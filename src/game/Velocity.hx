package game;

class Velocity {
    public var x:Float;
    public var y:Float;
    public var prevX:Float;
    public var prevY:Float;
    public var xMax:Float;
    public var yMax:Float;

    public function new(x=0., y=0., xMax=1000, yMax=1000) {
        this.x = x;
        this.y = y;
        this.prevX = x;
        this.prevY = y;
        this.xMax = xMax;
        this.yMax = yMax;
    }
}