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



public class LoaderMaxImageItemVars {
    protected var _vars:Object;

    public const REGISTRATION_CENTER:String = "registrationCenter";
    public const REGISTRATION_TOP_LEFT:String = "registrationTopLeft";



    public function LoaderMaxImageItemVars(vars:Object = null) {
        //_target = target;
        _vars = (vars != null) ? CloneTextObjects.clone(vars) : new Object();
    }

    /** @private **/
    protected function _set(property:String, value:*, requirePlugin:Boolean = false):LoaderMaxImageItemVars {
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

    protected function _setFont(property:String, value:Font):LoaderMaxImageItemVars {
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
    public function align(align:String):LoaderMaxImageItemVars {
        return _set("align", align);
    }

    /**
     * Indicates the block indentation in pixels. Block indentation is applied to an entire block of text; that is, to all lines of the text. In contrast, normal indentation (TextFormat.indent) affects only the first line of each paragraph. If this property is null, the TextFormat object does not specify block indentation (block indentation is 0).
     *
     * @param blockIndent
     * @return
     */
    public function blockIndent(blockIndent:Number):LoaderMaxImageItemVars {
        return _set("blockIndent", blockIndent);
    }

    /**
     * Specifies whether the text is boldface. The default value is null, which means no boldface is used. If the value is true, then the text is boldface.
     *
     * @param bold
     * @return
     */
    public function bold(bold:Boolean):LoaderMaxImageItemVars {
        return _set("bold", bold);
    }

    /**
     * Indicates that the text is part of a bulleted list. In a bulleted list, each paragraph of text is indented. To the left of the first line of each paragraph, a bullet symbol is displayed. The default value is null, which means no bulleted list is used.
     *
     * @param bullet
     * @return
     */
    public function bullet(bullet:Boolean):LoaderMaxImageItemVars {
        return _set("bullet", bullet);
    }

    /**
     * Indicates the color of the text. A number containing three 8-bit RGB components; for example, 0xFF0000 is red, and 0x00FF00 is green. The default value is null, which means that Flash Player uses the color black (0x000000).
     *
     * @param color
     * @return
     */
    public function color(color:uint):LoaderMaxImageItemVars {
        return _set("color", color);
    }

    /**
     * The name of the font for text in this text format, as a string. The default value is null, which means that Flash Player uses Times New Roman font for the text.
     *
     * @param font
     * @return
     */
    public function font(font:*):LoaderMaxImageItemVars {

        var fontName:String = "";
        var fontClass:String = getClassName(font);

        if (fontClass == "String") {
            fontName = font;
        } else {
            fontName = font.fontName;
        }

        return _set("font", fontName);
    }


    public function _newProperty(_newProperty:Number):LoaderMaxImageItemVars {
        return _set("_newProperty", _newProperty);
    }



    public function width(width:Number):LoaderMaxImageItemVars {
        return _set("width", width);
    }

    public function height(height:Number):LoaderMaxImageItemVars {
        return _set("height", height);
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
    public function registration(registration:String):LoaderMaxImageItemVars {
        return _set("registration", registration);
    }

    public function registrationPoint(registrationPoint:Point):LoaderMaxImageItemVars {
        return _set("registrationPoint", registrationPoint);
    }



    //---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------------

    /** The generic object populated by all of the method calls in the TweenLiteVars instance. This is the raw data that gets passed to the tween. **/
    public function get vars():Object {
        return _vars;
    }

    /** @private **/
    public function get _isLoaderMaxImageItemVars():Boolean {
        return true;
    }
}
}