package project_tablets_1297 {
import com.dell.Omniture.OminitureParams;
import com.dell.errors.AbstractClassError;
import com.dell.utils.capabilities.isPC;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.XMLLoader;

/**
 * <p>Gobal app params</p>
 *
 * <p>Configure you app settingser here<br>
 * <ul>
 *        <li>XML Loads
 *        <li>SubLoads
 *        <li>Tracking
 *        <li>Debugging
 *        <li>PathManager for Assets
 *        <li>Assets Atlas
 * </ulL>
 *
 * @author Jerry_Orta
 *
 */
public class Params {
    //================ PROJECT INFO ==================
    public const APP_ART_DIRECTOR:String = "Rachel Rossano";
    public const APP_DEVELOPER:String = "Jerry Orta";
    public const APP_RELEASE_DATE:String = "10/9/2013";
    public const APP_VERSION:String = "1.3.0";
    public const APP_DEPARTMENT:String = "Product Launch / Commercial";

    //================ APP ==================
    public const APP_BACKGROUND_COLOR:uint = 0xFFFFFF;
    public const WIDTH:Number = 965;
    public const HEIGHT:Number = 500;

    //================ DEBUGGER ==================
    public const DEBUG_ENABLED:Boolean = true;
    public const DEBUG_INITIAL_COLOR:uint = 0x009900;
    public const DEBUG_DEPTH:int = 5;

    //================ PATH MANAGER ==================
    public const PATHMANAGER_ENABLED:Boolean = true;

    //================ Load XML ==================
    //BEGIN do not change the following
    public const XML_LOADERMAX_NAME:String = "xmlLoader";
    public const XML_CONFIG_LOADER_NAME:String = "configLoader";
    public const XML_LOCALIZED_LOADER_NAME:String = "xmlCopy";
    public const XML_ASSET_lOADER_NAME:String = "assetLoader";
    //END do not change the following

    /**
     * Load different assets based an language query.
     */
    public const XML_LOCALIZED_LOADERS:Boolean = true;
    public const XML_LOAD_CONFIG:Boolean = false;

    //================ OMNITURE ==================
    public const OMNITURE_ENABLED:Boolean = true;

    //ReplaceThisWithYourProjectNameBeforeLaunch
    public const OMNITURE_SITE:String = "1297-Tablets";  //product name, this is used in tracking, so it is important.
    public const OMNITURE_ACCOUNT:String = OminitureParams.DEV; // for production, use OminitureParams.PROD


    /**
     * These options are not specifically for the Omniture Server calls, but for how this app calls Omnituree
     */
    public const OMNITURE_DEBUGGER_LABEL_COLOR:uint = 0x990000;
    public const OMNITURE_TRACK_CLICK_MAP:Boolean = true;
    public const OMNITURE_DEBUG_TRACKING:Boolean = true;
    public const OMNITURE_TRACK_LOCAL:Boolean = true;

    /**
     * Events to track
     *
     * Used at: com.dell.screens.lib.UI_Gallery360ZoomScreen_FLAT
     */
    public const OMNITURE_TRACK_GALLERY:Boolean = false;

    /**
     * Track when the 350 if viewed ( not zoomed or scrubbed ).
     * Used at: com.dell.screens.lib.UI_Gallery360ZoomScreen_FLAT
     */
    public const OMNITURE_TRACK_360:Boolean = true;


    /**
     *
     * Track scrubber once per session.
     *
     * Used at: com.dell.controls.components.scrubbers.lib.UI_MVC_ScrubberDefault.as
     */
    public const OMNITURE_TRACK_SCRUBBER_ONCE:Boolean = true;

    /**
     * track only first zoom click per asset per session.
     *
     * Used at: com.dell.controls.components.galleries.UI_GalleryImageNoThrowProps_Fade
     * Used at: com.dell.screens.lib.UI_Gallery360ZoomScreen_FLAT
     */
    public const OMNITURE_TRACK_ZOOM_ONCE:Boolean = true;

    /**
     * Track every zoom event... this is bad, don't do it
     */
    public const OMNITURE_TRACK_ZOOM_CONTINUOUS:Boolean = false;

    /**
     * Track CTA click
     */
    public const OMNITURE_TRACK_CTA:Boolean = false;

    /**
     * Track each view of image
     */
    public const OMNITURE_TRACK_IMAGE:Boolean = true;


    /**
     * Track the first image of a gallery when the gallery icon is selected
     */
    public const OMNITURE_TRACK_FIRST_IMAGE_GALLERY_SELECTED:Boolean = true;

    /**
     * Track when image is viewed via the gallery nav carrots
     */
    public const OMNITURE_TRACK_IMAGE_GALLERY_CARROT_NAV:Boolean = true;


    //================ PARSER ==================
    public const XML_PARSER:Class = TabletsXMLParser;


    //================ MODULE INDEX (NUMER) ==================
    /**
     * Used for subload of content
     */
    public const MODULE_INDEX:Number = 0;

    //================ LOADERMAX LOADERS ACTIVATE ARRAY ==================
    public const LOADERMAX_ACTIVATE:Array = [ImageLoader, SWFLoader, XMLLoader];


    //================ MAIN NAV MOUSE OVER TEXT COLOR ==================
    public static const VENUE7_ON:uint = 0x70b70c;
    public static const VENUE8_ON:uint = 0x70b70c;
    public static const VENUE8PRO_ON:uint = 0x6cc3c0;
    public static const VENUE11PRO_ON:uint = 0x1181c1;
    public static const NAV_OFF:uint = 0x444444;

    //================ INTRO ANIMATION ==================
    public static const CTA_OVER:uint = 0x00afce;
    public static const CTA_OFF:uint = 0x0085c3;

    public function Params() {
    }
}
}