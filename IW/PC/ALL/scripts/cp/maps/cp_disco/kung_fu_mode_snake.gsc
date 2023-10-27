/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\kung_fu_mode_snake.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 1163 ms
 * Timestamp: 10/27/2023 12:04:31 AM
*******************************************************************/

//Function Number: 1
snake_kung_fu_init()
{
	level._effect["skeleton_summon_portal"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_rave_superslasher_spawn_portal.vfx");
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\powers\coop_powers::func_D787("power_shuriken_snake",::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power,::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power,::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken,undefined,undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_summon_pet_snake",::scripts\cp\maps\cp_disco\kung_fu_mode::func_2B53,::scripts\cp\maps\cp_disco\kung_fu_mode::func_2B53,::summon_skeleton_pet,undefined,"snake_chi_power",undefined);
}

//Function Number: 2
summon_skeleton_pet()
{
	self endon("watch_for_kung_fu_timeout");
	self endon("disconnect");
	self endon("last_stand");
	wait(0.1);
	if(scripts\common\utility::istrue(self.snake_super))
	{
		return;
	}

	scripts\cp\powers\coop_powers::func_D728();
	var_00 = 250;
	if(self.chi_meter_amount - var_00 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	scripts\cp\zombies\zombies_spawning::func_93EB(1);
	self playlocalsound("chi_snake_skeleton_summon");
	wait(1);
	if(isdefined(self.pet_skeleton))
	{
		self.pet_skeleton notify("owner_spawned_new_guy");
		self.pet_skeleton dodamage(self.pet_skeleton.health + 100,self.pet_skeleton.origin);
		wait(0.1);
		self.pet_skeleton = undefined;
	}

	self.pet_skeleton = skeleton_spawner();
	if(isdefined(self.pet_skeleton))
	{
		scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
	}
	else
	{
		scripts\cp\zombies\zombies_spawning::func_4FB8(1);
	}

	self.kung_fu_exit_delay = 0;
	scripts\cp\powers\coop_powers::func_D72E();
	self notify("snake_chi_power",1);
}

//Function Number: 3
skeleton_spawner()
{
	var_00 = determine_skeleton_spawn_point(self.origin);
	var_01 = spawn_skeleton_solo(var_00);
	if(isdefined(var_01))
	{
		var_01 thread skeleton_arrival_cowbell(var_00);
		var_01 thread set_skeleton_attributes(self);
	}

	return var_01;
}

//Function Number: 4
spawn_skeleton_solo(param_00)
{
	param_00 = scripts\common\utility::func_5D14(param_00,30,-100);
	var_01 = spawnstruct();
	var_01.origin = param_00;
	var_01.var_EE79 = "ground_spawn_no_boards";
	var_01.var_ECF5 = "spawn_ground";
	var_02 = 4;
	var_03 = 0.3;
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		var_05 = var_01 scripts\cp\zombies\zombies_spawning::func_1081B("skeleton",1);
		if(isdefined(var_05))
		{
			level thread skeleton_spawn_fx_pillar(param_00,2);
			wait(var_03);
			return var_05;
		}

		wait(var_03);
	}

	return undefined;
}

//Function Number: 5
skeleton_spawn_fx_pillar(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin_snake_chi");
	wait(param_01);
	var_02 delete();
}

//Function Number: 6
skeleton_arrival_cowbell(param_00)
{
	var_01 = (0,0,-11);
	var_02 = spawnfx(level._effect["skeleton_summon_portal"],param_00 + var_01,(0,0,1),(1,0,0));
	thread scripts\common\utility::play_sound_in_space("chi_snake_skeleton_spawn",var_02.origin);
	triggerfx(var_02);
	self playsound("chi_snake_skeleton_spawn_foley");
	scripts\common\utility::waittill_any_3("death","intro_vignette_done");
	var_02 delete();
}

//Function Number: 7
set_skeleton_attributes(param_00)
{
	level endon("game_ended");
	self endon("death");
	self.playerowner = param_00;
	self.var_222 = param_00;
	var_01 = self;
	var_01.team = "allies";
	var_01.var_1F5 = "sprint";
	var_01.var_9CA2 = 1;
	var_01.var_9CEF = 1;
	var_01.maxhealth = 900;
	var_01.health = 900;
	var_01.allowpain = 0;
	var_01 notify("turned");
	var_01 thread zombie_movement_update(self);
	var_01.var_B57A = int(scripts\cp\zombies\zombies_spawning::func_3728("generic_zombie") * 1.5);
	level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,var_01);
	level.var_4B95--;
	var_01 thread func_A626(30);
	var_01 thread func_E0B2();
	var_01 thread watch_zombie_collision();
	if(isdefined(level.var_1299F))
	{
		level.var_1299F = scripts\common\utility::array_add(level.var_1299F,var_01);
		return;
	}

	level.var_1299F = [];
	level.var_1299F = scripts\common\utility::array_add(level.var_1299F,var_01);
}

//Function Number: 8
watch_zombie_collision()
{
	self endon("death");
	var_00 = 576;
	for(;;)
	{
		var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
		if(var_01.size == 0)
		{
			wait(0.05);
			continue;
		}

		var_02 = scripts\common\utility::getclosest(self.origin,var_01);
		if(distancesquared(var_02.origin,self.origin) < var_00)
		{
			var_02.full_gib = 1;
			var_02.var_4C87 = 1;
			var_02 dodamage(var_02.health + 100,var_02.origin,self,self,"MOD_MELEE","none");
		}

		wait(0.05);
	}
}

//Function Number: 9
func_A626(param_00)
{
	level endon("game_ended");
	self endon("death");
	self waittill("intro_vignette_done");
	while(param_00 > 0)
	{
		wait(1);
		param_00--;
	}

	thread scripts\common\utility::play_sound_in_space("chi_snake_skeleton_death",self.origin);
	self dodamage(self.health + 100,self.origin);
}

//Function Number: 10
func_E0B2()
{
	level endon("game_ended");
	self waittill("death");
	level.var_1299F = scripts\common\utility::func_22A9(level.var_1299F,self);
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}

//Function Number: 11
determine_skeleton_spawn_point(param_00)
{
	var_01 = self.angles;
	var_02 = self.origin + anglestoforward(self.angles) * 64;
	var_03 = 0;
	while(var_03 <= 360)
	{
		if(ispointonnavmesh(var_02) && scripts\cp\maps\cp_disco\cp_disco::is_in_active_volume(var_02))
		{
			break;
		}

		var_01 = var_01 + (0,15,0);
		var_03 = var_03 + 15;
		var_02 = self.origin + anglestoforward(var_01) * 64;
	}

	if(var_03 >= 360)
	{
		return self.origin;
	}

	return var_02;
}

//Function Number: 12
zombie_movement_update(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self endon("death");
	for(;;)
	{
		var_01 = determine_skeleton_mode(param_00);
		switch(var_01)
		{
			case "move":
				skeleton_move_to_player(param_00);
				break;
	
			case "fight":
				self.var_EF64 = 0;
				wait(3);
				break;
	
			default:
				wait(0.25);
				break;
		}
	}
}

//Function Number: 13
skeleton_move_to_player(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self endon("death");
	self.var_EF64 = 1;
	self method_8287(96);
	self method_8284(self.playerowner);
	scripts\common\utility::waittill_any_timeout_1(2,"goal_reached");
}

//Function Number: 14
determine_skeleton_mode(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self endon("death");
	if(distance2dsquared(self.origin,param_00.origin) >= 1048576)
	{
		return "move";
	}

	var_01 = sortbydistance(level.spawned_enemies,param_00.origin);
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return "move";
	}

	if(distance2dsquared(var_01[0].origin,param_00.origin) >= 1048576)
	{
		return "move";
	}

	return "fight";
}

//Function Number: 15
snake_super_use(param_00)
{
	self.snake_super = 1;
	scripts\common\utility::func_1C53(0);
	var_01 = 500;
	if(self.chi_meter_amount - var_01 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	self playgestureviewmodel("ges_snake_melee_super",undefined,1);
	thread play_snake_hand_fx();
	self.kung_fu_shield = 1;
	wait(0.75);
	self playanimscriptevent("power_active_cp","gesture024");
	var_02 = 4;
	var_03 = 0.1;
	var_04 = var_02 / var_03;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		snake_super_damage_nearby_enemies();
		wait(var_03);
	}

	self stopgestureviewmodel("ges_snake_melee_super");
	self.kung_fu_shield = undefined;
	self.kung_fu_exit_delay = 0;
	self.snake_super = undefined;
	scripts\common\utility::func_1C53(1);
	scripts\cp\powers\coop_powers::func_D72E();
}

//Function Number: 16
play_snake_hand_fx()
{
	self setscriptablepartstate("kung_fu_super_fx","snake");
	wait(4.75);
	self setscriptablepartstate("kung_fu_super_fx","off");
}

//Function Number: 17
snake_super_damage_nearby_enemies()
{
	var_00 = 50;
	var_01 = [];
	var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_03 = sortbydistance(var_02,self.origin);
	foreach(var_05 in var_03)
	{
		isdefined(var_05);
		if(distance2dsquared(self.origin,var_05.origin) >= var_00 * var_00)
		{
			break;
		}

		if(scripts\common\utility::func_13D90(self.origin,self getplayerangles(),var_05.origin,cos(90)))
		{
			var_01[var_01.size] = var_05;
		}
	}

	var_07 = 0;
	foreach(var_05 in var_01)
	{
		if(var_07 >= 3)
		{
			return;
		}

		if(isdefined(var_05))
		{
			var_05 dodamage(var_05.maxhealth + 1000,self.origin,self,undefined,"MOD_EXPLOSIVE");
		}

		var_07++;
	}
}