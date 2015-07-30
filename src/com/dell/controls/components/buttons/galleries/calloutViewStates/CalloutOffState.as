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
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

import flash.events.MouseEvent;

public class CalloutOffState implements IButtonState {

    private var _buttonMain:IButton;
    private var _onGraphic:AbstractGraphic;
    private var _offGraphic:AbstractGraphic;
    private var _overGraphic:AbstractGraphic
    private var _callout:AbstractUI;
    private var _name:String;

    public function CalloutOffState( galleryNavButton:IButton, onGraphic:AbstractGraphic, offGraphic:AbstractGraphic, overGraphic:AbstractGraphic, callout:AbstractUI ) {
        this._buttonMain = galleryNavButton;
        this._onGraphic = onGraphic;
        this._offGraphic = offGraphic;
        this._overGraphic = overGraphic;
        this._callout = callout;
        this._callout.mouseEnabled = false;
        this._callout.mouseChildren = false;
        this.name = AbstractButton.OFF;

    }

    public function on( event:MouseEvent = null ):void {
        this.setOnState();
    }

    public function off( event:MouseEvent = null ):void {
        //Just in case the over state is not instantiated, we can do "off" operations while still in off

//        TweenLite.killTweensOf( this._overGraphic );
//        TweenLite.killTweensOf( this._callout );
//        TweenLite.to( this._onGraphic, this._galleryNavButton.transitionTime, { alpha: 0, ease:Sine.easeOut, overwrite:true});
        TweenLite.to( this._overGraphic, this._buttonMain.transitionTime, { alpha: 0, ease:Sine.easeOut, overwrite:"all"});
        TweenMax.to( this._callout, this._buttonMain.transitionTime, { autoAlpha: 0, ease:Sine.easeOut, overwrite:"all"});
        TweenLite.delayedCall( this._buttonMain.transitionTime, this.setOffStatea );
    }

    public function over( event:MouseEvent = null ):void {
        this.setOverState();
    }



    // set states

    private function setOnState():void {
		TweenLite.to( this._onGraphic, this._buttonMain.transitionTime, { alpha: 1, ease:Sine.easeOut, overwrite:"all"});
        this._buttonMain.setStateClass( this._buttonMain.onStateClass );
    }

    private function setOffStatea():void {
//        throw new AbstractMethodError();
    }

    private function setOverState():void {
		TweenLite.to( this._overGraphic, this._buttonMain.transitionTime, { alpha: 1, ease:Sine.easeOut, overwrite:"all"});
		TweenMax.to( this._callout, this._buttonMain.transitionTime, { autoAlpha: 1, ease:Sine.easeOut, overwrite:"all"});
        this._buttonMain.setStateClass( this._buttonMain.overStateClass );
    }


    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }
}
}
