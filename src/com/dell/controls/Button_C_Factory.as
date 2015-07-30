/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 8:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls {
import com.dell.controls.components.buttons.cameras.Camera_DefaultView;
import com.dell.controls.components.buttons.galleries.GalleryNavButton_CalloutView;
import com.dell.controls.components.buttons.galleries.GalleryNavButton_DefaultView;
import com.dell.controls.components.buttons.galleries.GalleryNavOverImageLeft;
import com.dell.controls.components.buttons.galleries.GalleryNavOverImageRight;
import com.dell.controls.components.buttons.nav.Main_Nav_Tablets;
import com.dell.controls.components.buttons.rotate.Rotate360_DefaultView;
import com.dell.controls.components.buttons.zoom.ZoomIN_DefaultView;
import com.dell.controls.components.buttons.zoom.ZoomOUT_DefaultView;
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;

public class Button_C_Factory extends AbstractButtonFactory {

    public static const GALLERY_TABLETS_DEFAULT:uint = 0;
    public static const GALLERY_TABLETS_WITH_CALLOUT:uint = 2;
    public static const CAMERA_DEFAULT:uint = 3;
    public static const ROTATE_360_DEFAULT:uint = 4;
    public static const ZOOM_IN_DEFAULT:uint = 5;
    public static const ZOOM_OUT_DEFAULT:uint = 6;
    public static const GALLERY_NAV_OVER_IMAGE_LEFT:uint = 7;
    public static const GALLERY_NAV_OVER_IMAGE_RIGHT:uint = 8;

    public static const MAIN_NAV_TABLETS:uint = 9;


    override protected function createComponent( name:String, graphicType:uint, vars:Object = null, data:Object = null ):AbstractButton {
        if (graphicType == GALLERY_TABLETS_DEFAULT) {
            return new GalleryNavButton_DefaultView( name, vars, data  );
        } else if (graphicType == GALLERY_TABLETS_WITH_CALLOUT) {
            return new GalleryNavButton_CalloutView( name, vars, data );
        } else if (graphicType == CAMERA_DEFAULT) {
            return new Camera_DefaultView( name, vars, data  );
        } else if (graphicType == ROTATE_360_DEFAULT) {
            return new Rotate360_DefaultView( name, vars, data );
        } else if (graphicType == ZOOM_IN_DEFAULT) {
            return new ZoomIN_DefaultView( name, vars, data );
        } else if (graphicType == ZOOM_OUT_DEFAULT) {
            return new ZoomOUT_DefaultView( name, vars, data );
        } else if (graphicType == GALLERY_NAV_OVER_IMAGE_LEFT) {
            return new GalleryNavOverImageLeft( name, vars, data );
        } else if (graphicType == GALLERY_NAV_OVER_IMAGE_RIGHT) {
            return new GalleryNavOverImageRight( name, vars, data );
        } else  if (graphicType == MAIN_NAV_TABLETS) {
            return new Main_Nav_Tablets( name, vars, data );
        } else {
            throw new Error("Invalid kind of progressB specified");
            return null;
        }
    }
}
} 
