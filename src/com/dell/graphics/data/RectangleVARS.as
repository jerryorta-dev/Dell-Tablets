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

public class RectangleVARS {
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


    public function RectangleVARS(vars:Object = null) {
		
		if (vars != null) {
			
			if (vars._isRectangleVARS) {
				_vars = clone( vars.vars );
			} else {
				_vars = clone(vars);
			}
			
		} else {
			_vars = new Object();
		}

    }

    /** @private **/
    protected function _set(property:String, value:*, requirePlugin:Boolean = false):RectangleVARS {
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

    public function prop(property:String, value:Number, relative:Boolean = false):RectangleVARS {
        return _set(property, (relative) ? String(value) : value);
    }

    public function addVars(newVars:Object):RectangleVARS {
        _vars = union(_vars, newVars);

        return this;
    }

    //---- PROPERTIES -------------------------------------------------------------------------------------------------------------


    public function width(width:Number):RectangleVARS {
        return _set("width", width);
    }


    public function height(height:Number):RectangleVARS {
        return _set("height", height);
    }


    public function fillColor(fillColor:uint = undefined):RectangleVARS {
        return _set("fillColor", fillColor);
    }


    public function fillAlpha(fillAlpha:Number):RectangleVARS {
        return _set("fillAlpha", fillAlpha);
    }


    public function borderWeight(borderWeight:Number):RectangleVARS {
        return _set("borderWeight", borderWeight);
    }


    public function borderColor(borderColor:uint = undefined):RectangleVARS {
        return _set("borderColor", borderColor);
    }


    public function rectangleRadiusArray(rectangleRadiusArray:Vector.<Number>):RectangleVARS {
        return _set("rectangleRadiusArray", rectangleRadiusArray);
    }

    public function topLeftRadius(topLeftRadius:Number):RectangleVARS {
        return _set("topLeftRadius", topLeftRadius);
    }

    public function topRightRadius(topRightRadius:Number):RectangleVARS {
        return _set("topRightRadius", topRightRadius);
    }

    public function bottomLeftRadius(bottomLeftRadius:Number):RectangleVARS {
        return _set("bottomLeftRadius", bottomLeftRadius);
    }

    public function bottomRightRadius(bottomRightRadius:Number):RectangleVARS {
        return _set("bottomRightRadius", bottomRightRadius);
    }

    public function radius(radius:Number):RectangleVARS {
        return _set("radius", radius);
    }

    public function x( x:Number ):RectangleVARS {
        return _set("x", x );
    }

    public function y(y:Number):RectangleVARS {
        return _set("y", y);
    }




    //---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------------

    /** The generic object populated by all of the method calls in the TweenLiteVars instance. This is the raw data that gets passed to the tween. **/
    public function get vars():Object {
        return _vars;
    }

    /** @private **/
    public function get _isRectangleVARS():Boolean {
        return true;
    }
}
}
