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
	public class DEMO_Text extends Template
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
		
		public function DEMO_Text()
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
//			
			//assign xmlParser your Project's parsing class
			
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

			var img:DisplayObject = new EmbeddedAssets.sky();
			img.x = 0;
			img.y = 0;
			addChild(img);
//			TweenLite.to(img, T.INTRO_FADE_TIME, {x: 100, ease:T.INTRO_EASE});

		    var introCopy:Object = Global.data.copy.intro;
			
//			This object may be shared among multiple textfields if needed
//            var title0:AbstractTextFieldParams = new Title0();
//            var t0TF:TextField = new TextfieldFactory().add( introCopy.title0, TextfieldFactory.DEFAULT, this, 50, 50, title0);
//
//            var title1:AbstractTextFieldParams = new Title1();
//            var t1TF:TextField = new TextfieldFactory().add( introCopy.title1, TextfieldFactory.DEFAULT, this, 50, 100, title1);
//
//            var title2:AbstractTextFieldParams = new Title2();
//            var t2TF:TextField = new TextfieldFactory().add( introCopy.title2, TextfieldFactory.DEFAULT, this, 50, 150, title2);
//
//            var headline:AbstractTextFieldParams = new Headline();
//            var hlTF:TextField = new TextfieldFactory().add( introCopy.headline, TextfieldFactory.DEFAULT, this, 50, 200, headline);
//
//            var subhead:AbstractTextFieldParams = new SubHead();
//            var shTF:TextField = new TextfieldFactory().add( introCopy.subhead, TextfieldFactory.DEFAULT, this, 50, 250, subhead);
//
//			var ctaParams:AbstractTextFieldParams = new CTA();
//            var cta:TextField = new TextfieldFactory().add( introCopy.cta, TextfieldFactory.DEFAULT, this, 50, 350, ctaParams);

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