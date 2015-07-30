/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/31/13
 * Time: 5:00 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.templateMVCFactory.lib {
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.controls.components.templateMVCFactory.mvc.control.ITemplateController;
import com.dell.controls.components.templateMVCFactory.mvc.control.TemplateController;
import com.dell.controls.components.templateMVCFactory.mvc.model.ITemplateModel;
import com.dell.controls.components.templateMVCFactory.mvc.model.TemplateModel;
import com.dell.controls.components.templateMVCFactory.mvc.view.TemplateCompositeView;
import com.dell.controls.components.templateMVCFactory.mvc.view.core.abstract.AbstractTemplateComponentView;
import com.dell.events.UIEvent;
import com.dell.events.UIEventDispatcher;

import flash.display.Sprite;
import flash.events.Event;

public class MVC_Wrapper extends AbstractUI implements IUI {

    public function MVC_Wrapper() {
        super();
    }

    private var deleteThis:Sprite;
    private var templateModel:ITemplateModel;
    private var templateController:ITemplateController;
    private var templateCompositeView:AbstractTemplateComponentView;

    private var _dispatcher:UIEventDispatcher;

    override public function commitProperties(event:Event = null):void {

    }

    override public function draw():void {

        this._dispatcher = new UIEventDispatcher();

        //TODO DELETE THIS IN REAL APP
        this.setDemoSprite();

        //MVC Stuff
        this.templateModel = new TemplateModel( );
        this.templateModel.addEventListener( UIEvent.CHANGE, changeHandler, false, 0, true );

        this.templateController = new TemplateController( this.templateModel );
        this.templateCompositeView = new TemplateCompositeView( this.templateModel as ITemplateModel, this.templateController );

    }

    override public function initialize():void {
        this.templateModel.addEventListener( UIEvent.UPDATE_VIEW, this.templateCompositeView.update, false, 0, true );
    }

    /**
     * <p>Add event listener to this class when the entire mvc updates it's state.</p>
     *
     * <p>For example:<br>
     *    var mvcObject:MVC_Wrapper = new MVC_Wrapper().
     *    mvcObject.addEventListener( UIEvent.CHANGE, doSomething );</p>
     *
     * @param data
     */
    private function changeHandler( event:UIEvent ):void {
        this._dispatcher.dispatchUIEvent( UIEvent.CHANGE, event.data );
    }

    //TODO DELETE THIS IN REAL APP
    private function setDemoSprite():void
    {
        deleteThis = new Sprite();
        deleteThis.graphics.beginFill( 0x990000, 1);
        deleteThis.graphics.drawRect(0, 0, 100, 100);
        deleteThis.graphics.endFill();
        this.addChild( deleteThis );
    }
}
}
