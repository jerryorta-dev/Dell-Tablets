package com.dell.controls
{
	import com.dell.controls.components.UIComposites.galleryZoomScrub.UI_SliderGalleryZoom;
	import com.dell.controls.components.core.abstract.AbstractUI;
	import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.controls.components.image.ImageItem;
import com.dell.controls.components.image.SWF360Item;
import com.dell.events.UIEvent;

	
	
	/**
	 * <p>
	 *  Archive of pre-built user interfaces.
	 * </p>
	 * <p>Example </p>
	 * <p>
	 * 	var cf:UIFactory = new UIFactory(); <br>
	 * 		var myUI:AbstractUI = cf.add( UIFactory.SLIDER_GALLERY_ZOOM_TABLETS_DEFAULT, this, 50, 50); <br>
     * 	    myUI.addEventListener( UIEvent.NAV_ITEM_SELECT, this.testUI, false, 0, true); <br>
     * 	    myUI.addEventListener( UIEvent.SCRUBBING, this.testUI, false, 0, true); <br>
     * 	    myUI.addEventListener( UIEvent.SCRUB_COMPLETE, this.testUI, false, 0, true); <br>
     * 	    myUI.addEventListener( UIEvent.GALLERY_ITEM_SELECT, this.testUI, false, 0, true); <br>
     * 	    myUI.addEventListener( UIEvent.ZOOMIMG, this.testUI, false, 0, true); <br>
     * 	    myUI.addEventListener( UIEvent.ZOOM_COMPLETE, this.testUI, false, 0, true); <br>
	 * </p>
	 * 
	 * @author Jerry_Orta
	 * 
	 */	
	public class Display_UI_Factory extends AbstractUIFactory
	{
		public static const IMAGE_WITH_ZOOM			:int = 0;
        public static const SWF_360_WITH_ZOOM                 :int = 1;

		override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
			if (graphicType == IMAGE_WITH_ZOOM) {
				return new ImageItem(vars, data );
			} if (graphicType == SWF_360_WITH_ZOOM) {
                return new SWF360Item(vars, data );
            } else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	}
}