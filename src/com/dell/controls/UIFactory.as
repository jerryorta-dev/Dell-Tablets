package com.dell.controls
{
	import com.dell.controls.components.UIComposites.galleryZoomScrub.UI_SliderGalleryZoom;
	import com.dell.controls.components.core.abstract.AbstractUI;
	import com.dell.controls.components.core.abstract.AbstractUIFactory;
   import com.dell.controls.components.shape.UI_Rectangle;


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
	public class UIFactory extends AbstractUIFactory
	{
		public static const SLIDER_GALLERY_ZOOM_TABLETS_DEFAULT			:int = 0;
        public static const UI_Rectangle_GRAPHIC                                :int = 1;

		override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
			if ( graphicType == SLIDER_GALLERY_ZOOM_TABLETS_DEFAULT ) {
				return new UI_SliderGalleryZoom(vars, data );
			} if ( graphicType == UI_Rectangle_GRAPHIC ) {
                return new UI_Rectangle(vars );
            } else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	}
}