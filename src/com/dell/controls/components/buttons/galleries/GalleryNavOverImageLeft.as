/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 3:18 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.buttons.galleries {
import com.dell.controls.Callout_C_Factory;
import com.dell.controls.components.buttons.DefaultButton;
import com.dell.controls.components.buttons.galleries.calloutViewStates.CalloutOffState;
import com.dell.controls.components.buttons.galleries.calloutViewStates.CalloutOnState;
import com.dell.controls.components.buttons.galleries.calloutViewStates.CalloutOverState;
import com.dell.controls.components.callouts.C_Callout_Default;
import com.dell.controls.components.core.abstract.AbstractCalloutParams;
import com.dell.core.Global;
import com.dell.graphics.RectangleFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.components.core.abstract.MovieClipFactory;
import com.dell.graphics.data.RectangleVARS;

import project_tablets_1297.text.gallery.GalleryRightLeftNavCalloutButtonParams;

public class GalleryNavOverImageLeft extends DefaultButton {

    //Callout
    private var _callout:C_Callout_Default;


    public function GalleryNavOverImageLeft(name:String, vars:Object = null, data:Object = null) {
        super(name, vars, data);

    }

    // GRAPHICS

    override public function draw():void {

//      _offGraphic = new MovieClipFactory(new UIGalleryNav().mcGalleryLeftNavOFF);
        _offGraphic = new MovieClipFactory(new UIGalleryNav().mcGalleryLeftNavON);
        this.addGraphic(_offGraphic);
        _offGraphic.mouseEnabled = false;


        _onGraphic = new MovieClipFactory(new UIGalleryNav().mcGalleryLeftNavON);
        this.addGraphic(_onGraphic);
        _onGraphic.mouseEnabled = false;

        _overGraphic = new MovieClipFactory(new UIGalleryNav().mcGalleryLeftNavON);
        this.addGraphic(_overGraphic);
        _overGraphic.mouseEnabled = false;

        const params:AbstractCalloutParams = new GalleryRightLeftNavCalloutButtonParams();
//        params.text = Global.data.copy.screen[ Global.moduleIndex ].slides[ i ].headline;
        params.text = Global.data.copy.screen[ this._data.screenIndex ].slides[ 0 ].headline;
        _callout = new Callout_C_Factory().add( Callout_C_Factory.DEFAULT_CALLOUT, this, 0, 0, params, this._data ) as C_Callout_Default;
        _callout.mouseEnabled = false;

        const rVars:RectangleVARS = new RectangleVARS().width(this._width).height(this._height).fillColor(0xffffff).fillAlpha(0);
        _hitGraphic = new RectangleFactory().add(RectangleFactory.RECTANGLE_WITH_VARS, this, 0, 0, rVars);


    }

    override public function addGraphic(_abstractGraphic:AbstractGraphic):void {
        _abstractGraphic.x = _abstractGraphic.y = 0;
        this.addChild(_abstractGraphic);
    }

    override public function initialize():void {

        _offGraphic.x = _onGraphic.x = _overGraphic.x = this._width / 2;
        _offGraphic.y = _onGraphic.y = _overGraphic.y = this._height / 2;


        _onGraphic.alpha = 0;
        _overGraphic.alpha = 0;

        _callout.x = (_offGraphic.x ) + (_offGraphic.width * .5);
        //TODO fix callout in graphics packgage
        _callout.y = (_offGraphic.y ) + (_offGraphic.height * .5);
        _callout.alpha = 0;

//		this.mouseEnabled = true;
//		this.mouseChildren = false;
//		this.useHandCursor = true;

//        onState = new OnState(this, _onGraphic, _offGraphic, _overGraphic);
//        offState = new OffState(this, _onGraphic, _offGraphic, _overGraphic);
//        overState = new OverState(this, _onGraphic, _offGraphic, _overGraphic);

        onState = new CalloutOnState( this, _onGraphic, _offGraphic, _overGraphic, _callout );
        offState = new CalloutOffState( this, _onGraphic, _offGraphic, _overGraphic, _callout );
        overState = new CalloutOverState( this, _onGraphic, _offGraphic, _overGraphic, _callout );



        this._stateClass = this.offState;
        this._state = this._stateClass.name;

		super.addListeners();
    }

    public function set text( _text:String ):void {
        _callout.text = _text;
    }




}
}
