/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 8:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.controls.components.lists.lib.List_UI_Button_GalleryNav;
import com.dell.controls.components.lists.lib.List_UI_Button_Rotate360Gallery;
import com.dell.controls.components.zoom.lib.ZoomDefault;

public class Zoom_UI_Factory extends AbstractUIFactory {

    public static const BUTTONS_ZOOM:uint = 0;


    override protected function createComponent( graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
        if (graphicType == BUTTONS_ZOOM) {
            return new ZoomDefault();
        }  else {
            throw new Error("Invalid kind of progressB specified");
            return null;
        }
    }
}
}
