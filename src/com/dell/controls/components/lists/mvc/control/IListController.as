/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 5:27 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.lists.mvc.control {
import flash.events.MouseEvent;

public interface IListController {
    function onClickEventHandler(event:MouseEvent):void;

    function onRollOverEventHandler(event:MouseEvent):void;

    function onRollOutEventHandler(event:MouseEvent):void;

    function setInitialState( buttonName:String, state:String ):void;

    function selectItem( buttonName:String ):void;

    function selectItemNoDispatch( buttonName:String ):void;

    function manualClick( _name:String ):void;
}
}
