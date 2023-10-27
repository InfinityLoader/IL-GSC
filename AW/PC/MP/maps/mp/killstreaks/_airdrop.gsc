/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_airdrop.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 995 ms
 * Timestamp: 10/27/2023 1:51:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(getdvarint("virtuallobbyactive",0))
	{
		return;
	}

	level._effect["airdrop_crate_destroy"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["airdrop_crate_trap_explode"] = loadfx("vfx/explosion/frag_grenade_default");
	setairdropcratecollision("airdrop_crate");
	setairdropcratecollision("care_package");
	level.numdropcrates = 0;
	level.cratetypes = [];
	level.killstreakwieldweapons["airdrop_trap_explosive_mp"] = "airdrop_assault";
	level.killstreakfuncs["airdrop_reinforcement_common"] = ::tryusereinforcementcommon;
	level.killstreakfuncs["airdrop_reinforcement_uncommon"] = ::tryusereinforcementuncommon;
	level.killstreakfuncs["airdrop_reinforcement_rare"] = ::tryusereinforcementrare;
	level.killstreakfuncs["airdrop_reinforcement_practice"] = ::tryusereinforcementpractice;
	addcratetypes_standard();
	level.secondaryreinforcementhinttext = [];
	level.secondaryreinforcementhinttext["specialty_extended_battery"] = &"PERKS_EXO_BATTERY";
	level.secondaryreinforcementhinttext["specialty_class_lowprofile"] = &"PERKS_LOWPROFILE";
	level.secondaryreinforcementhinttext["specialty_class_flakjacket"] = &"PERKS_FLAKJACKET";
	level.secondaryreinforcementhinttext["specialty_class_lightweight"] = &"PERKS_LIGHTWEIGHT";
	level.secondaryreinforcementhinttext["specialty_class_blindeye"] = &"PERKS_BLINDEYE";
	level.secondaryreinforcementhinttext["specialty_class_coldblooded"] = &"PERKS_COLDBLOODED";
	level.secondaryreinforcementhinttext["specialty_class_peripherals"] = &"PERKS_PERIPHERALS";
	level.secondaryreinforcementhinttext["specialty_class_fasthands"] = &"PERKS_FASTHANDS";
	level.secondaryreinforcementhinttext["specialty_class_dexterity"] = &"PERKS_DEXTERITY";
	level.secondaryreinforcementhinttext["specialty_exo_blastsuppressor"] = &"PERKS_EXO_BLASTSUPPRESSOR";
	level.secondaryreinforcementhinttext["specialty_class_hardwired"] = &"PERKS_HARDWIRED";
	level.secondaryreinforcementhinttext["specialty_class_toughness"] = &"PERKS_TOUGHNESS";
	level.secondaryreinforcementhinttext["specialty_class_scavenger"] = &"PERKS_SCAVENGER";
	level.secondaryreinforcementhinttext["specialty_class_hardline"] = &"PERKS_HARDLINE";
	if(isdefined(level.customcratefunc))
	{
		[[ level.customcratefunc ]]();
	}

	generatemaxweightedcratevalue();
	level.mapkillstreakautodropindex = randomint(4);
}

//Function Number: 2
addcratetypes_standard()
{
	var_00 = level.mapkillstreak;
	if(isdefined(level.mapstreaksdisabled) && level.mapstreaksdisabled)
	{
		var_00 = undefined;
	}

	addcratetype("airdrop_assault",var_00,168,::killstreakcratethink,level.mapkillstreakpickupstring,var_00);
	addcratetype("airdrop_assault","b",168,::killstreakcratethink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian","sentry_heavy_resistance");
	addcratetype("airdrop_assault","c",168,::killstreakcratethink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian","sentry_rippable","sentry_rocket_turret");
	addcratetype("airdrop_assault","d",168,::killstreakcratethink,&"MP_MISSILE_STRIKE_PICKUP","missile_strike","missile_strike_extra_1");
	addcratetype("airdrop_assault","e",168,::killstreakcratethink,&"MP_MISSILE_STRIKE_PICKUP","missile_strike","missile_strike_chem","missile_strike_extra_1");
	addcratetype("airdrop_assault","f",168,::killstreakcratethink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_cloak","recon_ugv_assist_points");
	addcratetype("airdrop_assault","g",168,::killstreakcratethink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_paint_grenade","recon_ugv_assist_points");
	addcratetype("airdrop_assault","h",98,::killstreakcratethink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_beam");
	addcratetype("airdrop_assault","i",98,::killstreakcratethink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_width","orbital_strike_laser_duration");
	addcratetype("airdrop_assault","j",100,::killstreakcratethink,&"MP_UAV_PICKUP","uav","uav_enemy_direction","uav_orbit");
	addcratetype("airdrop_assault","k",100,::killstreakcratethink,&"MP_UAV_PICKUP","uav","uav_scrambler","uav_increased_time","uav_paint_outline");
	addcratetype("airdrop_assault","l",40,::killstreakcratethink,&"MP_WARBIRD_PICKUP","warbird","warbird_rockets","warbird_coop_offensive");
	addcratetype("airdrop_assault","m",40,::killstreakcratethink,&"MP_WARBIRD_PICKUP","warbird","warbird_ai_attack","warbird_flares","warbird_time");
	addcratetype("airdrop_assault","n",30,::killstreakcratethink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_mg","assault_ugv_rockets");
	addcratetype("airdrop_assault","o",30,::killstreakcratethink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_ai","assault_ugv_rockets");
	addcratetype("airdrop_assault","p",20,::killstreakcratethink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_turret","orbitalsupport_coop_offensive","orbitalsupport_ammo");
	addcratetype("airdrop_assault","q",20,::killstreakcratethink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_rockets","orbitalsupport_flares","orbitalsupport_time");
	addcratetype("airdrop_assault","r",20,::killstreakcratethink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_two","strafing_run_airstrike_flares");
	addcratetype("airdrop_assault","s",20,::killstreakcratethink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_stealth");
	addcratetype("airdrop_assault","t",10,::killstreakcratethink,&"MP_EMP_PICKUP","emp","emp_assist","emp_flash");
	addcratetype("airdrop_assault","u",10,::killstreakcratethink,&"MP_EMP_PICKUP","emp","emp_streak_kill","emp_equipment_kill","emp_time_1");
	addcratetype("airdrop_assault","v",10,::killstreakcratethink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_radar","heavy_exosuit_punch");
	addcratetype("airdrop_assault","w",10,::killstreakcratethink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_trophy","heavy_exosuit_rockets","heavy_exosuit_eject");
	addcratetype("airdrop_assault_odds",var_00,136,::killstreakcratethink,level.mapkillstreakpickupstring,var_00);
	addcratetype("airdrop_assault_odds","b",136,::killstreakcratethink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian","sentry_heavy_resistance");
	addcratetype("airdrop_assault_odds","c",136,::killstreakcratethink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian","sentry_rippable","sentry_rocket_turret");
	addcratetype("airdrop_assault_odds","d",136,::killstreakcratethink,&"MP_MISSILE_STRIKE_PICKUP","missile_strike","missile_strike_extra_1");
	addcratetype("airdrop_assault_odds","e",136,::killstreakcratethink,&"MP_MISSILE_STRIKE_PICKUP","missile_strike","missile_strike_chem","missile_strike_extra_1");
	addcratetype("airdrop_assault_odds","f",136,::killstreakcratethink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_cloak","recon_ugv_assist_points");
	addcratetype("airdrop_assault_odds","g",136,::killstreakcratethink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_paint_grenade","recon_ugv_assist_points");
	addcratetype("airdrop_assault_odds","h",116,::killstreakcratethink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_beam");
	addcratetype("airdrop_assault_odds","i",116,::killstreakcratethink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_width","orbital_strike_laser_duration");
	addcratetype("airdrop_assault_odds","j",100,::killstreakcratethink,&"MP_UAV_PICKUP","uav","uav_enemy_direction","uav_orbit");
	addcratetype("airdrop_assault_odds","k",100,::killstreakcratethink,&"MP_UAV_PICKUP","uav","uav_scrambler","uav_increased_time","uav_paint_outline");
	addcratetype("airdrop_assault_odds","l",60,::killstreakcratethink,&"MP_WARBIRD_PICKUP","warbird","warbird_rockets","warbird_coop_offensive");
	addcratetype("airdrop_assault_odds","m",60,::killstreakcratethink,&"MP_WARBIRD_PICKUP","warbird","warbird_ai_attack","warbird_flares","warbird_time");
	addcratetype("airdrop_assault_odds","n",50,::killstreakcratethink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_mg","assault_ugv_rockets");
	addcratetype("airdrop_assault_odds","o",50,::killstreakcratethink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_ai","assault_ugv_rockets");
	addcratetype("airdrop_assault_odds","p",40,::killstreakcratethink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_turret","orbitalsupport_coop_offensive","orbitalsupport_ammo");
	addcratetype("airdrop_assault_odds","q",40,::killstreakcratethink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_rockets","orbitalsupport_flares","orbitalsupport_time");
	addcratetype("airdrop_assault_odds","r",40,::killstreakcratethink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_two","strafing_run_airstrike_flares");
	addcratetype("airdrop_assault_odds","s",40,::killstreakcratethink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_stealth");
	addcratetype("airdrop_assault_odds","t",30,::killstreakcratethink,&"MP_EMP_PICKUP","emp","emp_assist","emp_flash");
	addcratetype("airdrop_assault_odds","u",30,::killstreakcratethink,&"MP_EMP_PICKUP","emp","emp_streak_kill","emp_equipment_kill","emp_time_1");
	addcratetype("airdrop_assault_odds","v",30,::killstreakcratethink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_radar","heavy_exosuit_punch");
	addcratetype("airdrop_assault_odds","w",30,::killstreakcratethink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_trophy","heavy_exosuit_rockets","heavy_exosuit_eject");
	addcratetype("airdrop_reinforcement_common","a",100,::reinforcementcratekillstreakthink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian");
	addcratetype("airdrop_reinforcement_common","b",100,::reinforcementcratekillstreakthink,&"MP_UAV_PICKUP","uav","uav_enemy_direction");
	addcratetype("airdrop_reinforcement_common","c",100,::reinforcementcratekillstreakthink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_assist_points");
	addcratetype("airdrop_reinforcement_uncommon","a",100,::reinforcementcratekillstreakthink,&"MP_EMP_PICKUP","emp");
	addcratetype("airdrop_reinforcement_uncommon","b",100,::reinforcementcratekillstreakthink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_rockets");
	addcratetype("airdrop_reinforcement_uncommon","c",100,::reinforcementcratekillstreakthink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian","sentry_rippable","sentry_rocket_turret");
	addcratetype("airdrop_reinforcement_uncommon","d",100,::reinforcementcratekillstreakthink,&"MP_MISSILE_STRIKE_PICKUP","missile_strike","missile_strike_chem","missile_strike_extra_1");
	addcratetype("airdrop_reinforcement_uncommon","e",100,::reinforcementcratekillstreakthink,&"MP_UAV_PICKUP","uav","uav_scrambler","uav_increased_time");
	addcratetype("airdrop_reinforcement_uncommon","f",100,::reinforcementcratekillstreakthink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_paint_grenade","recon_ugv_assist_points");
	addcratetype("airdrop_reinforcement_uncommon","g",100,::reinforcementcratespecialtythink,&"PERKS_EXO_BATTERY","specialty_extended_battery");
	addcratetype("airdrop_reinforcement_uncommon","h",100,::reinforcementcratespecialtythink,&"PERKS_LOWPROFILE","specialty_class_lowprofile");
	addcratetype("airdrop_reinforcement_uncommon","j",100,::reinforcementcratespecialtythink,&"PERKS_FLAKJACKET","specialty_class_flakjacket");
	addcratetype("airdrop_reinforcement_uncommon","k",100,::reinforcementcratespecialtythink,&"PERKS_LIGHTWEIGHT","specialty_class_lightweight");
	addcratetype("airdrop_reinforcement_uncommon","l",100,::reinforcementcratespecialtythink,&"PERKS_BLINDEYE","specialty_class_blindeye");
	addcratetype("airdrop_reinforcement_uncommon","m",100,::reinforcementcratespecialtythink,&"PERKS_COLDBLOODED","specialty_class_coldblooded");
	addcratetype("airdrop_reinforcement_uncommon","n",100,::reinforcementcratespecialtythink,&"PERKS_PERIPHERALS","specialty_class_peripherals");
	addcratetype("airdrop_reinforcement_uncommon","o",100,::reinforcementcratespecialtythink,&"PERKS_FASTHANDS","specialty_class_fasthands");
	addcratetype("airdrop_reinforcement_uncommon","p",100,::reinforcementcratespecialtythink,&"PERKS_DEXTERITY","specialty_class_dexterity");
	addcratetype("airdrop_reinforcement_uncommon","r",100,::reinforcementcratespecialtythink,&"PERKS_EXO_BLASTSUPPRESSOR","specialty_exo_blastsuppressor");
	addcratetype("airdrop_reinforcement_uncommon","s",100,::reinforcementcratespecialtythink,&"PERKS_HARDWIRED","specialty_class_hardwired");
	addcratetype("airdrop_reinforcement_uncommon","t",100,::reinforcementcratespecialtythink,&"PERKS_TOUGHNESS","specialty_class_toughness");
	addcratetype("airdrop_reinforcement_uncommon","u",100,::reinforcementcratespecialtythink,&"PERKS_SCAVENGER","specialty_class_scavenger");
	addcratetype("airdrop_reinforcement_uncommon","v",100,::reinforcementcratespecialtythink,&"PERKS_HARDLINE","specialty_class_hardline");
	addcratetype("airdrop_reinforcement_rare","a",100,::reinforcementcratekillstreakthink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_radar");
	addcratetype("airdrop_reinforcement_rare","b",100,::reinforcementcratekillstreakthink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_turret");
	addcratetype("airdrop_reinforcement_rare","c",100,::reinforcementcratekillstreakthink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_flares");
	addcratetype("airdrop_reinforcement_rare","d",100,::reinforcementcratekillstreakthink,&"MP_WARBIRD_PICKUP","warbird","warbird_ai_attack","warbird_flares");
	addcratetype("airdrop_reinforcement_rare","e",100,::reinforcementcratekillstreakthink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_width","orbital_strike_laser_duration");
	addcratetype("airdrop_reinforcement_rare","f",100,::reinforcementcratekillstreakthink,&"MP_UAV_PICKUP","uav","uav_scrambler","uav_increased_time","uav_paint_outline");
	addcratetype("airdrop_reinforcement_rare","g",100,::reinforcementcratekillstreakthink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_paint_grenade","recon_ugv_assist_points","recon_ugv_stun");
	addcratetype("airdrop_reinforcement_rare","h",100,::reinforcementcratespecialtythink,&"PERKS_EXO_BATTERY","specialty_extended_battery");
	addcratetype("airdrop_reinforcement_rare","i",100,::reinforcementcratespecialtythink,&"PERKS_LOWPROFILE","specialty_class_lowprofile");
	addcratetype("airdrop_reinforcement_rare","k",100,::reinforcementcratespecialtythink,&"PERKS_FLAKJACKET","specialty_class_flakjacket");
	addcratetype("airdrop_reinforcement_rare","l",100,::reinforcementcratespecialtythink,&"PERKS_LIGHTWEIGHT","specialty_class_lightweight");
	addcratetype("airdrop_reinforcement_rare","m",100,::reinforcementcratespecialtythink,&"PERKS_BLINDEYE","specialty_class_blindeye");
	addcratetype("airdrop_reinforcement_rare","n",100,::reinforcementcratespecialtythink,&"PERKS_COLDBLOODED","specialty_class_coldblooded");
	addcratetype("airdrop_reinforcement_rare","o",100,::reinforcementcratespecialtythink,&"PERKS_PERIPHERALS","specialty_class_peripherals");
	addcratetype("airdrop_reinforcement_rare","p",100,::reinforcementcratespecialtythink,&"PERKS_FASTHANDS","specialty_class_fasthands");
	addcratetype("airdrop_reinforcement_rare","q",100,::reinforcementcratespecialtythink,&"PERKS_DEXTERITY","specialty_class_dexterity");
	addcratetype("airdrop_reinforcement_rare","s",100,::reinforcementcratespecialtythink,&"PERKS_EXO_BLASTSUPPRESSOR","specialty_exo_blastsuppressor");
	addcratetype("airdrop_reinforcement_rare","t",100,::reinforcementcratespecialtythink,&"PERKS_HARDWIRED","specialty_class_hardwired");
	addcratetype("airdrop_reinforcement_rare","u",100,::reinforcementcratespecialtythink,&"PERKS_TOUGHNESS","specialty_class_toughness");
	addcratetype("airdrop_reinforcement_rare","v",100,::reinforcementcratespecialtythink,&"PERKS_SCAVENGER","specialty_class_scavenger");
	addcratetype("airdrop_reinforcement_rare","w",100,::reinforcementcratespecialtythink,&"PERKS_HARDLINE","specialty_class_hardline");
	addcratetype("airdrop_reinforcement_practice","a",168,::reinforcementcratekillstreakthink,&"MP_SENTRY_PICKUP","remote_mg_sentry_turret","sentry_guardian","sentry_rippable","sentry_rocket_turret");
	addcratetype("airdrop_reinforcement_practice","b",168,::reinforcementcratekillstreakthink,&"MP_MISSILE_STRIKE_PICKUP","missile_strike","missile_strike_extra_1");
	addcratetype("airdrop_reinforcement_practice","c",168,::reinforcementcratekillstreakthink,&"MP_RECON_UGV_PICKUP","recon_ugv","recon_ugv_paint_grenade","recon_ugv_assist_points");
	addcratetype("airdrop_reinforcement_practice","d",98,::reinforcementcratekillstreakthink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_beam");
	addcratetype("airdrop_reinforcement_practice","e",98,::reinforcementcratekillstreakthink,&"MP_ORBITAL_STRIKE_LASER_PICKUP","orbital_strike_laser","orbital_strike_laser_width","orbital_strike_laser_duration");
	addcratetype("airdrop_reinforcement_practice","f",100,::reinforcementcratekillstreakthink,&"MP_UAV_PICKUP","uav","uav_enemy_direction","uav_orbit");
	addcratetype("airdrop_reinforcement_practice","g",100,::reinforcementcratekillstreakthink,&"MP_UAV_PICKUP","uav","uav_scrambler","uav_increased_time","uav_paint_outline");
	addcratetype("airdrop_reinforcement_practice","h",40,::reinforcementcratekillstreakthink,&"MP_WARBIRD_PICKUP","warbird","warbird_rockets","warbird_coop_offensive");
	addcratetype("airdrop_reinforcement_practice","i",40,::reinforcementcratekillstreakthink,&"MP_WARBIRD_PICKUP","warbird","warbird_ai_attack","warbird_flares","warbird_time");
	addcratetype("airdrop_reinforcement_practice","j",30,::reinforcementcratekillstreakthink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_mg","assault_ugv_rockets");
	addcratetype("airdrop_reinforcement_practice","k",30,::reinforcementcratekillstreakthink,&"MP_GROUND_ASSAULT_DRONE_PICKUP","assault_ugv","assault_ugv_ai","assault_ugv_rockets");
	addcratetype("airdrop_reinforcement_practice","l",20,::reinforcementcratekillstreakthink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_turret","orbitalsupport_coop_offensive","orbitalsupport_ammo");
	addcratetype("airdrop_reinforcement_practice","m",20,::reinforcementcratekillstreakthink,&"MP_ORBITALSUPPORT_PICKUP","orbitalsupport","orbitalsupport_rockets","orbitalsupport_flares","orbitalsupport_time");
	addcratetype("airdrop_reinforcement_practice","n",20,::reinforcementcratekillstreakthink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_flares");
	addcratetype("airdrop_reinforcement_practice","o",20,::reinforcementcratekillstreakthink,&"MP_AIRSTRIKE_PICKUP","strafing_run_airstrike","strafing_run_airstrike_stealth");
	addcratetype("airdrop_reinforcement_practice","p",10,::reinforcementcratekillstreakthink,&"MP_EMP_PICKUP","emp","emp_assist","emp_flash");
	addcratetype("airdrop_reinforcement_practice","q",10,::reinforcementcratekillstreakthink,&"MP_EMP_PICKUP","emp","emp_streak_kill","emp_equipment_kill","emp_time_1");
	addcratetype("airdrop_reinforcement_practice","r",10,::reinforcementcratekillstreakthink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_radar","heavy_exosuit_punch");
	addcratetype("airdrop_reinforcement_practice","s",10,::reinforcementcratekillstreakthink,&"MP_HEAVY_EXO_PICKUP","heavy_exosuit","heavy_exosuit_trophy","heavy_exosuit_rockets","heavy_exosuit_eject");
}

//Function Number: 3
generatemaxweightedcratevalue()
{
	foreach(var_06, var_01 in level.cratetypes)
	{
		level.cratemaxval[var_06] = 0;
		foreach(var_03 in var_01)
		{
			var_04 = var_03.type;
			if(!level.cratetypes[var_06][var_04].raw_weight)
			{
				level.cratetypes[var_06][var_04].weight = level.cratetypes[var_06][var_04].raw_weight;
				continue;
			}

			level.cratemaxval[var_06] = level.cratemaxval[var_06] + level.cratetypes[var_06][var_04].raw_weight;
			level.cratetypes[var_06][var_04].weight = level.cratemaxval[var_06];
		}
	}
}

//Function Number: 4
changecrateweight(param_00,param_01,param_02)
{
	if(!isdefined(level.cratetypes[param_00]) || !isdefined(level.cratetypes[param_00][param_01]))
	{
		return;
	}

	level.cratetypes[param_00][param_01].raw_weight = param_02;
	generatemaxweightedcratevalue();
}

//Function Number: 5
setairdropcratecollision(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level.airdropcratecollision = getent(var_01[0].target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 deletecrate();
	}
}

//Function Number: 6
addcratetype(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_01))
	{
		return;
	}

	level.cratetypes[param_00][param_01] = spawnstruct();
	level.cratetypes[param_00][param_01].droptype = param_00;
	level.cratetypes[param_00][param_01].type = param_01;
	level.cratetypes[param_00][param_01].raw_weight = param_02;
	level.cratetypes[param_00][param_01].weight = param_02;
	level.cratetypes[param_00][param_01].func = param_03;
	level.cratetypes[param_00][param_01].streakref = param_05;
	level.cratetypes[param_00][param_01].modules = [];
	level.cratetypes[param_00][param_01].modules[level.cratetypes[param_00][param_01].modules.size] = param_06;
	level.cratetypes[param_00][param_01].modules[level.cratetypes[param_00][param_01].modules.size] = param_07;
	level.cratetypes[param_00][param_01].modules[level.cratetypes[param_00][param_01].modules.size] = param_08;
	if(isdefined(param_04))
	{
		game["strings"][param_00 + param_01 + "_hint"] = param_04;
	}
}

//Function Number: 7
getstreakforcrate(param_00,param_01)
{
	if(isdefined(level.cratetypes[param_00]) && isdefined(level.cratetypes[param_00][param_01]) && isdefined(level.cratetypes[param_00][param_01].streakref))
	{
		return level.cratetypes[param_00][param_01].streakref;
	}

	return param_01;
}

//Function Number: 8
getmodulesforcrate(param_00,param_01)
{
	if(isdefined(level.customkillstreakcratemodules))
	{
		return [[ level.customkillstreakcratemodules ]](param_00,param_01);
	}

	return level.cratetypes[param_00][param_01].modules;
}

//Function Number: 9
getrandomcratetype(param_00,param_01)
{
	if(getdvar("g_gametype") != "horde")
	{
		var_07 = isdefined(level.mapkillstreak) && isdefined(level.cratetypes[param_00][level.mapkillstreak]);
		var_08 = isdefined(level.mapkillstreakautodropindex) && level.numdropcrates >= level.mapkillstreakautodropindex;
		if(var_07 && var_08)
		{
			level.mapkillstreakautodropindex = undefined;
			return level.mapkillstreak;
		}
	}

	var_09 = randomint(level.cratemaxval[param_00]);
	var_0A = undefined;
	var_0B = level.cratetypes[param_00];
	if(isdefined(param_01))
	{
		var_0C = level.cratetypes[param_00];
		foreach(var_0E in var_0C)
		{
			if(cratetypeisexcluded(var_0E.type,param_01))
			{
				var_0C = special_array_remove(var_0C,var_0E);
			}
		}

		var_0B = var_0C;
	}

	foreach(var_04 in var_0B)
	{
		var_05 = var_04.type;
		if(!level.cratetypes[param_00][var_05].weight)
		{
			continue;
		}

		var_0A = var_05;
		if(level.cratetypes[param_00][var_05].weight > var_09)
		{
			break;
		}
	}

	return var_0A;
}

//Function Number: 10
cratetypeisexcluded(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
special_array_remove(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(var_04 != param_01)
		{
			var_02[var_04.type] = var_04;
		}
	}

	return var_02;
}

//Function Number: 12
getcratetypefordroptype(param_00,param_01)
{
	switch(param_00)
	{
		case "airdrop_assault_odds":
		case "airdrop_assault":
		default:
			break;
	}
}

//Function Number: 13
deleteonownerdeath(param_00)
{
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	self delete();
}

//Function Number: 14
crateteammodelupdater()
{
	self endon("death");
	self hide();
	foreach(var_01 in level.players)
	{
		if(var_01.team != "spectator")
		{
			self showtoplayer(var_01);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_01 in level.players)
		{
			if(var_01.team != "spectator")
			{
				self showtoplayer(var_01);
			}
		}
	}
}

//Function Number: 15
cratemodelteamupdater(param_00,param_01)
{
	self endon("death");
	self hide();
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_00 || param_01 && var_03.team == "spectator")
		{
			self showtoplayer(var_03);
		}
	}

	for(;;)
	{
		level common_scripts\utility::waittill_any("joined_team","joined_spectators");
		self hide();
		foreach(var_03 in level.players)
		{
			if(var_03.team == param_00 || param_01 && var_03.team == "spectator")
			{
				self showtoplayer(var_03);
			}
		}
	}
}

//Function Number: 16
cratemodelplayerupdater(param_00,param_01)
{
	self endon("death");
	self hide();
	foreach(var_03 in level.players)
	{
		if(param_01 && isdefined(param_00) && var_03 != param_00)
		{
			continue;
		}

		if(!param_01 && isdefined(param_00) && var_03 == param_00)
		{
			continue;
		}

		self showtoplayer(var_03);
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_03 in level.players)
		{
			if(param_01 && isdefined(param_00) && var_03 != param_00)
			{
				continue;
			}

			if(!param_01 && isdefined(param_00) && var_03 == param_00)
			{
				continue;
			}

			self showtoplayer(var_03);
		}
	}
}

//Function Number: 17
crateuseteamupdater(param_00)
{
	self endon("death");
	for(;;)
	{
		setusablebyteam(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 18
crateusejuggernautupdater()
{
	var_00 = getstreakforcrate(self.droptype,self.cratetype);
	if(!issubstr(var_00,"juggernaut"))
	{
		return;
	}

	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_01);
		self disableplayeruse(var_01);
		thread crateusepostjuggernautupdater(var_01);
	}
}

//Function Number: 19
crateusepostjuggernautupdater(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("death");
	self enableplayeruse(param_00);
}

//Function Number: 20
createairdropcrate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	var_07 = spawn("script_model",param_03);
	var_07.angles = param_04;
	var_07.curprogress = 0;
	var_07.usetime = 0;
	var_07.userate = 0;
	var_07.team = self.team;
	if(isdefined(param_00))
	{
		var_07.owner = param_00;
	}
	else
	{
		var_07.owner = undefined;
	}

	var_07.cratetype = param_02;
	var_07.droptype = param_01;
	var_07.targetname = "care_package";
	var_07.istrap = param_05;
	if(var_07.team == "any")
	{
		var_07 setmodel("orbital_carepackage_pod_01_ai");
		var_07.friendlymodel = spawn("script_model",var_07.origin);
		var_07.friendlymodel setmodel("tag_origin");
		var_07.friendlymodel thread deleteonownerdeath(var_07);
	}
	else if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		var_07 setmodel("orbital_carepackage_pod_01_logo_atlas");
		var_07.friendlymodel = spawn("script_model",var_07.origin);
		var_07.friendlymodel setmodel("orbital_carepackage_pod_01_ai");
		var_07.friendlymodel.parentcrate = var_07;
		var_07.friendlymodel notsolid();
		var_07.friendlymodel thread deleteonownerdeath(var_07);
	}
	else
	{
		var_07 setmodel(maps\mp\gametypes\_teams::getteamcratemodel(var_07.team));
		var_07 thread crateteammodelupdater();
		var_08 = "orbital_carepackage_pod_01_ai";
		var_09 = "orbital_carepackage_pod_01_clr_01_ai";
		if(param_02 == "booby_trap")
		{
			var_08 = "orbital_carepackage_pod_01_logo_trap_ai";
			var_07 thread trap_createbombsquadmodel();
		}
		else if(param_05)
		{
			var_07 thread trap_createbombsquadmodel();
		}

		var_07.friendlymodel = spawn("script_model",param_03);
		var_07.friendlymodel setmodel(var_08);
		var_07.friendlymodel.parentcrate = var_07;
		var_07.friendlymodel notsolid();
		var_07.enemymodel = spawn("script_model",param_03);
		var_07.enemymodel setmodel(var_09);
		var_07.enemymodel.parentcrate = var_07;
		var_07.enemymodel notsolid();
		var_07.friendlymodel thread deleteonownerdeath(var_07);
		if(level.teambased)
		{
			var_07.friendlymodel thread cratemodelteamupdater(var_07.team,1);
		}
		else
		{
			var_07.friendlymodel thread cratemodelplayerupdater(param_00,1);
		}

		var_07.enemymodel thread deleteonownerdeath(var_07);
		if(level.teambased)
		{
			var_07.enemymodel thread cratemodelteamupdater(level.otherteam[var_07.team],0);
		}
		else
		{
			var_07.enemymodel thread cratemodelplayerupdater(param_00,0);
		}
	}

	var_07.inuse = 0;
	if(param_06)
	{
		var_07 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
	}

	var_07.killcament = spawn("script_model",var_07.origin + (0,0,-200));
	var_07.killcament setscriptmoverkillcam("explosive");
	var_07.killcament setcontents(0);
	var_07.killcament linkto(var_07);
	level.numdropcrates++;
	return var_07;
}

//Function Number: 21
trap_createbombsquadmodel()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 hide();
	var_00 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(self.owner);
	var_00 setmodel("orbital_carepackage_pod_01_ai_bombsquad");
	var_00 linkto(self);
	var_00 setcontents(0);
	self waittill("death");
	var_00 delete();
}

//Function Number: 22
cratesetuphintstrings(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(self.owner))
	{
		self.ownerstringent = spawn("script_model",self.origin + (0,0,60));
		self.ownerstringent setcursorhint("HINT_NOICON");
		self.ownerstringent sethintstring(param_00);
		self.ownerstringent setsecondaryhintstring(param_01);
		self.otherstringent = spawn("script_model",self.origin + (0,0,60));
		self.otherstringent setcursorhint("HINT_NOICON");
		self.otherstringent sethintstring(param_00);
		return;
	}

	self setcursorhint("HINT_NOICON");
	self sethintstring(param_00);
}

//Function Number: 23
onplayerconnecthintstring(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	for(;;)
	{
		level waittill("connected",var_02);
		var_02 thread onplayerspawnedhintstring(param_00,param_01);
	}
}

//Function Number: 24
onplayerspawnedhintstring(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	self waittill("spawned");
	param_00 enableplayeruse(self);
	param_01 disableplayeruse(self);
}

//Function Number: 25
cratesetupforuse(param_00,param_01)
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self waittill("drop_pod_cleared");
	}

	if(isdefined(self.ownerstringent))
	{
		self.ownerstringent makeusable();
		self.otherstringent makeusable();
		foreach(var_03 in level.players)
		{
			if(var_03 != self.owner)
			{
				self.ownerstringent disableplayeruse(var_03);
				self.otherstringent enableplayeruse(var_03);
				continue;
			}

			self.otherstringent disableplayeruse(var_03);
			self.ownerstringent enableplayeruse(var_03);
		}

		thread onplayerconnecthintstring(self.otherstringent,self.ownerstringent);
	}
	else
	{
		self makeusable();
	}

	self.mode = param_00;
	if(self.team == "any")
	{
		var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_05,"invisible",(0,0,0));
		objective_position(var_05,self.origin);
		objective_state(var_05,"active");
		var_06 = "compass_objpoint_ammo_friendly";
		objective_icon(var_05,var_06);
		objective_team(var_05,"none");
		self.objidfriendly = var_05;
	}
	else
	{
		if(level.teambased || isdefined(self.owner))
		{
			var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
			objective_add(var_05,"invisible",(0,0,0));
			objective_position(var_05,self.origin);
			objective_state(var_05,"active");
			var_06 = "compass_objpoint_ammo_friendly";
			if(param_00 == "trap")
			{
				var_06 = "compass_objpoint_trap_friendly";
			}

			objective_icon(var_05,var_06);
			if(!level.teambased && isdefined(self.owner))
			{
				objective_playerteam(var_05,self.owner getentitynumber());
			}
			else
			{
				objective_team(var_05,self.team);
			}

			self.objidfriendly = var_05;
		}

		if(!isdefined(level.ishorde) && level.ishorde)
		{
			if(!isdefined(self.owner) || !isdefined(self.modulehide) && self.modulehide)
			{
				var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
				objective_add(var_05,"invisible",(0,0,0));
				objective_position(var_05,self.origin);
				objective_state(var_05,"active");
				objective_icon(var_05,"compass_objpoint_ammo_enemy");
				if(!level.teambased && isdefined(self.owner))
				{
					objective_playerenemyteam(var_05,self.owner getentitynumber());
				}
				else
				{
					objective_team(var_05,level.otherteam[self.team]);
				}

				self.objidenemy = var_05;
			}
		}
	}

	if(self.team == "any")
	{
		foreach(var_08 in level.teamnamelist)
		{
			if(isdefined(param_01) && isarray(param_01))
			{
				setheadicon_multiple(var_08,param_01);
				continue;
			}

			maps\mp\_entityheadicons::setheadicon(var_08,param_01,(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
		}
	}
	else if(param_00 == "trap")
	{
		thread crateuseteamupdater(maps\mp\_utility::getotherteam(self.team));
	}
	else
	{
		thread crateuseteamupdater();
		var_0A = getstreakforcrate(self.droptype,self.cratetype);
		if(issubstr(var_0A,"juggernaut"))
		{
			foreach(var_03 in level.players)
			{
				if(var_03 maps\mp\_utility::isjuggernaut())
				{
					thread crateusepostjuggernautupdater(var_03);
				}
			}
		}

		if(level.teambased)
		{
			if(isdefined(param_01) && isarray(param_01))
			{
				setheadicon_multiple(self.team,param_01);
			}
			else
			{
				maps\mp\_entityheadicons::setheadicon(self.team,param_01,(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
			}
		}
		else if(isdefined(self.owner))
		{
			if(isdefined(param_01) && isarray(param_01))
			{
				setheadicon_multiple(self.owner,param_01);
			}
			else
			{
				maps\mp\_entityheadicons::setheadicon(self.owner,param_01,(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
			}
		}
	}

	thread crateusejuggernautupdater();
}

//Function Number: 26
setheadicon_multiple(param_00,param_01)
{
	var_02 = 10;
	var_03 = 0;
	self.iconents = [];
	foreach(var_05 in param_01)
	{
		self.iconents[var_05] = common_scripts\utility::spawn_tag_origin();
		self.iconents[var_05] maps\mp\_entityheadicons::setheadicon(param_00,var_05,(0,0,55 + var_03 * var_02),14,14,undefined,undefined,undefined,undefined,undefined,0);
		var_03++;
	}
}

//Function Number: 27
setusablebyteam(param_00)
{
	var_01 = getstreakforcrate(self.droptype,self.cratetype);
	foreach(var_03 in level.players)
	{
		if(issubstr(var_01,"juggernaut") && var_03 maps\mp\_utility::isjuggernaut())
		{
			self disableplayeruse(var_03);
			continue;
		}

		if(!level.teambased && self.mode == "trap")
		{
			if(isdefined(self.owner) && var_03 == self.owner)
			{
				self disableplayeruse(var_03);
			}
			else
			{
				self enableplayeruse(var_03);
			}

			continue;
		}

		if(!isdefined(param_00) || param_00 == var_03.team)
		{
			self enableplayeruse(var_03);
			continue;
		}

		self disableplayeruse(var_03);
	}
}

//Function Number: 28
physicswaiter(param_00,param_01)
{
	self waittill("physics_finished");
	self.droppingtoground = 0;
	self thread [[ level.cratetypes[param_00][param_01].func ]](param_00);
	level thread droptimeout(self,self.owner,param_01);
	var_02 = getentarray("trigger_hurt","classname");
	foreach(var_04 in var_02)
	{
		if(self.friendlymodel istouching(var_04))
		{
			deletecrate();
			return;
		}
	}

	if(isdefined(self.owner) && abs(self.origin[2] - self.owner.origin[2]) > 4000)
	{
		deletecrate();
		return;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		self disconnectpaths();
	}
	else if(isdefined(level.ishorde) && level.ishorde)
	{
		self disconnectpaths();
	}

	var_06 = spawnstruct();
	var_06.deathoverridecallback = ::movingplatformdeathfunc;
	var_06.touchingplatformvalid = ::movingplatformtouchvalid;
	thread maps\mp\_movers::handle_moving_platforms(var_06);
}

//Function Number: 29
movingplatformdeathfunc(param_00)
{
	deletecrate(1,1);
}

//Function Number: 30
movingplatformtouchvalid(param_00)
{
	return carepackageandcarepackagevalid(param_00) && carepackageandgoliathvalid(param_00) && carepackageandplatformvalid(param_00);
}

//Function Number: 31
carepackageandgoliathvalid(param_00)
{
	return !isdefined(self.targetname) || !isdefined(param_00.cratetype) || self.targetname != "care_package" || param_00.cratetype != "juggernaut";
}

//Function Number: 32
carepackageandcarepackagevalid(param_00)
{
	return !isdefined(self.targetname) || !isdefined(param_00.targetname) || self.targetname != "care_package" || param_00.targetname != "care_package";
}

//Function Number: 33
carepackageandplatformvalid(param_00)
{
	return !isdefined(self.targetname) || !isdefined(param_00.carepackagetouchvalid) || self.targetname != "care_package" || !param_00.carepackagetouchvalid;
}

//Function Number: 34
droptimeout(param_00,param_01,param_02)
{
	if(isdefined(level.nocratetimeout) && level.nocratetimeout)
	{
		return;
	}

	level endon("game_ended");
	param_00 endon("death");
	if(param_00.droptype == "nuke_drop")
	{
		return;
	}

	var_03 = 90;
	if(param_02 == "supply")
	{
		var_03 = 20;
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_03);
	while(param_00.curprogress != 0)
	{
		wait(1);
	}

	param_00 deletecrate(1,1);
}

//Function Number: 35
crateothercapturethink(param_00)
{
	self endon("captured");
	var_01 = self;
	if(isdefined(self.otherstringent))
	{
		var_01 = self.otherstringent;
	}

	while(isdefined(self))
	{
		var_01 waittill("trigger",var_02);
		if(isdefined(self.owner) && var_02 == self.owner)
		{
			continue;
		}

		if(var_02 isjumping() || isdefined(var_02.exo_hover_on) && var_02.exo_hover_on)
		{
			continue;
		}

		if(!var_02 isonground() && !waitplayerstuckoncarepackagereturn(var_02))
		{
			continue;
		}

		if(!validateopenconditions(var_02))
		{
			continue;
		}

		var_02.iscapturingcrate = 1;
		var_03 = createuseent();
		var_04 = 0;
		if(self.cratetype == "booby_trap")
		{
			var_04 = var_03 useholdthink(var_02,500,param_00);
		}
		else
		{
			var_04 = var_03 useholdthink(var_02,undefined,param_00);
		}

		if(isdefined(var_03))
		{
			var_03 delete();
		}

		if(!var_04)
		{
			if(isdefined(var_02))
			{
				var_02.iscapturingcrate = 0;
			}

			continue;
		}

		var_02.iscapturingcrate = 0;
		if(isdefined(level.ishorde) && level.ishorde)
		{
			if(self.cratetype == "juggernaut" && !isdefined(var_02.laststand) && var_02.laststand)
			{
				var_02 setdemigod(1);
			}

			if(isdefined(var_02.laststand) && var_02.laststand)
			{
				continue;
			}
		}

		self notify("captured",var_02);
	}
}

//Function Number: 36
crateownercapturethink(param_00)
{
	self endon("captured");
	if(!isdefined(self.owner))
	{
		return;
	}

	self.owner endon("disconnect");
	var_01 = self;
	if(isdefined(self.ownerstringent))
	{
		var_01 = self.ownerstringent;
	}

	var_02 = 500;
	if(isdefined(self.modulepickup) && self.modulepickup)
	{
		var_02 = 100;
	}

	while(isdefined(self))
	{
		var_01 waittill("trigger",var_03);
		if(isdefined(self.owner) && var_03 != self.owner)
		{
			continue;
		}

		if(var_03 isjumping() || isdefined(var_03.exo_hover_on) && var_03.exo_hover_on)
		{
			continue;
		}

		if(!var_03 isonground() && !waitplayerstuckoncarepackagereturn(var_03))
		{
			continue;
		}

		if(!validateopenconditions(var_03))
		{
			continue;
		}

		var_03.iscapturingcrate = 1;
		if(!useholdthink(var_03,var_02,param_00))
		{
			var_03.iscapturingcrate = 0;
			continue;
		}

		var_03.iscapturingcrate = 0;
		if(isdefined(level.ishorde) && level.ishorde)
		{
			if(self.cratetype == "juggernaut" && !isdefined(var_03.laststand) && var_03.laststand)
			{
				var_03 setdemigod(1);
			}

			if(isdefined(var_03.laststand) && var_03.laststand)
			{
				continue;
			}
		}

		self notify("captured",var_03);
	}
}

//Function Number: 37
waitplayerstuckoncarepackagereturn(param_00)
{
	if(param_00 isonground())
	{
		return 0;
	}

	var_01 = 200;
	var_02 = param_00.origin;
	var_03 = gettime();
	while(isdefined(param_00) && maps\mp\_utility::isreallyalive(param_00) && !param_00 isonground() && var_02 == param_00.origin && param_00 usebuttonpressed())
	{
		var_04 = gettime() - var_03;
		if(var_04 >= var_01)
		{
			return 1;
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 38
validateopenconditions(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(issubstr(var_01,"turrethead"))
	{
		return 1;
	}

	if(!param_00 maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon())
	{
		return 0;
	}

	if(isdefined(param_00.changingweapon) && !param_00 maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon())
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
killstreakcratethink(param_00)
{
	self endon("death");
	var_01 = getstreakforcrate(param_00,self.cratetype);
	var_02 = getmodulesforcrate(param_00,self.cratetype);
	var_03 = isdefined(self.owner) && self.owner maps\mp\_utility::_hasperk("specialty_highroller") || isdefined(self.moduleroll) && self.moduleroll;
	var_04 = undefined;
	if(var_03)
	{
		var_04 = &"MP_PACKAGE_REROLL";
	}

	var_05 = undefined;
	if(isdefined(game["strings"][param_00 + self.cratetype + "_hint"]))
	{
		var_05 = game["strings"][param_00 + self.cratetype + "_hint"];
	}
	else
	{
		var_05 = &"PLATFORM_GET_KILLSTREAK";
	}

	cratesetuphintstrings(var_05,var_04);
	cratesetupforuse("all",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_01,var_02));
	if(isdefined(self.owner))
	{
		thread crateothercapturethink();
	}

	thread crateownercapturethink();
	if(var_03)
	{
		thread crateownerdoubletapthink();
	}

	if(self.istrap)
	{
		cratetrapsetupkillcam();
	}

	for(;;)
	{
		self waittill("captured",var_06);
		var_01 = getstreakforcrate(param_00,self.cratetype);
		var_02 = getmodulesforcrate(param_00,self.cratetype);
		if(isdefined(self.owner) && var_06 != self.owner)
		{
			if(!level.teambased || var_06.team != self.team)
			{
				if(self.istrap)
				{
					var_06 thread detonatetrap(self,self.owner);
					return;
				}
				else
				{
					var_06 thread maps\mp\_events::hijackerevent(self.owner);
				}
			}
			else
			{
				self.owner thread maps\mp\_events::sharedevent();
			}
		}

		var_06 playlocalsound("orbital_pkg_use");
		var_07 = var_06 maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex(var_01,0);
		var_06 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_01,undefined,undefined,var_02,var_07);
		var_06 thread maps\mp\killstreaks\_killstreaks::givekillstreak(var_01,0,0,self.owner,var_02);
		if(isdefined(level.mapkillstreak) && level.mapkillstreak == self.cratetype)
		{
			var_06 thread maps\mp\_events::mapkillstreakevent();
		}

		var_08 = 1;
		var_09 = var_06 maps\mp\_utility::_hasperk("specialty_highroller") && !level.teambased || var_06.team != self.team;
		var_0A = isdefined(self.moduletrap) && self.moduletrap;
		var_0B = var_0A && self.owner == var_06 || level.teambased && var_06.team == self.team;
		if(var_09 || var_0B)
		{
			var_0C = var_06 createairdropcrate(var_06,"booby_trap","booby_trap",self.origin,self.angles);
			if(isdefined(var_0C.enemymodel))
			{
				var_0C.enemymodel thread maps\mp\killstreaks\_orbital_carepackage::orbitalanimate(1);
			}

			var_0C thread boobytrapcratethink(self);
			level thread droptimeout(var_0C,var_0C.owner,var_0C.cratetype);
			var_08 = 0;
			if(isdefined(var_0C.friendlymodel))
			{
				var_0C.friendlymodel solid();
			}

			if(isdefined(var_0C.enemymodel))
			{
				var_0C.enemymodel solid();
			}
		}

		deletecrate(var_08);
	}
}

//Function Number: 40
detonatetrap(param_00,param_01)
{
	param_00 endon("death");
	var_02 = param_00.origin + (0,0,50);
	if(level.teambased)
	{
		param_00 maps\mp\_entityheadicons::setheadicon(self.team,"specialty_trap_crate",(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
	}
	else
	{
		param_00 maps\mp\_entityheadicons::setheadicon(self,"specialty_trap_crate",(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
	}

	thread common_scripts\utility::play_sound_in_space("orbital_pkg_trap_armed",var_02);
	wait(1);
	var_03 = var_02 + (0,0,1) - var_02;
	playfx(common_scripts\utility::getfx("airdrop_crate_trap_explode"),var_02,var_03);
	thread common_scripts\utility::play_sound_in_space("orbital_pkg_trap_detonate",var_02);
	if(isdefined(param_00.friendlymodel))
	{
		param_00.friendlymodel notsolid();
	}

	if(isdefined(param_00.enemymodel))
	{
		param_00.enemymodel notsolid();
	}

	if(isdefined(param_01))
	{
		param_00.trapkillcament radiusdamage(var_02,400,300,50,param_01,"MOD_EXPLOSIVE","airdrop_trap_explosive_mp");
	}
	else
	{
		param_00.trapkillcament radiusdamage(var_02,400,300,50,undefined,"MOD_EXPLOSIVE","airdrop_trap_explosive_mp");
	}

	param_00 deletecrate();
}

//Function Number: 41
deletecrate(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}

	if(isdefined(self.objidenemy))
	{
		maps\mp\_utility::_objective_delete(self.objidenemy);
	}

	if(isdefined(self.trapkillcament))
	{
		self.trapkillcament delete();
	}

	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	if(isdefined(self.ownerstringent))
	{
		self.ownerstringent delete();
	}

	if(isdefined(self.otherstringent))
	{
		self.otherstringent delete();
	}

	if(isdefined(self.droptype))
	{
		if(param_00)
		{
			playfx(common_scripts\utility::getfx("ocp_death"),self.origin);
		}

		if(param_01)
		{
			playsoundatpos(self.origin,"orbital_pkg_self_destruct");
		}
	}

	if(isdefined(self.iconents))
	{
		foreach(var_03 in self.iconents)
		{
			var_03 delete();
		}
	}

	self delete();
}

//Function Number: 42
useholdthink(param_00,param_01,param_02)
{
	if(isplayer(param_00))
	{
		param_00 playerlinkto(self);
	}
	else
	{
		param_00 linkto(self);
	}

	param_00 playerlinkedoffsetenable();
	if(!param_00 maps\mp\_utility::isjuggernaut())
	{
		param_00 common_scripts\utility::_disableweapon();
	}

	thread useholdthinkplayerreset(param_00);
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(param_01))
	{
		if(param_00 maps\mp\_utility::_hasperk("specialty_unwrapper") && isdefined(param_00.specialty_unwrapper_care_bonus))
		{
			param_01 = param_01 * param_00.specialty_unwrapper_care_bonus;
		}

		if(isdefined(level.podcapturetimemodifier))
		{
			param_01 = param_01 * level.podcapturetimemodifier;
		}

		self.usetime = param_01;
	}
	else if(param_00 maps\mp\_utility::_hasperk("specialty_unwrapper") && isdefined(param_00.specialty_unwrapper_care_bonus))
	{
		self.usetime = 3000 * param_00.specialty_unwrapper_care_bonus;
	}
	else
	{
		self.usetime = 3000;
	}

	if(isplayer(param_00))
	{
		param_00 thread personalusebar(self,param_02);
	}

	var_03 = useholdthinkloop(param_00);
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self notify("useHoldThinkLoopDone");
	self.inuse = 0;
	self.curprogress = 0;
	return var_03;
}

//Function Number: 43
useholdthinkplayerreset(param_00)
{
	param_00 endon("death");
	common_scripts\utility::waittill_any("death","captured","useHoldThinkLoopDone");
	if(isalive(param_00))
	{
		if(!param_00 maps\mp\_utility::isjuggernaut())
		{
			param_00 common_scripts\utility::_enableweapon();
		}

		if(param_00 islinked())
		{
			param_00 unlink();
		}
	}
}

//Function Number: 44
personalusebar(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(param_01))
	{
		iprintlnbold("Fixme @agersant " + param_01);
	}

	self setclientomnvar("ui_use_bar_text",1);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	var_02 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && param_00.inuse && !level.gameended)
	{
		if(var_02 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			if(param_00.userate > 0)
			{
				var_03 = gettime();
				var_04 = param_00.curprogress / param_00.usetime;
				var_05 = var_03 + 1 - var_04 * param_00.usetime / param_00.userate;
				self setclientomnvar("ui_use_bar_end_time",int(var_05));
			}

			var_02 = param_00.userate;
		}

		wait(0.05);
	}

	self setclientomnvar("ui_use_bar_end_time",0);
}

//Function Number: 45
ishordelaststand(param_00)
{
	return isdefined(level.ishorde) && level.ishorde && isdefined(param_00.laststand) && param_00.laststand;
}

//Function Number: 46
useholdthinkloop(param_00)
{
	param_00 endon("stop_useHoldThinkLoop");
	while(!level.gameended && isdefined(self) && maps\mp\_utility::isreallyalive(param_00) && !ishordelaststand(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 47
isairdropmarker(param_00)
{
	switch(param_00)
	{
		case "airdrop_mp":
		case "airdrop_marker_mp":
			break;

		default:
			break;
	}
}

//Function Number: 48
createuseent()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.curprogress = 0;
	var_00.usetime = 0;
	var_00.userate = 3000;
	var_00.inuse = 0;
	var_00 thread deleteuseent(self);
	return var_00;
}

//Function Number: 49
deleteuseent(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 50
crateownerdoubletapthink()
{
	self.packageholdtimer = 0;
	self.packagesingletapped = 0;
	while(!level.gameended && isdefined(self))
	{
		if(maps\mp\_utility::isreallyalive(self.owner) && distancesquared(self.origin,self.owner.origin) < 10000)
		{
			if(self.owner usebuttonpressed())
			{
				self.packageholdtimer++;
				continue;
			}

			if(self.packageholdtimer > 0)
			{
				if(self.packageholdtimer < 5)
				{
					if(self.packagesingletapped == 1)
					{
						self notify("package_double_tap");
						var_00 = self.cratetype;
						var_01 = 0;
						while(self.cratetype == var_00 && var_01 < 100)
						{
							var_01++;
							self.cratetype = getrandomcratetype(self.droptype);
						}

						var_02 = getstreakforcrate(self.droptype,self.cratetype);
						var_03 = getmodulesforcrate(self.droptype,self.cratetype);
						var_04 = game["strings"][self.droptype + self.cratetype + "_hint"];
						if(!isdefined(var_04))
						{
							var_04 = &"PLATFORM_GET_KILLSTREAK";
						}

						if(isdefined(self.ownerstringent))
						{
							self.ownerstringent sethintstring(var_04);
							self.otherstringent sethintstring(var_04);
							self.ownerstringent setsecondaryhintstring("");
						}
						else
						{
							self sethintstring(var_04);
							self setsecondaryhintstring("");
						}

						if(level.teambased)
						{
							maps\mp\_entityheadicons::setheadicon(self.team,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_02,var_03),(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
						}
						else if(isdefined(self.owner))
						{
							maps\mp\_entityheadicons::setheadicon(self.owner,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_02,var_03),(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
						}

						self.owner playlocalsound("orbital_pkg_reroll");
						return 1;
					}
					else
					{
						self.packagesingletapped = 1;
						thread tappackagethink();
					}
				}

				self.packageholdtimer = 0;
			}
		}

		wait(0.05);
	}
}

//Function Number: 51
tappackagethink()
{
	level endon("game_ended");
	self endon("death");
	self endon("package_double_tap");
	wait(0.2);
	self.packagesingletapped = 0;
}

//Function Number: 52
boobytrapcratethink(param_00)
{
	self endon("death");
	var_01 = getstreakforcrate(param_00.droptype,param_00.cratetype);
	var_02 = getmodulesforcrate(param_00.droptype,param_00.cratetype);
	var_03 = maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_01,var_02);
	var_04 = undefined;
	if(isdefined(game["strings"][param_00.droptype + param_00.cratetype + "_hint"]))
	{
		var_04 = game["strings"][param_00.droptype + param_00.cratetype + "_hint"];
	}
	else
	{
		var_04 = &"PLATFORM_GET_KILLSTREAK";
	}

	cratesetuphintstrings(var_04);
	cratesetupforuse("trap",var_03);
	cratetrapsetupkillcam();
	thread crateothercapturethink(param_00);
	for(;;)
	{
		self waittill("captured",var_05);
		var_05 thread detonatetrap(self,self.owner);
	}
}

//Function Number: 53
cratetrapsetupkillcam(param_00)
{
	var_01 = bullettrace(self.origin,self.origin + (0,0,90),0,self);
	self.trapkillcament = spawn("script_model",var_01["position"]);
	self.trapkillcament setcontents(0);
	self.trapkillcament setscriptmoverkillcam("large explosive");
}

//Function Number: 54
tryusereinforcementcommon(param_00,param_01,param_02)
{
	return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(param_00,"airdrop_reinforcement_common",param_02);
}

//Function Number: 55
tryusereinforcementuncommon(param_00,param_01,param_02)
{
	return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(param_00,"airdrop_reinforcement_uncommon",param_02);
}

//Function Number: 56
tryusereinforcementrare(param_00,param_01,param_02)
{
	return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(param_00,"airdrop_reinforcement_rare",param_02);
}

//Function Number: 57
tryusereinforcementpractice(param_00,param_01,param_02)
{
	return maps\mp\killstreaks\_orbital_carepackage::tryuseorbitalcarepackage(param_00,"airdrop_reinforcement_practice",param_02);
}

//Function Number: 58
reinforcementcratekillstreakthink(param_00)
{
	killstreakcratethink(param_00);
}

//Function Number: 59
reinforcementcratespecialtythink(param_00)
{
	self endon("death");
	var_01 = getperkforcrate(param_00,self.cratetype);
	var_02 = undefined;
	if(param_00 == "airdrop_reinforcement_rare")
	{
		var_02 = getsecondaryperkforcrate(param_00);
	}

	var_03 = undefined;
	if(isdefined(var_02))
	{
		var_04 = game["strings"][param_00 + self.cratetype + "_hint"];
		var_05 = getsecondaryperkhintfromperkref(var_02);
		if(isdefined(var_04) && isdefined(var_05))
		{
			self setreinforcementhintstrings(var_04,var_05);
		}
		else
		{
			cratesetuphintstrings(&"MP_PERK_PICKUP_GENERIC_MULTIPLE");
		}

		var_03 = [];
		var_03[0] = getperkcrateicon(var_01);
		if(!isdefined(var_03[0]))
		{
			var_03[0] = "";
		}

		var_03[1] = getperkcrateicon(var_02);
		if(!isdefined(var_03[1]))
		{
			var_03[1] = "";
		}
	}
	else
	{
		var_04 = game["strings"][var_01 + self.cratetype + "_hint"];
		if(isdefined(var_04))
		{
			self setreinforcementhintstrings(var_04);
		}
		else
		{
			cratesetuphintstrings(&"MP_PERK_PICKUP_GENERIC");
		}

		var_03 = getperkcrateicon(var_01);
		if(!isdefined(var_03))
		{
			var_03 = "";
		}
	}

	cratesetupforuse("all",var_03);
	if(isdefined(self.owner))
	{
		thread crateothercapturethink();
	}

	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_06);
		if(isdefined(self.owner) && var_06 != self.owner)
		{
			if(!level.teambased || var_06.team != self.team)
			{
				var_06 thread maps\mp\_events::hijackerevent(self.owner);
			}
			else
			{
				self.owner thread maps\mp\_events::sharedevent();
			}
		}

		var_06 playlocalsound("orbital_pkg_use");
		var_06 apply_reinforcement_perk(var_01);
		var_07 = int(tablelookuprownum("mp/perktable.csv",1,var_01));
		var_06 setclientomnvar("ui_reinforcement_active_perk_1",var_07);
		if(isdefined(var_02))
		{
			var_06 apply_reinforcement_perk(var_02);
			var_07 = int(tablelookuprownum("mp/perktable.csv",1,var_02));
			var_06 setclientomnvar("ui_reinforcement_active_perk_2",var_07);
		}
		else
		{
			var_06 setclientomnvar("ui_reinforcement_active_perk_2",-1);
		}

		deletecrate(1);
	}
}

//Function Number: 60
getperkforcrate(param_00,param_01)
{
	if(isdefined(level.cratetypes[param_00][param_01].streakref))
	{
		return level.cratetypes[param_00][param_01].streakref;
	}

	return param_01;
}

//Function Number: 61
getsecondaryperkforcrate(param_00)
{
	if(isdefined(level.cratetypes[param_00]) && isdefined(level.cratetypes[param_00][self.cratetype]))
	{
		var_01 = [];
		foreach(var_03 in level.cratetypes[param_00])
		{
			if(!issubstr(var_03.streakref,"specialty_"))
			{
				var_01[var_01.size] = var_03.type;
			}
		}

		var_01[var_01.size] = self.cratetype;
		var_05 = getrandomcratetype(param_00,var_01);
		if(isdefined(var_05) && isdefined(level.cratetypes[param_00][var_05].streakref))
		{
			return level.cratetypes[param_00][var_05].streakref;
		}
	}

	return undefined;
}

//Function Number: 62
getsecondaryperkhintfromperkref(param_00)
{
	var_01 = undefined;
	if(isdefined(level.secondaryreinforcementhinttext[param_00]))
	{
		var_01 = level.secondaryreinforcementhinttext[param_00];
	}

	return var_01;
}

//Function Number: 63
getperkcrateicon(param_00)
{
	var_01 = "mp/perktable.csv";
	var_02 = 1;
	var_03 = 11;
	return tablelookup(var_01,var_02,param_00,var_03);
}

//Function Number: 64
apply_reinforcement_perk(param_00)
{
	self.reinforcementperks[param_00] = 1;
	if(param_00 == "specialty_extended_battery")
	{
		maps\mp\_utility::giveperk("specialty_extended_battery",0);
		maps\mp\_utility::giveperk("specialty_exo_slamboots",0);
		return;
	}

	if(param_00 == "specialty_class_lowprofile")
	{
		maps\mp\_utility::giveperk("specialty_radarimmune",0);
		maps\mp\_utility::giveperk("specialty_exoping_immune",0);
		return;
	}

	if(param_00 == "specialty_class_flakjacket")
	{
		maps\mp\_utility::giveperk("specialty_hard_shell",0);
		maps\mp\_utility::giveperk("specialty_throwback",0);
		maps\mp\_utility::giveperk("_specialty_blastshield",0);
		self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale",45) / 100;
		if(isdefined(level.hardcoremode) && level.hardcoremode)
		{
			self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC",90) / 100;
		}

		return;
	}

	if(param_00 == "specialty_class_lightweight")
	{
		maps\mp\_utility::giveperk("specialty_lightweight",0);
		return;
	}

	if(param_00 == "specialty_class_dangerclose")
	{
		maps\mp\_utility::giveperk("specialty_explosivedamage",0);
		return;
	}

	if(param_00 == "specialty_class_blindeye")
	{
		maps\mp\_utility::giveperk("specialty_blindeye",0);
		maps\mp\_utility::giveperk("specialty_plainsight",0);
		return;
	}

	if(param_00 == "specialty_class_coldblooded")
	{
		maps\mp\_utility::giveperk("specialty_coldblooded",0);
		maps\mp\_utility::giveperk("specialty_spygame",0);
		maps\mp\_utility::giveperk("specialty_heartbreaker",0);
		return;
	}

	if(param_00 == "specialty_class_peripherals")
	{
		maps\mp\_utility::giveperk("specialty_moreminimap",0);
		maps\mp\_utility::giveperk("specialty_silentkill",0);
		return;
	}

	if(param_00 == "specialty_class_fasthands")
	{
		maps\mp\_utility::giveperk("specialty_quickswap",0);
		maps\mp\_utility::giveperk("specialty_fastoffhand",0);
		maps\mp\_utility::giveperk("specialty_sprintreload",0);
		return;
	}

	if(param_00 == "specialty_class_dexterity")
	{
		maps\mp\_utility::giveperk("specialty_sprintfire",0);
		return;
	}

	if(param_00 == "specialty_class_hardwired")
	{
		maps\mp\_utility::giveperk("specialty_empimmune",0);
		maps\mp\_utility::giveperk("specialty_stun_resistance",0);
		self.stunscaler = 0.1;
		return;
	}

	if(param_00 == "specialty_class_toughness")
	{
		self setviewkickscale(0.2);
		return;
	}

	if(param_00 == "specialty_class_scavenger")
	{
		self.ammopickup_scalar = 0.2;
		maps\mp\_utility::giveperk("specialty_scavenger",0);
		maps\mp\_utility::giveperk("specialty_bulletresupply",0);
		maps\mp\_utility::giveperk("specialty_extraammo",0);
		return;
	}

	if(param_00 == "specialty_class_hardline")
	{
		maps\mp\_utility::giveperk("specialty_hardline",0);
		maps\mp\killstreaks\_killstreaks::updatestreakcount();
	}
}