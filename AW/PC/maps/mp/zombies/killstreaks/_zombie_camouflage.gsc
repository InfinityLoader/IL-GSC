/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\killstreaks\_zombie_camouflage.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 73 ms
 * Timestamp: 4/22/2024 2:12:59 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.camo_duration = 20;
	level.killstreakfuncs["zm_camouflage"] = ::tryusezombiecamouflage;
}

//Function Number: 2
tryusezombiecamouflage(param_00,param_01)
{
	if(maps\mp\zombies\_util::arekillstreaksdisabled())
	{
		return 0;
	}

	thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("ss_shield");
	thread playercamouflagemode();
	return 1;
}

//Function Number: 3
playercamouflagemode(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.camo_duration;
	}

	var_01 = int(gettime() + param_00 * 1000);
	if(isdefined(self.crategodmode) && self.crategodmode)
	{
		var_02 = self getclientomnvar("ui_zm_camo");
		if(var_02 >= var_01)
		{
			return;
		}
	}

	self notify("playerCamouflageMode");
	if(!isdefined(self.crategodmode))
	{
		self.crategodmode = 0;
	}

	self playlocalsound("zmb_ss_camo_use");
	self.crategodmode++;
	maps\mp\zombies\_util::setzombiesignoreme(1);
	self setclientomnvar("ui_zm_camo",var_01);
	playercamouflagemodewait(param_00);
	if(isdefined(self))
	{
		maps\mp\zombies\_util::setzombiesignoreme(0);
		self.crategodmode--;
	}
}

//Function Number: 4
playercamouflagemodewait(param_00)
{
	self endon("playerCamouflageMode");
	wait(param_00);
}