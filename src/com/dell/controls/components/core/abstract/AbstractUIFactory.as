package com.dell.controls.components.core.abstract
{
	import com.dell.errors.AbstractMethodError;
	
	import flash.display.Sprite;

	public class AbstractUIFactory
	{
		
		public function add( componentType:uint, target:Sprite, xPos:Number, yPos:Number, vars:Object = null, data:Object = null):AbstractUI {
			var _component:AbstractUI = this.createComponent( componentType, vars, data );
			_component.commitProperties();
            _component.draw();
			_component.setLoc( xPos, yPos );
			target.addChild( _component );
			_component.initialize();
			return _component;
		}
		
		protected function createComponent( graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
		 	throw new AbstractMethodError;
			return null;
		}
	}
}