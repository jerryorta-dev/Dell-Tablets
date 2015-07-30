package com.dell.Omniture
{

import com.dell.core.Global;
import com.dell.debug.abstract.Debugger;
import com.dell.services.PathManager;
import com.omniture.AppMeasurement;

public class Tracker
	{
		private var s:AppMeasurement;
		
		public function Tracker() 
		{
			s = new AppMeasurement();
			Global.stage.addChild( s );
		}
		
		public function configActionSource():void
		{
  

            /* Specify the Report Suite ID(s) to track here */
//			s.account = "dellglobalonline";// (development: dellglobalonlinedev)
			s.account = Global.p.OMNITURE_ACCOUNT;// (development: dellglobalonlinedev)
			
			Global.setDebuggerLabel( "OMNITURE SERVER ");
            Global.debug(this, s.account );
			
			/* You may add or alter any code config here */
			s.pageName = PathManager.country + ":" + PathManager.language + ":" + PathManager.segment + ":" + PathManager.customerset + ":" + "flash" + ":" + Global.p.OMNITURE_SITE;
			
			s.charSet = "UTF-8";
			s.currencyCode = "USD";
			
			/* Turn on and configure ClickMap tracking here */
			s.trackClickMap = Global.p.OMNITURE_TRACK_CLICK_MAP;
			
			/* Turn on and configure debugging here */
			s.debugTracking = Global.p.OMNITURE_DEBUG_TRACKING;
			s.trackLocal = Global.p.OMNITURE_TRACK_LOCAL;
			
			/* WARNING: Changing any of the below variables will cause drastic changes
			to how your visitor data is collected.  Changes should only be made
			when instructed to do so by your account manager.*/
			s.dc = "112";
			
			
			if (s.account.substr(s.account.length-3)!='dev') {
				
				s.trackingServer="nsm.dell.com";
				s.trackingServerSecure="sm.dell.com";
				
			}
			
			s.prop49="?c=" + PathManager.country + "&l=" + PathManager.language + "&s=" + PathManager.segment + "&cs=" + PathManager.customerset;
			
			s.visitorNamespace = "dell";
			
		}
		
		public function trackMetrics( event:TrackEvent ):void
		{
			var _clickType:String = event.clickType;
			var _metricID:String = ( event.metricID != "" ) ? event.metricID : "all";
			s.prop4 = PathManager.country + ":" + PathManager.language + ":" + PathManager.segment + ":" + PathManager.customerset + ":" +  "flash" + ":" + Global.p.OMNITURE_SITE + ":" + _clickType + ":" + _metricID;
			s.track();
			
			var prevDebugColor:uint = Debugger._color;
			var prevDegugLabal:String = Debugger._label;
			
			Global.setDebuggerLabel( "s.prop4" );
			Global.setDebuggerColor( Global.p.OMNITURE_DEBUGGER_LABEL_COLOR );
			Global.debug( this, s.prop4 );
			Global.setDebuggerLabel( prevDegugLabal );
			Global.setDebuggerColor( prevDebugColor );
			
			
//			trace("");
//			trace("s.prop4: "+s.prop4);
//			trace("");
			
//			trackingDebug.text += "\n"+s.prop4;
		}
		
	}
}