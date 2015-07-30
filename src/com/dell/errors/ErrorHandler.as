package com.dell.errors
{
	
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	public class ErrorHandler extends Sprite
	{
		public function ErrorHandler()
		{
		}
			
		
		public static function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("****************************************************************");
			trace("securityErrorHandler: " + event);
		}
		
		public static function onIOError(e:IOErrorEvent):void {  
			trace("****************************************************************");
			trace("Error loading URL. " + e);  
		} 
		
		
	}
}