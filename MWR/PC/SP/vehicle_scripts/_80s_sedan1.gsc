/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_80s_sedan1.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 77 ms
 * Timestamp: 10/27/2023 2:46:14 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("80s_sedan1",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_brn","vehicle_80s_sedan1_brn_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_green","vehicle_80s_sedan1_green_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_red","vehicle_80s_sedan1_red_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_silv","vehicle_80s_sedan1_silv_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_tan","vehicle_80s_sedan1_tan_destroyed");
	maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_yel","vehicle_80s_sedan1_yel_destroyed");
	maps\_vehicle::build_destructible("vehicle_80s_sedan1_brn_destructible","vehicle_80s_sedan1_brn");
	maps\_vehicle::build_destructible("vehicle_80s_sedan1_green_destructible","vehicle_80s_sedan1_green");
	maps\_vehicle::build_destructible("vehicle_80s_sedan1_red_destructible","vehicle_80s_sedan1_red");
	maps\_vehicle::build_destructible("vehicle_80s_sedan1_silv_destructible","vehicle_80s_sedan1_silv");
	maps\_vehicle::build_destructible("vehicle_80s_sedan1_tan_destructible","vehicle_80s_sedan1_tan");
	maps\_vehicle::build_destructible("vehicle_80s_sedan1_yel_destructible","vehicle_80s_sedan1_yel");
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_treadfx();
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
	for(var_01 = 0;var_01 < 1;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[0].idle = %luxurysedan_driver_idle;
	return var_00;
}