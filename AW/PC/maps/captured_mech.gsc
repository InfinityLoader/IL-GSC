/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_mech.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 1298 ms
 * Timestamp: 4/22/2024 2:26:25 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
	maps\captured_mech_code::pre_load();
	level.player maps\_playermech_code::playermech_init();
	common_scripts\utility::flag_init("flag_mech_enabled");
	common_scripts\utility::flag_init("flag_getting_into_mech");
	common_scripts\utility::flag_init("flag_mb1_start");
	common_scripts\utility::flag_init("flag_mb1_jump_done");
	common_scripts\utility::flag_init("flag_fallback_1");
	common_scripts\utility::flag_init("flag_fallback_2");
	common_scripts\utility::flag_init("hint_weap_swarm_hold");
	common_scripts\utility::flag_init("hint_weap_swarm_release");
	common_scripts\utility::flag_init("flag_mb2_end");
	common_scripts\utility::flag_init("flag_mb2_mech_stencil_on");
	common_scripts\utility::flag_init("flag_mb2_mech_smashing_doors");
	common_scripts\utility::flag_init("flag_mb2_mechs_dead");
	common_scripts\utility::flag_init("lgt_flag_mech_entered");
	common_scripts\utility::flag_init("flag_final_vo");
	maps\_utility::add_hint_string("hint_mech_start","Press ^3[{+activate}]^7 to Enter Mech",::hint_mech_start);
	maps\_utility::add_hint_string("hint_mech_grab","Press ^3[{+activate}]^7 to Grab Object",::hint_mech_grab);
	maps\_utility::add_hint_string("hint_weap_swarm_hold","Hold ^3[{+smoke}]^7 lock targets.",::hint_weap_swarm_hold);
	maps\_utility::add_hint_string("hint_weap_swarm_release","Release ^3[{+smoke}]^7 to fire swarm missiles.",::hint_weap_swarm_release);
	maps\_utility::add_hint_string("hint_weap_rocket","Press ^3[{+frag}]^7 to fire rockets",::hint_weap);
	maps\_utility::add_hint_string("hint_weap_gun","Press ^3[{+attack}]^7 to fire main gun",::hint_weap);
}

//Function Number: 2
post_load()
{
	level._mb = spawnstruct();
	level._mb.civilians = [];
	level._mb.enemies = [];
	level._mb.trigs = [];
	level._mb.nodes = [];
	level.enemy_run_nodes = [];
	level.civ_run_nodes = [];
	level.vehicle_death_fx_override["script_vehicle_vrap"] = 1;
	level.vehicle_death_fx["script_vehicle_vrap"] = [];
	level.vehicle_death_fx["script_vehicle_vrap"][0] = maps\_vehicle::build_fx("vfx/map/captured/cap_vrap_destro","TAG_DEATH_FX");
	if(isdefined(common_scripts\utility::getstruct("struct_playerstart_mb1","targetname")))
	{
		spawnfunc_mb();
		level._mb.run_nodes1 = getnodearray("node_mb1_run","script_noteworthy");
		level._mb.exit_run_nodes1 = getnodearray("node_exit_run1","script_noteworthy");
		level._mb.exit_run_nodes2 = getnodearray("node_exit_run2","script_noteworthy");
		level._mb.exit_run_nodes_enemy = getnodearray("node_mb2_run_enemy","script_noteworthy");
		level.enemy_run_nodes = level._mb.run_nodes1;
		level.civ_run_nodes = level._mb.run_nodes1;
		level._mb.intro_node = common_scripts\utility::getstruct("struct_mb1_introwall_smash","targetname") common_scripts\utility::spawn_tag_origin();
		level._mb.slide_gate_right = getent("brush_mb2_gate_right","targetname");
		level._mb.slide_gate_left = getent("brush_mb2_gate_left","targetname");
		level._mb.slide_gate_destroyed = getentarray("brush_mb2_gate_destroyed","targetname");
		common_scripts\utility::array_call(level._mb.slide_gate_destroyed,::hide);
		level._mb.lifts = sortbydistance(getentarray("origin_mb2_lift","script_noteworthy"),common_scripts\utility::getstruct("struct_mb2_lift_order","targetname").origin);
		foreach(var_01 in level._mb.lifts)
		{
			common_scripts\utility::array_call(getentarray(var_01.target,"targetname"),::linkto,var_01);
			var_01.fx = [];
			foreach(var_03 in common_scripts\utility::getstructarray(var_01.target,"targetname"))
			{
				if(var_03.script_parameters == "top")
				{
					var_01.goal = var_03;
					continue;
				}

				if(var_03.script_parameters == "fx")
				{
					var_01.fx = common_scripts\utility::array_add(var_01.fx,var_03);
				}
			}
		}
	}
	else
	{
		iprintln("Warning: Mech Battle start point missing.  Compiled out?");
	}

	setignoremegroup("team3","allies");
	setignoremegroup("allies","team3");
}

//Function Number: 3
hint_mech_start()
{
	return !common_scripts\utility::flag("hint_mech_start");
}

//Function Number: 4
hint_mech_grab()
{
	return !common_scripts\utility::flag("hint_mech_grab");
}

//Function Number: 5
hint_weap()
{
	return 0;
}

//Function Number: 6
hint_weap_swarm_hold()
{
	return common_scripts\utility::flag("hint_weap_swarm_hold");
}

//Function Number: 7
hint_weap_swarm_release()
{
	return common_scripts\utility::flag("hint_weap_swarm_release");
}

//Function Number: 8
start(param_00,param_01)
{
	level.player maps\captured_util::warp_to_start(param_00);
	level.allies maps\captured_util::warp_allies(param_01,1);
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	if(level.start_point != "mb1_intro")
	{
		mb_setup();
		level.allies[0] hudoutlineenable(3,1);
	}

	if(level.start_point == "mb1_jump")
	{
		thread maps\_playermech_code::playermech_start("base_noweap");
	}
	else if(level.start_point == "mb1")
	{
		common_scripts\utility::flag_set("flag_mb1_start");
		common_scripts\utility::flag_set("flag_mb1_jump_done");
		level._mb.intro_node maps\_utility::delaythread(0.05,::ai_mb1_jumpdown_guards,1);
	}
	else if(issubstr(level.start_point,"mb2"))
	{
		common_scripts\utility::array_call(getentarray("trig_mb1","script_noteworthy"),::delete);
		if(issubstr(level.start_point,"mb2_gatesmash"))
		{
			thread maps\_playermech_code::playermech_start("base");
		}
		else
		{
			thread ambient_mb2_cranes();
			level._mb.slide_gate_right connectpaths();
			level._mb.slide_gate_left connectpaths();
			level._mb.slide_gate_right delete();
			level._mb.slide_gate_left delete();
			common_scripts\utility::array_call(level._mb.slide_gate_destroyed,::show);
			level.allies maps\captured_util::warp_allies("struct_allystart_mb2_gate",1);
			maps\_utility::activate_trigger_with_targetname("trig_mb2_ally_1_half");
			thread maps\_playermech_code::playermech_start("base");
		}
	}

	common_scripts\utility::flag_set("flag_battle_to_heli_end");
}

//Function Number: 9
mb_setup()
{
	if(isdefined(level._mb.mb_setup))
	{
		return;
	}

	level.player thread maps\captured_mech_code::init_mech_actions();
	level._mb.mb_setup = 1;
	if(maps\captured_util::start_point_is_before("mb1_mech",1))
	{
		level._mb.node = common_scripts\utility::getstruct("struct_exfil_mechstart","targetname");
		level._mb.suit["top"] = maps\_utility::spawn_anim_model("mech_suit_top");
		level._mb.suit["bottom"] = maps\_utility::spawn_anim_model("mech_suit_bottom");
		level._mb.suit["handle"] = maps\_utility::spawn_anim_model("mech_handle");
		level._mb.debris = maps\_utility::spawn_anim_model("debris");
		level._mb.rocks = maps\_utility::spawn_anim_model("rocks");
		level._mb.dead_mech_enemy = getent("actor_player_mech","targetname");
		level._mb.dead_mech_enemy attach("npc_exo_armor_atlas_head_captured");
		level._mb.dead_mech_enemy maps\_utility::assign_animtree("mech_opfor");
	}
	else if(maps\captured_util::start_point_is_after("mb1",1))
	{
		getent("actor_player_mech","targetname") delete();
		common_scripts\utility::flag_set("flag_mech_vo_active");
	}

	var_00 = [];
	foreach(var_02 in getentarray("mb1_nostencil","script_noteworthy"))
	{
		var_00 = common_scripts\utility::array_add(var_00,var_02 maps\_utility::spawn_vehicle());
	}

	if(maps\captured_util::start_point_is_before("mb1_jump",1))
	{
		level.player maps\_playermech_code::disable_stencil(var_00);
	}

	common_scripts\utility::create_dvar("quickmech","0");
	if(maps\captured_util::start_point_is_before("mb1",1))
	{
		level.player enableinvulnerability();
		level.allies maps\captured_util::warp_allies("struct_allystart_mb1",1);
		level.ally maps\captured_util::ignore_everything();
		maps\_utility::activate_trigger_with_targetname("trig_mb_ally_1");
		setup_vols(getentarray("vol_mb1","script_noteworthy"));
	}

	wait(0.05);
	if(!isdefined(level.ally.magic_bullet_shield) || !level.ally.magic_bullet_shield)
	{
		level.ally maps\_utility::magic_bullet_shield();
	}
}

//Function Number: 10
main_mb1_intro()
{
	mb_setup();
	var_00 = level._mb.node common_scripts\utility::spawn_tag_origin();
	level.ally.anim_node = level._mb.node common_scripts\utility::spawn_tag_origin();
	level.player.rig = maps\_utility::spawn_anim_model("player_rig");
	level.player freezecontrols(1);
	level.player disableweapons();
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player playerlinktoabsolute(level.player.rig,"tag_player");
	level.player.rig show();
	soundscripts\_snd::snd_message("aud_wakeup_mix");
	thread maps\captured_fx::fx_heli_crash_godrays_on();
	level.player common_scripts\utility::delaycall(17.5,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(18.4,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(19.3,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(20.6,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(21.5,::playrumbleonentity,"heavy_1s");
	var_01 = getent("mech_intro_feet","targetname");
	var_01 hide();
	level notify("anim_mech_wakeup");
	level.ally.anim_node thread ai_ally_mb_intro_anim();
	var_02 = getent("model_warbird_rotor","targetname");
	var_02 maps\_utility::assign_animtree("warbird_rotor");
	level._mb.node thread maps\_anim::anim_single(common_scripts\utility::array_combine(level._mb.suit,[level._mb.dead_mech_enemy,level._mb.debris,level._mb.rocks,var_02]),"anim_mech_wakeup");
	var_00 maps\_anim::anim_single_solo(level.player.rig,"anim_mech_wakeup");
	thread maps\captured_fx::fx_heli_crash_godrays_off();
	var_01 show();
	soundscripts\_snd::snd_message("aud_wakeup_mech_cooldown_pings");
	setsaveddvar("g_friendlyNameDist",level.friendlynamedist);
	level.player freezecontrols(0);
	level.player.rig hide();
	level.player maps\_utility::blend_movespeedscale(0.2);
	level.player maps\_utility::blend_movespeedscale(0.5,6);
	level.player allowjump(1);
	level.player allowmelee(1);
	level.player allowsprint(1);
	level.player unlink();
	level.player.rig delete();
	var_00 delete();
}

//Function Number: 11
main_mb1_mech()
{
	level.player.rig = maps\_utility::spawn_anim_model("player_rig_temp");
	level.player.rig hide();
	level._mb.node maps\_anim::anim_first_frame(common_scripts\utility::array_combine(level._mb.suit,[level._mb.dead_mech_enemy,level.player.rig]),"mech_enter");
	var_00 = common_scripts\utility::getstruct("struct_prompt_mechenter","targetname");
	var_01 = spawn("script_origin",var_00.origin);
	var_01 makeusable();
	thread dialogue_mb1_intro();
	thread maps\captured_actions::mech_entry_action();
	level notify("objective_player_can_get_into_mech");
	var_02 = getdvar("mechCrouchtime");
	setsaveddvar("mechCrouchtime",3000);
	var_01 maps\_utility::addhinttrigger(&"CAPTURED_HINT_ENTER_CONSOLE",&"CAPTURED_HINT_ENTER_PC");
	var_01 thread maps\captured_actions::prompt_show_hide("flag_waittill_entity_activate_looking_at","captured_action_complete");
	maps\captured_util::waittill_entity_activate_looking_at(level._mb.dead_mech_enemy,undefined,undefined,72,0.4,0);
	common_scripts\utility::flag_set("flag_getting_into_mech");
	var_03 = getent("mech_intro_feet","targetname");
	var_03 hide();
	level.player common_scripts\utility::delaycall(17.5,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(19.55,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(21.05,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(22.75,::playrumbleonentity,"heavy_1s");
	level notify("captured_action_complete");
	level.player setstance("stand");
	var_01 delete();
	if(isdefined(level.ally.anim_node))
	{
		level.ally.anim_node maps\_utility::anim_stopanimscripted();
		level.ally.anim_node delete();
	}

	level.player maps\_utility::blend_movespeedscale(1);
	level.player notify("stop_one_handed_gunplay");
	common_scripts\utility::array_call(getentarray("opfor_bh_helo","targetname"),::delete);
	common_scripts\utility::array_call(getaiarray("axis","neutral","team3"),::delete);
	level.player event_mb1_climb_in_mech();
	level.player.rig delete();
	setsaveddvar("mechCrouchtime",var_02);
	var_04 = getent("mech_intro_blocker","targetname");
	var_04 delete();
	var_03 delete();
	common_scripts\utility::flag_set("lgt_flag_mech_entered");
}

//Function Number: 12
main_mb1_jump()
{
	level.player allowmelee(0);
	if(isdefined(level._mb.suit))
	{
		foreach(var_01 in level._mb.suit)
		{
			var_01 delete();
		}
	}

	thread dialogue_mb1_jumpdown();
	level.player event_mb1_jumpdown();
}

//Function Number: 13
main_mb1()
{
	common_scripts\utility::flag_wait("flag_mb1_start");
	thread ai_mb1();
	thread ambient_mb1_crane();
	thread dialogue_mb1();
	level.player thread event_mb1_weapons_come_online();
	common_scripts\utility::flag_wait("flag_mb1_end");
}

//Function Number: 14
main_mb2_gatesmash()
{
	thread ai_mb2_gate();
	thread dialogue_mb2_gatesmash();
	level.player thread event_mb2_gatesmash();
	common_scripts\utility::flag_wait("flag_mb2_mech_smashing_doors");
	thread ambient_mb2_cranes();
	if(distance(level.ally.origin,level.player.origin) > 512)
	{
		level.ally maps\captured_util::warp_to_start("struct_allywarp_mb2");
	}
}

//Function Number: 15
main_mb2()
{
	thread ai_mb2();
	thread dialogue_mb2();
	thread ambient_mb2_tanks();
	common_scripts\utility::flag_wait("flag_mb2_gateclose");
	level._exit.gate_inner.col disconnectpaths();
	soundscripts\_snd::snd_message("scn_cap_mech_door_closes");
	level._exit.node maps\_anim::anim_single([level._exit.gate_inner,level._exit.lock],"anim_exit_gateclose");
	common_scripts\utility::flag_wait("flag_mb2_end");
}

//Function Number: 16
ai_ally_mb_intro_anim()
{
	level endon("captured_action_complete");
	maps\_anim::anim_single_solo(level.ally,"anim_mech_wakeup");
	thread maps\_anim::anim_loop_solo(level.ally,"anim_mech_wakeup_exit_loop");
}

//Function Number: 17
ai_mb1()
{
	setignoremegroup("team3","axis");
	setignoremegroup("team3","allies");
	setignoremegroup("allies","team3");
	maps\_utility::delaythread(1,::common_scripts\utility::array_thread,getentarray("vehicle_mb1_truck_1","targetname"),::maps\_vehicle::spawn_vehicle_and_gopath);
	thread ai_mb1_drones();
	common_scripts\utility::array_thread(getentarray("trig_mb1_retreat","script_noteworthy"),::ai_special_retreat_watcher,"enemy_mb1_foot","flag_mb1_end");
	level thread retreat_watcher("enemy_mb1_foot","flag_mb1_fallback_idx0","flag_mb1_end",0,1);
	level thread retreat_watcher("enemy_mb1_foot","flag_mb1_fallback_idx1","flag_mb1_end",1,2,"trig_mb_ally_2");
	level thread retreat_watcher("enemy_mb1_foot","flag_mb1_fallback_idx2","flag_mb1_end",2,3);
	level thread retreat_watcher("enemy_mb1_foot","flag_mb1_fallback_idx3","flag_mb1_end",3,4,"trig_mb_ally_3");
	level thread retreat_watcher("enemy_mb1_foot","flag_mb1_fallback_idx4","flag_mb1_end",4,undefined,"trig_mb_ally_4");
	common_scripts\utility::flag_wait("flag_mb1_mech_closemove");
	retreat_group("enemy_mb1_close");
	foreach(var_01 in level._mb.enemies["enemy_mb1_close"])
	{
		var_01 add_to_group_enemy("enemy_mb1_foot");
	}

	level._mb.enemies["enemy_mb1_close"] = [];
	level.ally maps\_utility::enable_ai_color();
	level.ally maps\captured_util::unignore_everything();
	level.ally.ignoreme = 1;
	level.ally.badplaceawareness = 0;
	maps\_utility::delaythread(1,::maps\_utility::activate_trigger_with_noteworthy,"trig_mb1_enemyflood");
	common_scripts\utility::flag_wait("flag_mb1_fallback_idx0");
	maps\_utility::activate_trigger_with_noteworthy("trig_mb2_civflood_1");
	common_scripts\utility::flag_wait("flag_mb1_fallback_idx1");
	thread ai_mb1_allywarp();
	maps\_utility::activate_trigger_with_targetname("trig_mb_enemy_towers");
	common_scripts\utility::flag_wait("flag_mb1_fallback_idx3");
	thread ai_mb1_script_end();
	common_scripts\utility::flag_wait("flag_mb1_end");
	level.enemy_run_nodes = level._mb.run_nodes1;
	level.civ_run_nodes = level._mb.run_nodes1;
	if(isdefined(level._mb.enemies["enemy_mb1_tower"]))
	{
		foreach(var_04 in level._mb.enemies["enemy_mb1_tower"])
		{
			if(!isalive(var_04))
			{
				continue;
			}

			var_04 setengagementmindist(512,512);
			var_04 maps\_utility::set_baseaccuracy(0.7);
			var_04 thread maps\captured_mech_code::spawnfunc_mech_crush();
		}
	}

	var_06 = getent("vol_mb2_civrun","targetname");
	foreach(var_08 in level._mb.civilians)
	{
		foreach(var_04 in var_08)
		{
			if(isalive(var_04) && var_04 istouching(var_06))
			{
				var_04 mb_run_to_goal();
			}
		}
	}

	thread maps\_spawner::killspawner(50);
	thread maps\_spawner::killspawner(51);
	if(isdefined(level._mb.enemies["enemy_mb1_foot"]))
	{
		common_scripts\utility::array_thread(level._mb.enemies["enemy_mb1_foot"],::mb_run_to_goal);
	}

	if(isdefined(level._mb.enemies["enemy_mb1_tower"]))
	{
		common_scripts\utility::array_thread(level._mb.enemies["enemy_mb1_tower"],::mb_run_to_goal);
	}

	thread maps\_utility::ai_delete_when_out_of_sight(level._mb.enemies["enemy_mb1_foot"],768);
}

//Function Number: 18
ai_special_retreat_watcher(param_00,param_01)
{
	level endon(param_01);
	self endon("stop_special_retreat_watcher");
	var_02 = getentarray(self.target,"targetname");
	self waittill("trigger");
	if(isdefined(var_02))
	{
		var_02 = common_scripts\utility::array_removeundefined(var_02);
		foreach(var_04 in var_02)
		{
			if(var_04.disabled)
			{
				var_04 enable_vol();
				continue;
			}

			var_04 disable_vol();
		}
	}

	if(isdefined(self.radius))
	{
		badplace_cylinder("temp_badplace",10,self.origin,self.radius,128,"axis");
	}

	retreat_group(param_00);
}

//Function Number: 19
ai_mb1_script_end()
{
	level endon("flag_mb1_end");
	while(!isdefined(level._mb.enemies["enemy_mb1_foot"]) || maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb1_foot"]).size > 0)
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("flag_mb1_end");
}

//Function Number: 20
ai_mb1_allywarp()
{
	level endon("flag_mb2_mech_smashing_doors");
	var_00 = common_scripts\utility::getstruct("struct_playerstart_mb1","targetname");
	while(level.player player_can_see(level.ally,var_00.origin,0.5))
	{
		wait(1);
	}

	level.ally maps\captured_util::warp_to_start("struct_playerstart_mb1");
}

//Function Number: 21
ai_mb1_jumpdown_guards(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = getentarray("enemy_mb1_wallsmash_intro","targetname");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_02[var_03] = var_01[var_03] maps\_utility::spawn_ai();
		var_02[var_03].animname = "mb1_introwall_guard" + var_03 + 1;
		var_02[var_03] maps\captured_util::ignore_everything();
		var_02[var_03] thread ai_mb1_first_guard_fallback(self);
	}

	if(!param_00)
	{
		wait(5);
	}

	maps\_utility::activate_trigger_with_targetname("trig_mb1_enemyspawn_1");
	wait(0.05);
	common_scripts\utility::array_thread(level._mb.enemies["enemy_mb1_foot"],::go_to_vol,1);
	if(!param_00)
	{
		self waittill("mech_anim_done");
		return;
	}

	wait(0.1);
	maps\_utility::anim_stopanimscripted();
	common_scripts\utility::array_thread(var_02,::maps\_utility::anim_stopanimscripted);
}

//Function Number: 22
ai_mb1_first_guard_fallback(param_00)
{
	self endon("death");
	param_00 maps\_anim::anim_single_solo(self,"anim_mb1_introwall_smash");
	add_to_group_enemy("enemy_mb1_foot");
	if(self.script_parameters != "intro_runner")
	{
		maps\captured_util::unignore_everything(1);
		common_scripts\utility::flag_wait_or_timeout("flag_mb1_mech_firstmove",randomfloatrange(1,3));
	}

	self.script_parameters = undefined;
	go_to_vol(1);
	self waittill("goal");
	maps\captured_util::unignore_everything(1);
}

//Function Number: 23
ai_mb1_drones()
{
	var_00 = 2;
	level._mb.drone_paths = "struct_mb1_drone2";
	common_scripts\utility::flag_wait("flag_mb1_mech_closemove");
	level._mb.drone_paths = "struct_mb1_drone3";
	level notify("drone_retreat");
	var_01 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vehicle_mb1_drone1");
	common_scripts\utility::flag_wait("flag_mb1_fallback_idx1");
	level._mb.drone_paths = "struct_mb1_drone4";
	level notify("drone_retreat");
	var_01 = maps\_utility::remove_dead_from_array(var_01);
	var_02 = getentarray("vehicle_mb1_drone3","targetname");
	if(var_01.size < var_00)
	{
		for(var_03 = var_01.size;var_03 < var_00;var_03++)
		{
			var_01 = common_scripts\utility::array_add(var_01,var_02[var_03] maps\_vehicle::spawn_vehicle_and_gopath());
		}
	}

	common_scripts\utility::flag_wait("flag_mb1_fallback_idx3");
	level._mb.drone_paths = "struct_mb1_drone5";
	level notify("drone_retreat");
	common_scripts\utility::flag_wait("flag_mb1_end");
	level notify("drone_retreat_final");
	var_01 = maps\_utility::remove_dead_from_array(var_01);
	foreach(var_05 in var_01)
	{
		var_05.script_vehicle_selfremove = 1;
		var_05 dronepath("struct_mb1_drone_exit");
	}
}

//Function Number: 24
ai_mb2_drones()
{
	level._mb.drone_paths = "struct_mb2_drone1";
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vehicle_mb2_drone");
	common_scripts\utility::flag_wait("flag_mb2_fallback_idx5");
	level._mb.drone_paths = "struct_mb2_drone2";
	level notify("drone_retreat");
	common_scripts\utility::flag_wait("flag_mb2_end");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	common_scripts\utility::array_thread(var_00,::drone_exit);
}

//Function Number: 25
drone_exit()
{
	self endon("death");
	while(!self.at_start)
	{
		wait(0.05);
	}

	self.script_vehicle_selfremove = 1;
	dronepath("struct_mb2_drone_exit");
}

//Function Number: 26
ai_mb2_gate()
{
	level.ally maps\_utility::enable_ai_color();
	maps\_utility::activate_trigger_with_targetname("trig_mb2_ally_1");
	level.player waittill("intro_anim_start");
	level.ally maps\captured_util::ignore_everything();
	level.ally.badplaceawareness = 0;
	thread maps\_spawner::killspawner(52);
	if(isdefined(level._mb.enemies["enemy_mb1_foot"]))
	{
		common_scripts\utility::array_call(maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb1_foot"]),::delete);
	}

	foreach(var_01 in level._mb.civilians)
	{
		common_scripts\utility::array_call(maps\_utility::remove_dead_from_array(var_01),::delete);
	}

	level.player waittill("exit_anim_done");
	level.ally maps\captured_util::unignore_everything();
}

//Function Number: 27
ai_mb2()
{
	level.ally maps\_utility::enable_ai_color();
	level.ally.ignoreme = 1;
	level.ally.badplaceawareness = 0;
	setup_vols(getentarray("vol_mb2","script_noteworthy"));
	level thread retreat_watcher("enemy_mb2_foot","flag_mb2_fallback_idx0","flag_mb2_mech_spawn");
	level thread retreat_watcher("enemy_mb2_foot","flag_mb2_fallback_idx1","flag_mb2_mech_spawn",0,1);
	level thread retreat_watcher("enemy_mb2_foot","flag_mb2_fallback_idx2","flag_mb2_end",1,2,"trig_mb2_ally_1_half");
	level thread retreat_watcher("enemy_mb2_foot","flag_mb2_fallback_idx3","flag_mb2_end",2,undefined,"trig_mb2_ally_2");
	level thread retreat_watcher(undefined,"flag_mb2_fallback_idx4","flag_mb2_end",undefined,undefined,"trig_mb2_ally_3");
	level thread retreat_watcher(undefined,"flag_mb2_fallback_idx5","flag_mb2_end",undefined,undefined,"trig_mb2_ally_4");
	maps\_utility::activate_trigger_with_targetname("trig_mb2_ally_1_half");
	level._mb.mb2_max_enemies = 20;
	maps\_utility::activate_trigger_with_noteworthy("trig_mb2_enemyflood");
	maps\_utility::activate_trigger_with_targetname("trig_mb2_enemy_start");
	level.civ_run_nodes = level._mb.exit_run_nodes1;
	level.enemy_run_nodes = level._mb.exit_run_nodes_enemy;
	maps\_utility::activate_trigger_with_noteworthy("trig_mb2_civflood_2");
	common_scripts\utility::flag_wait_or_timeout("flag_mb2_fallback_idx0",2);
	common_scripts\utility::flag_set("flag_mb2_fallback_idx0");
	maps\_utility::delaythread(0.05,::common_scripts\utility::flag_clear,"flag_mb2_fallback_idx0");
	common_scripts\utility::flag_wait("flag_mb2_fallback_idx2");
	level._mb.mb2_max_enemies = 10;
	common_scripts\utility::flag_wait_or_timeout("flag_mb2_mech_spawn",8);
	maps\_utility::activate_trigger_with_targetname("trig_mb2_enemy_mechs");
	thread soundscripts\_snd::snd_message("aud_warehouse_mech_lift_alarm");
	thread soundscripts\_snd::snd_message("aud_warehouse_mech_lift_vo");
	thread ai_mb2_remove_stencils();
	thread ai_mb2_mech_watcher();
	thread ai_mb2_enemies_run();
	common_scripts\utility::flag_wait_either("flag_mb2_fallback_idx4","flag_mb2_mechs_dead");
	maps\_utility::activate_trigger_with_targetname("trig_mb2_enemy_drivein");
	thread ai_mb2_drones();
	thread ai_mb2_script_end();
	common_scripts\utility::flag_wait("flag_mb2_gateclose");
	level.civ_run_nodes = level._mb.exit_run_nodes_enemy;
	foreach(var_01 in level._mb.civilians)
	{
		common_scripts\utility::array_thread(var_01,::mb_run_to_goal);
	}
}

//Function Number: 28
ai_mb2_enemies_run()
{
	common_scripts\utility::flag_wait_either("flag_mb2_mechs_dead","flag_mb2_fallback_idx5");
	common_scripts\utility::array_thread(maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_foot"]),::ai_mb2_enemyrun);
	thread maps\_utility::ai_delete_when_out_of_sight(level._mb.enemies["enemy_mb2_foot"],768);
}

//Function Number: 29
ai_mb2_script_end()
{
	while(!isdefined(level._mb.enemies["enemy_mb2_mech"]) || maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_mech"]).size > 0)
	{
		wait(0.05);
	}

	while(!isdefined(level._mb.enemies["enemy_mb2_foot"]) || maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_foot"]).size > 0)
	{
		wait(0.05);
	}

	while(!isdefined(level._mb.enemies["enemy_mb2_final"]) || maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_final"]).size > 2)
	{
		wait(0.05);
	}

	common_scripts\utility::array_thread(maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_final"]),::ai_mb2_enemyrun,1,1);
	thread maps\_utility::ai_delete_when_out_of_sight(level._mb.enemies["enemy_mb2_final"],768);
	wait(3);
	common_scripts\utility::flag_set("flag_mb2_gateclose");
	common_scripts\utility::flag_set("flag_mb2_end");
}

//Function Number: 30
ai_mb2_mech_watcher()
{
	var_00 = 1;
	var_01 = [];
	while(!isdefined(level._mb.enemies["enemy_mb2_mech"]) || level._mb.enemies["enemy_mb2_mech"].size < 4)
	{
		wait(0.05);
	}

	for(;;)
	{
		while(maps\_utility::remove_dead_from_array(var_01).size == var_00)
		{
			wait(1);
		}

		var_02 = maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_mech"]);
		if(var_02.size == 0)
		{
			break;
		}

		foreach(var_04 in sortbydistance(var_02,level.player.origin))
		{
			if(isalive(var_04) && !isdefined(common_scripts\utility::array_find(var_01,var_04)))
			{
				var_01 = common_scripts\utility::array_add(var_01,var_04);
				var_04 maps\_utility::set_fixednode_false();
				var_04 maps\_mech::mech_start_hunting();
				break;
			}
		}
	}

	common_scripts\utility::flag_set("flag_mb2_mechs_dead");
}

//Function Number: 31
ai_mb2_remove_stencils()
{
	common_scripts\utility::flag_wait("flag_mb2_mech_stencil_on");
	level.player maps\_playermech_code::disable_stencil(maps\_utility::remove_dead_from_array(level._mb.enemies["enemy_mb2_foot"]));
}

//Function Number: 32
ai_mb2_enemyrun(param_00,param_01)
{
	if(isdefined(param_01) && param_01)
	{
		self.nounignore = 1;
	}

	self endon("death");
	wait(randomfloatrange(0,4));
	mb_run_to_goal();
	if(isdefined(param_00) && param_00)
	{
		maps\_utility::delaythread(randomfloatrange(0,3),::maps\captured_util::ignore_everything);
	}
}

//Function Number: 33
spawnfunc_mb()
{
	maps\_utility::array_spawn_function_noteworthy("civ_mb1_foot",::spawnfunc_mb_civilians);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb1_close",::spawnfunc_mb_enemies);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb1_intro",::spawnfunc_mb_enemies);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb1_foot",::spawnfunc_mb_enemies);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb1_tower",::spawnfunc_mb1_tower);
	maps\_utility::array_spawn_function_noteworthy("vehicle_mb1_drone",::spawnfunc_mb_drone);
	maps\_utility::array_spawn_function_noteworthy("vehicle_mb1_vrap",::spawnfunc_mb1_vrap);
	maps\_utility::array_spawn_function_noteworthy("civ_mb2_foot",::spawnfunc_mb_civilians);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb2_foot",::spawnfunc_mb_enemies);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb2_final",::spawnfunc_mb2_final);
	maps\_utility::array_spawn_function_noteworthy("enemy_mb2_mech",::spawnfunc_mb2_mech);
	maps\_utility::array_spawn_function_noteworthy("vehicle_mb2_drone",::spawnfunc_mb_drone);
	maps\_utility::array_spawn_function_noteworthy("vehicle_mb2_vrap",::spawnfunc_mb2_vrap);
}

//Function Number: 34
spawnfunc_mb_civilians(param_00)
{
	add_to_group_civilian(self.script_noteworthy);
	self hudoutlineenable(3,1);
	self setthreatbiasgroup("team3");
	self.no_friendly_fire_penalty = 1;
	self.a.disablelongdeath = 1;
	thread maps\captured_mech_code::spawnfunc_mech_crush();
	if(!isdefined(self.script_parameters) || self.script_parameters != "nogoal")
	{
		thread mb_run_to_goal(param_00);
	}
}

//Function Number: 35
spawnfunc_mb_enemies()
{
	self endon("death");
	add_to_group_enemy(self.script_noteworthy);
	if(common_scripts\utility::flag("flag_mb2_mech_spawn"))
	{
		level.player maps\_playermech_code::disable_stencil(self);
	}

	if(isdefined(self.ridingvehicle))
	{
		self.ridingvehicle waittill("unloaded");
	}

	if(issubstr(self.classname,"jet"))
	{
		self.canjumppath = 1;
	}

	self setengagementmindist(512,512);
	maps\_utility::set_baseaccuracy(0.7);
	self.a.disablelongdeath = 1;
	thread maps\captured_mech_code::spawnfunc_mech_crush();
	if(!isdefined(level._mb.glass_broken))
	{
		level._mb.glass_broken["glass_mb2_R_2"] = 0;
		level._mb.glass_broken["glass_mb2_L_2"] = 0;
	}

	if(isdefined(self.script_parameters) && issubstr(self.script_parameters,"glass") && !level._mb.glass_broken[self.script_parameters])
	{
		foreach(var_01 in common_scripts\utility::getstructarray(self.script_parameters,"targetname"))
		{
			magicbullet("iw5_titan45_sp",self.origin + (0,0,32),var_01.origin);
		}

		foreach(var_04 in getglassarray(self.script_parameters))
		{
			destroyglass(var_04);
		}

		level._mb.glass_broken[self.script_parameters] = 1;
	}

	if(isdefined(self.script_parameters) && issubstr(self.script_parameters,"intro"))
	{
		return;
	}

	if(isdefined(self.script_parameters) && self.script_parameters == "run_to_goal")
	{
		mb_run_to_goal(1,self.target);
		return;
	}

	go_to_vol();
	maps\captured_util::unignore_everything(1);
}

//Function Number: 36
spawnfunc_mb2_final()
{
	self endon("death");
	add_to_group_enemy(self.script_noteworthy);
	if(isdefined(self.ridingvehicle))
	{
		self.ridingvehicle waittill("unloaded");
	}

	if(issubstr(self.classname,"jet"))
	{
		self.canjumppath = 1;
	}

	self setengagementmindist(512,512);
	self.a.disablelongdeath = 1;
	thread maps\captured_mech_code::spawnfunc_mech_crush();
	self.noclosemechrun = 1;
	maps\captured_util::unignore_everything(1);
}

//Function Number: 37
spawnfunc_mb1_tower()
{
	add_to_group_enemy(self.script_noteworthy);
	if(issubstr(self.classname,"jet"))
	{
		self.canjumppath = 1;
	}

	self.a.disablelongdeath = 1;
}

//Function Number: 38
spawnfunc_mb_drone()
{
	self endon("death");
	self.at_start = 0;
	if(isdefined(self.target))
	{
		self waittill("reached_dynamic_path_end");
	}

	self.at_start = 1;
	self vehicle_setspeedimmediate(15);
	self laseron();
	dronepath(level._mb.drone_paths);
	for(;;)
	{
		level waittill("drone_retreat");
		dronepath(level._mb.drone_paths);
	}
}

//Function Number: 39
dronepath(param_00)
{
	self.path_chosen = undefined;
	var_01 = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.chosen))
		{
			var_03.chosen = 1;
			self.path_chosen = var_03;
			break;
		}
	}

	if(!isdefined(self.path_chosen))
	{
		self.path_chosen = common_scripts\utility::random(var_01);
	}

	maps\_utility::vehicle_detachfrompath();
	thread maps\_utility::vehicle_dynamicpath(self.path_chosen);
	self vehicle_setspeedimmediate(15);
}

//Function Number: 40
spawnfunc_mb1_vrap()
{
	self endon("death");
	soundscripts\_snd::snd_message("aud_mech_trucks_enter",self.script_index);
}

//Function Number: 41
spawnfunc_mb2_vrap()
{
	self endon("death");
	soundscripts\_snd::snd_message("aud_mech_trucks_enter",self.script_index);
	maps\_vehicle::godon();
	wait(5);
	maps\_vehicle::godoff();
}

//Function Number: 42
spawnfunc_mb2_mech()
{
	add_to_group_enemy(self.script_noteworthy);
	maps\captured_util::ignore_everything();
	level.player maps\_playermech_code::disable_stencil(self);
	self.a.disablelongdeath = 1;
	self.favoriteenemy = level.player;
	self.badplaceawareness = 0;
	self.script_forcegoal = 1;
	self.health = 6000;
	maps\_utility::set_baseaccuracy(3);
	var_00 = level._mb.lifts[self.script_index];
	self linkto(var_00);
	var_00 thread mb2_lift(self);
	self endon("death");
	common_scripts\utility::flag_wait("flag_mb2_mech_stencil_on");
	maps\captured_util::unignore_everything();
	level.player maps\_playermech_code::enable_stencil(self);
	var_00 waittill("lift_up");
	maps\captured_util::ignore_everything();
	self unlink();
	wait(randomintrange(1,3));
	maps\captured_util::unignore_everything();
	wait(randomintrange(1,5));
	maps\_mech::mech_start_rockets();
}

//Function Number: 43
two_mech_hunt()
{
	self endon("death");
	self endon("stop_hunting");
	self.usechokepoints = 0;
	for(;;)
	{
		wait(0.5);
		if(isdefined(self.enemy))
		{
			var_00 = undefined;
			if(isdefined(self._mech_node))
			{
				var_00 = self._mech_node;
			}

			var_01 = getnodesinradiussorted(self.enemy.origin,512,0,256,"Path");
			var_02 = undefined;
			if(!isdefined(var_01[0]._mech_occupied) || var_01[0]._mech_occupied == self)
			{
				self._mech_node = var_01[0];
			}
			else
			{
				self._mech_node = var_01[var_01.size - 1];
			}

			self._mech_node._mech_occupied = self;
			self setgoalpos(self._mech_node.origin);
			self.goalradius = 200;
			self.goalheight = 81;
			if(isdefined(var_00) && var_00 != self._mech_node)
			{
				var_00._mech_occupied = undefined;
			}
		}
	}
}

//Function Number: 44
mb2_lift(param_00)
{
	self endon("stop_lift");
	thread mb2_lift_steam();
	thread soundscripts\_snd::snd_message("aud_warehouse_mech_lift");
	if(isdefined(param_00))
	{
		thread mb2_lift_enemydeath(param_00);
	}

	var_01 = self.origin;
	self moveto(var_01 + (0,0,32),0.5,0,0.5);
	wait(0.5);
	self moveto(self.goal.origin,3);
	wait(2);
	common_scripts\utility::flag_set("flag_mb2_mech_stencil_on");
	wait(1);
	self notify("lift_up");
	wait(3);
	self moveto(var_01,3);
	wait(3);
	self notify("lift_down");
}

//Function Number: 45
mb2_lift_enemydeath(param_00)
{
	self endon("lift_down");
	self waittill("lift_up");
	if(!isalive(param_00))
	{
		self notify("stop_lift");
		return;
	}

	param_00 waittill("death");
	self notify("stop_lift");
}

//Function Number: 46
mb2_lift_steam()
{
	self endon("stop_lift");
	foreach(var_01 in self.fx)
	{
		playfx(common_scripts\utility::getfx("fx_lift_steam"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
	}

	wait(0.5);
	foreach(var_01 in self.fx)
	{
		playfx(common_scripts\utility::getfx("fx_lift_steam"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
	}

	wait(0.25);
	foreach(var_01 in self.fx)
	{
		playfx(common_scripts\utility::getfx("fx_lift_steam"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
	}
}

//Function Number: 47
deathfunc_vrap()
{
	self endon("unloaded");
	self waittill("death");
	foreach(var_01 in self.riders)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		var_01 delete();
	}
}

//Function Number: 48
deathfunc_vol()
{
	self notify("stop_deathfunc_vol");
	self endon("stop_deathfunc_vol");
	self.deathfunc_vol = 1;
	common_scripts\utility::waittill_either("death","pain_death");
	if(isdefined(self._vol) && isdefined(self._vol.counter))
	{
		self._vol.counter--;
		self._vol.ai = common_scripts\utility::array_remove(self._vol.ai,self);
	}
}

//Function Number: 49
mb_run_to_goal(param_00,param_01,param_02)
{
	if(!isalive(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = level.civ_run_nodes;
	if(issubstr(self.classname,"enemy"))
	{
		var_03 = level.enemy_run_nodes;
	}

	self notify("stop_go_to_vol");
	self notify("stop_mb_run_to_goal");
	self endon("stop_mb_run_to_goal");
	self endon("death");
	self cleargoalvolume();
	self.running_to_goal = 1;
	self.goalradius = 256;
	if(isdefined(self.nounignore) && self.nounignore)
	{
		maps\captured_util::unignore_everything(1);
	}

	var_04 = undefined;
	if(isdefined(param_01))
	{
		var_05 = [];
		var_05 = getnodearray(param_01,"targetname");
		if(var_05.size == 0)
		{
			var_05 = getentarray(param_01,"targetname");
			if(!isdefined(var_05))
			{
			}

			var_04 = undefined;
			if(param_02)
			{
				var_04 = sortbydistance(var_05,self.origin)[0];
			}
			else
			{
				var_04 = common_scripts\utility::random(var_05);
			}

			self setgoalvolumeauto(var_04);
		}
		else
		{
			var_04 = undefined;
			if(param_02)
			{
				var_04 = sortbydistance(var_05,self.origin)[0];
			}
			else
			{
				var_04 = common_scripts\utility::random(var_05);
			}

			maps\_utility::follow_path(var_04);
		}
	}
	else
	{
		var_04 = undefined;
		if(param_02)
		{
			var_04 = sortbydistance(var_03,self.origin)[0];
		}
		else
		{
			var_04 = common_scripts\utility::random(var_03);
		}

		maps\_utility::follow_path(var_04);
	}

	self.running_to_goal = undefined;
	if(isdefined(param_00) && param_00)
	{
		if(isdefined(self.nounignore) && self.nounignore)
		{
			maps\captured_util::unignore_everything();
		}

		return;
	}

	self delete();
}

//Function Number: 50
add_to_group_civilian(param_00)
{
	if(!isdefined(level._mb.civilians[param_00]))
	{
		level._mb.civilians[param_00] = [];
	}

	level._mb.civilians[param_00] = common_scripts\utility::array_add(maps\_utility::remove_dead_from_array(level._mb.civilians[param_00]),self);
	self._group = param_00;
}

//Function Number: 51
add_to_group_enemy(param_00)
{
	if(!isalive(self))
	{
		return;
	}

	if(!isdefined(level._mb.enemies[param_00]))
	{
		level._mb.enemies[param_00] = [];
	}

	level._mb.enemies[param_00] = common_scripts\utility::array_add(maps\_utility::remove_dead_from_array(level._mb.enemies[param_00]),self);
	self._group = param_00;
}

//Function Number: 52
retreat_watcher(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon(param_02);
	var_07 = getent(param_01,"targetname");
	var_08 = [];
	if(isdefined(var_07) && isdefined(var_07.target))
	{
		var_08 = getentarray(var_07.target,"targetname");
	}

	var_09 = [];
	var_0A = [];
	foreach(var_0C in level._mb.retreat_vols)
	{
		if(isdefined(var_0C.script_index))
		{
			if(isdefined(param_03) && var_0C.script_index == param_03)
			{
				var_09 = common_scripts\utility::array_add(var_09,var_0C);
			}

			if(isdefined(param_04) && var_0C.script_index == param_04)
			{
				var_0A = common_scripts\utility::array_add(var_0A,var_0C);
			}
		}
	}

	for(;;)
	{
		common_scripts\utility::flag_wait(param_01);
		if(isdefined(param_05))
		{
			maps\_utility::activate_trigger_with_targetname(param_05);
		}

		foreach(var_0F in var_08)
		{
			var_0F notify("stop_special_retreat_watcher");
		}

		var_09 = common_scripts\utility::array_removeundefined(var_09);
		common_scripts\utility::array_thread(var_09,::disable_vol);
		var_0A = common_scripts\utility::array_removeundefined(var_0A);
		common_scripts\utility::array_thread(var_0A,::enable_vol);
		if(isdefined(param_00))
		{
			retreat_group(param_00);
		}

		common_scripts\utility::flag_waitopen(param_01);
	}
}

//Function Number: 53
remove_vol_index(param_00)
{
	foreach(var_02 in level._mb.retreat_vols)
	{
		if(isdefined(var_02.script_index) && var_02.script_index == param_00)
		{
			var_02 delete();
		}
	}
}

//Function Number: 54
retreat_group(param_00,param_01)
{
	var_02 = level._mb.enemies[param_00];
	foreach(var_04 in level._mb.enemies[param_00])
	{
		if(!isdefined(var_04.running_to_goal))
		{
			var_04 maps\_utility::delaythread(randomfloatrange(0,2),::go_to_vol,0,param_01);
		}
	}
}

//Function Number: 55
go_to_vol(param_00,param_01)
{
	self notify("stop_go_to_vol");
	self endon("stop_go_to_vol");
	self endon("death");
	if(!isalive(self))
	{
		return 0;
	}

	if(isdefined(param_01))
	{
		var_02 = [];
		if(isarray(param_01))
		{
			var_02 = param_01;
		}
		else
		{
			var_02[0] = param_01;
		}

		foreach(var_04 in var_02)
		{
			if(isdefined(self.script_index) && int(self.script_index) == var_04)
			{
				return;
			}
		}
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(self.deathfunc_vol))
	{
		thread deathfunc_vol();
	}

	if(isdefined(self._vol) && isdefined(self._vol.counter))
	{
		self._vol.counter--;
		self._vol = undefined;
		wait(0.05);
	}

	if(isdefined(self.target))
	{
		self.target = undefined;
		return 0;
	}

	var_06 = [];
	var_07 = [];
	var_08 = [];
	var_06 = get_valid_vols(level._mb.priority_vols);
	if(param_00)
	{
		var_06 = sortbydistance(var_06,self.origin);
	}
	else
	{
		var_06 = sortbydistance(var_06,level.player.origin);
	}

	choose_vol(var_06);
	if(!isdefined(self._vol))
	{
		var_07 = get_valid_vols(level._mb.retreat_vols);
		if(param_00)
		{
			var_07 = sortbydistance(var_07,self.origin);
		}
		else
		{
			var_07 = sortbydistance(var_07,level.player.origin);
		}

		choose_vol(var_07);
	}

	if(!isdefined(self._vol))
	{
		var_08 = get_valid_vols(level._mb.overflow_vols);
		if(param_00)
		{
			var_08 = sortbydistance(var_08,self.origin);
		}
		else
		{
			var_08 = sortbydistance(var_08,level.player.origin);
		}

		choose_vol(var_08);
	}

	maps\_utility::set_fixednode_false();
	if(isdefined(self._vol))
	{
		self cleargoalvolume();
		maps\_spawner::go_to_node(self._vol,"entity");
		return 1;
	}

	if(isdefined(self.spawner))
	{
		self.spawner delete();
	}

	self notify("stop_deathfunc_vol");
	thread mb_run_to_goal();
	return 0;
}

//Function Number: 56
choose_vol(param_00)
{
	var_01 = distance(self.origin,level.player.origin);
	foreach(var_03 in param_00)
	{
		if(isdefined(self.script_namenumber) && isdefined(var_03.script_index))
		{
			var_04 = strtok(self.script_namenumber," ");
			if(!isdefined(common_scripts\utility::array_find(var_04,maps\_utility::string(var_03.script_index))))
			{
				continue;
			}
		}

		if(var_03.counter >= var_03.max_count)
		{
			continue;
		}

		var_03.ai = common_scripts\utility::array_add(var_03.ai,self);
		var_03.counter++;
		self._vol = var_03;
		break;
	}
}

//Function Number: 57
setup_vols(param_00)
{
	var_01 = getallnodes();
	var_02 = common_scripts\utility::spawn_tag_origin();
	if(isdefined(level._mb.retreat_vols))
	{
		common_scripts\utility::array_call(level._mb.retreat_vols,::delete);
	}

	level._mb.priority_vols = [];
	level._mb.retreat_vols = [];
	level._mb.overflow_vols = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.counter))
		{
			var_04.counter = 0;
			var_04.max_count = int(var_04.script_parameters);
			var_04.ai = [];
		}

		if(!isdefined(var_04.disabled))
		{
			if(isdefined(var_04.script_nodestate) && var_04.script_nodestate == "0")
			{
				var_04 disable_vol();
			}
			else
			{
				var_04 enable_vol();
			}
		}

		var_04.nodes = [];
		foreach(var_06 in var_01)
		{
			var_02.origin = var_06.origin;
			if(var_02 istouching(var_04))
			{
				if(issubstr(var_06.type,"Cover") || issubstr(var_06.type,"Conceal") || issubstr(var_06.type,"Exposed"))
				{
					var_04.nodes = common_scripts\utility::array_add(var_04.nodes,var_06);
				}
			}
		}

		var_04 thread vol_auto_disable();
		if(isdefined(var_04.script_namenumber))
		{
			if(issubstr(var_04.script_namenumber,"priority"))
			{
				level._mb.priority_vols = common_scripts\utility::array_add(level._mb.priority_vols,var_04);
				continue;
			}

			if(issubstr(var_04.script_namenumber,"overflow"))
			{
				level._mb.overflow_vols = common_scripts\utility::array_add(level._mb.overflow_vols,var_04);
				continue;
			}
		}

		level._mb.retreat_vols = common_scripts\utility::array_add(level._mb.retreat_vols,var_04);
	}
}

//Function Number: 58
vol_auto_disable()
{
	self notify("notify_stop_vol_auto_disable");
	self endon("notify_stop_vol_auto_disable");
	while(isdefined(self))
	{
		if(!self.disabled)
		{
			self.nodes = common_scripts\utility::array_removeundefined(self.nodes);
			var_00 = 1;
			foreach(var_02 in self.nodes)
			{
				if(isdefined(var_02.state) && var_02.state == "unlinked" || var_02.state == "disabled")
				{
					var_00 = 0;
					break;
				}
			}

			if(!var_00)
			{
				disable_vol();
			}

			continue;
		}

		common_scripts\utility::array_thread(maps\_utility::remove_dead_from_array(self.ai),::go_to_vol);
		self.ai = [];
		wait(0.1);
	}
}

//Function Number: 59
disable_vol()
{
	if(!isdefined(self))
	{
		return;
	}

	self.disabled = 1;
}

//Function Number: 60
enable_vol()
{
	if(!isdefined(self))
	{
		return;
	}

	self.disabled = 0;
}

//Function Number: 61
get_valid_vols(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04) && !var_04.disabled)
		{
			var_01 = common_scripts\utility::array_add(var_01,var_04);
		}
	}

	return var_01;
}

//Function Number: 62
event_mb1_climb_in_mech()
{
	thread dialogue_mb1_bootup();
	self freezecontrols(1);
	self disableweapons();
	self allowprone(0);
	self allowcrouch(0);
	soundscripts\_snd::snd_message("start_mech");
	self playerlinktoblend(self.rig,"tag_player",0.5);
	wait(0.5);
	self playerlinktodelta(self.rig,"tag_player",0,0,0,0,0,1);
	self.rig show();
	thread take_weapon_delayed();
	level thread maps\captured_util::waittill_notify_func("notify_mech_enable",::maps\_playermech_code::playermech_start,"base_noweap_bootup");
	thread event_mb1_climb_in_mech_gideon();
	level._mb.node maps\_anim::anim_single(common_scripts\utility::array_combine(level._mb.suit,[level._mb.dead_mech_enemy,self.rig]),"mech_enter");
	thread maps\_playermech_code::playermech_start("base_noweap");
	self lerpviewangleclamp(0,0,0,30,30,30,30);
	common_scripts\utility::flag_set("flag_mech_enabled");
}

//Function Number: 63
event_mb1_climb_in_mech_gideon()
{
	var_00 = level._mb.node common_scripts\utility::spawn_tag_origin();
	var_00 maps\_anim::anim_single_solo(level.ally,"mech_enter");
	var_00 thread maps\_anim::anim_loop_solo(level.ally,"mech_enter_loop");
	common_scripts\utility::flag_wait("flag_mb1_jump_done");
	var_00 maps\_utility::anim_stopanimscripted();
	level.ally maps\_utility::anim_stopanimscripted();
	var_00 delete();
}

//Function Number: 64
take_weapon_delayed()
{
	wait(1);
	var_00 = self getcurrentweapon();
	self takeweapon(var_00);
}

//Function Number: 65
event_mb1_jumpdown()
{
	var_00 = getent("trig_mb1_introwall_smash","targetname");
	var_01 = level._mb.intro_node;
	for(;;)
	{
		var_00 waittill("trigger",var_02);
		if(level.player maps\captured_mech_code::cansmash(var_01,anglestoright(var_01.angles) * -1))
		{
			break;
		}

		wait(0.05);
	}

	thread maps\captured_mech_code::spawn_mech_rig(1,0.2);
	var_01 thread ai_mb1_jumpdown_guards();
	soundscripts\_snd::snd_message("aud_mech_jump");
	soundscripts\_snd::snd_message("aud_mech_panic_walla_watcher");
	common_scripts\utility::flag_set("flag_force_hud_ready");
	var_01 thread maps\captured_mech_code::anim_single_mech([self.rig],"anim_mb1_introwall_smash","cap_s1_escape_mech_jump_out_vm");
	level.dopickyautosavechecks = 0;
	maps\_utility::autosave_by_name("mb_jumpdown_start");
	level.dopickyautosavechecks = 1;
	level.player common_scripts\utility::delaycall(0.55,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(1.85,::playrumbleonentity,"heavy_1s");
	getscriptablearray("intro_wall_scrtble","targetname")[0] setscriptablepartstate(0,1);
	maps\_utility::delaythread(1.75,::common_scripts\_exploder::exploder,"mech_intro_land");
	level.player maps\_utility::delaythread(1.75,::maps\_playermech_code::enable_stencil,getentarray("mb1_nostencil","script_noteworthy"));
	soundscripts\_snd::snd_music_message("mus_captured_mech");
	common_scripts\utility::flag_set("flag_mb1_start");
	var_01 waittill("mech_anim_done");
	common_scripts\utility::flag_clear("flag_force_hud_ready");
	self unlink();
	self.rig delete();
	var_01 delete();
	common_scripts\utility::flag_set("flag_mb1_jump_done");
}

//Function Number: 66
event_mb1_weapons_come_online()
{
	common_scripts\utility::flag_wait("flag_mb1_jump_done");
	level.player disableinvulnerability();
	thread maps\_playermech_code::playermech_start("base_transition");
	while(maps\_playermech_code::get_mech_state() != "base_transition")
	{
		wait(0.05);
	}

	maps\_playermech_code::set_mech_state("base");
}

//Function Number: 67
event_mb2_gatesmash()
{
	var_00 = common_scripts\utility::getstruct("struct_mb2_gatesmash","targetname");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_mb2_gatesmash");
		if(level.player maps\captured_mech_code::cansmash(var_00,anglestoforward(var_00.angles)))
		{
			break;
		}

		wait(0.05);
	}

	thread maps\captured_mech_code::spawn_mech_rig(1,0.2);
	soundscripts\_snd::snd_message("mech_warehouse_door_smash");
	playfx(level._effect["playermech_cannon_default"],(9041,-1195,260),(0,1,0.5));
	level._mb.slide_gate_right connectpaths();
	level._mb.slide_gate_left connectpaths();
	level._mb.slide_gate_right delete();
	level._mb.slide_gate_left delete();
	common_scripts\utility::flag_set("flag_mb2_mech_smashing_doors");
	common_scripts\utility::flag_set("flag_force_hud_ready");
	var_00 thread maps\captured_mech_code::anim_single_mech([self.rig],"mech_run_through","cap_playermech_run_through_mech_short_vm");
	common_scripts\utility::array_call(level._mb.slide_gate_destroyed,::show);
	self waittill("mech_anim_done");
	common_scripts\utility::flag_clear("flag_force_hud_ready");
	self unlink();
	self.rig delete();
}

//Function Number: 68
ambient_mb1_crane()
{
	var_00 = getscriptablearray("scriptable_mb1_crane","targetname")[0];
	var_01 = common_scripts\utility::getstruct("struct_mb1_crane","targetname");
	var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
	var_00 waittill("death");
	thread maps\captured_mech_code::smash_throw(var_01.origin,var_01.radius);
	common_scripts\utility::array_thread(getnodesinradius(var_01.origin,var_01.radius,0,var_01.radius),::maps\captured_mech_code::disconnect_node);
	wait(0.4);
	radiusdamage(var_02.origin,var_02.radius,500,500,level.player);
}

//Function Number: 69
ambient_mb2_claw_platform(param_00)
{
	level endon("flag_mb2_end");
	var_01 = common_scripts\utility::getstructarray(param_00,"targetname");
	var_02 = undefined;
	foreach(var_04 in getentarray(param_00,"targetname"))
	{
		if(issubstr(var_04.classname,"brushmodel"))
		{
			var_02 = var_04;
		}
	}

	var_02 setcandamage(1);
	var_02 setcanradiusdamage(1);
	var_06 = undefined;
	var_07 = undefined;
	foreach(var_09 in var_01)
	{
		if(var_09.script_noteworthy == "struct_disconnect")
		{
			var_06 = var_09;
			continue;
		}

		if(var_09.script_noteworthy == "struct_damage")
		{
			var_07 = var_09;
		}
	}

	for(;;)
	{
		var_02 waittill("damage",var_0B,var_0C,var_0D,var_0E);
		if(var_0C != level.player)
		{
			wait(0.05);
			continue;
		}

		thread maps\captured_mech_code::smash_throw(var_0E,200);
	}
}

//Function Number: 70
ambient_mb2_cranes()
{
	thread soundscripts\_snd::snd_message("aud_warehouse_roof_machines_line");
	level._mb.cargo_total = 7;
	level._mb.cargo["A"] = 0;
	level._mb.cargo["B"] = 0;
	level._mb.cranes = [];
	for(var_00 = 0;var_00 < 10;var_00++)
	{
		thread ambient_mb2_crane("A","model_mb2_craneA" + var_00 + 1,"struct_mb2_cranepath_A",40);
	}

	for(var_00 = 0;var_00 < 10;var_00++)
	{
		thread ambient_mb2_crane("B","model_mb2_craneB" + var_00 + 1,"struct_mb2_cranepath_B",30);
	}

	thread ambient_mb2_claw_platform("model_mb2_claw_platform1");
	thread ambient_mb2_claw_platform("model_mb2_claw_platform2");
	thread ambient_mb2_claw_platform("model_mb2_claw_platform3");
}

//Function Number: 71
ambient_mb2_crane(param_00,param_01,param_02,param_03)
{
	level endon("flag_exit_lock_broken");
	var_04 = common_scripts\utility::getstruct(param_02,"targetname");
	var_05 = common_scripts\utility::getstruct(var_04.target,"targetname");
	var_06 = undefined;
	var_07 = undefined;
	var_08 = [];
	foreach(var_0A in getentarray(param_01,"targetname"))
	{
		if(issubstr(var_0A.model,"crane"))
		{
			var_06 = var_0A common_scripts\utility::spawn_tag_origin();
			var_06.main_model = var_0A;
			var_0A linkto(var_06);
			continue;
		}
		else if(issubstr(var_0A.classname,"brushmodel"))
		{
			var_07 = var_0A;
			continue;
		}

		var_08 = common_scripts\utility::array_add(var_08,var_0A);
	}

	level._mb.cranes = common_scripts\utility::array_add(level._mb.cranes,var_06);
	var_06.tmodel = param_01;
	var_06.var_5763 = param_00;
	playfxontag(level._effect["cap_crane_light"],var_06.main_model,"crane_T");
	var_06.templates = [];
	foreach(var_0A in var_08)
	{
		var_0D = spawnstruct();
		var_0D.model = var_0A.model;
		var_0D.offset = var_0A.origin - var_06.origin;
		var_06.templates = common_scripts\utility::array_add(var_06.templates,var_0D);
	}

	if(isdefined(var_07))
	{
		var_06.brush = var_07;
		var_07 linkto(var_06);
		var_06 childthread tank_damage_detection(1);
	}

	var_06.parts = [];
	if(common_scripts\utility::random([0,1]) && level._mb.cargo[var_06.var_5763] < level._mb.cargo_total)
	{
		common_scripts\utility::array_call(var_08,::linkto,var_06);
		var_06.parts = var_08;
		level._mb.cargo[var_06.var_5763]++;
	}
	else
	{
		common_scripts\utility::array_call(var_08,::delete);
		var_06.brush notsolid();
		var_06.parts = [];
	}

	var_0F = param_03 * distance2d(var_06.origin,var_05.origin) / distance2d(var_04.origin,var_05.origin);
	var_06 thread soundscripts\_snd::snd_message("aud_warehouse_roof_machines",var_0F);
	var_06 moveto((var_05.origin[0],var_06.origin[1],var_06.origin[2]),var_0F);
	wait(var_0F);
	for(;;)
	{
		if(var_06.parts.size == 0)
		{
			if(common_scripts\utility::random([0,1]) && level._mb.cargo[var_06.var_5763] < level._mb.cargo_total)
			{
				var_06.parts = [];
				foreach(var_0D in var_06.templates)
				{
					var_0A = spawn("script_model",var_04.origin);
					var_0A setmodel(var_0D.model);
					var_0A linkto(var_06,"tag_origin",var_0D.offset,(0,0,0));
					var_06.parts = common_scripts\utility::array_add(var_06.parts,var_0A);
				}

				var_06.brush solid();
				level._mb.cargo[var_06.var_5763]++;
			}
		}

		var_06.parts = common_scripts\utility::array_removeundefined(var_06.parts);
		var_06.main_model hide();
		stopfxontag(level._effect["cap_crane_light"],var_06.main_model,"crane_T");
		common_scripts\utility::array_call(var_06.parts,::hide);
		var_06.origin = (var_04.origin[0],var_06.origin[1],var_06.origin[2]);
		wait(0.05);
		var_06.main_model show();
		playfxontag(level._effect["cap_crane_light"],var_06.main_model,"crane_T");
		common_scripts\utility::array_call(var_06.parts,::show);
		var_06 thread soundscripts\_snd::snd_message("aud_warehouse_roof_machines",param_03);
		var_06 moveto((var_05.origin[0],var_06.origin[1],var_06.origin[2]),param_03);
		wait(param_03);
	}
}

//Function Number: 72
ambient_mb2_tanks()
{
	for(var_00 = 2;var_00 < 8;var_00++)
	{
		var_01 = getentarray("model_mb2_crate_explode_" + var_00,"targetname");
		var_02 = undefined;
		var_03 = [];
		foreach(var_05 in var_01)
		{
			if(issubstr(var_05.classname,"brushmodel"))
			{
				var_02 = var_05;
				continue;
			}

			var_03 = common_scripts\utility::array_add(var_03,var_05);
		}

		var_07 = common_scripts\utility::spawn_tag_origin();
		var_07.brush = var_02;
		var_07.parts = var_03;
		var_07 thread tank_damage_detection();
	}
}

//Function Number: 73
tank_damage_detection(param_00)
{
	level endon("flag_exit_lock_broken");
	self endon("death");
	self.brush setcandamage(1);
	self.brush setcanradiusdamage(1);
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	for(;;)
	{
		self.brush waittill("damage",var_01,var_02);
		if(var_02 != level.player)
		{
			continue;
		}

		if(self.parts.size == 0)
		{
			continue;
		}

		playfx(level._effect["fireball_explosion_cluster_parent_02"],self.origin,(0,0,-1));
		self radiusdamage(self.origin,512,300,300,level.player);
		common_scripts\utility::array_call(self.parts,::delete);
		if(!isremovedentity(self))
		{
			self.parts = [];
		}

		if(isdefined(self.var_5763))
		{
			level._mb.cargo[self.var_5763]--;
		}

		self.brush notsolid();
		if(!param_00)
		{
			break;
		}
	}

	self.brush delete();
	self delete();
}

//Function Number: 74
player_can_see(param_00,param_01,param_02)
{
	if(player_can_see_ai_bones(param_00,param_02))
	{
		return 1;
	}

	if(player_can_see_point(param_01,param_02))
	{
		return 1;
	}

	if(player_can_see_point(param_01 + (0,0,70),param_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 75
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

//Function Number: 76
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

//Function Number: 77
dialogue_mb1_intro()
{
}

//Function Number: 78
dialogue_mb1_bootup()
{
	wait(11);
	wait(7);
	wait(1);
	wait(0.3);
	level.allies[0] hudoutlineenable(3,1);
}

//Function Number: 79
dialogue_mb1_jumpdown()
{
	maps\_utility::smart_radio_dialogue("cap_gdn_smashthroughthatwall");
	thread maps\_utility::smart_radio_dialogue("cap_gdn_illhangbackyou");
	level thread dialogue_wallsmash_nag("flag_mb1_start");
	common_scripts\utility::flag_wait("flag_mb1_start");
	wait(3);
	maps\_utility::smart_radio_dialogue("cap_sri_calibratingweapons");
}

//Function Number: 80
dialogue_wallsmash_nag(param_00)
{
	self endon(param_00);
	wait(7);
	var_01 = ["cap_gdn_bustthroughthatwall","cap_gdn_sprintthroughthat"];
	level.player maps\captured_util::radio_dialogue_nag_loop(var_01,param_00,undefined,undefined,undefined,undefined,"flag_mech_vo_active");
}

//Function Number: 81
dialogue_mb1()
{
	smart_radio_dialogue_mb("cap_sri_allweaponssystems");
	common_scripts\utility::flag_set("flag_mech_vo_active");
	common_scripts\utility::flag_wait("flag_mb1_mech_firstmove");
	smart_radio_dialogue_mb("cap_gdn_tangosinthebuildings");
	smart_radio_dialogue_mb("cap_gdn_burstthroughthewalls");
	common_scripts\utility::flag_wait("flag_mb1_fallback_idx2");
	thread smart_radio_dialogue_mb("cap_gdn_headtowardsthatwarehouse");
	common_scripts\utility::flag_wait("flag_mb1_end");
}

//Function Number: 82
dialogue_gid_rocket_reminder()
{
	maps\_utility_code::add_to_radio("cap_gdn_thatrocketpacksa");
	smart_radio_dialogue_mb("cap_gdn_thatrocketpacksa");
}

//Function Number: 83
dialogue_gid_swarm_reminder()
{
}

//Function Number: 84
dialogue_mb2_gatesmash()
{
	level endon("flag_mb2_mech_smashing_doors");
	smart_radio_dialogue_mb("cap_gdn_bustthroughmitchell");
	level thread dialogue_wallsmash_nag("flag_mb2_mech_smashing_doors");
}

//Function Number: 85
dialogue_mb2()
{
	common_scripts\utility::flag_clear("flag_mech_vo_active");
	wait(1.5);
	smart_radio_dialogue_mb("cap_sri_warninghullintegrity");
	smart_radio_dialogue_mb("cap_gdn_lotsoftangoslock");
	common_scripts\utility::flag_set("flag_mech_vo_active");
	common_scripts\utility::flag_wait("flag_mb2_mech_stencil_on");
	smart_radio_dialogue_mb("cap_sri_enemymechdetected");
	common_scripts\utility::flag_wait_either("flag_mb2_fallback_idx4","flag_mb2_mechs_dead");
	thread dialogue_mb2_gid_il_convo();
	if(!common_scripts\utility::flag("flag_final_vo"))
	{
		smart_radio_dialogue_mb("cap_sri_enemyvehicledetected");
	}

	common_scripts\utility::flag_wait("flag_mb2_gateclose");
}

//Function Number: 86
dialogue_mb2_gid_il_convo()
{
	common_scripts\utility::flag_set("flag_final_vo");
	smart_radio_dialogue_mb("cap_gdn_ilonawereapproaching");
	smart_radio_dialogue_mb("cap_iln_justgethrough");
	common_scripts\utility::flag_clear("flag_final_vo");
}

//Function Number: 87
smart_radio_dialogue_mb(param_00)
{
	common_scripts\utility::flag_clear("flag_mech_vo_active");
	maps\_utility::smart_radio_dialogue(param_00);
	common_scripts\utility::flag_set("flag_mech_vo_active");
}