/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_scrambler.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 137 ms
 * Timestamp: 10/27/2023 2:12:53 AM
*******************************************************************/

//Function Number: 1
setscrambler()
{
	self setoffhandsecondaryclass("flash");
	maps\mp\_utility::_giveweapon("scrambler_mp",0);
	self givestartammo("scrambler_mp");
	thread monitorscrambleruse();
}

//Function Number: 2
unsetscrambler()
{
	self notify("end_monitorScramblerUse");
}

//Function Number: 3
deletescrambler(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(var_02))
		{
			var_02.inplayerscrambler = undefined;
		}
	}

	param_00 notify("death");
	param_00 delete();
	self.deployedscrambler = undefined;
	var_04 = [];
	var_04 = maps\mp\_utility::cleanarray(level.scramblers);
	level.scramblers = var_04;
}

//Function Number: 4
monitorscrambleruse()
{
	self notify("end_monitorScramblerUse");
	self endon("end_monitorScramblerUse");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "scrambler" || var_01 == "scrambler_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			var_00 hide();
			var_00 waittill("missile_stuck");
			var_02 = 40;
			if(var_02 * var_02 < distancesquared(var_00.origin,self.origin))
			{
				var_03 = bullettrace(self.origin,self.origin - (0,0,var_02),0,self);
				if(var_03["fraction"] == 1)
				{
					var_00 delete();
					self setweaponammostock("scrambler_mp",self getweaponammostock("trophy_mp") + 1);
					continue;
				}

				var_00.origin = var_03["position"];
			}

			var_00 show();
			if(isdefined(self.deployedscrambler))
			{
				deletescrambler(self.deployedscrambler);
			}

			var_04 = var_00.origin;
			var_05 = spawn("script_model",var_04);
			var_05.health = 100;
			var_05.team = self.team;
			var_05.owner = self;
			var_05 setcandamage(1);
			var_05 makescrambler(self);
			var_05 scramblersetup(self);
			var_05 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_jammer_bombsquad","tag_origin",level.otherteam[self.team],self);
			level.scramblers[level.scramblers.size] = var_05;
			self.deployedscrambler = var_05;
			self.changingweapon = undefined;
			wait 0.05;
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
	}
}

//Function Number: 5
scramblersetup(param_00)
{
	self setmodel("weapon_jammer");
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,20));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(param_00,(0,0,20));
	}

	thread scramblerdamagelistener(param_00);
	thread scrambleruselistener(param_00);
	param_00 thread scramblerwatchowner(self);
	thread scramblerbeepsounds();
	thread maps\mp\_utility::notusableforjoiningplayers(param_00);
}

//Function Number: 6
scramblerwatchowner(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","death");
	level thread deletescrambler(param_00);
}

//Function Number: 7
scramblerbeepsounds()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait 3;
		self playsound("scrambler_beep");
	}
}

//Function Number: 8
scramblerdamagelistener(param_00)
{
	self endon("death");
	self.health = 999999;
	self.maxhealth = 100;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_02))
		{
			continue;
		}

		if(isdefined(var_0A))
		{
			switch(var_0A)
			{
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
				case "concussion_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(var_05 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		if(isdefined(var_09) && var_09 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		self.damagetaken = self.damagetaken + var_01;
		if(isplayer(var_02))
		{
			var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("scrambler");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			if(isdefined(param_00) && var_02 != param_00)
			{
				var_02 notify("destroyed_explosive");
			}

			self playsound("sentry_explode");
			self.deatheffect = playfx(common_scripts\utility::getfx("equipment_explode"),self.origin);
			var_02 thread deletescrambler(self);
		}
	}
}

//Function Number: 9
scrambleruselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PATCH_PICKUP_SCRAMBLER");
	maps\mp\_utility::setselfusable(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		var_01 playlocalsound("scavenger_pack_pickup");
		if(var_01 getammocount("scrambler_mp") == 0)
		{
			var_01 setscrambler();
		}

		var_01 thread deletescrambler(self);
	}
}

//Function Number: 10
scramblerproximitytracker()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	level endon("game_ended");
	self.scramproxyactive = 0;
	var_00 = 512;
	for(;;)
	{
		wait 0.05;
		self.scramproxyactive = 0;
		foreach(var_02 in level.scramblers)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(self))
			{
				continue;
			}

			var_03 = distancesquared(var_02.origin,self.origin);
			if((level.teambased && var_02.team != self.team) || !level.teambased && isdefined(var_02.owner) && var_02.owner != self)
			{
				if(var_03 < var_00 * var_00)
				{
					self.inplayerscrambler = var_02.owner;
				}
				else
				{
					self.inplayerscrambler = undefined;
				}

				continue;
			}

			if(var_03 < var_00 * var_00)
			{
				self.scramproxyactive = 1;
				break;
			}
		}

		if(self.scramproxyactive)
		{
			if(!maps\mp\_utility::_hasperk("specialty_blindeye"))
			{
				maps\mp\_utility::giveperk("specialty_blindeye",0);
				self.scramproxyperk = 1;
			}

			continue;
		}

		if(isdefined(self.scramproxyperk) && self.scramproxyperk)
		{
			if(!maps\mp\killstreaks\_perkstreaks::isperkstreakon("specialty_blindeye_ks"))
			{
				maps\mp\_utility::_unsetperk("specialty_blindeye");
			}

			self.scramproxyperk = 0;
		}
	}
}