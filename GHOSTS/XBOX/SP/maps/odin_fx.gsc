/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_fx.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 62
 * Decompile Time: 1044 ms
 * Timestamp: 10/27/2023 1:38:09 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level._effect["vfx_scrnfx_space_glass_fog"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_space_glass_fog");
	level._effect["vfx_scrnfx_space_glass"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_space_glass");
	level._effect["vfx_shuttle_manuvr_thrust"] = loadfx("vfx/moments/odin/vfx_shuttle_manuvr_thrust");
	level._effect["glow_red_light_400_strobe"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_400_strobe");
	level._effect["light_blue_steady_FX"] = loadfx("fx/misc/tower_light_blue_steady");
	level._effect["amber_light_45_beacon_nolight_glow"] = loadfx("vfx/ambient/lights/amber_light_45_beacon_nolight_glow");
	level._effect["strobe_flash_distant"] = loadfx("vfx/moments/odin/strobe_flash_distant");
	level._effect["odin_fire_close"] = loadfx("vfx/moments/odin/odin_fire_close");
	level._effect["space_microtar_shot"] = loadfx("vfx/gameplay/muzzle_flashes/smg/vfx_muz_smg_v");
	level._effect["space_clip_reload"] = loadfx("vfx/gameplay/space/space_clip_reload");
	level._effect["space_clip_reload_odin_ext"] = loadfx("vfx/gameplay/space/space_clip_reload_odin_ext");
	level._effect["electrical_transformer_explosion"] = loadfx("fx/explosions/electrical_transformer_explosion");
	level._effect["electrical_transformer_spark_runner_tight"] = loadfx("fx/explosions/electrical_transformer_spark_runner_tight");
	level._effect["electrical_transformer_sparks_a_cone"] = loadfx("fx/explosions/electrical_transformer_sparks_a_cone");
	level._effect["steam_jet_large"] = loadfx("fx/smoke/steam_jet_large");
	level._effect["flashlight"] = loadfx("vfx/moments/odin/flashlight_spotlight_odin_bright");
	level._effect["vfx_kyra_impact_head_space"] = loadfx("vfx/moments/odin/vfx_kyra_impact_head_space");
	level._effect["vfx_kyra_impact_head_space_blood"] = loadfx("vfx/moments/odin/vfx_kyra_impact_head_space_blood");
	level._effect["sun_lens_flare"] = loadfx("vfx/moments/odin/odin_sun_flare");
	level._effect["amber_light_45_flare_nolight"] = loadfx("vfx/ambient/lights/amber_light_45_flare_nolight");
	level._effect["blood_impact_space"] = loadfx("vfx/moments/odin/vfx_blood_impact_space");
	level._effect["blue_light_100_nolight"] = loadfx("vfx/ambient/lights/blue_light_100_nolight");
	level._effect["ext_dust_motes"] = loadfx("vfx/moments/odin/vfx_ext_dust_motes");
	level._effect["fuel_explosion_zerog"] = loadfx("vfx/moments/loki/fuel_explosion_zerog");
	level._effect["fuel_fire_zerog_small"] = loadfx("vfx/moments/loki/vfx_fuel_fire_zerog_small");
	level._effect["fuel_leak_zerog_small"] = loadfx("vfx/moments/loki/vfx_fuel_leak_zerog_small");
	level._effect["int_space_smoke"] = loadfx("vfx/moments/odin/vfx_int_space_smoke");
	level._effect["odin_airlock_dust"] = loadfx("vfx/moments/odin/odin_airlock_dust");
	level._effect["odin_airlock_dust_excited"] = loadfx("vfx/moments/odin/odin_airlock_dust_excited");
	level._effect["odin_airlock_steam"] = loadfx("vfx/moments/odin/odin_airlock_steam");
	level._effect["odin_blood_splat_48"] = loadfx("vfx/moments/odin/odin_blood_splat_48");
	level._effect["odin_burnup_kyra_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_kyra_trail_runner");
	level._effect["odin_burnup_player_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_player_trail_runner");
	level._effect["odin_burnup_sat_door_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_sat_door_trail_runner");
	level._effect["odin_burnup_sat_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_sat_trail_runner");
	level._effect["odin_burnup_scrnfx"] = loadfx("vfx/moments/odin/odin_burnup_scrnfx");
	level._effect["odin_debris_field_high_runner"] = loadfx("vfx/moments/odin/odin_debris_field_high_runner");
	level._effect["odin_debris_field_low_runner"] = loadfx("vfx/moments/odin/odin_debris_field_low_runner");
	level._effect["odin_debris_field_max_runner"] = loadfx("vfx/moments/odin/odin_debris_field_max_runner");
	level._effect["odin_debris_field_med_runner"] = loadfx("vfx/moments/odin/odin_debris_field_med_runner");
	level._effect["odin_escape_godray"] = loadfx("vfx/moments/odin/odin_escape_godray");
	level._effect["odin_fire_flare_runner"] = loadfx("vfx/moments/odin/odin_fire_flare_runner");
	level._effect["odin_helmet_glass_shatter"] = loadfx("vfx/moments/odin/odin_helmet_glass_shatter");
	level._effect["odin_int_dust"] = loadfx("vfx/moments/odin/odin_int_dust");
	level._effect["odin_int_white_light_rect"] = loadfx("vfx/moments/odin/odin_int_white_light_rect");
	level._effect["odin_int_white_light_rect_glow"] = loadfx("vfx/moments/odin/odin_int_white_light_rect_glow");
	level._effect["odin_rog_barrel_flash"] = loadfx("vfx/moments/odin/odin_rog_barrel_flash");
	level._effect["odin_rog_flash"] = loadfx("vfx/moments/odin/odin_rog_flash");
	level._effect["odin_rog_impact"] = loadfx("vfx/moments/odin/odin_rog_impact");
	level._effect["odin_rog_plume_01"] = loadfx("vfx/moments/odin/odin_rog_plume_01");
	level._effect["odin_rog_plume_02"] = loadfx("vfx/moments/odin/odin_rog_plume_02");
	level._effect["odin_rog_plume_03"] = loadfx("vfx/moments/odin/odin_rog_plume_03");
	level._effect["odin_rog_trail_flare"] = loadfx("vfx/moments/odin/odin_rog_trail_flare");
	level._effect["odin_rog_trail_geotrail_runner"] = loadfx("vfx/moments/odin/odin_rog_trail_geotrail_runner");
	level._effect["odin_sat_exp_rcs_fire_runner"] = loadfx("vfx/moments/odin/odin_sat_exp_rcs_fire_runner");
	level._effect["odin_sat_rcs_fire_puff"] = loadfx("vfx/moments/odin/odin_sat_rcs_fire_puff");
	level._effect["odin_sat_rcs_fuel_fire"] = loadfx("vfx/moments/odin/odin_sat_rcs_fuel_fire");
	level._effect["odin_sat_red_light"] = loadfx("vfx/moments/odin/odin_sat_red_light");
	level._effect["odin_sat_red_light_blinker_runner"] = loadfx("vfx/moments/odin/odin_sat_red_light_blinker_runner");
	level._effect["odin_sat_thrusters_ignite_sporadic"] = loadfx("vfx/moments/odin/odin_sat_thrusters_ignite_sporadic");
	level._effect["odin_sat_thrusters_runner"] = loadfx("vfx/moments/odin/odin_sat_thrusters_runner");
	level._effect["odin_shuttle_dock_steam"] = loadfx("vfx/moments/odin/odin_shuttle_dock_steam");
	level._effect["odin_spin_decompression"] = loadfx("vfx/moments/odin/odin_spin_decompression");
	level._effect["odin_spin_implosion"] = loadfx("vfx/moments/odin/odin_spin_implosion");
	level._effect["odin_spin_piece_debris"] = loadfx("vfx/moments/odin/odin_spin_piece_debris");
	level._effect["odin_spin_piece_debris_runner"] = loadfx("vfx/moments/odin/odin_spin_piece_debris_runner");
	level._effect["odin_spin_solar_flash"] = loadfx("vfx/moments/odin/odin_spin_solar_flash");
	level._effect["odin_spin_solar_player_debris"] = loadfx("vfx/moments/odin/odin_spin_solar_player_debris");
	level._effect["odin_spin_solar_runner"] = loadfx("vfx/moments/odin/odin_spin_solar_runner");
	level._effect["red_light_45_flare_nolight"] = loadfx("vfx/ambient/lights/red_light_45_flare_nolight");
	level._effect["red_light_45_rect_nolight"] = loadfx("vfx/ambient/lights/red_light_45_rect_nolight");
	level._effect["space_jet_small"] = loadfx("vfx/gameplay/space/space_jet_small");
	level._effect["spc_battle_smoke_200"] = loadfx("vfx/ambient/space/spc_battle_smoke_200");
	level._effect["spc_battle_smoke_200_thick"] = loadfx("vfx/ambient/space/spc_battle_smoke_200_thick");
	level._effect["spc_explosion_1200"] = loadfx("vfx/gameplay/space/spc_explosion_1200");
	level._effect["spc_explosion_240"] = loadfx("vfx/gameplay/space/spc_explosion_240");
	level._effect["spc_fire_big_light"] = loadfx("vfx/ambient/space/spc_fire_big_light");
	level._effect["spc_fire_oriented"] = loadfx("vfx/ambient/space/spc_fire_oriented");
	level._effect["spc_fire_oriented_big"] = loadfx("vfx/ambient/space/spc_fire_oriented_big");
	level._effect["spc_fire_puff_bigger_light"] = loadfx("vfx/ambient/space/spc_fire_puff_bigger_light");
	level._effect["spc_shell_casings"] = loadfx("vfx/ambient/space/spc_shell_casings");
	level._effect["spc_sparks_jet_single_runner"] = loadfx("vfx/ambient/space/spc_sparks_jet_single_runner");
	level._effect["station_piece_collision"] = loadfx("vfx/moments/odin/station_piece_collision");
	level._effect["warm_light_30_rect_nolight"] = loadfx("vfx/ambient/lights/warm_light_30_rect_nolight");
	level._effect["white_light_40_nolight"] = loadfx("vfx/ambient/lights/white_light_40_nolight");
	level._effect["zg_electrical_sparks_big"] = loadfx("vfx/ambient/space/zg_electrical_sparks_big");
	level._effect["zg_electrical_sparks_big_single_runner"] = loadfx("vfx/ambient/space/zg_electrical_sparks_big_single_runner");
	level._effect["zg_electrical_sparks_runner"] = loadfx("vfx/ambient/space/zg_electrical_sparks_runner");
	level._effect["zg_electrical_sparks_runner_40"] = loadfx("vfx/ambient/space/zg_electrical_sparks_runner_40");
	level._effect["zg_fire_jet"] = loadfx("vfx/ambient/space/zg_fire_jet");
	level._effect["zg_fire_puff"] = loadfx("vfx/ambient/space/zg_fire_puff");
	level._effect["zg_fire_puff_single"] = loadfx("vfx/ambient/space/zg_fire_puff_single");
	maps\_utility::func_70BD("fx_alphathreshold",9,2);
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		if(isdefined(level.var_61E7) && level.var_61E7 == 1)
		{
			level.createfx_offset = (0,50000,50000);
			maps\createfx\odin_fx::func_4FDD();
			level.createfx_offset = undefined;
		}
		else
		{
			maps\createfx\odin_fx::func_4FDD();
		}

		maps\createfx\odin_sound::func_4FDD();
	}
}

//Function Number: 2
fx_init()
{
	common_scripts\utility::func_3385("fx_start_burnup");
	common_scripts\utility::func_3385("clear_for_sat_clean");
	level thread fx_ambient_setup();
	level.var_1FFD = [];
	level.var_1FFD[0] = level._effect["vfx_scrnfx_odin_helmet_cracks_0"];
	level.var_1FFD[1] = level._effect["vfx_scrnfx_odin_helmet_cracks_1"];
	level.var_1FFD[2] = level._effect["vfx_scrnfx_odin_helmet_cracks_2"];
	level.var_1FFD[3] = level._effect["vfx_scrnfx_odin_helmet_cracks_3"];
	level.var_1FFD[4] = level._effect["vfx_scrnfx_odin_helmet_cracks_4"];
	level.var_1FFD[5] = level._effect["vfx_scrnfx_odin_helmet_cracks_5"];
}

//Function Number: 3
func_5822(param_00)
{
	level endon("start_transition_to_youngblood");
	self endon("stopLightPulsing");
	var_01 = self getlightintensity();
	var_02 = 0.05;
	var_03 = var_01;
	var_04 = 0.3 / param_00;
	var_05 = 0.6 / param_00;
	var_06 = var_01 - var_02 / var_04 / 0.05;
	var_07 = var_01 - var_02 / var_05 / 0.05;
	wait(randomfloatrange(0.01,0.3));
	for(;;)
	{
		var_08 = 0;
		while(var_08 < var_05)
		{
			var_03 = var_03 - var_07;
			var_03 = clamp(var_03,0,100);
			self setlightintensity(var_03);
			var_08 = var_08 + 0.05;
			wait(0.05);
		}

		wait(1);
		var_08 = 0;
		while(var_08 < var_04)
		{
			var_03 = var_03 + var_06;
			var_03 = clamp(var_03,0,100);
			self setlightintensity(var_03);
			var_08 = var_08 + 0.05;
			wait(0.05);
		}

		wait(0.5);
	}
}

//Function Number: 4
func_5821(param_00,param_01,param_02,param_03)
{
	self endon("stopLightFlicker");
	var_04 = param_00;
	var_05 = 0;
	maps\_utility::func_2F47("stop_flicker");
	var_06 = self getlightintensity();
	var_07 = 0;
	var_08 = var_06;
	var_09 = 0;
	for(;;)
	{
		if(maps\_utility::ent_flag("stop_flicker"))
		{
			wait(0.05);
			continue;
		}

		var_0A = var_04;
		var_04 = param_00 + param_01 - param_00 * randomfloat(1);
		var_09 = randomintrange(1,10);
		if(param_02 != param_03)
		{
			var_05 = var_05 + randomfloatrange(param_02,param_03);
		}
		else
		{
			var_05 = var_05 + param_02;
		}

		if(var_05 == 0)
		{
			var_05 = var_05 + 1E-07;
		}

		var_0B = var_0A - var_04 * 1 / var_05;
		while(var_05 > 0 && !maps\_utility::ent_flag("stop_flicker"))
		{
			self method_8313(var_04 + var_0B * var_05);
			wait(0.05);
			var_05 = var_05 - 0.05;
		}

		while(var_09)
		{
			wait(randomfloatrange(0.05,0.1));
			if(var_08 > 0.2)
			{
				var_08 = randomfloatrange(0,0.3);
			}
			else
			{
				var_08 = var_06;
			}

			self setlightintensity(var_08);
			var_09--;
		}

		self setlightintensity(var_06);
		wait(randomfloatrange(param_02,param_03));
	}
}

//Function Number: 5
func_1ADF(param_00,param_01)
{
	var_02 = self getlightintensity();
	var_03 = castint(param_01 / 0.05);
	var_04 = param_00 - var_02 / var_03;
	var_05 = var_02;
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		var_05 = var_05 + var_04;
		self setlightintensity(var_05);
		wait(0.05);
	}

	self setlightintensity(param_00);
}

//Function Number: 6
func_5C68(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_wait(param_02);
	}

	var_04 = 0;
	var_05 = 0;
	var_06 = maps\_utility::create_sunflare_setting("odin_spin");
	for(;;)
	{
		if(isdefined(param_01))
		{
			var_07 = param_00 gettagorigin("tag_flash");
		}
		else
		{
			var_07 = param_00.origin;
		}

		var_04 = atan(level.player.origin[2] - var_07[2] / sqrt(squared(level.player.origin[0] - var_07[0]) + squared(level.player.origin[1] - var_07[1])));
		if(level.player.origin[0] < var_07[0])
		{
			var_05 = atan(level.player.origin[1] - var_07[1] / level.player.origin[0] - var_07[0]);
		}
		else
		{
			var_05 = 180 + atan(level.player.origin[1] - var_07[1] / level.player.origin[0] - var_07[0]);
		}

		var_06.position = (var_04,var_05,0);
		maps\_art::func_7D49("odin_spin",0);
		wait(0.05);
		if(isdefined(param_03))
		{
			if(common_scripts\utility::flag(param_03))
			{
				break;
			}
		}
	}
}

//Function Number: 7
func_4DD9()
{
	maps\_utility::func_70BD("r_specularColorScale",1.5,9.01);
	function_0168("actor_spaceLightingOffset",20);
	function_0168("sm_sunSampleSizeNear",0.5);
	common_scripts\utility::func_3385("lgt_flag_end_sun_move");
	level.spinsuntranstime = 0.25;
	var_00 = getentarray("lgt_odin_pulsing","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_5822(1);
	}

	thread lgt_intro_sequence();
	thread lgt_ally_sequence();
	thread func_4DD8();
	thread func_4DDC();
	thread func_4DDB();
	resetsunlight();
	function_01B2();
	var_04 = getent("intro_airlock_door","targetname");
	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel("tag_origin");
	var_05.origin = var_04.origin - (168,0,0);
	var_04 method_83BC(var_05);
}

//Function Number: 8
lgt_intro_sequence()
{
	common_scripts\utility::flag_wait("do_transition_to_odin");
	maps\_art::func_7D49("odin_default",0);
	var_00 = vectornormalize((-1232,-2641,-155));
	if(!isdefined(level.sunflare))
	{
		level.sunflare = spawn("script_model",(0,0,0));
		level.sunflare setmodel("tag_origin");
		playfxontag(level._effect["sun_lens_flare"],level.sunflare,"tag_origin");
	}

	while(!common_scripts\utility::flag("ally_clear"))
	{
		level.sunflare.origin = level.player.origin + var_00 * 100000;
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 9
lgt_ally_sequence()
{
	common_scripts\utility::flag_wait_any("unlock_post_infil_auto_door","lgt_trg_allySunSample","player_approaching_infiltration");
	function_0168("actor_spaceLightingOffset",-10);
	function_0168("sm_sunSampleSizeNear",0.2);
	common_scripts\utility::flag_wait("invader_scene_begin");
	function_0168("actor_spaceLightingOffset",20);
}

//Function Number: 10
func_4DD8()
{
	common_scripts\utility::flag_wait("ally_clear");
	function_0168("sm_sunSampleSizeNear",0.1);
	maps\_art::func_7D49("odin_escape",0);
	thread func_4DDA();
	var_00 = vectornormalize((296,-835,-20));
	if(!isdefined(level.sunflare))
	{
		level.sunflare = spawn("script_model",(0,0,0));
		level.sunflare setmodel("tag_origin");
		playfxontag(level._effect["sun_lens_flare"],level.sunflare,"tag_origin");
	}

	while(!common_scripts\utility::flag("lgt_trg_odin_destruction"))
	{
		level.sunflare.origin = level.player.origin + var_00 * 100000;
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 11
func_4DDC()
{
	level endon("start_transition_to_youngblood");
	common_scripts\utility::flag_wait("lgt_spin_setup");
	level.spinsuntranstime = 10;
	common_scripts\utility::flag_set("lgt_trg_odin_destruction");
	function_0168("sm_sunSampleSizeNear",0.1);
	if(!isdefined(level.sunflare))
	{
		level.sunflare = spawn("script_model",(0,0,0));
		level.sunflare setmodel("tag_origin");
		playfxontag(level._effect["sun_lens_flare"],level.sunflare,"tag_origin");
	}

	var_00 = maps/odin_util::func_2BCF();
	var_01 = (48583,18170,-45500);
	level.sunflare.origin = var_00.origin - var_01;
	level.sunflare linkto(var_00);
	wait(2);
	thread func_5C68(level.sunflare,undefined,undefined,"lgt_flag_end_sun_move");
	common_scripts\utility::flag_wait_any("lgt_flag_spin_over","trigger_spacejump");
	level.sunflare unlink(var_00);
	common_scripts\utility::flag_set("lgt_flag_end_sun_move");
}

//Function Number: 12
func_4DDB()
{
	level endon("start_transition_to_youngblood");
	common_scripts\utility::flag_wait("trigger_spacejump");
	wait(0.25);
	var_00 = vectornormalize((-3,-5,6));
	var_01 = level.player.origin + var_00 * 100000;
	if(!isdefined(level.sunflare))
	{
		level.sunflare = spawn("script_model",(-55629,-13122.8,46438.3));
		level.sunflare setmodel("tag_origin");
		playfxontag(level._effect["sun_lens_flare"],level.sunflare,"tag_origin");
	}

	thread maps\_art::func_7D49("odin_satellite",level.spinsuntranstime);
	level.sunflare moveto(var_01,level.spinsuntranstime);
	common_scripts\utility::flag_set("lgt_trg_odin_destruction");
	function_01B3();
	thread maps\_utility::func_4D8F("sm_sunSampleSizeNear",0.6,1.5);
	common_scripts\utility::flag_wait("fx_start_burnup");
	killfxontag(level._effect["sun_lens_flare"],level.sunflare,"tag_origin");
	function_01B5();
}

//Function Number: 13
func_4DDA()
{
	var_00 = getentarray("lgt_odin_destruction","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_5822(1);
	}

	thread func_6878("lgt_odin_spin_ref","lgt_odin_spinning","pitch");
	thread func_6878("lgt_odin_spin_ref_1","lgt_odin_spinning_1","yaw");
	thread func_6878("lgt_odin_spin_ref_2","lgt_odin_spinning_2","roll");
	thread func_365F();
	common_scripts\utility::flag_wait("lgt_trg_odin_destruction");
	wait(3);
	foreach(var_02 in var_00)
	{
		var_02 notify("stopLightPulsing");
		var_02 setlightintensity(0.1);
		var_02 maps\_lights::func_1ADD((0.993235,0.24,0.145098),0.4,0.1,0.05);
	}

	wait(3.5);
	foreach(var_02 in var_00)
	{
		var_02 func_1ADF(randomfloatrange(1.3,1.7),0.1);
		common_scripts\utility::func_8AFE();
		var_02 thread func_5822(4);
	}
}

//Function Number: 14
func_6878(param_00,param_01,param_02)
{
	var_03 = getentarray(param_01,"script_noteworthy");
	var_04 = getent(param_00,"script_noteworthy");
	if(!isdefined(var_03) || !isdefined(var_04) || !isdefined(param_02))
	{
	}

	var_04 thread func_6879(-360,param_02,1);
	foreach(var_06 in var_03)
	{
		var_06 thread maps\_utility::func_508D(var_04,var_06.origin - var_04.origin);
	}
}

//Function Number: 15
func_6879(param_00,param_01,param_02)
{
	level endon("start_transition_to_youngblood");
	self endon("stopLightSpinning");
	for(;;)
	{
		switch(param_01)
		{
			case "yaw":
				self rotateyaw(param_00,param_02);
				wait(param_02);
				break;
	
			case "pitch":
				self rotatepitch(param_00,param_02);
				wait(param_02);
				break;
	
			case "roll":
				self rotateroll(param_00,param_02);
				wait(param_02);
				break;
	
			default:
				wait(1);
				break;
		}
	}
}

//Function Number: 16
fx_ambient_setup()
{
	level thread fx_intro_ambient();
	level thread fx_airlock_ambient();
	level thread fx_escape_ambient();
	level thread func_3680();
	level thread fx_jump_ambient();
	level thread func_3661();
}

//Function Number: 17
fx_intro_ambient()
{
	level endon("start_transition_to_youngblood");
	for(;;)
	{
		common_scripts\utility::flag_wait("fx_intro_ambient");
		common_scripts\utility::exploder("intro_ambient");
		common_scripts\utility::exploder("intro_ambient_airlock_dust");
		common_scripts\utility::func_33A0("fx_intro_ambient");
		maps\_utility::func_7C22("intro_ambient");
		maps\_utility::func_7C22("intro_ambient_airlock_dust");
		maps\_utility::func_7C22("intro_airlock_complete");
	}
}

//Function Number: 18
fx_airlock_ambient()
{
	level endon("start_transition_to_youngblood");
	for(;;)
	{
		common_scripts\utility::flag_wait("fx_airlock_ambient");
		common_scripts\utility::exploder("airlock_ambient");
		common_scripts\utility::func_33A0("fx_airlock_ambient");
		maps\_utility::func_7C22("airlock_ambient");
	}
}

//Function Number: 19
fx_escape_ambient()
{
	level endon("start_transition_to_youngblood");
	for(;;)
	{
		common_scripts\utility::flag_wait("fx_escape_ambient");
		common_scripts\utility::exploder("escape_ambient");
		common_scripts\utility::func_33A0("fx_escape_ambient");
		maps\_utility::func_7C22("escape_ambient");
	}
}

//Function Number: 20
func_3680()
{
	level endon("start_transition_to_youngblood");
	for(;;)
	{
		common_scripts\utility::flag_wait("fx_spin_ambient");
		common_scripts\utility::exploder("spin_ambient");
		common_scripts\utility::func_33A0("fx_spin_ambient");
		maps\_utility::func_7C22("spin_ambient");
	}
}

//Function Number: 21
fx_jump_ambient()
{
	level endon("start_transition_to_youngblood");
	for(;;)
	{
		common_scripts\utility::flag_wait("fx_jump_ambient");
		common_scripts\utility::exploder("jump_ambient");
		common_scripts\utility::exploder("jump_ambient_fire_1");
		common_scripts\utility::exploder("jump_ambient_fire_2");
		common_scripts\utility::exploder("jump_ambient_fire_3");
		common_scripts\utility::exploder("jump_ambient_fire_4");
		common_scripts\utility::exploder("jump_ambient_fire_5");
		level thread func_3625();
		common_scripts\utility::func_33A0("fx_jump_ambient");
		maps\_utility::func_7C22("jump_ambient");
		maps\_utility::func_7C22("jump_ambient_fire_1");
		maps\_utility::func_7C22("jump_ambient_fire_2");
		maps\_utility::func_7C22("jump_ambient_fire_3");
		maps\_utility::func_7C22("jump_ambient_fire_4");
		maps\_utility::func_7C22("jump_ambient_fire_5");
	}
}

//Function Number: 22
func_3625()
{
	level endon("start_transition_to_youngblood");
	wait(4.5);
	maps\_utility::func_7C22("jump_ambient_fire_1");
	level waittill("decomp_player_anim_done");
	wait(9);
	maps\_utility::func_7C22("jump_ambient_fire_2");
	wait(3);
	maps\_utility::func_7C22("jump_ambient_fire_3");
	wait(3);
	maps\_utility::func_7C22("jump_ambient_fire_4");
	wait(3);
	maps\_utility::func_7C22("jump_ambient_fire_5");
}

//Function Number: 23
func_3661()
{
	level endon("start_transition_to_youngblood");
	for(;;)
	{
		common_scripts\utility::flag_wait("fx_sat_ambient");
		common_scripts\utility::exploder("sat_ambient");
		common_scripts\utility::func_33A0("fx_sat_ambient");
		maps\_utility::func_7C22("sat_ambient");
	}
}

//Function Number: 24
func_361E(param_00)
{
	playfxontag(level._effect["blood_impact_space"],param_00,"j_head");
}

//Function Number: 25
func_3607()
{
	level endon("player_exited_escape_hallway");
	var_00 = getent("sat_barrel_top","script_noteworthy");
	var_01 = getent("sat_barrel_target","script_noteworthy");
	var_02 = getent("sat_barrel_bottom","script_noteworthy");
	var_03 = common_scripts\utility::func_7836();
	var_03.angles = var_00.angles;
	var_04 = getent("fake_earth","targetname");
	var_05 = 1;
	var_06 = maps/odin_util::func_6A53();
	while(!common_scripts\utility::flag("absolute_fire_decompression"))
	{
		common_scripts\utility::flag_wait("fire_rog");
		common_scripts\utility::func_337C("fire_rog");
		common_scripts\utility::flag_set("ready_to_fire_next_salvo");
		var_07 = "tag_fx_impact_" + var_05;
		var_08 = var_04 gettagorigin(var_07);
		var_09 = var_01.origin - var_00.origin;
		var_0A = var_08 - var_00.origin;
		var_0B = common_scripts\utility::func_7836();
		var_0B.origin = var_06.origin;
		var_0B.angles = vectortoangles(var_09);
		var_06 linkto(var_0B);
		if(var_07 == "tag_fx_impact_1")
		{
			var_0C = vectortoangles(var_0A) + (0,0,-40);
		}
		else
		{
			var_0C = vectortoangles(var_0A) + (0,0,randomfloatrange(-4,4));
		}

		var_0B rotateto(var_0C,4,2,2);
		thread fire_sat_rcs_thrusters(var_0B.angles,vectortoangles(var_0A),4);
		wait(4);
		var_06 unlink();
		var_0B delete();
		var_03.origin = var_00.origin;
		wait(1.2);
		thread rog_firing_fx_at_player(var_02.origin);
		thread maps/odin_audio::func_727F();
		wait(2);
		playfxontag(level._effect["odin_rog_flash"],var_03,"tag_origin");
		thread bright_light_flash_into_console();
		thread func_7228();
		thread func_5826(var_02,var_01,0.1);
		var_04 thread fx_escape_play_rog_impact(var_07,8);
		var_03 thread func_3658(0.1,6.7);
		var_03 thread func_6732(8,var_07,var_04,"player_exited_escape_hallway","odin_interior_rog","odin_interior");
		var_05 = var_05 + 1;
		if(var_05 > 7)
		{
			var_05 = 2;
		}
	}

	var_03 delete();
}

//Function Number: 26
func_3681()
{
	level endon("start_transition_to_youngblood");
	var_00 = common_scripts\utility::func_7836();
	var_01 = getent("sat_barrel_top","script_noteworthy");
	var_02 = getent("sat_barrel_target","script_noteworthy");
	var_03 = getent("sat_barrel_bottom","script_noteworthy");
	var_00.angles = var_01.angles;
	var_04 = maps/odin_util::func_2BCF().earth_model;
	var_05 = 4;
	var_06 = maps/odin_util::func_6A53();
	var_07 = getent("final_sat_orientation","targetname");
	while(!common_scripts\utility::flag("satellite_end_anim_started"))
	{
		var_08 = "tag_fx_impact_" + var_05;
		var_09 = var_04 gettagorigin(var_08);
		var_0A = var_02.origin - var_01.origin;
		var_0B = vectortoangles(var_09 - var_01.origin);
		var_0C = var_07.angles - var_0B;
		var_0D = distance(level.ally.origin,var_06.origin);
		var_0E = distance(level.player.origin,var_06.origin);
		var_0F = 1;
		level.var_6A61 = 0;
		if(!common_scripts\utility::flag("triggered_finale"))
		{
			if(var_0D > 6250 || var_0E > 6250)
			{
				var_10 = var_0D / 1000;
				var_0F = 3;
				var_11 = var_07.angles + (randomfloatrange(0 - var_10,var_10),randomfloatrange(0 - var_10,var_10),randomfloatrange(0 - var_10,var_10));
			}
			else
			{
				var_11 = var_07.angles;
				level.var_6A61 = 1;
			}
		}
		else
		{
			var_11 = var_07.angles;
			level.var_6A61 = 1;
		}

		if(!common_scripts\utility::flag("first_finale_stage_done"))
		{
			thread fire_sat_rcs_thrusters(var_06.angles - var_0C * var_0F,var_11 - var_0C * var_0F,6);
		}

		if(common_scripts\utility::flag("lgt_flag_spin_over"))
		{
			var_06 rotateto(var_11,6,3,3);
			wait(6);
		}
		else
		{
			wait(6);
		}

		var_00.origin = var_01.origin;
		wait(0.5);
		thread rog_firing_fx_at_player(var_03.origin);
		thread maps/odin_audio::func_727F();
		wait(2);
		playfxontag(level._effect["odin_rog_flash"],var_00,"tag_origin");
		thread func_7228();
		if(!common_scripts\utility::flag("landed_on_satellite"))
		{
			thread func_5826(var_03,var_02,0.1);
			var_04 thread fx_spin_play_rog_impact(var_08,8);
			var_00 thread func_3658(1.4,6.7);
			var_00 thread func_6732(8,var_08,var_04,"triggered_finale","odin_spin_rog","odin_spin");
		}

		var_05 = var_05 + 1;
		if(var_05 > 11)
		{
			var_05 = 4;
		}

		wait(1);
	}

	var_00 delete();
}

//Function Number: 27
func_6A44()
{
}

//Function Number: 28
func_6732(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	var_07 = getent("sat_barrel_bottom","script_noteworthy");
	var_08 = getent("sat_barrel_target","script_noteworthy");
	var_09 = common_scripts\utility::func_7836();
	var_09.origin = var_08.origin;
	var_0A = var_07.origin - var_06.origin;
	var_06.angles = vectortoangles(var_0A);
	if(!common_scripts\utility::flag(param_03))
	{
		var_06 thread god_rays_from_rog(8,param_04,param_05);
	}

	var_06 moveto(var_07.origin,param_00 * 0.1,param_00 * 0.1,0);
	var_06 waittill("movedone");
	var_0B = 0;
	while(var_0B < 110)
	{
		if(common_scripts\utility::flag("landed_on_satellite"))
		{
			break;
		}

		var_0C = param_02 gettagorigin(param_01);
		var_0A = var_06.origin - var_09.origin;
		var_06.angles = vectortoangles(var_0A);
		var_09 moveto(var_0C,1.5);
		var_06 moveto(var_09.origin,param_00);
		var_0B = var_0B + 1;
		wait(0.05);
	}
}

//Function Number: 29
god_rays_from_rog(param_00,param_01,param_02)
{
	if(maps\_utility::func_47F6())
	{
		var_03 = 0;
		var_04 = 0;
		var_05 = 0;
		if(isdefined(param_01))
		{
			maps\_utility::func_8A02(param_01,0.5);
			wait(0.5);
		}

		var_06 = maps\_utility::create_sunflare_setting("odin_rog_fire");
		if(isdefined(param_02))
		{
			maps\_utility::func_252F(3,::maps\_utility::func_8A02,param_02,3);
			maps\_utility::func_252F(6,::maps\_utility::func_8A02,"",0);
		}

		for(;;)
		{
			var_07 = self.origin;
			var_03 = atan(level.player.origin[2] - var_07[2] / sqrt(squared(level.player.origin[0] - var_07[0]) + squared(level.player.origin[1] - var_07[1])));
			if(level.player.origin[0] < var_07[0])
			{
				var_04 = atan(level.player.origin[1] - var_07[1] / level.player.origin[0] - var_07[0]);
			}
			else
			{
				var_04 = 180 + atan(level.player.origin[1] - var_07[1] / level.player.origin[0] - var_07[0]);
			}

			var_06.position = (var_03,var_04,0);
			wait(0.05);
			var_05 = var_05 + 0.05;
			if(var_05 > param_00)
			{
				break;
			}
		}
	}
}

//Function Number: 30
func_3D70()
{
	if(maps\_utility::func_47F6())
	{
		wait(4);
		var_00 = maps\_utility::create_sunflare_setting("odin_airlock");
		var_00.position = (90,-90,0);
		maps\_art::func_7D49("odin_airlock",0);
		maps\_utility::func_8A02("odin_interior_rog",3);
		wait(4);
		maps\_utility::func_8A02("",4);
	}
}

//Function Number: 31
fire_sat_rcs_thrusters(param_00,param_01,param_02)
{
	level endon("triggered_finale");
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	if(level.var_6A61 == 1)
	{
		var_03 = 4;
		var_04 = 4;
		var_05 = 3;
		var_06 = 3;
	}

	if(param_00[1] < param_01[1])
	{
		var_03 = 5;
	}
	else
	{
		var_06 = 5;
	}

	if(param_00[0] < param_01[0])
	{
		var_05 = 3;
	}
	else
	{
		var_04 = 3;
	}

	thread maps/odin_audio::sfx_satellite_lat_thruster_loop(level.var_80B7);
	thread maps/odin_audio::func_7363(level.var_80BF);
	thread maps/odin_audio::func_7363(level.var_80B7);
	for(var_07 = 0;var_07 < param_02 * 2;var_07++)
	{
		if(var_03 > randomfloatrange(1,6))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B7,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C3,"tag_origin");
		}

		if(var_06 > randomfloatrange(1,6))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C3,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B7,"tag_origin");
		}

		if(var_05 > randomfloatrange(1,5))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BF,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BB,"tag_origin");
		}

		if(var_04 > randomfloatrange(1,5))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BB,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BF,"tag_origin");
		}

		wait(0.15);
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B7,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BB,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BF,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C3,"tag_origin");
		wait(0.05);
	}

	common_scripts\utility::flag_set("stop_sat_lat_thrust_loop");
	wait(param_02 * 0.1);
	thread maps/odin_audio::sfx_satellite_lat_thruster_loop(level.var_80B7);
	thread maps/odin_audio::func_7363(level.var_80BF);
	thread maps/odin_audio::func_7363(level.var_80B7);
	for(var_07 = 0;var_07 < param_02 * 2;var_07++)
	{
		if(var_06 > randomfloatrange(1,6))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B7,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C3,"tag_origin");
		}

		if(var_03 > randomfloatrange(1,6))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C3,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B7,"tag_origin");
		}

		if(var_04 > randomfloatrange(1,5))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BF,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BB,"tag_origin");
		}

		if(var_05 > randomfloatrange(1,5))
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BB,"tag_origin");
		}
		else
		{
			playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BF,"tag_origin");
		}

		wait(0.15);
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B7,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BB,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BF,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C3,"tag_origin");
		wait(0.05);
	}

	common_scripts\utility::flag_set("stop_sat_lat_thrust_loop");
}

//Function Number: 32
rog_firing_fx_at_player(param_00)
{
	if(distance2d(param_00,level.player.origin) < 15000)
	{
		earthquake(0.1,3,param_00,14000);
		if(!common_scripts\utility::flag("hold_satellite_back_thrusters"))
		{
			thread func_6735();
		}

		wait(1);
		playfx(level._effect["odin_fire_close"],param_00);
		wait(1);
		earthquake(0.3,2,param_00,14000);
		wait(1);
		earthquake(0.1,6,param_00,14000);
	}
}

//Function Number: 33
func_6735()
{
	level endon("first_finale_stage_done");
	wait(0.5);
	if(!common_scripts\utility::flag("first_finale_stage_done"))
	{
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
		thread maps/odin_audio::func_7363(level.var_80B5);
		thread maps/odin_audio::func_7364(level.var_80B5);
		thread maps/odin_audio::func_7363(level.var_80B9);
		common_scripts\utility::func_8AFE();
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
		thread maps/odin_audio::func_7363(level.var_80BD);
		thread maps/odin_audio::func_7363(level.var_80C1);
		wait(0.6);
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
		wait(randomfloatrange(0.05,0.15));
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
		common_scripts\utility::func_8AFE();
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
		wait(0.8);
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
		wait(randomfloatrange(0.1,0.8));
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
		common_scripts\utility::func_8AFE();
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
		playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
		wait(1.2);
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
		stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
		common_scripts\utility::flag_set("stop_sat_thrust_loop");
	}
}

//Function Number: 34
fx_escape_play_rog_impact(param_00,param_01)
{
	var_02 = gettime();
	var_03 = gettime() - param_01 * 1000;
	for(;;)
	{
		var_03 = gettime() - param_01 * 1000;
		if(common_scripts\utility::flag("absolute_fire_decompression"))
		{
			break;
		}
		else if(var_03 >= var_02)
		{
			playfxontag(level._effect["odin_rog_impact"],self,param_00);
			thread maps/odin_audio::func_734F();
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_wait("absolute_fire_decompression");
	wait(0.5);
	killfxontag(level._effect["odin_rog_impact"],self,param_00);
}

//Function Number: 35
fx_spin_play_rog_impact(param_00,param_01)
{
	wait(param_01);
	playfxontag(level._effect["odin_rog_impact"],self,param_00);
}

//Function Number: 36
func_5826(param_00,param_01,param_02)
{
	wait(param_02);
}

//Function Number: 37
func_3658(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	if(!isdefined(param_01))
	{
		param_01 = 3;
	}

	wait(param_00);
	if(!isdefined(self))
	{
	}

	playfxontag(level._effect["odin_rog_trail_flare"],self,"tag_origin");
	playfxontag(level._effect["odin_rog_trail_geotrail_runner"],self,"tag_origin");
	wait(param_01);
	if(!isdefined(self))
	{
	}

	killfxontag(level._effect["odin_rog_trail_flare"],self,"tag_origin");
}

//Function Number: 38
func_7228()
{
	if(level.var_5D19 == 0)
	{
		wait(0.7);
		thread maps/odin_audio::sfx_shaky_camera_moment();
		wait(0.4);
		earthquake(randomfloatrange(0.05,0.12),3,level.player.origin,500);
	}

	if(level.var_5D19 == 3)
	{
		earthquake(randomfloatrange(0.05,0.12),3,level.player.origin,500);
	}
}

//Function Number: 39
bright_light_flash_into_console()
{
	var_00 = getent("bright_light_flash_into_console","script_noteworthy");
	var_01 = 0;
	while(var_01 <= 1.8)
	{
		var_00 setlightintensity(var_01);
		wait(0.06);
		var_01 = var_01 + 0.05;
	}

	while(var_01 > 0)
	{
		var_00 setlightintensity(var_01);
		wait(0.1);
		var_01 = var_01 - 0.05;
	}
}

//Function Number: 40
func_6A5C()
{
	level.var_6A61 = 0;
	level.var_80B4 = getent("sat_thruster_01","script_noteworthy");
	level.var_80B8 = getent("sat_thruster_02","script_noteworthy");
	level.var_80BC = getent("sat_thruster_03","script_noteworthy");
	level.var_80C0 = getent("sat_thruster_04","script_noteworthy");
	level.var_80B6 = getent("sat_thruster_01_lat","script_noteworthy");
	level.var_80BA = getent("sat_thruster_02_lat","script_noteworthy");
	level.var_80BE = getent("sat_thruster_03_lat","script_noteworthy");
	level.var_80C2 = getent("sat_thruster_04_lat","script_noteworthy");
	level.var_80B5 = common_scripts\utility::func_7836();
	level.var_80B5.origin = level.var_80B4.origin;
	level.var_80B5.angles = level.var_80B4.angles;
	level.var_80B5 linkto(level.var_80B4);
	level.var_80B9 = common_scripts\utility::func_7836();
	level.var_80B9.origin = level.var_80B8.origin;
	level.var_80B9.angles = level.var_80B8.angles;
	level.var_80B9 linkto(level.var_80B8);
	level.var_80BD = common_scripts\utility::func_7836();
	level.var_80BD.origin = level.var_80BC.origin;
	level.var_80BD.angles = level.var_80BC.angles;
	level.var_80BD linkto(level.var_80BC);
	level.var_80C1 = common_scripts\utility::func_7836();
	level.var_80C1.origin = level.var_80C0.origin;
	level.var_80C1.angles = level.var_80C0.angles;
	level.var_80C1 linkto(level.var_80C0);
	level.var_80B7 = common_scripts\utility::func_7836();
	level.var_80B7.origin = level.var_80B6.origin;
	level.var_80B7.angles = level.var_80B6.angles;
	level.var_80B7 linkto(level.var_80B6);
	level.var_80BB = common_scripts\utility::func_7836();
	level.var_80BB.origin = level.var_80BA.origin;
	level.var_80BB.angles = level.var_80BA.angles;
	level.var_80BB linkto(level.var_80BA);
	level.var_80BF = common_scripts\utility::func_7836();
	level.var_80BF.origin = level.var_80BE.origin;
	level.var_80BF.angles = level.var_80BE.angles;
	level.var_80BF linkto(level.var_80BE);
	level.var_80C3 = common_scripts\utility::func_7836();
	level.var_80C3.origin = level.var_80C2.origin;
	level.var_80C3.angles = level.var_80C2.angles;
	level.var_80C3 linkto(level.var_80C2);
	common_scripts\utility::flag_wait("satellite_end_anim_started");
	level.var_80B4 delete();
	level.var_80B8 delete();
	level.var_80BC delete();
	level.var_80C0 delete();
	level.var_80B7 delete();
	level.var_80BB delete();
	level.var_80BF delete();
	level.var_80C3 delete();
}

//Function Number: 41
func_35DA()
{
	wait(10);
	level thread fx_burnup_sat();
	wait(5);
	common_scripts\utility::flag_set("fx_start_burnup");
	maps\_utility::func_8A02("odin_burnup",8);
	level.ally thread fx_burnup_kyra();
	level.player thread fx_burnup_player();
}

//Function Number: 42
fx_burnup_kyra()
{
	self endon("death");
	playfxontag(level._effect["odin_burnup_kyra_trail_runner"],self,"j_spinelower");
	common_scripts\utility::func_8AFE();
	playfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_wrist_le");
	playfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_wrist_ri");
	common_scripts\utility::func_8AFE();
	playfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_ankle_le");
	playfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_ankle_ri");
	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	self endon("death");
	wait(2);
	if(!isdefined(self))
	{
	}

	killfxontag(level._effect["odin_burnup_kyra_trail_runner"],self,"j_spinelower");
	killfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_wrist_le");
	killfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_wrist_ri");
	common_scripts\utility::func_8AFE();
	if(!isdefined(self))
	{
	}

	killfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_ankle_le");
	killfxontag(level._effect["odin_burnup_player_trail_runner"],self,"j_ankle_ri");
}

//Function Number: 43
fx_burnup_player()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 method_8021(self,"tag_origin",(0,0,0),(0,0,0),1);
	playfxontag(level._effect["odin_burnup_scrnfx"],var_00,"tag_origin");
	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	wait(1.9);
	killfxontag(level._effect["odin_burnup_scrnfx"],var_00,"tag_origin");
	common_scripts\utility::func_8AFE();
	var_00 delete();
}

//Function Number: 44
fx_burnup_sat()
{
	var_00 = [];
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorL_01","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorL_02","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorL_03","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorL_04","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorR_01","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorR_02","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorR_03","script_noteworthy");
	var_00[var_00.size] = getent("odin_sat_section_04_pod_doorR_04","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(maps\_utility::func_4027(var_02.model,"tag_fx_tip"))
		{
			playfxontag(level._effect["odin_burnup_sat_door_trail_runner"],var_02,"tag_fx_tip");
		}

		wait(randomfloatrange(0.1,0.5));
	}

	var_04 = getentarray("fx_sat_burnup_trail","script_noteworthy");
	var_05 = [];
	foreach(var_02 in var_04)
	{
		var_07 = var_02 common_scripts\utility::func_7836();
		var_07 linkto(var_02);
		playfxontag(level._effect["odin_burnup_sat_trail_runner"],var_07,"tag_origin");
		var_05[var_05.size] = var_07;
		wait(randomfloatrange(0.1,0.5));
	}

	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	wait(1.9);
	foreach(var_02 in var_00)
	{
		if(maps\_utility::func_4027(var_02.model,"tag_fx_tip"))
		{
			killfxontag(level._effect["odin_burnup_sat_door_trail_runner"],var_02,"tag_fx_tip");
		}
	}

	foreach(var_02 in var_05)
	{
		var_02 delete();
	}

	common_scripts\utility::flag_set("clear_for_sat_clean");
}

//Function Number: 45
fx_sat_thrusters_damage()
{
	if(!isdefined(level.var_80B5))
	{
		level.var_80B4 = getent("sat_thruster_01","script_noteworthy");
		level.var_80B8 = getent("sat_thruster_02","script_noteworthy");
		level.var_80BC = getent("sat_thruster_03","script_noteworthy");
		level.var_80C0 = getent("sat_thruster_04","script_noteworthy");
		level.var_80B5 = common_scripts\utility::func_7836();
		level.var_80B5.origin = level.var_80B4.origin;
		level.var_80B5.angles = level.var_80B4.angles;
		level.var_80B5 linkto(level.var_80B4);
		level.var_80B9 = common_scripts\utility::func_7836();
		level.var_80B9.origin = level.var_80B8.origin;
		level.var_80B9.angles = level.var_80B8.angles;
		level.var_80B9 linkto(level.var_80B8);
		level.var_80BD = common_scripts\utility::func_7836();
		level.var_80BD.origin = level.var_80BC.origin;
		level.var_80BD.angles = level.var_80BC.angles;
		level.var_80BD linkto(level.var_80BC);
		level.var_80C1 = common_scripts\utility::func_7836();
		level.var_80C1.origin = level.var_80C0.origin;
		level.var_80C1.angles = level.var_80C0.angles;
		level.var_80C1 linkto(level.var_80C0);
	}

	common_scripts\utility::flag_wait("first_finale_stage_done");
	stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B5,"tag_origin");
	stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80B9,"tag_origin");
	stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
	stopfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
	common_scripts\utility::func_8AFE();
	playfxontag(level._effect["odin_sat_thrusters_ignite_sporadic"],level.var_80B5,"tag_origin");
	thread maps/odin_audio::func_7363(level.var_80B5);
	thread maps/odin_audio::func_7364(level.var_80B5);
	playfxontag(level._effect["odin_sat_thrusters_ignite_sporadic"],level.var_80B9,"tag_origin");
	thread maps/odin_audio::func_7363(level.var_80B9);
	common_scripts\utility::func_8AFE();
	playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
	thread maps/odin_audio::func_7363(level.var_80BD);
	playfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
	thread maps/odin_audio::func_7363(level.var_80C1);
	common_scripts\utility::flag_wait("satellite_end_anim_started");
	killfxontag(level._effect["odin_sat_thrusters_ignite_sporadic"],level.var_80B5,"tag_origin");
	killfxontag(level._effect["odin_sat_thrusters_ignite_sporadic"],level.var_80B9,"tag_origin");
	killfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80BD,"tag_origin");
	killfxontag(level._effect["odin_sat_thrusters_runner"],level.var_80C1,"tag_origin");
	common_scripts\utility::flag_set("stop_sat_thrust_loop");
}

//Function Number: 46
fx_spin_player_debris()
{
	wait(2.1);
	level.var_5FED = spawn("script_model",(0,0,0));
	level.var_5FED setmodel("tag_origin");
	level.var_5FED method_8021(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	playfxontag(level._effect["odin_debris_field_max_runner"],level.var_5FED,"tag_origin");
	wait(10.3);
	stopfxontag(level._effect["odin_debris_field_max_runner"],level.var_5FED,"tag_origin");
	playfxontag(level._effect["odin_debris_field_high_runner"],level.var_5FED,"tag_origin");
	wait(15);
	stopfxontag(level._effect["odin_debris_field_high_runner"],level.var_5FED,"tag_origin");
	playfxontag(level._effect["odin_debris_field_med_runner"],level.var_5FED,"tag_origin");
	wait(8);
	stopfxontag(level._effect["odin_debris_field_med_runner"],level.var_5FED,"tag_origin");
	playfxontag(level._effect["odin_debris_field_low_runner"],level.var_5FED,"tag_origin");
	level waittill("objective_destroy_sat");
	wait(5);
	stopfxontag(level._effect["odin_debris_field_max_runner"],level.var_5FED,"tag_origin");
	stopfxontag(level._effect["odin_debris_field_high_runner"],level.var_5FED,"tag_origin");
	stopfxontag(level._effect["odin_debris_field_med_runner"],level.var_5FED,"tag_origin");
	stopfxontag(level._effect["odin_debris_field_low_runner"],level.var_5FED,"tag_origin");
	level.var_5FED delete();
}

//Function Number: 47
fx_sat_rcs_damage(param_00)
{
	switch(param_00)
	{
		case 1:
			var_01 = getent("fx_sat_rcs_damage_1","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_leak_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,1,0);
			thread maps/odin_audio::sfx_set_ending_flag();
			break;

		case 2:
			var_01 = getent("fx_sat_rcs_damage_2","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,2,0);
			break;

		case 3:
			fx_sat_rcs_damage_kill();
			var_01 = getent("fx_sat_rcs_damage_1","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,3,0);
			thread maps/odin_audio::func_7345(var_01,5,5);
			var_01 = getent("fx_sat_rcs_damage_2","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			var_01 = getent("fx_sat_rcs_damage_3","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,4,0.1);
			var_01 = getent("ally_shooting_target","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["zg_electrical_sparks_runner_40"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			break;

		case 4:
			var_01 = getent("fx_sat_rcs_damage_4","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			var_01 = getent("fx_sat_rcs_damage_5","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,4,0.1);
			var_01 = getent("ally_shooting_target","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["odin_fire_flare_runner"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			break;

		case 5:
			var_01 = getent("fx_sat_rcs_damage_6","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["odin_sat_rcs_fire_puff"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,5,0);
			var_01 = getent("fx_sat_rcs_damage_7","script_noteworthy");
			var_02 = var_01.origin;
			var_03 = anglestoforward(var_01.angles);
			var_04 = anglestoup(var_01.angles);
			level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["odin_sat_rcs_fire_puff"],var_02,var_03,var_04);
			triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
			thread maps/odin_audio::func_7345(var_01,4,0.5);
			thread maps/odin_audio::func_7345(var_01,5,2.1);
			wait(3);
			level notify("thrusters_fully_damaged");
			break;

		default:
			break;
	}
}

//Function Number: 48
fx_sat_rcs_damage_kill()
{
	foreach(var_01 in level.fx_sat_rcs_damage)
	{
		var_01 delete();
	}

	level.fx_sat_rcs_damage = [];
}

//Function Number: 49
func_3684(param_00)
{
	playfxontag(level._effect["odin_spin_solar_flash"],param_00,"panel_04");
	playfxontag(level._effect["odin_spin_solar_flash"],param_00,"panel_06");
	if(maps\_utility::func_47F6())
	{
		common_scripts\utility::func_8AFE();
		playfxontag(level._effect["odin_spin_solar_runner"],param_00,"panel_04");
		playfxontag(level._effect["odin_spin_solar_runner"],param_00,"panel_06");
		playfxontag(level._effect["odin_spin_solar_runner"],param_00,"panel_07");
	}
}

//Function Number: 50
func_3685(param_00)
{
	playfxontag(level._effect["odin_spin_solar_flash"],param_00,"panel_03");
	playfxontag(level._effect["odin_spin_solar_player_debris"],level.var_5FED,"tag_origin");
}

//Function Number: 51
func_367C(param_00)
{
}

//Function Number: 52
fx_solar_panel_collision_player(param_00)
{
}

//Function Number: 53
func_3674()
{
	common_scripts\utility::exploder("shuttle_dock");
}

//Function Number: 54
func_3664(param_00)
{
	var_01 = getent("fx_sat_rcs_explosion","script_noteworthy");
	var_02 = common_scripts\utility::func_7836();
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(param_00);
	playfxontag(level._effect["odin_sat_exp_rcs_fire_runner"],var_02,"tag_origin");
	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	wait(1.9);
	killfxontag(level._effect["odin_sat_exp_rcs_fire_runner"],var_02,"tag_origin");
	var_02 delete();
}

//Function Number: 55
func_365F()
{
	common_scripts\utility::func_F1B(getentarray("fx_amber_light_pitch","script_noteworthy"),::fx_rotate_lights,"amber","pitch");
	common_scripts\utility::func_F1B(getentarray("fx_amber_light_yaw","script_noteworthy"),::fx_rotate_lights,"amber","yaw");
	common_scripts\utility::func_F1B(getentarray("fx_red_light_pitch","script_noteworthy"),::fx_rotate_lights,"red","pitch");
	common_scripts\utility::func_F1B(getentarray("fx_red_light_pitch_2","script_noteworthy"),::fx_rotate_lights,"red","pitch_2");
	common_scripts\utility::func_F1B(getentarray("fx_red_light_yaw","script_noteworthy"),::fx_rotate_lights,"red","yaw");
}

//Function Number: 56
fx_rotate_lights(param_00,param_01)
{
	var_02 = common_scripts\utility::func_7836();
	var_02.origin = self.origin + 2.5 * anglestoup(self.angles);
	var_02.angles = self.angles;
	var_02 linkto(self);
	switch(param_00)
	{
		case "amber":
			playfxontag(level._effect["amber_light_45_flare_nolight"],var_02,"tag_origin");
			break;

		case "red":
			playfxontag(level._effect["red_light_45_flare_nolight"],var_02,"tag_origin");
			break;
	}

	switch(param_01)
	{
		case "pitch":
			thread func_6879(-360,"pitch",1);
			break;

		case "pitch_2":
			thread func_6879(360,"pitch",1);
			break;

		case "yaw":
			thread func_6879(-360,"yaw",1);
			break;
	}

	self waittill("start_transition_to_youngblood");
	var_02 delete();
}

//Function Number: 57
fx_space_glass()
{
	level.var_773F = spawn("script_model",(0,0,0));
	level.var_773F setmodel("tag_origin");
	level.var_773F method_8021(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	playfxontag(common_scripts\utility::func_3AB9("vfx_scrnfx_space_glass"),level.var_773F,"tag_origin");
	common_scripts\utility::flag_wait("invasion_clear");
	killfxontag(common_scripts\utility::func_3AB9("vfx_scrnfx_space_glass"),level.var_773F,"tag_origin");
	level.var_773F delete();
}

//Function Number: 58
func_3673()
{
	var_00 = getentarray("fx_sat_antenna_light","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 common_scripts\utility::func_7836();
		var_03 linkto(var_02);
		playfxontag(level._effect["odin_sat_red_light"],var_03,"tag_origin");
	}
}

//Function Number: 59
fx_sat_doors_open(param_00)
{
	foreach(var_02 in param_00)
	{
		playfxontag(level._effect["odin_sat_red_light_blinker_runner"],var_02,"tag_fx_base_light");
	}

	wait(18);
	foreach(var_02 in param_00)
	{
		stopfxontag(level._effect["odin_sat_red_light_blinker_runner"],var_02,"tag_fx_base_light");
	}
}

//Function Number: 60
fx_sat_doors_close(param_00)
{
	foreach(var_02 in param_00)
	{
		playfxontag(level._effect["odin_sat_red_light_blinker_runner"],var_02,"tag_fx_base_light");
	}

	wait(20);
	foreach(var_02 in param_00)
	{
		stopfxontag(level._effect["odin_sat_red_light_blinker_runner"],var_02,"tag_fx_base_light");
	}
}

//Function Number: 61
airlock_glass_fog()
{
	wait(2);
	level.var_3480 = spawn("script_model",(0,0,0));
	level.var_3480 setmodel("tag_origin");
	level.var_3480 method_8021(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	playfxontag(common_scripts\utility::func_3AB9("vfx_scrnfx_space_glass_fog"),level.var_3480,"tag_origin");
}

//Function Number: 62
fx_spin_create_rog_plumes()
{
	var_00 = maps/odin_util::func_2BCF().earth_model;
	for(var_01 = 1;var_01 < 4;var_01++)
	{
		var_02 = "tag_fx_impact_" + var_01;
		playfxontag(level._effect["odin_rog_plume_0" + var_01],var_00,var_02);
	}

	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	for(var_01 = 1;var_01 < 4;var_01++)
	{
		var_02 = "tag_fx_impact_" + var_01;
		killfxontag(level._effect["odin_rog_plume_0" + var_01],var_00,var_02);
	}
}