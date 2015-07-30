/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/16/13
 * Time: 3:10 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.screens.lib {
import com.dell.controls.Button_C_Factory;
import com.dell.controls.Callout_C_Factory;
import com.dell.controls.Display_UI_Factory;
import com.dell.controls.Gallery_UI_Factory;
import com.dell.controls.List_UI_Factory;
import com.dell.controls.ProgressBar_UI_Factory;
import com.dell.controls.Scrubber_MVC_Factory;
import com.dell.controls.UIFactory;
import com.dell.controls.Zoom_UI_Factory;
import com.dell.controls.components.buttons.galleries.GalleryNavOverImageRight;
import com.dell.controls.components.callouts.C_Callout_Rectangle_Header_Copy;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;
import com.dell.controls.components.core.abstract.AbstractCalloutParams;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.controls.components.galleries.UI_GalleryImageNoThrowProps_Fade;
import com.dell.controls.components.image.SWF360Item;
import com.dell.controls.components.lists.lib.List_UI_Button_GalleryNav;
import com.dell.controls.components.lists.lib.List_UI_Button_Rotate360Gallery;
import com.dell.controls.components.progressBars.ProgressBar_UI_Default;
import com.dell.controls.components.scrubbers.lib.UI_MVC_ScrubberDefault;
import com.dell.core.Global;
import com.dell.data.CalloutVARS;
import com.dell.events.UIEvent;
import com.dell.graphics.CommonElementsGraphicFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.AbstractGraphicFactory;
import com.dell.graphics.data.CalloutGraphicVARS;
import com.dell.graphics.data.RectangleVARS;
import com.dell.loading.abstract.LoaderMaxHelper;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.LoaderStatus;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import project_tablets_1297.Track_Tablets1297;
import project_tablets_1297.text.gallery.R360_Callout_Copy;
import project_tablets_1297.text.gallery.R360_Callout_Header;

public class UI_Gallery360ZoomScreen_FLAT extends AbstractUI implements IUI {

    //VISUAL ASSETS FROM XML
    private var _visual_Image_Gallery:UI_GalleryImageNoThrowProps_Fade;
    private var _visual_SWF360:SWF360Item;

    //GRAPHIC ELEMENTS
    private var _ui_ROOT_and_background:AbstractUI;
    private var _ui_divider1:AbstractGraphic;
    private var _ui_divider2:AbstractGraphic;

    //UI COMPONENTS
    private var _ui:AbstractUI; //delete
    public var _ui_scrubber:UI_MVC_ScrubberDefault;
    public var _ui_buttons_Gallery_360:AbstractUI;
    public var _ui_buttons_gallery_Nav:AbstractUI;


    //LoaderMax Loaders
    private var _loResImageLoader:LoaderMax;
    private var _hiResImageLoader:LoaderMax;
    private var _loResSWFLoader:LoaderMax;
    private var _hiResSWFLoader:LoaderMax;
    private var _allLoResLoader:LoaderMax;

    private var _screenProgressBarVars:Object;
    private var _ui_zoom_progressBarVars:Object;
    private var _screenProgressBar:ProgressBar_UI_Default;
    private var _ui_zoomProgressBar:ProgressBar_UI_Default;

    private const UI_ZOOM_OFF_ALPHA:Number = .4;
    public var _ui_buttons_zoom:AbstractUI;
    private var _zoomPointNotLoaded:Point = new Point(397, 3);
    private var _zoomPointLoaded:Point = new Point(397, 7);
    private var _hiResSWFLoaded:Boolean = false;
    private var _hiResImagesLoaded:Boolean = false;

    private var _rightNavButton:GalleryNavOverImageRight;

    //TEXT
    private var callout:C_Callout_Rectangle_Header_Copy;


    /**
     * Since LoaderMax calls COMPLETE twice, this prevents building the UI twice.
     */
    private var _uiIsBuilt:Boolean = false;


    public function UI_Gallery360ZoomScreen_FLAT(vars:Object = null, data:Object = null) {

        super(vars, data);
        this.name = "UI_GALLERY_360_FLAT";

        this._vars = ( vars != null ) ? vars : null;
        this._data = ( data != null ) ? data : null;

    }

    override public function commitProperties(event:Event = null):void {

//        this.screenIndex = this._data.screenIndex;

        _screenProgressBarVars = {};
        _screenProgressBarVars.backgroundVars = new RectangleVARS().width(200).height(20).radius(10).fillColor(0xebebeb);
        _screenProgressBarVars.progressBarVars = new RectangleVARS(_screenProgressBarVars.backgroundVars).fillColor(0x0085c3);

        _ui_zoom_progressBarVars = {};
        _ui_zoom_progressBarVars.backgroundVars = new RectangleVARS().width(55).height(5).radius(3).fillColor(0xebebeb);
        _ui_zoom_progressBarVars.progressBarVars = new RectangleVARS(_ui_zoom_progressBarVars.backgroundVars).fillColor(0x0085c3);

        this._loResImageLoader = LoaderMax.getLoader(this._vars.loResImageLoader);
        this._loResSWFLoader = LoaderMax.getLoader(this._vars.loResSWF360Loader);
        this._hiResImageLoader = LoaderMax.getLoader(this._vars.hiResImageLoader);
        this._hiResSWFLoader = LoaderMax.getLoader(this._vars.hiResSWF360Loader);
        this._allLoResLoader = LoaderMax.getLoader(this._vars.allLoResLoader);

        this._vars.width = Global.p.WIDTH;
        this._vars.height = Global.p.HEIGHT;

    }

    override public function draw():void {

        _screenProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, this, 382, 240, _screenProgressBarVars) as ProgressBar_UI_Default;
        _screenProgressBar.alpha = 0;
        _screenProgressBar.visible = false;
//        TweenMax.to(this._screenProgressBar, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
    }

    override public function initialize():void {


    }


    private function loadLoResAssets(event:LoaderEvent = null):void {

        if (!LoaderMaxHelper.loaderHasContent(this._loResImageLoader.getChildAt(0)) && !LoaderMaxHelper.loaderHasContent(this._loResSWFLoader.getChildAt(0))) {
            _allLoResLoader.prioritize();
            this._allLoResLoader.addEventListener(LoaderEvent.COMPLETE, this.hideProgressBar, false, 0, true);
            this._allLoResLoader.addEventListener(LoaderEvent.PROGRESS, this._screenProgressBar.progress, false, 0, true);
        } else {
            this.buildScreen(null);
            this.buildScreen(null);
        }

    }

    private function loadHiResSwf():void {

//        if (!LoaderMaxHelper.loaderHasContent(this._hiResSWFLoader.getChildAt(0)) && !this._hiResSWFLoaded) {
        if ((this._hiResSWFLoader.status != LoaderStatus.COMPLETED) && !this._hiResSWFLoaded) {

            TweenLite.to(this._ui_buttons_zoom, Global.t.TRANSITION, {alpha: this.UI_ZOOM_OFF_ALPHA, x: _zoomPointNotLoaded.x, y: _zoomPointNotLoaded.y, ease: Global.t.EASE});
            this._ui_buttons_zoom.deactivateComposite();
            TweenLite.to(this._ui_zoomProgressBar, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE });

            _hiResSWFLoader.prioritize();
            this._hiResImageLoader.removeEventListener(LoaderEvent.PROGRESS, this._ui_zoomProgressBar.progress);
            this._hiResSWFLoader.addEventListener(LoaderEvent.COMPLETE, this.hiResSWFLoadedHandler, false, 0, true);
            this._hiResSWFLoader.addEventListener(LoaderEvent.PROGRESS, this._ui_zoomProgressBar.progress, false, 0, true);

        } else {
            this.hiResSWFLoadedHandler(null);
        }

    }


    private function loadHiResImages():void {

//        if (!LoaderMaxHelper.loaderHasContent(this._hiResImageLoader.getChildAt(0)) && !this._hiResImagesLoaded) {
        if ((this._hiResImageLoader.status != LoaderStatus.COMPLETED) && !this._hiResImagesLoaded) {

            TweenLite.to(this._ui_buttons_zoom, Global.t.TRANSITION, {alpha: this.UI_ZOOM_OFF_ALPHA, x: _zoomPointNotLoaded.x, y: _zoomPointNotLoaded.y, ease: Global.t.EASE});
            this._ui_buttons_zoom.deactivateComposite();
            TweenLite.to(this._ui_zoomProgressBar, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE });

            this._hiResImageLoader.prioritize();
            this._hiResSWFLoader.removeEventListener(LoaderEvent.PROGRESS, this._ui_zoomProgressBar.progress );
            this._hiResImageLoader.addEventListener(LoaderEvent.COMPLETE, this.hiResImageLoaderHandler, false, 0, true);
            this._hiResImageLoader.addEventListener(LoaderEvent.PROGRESS, this._ui_zoomProgressBar.progress, false, 0, true);

        } else {
            this.hiResImageLoaderHandler();
        }

    }


    private function hideProgressBar(event:LoaderEvent):void {
        TweenMax.to(this._screenProgressBar, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE, onComplete: buildScreen});
    }

    private function buildScreen(event:LoaderEvent = null):void {

        if (!_uiIsBuilt) {
            _uiIsBuilt = true;
            this._allLoResLoader.removeEventListener(LoaderEvent.COMPLETE, this.buildScreen);
            this._allLoResLoader.removeEventListener(LoaderEvent.PROGRESS, this._screenProgressBar.progress);
        } else {
            return;
        }

        //FACTORIES
        const listFactory:AbstractUIFactory = new List_UI_Factory();
        const graphicFactory:AbstractGraphicFactory = new CommonElementsGraphicFactory();
        const scrubberFactory:AbstractUIFactory = new Scrubber_MVC_Factory();
        const zoomFactory:AbstractUIFactory = new Zoom_UI_Factory();
        const galleryFactory:AbstractUIFactory = new Gallery_UI_Factory();
        const uiFactory:AbstractUIFactory = new UIFactory();

        //Leaf of Gallery UI - Image
        _visual_Image_Gallery = galleryFactory.add(Gallery_UI_Factory.UI_IMAGE_GALLERY_NO_THROW_PROPS_FADE, this, 0, 0, this._vars, this._data) as UI_GalleryImageNoThrowProps_Fade;
        //Leaf of Button Gallery 360 - SWF

        //Because there is only one 360, the image is placed directly here, rather then embedded in functionality like the static images
        _visual_SWF360 = new Display_UI_Factory().add(Display_UI_Factory.SWF_360_WITH_ZOOM, this, 0, 0, this._vars, Global.data.copy.screen[ this._data.screenIndex ].slides) as SWF360Item;

        //Tree Trunk
        const bgParms:RectangleVARS = new RectangleVARS().width(467).height(34).fillColor(0xf9f9f9).radius(5).borderColor(0xa6a6a7).borderWeight(1).fillColor(0xf9f9f9);
        _ui_ROOT_and_background = uiFactory.add(UIFactory.UI_Rectangle_GRAPHIC, this, 332, 445, bgParms);

        //Leafs - graphics only
        _ui_divider1 = graphicFactory.add(CommonElementsGraphicFactory.STROKE_DIVIDER, _ui_ROOT_and_background, 105, 6);
        _ui_divider2 = graphicFactory.add(CommonElementsGraphicFactory.STROKE_DIVIDER, _ui_ROOT_and_background, 384, 6);

        //Branch of _background - Gallery UI
        _ui_buttons_gallery_Nav = listFactory.add(List_UI_Factory.LIST_UI_BUTTONS_GALLERY_NAV, _ui_ROOT_and_background, 140, 12, null, this._data);

        //Branch of _background - Scrubber
        _ui_scrubber = scrubberFactory.add(Scrubber_MVC_Factory.UI_MVC_SCRUBBER_DEFAULT, _ui_ROOT_and_background, 126, ( (_ui_ROOT_and_background.height / 2))) as UI_MVC_ScrubberDefault;

//        _ui_scrubber.movieClip = _visual_SWF360.loResSWF;
        _ui_scrubber.scrubUpdateFunction = _visual_SWF360.onScrubUpdate;
        _ui_scrubber.scrubCompleteFunction = _visual_SWF360.onScrubComplete;
        _ui_scrubber.omniture_track_metricID = Track_Tablets1297.getProduct(this._data.screenIndex) + "_360";

        //Leaf of _backgroun = buttons for 360 and scrubber
        _ui_buttons_Gallery_360 = listFactory.add(List_UI_Factory.LIST_UI_BUTTONS_360_GALLERY, _ui_ROOT_and_background, 12, 5);

        _ui_buttons_zoom = zoomFactory.add(Zoom_UI_Factory.BUTTONS_ZOOM, _ui_ROOT_and_background, _zoomPointNotLoaded.x, _zoomPointNotLoaded.y);

        _ui_zoomProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, _ui_ROOT_and_background, 397, 27, _ui_zoom_progressBarVars) as ProgressBar_UI_Default;


        const yPos:Number = ( Global.p.HEIGHT - 100 ) / 2;

        const rightNavVars:Object = {};
        rightNavVars.width = 100;
        rightNavVars.height = 100;

        const buttonFactory:AbstractButtonFactory = new Button_C_Factory();
        this._rightNavButton = buttonFactory.add("rightNav", Button_C_Factory.GALLERY_NAV_OVER_IMAGE_RIGHT, this, (Global.p.WIDTH - rightNavVars.width), yPos, rightNavVars, this._data) as GalleryNavOverImageRight;
        this._rightNavButton.text = Global.data.copy.screen[ this._data.screenIndex ].slides[  0 ].headline;

        this._rightNavButton.buttonMode = true;
        this._rightNavButton.useHandCursor = true;
        this._rightNavButton.mouseChildren = true;

        addCalloutTo360();

        this.addToComposite(_ui_ROOT_and_background);
        _ui_ROOT_and_background.addToComposite(_ui_buttons_gallery_Nav);
        _ui_buttons_gallery_Nav.addToComposite(_visual_Image_Gallery);
        _ui_ROOT_and_background.addToComposite(_ui_scrubber);
        _ui_scrubber.addToComposite(_visual_SWF360);
//        _ui_ROOT_and_background.addToComposite(_ui_buttons_zoom);

        this.state = STATE_SWF_260_ACTIVE;

        _visual_Image_Gallery.alpha = 0;
        _visual_Image_Gallery.visible = false;
        _ui_buttons_gallery_Nav.alpha = 0;
        _ui_buttons_gallery_Nav.visible = false;
        _ui_buttons_zoom.alpha = UI_ZOOM_OFF_ALPHA;
        _ui_zoomProgressBar.alpha = 1;
        _ui_zoomProgressBar.visible = true;

        this.activateComposite();
        _ui_buttons_gallery_Nav.deactivateComposite();
        _ui_buttons_zoom.deactivateComposite();
    }


    override public function disposeComposite():Boolean {
        removeChild(_ui_ROOT_and_background);
        removeChild(_ui_divider1);
        removeChild(_ui_divider2);

        _ui_divider2 = null;
        _ui_divider1 = null;

        _ui_ROOT_and_background = null;
        return true;
    }


    private function to_ui_selectGalleryItem(event:UIEvent):void {
//		trace(event.type + " ----> " + event.data);
        (_ui_buttons_gallery_Nav as List_UI_Button_GalleryNav).selectGalleryItemNoDispatch(String(event.data));
    }

    private function to_gallery_selectGalleryItem(event:UIEvent):void {
//        trace(event.type + " ----> " + event.data);
        _visual_Image_Gallery.index = int(event.data);

        if (Global.p.OMNITURE_TRACK_FIRST_IMAGE_GALLERY_SELECTED && !_isResetting) {
            Global.trackMetrics("image", Track_Tablets1297.getProduct(this._data.screenIndex) + "_image_" + int(event.data));
        }
    }

    private function zoom(event:UIEvent):void {

        if (this.state == STATE_GALLERY_ACTIVE) {
            _visual_Image_Gallery.onZoomUpdate = Number(event.data);
        }

        if (this.state == STATE_SWF_260_ACTIVE) {
//            (_visual_SWF360 as GallerySWF360ThrowProps).zoom = Number(event.data);
            this._visual_SWF360.onZoomUpdate(Number(event.data));
        }
    }

    private function to_ui_galleryHiResLoaded(event:UIEvent):void {
//        trace(event.type + " ----> " + event.data);
//        (_ui as UI_SliderGalleryZoom).zoomON( true );
    }

    private function to_ui_scrubberHiResLoaded(event:UIEvent):void {
//        (_ui as UI_SliderGalleryZoom).zoomON( true );
    }

    private var _trackZoomItem360HasTracked:Boolean = false;

    private function onZoomComplete(event:UIEvent):void {


        if (this.state == STATE_GALLERY_ACTIVE) {
            _visual_Image_Gallery.onZoomComplete();
        }

        if (this.state == STATE_SWF_260_ACTIVE) {
            this._visual_SWF360.onZoomComplete();

            if (Global.p.OMNITURE_TRACK_ZOOM_CONTINUOUS) {
                Global.trackMetrics("zoom", Track_Tablets1297.getProduct(this._data.screenIndex) + "_360_Zoom");
            }

            if (Global.p.OMNITURE_TRACK_ZOOM_ONCE && !this._trackZoomItem360HasTracked && !Global.p.OMNITURE_TRACK_ZOOM_CONTINUOUS) {
                _trackZoomItem360HasTracked = true;
                Global.trackMetrics("zoom", Track_Tablets1297.getProduct(this._data.screenIndex) + "_360_Zoom");
            }

        }
    }

    private function to_gallery_zoom_hover(event:UIEvent):void {

    }

    private function to_gallery_zoom_roll_out(event:UIEvent):void {

    }

    private function navRightMouseHandler(event:MouseEvent):void {
        _visual_SWF360.reset();

        //Turn Gallery Icon on
        (_ui_buttons_Gallery_360 as List_UI_Button_Rotate360Gallery).galleryON();

    }

    private function from_gallery_left_carrot(event:UIEvent):void {
        (_ui_buttons_Gallery_360 as List_UI_Button_Rotate360Gallery).r360ON();
    }


    //togle ui

    private const STATE_GALLERY_ACTIVE:String = "galleryActive";
    private const STATE_SWF_260_ACTIVE:String = "swf360Active";
    private var state:String;

    private function toggleGalleryAnd360OFF(event:UIEvent):void {


        TweenLite.killTweensOf(_visual_Image_Gallery);
        TweenLite.killTweensOf(_visual_SWF360);
        TweenLite.killTweensOf(_ui_buttons_zoom);
        TweenLite.killTweensOf(_ui_zoomProgressBar);

        var eventData:String = String(event.data);


        if (eventData == "360") {


            TweenMax.to(_visual_Image_Gallery, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
            TweenMax.to(_ui_buttons_gallery_Nav, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE, onComplete: this.toggleGalleryOr360On, onCompleteParams: [eventData]});

            _ui_scrubber.activateComposite();
            _ui_buttons_gallery_Nav.deactivateComposite();
        }

        if (eventData == "Gallery") {


            TweenMax.to(_ui_scrubber, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
            TweenMax.to(_visual_SWF360, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE, onComplete: this.toggleGalleryOr360On, onCompleteParams: [eventData]});

            _ui_scrubber.deactivateComposite();
            _ui_buttons_gallery_Nav.activateComposite();
        }
    }


    private function toggleGalleryOr360On(_data:String):void {

        if (_data == "360") {

            if (Global.p.OMNITURE_TRACK_360 && !_isResetting) {
                Global.trackMetrics("360", Track_Tablets1297.getProduct(this._data.screenIndex) + "_360");
            }

            _visual_Image_Gallery.reset();
            (_ui_buttons_gallery_Nav as List_UI_Button_GalleryNav).reset();
            this._rightNavButton.addEventListener(MouseEvent.CLICK, this.navRightMouseHandler, false, 0, true);
            TweenMax.to(_rightNavButton, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
            TweenMax.to(_visual_SWF360, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
            TweenMax.to(_ui_scrubber, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
            this.state = STATE_SWF_260_ACTIVE;
            loadHiResSwf();
        }

        if (_data == "Gallery") {

            if (Global.p.OMNITURE_TRACK_GALLERY && !_isResetting) {
                Global.trackMetrics("Gallery", Track_Tablets1297.getProduct(this._data.screenIndex) + "_Gallery");
            }


            if (Global.p.OMNITURE_TRACK_IMAGE && !_isResetting) {
                Global.trackMetrics("image", Track_Tablets1297.getProduct(this._data.screenIndex) + "_image_0");
            }
            _visual_SWF360.reset();
            _ui_scrubber.reset();
			
			_visual_Image_Gallery.scaleX = 1.01;
			_visual_Image_Gallery.scaleY = 1.01;
			
            this._rightNavButton.removeEventListener(MouseEvent.CLICK, this.navRightMouseHandler);
            TweenMax.to(_rightNavButton, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
            TweenMax.to(_visual_Image_Gallery, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
            TweenMax.to(_ui_buttons_gallery_Nav, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
            this.state = STATE_GALLERY_ACTIVE;
            loadHiResImages();
        }

        _isResetting = false;
    }


    override public function activateComposite():Boolean {
        //UI does not build until assets are loaded.
        if (!_uiIsBuilt) {

            loadLoResAssets();

        } else {

            if (this._hiResSWFLoader.status != LoaderStatus.COMPLETED) {
                this._hiResSWFLoader.addEventListener(LoaderEvent.COMPLETE, this.buildScreen, false, 0, true);
            }

            this._rightNavButton.addEventListener(MouseEvent.CLICK, this.navRightMouseHandler, false, 0, true);

            _visual_Image_Gallery.addEventListener(UIEvent.GALLERY_IMAGE_CHANGE, to_ui_selectGalleryItem, false, 0, true);
            _visual_Image_Gallery.addEventListener(UIEvent.GALLERY_FIRST_LEFT_CARROT_SELECT, from_gallery_left_carrot, false, 0, true);
//            _visual_Image_Gallery.addEventListener(UIEvent.GALLERY_IMAGE_CHANGE, to_ui_selectGalleryItem, false, 0, true);
            _visual_Image_Gallery.addEventListener(UIEvent.HI_RES_IMAGE_LOADED, to_ui_galleryHiResLoaded, false, 0, true);

            _visual_SWF360.addEventListener(UIEvent.HIGH_RES_SWF_LOADED, to_ui_scrubberHiResLoaded, false, 0, true);

            _ui_buttons_Gallery_360.addEventListener(UIEvent.NAV_ITEM_SELECT, this.toggleGalleryAnd360OFF, false, 0, true);
            _ui_buttons_gallery_Nav.addEventListener(UIEvent.GALLERY_ITEM_SELECT, this.to_gallery_selectGalleryItem, false, 0, true);

            _ui_buttons_zoom.addEventListener(UIEvent.ZOOMIMG, this.zoom, false, 0, true);
            _ui_buttons_zoom.addEventListener(UIEvent.ZOOM_COMPLETE, this.onZoomComplete, false, 0, true);
            _ui_buttons_zoom.addEventListener(UIEvent.ZOOM_HOVER, this.to_gallery_zoom_hover, false, 0, true);
            _ui_buttons_zoom.addEventListener(UIEvent.ZOOM_ROOL_OUT, this.to_gallery_zoom_roll_out, false, 0, true);
        }

        if (this.state == STATE_SWF_260_ACTIVE) {
            loadHiResSwf();
        }

        if (this.state == STATE_GALLERY_ACTIVE) {
            loadHiResImages();
        }



        super.activateComposite();
        return true;
    }


    override public function deactivateComposite():Boolean {

        if (this._hiResSWFLoader.status != LoaderStatus.COMPLETED) {
            this._hiResSWFLoader.addEventListener(LoaderEvent.COMPLETE, this.buildScreen);
        }

        this._rightNavButton.removeEventListener(MouseEvent.CLICK, this.navRightMouseHandler);


        _visual_SWF360.removeEventListener(UIEvent.HIGH_RES_SWF_LOADED, to_ui_scrubberHiResLoaded);
        _ui_buttons_Gallery_360.removeEventListener(UIEvent.NAV_ITEM_SELECT, this.toggleGalleryAnd360OFF);
        _ui_buttons_gallery_Nav.addEventListener(UIEvent.GALLERY_ITEM_SELECT, this.to_gallery_selectGalleryItem);

        _visual_Image_Gallery.removeEventListener(UIEvent.GALLERY_IMAGE_CHANGE, to_ui_selectGalleryItem);
        _visual_Image_Gallery.removeEventListener(UIEvent.HI_RES_IMAGE_LOADED, to_ui_galleryHiResLoaded);
        _visual_Image_Gallery.addEventListener(UIEvent.GALLERY_FIRST_LEFT_CARROT_SELECT, from_gallery_left_carrot);
//        _visual_Image_Gallery.removeEventListener(UIEvent.GALLERY_IMAGE_CHANGE, to_ui_selectGalleryItem);

        _ui_buttons_zoom.removeEventListener(UIEvent.ZOOMIMG, this.zoom);
        _ui_buttons_zoom.removeEventListener(UIEvent.ZOOM_COMPLETE, this.onZoomComplete);
        _ui_buttons_zoom.removeEventListener(UIEvent.ZOOM_HOVER, this.to_gallery_zoom_hover);
        _ui_buttons_zoom.removeEventListener(UIEvent.ZOOM_ROOL_OUT, this.to_gallery_zoom_roll_out);

        super.deactivateComposite();
        return true;
    }

    private function hiResSWFLoadedHandler(event:LoaderEvent = null):void {

        if (!_hiResSWFLoaded) {

            _hiResSWFLoaded = true;

//            this._hiResSWFLoader.removeEventListener(LoaderEvent.COMPLETE, this._visual_SWF360.setHiResSwf);
            this._hiResSWFLoader.removeEventListener(LoaderEvent.COMPLETE, this.hiResSWFLoadedHandler);
            this._hiResSWFLoader.removeEventListener(LoaderEvent.PROGRESS, this._screenProgressBar.progress);

            this._visual_SWF360.setHiResSwf();

            TweenLite.to(this._ui_buttons_zoom, Global.t.TRANSITION, {alpha: 1, x: _zoomPointLoaded.x, y: _zoomPointLoaded.y, ease: Global.t.EASE});
            this._ui_buttons_zoom.activateComposite();
            TweenLite.to(this._ui_zoomProgressBar, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE });
        }


    }

    private function hiResImageLoaderHandler(event:LoaderEvent = null):void {

        if (!_hiResImagesLoaded) {

            _hiResImagesLoaded = true;

//            this._hiResImageLoader.removeEventListener(LoaderEvent.COMPLETE, this._visual_SWF360.setHiResSwf);
            this._hiResImageLoader.removeEventListener(LoaderEvent.COMPLETE, this.hiResImageLoaderHandler);
            this._hiResImageLoader.removeEventListener(LoaderEvent.PROGRESS, this._screenProgressBar.progress);

            this._visual_Image_Gallery.setUpHiResImages();

            TweenLite.to(this._ui_buttons_zoom, Global.t.TRANSITION, { alpha: 1, x: _zoomPointLoaded.x, y: _zoomPointLoaded.y, ease: Global.t.EASE});
            this._ui_buttons_zoom.activateComposite();
            TweenLite.to(this._ui_zoomProgressBar, Global.t.TRANSITION, { autoAlpha: 0, ease: Global.t.EASE });

        }


    }

    /**
     * disable functionality while resetting.
     */
    private var _isResetting:Boolean = false;

    public function reset():void {
        _isResetting = true;
        _visual_SWF360.reset();
        _visual_Image_Gallery.reset();
        (_ui_buttons_gallery_Nav as List_UI_Button_GalleryNav).reset();
        _ui_scrubber.reset();
        (_ui_buttons_Gallery_360 as List_UI_Button_Rotate360Gallery).r360ON();
    }


    private function addCalloutTo360():void {

        var calloutParams:Object = textBoxParams();

        //TODO find a way to simplify this

//        trace( Global.data.copy.screen[ this._data.screenIndex ].threeSixty.title );
//        trace( Global.data.copy.screen[ this._data.screenIndex ].threeSixty.color );
//        trace( Global.data.copy.screen[ this._data.screenIndex ].threeSixty.descr );
//        trace( Global.data.copy.screen[ this._data.screenIndex ].threeSixty.callOutWidth );
//        trace( Global.data.copy.screen[ this._data.screenIndex ].threeSixty.backgroundAlpha );

        calloutParams.textFieldHeaderParams.text = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.title;

        //(calloutParams.textFieldHeaderParams as AbstractTextFieldParams).color = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.color;


        calloutParams.textFieldHeaderParams.embeddedFontFormat.color = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.color;

        calloutParams.textFieldHeaderParams.noFontTextFormat.color = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.color;


        calloutParams.textFieldCopyParams.text = Global.data.copy.screen[ this._data.screenIndex ].threeSixty.descr;
        (calloutParams.callOutVars as CalloutVARS).width(Global.data.copy.screen[ this._data.screenIndex ].threeSixty.callOutWidth);
        (calloutParams.calloutGraphicVars as CalloutGraphicVARS).fillAlpha(Global.data.copy.screen[ this._data.screenIndex ].threeSixty.backgroundAlpha);

        this.callout = new Callout_C_Factory().add(
                Callout_C_Factory.CALLOUT_HEADER_COPY,
                _visual_SWF360.callout,
                Global.data.copy.screen[ this._data.screenIndex ].threeSixty.x,
                Global.data.copy.screen[ this._data.screenIndex ].threeSixty.y,
                calloutParams) as C_Callout_Rectangle_Header_Copy;
    }


    ///TEXTFIELD
    /**
     *
     * 360 TextField Params
     *
     * @return
     */
    private function textBoxParams():Object {
        var o:Object = {};

        var _headerParams:AbstractTextFieldParams = new R360_Callout_Header();
        o.textFieldHeaderParams = _headerParams;
//        trace( _headerParams.text );

        var _copy:AbstractTextFieldParams = new R360_Callout_Copy();
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
        _callOutFunctionVars.registration(AbstractCalloutParams.REGISTER_TOP_MIDDLE);
        o.callOutVars = _callOutFunctionVars;

        return o;

    }

}
}
