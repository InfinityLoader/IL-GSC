/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_drone.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 442 ms
 * Timestamp: 10/27/2023 2:35:39 AM
*******************************************************************/

//Function Number: 1
func_1B95()
{
	if(getdvar("debug_drones") == "")
	{
		setdvar("debug_drones","0");
	}

	if(!isdefined(level.lookahead_value))
	{
		level.drone_lookahead_value = 200;
	}

	if(!isdefined(level.max_drones))
	{
		level.max_drones = [];
	}

	if(!isdefined(level.max_drones["allies"]))
	{
		level.max_drones["allies"] = 99999;
	}

	if(!isdefined(level.max_drones["axis"]))
	{
		level.max_drones["axis"] = 99999;
	}

	if(!isdefined(level.max_drones["team3"]))
	{
		level.max_drones["team3"] = 99999;
	}

	if(!isdefined(level.max_drones["neutral"]))
	{
		level.max_drones["neutral"] = 99999;
	}

	if(!isdefined(level.drones))
	{
		level.drones = [];
	}

	if(!isdefined(level.drones["allies"]))
	{
		level.drones["allies"] = maps\_utility::struct_arrayspawn();
	}

	if(!isdefined(level.drones["axis"]))
	{
		level.drones["axis"] = maps\_utility::struct_arrayspawn();
	}

	if(!isdefined(level.drones["team3"]))
	{
		level.drones["team3"] = maps\_utility::struct_arrayspawn();
	}

	if(!isdefined(level.drones["neutral"]))
	{
		level.drones["neutral"] = maps\_utility::struct_arrayspawn();
	}

	level.drone_spawn_func = ::drone_init;
}

//Function Number: 2
drone_give_soul()
{
	self useanimtree(#animtree);
	self startusingheroonlylighting();
	if(isdefined(self.script_moveplaybackrate))
	{
		self.moveplaybackrate = self.script_moveplaybackrate;
	}
	else
	{
		self.moveplaybackrate = 1;
	}

	if(self.team == "llies")
	{
		maps\_names::get_name();
		self setlookattext(self.name,&"");
	}

	if(isdefined(level.dronecallbackthread))
	{
		self thread [[ level.dronecallbackthread ]]();
	}

	if(!isdefined(self.var_1B9F))
	{
		level thread maps\_friendlyfire::friendly_fire_think(self);
	}

	if(!isdefined(level.ai_dont_glow_in_thermal))
	{
		self thermaldrawenable();
	}
}

//Function Number: 3
drone_init()
{
	if(level.drones[self.team].array.size >= level.max_drones[self.team])
	{
		self delete();
		return;
	}

	thread drone_array_handling(self);
	level notify("new_drone");
	self setcandamage(1);
	drone_give_soul();
	if(isdefined(self.var_1BA2))
	{
		return;
	}

	thread drone_death_thread();
	if(isdefined(self.target))
	{
		if(!isdefined(self.script_moveoverride))
		{
			thread drone_move();
		}
		else
		{
			thread drone_wait_move();
		}
	}

	if(isdefined(self.var_1BA4) && self.var_1BA4 == 0)
	{
		return;
	}

	thread func_1BB3();
}

//Function Number: 4
drone_array_handling(param_00)
{
	maps\_utility::structarray_add(level.drones[param_00.team],param_00);
	var_01 = param_00.team;
	param_00 waittill("death");
	if(isdefined(param_00) && isdefined(param_00.struct_array_index))
	{
		maps\_utility::func_1BA7(level.drones[var_01],param_00.struct_array_index);
		return;
	}

	maps\_utility::func_1BA8(level.drones[var_01]);
}

//Function Number: 5
drone_death_thread()
{
	drone_wait_for_death();
	if(!isdefined(self))
	{
		return;
	}

	var_00 = "stand";
	if(isdefined(self.animset) && isdefined(level.var_1BAB[self.team][self.animset]) && isdefined(level.var_1BAB[self.team][self.animset]["death"]))
	{
		var_00 = self.animset;
	}

	var_01 = level.var_1BAB[self.team][var_00]["death"];
	if(isdefined(self.var_93B))
	{
		var_01 = self.var_93B;
	}

	self notify("death");
	if(isdefined(level.drone_death_handler))
	{
		self thread [[ level.drone_death_handler ]](var_01);
		return;
	}

	if(!isdefined(self.noragdoll) && isdefined(self.skipdeathanim))
	{
		if(isdefined(self.noragdoll))
		{
			func_1BB1(var_01,"deathplant");
		}
		else if(isdefined(self.skipdeathanim))
		{
			self startragdoll();
			func_1BB1(var_01,"deathplant");
		}
		else
		{
			func_1BB1(var_01,"deathplant");
			self startragdoll();
		}
	}

	self notsolid();
	thread drone_thermal_draw_disable(2);
	if(isdefined(self) && isdefined(self.nocorpsedelete))
	{
		return;
	}

	wait 10;
	while(isdefined(self))
	{
		if(!maps\_utility::within_fov(level.player.origin,level.player.angles,self.origin,0.5))
		{
			self delete();
		}

		wait 5;
	}
}

//Function Number: 6
drone_wait_for_death()
{
	self endon("death");
	while(isdefined(self))
	{
		self waittill("damage");
		if(isdefined(self.damageshield) && self.damageshield)
		{
			self.health = 100000;
			continue;
		}

		if(self.health <= 0)
		{
			break;
		}
	}
}

//Function Number: 7
drone_thermal_draw_disable(param_00)
{
	wait param_00;
	if(isdefined(self))
	{
		self thermaldrawdisable();
	}
}

//Function Number: 8
func_1BB0(param_00,param_01)
{
	self clearanim(%body,0.2);
	self stopanimscripted();
	self setflaggedanimknoballrestart("drone_anim",param_00,%body,1,0.2,param_01);
}

//Function Number: 9
func_1BB1(param_00,param_01)
{
	self clearanim(%body,0.2);
	self stopanimscripted();
	var_02 = "normal";
	if(isdefined(param_01))
	{
		var_02 = "deathplant";
	}

	var_03 = "drone_anim";
	self animscripted(var_03,self.origin,self.angles,param_00,var_02);
	self waittillmatch("end","drone_anim");
}

//Function Number: 10
drone_drop_real_weapon_on_death()
{
	if(!isdefined(self))
	{
		return;
	}

	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	var_00 = getweaponmodel(self.weapon);
	var_01 = self.weapon;
	if(isdefined(var_00))
	{
		self detach(var_00,"tag_weapon_right");
		var_02 = self gettagorigin("tag_weapon_right");
		var_03 = self gettagangles("tag_weapon_right");
		var_04 = spawn("weapon_" + var_01,(0,0,0));
		var_04.angles = var_03;
		var_04.origin = var_02;
	}
}

//Function Number: 11
func_1BB3(param_00,param_01)
{
	if(isdefined(self.drone_idle_custom))
	{
		[[ self.drone_idle_override ]]();
		return;
	}

	if(isdefined(param_00) && isdefined(param_00["script_noteworthy"]) && isdefined(level.var_1BAB[self.team][param_00["script_noteworthy"]]))
	{
		thread func_1BB8(param_00["script_noteworthy"],param_00,param_01);
		return;
	}

	if(isdefined(self.idleanim))
	{
		func_1BB0(self.idleanim,1);
		return;
	}

	func_1BB0(level.var_1BAB[self.team]["stand"]["idle"],1);
}

//Function Number: 12
drone_get_goal_loc_with_arrival(param_00,param_01)
{
	var_02 = param_01["script_noteworthy"];
	if(!isdefined(level.var_1BAB[self.team][var_02]["arrival"]))
	{
		return param_00;
	}

	var_03 = getmovedelta(level.var_1BAB[self.team][var_02]["arrival"],0,1);
	var_03 = length(var_03);
	param_00 = param_00 - var_03;
	return param_00;
}

//Function Number: 13
func_1BB8(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_drone_fighting");
	self.animset = param_00;
	self.weaponsound = undefined;
	var_03 = randomintrange(1,4);
	if(self.team == "axis")
	{
		if(var_03 == 1)
		{
			self.weaponsound = "drone_ak47_fire_npc";
		}
		else if(var_03 == 2)
		{
			self.weaponsound = "drone_g36c_fire_npc";
		}

		if(var_03 == 3)
		{
			self.weaponsound = "drone_fnp90_fire_npc";
		}
	}
	else
	{
		if(var_03 == 1)
		{
			self.weaponsound = "drone_m4carbine_fire_npc";
		}
		else if(var_03 == 2)
		{
			self.weaponsound = "drone_m16_fire_npc";
		}

		if(var_03 == 3)
		{
			self.weaponsound = "drone_m249saw_fire_npc";
		}
	}

	self.angles = (0,self.angles[1],self.angles[2]);
	if(param_00 == "coverprone")
	{
		self moveto(self.origin + (0,0,8),0.05);
	}

	self.noragdoll = 1;
	var_04 = level.var_1BAB[self.team][param_00];
	self.var_93B = var_04["death"];
	while(isdefined(self))
	{
		func_1BB1(var_04["idle"][randomint(var_04["idle"].size)]);
		if(common_scripts\utility::cointoss() && !isdefined(self.ignoreall))
		{
			var_05 = 1;
			if(isdefined(var_04["pop_up_chance"]))
			{
				var_05 = var_04["pop_up_chance"];
			}

			var_05 = var_05 * 100;
			var_06 = 1;
			if(randomfloat(100) > var_05)
			{
				var_06 = 0;
			}

			if(var_06 == 1)
			{
				func_1BB1(var_04["hide_2_aim"]);
				wait getanimlength(var_04["hide_2_aim"]) - 0.5;
			}

			if(isdefined(var_04["fire"]))
			{
				if(param_00 == "coverprone" && var_06 == 1)
				{
					thread func_1BB0(var_04["fire_exposed"],1);
				}
				else
				{
					thread func_1BB0(var_04["fire"],1);
				}

				drone_fire_randomly();
			}
			else
			{
				drone_shoot();
				wait 0.15;
				drone_shoot();
				wait 0.15;
				drone_shoot();
				wait 0.15;
				drone_shoot();
			}

			if(var_06 == 1)
			{
				func_1BB1(var_04["aim_2_hide"]);
			}

			func_1BB1(var_04["reload"]);
		}
	}
}

//Function Number: 14
drone_fire_randomly()
{
	self endon("death");
	if(common_scripts\utility::cointoss())
	{
		drone_shoot();
		wait 0.1;
		drone_shoot();
		wait 0.1;
		drone_shoot();
		if(common_scripts\utility::cointoss())
		{
			wait 0.1;
			drone_shoot();
		}

		if(common_scripts\utility::cointoss())
		{
			wait 0.1;
			drone_shoot();
			wait 0.1;
			drone_shoot();
			wait 0.1;
		}

		if(common_scripts\utility::cointoss())
		{
			wait randomfloatrange(1,2);
			return;
		}

		return;
	}

	drone_shoot();
	wait randomfloatrange(0.25,0.75);
	drone_shoot();
	wait randomfloatrange(0.15,0.75);
	drone_shoot();
	wait randomfloatrange(0.15,0.75);
	drone_shoot();
	wait randomfloatrange(0.15,0.75);
}

//Function Number: 15
drone_shoot()
{
	self endon("death");
	self notify("firing");
	self endon("firing");
	drone_shoot_fx();
	var_00 = %exposed_crouch_shoot_auto_v2;
	self setanimknobrestart(var_00,1,0.2,1);
	common_scripts\utility::delaycall(0.25,::clearanim,var_00,0);
}

//Function Number: 16
drone_shoot_fx()
{
	var_00 = common_scripts\utility::func_539("ak47_muzzleflash");
	if(self.team == "allies")
	{
		var_00 = common_scripts\utility::func_539("m16_muzzleflash");
	}

	thread drone_play_weapon_sound(self.weaponsound);
	playfxontag(var_00,self,"tag_flash");
}

//Function Number: 17
drone_play_weapon_sound(param_00)
{
	self playsound(param_00);
}

//Function Number: 18
drone_wait_move()
{
	self endon("death");
	self waittill("move");
	thread drone_move();
}

//Function Number: 19
func_1BBF()
{
	if(!isdefined(self.target))
	{
		return;
	}

	if(isdefined(level.drone_paths[self.target]))
	{
		return;
	}

	level.drone_paths[self.target] = 1;
	var_00 = self.target;
	var_01 = common_scripts\utility::getstruct(var_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = [];
	var_03 = [];
	var_04 = var_01;
	for(;;)
	{
		var_01 = var_04;
		var_05 = 0;
		for(;;)
		{
			if(!isdefined(var_01.target))
			{
				break;
			}

			var_06 = common_scripts\utility::getstructarray(var_01.target,"targetname");
			if(var_06.size)
			{
				break;
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(isdefined(var_03[var_09.origin + ""]))
				{
					continue;
				}

				var_07 = var_09;
				break;
			}

			if(!isdefined(var_07))
			{
				break;
			}

			var_03[var_07.origin + ""] = 1;
			var_02[var_01.targetname] = var_07.origin - var_01.origin;
			var_01.angles = vectortoangles(var_02[var_01.targetname]);
			var_01 = var_07;
			var_05 = 1;
		}

		if(!var_05)
		{
			break;
		}
	}

	var_00 = self.target;
	var_01 = common_scripts\utility::getstruct(var_00,"targetname");
	var_0B = var_01;
	var_03 = [];
	for(;;)
	{
		var_01 = var_04;
		var_05 = 0;
		for(;;)
		{
			if(!isdefined(var_01.target))
			{
				return;
			}

			if(!isdefined(var_02[var_01.targetname]))
			{
				return;
			}

			var_06 = common_scripts\utility::getstructarray(var_01.target,"targetname");
			if(var_06.size)
			{
				break;
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(isdefined(var_03[var_09.origin + ""]))
				{
					continue;
				}

				var_07 = var_09;
				break;
			}

			if(!isdefined(var_07))
			{
				break;
			}

			if(isdefined(var_01.radius))
			{
				var_0E = var_02[var_0B.targetname];
				var_0F = var_02[var_01.targetname];
				var_10 = var_0E + var_0F * 0.5;
				var_01.angles = vectortoangles(var_10);
			}

			var_05 = 1;
			var_0B = var_01;
			var_01 = var_07;
		}

		if(!var_05)
		{
			break;
		}
	}
}

//Function Number: 20
func_1BC0(param_00)
{
	var_01 = 170;
	var_02 = 1;
	var_03 = getanimlength(param_00);
	var_04 = getmovedelta(param_00,0,1);
	var_05 = length(var_04);
	if(var_03 > 0 && var_05 > 0)
	{
		var_01 = var_05 / var_03;
		var_02 = 0;
	}

	if(isdefined(self.var_1BC1))
	{
		var_01 = self.var_1BC1;
	}

	var_06 = spawnstruct();
	var_06.anim_relative = var_02;
	var_06.run_speed = var_01;
	var_06.anim_time = var_03;
	return var_06;
}

//Function Number: 21
drone_move()
{
	self endon("death");
	self endon("drone_stop");
	wait 0.05;
	var_00 = func_1BCC(self.target,self.origin);
	var_01 = level.var_1BAB[self.team]["stand"]["run"];
	if(isdefined(self.runanim))
	{
		var_01 = self.runanim;
	}

	var_02 = func_1BC0(var_01);
	var_03 = var_02.run_speed;
	var_04 = var_02.anim_relative;
	if(isdefined(self.var_1BC7))
	{
		var_02 = [[ self.var_1BC7 ]]();
		if(isdefined(var_02))
		{
			var_01 = var_02.runanim;
			var_03 = var_02.run_speed;
			var_04 = var_02.anim_relative;
		}

		var_02 = undefined;
	}

	if(!var_04)
	{
		thread func_1BCB(var_03);
	}

	func_1BB0(var_01,self.moveplaybackrate);
	var_05 = 0.5;
	var_06 = 0;
	self.started_moving = 1;
	self.var_1BC9 = var_00[var_06];
	for(;;)
	{
		if(!isdefined(var_00[var_06]))
		{
			break;
		}

		var_07 = var_00[var_06]["vec"];
		var_08 = self.origin - var_00[var_06]["origin"];
		var_09 = vectordot(vectornormalize(var_07),var_08);
		if(!isdefined(var_00[var_06]["dist"]))
		{
			break;
		}

		var_0A = var_09 + level.drone_lookahead_value;
		while(var_0A > var_00[var_06]["dist"])
		{
			var_0A = var_0A - var_00[var_06]["dist"];
			var_06++;
			self.var_1BC9 = var_00[var_06];
			if(!isdefined(var_00[var_06]["dist"]))
			{
				self rotateto(vectortoangles(var_00[var_00.size - 1]["vec"]),var_05);
				var_0B = distance(self.origin,var_00[var_00.size - 1]["origin"]);
				var_0C = var_0B / var_03 * self.moveplaybackrate;
				var_0D = var_00[var_00.size - 1]["origin"] + (0,0,100);
				var_0E = var_00[var_00.size - 1]["origin"] - (0,0,100);
				var_0F = physicstrace(var_0D,var_0E);
				if(getdvar("debug_drones") == "1")
				{
					thread common_scripts\utility::draw_line_for_time(var_0D,var_0E,1,1,1,var_05);
					thread common_scripts\utility::draw_line_for_time(self.origin,var_0F,0,0,1,var_05);
				}

				self moveto(var_0F,var_0C);
				wait var_0C;
				self notify("goal");
				thread func_1BCF();
				thread func_1BB3(var_00[var_00.size - 1],var_0F);
				return;
			}

			if(!isdefined(var_03[var_09]))
			{
				self notify("goal");
				thread func_1BB3();
				return;
			}
		}

		if(isdefined(self.var_1BC7))
		{
			var_05 = [[ self.var_1BC7 ]]();
			if(isdefined(var_05))
			{
				var_04 = var_05.runanim;
				if(var_05.runanim != var_04)
				{
					var_06 = var_05.run_speed;
					var_07 = var_05.anim_relative;
					if(!var_07)
					{
						thread func_1BCB(var_06);
					}
					else
					{
						self notify("drone_move_z");
					}

					func_1BB0(var_04,self.moveplaybackrate);
				}
			}
		}

		self.var_1BC9 = var_03[var_09];
		var_0E = var_03[var_09]["vec"] * var_0D;
		var_0E = var_0E + var_03[var_09]["origin"];
		var_12 = var_0E;
		var_13 = var_12 + (0,0,100);
		var_14 = var_12 - (0,0,100);
		var_12 = physicstrace(var_13,var_14);
		if(!var_07)
		{
			self.var_1BCA = var_12;
		}

		if(getdvar("debug_drones") == "1")
		{
			thread common_scripts\utility::draw_line_for_time(var_13,var_14,1,1,1,var_08);
			thread draw_point(var_12,1,0,0,16,var_08);
		}

		var_0B = vectortoangles(var_12 - self.origin);
		self rotateto((0,var_0B[1],0),var_08);
		var_0C = var_06 * var_08 * self.moveplaybackrate;
		var_0F = vectornormalize(var_12 - self.origin);
		var_0E = var_0F * var_0C;
		var_0E = var_0E + self.origin;
		if(getdvar("debug_drones") == "1")
		{
			thread common_scripts\utility::draw_line_for_time(self.origin,var_0E,0,0,1,var_08);
		}

		self moveto(var_0E,var_08);
		wait var_08;
	}

	thread func_1BB3();
}

//Function Number: 22
func_1BCB(param_00)
{
	self endon("death");
	self endon("drone_stop");
	self notify("drone_move_z");
	self endon("drone_move_z");
	var_01 = 0.05;
	for(;;)
	{
		if(isdefined(self.var_1BCA) && param_00 > 0)
		{
			var_02 = self.var_1BCA[2] - self.origin[2];
			var_03 = distance2d(self.var_1BCA,self.origin);
			var_04 = var_03 / param_00;
			if(var_04 > 0 && var_02 != 0)
			{
				var_05 = abs(var_02) / var_04;
				var_06 = var_05 * var_01;
				if(var_02 >= var_05)
				{
					self.origin = (self.origin[0],self.origin[1],self.origin[2] + var_06);
				}
				else if(var_02 <= var_05 * -1)
				{
					self.origin = (self.origin[0],self.origin[1],self.origin[2] - var_06);
				}
			}
		}

		wait var_01;
	}
}

//Function Number: 23
func_1BCC(param_00,param_01)
{
	var_02 = 1;
	var_03 = [];
	var_29[0] = "origin";
	var_29[0] = "dist";
	var_04 = undefined;
	var_04 = param_01;
	param_00["entity"] = ::maps\_spawner::get_target_ents;
	var_06 = undefined;
	var_07 = [[ var_41["entity"] ]](var_04);
	var_08 = [[ var_41["node"] ]](var_04);
	var_09 = [[ var_41["struct"] ]](var_04);
	if(var_07.size)
	{
		var_06 = "entity";
	}
	else if(var_08.size)
	{
		var_06 = "node";
	}
	else if(var_09.size)
	{
		var_06 = "struct";
	}

	for(;;)
	{
		var_0A = var_29.size;
		var_0B = [[ var_41[var_06] ]](var_04);
		var_0C = common_scripts\utility::random(var_0B);
		var_0D = var_0C.origin;
		if(isdefined(var_0C.radius))
		{
			if(!isdefined(self.var_1BCD))
			{
				self.var_1BCD = -1 + randomfloat(2);
			}

			if(!isdefined(var_0C.angles))
			{
				var_0C.angles = (0,0,0);
			}

			var_0E = anglestoforward(var_0C.angles);
			var_0F = anglestoright(var_0C.angles);
			var_10 = anglestoup(var_0C.angles);
			var_11 = (0,self.var_1BCD * var_0C.radius,0);
			var_0D = var_0D + var_0E * var_11[0];
			var_0D = var_0D + var_0F * var_11[1];
			var_0D = var_0D + var_10 * var_11[2];
		}

		var_29[var_0A]["origin"] = var_0D;
		var_29[var_0A]["target"] = var_0C.target;
		if(isdefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isdefined(var_0C.angles))
		{
			var_29[var_0A]["angles"] = var_0C.angles;
		}

		if(isdefined(var_0C.script_noteworthy))
		{
			var_29[var_0A]["script_noteworthy"] = var_0C.script_noteworthy;
		}

		var_29[var_0A - 1]["dist"] = distance(var_29[var_0A]["origin"],var_29[var_0A - 1]["origin"]);
		var_29[var_0A - 1]["vec"] = vectornormalize(var_29[var_0A]["origin"] - var_29[var_0A - 1]["origin"]);
		if(!isdefined(var_29[var_0A - 1]["target"]))
		{
			var_29[var_0A - 1]["target"] = var_0C.targetname;
		}

		if(!isdefined(var_29[var_0A - 1]["script_noteworthy"]) && isdefined(var_0C.script_noteworthy))
		{
			var_29[var_0A - 1]["script_noteworthy"] = var_0C.script_noteworthy;
		}

		if(!isdefined(var_0C.target))
		{
			break;
		}

		var_04 = var_0C.target;
	}

	if(isdefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isdefined(var_29[var_0A]["angles"]))
	{
		var_29[var_0A]["vec"] = anglestoforward(var_29[var_0A]["angles"]);
	}
	else
	{
		var_29[var_0A]["vec"] = var_29[var_0A - 1]["vec"];
	}

	var_0C = undefined;
	return var_29;
}

//Function Number: 24
draw_point(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 + (param_04,0,0);
	var_07 = param_00 - (param_04,0,0);
	thread common_scripts\utility::draw_line_for_time(var_06,var_07,param_01,param_02,param_03,param_05);
	var_06 = param_00 + (0,param_04,0);
	var_07 = param_00 - (0,param_04,0);
	thread common_scripts\utility::draw_line_for_time(var_06,var_07,param_01,param_02,param_03,param_05);
	var_06 = param_00 + (0,0,param_04);
	var_07 = param_00 - (0,0,param_04);
	thread common_scripts\utility::draw_line_for_time(var_06,var_07,param_01,param_02,param_03,param_05);
}

//Function Number: 25
func_1BCF()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.script_noteworthy))
	{
		return;
	}

	switch(self.script_noteworthy)
	{
		case "delete_on_goal":
			self delete();
			break;

		case "die_on_goal":
			self kill();
			break;
	}
}