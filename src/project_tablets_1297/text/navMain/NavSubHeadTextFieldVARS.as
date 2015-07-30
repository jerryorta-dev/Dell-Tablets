/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/5/13
 * Time: 2:24 PM
 * To change this template use File | Settings | File Templates.
 */
package project_tablets_1297.text.navMain {
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.core.interfaces.ITextFieldParams;

import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;

import flash.text.TextFormatAlign;

import project_tablets_1297.NavScreen;

public class NavSubHeadTextFieldVARS extends AbstractTextFieldParams implements  ITextFieldParams{
    public function NavSubHeadTextFieldVARS() {
        super();
    }
    
    
    override public function noFont_VARS():void {

        // TEXT FORMAT
        _noFont_FORMAT_VARS.color( 0x444444 );
        _noFont_FORMAT_VARS.size(13);
        _noFont_FORMAT_VARS.leading(1);
        _noFont_FORMAT_VARS.font("_sans");
        _noFont_FORMAT_VARS.align( TextFormatAlign.LEFT );

    }
    
    override public function embeddedFont_VARS():void {

        // TEXT FORMAT
        _embeddedFont_FORMAT_VARS.color( 0x444444 );
        _embeddedFont_FORMAT_VARS.size( 13 );
        _embeddedFont_FORMAT_VARS.leading(1);
        _embeddedFont_FORMAT_VARS.font( "museosansfordell300" );
        _embeddedFont_FORMAT_VARS.align(TextFormatAlign.LEFT);


    }

    override public function textField_VARS():void {
        // TEXT FIELD
        _textField_VARS.width( 120 );
        _textField_VARS.height( 20 );
        _textField_VARS.multiline( true );
        _textField_VARS.selectable( true );
        _textField_VARS.antiAliasType( AntiAliasType.ADVANCED );
        _textField_VARS.autoSize( TextFieldAutoSize.LEFT );
        _textField_VARS.wordWrap( true );

    }
    

}
}