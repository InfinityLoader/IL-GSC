/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_sp_airstrike.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 408 ms
 * Timestamp: 10/27/2023 2:21:02 AM
*******************************************************************/

//Function Number: 1
airstrike_preload()
{
	precachelocationselector("map_artillery_selector");
	precacheitem("killstreak_precision_airstrike_sp");
	precacheitem("killstreak_stealth_airstrike_sp");
	precacheitem("stealth_bomb_mp");
	precacheitem("artillery_mp");
	precacheitem("harrier_missile_mp");
	precachemodel("vehicle_mig29_desert");
	precachemodel("vehicle_av8b_harrier_jet_mp");
	precachemodel("vehicle_av8b_harrier_jet_opfor_mp");
	precachemodel("weapon_minigun");
	precachemodel("vehicle_b2_bomber");
	precachemodel("projectile_cbu97_clusterbomb");
	precacheshader("specialty_precision_airstrike");
	precacheshader("dpad_killstreak_precision_airstrike");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_PRECISION_AIRSTRIKE");
	precachestring(&"SP_KILLSTREAKS_EARNED_PRECISION_AIRSTRIKE");
	precachestring(&"SP_KILLSTREAKS_PRECISION_AIRSTRIKE_PICKUP");
	precacheshader("specialty_stealth_bomber");
	precacheshader("dpad_killstreak_stealth_bomber");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_STEALTH_AIRSTRIKE");
	precachestring(&"SP_KILLSTREAKS_EARNED_STEALTH_AIRSTRIKE");
	precachestring(&"SP_KILLSTREAKS_STEALTH_AIRSTRIKE_PICKUP");
	level.var_3442 = loadfx("fire/fire_smoke_trail_L");
	level.var_3443 = loadfx("explosions/clusterbomb");
	level.mortareffect = loadfx("explosions/artilleryExp_dirt_brown");
	level.bombstrike = loadfx("explosions/wall_explosion_pm_a");
	level.stealthbombfx = loadfx("explosions/stealth_bomb_mp");
	level.planes = 0;
	level.harrier_smoke = loadfx("fire/jet_afterburner_harrier_damaged");
	level.harrier_deathfx = loadfx("explosions/aerial_explosion_harrier");
	level.harrier_afterburnerfx = loadfx("fire/jet_afterburner_harrier");
	level.fx_airstrike_afterburner = loadfx("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx("smoke/jet_contrail");
	level.dangermaxradius["stealth"] = 900;
	level.dangerminradius["stealth"] = 750;
	level.dangerforwardpush["stealth"] = 1;
	level.dangerovalscale["stealth"] = 6;
	level.dangermaxradius["default"] = 550;
	level.dangerminradius["default"] = 300;
	level.dangerforwardpush["default"] = 1.5;
	level.dangerovalscale["default"] = 6;
	level.dangermaxradius["precision"] = 550;
	level.dangerminradius["precision"] = 300;
	level.dangerforwardpush["precision"] = 2;
	level.dangerovalscale["precision"] = 6;
	level.dangermaxradius["harrier"] = 550;
	level.dangerminradius["harrier"] = 300;
	level.dangerforwardpush["harrier"] = 1.5;
	level.dangerovalscale["harrier"] = 6;
	level.artillerydangercenters = [];
}

//Function Number: 2
try_use_airstrike(param_00)
{
	if(isdefined(self.using_uav) && self.using_uav)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = "precision";
	}

	switch(param_00)
	{
		case "precision":
			break;

		case "stealth":
			break;

		case "harrier":
			if(level.planes > 1)
			{
				iprintlnbold("Air space too crowded!");
				return 0;
			}
			break;

		case "super":
			break;
	}

	var_01 = airstrike_location_select(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	thread finish_using_airstrike(param_00,var_01.location,var_01.directionyaw);
	return 1;
}

//Function Number: 3
airstrike_location_select(param_00)
{
	var_01 = 0;
	if(param_00 == "precision" || param_00 == "stealth")
	{
		var_01 = 1;
	}

	var_02 = level.mapsize / 5.625;
	if(issplitscreen())
	{
		var_02 = var_02 * 1.5;
	}

	self beginlocationselection("map_artillery_selector",var_01,var_02);
	self.selectinglocation = 1;
	self setblurforplayer(4,0.3);
	thread waitforairstrikecancel();
	thread endselectionon("cancel_location");
	thread endselectionon("death");
	thread endselectionon("disconnect");
	self endon("stop_location_selection");
	self waittill("confirm_location",var_03,var_04);
	if(!var_01)
	{
		var_04 = randomint(360);
	}

	self setblurforplayer(0,0.3);
	if(param_00 == "harrier" && level.planes > 1)
	{
		self notify("cancel_location");
		iprintlnbold("Air space too crowded!");
		return 0;
	}

	var_05 = spawnstruct();
	var_05.location = var_03;
	var_05.directionyaw = var_04;
	maps\_utility::delaythread(0.05,::stopairstrikelocationselection);
	return var_05;
}

//Function Number: 4
waitforairstrikecancel()
{
	self waittill("cancel_location");
	self setblurforplayer(0,0.3);
}

//Function Number: 5
endselectionon(param_00)
{
	self endon("stop_location_selection");
	self waittill(param_00);
	thread stopairstrikelocationselection();
}

//Function Number: 6
stopairstrikelocationselection()
{
	self setblurforplayer(0,0.3);
	self endlocationselection();
	self.selectinglocation = undefined;
	self notify("stop_location_selection");
}

//Function Number: 7
finish_using_airstrike(param_00,param_01,param_02)
{
	var_03 = bullettrace(level.mapcenter + (0,0,1000000),level.mapcenter,0,undefined);
	param_01 = (param_01[0],param_01[1],var_03["position"][2] - 514);
	thread do_airstrike(param_00,param_01,param_02,self,self.team);
}

//Function Number: 8
do_airstrike(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		param_00 = "default";
	}

	if(param_00 == "harrier")
	{
		level.planes++;
	}

	if(isdefined(level.airstrikeinprogress))
	{
		while(isdefined(level.airstrikeinprogress))
		{
			level waittill("begin_airstrike");
		}

		level.airstrikeinprogress = 1;
		wait 2;
	}

	if(!isdefined(param_03))
	{
		if(param_00 == "harrier")
		{
			level.planes--;
		}

		return;
	}

	level.airstrikeinprogress = 1;
	var_05 = 17 + randomint(3);
	var_06 = bullettrace(param_01,param_01 + (0,0,-1000000),0,undefined);
	var_07 = var_06["position"];
	var_08 = spawnstruct();
	var_08.origin = var_07;
	var_08.forward = anglestoforward((0,param_02,0));
	var_08.airstriketype = param_00;
	level.artillerydangercenters[level.artillerydangercenters.size] = var_08;
	var_09 = callstrike(param_03,var_07,param_02,param_00);
	wait 1;
	level.airstrikeinprogress = undefined;
	param_03 notify("begin_airstrike");
	level notify("begin_airstrike");
	wait 7.5;
	var_0A = 0;
	var_0B = [];
	for(var_0C = 0;var_0C < level.artillerydangercenters.size;var_0C++)
	{
		if(!var_0A && level.artillerydangercenters[var_0C].origin == var_07)
		{
			var_0A = 1;
			continue;
		}

		var_0B[var_0B.size] = level.artillerydangercenters[var_0C];
	}

	level.artillerydangercenters = var_0B;
	if(param_00 != "harrier")
	{
		return;
	}

	while(isdefined(var_09))
	{
		wait 0.1;
	}

	level.planes--;
}

//Function Number: 9
callstrike(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = 0;
	var_06 = (0,param_02,0);
	var_04 = getent("airstrikeheight","targetname");
	if(param_03 == "stealth")
	{
		var_07 = 12000;
		var_08 = 2000;
		if(!isdefined(var_04))
		{
			var_09 = 950;
			var_05 = 1500;
			if(isdefined(level.airstrikeheightscale))
			{
				var_09 = var_09 * level.airstrikeheightscale;
			}
		}
		else
		{
			var_09 = var_05.origin[2];
			var_05 = getexplodedistance(var_09);
		}
	}
	else
	{
		var_07 = 24000;
		var_08 = 7000;
		if(!isdefined(var_05))
		{
			var_09 = 850;
			var_05 = 1500;
			if(isdefined(level.airstrikeheightscale))
			{
				var_09 = var_09 * level.airstrikeheightscale;
			}
		}
		else
		{
			var_09 = var_05.origin[2];
			var_05 = getexplodedistance(var_09);
		}
	}

	var_0A = param_01 + anglestoforward(var_06) * -1 * var_07;
	if(isdefined(var_04))
	{
		var_0A = var_0A * (1,1,0);
	}

	var_0A = var_0A + (0,0,var_09);
	if(param_03 == "stealth")
	{
		var_0B = param_01 + anglestoforward(var_06) * var_07 * 4;
	}
	else
	{
		var_0B = param_02 + anglestoforward(var_07) * var_08;
	}

	if(isdefined(var_04))
	{
		var_0B = var_0B * (1,1,0);
	}

	var_0B = var_0B + (0,0,var_09);
	var_0C = length(var_0A - var_0B);
	var_0D = var_0C / var_08;
	var_0C = abs(var_0C / 2 + var_05);
	var_0E = var_0C / var_08;
	param_00 endon("disconnect");
	level.airstrikedamagedents = [];
	level.airstrikedamagedentscount = 0;
	level.airstrikedamagedentsindex = 0;
	if(param_03 == "stealth")
	{
		level thread dobomberstrike(param_00,param_01,var_0A + (0,0,randomint(1000)),var_0B + (0,0,randomint(1000)),var_0E,var_0D,var_06);
		return;
	}

	level thread doplanestrike(param_00,param_01,var_0A + (0,0,randomint(500)),var_0B + (0,0,randomint(500)),var_0E,var_0D,var_06,param_03);
	wait randomfloatrange(1.5,2.5);
	level thread doplanestrike(param_00,param_01,var_0A + (0,0,randomint(200)),var_0B + (0,0,randomint(200)),var_0E,var_0D,var_06,param_03);
	wait randomfloatrange(1.5,2.5);
	level thread doplanestrike(param_00,param_01,var_0A + (0,0,randomint(200)),var_0B + (0,0,randomint(200)),var_0E,var_0D,var_06,param_03);
	if(param_03 == "super")
	{
		wait randomfloatrange(2.5,3.5);
		level thread doplanestrike(param_00,param_01,var_0A + (0,0,randomint(200)),var_0B + (0,0,randomint(200)),var_0E,var_0D,var_06,param_03);
	}
}

//Function Number: 10
getexplodedistance(param_00)
{
	var_01 = 850;
	var_02 = 1500;
	var_03 = var_01 / param_00;
	var_04 = var_03 * var_02;
	return var_04;
}

//Function Number: 11
airstrike_spawn_fake_plane(param_00,param_01,param_02)
{
	var_03 = "vehicle_mig29_desert";
	var_04 = "compass_objpoint_airstrike_friendly";
	var_05 = "compass_objpoint_airstrike_busy";
	if(param_00 == "harrier")
	{
		var_03 = "vehicle_av8b_harrier_jet_mp";
		if(param_01.team != "allies")
		{
			var_03 = "vehicle_av8b_harrier_jet_opfor_mp";
		}

		var_04 = "hud_minimap_harrier_green";
		var_05 = "hud_minimap_harrier_red";
	}
	else if(param_00 == "stealth")
	{
		var_03 = "vehicle_b2_bomber";
		var_04 = "compass_objpoint_b2_airstrike_friendly";
		var_05 = "compass_objpoint_b2_airstrike_enemy";
	}

	var_06 = spawn("script_model",param_02);
	var_06.team = param_01.team;
	var_06 setmodel(var_03);
	return var_06;
}

//Function Number: 12
doplanestrike(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_08 = 100;
	var_09 = 150;
	var_0A = param_02 + (randomfloat(2) - 1 * var_08,randomfloat(2) - 1 * var_08,0);
	var_0B = param_03 + (randomfloat(2) - 1 * var_09,randomfloat(2) - 1 * var_09,0);
	var_0C = airstrike_spawn_fake_plane(param_07,param_00,var_0A);
	var_0C playloopsound("veh_mig29_dist_loop");
	var_0C.angles = param_06;
	var_0D = anglestoforward(param_06);
	var_0C thread playplanefx();
	var_0C moveto(var_0B,param_05,0,0);
	thread callstrike_bombeffect(var_0C,var_0B,param_05,param_04 - 1,param_00,param_07);
	wait param_05;
	var_0C notify("delete");
	var_0C delete();
}

//Function Number: 13
playplanefx()
{
	self endon("death");
	wait 0.5;
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_right");
	wait 0.5;
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_left");
	wait 0.5;
	playfxontag(level.fx_airstrike_contrail,self,"tag_right_wingtip");
	wait 0.5;
	playfxontag(level.fx_airstrike_contrail,self,"tag_left_wingtip");
}

//Function Number: 14
callstrike_bomb(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		self notify("stop_bombing");
		return;
	}

	var_04 = 512;
	var_05 = (0,randomint(360),0);
	var_06 = param_00 + anglestoforward(var_05) * randomfloat(var_04);
	var_07 = bullettrace(var_06,var_06 + (0,0,-10000),0,undefined);
	var_06 = var_07["position"];
	var_08 = distance(param_00,var_06);
	if(var_08 > 5000)
	{
		return;
	}

	wait 0.85 * var_08 / 2000;
	if(!isdefined(param_01))
	{
		self notify("stop_bombing");
		return;
	}

	if(param_03)
	{
		playfx(level.mortareffect,var_06);
		playrumbleonposition("grenade_rumble",var_06);
		earthquake(1,0.6,var_06,2000);
	}

	thread common_scripts\utility::play_sound_in_space("exp_airstrike_bomb",var_06);
	radiusartilleryshellshock(var_06,512,8,4);
	radiusdamage(var_06 + (0,0,16),896,300,50,param_01,"MOD_PROJECTILE_SPLASH","stealth_bomb_mp");
}

//Function Number: 15
radiusartilleryshellshock(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in level.players)
	{
		if(!isalive(var_05))
		{
			continue;
		}

		var_06 = var_05.origin + (0,0,32);
		var_07 = distance(param_00,var_06);
		if(var_07 > param_01)
		{
			continue;
		}

		var_08 = var_07 / param_01;
		var_09 = maps\_utility::linear_interpolate(var_08,param_03,param_02);
		var_05 thread artilleryshellshock("default",var_09);
	}
}

//Function Number: 16
artilleryshellshock(param_00,param_01)
{
	if(isdefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked)
	{
		return;
	}

	self.beingartilleryshellshocked = 1;
	self shellshock(param_00,param_01);
	wait param_01 + 1;
	self.beingartilleryshellshocked = 0;
}

//Function Number: 17
callstrike_bombeffect(param_00,param_01,param_02,param_03,param_04,param_05)
{
	wait param_03;
	if(!isdefined(param_04))
	{
		return;
	}

	param_00 playsound("veh_mig29_sonic_boom");
	var_06 = anglestoforward(param_00.angles);
	var_07 = spawnbomb(param_00.origin,param_00.angles);
	var_07.airstriketype = param_05;
	var_07 movegravity(anglestoforward(param_00.angles) * 4666.667,3);
	wait 1;
	var_08 = spawn("script_model",var_07.origin);
	var_08 setmodel("tag_origin");
	var_08.origin = var_07.origin;
	var_08.angles = var_07.angles;
	var_07 setmodel("tag_origin");
	wait 0.1;
	var_09 = var_08.origin;
	var_0A = var_08.angles;
	playfxontag(level.var_3443,var_08,"tag_origin");
	wait 1;
	var_0B = 12;
	var_0C = 5;
	var_0D = 55;
	var_0E = var_0D - var_0C / var_0B;
	var_0F = (0,0,0);
	for(var_10 = 0;var_10 < var_0B;var_10++)
	{
		var_11 = anglestoforward(var_0A + (var_0D - var_0E * var_10,randomint(10) - 5,0));
		var_12 = var_09 + var_11 * 10000;
		var_13 = bullettrace(var_09,var_12,0,undefined);
		var_14 = var_13["position"];
		var_0F = var_0F + var_14;
		radiusdamage(var_14 + (0,0,16),512,200,30,param_04,"MOD_PROJECTILE_SPLASH","artillery_mp");
		if(var_10 % 3 == 0)
		{
			thread common_scripts\utility::play_sound_in_space("exp_airstrike_bomb",var_14);
			playrumbleonposition("artillery_rumble",var_14);
			earthquake(0.7,0.75,var_14,1000);
		}

		wait 0.05;
	}

	var_0F = var_0F / var_0B + (0,0,128);
	wait 5;
	var_08 delete();
	var_07 delete();
}

//Function Number: 18
spawnbomb(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = param_01;
	var_02 setmodel("projectile_cbu97_clusterbomb");
	return var_02;
}

//Function Number: 19
dobomberstrike(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_07 = 100;
	var_08 = 150;
	var_09 = param_02 + (randomfloat(2) - 1 * var_07,randomfloat(2) - 1 * var_07,0);
	var_0A = param_03 + (randomfloat(2) - 1 * var_08,randomfloat(2) - 1 * var_08,0);
	var_0B = airstrike_spawn_fake_plane("stealth",param_00,var_09);
	var_0B playloopsound("veh_b2_dist_loop");
	var_0B setmodel("vehicle_b2_bomber");
	var_0B.angles = param_06;
	var_0C = anglestoforward(param_06);
	var_0B moveto(var_0A,param_05,0,0);
	thread bomberdropbombs(var_0B,param_01,param_00);
	wait param_05;
	var_0B notify("delete");
	var_0B delete();
}

//Function Number: 20
bomberdropbombs(param_00,param_01,param_02)
{
	while(!targetisclose(param_00,param_01,5000))
	{
		wait 0.05;
	}

	var_03 = 1;
	var_04 = 0;
	param_00 notify("start_bombing");
	param_00 thread playbombfx();
	for(var_05 = targetgetdist(param_00,param_01);var_05 < 5000;var_05 = targetgetdist(param_00,param_01))
	{
		if(var_05 < 1500 && !var_04)
		{
			param_00 playsound("veh_b2_sonic_boom");
			var_04 = 1;
		}

		var_03 = !var_03;
		if(var_05 < 4500)
		{
			param_00 thread callstrike_bomb(param_00.origin,param_02,(0,0,0),var_03);
		}

		wait 0.1;
	}

	param_00 notify("stop_bombing");
}

//Function Number: 21
targetisclose(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 3000;
	}

	var_03 = targetisinfront(param_00,param_01);
	if(var_03)
	{
		var_04 = 1;
	}
	else
	{
		var_04 = -1;
	}

	var_05 = common_scripts\utility::flat_origin(param_00.origin);
	var_06 = var_05 + anglestoforward(common_scripts\utility::flat_angle(param_00.angles)) * var_04 * 100000;
	var_07 = pointonsegmentnearesttopoint(var_05,var_06,param_01);
	var_08 = distance(var_05,var_07);
	if(var_08 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
targetisinfront(param_00,param_01)
{
	var_02 = anglestoforward(common_scripts\utility::flat_angle(param_00.angles));
	var_03 = vectornormalize(common_scripts\utility::flat_origin(param_01) - param_00.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
targetgetdist(param_00,param_01)
{
	var_02 = targetisinfront(param_00,param_01);
	if(var_02)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = -1;
	}

	var_04 = common_scripts\utility::flat_origin(param_00.origin);
	var_05 = var_04 + anglestoforward(common_scripts\utility::flat_angle(param_00.angles)) * var_03 * 100000;
	var_06 = pointonsegmentnearesttopoint(var_04,var_05,param_01);
	var_07 = distance(var_04,var_06);
	return var_07;
}

//Function Number: 24
playbombfx()
{
	self endon("stop_bombing");
	for(;;)
	{
		playfxontag(level.stealthbombfx,self,"tag_left_alamo_missile");
		playfxontag(level.stealthbombfx,self,"tag_right_alamo_missile");
		wait 0.5;
	}
}