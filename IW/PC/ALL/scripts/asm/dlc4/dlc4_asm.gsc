/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\dlc4\dlc4_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 2660 ms
 * Timestamp: 10/27/2023 12:01:36 AM
*******************************************************************/

//Function Number: 1
gettunedata()
{
	return level.agenttunedata[self.agent_type];
}

//Function Number: 2
getanimmovedeltadist(param_00)
{
	var_01 = self method_80FD(param_00,0);
	var_02 = getmovedelta(var_01,0,1);
	var_03 = length2d(var_02);
	return var_03;
}

//Function Number: 3
analyzeanims()
{
	var_00 = gettunedata();
	if(!isdefined(var_00.min_moving_pain_dist))
	{
		var_01 = self method_80FD("pain_moving",0);
		var_02 = getmovedelta(var_01,0,1);
		var_00.min_moving_pain_dist = length(var_02);
		var_00.arrivalanimdist = [];
		var_00.arrivalanimdist["run_stop"] = getanimmovedeltadist("run_stop");
		var_00.arrivalanimdist["sprint_stop"] = getanimmovedeltadist("sprint_stop");
		var_00.movingattackdisttoattack = [];
		var_03 = self method_8100("moving_melee");
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_01 = self method_80FD("moving_melee",var_04);
			var_05 = getnotetracktimes(var_01,"start_melee");
			var_02 = getmovedelta(var_01,0,var_05[0]);
			var_00.movingattackdisttoattacksq[var_04] = length2dsquared(var_02);
		}
	}
}

//Function Number: 4
choosespawnanim(param_00,param_01,param_02)
{
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ECF5))
	{
		var_03 = "";
		switch(self.var_1F5)
		{
			case "walk":
			case "slow_walk":
				var_03 = "_walk";
				break;

			case "run":
			case "sprint":
				var_03 = "_run";
				break;

			default:
				break;
		}

		if(lib_0A1D::func_2347(param_01,self.spawner.var_ECF5 + var_03))
		{
			return lib_0A1A::func_2358(param_01,self.spawner.var_ECF5 + var_03);
		}
		else if(lib_0A1D::func_2347(param_01,self.spawner.var_ECF5))
		{
			return lib_0A1A::func_2358(param_01,self.spawner.var_ECF5);
		}
	}

	if(!isdefined(param_02))
	{
		return lib_0F3C::func_3EF4(param_00,param_01,param_02);
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 5
setasmaction(param_00)
{
	if(isdefined(self.fnactionvalidator))
	{
	}

	self.requested_action = param_00;
	self.current_action = undefined;
}

//Function Number: 6
clearasmaction()
{
	self.requested_action = undefined;
	self.current_action = undefined;
}

//Function Number: 7
shoulddoaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(self.requested_action == param_02)
	{
		if(isdefined(self.current_action) && self.current_action == param_02)
		{
			return 0;
		}

		self.current_action = param_02;
		return 1;
	}

	return 0;
}

//Function Number: 8
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

//Function Number: 9
playanimandlookatenemy(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,getenemy());
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_C081);
}

//Function Number: 10
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

//Function Number: 11
ismyenemyinfrontofme(param_00,param_01)
{
	var_02 = vectornormalize(param_00.origin - self.origin * (1,1,0));
	var_03 = vectornormalize(anglestoforward(self.angles) * (1,1,0));
	var_04 = vectordot(var_02,var_03);
	if(var_04 > param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
shouldmeleeattackhit(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = self.origin;
	}

	if(lib_0F74::func_9DE0(param_00))
	{
		return 1;
	}

	var_05 = distance2dsquared(param_00.origin,param_04);
	if(var_05 > param_01)
	{
		return 0;
	}

	if(!ismyenemyinfrontofme(param_00,param_02))
	{
		if(var_05 < param_03)
		{
			return 1;
		}

		return 0;
	}

	return 1;
}

//Function Number: 13
domeleedamageoncontact(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_00 + "_finished");
	self endon("DoMeleeDamageOnContact_stop");
	var_05 = gettunedata();
	while(isdefined(param_01) && isalive(param_01))
	{
		var_06 = self gettagorigin("j_head",1);
		if(shouldmeleeattackhit(param_01,var_05.moving_melee_attack_damage_radius_sq,var_05.melee_dot,var_05.force_melee_attack_damage_radius_sq,var_06))
		{
			lib_0C73::func_1106E();
			lib_0C73::func_5904(param_01,param_02,"MOD_IMPACT");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 14
alienmeleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = gettunedata();
		if(shouldmeleeattackhit(self.var_4B26,var_04.moving_melee_attack_damage_radius_sq,var_04.melee_dot))
		{
			lib_0C73::func_1106E();
			lib_0C73::func_5904(self.var_4B26,self.var_B601,"MOD_IMPACT");
		}
	}

	if(param_00 == "start_melee")
	{
		var_04 = gettunedata();
		thread domeleedamageoncontact(param_01,self.var_4B26,self.var_B601,var_04.moving_melee_attack_damage_radius_sq,var_04.melee_dot);
		return;
	}

	if(param_00 == "end_melee")
	{
		self method_8282(1,1);
		self notify("DoMeleeDamageOnContact_stop");
		return;
	}

	if(param_00 == "flex_start")
	{
		var_05 = getenemy();
		if(isdefined(var_05))
		{
			var_04 = gettunedata();
			var_06 = self method_80FD(param_01,param_02);
			var_07 = getnotetracktimes(var_06,"hit");
			var_08 = var_07[0];
			if(var_08 > param_03)
			{
				var_09 = getmovedelta(var_06,param_03,var_08);
				var_0A = length2d(var_09);
				var_0B = getanimlength(var_06);
				var_0C = var_08 * var_0B - param_03 * var_0B;
				var_0D = var_05 getvelocity();
				var_0E = var_05.origin + var_0D * var_0C;
				var_0F = distance(var_0E,self.origin);
				var_10 = 1;
				if(var_0F > var_0A && var_0A > 0)
				{
					var_10 = var_0F / var_0A;
					if(var_10 < 1)
					{
						var_10 = 1;
					}

					var_10 = var_10 + var_04.melee_xy_scale_boost;
					if(var_10 > var_04.melee_max_flex_xy_scale)
					{
						var_10 = var_04.melee_max_flex_xy_scale;
					}
				}
				else
				{
					var_10 = 1 + var_04.melee_xy_scale_boost;
				}

				self method_8282(var_10,1);
				return;
			}

			return;
		}

		return;
	}
}

//Function Number: 15
meleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		self method_8282(1,1);
		var_04 = getenemy();
		if(isdefined(var_04))
		{
			var_05 = gettunedata();
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

//Function Number: 16
terminate_movingmelee(param_00,param_01,param_02)
{
	self method_85C9(0);
}

//Function Number: 17
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 18
stopfacingenemy(param_00,param_01)
{
	self endon(param_00 + "_finished");
	wait(param_01);
	lib_0C73::func_1106E();
}

//Function Number: 19
choosemovingmeleeattack(param_00,param_01,param_02)
{
	if(isdefined(self.var_1198.movingmeleeattackindex))
	{
		return self.var_1198.movingmeleeattackindex;
	}

	return randomint(self method_8100(param_01));
}

//Function Number: 20
playmovingmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = 1;
	if(isdefined(self.var_C081))
	{
		var_04 = self.var_C081;
	}

	var_05 = lib_0A1D::func_2337(param_00,param_01);
	var_06 = self method_80FD(param_01,var_05);
	var_07 = getanimlength(var_06) * 1 / var_04;
	var_08 = getnotetracktimes(var_06,"start_melee");
	var_09 = var_07 * var_08[0];
	var_0A = gettunedata();
	var_0B = randomfloatrange(var_0A.min_stop_facing_enemy_time_before_hit,var_0A.max_stop_facing_enemy_time_before_hit);
	var_0C = var_09 - var_0B;
	if(var_0C < 0)
	{
		var_0C = 0.1;
	}

	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	thread stopfacingenemy(param_01,var_0C);
	if(isdefined(self.preventplayerpushdist))
	{
		self method_85C9(self.preventplayerpushdist);
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 21
terminate_meleeattack(param_00,param_01,param_02)
{
	self method_85C9(0);
}

//Function Number: 22
playmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	if(isdefined(self.preventplayerpushdist))
	{
		self method_85C9(self.preventplayerpushdist);
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_C081);
}

//Function Number: 23
choosemeleeattack(param_00,param_01,param_02)
{
	self.meleeattackanimindex = randomintrange(0,self method_8100(param_01));
	return self.meleeattackanimindex;
}

//Function Number: 24
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 25
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233) || self method_841E() < gettunedata().min_moving_pain_dist)
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,self.var_C081);
		return;
	}

	var_04 = lib_0A1D::func_2337(param_01,param_02);
	lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,self.var_C081);
}

//Function Number: 26
doteleporthack(param_00,param_01,param_02,param_03)
{
	var_06 = self method_8146();
	self setorigin(var_06,0);
	var_06 = getgroundposition(var_06,15);
	self.var_9CEC = undefined;
	self notify("traverse_end");
	lib_0A1A::func_237C("decide_idle",param_03);
}

//Function Number: 27
shouldturn(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.desiredyaw))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
handleadditionalyaw(param_00,param_01)
{
	self endon(param_00 + "_finished");
	var_02 = self.additionalyaw / param_01;
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_04 = self.angles[1];
		var_04 = var_04 + var_02;
		var_05 = (self.angles[0],var_04,self.angles[2]);
		self method_8289("face angle abs",var_05);
		scripts\common\utility::func_136F7();
	}

	self.additionalyaw = undefined;
}

//Function Number: 29
func_D56A(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getanimlength(var_05);
	if(isdefined(self.additionalyaw))
	{
		thread handleadditionalyaw(param_01,floor(var_06 * 20));
	}

	return lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_C081);
}

//Function Number: 30
func_3F0A(param_00,param_01,param_02)
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

	var_05 = lib_0A1A::func_2358(param_01,var_03);
	var_06 = self method_80FD(param_01,var_05);
	var_07 = getangledelta(var_06,0,1);
	self.additionalyaw = self.desiredyaw - var_07;
	self.desiredyaw = undefined;
	return var_05;
}

//Function Number: 31
shouldstartarrivalalien(param_00,param_01,param_02,param_03)
{
	if(!lib_0C75::func_FFE7())
	{
		return 0;
	}

	var_04 = self.var_233;
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = gettunedata();
	if(!isdefined(var_05.arrivalanimdist[param_02]))
	{
		return 0;
	}

	var_06 = var_05.arrivalanimdist[param_02];
	var_07 = distance2d(var_04,self.origin);
	if(var_07 < var_06 * 1.1 && var_07 > var_06 * 0.75)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
playalienarrival(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_233;
	if(isdefined(var_04))
	{
		var_05 = gettunedata();
		var_06 = var_05.arrivalanimdist[param_01];
		var_07 = distance2d(var_04,self.origin);
		var_08 = var_07 / var_06;
		self method_8282(var_08,1);
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,0,self.var_C081);
}

//Function Number: 33
terminate_arrival(param_00,param_01,param_02)
{
	self method_8282(1,1);
}

//Function Number: 34
playaliendeathanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self method_828A("gravity");
	if(!scripts\common\utility::istrue(self.var_11B2F))
	{
		self method_8281("anim deltas");
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 35
getenemy()
{
	if(isdefined(self.myenemy))
	{
		return self.myenemy;
	}

	return undefined;
}

//Function Number: 36
lookatenemy()
{
	var_00 = getenemy();
	if(isdefined(var_00))
	{
		var_01 = var_00.origin - self.origin;
		var_02 = vectortoangles(var_01);
		self method_8289("face angle abs",var_02);
		return;
	}

	self method_8289("face angle abs",self.angles);
}

//Function Number: 37
dojump(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(self.agent_type == "alien_phantom")
	{
		self.bteleporting = 1;
	}

	if(isdefined(self.preventplayerpushdist))
	{
		self method_85C9(self.preventplayerpushdist);
	}

	scripts\asm\alien_goon\alien_jump::func_A4C3(param_00,param_01,self.origin,self.angles,self.var_1198.jumpdestinationpos,self.var_1198.jumpdestinationangles,self.var_1198.jumpnextpos);
	self.bteleporting = undefined;
	self.var_1198.jumpdestinationpos = undefined;
	self.var_1198.jumpdestinationangles = undefined;
	self.var_1198.jumpnextpos = undefined;
	clearasmaction();
}

//Function Number: 38
dojumpattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = gettunedata();
	thread domeleedamageoncontact(param_01,self.var_4B26,self.var_B601 * var_04.jump_attack_melee_damage_multiplier,var_04.jump_attack_damage_radius_sq,var_04.jump_attack_damage_dot);
	if(isdefined(self.preventplayerpushdist))
	{
		self method_85C9(self.preventplayerpushdist);
	}

	scripts\asm\alien_goon\alien_jump::jumpattack(param_00,param_01,self.var_1198.jumpdestinationpos);
	self.var_1198.jumpdestinationpos = undefined;
	clearasmaction();
}

//Function Number: 39
doalienjumptraversal(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self method_8148();
	var_05 = self method_8146();
	var_06 = scripts\common\utility::func_824D(var_05);
	if(abs(var_06) > 16)
	{
		self.desiredyaw = var_06;
		func_D56A(param_00,"turn",param_02);
	}

	var_07 = vectornormalize(var_05 - self.origin * (1,1,0));
	var_08 = vectortoangles(var_07);
	if(self.agent_type == "alien_phantom")
	{
		self.bteleporting = 1;
	}

	scripts\asm\alien_goon\alien_jump::func_A4C3(param_00,param_01,self.origin,var_08,var_05,var_08,var_05 + anglestoforward(var_08) * 10);
	self.bteleporting = undefined;
	self notify("traverse_end");
	thread lib_0A1A::func_237C("decide_idle");
}

//Function Number: 40
checkpainnotify()
{
	if(self.var_1198.painnotifytime > 0)
	{
		self.var_1198.painnotifytime = 0;
		return 1;
	}

	return 0;
}

//Function Number: 41
jumpnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "stop_teleport")
	{
		if(self method_85B8())
		{
			level.totalphantomsjumping--;
			if(level.totalphantomsjumping <= 0)
			{
				level.totalphantomsjumping = 0;
			}

			self method_85B7(0);
			thread play_teleport_end();
		}
	}
}

//Function Number: 42
play_teleport_end()
{
	scripts\common\utility::func_136F7();
	self setscriptablepartstate("teleport_fx","teleport_end");
}

//Function Number: 43
terminate_jump(param_00,param_01,param_02)
{
	self method_85B7(0);
}

//Function Number: 44
isalienjumpfinished(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.var_11B2F))
	{
		return 0;
	}

	return shouldabortaction(param_00,param_01,param_02,param_01);
}