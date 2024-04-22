/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _sniper_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 91 ms
 * Timestamp: 4/22/2024 2:05:34 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel(param_00);
	level._effect["drone_fan_distortion"] = loadfx("vfx/distortion/sniper_drone_runner");
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/heli_dust_default");
	maps\_vehicle::build_template("sniper_drone",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_life(499);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 3
set_ai_anims()
{
	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].sittag = "tag_player";
	var_00[0].bhasgunwhileriding = 1;
	return var_00;
}

//Function Number: 4
init_local()
{
	thread pdrone_flying_fx();
	thread start_sniper_drone_audio();
}

//Function Number: 5
pdrone_flying_fx()
{
	self endon("death");
	if(self.classname == "script_vehicle_sniper_drone")
	{
		playfxontag(common_scripts\utility::getfx("drone_fan_distortion"),self,"TAG_ORIGIN");
	}
}

//Function Number: 6
start_sniper_drone_audio()
{
	var_00 = spawnstruct();
	var_00.preset_name = "sniper_drone";
	var_01 = ::vehicle_scripts\_sniper_drone_aud::snd_sniper_drone_constructor;
	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}