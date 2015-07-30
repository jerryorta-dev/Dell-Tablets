package com.dell.graphics.components.shapes {
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.interfaces.IGraphic;
import com.dell.graphics.components.core.utils.RoundPathHelper;

import flash.display.Shape;
import flash.geom.Point;

/**
 * Graphic must have a vertically centered registration
 * @author Jerry_Orta
 *
 */
public class CallOutGraphic extends AbstractGraphic implements IGraphic {

    private var vars:Object;

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


    private var _registrationToArrowTip:Boolean;

    private var _rectangleRadiusArray:Vector.<Number>;

    private var _rectWidth:Number;
    private var _rectHeight:Number;

    private var _fillColor:uint;
    private var _fillAlpha:Number;
    private var _borderColor:uint;
    private var _borderWeight:Number;
    private var _borderAlpha:Number;

    private var _arrowRadiusArray:Vector.<Number>;

    private var _arrowWidth:Number;		//Width of Bubble point
    private var _arrowHeight:Number;		//Height of bubble point
    private var _arrowCentered:Boolean;
    private var _arrowDirection:String;

    private var _arrowLeftOffset:Number;
    private var _arrowRightOffset:Number;
    private var _arrowTopOffset:Number;
    private var _arrowBottomOffset:Number;
    private var _arrowPointPosition:Number;
    private var _arrowPoint:Point;

    private var _pointsArray:Vector.<Point>;
    private var _raddiArray:Vector.<Number>;
    private var _registration:String;
    private var _registrationPoint:Point;



    private var _shape:Shape;
    /**
     * <p>Pass a vars object with rectangle parameters;</p>
     *
     * <ul>
     *     <li>vars.width = width of rectangle</li>
     *     <li>vars.height = height of rectangle</li>
     *     <li>vars.fillColor = fill color of rectangle</li>
     *     <li>vars.fillAlpha = opacity of fill.</li>
     *     <li>vars.borderWeight = wieght of border </li>
     *     <li>vars.borderColor = color of border</li>
     *     <li>vars.rectRadiusArray = Array of four corner radii of the rectangle, starting with top left, top right, bottom right, bottom left</li>
     *     <li>vars.arrowRadiusArray = Array of three corner radii of the pointer, starting with the left, point, right, if pointing down</li>
     *     <li>vars.arrowWidth = width of pointer</li>
     *     <li>vars.arrowHeight =  height of pointer</li>
     *     <li>vars.arrowCentered = Boolean, point is Centered on side.
     *     <li>vars.arrowDirection = direction of pointer. for example: vars.right = CallOutGraphic.ARROW_POSITION_BOTTOM.</li>
     *     <li>vars.arrowLeftOffset = position of left of arrow ( top or bottom of callout ) from left edge of callout</li>
     *     <li>vars.arrowRightOffset = position of right of arrow (top or bottom of callout ) from right edge of callout</li>
     *     <li>vars.arrowTopOffset = position of top of arrow ( Left or Right of callout ) from top edge of callout</li>
     *     <li>vars.arrowBottomOffset = position of bottom of arrow ( Left or Right of callout ) from bottom edge of callout</li>
     *     <li>vars.arrowPointPosition = position of the center of arrow relative to the left callout edge ( if arrow is positioned at the top or bottom of callout) or top edge (if arrow is positioned on the left or right of callout).</li>
     *     <li>vars.arrowPoint = a point object place the arrow tip. Use this if need to point to another object</li>
     *     <li>vars.registration = alignment of the registration point in the Sprite</li>
     *     <li>vars.registrationPoint = specific point to registrate sprite</li>
     * </ul>
     * @param vars
     */
    public function CallOutGraphic(vars:Object = null):void {
        this.vars = vars || {};
        if (this.vars._isCalloutGraphicVARS) {
            this.vars = this.vars.vars;
        }

        _shape = new Shape();

        _rectangleRadiusArray = new Vector.<Number>(4, false);
        _arrowRadiusArray = new Vector.<Number>(3, false);
        _pointsArray = new Vector.<Point>();
        _raddiArray = new Vector.<Number>();

        if (this.vars.rectangleRadiusArray != null) {
            _rectangleRadiusArray = this.vars.rectangleRadiusArray;
        } else {
            _rectangleRadiusArray = new <Number>[10, 10, 10, 10];
        }

        _rectWidth = (this.vars.width != null) ? this.vars.width : 351;
        _rectHeight = (this.vars.height != null) ? this.vars.height : 32;
        _fillColor = (this.vars.fillColor != null) ? this.vars.fillColor : 0xFFFFFF;
        _fillAlpha = (this.vars.fillAlpha != null) ? this.vars.fillAlpha : 1;
        _borderColor = (this.vars.borderColor != null) ? this.vars.borderColor : 0xFF0000;
        _borderWeight = (this.vars.borderWeight != null) ? this.vars.borderWeight : 0;
        _borderAlpha = (this.vars.borderAlpha != null) ? this.vars.borderAlpha : 1;

        if (this.vars.arrowRadiusArray != null) {
            _arrowRadiusArray = this.vars.arrowRadiusArray;
        } else {
            _arrowRadiusArray = new <Number>[5, 5, 5];
        }

        _arrowWidth = (this.vars.arrowWidth != null) ? this.vars.arrowWidth : 0;
        _arrowHeight = (this.vars.arrowHeight != null) ? this.vars.arrowHeight : 0;
        _arrowDirection = (this.vars.arrowDirection != null) ? this.vars.arrowDirection : CallOutGraphic.ARROW_POSITION_BOTTOM;

        _arrowTopOffset = (this.vars.arrowTopOffset != null ) ? this.vars.arrowTopOffset : null;
        _arrowBottomOffset = (this.vars.arrowBottomOffset != null ) ? this.vars.arrowBottomOffset : null;
        _arrowLeftOffset = (this.vars.arrowLeftOffset != null ) ? this.vars.arrowLeftOffset : null;
        _arrowRightOffset = (this.vars.arrowRightOffset != null ) ? this.vars.arrowRightOffset : null;

        _arrowCentered = (this.vars.arrowCentered != null ) ? this.vars.arrowCentered : false;

        _arrowPointPosition = ( this.vars.arrowPointPosition != null ) ? this.vars.arrowPointPosition : null;
        _arrowPoint = (this.vars.arrowPoint != null) ? this.vars.arrowPoint : null;

        _registration = (this.vars.registration != null) ? this.vars.registration : CallOutGraphic.REGISTER_TOP_LEFT;
        _registrationPoint = (this.vars.registrationPoint) ? this.vars.registrationPoint : null;
        _registrationToArrowTip = (this.vars.registrationToArrowTip != null) ? this.vars.registrationToArrowTip : false;

        calculatePoints();

    }


    private var _upperLeftPoint:Point;
    private var _upperRightPoint:Point;
    private var _bottomRightPoint:Point;
    private var _bottomLeftPoint:Point;

    private var _arrowFirstPoint:Point;
    private var _arrowTipPoint:Point;
    private var _arrowSecongPoint:Point;

    protected function calculatePoints():void {

        //Upper Left of Rectangle
        _upperLeftPoint = new Point(0, 0);

        //Upper Right of Rectangle
        _upperRightPoint = new Point(_rectWidth, 0);

        //Bottom Right of Rectangle
        _bottomRightPoint = new Point(_rectWidth, _rectHeight);

        //Bottom Left of Rectangle
        _bottomLeftPoint = new Point(0, _rectHeight);

        if (_arrowRightOffset) {
            _arrowLeftOffset = _rectWidth - _arrowWidth - _arrowRightOffset;
        }

        if (_arrowLeftOffset) {
            _arrowRightOffset = _arrowLeftOffset + _arrowWidth
        }

        if (isNaN(_arrowRightOffset) && isNaN(_arrowLeftOffset)) {
            _arrowLeftOffset = getHorizontalCenterOffset();
            _arrowRightOffset = _arrowLeftOffset + _arrowWidth;
        }

        if (_arrowBottomOffset) {
            _arrowTopOffset = _rectHeight - _arrowWidth - _arrowBottomOffset;
        }

        if (_arrowTopOffset) {
            _arrowBottomOffset = _arrowTopOffset + _arrowWidth;
        }

        if (isNaN(_arrowTopOffset) && isNaN(_arrowBottomOffset)) {
            _arrowTopOffset = getVerticalCenterOffset();
            _arrowBottomOffset = _arrowTopOffset + _arrowWidth;
        }

        if (_arrowPointPosition) {
            _arrowLeftOffset = getHorizontalCenterOffset();
            _arrowRightOffset = _arrowLeftOffset + _arrowWidth;

            _arrowTopOffset = getVerticalCenterOffset();
            _arrowBottomOffset = _arrowTopOffset + _arrowWidth;
        }

        if (_arrowCentered) {
            _arrowLeftOffset = getHorizontalCenterOffset();
            _arrowRightOffset = _arrowLeftOffset + _arrowWidth;
            _arrowTopOffset = getVerticalCenterOffset();
            _arrowBottomOffset = _arrowTopOffset + _arrowWidth;
        }


        this.checkLimits();

    }


    private function checkLimits():void {
        if (_arrowTopOffset < ( _arrowWidth / 2)) {
            _arrowTopOffset = _arrowWidth / 2;
            _arrowBottomOffset = _arrowTopOffset + _arrowWidth;
        }

        if (_arrowBottomOffset > ( _rectHeight - (_arrowWidth / 2))) {
            _arrowBottomOffset = _rectHeight - (_arrowWidth / 2);
            _arrowTopOffset =  _arrowBottomOffset - _arrowWidth;
        }

        if (_arrowLeftOffset < ( _arrowWidth / 2)) {
            _arrowLeftOffset = _arrowWidth / 2;
            _arrowRightOffset = _arrowLeftOffset + _arrowWidth;
        }

        if (_arrowRightOffset > ( _rectWidth - ( _arrowWidth / 2))) {

            _arrowRightOffset = _rectWidth - ( _arrowWidth / 2);
            _arrowLeftOffset = _arrowRightOffset - _arrowWidth;
        }
		

        this.assignVectors();
    }

    private function assignVectors():void {
        //Put points in order.
        if (_arrowDirection == CallOutGraphic.ARROW_POSITION_TOP) {
            _arrowFirstPoint = new Point(_arrowLeftOffset, 0); //done

            if (_arrowPoint) {
                _arrowTipPoint = _arrowPoint;
            } else {
                _arrowTipPoint = new Point(_arrowLeftOffset + (_arrowWidth / 2), -_arrowHeight);
            }
            _arrowSecongPoint = new Point(_arrowRightOffset, 0); //done

            _pointsArray = new <Point>[
                _upperLeftPoint,
                _arrowFirstPoint,
                _arrowTipPoint,
                _arrowSecongPoint,
                _upperRightPoint,
                _bottomRightPoint,
                _bottomLeftPoint
            ];
            _raddiArray = new <Number>[
                _rectangleRadiusArray[0],
                _arrowRadiusArray[0],
                _arrowRadiusArray[1],
                _arrowRadiusArray[2],
                _rectangleRadiusArray[1],
                _rectangleRadiusArray[2],
                _rectangleRadiusArray[3]
            ];
        }

        if (_arrowDirection == CallOutGraphic.ARROW_POSITION_RIGHT) {
            _arrowFirstPoint = new Point(_rectWidth, _arrowTopOffset); //done

            if (_arrowPoint) {
                _arrowTipPoint = _arrowPoint;
            } else {
                _arrowTipPoint = new Point(_rectWidth + _arrowHeight, _arrowTopOffset + (_arrowWidth / 2));
            }
            _arrowSecongPoint = new Point(_rectWidth, _arrowBottomOffset); //done

            _pointsArray = new <Point>[
                _upperLeftPoint,
                _upperRightPoint,
                _arrowFirstPoint,
                _arrowTipPoint,
                _arrowSecongPoint,
                _bottomRightPoint,
                _bottomLeftPoint
            ];
            _raddiArray = new <Number>[
                _rectangleRadiusArray[0],
                _rectangleRadiusArray[1],
                _arrowRadiusArray[0],
                _arrowRadiusArray[1],
                _arrowRadiusArray[2],
                _rectangleRadiusArray[2],
                _rectangleRadiusArray[3]
            ];
        }

        if (_arrowDirection == CallOutGraphic.ARROW_POSITION_BOTTOM) {
            _arrowFirstPoint = new Point(_arrowRightOffset, _rectHeight); //done

            if (_arrowPoint) {
                _arrowTipPoint = _arrowPoint;
            } else {
                _arrowTipPoint = new Point(_arrowRightOffset - (_arrowWidth / 2), _rectHeight + _arrowHeight);
            }
            _arrowSecongPoint = new Point(_arrowLeftOffset, _rectHeight); //done

            _pointsArray = new <Point>[
                _upperLeftPoint,
                _upperRightPoint,
                _bottomRightPoint,
                _arrowFirstPoint,
                _arrowTipPoint,
                _arrowSecongPoint,
                _bottomLeftPoint
            ];
            _raddiArray = new <Number>[
                _rectangleRadiusArray[0],
                _rectangleRadiusArray[1],
                _rectangleRadiusArray[2],
                _arrowRadiusArray[0],
                _arrowRadiusArray[1],
                _arrowRadiusArray[2],
                _rectangleRadiusArray[3]
            ];
        }

        if (_arrowDirection == CallOutGraphic.ARROW_POSITION_LEFT) {
            _arrowFirstPoint = new Point(0, _arrowBottomOffset); //done

            if (_arrowPoint) {
                _arrowTipPoint = _arrowPoint;
            } else {
                _arrowTipPoint = new Point(-_arrowHeight, _arrowBottomOffset - ( _arrowWidth / 2));
            }

            _arrowSecongPoint = new Point(0, _arrowTopOffset); //done

            _pointsArray = new <Point>[
                _upperLeftPoint,
                _upperRightPoint,
                _bottomRightPoint,
                _bottomLeftPoint,
                _arrowFirstPoint,
                _arrowTipPoint,
                _arrowSecongPoint
            ];
            _raddiArray = new <Number>[
                _rectangleRadiusArray[0],
                _rectangleRadiusArray[1],
                _rectangleRadiusArray[2],
                _rectangleRadiusArray[3],
                _arrowRadiusArray[0],
                _arrowRadiusArray[1],
                _arrowRadiusArray[2]
            ];
        }


        //Adjust radius array
        _raddiArray.push(_raddiArray.shift());

        this.paint();
    }

    private function getVerticalCenterOffset():Number {
        return (_rectHeight / 2 ) - (_arrowWidth / 2 );
    }

    private function getHorizontalCenterOffset():Number {
        return (_rectWidth / 2 ) - (_arrowWidth / 2 );
    }

    private function paint():void {
        _shape.graphics.clear();

        if (_borderWeight != 0) {
            _shape.graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);
        }
        _shape.graphics.beginFill(_fillColor, _fillAlpha);

        RoundPathHelper.drawRoundPath({g: _shape.graphics, points: _pointsArray, closePath: true, radii: _raddiArray});
        _shape.graphics.endFill()



        this.setRegistration();

    }


    override public function draw():void {
      
    }


    private function setRegistration():void {
        if (_registration == CallOutGraphic.REGISTER_TOP_LEFT) {
            _shape.x = 0;
            _shape.y = 0;
        }

        if (_registration == CallOutGraphic.REGISTER_TOP_MIDDLE) {
            _shape.x = -(this.rectWidth / 2);
            _shape.y = 0;
        }

        if (_registration == CallOutGraphic.REGISTER_TOP_RIGHT) {
            _shape.x = -this.rectWidth;
            _shape.y = 0;
        }

        if (_registration == CallOutGraphic.REGISTER_RIGHT_MIDDLE) {
            _shape.x = -this.rectWidth;
            _shape.y = -(this.rectHeight / 2);
        }

        if (_registration == CallOutGraphic.REGISTER_BOTTOM_RIGHT) {
            _shape.x = -this.rectWidth;
            _shape.y = -(this.rectHeight);
        }

        if (_registration == CallOutGraphic.REGISTER_BOTTOM_MIDDLE) {
            _shape.x = -(this.rectWidth / 2);
            _shape.y = -this.rectHeight;
        }

        if (_registration == CallOutGraphic.REGISTER_BOTTOM_LEFT) {
            _shape.x = 0;
            _shape.y = -this.rectHeight;
        }

        if (_registration == CallOutGraphic.REGISTER_LEFT_MIDDLE) {
            _shape.x = 0;
            _shape.y = -(this.rectHeight / 2);
        }

        if (_registrationPoint != null) {
            _shape.x = _registrationPoint.x;
            _shape.y = _registrationPoint.y;
        }

        if (_registrationToArrowTip) {
            _shape.x = -_arrowTipPoint.x;
            _shape.y = -_arrowTipPoint.y;
        }


    }

    override public function initialize():void {
        this.addChild(_shape);
        this.calculatePoints();
    }

    /**
     * Width of call out rectangle.
     * @param number
     */
    public function set rectWidth(number:Number):void {
        _rectWidth = number;
        this.calculatePoints();
    }

    /**
     * Width of call out rectangle.
     */
    public function get rectWidth():Number {
        return _rectWidth;
    }

    override public function set width(number:Number):void {
        _rectWidth = number;
        this.calculatePoints();
    }

    /**
     * Width of call out rectangle.
     */
    override public function get width():Number {
        if (_arrowDirection == CallOutGraphic.ARROW_POSITION_LEFT || _arrowDirection == CallOutGraphic.ARROW_POSITION_RIGHT) {
            return _rectWidth + _arrowHeight;
        } else {
            return _rectWidth;
        }
    }

    /**
     * Height of call out rectangle.
     * @param number
     */
    public function set rectHeight(number:Number):void {
        _rectHeight = number;
        this.calculatePoints();
    }


    public function get rectHeight():Number {
        return _rectHeight;
    }

    override public function set height(number:Number):void {
        _rectHeight = number;
        this.calculatePoints();
    }


    override public function get height():Number {
        if (_arrowDirection == CallOutGraphic.ARROW_POSITION_TOP || _arrowDirection == CallOutGraphic.ARROW_POSITION_BOTTOM) {
            return _rectHeight + _arrowHeight;
        } else {
            return _rectHeight;
        }
    }


    /**
     * Color of the call out fill in the format 0xFFFFFF;
     * @return
     *
     */
    public function get fillColor():uint {
        return _fillColor;
    }

    public function set fillColor(value:uint):void {
        _fillColor = value;
        this.calculatePoints();
    }

    /**
     * Opacity of the fill.
     * @return
     *
     */
    public function get fillAlpha():Number {
        return _fillAlpha;
    }

    public function set fillAlpha(value:Number):void {
        _fillAlpha = value;
        this.calculatePoints();
    }

    /**
     * Color of border in in the format 0xFFFFFF;
     * @return
     *
     */
    public function get borderColor():uint {
        return _borderColor;
    }

    public function set borderColor(value:uint):void {
        _borderColor = value;
        this.calculatePoints();
    }

    /**
     * Weight in pixels or border.
     * @return
     *
     */
    public function get borderWeight():Number {
        return _borderWeight;
    }

    public function set borderWeight(value:Number):void {
        _borderWeight = value;
        this.calculatePoints();
    }

    /**
     * Opacity of Call Out border.
     * @return
     *
     */
    public function get borderAlpha():Number {
        return _borderAlpha;
    }

    public function set borderAlpha(value:Number):void {
        _borderAlpha = value;
        this.calculatePoints();
    }

    /**
     * Width of arrow when place on top or bottom of rectangle. Height of arrow when place on left or right of rectangle.
     * @return
     *
     */
    public function get arrowWidth():Number {
        return _arrowWidth;
    }

    public function set arrowWidth(value:Number):void {
        _arrowWidth = value;
        this.calculatePoints();
    }

    /**
     * Height of arrow when it's placed on top or bottom of rectangle. Width of arrow if placed on the left or right of rectangle.
     * @return
     *
     */
    public function get arrowHeight():Number {
        return _arrowHeight;
    }

    public function set arrowHeight(value:Number):void {
        _arrowHeight = value;
        this.calculatePoints();
    }

    /**
     * Center the arrow on the rectangle edge.
     * @return
     *
     */
    public function get arrowCentered():Boolean {
        return _arrowCentered;
    }

    public function set arrowCentered(value:Boolean):void {
        _arrowCentered = value;
        this.calculatePoints();
    }

    /**
     * The edge of the rectangle to place the arrow. Use the following:<br><br>
     *
     * CallOutGraphic.ARROW_POSITION_TOP<br>
     * CallOutGraphic.ARROW_POSITION_RIGHT<br>
     * CallOutGraphic.ARROW_POSITION_BOTTOM<br>
     * CallOutGraphic.ARROW_POSITION_LEFT<br>
     *
     * @return
     *
     */
    public function get arrowDirection():String {
        return _arrowDirection;
    }

    public function set arrowDirection(value:String):void {
        _arrowDirection = value;
        this.calculatePoints();
    }

    /**
     * Position of the arrow from it's left edge to the left of the rectangle.
     * @return
     *
     */
    public function get arrowLeftOffset():Number {
        return _arrowLeftOffset;
    }

    public function set arrowLeftOffset(value:Number):void {
        _arrowLeftOffset = value;
        this.calculatePoints();
    }

    /**
     * Position of the arrow from it's right edge to the right of the rectangle.
     * @return
     *
     */
    public function get arrowRightOffset():Number {
        return _arrowRightOffset;
    }

    public function set arrowRightOffset(value:Number):void {
        _arrowRightOffset = value;
        this.calculatePoints();
    }

    /**
     * Position of the arrow from it's top edge to the top of the rectangle.
     * @return
     *
     */
    public function get arrowTopOffset():Number {
        return _arrowTopOffset;
    }

    public function set arrowTopOffset(value:Number):void {
        _arrowTopOffset = value;
        this.calculatePoints();
    }

    /**
     * Position of the arrow from it's lower edge to the bottom of the rectangle.
     * @return
     *
     */
    public function get arrowBottomOffset():Number {
        return _arrowBottomOffset;
    }

    public function set arrowBottomOffset(value:Number):void {
        _arrowBottomOffset = value;
        this.calculatePoints();
    }

    /**
     * Position the tip of the arrow to any postion. Good to point to other objects.
     * @return
     *
     */
    public function get arrowPoint():Point {
        return _arrowPoint;
    }

    public function set arrowPoint(value:Point):void {
        _arrowPoint = value;
        this.calculatePoints();
    }

    /**
     * Position the center of the arrow on the rectangle edge rather than using offets. Overrides offsets.
     * @return
     *
     */
    public function get arrowPointPosition():Number {
        return _arrowPointPosition;
    }

    public function set arrowPointPosition(value:Number):void {
        _arrowPointPosition = value;
        this.calculatePoints();
    }


    public function get registrationPoint():Point {
        return _registrationPoint;
    }

    public function set registrationPoint(value:Point):void {
        _registrationPoint = value;
    }

    public function get registration():String {
        return _registration;
    }

    public function set registration(value:String):void {
        _registration = value;
    }
}
}