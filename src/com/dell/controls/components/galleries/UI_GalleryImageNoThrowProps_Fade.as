/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/15/13
 * Time: 9:01 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.galleries {
import com.dell.controls.Button_C_Factory;
import com.dell.controls.Callout_C_Factory;
import com.dell.controls.Display_UI_Factory;
import com.dell.controls.components.buttons.galleries.GalleryNavOverImageLeft;
import com.dell.controls.components.buttons.galleries.GalleryNavOverImageRight;
import com.dell.controls.components.callouts.C_Callout_Rectangle_Header_Copy;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;
import com.dell.controls.components.core.abstract.AbstractCalloutParams;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.image.ImageItem;
import com.dell.core.Global;
import com.dell.data.CalloutVARS;
import com.dell.events.UIEvent;
import com.dell.graphics.components.shapes.Rectangle;
import com.dell.graphics.data.CalloutGraphicVARS;
import com.dell.graphics.data.RectangleVARS;
import com.greensock.BlitMask;
import com.greensock.TweenLite;
import com.greensock.easing.Strong;
import com.greensock.loading.LoaderMax;
import com.greensock.plugins.AutoAlphaPlugin;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import project_tablets_1297.text.gallery.Gallery_Callout_Copy;
import project_tablets_1297.text.gallery.Gallery_Callout_Header;

public class UI_GalleryImageNoThrowProps_Fade extends AbstractUI {

    private var _loResLoaderName:String;
    private var _hiResLoaderName:String;

    private var _loResLoader:LoaderMax;
    private var _hiResLoader:LoaderMax;


    private var _gap:Number;

    private var _width:Number = 0;
    private var _height:Number = 0;

    private var _maskProps:RectangleVARS;

    private var _throwPropsEnd:Array;

    private var _images:Vector.<ImageItem>;

    private var _index:int;
    private var _previousIndex:int;

    private var _container:Sprite;
    private var _leftNavButton:GalleryNavOverImageLeft;
    private var _rightNavButton:GalleryNavOverImageRight;
    private var _mask:Sprite;
    private var _blitMask:BlitMask;

    private var _lowResLoaded:Boolean = false;
    private var _hiResLoaded:Boolean = false;

    private var _rangeOfData:int;

    private var _tackZoomItemHasTracked:Dictionary;

    public function UI_GalleryImageNoThrowProps_Fade(vars:Object = null, data:Object = null) {

        super(vars, data);
        this.name = "UI_IMAGE_GALLERY_NO_THROW_PROPS";

    }

    override public function commitProperties(event:Event = null):void {

        TweenPlugin.activate([ AutoAlphaPlugin ])

        this._gap = ( this._vars.gap != null ) ? this._vars.gap : 20;
        this._loResLoaderName = this._vars.loResImageLoader;
        this._hiResLoaderName = this._vars.hiResImageLoader;

        //Only works in this location, not commitProperties
        this._bounds = new flash.geom.Rectangle(0, 0, this._vars.width, this._vars.height);

        this._maskProps = new RectangleVARS();
        this._maskProps.width(this._bounds.width).height(this._bounds.height).x(0).y(0).fillColor(0xffffff).fillAlpha(1);
        this._loResLoader = LoaderMax.getLoader(this._loResLoaderName);
        this._hiResLoader = LoaderMax.getLoader(this._hiResLoaderName);
        this._throwPropsEnd = new Array();
        this._images = new Vector.<ImageItem>();

        //TODO use Math.min( xml , config loader numChildren);
        this._rangeOfData = Global.data.copy.screen[ this._data.screenIndex ].slides.length;

        _tackZoomItemHasTracked = new Dictionary();

    }

    override public function draw():void {

        this._mask = new com.dell.graphics.components.shapes.Rectangle(this._maskProps);


        this.addChild(this._mask);

        this._container = new Sprite;
        this._container.x = this._container.y = 0;
        this.addChild(this._container);


        const buttonFactory:AbstractButtonFactory = new Button_C_Factory();

        const yPos:Number = ( Global.p.HEIGHT - 100 ) /2;

        const leftNavVars:Object = {};
        leftNavVars.width = 100;
        leftNavVars.height = 100;
        this._leftNavButton = buttonFactory.add("leftNav", Button_C_Factory.GALLERY_NAV_OVER_IMAGE_LEFT, this, 205, yPos, leftNavVars, this._data) as GalleryNavOverImageLeft;
        this._leftNavButton.text = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.title;
        this._leftNavButton.visible = true;

        this._leftNavButton.buttonMode = true;
        this._leftNavButton.useHandCursor = true;
        this._leftNavButton.mouseChildren = true;

        const rightNavVars:Object = {};
        rightNavVars.width = 100;
        rightNavVars.height = 100;
        this._rightNavButton = buttonFactory.add("rightNav", Button_C_Factory.GALLERY_NAV_OVER_IMAGE_RIGHT, this, (Global.p.WIDTH - rightNavVars.width), yPos, rightNavVars, this._data) as GalleryNavOverImageRight;
        this._rightNavButton.text = Global.data.copy.screen[ this._data.screenIndex ].slides[  1 ].headline;

        this._rightNavButton.buttonMode = true;
        this._rightNavButton.useHandCursor = true;
        this._rightNavButton.mouseChildren = true;
    }

    override public function initialize():void {

        this.setUpLoResImages();
        this.activateComposite();
    }

    override public function activateComposite():Boolean {
        this._leftNavButton.addEventListener(MouseEvent.CLICK, this.navFirstLeftCarrotMoustHandler, false, 0, true);
        this._rightNavButton.addEventListener(MouseEvent.CLICK, this.navRightMouseHandler, false, 0, true);

        super.activateComposite();
        return true;
    }

    override public function deactivateComposite():Boolean {

        this._leftNavButton.removeEventListener(MouseEvent.CLICK, this.navFirstLeftCarrotMoustHandler);
        this._rightNavButton.removeEventListener(MouseEvent.CLICK, this.navRightMouseHandler);

        super.deactivateComposite();
        return true;
    }


    override public function disposeComposite():Boolean {
        this.removeChild(_container);
        this.removeChild(_leftNavButton);
        this.removeChild(_rightNavButton);
        this.removeChild(_mask);
        this.removeChild(_blitMask);

        _container = null;
        _leftNavButton = null;
        _rightNavButton = null;
        _mask = null;
        _blitMask = null;

        super.disposeComposite();
        return true;
    }


    public function setUpLoResImages():void {
        _lowResLoaded = true;

        Global.setDebuggerColor(0x0babee);
        Global.setDebuggerLabel("Low Res Gallery Images");
        Global.setDebuggerPerson("LoaderMax SWF Content");

//        const len:int = this._loResLoader.numChildren;
//        const len:int = Global.data.copy.screen[ this._data.screenIndex ].slides.length;

        var currentXPos:Number = 0;

        var calloutParams:Object = textBoxParams();


        for (var i:int = 0; i < this._rangeOfData; i++) {

            _tackZoomItemHasTracked[i] = false;

            var rawImage:DisplayObject = this._loResLoader.getContent(this._loResLoaderName + i);

            var imageVars:Object = {};
            imageVars.width = this._vars.width;
            imageVars.height = this._vars.height;
            imageVars.registration = ImageItem.TOP_LEFT_REGISTRATION;

            var imageData:Object = {};
            imageData.index = i;
            imageData.zoomMin = this._hiResLoader.vars.zoomMin;
            imageData.zoomMax = 1;
            imageData.loResImage = rawImage;

            var img:ImageItem = new Display_UI_Factory().add(Display_UI_Factory.IMAGE_WITH_ZOOM, this._container, 0, 0, imageVars, imageData) as ImageItem;
            this._throwPropsEnd.push(-currentXPos);

//            currentXPos += rawImage.width + this._gap;

            this._width = ( rawImage.width > this._width ) ? rawImage.width : this._width;
            this._height = ( rawImage.height > this._height ) ? rawImage.height : this._height;

            this._container.addChild(img);
            this._images.push(img);

            if (i == 0 ) {
                img.alpha = 1;
                img.visible = true;
            } else {
                img.alpha = 0;
                img.visible = false;
            }



            /*

             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].id );
             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].x );
             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].y );
             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].color );
             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].textBoxWidth );
             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].headline );
             trace( Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].subhead );
             */

//            calloutParams.textFieldHeaderParams.text = "TEST TEST TEST";

//            trace( Global.data.copy.screen[ this._data.screenIndex ].slides.length );

            if (i < this._rangeOfData) {

                //TODO find a way to simplify this
                calloutParams.textFieldHeaderParams.text = Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].headline;

                //(calloutParams.textFieldHeaderParams as AbstractTextFieldParams).color = Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].color;
				
				calloutParams.textFieldHeaderParams.embeddedFontFormat.color =
					Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].color;
				
				calloutParams.textFieldHeaderParams.noFontTextFormat.color
					= Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].color;
				

                calloutParams.textFieldCopyParams.text = Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].subhead;
                (calloutParams.callOutVars as CalloutVARS).width(Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].callOutWidth);
                (calloutParams.calloutGraphicVars as CalloutGraphicVARS).fillAlpha(Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].backgroundAlpha);

                var callout:C_Callout_Rectangle_Header_Copy = new Callout_C_Factory().add(
                        Callout_C_Factory.CALLOUT_HEADER_COPY,
                        img.callout,
                        Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].x,
                        Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].y,
                        calloutParams) as C_Callout_Rectangle_Header_Copy;

            }

        }

        this._bounds = new flash.geom.Rectangle(0, 0, this._width, this._height);

//        this.setUpThrowProps();
        this.onThrowPropsComplete();
    }


    public function setUpHiResImages():void {

//		_hiResLoaded = true;
//		this.eventDispatcher(new UIEvent(UIEvent.HI_RES_IMAGE_LOADED, null));

//        const len:int = this._hiResLoader.numChildren;
        for (var i:int = 0; i < this._rangeOfData; i++) {
            this._images[i].setHiResImage(this._hiResLoaderName + i);
//            trace( this._hiResLoaderName + i);
        }

    }


    public function navFirstLeftCarrotMoustHandler(event:MouseEvent):void {
//        updateBlitmask();
//        this._previousIndex = this._index;
//        this._blitMask.enableBitmapMode();
        this._images[ this._index ].reset();
//        this.updateBlitmask();
        if (this._index == 0) {
            this.eventDispatcher(new UIEvent(UIEvent.GALLERY_FIRST_LEFT_CARROT_SELECT, "360"));
            return;
        }


        if (this._index > 0) {
            this._index = this._index - 1;
        } else {
            this._index = 0; //not really necessary
        }

        if ( Global.p.OMNITURE_TRACK_IMAGE_GALLERY_CARROT_NAV ) {
            Global.trackMetrics("image", Global.navItemName + "_image_" + this._index) ;
        }

        this.updateText(this._index);

        this.fadeImageOut();
    }


    public function navRightMouseHandler(event:MouseEvent):void {
        this._previousIndex = this._index;

//        updateBlitmask();
        this._images[ this._index ].reset();
//        this._blitMask.enableBitmapMode();
//        this.updateBlitmask();

        if (this._index < (this._throwPropsEnd.length - 1)) {
            this._index = this._index + 1;
        } else {
            this._index = this._throwPropsEnd.length - 1;
        }

        //TRACK

        if ( Global.p.OMNITURE_TRACK_IMAGE_GALLERY_CARROT_NAV ) {
            Global.trackMetrics("image", Global.navItemName + "_image_" + this._index) ;
        }


        this.updateText(this._index);
        this.fadeImageOut();
    }

    private function fadeImageOut():void {
        const len:int = _images.length;
        for ( var i:int = 0; i < len; i++) {
            TweenLite.to(this._images[i], Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
        }

        TweenLite.delayedCall( Global.t.TRANSITION +.05, this.fadeImageIn);


    }

    private function fadeImageIn():void {
        TweenLite.to(this._images[ this._index], Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE, onComplete: onThrowPropsComplete});
    }


    private function updateText(_index:int):void {
        var left:int, right:int;

        var min:int = 0;
        var max:int = this._throwPropsEnd.length - 1;


        if (_index > min) {
            left = _index - 1;
        } else {
            left = min;
        }

        if (_index < max) {
            right = _index + 1;
        } else {
            right = max;
        }
        
        this._rightNavButton.text = Global.data.copy.screen[ this._data.screenIndex ].slides[  right ].headline;

        //Back to 360
        if (this._index == 0) {
            this._leftNavButton.text = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.title;
        } else {
            this._leftNavButton.text = Global.data.copy.screen[ this._data.screenIndex ].slides[ left ].headline;
        }

    }


    private function changeNavButtonState():void {
//        this._blitMask.enableBitmapMode();
        if (this._index == 0) {
//            TweenLite.to(this._leftNavButton, Global.t.TRANSITION, {alpha: 0, ease: Global.t.EASE});  //art direction change... neeed to nav back back to 360
            TweenLite.to(this._rightNavButton, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE});
            this._leftNavButton.visible = true; //art direction change... neeed to nav back back to 360
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

        this._images[ this._index ].zoomComplete();

        if ( Global.p.OMNITURE_TRACK_ZOOM_CONTINUOUS ) {
            Global.trackMetrics( "zoom", Global.navItemName + "_Image_" + this._index + "_Zoom" );
        }

//        trace ( !this._tackZoomItemHasTracked[this._index] );

        if ( Global.p.OMNITURE_TRACK_ZOOM_ONCE && !this._tackZoomItemHasTracked[this._index] && !Global.p.OMNITURE_TRACK_ZOOM_CONTINUOUS ) {
            this._tackZoomItemHasTracked[ this._index ] = true;
            Global.trackMetrics( "zoom", Global.navItemName + "_Image_" + this._index + "_Zoom" );
        }

    }


    private var enabled:Boolean;

    public function set onZoomUpdate(zoomFactor:Number):void {
//        if (enabled) {
        this.disableThrowPropsBitMask();
//        }

        this._images[ this._index ].onZoomUpdate(zoomFactor);

    }


    private function disableThrowPropsBitMask():void {
        enabled = false;
//        this._blitMask.dispose();
//        this._blitMask.removeEventListener(MouseEvent.MOUSE_DOWN, throwPropsMouseDownHandler);
        this._container.mask = this._mask;
        this._container.mouseEnabled = false;
        this._container.mouseChildren = true;
    }


    private function throwPropsMouseDownHandler(event:MouseEvent):void {

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
//        this._images[ this._previousIndex ].reset();

//        this._index = this.throwPropsGetIndex();
        this.dispatchEvent(new UIEvent(UIEvent.GALLERY_IMAGE_CHANGE, this._index));
        this.changeNavButtonState();
//        this._blitMask.disableBitmapMode();
//        this.updateBlitmask();
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



    public function get index():int {
        return _index;
    }

    public function reset():void {

        this.index = 0;

    }

    public function set index(value:int):void {

        if ( value == this._index ) {
            return;
        }

        //Reset Image
        if (this._images[ this._index] != null) {
            this._images[ this._index ].reset();
        }

        _index = value;
        this.updateText(value);
//        TweenLite.to(this._container, Global.t.TRANSITION, {x: this._throwPropsEnd[ this._index ], onUpdate: this._blitMask.update, ease: Global.t.EASE, onComplete: this.changeNavButtonState});
        this.fadeImageOut();
    }


    ///TEXTFIELD
    private function textBoxParams():Object {
        var o:Object = {};

        var _headerParams:AbstractTextFieldParams = new Gallery_Callout_Header();
        o.textFieldHeaderParams = _headerParams;

        //Where text color is mapped
//        o.textFieldHeaderParams.embeddedFontFormat.color = 0x990000;
//        o.textFieldHeaderParams.noFontTextFormat.color = 0x990000;
//        trace( _headerParams.text );

        var _copy:AbstractTextFieldParams = new Gallery_Callout_Copy();
        o.textFieldCopyParams = _copy;


        var _calloutGraphicVars:CalloutGraphicVARS = new CalloutGraphicVARS();
        _calloutGraphicVars.arrowWidth(0);
        _calloutGraphicVars.arrowHeight(0);
        _calloutGraphicVars.borderColor(0xffffff);
        _calloutGraphicVars.borderWeight(0);

        _calloutGraphicVars.arrowCentered(true);
        _calloutGraphicVars.rectangleRadiusArray(new <Number>[8, 8, 8, 8]);
        _calloutGraphicVars.arrowRadiusArray(new <Number>[0, 0, 0]);
        //_calloutGraphicVars.arrowDirection( AbstractCalloutParams.ARROW_POSITION_TOP );
        o.calloutGraphicVars = _calloutGraphicVars;

        var _callOutFunctionVars:CalloutVARS = new CalloutVARS();
        //Callout functionality
        //_callOutFunctionVars.width(120);
        //_calloutVars.minHeight(55);
        //_calloutVars.height( 66 );
        //Callout will expand horizontally if text requires more room.
        //Should only set maxWidth or maxHeight, but not both.
        //Should be opposite of width or height setting
        //TODO  not sure if this is needed
        //callOutFunctionalty.maxHeight( 100 );

        //With variable text, which way should the callout expand.
        _callOutFunctionVars.expandDirection(AbstractCalloutParams.EXPAND_VERTICALLY);

        //Set text to have max number of lines
        //_callOutFunctionVars.textMaxLines( 2 );

        _callOutFunctionVars.padding(20);
        _callOutFunctionVars.paddingBottom(20);
        //_calloutVars.paddingTop( 12 );
        _callOutFunctionVars.registration(AbstractCalloutParams.REGISTER_TOP_LEFT);
        o.callOutVars = _callOutFunctionVars;

        return o;

    }
}
}
