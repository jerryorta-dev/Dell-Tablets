/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/15/13
 * Time: 11:17 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.image {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.core.Global;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Linear;
import com.greensock.easing.Strong;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TransformAroundPointPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * <p>Displays a lowres and highres image.</p>
 *
 * <p>vars:</p>
 * <ul>
 *     <li>vars.width = width of image</li>
 *     <li>vars.height = height of image</li>
 *     <li>vars.registration = defaults to ImageItem.TOP_LEFT_REGISTRATION</li>
 * </ul>
 *
 * <p>data:</p>
 * <ul>
 *     <li>data.lowResImage = lowRes display Object</li>
 *     <li>data.hiResImage = hiRes display Object</li>
 *     <li>data.zoomMin = min scale to zoom image, usually the start scale</li>
 *     <li>data.zoomMax = max scale to zoom image.</li>
 * </ul>
 */
public class ImageItem extends AbstractUI {

    //VARS
    private var _width:Number;
    private var _height:Number;

    //DATA
    private var _lowResImage:Sprite;
    private var _zoomImage:Sprite;
    private var _callout:Sprite;

    private var _zoomMin:Number;
    private var _zoomMax:Number;
    private var _index:int;
    private var _calloutIsActive:Boolean = true;

    //Helpers
    private var _mask:Sprite;

    private var _displayObjects:Vector.<Sprite>;


    private var _registration:String;
    public static const CENTER_REGISTRATION:String = "centerRegistration";
    public static const TOP_LEFT_REGISTRATION:String = "topLeftRegistration";

    private var _maxBounds:Rectangle;

    public function ImageItem(vars:Object = null, data:Object = null) {

        //vars
        this._vars = ( vars != null ) ? vars : null;
        this._width = this._vars.width;
        this._height = this._vars.height;
        this._registration = ( this._vars.registration != null ) ? this._vars.registration : TOP_LEFT_REGISTRATION;

        //data
        this._data = ( data != null ) ? data : null;

        this._lowResImage = (this._data.loResImage != null) ? this._data.loResImage : null;
        this._zoomImage = (this._data.zoomImage != null) ? this._data.xoomImage : null;
        this.zoomValue = this._zoomMin = ( this._data.zoomMin != null) ? this._data.zoomMin : 1;
        this._zoomMax = ( this._data.zoomMax != null) ? this._data.zoomMax : 1;
        this._index = ( this._data.index != null) ? this._data.index : 0;

        _displayObjects = new Vector.<Sprite>();
        this._bounds = new Rectangle(0, 0, this._width, this._height);

        super(vars, data);
    }

    override public function commitProperties(event:Event = null):void {
        TweenPlugin.activate([TransformAroundPointPlugin]);
    }

    override public function draw():void {

        this._lowResImage.x = this._lowResImage.y = 0;
        this.addChild(this._lowResImage);
        _displayObjects.push(this._lowResImage);

        this._mask = this.createMask();
        this._mask.x = this._mask.y = 0;
        this.addChild(this._mask);
        _displayObjects.push(this._mask);

        this.mask = this._mask;

        this._callout = new Sprite();
        this._callout.x = this._callout.y = 0;
        this.addChild(this._callout);

    }

    override public function initialize():void {
        this.setRegistration();
    }


    private function createMask():Sprite {

        var sp:Sprite = new Sprite;
        sp.graphics.clear();
        sp.graphics.beginFill(0xFFFFFF, 1);
        sp.graphics.drawRect(0, 0, this._width, this._height);
        sp.graphics.endFill();

        return sp;
    }


    public function setHiResImage(value:String):void {

        var loader:ImageLoader = LoaderMax.getLoader(value);
        this._zoomImage = loader.content;

//        this.zoomValue = this._zoomMin = this._lowResImage.width / this._zoomImage.width;
//        this.zoomValue = this._zoomMin = Global.p.WIDTH / this._zoomImage.width + ZOOM_TOLERANCE;
        this.zoomValue = this._zoomMin = Global.p.WIDTH / this._zoomImage.width;

        this._zoomImage.scaleX = this._zoomImage.scaleY = this.zoomValue;

        this._zoomImage.x = this._zoomImage.y = 0;
        this.addChild(_zoomImage)
        this._displayObjects.push(this._zoomImage);

        this._zoomImage.visible = true;
        this._lowResImage.visible = false;

        this.swapChildren(this._callout, this._zoomImage);

        this.setUpThrowProps();
    }


    public function get zoomImage():DisplayObject {
        return _zoomImage;
    }

    public function get lowResImage():DisplayObject {
        return _lowResImage;
    }

    public function set lowResImage(value:DisplayObject):void {
        _lowResImage = value as Sprite;
    }


    public function get callout():Sprite {
        return _callout;
    }

    public function set callout(value:Sprite):void {
        _callout = value;
    }

    private function setRegistration():void {
        var i:int;
        var len:int = this._displayObjects.length;

        if (this._registration == CENTER_REGISTRATION) {
            for (i = 0; i < len; i++) {
                this._displayObjects[i].x = -this._width;
                this._displayObjects[i].y = -this._height;
            }
        }
    }

    public function removeLoResImage():void {
        this.removeChild(this._lowResImage);
        this.removeChild(this._mask);
    }

    private var zoomValue:Number;
    private var responsiveness:Number = .025;

    public function onZoomUpdate(_direction:Number):void {

        if (enabled) {
            this.disableNavThrowProps();
        }

        if (_direction == 1) {
            zoomValue += (responsiveness * zoomValue);
        }

        if (_direction == -1) {
            zoomValue -= (responsiveness * zoomValue);
        }


        if (zoomValue < this._zoomMin) {
            zoomValue = this._zoomMin;
        }

        if (zoomValue > this._zoomMax) {
            zoomValue = this._zoomMax;
        }

        this.scaleImage = this.zoomValue;


    }

    private function set scaleImage(zoomFactor:Number):void {


        TweenLite.to(this._zoomImage, (0), {
            transformAroundPoint: {point: new Point(this._bounds.width / 2, this._bounds.height / 2), scaleX: zoomFactor, scaleY: zoomFactor},
            ease: Linear.easeNone, onUpdate: this.checkBounds, onComplete: this.checkBounds});

    }

    public function reset():void {

        if (!this._zoomImage) {
            return;
        }

        TweenLite.to(this._zoomImage, (Global.t.TRANSITION), {
            transformAroundPoint: {point: new Point(this._bounds.width / 2, this._bounds.height / 2), scaleX: this._zoomMin, scaleY: this._zoomMin},
            ease: Linear.easeNone, onUpdate: this.checkBounds, onComplete: this.checkBounds});
    }


    private function get scaleImage():Number {
        return this._zoomImage.scaleX;
    }


    private const ZOOM_TOLERANCE:Number = .01;
    private const MOVE_TOLERANCE:Number = 10;
    private function checkBounds():void {

        if (this._zoomImage.x > this._bounds.x) {
            this._zoomImage.x = this._bounds.x;
        }

        if (this._zoomImage.y > this._bounds.y) {
            this._zoomImage.y = this._bounds.y;
        }

        if ((this._zoomImage.x + this._zoomImage.width + MOVE_TOLERANCE) < this._bounds.width) {
            this._zoomImage.x = this._bounds.width - this._zoomImage.width; //should be negative
        }

        if ((this._zoomImage.y + this._zoomImage.height + MOVE_TOLERANCE) < this._bounds.height) {
            this._zoomImage.y = this._bounds.height - this._zoomImage.height; //should be negative
        }

        if (this._zoomImage.scaleX <= (this._zoomMin + ZOOM_TOLERANCE) ) {
            this._zoomImage.scaleX = this._zoomImage.scaleY = this._zoomMin;
            this._zoomImage.x = this._bounds.x;
            this._zoomImage.y = this._bounds.y;
        }

        toggleCallout();
    }


    private function toggleCallout():void {

//        trace("scale check:::" + this._zoomImage.scaleX + " --> " + this._zoomMin);
        if (this._zoomImage.scaleX > this._zoomMin && this._calloutIsActive) {
            this._calloutIsActive = false;
            TweenMax.to(this._callout, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
        }

        if (this._zoomImage.scaleX <= (this._zoomMin + ZOOM_TOLERANCE) && !this._calloutIsActive) {
            this._calloutIsActive = true;
            TweenMax.to(this._callout, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
        }
    }




    public function zoomComplete():void {



        this.toggleHiResLoRes();
    }


    //Throw Props

    private function toggleHiResLoRes():void {
        if (zoomValue != _zoomMin) {
            this.enableNavThrowProps();
        }
    }

    private var enabled:Boolean = false;

    public function disableNavThrowProps():void {
        if (!enabled) {
            return;
        }
        enabled = false;
        ThrowPropsPlugin.untrack(this._zoomImage, "x,y");

        this._zoomImage.removeEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler);


    }

    public function enableNavThrowProps():void {
        if (enabled) {
            return;
        }
        enabled = true;
//        this._blitMask.enableBitmapMode();
        ThrowPropsPlugin.track(this._zoomImage, "x,y");


        this._zoomImage.addEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler, false, 0, true);
    }

    private function setUpThrowProps():void {

        enabled = true;
        this._lowResImage.visible = false;
        this._lowResImage.mouseEnabled = false;

        this._zoomImage.mouseEnabled = true;
        this._zoomImage.mouseChildren = false;

        this.enableNavThrowProps();

    }


    private function throwPropsMouseDownHandler(event:MouseEvent):void {
        TweenLite.killTweensOf(this._zoomImage);
        this._zoomImage.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.throwPropsMouseMoveHandler);
//        this._zoomImage.startDrag(false, new Rectangle(-99999, -99999, 99999999, 99999999));

        this._zoomImage.startDrag(false, new Rectangle(
                Global.p.WIDTH - this._zoomImage.width, //left bounds - negative value
                Global.p.HEIGHT - this._zoomImage.height, // top bounds - negative value
                this._zoomImage.width - Global.p.WIDTH, // right bounds
                this._zoomImage.height - Global.p.HEIGHT)); // bottom bounds
        this._zoomImage.stage.addEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);
    }

    private function throwPropsMouseMoveHandler(event:MouseEvent):void {
//        this.checkBounds();
    }

    private function throwPropsMouseUpHandler(event:MouseEvent):void {

        this._zoomImage.stage.removeEventListener(MouseEvent.MOUSE_MOVE, throwPropsMouseMoveHandler);
        this._zoomImage.stopDrag();

//        var xOverlap:Number = Math.max(0, this._zoomImage.width - this._bounds.width + MOVE_TOLERANCE);
        var xOverlap:Number = Math.abs(Global.p.WIDTH - this._zoomImage.width);
//        var yOverlap:Number = Math.max(0, this._zoomImage.height - this._bounds.height + MOVE_TOLERANCE);
        var yOverlap:Number = Math.abs(Global.p.HEIGHT - this._zoomImage.height);



        ThrowPropsPlugin.to(this._zoomImage, {ease: Strong.easeOut, onComplete: onThrowPropsComplete,
            throwProps: {
                x: {max: this._bounds.left, min: this._bounds.left - xOverlap, resistance: 500}, y: {max: this._bounds.top, min: this._bounds.top - yOverlap, resistance: 500}
            }}, 10, 0.25, 0);
    }

    private function onThrowPropsComplete():void {
        if (zoomValue == _zoomMin) {
            this._zoomImage.stage.removeEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);
            disableNavThrowProps();
        }

//        checkBounds();
    }


}
}
