package com.dell.graphics
{
	import com.dell.graphics.components.buttons.SliderScrubber_Default;
	import com.dell.graphics.components.core.abstract.AbstractGraphic;
	import com.dell.graphics.components.core.abstract.AbstractGraphicFactory;


	public class ScrubberButtonGraphicFactory extends AbstractGraphicFactory
	{
		
		public static const SCRUBBER_GRAPHIC_CENTER_REG		:uint = 0;

		override protected function createGraphic( graphicType:uint, vars:Object = null ):AbstractGraphic {
			if (graphicType == SCRUBBER_GRAPHIC_CENTER_REG) {
				return new SliderScrubber_Default(); 
			} else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	}
}