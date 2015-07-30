package com.dell.controls.components.lists.lib {
import com.dell.controls.Button_C_Factory;
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.controls.components.lists.mvc.control.IListController;
import com.dell.controls.components.lists.mvc.control.ListController;
import com.dell.controls.components.lists.mvc.model.IListModel;
import com.dell.controls.components.lists.mvc.model.ListModel;
import com.dell.controls.components.lists.mvc.view.ListCompositeView;
import com.dell.controls.components.lists.mvc.view.core.AbstractListCompositeView;
import com.dell.events.UIEvent;

import flash.events.Event;


/**
 * Options for 360 Rotation or Gallery
 */
public class List_UI_Button_Rotate360Gallery extends AbstractUI  {
    private const INITIAL_ON_STATE_BUTTON_NUMBER:int = 0;

    private var _button1View:AbstractButton;
    private var _button2View:AbstractButton;

    private var buttons:Vector.<AbstractButton>;

    private var listModel:Object;
    private var listController:IListController;
    private var listCompositeView:AbstractListCompositeView;
	
	public function List_UI_Button_Rotate360Gallery( data:Object = null ):void {
		super( data );
        this.name = "LIST_UI_BUTTONS_360_GALLERY";
	}

    override public function commitProperties(event:Event = null):void {

    }

    override public function draw():void {
        listModel = new ListModel();
        listController = new ListController(listModel as IListModel);
        listCompositeView = new ListCompositeView(listModel, listController);

        var btnFactory:AbstractButtonFactory = new Button_C_Factory();
        var xPos:Vector.<int> = new <int>[0, 36];

        _button1View = btnFactory.add( "360", Button_C_Factory.ROTATE_360_DEFAULT, this, xPos[0], 0 );
		_button2View = btnFactory.add( "Gallery", Button_C_Factory.CAMERA_DEFAULT, this, xPos[1], 0 );

        buttons = new <AbstractButton>[_button1View, _button2View];

        var len:int = xPos.length;
        for (var i:int = 0; i < len; i++) {

            listCompositeView.add(buttons[i]);

            buttons[i].buttonMode = true;
            buttons[i].useHandCursor = true;
            buttons[i].mouseChildren = false;

        }
    }

    override public function initialize():void {

       this.activateComposite();

        //Must come after event listeners are added.
        listController.setInitialState(buttons[this.INITIAL_ON_STATE_BUTTON_NUMBER].name, AbstractButton.ON);

    }

    public function galleryON():void {
//        trace( "gallery On" )
        listController.manualClick(buttons[1].name);
    }



    public function r360ON():void {
//        trace( "360 on")
        listController.manualClick(buttons[0].name);
    }

    private function changeHandler( event:UIEvent ):void {
        this.eventDispatcher( new UIEvent(UIEvent.NAV_ITEM_SELECT, event.data));
    }

    override public function activateComposite():Boolean {
//        trace( " zoom activated " );
        listModel.addEventListener( UIEvent.CHANGE, this.changeHandler, false, 0, true);
        listModel.addEventListener(UIEvent.CLICK, listCompositeView.setOnState);
        listModel.addEventListener(UIEvent.ROLL_OVER, listCompositeView.setOverState);
        listModel.addEventListener(UIEvent.ROLL_OUT, listCompositeView.setOffState);
		super.activateComposite();
		return true;
    }

    override public function deactivateComposite():Boolean {
        listModel.removeEventListener( UIEvent.CHANGE, this.changeHandler);
        listModel.removeEventListener(UIEvent.CLICK, listCompositeView.setOnState);
        listModel.removeEventListener(UIEvent.ROLL_OVER, listCompositeView.setOverState);
        listModel.removeEventListener(UIEvent.ROLL_OUT, listCompositeView.setOffState);
		super.deactivateComposite();
		return true;
    }

    override public function disposeComposite():Boolean {


        super.disposeComposite();
        return true;
    }




}
}