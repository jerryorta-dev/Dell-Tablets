package com.dell.controls.components.core.abstract {
import com.dell.errors.AbstractMethodError;

import flash.display.Sprite;
import flash.text.TextField;

public class AbstractTextfieldFactory {

    public function add(copy:String, componentType:uint, target:Sprite, xPos:Number, yPos:Number, _textFieldParams:Object):TextField {

        //create a text property
        _textFieldParams.text = copy;

        var _component:TextField = this.createComponent(componentType, _textFieldParams);
        _component.x = xPos;
        _component.y = yPos;
        target.addChild(_component);

        return _component;
    }

    protected function createComponent(graphicType:uint, _textFieldParams:Object ):TextField {
        throw new AbstractMethodError;
        return null;
    }

}
}