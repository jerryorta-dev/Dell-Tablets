package {

import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.core.Global;
import com.dell.core.Template;
import com.dell.graphics.RectangleFactory;
import com.dell.graphics.data.RectangleVARS;
import com.dell.screens.ScreenFactory;
import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.display.Sprite;
import flash.events.Event;

import project_tablets_1297.Intro_Tablets;
import project_tablets_1297.NavScreen;
import project_tablets_1297.Params;
import project_tablets_1297.T;
import project_tablets_1297.Track_Tablets1297;

[SWF(width="965", height="500", frameRate="60", backgroundColor="0xEEEEEE")]
public class Tablets1297 extends Template {

    [Embed(source="/assets/fonts/museosansfordell-300-webfont.ttf",
            fontName="museosansfordell300",
            fontFamily="museosansfordell300",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var museosansfordell300:Class;

    [Embed(source="/assets/fonts/museosansfordell-700-webfont.ttf",
            fontName="museoSans700",
            fontFamily="museoSans700",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var museoSans700:Class;

    /*
     [Embed(source="/assets/fonts/museofordell-300-webfont.ttf",
     fontName="museoRegular",
     fontFamily="museoRegular",
     mimeType="application/x-font",
     fontWeight="normal",
     fontStyle="normal",
     advancedAntiAliasing="true",
     embedAsCFF="false")]
     private var museoRegular:Class;
     */
    /*
     [Embed(source="/assets/fonts/trebuc.ttf",
     fontName="trebuchetMS",
     fontFamily="trebuchetMS",
     mimeType="application/x-font",
     fontWeight="normal",
     fontStyle="normal",
     advancedAntiAliasing="true",
     embedAsCFF="false")]
     private var trebuchetMS:Class;
     */

    private var screen0:AbstractUI;
    private var screen1:AbstractUI;
    private var screen2:AbstractUI;
    private var screen3:AbstractUI;

    private var screenArray:Array;
    private var mainNav:Sprite;

    private var intro:Intro_Tablets;

    public function Tablets1297() {
        super();

    }


    override protected function initialize():void {
        screenArray = new Array();

        //Assign project_tablets_1297 Params object
        Global.p = new Params();

        //Assign project_tablets_1297 Timing object
        Global.t = new T();

        //Order which to load LoaderMax Queues from XML Queues


    }


    /**
     * <p>Place your custom code in here.</p>
     *
     * <p>This function is called only when all xml is loaded (config and copy). Both the config and copy
     * xml files are combined into one object <code>data</code> and attached to the Global object
     * so you can access the data anywhere in the app.</p>
     *
     * <p>To get the xml data, call Global.data. Or you can get specific config or copy xml by object
     * notation:</p>
     *
     * <code> Global.config.gallery.icon <br>
     *        Global.copy.item1.title </code>
     *
     */
    override protected function ready():void {

        Global.setDebuggerColor(0xcc0cd3);
        Global.setDebuggerLabel("XML Data");
        Global.setDebuggerPerson("XMLParser");
        Global.debug(this, Global.data);

//		var mcBackTablet:DisplayObject = new EmbeddedAssets.introBackTablet(); 
//		var mcBackTablet:MovieClip = new intro_back_3();
//		mcBackTablet.x = 615 + T.X_OFFSET;
//		mcBackTablet.x = 0;
//		mcBackTablet.y = 119;
//		addChild( mcBackTablet);

        var appMask:RectangleVARS = new RectangleVARS().width(965).height(500).fillAlpha(0xfffff).rectangleRadiusArray(new <Number>[10, 10, 0, 0]);
        var _mask:Sprite = new RectangleFactory().add(RectangleFactory.RECTANGLE_WITH_VARS, this, 0, 0, appMask);
        this.mask = _mask;

        this.intro = new Intro_Tablets({ allLoResLoaderName: "acreen0AllLoRes", onComplete: initNavAndScreens});
        this.intro.x = this.intro.y = 0;
        this.addChild(this.intro);

        //Screens -- the container for each tab that consists of the visuals and it's own ui.
        this.screen0 = new ScreenFactory().add(ScreenFactory.UI_GALLERY_360_FLAT_UI, this, 0, 0, getScreenVars(0), getScreenData(0));
        this.screen0.alpha = 0;
        this.screen0.visible = false;

        this.screen1 = new ScreenFactory().add(ScreenFactory.UI_GALLERY_360_FLAT_UI, this, 0, 0, getScreenVars(1), getScreenData(1));
        this.screen1.alpha = 0;
        this.screen1.visible = false;

        this.screen2 = new ScreenFactory().add(ScreenFactory.UI_GALLERY_360_FLAT_UI, this, 0, 0, getScreenVars(2), getScreenData(2));
        this.screen2.alpha = 0;
        this.screen2.visible = false;

        this.screen3 = new ScreenFactory().add(ScreenFactory.UI_GALLERY_360_FLAT_UI, this, 0, 0, getScreenVars(3), getScreenData(3));
        this.screen3.alpha = 0;
        this.screen3.visible = false;

        screenArray.push(this.screen0, this.screen1, this.screen2, this.screen3);

    }


    private function initNavAndScreens():void {

        Global.navItemName = Track_Tablets1297.getProduct(0);
        Global.index = 0;
        Global.trackMetrics("360", Global.navItemName + "_360") ;

        mainNav = new NavScreen({callBack: this.onNavSelected});
        mainNav.x = 0;
        mainNav.y = 0;
        this.addChild(mainNav);
        mainNav.alpha = 0;
        mainNav.visible = false;

        screen0.activateComposite();
        showNavAndScreens();

    }

    private function showNavAndScreens():void {

        mainNav.removeEventListener(Event.ADDED_TO_STAGE, showNavAndScreens);

        TweenLite.to(this.intro, Global.t.TRANSITION, { delay: Global.t.TRANSITION, autoAlpha: 0, ease: Global.t.EASE, onComplete: disposeIntro });
        TweenLite.to(this.mainNav, Global.t.TRANSITION, { delay: Global.t.TRANSITION, autoAlpha: 1, ease: Global.t.EASE });
        TweenLite.to(this.screen0, Global.t.TRANSITION, { delay: Global.t.TRANSITION, autoAlpha: 1, ease: Global.t.EASE });

    }


    /**
     * Recover memory for screens.
     */
    private function disposeIntro():void {
        intro.dispose();
        this.removeChild(intro);
        intro = null;
    }


    private function onNavSelected(item:int):void {

        Global.navItemName = Track_Tablets1297.getProduct(item);
        Global.index = item;


        //Hide Screen first:
        const len:int = this.screenArray.length;

        for (var i:int = 0; i < len; i++) {
            if (this.screenArray[ i ].visible == true) {
                TweenMax.to(this.screenArray[ i ], Global.t.TRANSITION, {autoAlpha: 0, ease: Global.t.EASE, onComplete: showScreen, onCompleteParams: ["screen" + item]});
                this.screenArray[ i ].reset();
                this.screenArray[ i ].deactivateComposite();
                break;
            }
        }
    }


    private function showScreen(_name:String):void {
        TweenMax.to(this[_name], Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});
        this[_name].activateComposite();

        /**
         * If activatingComposite, 360 is shows first by default
         */
        if (Global.p.OMNITURE_TRACK_360) {
            Global.trackMetrics("360", Track_Tablets1297.getProduct( Global.index ) + "_360");
        }
    }

    /**
     * Set up loader references for screens
     */
    private function getScreenVars(index:int):Object {

        var screenVars:Object = {};
        screenVars.allLoResLoader = "acreen" + index + "AllLoRes";

        screenVars.loResImageLoader = "screen" + index + "ImagesLoRes";
        screenVars.hiResImageLoader = "screen" + index + "ImagesHiRes";

        screenVars.loResSWF360Loader = "screen" + index + "SwfsLoRes";
        screenVars.hiResSWF360Loader = "screen" + index + "SwfsHiRes";

        screenVars.screenIndex = index;

        return screenVars;
    }

    private function getScreenData(index:uint):Object {
        var screenData:Object = {};
        screenData.screenIndex = index;
        return screenData;
    }


}
}