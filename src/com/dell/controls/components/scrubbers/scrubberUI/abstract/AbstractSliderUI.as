package com.dell.controls.components.scrubbers.scrubberUI.abstract {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.ISlider;
import com.dell.events.UIEvent;
import com.dell.events.UIEventDispatcher;
import com.dell.graphics.RectangleFactory;
import com.dell.graphics.ScrubberButtonGraphicFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.AbstractGraphicFactory;
import com.dell.graphics.data.RectangleVARS;
import com.greensock.TweenLite;
import com.greensock.easing.Strong;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.utils.getTimer;

/**
 * <p>This provides the user interface functionality of the scrubber. The ease while dragging, momentum after throwing the scrub head and click track.</p>
 * <p>Subclass this class to add or change functionality. You may use ScrubberDefault as an example to create a new scrubber.</p>
 */
public class AbstractSliderUI extends AbstractUI implements ISlider {

    private var _width:Number = 240;


    /**
     * After the moust is release when sliding, the amount
     * of resistance to stop the scrubber as it is
     * throwen.
     */
    private var _resistance:Number = 200;

    /**
     * Maximum amount of time to allow the scrubber to
     * tween after it's thrown.
     */
    private var _max_duration:Number = .6;

    /**
     * Minimum amount of time to allow the scrubber to
     * tween after it's thrown.
     */
    private var _min_duration:Number = .25;

    /**
     * Allow the scrubber go past the left or right bounds of the slider.
     * Leave a 0 to not allow. The value is designed for lists in mobile
     * devices, which we don't use for a slider.
     */
    private var _overshoot_tolerance:Number = 0;

    /**
     * While the mouse is down, the responsiveness of the scrubber as you drag it.
     */
    private var _ease_while_sliding:Number = .5;

    /**
     * The time it takes for scrubber to tween to mouse location when clicking on the track.
     */
    private var _time_click_track:Number = .3;

    private var _onStart:Function;

    protected var trackGraphic:AbstractGraphic;
    protected var progressGraphic:AbstractGraphic;
    protected var scrubberGraphic:AbstractGraphic;

    private var _value:Number;
    private var _onUpdate:Function;
    private var _onComplete:Function;

    private var _scrubberInitialPosition:Number;


    //some variables for tracking the velocity of mc
    protected var t1:uint, t2:uint, x1:Number, x2:Number;

    public function AbstractSliderUI( vars:Object = null, data:Object = null) {
        super( vars, data);
		this._vars = ( vars != null ) ? vars : {};

    }

	
	override public function commitProperties(event:Event=null):void {
		this.name = "AbstractSliderUI";
        this._onUpdate = ( this._vars.onUpdate != null) ? this._vars.onUpdate : null;
        this._onComplete = ( this._vars.onComplete != null ) ? this._vars.onComplete : null;
	}

    override public function draw():void {


        const rectangleFactory:AbstractGraphicFactory = new RectangleFactory();

        const trackGraphicVARS:RectangleVARS = new RectangleVARS().width( 240).height( 10).fillColor( 0xebebeb ).radius( 3.5 );
        trackGraphic = rectangleFactory.add(RectangleFactory.RECTANGLE_WITH_VARS, this, 0, -( trackGraphicVARS.vars.height / 2), trackGraphicVARS);
        trackGraphic.width = this._width;

        const progressGraphicVARS:RectangleVARS = new RectangleVARS( trackGraphicVARS ).fillColor( 0x0085c3 );
        progressGraphic = rectangleFactory.add(RectangleFactory.RECTANGLE_WITH_VARS, this, 0, -( trackGraphicVARS.vars.height / 2), progressGraphicVARS);
        progressGraphic.width = this._width;

        scrubberGraphic = new ScrubberButtonGraphicFactory().add(ScrubberButtonGraphicFactory.SCRUBBER_GRAPHIC_CENTER_REG, this, 0, 0);
        scrubberGraphic.x = scrubberGraphic.width / 2;
        this._scrubberInitialPosition = scrubberGraphic.x;

        //Allow to click through and hit the trackGraphic
        progressGraphic.mouseEnabled = false;



        //Ractangle( Center of scrubber in it's initial x position, scrubberGraphic y pos, track width minus scrubber x, 0)
        _bounds = new Rectangle(0, scrubberGraphic.y, trackGraphic.width - (scrubberGraphic.width), 0);
        _bounds.x = scrubberGraphic.width / 2;

        this.updateProgressBar();

        
    }



    override public function initialize():void {
        TweenPlugin.activate([ThrowPropsPlugin]);
		this.activateComposite();
    }



    private function scrubberMouseDownHandler(event:MouseEvent):void {
        this.callOnStart();

        TweenLite.killTweensOf(scrubberGraphic);
        x1 = x2 = scrubberGraphic.x;
        t1 = t2 = getTimer();

        scrubberGraphic.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        scrubberGraphic.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }


    private function trackMouseDownHandler(event:MouseEvent):void {
		mouseClamped = this.mouseX;
		if (mouseClamped > _bounds.right) {
			mouseClamped = _bounds.right;
		}
		else if (mouseClamped < _bounds.left) {
			mouseClamped = _bounds.left;
		}

        TweenLite.to(scrubberGraphic, this._time_click_track, {x: mouseClamped, ease: Strong.easeOut, onUpdate: callOnUpdate, onComplete: callOnComplete});
        TweenLite.to(progressGraphic, this._time_click_track, {width: mouseClamped, ease: Strong.easeOut});
    }

    public function to( value:Number ):void {
        mouseClamped = value;
        if (mouseClamped > _bounds.right) {
            mouseClamped = _bounds.right;
        }
        else if (mouseClamped < _bounds.left) {
            mouseClamped = _bounds.left;
        }

        TweenLite.to(scrubberGraphic, this._time_click_track, {x: mouseClamped, ease: Strong.easeOut, onUpdate: callOnUpdate, onComplete: callOnComplete});
        TweenLite.to(progressGraphic, this._time_click_track, {width: mouseClamped, ease: Strong.easeOut});
    }

    public function reset():void {
        this.to( 0 );
    }

    /**
     * Restrict the mouseX valude to the scrubber range.
     */
    private var mouseClamped:Number;

    /**
     *
     * @param event
     *
     */
    private function enterFrameHandler(event:Event):void {
        //track velocity using the last 2 frames for more accuracy
        mouseClamped = this.mouseX;
        if (mouseClamped > _bounds.right) {
            mouseClamped = _bounds.right;
        }
        else if (mouseClamped < _bounds.left) {
            mouseClamped = _bounds.left;
        }

//        scrubberGraphic.x += this._ease_while_sliding * ( mouseClamped - scrubberGraphic.x);
        scrubberGraphic.x += ( mouseClamped - scrubberGraphic.x);
//        scrubberGraphic.x += ( mouseClamped - scrubberGraphic.x);

        x2 = x1;
        t2 = t1;
        x1 = scrubberGraphic.x;
        t1 = getTimer();
        this.updateProgressBar();
    }


    private function mouseUpHandler(event:MouseEvent):void {
        TweenLite.killTweensOf(scrubberGraphic);
        scrubberGraphic.stopDrag();
        scrubberGraphic.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        scrubberGraphic.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        var time:Number = (getTimer() - t2) / 1000;
        var xVelocity:Number = (scrubberGraphic.x - x2) / time;
        var yOverlap:Number = Math.max(0, scrubberGraphic.width - _bounds.width);

        ThrowPropsPlugin.to(scrubberGraphic, {throwProps: {
            x: {velocity: xVelocity, max: _bounds.right, min: _bounds.left, resistance: this._resistance}
        }, onUpdate: updateProgressBar, onComplete: callOnComplete, ease: Strong.easeOut
        }, this._max_duration, this._min_duration, this._overshoot_tolerance);
    }
	
	override public function activateComposite():Boolean {

        scrubberGraphic.addEventListener(MouseEvent.MOUSE_DOWN, scrubberMouseDownHandler);
        trackGraphic.addEventListener(MouseEvent.MOUSE_DOWN, trackMouseDownHandler);

		super.activateComposite();
		return true;
	}
	
	override public function deactivateComposite():Boolean {

        scrubberGraphic.removeEventListener(MouseEvent.MOUSE_DOWN, scrubberMouseDownHandler);
        trackGraphic.removeEventListener(MouseEvent.MOUSE_DOWN, trackMouseDownHandler);

		super.deactivateComposite();
		return true;
	}
	

    override public function disposeComposite():Boolean {
        removeChild(trackGraphic);
        removeChild(progressGraphic);
        removeChild(scrubberGraphic);
        trackGraphic = null;
        progressGraphic = null;
        scrubberGraphic = null;

        mouseClamped = undefined;
        _bounds = null;
		super.disposeComposite();
		return true;
    }



    private function updateProgressBar():void {

        progressGraphic.width = scrubberGraphic.x ;
        this.callOnUpdate();
    }

    private function normalizeScrubberPosValue():Number {
        return scrubberGraphic.x - ( scrubberGraphic.width / 2 );
//        return scrubberGraphic.x ;
    }


    private function callOnComplete():void {
//        eventDispatcher( new UIEvent( UIEvent.COMPLETE, this.normalizeScrubberPosValue() ));
        if ( this._onComplete != null ) {
            this._onComplete.call( null, this.normalizeScrubberPosValue() );
        }
    }

    private function callOnStart():void {

    }

    private function callOnUpdate():void {
//        eventDispatcher( new UIEvent( UIEvent.UPDATE_CONTROLLER, this.normalizeScrubberPosValue() ));
        if (this._onUpdate != null) {
            this._onUpdate.call( null, this.normalizeScrubberPosValue() );
        }
    }



    // GETTERS AND SETTERS


    /**
     * Called when you click on the scrubber.
     */
    public function get onStart():Function {
        return _onStart;
    }

    /**
     * @private
     */
    public function set onStart(value:Function):void {
        _onStart = value;
    }

    override public function get width():Number {
        return _width;
    }

    override public function set width(value:Number):void {
        _width = value;
    }

    public function get resistance():Number {
        return _resistance;
    }

    public function set resistance(value:Number):void {
        _resistance = value;
    }

    public function get max_duration():Number {
        return _max_duration;
    }

    public function set max_duration(value:Number):void {
        _max_duration = value;
    }

    public function get min_duration():Number {
        return _min_duration;
    }

    public function set min_duration(value:Number):void {
        _min_duration = value;
    }

    public function get overshoot_tolerance():Number {
        return _overshoot_tolerance;
    }

    public function set overshoot_tolerance(value:Number):void {
        _overshoot_tolerance = value;
    }

    public function get ease_while_sliding():Number {
        return _ease_while_sliding;
    }

    public function set ease_while_sliding(value:Number):void {
        _ease_while_sliding = value;
    }

    public function get time_click_track():Number {
        return _time_click_track;
    }

    public function set time_click_track(value:Number):void {
        _time_click_track = value;
    }


    public function get value():Number {
        return _value;
    }

    public function set value(value:Number):void {
        _value = value;
    }

    public function get onUpdate():Function {
        return _onUpdate;
    }

    public function set onUpdate(value:Function):void {
        _onUpdate = value;
    }

    public function get onComplete():Function {
        return _onComplete;
    }

    public function set onComplete(value:Function):void {
        _onComplete = value;
    }
}
}