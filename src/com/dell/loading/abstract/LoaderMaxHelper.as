/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 9/12/13
 * Time: 8:10 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dell.loading.abstract {
import com.dell.services.PathManager;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.LoaderStatus;
import com.greensock.loading.core.DisplayObjectLoader;
import com.greensock.loading.core.LoaderItem;

public class LoaderMaxHelper {


    private var loaders:Vector.<Object>;

    public static const SWFLoader:String = "SWFLoader";
    public static const ImageLoader:String = "ImageLoader";
    public static const MP3Loader:String = "MP3Loader";
    public static const VideoLoader:String = "VideoLoader";
    public static const BinaryDataLoader:String = "BinaryDataLoader";
    public static const CSSLoader:String = "CSSLoader";
    public static const DataLoader:String = "DataLoader";
    public static const XMLLoader:String = "XMLLoader";

    /**
     * The goal for this class is to have the queue name and it's child loaders as a variable. Then
     * this queue may be a queue of queues. Then, have the ability to prioritize at runtime which
     * queue is loading.
     *
     * Reference: http://forums.greensock.com/topic/5191-managing-load-order-dynamically-with-multiple-priorities/
     */
    public function LoaderMaxHelper() {

    }

    public static function prependURLsRecursively(_name:String):void {
        var queue:LoaderMax = LoaderMax.getLoader(_name);
        var children:Array = queue.getChildren();
        var len:int = queue.numChildren;

        for (var i:int = 0; i < len; i++) {
            var loaderType:String = children[i].toString().split(" ")[0];
            if (loaderType == "LoaderMax") {
                LoaderMaxHelper.prependURLsRecursively(children[i].name);
            } else {
                children[i].url = LoaderMaxHelper.getPath(LoaderMaxHelper.getLoaderType(children[i])) + children[i].url;
            }

        }

    }


    public static function getLoaderType(loader:LoaderItem):String {
        return loader.toString().split(" ")[0];
    }


    public static const CONTENT_BITMAP:String = "[object Bitmap]";
    public static const CONTENT_MOVIECLIP:String = "[object MovieClip]";


    public static function loaderHasContent(loader:DisplayObjectLoader):Boolean {

        if (loader.rawContent != null) {
            return true;
        }

        return false;
    }


    private static function getPath(_loaderType:String):String {

        if (_loaderType == "SWFLoader") {
            return PathManager.swfPath;
        }

        if (_loaderType == "ImageLoader") {
            return PathManager.imagePath;
        }

        if (_loaderType == "MP3Loader") {
            return PathManager.mp3Path;
        }

        if (_loaderType == "VideoLoader") {
            return PathManager.videoPath;
        }

        if (_loaderType == "BinaryDataLoader") {
            return PathManager.binaryDataPath;
        }

        if (_loaderType == "CSSLoader") {
            return PathManager.cssPath;
        }

        if (_loaderType == "DataLoader") {
            return PathManager.dataPath;
        }

        if (_loaderType == "XMLLoader") {
            return PathManager.xmlPath;
        }


        return "";
    }


    /*
     You don't typically use this method directly.
     Instead, the queue() method uses it to cancel
     the loading of children after a particular index
     which basically allows us to prioritize on the fly.
     For example, if child 5 is loading but you just
     inserted one at index 2, that new one should be
     prioritized, thus temporarily canceling the loader
     at index 5 (and all others after 2).
     */
    private function cancelChildrenAfterIndex(queue:LoaderMax, index:uint):void {
        var children:Array = queue.getChildren();
        var i:int = children.length;
        while (--i > index) {
            if (children[i].status == LoaderStatus.LOADING) {
                children[i].cancel();
            }
        }
    }


}
}
