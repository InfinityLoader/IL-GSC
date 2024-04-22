/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _mark_and_execute.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 296 ms
 * Timestamp: 4/22/2024 2:21:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	precacheshader("dpad_laser_designator");
	precacheitem("rsass_silenced");
}

//Function Number: 2
mark_and_execute_on(param_00)
{
	level.hud_mark = set_temp_hud_text("default",1,&"IRONS_ESTATE_MARK",-398,-52);
	level.hud_execute = set_temp_hud_text("default",1,&"IRONS_ESTATE_EXECUTE",-365,-35);
	level.hud_execute.color = (1,0,0);
	self notifyonplayercommand("mark","+actionslot 3");
	self notifyonplayercommand("execute","+actionslot 2");
	level.executer = param_00;
	thread mark_monitor();
	thread execute_monitor();
	setup_generic_target_acquired_vo();
	setup_generic_no_shot_vo();
	setup_generic_target_down_vo();
	setup_generic_taking_the_shot_vo();
	setup_player_blocking_shot_vo();
}

//Function Number: 3
mark_and_execute_off()
{
	self notify("mark_and_execute_off");
	wait(0.05);
	if(isdefined(level.hud_mark))
	{
		level.hud_mark destroy();
	}

	if(isdefined(level.hud_execute))
	{
		level.hud_execute destroy();
	}
}

//Function Number: 4
set_temp_hud_text(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_hud_util::createfontstring(param_00,param_01);
	var_05 settext(param_02);
	var_05 maps\_hud_util::setpoint("CENTER","BOTTOM",param_03,param_04);
	return var_05;
}

//Function Number: 5
mark_monitor()
{
	self endon("death");
	self endon("mark_and_execute_off");
	level.marked_enemy = undefined;
	for(;;)
	{
		self waittill("mark");
		var_00 = bullettrace(self geteye(),self geteye() + anglestoforward(self getplayerangles()) * 50000,1,self,0,0,0,0,0);
		if(isdefined(var_00["entity"]))
		{
			var_01 = var_00["entity"];
			if(isai(var_01) && isenemyteam(var_01.team,self.team) && isalive(var_01))
			{
				common_scripts\utility::flag_set("marked_enemy");
				attempt_mark_enemy(var_01);
			}
		}

		wait(0.05);
	}
}

//Function Number: 6
attempt_mark_enemy(param_00)
{
	level.player endon("death");
	level.player endon("mark_and_execute_off");
	if(isdefined(level.marked_enemy) && level.marked_enemy == param_00)
	{
		level.marked_enemy unmark_enemy();
		return;
	}

	if(isdefined(level.marked_enemy) && level.marked_enemy != param_00)
	{
		level.marked_enemy unmark_enemy();
		param_00 mark_enemy();
		return;
	}

	if(!isdefined(level.marked_enemy))
	{
		param_00 mark_enemy();
		return;
	}
}

//Function Number: 7
mark_enemy()
{
	self endon("death");
	self endon("mark_and_execute_off");
	self notify("marked");
	level notify("new_enemy_marked");
	thread maps\_tagging::tag_enemy(level.player);
	level.marked_enemy = self;
	thread marked_enemy_death_cleanup();
	thread marked_enemy_marker();
	thread can_shoot_enemy_monitor();
}

//Function Number: 8
unmark_enemy()
{
	self endon("death");
	self endon("mark_and_execute_off");
	self notify("unmarked");
	level.executer.can_shoot_enemy = undefined;
	level.marked_enemy = undefined;
}

//Function Number: 9
execute_monitor()
{
	self endon("death");
	self endon("mark_and_execute_off");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("execute","weapon_fired");
		if(var_00 == "weapon_fired")
		{
			var_01 = bullettrace(self geteye(),self geteye() + anglestoforward(self getplayerangles()) * 50000,1,self,0,0,0,0,0);
			if(isdefined(var_01["entity"]))
			{
				var_02 = var_01["entity"];
				if(isai(var_02) && isenemyteam(var_02.team,self.team))
				{
					attempt_execute();
				}
			}
		}
		else if(var_00 == "execute")
		{
			attempt_execute();
		}

		wait(0.05);
	}
}

//Function Number: 10
attempt_execute()
{
	level.player endon("death");
	level.player endon("mark_and_execute_off");
	level endon("new_enemy_marked");
	level notify("new_execute_attempted");
	level endon("new_execute_attempted");
	if(isdefined(level.marked_enemy) && isalive(level.marked_enemy) && isdefined(level.executer))
	{
		if(isdefined(level.executer.can_shoot_enemy) && level.executer.can_shoot_enemy == 1 && isdefined(level.executer.shoot_tag))
		{
			var_00 = level.marked_enemy;
			level.marked_enemy.health = 1;
			magicbullet("rsass_silenced",level.executer.origin,var_00 gettagorigin(level.executer.shoot_tag));
			wait(0.1);
			if(isdefined(var_00) && isalive(var_00))
			{
				var_00 kill(level.executer.origin);
			}

			wait(0.1);
			var_01 = common_scripts\utility::random(level.generic_target_down_vo_lines);
			thread mark_and_execute_vo_controller(var_01);
			return;
		}

		if(isdefined(level.player_blocking_shot) && level.player_blocking_shot == 1)
		{
			var_01 = common_scripts\utility::random(level.player_blocking_shot_vo_lines);
			thread mark_and_execute_vo_controller(var_01);
			return;
		}

		var_01 = common_scripts\utility::random(level.generic_no_shot_vo_lines);
		thread mark_and_execute_vo_controller(var_01);
		return;
	}
}

//Function Number: 11
can_shoot_enemy_monitor()
{
	self endon("death");
	self endon("unmarked");
	level.player endon("death");
	level.player endon("mark_and_execute_off");
	var_00 = common_scripts\utility::random(level.generic_target_acquired_vo_lines);
	thread mark_and_execute_vo_controller(var_00);
	for(;;)
	{
		if(isdefined(level.marked_enemy) && isalive(level.marked_enemy))
		{
			var_01 = bullettrace(level.executer.origin,level.marked_enemy gettagorigin("j_head"),1,level.executer,0,1,1,0,0);
			if(isdefined(var_01["entity"]) && var_01["entity"] == level.marked_enemy)
			{
				level.hud_execute.color = (0,1,0);
				level.executer.can_shoot_enemy = 1;
				level.executer.shoot_tag = "j_head";
				level.player_blocking_shot = 0;
			}
			else if(isdefined(var_01["entity"]) && var_01["entity"] == level.player)
			{
				level.player_blocking_shot = 1;
				level.hud_execute.color = (1,0,0);
				level.executer.can_shoot_enemy = undefined;
				level.executer.shoot_tag = undefined;
			}
			else
			{
				var_01 = bullettrace(level.executer.origin,level.marked_enemy gettagorigin("j_SpineUpper"),1,level.executer,0,1,1,0,0);
				if(isdefined(var_01["entity"]) && var_01["entity"] == level.marked_enemy)
				{
					level.hud_execute.color = (0,1,0);
					level.executer.can_shoot_enemy = 1;
					level.executer.shoot_tag = "j_SpineUpper";
					level.player_blocking_shot = 0;
				}
				else if(isdefined(var_01["entity"]) && var_01["entity"] == level.player)
				{
					level.player_blocking_shot = 1;
					level.hud_execute.color = (1,0,0);
					level.executer.can_shoot_enemy = undefined;
					level.executer.shoot_tag = undefined;
				}
				else
				{
					var_01 = bullettrace(level.executer.origin,level.marked_enemy gettagorigin("J_SpineLower"),1,level.executer,0,1,1,0,0);
					if(isdefined(var_01["entity"]) && var_01["entity"] == level.marked_enemy)
					{
						level.hud_execute.color = (0,1,0);
						level.executer.can_shoot_enemy = 1;
						level.executer.shoot_tag = "J_SpineLower";
						level.player_blocking_shot = 0;
					}
					else if(isdefined(var_01["entity"]) && var_01["entity"] == level.player)
					{
						level.player_blocking_shot = 1;
						level.hud_execute.color = (1,0,0);
						level.executer.can_shoot_enemy = undefined;
						level.executer.shoot_tag = undefined;
					}
					else
					{
						level.hud_execute.color = (1,0,0);
						level.executer.can_shoot_enemy = undefined;
						level.executer.shoot_tag = undefined;
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
marked_enemy_death_cleanup()
{
	level.player endon("death");
	level.player endon("mark_and_execute_off");
	self endon("unmarked");
	self waittill("death");
	level.hud_execute.color = (1,0,0);
	level.executer.can_shoot_enemy = undefined;
	level.executer.shoot_tag = undefined;
}

//Function Number: 13
marked_enemy_marker()
{
	level.player endon("death");
	level.player endon("mark_and_execute_off");
	self endon("unmarked");
	self endon("death");
	while(isdefined(self) && isalive(self))
	{
		var_00 = distance(level.player.origin,self.origin);
		var_01 = 1500;
		var_02 = 0;
		var_03 = 0.25;
		var_04 = 3;
		var_05 = var_01 - var_02;
		var_00 = clamp(var_00 - var_02,0,var_05);
		var_06 = var_03 + var_00 / var_05 * var_04 - var_03;
		wait(0.05);
	}
}

//Function Number: 14
setup_generic_target_acquired_vo()
{
	level.generic_target_acquired_vo_lines = [];
	level.generic_target_acquired_vo_lines[0] = spawnstruct();
	level.generic_target_acquired_vo_lines[0].vo = "ie_iln_targetacquired";
	level.generic_target_acquired_vo_lines[0].vo_priority = 1;
	level.generic_target_acquired_vo_lines[1] = spawnstruct();
	level.generic_target_acquired_vo_lines[1].vo = "ie_iln_gothim";
	level.generic_target_acquired_vo_lines[1].vo_priority = 1;
	level.generic_target_acquired_vo_lines[2] = spawnstruct();
	level.generic_target_acquired_vo_lines[2].vo = "ie_iln_trackingtarget";
	level.generic_target_acquired_vo_lines[2].vo_priority = 1;
	level.generic_target_acquired_vo_lines[3] = spawnstruct();
	level.generic_target_acquired_vo_lines[3].vo = "ie_iln_watchyingtarget";
	level.generic_target_acquired_vo_lines[3].vo_priority = 1;
}

//Function Number: 15
setup_generic_no_shot_vo()
{
	level.generic_no_shot_vo_lines = [];
	level.generic_no_shot_vo_lines[0] = spawnstruct();
	level.generic_no_shot_vo_lines[0].vo = "ie_iln_noshot";
	level.generic_no_shot_vo_lines[0].vo_priority = 2;
	level.generic_no_shot_vo_lines[1] = spawnstruct();
	level.generic_no_shot_vo_lines[1].vo = "ie_iln_idonthaveashot";
	level.generic_no_shot_vo_lines[1].vo_priority = 2;
	level.generic_no_shot_vo_lines[2] = spawnstruct();
	level.generic_no_shot_vo_lines[2].vo = "ie_iln_donthaveashot";
	level.generic_no_shot_vo_lines[2].vo_priority = 2;
	level.generic_no_shot_vo_lines[3] = spawnstruct();
	level.generic_no_shot_vo_lines[3].vo = "ie_iln_donthavehim";
	level.generic_no_shot_vo_lines[3].vo_priority = 2;
	level.generic_no_shot_vo_lines[4] = spawnstruct();
	level.generic_no_shot_vo_lines[4].vo = "ie_iln_targetobstructed";
	level.generic_no_shot_vo_lines[4].vo_priority = 2;
	level.generic_no_shot_vo_lines[5] = spawnstruct();
	level.generic_no_shot_vo_lines[5].vo = "ie_iln_noclearshot";
	level.generic_no_shot_vo_lines[5].vo_priority = 2;
	level.generic_no_shot_vo_lines[6] = spawnstruct();
	level.generic_no_shot_vo_lines[6].vo = "ie_iln_outofsight";
	level.generic_no_shot_vo_lines[6].vo_priority = 2;
	level.generic_no_shot_vo_lines[7] = spawnstruct();
	level.generic_no_shot_vo_lines[7].vo = "ie_iln_outofview";
	level.generic_no_shot_vo_lines[7].vo_priority = 2;
}

//Function Number: 16
setup_player_blocking_shot_vo()
{
	level.player_blocking_shot_vo_lines = [];
	level.player_blocking_shot_vo_lines[0] = spawnstruct();
	level.player_blocking_shot_vo_lines[0].vo = "ie_iln_mitchellblockingmyshot";
	level.player_blocking_shot_vo_lines[0].vo_priority = 0;
	level.player_blocking_shot_vo_lines[1] = spawnstruct();
	level.player_blocking_shot_vo_lines[1].vo = "ie_iln_blockingmyshot";
	level.player_blocking_shot_vo_lines[1].vo_priority = 0;
	level.player_blocking_shot_vo_lines[2] = spawnstruct();
	level.player_blocking_shot_vo_lines[2].vo = "ie_iln_moveoutoftheway";
	level.player_blocking_shot_vo_lines[2].vo_priority = 0;
	level.player_blocking_shot_vo_lines[3] = spawnstruct();
	level.player_blocking_shot_vo_lines[3].vo = "ie_iln_getoutoftheway";
	level.player_blocking_shot_vo_lines[3].vo_priority = 0;
}

//Function Number: 17
setup_generic_target_down_vo()
{
	level.generic_target_down_vo_lines = [];
	level.generic_target_down_vo_lines[0] = spawnstruct();
	level.generic_target_down_vo_lines[0].vo = "ie_iln_targetsdown";
	level.generic_target_down_vo_lines[0].vo_priority = 2;
	level.generic_target_down_vo_lines[1] = spawnstruct();
	level.generic_target_down_vo_lines[1].vo = "ie_iln_hesdown";
	level.generic_target_down_vo_lines[1].vo_priority = 2;
	level.generic_target_down_vo_lines[2] = spawnstruct();
	level.generic_target_down_vo_lines[2].vo = "ie_iln_igothim";
	level.generic_target_down_vo_lines[2].vo_priority = 2;
	level.generic_target_down_vo_lines[3] = spawnstruct();
	level.generic_target_down_vo_lines[3].vo = "ie_iln_targetneutralized";
	level.generic_target_down_vo_lines[3].vo_priority = 2;
}

//Function Number: 18
setup_generic_taking_the_shot_vo()
{
	level.generic_taking_the_shot_vo_lines = [];
	level.generic_taking_the_shot_vo_lines[0] = spawnstruct();
	level.generic_taking_the_shot_vo_lines[0].vo = "ie_iln_takingshot";
	level.generic_taking_the_shot_vo_lines[0].vo_priority = 0;
}

//Function Number: 19
mark_and_execute_vo_controller(param_00)
{
	level.player endon("death");
	level.player endon("mark_and_execute_off");
	level endon("meet_cormack_end");
	if(isdefined(level.play_ilana_vo) && level.play_ilana_vo == 1)
	{
		if(isdefined(level.current_vo) && isdefined(param_00.vo_priority) && param_00.vo_priority > level.current_vo.vo_priority)
		{
			level.ilana_vo_org stopsounds();
			wait(0.05);
			level.current_vo = param_00;
			level.ilana_vo_org playsound(param_00.vo,"sounddone",1);
			level.ilana_vo_org waittill("sounddone");
			wait(0.5);
			level.current_vo = undefined;
			return;
		}

		if(!isdefined(level.current_vo))
		{
			level.current_vo = param_00;
			level.ilana_vo_org playsound(param_00.vo,"sounddone",1);
			level.ilana_vo_org waittill("sounddone");
			wait(0.5);
			level.current_vo = undefined;
			return;
		}
	}
}