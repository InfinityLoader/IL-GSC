/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\dlc4\wander.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 181 ms
 * Timestamp: 10/26/2023 11:58:40 PM
*******************************************************************/

//Function Number: 1
findrandomnavpoint(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		param_00 = 300;
		param_01 = 1200;
	}

	var_02 = anglestoforward(self.angles);
	var_03 = anglestoright(self.angles);
	var_04 = var_03 * -1;
	var_05 = var_02 * -1;
	var_06 = [];
	var_06[0] = var_02;
	var_06[1] = var_03;
	var_06[2] = var_04;
	var_06[3] = var_05;
	var_06 = scripts\common\utility::array_randomize(var_06);
	var_07 = param_00 * 2;
	foreach(var_09 in var_06)
	{
		var_0A = self.origin + var_09 * var_07;
		var_0A = getclosestpointonnavmesh(var_0A);
		var_0B = getrandomnavpoint(var_0A,param_00);
		if(!isdefined(var_0B))
		{
			continue;
		}

		var_0C = distancesquared(var_0B,self.origin);
		if(var_0C > param_00 * param_00)
		{
			return var_0B;
		}
	}

	return undefined;
}

//Function Number: 2
wander_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self method_841F();
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(isdefined(var_01.wander_goal_radius))
	{
		self.var_3135.var_9928[param_00].wandergoalradiussq = var_01.wander_goal_radius * var_01.wander_goal_radius;
		return;
	}

	self.var_3135.var_9928[param_00].wandergoalradiussq = 4096;
}

//Function Number: 3
wander_tick(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::getenemy();
	if(isdefined(var_01))
	{
		return level.var_111AE;
	}

	var_02 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
	if(isdefined(self.var_233) && distancesquared(self.var_233,self.origin) > var_02.wandergoalradiussq)
	{
		return level.var_E87A;
	}

	if(!isdefined(var_02.var_13845))
	{
		var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
		var_02.var_13845 = gettime() + randomintrange(var_03.wander_min_wait_time_ms,var_03.wander_max_wait_time_ms);
		return level.var_E87A;
	}
	else if(gettime() < var_03.var_13845)
	{
		return level.var_E87A;
	}

	var_04 = findrandomnavpoint();
	if(!isdefined(var_04))
	{
		var_03.var_13845 = gettime() + 150;
		return level.var_E87A;
	}

	var_03.var_13845 = undefined;
	self method_8286(var_04);
	return level.var_E87A;
}

//Function Number: 4
wander_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}