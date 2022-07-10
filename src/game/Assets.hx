package game;

class Assets {
    public var tiles(default, null) = new Map<AssetTileKind, h2d.Tile>();
    public var tileArrays(default, null) = new Map<AssetTileArrayKind, Array<h2d.Tile>>();
    public var fonts(default, null) = new Map<AssetFontKind, h2d.Font>();

    public function new() {
        fonts[DEFAULT12] = makeDefaultFont(12);
        fonts[DEFAULT16] = makeDefaultFont(16);
        fonts[DEFAULT24] = makeDefaultFont(24);
        fonts[DEFAULT48] = makeDefaultFont(48);

        tiles[Dad] = h2d.Tile.fromColor(0xFF0000FF, 64, 64, 1);
        tiles[Baby] = h2d.Tile.fromColor(0xFF00FF00, 32, 32, 1);
    }

    function makeTileArrayFromFixedSize(res:hxd.res.Image, x:Int, y:Int, w:Int, 
    h:Int, frames:Int, dx:Int, dy:Int):Array<h2d.Tile> 
    {
        var tileArray = new Array<h2d.Tile>();
        var imgTile = res.toTile();
        for (frameIdx in 0...frames) {
            var tile = imgTile.sub(x, y, w, h, -dx, -dy);
            tileArray.push(tile);
            x += w;
        }
        return tileArray;
    }

    function makeDefaultFont(size:Int):h2d.Font {
        var font = hxd.res.DefaultFont.get().clone();
        font.resizeTo(size);
        return font;
    }

    /**
        Parses a resource file consisting of JSON text. Returns a structure or array of structures according to the content of res. The JSON parsing is currently dynamic and will not flag a mismatch between the content and expected type T.
    **/
    static inline function parseJsonRes<T>(res:hxd.res.Resource):T {
        var result:T = haxe.Json.parse(res.entry.getText());
        return result;
    }

    /**
        Looks up a resource from a path string. If resource doesn't exist a runtime error will be raised.
    **/
    public static inline function getResFromString(path:String):hxd.res.Resource {
        return hxd.Res.loader.load(path).toPrefab();
    }

    public function getImageFromString(path:String):hxd.res.Image {
        return hxd.Res.loader.load(path).toImage();
    }
}

enum AssetTileKind {
    Dad;
    Baby;
}

enum AssetTileArrayKind {

}

enum AssetFontKind {
    DEFAULT12;
    DEFAULT16;
    DEFAULT24;
    DEFAULT48;
}