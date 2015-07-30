/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/15/13
 * Time: 11:17 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.image {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.core.Global;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Linear;
import com.greensock.easing.Strong;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.greensock.plugins.FramePlugin;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TransformAroundPointPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * <p>Displays a lowres and highres image.</p>
 *
 * <p>vars:</p>
 * <ul>
 *     <li>vars.width = width of image</li>
 *     <li>vars.height = height of image</li>
 *     <li>vars.registration = defaults to ImageItem.TOP_LEFT_REGISTRATION</li>
 * </ul>
 *
 * <p>data:</p>
 * <ul>
 *     <li>data.lowResImage = lowRes display Object</li>
 *     <li>data.hiResImage = hiRes display Object</li>
 *     <li>data.zoomMin = min scale to zoom image, usually the start scale</li>
 *     <li>data.zoomMax = max scale to zoom image.</li>
 * </ul>
 */
public class SWF360Item extends AbstractUI {

    //VARS
    private var _width:Number;
    private var _height:Number;

    //DATA
    private var _loResSWF:MovieClip;
    private var _zoomImage:MovieClip;
    private var _zoomMin:Number;
    private var _zoomMax:Number;


    private var _loResSWF360Loader:SWFLoader;
    private var _hiResSWF360Loader:SWFLoader;

    private var _callout:Sprite;
    private var _calloutIsActive:Boolean = true;

    private var hiResX:Number;
    private var hiResY:Number;

    //Helpers
    private var _mask:Sprite;

    private var _displayObjects:Vector.<Sprite>;

    private var _registration:String;
    public static const CENTER_REGISTRATION:String = "centerRegistration";
    public static const TOP_LEFT_REGISTRATION:String = "topLeftRegistration";


    private var _frame:int = 0;


    public function SWF360Item(vars:Object = null, data:Object = null) {

        super(vars, data);

    }

    override public function commitProperties(event:Event = null):void {

        TweenPlugin.activate([TransformAroundPointPlugin, FramePlugin]);

        if (this._vars.loResSWF360Loader != null) {
            this._loResSWF360Loader = LoaderMax.getLoader(this._vars.loResSWF360Loader + "0");
        }

        if (this._vars.hiResSWF360Loader != null) {
            this._hiResSWF360Loader = LoaderMax.getLoader(this._vars.hiResSWF360Loader + "0");
        }

        this._width = this._vars.width;
        this._height = this._vars.height;

        this.zoomValue = this._zoomMin = this._hiResSWF360Loader.vars.zoomMin;

        this._zoomMax = 1;

        _displayObjects = new Vector.<Sprite>();
        this._bounds = new Rectangle(0, 0, this._width, this._height);


    }

    override public function draw():void {

        this._loResSWF = this._loResSWF360Loader.rawContent as MovieClip;

        this._loResSWF.x = this._loResSWF360Loader.vars.x;
        this._loResSWF.y = this._loResSWF360Loader.vars.y;

        this.addChild(this._loResSWF);

        _displayObjects.push(this._loResSWF);

        TweenLite.to(this._loResSWF, 0, {frame: this._frame});

        this._mask = this.createMask();
        this._mask.x = this._mask.y = 0;
        this.addChild(this._mask);
        _displayObjects.push(this._mask);

        this.mask = this._mask;

        this._callout = new Sprite();
        this._callout.x = this._callout.y = 0;
        this.addChild(this._callout);

    }


    override public function initialize():void {
        this.setRegistration();
    }


    private function createMask():Sprite {

        var sp:Sprite = new Sprite;
        sp.graphics.clear();
        sp.graphics.beginFill(0xFFFFFF, 1);
        sp.graphics.drawRect(0, 0, this._width, this._height);
        sp.graphics.endFill();

        return sp;
    }

    public function onScrubUpdate(value:Number):void {

        this._frame = value;

        if (this._zoomImage != null && this._zoomImage.visible) {
//            this._zoomImage.gotoAndStop( value );
//            TweenLite.to(this._zoomImage,.05, {frame:value});
            TweenLite.killTweensOf(_zoomImage);
            TweenLite.to(_zoomImage, 0, {frame: value, ease: Strong.easeOut});
        } else {
            TweenLite.killTweensOf(_loResSWF);
            TweenLite.to(_loResSWF, 0, {frame: value, ease: Strong.easeOut});
        }
//        TweenLite.to(this._lowResImage,.05, {frame:value});
//        this._lowResImage.gotoAndStop( value );


    }

    public function onScrubComplete(value:Number):void {
//        Global.debug(this, value);
//        this._frame = value;
//        if (this._zoomImage != null) {
//            this._zoomImage.gotoAndStop(value);
//        }
//        this._loResSWF.gotoAndStop(value);
    }

    private var _hiResContainer:Sprite;

    public function setHiResSwf():void {

        if (this._hiResSWF360Loader == null) {
            return;
        }
        _hiResContainer = new Sprite();
        _hiResContainer.x = 0;
        _hiResContainer.y = 0;
        this.addChild(_hiResContainer);

        this._zoomImage = this._hiResSWF360Loader.rawContent as MovieClip;

        this.zoomValue = this._zoomMin = this._zoomImage.scaleX;

        this._hiResContainer.scaleX = _hiResContainer.scaleY = this._zoomImage.scaleX;

        //Expand the sprite to cover entire area
        var shape:Shape = new Shape();
        shape.graphics.beginFill(0xFFFFFF, 0);
        shape.graphics.drawRect(0, 0, this._width * ( 1 / this._zoomMin), this._height * ( 1 / this._zoomMin));
        shape.graphics.endFill();

        this._hiResContainer.addChild(shape);

        this._zoomImage.scaleX = this._zoomImage.scaleY = 1;
        this._zoomImage.x = this._hiResSWF360Loader.vars.x * ( 1 / this._zoomMin );
        this._zoomImage.y = this._hiResSWF360Loader.vars.y * ( 1 / this._zoomMin );

        this._hiResContainer.addChild(this._zoomImage);

        this._displayObjects.push(this._hiResContainer);

        _hiResContainer.visible = true;
        _loResSWF.visible = false;

        this.swapChildren(this._callout, this._hiResContainer);

    }

    public function get callout():Sprite {
        return _callout;
    }

    public function set callout(value:Sprite):void {
        _callout = value;
    }

    private function toggleCallout():void {

//        trace("scale check:::" + this._zoomImage.scaleX + " --> " + this._zoomMin);
        if (this._hiResContainer.scaleX > this._zoomMin && this._calloutIsActive) {
            this._calloutIsActive = false;
            TweenMax.to(this._callout, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
        }

        if (this._hiResContainer.scaleX <= (this._zoomMin + ZOOM_TOLERANCE) && !this._calloutIsActive) {
            this._calloutIsActive = true;
            TweenMax.to(this._callout, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
        }
    }


    private const ZOOM_TOLERANCE:Number = .01;
    private const MOVE_TOLERANCE:Number = 10;
    private function checkBounds():void {

        if (this._hiResContainer.x > this._bounds.x) {
            this._hiResContainer.x = this._bounds.x;
        }

        if (this._hiResContainer.y > this._bounds.y) {
            this._hiResContainer.y = this._bounds.y;
        }

        if ((this._hiResContainer.x + this._hiResContainer.width + MOVE_TOLERANCE) < this._bounds.width) {
            this._hiResContainer.x = this._bounds.width - this._hiResContainer.width; //should be negative
        }

        if ((this._hiResContainer.y + this._hiResContainer.height + MOVE_TOLERANCE) < this._bounds.height) {
            this._hiResContainer.y = this._bounds.height - this._hiResContainer.height; //should be negative
        }

        if (this._hiResContainer.scaleX <= (this._zoomMin + ZOOM_TOLERANCE) ) {
            this._hiResContainer.scaleX = this._hiResContainer.scaleY = this._zoomMin;
            this._hiResContainer.x = this._bounds.x;
            this._hiResContainer.y = this._bounds.y;
        }

        toggleCallout();
    }


    public function get zoomImage():MovieClip {
        return _zoomImage;
    }

    public function get loResSWF():MovieClip {
        return _loResSWF;
    }

    public function set loResSWF(value:MovieClip):void {
        _loResSWF = value as MovieClip;
    }


    private function setRegistration():void {
        var i:int;
        var len:int = this._displayObjects.length;

        if (this._registration == CENTER_REGISTRATION) {
            for (i = 0; i < len; i++) {
                this._displayObjects[i].x = -this._width;
                this._displayObjects[i].y = -this._height;
            }
        }
    }


    private var zoomValue:Number;
    private var responsiveness:Number = .025;

    public function onZoomUpdate(_direction:Number):void {

        if (enabled) {
            this.disableNavThrowProps();
        }

        if (_direction == 1) {
            zoomValue += (responsiveness * zoomValue);
        }

        if (_direction == -1) {
            zoomValue -= (responsiveness * zoomValue);
        }

        if (zoomValue < this._zoomMin) {
            zoomValue = this._zoomMin;
        }

        if (zoomValue > this._zoomMax) {
            zoomValue = this._zoomMax;
        }


        this.scaleImage(zoomValue);


    }


    private function scaleImage(zoomFactor:Number):void {

        TweenLite.to(this._hiResContainer, (0), {
            transformAroundPoint: {point: new Point(this._bounds.width / 2, this._bounds.height / 2), scaleX: zoomFactor, scaleY: zoomFactor},
            ease: Linear.easeNone, onUpdate: this.checkBounds, onComplete: this.checkBounds});

    }

    public function reset():void {

        if ( this._hiResContainer == null ) {
            return;
        }

        TweenLite.to(this._hiResContainer, (Global.t.TRANSITION), {
            transformAroundPoint: {point: new Point(this._bounds.width / 2, this._bounds.height / 2), scaleX: this._zoomMin, scaleY: this._zoomMin},
            ease: Linear.easeNone, onUpdate: this.checkBounds, onComplete: this.checkBounds});
    }


    public function onZoomComplete():void {
        this.toggleHiResLoRes();

    }

    private function toggleHiResLoRes():void {
        if (zoomValue != _zoomMin) {
            this.enableNavThrowProps();
        }
    }

    //Throw Props

    private var enabled:Boolean = false;

    public function disableNavThrowProps():void {
//        trace( "disable" );

        if (!enabled) {
            return;
        }

        enabled = false;
        ThrowPropsPlugin.untrack(this._hiResContainer, "x,y");
//        this._hiResContainer.stage.removeEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);
        this._hiResContainer.removeEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler);
    }

    public function enableNavThrowProps():void {
//        trace( "enable" );
        if (enabled) {
            return;
        }
        enabled = true;
        ThrowPropsPlugin.track(this._hiResContainer, "x,y");

        this._hiResContainer.addEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler, false, 0, true);
    }

    private function setUpThrowProps():void {

        enabled = true;
        this._hiResContainer.mouseEnabled = true;
        this._hiResContainer.mouseChildren = false;
        this._hiResContainer.useHandCursor = true;

        this.enableNavThrowProps();

    }


    private function throwPropsMouseDownHandler(event:MouseEvent):void {

        TweenLite.killTweensOf(this._hiResContainer);
        this._hiResContainer.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.throwPropsMouseMoveHandler);
//        this._hiResContainer.startDrag(false, new Rectangle(-99999, -99999, 99999999, 99999999));

        this._hiResContainer.startDrag(false, new Rectangle(
                Global.p.WIDTH - this._hiResContainer.width, //left bounds - negative value
                Global.p.HEIGHT - this._hiResContainer.height, // top bounds - negative value
                this._hiResContainer.width - Global.p.WIDTH, // right bounds
                this._hiResContainer.height - Global.p.HEIGHT)); // bottom bounds


        this._hiResContainer.stage.addEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);

    }

    private function throwPropsMouseMoveHandler(event:MouseEvent):void {

    }

    private function throwPropsMouseUpHandler(event:MouseEvent):void {
        this._hiResContainer.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.throwPropsMouseMoveHandler);
        this._hiResContainer.stopDrag();

//        var xOverlap:Number = Math.max(0, this._hiResContainer.width - this._bounds.width);
//        var yOverlap:Number = Math.max(0, this._hiResContainer.height - this._bounds.height);

        var xOverlap:Number = Math.abs(Global.p.WIDTH - this._hiResContainer.width);
        var yOverlap:Number = Math.abs(Global.p.HEIGHT - this._hiResContainer.height);


        ThrowPropsPlugin.to(this._hiResContainer, {ease: Strong.easeOut, onComplete: onThrowPropsComplete, throwProps: {x: {max: this._bounds.left, min: this._bounds.left - xOverlap, resistance: 500}, y: {max: this._bounds.top, min: this._bounds.top - yOverlap, resistance: 500}}}, 10, 0.25, 0);
    }

    private function onThrowPropsComplete():void {
        if (zoomValue == _zoomMin) {
            this._hiResContainer.stage.removeEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);
            disableNavThrowProps();
        }


    }


}
}
