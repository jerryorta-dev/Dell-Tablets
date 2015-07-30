package com.dell.graphics.components.core.abstract {
import flash.display.MovieClip;

/**
 * The only purpose of this class is a way to type MovieClips as an AbstractGraphic to use with other controls.
 */
public class MovieClipFactory extends AbstractGraphic {
    private var _movieClip:MovieClip;
    private var _xPos:Number;
    private var _yPos:Number;

    public function MovieClipFactory(_mc:MovieClip, xPos:Number = 0, yPos:Number = 0) {
        super();

        this._movieClip = _mc;

        this.addMC();
    }

    private function addMC():void {
        this._movieClip.x = this._xPos;
        this._movieClip.y = this._yPos;
        this.addChild(this._movieClip);
    }
}
}