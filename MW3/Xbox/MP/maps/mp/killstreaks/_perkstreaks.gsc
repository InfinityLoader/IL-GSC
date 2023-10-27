/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_perkstreaks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 22
 * Decompile Time: 380 ms
 * Timestamp: 10/27/2023 2:27:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["specialty_longersprint_ks"] = ::func_28E9;
	level.killstreakfuncs["specialty_fastreload_ks"] = ::func_28EA;
	level.killstreakfuncs["specialty_scavenger_ks"] = ::tryusescavenger;
	level.killstreakfuncs["specialty_blindeye_ks"] = ::func_28E4;
	level.killstreakfuncs["specialty_paint_ks"] = ::tryusepaint;
	level.killstreakfuncs["specialty_hardline_ks"] = ::func_28EC;
	level.killstreakfuncs["specialty_coldblooded_ks"] = ::tryusecoldblooded;
	level.killstreakfuncs["specialty_quickdraw_ks"] = ::func_28EF;
	level.killstreakfuncs["specialty_assists_ks"] = ::func_28E6;
	level.killstreakfuncs["_specialty_blastshield_ks"] = ::tryuseblastshield;
	level.killstreakfuncs["specialty_detectexplosive_ks"] = ::tryusesitrep;
	level.killstreakfuncs["specialty_autospot_ks"] = ::tryuseironlungs;
	level.killstreakfuncs["specialty_bulletaccuracy_ks"] = ::tryusesteadyaim;
	level.killstreakfuncs["specialty_quieter_ks"] = ::tryusedeadsilence;
	level.killstreakfuncs["specialty_stalker_ks"] = ::func_28E8;
	level.killstreakfuncs["all_perks_bonus"] = ::func_28E3;
}

//Function Number: 2
func_28E3()
{
}

//Function Number: 3
func_28E4(param_00)
{
	func_28F5("specialty_blindeye");
}

//Function Number: 4
tryusepaint(param_00)
{
	func_28F5("specialty_paint");
}

//Function Number: 5
func_28E6(param_00)
{
	func_28F5("specialty_assists");
}

//Function Number: 6
tryusesteadyaim(param_00)
{
	func_28F5("specialty_bulletaccuracy");
}

//Function Number: 7
func_28E8(param_00)
{
	func_28F5("specialty_stalker");
}

//Function Number: 8
func_28E9(param_00)
{
	func_28F5("specialty_longersprint");
}

//Function Number: 9
func_28EA(param_00)
{
	func_28F5("specialty_fastreload");
}

//Function Number: 10
tryusescavenger(param_00)
{
	func_28F5("specialty_scavenger");
}

//Function Number: 11
func_28EC(param_00)
{
	func_28F5("specialty_hardline");
	maps\mp\killstreaks\_killstreaks::func_28ED();
}

//Function Number: 12
tryusecoldblooded(param_00)
{
	func_28F5("specialty_coldblooded");
}

//Function Number: 13
func_28EF(param_00)
{
	func_28F5("specialty_quickdraw");
}

//Function Number: 14
tryuseblastshield(param_00)
{
	func_28F5("_specialty_blastshield");
}

//Function Number: 15
tryusesitrep(param_00)
{
	func_28F5("specialty_detectexplosive");
}

//Function Number: 16
tryuseironlungs(param_00)
{
	func_28F5("specialty_autospot");
}

//Function Number: 17
func_28F3(param_00)
{
	func_28F5("specialty_heartbreaker");
}

//Function Number: 18
tryusedeadsilence(param_00)
{
	func_28F5("specialty_quieter");
}

//Function Number: 19
func_28F5(param_00)
{
	maps\mp\_utility::giveperk(param_00,0);
	thread func_28F6(param_00);
	thread func_28F8(param_00);
	maps\mp\_matchdata::logkillstreakevent(param_00 + "_ks",self.origin);
}

//Function Number: 20
func_28F6(param_00)
{
	self endon("disconnect");
	self waittill("death");
	maps\mp\_utility::func_282E(param_00);
	maps\mp\_utility::_unsetextraperks(param_00);
}

//Function Number: 21
func_28F8(param_00)
{
	var_01 = maps\mp\gametypes\_class::func_28F9(param_00);
	if(var_01 != "specialty_null")
	{
		maps\mp\_utility::giveperk(var_01,0);
		thread func_28F6(var_01);
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