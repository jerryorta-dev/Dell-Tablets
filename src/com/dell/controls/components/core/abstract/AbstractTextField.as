package com.dell.controls.components.core.abstract {
import com.dell.errors.AbstractMethodError;

import flash.text.TextField;

public class AbstractTextField {
    public function AbstractTextField() {
//			throw new AbstractClassError();
    }


    // ABSTRACT Method (must be overridden in a subclass)
    public static function drawWidget(vars:Object = null):TextField {
        throw new AbstractMethodError();
        return null;
    }

}
}