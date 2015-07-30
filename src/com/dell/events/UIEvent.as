/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/30/13
 * Time: 12:43 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.events {
import flash.events.Event;

public class UIEvent extends Event {

    public static const INIT:String = "init";
    public static const CHANGE:String = "change";
    public static const COMPLETE:String = "complete";
    public static const STOP:String = "stop";
    public static const START:String = "start";
    public static const DISPOSE:String = "dispose";

    public static const CLICK:String = "click";
    public static const ROLL_OVER:String = "rollOver";
    public static const ROLL_OUT:String = "rollOut";

    public static const SELECT:String = "select";

    //SCRUBBER
    public static const SCRUBBING:String = "scrubbing";
    public static const SCRUB_COMPLETE:String = "scrubComplete";

    //ZOOM
    public static const ZOOMIMG:String = "zoom";
    public static const ZOOM_COMPLETE:String = "zoomComplete";
    public static const ZOOM_HOVER:String = "zoomHover";
    public static const ZOOM_ROOL_OUT:String = "zoomHover";

    //MVC Handlers
    public static const UPDATE_VIEW:String = "updateView";
    public static const UPDATE_MODEL:String = "updateModel";
    public static const UPDATE_CONTROLLER:String = "updateController";

    //NAVIGATION
    public static const NAV_ITEM_SELECT:String = "navItemSelect";

    //GALLERY
    public static const GALLERY_ITEM_SELECT:String = "galleryItemSelect";
	public static const GALLERY_IMAGE_CHANGE:String = "galleryImageChange";
    public static const GALLERY_FIRST_LEFT_CARROT_SELECT:String = "galleryFirstLeftCarrotSelect";

    //RESULUTION
    public static const HIGH_RES_SWF_LOADED:String = "highResSWFLoaded";
    public static const LO_RES_SWF_LOADED:String = "loResSWFLoaded";
    public static const LO_RES_IMAGE_LOADED:String = "loResImageLoaded";
    public static const HI_RES_IMAGE_LOADED:String = "hiResImageLoaded";




    public var data:Object = {};

    public function UIEvent(type:String,
                                     _data:Object = null,
                                     bubbles:Boolean = false,
                                     cancelable:Boolean = false) {
        super(type, bubbles, cancelable);

        this.data = _data;
    }

    public override function clone():Event {
        return Event(new UIEvent(type, data,
                bubbles, cancelable));
    }

    public override function toString():String {
        return formatToString("InteractiveEvent", "type",
                "_data",
                "bubbles", "cancelable", "eventPhase");
    }
}
}
