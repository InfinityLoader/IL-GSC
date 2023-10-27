/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zombies_perks.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 420 ms
 * Timestamp: 10/27/2023 3:25:42 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_AB22 = [];
	level.var_AB23 = [];
	level.var_AB25 = [];
	level.var_AB22["specialty_class_armor_zm"] = 1;
	level.var_AB22["specialty_class_longlasting_zm"] = 1;
	level.var_AB22["specialty_class_resourceful_zm"] = 1;
	level.var_AB22["specialty_class_aftertaste_zm"] = 1;
	level.var_AB22["specialty_class_mugger_zm"] = 1;
	level.var_AB22["specialty_class_finishing_blow_zm"] = 1;
	level.var_AB22["specialty_class_fully_loaded_zm"] = 1;
	level.var_AB22["specialty_class_preventative_medicine_zm"] = 1;
	level.var_AB22["specialty_class_flak_jacket_zm"] = 1;
	level.var_AB22["specialty_class_grenadier_zm"] = 1;
	level.var_AB22["specialty_class_discipline_zm"] = 1;
	level.var_AB22["specialty_class_specialist_zm"] = 1;
	level.var_AB22["specialty_class_dutiful_medic_zm"] = 1;
	level.var_AB22["specialty_class_gungho_zm"] = 1;
	level.var_AB22["specialty_class_fast_hands_zm"] = 1;
	level.var_AB22["specialty_class_hoarder_zm"] = 1;
	level.var_AB22["specialty_class_lucky_crit_zm"] = 1;
	level.var_AB22["specialty_class_mule_kick_zm"] = 1;
	level.var_AB22["specialty_class_mobilization_zm"] = 1;
	level.var_AB22["specialty_class_survivalist_zm"] = 1;
	level.var_AB22["specialty_class_saboteur_zm"] = 1;
	level.var_AB22["specialty_class_recon_medic_zm"] = 1;
	level.var_AB22["specialty_class_covert_exfiltration_zm"] = 1;
	level.var_AB22["specialty_class_serrated_edge_zm"] = 1;
	level.var_AB22["specialty_class_charge_the_line_zm"] = 1;
	level.var_AB22["specialty_class_marksmanship_zm"] = 1;
	level.var_AB22["specialty_class_explosives_handler_zm"] = 1;
	level.var_AB22["specialty_class_ammo_carrier_zm"] = 1;
	level.var_AB22["specialty_class_frag_skull_zm"] = 1;
	level.var_AB22["specialty_class_squad_tactics_zm"] = 1;
	level.var_AB22["specialty_class_mk_ii_zm"] = 1;
	level.var_AB22["specialty_class_suppressive_fire_zm"] = 1;
	level.var_AB22["specialty_class_improvised_def_zm"] = 1;
	level.var_AB22["specialty_class_resilient_zm"] = 1;
	level.var_AB22["specialty_class_team_effort_zm"] = 1;
	level.var_AB22["specialty_class_counter_offensive_zm"] = 1;
	level.var_AB22["specialty_class_come_get_zm"] = 1;
	level.var_AB22["specialty_class_hit_em_hard_zm"] = 1;
	level.var_AB22["specialty_class_bolster_morale_zm"] = 1;
	level.var_AB22["specialty_class_exploit_weakness_zm"] = 1;
	level.var_AB22["specialty_class_on_your_feet_zm"] = 1;
	level.var_AB22["specialty_class_fiery_burst_zm"] = 1;
	level.var_AB22["specialty_class_breathing_room_zm"] = 1;
	level.var_AB22["specialty_class_sustain_zone_zm"] = 1;
	level.var_AB23["specialty_class_armor_zm"] = ::func_8632;
	level.var_AB25["specialty_class_armor_zm"] = ::func_A051;
	level.var_AB23["specialty_class_fully_loaded_zm"] = ::func_868A;
	level.var_AB25["specialty_class_fully_loaded_zm"] = ::func_A066;
	level.var_AB23["specialty_class_flak_jacket_zm"] = ::func_8683;
	level.var_AB25["specialty_class_flak_jacket_zm"] = ::func_A062;
	level.var_AB23["specialty_class_grenadier_zm"] = ::func_8697;
	level.var_AB25["specialty_class_grenadier_zm"] = ::func_A068;
	level.var_AB23["specialty_class_discipline_zm"] = ::func_8665;
	level.var_AB25["specialty_class_discipline_zm"] = ::func_A058;
	level.var_AB23["specialty_class_dutiful_medic_zm"] = ::func_866F;
	level.var_AB25["specialty_class_dutiful_medic_zm"] = ::func_A05A;
	level.var_AB23["specialty_class_gungho_zm"] = ::func_869B;
	level.var_AB25["specialty_class_gungho_zm"] = ::func_A069;
	level.var_AB23["specialty_class_fast_hands_zm"] = ::func_867D;
	level.var_AB25["specialty_class_fast_hands_zm"] = ::func_A05F;
	level.var_AB23["specialty_class_hoarder_zm"] = ::func_86A8;
	level.var_AB25["specialty_class_hoarder_zm"] = ::func_A06A;
	level.var_611["zmb_moon_speed_down"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_speed_down");
}

//Function Number: 2
func_0F35(param_00)
{
}

//Function Number: 3
func_536E()
{
	foreach(var_02, var_01 in level.var_AB22)
	{
		level.var_8324[var_02] = var_01;
	}

	foreach(var_02, var_04 in level.var_AB23)
	{
		level.var_6F68[var_02] = var_04;
	}

	foreach(var_02, var_04 in level.var_AB25)
	{
		level.var_6F6C[var_02] = var_04;
	}
}

//Function Number: 4
func_0F39()
{
	var_00 = lib_0547::func_4BA7("specialty_class_armor_zm") || lib_0547::func_4BA7("specialty_class_longlasting_zm") || lib_0547::func_4BA7("specialty_class_resourceful_zm") || lib_0547::func_4BA7("specialty_class_aftertaste_zm") || lib_0547::func_4BA7("specialty_class_mugger_zm") || lib_0547::func_4BA7("specialty_class_finishing_blow_zm") || lib_0547::func_4BA7("specialty_class_fully_loaded_zm") || lib_0547::func_4BA7("specialty_class_preventative_medicine_zm") || lib_0547::func_4BA7("specialty_class_flak_jacket_zm") || lib_0547::func_4BA7("specialty_class_grenadier_zm") || lib_0547::func_4BA7("specialty_class_discipline_zm") || lib_0547::func_4BA7("specialty_class_specialist_zm") || lib_0547::func_4BA7("specialty_class_dutiful_medic_zm") || lib_0547::func_4BA7("specialty_class_gungho_zm") || lib_0547::func_4BA7("specialty_class_fast_hands_zm") || lib_0547::func_4BA7("specialty_class_suppressive_fire_zm") || lib_0547::func_4BA7("specialty_class_hoarder_zm") || lib_0547::func_4BA7("specialty_class_lucky_crit_zm") || lib_0547::func_4BA7("specialty_class_mule_kick_zm");
	if(var_00)
	{
		level.var_400E[level.var_400E.size] = ["assassin_set 4 -1",self];
		level.var_400E[level.var_400E.size] = ["bat_elite_set 4 -1",self];
	}
}

//Function Number: 5
func_A27B(param_00,param_01)
{
	switch(param_01)
	{
		case "specialty_class_hoarder_zm":
		case "specialty_class_mk_ii_zm":
		case "specialty_class_hit_em_hard_zm":
		case "specialty_class_dutiful_medic_zm":
		case "specialty_class_specialist_zm":
		case "specialty_class_on_your_feet_zm":
		case "specialty_class_resilient_zm":
		case "specialty_class_improvised_def_zm":
		case "specialty_class_frag_skull_zm":
		case "specialty_class_explosives_handler_zm":
		case "specialty_class_marksmanship_zm":
		case "specialty_class_survivalist_zm":
		case "specialty_class_grenadier_zm":
		case "specialty_class_fully_loaded_zm":
		case "specialty_class_longlasting_zm":
		case "specialty_class_armor_zm":
		case "specialty_class_mule_kick_zm":
		case "specialty_class_recon_medic_zm":
		case "specialty_class_preventative_medicine_zm":
		case "specialty_class_aftertaste_zm":
		case "specialty_class_lucky_crit_zm":
		case "specialty_class_fast_hands_zm":
		case "specialty_class_gungho_zm":
		case "specialty_class_discipline_zm":
		case "specialty_class_flak_jacket_zm":
		case "specialty_class_finishing_blow_zm":
		case "specialty_class_mugger_zm":
		case "specialty_class_resourceful_zm":
		case "specialty_class_suppressive_fire_zm":
		case "specialty_class_serrated_edge_zm":
		case "specialty_class_sustain_zone_zm":
		case "specialty_class_come_get_zm":
		case "specialty_class_breathing_room_zm":
		case "specialty_class_fiery_burst_zm":
		case "specialty_class_exploit_weakness_zm":
		case "specialty_class_bolster_morale_zm":
		case "specialty_class_counter_offensive_zm":
		case "specialty_class_team_effort_zm":
		case "specialty_class_ammo_carrier_zm":
		case "specialty_class_covert_exfiltration_zm":
		case "specialty_class_saboteur_zm":
		case "specialty_class_squad_tactics_zm":
		case "specialty_class_charge_the_line_zm":
		case "specialty_class_mobilization_zm":
			return maps\mp\_utility::func_452A(param_01);

		default:
			return 0;
	}
}

//Function Number: 6
func_6B6C(param_00)
{
	param_00.var_AB24 = [];
}

//Function Number: 7
func_6B81()
{
	var_00 = 0;
	if(lib_0547::func_4BA7("specialty_class_armor_zm"))
	{
		var_00 = lib_0547::playergetmaxarmorcount();
	}

	lib_0547::func_7454(var_00);
}

//Function Number: 8
func_8632()
{
}

//Function Number: 9
func_A051()
{
}

//Function Number: 10
func_868A()
{
	maps\mp\_utility::func_47A2("specialty_stockpile");
}

//Function Number: 11
func_A066()
{
	maps\mp\_utility::func_735("specialty_stockpile");
}

//Function Number: 12
func_8683()
{
	maps\mp\_utility::func_47A2("specialty_immune_grenade_suicide");
}

//Function Number: 13
func_A062()
{
	maps\mp\_utility::func_735("specialty_immune_grenade_suicide");
}

//Function Number: 14
func_0633()
{
	if(lib_0547::func_F0F("specialty_class_longlasting_zm"))
	{
		return 5;
	}

	return 0;
}

//Function Number: 15
func_8697()
{
	maps\mp\_utility::func_47A2("specialty_grenade_extra_zm");
}

//Function Number: 16
func_A068()
{
	maps\mp\_utility::func_735("specialty_grenade_extra_zm");
}

//Function Number: 17
func_8665()
{
	maps\mp\_utility::func_47A2("specialty_discipline_zm");
}

//Function Number: 18
func_A058()
{
	maps\mp\_utility::func_735("specialty_discipline_zm");
}

//Function Number: 19
func_866F()
{
	self.var_3514 = 0;
}

//Function Number: 20
func_A05A()
{
	self.var_3514 = undefined;
}

//Function Number: 21
func_21B2()
{
	if(lib_0547::func_4BA7("specialty_class_dutiful_medic_zm") && isdefined(self.var_57AB) && self.var_57AB && gettime() - self.var_3514 > 30000)
	{
		self luinotifyeventextraplayer(&"trigger_mod_proc_and_stop",2,"specialty_class_dutiful_medic_zm",30000);
		self.var_3514 = gettime();
		return 1;
	}

	return 0;
}

//Function Number: 22
func_869B()
{
	maps\mp\_utility::func_47A2("specialty_sprintfire");
	maps\mp\_utility::func_47A2("specialty_mantlefire");
}

//Function Number: 23
func_A069()
{
	maps\mp\_utility::func_735("specialty_sprintfire");
	maps\mp\_utility::func_735("specialty_mantlefire");
}

//Function Number: 24
func_867D()
{
	maps\mp\_utility::func_47A2("specialty_quickswap");
	maps\mp\_utility::func_47A2("specialty_fastoffhand");
}

//Function Number: 25
func_A05F()
{
	maps\mp\_utility::func_735("specialty_quickswap");
	maps\mp\_utility::func_735("specialty_fastoffhand");
}

//Function Number: 26
func_86A8()
{
	var_00 = lib_056A::func_420E(1);
	self setclientomnvar("zm_blitz_items_limit",var_00);
}

//Function Number: 27
func_A06A()
{
	var_00 = lib_056A::func_420E(0);
	self setclientomnvar("zm_blitz_items_limit",var_00);
}

//Function Number: 28
func_466B(param_00)
{
	switch(param_00)
	{
		case "throwingknife_zm":
			return 2.5;

		default:
			return 2.5;
	}
}

//Function Number: 29
func_0F38(param_00)
{
	lib_054D::func_99B("suppressive_fire",func_46BB(param_00));
	if(isalive(self))
	{
		playfxontag(level.var_611["zmb_moon_speed_down"],self,"J_Knee_RI");
		playfxontag(level.var_611["zmb_moon_speed_down"],self,"J_Knee_LE");
	}
}

//Function Number: 30
func_46BB(param_00)
{
	var_01 = lib_054D::func_443F("suppressive_fire");
	if(!isdefined(var_01))
	{
		var_01 = func_90A8();
	}

	var_01.var_5CC8 = 1;
	var_01.var_721C = param_00;
	return var_01;
}

//Function Number: 31
func_90A8()
{
	var_00 = spawnstruct();
	var_00.var_1CF0 = ::func_7CFD;
	var_00.var_5CC8 = 1;
	var_01 = 1;
	var_02 = lib_0547::func_A51(self.var_A4B);
	if(isdefined(var_02.suppressive_fire_speed_multiplier))
	{
		var_01 = var_02.suppressive_fire_speed_multiplier;
	}

	var_00.var_90F0 = var_01;
	self notify("speed_debuffs_changed");
	return var_00;
}

//Function Number: 32
func_7CFD(param_00)
{
	self notify("speed_debuffs_changed");
	stopfxontag(level.var_611["zmb_moon_speed_down"],self,"J_Knee_RI");
	stopfxontag(level.var_611["zmb_moon_speed_down"],self,"J_Knee_LE");
}