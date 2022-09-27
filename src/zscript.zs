version "4.8"

/*
 * HD uses `vile/death` sound only in Freedoom, hence this workaround.
 * https://codeberg.org/mc776/hideousdestructor/src/branch/main/zscript/mob_necromancer.zs#L386
 */

class NecromancerDeathVocalizationUpdater: Thinker
{
    Actor Necromancer;

    override void Tick()
    {
        super.Tick();

        Necromancer.painsound = "vile/death";
    }
}

class NecromancerDeathHandler: EventHandler 
{
    override void WorldThingSpawned(WorldEvent e) 
    {
        if (
            !e.Thing ||
            !(e.Thing is 'Necromancer') ||
            Wads.CheckNumForName("FREEDOOM", 0) != -1 // If playing Freedoom.
        ) {
            return;
        }

        NecromancerDeathVocalizationUpdater VocalizationUpdater = new("NecromancerDeathVocalizationUpdater");
        VocalizationUpdater.Necromancer = e.Thing;
    }
}
