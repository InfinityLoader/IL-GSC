/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_perkstreaks.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 573 ms
 * Timestamp: 10/27/2023 12:29:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_fastsprintrecovery_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_fastreload_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_lightweight_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_marathon_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_stalker_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_reducedsway_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_quickswap_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_pitcher_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_bulletaccuracy_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_quickdraw_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_sprintreload_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_silentkill_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_blindeye_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_gpsjammer_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_quieter_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_incog_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_paint_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_scavenger_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_detectexplosive_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_selectivehearing_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_comexp_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_falldamage_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_regenfaster_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_sharp_focus_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_stun_resistance_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_blastshield_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_gunsmith_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_extraammo_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_extra_equipment_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_extra_deadly_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_extra_attachment_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_explosivedamage_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_gambler_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_hardline_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_twoprimaries_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_boom_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_deadeye_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("specialty_chain_reaction_ks",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("teleport",::func_128F4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("all_perks_bonus",::func_128D6);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("speed_boost",::func_12904);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("refill_grenades",::func_128FA);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("refill_ammo",::func_128F9);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("regen_faster",::func_128FB);
}

//Function Number: 2
func_12904(param_00,param_01)
{
	func_58E3("specialty_juiced","speed_boost");
	return 1;
}

//Function Number: 3
func_128FA(param_00,param_01)
{
	func_58E3("specialty_refill_grenades","refill_grenades");
	return 1;
}

//Function Number: 4
func_128F9(param_00,param_01)
{
	func_58E3("specialty_refill_ammo","refill_ammo");
	return 1;
}

//Function Number: 5
func_128FB(param_00,param_01)
{
	func_58E3("specialty_regenfaster","regen_faster");
	return 1;
}

//Function Number: 6
func_128D6(param_00,param_01)
{
	return 1;
}

//Function Number: 7
func_128F4(param_00,param_01)
{
	var_02 = scripts\mp\_utility::strip_suffix(param_01,"_ks");
	func_5A5D(var_02);
	return 1;
}

//Function Number: 8
func_5A5D(param_00)
{
	scripts\mp\_utility::func_8387(param_00);
	thread func_139E8(param_00);
	thread func_3E15(param_00);
	if(param_00 == "specialty_hardline")
	{
		scripts\mp\killstreaks\_killstreaks::func_F866();
	}

	scripts\mp\_matchdata::func_AFC9(param_00 + "_ks",self.origin);
}

//Function Number: 9
func_58E3(param_00,param_01)
{
	scripts\mp\_utility::func_8387(param_00);
	if(isdefined(param_01))
	{
		scripts\mp\_matchdata::func_AFC9(param_01,self.origin);
	}
}

//Function Number: 10
func_139E8(param_00)
{
	self endon("disconnect");
	self waittill("death");
	scripts\mp\_utility::func_E150(param_00);
}

//Function Number: 11
func_3E15(param_00)
{
	var_01 = scripts\mp\_class::func_805D(param_00);
	if(var_01 != "specialty_null")
	{
		scripts\mp\_utility::func_8387(var_01);
		thread func_139E8(var_01);
	}
}

//Function Number: 12
func_9EE0(param_00)
{
	for(var_01 = 1;var_01 < 4;var_01++)
	{
		if(isdefined(self.pers["killstreaks"][var_01].var_110EA) && self.pers["killstreaks"][var_01].var_110EA == param_00)
		{
			if(self.pers["killstreaks"][var_01].var_269A)
			{
				return 1;
			}
		}
	}

	return 0;
}