/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\alien_goon\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 976 ms
 * Timestamp: 10/26/2023 11:58:26 PM
*******************************************************************/

//Function Number: 1
initbehaviors(param_00)
{
	setupbehaviorstates();
	self.desiredaction = undefined;
	self.lastenemyengagetime = 0;
	self.myenemy = undefined;
	lib_0A1B::func_2968("run");
	return level.var_111AE;
}

//Function Number: 2
setupbehaviorstates()
{
	scripts\aitypes\dlc4\simple_action::setupsimplebtaction();
	scripts\aitypes\dlc4\melee::setupstandmeleebtaction(undefined,::melee_goontick);
	scripts\aitypes\dlc4\melee::setupmovingmeleebtaction(undefined,::movingmelee_goontick);
	scripts\aitypes\dlc4\alien_jump::setupjumpattackbtaction();
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("teleport",::teleport_begin,::teleport_tick,::teleport_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("post_attack",::postattack_begin,::postattack_tick,::postattack_end);
}

//Function Number: 3
updateeveryframe(param_00)
{
	scripts\aitypes\dlc4\behavior_utils::func_12E8A();
	return level.var_6AD5;
}

//Function Number: 4
teleport_begin(param_00)
{
	scripts\aitypes\dlc4\behavior_utils::facepoint(self.var_AAFD);
	self.var_1198.jumpdestinationpos = self.var_AAFD;
	self.var_1198.jumpdestinationangles = vectortoangles(self.var_AAFD - self.origin * (1,1,0));
	self.var_1198.jumpnextpos = undefined;
	scripts\asm\dlc4\dlc4_asm::setasmaction("jump");
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"jump","jump");
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"jump");
	self.bteleporting = 1;
}

//Function Number: 5
teleport_tick(param_00)
{
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self method_841F();
	return level.var_111AE;
}

//Function Number: 6
teleport_end(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.nextjumpattack = gettime() + var_01.jump_attack_min_interval;
	self.var_1198.jumpdestinationpos = undefined;
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	self.bteleporting = undefined;
}

//Function Number: 7
melee_goontick(param_00)
{
	var_01 = scripts\aitypes\dlc4\melee::melee_tick(param_00);
	if(var_01 == level.var_6AD5)
	{
		scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"post_attack");
	}

	return var_01;
}

//Function Number: 8
movingmelee_goontick(param_00)
{
	var_01 = scripts\aitypes\dlc4\melee::movingmelee_tick(param_00);
	if(var_01 == level.var_6AD5)
	{
		scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"post_attack");
	}

	return var_01;
}

//Function Number: 9
postattack_begin(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_02 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
	var_02.postattackendtime = gettime() + var_01.min_time_between_melee_attacks_ms;
	var_03 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_03))
	{
		scripts\asm\dlc4\dlc4_asm::setasmaction("taunt");
		scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"taunt","taunt");
		scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"taunt");
		return;
	}

	var_04 = vectornormalize(var_03.origin - self.origin * (1,1,0));
	var_05 = anglestoforward(self.angles);
	var_06 = vectordot(var_04,var_05);
	var_07 = distancesquared(var_03.origin,self.origin);
	if(var_06 > 0 || var_07 < var_01.post_attack_max_enemy_dist_sq)
	{
		if(candomanuever("jump_back"))
		{
			scripts\asm\dlc4\dlc4_asm::setasmaction("jump_back");
			scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"jump_back","jump_back");
			scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"jump_back");
			return;
		}

		if(candomanuever("slide_left"))
		{
			scripts\asm\dlc4\dlc4_asm::setasmaction("slide_left");
			scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"slide_left","slide_left");
			scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"slide_left");
			return;
		}

		if(candomanuever("slide_right"))
		{
			scripts\asm\dlc4\dlc4_asm::setasmaction("slide_right");
			scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"slide_right","slide_right");
			scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"slide_right");
			return;
		}
	}

	if(randomint(100) < var_01.post_attack_taunt_chance)
	{
		scripts\asm\dlc4\dlc4_asm::setasmaction("taunt");
		scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"taunt","taunt");
		scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"taunt");
	}
}

//Function Number: 10
postattack_tick(param_00)
{
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.runing;
	}

	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	scripts\aitypes\dlc4\behavior_utils::facepoint(var_01.origin);
	var_02 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
	if(gettime() < var_02.postattackendtime)
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 11
postattack_end(param_00)
{
	var_01 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
	var_01.postattackendtime = undefined;
}

//Function Number: 12
candomanuever(param_00)
{
	var_01 = self method_80FD(param_00,0);
	var_02 = getmovedelta(var_01,0,1);
	var_03 = self method_81E7(var_02);
	if(!lib_0F74::func_38D1(self.origin,var_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
decideaction(param_00)
{
	if(isdefined(self.desiredaction))
	{
		return level.var_111AE;
	}

	if(isdefined(self.nextaction))
	{
		scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,self.nextaction);
		self.nextaction = undefined;
		return level.var_111AE;
	}

	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = gettime();
	if(self method_805F(var_01))
	{
		if(scripts\aitypes\dlc4\melee::trymeleeattacks(param_00))
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}

		if(scripts\aitypes\dlc4\alien_jump::tryjumpattack(param_00,var_01))
		{
			return level.var_111AE;
		}
	}
	else
	{
		var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
		var_04 = distancesquared(var_01.origin,self.origin);
		if(var_04 <= var_03.stand_melee_dist_sq)
		{
			if(scripts\aitypes\dlc4\melee::trymeleeattacks(param_00))
			{
				self.lastenemyengagetime = var_02;
				return level.var_111AE;
			}
		}
	}

	return level.var_6AD5;
}

//Function Number: 14
getdodgemovescale(param_00,param_01)
{
	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_03 = lib_0A1A::func_2358(param_00,param_01);
	var_04 = self method_80FD(param_00,var_03);
	var_05 = scripts\mp\agents\_scriptedagents::func_80FE(var_04);
	if(var_05 < var_02.min_dodge_scale)
	{
		return undefined;
	}

	if(var_05 > var_02.max_dodge_scale)
	{
		return var_02.max_dodge_scale;
	}

	return var_05;
}

//Function Number: 15
updatestumble(param_00)
{
	if(!isdefined(self.damageaccumulator))
	{
		return 0;
	}

	if(isdefined(self.var_1198.requested_dodge_dir))
	{
		return 0;
	}

	if(!isdefined(self.damageaccumulator.var_A96A) || gettime() > self.damageaccumulator.var_A96A + 1000)
	{
		self.damageaccumulator.accumulateddamage = 0;
		self.damageaccumulator.var_A96A = 0;
	}

	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(isdefined(self.nextstumbletime) && gettime() < self.nextstumbletime)
	{
		return 0;
	}

	if(self.damageaccumulator.accumulateddamage < self.maxhealth * var_01.stumble_damage_pct)
	{
		return 0;
	}

	if(randomint(100) < var_01.stumble_chance)
	{
		func_5AB8(param_00);
		return 1;
	}

	self.damageaccumulator.accumulateddamage = 0;
	self.damageaccumulator.var_A96A = 0;
	return 0;
}

//Function Number: 16
updatedodge(param_00)
{
	var_01 = gettime();
	if(isdefined(self.var_1198.requested_dodge_dir))
	{
		if(self.lastdodgetime - var_01 > 150)
		{
			self.var_1198.requested_dodge_dir = undefined;
		}
		else
		{
			return 0;
		}
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!isdefined(self.lastwhizbytime))
	{
		return 0;
	}

	if(self.lastwhizbytime == var_01)
	{
		return 0;
	}

	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(var_01 - self.lastwhizbytime > 100)
	{
		self.lastwhizbytime = undefined;
		return 0;
	}

	if(isdefined(self.lastdodgechecktime) && var_01 - self.lastdodgechecktime < var_02.min_dodge_test_interval_ms)
	{
		return 0;
	}

	if(isdefined(self.lastdodgetime) && var_01 < self.lastdodgetime + var_02.min_dodge_interval_ms)
	{
		return 0;
	}

	self.lastdodgechecktime = var_01;
	var_03 = randomint(100);
	if(var_03 < var_02.dodge_chance)
	{
		var_04 = distancesquared(self.var_233,self.origin);
		if(var_04 < var_02.min_enemy_dist_to_dodge_sq)
		{
			return 0;
		}

		self.lastdodgetime = gettime();
		var_05 = undefined;
		if(scripts\common\utility::func_4347())
		{
			var_06 = "left";
			var_05 = getdodgemovescale("run_dodge",var_06);
			if(!isdefined(var_05))
			{
				var_06 = "right";
				var_05 = getdodgemovescale("run_dodge",var_06);
			}
		}
		else
		{
			var_06 = "right";
			var_05 = getdodgemovescale("run_dodge",var_06);
			if(!isdefined(var_05))
			{
				var_06 = "left";
				var_05 = getdodgemovescale("run_dodge",var_06);
			}
		}

		if(isdefined(var_05))
		{
			self.var_1198.requested_dodge_dir = var_06;
			self.var_1198.requested_dodge_scale = var_05;
			return 1;
		}
	}

	self.lastwhizbytime = undefined;
	return 0;
}

//Function Number: 17
followenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
}

//Function Number: 18
followenemy_tick(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(!updatestumble(param_00))
	{
		updatedodge(param_00);
	}

	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_03 = getclosestpointonnavmesh(var_01.origin,self);
	var_04 = distancesquared(var_03,self.origin);
	if(var_04 > var_02.stand_melee_dist_sq)
	{
		self method_8286(var_03);
		if(!self method_805F(var_01))
		{
			if(!isdefined(self.var_233))
			{
				scripts\aitypes\dlc4\behavior_utils::facepoint(var_01.origin);
			}

			return level.var_E87A;
		}
	}
	else
	{
		scripts\aitypes\dlc4\behavior_utils::facepoint(var_01.origin);
	}

	return level.var_111AE;
}

//Function Number: 19
followenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 20
jumpback(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"jump_back");
}

//Function Number: 21
slideleft(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"slide_left");
}

//Function Number: 22
slideright(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"slide_right");
}

//Function Number: 23
taunt(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"taunt");
}

//Function Number: 24
func_5AB8(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.nextstumbletime = gettime() + var_01.stumble_interval_ms;
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"stumble");
}