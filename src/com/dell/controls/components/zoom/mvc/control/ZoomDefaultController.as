/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/3/13
 * Time: 3:04 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.zoom.mvc.control {
import com.dell.controls.components.lists.mvc.control.ListController;
import com.dell.controls.components.zoom.mvc.model.IZoomDefaultModel;

public class ZoomDefaultController extends ListController {

    private var SCALE_MIN:Number = 1; // 100%
    private var SCALE_MAX:Number = 2.74; // 274%

    private var SCALE_FACTOR:Number = .087; // 5% increments
	


    public function ZoomDefaultController(aModel:IZoomDefaultModel, _minRange:Number = 0, _maxRange:Number = 100, _scaleFactor:Number = 1) {
        super(aModel);
        this.SCALE_MIN = _minRange;
        this.SCALE_MAX = _maxRange;
        this.SCALE_FACTOR = _scaleFactor;
    }

    //Scale Up
    public function onZoomInHandler( scaleRequest:Number ):void {
        var result:Number =  scaleRequest += SCALE_FACTOR;
        if ( !this.isUpperRange( result ) ) {
            result = this.SCALE_MAX;
        }

        (this.model as IZoomDefaultModel).zoomIn( result );

    }

    //Scale Down
    public function onZoomOutHandler( scaleRequest:Number ):void {
        var result:Number =  scaleRequest -= SCALE_FACTOR;
        if ( !this.isLowerRange( result ) ) {
            result = this.SCALE_MIN;
        }


        (this.model as IZoomDefaultModel).zoomOut( result );

    }



    public function onZoomComplete(finalValue:Number):void {

    }



    /**
     * If value is within range of scaleMin and scaleMax;
     */
    private function isUpperRange( value:Number ):Boolean {
        return value < this.SCALE_MAX;
    }

    private function isLowerRange(value:Number):Boolean {
        return value > this.SCALE_MIN;
    }


}
}
