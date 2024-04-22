/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _atlas_piranha.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 2:04:18 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02,param_03)
{
	precachemodel("vehicle_speedboat_piranha_turret");
	precacheturret("warbird_turret");
	maps\_vehicle::build_template("atlas_piranha",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	if(isdefined(param_03))
	{
		maps\_vehicle::build_turret(param_03,"tag_turret","vehicle_speedboat_piranha_turret",undefined,"manual",0.5,20,-14);
	}
}

//Function Number: 2
init_local()
{
}