/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_destructables.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	ents = getentarray("destructable", "targetname");
	if(getdvar("scr_destructables") == "0")
	{
		for(i = 0;i < ents.size;i++)
		{
			ents[i] delete();
		}

		return;
	}

	for(i = 0;i < ents.size;i++)
	{
		ents[i] thread destructable_think();
	}
}

destructable_think()
{
	accumulate = 40;
	threshold = 0;
	if(isdefined(self.script_accumulate))
	{
		accumulate = self.script_accumulate;
	}

	if(isdefined(self.script_threshold))
	{
		threshold = self.script_threshold;
	}

	if(isdefined(self.script_destructable_area))
	{
		areas = strtok(self.script_destructable_area, " ");
		for(i = 0;i < areas.size;i++)
		{
			blockarea(areas[i]);
		}
	}

	if(isdefined(self.script_fxid))
	{
		self.fx = loadfx(self.script_fxid);
	}

	dmg = 0;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage", amount, other);
		if(amount >= threshold)
		{
			dmg = dmg + amount;
			if(dmg >= accumulate)
			{
				thread destructable_destruct();
				return;
			}
		}
	}
}

destructable_destruct()
{
	ent = self;
	if(isdefined(self.script_destructable_area))
	{
		areas = strtok(self.script_destructable_area, " ");
		for(i = 0;i < areas.size;i++)
		{
			unblockarea(areas[i]);
		}
	}

	if(isdefined(ent.fx))
	{
		playfx(ent.fx, ent.origin + (0,0,6));
	}

	ent delete();
}

blockarea(area)
{
	spawns = getentarray("mp_tdm_spawn", "classname");
	blockentsinarea(spawns, area);
	spawns = getentarray("mp_dm_spawn", "classname");
	blockentsinarea(spawns, area);
}

blockentsinarea(ents, area)
{
	for(i = 0;i < ents.size;i++)
	{
		if(!isdefined(ents[i].script_destructable_area) || ents[i].script_destructable_area != area)
		{
			continue;
		}

		ents[i].blockedoff = 1;
	}
}

unblockarea(area)
{
	spawns = getentarray("mp_tdm_spawn", "classname");
	unblockentsinarea(spawns, area);
	spawns = getentarray("mp_dm_spawn", "classname");
	unblockentsinarea(spawns, area);
}

unblockentsinarea(ents, area)
{
	for(i = 0;i < ents.size;i++)
	{
		if(!isdefined(ents[i].script_destructable_area) || ents[i].script_destructable_area != area)
		{
			continue;
		}

		ents[i].blockedoff = 0;
	}
}