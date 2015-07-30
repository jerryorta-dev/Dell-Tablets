package com.dell.graphics.components.buttons
{
	import com.dell.graphics.components.core.abstract.AbstractGraphic;
	import com.dell.graphics.components.core.interfaces.IGraphic;
	
	import flash.display.Shape;
	
	public class GalleryButton_Default_Off extends AbstractGraphic implements IGraphic
	{
		private const RECT_WIDTH:Number = 24;
		private const RECT_HEIGHT:Number = 10;
		private const FILL_COLOR:uint = 0xAAAAAA;
		private const RADIUS:Number = 3;
		private const STROKE_COLOR:uint = 0xffffff;
		private const STROKE_WEIGHT:Number = 0;
		
		
		override public function draw():void
		{
			var rect:Shape = new Shape();
//			rect.graphics.lineStyle( this.STROKE_WEIGHT, this.STROKE_COLOR, 1, true);
			rect.graphics.beginFill( this.FILL_COLOR, 1 );
			rect.graphics.drawRoundRect( 0, 0, this.RECT_WIDTH, this.RECT_HEIGHT, this.RADIUS );
			rect.graphics.endFill();
			rect.x = 0;
			rect.y = 0;
			addChild( rect );
		}
		
		override public function initialize():void
		{
			
		}
	}
}