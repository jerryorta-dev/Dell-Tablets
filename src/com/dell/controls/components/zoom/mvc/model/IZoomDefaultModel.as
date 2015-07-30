/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/3/13
 * Time: 3:48 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.zoom.mvc.model {
import com.dell.controls.components.lists.mvc.model.IListModel;

import flash.events.IEventDispatcher;

public interface IZoomDefaultModel extends IListModel, IEventDispatcher {
    function zoomIn( value:Number ):void;
    function zoomOut( value:Number ):void;
    function get zoomValue():Number;
    function set zoomValue(value:Number):void;
}
}
