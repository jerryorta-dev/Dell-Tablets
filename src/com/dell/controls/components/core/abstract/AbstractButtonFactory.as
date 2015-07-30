package com.dell.controls.components.core.abstract
{
	import com.dell.errors.AbstractMethodError;
	
	import flash.display.Sprite;

	public class AbstractButtonFactory
	{

		public function add( name:String,  componentType:uint, target:Sprite, xPos:Number, yPos:Number, vars:Object = null, data:Object = null ):AbstractButton {
			var _component:AbstractButton = this.createComponent( name, componentType, vars, data );
			_component.draw();
			_component.setLoc( xPos, yPos );
			target.addChild( _component );
			_component.initialize();
			return _component;
		}
		
		protected function createComponent(name:String, graphicType:uint, vars:Object = null, data:Object = null ):AbstractButton {
		 	throw new AbstractMethodError;
			return null;
		}
	}
}