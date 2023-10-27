/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airstrike.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 591 ms
 * Timestamp: 10/27/2023 2:13:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachelocationselector("map_artillery_selector");
	precachestring(&"KILLSTREAKS_PRECISION_AIRSTRIKE");
	precachestring(&"KILLSTREAKS_STEALTH_AIRSTRIKE");
	precachestring(&"KILLSTREAKS_HARRIER_AIRSTRIKE");
	precacheitem("stealth_bomb_mp");
	precacheitem("artillery_mp");
	precacheitem("harrier_missile_mp");
	precachemodel("vehicle_av8b_harrier_jet_mp");
	precachemodel("vehicle_av8b_harrier_jet_opfor_mp");
	precachemodel("weapon_minigun");
	precachemodel("vehicle_b2_bomber");
	precachevehicle("harrier_mp");
	precacheturret("harrier_FFAR_mp");
	precacheminimapicon("compass_objpoint_airstrike_friendly");
	precacheminimapicon("compass_objpoint_airstrike_busy");
	precacheminimapicon("compass_objpoint_b2_airstrike_friendly");
	precacheminimapicon("compass_objpoint_b2_airstrike_enemy");
	precacheminimapicon("hud_minimap_harrier_green");
	precacheminimapicon("hud_minimap_harrier_red");
	level.var_3442 = loadfx("fire/fire_smoke_trail_L");
	level.var_3443 = loadfx("explosions/clusterbomb");
	level.var_1A8 = loadfx("explosions/clusterbomb_no_fount");
	level.airstrikessfx = loadfx("explosions/clusterbomb_exp_direct_runner");
	level.mortareffect = loadfx("explosions/clusterbomb_exp_direct_runner_stealth");
	level.bombstrike = loadfx("explosions/wall_explosion_pm_a");
	level.stealthbombfx = loadfx("explosions/stealth_bomb_mp");
	level.airplane = [];
	level.harriers = [];
	level.planes = 0;
	level.harrier_smoke = loadfx("fire/jet_afterburner_harrier_damaged");
	level.harrier_deathfx = loadfx("explosions/aerial_explosion_harrier");
	level.harrier_afterburnerfx = loadfx("fire/jet_afterburner_harrier");
	level.fx_airstrike_afterburner = loadfx("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx("smoke/jet_contrail");
	level.dangermaxradius["stealth_airstrike"] = 900;
	level.dangerminradius["stealth_airstrike"] = 750;
	level.dangerforwardpush["stealth_airstrike"] = 1;
	level.dangerovalscale["stealth_airstrike"] = 6;
	level.dangermaxradius["airstrike"] = 550;
	level.dangerminradius["airstrike"] = 300;
	level.dangerforwardpush["airstrike"] = 1.5;
	level.dangerovalscale["airstrike"] = 6;
	level.dangermaxradius["precision_airstrike"] = 550;
	level.dangerminradius["precision_airstrike"] = 300;
	level.dangerforwardpush["precision_airstrike"] = 2;
	level.dangerovalscale["precision_airstrike"] = 6;
	level.dangermaxradius["harrier_airstrike"] = 550;
	level.dangerminradius["harrier_airstrike"] = 300;
	level.dangerforwardpush["harrier_airstrike"] = 1.5;
	level.dangerovalscale["harrier_airstrike"] = 6;
	level.artillerydangercenters = [];
	level.killstreakfuncs["airstrike"] = ::tryusedefaultairstrike;
	level.killstreakfuncs["precision_airstrike"] = ::tryuseprecisionairstrike;
	level.killstreakfuncs["super_airstrike"] = ::tryusesuperairstrike;
	level.killstreakfuncs["harrier_airstrike"] = ::tryuseharrierairstrike;
	level.killstreakfuncs["stealth_airstrike"] = ::tryusestealthairstrike;
	level.planes = [];
}

//Function Number: 2
tryusedefaultairstrike(param_00)
{
	return tryuseairstrike(param_00,"airstrike");
}

//Function Number: 3
tryuseprecisionairstrike(param_00)
{
	return tryuseairstrike(param_00,"precision_airstrike");
}

//Function Number: 4
tryusesuperairstrike(param_00)
{
	return tryuseairstrike(param_00,"super_airstrike");
}

//Function Number: 5
tryuseharrierairstrike(param_00)
{
	return tryuseairstrike(param_00,"harrier_airstrike");
}

//Function Number: 6
tryusestealthairstrike(param_00)
{
	return tryuseairstrike(param_00,"stealth_airstrike");
}

//Function Number: 7
tryuseairstrike(param_00,param_01)
{
	if(!maps\mp\_utility::validateusestreak())
	{
		return 0;
	}

	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	switch(param_01)
	{
		case "precision_airstrike":
			break;

		case "stealth_airstrike":
			break;

		case "harrier_airstrike":
			if(level.planes > 1)
			{
				self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
				return 0;
			}
			break;

		case "super_airstrike":
			break;
	}

	var_02 = selectairstrikelocation(param_00,param_01);
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
doairstrike(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_05 == "harrier_airstrike")
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
		if(param_05 == "harrier_airstrike")
		{
			level.planes--;
		}

		return;
	}

	level.airstrikeinprogress = 1;
	var_06 = 17 + randomint(3);
	var_07 = bullettrace(param_01,param_01 + (0,0,-1000000),0,undefined);
	var_08 = var_07["position"];
	var_09 = spawnstruct();
	var_09.origin = var_08;
	var_09.forward = anglestoforward((0,param_02,0));
	var_09.streakname = param_05;
	level.artillerydangercenters[level.artillerydangercenters.size] = var_09;
	var_0A = callstrike(param_00,param_03,var_08,param_02,param_05);
	wait 1;
	level.airstrikeinprogress = undefined;
	param_03 notify("begin_airstrike");
	level notify("begin_airstrike");
	wait 7.5;
	var_0B = 0;
	var_0C = [];
	for(var_0D = 0;var_0D < level.artillerydangercenters.size;var_0D++)
	{
		if(!var_0B && level.artillerydangercenters[var_0D].origin == var_08)
		{
			var_0B = 1;
			continue;
		}

		var_0C[var_0C.size] = level.artillerydangercenters[var_0D];
	}

	level.artillerydangercenters = var_0C;
	if(param_05 != "harrier_airstrike")
	{
		return;
	}

	while(isdefined(var_0A))
	{
		wait 0.1;
	}

	level.planes--;
}

//Function Number: 9
clearprogress(param_00)
{
	wait 2;
	level.airstrikeinprogress = undefined;
}

//Function Number: 10
getairstrikedanger(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.artillerydangercenters.size;var_02++)
	{
		var_03 = level.artillerydangercenters[var_02].origin;
		var_04 = level.artillerydangercenters[var_02].forward;
		var_05 = level.artillerydangercenters[var_02].streakname;
		var_01 = var_01 + getsingleairstrikedanger(param_00,var_03,var_04,var_05);
	}

	return var_01;
}

//Function Number: 11
getsingleairstrikedanger(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 + level.dangerforwardpush[param_03] * level.dangermaxradius[param_03] * param_02;
	var_05 = param_00 - var_04;
	var_05 = (var_05[0],var_05[1],0);
	var_06 = vectordot(var_05,param_02) * param_02;
	var_07 = var_05 - var_06;
	var_08 = var_07 + var_06 / level.dangerovalscale[param_03];
	var_09 = lengthsquared(var_08);
	if(var_09 > level.dangermaxradius[param_03] * level.dangermaxradius[param_03])
	{
		return 0;
	}

	if(var_09 < level.dangerminradius[param_03] * level.dangerminradius[param_03])
	{
		return 1;
	}

	var_0A = sqrt(var_09);
	var_0B = var_0A - level.dangerminradius[param_03] / level.dangermaxradius[param_03] - level.dangerminradius[param_03];
	return 1 - var_0B;
}

//Function Number: 12
pointisinairstrikearea(param_00,param_01,param_02,param_03)
{
	return distance2d(param_00,param_01) <= level.dangermaxradius[param_03] * 1.25;
}

//Function Number: 13
losradiusdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\mp\gametypes\_weapons::getdamageableents(param_00,param_01,1);
	glassradiusdamage(param_00,param_01,param_02,param_03);
	for(var_08 = 0;var_08 < var_07.size;var_08++)
	{
		if(var_07[var_08].entity == self)
		{
			continue;
		}

		var_09 = distance(param_00,var_07[var_08].damagecenter);
		if(var_07[var_08].isplayer || isdefined(var_07[var_08].issentry) && var_07[var_08].issentry)
		{
			var_0A = !bullettracepassed(var_07[var_08].entity.origin,var_07[var_08].entity.origin + (0,0,130),0,undefined);
			if(var_0A)
			{
				var_0A = !bullettracepassed(var_07[var_08].entity.origin + (0,0,130),param_00 + (0,0,114),0,undefined);
				if(var_0A)
				{
					var_09 = var_09 * 4;
					if(var_09 > param_01)
					{
						continue;
					}
				}
			}
		}

		var_07[var_08].damage = int(param_02 + param_03 - param_02 * var_09 / param_01);
		var_07[var_08].pos = param_00;
		var_07[var_08].damageowner = param_04;
		var_07[var_08].einflictor = param_05;
		level.airstrikedamagedents[level.airstrikedamagedentscount] = var_07[var_08];
		level.airstrikedamagedentscount++;
	}

	thread airstrikedamageentsthread(param_06);
}

//Function Number: 14
airstrikedamageentsthread(param_00)
{
	self notify("airstrikeDamageEntsThread");
	self endon("airstrikeDamageEntsThread");
	while(level.airstrikedamagedentsindex < level.airstrikedamagedentscount)
	{
		if(!isdefined(level.airstrikedamagedents[level.airstrikedamagedentsindex]))
		{
			continue;
		}

		var_01 = level.airstrikedamagedents[level.airstrikedamagedentsindex];
		if(!isdefined(var_01.entity))
		{
			continue;
		}

		if(!var_01.isplayer || isalive(var_01.entity))
		{
			var_01 maps\mp\gametypes\_weapons::damageent(var_01.einflictor,var_01.damageowner,var_01.damage,"MOD_PROJECTILE_SPLASH",param_00,var_01.pos,vectornormalize(var_01.damagecenter - var_01.pos));
			level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
			if(var_01.isplayer)
			{
				wait 0.05;
			}

			continue;
		}

		level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
		level.airstrikedamagedentsindex++;
	}
}

//Function Number: 15
radiusartilleryshellshock(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.players;
	foreach(var_07 in level.players)
	{
		if(!isalive(var_07))
		{
			continue;
		}

		if(var_07.team == param_04 || var_07.team == "spectator")
		{
			continue;
		}

		var_08 = var_07.origin + (0,0,32);
		var_09 = distance(param_00,var_08);
		if(var_09 > param_01)
		{
			continue;
		}

		var_0A = int(param_02 + param_03 - param_02 * var_09 / param_01);
		var_07 thread artilleryshellshock("default",var_0A);
	}
}

//Function Number: 16
artilleryshellshock(param_00,param_01)
{
	self endon("disconnect");
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
dobomberstrike(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_0A = 100;
	var_0B = 150;
	var_0C = param_04 + (randomfloat(2) - 1 * var_0A,randomfloat(2) - 1 * var_0A,0);
	var_0D = param_05 + (randomfloat(2) - 1 * var_0B,randomfloat(2) - 1 * var_0B,0);
	var_0E = spawnplane(param_01,"script_model",var_0C,"compass_objpoint_b2_airstrike_friendly","compass_objpoint_b2_airstrike_enemy");
	addplanetolist(var_0E);
	var_0E thread handledeath();
	var_0E playloopsound("veh_b2_dist_loop");
	var_0E setmodel("vehicle_b2_bomber");
	var_0E thread handleemp(param_01);
	var_0E.lifeid = param_00;
	var_0E.angles = param_08;
	var_0F = anglestoforward(param_08);
	var_0E moveto(var_0D,param_07,0,0);
	thread stealthbomber_killcam(var_0E,var_0D,param_07,param_09);
	thread bomberdropbombs(var_0E,param_03,param_01);
	var_0E endon("death");
	wait param_07 * 0.65;
	removeplanefromlist(var_0E);
	var_0E notify("delete");
	var_0E delete();
}

//Function Number: 18
bomberdropbombs(param_00,param_01,param_02)
{
	param_00 endon("death");
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

//Function Number: 19
playbombfx()
{
	self endon("stop_bombing");
	self endon("death");
	for(;;)
	{
		playfxontag(level.stealthbombfx,self,"tag_left_alamo_missile");
		playfxontag(level.stealthbombfx,self,"tag_right_alamo_missile");
		wait 0.5;
	}
}

//Function Number: 20
stealthbomber_killcam(param_00,param_01,param_02,param_03)
{
	param_00 waittill("start_bombing");
	var_04 = anglestoforward(param_00.angles);
	var_05 = spawn("script_model",param_00.origin + (0,0,100) - var_04 * 200);
	param_00.killcament = var_05;
	param_00.killcament setscriptmoverkillcam("airstrike");
	param_00.airstriketype = param_03;
	var_05.starttime = gettime();
	var_05 thread deleteaftertime(15);
	var_05 linkto(param_00,"tag_origin",(-256,768,768),(0,0,0));
}

//Function Number: 21
callstrike_bomb(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01) || param_01 maps\mp\_utility::isemped() || param_01 maps\mp\_utility::isairdenied())
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
	if(!isdefined(param_01) || param_01 maps\mp\_utility::isemped() || param_01 maps\mp\_utility::isairdenied())
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

	thread maps\mp\_utility::playsoundinspace("exp_airstrike_bomb",var_06);
	radiusartilleryshellshock(var_06,512,8,4,param_01.team);
	losradiusdamage(var_06 + (0,0,16),896,300,50,param_01,self,"stealth_bomb_mp");
}

//Function Number: 22
doplanestrike(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_0A = 100;
	var_0B = 150;
	var_0C = param_04 + (randomfloat(2) - 1 * var_0A,randomfloat(2) - 1 * var_0A,0);
	var_0D = param_05 + (randomfloat(2) - 1 * var_0B,randomfloat(2) - 1 * var_0B,0);
	if(param_09 == "harrier_airstrike")
	{
		var_0E = spawnplane(param_01,"script_model",var_0C,"hud_minimap_harrier_green","hud_minimap_harrier_red");
	}
	else
	{
		var_0E = spawnplane(param_02,"script_model",var_0D,"compass_objpoint_airstrike_friendly","compass_objpoint_airstrike_busy");
	}

	addplanetolist(var_0E);
	var_0E thread handledeath();
	if(param_09 == "harrier_airstrike")
	{
		if(param_01.team == "allies")
		{
			var_0E setmodel("vehicle_av8b_harrier_jet_mp");
		}
		else
		{
			var_0E setmodel("vehicle_av8b_harrier_jet_opfor_mp");
		}
	}
	else
	{
		var_0E setmodel("vehicle_mig29_desert");
	}

	var_0E playloopsound("veh_mig29_dist_loop");
	var_0E thread handleemp(param_01);
	var_0E.lifeid = param_00;
	var_0E.angles = param_08;
	var_0F = anglestoforward(param_08);
	var_0E thread playplanefx();
	var_0E moveto(var_0D,param_07,0,0);
	thread callstrike_bombeffect(var_0E,var_0D,param_07,param_06 - 1,param_01,param_02,param_09);
	var_0E endon("death");
	wait param_07;
	removeplanefromlist(var_0E);
	var_0E notify("delete");
	var_0E delete();
}

//Function Number: 23
handledeath()
{
	level endon("game_ended");
	self endon("delete");
	self waittill("death");
	var_00 = anglestoforward(self.angles) * 200;
	playfx(level.harrier_deathfx,self.origin,var_00);
	removeplanefromlist(self);
	self delete();
}

//Function Number: 24
addplanetolist(param_00)
{
	level.planes[level.planes.size] = param_00;
}

//Function Number: 25
removeplanefromlist(param_00)
{
	for(var_01 = 0;var_01 < level.planes.size;var_01++)
	{
		if(isdefined(level.planes[var_01]) && level.planes[var_01] == param_00)
		{
			level.planes[var_01] = undefined;
		}
	}
}

//Function Number: 26
callstrike_bombeffect(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 endon("death");
	wait param_03;
	if(!isdefined(param_04) || param_04 maps\mp\_utility::isemped() || param_04 maps\mp\_utility::isairdenied())
	{
		return;
	}

	param_00 playsound("veh_mig29_sonic_boom");
	var_07 = anglestoforward(param_00.angles);
	var_08 = spawnbomb(param_00.origin,param_00.angles);
	var_08 movegravity(anglestoforward(param_00.angles) * 4666.667,3);
	var_08.lifeid = param_05;
	var_09 = spawn("script_model",param_00.origin + (0,0,100) - var_07 * 200);
	var_08.killcament = var_09;
	var_08.killcament setscriptmoverkillcam("airstrike");
	var_08.airstriketype = param_06;
	var_09.starttime = gettime();
	var_09 thread deleteaftertime(15);
	var_09.angles = var_07;
	var_09 moveto(param_01 + (0,0,100),param_02,0,0);
	wait 0.4;
	var_09 moveto(var_09.origin + var_07 * 4000,1,0,0);
	wait 0.45;
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.2) * 3500,2,0,0);
	wait 0.15;
	var_0A = spawn("script_model",var_08.origin);
	var_0A setmodel("tag_origin");
	var_0A.origin = var_08.origin;
	var_0A.angles = var_08.angles;
	var_08 setmodel("tag_origin");
	wait 0.1;
	var_0B = var_0A.origin;
	var_0C = var_0A.angles;
	if(level.splitscreen)
	{
		playfxontag(level.var_1A8,var_0A,"tag_origin");
	}
	else
	{
		playfxontag(level.var_3443,var_0A,"tag_origin");
	}

	wait 0.05;
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.25) * 2500,2,0,0);
	wait 0.25;
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.35) * 2000,2,0,0);
	wait 0.2;
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.45) * 1500,2,0,0);
	wait 0.5;
	var_0D = 12;
	var_0E = 5;
	var_0F = 55;
	var_10 = var_0F - var_0E / var_0D;
	var_11 = (0,0,0);
	for(var_12 = 0;var_12 < var_0D;var_12++)
	{
		var_13 = anglestoforward(var_0C + (var_0F - var_10 * var_12,randomint(10) - 5,0));
		var_14 = var_0B + var_13 * 10000;
		var_15 = bullettrace(var_0B,var_14,0,undefined);
		var_16 = var_15["position"];
		var_11 = var_11 + var_16;
		playfx(level.airstrikessfx,var_16);
		thread losradiusdamage(var_16 + (0,0,16),512,200,30,param_04,var_08,"artillery_mp");
		if(var_12 % 3 == 0)
		{
			thread maps\mp\_utility::playsoundinspace("exp_airstrike_bomb",var_16);
			playrumbleonposition("artillery_rumble",var_16);
			earthquake(0.7,0.75,var_16,1000);
		}

		wait 0.05;
	}

	var_11 = var_11 / var_0D + (0,0,128);
	var_09 moveto(var_08.killcament.origin * 0.35 + var_11 * 0.65,1.5,0,0.5);
	wait 5;
	var_0A delete();
	var_08 delete();
}

//Function Number: 27
spawnbomb(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = param_01;
	var_02 setmodel("projectile_cbu97_clusterbomb");
	return var_02;
}

//Function Number: 28
deleteaftertime(param_00)
{
	self endon("death");
	wait 10;
	self delete();
}

//Function Number: 29
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

//Function Number: 30
callstrike(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	var_06 = 0;
	var_07 = (0,param_03,0);
	var_05 = getent("airstrikeheight","targetname");
	if(param_04 == "stealth_airstrike")
	{
		thread maps\mp\_utility::teamplayercardsplash("used_stealth_airstrike",param_01,param_01.team);
		var_08 = 12000;
		var_09 = 2000;
		if(!isdefined(var_05))
		{
			var_0A = 950;
			var_06 = 1500;
			if(isdefined(level.airstrikeheightscale))
			{
				var_0A = var_0A * level.airstrikeheightscale;
			}
		}
		else
		{
			var_0A = var_06.origin[2];
			if(getdvar("mapname") == "mp_exchange")
			{
				var_0A = var_0A + 1024;
			}

			var_06 = getexplodedistance(var_0A);
		}
	}
	else
	{
		var_08 = 24000;
		var_09 = 7000;
		if(!isdefined(var_06))
		{
			var_0A = 850;
			var_06 = 1500;
			if(isdefined(level.airstrikeheightscale))
			{
				var_0A = var_0A * level.airstrikeheightscale;
			}
		}
		else
		{
			var_0A = var_06.origin[2];
			var_06 = getexplodedistance(var_0A);
		}
	}

	var_0B = param_02 + anglestoforward(var_07) * -1 * var_08;
	if(isdefined(var_05))
	{
		var_0B = var_0B * (1,1,0);
	}

	var_0B = var_0B + (0,0,var_0A);
	if(param_04 == "stealth_airstrike")
	{
		var_0C = param_02 + anglestoforward(var_07) * var_08 * 4;
	}
	else
	{
		var_0C = param_03 + anglestoforward(var_08) * var_09;
	}

	if(isdefined(var_05))
	{
		var_0C = var_0C * (1,1,0);
	}

	var_0C = var_0C + (0,0,var_0A);
	var_0D = length(var_0B - var_0C);
	var_0E = var_0D / var_09;
	var_0D = abs(var_0D / 2 + var_06);
	var_0F = var_0D / var_09;
	param_01 endon("disconnect");
	var_10 = param_00;
	level.airstrikedamagedents = [];
	level.airstrikedamagedentscount = 0;
	level.airstrikedamagedentsindex = 0;
	if(param_04 == "harrier_airstrike")
	{
		level thread doplanestrike(param_00,param_01,var_10,param_02,var_0B + (0,0,randomint(500)),var_0C + (0,0,randomint(500)),var_0F,var_0E,var_07,param_04);
		wait randomfloatrange(1.5,2.5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		level thread doplanestrike(param_00,param_01,var_10,param_02,var_0B + (0,0,randomint(200)),var_0C + (0,0,randomint(200)),var_0F,var_0E,var_07,param_04);
		wait randomfloatrange(1.5,2.5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_11 = maps\mp\killstreaks\_harrier::beginharrier(param_00,var_0B,param_02);
		param_01 thread maps\mp\killstreaks\_harrier::defendlocation(var_11);
		return var_11;
	}

	if(var_05 == "stealth_airstrike")
	{
		level thread dobomberstrike(param_01,param_02,var_11,param_03,var_0C + (0,0,randomint(1000)),var_0D + (0,0,randomint(1000)),var_10,var_0F,var_08,var_05);
		return;
	}

	level thread doplanestrike(param_01,param_02,var_11,param_03,var_0C + (0,0,randomint(500)),var_0D + (0,0,randomint(500)),var_10,var_0F,var_08,var_05);
	wait randomfloatrange(1.5,2.5);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	level thread doplanestrike(param_01,param_02,var_11,param_03,var_0C + (0,0,randomint(200)),var_0D + (0,0,randomint(200)),var_10,var_0F,var_08,var_05);
	wait randomfloatrange(1.5,2.5);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	level thread doplanestrike(param_01,param_02,var_11,param_03,var_0C + (0,0,randomint(200)),var_0D + (0,0,randomint(200)),var_10,var_0F,var_08,var_05);
	if(var_05 == "super_airstrike")
	{
		wait randomfloatrange(2.5,3.5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		level thread doplanestrike(param_01,param_02,var_11,param_03,var_0C + (0,0,randomint(200)),var_0D + (0,0,randomint(200)),var_10,var_0F,var_08,var_05);
		return;
	}
}

//Function Number: 31
getexplodedistance(param_00)
{
	var_01 = 850;
	var_02 = 1500;
	var_03 = var_01 / param_00;
	var_04 = var_03 * var_02;
	return var_04;
}

//Function Number: 32
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

//Function Number: 33
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

//Function Number: 34
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

//Function Number: 35
waitforairstrikecancel()
{
	self waittill("cancel_location");
	self setblurforplayer(0,0.3);
}

//Function Number: 36
selectairstrikelocation(param_00,param_01)
{
	var_02 = level.mapsize / 6.46875;
	if(level.splitscreen)
	{
		var_02 = var_02 * 1.5;
	}

	var_03 = 0;
	switch(param_01)
	{
		case "precision_airstrike":
			var_03 = 1;
			self playlocalsound(game["voice"][self.team] + "KS_hqr_airstrike");
			break;

		case "stealth_airstrike":
			var_03 = 1;
			self playlocalsound(game["voice"][self.team] + "KS_hqr_bomber");
			break;
	}

	maps\mp\_utility::_beginlocationselection(param_01,"map_artillery_selector",var_03,var_02);
	self endon("stop_location_selection");
	self waittill("confirm_location",var_04,var_05);
	if(!var_03)
	{
		var_05 = randomint(360);
	}

	self setblurforplayer(0,0.3);
	if(param_01 == "harrier_airstrike" && level.planes > 1)
	{
		self notify("cancel_location");
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	thread airstrikemadeselectionvo(param_01);
	maps\mp\_matchdata::logkillstreakevent(param_01,var_04);
	thread finishairstrikeusage(param_00,var_04,var_05,param_01);
	return 1;
}

//Function Number: 37
finishairstrikeusage(param_00,param_01,param_02,param_03)
{
	self notify("used");
	var_04 = bullettrace(level.mapcenter + (0,0,1000000),level.mapcenter,0,undefined);
	param_01 = (param_01[0],param_01[1],var_04["position"][2] - 514);
	thread doairstrike(param_00,param_01,param_02,self,self.pers["team"],param_03);
}

//Function Number: 38
useairstrike(param_00,param_01,param_02)
{
}

//Function Number: 39
handleemp(param_00)
{
	self endon("death");
	if(param_00 maps\mp\_utility::isemped())
	{
		self notify("death");
		return;
	}

	for(;;)
	{
		level waittill("emp_update");
		if(!param_00 maps\mp\_utility::isemped())
		{
			continue;
		}

		self notify("death");
	}
}

//Function Number: 40
airstrikemadeselectionvo(param_00)
{
	self endon("death");
	self endon("disconnect");
	switch(param_00)
	{
		case "precision_airstrike":
			self playlocalsound(game["voice"][self.team] + "KS_ast_inbound");
			break;

		case "stealth_airstrike":
			self playlocalsound(game["voice"][self.team] + "KS_bmb_inbound");
			break;
	}
}