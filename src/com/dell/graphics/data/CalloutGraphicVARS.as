/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com
 *
 * Date: 10/31/12
 * Time: 9:13 AM
 */
package com.dell.graphics.data {
import com.dell.utils.object.clone;
import com.dell.utils.objects.union;

import flash.geom.Point;
import flash.globalization.NumberFormatter;

public class CalloutGraphicVARS {
    /** @private **/
    public static const version:Number = 1.0;

    /** @private **/
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


    public function CalloutGraphicVARS(vars:Object = null) {
        //_target = target;
        _vars = (vars != null) ? clone(vars) : new Object();

    }

    /** @private **/
    protected function _set(property:String, value:*, requirePlugin:Boolean = false):CalloutGraphicVARS {
        if (value == null) {
            delete _vars[property]; //in case it was previously set
        } else {
            _vars[property] = value;
        }
        /* if (requirePlugin && !(property in _target.plugins)) {
         trace("WARNING: you must activate() the " + property + " plugin in order for the feature to work in TweenLite. See http://www.greensock.com/tweenlite/#plugins for details.");
         }*/
        return this;
    }

    public function prop(property:String, value:Number, relative:Boolean = false):CalloutGraphicVARS {
        return _set(property, (relative) ? String(value) : value);
    }

    public function addVars(newVars:Object):CalloutGraphicVARS {
        _vars = union(_vars, newVars);

        return this;
    }

    //---- PROPERTIES -------------------------------------------------------------------------------------------------------------


    public function width(width:Number):CalloutGraphicVARS {
        return _set("width", width);
    }


    public function height(height:Number):CalloutGraphicVARS {
        return _set("height", height);
    }


    public function fillColor(fillColor:uint = undefined):CalloutGraphicVARS {
        return _set("fillColor", fillColor);
    }


    public function fillAlpha(fillAlpha:Number):CalloutGraphicVARS {
        return _set("fillAlpha", fillAlpha);
    }


    public function borderWeight(borderWeight:Number):CalloutGraphicVARS {
        return _set("borderWeight", borderWeight);
    }


    public function borderColor(borderColor:uint = undefined):CalloutGraphicVARS {
        return _set("borderColor", borderColor);
    }


    public function rectangleRadiusArray(rectangleRadiusArray:Vector.<Number>):CalloutGraphicVARS {
        return _set("rectangleRadiusArray", rectangleRadiusArray);
    }


    public function arrowRadiusArray(arrowRadiusArray:Vector.<Number>):CalloutGraphicVARS {
        return _set("arrowRadiusArray", arrowRadiusArray);
    }


    public function arrowWidth(arrowWidth:Number):CalloutGraphicVARS {
        return _set("arrowWidth", arrowWidth);
    }


    public function arrowHeight(arrowHeight:Number):CalloutGraphicVARS {
        return _set("arrowHeight", arrowHeight);
    }

    public function arrowCentered(arrowCentered:Boolean):CalloutGraphicVARS {
        return _set("arrowCentered", arrowCentered);
    }

    public function arrowDirection(arrowDirection:String):CalloutGraphicVARS {
        return _set("arrowDirection", arrowDirection);
    }

    public function arrowLeftOffset(arrowLeftOffset:Number):CalloutGraphicVARS {
        return _set("arrowLeftOffset", arrowLeftOffset);
    }

    public function arrowRightOffset(arrowRightOffset:Number):CalloutGraphicVARS {
        return _set("arrowRightOffset", arrowRightOffset);
    }

    public function arrowTopOffset(arrowTopOffset:Number):CalloutGraphicVARS {
        return _set("arrowTopOffset", arrowTopOffset);
    }

    public function arrowBottomOffset(arrowBottomOffset:Number):CalloutGraphicVARS {
        return _set("arrowBottomOffset", arrowBottomOffset);
    }

    public function arrowPointPosition(arrowPointPosition:Number):CalloutGraphicVARS {
        return _set("arrowPointPosition", arrowPointPosition);
    }

    public function arrowPoint(arrowPoint:Point):CalloutGraphicVARS {
        return _set("arrowPoint", arrowPoint);
    }




    //---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------------

    /** The generic object populated by all of the method calls in the TweenLiteVars instance. This is the raw data that gets passed to the tween. **/
    public function get vars():Object {
        return _vars;
    }

    /** @private **/
    public function get _isCalloutGraphicVARS():Boolean {
        return true;
    }
}
}
