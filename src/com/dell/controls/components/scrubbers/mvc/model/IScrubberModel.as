﻿package com.dell.controls.components.scrubbers.mvc.model {import com.dell.events.UIEvent;import flash.events.IEventDispatcher;public interface IScrubberModel extends IEventDispatcher {    function get state():Number;    function get eventUpdateObjectFromController():Number;    function set eventUpdateObjectFromController(value:Number):void;    function get eventCompleteObjectFromController():Number;    function set eventCompleteObjectFromController(value:Number):void;}}