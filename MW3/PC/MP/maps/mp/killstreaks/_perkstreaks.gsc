/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_perkstreaks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 402 ms
 * Timestamp: 10/27/2023 2:14:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["specialty_longersprint_ks"] = ::tryuseextremeconditioning;
	level.killstreakfuncs["specialty_fastreload_ks"] = ::tryusesleightofhand;
	level.killstreakfuncs["specialty_scavenger_ks"] = ::tryusescavenger;
	level.killstreakfuncs["specialty_blindeye_ks"] = ::tryuseblindeye;
	level.killstreakfuncs["specialty_paint_ks"] = ::tryusepaint;
	level.killstreakfuncs["specialty_hardline_ks"] = ::tryusehardline;
	level.killstreakfuncs["specialty_coldblooded_ks"] = ::tryusecoldblooded;
	level.killstreakfuncs["specialty_quickdraw_ks"] = ::tryusequickdraw;
	level.killstreakfuncs["specialty_assists_ks"] = ::tryuseassists;
	level.killstreakfuncs["_specialty_blastshield_ks"] = ::tryuseblastshield;
	level.killstreakfuncs["specialty_detectexplosive_ks"] = ::tryusesitrep;
	level.killstreakfuncs["specialty_autospot_ks"] = ::tryuseironlungs;
	level.killstreakfuncs["specialty_bulletaccuracy_ks"] = ::tryusesteadyaim;
	level.killstreakfuncs["specialty_quieter_ks"] = ::tryusedeadsilence;
	level.killstreakfuncs["specialty_stalker_ks"] = ::tryusestalker;
	level.killstreakfuncs["all_perks_bonus"] = ::tryuseallperks;
}

//Function Number: 2
tryuseallperks()
{
}

//Function Number: 3
tryuseblindeye(param_00)
{
	doperkfunctions("specialty_blindeye");
}

//Function Number: 4
tryusepaint(param_00)
{
	doperkfunctions("specialty_paint");
}

//Function Number: 5
tryuseassists(param_00)
{
	doperkfunctions("specialty_assists");
}

//Function Number: 6
tryusesteadyaim(param_00)
{
	doperkfunctions("specialty_bulletaccuracy");
}

//Function Number: 7
tryusestalker(param_00)
{
	doperkfunctions("specialty_stalker");
}

//Function Number: 8
tryuseextremeconditioning(param_00)
{
	doperkfunctions("specialty_longersprint");
}

//Function Number: 9
tryusesleightofhand(param_00)
{
	doperkfunctions("specialty_fastreload");
}

//Function Number: 10
tryusescavenger(param_00)
{
	doperkfunctions("specialty_scavenger");
}

//Function Number: 11
tryusehardline(param_00)
{
	doperkfunctions("specialty_hardline");
	maps\mp\killstreaks\_killstreaks::setstreakcounttonext();
}

//Function Number: 12
tryusecoldblooded(param_00)
{
	doperkfunctions("specialty_coldblooded");
}

//Function Number: 13
tryusequickdraw(param_00)
{
	doperkfunctions("specialty_quickdraw");
}

//Function Number: 14
tryuseblastshield(param_00)
{
	doperkfunctions("_specialty_blastshield");
}

//Function Number: 15
tryusesitrep(param_00)
{
	doperkfunctions("specialty_detectexplosive");
}

//Function Number: 16
tryuseironlungs(param_00)
{
	doperkfunctions("specialty_autospot");
}

//Function Number: 17
tryuseassassin(param_00)
{
	doperkfunctions("specialty_heartbreaker");
}

//Function Number: 18
tryusedeadsilence(param_00)
{
	doperkfunctions("specialty_quieter");
}

//Function Number: 19
doperkfunctions(param_00)
{
	maps\mp\_utility::giveperk(param_00,0);
	thread watchdeath(param_00);
	thread checkforperkupgrade(param_00);
	maps\mp\_matchdata::logkillstreakevent(param_00 + "_ks",self.origin);
}

//Function Number: 20
watchdeath(param_00)
{
	self endon("disconnect");
	self waittill("death");
	maps\mp\_utility::_unsetperk(param_00);
	maps\mp\_utility::_unsetextraperks(param_00);
}

//Function Number: 21
checkforperkupgrade(param_00)
{
	var_01 = maps\mp\gametypes\_class::getperkupgrade(param_00);
	if(var_01 != "specialty_null")
	{
		maps\mp\_utility::giveperk(var_01,0);
		thread watchdeath(var_01);
	}
}

//Function Number: 22
isperkstreakon(param_00)
{
	for(var_01 = 1;var_01 < 4;var_01++)
	{
		if(isdefined(self.pers["killstreaks"][var_01].streakname) && self.pers["killstreaks"][var_01].streakname == param_00)
		{
			if(self.pers["killstreaks"][var_01].available)
			{
				return 1;
			}
		}
	}

	return 0;
}