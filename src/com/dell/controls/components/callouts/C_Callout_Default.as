/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/8/13
 * Time: 2:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.callouts {
import com.dell.controls.TextfieldFactory;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.data.CalloutVARS;
import com.dell.graphics.CommonElementsGraphicFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.shapes.CallOutGraphic;
import com.dell.graphics.data.CalloutGraphicVARS;

import flash.events.Event;
import flash.text.TextField;

public class C_Callout_Default extends AbstractUI {



    private var _calloutGraphic:CallOutGraphic;
    private var _textField:TextField;
    private var _copy:String;

    private var _padding:Number;
    private var _paddingTop:Number;
    private var _paddingRight:Number;
    private var _paddingBottom:Number;
    private var _paddingLeft:Number;

    private var _textFieldVars:Object;
    private var _calloutGraphicVars:CalloutGraphicVARS;

    private var _expandDirection:String;

    private var _width:Number;
    private var _height:Number;

    private var _minWidth:Number;
    private var _minHeight:Number;

    private var _registration:String;

    private var _maxLines:Number;



    public function C_Callout_Default(vars:Object = null, data = null) {

        super(vars, data);


        if (this._vars._isAbstractCalloutParams) {
            this._vars = this._vars.calloutVars.vars;

            /**
             * Because the vars passed in is an object with properties as various types
             * of vars
             */
            _textFieldVars = vars;
            _calloutGraphicVars = vars.calloutGraphicVars;
        }



    }

    override public function commitProperties(event:Event = null):void {

		
//        if (event){
//            removeEventListener(Event.ADDED_TO_STAGE, commitProperties);
//        }


		this._copy =  ( this._vars.text != null) ? this._vars.text : "DEFAULT TEXT";

		_padding = (this._vars.padding != null) ? this._vars.padding : 0;

        _paddingTop = (this._vars.paddingTop != null) ? this._vars.paddingTop : _padding;
        _paddingRight = (this._vars.paddingRight != null) ? this._vars.paddingRight : _padding;
        _paddingBottom = (this._vars.paddingBottom != null) ? this._vars.paddingBottom : _padding;
        _paddingLeft = (this._vars.paddingLeft != null) ? this._vars.paddingLeft : _padding;

        _expandDirection = (this._vars.expandDirection != null) ? this._vars.expandDirection : CalloutVARS.DIRECTION_DOWN;

        _width = this._vars.width;
        _height = this._vars.height;

        _minWidth = this._vars.minWidth;
        _minHeight = this._vars.minHeight;

        _registration = (this._vars.registration != null) ? this._vars.registration : CalloutVARS.REGISTER_BOTTOM_MIDDLE;

        _maxLines = (this._vars.textMaxLines != null ) ? this._vars.textMaxLines : -1;

        this.drawWidget();
    }

    public function drawWidget():void {
        _calloutGraphic = new CommonElementsGraphicFactory().add(CommonElementsGraphicFactory.CALLOUT_DEFAULT, this, 0, 0, _calloutGraphicVars) as CallOutGraphic;
        _textField = new TextfieldFactory().add(this._copy, TextfieldFactory.DEFAULT, this, 0, 0, _textFieldVars);

        _calloutGraphic.addEventListener(Event.ADDED_TO_STAGE, checkCalloutOnStage, false, 0, true);
        _textField.addEventListener(Event.ADDED_TO_STAGE, checkTextFieldOnStage, false, 0, true);
    }


    private var textFieldAddedToStage:Boolean = false;
    private var calloutGraphicAddedToStage:Boolean = false;
    private function checkTextFieldOnStage(event:Event = null):void {
        textFieldAddedToStage = true;
        if (textFieldAddedToStage && calloutGraphicAddedToStage) {
            setMaxLines();
            removeListeners();
        }
    }

    private function checkCalloutOnStage(event:Event = null):void {
        calloutGraphicAddedToStage = true;
        if (textFieldAddedToStage && calloutGraphicAddedToStage) {
            setMaxLines();
            removeListeners();
        }
    }

    private function removeListeners():void {
        _calloutGraphic.removeEventListener(Event.ADDED_TO_STAGE, checkCalloutOnStage);
        _textField.removeEventListener(Event.ADDED_TO_STAGE, checkTextFieldOnStage);
    }

    private function setMaxLines():void {

        if (_maxLines != -1) {
            while( _textField.numLines > _maxLines) {
                _textField.width = _textField.width + 1;
            }
        }


        layout();
    }

    private function layout():void {

        if (_maxLines == -1) {
            _textField.width = this._width - _paddingLeft - _paddingRight - 2;

        }

        _calloutGraphic.rectWidth = _textField.width + _paddingLeft + _paddingRight;

        _calloutGraphic.rectHeight = _textField.height + _paddingTop + _paddingBottom;

        if (!isNaN(this.minHeight) && _calloutGraphic.rectHeight < this.minHeight) {
            _calloutGraphic.rectHeight = this.minHeight;
        }

        if (!isNaN(this.minWidth) && _calloutGraphic.rectWidth < this.minWidth) {
            _calloutGraphic.rectWidth = this.minWidth;
        }



        if (_expandDirection == CalloutVARS.EXPAND_HORIZONTALLY) {

        }


        if (_registration == CalloutVARS.REGISTER_BOTTOM_MIDDLE) {
            _calloutGraphic.x = -( _calloutGraphic.width / 2 );
            _calloutGraphic.y = -_calloutGraphic.height;

        }

        if (_registration == CalloutVARS.REGISTER_TOP_MIDDLE ) {
            _calloutGraphic.x = -( _calloutGraphic.width / 2 );
            _calloutGraphic.y = _calloutGraphic.arrowHeight;
        }

        _textField.x = _calloutGraphic.x + _paddingLeft;
        _textField.y = _calloutGraphic.y + _paddingTop;



    }


    override public function draw():void {


    }


    // ABSTRACT Method (must be overridden in a subclass)
    override public function initialize():void {

    }

    override public function get width():Number {
        return _width;
    }

    override public function set width(value:Number):void {
        _width = value;
    }


    override public function get height():Number {
        return _height;
    }

    override public function set height(value:Number):void {
        _height = value;
    }


    public function get minWidth():Number {
        return _minWidth;
    }

    public function set minWidth(value:Number):void {
        _minWidth = value;
    }

    public function get minHeight():Number {
        return _minHeight;
    }

    public function set minHeight(value:Number):void {
        _minHeight = value;
    }



    public function set text( _text:String):void {
        _textField.text = _text;
        this.layout();
    }

    public function get text():String {
        return _textField.text;
    }
}
}
