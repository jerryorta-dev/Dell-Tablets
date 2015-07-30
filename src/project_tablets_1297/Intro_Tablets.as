/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/29/13
 * Time: 8:41 AM
 * To change this template use File | Settings | File Templates.
 */
package project_tablets_1297 {
import com.dell.controls.ProgressBar_UI_Factory;
import com.dell.controls.TextfieldFactory;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.progressBars.ProgressBar_UI_Default;
import com.dell.core.Global;
import com.dell.graphics.data.RectangleVARS;
import com.dell.services.PathManager;
import com.dell.utils.textField.createHitTarget;
import com.dell.utils.textField.measureString;
import com.greensock.TimelineLite;
import com.greensock.TweenAlign;
import com.greensock.TweenLite;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.plugins.AutoAlphaPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import project_tablets_1297.text.intro.CTA_Text;
import project_tablets_1297.text.intro.Headline;
import project_tablets_1297.text.intro.ProductTitle;
import project_tablets_1297.text.intro.SubHead;
import project_tablets_1297.text.intro.Title0;
import project_tablets_1297.text.intro.Title1;
import project_tablets_1297.text.intro.Title2;

public class Intro_Tablets extends Sprite {

    private var vars:Object;

    private var introAssets:Array;
    private var garbageCan:Array;
    private var ctaSP:Sprite;
    private var ctaParams:AbstractTextFieldParams;

    private var ctaTF:TextField;

    private var hitTarget:Sprite;

    private var _allLoResLoader:LoaderMax;
    private var _allLoResLoaderName:String

    private var _onComplete:Function;

    //LoaderMax complete listener fires twice, stop the second one
    private var screen0LoResLoaded:Boolean = false;


    private var _screenProgressBar:ProgressBar_UI_Default;

    public function Intro_Tablets( vars:Object ) {

        this.vars = vars;
        this._allLoResLoaderName = vars.allLoResLoaderName;
        this._onComplete = vars.onComplete;

        if (this.stage){
            commitProperties();
        }else{
            this.addEventListener(Event.ADDED_TO_STAGE, commitProperties);
        }

    }

    private function commitProperties( event:Event = null ):void {
        if (event){
            removeEventListener(Event.ADDED_TO_STAGE, commitProperties);
        }
        TweenPlugin.activate([ AutoAlphaPlugin, TintPlugin ]);

        introAssets = new Array();
        garbageCan = new Array();


        var introCopy:Object = Global.data.copy.intro;
        var tlIntro:TimelineLite = new TimelineLite({paused: true, onComplete: onIntroComplete});
        //function add(copy:String, componentType:uint, target:Sprite, xPos:Number, yPos:Number, _textFieldParams:AbstractTextFieldParams):TextField


        //This object may be shared among multiple textfields if needed
        var title0:AbstractTextFieldParams = new Title0();

        if ( PathManager.language == "fr" && PathManager.country == "ca") {
            title0.textFieldVars.width( 700 );
        }
		
		var altDisplay:Boolean = false;
		try {
			altDisplay = (introCopy.introView.altDisplay) == "true" ? true : false;
		}
		catch(e:Error){
			altDisplay = false;
		}


        var t0SP:Sprite = spriteFactory( this, introCopy.title0.x, introCopy.title0.y);
        var t0TF:TextField = new TextfieldFactory().add(introCopy.title0.text, TextfieldFactory.DEFAULT, t0SP, 0, 0, title0);
        t0SP.alpha = 0;

        var title1:AbstractTextFieldParams = new Title1();
        var t1SP:Sprite = spriteFactory( this, introCopy.title1.x, introCopy.title1.y);
        var t1TF:TextField = new TextfieldFactory().add(introCopy.title1.text, TextfieldFactory.DEFAULT, t1SP, 0, 0, title1);
        t1SP.alpha = 0;

        var title2:AbstractTextFieldParams = new Title2();
        var t2SP:Sprite = spriteFactory( this, introCopy.title2.x, introCopy.title2.y);
        var t2TF:TextField = new TextfieldFactory().add(introCopy.title2.text, TextfieldFactory.DEFAULT, t2SP, 0, 0, title2);
        t2SP.alpha = 0;
		
		

        var headline:AbstractTextFieldParams = new Headline();
        var hlSP:Sprite = spriteFactory( this, introCopy.headline.x, introCopy.headline.y);
        var hlTF:TextField = new TextfieldFactory().add(introCopy.headline.text, TextfieldFactory.DEFAULT, hlSP, 0, 0, headline);
        hlSP.alpha = 0;

        var subhead:AbstractTextFieldParams = new SubHead();
        var shSP:Sprite = spriteFactory( this, introCopy.subhead.x, introCopy.subhead.y);
        var shTF:TextField = new TextfieldFactory().add(introCopy.subhead.text, TextfieldFactory.DEFAULT, shSP, 0, 0, subhead);
		if ( PathManager.language == "en" && PathManager.country == "us") {
			shTF.width = shTF.width + 50;  
		}
        shSP.alpha = 0;

        ctaParams = new CTA_Text();
        ( ctaParams as AbstractTextFieldParams ).textFieldWidth = introCopy.cta.callOutWidth;
        ctaSP = spriteFactory( this, introCopy.cta.x, introCopy.cta.y );
        ctaTF = new TextfieldFactory().add(introCopy.cta.text, TextfieldFactory.DEFAULT, ctaSP, 0, 0, ctaParams);
        ctaSP.alpha = 0;

        //Tablet Imagery
        //var mcTablet1:DisplayObject = new EmbeddedAssets.introTablet1();
//        var mcTablet1:DisplayObject = new intro_11pro_first();
        var mcTablet1:DisplayObject = new EmbeddedAssets.introFirst11Pro;

        if ( !altDisplay ) {
            mcTablet1.x = 285;
            mcTablet1.y = 214;
        } else {
            mcTablet1.x = 346;
            mcTablet1.y = 214;
        }



        mcTablet1.alpha = 0;
		addChildAt(mcTablet1, 2);

        var mcBackTablet:DisplayObject;

        var mcBackPrimary:DisplayObject  = new EmbeddedAssets.introBackTablet();
        var mcBackAlt:DisplayObject = new EmbeddedAssets.introBackTablet8ProAlt();


        if ( !altDisplay ) {
            mcBackTablet = mcBackPrimary;
            mcBackTablet.y = 119;
        } else {
            mcBackTablet = mcBackAlt;
            mcBackTablet.y = 109;
        }

//		var mcBackTablet:DisplayObject = new intro_8_back();
        mcBackTablet.x = 585 + T.X_OFFSET;
//		mcBackTablet.x = 0;

        addChildAt(mcBackTablet, 1);

       var mcLeftTablet:DisplayObject = new EmbeddedAssets.introLeftTablet();
        //var mcLeftTablet:DisplayObject = new intro_7_left();
        mcLeftTablet.x = 108 + T.X_OFFSET;
        mcLeftTablet.y = 290;
		addChild(mcLeftTablet);
		
		
		//var mcRightTablet:DisplayObject = new EmbeddedAssets.introRightTablet();
		var mcRightTablet:DisplayObject = new intro_8pro_right();
		mcRightTablet.addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
			tlIntro.play();
		});
		mcRightTablet.x = 584 + T.X_OFFSET;
		mcRightTablet.y = 268;
		addChild(mcRightTablet);
		
		

		//Product Titles for tablets
		if(!altDisplay){
			var prodTitle1:AbstractTextFieldParams = new ProductTitle();
			var pt1SP:Sprite = spriteFactory( this, 95, 266);
			var pt1TF:TextField = new TextfieldFactory().add( Global.data.copy.nav.venue7.title, TextfieldFactory.DEFAULT, pt1SP, 0, 0, prodTitle1);
			pt1SP.alpha = 0;
			
		}
		
		var prodTitle2:AbstractTextFieldParams = new ProductTitle();


        var tf11ProX:int = 298;
        var tf11ProY:int = 190;
        if ( altDisplay ) {
            tf11ProX = 360;
//            tf11ProY = 190;
        }

		var pt2SP:Sprite = spriteFactory( this, tf11ProX, tf11ProY);
		var pt2TF:TextField = new TextfieldFactory().add( Global.data.copy.nav.venue11Pro.title, TextfieldFactory.DEFAULT, pt2SP, 0, 0, prodTitle2);
		pt2SP.alpha = 0;
		
		var prodTitle3:AbstractTextFieldParams = new ProductTitle();
		var ptX:int = 705; // 680, 98
		var ptY:int = 98;

		if(altDisplay){
			ptX = 780;
			ptY = 87;
		}

		var pt3SP:Sprite = spriteFactory( this, ptX, ptY);

        var pt3TF:TextField;


        if(!altDisplay){
			
				pt3TF = new TextfieldFactory().add( Global.data.copy.nav.venue8.title, TextfieldFactory.DEFAULT, pt3SP, 0, 0, prodTitle3);
			
		
		} else {
            pt3TF = new TextfieldFactory().add( Global.data.copy.nav.venue8Pro.title, TextfieldFactory.DEFAULT, pt3SP, 0, 0, prodTitle3);
        }


		pt3SP.alpha = 0;
		
		if(!altDisplay){
			var prodTitle4:AbstractTextFieldParams = new ProductTitle();
			var pt4SP:Sprite = spriteFactory( this, 808, 245); //x originally 863
			var pt4TF:TextField

				pt4TF = new TextfieldFactory().add( Global.data.copy.nav.venue8Pro.title, TextfieldFactory.DEFAULT, pt4SP, 0, 0, prodTitle4);
				
			pt4SP.alpha = 0;
		}
		


        //fade in
        tlIntro.insert(TweenLite.to(t0SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), .2);
        tlIntro.insert(TweenLite.to(t1SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 1.3);
        tlIntro.insert(TweenLite.to(t2SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 2.1);
		
        

        //fade out copy
        tlIntro.insertMultiple([new TweenLite(t0SP, .8, {alpha: 0, ease: T.EASE_REG}),
            new TweenLite(t1SP, .8, {alpha: 0, ease: T.EASE_REG}),
            new TweenLite(t2SP, .8, {alpha: 0, ease: T.EASE_REG})],
                3.9,
                TweenAlign.START,
                0);

        //fade in HL
        tlIntro.insert(TweenLite.to(hlSP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 4.5);

//		slide tablets in
		
		if(!altDisplay){
			tlIntro.insert(TweenLite.to(mcTablet1, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_STR_IN}), 2);
	        tlIntro.insertMultiple([new TweenLite(mcLeftTablet, T.TABLET_SLIDE_TIME, {x: mcLeftTablet.x - T.X_OFFSET -30, ease: T.EASE_QUAD_OUT}),
	            new TweenLite(mcRightTablet, T.TABLET_SLIDE_TIME, {x: mcRightTablet.x - T.X_OFFSET, ease: T.EASE_QUAD_OUT}),
	            new TweenLite(mcBackTablet, T.TABLET_SLIDE_TIME, {x: mcBackTablet.x - T.X_OFFSET, ease: T.EASE_QUAD_OUT})],
	                4,
	                TweenAlign.START,
	                0);
		}else{
			tlIntro.insert(TweenLite.to(mcTablet1, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_STR_IN}), 3);
			tlIntro.insertMultiple([
				new TweenLite(mcBackTablet, T.TABLET_SLIDE_TIME *.8, {x: 687, ease: T.EASE_QUAD_OUT})],
				4,
				TweenAlign.START,
				0);
		}

        //fade in last copy
        tlIntro.insert(TweenLite.to(shSP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 6);
        tlIntro.insert(TweenLite.to(ctaSP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 7);
		
		
		//fade in the titles once tablets slide in
		if(!altDisplay){
			tlIntro.insert(TweenLite.to(pt1SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 7.9);
			tlIntro.insert(TweenLite.to(pt2SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 8.0);
			tlIntro.insert(TweenLite.to(pt3SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 8.1);
			tlIntro.insert(TweenLite.to(pt4SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 7.8);
		}else{
			tlIntro.insert(TweenLite.to(pt2SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 8.0);
			tlIntro.insert(TweenLite.to(pt3SP, T.INTRO_FADE_IN, {alpha: 1, ease: T.EASE_REG}), 8.1);
		}

        this.hitTarget = createHitTarget(ctaTF.text, ctaTF.getTextFormat(), new <Number>[-5, -5, 20, 15]);

        this.addChild(hitTarget);
        hitTarget.x = this.ctaSP.x;
        hitTarget.y = this.ctaSP.y;

        this.hitTarget.addEventListener(MouseEvent.CLICK, loadScreens, false, 0, true);
        this.hitTarget.addEventListener(MouseEvent.ROLL_OVER, ctaMouseOverHandler, false, 0, true);
        this.hitTarget.addEventListener(MouseEvent.ROLL_OUT, ctaMouseOffHandler, false, 0, true);

        introAssets.push(t0SP, t1SP, t2SP, mcTablet1, hlSP, mcLeftTablet, mcRightTablet, mcBackTablet, shSP, ctaSP, hitTarget);

    }

    private function ctaMouseOverHandler(event:MouseEvent):void {
        TweenLite.to(this.ctaSP, Global.t.TRANSITION, { tint: Params.CTA_OVER, ease: Global.t.EASE });
    }

    private function ctaMouseOffHandler(event:MouseEvent):void {
        TweenLite.to(this.ctaSP, Global.t.TRANSITION, { tint: Params.CTA_OFF, ease: Global.t.EASE });
    }


    private function emptyGarbage():void {

        var len:int = garbageCan.length;
        for (var i:int = 0; i < len; i++) {
            garbageCan[i] = null;
            delete garbageCan[i];
        }

        var aLen:int = introAssets.length;
        for (var j:int = 0; j < aLen; j++) {
            TweenLite.killTweensOf(introAssets[j]);
            TweenLite.to(introAssets[j], Global.t.TRANSITION, { alpha: 0, ease: Global.t.EASE});
        }



    }


    /**
     * Load each Tablets screen
     * @param event
     */
    private function loadScreens(event:MouseEvent):void {

        if ( Global.p.OMNITURE_TRACK_CTA ) {
            Global.trackMetrics( "cta", "CTA" );
        }

        const _ctaWidth:Number = measureString(this.ctaTF.text, this.ctaTF.getTextFormat()).width + 10;

        var _screenProgressBarVars:Object = {};
        _screenProgressBarVars.backgroundVars = new RectangleVARS().width(_ctaWidth).height(5).radius(2).fillColor(0xebebeb);
        _screenProgressBarVars.progressBarVars = new RectangleVARS(_screenProgressBarVars.backgroundVars).fillColor(0x0085c3);
        _screenProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, this, this.ctaSP.x + 2, this.ctaSP.y + this.ctaSP.height + 2, _screenProgressBarVars) as ProgressBar_UI_Default;
        _screenProgressBar.alpha = 0;

        introAssets.push(_screenProgressBar);

        TweenLite.to(this._screenProgressBar, Global.t.TRANSITION, {autoAlpha: 1, ease: Global.t.EASE});

        /*
         Load ALL assets with one channel ( one asset at a time ).
         As the user navigates to different parts of the app, the loader is
         reprioritized to load what the user navigates to first.
         */
        LoaderMax.getLoader("master").load();

        this._allLoResLoader = LoaderMax.getLoader( this._allLoResLoaderName );

        _allLoResLoader.prioritize();
        this._allLoResLoader.addEventListener(LoaderEvent.COMPLETE, this.onScreensLoaded, false, 0, true);
        this._allLoResLoader.addEventListener(LoaderEvent.PROGRESS, this._screenProgressBar.progress, false, 0, true);


    }

    private function spriteFactory( _target:Sprite, _xPos:Number, _yPos:Number ):Sprite {
        var sp:Sprite = new Sprite();
        sp.x = _xPos;
        sp.y = _yPos;
        _target.addChild( sp );
        return sp;
    }

    private function onIntroComplete():void {
        //Doing nada for now;
    }

    private function onScreensLoaded(event:LoaderEvent):void {

        if (screen0LoResLoaded) {
            return;
        }
        screen0LoResLoaded = true;
        this._allLoResLoader.removeEventListener(LoaderEvent.COMPLETE, this.onScreensLoaded);
        this._allLoResLoader.removeEventListener(LoaderEvent.PROGRESS, this._screenProgressBar.progress);

        this.emptyGarbage();

        if ( _onComplete != null) {
            this._onComplete.apply( null, null );
        }

    }

    public function dispose():void {
        var aLen:int = introAssets.length;
        for (var j:int = 0; j < aLen; j++) {
            if (introAssets[j]) {
                this.removeChild(introAssets[j]);
                introAssets[j] = null;
            }
        }
    }



}
}
