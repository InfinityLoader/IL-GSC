/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_mig29.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 232 ms
 * Timestamp: 10/27/2023 2:51:10 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("mig29",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_mig29_desert");
	maps\_vehicle::build_deathmodel("vehicle_av8b_harrier_jet");
	buildmig29fx("afterburner","fx/fire/jet_afterburner");
	buildmig29fx("contrail","fx/smoke/jet_contrail");
	buildmig29fx("contrail_02","fx/smoke/jet_contrail_02");
	maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_rumble("mig_rumble",0.1,0.2,11300,0.05,0.05);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_is_airplane();
}

//Function Number: 2
init_local()
{
	thread playafterburner();
	thread playcontrail();
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	var_01 = "rope_test";
	precachemodel(var_01);
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

	return var_00;
}

//Function Number: 5
playafterburner()
{
	playfxontag(level._effect["afterburner"],self,"tag_engine_right");
	playfxontag(level._effect["afterburner"],self,"tag_engine_left");
}

//Function Number: 6
playcontrail()
{
	playfxontag(level._effect["contrail"],self,"tag_right_wingtip");
	playfxontag(level._effect["contrail_02"],self,"tag_left_wingtip");
}

//Function Number: 7
playerisclose(param_00)
{
	var_01 = playerisinfront(param_00);
	if(var_01)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = -1;
	}

	var_03 = common_scripts\utility::flat_origin(param_00.origin);
	var_04 = var_03 + anglestoforward(common_scripts\utility::flat_angle(param_00.angles)) * var_02 * 100000;
	var_05 = pointonsegmentnearesttopoint(var_03,var_04,level.player.origin);
	var_06 = distance(var_03,var_05);
	var_07 = 3000;
	if(isdefined(level.mig29_near_distance_override))
	{
		var_07 = level.mig29_near_distance_override;
	}

	return var_06 < var_07;
}

//Function Number: 8
playerisinfront(param_00)
{
	var_01 = anglestoforward(common_scripts\utility::flat_angle(param_00.angles));
	var_02 = vectornormalize(common_scripts\utility::flat_origin(level.player.origin) - param_00.origin);
	var_03 = vectordot(var_01,var_02);
	if(var_03 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
plane_sound_node()
{
	self waittill("trigger",var_00);
	var_00 endon("death");
	thread plane_sound_node();
	var_00 thread common_scripts\utility::play_loop_sound_on_entity("veh_mig29_dist_loop");
	var_01 = 0;
	if(isdefined(self.script_parameters) && self.script_parameters == "play_additional_sound")
	{
		var_01 = 1;
	}

	var_00 thread plane_passby_sfx(var_01);
	while(playerisinfront(var_00))
	{
		wait(0.05);
	}

	wait(0.5);
	var_00 thread common_scripts\utility::play_sound_in_space("veh_mig29_sonic_boom");
	var_00 waittill("reached_end_node");
	var_00 stop_sound("veh_mig29_dist_loop");
	var_00 delete();
}

//Function Number: 10
plane_passby_sfx(param_00)
{
	self endon("death");
	self endon("reached_end_node");
	while(!playerisclose(self))
	{
		wait(0.05);
	}

	thread maps\_utility::play_sound_on_entity("veh_mig29_passby");
	if(param_00)
	{
		thread maps\_utility::play_sound_on_entity("veh_mig29_passby_layer");
	}
}

//Function Number: 11
plane_bomb_node()
{
	buildmig29fx("plane_bomb_explosion1","fx/explosions/airlift_explosion_large");
	buildmig29fx("plane_bomb_explosion2","fx/explosions/tanker_explosion");
	self waittill("trigger",var_00);
	var_00 endon("death");
	thread plane_bomb_node();
	var_01 = getentarray(self.script_linkto,"script_linkname");
	var_01 = common_scripts\utility::get_array_of_closest(self.origin,var_01,undefined,var_01.size);
	var_02 = 0;
	wait(randomfloatrange(0.3,0.8));
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_02++;
		if(var_02 == 3)
		{
			var_02 = 1;
		}

		var_01[var_03] thread maps\_utility::play_sound_on_entity("airstrike_explosion");
		var_04 = "plane_bomb_explosion" + var_02;
		var_05 = level._effect[var_04];
		if(isdefined(level.plane_bomb_explosion_overrides) && isdefined(level.plane_bomb_explosion_overrides[var_04]))
		{
			var_05 = level.plane_bomb_explosion_overrides[var_04];
		}

		playfx(var_05,var_01[var_03].origin);
		wait(randomfloatrange(0.3,1.2));
	}
}

//Function Number: 12
plane_bomb_cluster()
{
	self waittill("trigger",var_00);
	var_00 endon("death");
	var_01 = var_00;
	var_01 thread plane_bomb_cluster();
	var_02 = spawn("script_model",var_01.origin - (0,0,100));
	var_02.angles = var_01.angles;
	var_02 setmodel("projectile_cbu97_clusterbomb");
	var_03 = anglestoforward(var_01.angles) * 2;
	var_04 = anglestoup(var_01.angles) * -0.2;
	var_05 = [];
	for(var_06 = 0;var_06 < 3;var_06++)
	{
		var_05[var_06] = var_03[var_06] + var_04[var_06] / 2;
	}

	var_05 = (var_05[0],var_05[1],var_05[2]);
	var_05 = var_05 * 7000;
	var_02 movegravity(var_05,2);
	wait(1.2);
	var_07 = spawn("script_model",var_02.origin);
	var_07 setmodel("tag_origin");
	var_07.origin = var_02.origin;
	var_07.angles = var_02.angles;
	wait(0.05);
	var_02 delete();
	var_02 = var_07;
	var_08 = var_02.origin;
	var_09 = var_02.angles;
	playfxontag(level.airstrikefx,var_02,"tag_origin");
	wait(1.6);
	var_0A = 12;
	var_0B = 5;
	var_0C = 55;
	var_0D = var_0C - var_0B / var_0A;
	for(var_06 = 0;var_06 < var_0A;var_06++)
	{
		var_0E = anglestoforward(var_09 + (var_0C - var_0D * var_06,randomint(10) - 5,0));
		var_0F = var_08 + var_0E * 10000;
		var_10 = bullettrace(var_08,var_0F,0,undefined);
		var_11 = var_10["position"];
		radiusdamage(var_11 + (0,0,16),512,400,30);
		if(var_06 % 3 == 0)
		{
			thread common_scripts\utility::play_sound_in_space("airstrike_explosion",var_11);
			playrumbleonposition("artillery_rumble",var_11);
			earthquake(0.7,0.75,var_11,1000);
		}

		wait(0.75 / var_0A);
	}

	wait(1);
	var_02 delete();
}

//Function Number: 13
stop_sound(param_00)
{
	self notify("stop sound" + param_00);
}

//Function Number: 14
setmig29fxoverride(param_00,param_01)
{
	if(!isdefined(level.mig29_fx_override))
	{
		level.mig29_fx_override = [];
	}

	level.mig29_fx_override[param_00] = param_01;
}

//Function Number: 15
buildmig29fx(param_00,param_01)
{
	if(isdefined(level.mig29_fx_override) && isdefined(level.mig29_fx_override[param_00]))
	{
		param_01 = level.mig29_fx_override[param_00];
	}

	level._effect[param_00] = loadfx(param_01);
}