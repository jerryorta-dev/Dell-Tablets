/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:20 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.buttons.galleries.calloutViewStates {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IButton;
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.errors.AbstractMethodError;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

import flash.events.MouseEvent;

public class CalloutOverState implements IButtonState {

    private var _buttonMain:IButton;
    private var _onGraphic:AbstractGraphic;
    private var _offGraphic:AbstractGraphic;
    private var _overGraphic:AbstractGraphic;
    private var _callout:AbstractUI;
    private var _name:String;

    public function CalloutOverState( galleryNavButton:IButton, onGraphic:AbstractGraphic, offGraphic:AbstractGraphic, overGraphic:AbstractGraphic, _callout:AbstractUI ) {
        this._buttonMain = galleryNavButton;
        this._onGraphic = onGraphic;
        this._offGraphic = offGraphic;
        this._overGraphic = overGraphic;
        this._callout = _callout;
        this._callout.mouseEnabled = false;
        this._callout.mouseChildren = false;
        this.name = AbstractButton.OVER;
    }

    public function on( event:MouseEvent = null ):void {
		this.setOnState();
    }

    public function off( event:MouseEvent = null ):void {
//        TweenLite.killTweensOf( this._onGraphic );
//        TweenLite.killTweensOf( this._overGraphic );
//        TweenLite.killTweensOf( this._callout );
//        TweenLite.to( this._onGraphic, this._galleryNavButton.transitionTime, { alpha: 0, ease:Sine.easeOut, overwrite:true});
        TweenLite.to( this._overGraphic, this._buttonMain.transitionTime, { alpha: 0, ease:Sine.easeOut, overwrite:"all"});
        TweenMax.to( this._callout, this._buttonMain.transitionTime, { autoAlpha: 0, ease:Sine.easeOut, overwrite:"all"});
        TweenLite.delayedCall( this._buttonMain.transitionTime, this.setOffState );
    }

    public function over( event:MouseEvent = null ):void {
		TweenLite.killTweensOf( this._overGraphic );
		TweenLite.killTweensOf( this._callout );
		TweenLite.to( this._overGraphic, this._buttonMain.transitionTime, { alpha: 1, ease:Sine.easeOut, overwrite:"all"});
		TweenMax.to( this._callout, this._buttonMain.transitionTime, { autoAlpha: 1, ease:Sine.easeOut, overwrite:"all"});
		this._buttonMain.setStateClass( this._buttonMain.overStateClass );
    }


    // set states

    private function setOnState():void {
		TweenLite.to( this._overGraphic, 0, { alpha: 0, ease:Sine.easeOut, overwrite:"all"});
		TweenMax.to( this._callout, 0, { autoAlpha: 0, ease:Sine.easeOut, overwrite:"all"});
		TweenLite.to( this._onGraphic, 0, { alpha: 1, ease:Sine.easeOut, overwrite:"all"});
        this._buttonMain.setStateClass( this._buttonMain.onStateClass );
    }

    private function setOffState():void {
        TweenLite.to( this._overGraphic, 0, { alpha: 0, ease:Sine.easeOut, overwrite:"all"});
        TweenMax.to( this._callout, 0, { autoAlpha: 0, ease:Sine.easeOut, overwrite:"all"});
        TweenLite.to( this._onGraphic, 0, { alpha:0, ease:Sine.easeOut, overwrite:"all"});
        this._buttonMain.setStateClass( this._buttonMain.offStateClass );
    }

    private function setOverState():void {
        throw new AbstractMethodError();
    }


    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }
}
}
