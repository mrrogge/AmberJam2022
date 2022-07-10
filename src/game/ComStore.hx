package game;

/**
    TODO: eventually it will make sense to generate these through build macros. Need to be able to specify the com map property names and corresponding types. Also need to specify interfaces of ComStore "subsets" to allow code to be more modular.
**/
class ComStore {
    var _nextIntId = 1;

    public var anims(default, null) = new heat.ecs.ComMap<h2d.Anim>();
    public var bitmaps(default, null) = new heat.ecs.ComMap<h2d.Bitmap>();
    public var bumpObjects(default, null) = new heat.ecs.ComMap<hxbump.BumpObject>();
    public var cleanupFlags(default, null) = new heat.ecs.ComMap<tink.core.Noise>();
    public var forces(default, null) = new heat.ecs.ComMap<game.Force>();
    public var heapsTexts(default, null) = new heat.ecs.ComMap<h2d.Text>();
    public var mass(default, null) = new heat.ecs.ComMap<Float>();
    public var objects(default, null) = new heat.ecs.ComMap<h2d.Object>();
    public var tileGroups(default, null) = new heat.ecs.ComMap<h2d.TileGroup>();
    public var timers(default, null) = new heat.ecs.ComMap<game.Timer>();
    public var tweeners(default, null) = new heat.ecs.ComMap<game.Tweener>();
    public var userInputConfigs(default, null) = new heat.ecs.ComMap<UserInputConfig>();
    public var velocities(default, null) = new heat.ecs.ComMap<game.Velocity>();

    public function new() {}

    public function getIntId():heat.ecs.EntityId {
        var id:heat.ecs.EntityId = _nextIntId++;
        return id;
    }
    
    public function disposeAll() {
        
    }
    
    public function disposeId(id:heat.ecs.EntityId) {
        preDisposeHook(id);
        anims.remove(id);
        bitmaps.remove(id);
        bumpObjects.remove(id);
        cleanupFlags.remove(id);
        forces.remove(id);
        heapsTexts.remove(id);
        mass.remove(id);
        objects.remove(id);
        tileGroups.remove(id);
        timers.remove(id);
        tweeners.remove(id);
        userInputConfigs.remove(id);
        velocities.remove(id);
    }

    /**
        For custom dispose logic
    **/
    function preDisposeHook(id:heat.ecs.EntityId) {
        // Remove heaps objects from scene tree
        anims[id].remove();
        bitmaps[id].remove();
        heapsTexts[id].remove();
        objects[id].remove();
        tileGroups[id].remove();
    }
}