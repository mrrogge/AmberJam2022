package game;

/**
    The custom app for this game.
**/
class App extends core.App {
    // Constants
    public static inline final LEVEL_WIDTH = 16*96;
    public static inline final LEVEL_HEIGHT = 16*32;
    public static inline final VIEW_WIDTH = 960;
    public static inline final VIEW_HEIGHT = 450;

    // public fields
    public var assets:Assets;

    // private fields

    override function onInit() {
        assets = new Assets();

        hxd.Window.getInstance().resize(VIEW_WIDTH, VIEW_HEIGHT);
        // hxd.Window.getInstance().displayMode = Fullscreen;

        this.mainProcess.addChild(new game.process.GameProcess(this.mainProcess));

    }
}