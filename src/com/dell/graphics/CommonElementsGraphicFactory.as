package com.dell.graphics
{
import com.dell.graphics.components.buttons.GalleryButton_Default_Off;
import com.dell.graphics.components.buttons.GalleryButton_Default_On;
import com.dell.graphics.components.common.Stroke_Default;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.AbstractGraphicFactory;
import com.dell.graphics.components.shapes.CallOutGraphic;

public class CommonElementsGraphicFactory extends AbstractGraphicFactory
	{
		public static const STROKE_DIVIDER		:uint = 0;
		public static const GALLERY_BUTTON_ON	:uint = 1;
		public static const GALLERY_BUTTON_OFF	:uint = 2;

        public static const CALLOUT_DEFAULT     :uint = 3;

		override protected function createGraphic( graphicType:uint, vars:Object = null ):AbstractGraphic {
			if (graphicType == STROKE_DIVIDER) {
				return new Stroke_Default(); 
			} else if (graphicType == GALLERY_BUTTON_ON) {
				return new GalleryButton_Default_On(); 
			} else if (graphicType == GALLERY_BUTTON_OFF ) {
				return new GalleryButton_Default_Off(); 
			} else if (graphicType == CALLOUT_DEFAULT) {
                return new CallOutGraphic( vars );
            } else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	
	}
}