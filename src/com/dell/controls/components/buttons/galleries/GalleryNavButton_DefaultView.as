/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:18 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.buttons.galleries {

import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.buttonStates.OffState;
import com.dell.controls.components.core.abstract.buttonStates.OnState;
import com.dell.controls.components.core.abstract.buttonStates.OverState;
import com.dell.controls.components.core.interfaces.IButton;
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.graphics.CommonElementsGraphicFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;

import flash.events.MouseEvent;



public class GalleryNavButton_DefaultView extends AbstractButton implements IButton {

    //States
    private var onState:IButtonState;
    private var offState:IButtonState;
    private var overState:IButtonState;
    private var _stateClass:IButtonState;


    //Graphics
    private var _onGraphic:AbstractGraphic;
    private var _offGraphic:AbstractGraphic;
    private var _overGraphic:AbstractGraphic;

    //Animation
    private var _transitionTime:Number = .25;
	
    public function GalleryNavButton_DefaultView( name:String, vars:Object = null, data:Object = null) {
//        super(aModel, aController);
		_data = ( data != null ) ? data : {};
        _vars = ( vars != null ) ? vars : {};
        this.name = name;
    }

    // GRAPHICS

    override public function draw():void {
		
        var factory:CommonElementsGraphicFactory = new CommonElementsGraphicFactory();
        _offGraphic = factory.add( CommonElementsGraphicFactory.GALLERY_BUTTON_OFF, this, 0, 0);
        _onGraphic = factory.add( CommonElementsGraphicFactory.GALLERY_BUTTON_ON, this, 0, 0);
        _overGraphic = factory.add( CommonElementsGraphicFactory.GALLERY_BUTTON_ON, this, 0, 0);

    }

    override public function initialize():void {
		
        _onGraphic.alpha = 0;
        _overGraphic.alpha = 0;

//		this.mouseEnabled = true;
//		this.mouseChildren = false;
//		this.useHandCursor = true;

        onState = new OnState( this, _onGraphic, _offGraphic, _overGraphic );
        offState = new OffState( this, _onGraphic, _offGraphic, _overGraphic );
        overState = new OverState( this, _onGraphic, _offGraphic, _overGraphic );

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
