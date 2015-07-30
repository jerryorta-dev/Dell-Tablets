/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/27/13
 * Time: 2:53 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.utils.textField {
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;


public function measureString(str:String, format:TextFormat):Rectangle {
    var textField:TextField = new TextField();
    textField.defaultTextFormat = format;
    textField.text = str;

    return new Rectangle(0, 0, textField.textWidth, textField.textHeight);
}


}

