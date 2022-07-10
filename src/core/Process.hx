package core;

class Process {
    public var fixedUpdateRate = 30.;
    public var maxUpdateCallsPerFrame = 5;

    var updateAcc = 0.;
    var children = new Array<Process>();
    var parent:Null<Process>;
    var killed = false;

    public function new(?parent:Process) {
        this.parent = parent;
    }

    public function init() {
        if (killed) return;
        onInit();
        for (child in children) {
            child.init();
        }
    }

    public function onInit() {

    }

    public function update(dt:Float) {
        if (killed) return;
        updateAcc += dt;
        if (updateAcc > maxUpdateCallsPerFrame/fixedUpdateRate) {
            updateAcc = maxUpdateCallsPerFrame/fixedUpdateRate;
        }
        while (updateAcc >= 1/fixedUpdateRate) {
            onUpdate(1/fixedUpdateRate);
            updateAcc -= 1/fixedUpdateRate;
        }
        for (child in children) {
            child.update(dt);
        }
    }

    public function onUpdate(dt:Float) {

    }

    /**
    Constructs a new Process and adds it as a child of this one.

    If you prefer to construct the Process a different way, use addChild();
    **/
    public function spawnChild() {
        var child = new Process(this);
        children.push(child);
    }

    /**
        Adds an externally constructed Process to this Process's children list.
    **/
    public function addChild(child:Process) {
        children.push(child);
        child.parent = this;
    }

    public function kill() {
        if (killed) return;
        onKilled();
        killed = true;
        if (parent != null) {
            parent.children.remove(this);
        }
        killChildren();
    }

    public function killChild(child:Process) {
        child.kill();
    }

    public function killChildren() {
        for (child in children) {
            child.kill();
        }
    }

    function onKilled() {}
}