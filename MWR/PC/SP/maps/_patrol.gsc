/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_patrol.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 342 ms
 * Timestamp: 10/27/2023 2:48:26 AM
*******************************************************************/

//Function Number: 1
patrol(param_00,param_01,param_02)
{
	if(isdefined(self.enemy))
	{
		return;
	}

	self endon("death");
	self endon("end_patrol");
	level endon("_stealth_spotted");
	level endon("_stealth_found_corpse");
	thread waittill_combat();
	thread waittill_death();
	self endon("enemy");
	self.goalradius = 32;
	self allowedstances("stand");
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.allowdeath = 1;
	self.script_patroller = 1;
	var_03 = "patrol_walk";
	if(isdefined(self.patrol_walk_anim))
	{
		var_03 = self.patrol_walk_anim;
	}

	var_04 = isdefined(self.canpatrolturn) && self.canpatrolturn;
	maps\_utility::set_generic_run_anim(var_03,1,!var_04);
	thread patrol_walk_twitch_loop();
	var_05[1][1] = ::get_target_ents;
	var_05[1][0] = ::common_scripts\utility::get_linked_ents;
	var_05[0][1] = ::get_target_nodes;
	var_05[0][0] = ::get_linked_nodes;
	var_06[1] = ::maps\_utility::set_goal_ent;
	var_06[0] = ::maps\_utility::set_goal_node;
	if(isdefined(param_00))
	{
		self.target = param_00;
	}

	if(isdefined(self.target))
	{
		var_07 = 1;
		var_08 = get_target_ents();
		var_09 = get_target_nodes();
		if(var_08.size)
		{
			var_0A = common_scripts\utility::random(var_08);
			var_0B = 1;
		}
		else
		{
			var_0A = common_scripts\utility::random(var_0B);
			var_0B = 0;
		}
	}
	else
	{
		var_07 = 0;
		var_08 = common_scripts\utility::get_linked_ents();
		var_09 = get_linked_nodes();
		if(var_0A.size)
		{
			var_0A = common_scripts\utility::random(var_0A);
			var_0B = 1;
		}
		else
		{
			var_0A = common_scripts\utility::random(var_0B);
			var_0B = 0;
		}
	}

	var_0C = var_0A;
	while(isdefined(var_0C.patrol_claimed))
	{
		wait(0.05);
	}

	var_0A.patrol_claimed = undefined;
	var_0A = var_0C;
	self notify("release_node");
	var_0A.patrol_claimed = 1;
	self.last_patrol_goal = var_0A;
	[[ var_06[var_0B] ]](var_0A);
	if(isdefined(var_0A.radius) && var_0A.radius > 0)
	{
		self.goalradius = var_0A.radius;
	}
	else
	{
		self.goalradius = 32;
	}

	self waittill("goal");
	var_0A notify("trigger",self);
	if(isdefined(var_0A.script_animation))
	{
		if(!isdefined(param_02) || param_02 == 0)
		{
			var_0D = "patrol_stop";
			maps\_anim::anim_generic_custom_animmode(self,"gravity",var_0D);
		}

		switch(var_0A.script_animation)
		{
			case "pause":
				break;

			case "turn180":
				break;

			case "smoke":
				break;

			case "stretch":
				break;

			case "checkphone":
				break;

			case "phone":
				break;
		}
	}
}

//Function Number: 2
add_to_patrol_animation_list(param_00,param_01)
{
	if(isdefined(param_01))
	{
		level.patrol_anims[param_00] = param_01;
	}
}

//Function Number: 3
init_patrol_animation_list()
{
	add_to_patrol_animation_list("patrol_walk",level.scr_anim["generic"]["patrol_walk"]);
	add_to_patrol_animation_list("patrol_walk_twitch",level.scr_anim["generic"]["patrol_walk_twitch"]);
	add_to_patrol_animation_list("patrol_stop",level.scr_anim["generic"]["patrol_stop"]);
	add_to_patrol_animation_list("patrol_start",level.scr_anim["generic"]["patrol_start"]);
	add_to_patrol_animation_list("patrol_turn180",level.scr_anim["generic"]["patrol_turn180"]);
	add_to_patrol_animation_list("patrol_idle_1",level.scr_anim["generic"]["patrol_idle_1"]);
	add_to_patrol_animation_list("patrol_idle_2",level.scr_anim["generic"]["patrol_idle_2"]);
	add_to_patrol_animation_list("patrol_idle_3",level.scr_anim["generic"]["patrol_idle_3"]);
	add_to_patrol_animation_list("patrol_idle_4",level.scr_anim["generic"]["patrol_idle_4"]);
	add_to_patrol_animation_list("patrol_idle_5",level.scr_anim["generic"]["patrol_idle_5"]);
	add_to_patrol_animation_list("patrol_idle_6",level.scr_anim["generic"]["patrol_idle_6"]);
	add_to_patrol_animation_list("patrol_idle_smoke",level.scr_anim["generic"]["patrol_idle_smoke"]);
	add_to_patrol_animation_list("patrol_idle_checkphone",level.scr_anim["generic"]["patrol_idle_checkphone"]);
	add_to_patrol_animation_list("patrol_idle_stretch",level.scr_anim["generic"]["patrol_idle_stretch"]);
	add_to_patrol_animation_list("patrol_idle_phone",level.scr_anim["generic"]["patrol_idle_phone"]);
	add_to_patrol_animation_list("patrol_turn_l45_rfoot",level.scr_anim["generic"]["patrol_turn_l45_rfoot"]);
	add_to_patrol_animation_list("patrol_turn_l45_lfoot",level.scr_anim["generic"]["patrol_turn_l45_lfoot"]);
	add_to_patrol_animation_list("patrol_turn_l90_rfoot",level.scr_anim["generic"]["patrol_turn_l90_rfoot"]);
	add_to_patrol_animation_list("patrol_turn_l90_lfoot",level.scr_anim["generic"]["patrol_turn_l90_lfoot"]);
	add_to_patrol_animation_list("patrol_turn_l135_rfoot",level.scr_anim["generic"]["patrol_turn_l135_rfoot"]);
	add_to_patrol_animation_list("patrol_turn_l135_lfoot",level.scr_anim["generic"]["patrol_turn_l135_lfoot"]);
	add_to_patrol_animation_list("patrol_turn_r45_rfoot",level.scr_anim["generic"]["patrol_turn_r45_rfoot"]);
	add_to_patrol_animation_list("patrol_turn_r45_lfoot",level.scr_anim["generic"]["patrol_turn_r45_lfoot"]);
	add_to_patrol_animation_list("patrol_turn_r90_rfoot",level.scr_anim["generic"]["patrol_turn_r90_rfoot"]);
	add_to_patrol_animation_list("patrol_turn_r90_lfoot",level.scr_anim["generic"]["patrol_turn_r90_lfoot"]);
	add_to_patrol_animation_list("patrol_turn_r135_rfoot",level.scr_anim["generic"]["patrol_turn_r135_rfoot"]);
	add_to_patrol_animation_list("patrol_turn_r135_lfoot",level.scr_anim["generic"]["patrol_turn_r135_lfoot"]);
	add_to_patrol_animation_list("patrol_walk_in_lfoot",level.scr_anim["generic"]["patrol_walk_in_lfoot"]);
	add_to_patrol_animation_list("patrol_walk_out_lfoot",level.scr_anim["generic"]["patrol_walk_out_lfoot"]);
	add_to_patrol_animation_list("patrol_walk_in_rfoot",level.scr_anim["generic"]["patrol_walk_in_rfoot"]);
	add_to_patrol_animation_list("patrol_walk_out_rfoot",level.scr_anim["generic"]["patrol_walk_out_rfoot"]);
}

//Function Number: 4
is_patrolling()
{
	foreach(var_01 in level.patrol_anims)
	{
		if(isdefined(var_01) && self getanimweight(var_01) != 0)
		{
			self.usepathsmoothingvalues = 1;
			self.pathlookaheaddist = 70;
			self.maxturnspeed = 19;
			self.sharpturn = 0.94;
			return 1;
		}
	}

	self.usepathsmoothingvalues = 0;
	return 0;
}

//Function Number: 5
enable_patrol_turn()
{
	self.canpatrolturn = 1;
}

//Function Number: 6
disable_patrol_turn()
{
	self.canpatrolturn = undefined;
}

//Function Number: 7
can_smoke()
{
	if(!isdefined(self.headmodel))
	{
		return 0;
	}

	switch(self.headmodel)
	{
		case "head_spetsnaz_assault_demetry_lob":
		case "head_spetsnaz_assault_demetry":
		case "head_sp_opforce_gas_mask_body_f":
		case "head_sp_opforce_fullwrap_body_d":
		case "head_sp_opforce_ski_mask_body_a":
			break;
	}
}

//Function Number: 8
patrol_walk_twitch_loop()
{
	self endon("death");
	self endon("enemy");
	self endon("end_patrol");
	level endon("_stealth_spotted");
	level endon("_stealth_found_corpse");
	self notify("patrol_walk_twitch_loop");
	self endon("patrol_walk_twitch_loop");
	if(isdefined(self.patrol_walk_anim) && !isdefined(self.patrol_walk_twitch))
	{
		return;
	}

	for(;;)
	{
		wait(randomfloatrange(8,20));
		var_00 = "patrol_walk_twitch";
		if(isdefined(self.patrol_walk_twitch))
		{
			var_00 = self.patrol_walk_twitch;
		}

		var_01 = isdefined(self.canpatrolturn) && self.canpatrolturn;
		maps\_utility::set_generic_run_anim(var_00,1,!var_01);
		var_02 = getanimlength(maps\_utility::getanim_generic(var_00));
		wait(var_02);
		var_00 = "patrol_walk";
		if(isdefined(self.patrol_walk_anim))
		{
			var_00 = self.patrol_walk_anim;
		}

		maps\_utility::set_generic_run_anim(var_00,1,!var_01);
	}
}

//Function Number: 9
waittill_combat_wait()
{
	self endon("end_patrol");
	level endon("_stealth_spotted");
	level endon("_stealth_found_corpse");
	self waittill("enemy");
}

//Function Number: 10
waittill_death()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self notify("release_node");
	if(!isdefined(self.last_patrol_goal))
	{
		return;
	}

	self.last_patrol_goal.patrol_claimed = undefined;
}

//Function Number: 11
waittill_combat()
{
	self endon("death");
	waittill_combat_wait();
	if(!isdefined(self._stealth))
	{
		maps\_utility::clear_run_anim();
		self allowedstances("stand","crouch","prone");
		self.disablearrivals = 0;
		self.disableexits = 0;
		self stopanimscripted();
		self notify("stop_animmode");
	}

	self.allowdeath = 0;
	if(!isdefined(self))
	{
		return;
	}

	self notify("release_node");
	if(!isdefined(self.last_patrol_goal))
	{
		return;
	}

	self.last_patrol_goal.patrol_claimed = undefined;
}

//Function Number: 12
get_target_ents()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 13
get_target_nodes()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = getnodearray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 14
get_linked_nodes()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = strtok(self.script_linkto," ");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = getnode(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 15
showclaimed(param_00)
{
	self endon("release_node");
}

//Function Number: 16
patrol_resume_move_start_func()
{
}

//Function Number: 17
pet_patrol()
{
}