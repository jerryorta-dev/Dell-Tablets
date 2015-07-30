/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/3/13
 * Time: 3:46 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.zoom.mvc.model {
import com.dell.controls.components.lists.mvc.model.*;
import com.dell.controls.components.zoom.mvc.model.IZoomDefaultModel;
import com.dell.events.UIEvent;

import flash.events.IEventDispatcher;

public class ZoomDefaultModel extends ListModel implements IZoomDefaultModel {
    public function ZoomDefaultModel(target:IEventDispatcher = null) {
        super(target);
    }

    private var _zoomValue:Number = 1;

    public function zoomIn( value:Number ):void {
//        trace( value )
        _zoomValue = value;
        dispatchEvent( new UIEvent( UIEvent.ZOOMIMG, _zoomValue));
    }

    public function zoomOut(value:Number):void {
//        trace( value )
        _zoomValue = value;
        dispatchEvent( new UIEvent( UIEvent.ZOOMIMG, _zoomValue));
    }

    public function zoomComplete( value:Number ):void {
        _zoomValue = value;
        dispatchEvent( new UIEvent( UIEvent.ZOOM_COMPLETE, _zoomValue ));
    }



    public function get zoomValue():Number {
       return _zoomValue;
    }

    public function set zoomValue(value:Number):void {
        _zoomValue = value;
    }
}
}
