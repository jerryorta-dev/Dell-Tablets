/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 8:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls {
import com.dell.controls.components.callouts.C_Callout_Default;
import com.dell.controls.components.callouts.C_Callout_Rectangle_Header_Copy;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;

public class Callout_C_Factory extends AbstractUIFactory {

    public static const DEFAULT_CALLOUT:uint = 0;
    public static const CALLOUT_HEADER_COPY:uint = 1;

    override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
        if (graphicType == DEFAULT_CALLOUT) {
            return new C_Callout_Default( vars, data );
        } if (graphicType == CALLOUT_HEADER_COPY) {
            return new C_Callout_Rectangle_Header_Copy( vars, data );
        } else {
            throw new Error("Invalid kind of factory class specified");
            return null;
        }
    }
}
}
