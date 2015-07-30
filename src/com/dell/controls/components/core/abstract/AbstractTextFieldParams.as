/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/5/13
 * Time: 2:11 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.core.abstract {
import com.dell.data.TextFieldVars;
import com.dell.data.TextFormatVars;
import com.dell.controls.components.text.core.TextUtil;
import com.dell.errors.AbstractMethodError;

import flash.text.TextFormat;

public class AbstractTextFieldParams extends Object {

    protected var _noFont_FORMAT_VARS:TextFormatVars;
    protected var _embeddedFont_FORMAT_VARS:TextFormatVars;

    public var _textField_VARS:TextFieldVars;

    private var _noFontTextFormat:TextFormat;
    private var _embeddedFontFormat:TextFormat;

    private var _text:String;



    public function AbstractTextFieldParams() {
        _noFont_FORMAT_VARS = new TextFormatVars();
        _embeddedFont_FORMAT_VARS = new TextFormatVars();

        _textField_VARS = new TextFieldVars();

        this.noFont_VARS();
        this.embeddedFont_VARS();
        this.textField_VARS();
        this.setTextFormats();
    }

    public function noFont_VARS():void {
        throw new AbstractMethodError();
    }

    public function embeddedFont_VARS():void {
        throw new AbstractMethodError();
    }

    public function textField_VARS():void {
        throw new AbstractMethodError();
    }


    private function setTextFormats():void {
        _noFontTextFormat = TextUtil.createTextFormat( _noFont_FORMAT_VARS.vars );
        _embeddedFontFormat = TextUtil.createTextFormat( _embeddedFont_FORMAT_VARS.vars );
    }


    public function get embeddedFontFormat():TextFormat {
        return _embeddedFontFormat;
    }

    public function get noFontTextFormat():TextFormat {
        return _noFontTextFormat;
    }



    public function get text():String {
        return _text;
    }

    public function set text(value:String):void {
        _text = value;
    }

    public function get textFieldVars():TextFieldVars {
        return this._textField_VARS;
    }

    public function set color(value:uint):void {
        _noFont_FORMAT_VARS.color( value );
        _embeddedFont_FORMAT_VARS.color( value )

    }

    public function set textFieldWidth( value:Number ):void {
        _textField_VARS.width( value );
    }



}
}
