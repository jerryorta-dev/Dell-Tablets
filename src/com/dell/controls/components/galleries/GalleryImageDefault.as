/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/15/13
 * Time: 9:01 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.galleries {
import com.dell.controls.Button_C_Factory;
import com.dell.controls.Display_UI_Factory;
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.image.ImageItem;
import com.dell.core.Global;
import com.dell.events.UIEvent;
import com.dell.graphics.components.core.utils.BitmapGrabber;
import com.dell.graphics.components.shapes.Rectangle;
import com.dell.graphics.data.RectangleVARS;
import com.greensock.BlitMask;
import com.greensock.TweenLite;
import com.greensock.easing.Strong;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.LoaderStatus;
import com.greensock.plugins.ThrowPropsPlugin;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

public class GalleryImageDefault extends AbstractUI {

    private var _loResLoaderName:String;
    private var _hiResLoaderName:String;

    private var _loResLoader:LoaderMax;
    private var _hiResLoader:LoaderMax;

    private var _container:Sprite;


    private var _gap:Number;

    private var _width:Number = 0;
    private var _height:Number = 0;

    private var _maskProps:RectangleVARS;
    private var _mask:Sprite;
    private var _blitMask:BlitMask;
    private var _throwPropsEnd:Array;

    private var _images:Vector.<ImageItem>;

    private var _index:int;

    private var _leftNavButton:AbstractButton;
    private var _rightNavButton:AbstractButton;

    public function GalleryImageDefault(vars:Object = null, data:Object = null) {


        this._vars = ( vars != null ) ? vars : null;
        this._data = ( data != null ) ? data : null;

        this._gap = ( this._vars.gap != null ) ? this._vars.gap : 10;
        this._loResLoaderName = data.loResImageLoader;
        this._hiResLoaderName = data.hiResImageLoader;

		//Only works in this location, not commitProperties
		this._bounds = new flash.geom.Rectangle(0, 0, this._vars.width, this._vars.height);

        super(vars, data);
    }

    override public function commitProperties(event:Event = null):void {
        
        this._maskProps = new RectangleVARS();
        this._maskProps.width( this._bounds.width).height( this._bounds.height).x( 0).y(0).fillColor(0xffffff).fillAlpha(1);
        this._loResLoader = LoaderMax.getLoader(this._loResLoaderName);
        this._hiResLoader = LoaderMax.getLoader(this._hiResLoaderName);
        this._throwPropsEnd = new Array();
        this._images = new Vector.<ImageItem>();

    }

    override public function draw():void {

        this._mask = new com.dell.graphics.components.shapes.Rectangle( this._maskProps );

        this.addChild( this._mask );

        this._container = new Sprite;
        this._container.x = this._container.y = 0;
        this.addChild(this._container);

        const buttonFactory:AbstractButtonFactory = new Button_C_Factory();

        const leftNavVars:Object = {};
        leftNavVars.width = 100;
        leftNavVars.height = Global.p.HEIGHT;
        this._leftNavButton = buttonFactory.add("leftNav", Button_C_Factory.GALLERY_NAV_OVER_IMAGE_LEFT, this, 0, 0, leftNavVars);
        this._leftNavButton.addEventListener(MouseEvent.CLICK, this.navLeftMouseHandler, false, 0, true);
        this._leftNavButton.visible = false;

        this._leftNavButton.buttonMode = true;
        this._leftNavButton.useHandCursor = true;
        this._leftNavButton.mouseChildren = false;

        const rightNavVars:Object = {};
        rightNavVars.width = 100;
        rightNavVars.height = Global.p.HEIGHT;
        this._rightNavButton = buttonFactory.add("rightNav", Button_C_Factory.GALLERY_NAV_OVER_IMAGE_RIGHT, this, (Global.p.WIDTH - rightNavVars.width), 0, rightNavVars);
        this._rightNavButton.addEventListener(MouseEvent.CLICK, this.navRightMouseHandler, false, 0, true);

        this._rightNavButton.buttonMode = true;
        this._rightNavButton.useHandCursor = true;
        this._rightNavButton.mouseChildren = false;
    }

    override public function initialize():void {
        if (this._loResLoader.status == LoaderStatus.COMPLETED) {
            loResLoaded(null);
        } else {
            this._loResLoader.prioritize(true);
            this._loResLoader.addEventListener(LoaderEvent.COMPLETE, loResLoaded, false, 0, true);
        }
    }


    private function loResLoaded(event:LoaderEvent = null):void {
        this.dispatchEvent(new UIEvent(UIEvent.LO_RES_IMAGE_LOADED, null));

        if (event) {
            this._loResLoader.removeEventListener(LoaderEvent.COMPLETE, loResLoaded);
        }

//        this._hiResLoader.prioritize(true);
//        this._hiResLoader.addEventListener(LoaderEvent.COMPLETE, this.hiResLoaded, false, 0, true);

        const len:int = this._loResLoader.numChildren;

        var currentXPos:Number = 0;

        for (var i:int = 0; i < len; i++) {

            var rawImage:DisplayObject = this._loResLoader.getContent(this._loResLoaderName + i);

            var imageVars:Object = {};
            imageVars.width = rawImage.width;
            imageVars.height = rawImage.height;
            imageVars.registration = ImageItem.TOP_LEFT_REGISTRATION;
			imageVars.smoothing = true;

            var imageData:Object = {};
            imageData.index = i;
            imageData.zoomMin = this._hiResLoader.vars.zoomMin;
            imageData.zoomMax = 1;
            imageData.loResImage = rawImage;
			imageData.smoothing = true;

            var img:ImageItem = new Display_UI_Factory().add(Display_UI_Factory.IMAGE_WITH_ZOOM, this._container, currentXPos, 0, imageVars, imageData) as ImageItem;
            this._throwPropsEnd.push(-currentXPos);
            currentXPos += rawImage.width + this._gap;

            this._width = ( rawImage.width > this._width ) ? rawImage.width : this._width;
            this._height = ( rawImage.height > this._height ) ? rawImage.height : this._height;

			
            this._container.addChild(img);
            this._images.push(img);
        }

        this._bounds = new flash.geom.Rectangle(0, 0, this._width, this._height);

        this.setUpThrowProps();
        this.onThrowPropsComplete();
    }

    public function setHiResImages():void {
//        this.dispatchEvent(new UIEvent(UIEvent.HI_RES_IMAGE_LOADED, null));


        const len:int = this._hiResLoader.numChildren;
        for (var i:int = 0; i < len; i++) {
            this._images[i].setHiResImage( this._hiResLoaderName + i );


//            this._images[i].lowResImage.visible = false;
//            this._images[i].removeLoResImage();
        }

//        this._blitMask.disableBitmapMode();
    }


    public function navLeftMouseHandler(event:MouseEvent):void {
//        updateBlitmask();
        if (this._index > 0) {
            this._index = this._index - 1;
        } else {
            this._index = 0; //not really necessary
        }

//        TweenLite.to(this._container, Global.t.TRANSITION, {x: this._throwPropsEnd[ this._index ], onUpdate: this._blitMask.update, ease: Global.t.EASE, onComplete: onThrowPropsComplete});
        TweenLite.to(this._container, Global.t.TRANSITION, {x: this._throwPropsEnd[ this._index ], ease: Global.t.EASE, onComplete: onThrowPropsComplete});
    }

    public function navRightMouseHandler(event:MouseEvent):void {
//        this._blitMask.enableBitmapMode();
        if (this._index < (this._throwPropsEnd.length - 1)) {
            this._index = this._index + 1;
        } else {
            this._index = this._throwPropsEnd.length - 1;
        }

//        TweenLite.to(this._container, Global.t.TRANSITION, {x: this._throwPropsEnd[ this._index ], onUpdate: this._blitMask.update, ease: Global.t.EASE, onComplete: onThrowPropsComplete})
        TweenLite.to(this._container, Global.t.TRANSITION, {x: this._throwPropsEnd[ this._index ], ease: Global.t.EASE, onComplete: onThrowPropsComplete});
    }

    private function changeNavButtonState():void {
        this._blitMask.enableBitmapMode();
        if (this._index == 0) {
            TweenLite.to(this._leftNavButton, Global.t.TRANSITION, {alpha: 0, ease: Global.t.EASE});
            TweenLite.to(this._rightNavButton, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE});
            this._leftNavButton.visible = false;
            this._rightNavButton.visible = true;
            return;
        }

        if (this._index == this._throwPropsEnd.length - 1) {
            TweenLite.to(this._leftNavButton, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE});
            TweenLite.to(this._rightNavButton, Global.t.TRANSITION, {alpha: 0, ease: Global.t.EASE});
            this._leftNavButton.visible = true;
            this._rightNavButton.visible = false;
            return;
        }

        TweenLite.to(this._leftNavButton, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE});
        TweenLite.to(this._rightNavButton, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE});
        this._leftNavButton.visible = true;
        this._rightNavButton.visible = true;
    }


//Throw Props


    public function onZoomComplete():void {
//        updateBlitmask();
        this._images[ this._index ].zoomComplete();
        enabled = true;
    }



    private var enabled:Boolean;
    public function set zoom(zoomFactor:Number):void {
        if (enabled) {
            this.disableThrowPropsBitMask();
        }

        this._images[ this._index ].onZoomUpdate(zoomFactor);

    }


    private function disableThrowPropsBitMask():void {
        enabled = false;
        this._blitMask.dispose();
        this._blitMask.removeEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler);
        this._container.mask = this._mask;
        this._container.mouseEnabled = false;
        this._container.mouseChildren  = true;
    }



    public function updateBlitmask():void {

        this._blitMask.dispose();
        this._images[ this._index ].lowResImage = new Bitmap( BitmapGrabber.grab( this._images[ this._index ].zoomImage, this._bounds, true ) );
        this._blitMask = new BlitMask(this._container, this._bounds.x, this._bounds.y, this._bounds.width, this._bounds.height, true, true);
       this.enableNavThrowProps();
    }

    public function disableNavThrowProps():void {
        enabled = false;
        this._blitMask.dispose();
        ThrowPropsPlugin.untrack(this._container, "x");
        this._blitMask.removeEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler);
    }

    public function enableNavThrowProps():void {
        enabled = true;
        this._blitMask.enableBitmapMode();
        ThrowPropsPlugin.track(this._container, "x");
        this._blitMask.addEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler, false, 0, true);
    }


    private function setUpThrowProps():void {
        this._container.mouseEnabled = true;
        this._container.mouseChildren = false;

        this._blitMask = new BlitMask(this._container, this._bounds.x, this._bounds.y, this._bounds.width, this._bounds.height, true, true);

        this.enableNavThrowProps();

    }

    private function throwPropsMouseDownHandler(event:MouseEvent):void {
//        trace( "thowPropsMouseDownHandler");
//        this.enableBitmapMode();
        TweenLite.killTweensOf(this._container);
        this._container.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.throwPropsMouseMoveHandler);
        this._container.startDrag(false, new flash.geom.Rectangle(-99999, this._bounds.y, 99999999, 0));
        this._container.stage.addEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);
    }

    private function throwPropsMouseMoveHandler(event:MouseEvent):void {
        this._blitMask.update();
        event.updateAfterEvent();
    }

    private function throwPropsMouseUpHandler(event:MouseEvent):void {
        this._container.stage.removeEventListener(MouseEvent.MOUSE_UP, throwPropsMouseUpHandler);
        this._container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this._blitMask.update);
        this._container.stopDrag();

        var xOverlap:Number = Math.max(0, this._container.width - this._bounds.width);
        ThrowPropsPlugin.to(this._container, {ease: Strong.easeOut, throwProps: {x: {max: this._bounds.left, min: this._bounds.left - xOverlap, resistance: 500, end: this._throwPropsEnd}}, onComplete: this.onThrowPropsComplete, onUpdate: this._blitMask.update}, 10, 0.25, 1);
    }

    private function onThrowPropsComplete():void {
        this._index = this.throwPropsGetIndex();
        this.dispatchEvent(new UIEvent(UIEvent.GALLERY_IMAGE_CHANGE, this._index));
        this.changeNavButtonState();

    }

    private function throwPropsGetIndex():int {

        var tolerance:int = 10;

        var len:int = this._throwPropsEnd.length;
        for (var i:int = 0; i < len; i++) {
            if (this._container.x > (this._throwPropsEnd[i] - tolerance) && this._container.x < (this._throwPropsEnd[i] + tolerance)) {
                return i;
                break;
            }
        }

        return 0;

    }

    //HELPER FUNCTIONS

    private function setMaskToImage():void {



    }

    public function get index():int {
        return _index;
    }

    public function set index(value:int):void {
        _index = value;
        TweenLite.to(this._container, Global.t.TRANSITION, {x: this._throwPropsEnd[ this._index ], onUpdate: this._blitMask.update, ease: Global.t.EASE, onComplete: this.changeNavButtonState});
    }
}
}
