/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _attack_drone_queen.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 56 ms
 * Timestamp: 4/22/2024 2:04:29 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel(param_00);
	if(level.currentgen)
	{
		precachemodel("vehicle_mil_attack_drone_static_multi_cg");
	}

	maps\_utility::set_console_status();
	level._effect["queen_drone_beacon_red"] = loadfx("vfx/lights/light_drone_beacon_red_single");
	level._effect["droneswarm_tread"] = loadfx("vfx/treadfx/droneswarm_tread_dust");
	level._effect["droneswarm_tread_water"] = loadfx("vfx/treadfx/droneswarm_tread_water");
	maps\_vehicle::build_template("attack_drone_queen",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathquake(0.4,0.8,1024);
	maps\_vehicle::build_life(499);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
init_local()
{
	self.script_cheap = 1;
	self.script_badplace = 0;
	self.dontdisconnectpaths = 1;
	self.contents = self setcontents(0);
	self.ignore_death_fx = 1;
	self.delete_on_death = 1;
	thread vehicle_scripts\_attack_drone_aud::attack_drone_queen_audio();
	thread attack_drone_queen_flying_fx();
	self hide();
	self makevehiclenotcollidewithplayers();
}

//Function Number: 3
attack_drone_queen_flying_fx()
{
	var_00 = 0.15;
	var_01 = squared(975);
	var_02 = (0,0,-195);
	var_03 = 0.2;
	var_04 = anglestoforward(self.angles + (-90,0,0));
	var_05 = anglestoup(self.angles + (-90,0,0));
	self endon("death");
	if(randomfloat(1) > var_00)
	{
		return;
	}

	wait(randomfloat(var_03));
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < var_01)
		{
			var_06 = bullettrace(self.origin,self.origin + var_02,0);
			if(var_06["fraction"] < 1)
			{
				if(var_06["surfacetype"] != "water_waist")
				{
					playfx(common_scripts\utility::getfx("droneswarm_tread"),var_06["position"],var_04,var_05);
				}
				else
				{
					playfx(common_scripts\utility::getfx("droneswarm_tread_water"),var_06["position"],var_04,var_05);
				}
			}
		}

		wait(var_03);
	}
}