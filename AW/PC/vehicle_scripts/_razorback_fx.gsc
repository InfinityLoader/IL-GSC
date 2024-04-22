/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _razorback_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 444 ms
 * Timestamp: 4/22/2024 2:05:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["light_point_red_solid_nolens"] = loadfx("vfx/lights/light_wingtip_red_med_point_nolens");
	level._effect["razorback_tread_smk_regular_runner"] = loadfx("vfx/treadfx/razorback_tread_smk_regular_runner");
	level._effect["razorback_tread_smk_strong_runner"] = loadfx("vfx/treadfx/razorback_tread_smk_strong_runner");
	level._effect["razorback_tread_smk_idle_runner"] = loadfx("vfx/treadfx/razorback_tread_smk_idle_runner");
	level._effect["razorback_exhaust_regular"] = loadfx("vfx/vehicle/razorback_exhaust_regular");
	level._effect["razorback_exhaust_idle"] = loadfx("vfx/vehicle/razorback_exhaust_idle");
	level._effect["razorback_exhaust_strong"] = loadfx("vfx/vehicle/razorback_exhaust_strong");
	level._effect["razorback_exhaust_light_flicker"] = loadfx("vfx/vehicle/razorback_exhaust_light_flicker");
	level._effect["razorback_exhaust_tail_left_regular"] = loadfx("vfx/vehicle/razorback_exhaust_tail_left_regular");
	level._effect["razorback_exhaust_tail_right_regular"] = loadfx("vfx/vehicle/razorback_exhaust_tail_right_regular");
}

//Function Number: 2
vfx_rb_thruster_front_light_on(param_00)
{
	maps\_utility::delaythread(0.4,::play_back_thruster_light_rz);
	maps\_utility::delaythread(0.45,::play_front_thruster_light_rz);
}

//Function Number: 3
vfx_rb_thruster_front_light_off(param_00)
{
	maps\_utility::delaythread(3.8,::stop_back_thruster_light_rz);
	maps\_utility::delaythread(6.5,::stop_front_thruster_light_rz);
}

//Function Number: 4
vfx_rb_thruster_front_on(param_00)
{
	maps\_utility::delaythread(0,::play_regular_front_thruster_rz,param_00);
	maps\_utility::delaythread(0.2,::play_regular_tread_front_rz,param_00);
	maps\_utility::delaythread(0.3,::play_regular_tail_thruster_rz,param_00);
	maps\_utility::delaythread(0.05,::stop_idle_front_thruster_rz,param_00);
	maps\_utility::delaythread(0.15,::stop_idle_tread_front_rz,param_00);
}

//Function Number: 5
vfx_rb_thruster_front_off(param_00)
{
	maps\_utility::delaythread(0,::stop_regular_front_thruster_rz,param_00);
	maps\_utility::delaythread(0.2,::stop_regular_tail_thruster_rz,param_00);
	maps\_utility::delaythread(0.3,::stop_regular_tread_front_rz,param_00);
	maps\_utility::delaythread(0.05,::play_idle_front_thruster_rz,param_00);
	maps\_utility::delaythread(0.15,::play_idle_tread_front_rz,param_00);
}

//Function Number: 6
vfx_rb_thruster_back_on(param_00)
{
	wait(0.1);
	maps\_utility::delaythread(0,::play_regular_back_thruster_rz,param_00);
	maps\_utility::delaythread(0.1,::play_regular_tread_back_rz,param_00);
	maps\_utility::delaythread(0.3,::stop_idle_back_thruster_rz,param_00);
	maps\_utility::delaythread(0.05,::vfx_razorback_jets_on,param_00);
}

//Function Number: 7
vfx_rb_thruster_back_off(param_00)
{
	wait(0.1);
	maps\_utility::delaythread(0,::stop_regular_back_thruster_rz,param_00);
	maps\_utility::delaythread(0.1,::stop_regular_tread_back_rz,param_00);
	maps\_utility::delaythread(0.3,::play_idle_back_thruster_rz,param_00);
	maps\_utility::delaythread(0.05,::vfx_razorback_jets_off,param_00);
}

//Function Number: 8
play_regular_front_thruster_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_TR_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 9
stop_regular_front_thruster_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_TR_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 10
play_regular_tread_front_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_TR_FX");
	playfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 11
stop_regular_tread_front_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_TR_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 12
play_idle_tread_front_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_tread_smk_idle_runner"),param_00,"thrusterCenter_TR_FX");
	playfxontag(common_scripts\utility::getfx("razorback_tread_smk_idle_runner"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 13
stop_idle_tread_front_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_tread_smk_idle_runner"),param_00,"thrusterCenter_TR_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_tread_smk_idle_runner"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 14
play_idle_front_thruster_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_TR_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 15
stop_idle_front_thruster_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_TR_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_TL_FX");
}

//Function Number: 16
play_front_thruster_light_rz()
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_TR_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_TL_FX");
}

//Function Number: 17
stop_front_thruster_light_rz()
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_TR_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_TL_FX");
}

//Function Number: 18
play_regular_tail_thruster_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_tail_right_regular"),param_00,"thrusterCenter_KR_FX1");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_tail_left_regular"),param_00,"thrusterCenter_KL_FX1");
}

//Function Number: 19
stop_regular_tail_thruster_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_tail_right_regular"),param_00,"thrusterCenter_KR_FX1");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_tail_left_regular"),param_00,"thrusterCenter_KL_FX1");
}

//Function Number: 20
play_regular_back_thruster_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_BL_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_BR_FX");
}

//Function Number: 21
stop_regular_back_thruster_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_BL_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),param_00,"thrusterCenter_BR_FX");
}

//Function Number: 22
play_regular_tread_back_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_BL_FX");
	playfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_BR_FX");
}

//Function Number: 23
stop_regular_tread_back_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_BL_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_tread_smk_regular_runner"),param_00,"thrusterCenter_BR_FX");
}

//Function Number: 24
play_idle_back_thruster_rz(param_00)
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_BL_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_BR_FX");
}

//Function Number: 25
stop_idle_back_thruster_rz(param_00)
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_BL_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),param_00,"thrusterCenter_BR_FX");
}

//Function Number: 26
play_back_thruster_light_rz()
{
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_BR_FX");
	playfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_BL_FX");
}

//Function Number: 27
stop_back_thruster_light_rz()
{
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_BR_FX");
	stopfxontag(common_scripts\utility::getfx("razorback_exhaust_light_flicker"),self,"thrusterCenter_BL_FX");
}

//Function Number: 28
play_thruster_amount_given_tag(param_00,param_01,param_02)
{
	self endon("kill_" + param_02);
	wait(param_00 * 0.05);
	if(param_01 == "idle")
	{
		stopfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),self,param_02);
		wait(0.05);
		stopfxontag(common_scripts\utility::getfx("razorback_exhaust_strong"),self,param_02);
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),self,param_02);
		wait(0.05);
		return;
	}

	if(param_01 == "regular")
	{
		wait(0.05);
		stopfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),self,param_02);
		wait(0.05);
		stopfxontag(common_scripts\utility::getfx("razorback_exhaust_strong"),self,param_02);
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),self,param_02);
		wait(0.05);
		return;
	}

	if(param_01 == "strong")
	{
		stopfxontag(common_scripts\utility::getfx("razorback_exhaust_idle"),self,param_02);
		wait(0.05);
		stopfxontag(common_scripts\utility::getfx("razorback_exhaust_regular"),self,param_02);
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("razorback_exhaust_strong"),self,param_02);
		wait(0.05);
		return;
	}
}

//Function Number: 29
vfx_red_lights_on()
{
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("light_point_red_solid_nolens"),self,"TAG_LIGHT_BACK_RIGHT");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("light_point_red_solid_nolens"),self,"TAG_LIGHT_BACK_LEFT");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("light_point_red_solid_nolens"),self,"TAG_LIGHT_RIGHT");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("light_point_red_solid_nolens"),self,"TAG_LIGHT_LEFT");
}

//Function Number: 30
vfx_razorback_jets_off(param_00)
{
	level.razorback notify("stop_kicking_up_dustthrusterCenter_BR_FX");
	level.razorback notify("stop_kicking_up_dustthrusterCenter_BL_FX");
}

//Function Number: 31
vfx_razorback_jets_on(param_00)
{
	level.razorback thread maps\_vehicle_code::aircraft_wash_thread(undefined,"thrusterCenter_BR_FX");
	level.razorback thread maps\_vehicle_code::aircraft_wash_thread(undefined,"thrusterCenter_BL_FX");
}