/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_equipment.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 125 ms
 * Timestamp: 10/27/2023 2:12:20 AM
*******************************************************************/

//Function Number: 1
watchtrophyusage()
{
	self endon("spawned_player");
	self endon("disconnect");
	self.trophyarray = [];
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "trophy" || var_01 == "trophy_mp")
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
					self setweaponammostock("trophy_mp",self getweaponammostock("trophy_mp") + 1);
					continue;
				}

				var_00.origin = var_03["position"];
			}

			var_00 show();
			self.trophyarray = common_scripts\utility::array_removeundefined(self.trophyarray);
			if(self.trophyarray.size >= level.maxperplayerexplosives)
			{
				self.trophyarray[0] detonate();
			}

			var_04 = spawn("script_model",var_00.origin);
			var_04 setmodel("mp_trophy_system");
			var_04 thread maps\mp\gametypes\_weapons::createbombsquadmodel("mp_trophy_system_bombsquad","tag_origin",level.otherteam[self.team],self);
			var_04.angles = var_00.angles;
			self.trophyarray[self.trophyarray.size] = var_04;
			var_04.owner = self;
			var_04.team = self.team;
			var_04.weaponname = var_01;
			if(isdefined(self.trophyremainingammo) && self.trophyremainingammo > 0)
			{
				var_04.ammo = self.trophyremainingammo;
			}
			else
			{
				var_04.ammo = 2;
			}

			var_04.trigger = spawn("script_origin",var_04.origin);
			var_04 thread trophydamage(self);
			var_04 thread trophyactive(self);
			var_04 thread trophydisconnectwaiter(self);
			var_04 thread trophyplayerspawnwaiter(self);
			var_04 thread trophyuselistener(self);
			var_04 thread maps\mp\gametypes\_weapons::c4empkillstreakwait();
			if(level.teambased)
			{
				var_04 maps\mp\_entityheadicons::setteamheadicon(var_04.team,(0,0,65));
			}
			else
			{
				var_04 maps\mp\_entityheadicons::setplayerheadicon(var_04.owner,(0,0,65));
			}

			wait 0.05;
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
	}
}

//Function Number: 2
trophyuselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self.trigger setcursorhint("HINT_NOICON");
	self.trigger sethintstring(&"MP_PICKUP_TROPHY");
	self.trigger maps\mp\_utility::setselfusable(param_00);
	self.trigger thread maps\mp\_utility::notusableforjoiningplayers(param_00);
	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		param_00 playlocalsound("scavenger_pack_pickup");
		param_00 maps\mp\_utility::giveperk("trophy_mp",0);
		param_00.trophyremainingammo = self.ammo;
		self.trigger delete();
		self delete();
		self notify("death");
	}
}

//Function Number: 3
trophyplayerspawnwaiter(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("spawned");
	thread trophybreak();
}

//Function Number: 4
trophydisconnectwaiter(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	thread trophybreak();
}

//Function Number: 5
trophyactive(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	var_01 = self.origin;
	for(;;)
	{
		if(!isdefined(level.grenades) || level.grenades.size < 1 && level.missiles.size < 1 || isdefined(self.disabled))
		{
			wait 0.05;
			continue;
		}

		var_02 = maps\mp\_utility::combinearrays(level.grenades,level.missiles);
		foreach(var_04 in var_02)
		{
			wait 0.05;
			if(!isdefined(var_04))
			{
				continue;
			}

			if(var_04 == self)
			{
				continue;
			}

			if(isdefined(var_04.weaponname))
			{
				switch(var_04.weaponname)
				{
					case "claymore_mp":
						break;
				}
			}

			switch(var_04.model)
			{
				case "mp_trophy_system":
				case "weapon_radar":
				case "weapon_jammer":
				case "weapon_parabolic_knife":
					break;
			}

			if(!isdefined(var_04.owner))
			{
				var_04.owner = getmissileowner(var_04);
			}

			if(isdefined(var_04.owner) && level.teambased && var_04.owner.team == param_00.team)
			{
				continue;
			}

			if(isdefined(var_04.owner) && var_04.owner == param_00)
			{
				continue;
			}

			var_05 = distancesquared(var_04.origin,self.origin);
			if(var_05 < 147456)
			{
				if(bullettracepassed(var_04.origin,self.origin,0,self))
				{
					playfx(level.sentry_fire,self.origin + (0,0,32),var_04.origin - self.origin,anglestoup(self.angles));
					self playsound("trophy_detect_projectile");
					param_00 thread projectileexplode(var_04,self);
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_noboomforyou");
					self.ammo--;
					if(self.ammo <= 0)
					{
						thread trophybreak();
					}
				}
			}
		}
	}
}

//Function Number: 6
projectileexplode(param_00,param_01)
{
	self endon("death");
	var_02 = param_00.origin;
	var_03 = param_00.model;
	var_04 = param_00.angles;
	if(var_03 == "weapon_light_marker")
	{
		playfx(level.empgrenadeexplode,var_02,anglestoforward(var_04),anglestoup(var_04));
		param_01 thread trophybreak();
		param_00 delete();
		return;
	}

	param_00 delete();
	param_01 playsound("trophy_fire");
	playfx(level.mine_explode,var_02,anglestoforward(var_04),anglestoup(var_04));
	radiusdamage(var_02,128,105,10,self,"MOD_EXPLOSIVE","trophy_mp");
}

//Function Number: 7
trophydamage(param_00)
{
	self endon("death");
	param_00 endon("death");
	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = 100;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02))
		{
			continue;
		}

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
		if(isdefined(var_0A) && var_0A == "emp_grenade_mp")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		self.damagetaken = self.damagetaken + var_01;
		if(isplayer(var_02))
		{
			var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("trophy");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			var_02 notify("destroyed_explosive");
			thread trophybreak();
		}
	}
}

//Function Number: 8
trophybreak()
{
	playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_origin");
	self playsound("sentry_explode");
	self notify("death");
	var_00 = self.origin;
	self.trigger makeunusable();
	wait 3;
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self))
	{
		self delete();
	}
}