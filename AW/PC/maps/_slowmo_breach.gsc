/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _slowmo_breach.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 130
 * Decompile Time: 1875 ms
 * Timestamp: 4/22/2024 2:22:46 AM
*******************************************************************/

//Function Number: 1
slowmo_breach_init()
{
	level.last_player_damage = 0;
	level.slomobreachduration = 3.5;
	level.breachenemies_active = 0;
	level.breachignoreenemy_count = 0;
	level.player_one_already_breached = undefined;
	level.breachenemies_alive = 0;
	level.has_special_breach_anim = [];
	level.breach_passive_time = 0;
	slomo_sound_scale_setup();
	setdvarifuninitialized("breach_debug","0");
	setdvarifuninitialized("breach_requires_friendlies_in_position","1");
	setdvarifuninitialized("hostage_missionfail","0");
	precacheitem("usp_scripted");
	precacheshader("breach_icon");
	precachemodel("weapon_parabolic_knife");
	precachestring(&"SCRIPT_WAYPOINT_BREACH");
	precachestring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
	precachestring(&"SCRIPT_BREACH_NEED_PLAYER");
	precachestring(&"SCRIPT_BREACH_NEED_FRIENDLY");
	precachestring(&"SCRIPT_BREACH_TOO_MANY_ENEMIES");
	precachestring(&"SCRIPT_BREACH_ILLEGAL_WEAPON");
	precachestring(&"SCRIPT_BREACH_PARTNER_NOT_READY");
	precachestring(&"SCRIPT_BREACH_YOU_NOT_READY");
	precachestring(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE_THROUGH_ENEMY");
	precachestring(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE");
	precachestring(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED");
	precachestring(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR");
	precachestring(&"SCRIPT_BREACH_RELOADING");
	level._slowmo_functions = [];
	level._effect["breach_door"] = loadfx("vfx/explosion/breach_door");
	level._effect["breach_room"] = loadfx("vfx/explosion/breach_room");
	level._effect["breach_room_residual"] = loadfx("vfx/explosion/breach_room_residual");
	level._effect["breach_knife_execution"] = loadfx("vfx/blood/blood_hit_knife");
	script_models();
	player_animations();
	friendly_animations();
	breach_anims();
	create_slowmo_breaches_from_entities();
	var_00 = getentarray("trigger_multiple_breachIcon","classname");
	common_scripts\utility::array_thread(var_00,::icon_trigger_setup);
	var_01 = getentarray("breach_solid_delete","targetname");
	common_scripts\utility::array_call(var_01,::connectpaths);
	common_scripts\utility::array_thread(var_01,::maps\_utility::self_delete);
	var_01 = getentarray("breach_delete","targetname");
	common_scripts\utility::array_thread(var_01,::maps\_utility::self_delete);
	var_02 = getentarray("breach_fx","targetname");
	common_scripts\utility::array_thread(var_02,::breach_fx_setup);
	level.has_special_breach_anim["aa12"] = 1;
	level.has_special_breach_anim["aa12_reflex"] = 1;
	level.has_special_breach_anim["aug_reflex"] = 1;
	level.has_special_breach_anim["aug_scope"] = 1;
	level.has_special_breach_anim["barrett"] = 1;
	level.has_special_breach_anim["beretta"] = 1;
	level.has_special_breach_anim["beretta393"] = 1;
	level.has_special_breach_anim["cheytac_silencer"] = 1;
	level.has_special_breach_anim["fal"] = 1;
	level.has_special_breach_anim["fal_acog"] = 1;
	level.has_special_breach_anim["fal_reflex"] = 1;
	level.has_special_breach_anim["fal_shotgun"] = 1;
	level.has_special_breach_anim["fal_shotgun_attach"] = 1;
	level.has_special_breach_anim["famas"] = 1;
	level.has_special_breach_anim["famas_arctic"] = 1;
	level.has_special_breach_anim["famas_arctic_eotech"] = 1;
	level.has_special_breach_anim["famas_arctic_reflex"] = 1;
	level.has_special_breach_anim["famas_mp2"] = 1;
	level.has_special_breach_anim["famas_shotgun"] = 1;
	level.has_special_breach_anim["famas_shotgun_attach"] = 1;
	level.has_special_breach_anim["famas_woodland"] = 1;
	level.has_special_breach_anim["famas_woodland_eotech"] = 1;
	level.has_special_breach_anim["famas_woodland_acog"] = 1;
	level.has_special_breach_anim["famas_woodland_reflex"] = 1;
	level.has_special_breach_anim["famas_woodland_shotgun"] = 1;
	level.has_special_breach_anim["famas_woodland_shotgun_attach"] = 1;
	level.has_special_breach_anim["fn2000"] = 1;
	level.has_special_breach_anim["fn2000_acog"] = 1;
	level.has_special_breach_anim["fn2000_eotech"] = 1;
	level.has_special_breach_anim["fn2000_reflex"] = 1;
	level.has_special_breach_anim["fn2000_scope"] = 1;
	level.has_special_breach_anim["fn2000_shotgun"] = 1;
	level.has_special_breach_anim["fn2000_shotgun_attach"] = 1;
	level.has_special_breach_anim["fn2000_silencer"] = 1;
	level.has_special_breach_anim["fn2000_thermal"] = 1;
	level.has_special_breach_anim["glock"] = 1;
	level.has_special_breach_anim["kriss"] = 1;
	level.has_special_breach_anim["kriss_reflex"] = 1;
	level.has_special_breach_anim["kriss_acog_silencer"] = 1;
	level.has_special_breach_anim["m1014"] = 1;
	level.has_special_breach_anim["m14_scoped"] = 1;
	level.has_special_breach_anim["m14_scoped_arctic"] = 1;
	level.has_special_breach_anim["m14_scoped_ghil"] = 1;
	level.has_special_breach_anim["m14_scoped_silencer"] = 1;
	level.has_special_breach_anim["m14_scoped_silencer_woodland"] = 1;
	level.has_special_breach_anim["m14_scoped_woodland"] = 1;
	level.has_special_breach_anim["m14ebr"] = 1;
	level.has_special_breach_anim["m14ebr_thermal"] = 1;
	level.has_special_breach_anim["m203"] = 1;
	level.has_special_breach_anim["m16_acog"] = 1;
	level.has_special_breach_anim["m16_basic"] = 1;
	level.has_special_breach_anim["m16_grenadier"] = 1;
	level.has_special_breach_anim["m16_reflex"] = 1;
	level.has_special_breach_anim["m16_silencer"] = 1;
	level.has_special_breach_anim["m21_baseasset"] = 1;
	level.has_special_breach_anim["m21_scoped_arctic_silenced"] = 1;
	level.has_special_breach_anim["mp5"] = 1;
	level.has_special_breach_anim["mp5_arctic"] = 1;
	level.has_special_breach_anim["mp5_arctic_reflex"] = 1;
	level.has_special_breach_anim["mp5_eotech"] = 1;
	level.has_special_breach_anim["mp5_reflex"] = 1;
	level.has_special_breach_anim["mp5_silencer"] = 1;
	level.has_special_breach_anim["mp5_silencer_reflex"] = 1;
	level.has_special_breach_anim["ranger"] = 1;
	level.has_special_breach_anim["striker"] = 1;
	level.has_special_breach_anim["striker_reflex"] = 1;
	level.has_special_breach_anim["striker_woodland"] = 1;
	level.has_special_breach_anim["striker_woodland_reflex"] = 1;
	level.has_special_breach_anim["tavor_acog"] = 1;
	level.has_special_breach_anim["tavor_digital_acog"] = 1;
	level.has_special_breach_anim["tavor_digital_eotech"] = 1;
	level.has_special_breach_anim["tavor_digital_mars"] = 1;
	level.has_special_breach_anim["tavor_digital_reflex"] = 1;
	level.has_special_breach_anim["tavor_eotech"] = 1;
	level.has_special_breach_anim["tavor_mars"] = 1;
	level.has_special_breach_anim["tavor_reflex"] = 1;
	level.has_special_breach_anim["tavor_woodland_acog"] = 1;
	level.has_special_breach_anim["tavor_woodland_eotech"] = 1;
	level.has_special_breach_anim["tavor_woodland_mars"] = 1;
	level.has_special_breach_anim["tavor_woodland_reflex"] = 1;
	level.has_special_breach_anim["tmp"] = 1;
	level.has_special_breach_anim["tmp_reflex"] = 1;
	level.has_special_breach_anim["tmp_silencer"] = 1;
	level.has_special_breach_anim["ump45"] = 1;
	level.has_special_breach_anim["ump45_acog"] = 1;
	level.has_special_breach_anim["ump45_arctic"] = 1;
	level.has_special_breach_anim["ump45_arctic_acog"] = 1;
	level.has_special_breach_anim["ump45_arctic_reflex"] = 1;
	level.has_special_breach_anim["ump45_reflex"] = 1;
	level.has_special_breach_anim["ump45_silencer"] = 1;
	level.has_special_breach_anim["ump45_eotech"] = 1;
	level.has_special_breach_anim["wa2000"] = 1;
	level.has_special_breach_anim["wa2000_thermal"] = 1;
	level.has_special_breach_anim["g36c"] = 1;
	level.has_special_breach_anim["g36c_acog"] = 1;
	level.has_special_breach_anim["g36c_reflex"] = 1;
	level.has_special_breach_anim["g36c_grenadier"] = 1;
	level.has_special_breach_anim["pecheneg"] = 1;
	level.has_special_breach_anim["pecheneg_reflex"] = 1;
	level.has_special_breach_anim["gl_g36c"] = 1;
	level.has_special_breach_anim["m240"] = 1;
	level.has_special_breach_anim["m240_reflex"] = 1;
	level.has_special_breach_anim["m240_acog"] = 1;
	level.has_special_breach_anim["m4_grenadier"] = 1;
	level.has_special_breach_anim["m4_grunt"] = 1;
	level.has_special_breach_anim["m4_grunt_acog"] = 1;
	level.has_special_breach_anim["m4_grunt_reflex"] = 1;
	level.has_special_breach_anim["m4_shotgun"] = 1;
	level.has_special_breach_anim["m4_shotgun_attach"] = 1;
	level.has_special_breach_anim["m4_silencer"] = 1;
	level.has_special_breach_anim["m4_silencer_acog"] = 1;
	level.has_special_breach_anim["alt_m4m203_acog"] = 1;
	level.has_special_breach_anim["m4m203_acog"] = 1;
	level.has_special_breach_anim["alt_m4m203_acog_payback"] = 1;
	level.has_special_breach_anim["m4m203_acog_payback"] = 1;
	level.has_special_breach_anim["m4m203_reflex"] = 1;
	level.has_special_breach_anim["m4m203_reflex_arctic"] = 1;
	level.has_special_breach_anim["m4m203_silencer"] = 1;
	level.has_special_breach_anim["m4m203_silencer_reflex"] = 1;
	level.has_special_breach_anim["m4m203_eotech"] = 1;
	level.has_special_breach_anim["scar_h"] = 1;
	level.has_special_breach_anim["scar_h_fgrip"] = 1;
	level.has_special_breach_anim["scar_h_acog"] = 1;
	level.has_special_breach_anim["scar_h_grenadier"] = 1;
	level.has_special_breach_anim["scar_h_reflex"] = 1;
	level.has_special_breach_anim["scar_h_shotgun"] = 1;
	level.has_special_breach_anim["scar_h_shotgun_attach"] = 1;
	level.has_special_breach_anim["scar_h_silencer"] = 1;
	level.has_special_breach_anim["scar_h_thermal_silencer"] = 1;
	level.has_special_breach_anim["scar_h_thermal"] = 1;
	level.has_special_breach_anim["scar_h_m203"] = 1;
	level.has_special_breach_anim["m203_m4"] = 1;
	level.has_special_breach_anim["m203_m4_acog"] = 1;
	level.has_special_breach_anim["m203_m4_eotech"] = 1;
	level.has_special_breach_anim["m203_m4_reflex"] = 1;
	level.has_special_breach_anim["m203_m4_silencer"] = 1;
	level.has_special_breach_anim["m203_m4_silencer_reflex"] = 1;
	level.has_special_breach_anim["m203_m4_reflex_arctic"] = 1;
	level.has_special_breach_anim["coltanaconda"] = 1;
	level.has_special_breach_anim["deserteagle"] = 1;
	level.has_special_breach_anim["pp2000"] = 1;
	level.has_special_breach_anim["pp2000_reflex"] = 1;
	level.has_special_breach_anim["pp2000_silencer"] = 1;
	level.has_special_breach_anim["pp2000_thermal"] = 1;
	level.has_special_breach_anim["ak47"] = 1;
	level.has_special_breach_anim["ak47_acog"] = 1;
	level.has_special_breach_anim["ak47_arctic"] = 1;
	level.has_special_breach_anim["ak47_arctic_acog"] = 1;
	level.has_special_breach_anim["ak47_arctic_eotech"] = 1;
	level.has_special_breach_anim["ak47_arctic_grenadier"] = 1;
	level.has_special_breach_anim["ak47_arctic_reflex"] = 1;
	level.has_special_breach_anim["ak47_desert"] = 1;
	level.has_special_breach_anim["ak47_desert_acog"] = 1;
	level.has_special_breach_anim["ak47_desert_eotech"] = 1;
	level.has_special_breach_anim["ak47_desert_grenadier"] = 1;
	level.has_special_breach_anim["ak47_desert_reflex"] = 1;
	level.has_special_breach_anim["ak47_digital"] = 1;
	level.has_special_breach_anim["ak47_digital_acog"] = 1;
	level.has_special_breach_anim["ak47_digital_eotech"] = 1;
	level.has_special_breach_anim["ak47_digital_grenadier"] = 1;
	level.has_special_breach_anim["ak47_digital_reflex"] = 1;
	level.has_special_breach_anim["ak47_eotech"] = 1;
	level.has_special_breach_anim["ak47_fall"] = 1;
	level.has_special_breach_anim["ak47_fall_acog"] = 1;
	level.has_special_breach_anim["ak47_fall_eotech"] = 1;
	level.has_special_breach_anim["ak47_fall_grenadier"] = 1;
	level.has_special_breach_anim["ak47_fall_reflex"] = 1;
	level.has_special_breach_anim["ak47_grenadier"] = 1;
	level.has_special_breach_anim["ak47_reflex"] = 1;
	level.has_special_breach_anim["ak47_shotgun"] = 1;
	level.has_special_breach_anim["ak47_shotgun_attach"] = 1;
	level.has_special_breach_anim["ak47_silencer"] = 1;
	level.has_special_breach_anim["ak47_thermal"] = 1;
	level.has_special_breach_anim["ak47_woodland"] = 1;
	level.has_special_breach_anim["ak47_woodland_acog"] = 1;
	level.has_special_breach_anim["ak47_woodland_eotech"] = 1;
	level.has_special_breach_anim["ak47_woodland_grenadier"] = 1;
	level.has_special_breach_anim["ak47_woodland_reflex"] = 1;
	level.has_special_breach_anim["gl_ak47"] = 1;
	level.has_special_breach_anim["gl_ak47_arctic"] = 1;
	level.has_special_breach_anim["masada"] = 1;
	level.has_special_breach_anim["masada_acog"] = 1;
	level.has_special_breach_anim["masada_dcburn_mt_black_off"] = 1;
	level.has_special_breach_anim["masada_dcburn_mt_black_on"] = 1;
	level.has_special_breach_anim["masada_digital"] = 1;
	level.has_special_breach_anim["masada_digital_acog"] = 1;
	level.has_special_breach_anim["masada_digital_eotech"] = 1;
	level.has_special_breach_anim["masada_digital_grenadier_eotech"] = 1;
	level.has_special_breach_anim["gl_masada_digital_eotech"] = 1;
	level.has_special_breach_anim["masada_digital_reflex"] = 1;
	level.has_special_breach_anim["masada_eotech"] = 1;
	level.has_special_breach_anim["masada_grenadier_acog"] = 1;
	level.has_special_breach_anim["masada_reflex"] = 1;
	level.has_special_breach_anim["masada_silencer_motion_tracker_off"] = 1;
	level.has_special_breach_anim["masada_silencer_motion_tracker_on"] = 1;
	level.has_special_breach_anim["masada_silencer_mt_black_off"] = 1;
	level.has_special_breach_anim["masada_silencer_mt_black_on"] = 1;
	level.has_special_breach_anim["masada_silencer_mt_camo_off"] = 1;
	level.has_special_breach_anim["masada_silencer_mt_camo_on"] = 1;
	level.has_special_breach_anim["masada_silencer_mt_dust_off"] = 1;
	level.has_special_breach_anim["masada_silencer_mt_dust_on"] = 1;
	level.has_special_breach_anim["uzi"] = 1;
	level.has_special_breach_anim["uzi_sd"] = 1;
	level.has_special_breach_anim["uzi_silencer"] = 1;
	level.has_special_breach_anim["uzi_akimbo"] = 1;
	level.has_special_breach_anim["p90"] = 1;
	level.has_special_breach_anim["p90_acog"] = 1;
	level.has_special_breach_anim["p90_eotech"] = 1;
	level.has_special_breach_anim["p90_reflex"] = 1;
	level.has_special_breach_anim["p90_silencer"] = 1;
	level.has_special_breach_anim["p90_arctic"] = 1;
	level.has_special_breach_anim["p90_arctic_acog"] = 1;
	level.has_special_breach_anim["p90_arctic_eotech"] = 1;
	level.has_special_breach_anim["p90_arctic_reflex"] = 1;
	level.has_special_breach_anim["rpd"] = 1;
	level.has_special_breach_anim["rpd_acog"] = 1;
	level.has_special_breach_anim["rpd_grip"] = 1;
	level.has_special_breach_anim["rpd_reflex"] = 1;
	level.has_special_breach_anim["sa80"] = 1;
	level.has_special_breach_anim["sa80_scope"] = 1;
	level.has_special_breach_anim["sa80lmg"] = 1;
	level.has_special_breach_anim["sa80lmg_reflex"] = 1;
	level.has_special_breach_anim["sa80lmg_scope"] = 1;
	level.has_special_breach_anim["at4"] = 1;
	level.has_special_breach_anim["at4_straight"] = 1;
	level.has_special_breach_anim["model1887"] = 1;
	level.has_special_breach_anim["usp"] = 1;
	level.has_special_breach_anim["usp_airport"] = 1;
	level.has_special_breach_anim["usp_silencer"] = 1;
	level.has_special_breach_anim["dragunov"] = 1;
	level.has_special_breach_anim["dragunov_arctic"] = 1;
	level.has_special_breach_anim["dragunov_desert"] = 1;
	level.has_special_breach_anim["dragunov_fall"] = 1;
	level.has_special_breach_anim["dragunov_woodland"] = 1;
	level.has_special_breach_anim["mg4"] = 1;
	level.has_special_breach_anim["mg4_acog"] = 1;
	level.has_special_breach_anim["mg4_arctic"] = 1;
	level.has_special_breach_anim["mg4_arctic_reflex"] = 1;
	level.has_special_breach_anim["mg4_arctic_thermal"] = 1;
	level.has_special_breach_anim["mg4_reflex"] = 1;
	level.has_special_breach_anim["mg4_thermal"] = 1;
	level.has_special_breach_anim["spas12"] = 1;
	level.has_special_breach_anim["spas12_arctic"] = 1;
	level.has_special_breach_anim["spas12_arctic_eotech"] = 1;
	level.has_special_breach_anim["spas12_arctic_grip"] = 1;
	level.has_special_breach_anim["spas12_arctic_heartbeat"] = 1;
	level.has_special_breach_anim["spas12_arctic_heartbeat_attach"] = 1;
	level.has_special_breach_anim["spas12_arctic_reflex"] = 1;
	level.has_special_breach_anim["spas12_eotech"] = 1;
	level.has_special_breach_anim["spas12_grip"] = 1;
	level.has_special_breach_anim["spas12_heartbeat"] = 1;
	level.has_special_breach_anim["spas12_heartbeat_attach"] = 1;
	level.has_special_breach_anim["spas12_reflex"] = 1;
	level.has_special_breach_anim["spas12_silencer"] = 1;
	level.has_special_breach_anim["paw20_eotech"] = 1;
	level.has_special_breach_anim["acr_hybrid"] = 1;
	level.has_special_breach_anim["acr_hybrid_silenced"] = 1;
	level.has_special_breach_anim["alt_acr_hybrid"] = 1;
	level.has_special_breach_anim["alt_acr_hybrid_silenced"] = 1;
	level.has_special_breach_anim["p99"] = 1;
	level.has_special_breach_anim["rsass"] = 1;
	level.has_special_breach_anim["fnfiveseven"] = 1;
	level.has_special_breach_anim["pp90m1"] = 1;
	level.has_special_breach_anim["pp90m1_acog"] = 1;
	level.has_special_breach_anim["pp90m1_eotech"] = 1;
	level.has_special_breach_anim["pp90m1_reflex"] = 1;
	level.has_special_breach_anim["pp90m1_silencer"] = 1;
	common_scripts\utility::flag_init("breaching_on");
	common_scripts\utility::flag_init("no_mercy");
}

//Function Number: 2
check_missing_animation()
{
	if(!isdefined(self.animation))
	{
		return;
	}

	if(will_be_manhandled() && self.script_noteworthy == "manhandled")
	{
		var_00 = getent(self.target,"targetname");
		level.manhandled_spawners[self.export] = var_00;
	}

	var_01 = self.script_parameters;
	if(isdefined(var_01))
	{
		level.missing_animation_parameters[var_01] = 1;
	}

	level.missing_animations[self.animation] = 1;
}

//Function Number: 3
is_breach_anim_loop_setup(param_00,param_01,param_02)
{
	if(!isdefined(level.scr_anim["generic"][param_00]))
	{
		return 0;
	}

	if(!isdefined(level.scr_anim["generic"][param_00][param_01]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
is_breach_anim_single_setup(param_00,param_01)
{
	if(!isdefined(level.scr_anim["generic"][param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
dump_missing_anims()
{
	if(!level.missing_animations.size)
	{
		return;
	}

	var_00 = [];
	var_00[var_00.size] = "_survives";
	var_00[var_00.size] = "_death";
	var_00[var_00.size] = "_death2";
	var_00[var_00.size] = "_idle";
	var_00[var_00.size] = "_manhandled_guarded";
	var_00[var_00.size] = "_manhandled";
	var_00[var_00.size] = "_manhandled_guarded_idle";
	var_00[var_00.size] = "_manhandled_idle";
	var_00[var_00.size] = "_manhandled_guarded_prepare_idle";
	var_00[var_00.size] = "_manhandled_prepare_idle";
	var_00[var_00.size] = "_manhandled_guarded_prepare";
	var_00[var_00.size] = "_manhandled_prepare";
	var_01 = [];
	foreach(var_07, var_03 in level.missing_animation_parameters)
	{
		foreach(var_05 in var_00)
		{
			var_01[var_01.size] = var_05 + var_07;
		}
	}

	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_11, var_03 in level.missing_animations)
	{
		var_09 = 0;
		if(isdefined(level.scr_stub["generic"][var_11]))
		{
			if(isarray(level.scr_stub["generic"][var_11]))
			{
				foreach(var_0C, var_0B in level.scr_stub["generic"][var_11])
				{
					if(!is_breach_anim_loop_setup(var_11,var_0C,var_0B))
					{
						var_09 = 1;
					}
				}
			}
			else if(!is_breach_anim_single_setup(var_11,level.scr_stub["generic"][var_11]))
			{
				var_09 = 1;
			}
		}

		foreach(var_05 in var_00)
		{
			var_0E = var_11 + var_05;
			if(!isdefined(level.scr_stub["generic"][var_0E]))
			{
				continue;
			}

			if(isarray(level.scr_stub["generic"][var_0E]))
			{
				foreach(var_0C, var_0B in level.scr_stub["generic"][var_0E])
				{
					if(!is_breach_anim_loop_setup(var_0E,var_0C,var_0B))
					{
						var_09 = 1;
					}
				}

				continue;
			}

			if(!is_breach_anim_single_setup(var_0E,level.scr_stub["generic"][var_0E]))
			{
				var_09 = 1;
			}
		}

		if(var_09)
		{
			level.missing_animations[var_11] = undefined;
		}
	}

	level.missing_animation_parameters = undefined;
	level.missing_animations = undefined;
}

//Function Number: 6
breach_anims()
{
	level.breach_death_anims = [];
	maps\_anim::addnotetrack_attach("generic","attach knife right","weapon_parabolic_knife","TAG_INHAND");
	maps\_anim::addnotetrack_detach("generic","detach knife right","weapon_parabolic_knife","TAG_INHAND","breach_react_knife_charge");
	level.scr_stub["generic"]["takedown_room2B_soldier"] = "takedown_room2B_soldier";
	level.scr_stub["generic"]["takedown_room2B_soldier_idle"][0] = "takedown_room2B_soldier_idle";
	level.scr_stub["generic"]["takedown_room1Alt_soldier"] = "takedown_room1Alt_soldier";
	level.scr_stub["generic"]["takedown_room1Alt_soldier_idle"][0] = "takedown_room1Alt_soldier_idle";
	level.scr_stub["generic"]["takedown_room2A_soldier"] = "takedown_room2A_soldier";
	level.scr_stub["generic"]["takedown_room2A_soldier_idle"][0] = "takedown_room2A_soldier_end_idle";
	level.scr_stub["generic"]["takedown_room1B_soldier"] = "takedown_room1B_soldier";
	level.scr_stub["generic"]["takedown_room1B_soldier_idle"][0] = "takedown_room1B_soldier_idle";
	level.scr_stub["generic"]["takedown_room1A_soldier"] = "takedown_room1A_soldier";
	level.scr_stub["generic"]["takedown_room1A_soldier_idle"][0] = "takedown_room1A_soldier_idle";
	level.scr_stub["generic"]["hostage_chair_twitch2"] = "hostage_chair_twitch2";
	level.scr_stub["generic"]["hostage_chair_twitch2_idle"][0] = "hostage_chair_idle";
	level.scr_stub["generic"]["hostage_chair_twitch"] = "hostage_chair_twitch";
	level.scr_stub["generic"]["hostage_chair_twitch_idle"][0] = "hostage_chair_idle";
	add_slowmo_breach_custom_function("hostage_chair_twitch2",::_slomo_breach_c4_hostage);
	add_slowmo_breach_custom_function("hostage_chair_twitch",::_slomo_breach_c4_hostage);
	level.scr_stub["generic"]["execution_shield_soldier"] = "execution_shield_soldier";
	level.scr_stub["generic"]["execution_shield_hostage"] = "execution_shield_hostage";
	level.scr_stub["generic"]["execution_shield_hostage_death"] = "execution_shield_hostage_death";
	level.scr_stub["generic"]["execution_shield_hostage_survives"] = "execution_shield_hostage_survives";
	level.scr_stub["generic"]["execution_shield_hostage_idle"][0] = "hostage_knees_idle";
	add_slowmo_breach_custom_function("execution_shield_soldier",::_slomo_breach_executioner_pistol);
	add_slowmo_breach_custom_function("execution_shield_hostage",::_slomo_breach_executed_guy);
	level.scr_stub["generic"]["execution_knife_soldier"] = "execution_knife_soldier";
	level.scr_stub["generic"]["execution_knife_hostage"] = "execution_knife_hostage";
	level.scr_stub["generic"]["execution_knife_hostage_death"] = "execution_knife_hostage_death";
	level.scr_stub["generic"]["execution_knife_hostage_idle"][0] = "hostage_knees_idle";
	level.scr_stub["generic"]["execution_knife_hostage_manhandled"] = "takedown_room2B_hostageA";
	level.scr_stub["generic"]["execution_knife_hostage_manhandled_idle"][0] = "takedown_room2B_hostageA_idle";
	add_slowmo_breach_custom_function("execution_knife_hostage",::_slomo_breach_executed_guy);
	add_slowmo_breach_custom_function("execution_knife_soldier",::_slomo_breach_executioner_knife);
	level.scr_stub["generic"]["execution_knife2_soldier"] = "execution_knife2_soldier";
	level.scr_stub["generic"]["execution_knife2_hostage"] = "execution_knife2_hostage";
	level.scr_stub["generic"]["execution_knife2_hostage_death"] = "execution_knife2_hostage_death";
	level.scr_stub["generic"]["execution_knife2_hostage_idle"][0] = "hostage_stand_idle";
	add_slowmo_breach_custom_function("execution_knife2_hostage",::_slomo_breach_executed_guy);
	add_slowmo_breach_custom_function("execution_knife2_soldier",::_slomo_breach_executioner_knife);
	level.scr_stub["generic"]["execution_onknees_soldier"] = "execution_onknees_soldier";
	level.scr_stub["generic"]["execution_onknees_hostage"] = "execution_onknees_hostage";
	level.scr_stub["generic"]["execution_onknees_hostage_idle"][0] = "execution_onknees_hostage_survives";
	level.scr_stub["generic"]["execution_onknees_hostage_death"] = "execution_onknees_hostage_death";
	level.scr_stub["generic"]["execution_onknees_hostage_manhandled_guarded"] = "takedown_room1A_hostageB";
	level.scr_stub["generic"]["execution_onknees_hostage_manhandled_guarded_idle"][0] = "takedown_room1A_hostageB_idle";
	add_slowmo_breach_custom_function("execution_onknees_soldier",::_slomo_breach_executioner_pistol);
	add_slowmo_breach_custom_function("execution_onknees_hostage",::_slomo_breach_executed_guy);
	level.scr_stub["generic"]["execution_onknees2_soldier"] = "execution_onknees2_soldier";
	level.scr_stub["generic"]["execution_onknees2_hostage"] = "execution_onknees2_hostage";
	level.scr_stub["generic"]["execution_onknees2_hostage_survives"] = "execution_onknees2_hostage_survives";
	level.scr_stub["generic"]["execution_onknees2_hostage_death"] = "execution_onknees2_hostage_death";
	level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded"] = "takedown_room2B_hostageB";
	level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded_idle"][0] = "takedown_room2B_hostageB_idle";
	level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded_prepare_idleV2"][0] = "takedown_room2A_hostageB_start_idle";
	level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guardedV2"] = "takedown_room2A_hostageB";
	level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded_idleV2"][0] = "takedown_room2A_hostageB_end_idle";
	add_slowmo_breach_custom_function("execution_onknees2_soldier",::_slomo_breach_executioner_pistol);
	add_slowmo_breach_custom_function("execution_onknees2_hostage",::_slomo_breach_executed_guy_pushed_to_floor);
	level.scr_stub["generic"]["execution_slamwall_soldier"] = "execution_slamwall_soldier";
	level.scr_stub["generic"]["execution_slamwall_hostage"] = "execution_slamwall_hostage";
	level.scr_stub["generic"]["execution_slamwall_hostage_idle"][0] = "hostage_stand_idle";
	level.scr_stub["generic"]["execution_slamwall_hostage_death"] = "execution_slamwall_hostage_death";
	level.scr_stub["generic"]["execution_slamwall_hostage_manhandled_prepare"] = "takedown_room2A_hostageA_flee";
	level.scr_stub["generic"]["execution_slamwall_hostage_manhandled_prepare_idle"][0] = "takedown_room2A_hostageA_hide_idle";
	level.scr_stub["generic"]["execution_slamwall_hostage_manhandled"] = "takedown_room2A_hostageA";
	level.scr_stub["generic"]["execution_slamwall_hostage_manhandled_idle"][0] = "takedown_room2A_hostageA_end_idle";
	add_slowmo_breach_custom_function("execution_slamwall_soldier",::_slomo_breach_executioner_pistol);
	add_slowmo_breach_custom_function("execution_slamwall_hostage",::_slomo_breach_executed_guy);
	level.scr_stub["generic"]["execution_fightback_guy1_03"] = "execution_fightback_guy1_03";
	level.scr_stub["generic"]["execution_fightback_guy2_03"] = "execution_fightback_guy2_03";
	level.scr_stub["generic"]["execution_fightback_guy2_03_death"] = "execution_fightback_guy2_03_death";
	level.scr_stub["generic"]["execution_fightback_guy2_03_survives"] = "execution_fightback_guy2_03_survives";
	add_slowmo_breach_custom_function("execution_fightback_guy1_03",::_slomo_breach_executioner_pistol);
	add_slowmo_breach_custom_function("execution_fightback_guy2_03",::_slomo_breach_executed_guy_pushed_to_floor);
	level.scr_stub["generic"]["patrol_bored_react"] = "patrol_bored_react_walkstop";
	level.scr_stub["generic"]["exposed_idle_react"] = "exposed_idle_reactA";
	level.scr_stub["generic"]["chess_surprise"] = "parabolic_chessgame_surprise_b";
	level.scr_stub["generic"]["breach_chair_reaction_v1"] = "breach_chair_reaction_v1";
	level.scr_stub["generic"]["patrol_bored_react_walkstop"] = "patrol_bored_react_walkstop";
	level.scr_stub["generic"]["exposed_idle_reactA"] = "exposed_idle_reactA";
	level.scr_stub["generic"]["hostage_stand_react_front"] = "hostage_stand_react_front";
	level.scr_stub["generic"]["hostage_stand_react_front_idle"][0] = "hostage_stand_idle";
	level.scr_stub["generic"]["hostage_stand_react_front_manhandled"] = "takedown_room1Alt_hostage";
	level.scr_stub["generic"]["hostage_stand_react_front_manhandled_idle"][0] = "takedown_room1Alt_hostage_idle";
	level.scr_stub["generic"]["death_explosion_stand_B_v3"] = "death_explosion_stand_B_v3";
	level.scr_stub["generic"]["breach_stackL_approach"] = "breach_stackL_approach";
	level.scr_stub["generic"]["react_stand_2_run_R45"] = "react_stand_2_run_R45";
	level.breach_death_anims["death_explosion_stand_B_v3"] = 1;
	add_slowmo_breach_custom_function("hostage_stand_react_front",::_slomo_breach_hostage_react);
	level.scr_stub["generic"]["hostage_stand_fall"] = "hostage_stand_fall";
	level.scr_stub["generic"]["hostage_stand_fall_idle"][0] = "hostage_knees_idle";
	level.scr_stub["generic"]["hostage_stand_fall_idle"][1] = "hostage_knees_twitch";
	level.scr_stub["generic"]["hostage_stand_fall_manhandled"] = "takedown_room1A_hostageA";
	level.scr_stub["generic"]["hostage_stand_fall_manhandled_idle"][0] = "takedown_room1A_hostageA_idle";
	level.scr_stub["generic"]["hostage_stand_fall_manhandledV2"] = "takedown_room1B_hostage";
	level.scr_stub["generic"]["hostage_stand_fall_manhandled_idleV2"][0] = "takedown_room1B_hostage_idle";
	add_slowmo_breach_custom_function("hostage_stand_fall",::_slomo_breach_hostage_react);
	level.scr_stub["generic"]["breach_react_knife_idle"] = "breach_react_knife_idle";
	level.scr_stub["generic"]["breach_react_knife_charge"] = "breach_react_knife_charge";
	level.scr_stub["generic"]["breach_react_knife_charge_death"] = "death_shotgun_back_v1";
	add_slowmo_breach_custom_function("breach_react_knife_charge",::_slomo_breach_knife_charger);
	level.scr_stub["generic"]["breach_react_blowback_v1"] = "breach_react_blowback_v1";
	level.scr_stub["generic"]["breach_react_blowback_v2"] = "breach_react_blowback_v1";
	level.scr_stub["generic"]["breach_react_blowback_v3"] = "breach_react_blowback_v1";
	level.scr_stub["generic"]["dying_crawl_back"] = "dying_crawl_back";
	add_slowmo_breach_custom_function("breach_react_blowback_v1",::_slomo_breach_blowback_guy);
	add_slowmo_breach_custom_function("breach_react_blowback_v2",::_slomo_breach_blowback_guy);
	level.scr_stub["generic"]["breach_react_desk_v1"] = "breach_react_desk_v1";
	level.scr_stub["generic"]["breach_react_desk_v2"] = "breach_react_desk_v2";
	level.scr_stub["generic"]["breach_react_desk_v3"] = "breach_react_desk_v3";
	level.scr_stub["generic"]["breach_react_desk_v4"] = "breach_react_desk_v4";
	level.scr_stub["generic"]["breach_react_desk_v5"] = "breach_react_desk_v5";
	level.scr_stub["generic"]["breach_react_desk_v6"] = "breach_react_desk_v6";
	level.scr_stub["generic"]["breach_react_desk_v7"] = "breach_react_desk_v7";
	add_slowmo_breach_custom_function("breach_react_desk_v7",::_slomo_breach_desk_guy);
	level.scr_stub["generic"]["breach_react_push_guy1"] = "breach_react_push_guy1";
	level.scr_stub["generic"]["breach_react_push_guy2"] = "breach_react_push_guy2";
	level.scr_stub["generic"]["breach_react_guntoss_v1_guy1"] = "breach_react_guntoss_v1_guy1";
	level.scr_stub["generic"]["breach_react_guntoss_v1_guy2"] = "breach_react_guntoss_v1_guy2";
	level.scr_stub["generic"]["breach_react_guntoss_v2_guy1"] = "breach_react_guntoss_v2_guy1";
	level.scr_stub["generic"]["breach_react_guntoss_v2_guy2"] = "breach_react_guntoss_v2_guy2";
	level.scr_stub["generic"]["breach_chair_hide_reaction_v1"] = "breach_chair_hide_reaction_v1";
	level.scr_stub["generic"]["breach_chair_hide_reaction_v1_death"] = "covercrouch_death_1";
	level.scr_stub["generic"]["breach_chair_hide_reaction_v1_death2"] = "covercrouch_death_2";
	level.scr_stub["generic"]["breach_chair_hide_reaction_v2"] = "breach_chair_hide_reaction_v2";
	level.scr_stub["generic"]["breach_chair_hide_reaction_v2_death"] = "breach_chair_hide_reaction_death_v2";
	add_slowmo_breach_custom_function("breach_chair_hide_reaction_v1",::_slomo_breach_chair_guy_normal);
	add_slowmo_breach_custom_function("breach_chair_hide_reaction_v2",::_slomo_breach_chair_guy_animated);
	level.scr_stub["generic"]["execution_fightback_guy1_02"] = "execution_fightback_guy1_02";
	level.scr_stub["generic"]["execution_fightback_guy2_02"] = "execution_fightback_guy2_02";
	level.scr_anim["generic"]["hostage_knees_loop"][0] = %hostage_knees_idle;
	level.scr_anim["generic"]["hostage_knees_loop"][1] = %hostage_knees_twitch;
}

//Function Number: 7
friendly_animations()
{
	level.scr_anim["generic"]["breach_friend_idle_01"][0] = %breach_flash_r1_idle;
	level.scr_anim["generic"]["breach_friend_enter_01"] = %breach_flash_r1_enter;
	level.scr_anim["generic"]["breach_friend_idle_02"][0] = %breach_flash_r2_idle;
	level.scr_anim["generic"]["breach_friend_enter_02"] = %breach_flash_r2_enter;
}

//Function Number: 8
breach_fx_setup()
{
	var_00 = self.script_fxid;
	var_01 = self.script_slowmo_breach;
	var_02 = common_scripts\utility::createexploder(var_00);
	var_02.v["origin"] = self.origin;
	var_02.v["angles"] = self.angles;
	var_02.v["fxid"] = var_00;
	var_02.v["delay"] = 0;
	var_02.v["exploder"] = "breach_" + var_01;
	var_02.v["soundalias"] = "nil";
}

//Function Number: 9
create_slowmo_breaches_from_entities()
{
	var_00 = [];
	var_01 = getentarray("breach_left_org","targetname");
	var_02 = getentarray("breach_right_org","targetname");
	var_03 = getentarray("breach_enemy_spawner","targetname");
	var_04 = getentarray("breach_hostage_spawner","targetname");
	var_05 = getentarray("breach_friendlyenemy_spawner","targetname");
	var_06 = getentarray("breach_friendlyhostage_spawner","targetname");
	var_07 = getentarray("breach_coopenemy_spawner","targetname");
	var_08 = getentarray("breach_coophostage_spawner","targetname");
	var_09 = getentarray("breach_solid","targetname");
	var_0A = getentarray("breach_door_volume","targetname");
	var_0B = getentarray("breach_safe_volume","targetname");
	var_0C = getentarray("trigger_use_breach","classname");
	var_0D = getentarray("trigger_multiple_breachIcon","classname");
	var_0E = getentarray("trigger_use_breach","classname");
	var_0F = getentarray("breach_damage_trigger","targetname");
	level.scr_stub = undefined;
	foreach(var_11 in var_01)
	{
		var_12 = var_11.script_slowmo_breach;
		var_13 = "wood";
		if(isdefined(var_11.script_slowmo_breach_doortype))
		{
			switch(var_11.script_slowmo_breach_doortype)
			{
				case "payback_wood":
				case "caves_wood":
				case "estate_wood_backwards":
				case "estate_wood":
				case "metal":
				case "wood":
				case "none":
					var_13 = var_11.script_slowmo_breach_doortype;
					break;

				default:
					break;
			}
		}

		var_14 = spawnstruct();
		var_14.left_post = var_11;
		var_14.doortype = var_13;
		var_14.spawners = [];
		var_14.spawners["enemy"] = [];
		var_14.spawners["hostage"] = [];
		var_14.spawners["friendlyenemy"] = [];
		var_14.spawners["friendlyhostage"] = [];
		var_14.spawners["coopenemy"] = [];
		var_14.spawners["coophostage"] = [];
		var_14.lookat_triggers = [];
		var_14.path_solids = [];
		var_14.enabled = 1;
		var_14.door_volume = [];
		var_14.room_volume = [];
		var_14.safe_volume = undefined;
		var_14.friendly_anim_ent = [];
		var_00[var_12] = var_14;
	}

	foreach(var_11 in var_02)
	{
		var_12 = var_11.script_slowmo_breach;
		var_00[var_12].right_post = var_11;
		var_17 = spawn("script_origin",var_11.origin);
		var_17.angles = var_11.angles;
		var_14 = spawnstruct();
		var_14.entity = var_17;
		var_14.yaw = -90;
		var_14 maps\_utility::translate_local();
		var_00[var_12].friendly_anim_ent = var_17;
	}

	foreach(var_1A in var_03)
	{
		var_00 = var_1A breach_spawner_setup(var_00,"enemy");
	}

	foreach(var_1A in var_04)
	{
		var_00 = var_1A breach_spawner_setup(var_00,"hostage");
	}

	foreach(var_1A in var_05)
	{
		var_00 = var_1A breach_spawner_setup(var_00,"friendlyenemy");
	}

	foreach(var_1A in var_06)
	{
		var_00 = var_1A breach_spawner_setup(var_00,"friendlyhostage");
	}

	foreach(var_1A in var_07)
	{
		var_00 = var_1A breach_spawner_setup(var_00,"coopenemy");
	}

	foreach(var_1A in var_08)
	{
		var_00 = var_1A breach_spawner_setup(var_00,"coophostage");
	}

	foreach(var_27 in var_0D)
	{
		var_12 = var_27.script_slowmo_breach;
		var_00[var_12].lookat_triggers[var_00[var_12].lookat_triggers.size] = var_27;
		var_28 = getent(var_27.target,"targetname");
		var_27.breach_origin = var_28.origin;
		var_29 = getent(var_28.target,"targetname");
		var_29.breached = 0;
		var_00[var_12].room_volume = var_29;
		var_28 thread breach_icon_think(var_27,var_12,var_29);
		var_2A = var_29.script_flag;
		common_scripts\utility::flag_init(var_2A);
	}

	foreach(var_27 in var_0E)
	{
		var_27 usetriggerrequirelookat();
		var_12 = var_27.script_slowmo_breach;
		var_00[var_12].trigger = var_27;
		if(isdefined(var_27.script_breachgroup))
		{
			var_27 thread breach_group_trigger_think();
		}
	}

	foreach(var_2F in var_0A)
	{
		var_12 = var_2F.script_slowmo_breach;
		var_00[var_12].door_volume = var_2F;
	}

	foreach(var_2F in var_0B)
	{
		var_12 = var_2F.script_slowmo_breach;
		var_00[var_12].safe_volume = var_2F;
	}

	foreach(var_34 in var_09)
	{
		var_12 = var_34.script_slowmo_breach;
		var_00[var_12].path_solids[var_00[var_12].path_solids.size] = var_34;
	}

	foreach(var_12, var_37 in var_00)
	{
		level thread slowmo_breach_think(var_37,var_12);
	}

	foreach(var_27 in var_0F)
	{
		var_12 = var_27.script_slowmo_breach;
		var_27 thread slowmo_breach_damage_trigger_think(var_12);
	}

	level.breach_groups = var_00;
}

//Function Number: 10
objective_breach(param_00,param_01,param_02,param_03,param_04)
{
	objective_setpointertextoverride(param_00,&"SCRIPT_WAYPOINT_BREACH");
	objective_position(param_00,(0,0,0));
	var_05 = [];
	if(isdefined(param_01))
	{
		var_05[var_05.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_05[var_05.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_05[var_05.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_05[var_05.size] = param_04;
	}

	var_06 = 0;
	foreach(var_08 in var_05)
	{
		var_09 = level.breach_groups[var_08].left_post;
		if(!isdefined(var_09))
		{
			return;
		}

		var_0A = anglestoright(var_09.angles);
		var_0B = var_09.origin + var_0A * -22.5 + (0,0,56);
		objective_additionalposition(param_00,var_06,var_0B);
		var_06++;
	}
}

//Function Number: 11
assign_script_breachgroup_to_ents(param_00)
{
	foreach(var_02 in param_00)
	{
		var_03 = 0;
		foreach(var_09, var_05 in level.breach_groups)
		{
			foreach(var_07 in var_05.lookat_triggers)
			{
				if(distance(var_02.origin,var_07.breach_origin) > 80)
				{
					continue;
				}

				var_02.script_slowmo_breach = var_09;
				var_03 = 1;
				break;
			}

			if(var_03)
			{
				break;
			}
		}
	}
}

//Function Number: 12
get_breach_indices_from_ents(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03.script_slowmo_breach;
	}

	return var_01;
}

//Function Number: 13
slowmo_breach_damage_trigger_think(param_00)
{
	level waittill("breaching_number_" + param_00);
	wait(3);
	var_01 = getaiarray();
	var_01 = maps\_utility::array_merge(var_01,level.players);
	foreach(var_03 in var_01)
	{
		if(var_03 istouching(self))
		{
			return;
		}
	}

	radiusdamage(self.origin,self.radius,500,500);
	self delete();
}

//Function Number: 14
icon_trigger_setup()
{
	self.script_flag = "breach_door_icon_" + self.script_slowmo_breach;
	level thread maps\_trigger::trigger_looking(self);
}

//Function Number: 15
breach_icon_think(param_00,param_01,param_02)
{
	thread breach_debug_display_animnames(param_02);
	var_03 = newhudelem();
	var_03 setshader("breach_icon",1,1);
	var_03.alpha = 0;
	var_03.color = (1,1,1);
	var_03.x = self.origin[0];
	var_03.y = self.origin[1];
	var_03.z = self.origin[2];
	var_03 setwaypoint(1,1);
	var_04 = spawn("script_model",self.origin);
	var_04 setmodel("mil_frame_charge");
	var_04 hidepart("j_frame_charge");
	wait(0.05);
	var_05 = "breach_door_icon_" + param_01;
	common_scripts\utility::flag_wait(var_05);
	while(!param_02.breached)
	{
		wait(0.05);
	}

	var_03 destroy();
	var_04 delete();
}

//Function Number: 16
breach_spawner_setup(param_00,param_01)
{
	var_02 = self.script_slowmo_breach;
	var_03 = 0;
	if(isdefined(self.script_slowmo_breach_spawners))
	{
		if(param_01 == "enemy" || param_01 == "hostage")
		{
			var_03 = self.script_slowmo_breach_spawners;
		}
	}

	if(!isdefined(param_00[var_02].spawners[param_01][var_03]))
	{
		param_00[var_02].spawners[param_01][var_03] = [];
	}

	var_04 = param_00[var_02].spawners[param_01][var_03];
	var_04[var_04.size] = self;
	param_00[var_02].spawners[param_01][var_03] = var_04;
	if(param_00.size)
	{
		return param_00;
	}

	return undefined;
}

//Function Number: 17
slowmo_breach_think(param_00,param_01)
{
	var_02 = param_00.left_post;
	var_03 = param_00.right_post;
	var_04 = param_00.spawners["enemy"];
	var_05 = param_00.spawners["hostage"];
	var_06 = param_00.trigger;
	var_07 = param_00.path_solids;
	var_08 = param_00.door_volume;
	var_09 = param_00.room_volume;
	var_0A = [];
	var_0B = [];
	var_0C = [];
	var_0D = [];
	if(isdefined(param_00.spawners["friendlyenemy"][0]))
	{
		var_0A = param_00.spawners["friendlyenemy"][0];
		param_00.spawners["friendlyenemy"] = var_0A;
	}

	if(isdefined(param_00.spawners["friendlyhostage"][0]))
	{
		var_0B = param_00.spawners["friendlyhostage"][0];
		param_00.spawners["friendlyhostage"] = var_0B;
	}

	if(isdefined(param_00.spawners["coopenemy"][0]))
	{
		var_0C = param_00.spawners["coopenemy"][0];
		param_00.spawners["coopenemy"] = var_0C;
	}

	if(isdefined(param_00.spawners["coophostage"][0]))
	{
		var_0D = param_00.spawners["coophostage"][0];
		param_00.spawners["coophostage"] = var_0D;
	}

	var_0E = spawnstruct();
	var_0E.entity = var_02;
	var_0E.forward = 5;
	var_0E.right = 6;
	var_0E.yaw = -90;
	var_0E maps\_utility::translate_local();
	var_0E = spawnstruct();
	var_0E.entity = var_03;
	var_0E.right = -2;
	var_0E.yaw = 90;
	var_0E maps\_utility::translate_local();
	var_0F = [];
	foreach(var_12, var_11 in var_04)
	{
		var_0F[var_12] = var_12;
	}

	foreach(var_12, var_11 in var_05)
	{
		var_0F[var_12] = var_12;
	}

	if(var_0F.size)
	{
		var_14 = common_scripts\utility::random(var_0F);
		if(isdefined(var_04[var_14]))
		{
			var_04 = var_04[var_14];
		}
		else
		{
			var_04 = [];
		}

		if(isdefined(var_05[var_14]))
		{
			var_05 = var_05[var_14];
		}
		else
		{
			var_05 = [];
		}
	}

	param_00.spawners["enemy"] = var_04;
	param_00.spawners["hostage"] = var_05;
	common_scripts\utility::array_thread(var_04,::maps\_utility::add_spawn_function,::breach_enemy_spawner_think);
	common_scripts\utility::array_thread(var_05,::maps\_utility::add_spawn_function,::breach_hostage_spawner_think);
	common_scripts\utility::array_thread(var_0A,::maps\_utility::add_spawn_function,::breach_enemy_spawner_think);
	common_scripts\utility::array_thread(var_0B,::maps\_utility::add_spawn_function,::breach_hostage_spawner_think);
	common_scripts\utility::array_thread(var_0C,::maps\_utility::add_spawn_function,::breach_enemy_spawner_think);
	common_scripts\utility::array_thread(var_0D,::maps\_utility::add_spawn_function,::breach_hostage_spawner_think);
	var_06 sethintstring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
	if(!isdefined(level.breach_use_triggers))
	{
		level.breach_use_triggers = [];
	}

	level.breach_use_triggers = common_scripts\utility::array_add(level.breach_use_triggers,var_06);
	var_15 = "breach_door_charge";
	var_16 = undefined;
	switch(param_00.doortype)
	{
		case "metal":
			var_16 = "breach_door_model_metal";
			break;

		case "estate_wood":
			var_16 = "breach_door_model_estate";
			break;

		case "estate_wood_backwards":
			var_16 = "breach_door_model_estate";
			break;

		case "caves_wood":
			var_16 = "breach_door_model_caves";
			break;

		case "payback_wood":
			var_16 = "breach_door_model_payback";
			var_15 = "breach_door_charge_payback";
			break;

		case "wood":
		case "none":
			var_16 = "breach_door_model";
			break;

		default:
			break;
	}

	var_17 = maps\_utility::spawn_anim_model(var_16);
	if(param_00.doortype == "none" || param_00.doortype == "estate_wood_backwards")
	{
		var_17 hide();
	}

	level.breach_doors = [];
	level.breach_doors[param_01] = var_17;
	var_18 = maps\_utility::spawn_anim_model(var_15);
	var_18 common_scripts\utility::hide_notsolid();
	var_02.scene_models = [];
	var_02 add_scene_model("active_breacher_rig");
	var_19 = var_02.scene_models["active_breacher_rig"];
	var_19 hide();
	var_1A = undefined;
	if(maps\_utility::is_coop())
	{
		var_02 add_coop_scene_models();
		var_1A = var_02.scene_models["passive_breacher_rig"];
		var_1A hide();
	}

	var_02.door = var_17;
	var_02.charge = var_18;
	var_02.post = var_03;
	var_02.breach_index = param_01;
	var_02 maps\_anim::anim_first_frame_solo(var_17,"breach");
	var_02 maps\_anim::anim_first_frame_solo(var_18,"breach");
	var_02 maps\_anim::anim_first_frame_solo(var_19,"breach_player_anim");
	if(maps\_utility::is_coop())
	{
		var_02 maps\_anim::anim_first_frame_solo(var_1A,"breach_player_anim");
	}

	var_02 wait_for_breach_or_deletion(param_00);
	foreach(var_1C in var_02.scene_models)
	{
		var_1C delete();
	}

	if(isdefined(var_06))
	{
		var_06 delete();
	}

	if(isdefined(var_17))
	{
		var_17 delete();
	}

	if(isdefined(var_18))
	{
		var_18 delete();
	}

	if(isdefined(var_02))
	{
		var_02 delete();
	}

	if(isdefined(var_03))
	{
		var_03 delete();
	}
}

//Function Number: 18
breach_should_be_skipped(param_00)
{
	if(!isdefined(level.skip_breach))
	{
		return 0;
	}

	if(!isdefined(level.skip_breach[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
coop_player_touching_valid_door_volume(param_00,param_01)
{
	var_02 = [];
	var_02[0] = param_00;
	if(isdefined(param_00.script_breachgroup))
	{
		var_02 = get_door_volumes_from_breachgroup(param_00.script_breachgroup);
	}

	foreach(var_04 in var_02)
	{
		if(param_01 istouching(var_04))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
get_door_volumes_from_breachgroup(param_00)
{
	var_01 = [];
	var_02 = getentarray("breach_door_volume","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.script_breachgroup) && var_04.script_breachgroup == param_00)
		{
			var_01[var_01.size] = var_04;
		}
	}

	return var_01;
}

//Function Number: 21
breach_participants_ready_to_proceed(param_00,param_01,param_02)
{
	if(maps\_utility::is_coop())
	{
		var_03 = maps\_utility::get_other_player(param_00);
		if(var_03 maps\_utility::ent_flag_exist("laststand_downed") && var_03 maps\_utility::ent_flag("laststand_downed"))
		{
			return 0;
		}

		if(coop_player_touching_valid_door_volume(param_02,var_03))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	if(param_01.size == 0)
	{
		return 1;
	}

	if(!room_has_multiple_doors(param_02))
	{
		return 1;
	}

	if(!breach_friendlies_ready_at_other_door(param_02,1))
	{
		if(getdvar("breach_requires_friendlies_in_position") == "1")
		{
			if(!breachfriendlies_can_teleport(param_01,param_02))
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 22
wait_for_breach_or_deletion(param_00)
{
	var_01 = param_00.trigger;
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = param_00.door_volume;
	var_01 endon("death");
	for(;;)
	{
		var_01 waittill("trigger",var_03,var_04);
		if(gettime() == level.breach_passive_time)
		{
			var_04 = level.breach_passive_player;
		}

		var_05 = isdefined(var_04);
		if(!param_00.enabled)
		{
			return;
		}

		if(isalive(var_03) && !var_05)
		{
			if(breach_failed_to_start())
			{
				continue;
			}
		}

		if(isdefined(param_00.safe_volume) && !maps\_utility::is_specialop())
		{
			if(isplayer(var_03) && isalive(var_03))
			{
				var_06 = param_00.safe_volume maps\_utility::get_ai_touching_volume("axis");
				if(var_06.size)
				{
					thread breach_too_many_enemies_hint();
					continue;
				}
			}
		}

		var_07 = get_available_breachfriendlies(var_02);
		if(isplayer(var_03) && isalive(var_03))
		{
			if(breach_should_be_skipped(var_01.script_slowmo_breach))
			{
				break;
			}

			if(breach_participants_ready_to_proceed(var_03,var_07,var_02))
			{
				if(player_breach(param_00,var_03))
				{
					break;
				}
			}
			else
			{
				thread breach_friendly_hint();
			}

			continue;
		}

		if(var_07.size)
		{
			friendlies_breach(param_00,var_07);
			break;
		}
		else
		{
			breachless_door_opens(param_00);
			break;
		}
	}
}

//Function Number: 23
breachfriendlies_can_teleport(param_00,param_01)
{
	var_02 = 0;
	var_03 = get_player_volume(param_01);
	foreach(var_05 in param_00)
	{
		if(isdefined(var_03))
		{
			if(var_05 goalpos_within_volume(var_03))
			{
				continue;
			}
		}

		if(!var_05 friendly_can_teleport())
		{
			continue;
		}

		var_02++;
	}

	if(var_02 >= 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
friendly_can_teleport()
{
	if(maps\_utility::player_can_see_ai(self))
	{
		return 0;
	}

	if(distance(level.player.origin,self.origin) < 96)
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
breach_friendly_hint()
{
	if(maps\_utility::is_coop())
	{
		thread breach_hint_create(&"SCRIPT_BREACH_NEED_PLAYER");
		return;
	}

	thread breach_hint_create(&"SCRIPT_BREACH_NEED_FRIENDLY");
}

//Function Number: 26
breach_too_many_enemies_hint()
{
	thread breach_hint_create(&"SCRIPT_BREACH_TOO_MANY_ENEMIES");
}

//Function Number: 27
breach_reloading_hint()
{
	thread breach_hint_create(&"SCRIPT_BREACH_RELOADING");
}

//Function Number: 28
breach_bad_weapon_hint()
{
	thread breach_hint_create(&"SCRIPT_BREACH_ILLEGAL_WEAPON");
}

//Function Number: 29
breach_not_ready_hint()
{
	if(maps\_utility::is_coop())
	{
		thread breach_hint_create(&"SCRIPT_BREACH_PARTNER_NOT_READY");
		return;
	}

	thread breach_hint_create(&"SCRIPT_BREACH_YOU_NOT_READY");
}

//Function Number: 30
breach_hint_create(param_00)
{
	level notify("breach_hint_cleanup");
	level endon("breach_hint_cleanup");
	var_01 = 20;
	if(issplitscreen())
	{
		var_01 = -23;
	}

	thread maps\_utility::hint(param_00,3,var_01);
	thread breach_hint_cleanup();
}

//Function Number: 31
breach_hint_cleanup()
{
	level notify("breach_hint_cleanup");
	level endon("breach_hint_cleanup");
	foreach(var_01 in level.breach_use_triggers)
	{
		if(isdefined(var_01))
		{
			var_01 sethintstring("");
		}
	}

	level common_scripts\utility::waittill_notify_or_timeout("breaching",3);
	maps\_utility::hint_fade();
	foreach(var_01 in level.breach_use_triggers)
	{
		if(isdefined(var_01))
		{
			var_01 sethintstring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
		}
	}
}

//Function Number: 32
room_has_multiple_doors(param_00)
{
	if(isdefined(param_00.script_breachgroup))
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
breach_friendlies_take_grenades()
{
	if(!isdefined(level.breachfriendlies))
	{
		return;
	}

	level.breachfriendlies_grenades_empty = 1;
	foreach(var_01 in level.breachfriendlies)
	{
		var_01.grenadeammo_prebreach = var_01.grenadeammo;
		var_01.grenadeammo = 0;
	}
}

//Function Number: 34
breach_friendlies_restore_grenades()
{
	if(!isdefined(level.breachfriendlies))
	{
		return;
	}

	if(!isdefined(level.breachfriendlies_grenades_empty))
	{
		return;
	}

	foreach(var_01 in level.breachfriendlies)
	{
		var_01.grenadeammo = var_01.grenadeammo_prebreach;
		var_01.grenadeammo_prebreach = undefined;
	}

	level.breachfriendlies_grenades_empty = undefined;
}

//Function Number: 35
breach_friendlies_ready_at_other_door(param_00,param_01)
{
	var_02 = param_00.script_breachgroup;
	var_03 = get_door_volumes_from_breachgroup(param_00.script_breachgroup);
	var_03 = common_scripts\utility::array_remove(var_03,param_00);
	var_04 = var_03[0];
	foreach(var_06 in level.breachfriendlies)
	{
		if(isdefined(param_01) && param_01)
		{
			if(var_06 goalpos_within_volume(var_04))
			{
				if(var_06 friendly_can_teleport())
				{
					return 1;
				}
			}
		}

		if(var_06 istouching(var_04))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 36
add_coop_scene_models()
{
	add_scene_model("passive_breacher_rig");
	add_scene_model("active_breacher_3rd_person");
	add_scene_model("passive_breacher_3rd_person");
}

//Function Number: 37
add_scene_model(param_00)
{
	self.scene_models[param_00] = maps\_utility::spawn_anim_model(param_00);
	self.scene_models[param_00] hide();
}

//Function Number: 38
set_room_to_breached(param_00,param_01)
{
	param_01.breached = 1;
	var_02 = get_breach_notify(param_00.script_breachgroup);
	if(isdefined(param_00.script_breachgroup))
	{
		level notify(var_02);
	}

	param_01 notify("breached");
	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 39
breachless_door_opens(param_00)
{
	var_01 = param_00.trigger;
	var_02 = param_00.room_volume;
	var_03 = param_00.path_solids;
	var_04 = self.door;
	var_05 = self.charge;
	set_room_to_breached(var_01,var_02);
	common_scripts\utility::array_call(var_03,::connectpaths);
	common_scripts\utility::array_thread(var_03,::maps\_utility::self_delete);
	var_06 = spawnstruct();
	var_06.entity = var_04;
	var_06.forward = 4;
	var_06.right = 10;
	var_06.yaw = -170;
	var_06 maps\_utility::translate_local();
	var_05 delete();
	if(!maps\_utility::is_coop())
	{
		return;
	}

	while(!var_02.breached)
	{
		wait(0.05);
	}

	var_07 = undefined;
	var_08 = undefined;
	if(param_00.spawners["coopenemy"].size)
	{
		var_07 = param_00.spawners["coopenemy"];
		var_08 = param_00.spawners["coophostage"];
	}
	else
	{
		var_07 = param_00.spawners["enemy"];
		var_08 = param_00.spawners["hostage"];
	}

	if(var_07.size)
	{
		common_scripts\utility::array_call(var_07,::stalingradspawn);
	}

	if(var_08.size)
	{
		common_scripts\utility::array_call(var_08,::stalingradspawn);
	}
}

//Function Number: 40
friendlies_breach(param_00,param_01)
{
	var_02 = param_00.trigger;
	var_03 = param_00.door_volume;
	var_04 = param_00.room_volume;
	var_05 = param_00.spawners["enemy"];
	var_06 = param_00.spawners["hostage"];
	var_07 = param_00.spawners["friendlyenemy"];
	var_08 = param_00.spawners["friendlyhostage"];
	var_09 = param_00.path_solids;
	var_0A = self.charge;
	var_0B = self.scene_models["active_breacher_rig"];
	set_room_to_breached(var_02,var_04);
	var_0C = param_00.friendly_anim_ent;
	var_0D = get_player_volume(var_03);
	var_0E = getdvar("breach_requires_friendlies_in_position") == "1";
	if(!var_0E)
	{
		if(isdefined(var_0D) && breach_friendlies_ready_at_other_door(var_0D))
		{
			foreach(var_10 in param_01)
			{
				if(!var_10 istouching(var_03))
				{
					param_01 = common_scripts\utility::array_remove(param_01,var_10);
				}
			}

			var_0E = 1;
		}
	}

	if(var_0E)
	{
		var_12 = common_scripts\utility::getclosest(var_0C.origin,param_01);
	}
	else
	{
		var_12 = get_teleport_optimized_breachfriendly(var_0D.origin,var_04,var_02,var_0E);
	}

	param_01 = common_scripts\utility::array_remove(param_01,var_12);
	if(var_07.size)
	{
		level.breachenemies = maps\_utility::array_spawn(var_07,1);
	}

	if(var_08.size)
	{
		common_scripts\utility::array_call(var_08,::stalingradspawn);
	}

	common_scripts\utility::array_call(var_09,::connectpaths);
	common_scripts\utility::array_thread(var_09,::maps\_utility::self_delete);
	var_12 thread friendly_breach(1,var_0C,var_04);
	if(param_01.size)
	{
		if(var_0E)
		{
			var_13 = common_scripts\utility::getclosest(var_0C.origin,param_01);
		}
		else
		{
			var_13 = get_teleport_optimized_breachfriendly(var_0D.origin,var_04,var_02,var_0E);
		}

		if(isdefined(var_13))
		{
			var_13 thread friendly_breach(2,var_0C,var_04);
		}
		else
		{
		}
	}

	wait(1);
	breach_friendlies_take_grenades();
	maps\_anim::anim_single_solo(var_0B,"breach_player_anim");
}

//Function Number: 41
get_player_volume(param_00)
{
	var_01 = undefined;
	var_02 = get_grouped_doorvolumes(param_00);
	foreach(var_04 in var_02)
	{
		if(level.player istouching(var_04))
		{
			var_01 = var_04;
			break;
		}
	}

	return var_01;
}

//Function Number: 42
get_teleport_optimized_breachfriendly(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	foreach(var_06 in param_02)
	{
		if(isdefined(param_03))
		{
			if(var_06 goalpos_within_volume(param_03))
			{
				continue;
			}
		}

		if(!var_06 friendly_can_teleport())
		{
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	if(!var_04.size)
	{
		return undefined;
	}

	var_04 = common_scripts\utility::get_array_of_closest(param_00,var_04);
	var_08 = var_04[0];
	foreach(var_06 in var_04)
	{
		if(var_06 goalpos_within_volume(param_01))
		{
			var_08 = var_06;
			break;
		}
	}

	return var_08;
}

//Function Number: 43
goalpos_within_volume(param_00)
{
	if(isdefined(self.goalpos))
	{
		if(origin_within_volume(self.goalpos + (0,0,40),param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 44
origin_within_volume(param_00,param_01)
{
	var_02 = spawn("script_origin",param_00);
	var_03 = 0;
	if(var_02 istouching(param_01))
	{
		var_03 = 1;
	}

	var_02 delete();
	return var_03;
}

//Function Number: 45
get_grouped_doorvolumes(param_00)
{
	var_01 = [];
	var_01[0] = param_00;
	if(isdefined(param_00.script_breachgroup))
	{
		foreach(var_03 in level.breach_groups)
		{
			if(!isdefined(var_03.door_volume))
			{
				continue;
			}

			if(var_03.door_volume == param_00)
			{
				continue;
			}

			if(!isdefined(var_03.door_volume.script_breachgroup))
			{
				continue;
			}

			if(isdefined(var_03.door_volume.script_breachgroup) && var_03.door_volume.script_breachgroup == param_00.script_breachgroup)
			{
				var_01[var_01.size] = var_03.door_volume;
			}
		}
	}

	return var_01;
}

//Function Number: 46
sort_breachers(param_00,param_01)
{
	var_02 = param_01["active"];
	var_03 = anglestoright(self.angles);
	var_04 = vectornormalize(var_02.origin - param_00.trigger.origin);
	var_05 = vectordot(var_03,var_04);
	if(var_05 < 0)
	{
		param_01["active"] = param_01["passive"];
		param_01["passive"] = var_02;
	}

	return param_01;
}

//Function Number: 47
player_breach(param_00,param_01)
{
	var_02 = [];
	var_02["active"] = param_01;
	var_03 = self.scene_models["active_breacher_rig"];
	var_04 = 0;
	var_05 = undefined;
	if(maps\_utility::is_coop())
	{
		var_02["passive"] = maps\_utility::get_other_player(var_02["active"]);
		var_05 = self.scene_models["passive_breacher_rig"];
		var_06 = breach_near_player(var_02["passive"]);
		if(var_06 == param_00)
		{
			var_04 = 1;
			var_06.room_volume.has_passive_breacher = 1;
			var_02 = sort_breachers(param_00,var_02);
		}
		else
		{
			level.breach_passive_player = var_02["passive"];
			level.breach_passive_time = gettime();
			var_06.trigger notify("trigger",var_02["passive"],"passive");
		}
	}

	var_02["active"] enablebreaching();
	if(var_04)
	{
		var_02["passive"] disableweapons();
	}

	foreach(param_01 in var_02)
	{
		if(!isdefined(level.slowmo_breach_disable_stancemod))
		{
			param_01 enableinvulnerability();
			param_01 disableweaponswitch();
			param_01 disableoffhandweapons();
			param_01 allowcrouch(0);
			param_01 allowprone(0);
			param_01 allowsprint(0);
			param_01 allowjump(0);
		}

		param_01 common_scripts\utility::_disableusability();
		if(!isdefined(param_01.prebreachcurrentweapon))
		{
			param_01.prebreachcurrentweapon = param_01 getcurrentweapon();
		}
	}

	level notify("breaching");
	level notify("breaching_number_" + self.script_slowmo_breach);
	setsaveddvar("objectiveHide",1);
	var_09 = param_00.room_volume;
	set_room_to_breached(param_00.trigger,var_09);
	var_0A = undefined;
	var_0B = isdefined(level.has_special_breach_anim[var_02["active"].prebreachcurrentweapon]);
	if(var_0B)
	{
		level.slowmo_breach_start_delay = 2.25;
		set_door_charge_anim_special();
		var_0A = 0.5;
	}
	else
	{
		level.slowmo_breach_start_delay = 2.15;
		set_door_charge_anim_normal();
		var_0A = 0.2;
	}

	var_02["active"] thread play_detpack_plant_sound(var_0A);
	if(maps\_utility::is_coop())
	{
		if(!isdefined(level.player_one_already_breached))
		{
			level.breachenemies_alive = 0;
			level.breachenemies_active = 0;
			level.player_one_already_breached = 1;
		}
	}
	else
	{
		level.breachenemies_alive = 0;
		level.breachenemies_active = 0;
	}

	var_0C = param_00.spawners["enemy"];
	common_scripts\utility::array_call(var_0C,::stalingradspawn);
	var_0D = param_00.spawners["hostage"];
	common_scripts\utility::array_call(var_0D,::stalingradspawn);
	var_02["active"] playerlinktoblend(var_03,"tag_player",0.2,0.1,0.1);
	if(isdefined(var_02["active"].dont_unlink_after_breach))
	{
		thread maps\_utility::open_up_fov(0.2,var_03,"tag_player",45,45,90,45);
	}

	if(var_04)
	{
		var_02["passive"] playerlinktoblend(var_05,"tag_player",0.2,0.1,0.1);
		if(isdefined(var_02["passive"].dont_unlink_after_breach))
		{
			thread maps\_utility::open_up_fov(0.2,var_05,"tag_player",45,45,90,45);
		}
	}

	var_02["active"] thread take_prebreach_weapons();
	if(!var_0B)
	{
		wait(0.05);
	}

	var_0E = self.charge;
	thread maps\_anim::anim_single_solo(var_0E,"breach");
	var_0E show();
	var_02["active"] thread restore_prebreach_weapons();
	var_0F = 0;
	if(var_04)
	{
		thread maps\_anim::anim_single_solo(var_05,"breach_player_anim");
		var_02["passive"].animname = "passive_breacher_3rd_person";
		var_02["passive"] thread maps\_anim::anim_single_solo(var_02["passive"],"breach_player_anim");
		var_02["passive"] thread enable_passive_weapons();
		var_02["passive"] thread restore_prebreach_weapons();
		var_02["active"].animname = "active_breacher_3rd_person";
		var_02["active"] thread maps\_anim::anim_single_solo(var_02["active"],"breach_player_anim");
	}

	maps\_anim::anim_single_solo(var_03,"breach_player_anim");
	level notify("sp_slowmo_breachanim_done");
	thread flag_set_when_room_cleared(var_09);
	var_10 = param_00.path_solids;
	common_scripts\utility::array_call(var_10,::connectpaths);
	common_scripts\utility::array_thread(var_10,::maps\_utility::self_delete);
	foreach(param_01 in var_02)
	{
		if(isdefined(param_01.dont_unlink_after_breach))
		{
			var_0F = 1;
			special_gulag_adjustment();
		}
		else
		{
			param_01 unlink();
		}

		param_01 show();
	}

	if(var_0F)
	{
		level waittill("breach_concludes");
	}

	var_02["active"] disablebreaching();
	foreach(param_01 in var_02)
	{
		if(!isdefined(level.slowmo_breach_disable_stancemod))
		{
			param_01 disableinvulnerability();
			param_01 enableweaponswitch();
			param_01 enableoffhandweapons();
			param_01 allowcrouch(1);
			param_01 allowprone(1);
			param_01 allowsprint(1);
			param_01 allowjump(1);
		}

		param_01 common_scripts\utility::_enableusability();
	}

	return 1;
}

//Function Number: 48
play_detpack_plant_sound(param_00)
{
	self endon("death");
	wait(param_00);
	self playsound("detpack_wall_plant");
}

//Function Number: 49
flag_set_when_room_cleared(param_00)
{
	var_01 = param_00.script_flag;
	level endon(var_01);
	var_02 = param_00 maps\_utility::get_ai_touching_volume("bad_guys");
	maps\_utility::waittill_dead(var_02);
	level notify("breach_room_has_been_cleared");
	level.breachenemies = undefined;
	common_scripts\utility::flag_set(var_01);
}

//Function Number: 50
take_prebreach_weapons()
{
	self giveweapon("usp_scripted");
	self switchtoweaponimmediate("usp_scripted");
	if(isdefined(level.has_special_breach_anim[self.prebreachcurrentweapon]))
	{
		self switchtoweaponimmediate(self.prebreachcurrentweapon);
	}
}

//Function Number: 51
restore_prebreach_weapons()
{
	wait(0.5);
	self takeweapon("usp_scripted");
	if(isdefined(self.prebreachcurrentweapon))
	{
		var_00 = self.prebreachcurrentweapon;
		self switchtoweapon(var_00);
		if(should_topoff_breach_weapon(var_00))
		{
			var_01 = weaponclipsize(var_00);
			if(self getweaponammoclip(var_00) < var_01)
			{
				self setweaponammoclip(var_00,var_01);
			}
		}

		self.prebreachcurrentweapon = undefined;
	}
}

//Function Number: 52
enable_passive_weapons()
{
	wait(2.2);
	self enableweapons();
}

//Function Number: 53
should_topoff_breach_weapon(param_00)
{
	if(level.gameskill > 1)
	{
		return 0;
	}

	if(isdefined(level.breach_no_auto_reload))
	{
		return !level.breach_no_auto_reload;
	}

	if(!isdefined(self.prebreachcurrentweapon))
	{
		return 0;
	}

	if(param_00 != self.prebreachcurrentweapon)
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
friendly_breach(param_00,param_01,param_02)
{
	var_03 = param_02.script_flag;
	if(param_00 == 2)
	{
		var_04 = "breach_friend_idle_02";
		var_05 = "breach_friend_enter_02";
	}
	else
	{
		var_04 = "breach_friend_idle_01";
		var_05 = "breach_friend_enter_01";
	}

	self.breaching = 1;
	var_06 = 1;
	if(!isdefined(self.magic_bullet_shield))
	{
		var_06 = 0;
		thread maps\_utility::magic_bullet_shield();
	}

	wait(0.5);
	self forceteleport(param_01.origin,param_01.angles);
	param_01 thread maps\_anim::anim_generic_loop(self,var_04,"stop_idle");
	self setgoalpos(self.origin);
	wait(3);
	thread friendlies_shoot_while_breaching(param_00);
	param_01 notify("stop_idle");
	param_01 maps\_anim::anim_generic(self,var_05);
	self setgoalpos(self.origin);
	level notify("friendlies_finished_breach");
	common_scripts\utility::flag_wait(var_03);
	if(!var_06)
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self.breaching = undefined;
}

//Function Number: 55
friendlies_shoot_while_breaching(param_00)
{
	if(param_00 == 1)
	{
		wait(1);
	}
	else
	{
		wait(2);
	}

	level endon("friendlies_finished_breach");
	level endon("breach_room_has_been_cleared");
	while(!isdefined(level.breachenemies))
	{
		wait(0.05);
	}

	while(isdefined(level.breachenemies) && level.breachenemies.size)
	{
		wait(0.05);
		if(!isdefined(level.breachenemies))
		{
			break;
		}

		level.breachenemies = maps\_utility::remove_dead_from_array(level.breachenemies);
		foreach(var_02 in level.breachenemies)
		{
			if(!isalive(var_02) || !isdefined(var_02))
			{
				continue;
			}

			var_03 = var_02 gettagorigin("tag_eye");
			var_04 = self getmuzzlepos();
			var_05 = self getshootatpos() - var_04;
			if(self canshoot(var_03,var_05))
			{
				magicbullet(self.weapon,self getmuzzlepos(),var_03);
				bullettracer(self getmuzzlepos(),var_03,1);
				wait(0.5);
			}
		}
	}
}

//Function Number: 56
get_available_breachfriendlies(param_00)
{
	var_01 = [];
	if(!isdefined(level.breachfriendlies))
	{
		return var_01;
	}

	var_01 = maps\_utility::array_removedead(level.breachfriendlies);
	var_02 = getdvar("breach_requires_friendlies_in_position") == "1";
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.breaching) && var_04.breaching == 1)
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_04);
			continue;
		}

		if(var_02 && !var_04 istouching(param_00))
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_04);
			continue;
		}
	}

	return var_01;
}

//Function Number: 57
get_breach_notify(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	return "A door in breach group " + param_00 + " has been activated.";
}

//Function Number: 58
breach_group_trigger_think()
{
	var_00 = self.script_breachgroup;
	var_01 = get_breach_notify(var_00);
	level waittill(var_01);
	waittillframeend;
	self notify("trigger");
}

//Function Number: 59
slowmo_player_cleanup()
{
	if(isdefined(level.playerspeed))
	{
		self setmovespeedscale(level.playerspeed);
		return;
	}

	self setmovespeedscale(1);
}

//Function Number: 60
slowmo_begins(param_00)
{
	if(isdefined(level.breaching) && level.breaching == 1)
	{
		return;
	}

	level.breaching = 1;
	common_scripts\utility::flag_set("breaching_on");
	level notify("slowmo_go");
	level endon("slowmo_go");
	var_01 = 0.5;
	var_02 = 0.75;
	var_03 = 0.2;
	if(isdefined(level.slomobreachplayerspeed))
	{
		var_03 = level.slomobreachplayerspeed;
	}

	var_04 = level.player;
	var_05 = undefined;
	if(maps\_utility::is_coop())
	{
		var_05 = maps\_utility::get_other_player(var_04);
	}

	var_04 thread maps\_utility::play_sound_on_entity("slomo_whoosh_in");
	var_04 thread player_heartbeat();
	thread slomo_breach_vision_change(var_01 * 2,var_02 / 2);
	thread slomo_difficulty_dvars();
	common_scripts\utility::flag_clear("can_save");
	maps\_utility::slowmo_start();
	var_04 thread set_breaching_variable();
	if(isdefined(var_05))
	{
		var_05 thread set_breaching_variable();
	}

	var_04 allowmelee(0);
	if(isdefined(var_05))
	{
		var_05 allowmelee(0);
	}

	maps\_utility::slowmo_setspeed_slow(0.25);
	maps\_utility::slowmo_setlerptime_in(var_01);
	maps\_utility::slowmo_lerp_in();
	var_04 setmovespeedscale(var_03);
	if(isdefined(var_05))
	{
		var_05 setmovespeedscale(var_03);
	}

	var_06 = gettime();
	var_07 = var_06 + level.slomobreachduration * 1000;
	if(!maps\_utility::is_coop())
	{
		var_04 thread catch_weapon_switch();
	}

	var_04 thread catch_mission_failed();
	if(isdefined(var_05))
	{
		var_05 thread catch_mission_failed();
	}

	var_08 = 500;
	var_09 = 1000;
	for(;;)
	{
		if(isdefined(level.forced_slowmo_breach_slowdown))
		{
			if(!level.forced_slowmo_breach_slowdown)
			{
				if(isdefined(level.forced_slowmo_breach_lerpout))
				{
					var_02 = level.forced_slowmo_breach_lerpout;
				}

				break;
			}

			wait(0.05);
			continue;
		}

		if(gettime() >= var_07)
		{
			break;
		}

		if(level.breachenemies_active <= 0 && level.breachignoreenemy_count == 0)
		{
			var_02 = 1.15;
			break;
		}

		if(!maps\_utility::is_coop())
		{
			if(var_04.lastreloadstarttime >= var_06 + var_08)
			{
				break;
			}

			if(var_04.switchedweapons && gettime() - var_06 > var_09)
			{
				break;
			}
		}

		if(maps\_utility::is_specialop() && common_scripts\utility::flag("special_op_terminated"))
		{
			break;
		}

		if(var_04.breach_missionfailed || maps\_utility::is_coop() && var_05.breach_missionfailed)
		{
			var_02 = 0.5;
			break;
		}

		wait(0.05);
	}

	level notify("slowmo_breach_ending",var_02);
	level notify("stop_player_heartbeat");
	var_04 thread maps\_utility::play_sound_on_entity("slomo_whoosh_out");
	maps\_utility::slowmo_setlerptime_out(var_02);
	maps\_utility::slowmo_lerp_out();
	var_04 allowmelee(1);
	if(isdefined(var_05))
	{
		var_05 allowmelee(1);
	}

	var_04 maps\_utility::delaythread(var_02,::clear_breaching_variable);
	if(isdefined(var_05))
	{
		var_05 maps\_utility::delaythread(var_02,::clear_breaching_variable);
	}

	maps\_utility::slowmo_end();
	common_scripts\utility::flag_set("can_save");
	level.player_one_already_breached = undefined;
	var_04 slowmo_player_cleanup();
	if(isdefined(var_05))
	{
		var_05 slowmo_player_cleanup();
	}

	level notify("slomo_breach_over");
	level.breaching = 0;
	common_scripts\utility::flag_clear("breaching_on");
	setsaveddvar("objectiveHide",0);
}

//Function Number: 61
set_breaching_variable()
{
	self endon("clear_breaching_variable");
	self.isbreaching = 1;
	self.breaching_shots_fired = 0;
	self.achieve_slowmo_breach_kills = undefined;
	var_00 = self getcurrentweaponclipammo();
	self notifyonplayercommand("player_shot_fired","+attack");
	self notifyonplayercommand("player_shot_fired","+attack_akimbo_accessible");
	while(isdefined(self.isbreaching))
	{
		self waittill("player_shot_fired");
		self.breaching_shots_fired = var_00 - self getcurrentweaponclipammo();
		wait(0.05);
		while(self isfiring())
		{
			self.breaching_shots_fired = var_00 - self getcurrentweaponclipammo();
			wait(0.05);
		}
	}
}

//Function Number: 62
clear_breaching_variable()
{
	self.isbreaching = undefined;
	thread maps\_utility::notify_delay("clear_breaching_variable",0.25);
}

//Function Number: 63
slomo_difficulty_dvars()
{
	var_00 = getdvar("bg_viewKickScale");
	var_01 = getdvar("bg_viewKickMax");
	setsaveddvar("bg_viewKickScale",0.3);
	setsaveddvar("bg_viewKickMax","15");
	setsaveddvar("bullet_penetration_damage",0);
	level waittill("slowmo_breach_ending");
	setsaveddvar("bg_viewKickScale",var_00);
	setsaveddvar("bg_viewKickMax",var_01);
	wait(2);
	setsaveddvar("bullet_penetration_damage",1);
}

//Function Number: 64
slomo_breach_vision_change(param_00,param_01)
{
	if(!isdefined(level.slomobasevision))
	{
		return;
	}

	visionsetnaked("slomo_breach",param_00);
	level waittill("slowmo_breach_ending",var_02);
	if(isdefined(var_02))
	{
		param_01 = var_02;
	}

	wait(1);
	visionsetnaked(level.slomobasevision,param_01);
}

//Function Number: 65
player_heartbeat()
{
	level endon("stop_player_heartbeat");
	for(;;)
	{
		self playlocalsound("breathing_heartbeat");
		wait(0.5);
	}
}

//Function Number: 66
catch_weapon_switch()
{
	level endon("slowmo_breach_ending");
	self.switchedweapons = 0;
	common_scripts\utility::waittill_any("weapon_switch_started","night_vision_on","night_vision_off");
	self.switchedweapons = 1;
}

//Function Number: 67
catch_mission_failed()
{
	level endon("slowmo_breach_ending");
	self.breach_missionfailed = 0;
	level waittill("mission failed");
	self.breach_missionfailed = 1;
}

//Function Number: 68
breach_enemy_spawner_think()
{
	var_00 = self.spawner;
	self endon("death");
	maps\_utility::add_damage_function(::record_last_player_damage);
	thread breach_enemy_ignored_by_friendlies();
	thread breach_enemy_ragdoll_on_death();
	level thread breach_enemy_track_status(self);
	if(isdefined(self.script_parameters) && common_scripts\utility::string_starts_with(self.script_parameters,"reference"))
	{
		var_00 = getent(self.script_parameters,"targetname");
	}

	self.reference = var_00;
	var_00 maps\_anim::anim_generic_first_frame(self,self.animation);
	if(isdefined(level._slowmo_functions[self.animation]))
	{
		var_01 = level._slowmo_functions[self.animation];
		self thread [[ var_01 ]]();
	}

	self.grenadeammo = 0;
	self.allowdeath = 1;
	self.health = 10;
	self.baseaccuracy = 5000;
	if(isdefined(self.script_threatbias))
	{
		self.threatbias = self.script_threatbias;
	}

	if(isdefined(level.breach_death_anims[self.animation]))
	{
		self.skipdeathanim = 1;
	}

	wait(level.slowmo_breach_start_delay);
	maps\_utility::script_delay();
	self notify("starting_breach_reaction");
	level notify("breach_enemy_anims");
	var_00 maps\_anim::anim_generic_gravity(self,self.animation);
	self notify("finished_breach_start_anim");
}

//Function Number: 69
record_last_player_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isalive(param_01))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	if(!self isbadguy())
	{
		return;
	}

	level.last_player_damage = gettime();
}

//Function Number: 70
breach_enemy_ignored_by_friendlies()
{
	self endon("death");
	if(!common_scripts\utility::flag("no_mercy"))
	{
		self.ignoreme = 1;
	}

	level common_scripts\utility::waittill_either("slomo_breach_over","friendlies_finished_breach");
	if(isdefined(self))
	{
		self.ignoreme = 0;
	}
}

//Function Number: 71
breach_enemy_ragdoll_on_death()
{
	self endon("breach_enemy_cancel_ragdoll_death");
	self.ragdoll_immediate = 1;
	var_00 = common_scripts\utility::waittill_any_return("death","finished_breach_start_anim");
	if(var_00 == "finished_breach_start_anim")
	{
		self.ragdoll_immediate = undefined;
	}
}

//Function Number: 72
breach_enemy_cancel_ragdoll()
{
	self notify("breach_enemy_cancel_ragdoll_death");
	self.ragdoll_immediate = undefined;
}

//Function Number: 73
breach_enemy_track_status(param_00)
{
	level.breachenemies_active++;
	var_01 = spawnstruct();
	var_01.enemy = param_00;
	var_01 thread breach_enemy_waitfor_death(param_00);
	var_01 thread breach_enemy_waitfor_death_counter(param_00);
	var_01 thread breach_enemy_catch_exceptions(param_00);
	var_01 thread breach_enemy_waitfor_breach_ending();
	var_01 waittill("breach_status_change",var_02);
	level.breachenemies_active--;
	var_01 = undefined;
}

//Function Number: 74
breach_enemy_waitfor_death(param_00)
{
	self endon("breach_status_change");
	param_00 waittill("death");
	self notify("breach_status_change","death");
}

//Function Number: 75
breach_enemy_waitfor_death_counter(param_00)
{
	level.breachenemies_alive++;
	param_00 waittill("death");
	level.breachenemies_alive--;
	if(level.breachenemies_alive <= 0)
	{
		breach_friendlies_restore_grenades();
	}

	level notify("breach_all_enemies_dead");
}

//Function Number: 76
breach_enemy_catch_exceptions(param_00)
{
	self endon("breach_status_change");
	while(isalive(param_00))
	{
		wait(0.05);
	}

	self notify("breach_status_change","exception");
}

//Function Number: 77
breach_enemy_waitfor_breach_ending()
{
	self endon("breach_status_change");
	level waittill("slowmo_breach_ending");
	self notify("breach_status_change","breach_ending");
}

//Function Number: 78
breach_hostage_spawner_think()
{
	self endon("death");
	self.breachfinished = 0;
	var_00 = self.spawner;
	self.reference = var_00;
	self endon("cancel_breach_behavior");
	thread hostage_mission_fail();
	maps\_anim::anim_generic_first_frame(self,self.animation);
	self.health = 10;
	self.no_friendly_fire_penalty = 1;
	self.ignorerandombulletdamage = 1;
	wait(level.slowmo_breach_start_delay);
	if(isdefined(level._slowmo_functions[self.animation]))
	{
		var_01 = level._slowmo_functions[self.animation];
		self thread [[ var_01 ]]();
	}

	self.allowdeath = 1;
	var_00 maps\_anim::anim_generic(self,self.animation);
	self notify("finished_breach_start_anim");
	if(isdefined(self.skipendingidle))
	{
		return;
	}

	if(anim_exists(self.animation + "_idle"))
	{
		thread maps\_anim::anim_generic_loop(self,self.animation + "_idle","stop_idle");
	}
	else
	{
		var_02 = "hostage_knees_loop";
		thread maps\_anim::anim_generic_loop(self,var_02,"stop_idle");
	}

	self.breachfinished = 1;
}

//Function Number: 79
hostage_health_regen()
{
	var_00 = self.health;
	self endon("death");
	self endon("saved");
	while(isdefined(self))
	{
		self waittill("damage",var_01,var_02);
		if(isdefined(var_02))
		{
			if(isplayer(var_02))
			{
				self kill(self.origin,level.player);
				break;
			}
			else if(isdefined(var_02.team) && var_02.team == "allies")
			{
				self.health = var_00;
			}
		}
	}
}

//Function Number: 80
get_room_volume_from_slomo_breach_number(param_00)
{
	return level.breach_groups[param_00].room_volume;
}

//Function Number: 81
hostage_mission_fail()
{
	if(maps\_utility::is_specialop())
	{
		level endon("special_op_terminated");
	}

	level endon("mission failed");
	var_00 = self.health;
	var_01 = 0;
	thread hostage_health_regen();
	var_02 = get_room_volume_from_slomo_breach_number(self.script_slowmo_breach);
	if(getdvar("hostage_missionfail") == "0")
	{
		return;
	}

	while(isdefined(self))
	{
		self waittill("death",var_03);
		if(isdefined(var_03))
		{
			if(isplayer(var_03))
			{
				level notify("player_shot_a_hostage");
				waittillframeend;
				if(level.last_player_damage == gettime())
				{
					maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE");
				}
				else
				{
					maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE","@SCRIPT_MISSIONFAIL_KILLEDHOSTAGE");
				}

				var_01 = 1;
			}
			else if(isdefined(var_03.team) && var_03.team == "allies" && !isplayer(var_03))
			{
				maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED");
				var_01 = 1;
			}
			else
			{
				if(coop_breached_from_same_door_in_a_muliti_door_room(var_02))
				{
					maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR");
				}
				else
				{
					maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED");
				}

				var_01 = 1;
			}
		}

		if(var_01 == 1)
		{
			thread maps\_utility::missionfailedwrapper();
			level notify("mission failed");
		}
	}
}

//Function Number: 82
coop_breached_from_same_door_in_a_muliti_door_room(param_00)
{
	if(!maps\_utility::is_specialop())
	{
		return 0;
	}

	if(!maps\_utility::is_coop())
	{
		return 0;
	}

	if(isdefined(param_00.has_passive_breacher))
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
script_models()
{
	level.scr_anim["breach_door_model"]["breach"] = %breach_player_door_v2;
	level.scr_animtree["breach_door_model"] = #animtree;
	level.scr_model["breach_door_model"] = "com_door_01_handleright";
	level.scr_anim["breach_door_hinge"]["breach"] = %breach_player_door_hinge_v1;
	level.scr_animtree["breach_door_hinge"] = #animtree;
	level.scr_model["breach_door_hinge"] = "com_door_piece_hinge";
	level.scr_anim["breach_door_model_metal"]["breach"] = %breach_player_door_v2;
	level.scr_animtree["breach_door_model_metal"] = #animtree;
	level.scr_model["breach_door_model_metal"] = "breach_door_metal_right";
	level.scr_anim["breach_door_hinge_metal"]["breach"] = %breach_player_door_metal;
	level.scr_animtree["breach_door_hinge_metal"] = #animtree;
	level.scr_model["breach_door_hinge_metal"] = "breach_door_metal_right_dst";
	level.scr_anim["breach_door_charge"]["breach"] = %breach_player_frame_charge_v3;
	level.scr_animtree["breach_door_charge"] = #animtree;
	level.scr_model["breach_door_charge"] = "mil_frame_charge";
	level.scr_animtree["desk"] = #animtree;
	level.scr_anim["desk"]["breach_react_desk_v7_desk"] = %breach_react_desk_v7_desk;
	level.scr_animtree["chair"] = #animtree;
	level.scr_anim["chair"]["breach_chair_hide_reaction_v2_chair"] = %breach_chair_hide_reaction_v2_chair;
	level.scr_anim["chair"]["breach_chair_hide_reaction_death_v2_chair"] = %breach_chair_hide_reaction_death_v2_chair;
}

//Function Number: 84
set_door_charge_anim_normal()
{
	level.scr_anim["breach_door_charge"]["breach"] = %breach_player_frame_charge_v3;
}

//Function Number: 85
set_door_charge_anim_special()
{
	level.scr_anim["breach_door_charge"]["breach"] = %breach_player_frame_charge;
}

//Function Number: 86
player_animations()
{
	if(!isdefined(level.slowmo_viewhands))
	{
		level.slowmo_viewhands = "viewhands_player_sas_woodland";
	}

	level.scr_animtree["active_breacher_rig"] = #animtree;
	level.scr_model["active_breacher_rig"] = level.slowmo_viewhands;
	level.scr_anim["active_breacher_rig"]["breach_player_anim"] = %breach_coop_player_1;
	level._slowmo_breach_funcs = [];
	add_breach_func(::breach_explosion);
	maps\_anim::addnotetrack_customfunction("active_breacher_rig","explode",::breach_functions);
	maps\_anim::addnotetrack_customfunction("active_breacher_rig","slowmo",::slowmo_begins);
}

//Function Number: 87
add_breach_func(param_00)
{
	level._slowmo_breach_funcs[level._slowmo_breach_funcs.size] = param_00;
}

//Function Number: 88
breach_functions(param_00)
{
	foreach(var_02 in level._slowmo_breach_funcs)
	{
		thread [[ var_02 ]](param_00);
	}
}

//Function Number: 89
breach_explosion(param_00)
{
	var_01 = level.breach_groups[self.breach_index];
	var_02 = undefined;
	var_03 = undefined;
	switch(var_01.doortype)
	{
		case "wood":
			var_02 = "detpack_explo_wood";
			var_03 = "breach_door_hinge";
			break;

		case "estate_wood":
			var_02 = "detpack_explo_wood";
			var_03 = "breach_door_hinge_estate";
			break;

		case "estate_wood_backwards":
			var_02 = "detpack_explo_wood";
			var_03 = undefined;
			break;

		case "caves_wood":
			var_02 = "detpack_explo_wood";
			var_03 = "breach_door_hinge_caves";
			break;

		case "payback_wood":
			var_02 = "pybk_breach_blast";
			var_03 = "breach_door_hinge_payback";
			break;

		case "metal":
			var_02 = "detpack_explo_metal";
			var_03 = "breach_door_hinge_metal";
			break;

		case "none":
			var_02 = "detpack_explo_concrete";
			break;

		default:
			break;
	}

	if(isdefined(var_02))
	{
		thread common_scripts\utility::play_sound_in_space(var_02,self.charge.origin);
	}

	common_scripts\_exploder::exploder("breach_" + self.breach_index);
	thread breach_rumble(self.charge.origin);
	self.charge delete();
	level notify("breach_explosion");
	if(isdefined(var_03))
	{
		var_04 = maps\_utility::spawn_anim_model(var_03);
		self.post thread maps\_anim::anim_single_solo(var_04,"breach");
	}

	wait(0.05);
	if(isdefined(self.door))
	{
		self.door delete();
	}
}

//Function Number: 90
breach_rumble(param_00)
{
	var_01 = spawn("script_origin",param_00);
	var_01.origin = param_00;
	var_01 playrumbleonentity("grenade_rumble");
	wait(4);
	var_01 delete();
}

//Function Number: 91
_slomo_breach_executioner_knife()
{
	self endon("death");
	self.dodamagetoall = 1;
	thread knife_guy_cleanup();
}

//Function Number: 92
_slomo_breach_executioner_pistol()
{
	self endon("death");
	self.dodamagetoall = 1;
	thread _slomo_breach_pistol_guy();
}

//Function Number: 93
_slomo_breach_pistol_guy()
{
	animscripts\notetracks::notetrackpistolpickup();
}

//Function Number: 94
_slomo_breach_blowback_guy()
{
	self endon("death");
	if(!common_scripts\utility::flag("no_mercy"))
	{
		self.ignoreme = 1;
	}

	self.forcelongdeath = 1;
	maps\_utility::waittill_notetrack_or_damage("bodyfall large");
	self waittill("finished_breach_start_anim");
	self dodamage(self.health - 1,self.origin);
}

//Function Number: 95
_slomo_breach_executed_guy()
{
	if(self.animation == "execution_knife_hostage" || self.animation == "execution_knife2_hostage")
	{
		thread _slomo_breach_knife_hostage_death();
	}

	if(will_be_manhandled())
	{
		thread get_manhandled();
	}

	self.skipendingidle = 1;
	self endon("death");
	maps\_utility::set_generic_deathanim(self.animation + "_death");
	self waittill("finished_breach_start_anim");
	if(isdefined(self.manhandled))
	{
		return;
	}

	if(anim_exists(self.animation + "_survives"))
	{
		self.reference maps\_anim::anim_generic(self,self.animation + "_survives");
	}

	thread maps\_anim::anim_generic_loop(self,self.animation + "_idle","stop_idle");
	self.breachfinished = 1;
}

//Function Number: 96
_slomo_breach_hostage_react()
{
	if(will_be_manhandled())
	{
		thread get_manhandled();
	}

	self.skipendingidle = 1;
	self waittill("finished_breach_start_anim");
	if(isdefined(self.manhandled))
	{
		return;
	}

	if(anim_exists(self.animation + "_idle"))
	{
		thread maps\_anim::anim_generic_loop(self,self.animation + "_idle","stop_idle");
	}

	self.breachfinished = 1;
}

//Function Number: 97
_slomo_breach_c4_hostage()
{
	var_00 = spawn("script_model",self.reference.origin);
	var_00 setmodel("com_restaurantchair_2");
	var_00.angles = self.reference.angles + (0,90,0);
	var_00.origin = self.reference.origin;
}

//Function Number: 98
_slomo_breach_knife_hostage_death()
{
	var_00 = maps\_utility::get_closest_ai(self.origin,"bad_guys");
	self waittill("finished_breach_start_anim");
	if(isdefined(var_00) && isalive(var_00))
	{
		playfxontag(common_scripts\utility::getfx("breach_knife_execution"),self,"J_neck");
		thread maps\_utility::play_sound_on_entity("melee_knife_hit_body");
		self kill();
	}
}

//Function Number: 99
_slomo_breach_executed_guy_pushed_to_floor()
{
	self.skipendingidle = 1;
	self endon("death");
	if(will_be_manhandled())
	{
		thread get_manhandled();
	}

	self waittillmatch("bodyfall large","single anim");
	maps\_utility::set_generic_deathanim(self.animation + "_death");
	self waittill("finished_breach_start_anim");
	maps\_anim::anim_generic(self,self.animation + "_survives");
	if(isdefined(self.manhandled))
	{
		return;
	}

	thread maps\_anim::anim_generic_loop(self,"hostage_knees_loop","stop_idle");
	self.breachfinished = 1;
}

//Function Number: 100
_slomo_breach_fightback_guy()
{
	self.skipendingidle = 1;
	self endon("death");
	self waittill("finished_breach_start_anim");
	maps\_utility::set_generic_deathanim(self.animation + "_death");
	maps\_anim::anim_generic(self,self.animation + "_survives");
	thread maps\_anim::anim_generic_loop(self,"hostage_knees_loop","stop_idle");
	self.breachfinished = 1;
}

//Function Number: 101
_slomo_breach_knife_charger()
{
	self endon("death");
	breach_enemy_cancel_ragdoll();
	maps\_utility::set_generic_deathanim(self.animation + "_death");
	self waittillmatch("stab","single anim");
	wait(0.1);
	thread knife_guy_stabs_player();
	self waittill("finished_breach_start_anim");
}

//Function Number: 102
knife_guy_stabs_player()
{
	var_00 = maps\_utility::get_closest_player(self.origin);
	var_01 = distance(var_00.origin,self.origin);
	if(var_01 <= 50)
	{
		var_00 playrumbleonentity("grenade_rumble");
		var_00 thread maps\_utility::play_sound_on_entity("melee_knife_hit_body");
		var_00 enablehealthshield(0);
		var_00 enabledeathshield(0);
		waittillframeend;
		var_00 dodamage(var_00.health + 50000,self gettagorigin("tag_weapon_right"),self);
		var_00.breach_missionfailed = 1;
	}
}

//Function Number: 103
knife_guy_cleanup()
{
	wait(0.5);
	common_scripts\utility::waittill_either("damage","finished_breach_start_anim");
	if(isdefined(self))
	{
		self detach("weapon_parabolic_knife","TAG_INHAND");
	}
}

//Function Number: 104
_slomo_breach_chair_guy_normal()
{
	self endon("death");
	breach_enemy_cancel_ragdoll();
	var_00 = randomintrange(1,3);
	if(common_scripts\utility::cointoss())
	{
		maps\_utility::set_generic_deathanim(self.animation + "_death");
		return;
	}

	maps\_utility::set_generic_deathanim(self.animation + "_death2");
}

//Function Number: 105
_slomo_breach_chair_guy_animated()
{
	self endon("death");
	breach_enemy_cancel_ragdoll();
	maps\_utility::set_generic_deathanim(self.animation + "_death");
	thread chair_animate();
	self waittill("finished_breach_start_anim");
	thread _slomo_breach_chair_guy_normal();
}

//Function Number: 106
chair_animate()
{
	var_00 = spawn("script_model",self.reference.origin);
	var_00 setmodel("furniture_chair_metal01");
	var_00.animname = "chair";
	var_00 maps\_utility::assign_animtree();
	var_00.reference = spawn("script_origin",self.reference.origin);
	var_00.reference.angles = self.reference.angles;
	self waittill("starting_breach_reaction");
	var_00.reference thread maps\_anim::anim_single_solo(var_00,"breach_chair_hide_reaction_v2_chair");
	self endon("finished_breach_start_anim");
	if(isalive(self))
	{
		self waittill("death");
		var_00.reference thread maps\_anim::anim_single_solo(var_00,"breach_chair_hide_reaction_death_v2_chair");
	}
}

//Function Number: 107
_slomo_breach_desk_guy()
{
	self endon("death");
	thread desk_animate();
	self waittill("finished_breach_start_anim");
}

//Function Number: 108
desk_animate()
{
	var_00 = spawn("script_model",self.reference.origin);
	var_00 setmodel("furniture_long_desk_animate");
	var_00.animname = "desk";
	var_00 maps\_utility::assign_animtree();
	var_00.reference = spawn("script_origin",self.reference.origin);
	var_00.reference.angles = self.reference.angles;
	self waittill("starting_breach_reaction");
	var_00.reference thread maps\_anim::anim_single_solo(var_00,"breach_react_desk_v7_desk");
}

//Function Number: 109
breach_near_player(param_00)
{
	foreach(var_02 in level.breach_groups)
	{
		if(param_00 istouching(var_02.door_volume))
		{
			return var_02;
		}
	}
}

//Function Number: 110
get_breach_groups()
{
	var_00 = getarraykeys(level.breach_groups);
	return var_00;
}

//Function Number: 111
make_empty_breach(param_00)
{
	level.breach_groups[param_00].enabled = 0;
}

//Function Number: 112
delete_breach(param_00)
{
	level.breach_groups[param_00].trigger delete();
	var_01 = level.breach_groups[param_00].path_solids;
	common_scripts\utility::array_call(var_01,::connectpaths);
	common_scripts\utility::array_thread(var_01,::maps\_utility::self_delete);
	foreach(var_03 in level.breach_groups[param_00].lookat_triggers)
	{
		var_03 delete();
	}
}

//Function Number: 113
breach_debug_display_animnames(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	var_01 = self.origin;
	wait(0.05);
	if(getdvar("breach_debug") == "0")
	{
		return;
	}

	var_02 = [];
	var_03 = getentarray("breach_enemy_spawner","targetname");
	var_04 = getentarray("breach_hostage_spawner","targetname");
	var_02 = maps\_utility::array_merge(var_03,var_04);
	foreach(var_06 in var_02)
	{
		if(!var_06 istouching(param_00))
		{
			var_02 = common_scripts\utility::array_remove(var_02,var_06);
		}
	}

	while(!param_00.breached)
	{
		var_08 = var_01;
		foreach(var_06 in var_02)
		{
			if(isdefined(var_06.animation))
			{
				thread maps\_utility::debug_message(var_06.animation,var_08,1);
				var_08 = var_08 - (0,0,10);
			}
		}

		wait(1);
	}
}

//Function Number: 114
will_be_manhandled()
{
	if(maps\_utility::is_coop())
	{
		return 0;
	}

	if(isdefined(level.hostagemanhandle) && level.hostagemanhandle == 0)
	{
		return 0;
	}

	if(isdefined(self.script_noteworthy))
	{
		return self.script_noteworthy == "manhandled" || self.script_noteworthy == "manhandled_guarded";
	}

	return 0;
}

//Function Number: 115
manhandler_hold()
{
	if(level.breachenemies_alive > 0)
	{
		return 1;
	}

	if(!self.startmanhandling)
	{
		return 1;
	}

	return 0;
}

//Function Number: 116
get_manhandled()
{
	self endon("death");
	self.manhandled = 1;
	self.readytobemanhandled = 0;
	self.startmanhandling = 0;
	var_00 = undefined;
	if(self.script_noteworthy == "manhandled")
	{
		var_00 = getent(self.target,"targetname");
	}

	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = "";
	if(isdefined(self.script_parameters))
	{
		var_06 = self.script_parameters;
	}

	switch(self.script_noteworthy)
	{
		case "manhandled":
			var_04 = self.animation + "_manhandled";
			break;

		case "manhandled_guarded":
			var_04 = self.animation + "_manhandled_guarded";
			break;
	}

	var_05 = var_04 + "_idle" + var_06;
	var_02 = var_04 + "_prepare" + var_06;
	var_03 = var_04 + "_prepare_idle" + var_06;
	var_04 = var_04 + var_06;
	assert_if_anim_not_defined(var_04);
	assert_if_anim_not_defined(var_05);
	if(self.script_noteworthy == "manhandled")
	{
		var_01 = var_00 maps\_utility::spawn_ai(1);
		var_01 hide();
		self.reference maps\_anim::anim_generic_first_frame(var_01,var_01.animation);
		var_01 pushplayer(1);
		level.manhandler = var_01;
		var_01.readytomanhandle = 0;
		var_01 thread manhandler_think();
	}

	wait(1);
	if(self.script_noteworthy == "manhandled")
	{
		var_01 show();
	}

	self waittill("finished_breach_start_anim");
	if(anim_exists(var_02))
	{
		self.reference maps\_anim::anim_generic(self,var_02);
	}

	if(anim_exists(var_03))
	{
		self.reference thread maps\_anim::anim_generic_loop(self,var_03,"stop_idle");
	}
	else
	{
		var_03 = undefined;
	}

	self.readytobemanhandled = 1;
	if(isdefined(var_03))
	{
		while(manhandler_hold())
		{
			wait(0.05);
		}
	}

	self.reference notify("stop_idle");
	self notify("stop_idle");
	if(self.script_noteworthy == "manhandled")
	{
		self.reference thread maps\_anim::anim_generic(var_01,var_01.animation);
	}

	self.reference maps\_anim::anim_generic(self,var_04);
	if(isdefined(var_01) && isdefined(level.scr_anim["generic"][var_01.animation + "_idle"]))
	{
		self.reference thread maps\_anim::anim_generic_loop(var_01,var_01.animation + "_idle","stop_idle");
	}

	if(isdefined(level.scr_anim["generic"][var_05]))
	{
		self.reference thread maps\_anim::anim_generic_loop(self,var_05,"stop_idle");
	}
}

//Function Number: 117
special_gulag_adjustment()
{
	var_00 = level.player getplayerangles();
	var_00 = (0,var_00[1],0);
	var_01 = anglestoforward(var_00);
	var_02 = anglestoup(var_00);
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03.origin = level.player.origin;
	var_03.angles = var_00;
	level.player playerlinktodelta(var_03,"tag_origin",1,45,45,90,45,1);
	var_04 = 0.45;
	var_03 moveto(var_03.origin + var_01 * 32 + var_02 * -14,var_04,var_04 * 0.4,var_04 * 0.4);
	wait(var_04);
	level.player setmovespeedscale(0.5);
	thread player_slows_down();
	level.player unlink();
	level.price_breach_ent thread price_breach_ent_rotatesto_player();
	level.price_breach_ent thread price_breach_ent_movesto_player();
}

//Function Number: 118
player_slows_down()
{
	wait(0.25);
	var_00 = level maps\_utility::create_blend(::player_loses_speedscale,0.5,0);
	var_00.time = 1.5;
}

//Function Number: 119
price_breach_ent_movesto_player()
{
	self endon("stop_following_player");
	wait(1.5);
	for(;;)
	{
		self moveto(level.player.origin,2,0,0);
		wait(0.05);
	}
}

//Function Number: 120
price_breach_ent_rotatesto_player()
{
	self endon("stop_following_player");
	var_00 = spawn("script_origin",(0,0,0));
	for(;;)
	{
		var_01 = level.player.origin;
		var_01 = maps\_utility::set_z(var_01,0);
		var_02 = self.origin;
		var_02 = maps\_utility::set_z(var_02,0);
		var_03 = vectortoangles(var_01 - var_02);
		var_04 = anglestoforward(var_03);
		var_05 = anglestoforward(self.angles);
		var_06 = anglestoright(self.angles);
		var_07 = vectordot(var_04,var_06);
		var_00.angles = self.angles;
		var_08 = abs(acos(var_07));
		var_09 = 2;
		if(var_09 > var_08)
		{
			var_09 = var_08;
		}

		if(var_07 < 0)
		{
			var_00 addyaw(var_09);
		}
		else
		{
			var_00 addyaw(var_09 * -1);
		}

		self rotateto(var_00.angles,0.15);
		wait(0.15);
	}
}

//Function Number: 121
player_loses_speedscale(param_00,param_01,param_02)
{
	level.player setmovespeedscale(param_01 * 1 - param_00 + param_02 * param_00);
}

//Function Number: 122
manhandler_think()
{
	level endon("mission failed");
	if(getdvar("hostage_missionfail") == "1")
	{
		level endon("player_shot_a_hostage");
	}

	thread maps\_utility::magic_bullet_shield();
	maps\_utility::setflashbangimmunity(1);
	if(!common_scripts\utility::flag("no_mercy"))
	{
		self.ignoreme = 1;
	}

	self.grenadeawareness = 0;
	wait(1);
	var_00 = [];
	var_01 = getaispeciesarray("neutral","civilian");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.readytobemanhandled))
		{
			continue;
		}

		if(isdefined(var_03.script_slowmo_breach) && var_03.script_slowmo_breach == self.script_slowmo_breach)
		{
			if(isdefined(var_03.script_noteworthy) && issubstr(var_03.script_noteworthy,"manhandled"))
			{
				var_00 = common_scripts\utility::array_add(var_00,var_03);
			}
		}
	}

	var_05 = var_00.size;
	var_06 = var_00;
	while(var_05 > 0)
	{
		wait(0.05);
		foreach(var_03 in var_06)
		{
			if(!isdefined(var_03) || var_03.readytobemanhandled == 1)
			{
				var_06 = common_scripts\utility::array_remove(var_06,var_03);
				var_05--;
			}
		}
	}

	foreach(var_03 in var_00)
	{
		if(isdefined(var_03))
		{
			var_03.startmanhandling = 1;
		}
	}
}

//Function Number: 123
assert_if_anim_not_defined(param_00)
{
}

//Function Number: 124
anim_exists(param_00)
{
	if(isdefined(level.scr_anim["generic"][param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 125
add_slowmo_breach_custom_function(param_00,param_01)
{
	level._slowmo_functions[param_00] = param_01;
}

//Function Number: 126
add_slowmo_breacher()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(level.breachfriendlies))
	{
		level.breachfriendlies = [];
		level.breachfriendlies[0] = self;
		return;
	}

	if(maps\_utility::is_in_array(level.breachfriendlies,self))
	{
		return;
	}

	level.breachfriendlies = common_scripts\utility::array_add(level.breachfriendlies,self);
}

//Function Number: 127
remove_slowmo_breacher()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(level.breachfriendlies))
	{
		return;
	}

	if(maps\_utility::is_in_array(level.breachfriendlies,self))
	{
		level.breachfriendlies = common_scripts\utility::array_remove(level.breachfriendlies,self);
	}
}

//Function Number: 128
breach_failed_to_start()
{
	var_00 = [];
	var_00[var_00.size] = ::ismeleeing;
	var_00[var_00.size] = ::isreloading;
	var_00[var_00.size] = ::isthrowinggrenade;
	foreach(var_02 in level.players)
	{
		if(var_02 isreloading())
		{
			thread breach_reloading_hint();
			return 1;
		}

		if(var_02 using_illegal_breach_weapon())
		{
			thread breach_bad_weapon_hint();
			return 1;
		}

		foreach(var_04 in var_00)
		{
			if(var_02 [[ var_04 ]]())
			{
				thread breach_not_ready_hint();
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 129
using_illegal_breach_weapon()
{
	var_00 = [];
	var_00["riotshield"] = 1;
	var_00["claymore"] = 1;
	var_00["c4"] = 1;
	var_00["none"] = 1;
	var_01 = self getcurrentweapon();
	return isdefined(var_00[var_01]);
}

//Function Number: 130
slomo_sound_scale_setup()
{
}