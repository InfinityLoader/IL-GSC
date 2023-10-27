/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_fastheal.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 103 ms
 * Timestamp: 10/27/2023 1:48:58 AM
*******************************************************************/

//Function Number: 1
watchfasthealusage()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	if(!isdefined(level.fasthealsettings))
	{
		fasthealinit();
	}

	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "fast_heal_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			thread tryusefastheal();
		}
	}
}

//Function Number: 2
fasthealinit()
{
	self.fasthealsettings = spawnstruct();
}

//Function Number: 3
tryusefastheal()
{
	if(!isdefined(self.fasthealsettings))
	{
		fasthealinit();
	}

	resetfastheal();
	thread startfastheal();
	thread monitorplayerdeath();
	return 1;
}

//Function Number: 4
startfastheal()
{
	self endon("ClearFastHeal");
	self endon("death");
	self playlocalsound("earn_superbonus");
	self.fasthealsettings.overlay = newclienthudelem(self);
	self.fasthealsettings.overlay.x = 0;
	self.fasthealsettings.overlay.y = 0;
	self.fasthealsettings.overlay.horzalign = "fullscreen";
	self.fasthealsettings.overlay.vertalign = "fullscreen";
	self.fasthealsettings.overlay setshader("exo_hud_cloak_overlay",640,480);
	self.fasthealsettings.overlay.archive = 1;
	self.fasthealsettings.overlay.alpha = 1;
	self.isfastheal = 1;
	self.ignoreregendelay = 1;
	self.healthregenlevel = 0.99;
	self notify("damage");
	wait(10);
	self.healthregenlevel = undefined;
	self.isfastheal = 0;
	if(isdefined(self.fasthealsettings.overlay))
	{
		self.fasthealsettings.overlay destroy();
	}

	self notify("EndFastHeal");
}

//Function Number: 5
resetfastheal()
{
	if(isdefined(self.isfastheal) && self.isfastheal == 1)
	{
		if(isdefined(self.fasthealsettings.overlay))
		{
			self.fasthealsettings.overlay destroy();
		}

		self.healthregenlevel = undefined;
		self notify("ClearFastHeal");
	}
}

//Function Number: 6
monitorplayerdeath()
{
	self endon("EndFastHeal");
	self waittill("death");
	self.healthregenlevel = undefined;
	self.isfastheal = 0;
	if(isdefined(self.fasthealsettings.overlay))
	{
		self.fasthealsettings.overlay destroy();
	}
}

//Function Number: 7
printhealthtoscreen()
{
	self endon("EndFastHeal");
	self endon("death");
	for(;;)
	{
		iprintlnbold(self.health);
		wait(1);
	}
}