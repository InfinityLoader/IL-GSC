/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vehicle_shg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 122 ms
 * Timestamp: 4/22/2024 2:24:47 AM
*******************************************************************/

//Function Number: 1
set_player_rig_spawn_function(param_00)
{
	level.player_rig_spawn_function = param_00;
}

//Function Number: 2
spawn_player_rig()
{
	var_00 = undefined;
	if(isdefined(level.player_rig_spawn_function))
	{
		var_00 = [[ level.player_rig_spawn_function ]]();
		var_00.animname = "_vehicle_player_rig";
	}
	else
	{
		var_00 = spawn("script_model",(0,0,0));
		var_00.animname = "_vehicle_player_rig";
		var_00 useanimtree(#animtree);
		var_00 setmodel("viewbody_generic_s1");
	}

	return var_00;
}

//Function Number: 3
add_vehicle_anim(param_00,param_01,param_02)
{
	if(!isdefined(level.vehicle_anims))
	{
		level.vehicle_anims = [];
	}

	if(!isdefined(level.vehicle_anims[param_00]))
	{
		level.vehicle_anims[param_00] = [];
	}

	level.vehicle_anims[param_00][param_01] = param_02;
}

//Function Number: 4
add_vehicle_player_anim(param_00,param_01,param_02)
{
	level.scr_anim["_vehicle_player_rig"][param_01] = param_02;
}

//Function Number: 5
get_vehicle_anim(param_00)
{
	return level.vehicle_anims[self.classname][param_00];
}

//Function Number: 6
get_vehicle_player_anim(param_00)
{
	return level.scr_anim["_vehicle_player_rig"][param_00];
}

//Function Number: 7
wait_for_vehicle_mount()
{
	self endon("guy_entered");
	self waittill("vehicle_mount",var_00);
	self.player_driver = var_00;
}

//Function Number: 8
wait_for_vehicle_dismount()
{
	self waittill("vehicle_dismount",var_00);
	if(isdefined(var_00))
	{
		var_00.drivingvehicle = undefined;
	}

	self.player_driver = undefined;
}