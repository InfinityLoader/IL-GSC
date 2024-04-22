/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_mech_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 698 ms
 * Timestamp: 4/22/2024 2:26:27 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
	common_scripts\utility::flag_init("hint_mash_button");
	maps\_utility::add_hint_string("hint_mash_button",&"CAPTURED_HINT_TAP",::hint_mash_button);
	common_scripts\utility::flag_init("hint_push_forward");
	maps\_utility::add_hint_string("hint_push_forward","Press Forward on Left Thumbstick to Push",::hint_push_forward);
	common_scripts\utility::flag_init("hint_pull_back");
	maps\_utility::add_hint_string("hint_pull_back","Press down on Left Thumbstick to Pull",::hint_pull_back);
	common_scripts\utility::flag_init("flag_mech_smash_active");
	mech_player_anims();
	mech_generic_human();
	mech_script_model_anims();
	mech_vehicle_anims();
	mech_fx();
}

//Function Number: 2
init_mech_actions()
{
	level.allow_threat_paint = 1;
	setsaveddvar("mechAcceleration",0.6);
	setsaveddvar("mechAirAcceleration",0.6);
	if(!isdefined(self.mech_init))
	{
		self.mech_init = 1;
		level.player thread maps\captured_util::waittill_notify_func("playermech_start",::soundscripts\_snd::snd_message,"aud_plr_inside_mech");
		setup_smash_nodes();
		common_scripts\utility::array_thread(getentarray("trig_mb_destructible","script_noteworthy"),::mech_action_smash);
		common_scripts\utility::array_thread(common_scripts\utility::getstructarray("brush_mb1_crane","targetname"),::mech_action_shoot);
		level.player thread mech_crush();
		maps\_playermech_code::playermech_disable_badplace();
		level.mech_swarm_number_of_rockets_per_target = 8;
	}
}

//Function Number: 3
hint_mash_button()
{
	return !common_scripts\utility::flag("hint_mash_button");
}

//Function Number: 4
hint_push_forward()
{
	return !common_scripts\utility::flag("hint_push_forward");
}

//Function Number: 5
hint_pull_back()
{
	return !common_scripts\utility::flag("hint_pull_back");
}

//Function Number: 6
mech_player_anims()
{
}

//Function Number: 7
mech_generic_human()
{
	level.scr_animtree["mech_player_rig"] = #animtree;
	level.scr_model["mech_player_rig"] = "worldhands_playermech";
	level.scr_anim["mech_player_rig"]["mech_run_through"] = %cap_playermech_run_through_mech_short;
	level.scr_anim["generic"]["explode_death"] = %death_explosion_run_f_v2;
	level.scr_anim["mech_player_rig"]["anim_mb1_intro_exit"] = %cap_s1_escape_mech_control_release_mech;
	level.scr_anim["mech_player_rig"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_jump_out_mech;
	level.scr_animtree["mb1_introwall_guard"] = #animtree;
	level.scr_anim["mb1_introwall_guard1"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_01;
	level.scr_anim["mb1_introwall_guard2"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_02;
	level.scr_anim["mb1_introwall_guard3"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_03;
	level.scr_anim["mb1_introwall_guard4"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_04;
	level.scr_anim["mb1_introwall_guard5"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_05;
	level.scr_anim["mb1_introwall_guard6"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_06;
	level.scr_anim["mb1_introwall_guard7"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_07;
	level.scr_anim["mb1_introwall_guard8"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_08;
	level.scr_anim["mb1_introwall_guard9"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_09;
	level.scr_anim["mb1_introwall_guard10"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_10;
	level.scr_anim["mb1_introwall_guard11"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_11;
	level.scr_anim["mb1_introwall_guard12"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_12;
	level.scr_anim["mb1_introwall_guard13"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_13;
	level.scr_anim["mb1_introwall_guard14"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_14;
	level.scr_anim["mb1_introwall_guard15"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_15;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_intro"] = %cap_s1_escape_mech_door_lift_intro_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_intro_idle"][0] = %cap_s1_escape_mech_door_lift_idle_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_1"] = %cap_s1_escape_mech_door_lift_01_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_2"] = %cap_s1_escape_mech_door_lift_02_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_3"] = %cap_s1_escape_mech_door_lift_03_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_4"] = %cap_s1_escape_mech_door_lift_04_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_5"] = %cap_s1_escape_mech_door_lift_05_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_6"] = %cap_s1_escape_mech_door_lift_06_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_7"] = %cap_s1_escape_mech_door_lift_07_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_1_rev"] = %cap_s1_escape_mech_door_lift_01_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_2_rev"] = %cap_s1_escape_mech_door_lift_02_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_3_rev"] = %cap_s1_escape_mech_door_lift_03_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_4_rev"] = %cap_s1_escape_mech_door_lift_04_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_5_rev"] = %cap_s1_escape_mech_door_lift_05_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_6_rev"] = %cap_s1_escape_mech_door_lift_06_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_7_rev"] = %cap_s1_escape_mech_door_lift_07_rev_mech;
	level.scr_anim["mech_player_rig"]["anim_exit_gatelift_exit"] = %cap_s1_escape_mech_door_lift_exit_mech;
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket_0",::notify_fire_rocket_0,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket_1",::notify_fire_rocket_1,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket",::notify_fire_rocket_2,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket_2",::notify_fire_rocket_3,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket_3",::notify_fire_rocket_4,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket_4",::notify_fire_rocket_5,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fire_rocket_5",::notify_fire_rocket_6,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fx_mech_foot_sparks",::maps\captured_fx::fx_mech_foot_sparks);
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fx_mech_exit_steam",::maps\captured_fx::fx_mech_exit_steam);
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fx_mech_land_sparks",::maps\captured_fx::fx_mech_land_sparks);
	maps\_anim::addnotetrack_customfunction("mech_player_rig","fx_mech_soft_land_dust",::maps\captured_fx::fx_mech_soft_land_dust);
	maps\_anim::addnotetrack_customfunction("mech_player_rig","mech_swap",::notify_mech_swap,"anim_exit_gatelift_exit");
	maps\_anim::addnotetrack_customfunction("mech_player_rig","snd_end_01",::maps\captured_aud::snd_end_01,"anim_exit_gatelift_exit");
	level.scr_anim["ally_0"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_gideon;
	level.scr_anim["tank_driver"]["anim_exit_takedown_intro"] = %cap_s1_escape_mech_tank_takedown_intro_opfor;
	level.scr_anim["tank_driver"]["anim_exit_takedown_idle"][0] = %cap_s1_escape_mech_tank_takedown_loop_opfor;
	level.scr_anim["tank_driver"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_opfor;
	level.scr_anim["mech_player_rig"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_mech;
}

//Function Number: 8
notify_fire_rocket_0(param_00)
{
	level.player notify("notify_fire_rocket_0");
}

//Function Number: 9
notify_fire_rocket_1(param_00)
{
	level.player notify("notify_fire_rocket_1");
}

//Function Number: 10
notify_fire_rocket_2(param_00)
{
	level.player notify("notify_fire_rocket_2");
}

//Function Number: 11
notify_fire_rocket_3(param_00)
{
	level.player notify("notify_fire_rocket_3");
}

//Function Number: 12
notify_fire_rocket_4(param_00)
{
	level.player notify("notify_fire_rocket_4");
}

//Function Number: 13
notify_fire_rocket_5(param_00)
{
	level.player notify("notify_fire_rocket_5");
}

//Function Number: 14
notify_fire_rocket_6(param_00)
{
	level.player notify("notify_fire_rocket_6");
}

//Function Number: 15
notify_mech_swap(param_00)
{
	level.player notify("mech_swap");
}

//Function Number: 16
mech_script_model_anims()
{
	level.scr_animtree["mb_wall_1"] = #animtree;
	level.scr_anim["mb_wall_1"]["mech_run_through"] = %cap_playermech_run_through_prop_short;
	level.scr_model["mb_wall_1"] = "cap_playermech_breakable_wall";
	level.scr_animtree["mb1_introwall"] = #animtree;
	level.scr_anim["mb1_introwall"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_jump_out_wall;
	level.scr_animtree["exit_gate_lock"] = #animtree;
	level.scr_model["exit_gate_lock"] = "cap_s1_exit_gate_lock";
	level.scr_anim["exit_gate_lock"]["anim_exit_gateclose"] = %cap_s1_escape_mech_gate_close_lock;
	level.scr_anim["exit_gate_lock"]["anim_exit_gatelift_intro"] = %cap_s1_escape_mech_door_lift_intro_lock;
	level.scr_animtree["exit_gate_inner"] = #animtree;
	level.scr_anim["exit_gate_inner"]["anim_exit_gateclose"] = %cap_s1_escape_mech_gate_close_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_intro"] = %cap_s1_escape_mech_door_lift_intro_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_intro_idle"][0] = %cap_s1_escape_mech_door_lift_intro_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_1"] = %cap_s1_escape_mech_door_lift_01_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_2"] = %cap_s1_escape_mech_door_lift_02_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_3"] = %cap_s1_escape_mech_door_lift_03_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_4"] = %cap_s1_escape_mech_door_lift_04_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_5"] = %cap_s1_escape_mech_door_lift_05_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_6"] = %cap_s1_escape_mech_door_lift_06_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_7"] = %cap_s1_escape_mech_door_lift_07_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_1_rev"] = %cap_s1_escape_mech_door_lift_01_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_2_rev"] = %cap_s1_escape_mech_door_lift_02_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_3_rev"] = %cap_s1_escape_mech_door_lift_03_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_4_rev"] = %cap_s1_escape_mech_door_lift_04_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_5_rev"] = %cap_s1_escape_mech_door_lift_05_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_6_rev"] = %cap_s1_escape_mech_door_lift_06_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_7_rev"] = %cap_s1_escape_mech_door_lift_07_rev_door;
	level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_exit"] = %cap_s1_escape_mech_door_lift_exit_door;
	level.scr_animtree["mech_gun"] = #animtree;
	level.scr_model["mech_gun"] = "vm_exo_interior_base";
}

//Function Number: 17
mech_vehicle_anims()
{
	level.scr_animtree["tank"] = #animtree;
	level.scr_anim["tank"]["anim_exit_takedown_intro"] = %cap_s1_escape_mech_tank_takedown_intro_tank;
	level.scr_anim["tank"]["anim_exit_takedown_idle"][0] = %cap_s1_escape_mech_tank_takedown_loop_tank;
	level.scr_anim["tank"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_tank;
}

//Function Number: 18
mech_fx()
{
	level._effect["fx_trailer_1"] = loadfx("vfx/destructible/cap_tank_trailer_l");
	level._effect["fx_trailer_3"] = loadfx("vfx/destructible/cap_tank_trailer_c");
	level._effect["fx_trailer_2"] = loadfx("vfx/destructible/cap_tank_trailer_r");
}

//Function Number: 19
mech_action_smash()
{
	level.player endon("death");
	level.player endon("exit_mech");
	self endon("death");
	level._mb.trigs = common_scripts\utility::array_add(level._mb.trigs,self);
	self.nodes = common_scripts\utility::getstructarray(self.target,"targetname");
	self.flag_smash = 0;
	self.additional_unlink_nodes = [];
	if(isdefined(self.nodes[0].target))
	{
		self.additional_geo = [];
		foreach(var_01 in getentarray(self.nodes[0].target,"targetname"))
		{
			if(issubstr(var_01.classname,"brushmodel"))
			{
				self.col = var_01;
				continue;
			}

			if(issubstr(var_01.classname,"model"))
			{
				self.additional_geo = common_scripts\utility::array_add(self.additional_geo,var_01);
			}
		}

		foreach(var_04 in common_scripts\utility::getstructarray(self.nodes[0].target,"targetname"))
		{
			if(isdefined(var_04.script_parameters) && var_04.script_parameters == "unlink")
			{
				self.additional_unlink_nodes = common_scripts\utility::array_add(self.additional_unlink_nodes,var_04);
				continue;
			}

			self.fx = var_04;
		}

		self.var_3A7 = getscriptablearray(self.nodes[0].target,"targetname")[0];
		self.glass = getglassarray(self.nodes[0].target);
		if(isdefined(self.col))
		{
			if(isdefined(self.nodes[0].height))
			{
				self.col connectpaths();
			}

			if(isdefined(self.col.target))
			{
				foreach(var_01 in getentarray(self.col.target,"targetname"))
				{
					self.additional_geo = common_scripts\utility::array_add(self.additional_geo,var_01);
				}
			}
		}
	}

	if(isdefined(self.col))
	{
		childthread mech_action_smash_projectile();
	}

	var_08 = undefined;
	for(;;)
	{
		self waittill("trigger",var_09,var_0A,var_0B);
		var_0C = 0;
		if(isstring(var_09) && var_09 == "weapon")
		{
			var_0C = 1;
		}

		if(self.flag_smash)
		{
			continue;
		}

		if(common_scripts\utility::flag("flag_mech_smash_active") && !var_0C)
		{
			continue;
		}

		var_0D = 0;
		var_0E = level.player meleebuttonpressed();
		if(var_0E || var_0C)
		{
			var_08 = choosesmashnode(level.player.origin,anglestoforward(level.player.angles),1);
			if(!isdefined(var_08) && !var_0C)
			{
				continue;
			}

			if(isdefined(var_08))
			{
				var_0D = level.player cansmash(var_08,anglestoforward(var_08.angles));
			}

			if(!var_0D && !var_0C)
			{
				continue;
			}

			if(!var_0C)
			{
				if(!var_0D)
				{
					continue;
				}

				if(distance(level.player.origin,var_08.origin) > 70)
				{
					while(level.player ismeleeing())
					{
						wait(0.05);
					}

					continue;
				}

				if(vectordot(anglestoforward(level.player getplayerangles()),anglestoforward(var_08.angles)) < 0.5)
				{
					while(level.player ismeleeing())
					{
						wait(0.05);
					}

					continue;
				}
			}
			else
			{
				var_08 = choosesmashnode(var_0B,var_0A,0,1);
				if(!isdefined(var_08))
				{
					continue;
				}
			}

			common_scripts\utility::flag_set("flag_mech_smash_active");
			if(level.allow_threat_paint)
			{
				common_scripts\utility::flag_clear("flag_mech_threat_paint_ping_on");
			}

			self.flag_smash = 1;
			anim_prep(var_08);
			if(var_0C)
			{
				soundscripts\_snd::snd_message("mech_wall_smash_3d",self.smash_obj.origin);
			}
			else
			{
				soundscripts\_snd::snd_message("mech_wall_smash");
			}

			if(isdefined(self.var_3A7))
			{
				if(angleclamp180(self.var_3A7.angles[1]) == angleclamp180(var_08.angles[1]))
				{
					self.var_3A7 setscriptablepartstate(0,4);
				}
				else
				{
					self.var_3A7 setscriptablepartstate(0,3);
				}
			}
			else if(self.smash_obj.model != "tag_origin")
			{
				var_08 thread maps\_anim::anim_single_solo(self.smash_obj,"mech_run_through");
				self.smash_obj setanimtime(self.smash_obj maps\_utility::getanim("mech_run_through"),0.2);
			}

			if(isdefined(self.col))
			{
				self.col connectpaths();
				self.col notify("remove");
				self.col delete();
			}

			if(isdefined(self.fx))
			{
				playfx(self.fx common_scripts\utility::getfx(self.fx.script_parameters),self.fx.origin,anglestoforward(self.fx.angles));
			}

			if(isdefined(self.fx))
			{
				thread smash_throw(self.fx.origin,256);
			}
			else
			{
				thread smash_throw_2(var_0B);
			}

			foreach(var_10 in self.additional_unlink_nodes)
			{
				common_scripts\utility::array_thread(getnodesinradius(var_10.origin,var_10.radius,0),::disconnect_node);
			}

			if(!isdefined(self.var_3A7) && self.smash_obj.model != "tag_origin")
			{
				var_08 waittill("mech_run_through");
			}

			if(level.allow_threat_paint)
			{
				common_scripts\utility::flag_set("flag_mech_threat_paint_ping_on");
			}

			common_scripts\utility::flag_clear("flag_mech_smash_active");
			level notify("mech_smash");
			cleanup_mech_traversal_elements(var_08);
			return;
		}
		else if(level.player getnormalizedmovement()[0] > 0)
		{
			var_0B = choosesmashnode(level.player.origin,anglestoforward(level.player.angles),1);
			if(!isdefined(var_0B))
			{
				continue;
			}

			if(!level.player cansmash(var_0B,anglestoforward(var_0B.angles)))
			{
				continue;
			}

			common_scripts\utility::flag_set("flag_mech_smash_active");
			if(level.allow_threat_paint)
			{
				common_scripts\utility::flag_clear("flag_mech_threat_paint_ping_on");
			}

			self.flag_smash = 1;
			anim_prep(var_0B);
			level.player thread spawn_mech_rig(1,0.2);
			if(isdefined(self.var_3A7))
			{
				if(angleclamp180(self.var_3A7.angles[1]) == angleclamp180(var_0B.angles[1]))
				{
					self.var_3A7 setscriptablepartstate(0,4);
				}
				else
				{
					self.var_3A7 setscriptablepartstate(0,3);
				}
			}

			var_12 = [level.player.rig];
			if(!isdefined(self.var_3A7) && self.smash_obj.model != "tag_origin")
			{
				var_12 = common_scripts\utility::array_add(var_12,self.smash_obj);
			}
			else
			{
				var_0B = var_0B common_scripts\utility::spawn_tag_origin();
				var_0B thread smash_surface_float();
			}

			common_scripts\utility::flag_set("flag_force_hud_ready");
			var_0B thread anim_single_mech(var_12,"mech_run_through","cap_playermech_run_through_mech_short_vm");
			soundscripts\_snd::snd_message("mech_wall_smash");
			if(isdefined(self.col))
			{
				self.col connectpaths();
				self.col notify("remove");
				self.col delete();
			}

			if(isdefined(self.fx))
			{
				thread smash_throw(self.fx.origin,256);
			}
			else
			{
				thread smash_throw_2(var_0E);
			}

			foreach(var_13 in self.additional_unlink_nodes)
			{
				common_scripts\utility::array_thread(getnodesinradius(var_13.origin,var_13.radius,0),::disconnect_node);
			}

			if(isdefined(self.fx))
			{
				playfx(self.fx common_scripts\utility::getfx(self.fx.script_parameters),self.fx.origin,anglestoforward(self.fx.angles));
			}

			var_0A waittill("mech_anim_done");
			common_scripts\utility::flag_clear("flag_force_hud_ready");
			setsaveddvar("mechHide",0);
			level.player unlink();
			level.player.rig delete();
			if(level.allow_threat_paint)
			{
				common_scripts\utility::flag_set("flag_mech_threat_paint_ping_on");
			}

			common_scripts\utility::flag_clear("flag_mech_smash_active");
			level notify("mech_smash");
			cleanup_mech_traversal_elements(var_0A);
			return;
		}
	}
}

//Function Number: 20
smash_surface_float()
{
	level.player.rig linkto(self);
	var_00 = self.origin + anglestoforward(self.angles) * 64 + (0,0,64);
	var_00 = maps\_utility::groundpos(var_00);
	var_01 = getanimlength(level.player.rig maps\_utility::getanim("mech_run_through"));
	if(isdefined(var_00))
	{
		self moveto(var_00,var_01);
	}

	wait(var_01);
	level.player.rig unlink();
	wait(0.05);
	self delete();
}

//Function Number: 21
choosesmashnode(param_00,param_01,param_02,param_03)
{
	var_04 = sortbydistance(self.nodes,param_00);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = undefined;
	var_06 = 0;
	var_07 = undefined;
	var_08 = [];
	foreach(var_0A in var_04)
	{
		var_0B = 0;
		var_07 = vectordot(anglestoforward(var_0A.angles),vectornormalize(param_01));
		if(var_07 > 0.7)
		{
			var_0B = 1;
			var_05 = var_0A;
		}
		else if(param_03 && var_07 > var_06)
		{
			var_05 = var_0A;
		}

		if(param_02)
		{
			var_0C = 32;
			if(isdefined(var_0A.radius))
			{
				var_0C = var_0A.radius;
			}

			var_0D = distance2d(level.player.origin,var_0A.origin);
			if(var_0D > var_0C)
			{
				var_05 = undefined;
			}
		}

		if(isdefined(var_05) && var_0B)
		{
			var_08 = common_scripts\utility::array_add(var_08,var_05);
		}
	}

	if(var_08.size > 0 && param_02)
	{
		return var_08[0];
	}

	if(isdefined(var_05))
	{
		return var_05;
	}
}

//Function Number: 22
cansmash(param_00,param_01)
{
	if(self getstance() != "stand")
	{
		return 0;
	}

	if(distance((0,0,self.origin[2]),(0,0,param_00.origin[2])) > 64)
	{
		return 0;
	}

	var_02 = param_00.origin + (0,0,64);
	if(!level.player maps\_utility::player_looking_at(var_02 + param_01 * 64,0.7,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
smash_throw_2(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = self.smash_obj.origin;
	}

	if(!isdefined(param_01))
	{
		param_01 = 128;
	}

	foreach(var_03 in sortbydistance(maps\_utility::remove_dead_from_array(level.mech_crush),param_00,param_01))
	{
		var_04 = var_03 death_throw(param_00,param_01,1);
	}
}

//Function Number: 24
smash_throw(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = self.smash_obj.origin;
	}

	if(!isdefined(param_01))
	{
		param_01 = 170;
	}

	foreach(var_03 in sortbydistance(maps\_utility::remove_dead_from_array(level.mech_crush),param_00,param_01))
	{
		var_03 thread smash_throw_solo();
	}

	physicsexplosionsphere(param_00,param_01,param_01,1);
}

//Function Number: 25
smash_throw_solo()
{
	if(isdefined(self.smash_throw_active))
	{
		return;
	}

	self.smash_throw_active = 1;
	var_00 = common_scripts\utility::spawn_tag_origin();
	self.animname = "generic";
	self.a.nodeath = 1;
	self.allowdeath = 1;
	level.player maps\_playermech_code::disable_stencil(self);
	self.noragdoll = 0;
	self startragdoll();
	var_00 thread maps\_anim::anim_single_solo(self,"explode_death");
	wait(0.25);
	if(isalive(self))
	{
		self notify("death",level.player,"MOD_MECH_SMASH");
		self kill();
	}

	var_00 delete();
}

//Function Number: 26
mech_action_smash_projectile()
{
	self.col setcandamage(1);
	self.col setcanradiusdamage(1);
	self.col solid();
	self.col endon("remove");
	if(isdefined(self.col.hits_left))
	{
		return;
	}

	var_00 = 2;
	self.col.hits_left = var_00;
	for(;;)
	{
		self.col waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(!isdefined(var_05))
		{
			continue;
		}

		if(isdefined(var_02) && var_02 == level.player)
		{
			if(issubstr(var_05,"BULLET"))
			{
				self.col.hits_left--;
				if(self.col.hits_left <= 0)
				{
					self notify("trigger","weapon",var_03,var_04);
				}
				else if(isdefined(self.var_3A7) && !isdefined(self.damaged))
				{
					var_06 = choosesmashnode(var_04,var_03,0,1);
					if(!isdefined(var_06))
					{
						continue;
					}

					if(angleclamp180(self.var_3A7.angles[1]) == angleclamp180(var_06.angles[1]))
					{
						self.var_3A7 setscriptablepartstate(0,1);
					}
					else
					{
						self.var_3A7 setscriptablepartstate(0,2);
					}

					self.damaged = 1;
				}

				continue;
			}

			if(isdefined(var_05) && issubstr(var_05,"GRENADE"))
			{
				self notify("trigger","weapon",var_03,var_04);
				continue;
			}

			if(isdefined(var_05) && issubstr(var_05,"SPLASH") || var_05 == "MOD_PROJECTILE")
			{
				self notify("trigger","weapon",var_03,var_04);
				continue;
			}
		}
	}
}

//Function Number: 27
anim_prep(param_00)
{
	if(isdefined(self.var_3A7))
	{
		self.smash_obj = self.var_3A7;
	}
	else if(isdefined(param_00.script_parameters))
	{
		self.smash_obj = maps\_utility::spawn_anim_model(param_00.script_parameters);
	}
	else
	{
		self.smash_obj = param_00 common_scripts\utility::spawn_tag_origin();
	}

	if(isdefined(param_00.height))
	{
		self.smash_obj.height = param_00.height;
	}

	if(isdefined(self.additional_geo))
	{
		foreach(var_02 in self.additional_geo)
		{
			if(isdefined(var_02))
			{
				var_02 delete();
			}
		}
	}

	self.additional_geo = undefined;
	if(isdefined(self.glass))
	{
		foreach(var_05 in self.glass)
		{
			deleteglass(var_05);
		}
	}

	self.glass = undefined;
	if(isdefined(self.opp_trig))
	{
		self.opp_trig cleanup_mech_traversal_elements(param_00,0);
	}
}

//Function Number: 28
setup_smash_nodes()
{
	foreach(var_01 in getallnodes())
	{
		if(issubstr(var_01.type,"Cover") || issubstr(var_01.type,"Conceal") || issubstr(var_01.type,"Exposed"))
		{
			if(isdefined(var_01.script_nodestate))
			{
				var_01.state = tolower(var_01.script_nodestate);
				switch(var_01.state)
				{
					case "linked":
						break;

					case "unlinked":
						var_01 disconnect_node(1);
						break;

					default:
						iprintln("Warning: node at " + var_01.origin + " has a .script_nodestate of \'" + var_01.state);
						break;
				}

				level._mb.nodes = common_scripts\utility::array_add(level._mb.nodes,var_01);
			}
		}
	}
}

//Function Number: 29
cleanup_mech_traversal_elements(param_00,param_01)
{
	if(isdefined(self.smash_obj) && !isdefined(self.var_3A7))
	{
		self.smash_obj delete();
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(isdefined(self.additional_geo))
	{
		foreach(var_03 in self.additional_geo)
		{
			if(isdefined(var_03))
			{
				var_03 delete();
			}
		}
	}

	if(isdefined(self.glass))
	{
		foreach(var_06 in self.glass)
		{
			deleteglass(var_06);
		}
	}

	if(isdefined(self.col))
	{
		self.col connectpaths();
		self.col notify("remove");
		self.col delete();
	}

	if(param_01)
	{
		var_08 = 128;
		if(isdefined(param_00.height))
		{
			var_08 = param_00.height;
		}

		foreach(var_0A in getnodesinradius(param_00.origin,128,0,var_08))
		{
			if(isdefined(var_0A.state))
			{
				if(isdefined(param_00.height) || !issubstr(var_0A.type,"exposed") && node_is_exposed(var_0A.origin + (0,0,32) + anglestoforward(var_0A.angles) * 64,var_0A))
				{
					if(var_0A.state == "linked")
					{
						var_0A disconnect_node();
					}

					level._mb.nodes = common_scripts\utility::array_remove(level._mb.nodes,var_0A);
					var_0A.state = undefined;
					continue;
				}

				if(var_0A.state == "unlinked")
				{
					var_0A connect_node();
				}
			}
		}
	}

	self delete();
}

//Function Number: 30
connect_node()
{
	self.state = "linked";
	self connectnode();
}

//Function Number: 31
disconnect_node(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00)
	{
		self.state = "unlinked";
	}
	else
	{
		self.state = "disabled";
	}

	self disconnectnode();
	if(isdefined(self.owner) && !isplayer(self.owner))
	{
		self.owner maps\captured_mech::go_to_vol();
	}
}

//Function Number: 32
node_is_exposed(param_00,param_01)
{
	if(param_01.type == "Cover Multi")
	{
		foreach(var_03 in ["Cover Left","Cover Right"])
		{
			if(isdefined(param_01.offset))
			{
				param_01.offset = undefined;
			}

			if(!sighttracepassed(param_01.origin + animscripts\utility::getnodeoffset(param_01,var_03),param_00,0,undefined))
			{
				return 0;
			}
		}

		return 1;
	}

	return sighttracepassed(var_04.origin + animscripts\utility::getnodeoffset(var_04),var_03,0,undefined);
}

//Function Number: 33
mech_action_shoot()
{
	self.var_3A7 = getscriptablearray(self.target,"targetname")[0];
	self setcandamage(1);
	self setcanradiusdamage(1);
	self.var_3A7 waittill("death");
	foreach(var_01 in getnodesinradius(self.origin,self.radius,0,self.height))
	{
		var_01 disconnect_node();
	}
}

//Function Number: 34
mech_crush()
{
	self endon("exit_mech");
	level.mech_crush = [];
	var_00 = 64;
	for(;;)
	{
		if(!common_scripts\utility::flag("flag_mech_smash_active"))
		{
			foreach(var_02 in level.mech_crush)
			{
				if(var_02 death_throw(self.origin,var_00,0))
				{
					soundscripts\_snd::snd_message("aud_mech_crush_guy",var_02);
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 35
mech_victim_death_func()
{
	if(self.damagemod == "MOD_MELEE" || isdefined(self.mech_death_throw) && self.mech_death_throw)
	{
		var_00 = level.player.origin;
		var_01 = self.origin - (var_00[0],var_00[1],self.origin[2]);
		self teleport(self.origin,vectortoangles(var_01));
		self.deathanim = %death_explosion_run_f_v2;
	}

	return 0;
}

//Function Number: 36
spawnfunc_mech_crush()
{
	self.deathfunction = ::mech_victim_death_func;
	self.badplaceawareness = 1;
	self.a.disablelongdeath = 1;
	level.mech_crush = common_scripts\utility::array_add(level.mech_crush,self);
}

//Function Number: 37
death_throw(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isalive(self) || !isai(self) || isdefined(self.playingdeathanim))
	{
		if(isdefined(common_scripts\utility::array_find(level.mech_crush,self)))
		{
			level.mech_crush = common_scripts\utility::array_remove(level.mech_crush,self);
		}

		return 0;
	}

	var_03 = distance(param_00,self.origin);
	var_04 = 200;
	var_05 = level.player getvelocity();
	var_06 = length(var_05);
	var_07 = self.origin - (param_00[0],param_00[1],self.origin[2]);
	var_08 = vectordot(var_05,var_07);
	if(var_03 <= param_01)
	{
		if(!param_02 && !level.player issprinting() && var_06 < var_04 || var_08 <= 0)
		{
			return 0;
		}

		maps\_utility::anim_stopanimscripted();
		self.mech_death_throw = 1;
		self.allowdeath = 1;
		self notify("death",level.player,"MOD_MECH_CRUSH");
		self kill();
		return 1;
	}
	else if(var_03 < 200)
	{
		if(!self.ignoreall)
		{
			if(!isdefined(self.noclosemechrun) || !self.noclosemechrun)
			{
				self.ignoreall = 1;
				maps\_utility::delaythread(6,::maps\_utility::set_ignoreall,0);
			}
		}
	}

	return 0;
}

//Function Number: 38
spawn_mech_rig(param_00,param_01)
{
	self.rig = maps\_utility::spawn_anim_model("mech_player_rig",self.origin,self.angles);
	self.rig hide();
	foreach(var_03 in common_scripts\utility::array_combine(level.mechdata_left_bones,level.mechdata_right_bones))
	{
		self.rig hidepart(var_03);
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!param_00)
	{
		param_01 = 0;
	}
	else if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_00)
	{
		self playerlinktoblend(self.rig,"tag_player",param_01);
	}

	wait(param_01);
	self playerlinktodelta(self.rig,"tag_player",1,0,0,0,0,1);
}

//Function Number: 39
anim_single_mech(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	param_00 = set_array(param_00);
	if(!isdefined(param_04))
	{
		param_04 = level.player;
	}

	var_08 = isarray(param_00[0] maps\_utility::getanim(param_01));
	if(!isdefined(param_03))
	{
		if(var_08)
		{
			param_03 = 0;
		}
		else
		{
			param_03 = 1;
		}
	}

	if(param_03)
	{
		param_04._frozen_controls = 1;
		param_04 freezecontrols(1);
	}

	if(!isdefined(param_02))
	{
		iprintln("Warning: no vm_anim_index for anim_single_player() call for \'" + param_01 + "\'");
	}

	level.player forceviewmodelanimationclear();
	if(var_08)
	{
		param_04 notify("mech_anim_loop_start");
		self notify("mech_anim_loop_start");
		thread anim_loop_vm(param_04,param_02,getanimlength(param_00[0] maps\_utility::getanim(param_01)[0]));
		maps\_anim::anim_loop(param_00,param_01,undefined,param_05);
		param_04 notify("mech_anim_loop_done");
		self notify("mech_anim_loop_done");
	}
	else
	{
		param_04 notify("mech_anim_start");
		self notify("mech_anim_start");
		param_04 setviewmodelanim(param_02);
		maps\_anim::anim_single(param_00,param_01,param_05,param_06,param_07);
		param_04 notify("mech_anim_done");
		self notify("mech_anim_done");
	}

	if(param_03)
	{
		param_04 freezecontrols(0);
		param_04._frozen_controls = 0;
	}
}

//Function Number: 40
anim_loop_vm(param_00,param_01,param_02)
{
	self endon("stop_loop");
	param_00 setviewmodelanim(param_01);
	for(;;)
	{
		wait(param_02);
		param_00 setviewmodelanimtime(0);
	}
}

//Function Number: 41
mech_obj_move(param_00,param_01)
{
	if(isstring(param_00.node))
	{
		param_00.node = common_scripts\utility::getstruct(param_00.node,"targetname");
		if(!isdefined(param_00.node))
		{
			param_00.node = getent(param_00.node,"targetname");
		}
	}

	param_00.state = "none";
	param_00.current_anim = undefined;
	param_00.current_anim_vm = undefined;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(isdefined(param_00.intro_anim))
	{
		param_00.state = "intro_anim";
		self notify("intro_anim_start");
		param_00.node anim_single_mech(param_00.guys,param_00.intro_anim,param_00.intro_anim_vm);
		self notify("intro_anim_done");
		param_00.current_anim = param_00.intro_anim;
		param_00.current_anim_vm = param_00.intro_anim_vm;
	}

	var_02 = 0;
	if(isdefined(param_00.main_anims))
	{
		param_00.main_anims = set_array(param_00.main_anims);
		param_00.main_anims_vm = set_array(param_00.main_anims_vm);
		if(param_00.input_type == "mash")
		{
			if(isdefined(param_00.rev_main_anims))
			{
				param_00.rev_main_anims = set_array(param_00.rev_main_anims);
				param_00.rev_main_anims_vm = set_array(param_00.rev_main_anims_vm);
			}

			var_03 = 1;
			var_04 = undefined;
			common_scripts\utility::flag_set("hint_mash_button");
			maps\_utility::display_hint("hint_mash_button");
			self.button_mash_level = 0;
			self.button_mash_success = 2;
			thread button_mash_detection();
			for(;;)
			{
				self.button_mash_level = clamp(self.button_mash_level,0,2);
				if(self.button_mash_level >= 2)
				{
					var_03 = 1;
					if(!isdefined(var_04))
					{
						var_04 = 0;
					}
					else
					{
						var_04++;
					}
				}
				else
				{
					var_03 = 0;
				}

				if(isdefined(var_04) && var_04 == param_00.main_anims.size)
				{
					break;
				}

				var_05 = undefined;
				var_06 = undefined;
				if(isdefined(var_04))
				{
					if(!var_03)
					{
						var_05 = param_00.rev_main_anims[var_04];
						var_06 = param_00.rev_main_anims_vm[var_04];
						var_04--;
						if(var_04 < 0)
						{
							var_04 = undefined;
						}
					}
					else
					{
						var_05 = param_00.main_anims[var_04];
						var_06 = param_00.main_anims_vm[var_04];
						if(!param_01)
						{
							thread constant_quake();
						}
					}

					if(var_02)
					{
						self notify("post_intro_loop_anim_done");
						param_00.node notify("stop_loop");
						common_scripts\utility::array_thread(param_00.guys,::maps\_utility::anim_stopanimscripted);
						var_02 = 0;
					}

					param_00.state = "main_anims";
					self notify("main_anim_start" + var_05);
					soundscripts\_snd::snd_message("aud_mech_obj_move",var_05);
					param_00.node anim_single_mech(param_00.guys,var_05,var_06);
					self notify("main_anim_done" + var_05);
					thread stop_constant_quake();
					if(isdefined(param_00.rev_main_anims) && isdefined(var_04) && !isdefined(param_00.rev_main_anims[var_04]))
					{
						break;
					}

					continue;
				}

				if(isdefined(param_00.post_intro_loop_anim) && !isdefined(var_04) && !var_02)
				{
					param_00.state = "post_intro_loop_anim";
					self notify("post_intro_loop_anim_start");
					soundscripts\_snd::snd_message("aud_mech_obj_move_wait");
					param_00.node thread anim_single_mech(param_00.guys,param_00.post_intro_loop_anim,param_00.post_intro_loop_anim_vm);
					var_02 = 1;
					continue;
				}

				wait(0.05);
			}

			if(isdefined(param_00.post_main_loop_anim))
			{
				param_00.state = "post_main_loop_anim";
				self notify("post_main_loop_anim_start");
				soundscripts\_snd::snd_message("aud_mech_obj_move_wait");
				param_00.node thread anim_single_mech(param_00.guys,param_00.post_main_loop_anim,param_00.post_main_loop_anim_vm);
				if(!param_01)
				{
					thread constant_quake();
				}

				while(self.button_mash_level >= 2)
				{
					wait(0.05);
				}

				self notify("post_main_loop_anim_done");
				param_00.node notify("stop_loop");
				common_scripts\utility::array_thread(param_00.guys,::maps\_utility::anim_stopanimscripted);
			}
		}
		else if(param_00.input_type == "push_forward" || param_00.input_type == "pull_back")
		{
			thread add_idle_control(param_00,param_01);
			if(isdefined(param_00.post_intro_loop_anim) && !var_02)
			{
				param_00.state = "post_intro_loop_anim";
				self notify("post_intro_loop_anim_start");
				param_00.node thread anim_single_mech(param_00.guys,param_00.post_intro_loop_anim,param_00.post_intro_loop_anim_vm);
				self waittill("input_success");
				self notify("post_intro_loop_anim_done");
				param_00.node notify("stop_loop");
				common_scripts\utility::array_thread(param_00.guys,::maps\_utility::anim_stopanimscripted);
				var_02 = 0;
			}

			param_00.state = "main_anims";
			for(var_07 = 0;var_07 < param_00.main_anims.size;var_07++)
			{
				param_00.current_anim = param_00.main_anims[var_07];
				param_00.current_anim_vm = param_00.main_anims_vm[var_07];
				param_00.node anim_single_mech(param_00.guys,param_00.main_anims[var_07],param_00.main_anims_vm[var_07],0);
			}

			self notify("stop_add_idle_control");
			common_scripts\utility::flag_clear("hint_" + param_00.input_type);
		}
		else
		{
		}
	}

	thread stop_constant_quake();
	if(isdefined(param_00.exit_anim))
	{
		param_00.state = "exit_anim";
		self notify("exit_anim_start");
		soundscripts\_snd::snd_message("aud_mech_obj_move_end");
		param_00.node anim_single_mech(param_00.guys,param_00.exit_anim,param_00.exit_anim_vm);
		self notify("exit_anim_done");
	}

	self unlink();
	self.rig delete();
}

//Function Number: 42
constant_quake()
{
	self endon("stop_quake");
	for(;;)
	{
		earthquake(0.5,0.05,self.origin,128);
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 43
stop_constant_quake()
{
	self notify("stop_quake");
}

//Function Number: 44
add_idle_control(param_00,param_01)
{
	self endon("stop_add_idle_control");
	var_02 = 0;
	var_03 = 0;
	common_scripts\utility::flag_set("hint_" + param_00.input_type);
	maps\_utility::display_hint("hint_" + param_00.input_type);
	for(;;)
	{
		var_03 = 0;
		if(param_00.input_type == "push_forward")
		{
			if(self getnormalizedmovement()[0] > 0)
			{
				var_03 = 1;
			}
		}
		else if(param_00.input_type == "pull_back")
		{
			if(self getnormalizedmovement()[0] < 0)
			{
				var_03 = 1;
			}
		}

		if(var_03)
		{
			self notify("input_success");
		}

		if(param_00.state == "main_anims")
		{
			if(var_03)
			{
				if(var_02)
				{
					var_02 = 0;
					if(isdefined(param_00.main_anim_idle_vm))
					{
						self setadditiveviewmodelanim(0);
					}

					maps\_anim::anim_set_rate(param_00.guys,param_00.current_anim,1);
					self pauseviewmodelanim(0);
					if(!param_01)
					{
						thread constant_quake();
					}
				}

				common_scripts\utility::flag_clear("hint_" + param_00.input_type);
			}
			else
			{
				common_scripts\utility::flag_set("hint_" + param_00.input_type);
				maps\_utility::display_hint("hint_" + param_00.input_type);
				if(!var_02)
				{
					var_02 = 1;
					maps\_anim::anim_set_rate(param_00.guys,param_00.current_anim,0);
					self pauseviewmodelanim(1);
					if(isdefined(param_00.main_anim_idle_vm))
					{
						self setadditiveviewmodelanim(param_00.main_anim_idle_vm);
					}

					thread stop_constant_quake();
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 45
button_mash_detection()
{
	self endon("notify_stop_mash_detection");
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_01++;
		}
		else
		{
			var_01 = 0;
		}

		if(var_01 > 0 && var_01 < 20)
		{
			if(self.button_mash_level < self.button_mash_success)
			{
				self.button_mash_level = self.button_mash_level + 1;
			}

			var_00 = 0;
			var_01++;
		}
		else
		{
			var_00++;
			if(var_00 >= 4 && self.button_mash_level > 0)
			{
				self.button_mash_level = self.button_mash_level - 1;
			}
		}

		wait(0.05);
	}
}

//Function Number: 46
set_array(param_00)
{
	if(isarray(param_00))
	{
		return param_00;
	}

	return [param_00];
}

//Function Number: 47
disable_threat_ping()
{
	common_scripts\utility::flag_clear("flag_mech_threat_paint_ping_on");
	level.allow_threat_paint = 0;
}

//Function Number: 48
enable_threat_ping()
{
	common_scripts\utility::flag_set("flag_mech_threat_paint_ping_on");
	level.allow_threat_paint = 1;
}