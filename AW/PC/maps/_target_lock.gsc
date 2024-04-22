/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _target_lock.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 145 ms
 * Timestamp: 4/22/2024 2:23:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.target_lock_targets = [];
}

//Function Number: 2
register_target_lock_change_func(param_00)
{
	level.target_lock_change_func = param_00;
}

//Function Number: 3
add_lock_target(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	target_set(param_00);
	if(isdefined(level.target_lock_change_func))
	{
		self [[ level.target_lock_change_func ]]("Added",param_00);
	}

	level.target_lock_targets = common_scripts\utility::array_add(level.target_lock_targets,param_00);
	level thread remove_from_targets_on_death(param_00);
}

//Function Number: 4
remove_lock_target(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(level.target_lock_change_func))
	{
		self [[ level.target_lock_change_func ]]("Removed",param_00);
	}

	level.target_lock_targets = common_scripts\utility::array_remove(level.target_lock_targets,param_00);
}

//Function Number: 5
get_best_lock_target(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.target_lock_targets)
	{
		if(is_viable_lock_target(var_04,param_00,param_01))
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_06 = bullettrace(self geteye(),self geteye() + anglestoforward(self getplayerangles()) * 100000,1,self);
	var_02 = sortbydistance(var_02,var_06["position"]);
	if(!var_02.size)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 6
is_viable_lock_target(param_00,param_01,param_02)
{
	if(!target_istarget(param_00))
	{
		return 0;
	}

	var_03 = target_isinrect(param_00,self,get_fov_for_player(self),param_01,param_01);
	if(!var_03)
	{
		return 0;
	}

	var_04 = bullettrace(self geteye(),param_00.origin,0,param_00);
	return bullettracepassed(self geteye(),param_00.origin,0,param_00);
}

//Function Number: 7
remove_from_targets_on_death(param_00)
{
	param_00 waittill("death");
	level remove_lock_target(param_00);
}

//Function Number: 8
get_fov_for_player(param_00)
{
	var_01 = getdvarint("cg_fov");
	var_02 = getdvarfloat("cg_playerFovScale0");
	if(isdefined(level.player2) && param_00 == level.player2)
	{
		var_02 = getdvarfloat("cg_playerFovScale1");
	}

	return var_01 * var_02;
}