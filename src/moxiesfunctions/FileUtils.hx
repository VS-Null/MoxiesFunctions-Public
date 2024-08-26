package moxiesfunctions;

#if sys
import sys.io.File;
import sys.FileSystem;
#else
import openfl.Assets;
#end

class FileUtils
{
	inline public static function coolTextFile(path:String):Array<String>
	{
		#if sys
		if (FileSystem.exists(path))
			return [for (i in File.getContent(path).trim().split('\n')) i.trim()];
		#else
		if (Assets.exists(path))
			return [for (i in Assets.getText(path).trim().split('\n')) i.trim()];
		#end

		return [];
	}

    // allows to read directories on non sys platforms
    inline public static function readDirectory(path:String):Array<String> {
        #if sys
        return FileSystem.readDirectory(path);
        #else
        // original by @MAJigsaw77
        var files:Array<String> = [];

        for (possibleFile in Assets.list().filter((f) -> f.contains(path))) {
            var file:String = possibleFile.replace('${path}/', "");
            if (file.contains("/"))
               file = file.replace(file.substring(file.indexOf("/"), file.length), "");

            if (!files.contains(file))
               files.push(file);
        }
  
        files.sort((a, b) -> {
            a = a.toUpperCase();
            b = b.toUpperCase();
            return (a < b) ? -1 : (a > b) ? 1 : 0;
        });

        return files;
        #end
    }
}