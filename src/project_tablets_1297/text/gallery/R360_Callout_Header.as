/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/5/13
 * Time: 2:24 PM
 * To change this template use File | Settings | File Templates.
 */
package project_tablets_1297.text.gallery {
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.core.interfaces.ITextFieldParams;

import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;

import flash.text.TextFormatAlign;

public class R360_Callout_Header extends AbstractTextFieldParams implements  ITextFieldParams{
    public function R360_Callout_Header() {
        super();
    }
    
    
    override public function noFont_VARS():void {

        // TEXT FORMAT
        _noFont_FORMAT_VARS.color(0x1181c1);
        _noFont_FORMAT_VARS.size(24);
        _noFont_FORMAT_VARS.leading(4);
        _noFont_FORMAT_VARS.font("_sans");
        _noFont_FORMAT_VARS.align( TextFormatAlign.CENTER );

    }
    
    override public function embeddedFont_VARS():void {

        // TEXT FORMAT
        _embeddedFont_FORMAT_VARS.color(0x1181c1);
        _embeddedFont_FORMAT_VARS.size(24);
        _embeddedFont_FORMAT_VARS.leading(4);
        _embeddedFont_FORMAT_VARS.font( "museosansfordell300" );
        _embeddedFont_FORMAT_VARS.align(TextFormatAlign.CENTER);


    }

    override public function textField_VARS():void {
        // TEXT FIELD
        _textField_VARS.width( 400 );
        _textField_VARS.height( 20 );
        _textField_VARS.multiline( true );
        _textField_VARS.selectable( true );
        _textField_VARS.antiAliasType( AntiAliasType.ADVANCED );
        _textField_VARS.autoSize( TextFieldAutoSize.CENTER );
        _textField_VARS.wordWrap( true );

    }
    

}
}
