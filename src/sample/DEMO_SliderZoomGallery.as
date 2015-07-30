package sample 
{

import com.dell.controls.UIFactory;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.core.Global;
import com.dell.core.Template;
import com.dell.events.UIEvent;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;

import flash.display.DisplayObject;

import project_tablets_1297.EmbeddedAssets;
import project_tablets_1297.Params;
import project_tablets_1297.T;
import project_tablets_1297.TabletsXMLParser;

[SWF(width="965", height="500", frameRate="60", backgroundColor="0x000000")]
	public class DEMO_SliderZoomGallery extends Template
	{
		
		[Embed(source="/assets/fonts/PillAlt600mg-Medium.ttf",
            fontName="pillMedium",
            fontFamily="pillMedium",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var pillMedium:Class;
		
		[Embed(source="/assets/fonts/PillAlt600mg-Bold.ttf",
            fontName="pillBold",
            fontFamily="pillBold",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var pillBold:Class;
		
		[Embed(source="/assets/fonts/PillAlt600mg-Regular.ttf",
            fontName="pillRegular",
            fontFamily="pillRegular",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var pillRegular:Class;
		
		[Embed(source="/assets/fonts/museosansfordell-700-webfont.ttf",
            fontName="museoSans700",
            fontFamily="museoSans700",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
		private var museoSans700:Class;
		
		public function DEMO_SliderZoomGallery()
		{
			super();
	
		}
		
		override protected function initialize():void {
			
			//Assign project_tablets_1297 Params object
			Global.p = new Params();
			
			//Assign project_tablets_1297 Timing object
			Global.t = new T();
			
			//Order which to load LoaderMax Queues from XML Queues
//			Global.setLoaderPriorities( new <String>["screen0SwfsLoRes", "screen0ImagesLoRes", "screen0SwfsHiRes", "screen0ImagesHiRes"] );
			

			//Module array index number for this subload
			Global.moduleIndex = 0;
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
			
			
			/*
			trace( Global.data.copy.modules[0].name );
			trace( Global.data.copy.modules[0].threeSixty.title );
			trace( Global.data.copy.modules[0].threeSixty.descr );
			trace( Global.data.copy.modules[0].slides[0].id );
			trace( Global.data.copy.modules[0].slides[0].headline );
			trace( Global.data.copy.modules[0].slides[0].subhead );
			*/
			
		
			var img:DisplayObject = new EmbeddedAssets.sky();
			img.x = 0;
			img.y = 0;
			addChild(img);
//			TweenLite.to(img, T.INTRO_FADE_TIME, {x: 100, ease:T.INTRO_EASE});
		
			var cf:UIFactory = new UIFactory();
			var myUI:AbstractUI = cf.add( UIFactory.SLIDER_GALLERY_ZOOM_TABLETS_DEFAULT, this, 300, 400);
            myUI.addEventListener( UIEvent.NAV_ITEM_SELECT, this.testUI, false, 0, true);
            myUI.addEventListener( UIEvent.SCRUBBING, this.testUI, false, 0, true);
            myUI.addEventListener( UIEvent.SCRUB_COMPLETE, this.testUI, false, 0, true);
            myUI.addEventListener( UIEvent.GALLERY_ITEM_SELECT, this.testUI, false, 0, true);
            myUI.addEventListener( UIEvent.ZOOMIMG, this.testUI, false, 0, true);
            myUI.addEventListener( UIEvent.ZOOM_COMPLETE, this.testUI, false, 0, true);

        }

        private function testUI( event:UIEvent ):void {
//            trace(event.type + " ----> " + event.data);
        }
		
		private function onComplete(Event:LoaderEvent):void
		{
			trace("subload complete");
		}


	}
}