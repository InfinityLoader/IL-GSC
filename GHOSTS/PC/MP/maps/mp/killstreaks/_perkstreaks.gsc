/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_perkstreaks.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 221 ms
 * Timestamp: 10/27/2023 1:21:21 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["specialty_fastsprintrecovery_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_fastreload_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_lightweight_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_marathon_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_stalker_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_reducedsway_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_quickswap_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_pitcher_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_bulletaccuracy_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_quickdraw_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_sprintreload_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_silentkill_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_blindeye_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_gpsjammer_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_quieter_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_incog_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_paint_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_scavenger_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_detectexplosive_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_selectivehearing_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_comexp_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_falldamage_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_regenfaster_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_sharp_focus_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_stun_resistance_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["_specialty_blastshield_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_gunsmith_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_extraammo_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_extra_equipment_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_extra_deadly_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_extra_attachment_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_explosivedamage_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_gambler_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_hardline_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_twoprimaries_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_boom_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["specialty_deadeye_ks"] = ::tryuseperkstreak;
	level.killstreakfuncs["all_perks_bonus"] = ::func_8429;
	level.killstreakfuncs["speed_boost"] = ::func_8454;
	level.killstreakfuncs["refill_grenades"] = ::func_844A;
	level.killstreakfuncs["refill_ammo"] = ::tryuserefillammo;
	level.killstreakfuncs["regen_faster"] = ::func_844B;
}

//Function Number: 2
func_8454(param_00,param_01)
{
	func_2962("specialty_juiced","speed_boost");
	return 1;
}

//Function Number: 3
func_844A(param_00,param_01)
{
	func_2962("specialty_refill_grenades","refill_grenades");
	return 1;
}

//Function Number: 4
tryuserefillammo(param_00,param_01)
{
	func_2962("specialty_refill_ammo","refill_ammo");
	return 1;
}

//Function Number: 5
func_844B(param_00,param_01)
{
	func_2962("specialty_regenfaster","regen_faster");
	return 1;
}

//Function Number: 6
func_8429(param_00,param_01)
{
	return 1;
}

//Function Number: 7
tryuseperkstreak(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_7CEA(param_01,"_ks");
	func_2A04(var_02);
	return 1;
}

//Function Number: 8
func_2A04(param_00)
{
	maps\mp\_utility::func_3CFB(param_00,0);
	thread func_8CD6(param_00);
	thread checkforperkupgrade(param_00);
	if(param_00 == "specialty_hardline")
	{
		maps\mp\killstreaks\_killstreaks::setstreakcounttonext();
	}

	maps\mp\_matchdata::func_4F1D(param_00 + "_ks",self.origin);
}

//Function Number: 9
func_2962(param_00,param_01)
{
	maps\mp\_utility::func_3CFB(param_00,0);
	if(isdefined(param_01))
	{
		maps\mp\_matchdata::func_4F1D(param_01,self.origin);
	}
}

//Function Number: 10
func_8CD6(param_00)
{
	self endon("disconnect");
	self waittill("death");
	maps\mp\_utility::_unsetperk(param_00);
}

//Function Number: 11
checkforperkupgrade(param_00)
{
	var_01 = maps\mp\gametypes\_class::getperkupgrade(param_00);
	if(var_01 != "specialty_null")
	{
		maps\mp\_utility::func_3CFB(var_01,0);
		thread func_8CD6(var_01);
	}
}

//Function Number: 12
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