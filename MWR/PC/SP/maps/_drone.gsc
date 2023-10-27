/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_drone.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 487 ms
 * Timestamp: 10/27/2023 2:47:39 AM
*******************************************************************/

//Function Number: 1
initglobals()
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
	maps\_drone_base::drone_give_soul();
	if(isdefined(self.script_drone_override))
	{
		return;
	}

	thread drone_monitor_damage_shield();
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

	if(isdefined(self.script_looping) && self.script_looping == 0)
	{
		return;
	}

	thread drone_idle();
}

//Function Number: 3
drone_array_handling(param_00)
{
	maps\_utility::structarray_add(level.drones[param_00.team],param_00);
	var_01 = param_00.team;
	param_00 waittill("death");
	if(isdefined(param_00) && isdefined(param_00.struct_array_index))
	{
		maps\_utility::structarray_remove_index(level.drones[var_01],param_00.struct_array_index);
		return;
	}

	maps\_utility::structarray_remove_undefined(level.drones[var_01]);
}

//Function Number: 4
drone_death_thread()
{
	drone_wait_for_death();
	if(!isdefined(self))
	{
		return;
	}

	var_00 = "stand";
	if(isdefined(self.animset) && isdefined(level.drone_anims[self.team][self.animset]) && isdefined(level.drone_anims[self.team][self.animset]["death"]))
	{
		var_00 = self.animset;
	}

	var_01 = level.drone_anims[self.team][var_00]["death"];
	if(isdefined(self.deathanim))
	{
		var_01 = self.deathanim;
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
			drone_play_scripted_anim(var_01,"deathplant");
		}
		else if(isdefined(self.skipdeathanim))
		{
			self startragdoll();
			drone_play_scripted_anim(var_01,"deathplant");
		}
		else
		{
			drone_play_scripted_anim(var_01,"deathplant");
			self startragdoll();
		}
	}

	self notsolid();
	thread drone_thermal_draw_disable(2);
	if(isdefined(self) && isdefined(self.nocorpsedelete))
	{
		return;
	}

	wait(10);
	while(isdefined(self))
	{
		if(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,self.origin,0.5))
		{
			self delete();
		}

		wait(5);
	}
}

//Function Number: 5
drone_monitor_damage_shield()
{
	self endon("death");
	for(;;)
	{
		while(!isdefined(self.damageshield) || !self.damageshield)
		{
			wait(0.05);
		}

		var_00 = self.health;
		self.health = 100000;
		while(isdefined(self.damageshield) && self.damageshield)
		{
			wait(0.05);
		}

		self.health = var_00;
		wait(0.05);
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
	wait(param_00);
	if(isdefined(self))
	{
		self motionblurhqenable();
	}
}

//Function Number: 8
drone_play_looping_anim(param_00,param_01)
{
	if(isdefined(self.drone_loop_custom))
	{
		self [[ self.drone_loop_override ]](param_00,param_01);
		return;
	}

	self clearanim(%body,0.2);
	self stopanimscripted();
	self setflaggedanimknoballrestart("drone_anim",param_00,%body,1,0.2,param_01);
	self.droneanim = param_00;
}

//Function Number: 9
drone_play_scripted_anim(param_00,param_01)
{
	if(self.type == "human")
	{
		self clearanim(%body,0.2);
	}

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
		maps\_utility::detach_attachments_from_weapon_model(self.weapon);
		self detach(var_00,"tag_weapon_right");
		var_02 = self gettagorigin("tag_weapon_right");
		var_03 = self gettagangles("tag_weapon_right");
		var_04 = spawn("weapon_" + var_01,(0,0,0));
		var_04.angles = var_03;
		var_04.origin = var_02;
	}
}

//Function Number: 11
drone_set_archetype_idle(param_00)
{
	if(isdefined(level.archetypes[param_00]))
	{
		var_01 = level.archetypes[param_00]["idle"]["stand"][0];
		var_01 = common_scripts\utility::array_combine(var_01,level.archetypes[param_00]["idle"]["stand"][1]);
		var_02 = level.archetypes[param_00]["idle"]["stand"][0][0];
		self.drone_archetype_custom_idle_base = var_02;
		self.drone_archetype_custom_idles = var_01;
		self.drone_idle_custom = 1;
		self.drone_idle_override = ::drone_archetype_idle_internal;
		thread drone_idle(undefined,undefined);
	}
}

//Function Number: 12
drone_archetype_idle_internal()
{
	self endon("death");
	var_00 = 10;
	if(!isdefined(self.drone_archetype_custom_idles) || !isarray(self.drone_archetype_custom_idles))
	{
		return;
	}

	self clearanim(%body,0.2);
	self stopanimscripted();
	var_01 = 1;
	animscripts\face::playfacialanim(undefined,"idle",undefined);
	for(;;)
	{
		var_02 = common_scripts\utility::random(self.drone_archetype_custom_idles);
		if(randomint(100) < var_00 || var_01)
		{
			self setflaggedanimknoballrestart("drone_anim",var_02,%body,1,0.2,1);
			var_01 = 0;
		}

		self waittillmatch("end","drone_anim");
		self setflaggedanimknoballrestart("drone_anim",self.drone_archetype_custom_idle_base,%body,1,0.2,1);
	}
}

//Function Number: 13
drone_idle(param_00,param_01)
{
	if(isdefined(self.drone_idle_custom))
	{
		[[ self.drone_idle_override ]]();
		return;
	}

	if(isdefined(param_00) && isdefined(param_00["script_noteworthy"]) && isdefined(level.drone_anims[self.team][param_00["script_noteworthy"]]))
	{
		thread drone_fight(param_00["script_noteworthy"],param_00,param_01);
		return;
	}

	if(isdefined(self.idleanim))
	{
		drone_play_looping_anim(self.idleanim,1);
		return;
	}

	drone_play_looping_anim(level.drone_anims[self.team]["stand"]["idle"],1);
}

//Function Number: 14
drone_get_goal_loc_with_arrival(param_00,param_01)
{
	var_02 = param_01["script_noteworthy"];
	if(!isdefined(level.drone_anims[self.team][var_02]["arrival"]))
	{
		return param_00;
	}

	var_03 = getmovedelta(level.drone_anims[self.team][var_02]["arrival"],0,1);
	var_03 = length(var_03);
	param_00 = param_00 - var_03;
	return param_00;
}

//Function Number: 15
drone_fight(param_00,param_01,param_02)
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
			self.weaponsound = "weap_m9_fire_npc";
		}
		else if(var_03 == 2)
		{
			self.weaponsound = "weap_usp45sd_fire_npc";
		}

		if(var_03 == 3)
		{
			self.weaponsound = "weap_pecheneg_fire_npc";
		}
	}
	else
	{
		if(var_03 == 1)
		{
			self.weaponsound = "weap_m9_fire_npc";
		}
		else if(var_03 == 2)
		{
			self.weaponsound = "weap_usp45sd_fire_npc";
		}

		if(var_03 == 3)
		{
			self.weaponsound = "weap_pecheneg_fire_npc";
		}
	}

	self.angles = (0,self.angles[1],self.angles[2]);
	if(param_00 == "coverprone")
	{
		self moveto(self.origin + (0,0,8),0.05);
	}

	self.noragdoll = 1;
	var_04 = level.drone_anims[self.team][param_00];
	self.deathanim = var_04["death"];
	while(isdefined(self))
	{
		drone_play_scripted_anim(var_04["idle"][randomint(var_04["idle"].size)]);
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
				drone_play_scripted_anim(var_04["hide_2_aim"]);
				wait(getanimlength(var_04["hide_2_aim"]) - 0.5);
			}

			if(isdefined(var_04["fire"]))
			{
				if(param_00 == "coverprone" && var_06 == 1)
				{
					thread drone_play_looping_anim(var_04["fire_exposed"],1);
				}
				else
				{
					thread drone_play_looping_anim(var_04["fire"],1);
				}

				drone_fire_randomly();
			}
			else
			{
				drone_shoot();
				wait(0.15);
				drone_shoot();
				wait(0.15);
				drone_shoot();
				wait(0.15);
				drone_shoot();
			}

			if(var_06 == 1)
			{
				drone_play_scripted_anim(var_04["aim_2_hide"]);
			}

			drone_play_scripted_anim(var_04["reload"]);
		}
	}
}

//Function Number: 16
drone_fire_randomly()
{
	self endon("death");
	if(common_scripts\utility::cointoss())
	{
		drone_shoot();
		wait(0.1);
		drone_shoot();
		wait(0.1);
		drone_shoot();
		if(common_scripts\utility::cointoss())
		{
			wait(0.1);
			drone_shoot();
		}

		if(common_scripts\utility::cointoss())
		{
			wait(0.1);
			drone_shoot();
			wait(0.1);
			drone_shoot();
			wait(0.1);
		}

		if(common_scripts\utility::cointoss())
		{
			wait(randomfloatrange(1,2));
			return;
		}

		return;
	}

	drone_shoot();
	wait(randomfloatrange(0.25,0.75));
	drone_shoot();
	wait(randomfloatrange(0.15,0.75));
	drone_shoot();
	wait(randomfloatrange(0.15,0.75));
	drone_shoot();
	wait(randomfloatrange(0.15,0.75));
}

//Function Number: 17
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

//Function Number: 18
drone_shoot_fx()
{
	var_00 = common_scripts\utility::getfx("pdrone_flash_wv");
	if(self.team == "allies")
	{
		var_00 = common_scripts\utility::getfx("pdrone_flash_wv");
	}

	if(isdefined(self.muzzleflashoverride))
	{
		var_00 = common_scripts\utility::getfx(self.muzzleflashoverride);
	}

	if(!isdefined(self.nodroneweaponsound))
	{
		thread drone_play_weapon_sound(self.weaponsound);
	}

	playfxontag(var_00,self,"tag_flash");
}

//Function Number: 19
drone_play_weapon_sound(param_00)
{
	self playsound(param_00);
}

//Function Number: 20
drone_wait_move()
{
	self endon("death");
	self waittill("move");
	thread drone_move();
}

//Function Number: 21
get_anim_data(param_00)
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

	if(isdefined(self.drone_run_speed))
	{
		var_01 = self.drone_run_speed;
	}

	var_06 = spawnstruct();
	var_06.anim_relative = var_02;
	var_06.run_speed = var_01;
	var_06.anim_time = var_03;
	return var_06;
}

//Function Number: 22
drone_get_final_target_node()
{
	var_00 = getpatharray(self.target,self.origin);
	var_01 = var_00[var_00.size - 2]["target"];
	var_02 = getnode(var_01,"targetname");
	if(!isdefined(var_02))
	{
		var_03 = getnodesonpath(var_00[var_00.size - 1]["origin"],var_00[var_00.size - 1]["origin"]);
		var_02 = var_03[var_03.size - 1];
	}

	return var_02;
}

//Function Number: 23
drone_move()
{
	self endon("death");
	self endon("drone_stop");
	wait(0.05);
	var_00 = getpatharray(self.target,self.origin);
	var_01 = level.drone_anims[self.team]["stand"]["run"];
	if(isdefined(self.runanim))
	{
		var_01 = self.runanim;
	}

	var_02 = get_anim_data(var_01);
	var_03 = var_02.run_speed;
	var_04 = var_02.anim_relative;
	if(isdefined(self.drone_move_callback))
	{
		var_02 = [[ self.drone_move_callback ]]();
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
		thread drone_move_z(var_03);
	}

	drone_play_looping_anim(var_01,self.moveplaybackrate);
	var_05 = 0.5;
	var_06 = 0;
	self.started_moving = 1;
	self.cur_node = var_00[var_06];
	var_07 = 0;
	var_08 = undefined;
	for(;;)
	{
		if(!isdefined(var_00[var_06]))
		{
			break;
		}

		var_09 = var_00[var_06]["vec"];
		var_0A = self.origin - var_00[var_06]["origin"];
		var_0B = vectordot(vectornormalize(var_09),var_0A);
		if(!isdefined(var_00[var_06]["dist"]))
		{
			break;
		}

		var_0C = var_0B + level.drone_lookahead_value;
		while(var_0C > var_00[var_06]["dist"])
		{
			var_0C = var_0C - var_00[var_06]["dist"];
			var_06++;
			self.cur_node = var_00[var_06];
			if(isdefined(var_08))
			{
				if(var_06 == 0)
				{
				}

				if(!isdefined(self.beforestairanim))
				{
					self.beforestairanim = self.droneanim;
				}

				var_0D = level.drone_anims[self.team]["stairs"][var_08];
				drone_play_looping_anim(var_0D,self.moveplaybackrate);
				var_07 = 1;
			}

			if(!isdefined(var_00[var_06]["dist"]))
			{
				self rotateto(vectortoangles(var_00[var_00.size - 1]["vec"]),var_05);
				var_0E = distance(self.origin,var_00[var_00.size - 1]["origin"]);
				var_0F = var_0E / var_03 * self.moveplaybackrate;
				var_10 = var_00[var_00.size - 1]["origin"] + (0,0,100);
				var_11 = var_00[var_00.size - 1]["origin"] - (0,0,100);
				var_12 = physicstrace(var_10,var_11);
				if(getdvar("debug_drones") == "1")
				{
					thread common_scripts\utility::draw_line_for_time(var_10,var_11,1,1,1,var_05);
					thread common_scripts\utility::draw_line_for_time(self.origin,var_12,0,0,1,var_05);
				}

				self moveto(var_12,var_0F);
				wait(var_0F);
				self notify("goal");
				thread check_delete();
				thread drone_idle(var_00[var_00.size - 1],var_12);
				return;
			}

			if(!isdefined(var_03[var_09]))
			{
				self notify("goal");
				thread drone_idle();
				return;
			}
		}

		if(isdefined(self.drone_move_callback))
		{
			var_05 = [[ self.drone_move_callback ]]();
			if(isdefined(var_05))
			{
				if(var_05.runanim != var_04)
				{
					var_04 = var_05.runanim;
					var_06 = var_05.run_speed;
					var_07 = var_05.anim_relative;
					if(!var_07)
					{
						thread drone_move_z(var_06);
					}
					else
					{
						self notify("drone_move_z");
					}

					drone_play_looping_anim(var_04,self.moveplaybackrate);
				}
			}
		}

		self.cur_node = var_03[var_09];
		var_11 = var_03[var_09]["vec"] * var_10;
		var_11 = var_11 + var_03[var_09]["origin"];
		var_15 = var_11;
		var_16 = var_15 + (0,0,100);
		var_17 = var_15 - (0,0,100);
		var_15 = physicstrace(var_16,var_17);
		if(!var_07)
		{
			self.drone_look_ahead_point = var_15;
		}

		if(getdvar("debug_drones") == "1")
		{
			thread common_scripts\utility::draw_line_for_time(var_16,var_17,1,1,1,var_08);
			thread draw_point(var_15,1,0,0,16,var_08);
		}

		var_0E = vectortoangles(var_15 - self.origin);
		self rotateto((0,var_0E[1],0),var_08);
		var_0F = var_06 * var_08 * self.moveplaybackrate;
		var_12 = vectornormalize(var_15 - self.origin);
		var_11 = var_12 * var_0F;
		var_11 = var_11 + self.origin;
		if(getdvar("debug_drones") == "1")
		{
			thread common_scripts\utility::draw_line_for_time(self.origin,var_11,0,0,1,var_08);
		}

		self moveto(var_11,var_08);
		wait(var_08);
		if(isdefined(self.cur_node["script_noteworthy"]) && self.cur_node["script_noteworthy"] == "stairs_start_up" || self.cur_node["script_noteworthy"] == "stairs_start_down")
		{
			var_18 = strtok(self.cur_node["script_noteworthy"],"_");
			var_0B = var_18[2];
			continue;
		}

		if(var_0A == 1)
		{
			if(isdefined(self.cur_node["script_noteworthy"]) && self.cur_node["script_noteworthy"] == "stairs_end")
			{
				var_19 = self.beforestairanim;
				drone_play_looping_anim(var_19,self.moveplaybackrate);
				var_0A = 0;
				var_0B = undefined;
			}
		}
	}

	thread drone_idle();
}

//Function Number: 24
drone_move_z(param_00)
{
	self endon("death");
	self endon("drone_stop");
	self notify("drone_move_z");
	self endon("drone_move_z");
	var_01 = 0.05;
	for(;;)
	{
		if(isdefined(self.drone_look_ahead_point) && param_00 > 0)
		{
			var_02 = self.drone_look_ahead_point[2] - self.origin[2];
			var_03 = distance2d(self.drone_look_ahead_point,self.origin);
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

		wait(var_01);
	}
}

//Function Number: 25
getpatharray(param_00,param_01)
{
	var_02 = 1;
	var_03 = [];
	var_03[0]["origin"] = param_01;
	var_03[0]["dist"] = 0;
	var_04 = undefined;
	var_04 = param_00;
	var_05["entity"] = ::maps\_spawner::get_target_ents;
	var_05["node"] = ::maps\_spawner::get_target_nodes;
	var_05["vehicle_node"] = ::maps\_spawner::get_target_vehicle_nodes;
	var_05["struct"] = ::maps\_spawner::get_target_structs;
	var_06 = undefined;
	var_07 = [[ var_05["entity"] ]](var_04);
	var_08 = [[ var_05["node"] ]](var_04);
	var_09 = [[ var_05["vehicle_node"] ]](var_04);
	var_0A = [[ var_05["struct"] ]](var_04);
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
		var_06 = "vehicle_node";
	}
	else if(var_0A.size)
	{
		var_06 = "struct";
	}

	var_0B = var_03.size;
	for(;;)
	{
		var_0C = [[ var_05[var_06] ]](var_04);
		var_0D = common_scripts\utility::random(var_0C);
		if(!isdefined(var_0D))
		{
			break;
		}

		var_0B = var_03.size;
		var_0E = var_0D.origin;
		if(isdefined(var_0D.radius))
		{
			if(!isdefined(self.dronerunoffset))
			{
				self.dronerunoffset = -1 + randomfloat(2);
			}

			if(!isdefined(var_0D.angles))
			{
				var_0D.angles = (0,0,0);
			}

			var_0F = anglestoforward(var_0D.angles);
			var_10 = anglestoright(var_0D.angles);
			var_11 = anglestoup(var_0D.angles);
			var_12 = (0,self.dronerunoffset * var_0D.radius,0);
			var_0E = var_0E + var_0F * var_12[0];
			var_0E = var_0E + var_10 * var_12[1];
			var_0E = var_0E + var_11 * var_12[2];
		}

		var_03[var_0B]["origin"] = var_0E;
		var_03[var_0B]["target"] = var_0D.target;
		if(isdefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isdefined(var_0D.angles))
		{
			var_03[var_0B]["angles"] = var_0D.angles;
		}

		if(isdefined(var_0D.script_noteworthy))
		{
			var_03[var_0B]["script_noteworthy"] = var_0D.script_noteworthy;
		}

		if(isdefined(var_0D.script_linkname))
		{
			var_03[var_0B]["script_linkname"] = var_0D.script_linkname;
		}

		var_03[var_0B - 1]["dist"] = distance(var_03[var_0B]["origin"],var_03[var_0B - 1]["origin"]);
		var_03[var_0B - 1]["vec"] = vectornormalize(var_03[var_0B]["origin"] - var_03[var_0B - 1]["origin"]);
		if(!isdefined(var_03[var_0B - 1]["target"]))
		{
			var_03[var_0B - 1]["target"] = var_0D.targetname;
		}

		if(!isdefined(var_03[var_0B - 1]["script_noteworthy"]) && isdefined(var_0D.script_noteworthy))
		{
			var_03[var_0B - 1]["script_noteworthy"] = var_0D.script_noteworthy;
		}

		if(!isdefined(var_03[var_0B - 1]["script_linkname"]) && isdefined(var_0D.script_linkname))
		{
			var_03[var_0B - 1]["script_linkname"] = var_0D.script_linkname;
		}

		if(!isdefined(var_0D.target))
		{
			break;
		}

		var_04 = var_0D.target;
	}

	if(isdefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isdefined(var_03[var_0B]["angles"]))
	{
		var_03[var_0B]["vec"] = anglestoforward(var_03[var_0B]["angles"]);
	}
	else
	{
		var_03[var_0B]["vec"] = var_03[var_0B - 1]["vec"];
	}

	var_0D = undefined;
	return var_03;
}

//Function Number: 26
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

//Function Number: 27
check_delete()
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
			break;

		case "die_on_goal":
			break;
	}
}