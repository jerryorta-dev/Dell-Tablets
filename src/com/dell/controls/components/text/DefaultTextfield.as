/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/5/13
 * Time: 10:51 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.text {
import com.dell.controls.components.core.abstract.AbstractTextField;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.utils.number.fastMax2;

import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

public class DefaultTextfield extends AbstractTextField {


    public function DefaultTextfield() {
        super();
    }

    public static function drawWidget(_params:Object):TextField {
        var _tf:TextField = new TextField();
        var textFieldParams:Object = _params.textFieldVars.vars;


        //CONFIGS
        if ( textFieldParams.width != null ) {
            _tf.width = textFieldParams.width;
        }

        _tf.multiline = textFieldParams.multiline ? textFieldParams.multiline : true;
        _tf.selectable = textFieldParams.selectable ? textFieldParams.selectable : false;

        if (_params.embeddedFontFormat.font != null) {
            // create a Font reference
            var _font:Font;

            var _fonts:Array = Font.enumerateFonts();

			var _hasFont:Boolean = false;
            for (var c:Number = 0; c < _fonts.length; c++) {

                if (_fonts[c].fontName == _params.embeddedFontFormat.font) {
                    _font = _fonts[c];
					_hasFont = true;
                    break;
                }
            }
			
			if (!_hasFont) {
				throw new Error( "Need to embed the " + _params.embeddedFontFormat.font + " font in the document class");
			}


            if (_font.hasGlyphs(_params.text)) {
                _tf.antiAliasType = textFieldParams.antiAliasType;
                _tf.defaultTextFormat = _params.embeddedFontFormat;
                _tf.embedFonts = true;
            }
            else {
                _tf.defaultTextFormat = _params.noFontTextFormat;
            }
            
        }
        else {

//            var _tf2:TextFormat = new TextFormat( "_sans", 12 );
            _tf.antiAliasType = textFieldParams.antiAliasType;
            _tf.defaultTextFormat = _params.embeddedFontFormat;
        }
//        _tf.autoSize = TextFieldAutoSize.LEFT;
        _tf.autoSize = textFieldParams.autoSize ? textFieldParams.autoSize : TextFieldAutoSize.LEFT;
        _tf.wordWrap = textFieldParams.wordWrap ? textFieldParams.wordWrap : true;
        _tf.htmlText = _params.text;
//
        return _tf;

        //END FOR LOCALIZATION
        //***********************************************
        //***********************************************
        //***********************************************

    }


}
}