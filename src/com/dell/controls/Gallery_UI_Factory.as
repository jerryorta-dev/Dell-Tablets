package com.dell.controls {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.controls.components.galleries.GalleryImageDefault;
import com.dell.controls.components.galleries.UI_GalleryImageNoThrowProps_Fade;


import com.dell.controls.components.galleries.UI_GalleryImageNoThrowProps;

public class Gallery_UI_Factory extends AbstractUIFactory {
    public static const GALLERY_IMAGE_DEFAULT:uint = 0;
    public static const UI_IMAGE_GALLERY_NO_THROW_PROPS:uint = 1;
    public static const GALLERY_SINGLE_SWF_360:uint = 2;
    public static const UI_IMAGE_GALLERY_NO_THROW_PROPS_FADE:uint = 3;
    public static const UI_GALLERY_NO_THROW_PROPS_XPS11:uint = 4;

    override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
        if (graphicType == GALLERY_IMAGE_DEFAULT) {
            return  new GalleryImageDefault(vars, data);
        }
        if (graphicType == UI_IMAGE_GALLERY_NO_THROW_PROPS) {
            return  new UI_GalleryImageNoThrowProps(vars, data);
        }
        if (graphicType == UI_IMAGE_GALLERY_NO_THROW_PROPS_FADE) {
            return  new UI_GalleryImageNoThrowProps_Fade(vars, data);
        }
        if (graphicType == GALLERY_SINGLE_SWF_360) {
//                return new GallerySWF360ThrowProps( vars, data );
            return null;
        } else {
            throw new Error("Invalid kind of progressB specified");
            return null;
        }
    }

}
}