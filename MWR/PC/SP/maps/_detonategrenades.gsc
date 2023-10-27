/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_detonategrenades.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 606 ms
 * Timestamp: 10/27/2023 2:47:37 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["c4_light_blink"] = loadfx("vfx/lights/light_c4_blink");
	level._effect["claymore_laser"] = loadfx("vfx/props/claymore_laser");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] thread watchgrenadeusage();
	}
}

//Function Number: 2
watchgrenadeusage()
{
	level.c4explodethisframe = 0;
	self endon("death");
	self.c4array = [];
	self.throwinggrenade = 0;
	thread watchc4();
	thread watchc4detonation();
	thread watchclaymores();
	thread begin_semtex_grenade_tracking();
	thread begin_concussion_grenade_tracking();
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		self.throwinggrenade = 1;
		if(var_00 == "c4")
		{
			beginc4tracking();
			continue;
		}

		if(var_00 == "smoke_grenade_american")
		{
			beginsmokegrenadetracking();
			continue;
		}

		begingrenadetracking();
	}
}

//Function Number: 3
beginsmokegrenadetracking()
{
	self waittill("grenade_fire",var_00,var_01);
	if(!isdefined(level.smokegrenades))
	{
		level.smokegrenades = 0;
	}

	var_00 thread smoke_grenade_death();
}

//Function Number: 4
beginflashgrenadetracking()
{
	self.throwinggrenade = 0;
	var_00 = gettime();
	self waittill("grenade_fire",var_01,var_02);
	if(isdefined(var_01))
	{
		var_03 = gettime();
		var_04 = var_03 - var_00;
		if(var_04 >= 1250)
		{
			var_01 waittill("explode",var_05);
			if(soundexists("null"))
			{
				thread common_scripts\utility::play_sound_in_space("null",var_05);
			}

			radiusdamage(var_05,96,300,200,self,"MOD_UNKNOWN","flash_grenade");
		}
	}
}

//Function Number: 5
begin_semtex_grenade_tracking()
{
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "semtex_grenade")
		{
			thread track_semtex_grenade(var_00);
			var_00 thread semtex_sticky_handle(self);
		}
	}
}

//Function Number: 6
track_semtex_grenade(param_00)
{
	self.throwinggrenade = 0;
	if(!isdefined(level.thrown_semtex_grenades))
	{
		level.thrown_semtex_grenades = 1;
	}
	else
	{
		level.thrown_semtex_grenades++;
	}

	param_00 waittill("death");
	waittillframeend;
	level.thrown_semtex_grenades--;
}

//Function Number: 7
semtex_sticky_handle(param_00)
{
	self waittill("missile_stuck",var_01);
	if(!isdefined(var_01))
	{
		return;
	}

	if(var_01.code_classname != "script_vehicle")
	{
		return;
	}

	var_01.has_semtex_on_it = 1;
	self waittill("explode");
	if(!isdefined(var_01) || !isalive(var_01))
	{
		return;
	}

	if(var_01 maps\_vehicle::is_godmode() || var_01 maps\_vehicle_code::attacker_isonmyteam(param_00))
	{
		var_01.has_semtex_on_it = undefined;
		return;
	}

	var_01 kill(var_01.origin,param_00);
}

//Function Number: 8
begin_concussion_grenade_tracking()
{
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "concussion_grenade")
		{
			thread track_concussion_grenade(var_00);
		}
	}
}

//Function Number: 9
track_concussion_grenade(param_00)
{
	self.throwinggrenade = 0;
	param_00 waittill("death");
	maps\_utility::slowmo_setlerptime_in(0.1);
	maps\_utility::slowmo_setlerptime_out(0.25);
	maps\_utility::slowmo_setspeed_norm(1);
	maps\_utility::slowmo_setspeed_slow(0.25);
	maps\_utility::slowmo_lerp_in();
	setdvar("noflash","1");
	wait(0.05);
	setdvar("noflash","0");
	wait(2);
	maps\_utility::slowmo_lerp_out();
}

//Function Number: 10
smoke_grenade_death()
{
	level.smokegrenades++;
	wait(50);
	level.smokegrenades--;
}

//Function Number: 11
begingrenadetracking()
{
	self endon("death");
	self waittill("grenade_fire",var_00,var_01);
	if(var_01 == "fraggrenade")
	{
		var_00 thread maps\_utility::grenade_earthquake();
	}
	else if(var_01 == "ninebang_grenade")
	{
		self.threw_ninebang = 1;
	}

	self.throwinggrenade = 0;
}

//Function Number: 12
beginc4tracking()
{
	self endon("death");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change");
	self.throwinggrenade = 0;
}

//Function Number: 13
watchc4()
{
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "c4")
		{
			if(!self.c4array.size)
			{
				thread watchc4altdetonate();
			}

			self.c4array[self.c4array.size] = var_00;
			var_00.owner = self;
			var_00 thread c4damage();
			thread c4death(var_00);
			var_00 thread playc4effects();
		}
	}
}

//Function Number: 14
c4death(param_00)
{
	param_00 waittill("death");
	self.c4array = maps\_utility::array_remove_nokeys(self.c4array,param_00);
}

//Function Number: 15
watchclaymores()
{
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "claymore" || var_01 == "claymore_mp")
		{
			var_00.owner = self;
			var_00 thread c4damage(1);
			var_00 thread claymoredetonation();
			var_00 thread playclaymoreeffects();
		}
	}
}

//Function Number: 16
claymoremakesentient(param_00)
{
	self endon("death");
	wait(1);
	if(isdefined(level.claymoresentientfunc))
	{
		self thread [[ level.claymoresentientfunc ]](param_00);
		return;
	}

	self makeentitysentient(param_00,1);
	self.attackeraccuracy = 2;
	self.maxvisibledist = 750;
	self.threatbias = -1000;
}

//Function Number: 17
claymoredetonation()
{
	self endon("death");
	self waittill("missile_stuck");
	var_00 = 192;
	if(isdefined(self.detonateradius))
	{
		var_00 = self.detonateradius;
	}

	var_01 = spawn("trigger_radius",self.origin + (0,0,0 - var_00),9,var_00,var_00 * 2);
	thread deleteondeath(var_01);
	if(!isdefined(level.claymores))
	{
		level.claymores = [];
	}

	level.claymores = common_scripts\utility::array_add(level.claymores,self);
	if(!maps\_utility::is_specialop() && level.claymores.size > 15)
	{
		level.claymores[0] delete();
	}

	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(isdefined(self.owner) && var_02 == self.owner)
		{
			continue;
		}

		if(isplayer(var_02))
		{
			continue;
		}

		if(var_02 damageconetrace(self.origin,self) > 0)
		{
			self playsound("claymore_activated_SP");
			wait(0.4);
			if(isdefined(self.owner))
			{
				self detonate(self.owner);
			}
			else
			{
				self detonate(undefined);
			}

			return;
		}
	}
}

//Function Number: 18
deleteondeath(param_00)
{
	self waittill("death");
	level.claymores = maps\_utility::array_remove_nokeys(level.claymores,self);
	wait(0.05);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 19
watchc4detonation()
{
	self endon("death");
	for(;;)
	{
		self waittill("detonate");
		var_00 = self getcurrentweapon();
		if(var_00 == "c4")
		{
			for(var_01 = 0;var_01 < self.c4array.size;var_01++)
			{
				if(isdefined(self.c4array[var_01]))
				{
					self.c4array[var_01] thread waitanddetonate(0.1);
				}
			}

			self.c4array = [];
		}
	}
}

//Function Number: 20
watchc4altdetonation()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("alt_detonate");
		var_00 = self getcurrentweapon();
		if(var_00 != "c4")
		{
			var_01 = [];
			for(var_02 = 0;var_02 < self.c4array.size;var_02++)
			{
				var_03 = self.c4array[var_02];
				if(isdefined(self.c4array[var_02]))
				{
					var_03 thread waitanddetonate(0.1);
				}
			}

			self.c4array = var_01;
			self notify("detonated");
		}
	}
}

//Function Number: 21
waitanddetonate(param_00)
{
	self endon("death");
	wait(param_00);
	self detonate();
}

//Function Number: 22
c4damage(param_00)
{
	self.health = 100;
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_01 = undefined;
	for(;;)
	{
		self waittill("damage",var_02,var_01);
		break;
	}

	self playsound("claymore_activated_SP");
	if(level.c4explodethisframe)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return;
	}

	level.c4explodethisframe = 1;
	if(isdefined(param_00) && param_00 && isplayer(var_01))
	{
		level.claymoreexplodethisframe_byplayer = 1;
	}

	thread resetc4explodethisframe();
	if(isplayer(var_01))
	{
		self detonate(var_01);
		return;
	}

	self detonate();
}

//Function Number: 23
resetc4explodethisframe()
{
	wait(0.05);
	level.c4explodethisframe = 0;
	level.claymoreexplodethisframe_byplayer = 0;
}

//Function Number: 24
saydamaged(param_00,param_01)
{
	for(var_02 = 0;var_02 < 60;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 25
playc4effects()
{
	self endon("death");
	self waittill("missile_stuck");
	playfxontag(common_scripts\utility::getfx("c4_light_blink"),self,"tag_fx");
}

//Function Number: 26
playclaymoreeffects()
{
	self endon("death");
	self waittill("missile_stuck");
	playfxontag(common_scripts\utility::getfx("claymore_laser"),self,"tag_fx");
}

//Function Number: 27
clearfxondeath(param_00)
{
	self waittill("death");
	param_00 delete();
}

//Function Number: 28
getdamageableents(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	for(var_05 = 0;var_05 < level.players.size;var_05++)
	{
		if(!isalive(level.players[var_05]) || level.players[var_05].sessionstate != "playing")
		{
			continue;
		}

		var_06 = level.players[var_05].origin + (0,0,32);
		var_07 = distance(param_00,var_06);
		if(var_07 < param_01 && !param_02 || weapondamagetracepassed(param_00,var_06,param_03,undefined))
		{
			var_08 = spawnstruct();
			var_08.isplayer = 1;
			var_08.isadestructable = 0;
			var_08.entity = level.players[var_05];
			var_08.damagecenter = var_06;
			var_04[var_04.size] = var_08;
		}
	}

	var_09 = getentarray("grenade","classname");
	for(var_05 = 0;var_05 < var_09.size;var_05++)
	{
		var_0A = var_09[var_05].origin;
		var_07 = distance(param_00,var_0A);
		if(var_07 < param_01 && !param_02 || weapondamagetracepassed(param_00,var_0A,param_03,var_09[var_05]))
		{
			var_08 = spawnstruct();
			var_08.isplayer = 0;
			var_08.isadestructable = 0;
			var_08.entity = var_09[var_05];
			var_08.damagecenter = var_0A;
			var_04[var_04.size] = var_08;
		}
	}

	var_0B = getentarray("destructable","targetname");
	for(var_05 = 0;var_05 < var_0B.size;var_05++)
	{
		var_0A = var_0B[var_05].origin;
		var_07 = distance(param_00,var_0A);
		if(var_07 < param_01 && !param_02 || weapondamagetracepassed(param_00,var_0A,param_03,var_0B[var_05]))
		{
			var_08 = spawnstruct();
			var_08.isplayer = 0;
			var_08.isadestructable = 1;
			var_08.entity = var_0B[var_05];
			var_08.damagecenter = var_0A;
			var_04[var_04.size] = var_08;
		}
	}

	return var_04;
}

//Function Number: 29
weapondamagetracepassed(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = param_01 - param_00;
	if(lengthsquared(var_05) < param_02 * param_02)
	{
		var_04 = param_01;
	}

	var_06 = vectornormalize(var_05);
	var_04 = param_00 + (var_06[0] * param_02,var_06[1] * param_02,var_06[2] * param_02);
	var_07 = bullettrace(var_04,param_01,0,param_03);
	if(getdvarint("scr_damage_debug") != 0)
	{
		if(var_07["fraction"] == 1)
		{
			thread debugline(var_04,param_01,(1,1,1));
		}
		else
		{
			thread debugline(var_04,var_07["position"],(1,0.9,0.8));
			thread debugline(var_07["position"],param_01,(1,0.4,0.3));
		}
	}

	return var_07["fraction"] == 1;
}

//Function Number: 30
damageent(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self.isplayer)
	{
		self.damageorigin = param_05;
		self.entity thread [[ level.callbackplayerdamage ]](param_00,param_01,param_02,0,param_03,param_04,param_05,param_06,"none",0);
		return;
	}

	if(self.isadestructable && param_04 == "artillery_mp" || param_04 == "claymore_mp")
	{
		return;
	}

	self.entity notify("damage",param_02,param_01);
}

//Function Number: 31
debugline(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < 600;var_03++)
	{
		wait(0.05);
	}
}

//Function Number: 32
onweapondamage(param_00,param_01,param_02,param_03)
{
	self endon("death");
	switch(param_01)
	{
		case "concussion_grenade_mp":
			break;

		default:
			break;
	}
}

//Function Number: 33
watchc4altdetonate()
{
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.5)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			if(!self.c4array.size)
			{
				return;
			}

			self notify("alt_detonate");
		}

		wait(0.05);
	}
}