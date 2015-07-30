package com.dell.controls.components.shape {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.utils.RoundPathHelper;

import flash.events.Event;

import flash.geom.Point;

/**
 * Graphic must have a vertically centered registration
 * @author Jerry_Orta
 *
 */
public class UI_Rectangle extends AbstractUI {

    private var vars:Object;


    private var _rectangleRadiusArray:Vector.<Number>;
    private var _pointsArray:Vector.<Point>;
    private var _raddiArray:Vector.<Number>;

    private var _rectWidth:Number;
    private var _rectHeight:Number;

    private var _fillColor:uint;
    private var _fillAlpha:Number;
    private var _borderColor:uint;
    private var _borderWeight:Number;
    private var _borderAlpha:Number;

    private var _topLeftRadius:Number;
    private var _topRightRadius:Number
    private var _bottomLeftRadius:Number;
    private var _bottomRightRadius:Number;

    private var _radius:Number;


    /**
     * <p>Pass a vars object with rectangle parameters;</p>
     *
     * <p> May use RectangleVARS to create params throwgh code hinting. <br>
     *     var param:RectangleVARS = new RectangleVARS();<br>
     *     param.width( 100 ).height( 100 ).topLeftRadius( 10 );</p>
     *
     * <p> Then pass param into Rectangle class. <br>
     *     var rect:Rectangle = new Rectangle( param );
     *
     * <ul>
     *     <li>vars.width = width of rectangle</li>
     *     <li>vars.height = height of rectangle</li>
     *     <li>vars.fillColor = fill color of rectangle</li>
     *     <li>vars.fillAlpha = opacity of fill.</li>
     *     <li>vars.borderWeight = wieght of border </li>
     *     <li>vars.borderColor = color of border</li>
     *     <li>vars.rectRadiusArray = Array of four corner radii of the rectangle, starting with top left, top right, bottom right, bottom left</li>
     *     <li>vars.topLeftRadius = top left radius of rectangle, overrides rectRadiusArray value</li>
     *     <li>vars.topRightRadius = top right radius of rectangle, overrides rectRadiusArray value</li>
     *     <li>vars.bottomLeftRadius = bottom left radius of rectangle, overrides rectRadiusArray value</li>
     *     <li>vars.bottomRightRadius = bottom right radius of rectangle, overrides rectRadiusArray value</li>
     * </ul>
     * @param vars
     */
    public function UI_Rectangle(vars:Object = null):void {
        this.name = "UI_Rectangle_GRAPHIC";
        this.vars = vars || {};
        if (this.vars._isRectangleVARS) {
            this.vars = this.vars.vars;
        }

		_rectangleRadiusArray = new Vector.<Number>(4, false);
        _pointsArray = new Vector.<Point>();
        _raddiArray = new Vector.<Number>();

        if (this.vars.rectangleRadiusArray != null) {
            _rectangleRadiusArray = this.vars.rectangleRadiusArray;
            _topLeftRadius = _rectangleRadiusArray[0];
            _topRightRadius = _rectangleRadiusArray[1];
            _bottomLeftRadius = _rectangleRadiusArray[2];
            _bottomRightRadius = _rectangleRadiusArray[3];
        } else {
            _rectangleRadiusArray = new <Number>[0, 0, 0, 0];
            _topLeftRadius = _rectangleRadiusArray[0];
            _topRightRadius = _rectangleRadiusArray[1];
            _bottomLeftRadius = _rectangleRadiusArray[2];
            _bottomRightRadius = _rectangleRadiusArray[3];
        }

        _topLeftRadius = (this.vars.topLeftRadius != null) ? this.vars.topLeftRadius : _rectangleRadiusArray[0] ;
        _topRightRadius = (this.vars.topRightRadius != null) ? this.vars.topRightRadius : _rectangleRadiusArray[1];
        _bottomLeftRadius = (this.vars.bottomLeftRadius != null) ? this.vars.bottomLeftRadius : _rectangleRadiusArray[2];
        _bottomRightRadius = (this.vars.bottomRightRadius != null) ? this.vars.bottomRightRadius : _rectangleRadiusArray[3];

        if (this.vars.radius != null) {
            _rectangleRadiusArray[0] = _topLeftRadius = this.vars.radius;
            _rectangleRadiusArray[1] = _topRightRadius = this.vars.radius;
            _rectangleRadiusArray[2] = _bottomLeftRadius = this.vars.radius;
            _rectangleRadiusArray[3] = _bottomRightRadius = this.vars.radius;
        }


        _rectWidth = (this.vars.width != null) ? this.vars.width : 351;
        _rectHeight = (this.vars.height != null) ? this.vars.height : 32;
        _fillColor = (this.vars.fillColor != null) ? this.vars.fillColor : 0xFFFFFF;
        _fillAlpha = (this.vars.fillAlpha != null) ? this.vars.fillAlpha : 1;
        _borderColor = (this.vars.borderColor != null) ? this.vars.borderColor : 0xFF0000;
        _borderWeight = (this.vars.borderWeight != null) ? this.vars.borderWeight : 0;
        _borderAlpha = (this.vars.borderAlpha != null) ? this.vars.borderAlpha : 1;


        calculatePoints();

    }

    override public function commitProperties( event:Event = null ):void {

    }


    private var _upperLeftPoint:Point;
    private var _upperRightPoint:Point;
    private var _bottomRightPoint:Point;
    private var _bottomLeftPoint:Point;

    protected function calculatePoints():void {

        //Upper Left of Rectangle
        _upperLeftPoint = new Point(0, 0);

        //Upper Right of Rectangle
        _upperRightPoint = new Point(_rectWidth, 0);

        //Bottom Right of Rectangle
        _bottomRightPoint = new Point(_rectWidth, _rectHeight);

        //Bottom Left of Rectangle
        _bottomLeftPoint = new Point(0, _rectHeight);

        this.assignVectors();
    }

    private function assignVectors():void {
        //Put points in order.
        _pointsArray = new <Point>[
            _upperLeftPoint,
            _upperRightPoint,
            _bottomRightPoint,
            _bottomLeftPoint
        ];
        _raddiArray = new <Number>[
            _rectangleRadiusArray[1],
            _rectangleRadiusArray[2],
            _rectangleRadiusArray[3],
            _rectangleRadiusArray[0]
        ];


        this.paint();
    }

    private function paint():void {
        graphics.clear();

        if (_borderWeight != 0) {
            graphics.lineStyle(_borderWeight, _borderColor, _borderAlpha, true);
        }
        graphics.beginFill(_fillColor, _fillAlpha);

        RoundPathHelper.drawRoundPath({g: graphics, points: _pointsArray, closePath: true, radii: _raddiArray});
        graphics.endFill();



    }


    override public function draw():void {
        this.calculatePoints();
    }

    override public function initialize():void {
	
    }

    /**
     * Width of call out rectangle.
     * @param number
     */
    override public function set width(number:Number):void {
        _rectWidth = number;
        this.calculatePoints();
    }

    /**
     * Width of call out rectangle.
     */
    override public function get width():Number {
        return _rectWidth;
    }

    /**
     * Height of call out rectangle.
     * @param number
     */
    override public function set height(number:Number):void {
        _rectHeight = number;
        this.calculatePoints();
    }


    override public function get height():Number {
        return _rectHeight;
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


	public function get topLeftRadius():Number {
        return _topLeftRadius;
    }

	public function set topLeftRadius(value:Number):void {
        _topLeftRadius = value;
        _rectangleRadiusArray[0] = value;
        this.calculatePoints();
    }

	public function get topRightRadius():Number {
        return _topRightRadius;
    }

	public function set topRightRadius(value:Number):void {
        _topRightRadius = value;
        _rectangleRadiusArray[1] = value;
        this.calculatePoints();
    }


	public function get bottomLeftRadius():Number {
        return _bottomLeftRadius;
    }

	public function set bottomLeftRadius(value:Number):void {
        _bottomLeftRadius = value;
        _rectangleRadiusArray[3] = value;
        this.calculatePoints();
    }

	public function get bottomRightRadius():Number {
        return _bottomRightRadius;
    }

	public function set bottomRightRadius(value:Number):void {
        _bottomRightRadius = value;
        _rectangleRadiusArray[2] = value;
        this.calculatePoints();
    }

	public function get radius():Number {
        return _radius;
    }

	public function set radius(value:Number):void {
        _radius = value;
        _rectangleRadiusArray[0] = value;
        _rectangleRadiusArray[1] = value;
        _rectangleRadiusArray[2] = value;
        _rectangleRadiusArray[3] = value;
        this.calculatePoints();
    }

}
}