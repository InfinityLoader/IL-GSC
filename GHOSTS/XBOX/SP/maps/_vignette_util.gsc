/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vignette_util.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 148 ms
 * Timestamp: 10/27/2023 1:38:05 AM
*******************************************************************/

//Function Number: 1
func_89CF(param_00,param_01)
{
	if(!common_scripts\utility::flag_exist(param_01))
	{
		common_scripts\utility::func_3385(param_01);
	}

	thread vignette_register_wait(param_00,param_01);
}

//Function Number: 2
vignette_register_wait(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_01);
	level thread [[ param_00 ]]();
}

//Function Number: 3
vignette_drone_spawn(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02.var_6BD5 = 1;
	var_03 = maps\_spawner::func_7870(var_02);
	var_03.animname = param_01;
	return var_03;
}

//Function Number: 4
func_89C1(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02.var_6BD5 = 1;
	var_02 thread maps\_utility::add_spawn_function(::func_89C2);
	var_03 = var_02 maps\_utility::func_7766();
	var_03.animname = param_01;
	return var_03;
}

//Function Number: 5
func_89C2()
{
	self endon("death");
	thread maps\_utility::magic_bullet_shield();
	thread func_89BF();
}

//Function Number: 6
func_89BE()
{
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::func_7C38();
	}

	self delete();
}

//Function Number: 7
func_89C0()
{
	if(!isalive(self))
	{
	}

	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::func_7C38();
	}

	self.allowdeath = 1;
	self.a.var_564F = 1;
	maps\_utility::func_6E54(0);
	self method_82E7();
}

//Function Number: 8
func_89BF()
{
	self.ignoreall = 1;
	self.ignoreme = 1;
	self.grenadeawareness = 0;
	self.ignoreexplosionevents = 1;
	self.ignorerandombulletdamage = 1;
	self.ignoresuppression = 1;
	self.fixednode = 0;
	self.var_279D = 1;
	maps\_utility::disable_pain();
	self.dontavoidplayer = 1;
	self.var_5877 = self.newenemyreactiondistsq;
	self.newenemyreactiondistsq = 0;
}

//Function Number: 9
func_89DA(param_00,param_01)
{
	var_02 = maps\_vehicle::func_784E(param_00);
	var_02.animname = param_01;
	return var_02;
}

//Function Number: 10
vignette_vehicle_delete()
{
	self delete();
}