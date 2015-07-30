/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 5:28 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.lists.mvc.control {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.lists.mvc.model.IListModel;

import flash.events.MouseEvent;

public class ListController implements IListController {

    protected var model:IListModel;

    public function ListController( aModel:IListModel ) {
        this.model = aModel;
    }

    public function onClickEventHandler(event:MouseEvent):void {
        var buttenEventObject:Object = {};

        buttenEventObject.name = event.target.name;
        buttenEventObject.state = AbstractButton.ON;

        this.model.setOnState = buttenEventObject;
    }

    public function manualClick( _name:String ):void {
        var buttenEventObject:Object = {};

        buttenEventObject.name = _name;
        buttenEventObject.state = AbstractButton.ON;

        this.model.setOnState = buttenEventObject;
    }

    public function onRollOverEventHandler(event:MouseEvent):void {
        var buttenEventObject:Object = {};

        buttenEventObject.name = event.target.name;
        buttenEventObject.state = AbstractButton.OVER;

        this.model.setOverState = buttenEventObject;
    }

    public function onRollOutEventHandler(event:MouseEvent):void {
        var buttenEventObject:Object = {};

        buttenEventObject.name = event.target.name;
        buttenEventObject.state = AbstractButton.OFF;

        this.model.setOffState = buttenEventObject;
    }

    public function setInitialState( buttonName:String, state:String ):void
    {
        var buttenEventObject:Object = {};
        buttenEventObject.name = buttonName;
        buttenEventObject.state = state;

        if (state == AbstractButton.ON) {
            this.model.setOnState = buttenEventObject;
        }

        if (state == AbstractButton.OVER) {
            this.model.setOverState = buttenEventObject;
        }

        if (state == AbstractButton.OFF) {
            this.model.setOffState = buttenEventObject;
        }
    }

    public function selectItem( buttonName:String ):void {
        var buttenEventObject:Object = {};
        buttenEventObject.name = buttonName;
        buttenEventObject.state = AbstractButton.ON;
        this.model.setOnState = buttenEventObject;
    }

    public function selectItemNoDispatch( buttonName:String ):void {
        var buttenEventObject:Object = {};
        buttenEventObject.name = buttonName;
        buttenEventObject.state = AbstractButton.ON;
        this.model.setOnStateNoEventDispatch = buttenEventObject;
    }
}
}
