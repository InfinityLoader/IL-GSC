/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _s19.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 124 ms
 * Timestamp: 4/22/2024 2:05:31 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("s19_player",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_mig29");
	maps\_vehicle::build_deathmodel("vehicle_mig29_low");
	maps\_vehicle::build_treadfx();
	level._effect["s19_engineeffect"] = loadfx("vfx/map/baghdad/bagh_sentinel_jet_mainengines");
	level._effect["s19_afterburner"] = loadfx("fx/fire/jet_afterburner_ignite");
	level._effect["s19_contrail"] = loadfx("vfx/trail/jet_contrail_cheap");
	maps\_vehicle::build_deathfx("vfx/map/baghdad/bagh_aircraft_explosion_midair",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	var_03 = randomfloatrange(0,1);
	maps\_vehicle::build_light(param_02,"wingtip_green","tag_left_wingtip","fx/misc/aircraft_light_wingtip_green","running",var_03);
	maps\_vehicle::build_light(param_02,"wingtip_red","tag_right_wingtip","fx/misc/aircraft_light_wingtip_red","running",var_03);
	maps\_vehicle::build_is_airplane();
	maps\_vehicle::build_death_jolt_delay(9999);
}

//Function Number: 2
init_local()
{
	thread playengineeffects();
	thread fx_contrail_handler();
	thread landing_gear_up();
}

//Function Number: 3
landing_gear_up()
{
	self useanimtree(#animtree);
	self setanim(%mig_landing_gear_up);
}

//Function Number: 4
playengineeffects()
{
	self endon("death");
	self endon("stop_engineeffects");
	maps\_utility::ent_flag_init("engineeffects");
	maps\_utility::ent_flag_set("engineeffects");
	var_00 = common_scripts\utility::getfx("s19_engineeffect");
	for(;;)
	{
		maps\_utility::ent_flag_wait("engineeffects");
		playfxontag(var_00,self,"tag_engine_left");
		maps\_utility::ent_flag_waitopen("engineeffects");
		stopfxontag(var_00,self,"tag_engine_left");
	}
}

//Function Number: 5
playafterburner()
{
	playfxontag(level._effect["s19_afterburner"],self,"tag_engine_right");
	playfxontag(level._effect["s19_afterburner"],self,"tag_engine_left");
}

//Function Number: 6
playcontrail()
{
	playfxontag(level._effect["s19_contrail"],self,"tag_right_wingtip");
	playfxontag(level._effect["s19_contrail"],self,"tag_left_wingtip");
}

//Function Number: 7
stopcontrail()
{
	stopfxontag(level._effect["s19_contrail"],self,"tag_right_wingtip");
	stopfxontag(level._effect["s19_contrail"],self,"tag_left_wingtip");
}

//Function Number: 8
fx_contrail_handler()
{
	level endon("death");
	var_00 = 45;
	var_01 = 0;
	while(isdefined(self))
	{
		var_02 = self.angles;
		var_03 = var_02[0];
		var_04 = var_02[2];
		var_05 = 0;
		if((var_04 > var_00 && var_04 < 360 - var_00) || var_04 < -1 * var_00 && var_04 > -1 * 360 - var_00)
		{
			var_05 = 1;
		}

		if((var_03 > var_00 && var_03 < 360 - var_00) || var_03 < -1 * var_00 && var_03 > -1 * 360 - var_00)
		{
			var_05 = 1;
		}

		if(var_05 && !var_01)
		{
			playcontrail();
			var_01 = 1;
			continue;
		}

		if(!var_05 && var_01)
		{
			stopcontrail();
			var_01 = 0;
		}

		wait 0.05;
	}
}