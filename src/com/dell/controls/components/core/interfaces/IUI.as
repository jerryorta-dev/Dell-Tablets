package com.dell.controls.components.core.interfaces {
import com.dell.events.UIEvent;

import flash.events.Event;

public interface IUI {
    function commitProperties(event:Event = null):void;

    function draw():void;

    function initialize():void;

    function eventDispatcher(event:UIEvent):void;

    //Composite functions
    function activateComposite():Boolean;

    function deactivateComposite():Boolean;

    function disposeComposite():Boolean;
}
}