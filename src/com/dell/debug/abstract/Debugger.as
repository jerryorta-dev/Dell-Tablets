package com.dell.debug.abstract
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.dell.debug.interfaces.IDebug;
	
	import flash.errors.IllegalOperationError;

	public class Debugger implements IDebug
	{
		public static var _caller:*;
		public static var _object:*;
		public static var _person:String;
		public static var _label:String;
		public static var _color:int;
		public static var _depth:int;
		private var _traceNow:Boolean = false;
		
		public function Debugger()
		{
			
		}
		
		
		public function init( obj:* ):void {
			// Start the MonsterDebugger
			MonsterDebugger.initialize( obj );
			Debugger._caller = obj;
			MonsterDebugger.trace(obj, "Initializing MonsterDebugger");
		}
		
		public function trace(caller:* = null, object:* = null, person:String = null, label:String = null, color:uint = 0x000000, depth:int = 5):void {

			if (_caller == null) {
				if (caller != null) {
					_caller = caller;
				} else {
					throw new IllegalOperationError("Must pass a caller trace.");
				}
			} else {
				_caller = (caller != null) ? caller : _caller;
			}
			
			if (_object == null) {
				if (object != null) {
					_object = object;
				} else {
					throw new IllegalOperationError("Must pass a object trace.");
				}
			} else {
				_object = (object != null) ? object : _object;
			}
			
			_label = ( label != null ) ? label : _label;
			
			//Condition is reversed - if not _color, then use default in signature
			_color = ( !_color ) ? color : _color;
			_depth = ( !_depth ) ? depth : _depth;
			
			MonsterDebugger.trace(_caller, _object, _person, _label, _color, _depth);

		}
		
		
		
		private function doTrace():void {
			if (_traceNow) {
				MonsterDebugger.trace(_caller, _object, _person, _label, _color, _depth);
			}
		}
		
		public function setCaller( obj:*, _doTrace:Boolean = false ):void {
			_caller = obj;
			_traceNow = (_doTrace) ? _doTrace : false;
			doTrace();
		}
		
		public function setObject( obj:*, _doTrace:Boolean = false ):void {
			_object = obj;
			_traceNow = (_doTrace) ? _doTrace : false;
			doTrace();
		}
		
		public function setPerson( str:String, _doTrace:Boolean = false ):void {
			_person = str;
			_traceNow = (_doTrace) ? _doTrace : false;
			doTrace();
		}
		
		public function setColor( color:uint, _doTrace:Boolean = false ):void {
			_color = color;
			_traceNow = (_doTrace) ? _doTrace : false;
			doTrace();
		}
		
		public function setLabel( label:String, _doTrace:Boolean = false ):void {
			_label = label;
			_traceNow = (_doTrace) ? _doTrace : false;
			doTrace();
		}
		
		public function setDepth( depth:int, _doTrace:Boolean = false ):void {
			_depth = depth;
			_traceNow = (_doTrace) ? _doTrace : false;
			doTrace();
		}
		
		public function get traceNow():Boolean
		{
			return _traceNow;
		}
		
		public function set traceNow(value:Boolean):void
		{
			_traceNow = value;
		}

	}
}