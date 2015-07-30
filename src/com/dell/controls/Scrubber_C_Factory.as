package com.dell.controls
{
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.abstract.AbstractUIFactory;
import com.dell.controls.components.scrubbers.scrubberUI.abstract.AbstractSliderUI;

public class Scrubber_C_Factory extends AbstractUIFactory
	{
		public static const UI_SCRUBBER_CONTROL			:uint = 0;

		override protected function createComponent(graphicType:uint, vars:Object = null, data:Object = null):AbstractUI {
			if (graphicType == UI_SCRUBBER_CONTROL) {
				return new AbstractSliderUI(vars, data);
			} else {
				throw new Error("Invalid kind of progressB specified");
				return null;
			}
		}
	
	}
}