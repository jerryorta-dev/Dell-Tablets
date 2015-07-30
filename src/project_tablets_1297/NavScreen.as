package project_tablets_1297 {
import com.dell.controls.ProgressBar_UI_Factory;
import com.dell.controls.TextfieldFactory;
import com.dell.controls.components.progressBars.ProgressBar_UI_Default;
import com.dell.core.Global;
import com.dell.services.PathManager;
import com.dell.graphics.RectangleFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.data.RectangleVARS;
import com.dell.utils.textField.setMaxLines;
import com.greensock.TweenLite;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.LoaderStatus;
import com.greensock.plugins.AutoAlphaPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import project_tablets_1297.text.navMain.NavHeaderTextFieldVARS;
import project_tablets_1297.text.navMain.NavPlayVARS;
import project_tablets_1297.text.navMain.NavSubHeadTextFieldVARS;
import project_tablets_1297.text.navMain.NavWorkVARS;

/**
 * Main Navigation ( Left buttons of the Tablets project_tablets_1297 )
 * @author Jerry_Orta
 *
 */
public class NavScreen extends Sprite {

    private var vars:Object;
    private var callBackFunction:Function;

    private var background:AbstractGraphic;

    private var work:TextField;
    private var tfPlay:TextField;

    private var mcVenue7:MovieClip;
    private var tfVenue7:TextField;
    private var tfVenue7Descr:TextField;
    private var venu7ProgressBar:ProgressBar_UI_Default;

    private var mcVenue8:MovieClip;
    private var tfVenue8:TextField;
    private var tfVenue8Descr:TextField;
    private var venue8ProgressBar:ProgressBar_UI_Default;

    private var mcVenue8Pro:MovieClip;
    private var tfVenue8Pro:TextField;
    private var tfVenue8ProDescr:TextField;
    private var venue8ProProgressBar:ProgressBar_UI_Default;

    private var mcVenue11Pro:MovieClip;
    private var tfVenue11Pro:TextField;
    private var tfVenue11ProDescr:TextField;
    private var venue11ProProgressBar:ProgressBar_UI_Default;


    private var navArray:Vector.<MovieClip>;
    private var tfArray:Vector.<TextField>;
    private var subCopyArray:Vector.<TextField>;
    private var hitTestArray:Vector.<Sprite>;
    private var loaderArray:Vector.<LoaderMax>;
    private var progressBarArray:Vector.<Sprite>;

    private var mainNavInitted:Boolean = false;
    private var _navIsOn:String;

    private var _selectedItem:int;


    public function NavScreen(vars:Object) {

        this.vars = ( vars != null ) ? vars : {} ;
        this.callBackFunction = (this.vars.callBack != null ) ? this.vars.callBack : null;

        this.buildNav();

        TweenPlugin.activate([ AutoAlphaPlugin, TintPlugin ])
    }

    private function buildNav(eventMouseEvent = null):void {

        navArray = new Vector.<MovieClip>();
        tfArray = new Vector.<TextField>();
        hitTestArray = new Vector.<Sprite>();
        subCopyArray = new Vector.<TextField>();
        loaderArray = new Vector.<LoaderMax>();
        progressBarArray = new Vector.<Sprite>();

        this.screen0LoResLoader = LoaderMax.getLoader( "acreen0AllLoRes" );
        this.screen1LoResLoader = LoaderMax.getLoader( "acreen1AllLoRes" );
        this.screen2LoResLoader = LoaderMax.getLoader( "acreen2AllLoRes" );
        this.screen3LoResLoader = LoaderMax.getLoader( "acreen3AllLoRes" );

        loaderArray.push( screen0LoResLoader, screen1LoResLoader, screen2LoResLoader, screen3LoResLoader );

//        const yPosArray:Vector.<Number> = new <Number>[0, ];

        const navCenterXPos:Number = 50; // Original 50
        const tfXPos:Number = 87; // Original 98
        var yNavStart:Number = 16 // Original 56
		

        const HEADER_ADJUST:Number = 10;
        const SUBHEAD_ADJUST:Number = 18;

        const HIT_WIDTH:Number = 200;
        const HIT_X:Number = 25;
        const HIT_Y_ADJUST:Number = 10;
        const HIT_HEIGHT:Number = 60;
//        const LOADER_BAR_WIDDTH:Number = 100;
		
		var introCopy:Object = Global.data.copy.intro;
		var altDisplay:Boolean = false;
		try {
			altDisplay = (introCopy.introView.altDisplay) == "true" ? true : false;
		}
		catch(e:Error){
			altDisplay = false;
		}
		if(altDisplay){ 
			yNavStart = 100;			
		}


        var tfVars:NavHeaderTextFieldVARS = new NavHeaderTextFieldVARS();
        var tfDescrVars:NavSubHeadTextFieldVARS = new NavSubHeadTextFieldVARS();
        var tfFactory:TextfieldFactory = new TextfieldFactory();

        //Width originally 205
        var bgVARS:RectangleVARS = new RectangleVARS().fillColor(0xffffff).width(220).height(440).fillAlpha(.7).rectangleRadiusArray(new <Number>[10, 0, 5, 0]);
        this.background = new RectangleFactory().add(RectangleFactory.RECTANGLE_WITH_VARS, this, 0, 0, bgVARS);


        //WORK

        var tfWorkVars:NavWorkVARS = new NavWorkVARS();
        this.work = tfFactory.add(Global.data.copy.nav.work, TextfieldFactory.DEFAULT, this, Global.data.copy.nav.workX, yNavStart, tfWorkVars);
        if(altDisplay){
            this.work.visible = false;
        }
		//        this.work.addEventListener(Event.ADDED_TO_STAGE, this.workAddedToStage, false, 0, true);

        /*
        var mcWorkTri:MovieClip = new UI_Nav().mcWork;
        mcWorkTri.x = navCenterXPos;
        mcWorkTri.y = 41;
        this.addChild(mcWorkTri);
*/
		
		

        //VENUE 11 PRO
        this.mcVenue11Pro = new UI_Main_Nav().mcVenue11Pro;
        this.mcVenue11Pro.x = navCenterXPos;

//        this.mcVenue11Pro.y = yNavStart;
        yNavStart += 26;
        this.mcVenue11Pro.y = yNavStart;
        this.addChild(this.mcVenue11Pro);

        navArray.push(this.mcVenue11Pro);

        this.tfVenue11Pro = tfFactory.add(Global.data.copy.nav.venue11Pro.title, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue11Pro.y + HEADER_ADJUST, tfVars);
        this.tfVenue11ProDescr = tfFactory.add(Global.data.copy.nav.venue11Pro.descr, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue11Pro.y + HEADER_ADJUST + SUBHEAD_ADJUST, tfDescrVars);

        var _v11ProProgressBarVars:Object = {};
        _v11ProProgressBarVars.backgroundVars = new RectangleVARS().width( Global.data.copy.nav.venue11Pro.progressBarWidth ).height(2).radius(1).fillColor( 0xebebeb );
        _v11ProProgressBarVars.progressBarVars = new RectangleVARS(_v11ProProgressBarVars.backgroundVars).fillColor(Params.VENUE11PRO_ON);
        this.venue11ProProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, this, tfXPos + 2, this.tfVenue11Pro.y + this.tfVenue11Pro.height - 3, _v11ProProgressBarVars) as ProgressBar_UI_Default;
        progressBarArray.push( this.venue11ProProgressBar);



        var ht0:Sprite = createHitTarget( HIT_WIDTH,  85);
        ht0.name = this.mcVenue11Pro.name + "-tab0";
        ht0.x = HIT_X;
//        ht0.y = 56 + HIT_Y_ADJUST  ;
        ht0.y = yNavStart + HIT_Y_ADJUST  ;
        this.addChild( ht0 );
        hitTestArray.push( ht0 );

        tfArray.push(tfVenue11Pro);
        subCopyArray.push(tfVenue11ProDescr);

        //VENUE 8 PRO
        this.mcVenue8Pro = new UI_Main_Nav().mcVenue8Pro;
        this.mcVenue8Pro.x = navCenterXPos;
//        this.mcVenue8Pro.y = 159;

        yNavStart += 103;
        this.mcVenue8Pro.y = yNavStart;
        this.addChild(this.mcVenue8Pro);
        navArray.push(this.mcVenue8Pro);

        this.tfVenue8Pro = tfFactory.add(Global.data.copy.nav.venue8Pro.title, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue8Pro.y + HEADER_ADJUST, tfVars);
        this.tfVenue8ProDescr = tfFactory.add(Global.data.copy.nav.venue8Pro.descr, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue8Pro.y + HEADER_ADJUST + SUBHEAD_ADJUST, tfDescrVars);
//        this.tfVenue8ProDescr.alpha = 0;

        var _v8ProProgressBarVars:Object = {};
        _v8ProProgressBarVars.backgroundVars = new RectangleVARS().width( Global.data.copy.nav.venue8Pro.progressBarWidth ).height(2).radius(1).fillColor( 0xebebeb );
		if ( PathManager.language == "en" && PathManager.country == "us") {
			_v8ProProgressBarVars.progressBarVars = new RectangleVARS(_v8ProProgressBarVars.backgroundVars).fillColor(Params.VENUE11PRO_ON);
		}else{
			_v8ProProgressBarVars.progressBarVars = new RectangleVARS(_v8ProProgressBarVars.backgroundVars).fillColor(Params.VENUE8PRO_ON);
				
		}
		this.venue8ProProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, this, tfXPos + 2, this.tfVenue8Pro.y + this.tfVenue8Pro.height - 3, _v8ProProgressBarVars) as ProgressBar_UI_Default;
        progressBarArray.push( this.venue8ProProgressBar);

        var ht1:Sprite = createHitTarget( HIT_WIDTH,  65);
        ht1.name = this.mcVenue8Pro.name + "-tab1";
        ht1.x = HIT_X;
        ht1.y = yNavStart  + HIT_Y_ADJUST  ;
        this.addChild( ht1 );
        hitTestArray.push( ht1 );

        tfArray.push(tfVenue8Pro);
        subCopyArray.push(tfVenue8ProDescr);

        //VENUE 8
		if(!altDisplay){  // hide the last 2 tablets for other regions
	        this.mcVenue8 = new UI_Main_Nav().mcVenue8;
	        this.mcVenue8.x = navCenterXPos;
	//        this.mcVenue8.y = 239;
	
	        yNavStart += 80
	        this.mcVenue8.y = yNavStart;
	        this.addChild(this.mcVenue8);
	        navArray.push(this.mcVenue8);
	
	        this.tfVenue8 = tfFactory.add(Global.data.copy.nav.venue8.title, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue8.y + HEADER_ADJUST, tfVars);
	        this.tfVenue8Descr = tfFactory.add(Global.data.copy.nav.venue8.descr, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue8.y + HEADER_ADJUST + SUBHEAD_ADJUST, tfDescrVars);
	//        this.tfVenue8Descr.alpha = 0;
	
	        var _v8ProgressBarVars:Object = {};
	        _v8ProgressBarVars.backgroundVars = new RectangleVARS().width( Global.data.copy.nav.venue8.progressBarWidth ).height(2).radius(1).fillColor( 0xebebeb );
	        _v8ProgressBarVars.progressBarVars = new RectangleVARS(_v8ProgressBarVars.backgroundVars).fillColor(Params.VENUE8_ON);
	        this.venue8ProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, this,tfXPos + 2, this.tfVenue8.y + this.tfVenue8.height - 3, _v8ProgressBarVars) as ProgressBar_UI_Default;
	        progressBarArray.push( this.venue8ProgressBar);
	
	
	        var ht2:Sprite = createHitTarget( HIT_WIDTH,  65);
	        ht2.name = this.mcVenue8.name + "-tab2";
	        ht2.x = HIT_X;
	        ht2.y = yNavStart  + HIT_Y_ADJUST  ;
	        this.addChild( ht2 );
	        hitTestArray.push( ht2 );
	
	        tfArray.push(tfVenue8);
	        subCopyArray.push(tfVenue8Descr);
	
	        //VENU 7
	        this.mcVenue7 = new UI_Main_Nav().mcVenue7;
	        this.mcVenue7.x = navCenterXPos;
	
	//        this.mcVenue7.y = 317;
	        yNavStart += 78;
	        this.mcVenue7.y = yNavStart;
	        this.addChild(this.mcVenue7);
	        this.navArray.push(this.mcVenue7);
	
	        this.tfVenue7 = tfFactory.add(Global.data.copy.nav.venue7.title, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue7.y + HEADER_ADJUST, tfVars);
	        this.tfVenue7Descr = tfFactory.add(Global.data.copy.nav.venue7.descr, TextfieldFactory.DEFAULT, this, tfXPos, this.mcVenue7.y + HEADER_ADJUST + SUBHEAD_ADJUST, tfDescrVars);
	//        this.tfVenue7Descr.alpha = 0;
	
	        var ht3:Sprite = createHitTarget( HIT_WIDTH,  HIT_HEIGHT );
	        ht3.name = this.mcVenue7.name + "-tab3";
	        ht3.x = HIT_X;
	        ht3.y = yNavStart + HIT_Y_ADJUST   ;
	        this.addChild( ht3 );
	        hitTestArray.push( ht3 );
	
	        var _v7ProgressBarVars:Object = {};
	        _v7ProgressBarVars.backgroundVars = new RectangleVARS().width( Global.data.copy.nav.venue7.progressBarWidth ).height(2).radius(1).fillColor( 0xebebeb );
	        _v7ProgressBarVars.progressBarVars = new RectangleVARS(_v7ProgressBarVars.backgroundVars).fillColor(Params.VENUE7_ON);
	        this.venu7ProgressBar = new ProgressBar_UI_Factory().add(ProgressBar_UI_Factory.PROGRESS_BAR_DEFAULT, this, tfXPos + 2, this.tfVenue7.y + this.tfVenue7.height - 3, _v7ProgressBarVars) as ProgressBar_UI_Default;
	        progressBarArray.push( this.venu7ProgressBar);
	
	
	        tfArray.push(tfVenue7);
	        subCopyArray.push(tfVenue7Descr);
	
	
	        //PLAY
	        /*
	        var mcPlayTri:MovieClip = new UI_Nav().mcPlay;
	        mcPlayTri.x = navCenterXPos;
	        mcPlayTri.y = 396;
	        this.addChild(mcPlayTri);
	         */
			
			yNavStart += 77;
	        var tfPlayVARS:NavPlayVARS = new NavPlayVARS();
	        this.tfPlay = tfFactory.add(Global.data.copy.nav.play, TextfieldFactory.DEFAULT, this, Global.data.copy.nav.playX, yNavStart, tfPlayVARS);
	//        this.tfPlay.addEventListener(Event.ADDED_TO_STAGE, this.playAddedToStage, false, 0, true);
		}
		
		if ( PathManager.language == "en" && PathManager.country == "us") {
			var leftNavUS:DisplayObject = new EmbeddedAssets.leftNavUS();
			leftNavUS.y = 43;
			leftNavUS.x = 15;
			this.addChildAt(leftNavUS,18);
		}

        this.addListeners(this.navArray);

    }


    private function workAddedToStage(event:Event):void {

        setMaxLines( this.work, 1);

        if ( (this.work.x - (this.work.width / 2)) < 10 ) {
            this.work.x = this.work.x - (this.work.width / 2)
        } else {
            this.work.x = 10;
        }

//        this.work.x = this.work.x - (this.work.width / 2);
        this.work.removeEventListener(Event.ADDED_TO_STAGE, this.workAddedToStage);
    }

    private function playAddedToStage(evnet:Event):void {

        setMaxLines( this.tfPlay, 1 );

        if ( (this.tfPlay.x - (this.tfPlay.width / 2)) < 10 ) {
            this.tfPlay.x = this.tfPlay.x - (this.tfPlay.width / 2)
        } else {
            this.tfPlay.x = 10;
            }

//        this.tfPlay.x = this.tfPlay.x - (this.tfPlay.width / 2);
        this.tfPlay.removeEventListener(Event.ADDED_TO_STAGE, this.playAddedToStage);
    }


    private function addListeners(_array:Vector.<MovieClip>):void {

        this._navIsOn = _array[0].name;
        TweenLite.to(this.tfVenue11Pro, Global.t.TRANSITION, {tint: Params.VENUE11PRO_ON, ease: Global.t.EASE });

        var len:int = _array.length;
        for (var i:int = 0; i < len; i++) {
            hitTestArray[i].buttonMode = true;
            hitTestArray[i].useHandCursor = true;
            hitTestArray[i].mouseChildren = false;
            hitTestArray[i].addEventListener(MouseEvent.CLICK, this.navigateFrom, false, 0, true);
            hitTestArray[i].addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
            hitTestArray[i].addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
            _array[i].ON.alpha = 0;
        }

        if (!mainNavInitted) {
            mainNavInitted = true;
            _array[0].ON.alpha = 1;
        }
    }

    private function onRollOver(event:MouseEvent):void {
//        trace(event.target.name);

        var _name:String =  event.target.name.split("-")[0];
//        trace(event.target.name);

        TweenLite.killTweensOf(this[ _name ].ON);
        TweenLite.to(this[ _name ].ON, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE });

//		trace(getTextFieldIndexByMCName( event.target.name ));
		
        var subCopyInt:int = getTextFieldIndexByMCName(_name);
//        var subCopyTF:TextField = subCopyArray[ subCopyInt ] as TextField;

//        if (subCopyTF != null) {
//            TweenLite.killTweensOf(subCopyTF);
//            TweenLite.to(subCopyTF, Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE });
//        }

        if ((this.loaderArray[ subCopyInt ].status != LoaderStatus.COMPLETED)) {
            TweenLite.to(progressBarArray[ subCopyInt ], Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE });
        }


        colorNavHeader(subCopyInt);
    }


    private function onRollOut(event:MouseEvent):void {
        var len:int = this.navArray.length;

        //Using loop because sometimes mouse movement is too fast to capture the out instance name if many
        //out events are fired in rapid succession.
        for (var i:int = 0; i < len; i++) {

            if (this.navArray[i].name != _navIsOn) {
                TweenLite.killTweensOf(this.navArray[i].ON);
                TweenLite.to(this.navArray[i].ON, Global.t.TRANSITION, {alpha: 0, ease: Global.t.EASE });
                TweenLite.killTweensOf(this.tfArray[i]);
                TweenLite.to(this.tfArray[i], Global.t.TRANSITION, {tint: Params.NAV_OFF, ease: Global.t.EASE });

//                var subCopyTF:TextField = subCopyArray[i] as TextField;
//                TweenLite.killTweensOf(subCopyTF);
//                TweenLite.to(subCopyTF, Global.t.TRANSITION, {alpha: 0, ease: Global.t.EASE });

                TweenLite.to(progressBarArray[ i ], Global.t.TRANSITION, {alpha: 0, ease: Global.t.EASE });
            }
        }
    }

    private function getTextFieldIndexByMCName(_name:String):int {

        var len:int = this.navArray.length;
        for (var i:int = 0; i < len; i++) {
            if (this.navArray[i].name == _name) {
                return i;
            }
        }

        return 0;
    }


    private function colorNavHeader(item:int):void {

        var color:int;

		if ( PathManager.language == "en" && PathManager.country == "us") {
	        if (item == 0) {
	            color = Params.VENUE11PRO_ON;
	        }
	
	        if (item == 1) {
	            color = Params.VENUE11PRO_ON;
	        }
	
	        if (item == 2) {
	            color = Params.VENUE8_ON;
	        }
	
	        if (item == 3) {
	            color = Params.VENUE7_ON;
	        }
		}else{
			if (item == 0) {
				color = Params.VENUE11PRO_ON;
			}
			
			if (item == 1) {
				color = Params.VENUE8PRO_ON;
			}
			
			if (item == 2) {
				color = Params.VENUE8_ON;
			}
			
			if (item == 3) {
				color = Params.VENUE7_ON;
			}
		}

        TweenLite.killTweensOf(this.tfArray[item]);
        TweenLite.to(this.tfArray[item], Global.t.TRANSITION, {tint: color, ease: Global.t.EASE });
    }


    private function navigateFrom(event:MouseEvent):void {
        var len:int = this.navArray.length;
        for (var i:int = 0; i < len; i++) {
            TweenLite.to(this.navArray[i].ON, Global.t.TRANSITION * .5, { alpha: 0, ease: Global.t.EASE});
            TweenLite.killTweensOf(this.tfArray[i]);
            TweenLite.to(this.tfArray[i], Global.t.TRANSITION, {tint: Params.NAV_OFF, ease: Global.t.EASE });
        }

        this.navigateTo(event.target.name.split("-")[0]);
    }


    private function navigateTo(_mcName:String):void {

        TweenLite.killTweensOf(this[ _mcName ].ON);
        TweenLite.to(this[ _mcName ].ON, Global.t.TRANSITION, { alpha: 1, ease: Global.t.EASE});
        _navIsOn = _mcName;

        this._selectedItem = getTextFieldIndexByMCName(_mcName);
        colorNavHeader( this._selectedItem );
        TweenLite.to(subCopyArray[ this._selectedItem ], Global.t.TRANSITION, {alpha: 1, ease: Global.t.EASE });

//        this.callBack( this._selectedItem );

        prioritizeLoResLoaded();

    }

    private var screen0LoResLoader:LoaderMax;
    private var screen1LoResLoader:LoaderMax;
    private var screen2LoResLoader:LoaderMax;
    private var screen3LoResLoader:LoaderMax;


    private var _screen0IsLoaded:Boolean = true;
    private var _screen1IsLoaded:Boolean = false;
    private var _screen2IsLoaded:Boolean = false;
    private var _screen3IsLoaded:Boolean = false;

    private function prioritizeLoResLoaded( ):void {
        if ( _selectedItem == 0 ) {

            if ((this.screen0LoResLoader.status != LoaderStatus.COMPLETED) && !this._screen0IsLoaded) {

                this.screen0LoResLoader.prioritize();
                this.screen0LoResLoader.addEventListener(LoaderEvent.COMPLETE, this.hasLoaded, false, 0, true);
                this.screen0LoResLoader.addEventListener(LoaderEvent.PROGRESS, this.venue11ProProgressBar.progress, false, 0, true);
                TweenLite.to( this.venue11ProProgressBar, Global.t.TRANSITION, {autoAlpha:1, ease:Global.t.EASE} );
//                Global.debug(this, "acreen0AllLoRes");
            } else {
                this.callBack();
            }
        }

        if ( _selectedItem == 1 ) {

            if ((this.screen1LoResLoader.status != LoaderStatus.COMPLETED) && !this._screen1IsLoaded) {

                this.screen1LoResLoader.prioritize();
                this.screen1LoResLoader.addEventListener(LoaderEvent.COMPLETE, this.hasLoaded, false, 0, true);
                this.screen1LoResLoader.addEventListener(LoaderEvent.PROGRESS, this.venue8ProProgressBar.progress, false, 0, true);
                TweenLite.to( this.venue8ProProgressBar, Global.t.TRANSITION, {autoAlpha:1, ease:Global.t.EASE} );
//                Global.debug(this, "acreen1AllLoRes");
            } else {
                this.callBack();
            }
        }

        if ( _selectedItem == 2 ) {

            if ((this.screen2LoResLoader.status != LoaderStatus.COMPLETED) && !this._screen2IsLoaded) {
//                Global.debug(this, "acreen2AllLoRes");
                this.screen2LoResLoader.prioritize();
                this.screen2LoResLoader.addEventListener(LoaderEvent.COMPLETE, this.hasLoaded, false, 0, true);
                this.screen2LoResLoader.addEventListener(LoaderEvent.PROGRESS, this.venue8ProgressBar.progress, false, 0, true);
                TweenLite.to( this.venue8ProgressBar, Global.t.TRANSITION, {autoAlpha:1, ease:Global.t.EASE} );
            } else {
                this.callBack();
            }
        }

        if ( _selectedItem == 3 ) {

            if ((this.screen3LoResLoader.status != LoaderStatus.COMPLETED) && !this._screen3IsLoaded) {
                Global.debug(this, "Loading --> acreen3AllLoRes");
                this.screen3LoResLoader.prioritize();
                this.screen3LoResLoader.addEventListener(LoaderEvent.COMPLETE, this.hasLoaded, false, 0, true);
                this.screen3LoResLoader.addEventListener(LoaderEvent.PROGRESS, this.venu7ProgressBar.progress, false, 0, true);
                TweenLite.to( this.venu7ProgressBar, Global.t.TRANSITION, {autoAlpha:1, ease:Global.t.EASE} );
            } else {
                this.callBack();
            }
        }
    }


    private function hasLoaded( event:LoaderEvent ):void {



        if ( this._selectedItem == 0 && !_screen0IsLoaded ) {
            _screen0IsLoaded = true;
            this.screen0LoResLoader.removeEventListener(LoaderEvent.COMPLETE, this.callBack );
            this.screen0LoResLoader.removeEventListener(LoaderEvent.PROGRESS, this.venue11ProProgressBar.progress );
            TweenLite.to( this.venue11ProProgressBar, Global.t.TRANSITION, {autoAlpha:0, ease:Global.t.EASE} );
            this.callBack();
        }

        if ( this._selectedItem == 1 && !_screen1IsLoaded ) {
            _screen1IsLoaded = true;
            this.screen1LoResLoader.removeEventListener(LoaderEvent.COMPLETE, this.callBack );
            this.screen1LoResLoader.removeEventListener(LoaderEvent.PROGRESS, this.venue8ProProgressBar.progress );
            TweenLite.to( this.venue8ProProgressBar, Global.t.TRANSITION, {autoAlpha:0, ease:Global.t.EASE} );
            this.callBack();
        }

        if ( this._selectedItem == 2 && !_screen2IsLoaded ) {
            _screen2IsLoaded = true;
            this.screen2LoResLoader.removeEventListener(LoaderEvent.COMPLETE, this.callBack );
            this.screen2LoResLoader.removeEventListener(LoaderEvent.PROGRESS, this.venue8ProgressBar.progress );
            TweenLite.to( this.venue8ProgressBar, Global.t.TRANSITION, {autoAlpha:0, ease:Global.t.EASE} );
            this.callBack();
        }

        if ( this._selectedItem == 3 && !_screen3IsLoaded ) {
            _screen3IsLoaded = true;
            this.screen3LoResLoader.removeEventListener(LoaderEvent.COMPLETE, this.callBack );
            this.screen3LoResLoader.removeEventListener(LoaderEvent.PROGRESS, this.venu7ProgressBar.progress );
            TweenLite.to( this.venu7ProgressBar, Global.t.TRANSITION, {autoAlpha:0, ease:Global.t.EASE} );
            this.callBack();
        }
    }

    private function callBack():void {
        if (this.callBackFunction != null) {
            this.callBackFunction.call( null, this._selectedItem );
        }

    }

    private function createHitTarget(_width:Number, _height:Number ):Sprite {
        var hitTarget:Sprite = new Sprite();
        hitTarget.graphics.beginFill(0x009999, 0);
        hitTarget.graphics.drawRect( -5, -5, _width + 5, _height + 5);
        hitTarget.graphics.endFill();
        hitTarget.buttonMode = true;
        hitTarget.useHandCursor = true;

        return hitTarget;
    }


}
}