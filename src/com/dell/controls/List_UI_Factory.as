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

public class List_UI_Factory extends AbstractUIFactory {

    public static const LIST_UI_BUTTONS_GALLERY_NAV:uint = 0;
    public static const LIST_UI_BUTTONS_360_GALLERY:uint = 1;

    override protected function createComponent( graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
        if (graphicType == LIST_UI_BUTTONS_GALLERY_NAV) {
            return new List_UI_Button_GalleryNav(vars, data );
        } else if (graphicType == LIST_UI_BUTTONS_360_GALLERY) {
            return new List_UI_Button_Rotate360Gallery( data );
        } else {
            throw new Error("Invalid kind of progressB specified");
            return null;
        }
    }
}
}
