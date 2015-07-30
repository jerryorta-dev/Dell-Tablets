package com.dell.graphics.components.buttons
{
	import com.dell.graphics.components.core.abstract.AbstractGraphic;
	import com.dell.graphics.components.core.interfaces.IGraphic;
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * Graphic must have a vertically and horizontally centered registration  
	 * @author Jerry_Orta
	 * 
	 */	
	public class SliderScrubber_Default extends AbstractGraphic implements IGraphic
	{
		private const RECT_WIDTH:Number = 18;
		private const RECT_HEIGHT:Number = 22;
		
		//Center in Sprite
		private const RECT_X_POS:Number = -9;
		private const RECT_Y_POS:Number = -11;
		
//		private const BEGIN_FILL_COLOR:uint = 0xdae2e4;
		private const BEGIN_FILL_COLOR:uint = 0xFFFFFF;
		private const END_FILL_COLOR:uint = 0xa7b9c2;
		private const STROKE_COLOR:uint = 0x95aab5;
		private const STROKE_WEIGHT:uint = 1;
		private const RADIUS:Number = 3.5;
		
		private const GRABBER_DARK:uint = 0x999999;
		private const GRABBER_LIGHT:uint = 0xFFFFFF;
		
		private const NUM_OF_GRABBERS:int = 3;
		private const GRABBER_XPOS:Number = 4;
		private const GRABBER_GAP:int = 3;
		private const GRABBER_WEIGHT:int = 1;


		override public function draw():void {

			this.createBackground( this.RECT_X_POS, this.RECT_Y_POS);

			var yPos:int = 7;
			
			for (var i:int = 0; i < NUM_OF_GRABBERS; i++) {
				createRectangle(GRABBER_XPOS, yPos, 10, GRABBER_WEIGHT, GRABBER_DARK);
				yPos += GRABBER_WEIGHT;
				createRectangle(GRABBER_XPOS, yPos, 10, GRABBER_WEIGHT, GRABBER_LIGHT);
				yPos += GRABBER_GAP;
			}

		}

		override public function initialize():void {
			
		}
		
		private function createRectangle(xPos:Number, yPos:Number, w:Number, h:Number, color:Number):void
		{
			var rect:Shape = new Shape();
			rect.graphics.beginFill( color, 1);
			rect.graphics.drawRect(0, 0, w, h);
			rect.graphics.endFill();
			rect.x = this.RECT_X_POS + xPos;
			rect.y = this.RECT_Y_POS + yPos;
			addChild( rect );
		}
		
		private function createBackground(xPos:Number, yPos:Number):void
		{
			var myMatrix:Matrix = new Matrix();
			myMatrix.createGradientBox(this.RECT_HEIGHT, this.RECT_WIDTH, 90, -10);
			
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(STROKE_WEIGHT, STROKE_COLOR, 1, true);
			rect.graphics.beginGradientFill( GradientType.LINEAR, [BEGIN_FILL_COLOR, END_FILL_COLOR], [1, 1],[0, 230] ,myMatrix );
			rect.graphics.drawRoundRect(0, 0, this.RECT_WIDTH, this.RECT_HEIGHT, RADIUS);
			rect.graphics.endFill();
			
			rect.x = xPos;
			rect.y = yPos;
			addChild( rect );
		}




	}
}