/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _playermech_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 131
 * Decompile Time: 1840 ms
 * Timestamp: 4/22/2024 2:22:25 AM
*******************************************************************/

//Function Number: 1
playermech_init(param_00)
{
	level thread playermech_fx_init();
	setsaveddvar("mechHide",0);
	if(level.script == "finale")
	{
		setsaveddvar("mechFxLethalFlash","muzzleflash/playermech_lethal_flash_view_run");
	}
	else
	{
		setsaveddvar("mechFxLethalFlash","muzzleflash/playermech_lethal_flash_view_run_cap");
	}

	setsaveddvar("mechMissileLerpTime",0.4);
	setsaveddvar("mechMissileTrackDelay",0.2);
	setsaveddvar("mechFxTacticalFlash","muzzleflash/playermech_tactical_flash_view_run");
	setsaveddvar("mechFxTacticalFlashTag","tag_rocket_flash");
	setdvar("mechCompassScaleFudge",1.5);
	if(1)
	{
		setsaveddvar("r_hudoutlineenable",1);
		setsaveddvar("r_chromaticAberrationTweaks",1);
		setsaveddvar("r_chromaticAberration",0);
		setsaveddvar("r_chromaticSeparationG",-10);
		setsaveddvar("r_chromaticSeparationR",10);
	}

	precachemodel("viewhands_playermech");
	precachemodel("vm_view_arms_mech");
	precacheshader("ui_playermech_icon_swarm_target");
	precacheshader("ui_playermech_icon_swarm_target");
	precacheshader("cinematic_3d_blend_visor");
	precachemodel("vm_exo_interior_base_missile");
	self.mechdata = spawnstruct();
	self.mechdata.active = 0;
	self.mechdata.init_active = 0;
	self.mechdata.swarm_target_list = [];
	self.mechdata.swarm_scantime_override = undefined;
	self.mechdata.swarm_dot_override = undefined;
	self.mechdata.threat_list = [];
	self.mechdata.bool_norecharge = 0;
	self.mechdata.dmg_screen_all = [];
	self.mechdata.dmg_screen_left = [];
	self.mechdata.dmg_screen_right = [];
	level.mechdata_left_bones = ["j_exo_left_srn_pnchout_01","j_exo_left_srn_pnchout_02","j_exo_left_srn_pnchout_03","j_exo_left_srn_pnchout_04","j_exo_left_srn_pnchout_05"];
	level.mechdata_right_bones = ["j_exo_right_srn_pnchout_01","j_exo_right_srn_pnchout_02","j_exo_right_srn_pnchout_03","j_exo_right_srn_pnchout_04","j_exo_right_srn_pnchout_05"];
	playermech_init_dmg_screens();
	if(isdefined(param_00))
	{
		self.mechdata.weapon_names = param_00;
	}
	else
	{
		self.mechdata.weapon_names["mech_base_weapon"] = "playermech_auto_cannon";
		self.mechdata.weapon_names["mech_lethal_weapon"] = "playermech_rocket";
		self.mechdata.weapon_names["mech_tactical_weapon"] = "playermech_rocket_swarm";
		self.mechdata.weapon_names["mech_swarm_rocket"] = "playermech_rocket_projectile";
		self.mechdata.weapon_names["mech_swarm_rocket_deploy"] = "playermech_rocket_deploy_projectile";
		self.mechdata.weapon_names["mech_base_no_weapon"] = "playermech_auto_cannon_noweap";
		self.mechdata.weapon_names["mech_dmg1_weapon"] = "playermech_auto_cannon_dmg1";
		self.mechdata.weapon_names["mech_dmg2_weapon"] = "playermech_auto_cannon_dmg2";
	}

	precacheitem(self.mechdata.weapon_names["mech_base_weapon"]);
	precacheitem(self.mechdata.weapon_names["mech_lethal_weapon"]);
	precacheitem(self.mechdata.weapon_names["mech_tactical_weapon"]);
	precacheitem(self.mechdata.weapon_names["mech_swarm_rocket"]);
	precacheitem(self.mechdata.weapon_names["mech_swarm_rocket_deploy"]);
	precacheitem(self.mechdata.weapon_names["mech_base_no_weapon"]);
	precacheitem(self.mechdata.weapon_names["mech_dmg1_weapon"]);
	precacheitem(self.mechdata.weapon_names["mech_dmg2_weapon"]);
	common_scripts\utility::flag_init("internal_threat_paint_in_progress");
	common_scripts\utility::flag_init("internal_swarm_rocket_active");
	common_scripts\utility::flag_init("internal_rocket_active");
	common_scripts\utility::flag_init("flag_mech_threat_paint_ping_on");
	common_scripts\utility::flag_init("flag_mech_vo_active");
	common_scripts\utility::flag_init("flag_mech_vo_playing");
	common_scripts\utility::flag_init("flag_force_hud_ready");
	thread aud_playermech_foley_override_handler();
	self.mechdata.create_badplace = 1;
	if(!isdefined(level.mech_max_health))
	{
		level.mech_max_health = 100;
	}

	if(!isdefined(level.damage_multiplier_mod))
	{
		level.damage_multiplier_mod = 0.07;
	}

	if(!isdefined(level.mech_swarm_rocket_max_targets))
	{
		level.mech_swarm_rocket_max_targets = 8;
	}

	if(!isdefined(level.mech_swarm_rocket_dud_min_count))
	{
		level.mech_swarm_rocket_dud_min_count = 0;
	}

	if(!isdefined(level.mech_swarm_rocket_dud_max_count))
	{
		level.mech_swarm_rocket_dud_max_count = 0;
	}

	if(!isdefined(level.mech_swarm_line_of_sight_lock_duration))
	{
		level.mech_swarm_line_of_sight_lock_duration = 2;
	}

	if(!isdefined(level.mech_swarm_use_two_stage_swarm))
	{
		level.mech_swarm_use_two_stage_swarm = 1;
	}

	if(!isdefined(level.mech_swarm_two_stage_swarm_homing_distance))
	{
		level.mech_swarm_two_stage_swarm_homing_distance = 250;
	}

	if(!isdefined(level.mech_swarm_two_stage_swarm_homing_strength))
	{
		level.mech_swarm_two_stage_swarm_homing_strength = 7500;
	}

	if(!isdefined(level.mech_swarm_number_of_rockets_per_target))
	{
		level.mech_swarm_number_of_rockets_per_target = 1;
	}

	if(!isdefined(level.mech_swarm_skip_line_of_sight_obstruction_test))
	{
		level.mech_swarm_skip_line_of_sight_obstruction_test = 1;
	}

	if(!isdefined(level.mech_threat_paint_delay))
	{
		level.mech_threat_paint_delay = 0.1;
	}
}

//Function Number: 2
playermech_init_vo()
{
	common_scripts\utility::flag_clear("flag_mech_vo_playing");
	var_00 = ["cap_sri_maingunoverheating","cap_sri_maingunoverheated"];
	level.player thread dialogue_mech(var_00,"chaingun_state_overheat","callback_chaingun_state_overheat");
	level.player thread dialogue_mech(["cap_sri_maingunready"],undefined,"chaingun_state_ready");
	level.player thread dialogue_mech(["cap_sri_rocketreloading"],undefined,"callback_rocket_reload");
	level.player thread dialogue_mech(["cap_sri_rocketready"],undefined,"rocket_state_ready");
	level.player thread dialogue_mech(["cap_sri_swarmmissilesreloading"],undefined,"callback_swarm_reload");
	level.player thread dialogue_mech(["cap_sri_swarmmissilesready"],undefined,"swarm_state_ready");
}

//Function Number: 3
dialog_mech_clear_queued(param_00)
{
	if(!isdefined(param_00) || param_00 == "chaingun")
	{
		maps\_utility::radio_dialogue_remove_from_stack("chaingun_state_overheat");
		maps\_utility::radio_dialogue_remove_from_stack("cap_sri_maingunready");
	}

	if(!isdefined(param_00) || param_00 == "rocket")
	{
		maps\_utility::radio_dialogue_remove_from_stack("cap_sri_rocketreloading");
		maps\_utility::radio_dialogue_remove_from_stack("cap_sri_rocketready");
	}

	if(!isdefined(param_00) || param_00 == "swarm")
	{
		maps\_utility::radio_dialogue_remove_from_stack("cap_sri_swarmmissilesreloading");
		maps\_utility::radio_dialogue_remove_from_stack("cap_sri_swarmmissilesready");
	}
}

//Function Number: 4
dialogue_mech(param_00,param_01,param_02)
{
	self endon("exit_mech");
	common_scripts\utility::flag_wait("flag_mech_vo_active");
	if(isdefined(param_01))
	{
		self waittill(param_01);
		common_scripts\utility::flag_set("flag_mech_vo_playing");
		maps\_utility::smart_radio_dialogue(common_scripts\utility::random(param_00));
		common_scripts\utility::flag_clear("flag_mech_vo_playing");
	}

	if(isdefined(param_02))
	{
		childthread dialogue_mech_everytime(param_02,param_00);
	}
}

//Function Number: 5
dialogue_mech_everytime(param_00,param_01)
{
	var_02 = 0;
	if(issubstr(param_00,"chaingun"))
	{
		var_02 = 1;
	}

	var_03 = 0;
	if(issubstr(param_00,"rocket"))
	{
		var_03 = 1;
	}

	var_04 = 0;
	if(issubstr(param_00,"swarm"))
	{
		var_04 = 1;
	}

	var_05 = 0;
	if(issubstr(param_00,"overheat"))
	{
		var_05 = 1;
	}

	var_06 = 0;
	if(issubstr(param_00,"ready"))
	{
		var_06 = 1;
	}

	var_07 = 0;
	if(issubstr(param_00,"reload"))
	{
		var_07 = 1;
	}

	for(;;)
	{
		self waittill(param_00);
		waittillframeend;
		if((var_02 && self.mechuistate.chaingun.state == "offline") || var_03 && self.mechuistate.rocket.state == "offline" || var_04 && self.mechuistate.swarm.state == "offline")
		{
			continue;
		}

		if(var_02 && var_06 && self.mechuistate.chaingun.last_state == "firing" || self.mechuistate.chaingun.last_state == "none")
		{
			continue;
		}

		if(var_03)
		{
			dialog_mech_clear_queued("rocket");
		}

		if(var_04)
		{
			dialog_mech_clear_queued("swarm");
		}

		if(var_02)
		{
			dialog_mech_clear_queued("chaingun");
		}

		thread play_reload_buzz(param_00,var_04,var_03);
		if(common_scripts\utility::flag("flag_mech_vo_active") && var_06 || var_05 || !common_scripts\utility::flag("flag_mech_vo_playing"))
		{
			common_scripts\utility::flag_set("flag_mech_vo_playing");
			maps\_utility::smart_radio_dialogue(common_scripts\utility::random(param_01));
			common_scripts\utility::flag_clear("flag_mech_vo_playing");
		}

		if(var_07 && var_04 || var_03)
		{
			for(;;)
			{
				if((var_03 && self.mechuistate.rocket.state != "reload") || var_04 && self.mechuistate.swarm.state != "reload")
				{
					self notify("kill_play_reload_buzz" + param_00);
					break;
				}

				wait 0.05;
			}
		}

		wait(0.05);
	}
}

//Function Number: 6
play_reload_buzz(param_00,param_01,param_02)
{
	self notify("kill_play_reload_buzz" + param_00);
	self endon("kill_play_reload_buzz" + param_00);
	wait(1);
	for(;;)
	{
		self waittill(param_00);
		if((param_02 && self.mechuistate.rocket.state == "reload") || param_01 && self.mechuistate.swarm.state == "reload")
		{
			soundscripts\_snd_playsound::snd_play_2d("wpn_goliath_dry_fire_plr");
		}

		wait(0.5);
	}
}

//Function Number: 7
playermech_init_dmg_screens()
{
	for(var_00 = 0;var_00 < level.mechdata_left_bones.size;var_00++)
	{
		self.mechdata.dmg_screen_left[var_00] = spawnstruct();
		self.mechdata.dmg_screen_left[var_00].bone = level.mechdata_left_bones[var_00];
		self.mechdata.dmg_screen_left[var_00].flickering = 0;
		self.mechdata.dmg_screen_left[var_00].hidden = 0;
		self.mechdata.dmg_screen_all[level.mechdata_left_bones[var_00]] = self.mechdata.dmg_screen_left[var_00];
	}

	for(var_00 = 0;var_00 < level.mechdata_right_bones.size;var_00++)
	{
		self.mechdata.dmg_screen_right[var_00] = spawnstruct();
		self.mechdata.dmg_screen_right[var_00].bone = level.mechdata_right_bones[var_00];
		self.mechdata.dmg_screen_right[var_00].flickering = 0;
		self.mechdata.dmg_screen_right[var_00].hidden = 0;
		self.mechdata.dmg_screen_all[level.mechdata_right_bones[var_00]] = self.mechdata.dmg_screen_right[var_00];
	}
}

//Function Number: 8
playermech_fx_init()
{
	level.mech_fx["rocket_separation"] = loadfx("vfx/muzzleflash/playermech_tactical_flash_view_run");
	level.mech_fx["bullet_hit_sparks"] = loadfx("vfx/weaponimpact/metal_spark_fountain_small");
	level.mech_fx["bullet_hit_sparks_large"] = loadfx("vfx/weaponimpact/metal_spark_fountain_large");
	level.mech_fx["rocket_trail_0"] = loadfx("vfx/trail/exo_armor_rocket_trail_a");
	level.mech_fx["rocket_trail_1"] = loadfx("vfx/trail/exo_armor_rocket_trail_b");
	level.mech_fx["rocket_trail_2"] = loadfx("vfx/trail/exo_armor_rocket_trail_c");
	level._effect["paint_threat"] = loadfx("vfx/explosion/paint_grenade");
	level._effect["exo_armor_gun_barrel_heat_view"] = loadfx("vfx/muzzleflash/exo_armor_gun_barrel_heat_view");
	level._effect["exo_armor_gun_barrel_overheat_view"] = loadfx("vfx/muzzleflash/exo_armor_gun_barrel_overheat_view");
	level._effect["playermech_lethal_flash_view_run_cap"] = loadfx("vfx/muzzleflash/playermech_lethal_flash_view_run_cap");
}

//Function Number: 9
playermech_start(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	if(!isplayer(self))
	{
		var_05 = level.player;
	}
	else
	{
		var_05 = self;
	}

	if(!isdefined(var_05.mechdata))
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = "base";
	}

	var_06 = var_05 get_mech_state();
	if(isdefined(var_06) && var_06 == param_00)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		if(param_00 == "base_noweap_bootup")
		{
			param_01 = 0;
		}
		else
		{
			param_01 = 1;
		}
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_05 thread _state_init();
	var_05 notify("playermech_start");
	var_05 thread aud_playermech_start();
	if(!isdefined(param_03))
	{
		param_03 = "viewhands_playermech";
	}

	if(!isdefined(param_04))
	{
		param_04 = "viewhands_playermech_dmg1";
	}

	switch(param_00)
	{
		case "base_noweap_bootup":
			var_05 setviewmodel(param_03);
			if(level.currentgen)
			{
				var_05 hidepartviewmodel("tag_camera",1);
			}
	
			var_05 setclientomnvar("ui_hide_hud",1);
			var_05 thread set_mech_weapon_state(param_00,param_01,var_05.mechdata.weapon_names["mech_base_no_weapon"],var_05.mechdata.weapon_names["mech_lethal_weapon"],var_05.mechdata.weapon_names["mech_tactical_weapon"],0,0,0);
			if(!param_02)
			{
				enable_mech_threat_ping();
			}
			break;

		case "base_noweap":
			var_05 setviewmodel(param_03);
			if(level.currentgen)
			{
				var_05 hidepartviewmodel("tag_camera",1);
			}
	
			var_05 setclientomnvar("ui_playermech_hud",1);
			var_05 setclientomnvar("ui_hide_hud",0);
			if(level.currentgen)
			{
				var_05 common_scripts\utility::delaycall(0.2,::hidepartviewmodel,"tag_camera",0);
			}
	
			var_05 thread set_mech_weapon_state(param_00,param_01,var_05.mechdata.weapon_names["mech_base_no_weapon"],var_05.mechdata.weapon_names["mech_lethal_weapon"],var_05.mechdata.weapon_names["mech_tactical_weapon"],0,0,0);
			if(!param_02)
			{
				enable_mech_threat_ping();
			}
			break;

		case "base_transition":
		case "base":
			var_05 setclientomnvar("ui_playermech_hud",1);
			var_05 setclientomnvar("ui_hide_hud",0);
			var_05 setviewmodel(param_03);
			var_05 thread set_mech_weapon_state(param_00,param_01,var_05.mechdata.weapon_names["mech_base_weapon"],var_05.mechdata.weapon_names["mech_lethal_weapon"],var_05.mechdata.weapon_names["mech_tactical_weapon"]);
			if(!param_02)
			{
				enable_mech_threat_ping();
			}
			break;

		case "dmg1":
		case "dmg1_transition":
			var_05 setclientomnvar("ui_playermech_hud",1);
			var_05 setclientomnvar("ui_hide_hud",0);
			var_05 setviewmodel(param_04);
			var_05 thread set_mech_weapon_state(param_00,param_01,var_05.mechdata.weapon_names["mech_dmg1_weapon"],var_05.mechdata.weapon_names["mech_lethal_weapon"],var_05.mechdata.weapon_names["mech_tactical_weapon"]);
			if(!param_02)
			{
				enable_mech_threat_ping();
			}
			break;

		case "dmg2":
		case "dmg2_transition":
			var_05 setclientomnvar("ui_playermech_hud",1);
			var_05 setclientomnvar("ui_hide_hud",0);
			var_05 setviewmodel(param_04);
			var_05 thread set_mech_weapon_state(param_00,param_01,var_05.mechdata.weapon_names["mech_dmg2_weapon"],var_05.mechdata.weapon_names["mech_lethal_weapon"],var_05.mechdata.weapon_names["mech_tactical_weapon"],0,0,0);
			disable_mech_threat_ping();
			break;

		default:
			break;
	}

	var_07 = 1;
	foreach(var_09 in var_05.mechdata.dmg_screen_all)
	{
		var_05 thread hide_mech_screen(var_09,0.05 * var_07);
		var_07++;
	}
}

//Function Number: 10
playermech_end(param_00)
{
	var_01 = undefined;
	if(!isplayer(self))
	{
		var_01 = level.player;
	}
	else
	{
		var_01 = self;
	}

	var_01 thread _exit(param_00);
	var_01 thread aud_playermech_end();
}

//Function Number: 11
add_swarm_repulsor_for_ally(param_00,param_01)
{
	if(!isdefined(param_00.swarm_repulsor_foot))
	{
		param_00.swarm_repulsor_foot = missile_createrepulsorent(param_00,10000,100,param_01);
		var_02 = param_00 getcentroid() - param_00.origin;
		param_00.swarm_repulsor_body = missile_createrepulsorent(param_00,10000,100,param_01,0,(0,0,var_02[2]));
		param_00.swarm_repulsor_head = missile_createrepulsorent(param_00,10000,100,param_01,0,(0,0,var_02[2] * 2));
	}
}

//Function Number: 12
enable_mech_threat_ping()
{
	common_scripts\utility::flag_set("flag_mech_threat_paint_ping_on");
}

//Function Number: 13
disable_mech_threat_ping()
{
	common_scripts\utility::flag_clear("flag_mech_threat_paint_ping_on");
}

//Function Number: 14
enable_mech_chaingun()
{
	set_mech_chaingun_state("ready");
	self allowfire(1);
}

//Function Number: 15
disable_mech_chaingun()
{
	set_mech_chaingun_state("offline");
	dialog_mech_clear_queued("chaingun");
	self allowfire(0);
}

//Function Number: 16
enable_mech_rocket()
{
	set_mech_rocket_state("ready");
	thread playermech_monitor_rocket_recharge();
	self enableoffhandweapons();
}

//Function Number: 17
disable_mech_rocket()
{
	set_mech_rocket_state("offline");
	self notify("stop_rocket_recharge");
	self.mechuistate.rocket.recharge = 100;
	dialog_mech_clear_queued("rocket");
	self disableoffhandweapons();
}

//Function Number: 18
enable_mech_swarm()
{
	set_mech_swarm_state("ready");
	thread playermech_monitor_swarm_recharge();
	self enableoffhandsecondaryweapons();
}

//Function Number: 19
disable_mech_swarm()
{
	set_mech_swarm_state("offline");
	dialog_mech_clear_queued("swarm");
	self notify("stop_swarm_recharge");
	self disableoffhandsecondaryweapons();
}

//Function Number: 20
enable_stencil(param_00)
{
	if(isarray(param_00))
	{
		foreach(var_02 in param_00)
		{
			var_02.disablestencil = undefined;
			mark_stencil(var_02);
		}

		return;
	}

	param_00.disablestencil = undefined;
	mark_stencil(param_00);
}

//Function Number: 21
disable_stencil(param_00)
{
	if(isarray(param_00))
	{
		foreach(var_02 in param_00)
		{
			var_02.disablestencil = 1;
		}

		return;
	}

	param_00.disablestencil = 1;
}

//Function Number: 22
mech_setup_player_for_forced_walk_scene()
{
	mech_setup_player_for_scene(undefined,1);
}

//Function Number: 23
mech_setup_player_for_scene(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	setsaveddvar("ammoCounterHide",1);
	self disableoffhandweapons();
	self disableweaponswitch();
	self enablegrenadethrowback(0);
	self allowcrouch(0);
	self allowjump(0);
	self allowmelee(0);
	self allowstand(1);
	self allowprone(0);
	self allowsprint(0);
	self allowmantle(0);
	self disableweaponpickup(1);
	self hidehud();
	self.original_r_znear = getdvarfloat("r_znear");
	setsaveddvar("r_znear",1);
	if(param_01)
	{
		self allowads(1);
		self showviewmodel();
		self.viewmodel_hidden = 0;
	}
	else
	{
		self allowads(0);
		self hideviewmodel();
		self.viewmodel_hidden = 1;
		self notify("kill_barrel_vfx");
		thread reload_checker_hack();
	}

	if(isdefined(self.mechuistate))
	{
		disable_mech_swarm();
		disable_mech_rocket();
		disable_mech_chaingun();
	}

	if(isdefined(param_00) && param_00)
	{
		wait 0.05;
		wait 0.05;
		while(self getstance() != "stand" || self isthrowinggrenade() || self isreloading())
		{
			self setstance("stand");
			wait(0.05);
		}
	}

	self setadditiveviewmodelanim(0);
}

//Function Number: 24
mech_setup_player_for_gameplay()
{
	setsaveddvar("ammoCounterHide",0);
	self enableoffhandweapons();
	self disableweaponswitch();
	self enablegrenadethrowback(0);
	self allowcrouch(0);
	self allowjump(1);
	self allowmelee(1);
	self allowstand(1);
	self allowprone(0);
	self allowsprint(1);
	self allowmantle(0);
	self disableweaponpickup(1);
	self showhud();
	self allowads(1);
	if(isdefined(self.original_r_znear))
	{
		setsaveddvar("r_znear",self.original_r_znear);
		self.original_r_znear = undefined;
	}

	self showviewmodel();
	self.viewmodel_hidden = 0;
	if(isdefined(self.mechuistate))
	{
		enable_mech_swarm();
		enable_mech_rocket();
		enable_mech_chaingun();
	}
}

//Function Number: 25
reload_checker_hack()
{
	for(;;)
	{
		if(self.viewmodel_hidden == 1)
		{
			self hideviewmodel();
		}
		else
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 26
_state_init()
{
	if(!isdefined(self.mechdata))
	{
	}

	self enableweapons();
	mech_setup_player_for_gameplay();
	if(!self.mechdata.active)
	{
		self.mechdata.active = 1;
		self.mechdata.init_active = 1;
		self.dontmelee = 1;
		level.noautosaveammocheck = 1;
		playermech_save_player_data();
		thread playermech_damage_manager();
		thread playermech_state_manager();
		level.savedcompassfadetime = getdvar("hud_fade_compass");
		setsaveddvar("hud_fade_compass",0);
		setsaveddvar("mechUseCodeSounds",1);
		setsaveddvar("mechUseCodeRumble",1);
		wait(0.2);
		self overrideviewmodelmaterialreset();
		self overrideviewmodelmaterial("cinematic_3d_blend","cinematic_3d_blend_visor");
		self setplayermech(1);
		if(!isdefined(self._old_visionset) || level.lvl_visionset != "_playermech")
		{
			self._old_visionset = level.lvl_visionset;
		}

		thread maps\_utility::vision_set_changes("_playermech",0.05);
		thread playermech_chaingun_watcher();
		thread playermech_rockets_and_swarm_watcher();
		thread playermech_invalid_weapon_watcher();
		playermech_init_vo();
		thread unlimited_mech_ammo();
		if(level.script == "finale")
		{
			thread playermech_physics_push_finale();
		}
		else
		{
			thread playermech_physics_push();
		}

		thread playermech_threat_paint_ping_loop();
		thread playermech_badplace();
		thread playermech_damage_parts();
		self.mechdata.init_active = 0;
	}
}

//Function Number: 27
mech_linkplayerview_rocket()
{
	if(0)
	{
		return;
	}

	wait(0.05);
	mech_unlinkplayerview_rocket();
	var_00 = spawn("script_model",(0,0,0));
	var_00.angles = (0,0,0);
	var_00 setmodel("vm_exo_interior_base_missile");
	var_00 linktoplayerview(self,"j_rocket",(0,0,0),(0,0,0),0);
	self.linked_rocket = var_00;
}

//Function Number: 28
mech_unlinkplayerview_rocket()
{
	if(!isdefined(self.linked_rocket))
	{
		return;
	}

	self.linked_rocket unlinkfromplayerview(self);
	self.linked_rocket delete();
	self.linked_rocket = undefined;
}

//Function Number: 29
set_mech_weapon_state(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("exit_mech");
	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	if(!isdefined(param_07))
	{
		param_07 = 1;
	}

	if(param_05)
	{
		enable_mech_chaingun();
	}
	else
	{
		disable_mech_chaingun();
	}

	if(param_06)
	{
		enable_mech_rocket();
	}
	else
	{
		disable_mech_rocket();
	}

	if(param_07)
	{
		enable_mech_swarm();
	}
	else
	{
		disable_mech_swarm();
	}

	var_08 = self getcurrentprimaryweapon();
	if(var_08 != param_02)
	{
		if(var_08 != "none")
		{
			thread delayed_takeweapon(var_08);
		}

		self giveweapon(param_02);
		if(param_01)
		{
			self switchtoweaponimmediate(param_02);
		}
		else
		{
			self switchtoweapon(param_02);
		}

		thread mech_linkplayerview_rocket();
	}

	var_09 = self getlethalweapon();
	if(var_09 != param_03)
	{
		if(var_09 != "none")
		{
			self takeweapon(var_09);
		}

		self setlethalweapon(param_03);
		self giveweapon(param_03);
	}

	var_0A = self gettacticalweapon();
	if(var_0A != param_04)
	{
		if(var_0A != "none")
		{
			self takeweapon(var_0A);
		}

		self settacticalweapon(param_04);
		self giveweapon(param_04);
	}

	while(self.mechdata.init_active)
	{
		wait(0.05);
	}

	while(self getcurrentprimaryweapon() != param_02)
	{
		wait(0.05);
	}

	set_mech_state(param_00);
}

//Function Number: 30
delayed_takeweapon(param_00)
{
	self endon("exit_mech");
	self notify("notify_stop_delayed_takeweapon");
	self endon("notify_stop_delayed_takeweapon");
	wait(0.3);
	self takeweapon(param_00);
}

//Function Number: 31
_exit(param_00)
{
	if(isdefined(param_00))
	{
		foreach(var_02 in param_00)
		{
			common_scripts\utility::flag_waitopen(var_02);
		}
	}

	common_scripts\utility::flag_waitopen("internal_threat_paint_in_progress");
	if(!isdefined(self.mechdata))
	{
	}

	mech_unlinkplayerview_rocket();
	playermech_restore_player_data();
	setsaveddvar("cg_cinematicfullscreen","1");
	stopcinematicingame();
	self overrideviewmodelmaterialreset();
	self setclientomnvar("ui_playermech_hud",0);
	setsaveddvar("hud_fade_compass",level.savedcompassfadetime);
	setsaveddvar("player_damagemultiplier",1);
	setsaveddvar("player_radiusDamageMultiplier",1);
	self notify("noHealthOverlay");
	thread maps\_gameskill::healthoverlay();
	setsaveddvar("mechUseCodeSounds",0);
	setsaveddvar("mechUseCodeRumble",0);
	self setplayermech(0);
	if(isdefined(self._old_visionset))
	{
		thread maps\_utility::vision_set_changes(self._old_visionset,0.05);
	}

	self.mechdata.active = 0;
	self.dontmelee = 0;
	level.noautosaveammocheck = 0;
	set_mech_state("none");
	self notify("exit_mech");
	self enabledeathshield(0);
}

//Function Number: 32
playermech_save_player_data()
{
	self.mechdata.activeweapon = self getcurrentweapon();
	var_00 = self getweaponslistall();
	self.mechdata.weapons = [];
	foreach(var_02 in var_00)
	{
		var_03 = self.mechdata.weapons.size;
		self.mechdata.weapons[var_03] = spawnstruct();
		self.mechdata.weapons[var_03].name = var_02;
		self.mechdata.weapons[var_03].clipammor = self getweaponammoclip(var_02,"right");
		self.mechdata.weapons[var_03].clipammol = self getweaponammoclip(var_02,"left");
		self.mechdata.weapons[var_03].stockammo = self setweaponammostock(var_02);
	}

	self takeallweapons();
	self enablegrenadethrowback(0);
}

//Function Number: 33
playermech_restore_player_data()
{
	self takeallweapons();
	foreach(var_01 in self.mechdata.weapons)
	{
		self giveweapon(var_01.name);
		self setweaponammoclip(var_01.name,var_01.clipammor,"right");
		self setweaponammoclip(var_01.name,var_01.clipammol,"left");
		self setweaponammostock(var_01.name,var_01.stockammo);
	}

	self enableweaponswitch();
	self enablegrenadethrowback(1);
	self switchtoweapon(self.mechdata.activeweapon);
}

//Function Number: 34
playermech_ui_state_reset()
{
	if(!isdefined(self.mechuistate))
	{
		self.mechuistate = spawnstruct();
		self.mechuistate.chaingun = spawnstruct();
		self.mechuistate.swarm = spawnstruct();
		self.mechuistate.rocket = spawnstruct();
		self.mechuistate.threat_list = spawnstruct();
		self.mechuistate.state = "none";
		self.mechuistate.chaingun.state = "none";
		self.mechuistate.chaingun.last_state = "none";
		self.mechuistate.swarm.state = "none";
		self.mechuistate.swarm.last_state = "none";
		self.mechuistate.rocket.state = "none";
		self.mechuistate.rocket.last_state = "none";
	}

	set_mech_state();
	self.mechuistate.threat_list.threats = [];
	self.mechuistate.threat_list.compass_offsets = [];
	self.mechuistate.chaingun.heatlevel = 0;
	self.mechuistate.chaingun.overheated = 0;
	self.mechuistate.swarm.target_list = [];
	self.mechuistate.swarm.threat_scan = 0;
	self.mechuistate.swarm.recharge = 100;
	self.mechuistate.rocket.fire = 0;
	self.mechuistate.rocket.recharge = 100;
}

//Function Number: 35
playermech_ui_state_enter(param_00)
{
	switch(param_00)
	{
		case "base_noweap_bootup":
			setsaveddvar("cg_cinematicfullscreen","0");
			if(!level.currentgen)
			{
				cinematicingame("playermech_bootup");
			}
			break;

		case "base_noweap":
			setsaveddvar("cg_cinematicfullscreen","0");
			break;

		case "base_transition":
			break;

		case "base":
			setsaveddvar("cg_cinematicfullscreen","0");
			break;

		case "dmg1_transition":
			break;

		case "dmg1":
			break;

		case "dmg2_transition":
			break;

		case "dmg2":
			break;

		case "outro":
			setsaveddvar("cg_cinematicfullscreen","0");
			cinematicingameloop("playermech_outro");
			break;
	}
}

//Function Number: 36
playermech_ui_state_leave(param_00)
{
	switch(param_00)
	{
		case "base_noweap_bootup":
			break;

		default:
			setsaveddvar("cg_cinematicfullscreen","1");
			stopcinematicingame();
			break;
	}
}

//Function Number: 37
playermech_state_manager()
{
	self endon("exit_mech");
	playermech_ui_state_reset();
	set_mech_state();
	set_mech_chaingun_state();
	set_mech_rocket_state();
	set_mech_swarm_state();
	thread playermech_ui_chaingun_feedback();
	thread playermech_ui_swarm_feedback();
	thread playermech_ui_rocket_feedback();
	for(;;)
	{
		state_main_pump();
		state_chaingun_pump();
		state_rocket_pump();
		state_swarm_pump();
		self.mechuistate.threat_list.threats = maps\_utility::remove_dead_from_array(self.mechdata.threat_list);
		playermech_ui_update_threat_compass_values(self.mechuistate.threat_list);
		playermech_ui_update_lui(self.mechuistate);
		wait(0.05);
	}
}

//Function Number: 38
set_mech_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate))
	{
		return;
	}

	if(self.mechuistate.state == param_00)
	{
		return;
	}

	playermech_ui_state_leave(self.mechuistate.state);
	self.mechuistate.state = param_00;
	self notify(param_00);
	playermech_ui_state_enter(param_00);
}

//Function Number: 39
get_mech_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.state;
}

//Function Number: 40
get_front_sorted_threat_list(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(vectordot(var_04.origin - self.origin,param_01) < 0)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	var_02 = sortbydistance(var_02,self.origin);
	return var_02;
}

//Function Number: 41
playermech_ui_weapon_feedback(param_00,param_01)
{
	self endon("exit_mech");
	self setclientomnvar(param_01,0);
	for(;;)
	{
		while(!self [[ param_00 ]]())
		{
			wait(0.05);
		}

		self setclientomnvar(param_01,1);
		while(self [[ param_00 ]]())
		{
			wait(0.05);
		}

		self setclientomnvar(param_01,0);
		wait(0.05);
	}
}

//Function Number: 42
playermech_ui_chaingun_feedback()
{
	playermech_ui_weapon_feedback(::attackbuttonpressed,"ui_playermech_chaingun_pressed");
}

//Function Number: 43
playermech_ui_swarm_feedback()
{
	playermech_ui_weapon_feedback(::secondaryoffhandbuttonpressed,"ui_playermech_swarm_pressed");
}

//Function Number: 44
playermech_ui_rocket_feedback()
{
	playermech_ui_weapon_feedback(::fragbuttonpressed,"ui_playermech_rocket_pressed");
}

//Function Number: 45
playermech_ui_update_threat_compass_values(param_00)
{
	param_00.compass_offsets = [];
	var_01 = anglestoforward(self getplayerangles());
	if(var_01[2] > 0.99)
	{
		return;
	}

	var_01 = vectornormalize(var_01 * (1,1,0));
	var_02 = get_front_sorted_threat_list(param_00.threats,var_01);
	var_03 = getdvarfloat("mechCompassScaleFudge");
	foreach(var_05 in var_02)
	{
		var_06 = var_05.origin - self.origin;
		var_06 = vectornormalize(var_06 * (1,1,0));
		if(var_06[2] > 0.99)
		{
			var_02.compass_offsets[param_00.compass_offsets.size] = 0;
			continue;
		}

		var_07 = acos(clamp(vectordot(var_06,var_01),-1,1)) / 180;
		var_08 = vectorcross(var_06,var_01);
		if(var_08[2] <= 0)
		{
			var_07 = var_07 * -1;
		}

		var_07 = var_07 * var_03;
		param_00.compass_offsets[param_00.compass_offsets.size] = var_07;
	}
}

//Function Number: 46
playermech_ui_update_lui(param_00)
{
	self setclientomnvar("ui_playermech_numswarmtargets",param_00.swarm.target_list.size);
	self setclientomnvar("ui_playermech_swarmrecharge",param_00.swarm.recharge);
	self setclientomnvar("ui_playermech_threats_scanned",param_00.swarm.threat_scan);
	self setclientomnvar("ui_playermech_rocketrecharge",param_00.rocket.recharge);
	self setclientomnvar("ui_playermech_chaingun_heatlevel",param_00.chaingun.heatlevel);
	self setclientomnvar("ui_playermech_threat_count",param_00.threat_list.compass_offsets.size);
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		var_02 = var_01 + 1;
		if(param_00.threat_list.compass_offsets.size >= var_02)
		{
			self setclientomnvar("ui_playermech_threat_position_" + var_02,param_00.threat_list.compass_offsets[var_01]);
		}
	}
}

//Function Number: 47
state_main_pump()
{
	switch(get_mech_state())
	{
		case "outro":
		case "dmg2":
		case "dmg2_transition":
		case "dmg1":
		case "dmg1_transition":
		case "base_transition":
		case "base_noweap":
		case "base_noweap_bootup":
		case "base":
			break;

		case "none":
			playermech_ui_state_reset();
			break;

		default:
			break;
	}
}

//Function Number: 48
state_chaingun_pump()
{
	set_mech_chaingun_last_state();
	var_00 = get_mech_chaingun_state();
	var_01 = self getcurrentweapon();
	self.mechuistate.chaingun.heatlevel = self getweaponheatlevel(var_01);
	self.mechuistate.chaingun.overheated = self isweaponoverheated(var_01);
	if(common_scripts\utility::flag("flag_force_hud_ready") && var_00 != "offline")
	{
		if(var_00 != "ready")
		{
			set_mech_chaingun_state("ready");
		}
	}
	else if(var_00 == "ready")
	{
		if(self.mechuistate.chaingun.overheated)
		{
			set_mech_chaingun_state("overheat");
			thread barrel_overheat_fx();
		}
		else if(self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !common_scripts\utility::flag("internal_swarm_rocket_active") && !common_scripts\utility::flag("internal_rocket_active"))
		{
			set_mech_chaingun_state("firing");
		}
	}
	else if(var_00 == "firing")
	{
		if(self.mechuistate.chaingun.overheated)
		{
			set_mech_chaingun_state("overheat");
			thread barrel_overheat_fx();
		}
		else if(!self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed())
		{
			set_mech_chaingun_state("ready");
		}
	}
	else if(var_00 == "overheat" && !self.mechuistate.chaingun.overheated)
	{
		set_mech_chaingun_state("ready");
	}

	switch(get_mech_chaingun_state())
	{
		case "ready":
			self setclientomnvar("ui_playermech_chaingun_state",1);
			break;

		case "firing":
			self setclientomnvar("ui_playermech_chaingun_state",2);
			break;

		case "overheat":
			self setclientomnvar("ui_playermech_chaingun_state",3);
			break;

		case "offline":
			self setclientomnvar("ui_playermech_chaingun_state",4);
			break;

		case "none":
			self setclientomnvar("ui_playermech_chaingun_state",0);
			break;

		default:
			break;
	}
}

//Function Number: 49
state_rocket_pump()
{
	set_mech_rocket_last_state();
	var_00 = get_mech_rocket_state();
	if(common_scripts\utility::flag("flag_force_hud_ready") && var_00 != "offline" && var_00 != "reload")
	{
		if(var_00 != "ready")
		{
			set_mech_rocket_state("ready");
		}
	}
	else if(var_00 != "offline" && playermech_invalid_rocket_callback())
	{
		set_mech_rocket_state("reload");
	}
	else if(var_00 == "reload" && !playermech_invalid_rocket_callback())
	{
		set_mech_rocket_state("ready");
	}

	switch(get_mech_rocket_state())
	{
		case "ready":
			self setclientomnvar("ui_playermech_rocket_state",1);
			break;

		case "reload":
			self setclientomnvar("ui_playermech_rocket_state",2);
			break;

		case "offline":
			self setclientomnvar("ui_playermech_rocket_state",3);
			break;

		case "none":
			self setclientomnvar("ui_playermech_rocket_state",0);
			break;

		default:
			break;
	}
}

//Function Number: 50
state_swarm_pump()
{
	set_mech_swarm_last_state();
	var_00 = get_mech_swarm_state();
	self.mechuistate.swarm.target_list = maps\_utility::remove_dead_from_array(self.mechdata.swarm_target_list);
	if(common_scripts\utility::flag("flag_force_hud_ready") && var_00 != "offline" && var_00 != "reload")
	{
		if(var_00 != "ready")
		{
			set_mech_swarm_state("ready");
			self.mechuistate.swarm.target_list = [];
		}
	}
	else if(common_scripts\utility::flag("internal_swarm_rocket_active"))
	{
		set_mech_swarm_state("target");
	}
	else if(var_00 == "target" && playermech_invalid_swarm_callback())
	{
		set_mech_swarm_state("reload");
	}
	else if(var_00 == "reload" && !playermech_invalid_swarm_callback())
	{
		set_mech_swarm_state("ready");
	}

	switch(get_mech_swarm_state())
	{
		case "ready":
			self setclientomnvar("ui_playermech_swarm_state",1);
			break;

		case "reload":
			self setclientomnvar("ui_playermech_swarm_state",3);
			break;

		case "target":
			self setclientomnvar("ui_playermech_swarm_state",2);
			break;

		case "offline":
			self setclientomnvar("ui_playermech_swarm_state",4);
			break;

		case "none":
			self setclientomnvar("ui_playermech_swarm_state",0);
			break;

		default:
			break;
	}
}

//Function Number: 51
set_mech_chaingun_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate.chaingun.state))
	{
		self.mechuistate.chaingun.state = "none";
	}

	if(self.mechuistate.chaingun.state == param_00)
	{
		return;
	}

	self.mechuistate.chaingun.state = param_00;
	self notify("chaingun_state_" + param_00);
}

//Function Number: 52
get_mech_chaingun_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.chaingun.state;
}

//Function Number: 53
set_mech_chaingun_last_state()
{
	if(isdefined(self.mechuistate.chaingun.last_state) && self.mechuistate.chaingun.state == self.mechuistate.chaingun.last_state)
	{
		return 1;
	}

	self.mechuistate.chaingun.last_state = self.mechuistate.chaingun.state;
	return 0;
}

//Function Number: 54
set_mech_rocket_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate.rocket.state))
	{
		self.mechuistate.rocket.state = "none";
	}

	if(self.mechuistate.rocket.state == param_00)
	{
		return;
	}

	self.mechuistate.rocket.state = param_00;
	self notify("rocket_state_" + param_00);
}

//Function Number: 55
get_mech_rocket_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.rocket.state;
}

//Function Number: 56
set_mech_rocket_last_state()
{
	if(isdefined(self.mechuistate.rocket.last_state) && self.mechuistate.rocket.state == self.mechuistate.rocket.last_state)
	{
		return 1;
	}

	self.mechuistate.rocket.last_state = self.mechuistate.rocket.state;
	return 0;
}

//Function Number: 57
set_mech_swarm_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate.swarm.state))
	{
		self.mechuistate.swarm.state = "none";
	}

	if(self.mechuistate.swarm.state == param_00)
	{
		return;
	}

	self.mechuistate.swarm.state = param_00;
	self notify("swarm_state_" + param_00);
}

//Function Number: 58
get_mech_swarm_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.swarm.state;
}

//Function Number: 59
set_mech_swarm_last_state()
{
	if(isdefined(self.mechuistate.swarm.last_state) && self.mechuistate.swarm.state == self.mechuistate.swarm.last_state)
	{
		return 1;
	}

	self.mechuistate.swarm.last_state = self.mechuistate.swarm.state;
	return 0;
}

//Function Number: 60
playermech_monitor_update_recharge(param_00,param_01)
{
	param_00.recharge = 0;
	var_02 = 100 / param_01 / 0.05;
	while(param_00.recharge < 100)
	{
		param_00.recharge = param_00.recharge + var_02;
		wait(0.05);
	}

	param_00.recharge = 100;
}

//Function Number: 61
playermech_monitor_rocket_recharge()
{
	self endon("exit_mech");
	self notify("stop_rocket_recharge");
	self endon("stop_rocket_recharge");
	for(;;)
	{
		self waittill("mech_rocket_fire");
		self disableoffhandweapons();
		playermech_monitor_update_recharge(self.mechuistate.rocket,4);
		self enableoffhandweapons();
		wait(0.05);
	}
}

//Function Number: 62
playermech_monitor_swarm_recharge()
{
	self endon("exit_mech");
	self notify("stop_swarm_recharge");
	self endon("stop_swarm_recharge");
	for(;;)
	{
		self waittill("mech_swarm_fire");
		self disableoffhandsecondaryweapons();
		playermech_monitor_update_recharge(self.mechuistate.swarm,6);
		self enableoffhandsecondaryweapons();
		wait(0.05);
	}
}

//Function Number: 63
playermech_link_viewmodel_part(param_00,param_01,param_02,param_03)
{
	self endon("exit_mech");
	param_00 useanimtree(param_02);
	param_00 linktoplayerview(self,param_03,(0,0,0),(0,0,0),1);
	param_00 notsolid();
	self notifyonplayercommand("playerdamage","+usereload");
	for(;;)
	{
		param_00 hide();
		self waittill("playerdamage");
		param_00 show();
		param_00 setanimrestart(param_01,1,0,1);
		wait(getanimlength(param_01) + 0.05);
	}
}

//Function Number: 64
playermech_damage_parts()
{
	if(!0)
	{
		return;
	}

	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("cap_playermech_breakable_wall");
	playermech_link_viewmodel_part(var_00,%cap_playermech_run_through_prop_short,#animtree,"tag_flash");
}

//Function Number: 65
playermech_is_damage_allowed(param_00,param_01,param_02)
{
	if(param_01 == "MOD_MELEE" && isdefined(param_02) && issubstr(param_02.classname,"enemy_mech"))
	{
		return 1;
	}

	if(self.mechdata.health - param_00 < 30)
	{
		return 1;
	}

	if(self.mechdata.damage_allowed)
	{
		return 1;
	}

	return 0;
}

//Function Number: 66
playermech_damage_manager()
{
	self endon("exit_mech");
	self.mechdata.health = level.mech_max_health;
	self.mechdata.damage_allowed = 0;
	self.mechdata.regen_cooldown = 0;
	setsaveddvar("player_damagemultiplier",level.damage_multiplier_mod);
	setsaveddvar("player_radiusDamageMultiplier",level.damage_multiplier_mod);
	childthread playermech_health_restore();
	childthread playermech_player_hit_fx();
	childthread playermech_mech_regen();
	var_00 = getdvarfloat("player_damagemultiplier");
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		self.mechdata.health = self.mechdata.health - var_01 / level.damage_multiplier_mod * 0.25;
		self notify("mech_damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		soundscripts\_snd_playsound::snd_play_at("bullet_large_mech_plr",var_04);
		self.mechdata.regen_cooldown = 1;
		if(level.script != "finale")
		{
			childthread screen_flicker_full(var_04);
		}
	}
}

//Function Number: 67
screen_flicker_full(param_00)
{
	var_01 = anglestoforward(self.angles);
	param_00 = (param_00[0],param_00[1],self.origin[2]);
	var_02 = vectornormalize(param_00 - self.origin);
	var_03 = vectordot(var_01,var_02);
	var_04 = vectorcross(var_01,var_02);
	var_05 = undefined;
	if(var_04[2] >= 0)
	{
		var_05 = self.mechdata.dmg_screen_left;
	}
	else
	{
		var_05 = self.mechdata.dmg_screen_right;
	}

	foreach(var_07 in common_scripts\utility::array_randomize(var_05))
	{
		childthread screen_flicker_full_solo(var_07);
	}
}

//Function Number: 68
screen_flicker_full_solo(param_00)
{
	if(!param_00.flickering)
	{
		param_00.flickering = 1;
		childthread show_mech_screen(param_00,0.05);
		wait(randomfloatrange(0.2,0.7));
		hide_mech_screen(param_00,0.05);
		wait(0.05);
		param_00.flickering = 0;
	}
}

//Function Number: 69
screen_flicker(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = undefined;
	if(!isplayer(self))
	{
		if(!isdefined(self.mechdata))
		{
			self.mechdata = spawnstruct();
			playermech_init_dmg_screens();
		}
	}

	if(isdefined(param_00))
	{
		var_03 = anglestoforward(self.angles);
		param_00 = (param_00[0],param_00[1],self.origin[2]);
		var_04 = vectornormalize(param_00 - self.origin);
		var_05 = vectordot(var_03,var_04);
		var_06 = vectorcross(var_03,var_04);
		if(var_06[2] >= 0)
		{
			var_02 = self.mechdata.dmg_screen_left;
		}
		else
		{
			var_02 = self.mechdata.dmg_screen_right;
		}
	}
	else
	{
		var_02 = common_scripts\utility::array_combine(self.mechdata.dmg_screen_left,self.mechdata.dmg_screen_right);
	}

	var_07 = 0.1;
	var_08 = 0.05;
	var_09 = 0;
	foreach(var_0B in common_scripts\utility::array_randomize(var_02))
	{
		if(param_01)
		{
			var_08 = randomfloatrange(0.1,1);
			var_09 = randomfloatrange(0.1,1);
			var_07 = randomfloatrange(0.1,1);
		}

		childthread show_mech_screen(var_0B,var_08);
		var_0B.flickering = 1;
		childthread hide_mech_screen(var_0B,var_08 + var_07 + var_09);
		var_0B.flickering = 0;
	}
}

//Function Number: 70
hide_mech_screen(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(!param_00.hidden)
	{
		if(isplayer(self))
		{
			self hidepartviewmodel(param_00.bone,1);
		}
		else
		{
			self hidepart(param_00.bone);
		}

		param_00.hidden = 1;
	}
}

//Function Number: 71
show_mech_screen(param_00,param_01)
{
	self endon("kill_show_mech_screen");
	self endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(param_00.hidden)
	{
		if(isplayer(self))
		{
			self hidepartviewmodel(param_00.bone,0);
		}
		else
		{
			self showpart(param_00.bone);
		}

		param_00.hidden = 0;
	}
}

//Function Number: 72
playermech_mech_regen()
{
	var_00 = 6;
	var_01 = 1;
	var_02 = level.mech_max_health / var_00 * var_01;
	for(;;)
	{
		if(!self.mechdata.regen_cooldown)
		{
			self.mechdata.health = clamp(self.mechdata.health + var_02,0,level.mech_max_health);
		}

		self.mechdata.regen_cooldown = 0;
		wait(var_01);
	}
}

//Function Number: 73
playermech_player_hit_fx()
{
	var_00 = "cg_hudDamageIconTime";
	var_01 = getdvar(var_00);
	var_02 = 0;
	var_03 = 1;
	while(self.mechdata.active)
	{
		if(self.mechdata.health < 30 && !self.mechdata.damage_allowed)
		{
			self.mechdata.damage_allowed = 1;
			thread maps\_gameskill::healthoverlay();
			setsaveddvar(var_00,var_01);
			continue;
		}

		if(var_03 || self.mechdata.health >= 30 && self.mechdata.damage_allowed)
		{
			var_03 = 0;
			self.mechdata.damage_allowed = 0;
			self setviewkickscale(0);
			self notify("noHealthOverlay");
			setsaveddvar(var_00,var_02);
		}

		wait(0.05);
	}

	setsaveddvar(var_00,var_01);
}

//Function Number: 74
playermech_health_restore()
{
	self enabledeathshield(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!playermech_is_damage_allowed(var_00,var_04,var_01))
		{
			self setnormalhealth(self.health + var_00);
			continue;
		}

		if(self.health == 1)
		{
			self enabledeathshield(0);
			if(isdefined(var_09))
			{
				self dodamage(1,var_03,var_01,var_01,var_04,var_09);
				continue;
			}

			self dodamage(1,var_03,var_01,var_01,var_04);
		}
	}
}

//Function Number: 75
playermech_dodamage(param_00,param_01,param_02)
{
	self dodamage(param_00,param_01,param_02);
}

//Function Number: 76
playermech_physics_push_on()
{
	self.physics_pulse_on = 1;
}

//Function Number: 77
playermech_physics_push_off()
{
	self.physics_pulse_on = 0;
}

//Function Number: 78
playermech_physics_push()
{
	self endon("exit_mech");
	playermech_physics_push_on();
	var_00 = 0.01;
	var_01 = 48;
	var_02 = 1;
	for(;;)
	{
		if(self.physics_pulse_on)
		{
			var_03 = clamp(length(self getvelocity()) * var_00,0,var_02);
			physicsexplosionsphere(self.origin,var_01,1,var_03);
		}

		wait(0.05);
	}
}

//Function Number: 79
playermech_physics_push_finale()
{
	self endon("exit_mech");
	playermech_physics_push_on();
	var_00 = 24;
	for(;;)
	{
		if(self.physics_pulse_on)
		{
			var_01 = var_00 * getdvarfloat("mechStandHeight") / 90;
			physicsexplosionsphere(self.origin,var_01,var_01 * 0.9,0.01);
		}

		wait(0.05);
	}
}

//Function Number: 80
playermech_invalid_gun_callback()
{
	if(self.mechuistate.chaingun.overheated)
	{
		if(self attackbuttonpressed())
		{
			self notify("callback_chaingun_state_overheat");
		}

		return 1;
	}

	return 0;
}

//Function Number: 81
playermech_invalid_rocket_callback()
{
	if(self.mechuistate.rocket.recharge < 100)
	{
		if(self fragbuttonpressed())
		{
			self notify("callback_rocket_reload");
		}

		return 1;
	}

	return 0;
}

//Function Number: 82
playermech_invalid_swarm_callback()
{
	if(self.mechuistate.swarm.recharge < 100)
	{
		if(self secondaryoffhandbuttonpressed())
		{
			self notify("callback_swarm_reload");
		}

		return 1;
	}

	return 0;
}

//Function Number: 83
playermech_invalid_weapon_instance(param_00,param_01)
{
	self endon("exit_mech");
	var_02 = 0;
	for(;;)
	{
		wait(0.05);
		if(self [[ param_00 ]]())
		{
			if(!var_02)
			{
				if([[ param_01 ]]())
				{
					var_02 = 1;
					soundscripts\_snd::snd_message("mech_weapon_offline");
				}
			}

			continue;
		}

		var_02 = 0;
	}
}

//Function Number: 84
playermech_invalid_weapon_watcher()
{
	thread playermech_invalid_weapon_instance(::attackbuttonpressed,::playermech_invalid_gun_callback);
	thread playermech_invalid_weapon_instance(::fragbuttonpressed,::playermech_invalid_rocket_callback);
	thread playermech_invalid_weapon_instance(::secondaryoffhandbuttonpressed,::playermech_invalid_swarm_callback);
}

//Function Number: 85
playermech_chaingun_watcher()
{
	self endon("exit_mech");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linktoplayerview(level.player,"j_barrel",(0,0,0),(0,0,0),1);
	for(;;)
	{
		self waittill("weapon_fired");
		if(self secondaryoffhandbuttonpressed() || self fragbuttonpressed())
		{
			continue;
		}

		self notify("chaingun_fired");
		thread barrel_heat_glow_fx(var_00);
	}

	common_scripts\utility::waittill_any_timeout(0.5,"kill_barrel_vfx");
	var_00 unlinkfromplayerview(level.player);
	var_00 delete();
}

//Function Number: 86
barrel_heat_glow_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("exo_armor_gun_barrel_heat_view"),param_00,"tag_origin");
}

//Function Number: 87
barrel_overheat_fx()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	wait 0.05;
	var_00 linktoplayerview(level.player,"j_barrel",(0,0,0),(0,0,0),1);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("exo_armor_gun_barrel_overheat_view"),var_00,"tag_origin");
	common_scripts\utility::waittill_any_timeout(4,"kill_barrel_vfx");
	killfxontag(common_scripts\utility::getfx("exo_armor_gun_barrel_overheat_view"),var_00,"tag_origin");
	var_00 unlinkfromplayerview(level.player);
	wait 0.05;
	var_00 delete();
}

//Function Number: 88
playermech_threat_paint(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self.mechdata.swarm_target_list = [];
	thread threat_paint_highlight_hud_effect();
	var_02 = [];
	var_03 = getaiarray("axis");
	foreach(var_05 in var_03)
	{
		var_06 = var_05 getlinkedparent();
		if(!isdefined(var_06) || !isdefined(var_06.code_classname) || var_06.code_classname != "script_vehicle")
		{
			var_02[var_02.size] = var_05;
		}
	}

	var_08 = [];
	var_09 = maps\_utility::getvehiclearray();
	foreach(var_0B in var_09)
	{
		if(isdefined(var_0B.script_team) && var_0B.script_team == "axis")
		{
			var_08[var_08.size] = var_0B;
		}
	}

	var_0D = sortbydistance(common_scripts\utility::array_combine(var_02,var_08),self.origin);
	var_0E = anglestoforward(self getplayerangles());
	var_0F = 1;
	if(var_0E[2] > 0.99)
	{
		var_0F = 0;
	}

	var_0E = vectornormalize(var_0E * (1,1,0));
	var_10 = [];
	foreach(var_05 in var_0D)
	{
		if(!isdefined(var_05) || !isalive(var_05))
		{
			continue;
		}

		var_05 notify("stop_marking_guy");
		unmark_swarm_target(var_05);
		mark_stencil(var_05);
		if(var_0F)
		{
			var_12 = vectornormalize(var_05.origin - self.origin * (1,1,0));
			if(length(var_12) < 0.001)
			{
				continue;
			}

			var_05.targetdot = vectordot(var_12,var_0E);
			if(var_05.targetdot < 0.7)
			{
				continue;
			}

			if(!pass_line_of_sight(var_05))
			{
				continue;
			}

			if(var_10.size < level.mech_swarm_rocket_max_targets)
			{
				var_10[var_10.size] = var_05;
				continue;
			}

			var_13 = 0;
			for(var_14 = 0;var_14 < var_10.size;var_14++)
			{
				if(var_10[var_14].targetdot < var_10[var_13].targetdot)
				{
					var_13 = var_14;
				}
			}

			if(var_05.targetdot > var_10[var_13].targetdot)
			{
				var_10[var_13] = var_05;
			}
		}
	}

	foreach(var_05 in var_10)
	{
		if(param_00)
		{
			thread handle_marking_guy(var_05);
			continue;
		}

		thread handle_marking_guy(var_05,1);
	}

	wait(0.05);
}

//Function Number: 89
pass_line_of_sight(param_00,param_01)
{
	if(level.mech_swarm_skip_line_of_sight_obstruction_test)
	{
		return 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = self.origin;
	if(isplayer(self))
	{
		var_02 = self geteye();
	}

	if(param_01)
	{
		if(1)
		{
			var_03 = param_00.origin + param_00 get_guy_offset(0);
			var_04 = bullettrace(var_02,var_03,1,self,0,1,0);
			if(isdefined(var_04["entity"]) && isdefined(var_04["entity"].script_team) && var_04["entity"].script_team == "allies")
			{
				return 0;
			}
		}

		if(isdefined(param_00.swarm_los_lock_duration_endtime) && gettime() < param_00.swarm_los_lock_duration_endtime)
		{
			return 1;
		}
	}

	param_00.swarm_los_body_behind_cover = undefined;
	param_00.swarm_los_overhead_blocked = undefined;
	var_05 = 0;
	var_03 = undefined;
	for(var_06 = 0;var_06 < 2;var_06++)
	{
		if(var_06 == 0)
		{
			var_03 = param_00.origin + param_00 get_guy_offset(0);
		}

		if(var_06 == 1)
		{
			var_03 = param_00.origin + param_00 get_guy_offset(1);
		}

		var_07 = (randomfloatrange(-10,10),randomfloatrange(-10,10),randomfloatrange(-10,10));
		var_04 = bullettrace(var_02,var_03 + var_07,0,self,0,0,0);
		if(var_04["fraction"] >= 1 || isdefined(var_04["entity"]) && param_00 != var_04["entity"])
		{
			param_00.swarm_los_lock_duration_endtime = gettime() + level.mech_swarm_line_of_sight_lock_duration * 2000;
			var_05 = 1;
			continue;
		}

		if(var_06 == 0 && distance2d(param_00.origin,var_04["position"]) < 75)
		{
			param_00.swarm_los_body_behind_cover = 1;
		}

		if(var_06 == 1)
		{
			param_00.swarm_los_overhead_blocked = 1;
		}
	}

	return var_05;
}

//Function Number: 90
playermech_threat_paint_loop(param_00)
{
	level endon("flag_force_hud_ready");
	self endon("death");
	self endon("grenade_fire");
	self endon("scripted_viewmodel_anim");
	for(;;)
	{
		if(isdefined(param_00) && param_00)
		{
			self.mechuistate.swarm.threat_scan = 1;
		}

		playermech_threat_paint(1,1);
	}
}

//Function Number: 91
playermech_threat_paint_ping_loop()
{
	self endon("death");
	self endon("exit_mech");
	for(;;)
	{
		if(!common_scripts\utility::flag("flag_mech_threat_paint_ping_on") || common_scripts\utility::flag("internal_threat_paint_in_progress"))
		{
			wait(0.05);
			continue;
		}

		if(common_scripts\utility::flag("internal_swarm_rocket_active"))
		{
			common_scripts\utility::flag_waitopen("internal_swarm_rocket_active");
			wait(0);
			continue;
		}

		playermech_threat_paint(0,1);
		wait(0);
	}
}

//Function Number: 92
threat_paint_highlight_hud_effect()
{
	common_scripts\utility::flag_set("internal_threat_paint_in_progress");
	var_00 = newclienthudelem(self);
	var_00.color = (1,0.05,0.025);
	var_00.alpha = 1;
	var_01 = 0.05;
	var_00 setradarhighlight(var_01);
	wait(var_01);
	var_00 destroy();
	common_scripts\utility::flag_clear("internal_threat_paint_in_progress");
}

//Function Number: 93
threat_paint_hud_effect()
{
	var_00 = newclienthudelem(self);
	var_00.x = self.origin[0];
	var_00.y = self.origin[1];
	var_00.z = self.origin[2];
	var_00.color = (1,0.05,0.025);
	var_00.alpha = 1;
	var_01 = 0;
	var_02 = 3000;
	var_03 = 500;
	var_00 setradarping(int(var_02 + var_03 / 2),int(var_03),var_01 + 0.05);
	wait(var_01);
	var_00 destroy();
}

//Function Number: 94
get_guy_offset(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = undefined;
	var_02 = self getcentroid()[2] - self.origin[2];
	if(!isdefined(self))
	{
		var_01 = (0,0,32);
	}
	else if(maps\_vehicle::isvehicle())
	{
		var_01 = (0,0,var_02);
	}
	else if(issubstr(self.classname,"mech"))
	{
		var_01 = (0,0,64);
	}
	else
	{
		var_01 = (0,0,32);
	}

	if(param_00 == 1)
	{
		var_01 = var_01 + (0,0,var_02) + (0,0,32);
	}
	else if(param_00 == 2)
	{
		if(isdefined(self.swarm_los_overhead_blocked) && self.swarm_los_overhead_blocked)
		{
			var_01 = get_guy_offset(0);
		}
		else
		{
			var_01 = var_01 + (0,0,var_02) + (0,0,30);
		}
	}
	else
	{
	}

	return var_01;
}

//Function Number: 95
handle_marking_guy(param_00,param_01)
{
	param_00 endon("death");
	param_00 notify("stop_marking_guy");
	param_00 endon("stop_marking_guy");
	thread handle_threat_paint_death(param_00);
	if(isdefined(param_01) && param_01)
	{
		return;
	}

	if(distance(self.origin,param_00.origin) > 3000)
	{
		return;
	}

	self.mechdata.swarm_target_list = maps\_utility::remove_dead_from_array(self.mechdata.swarm_target_list);
	if(self.mechdata.swarm_target_list.size >= level.mech_swarm_rocket_max_targets)
	{
		return;
	}

	var_02 = param_00 get_guy_offset(0);
	var_03 = 0.4;
	if(isdefined(self.mechdata.swarm_dot_override))
	{
		var_03 = self.mechdata.swarm_dot_override;
	}

	if(!maps\_utility::player_looking_at(param_00.origin + var_02,var_03,1))
	{
		var_04 = bullettrace(self geteye(),param_00.origin + var_02,0);
		if(!isdefined(var_04) || !isdefined(var_04["position"]))
		{
			return;
		}
	}

	if(!pass_line_of_sight(param_00))
	{
		return;
	}

	if(common_scripts\utility::flag("flag_force_hud_ready"))
	{
		return;
	}

	mark_swarm_target(param_00);
	var_05 = 2;
	while(maps\_utility::player_looking_at(param_00.origin + var_02,var_03,1) && !common_scripts\utility::flag("flag_force_hud_ready"))
	{
		wait(var_05);
		if(distance(self.origin,param_00.origin) > 3000)
		{
			return;
		}

		if(!pass_line_of_sight(param_00))
		{
			break;
		}

		if(!self secondaryoffhandbuttonpressed() || !self isusingoffhand())
		{
			break;
		}
	}

	unmark_swarm_target(param_00);
}

//Function Number: 96
mark_stencil(param_00)
{
	if((isdefined(param_00.disablestencil) && param_00.disablestencil) || isdefined(param_00.script_parameters) && param_00.script_parameters == "disablestencil")
	{
		return;
	}

	if(isdefined(param_00) && isalive(param_00) && !isdefined(param_00.target_stencil) || !param_00.target_stencil)
	{
		param_00.target_stencil = 1;
		if(1)
		{
			param_00 hudoutlineenable(4,1);
		}
		else
		{
			param_00 setthreatdetection("detected");
		}

		self.mechdata.threat_list = common_scripts\utility::array_add(self.mechdata.threat_list,param_00);
	}
}

//Function Number: 97
unmark_stencil(param_00)
{
	if(isdefined(param_00.target_stencil) && param_00.target_stencil)
	{
		param_00.target_stencil = undefined;
		if(1)
		{
			param_00 hudoutlinedisable();
			param_00 hudoutlineenable(0,0);
		}
		else
		{
			param_00 setthreatdetection("enhanceable");
		}

		self.mechdata.threat_list = common_scripts\utility::array_remove(self.mechdata.threat_list,param_00);
	}
}

//Function Number: 98
mark_swarm_target(param_00)
{
	if(isdefined(param_00) && isalive(param_00) && !isdefined(param_00.target_swarm) || !param_00.target_swarm)
	{
		param_00.target_swarm = 1;
		var_01 = param_00 get_guy_offset(0);
		target_set(param_00,var_01);
		target_setshader(param_00,"ui_playermech_icon_swarm_target");
		self.mechdata.swarm_target_list = common_scripts\utility::array_add(self.mechdata.swarm_target_list,param_00);
		wait(0.05);
	}
}

//Function Number: 99
unmark_swarm_target(param_00)
{
	if(isdefined(param_00.target_swarm) && param_00.target_swarm)
	{
		self.mechdata.swarm_target_list = common_scripts\utility::array_remove(self.mechdata.swarm_target_list,param_00);
	}

	param_00.target_swarm = undefined;
	if(target_istarget(param_00))
	{
		target_remove(param_00);
	}
}

//Function Number: 100
handle_threat_paint_death(param_00)
{
	param_00 notify("handle_threat_paint_death");
	param_00 endon("handle_threat_paint_death");
	param_00 waittill("death");
	if(isdefined(param_00))
	{
		param_00 notify("stop_marking_guy");
		unmark_stencil(param_00);
		unmark_swarm_target(param_00);
		param_00 setthreatdetection("disable");
	}
}

//Function Number: 101
playermech_disable_badplace()
{
	self.mechdata.create_badplace = 0;
}

//Function Number: 102
playermech_enable_badplace()
{
	self.mechdata.create_badplace = 1;
}

//Function Number: 103
playermech_badplace()
{
	self endon("exit_mech");
	for(;;)
	{
		if(self.mechdata.create_badplace)
		{
			badplace_cylinder("mech",1,self.origin,128,256,"axis");
		}

		wait(0.05);
	}
}

//Function Number: 104
playermech_rockets_wait_swarm()
{
	self endon("scripted_viewmodel_anim");
	level endon("flag_force_hud_ready");
	self waittill("grenade_fire",var_00,var_01);
	self notify("mech_swarm_fire");
	self notify("stop_delay_thread");
	thread rocket_swarm();
	var_00 delete();
}

//Function Number: 105
playermech_rockets_wait_rocket()
{
	self endon("scripted_viewmodel_anim");
	level endon("flag_force_hud_ready");
	self waittill("grenade_fire",var_00,var_01);
	self notify("mech_rocket_fire",var_00);
	thread rocket_fire_rumbles();
}

//Function Number: 106
rocket_fire_rumbles()
{
	var_00 = maps\_utility::get_rumble_ent("steady_rumble",0);
	var_00.intensity = 0.8;
	wait(0.2);
	var_00.intensity = 0;
}

//Function Number: 107
playermech_rockets_and_swarm_watcher()
{
	self endon("exit_mech");
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(common_scripts\utility::flag("flag_force_hud_ready"))
		{
			continue;
		}

		if(var_00 == self.mechdata.weapon_names["mech_lethal_weapon"])
		{
			common_scripts\utility::flag_set("internal_rocket_active");
			self notify("mech_rocket_pullback");
			playermech_rockets_wait_rocket();
			maps\_utility::delaythread(0.75,::common_scripts\utility::flag_clear,"internal_rocket_active");
		}
		else if(var_00 == self.mechdata.weapon_names["mech_tactical_weapon"])
		{
			common_scripts\utility::flag_set("internal_swarm_rocket_active");
			self notify("mech_swarm_pullback");
			maps\_utility::delaythread(level.mech_threat_paint_delay,::playermech_threat_paint_loop,1);
			playermech_rockets_wait_swarm();
			maps\_utility::delaythread(0.75,::common_scripts\utility::flag_clear,"internal_swarm_rocket_active");
		}

		maps\_utility::delaythread(2,::playermech_ui_turn_off_threat_count);
		wait(0.05);
	}
}

//Function Number: 108
mech_rocket_clear(param_00)
{
	wait(1);
	common_scripts\utility::flag_clear(param_00);
}

//Function Number: 109
playermech_ui_turn_off_threat_count()
{
	self.mechuistate.swarm.threat_scan = 0;
}

//Function Number: 110
rocket_swarm_random_course_change()
{
	self endon("death");
	self endon("rocket_start_swarm_stage_two");
	for(;;)
	{
		var_00 = 1;
		var_01 = 0.2;
		self.forward = vectornormalize(self.forward + (randomfloatrange(var_00 * -1,var_00),randomfloatrange(var_00 * -1,var_00),randomfloatrange(var_01 * -1,var_01)));
		var_02 = randomfloatrange(0.1,0.4);
		wait(var_02);
	}
}

//Function Number: 111
rocket_swarm_get_height_offset(param_00)
{
	if(isdefined(level.mech_swarm_use_two_stage_swarm) && level.mech_swarm_use_two_stage_swarm)
	{
		return param_00 get_guy_offset(2);
	}

	return param_00 get_guy_offset(0);
}

//Function Number: 112
rocket_swarm_target_course_change(param_00)
{
	self endon("death");
	self endon("rocket_start_swarm_stage_two");
	for(;;)
	{
		var_01 = param_00.origin + rocket_swarm_get_height_offset(param_00);
		self.forward = vectornormalize(var_01 - self.origin);
		wait(0.05);
	}
}

//Function Number: 113
rocket_swarm_linear_think(param_00,param_01,param_02)
{
	self endon("death");
	self endon("rocket_start_swarm_stage_two");
	self.forward = param_00;
	if(param_01)
	{
		thread rocket_swarm_random_course_change();
	}

	if(isdefined(param_02))
	{
		thread rocket_swarm_target_course_change(param_02);
	}

	for(;;)
	{
		var_03 = self.origin;
		self.origin = self.origin + self.forward * 150;
		wait(0.05);
	}
}

//Function Number: 114
rocket_two_stage_swarm_think(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.mech_swarm_use_two_stage_swarm) || !level.mech_swarm_use_two_stage_swarm)
	{
		return;
	}

	var_04 = undefined;
	var_05 = undefined;
	var_06 = param_01.origin;
	while(isvalidmissile(param_00))
	{
		if(isdefined(param_01))
		{
			var_07 = param_01.origin;
		}
		else
		{
			var_07 = var_06;
		}

		var_08 = level.mech_swarm_two_stage_swarm_homing_distance;
		var_09 = level.mech_swarm_two_stage_swarm_homing_strength;
		if(isdefined(param_01.swarm_los_body_behind_cover) && param_01.swarm_los_body_behind_cover)
		{
			var_08 = 100;
			var_09 = 10000;
		}

		if(distance2d(param_00.origin,var_07) < var_08 || isdefined(param_00.pathing_done) && param_00.pathing_done)
		{
			if(isdefined(param_02))
			{
				param_02 notify("rocket_start_swarm_stage_two");
				param_02.origin = param_01.origin + param_01 get_guy_offset(0);
				param_02 linkto(param_01);
			}

			if(isdefined(param_01))
			{
				var_04 = missile_createattractorent(param_01,var_09,100000,param_00,1,param_01 get_guy_offset(0));
			}

			break;
		}

		if(isdefined(param_01))
		{
			var_06 = param_01.origin;
		}

		wait 0.05;
	}

	if(isvalidmissile(param_00))
	{
		var_0A = gettime() + 2000;
		while(isvalidmissile(param_00) && gettime() < var_0A)
		{
			if(!isdefined(param_01))
			{
				var_05 = missile_createattractororigin(var_06,500000,100000,param_00,1);
				wait(2);
				missile_deleteattractor(var_05);
				break;
			}

			var_06 = param_01.origin;
			wait 0.05;
		}
	}

	if(isdefined(var_04))
	{
		missile_deleteattractor(var_04);
	}
}

//Function Number: 115
rocket_swarm_iterate_next_node(param_00,param_01,param_02,param_03)
{
	self endon("rocket_start_swarm_stage_two");
	self endon("death");
	for(;;)
	{
		var_04 = param_02[param_03];
		var_05 = var_04.origin + rocket_swarm_get_height_offset(param_00);
		var_06 = anglestoforward(param_01.angles);
		var_07 = vectornormalize(var_05 - param_01.origin);
		var_08 = vectordot(var_06,var_07);
		if(var_08 >= 0.7)
		{
			if(param_03 == param_02.size - 1)
			{
				self.origin = param_00.origin;
			}
			else
			{
				self.origin = var_05;
			}

			return param_03;
		}

		param_03++;
		if(param_03 == param_02.size)
		{
			self.origin = param_00.origin;
			return param_03;
		}
	}
}

//Function Number: 116
rocket_swarm_should_path(param_00,param_01,param_02)
{
	if(!isdefined(param_01) || param_01.size <= 1)
	{
		return 0;
	}

	if(abs(param_02 - param_00.origin[2]) > 80)
	{
		return 0;
	}

	return 1;
}

//Function Number: 117
rocket_swarm_path_think(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_01 endon("death");
	param_00 endon("death");
	if(!isdefined(self) || !isdefined(self.origin) || !isdefined(param_00))
	{
		return;
	}

	if(!isalive(param_00))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	var_04 = param_00.origin;
	if(param_03)
	{
		var_05 = 50;
		var_04 = var_04 + (randomfloatrange(var_05 * -1,var_05),randomfloatrange(var_05 * -1,var_05),0);
	}

	var_06 = getnodesonpath(self.origin,var_04);
	if(!rocket_swarm_should_path(param_00,var_06,param_02))
	{
		var_04 = var_04 + rocket_swarm_get_height_offset(param_00);
		var_07 = vectornormalize(var_04 - self.origin);
		if(param_03)
		{
			var_08 = 0.2;
			var_07 = vectornormalize(var_07 + (randomfloatrange(var_08 * -1,var_08),randomfloatrange(var_08 * -1,var_08),randomfloatrange(var_08 * -1,var_08)));
			thread rocket_swarm_linear_think(var_07,0,undefined);
		}
		else
		{
			thread rocket_swarm_linear_think(var_07,0,param_00);
			thread rocket_two_stage_swarm_think(param_01,param_00,self,0);
		}

		return;
	}

	thread rocket_swarm_path_node_think(param_01,param_02,var_07,var_06);
	thread rocket_two_stage_swarm_think(param_02,param_01,self,1);
}

//Function Number: 118
rocket_swarm_path_node_think(param_00,param_01,param_02,param_03)
{
	self endon("rocket_start_swarm_stage_two");
	var_04 = 0;
	while(isdefined(self))
	{
		var_05 = self.origin;
		var_04 = rocket_swarm_iterate_next_node(param_00,param_01,param_02,var_04);
		var_06 = -5;
		if(self.origin[2] - var_05[2] < var_06)
		{
			self.origin = (self.origin[0],self.origin[1],var_05[2] + var_06);
		}

		if(var_04 == param_02.size)
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(param_01))
	{
		param_01.pathing_done = 1;
	}
}

//Function Number: 119
rocket_swarm_start_position(param_00,param_01)
{
	var_02 = level.mech_swarm_rocket_max_targets + level.mech_swarm_rocket_dud_max_count;
	var_03 = 15;
	var_04 = 80;
	var_05 = var_04 / 2;
	var_06 = var_02 / 2;
	var_07 = var_04 / var_06;
	var_08 = (150,60,10);
	if(param_01 == 0)
	{
		var_08 = var_08 * (0,1,1);
	}

	if(param_01 >= var_06)
	{
		var_08 = var_08 + (0,0,var_03);
		param_01 = param_01 - var_06;
	}
	else
	{
		var_08 = var_08 - (0,0,var_03);
	}

	var_08 = var_08 + (0,var_07 * param_01 - var_05,0);
	var_09 = param_00 + rotatevector(var_08,self getplayerangles());
	return var_09;
}

//Function Number: 120
rocket_swarm_death_thread(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_01))
	{
		param_01 endon("death");
	}

	for(;;)
	{
		if(isdefined(param_01) && distance(param_00.origin,param_01.origin) < 64)
		{
			param_02 unmark_swarm_target(param_01);
			radiusdamage(param_01.origin,128,300,300,param_02);
			if(issubstr(param_01.classname,"pdrone"))
			{
				param_01 notify("death",param_02,"MOD_MECH_SWARM_DESTROY");
				param_01 kill();
			}

			param_00 delete();
		}

		wait(0.05);
	}
}

//Function Number: 121
rocket_swarm_create_and_manage_attractor(param_00,param_01,param_02)
{
	self.origin = param_00.origin;
	missile_createattractorent(self,5000,100000,param_00,1);
	rocket_swarm_death_thread(param_00,param_01,param_02);
	self delete();
}

//Function Number: 122
rocket_swarm_straight_rocket(param_00,param_01,param_02,param_03)
{
	var_04 = rocket_swarm_start_position(param_00,param_02);
	var_05 = magicbullet(self.mechdata.weapon_names["mech_swarm_rocket"],var_04,var_04 + param_01 * 1000,self);
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06 thread rocket_swarm_create_and_manage_attractor(var_05,undefined,self);
	var_06 thread rocket_swarm_linear_think(param_01,param_03);
}

//Function Number: 123
rocket_swarm()
{
	thread rocket_swarm_fired_rumbles();
	var_00 = self geteye();
	var_01 = vectornormalize(anglestoforward(self getplayerangles()));
	if(0)
	{
		var_02 = sortbydistance(getaiarray("axis"),self.origin);
		var_03 = get_front_sorted_threat_list(var_02,var_01);
	}
	else
	{
		var_03 = maps\_utility::remove_dead_from_array(self.mechdata.swarm_target_list);
	}

	var_04 = 0;
	var_05 = 0;
	if(var_03.size == 0)
	{
		rocket_swarm_straight_rocket(var_00,var_01,var_04,0);
		var_04++;
		wait(0.05);
	}

	var_06 = 0;
	while(var_03.size && var_04 < level.mech_swarm_rocket_max_targets)
	{
		var_03 = maps\_utility::remove_dead_from_array(var_03);
		if(var_03.size == 0)
		{
			break;
		}

		foreach(var_08 in var_03)
		{
			if(!isalive(var_08))
			{
				break;
			}

			var_09 = rocket_swarm_start_position(var_00,var_04);
			var_0A = rocket_swarm_end_position(var_09,var_08);
			var_0B = magicbullet(self.mechdata.weapon_names["mech_swarm_rocket"],var_09,var_0A,self);
			if(isai(var_08) && target_istarget(var_08))
			{
				target_setshader(var_08,"ui_playermech_icon_swarm_target");
			}

			var_0C = common_scripts\utility::spawn_tag_origin();
			var_0C thread rocket_swarm_create_and_manage_attractor(var_0B,var_08,self);
			var_0C thread rocket_swarm_path_think(var_08,var_0B,self.origin[2],var_06);
			var_04++;
			if(var_04 >= level.mech_swarm_rocket_max_targets)
			{
				break;
			}

			wait(0.05);
		}

		var_05++;
		if(var_03.size == 1)
		{
			if(var_04 == 2)
			{
				var_06 = 1;
			}

			continue;
		}

		if(var_05 >= level.mech_swarm_number_of_rockets_per_target)
		{
			var_06 = 1;
		}
	}

	var_0E = randomintrange(level.mech_swarm_rocket_dud_min_count,level.mech_swarm_rocket_dud_max_count + 1);
	var_0F = var_0E + level.mech_swarm_rocket_max_targets;
	while(var_04 < var_0F)
	{
		rocket_swarm_straight_rocket(var_00,var_01,var_04,1);
		wait(0.05);
		var_04++;
	}
}

//Function Number: 124
rocket_swarm_end_position(param_00,param_01)
{
	if(isdefined(level.mech_swarm_use_two_stage_swarm) && level.mech_swarm_use_two_stage_swarm)
	{
		return param_01.origin + get_guy_offset(2);
	}

	var_02 = vectornormalize(param_01.origin - param_00);
	return param_00 + var_02 * 1000;
}

//Function Number: 125
rocket_swarm_fired_rumbles()
{
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble",0);
	var_00.intensity = 0.4;
	wait(0.1);
	var_00.intensity = 0.6;
	wait(0.1);
	var_00.intensity = 0.8;
	wait(0.1);
	var_00.intensity = 1;
	wait(0.1);
	var_00.intensity = 0;
}

//Function Number: 126
hide_mech_glass_static_overlay(param_00)
{
	foreach(var_02 in level.player.mechdata.dmg_screen_right)
	{
		param_00 hidepart(var_02.bone);
	}

	foreach(var_02 in level.player.mechdata.dmg_screen_left)
	{
		param_00 hidepart(var_02.bone);
	}
}

//Function Number: 127
scripted_screen_flicker_loop(param_00)
{
	self notify("kill_duplicate_scripted_screen_flicker_loop");
	self endon("death");
	self endon("kill_duplicate_scripted_screen_flicker_loop");
	var_01 = -1;
	if(isstring(param_00))
	{
		self endon(param_00);
	}
	else if(isdefined(param_00))
	{
		var_01 = gettime() + param_00 * 1000;
	}

	screen_flicker(undefined,0);
	wait(0.1);
	screen_flicker(undefined,0);
	wait(0.2);
	screen_flicker(undefined,0);
	while(!isdefined(param_00) || gettime() < var_01)
	{
		screen_flicker(undefined,1);
		wait(2);
	}
}

//Function Number: 128
unlimited_mech_ammo()
{
	self endon("exit_mech");
	for(;;)
	{
		foreach(var_01 in self getweaponslistall())
		{
			level.player setweaponammostock(var_01,weaponmaxammo(var_01));
		}

		wait(5);
	}
}

//Function Number: 129
aud_playermech_start()
{
	if(!isdefined(level.player.audio.mech_amb) || level.player.audio.mech_amb == 0)
	{
		level.player soundscripts\_snd_playsound::snd_play_loop_2d("mech_suit_cockpit_plr","stop_playermech_cockpit",3,2);
		level.player.audio.mech_amb = 1;
	}

	level.player.audio.mech_steps = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("player_mech");
}

//Function Number: 130
aud_playermech_end()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("player_mech");
	level.player.audio.mech_steps = 0;
	level.player.audio.mech_amb = 0;
	level notify("stop_playermech_cockpit");
}

//Function Number: 131
aud_playermech_foley_override_handler()
{
	level.player endon("death");
	if(!isdefined(level.player.audio))
	{
		level.player.audio = spawnstruct();
	}

	if(!isdefined(level.player.audio.mech_steps))
	{
		level.player.audio.mech_steps = 0;
	}

	level.player waittill("playermech_start");
	for(;;)
	{
		level.player waittill("foley",var_00,var_01,var_02);
		switch(var_00)
		{
			case "walk":
				if(level.player.audio.mech_steps == 1)
				{
				}
				break;
	
			case "run":
				if(level.player.audio.mech_steps == 1)
				{
				}
				break;
	
			case "sprint":
				if(level.player.audio.mech_steps == 1)
				{
				}
				break;
	
			case "jump":
				if(level.player.audio.mech_steps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mech_jump_plr");
				}
				break;
	
			case "lightland":
				if(level.player.audio.mech_steps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mech_walk_plr");
					soundscripts\_snd_playsound::snd_play_2d("mech_run_plr");
				}
				break;
	
			case "mediumland":
				if(level.player.audio.mech_steps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mech_walk_plr");
					soundscripts\_snd_playsound::snd_play_2d("mech_run_plr");
				}
				break;
	
			case "heavyland":
				if(level.player.audio.mech_steps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mech_walk_plr");
					soundscripts\_snd_playsound::snd_play_2d("mech_run_plr");
				}
				break;
	
			case "damageland":
				if(level.player.audio.mech_steps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mech_walk_plr");
					soundscripts\_snd_playsound::snd_play_2d("mech_run_plr");
				}
				break;
	
			case "stationarycrouchscuff":
				break;
	
			case "stationaryscuff":
				break;
	
			case "crouchscuff":
				break;
	
			case "runscuff":
				break;
	
			case "sprintscuff":
				break;
	
			case "prone":
				break;
	
			case "crouchwalk":
				break;
	
			case "crouchrun":
				break;
	
			case "mantleuphigh":
				break;
	
			case "mantleupmedium":
				break;
	
			case "mantleuplow":
				break;
	
			case "mantleoverhigh":
				break;
	
			case "mantleovermedium":
				break;
	
			case "mantleoverlow":
				break;
		}
	}
}