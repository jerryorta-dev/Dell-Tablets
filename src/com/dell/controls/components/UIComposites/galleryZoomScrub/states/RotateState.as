/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/4/13
 * Time: 12:12 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.UIComposites.galleryZoomScrub.states {
import com.dell.controls.components.UIComposites.galleryZoomScrub.UI_SliderGalleryZoom;
import com.dell.core.Global;
import com.greensock.TweenLite;
import com.greensock.easing.Sine;

import project_tablets_1297.T;

public class RotateState implements IGalleryScrubber{

    private var _ui:UI_SliderGalleryZoom;
    private var _name:String;


    public function RotateState( ui:UI_SliderGalleryZoom ) {

        this._ui = ui;
        this._name = UI_SliderGalleryZoom.ROTATE_STATE;
    }

    public function gallery():void {
        TweenLite.killTweensOf( this._ui._scrubberUI );
        TweenLite.to( this._ui._scrubberUI, Global.t.TRANSITION, { alpha: 0, ease:Sine.easeOut, overwrite:true});
        TweenLite.delayedCall(Global.t.TRANSITION , this.setGalleryState );
    }

    public function rotate():void {
        TweenLite.killTweensOf( this._ui._galleryUI );
        TweenLite.to( this._ui._galleryUI, Global.t.TRANSITION, { alpha: 0, ease:Sine.easeOut, overwrite:true});
        TweenLite.delayedCall(Global.t.TRANSITION , this.setRotateState );
    }


    private function setGalleryState():void {
        this._ui._scrubberUI.visible = false;
        this._ui._galleryUI.visible = true;
        TweenLite.to( this._ui._galleryUI, Global.t.TRANSITION, { alpha: 1, ease:Sine.easeOut, overwrite:true});
        this._ui.setStateClass( this._ui.galleryStateClass );
    }

    private function setRotateState():void {
        this._ui._galleryUI.visible = false;
        this._ui._scrubberUI.visible = true;
        TweenLite.to( this._ui._scrubberUI, Global.t.TRANSITION, { alpha: 1, ease:Sine.easeOut, overwrite:true});
        this._ui.setStateClass( this._ui.galleryStateClass );
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }
}
}
