/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/8/13
 * Time: 2:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.callouts {
import com.dell.controls.TextfieldFactory;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.data.CalloutVARS;
import com.dell.graphics.CommonElementsGraphicFactory;
import com.dell.graphics.components.shapes.CallOutGraphic;
import com.dell.graphics.data.CalloutGraphicVARS;

import flash.events.Event;
import flash.text.TextField;

public class C_Callout_Rectangle_Header_Copy extends AbstractUI {

    private const TEXTFIELD_GAP:Number = 0;

    private var _textField_HeaderVars:Object;
    private var _textField_CopyVars:Object;
    private var _calloutGraphicVars:CalloutGraphicVARS;
    private var _callOutVars:Object;

    private var _calloutGraphic:CallOutGraphic;
    private var _textField_Copy:TextField;
    private var _textField_Header:TextField;
//    private var _copy:String;
//    private var _header:String;

    private var _padding:Number;
    private var _paddingTop:Number;
    private var _paddingRight:Number;
    private var _paddingBottom:Number;
    private var _paddingLeft:Number;



    private var _expandDirection:String;

    private var _width:Number;
    private var _height:Number;

    private var _minWidth:Number;
    private var _minHeight:Number;

    private var _registration:String;

    private var _maxLines:Number;



    public function C_Callout_Rectangle_Header_Copy(vars:Object = null, data = null) {

        super(vars, data);

        this.name = "callout";

        this._callOutVars = this._vars.callOutVars.vars;
        this._textField_HeaderVars = this._vars.textFieldHeaderParams;
        this._textField_CopyVars = this._vars.textFieldCopyParams;
        this._calloutGraphicVars = this._vars.calloutGraphicVars;

//        if (this._functionalVars.calloutFunctionVars._isAbstractCalloutParams) {
//            this._functionalVars = this._functionalVars.calloutFunctionVars.vars;
//            _textField_HeaderVars = vars;
//            _calloutGraphicVars = vars.calloutGraphicVars;
//        }

    }

    override public function commitProperties(event:Event = null):void {

		
//        if (event){
//            removeEventListener(Event.ADDED_TO_STAGE, commitProperties);
//        }


//		this._copy =  ( this._data.copy != null) ? this._data.copy : "Copy";
//        this._header = ( this._data.header != null) ? this._data.header: "Header";

		_padding = (this._callOutVars.padding != null) ? this._callOutVars.padding : 0;

        _paddingTop = (this._callOutVars.paddingTop != null) ? this._callOutVars.paddingTop : _padding;
        _paddingRight = (this._callOutVars.paddingRight != null) ? this._callOutVars.paddingRight : _padding;
        _paddingBottom = (this._callOutVars.paddingBottom != null) ? this._callOutVars.paddingBottom : _padding;
        _paddingLeft = (this._callOutVars.paddingLeft != null) ? this._callOutVars.paddingLeft : _padding;

        _expandDirection = (this._callOutVars.expandDirection != null) ? this._callOutVars.expandDirection : CalloutVARS.DIRECTION_DOWN;

        _width = this._callOutVars.width;
        _height = this._callOutVars.height;

        _minWidth = this._callOutVars.minWidth;
        _minHeight = this._callOutVars.minHeight;

        _registration = (this._callOutVars.registration != null) ? this._callOutVars.registration : CalloutVARS.REGISTER_BOTTOM_MIDDLE;

        _maxLines = (this._callOutVars.textMaxLines != null ) ? this._callOutVars.textMaxLines : -1;

        this.drawWidget();
    }

    public function drawWidget():void {
        _calloutGraphic = new CommonElementsGraphicFactory().add(CommonElementsGraphicFactory.CALLOUT_DEFAULT, this, 0, 0, _calloutGraphicVars) as CallOutGraphic;
        _textField_Header = new TextfieldFactory().add(this._textField_HeaderVars.text, TextfieldFactory.DEFAULT, this, 0, 0, _textField_HeaderVars);
        _textField_Copy = new TextfieldFactory().add(this._textField_CopyVars.text, TextfieldFactory.DEFAULT, this, 0, 0, _textField_CopyVars);

        _calloutGraphic.addEventListener(Event.ADDED_TO_STAGE, checkCopyOnState, false, 0, true);
        _textField_Header.addEventListener(Event.ADDED_TO_STAGE, checkHeaderOnStaqte, false, 0, true);
        _textField_Copy.addEventListener(Event.ADDED_TO_STAGE, checkCalloutOnStage, false, 0, true);
    }


    private var headerAddedtoStage:Boolean = false;
    private var copyAddedToStage:Boolean = false;
    private var calloutGraphicAddedToStage:Boolean = false;

    private function checkHeaderOnStaqte(event:Event = null):void {
        headerAddedtoStage = true;
        if (headerAddedtoStage && calloutGraphicAddedToStage && copyAddedToStage) {
            setMaxLines();
            removeListeners();
        }
    }

    private function checkCopyOnState(event:Event = null):void {
        copyAddedToStage = true;
        if (headerAddedtoStage && calloutGraphicAddedToStage && copyAddedToStage) {
            setMaxLines();
            removeListeners();
        }
    }

    private function checkCalloutOnStage(event:Event = null):void {
        calloutGraphicAddedToStage = true;
        if (headerAddedtoStage && calloutGraphicAddedToStage && copyAddedToStage) {
            setMaxLines();
            removeListeners();
        }
    }

    private function removeListeners():void {
        _calloutGraphic.removeEventListener(Event.ADDED_TO_STAGE, checkCopyOnState);
        _textField_Copy.removeEventListener(Event.ADDED_TO_STAGE, checkHeaderOnStaqte);
        _textField_Header.removeEventListener(Event.ADDED_TO_STAGE, checkHeaderOnStaqte);
    }

    private function setMaxLines():void {

        if (_maxLines != -1) {
            while( _textField_Copy.numLines > _maxLines) {
                _textField_Copy.width = _textField_Copy.width + 1;
            }
        }


        layout();
    }

    private function layout():void {

        if (_maxLines == -1) {
            _textField_Header.width = _textField_Copy.width = this._width - _paddingLeft - _paddingRight - 2;
        }



        var _maxWidth:Number = Math.max(_textField_Copy.width, _textField_Header.width )

        _calloutGraphic.rectWidth = _maxWidth + _paddingLeft + _paddingRight;

        if (!isNaN(this.minHeight) && _calloutGraphic.rectHeight < this.minHeight) {
            _calloutGraphic.rectHeight = this.minHeight;
        }

        if (!isNaN(this.minWidth) && _calloutGraphic.rectWidth < this.minWidth) {
            _calloutGraphic.rectWidth = this.minWidth;
        }



        if (_expandDirection == CalloutVARS.EXPAND_DOWN) {
            _textField_Header.width = _textField_Copy.width = this._width - _paddingLeft - _paddingRight - 2;
        }


        if (_registration == CalloutVARS.REGISTER_BOTTOM_MIDDLE) {
            _calloutGraphic.x = -( _calloutGraphic.width / 2 );
            _calloutGraphic.y = -_calloutGraphic.height;

        }

        if (_registration == CalloutVARS.REGISTER_TOP_MIDDLE ) {
            _calloutGraphic.x = -( _calloutGraphic.width / 2 );
            _calloutGraphic.y = _calloutGraphic.arrowHeight;
        }



        _textField_Header.x = _calloutGraphic.x + _paddingLeft;
        _textField_Copy.x = _calloutGraphic.x + _paddingLeft;
        _textField_Header.y = _calloutGraphic.y + _paddingTop;
        _textField_Copy.y = _textField_Header.y + _textField_Header.height + TEXTFIELD_GAP;

        _calloutGraphic.rectHeight = _textField_Copy.y + _textField_Copy.height + _paddingBottom;

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
        _textField_Copy.text = _text;
        this.layout();
    }

    public function get text():String {
        return _textField_Copy.text;
    }

    public function set header( _text:String):void {
        _textField_Header.text = _text;
    }

    public function set copy(_text:String):void {
        _textField_Copy.text = _text;
    }

    public function get headerTf():TextField {
        return _textField_Header;
    }

    public function set headerWidth( value:Number):void {
        _textField_Header.width = value;
        _textField_Copy.width = value;
        layout();
    }

    public function set copyWidth( value:Number ):void {
        _textField_Copy.width = value;
        layout();
    }

    public function get copyTF():TextField {
        return _textField_Copy;
    }

    public function invalidate():void {
        layout();
    }
}
}
