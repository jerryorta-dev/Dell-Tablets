/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:18 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.buttons.nav {

import com.dell.controls.Callout_C_Factory;
import com.dell.controls.components.buttons.galleries.calloutViewStates.CalloutOffState;
import com.dell.controls.components.buttons.galleries.calloutViewStates.CalloutOnState;
import com.dell.controls.components.buttons.galleries.calloutViewStates.CalloutOverState;
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IButton;
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.graphics.CommonElementsGraphicFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;

import flash.events.MouseEvent;

public class Main_Nav_Tablets extends AbstractButton implements IButton {

    //States
    private var onState:IButtonState;
    private var offState:IButtonState;
    private var overState:IButtonState;
    private var _stateClass:IButtonState;


    //Graphics
    private var _onGraphic:AbstractGraphic;
    private var _offGraphic:AbstractGraphic;
    private var _overGraphic:AbstractGraphic;

    //Callout
    private var _callout:AbstractUI;
    //Animation
    private var _transitionTime:Number = .25;

	
    public function Main_Nav_Tablets( name:String, vars:Object = null, data:Object = null) {
//        super(aModel, aController);
		_data = ( data != null ) ? data : {};
        _vars = ( vars != null ) ? vars : {};
        this.name = name;
    }

    // GRAPHICS

    override public function draw():void {

        _callout = new Callout_C_Factory().add( Callout_C_Factory.DEFAULT_CALLOUT, this, 12, -5, this._vars, this._data );

        var factory:CommonElementsGraphicFactory = new CommonElementsGraphicFactory();
		
//        _offGraphic = factory.add( CommonElementsGraphicFactory.GALLERY_BUTTON_OFF, this, 0, 0);
//        _onGraphic = factory.add( CommonElementsGraphicFactory.GALLERY_BUTTON_ON, this, 0, 0);
//        _overGraphic = factory.add( CommonElementsGraphicFactory.GALLERY_BUTTON_ON, this, 0, 0);



    }

    override public function initialize():void {
		
        _onGraphic.alpha = 0;
        _overGraphic.alpha = 0;
        _callout.alpha = 0;

//		this.mouseEnabled = true;
//		this.mouseChildren = false;
//		this.useHandCursor = true;

        onState = new CalloutOnState( this, _onGraphic, _offGraphic, _overGraphic, _callout );
        offState = new CalloutOffState( this, _onGraphic, _offGraphic, _overGraphic, _callout );
        overState = new CalloutOverState( this, _onGraphic, _offGraphic, _overGraphic, _callout );

        this._stateClass = offState;
        this._state = this._stateClass.name;
    }

    // STATES

    override public function on( event:MouseEvent = null ):void {
        _stateClass.on();
//        this.removeEventHandlers();
    }

    override public function off( event:MouseEvent = null ):void {
        _stateClass.off();
//        this.addEventHandlers();
    }

    override public function over( event:MouseEvent = null ):void {
        if (_stateClass != onState) {
            _stateClass.over();
        }
    }

    public function setStateClass(state:IButtonState):void {
        this._state = state.name;
        this._stateClass = state;
    }

    override public function getStateClass():IButtonState {
        return _stateClass;
    }

    public function get onStateClass():IButtonState {
        return this.onState;
    }

    public function get offStateClass():IButtonState {
        return this.offState;
    }

    public function get overStateClass():IButtonState {
        return this.overState;
    }

    public function get transitionTime():Number {
        return _transitionTime;
    }
}
}
