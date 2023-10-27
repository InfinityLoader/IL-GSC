/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_a10.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 22
 * Decompile Time: 316 ms
 * Timestamp: 10/27/2023 2:26:30 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_WAR_AIRSTRIKE_INBOUND");
	precachestring(&"SPLASHES_DESTROYED_A10");
	precachestring(&"KILLSTREAKS_A10_SUPPORT");
	precachemodel("vehicle_a10_warthog");
	precacheitem("a10_30mm_mp");
	precachempanim("MP_A10_strafing_run");
	precacheshader("compass_objpoint_a10_friendly");
	precacheshader("compass_objpoint_a10_enemy");
	precacheminimapicon("compass_objpoint_a10_friendly");
	precacheminimapicon("compass_objpoint_a10_enemy");
	level.a10_fx["bullet_rain"] = loadfx("misc/warthog_volley_runner");
	level.a10_fx["bullet_impacts"] = loadfx("impacts/warthog_volley_runner");
	level.a10_fx["bullet_dust"] = loadfx("dust/wing_drop_dust");
	level.a10_fx["afterburner"] = loadfx("fire/jet_afterburner");
	level.a10_fx["contrail"] = loadfx("smoke/jet_contrail");
	level.a10_fx["wingtip_light_green"] = loadfx("misc/aircraft_light_wingtip_green");
	level.a10_fx["wingtip_light_red"] = loadfx("misc/aircraft_light_wingtip_red");
	level.killstreakfuncs["a10_support"] = ::tryusea10strike;
	level.killstreaksetupfuncs["a10_support"] = ::func_3430;
	level.a10maxhealth = 350;
	level.a10speed = 100;
	level.a10speedreduction = 75;
	level.a10startpointoffset = 5000;
	level.a10impactfxdelay = 0.5;
	level.a10damage = 200;
	level.a10damageradius = 384;
	level.a10damagedelay = 0.5;
	level.a10bulletraindelay = 0.5;
	level.a10bulletimpactsdelay = 0.5;
	level.a10earthquakemagnitude = 0.1;
	level.a10earthquakeduration = 0.5;
	level.a10earthquakedelay = 0.5;
	level.a10dirteffectradius = 350;
	level.a10shootinggroundsounddelay = 0.1;
	level.a10startpositionscalar = 2000;
}

//Function Number: 2
func_3430()
{
	self.useduava10 = 0;
}

//Function Number: 3
tryusea10strike(param_00)
{
	var_01 = undefined;
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::func_2BE7())
	{
		return 0;
	}

	if(maps\mp\_utility::func_27E5())
	{
		return 0;
	}

	var_02 = "a10_support";
	if(!self.useduava10)
	{
		self.useduava10 = 1;
		maps\mp\killstreaks\_uav::useuav(var_02);
	}

	var_01 = func_3433(param_00,var_02);
	if(!isdefined(var_01) || !var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_3433(param_00,param_01)
{
	self playlocalsound("US_KS_hqr_a10");
	maps\mp\_utility::_beginlocationselection(param_01,"map_artillery_selector",1,500);
	self endon("stop_location_selection");
	self waittill("confirm_location",var_02,var_03);
	self playlocalsound("US_KS_a10_inbound");
	thread finisha10strikeusage(param_00,var_02,::calla10strike,var_03);
	self setblurforplayer(0,0.3);
	return 1;
}

//Function Number: 5
finisha10strikeusage(param_00,param_01,param_02,param_03)
{
	self notify("used");
	wait 0.05;
	thread maps\mp\_utility::func_2EB1(0);
	self thread [[ param_02 ]](param_00,param_01,param_03);
	return 1;
}

//Function Number: 6
calla10strike(param_00,param_01,param_02)
{
	if(!isdefined(self))
	{
		return;
	}

	if(level.teambased)
	{
		var_03 = level.players;
		foreach(var_05 in level.players)
		{
			var_06 = var_05.pers["team"];
			if(isdefined(var_06))
			{
				if(var_06 == self.team)
				{
					var_05 iprintln(&"MP_WAR_AIRSTRIKE_INBOUND",self);
				}
			}
		}
	}

	var_08 = (0,param_02,0);
	var_09 = 12000;
	var_0A = param_01 + anglestoforward(var_08) * -1 * var_09;
	var_0B = param_01 + anglestoforward(var_08) * var_09 * 2;
	var_0A = var_0A * (1,1,0);
	var_0B = var_0B * (1,1,0);
	var_0C = getbestheight(var_0A,var_0B);
	var_0B = var_0B + (0,0,var_0C);
	var_0A = var_0A + (0,0,var_0C);
	self endon("disconnect");
	var_0D = self.lifeid;
	level thread doa10strike(param_00,self,var_0D,param_01,var_0A,var_0B,var_08,0);
}

//Function Number: 7
getbestheight(param_00,param_01)
{
	var_02 = getent("airstrikeheight","targetname");
	var_03 = level.spawnpoints;
	var_04 = var_03[0];
	foreach(var_06 in var_03)
	{
		if(var_06.origin[2] < var_04.origin[2])
		{
			var_04 = var_06;
		}
	}

	if(isdefined(var_02))
	{
		var_08 = var_02.origin[2];
	}
	else if(isdefined(level.airstrikeheightscale))
	{
		var_08 = 850 * level.airstrikeheightscale;
	}
	else
	{
		var_08 = 850;
	}

	var_09 = var_08;
	var_0A = var_08;
	var_0B = var_04.origin[2];
	var_0C = undefined;
	var_0D = 0;
	for(;;)
	{
		var_0E = var_0A - var_0B / 2 + var_0B;
		var_0F = bullettrace(param_00 + (0,0,var_0E),param_01 + (0,0,var_0E),0,undefined);
		if(var_0F["surfacetype"] != "none")
		{
			var_0B = var_0E;
			var_0D++;
			if(var_0D > 4 && isdefined(var_0C))
			{
				var_08 = var_0C;
				break;
			}
			else if(var_0D > 6)
			{
				var_08 = var_09;
				break;
			}
		}
		else
		{
			var_0C = var_0E;
			var_0A = var_0E;
			if(var_0E < var_04.origin[2] + 512)
			{
				var_08 = var_04.origin[2] + 512;
				break;
			}
		}

		wait 0.05;
	}

	var_0D = 0;
	for(;;)
	{
		wait 0.05;
		var_10 = bullettrace(param_00 + (0,0,var_08),param_01 + (0,0,var_08),0,undefined);
		var_11 = bullettrace(param_00 + (50,50,var_08 + 50),param_01 + (50,50,var_08 + 50),0,undefined);
		wait 0.05;
		var_12 = bullettrace(param_00 + (-50,-50,var_08 - 50),param_01 + (-50,-50,var_08 - 50),0,undefined);
		var_13 = bullettrace(param_00 + (50,50,var_08 - 50),param_01 + (50,50,var_08 - 50),0,undefined);
		wait 0.05;
		var_14 = bullettrace(param_00 + (-50,-50,var_08 + 50),param_01 + (-50,-50,var_08 + 50),0,undefined);
		if(var_10["surfacetype"] != "none" || var_11["surfacetype"] != "none" || var_12["surfacetype"] != "none" || var_13["surfacetype"] != "none" || var_14["surfacetype"] != "none")
		{
			var_0D++;
			var_08 = var_08 + 200;
			if(var_0D > 5)
			{
				var_08 = var_09;
				break;
			}

			continue;
		}

		break;
	}

	return var_08 + 175;
}

//Function Number: 8
doa10strike(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_08 = func_343E(param_01,param_04,param_05,param_03,param_07);
	var_08.lifeid = param_00;
	var_08 playloopsound("veh_mig29_dist_loop");
	var_09 = level.spawnpoints;
	var_0A = var_09[0];
	foreach(var_0C in var_09)
	{
		if(var_0C.origin[2] > var_0A.origin[2])
		{
			var_0A = var_0C;
		}
	}

	var_08.killcament = spawn("script_model",(var_08.origin[0],var_08.origin[1],var_0A.origin[2] + 5000));
	var_08.killcament linkto(var_08);
	param_01.a10 = var_08;
	var_08 thread watchtimeout();
	var_08 thread func_28F6();
	var_08 endon("death");
	var_08 thread func_3438();
}

//Function Number: 9
watchtimeout()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	maps\mp\gametypes\_hostmigration::func_2740(35);
	self notify("death");
}

//Function Number: 10
func_3438()
{
	self endon("death");
	wait self.initialdelay;
	var_00 = self.startpoint;
	var_01 = self.attackpoint;
	var_02 = self.endpoint;
	var_01 = (var_01[0],var_01[1],var_00[2] - level.a10startpointoffset);
	var_03 = distance(var_00,var_01) * 0.5;
	var_04 = float(level.a10speed);
	var_05 = var_03 / var_04 / 60;
	var_06 = var_00 + vectornormalize(var_01 - var_00) * var_03;
	thread a10playenginefx();
	self moveto(var_06,var_05);
	wait var_05;
	var_03 = distance(var_00,var_01) * 0.5;
	var_04 = float(level.a10speed - level.a10speedreduction);
	var_05 = var_03 / var_04 / 60;
	self moveto(var_01,var_05);
	thread func_3440(var_05);
	thread monitorkills();
	wait var_05;
	self notify("stopShooting");
	var_03 = distance2d(var_01,var_02);
	var_04 = level.a10speed;
	var_05 = var_03 / var_04 / 60;
	self moveto(var_02,var_05);
	var_07 = vectortoangles(var_02 - var_01);
	self waittill("movedone");
	self notify("gone");
	wait 0.5;
	func_3448();
}

//Function Number: 11
a10playenginefx()
{
	self endon("death");
	wait 0.5;
	playfxontag(level.a10_fx["afterburner"],self,"tag_engine_right");
	wait 0.5;
	playfxontag(level.a10_fx["afterburner"],self,"tag_engine_left");
	wait 0.5;
	playfxontag(level.a10_fx["contrail"],self,"tag_right_wingtip");
	wait 0.5;
	playfxontag(level.a10_fx["contrail"],self,"tag_left_wingtip");
	wait 0.5;
	playfxontag(level.a10_fx["wingtip_light_red"],self,"tag_right_wingtip");
	wait 0.5;
	playfxontag(level.a10_fx["wingtip_light_green"],self,"tag_left_wingtip");
}

//Function Number: 12
monitorkills()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	self endon("stopShooting");
	for(;;)
	{
		self waittill("killedPlayer");
		self.killcount++;
	}
}

//Function Number: 13
func_343E(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = param_01 + (0,0,level.a10startpointoffset);
	var_05 = vectortoangles(param_02 - param_01);
	var_06 = spawn("script_model",param_01);
	var_07 = spawnplane(param_00,"script_model",param_01,"compass_objpoint_a10_friendly","compass_objpoint_a10_enemy");
	if(!isdefined(var_06))
	{
		return;
	}

	var_07 linkto(var_06);
	var_06.fakea10 = var_07;
	var_06 setmodel("vehicle_a10_warthog");
	var_06.health = 999999;
	var_06.maxhealth = level.a10maxhealth;
	var_06.damagetaken = 0;
	var_06.owner = param_00;
	var_06.team = param_00.team;
	var_06.killcount = 0;
	var_06.startpoint = param_01;
	var_06.endpoint = param_02;
	var_06.attackpoint = param_03;
	var_06.initialdelay = param_04;
	var_06.angles = var_05;
	return var_06;
}

//Function Number: 14
func_3440(param_00)
{
	self endon("gone");
	self endon("death");
	self endon("stopShooting");
	var_01 = level.spawnpoints;
	var_02 = var_01[0];
	var_03 = vectornormalize(self.origin - self.attackpoint) * level.a10startpositionscalar;
	var_03 = self.attackpoint + (var_03[0],var_03[1],0);
	var_04 = vectornormalize(self.origin - self.attackpoint) * -1 * level.a10startpositionscalar;
	var_04 = self.attackpoint + (var_04[0],var_04[1],0);
	var_05 = vectornormalize(var_04 - var_03);
	var_06 = distance2d(var_03,var_04) / param_00 / 0.05;
	self.a10shootingpos = (var_03[0],var_03[1],var_02.origin[2] - 128);
	var_07 = var_05 * var_06;
	thread func_3442();
	thread func_3443();
	thread manageshootinggroundsound();
	thread func_3445();
	while(param_00 > 0)
	{
		foreach(var_09 in level.players)
		{
			if(level.teambased)
			{
				if(var_09.team != self.owner.team)
				{
					var_0A = pointonsegmentnearesttopoint(self.origin,self.a10shootingpos,var_09.origin);
					if(distancesquared(var_0A,var_09.origin) < level.a10damageradius * level.a10damageradius)
					{
						radiusdamage(var_0A,level.a10damageradius,level.a10damage,level.a10damage,self,"MOD_RIFLE_BULLET","a10_30mm_mp");
					}
				}

				continue;
			}

			var_0A = pointonsegmentnearesttopoint(self.origin,self.a10shootingpos,var_09.origin);
			if(distancesquared(var_0A,var_09.origin) < level.a10damageradius * level.a10damageradius)
			{
				radiusdamage(var_0A,level.a10damageradius,level.a10damage,level.a10damage,self,"MOD_RIFLE_BULLET","a10_30mm_mp");
			}
		}

		var_0C = self gettagorigin("tag_gun");
		for(var_0D = 0;var_0D < 1;var_0D++)
		{
			magicbullet("a10_30mm_mp",var_0C,self.a10shootingpos + (randomintrange(-100,100),randomintrange(-100,100),0),self.owner);
		}

		self.a10shootingpos = self.a10shootingpos + (var_07[0],var_07[1],0);
		param_00 = param_00 - 0.05;
		wait 0.05;
	}
}

//Function Number: 15
func_3442()
{
	self endon("gone");
	self endon("death");
	self endon("stopShooting");
	for(;;)
	{
		var_00 = self gettagorigin("tag_gun");
		var_01 = self.a10shootingpos - var_00;
		var_02 = anglestoup(var_01);
		playfx(level.a10_fx["bullet_rain"],var_00,var_01,var_02);
		wait level.a10bulletraindelay;
	}
}

//Function Number: 16
func_3443()
{
	var_00 = spawn("script_origin",self gettagorigin("tag_gun"));
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 linkto(self,"tag_gun");
	var_00 playloopsound("pavelow_mg_loop");
	common_scripts\utility::waittill_any("stopShooting","gone","death");
	var_00 stoploopsound("pavelow_mg_loop");
	wait 0.5;
	var_00 delete();
}

//Function Number: 17
manageshootinggroundsound()
{
	self endon("death");
	self endon("gone");
	self endon("stopShooting");
	for(;;)
	{
		level thread common_scripts\utility::play_sound_in_space("bullet_a10warthog_default",self.a10shootingpos);
		wait level.a10shootinggroundsounddelay;
	}
}

//Function Number: 18
func_3445()
{
	self endon("death");
	self endon("gone");
	self endon("stopShooting");
	for(;;)
	{
		playrumbleonposition("grenade_rumble",self.a10shootingpos);
		earthquake(level.a10earthquakemagnitude,level.a10earthquakeduration,self.a10shootingpos,level.a10damageradius);
		foreach(var_01 in level.players)
		{
			if(var_01 maps\mp\_utility::isusingremote())
			{
				continue;
			}

			if(distance(self.a10shootingpos,var_01.origin) > level.a10dirteffectradius)
			{
				continue;
			}

			if(var_01 damageconetrace(self.a10shootingpos))
			{
				var_01 thread maps\mp\gametypes\_shellshock::dirteffect(self.a10shootingpos);
			}
		}

		wait level.a10earthquakedelay;
	}
}

//Function Number: 19
func_28F6()
{
	self endon("gone");
	self waittill("death");
	thread func_3446();
}

//Function Number: 20
func_3446()
{
	self endon("gone");
	if(!isdefined(self))
	{
		return;
	}

	wait randomfloatrange(0.5,1.5);
	func_3447();
}

//Function Number: 21
func_3447()
{
	self notify("explode");
	func_3448();
}

//Function Number: 22
func_3448()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	if(isdefined(self.fakea10))
	{
		self.fakea10 delete();
	}

	self delete();
}