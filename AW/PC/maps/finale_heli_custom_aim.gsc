/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_heli_custom_aim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 338 ms
 * Timestamp: 4/22/2024 2:29:16 AM
*******************************************************************/

//Function Number: 1
start_heli_custom_aim(param_00)
{
	thread select_target_think(param_00);
	thread aim_additives_think(param_00);
}

//Function Number: 2
select_target_think(param_00)
{
	self endon("death");
	self endon(param_00);
	var_01 = getaiarray("axis");
	var_02 = 0;
	self.enemy_custom = var_01[var_02];
	var_03 = 0.25;
	var_04 = self.enemy_custom;
	for(;;)
	{
		if(!isalive(var_04))
		{
			self.enemy_custom = undefined;
			self.enemy_custom_fire_ok_time = gettime() + randomfloatrange(0.15,0.35) * 1000;
		}

		var_05 = getaiarray("axis");
		var_06 = maps\_utility::getvehiclearray();
		foreach(var_08 in var_06)
		{
			if(isdefined(var_08.script_team) && var_08.script_team == "axis")
			{
				var_05[var_05.size] = var_08;
			}
		}

		var_05 = maps\_utility::array_removedead(var_05);
		var_0A = [];
		for(var_0B = 0;var_0B < var_05.size;var_0B++)
		{
			var_0C = var_05[var_0B];
			if(isdefined(var_0C.vehicle_position))
			{
				continue;
			}

			if(distancesquared(self.origin,var_0C.origin) > 5000000)
			{
				continue;
			}

			if(!self canshoot(var_0C getcentroid()))
			{
				continue;
			}

			if(!within_angle(var_0C,self.rightaimlimit,self.leftaimlimit,self.upaimlimit,self.downaimlimit))
			{
				continue;
			}

			var_0A[var_0A.size] = var_0C;
		}

		var_0D = -1;
		var_0E = 9999999;
		for(var_0B = 0;var_0B < var_0A.size;var_0B++)
		{
			if(length(self.origin - var_0A[var_0B].origin) < var_0E)
			{
				var_0D = var_0B;
				var_0E = length(self.origin - var_0A[var_0B].origin);
			}
		}

		if(var_0D > -1)
		{
			self.enemy_custom = var_0A[var_0D];
		}

		var_04 = self.enemy_custom;
		wait(var_03);
	}
}

//Function Number: 3
within_angle(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = get_diff_angles_from_facing(param_00);
	var_06 = var_05[0];
	var_07 = var_05[1];
	if(var_07 >= param_01 && var_07 <= param_02 && var_06 >= param_03 && var_06 <= param_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
gettagangles_c(param_00)
{
	var_01 = self gettagangles(param_00);
	if(param_00 == "TAG_SYNC")
	{
		var_01 = combineangles(var_01,(0,180,0));
	}

	return var_01;
}

//Function Number: 5
get_world_pitch_yaw_between_vectors(param_00,param_01)
{
	param_00 = vectornormalize(param_00);
	var_02 = angleclamp360(param_00[0],param_00[1]);
	var_03 = asin(param_00[2]);
	param_01 = vectornormalize(param_01);
	var_04 = angleclamp360(param_01[0],param_01[1]);
	var_05 = asin(param_01[2]);
	var_06 = param_01 - param_00;
	var_07 = angleclamp360(var_06[0],var_06[1]);
	var_08 = asin(var_06[2]);
	return [var_05 - var_03,var_04 - var_02];
}

//Function Number: 6
get_diff_angles_from_facing(param_00,param_01)
{
	return get_diff_angles_from_tag_to_guy("J_gun","TAG_SYNC",param_00,param_01);
}

//Function Number: 7
get_diff_angles_from_gun(param_00,param_01)
{
	return get_diff_angles_from_tag_to_guy("TAG_FLASH","TAG_FLASH",param_00,param_01);
}

//Function Number: 8
get_diff_angles_from_tag_to_guy(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = (0.3,0,0);
	var_05 = (1,0,0);
	var_06 = param_02 quarter_up_position();
	var_07 = self gettagorigin(param_00);
	var_08 = gettagangles_c(param_01);
	var_09 = anglestoforward(var_08);
	var_0A = var_06 - var_07;
	var_0B = vectortoangles(var_0A);
	var_0C = rotatevectorinverted(var_09,var_0B);
	var_0D = anglestoforward((0,0,0));
	var_0E = get_world_pitch_yaw_between_vectors(var_0D,var_0C);
	var_0F = var_0E[0];
	var_10 = var_0E[1];
	return [var_0F,var_10];
}

//Function Number: 9
ender_cleanup(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self waittill(param_05);
	self clearanim(param_00,0);
	self clearanim(param_01,0);
	self clearanim(param_02,0);
	self clearanim(param_03,0);
	self clearanim(param_04,0);
}

//Function Number: 10
rotate_to_goal(param_00,param_01,param_02,param_03)
{
	if(param_01 > param_00 + 0.5)
	{
		param_00 = param_00 + 0.5;
	}
	else if(param_01 < param_00 - 0.5)
	{
		param_00 = param_00 - 0.5;
	}
	else
	{
		param_00 = param_01;
	}

	if(param_03 > param_02 + 0.5)
	{
		param_02 = param_02 + 0.5;
	}
	else if(param_03 < param_02 - 0.5)
	{
		param_02 = param_02 - 0.5;
	}
	else
	{
		param_02 = param_03;
	}

	return [param_00,param_02];
}

//Function Number: 11
rotate_until_no_diff(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = 0;
	if(abs(param_03) < 5)
	{
		if(param_01 > 0)
		{
			var_04 = param_01 * 0.1;
		}
		else
		{
			var_04 = param_01 * 0.1;
		}

		param_00 = param_00 + var_04;
	}

	if(param_03 > 0)
	{
		var_05 = param_03 * 0.1;
	}
	else
	{
		var_05 = param_03 * 0.1;
	}

	param_02 = param_02 + var_05;
	if(param_00 < self.upaimlimit)
	{
		param_00 = self.upaimlimit;
	}

	if(param_00 > self.downaimlimit)
	{
		param_00 = self.downaimlimit;
	}

	if(param_02 > self.leftaimlimit)
	{
		param_02 = self.leftaimlimit;
	}

	if(param_02 < self.rightaimlimit)
	{
		param_02 = self.rightaimlimit;
	}

	return [param_00,param_02];
}

//Function Number: 12
quarter_up_position()
{
	var_00 = self getcentroid()[2] - self.origin[2];
	return (self.origin[0],self.origin[1],self.origin[2] + var_00 * 0.5);
}

//Function Number: 13
get_shoot_pos_with_offset()
{
	var_00 = quarter_up_position();
	if(isdefined(self.vehicletype) && self.vehicletype == "diveboat_ai")
	{
		var_01 = randomfloatrange(-70,-50);
		var_02 = randomfloatrange(-70,-50);
		var_03 = 0;
		var_00 = var_00 + (var_01,var_02,var_03);
	}

	return var_00;
}

//Function Number: 14
heli_custom_fireuntiloutofammo(param_00,param_01,param_02)
{
	self.heli_action_status = 1;
	self setanimlimited(param_00,1,0);
	self.shootstyle = "full";
	self.shootpos = self.enemy_custom get_shoot_pos_with_offset();
	self.fastburst = 0;
	self.shootent = undefined;
	animscripts\combat_utility::fireuntiloutofammo(param_01,0,100);
	self clearanim(param_01,0);
	if(need_to_reload())
	{
		heli_custom_reload(param_00,param_02);
	}

	self.heli_action_status = 0;
}

//Function Number: 15
need_to_reload()
{
	if(self.bulletsinclip <= 0)
	{
		return 1;
	}

	var_00 = self.bulletsinclip / weaponclipsize(self.weapon);
	var_01 = weaponclipsize(self.weapon) - self.bulletsinclip;
	var_02 = getdvarfloat("cg_fov");
	if(var_00 < 0.75 || var_01 > 50 && randomfloat(100) < 100 - min(100,var_01) && level.player worldpointinreticle_circle(self.origin,var_02,250))
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
heli_custom_reload(param_00,param_01)
{
	self.heli_action_status = 2;
	self setanimlimited(param_00,1,0);
	var_02 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
	self setflaggedanimknobrestart(var_02,param_01,1,0.2);
	animscripts\shared::donotetracks(var_02);
	self notify("abort_reload");
	animscripts\weaponlist::refillclip();
	self clearanim(param_01,0);
	self.heli_action_status = 0;
}

//Function Number: 17
aim_additives_think(param_00)
{
	self endon("death");
	self endon(param_00);
	var_01 = %fin_flying_mech_aim_6;
	var_02 = %fin_flying_mech_firing_right;
	var_03 = %fin_flying_mech_aim_4;
	var_04 = %fin_flying_mech_firing_left;
	var_05 = %fin_flying_mech_aim_8;
	var_06 = %fin_flying_mech_firing_aim_up;
	var_07 = %fin_flying_mech_aim_2;
	var_08 = %fin_flying_mech_firing_down;
	var_09 = %fin_flying_mech_action_root;
	var_0A = %fin_flying_mech_firing_fire_auto;
	var_0B = %fin_flying_mech_firing_reload;
	var_0C = get_aim_limits(var_01,var_03,var_05,var_07,var_02,var_04,var_06,var_08,1);
	var_0D = var_0C[0];
	var_0E = var_0C[1];
	var_0F = var_0C[2];
	var_10 = var_0C[3];
	self.rightaimlimit = var_0D;
	self.leftaimlimit = var_0E;
	self.upaimlimit = var_0F;
	self.downaimlimit = var_10;
	thread ender_cleanup(var_01,var_03,var_05,var_07,var_09,param_00);
	self setanim(var_03,0.01,0);
	self setanim(var_04,1,0);
	self setanimtime(var_04,1);
	self setanim(var_01,0.01,0);
	self setanim(var_02,1,0);
	self setanimtime(var_02,1);
	self setanim(var_07,0.01,0);
	self setanim(var_08,1,0);
	self setanimtime(var_08,1);
	self setanim(var_05,0.01,0);
	self setanim(var_06,1,0);
	self setanimtime(var_06,1);
	var_11 = 0;
	var_12 = 0;
	var_13 = 0;
	var_14 = 0;
	var_15 = 999;
	var_16 = 999;
	self.heli_action_status = 0;
	self.enemy_custom_fire_ok_time = 0;
	var_17 = 0.1;
	if(isdefined(self.aimblendtime))
	{
		var_17 = self.aimblendtime;
	}

	for(;;)
	{
		if(isdefined(self.enemy_custom))
		{
			var_18 = get_diff_angles_from_gun(self.enemy_custom,0);
			var_15 = var_18[0];
			var_16 = var_18[1];
		}
		else
		{
			var_15 = 0;
			var_16 = 0;
		}

		if(isdefined(self.enemy_custom) && gettime() > self.enemy_custom_fire_ok_time && abs(var_15) < 10 && abs(var_16) < 10)
		{
			if(self.heli_action_status == 0)
			{
				childthread heli_custom_fireuntiloutofammo(var_09,var_0A,var_0B);
			}
		}
		else if(self.heli_action_status == 1)
		{
			self notify("enemy");
			if(self getanimweight(var_0A) > 0)
			{
				self clearanim(var_0A,0);
			}

			self.heli_action_status = 0;
		}

		if(self.heli_action_status != 2)
		{
			if(abs(var_15) > 0 || abs(var_16) > 0)
			{
				var_19 = rotate_until_no_diff(var_14,var_15,var_13,var_16);
				var_14 = var_19[0];
				var_13 = var_19[1];
			}

			if(isdefined(var_14))
			{
				if(var_14 == 0)
				{
					self setanim(var_07,0.001,0.05,1,1);
					self setanim(var_05,0.001,0.05,1,1);
				}
				else if(var_14 < 0)
				{
					self setanim(var_07,0.001,0.05,1,1);
					self setanim(var_05,absz(var_14 / self.upaimlimit),0.05,1,1);
				}
				else
				{
					self setanim(var_07,absz(var_14 / self.downaimlimit),0.05,1,1);
					self setanim(var_05,0.001,0.05,1,1);
				}
			}

			if(isdefined(var_13))
			{
				if(var_13 == 0)
				{
					self setanim(var_03,0.001,0.05,1,1);
					self setanim(var_01,0.001,0.05,1,1);
				}
				else if(var_13 > 0)
				{
					self setanim(var_03,absz(var_13 / self.leftaimlimit),0.05,1,1);
					self setanim(var_01,0.001,0.05,1,1);
				}
				else
				{
					self setanim(var_03,0.001,0.05,1,1);
					self setanim(var_01,absz(var_13 / self.rightaimlimit),0.05,1,1);
				}
			}
		}

		self setanimtime(var_02,1);
		self setanimtime(var_04,1);
		self setanimtime(var_06,1);
		self setanimtime(var_08,1);
		wait 0.05;
	}
}

//Function Number: 18
absz(param_00)
{
	param_00 = abs(param_00);
	if(param_00 > 1)
	{
		param_00 = 1;
	}

	if(param_00 == 0)
	{
		return 0.001;
	}

	return param_00;
}

//Function Number: 19
get_aim_limits(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = 1;
	var_0A = get_limit_table(param_00,param_04,1,param_08,var_09);
	var_0B = get_limit_table(param_01,param_05,1,param_08,var_09);
	var_0C = get_limit_table(param_02,param_06,0,param_08,var_09);
	var_0D = get_limit_table(param_03,param_07,0,param_08,var_09);
	var_0E = float(getfirstarraykey(var_0A));
	var_0F = float(getfirstarraykey(var_0B));
	var_10 = float(getfirstarraykey(var_0C));
	var_11 = float(getfirstarraykey(var_0D));
	self.dummy_model delete();
	return [var_0E,var_0F,var_10,var_11];
}

//Function Number: 20
get_limit(param_00,param_01,param_02,param_03,param_04)
{
	return get_limit_table(param_00,param_01,param_02,param_03,1);
}

//Function Number: 21
get_limit_table(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	if(!isdefined(param_03) || param_03)
	{
		if(!isdefined(self.dummy_model))
		{
			self.dummy_model = maps\_utility::spawn_anim_model(self.animname,(0,-300,0),(0,0,0));
			if(isdefined(self.weapon))
			{
				var_06 = getweaponmodel(self.weapon);
				self.dummy_model attach(var_06,"tag_weapon_right");
				self.dummy_model maps\_utility::update_weapon_tag_visibility(self.weapon);
			}

			if(param_04)
			{
				self.dummy_model hide();
			}

			self.dummy_model thread maps\_anim::anim_first_frame_solo(self.dummy_model,"intro_flyin_idle_test");
		}

		var_05 = self.dummy_model;
	}
	else
	{
		var_05 = self;
	}

	var_07 = 0.025;
	var_08 = [];
	var_09 = 0;
	var_0A = 1;
	if(!isdefined(param_01) || !isdefined(param_00))
	{
		var_08["0"] = 0;
		var_08["1"] = 0;
		return var_08;
	}

	var_05 setanimlimited(param_00,1,0);
	var_05 setanimknoblimited(param_01,1,0);
	var_05 setanimtime(param_01,1);
	while(var_0A >= 0)
	{
		var_05 setanimlimited(param_00,var_0A,0);
		wait 0.05;
		var_0B = var_05 gettagangles("TAG_FLASH");
		var_0C = var_05.angles;
		var_0D = invertangles(var_0C);
		var_0E = combineangles(var_0B,var_0D);
		var_08[maps\_utility::string(angleclamp180(var_0E[param_02]))] = var_0A;
		var_0A = 1 - var_09 * var_07;
		var_09++;
		if(param_04)
		{
			break;
		}
	}

	var_05 clearanim(param_00,0);
	return var_08;
}