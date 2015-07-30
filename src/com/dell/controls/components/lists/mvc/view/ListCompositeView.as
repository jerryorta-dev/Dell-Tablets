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

public class ListCompositeView extends AbstractListCompositeView {
    public function ListCompositeView(aModel:Object, aController:Object) {
        super(aModel, aController);

        //Add Event Listeners
    }


    override public function add(c:AbstractButton):void {
        aChildren.push(c);
        c.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        c.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
        c.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
    }

    protected function onClick(event:MouseEvent):void {
        // delegate to the controller (strategy) to handle map type change
        controller.onClickEventHandler(event);
    }

    protected function onRollOver(event:MouseEvent):void {
        controller.onRollOverEventHandler(event);
    }

    protected function onRollOut(event:MouseEvent):void {
        controller.onRollOutEventHandler(event);
    }


    override public function setOnState(event:UIEvent = null):void {
        for each (var c:AbstractButton in aChildren) {
            if (c.name == this.model.currentGroupState.name) {
                c.on();
            } else {
                c.off();
            }
        }
    }

    override public function setOverState(event:UIEvent = null):void {
        for each (var c:AbstractButton in aChildren) {
            if (c.name == this.model.overState.name) {
                c.over();
            }
        }
    }

    override public function setOffState(event:UIEvent = null):void {
        for each (var c:AbstractButton in aChildren) {
            if ( this.model.currentGroupState != null) {
                if (c.name != this.model.currentGroupState.name) {
                    c.off();
                }
            } else {
                c.off();
            }
        }
    }


}
}
