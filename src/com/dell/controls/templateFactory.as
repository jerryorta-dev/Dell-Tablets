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
import com.dell.controls.components.templateMVCFactory.lib.MVC_Wrapper;

public class TemplateFactory extends AbstractUIFactory {

    public static const MVC_WRAPPER:uint = 0;

    override protected function createComponent(graphicType:uint, vars:Object = null):AbstractUI {
        if (graphicType == MVC_WRAPPER) {
            return new MVC_Wrapper();
        } else {
            throw new Error("Invalid kind of factory class specified");
            return null;
        }
    }
}
}
