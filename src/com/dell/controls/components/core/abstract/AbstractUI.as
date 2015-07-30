package com.dell.controls.components.core.abstract {
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.errors.AbstractMethodError;
import com.dell.events.UIEvent;
import com.greensock.events.LoaderEvent;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

public class AbstractUI extends Sprite implements IUI {

    protected var _vars:Object;
    protected var _data:Object;
    protected var _isActivated:Boolean = false;
    protected var _uiArray:Vector.<AbstractUI>;
    protected var parentNode:AbstractUI = null;
    protected var _bounds:Rectangle;

    public function AbstractUI(vars:Object = null, data:Object = null) {
        //In case subclass has not applied data yet
//        if (this._data == null) {
//            _data = data;
//        }

        //In case subclass has not applied vars yet
		this._vars = ( vars != null) ? vars : {};
		this._data = ( data != null) ? data : {};

		

        _uiArray = new Vector.<AbstractUI>();

        //            if (this.stage){
//                commitProperties();
//            }else{
//                addEventListener(Event.ADDED_TO_STAGE, commitProperties);
//            }
    }

    public function setLoc(xLoc:int, yLoc:int):void {
        this.x = xLoc;
        this.y = yLoc;
    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function commitProperties(event:Event = null):void {
        throw new AbstractMethodError();
    }


    // ABSTRACT Method (must be overridden in a subclass)
    public function draw():void {
        throw new AbstractMethodError();
    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function initialize():void {
        throw new AbstractMethodError();
    }

    public function get data():Object {
        return _data;
    }

    public function set data(value:Object):void {
        _data = value;
    }

    public function addToComposite( ui:AbstractUI ):void {
        _uiArray.push(ui);
        ui.setCompositeParent(this); //Not sure if this is needed
//        this.addChild( ui );
    }

    public function activateComposite():Boolean {

        if (!this._isActivated) {
            this._isActivated = true;
//            trace("activateComposite " + this.name);

            const len:int = _uiArray.length;

            for ( var i:uint = 0; i < len; i++ ) {
                _uiArray[i].activateComposite();
            }

        }

        return true;
    }

    public function deactivateComposite():Boolean {

//        if (this._isActivated) {

            this._isActivated = false;
//            trace("deactivateComposite " + this.name);

            const len:int = _uiArray.length;

            for ( var i:uint = 0; i < len; i++ ) {
                _uiArray[i].deactivateComposite();
            }
//        }

        return true;
    }

    public function disposeComposite():Boolean {

        const len:int = _uiArray.length;

        for ( var i:uint = 0; i < len; i++ ) {
            _uiArray[i].disposeComposite();
//            this.removeChild( _uiArray[i]);
            _uiArray[i] = null;
        }

        return true;
    }

    internal function setCompositeParent(compositeNode:AbstractUI):void {
        this.parentNode = compositeNode;
    }

    public function eventDispatcher(event:UIEvent):void {
        if (this._isActivated) {
            dispatchEvent( event );
        }
    }

    public function get bounds():Rectangle {
        return _bounds;
    }

    public function set bounds(value:Rectangle):void {
        _bounds = value;
    }

//       public function setUpHiResSWF( event:LoaderEvent ):void {
//
//    }


}
}