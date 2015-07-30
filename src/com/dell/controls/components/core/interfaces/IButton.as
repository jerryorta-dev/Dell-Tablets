/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/3/13
 * Time: 9:25 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.controls.components.core.interfaces {
public interface IButton {
    function get transitionTime():Number;
    function get onStateClass():IButtonState;
    function get overStateClass():IButtonState;
    function get offStateClass():IButtonState;
    function setStateClass(state:IButtonState):void;
}
}
