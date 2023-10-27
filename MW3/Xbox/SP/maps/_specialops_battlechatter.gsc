/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_specialops_battlechatter.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 627 ms
 * Timestamp: 10/27/2023 2:33:32 AM
*******************************************************************/

//Function Number: 1
init()
{
	anim.so = spawnstruct();
	level.so.eventtypes = [];
	level.so.eventtypes["check_fire"] = "threat_friendly_fire";
	level.so.eventtypes["reload"] = "inform_reload_generic";
	level.so.eventtypes["frag_out"] = "inform_attack_grenade";
	level.so.eventtypes["flash_out"] = "inform_attack_flashbang";
	level.so.eventtypes["smoke_out"] = "inform_attack_smoke";
	level.so.eventtypes["c4_plant"] = "inform_attack_c4";
	level.so.eventtypes["claymore_plant"] = "inform_plant_claymore";
	level.so.eventtypes["downed"] = "inform_suppressed";
	level.so.eventtypes["bleedout"] = "inform_bleedout";
	level.so.eventtypes["reviving"] = "inform_reviving";
	level.so.eventtypes["revived"] = "inform_revived";
	level.so.eventtypes["sentry_out"] = "inform_place_sentry";
	level.so.eventtypes["area_secure"] = "inform_area_secure";
	level.so.eventtypes["kill_generic"] = "inform_kill_generic";
	level.so.eventtypes["kill_infantry"] = "inform_kill_infantry";
	level.so.eventtypes["affirmative"] = "inform_roger";
	level.so.eventtypes["negative"] = "inform_negative";
	level.so.eventtypes["on_comms"] = "inform_comms";
	level.so.eventtypes["mark_dropzone"] = "inform_markdz";
	level.so.eventtypes["glowstick_out"] = "inform_use_glowstick";
	level.so.eventtypeminwait = [];
	level.so.eventtypeminwait["check_fire"] = 4;
	level.so.eventtypeminwait["reload"] = 8;
	level.so.eventtypeminwait["frag_out"] = 3;
	level.so.eventtypeminwait["flash_out"] = 3;
	level.so.eventtypeminwait["smoke_out"] = 3;
	level.so.eventtypeminwait["c4_plant"] = 2;
	level.so.eventtypeminwait["claymore_plant"] = 2;
	level.so.eventtypeminwait["downed"] = 0.5;
	level.so.eventtypeminwait["bleedout"] = 0.5;
	level.so.eventtypeminwait["reviving"] = 2;
	level.so.eventtypeminwait["revived"] = 2;
	level.so.eventtypeminwait["sentry_out"] = 3;
	level.so.eventtypeminwait["kill_generic"] = 2;
	level.so.eventtypeminwait["kill_infantry"] = 2;
	level.so.eventtypeminwait["area_secure"] = 0.5;
	level.so.eventtypeminwait["affirmative"] = 2;
	level.so.eventtypeminwait["negative"] = 2;
	level.so.eventtypeminwait["on_comms"] = 0.5;
	level.so.eventtypeminwait["mark_dropzone"] = 0.5;
	level.so.eventtypeminwait["glowstick_out"] = 3;
	level.so.skipdistancecheck = [];
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "affirmative";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "negative";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "area_secure";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "on_comms";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "mark_dropzone";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "downed";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "bleedout";
	level.so.skipdistancecheck[level.so.skipdistancecheck.size] = "check_fire";
	level.so.noreloadcalloutweapons = [];
	level.so.noreloadcalloutweapons[level.so.noreloadcalloutweapons.size] = "m79";
	level.so.noreloadcalloutweapons[level.so.noreloadcalloutweapons.size] = "ranger";
	level.so.noreloadcalloutweapons[level.so.noreloadcalloutweapons.size] = "claymore";
	level.so.noreloadcalloutweapons[level.so.noreloadcalloutweapons.size] = "rpg";
	level.so.noreloadcalloutweapons[level.so.noreloadcalloutweapons.size] = "rpg_player";
	level.so.bcmaxdistsqd = 640000;
	level.so.bcprintfailprefix = "^3***** BCS FAILURE: ";
	common_scripts\utility::array_thread(level.players,::enable_chatter_on_player);
	enable_chatter();
}

//Function Number: 2
enable_chatter()
{
	level.so_player_chatter_enabled = 1;
}

//Function Number: 3
disable_chatter()
{
	level.so_player_chatter_enabled = 0;
}

//Function Number: 4
enable_chatter_on_player()
{
	self.so_isspeaking = 0;
	self.bc_eventtypelastusedtime = [];
	thread revive_tracking();
	thread claymore_tracking();
	thread reload_tracking();
	thread grenade_tracking();
	thread friendlyfire_tracking();
	thread friendlyfire_whizby_tracking();
	thread sentry_tracking();
	thread kill_generic_tracking();
	thread kill_infantry_tracking();
	thread area_secure_tracking();
	thread affirmative_tracking();
	thread negative_tracking();
	thread on_comms_tracking();
	thread mark_dropzone_tracking();
	thread glowstick_tracking();
}

//Function Number: 5
revive_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("so_downed","so_bleedingout","so_reviving","so_revived");
		if(var_00 == "so_downed")
		{
			play_so_chatter("downed");
			continue;
		}

		if(var_00 == "so_bleedingout")
		{
			play_so_chatter("bleedout");
			continue;
		}

		if(var_00 == "so_reviving")
		{
			play_so_chatter("reviving");
			continue;
		}

		if(var_00 == "so_revived")
		{
			play_so_chatter("revived");
		}
	}
}

//Function Number: 6
claymore_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("begin_firing");
		var_00 = self getcurrentweapon();
		if(var_00 == "claymore")
		{
			play_so_chatter("claymore_plant");
		}
	}
}

//Function Number: 7
sentry_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("sentry_placement_finished");
		play_so_chatter("sentry_out");
	}
}

//Function Number: 8
kill_generic_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_kill_generic");
		play_so_chatter("kill_generic");
	}
}

//Function Number: 9
kill_infantry_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_kill_infantry");
		play_so_chatter("kill_infantry");
	}
}

//Function Number: 10
area_secure_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_area_secure");
		play_so_chatter("area_secure");
	}
}

//Function Number: 11
affirmative_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_affirmative");
		play_so_chatter("area_secure");
	}
}

//Function Number: 12
negative_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_negative");
		play_so_chatter("negative");
	}
}

//Function Number: 13
on_comms_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_on_comms");
		play_so_chatter("on_comms");
	}
}

//Function Number: 14
mark_dropzone_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_bcs_mark_dropzone");
		play_so_chatter("mark_dropzone");
	}
}

//Function Number: 15
glowstick_tracking()
{
}

//Function Number: 16
reload_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("reload_start");
		var_00 = self getcurrentweapon();
		if(weapon_no_reload_callout(var_00))
		{
			continue;
		}

		if(is_downed())
		{
			continue;
		}

		play_so_chatter("reload");
	}
}

//Function Number: 17
weapon_no_reload_callout(param_00)
{
	foreach(var_02 in level.so.noreloadcalloutweapons)
	{
		if(param_00 == var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 18
grenade_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = undefined;
		if(var_01 == "fraggrenade")
		{
			var_02 = "frag_out";
		}
		else if(var_01 == "semtex_grenade")
		{
			var_02 = "frag_out";
		}
		else if(var_01 == "flash_grenade")
		{
			var_02 = "flash_out";
		}
		else if(var_01 == "smoke_grenade_american")
		{
			var_02 = "smoke_out";
		}
		else if(var_01 == "c4")
		{
			var_02 = "c4_plant";
		}

		if(isdefined(var_02))
		{
			play_so_chatter(var_02);
		}
	}
}

//Function Number: 19
friendlyfire_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!friendlyfire_is_valid(var_00,var_01,var_04))
		{
			continue;
		}

		play_so_chatter("check_fire");
	}
}

//Function Number: 20
friendlyfire_is_valid(param_00,param_01,param_02)
{
	if(param_00 <= 0)
	{
		return 0;
	}

	if(!isplayer(param_01))
	{
		return 0;
	}

	if(param_01 == self)
	{
		return 0;
	}

	if(param_02 == "MOD_MELEE")
	{
		return 0;
	}

	if(isdefined(level.friendlyfire_warnings) && !level.friendlyfire_warnings)
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
friendlyfire_whizby_tracking()
{
	level endon("special_op_terminated");
	self endon("death");
	self addaieventlistener("bulletwhizby");
	for(;;)
	{
		self waittill("ai_event",var_00,var_01,var_02);
		if(var_00 == "bulletwhizby")
		{
			if(!friendlyfire_whizby_is_valid(var_01,var_02))
			{
				continue;
			}

			play_so_chatter("check_fire");
		}
	}
}

//Function Number: 22
friendlyfire_whizby_is_valid(param_00,param_01)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(param_00 == self)
	{
		return 0;
	}

	if(is_downed())
	{
		return 0;
	}

	if(abs(param_01[2] - self.origin[2] > 128))
	{
		return 0;
	}

	var_02 = distance2d(self.origin,param_01);
	if(!animscripts/battlechatter_ai::friendlyfire_whizby_distances_valid(param_00,var_02))
	{
		return 0;
	}

	if(isdefined(level.friendlyfire_warnings) && !level.friendlyfire_warnings)
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
func_0EF1()
{
	var_00 = func_0EF2();
	play_so_chatter(var_00);
}

//Function Number: 24
func_0EF2()
{
	var_00 = "downed";
	var_01 = self.var_EF3.bleedout_time;
	var_02 = self.var_EF3.bleedout_time_default;
	if(var_01 < var_02 * level.laststand_stage2_multiplier)
	{
		var_00 = "bleedout";
	}

	return var_00;
}

//Function Number: 25
can_say_current_nag_event_type()
{
	var_00 = func_0EF2();
	return can_say_event_type(var_00);
}

//Function Number: 26
play_so_chatter(param_00)
{
	level endon("special_op_terminated");
	self endon("death");
	if(!can_say_event_type(param_00))
	{
		return;
	}

	if(!func_0F01(param_00))
	{
		return;
	}

	var_01 = get_player_team_prefix(self) + level.so.eventtypes[param_00];
	var_01 = check_overrides(param_00,var_01);
	if(!isdefined(var_01))
	{
		return;
	}

	if(!soundexists(var_01))
	{
		return;
	}

	self.so_isspeaking = 1;
	self playsound(var_01,"bc_done",1);
	self waittill("bc_done");
	self.so_isspeaking = 0;
	func_0EFA(param_00);
}

//Function Number: 27
can_say_event_type(param_00)
{
	if(!isdefined(level.so_player_chatter_enabled) || !level.so_player_chatter_enabled)
	{
		return 0;
	}

	if(self.so_isspeaking)
	{
		return 0;
	}

	if(!isdefined(self.bc_eventtypelastusedtime[param_00]))
	{
		return 1;
	}

	var_01 = self.bc_eventtypelastusedtime[param_00];
	var_02 = level.so.eventtypeminwait[param_00] * 1000;
	if(gettime() - var_01 >= var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_0EFA(param_00)
{
	self.bc_eventtypelastusedtime[param_00] = gettime();
}

//Function Number: 29
check_overrides(param_00,param_01)
{
	if(param_00 == "reload")
	{
		if(isdefined(level.so_override["skip_inform_reloading"]) && level.so_override["skip_inform_reloading"])
		{
			return undefined;
		}

		if(isdefined(level.so_override["inform_reloading"]))
		{
			return level.so_override["inform_reloading"];
		}
	}

	return param_01;
}

//Function Number: 30
get_player_team_prefix(param_00)
{
	var_01 = "";
	if(isdefined(level.so_stealth) && level.so_stealth)
	{
		var_01 = "STEALTH_";
	}

	var_02 = "1";
	if(param_00 == level.player2)
	{
		var_02 = "2";
	}

	switch(level.so_campaign)
	{
		case "fso":
		case "hijack":
		case "delta":
		case "ranger":
			return "SO_US_" + var_02 + "_" + var_01;

		case "seal":
			return "SO_NS_" + var_02 + "_" + var_01;

		case "sas":
		case "ghillie":
		case "woodland":
		case "desert":
		case "arctic":
			return "SO_UK_" + var_02 + "_" + var_01;

		default:
			break;
	}
}

//Function Number: 31
func_0F01(param_00)
{
	if(isdefined(param_00))
	{
		foreach(var_02 in level.so.skipdistancecheck)
		{
			if(var_02 == param_00)
			{
				return 1;
			}
		}
	}

	var_04 = maps\_utility::get_other_player(self);
	if(distancesquared(var_04.origin,self.origin) > level.so.bcmaxdistsqd)
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
is_downed()
{
	if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
	{
		return 1;
	}

	return 0;
}