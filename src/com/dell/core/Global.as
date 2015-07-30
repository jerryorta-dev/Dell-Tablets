package com.dell.core {
import com.dell.Omniture.TrackEvent;
import com.dell.Omniture.Tracker;
import com.dell.debug.abstract.Debugger;
import com.dell.debug.interfaces.IDebug;
import com.dell.errors.AbstractClassError;

import com.dell.services.PathManager;
import com.dell.utils.getLoaderInfo;

import flash.display.DisplayObject;
import flash.display.LoaderInfo;
import flash.display.Stage;
import flash.system.Capabilities;

import project_tablets_1297.Params;
import project_tablets_1297.T;

public class Global {
    public static var isInitted:Boolean = false;
    public static var stage:Stage;
    public static var root:DisplayObject;
    public static var flashVars:Object;

    public static var APP_WIDTH:Number;
    public static var APP_HEIGHT:Number;
    public static var moduleIndex:int;

    //Used for tracking which menu item is active
    public static var navItemName:String;
    public static var index:int;

    /**
     * The stage of the the parent swf. Used as a root refernce
     * for subloads.
     */
    private static var _parentStage:Stage;

    /**
     *To be set by Capabilities Class, report to debugger.
     */
    public static var PLAYER_VERSION:String;


    /**
     * Singleton Global params for any web project_tablets_1297.
     *
     * Contains:
     *    Monster Debugger
     *  Flash Trace.
     *  Omniture tracking
     *    Google Analytics Tracking
     *
     *
     */
    public function Global() {
        throw new AbstractClassError
    }

    public static function init(_stage:Stage, _root:DisplayObject):void {
        Global.isInitted = true;

        Global.stage = _stage;
        Global.root = _root;

        Global.APP_WIDTH = _stage.stageWidth;
        Global.APP_HEIGHT = _stage.stageHeight;

        Global.PLAYER_VERSION = Capabilities.version;

        Global.flashVars = ( _root.loaderInfo != null ) ? LoaderInfo(_root.loaderInfo).parameters : {};

    }


    // =======================  PATH MANAGER ===========================
    // =======================  PATH MANAGER ===========================
    // =======================  PATH MANAGER ===========================
    // =======================  PATH MANAGER ===========================

    /**
     * If PathManager has been initted;
     */
    private static var _pathManagerInitted:Boolean = false;

    /**
     * Base url to assets.
     */
    public static var BASE_URL:String;

    /**
     * Path to config xml
     */
    public static var CONFIG_XML:String;

    /**
     * Path to language xml.
     */
    public static var LOCALIZED_XML:String;


    public static function getPathManager():Class {
        if (Global.stage && Global.p.PATHMANAGER_ENABLED && !PathManager.isInitted) {

            PathManager.init(getLoaderInfo(Global.stage));
            Global.BASE_URL = PathManager.baseURL;

            if ( Global.p.XML_LOAD_CONFIG ) {
                Global.CONFIG_XML = Global.getConfigXML();
            }

            if ( Global.p.XML_LOCALIZED_LOADERS ) {
                Global.CONFIG_XML = Global.getLocalizedLoaders();
            }

            Global.LOCALIZED_XML = Global.getLocalizedXML();

        }

        return PathManager;
    }

    /**
     * Return full path to config XML. If no name is provided, defaults to filename "config.xml"
     */
    public static function getConfigXML(nameOfFile:String = null):String {
        if (!nameOfFile) {
            nameOfFile = "config.xml";
        }

        return Global.getPathManager().getConfigXML(nameOfFile);
    }

    /**
     * Return full path to translated XML.
     */
    public static function getLocalizedXML():String {
        return Global.getPathManager().getLocalizedXML();
    }

    public static function getLocalizedLoaders():String {
        return Global.getPathManager().getLocalizedLoadersXML();
    }

    public static function getLanguage():String {
        return Global.getPathManager().language;
    }

    public static function getCountry():String {
        return Global.getPathManager().country;
    }

    //=======================  PARAMS ===========================
    //=======================  PARAMS ===========================
    //=======================  PARAMS ===========================
    //=======================  PARAMS ===========================

    private static var _params:Params;

    public static function get p():Params {
        return _params;
    }

    public static function set p(value:Params):void {
        _params = value;
    }

    //=======================  TIMING ===========================
    //=======================  TIMING ===========================
    //=======================  TIMING ===========================
    //=======================  TIMING ===========================
    private static var _timing:T;

    public static function get t():T {
        return _timing;
    }

    public static function set t(value:T):void {
        _timing = value;
    }


    //=======================  MONSTER DEBUGGER ===========================
    //=======================  MONSTER DEBUGGER ===========================
    //=======================  MONSTER DEBUGGER ===========================
    //=======================  MONSTER DEBUGGER ===========================

    private static var _debugger:IDebug;

    /**
     * Init MonsterDebugger. If caller is not suplied, Global._referenceObject
     * is used.
     *
     * @param caller
     *
     */
    public static function getDebugger(caller:* = null):IDebug {
        if (Global.stage && Global.p.DEBUG_ENABLED && !_debugger) {
            Global._debugger = new Debugger();
            Global._debugger.init((caller != null) ? caller : Global.stage);
        }
        return _debugger;
    }


    public static function debug(caller:* = null, object:* = null, person:String = null, label:String = null, color:uint = 0x000000, depth:int = 5):void {
        Global.getDebugger().trace(caller, object, person, label, color, depth);
    }

    public static function setDebuggerLabel(lable:String):void {
        Global.getDebugger().setLabel(lable);
    }

    public static function setDebuggerColor(color:uint):void {
        Global.getDebugger().setColor(color);
    }

    public static function setDebuggerDepth(depth:int):void {
        Global.getDebugger().setDepth(depth);
    }

    public static function setDebuggerPerson(person:String):void {
        Global.getDebugger().setPerson(person);
    }

    // =======================  XML Loader ===========================
    // =======================  XML Loader ===========================
    // =======================  XML Loader ===========================
    // =======================  XML Loader ===========================

    public static var data:Object;

    // =======================  OMNITURE ===========================
    // =======================  OMNITURE ===========================
    // =======================  OMNITURE ===========================
    // =======================  OMNITURE ===========================

    public static var _tracker:Tracker;

    public static function getTracker():Tracker {
        if (Global.p.OMNITURE_ENABLED && !Global._tracker) {
            Global._tracker = new Tracker();
            Global._tracker.configActionSource();
        }
        return Global._tracker;
    }

    public static function trackMetrics(type:String, metricID:String, clickType:String = "button"):void {
        var tEvt:TrackEvent = new TrackEvent(type, metricID, clickType);
        Global.getTracker().trackMetrics(tEvt);
    }


    // =======================  XMLParser ===========================
    // =======================  XMLParser ===========================
    // =======================  XMLParser ===========================
    // =======================  XMLParser ===========================


    private static var _xmlParser:Class;

    public static function set parser( value:Class ):void {
        _xmlParser = value;
    }

    public static function get parser():Class {
        return _xmlParser;
    }



}
}