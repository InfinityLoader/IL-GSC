/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: betrayal_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 170
 * Decompile Time: 2502 ms
 * Timestamp: 4/22/2024 2:25:46 AM
*******************************************************************/

//Function Number: 1
move_player_to_ent_by_targetname(param_00)
{
	var_01 = get_ent_by_targetname(param_00);
	maps\_utility::teleport_player(var_01);
	return var_01;
}

//Function Number: 2
move_squad_member_to_ent_by_targetname(param_00)
{
	var_01 = get_ent_by_targetname(param_00);
	self forceteleport(var_01.origin,var_01.angles);
}

//Function Number: 3
move_squad_member_to_ent(param_00)
{
	self forceteleport(param_00.origin,param_00.angles);
}

//Function Number: 4
give_player_just_hands()
{
	level.player disableweapons();
	level.player allowmelee(0);
	level.player allowsprint(0);
	level.player setmovespeedscale(0.45);
	level thread start_player_walk_sway();
}

//Function Number: 5
give_player_gun()
{
	level.player enableweapons();
	level.player allowmelee(1);
	level.player allowsprint(1);
	level.player maps\_utility::blend_movespeedscale_default();
	level.player notify("stop_player_walk_sway");
}

//Function Number: 6
activate_betrayal_exo_abilities()
{
	maps\_player_exo::setboostdash();
	maps\_player_exo::setoverdrive();
	maps\_player_exo::setexoslide();
}

//Function Number: 7
deactivate_betrayal_exo_abilities()
{
	maps\_player_exo::unsetboostdash();
	maps\_player_exo::unsetoverdrive();
	maps\_player_exo::unsetexoslide();
}

//Function Number: 8
start_player_walk_sway()
{
	level.player endon("death");
	level.player endon("stop_player_walk_sway");
	for(;;)
	{
		screenshake(level.player.origin,1,1,0.5,2,0.2,0.2,0,0.15,0.18,0.05);
		wait(1.5);
	}
}

//Function Number: 9
start_player_office_scene_walk_sway()
{
	level.player endon("death");
	level.player endon("stop_player_walk_sway");
	common_scripts\utility::flag_wait("flag_objective_office_scene_follow_gideon");
	var_00 = getdvar("bg_viewBobAmplitudeStanding");
	var_01 = getdvar("bg_viewBobAmplitudeDucked");
	var_02 = getdvar("bg_viewBobMax");
	setsaveddvar("bg_viewBobAmplitudeStanding","0.005 0.01");
	setsaveddvar("bg_viewBobAmplitudeDucked","0.002 0.005");
	setsaveddvar("bg_viewBobMax",3);
	level.player setbobrate(0.8);
	common_scripts\utility::flag_wait("flag_confrontation_give_player_real_gun");
	setsaveddvar("bg_viewBobAmplitudeStanding",var_00);
	setsaveddvar("bg_viewBobAmplitudeDucked",var_01);
	setsaveddvar("bg_viewBobMax",var_02);
	level.player setbobrate(1);
}

//Function Number: 10
player_apply_mission_failed_wrapper_on_death_for_duration(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		level.player common_scripts\utility::waittill_any_timeout(param_01,"death");
		setdvar("ui_deadquote",&"mission_fail_wrapper");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 11
player_mission_failed_handler(param_00,param_01,param_02)
{
	if((isdefined(param_01) && common_scripts\utility::flag(param_01)) || isdefined(param_02) && !common_scripts\utility::flag(param_02))
	{
		common_scripts\utility::flag_set("disable_autosaves");
		level.player common_scripts\utility::waittill_any_timeout(param_00,"death");
		if((isdefined(param_01) && !common_scripts\utility::flag(param_01)) || isdefined(param_02) && common_scripts\utility::flag(param_02))
		{
			common_scripts\utility::flag_clear("disable_autosaves");
			maps\_utility::autosave_by_name();
			return 1;
		}

		wait(0.5);
		setdvar("ui_deadquote",&"BETRAYAL_FAIL_ESCAPE");
		maps\_utility::missionfailedwrapper();
		return 0;
	}

	return 1;
}

//Function Number: 12
spawn_squad(param_00,param_01,param_02)
{
	if(isdefined(param_01) && param_01)
	{
		level.gideon = spawn_squad_member(param_00,"gideon");
	}

	if(isdefined(param_02) && param_02)
	{
		level.ilana = spawn_squad_member(param_00,"ilana");
		level.ilana maps\_utility::place_weapon_on("iw5_sn6_sp_opticsreddot","right");
		level.ilana maps\_utility::gun_remove();
	}
}

//Function Number: 13
spawn_squad_member(param_00,param_01)
{
	var_02 = spawn_ai_from_targetname_single("spawner_squad_" + param_01,1,1);
	var_02.ignoreall = 1;
	var_02.dontmelee = 1;
	var_02 maps\_utility::gun_remove();
	if(param_01 == "gideon")
	{
		var_02 maps\_urgent_walk::set_urgent_walk_anims();
	}

	var_02 setup_hero(param_01);
	var_02 start_squad_member_at_start(param_00 + "_" + param_01);
	var_02 setgoalpos(var_02.origin);
	return var_02;
}

//Function Number: 14
setup_hero(param_00)
{
	maps\_utility::make_hero();
	self.animname = param_00;
}

//Function Number: 15
start_squad_member_at_start(param_00)
{
	var_01 = get_ent_by_targetname(param_00);
	self forceteleport(var_01.origin,var_01.angles);
}

//Function Number: 16
player_knockout_white()
{
	level.crash_overlay = get_white_overlay();
	level.crash_overlay thread blackout(0.01,2);
}

//Function Number: 17
player_knockout_wakeup()
{
	if(isdefined(level.crash_overlay))
	{
		level.crash_overlay thread restorevision(2,0);
	}

	level.player shellshock("default",6);
}

//Function Number: 18
get_white_overlay()
{
	if(!isdefined(level.white_overlay))
	{
		level.white_overlay = maps\_hud_util::create_client_overlay("white",0,level.player);
	}

	level.white_overlay.sort = -1;
	level.white_overlay.foreground = 1;
	return level.white_overlay;
}

//Function Number: 19
blackout(param_00,param_01)
{
	fadeoverlay(param_00,1,param_01);
}

//Function Number: 20
restorevision(param_00,param_01)
{
	fadeoverlay(param_00,0,param_01);
}

//Function Number: 21
fadeoverlay(param_00,param_01,param_02)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	setblur(param_02,param_00);
	wait(param_00);
}

//Function Number: 22
animate_player_on_rig_simple(param_00,param_01,param_02,param_03,param_04)
{
	level.rig = maps\_utility::spawn_anim_model(param_00,level.player.origin,level.player.angles);
	level.rig hide();
	level.player maps\_shg_utility::setup_player_for_scene();
	var_05 = 0.5;
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	var_06 = get_ent_by_targetname(param_02);
	var_06 maps\_anim::anim_first_frame_solo(level.rig,param_01);
	level.player playerlinktoblend(level.rig,"tag_player",var_05);
	level.rig common_scripts\utility::delaycall(var_05,::show);
	level.player common_scripts\utility::delaycall(var_05,::playerlinktodelta,level.rig,"tag_player",1,0,0,0,0,1);
	if(isdefined(param_04))
	{
		param_04 = common_scripts\utility::array_add(param_04,level.rig);
		var_06 maps\_anim::anim_single(param_04,param_01);
	}
	else
	{
		var_06 maps\_anim::anim_single_solo(level.rig,param_01);
	}

	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.rig delete();
}

//Function Number: 23
spawn_ai_from_targetname_single(param_00,param_01,param_02)
{
	var_03 = spawn_ai_from_targetname(param_00,param_01,param_02);
	return var_03[0];
}

//Function Number: 24
spawn_ai_from_targetname(param_00,param_01,param_02)
{
	var_03 = get_ents_by_targetname(param_00);
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = [];
	foreach(var_06 in var_03)
	{
		var_04[var_04.size] = var_06 maps\_utility::spawn_ai(param_01,param_02);
	}

	return var_04;
}

//Function Number: 25
add_spawn_function_to_targetname(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = get_ents_by_targetname(param_00);
	common_scripts\utility::array_thread(var_07,::maps\_utility::add_spawn_function,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 26
add_spawn_function_to_noteworthy(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = get_ents_by_noteworthy(param_00);
	common_scripts\utility::array_thread(var_07,::maps\_utility::add_spawn_function,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 27
remove_on_spawner_delete()
{
	self endon("death");
	var_00 = self.spawner;
	self.script_linkname = undefined;
	var_00 waittill("death");
	if(isai(self))
	{
		delete_ai();
	}

	if(maps\_vehicle::isvehicle())
	{
		delete_veh();
	}
}

//Function Number: 28
allow_boost_jump()
{
	self.canjumppath = 1;
}

//Function Number: 29
remove_display_name()
{
	self.name = " ";
}

//Function Number: 30
set_display_name(param_00)
{
	self.name = param_00;
}

//Function Number: 31
setup_squad_member_for_scene()
{
	self.old_name = self.name;
	self.name = " ";
}

//Function Number: 32
setup_squad_member_for_gameplay()
{
	self.name = self.old_name;
}

//Function Number: 33
force_to_always_sidearm()
{
	animscripts\utility::setalwaysusepistol(1);
}

//Function Number: 34
set_custom_patrol_anim_set(param_00)
{
	set_custom_run_anim(param_00);
	self allowedstances("stand");
	self.oldcombatmode = self.combatmode;
	self.combatmode = "no_cover";
	maps\_utility::disable_cqbwalk();
}

//Function Number: 35
set_custom_run_anim(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(level.scr_anim["generic"]["patrol_walk_" + param_00]))
	{
		var_01 = "patrol_walk_" + param_00;
	}

	if(isdefined(level.scr_anim["generic"]["patrol_walk_weights_" + param_00]))
	{
		var_02 = "patrol_walk_weights_" + param_00;
	}

	maps\_utility::set_generic_run_anim_array(var_01,var_02,1);
	if(isdefined(level.scr_anim["generic"]["patrol_idle_" + param_00]))
	{
		var_03 = "patrol_idle_" + param_00;
		maps\_utility::set_generic_idle_anim(var_03);
	}

	if(isdefined(level.scr_anim["generic"]["patrol_transin_" + param_00]))
	{
		self.customarrivalfunc = ::custom_idle_trans_function;
		self.startidletransitionanim = level.scr_anim["generic"]["patrol_transin_" + param_00];
	}

	if(isdefined(level.scr_anim["generic"]["patrol_transout_" + param_00]))
	{
		self.permanentcustommovetransition = 1;
		self.custommovetransition = ::animscripts\cover_arrival::custommovetransitionfunc;
		self.startmovetransitionanim = level.scr_anim["generic"]["patrol_transout_" + param_00];
	}
}

//Function Number: 36
clear_custom_patrol_anim_set()
{
	maps\_utility::clear_generic_run_anim();
	maps\_utility::clear_generic_idle_anim();
	self.permanentcustommovetransition = undefined;
	self.custommovetransition = undefined;
	self.startmovetransitionanim = undefined;
	self.customarrivalfunc = undefined;
	self.startidletransitionanim = undefined;
	self allowedstances("stand","crouch","prone");
	if(isdefined(self.oldcombatmode))
	{
		self.combatmode = self.oldcombatmode;
	}
}

//Function Number: 37
custom_idle_trans_function()
{
	if(!isdefined(self.startidletransitionanim))
	{
		return;
	}

	var_00 = self.approachnumber;
	var_01 = self.startidletransitionanim;
	if(!isdefined(self.heat))
	{
		thread animscripts\cover_arrival::abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.movetransitionrate);
	animscripts\face::playfacialanim(var_01,"run");
	animscripts\shared::donotetracks("coverArrival",::animscripts\cover_arrival::handlestartaim);
	var_02 = level.arrivalendstance[self.approachtype];
	if(isdefined(var_02))
	{
		self.a.pose = var_02;
	}

	self.a.movement = "stop";
	self.a.arrivaltype = self.approachtype;
	self clearanim(%root,0.3);
	self.lastapproachaborttime = undefined;
	var_03 = self.origin - self.goalpos;
}

//Function Number: 38
event_actor_animations(param_00,param_01,param_02)
{
	level endon(param_02);
	self endon("death");
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(param_01[var_03]["anim"] != "SKIP_BEAT")
		{
			common_scripts\utility::flag_wait(param_01[var_03]["wait_flag"]);
			stop_current_animations();
			if(param_01[var_03]["anim"] == "PATH_TO_TARGET")
			{
				maps\_utility::set_goalradius(16);
				self notify("move");
				if(param_01[var_03 + 1]["anim"] != "TELEPORT_TO_TARGET")
				{
					self waittill("goal");
					self.target = undefined;
					common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
				}

				continue;
			}

			if(param_01[var_03]["anim"] == "TELEPORT_TO_TARGET")
			{
				var_04 = getnode(self.target,"targetname");
				maps\_utility::teleport_ai(var_04);
				common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
				continue;
			}

			if(param_01[var_03]["anim"] == "WAIT_DELAY")
			{
				common_scripts\utility::flag_wait(param_01[var_03]["wait_for"]);
				common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
				continue;
			}

			if(param_01[var_03]["anim"] == "REACT")
			{
				self.animname = "scripted";
				var_05 = self.script_parameters;
				maps\_anim::anim_single_solo(self,var_05);
				continue;
			}

			if(isarray(level.scr_anim["scripted"][param_01[var_03]["anim"]]))
			{
				self.animname = "scripted";
				thread maps\_anim::anim_loop([self],param_01[var_03]["anim"]);
				continue;
			}

			self.animname = "scripted";
			maps\_anim::anim_single_solo(self,param_01[var_03]["anim"]);
			common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
		}
	}
}

//Function Number: 39
generic_event_actor_animations(param_00,param_01,param_02)
{
	level endon(param_02);
	self endon("death");
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(param_01[var_03]["anim"] != "SKIP_BEAT")
		{
			common_scripts\utility::flag_wait(param_01[var_03]["wait_flag"]);
			stop_current_animations();
			if(param_01[var_03]["anim"] == "IDLE")
			{
				self.animname = "scripted";
				var_04 = self.animation;
				thread maps\_anim::anim_loop([self],var_04);
				continue;
			}

			if(param_01[var_03]["anim"] == "PATH_TO_TARGET")
			{
				self notify("move");
				if(param_01[var_03 + 1]["anim"] != "TELEPORT_TO_TARGET")
				{
					self waittill("goal");
					self.target = undefined;
					common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
				}

				continue;
			}

			if(param_01[var_03]["anim"] == "TELEPORT_TO_TARGET")
			{
				var_05 = getnode(self.target,"targetname");
				maps\_utility::teleport_ai(var_05);
				common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
				continue;
			}

			if(param_01[var_03]["anim"] == "TARGET_REACHED_IDLE_ANIM")
			{
				self.animname = "scripted";
				var_04 = self.script_parameters;
				maps\_anim::anim_single_solo(self,var_04);
				continue;
			}

			if(param_01[var_03]["anim"] == "WAIT_DELAY")
			{
				common_scripts\utility::flag_wait(param_01[var_03]["wait_for"]);
				common_scripts\utility::flag_set(param_00 + "_completed_beat_" + var_03);
				continue;
			}

			if(param_01[var_03]["anim"] == "REACT")
			{
				self.animname = "scripted";
				var_04 = self.script_noteworthy;
				maps\_anim::anim_single_solo_run(self,var_04);
			}
		}
	}
}

//Function Number: 40
stop_current_animations(param_00)
{
	self endon("death");
	self stopanimscripted();
	self notify("drone_stop");
	self notify("stop_loop");
	self notify("single anim","end");
	self notify("looping anim","end");
	if(isdefined(param_00))
	{
		param_00 notify("drone_stop");
		param_00 notify("stop_loop");
		param_00 notify("single anim","end");
		param_00 notify("looping anim","end");
	}
}

//Function Number: 41
simple_anim_at_struct(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	var_02 = var_01.animation;
	wait(randomfloatrange(0.5,2));
	var_01 maps\_anim::anim_reach_solo(self,var_02);
	var_01 maps\_anim::anim_single_solo(self,var_02);
	self notify("anim_finished");
}

//Function Number: 42
clear_ignore_all_on_group(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02 stop_current_animations();
			var_02 maps\_utility::set_ignoreall(0);
		}
	}
}

//Function Number: 43
delete_ai(param_00)
{
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	if(!isdefined(param_00))
	{
		param_00 = 128;
	}

	var_01[0] = self;
	level thread maps\_utility::ai_delete_when_out_of_sight(var_01,param_00);
}

//Function Number: 44
delete_ai_on_goal()
{
	self endon("death");
	self waittill("goal");
	delete_ai();
}

//Function Number: 45
delete_ai_on_flag(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	delete_ai();
}

//Function Number: 46
delete_ai_on_path_end()
{
	self endon("death");
	self waittill("reached_path_end");
	self delete();
}

//Function Number: 47
clean_up_ai_single(param_00)
{
	var_01[0] = param_00;
	clean_up_ai(var_01);
}

//Function Number: 48
clean_up_ai(param_00)
{
	var_01 = getaiarray();
	foreach(var_03 in var_01)
	{
		if(common_scripts\utility::array_contains(param_00,var_03))
		{
			continue;
		}

		var_03 delete_ai();
	}
}

//Function Number: 49
clean_up_vehicles_all()
{
	var_00 = maps\_utility::getvehiclearray();
	foreach(var_02 in var_00)
	{
		var_02 delete_veh();
	}
}

//Function Number: 50
clean_up_vehicle_type(param_00)
{
	var_01 = maps\_utility::getvehiclearray();
	foreach(var_03 in var_01)
	{
		if(var_03.vehicletype == param_00)
		{
			var_03 delete_veh();
		}
	}
}

//Function Number: 51
delete_veh(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 128;
	}

	var_01[0] = self;
	level thread maps\_utility::ai_delete_when_out_of_sight(var_01,param_00);
}

//Function Number: 52
open_double_doors_by_name(param_00,param_01,param_02)
{
	var_03 = get_ents_by_targetname(param_00 + "_right");
	var_04 = get_ents_by_targetname(param_00 + "_left");
	level thread open_door(var_03,param_01,param_02);
	level thread open_door(var_04,param_01,param_02 * -1);
}

//Function Number: 53
open_double_hatch_by_name(param_00,param_01,param_02)
{
	var_03 = get_ents_by_targetname(param_00 + "_right");
	var_04 = get_ents_by_targetname(param_00 + "_left");
	level thread open_door(var_03,param_01,param_02);
	level thread open_door(var_04,param_01,param_02);
}

//Function Number: 54
open_single_door_by_name(param_00,param_01,param_02)
{
	var_03 = get_ents_by_targetname(param_00);
	level thread open_door(var_03,param_01,param_02);
}

//Function Number: 55
open_door(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(var_04.classname == "script_brushmodel")
		{
			var_04 connectpaths();
		}

		var_04 rotateyaw(param_02,param_01,param_01 / 5,param_01 / 5);
	}

	wait(param_01);
	foreach(var_04 in param_00)
	{
		if(var_04.classname == "script_brushmodel")
		{
			var_04 disconnectpaths();
		}
	}
}

//Function Number: 56
open_double_sliding_doors_toggle(param_00,param_01)
{
	var_02 = get_ents_by_targetname(param_00 + "_right");
	var_03 = get_ents_by_targetname(param_00 + "_left");
	level thread open_sliding_door_toggle(var_02,param_00,param_01);
	level thread open_sliding_door_toggle(var_03,param_00,param_01);
}

//Function Number: 57
open_sliding_door_toggle(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_00)
	{
		var_06 = get_ent_by_targetname(var_05.targetname + "_goal");
		var_07 = get_ent_by_targetname(var_05.targetname + "_default_org");
		var_05.col = get_ent_by_targetname(var_05.target);
		var_05.col linkto(var_05);
		if(isdefined(var_05.col) && var_05.col.classname == "script_brushmodel")
		{
			var_05.col connectpaths();
		}

		if(isdefined(param_03))
		{
			var_08 = param_03 * var_06.origin - var_07.origin + var_07.origin;
			soundscripts\_snd::snd_message("bet_conf_door_opens",var_05);
			var_05 moveto(var_08,param_02,param_02 / 2,param_02 / 2);
			wait(param_02);
			var_05.col disconnectpaths();
			continue;
		}

		if(var_05.origin == var_06.origin)
		{
			var_05 moveto(var_07.origin,param_02,param_02 / 2,param_02 / 2);
			wait(param_02);
			var_05.col disconnectpaths();
			if(var_05.classname == "script_brushmodel")
			{
				var_05 disconnectpaths();
			}

			continue;
		}

		if(var_05.origin == var_07.origin)
		{
			var_05 moveto(var_06.origin,param_02,param_02 / 2,param_02 / 2);
			wait(param_02);
			var_05.col connectpaths();
			if(var_05.classname == "script_brushmodel")
			{
				var_05 connectpaths();
			}

			continue;
		}

		var_05 moveto(var_06.origin,param_02,param_02 / 2,param_02 / 2);
		wait(param_02);
		var_05.col connectpaths();
		if(var_05.classname == "script_brushmodel")
		{
			var_05 connectpaths();
		}
	}
}

//Function Number: 58
prepare_blast_doors(param_00,param_01)
{
	var_02 = get_ents_by_targetname(param_00);
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.prepared) && var_04.prepared)
		{
			continue;
		}

		var_04.prepared = 1;
		var_04.original_org = var_04.origin;
		var_04.origin = var_04.origin + (0,0,param_01);
		var_04.opened_org = var_04.origin;
	}
}

//Function Number: 59
raise_blast_doors(param_00,param_01,param_02)
{
	var_03 = get_ents_by_targetname(param_00);
	var_03 = common_scripts\utility::array_sort_with_func(var_03,::blast_door_compare);
	var_04 = 1;
	var_05 = var_03[var_03.size - 1].door_num;
	var_06 = 0;
	while(var_04 <= var_05)
	{
		var_07 = [];
		while(var_06 < var_03.size && var_03[var_06].door_num == var_04)
		{
			var_03[var_06].prepared = 0;
			var_03[var_06] moveto(var_03[var_06].original_org,param_01,0,param_01 / 4);
			var_07[var_07.size] = var_03[var_06];
			var_06++;
		}

		wait(param_01);
		var_04++;
	}

	if(isdefined(param_02))
	{
		blast_doors_mr_x(var_03,param_02);
	}
}

//Function Number: 60
blast_doors_mr_x(param_00,param_01)
{
	param_00 = common_scripts\utility::array_randomize(param_00);
	var_02 = 0.5;
	var_03 = 1;
	var_04 = [40,100,120,70];
	var_05 = [40,100,120,70];
	var_06 = 0;
	common_scripts\utility::flag_wait(param_01);
	foreach(var_08 in param_00)
	{
		var_09 = randomfloatrange(var_02,var_03);
		var_08 moveto(var_08.opened_org + var_04[var_06] * anglestoup(var_08.angles),var_09,0,var_09 / 4);
		wait(0.1);
		var_06++;
		if(var_06 > 3)
		{
			var_06 = 0;
		}
	}

	var_06 = 0;
	wait(0.2);
	foreach(var_08 in param_00)
	{
		var_09 = randomfloatrange(var_02,var_03);
		var_08 moveto(var_08.original_org - var_05[var_06] * anglestoup(var_08.angles),var_09,0,var_09 / 4);
		wait(0.1);
		var_06++;
		if(var_06 > 3)
		{
			var_06 = 0;
		}
	}

	wait(0.2);
	foreach(var_08 in param_00)
	{
		var_08 moveto(var_08.opened_org,var_02,0,var_02 / 4);
		wait(0.1);
	}

	common_scripts\utility::flag_wait("flag_roof_close_mrX_blast_doors");
	wait(2);
	param_00 = common_scripts\utility::array_randomize(param_00);
	foreach(var_08 in param_00)
	{
		var_09 = randomfloatrange(var_02,var_03);
		var_08 moveto(var_08.original_org,var_09,0,var_09 / 4);
	}
}

//Function Number: 61
blast_door_compare(param_00,param_01)
{
	if(!isdefined(param_00.doornum))
	{
		param_00.door_num = get_blast_door_num(param_00.script_noteworthy);
	}

	if(!isdefined(param_01.doornum))
	{
		param_01.door_num = get_blast_door_num(param_01.script_noteworthy);
	}

	return param_00.door_num < param_01.door_num;
}

//Function Number: 62
get_blast_door_num(param_00)
{
	var_01 = strtok(param_00,"_");
	foreach(var_03 in var_01)
	{
		if(maps\_utility::string_is_single_digit_integer(var_03))
		{
			return int(var_03);
		}
	}
}

//Function Number: 63
ups_to_mph(param_00)
{
	return param_00 / 63360 * 60 * 60;
}

//Function Number: 64
mph_to_ups(param_00)
{
	return param_00 * 63360 / 60 / 60;
}

//Function Number: 65
vehicle_chase_target(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self notify("one_vehicle_chase_target");
	self endon("one_vehicle_chase_target");
	level endon("stop_all_chase_vehicles");
	self endon("stop_chase_target");
	self endon("death");
	self.oscillate_speed = 0;
	if(param_03 >= 0 && param_04 > 0)
	{
		thread vehicle_oscillate_location(param_03,param_04);
	}

	for(;;)
	{
		var_0A = param_00 vehicle_getspeed();
		var_0B = vectornormalize(anglestoforward(param_00.angles));
		var_0C = self.origin - param_00.origin;
		var_0D = vectordot(var_0B,var_0C) * var_0B;
		var_0E = length(var_0D);
		var_0F = vectornormalize(var_0C);
		var_10 = vectordot(var_0B,var_0F);
		if(var_10 < 0)
		{
			if(param_05)
			{
				var_0A = var_0A * 1.5;
			}
			else if(var_0E < param_01)
			{
				var_0A = var_0A * 0.8;
			}
			else if(var_0E > param_02 * 1.5)
			{
				var_0A = var_0A * 1.35;
			}
			else if(var_0E > param_02 * 1.2)
			{
				var_0A = var_0A * 1.2;
			}
			else if(var_0E > param_02)
			{
				var_0A = var_0A * 1.1;
			}
			else
			{
				var_0A = var_0A + self.oscillate_speed;
			}
		}
		else if(param_06)
		{
			var_0A = var_0A * 0.5;
		}
		else if(var_0E < param_01)
		{
			var_0A = var_0A * 1.2;
		}
		else if(var_0E > param_02 * 1.5)
		{
			var_0A = var_0A * 0.7;
		}
		else if(var_0E > param_02 * 1.2)
		{
			var_0A = var_0A * 0.85;
		}
		else if(var_0E > param_02)
		{
			var_0A = var_0A * 0.95;
		}
		else
		{
			var_0A = var_0A + self.oscillate_speed;
		}

		if(param_07 && isdefined(level.player.drivingvehicle))
		{
			if(vectordot(level.player.drivingvehicle.origin - self.origin,anglestoforward(self.angles)) > 0)
			{
				var_11 = time_and_distance_of_closest_approach(self.origin,self vehicle_getvelocity(),level.player.drivingvehicle.origin,level.player.drivingvehicle vehicle_getvelocity(),0.1,234,0);
				var_12 = var_11[0];
				var_13 = var_11[1];
				if(var_12 < 2 && var_13 < 234)
				{
					var_0A = level.player.drivingvehicle vehicle_getspeed() * 0.6;
				}
			}
		}

		if(param_08)
		{
			var_0A = clamp(var_0A,0,200);
		}
		else if(isdefined(param_09))
		{
			var_0A = clamp(var_0A,param_09,200);
		}
		else
		{
			var_0A = clamp(var_0A,20,200);
		}

		self vehicle_setspeed(var_0A,100,100);
		wait(0.05);
	}
}

//Function Number: 66
vehicle_oscillate_location(param_00,param_01)
{
	self notify("one_vehicle_oscillate_location");
	self endon("one_vehicle_oscillate_location");
	level endon("stop_all_chase_vehicles");
	self endon("stop_chase_target");
	self endon("death");
	var_02 = gettime();
	param_01 = param_01 * 1000;
	for(;;)
	{
		var_03 = gettime() - var_02;
		var_04 = var_03 % param_01;
		var_04 = var_04 / param_01;
		var_04 = var_04 * 365;
		var_05 = param_00 * sin(var_04);
		self.oscillate_speed = var_05;
		wait(0.05);
	}
}

//Function Number: 67
time_and_distance_of_closest_approach(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = 0.05;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_07 = param_00 - param_02;
	var_08 = param_01 - param_03;
	var_09 = lengthsquared(var_08);
	var_0A = 2 * vectordot(var_07,var_08);
	var_0B = lengthsquared(var_07) - squared(param_05);
	var_0C = squared(var_0A) - 4 * var_09 * var_0B;
	var_0D = 0;
	if(var_0C > 0 && var_09 > 0)
	{
		var_0E = -0.5 * var_0A + common_scripts\utility::sign(var_0A) * sqrt(var_0C);
		var_0F = min(var_0E / var_09,var_0B / var_0E);
	}
	else if(var_0A > 0)
	{
		var_0F = var_0B / -2 * var_0A;
	}
	else
	{
		var_0F = param_05;
	}

	if(var_0F < param_04)
	{
		var_0F = param_04;
	}

	var_10 = distance(param_00 + param_01 * var_0F,param_02 + param_03 * var_0F);
	return [var_0F,var_10];
}

//Function Number: 68
get_ent_by_targetname(param_00)
{
	return getent(param_00,"targetname");
}

//Function Number: 69
get_ents_by_targetname(param_00)
{
	return getentarray(param_00,"targetname");
}

//Function Number: 70
get_ent_by_target(param_00)
{
	return getent(param_00,"target");
}

//Function Number: 71
get_ents_by_target(param_00)
{
	return getentarray(param_00,"target");
}

//Function Number: 72
get_ents_by_noteworthy(param_00)
{
	return getentarray(param_00,"script_noteworthy");
}

//Function Number: 73
get_vehnode_by_targetname(param_00)
{
	return getvehiclenode(param_00,"targetname");
}

//Function Number: 74
get_vehnodes_by_targetname(param_00)
{
	return getvehiclenodearray(param_00,"targetname");
}

//Function Number: 75
wait_for_trigger_and_ai_single(param_00,param_01)
{
	var_02[0] = param_01;
	wait_for_trigger_with_group_touching(param_00,1,var_02);
}

//Function Number: 76
wait_for_trigger_just_ai_single(param_00,param_01)
{
	var_02[0] = param_01;
	wait_for_trigger_with_group_touching(param_00,0,var_02);
}

//Function Number: 77
wait_for_trigger_and_ai_group(param_00,param_01)
{
	wait_for_trigger_with_group_touching(param_00,1,param_01);
}

//Function Number: 78
wait_for_trigger_just_ai_group(param_00,param_01)
{
	wait_for_trigger_with_group_touching(param_00,0,param_01);
}

//Function Number: 79
wait_for_trigger_with_group_touching(param_00,param_01,param_02)
{
	var_03 = get_ent_by_targetname(param_00);
	for(;;)
	{
		if(param_01)
		{
			var_03 waittill("trigger");
		}

		var_04 = 1;
		foreach(var_06 in param_02)
		{
			if(!var_06 istouching(var_03))
			{
				var_04 = 0;
			}
		}

		if(var_04)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 80
wait_for_no_trigger_and_ai_single(param_00,param_01)
{
	var_02[0] = param_01;
	wait_for_trigger_with_group_not_touching(param_00,1,var_02);
}

//Function Number: 81
wait_for_no_trigger_just_ai_single(param_00,param_01)
{
	var_02[0] = param_01;
	wait_for_trigger_with_group_not_touching(param_00,0,var_02);
}

//Function Number: 82
wait_for_no_trigger_and_ai_group(param_00,param_01)
{
	wait_for_trigger_with_group_not_touching(param_00,1,param_01);
}

//Function Number: 83
wait_for_no_trigger_just_ai_group(param_00,param_01)
{
	wait_for_trigger_with_group_not_touching(param_00,0,param_01);
}

//Function Number: 84
wait_for_trigger_with_group_not_touching(param_00,param_01,param_02)
{
	var_03 = get_ent_by_targetname(param_00);
	for(;;)
	{
		var_04 = 1;
		if(param_01 && level.player istouching(var_03))
		{
			var_04 = 0;
		}

		foreach(var_06 in param_02)
		{
			if(var_06 istouching(var_03))
			{
				var_04 = 0;
			}
		}

		if(var_04)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 85
drone_swarm_move_change_path_on_trigger(param_00)
{
	self waittill("trigger");
	if(isdefined(self.script_wait))
	{
		wait(self.script_wait);
	}

	var_01 = common_scripts\utility::getstruct(self.target,"targetname");
	var_02 = var_01.script_noteworthy;
	var_03 = 3;
	if(isdefined(var_01.script_delay))
	{
		var_03 = var_01.script_delay;
	}

	if(!isdefined(param_00) || param_00 == 0)
	{
		level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_teleport_to_point(var_01);
	}

	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_02,undefined,var_03);
}

//Function Number: 86
drone_swarm_start_kamikaze_attack(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_04))
	{
		level.override_min_wave_delay = 7;
	}
	else
	{
		level.override_min_wave_delay = param_04;
	}

	if(!isdefined(param_05))
	{
		level.override_max_wave_delay = 10;
	}
	else
	{
		level.override_max_wave_delay = param_05;
	}

	if(!isdefined(param_06))
	{
		level.override_max_wave_spawns = 2;
	}
	else
	{
		level.override_max_wave_spawns = param_06;
	}

	if(!isdefined(param_07))
	{
		level.override_kamikaze_range = 512;
	}
	else
	{
		level.override_kamikaze_range = param_07;
	}

	if(isdefined(param_01))
	{
		level waittill(param_01);
	}

	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	level endon("drone_swarm_stop_kamikaze_attack");
	for(;;)
	{
		level.snake_cloud.snakes = maps\_shg_design_tools::sortbydistanceauto(level.snake_cloud.snakes,level.player.origin);
		var_08 = randomint(level.override_max_wave_spawns);
		var_09 = 0;
		for(var_0A = 0;var_09 < var_08 && var_0A < level.snake_cloud.snakes.size;var_0A++)
		{
			if(level.player player_can_see_point(level.snake_cloud.snakes[var_0A].origin))
			{
				continue;
			}

			if(level.snake_cloud.snakes[var_0A] drone_swarm_kamikaze_attack_player(param_00,param_03))
			{
				var_09++;
			}

			wait(randomfloatrange(0.1,0.25));
		}

		if(isdefined(param_03))
		{
			foreach(var_0C in param_03)
			{
				var_0C.claimed = undefined;
			}
		}

		wait(randomfloatrange(level.override_min_wave_delay,level.override_max_wave_delay));
	}
}

//Function Number: 87
drone_swarm_kamikaze_set_attack_vars(param_00,param_01,param_02,param_03)
{
	waittillframeend;
	if(isdefined(param_00))
	{
		level.override_min_wave_delay = param_00;
	}

	if(isdefined(param_01))
	{
		level.override_max_wave_delay = param_01;
	}

	if(isdefined(param_02))
	{
		level.override_max_wave_spawns = param_02;
	}

	if(isdefined(param_03))
	{
		level.override_kamikaze_range = param_03;
	}
}

//Function Number: 88
drone_swarm_kamikaze_attack_player(param_00,param_01)
{
	var_02 = level.player geteye();
	var_03 = self gettagorigin("tag_origin");
	if(!isdefined(level.swarm_last_player_pos))
	{
		level.swarm_last_player_pos = var_02;
	}

	if(sighttracepassed(var_03,var_02,0,self))
	{
		level.swarm_last_player_pos = var_02;
		param_00.count = 1;
		var_04 = param_00 maps\_utility::spawn_vehicle();
		if(!isdefined(var_04) || !var_04 maps\_vehicle::isvehicle())
		{
			return 0;
		}

		var_04 vehicle_teleport(self.origin,self.angles);
		var_04 vehicle_setspeed(20,20,20);
		var_05 = undefined;
		if(isdefined(param_01))
		{
			foreach(var_07 in param_01)
			{
				if(!isdefined(var_07.claimed) && distance(var_07.origin,level.player.origin) < level.override_kamikaze_range)
				{
					var_07.claimed = 1;
					var_05 = var_07;
					break;
				}
			}
		}

		var_04 thread drone_swarm_kamikaze_seek_player(var_05);
		return 1;
	}

	return 0;
}

//Function Number: 89
drone_swarm_kamikaze_seek_player(param_00)
{
	self endon("death");
	var_01 = undefined;
	for(;;)
	{
		if(isdefined(param_00))
		{
			var_01 = param_00.origin;
		}
		else
		{
			var_02 = anglestoforward(level.player getplayerangles());
			var_03 = level.player geteye() + 30 * var_02;
			var_04 = self gettagorigin("tag_origin");
			var_05 = vectornormalize(var_03 - var_04);
			var_06 = var_04 + var_05 * 20;
			var_01 = level.swarm_last_player_pos;
			if(sighttracepassed(var_06,var_03,0,undefined))
			{
				var_01 = var_03;
			}
		}

		drone_swarm_kamikaze_set_goal(var_01);
		if(distance(self.origin,var_01) < 45)
		{
			thread drone_swarm_kamikaze_explode();
		}

		wait(0.05);
	}
}

//Function Number: 90
drone_swarm_kamikaze_set_goal(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!maps\_vehicle::isvehicle())
	{
		return;
	}

	self setvehgoalpos(param_00);
}

//Function Number: 91
drone_swarm_kamikaze_explode()
{
	var_00 = 15;
	var_01 = 10;
	var_02 = self.origin;
	var_03 = self.angles;
	if(randomint(100) < 5)
	{
		playfx(common_scripts\utility::getfx("drone_sparks"),var_02);
	}

	self radiusdamage(var_02,130,var_00,var_01,self);
	earthquake(randomfloatrange(0.25,1),0.5,level.player.origin,32);
	var_04 = spawn("script_model",var_02);
	var_04 setmodel("vehicle_mil_attack_drone_destroy");
	var_04.angles = var_03;
	playfxontag(level._effect["swarm_death_explosion"],self,"tag_origin");
	soundscripts\_snd::snd_message("pdrone_death_explode");
	self kill();
	wait 0.05;
	var_05 = var_04.origin + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)) - level.player geteye();
	var_06 = randomintrange(50,80);
	var_04 physicslaunchserver(var_04.origin + (randomintrange(-15,15),randomintrange(-15,15),randomintrange(-15,15)),var_05 * var_06);
	if(randomint(100) < 5)
	{
		playfxontag(common_scripts\utility::getfx("drone_smoke"),var_04,"tag_origin");
	}

	wait(15);
	var_04 delete();
}

//Function Number: 92
start_fire_suppression_group(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_01);
	level thread maps\betrayal_fx::escape_sprinklers_off();
}

//Function Number: 93
warbird_toggle_turret_off_after_deploy()
{
	self endon("death");
	self waittill("unloaded");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 94
warbird_shooting_think(param_00,param_01,param_02)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	if(isdefined(param_01) && param_01 == 1)
	{
		maps\_utility::ent_flag_set("fire_turrets");
	}

	for(;;)
	{
		maps\_utility::ent_flag_wait("fire_turrets");
		thread warbird_fire_init(param_00,param_02);
		maps\_utility::ent_flag_waitopen("fire_turrets");
	}
}

//Function Number: 95
warbird_fire_init(param_00,param_01)
{
	self endon("death");
	var_02 = self.mgturret[0];
	var_03 = self.mgturret[1];
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}
	else
	{
		var_04 = 3;
	}

	while(maps\_utility::ent_flag("fire_turrets"))
	{
		if(isdefined(self.sight_check))
		{
			param_00 = self.sight_check;
		}

		if(!isdefined(self.turret_target_override))
		{
			var_05 = getaiarray("allies");
			if(!maps\_utility::ent_flag_exist("dont_shoot_player") || !maps\_utility::ent_flag("dont_shoot_player"))
			{
				var_06 = 33;
				if(randomint(100) <= var_06)
				{
					var_05 = common_scripts\utility::array_add(var_05,level.player);
				}
			}

			var_07 = [];
			foreach(var_09 in var_05)
			{
				if(isdefined(var_09.ignoreme) && var_09.ignoreme)
				{
					continue;
				}
				else
				{
					var_07[var_07.size] = var_09;
				}
			}

			var_07 = sortbydistance(var_07,self.origin);
			var_0B = undefined;
			foreach(var_09 in var_07)
			{
				if(!isdefined(var_09))
				{
					continue;
				}

				if(!isalive(var_09))
				{
					continue;
				}

				if(isdefined(param_00) && param_00)
				{
					var_0D = self.mgturret[0] gettagorigin("tag_flash");
					var_0E = var_09 geteye();
					var_0F = vectornormalize(var_0E - var_0D);
					var_10 = var_0E + var_0F * 20;
					if(!sighttracepassed(var_10,var_0E,0,var_09,self.mgturret[0]))
					{
						continue;
					}
				}

				var_0B = var_09;
				break;
			}
		}
		else
		{
			var_0B = self.turret_target_override;
		}

		if(isdefined(var_0B))
		{
			var_02 settargetentity(var_0B);
			var_03 settargetentity(var_0B);
			var_02 turretfireenable();
			var_03 turretfireenable();
			var_02 startfiring();
			var_03 startfiring();
			warbird_wait_for_fire_target_done(var_0B,param_00);
			var_02 cleartargetentity();
			var_03 cleartargetentity();
			var_02 turretfiredisable();
			var_03 turretfiredisable();
		}

		wait(var_04);
	}

	var_02 turretfiredisable();
	var_03 turretfiredisable();
}

//Function Number: 96
warbird_wait_for_fire_target_done(param_00,param_01)
{
	param_00 endon("death");
	if(!maps\_utility::ent_flag("fire_turrets"))
	{
		return;
	}

	self endon("fire_turrets");
	if(param_00 == level.player)
	{
		var_02 = 0.6;
	}
	else
	{
		var_02 = 3;
	}

	var_03 = 0;
	while(var_03 < var_02)
	{
		if(isdefined(param_01) && param_01)
		{
			var_04 = self.mgturret[0] gettagorigin("tag_flash");
			var_05 = param_00 geteye();
			var_06 = vectornormalize(var_05 - var_04);
			var_07 = var_04 + var_06 * 20;
			if(!sighttracepassed(var_07,var_05,0,param_00,self.mgturret[0]))
			{
				return;
			}
		}

		var_03 = var_03 + 0.3;
		wait(0.3);
	}
}

//Function Number: 97
warbird_get_passengers()
{
	var_00 = self.riders;
	return var_00;
}

//Function Number: 98
warbird_ignore_until_unloaded()
{
	foreach(var_01 in self)
	{
		var_01.ignoreme = 1;
		var_01 thread warbird_wait_until_unloaded();
	}
}

//Function Number: 99
warbird_wait_until_unloaded()
{
	self endon("death");
	self waittill("jumpedout");
	self.ignoreme = 0;
	self notify("take_cover");
}

//Function Number: 100
warbird_unload_listener()
{
	var_00 = self.riders;
	self waittill("finish");
	foreach(var_02 in var_00)
	{
		var_02 notify("zipline_finish");
	}
}

//Function Number: 101
ally_redirect_goto_node(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = undefined;
	foreach(var_0A in level.alpha_squad)
	{
		if(isdefined(var_0A.script_friendname) && var_0A.script_friendname == param_00)
		{
			var_08 = var_0A;
		}
	}

	var_0C = getnode(param_01,"targetname");
	var_08 maps\_utility::enable_ai_color();
	var_08 maps\_utility::set_goal_node(var_0C);
	if(isdefined(param_03))
	{
		var_08 thread exec_function(param_02,param_03,param_04,param_05,param_06,param_07);
	}
}

//Function Number: 102
exec_function(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	if(isdefined(param_05))
	{
		var_06 = 4;
	}
	else if(isdefined(param_04))
	{
		var_06 = 3;
	}
	else if(isdefined(param_03))
	{
		var_06 = 2;
	}
	else if(isdefined(param_02))
	{
		var_06 = 1;
	}

	if(param_00 == 1)
	{
		switch(var_06)
		{
			case 0:
				thread [[ param_01 ]]();
				break;

			case 1:
				thread [[ param_01 ]](param_02);
				break;

			case 2:
				thread [[ param_01 ]](param_02,param_03);
				break;

			case 3:
				thread [[ param_01 ]](param_02,param_03,param_04);
				break;

			case 4:
				thread [[ param_01 ]](param_02,param_03,param_04,param_05);
				break;
		}

		return;
	}

	switch(var_06)
	{
		case 0:
			[[ param_01 ]]();
			break;

		case 1:
			[[ param_01 ]](param_02);
			break;

		case 2:
			[[ param_01 ]](param_02,param_03);
			break;

		case 3:
			[[ param_01 ]](param_02,param_03,param_04);
			break;

		case 4:
			[[ param_01 ]](param_02,param_03,param_04,param_05);
			break;
	}
}

//Function Number: 103
assign_goal_vol(param_00,param_01)
{
	if(isdefined(self))
	{
		var_02 = getent(param_00,"targetname");
		self setgoalvolumeauto(var_02);
		if(isdefined(param_01))
		{
			self.goalradius = param_01;
		}
	}
}

//Function Number: 104
assign_goal_node(param_00,param_01)
{
	if(isdefined(self))
	{
		var_02 = getnode(param_00,"targetname");
		self setgoalnode(var_02);
		if(isdefined(param_01))
		{
			self.goalradius = param_01;
		}
	}
}

//Function Number: 105
setupenemygoalvolumesettings(param_00,param_01)
{
	param_00 = common_scripts\utility::array_randomize(param_00);
	if(level.player istouching(param_00[0]))
	{
		self setgoalvolumeauto(param_00[1]);
		wait 0.05;
		if(isdefined(param_01))
		{
			self.goalradius = param_01;
			return;
		}

		return;
	}

	self setgoalvolumeauto(param_00[0]);
	wait 0.05;
	if(isdefined(param_01))
	{
		self.goalradius = param_01;
	}
}

//Function Number: 106
ally_move_dynamic_speed()
{
	self notify("start_dynamic_run_speed");
	self endon("death");
	self endon("stop_dynamic_run_speed");
	self endon("start_dynamic_run_speed");
	if(maps\_utility::ent_flag_exist("_stealth_custom_anim"))
	{
		maps\_utility::ent_flag_waitopen("_stealth_custom_anim");
	}

	self.run_speed_state = "";
	ally_reset_dynamic_speed();
	var_00 = 144;
	var_01 = ["sprint","run"];
	var_02 = [];
	var_02["player_sprint"]["sprint"][0] = 225 * var_00;
	var_02["player_sprint"]["sprint"][1] = 900 * var_00;
	var_02["player_sprint"]["run"][0] = 900 * var_00;
	var_02["player_sprint"]["run"][1] = 900 * var_00;
	var_02["player_run"]["sprint"][0] = 225 * var_00;
	var_02["player_run"]["sprint"][1] = 400 * var_00;
	var_02["player_run"]["run"][0] = 400 * var_00;
	var_02["player_run"]["run"][1] = 625 * var_00;
	var_02["player_crouch"]["run"][0] = 4 * var_00;
	var_02["player_crouch"]["run"][1] = 100 * var_00;
	var_03 = 123;
	var_04 = 189;
	var_05 = 283;
	for(;;)
	{
		wait(0.2);
		if(isdefined(self.force_run_speed_state))
		{
			ally_dynamic_run_set(self.force_run_speed_state);
			continue;
		}

		var_06 = vectornormalize(anglestoforward(self.angles));
		var_07 = vectornormalize(self.origin - level.player.origin);
		var_08 = vectordot(var_06,var_07);
		var_09 = distancesquared(self.origin,level.player.origin);
		if(isdefined(self.cqbwalking) && self.cqbwalking)
		{
			self.moveplaybackrate = 1;
		}

		if(common_scripts\utility::flag_exist("_stealth_spotted") && common_scripts\utility::flag("_stealth_spotted"))
		{
			ally_dynamic_run_set("run");
			continue;
		}

		if(var_08 < -0.25 && var_09 > 225 * var_00)
		{
			ally_dynamic_run_set("sprint");
			continue;
		}

		ally_dynamic_run_set("cqb");
	}
}

//Function Number: 107
ally_stop_dynamic_speed()
{
	self endon("death");
	self notify("stop_dynamic_run_speed");
	ally_reset_dynamic_speed();
}

//Function Number: 108
ally_reset_dynamic_speed()
{
	self endon("death");
	maps\_utility::disable_cqbwalk();
	self.moveplaybackrate = 1;
	maps\_utility::clear_run_anim();
	self notify("stop_loop");
}

//Function Number: 109
ally_dynamic_run_set(param_00)
{
	if(self.run_speed_state == param_00)
	{
		return;
	}

	self.run_speed_state = param_00;
	switch(param_00)
	{
		case "sprint":
			if(isdefined(self.cqbwalking) && self.cqbwalking)
			{
				self.moveplaybackrate = 1;
			}
			else
			{
				self.moveplaybackrate = 1;
			}
	
			maps\_utility::set_generic_run_anim("DRS_sprint");
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "run":
			self.moveplaybackrate = 1;
			maps\_utility::clear_run_anim();
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "jog":
			self.moveplaybackrate = 1;
			maps\_utility::set_generic_run_anim("DRS_combat_jog");
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "cqb":
			self.moveplaybackrate = 1;
			maps\_utility::enable_cqbwalk();
			self notify("stop_loop");
			break;
	}
}

//Function Number: 110
fake_linkto_internal(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_00 endon("death");
	self notify("fake_unlink");
	self endon("fake_unlink");
	if(!isdefined(param_02) || !isdefined(param_03))
	{
		if(isdefined(param_01))
		{
			var_04 = param_00 gettagorigin(param_01);
			var_05 = param_00 gettagangles(param_01);
		}
		else
		{
			var_04 = param_02.origin;
			var_05 = param_01.angles;
		}

		var_06 = transformmove((0,0,0),(0,0,0),var_04,var_05,self.origin,self.angles);
		param_02 = var_06["origin"];
		param_03 = var_06["angles"];
	}

	for(;;)
	{
		if(isdefined(param_01))
		{
			var_04 = param_00 gettagorigin(param_01);
			var_05 = param_00 gettagangles(param_01);
		}
		else
		{
			var_04 = param_00.origin;
			var_05 = param_00.angles;
		}

		var_06 = transformmove(var_04,var_05,(0,0,0),(0,0,0),param_02,param_03);
		self.origin = var_06["origin"];
		self.angles = var_06["angles"];
		wait 0.05;
	}
}

//Function Number: 111
fake_unlink()
{
	self notify("fake_unlink");
}

//Function Number: 112
civilian_setup(param_00,param_01,param_02)
{
	self waittill("trigger");
	var_03 = getent(self.script_linkto,"script_linkname");
	var_04 = getentarray(self.target,"targetname");
	var_05 = [];
	var_06 = [];
	var_07 = [];
	foreach(var_09 in var_04)
	{
		if(isdefined(var_09.script_noteworthy) && var_09.script_noteworthy == "ai_spawner")
		{
			var_05 = common_scripts\utility::getstructarray(var_09.target,"targetname");
			foreach(var_0B in var_05)
			{
				var_0C = var_0B civilian_spawn_single(var_09,"ai",param_01);
				var_09.count = 1;
				var_07 = common_scripts\utility::array_add(var_07,var_0C);
				wait 0.05;
				var_0C thread civilian_actor_behavior_manager(param_00,1,var_0B);
			}

			continue;
		}

		var_05 = common_scripts\utility::getstructarray(var_09.target,"targetname");
		foreach(var_0B in var_05)
		{
			var_0C = var_0B civilian_spawn_single(var_09,"drone",param_01);
			var_0C thread civilian_actor_behavior_manager(param_00,0);
			var_06 = common_scripts\utility::array_add(var_06,var_0C);
		}
	}

	if(!isdefined(param_02) || param_02)
	{
		civilian_setup_esc_nodes(var_07);
	}

	var_03 waittill("trigger");
	foreach(var_12 in var_07)
	{
		civilian_cleanup(var_12);
	}

	foreach(var_12 in var_06)
	{
		civilian_cleanup(var_12);
	}
}

//Function Number: 113
civilian_spawn_single(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = undefined;
	param_00.target = self.target;
	param_00.script_moveoverride = 1;
	if(param_01 == "ai")
	{
		var_03 = param_00 maps\_utility::spawn_ai(1);
		param_00.count = 1;
		var_03.ignoreme = 1;
		var_03.ignoreall = 1;
		var_03 maps\_utility::disable_pain();
		var_03 forceteleport(self.origin,self.angles);
	}
	else
	{
		var_03 = param_00 maps\_utility::dronespawn();
		var_03.origin = self.origin;
		var_03.angles = self.angles;
	}

	param_00.script_moveoverride = undefined;
	var_03 civilian_detach_props();
	var_03.script_parameters = self.script_parameters;
	var_03.script_linkto = self.script_linkto;
	var_03.animation = self.animation;
	var_03.script_noteworthy = self.script_noteworthy;
	var_03.script_nodestate = self.script_nodestate;
	var_03.script_squadname = self.script_squadname;
	var_03.health = 20;
	if(isdefined(self.civilian_walk_animation))
	{
		var_03.civilian_walk_animation = self.civilian_walk_animation;
	}

	if(isdefined(param_02) && param_02)
	{
		var_03.no_friendly_fire_penalty = 1;
	}

	return var_03;
}

//Function Number: 114
civilian_init_props()
{
	if(isdefined(level.civilianprops))
	{
		return;
	}

	anim.civilianprops = [];
	level.civilianprops["civilian_texting_standing"] = "electronics_pda";
	level.civilianprops["civilian_texting_sitting"] = "electronics_pda";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
	level.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
	level.civilianprops["civilian_smoking_A"] = "prop_cigarette";
	level.civilianprops["civilian_smoking_B"] = "prop_cigarette";
	level.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
	level.civilianprops["oilrig_balcony_smoke_idle"] = "prop_cigarette";
	level.civilianprops["guardB_sit_drinker_idle"] = "cs_coffeemug02";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
	level.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
	level.civilianprops["civilian_reader_1"] = "lab_tablet_flat_on";
	level.civilianprops["civilian_reader_2"] = "lab_tablet_flat_on";
	level.civilianprops["civilian_briefcase_walk"] = "com_metal_briefcase";
	level.civilianprops["civilian_crazy_walk"] = "electronics_pda";
	level.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
	level.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
	level.civilianprops["civilian_paper_walk"] = "paper_memo";
	level.civilianprops["civilian_coffee_walk"] = "cs_coffeemug02";
	level.civilianprops["civilian_pda_walk"] = "electronics_pda";
	level.civilianprops["civilian_crowd_walk_stand_idle"] = "electronics_pda";
	level.civilianprops["civilian_crowd_walk_stand"] = "electronics_pda";
	level.civilianprops["civilian_walk_nervous"] = "electronics_pda";
	level.civilianprops["civilian_walk_pda"] = "electronics_pda";
}

//Function Number: 115
civilian_attach_props(param_00)
{
	if(isdefined(self.hasattachedprops))
	{
		return;
	}

	civilian_init_props();
	var_01 = level.civilianprops[param_00];
	if(isdefined(var_01))
	{
		self.attachedpropmodel = var_01;
		self.attachedproptag = "tag_inhand";
		if(issubstr(self.attachedpropmodel,"electronics_pda"))
		{
			wait(0.25);
		}

		var_02 = self attach(self.attachedpropmodel,self.attachedproptag,1);
		self.hasattachedprops = 1;
		return var_01;
	}
}

//Function Number: 116
civilian_setup_esc_nodes(param_00)
{
	if(!isdefined(level.esc_node_locations))
	{
		level.esc_node_locations = getnodearray("ai_esc_node","targetname");
	}

	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.target))
		{
			if(level.esc_node_locations.size > 0)
			{
				foreach(var_05 in level.esc_node_locations)
				{
					var_06 = distance(var_05.origin,self.origin);
					if(!isdefined(var_05) || var_05.targetname != "ai_esc_node")
					{
						level.esc_node_locations = common_scripts\utility::array_remove(level.esc_node_locations,var_05);
					}
				}

				level.esc_node_locations = sortbydistance(level.esc_node_locations,var_03.origin);
				var_01 = level.esc_node_locations[0];
				level.esc_node_locations = common_scripts\utility::array_remove(level.esc_node_locations,level.esc_node_locations[0]);
				var_03 setgoalnode(var_01);
				if(isdefined(var_01.target))
				{
					var_03 thread civilian_actor_ai_player_reaction(var_01);
				}
			}
			else
			{
			}

			continue;
		}

		var_01 = getnode(var_03.target,"targetname");
		var_08 = undefined;
		if(isdefined(var_01) && isdefined(var_01.target))
		{
			var_08 = getent(var_01.target,"targetname");
			if(isdefined(var_08) && isdefined(var_08.angles))
			{
				var_03.final_animation_angles = var_08.angles;
				var_03.final_animation_origin = var_08.origin;
			}
		}

		var_03 setgoalnode(var_01);
	}
}

//Function Number: 117
filter_nodes(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.targetname) && var_04.targetname == param_01)
		{
			var_02 = common_scripts\utility::array_add(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 118
civilian_actor_behavior_manager(param_00,param_01,param_02)
{
	level.player endon("death");
	self endon("death");
	if(isdefined(param_02) && isdefined(param_02.animation) && issubstr(param_02.animation,"_sit_"))
	{
		thread civilian_actor_play_idle(undefined,param_02);
	}
	else
	{
		thread civilian_actor_play_idle();
	}

	thread civilian_wait_for_reaction(param_00);
	self waittill("reacting");
	if(param_01)
	{
		self setlookatentity(level.player);
		self setlookatentity();
	}

	thread civilian_actor_play_reaction(param_01);
}

//Function Number: 119
civilian_wait_for_reaction(param_00)
{
	if(isstring(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}
	else if(isdefined(param_00))
	{
		maps\_utility::waittill_entity_in_range(level.player,param_00);
	}
	else
	{
	}

	wait 0.05;
	self notify("reacting");
}

//Function Number: 120
civilian_watch_player_when_close()
{
	self endon("death");
	level.player endon("death");
	self endon("reacting");
	var_00 = 0;
	for(;;)
	{
		var_00 = distance(self.origin,level.player.origin);
		if(var_00 <= 100)
		{
			self setlookatentity(level.player);
		}
		else
		{
			self stoplookat();
		}

		wait(0.5);
	}
}

//Function Number: 121
civilian_actor_play_idle(param_00,param_01)
{
	self notify("new_idle_spot");
	self endon("new_idle_spot");
	self endon("death");
	if(isdefined(self.attachedpropmodel))
	{
		civilian_detach_props();
	}

	stop_current_animations();
	self.animname = "generic";
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}
	else if(isdefined(self.animation))
	{
		var_02 = self.animation;
	}
	else
	{
		var_02 = civilian_get_random_idle();
	}

	self.animation = var_02;
	if(!isdefined(param_01))
	{
		thread maps\_anim::anim_generic_loop(self,var_02);
	}
	else
	{
		param_01 maps\_anim::anim_generic_loop(self,var_02);
	}

	var_03 = civilian_attach_props(var_02);
	self waittill("reacting");
	if(isdefined(var_03))
	{
		civilian_detach_props();
	}
}

//Function Number: 122
civilian_actor_play_reaction(param_00)
{
	self endon("death");
	level.player endon("death");
	wait(randomfloatrange(0,0.25));
	self.animname = "civilian_react";
	var_01 = civilian_get_random_reaction();
	if(isdefined(self.script_noteworthy))
	{
		stop_current_animations();
		var_01 = self.script_noteworthy;
		maps\_anim::anim_single_solo_run(self,var_01);
	}

	if(isdefined(self.target) || isdefined(self.goalpos))
	{
		self.goalradius = 16;
		stop_current_animations();
		self.animname = "generic";
		if(!param_00 && isdefined(self.civilian_walk_animation))
		{
			var_01 = self.civilian_walk_animation;
		}
		else
		{
			var_01 = civilian_get_random_run();
		}

		self.runanim = level.scr_anim[self.animname][var_01][0];
		maps\_utility::set_run_anim_array(var_01,undefined,1);
		self notify("move");
		self waittill("goal");
		stop_current_animations();
		self.animname = "civilian_react";
		var_01 = civilian_get_random_reaction();
	}
	else if(!isdefined(self.script_parameters))
	{
		var_01 = civilian_get_random_reaction();
	}

	if(isdefined(self.script_parameters))
	{
		if(isdefined(self.final_animation_angles) && isdefined(self.final_animation_origin) && isdefined(self.script_nodestate))
		{
			self forceteleport(self.final_animation_origin,self.final_animation_angles);
		}

		stop_current_animations();
		self.animname = "generic";
		var_01 = self.script_parameters;
		thread maps\_anim::anim_generic_loop(self,var_01);
	}
	else
	{
		if(isdefined(self.final_animation_angles) && isdefined(self.script_nodestate))
		{
			self forceteleport(self.origin,self.final_animation_angles);
		}

		if(isdefined(self.final_animation_origin) && isdefined(self.script_nodestate))
		{
			self forceteleport(self.final_animation_origin,self.angles);
		}

		stop_current_animations();
		thread maps\_anim::anim_loop([self],var_01);
	}

	self notify("done_reacting");
}

//Function Number: 123
civilian_actor_ai_player_reaction(param_00)
{
	self endon("death");
	var_01 = getnode(param_00.target,"targetname");
	var_02 = var_01.script_noteworthy;
	common_scripts\utility::flag_wait(var_02);
	stop_current_animations();
	wait 0.05;
	self setgoalnode(var_01);
	self waittill("goal");
	self waittill("done_reacting");
	stop_current_animations();
	var_01 thread maps\_anim::anim_loop_solo(self,"civ_react_cower_crouch_to_crouch_2","stop_loop");
}

//Function Number: 124
civilian_actor_drone_player_reaction()
{
}

//Function Number: 125
civilian_get_random_reaction()
{
	self endon("death");
	var_00 = [];
	var_00[0] = "civ_react_cower_crouch_to_crouch";
	var_00[1] = "civ_react_crouch_idle";
	var_00[2] = "civ_react_cower_hunch_to_hunch";
	var_00[3] = "civ_react_cower_crouch_to_crouch_2";
	var_00[4] = "civ_react_cower_crouch_to_crouch_3";
	var_00[5] = "bet_civilians_cowering_idle_01";
	var_00[6] = "bet_civilians_cowering_idle_02";
	var_00[7] = "bet_civilians_cowering_idle_03";
	var_00[8] = "bet_civilians_cowering_idle_04";
	var_00[9] = "bet_civilians_cowering_idle_05";
	var_00[10] = "bet_civilians_cowering_idle_06";
	var_01 = randomintrange(0,var_00.size);
	return var_00[var_01];
}

//Function Number: 126
civilian_get_random_idle()
{
	self endon("death");
	var_00 = [];
	var_00[0] = "civilian_stand_idle2";
	var_00[1] = "civilian_stand_idle4";
	var_00[2] = "civilian_stand_idle5";
	var_00[3] = "civilian_stand_idle6";
	var_00[4] = "civilian_stand_idle7";
	var_00[5] = "civilian_stand_idle8";
	var_00[6] = "civilian_stand_idle9";
	if(issubstr(self.model,"female"))
	{
	}
	else if(issubstr(self.model,"male"))
	{
		var_00[7] = "civilian_stand_idle_male1";
	}

	var_01 = randomintrange(0,var_00.size);
	return var_00[var_01];
}

//Function Number: 127
civilian_get_random_run()
{
	self endon("death");
	var_00 = [];
	var_00[0] = "civ_run_hunch1";
	var_00[1] = "civ_run_stand1";
	if(issubstr(self.model,"female"))
	{
	}
	else if(issubstr(self.model,"male"))
	{
		var_00[2] = "civilian_run1_male";
		var_00[3] = "civilian_run2_male";
		var_00[4] = "civilian_run3_male";
	}

	var_01 = randomintrange(0,var_00.size);
	return var_00[var_01];
}

//Function Number: 128
civilian_get_random_walk()
{
	self endon("death");
	var_00 = [];
	var_00[0] = "civilian_walk_nervous";
	var_00[1] = "civilian_walk_hurried";
	if(issubstr(self.model,"female"))
	{
		var_00[2] = "civilian_walk1_female";
		var_00[3] = "civilian_walk2_female";
	}
	else if(issubstr(self.model,"male"))
	{
		var_00[2] = "civilian_walk1_male";
		var_00[3] = "civilian_walk2_male";
		var_00[4] = "civilian_walk3_male";
		var_00[5] = "civilian_male_walk_cool";
	}

	var_01 = randomintrange(0,var_00.size);
	return var_00[var_01];
}

//Function Number: 129
civilian_cleanup(param_00)
{
	if(isdefined(param_00) && !isremovedentity(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 130
civilian_detach_props()
{
	if(isdefined(self.hasattachedprops) && isdefined(self.attachedpropmodel))
	{
		self detach(self.attachedpropmodel,self.attachedproptag);
		self.hasattachedprops = undefined;
		self.attachedpropmodel = undefined;
		self.attachedproptag = undefined;
	}
}

//Function Number: 131
civilian_walker_setup(param_00,param_01)
{
	level.player endon("death");
	self waittill("trigger");
	var_02 = getent(self.script_linkto,"script_linkname");
	var_03 = getentarray(self.target,"targetname");
	var_04 = [];
	var_05 = [];
	foreach(var_07 in var_03)
	{
		var_04 = common_scripts\utility::getstructarray(var_07.target,"targetname");
		foreach(var_09 in var_04)
		{
			var_0A = var_09 civilian_spawn_single(var_07,"ai",param_01);
			var_07.count = 1;
			var_0A maps\_utility::set_ignoreall(1);
			var_0A.is_walking = 0;
			var_05 = common_scripts\utility::array_add(var_05,var_0A);
			if(isdefined(var_0A.civilian_walk_animation))
			{
				var_0A.animname = "generic";
				var_0B = var_0A.civilian_walk_animation;
				var_0A.runanim = level.scr_anim[var_0A.animname][var_0B][0];
				var_0A maps\_utility::set_run_anim_array(var_0B,undefined,1);
			}
			else
			{
				var_0A.animname = "generic";
				var_0B = civilian_get_random_walk();
				var_0A.civilian_walk_animation = var_0B;
				var_0A.runanim = level.scr_anim[var_0A.animname][var_0B][0];
				var_0A maps\_utility::set_run_anim_array(var_0B,undefined,1);
			}

			wait 0.05;
			var_0A pushplayer(1);
			var_0A thread civilian_walker_behavior_manager(param_00);
			var_0A thread civilian_walker_idle_when_blocked();
		}
	}

	var_02 waittill("trigger");
	foreach(var_0F in var_05)
	{
		civilian_cleanup(var_0F);
	}

	foreach(var_0F in var_05)
	{
		civilian_cleanup(var_0F);
	}
}

//Function Number: 132
civilian_walker_setup_esc_nodes()
{
	level.walker_esc_node_locations = getnodesinradius(self.origin,4096,0,1024,"scripted");
	level.walker_esc_node_locations = filter_nodes(level.esc_node_locations,"ai_walker_esc_node");
}

//Function Number: 133
civilian_walker_behavior_manager(param_00)
{
	self endon("reacting");
	self endon("death");
	level.player endon("death");
	thread civilian_actor_play_idle();
	thread civilian_wait_for_reaction(param_00);
	thread civilian_walker_wait_for_walk_signal();
	self waittill("reacting");
	civilian_walker_play_reaction();
}

//Function Number: 134
civilian_walker_wait_for_walk_signal()
{
	self endon("death");
	self endon("reaction");
	level.player endon("death");
	var_00 = getent(self.script_linkto,"script_linkname");
	var_00 waittill("trigger");
	thread civilian_walker_play_walk();
}

//Function Number: 135
civilian_walker_play_walk()
{
	self endon("death");
	self endon("reacting");
	level.player endon("death");
	self.goal_node = civilian_walker_update_current_goal_and_animate_to(self);
	wait(randomintrange(5,8));
	while(isdefined(self.goal_node))
	{
		self.goal_node = civilian_walker_update_current_goal_and_animate_to(self.goal_node);
		wait(randomintrange(5,8));
	}
}

//Function Number: 136
civilian_walker_idle_when_blocked()
{
	self endon("death");
	self endon("reacting");
	level.player endon("death");
	for(;;)
	{
		if(self.is_walking && civilian_check_if_player_blocking())
		{
			civilian_detach_props();
			thread civilian_actor_play_idle();
			while(civilian_check_if_player_blocking())
			{
				wait(1);
			}

			waittillframeend;
			if(self.is_walking)
			{
				if(isdefined(self.goal_node) && isdefined(self.goal_node.target))
				{
					var_00 = getnode(self.goal_node.target,"targetname");
					var_01 = distance(var_00.origin,self.origin);
					if(var_01 - 15 > self.goalradius)
					{
						stop_current_animations();
						self notify("move");
						civilian_detach_props();
					}
				}
				else
				{
					self notify("move");
					stop_current_animations();
					civilian_detach_props();
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 137
civilian_check_if_player_blocking()
{
	self endon("death");
	self endon("reacting");
	level.player endon("death");
	var_00 = distance(level.player.origin,self.origin);
	if(var_00 < 100)
	{
		return 1;
	}

	return 0;
}

//Function Number: 138
civilian_walker_update_current_goal_and_animate_to(param_00)
{
	var_01 = undefined;
	while(civilian_check_if_player_blocking())
	{
		wait(1);
	}

	if(isdefined(param_00.target))
	{
		var_01 = getnode(param_00.target,"targetname");
	}

	if(isdefined(var_01))
	{
		self setgoalnode(var_01);
		if(isdefined(param_00.script_noteworthy))
		{
			civilian_detach_props();
			stop_current_animations();
			self.animname = "generic";
			var_02 = param_00.script_noteworthy;
			maps\_anim::anim_single_solo_run(self,var_02);
		}

		stop_current_animations();
		self.goalradius = 16;
		civilian_detach_props();
		self notify("move");
		self.is_walking = 1;
		self waittill("goal");
		self.is_walking = 0;
		if(isdefined(var_01.script_parameters))
		{
			stop_current_animations();
			var_01.animname = "generic";
			var_02 = var_01.script_parameters;
			var_01 maps\_anim::anim_single_solo(self,var_02);
		}

		if(isdefined(var_01.animation))
		{
			thread civilian_actor_play_idle(var_01.animation);
		}
		else
		{
			thread civilian_actor_play_idle();
		}

		return var_01;
	}

	return undefined;
}

//Function Number: 139
civilian_walker_play_reaction()
{
	self endon("death");
	level.player endon("death");
	stop_current_animations();
}

//Function Number: 140
bullet_thing(param_00)
{
	self setcandamage(1);
	var_01 = self;
	switch(param_00)
	{
		case "magnet":
			var_01 thread bullet_magnet_shield(self);
			break;

		case "deflector":
			var_01 thread bullet_deflector_shield(self);
			break;

		case "shield":
			var_01 thread bullet_shield_shield(self);
			break;

		default:
			break;
	}

	while(self.health > 0)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(var_06 == "MOD_GRENADE_SPLASH")
		{
			break;
		}
		else if(var_03.classname == "worldspawn")
		{
			self.health = self.health + var_02;
		}
	}

	self kill();
	var_01 delete();
}

//Function Number: 141
bullet_magnet_shield(param_00)
{
	param_00 endon("death");
	self endon("death");
	self.health = 20000;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(var_05 == "MOD_GRENADE_SPLASH")
		{
			continue;
		}

		var_0B = var_04 + anglestoforward(vectortoangles(self.origin - var_04)) * 1;
		var_0C = self.origin + anglestoforward(vectortoangles(var_04 - self.origin)) * 30;
		if(issubstr(var_0A,"grenade"))
		{
			var_0B = var_04 + anglestoforward(vectortoangles(self.origin - var_04)) * 10;
			var_0D = getentarray("grenade","classname");
			foreach(var_0F in var_0D)
			{
				if(distancesquared(var_0F.origin,var_04) < squared(5))
				{
					var_0F delete();
				}
			}

			magicgrenade(var_0A,var_0B,var_0C,1);
		}
		else
		{
			magicbullet(var_0A,var_0B,self.origin);
		}

		self.health = self.health + var_01;
	}
}

//Function Number: 142
bullet_deflector_shield(param_00)
{
	param_00 endon("death");
	self endon("death");
	self.health = 20000;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(var_05 == "MOD_GRENADE_SPLASH")
		{
			continue;
		}

		var_0B = var_04 + anglestoforward(vectortoangles(self.origin - var_04)) * -1;
		var_0C = var_04 + anglestoforward(vectortoangles(self.origin - var_04)) * -2;
		if(issubstr(var_0A,"grenade"))
		{
			var_0D = getentarray("grenade","classname");
			foreach(var_0F in var_0D)
			{
				if(distancesquared(var_0F.origin,var_04) < squared(5))
				{
					var_0F delete();
				}
			}

			magicgrenade(var_0A,var_0B,var_0C,1);
		}
		else
		{
			magicbullet(var_0A,var_0B,var_0C);
		}

		self.health = self.health + var_01;
	}
}

//Function Number: 143
bullet_shield_shield(param_00)
{
	param_00 endon("death");
	self endon("death");
	self.health = 20000;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(var_05 == "MOD_GRENADE_SPLASH")
		{
			continue;
		}

		playfx(common_scripts\utility::getfx("bullet_drop"),var_04,var_03);
		self.health = self.health + var_01;
	}
}

//Function Number: 144
drone_secure_zone(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_07 = common_scripts\utility::getstruct(param_00,"targetname");
	thread maps\_vehicle::vehicle_paths(var_07);
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(param_06 < param_05)
	{
		param_06 = param_05;
	}

	var_08 = param_06 - param_05;
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_wait_or_timeout(param_02,param_05);
	}
	else
	{
		wait(param_05);
	}

	drone_magic_bullets(0,var_08,param_03,param_01);
	drone_magic_bullets(1,undefined,param_01);
}

//Function Number: 145
drone_magic_bullets(param_00,param_01,param_02,param_03)
{
	self endon("death");
	common_scripts\utility::flag_clear("flag_stop_drone_magic_bullets");
	var_04 = 0;
	var_05 = level.player.origin;
	var_06 = self gettagorigin("TAG_LASER");
	var_06 = var_06 - 50 * anglestoforward(var_06);
	if(param_00)
	{
		var_07 = 4;
		var_08 = 75;
		var_09 = 150;
		var_0A = "betrayal_missile_small_lethal";
	}
	else
	{
		var_07 = 8;
		var_08 = 100;
		var_09 = 250;
		var_0A = "betrayal_missile_small_harass";
	}

	if(isdefined(param_01))
	{
		thread flag_set_on_timeout("flag_stop_drone_magic_bullets",param_01);
	}

	if(isdefined(param_02) && isdefined(param_03))
	{
		thread flag_set_once_either_set("flag_stop_drone_magic_bullets",param_02,param_03);
	}
	else
	{
		thread flag_set_once_this_set("flag_stop_drone_magic_bullets",param_02);
	}

	while(!common_scripts\utility::flag("flag_stop_drone_magic_bullets"))
	{
		var_06 = self gettagorigin("TAG_LASER");
		var_0B = randomintrange(var_08,var_09);
		if(var_04 == 0 || var_04 == 5)
		{
			var_05 = level.player.origin + var_0B * anglestoright(level.player.origin);
		}
		else if(var_04 == 1 || var_04 == 6)
		{
			var_05 = level.player.origin - var_0B * anglestoright(level.player.origin);
		}
		else if(var_04 == 2 || var_04 == 7)
		{
			var_05 = level.player.origin + var_0B * anglestoforward(level.player.origin);
		}
		else if(var_04 == 3 || var_04 == 8)
		{
			var_05 = level.player.origin - var_0B * anglestoforward(level.player.origin);
		}
		else if(var_04 == 4)
		{
			var_05 = level.player.origin;
		}

		var_0C = magicbullet(var_0A,var_06,var_05);
		var_0C thread missile_stuff();
		var_04++;
		if(var_04 > var_07)
		{
			var_04 = 0;
		}

		wait(0.1);
	}

	self notify("stop_delay_call");
}

//Function Number: 146
missile_stuff()
{
	playfx(common_scripts\utility::getfx("hovertank_anti_pers_muzzle_flash_vm"),self.origin,anglestoforward(self.angles),anglestoup(self.angles));
	thread missile_delayed_trail();
}

//Function Number: 147
missile_delayed_trail()
{
	var_00 = 0.5;
	wait(var_00);
	if(isdefined(self))
	{
		playfxontag(common_scripts\utility::getfx("hovertank_anti_pers_trail_rocket_2"),self,"tag_origin");
		self waittill("death");
	}
}

//Function Number: 148
flag_set_on_timeout(param_00,param_01)
{
	self endon("stop_delay_call");
	wait(param_01);
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 149
flag_set_once_either_set(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait_either(param_01,param_02);
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 150
flag_set_once_this_set(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_01);
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 151
balcony_death_anims()
{
	self.animname = "generic";
	self.deathfunction = ::try_balcony_death;
}

//Function Number: 152
try_balcony_death()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(self.a.pose == "prone")
	{
		return 0;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "container_death")
	{
		self.deathanim = maps\_utility::getgenericanim("container_death");
		return 0;
	}

	if(isdefined(self.prevnode))
	{
		if(isdefined(self.prevnode.script_balcony))
		{
			var_00 = self.angles[1];
			if(var_00 > 180)
			{
				var_00 = var_00 - 360;
			}

			var_01 = self.prevnode.angles[1];
			if(var_01 > 180)
			{
				var_01 = var_01 - 360;
			}

			var_02 = abs(var_00 - var_01);
			if(var_02 > 90)
			{
				return 0;
			}

			var_03 = distance(self.origin,self.prevnode.origin);
			if(var_03 > 92)
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}

	if(!isdefined(level.last_balcony_death))
	{
		level.last_balcony_death = -4000;
	}

	var_04 = gettime() - level.last_balcony_death;
	if(var_04 < 2000)
	{
		return 0;
	}

	var_05 = maps\_utility::getgenericanim("balcony_death");
	self.deathanim = var_05[randomint(var_05.size)];
	return 0;
}

//Function Number: 153
waittill_player_exo_climbing()
{
	for(;;)
	{
		if(maps\_exo_climb::is_exo_climbing())
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 154
waittill_player_not_exo_climbing()
{
	for(;;)
	{
		if(!maps\_exo_climb::is_exo_climbing())
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 155
spawn_and_handle_looping_helicopters(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,"targetname");
	level.looping_heli_array = [];
	level.looping_helis_currently_moving = [];
	foreach(var_05 in var_03)
	{
		var_06 = var_05 maps\_utility::spawn_vehicle();
		var_06 soundscripts\_snd::snd_message("aud_ambient_helicopter",param_00);
		var_06 childthread heli_hold_position(var_05,param_01);
		level.looping_heli_array = common_scripts\utility::array_add(level.looping_heli_array,var_06);
	}

	if(level.looping_heli_array.size > 0)
	{
		while(!common_scripts\utility::flag(param_01))
		{
			if(level.looping_helis_currently_moving.size < param_02)
			{
				var_08 = 0;
				for(;;)
				{
					var_09 = 1;
					var_08 = randomintrange(0,level.looping_heli_array.size);
					if(!common_scripts\utility::array_contains(level.looping_helis_currently_moving,level.looping_heli_array[var_08]))
					{
						break;
					}

					wait(0.05);
				}

				level.looping_helis_currently_moving = common_scripts\utility::array_add(level.looping_helis_currently_moving,level.looping_heli_array[var_08]);
				level.looping_heli_array[var_08] childthread send_heli_through_path(level.looping_helis_currently_moving.size - 1);
			}

			wait(1);
		}

		common_scripts\utility::flag_wait(param_01);
		foreach(var_0B in level.looping_heli_array)
		{
			if(isdefined(var_0B))
			{
				var_0B thread heli_delete_on_pathend();
			}
		}
	}
}

//Function Number: 156
heli_hold_position(param_00,param_01)
{
	for(;;)
	{
		if(!common_scripts\utility::array_contains(level.looping_helis_currently_moving,self))
		{
			self vehicle_teleport(param_00.origin,param_00.angles,0);
		}

		wait(5);
		if(common_scripts\utility::flag(param_01))
		{
			break;
		}
	}
}

//Function Number: 157
send_heli_through_path(param_00)
{
	self endon("death");
	var_01 = self.origin;
	var_02 = self.angles;
	var_03 = common_scripts\utility::getstruct(self.target,"targetname");
	thread maps\_vehicle_code::_vehicle_paths(var_03);
	self waittill("reached_dynamic_path_end");
	wait 0.05;
	if(isdefined(self))
	{
		self vehicle_teleport(var_01,var_02,0);
		level.looping_helis_currently_moving = common_scripts\utility::array_remove(level.looping_helis_currently_moving,self);
	}
}

//Function Number: 158
heli_delete_on_pathend()
{
	common_scripts\utility::waittill_notify_or_timeout_return("reached_dynamic_path_end",30);
	level.looping_heli_array = common_scripts\utility::array_remove(level.looping_heli_array,self);
	self delete();
}

//Function Number: 159
start_player_diveboat_ride()
{
	level.player_boat useby(level.player);
	level.player_boat vehicle_scripts\_diveboat::do_diveboat_threads();
	level.player_boat setviewmodeldepth(1);
	level.player.drivingvehicle = level.player_boat;
}

//Function Number: 160
scripted_spin_fan_blades(param_00,param_01)
{
	level endon(param_01);
	var_02 = max(randomfloatrange(0.1,2) / 4,0.05) * param_00;
	var_03 = self.angles[1];
	for(;;)
	{
		while(var_03 > 36000)
		{
			var_03 = var_03 - 36000;
			self.angles = (self.angles[0],var_03,self.angles[2]);
		}

		var_03 = var_03 + 90;
		self rotateyaw(90,var_02,0,0);
		wait(var_02);
	}
}

//Function Number: 161
progress_path_create(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	var_02 = [];
	var_03 = 0;
	var_04 = var_01;
	for(;;)
	{
		var_05 = var_01;
		if(isdefined(var_01.target))
		{
			var_05 = common_scripts\utility::getstruct(var_01.target,"targetname");
		}

		var_02[var_02.size] = var_01;
		var_01.next_node = var_05;
		var_01.prev_node = var_04;
		var_01.dist_to_next_node = distance(var_01.origin,var_01.next_node.origin);
		var_01.index = var_03;
		var_03++;
		if(var_01 == var_05)
		{
			break;
		}

		var_04 = var_01;
		var_01 = var_05;
	}

	return var_02;
}

//Function Number: 162
progress_path_get_my_node_from_org(param_00)
{
	param_00 = (param_00[0],param_00[1],0);
	var_01 = common_scripts\utility::get_array_of_closest(param_00,self,undefined,3);
	var_02 = var_01[0];
	var_03 = var_02.index;
	if(var_01[1].index < var_03)
	{
		var_02 = var_01[1];
		var_03 = var_02.index;
	}

	if(var_01[2].index < var_03)
	{
		var_02 = var_01[2];
	}

	return var_02;
}

//Function Number: 163
progress_path_move_to_correct_node(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	for(;;)
	{
		var_04 = param_00.dist_to_next_node;
		if(param_01 > var_04)
		{
			if(param_00 == param_00.next_node)
			{
				break;
			}

			var_05 = get_position_from_spline(param_00,var_04,param_02);
			param_01 = param_01 - var_04;
			param_00 = param_00.next_node;
			var_06 = get_progression_between_points(var_05,param_00.origin,param_00.next_node.origin);
			param_02 = var_06["offset"];
			continue;
		}

		if(param_01 < 0)
		{
			if(param_00 == param_00.prev_node)
			{
				break;
			}

			var_05 = get_position_from_spline(param_00,0,param_02);
			param_00 = param_00.prev_node;
			var_06 = get_progression_between_points(var_05,param_00.origin,param_00.next_node.origin);
			param_01 = param_01 + var_06["progress"];
			param_02 = var_06["offset"];
			continue;
		}

		break;
	}

	var_03.node = param_00;
	var_03.progress = param_01;
	var_03.offset = param_02;
	return var_03;
}

//Function Number: 164
get_progression_between_points(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = vectornormalize(param_02 - param_01);
	var_05 = param_00 - param_01;
	var_06 = vectordot(var_05,var_04);
	var_07 = param_01 + var_04 * var_06;
	var_03["progress"] = var_06;
	var_03["offset"] = distance2d(var_07,param_00);
	var_08 = anglestoright(vectortoangles(var_04));
	var_09 = vectornormalize(var_07 - param_00);
	var_0A = vectordot(var_08,var_09);
	var_03["side"] = "right";
	if(var_0A > 0)
	{
		var_03["offset"] = var_03["offset"] * -1;
		var_03["side"] = "left";
	}

	return var_03;
}

//Function Number: 165
get_position_from_spline(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = vectortoangles(param_00.next_node.origin - param_00.origin);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	return param_00.origin + var_05 * param_01 + var_06 * param_02;
}

//Function Number: 166
can_teleport_ai_to_pos(param_00,param_01,param_02)
{
	if(player_can_see_ai_bones(param_00,param_02))
	{
		return 0;
	}

	if(player_can_see_point(param_01,param_02))
	{
		return 0;
	}

	if(player_can_see_point(param_01 + (0,0,70),param_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 167
player_can_see_point(param_00,param_01)
{
	var_02 = 0.342;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	var_03 = level.player getplayerangles();
	if(!common_scripts\utility::within_fov(level.player.origin,var_03,param_00,var_02))
	{
		return 0;
	}

	var_04 = level.player geteye();
	if(sighttracepassed(var_04,param_00,1,level.player))
	{
		return 1;
	}

	return 0;
}

//Function Number: 168
player_can_see_ai_bones(param_00,param_01)
{
	var_02 = 0.342;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,param_00.origin,var_02))
	{
		return 0;
	}

	var_03 = level.player geteye();
	var_04 = param_00 gettagorigin("j_head");
	if(sighttracepassed(var_03,var_04,1,level.player,param_00))
	{
		return 1;
	}

	var_05 = param_00 gettagorigin("j_mainroot");
	if(sighttracepassed(var_03,var_05,1,level.player,param_00))
	{
		return 1;
	}

	var_06 = param_00 gettagorigin("j_wrist_le");
	if(sighttracepassed(var_03,var_06,1,level.player,param_00))
	{
		return 1;
	}

	var_06 = param_00 gettagorigin("j_wrist_ri");
	if(sighttracepassed(var_03,var_06,1,level.player,param_00))
	{
		return 1;
	}

	var_07 = param_00 gettagorigin("j_ankle_ri");
	if(sighttracepassed(var_03,var_07,1,level.player,param_00))
	{
		return 1;
	}

	var_07 = param_00 gettagorigin("j_ankle_ri");
	if(sighttracepassed(var_03,var_07,1,level.player,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 169
handle_ally_keep_up_with_player(param_00)
{
	level notify("stop_previous_ally_move_manager");
	level endon("stop_previous_ally_move_manager");
	level endon("flag_boat_player_in_boat");
	var_01 = progress_path_create("level_progression_path_start");
	var_02 = var_01 progress_path_get_my_node_from_org(level.player.origin);
	var_03 = var_02;
	var_04 = 0;
	var_05 = var_01 progress_path_get_my_node_from_org(param_00.origin);
	var_06 = var_05;
	var_07 = 0;
	for(;;)
	{
		var_08 = get_progression_between_points(level.player.origin,var_02.origin,var_02.next_node.origin);
		var_09 = progress_path_move_to_correct_node(var_02,var_08["progress"],var_08["offset"]);
		var_0A = get_progression_between_points(param_00.origin,var_05.origin,var_05.next_node.origin);
		var_0B = progress_path_move_to_correct_node(var_05,var_0A["progress"],var_0A["offset"]);
		var_0C = var_09.progress;
		var_0D = var_09.offset;
		var_02 = var_09.node;
		var_0E = var_0B.progress;
		var_0F = var_0B.offset;
		var_05 = var_0B.node;
		if(var_02 == var_03.next_node)
		{
			var_03 = var_02;
			var_04 = var_0C;
		}

		if(var_02 == var_03 && var_0C >= var_04 + 5)
		{
			var_03 = var_02;
			var_04 = var_0C;
		}

		if(var_05 == var_06.next_node)
		{
			var_06 = var_05;
			var_07 = var_0E;
		}

		if(var_05 == var_06 && var_0E >= var_07 + 5)
		{
			var_06 = var_05;
			var_07 = var_0E;
		}

		ally_determine_move_speed(var_09,var_0B,param_00);
		wait(0.05);
	}
}

//Function Number: 170
ally_determine_move_speed(param_00,param_01,param_02)
{
	level endon("flag_boat_player_in_boat");
	var_03 = 0;
	if(param_00.node == param_01.node)
	{
		if(param_00.progress > param_01.progress)
		{
			var_03 = 1;
		}
		else
		{
			var_03 = 0;
		}
	}
	else if(param_00.node.index > param_01.node.index)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = 0;
	}

	if(var_03)
	{
		var_04 = distance(level.player.origin,param_02.origin);
		if(var_04 < 256)
		{
			param_02 maps\_utility::set_moveplaybackrate(1,0.5);
		}

		if(var_04 < 512)
		{
			param_02 maps\_utility::set_moveplaybackrate(1.2,0.5);
			return;
		}

		param_02 maps\_utility::set_moveplaybackrate(1.4,0.5);
		return;
	}

	var_04 = distance(level.player.origin,var_03.origin);
	if(var_04 < 64)
	{
		param_02 maps\_utility::set_moveplaybackrate(1.05,0.5);
		return;
	}

	param_02 maps\_utility::set_moveplaybackrate(1,0.5);
}