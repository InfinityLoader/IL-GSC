/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\alien_rhino\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 680 ms
 * Timestamp: 10/26/2023 11:58:27 PM
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
	scripts\aitypes\dlc4\melee::setupstandmeleebtaction();
	scripts\aitypes\dlc4\melee::setupmovingmeleebtaction();
	scripts\aitypes\dlc4\alien_jump::setupjumpattackbtaction();
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("charge",::charge_begin,::charge_tick,::charge_end);
}

//Function Number: 3
updateeveryframe(param_00)
{
	scripts\aitypes\dlc4\behavior_utils::func_12E8A();
	return level.var_6AD5;
}

//Function Number: 4
charge_begin(param_00)
{
	scripts\asm\dlc4\dlc4_asm::setasmaction("charge");
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_02 = scripts\asm\dlc4\dlc4_asm::getenemy();
	self.var_4B26 = var_02;
	self.bchargeaborted = undefined;
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"charge_intro","charge_intro",::charge_introdone);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"charge_intro");
}

//Function Number: 5
charge_tick(param_00)
{
	if(!isdefined(self.var_4B26) || scripts\aitypes\dlc4\behavior_utils::shouldignoreenemy(self.var_4B26))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.bchargeaborted))
	{
		return level.var_6AD5;
	}

	var_01 = getclosestpointonnavmesh(self.var_4B26.origin);
	self method_8286(var_01);
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 6
charge_end(param_00)
{
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	self.var_4B26 = undefined;
	self.bchargehit = undefined;
	self.desiredyaw = undefined;
	self.bchargeaborted = undefined;
	self.var_1198.chargeintroindex = undefined;
	self method_841F();
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.nextchargeattacktesttime = gettime() + randomintrange(var_01.min_charge_attack_interval_ms,var_01.max_charge_attack_interval_ms);
}

//Function Number: 7
charge_introdone(param_00,param_01)
{
	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"charging","charge_loop",::charge_movedone,undefined,var_02.max_charge_time_ms);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"charging");
	return 1;
}

//Function Number: 8
charge_movedone(param_00,param_01)
{
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"charge_end","charge_outro",::charge_enddone);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"charge_end");
	return 1;
}

//Function Number: 9
charge_enddone(param_00,param_01)
{
	return 0;
}

//Function Number: 10
trycharge(param_00,param_01,param_02)
{
	if(!scripts\common\utility::istrue(param_02))
	{
		if(isdefined(self.nextchargeattacktesttime) && gettime() < self.nextchargeattacktesttime)
		{
			return 0;
		}
	}

	var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_04 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_04))
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = distancesquared(var_04.origin,self.origin);
	}

	if(param_01 < var_03.charge_attack_mindist_sq)
	{
		return 0;
	}

	if(param_01 > var_03.charge_attack_maxdist_sq)
	{
		return 0;
	}

	self.nextchargeattacktesttime = gettime() + 2000;
	var_05 = randomint(var_03.chargeintroanimtimes.size);
	var_06 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_04,var_03.chargeintroanimtimes[var_05] * 0.7);
	var_07 = anglestoforward(self.angles);
	var_08 = var_06 - self.origin;
	var_07 = (var_07[0],var_07[1],0);
	var_08 = vectornormalize((var_08[0],var_08[1],0));
	var_09 = vectordot(var_07,var_08);
	if(var_09 < 0.707)
	{
		return 0;
	}

	if(!navisstraightlinereachable(self.origin,var_06,self))
	{
		self.nextchargeattacktesttime = gettime() + 500;
		return 0;
	}

	self.var_1198.chargeintroindex = var_05;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"charge");
	return 1;
}

//Function Number: 11
taunt(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"taunt");
}

//Function Number: 12
trytaunt(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_03 = gettime();
	if(!isdefined(self.nexttaunttime))
	{
		self.nexttaunttime = var_03 + var_02.initial_taunt_wait_time_ms;
		return 0;
	}

	if(var_03 < self.nexttaunttime)
	{
		return 0;
	}

	var_04 = distancesquared(self.origin,var_01.origin);
	if(var_04 < var_02.taunt_min_dist_to_enemy_sq)
	{
		self.nexttaunttime = var_03 + 1000;
		return 0;
	}

	if(var_04 > var_02.taunt_max_dist_to_enemy_sq)
	{
		self.nexttaunttime = var_03 + 1000;
		return 0;
	}

	self.nexttaunttime = var_03 + randomintrange(var_02.min_time_between_taunts_ms,var_02.max_time_between_taunts_ms);
	var_05 = randomint(var_02.taunt_chance);
	if(var_05 < var_02.taunt_chance)
	{
		taunt(param_00);
		return 1;
	}

	return 0;
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

		if(trycharge(param_00))
		{
			return level.var_111AE;
		}

		if(trytaunt(param_00))
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
followenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
}

//Function Number: 15
followenemy_tick(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
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

//Function Number: 16
followenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}