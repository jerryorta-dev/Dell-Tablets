/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com
 *
 * Date: 10/31/12
 * Time: 9:14 AM
 */
package com.dell.data {
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.text.core.CloneTextObjects;
import com.dell.graphics.data.CalloutGraphicVARS;
import com.dell.utils.type.getClassName;

import flash.geom.Point;
import flash.text.Font;



public class CalloutVARS {
    protected var _vars:Object;

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

    public function CalloutVARS(vars:Object = null) {
        //_target = target;
        _vars = (vars != null) ? CloneTextObjects.clone(vars) : new Object();
    }

    /** @private **/
    protected function _set(property:String, value:*, requirePlugin:Boolean = false):CalloutVARS {
        if (value == null) {
            delete _vars[property]; //in case it was previously set
        } else {
            _vars[property] = value;
        }
        /* if (requirePlugin && !(property in _target.plugins)) {
         trace("WARNING: you must activate() the " + property + " plugin in order for the feature to work in TweenLite. See http://www.greensock.com/tweenlite/#plugins for details.");
         }*/

        //trace(_format[property]);
        return this;
    }

    protected function _setFont(property:String, value:Font):CalloutVARS {
        _vars[property] = value as Font;
        return this;
    }


    //---- PROPERTIES -------------------------------------------------------------------------------------------------------------

    /**
     * Indicates the alignment of the paragraph. Valid values are TextFormatAlign constants.
     *
     * The default value is TextFormatAlign.LEFT.
     *
     * @param align
     * @return
     */
    public function align(align:String):CalloutVARS {
        return _set("align", align);
    }

    /**
     * Indicates the block indentation in pixels. Block indentation is applied to an entire block of text; that is, to all lines of the text. In contrast, normal indentation (TextFormat.indent) affects only the first line of each paragraph. If this property is null, the TextFormat object does not specify block indentation (block indentation is 0).
     *
     * @param blockIndent
     * @return
     */
    public function blockIndent(blockIndent:Number):CalloutVARS {
        return _set("blockIndent", blockIndent);
    }

    /**
     * Specifies whether the text is boldface. The default value is null, which means no boldface is used. If the value is true, then the text is boldface.
     *
     * @param bold
     * @return
     */
    public function bold(bold:Boolean):CalloutVARS {
        return _set("bold", bold);
    }

    /**
     * Indicates that the text is part of a bulleted list. In a bulleted list, each paragraph of text is indented. To the left of the first line of each paragraph, a bullet symbol is displayed. The default value is null, which means no bulleted list is used.
     *
     * @param bullet
     * @return
     */
    public function bullet(bullet:Boolean):CalloutVARS {
        return _set("bullet", bullet);
    }

    /**
     * Indicates the color of the text. A number containing three 8-bit RGB components; for example, 0xFF0000 is red, and 0x00FF00 is green. The default value is null, which means that Flash Player uses the color black (0x000000).
     *
     * @param color
     * @return
     */
    public function color(color:uint):CalloutVARS {
        return _set("color", color);
    }

    /**
     * The name of the font for text in this text format, as a string. The default value is null, which means that Flash Player uses Times New Roman font for the text.
     *
     * @param font
     * @return
     */
    public function font(font:*):CalloutVARS {

        var fontName:String = "";
        var fontClass:String = getClassName(font);

        if (fontClass == "String") {
            fontName = font;
        } else {
            fontName = font.fontName;
        }

        return _set("font", fontName);
    }


    public function _newProperty(_newProperty:Number):CalloutVARS {
        return _set("_newProperty", _newProperty);
    }


    public function padding(padding:Number):CalloutVARS {
        return _set("padding", padding);
    }

    public function paddingRight(paddingRight:Number):CalloutVARS {
        return _set("paddingRight", paddingRight);
    }

    public function paddingTop(paddingTop:Number):CalloutVARS {
        return _set("paddingTop", paddingTop);
    }

    public function paddingLeft(paddingLeft:Number):CalloutVARS {
        return _set("paddingLeft", paddingLeft);
    }

    public function paddingBottom(paddingBottom:Number):CalloutVARS {
        return _set("paddingBottom", paddingBottom);
    }

    public function expandDirection(expandDirection:String):CalloutVARS {
        return _set("expandDirection", expandDirection);
    }

    public function textFieldVars(textFieldVars:AbstractTextFieldParams):CalloutVARS {
        return _set("textFieldVars", textFieldVars);
    }

    public function calloutGraphicVars(calloutGraphicVars:CalloutGraphicVARS):CalloutVARS {
        return _set("calloutGraphicVars", calloutGraphicVars);
    }

    public function maxWidth(maxWidth:Number):CalloutVARS {
        return _set("maxWidth", maxWidth);
    }

    public function maxHeight(maxHeight:Number):CalloutVARS {
        return _set("maxHeight", maxHeight);
    }

    public function width(width:Number):CalloutVARS {
        return _set("width", width);
    }

    public function height(height:Number):CalloutVARS {
        return _set("height", height);
    }

    public function minWidth(minWidth:Number):CalloutVARS {
        return _set("minWidth", minWidth);
    }

    public function minHeight(minHeight:Number):CalloutVARS {
        return _set("minHeight", minHeight);
    }

    public function arrowDirection(arrowDirection:String):CalloutVARS {
        return _set("arrowDirection", arrowDirection);
    }
	
	public function textMaxLines(textMaxLines:int):CalloutVARS {
		return _set("textMaxLines", textMaxLines);
	}

    /**
     *  Side of callout to position arrow.
     * @param arrowPosition
     * @return
     */
    public function arrowPosition(arrowPosition:String):CalloutVARS {
        return _set("arrowPosition", arrowPosition);
    }

    public function text(text:String):CalloutVARS {
        return _set("text", text);
    }

    /**
     * <p>This resgistraction point of the graphic in the Sprite. Use the following constants:</p>
     * <ul>
     *     <li>CallOutGraphic.REGISTER_TOP_LEFT</li>
     *     <li>CallOutGraphic.REGISTER_TOP_RIGHT</li>
     *     <li>CallOutGraphic.REGISTER_TOP_LEFT</li>
     *     <li>CallOutGraphic.REGISTER_BOTTOM_RIGHT</li>
     *     <li>CallOutGraphic.REGISTER_TOP_MIDDLE</li>
     *     <li>CallOutGraphic.REGISTER_RIGHT_MIDDLE</li>
     *     <li>CallOutGraphic.REGISTER_BOTTOM_MIDDLE</li>
     *     <li>CallOutGraphic.REGISTER_LEFT_MIDDLE</li>
     * </ul>
     * @param registration
     * @return
     */
    public function registration(registration:String):CalloutVARS {
        return _set("registration", registration);
    }

    public function registrationPoint(registrationPoint:Point):CalloutVARS {
        return _set("registrationPoint", registrationPoint);
    }

    public function registrationToArrowTip(registrationToArrowTip:Boolean):CalloutVARS {
        return _set("registrationToArrowTip", registrationToArrowTip);
    }

    //---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------------

    /** The generic object populated by all of the method calls in the TweenLiteVars instance. This is the raw data that gets passed to the tween. **/
    public function get vars():Object {
        return _vars;
    }

    /** @private **/
    public function get _isCalloutVARS():Boolean {
        return true;
    }
}
}