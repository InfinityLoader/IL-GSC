/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_patrol.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 421 ms
 * Timestamp: 10/27/2023 1:25:01 AM
*******************************************************************/

//Function Number: 1
func_5B3C(param_00)
{
	if(isdefined(self.enemy))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("damage");
	self endon("end_patrol");
	self endon("dog_attacks_ai");
	waittillframeend;
	if(isdefined(self.var_6CC5))
	{
		[[ level.global_callbacks["_patrol_endon_spotted_flag"] ]]();
	}

	thread func_8B3E();
	thread func_8B4C();
	self.goalradius = 32;
	self allowedstances("stand");
	self.var_279A = 1;
	self.disableexits = 1;
	self.allowdeath = 1;
	self.var_6C79 = 1;
	self.oldcombatmode = self.combatmode;
	self.combatmode = "no_cover";
	maps\_utility::disable_cqbwalk();
	if(isdefined(self.var_6C37))
	{
		self.var_58C9 = self.moveplaybackrate;
		self.moveplaybackrate = self.var_6C37;
	}

	linkpet();
	func_6F40();
	var_01["ent"][1] = ::get_target_ents;
	var_01["ent"][0] = ::common_scripts\utility::get_linked_ents;
	var_01["node"][1] = ::func_39C3;
	var_01["node"][0] = ::func_38D9;
	var_01["struct"][1] = ::func_39C4;
	var_01["struct"][0] = ::maps\_utility::get_linked_structs;
	var_02["ent"] = ::maps\_utility::func_6EF4;
	var_02["node"] = ::maps\_utility::func_6EF9;
	var_02["struct"] = ::maps\_utility::func_6EF4;
	if(isdefined(param_00))
	{
		self.target = param_00;
	}

	if(isdefined(self.target))
	{
		var_03 = 1;
		var_04 = get_target_ents();
		var_05 = func_39C3();
		var_06 = func_39C4();
		if(var_04.size)
		{
			var_07 = common_scripts\utility::func_6306(var_04);
			var_08 = "ent";
		}
		else if(var_07.size)
		{
			var_07 = common_scripts\utility::func_6306(var_07);
			var_08 = "node";
		}
		else
		{
			var_07 = common_scripts\utility::func_6306(var_08);
			var_08 = "struct";
		}
	}
	else
	{
		var_03 = 0;
		var_04 = common_scripts\utility::get_linked_ents();
		var_05 = func_38D9();
		var_06 = maps\_utility::get_linked_structs();
		if(var_06.size)
		{
			var_07 = common_scripts\utility::func_6306(var_06);
			var_08 = "ent";
		}
		else if(var_07.size)
		{
			var_07 = common_scripts\utility::func_6306(var_07);
			var_08 = "node";
		}
		else
		{
			var_07 = common_scripts\utility::func_6306(var_08);
			var_08 = "struct";
		}
	}

	var_09 = [];
	var_09["pause"] = "patrol_idle_";
	var_09["turn180"] = common_scripts\utility::func_803F(isdefined(self.var_5B3D),self.var_5B3D,"patrol_turn180");
	var_09["smoke"] = "patrol_idle_smoke";
	var_09["stretch"] = "patrol_idle_stretch";
	var_09["checkphone"] = "patrol_idle_checkphone";
	var_09["phone"] = "patrol_idle_phone";
	var_0A = var_07;
	for(;;)
	{
		while(isdefined(var_0A.var_5B3E))
		{
			wait(0.05);
		}

		var_07.var_5B3E = undefined;
		var_07 = var_0A;
		self notify("release_node");
		var_07.var_5B3E = 1;
		self.var_4C17 = var_07;
		[[ var_02[var_08] ]](var_07);
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

		if(isdefined(var_07.var_6BA6))
		{
			maps\_utility::func_2F48(var_07.var_6BA6);
		}

		if(isdefined(var_07.script_flag_clear))
		{
			common_scripts\utility::func_337C(var_07.script_flag_clear);
		}

		var_0B = var_07 [[ var_01[var_08][var_03] ]]();
		if(!var_0B.size)
		{
			self notify("reached_path_end");
			self notify("_patrol_reached_path_end");
			if(isalive(self.var_5B47))
			{
				self.var_5B47 notify("master_reached_patrol_end");
			}
		}

		var_0C = ::animscripts/reactions::func_63BF;
		var_0D = var_07.var_6B33;
		var_0E = 1;
		var_0F = 0;
		if(isdefined(var_07.script_parameters))
		{
			var_10 = strtok(var_07.script_parameters," ");
			for(var_11 = 0;var_11 < var_10.size;var_11++)
			{
				switch(var_10[var_11])
				{
					case "keep_running":
						var_0E = 0;
						break;
	
					case "use_node":
						var_0F = 1;
						break;
	
					case "animset":
						var_11 = var_11 + 1;
						self.var_6B33 = var_10[var_11];
						if(self.var_6B33 == "default")
						{
							self.var_6B33 = undefined;
							self.var_5B50 = undefined;
							self.var_5B51 = undefined;
							self.var_5B43 = undefined;
						}
						func_6F40();
						break;
				}
			}
		}

		if(isdefined(var_07.var_6C37))
		{
			self.moveplaybackrate = var_07.var_6C37;
		}

		if((isdefined(var_07.script_delay) && var_07.script_delay > 0.5) || isdefined(var_0D) || isdefined(var_07.var_6BC4) && !common_scripts\utility::flag(var_07.var_6BC4))
		{
			if(!isdefined(self.var_5B46) && var_0E)
			{
				func_5B40(var_0D,var_0C,var_07);
			}

			if(isdefined(var_07.var_6BC4) && !common_scripts\utility::flag(var_07.var_6BC4))
			{
				common_scripts\utility::flag_wait(var_07.var_6BC4);
			}

			var_07 maps\_utility::script_delay();
			if(isdefined(var_0D))
			{
				if(isdefined(var_07.var_6BAE))
				{
					self orientmode("face angle",var_07.angles[1]);
				}

				self.var_5B4A = 1;
				var_12 = var_09[var_0D];
				if(!isdefined(var_12))
				{
					if(isdefined(level.patrol_scriptedanims))
					{
						var_12 = level.patrol_scriptedanims[var_0D];
					}
				}

				if(isdefined(var_12))
				{
					if(var_0D == "pause")
					{
						if(isdefined(self.var_5B4B) && isdefined(self.var_5B4B[var_0D]))
						{
							var_12 = self.var_5B4B[var_0D][randomint(self.var_5B4B[var_0D].size)];
						}
						else
						{
							var_12 = var_12 + randomintrange(1,6);
						}
					}

					if(var_0F)
					{
						var_07 maps\_anim::anim_generic_reach(self,var_12);
						var_07 maps\_anim::func_D65(self,"gravity",var_12,undefined,var_0C);
					}
					else
					{
						maps\_anim::func_D65(self,"gravity",var_12,undefined,var_0C);
					}
				}

				self.var_5B4A = undefined;
			}

			if(var_0B.size && !isdefined(var_0D) || var_0D != "turn180" && var_0E && !isdefined(self.skip_start_transition) || !self.skip_start_transition)
			{
				func_5B3F(var_0D,var_0C);
			}
		}

		if(!var_0B.size)
		{
			if(isdefined(self.var_5B41) && !isdefined(var_0D))
			{
				func_5B40("path_end_idle",var_0C,var_07);
				for(;;)
				{
					var_13 = self.var_5B41[randomint(self.var_5B41.size)];
					maps\_anim::func_D65(self,"gravity",var_13,undefined,var_0C);
				}
			}

			break;
		}

		var_0A = common_scripts\utility::func_6306(var_0B);
	}
}

//Function Number: 2
func_5B40(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = 0;
	if(isdefined(param_02.var_6BAE))
	{
		var_03 = param_02;
		self.noteleport = 1;
		var_04 = 1;
	}

	if(isdefined(self.var_5B4F) && isdefined(self.var_5B4F[param_00]))
	{
		var_03 maps\_anim::func_D65(self,"gravity",self.var_5B4F[param_00],undefined,param_01,var_04);
	}

	if(isdefined(self.var_6B33) && isdefined(level.scr_anim["generic"]["patrol_stop_" + self.var_6B33]))
	{
		maps\_anim::func_D65(self,"gravity","patrol_stop_" + self.var_6B33,undefined,param_01);
	}

	var_03 maps\_anim::func_D65(self,"gravity","patrol_stop",undefined,param_01,var_04);
}

//Function Number: 3
func_5B3F(param_00,param_01)
{
	if(isdefined(self.var_5B4D) && isdefined(self.var_5B4D[param_00]))
	{
		maps\_anim::func_D65(self,"gravity",self.var_5B4D[param_00],undefined,param_01);
	}

	if(isdefined(self.var_6B33) && isdefined(level.scr_anim["generic"]["patrol_start_" + self.var_6B33]))
	{
		maps\_anim::func_D65(self,"gravity","patrol_start_" + self.var_6B33,undefined,param_01);
	}

	maps\_anim::func_D65(self,"gravity","patrol_start",undefined,param_01);
}

//Function Number: 4
func_79C7()
{
	if(self.a.var_60B1 == "crouch" && isdefined(self.a.var_ED8))
	{
		var_00 = self.a.var_ED8["stance_change"];
		if(isdefined(var_00))
		{
			self setflaggedanimknoballrestart("stand_up",var_00,%root,1);
			animscripts/shared::func_2986("stand_up");
		}
	}
}

//Function Number: 5
func_5B49()
{
	self endon("enemy");
	self animmode("zonly_physics",0);
	self orientmode("face current");
	func_79C7();
	var_00 = level.scr_anim["generic"]["patrol_radio_in_clear"];
	self setflaggedanimknoballrestart("radio",var_00,%root,1);
	animscripts/shared::func_2986("radio");
	func_8487();
}

//Function Number: 6
func_8487()
{
	if(!isdefined(self.pathgoalpos))
	{
	}

	var_00 = self.pathgoalpos;
	var_01 = var_00 - self.origin;
	var_01 = (var_01[0],var_01[1],0);
	var_02 = lengthsquared(var_01);
	if(var_02 < 1)
	{
	}

	var_01 = var_01 / sqrt(var_02);
	var_03 = anglestoforward(self.angles);
	if(vectordot(var_03,var_01) < -0.5)
	{
		self animmode("zonly_physics",0);
		self orientmode("face current");
		func_79C7();
		var_04 = level.scr_anim["generic"]["patrol_turn180"];
		self setflaggedanimknoballrestart("move",var_04,%root,1);
		if(animhasnotetrack(var_04,"code_move"))
		{
			animscripts/shared::func_2986("move");
			self orientmode("face motion");
			self animmode("none",0);
		}

		animscripts/shared::func_2986("move");
	}
}

//Function Number: 7
func_6F40()
{
	if(isdefined(self.var_6B33))
	{
		if(isdefined(level.scr_anim["generic"]["patrol_walk_" + self.var_6B33]))
		{
			self.var_5B50 = "patrol_walk_" + self.var_6B33;
		}

		if(isdefined(level.scr_anim["generic"]["patrol_walk_weights_" + self.var_6B33]))
		{
			self.var_5B51 = "patrol_walk_weights_" + self.var_6B33;
		}

		if(isdefined(level.scr_anim["generic"]["patrol_idle_" + self.var_6B33]))
		{
			self.var_5B43 = "patrol_idle_" + self.var_6B33;
		}
	}

	var_00 = "patrol_walk";
	if(isdefined(self.var_5B50))
	{
		var_00 = self.var_5B50;
	}

	var_01 = undefined;
	if(isdefined(self.var_5B51))
	{
		var_01 = self.var_5B51;
	}

	if(isdefined(self.var_6B33))
	{
		if(isdefined(level.scr_anim["generic"]["patrol_idle_" + self.var_6B33]))
		{
			maps\_utility::func_6EED("patrol_idle_" + self.var_6B33);
		}
	}

	maps\_utility::func_6EF1(var_00,var_01);
}

//Function Number: 8
func_8B3F()
{
	self endon("end_patrol");
	if(isdefined(self.var_5B45))
	{
		self.var_5B45 endon("death");
	}

	self waittill("enemy");
}

//Function Number: 9
func_8B4C()
{
	self waittill("death");
	if(!isdefined(self))
	{
	}

	self notify("release_node");
	if(!isdefined(self.var_4C17))
	{
	}

	self.var_4C17.var_5B3E = undefined;
}

//Function Number: 10
func_8B3E()
{
	self endon("death");
	func_8B3F();
	var_00 = maps\_utility::ent_flag_exist("_stealth_enabled") && maps\_utility::ent_flag("_stealth_enabled");
	self.var_6C79 = 0;
	if(!var_00)
	{
		maps\_utility::func_1D11();
		self.combatmode = self.oldcombatmode;
		maps\_utility::clear_run_anim();
		self allowedstances("stand","crouch","prone");
		self.var_279A = 0;
		self.disableexits = 0;
		self stopanimscripted();
		self notify("stop_animmode");
		self.var_6C58 = undefined;
		self.goalradius = level.var_2497;
	}

	if(isdefined(self.var_589C))
	{
		self.interval = self.var_589C;
	}

	self.moveplaybackrate = 1;
	if(!isdefined(self))
	{
	}

	self notify("release_node");
	if(!isdefined(self.var_4C17))
	{
	}

	self.var_4C17.var_5B3E = undefined;
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
func_39C3()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = getnodearray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 13
func_39C4()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = common_scripts\utility::func_3C1A(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 14
func_38D9()
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
func_7506(param_00)
{
	self endon("release_node");
}

//Function Number: 16
linkpet()
{
	if(isdefined(self.var_5B47))
	{
		self.var_5B47 thread pet_patrol();
	}

	if(!isdefined(self.script_pet))
	{
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
		self.var_5B47 = var_01;
		var_01.var_5B45 = self;
		break;
	}

	if(!isdefined(var_01))
	{
	}

	var_01 thread pet_patrol();
}

//Function Number: 17
pet_patrol()
{
	maps\_utility::func_77BE(self);
	if(isdefined(self.enemy))
	{
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	if(isdefined(self.var_6CC5))
	{
		[[ level.global_callbacks["_patrol_endon_spotted_flag"] ]]();
	}

	self.var_5B45 endon("death");
	thread func_8B3E();
	self.goalradius = 4;
	self.allowdeath = 1;
	var_00 = func_5BBD();
	var_01 = vectornormalize(self.origin - self.var_5B45.origin);
	var_02 = anglestoright(self.var_5B45.angles);
	var_03 = "left";
	if(vectordot(var_01,var_02) > 0)
	{
		var_03 = "right";
	}

	wait(1);
	thread func_5BBF();
	thread func_5BC0();
	self.var_589C = self.interval;
	self.interval = 70;
	for(;;)
	{
		if(isdefined(self.var_5B45) && !isdefined(self.var_5B45.var_5B4A))
		{
			var_00 = func_5BC1(var_00);
			if(var_03 == "null")
			{
				var_03 = "back";
			}

			var_03 = pet_patrol_get_available_origin(var_00,var_03);
			self.var_5B42 = var_00[var_03].origin;
		}
		else
		{
			self.var_5B42 = self.origin;
		}

		self setgoalpos(self.var_5B42);
		wait(0.05);
	}
}

//Function Number: 18
func_5BBD()
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
func_5BC1(param_00)
{
	var_01 = vectortoangles(self.var_5B45.var_4C17.origin - self.var_5B45.origin);
	var_02 = self.var_5B45.origin;
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
		param_00[var_07].checked = 0;
		param_00[var_07].var_6414 = 0;
	}

	return param_00;
}

//Function Number: 20
func_5BBB(param_00)
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
	param_00[param_01].var_6414 = 1;
	for(var_02 = 0;var_02 < param_00[param_01].options.size;var_02++)
	{
		var_03 = param_00[param_01].options[var_02];
		if(param_00[var_03].checked)
		{
			continue;
		}

		if(self maymovetopoint(param_00[var_03].origin))
		{
			return var_03;
		}

		param_00[var_03].checked = 1;
	}

	for(var_02 = 0;var_02 < param_00[param_01].options.size;var_02++)
	{
		var_03 = param_00[param_01].options[var_02];
		if(param_00[var_03].var_6414)
		{
			continue;
		}

		var_03 = pet_patrol_get_available_origin(param_00,var_03);
		return var_03;
	}

	return "null";
}

//Function Number: 22
func_5BBF(param_00)
{
	if(isdefined(self.enemy))
	{
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	self.var_5B45 endon("death");
	if(isdefined(self.var_5B45.script_noteworthy) && self.var_5B45.script_noteworthy == "cqb_patrol")
	{
		maps\_utility::func_6E98();
	}

	if(!isdefined(param_00))
	{
		param_00 = 200;
	}

	maps\_utility::func_6E98();
	for(;;)
	{
		wait(0.1);
		var_01 = self.var_5B42;
		var_02 = distancesquared(self.origin,self.var_5B42);
		if(var_02 > squared(param_00))
		{
			if(self.a.var_5486 == "run")
			{
				continue;
			}

			maps\_anim::func_D65(self,"gravity","patrol_dog_start");
			maps\_utility::clear_run_anim();
			self.var_6C58 = 1;
			continue;
		}

		if(self.a.var_5486 != "walk")
		{
			self notify("stopped_while_patrolling");
			maps\_anim::func_D65(self,"gravity","patrol_dog_stop");
			maps\_utility::func_6E98();
		}
	}
}

//Function Number: 23
func_5BC0(param_00,param_01)
{
	if(isdefined(self.enemy))
	{
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	self.var_5B45 endon("death");
	if(isdefined(self.var_5B45.script_noteworthy) && self.var_5B45.script_noteworthy == "cqb_patrol")
	{
		for(;;)
		{
			wait(0.05);
			var_02 = self.var_5B42;
			var_03 = distancesquared(self.origin,self.var_5B42);
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
		wait(0.05);
		var_02 = self.var_5B42;
		var_03 = distancesquared(self.origin,self.var_5B42);
		if(self.a.var_5486 != "walk")
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