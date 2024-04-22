/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 265
 * Decompile Time: 3900 ms
 * Timestamp: 4/22/2024 2:34:57 AM
*******************************************************************/

//Function Number: 1
play_rumble_funeral_gun_salute()
{
	level.player common_scripts\utility::delaycall(0.8,::playrumbleonentity,"damage_light");
	level.player common_scripts\utility::delaycall(4.9,::playrumbleonentity,"damage_light");
	level.player common_scripts\utility::delaycall(8.5,::playrumbleonentity,"heavy_3s");
}

//Function Number: 2
play_rumble_training_s1_mute_breach()
{
	level.player common_scripts\utility::delaycall(1.8,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(2.2,::playrumbleonentity,"heavy_1s");
}

//Function Number: 3
play_rumble_training_s1_reload_malfunction()
{
	level.player common_scripts\utility::delaycall(0.5,::playrumbleonentity,"heavy_3s");
}

//Function Number: 4
play_rumble_training_s1_president_load_fail()
{
	level.player common_scripts\utility::delaycall(2.7,::playrumbleonentity,"heavy_3s");
	level.player common_scripts\utility::delaycall(5.8,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(6.8,::playrumbleonentity,"heavy_1s");
	wait(21);
	level.player.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
	level.player.rumble_entity.intensity = 0.1;
	level.player.rumble_entity common_scripts\utility::delaycall(0.5,::delete);
	wait(12);
	level.player.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
	level.player.rumble_entity.intensity = 0.08;
	level.player.rumble_entity common_scripts\utility::delaycall(1.5,::delete);
}

//Function Number: 5
play_rumble_elevator()
{
	wait(1.4);
	level.player.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
	level.player.rumble_entity.intensity = 0.08;
	wait(15);
	level.player stoprumble("steady_rumble");
	level.player.rumble_entity delete();
}

//Function Number: 6
play_rumble_jeep_ride()
{
	level.player.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
	level.player.rumble_entity.intensity = 0.088;
	wait(94);
	level.player.rumble_entity.intensity = 0.08;
	wait(14);
	level.player stoprumble("steady_rumble");
	level.player.rumble_entity delete();
	wait(1.3);
	level.player playrumbleonentity("heavy_1s");
	wait(0.3);
	level.player stoprumble("heavy_1s");
}

//Function Number: 7
play_rumble_training_s2_president_load()
{
	wait(1.5);
	level.player playrumbleonentity("heavy_1s");
	wait(0.5);
	level.player stoprumble("heavy_1s");
	wait(6.3);
	level.player playrumbleonentity("heavy_1s");
	wait(0.2);
	level.player stoprumble("heavy_1s");
	wait(0.6);
	level.player playrumbleonentity("heavy_1s");
	wait(0.1);
	level.player stoprumble("heavy_1s");
	wait(0.1);
	level.player playrumbleonentity("heavy_1s");
	wait(0.1);
	level.player stoprumble("heavy_1s");
}

//Function Number: 8
play_rumble_walker_tank()
{
	for(var_00 = 1;var_00 < 10;var_00++)
	{
		level waittill("titan_rumble");
		if(var_00 == 3 || var_00 == 4 || var_00 == 5 || var_00 == 6 || var_00 == 7)
		{
			level.player playrumbleonentity("heavy_1s");
			wait(0.75);
			level.player stoprumble("heavy_1s");
		}
	}
}

//Function Number: 9
play_rumble_arm_repair()
{
	common_scripts\utility::flag_wait("tour_exo_arm");
	wait(3.6);
	level.player playrumbleonentity("steady_rumble");
	wait(0.9);
	level.player stoprumble("steady_rumble");
	wait(1.7);
	level.player playrumbleonentity("steady_rumble");
	wait(0.9);
	level.player stoprumble("steady_rumble");
	wait(3.4);
	level.player playrumbleonentity("damage_light");
	wait(0.7);
	level.player stoprumble("damage_light");
	common_scripts\utility::flag_wait("arm_repair_attempt_1");
	common_scripts\utility::flag_wait("arm_repair_attempt_2");
	common_scripts\utility::flag_wait("arm_repair_attempt_3");
	common_scripts\utility::flag_waitopen("arm_repair_attempt_3");
	wait(2.2);
	level.player playrumbleonentity("damage_light");
	wait(0.5);
	level.player stoprumble("damage_light");
}

//Function Number: 10
play_camera_shake_tour_ride()
{
	var_00 = 0.5;
	var_01 = 11;
	var_02 = 30.3;
	var_03 = 7.3;
	var_04 = 10.2;
	var_05 = 12.5;
	var_06 = 11.2;
	var_07 = 9.3;
	var_08 = 3;
	var_09 = 0.5;
	var_0A = 1.5;
	var_0B = 1.25;
	var_0C = 1;
	var_0D = 0;
	var_0E = 1;
	var_0F = 0.8;
	var_10 = 0.6;
	level.player screenshakeonentity(var_0C,var_0C,var_0C,var_00,0,0,0,var_0E,var_0F,var_10);
	wait(var_00);
	level.player screenshakeonentity(var_0A,var_0A,var_0A,var_01,0,0,0,var_0E,var_0F,var_10);
	wait(var_01);
	level.player screenshakeonentity(var_0B,var_0B,var_0B,var_02,0,0,0,var_0E,var_0F,var_10);
	wait(var_02);
	level.player screenshakeonentity(var_0C,var_0C,var_0C,var_03,0,0,0,var_0E,var_0F,var_10);
	wait(var_03);
	level.player screenshakeonentity(var_0B,var_0B,var_0B,var_04,0,0,0,var_0E,var_0F,var_10);
	wait(var_04);
	level.player screenshakeonentity(var_0A,var_0A,var_0A,var_05,0,0,0,var_0E,var_0F,var_10);
	wait(var_05);
	level.player screenshakeonentity(var_0B,var_0B,var_0B,var_06,0,0,0,var_0E,var_0F,var_10);
	wait(var_06);
	level.player screenshakeonentity(var_0A,var_0A,var_0A,var_07,0,0,0,var_0E,var_0F,var_10);
	wait(var_07);
	level.player screenshakeonentity(var_0B,var_0B,var_0B,var_08,0,0,0,var_0E,var_0F,var_10);
	wait(var_08);
	level.player screenshakeonentity(var_0C,var_0C,var_0C,var_09,0,0,0,var_0E,var_0F,var_10);
	wait(var_09);
}

//Function Number: 11
mission_out_of_bounds_fail()
{
	common_scripts\utility::flag_wait("training_player_left_encounter");
	if(!common_scripts\utility::flag("flag_player_using_drone"))
	{
		common_scripts\utility::flag_clear("training_out_of_bounds_warning");
		if(!common_scripts\utility::flag("training_round_2"))
		{
			if(!common_scripts\utility::flag("training_s1_end_anim_started"))
			{
				setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_ABANDONED");
			}
			else
			{
				setdvar("ui_deadquote",&"RECOVERY_OBJECTIVE_FAIL_JEEP_BOARD");
			}
		}
		else if(!common_scripts\utility::flag("training_s2_golf_course_vehicles"))
		{
			setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_ABANDONED");
		}
		else
		{
			setdvar("ui_deadquote",&"RECOVERY_OBJECTIVE_FAIL_JEEP_BOARD");
		}

		setblur(30,2);
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 12
mission_warn_out_of_bounds_fail()
{
	level endon("training_player_left_encounter");
	for(;;)
	{
		common_scripts\utility::flag_wait("training_out_of_bounds_warning");
		if(!common_scripts\utility::flag("flag_player_using_drone"))
		{
			thread maps\_utility::display_hint("warning_prompt");
		}

		common_scripts\utility::flag_waitopen("training_out_of_bounds_warning");
	}
}

//Function Number: 13
bloody_death(param_00,param_01)
{
	self endon("death");
	if(!issentient(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(self.bloody_death) && self.bloody_death)
	{
		return;
	}

	self.bloody_death = 1;
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	var_02 = [];
	var_02[0] = "j_hip_le";
	var_02[1] = "j_hip_ri";
	var_02[2] = "j_head";
	var_02[3] = "j_spine4";
	var_02[4] = "j_elbow_le";
	var_02[5] = "j_elbow_ri";
	var_02[6] = "j_clavicle_le";
	var_02[7] = "j_clavicle_ri";
	var_03 = getdvarint("cg_fov");
	for(var_04 = 0;var_04 < 3 + randomint(5);var_04++)
	{
		var_05 = randomintrange(0,var_02.size);
		thread bloody_death_fx(var_02[var_05],undefined);
		wait(randomfloat(0.1));
		if(isdefined(param_01) && isai(param_01) && isalive(param_01))
		{
			if(!level.player worldpointinreticle_circle(param_01.origin,var_03,500))
			{
				param_01 shootblank();
			}
		}
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 14
bloody_death_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 15
delete_on_notify(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "level_cleanup";
	}

	self endon("death");
	level waittill(param_00);
	if(common_scripts\utility::flag_exist("_stealth_spotted"))
	{
		common_scripts\utility::flag_waitopen("_stealth_spotted");
	}

	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self delete();
}

//Function Number: 16
enable_jump_jet_pathing()
{
	if(issubstr(self.classname,"jump"))
	{
		self.canjumppath = 1;
	}
}

//Function Number: 17
recovery_thermal_manager()
{
	self thermaldrawenable();
}

//Function Number: 18
training_set_up_player()
{
	common_scripts\utility::flag_clear("flag_disable_exo");
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowjump(1);
	level.player giveweapon("iw5_bal27_sp_silencer01_variablereddot");
	level.player giveweapon("iw5_titan45_sp_silencerpistol");
	level.player switchtoweapon("iw5_bal27_sp_silencer01_variablereddot");
	level.player enablehybridsight("iw5_bal27_sp_silencer01_variablereddot",1);
	if(level.nextgen)
	{
		level.player overrideviewmodelmaterial("m/mtl_bal27_base_black","m/mtl_bal27_base_black_logo");
	}
	else
	{
		level.player overrideviewmodelmaterial("mq/mtl_bal27_base_black","mq/mtl_bal27_base_black_logo");
	}

	level.player enableweapons();
	level.player allowfire(1);
	level.player allowads(1);
	level.player allowmelee(1);
	maps\_variable_grenade::give_player_variable_grenade();
	maps\_variable_grenade::set_variable_grenades_with_no_switch("tracking_grenade_var","paint_grenade_var");
}

//Function Number: 19
training_s2_start_set_up_player()
{
	common_scripts\utility::flag_clear("flag_disable_exo");
	common_scripts\utility::flag_set("flag_enable_overdrive");
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowjump(1);
	level.player enableweapons();
	level.player allowfire(1);
	level.player allowads(1);
	level.player allowmelee(1);
	maps\_variable_grenade::give_player_variable_grenade();
}

//Function Number: 20
training_s1_squad_allow_run()
{
	if(isalive(level.ally_squad_member_1))
	{
		level.ally_squad_member_1 allowedstances("prone","crouch","stand");
	}

	if(isalive(level.ally_squad_member_2))
	{
		level.ally_squad_member_2 allowedstances("prone","crouch","stand");
	}

	if(isalive(level.ally_squad_member_4))
	{
		level.ally_squad_member_4 allowedstances("prone","crouch","stand");
	}

	if(isalive(level.joker))
	{
		level.joker allowedstances("prone","crouch","stand");
	}

	if(isalive(level.ally_squad_member_3))
	{
		level.ally_squad_member_3 allowedstances("prone","crouch","stand");
	}
}

//Function Number: 21
training_s1_windy_trees()
{
	var_00 = getentarray("windy_trees","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread training_s1_windy_trees_think();
	}
}

//Function Number: 22
training_s1_windy_trees_think()
{
	wait(randomfloatrange(1.5,2.85));
	while(common_scripts\utility::flag("training_s1_enable_living_room") == 0)
	{
		var_00 = self.angles;
		var_01 = randomintrange(1,3);
		if(var_01 == 2)
		{
			var_02 = 6;
		}
		else
		{
			var_02 = -6;
		}

		self rotateto(var_00 + (var_02,0,0),4,3,1);
		wait(4);
		self rotateto(var_00,4,3,1);
		wait(3.85);
	}
}

//Function Number: 23
player_control_on()
{
	level.player unlink();
	level.player enableweapons();
	level.player allowstand(1);
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowsprint(1);
}

//Function Number: 24
training_s1_opening_guy_think(param_00,param_01)
{
	self endon("death");
	var_02 = common_scripts\utility::getstruct(param_00,"targetname");
	self forceteleport(var_02.origin,var_02.angles);
	self setgoalpos(self.origin);
	self allowedstances("crouch");
	maps\_stealth_utility::stealth_plugin_basic();
	maps\_stealth_utility::stealth_plugin_accuracy();
	maps\_stealth_utility::stealth_plugin_smart_stance();
	maps\_utility::forceuseweapon("iw5_bal27_sp_silencer01_variablereddot","primary");
	maps\_utility::disable_surprise();
	if(!isdefined(level.allies_s1))
	{
		level.allies_s1 = [];
	}

	level.allies_s1 = common_scripts\utility::array_add(level.allies_s1,self);
	common_scripts\utility::flag_wait(param_01);
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	bloody_death();
}

//Function Number: 25
training_s1_starting_enemies_think(param_00,param_01,param_02)
{
	self endon("death");
	thread attach_flashlight_on_gun();
	thread maps\_utility::set_battlechatter(0);
	maps\_utility::disable_long_death();
	thread training_s1_start_stealth_watch(param_00);
	thread training_s1_starting_enemies_alerted(param_00);
	common_scripts\utility::flag_wait(param_01);
	wait(randomfloatrange(0.5,1.5));
	bloody_death();
}

//Function Number: 26
training_s1_start_stealth_watch(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any_ents(self,"patrol_alerted",self,"_stealth_spotted",self,"stealth_event",self,"_stealth_found_corpse",self,"alerted",self,"enemy");
	wait(2);
	thread training_s1_alert();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 27
training_s1_starting_enemies_alerted(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	self notify("alerted");
	thread maps\_utility::set_battlechatter(1);
	maps\_utility::player_seek();
}

//Function Number: 28
training_s1_sniper_enemies_think(param_00,param_01,param_02)
{
	self endon("death");
	self.health = 1;
	attach_flashlight_on_gun();
	maps\_utility::set_battlechatter(0);
	thread training_s1_start_stealth_watch(param_00);
	common_scripts\utility::flag_wait(param_00);
	self notify("alerted");
	maps\_utility::set_battlechatter(1);
	common_scripts\utility::flag_wait(param_01);
	wait(randomfloatrange(0.5,1.5));
	bloody_death();
}

//Function Number: 29
training_s1_starting_enemies_charge(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	maps\_utility::player_seek();
}

//Function Number: 30
training_s1_surprise_enemy_think()
{
	self endon("death");
	maps\_utility::disable_bulletwhizbyreaction();
	if(!maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
	{
		maps\_utility::ent_flag_init("_stealth_behavior_asleep");
	}

	maps\_utility::ent_flag_set("_stealth_behavior_asleep");
	self.ignoreall = 1;
	var_00 = self.health;
	thread maps\_utility::magic_bullet_shield();
	self.ignorerandombulletdamage = 1;
	maps\_utility::disable_long_death();
	thread attach_flashlight_on_gun();
	maps\_utility::set_battlechatter(0);
	thread training_s1_surprise_enemy_alert(var_00);
	common_scripts\utility::flag_wait("flag_training_s1_surprise_enemy_alert");
	maps\_utility::enable_bulletwhizbyreaction();
	if(isdefined(self.magic_bullet_shield))
	{
		thread maps\_utility::stop_magic_bullet_shield();
		self.noragdoll = undefined;
	}

	self.ignoreall = 0;
	self.health = var_00;
	self.ignorerandombulletdamage = 0;
	if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
	{
		maps\_utility::ent_flag_clear("_stealth_behavior_asleep");
	}
}

//Function Number: 31
training_s1_surprise_enemy_alert(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait("training_s1_start_alerted");
	maps\_utility::enable_bulletwhizbyreaction();
	if(isdefined(self.magic_bullet_shield))
	{
		thread maps\_utility::stop_magic_bullet_shield();
		self.noragdoll = undefined;
	}

	self.ignoreall = 0;
	self.health = param_00;
	self.ignorerandombulletdamage = 0;
	if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
	{
		maps\_utility::ent_flag_clear("_stealth_behavior_asleep");
	}

	self notify(" alerted");
	maps\_utility::player_seek();
}

//Function Number: 32
training_s1_surprise_enemy_go()
{
	wait(3);
	self.health = 1;
	if(isdefined(self.magic_bullet_shield))
	{
		thread maps\_utility::stop_magic_bullet_shield();
	}

	if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
	{
		maps\_utility::ent_flag_clear("_stealth_behavior_asleep");
	}
}

//Function Number: 33
training_surprise_enemy_move_to_patio(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		self.goalradius = 8;
		maps\_utility::set_forcegoal();
		maps\_utility::set_goal_node(param_00);
		self waittill("goal");
		maps\_utility::unset_forcegoal();
		self.ignoreall = 0;
	}
}

//Function Number: 34
training_s1_alert_check()
{
	level endon("training_s1_start_alerted");
	level endon("training_s1_clear_initial_spawn");
	common_scripts\utility::flag_wait("flag_training_s1_alert_starting_enemies");
	thread training_s1_alert();
}

//Function Number: 35
training_s1_alert()
{
	common_scripts\utility::flag_set("training_s1_start_alerted");
	common_scripts\utility::flag_set("training_s1_snipers_attack");
	common_scripts\utility::flag_set("flag_vo_training_s1_joker_spotted_us");
	level notify("training_s1_start_enemies_alert");
	thread training_s1_set_squad_active_and_target();
	thread training_s1_squad_allow_run();
	common_scripts\utility::flag_set("flag_obj_rescue1_start_clear");
	maps\_utility::waittill_aigroupcount("training_s1_enemies_start",2);
	common_scripts\utility::flag_set("training_s1_clear_initial_spawn");
	maps\_utility::waittill_aigroupcleared("training_s1_enemies_start");
	common_scripts\utility::flag_set("training_s1_start_alerted_enemies_dead");
	common_scripts\utility::flag_set("training_s1_clear_initial_spawn");
	wait(1);
	common_scripts\utility::flag_set("training_s1_prepare_breach_room");
	common_scripts\utility::flag_set("flag_obj_rescue1_enter");
	thread training_s1_set_squad_passive_and_ignore();
}

//Function Number: 36
training_s1_monitor_surprise_enemy_death()
{
	self waittill("death");
	wait(2);
	if(common_scripts\utility::flag("flag_vo_training_s1_joker_got_him") == 0)
	{
		common_scripts\utility::flag_set("flag_vo_training_s1_joker_good_kill");
	}
}

//Function Number: 37
training_s1_kill_surprise_enemy()
{
	if(isalive(level.surprise_enemy))
	{
		level.surprise_enemy.health = 1;
		magicbullet(level.joker.weapon,level.joker gettagorigin("tag_flash"),level.surprise_enemy geteye());
		level.surprise_enemy bloody_death();
		common_scripts\utility::flag_set("flag_vo_training_s1_joker_got_him");
	}
}

//Function Number: 38
training_s1_show_threat_text()
{
	level endon("threat_grenade_hint_text_off");
	wait(1);
	thread training_s1_show_threat_text_ender();
	for(;;)
	{
		level.player.showhint = 1;
		thread maps\_utility::display_hint("threat_breach_prompt");
		common_scripts\utility::flag_waitopen("player_at_threat_breach");
		level.player.showhint = 0;
		common_scripts\utility::flag_wait("player_at_threat_breach");
	}
}

//Function Number: 39
training_s1_show_threat_text_ender()
{
	common_scripts\utility::flag_wait("threat_grenade_hint_text_off");
	level.player.showhint = 0;
}

//Function Number: 40
training_s1_refill_threat_grenades()
{
	while(!common_scripts\utility::flag("threat_grenade_hint_text_off"))
	{
		if(!common_scripts\utility::flag("player_at_threat_breach"))
		{
			common_scripts\utility::flag_wait("player_at_threat_breach");
		}

		if(level.player setweaponammostock("paint_grenade_var") == 0)
		{
			level.player setweaponammostock("paint_grenade_var",1);
		}

		wait(0.2);
	}
}

//Function Number: 41
training_s1_threat_enemies()
{
	wait(1.5);
	var_00 = self;
	var_01 = 0;
	while(var_01 < 4 && var_00.size > 0)
	{
		foreach(var_03 in var_00)
		{
			var_04 = randomfloatrange(1.5,2.5);
			wait(var_04);
			var_01 = var_01 + var_04;
			if(!isalive(var_03))
			{
				continue;
			}

			var_05 = 7;
			var_06 = (randomfloat(var_05),randomfloat(var_05),randomfloat(var_05));
			magicbullet(level.joker.weapon,level.joker gettagorigin("tag_flash"),var_03 geteye() + var_06);
			var_04 = randomfloatrange(0.2,0.35);
			wait(var_04);
			var_01 = var_01 + var_04;
			var_06 = (randomfloat(var_05),randomfloat(var_05),randomfloat(var_05));
			if(common_scripts\utility::cointoss())
			{
				magicbullet(level.joker.weapon,level.joker gettagorigin("tag_flash"),var_03 geteye() + var_06);
			}

			if(!isalive(var_03))
			{
				continue;
			}
		}

		var_00 = maps\_utility::array_removedead(var_00);
	}

	level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
	level.ally_squad_member_3 bloody_death();
}

//Function Number: 42
training_s1_flash_door()
{
	var_00 = common_scripts\utility::getstruct("training_s1_flashbang_animnode","targetname");
	var_01 = getent("training_s1_flash_door","targetname");
	var_01.animname = "door_prop";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("living_room_door_clip","targetname");
	var_02 linkto(var_01,"door");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"training_s1_flash_door_open");
	common_scripts\utility::flag_wait("training_s1_peak_flash_door");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s1_flash_door_open");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"training_s1_flash_door_open_idle","stop_loop");
	common_scripts\utility::flag_wait("training_s1_open_flash_door");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s1_flash_door_out");
	var_02 connectpaths();
	common_scripts\utility::flag_wait("training_s1_close_living_room_door");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"training_s1_flash_door_open");
	wait(1);
	var_02 disconnectpaths();
}

//Function Number: 43
training_s1_flash_enemies_think(param_00,param_01)
{
	self endon("death");
	self.pacifist = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
	maps\_utility::disable_long_death();
	if(isdefined(self.animation))
	{
		self.animname = "generic";
		thread maps\_anim::anim_loop_solo(self,self.animation,"stop_loop");
		maps\_utility::set_allowdeath(1);
		thread training_s1_flash_death_check();
	}

	common_scripts\utility::flag_wait(param_00);
	maps\_utility::anim_stopanimscripted();
	if(level.flash_attack == 1)
	{
		maps\_utility::flashbangstart(4);
	}
	else
	{
		maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	}

	self.pacifist = 0;
	self.ignoreall = 0;
	self.ignoreme = 0;
	common_scripts\utility::flag_wait(param_01);
	bloody_death(1);
}

//Function Number: 44
training_s1_flash_death_check()
{
	self waittill("death");
	if(common_scripts\utility::flag("training_s1_open_flash_door") == 0)
	{
		level.flash_attack = 0;
		common_scripts\utility::flag_set("training_s1_flag_flash");
	}
}

//Function Number: 45
training_s1_enemies_living_room_think()
{
	self endon("death");
	self.ignoreall = 1;
	thread maps\_utility::set_battlechatter(0);
	maps\_utility::disable_long_death();
	thread training_s1_threat_death_check();
	if(isdefined(self.animation))
	{
		self.animname = "generic";
		maps\_utility::set_allowdeath(1);
		thread maps\_anim::anim_loop_solo(self,self.animation,"stop_loop");
	}
}

//Function Number: 46
training_s1_threat_death_check()
{
	level endon("threat_thrown");
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(common_scripts\utility::flag("training_s1_flag_thermal") == 0 && var_01 == level.player)
	{
		level.threat_attack = "nil";
		common_scripts\utility::flag_set("training_s1_flag_thermal");
	}
}

//Function Number: 47
training_s1_living_room_check()
{
	maps\_utility::waittill_aigroupcleared("flash_enemies");
	level.living_room_clear = 1;
}

//Function Number: 48
training_s1_living_room_timer()
{
	wait(15);
	level.living_room_clear = 1;
}

//Function Number: 49
training_s1_threat_door()
{
	var_00 = common_scripts\utility::getstruct("training_s1_flashbang_animnode","targetname");
	var_01 = getent("training_s1_flash_door","targetname");
	var_01.animname = "door_prop";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("living_room_door_clip","targetname");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"training_s1_threat_door_open");
	var_02 linkto(var_01,"door");
	common_scripts\utility::flag_wait("training_s1_peak_thermal_door");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s1_threat_door_open");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"training_s1_threat_door_open_idle","stop_loop");
	common_scripts\utility::flag_wait("training_s1_open_thermal_door");
	if(level.threat_attack == "smart")
	{
		wait(3);
	}

	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s1_threat_door_out");
	var_02 connectpaths();
	common_scripts\utility::flag_wait("training_s1_breach_done");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"training_s1_threat_door_open");
	wait(1);
	var_02 disconnectpaths();
}

//Function Number: 50
training_s1_shoot_monitor()
{
	level endon("flag_obj_rescue1_breach");
	level.threat_attack = "nil";
	for(;;)
	{
		level.player waittill("weapon_fired",var_00);
		if(common_scripts\utility::flag("player_at_threat_breach"))
		{
			level.threat_attack = var_00;
			common_scripts\utility::flag_set("threat_grenade_hint_text_off");
			common_scripts\utility::flag_set("threat_breach_kickoff_gunfire");
			break;
		}
	}
}

//Function Number: 51
training_s1_flash_monitor()
{
	level.threat_attack = "nil";
	for(;;)
	{
		level.player waittill("grenade_fire",var_00,var_01);
		if(common_scripts\utility::flag("player_at_threat_breach"))
		{
			break;
		}
	}

	if(var_01 == "paint_grenade_var")
	{
		level notify("threat_thrown");
	}

	level notify("training_s1_joker_threat_grenade_nag_off");
	common_scripts\utility::flag_set("threat_grenade_hint_text_off");
	var_00 waittill("death");
	if(var_01 == "paint_grenade_var")
	{
		level.threat_attack = "threat";
	}
	else if(var_01 == "tracking_grenade_var")
	{
		level.threat_attack = "smart";
	}
	else
	{
		level.threat_attack = "other";
	}

	common_scripts\utility::flag_set("training_s1_flag_thermal");
}

//Function Number: 52
training_s1_kill_threat_enemies()
{
	self endon("death");
	wait(5);
	if(isalive(self))
	{
		magicbullet(level.gideon.weapon,level.gideon gettagorigin("tag_flash"),self geteye());
		bloody_death();
	}
}

//Function Number: 53
training_surprise_enemy_think()
{
	if(!isalive(self))
	{
		return;
	}

	self endon("death");
	thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	thread maps\_utility::set_battlechatter(1);
	self.ignoreall = 0;
	self.health = 1;
	var_00 = getent("training_s1_surprise_enemy_cover_node","targetname");
	if(isdefined(var_00))
	{
		self.goalradius = 32;
		maps\_utility::set_forcegoal();
		maps\_utility::set_goal_node(var_00);
		self waittill("goal");
		maps\_utility::unset_forcegoal();
	}
}

//Function Number: 54
training_s2_open_bedroom_door_2()
{
	var_00 = getent("bedroom_2_door","targetname");
	getent(var_00.target,"targetname") linkto(var_00);
	var_00.angles = var_00.angles + (0,85,0);
	var_00 connectpaths();
}

//Function Number: 55
training_s1_president_setup(param_00)
{
	self endon("death");
	maps\_utility::magic_bullet_shield();
	self.animname = "president";
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	maps\_utility::set_battlechatter(0);
	self.team = "allies";
	level maps\_utility::clear_color_order("y","allies");
	maps\_utility::set_force_color("y");
	common_scripts\utility::flag_wait(param_00);
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self delete();
}

//Function Number: 56
training_s1_set_up_search_drones(param_00,param_01)
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	self.ignoreall = 1;
	self.ignoreme = 1;
	thread training_s1_search_drones_damage_check(param_00);
	thread training_s1_search_drones_death_check();
	thread training_s1_search_drones_cleanup(param_01);
	if(isdefined(self.animation))
	{
		thread training_s1_search_drones_play_ainm();
		thread maps\recovery_fx::drone_search_light_fx();
	}
	else
	{
		self laseron();
	}

	common_scripts\utility::flag_wait(param_00);
	self.ignoreall = 0;
	self.ignoreme = 0;
	if(isdefined(self.animation))
	{
		self stopanimscripted();
	}

	thread vehicle_scripts\_pdrone::stop_scripted_move_and_attack();
}

//Function Number: 57
training_s1_search_drones_play_ainm()
{
	wait(2);
	self.animname = "pdrone";
	self.allowdeath = 1;
	var_00 = getent("training_s1_drone_attack_scene","targetname");
	var_00 maps\_anim::anim_first_frame_solo(self,self.animation);
	var_00 maps\_anim::anim_single_solo(self,self.animation);
	if(isalive(self))
	{
		self delete();
	}
}

//Function Number: 58
training_s1_search_drones_damage_check(param_00)
{
	self endon("death");
	self endon("training_s1_search_drones_done");
	self waittill("damage");
	if(!common_scripts\utility::flag("training_s1_search_drones_done"))
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 59
training_s1_search_drones_death_check()
{
	self waittill("death");
	level.search_drones_count = level.search_drones_count + 1;
}

//Function Number: 60
training_s1_search_drones_cleanup(param_00)
{
	self endon("death");
}

//Function Number: 61
training_s1_drone_ambush_scene()
{
	wait(1);
	var_00 = common_scripts\utility::getstruct("attacklocation1","targetname");
	var_01 = level.ally_squad_member_1;
	var_01 maps\_utility::enable_long_death();
	var_01 maps\_utility::stop_magic_bullet_shield();
	magicbullet("iw5_bal27_sp",var_00.origin,var_01.origin);
	magicbullet("iw5_bal27_sp",var_00.origin,var_01.origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp",var_00.origin,var_01.origin);
	wait(0.25);
	magicbullet("iw5_bal27_sp",var_00.origin,var_01.origin);
	if(isalive(var_01))
	{
		var_01 kill();
	}

	wait(5);
	var_02 = common_scripts\utility::getstruct("attacklocation2","targetname");
	var_03 = level.ally_squad_member_4;
	var_03 maps\_utility::enable_long_death();
	var_03 maps\_utility::stop_magic_bullet_shield();
	magicbullet("iw5_bal27_sp",var_02.origin,var_03.origin);
	magicbullet("iw5_bal27_sp",var_02.origin,var_03.origin);
	wait(0.15);
	magicbullet("iw5_bal27_sp",var_02.origin,var_03.origin);
	magicbullet("iw5_bal27_sp",var_02.origin,var_03.origin);
	wait(0.25);
	magicbullet("iw5_bal27_sp",var_02.origin,var_03.origin);
	magicbullet("iw5_bal27_sp",var_02.origin,var_03.origin);
	if(isalive(var_03))
	{
		var_03 kill();
	}
}

//Function Number: 62
training_s1_terrace_enemies_think(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	bloody_death(1);
}

//Function Number: 63
training_s1_patio_enemies_think(param_00,param_01)
{
	self endon("death");
	thread maps\_utility::disable_long_death();
	var_02 = self.health;
	self.health = 1;
	thread maps\_utility::set_battlechatter(0);
	if(randomint(10) < 5)
	{
		thread attach_flashlight_on_gun();
	}

	thread training_s1_patio_enemies_alert(param_00,var_02);
	thread training_s1_patio_enemies_alert_check(param_00);
	common_scripts\utility::flag_wait(param_01);
	bloody_death();
}

//Function Number: 64
training_s1_patio_enemies_alert(param_00,param_01)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	self.health = param_01;
	thread maps\_utility::set_battlechatter(1);
	self notify("alerted");
}

//Function Number: 65
training_s1_patio_enemies_alert_check(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any_ents(self,"patrol_alerted",self,"_stealth_spotted",self,"stealth_event",self,"_stealth_found_corpse",self,"alerted",self,"enemy");
	wait(3);
	common_scripts\utility::flag_set(param_00);
	training_s1_set_squad_active_and_target();
}

//Function Number: 66
training_s1_allies_advance()
{
	level endon("training_s1_hide");
	thread training_s1_check_snipers();
	thread training_s1_patio_joker_loc_check();
	while(common_scripts\utility::flag("training_s1_spawn_patio_wave1_dead") == 0 && common_scripts\utility::flag("training_s1_spawn_patio_enemies_wave2") == 0)
	{
		wait 0.05;
	}

	if(common_scripts\utility::flag("training_s1_patio_alerted") == 1 && common_scripts\utility::flag("training_s1_spawn_patio_wave1_dead") == 0)
	{
		maps\_utility::activate_trigger("training_s1_color_trigger_patio_lower1","targetname");
		level.joker maps\_utility::cqb_walk("off");
	}

	while(common_scripts\utility::flag("training_s1_spawn_patio_wave1_dead") == 0 && common_scripts\utility::flag("training_s1_spawn_patio_enemies_wave3") == 0)
	{
		wait 0.05;
	}

	if(common_scripts\utility::flag("training_s1_patio_alerted") == 1 && common_scripts\utility::flag("training_s1_spawn_patio_wave1_dead") == 0)
	{
		maps\_utility::activate_trigger("training_s1_color_trigger_patio_lower","targetname");
		level.joker maps\_utility::cqb_walk("off");
	}
}

//Function Number: 67
training_s1_patio_joker_loc_check()
{
	level endon("training_s1_hide");
	common_scripts\utility::flag_wait("training_s1_patio_alerted");
	if(common_scripts\utility::flag("training_s1_spawn_patio_enemies_wave2"))
	{
		maps\_utility::activate_trigger("training_s1_color_trigger_patio_lower1","targetname");
		level.joker maps\_utility::cqb_walk("off");
	}

	if(common_scripts\utility::flag("training_s1_spawn_patio_enemies_wave3"))
	{
		maps\_utility::activate_trigger("training_s1_color_trigger_patio_lower","targetname");
		level.joker maps\_utility::cqb_walk("off");
	}
}

//Function Number: 68
training_s1_check_snipers()
{
	maps\_utility::waittill_aigroupcleared("patio_ambush1");
	common_scripts\utility::flag_set("training_s1_spawn_patio_wave1_dead");
}

//Function Number: 69
training_s1_pool_house_doors()
{
	var_00 = getent("pool_house_door01","targetname");
	getent(var_00.target,"targetname") linkto(var_00);
	var_01 = getent("pool_house_door02","targetname");
	getent(var_01.target,"targetname") linkto(var_01);
	var_00 rotateto(var_00.angles + (0,90,0),1,0,1);
	var_01 rotateto(var_01.angles + (0,-90,0),1,0,1);
	var_00 connectpaths();
	var_01 connectpaths();
	wait(3);
	var_00 rotateto(var_00.angles + (0,-90,0),1,0,1);
	var_01 rotateto(var_01.angles + (0,90,0),1,0,1);
	var_00 disconnectpaths();
	var_01 disconnectpaths();
}

//Function Number: 70
training_s1_terrace_vehicles_think(param_00,param_01,param_02)
{
	self endon("death");
	thread training_s1_terrace_vehicles_cleanup(param_00);
	thread training_s1_golf_course_encounter(param_01);
	foreach(var_04 in self.riders)
	{
		var_04 thread attach_flashlight_on_vehicle_unload();
		var_04 thread maps\_utility::set_battlechatter(0);
		var_04 thread training_s1_terrace_vehicles_riders_think(param_01);
		var_04 thread training_s1_terrace_vehicles_riders_cleanup(param_00,param_01);
		var_04 thread training_s1_golf_course_alert(param_01);
	}

	common_scripts\utility::flag_wait(param_01);
	var_06 = getent("golf_course_watch_out","targetname");
	badplace_brush("watch_out",-1,var_06,"axis");
	var_07 = getentarray("training_s1_vehicle_attack_node","script_noteworthy");
	foreach(var_09 in var_07)
	{
		var_0A = 2;
		if(isdefined(var_09.speed))
		{
			var_09.speed = var_09.speed * var_0A;
		}
	}

	common_scripts\utility::flag_wait(param_02);
	badplace_delete("watch_out");
	soundscripts\_snd::snd_message("rec_train1_stealth_car_stop",self);
	maps\_vehicle::vehicle_stop_named("stop_to_kill_player",15,10);
	maps\_vehicle::vehicle_unload("all_but_gunner");
}

//Function Number: 71
training_s1_golf_course_encounter(param_00)
{
	while(common_scripts\utility::flag("training_s1_hide_from_patrols_done") == 0)
	{
		common_scripts\utility::flag_wait(param_00);
		maps\_utility::waittill_aigroupcleared("golf_course_ambush1");
		common_scripts\utility::flag_set("training_s1_hide_from_patrols_done");
	}
}

//Function Number: 72
training_s1_golf_course_encounter_track_deaths()
{
	maps\_utility::waittill_aigroupcleared("golf_course_ambush1");
	common_scripts\utility::flag_set("training_s1_hide_from_patrols_done");
}

//Function Number: 73
training_s1_terrace_vehicles_riders_cleanup(param_00,param_01)
{
	self endon("death");
	common_scripts\utility::flag_wait("training_s1_golf_course_vehicles");
	if(!common_scripts\utility::flag(param_01))
	{
		self delete();
		return;
	}

	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 74
training_s1_terrace_vehicles_riders_think(param_00)
{
	self endon("death");
	self.pacifist = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
	maps\_utility::disable_long_death();
	common_scripts\utility::flag_wait(param_00);
	self.pacifist = 0;
	self.ignoreall = 0;
	thread maps\_utility::set_battlechatter(1);
	self.ignoreme = 0;
}

//Function Number: 75
training_s1_terrace_vehicles_cleanup(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	foreach(var_02 in self.riders)
	{
		var_02 delete();
	}

	self delete();
}

//Function Number: 76
training_s1_golf_course_alert(param_00)
{
	var_01 = common_scripts\utility::waittill_any_return("patrol_alerted","_stealth_spotted","stealth_event","alerted","enemy","damage","death");
	wait(2);
	if(isalive(self))
	{
		self notify("alerted");
		thread maps\_utility::clear_run_anim();
		thread maps\_utility::player_seek_enable();
	}

	if(!common_scripts\utility::flag(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 77
training_s1_runner_enemy_think(param_00,param_01)
{
	self endon("death");
	maps\_utility::disable_long_death();
	attach_flashlight_on_gun();
	thread training_s1_golf_course_alert(param_01);
	var_02 = [];
	var_02["saw"] = ::training_s1_runner_enemy_found_corpse;
	var_02["found"] = ::training_s1_runner_enemy_found_corpse;
	maps\_stealth_utility::stealth_corpse_behavior_custom(var_02);
	force_patrol_anim_set("patroljog",0);
	maps\_utility::set_moveplaybackrate(1.1);
	training_s1_runner_enemy_think_cleanup(param_01);
	common_scripts\utility::flag_wait(param_00);
	bloody_death();
}

//Function Number: 78
training_s1_runner_enemy_think_cleanup(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait("training_s1_golf_course_vehicles");
	if(!common_scripts\utility::flag(param_00))
	{
		self delete();
	}
}

//Function Number: 79
training_s1_runner_enemy_found_corpse()
{
	clearallcorpses();
}

//Function Number: 80
force_patrol_anim_set(param_00,param_01,param_02)
{
	maps\_patrol_extended::force_patrol_anim_set(param_00,param_01,0,param_02);
}

//Function Number: 81
training_prone_hint_text()
{
	wait(1);
	level.player.showhint = 1;
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		thread maps\_utility::display_hint("prone_prompt");
	}
	else
	{
		thread maps\_utility::display_hint("pc_prone_prompt");
	}

	thread training_prone_hint_monitor();
	var_00 = 8;
	level common_scripts\utility::waittill_notify_or_timeout("player_prone",var_00);
	level.player.showhint = 0;
}

//Function Number: 82
training_prone_hint_monitor()
{
	level endon("training_s1_hide_from_patrols_done");
	while(level.player getstance() != "prone" && common_scripts\utility::flag("training_s1_spotted") == 0)
	{
		wait(0.5);
	}

	level notify("player_prone");
}

//Function Number: 83
training_s1_escape_vehicle_think(param_00,param_01)
{
	self endon("death");
	foreach(var_03 in self.riders)
	{
		var_03 thread training_s1_escape_vehicle_driver(param_00);
	}

	common_scripts\utility::flag_wait(param_01);
	maps\_utility::stop_magic_bullet_shield();
	self delete();
}

//Function Number: 84
training_s1_escape_vehicle_driver(param_00)
{
	self endon("death");
	self.health = 1;
	common_scripts\utility::flag_wait(param_00);
	bloody_death();
}

//Function Number: 85
training_s1_ambush_vehicles_think(param_00,param_01)
{
	self endon("death");
	foreach(var_03 in self.riders)
	{
		var_03 thread training_s1_unload1_think(param_00,param_01);
	}

	self waittill("reached_end_node");
	maps\_vehicle::vehicle_unload();
	common_scripts\utility::flag_wait(param_00);
	self.pacifist = 1;
	foreach(var_03 in self.riders)
	{
		var_03.ignoreall = 1;
		var_03.pacifist = 1;
	}

	common_scripts\utility::flag_wait(param_01);
	self delete();
}

//Function Number: 86
training_s1_unload1_think(param_00,param_01)
{
	self endon("death");
	if(isdefined(self.vehicle_position))
	{
		thread attach_flashlight_on_vehicle_unload();
	}

	common_scripts\utility::flag_wait(param_00);
	self.pacifist = 1;
	self.ignoreall = 1;
	common_scripts\utility::flag_wait(param_01);
	bloody_death();
}

//Function Number: 87
training_s1_kva_ambush1_think(param_00,param_01)
{
	self endon("death");
	thread maps\_utility::disable_long_death();
	thread attach_flashlight_on_gun();
	common_scripts\utility::flag_wait(param_00);
	self.pacifist = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
	maps\_utility::set_battlechatter(0);
	common_scripts\utility::flag_wait(param_01);
	bloody_death();
}

//Function Number: 88
training_s1_kva_ambush2_think(param_00,param_01)
{
	self endon("death");
	thread maps\_utility::disable_long_death();
	thread attach_flashlight_on_gun();
	self.ignoreall = 1;
	maps\_utility::set_goal_radius(40);
	self waittill("goal");
	if(isdefined(self) && isalive(self))
	{
		self.ignoreall = 0;
	}

	common_scripts\utility::flag_wait(param_00);
	self.pacifist = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
	maps\_utility::set_battlechatter(0);
	common_scripts\utility::flag_wait(param_01);
	bloody_death();
}

//Function Number: 89
training_s1_guard_house_doors()
{
	var_00 = getent("guard_door_01","targetname");
	getent(var_00.target,"targetname") linkto(var_00);
	var_01 = getent("guard_door_02","targetname");
	getent(var_01.target,"targetname") linkto(var_01);
	wait(randomint(10));
	var_00 rotateto(var_00.angles + (0,-90,0),1,0,1);
	wait(randomint(5));
	var_01 rotateto(var_01.angles + (0,90,0),1,0,1);
	var_00 connectpaths();
	var_01 connectpaths();
	wait(30);
	var_00 rotateto(var_00.angles + (0,90,0),1,0,1);
	wait(randomint(5));
	var_01 rotateto(var_01.angles + (0,-90,0),1,0,1);
	var_00 disconnectpaths();
	var_01 disconnectpaths();
}

//Function Number: 90
training_door_cover_cloak_think()
{
	var_00 = self getmodelfromentity();
	self setmodel(var_00 + "_cloak");
	self drawpostresolve();
	self setmaterialscriptparam(1,0);
	wait(1);
	self setmaterialscriptparam(0,1.5);
	wait(1.5);
	common_scripts\utility::hide_notsolid();
	common_scripts\utility::flag_wait("training_round_2");
	self setmodel(var_00);
	common_scripts\utility::show_solid();
}

//Function Number: 91
gideon_change_outfit()
{
	if(level.gideon.model == "kva_body_assault")
	{
		if(isdefined(level.gideon.magic_bullet_shield))
		{
			level.gideon maps\_utility::stop_magic_bullet_shield();
		}

		level.gideon delete();
		maps\_utility::clear_color_order("b","allies");
		level.gideon = getent("gideon","targetname") maps\_utility::spawn_ai(1);
		level.gideon.script_pushable = 0;
		var_00 = common_scripts\utility::getstruct("gideon_exo_exit","targetname");
		level.gideon forceteleport(var_00.origin,var_00.angles);
		level.gideon maps\_utility::gun_remove();
	}
}

//Function Number: 92
gideon_change_mask(param_00)
{
	wait(5.5);
	level.gideon detach("head_hero_gideon_mask");
	level.gideon attach("head_hero_gideon_mask_down");
}

//Function Number: 93
stack_make()
{
	var_00 = spawnstruct();
	var_00.contents = [];
	var_00.top = -1;
	var_00.isstack = 1;
	return var_00;
}

//Function Number: 94
stack_push(param_00)
{
	var_01 = self;
	var_01.top++;
	var_01.contents[var_01.top] = param_00;
}

//Function Number: 95
stack_pop()
{
	var_00 = self;
	if(var_00.top < 0)
	{
		return undefined;
	}

	var_01 = var_00.contents[var_00.top];
	var_00.top--;
	return var_01;
}

//Function Number: 96
stack_peek()
{
	var_00 = self;
	return var_00.contents[var_00.top];
}

//Function Number: 97
aim_assist_using_bmodels_init()
{
	if(isdefined(level.aim_assist_with_bmodels))
	{
		return;
	}

	level.aim_assist_with_bmodels = spawnstruct();
	level.aim_assist_with_bmodels.entities = getentarray("script_brushmodel_for_aim_assist","targetname");
	level.aim_assist_with_bmodels.entitiesinuse = [];
	var_00 = stack_make();
	level.aim_assist_with_bmodels.stack = var_00;
	foreach(var_02 in level.aim_assist_with_bmodels.entities)
	{
		var_02.maxhealth = 1000;
		var_02 setnormalhealth(var_02.maxhealth);
		var_02 hide();
		var_00 stack_push(var_02);
	}
}

//Function Number: 98
is_aim_assist_enabled_on_script_model(param_00)
{
	return isdefined(param_00.aim_assist_bmodel);
}

//Function Number: 99
enable_aim_assist_on_script_model(param_00,param_01)
{
	var_02 = level.aim_assist_with_bmodels.stack;
	var_03 = var_02 stack_pop();
	var_03.health = var_03.maxhealth;
	var_03 enableaimassist();
	var_03 linkto(param_00,param_01,(4,0,0),(0,0,0));
	param_00.aim_assist_bmodel = var_03;
	level.aim_assist_with_bmodels.entitiesinuse = common_scripts\utility::array_add(level.aim_assist_with_bmodels.entitiesinuse,var_03);
}

//Function Number: 100
disable_aim_assist_on_script_model(param_00)
{
	var_01 = param_00.aim_assist_bmodel;
	var_01 unlink();
	var_02 = level.aim_assist_with_bmodels.stack;
	var_01 disableaimassist();
	var_02 stack_push(var_01);
	param_00.aim_assist_bmodel = undefined;
	level.aim_assist_with_bmodels.entitiesinuse = common_scripts\utility::array_remove(level.aim_assist_with_bmodels.entitiesinuse,var_01);
}

//Function Number: 101
score_manager_print_final_score(param_00)
{
	var_01 = level.score_keeper.count;
	var_02 = level.score_keeper.max;
	if(param_00 == "holo_range")
	{
		if(var_01 > 2375)
		{
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_ilona");
		}

		if(var_01 < 600)
		{
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_bad");
		}

		if(var_01 >= 600 && var_01 < 1200)
		{
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_average");
		}

		if(var_01 >= 1200 && var_01 < 2000)
		{
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_good");
		}

		if(var_01 >= 2000 && var_01 < 3000)
		{
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_excellent");
		}

		if(var_01 >= 3000)
		{
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_perfect");
		}

		if(var_01 >= 2000)
		{
			maps\_utility::giveachievement_wrapper("LEVEL_2A");
			return;
		}

		return;
	}

	if(param_00 == "grenade_range")
	{
		switch(var_01)
		{
			case 0:
				iprintlnbold("TRY AGAIN");
				break;

			case 1:
				iprintlnbold("AWFUL");
				break;

			case 2:
				iprintlnbold("TERRIBLE");
				break;

			case 3:
				iprintlnbold("TERRIBLE");
				break;

			case 4:
				iprintlnbold("POOR");
				break;

			case 5:
				iprintlnbold("POOR");
				break;

			case 6:
				iprintlnbold("AVERAGE");
				break;

			case 7:
				iprintlnbold("AVERAGE");
				break;

			case 8:
				iprintlnbold("DECENT");
				break;

			case 9:
				iprintlnbold("DECENT");
				break;

			case 10:
				iprintlnbold("GOOD");
				break;

			case 11:
				iprintlnbold("GOOD");
				break;

			case 12:
				iprintlnbold("GREAT");
				break;

			case 13:
				iprintlnbold("GREAT");
				break;

			case 14:
				iprintlnbold("AWESOME");
				break;

			case 15:
				iprintlnbold("AWESOME");
				break;

			case 16:
				iprintlnbold("PERFECT");
				break;
		}

		return;
	}

	if(param_00 == "drone_range")
	{
		return;
	}
}

//Function Number: 102
score_manager_print_current_score()
{
}

//Function Number: 103
score_manager_detect_timeout(param_00)
{
	level.score_keeper endon("score_manager_timed_out");
	wait(param_00);
	level.score_keeper notify("score_manager_timed_out");
}

//Function Number: 104
score_manager_increase_score(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_00.team) && param_00.team == level.player.team)
	{
		common_scripts\utility::flag_set("flag_vo_shooting_range_friendly");
		level.score_keeper.count = level.score_keeper.count - param_01;
		if(param_01 == 25)
		{
			playfx(level._effect["recovery_scoring_minus25"],param_00.origin + (0,0,80));
		}

		if(param_01 == 50)
		{
			playfx(level._effect["recovery_scoring_minus50"],param_00.origin + (0,0,80));
		}

		if(param_01 == 75)
		{
			playfx(level._effect["recovery_scoring_minus75"],param_00.origin + (0,0,80));
		}

		if(param_01 == 100)
		{
			playfx(level._effect["recovery_scoring_minus100"],param_00.origin + (0,0,80));
		}
	}
	else
	{
		level.score_keeper.count = level.score_keeper.count + param_01;
		if(param_01 == 25)
		{
			playfx(level._effect["recovery_scoring_add25"],param_00.origin + (0,0,80));
		}

		if(param_01 == 50)
		{
			playfx(level._effect["recovery_scoring_add50"],param_00.origin + (0,0,80));
		}

		if(param_01 == 75)
		{
			playfx(level._effect["recovery_scoring_add75"],param_00.origin + (0,0,80));
		}

		if(param_01 == 100)
		{
			playfx(level._effect["recovery_scoring_add100"],param_00.origin + (0,0,80));
		}
	}

	level.score_keeper notify("score_manager_score_increased");
	score_manager_print_current_score();
}

//Function Number: 105
score_manager_waittill_timeout_or_maxscore(param_00,param_01)
{
	level.score_keeper endon("score_manager_timed_out");
	level.score_keeper thread score_manager_detect_timeout(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.score_keeper.max - level.score_keeper.count;
	}

	while(param_01 > 0)
	{
		level.score_keeper waittill("score_manager_score_increased");
		param_01--;
	}

	level.score_keeper notify("score_manager_timed_out");
}

//Function Number: 106
score_manager_force_stop()
{
	level.score_keeper notify("score_manager_timed_out");
}

//Function Number: 107
score_manager_init(param_00)
{
	if(!isdefined(level.score_keeper))
	{
		level.score_keeper = spawnstruct();
	}

	level.score_keeper.count = 0;
	level.score_keeper.max = param_00;
	level.score_keeper notify("score_manager_timed_out");
}

//Function Number: 108
score_manager_detect_enemy_death()
{
	level.score_keeper endon("score_manager_timed_out");
	self endon("score_manager_detect_enemy_death_stop");
	common_scripts\utility::waittill_either("death","pain_death");
	score_manager_increase_score(self);
}

//Function Number: 109
score_manager_detect_damage(param_00,param_01)
{
	level.score_keeper endon("score_manager_timed_out");
	var_02 = level.score_keeper.stats;
	self setcandamage(1);
	var_03 = undefined;
	var_04 = undefined;
	while(!isdefined(var_03) || var_03 == "MOD_CRUSH")
	{
		self waittill("damage",var_05,var_06,var_07,var_08,var_03,var_09,var_0A,var_04,var_0B);
	}

	if(isdefined(param_00) && param_00 == 1)
	{
		var_0C = self gettagorigin("tag_head");
		var_0D = self gettagorigin("tag_chest");
		var_0E = self gettagorigin("tag_arms");
		var_0F = self gettagorigin("tag_legs");
		level.score_keeper notify("score_change");
		playfx(level._effect["expround_asphalt_1"],self.origin);
		if(isdefined(param_01) && param_01)
		{
			playfx(level._effect["recovery_scoring_target_shutter_enemy"],var_0D);
			var_02.enemy_kills++;
			if(var_04 == "tag_head")
			{
				score_manager_increase_score(self,100);
				var_02.enemy_headshots++;
			}
			else if(var_04 == "tag_chest")
			{
				score_manager_increase_score(self,75);
				var_02.enemy_chestshots++;
			}
			else if(var_04 == "tag_arms")
			{
				score_manager_increase_score(self,50);
				var_02.enemy_armshots++;
			}
			else if(var_04 == "tag_legs")
			{
				score_manager_increase_score(self,50);
				var_02.enemy_legshots++;
			}

			soundscripts\_snd::snd_message("shooting_range_enemy_shot",self,var_04);
		}
		else
		{
			playfx(level._effect["recovery_scoring_target_shutter_friendly"],var_0D);
			var_02.civ_kills++;
			if(var_04 == "tag_head")
			{
				score_manager_increase_score(self,100);
				var_02.civ_headshots++;
			}
			else if(var_04 == "tag_chest")
			{
				score_manager_increase_score(self,75);
				var_02.civ_chestshots++;
			}
			else if(var_04 == "tag_arms")
			{
				score_manager_increase_score(self,50);
				var_02.civ_armshots++;
			}
			else if(var_04 == "tag_legs")
			{
				score_manager_increase_score(self,50);
				var_02.civ_legshots++;
			}

			soundscripts\_snd::snd_message("shooting_range_friendly_shot",self,var_04);
		}
	}
	else
	{
		score_manager_increase_score(self,1);
		playfx(level._effect["frag_grenade_default"],self.origin);
		soundscripts\_snd_playsound::snd_play_linked("wpn_grenade_exp");
	}

	self notify("target_hit");
}

//Function Number: 110
wait_for_primary_weapon_pickup()
{
	level endon("shooting_range_started_once");
	level.player waittill("weapon_switch_started");
	for(;;)
	{
		var_00 = level.player getcurrentweapon();
		if(var_00 != "none")
		{
			break;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("flag_obj_equip_firing_range");
	common_scripts\utility::flag_set("flag_vo_shooting_range_02");
}

//Function Number: 111
attach_flashlight_on_gun()
{
	hand_flashlight_remove();
	if(!isdefined(self.gun_flashlight) || !self.gun_flashlight)
	{
		playfxontag(level._effect["flashlight"],self,"tag_flash");
		self.gun_flashlight = 1;
		self notify("flashlight_on_gun");
	}
}

//Function Number: 112
gun_flashlight_off()
{
	if(isdefined(self.gun_flashlight) && self.gun_flashlight)
	{
		stopfxontag(level._effect["flashlight"],self,"tag_flash");
		self.gun_flashlight = 0;
	}
}

//Function Number: 113
attach_flashlight_in_hand()
{
	if(isdefined(self.hand_flashlight))
	{
		return;
	}

	gun_flashlight_off();
	var_00 = "TAG_INHAND";
	self.hand_flashlight = spawn("script_model",self.origin);
	var_01 = self.hand_flashlight;
	var_01.owner = self;
	var_01.origin = self gettagorigin(var_00);
	var_01.angles = self gettagangles(var_00);
	var_01 setmodel("com_flashlight_on");
	var_01 linkto(self,var_00);
	var_01 thread hand_flashlight_watch_for_drop();
	thread hand_flashlight_handle_alert();
	thread hand_flashlight_handle_node_pause();
	thread hand_flashlight_handle_effects();
	hand_flashlight_on();
}

//Function Number: 114
hand_flashlight_watch_for_drop()
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.owner) || self.owner.health <= 0)
		{
			stopfxontag(common_scripts\utility::getfx("flashlight"),self,"tag_light");
			return;
		}

		wait(0.2);
	}
}

//Function Number: 115
hand_flashlight_on()
{
	self.hand_flashlight setmodel("com_flashlight_on");
	playfxontag(common_scripts\utility::getfx("flashlight"),self.hand_flashlight,"tag_light");
}

//Function Number: 116
hand_flashlight_off()
{
	self.hand_flashlight setmodel("com_flashlight_off");
	stopfxontag(common_scripts\utility::getfx("flashlight"),self.hand_flashlight,"tag_light");
}

//Function Number: 117
hand_flashlight_remove()
{
	if(isdefined(self.hand_flashlight))
	{
		hand_flashlight_off();
		self.hand_flashlight delete();
		self notify("stop_flashlight_thread");
	}
}

//Function Number: 118
hand_flashlight_should_hide(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.script_animation) && param_00.script_animation != "pause")
	{
		return 1;
	}

	if(isdefined(param_00.script_delay))
	{
		return 1;
	}

	return 0;
}

//Function Number: 119
hand_flashlight_handle_alert()
{
	self endon("death");
	self endon("stop_flashlight_thread");
	common_scripts\utility::waittill_any("death","remove_flashlight","enemy","reached_path_end");
	wait(0.1);
	if(isalive(self))
	{
		thread attach_flashlight_on_gun();
	}
}

//Function Number: 120
hand_flashlight_handle_node_pause()
{
	self endon("death");
	self endon("remove_flashlight");
	self endon("stop_flashlight_thread");
	for(;;)
	{
		self waittill("goal");
		if(hand_flashlight_should_hide(self.last_patrol_goal))
		{
			self notify("flashlight_off");
			self waittill("release_node");
			self notify("flashlight_on");
		}
	}
}

//Function Number: 121
hand_flashlight_handle_effects()
{
	self endon("death");
	self endon("remove_flashlight");
	self endon("stop_flashlight_thread");
	for(;;)
	{
		self waittill("flashlight_off");
		hand_flashlight_off();
		self waittill("flashlight_on");
		hand_flashlight_on();
	}
}

//Function Number: 122
attach_flashlight_on_vehicle_unload()
{
	self waittill("jumping_out");
	attach_flashlight_on_gun();
}

//Function Number: 123
training_stealth_spotted()
{
	common_scripts\utility::flag_wait("_stealth_spotted");
	thread training_s2_set_squad_active_and_target();
	common_scripts\utility::flag_set("training_s2_start_alerted");
	common_scripts\utility::flag_set("flag_vo_training_s2_joker_here_they");
	common_scripts\utility::flag_set("flag_obj_rescue2_entrance_clear");
	wait(3);
	if(level.player maps\_player_exo::overdrive_is_on() == 0)
	{
		if(level.player.exobatterylevel == 0)
		{
			maps\recovery_code::give_overdrive_battery();
		}

		common_scripts\utility::flag_set("flag_vo_training_s2_gideon_use_overdrive");
		thread maps\_utility::display_hint_timeout("overdrive_prompt_sim",3);
	}
}

//Function Number: 124
training_s1_golf_course_custom_stealth()
{
	var_00 = [];
	var_00["prone"] = 150;
	var_00["crouch"] = 400;
	var_00["stand"] = 400;
	maps\_stealth_visibility_system::system_set_detect_ranges(var_00);
	var_01 = [];
	var_01["player_dist"] = 1500;
	var_01["sight_dist"] = 480;
	var_01["detect_dist"] = 240;
	var_01["found_dist"] = 96;
	var_01["found_dog_dist"] = 60;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_01);
}

//Function Number: 125
training_reset_stealth_settings()
{
	maps\_stealth_utility::stealth_corpse_ranges_default();
}

//Function Number: 126
training_s2_squad_allow_run()
{
	if(isalive(level.gideon))
	{
		level.gideon allowedstances("prone","crouch","stand");
	}

	if(isalive(level.joker))
	{
		level.joker allowedstances("prone","crouch","stand");
	}

	if(isalive(level.ally_s2_squad_member_1))
	{
		level.ally_s2_squad_member_1 allowedstances("prone","crouch","stand");
	}
}

//Function Number: 127
training_s2_enemies_start_think(param_00,param_01,param_02)
{
	self endon("death");
	thread attach_flashlight_on_gun();
	thread maps\_utility::set_battlechatter(0);
	maps\_utility::disable_long_death();
	thread training_s2_enemies_start_think_alerted(param_00);
	thread training_s2_starting_enemy_charge(param_01);
	common_scripts\utility::flag_wait(param_02);
	bloody_death();
}

//Function Number: 128
training_s2_enemies_start_think_alerted(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	maps\_utility::waittill_aigroupcount("training_s2_starting_enemies",17);
	self notify("alerted");
	maps\_utility::set_battlechatter(1);
	var_01 = getnode("training_s2_enemy_attack_node4","targetname");
	if(isdefined(var_01))
	{
		self.goalradius = 200;
		maps\_utility::set_forcegoal();
		maps\_utility::set_goal_node(var_01);
		self waittill("goal");
		maps\_utility::unset_forcegoal();
	}
}

//Function Number: 129
training_s2_enemies_start2_think(param_00,param_01,param_02)
{
	self endon("death");
	thread attach_flashlight_on_gun();
	thread maps\_utility::set_battlechatter(0);
	maps\_utility::disable_long_death();
	thread training_s2_enemies_start2_think_alerted(param_00);
	thread training_s2_starting_enemy_charge(param_01);
	common_scripts\utility::flag_wait(param_02);
	bloody_death();
}

//Function Number: 130
training_s2_enemies_start2_think_alerted(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	maps\_utility::waittill_aigroupcount("training_s2_starting_enemies",11);
	self notify("alerted");
	var_01 = getnode("training_s2_enemy_attack_node8","targetname");
	thread maps\_utility::set_battlechatter(1);
	if(isdefined(var_01))
	{
		self.goalradius = 32;
		maps\_utility::set_forcegoal();
		maps\_utility::set_goal_node(var_01);
		self waittill("goal");
		maps\_utility::unset_forcegoal();
	}
}

//Function Number: 131
training_s2_enemies_patrol_think(param_00,param_01,param_02)
{
	self endon("death");
	thread attach_flashlight_on_gun();
	thread maps\_utility::set_battlechatter(0);
	maps\_utility::disable_long_death();
	thread training_s2_enemy_notify(param_00);
	thread training_s2_enemies_patrol_think_alerted(param_00);
	thread training_s2_starting_enemy_charge(param_01);
	common_scripts\utility::flag_wait(param_02);
	bloody_death();
}

//Function Number: 132
training_s2_starting_enemy_charge(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	maps\_utility::player_seek();
}

//Function Number: 133
training_s2_enemy_notify(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any_ents(self,"patrol_alerted",self,"_stealth_spotted",self,"stealth_event",self,"_stealth_found_corpse",self,"alerted",self,"enemy");
	wait(2);
	self notify("alerted");
	common_scripts\utility::flag_set("_stealth_spotted");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 134
training_s2_enemies_patrol_think_alerted(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	self.ignoreall = 0;
	self.ignoreme = 0;
	thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	self notify("alerted");
	maps\_utility::set_battlechatter(1);
}

//Function Number: 135
training_s2_enemies_living_room_think(param_00)
{
	self endon("death");
	if(isdefined(self.animation))
	{
		thread maps\_utility::anim_stopanimscripted();
	}

	var_01 = getent("training_s1_threat_react_origin","targetname");
	var_02 = var_01.origin;
	thread maps\_stealth_shared_utilities::enemy_reactto_and_lookaround(var_02);
	self notify("alert");
	thread maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	thread maps\_stealth_utility::disable_stealth_for_ai();
	thread maps\_utility::set_battlechatter(1);
	wait(randomfloatrange(0.25,1));
	var_03 = self findbestcovernode();
	if(isdefined(var_03))
	{
		maps\_utility::set_goal_node(var_03);
	}
}

//Function Number: 136
training_s2_threat_death_check()
{
	self waittill("death");
	if(common_scripts\utility::flag("training_s2_flag_thermal") == 0)
	{
		level.threat_attack = "nil";
		common_scripts\utility::flag_set("training_s2_flag_thermal");
	}
}

//Function Number: 137
training_s2_living_room_check()
{
	maps\_utility::waittill_aigroupcleared("training_s2_enemies_living_room");
	level.living_room_clear = 1;
}

//Function Number: 138
training_s2_living_room_timer()
{
	wait(15);
	level.living_room_clear = 1;
}

//Function Number: 139
training_s2_enemies_hall_think()
{
	self endon("death");
	maps\_utility::disable_long_death();
}

//Function Number: 140
training_s2_threat_door()
{
	var_00 = common_scripts\utility::getstruct("training_s1_flashbang_animnode","targetname");
	var_01 = getent("training_s1_flash_door","targetname");
	var_01.animname = "door_prop";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("living_room_door_clip","targetname");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"training_s2_threat_door_open");
	var_02 linkto(var_01,"door");
	common_scripts\utility::flag_wait("training_s2_peak_thermal_door");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s2_threat_door_open");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"training_s2_threat_door_open_idle","stop_loop");
	common_scripts\utility::flag_wait("training_s2_open_thermal_door");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s2_threat_door_out");
	var_02 connectpaths();
	common_scripts\utility::flag_wait("training_s2_breach_done");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"training_s2_threat_door_open");
	wait(1);
	var_02 disconnectpaths();
}

//Function Number: 141
training_s2_flash_monitor()
{
	level.threat_attack = "nil";
	level.player waittill("grenade_fire",var_00,var_01);
	var_00 waittill("death");
	if(var_01 == "paint_grenade_var")
	{
		level.threat_attack = "threat";
	}
	else
	{
		level.threat_attack = "other";
	}

	common_scripts\utility::flag_set("training_s2_flag_thermal");
}

//Function Number: 142
training_s2_kill_threat_enemies()
{
	self endon("death");
	wait(5);
	if(isalive(self))
	{
		magicbullet(level.gideon.weapon,level.gideon gettagorigin("tag_flash"),self geteye());
		bloody_death();
	}
}

//Function Number: 143
training_s2_start_squad_attack(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	training_s2_set_squad_active_and_target();
}

//Function Number: 144
training_s2_opening_guy_think(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	self forceteleport(var_01.origin,var_01.angles);
	self setgoalpos(self.origin);
	self allowedstances("crouch");
	maps\_stealth_utility::stealth_plugin_basic();
	maps\_stealth_utility::stealth_plugin_accuracy();
	maps\_stealth_utility::stealth_plugin_smart_stance();
	maps\_utility::disable_surprise();
	if(!isdefined(level.allies_s2))
	{
		level.allies_s2 = [];
	}

	level.allies_s2 = common_scripts\utility::array_add(level.allies_s2,self);
}

//Function Number: 145
training_s1_clear_bedrooms(param_00)
{
	wait(2);
	var_01 = getent("bedroom_1_door","targetname");
	getent(var_01.target,"targetname") linkto(var_01);
	var_02 = 1;
	var_01 rotateto(var_01.angles + (0,145,0),var_02,0.05,0.05);
	var_01 common_scripts\utility::delaycall(var_02,::connectpaths);
	var_01 common_scripts\utility::delaycall(2,::disconnectpaths);
	var_03 = getent("bedroom_2_door","targetname");
	getent(var_03.target,"targetname") linkto(var_03);
	var_03.angles = var_03.angles + (0,85,0);
	var_03 connectpaths();
	var_03 disconnectpaths();
	maps\_utility::array_spawn_noteworthy("training_s1_bedroom_spawners",1);
	common_scripts\utility::flag_wait(param_00);
	var_01 rotateto(var_01.angles + (0,-145,0),var_02,0.05,0.05);
	var_01 common_scripts\utility::delaycall(var_02,::connectpaths);
	var_01 common_scripts\utility::delaycall(2,::disconnectpaths);
	var_03.angles = var_03.angles + (0,-85,0);
	var_03 connectpaths();
	var_03 disconnectpaths();
}

//Function Number: 146
training_s1_bedroom_spawners_think()
{
	maps\_utility::set_battlechatter(0);
	bloody_death();
}

//Function Number: 147
training_s2_drone_manager()
{
	common_scripts\utility::flag_set("training_s2_drone_start");
	level notify("training_s2_drone_start");
	level.player setweaponhudiconoverride("actionslot3","dpad_icon_drone_off");
	common_scripts\utility::flag_set("flag_disable_exo");
	training_s2_player_drone_control();
	common_scripts\utility::flag_clear("flag_disable_exo");
	common_scripts\utility::flag_clear("flag_player_using_drone");
	common_scripts\utility::flag_set("training_s2_drone_attack_done");
}

//Function Number: 148
training_s2_player_drone_control()
{
	var_00 = getent("training_s2_pdrone","targetname");
	var_01 = common_scripts\utility::getstruct("pdrone_player_spawnstruct_1","targetname");
	var_02 = common_scripts\utility::getstruct("pdrone_player_nothreat_return","targetname");
	var_03 = getnode("pdrone_player_spawnnode_1","targetname");
	var_04 = vehicle_scripts\_pdrone_player::pdrone_deploy(var_00,0,var_01);
	vehicle_scripts\_pdrone_player::pdrone_player_use(var_04,"training_drone_space",undefined,undefined);
	var_04 vehicle_scripts\_pdrone_player::pdrone_player_add_vehicle_target("script_noteworthy","training_s2_patio_vehicles");
	level.player.drone = var_04;
	var_04 vehicle_scripts\_pdrone_player::pdrone_player_enter(1,var_03,var_02);
	soundscripts\_snd::snd_message("rec_player_drone_start",var_04);
	var_04 vehicle_scripts\_pdrone_player::pdrone_player_loop();
	soundscripts\_snd::snd_message("rec_player_drone_end");
	if(var_04.customhealth <= 0)
	{
		common_scripts\utility::flag_set("flag_vo_training_s2_gideon_drone_down");
	}

	var_04 vehicle_scripts\_pdrone_player::pdrone_player_exit(1);
	var_04 delete();
}

//Function Number: 149
training_s2_enemies_patio_think(param_00,param_01,param_02)
{
	self endon("death");
	thread maps\_stealth_utility::enable_stealth_for_ai();
	maps\_utility::disable_long_death();
	self thermaldrawenable();
	thread attach_flashlight_on_gun();
	thread maps\_stealth_utility::disable_stealth_system();
	self notify("awareness_alert_level","warning");
	thread maps\_utility::set_battlechatter(1);
	common_scripts\utility::flag_wait(param_02);
	thread maps\_utility::player_seek_enable();
	common_scripts\utility::flag_wait(param_00);
	bloody_death();
}

//Function Number: 150
training_s2_patio_enemies_alert_think()
{
	self endon("death");
	common_scripts\utility::waittill_any_ents(self,"patrol_alerted",self,"_stealth_spotted",self,"stealth_event",self,"_stealth_found_corpse",self,"alerted",self,"enemy");
	self notify("alerted");
	common_scripts\utility::flag_set("training_s2_patio_alert");
}

//Function Number: 151
training_s2_patio_enemies_damaged(param_00)
{
	self endon("death");
	self waittill("damage");
	maps\_stealth_utility::disable_stealth_system();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 152
training_s2_shield_tutorial()
{
	if(level.player maps\_player_exo::exo_shield_is_on() == 0)
	{
		if(level.player.exobatterylevel == 0)
		{
			maps\recovery_code::give_overdrive_battery();
		}

		common_scripts\utility::flag_set("flag_vo_training_s2_gideon_use_your_shield");
		thread maps\_utility::display_hint_timeout("shield_prompt_sim",3);
	}
}

//Function Number: 153
training_s1_drone_attack_think()
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	self laseron();
	if(isdefined(self.animation))
	{
		self.animname = "drone";
		var_00 = getent("training_s1_drone_attack_scene","targetname");
		var_00 maps\_anim::anim_first_frame_solo(self,self.animation);
		var_00 thread maps\_anim::anim_single_solo(self,self.animation);
	}
}

//Function Number: 154
training_s2_drone_ambush_attack_think()
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	self laseron();
	common_scripts\utility::flag_wait("training_s2_living_room_drone_attack_done");
	wait(randomfloatrange(0.5,1.5));
	self notify("death");
}

//Function Number: 155
training_s2_drone_attack_think(param_00,param_01)
{
	self endon("death");
	self.pacifist = 1;
	thread maps\_shg_utility::make_emp_vulnerable();
	self laseron();
	thread training_s2_drone_damaged(param_01);
	thread training_s2_drone_attack_death(param_01);
	common_scripts\utility::flag_wait(param_01);
	self notify("awareness_alert_level","warning");
	self.pacifist = 0;
	self.ignoreall = 0;
	self.engage_enemy = 1;
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 156
training_s2_drone_damaged(param_00)
{
	self endon("death");
	self waittill("damage");
	maps\_stealth_utility::disable_stealth_system();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 157
training_s2_drone_attack_death(param_00)
{
	self waittill("death");
	level.drones_s2_dead = level.drones_s2_dead + 1;
	maps\_stealth_utility::disable_stealth_system();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 158
set_tv_screen_broken()
{
	var_00 = getentarray("tv_screen_broken","targetname");
	var_01 = getentarray("tv_screen_unbroken","targetname");
	foreach(var_03 in var_00)
	{
		var_03 common_scripts\utility::show_solid();
	}

	foreach(var_03 in var_01)
	{
		var_03 common_scripts\utility::hide_notsolid();
	}
}

//Function Number: 159
set_tv_screen_unbroken()
{
	var_00 = getentarray("tv_screen_broken","targetname");
	var_01 = getentarray("tv_screen_unbroken","targetname");
	foreach(var_03 in var_00)
	{
		var_03 common_scripts\utility::hide_notsolid();
	}

	foreach(var_03 in var_01)
	{
		var_03 common_scripts\utility::show_solid();
	}
}

//Function Number: 160
training_s1_breack_tv_screen()
{
	set_tv_screen_unbroken();
	common_scripts\utility::flag_wait("training_s1_flag_screen_smash");
	set_tv_screen_broken();
}

//Function Number: 161
training_s1_breach_enemy_think()
{
	self endon("death");
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	self.animname = "generic";
	self.ignoreme = 1;
	maps\_utility::disable_long_death();
	self.ignoresonicaoe = 1;
	if(self.animation == "training_s1_exo_breach_kva2_start")
	{
		thread training_s1_breach_enemy_death_check();
		self endon("killed");
		var_00 maps\_anim::anim_first_frame_solo(self,self.animation);
		thread training_s1_breach_enemy_stop_death_check();
		var_00 maps\_anim::anim_single_solo(self,self.animation);
		self.noragdoll = 1;
		self.a.nodeath = 1;
		self.allowdeath = 1;
		maps\_utility::set_battlechatter(0);
		self kill();
		return;
	}

	if(self.animation == "training_s1_exo_breach_kva3_start")
	{
		self disableaimassist();
	}

	self.allowdeath = 0;
	var_00 maps\_anim::anim_first_frame_solo(self,self.animation);
	var_00 maps\_anim::anim_single_solo(self,self.animation);
	self.noragdoll = 1;
	self.allowdeath = 1;
	self.a.nodeath = 1;
	maps\_utility::set_battlechatter(0);
	self kill();
}

//Function Number: 162
training_s1_breach_enemy_stop_death_check()
{
	self endon("death");
	self endon("killed");
	wait(7);
	self notify("killed2");
}

//Function Number: 163
training_s1_breach_enemy_death_check()
{
	self endon("death");
	self endon("killed2");
	var_00 = 0;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	while(var_00 < 5)
	{
		self waittill("damage",var_05,var_04,var_06,var_01,var_02,var_07,var_08,var_03,var_09,var_0A);
		var_00 = var_00 + var_05;
	}

	if(isdefined(var_01) && isdefined(var_02) && isplayer(var_04))
	{
		if(var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_01);
			soundscripts\_snd::snd_message("rec_chair_kva_gets_shot",var_01);
		}

		self notify("killed");
		self stopanimscripted();
		var_0B = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
		var_0B maps\_anim::anim_single_solo(self,"training_s1_exo_breach_kva2_death");
		self.noragdoll = 1;
		self.allowdeath = 1;
		self.a.nodeath = 1;
		maps\_utility::set_battlechatter(0);
		self kill();
	}
}

//Function Number: 164
training_s1_breach_enemy_monitor_death()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	while(var_00 < 5)
	{
		self waittill("damage",var_04,var_05,var_06,var_01,var_02,var_07,var_08,var_03,var_09,var_0A);
		var_00 = var_00 + var_04;
	}

	if(isdefined(var_01) && isdefined(var_02))
	{
		if(var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_01);
			soundscripts\_snd::snd_message("rec_kva_with_president_gets_shot",var_01);
		}
	}

	thread training_s1_breach_slomo_end();
	if(common_scripts\utility::flag("training_s1_flag_president_dead") == 0)
	{
		common_scripts\utility::flag_set("training_s1_breach_enemy_dead");
		var_0B = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
		var_0B thread maps\_anim::anim_single_solo(self,"training_s1_exo_breach_kva1_success");
		wait 0.05;
		self.noragdoll = 1;
		self.allowdeath = 1;
		self.a.nodeath = 1;
		maps\_utility::set_battlechatter(0);
		self kill();
	}
	else
	{
		self.allowdeath = 1;
		maps\_utility::set_battlechatter(0);
		self kill();
	}

	if(var_03 == "j_head")
	{
		waittillframeend;
		level.player.hud_damagefeedback fadeovertime(0.05);
		level.player.hud_damagefeedback.alpha = 0;
		level.player maps\_damagefeedback::updatedamagefeedback(self,1);
		level.player maps\_upgrade_challenge::give_player_challenge_headshot(1);
	}
	else
	{
		level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
	}

	wait(1);
	level.player.hud_damagefeedback fadeovertime(1);
}

//Function Number: 165
training_s1_breach_slomo_end()
{
	var_00 = 0.65;
	maps\_utility::slowmo_setlerptime_out(var_00);
	maps\_utility::slowmo_lerp_out();
	maps\_utility::slowmo_end();
	level.player setmovespeedscale(1);
}

//Function Number: 166
training_s1_breach_kva_think()
{
	self endon("shot");
	self endon("death");
	self.ignoresonicaoe = 1;
	self.animname = "generic";
	self.ignoreme = 1;
	self.allowdeath = 0;
	maps\_utility::disable_long_death();
	maps\_utility::forceuseweapon("iw5_titan45_sp","primary");
	thread maps\_utility::set_battlechatter(0);
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	thread training_s1_breach_enemy_monitor_death();
	var_00 maps\_anim::anim_first_frame_solo(self,"training_s1_exo_breach_kva1_start");
	var_00 maps\_anim::anim_single_solo(self,"training_s1_exo_breach_kva1_start");
	var_00 thread maps\_anim::anim_loop_solo(self,"training_s1_exo_breach_kva1_idle","stop_loop");
	wait(1.5);
	var_00 notify("stop_loop");
	level.president notify("stop_idle_loop_s1");
	if(common_scripts\utility::flag("training_s1_breach_enemy_dead") == 0)
	{
		var_00 maps\_anim::anim_single_solo(self,"training_s1_exo_breach_kva1_fail");
	}
}

//Function Number: 167
training_s1_president_breach_setup(param_00)
{
	self endon("death");
	self.allowdeath = 0;
	self.animname = "president";
	self.name = "POTUS";
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	thread maps\_utility::set_battlechatter(0);
	thread training_s1_president_breach_monitor_death();
	self.team = "allies";
	level maps\_utility::clear_color_order("y","allies");
	maps\_utility::set_force_color("y");
	common_scripts\utility::flag_wait(param_00);
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self delete();
}

//Function Number: 168
training_s1_president_dead()
{
	common_scripts\utility::flag_wait("training_s1_flag_president_shot");
	playfxontag(common_scripts\utility::getfx("recovery_blood_impact_burst"),level.president,"j_head");
	common_scripts\utility::flag_set("training_s1_flag_president_dead");
	level.president notify("shot");
	soundscripts\_snd::snd_message("rec_s1_president_killed");
	wait(2);
	setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_DEAD");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 169
training_s1_president_breach_monitor_death()
{
	self endon("breach_s1_end");
	var_00 = 0;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	while(var_00 < 5)
	{
		self waittill("damage",var_05,var_04,var_06,var_01,var_02,var_07,var_08,var_03,var_09,var_0A);
		var_00 = var_00 + var_05;
	}

	if(isdefined(var_01) && isdefined(var_02) && isplayer(var_04))
	{
		if(var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_01);
			soundscripts\_snd::snd_message("rec_plr_kills_president",var_01);
		}
	}

	common_scripts\utility::flag_set("training_s1_flag_president_dead");
	self.allowdeath = 1;
	self kill();
	if(isplayer(var_04))
	{
		setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_MURDERED");
	}
	else
	{
		setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_DEAD");
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 170
training_s1_bathroom_enemy_think()
{
	self endon("death");
	self.ignoresonicaoe = 1;
	self.animname = "kva";
	self.ignoreme = 1;
	self.allowdeath = 1;
	self.health = 1;
	maps\_utility::disable_long_death();
	thread training_s1_bathroom_enemy_flag_death();
	thread training_s1_bathroom_force_death();
	thread maps\_utility::set_battlechatter(0);
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	thread training_s1_bathroom_enemy_dialog();
	var_00 maps\_anim::anim_first_frame_solo(self,"training_s1_exo_breach_kva_bathroom_start");
	var_00 maps\_anim::anim_single_solo(self,"training_s1_exo_breach_kva_bathroom_start");
	self.allowdeath = 0;
	self.health = 100;
	var_00 thread maps\_anim::anim_loop_solo(self,"training_s1_exo_breach_kva_bathroom_idle","stop_loop");
	self.ignoreme = 0;
	level.joker.ignoreall = 0;
	thread training_s1_bathroom_enemy_monitor_death();
	self waittill("shot");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo(self,"training_s1_exo_breach_kva_bathroom_death");
	self.noragdoll = 1;
	self.allowdeath = 1;
	self.a.nodeath = 1;
	wait(0.05);
	self kill();
}

//Function Number: 171
training_s1_bathroom_enemy_dialog()
{
	self endon("death");
	wait(3.5);
	common_scripts\utility::flag_set("flag_vo_training_s1_kva_what");
}

//Function Number: 172
training_s1_bathroom_enemy_monitor_death()
{
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(isdefined(var_03) && isdefined(var_04))
	{
		if(var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_03);
		}
	}

	self notify("shot");
}

//Function Number: 173
training_s1_bathroom_enemy_flag_death()
{
	self waittill("death");
	common_scripts\utility::flag_set("training_s1_bathroom_enemy_dead");
}

//Function Number: 174
training_s1_bathroom_force_death()
{
	common_scripts\utility::flag_wait("training_s1_flag_bathroom_guy_shot");
	self kill();
}

//Function Number: 175
training_s1_exo_breach_monitor_enemy_group_death()
{
	maps\_utility::waittill_aigroupcleared("training_s1_enemies_breach");
	common_scripts\utility::flag_set("training_s1_exo_breach_clear");
}

//Function Number: 176
training_s1_enemies_ambush_think(param_00)
{
	self endon("death");
	thread maps\_utility::disable_long_death();
	attach_flashlight_on_gun();
	common_scripts\utility::flag_wait(param_00);
	bloody_death();
}

//Function Number: 177
training_s2_enemies_ambush_think(param_00)
{
	self endon("death");
	thread maps\_utility::disable_long_death();
	attach_flashlight_on_gun();
	common_scripts\utility::flag_wait(param_00);
	bloody_death();
}

//Function Number: 178
training_s1_joker_move()
{
	level endon("training_s1_living_room_scene");
	var_00 = common_scripts\utility::getstruct("training_s1_flashbang_animnode","targetname");
	common_scripts\utility::flag_wait("training_s1_start_alerted");
	maps\_utility::waittill_aigroupcleared("training_s1_start");
	maps\_utility::waittill_aigroupcleared("training_s1_enemies_start");
	var_00 maps\_anim::anim_reach_solo(level.joker,"training_s1_threat_guy_in");
	var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_threat_guy_in");
}

//Function Number: 179
training_s1_patio_door_breach()
{
	var_00 = common_scripts\utility::getstruct("training_s2_patio_door_animnode","targetname");
	common_scripts\utility::flag_set("training_s1_patio_doors_joker_in");
	var_00 maps\_anim::anim_reach_solo(level.joker,"training_s1_patio_joker_door_in");
	var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_patio_joker_door_in");
	var_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_patio_joker_door_idle","stop_loop1");
	thread training_s1_patio_door_breach_monitor(var_00);
	common_scripts\utility::flag_wait("training_s1_joker_search_drones_cover");
	level.joker maps\_utility::cqb_walk("on");
	if(common_scripts\utility::flag("training_s1_search_drones_attack") == 1)
	{
		var_00 notify("stop_loop2");
		var_00 thread maps\_anim::anim_single_solo_run(level.joker,"training_s1_patio_joker_door_out");
		common_scripts\utility::flag_set("training_s1_breach_patio_doors_open");
	}
	else
	{
		var_00 notify("stop_loop1");
		var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_patio_joker_door_slow_in");
		common_scripts\utility::flag_set("training_s1_slow_patio_doors_open");
		var_00 maps\_anim::anim_single_solo(level.joker,"training_s1_patio_joker_door_slow_open");
		var_00 thread maps\_anim::anim_single_solo_run(level.joker,"training_s1_patio_joker_door_slow_out");
	}

	level notify("advance_to_patio");
}

//Function Number: 180
training_s1_patio_door_breach_monitor(param_00)
{
	self endon("training_s1_search_drones_done");
	common_scripts\utility::flag_wait("training_s1_search_drones_attack");
	param_00 notify("stop_loop1");
	param_00 thread maps\_anim::anim_loop_solo(level.joker,"training_s1_patio_joker_door_alert_idle","stop_loop2");
}

//Function Number: 181
training_s1_patio_door_clip()
{
	var_00 = getent("french_door_clip_01","targetname");
	var_01 = getent("french_door_clip_02","targetname");
	var_02 = getent("training_patio_french_doors","targetname");
	var_00 linkto(var_02,"door_r");
	var_01 linkto(var_02,"door_l");
	var_00 connectpaths();
	var_01 connectpaths();
	common_scripts\utility::flag_wait("training_s1_end");
	wait(1);
	var_00 disconnectpaths();
	var_01 disconnectpaths();
}

//Function Number: 182
training_s2_breach_enemy_think()
{
	self endon("death");
	self.ignoresonicaoe = 1;
	self.animname = "generic";
	self.ignoreme = 1;
	self.allowdeath = 1;
	self.health = 5;
	maps\_utility::disable_long_death();
	thread maps\_utility::set_battlechatter(0);
	if(isdefined(self.animation))
	{
		var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
		var_00 maps\_anim::anim_first_frame_solo(self,self.animation);
		var_00 maps\_anim::anim_single_solo(self,self.animation);
	}
}

//Function Number: 183
training_s2_breach_enemy_stop_death_check()
{
	self endon("death");
	self endon("killed");
	wait(7);
	self notify("killed2");
}

//Function Number: 184
training_s2_breach_enemy_death_check()
{
	self endon("death");
	self endon("killed2");
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(isdefined(var_03) && isdefined(var_04) && isplayer(var_01))
	{
		if(var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_03);
			soundscripts\_snd::snd_message("rec_slomo_kill_bad_guy",var_03);
		}

		self notify("killed");
		self stopanimscripted();
		var_05 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
		var_05 maps\_anim::anim_single_solo(self,"training_s2_exo_breach_kva2_death");
		self.noragdoll = 1;
		self.allowdeath = 1;
		self.a.nodeath = 1;
		thread maps\_utility::set_battlechatter(0);
		self kill();
	}
}

//Function Number: 185
training_s2_breach_kva_think()
{
	self endon("shot");
	self endon("death");
	self.ignoresonicaoe = 1;
	self.animname = "generic";
	self.ignoreme = 1;
	self.allowdeath = 0;
	maps\_utility::disable_long_death();
	maps\_utility::forceuseweapon("iw5_titan45_sp","primary");
	thread maps\_utility::set_battlechatter(0);
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	thread training_s2_breach_enemy_monitor_death();
	var_00 maps\_anim::anim_first_frame_solo(self,"training_s2_exo_breach_kva1_react");
	var_00 maps\_anim::anim_single_solo(self,"training_s2_exo_breach_kva1_react");
	var_00 thread maps\_anim::anim_loop_solo(self,"training_s2_exo_breach_kva1_react_idle","stop_loop");
	wait(3);
	var_00 notify("stop_loop");
	level.president notify("stop_idle_loop_s2");
	if(common_scripts\utility::flag("training_s2_breach_enemy_dead") == 0)
	{
		var_00 maps\_anim::anim_single_solo(self,"training_s2_exo_breach_kva1_fail");
	}
}

//Function Number: 186
training_s1_bathroom_breach_door()
{
	var_00 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_01 = getent("training_exo_breach_bathroom_door","targetname");
	var_01.animname = "door_prop";
	var_01 maps\_utility::assign_animtree();
	var_02 = getent("breach_bathroom_door_clip","targetname");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"training_s1_bathroom_door");
	soundscripts\_snd::snd_message("rec_bathroom_guy",var_01);
	var_02 linkto(var_01,"door");
	var_00 maps\_anim::anim_single_solo(var_01,"training_s1_bathroom_door");
	var_02 connectpaths();
}

//Function Number: 187
training_s2_breach_enemy_monitor_death()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	while(var_00 < 5)
	{
		self waittill("damage",var_05,var_04,var_06,var_01,var_02,var_07,var_08,var_03,var_09,var_0A);
		var_00 = var_00 + var_05;
	}

	if(isdefined(var_01) && isdefined(var_02) && isplayer(var_04))
	{
		if(var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_01);
			soundscripts\_snd::snd_message("rec_slomo_kill_bad_guy",var_01);
		}
	}

	if(common_scripts\utility::flag("training_s2_flag_president_dead") == 0)
	{
		common_scripts\utility::flag_set("training_s2_breach_enemy_dead");
		self notify("shot");
		var_0B = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
		var_0B thread maps\_anim::anim_single_solo(self,"training_s2_exo_breach_kva1_success");
		wait 0.05;
		self.noragdoll = 1;
		self.allowdeath = 1;
		self.a.nodeath = 1;
		thread maps\_utility::set_battlechatter(0);
		self kill();
	}
	else
	{
		common_scripts\utility::flag_set("training_s2_breach_enemy_dead");
		self notify("shot");
		self.allowdeath = 1;
		thread maps\_utility::set_battlechatter(0);
		self kill();
	}

	if(var_03 == "j_head")
	{
		waittillframeend;
		level.player.hud_damagefeedback fadeovertime(0.05);
		level.player.hud_damagefeedback.alpha = 0;
		level.player maps\_damagefeedback::updatedamagefeedback(self,1);
		level.player maps\_upgrade_challenge::give_player_challenge_headshot(1);
	}
	else
	{
		level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
	}

	wait(1);
	level.player.hud_damagefeedback fadeovertime(1);
}

//Function Number: 188
training_s2_breach_enemies_monitor()
{
	common_scripts\utility::flag_wait("training_s2_breach_enemy_dead");
	maps\_utility::waittill_aigroupcleared("training_s2_enemies_breach");
	var_00 = 0.65;
	maps\_utility::slowmo_setlerptime_out(var_00);
	maps\_utility::slowmo_lerp_out();
	maps\_utility::slowmo_end();
	level.player setmovespeedscale(1);
	common_scripts\utility::flag_set("training_s2_breach_enemies_dead");
}

//Function Number: 189
training_s2_president_setup()
{
	self endon("death");
	maps\_utility::magic_bullet_shield();
	self.animname = "president";
	self.name = "POTUS";
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	thread maps\_utility::set_battlechatter(0);
	self.team = "allies";
	level maps\_utility::clear_color_order("y","allies");
	maps\_utility::set_force_color("y");
}

//Function Number: 190
training_s2_breach_president_setup()
{
	self endon("death");
	self.allowdeath = 0;
	self.animname = "president";
	self.name = "POTUS";
	self.pacifist = 1;
	self.ignoreme = 1;
	self.ignoreall = 1;
	thread maps\_utility::set_battlechatter(0);
	thread training_s2_president_breach_monitor_death();
	self.team = "allies";
	level maps\_utility::clear_color_order("y","allies");
	maps\_utility::set_force_color("y");
}

//Function Number: 191
training_s2_president_breach_monitor_death()
{
	self endon("breach_s2_end");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	while(var_00 < 5)
	{
		self waittill("damage",var_04,var_03,var_05,var_01,var_02);
		var_00 = var_00 + var_04;
	}

	if(isdefined(var_01) && isdefined(var_02) && isplayer(var_03))
	{
		if(var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_EXPLOSIVE_BULLET")
		{
			playfx(common_scripts\utility::getfx("flesh_hit"),var_01);
			soundscripts\_snd::snd_message("rec_slomo_kill_bad_guy",var_01);
		}
	}

	common_scripts\utility::flag_set("training_s2_flag_president_dead");
	self.allowdeath = 1;
	self kill();
	if(isplayer(var_03))
	{
		setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_MURDERED");
	}
	else
	{
		setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_DEAD");
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 192
training_s2_president_dead()
{
	common_scripts\utility::flag_wait("training_s2_flag_president_shot");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("recovery_blood_impact_burst"),level.president,"j_head");
	common_scripts\utility::flag_set("training_s2_flag_president_dead");
	level.president notify("shot_s2");
	wait(2);
	setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_DEAD");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 193
training_s2_exo_breach_knife()
{
	var_00 = maps\_utility::spawn_anim_model("knife_prop");
	var_00.animname = "knife_prop";
	var_01 = common_scripts\utility::getstruct("training_s1_exo_breach_marker","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"training_s2_exo_knife");
	var_01 maps\_anim::anim_single_solo(var_00,"training_s2_exo_knife");
	var_00 delete();
}

//Function Number: 194
training_s2_open_patio_door()
{
	var_00 = common_scripts\utility::getstruct("training_s2_patio_door_animnode","targetname");
	var_00 maps\_anim::anim_reach_solo(level.gideon,"training_s2_patio_gideon_door_in");
	level.patio_doors notify("in2");
	var_00 maps\_anim::anim_single_solo(level.gideon,"training_s2_patio_gideon_door_in");
	var_00 thread maps\_anim::anim_loop_solo(level.gideon,"training_s2_patio_gideon_door_idle","stop_loop");
	common_scripts\utility::flag_wait("training_s2_living_room_drone_attack_done");
	var_00 notify("stop_loop");
	if(level.broken_door == 0)
	{
		common_scripts\utility::flag_set("training_s2_gideon_smash_french_door");
		var_00 maps\_anim::anim_reach_solo(level.gideon,"training_s2_patio_gideon_door_out");
		level.patio_doors notify("go2");
		level.gideon maps\_utility::cqb_walk("on");
		var_00 thread maps\_anim::anim_single_solo_run(level.gideon,"training_s2_patio_gideon_door_out");
	}

	maps\_utility::activate_trigger("training_s2_patio_color_trigger","targetname");
}

//Function Number: 195
training_s2_player_drone()
{
	level endon("training_s2_drone_enemies_killed");
	level.player.showhint = 1;
	maps\_utility::display_hint_timeout("drone_deploy_prompt",10);
	for(;;)
	{
		level.player waittill("use_drone");
		while(level.player isjumping())
		{
			wait 0.05;
		}

		if(vehicle_scripts\_pdrone_player::pdrone_deploy_check(85))
		{
			break;
		}
		else
		{
			level.player.showhint = 0;
			wait(0.25);
			level.player.showhint = 1;
			maps\_utility::display_hint_timeout("drone_deploy_fail_prompt",2);
			wait(2);
			level.player.showhint = 0;
			wait(0.25);
			level.player.showhint = 1;
			maps\_utility::display_hint_timeout("drone_deploy_prompt",10);
		}
	}

	level.player.showhint = 0;
	if(common_scripts\utility::flag("training_s2_drone_attack_done") == 0)
	{
		common_scripts\utility::flag_set("training_s2_drone_start");
		level notify("training_s2_drone_start");
		maps\_utility::array_spawn_noteworthy("training_s2_enemies2_patio",1);
		common_scripts\utility::flag_set("training_s2_patio_alert");
		common_scripts\utility::flag_set("flag_player_using_drone");
		thread training_s2_drone_manager();
	}
}

//Function Number: 196
training_s2_player_drone_delete()
{
	self endon("death");
	common_scripts\utility::flag_wait("training_s2_drone_start");
	self delete();
}

//Function Number: 197
training_s2_spawn_search_vehicle()
{
	var_00 = getent("training_s2_patio_vehicles","script_noteworthy");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 thread training_s2_drone_attack_vehicles_think();
}

//Function Number: 198
training_s2_drone_attack_vehicles_think()
{
	self endon("death");
	playfxontag(common_scripts\utility::getfx("car_tread_mud"),self,"tag_wheel_back_right");
	playfxontag(common_scripts\utility::getfx("car_tread_mud"),self,"tag_wheel_back_left");
	playfxontag(common_scripts\utility::getfx("car_tread_mud"),self,"tag_wheel_front_right");
	playfxontag(common_scripts\utility::getfx("car_tread_mud"),self,"tag_wheel_front_left");
	foreach(var_01 in self.riders)
	{
		var_01 thread training_s2_unload_drone_attack_think();
	}

	self waittill("reached_end_node");
	maps\_vehicle::vehicle_unload("all_but_gunner");
}

//Function Number: 199
training_s2_unload_drone_attack_think()
{
	self endon("death");
	if(isdefined(self.vehicle_position))
	{
		thread attach_flashlight_on_vehicle_unload();
		thread maps\_utility::set_battlechatter(0);
	}

	common_scripts\utility::flag_wait("training_s2_patio_alert");
	self notify("awareness_alert_level","warning");
	thread maps\_utility::set_battlechatter(1);
	common_scripts\utility::flag_wait("flag_training_s2_patio_enemies_charge");
	thread maps\_utility::player_seek_enable();
	common_scripts\utility::flag_wait("training_s2_clear_patio_spawn");
	bloody_death(randomfloatrange(0.5,1.5));
}

//Function Number: 200
training_s2_patio_enemies_alert_check()
{
	self endon("death");
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(var_01 == level.player)
	{
		wait(2);
		common_scripts\utility::flag_set("training_s2_patio_alert");
		self notify("alerted");
	}
}

//Function Number: 201
training_s2_ambush_vehicles_think(param_00)
{
	self endon("death");
	foreach(var_02 in self.riders)
	{
		var_02 thread training_s2_unload1_think(param_00);
	}

	self waittill("reached_end_node");
	maps\_vehicle::vehicle_unload();
	common_scripts\utility::flag_wait(param_00);
	wait(randomfloatrange(0.5,4.5));
	self kill();
}

//Function Number: 202
training_s2_unload1_think(param_00)
{
	self endon("death");
	if(isdefined(self.vehicle_position))
	{
		thread attach_flashlight_on_vehicle_unload();
		maps\_utility::disable_long_death();
	}

	common_scripts\utility::flag_wait(param_00);
	wait(randomintrange(1,6));
	bloody_death();
}

//Function Number: 203
training_s2_kva_ambush1_think(param_00)
{
	self endon("death");
	thread attach_flashlight_on_gun();
	maps\_utility::disable_long_death();
	maps\_utility::ai_ignore_everything();
	maps\_utility::delaythread(3,::maps\_utility::ai_unignore_everything);
	common_scripts\utility::flag_wait(param_00);
	wait(randomintrange(1,6));
	bloody_death();
}

//Function Number: 204
training_s2_drone_end_think(param_00)
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	self laseron();
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 205
training_s2_guard_house_doors()
{
	var_00 = getent("guard_door_01","targetname");
	getent(var_00.target,"targetname") linkto(var_00);
	var_01 = getent("guard_door_02","targetname");
	getent(var_01.target,"targetname") linkto(var_01);
	var_00 rotateto(var_00.angles + (0,-90,0),1,0,1);
	var_01 rotateto(var_01.angles + (0,90,0),1,0,1);
	var_00 connectpaths();
	var_01 connectpaths();
	wait(4);
	var_00 rotateto(var_00.angles + (0,90,0),1,0,1);
	var_01 rotateto(var_01.angles + (0,-90,0),1,0,1);
	var_00 disconnectpaths();
	var_01 disconnectpaths();
}

//Function Number: 206
training_s1_set_squad_passive_and_ignore()
{
	level.allies_s1 = maps\_utility::array_removedead(level.allies_s1);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::set_ignoreall,1);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::set_ignoreme,1);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::set_battlechatter,0);
}

//Function Number: 207
training_s1_set_sqaud_cqb_enable()
{
	level.allies_s1 = maps\_utility::array_removedead(level.allies_s1);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::enable_cqbwalk);
}

//Function Number: 208
training_s1_set_squad_active_and_target()
{
	level.allies_s1 = maps\_utility::array_removedead(level.allies_s1);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::set_ignoreall,0);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::set_ignoreme,0);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::set_battlechatter,1);
}

//Function Number: 209
training_s1_set_sqaud_cqb_disable()
{
	level.allies_s1 = maps\_utility::array_removedead(level.allies_s1);
	common_scripts\utility::array_thread(level.allies_s1,::maps\_utility::disable_cqbwalk);
}

//Function Number: 210
training_s2_set_squad_passive_and_ignore()
{
	level.allies_s2 = maps\_utility::array_removedead(level.allies_s2);
	common_scripts\utility::array_thread(level.allies_s2,::maps\_utility::set_ignoreall,1);
	common_scripts\utility::array_thread(level.allies_s2,::maps\_utility::set_ignoreme,1);
	common_scripts\utility::array_thread(level.allies_s2,::maps\_utility::set_battlechatter,0);
}

//Function Number: 211
training_s2_set_squad_active_and_target()
{
	level.allies_s2 = maps\_utility::array_removedead(level.allies_s2);
	common_scripts\utility::array_thread(level.allies_s2,::maps\_utility::set_ignoreall,0);
	common_scripts\utility::array_thread(level.allies_s2,::maps\_utility::set_ignoreme,0);
	common_scripts\utility::array_thread(level.allies_s2,::maps\_utility::set_battlechatter,1);
}

//Function Number: 212
warbird_heavy_shooting_think(param_00)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	thread warbird_heavy_fire_monitor();
	for(;;)
	{
		self waittill("warbird_fire");
		maps\_utility::ent_flag_set("fire_turrets");
		thread warbird_heavy_fire(param_00);
		self waittill("warbird_stop_firing");
		maps\_utility::ent_flag_clear("fire_turrets");
	}
}

//Function Number: 213
warbird_heavy_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	var_01 notify("stop_burst_fire_unmanned");
	var_02 notify("stop_burst_fire_unmanned");
	var_03 = 0.4;
	var_04 = var_03 / 2;
	var_01 thread burst_fire_warbird(var_03,0);
	var_02 thread burst_fire_warbird(var_03,var_04);
	var_05 = common_scripts\utility::get_enemy_team(self.script_team);
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_06 = getaiarray(var_05);
		if(isdefined(level.flying_attack_drones))
		{
			var_07 = level.flying_attack_drones;
		}
		else
		{
			var_07 = [];
		}

		if(isdefined(level.drones) && isdefined(level.drones[var_05].array))
		{
			var_06 = common_scripts\utility::array_combine(var_06,level.drones[var_05].array);
		}

		if(var_05 == level.player.team)
		{
			var_06 = common_scripts\utility::array_add(var_06,level.player);
		}

		var_06 = common_scripts\utility::array_combine(var_06,var_07);
		var_08 = [];
		foreach(var_0A in var_06)
		{
			if(isdefined(var_0A.ignoreme) && var_0A.ignoreme)
			{
				continue;
			}
			else
			{
				var_08[var_08.size] = var_0A;
			}
		}

		var_08 = sortbydistance(var_08,self.origin);
		var_0C = undefined;
		foreach(var_0A in var_08)
		{
			if(!isdefined(var_0A))
			{
				continue;
			}

			if(!isalive(var_0A))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0E = self.mgturret[0] gettagorigin("tag_flash");
				var_0F = var_0A geteye();
				var_10 = vectornormalize(var_0F - var_0E);
				var_11 = var_0E + var_10 * 20;
				if(!sighttracepassed(var_11,var_0F,0,var_0A,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0C = var_0A;
			break;
		}

		if(isdefined(var_0C))
		{
			var_01 settargetentity(var_0C);
			var_02 settargetentity(var_0C);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_0C,param_00);
			var_01 notify("stop_firing");
			var_02 notify("stop_firing");
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(0.05);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 214
warbird_heavy_fire_monitor()
{
	self endon("death");
	self waittill("warbird_stop_firing");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 215
burst_fire_warbird(param_00,param_01)
{
	self endon("death");
	self endon("stop_burst_fire_warbird");
	var_02 = 1;
	var_03 = 1;
	var_04 = 1;
	var_05 = 1;
	var_06 = gettime();
	var_07 = "start";
	for(;;)
	{
		var_08 = var_06 - gettime() * 0.001;
		if(self isfiringturret() && var_08 <= 0)
		{
			if(var_07 != "fire")
			{
				var_07 = "fire";
				thread doshoottuned(param_00,param_01);
			}

			var_08 = var_04 + randomfloat(var_05);
			thread turrettimer(var_08);
			self waittill("turretstatechange");
			var_08 = var_02 + randomfloat(var_03);
			var_06 = gettime() + int(var_08 * 1000);
			continue;
		}

		if(var_07 != "aim")
		{
			var_07 = "aim";
		}

		thread turrettimer(var_08);
		self waittill("turretstatechange");
	}
}

//Function Number: 216
doshoottuned(param_00,param_01)
{
	self endon("death");
	self endon("turretstatechange");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	for(;;)
	{
		self shootturret();
		wait(param_00);
	}
}

//Function Number: 217
turrettimer(param_00)
{
	if(param_00 <= 0)
	{
		return;
	}

	self endon("turretstatechange");
	wait(param_00);
	if(isdefined(self))
	{
		self notify("turretstatechange");
	}
}

//Function Number: 218
military_drone_stationary_think(param_00)
{
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		self.script_noteworthy = self.script_parameters;
	}

	if(isdefined(self.animation))
	{
		self.idleanim = self.animation;
	}
	else
	{
		self.idleanim = %patrol_bored_idle;
	}

	self.spawner thread maps\_anim::anim_generic_loop(self,self.idleanim);
	self.name = " ";
	self setlookattext(self.name,&"");
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 219
military_drone_runners_think(param_00)
{
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		self.script_noteworthy = self.script_parameters;
	}

	self.animname = "generic";
	self.name = " ";
	self.runanim = maps\_utility::getanim(self.animation);
	self.idleanim = %patrol_bored_idle;
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 220
military_drone_guards_stationary_think(param_00)
{
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		self.script_noteworthy = self.script_parameters;
	}

	if(isdefined(self.animation))
	{
		self.idleanim = self.animation;
	}
	else
	{
		self.idleanim = %patrol_bored_idle;
	}

	thread maps\_anim::anim_generic_loop(self,self.idleanim);
	common_scripts\utility::flag_waitopen(param_00);
	self delete();
}

//Function Number: 221
military_drone_guards_patrol_think(param_00)
{
	self pushplayer(1);
	self.animname = "generic";
	self.idleanim = %patrol_bored_idle;
	maps\_utility::set_run_anim("active_patrolwalk_gundown");
	maps\_utility::ai_ignore_everything();
	maps\_utility::disable_arrivals();
	maps\_utility::disable_exits();
	self.goalradius = 16;
	maps\_utility::set_battlechatter(0);
	common_scripts\utility::flag_waitopen(param_00);
	self delete();
}

//Function Number: 222
grenade_range_enemy_think()
{
	self waittill("death",var_00);
	level.grenade_range_container.aikills++;
	level.grenade_range_container notify("score_change");
	if(!isplayer(var_00))
	{
		return;
	}

	if(common_scripts\utility::flag("flag_obj_grenade_range_tutorial_complete"))
	{
	}

	level notify("grenade_range_point_scored_100");
}

//Function Number: 223
grenade_range_drone_think()
{
	self endon("no_score");
	grenade_range_drone_death_detect();
	level.grenade_range_container.dronekills++;
	level.grenade_range_container notify("score_change");
	var_00 = self.mod;
	if(var_00 == "EMP")
	{
		if(common_scripts\utility::flag("flag_obj_grenade_range_tutorial_complete"))
		{
		}

		level notify("grenade_range_point_scored_100");
	}

	if(var_00 == "grenade")
	{
		if(common_scripts\utility::flag("flag_obj_grenade_range_tutorial_complete"))
		{
		}

		level notify("grenade_range_point_scored_100");
	}

	if(var_00 == "bullet")
	{
		if(common_scripts\utility::flag("flag_obj_grenade_range_tutorial_complete"))
		{
		}

		level notify("grenade_range_point_scored_50");
	}
}

//Function Number: 224
grenade_range_drone_death_detect()
{
	self.mod = "EMP";
	self endon("emp_death");
	self waittill("death",var_00,var_01,var_02);
	switch(var_01)
	{
		case "MOD_RIFLE_BULLET":
		case "MOD_PISTOL_BULLET":
			self.mod = "bullet";
			break;

		case "MOD_EXPLOSIVE":
		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
			self.mod = "grenade";
			break;

		default:
			break;
	}
}

//Function Number: 225
civilian_drone_repair_think(param_00)
{
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		self.script_noteworthy = self.script_parameters;
	}

	if(self.weapon != "none")
	{
		maps\_utility::gun_remove();
	}

	if(isdefined(self.animation))
	{
		self.idleanim = self.animation;
	}
	else
	{
		self.idleanim = %cliffhanger_welder_engine;
	}

	self.eaniment = self.spawner;
	self.eaniment.origin = self.eaniment.origin + (0,0,-3);
	self attach("machinery_welder_handle","tag_inhand");
	thread flashing_welding();
	self.spawner thread maps\_anim::anim_generic_loop(self,"cliffhanger_welder_engine");
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 226
civilian_drone_stationary_think(param_00)
{
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		self.script_noteworthy = self.script_parameters;
	}

	if(self.weapon != "none")
	{
		maps\_utility::gun_remove();
	}

	if(isdefined(self.animation))
	{
		self.idleanim = self.animation;
	}
	else
	{
		self.idleanim = %civilian_stand_idle;
	}

	self.spawner thread maps\_anim::anim_generic_loop(self,self.idleanim);
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 227
civilian_drone_runners_think(param_00)
{
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		self.script_noteworthy = self.script_parameters;
	}

	self.animname = "generic";
	self.runanim = maps\_utility::getanim(self.animation);
	if(self.weapon != "none")
	{
		maps\_utility::gun_remove();
	}

	self.idleanim = %civilian_stand_idle;
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 228
flashing_welding()
{
	self endon("death");
	thread stop_sparks();
	playfxontag(level._effect["welding_sparks_oneshot_sml"],self,"tag_tip_fx");
}

//Function Number: 229
stop_sparks()
{
	self endon("death");
	for(;;)
	{
		self waittillmatch("spark off","looping anim");
		self notify("spark off");
	}
}

//Function Number: 230
setup_deck_deploy_warbird()
{
	waittillframeend;
	self notify("warbird_fire");
	var_00 = get_passengers();
	var_00 thread ignore_until_unloaded();
}

//Function Number: 231
get_passengers()
{
	var_00 = self.riders;
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.drivingvehicle))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 232
ignore_until_unloaded()
{
	var_00 = 1;
	foreach(var_02 in self)
	{
		var_02.ignoreme = 1;
		var_02 thread wait_until_unloaded(var_00);
		var_00++;
	}
}

//Function Number: 233
wait_until_unloaded(param_00)
{
	self endon("death");
	self waittill("jumpedout");
	self.ignoreme = 0;
	goto_node("zipline_path0" + param_00,0,256);
	self waittill("goal");
	wait(5);
	self delete();
}

//Function Number: 234
warbird_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	var_03 = 3;
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_04 = getaiarray("allies");
		if(!maps\_utility::ent_flag_exist("dont_shoot_player") || !maps\_utility::ent_flag("dont_shoot_player"))
		{
			var_05 = 33;
			if(randomint(100) <= var_05)
			{
				var_04 = common_scripts\utility::array_add(var_04,level.player);
			}
		}

		var_06 = [];
		foreach(var_08 in var_04)
		{
			if(isdefined(var_08.ignoreme) && var_08.ignoreme)
			{
				continue;
			}
			else
			{
				var_06[var_06.size] = var_08;
			}
		}

		var_06 = sortbydistance(var_06,self.origin);
		var_0A = undefined;
		foreach(var_08 in var_06)
		{
			if(!isdefined(var_08))
			{
				continue;
			}

			if(!isalive(var_08))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0C = self.mgturret[0] gettagorigin("tag_flash");
				var_0D = var_08 geteye();
				var_0E = vectornormalize(var_0D - var_0C);
				var_0F = var_0D + var_0E * 20;
				if(!sighttracepassed(var_0F,var_0D,0,var_08,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0A = var_08;
			break;
		}

		if(isdefined(var_0A))
		{
			var_01 settargetentity(var_0A);
			var_02 settargetentity(var_0A);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_0A,param_00);
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(var_03);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 235
wait_for_warbird_fire_target_done(param_00,param_01)
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

//Function Number: 236
prep_user_for_drone()
{
	self disableweapons();
	self.ignoreme = 1;
	self enableinvulnerability();
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		var_02 thermaldrawenable();
	}

	var_04 = getaiarray("allies");
	foreach(var_02 in var_04)
	{
		var_02 thermaldrawenable();
	}

	wait 0.05;
	level.player thermalvisionon();
}

//Function Number: 237
make_drone_fully_controllable(param_00)
{
	param_00 endon("death");
	level.player thread monitor_drone_stick_deflection(param_00);
	wait 0.05;
	for(;;)
	{
		var_01 = level.player.drone_control["stick_input_move"] * 10;
		var_02 = getdroneperlinovertime(5,3,2,0.5);
		var_03 = param_00 setvehgoalpos(param_00.origin + var_01 + var_02);
		wait 0.05;
	}
}

//Function Number: 238
getdroneperlinovertime(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = (perlinnoise2d(gettime() * 0.001 * 0.05,10,param_00,param_01,param_02) * param_03,perlinnoise2d(gettime() * 0.001 * 0.05,20,param_00,param_01,param_02) * param_03,perlinnoise2d(gettime() * 0.001 * 0.05,30,param_00,param_01,param_02) * param_03);
	return var_04;
}

//Function Number: 239
monitor_drone_stick_deflection(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		var_01 = self getnormalizedmovement();
		var_01 = (var_01[0],var_01[1] * -1,0);
		var_02 = self.angles;
		var_03 = vectortoangles(var_01);
		var_04 = common_scripts\utility::flat_angle(combineangles(var_02,var_03));
		var_05 = anglestoforward(var_04) * length(var_01);
		self.drone_control["stick_input_move"] = var_05;
		wait 0.05;
	}
}

//Function Number: 240
unlink_player_from_drone(param_00)
{
	level.player.dronetag unlink();
	level.player unlink();
	level.player maps\_utility::teleport_player(param_00);
	wait 0.05;
	level.player remove_user_from_drone();
	level.player lerpfov(65,0);
}

//Function Number: 241
remove_user_from_drone()
{
	self enableweapons();
	self.ignoreme = 0;
	self disableinvulnerability();
	level.player thermalvisionoff();
}

//Function Number: 242
recovery_breach_setup_player()
{
	level.player enableinvulnerability();
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	level.player allowjump(0);
}

//Function Number: 243
recovery_breach_cleanup_player()
{
	level.player disableinvulnerability();
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowsprint(1);
	level.player allowjump(1);
}

//Function Number: 244
breach_slow_down(param_00)
{
}

//Function Number: 245
enable_player_control(param_00)
{
	level.player unlink();
	level.player_rig delete();
}

//Function Number: 246
spawn_player_rig(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "player_rig";
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player.origin;
	}

	var_02 = maps\_utility::spawn_anim_model(param_00);
	return var_02;
}

//Function Number: 247
disable_trigger_while_player_animating(param_00)
{
	level endon(param_00);
	for(;;)
	{
		if(isdefined(self.trigger_off))
		{
			common_scripts\utility::trigger_on();
		}

		wait(0.05);
	}
}

//Function Number: 248
goto_node(param_00,param_01,param_02)
{
	self endon("stop_goto_node");
	if(!isdefined(param_02))
	{
		param_02 = 16;
	}

	maps\_utility::set_goal_radius(param_02);
	if(isstring(param_00))
	{
		var_03 = getnode(param_00,"script_noteworthy");
	}
	else
	{
		var_03 = param_01;
	}

	if(isdefined(var_03))
	{
		maps\_utility::set_goal_node(var_03);
	}
	else
	{
		var_03 = common_scripts\utility::getstruct(param_00,"script_noteworthy");
		maps\_utility::set_goal_pos(var_03.origin);
	}

	if(param_01)
	{
		self waittill("goal");
	}
}

//Function Number: 249
leaderboard_precache()
{
	precachemodel("rec_sb_row");
	for(var_00 = 0;var_00 <= 9;var_00++)
	{
		precachemodel("rec_sb_" + var_00);
	}

	for(var_00 = 1;var_00 <= 9;var_00++)
	{
		precachemodel("rec_sb_name_0" + var_00);
	}

	precachemodel("rec_sb_name_10");
	precachemodel("rec_sb_name_11");
	precachemodel("rec_sb_drone_range");
	precachemodel("rec_sb_ar_range");
	precachemodel("rec_sb_shooting_range");
}

//Function Number: 250
leaderboard_make(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.isleaderboard = 1;
	var_03.maxentries = param_00;
	var_03.range_name = param_01;
	if(isdefined(param_02))
	{
		var_03.shouldsortscoresinascendingorder = param_02;
	}
	else
	{
		var_03.shouldsortscoresinascendingorder = 0;
	}

	var_03.playerscores = [];
	var_03 leaderboard_defaults(param_01);
	var_03.leaderboard_screen = var_03 leaderboard_screen_make();
	var_03 leaderboard_screen_update();
	return var_03;
}

//Function Number: 251
leaderboard_compare_scores(param_00,param_01)
{
	var_02 = self;
	return (var_02.shouldsortscoresinascendingorder && param_01 < param_00) || !var_02.shouldsortscoresinascendingorder && param_01 > param_00;
}

//Function Number: 252
leaderboard_sort_scores()
{
	var_00 = self.playerscores;
	for(var_01 = 0;var_01 < var_00.size - 1;var_01++)
	{
		for(var_02 = var_01 + 1;var_02 < var_00.size;var_02++)
		{
			if(leaderboard_compare_scores(var_00[var_01].playerscore,var_00[var_02].playerscore) || var_00[var_02].playerscore == var_00[var_01].playerscore && var_00[var_02].playername == "player")
			{
				var_03 = var_00[var_02];
				var_00[var_02] = var_00[var_01];
				var_00[var_01] = var_03;
			}
		}
	}

	self.playerscores = var_00;
}

//Function Number: 253
leaderboard_record(param_00,param_01)
{
	var_02 = self;
	if(param_00 == "player")
	{
		for(var_03 = 0;var_03 < var_02.playerscores.size;var_03++)
		{
			var_04 = var_02.playerscores[var_03];
			if(var_04.playername == param_00)
			{
				if(var_02 leaderboard_compare_scores(var_04.playerscore,param_01))
				{
					var_04.playerscore = param_01;
					var_02 leaderboard_sort_scores();
				}

				return;
			}
		}
	}

	if(var_02.playerscores.size == var_02.maxentries && var_02 leaderboard_compare_scores(param_01,var_02.playerscores[var_02.maxentries - 1].playerscore))
	{
		return;
	}

	var_04 = spawnstruct();
	var_04.isleaderboardentry = 1;
	var_04.playername = param_00;
	var_04.playerscore = param_01;
	if(var_02.playerscores.size == var_02.maxentries)
	{
		var_02.playerscores[var_02.maxentries - 1] = var_04;
	}
	else
	{
		var_02.playerscores[var_02.playerscores.size] = var_04;
	}

	var_02 leaderboard_sort_scores();
}

//Function Number: 254
leaderboard_defaults(param_00)
{
	var_01 = [];
	var_01["drone_range"] = "sb_drone_range";
	var_01["grenade_range"] = "sb_grenade_range";
	var_01["shooting_range"] = "sb_shooting_range";
	var_02 = [];
	var_02["drone_range"] = "rec_sb_drone_range";
	var_02["grenade_range"] = "rec_sb_ar_range";
	var_02["shooting_range"] = "rec_sb_shooting_range";
	if(param_00 == "shooting_range")
	{
		leaderboard_record("name_01",2375);
		leaderboard_record("name_02",2050);
		leaderboard_record("name_03",1825);
		leaderboard_record("name_04",1650);
		leaderboard_record("name_05",1300);
		leaderboard_record("name_06",1150);
		leaderboard_record("name_07",975);
		leaderboard_record("name_08",775);
		leaderboard_record("name_09",425);
		leaderboard_record("name_10",200);
		leaderboard_record("player",0);
	}
	else if(param_00 == "grenade_range")
	{
		leaderboard_record("name_01",1800);
		leaderboard_record("name_02",1550);
		leaderboard_record("name_03",1400);
		leaderboard_record("name_04",1200);
		leaderboard_record("name_05",950);
		leaderboard_record("name_06",750);
		leaderboard_record("name_07",600);
		leaderboard_record("name_08",300);
		leaderboard_record("name_09",250);
		leaderboard_record("name_10",100);
	}
	else if(param_00 == "drone_range")
	{
		leaderboard_record("name_01",15);
		leaderboard_record("name_02",21);
		leaderboard_record("name_03",26);
		leaderboard_record("name_04",31);
		leaderboard_record("name_05",34);
		leaderboard_record("name_06",36);
		leaderboard_record("name_07",40);
		leaderboard_record("name_08",49);
		leaderboard_record("name_09",57);
		leaderboard_record("name_10",60);
	}

	var_03 = [];
	var_03["player"] = "rec_sb_name_01";
	var_03["name_01"] = "rec_sb_name_11";
	var_03["name_02"] = "rec_sb_name_02";
	var_03["name_03"] = "rec_sb_name_03";
	var_03["name_04"] = "rec_sb_name_04";
	var_03["name_05"] = "rec_sb_name_05";
	var_03["name_06"] = "rec_sb_name_06";
	var_03["name_07"] = "rec_sb_name_07";
	var_03["name_08"] = "rec_sb_name_08";
	var_03["name_09"] = "rec_sb_name_09";
	var_03["name_10"] = "rec_sb_name_10";
	var_04 = spawnstruct();
	var_04.titlemap = var_02;
	var_04.namemodelmap = var_03;
	var_04.screennamemap = var_01;
	self.settings = var_04;
}

//Function Number: 255
leaderboard_screen_make()
{
	var_00 = self.range_name;
	var_01 = getent(self.settings.screennamemap[var_00],"targetname");
	var_01.isleaderboardscreen = 1;
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel(self.settings.titlemap[var_00]);
	var_02 linkto(var_01,"title",(0,0,0),(0,90,0));
	var_01.rows = [];
	for(var_03 = 0;var_03 < 10;var_03++)
	{
		var_04 = spawn("script_model",var_01.origin);
		var_04.isleaderboardscreenrow = 1;
		var_01.rows[var_03] = var_04;
		var_04 setmodel("rec_sb_row");
		var_04 linkto(var_01,"row" + var_03 + 1,(0,0,0),(0,0,0));
		var_04.nametagmodel = spawn("script_model",var_01.origin);
		var_04.nametagmodel linkto(var_04,"name1",(0,0,0),(0,90,0));
		var_04.digitmodels = [];
		var_04.digitmodels[0] = spawn("script_model",var_01.origin);
		var_04.digitmodels[0] linkto(var_04,"digit1",(0,0,0),(0,90,0));
		var_04.digitmodels[1] = spawn("script_model",var_01.origin);
		var_04.digitmodels[1] linkto(var_04,"digit2",(0,0,0),(0,90,0));
		var_04.digitmodels[2] = spawn("script_model",var_01.origin);
		var_04.digitmodels[2] linkto(var_04,"digit3",(0,0,0),(0,90,0));
		var_04.digitmodels[3] = spawn("script_model",var_01.origin);
		var_04.digitmodels[3] linkto(var_04,"digit4",(0,0,0),(0,90,0));
	}

	return var_01;
}

//Function Number: 256
leaderboard_score_to_digits(param_00)
{
	var_01 = [];
	var_02 = param_00;
	var_03 = var_02 % 10;
	var_02 = int(var_02 / 10);
	var_01[0] = "rec_sb_" + var_03;
	var_03 = var_02 % 10;
	var_02 = int(var_02 / 10);
	var_01[1] = "rec_sb_" + var_03;
	var_03 = var_02 % 10;
	var_02 = int(var_02 / 10);
	var_01[2] = "rec_sb_" + var_03;
	var_03 = var_02 % 10;
	var_02 = int(var_02 / 10);
	var_01[3] = "rec_sb_" + var_03;
	var_01 = common_scripts\utility::array_reverse(var_01);
	return var_01;
}

//Function Number: 257
leaderboard_screen_update()
{
	var_00 = self;
	var_01 = self.leaderboard_screen;
	for(var_02 = 0;var_02 < 10;var_02++)
	{
		var_03 = var_01.rows[var_02];
		var_04 = var_00.playerscores[var_02];
		var_05 = var_00.settings.namemodelmap[var_04.playername];
		var_03.nametagmodel setmodel(var_05);
		var_06 = leaderboard_score_to_digits(var_04.playerscore);
		var_03.digitmodels[0] setmodel(var_06[0]);
		var_03.digitmodels[1] setmodel(var_06[1]);
		var_03.digitmodels[2] setmodel(var_06[2]);
		var_03.digitmodels[3] setmodel(var_06[3]);
	}
}

//Function Number: 258
play_reload_malfunction_on_next_reload(param_00)
{
	level notify("play_reload_malfunction_on_next_reload_stop");
	level endon("play_reload_malfunction_on_next_reload_stop");
	if(!common_scripts\utility::flag_exist("reload_malfunction"))
	{
		common_scripts\utility::flag_init("reload_malfunction");
	}

	common_scripts\utility::flag_set("reload_malfunction");
	if(isdefined(param_00))
	{
		level endon(param_00);
	}

	if(!isdefined(level.player.numofreloadmalfunctions))
	{
		level.player.numofreloadmalfunctions = 0;
	}

	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	childthread reload_malfunction_disable_on_grenade_throw();
	for(;;)
	{
		wait 0.05;
		if(!common_scripts\utility::flag("reload_malfunction"))
		{
			common_scripts\utility::flag_wait("reload_malfunction");
		}

		var_01 = level.player getcurrentweapon();
		var_02 = weaponclipsize(var_01);
		var_03 = level.player getweaponammoclip(var_01);
		var_04 = [];
		var_05 = [];
		if(issubstr(var_01,"bal27"))
		{
			var_04 = [1,2];
			var_05 = [%vm_bal_27_reload_exo_malfunction_1,%vm_bal_27_reload_exo_malfunction_2];
		}
		else if(issubstr(var_01,"titan45"))
		{
			var_04 = [3,4];
			var_05 = [%vm_titan45_reload_exo_malfunction_1,%vm_titan45_reload_exo_malfunction_2];
		}
		else if(issubstr(var_01,"ak12"))
		{
			var_04 = [5,6];
			var_05 = [%vm_ak12_reload_exo_malfunction_1,%vm_ak12_reload_exo_malfunction_2];
		}
		else if(issubstr(var_01,"vbr"))
		{
			var_04 = [7,8];
			var_05 = [%vm_vbr_reload_exo_malfunction_1,%vm_vbr_reload_exo_malfunction_2];
		}
		else if(issubstr(var_01,"kf5"))
		{
			var_04 = [11,12];
			var_05 = [%vm_kf5_reload_exo_malfunction_1,%vm_kf5_reload_exo_malfunction_2];
		}
		else if(issubstr(var_01,"rhino"))
		{
			var_04 = [9,10];
			var_05 = [%vm_rhino_reload_exo_malfunction_1,%vm_rhino_reload_exo_malfunction_2];
		}
		else
		{
			continue;
		}

		if(var_03 < var_02 && level.player usebuttonpressed() && !level.player isholdinggrenade() && !level.player isreloading())
		{
			break;
		}

		if(var_03 < 2)
		{
			break;
		}
	}

	thread play_reload_malfunction(var_04[level.player.numofreloadmalfunctions],var_05[level.player.numofreloadmalfunctions],var_01,var_02,var_03);
	level.player.numofreloadmalfunctions = level.player.numofreloadmalfunctions + 1 % var_04.size;
	level notify("play_reload_malfunction_on_next_reload_stop");
}

//Function Number: 259
reload_malfunction_disable_on_grenade_throw()
{
	for(;;)
	{
		level.player common_scripts\utility::waittill_any("grenade_fire","grenade_pullback");
		common_scripts\utility::flag_clear("reload_malfunction");
		wait(1.5);
		common_scripts\utility::flag_set("reload_malfunction");
	}
}

//Function Number: 260
play_reload_malfunction(param_00,param_01,param_02,param_03,param_04)
{
	thread play_rumble_training_s1_reload_malfunction();
	common_scripts\utility::flag_set("flag_vo_training_s1_reload_malfunction");
	level.player allowmantle(0);
	level.player allowads(0);
	level.player disableweaponpickup();
	level.player disableweaponswitch();
	level.player enableinvulnerability();
	setsaveddvar("ammoCounterHide","1");
	soundscripts\_snd::snd_message("camp_david_reload_malfunction",param_00,param_02);
	level.player setviewmodelanim(param_00);
	var_05 = level.player setweaponammostock(param_02);
	level.player setweaponammoclip(param_02,param_03);
	level.player setweaponammostock(param_02,var_05 - param_03 - param_04);
	wait(getanimlength(param_01));
	level.player allowads(1);
	level.player enableweaponpickup();
	level.player enableweaponswitch();
	level.player allowmantle(1);
	level.player disableinvulnerability();
	setsaveddvar("ammoCounterHide","0");
}

//Function Number: 261
lerp_anim_weight_on_actor_over_time(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_01 / 0.05);
	var_05 = param_03 - param_02 / var_04;
	var_06 = param_02;
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		self setanim(param_00,var_06,0.05,1);
		var_06 = var_06 + var_05;
		wait 0.05;
	}
}

//Function Number: 262
lerp_in_turn_rate(param_00)
{
	var_01 = 0;
	var_02 = 1 / param_00 / 0.05;
	var_03 = getdvarint("aim_turnrate_pitch");
	var_04 = getdvarint("aim_turnrate_pitch_ads");
	var_05 = getdvarint("aim_turnrate_yaw");
	var_06 = getdvarint("aim_turnrate_yaw_ads");
	var_07 = getdvarint("aim_accel_turnrate_lerp");
	while(var_01 <= 1)
	{
		setsaveddvar("aim_turnrate_pitch",int(var_01 * var_03));
		setsaveddvar("aim_turnrate_pitch_ads",int(var_01 * var_04));
		setsaveddvar("aim_turnrate_yaw",int(var_01 * var_05));
		setsaveddvar("aim_turnrate_yaw_ads",int(var_01 * var_06));
		setsaveddvar("aim_accel_turnrate_lerp",int(var_01 * var_07));
		wait 0.05;
		var_01 = var_01 + var_02;
	}

	setsaveddvar("aim_turnrate_pitch",var_03);
	setsaveddvar("aim_turnrate_pitch_ads",var_04);
	setsaveddvar("aim_turnrate_yaw",var_05);
	setsaveddvar("aim_turnrate_yaw_ads",var_06);
	setsaveddvar("aim_accel_turnrate_lerp",var_07);
}

//Function Number: 263
waittill_drones_dead(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && !isremovedentity(var_02))
		{
			var_02 waittill("death");
		}
	}
}

//Function Number: 264
waittill_s2_drone_ambush_done(param_00)
{
	while(param_00.size > 0 && !common_scripts\utility::flag("training_s2_start_enter_patio"))
	{
		param_00 = maps\_utility::array_removedead(param_00);
		wait 0.05;
	}
}

//Function Number: 265
training_s2_drone_ambush_attack()
{
	level endon("training_s2_living_room_drone_attack_done");
	var_00 = common_scripts\utility::getstruct("attacklocation3","targetname");
	var_01 = common_scripts\utility::getstructarray(var_00.target,"targetname");
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[0].origin);
	wait(1);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[1].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[2].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[3].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[4].origin);
	wait(0.25);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[5].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[6].origin);
	wait(0.5);
	magicbullet("iw5_bal27_sp_silencer01_variablereddot",var_00.origin,var_01[7].origin);
}