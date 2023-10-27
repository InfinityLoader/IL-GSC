/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\crab_mini\crab_mini_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 1597 ms
 * Timestamp: 10/27/2023 12:01:32 AM
*******************************************************************/

//Function Number: 1
asminit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	analyzeanims();
}

//Function Number: 2
analyzeanims()
{
	var_00 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
	if(!isdefined(var_00.min_moving_pain_dist))
	{
		var_01 = self method_80FD("pain_moving",0);
		var_02 = getmovedelta(var_01,0,1);
		var_00.min_moving_pain_dist = length(var_02);
	}
}

//Function Number: 3
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "moving_melee":
		case "stand_melee":
			return 1;
	}

	return 0;
}

//Function Number: 4
setaction(param_00)
{
	self.requested_action = param_00;
}

//Function Number: 5
clearaction()
{
	self.requested_action = undefined;
}

//Function Number: 6
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 7
playanimandlookatenemy(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\crab_mini\crab_mini_agent::getenemy());
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 8
isanimdone(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_232B(param_01,"end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"early_end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"finish_early"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
ismyenemyinfrontofme(param_00,param_01)
{
	var_02 = vectornormalize(param_00.origin - self.origin * (1,1,0));
	var_03 = anglestoforward(self.angles);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
shouldmeleeattackhit(param_00,param_01,param_02)
{
	if(lib_0F74::func_9DE0(param_00))
	{
		return 1;
	}

	var_03 = distance2dsquared(param_00.origin,self.origin);
	if(var_03 > param_01)
	{
		return 0;
	}

	if(!ismyenemyinfrontofme(param_00,param_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
playmovingmelee(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 12
domeleedamageoncontact(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self endon("DoMeleeDamageOnContact_stop");
	var_02 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
	while(isdefined(param_01) && isalive(param_01))
	{
		if(shouldmeleeattackhit(param_01,var_02.moving_melee_attack_damage_radius_sq,var_02.melee_dot))
		{
			if(randomint(100) < var_02.chance_to_get_stuck_if_hit)
			{
				scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
			}
			else
			{
				scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(0);
			}

			lib_0C73::func_1106E();
			lib_0C73::func_5904(param_01,self.var_B601,"MOD_IMPACT");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
movingmeleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		self method_8282(1,1);
		self notify("DoMeleeDamageOnContact_stop");
		return;
	}

	if(param_00 == "flex_start")
	{
		var_04 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
		if(isdefined(var_04))
		{
			var_05 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
			var_06 = self method_80FD(param_01,param_02);
			var_07 = getnotetracktimes(var_06,"hit");
			var_08 = var_07[0];
			if(var_08 > param_03)
			{
				var_09 = getmovedelta(var_06,param_03,var_08);
				var_0A = length2d(var_09);
				var_0B = getanimlength(var_06);
				var_0C = var_08 * var_0B - param_03 * var_0B;
				var_0D = var_04 getvelocity();
				var_0E = var_04.origin + var_0D * var_0C;
				var_0F = distance(var_0E,self.origin);
				var_10 = 1;
				if(var_0F > var_0A && var_0A > 0)
				{
					var_10 = var_0F / var_0A;
					if(var_10 < 1)
					{
						var_10 = 1;
					}

					var_10 = var_10 + var_05.melee_xy_scale_boost;
					if(var_10 > var_05.melee_max_flex_xy_scale)
					{
						var_10 = var_05.melee_max_flex_xy_scale;
					}
				}
				else
				{
					var_10 = 1 + var_05.melee_xy_scale_boost;
				}

				self method_8282(var_10,1);
				return;
			}

			return;
		}

		return;
	}

	if(var_0C == "check_stuck")
	{
		if(scripts\mp\agents\crab_mini\crab_mini_agent::iscrabministuck())
		{
			lib_0A1A::func_2330(var_0D,"end");
			return;
		}

		return;
	}
}

//Function Number: 14
meleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		self method_8282(1,1);
		var_04 = scripts\mp\agents\crab_mini\crab_mini_agent::getenemy();
		if(isdefined(var_04))
		{
			var_05 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
			if(shouldmeleeattackhit(var_04,var_05.melee_attack_damage_radius_sq,var_05.melee_dot))
			{
				self notify("attack_hit",var_04);
				lib_0C73::func_5904(var_04,self.var_B601,"MOD_IMPACT");
			}
			else
			{
				self notify("attack_miss",var_04);
			}
		}

		if(!scripts\common\utility::istrue(self.bmovingmelee))
		{
			self notify("stop_melee_face_enemy");
		}
	}
}

//Function Number: 15
timetogetstuck(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.btimetogetstuck))
	{
		self.btimetogetstuck = undefined;
		return 1;
	}

	return 0;
}

//Function Number: 16
terminate_movingmelee(param_00,param_01,param_02)
{
	self.btimetogetstuck = undefined;
}

//Function Number: 17
shouldabortaction(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		return 0;
	}

	if(!isdefined(self.requested_action))
	{
		return 1;
	}

	if(isdefined(param_03))
	{
		if(self.requested_action != param_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 18
shoulddoaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(self.requested_action == param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 20
stopfacingenemy(param_00,param_01)
{
	self endon(param_00 + "_finished");
	wait(param_01);
	lib_0C73::func_1106E();
}

//Function Number: 21
playmovingmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getanimlength(var_05);
	var_07 = getnotetracktimes(var_05,"hit");
	var_08 = var_06 * var_07[0];
	var_09 = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
	var_0A = randomfloatrange(var_09.min_stop_facing_enemy_time_before_hit,var_09.max_stop_facing_enemy_time_before_hit);
	var_0B = var_08 - var_0A;
	if(var_0B < 0)
	{
		var_0B = 0.1;
	}

	if(randomint(100) < var_09.chance_to_get_stuck_if_miss)
	{
		scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(1);
	}
	else
	{
		scripts\mp\agents\crab_mini\crab_mini_agent::setisstuck(0);
	}

	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	thread stopfacingenemy(param_01,var_0B);
	thread domeleedamageoncontact(param_01,self.var_4B26);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 22
playmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 23
choosemeleeattack(param_00,param_01,param_02)
{
	self.meleeattackanimindex = randomintrange(0,self method_8100(param_01));
	return self.meleeattackanimindex;
}

//Function Number: 24
choosestuckanim(param_00,param_01,param_02)
{
	return self.meleeattackanimindex;
}

//Function Number: 25
isstuckdone(param_00,param_01,param_02,param_03)
{
	return !scripts\common\utility::istrue(self.bisstuck);
}

//Function Number: 26
shoulddostuckanim(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.bisstuck);
}

//Function Number: 27
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 28
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233) || self method_841E() < scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata().min_moving_pain_dist)
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,1);
		return;
	}

	lib_0A1D::func_2364(param_01,param_02,param_03,var_04);
}

//Function Number: 29
doteleporthack(param_00,param_01,param_02,param_03)
{
	var_06 = self method_8146();
	self setorigin(var_06,0);
	var_06 = getgroundposition(var_06,15);
	self.var_9CEC = undefined;
	self notify("traverse_end");
	lib_0A1A::func_237C("decide_idle",param_03);
}

//Function Number: 30
shouldturn(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.desiredyaw))
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
choosecrabminiturnanim(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = abs(self.desiredyaw);
	if(self.desiredyaw < 0)
	{
		if(var_04 < 67.5)
		{
			var_03 = 9;
		}
		else if(var_04 < 112.5)
		{
			var_03 = 6;
		}
		else if(var_04 < 157.5)
		{
			var_03 = 3;
		}
		else
		{
			var_03 = "2r";
		}
	}
	else if(self.desiredyaw < 67.5)
	{
		var_03 = 7;
	}
	else if(self.desiredyaw < 112.5)
	{
		var_03 = 4;
	}
	else if(self.desiredyaw < 157.5)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = "2l";
	}

	self.desiredyaw = undefined;
	return lib_0A1A::func_2358(param_01,var_03);
}