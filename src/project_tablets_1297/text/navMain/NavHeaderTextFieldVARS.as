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
import project_tablets_1297.Params;

public class NavHeaderTextFieldVARS extends AbstractTextFieldParams implements  ITextFieldParams{
    public function NavHeaderTextFieldVARS() {
        super();
    }
    
    
    override public function noFont_VARS():void {

        // TEXT FORMAT
        _noFont_FORMAT_VARS.color( Params.NAV_OFF );
        _noFont_FORMAT_VARS.size(14);
        _noFont_FORMAT_VARS.leading(1);
        _noFont_FORMAT_VARS.font("_sans");
        _noFont_FORMAT_VARS.align( TextFormatAlign.LEFT );

    }
    
    override public function embeddedFont_VARS():void {

        // TEXT FORMAT
        _embeddedFont_FORMAT_VARS.color( Params.NAV_OFF );
        _embeddedFont_FORMAT_VARS.size( 14 );
        _embeddedFont_FORMAT_VARS.leading(1);
        _embeddedFont_FORMAT_VARS.font( "museoSans700" );
        _embeddedFont_FORMAT_VARS.align(TextFormatAlign.LEFT);


    }

    override public function textField_VARS():void {
        // TEXT FIELD
        _textField_VARS.width( 145 );
        _textField_VARS.height( 20 );
        _textField_VARS.multiline( true );
        _textField_VARS.selectable( false );
        _textField_VARS.antiAliasType( AntiAliasType.ADVANCED );
        _textField_VARS.autoSize( TextFieldAutoSize.LEFT );
        _textField_VARS.wordWrap( true );

    }
    

}
}
