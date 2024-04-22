/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _chinese_brave_warrior.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 103 ms
 * Timestamp: 4/22/2024 2:04:34 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("warrior_atlas",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%humvee_50cal_driving_idle_forward,%humvee_50cal_driving_idle_backward,10);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
	if(issubstr(self.vehicletype,"physics"))
	{
		var_00 = [];
		var_00["idle"] = %humvee_antennas_idle_movement;
		var_00["rot_l"] = %humvee_antenna_l_rotate_360;
		var_00["rot_r"] = %humvee_antenna_r_rotate_360;
		thread maps\_vehicle_code::humvee_antenna_animates(var_00);
	}
}

//Function Number: 3
build_humvee_anims()
{
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 4
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 5
setanims()
{
}

//Function Number: 6
unload_groups()
{
}