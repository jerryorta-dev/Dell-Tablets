package sample
{

import com.dell.controls.Callout_C_Factory;
import com.dell.controls.components.core.abstract.AbstractCalloutParams;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.core.Global;
import com.dell.core.Template;
import com.dell.events.UIEvent;
import com.greensock.events.LoaderEvent;

import flash.display.DisplayObject;

import project_tablets_1297.EmbeddedAssets;
import project_tablets_1297.Params;
import project_tablets_1297.T;
import project_tablets_1297.text.gallery.GalleryCalloutButtonParams;

[SWF(width="965", height="500", frameRate="60", backgroundColor="0x000000")]
	public class DEMO_Callout extends Template
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
		
		
		public function DEMO_Callout()
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
			
			//create a SWFLoader that will add the content to the display list at position x:50, y:100 when it has loaded:
			//			var loader:SWFLoader = new SWFLoader("SubLoadMain.swf", {name:"mainSWF", container:this, estimatedBytes:9500});
			//			loader.load();
			//Load assets

			var img:DisplayObject = new EmbeddedAssets.sky();
			img.x = 0;
			img.y = 0;
			addChild(img);
			
			const params:AbstractCalloutParams = new GalleryCalloutButtonParams();
			params.text = "TEST TEXT BLASH ;Alaksdj aslj asjf as dflj a asljfaj as fa ldflaksj ";
			const callout:AbstractUI = new Callout_C_Factory().add(Callout_C_Factory.DEFAULT_CALLOUT, this, 300, 300, params);
//            params.text = "Button 2 ";
//            const callout2:AbstractUI = new CalloutFactory().add(CalloutFactory.DEFAULT_CALLOUT, this, 600, 300, params);
			


        }

        private function testUI( event:UIEvent ):void {
            trace(event.type + " ----> " + event.data);
        }
		
		private function onComplete(Event:LoaderEvent):void
		{
			trace("subload complete");
		}


	}
}