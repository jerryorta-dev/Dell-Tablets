package com.dell.core
{
	import com.dell.errors.ErrorHandler;
	import com.dell.loading.XMLParser;
import com.dell.loading.abstract.LoaderMaxHelper;
import com.dell.services.PathManager;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
import com.greensock.plugins.ThrowPropsPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	
	public class Template extends Sprite
	{
		
		public static var context:LoaderContext;
		public static var isLive:Boolean;   		
		
		public function Template()
		{
			super();
			
			Security.allowDomain("*");	
			
			context = new LoaderContext( );
			context.checkPolicyFile = true;
			if( Security.sandboxType == Security.REMOTE )
			{
				context.securityDomain = SecurityDomain.currentDomain;
			}
			context.applicationDomain = ApplicationDomain.currentDomain;
			
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			
			
			//wait for loaderinfo to get flashvars
			root.loaderInfo.addEventListener(Event.COMPLETE, checkLocal,false,0,true);				
			root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOError);
		}
		
		private function checkLocal(e:Event):void{
			
			var url:String = LoaderInfo(e.target).url;			
			
			if(url.indexOf("file") >= 0){
				isLive = false;	
			}else{
				isLive = true;	
			}

			setBackground();
            commitProperties()
			
		}
		
		private function setBackground():void {
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill( Global.p.APP_BACKGROUND_COLOR , 1);
			bg.graphics.drawRect( 0, 0, this.stage.stageWidth, this.stage.stageHeight );
			bg.graphics.endFill();
			bg.x = bg.y = 0;
			this.addChild(bg);
			
			this.initialize();
		}

        protected function initialize():void {

        }

        /**
         * <p>Initialize PathManather, Global, and LoaderMax.</p>
         * TODO Use flashvars here if needed
         * @param e
         */
		private function commitProperties (e:Event = null) :void {
			
			



			Global.init( this.stage, root );
			Global.getPathManager();

            Global.moduleIndex = Global.p.MODULE_INDEX;
					
			if (Global.p.DEBUG_ENABLED)
			{
				//Set the label of your traces
				Global.setDebuggerLabel( "Release Info" );
				//Set MonsterDebugger color of t races
				Global.setDebuggerColor( Global.p.DEBUG_INITIAL_COLOR );
				//Set MonsterDebugger depth of object tracing
				Global.setDebuggerDepth( Global.p.DEBUG_DEPTH );
				//Set developer's name
				Global.setDebuggerPerson( Global.p.APP_DEVELOPER );
				
				Global.debug(null, "Art Director: " + Global.p.APP_ART_DIRECTOR );
				Global.debug(null, "Developer: " + Global.p.APP_DEVELOPER );
				Global.debug(null, "Department: " + Global.p.APP_DEPARTMENT );
				Global.debug(null, "Release Date: " + Global.p.APP_RELEASE_DATE );
				Global.debug(null, "Release Version: " + Global.p.APP_VERSION );
				Global.debug(null, "Flash Player Version: " + Capabilities.version );
				
			}
			
			if (Global.p.PATHMANAGER_ENABLED)
			{

				Global.setDebuggerLabel( "Pathmanager results" );
				Global.debug(this, "Base URL: " + Global.BASE_URL );
				Global.debug(this, "Country: " + Global.getCountry() );
				Global.debug(this, "Language: " + Global.getLanguage() );
				Global.debug(this, "Config XML: " + Global.CONFIG_XML );
				Global.debug(this, "Localized XML: " + Global.LOCALIZED_XML );
			}
			
			if (Global.p.OMNITURE_ENABLED)
			{
				Global.trackMetrics( "FlashPlayerVersion", Capabilities.version );
			}


            LoaderMax.activate( Global.p.LOADERMAX_ACTIVATE );
			TweenPlugin.activate([ThrowPropsPlugin]);
			

			this.loadXML();
		
		}
		
		private var parser:XMLParser;

		
		protected function loadXML():void 
		{
			parser = new Global.p.XML_PARSER({onComplete: dataComplete});
		
			var queue:LoaderMax = new LoaderMax({name: Global.p.XML_LOADERMAX_NAME, onComplete: parser.parseData});

            if ( Global.p.XML_LOAD_CONFIG ) {
//				trace( PathManager.getConfigXML() );
                queue.append(new XMLLoader(PathManager.getConfigXML(), {name: Global.p.XML_CONFIG_LOADER_NAME }));
            }

            if ( Global.p.XML_LOCALIZED_LOADERS ) {
//				trace( PathManager.getLocalizedLoadersXML() );
                queue.append(new XMLLoader(PathManager.getLocalizedLoadersXML(), {name: Global.p.XML_ASSET_lOADER_NAME }));
            }

            queue.append(new XMLLoader(PathManager.getLocalizedXML(), {name: Global.p.XML_LOCALIZED_LOADER_NAME }));
			queue.load();
			
		}


		
		private function dataComplete( data:Object ):void
		{

	            //Prepend LoaderMax URLs
            LoaderMaxHelper.prependURLsRecursively( "master" );
			Global.data = data;
			this.ready();
		}





		
		protected function ready():void {
			
		}
		
		public function callFromChildSwf():void {
			trace("Parent called")
			//        mcDesign.startBuild();
		}


	}
}