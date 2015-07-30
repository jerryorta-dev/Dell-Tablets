/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 10:18 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.core.abstract {
import com.dell.controls.components.core.interfaces.IButtonState;
import com.dell.errors.AbstractMethodError;
import com.dell.events.UIEvent;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class AbstractButton  extends Sprite {

    public static const ON:String = "on";
    public static const OFF:String = "off";
    public static const OVER:String = "over";
    protected var _state:String;

	protected var _data:Object;
    protected var _vars:Object;

    public function AbstractButton( ) {
		
    }

    public function setLoc(xLoc:int, yLoc:int):void {
        this.x = xLoc;
        this.y = yLoc;
    }

    public function commitProperties():void {

    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function draw():void {
        throw new AbstractMethodError();
    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function initialize():void {
        throw new AbstractMethodError();
    }

    public function on( event:MouseEvent = null ):void {

    }

    public function over( event:MouseEvent = null ):void {

    }

    public function off( event:MouseEvent = null ):void {

    }

    //This is overwritten
    public function getStateClass():IButtonState {
        return null;
    }


    public function get state():String {
        return _state;
    }

    public function set state(value:String):void {
        _state = value;
    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function setOnState( event:UIEvent = null ):void {

    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function setOverState( event:UIEvent = null ):void {

    }

    // ABSTRACT Method (must be overridden in a subclass)
    public function setOffState( event:UIEvent = null ):void {

    }
}
}
