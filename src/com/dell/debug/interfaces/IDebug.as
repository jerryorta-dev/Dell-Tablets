package com.dell.debug.interfaces
{
	public interface IDebug
	{
        function init( obj:* ):void;
		function trace(caller:* = null, object:* = null, person:String = null, label:String = null, color:uint = 0x000000, depth:int = 5):void;
		function setCaller( obj:*, _doTrace:Boolean = false ):void;
		function setObject( obj:*, _doTrace:Boolean = false ):void;
        function setLabel( label:String, _doTrace:Boolean = false ):void;
		function setPerson( str:String, _doTrace:Boolean = false ):void;
		function setColor( color:uint, _doTrace:Boolean = false ):void;
		function setDepth( depth:int, _doTrace:Boolean = false ):void;
	}
	
	
}