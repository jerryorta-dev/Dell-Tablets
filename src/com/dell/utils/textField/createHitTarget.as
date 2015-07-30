/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/27/13
 * Time: 3:53 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.utils.textField {
import flash.display.Sprite;
import flash.text.TextFormat;

/**
 * Usage:
 *
 * this.hitTarget = createHitTarget( this.ctaTF.text, this.ctaTF.getTextFormat(), new <Number>[-5, -5, 20, 15] )
 *
 * this.addChild( hitTarget );
 * hitTarget.x = this.ctaTF.x;
 * hitTarget.y = this.ctaTF.y;
 *
 * @param str = text in textField
 * @param format = use getTextFormat() function from TextField
 * @param bounds = adjust left, top, right, bottom coordinates. For example, [-5, -5, 20, 15]
 * means the hitTarget will draw a transparent rectangle where x = -5, y = -6, width = textfield width + 20 more px,
 * height is textField height + 15 more pixels.
 * @return
 */
public function createHitTarget( str:String, format:TextFormat, bounds:Vector.<Number> ):Sprite {

        var hitTarget:Sprite = new Sprite( );
        hitTarget.graphics.beginFill(0xFFFFFF, 0);
        hitTarget.graphics.drawRect( bounds[0], bounds[1], measureString( str, format).width + bounds[2], measureString( str, format).height + bounds[3]);
        hitTarget.graphics.endFill();
        hitTarget.buttonMode = true;
        hitTarget.useHandCursor = true;
        return hitTarget;
    }

}
