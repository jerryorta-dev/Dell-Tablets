package project_tablets_1297 {
import com.dell.core.Global;
import com.dell.loading.XMLParser;
import com.greensock.events.LoaderEvent;

public class TabletsXMLParser extends XMLParser {
    public function TabletsXMLParser(vars:Object = null) {
        super(vars);
    }


	override public function parseData(event:LoaderEvent):void
	{

        _eventData = event.target;

        //Start by parsing the config xml
//        var _config:XMLList = (_eventData.getContent(Global.p.XML_CONFIG_LOADER_NAME ) as XML).nav.item;

        //Will attach to data object
//        _data.config = {};

        //do parsing
//        for each (var _t:XML in _config) {
//            var obj:Object = {};
//            obj.name = String(_t.@name);
//            obj.stateName = String(_t.@stateName);
//            obj.icon = String(_t.@icon + ".png");
//            obj.initState = String(_t.@initState);
//            _data.config[ String(_t.@name) ] = obj;
//        }

        super.parseData(event);
    }


    override protected function parseCopy():void {
        //PARSE NAV
		_data.copy = {};

        var _shell:XMLList = (_eventData.getContent(Global.p.XML_LOCALIZED_LOADER_NAME) as XML).shell;

        var nav:Object = {};

        nav.work = _shell.nav.topLabel;
        nav.workX = _shell.nav.topLabel.@["x"];
        nav.play = _shell.nav.bottomLabel;
        nav.playX = _shell.nav.bottomLabel.@["x"];

        nav.venue11Pro = {};
        nav.venue11Pro.title = _shell.nav.item[0].title;
        nav.venue11Pro.descr = _shell.nav.item[0].descr;
        nav.venue11Pro.progressBarWidth = Number(_shell.nav.item[0].@["progressBarWidth"]);

        nav.venue8Pro = {};
        nav.venue8Pro.title = _shell.nav.item[1].title;
        nav.venue8Pro.descr = _shell.nav.item[1].descr;
        nav.venue8Pro.progressBarWidth = Number(_shell.nav.item[1].@["progressBarWidth"]);

        nav.venue8 = {};
        nav.venue8.title = _shell.nav.item[2].title;
        nav.venue8.descr = _shell.nav.item[2].descr;
        nav.venue8.progressBarWidth = Number(_shell.nav.item[2].@["progressBarWidth"]);

        nav.venue7 = {};
        nav.venue7.title = _shell.nav.item[3].title;
        nav.venue7.descr = _shell.nav.item[3].descr;
        nav.venue7.progressBarWidth = Number(_shell.nav.item[3].@["progressBarWidth"]);

        _data.copy.nav = nav;


		// PARSE INTRO
        var _copy:XMLList = (_eventData.getContent(Global.p.XML_LOCALIZED_LOADER_NAME) as XML).intro;

        var intro:Object = {};
        intro.title0 = {};
        intro.title0.text =  _copy.title[0];
        intro.title0.callOutWidth = _copy.title[0].@["callOutWidth"];
        intro.title0.x = _copy.title[0].@["x"];
        intro.title0.y = _copy.title[0].@["y"];
        intro.title0.color = _copy.title[0].@["color"];
        intro.title0.expandDirection = _copy.title[0].@["expandDirection"];
        intro.title0.backgroundAlpha = _copy.title[0].@["backgroundAlpha"];

        intro.title1 = {};
        intro.title1.text =  _copy.title[1];
        intro.title1.callOutWidth = _copy.title[1].@["callOutWidth"];
        intro.title1.x = _copy.title[1].@["x"];
        intro.title1.y = _copy.title[1].@["y"];
        intro.title1.color = _copy.title[1].@["color"];
        intro.title1.expandDirection = _copy.title[1].@["expandDirection"];
        intro.title1.backgroundAlpha = _copy.title[1].@["backgroundAlpha"];

        intro.title2 = {};
        intro.title2.text =  _copy.title[2];
        intro.title2.callOutWidth = _copy.title[2].@["callOutWidth"];
        intro.title2.x = _copy.title[2].@["x"];
        intro.title2.y = _copy.title[2].@["y"];
        intro.title2.color = _copy.title[2].@["color"];
        intro.title2.expandDirection = _copy.title[2].@["expandDirection"];
        intro.title2.backgroundAlpha = _copy.title[2].@["backgroundAlpha"];

        intro.headline = {};
        intro.headline.text = _copy.headline;
        intro.headline.callOutWidth = _copy.headline.@["callOutWidth"];
        intro.headline.x = _copy.headline.@["x"];
        intro.headline.y = _copy.headline.@["y"];
        intro.headline.color = _copy.headline.@["color"];
        intro.headline.expandDirection = _copy.headline.@["expandDirection"];
        intro.headline.backgroundAlpha = _copy.headline.@["backgroundAlpha"];

        intro.subhead = {};
        intro.subhead.text = _copy.subhead;
        intro.subhead.callOutWidth = _copy.subhead.@["callOutWidth"];
        intro.subhead.x = _copy.subhead.@["x"];
        intro.subhead.y = _copy.subhead.@["y"];
        intro.subhead.color = _copy.subhead.@["color"];
        intro.subhead.expandDirection = _copy.subhead.@["expandDirection"];
        intro.subhead.backgroundAlpha = _copy.subhead.@["backgroundAlpha"];

        intro.cta = {};
        intro.cta.text = _copy.cta;
        intro.cta.callOutWidth = _copy.cta.@["callOutWidth"];
        intro.cta.x = _copy.cta.@["x"];
        intro.cta.y = _copy.cta.@["y"];
        intro.cta.color = _copy.cta.@["color"];
        intro.cta.expandDirection = _copy.cta.@["expandDirection"];
        intro.cta.backgroundAlpha = _copy.cta.@["backgroundAlpha"];

		intro.introView = {};
		intro.introView.altDisplay = _copy.introView.@["altDisplay"];
		
		
        //Attach to _data.copy
        _data.copy.intro = intro;


        //<productscreen name="11pro">
        var _products:XMLList = (_eventData.getContent(Global.p.XML_LOCALIZED_LOADER_NAME) as XML).products.productScreen;

		var modulesVector:Vector.<Object> = new Vector.<Object>;

		for each (var _module:XML in _products) {
			var screen:Object = new Object();
			screen.name = _module.@["name"];
			
			var threeSixty:Object = new Object();
			threeSixty.title = _module.threeSixty.title;
			threeSixty.descr = _module.threeSixty.descr;

            threeSixty.color =  _module.threeSixty.@["color"];
            threeSixty.callOutWidth = _module.threeSixty.@["callOutWidth"];
            threeSixty.backgroundAlpha = _module.threeSixty.@["backgroundAlpha"];
            threeSixty.x = _module.threeSixty.@["x"];
            threeSixty.y = _module.threeSixty.@["y"];

			screen.threeSixty = threeSixty;
			
			screen.slides = this.parseSlide( _module.slides.slide );
			
			modulesVector.push( screen );
		}
		
		_data.copy.screen = modulesVector;


        super.parseCopy();
    }
	
	private function parseSlide( _xmlList:XMLList ):Vector.<Object> {
		var slidesVector:Vector.<Object> = new Vector.<Object>();

		for each (var slide:XML in _xmlList) {
			var slideObj:Object = {};
		
			//if have multiple copyBoxes per headline, they would share the same id
			slideObj.id = slide.@["id"];
			slideObj.callOutWidth = slide.@["callOutWidth"];
			slideObj.x = slide.@["x"];
			slideObj.y = slide.@["y"];
			slideObj.backgroundAlpha = slide.@["backgroundAlpha"];
			slideObj.expandDirection = slide.@["expandDirection"];
			slideObj.color = slide.@["color"];

			slideObj.headline = slide.copyBox.headline;
			slideObj.subhead = slide.copyBox.subhead;
			
			slidesVector.push( slideObj );
		}

		return slidesVector;
	}
}
}