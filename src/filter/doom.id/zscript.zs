version "4.8"

/*
 * Because HD uses `vile/death` sound only in Freedoom.
 * https://codeberg.org/mc776/hideousdestructor/src/branch/main/zscript/mob_necromancer.zs#L386
 */

class NecromancerDeathHandler: EventHandler 
{
    String NecromancerClassName;
    class<Actor> NecromancerActor;

    override void NewGame()
    {
        NecromancerClassName = "Necromancer";
        NecromancerActor = NecromancerClassName;
    }

    override void WorldThingDied(WorldEvent e) 
    {
        if (!e.Thing || !(e.Thing is (NecromancerActor ? "Necromancer" : "")))
        {
            return;
        }

        e.Thing.PainSound = "vile/death";
    }
}
