/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_remotemissile_utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 139 ms
 * Timestamp: 10/27/2023 2:20:51 AM
*******************************************************************/

//Function Number: 1
setup_remote_missile_target()
{
	if(!isdefined(level.remote_missile_targets))
	{
		level.remote_missile_targets = [];
	}

	level.remote_missile_targets[self.unique_id] = self;
	if(isdefined(level.remotemissile.draw_red_boxes) && !isdefined(level.uav_is_destroyed))
	{
		level endon("draw_target_end");
		while(isdefined(level.setup_remote_missile_target_last_add_time) && level.setup_remote_missile_target_last_add_time == gettime())
		{
			wait 0.05;
		}

		level.setup_remote_missile_target_last_add_time = gettime();
		if(isalive(self))
		{
			maps\_remotemissile::draw_target();
		}
	}

	self waittill("death");
	level.remote_missile_targets[self.unique_id] = undefined;
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.has_target_shader))
	{
		self.has_target_shader = undefined;
		target_remove(self);
	}
}

//Function Number: 2
player_uav_rig()
{
	if(isdefined(level.uavrig))
	{
		return level.uavrig;
	}

	var_00 = maps\_remotemissile::get_current_uav_rig();
	return var_00;
}

//Function Number: 3
create_uav_rigs(param_00)
{
	foreach(var_02 in level.players)
	{
		var_03 = common_scripts\utility::spawn_tag_origin();
		var_03.origin = self.origin;
		var_03.uav = self;
		var_03 thread maps\_remotemissile::run_rig_function_when_player_uses_uav(param_00,var_02);
		var_02 add_player_rig(var_03);
		var_02 thread maps\_remotemissile::cycle_uav_rigs();
	}
}

//Function Number: 4
add_player_rig(param_00)
{
	if(!isdefined(self.var_3BF0))
	{
		self.var_3BF0 = [];
	}

	self.var_3BF0[self.var_3BF0.size] = param_00;
}

//Function Number: 5
give_player_remote_missiles()
{
	self giveweapon("remote_missile_detonator");
	self.remotemissile_actionslot = 4;
	thread remotemissile_with_autoreloading();
	common_scripts\utility::flag_clear("predator_missile_launch_allowed");
	self setactionslot(self.remotemissile_actionslot,"weapon","remote_missile_detonator");
}

//Function Number: 6
remotemissile_reload()
{
	level endon("stop_uav_reload");
	level endon("special_op_terminated");
	if(common_scripts\utility::flag("uav_reloading"))
	{
		if(isdefined(level.uav_is_destroyed))
		{
			return;
		}

		maps\_remotemissile::remove_uav_weapon();
		if(common_scripts\utility::flag("uav_collecting_stats"))
		{
			level waittill("uav_collecting_stats");
			maps\_remotemissile::play_kills_dialogue();
		}

		if(isdefined(level.uav_is_destroyed))
		{
			return;
		}

		level.uav_user = undefined;
		if(common_scripts\utility::flag("uav_reloading"))
		{
			level waittill("uav_reloading");
		}

		if(isdefined(level.uav_is_destroyed))
		{
			return;
		}

		if(!common_scripts\utility::flag("uav_enabled"))
		{
			return;
		}

		if(self getweaponammoclip(self.uav_weaponname) < 1)
		{
			maps\_remotemissile::disable_uav();
			return;
		}

		maps\_remotemissile::restore_uav_weapon();
		thread maps\_remotemissile::remotemissile_radio("uav_online");
		thread maps\_remotemissile::remotemissile_radio_reminder();
	}
}

//Function Number: 7
remotemissile_with_autoreloading()
{
	maps\_remotemissile::remotemissile_player_input(::remotemissile_reload);
}

//Function Number: 8
remotemissile_no_autoreload()
{
	maps\_remotemissile::remotemissile_player_input();
}

//Function Number: 9
remotemissile_move_player()
{
	return isdefined(level.remotemissile_temp_move_player);
}