package com.dell.controls
{
	import com.dell.controls.components.core.abstract.AbstractUI;
	import com.dell.controls.components.core.abstract.AbstractUIFactory;
	import com.dell.controls.components.scrubbers.lib.UI_MVC_ScrubberDefault;
	
	public class Scrubber_MVC_Factory extends AbstractUIFactory
	{
		public static const UI_MVC_SCRUBBER_DEFAULT			:uint = 0;

		override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
			if (graphicType == UI_MVC_SCRUBBER_DEFAULT) {
				return new UI_MVC_ScrubberDefault();
			} else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	
	}
}