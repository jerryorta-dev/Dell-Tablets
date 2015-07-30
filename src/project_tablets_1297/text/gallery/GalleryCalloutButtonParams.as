/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/5/13
 * Time: 2:24 PM
 * To change this template use File | Settings | File Templates.
 */
package project_tablets_1297.text.gallery {
import com.dell.controls.components.core.abstract.AbstractCalloutParams;
import com.dell.controls.components.core.abstract.AbstractTextFieldParams;
import com.dell.controls.components.core.interfaces.ITextFieldParams;

import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;

import flash.text.TextFormatAlign;

public class GalleryCalloutButtonParams extends AbstractCalloutParams implements ITextFieldParams {
    public function GalleryCalloutButtonParams() {
        super();
    }


    override public function noFont_VARS():void {

        // TEXT FORMAT
        _noFont_FORMAT_VARS.color(0x0085c0);
        _noFont_FORMAT_VARS.size(13);
        _noFont_FORMAT_VARS.leading(4);
        _noFont_FORMAT_VARS.font("_sans");
        _noFont_FORMAT_VARS.align(TextFormatAlign.CENTER);


    }

    override public function embeddedFont_VARS():void {

        // TEXT FORMAT
        _embeddedFont_FORMAT_VARS.color(0x0085c0);
        _embeddedFont_FORMAT_VARS.size(13);
        _embeddedFont_FORMAT_VARS.leading(4);
        _embeddedFont_FORMAT_VARS.font("museoSans700");
        _embeddedFont_FORMAT_VARS.align(TextFormatAlign.CENTER);

    }

    override public function textField_VARS():void {
        // TEXT FIELD
        _textField_VARS.width(100);
//        _textField_VARS.height(10);
        _textField_VARS.multiline(true);
        _textField_VARS.selectable(false);
		
        _textField_VARS.antiAliasType(AntiAliasType.ADVANCED);
        _textField_VARS.autoSize(TextFieldAutoSize.CENTER);
        _textField_VARS.wordWrap(true);

    }

    override public function calloutGraphic_VARS():void {
        //Callout graphic
        _calloutGraphicVars.arrowWidth( 12 );
        _calloutGraphicVars.arrowHeight( 10 );
        _calloutGraphicVars.borderColor( 0xbbbbbb );
        _calloutGraphicVars.borderWeight( 1 );

        _calloutGraphicVars.arrowCentered( true );
        _calloutGraphicVars.rectangleRadiusArray( new <Number>[5, 5, 5, 5] );
        _calloutGraphicVars.arrowRadiusArray( new <Number>[1, 1, 1] );
        _calloutGraphicVars.arrowDirection( AbstractCalloutParams.ARROW_POSITION_BOTTOM );

    }

    override public function functionality_VARS():void {
        //Callout functionality
        _calloutVars.width( 125 );
        _calloutVars.minHeight(55);
//        _calloutVars.height( 66 );
        //Callout will expand horizontally if text requires more room.
        //Should only set maxWidth or maxHeight, but not both.
        //Should be opposite of width or height setting
        //TODO  not sure if this is needed
//			callOutFunctionalty.maxHeight( 100 );

        //With variable text, which way should the callout expand.
        _calloutVars.expandDirection( AbstractCalloutParams.EXPAND_HORIZONTALLY);

        //Set text to have max number of lines
        _calloutVars.textMaxLines( 2 );

        _calloutVars.padding( 8 );
		_calloutVars.paddingBottom( 2 );
//        _calloutVars.paddingTop( 12 );
        _calloutVars.registration( AbstractCalloutParams.REGISTER_BOTTOM_MIDDLE );
    }
}
}
