#if !macro
#if (openfl_html5_dom && !flambe)

import com.djoker.glteste.Main;
import haxe.Resource;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLLoaderDataFormat;
//import flash.Assets;
import flash.Lib;

class ApplicationMain {

	private static var completed:Int;
	private static var preloader:NMEPreloader;
	private static var total:Int;

	public static var loaders:Map <String, Loader>;
	public static var urlLoaders:Map <String, URLLoader>;

	public static function main() {
		
		completed = 0;
		loaders = new Map <String, Loader>();
		urlLoaders = new Map <String, URLLoader>();
		total = 0;
		
		//flash.Lib.setPackage("djoker", "glframework", "com.djoker.glframework", "1.0.0");
		flash.Lib.current.loaderInfo = flash.display.LoaderInfo.create (null);
		
		try {
			
			if (Reflect.hasField (js.Browser.window, "winParameters")) {
				
				Reflect.setField (flash.Lib.current.loaderInfo, "parameters", Reflect.field (js.Browser.window, "winParameters")());
				
			}
			
			flash.Lib.current.stage.loaderInfo = flash.Lib.current.loaderInfo;
			
		} catch (e:Dynamic) {}

		

		
		preloader = new NMEPreloader();
		
		Lib.current.addChild(preloader);
		preloader.onInit();

		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/Background.jpg", loader);
		total ++;
		
		
		
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = BINARY;
		urlLoaders.set("assets/desert.tmx", urlLoader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/hxlogo.png", loader);
		total ++;
		
		
		
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = BINARY;
		urlLoaders.set("assets/map.tmx", urlLoader);
		total ++;
		
		
		
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = BINARY;
		urlLoaders.set("assets/mapxml.tmx", urlLoader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/player.png", loader);
		total ++;
		
		
		
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = BINARY;
		urlLoaders.set("assets/scrol.tmx", urlLoader);
		total ++;
		
		
		
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = BINARY;
		urlLoaders.set("assets/sewers.tmx", urlLoader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/sewer_tileset.png", loader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/sprites.png", loader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/texture.jpg", loader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/texture.png", loader);
		total ++;
		
		
		
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = BINARY;
		urlLoaders.set("assets/TileMap.tmx", urlLoader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/tiles.png", loader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/tmw_desert_spacing.png", loader);
		total ++;
		
		
		
		
		var loader:Loader = new Loader();
		loaders.set("assets/zazaka.png", loader);
		total ++;
		
		
		
		var resourcePrefix = "__ASSET__:bitmap_";
		for (resourceName in Resource.listNames()) {
			if (StringTools.startsWith (resourceName, resourcePrefix)) {
				var type = Type.resolveClass(StringTools.replace (resourceName.substring(resourcePrefix.length), "_", "."));
				if (type != null) {
					total++;
					var instance = Type.createInstance (type, [ 0, 0, true, 0x00FFFFFF, bitmapClass_onComplete ]);
				}
			}
		}
		
		
		
		if (total == 0) {
			begin();
		} else {
			for (path in loaders.keys()) {
				var loader:Loader = loaders.get(path);
				loader.contentLoaderInfo.addEventListener("complete",
          loader_onComplete);
				loader.load (new URLRequest (path));
			}

			for (path in urlLoaders.keys()) {
				var urlLoader:URLLoader = urlLoaders.get(path);
				urlLoader.addEventListener("complete", loader_onComplete);
				urlLoader.load(new URLRequest (path));
			}
		}
	}

	private static function begin():Void {
		preloader.addEventListener(Event.COMPLETE, preloader_onComplete);
		preloader.onLoaded ();
	}
	
	private static function bitmapClass_onComplete(instance:BitmapData):Void {
		completed++;
		var classType = Type.getClass (instance);
		Reflect.setField (classType, "preload", instance);
		if (completed == total) {
			begin ();
		}
	}

	private static function loader_onComplete(event:Event):Void {
		completed ++;
		preloader.onUpdate (completed, total);
		if (completed == total) {
			begin ();
		}
	}

	private static function preloader_onComplete(event:Event):Void {
		preloader.removeEventListener(Event.COMPLETE, preloader_onComplete);
		Lib.current.removeChild(preloader);
		preloader = null;
		if (Reflect.field(com.djoker.glteste.Main, "main") == null)
		{
			var mainDisplayObj = Type.createInstance(DocumentClass, []);
			if (Std.is(mainDisplayObj, flash.display.DisplayObject))
				flash.Lib.current.addChild(cast mainDisplayObj);
		}
		else
		{
			Reflect.callMethod(com.djoker.glteste.Main, Reflect.field (com.djoker.glteste.Main, "main"), []);
		}
	}
}

@:build(DocumentClass.build())
class DocumentClass extends com.djoker.glteste.Main {}

#else

import com.djoker.glteste.Main;

class ApplicationMain {

	public static function main() {
		if (Reflect.field(com.djoker.glteste.Main, "main") == null) {
			Type.createInstance(com.djoker.glteste.Main, []);
		} else {
			Reflect.callMethod(com.djoker.glteste.Main, Reflect.field(com.djoker.glteste.Main, "main"), []);
		}
	}
}

#end
#else

import haxe.macro.Context;
import haxe.macro.Expr;

class DocumentClass {
	
	macro public static function build ():Array<Field> {
		var classType = Context.getLocalClass().get();
		var searchTypes = classType;
		while (searchTypes.superClass != null) {
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				var fields = Context.getBuildFields();
				var method = macro {
					return flash.Lib.current.stage;
				}
				fields.push ({ name: "get_stage", access: [ APrivate, AOverride ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos() });
				return fields;
			}
			searchTypes = searchTypes.superClass.t.get();
		}
		return null;
	}
	
}
#end
