/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_minefields.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

minefields()
{
	minefields = getentarray("minefield", "targetname");
	if(minefields.size > 0)
	{
		level._effect["mine_explosion"] = loadfx("explosions/grenadeExp_dirt");
	}

	for(i = 0;i < minefields.size;i++)
	{
		minefields[i] thread minefield_think();
	}
}

minefield_think()
{
	for(;;)
	{
		self waittill("trigger", other);
		if(isplayer(other))
		{
			other thread minefield_kill(self);
		}
	}
}

minefield_kill(trigger)
{
	if(isdefined(self.minefield))
	{
		return;
	}

	self.minefield = 1;
	self playsound("minefield_click");
	wait 0.5;
	wait randomfloat(0.5);
	if(isdefined(self) && self istouching(trigger))
	{
		origin = self getorigin();
		range = 300;
		maxdamage = 2000;
		mindamage = 50;
		self playsound("explo_mine");
		playfx(level._effect["mine_explosion"], origin);
		radiusdamage(origin, range, maxdamage, mindamage);
	}

	self.minefield = undefined;
}