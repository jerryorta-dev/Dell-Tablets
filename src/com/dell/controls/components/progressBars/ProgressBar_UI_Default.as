/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/31/13
 * Time: 11:54 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.progressBars {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.graphics.RectangleFactory;
import com.dell.graphics.components.core.abstract.AbstractGraphic;
import com.dell.graphics.data.RectangleVARS;
import com.greensock.events.LoaderEvent;

import flash.events.Event;

public class ProgressBar_UI_Default extends AbstractUI implements IUI {

    private var _background:AbstractGraphic;
    private var _progressBar:AbstractGraphic;

    private var _backgroundVars:RectangleVARS;
    private var _progressVars:RectangleVARS;
    private var _maxRawValue:Number;


    public function ProgressBar_UI_Default( vars:Object ):void {
        super( vars, null );

    }

    override public function commitProperties(event:Event = null):void {
        _backgroundVars = this._vars.backgroundVars;
        _progressVars = this._vars.progressBarVars;
        _maxRawValue = _backgroundVars.vars.width;
    }



    override public function draw():void {
        this.alpha = 0;
        this.visible = false;
        _background = new RectangleFactory().add( RectangleFactory.RECTANGLE_WITH_VARS, this, 0, 0, _backgroundVars)
        _progressBar = new RectangleFactory().add( RectangleFactory.RECTANGLE_WITH_VARS, this, 0, 0, _progressVars)

    }



    override public function initialize():void {

        _progressBar.width = 0;
    }

    public function progress( event:LoaderEvent ):void {
        var value:Number = event.target.progress;
        var result:Number = value * _maxRawValue;
        var radius:Number = _progressVars.vars.radius;
        var height:Number = _progressVars.vars.height;


        if (radius > 0) {
            //Grow Radius
            if ( result <= radius) {
                _progressBar.radius = result;
            } else {
                _progressBar.radius = radius;
            }

            //Grow Height
            if ( result <= height) {
                _progressBar.height = result;
                _progressBar.y = (height * .5) - (result * .5) ;
            } else  {
                _progressBar.height = height;
                _progressBar.y = 0;
            }

            //Center Vertically

        }



        _progressBar.width = result;
    }

    override public function activateComposite():Boolean {
        return true;
    }

    override public function deactivateComposite():Boolean {
        return true;
    }




}
}
