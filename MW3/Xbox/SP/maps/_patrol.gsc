/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_patrol.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 23
 * Decompile Time: 412 ms
 * Timestamp: 10/27/2023 2:35:41 AM
*******************************************************************/

//Function Number: 1
patrol(param_00)
{
	if(isdefined(self.enemy))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("damage");
	self endon("end_patrol");
	waittillframeend;
	if(isdefined(self.var_1BD1))
	{
		[[ level.global_callbacks["_patrol_endon_spotted_flag"] ]]();
	}

	thread waittill_combat();
	thread func_1BEF();
	self.goalradius = 32;
	self allowedstances("stand");
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.allowdeath = 1;
	self.script_patroller = 1;
	maps\_utility::disable_cqbwalk();
	func_1BF6();
	set_patrol_run_anim_array();
	var_01["ent"][1] = ::get_target_ents;
	var_29["ent"] = 0;
	var_29["node"] = 1;
	var_29["node"] = 0;
	var_29["struct"] = 1;
	var_29["struct"] = 0;
	param_00["ent"] = ::maps\_utility::set_goal_ent;
	if(isdefined(var_01))
	{
		self.target = var_01;
	}

	if(isdefined(self.target))
	{
		var_03 = 1;
		var_04 = get_target_ents();
		var_05 = get_target_nodes();
		var_06 = func_0FD7();
		if(var_04.size)
		{
			var_07 = common_scripts\utility::random(var_04);
			var_08 = "ent";
		}
		else if(var_07.size)
		{
			var_07 = common_scripts\utility::random(var_07);
			var_08 = "node";
		}
		else
		{
			var_07 = common_scripts\utility::random(var_08);
			var_08 = "struct";
		}
	}
	else
	{
		var_03 = 0;
		var_04 = common_scripts\utility::get_linked_ents();
		var_05 = func_1BF4();
		var_06 = maps\_utility::get_linked_structs();
		if(var_06.size)
		{
			var_07 = common_scripts\utility::random(var_06);
			var_08 = "ent";
		}
		else if(var_07.size)
		{
			var_07 = common_scripts\utility::random(var_07);
			var_08 = "node";
		}
		else
		{
			var_07 = common_scripts\utility::random(var_08);
			var_08 = "struct";
		}
	}

	var_09 = [];
	var_0A = var_07;
	for(;;)
	{
		while(isdefined(var_0A.var_1BD7))
		{
			wait 0.05;
		}

		var_07.var_1BD7 = undefined;
		var_07 = var_0A;
		self notify("release_node",var_41["phone"],"patrol_idle_phone",var_41["checkphone"],"patrol_idle_checkphone",var_41["stretch"],"patrol_idle_stretch",var_41["smoke"],"patrol_idle_smoke",var_41["turn180"],common_scripts\utility::ter_op(isdefined(self.var_1BD6),self.var_1BD6,"patrol_turn180"),var_41["pause"],"patrol_idle_",var_41["struct"],::maps\_utility::set_goal_ent,var_41["node"],::maps\_utility::set_goal_node,::maps\_utility::get_linked_structs,::func_0FD7,::func_1BF4,::get_target_nodes,::common_scripts\utility::get_linked_ents);
		var_07.var_1BD7 = 1;
		self.var_1BD8 = var_07;
		[[ var_41[var_08] ]](var_07);
		if(isdefined(var_07.radius) && var_07.radius > 0)
		{
			self.goalradius = var_07.radius;
		}
		else
		{
			self.goalradius = 32;
		}

		self waittill("goal");
		var_07 notify("trigger",self);
		if(isdefined(var_07.script_flag_set))
		{
			common_scripts\utility::flag_set(var_07.script_flag_set);
		}

		if(isdefined(var_07.script_ent_flag_set))
		{
			maps\_utility::func_FA4(var_07.script_ent_flag_set);
		}

		if(isdefined(var_07.script_flag_clear))
		{
			common_scripts\utility::flag_clear(var_07.script_flag_clear);
		}

		var_0B = var_07 [[ var_29[var_08][var_03] ]]();
		if(!var_0B.size)
		{
			self notify("reached_path_end");
			self notify("_patrol_reached_path_end");
			if(isalive(self.var_1BDC))
			{
				self.var_1BDC notify("master_reached_patrol_end");
			}
		}

		if(isdefined(var_07.script_flag_wait))
		{
			common_scripts\utility::flag_wait(var_07.script_flag_wait);
		}

		var_07 maps\_utility::script_delay();
		var_0C = ::animscripts/reactions::reactionscheckloop;
		var_0D = var_07.script_animation;
		if(isdefined(var_0D))
		{
			if(!isdefined(self.patrol_no_stop_transition))
			{
				patrol_do_stop_transition_anim(var_0D,var_0C,var_07);
			}

			if(isdefined(var_07.script_faceangles))
			{
				self orientmode("face angle",var_07.angles[1]);
			}

			self.var_1BE0 = 1;
			var_0E = var_09[var_0D];
			if(isdefined(var_0E))
			{
				if(var_0D == "pause")
				{
					if(isdefined(self.patrol_scriptedanim) && isdefined(self.patrol_scriptedanim[var_0D]))
					{
						var_0E = self.patrol_scriptedanim[var_0D][randomint(self.patrol_scriptedanim[var_0D].size)];
					}
					else
					{
						var_0E = var_0E + randomintrange(1,6);
					}
				}

				maps\_anim::anim_generic_custom_animmode(self,"gravity",var_0E,undefined,var_0C);
				if(var_0B.size && var_0D != "turn180")
				{
					patrol_do_start_transition_anim(var_0D,var_0C);
				}
			}

			self.var_1BE0 = undefined;
		}

		if(!var_0B.size)
		{
			if(isdefined(self.patrol_end_idle) && !isdefined(var_0D))
			{
				patrol_do_stop_transition_anim("path_end_idle",var_0C,var_07);
				for(;;)
				{
					var_0F = self.patrol_end_idle[randomint(self.patrol_end_idle.size)];
					maps\_anim::anim_generic_custom_animmode(self,"gravity",var_0F,undefined,var_0C);
				}
			}

			break;
		}

		var_0A = common_scripts\utility::random(var_0B);
	}
}

//Function Number: 2
patrol_do_stop_transition_anim(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = 0;
	if(isdefined(param_02.script_faceangles))
	{
		var_03 = param_02;
		self.noteleport = 1;
		var_04 = 1;
	}

	if(isdefined(self.patrol_stop) && isdefined(self.patrol_stop[param_00]))
	{
		var_03 maps\_anim::anim_generic_custom_animmode(self,"gravity",self.patrol_stop[param_00],undefined,param_01,var_04);
		return;
	}

	var_03 maps\_anim::anim_generic_custom_animmode(self,"gravity","patrol_stop",undefined,param_01,var_04);
}

//Function Number: 3
patrol_do_start_transition_anim(param_00,param_01)
{
	if(isdefined(self.var_1BE6) && isdefined(self.var_1BE6[param_00]))
	{
		maps\_anim::anim_generic_custom_animmode(self,"gravity",self.var_1BE6[param_00],undefined,param_01);
		return;
	}

	maps\_anim::anim_generic_custom_animmode(self,"gravity","patrol_start",undefined,param_01);
}

//Function Number: 4
func_1BE7()
{
	if(self.a.var_911 == "crouch" && isdefined(self.a.array))
	{
		var_00 = self.a.array["stance_change"];
		if(isdefined(var_00))
		{
			self setflaggedanimknoballrestart("stand_up",var_00,%root,1);
			animscripts/shared::donotetracks("stand_up");
		}
	}
}

//Function Number: 5
func_1BE8()
{
	self endon("enemy");
	self animmode("zonly_physics",0);
	self orientmode("face current");
	func_1BE7();
	var_00 = level.scr_anim["generic"]["patrol_radio_in_clear"];
	self setflaggedanimknoballrestart("radio",var_00,%root,1);
	animscripts/shared::donotetracks("radio");
	turn_180_move_start_func();
}

//Function Number: 6
turn_180_move_start_func()
{
	if(!isdefined(self.pathgoalpos))
	{
		return;
	}

	var_00 = self.pathgoalpos;
	var_01 = var_00 - self.origin;
	var_01 = (var_01[0],var_01[1],0);
	var_02 = lengthsquared(var_01);
	if(var_02 < 1)
	{
		return;
	}

	var_01 = var_01 / sqrt(var_02);
	var_03 = anglestoforward(self.angles);
	if(vectordot(var_03,var_01) < -0.5)
	{
		self animmode("zonly_physics",0);
		self orientmode("face current");
		func_1BE7();
		var_04 = level.scr_anim["generic"]["patrol_turn180"];
		self setflaggedanimknoballrestart("move",var_04,%root,1);
		if(animhasnotetrack(var_04,"code_move"))
		{
			animscripts/shared::donotetracks("move");
			self orientmode("face motion");
			self animmode("none",0);
		}

		animscripts/shared::donotetracks("move");
	}
}

//Function Number: 7
set_patrol_run_anim_array()
{
	var_00 = "patrol_walk";
	if(isdefined(self.patrol_walk_anim))
	{
		var_00 = self.patrol_walk_anim;
	}

	var_01 = undefined;
	if(isdefined(self.patrol_walk_twitch))
	{
		var_01 = self.patrol_walk_twitch;
	}

	maps\_utility::set_generic_run_anim_array(var_00,var_01);
}

//Function Number: 8
func_1BED()
{
	self endon("end_patrol");
	if(isdefined(self.var_1BEE))
	{
		self.var_1BEE endon("death");
	}

	self waittill("enemy");
}

//Function Number: 9
func_1BEF()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self notify("release_node");
	if(!isdefined(self.var_1BD8))
	{
		return;
	}

	self.var_1BD8.var_1BD7 = undefined;
}

//Function Number: 10
waittill_combat()
{
	self endon("death");
	func_1BED();
	var_00 = maps\_utility::ent_flag_exist("_stealth_enabled") && maps\_utility::ent_flag("_stealth_enabled");
	if(!var_00)
	{
		maps\_utility::clear_run_anim();
		self allowedstances("stand","crouch","prone");
		self.disablearrivals = 0;
		self.disableexits = 0;
		self stopanimscripted();
		self notify("stop_animmode");
		self.script_nobark = undefined;
		self.goalradius = level.default_goalradius;
	}

	if(isdefined(self.var_1BF3))
	{
		self.interval = self.var_1BF3;
	}

	self.moveplaybackrate = 1;
	if(!isdefined(self))
	{
		return;
	}

	self notify("release_node");
	if(!isdefined(self.var_1BD8))
	{
		return;
	}

	self.var_1BD8.var_1BD7 = undefined;
}

//Function Number: 11
get_target_ents()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 12
get_target_nodes()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = getnodearray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 13
func_0FD7()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = common_scripts\utility::getstructarray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 14
func_1BF4()
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
func_1BF6()
{
	if(isdefined(self.var_1BDC))
	{
		self.var_1BDC thread pet_patrol();
		return;
	}

	if(!isdefined(self.script_pet))
	{
		return;
	}

	waittillframeend;
	var_00 = getaispeciesarray(self.team,"dog");
	var_01 = undefined;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(!isdefined(var_00[var_02].script_pet))
		{
			continue;
		}

		if(var_00[var_02].script_pet != self.script_pet)
		{
			continue;
		}

		var_01 = var_00[var_02];
		self.var_1BDC = var_01;
		var_01.var_1BEE = self;
		break;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_01 thread pet_patrol();
}

//Function Number: 17
pet_patrol()
{
	maps\_utility::func_F77(self);
	if(isdefined(self.enemy))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	if(isdefined(self.var_1BD1))
	{
		[[ level.global_callbacks["_patrol_endon_spotted_flag"] ]]();
	}

	self.var_1BEE endon("death");
	thread waittill_combat();
	self.goalradius = 4;
	self.allowdeath = 1;
	var_00 = func_1BFA();
	var_01 = vectornormalize(self.origin - self.var_1BEE.origin);
	var_02 = anglestoright(self.var_1BEE.angles);
	var_03 = "left";
	if(vectordot(var_01,var_02) > 0)
	{
		var_03 = "right";
	}

	wait 1;
	thread func_1C01();
	thread pet_patrol_handle_movespeed();
	self.var_1BF3 = self.interval;
	self.interval = 70;
	for(;;)
	{
		if(isdefined(self.var_1BEE) && !isdefined(self.var_1BEE.var_1BE0))
		{
			var_00 = func_1BFC(var_00);
			if(var_03 == "null")
			{
				var_03 = "back";
			}

			var_03 = pet_patrol_get_available_origin(var_00,var_03);
			self.patrol_goal_pos = var_00[var_03].origin;
		}
		else
		{
			self.patrol_goal_pos = self.origin;
		}

		self setgoalpos(self.patrol_goal_pos);
		wait 0.05;
	}
}

//Function Number: 18
func_1BFA()
{
	var_00 = [];
	var_01 = spawnstruct();
	var_01.options = [];
	var_01.options[var_01.options.size] = "right";
	var_01.options[var_01.options.size] = "back_right";
	var_02 = spawnstruct();
	var_02.options = [];
	var_02.options[var_02.options.size] = "right";
	var_02.options[var_02.options.size] = "back_right";
	var_02.options[var_02.options.size] = "back";
	var_03 = spawnstruct();
	var_03.options = [];
	var_03.options[var_03.options.size] = "back_right";
	var_03.options[var_03.options.size] = "back_left";
	var_03.options[var_03.options.size] = "back";
	var_04 = spawnstruct();
	var_04.options = [];
	var_04.options[var_04.options.size] = "left";
	var_04.options[var_04.options.size] = "back_left";
	var_04.options[var_04.options.size] = "back";
	var_05 = spawnstruct();
	var_05.options = [];
	var_05.options[var_05.options.size] = "left";
	var_05.options[var_05.options.size] = "back_left";
	var_06 = spawnstruct();
	var_00["right"] = var_01;
	var_00["left"] = var_05;
	var_00["back_right"] = var_02;
	var_00["back_left"] = var_04;
	var_00["back"] = var_03;
	var_00["null"] = var_06;
	return var_00;
}

//Function Number: 19
func_1BFC(param_00)
{
	var_01 = vectortoangles(self.var_1BEE.var_1BD8.origin - self.var_1BEE.origin);
	var_02 = self.var_1BEE.origin;
	var_03 = anglestoright(var_01);
	var_04 = anglestoforward(var_01);
	param_00["right"].origin = var_02 + var_03 * 40 + var_04 * 30;
	param_00["left"].origin = var_02 + var_03 * -40 + var_04 * 30;
	param_00["back_right"].origin = var_02 + var_03 * 32 + var_04 * -16;
	param_00["back_left"].origin = var_02 + var_03 * -32 + var_04 * -16;
	param_00["back"].origin = var_02 + var_04 * -48;
	param_00["null"].origin = self.origin;
	var_05 = getarraykeys(param_00);
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = var_05[var_06];
		param_00[var_07].var_1BFD = 0;
		param_00[var_07].recursed = 0;
	}

	return param_00;
}

//Function Number: 20
pet_debug_positions(param_00)
{
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(var_03 == "null")
		{
			continue;
		}
	}
}

//Function Number: 21
pet_patrol_get_available_origin(param_00,param_01)
{
	param_00[param_01].recursed = 1;
	for(var_02 = 0;var_02 < param_00[param_01].options.size;var_02++)
	{
		var_03 = param_00[param_01].options[var_02];
		if(param_00[var_03].var_1BFD)
		{
			continue;
		}

		if(self maymovetopoint(param_00[var_03].origin))
		{
			return var_03;
		}

		param_00[var_03].var_1BFD = 1;
	}

	for(var_02 = 0;var_02 < param_00[param_01].options.size;var_02++)
	{
		var_03 = param_00[param_01].options[var_02];
		if(param_00[var_03].recursed)
		{
			continue;
		}

		var_03 = pet_patrol_get_available_origin(param_00,var_03);
		return var_03;
	}

	return "null";
}

//Function Number: 22
func_1C01(param_00)
{
	if(isdefined(self.enemy))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	self.var_1BEE endon("death");
	if(isdefined(self.var_1BEE.script_noteworthy) && self.var_1BEE.script_noteworthy == "cqb_patrol")
	{
		maps\_utility::set_dog_walk_anim();
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 200;
	}

	maps\_utility::set_dog_walk_anim();
	for(;;)
	{
		wait 0.1;
		var_01 = self.patrol_goal_pos;
		var_02 = distancesquared(self.origin,self.patrol_goal_pos);
		if(var_02 > squared(param_00))
		{
			if(self.a.movement == "run")
			{
				continue;
			}

			maps\_anim::anim_generic_custom_animmode(self,"gravity","patrol_dog_start");
			maps\_utility::clear_run_anim();
			self.script_nobark = 1;
			continue;
		}

		if(self.a.movement != "walk")
		{
			self notify("stopped_while_patrolling");
			maps\_anim::anim_generic_custom_animmode(self,"gravity","patrol_dog_stop");
			maps\_utility::set_dog_walk_anim();
		}
	}
}

//Function Number: 23
pet_patrol_handle_movespeed(param_00,param_01)
{
	if(isdefined(self.enemy))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	self.var_1BEE endon("death");
	if(isdefined(self.var_1BEE.script_noteworthy) && self.var_1BEE.script_noteworthy == "cqb_patrol")
	{
		for(;;)
		{
			wait 0.05;
			var_02 = self.patrol_goal_pos;
			var_03 = distancesquared(self.origin,self.patrol_goal_pos);
			if(var_03 < squared(16))
			{
				if(self.moveplaybackrate > 0.4)
				{
					self.moveplaybackrate = self.moveplaybackrate - 0.05;
				}

				continue;
			}

			if(var_03 > squared(48))
			{
				if(self.moveplaybackrate < 1.8)
				{
					self.moveplaybackrate = self.moveplaybackrate + 0.05;
				}

				continue;
			}

			self.moveplaybackrate = 1;
		}
	}

	if(!isdefined(param_00))
	{
		param_00 = 16;
	}

	if(!isdefined(param_01))
	{
		param_01 = 48;
	}

	var_04 = param_00 * param_00;
	var_05 = param_01 * param_01;
	for(;;)
	{
		wait 0.05;
		var_02 = self.patrol_goal_pos;
		var_03 = distancesquared(self.origin,self.patrol_goal_pos);
		if(self.a.movement != "walk")
		{
			self.moveplaybackrate = 1;
			continue;
		}

		if(var_03 < var_04)
		{
			if(self.moveplaybackrate > 0.4)
			{
				self.moveplaybackrate = self.moveplaybackrate - 0.05;
			}

			continue;
		}

		if(var_03 > var_05)
		{
			if(self.moveplaybackrate < 0.75)
			{
				self.moveplaybackrate = self.moveplaybackrate + 0.05;
			}

			continue;
		}

		self.moveplaybackrate = 0.5;
	}
}