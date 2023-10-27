/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_chopperboss.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 328 ms
 * Timestamp: 10/27/2023 2:21:06 AM
*******************************************************************/

//Function Number: 1
chopper_boss_load_fx()
{
	level._effect["chopper_boss_light_smoke"] = loadfx("smoke/smoke_trail_white_heli");
	level._effect["chopper_boss_heavy_smoke"] = loadfx("smoke/smoke_trail_black_heli");
}

//Function Number: 2
chopper_boss_locs_populate(param_00,param_01)
{
	level.chopper_boss_locs = common_scripts\utility::getstructarray(param_01,param_00);
	foreach(var_03 in level.chopper_boss_locs)
	{
		var_03.neighbors = var_03 maps\_utility::get_linked_structs();
		foreach(var_05 in level.chopper_boss_locs)
		{
			if(var_03 == var_05)
			{
				continue;
			}

			if(!maps\_utility::array_contains(var_03.neighbors,var_05) && maps\_utility::array_contains(var_05 maps\_utility::get_linked_structs(),var_03))
			{
				var_03.neighbors[var_03.neighbors.size] = var_05;
			}
		}
	}
}

//Function Number: 3
chopper_path_release(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = strtok(param_01," ");
		foreach(var_04 in var_02)
		{
			self endon(var_04);
		}
	}

	var_06 = strtok(param_00," ");
	switch(var_06.size)
	{
		case 1:
			self waittill(var_06[0]);
			break;

		case 2:
			common_scripts\utility::waittill_either(var_06[0],var_06[1]);
			break;

		case 3:
			common_scripts\utility::waittill_any(var_06[0],var_06[1],var_06[2]);
			break;

		case 4:
			common_scripts\utility::waittill_any(var_06[0],var_06[1],var_06[2],var_06[3]);
			break;

		default:
			break;
	}

	self.loc_current.in_use = undefined;
}

//Function Number: 4
chopper_boss_behavior_little_bird(param_00)
{
	self endon("death");
	self endon("deathspin");
	level endon("special_op_terminated");
	self.loc_current = param_00;
	self.loc_current.in_use = 1;
	chopper_boss_setup();
	thread chopper_boss_damage_states();
	thread chopper_event_on_death();
	var_01 = 0;
	for(;;)
	{
		self.heli_target = undefined;
		var_02 = (isdefined(self.request_move) && self.request_move) || var_01;
		while(isdefined(level.chopper_boss_finding_target) && level.chopper_boss_finding_target == 1)
		{
			wait 0.05;
		}

		var_03 = chopper_boss_get_best_location_and_target(var_02);
		if(isdefined(var_03) && self.loc_current != var_03)
		{
			if(isdefined(self.heli_target))
			{
				self setlookatent(self.heli_target);
			}
			else
			{
				var_04 = maps\_utility::getclosest(self.origin,level.players);
				if(isdefined(var_04))
				{
					self setlookatent(var_04);
				}
			}

			self.request_move = undefined;
			thread chopper_boss_move(var_03);
			self waittill("reached_dynamic_path_end");
		}

		if(isdefined(self.heli_target))
		{
			var_01 = chopper_boss_attempt_firing(self.heli_target);
		}

		wait 0.1;
	}
}

//Function Number: 5
chopper_boss_setup()
{
	maps\_vehicle::mgoff();
	chopper_boss_sentient();
	maps\_utility::add_damagefeedback();
	self.mgturret[1] unlink();
	self.mgturret[1] delete();
	var_00 = self.mgturret[0];
	var_00 unlink();
	var_00 linkto(self,"tag_turret",(0,0,0),(0,0,0));
	var_00 setleftarc(45);
	var_00 setrightarc(45);
	var_00 settoparc(45);
	var_00 setbottomarc(55);
	var_00 setdefaultdroppitch(-10);
	self.mgturret = [];
	self.mgturret[self.mgturret.size] = var_00;
}

//Function Number: 6
chopper_event_on_death()
{
	self waittill("death",var_00);
	if(!isdefined(self))
	{
		return;
	}

	if(maps\_utility::is_survival())
	{
		playfx(level._effect["money"],self.origin + (0,0,-32));
	}
}

//Function Number: 7
chopper_boss_damage_states()
{
	self endon("death");
	self endon("deathspin");
	var_00 = self.health - self.healthbuffer;
	var_01 = 0;
	for(;;)
	{
		var_02 = self.health - self.healthbuffer;
		if(var_02 <= var_00 * 0.5)
		{
			if(var_01 == 1)
			{
				var_01 = 2;
				self.request_move = 1;
			}

			playfxontag(common_scripts\utility::getfx("chopper_boss_heavy_smoke"),self,"tag_engine");
		}
		else if(var_02 <= var_00 * 0.75)
		{
			if(var_01 == 0)
			{
				var_01 = 1;
				self.request_move = 1;
			}

			playfxontag(common_scripts\utility::getfx("chopper_boss_light_smoke"),self,"tag_engine");
		}

		wait 0.05;
	}
}

//Function Number: 8
chopper_boss_can_hit_from(param_00,param_01)
{
	var_02 = self.mgturret[0].origin[2] - self.origin[2];
	return bullettracepassed(param_00 + (0,0,var_02),param_01,0,self);
}

//Function Number: 9
chopper_boss_in_range(param_00)
{
	var_01 = distance2d(self.origin,param_00);
	var_02 = 384;
	if(isdefined(level.chopper_boss_min_dist2d))
	{
		var_02 = level.chopper_boss_min_dist2d;
	}

	return var_01 >= var_02 && var_01 <= 3072;
}

//Function Number: 10
chopper_boss_set_target(param_00)
{
	if(isdefined(param_00))
	{
		self.heli_target = param_00;
	}
}

//Function Number: 11
chopper_boss_attempt_firing(param_00)
{
	self endon("deathspin");
	self endon("death");
	var_01 = 0;
	if(isdefined(param_00) && !isdefined(param_00.heli_shooting) && chopper_boss_in_range(param_00.origin))
	{
		thread chopper_boss_manage_shooting_flag(self.heli_target);
		self setlookatent(param_00);
		var_02 = chopper_boss_wait_face_target(param_00,5);
		if(isdefined(param_00))
		{
			if(isdefined(var_02) && var_02)
			{
				chopper_boss_fire_turrets(param_00);
				var_01 = 1;
			}
		}

		self notify("chopper_done_shooting");
	}

	return var_01;
}

//Function Number: 12
chopper_boss_manage_shooting_flag(param_00)
{
	param_00.heli_shooting = 1;
	common_scripts\utility::waittill_any("death","deathspin","chopper_done_shooting");
	if(isdefined(param_00))
	{
		param_00.heli_shooting = undefined;
	}
}

//Function Number: 13
chopper_boss_wait_face_target(param_00,param_01)
{
	self endon("death");
	self endon("deathspin");
	param_00 endon("death");
	var_02 = undefined;
	if(isdefined(param_01))
	{
		var_02 = gettime() + param_01 * 1000;
	}

	while(isdefined(param_00))
	{
		if(maps\_utility::within_fov_2d(self.origin,self.angles,param_00.origin,0))
		{
			return 1;
		}

		if(isdefined(var_02) && gettime() >= var_02)
		{
			return 0;
		}

		wait 0.25;
	}
}

//Function Number: 14
chopper_boss_fire_turrets(param_00)
{
	self endon("deathspin");
	self endon("death");
	param_00 endon("death");
	var_01 = 20;
	foreach(var_03 in self.mgturret)
	{
		if(isai(param_00))
		{
			var_03 settargetentity(param_00,param_00 geteye() - param_00.origin);
		}
		else if(isplayer(param_00))
		{
			if(maps\_utility::is_player_down(param_00))
			{
				var_01 = 60;
				var_03 settargetentity(param_00);
			}
			else
			{
				var_03 settargetentity(param_00,param_00 geteye() - param_00.origin);
			}
		}
		else
		{
			var_03 settargetentity(param_00,(0,0,32));
		}

		var_03 startbarrelspin();
	}

	wait 2;
	var_05 = weaponfiretime("minigun_littlebird_spinnup");
	var_06 = 0;
	for(var_07 = 0;var_07 < var_01;var_07++)
	{
		self.mgturret[var_06] shootturret();
		var_06++;
		if(var_06 >= self.mgturret.size)
		{
			var_06 = 0;
		}

		wait var_05 + 0.05;
	}

	wait 1;
	foreach(var_03 in self.mgturret)
	{
		var_03 stopbarrelspin();
	}
}

//Function Number: 15
chopper_boss_manage_targeting_flag()
{
	level.chopper_boss_finding_target = 1;
	common_scripts\utility::waittill_any("death","deathspin","chopper_done_targeting");
	level.chopper_boss_finding_target = undefined;
}

//Function Number: 16
chopper_boss_get_best_location_and_target(param_00)
{
	self endon("death");
	var_01 = self.loc_current.neighbors;
	if(!isdefined(param_00) || param_00 == 0)
	{
	}

	thread chopper_boss_manage_targeting_flag();
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(!maps\_utility::is_player_down(var_04) && !isdefined(var_04.ignoreme) || var_04.ignoreme == 0)
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_06 = getaiarray("allies");
	foreach(var_08 in var_06)
	{
		if(!isdefined(var_08.ignoreme) || var_08.ignoreme == 0)
		{
			var_02[var_02.size] = var_08;
		}
	}

	if(isdefined(level.placed_sentry))
	{
		foreach(var_0B in level.placed_sentry)
		{
			if(!isdefined(var_0B.ignoreme) || var_0B.ignoreme == 0)
			{
				var_02[var_02.size] = var_0B;
			}
		}
	}

	if(!var_02.size)
	{
		foreach(var_04 in level.players)
		{
			if(!maps\_utility::is_player_down_and_out(var_04) && !isdefined(var_04.ignoreme) || var_04.ignoreme == 0)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	var_0F = [];
	var_10 = 0;
	foreach(var_12 in var_7B)
	{
		if(var_12 != self.loc_current && isdefined(var_12.in_use))
		{
			continue;
		}

		var_12.heli_target = undefined;
		var_12.dist2d = undefined;
		var_13 = undefined;
		foreach(var_15 in var_02)
		{
			if(!isdefined(var_15))
			{
				continue;
			}

			if(var_12 chopper_boss_in_range(var_15.origin) == 0)
			{
				continue;
			}

			var_16 = var_15.origin + (0,0,64);
			if(isai(var_15) || isplayer(var_15))
			{
				var_16 = var_15 geteye();
			}

			if(chopper_boss_can_hit_from(var_12.origin,var_16))
			{
				if(!isdefined(var_12.heli_target))
				{
					var_0F[var_0F.size] = var_12;
					var_12.heli_target = var_15;
					var_13 = distance2d(var_12.origin,var_15.origin);
				}
				else
				{
					var_17 = distance2d(var_12.origin,var_15.origin);
					if(var_17 < var_13)
					{
						var_12.heli_target = var_15;
						var_13 = var_17;
					}
				}
			}

			var_10++ = var_7B[var_01.size];
			if(var_10 >= 4)
			{
				wait 0.05;
				var_10 = 0;
			}
		}
	}

	if(var_0F.size)
	{
		var_1A = [];
		foreach(var_12 in var_0F)
		{
			if(isdefined(var_12.heli_target))
			{
				var_1A[var_1A.size] = var_12;
			}
		}

		var_0F = var_1A;
	}

	if(!var_0F.size)
	{
		foreach(var_12 in var_7B)
		{
			if(var_12 != self.loc_current && isdefined(var_12.in_use))
			{
				continue;
			}

			var_1E = undefined;
			foreach(var_15 in var_02)
			{
				if(!isdefined(var_15))
				{
					continue;
				}

				if(!isdefined(var_1E))
				{
					var_1E = var_15;
					var_12.dist2d = distance2d(var_12.origin,var_15.origin);
					continue;
				}

				var_20 = distance2d(var_12.origin,var_15.origin);
				if(var_20 < var_12.dist2d)
				{
					var_1E = var_15;
					var_12.dist2d = var_20;
				}
			}

			if(isdefined(var_12.dist2d))
			{
				var_0F[var_0F.size] = var_12;
			}
		}
	}
	else
	{
		foreach(var_12 in var_0F)
		{
			var_12.dist2d = distance2d(var_12.heli_target.origin,var_12.origin);
		}
	}

	var_25 = maps\_utility_joec::exchange_sort_by_handler(var_0F,::chopper_boss_loc_compare);
	var_26 = undefined;
	var_27 = 0;
	foreach(var_12 in var_25)
	{
		var_29 = 384;
		if(isdefined(level.chopper_boss_min_dist2d))
		{
			var_29 = level.chopper_boss_min_dist2d;
		}

		if(var_12.dist2d >= var_29 && var_12.dist2d <= 3072)
		{
			var_26 = var_12;
			var_27 = 1;
			break;
		}
	}

	if(!isdefined(var_26) && var_25.size)
	{
		var_26 = var_25[0];
	}

	if(isdefined(var_26) && isdefined(var_26.heli_target))
	{
		chopper_boss_set_target(var_26.heli_target);
	}

	self notify("chopper_done_targeting",self.loc_current);
	if(isdefined(var_26) && var_26 != self.loc_current)
	{
		return var_26;
	}

	return undefined;
}

//Function Number: 17
chopper_boss_loc_compare()
{
	return self.dist2d;
}

//Function Number: 18
chopper_boss_move(param_00)
{
	self.loc_current.in_use = undefined;
	self.loc_current = param_00;
	self.loc_current.in_use = 1;
	thread maps\_vehicle::vehicle_paths(param_00);
}

//Function Number: 19
chopper_boss_sentient()
{
	self makeentitysentient("axis",1);
	self.attackeraccuracy = 6;
	self.maxvisibledist = 3072;
	self.threatbias = 10000;
}