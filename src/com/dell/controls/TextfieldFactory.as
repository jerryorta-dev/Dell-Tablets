package com.dell.controls
{
import com.dell.controls.components.core.abstract.AbstractTextfieldFactory;
import com.dell.controls.components.text.DefaultTextfield;

import flash.text.TextField;

public class TextfieldFactory extends AbstractTextfieldFactory
	{

        public static const DEFAULT:uint = 0;

        override protected function createComponent( graphicType:uint, _textFieldParams:Object ):TextField {
            if (graphicType == DEFAULT) {
              return  DefaultTextfield.drawWidget( _textFieldParams );
            }  else {
                throw new Error("Invalid kind of progressB specified");
                return null;
            }
        }
	}
}