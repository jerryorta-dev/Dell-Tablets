/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 10/2/13
 * Time: 11:12 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.utils.textField {
import flash.text.TextField;

public function setMaxLines( _tf:TextField, _maxLines:int ):void {

    if (_maxLines != -1) {
        while( _tf.numLines > _maxLines) {
            _tf.width = _tf.width + 1;
        }
    }

}

}
