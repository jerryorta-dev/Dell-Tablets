package com.dell.graphics.components.backgrounds
{
	import com.dell.graphics.components.core.abstract.AbstractGraphic;
	import com.dell.graphics.components.core.interfaces.IGraphic;
	
	import flash.display.Shape;
	

	public class Background_Default extends AbstractGraphic implements IGraphic
	{
		
		private const RECT_WIDTH:Number = 467;
		private const RECT_HEIGHT:Number = 34;
		private const FILL_COLOR:uint = 0xf9f9f9;
		private const RADIUS:Number = 5;
		private const STROKE_COLOR:uint = 0xa6a6a7;
		private const STROKE_WEIGHT:Number = 1;
		
		override public function draw():void {

			var rect:Shape = new Shape();
			rect.graphics.lineStyle( this.STROKE_WEIGHT, this.STROKE_COLOR, 1, true);
			rect.graphics.beginFill( this.FILL_COLOR, 1 );
			rect.graphics.drawRoundRect( 0, 0, this.RECT_WIDTH, this.RECT_HEIGHT, this.RADIUS );
			rect.graphics.endFill();
			rect.x = 0;
			rect.y = 0;
			addChild( rect );
			
		}
		
		override public function initialize():void {
			
		}
	}
}