package com.dell.screens
{
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.screens.lib.UI_Gallery360ZoomScreen_FLAT;

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
	public class ScreenFactory extends AbstractUIFactory
	{
		public static const UI_GALLERY_360_FLAT_UI			:int = 01;

		override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
			if  (graphicType == UI_GALLERY_360_FLAT_UI) {
                return new UI_Gallery360ZoomScreen_FLAT( vars, data );
            } else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	}
}