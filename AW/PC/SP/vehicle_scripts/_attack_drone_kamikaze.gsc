/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_attack_drone_kamikaze.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 115 ms
 * Timestamp: 10/27/2023 2:06:13 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel(param_00);
	maps\_utility::set_console_status();
	level._effect["pdrone_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["pdrone_large_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_large_explosion");
	level._effect["kamikaze_drone_beacon_attack"] = loadfx("vfx/lights/light_drone_beacon_attack");
	maps\_vehicle::build_template("attack_drone_kamikaze",param_00,param_01,param_02);
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
	thread vehicle_scripts\_attack_drone_aud::attack_drone_kamikaze_audio();
	thread attack_drone_kamikaze_flying_fx();
	if(isdefined(self.script_parameters) && self.script_parameters == "diveboat_weapon_target")
	{
		self.contents = self setcontents(self.contents);
		self.custom_death_script = ::handle_death;
		target_set(self,(0,0,0));
		target_hidefromplayer(self,level.player);
	}
}

//Function Number: 3
attack_drone_kamikaze_flying_fx()
{
	playfxontag(common_scripts\utility::getfx("kamikaze_drone_beacon_attack"),self,"tag_origin");
}

//Function Number: 4
handle_death()
{
	if(!isdefined(self))
	{
		return;
	}

	self.crashing = 1;
	if(self.script_team != "allies" && !isdefined(self.owner) && isdefined(self.last_damage_attacker) && randomfloat(1) < 0.33)
	{
		if(randomfloat(1) < 0.5)
		{
			death_crash_nearby_player(self.last_damage_attacker);
		}
		else
		{
			thread death_spiral(self.last_damage_attacker);
		}
	}
	else
	{
		play_death_explosion_fx();
	}

	if(isdefined(self))
	{
		self notify("crash_done");
		self delete();
	}
}

//Function Number: 5
play_death_explosion_fx()
{
	if(self.classname == "script_vehicle_pdrone_atlas_large")
	{
		playfx(common_scripts\utility::getfx("pdrone_large_death_explosion"),self gettagorigin("tag_origin"));
		soundscripts\_snd::snd_message("pdrone_death_explode");
		return;
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),self gettagorigin("tag_origin"));
	soundscripts\_snd::snd_message("pdrone_death_explode");
}

//Function Number: 6
death_spiral(param_00)
{
	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	if(isdefined(self.death_model_override))
	{
		var_01 setmodel(self.death_model_override);
	}
	else
	{
		var_01 setmodel(self.model);
	}

	self hide();
	stopfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("emp_drone_damage"),var_01,"TAG_ORIGIN");
	soundscripts\_snd::snd_message("pdrone_emp_death",var_01);
	var_02 = (self.origin[0],self.origin[1],self.origin[2] - 500);
	var_03 = physicstrace(self.origin,var_02);
	var_04 = 0;
	var_05 = 5;
	var_06 = param_00.origin - var_01.origin;
	var_06 = vectornormalize(var_06);
	var_07 = vectorcross((0,0,1),var_06);
	var_07 = vectornormalize(var_07);
	var_08 = 100;
	var_09 = var_01.origin + var_07 * var_08;
	var_0A = vectortoangles(var_01.origin - var_09);
	var_0B = 1;
	if(common_scripts\utility::cointoss())
	{
		var_0B = -1;
	}

	while(var_04 < 5)
	{
		wait(0.05);
		var_04 = var_04 + 0.05;
		var_0A = var_0A + (0,10,0) * var_0B;
		var_0C = maps\_utility::linear_interpolate(clamp(var_04 / 3,0,1),2,30);
		var_09 = var_09 - (0,0,var_0C);
		var_0D = var_09 + anglestoforward(var_0A) * var_08;
		var_0E = physicstrace(var_01.origin,var_0D,var_01);
		var_01.origin = var_0D;
		var_01.angles = var_01.angles + (0,50,0) * var_0B;
		var_0F = length(var_03 - var_01.origin);
		if(var_0F < 60 || var_01.origin[2] < var_03[2] + 15 || var_0E != var_0D)
		{
			break;
		}
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),var_01.origin);
	soundscripts\_snd::snd_message("pdrone_crash_land",var_01.origin);
	var_01 delete();
}

//Function Number: 7
death_crash_nearby_player(param_00)
{
	self.vehicle_stays_alive = 1;
	var_01 = param_00.origin - self.origin;
	var_01 = vectornormalize(var_01);
	var_02 = vectorcross((0,0,1),var_01);
	var_02 = vectornormalize(var_02);
	if(common_scripts\utility::cointoss())
	{
		var_02 = var_02 * -1;
	}

	var_03 = param_00.origin - var_01 * (1,1,0) * 250 + var_02 * 250;
	var_03 = (var_03[0],var_03[1],self.origin[2]);
	var_04 = common_scripts\utility::randomvectorincone(vectornormalize(var_03 - self.origin),15);
	var_05 = self.origin + var_04 * 250;
	var_03 = physicstrace(self.origin,var_05);
	self notify("newpath");
	self notify("deathspin");
	self setneargoalnotifydist(60);
	self vehicle_helisetai(var_03,drone_parm("speed") * 0.75,drone_parm("accel"),drone_parm("decel"),undefined,undefined,0,0,0,0,0,0,0);
	common_scripts\utility::waittill_any("goal","near_goal");
	death_plummet();
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
}

//Function Number: 8
death_plummet()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 setmodel(self.model);
	self hide();
	if(!issubstr(self.classname,"_security"))
	{
		stopfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"tag_origin");
	}

	var_01 = 0;
	var_02 = self vehicle_getvelocity();
	var_03 = squared(0.05);
	var_04 = (0,0,-980);
	while(var_01 < 5)
	{
		wait(0.05);
		var_02 = var_04 * 0.05 + var_02;
		var_02 = vectorclamp(var_02,1000);
		var_05 = var_02 * 0.05 + var_04 * var_03 / 2;
		var_06 = var_00.origin + var_05;
		var_07 = physicstrace(var_00.origin,var_06,var_00);
		if(var_07 != var_06)
		{
			break;
		}

		var_00.origin = var_06;
		var_00.angles = var_00.angles + (0,5,0);
		var_01 = var_01 + 0.05;
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),var_00.origin);
	soundscripts\_snd::snd_message("pdrone_crash_land",var_00.origin);
	var_00 delete();
}

//Function Number: 9
drone_parm(param_00)
{
	return level.pdrone_parms[self.classname][param_00];
}