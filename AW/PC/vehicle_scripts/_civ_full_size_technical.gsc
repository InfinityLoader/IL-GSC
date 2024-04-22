/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _civ_full_size_technical.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 83 ms
 * Timestamp: 4/22/2024 2:04:40 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	build_technical(param_00,param_01,param_02,"vehicle_civ_full_size_technical_turret","50cal_turret_technical_lagos");
}

//Function Number: 2
build_technical(param_00,param_01,param_02,param_03,param_04)
{
	maps\_vehicle::build_template("civ_full_size_technical",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%technical_driving_idle_forward,%technical_driving_idle_backward,10);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_small_runner","TAG_DEATH_FX",undefined,undefined,undefined,undefined,0);
	if(issubstr(param_02,"script_vehicle_civ_full_size_technical_turret"))
	{
		maps\_vehicle::build_turret(param_04,"tag_turret",param_03,undefined,"auto_ai",0.5,20,-14);
	}

	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
}

//Function Number: 3
init_local()
{
	soundscripts\_snd::snd_message("atlas_van_explode");
	if(!isdefined(self.script_allow_rider_deaths))
	{
		self.script_allow_rider_deaths = 1;
	}
}

//Function Number: 4
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %technical_exit_driver_technical;
	param_00[1].vehicle_turret_fire = %technical_fire_turret;
	param_00[2].vehicle_getoutanim = %technical_exit_passenger_technical;
	return param_00;
}

//Function Number: 5
setanims()
{
	var_00 = 3;
	var_01 = [];
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		var_01[var_02] = spawnstruct();
	}

	var_01[0].sittag = "tag_driver";
	var_01[0].idle = %technical_idle_driver;
	var_01[0].getout = %technical_exit_driver;
	var_01[1].sittag = "tag_guy_turret_gun";
	var_01[1].sittag_on_turret = 1;
	var_01[1].death = %technical_death_gunner;
	var_01[1].idle = %technical_idle_gunner;
	var_01[1].mgturret = 0;
	var_01[1].death_no_ragdoll = 1;
	var_01[2].sittag = "tag_passenger";
	var_01[2].idle = %technical_passenger_idle;
	var_01[2].getout = %technical_exit_passenger;
	return var_01;
}