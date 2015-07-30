package com.dell.controls.components.UIComposites.galleryZoomScrub {
import com.dell.controls.List_UI_Factory;
import com.dell.controls.Scrubber_MVC_Factory;
import com.dell.controls.Zoom_UI_Factory;
import com.dell.controls.components.UIComposites.galleryZoomScrub.states.GalleryState;
import com.dell.controls.components.UIComposites.galleryZoomScrub.states.IGalleryScrubber;
import com.dell.controls.components.UIComposites.galleryZoomScrub.states.RotateState;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.controls.components.lists.lib.List_UI_Button_GalleryNav;
import com.dell.events.UIEvent;
import com.dell.graphics.CommonElementsGraphicFactory;
import com.dell.graphics.RectangleFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.AbstractGraphicFactory;
import com.dell.graphics.data.RectangleVARS;
import com.dell.core.Global;
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.events.Event;

/**
 * <p>UI that contains a scrubber, 5 button gallery, and zoom.</p>
 * <code>
 *     import com.dell.controls.UIFactory;<br>
 *     import com.dell.events.UIEvent;<br>
 *     import com.dell.controls.abstract.AbstractUI;<br><br>
 *
 *     private function initUI():void {<br>
 *          var cf:UIFactory = new UIFactory();<br>
 *          var myUI:AbstractUI = cf.add( UIFactory.SLIDER_GALLERY_ZOOM_TABLETS_DEFAULT, this, 50, 50);<br><br>
 *
 *          myUI.addEventListener( UIEvent.NAV_ITEM_SELECT, this.testUI, false, 0, true);<br>
 *          myUI.addEventListener(UIEvent.SCRUBBING, this.testUI, false, 0, true);<br>
 *          myUI.addEventListener(UIEvent.SCRUB_COMPLETE, this.testUI, false, 0, true);<br>
 *          myUI.addEventListener(UIEvent.GALLERY_ITEM_SELECT, this.testUI, false, 0, true);<br>
 *          myUI.addEventListener( UIEvent.ZOOMIMG, this.testUI, false, 0, true);<br>
 *          myUI.addEventListener( UIEvent.ZOOM_COMPLETE, this.testUI, false, 0, true);<br>
 *     }<br><br>
 *
 *   private function testUI( event:UIEvent ):void {<br>
 *      trace(event.type + " ----> " + event.data);<br>
 *   }
 * </code>
 *
 *
 *
 */
public class UI_SliderGalleryZoom extends AbstractUI {
    private var background:AbstractGraphic;

    public var _scrubberUI:AbstractUI;
    public var _rotate360GalleryUI:AbstractUI;
    public var _galleryUI:AbstractUI;
    public var _zoomUI:AbstractUI;

    private var _divider1:AbstractGraphic;
    private var _divider2:AbstractGraphic;


    /**
     * <p>
     * Use factory of prebuilt User Interfaces.
     * </p>
     * <p>Example </p>
     * <p>
     *    var cf:UIFactory = new UIFactory(); <br>
     *        var myUI:AbstractUI = cf.add( UIFactory.SLIDER_GALLERY_ZOOM_TABLETS_DEFAULT, this, 50, 50); <br>
     *        myUI.addEventListener( UIEvent.NAV_ITEM_SELECT, this.testUI, false, 0, true); <br>
     *        myUI.addEventListener( UIEvent.SCRUBBING, this.testUI, false, 0, true); <br>
     *        myUI.addEventListener( UIEvent.SCRUB_COMPLETE, this.testUI, false, 0, true); <br>
     *        myUI.addEventListener( UIEvent.GALLERY_ITEM_SELECT, this.testUI, false, 0, true); <br>
     *        myUI.addEventListener( UIEvent.ZOOMIMG, this.testUI, false, 0, true); <br>
     *        myUI.addEventListener( UIEvent.ZOOM_COMPLETE, this.testUI, false, 0, true); <br>
     * </p>
     *
     * @author Jerry_Orta
     *
     */
    public function UI_SliderGalleryZoom(vars:Object = null, data:Object = null) {
        super(vars, data);

    }

    override public function commitProperties(event:Event = null):void {

    }


    override public function draw():void {

        /*
         trace( Global.data.copy.modules[ Global.moduleIndex ].name );
         trace( Global.data.copy.modules[ Global.moduleIndex ].threeSixty.title );
         trace( Global.data.copy.modules[ Global.moduleIndex ].threeSixty.descr );
         trace( Global.data.copy.modules[ Global.moduleIndex ].slides[0].id );
         trace( Global.data.copy.modules[ Global.moduleIndex ].slides[0].headline );
         trace( Global.data.copy.modules[ Global.moduleIndex ].slides[0].subhead );
         */

        const bgFactory:AbstractGraphicFactory = new RectangleFactory();
        const listFactory:AbstractUIFactory = new List_UI_Factory();
        const graphicFactory:AbstractGraphicFactory = new CommonElementsGraphicFactory();
        const scrubberFactory:AbstractUIFactory = new Scrubber_MVC_Factory();
        const zoomFactory:AbstractUIFactory = new Zoom_UI_Factory();

        const bgParms:RectangleVARS = new RectangleVARS().width(467).height(34).fillColor(0xf9f9f9).radius(5).borderColor(0xa6a6a7).borderWeight(1).fillColor(0xf9f9f9);
        background = bgFactory.add(RectangleFactory.RECTANGLE_WITH_VARS, this, 0, 0, bgParms);

        //UI
        _rotate360GalleryUI = listFactory.add(List_UI_Factory.LIST_UI_BUTTONS_360_GALLERY, this, 12, 5);
        _scrubberUI = scrubberFactory.add(Scrubber_MVC_Factory.UI_MVC_SCRUBBER_DEFAULT, this, 126, background.height / 2);
        _galleryUI = listFactory.add(List_UI_Factory.LIST_UI_BUTTONS_GALLERY_NAV, this, 140, 12, null, Global.data.copy.screen[ Global.moduleIndex ].slides);
        _zoomUI = zoomFactory.add(Zoom_UI_Factory.BUTTONS_ZOOM, this, 397, 7);

        this.addChild(background);
        this.addChild(_scrubberUI);

        _divider1 = graphicFactory.add(CommonElementsGraphicFactory.STROKE_DIVIDER, this, 106, 6);
        _divider2 = graphicFactory.add(CommonElementsGraphicFactory.STROKE_DIVIDER, this, 384, 6);

        _zoomUI.alpha = 0;
        _zoomUI.visible = false;

    }

    override public function initialize():void {

        this.activateComposite();

        this._galleryState = new GalleryState(this);
        this._rotateState = new RotateState(this);

        this._stateClass = this._rotateState;
        this._state = this._rotateState.name;

        _galleryUI.alpha = 0;
        _galleryUI.visible = false;

    }

    override public function activateComposite():Boolean {

        _rotate360GalleryUI.addEventListener(UIEvent.NAV_ITEM_SELECT, this.rotateGallerySelect, false, 0, true);
        _scrubberUI.addEventListener(UIEvent.SCRUBBING, this.eventDispatcher, false, 0, true);
        _scrubberUI.addEventListener(UIEvent.SCRUB_COMPLETE, this.eventDispatcher, false, 0, true);
        _galleryUI.addEventListener(UIEvent.GALLERY_ITEM_SELECT, this.eventDispatcher, false, 0, true);
        _zoomUI.addEventListener(UIEvent.ZOOMIMG, this.eventDispatcher, false, 0, true);
        _zoomUI.addEventListener(UIEvent.ZOOM_COMPLETE, this.eventDispatcher, false, 0, true);
        _zoomUI.addEventListener(UIEvent.ZOOM_HOVER, this.eventDispatcher, false, 0, true);
        _zoomUI.addEventListener(UIEvent.ZOOM_ROOL_OUT, this.eventDispatcher, false, 0, true);
        super.activateComposite();
        return true;
    }

    override public function deactivateComposite():Boolean {

        _rotate360GalleryUI.removeEventListener(UIEvent.NAV_ITEM_SELECT, this.rotateGallerySelect);
        _scrubberUI.removeEventListener(UIEvent.SCRUBBING, this.eventDispatcher);
        _scrubberUI.removeEventListener(UIEvent.SCRUB_COMPLETE, this.eventDispatcher);
        _galleryUI.removeEventListener(UIEvent.GALLERY_ITEM_SELECT, this.eventDispatcher);
        _zoomUI.removeEventListener(UIEvent.ZOOMIMG, this.eventDispatcher);
        _zoomUI.removeEventListener(UIEvent.ZOOM_COMPLETE, this.eventDispatcher);
        _zoomUI.removeEventListener(UIEvent.ZOOM_HOVER, this.eventDispatcher);
        _zoomUI.removeEventListener(UIEvent.ZOOM_ROOL_OUT, this.eventDispatcher);
        super.activateComposite();
        return true;
    }

    override public function eventDispatcher(event:UIEvent):void {
        if (this._isActivated) {
            dispatchEvent(event);
        }
    }

    public function zoomON(value:Boolean = true):void {
        if (value) {
            TweenMax.to(_zoomUI, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
        } else {
            TweenMax.to(_zoomUI, Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE});
        }
    }

    private function rotateGallerySelect(event:UIEvent):void {
//        trace(event.type + " ::: " + event.data);

        //Name of button from com.dell.controls.lists.lib.Rotate360Gallery
        if (event.data == "360") {
            this.rotate();
        }

        if (event.data == "Gallery") {
            this.gallery();
        }

        this.eventDispatcher(new UIEvent(event.type, event.data))

    }

    /**
     * set the gallery to a value;
     * @param value
     */
    public function selectGalleryItem(value:String):void {
        (_galleryUI as List_UI_Button_GalleryNav).selectGalleryItem(value);
    }


    //STATES
    private var _stateClass:IGalleryScrubber;
    private var _state:String;

    private var _galleryState:IGalleryScrubber;
    private var _rotateState:IGalleryScrubber;

    public static const GALLERY_STATE:String = "galleryState";
    public static const ROTATE_STATE:String = "rotateState";

    public function gallery():void {
        _stateClass.gallery();
    }

    public function rotate():void {
        _stateClass.rotate();
    }

    public function setStateClass(state:IGalleryScrubber):void {
        this._state = state.name;
        this._stateClass = state;
    }


    public function getStateClass():IGalleryScrubber {
        return _stateClass;
    }

    public function get galleryStateClass():IGalleryScrubber {
        return this._galleryState;
    }

    public function get rotateStateClass():IGalleryScrubber {
        return this._rotateState;
    }


}
}