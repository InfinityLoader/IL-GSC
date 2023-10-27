/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\dlc4\melee.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 434 ms
 * Timestamp: 10/26/2023 11:58:39 PM
*******************************************************************/

//Function Number: 1
setupstandmeleebtaction(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = ::melee_begin;
	}

	if(!isdefined(param_01))
	{
		param_01 = ::melee_tick;
	}

	if(!isdefined(param_02))
	{
		param_02 = ::melee_end;
	}

	scripts\aitypes\dlc4\bt_action_api::setupbtaction("stand_melee",param_00,param_01,param_02);
}

//Function Number: 2
setupmovingmeleebtaction(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = ::melee_begin;
	}

	if(!isdefined(param_01))
	{
		param_01 = ::melee_tick;
	}

	if(!isdefined(param_02))
	{
		param_02 = ::melee_end;
	}

	scripts\aitypes\dlc4\bt_action_api::setupbtaction("moving_melee",param_00,param_01,param_02);
}

//Function Number: 3
melee_begin(param_00)
{
	var_01 = scripts\aitypes\dlc4\bt_action_api::getcurrentdesiredbtaction(param_00);
	scripts\asm\dlc4\dlc4_asm::setasmaction(var_01);
	var_02 = scripts\asm\dlc4\dlc4_asm::getenemy();
	self.var_4B26 = var_02;
	self.bmovingmelee = undefined;
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,var_01,var_01);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,var_01);
}

//Function Number: 4
melee_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 5
melee_end(param_00)
{
	self.var_4B26 = undefined;
	self.var_A9B8 = gettime();
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	scripts\aitypes\dlc4\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 6
movingmelee_begin(param_00)
{
	var_01 = scripts\aitypes\dlc4\bt_action_api::getcurrentdesiredbtaction(param_00);
	scripts\asm\dlc4\dlc4_asm::setasmaction(var_01);
	var_02 = scripts\asm\dlc4\dlc4_asm::getenemy();
	self.var_4B26 = var_02;
	self.bmovingmelee = 1;
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,var_01,var_01,::movingmelee_attackdone);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,var_01);
}

//Function Number: 7
movingmelee_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 8
movingmelee_end(param_00)
{
	self.var_4B26 = undefined;
	self.var_1198.movingmeleeattackindex = undefined;
	self.var_A9B8 = gettime();
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	scripts\aitypes\dlc4\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 9
movingmelee_attackdone(param_00,param_01)
{
	return 0;
}

//Function Number: 10
trymeleeattacks(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(isdefined(self.var_A9B8) && gettime() - self.var_A9B8 < var_02.min_time_between_melee_attacks_ms)
	{
		return 0;
	}

	if(abs(var_01.origin[2] - self.origin[2]) > var_02.melee_max_z_diff)
	{
		return 0;
	}

	var_03 = var_01.origin;
	if(isdefined(self.var_233))
	{
		var_03 = scripts\aitypes\dlc4\behavior_utils::getpredictedenemypos(var_01,var_02.avg_time_to_impact);
	}

	var_04 = distancesquared(var_03,self.origin);
	if(var_04 < var_02.stand_melee_dist_sq)
	{
		scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"stand_melee");
		return 1;
	}

	var_05 = randomint(var_02.movingattackdisttoattacksq.size);
	var_06 = distancesquared(self.origin,var_01.origin);
	if(var_06 > var_02.non_predicted_move_melee_dist_sq)
	{
		if(var_04 > var_02.movingattackdisttoattacksq[var_05])
		{
			return 0;
		}
	}

	if(var_06 > var_02.check_reachable_dist_sq)
	{
		var_07 = self method_84AC();
		var_08 = getclosestpointonnavmesh(var_01.origin,self);
		if(!navisstraightlinereachable(var_07,var_08,self))
		{
			return 0;
		}
	}

	self.var_1198.movingmeleeattackindex = var_05;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"moving_melee");
	return 1;
}