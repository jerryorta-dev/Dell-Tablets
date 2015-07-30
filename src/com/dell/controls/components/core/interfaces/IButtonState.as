/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:16 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.core.interfaces {
import flash.events.MouseEvent;

public interface IButtonState {

    function on( event:MouseEvent = null ):void;
    function off( event:MouseEvent = null ):void;
    function over( event:MouseEvent = null ):void;
    function get name():String;
    function set name(value:String):void;

}
}
