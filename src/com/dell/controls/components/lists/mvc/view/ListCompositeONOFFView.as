/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 5:00 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.lists.mvc.view {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.lists.mvc.view.core.AbstractListCompositeView;
import com.dell.events.UIEvent;

import flash.events.MouseEvent;

public class ListCompositeONOFFView extends ListCompositeView {
    public function ListCompositeONOFFView(aModel:Object, aController:Object) {
        super(aModel, aController);

        //Add Event Listeners
    }


    override public function add(c:AbstractButton):void {
        aChildren.push(c);
//        c.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        c.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
        c.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
    }



    override protected function onRollOver(event:MouseEvent):void {
        super.onRollOver( event );
    }

    override protected function onRollOut(event:MouseEvent):void {
        super.onRollOut( event );
    }

}
}
