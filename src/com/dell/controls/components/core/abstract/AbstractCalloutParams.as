/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/5/13
 * Time: 2:11 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.core.abstract {
import com.dell.data.CalloutVARS;
import com.dell.data.TextFieldVars;
import com.dell.data.TextFormatVars;
import com.dell.controls.components.text.core.TextUtil;
import com.dell.errors.AbstractMethodError;
import com.dell.graphics.data.CalloutGraphicVARS;

import flash.text.TextFormat;

public class AbstractCalloutParams extends Object {

    protected var _noFont_FORMAT_VARS:TextFormatVars;
    protected var _embeddedFont_FORMAT_VARS:TextFormatVars;

    protected var _textField_VARS:TextFieldVars;

    protected var _noFontTextFormat:TextFormat;
    protected var _embeddedFontFormat:TextFormat;

    protected var _calloutGraphicVars:CalloutGraphicVARS;
    protected var _calloutVars:CalloutVARS;

    protected var _text:String;


    /**
     * The callout may be positioned on any side of the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_ANY:String = "any";

    /**
     * The callout may be positioned on top or bottom of the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_VERTICAL:String = "vertical";

    /**
     * The callout may be positioned on top or bottom of the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_HORIZONTAL:String = "horizontal";

    /**
     * The callout must be positioned above the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_UP:String = "up";

    /**
     * The callout must be positioned below the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_DOWN:String = "down";

    /**
     * The callout must be positioned to the left side of the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_LEFT:String = "left";

    /**
     * The callout must be positioned to the right side of the origin region.
     *
     * @see #supportedDirections
     */
    public static const DIRECTION_RIGHT:String = "right";

    /**
     * The arrow will appear on the top side of the callout.
     *
     * @see #arrowPosition
     */
    public static const ARROW_POSITION_TOP:String = "top";

    /**
     * The arrow will appear on the right side of the callout.
     *
     * @see #arrowPosition
     */
    public static const ARROW_POSITION_RIGHT:String = "right";

    /**
     * The arrow will appear on the bottom side of the callout.
     *
     * @see #arrowPosition
     */
    public static const ARROW_POSITION_BOTTOM:String = "bottom";

    /**
     * The arrow will appear on the left side of the callout.
     *
     * @see #arrowPosition
     */
    public static const ARROW_POSITION_LEFT:String = "left";




    public static const REGISTER_TOP_LEFT:String = "topLeft";
    public static const REGISTER_TOP_RIGHT:String = "topRight";
    public static const REGISTER_BOTTOM_RIGHT:String = "bottomRight";
    public static const REGISTER_BOTTOM_LEFT:String = "bottomLeft";
    public static const REGISTER_TOP_MIDDLE:String = "topMiddle";
    public static const REGISTER_RIGHT_MIDDLE:String = "rightMiddle";
    public static const REGISTER_BOTTOM_MIDDLE:String = "bottomMiddle";
    public static const REGISTER_LEFT_MIDDLE:String = "leftMiddle";

    public static const EXPAND_HORIZONTALLY:String = "expandHorizontally";
    public static const EXPAND_VERTICALLY:String = "expandVertically";
    public static const EXPAND_LEFT:String = "expandLeft";
    public static const EXPAND_RIGHT:String = "expandRight";
    public static const EXPAND_UP:String = "expandUp";
    public static const EXPAND_DOWN:String = "expandDown";



    public function AbstractCalloutParams() {
        _noFont_FORMAT_VARS = new TextFormatVars();
        _embeddedFont_FORMAT_VARS = new TextFormatVars();

        _textField_VARS = new TextFieldVars();
        _calloutGraphicVars = new CalloutGraphicVARS();
        _calloutVars = new CalloutVARS();

        this.noFont_VARS();
        this.embeddedFont_VARS();
        this.textField_VARS();
        this.setTextFormats();
        this.calloutGraphic_VARS();
        this.functionality_VARS();
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

    public function calloutGraphic_VARS():void {
        throw new AbstractMethodError();
    }

    public function functionality_VARS():void {
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
        _calloutVars.text( value );
    }

    public function get textFieldVars():TextFieldVars {
        return this._textField_VARS;
    }


    public function get calloutVars():CalloutVARS {
        return _calloutVars;
    }

    public function get calloutGraphicVars():CalloutGraphicVARS {
        return _calloutGraphicVars;
    }

    /** @private **/
    public function get _isAbstractCalloutParams():Boolean {
        return true;
    }
}
}
