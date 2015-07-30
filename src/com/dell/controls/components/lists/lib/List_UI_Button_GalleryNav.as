package com.dell.controls.components.lists.lib {
import com.dell.controls.components.core.abstract.AbstractButton;
import com.dell.controls.components.core.abstract.AbstractButtonFactory;
import com.dell.controls.components.core.abstract.AbstractCalloutParams;
import com.dell.controls.components.core.abstract.AbstractUI;
import com.dell.controls.components.core.interfaces.IUI;
import com.dell.controls.Button_C_Factory;
import com.dell.controls.components.lists.mvc.control.IListController;
import com.dell.controls.components.lists.mvc.control.ListController;
import com.dell.controls.components.lists.mvc.model.IListModel;
import com.dell.controls.components.lists.mvc.view.core.AbstractListCompositeView;
import com.dell.core.Global;
import com.dell.events.UIEvent;
import com.dell.controls.components.lists.mvc.model.ListModel;
import com.dell.controls.components.lists.mvc.view.ListCompositeView;

import flash.events.Event;

import project_tablets_1297.text.gallery.GalleryCalloutButtonParams;


public class List_UI_Button_GalleryNav extends AbstractUI implements IUI {
    private const INITIAL_ON_STATE_BUTTON_NUMBER:int = 0;



    private var buttons:Vector.<AbstractButton>;

    private var listModel:Object;
    private var listController:IListController;
    private var listCompositeView:AbstractListCompositeView;

    private var _rangeOfData:int;


    /**
     * This nav ui is built to hold 5 buttons or less.
     * @param vars
     * @param data
     */
    public function List_UI_Button_GalleryNav( vars = null, data:Object = null ):void {
        super(vars, data );
        this.name = "LIST_UI_BUTTONS_GALLERY_NAV";
    }

    override public function commitProperties(event:Event = null):void {
        //TODO get lesser of either copy or images
        this._rangeOfData = Global.data.copy.screen[ this._data.screenIndex ].slides.length;
    }

    override public function draw():void {
        listModel = new ListModel();
        this.listModel.addEventListener( UIEvent.CHANGE, this.changeHandler, false, 0, true);

        listController = new ListController(listModel as IListModel);
        listCompositeView = new ListCompositeView(listModel, listController);

        var btnFactory:AbstractButtonFactory = new Button_C_Factory();
        // var xPos:Vector.<int> = new <int>[0, 45, 93, 139, 185];

        var incr:Number = ( 185 / ( this._rangeOfData - 1 ));
        var xPos:Vector.<int> = new Vector.<int>();

        for ( var r:int = 0; r < this._rangeOfData; r++ ) {
            xPos.push( r * incr );
        }


//      buttons = new <AbstractButton>[_button1View, _button2View, _button3View, _button4View, _button5View];
		buttons = new <AbstractButton>[];



//        var len:int = Global.data.copy.screen[ this._data.screenIndex ].slides.length;
        for (var i:int = 0; i < this._rangeOfData; i++) {

            if ( i < Global.data.copy.screen[ this._data.screenIndex ].slides.length ) {
                var params:AbstractCalloutParams = new GalleryCalloutButtonParams();
                params.text = Global.data.copy.screen[ this._data.screenIndex ].slides[ i ].headline;
                //Global.data.copy.screen[ this._data.screenIndex ].slides

                buttons[i] = btnFactory.add(String(i), Button_C_Factory.GALLERY_TABLETS_WITH_CALLOUT, this, xPos[i], 0, params, this._data );

                listCompositeView.add(buttons[i]);

                buttons[i].buttonMode = true;
                buttons[i].useHandCursor = true;
                buttons[i].mouseChildren = false;

            }

        }
    }

    override public function initialize():void {

        this.activateComposite();


        //Must come after event listeners are added.
        listController.setInitialState(buttons[this.INITIAL_ON_STATE_BUTTON_NUMBER].name, AbstractButton.ON);

    }

    public function reset():void {

//        this.listController.selectItem( '0"');

        this.listController.manualClick( "0");
        buttons[0].on();

        var len:int = buttons.length;
        for (var i:int = 0; i < len; i++) {
            if (i != 0) {
                buttons[i].off();
            }
        }

//        buttons[0].on();
//
//        var buttenEventObject:Object = {};
//
//        buttenEventObject.name = "0";
//        buttenEventObject.state = AbstractButton.ON;
//
//        this.listModel.setOnState = buttenEventObject;
    }

    override public function activateComposite():Boolean {


        listModel.addEventListener(UIEvent.CLICK, listCompositeView.setOnState);
        listModel.addEventListener(UIEvent.ROLL_OVER, listCompositeView.setOverState);
        listModel.addEventListener(UIEvent.ROLL_OUT, listCompositeView.setOffState);

        super.activateComposite();
        return true;
    }

    override public function deactivateComposite():Boolean {


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


    private function changeHandler( event:UIEvent ):void {
        eventDispatcher( new UIEvent(UIEvent.GALLERY_ITEM_SELECT, event.data) );
    }

    public function selectGalleryItem( value:String ):void {
        listController.selectItem( value );
    }

    public function selectGalleryItemNoDispatch( value:String ):void {
        listController.selectItemNoDispatch( value );
    }


}
}