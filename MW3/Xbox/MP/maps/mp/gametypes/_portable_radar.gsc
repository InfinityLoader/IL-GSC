/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_portable_radar.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 154 ms
 * Timestamp: 10/27/2023 2:25:46 AM
*******************************************************************/

//Function Number: 1
setportableradar()
{
	self setoffhandsecondaryclass("flash");
	maps\mp\_utility::_giveweapon("portable_radar_mp",0);
	self givestartammo("portable_radar_mp");
	thread monitorportableradaruse();
}

//Function Number: 2
unsetportableradar()
{
	self notify("end_monitorPortableRadarUse");
}

//Function Number: 3
deleteportableradar(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(var_02))
		{
			var_02.inplayerportableradar = undefined;
		}
	}

	param_00 notify("death");
	param_00 delete();
	self.deployedportableradar = undefined;
}

//Function Number: 4
monitorportableradaruse()
{
	self notify("end_monitorPortableRadarUse");
	self endon("end_monitorPortableRadarUse");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "portabl_radar" || var_01 == "portable_radar_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			if(isdefined(self.deployedportableradar))
			{
				deleteportableradar(self.deployedportableradar);
			}

			var_00 waittill("missile_stuck");
			var_02 = var_00.origin;
			if(isdefined(var_00))
			{
				var_00 delete();
			}

			var_03 = spawn("script_model",var_02);
			var_03.health = 100;
			var_03.team = self.team;
			var_03.owner = self;
			var_03 setcandamage(1);
			var_03 makeportableradar(self);
			var_03 portableradarsetup(self);
			var_03 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_radar_bombsquad","tag_origin",level.otherteam[self.team],self);
			var_03 thread func_291A();
			thread func_2916(var_03);
			self.deployedportableradar = var_03;
		}
	}
}

//Function Number: 5
portableradarsetup(param_00)
{
	self setmodel("weapon_radar");
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,20));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(param_00,(0,0,20));
	}

	thread portableradardamagelistener(param_00);
	thread portableradaruselistener(param_00);
	thread portableradarbeepsounds();
	thread maps\mp\_utility::notusableforjoiningplayers(param_00);
}

//Function Number: 6
func_2916(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","spawned_player");
	level thread deleteportableradar(param_00);
}

//Function Number: 7
portableradarbeepsounds()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait 2;
		self playsound("sentry_gun_beep");
	}
}

//Function Number: 8
portableradardamagelistener(param_00)
{
	self endon("death");
	self.health = 999999;
	self.maxhealth = 100;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_02))
		{
			continue;
		}

		if(isdefined(var_0A))
		{
			switch(var_0A)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
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
		if(isdefined(var_0A) && var_0A == "emp_grenade_mp")
		{
			self.damagetaken = self.maxhealth + 1;
		}

		if(isplayer(var_02))
		{
			var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("portable_radar");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			if(isdefined(param_00) && var_02 != param_00)
			{
				var_02 notify("destroyed_explosive");
			}

			self playsound("sentry_explode");
			self.deatheffect = playfx(common_scripts\utility::func_539("equipment_explode"),self.origin);
			var_02 thread deleteportableradar(self);
		}
	}
}

//Function Number: 9
portableradaruselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PATCH_PICKUP_PORTABLE_RADAR");
	maps\mp\_utility::setselfusable(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		var_01 playlocalsound("scavenger_pack_pickup");
		if(var_01 getammocount("portable_radar_mp") == 0)
		{
			var_01 setportableradar();
		}

		var_01 thread deleteportableradar(self);
	}
}

//Function Number: 10
func_291A()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 512;
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			if(level.teambased && var_02.team == self.team)
			{
				continue;
			}

			var_03 = distancesquared(self.origin,var_02.origin);
			if(distancesquared(var_02.origin,self.origin) < var_00 * var_00)
			{
				var_02.inplayerportableradar = self.owner;
				continue;
			}

			var_02.inplayerportableradar = undefined;
		}

		wait 0.05;
	}
}