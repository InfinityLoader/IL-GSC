/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_portable_radar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 128 ms
 * Timestamp: 4/22/2024 2:10:12 AM
*******************************************************************/

//Function Number: 1
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
}

//Function Number: 2
monitorportableradaruse()
{
	self endon("disconnect");
	level endon("game_ended");
	self.portableradararray = [];
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "portabl_radar" || var_01 == "portable_radar_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				continue;
			}

			self.portableradararray = common_scripts\utility::array_removeundefined(self.portableradararray);
			if(self.portableradararray.size >= level.maxperplayerexplosives)
			{
				deleteportableradar(self.portableradararray[0]);
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
			var_03 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_radar_bombsquad","tag_origin",self);
			var_03 thread portableradarproximitytracker();
			thread portableradarwatchowner(var_03);
			self.portableradararray[self.portableradararray.size] = var_03;
		}
	}
}

//Function Number: 3
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

//Function Number: 4
portableradarwatchowner(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","spawned_player");
	level thread deleteportableradar(param_00);
}

//Function Number: 5
portableradarbeepsounds()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(2);
		self playsound("sentry_gun_beep");
	}
}

//Function Number: 6
portableradardamagelistener(param_00)
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
			var_0B = maps\mp\_utility::strip_suffix(var_0A,"_lefthand");
		}
		else
		{
			var_0B = undefined;
		}

		if(isdefined(var_0B))
		{
			switch(var_0B)
			{
				case "smoke_grenade_var_mp":
				case "stun_grenade_var_mp":
				case "smoke_grenade_mp":
				case "stun_grenade_mp":
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(maps\mp\_utility::ismeleemod(var_05))
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		if(isdefined(var_09) && var_09 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		self.damagetaken = self.damagetaken + var_01;
		if(isdefined(var_0B) && var_0B == "emp_grenade_mp" || var_0B == "emp_grenade_var_mp" || var_0B == "emp_grenade_killstreak_mp")
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
			self.deatheffect = playfx(common_scripts\utility::getfx("equipment_explode"),self.origin);
			self freeentitysentient();
			var_02 thread deleteportableradar(self);
		}
	}
}

//Function Number: 7
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
		self waittill("trigger",param_00);
		var_01 = param_00 setweaponammostock("portable_radar_mp");
		if(var_01 < weaponmaxammo("portable_radar_mp"))
		{
			param_00 playlocalsound("scavenger_pack_pickup");
			param_00 setweaponammostock("portable_radar_mp",var_01 + 1);
			param_00 thread deleteportableradar(self);
		}
	}
}

//Function Number: 8
portableradarproximitytracker()
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

			if(var_02 maps\mp\_utility::_hasperk("specialty_class_lowprofile"))
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

		wait(0.05);
	}
}