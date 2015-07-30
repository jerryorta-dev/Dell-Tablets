package com.dell.graphics.components.core.abstract
{
	import com.dell.errors.AbstractMethodError;
	
	import flash.display.Sprite;

	public class AbstractGraphicFactory
	{
		public function AbstractGraphicFactory()
		{
//			throw new AbstractClassError();
		}
		
		public function add( graphicType:uint, target:Sprite, xPos:Number, yPos:Number, vars:Object = null ):AbstractGraphic {
			var _graphic:AbstractGraphic = this.createGraphic( graphicType, vars );
			_graphic.draw();
			_graphic.setLoc( xPos, yPos ); 
			target.addChild( _graphic );
			_graphic.initialize();
			return _graphic;
		}
		
		protected function createGraphic( graphicType:uint, vars:Object = null ):AbstractGraphic {
		 	throw new AbstractMethodError;
			return null;
		}
	}
}