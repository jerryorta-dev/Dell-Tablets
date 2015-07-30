package com.dell.graphics.components.core.abstract
{
	import com.dell.errors.AbstractMethodError;
	
	import flash.display.Sprite;

	public class AbstractGraphic extends Sprite
	{
		public function AbstractGraphic()
		{
//			throw new AbstractClassError();
		}
		
		public function setLoc(xLoc:int, yLoc:int):void {
			this.x = xLoc;
			this.y = yLoc;
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		public function draw():void {
			throw new AbstractMethodError();
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		public function initialize():void {
			throw new AbstractMethodError();
		}

        public function set radius(value:Number):void {
            throw new AbstractMethodError();
        }

        public function get radius():Number {
            throw new AbstractMethodError();
        }
	}
}