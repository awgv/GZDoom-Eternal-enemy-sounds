version "4.8"

/*
  HD uses `vile/death` sound only in Freedoom, hence this workaround.
  https://codeberg.org/mc776/hideousdestructor/src/branch/main/zscript/mob_necromancer.zs#L386
*/
class NecromancerDeathHandler: EventHandler
{
    override void WorldThingDied(WorldEvent e)
    {
        if (!e.Thing || !(e.Thing is 'Necromancer')) {
            return;
        }

        // If playing Freedoom:
        if (Wads.CheckNumForName("FREEDOOM", 0) != -1) {
            return;
        }

        e.Thing.GiveInventory('NecromancerDeathVocalizationUpdater', 1);
    }
}

class NecromancerDeathVocalizationUpdater: Inventory
{
    default
    {
        Inventory.MaxAmount 1;
        +INVENTORY.PERSISTENTPOWER;
    }

    override void DoEffect()
    {
        super.DoEffect();
        let owner = Necromancer(Owner);

        if (owner is 'Necromancer')
        {
            owner.painsound = "vile/death";
        }
    }
}
