package project_tablets_1297
{
import com.greensock.easing.Ease;
import com.greensock.easing.Quad;
import com.greensock.easing.Sine;
import com.greensock.easing.SineIn;
import com.greensock.easing.SineOut;
import com.greensock.easing.Strong;

/**
	 * <p>Specs, Timing, Animation params, etc.</p> 
	 * @author Jerry_Orta
	 * 
	 */	
	public class T
	{

		public static const INTRO_FADE_TIME:Number = .4;
		public static const INTRO_EASE:SineOut = Sine.easeOut;
		
		public static const INTRO_FADE_IN:Number = 2.2;
		public static const INTRO_FADE_OUT:Number = 1.1;
		public static const TABLET_SLIDE_TIME:Number = 4;
		
		public static const EASE_REG:SineOut = Sine.easeOut;
		public static const EASE_STR_IN:SineIn = Sine.easeIn;
		public static const EASE_QUAD_OUT:Ease = Quad.easeOut;
		public static const X_OFFSET:Number = 860;	
		
		public const INTRO_FADE_TIME:Number = .4;
		public const INTRO_EASE:Ease = Sine.easeOut;

        public const TRANSITION:Number = .25;

        public const EASE:Ease = Strong.easeOut;
		
		public function T() { };
		
		public function init():void {
			//init stuff
		}
	}
}