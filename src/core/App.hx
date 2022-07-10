package core;

class App extends hxd.App {
    public var lastFps(default, null) = 0.;
    public var keyEventSignal(default, null):heat.event.ISignal<input.EKey>;
    public var mouseBtnEventSignal(default, null):heat.event.ISignal<input.EMouseBtn>;

    var mainProcess:Process;

    var keyEventSignalEmitter = new heat.event.SignalEmitter<input.EKey>();
    var mouseBtnEventSignalEmitter = new heat.event.SignalEmitter<input.EMouseBtn>();

    override function init() {
        super.init();
        keyEventSignal = keyEventSignalEmitter.signal;
        mouseBtnEventSignal = mouseBtnEventSignalEmitter.signal;
        mainProcess = new Process();
        onInit();
        hxd.Window.getInstance().addEventTarget(onEvent);
    }

    public function onInit() {

    }

    override function update(dt:Float) {
        super.update(dt);
        mainProcess.update(dt);
        lastFps = 1/dt;
    }

    public function exit() {
        #if sys
        Sys.exit(0);
        #end
    }

    final KEYMAP:Map<Int, input.KeyCode> = [
        hxd.Key.UP => UP,
        hxd.Key.DOWN => DOWN,
        hxd.Key.LEFT => LEFT,
        hxd.Key.RIGHT => RIGHT,
        hxd.Key.A => A,
        hxd.Key.B => B,
        hxd.Key.C => C,
        hxd.Key.D => D,
        hxd.Key.E => E,
        hxd.Key.F => F,
        hxd.Key.G => G,
        hxd.Key.H => H,
        hxd.Key.I => I,
        hxd.Key.J => J,
        hxd.Key.K => K,
        hxd.Key.L => L,
        hxd.Key.M => M,
        hxd.Key.N => N,
        hxd.Key.O => O,
        hxd.Key.P => P,
        hxd.Key.Q => Q,
        hxd.Key.R => R,
        hxd.Key.S => S,
        hxd.Key.T => T,
        hxd.Key.U => U,
        hxd.Key.V => V,
        hxd.Key.W => W,
        hxd.Key.X => X,
        hxd.Key.Y => Y,
        hxd.Key.Z => Z,
        hxd.Key.ESCAPE => ESC,
        hxd.Key.F1 => F1,
        hxd.Key.F2 => F2,
        hxd.Key.F3 => F3,
        hxd.Key.F4 => F4,
        hxd.Key.F5 => F5,
        hxd.Key.F6 => F6,
        hxd.Key.F7 => F7,
        hxd.Key.F8 => F8,
        hxd.Key.F9 => F9,
        hxd.Key.F10 => F10,
        hxd.Key.F11 => F11,
        hxd.Key.F12 => F12,
        hxd.Key.SPACE => SPACE,
        hxd.Key.ENTER => ENTER,
        hxd.Key.NUMPAD_ENTER => NUMPAD_ENTER
    ];

    function onEvent(et:hxd.Event):Void {
        switch et.kind {
            case EKeyDown: {
                // prevents holding down keys and triggering multiple times
                if (!hxd.Key.ALLOW_KEY_REPEAT && hxd.Key.isDown(et.keyCode)) return;
                if (KEYMAP.exists(et.keyCode)) {
                    keyEventSignalEmitter.emit({code:KEYMAP[et.keyCode], kind: PRESSED});
                }
                else {
                    keyEventSignalEmitter.emit({code:OTHER(et.keyCode), kind: PRESSED});
                }
            }
            case EKeyUp: {
                // prevents multiple key up events for the same key - shouldn't happen, but just in case
                if (!hxd.Key.isDown(et.keyCode)) return;
                if (KEYMAP.exists(et.keyCode)) {
                    keyEventSignalEmitter.emit({code:KEYMAP[et.keyCode], kind: RELEASED});
                }
                else {
                    keyEventSignalEmitter.emit({code:OTHER(et.keyCode), kind: RELEASED});
                }
            }
            default: {}
        }
    }

    override function loadAssets(onLoaded:() -> Void) {
        #if js
        hxd.Res.initEmbed();
        #else
        hxd.res.Resource.LIVE_UPDATE = true;
        hxd.Res.initLocal();
        #end
        super.loadAssets(onLoaded);
    }
}