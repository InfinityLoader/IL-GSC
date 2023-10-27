/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_80s_hatch1.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 2:46:14 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("80s_hatch1",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_brn_destructible","vehicle_80s_hatch1_brn");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_green_destructible","vehicle_80s_hatch1_green");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_red_destructible","vehicle_80s_hatch1_red");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_silv_destructible","vehicle_80s_hatch1_silv");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_tan_destructible","vehicle_80s_hatch1_tan");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_yel_destructible","vehicle_80s_hatch1_yel");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_decayed_brn_destructible","vehicle_80s_hatch1_decayed_brn");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_decayed_green_destructible","vehicle_80s_hatch1_decayed_green");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_decayed_red_destructible","vehicle_80s_hatch1_decayed_red");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_decayed_silv_destructible","vehicle_80s_hatch1_decayed_silv");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_decayed_white_destructible","vehicle_80s_hatch1_decayed_white");
	maps\_vehicle::build_destructible("vehicle_80s_hatch1_decayed_yel_destructible","vehicle_80s_hatch1_decayed_yel");
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 2
init_local()
{
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 4
setanims()
{
	var_00 = [];
	return var_00;
	return var_00;
}