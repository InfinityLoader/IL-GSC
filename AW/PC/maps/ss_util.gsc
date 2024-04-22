/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ss_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 417 ms
 * Timestamp: 4/22/2024 2:37:16 AM
*******************************************************************/

//Function Number: 1
fake_death_over_time(param_00,param_01,param_02)
{
	self endon("death");
	wait(randomintrange(param_01,param_02));
	if(isdefined(self) && isai(self) && isalive(self))
	{
		if(param_00 == "bullet")
		{
			fake_death_bullet();
			return;
		}

		fake_death_bullet();
	}
}

//Function Number: 2
fake_death_bullet(param_00)
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

	var_01 = [];
	var_01[0] = "j_hip_le";
	var_01[1] = "j_hip_ri";
	var_01[2] = "j_head";
	var_01[3] = "j_spine4";
	var_01[4] = "j_elbow_le";
	var_01[5] = "j_elbow_ri";
	var_01[6] = "j_clavicle_le";
	var_01[7] = "j_clavicle_ri";
	for(var_02 = 0;var_02 < 3 + randomint(5);var_02++)
	{
		var_03 = randomintrange(0,var_01.size);
		thread fake_death_bullet_fx(var_01[var_03],undefined);
		wait(randomfloat(0.1));
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 3
fake_death_bullet_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 4
array_setgoalvolume(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	wait(0.05);
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04) && isai(var_04))
		{
			var_04 cleargoalvolume();
			var_04 setgoalvolumeauto(var_02);
		}
	}
}

//Function Number: 5
radio_dialogue_queue_single(param_00)
{
	maps\_shg_utility::conversation_start();
	maps\_utility::radio_dialogue(param_00);
	maps\_shg_utility::conversation_stop();
}

//Function Number: 6
dialogue_queue_single(param_00)
{
	maps\_shg_utility::conversation_start();
	maps\_utility::dialogue_queue(param_00);
	maps\_shg_utility::conversation_stop();
}

//Function Number: 7
dialogue_random_line(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = [];
	if(isdefined(param_00))
	{
		var_08[var_08.size] = param_00;
	}

	if(isdefined(param_01))
	{
		var_08[var_08.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_08[var_08.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_08[var_08.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_08[var_08.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_08[var_08.size] = param_05;
	}

	if(isdefined(param_06))
	{
		var_08[var_08.size] = param_06;
	}

	if(isdefined(param_07))
	{
		var_08[var_08.size] = param_07;
	}

	if(!isdefined(level.dialogue_random_last_line))
	{
		level.dialogue_random_last_line = undefined;
	}

	var_09 = 0;
	while(!var_09)
	{
		var_0A = common_scripts\utility::random(var_08);
		if(isdefined(level.dialogue_random_last_line) && level.dialogue_random_last_line == var_0A)
		{
			continue;
		}
		else
		{
			if(isdefined(self) && isai(self))
			{
				dialogue_queue_single(var_0A);
			}
			else
			{
				radio_dialogue_queue_single(var_0A);
			}

			level.dialogue_random_last_line = var_0A;
			var_09 = 1;
		}

		wait(0.05);
	}

	var_09 = 0;
}

//Function Number: 8
hint_neverbreak()
{
	return 0;
}

//Function Number: 9
setup_ignore_suppression_triggers()
{
	var_00 = getentarray("trigger_ignore_suppression","targetname");
	foreach(var_02 in var_00)
	{
		level thread ignore_suppression_trigger_think(var_02);
	}
}

//Function Number: 10
ignore_suppression_trigger_think(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01) && isai(var_01) && !var_01 isbadguy())
		{
			var_01 thread ignore_suppression_trigger_ai_think(param_00);
		}
	}
}

//Function Number: 11
ignore_suppression_trigger_ai_think(param_00)
{
	self notify("ignore_suppression_trigger_ai_think_stop");
	self endon("ignore_suppression_trigger_ai_think_stop");
	self endon("death");
	maps\_utility::set_ignoresuppression(1);
	while(self istouching(param_00))
	{
		wait(0.5);
	}

	maps\_utility::set_ignoresuppression(0);
}

//Function Number: 12
add_hint_background(param_00)
{
	if(isdefined(param_00))
	{
		level.hintbackground = maps\_hud_util::createicon("popmenu_bg",650,50);
	}
	else
	{
		level.hintbackground = maps\_hud_util::createicon("popmenu_bg",650,30);
	}

	level.hintbackground.hidewheninmenu = 1;
	level.hintbackground maps\_hud_util::setpoint("TOP",undefined,0,110);
	level.hintbackground.alpha = 0.5;
	level.hintbackground.sort = 0;
}

//Function Number: 13
clear_hints()
{
	if(isdefined(level.hintelem))
	{
		level.hintelem maps\_hud_util::destroyelem();
	}

	if(isdefined(level.iconelem))
	{
		level.iconelem maps\_hud_util::destroyelem();
	}

	if(isdefined(level.iconelem2))
	{
		level.iconelem2 maps\_hud_util::destroyelem();
	}

	if(isdefined(level.iconelem3))
	{
		level.iconelem3 maps\_hud_util::destroyelem();
	}

	if(isdefined(level.hintbackground))
	{
		level.hintbackground maps\_hud_util::destroyelem();
	}

	level notify("clearing_hints");
}

//Function Number: 14
hint_with_background(param_00,param_01,param_02)
{
	clear_hints();
	level endon("clearing_hints");
	add_hint_background(param_02);
	level.hintelem = maps\_hud_util::createfontstring("default",2);
	level.hintelem.hidewheninmenu = 1;
	level.hintelem maps\_hud_util::setpoint("TOP",undefined,0,110);
	level.hintelem.sort = 0.5;
	level.high_priority_hint = 1;
	level.hintelem settext(param_00);
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		return;
	}

	level.high_priority_hint = undefined;
	level.hintelem fadeovertime(0.5);
	level.hintelem.alpha = 0;
	wait(0.5);
	clear_hints();
}

//Function Number: 15
dog_monitor_goal_ent(param_00,param_01)
{
	level endon("special_op_terminated");
	self endon("death");
	var_02 = 30;
	var_03 = self.meleeattackdist + var_02;
	for(;;)
	{
		wait(0.05);
		if(dog_enemy_laststand_check())
		{
			continue;
		}

		if(isdefined(self.enemy) && self.movemode == "stop")
		{
			if(get_next_allow_melee_time(self) > gettime())
			{
				continue;
			}

			self setgoalentity(param_01);
			maps\_utility::set_ignoreall(1);
			continue;
		}

		if(isdefined(self.ignoreall) && self.ignoreall)
		{
			var_04 = getnodesinradiussorted(self.favoriteenemy.origin,16,0,64,"Path");
			if(isdefined(var_04) && var_04.size > 0)
			{
				self setgoalentity(self.favoriteenemy);
				maps\_utility::set_ignoreall(0);
				continue;
			}

			if(maps\_utility::is_coop() && distance2d(self.origin,param_01.origin) < 125)
			{
				var_05 = get_different_favoriteenemy();
				if(var_05 so_can_player_see_dog(self))
				{
					dog_swap_enemy();
					maps\_utility::set_ignoreall(0);
				}
			}
		}
	}
}

//Function Number: 16
so_can_player_see_dog(param_00)
{
	var_01 = self geteye();
	var_02 = param_00 geteye();
	if(sighttracepassed(var_01,var_02,1,self,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
get_next_allow_melee_time(param_00)
{
	var_01 = 0;
	if(isdefined(self.enemy.dogattackallowtime))
	{
		var_01 = self.enemy.dogattackallowtime + 2500;
	}

	return var_01;
}

//Function Number: 18
dog_enemy_laststand_check()
{
	if(!maps\_utility::is_coop())
	{
		return 0;
	}

	if(isdefined(self.favoriteenemy.laststand) && self.favoriteenemy.laststand)
	{
		dog_swap_enemy();
		return 1;
	}

	return 0;
}

//Function Number: 19
dog_swap_enemy()
{
	if(!maps\_utility::is_coop())
	{
		return;
	}

	var_00 = get_different_favoriteenemy();
	self setgoalentity(var_00);
	maps\_utility::set_favoriteenemy(var_00);
}

//Function Number: 20
get_different_favoriteenemy()
{
	var_00 = self.favoriteenemy != level.player2;
	return level.players[var_00];
}

//Function Number: 21
ai_wave_spawn(param_00,param_01)
{
	param_00 = getentarray(param_00,"targetname");
	var_02 = [];
	if(!isdefined(param_01))
	{
		param_01 = param_00.size;
	}

	param_00 = common_scripts\utility::array_randomize(param_00);
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_04 = param_00[var_03] maps\_utility::spawn_ai(1);
		var_02[var_02.size] = var_04;
		wait(0.1);
		param_00[var_03].count = 1;
	}

	return var_02;
}

//Function Number: 22
ai_wave_setgoalvolume(param_00,param_01)
{
	param_01 = getent(param_01,"targetname");
	wait(0.05);
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03) && isalive(var_03) && isai(var_03))
		{
			var_03 cleargoalvolume();
			var_03 setgoalvolumeauto(param_01);
		}
	}
}

//Function Number: 23
ai_wave_monitor_threshold(param_00,param_01,param_02)
{
	level endon(param_02);
	for(;;)
	{
		param_00 = maps\_utility::array_removedead(param_00);
		if(param_00.size <= param_01)
		{
			if(isdefined(param_02))
			{
				level notify(param_02);
			}
		}

		wait(0.1);
	}
}

//Function Number: 24
ai_wave_monitor_retreat(param_00,param_01,param_02)
{
	level waittill(param_01);
	array_setgoalvolume(param_00,param_02);
}

//Function Number: 25
ai_wave_spawn_volume_threshold_retreat(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = ai_wave_spawn(param_00,param_01);
	ai_wave_setgoalvolume(var_06,param_02);
	ai_wave_monitor_threshold(var_06,param_03,param_04);
	ai_wave_monitor_retreat(var_06,param_04,param_05);
	return var_06;
}

//Function Number: 26
ai_wave_spawn_volume_threshold(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = ai_wave_spawn(param_00,param_01);
	ai_wave_setgoalvolume(var_06,param_02);
	ai_wave_monitor_threshold(var_06,param_03,param_04);
	ai_wave_monitor_retreat(var_06,param_04,param_05);
	return var_06;
}

//Function Number: 27
ai_wave_spawn_volume(param_00,param_01,param_02)
{
	var_03 = ai_wave_spawn(param_00,param_01);
	ai_wave_setgoalvolume(var_03,param_02);
	return var_03;
}