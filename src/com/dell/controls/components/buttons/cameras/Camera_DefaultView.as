/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:18 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.buttons.cameras {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.buttonStates.OffState;
import com.dell.controls.components.core.abstract.buttonStates.OnState;
import com.dell.controls.components.core.abstract.buttonStates.OverState;
import com.dell.controls.components.core.interfaces.IButton;
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.core.Global;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.MovieClipFactory;

import flash.events.MouseEvent;

public class Camera_DefaultView extends AbstractButton implements IButton {

    //States
    private var onState:IButtonState;
    private var offState:IButtonState;
    private var overState:IButtonState;
    private var _stateClass:IButtonState;


    //Graphics
    private var _onGraphic:AbstractGraphic;
    private var _offGraphic:AbstractGraphic;
    private var _overGraphic:AbstractGraphic;


	
    public function Camera_DefaultView( name:String, vars:Object = null, data:Object = null) {
//        super(aModel, aController);
		_data = ( data != null ) ? data : {};
        _vars = ( vars != null ) ? vars : {};
        this.name = name;
    }

    // GRAPHICS

    override public function draw():void {

        _offGraphic = new MovieClipFactory( new UICamera().mcPhotoIconOff );
        this.addGraphic( _offGraphic );

        _onGraphic = new MovieClipFactory( new UICamera().mcPhotoIconOn );
        this.addGraphic( _onGraphic );

        _overGraphic = new MovieClipFactory( new UICamera().mcPhotoIconOn );
        this.addGraphic( _overGraphic );

    }

    private function addGraphic( _abstractGraphic:AbstractGraphic ):void {
        _abstractGraphic.x = _abstractGraphic.y = 0;
        this.addChild( _abstractGraphic );
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

        this._stateClass = this.offState;
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
        return Global.t.TRANSITION;
    }
	
}
}
