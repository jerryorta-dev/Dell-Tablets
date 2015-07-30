/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/30/13
 * Time: 8:18 AM
 * To change this template use File | Settings | File Templates.
 */
package project_tablets_1297 {
import com.dell.core.Global;

/**
 * Create Omniture tracking string based on the 1297 Tablets Project.
 */
public class Track_Tablets1297 {


    public static function getProduct(_screenIndex:int):String {
        var str:String = "";

        if (_screenIndex == 0) {
            str = "Venue_11_Pro";
        }

        if (_screenIndex == 1) {
            str = "Venue_8_Pro";
        }

        if (_screenIndex == 2) {
            str = "Venue_8";
        }

        if (_screenIndex == 3) {
            str = "Venue_7";
        }

        return str;
    }

}
}
