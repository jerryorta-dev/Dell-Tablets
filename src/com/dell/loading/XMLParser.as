/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/1/13
 * Time: 11:26 AM
 *
 */
package com.dell.loading {

import com.greensock.events.LoaderEvent;



/**
 * Only organize data to build the interface, do not build display objects here
 */
public class XMLParser {

    protected var vars:Object;

    protected var _dataVector:Vector.<Object>;
    protected var _data:Object;

    protected var _eventData:Object;


    protected var _onComplete:Function;


    public function XMLParser(vars:Object = null) {
        this.vars = (vars != null) ? vars : {};
        _onComplete = (this.vars.onComplete != null) ? this.vars.onComplete : null;

        _data = new Object();

    }


    public function parseData(event:LoaderEvent):void {
// parse copy xml
        parseCopy();
    }

    protected function parseCopy():void {
		// call complete method
        complete();
    }


    protected function complete():void {

        if (_onComplete != null) {
            _onComplete.apply(null, [_data]); // call callBack method and pass data object
        }
    }


}
}