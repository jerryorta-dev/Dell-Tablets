/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 7/25/13
 * Time: 4:41 AM
 * To change this template use File | Settings | File Templates.
 */
package project_tablets_1297 {
	import com.dell.errors.AbstractClassError;

//    import flash.media.Sound;
//    import flash.media.SoundTransform;



    public class EmbeddedAssets {

		/*[Embed(source="/compiledAssets/intro/11pro_first.png")]
		public static var introTablet1:Class;
		
		[Embed(source="/compiledAssets/intro/7_left.png")]
		public static var introLeftTablet:Class;
		
		[Embed(source="/compiledAssets/intro/8pro_right.png")]
		public static var introRightTablet:Class;
		
		*/
		
		
		[Embed(source="/compiledAssets/intro/7_left.png")]
		public static var introLeftTablet:Class;
		
		[Embed(source="/compiledAssets/intro/11pro_first.png")]
		public static var introFirst11Pro:Class;

        [Embed(source="/compiledAssets/intro/8_back.jpg")]
		public static var introBackTablet:Class;

        [Embed(source="/compiledAssets/intro/flash-intro-no-androids-final-8Pro.jpg")]
		public static var introBackTablet8ProAlt:Class;

		[Embed(source="/compiledAssets/intro/leftNavUS.png")]
		public static var leftNavUS:Class;

		/*
		[Embed(source="/compiledAssets/explosion.mp3")]
		private static var explosionSound:Class;
		public static var explosion:Sound;
		*/

		public function EmbeddedAssets():void { throw new AbstractClassError() };

        public static function init():void {


			//For BUG in flash player, to load in memory
//			explosion = new explosionSound();
//			explosion.play( 0, 0, new SoundTransform( 0 ));

		}
    }
}
