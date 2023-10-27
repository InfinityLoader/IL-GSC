/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_challenge.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 538 ms
 * Timestamp: 10/27/2023 2:21:27 AM
*******************************************************************/

//Function Number: 1
precache_challenge_strings()
{
	precachestring(&"SO_SURVIVAL_SUR_CH_HEADSHOT");
	precachestring(&"SO_SURVIVAL_SUR_CH_STREAK");
	precachestring(&"SO_SURVIVAL_SUR_CH_STAGGER");
	precachestring(&"SO_SURVIVAL_SUR_CH_QUADKILL");
	precachestring(&"SO_SURVIVAL_SUR_CH_FLASH");
	precachestring(&"SO_SURVIVAL_SUR_CH_KNIFE");
}

//Function Number: 2
ch_populate()
{
	var_00 = 0;
	var_01 = 20;
	var_02 = [];
	for(var_03 = var_00;var_03 <= var_01;var_03++)
	{
		var_04 = ch_get_ref_by_index(var_03);
		if(!isdefined(var_04) || var_04 == "")
		{
			break;
		}

		var_05 = spawnstruct();
		var_05.idx = var_03;
		var_05.ref = var_04;
		var_05.name = ch_get_name(var_04);
		var_05.var_189B = ch_get_desc(var_04);
		var_05.splash = ch_get_splash(var_04);
		var_05.icon = ch_get_icon(var_04);
		var_05.requirement = ch_get_requirement(var_04);
		var_05.xp = ch_get_xp(var_04);
		var_05.repeatable = ch_get_repeatable(var_04);
		var_05.carry = ch_get_carry(var_04);
		var_05.wave_active = ch_get_wave_active(var_04);
		var_05.wave_inactive = ch_get_wave_inactive(var_04);
		var_05.func = challenge_func_director(var_04);
		var_02[var_04] = var_05;
	}

	return var_02;
}

//Function Number: 3
challenge_init()
{
	level.sur_ch = ch_populate();
	common_scripts\utility::flag_init("challenge_monitor_busy");
	maps\_utility::add_global_spawn_function("axis",::track_melee_streak);
	maps\_utility::add_global_spawn_function("axis",::track_flash_kill);
	foreach(var_01 in level.players)
	{
		var_01 thread sur_challenge_think();
	}
}

//Function Number: 4
sur_challenge_think()
{
	wait 0.05;
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		maps\_specialops::surhud_challenge_label(var_00,"");
		maps\_specialops::surhud_challenge_progress(var_00,0);
		maps\_specialops::surhud_challenge_reward(var_00,0);
	}

	maps\_specialops::surhud_disable("challenge");
	common_scripts\utility::flag_wait("start_survival");
	for(;;)
	{
		var_01 = [];
		foreach(var_03 in level.sur_ch)
		{
			if(var_03.wave_active == 0)
			{
				continue;
			}

			if(var_03.wave_inactive == 0)
			{
				if(level.current_wave >= var_03.wave_active)
				{
					var_01[var_01.size] = var_03;
				}

				continue;
			}

			if(level.current_wave >= var_03.wave_active && level.current_wave <= var_03.wave_inactive)
			{
				var_01[var_01.size] = var_03;
			}
		}

		var_05 = 0;
		var_01 = maps\_utility::array_randomize(var_01);
		self.selected_ch_array = [];
		self.completed_ch = [];
		foreach(var_07 in var_01)
		{
			if(var_05 == 2)
			{
				break;
			}

			self.selected_ch_array[var_07.ref] = spawnstruct();
			self.selected_ch_array[var_07.ref].index = var_05;
			self.selected_ch_array[var_07.ref].struct = var_07;
			self.completed_ch[var_07.ref] = 0;
			self thread [[ var_07.func ]](var_07.ref);
			var_05++;
		}

		maps\_specialops::surhud_animate("challenge");
		level waittill("wave_ended");
		level waittill("wave_started");
		self notify("challenge_reset");
	}
}

//Function Number: 5
challenge_func_director(param_00)
{
	switch(param_00)
	{
		case "sur_ch_headshot":
			return ::sur_ch_headshot;

		case "sur_ch_streak":
			return ::sur_ch_streak;

		case "sur_ch_stagger":
			return ::sur_ch_stagger;

		case "sur_ch_quadkill":
			return ::sur_ch_quadkill;

		case "sur_ch_knife":
			return ::sur_ch_knife;

		case "sur_ch_flash":
			return ::sur_ch_flash;
	}

	return undefined;
}

//Function Number: 6
sur_ch_generic(param_00)
{
	self endon("death");
	self endon("challenge_reset");
	var_01 = self.selected_ch_array[param_00].index;
	var_02 = ch_get_requirement(param_00);
	var_03 = ch_get_xp(param_00);
	var_04 = ch_get_carry(param_00);
	var_05 = ch_get_repeatable(param_00);
	self.selected_ch_array[param_00].completed = 0;
	self.selected_ch_array[param_00].progress = 0;
	thread setup_ch_progress_bar(var_01,param_00);
	var_06 = undefined;
	for(;;)
	{
		while(self.selected_ch_array[param_00].progress < var_02)
		{
			self waittill(param_00,var_07,var_06);
			if(!isdefined(var_07))
			{
				var_07 = 1;
			}

			if(var_07 < 0)
			{
				self.selected_ch_array[param_00].progress = 0;
			}
			else
			{
				self.selected_ch_array[param_00].progress = self.selected_ch_array[param_00].progress + var_07;
			}

			thread ch_progress_bar_update(param_00);
		}

		if(isdefined(var_06) && isai(var_06))
		{
			playfx(level._effect["money"],var_06.origin + (0,0,32));
		}

		self.selected_ch_array[param_00].progress = 0;
		self.selected_ch_array[param_00].completed++;
		var_08 = self.selected_ch_array[param_00].completed * ch_get_xp(param_00);
		maps\_utility::givexp(param_00,var_08);
		thread indicate_completion(param_00,var_08);
		while(common_scripts\utility::flag("challenge_monitor_busy"))
		{
			wait 0.05;
		}

		self notify("challenge_complete",param_00);
		maps\_utility::delaythread(0.05,::ch_progress_bar_update,param_00);
		if(!var_05)
		{
			return;
		}
	}
}

//Function Number: 7
generic_kill_monitor(param_00,param_01)
{
	self endon("death");
	self endon("challenge_reset");
	for(;;)
	{
		var_02 = self.stats["kills"];
		level waittill("specops_player_kill",var_03,var_04,var_05,var_06);
		if(!isalive(var_03) || var_03 != self)
		{
			continue;
		}

		waittillframeend;
		if(var_02 < self.stats["kills"])
		{
			var_07 = self.stats["kills"] - var_02;
			for(var_08 = 0;var_08 < var_07;var_08++)
			{
				self notify(param_00,param_01,var_04);
				waittillframeend;
			}
		}
	}
}

//Function Number: 8
sur_ch_flash(param_00)
{
	thread sur_ch_generic(param_00);
}

//Function Number: 9
track_flash_kill()
{
	level endon("special_op_terminated");
	if(!isai(self))
	{
		return;
	}

	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(var_00) || !isplayer(var_00))
	{
		return;
	}

	if(common_scripts\utility::isflashed())
	{
		var_00 notify("sur_ch_flash",1);
	}
}

//Function Number: 10
sur_ch_knife(param_00)
{
	thread sur_ch_generic(param_00);
}

//Function Number: 11
track_melee_streak()
{
	level endon("special_op_terminated");
	if(!isai(self))
	{
		return;
	}

	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(var_00) || !isplayer(var_00))
	{
		return;
	}

	if(isdefined(var_02) && weapontype(var_02) == "riotshield")
	{
		var_00 notify("sur_ch_knife",-1);
		return;
	}

	if(isdefined(var_01) && var_01 == "MOD_MELEE")
	{
		var_00 notify("sur_ch_knife",1);
		return;
	}

	var_00 notify("sur_ch_knife",-1);
}

//Function Number: 12
sur_ch_quadkill(param_00)
{
	thread sur_ch_generic(param_00);
}

//Function Number: 13
sur_ch_headshot(param_00)
{
	thread sur_ch_generic(param_00);
}

//Function Number: 14
sur_ch_streak(param_00)
{
	self endon("death");
	self endon("challenge_reset");
	thread sur_ch_generic(param_00);
	waittillframeend;
	thread generic_kill_monitor(param_00,1);
	thread streak_reset(param_00);
}

//Function Number: 15
streak_reset(param_00)
{
	self endon("death");
	self endon("challenge_reset");
	for(;;)
	{
		self waittill("damage",var_01,var_02);
		if(isdefined(var_02) && isai(var_02))
		{
			self notify(param_00,-1);
		}
	}
}

//Function Number: 16
sur_ch_stagger(param_00)
{
	self endon("death");
	self endon("challenge_reset");
	thread sur_ch_generic(param_00);
	waittillframeend;
	thread generic_kill_monitor(param_00,6);
	thread stagger_decay(param_00);
}

//Function Number: 17
stagger_decay(param_00)
{
	self endon("death");
	self endon("challenge_reset");
	var_01 = 5;
	var_01 = min(20,var_01);
	var_02 = 1 / var_01;
	for(;;)
	{
		var_03 = 2;
		while(self.selected_ch_array[param_00].progress == 0)
		{
			common_scripts\utility::waittill_any_timeout(var_03,param_00);
		}

		if(level.survival_wave_intermission)
		{
			level waittill("wave_started");
			wait var_03;
		}

		for(var_04 = 0;var_04 < var_01;var_04++)
		{
			wait 1 / var_01;
			var_05 = self.selected_ch_array[param_00].progress;
			self.selected_ch_array[param_00].progress = max(0,var_05 - var_02);
			thread ch_progress_bar_update(param_00);
		}
	}
}

//Function Number: 18
setup_ch_progress_bar(param_00,param_01)
{
	maps\_specialops::surhud_challenge_label(param_00,ch_get_name(param_01));
	thread ch_progress_bar_update(param_01);
}

//Function Number: 19
ch_progress_bar_update(param_00)
{
	var_01 = self.selected_ch_array[param_00].index;
	var_02 = self.selected_ch_array[param_00].progress;
	var_03 = self.selected_ch_array[param_00].completed + 1;
	var_04 = ch_get_requirement(param_00);
	maps\_specialops::surhud_challenge_reward(var_01,ch_get_xp(param_00) * var_03);
	maps\_specialops::surhud_challenge_progress(var_01,int(var_02 / var_04 * 100) / 100);
}

//Function Number: 20
indicate_completion(param_00,param_01)
{
	if(isdefined(self.doingnotify) && self.doingnotify)
	{
		while(self.doingnotify)
		{
			wait 0.05;
		}
	}

	var_02 = spawnstruct();
	var_02.duration = 2.5;
	var_02.sound = "survival_bonus_splash";
	var_02.type = "wave";
	var_02.title_font = "hudbig";
	var_02.playsoundlocally = 1;
	var_02.zoomin = 1;
	var_02.var_3E34 = 1;
	var_02.fadein = 1;
	var_02.fadeout = 1;
	var_02.title_glowcolor = (0.85,0.35,0.15);
	var_02.title_color = (0.95,0.95,0.9);
	var_02.title = ch_get_splash(param_00);
	var_02.title_set_value = param_01;
	if(issplitscreen())
	{
		var_02.title_basefontscale = 1;
	}
	else
	{
		var_02.title_basefontscale = 1.1;
	}

	maps\_so_survival_code::splash_notify_message(var_02);
}

//Function Number: 21
ch_exist(param_00)
{
	return isdefined(level.sur_ch) && isdefined(level.sur_ch[param_00]);
}

//Function Number: 22
ch_get_index_by_ref(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].idx;
	}

	return tablelookup("sp/survival_challenge.csv",1,param_00,0);
}

//Function Number: 23
ch_get_ref_by_index(param_00)
{
	return tablelookup("sp/survival_challenge.csv",0,param_00,1);
}

//Function Number: 24
ch_get_name(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].name;
	}

	return tablelookup("sp/survival_challenge.csv",1,param_00,2);
}

//Function Number: 25
ch_get_desc(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].var_189B;
	}

	return tablelookup("sp/survival_challenge.csv",1,param_00,3);
}

//Function Number: 26
ch_get_splash(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].splash;
	}

	return tablelookupistring("sp/survival_challenge.csv",1,param_00,4);
}

//Function Number: 27
ch_get_icon(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].icon;
	}

	return tablelookup("sp/survival_challenge.csv",1,param_00,5);
}

//Function Number: 28
ch_get_requirement(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].requirement;
	}

	return int(tablelookup("sp/survival_challenge.csv",1,param_00,6));
}

//Function Number: 29
ch_get_xp(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].xp;
	}

	return int(tablelookup("sp/survival_challenge.csv",1,param_00,7));
}

//Function Number: 30
ch_get_repeatable(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].repeatable;
	}

	return int(tablelookup("sp/survival_challenge.csv",1,param_00,8));
}

//Function Number: 31
ch_get_carry(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].carry;
	}

	return int(tablelookup("sp/survival_challenge.csv",1,param_00,9));
}

//Function Number: 32
ch_get_wave_active(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].wave_active;
	}

	return int(tablelookup("sp/survival_challenge.csv",1,param_00,10));
}

//Function Number: 33
ch_get_wave_inactive(param_00)
{
	if(ch_exist(param_00))
	{
		return level.sur_ch[param_00].wave_inactive;
	}

	return int(tablelookup("sp/survival_challenge.csv",1,param_00,11));
}