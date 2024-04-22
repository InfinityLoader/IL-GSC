/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vignette_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 182 ms
 * Timestamp: 4/22/2024 2:24:54 AM
*******************************************************************/

//Function Number: 1
vignette_register(param_00,param_01)
{
	if(!common_scripts\utility::flag_exist(param_01))
	{
		common_scripts\utility::flag_init(param_01);
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
	var_02.script_forcespawn = 1;
	var_03 = maps\_spawner::spawner_dronespawn(var_02);
	var_03.animname = param_01;
	return var_03;
}

//Function Number: 4
vignette_actor_spawn(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02.script_forcespawn = 1;
	var_02 thread maps\_utility::add_spawn_function(::vignette_actor_spawn_func);
	var_03 = var_02 maps\_utility::spawn_ai();
	var_03.animname = param_01;
	return var_03;
}

//Function Number: 5
vignette_actor_spawn_func()
{
	self endon("death");
	thread maps\_utility::magic_bullet_shield();
	thread vignette_actor_ignore_everything();
}

//Function Number: 6
vignette_actor_delete()
{
	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self delete();
}

//Function Number: 7
vignette_actor_kill()
{
	if(!isalive(self))
	{
		return;
	}

	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self.allowdeath = 1;
	self.a.nodeath = 1;
	maps\_utility::set_battlechatter(0);
	self kill();
}

//Function Number: 8
vignette_actor_ignore_everything()
{
	self.ignoreall = 1;
	self.ignoreme = 1;
	self.grenadeawareness = 0;
	self.ignoreexplosionevents = 1;
	self.ignorerandombulletdamage = 1;
	self.ignoresuppression = 1;
	self.fixednode = 0;
	self.disablebulletwhizbyreaction = 1;
	maps\_utility::disable_pain();
	self.dontavoidplayer = 1;
	self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
	self.newenemyreactiondistsq = 0;
}

//Function Number: 9
vignette_vehicle_spawn(param_00,param_01)
{
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname(param_00);
	var_02.animname = param_01;
	return var_02;
}

//Function Number: 10
vignette_vehicle_delete()
{
	self delete();
}