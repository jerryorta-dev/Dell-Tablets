/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/4/13
 * Time: 12:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.UIComposites.galleryZoomScrub.states {
import flash.events.MouseEvent;

public interface IGalleryScrubber {
    function gallery():void;
    function rotate():void;
    function get name():String;
    function set name(value:String):void;
}
}
