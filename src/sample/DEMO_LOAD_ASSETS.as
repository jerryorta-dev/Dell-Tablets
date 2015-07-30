package sample 
{

import com.dell.controls.TextfieldFactory;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.core.Global;
import com.dell.core.Template;
import com.dell.events.UIEvent;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;

import flash.display.DisplayObject;
import flash.text.TextField;

import project_tablets_1297.EmbeddedAssets;
import project_tablets_1297.Params;
import project_tablets_1297.T;
import project_tablets_1297.TabletsXMLParser;
import project_tablets_1297.text.intro.CTA_Text;
import project_tablets_1297.text.intro.Headline;
import project_tablets_1297.text.intro.SubHead;
import project_tablets_1297.text.intro.Title0;
import project_tablets_1297.text.intro.Title1;
import project_tablets_1297.text.intro.Title2;

[SWF(width="965", height="500", frameRate="60", backgroundColor="0x000000")]
	public class DEMO_LOAD_ASSETS extends Template
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
		
		
		public function DEMO_LOAD_ASSETS()
		{
			super();
	
		}
		
		override protected function initialize():void {
			
			//Assign project_tablets_1297 Params object
			Global.p = new Params();
			
			//Assign project_tablets_1297 Timing object
			Global.t = new T();
			
			//Order which to load LoaderMax Queues.
//			Global.setLoaderPriorities( new <String>["module1SwfsLoRes", "module1ImagesLoRes", "module1SwfsHiRes", "module1ImagesHiRes"] );
//			LoaderMax.prioritize( "module1SwfsLoRes" );
			
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