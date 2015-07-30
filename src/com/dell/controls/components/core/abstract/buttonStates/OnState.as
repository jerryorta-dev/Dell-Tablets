/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:20 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.core.abstract.buttonStates {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.interfaces.IButton;
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.errors.AbstractMethodError;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.greensock.TweenLite;
import com.greensock.easing.Sine;

import flash.events.MouseEvent;

public class OnState implements IButtonState {

    private var _buttonMain:IButton;
    private var _onGraphic:AbstractGraphic;
    private var _offGraphic:AbstractGraphic;
    private var _overGraphic:AbstractGraphic;
    private var _name:String;


    public function OnState( galleryNavButton:IButton, onGraphic:AbstractGraphic, offGraphic:AbstractGraphic, overGraphic:AbstractGraphic ) {
        this._buttonMain = galleryNavButton;
        this._onGraphic = onGraphic;
        this._offGraphic = offGraphic;
        this._overGraphic = overGraphic;
        this.name = AbstractButton.ON;
    }

    public function on( event:MouseEvent = null ):void {
        //DO NOT DO ANYTHING
    }

    public function off( event:MouseEvent = null ):void {
        TweenLite.killTweensOf( this._onGraphic );
        TweenLite.to( this._onGraphic, this._buttonMain.transitionTime, { alpha: 0, ease:Sine.easeOut, overwrite:true});
        TweenLite.delayedCall( this._buttonMain.transitionTime, this.setOffStatea );
    }

    public function over( event:MouseEvent = null ):void {
        //DO NOT DO ANYTHING
    }


    // set states

    private function setOnState():void {
        throw new AbstractMethodError();
    }

    private function setOffStatea():void {
        this._buttonMain.setStateClass( this._buttonMain.offStateClass );
    }

    private function setOverState():void {
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
