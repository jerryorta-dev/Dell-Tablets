package com.dell.graphics
{
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.AbstractGraphicFactory;
import com.dell.graphics.components.shapes.Rectangle;

public class RectangleFactory extends AbstractGraphicFactory
	{
		public static const RECTANGLE_WITH_VARS		:uint = 0;

		override protected function createGraphic( graphicType:uint, vars:Object = null ):AbstractGraphic {
			if (graphicType == RECTANGLE_WITH_VARS) {
				return new Rectangle( vars );
			} else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	
	}
}