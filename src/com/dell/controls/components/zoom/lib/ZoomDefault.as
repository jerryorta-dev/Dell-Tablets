package com.dell.controls.components.zoom.lib {
import com.dell.controls.Button_C_Factory;
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.controls.components.lists.mvc.view.ListCompositeONOFFView;
import com.dell.controls.components.lists.mvc.view.core.AbstractListCompositeView;
import com.dell.controls.components.zoom.mvc.control.ZoomNoLimitController;
import com.dell.controls.components.zoom.mvc.model.IZoomDefaultModel;
import com.dell.controls.components.zoom.mvc.model.ZoomDefaultModel;
import com.dell.core.Global;
import com.dell.events.UIEvent;

import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Zoom In or Zoom Out
 */
public class ZoomDefault extends AbstractUI implements IUI {

    private const INITIAL_ON_STATE_BUTTON_NUMBER:int = 0;

    private var _button1View:AbstractButton;
    private var _button2View:AbstractButton;

    private var buttons:Vector.<AbstractButton>;

    private var zoomModel:IZoomDefaultModel;
    private var zoomController:ZoomNoLimitController;
    private var zoomCompositeView:AbstractListCompositeView;

    override public function commitProperties(event:Event = null):void {

    }

    override public function draw():void {

        zoomModel = new ZoomDefaultModel();
        zoomModel.zoomValue = .36401;
        this.zoomModel.addEventListener(UIEvent.ZOOMIMG, this.changeHandler, false, 0, true);
        zoomController = new ZoomNoLimitController((zoomModel as IZoomDefaultModel), .36401, 1, 1);
        zoomCompositeView = new ListCompositeONOFFView(zoomModel, zoomController);

        var btnFactory:AbstractButtonFactory = new Button_C_Factory();
        var xPos:Vector.<int> = new <int>[0, 35];

        _button1View = btnFactory.add("ZoomIn", Button_C_Factory.ZOOM_IN_DEFAULT, this, xPos[0], 0);
        _button2View = btnFactory.add("ZoomOut", Button_C_Factory.ZOOM_OUT_DEFAULT, this, xPos[1], 0);

        buttons = new <AbstractButton>[_button1View, _button2View];

        var len:int = xPos.length;
        for (var i:int = 0; i < len; i++) {

            zoomCompositeView.add(buttons[i]);

        }
    }

    override public function initialize():void {
//        this.activateComposite();
    }


    override public function activateComposite():Boolean {
        if (!this._isActivated) {

            _button1View.buttonMode = true;
            _button1View.useHandCursor = true;
            _button1View.mouseChildren = false;
            _button1View.mouseEnabled = true;
            _button2View.buttonMode = true;
            _button2View.useHandCursor = true;
            _button2View.mouseChildren = false;
            _button2View.mouseEnabled = true;

            //TODO add control handler for Mouse Event
            _button1View.addEventListener(MouseEvent.MOUSE_DOWN, this.zoomInHandler);
            _button1View.addEventListener(MouseEvent.MOUSE_UP, this.zoomComplete);
            _button1View.addEventListener(MouseEvent.ROLL_OVER, this.zoomHover);
            _button1View.addEventListener(MouseEvent.ROLL_OUT, this.zoomRollOut);

            _button2View.addEventListener(MouseEvent.MOUSE_DOWN, this.zoomOutHandler);
            _button2View.addEventListener(MouseEvent.MOUSE_UP, this.zoomComplete);
            _button2View.addEventListener(MouseEvent.ROLL_OVER, this.zoomHover);
            _button2View.addEventListener(MouseEvent.ROLL_OUT, this.zoomRollOut);

            zoomModel.addEventListener(UIEvent.ROLL_OVER, zoomCompositeView.setOverState);
            zoomModel.addEventListener(UIEvent.ROLL_OUT, zoomCompositeView.setOffState);

        }


        return true;
    }


    override public function deactivateComposite():Boolean {

        if (this._isActivated) {
            _button1View.buttonMode = false;
            _button1View.useHandCursor = false;
            _button1View.mouseChildren = false;
            _button1View.mouseEnabled = false;
            _button2View.buttonMode = false;
            _button2View.useHandCursor = false;
            _button2View.mouseChildren = false;
            _button2View.mouseEnabled = false;

            //TODO add control handler for Mouse Event
            _button1View.removeEventListener(MouseEvent.MOUSE_DOWN, this.zoomInHandler);
            _button1View.removeEventListener(MouseEvent.MOUSE_UP, this.zoomComplete);
            _button1View.removeEventListener(MouseEvent.ROLL_OVER, this.zoomHover);
            _button1View.removeEventListener(MouseEvent.ROLL_OUT, this.zoomRollOut);

            _button2View.removeEventListener(MouseEvent.MOUSE_DOWN, this.zoomOutHandler);
            _button2View.removeEventListener(MouseEvent.MOUSE_UP, this.zoomComplete);
            _button2View.removeEventListener(MouseEvent.ROLL_OVER, this.zoomHover);
            _button2View.removeEventListener(MouseEvent.ROLL_OUT, this.zoomRollOut);

            zoomModel.removeEventListener(UIEvent.ROLL_OVER, zoomCompositeView.setOverState);
            zoomModel.removeEventListener(UIEvent.ROLL_OUT, zoomCompositeView.setOffState);
        }
        return true;
    }

    private const ZOOM_OUT:String = "zoomOut";
    private const ZOOM_IN:String = "zoomIn";
    private var zoomDirection:String;

    private function changeHandler(event:UIEvent):void {
        dispatchEvent(new UIEvent(UIEvent.ZOOMIMG, event.data));
    }

    private function zoomInHandler(event:MouseEvent):void {


        this.zoomDirection = this.ZOOM_IN;
        this.addEventListener(Event.ENTER_FRAME, this.zoomInEnterFrame, false, 0, true);

    }

    private function zoomOutHandler(event:MouseEvent):void {



        this.zoomDirection = this.ZOOM_OUT;
        this.addEventListener(Event.ENTER_FRAME, this.zoomOutEnterFrame, false, 0, true);

    }

    private function zoomComplete(event:MouseEvent):void {
        if (this.zoomDirection == this.ZOOM_IN) {
            this.removeEventListener(Event.ENTER_FRAME, this.zoomInEnterFrame);
        }

        if (this.zoomDirection == this.ZOOM_OUT) {
            this.removeEventListener(Event.ENTER_FRAME, this.zoomOutEnterFrame);
        }

        dispatchEvent(new UIEvent(UIEvent.ZOOM_COMPLETE, this.zoomModel.zoomValue));

    }

    private function zoomHover(event:MouseEvent):void {
        dispatchEvent(new UIEvent(UIEvent.ZOOM_HOVER, this.zoomModel.zoomValue));
    }

    private function zoomRollOut(event:MouseEvent):void {
        dispatchEvent(new UIEvent(UIEvent.ZOOM_ROOL_OUT, this.zoomModel.zoomValue));
    }

    private function zoomInEnterFrame(event:Event):void {
        this.zoomController.onZoomInHandler();
    }

    private function zoomOutEnterFrame(event:Event):void {
        this.zoomController.onZoomOutHandler();
    }



}
}