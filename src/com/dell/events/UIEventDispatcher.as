/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/2/13
 * Time: 8:20 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.events {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class UIEventDispatcher extends EventDispatcher {
    public function UIEventDispatcher(target:IEventDispatcher = null) {
        super(target);
    }

    public function dispatchUIEvent( eventType:String, data:Object = null ):void {
        dispatchEvent(new UIEvent( eventType, data ));
    }
}
}
