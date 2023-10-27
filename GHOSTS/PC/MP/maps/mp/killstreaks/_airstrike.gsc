/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airstrike.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 720 ms
 * Timestamp: 10/27/2023 1:20:24 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precachelocationselector("map_artillery_selector");
	level.airstrikefx = loadfx("fx/explosions/clusterbomb");
	level.airstrikessfx = loadfx("fx/explosions/clusterbomb_no_fount");
	level.airstrikeexplosion = loadfx("fx/explosions/clusterbomb_exp_direct_runner_cheap");
	level.mortareffect = loadfx("fx/explosions/clusterbomb_exp_direct_runner_stealth");
	level.bombstrike = loadfx("fx/explosions/wall_explosion_pm_a");
	level.airburstbomb = loadfx("fx/explosions/airburst");
	level.harriers = [];
	level.fx_airstrike_afterburner = loadfx("fx/fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx("fx/smoke/jet_contrail");
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
	level.killstreakfuncs["airstrike"] = ::func_8428;
	level.killstreakfuncs["precision_airstrike"] = ::func_8428;
	level.killstreakfuncs["super_airstrike"] = ::func_8428;
	level.killstreakfuncs["harrier_airstrike"] = ::func_8428;
	level.killstreakfuncs["stealth_airstrike"] = ::func_8428;
	level.planes = [];
}

//Function Number: 2
func_8428(param_00,param_01)
{
	switch(param_01)
	{
		case "precision_airstrike":
			break;

		case "stealth_airstrike":
			break;

		case "harrier_airstrike":
			if(isdefined(level.harrier_incoming) || level.harriers.size >= 1)
			{
				self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
				return 0;
			}
			break;

		case "super_airstrike":
			break;
	}

	var_02 = func_6D6F(param_00,param_01);
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_2858(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_05 == "harrier_airstrike")
	{
		level.harrier_incoming = 1;
	}

	if(isdefined(level.airstrikeinprogress))
	{
		while(isdefined(level.airstrikeinprogress))
		{
			level waittill("begin_airstrike");
		}

		level.airstrikeinprogress = 1;
		wait(2);
	}

	if(!isdefined(param_03))
	{
		if(param_05 == "harrier_airstrike")
		{
			level.harrier_incoming = undefined;
		}
	}

	level.airstrikeinprogress = 1;
	var_06 = bullettrace(param_01,param_01 + (0,0,-1000000),0,undefined);
	var_07 = var_06["position"];
	var_08 = spawnstruct();
	var_08.origin = var_07;
	var_08.forward = anglestoforward((0,param_02,0));
	var_08.streakname = param_05;
	var_08.team = param_04;
	level.artillerydangercenters[level.artillerydangercenters.size] = var_08;
	callstrike(param_00,param_03,var_07,param_02,param_05);
	if(param_05 == "harrier_airstrike")
	{
		level.harrier_incoming = undefined;
	}

	wait(1);
	level.airstrikeinprogress = undefined;
	param_03 notify("begin_airstrike");
	level notify("begin_airstrike");
	wait(7.5);
	var_09 = 0;
	var_0A = [];
	for(var_0B = 0;var_0B < level.artillerydangercenters.size;var_0B++)
	{
		if(!var_09 && level.artillerydangercenters[var_0B].origin == var_07)
		{
			var_09 = 1;
			continue;
		}

		var_0A[var_0A.size] = level.artillerydangercenters[var_0B];
	}

	level.artillerydangercenters = var_0A;
}

//Function Number: 4
clearprogress(param_00)
{
	wait(2);
	level.airstrikeinprogress = undefined;
}

//Function Number: 5
getairstrikedanger(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.artillerydangercenters.size;var_02++)
	{
		var_03 = level.artillerydangercenters[var_02].origin;
		var_04 = level.artillerydangercenters[var_02].forward;
		var_05 = level.artillerydangercenters[var_02].streakname;
		var_01 = var_01 + func_3BE7(param_00,var_03,var_04,var_05);
	}

	return var_01;
}

//Function Number: 6
func_3BE7(param_00,param_01,param_02,param_03)
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

//Function Number: 7
func_608C(param_00,param_01,param_02,param_03)
{
	return distance2d(param_00,param_01) <= level.dangermaxradius[param_03] * 1.25;
}

//Function Number: 8
func_4F96(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\mp\gametypes\_weapons::func_3A70(param_00,param_01,1);
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

//Function Number: 9
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
			var_01 maps\mp\gametypes\_weapons::func_2306(var_01.einflictor,var_01.damageowner,var_01.damage,"MOD_PROJECTILE_SPLASH",param_00,var_01.pos,vectornormalize(var_01.damagecenter - var_01.pos));
			level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
			if(var_01.isplayer)
			{
				wait(0.05);
			}

			continue;
		}

		level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
		level.airstrikedamagedentsindex++;
	}
}

//Function Number: 10
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

//Function Number: 11
artilleryshellshock(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked)
	{
	}

	self.beingartilleryshellshocked = 1;
	self shellshock(param_00,param_01);
	wait(param_01 + 1);
	self.beingartilleryshellshocked = 0;
}

//Function Number: 12
dobomberstrike(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
	}

	var_0A = 100;
	var_0B = 150;
	var_0C = param_04 + (randomfloat(2) - 1 * var_0A,randomfloat(2) - 1 * var_0A,4000);
	var_0D = param_05 + (randomfloat(2) - 1 * var_0B,randomfloat(2) - 1 * var_0B,4000);
	var_0E = spawnplane(param_01,"script_model",var_0C,"compass_objpoint_b2_airstrike_friendly","compass_objpoint_b2_airstrike_enemy");
	addplanetolist(var_0E);
	var_0E thread func_3F75();
	var_0E playloopsound("veh_b2_dist_loop");
	var_0E setmodel("vehicle_b2_bomber");
	var_0E thread handleemp(param_01);
	var_0E.lifeid = param_00;
	var_0E.angles = param_08;
	var_0F = anglestoforward(param_08);
	var_0E moveto(var_0D,param_07,0,0);
	thread func_7BE2(var_0E,var_0D,param_07,param_09);
	thread func_1553(var_0E,param_03,param_01);
	var_0E endon("death");
	wait(param_07 * 0.65);
	removeplanefromlist(var_0E);
	var_0E notify("delete");
	var_0E delete();
}

//Function Number: 13
func_1553(param_00,param_01,param_02)
{
	param_00 endon("death");
	while(!func_7F65(param_00,param_01,5000))
	{
		wait(0.05);
	}

	var_03 = 1;
	var_04 = 0;
	param_00 notify("start_bombing");
	var_05 = 0;
	for(var_06 = func_7F5F(param_00,param_01);var_06 < 5000;var_06 = func_7F5F(param_00,param_01))
	{
		if(var_06 < 1500 && !var_04)
		{
			param_00 playsoundonmovingent("veh_b2_sonic_boom");
			var_04 = 1;
		}

		if(var_06 < 3000 && var_05 < 4)
		{
			param_00 thread dropparachutebomb(param_00,param_02);
			var_05++;
			wait(randomfloatrange(0.15,0.3));
		}

		wait(0.1);
	}

	param_00 notify("stop_bombing");
}

//Function Number: 14
dropparachutebomb(param_00,param_01)
{
	self endon("stop_bombing");
	self endon("death");
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel("parachute_cargo_static");
	var_02.team = param_01.team;
	var_02.owner = param_01;
	var_02 setcandamage(1);
	var_03 = bullettrace(var_02.origin,var_02.origin - (0,0,20000),0,var_02,0,0);
	var_04 = var_03["position"];
	var_02 moveto(var_04,randomintrange(8,14));
	var_02 thread func_1550(param_00,var_04);
	var_02 thread bombwatcher(param_00,var_04);
}

//Function Number: 15
func_1550(param_00,param_01)
{
	var_02 = self;
	self endon("death");
	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = 200;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
		if(!maps\mp\gametypes\_weapons::func_357F(self.owner,var_04))
		{
			continue;
		}

		if(!isdefined(self))
		{
		}

		self.wasdamaged = 1;
		self.damagetaken = self.damagetaken + var_03;
		if(isplayer(var_04))
		{
			var_04 maps\mp\gametypes\_damagefeedback::func_86E0("tactical_insertion");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			radiusdamage(var_02.origin,1024,600,65,var_02.owner,"MOD_EXPLOSIVE","stealth_bomb_mp");
			playfx(level.airburstbomb,var_02.origin,anglestoforward(var_02.angles),var_02.origin - param_01);
			if(isdefined(var_02))
			{
				var_02 delete();
			}

			self notify("death");
		}
	}
}

//Function Number: 16
bombwatcher(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	while(var_02.origin[2] > param_01[2] + 600)
	{
		wait(0.1);
	}

	radiusdamage(param_01 + (0,0,64),1024,600,65,param_00.owner,"MOD_EXPLOSIVE","stealth_bomb_mp");
	playfx(level.airburstbomb,var_02.origin,anglestoforward(var_02.angles),var_02.origin - param_01);
	var_02 delete();
}

//Function Number: 17
func_5D51()
{
	self endon("stop_bombing");
	self endon("death");
	for(;;)
	{
		playfxontag(level.stealthbombfx,self,"tag_left_alamo_missile");
		playfxontag(level.stealthbombfx,self,"tag_right_alamo_missile");
		wait(0.5);
	}
}

//Function Number: 18
func_7BE2(param_00,param_01,param_02,param_03)
{
	param_00 waittill("start_bombing");
	var_04 = anglestoforward(param_00.angles);
	var_05 = spawn("script_model",param_00.origin + (0,0,100) - var_04 * 200);
	param_00.killcament = var_05;
	param_00.killcament setscriptmoverkillcam("airstrike");
	param_00.airstriketype = param_03;
	var_05.starttime = gettime();
	var_05 thread func_2583(15);
	var_05 linkto(param_00,"tag_origin",(-256,768,768),(0,0,0));
}

//Function Number: 19
func_1964(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01) || param_01 maps\mp\_utility::func_48F6())
	{
		self notify("stop_bombing");
	}

	var_04 = 512;
	var_05 = (0,randomint(360),0);
	var_06 = param_00 + anglestoforward(var_05) * randomfloat(var_04);
	var_07 = bullettrace(var_06,var_06 + (0,0,-10000),0,undefined);
	var_06 = var_07["position"];
	var_08 = distance(param_00,var_06);
	if(var_08 > 5000)
	{
	}

	wait(0.85 * var_08 / 2000);
	if(!isdefined(param_01) || param_01 maps\mp\_utility::func_48F6())
	{
		self notify("stop_bombing");
	}

	if(param_03)
	{
		playfx(level.mortareffect,var_06);
		level thread maps\mp\gametypes\_shellshock::func_7BE1(var_06);
	}

	thread maps\mp\_utility::func_6044("exp_airstrike_bomb",var_06);
	radiusartilleryshellshock(var_06,512,8,4,param_01.team);
	func_4F96(var_06 + (0,0,16),896,300,50,param_01,self,"stealth_bomb_mp");
}

//Function Number: 20
handleharrierairstrikeobjectiveicons()
{
	self endon("death");
	self.owner endon("disconnect");
	wait(2);
	maps\mp\killstreaks\_plane::func_7082("hud_minimap_harrier_green","hud_minimap_harrier_red");
	thread cleanupharrierairstrikeobjectiveicons();
}

//Function Number: 21
cleanupharrierairstrikeobjectiveicons()
{
	var_00 = self.friendlyteamid;
	var_01 = self.enemyteamid;
	common_scripts\utility::func_8B35(3.5,"death");
	if(isdefined(var_00))
	{
		maps\mp\_utility::_objective_delete(var_00);
		maps\mp\_utility::_objective_delete(var_01);
	}
}

//Function Number: 22
func_2A06(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
	}

	var_0A = 100;
	var_0B = 150;
	var_0C = param_04 + (randomfloat(2) - 1 * var_0A,randomfloat(2) - 1 * var_0A,0);
	var_0D = param_05 + (randomfloat(2) - 1 * var_0B,randomfloat(2) - 1 * var_0B,0);
	var_0E = spawn("script_model",var_0C);
	var_0E.owner = param_01;
	var_0E.origin = var_0C;
	var_0E.angles = param_08;
	var_0E.team = param_01.team;
	var_0E thread func_3F75();
	if(param_09 == "harrier_airstrike")
	{
		var_0E setmodel("vehicle_av8b_harrier_jet_mp");
		var_0E playloopsound("harrier_fly_in");
	}
	else
	{
		var_0E setmodel("vehicle_a10_warthog_iw6_mp");
		var_0E playloopsound("veh_mig29_dist_loop");
	}

	var_0E thread handleemp(param_01);
	var_0E.lifeid = param_00;
	var_0E.angles = param_08;
	var_0F = anglestoforward(param_08);
	var_0E thread func_6034();
	var_0E moveto(var_0D,param_07,0,0);
	if(param_09 == "harrier_airstrike")
	{
		var_0E thread handleharrierairstrikeobjectiveicons();
	}

	thread callstrike_bombeffect(var_0E,var_0D,param_07,param_06 - 1,param_01,param_02,param_09);
	wait(param_06 - 0.75);
	var_0E scriptmodelplayanimdeltamotion("airstrike_mp_roll");
	var_0E endon("death");
	wait(param_07 - param_06);
	removeplanefromlist(var_0E);
	var_0E notify("delete");
	var_0E delete();
}

//Function Number: 23
func_3F75()
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
	wait(param_03);
	if(!isdefined(param_04) || param_04 maps\mp\_utility::func_48F6())
	{
	}

	if(param_06 == "harrier_airstrike")
	{
		param_00 playsoundonmovingent("harrier_sonic_boom");
	}
	else
	{
		param_00 playsoundonmovingent("veh_mig29_sonic_boom");
	}

	var_07 = anglestoforward(param_00.angles);
	var_08 = func_7863(param_00.origin,param_00.angles);
	var_08 movegravity(anglestoforward(param_00.angles) * 4666.667,3);
	var_08.lifeid = param_05;
	var_09 = spawn("script_model",param_00.origin + (0,0,100) - var_07 * 200);
	var_08.killcament = var_09;
	var_08.killcament setscriptmoverkillcam("airstrike");
	var_08.airstriketype = param_06;
	var_09.starttime = gettime();
	var_09 thread func_2583(15);
	var_09.angles = var_07;
	var_09 moveto(param_01 + (0,0,100),param_02,0,0);
	wait(0.4);
	var_09 moveto(var_09.origin + var_07 * 4000,1,0,0);
	wait(0.45);
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.2) * 3500,2,0,0);
	wait(0.15);
	var_0A = spawn("script_model",var_08.origin);
	var_0A setmodel("tag_origin");
	var_0A.origin = var_08.origin;
	var_0A.angles = var_08.angles;
	var_08 setmodel("tag_origin");
	wait(0.1);
	var_0B = var_0A.origin;
	var_0C = var_0A.angles;
	if(level.splitscreen)
	{
		playfxontag(level.airstrikessfx,var_0A,"tag_origin");
	}
	else
	{
		playfxontag(level.airstrikefx,var_0A,"tag_origin");
	}

	wait(0.05);
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.25) * 2500,2,0,0);
	wait(0.25);
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.35) * 2000,2,0,0);
	wait(0.2);
	var_09 moveto(var_09.origin + var_07 + (0,0,-0.45) * 1500,2,0,0);
	wait(0.5);
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
		playfx(level.airstrikeexplosion,var_16);
		thread func_4F96(var_16 + (0,0,16),512,200,30,param_04,var_08,"artillery_mp");
		if(var_12 % 3 == 0)
		{
			thread maps\mp\_utility::func_6044("exp_airstrike_bomb",var_16);
			level thread maps\mp\gametypes\_shellshock::airstrike_earthquake(var_16);
		}

		wait(0.05);
	}

	var_11 = var_11 / var_0D + (0,0,128);
	var_09 moveto(var_08.killcament.origin * 0.35 + var_11 * 0.65,1.5,0,0.5);
	wait(5);
	var_0A delete();
	var_08 delete();
}

//Function Number: 27
func_7863(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = param_01;
	var_02 setmodel("projectile_cbu97_clusterbomb");
	return var_02;
}

//Function Number: 28
func_2583(param_00)
{
	self endon("death");
	wait(10);
	self delete();
}

//Function Number: 29
func_6034()
{
	self endon("death");
	wait(0.5);
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_right");
	wait(0.5);
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_left");
	wait(0.5);
	playfxontag(level.fx_airstrike_contrail,self,"tag_right_wingtip");
	wait(0.5);
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
		thread maps\mp\_utility::func_7FA0("used_stealth_airstrike",param_01,param_01.team);
		var_08 = 12000;
		var_09 = 4000;
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
		if(var_07 == "harrier_airstrike")
		{
			thread maps\mp\_utility::func_7FA0("used_harrier",param_04);
		}

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

	param_01 endon("disconnect");
	var_0B = param_00;
	level.airstrikedamagedents = [];
	level.airstrikedamagedentscount = 0;
	level.airstrikedamagedentsindex = 0;
	if(param_04 == "harrier_airstrike")
	{
		var_0C = func_3AAE(param_02,var_07,var_08,var_05,var_0A,var_09,var_06,param_04);
		level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(500)),var_0C["endPoint"] + (0,0,randomint(500)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
		wait(randomfloatrange(1.5,2.5));
		maps\mp\gametypes\_hostmigration::func_8BBA();
		level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(200)),var_0C["endPoint"] + (0,0,randomint(200)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
		wait(randomfloatrange(1.5,2.5));
		maps\mp\gametypes\_hostmigration::func_8BBA();
		level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(200)),var_0C["endPoint"] + (0,0,randomint(200)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
		wait(randomfloatrange(1.5,2.5));
		maps\mp\gametypes\_hostmigration::func_8BBA();
		var_0D = maps\mp\killstreaks\_harrier::beginharrier(param_00,var_0C["startPoint"],param_02);
		param_01 thread maps\mp\killstreaks\_harrier::defendlocation(var_0D);
	}

	if(var_05 == "stealth_airstrike")
	{
		var_0C = func_3AAE(param_03,var_08,var_09,var_06,var_0B,var_0A,var_07,var_05);
		level thread dobomberstrike(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(1000)),var_0C["endPoint"] + (0,0,randomint(1000)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
	}

	var_0C = func_3AAE(param_03,var_08,var_09,var_06,var_0B,var_0A,var_07,var_05);
	level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(500)),var_0C["endPoint"] + (0,0,randomint(500)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
	wait(randomfloatrange(1.5,2.5));
	maps\mp\gametypes\_hostmigration::func_8BBA();
	level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(200)),var_0C["endPoint"] + (0,0,randomint(200)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
	wait(randomfloatrange(1.5,2.5));
	maps\mp\gametypes\_hostmigration::func_8BBA();
	level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(200)),var_0C["endPoint"] + (0,0,randomint(200)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
	if(param_04 == "super_airstrike")
	{
		wait(randomfloatrange(2.5,3.5));
		maps\mp\gametypes\_hostmigration::func_8BBA();
		level thread func_2A06(param_00,param_01,var_0B,param_02,var_0C["startPoint"] + (0,0,randomint(200)),var_0C["endPoint"] + (0,0,randomint(200)),var_0C["bombTime"],var_0C["flyTime"],var_07,param_04);
	}
}

//Function Number: 31
func_3AAE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = param_00 + anglestoforward(param_01) * -1 * param_02;
	if(isdefined(param_03))
	{
		var_08 = var_08 * (1,1,0);
	}

	var_08 = var_08 + (0,0,param_04);
	if(param_07 == "stealth_airstrike")
	{
		var_09 = param_00 + anglestoforward(param_01) * param_02 * 4;
	}
	else
	{
		var_09 = param_01 + anglestoforward(param_02) * param_03;
	}

	if(isdefined(param_03))
	{
		var_09 = var_09 * (1,1,0);
	}

	var_09 = var_09 + (0,0,param_04);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / param_05;
	var_0A = abs(var_0A / 2 + param_06);
	var_0C = var_0A / param_05;
	var_0D["startPoint"] = var_08;
	var_0D["endPoint"] = var_09;
	var_0D["bombTime"] = var_0C;
	var_0D["flyTime"] = var_0B;
	return var_0D;
}

//Function Number: 32
getexplodedistance(param_00)
{
	var_01 = 850;
	var_02 = 1500;
	var_03 = var_01 / param_00;
	var_04 = var_03 * var_02;
	return var_04;
}

//Function Number: 33
func_7F5F(param_00,param_01)
{
	var_02 = func_7F66(param_00,param_01);
	if(var_02)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = -1;
	}

	var_04 = common_scripts\utility::func_3417(param_00.origin);
	var_05 = var_04 + anglestoforward(common_scripts\utility::func_3415(param_00.angles)) * var_03 * 100000;
	var_06 = pointonsegmentnearesttopoint(var_04,var_05,param_01);
	var_07 = distance(var_04,var_06);
	return var_07;
}

//Function Number: 34
func_7F65(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 3000;
	}

	var_03 = func_7F66(param_00,param_01);
	if(var_03)
	{
		var_04 = 1;
	}
	else
	{
		var_04 = -1;
	}

	var_05 = common_scripts\utility::func_3417(param_00.origin);
	var_06 = var_05 + anglestoforward(common_scripts\utility::func_3415(param_00.angles)) * var_04 * 100000;
	var_07 = pointonsegmentnearesttopoint(var_05,var_06,param_01);
	var_08 = distance(var_05,var_07);
	if(var_08 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_7F66(param_00,param_01)
{
	var_02 = anglestoforward(common_scripts\utility::func_3415(param_00.angles));
	var_03 = vectornormalize(common_scripts\utility::func_3417(param_01) - param_00.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_8AD5()
{
	self waittill("cancel_location");
	self setblurforplayer(0,0.3);
}

//Function Number: 37
func_6D6F(param_00,param_01)
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

	if(param_01 != "harrier_airstrike")
	{
		maps\mp\_utility::_beginlocationselection(param_01,"map_artillery_selector",var_03,var_02);
		self endon("stop_location_selection");
		self waittill("confirm_location",var_04,var_05);
	}
	else
	{
		var_06 = [];
		foreach(var_08 in level.players)
		{
			if(!isdefined(var_08))
			{
				continue;
			}

			if(!isdefined(var_08.team))
			{
				continue;
			}

			if(var_08.team == self.team)
			{
				continue;
			}

			var_06[var_06.size] = var_08.origin;
		}

		if(var_06.size)
		{
			var_0A = averagepoint(var_06);
		}
		else
		{
			var_0A = (0,0,0);
		}

		var_04 = var_0A;
		var_05 = randomint(360);
	}

	if(!var_03)
	{
		var_05 = randomint(360);
	}

	self setblurforplayer(0,0.3);
	if(param_01 == "harrier_airstrike" && isdefined(level.harrier_incoming) || level.harriers.size > 1)
	{
		self notify("cancel_location");
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	thread airstrikemadeselectionvo(param_01);
	maps\mp\_matchdata::func_4F1D(param_01,var_04);
	thread func_3296(param_00,var_04,var_05,param_01);
	return 1;
}

//Function Number: 38
func_3296(param_00,param_01,param_02,param_03)
{
	self notify("used");
	var_04 = bullettrace(level.mapcenter + (0,0,1000000),level.mapcenter,0,undefined);
	param_01 = (param_01[0],param_01[1],var_04["position"][2] - 514);
	thread func_2858(param_00,param_01,param_02,self,self.pers["team"],param_03);
}

//Function Number: 39
func_87A4(param_00,param_01,param_02)
{
}

//Function Number: 40
handleemp(param_00)
{
	self endon("death");
	if(param_00 maps\mp\_utility::func_48B2())
	{
		self notify("death");
	}

	for(;;)
	{
		level waittill("emp_update");
		if(!param_00 maps\mp\_utility::func_48B2())
		{
			continue;
		}

		self notify("death");
	}
}

//Function Number: 41
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