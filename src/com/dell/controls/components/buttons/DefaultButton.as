/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:18 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.buttons {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.interfaces.IButton;
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.core.Global;
import com.dell.graphics.components.core.abstract.AbstractGraphic;

import flash.events.MouseEvent;

public class DefaultButton extends AbstractButton implements IButton {

    //States
    protected var onState:IButtonState;
    protected var offState:IButtonState;
    protected var overState:IButtonState;
    protected var _stateClass:IButtonState;


    //Graphics
    protected var _onGraphic:AbstractGraphic;
    protected var _offGraphic:AbstractGraphic;
    protected var _overGraphic:AbstractGraphic;

    protected var _width:Number;
    protected var _height:Number;
    protected var _hitGraphic:AbstractGraphic;

    private var _isSelected:Boolean = false;



    public function DefaultButton( name:String, vars:Object = null, data:Object = null) {
//        super(aModel, aController);
		_data = ( data != null ) ? data : {};
		_vars = ( vars != null ) ? vars : {};
        this.name = name;

        this._width = ( this._vars.width != null ) ? this._vars.width : 100;
        this._height = ( this._vars.height != null ) ? this._vars.height : 100;

    }

    // GRAPHICS

    override public function draw():void {



    }

    public function addGraphic( _abstractGraphic:AbstractGraphic ):void {

    }

    override public function initialize():void {


    }

    protected function addListeners():void {
//		this._hitGraphic.mouseEnabled = true;
		
		this.useHandCursor = true;
		this.mouseChildren = false;
		
//        this.addEventListener(MouseEvent.CLICK, this.on)
        this.addEventListener(MouseEvent.MOUSE_OVER, this.over);
        this.addEventListener(MouseEvent.ROLL_OUT, this.off);
    }

    
    public function get isActive():Boolean {
        return _isSelected;
    }

    public function set isActive(value:Boolean):void {
        _isSelected = value;
    }

    // STATES

    override public function on( event:MouseEvent = null ):void {
		if (!this._isSelected ) {
			_stateClass.on();
		}
    }

    override public function off( event:MouseEvent = null ):void {
        _stateClass.off();

    }

    override public function over( event:MouseEvent = null ):void {
        if (_stateClass != onState && !this._isSelected) {
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
