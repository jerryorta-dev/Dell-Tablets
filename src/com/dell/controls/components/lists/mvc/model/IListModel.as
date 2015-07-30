/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 8/29/13
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.lists.mvc.model {
public interface IListModel {
    function set setOnState( _state:Object ):void;
    function set setOverState( _state:Object ):void;
    function set setOffState(_state:Object ):void;
    function set setOnStateNoEventDispatch( _state:Object ):void;

}
}
