/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hardpoints.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 783 ms
 * Timestamp: 10/27/2023 2:41:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("radar_mp");
	precacheitem("airstrike_mp");
	precacheitem("helicopter_mp");
	precacheitem("artillery_mp");
	level.killstreaksenabled = 1;
	level.hardpointitems = [];
	level.hardpointitems["radar_mp"] = getdvarint("scr_killstreak_kills_uav",3);
	level.hardpointitems["airstrike_mp"] = getdvarint("scr_killstreak_kills_airstrike",5);
	level.hardpointitems["helicopter_mp"] = getdvarint("scr_killstreak_kills_heli",7);
	level.maxkillstreakforaward = 0;
	foreach(var_01 in level.hardpointitems)
	{
		if(level.maxkillstreakforaward < var_01)
		{
			level.maxkillstreakforaward = var_01;
		}
	}

	level.hardpointhints["radar_mp"] = &"MP_EARNED_RADAR";
	level.hardpointhints["airstrike_mp"] = &"MP_EARNED_AIRSTRIKE";
	level.hardpointhints["helicopter_mp"] = &"MP_EARNED_HELICOPTER";
	level.hardpointhints["radar_mp_not_available"] = &"MP_RADAR_NOT_AVAILABLE";
	level.hardpointhints["airstrike_mp_not_available"] = &"MP_AIRSTRIKE_NOT_AVAILABLE";
	level.hardpointhints["helicopter_mp_not_available"] = &"MP_HELICOPTER_NOT_AVAILABLE";
	level.hardpointinforms["radar_mp"] = "mp_killstreak_radar";
	level.hardpointinforms["airstrike_mp"] = "mp_killstreak_jet";
	level.hardpointinforms["helicopter_mp"] = "mp_killstreak_heli";
	precachestring(level.hardpointhints["radar_mp"]);
	precachestring(level.hardpointhints["airstrike_mp"]);
	precachestring(level.hardpointhints["helicopter_mp"]);
	precachestring(level.hardpointhints["radar_mp_not_available"]);
	precachestring(level.hardpointhints["airstrike_mp_not_available"]);
	precachestring(level.hardpointhints["helicopter_mp_not_available"]);
	precachestring(&"MP_KILLSTREAK_N");
	precachelocationselector("map_artillery_selector");
	if(!isdefined(level.airstrikefx))
	{
		level.airstrikefx = loadfx("fx/explosions/clusterbomb_mp");
	}

	if(!isdefined(level.airstrike_close_sound))
	{
		level.airstrike_close_sound = "h1_ks_veh_mig29_close_loop";
	}

	level.fx_airstrike_harrier_jet = loadfx("fx/fire/jet_afterburner_harrier");
	level.fx_airstrike_afterburner = loadfx("fx/fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx("fx/smoke/jet_contrail");
	level.fx_heli_dust = loadfx("vfx/treadfx/heli_dust_default");
	level.fx_heli_water = loadfx("vfx/treadfx/heli_water_default");
	game["dialog"]["uav_online"] = "ouruavonline";
	game["dialog"]["uav_offline"] = "";
	game["dialog"]["enemy_uav_online"] = "enemyuavair";
	game["dialog"]["enemy_uav_offline"] = "";
	game["dialog"]["airstrike_inbound"] = "friendlyair";
	game["dialog"]["enemy_airstrike_inbound"] = "enemyair";
	game["dialog"]["helicopter_inbound"] = "friendlyheli";
	game["dialog"]["enemy_helicopter_inbound"] = "enemyheli";
	game["dialog"]["radar_mp"] = "uavrecon";
	game["dialog"]["airstrike_mp"] = "airstrike";
	game["dialog"]["helicopter_mp"] = "helisupport";
	if(getdvar("scr_heli_hardpoint_interval") != "")
	{
		level.helicopterinterval = getdvarfloat("scr_heli_hardpoint_interval");
	}
	else
	{
		setdvar("scr_heli_hardpoint_interval",180);
		level.helicopterinterval = 180;
	}

	level.artillerydangermaxradius = 550;
	level.artillerydangerminradius = 300;
	level.artillerydangerforwardpush = 1.5;
	level.artillerydangerovalscale = 6;
	level.artillerymaprange = level.artillerydangerminradius * 0.3 + level.artillerydangermaxradius * 0.7;
	level.artillerydangermaxradiussq = level.artillerydangermaxradius * level.artillerydangermaxradius;
	level.artillerydangercenters = [];
	level.radarviewtime = 30;
	level.numhardpointreservedobjectives = 0;
	maps\mp\_helicopter::init();
	maps\mp\gametypes\_rank::registerxpeventinfo("radar_mp_earned",100);
	maps\mp\gametypes\_rank::registerxpeventinfo("airstrike_mp_earned",100);
	maps\mp\gametypes\_rank::registerxpeventinfo("helicopter_mp_earned",100);
	level.killstreakwieldweapons["artillery_mp"] = "airstrike_mp";
	level.killstreakwieldweapons["cobra_ffar_mp"] = "helicopter_mp";
	level.killstreakwieldweapons["hind_ffar_mp"] = "helicopter_mp";
	level.killstreakwieldweapons["cobra_20mm_mp"] = "helicopter_mp";
	level.killstreakfuncs = [];
	level.killstreakfuncs["radar_mp"] = ::blank;
	level.killstreakfuncs["airstrike_mp"] = ::blank;
	level.killstreakfuncs["helicopter_mp"] = ::blank;
	if(level.teambased)
	{
		level.activeuavs["allies"] = 0;
		level.activeuavs["axis"] = 0;
		level.uavmodels["allies"] = [];
		level.uavmodels["axis"] = [];
	}
	else
	{
		level.activeuavs = [];
		level.uavmodels = [];
	}

	level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay",0);
	level.killcountpersistsoverrounds = maps\mp\_utility::getintproperty("scr_killcount_persists",1);
	level thread onplayerconnect();
}

//Function Number: 2
blank()
{
}

//Function Number: 3
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!level.teambased)
		{
			level.activeuavs[var_00.guid] = 0;
		}
	}
}

//Function Number: 4
adduavmodel()
{
	if(level.teambased)
	{
		level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
		return;
	}

	level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

//Function Number: 5
removeuavmodel()
{
	var_00 = [];
	if(level.teambased)
	{
		var_01 = self.team;
		foreach(var_03 in level.uavmodels[var_01])
		{
			if(!isdefined(var_03) || var_03 == self)
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		level.uavmodels[var_01] = var_00;
		return;
	}

	foreach(var_03 in level.uavmodels)
	{
		if(!isdefined(var_03) || var_03 == self)
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	level.uavmodels = var_00;
}

//Function Number: 6
addactiveuav()
{
	self.uavtype = "standard";
	if(level.teambased)
	{
		level.activeuavs[self.team]++;
		return;
	}

	level.activeuavs[self.owner.guid]++;
}

//Function Number: 7
removeactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]--;
		return;
	}

	if(isdefined(self.owner))
	{
		level.activeuavs[self.owner.guid]--;
	}
}

//Function Number: 8
doartillery(param_00,param_01,param_02)
{
	level.airstrikeinprogress = 1;
	var_03 = bullettrace(param_00,param_00 + (0,0,-100000),0,undefined,0,0,0,0,0,1);
	var_04 = var_03["position"];
	var_05 = level.mapcenter[2] - var_04[2];
	if(abs(var_05) > 2000)
	{
		var_04 = (var_04[0],var_04[1],level.mapcenter[2]);
	}

	var_06 = getbestplanedirection(var_04);
	if(level.teambased)
	{
		var_07 = level.players;
		if(!level.hardcoremode)
		{
			for(var_08 = 0;var_08 < var_07.size;var_08++)
			{
				if(isalive(var_07[var_08]) && isdefined(var_07[var_08].pers["team"]) && var_07[var_08].pers["team"] == param_02)
				{
					if(pointisinairstrikearea(var_07[var_08].origin,var_04,var_06))
					{
						var_07[var_08] iprintlnbold(&"MP_WAR_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
					}
				}
			}
		}

		maps\mp\_utility::leaderdialog("airstrike_inbound",param_02);
		for(var_08 = 0;var_08 < level.players.size;var_08++)
		{
			var_09 = level.players[var_08];
			var_0A = var_09.pers["team"];
			if(isdefined(var_0A))
			{
				if(var_0A == param_02)
				{
					var_09 iprintln(&"MP_WAR_AIRSTRIKE_INBOUND",param_01);
				}
			}
		}
	}
	else
	{
		param_01 maps\mp\_utility::leaderdialogonplayer("airstrike_inbound");
		if(!level.hardcoremode)
		{
			if(pointisinairstrikearea(param_01.origin,var_04,var_06))
			{
				param_01 iprintlnbold(&"MP_WAR_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
			}
		}
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(2);
	if(!isdefined(param_01))
	{
		level.airstrikeinprogress = undefined;
		return;
	}

	param_01 notify("begin_airstrike");
	var_0B = spawnstruct();
	var_0B.origin = var_04;
	var_0B.forward = anglestoforward((0,var_06,0));
	var_0B.owner = param_01;
	var_0B.team = param_01.team;
	level.artillerydangercenters[level.artillerydangercenters.size] = var_0B;
	callstrike(param_01,var_04,var_06);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(8.5);
	var_0C = 0;
	var_0D = [];
	for(var_08 = 0;var_08 < level.artillerydangercenters.size;var_08++)
	{
		if(!var_0C && level.artillerydangercenters[var_08].origin == var_04)
		{
			var_0C = 1;
			continue;
		}

		var_0D[var_0D.size] = level.artillerydangercenters[var_08];
	}

	level.artillerydangercenters = var_0D;
	level.airstrikeinprogress = undefined;
}

//Function Number: 9
getairstrikedanger(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.artillerydangercenters.size;var_02++)
	{
		var_03 = level.artillerydangercenters[var_02].origin;
		var_04 = level.artillerydangercenters[var_02].forward;
		var_01 = var_01 + getsingleairstrikedanger(param_00,var_03,var_04);
	}

	return var_01;
}

//Function Number: 10
getsingleairstrikedanger(param_00,param_01,param_02)
{
	var_03 = param_01 + level.artillerydangerforwardpush * level.artillerydangermaxradius * param_02;
	var_04 = param_00 - var_03;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = vectordot(var_04,param_02) * param_02;
	var_06 = var_04 - var_05;
	var_07 = var_06 + var_05 / level.artillerydangerovalscale;
	var_08 = lengthsquared(var_07);
	if(var_08 > level.artillerydangermaxradius * level.artillerydangermaxradius)
	{
		return 0;
	}

	if(var_08 < level.artillerydangerminradius * level.artillerydangerminradius)
	{
		return 1;
	}

	var_09 = sqrt(var_08);
	var_0A = var_09 - level.artillerydangerminradius / level.artillerydangermaxradius - level.artillerydangerminradius;
	return 1 - var_0A;
}

//Function Number: 11
pointisinairstrikearea(param_00,param_01,param_02)
{
	return distance2d(param_00,param_01) <= level.artillerydangermaxradius * 1.25;
}

//Function Number: 12
losradiusdamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = maps\mp\gametypes\_weapons::getdamageableents(param_00,param_01,1);
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		if(var_06[var_07].entity == self)
		{
			continue;
		}

		var_08 = distance(param_00,var_06[var_07].damagecenter);
		if(var_06[var_07].isplayer)
		{
			var_09 = !maps\mp\gametypes\_weapons::weapondamagetracepassed(var_06[var_07].entity.origin,var_06[var_07].entity.origin + (0,0,130),0,undefined);
			if(!var_09)
			{
				var_09 = !maps\mp\gametypes\_weapons::weapondamagetracepassed(var_06[var_07].entity.origin + (0,0,130),param_00 + (0,0,114),0,undefined);
				if(var_09)
				{
					var_08 = var_08 * 4;
					if(var_08 > param_01)
					{
						continue;
					}
				}
			}
		}

		var_06[var_07].damage = int(param_02 + param_03 - param_02 * var_08 / param_01);
		var_06[var_07].pos = param_00;
		var_06[var_07].damageowner = param_04;
		var_06[var_07].einflictor = param_05;
		level.airstrikedamagedents[level.airstrikedamagedentscount] = var_06[var_07];
		level.airstrikedamagedentscount++;
	}

	thread airstrikedamageentsthread();
}

//Function Number: 13
airstrikedamageentsthread()
{
	self notify("airstrikeDamageEntsThread");
	self endon("airstrikeDamageEntsThread");
	while(level.airstrikedamagedentsindex < level.airstrikedamagedentscount)
	{
		if(!isdefined(level.airstrikedamagedents[level.airstrikedamagedentsindex]))
		{
			continue;
		}

		var_00 = level.airstrikedamagedents[level.airstrikedamagedentsindex];
		if(!isdefined(var_00.entity))
		{
			continue;
		}

		if(!var_00.isplayer || isalive(var_00.entity))
		{
			var_00 maps\mp\gametypes\_weapons::damageent(var_00.einflictor,var_00.damageowner,var_00.damage,"MOD_PROJECTILE_SPLASH","artillery_mp",var_00.pos,vectornormalize(var_00.damagecenter - var_00.pos));
			level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
			if(var_00.isplayer)
			{
				wait(0.05);
			}

			continue;
		}

		level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
		level.airstrikedamagedentsindex++;
	}
}

//Function Number: 14
radiusartilleryshellshock(param_00,param_01,param_02,param_03)
{
	var_04 = level.players;
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(!isalive(var_04[var_05]))
		{
			continue;
		}

		var_06 = var_04[var_05].origin + (0,0,32);
		var_07 = distance(param_00,var_06);
		if(var_07 < param_01)
		{
			var_08 = int(param_02 + param_03 - param_02 * var_07 / param_01);
			var_04[var_05] thread artilleryshellshock("default",var_08);
		}
	}
}

//Function Number: 15
artilleryshellshock(param_00,param_01)
{
	if(isdefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked)
	{
		return;
	}

	self.beingartilleryshellshocked = 1;
	self shellshock(param_00,param_01);
	wait(param_01 + 1);
	self.beingartilleryshellshocked = 0;
}

//Function Number: 16
doplanestrike(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_08 = 100;
	var_09 = 150;
	var_0A = param_03 + (randomfloat(2) - 1 * var_08,randomfloat(2) - 1 * var_08,0);
	var_0B = param_04 + (randomfloat(2) - 1 * var_09,randomfloat(2) - 1 * var_09,0);
	var_0C = spawnplane(param_00,"script_model",var_0A,"compass_objpoint_airstrike_friendly","compass_objpoint_airstrike_busy");
	var_0D = param_00.pers["team"];
	if(var_0D == "allies")
	{
		var_0E = "h1_vehicle_av8b_harrier";
		if(isdefined(level.airstrike_model_allies_override))
		{
			var_0E = level.airstrike_model_allies_override;
		}

		var_0C setmodel(var_0E);
	}
	else
	{
		var_0E = "h1_vehicle_mig29";
		if(isdefined(level.airstrike_model_axis_override))
		{
			var_0E = level.airstrike_model_axis_override;
		}

		var_0C setmodel(var_0E);
	}

	var_0C.angles = param_07;
	var_0F = anglestoforward(param_07);
	if(isdefined(level.airstrike_plane_fx_func))
	{
		var_0C thread [[ level.airstrike_plane_fx_func ]](var_0D);
	}
	else
	{
		var_0C thread playplanefx(var_0D);
	}

	var_0C moveto(var_0B,param_06,0,0);
	thread callstrike_planesound(var_0C,param_02);
	thread callstrike_bombeffect(var_0C,var_0B,param_06,param_05 - 1,param_00,param_01);
	wait(param_06);
	var_0C notify("delete");
	var_0C delete();
}

//Function Number: 17
callstrike_bombeffect(param_00,param_01,param_02,param_03,param_04,param_05)
{
	wait(param_03);
	param_00 thread common_scripts\utility::play_sound_in_space("h1_ks_airstrike_jet_by");
	var_06 = anglestoforward(param_00.angles);
	var_07 = spawnbomb(param_00.origin,param_00.angles);
	var_07 movegravity(common_scripts\utility::vectorscale(anglestoforward(param_00.angles),4666.667),3);
	var_07.ownerrequireddeathcount = param_05;
	var_08 = spawn("script_model",param_00.origin + (0,0,100) - var_06 * 200);
	var_07.killcament = var_08;
	var_08.starttime = gettime();
	var_08 thread deleteaftertime(15);
	var_08.angles = var_06;
	var_08 moveto(param_01 + (0,0,100),param_02,0,0);
	wait(0.4);
	var_08 moveto(var_08.origin + var_06 * 4000,1,0,0);
	wait(0.45);
	var_08 moveto(var_08.origin + var_06 + (0,0,-0.2) * 3500,2,0,0);
	wait(0.15);
	var_09 = spawn("script_model",var_07.origin);
	var_09 setmodel("tag_origin");
	var_09.origin = var_07.origin;
	var_09.angles = var_07.angles;
	var_07 setmodel("tag_origin");
	wait(0.1);
	var_0A = var_09.origin;
	var_0B = var_09.angles;
	playfxontag(level.airstrikefx,var_09,"tag_origin");
	wait(0.05);
	var_08 moveto(var_08.origin + var_06 + (0,0,-0.25) * 2500,2,0,0);
	wait(0.25);
	var_08 moveto(var_08.origin + var_06 + (0,0,-0.35) * 2000,2,0,0);
	wait(0.2);
	var_08 moveto(var_08.origin + var_06 + (0,0,-0.45) * 1500,2,0,0);
	var_0C = 12;
	var_0D = 5;
	var_0E = 55;
	var_0F = var_0E - var_0D / var_0C;
	var_10 = (0,0,0);
	for(var_11 = 0;var_11 < var_0C;var_11++)
	{
		var_12 = anglestoforward(var_0B + (var_0E - var_0F * var_11,randomint(10) - 5,0));
		var_13 = var_0A + common_scripts\utility::vectorscale(var_12,10000);
		var_14 = bullettrace(var_0A,var_13,0,undefined);
		var_15 = var_14["position"];
		var_10 = var_10 + var_15;
		thread losradiusdamage(var_15 + (0,0,16),512,200,30,param_04,var_07);
		if(var_11 % 3 == 0)
		{
			thread maps\mp\_utility::playsoundinspace("h1_ks_airstrike_exp",var_15);
			playrumbleonposition("artillery_rumble",var_15);
			earthquake(0.7,0.75,var_15,1000);
		}

		wait(0.05);
	}

	var_10 = var_10 / var_0C + (0,0,128);
	var_08 moveto(var_07.killcament.origin * 0.35 + var_10 * 0.65,1.5,0,0.5);
	wait(5);
	var_09 delete();
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
deleteaftertime(param_00)
{
	self endon("death");
	wait(10);
	self delete();
}

//Function Number: 20
playplanefx(param_00)
{
	self endon("death");
	if(param_00 == "allies")
	{
		playfxontag(level.fx_airstrike_harrier_jet,self,"tag_engine_right");
		playfxontag(level.fx_airstrike_harrier_jet,self,"tag_engine_right2");
		playfxontag(level.fx_airstrike_harrier_jet,self,"tag_engine_left");
		playfxontag(level.fx_airstrike_harrier_jet,self,"tag_engine_left2");
		wait(1);
	}
	else
	{
		playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_right");
		playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_left");
	}

	playfxontag(level.fx_airstrike_contrail,self,"tag_right_wingtip");
	playfxontag(level.fx_airstrike_contrail,self,"tag_left_wingtip");
}

//Function Number: 21
getbestplanedirection(param_00)
{
	if(getdvarint("scr_airstrikebestangle") != 1)
	{
		return randomfloat(360);
	}

	var_01 = -25;
	var_02 = 15;
	var_03 = param_00 + (0,0,64);
	var_04 = randomfloat(360);
	var_05 = 0;
	var_06 = [];
	for(var_07 = 0;var_07 < var_02;var_07++)
	{
		var_08 = var_07 * 1 + randomfloat(1) / var_02 * 360;
		var_09 = (var_01,var_08 + 180,0);
		var_0A = anglestoforward(var_09);
		var_0B = var_03 + var_0A * 1500;
		var_0C = bullettrace(var_03,var_0B,0,undefined);
		if(var_0C["fraction"] > var_05)
		{
			var_05 = var_0C["fraction"];
			var_04 = var_08;
			if(var_0C["fraction"] >= 1)
			{
				var_06[var_06.size] = var_08;
			}
		}

		if(var_07 % 3 == 0)
		{
			wait(0.05);
		}
	}

	if(var_06.size > 0)
	{
		return var_06[randomint(var_06.size)];
	}

	return var_04;
}

//Function Number: 22
callstrike(param_00,param_01,param_02)
{
	var_03 = (0,param_02,0);
	var_04 = 24000;
	var_05 = 1500;
	var_06 = 850;
	var_07 = 7000;
	if(isdefined(level.airstrikeheightscale))
	{
		var_06 = var_06 * level.airstrikeheightscale;
	}

	var_08 = param_01 + common_scripts\utility::vectorscale(anglestoforward(var_03),-1 * var_04);
	var_08 = var_08 + (0,0,var_06);
	var_09 = param_01 + common_scripts\utility::vectorscale(anglestoforward(var_03),var_04);
	var_09 = var_09 + (0,0,var_06);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / var_07;
	var_0A = abs(var_0A / 2 + var_05);
	var_0C = var_0A / var_07;
	param_00 endon("disconnect");
	var_0D = param_00.deaths;
	level.airstrikedamagedents = [];
	level.airstrikedamagedentscount = 0;
	level.airstrikedamagedentsindex = 0;
	level thread doplanestrike(param_00,var_0D,param_01,var_08 + (0,0,randomint(500)),var_09 + (0,0,randomint(500)),var_0C,var_0B,var_03);
	var_0E = randomfloatrange(1.5,2.5);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0E);
	level thread doplanestrike(param_00,var_0D,param_01,var_08 + (0,0,randomint(200)),var_09 + (0,0,randomint(200)),var_0C,var_0B,var_03);
	var_0E = randomfloatrange(1.5,2.5);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0E);
	level thread doplanestrike(param_00,var_0D,param_01,var_08 + (0,0,randomint(200)),var_09 + (0,0,randomint(200)),var_0C,var_0B,var_03);
}

//Function Number: 23
targetisclose(param_00,param_01)
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
	var_05 = var_04 + common_scripts\utility::vectorscale(anglestoforward(common_scripts\utility::flat_angle(param_00.angles)),var_03 * 100000);
	var_06 = pointonsegmentnearesttopoint(var_04,var_05,param_01);
	var_07 = distance(var_04,var_06);
	if(var_07 < 3000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
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

//Function Number: 25
callstrike_planesound(param_00,param_01)
{
	param_00 thread common_scripts\utility::play_loop_sound_on_entity("h1_ks_veh_mig29_dist_loop");
	while(!targetisclose(param_00,param_01))
	{
		wait(0.05);
	}

	param_00 notify("stop soundh1_ks_veh_mig29_dist_loop");
	param_00 thread common_scripts\utility::play_loop_sound_on_entity(level.airstrike_close_sound);
	while(targetisinfront(param_00,param_01))
	{
		wait(0.05);
	}

	wait(0.5);
	while(targetisclose(param_00,param_01))
	{
		wait(0.05);
	}

	param_00 notify("stop sound" + level.airstrike_close_sound);
	param_00 thread common_scripts\utility::play_loop_sound_on_entity("h1_ks_veh_mig29_dist_loop");
	param_00 waittill("delete");
	param_00 notify("stop soundh1_ks_veh_mig29_dist_loop");
}

//Function Number: 26
givehardpointitemforstreak()
{
	var_00 = self.pers["cur_kill_streak"];
	foreach(var_03, var_02 in level.hardpointitems)
	{
		if(getdvarint("scr_game_forceuav") && var_03 == "radar_mp")
		{
			continue;
		}

		if(var_00 == var_02)
		{
			thread givehardpoint(var_03,var_02);
			break;
		}
	}
}

//Function Number: 27
waittilldoneusingkillstreak()
{
	for(var_00 = self getcurrentprimaryweapon();maps\mp\_utility::iskillstreakweapon(var_00) || maps\mp\_utility::is_true(self.selectinglocation);var_00 = self getcurrentprimaryweapon())
	{
		wait 0.05;
	}
}

//Function Number: 28
givehardpoint(param_00,param_01)
{
	self notify("giveHardpoint");
	self endon("giveHardpoint");
	self endon("disconnect");
	self endon("death");
	waittilldoneusingkillstreak();
	if(givehardpointitem(param_00))
	{
		thread hardpointnotify(param_00,param_01);
	}
}

//Function Number: 29
hardpointnotify(param_00,param_01)
{
	thread maps\mp\_events::earnedkillstreakevent(param_00,param_01);
	maps\mp\_utility::leaderdialogonplayer(param_00,"killstreak_earned",1);
}

//Function Number: 30
killstreakearned(param_00)
{
	if(param_00 == "radar_mp")
	{
		self.firstkillstreakearned = gettime();
		return;
	}

	if(isdefined(self.firstkillstreakearned) && param_00 == "helicopter_mp")
	{
		if(gettime() - self.firstkillstreakearned < 20000)
		{
			thread maps\mp\gametypes\_misions::genericchallenge("wargasm");
			return;
		}
	}
}

//Function Number: 31
removekillstreakweapons()
{
	var_00 = self getweaponslistall();
	foreach(var_02 in var_00)
	{
		if(maps\mp\_utility::iskillstreakweapon(var_02))
		{
			self takeweapon(var_02);
		}
	}
}

//Function Number: 32
givehardpointitem(param_00)
{
	if(level.gameended && level.gameendtime != gettime())
	{
		return 0;
	}

	if(!maps\mp\_utility::is_true(level.killstreaksenabled))
	{
		return 0;
	}

	if(getdvar("scr_game_hardpoints") != "" && getdvarint("scr_game_hardpoints") == 0)
	{
		return 0;
	}

	if(isdefined(self.selectinglocation))
	{
		return 0;
	}

	var_01 = self getcurrentprimaryweapon();
	if(maps\mp\_utility::iskillstreakweapon(var_01))
	{
		return 0;
	}

	if(!isdefined(level.hardpointitems[param_00]) || !level.hardpointitems[param_00])
	{
		return 0;
	}

	if((!isdefined(level.heli_paths) || !level.heli_paths.size) && param_00 == "helicopter_mp")
	{
		return 0;
	}

	if(isdefined(self.pers["hardPointItem"]))
	{
		if(level.hardpointitems[param_00] < level.hardpointitems[self.pers["hardPointItem"]])
		{
			return 0;
		}
	}

	removekillstreakweapons();
	self giveweapon(param_00);
	self givemaxammo(param_00);
	self setactionslot(4,"weapon",param_00);
	self.pers["hardPointItem"] = param_00;
	var_02 = maps\mp\_utility::getkillstreakindex(param_00);
	self setclientomnvar("ks_icon0",var_02);
	return 1;
}

//Function Number: 33
giveownedhardpointitem()
{
	if(isdefined(self.pers["hardPointItem"]))
	{
		givehardpointitem(self.pers["hardPointItem"]);
	}
}

//Function Number: 34
hardpointitemwaiter()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\_utility::is_true(level.gameended))
	{
		return;
	}

	var_00 = self getcurrentweapon();
	giveownedhardpointitem();
	self waittill("weapon_change");
	var_01 = self getcurrentweapon();
	switch(var_01)
	{
		case "helicopter_mp":
		case "airstrike_mp":
		case "radar_mp":
			break;

		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 35
playerwaitforweapontoanimate(param_00)
{
	if(param_00 == "radar_mp" || param_00 == "helicopter_mp")
	{
		common_scripts\utility::_disableweaponswitch();
		var_01 = common_scripts\utility::waittill_notify_or_timeout_return("weapon_change",0.75);
		common_scripts\utility::_enableweaponswitch();
		if(!isdefined(var_01) && !self isonladder() && !self isusingturret())
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 36
playertakehardpointweapon(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(param_00 != "none")
	{
		var_02 = playerwaitforweapontoanimate(param_01);
		if(var_02)
		{
			self switchtoweapon(param_00);
			common_scripts\utility::_disableweaponswitch();
			self waittill("weapon_change");
			common_scripts\utility::_enableweaponswitch();
		}
	}

	self takeweapon(param_01);
}

//Function Number: 37
triggerhardpoint(param_00)
{
	if(level.killstreakrounddelay)
	{
		var_01 = 0;
		if(isdefined(level.prematch_done_time))
		{
			var_01 = gettime() - level.prematch_done_time / 1000;
		}

		if(var_01 < level.killstreakrounddelay)
		{
			var_02 = int(level.killstreakrounddelay - var_01 + 0.5);
			if(!var_02)
			{
				var_02 = 1;
			}

			self iprintlnbold(&"MP_UNAVAILABLE_FOR_N",var_02);
			return 0;
		}
	}

	if(var_01 == "radar_mp")
	{
		maps\mp\_matchdata::logkillstreakevent(var_01,self.origin);
		thread useradaritem();
	}
	else if(var_01 == "airstrike_mp")
	{
		if(isdefined(level.airstrikeinprogress))
		{
			self method_854D("h1_ks_airstrike_activate_start_plr");
			self iprintlnbold(level.hardpointhints[var_01 + "_not_available"]);
			return 0;
		}

		var_03 = selectairstrikelocation(var_01);
		if(!isdefined(var_03) || !var_03)
		{
			return 0;
		}
	}
	else if(var_01 == "helicopter_mp")
	{
		if(isdefined(level.chopper))
		{
			self iprintlnbold(level.hardpointhints[var_01 + "_not_available"]);
			return 0;
		}

		var_04 = 0;
		var_05 = randomint(level.heli_paths[var_04].size);
		var_06 = level.heli_paths[var_04][var_05];
		var_07 = self.pers["team"];
		var_08 = level.otherteam[var_07];
		if(level.teambased)
		{
			maps\mp\_utility::leaderdialog("helicopter_inbound",var_07);
			maps\mp\_utility::leaderdialog("enemy_helicopter_inbound",var_08);
			for(var_09 = 0;var_09 < level.players.size;var_09++)
			{
				var_0A = level.players[var_09];
				var_0B = var_0A.pers["team"];
				if(isdefined(var_0B))
				{
					if(var_0B == var_07)
					{
						var_0A iprintln(&"MP_HELICOPTER_INBOUND",self);
					}
				}
			}
		}
		else
		{
			maps\mp\_utility::leaderdialogonplayer("helicopter_inbound");
			var_0C = [];
			var_0C[0] = self;
			maps\mp\_utility::leaderdialog("enemy_helicopter_inbound",undefined,undefined,var_0C);
		}

		maps\mp\_matchdata::logkillstreakevent(var_01,self.origin);
		thread maps\mp\_helicopter::heli_think(self,var_06,self.pers["team"]);
	}

	return 1;
}

//Function Number: 38
uavacquiredprintandsound(param_00,param_01,param_02,param_03)
{
	var_04 = game["voice"][param_00] + game["dialog"]["uav_online"];
	var_05 = game["voice"][param_01] + game["dialog"]["enemy_uav_online"];
	if(level.splitscreen)
	{
		for(var_06 = 0;var_06 < level.players.size;var_06++)
		{
			var_07 = level.players[var_06];
			var_08 = var_07.pers["team"];
			if(isdefined(var_08))
			{
				if(var_08 == param_00)
				{
					var_07 iprintln(&"MP_WAR_RADAR_ACQUIRED",param_02,param_03);
					continue;
				}

				if(var_08 == param_01)
				{
					var_07 iprintln(&"MP_WAR_RADAR_ACQUIRED_ENEMY",param_03);
				}
			}
		}

		level.players[0] playlocalsound(var_04);
		return;
	}

	maps\mp\_utility::leaderdialog("uav_online",param_03);
	maps\mp\_utility::leaderdialog("enemy_uav_online",var_04);
	for(var_06 = 0;var_06 < level.players.size;var_06++)
	{
		var_07 = level.players[var_06];
		var_08 = var_07.pers["team"];
		if(isdefined(var_08))
		{
			if(var_08 == param_00)
			{
				var_07 iprintln(&"MP_WAR_RADAR_ACQUIRED",param_02,param_03);
				continue;
			}

			if(var_08 == param_01)
			{
				var_07 iprintln(&"MP_WAR_RADAR_ACQUIRED_ENEMY",param_03);
			}
		}
	}
}

//Function Number: 39
useradaritem()
{
	var_00 = self.pers["team"];
	var_01 = "axis";
	if(var_00 == "axis")
	{
		var_01 = "allies";
	}

	if(level.teambased)
	{
		uavacquiredprintandsound(var_00,var_01,self,level.radarviewtime);
		level notify("radar_timer_kill_" + var_00);
		thread useteamuav(var_00,var_01);
		return;
	}

	maps\mp\_utility::leaderdialogonplayer("uav_online");
	self iprintln(&"MP_WAR_RADAR_ACQUIRED",self,level.radarviewtime);
	self notify("radar_timer_kill");
	thread useplayeruav();
}

//Function Number: 40
waitforradartoexpireorinterrupt(param_00)
{
	self endon(param_00);
	self endon("disconnect");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.radarviewtime);
	return "expire";
}

//Function Number: 41
useteamuav(param_00,param_01)
{
	level endon("game_ended");
	setteamradarwrapper(param_00,1);
	var_02 = spawnstruct();
	var_02.team = param_00;
	var_02.owner = self;
	var_02.uavtype = "standard";
	var_02.origin = (0,0,0);
	var_02 adduavmodel();
	var_02 addactiveuav();
	var_03 = level waitforradartoexpireorinterrupt("radar_timer_kill_" + param_00);
	if(isdefined(var_03) && var_03 == "expire")
	{
		setteamradarwrapper(param_00,0);
		maps\mp\_utility::printandsoundoneveryone(param_00,param_01,&"MP_WAR_RADAR_EXPIRED",&"MP_WAR_RADAR_EXPIRED_ENEMY",undefined,undefined,"");
	}

	var_02 removeactiveuav();
	var_02 removeuavmodel();
	var_02 = undefined;
}

//Function Number: 42
useplayeruav(param_00,param_01)
{
	level endon("game_ended");
	self.hasradar = 1;
	var_02 = spawnstruct();
	var_02.team = param_00;
	var_02.owner = self;
	var_02.uavtype = "standard";
	var_02.origin = (0,0,0);
	var_02 adduavmodel();
	var_02 addactiveuav();
	var_03 = waitforradartoexpireorinterrupt("radar_timer_kill");
	if(isdefined(var_03) && var_03 == "expire")
	{
		self.hasradar = 0;
		self iprintln(&"MP_WAR_RADAR_EXPIRED");
	}

	var_02 removeactiveuav();
	var_02 removeuavmodel();
	var_02 = undefined;
}

//Function Number: 43
setteamradarwrapper(param_00,param_01)
{
	setteamradar(param_00,param_01);
	var_02 = 0;
	if(param_01)
	{
		var_02 = 1;
	}

	level notify("radar_status_change",param_00);
}

//Function Number: 44
waitforairstrikecancel()
{
	self endon("location_selection_complete");
	self endon("disconnect");
	self waittill("stop_location_selection");
	if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() > 0)
	{
		self switchtoweapon(common_scripts\utility::getlastweapon());
	}
}

//Function Number: 45
selectairstrikelocation(param_00)
{
	if(!isdefined(level.mapsize))
	{
		level.mapsize = 1024;
	}

	var_01 = level.mapsize / 6.46875;
	if(level.splitscreen)
	{
		var_01 = var_01 * 1.5;
	}

	maps\mp\_utility::_beginlocationselection(param_00,"map_artillery_selector",0,var_01);
	thread waitforairstrikecancel();
	self endon("stop_location_selection");
	self endon("disconnect");
	self waittill("confirm_location",var_02);
	if(isdefined(level.airstrikeinprogress))
	{
		self iprintlnbold(level.hardpointhints["airstrike_mp_not_available"]);
		thread maps\mp\_utility::stoplocationselection(0,"cancel_location");
		return 0;
	}

	maps\mp\_matchdata::logkillstreakevent(param_00,var_02);
	thread finishairstrikeusage(var_02,::useairstrike);
	return 1;
}

//Function Number: 46
finishairstrikeusage(param_00,param_01)
{
	self notify("used");
	self thread [[ param_01 ]](param_00);
	return 1;
}

//Function Number: 47
useairstrike(param_00)
{
	if(!isdefined(level.airstrikeheight))
	{
		var_01 = bullettrace(level.mapcenter + (0,0,100000),level.mapcenter,0,undefined);
		level.airstrikeheight = var_01["position"][2] - 514;
	}

	param_00 = (param_00[0],param_00[1],level.airstrikeheight);
	thread doartillery(param_00,self,self.pers["team"]);
}

//Function Number: 48
killstreakhit(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isplayer(param_00) && isdefined(param_02.owner) && isdefined(param_02.owner.team))
	{
		if(((level.teambased && param_02.owner.team != param_00.team) || !level.teambased) && param_00 != param_02.owner)
		{
			if(maps\mp\_utility::iskillstreakweapon(param_01))
			{
				return;
			}

			if(!isdefined(param_00.lasthittime[param_01]))
			{
				param_00.lasthittime[param_01] = 0;
			}

			if(param_00.lasthittime[param_01] == gettime())
			{
				return;
			}

			param_00.lasthittime[param_01] = gettime();
			param_00 thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname(param_01,1,"hits");
			var_03 = param_00 maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
			var_04 = param_00 maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;
			if(var_04 <= var_03)
			{
				param_00 maps\mp\gametypes\_persistence::statsetbuffered("hits",var_04);
				param_00 maps\mp\gametypes\_persistence::statsetbuffered("misses",int(var_03 - var_04));
				var_05 = clamp(float(var_04) / float(var_03),0,1) * 10000;
				param_00 maps\mp\gametypes\_persistence::statsetbuffered("accuracy",int(var_05));
				return;
			}
		}
	}
}

//Function Number: 49
playerhasuavactive()
{
	if(level.teambased)
	{
		if(level.activeuavs[self.team] > 0)
		{
			return 1;
		}
	}
	else if(level.activeuavs[self.guid] > 0)
	{
		return 1;
	}

	return 0;
}