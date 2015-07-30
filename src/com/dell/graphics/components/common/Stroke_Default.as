package com.dell.graphics.components.common
{
	import com.dell.graphics.components.core.abstract.AbstractGraphic;
	import com.dell.graphics.components.core.interfaces.IGraphic;
	
	import flash.display.*;

	
	public class Stroke_Default extends AbstractGraphic implements IGraphic
	{
		private var _length:Number = 24;
		private const THICKNESS:Number = 1;
		private const PIXEL_HINTING:Boolean = false;
		private const SCALE_MODE:String = "normal";
		private const CAPS:String = CapsStyle.ROUND;
		private const JOINTS:String = JointStyle.ROUND;
		private const MITER_LIMIT:Number = 3.0;
		private const FILL:IGraphicsFill = new GraphicsSolidFill(0xCCCCCC);
		
		private var shape:Shape;
		private var drawing:Vector.<IGraphicsData>;
		
		override public function draw():void {
			
			shape = new Shape();
			var _stroke:GraphicsStroke = new GraphicsStroke( this.THICKNESS, this.PIXEL_HINTING, this.SCALE_MODE, this.CAPS, this.JOINTS, this.MITER_LIMIT, this.FILL);
			//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Graphics.html#drawGraphicsData()
			
			// establish the path properties
			var pathCommands:Vector.<int> = new Vector.<int>(2, true);
			pathCommands[0] = GraphicsPathCommand.MOVE_TO;
			pathCommands[1] = GraphicsPathCommand.LINE_TO;

			var pathCoordinates:Vector.<Number> = new Vector.<Number>(4, true);
			pathCoordinates[0] = 0;
			pathCoordinates[1] = 0;
			pathCoordinates[2] = 0;
			pathCoordinates[3] = 24;
			

			
			var myPath:GraphicsPath = new GraphicsPath(pathCommands, pathCoordinates);

			
			// populate the IGraphicsData Vector array
			drawing = new Vector.<IGraphicsData>(2, true);
			drawing[0] = _stroke;
			drawing[1] = myPath;
			
			// render the drawing
			shape.graphics.drawGraphicsData( drawing );
			shape.x = shape.y = 0;
			
			this.addChild( shape );
		}
		
		override public function initialize():void {
			
		}
		
		public function set length(val:Number):void {
			this.removeChild( shape );
			this.shape = null;
			drawing = null;
			_length = val;
			this.draw();
		}
		
		public function get length():Number {
			return _length;
		}
	}
}