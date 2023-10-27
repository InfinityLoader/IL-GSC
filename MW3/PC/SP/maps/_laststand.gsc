/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_laststand.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 1201 ms
 * Timestamp: 10/27/2023 2:22:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.laststand_initialized))
	{
		return;
	}

	level.laststand_initialized = 1;
	common_scripts\utility::flag_init("laststand_on");
	foreach(var_01 in level.players)
	{
		var_01 maps\_utility::ent_flag_init("laststand_downed");
		var_01 maps\_utility::ent_flag_init("laststand_pause_bleedout_timer");
		var_01 maps\_utility::ent_flag_init("laststand_proc_running");
		var_01.laststand_info = spawnstruct();
		var_01.laststand_info.type_getup_lives = 0;
	}

	precachestring(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
	precachestring(&"SCRIPT_COOP_BLEEDING_OUT");
	precachestring(&"SCRIPT_COOP_REVIVING_PARTNER");
	precachestring(&"SCRIPT_COOP_REVIVING");
	precachestring(&"SCRIPT_COOP_REVIVE");
	precacheshellshock("laststand_getup");
	precacheitem("fnfiveseven");
	common_scripts\utility::flag_set("laststand_on");
	level.revive_hud_base_offset = 75;
	if(!issplitscreen())
	{
		level.revive_hud_base_offset = 120;
	}

	level.revive_bar_offset = 15;
	level.revive_bar_getup_offset = 30;
	level.laststand_hud_elements = [];
	thread laststand_on_load_finished();
}

//Function Number: 2
laststand_on_load_finished()
{
	level waittill("load_finished");
	if(laststand_get_type() == 2)
	{
		precacheshader("specialty_self_revive");
	}

	thread laststand_global_spawn_funcs();
	if(common_scripts\utility::flag_exist("slamzoom_finished") && !common_scripts\utility::flag("slamzoom_finished"))
	{
		common_scripts\utility::flag_wait("slamzoom_finished");
	}

	thread laststand_notify_on_player_state_changes("laststand_player_state_changed");
	thread laststand_downed_player_manager();
	thread laststand_coop_hud_manager();
	thread laststand_getup_hud_init();
	thread laststand_on_mission_end();
}

//Function Number: 3
laststand_global_spawn_funcs()
{
	if(laststand_get_type() == 2)
	{
		maps\_utility::add_global_spawn_function("axis",::ai_laststand_on_death);
	}
}

//Function Number: 4
player_laststand_proc()
{
	if(!maps\_utility::laststand_enabled())
	{
		return;
	}

	if(maps\_utility::ent_flag("laststand_proc_running"))
	{
		return;
	}

	if(!isdefined(self.original_maxhealth))
	{
		self.original_maxhealth = self.maxhealth;
	}

	if(!common_scripts\utility::flag("laststand_on"))
	{
		return;
	}

	level endon("laststand_on");
	thread player_laststand_proc_ended();
	switch(level.gameskill)
	{
		case 1:
		case 0:
			self.laststand_info.bleedout_time_default = 120;
			level.laststand_stage2_multiplier = 0.5;
			level.laststand_stage3_multiplier = 0.25;
			break;

		case 2:
			self.laststand_info.bleedout_time_default = 90;
			level.laststand_stage2_multiplier = 0.66;
			level.laststand_stage3_multiplier = 0.33;
			break;

		case 3:
			self.laststand_info.bleedout_time_default = 60;
			level.laststand_stage2_multiplier = 0.5;
			level.laststand_stage3_multiplier = 0.25;
			break;
	}

	maps\_utility::ent_flag_set("laststand_proc_running");
	self enabledeathshield(1);
	maps\_utility::ent_flag_clear("laststand_downed");
	maps\_utility::ent_flag_clear("laststand_pause_bleedout_timer");
	self endon("death");
	var_00 = self.unique_id;
	for(;;)
	{
		self waittill("deathshield",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isdefined(self.saved_by_armor) && self.saved_by_armor)
		{
			continue;
		}

		if(maps\_utility::ent_flag("laststand_downed"))
		{
			continue;
		}

		if(isdefined(self.laststand_revive_time) && gettime() - self.laststand_revive_time <= 1750)
		{
			continue;
		}

		var_0B = [];
		if(maps\_utility::is_coop() && laststand_downing_will_fail())
		{
			var_0C = maps\_utility::get_other_player(self);
			if(var_0C maps\_utility::ent_flag("laststand_downed"))
			{
				self.coop_death_reason = [];
				self.coop_death_reason["attacker"] = var_03;
				self.coop_death_reason["cause"] = var_06;
				self.coop_death_reason["weapon_name"] = var_0B;
			}
		}

		if(!maps\_utility::is_coop())
		{
			self.coop_death_reason = [];
			self.coop_death_reason["attacker"] = var_03;
			self.coop_death_reason["cause"] = var_06;
			self.coop_death_reason["weapon_name"] = var_0B;
		}

		level.down_player_requests[self.unique_id] = var_7B;
		try_crush_player(var_03,var_06);
		level notify("request_player_downed",var_7B["player"],self,var_7B["damage"],var_01);
	}
}

//Function Number: 5
player_laststand_proc_ended()
{
	self endon("death");
	common_scripts\utility::flag_waitopen("laststand_on");
	maps\_utility::ent_flag_clear("laststand_proc_running");
	self enabledeathshield(0);
}

//Function Number: 6
laststand_downed_player_manager()
{
	if(maps\_utility::is_coop())
	{
		thread laststand_revive_ents_manager();
	}

	level.laststand_recent_player_downed_time = 0;
	for(;;)
	{
		level.down_player_requests = [];
		level waittill("request_player_downed");
		waittillframeend;
		var_00 = gettime();
		if(var_00 < level.laststand_recent_player_downed_time + level.player_downed_death_buffer_time * 1000)
		{
			continue;
		}

		level.laststand_recent_player_downed_time = var_00;
		var_01 = 0;
		var_02 = undefined;
		level.down_player_requests = maps\_utility::array_randomize(level.down_player_requests);
		foreach(var_04 in level.down_player_requests)
		{
			if(var_04["damage"] >= var_01)
			{
				var_02 = var_04["player"];
			}
		}

		var_02 thread player_laststand_force_down();
		thread maps\_gameskill::resetskill();
	}
}

//Function Number: 7
laststand_revive_ents_manager()
{
	if(!maps\_utility::is_coop())
	{
		return;
	}

	level.default_use_radius = getdvarint("player_useradius");
	level endon("special_op_terminated");
	level.revive_ents = [];
	foreach(var_01 in level.players)
	{
		var_02 = spawn("script_model",var_01.origin + (0,0,28));
		var_02 setmodel("tag_origin");
		var_02 linkto(var_01,"tag_origin",(0,0,28),(0,0,0));
		var_02 sethintstring(&"SCRIPT_COOP_REVIVE");
		level.revive_ents[var_01.unique_id] = var_02;
		var_01 thread player_laststand_on_revive();
	}

	for(;;)
	{
		level waittill("laststand_player_state_changed");
		foreach(var_01 in level.players)
		{
			var_01 revive_set_use_target_state(maps\_utility::is_player_down(var_01));
		}

		if(maps\_utility::get_players_healthy().size == level.players.size)
		{
			setsaveddvar("player_useradius",level.default_use_radius);
			continue;
		}

		setsaveddvar("player_useradius",128);
	}
}

//Function Number: 8
laststand_notify_on_player_state_changes(param_00)
{
	level endon("special_op_terminated");
	foreach(var_02 in level.players)
	{
		var_02 endon("death");
	}

	for(;;)
	{
		foreach(var_02 in level.players)
		{
			var_02 thread notify_on_ent_flag_change("laststand_downed",param_00);
		}

		level waittill(param_00);
	}
}

//Function Number: 9
notify_on_ent_flag_change(param_00,param_01)
{
	level endon("special_op_terminated");
	level endon(param_01);
	self endon("death");
	if(maps\_utility::ent_flag(param_00))
	{
		maps\_utility::ent_flag_waitopen(param_00);
	}
	else
	{
		maps\_utility::ent_flag_wait(param_00);
	}

	level notify(param_01);
}

//Function Number: 10
player_laststand_force_down()
{
	if(!isalive(self))
	{
		return;
	}

	level endon("special_op_terminated");
	self endon("death");
	player_laststand_set_down_attributes();
	if(maps\_utility::is_coop())
	{
		thread player_laststand_downed_dialogue();
		thread player_laststand_on_downed_hud_update();
		thread player_laststand_downed_icon();
	}

	maps\_utility::add_wait(::maps\_utility::ent_flag_waitopen,"laststand_downed");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"coop_bled_out");
	maps\_utility::do_wait_any();
	self notify("end_func_player_laststand_downed_icon");
	if(maps\_utility::ent_flag("laststand_downed"))
	{
		player_laststand_kill();
		return;
	}

	player_laststand_set_original_attributes();
}

//Function Number: 11
player_laststand_on_revive()
{
	self endon("death");
	level endon("special_op_terminated");
	var_00 = player_get_revive_ent();
	var_01 = 0;
	for(;;)
	{
		var_00 waittill("trigger",var_02);
		if(maps\_utility::is_player_down(var_02))
		{
			continue;
		}

		self.laststand_savior = var_02;
		if(maps\_utility::is_player_down(self) && var_02 player_laststand_is_reviving(self))
		{
			laststand_freeze_players(1,var_02,self);
			level.laststand_recent_player_downed_time = 0;
			wait 0.1;
			if(!maps\_utility::is_player_down(self) || !var_02 player_laststand_is_reviving(self))
			{
				var_02 player_laststand_revive_buddy_cleanup(self);
				continue;
			}

			level.bars = [];
			level.bars["p1"] = maps\_hud_util::createclientprogressbar(level.player,level.revive_hud_base_offset + level.revive_bar_offset);
			level.bars["p2"] = maps\_hud_util::createclientprogressbar(level.player2,level.revive_hud_base_offset + level.revive_bar_offset);
			var_03 = randomfloat(1) > 0.33;
			if(var_03)
			{
				var_02 notify("so_reviving");
			}

			var_01 = 0;
			var_04 = 1.5;
			while(maps\_utility::is_player_down(self) && !maps\_utility::is_player_down(var_02) && var_02 player_laststand_is_reviving(self))
			{
				maps\_utility::ent_flag_set("laststand_pause_bleedout_timer");
				foreach(var_06 in level.bars)
				{
					var_06 maps\_hud_util::updatebar(var_01 / var_04);
				}

				wait 0.05;
				var_01 = var_01 + 0.05;
				if(maps\_utility::is_player_down(self) && var_01 > var_04)
				{
					if(!var_03)
					{
						var_02 notify("so_revived");
					}

					var_02 notify("so_revive_success");
					player_laststand_revive_self();
					break;
				}
			}

			var_02 player_laststand_revive_buddy_cleanup(self);
		}
	}
}

//Function Number: 12
player_laststand_is_reviving(param_00)
{
	if(!self usebuttonpressed())
	{
		return 0;
	}

	if(isdefined(param_00.laststand_savior) && param_00.laststand_savior == self)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
player_laststand_revive_self()
{
	self.laststand_revive_time = gettime();
	player_dying_effect_remove();
	maps\_utility::ent_flag_clear("laststand_downed");
	self.coop_death_reason = undefined;
	thread maps\_gameskill::resetskill();
	self notify("revived");
}

//Function Number: 14
player_laststand_revive_buddy_cleanup(param_00)
{
	level notify("revive_bars_killed");
	revive_hud_cleanup_bars();
	if(isdefined(param_00) && isalive(param_00))
	{
		param_00.laststand_savior = undefined;
		param_00 maps\_utility::ent_flag_clear("laststand_pause_bleedout_timer");
	}

	if(isdefined(self) && isalive(self))
	{
		laststand_freeze_players(0,self,param_00);
	}
}

//Function Number: 15
laststand_freeze_players(param_00,param_01,param_02)
{
	param_02 = maps\_utility::get_other_player(self);
	if(param_00)
	{
		param_01 freezecontrols(1);
		param_01 disableweapons();
		param_01 disableweaponswitch();
		param_02 freezecontrols(1);
		param_02 disableweapons();
		return;
	}

	param_01 freezecontrols(0);
	param_01 enableweapons();
	param_01 enableweaponswitch();
	param_02 freezecontrols(0);
	if(!maps\_utility::is_player_down_and_out(param_02))
	{
		param_02 enableweapons();
	}
}

//Function Number: 16
player_laststand_downed_dialogue()
{
	self endon("death");
	self endon("revived");
	level endon("special_op_terminated");
	wait 1;
	self notify("so_downed");
	thread player_laststand_downed_nag_button(0.05);
}

//Function Number: 17
player_laststand_downed_nag_button(param_00)
{
	self endon("death");
	self endon("revived");
	level endon("special_op_terminated");
	if(isdefined(param_00) && param_00 > 0)
	{
		wait param_00;
	}

	self notifyonplayercommand("nag","weapnext");
	for(;;)
	{
		if(!can_show_nag_prompt())
		{
			wait 0.05;
			continue;
		}

		if(nag_should_draw_hud())
		{
			thread nag_prompt_show();
			thread nag_prompt_cancel();
		}

		var_01 = common_scripts\utility::waittill_any_timeout(level.coop_revive_nag_hud_refreshtime,"nag","nag_cancel");
		if(var_01 == "nag")
		{
			self.lastrevivenagbuttonpresstime = gettime();
			thread player_downed_hud_toggle_blinkstate();
			thread maps\_specialops_battlechatter::play_revive_nag();
		}

		wait 0.05;
	}
}

//Function Number: 18
nag_should_draw_hud()
{
	var_00 = level.coop_revive_nag_hud_refreshtime * 1000;
	if(isdefined(self) && isdefined(self.nag_hud_on))
	{
		return 0;
	}
	else if(!isdefined(self.lastrevivenagbuttonpresstime))
	{
		return 1;
	}
	else if(gettime() - self.lastrevivenagbuttonpresstime < var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
nag_prompt_show()
{
	if(!isdefined(self))
	{
		return;
	}

	self.nag_hud_on = 1;
	var_00 = 0.05;
	var_01 = &"SPECIAL_OPS_REVIVE_NAG_HINT";
	var_02 = get_nag_hud();
	var_02.alpha = 0;
	var_02 settext(var_01);
	var_02 fadeovertime(var_00);
	var_02.alpha = 1;
	waittill_disable_nag();
	self.nag_hud_on = undefined;
	var_02 fadeovertime(var_00);
	var_02.alpha = 0;
	var_02 common_scripts\utility::delaycall(var_00 + 0.05,::destroy);
}

//Function Number: 20
get_nag_hud()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 50;
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.fontscale = 1;
	var_00.color = (1,1,1);
	var_00.font = "hudsmall";
	var_00.glowcolor = (0.3,0.6,0.3);
	var_00.glowalpha = 0;
	var_00.foreground = 1;
	var_00.hidewheninmenu = 1;
	var_00.hidewhendead = 1;
	return var_00;
}

//Function Number: 21
nag_prompt_cancel()
{
	self endon("nag");
	while(maps\_utility::is_player_down(self) && can_show_nag_prompt())
	{
		wait 0.05;
	}

	self notify("nag_cancel");
}

//Function Number: 22
can_show_nag_prompt()
{
	if(isdefined(level.hide_nag_prompt) && level.hide_nag_prompt)
	{
		return 0;
	}

	var_00 = maps\_utility::get_other_player(self);
	if(var_00 player_laststand_is_reviving(self))
	{
		return 0;
	}

	if(!maps\_specialops_battlechatter::can_say_current_nag_event_type())
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
laststand_coop_hud_manager()
{
	if(!maps\_utility::is_coop())
	{
		return;
	}

	level endon("special_op_terminated");
	var_00 = [];
	foreach(var_02 in level.players)
	{
		var_00[var_02.unique_id] = maps\_utility::is_player_down(var_02);
	}

	laststand_coop_hud_create();
	for(;;)
	{
		level waittill("laststand_player_state_changed");
		waittillframeend;
		foreach(var_02 in level.players)
		{
			var_05 = maps\_utility::get_other_player(var_02);
			var_06 = var_02 player_laststand_changed_state(var_00);
			var_07 = var_05 player_laststand_changed_state(var_00);
			if(var_06)
			{
				if(maps\_utility::is_player_down(var_02))
				{
					var_02.revive_text_friend.alpha = 0;
					var_02.revive_timer_friend.alpha = 0;
					var_02.revive_text_local thread maps\_specialops::so_hud_pulse_stop();
					var_02.revive_timer_local thread maps\_specialops::so_hud_pulse_stop();
					var_02.revive_text_local.alpha = 1;
					var_02.revive_timer_local.alpha = 1;
					var_02.revive_text_local thread maps\_specialops::so_hud_pulse_create();
					var_02.revive_timer_local thread maps\_specialops::so_hud_pulse_create();
				}
				else if(maps\_utility::is_player_down(var_05))
				{
					var_02.revive_text_local.alpha = 0;
					var_02.revive_timer_local.alpha = 0;
					var_02.revive_text_friend thread maps\_specialops::so_hud_pulse_stop();
					var_02.revive_timer_friend thread maps\_specialops::so_hud_pulse_stop();
					var_02.revive_text_friend.alpha = 1;
					var_02.revive_timer_friend.alpha = 1;
					var_02.revive_text_friend thread maps\_specialops::so_hud_pulse_create();
					var_02.revive_timer_friend thread maps\_specialops::so_hud_pulse_create();
				}
				else
				{
					var_02 player_laststand_hud_hide();
				}
			}

			if(var_07)
			{
				if(!maps\_utility::is_player_down(var_02))
				{
					if(maps\_utility::is_player_down(var_05))
					{
						var_02.revive_text_local.alpha = 0;
						var_02.revive_timer_local.alpha = 0;
						var_02.revive_text_friend thread maps\_specialops::so_hud_pulse_stop();
						var_02.revive_timer_friend thread maps\_specialops::so_hud_pulse_stop();
						var_02.revive_text_friend.alpha = 1;
						var_02.revive_timer_friend.alpha = 1;
						var_02.revive_text_friend thread maps\_specialops::so_hud_pulse_create();
						var_02.revive_timer_friend thread maps\_specialops::so_hud_pulse_create();
						continue;
					}

					var_02 player_laststand_hud_hide();
				}
			}
		}

		foreach(var_02 in level.players)
		{
			var_00[var_02.unique_id] = maps\_utility::is_player_down(var_02);
		}
	}
}

//Function Number: 24
laststand_coop_hud_create()
{
	foreach(var_01 in level.players)
	{
		var_01.revive_text_local = var_01 maps\_hud_util::createclientfontstring("hudsmall",1);
		var_01.revive_text_local maps\_hud_util::setpoint("CENTER",undefined,0,level.revive_hud_base_offset);
		var_01.revive_text_local settext(&"SCRIPT_COOP_BLEEDING_OUT");
		var_01.revive_text_friend = var_01 maps\_hud_util::createclientfontstring("hudsmall",1);
		var_01.revive_text_friend maps\_hud_util::setpoint("CENTER",undefined,0,level.revive_hud_base_offset);
		var_01.revive_text_friend settext(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
		var_01.revive_timer_local = var_01 maps\_hud_util::createclienttimer("hudsmall",1.2);
		var_01.revive_timer_local maps\_hud_util::setpoint("CENTER",undefined,0,level.revive_hud_base_offset + level.revive_bar_offset);
		var_01.revive_timer_friend = var_01 maps\_hud_util::createclienttimer("hudsmall",1.2);
		var_01.revive_timer_friend maps\_hud_util::setpoint("CENTER",undefined,0,level.revive_hud_base_offset + level.revive_bar_offset);
		var_01 player_laststand_hud_hide();
		level.laststand_hud_elements[level.laststand_hud_elements.size] = var_01.revive_text_local;
		level.laststand_hud_elements[level.laststand_hud_elements.size] = var_01.revive_text_friend;
		level.laststand_hud_elements[level.laststand_hud_elements.size] = var_01.revive_timer_local;
		level.laststand_hud_elements[level.laststand_hud_elements.size] = var_01.revive_timer_friend;
	}
}

//Function Number: 25
player_laststand_hud_hide()
{
	self.revive_text_local.alpha = 0;
	self.revive_text_friend.alpha = 0;
	self.revive_timer_local.alpha = 0;
	self.revive_timer_friend.alpha = 0;
}

//Function Number: 26
player_laststand_changed_state(param_00)
{
	var_01 = maps\_utility::is_player_down(self);
	var_02 = param_00[self.unique_id];
	return var_01 != var_02;
}

//Function Number: 27
laststand_getup_hud_init()
{
	if(laststand_get_type() != 2)
	{
		return;
	}

	foreach(var_01 in level.players)
	{
		var_01.laststand_getup_fast = 0;
	}

	laststand_revive_bar_getup_create();
}

//Function Number: 28
laststand_revive_bar_getup_create()
{
	foreach(var_01 in level.players)
	{
		var_02 = level.revive_hud_base_offset + level.revive_bar_getup_offset;
		var_01.revive_bar_getup = maps\_hud_util::createclientprogressbar(var_01,var_02,"white","black",130,12);
		var_01 player_laststand_getup_bar_set_fill(0.5);
		level.laststand_hud_elements[level.laststand_hud_elements.size] = var_01.revive_bar_getup;
		var_01.revive_bar_getup_icon = newclienthudelem(var_01);
		var_01.revive_bar_getup_icon.hidden = 0;
		var_01.revive_bar_getup_icon.elemtype = "icon";
		var_01.revive_bar_getup_icon.hidewheninmenu = 1;
		var_01.revive_bar_getup_icon.archived = 0;
		var_01.revive_bar_getup_icon.x = -93;
		var_01.revive_bar_getup_icon.y = var_02;
		var_01.revive_bar_getup_icon.alignx = "center";
		var_01.revive_bar_getup_icon.aligny = "middle";
		var_01.revive_bar_getup_icon.horzalign = "center";
		var_01.revive_bar_getup_icon.vertalign = "middle";
		var_01.revive_bar_getup_icon.children = [];
		var_01.revive_bar_getup_icon.elemtype = "icon";
		var_01.revive_bar_getup_icon setshader("specialty_self_revive",28,28);
		level.laststand_hud_elements[level.laststand_hud_elements.size] = var_01.revive_bar_getup_icon;
		var_01.revive_bar_getup maps\_hud_util::hidebar(1);
		var_01.revive_bar_getup_icon.alpha = 0;
	}
}

//Function Number: 29
player_laststand_on_downed_hud_update()
{
	self endon("end_func_player_laststand_downed_icon");
	self endon("death");
	self endon("revived");
	level endon("special_op_terminated");
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			var_01.revive_timer_local settimer(self.laststand_info.bleedout_time_default - 1);
			continue;
		}

		var_01.revive_timer_friend settimer(self.laststand_info.bleedout_time_default - 1);
	}

	thread player_laststand_countdown_timer(self.laststand_info.bleedout_time_default);
	var_03 = self.laststand_info.bleedout_time_default;
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			var_01.revive_text_local.color = self.revive_text_local.color;
			var_01.revive_timer_local.color = self.revive_text_local.color;
			continue;
		}

		var_01.revive_text_friend.color = var_01.revive_text_local.color;
		var_01.revive_timer_friend.color = var_01.revive_text_local.color;
	}

	waittillframeend;
	while(var_03)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 == self)
			{
				var_07 = var_01.revive_text_local;
				var_08 = var_01.revive_timer_local;
			}
			else
			{
				var_07 = var_01.revive_text_friend;
				var_08 = var_01.revive_timer_friend;
			}

			var_09 = var_07.color;
			var_0A = get_coop_downed_hud_color(self.laststand_info.bleedout_time,self.laststand_info.bleedout_time_default,0,var_01 == self);
			var_07.color = var_0A;
			var_08.color = var_0A;
			if(distance(var_0A,var_09) > 0.001)
			{
				if(distance(var_0A,var_01.coop_icon_color_dying) <= 0.001)
				{
					var_07.pulse_bounds = 1;
					var_08.pulse_bounds = 1;
				}

				var_07 thread maps\_specialops::so_hud_pulse_create();
				var_08 thread maps\_specialops::so_hud_pulse_create();
			}
		}

		wait 1;
		var_03 = var_03 - 1;
	}
}

//Function Number: 30
player_laststand_downed_icon()
{
	self endon("end_func_player_laststand_downed_icon");
	self endon("death");
	self endon("revived");
	level endon("special_op_terminated");
	waittillframeend;
	var_00 = maps\_utility::get_other_player(self);
	var_00 maps\_coop::friendlyhudicon_downed();
	while(self.laststand_info.bleedout_time > 0)
	{
		maps\_utility::ent_flag_waitopen("laststand_pause_bleedout_timer");
		var_00 maps\_coop::friendlyhudicon_update(get_coop_downed_hud_color(self.laststand_info.bleedout_time,self.laststand_info.bleedout_time_default));
		wait 0.05;
	}
}

//Function Number: 31
player_laststand_countdown_timer(param_00)
{
	self endon("death");
	self endon("revived");
	level endon("special_op_terminated");
	self.laststand_info.bleedout_time = param_00;
	while(self.laststand_info.bleedout_time > 0)
	{
		if(maps\_utility::ent_flag("laststand_pause_bleedout_timer"))
		{
			foreach(var_02 in level.players)
			{
				if(var_02 == self)
				{
					var_02.revive_timer_local.alpha = 0;
					continue;
				}

				var_02.revive_timer_friend.alpha = 0;
			}

			maps\_utility::ent_flag_waitopen("laststand_pause_bleedout_timer");
			if(self.laststand_info.bleedout_time >= 1)
			{
				foreach(var_02 in level.players)
				{
					if(var_02 == self)
					{
						var_02.revive_timer_local settimer(self.laststand_info.bleedout_time - 1);
						continue;
					}

					var_02.revive_timer_friend settimer(self.laststand_info.bleedout_time - 1);
				}
			}
		}
		else
		{
			foreach(var_02 in level.players)
			{
				if(var_02 == self)
				{
					var_02.revive_timer_local.alpha = 1;
					continue;
				}

				if(!maps\_utility::is_player_down(var_02))
				{
					var_02.revive_timer_friend.alpha = 1;
				}
			}
		}

		wait 0.05;
		self.laststand_info.bleedout_time = self.laststand_info.bleedout_time - 0.05;
	}

	self.laststand_info.bleedout_time = 0;
	maps\_specialops::so_force_deadquote("@DEADQUOTE_SO_BLED_OUT","ui_bled_out");
	thread maps\_specialops::so_dialog_mission_failed_bleedout();
	self notify("coop_bled_out");
}

//Function Number: 32
get_coop_downed_hud_color(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) && param_03)
	{
		var_04 = self;
	}
	else
	{
		var_04 = maps\_utility::get_other_player(self);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 && coop_downed_hud_should_blink())
	{
		if(self.blinkstate == 1)
		{
			return var_04.coop_icon_color_blink;
		}
	}

	if(param_00 < param_01 * level.laststand_stage3_multiplier)
	{
		return var_04.coop_icon_color_dying;
	}

	if(param_00 < param_01 * level.laststand_stage2_multiplier)
	{
		return var_04.coop_icon_color_damage;
	}

	return var_04.coop_icon_color_downed;
}

//Function Number: 33
coop_downed_hud_should_blink()
{
	var_00 = maps\_utility::get_other_player(self);
	if(var_00 player_laststand_is_reviving(self))
	{
		return 0;
	}

	if(isdefined(self.lastrevivenagbuttonpresstime))
	{
		if(gettime() - self.lastrevivenagbuttonpresstime < level.coop_icon_blinktime * 1000)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 34
laststand_hud_destroy()
{
	if(isdefined(level.laststand_hud_elements))
	{
		foreach(var_01 in level.laststand_hud_elements)
		{
			if(isdefined(var_01))
			{
				var_01 notify("destroying");
				var_01 maps\_hud_util::destroyelem();
			}
		}
	}

	level.laststand_hud_elements = undefined;
}

//Function Number: 35
player_laststand_set_down_attributes()
{
	self endon("death");
	self notify("player_downed");
	self.ignorerandombulletdamage = 1;
	self enableinvulnerability();
	maps\_utility::ent_flag_set("laststand_downed");
	self.laststand = 1;
	self.health = 2;
	self.maxhealth = self.original_maxhealth;
	self.ignoreme = 1;
	self disableusability();
	self disableweaponswitch();
	self disableoffhandweapons();
	self disableweapons();
	if(!isdefined(self.laststand_down_count))
	{
		self.laststand_down_count = 1;
	}
	else
	{
		self.laststand_down_count++;
	}

	if(isdefined(self.placingsentry))
	{
		self notify("sentry_placement_canceled");
	}

	thread player_laststand_kill_by_vehicle();
	if(laststand_downing_will_fail())
	{
		player_laststand_kill();
		return;
	}

	thread player_laststand_set_down_part1();
}

//Function Number: 36
player_laststand_set_original_attributes()
{
	self.ignorerandombulletdamage = 0;
	maps\_utility::ent_flag_clear("laststand_downed");
	self.laststand = 0;
	self.achieve_downed_kills = undefined;
	self.down_part2_proc_ran = undefined;
	if(maps\_utility::is_coop())
	{
		var_00 = maps\_utility::get_other_player(self);
		var_00 maps\_coop::friendlyhudicon_normal();
	}

	self disableweapons();
	remove_pistol_if_extra();
	self.health = self.maxhealth;
	self.ignoreme = 0;
	self setstance("stand");
	self enableusability();
	self enableoffhandweapons();
	self enableweaponswitch();
	self enableweapons();
	self notify("not_in_last_stand");
	wait 1;
	self disableinvulnerability();
}

//Function Number: 37
remove_pistol_if_extra()
{
	if(isdefined(self.forced_pistol))
	{
		self takeweapon(self.forced_pistol);
		self.forced_pistol = undefined;
	}

	if(isdefined(self.preincap_pistol))
	{
		self setweaponammoclip(self.preincap_pistol,self.preincap_pistol_clip);
		self setweaponammostock(self.preincap_pistol,self.preincap_pistol_stock);
	}

	if(player_can_restore_weapon(self.preincap_weapon))
	{
		self switchtoweapon(self.preincap_weapon);
	}
	else
	{
		var_00 = self getweaponslistprimaries();
		self switchtoweapon(var_00[0]);
	}

	self.preincap_weapon = undefined;
}

//Function Number: 38
player_laststand_kill_by_vehicle()
{
	self endon("revived");
	self endon("death");
	level endon("special_op_terminated");
	if(common_scripts\utility::flag("special_op_terminated"))
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	for(;;)
	{
		var_00 = vehicle_getarray();
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02.dont_crush_player) && var_02.dont_crush_player)
			{
				continue;
			}

			var_03 = var_02 vehicle_getspeed();
			if(abs(var_03) == 0)
			{
				continue;
			}

			if(self istouching(var_02))
			{
				var_02 maps\_specialops::so_crush_player(self,"MOD_CRUSH");
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 39
player_laststand_set_down_part1()
{
	self endon("revived");
	self endon("death");
	level endon("special_op_terminated");
	if(laststand_get_type() != 2)
	{
		wait 0.3;
	}

	thread player_laststand_force_switch_to_pistol();
	if(laststand_get_type() == 2)
	{
		if(get_lives_remaining() > 0)
		{
			if(!isdefined(self.laststand_count))
			{
				self.laststand_count = 1;
			}
			else
			{
				self.laststand_count++;
			}

			if(self.laststand_count <= 9999)
			{
				thread player_laststand_getup_sequence();
				self waittill("laststand_getup_failed");
			}

			if(!maps\_utility::is_coop() || maps\_utility::is_player_down_and_out(maps\_utility::get_other_player(self)))
			{
				player_laststand_kill();
				return;
			}
		}
		else
		{
			waittillframeend;
		}
	}
	else
	{
		wait 0.25;
		self disableinvulnerability();
		thread player_laststand_down_draw_attention();
		self waittill("damage");
	}

	thread player_laststand_set_down_part2();
}

//Function Number: 40
player_laststand_getup_sequence()
{
	self endon("revived");
	self endon("death");
	self endon("laststand_getup_failed");
	level endon("special_op_terminated");
	thread player_laststand_getup_sequence_clean_up();
	thread player_laststand_getup_sequence_catch_kills();
	thread player_laststand_getup_sequence_catch_damage();
	thread player_laststand_getup_sequence_bad_place();
	thread player_laststand_effect();
	thread player_laststand_getup_sequence_ignore();
	var_00 = self.laststand_count - 1 * 0;
	var_01 = max(0.5 - var_00,0.2);
	player_laststand_getup_bar_set_fill(var_01);
	self.revive_bar_getup maps\_hud_util::hidebar(0);
	self.revive_bar_getup_icon.alpha = 1;
	wait 2;
	self disableinvulnerability();
	self.last_damage_time = gettime();
	for(;;)
	{
		var_02 = 0;
		if(isdefined(self.laststand_getup_fast) && self.laststand_getup_fast)
		{
			var_02 = 1;
		}
		else if(gettime() - self.last_damage_time > 3000)
		{
			var_02 = 1;
		}

		var_03 = common_scripts\utility::ter_op(var_02,0.01,0.0025);
		player_laststand_getup_bar_adjust(var_03);
		wait 0.05;
	}
}

//Function Number: 41
player_laststand_getup_sequence_clean_up()
{
	level endon("special_op_terminated");
	self endon("death");
	var_00 = common_scripts\utility::waittill_any_return("player_down_and_out","revived");
	if(isdefined(var_00) && var_00 == "player_down_and_out")
	{
		self.ignoreme = 1;
	}

	update_lives_remaining(0);
	thread player_laststand_getup_sequence_clean_up_delayed(0.5);
	self.laststand_getup_fast = 0;
	if(isdefined(self.laststand_badplace))
	{
		badplace_delete(self.laststand_badplace);
		self.laststand_badplace = undefined;
	}
}

//Function Number: 42
player_laststand_getup_sequence_clean_up_delayed(param_00)
{
	level endon("special_op_terminated");
	self endon("player_downed");
	wait param_00;
	self.revive_bar_getup maps\_hud_util::hidebar(1);
	self.revive_bar_getup_icon.alpha = 0;
}

//Function Number: 43
player_laststand_getup_sequence_ignore()
{
	self endon("revived");
	self endon("death");
	self endon("laststand_getup_failed");
	level endon("special_op_terminated");
	self.ignoreme = 1;
	wait 0.25;
	self.ignoreme = 0;
}

//Function Number: 44
player_laststand_getup_sequence_catch_kills()
{
	self endon("revived");
	self endon("death");
	self endon("laststand_getup_failed");
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("revive_kill");
		player_laststand_getup_bar_adjust(1);
	}
}

//Function Number: 45
player_laststand_getup_sequence_catch_damage()
{
	self endon("revived");
	self endon("death");
	self endon("laststand_getup_failed");
	level endon("special_op_terminated");
	for(;;)
	{
		common_scripts\utility::waittill_any("damage","deathshield");
		player_laststand_getup_bar_adjust(-0.1);
		self.last_damage_time = gettime();
		wait 0.2;
	}
}

//Function Number: 46
player_laststand_getup_sequence_bad_place()
{
	self endon("revived");
	self endon("death");
	self endon("laststand_getup_failed");
	level endon("special_op_terminated");
	self.laststand_badplace = self.unique_id + "_ls_badplace";
	for(;;)
	{
		badplace_cylinder(self.laststand_badplace,90,self.origin,120,120,"axis");
		wait 90;
		badplace_delete(self.laststand_badplace);
	}
}

//Function Number: 47
player_laststand_getup_bar_adjust(param_00)
{
	param_00 = clamp(param_00,-1,1);
	var_01 = clamp(self.revive_bar_getup.bar.frac + param_00,0,1);
	player_laststand_getup_bar_set_fill(var_01);
	if(var_01 == 1)
	{
		player_laststand_revive_self();
		return;
	}

	if(var_01 == 0)
	{
		self notify("laststand_getup_failed");
	}
}

//Function Number: 48
player_laststand_getup_bar_set_fill(param_00)
{
	var_01 = (1,0.4,0.4);
	var_02 = (1,0,0);
	self.revive_bar_getup.bar.color = vectorlerp(var_02,var_01,param_00);
	self.revive_bar_getup maps\_hud_util::updatebar(param_00);
}

//Function Number: 49
player_laststand_set_down_part2()
{
	self.down_part2_proc_ran = 1;
	self notify("player_down_and_out");
	self disableweapons();
	thread player_dying_effect();
	self.ignoreme = 1;
	self.ignorerandombulletdamage = 1;
	self enableinvulnerability();
}

//Function Number: 50
player_laststand_force_switch_to_pistol()
{
	self.preincap_weapon = self getcurrentweapon();
	var_00 = player_laststand_check_for_pistol();
	self.preincap_pistol = undefined;
	self.preincap_pistol_stock = 0;
	self.preincap_pistol_clip = 0;
	var_01 = undefined;
	if(isdefined(var_00))
	{
		self.preincap_pistol = var_00;
		self.preincap_pistol_stock = self getweaponammostock(var_00);
		self.preincap_pistol_clip = self getweaponammoclip(var_00);
		var_01 = var_00;
	}
	else if(isdefined(level.coop_incap_weapon))
	{
		var_02 = isdefined(level.coop_incap_weapon) && self hasweapon(level.coop_incap_weapon);
		if(!var_02)
		{
			self.forced_pistol = level.coop_incap_weapon;
			self giveweapon(level.coop_incap_weapon);
		}
		else
		{
			self.preincap_pistol = level.coop_incap_weapon;
			self.preincap_pistol_stock = self getweaponammostock(var_00);
			self.preincap_pistol_clip = self getweaponammoclip(var_00);
		}

		var_01 = level.coop_incap_weapon;
	}
	else
	{
		var_01 = "fnfiveseven";
		self.forced_pistol = var_01;
		self giveweapon(var_01);
	}

	self setweaponammoclip(var_01,weaponclipsize(var_01));
	self setweaponammostock(var_01,weaponmaxammo(var_01));
	thread player_laststand_on_reload_fill_stock();
	self switchtoweapon(var_01);
	self enableweapons();
}

//Function Number: 51
player_laststand_on_reload_fill_stock()
{
	level endon("special_op_terminated");
	self endon("death");
	self endon("player_down_and_out");
	self endon("not_in_last_stand");
	self endon("revived");
	self endon("weapon_change");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getcurrentweapon();
		self setweaponammostock(var_00,weaponmaxammo(var_00));
	}
}

//Function Number: 52
player_laststand_down_draw_attention()
{
	self endon("death");
	self endon("revived");
	self endon("damage");
	notifyoncommand("draw_attention","+attack");
	notifyoncommand("draw_attention","+attack_akimbo_accessible");
	common_scripts\utility::waittill_any_timeout(4,"draw_attention","player_down_and_out");
	if(maps\_utility::is_player_down_and_out(self))
	{
		return;
	}

	self.ignoreme = 0;
	self.ignorerandombulletdamage = 0;
}

//Function Number: 53
ai_laststand_on_death()
{
	level endon("special_op_terminated");
	self waittill("death",var_00,var_01,var_02);
	var_03 = 0;
	if(isdefined(var_00) && isalive(var_00) && isplayer(var_00) && maps\_utility::is_player_down(var_00))
	{
		if(isdefined(var_02) && weaponclass(var_02) == "pistol")
		{
			var_03 = 1;
		}
		else if(isdefined(var_01) && var_01 == "MOD_MELEE")
		{
			var_03 = 1;
		}
	}

	if(var_03)
	{
		var_00 notify("revive_kill");
	}
}

//Function Number: 54
player_dying_effect()
{
	self endon("death");
	self endon("revived");
	if(!maps\_utility::ent_flag_exist("laststand_dying_effect"))
	{
		maps\_utility::ent_flag_init("laststand_dying_effect");
	}
	else if(maps\_utility::ent_flag("laststand_dying_effect"))
	{
		return;
	}

	maps\_utility::ent_flag_set("laststand_dying_effect");
	player_shock_effect("default",60,1);
}

//Function Number: 55
player_dying_effect_remove()
{
	if(maps\_utility::ent_flag_exist("laststand_dying_effect"))
	{
		maps\_utility::ent_flag_clear("laststand_dying_effect");
	}

	self stopshellshock();
}

//Function Number: 56
player_laststand_effect()
{
	self endon("death");
	self endon("revived");
	self endon("player_down_and_out");
	self notify("laststand_effect");
	self endon("laststand_effect");
	player_shock_effect("laststand_getup",60,1);
}

//Function Number: 57
player_shock_effect(param_00,param_01,param_02,param_03)
{
	self endon("death");
	level endon("special_op_terminated");
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	if(isdefined(param_03))
	{
		var_04 = strtok(param_03," ");
		foreach(var_06 in var_04)
		{
			self endon(var_06);
		}
	}

	for(;;)
	{
		self shellshock(param_00,param_01);
		wait param_01;
		if(isdefined(param_02) && !param_02)
		{
			break;
		}
	}
}

//Function Number: 58
laststand_get_type()
{
	var_00 = (isdefined(level.laststand_type) && level.laststand_type == 0) || level.laststand_type == 1 || level.laststand_type == 2;
	if(var_00)
	{
		return level.laststand_type;
	}

	return 0;
}

//Function Number: 59
laststand_can_pick_self_up()
{
	return laststand_get_type() == 2 && get_lives_remaining() > 0;
}

//Function Number: 60
laststand_downing_will_fail()
{
	if(maps\_utility::is_coop())
	{
		var_00 = maps\_utility::get_other_player(self);
		var_01 = (maps\_utility::is_player_down(var_00) && !var_00 laststand_can_pick_self_up()) || maps\_utility::is_player_down_and_out(var_00);
		if(var_01 && !laststand_can_pick_self_up())
		{
			return 1;
		}

		return 0;
	}

	if(!laststand_can_pick_self_up())
	{
		return 1;
	}

	return 0;
}

//Function Number: 61
get_lives_remaining()
{
	if(laststand_get_type() == 2 && isdefined(self.laststand_info.type_getup_lives))
	{
		return max(0,self.laststand_info.type_getup_lives);
	}

	return 0;
}

//Function Number: 62
update_lives_remaining(param_00)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00),param_00,0);
	self.laststand_info.type_getup_lives = max(0,common_scripts\utility::ter_op(param_00,self.laststand_info.type_getup_lives + 1,self.laststand_info.type_getup_lives - 1));
	self notify("laststand_lives_updated");
}

//Function Number: 63
player_laststand_kill()
{
	level endon("special_op_terminated");
	thread player_dying_effect_remove();
	self enabledeathshield(0);
	self disableinvulnerability();
	self enablehealthshield(0);
	self.achieve_downed_kills = undefined;
	waittillframeend;
	self kill();
}

//Function Number: 64
try_crush_player(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.dont_crush_player) && param_00.dont_crush_player)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(param_01 != "MOD_CRUSH")
	{
		return;
	}

	if(isdefined(param_00.vehicletype))
	{
		var_02 = param_00 vehicle_getspeed();
		if(abs(var_02) == 0)
		{
			return;
		}
	}

	if(common_scripts\utility::flag("special_op_terminated"))
	{
		return;
	}

	param_00 maps\_specialops::so_crush_player(self,param_01);
}

//Function Number: 65
player_laststand_check_for_pistol(param_00)
{
	var_01 = self getweaponslistprimaries();
	if(isdefined(param_00))
	{
		foreach(var_03 in var_01)
		{
			if(var_03 == param_00)
			{
				return var_03;
			}
		}
	}

	var_05 = self getcurrentweapon();
	if(weaponclass(var_05) == "pistol")
	{
		return var_05;
	}

	foreach(var_03 in var_01)
	{
		if(weaponclass(var_03) == "pistol")
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 66
laststand_on_mission_end()
{
	level waittill("special_op_terminated");
	revive_destroy_use_targets();
	revive_hud_cleanup_bars();
	laststand_hud_destroy();
}

//Function Number: 67
revive_hud_cleanup_bars()
{
	if(isdefined(level.bars))
	{
		foreach(var_01 in level.bars)
		{
			if(isdefined(var_01))
			{
				var_01 notify("destroying");
				var_01 maps\_hud_util::destroyelem();
			}
		}

		level.bars = undefined;
	}
}

//Function Number: 68
waittill_disable_nag()
{
	level endon("special_op_terminated");
	common_scripts\utility::waittill_any("nag","nag_cancel","death","revived");
}

//Function Number: 69
player_can_restore_weapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(!self hasweapon(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 70
revive_set_use_target_state(param_00)
{
	var_01 = player_get_revive_ent();
	if(param_00)
	{
		var_01 makeusable();
	}
	else
	{
		var_01 makeunusable();
	}

	return var_01;
}

//Function Number: 71
player_get_revive_ent()
{
	return level.revive_ents[self.unique_id];
}

//Function Number: 72
revive_destroy_use_targets()
{
	if(isdefined(level.revive_ents))
	{
		foreach(var_01 in level.revive_ents)
		{
			var_01 delete();
		}
	}
}

//Function Number: 73
player_downed_hud_toggle_blinkstate()
{
	self notify("player_downed_hud_blinkstate");
	self endon("player_downed_hud_blinkstate");
	self endon("death");
	self endon("revived");
	self.blinkstate = 1;
	for(;;)
	{
		wait level.coop_icon_blinkcrement;
		if(self.blinkstate == 1)
		{
			self.blinkstate = 0;
			continue;
		}

		self.blinkstate = 1;
	}
}