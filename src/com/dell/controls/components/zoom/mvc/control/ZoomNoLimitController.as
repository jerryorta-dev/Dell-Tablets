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

public class ZoomNoLimitController extends ListController {

    private var SCALE_MIN:Number = 1; // 100%
    private var SCALE_MAX:Number = 2.74; // 274%

    private var SCALE_FACTOR:Number = 1; // 5% increments
//    private var SCALE_FACTOR:Number = .087; // 5% increments



    public function ZoomNoLimitController(aModel:IZoomDefaultModel, _minRange:Number = 0, _maxRange:Number = 100, _scaleFactor:Number = 1) {
        super(aModel);

        this.SCALE_FACTOR = _scaleFactor;
    }

    //Scale Up
    public function onZoomInHandler(  ):void {

        (this.model as IZoomDefaultModel).zoomIn( SCALE_FACTOR );

    }

    //Scale Down
    public function onZoomOutHandler(  ):void {

        (this.model as IZoomDefaultModel).zoomOut( -SCALE_FACTOR );

    }




}
}