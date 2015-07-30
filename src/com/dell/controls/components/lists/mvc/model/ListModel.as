/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 5:13 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.lists.mvc.model {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.events.UIEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;


public class ListModel extends EventDispatcher implements IListModel {

    private var _previousGroupState:Object;
    private var _radioButtonState:Object;
    private var _currentGroupState:Object;

    private var _overState:Object;
    private var _offState:Object;




    public function ListModel(target:IEventDispatcher = null) {
        super(target);
        _radioButtonState = {};

    }



    private function updateOnState():void {
        dispatchEvent( new UIEvent(UIEvent.CLICK, null)); // dispatch event
    }

    public function updateOverState():void {
        dispatchEvent( new UIEvent(UIEvent.ROLL_OVER, null));
    }

    public function updateOffState():void {
        dispatchEvent( new UIEvent( UIEvent.ROLL_OUT, null));
    }



    public function set setOnState( _state:Object ):void {
        _currentGroupState = _state;
        dispatchEvent(new UIEvent( UIEvent.CHANGE, _state.name )); //TODO delete this possibly
        this.updateOnState();
    }

    public function set setOnStateNoEventDispatch( _state:Object ):void {
        _currentGroupState = _state;
        this.updateOnState();
    }

    public function set setOverState( _state:Object ):void {
        _overState = _state;
        this.updateOverState();
    }

    public function set setOffState(_state:Object ):void {
        _offState = _state;
        this.updateOffState();
    }


    public function get overState():Object {
        return _overState;
    }

    public function get offState():Object {
        return _offState;
    }

    public function get currentGroupState():Object {
        return _currentGroupState;
    }

}
}
