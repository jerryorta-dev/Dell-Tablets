/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/31/13
 * Time: 11:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.scrubbers.lib {
import com.dell.controls.Scrubber_C_Factory;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.scrubbers.mvc.control.IScrubberController;
import com.dell.controls.components.scrubbers.mvc.control.ScrubberController;
import com.dell.controls.components.scrubbers.mvc.model.ScrubberModel;
import com.dell.controls.components.scrubbers.mvc.view.ScrubberCompositeView;
import com.dell.controls.components.scrubbers.mvc.view.core.abstract.AbstractScrubberComponentView;
import com.dell.controls.components.scrubbers.scrubberUI.abstract.AbstractSliderUI;
import com.dell.core.Global;
import com.dell.events.UIEvent;
import com.greensock.TweenLite;
import com.greensock.easing.Strong;

import flash.display.MovieClip;

import flash.events.Event;


/**
 * Includes the MVC Wrapper for scrubber functionality
 */
public class UI_MVC_ScrubberDefault extends AbstractUI {

    //MVC
    private var scrubberModel:Object;
    private var scrubberController:IScrubberController;
    private var scrubberCompositeView:AbstractScrubberComponentView;

    private var _ui_scrubber:AbstractUI;

    private var _movieClip:MovieClip;

    private var _scrubUpdateFunction:Function;
    private var _scrubCompleteFunction:Function;

    private var _omniture_track_metricID:String;

    private var _hasOminitureTracked:Boolean = false;
    private var _isResetting:Boolean = false;

    override public function commitProperties(event:Event = null):void {
        this.name = "UI_MVC_SCRUBBER_DEFAULT";
    }

    override public function draw():void {

        var modelVars:Object = { onUpdate:this.onUpdateHandler, onComplete:this.onCompleteHandler };
        this.scrubberModel = new ScrubberModel( null, modelVars);

        this.scrubberController = new ScrubberController(this.scrubberModel);
        this.scrubberCompositeView = new ScrubberCompositeView(this.scrubberModel, this.scrubberController);

        var _uiScrubberVars:Object = {onUpdate:this.scrubberController.updateHandler , onComplete:this.scrubberController.completeHandler };
        _ui_scrubber = new Scrubber_C_Factory().add(Scrubber_C_Factory.UI_SCRUBBER_CONTROL, this, 0, 0, _uiScrubberVars);

        this.scrubberController.rangeHandler(_ui_scrubber.bounds);
        this.scrubberCompositeView.add(_ui_scrubber);

    }

    override public function initialize():void {
        this.activateComposite();
    }

    override public function activateComposite():Boolean {

//        this.scrubberModel.addEventListener(UIEvent.SCRUBBING, this.onUpdateHandler, false, 0, true);
//        this.scrubberModel.addEventListener(UIEvent.SCRUB_COMPLETE, this.onCompleteHandler, false, 0, true);

//        _ui_scrubber.addEventListener(UIEvent.UPDATE_CONTROLLER, this.scrubberController.updateHandler, false, 0, true);
//        _ui_scrubber.addEventListener(UIEvent.COMPLETE, this.scrubberController.completeHandler, false, 0, true);


        super.activateComposite();
        return true;
    }

    override public function deactivateComposite():Boolean {

     /*   this.scrubberModel.removeEventListener(UIEvent.SCRUBBING, this.changeHandler);
        this.scrubberModel.removeEventListener(UIEvent.SCRUB_COMPLETE, this.onCompleteHandler);

        _ui_scrubber.removeEventListener(UIEvent.UPDATE_CONTROLLER, this.scrubberController.updateHandler);
        _ui_scrubber.removeEventListener(UIEvent.COMPLETE, this.scrubberController.completeHandler);
*/

        super.deactivateComposite();
        return true;
    }

    override public function disposeComposite():Boolean {

        scrubberModel = null;
        scrubberController = null;
        scrubberCompositeView = null;

        super.disposeComposite();
        return true;
    }


    /**
     * <p>Add event listener to this class when the entire mvc updates it's state.</p>
     *
     * <p>For example:</br>
     *    var _scrubber:ScrubberDefault = new ScrubberDefault().</br>
     *    mvcObject.addEventListener( UIEvent.CHANGE, doSomething );</p>
     *
     * @param data
     */
    private function onUpdateHandler( value:Number):void {

        if ( !_hasOminitureTracked  && Global.p.OMNITURE_TRACK_SCRUBBER_ONCE && (this._omniture_track_metricID != null && !_isResetting )) {
            _hasOminitureTracked = true;

            Global.trackMetrics("slider", this._omniture_track_metricID + "_Slider" );
        }

//        dispatchEvent(new UIEvent(event.type, event.data));
        if ( _movieClip != null ) {
//            _movieClip.gotoAndStop( value );
            TweenLite.killTweensOf( _movieClip );
            TweenLite.to(_movieClip, 0, {frame: value, ease:Strong.easeOut});
        }

        if (_scrubUpdateFunction != null) {
            _scrubUpdateFunction.call( null, value );
        }

    }

    private function onCompleteHandler( value:Number ):void {
//        this._dispatcher.dispatchUIEvent( event.type, event.data );
//        dispatchEvent(new UIEvent(event.type, event.data));

        if ( _movieClip != null ) {
//            _movieClip.gotoAndStop( value );
            TweenLite.killTweensOf( _movieClip );
            TweenLite.to(_movieClip, 0, {frame: value, ease:Strong.easeOut});
        }

        if (_scrubCompleteFunction != null) {
            _scrubCompleteFunction.call( null, value );
        }

        _isResetting = false;
    }

    public function reset():void {
        _isResetting = true;
        ( _ui_scrubber as AbstractSliderUI).reset();
    }

    public function to( value:Number ):void {
        ( _ui_scrubber as AbstractSliderUI).to( value );
    }


    public function get movieClip():MovieClip {
        return _movieClip;
    }

    public function set movieClip(value:MovieClip):void {
        _movieClip = value;
    }

    public function get scrubUpdateFunction():Function {
        return _scrubUpdateFunction;
    }


    public function set scrubUpdateFunction(value:Function):void {

        _scrubUpdateFunction = value;
    }

    public function get scrubCompleteFunction():Function {
        return _scrubCompleteFunction;
    }

    public function set scrubCompleteFunction(value:Function):void {
        _scrubCompleteFunction = value;
    }

    public function get omniture_track_metricID():String {
        return _omniture_track_metricID;
    }

    public function set omniture_track_metricID(value:String):void {
        _omniture_track_metricID = value;
    }
}
}
