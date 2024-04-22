/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_equipment.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 266 ms
 * Timestamp: 4/22/2024 2:09:20 AM
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
					self setweaponammostock("trophy_mp",self setweaponammostock("trophy_mp") + 1);
					continue;
				}

				var_00.origin = var_03["position"];
			}

			var_00 show();
			self.trophyarray = common_scripts\utility::array_removeundefined(self.trophyarray);
			if(self.trophyarray.size >= level.maxperplayerexplosives)
			{
				self.trophyarray[0] thread trophybreak();
			}

			var_04 = spawn("script_model",var_00.origin);
			var_04 setmodel("mp_trophy_system");
			var_04 thread maps\mp\gametypes\_weapons::createbombsquadmodel("mp_trophy_system_bombsquad","tag_origin",self);
			var_04.angles = var_00.angles;
			self.trophyarray[self.trophyarray.size] = var_04;
			var_04.owner = self;
			var_04.team = self.team;
			var_04.weaponname = var_01;
			var_04.stunned = 0;
			level.trophies[level.trophies.size] = var_04;
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

			wait(0.05);
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
	}
}

//Function Number: 2
trophystunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	playfxontag(common_scripts\utility::getfx("mine_stunned"),self,"tag_origin");
}

//Function Number: 3
trophystunend()
{
	self.stunned = 0;
	stopfxontag(common_scripts\utility::getfx("mine_stunned"),self,"tag_origin");
}

//Function Number: 4
trophychangeowner(param_00)
{
	if(isdefined(self.entityheadicon))
	{
		self.entityheadicon destroy();
	}

	self notify("change_owner");
	self.owner = param_00;
	self.team = param_00.team;
	param_00.trophyarray[param_00.trophyarray.size] = self;
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,65));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,65));
	}

	thread trophydamage(param_00);
	thread trophyactive(param_00);
	thread trophydisconnectwaiter(param_00);
	thread trophyplayerspawnwaiter(param_00);
}

//Function Number: 5
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
		var_01 = param_00 getweaponammoclip("trophy_mp");
		param_00 setweaponammoclip("trophy_mp",var_01 + 1);
		param_00.trophyremainingammo = self.ammo;
		self.trigger delete();
		self delete();
		self notify("death");
	}
}

//Function Number: 6
trophyplayerspawnwaiter(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("change_owner");
	param_00 waittill("spawned");
	thread trophybreak();
}

//Function Number: 7
trophydisconnectwaiter(param_00)
{
	self endon("death");
	self endon("change_owner");
	param_00 waittill("disconnect");
	thread trophybreak();
}

//Function Number: 8
trophyactive(param_00,param_01,param_02,param_03)
{
	param_00 endon("disconnect");
	self endon("death");
	self endon("change_owner");
	self endon("trophyDisabled");
	if(!isdefined(param_01))
	{
		param_01 = 384;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = "exorepulsor_equipment_mp";
	}

	var_04 = param_01 * param_01;
	for(;;)
	{
		if(!isdefined(level.grenades) || level.grenades.size < 1 && level.missiles.size < 1 && level.trackingdrones.size < 1 || isdefined(self.disabled) || self.stunned == 1)
		{
			wait(0.05);
			continue;
		}

		var_05 = common_scripts\utility::array_combine(level.grenades,level.missiles);
		var_05 = common_scripts\utility::array_combine(var_05,level.trackingdrones);
		if(var_05.size < 1)
		{
			wait(0.05);
			continue;
		}

		foreach(var_07 in var_05)
		{
			wait(0.05);
			if(!isdefined(var_07))
			{
				continue;
			}

			if(var_07 == self)
			{
				continue;
			}

			if(isdefined(var_07.weaponname))
			{
				switch(var_07.weaponname)
				{
					case "orbital_carepackage_droppod_mp":
					case "orbital_carepackage_pod_mp":
					case "claymore_mp":
						break;
				}
			}

			switch(var_07.model)
			{
				case "mp_trophy_system":
				case "weapon_radar":
				case "weapon_jammer":
				case "weapon_parabolic_knife":
					break;
			}

			if(!isdefined(var_07.owner))
			{
				var_07.owner = getmissileowner(var_07);
			}

			if(isdefined(var_07.owner) && level.teambased && var_07.owner.team == param_00.team)
			{
				continue;
			}

			if(isdefined(var_07.owner) && var_07.owner == param_00)
			{
				continue;
			}

			if(!trophywithinmindot(var_07))
			{
				continue;
			}

			var_08 = distancesquared(var_07.origin,self.origin);
			if(var_08 < var_04)
			{
				if(bullettracepassed(var_07.origin,self.origin,0,self))
				{
					var_09 = self.origin + (0,0,32);
					if(isdefined(self.laserent))
					{
						var_09 = self.laserent.origin;
					}

					playfx(level.sentry_fire,var_09,var_07.origin - self.origin,anglestoup(self.angles));
					thread trophyhandlelaser(param_00,var_07);
					self playsound("trophy_detect_projectile");
					if(isdefined(var_07.classname) && var_07.classname == "rocket" && isdefined(var_07.type) && var_07.type == "remote")
					{
						if(isdefined(var_07.type) && var_07.type == "remote")
						{
							level thread maps\mp\gametypes\_missions::vehiclekilled(var_07.owner,param_00,undefined,param_00,undefined,"MOD_EXPLOSIVE",param_03);
							level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_predator_missile",param_00);
							level thread maps\mp\gametypes\_rank::awardgameevent("kill",param_00,param_03,undefined,"MOD_EXPLOSIVE");
							param_00 notify("destroyed_killstreak",param_03);
						}

						if(isdefined(level.chopper_fx["explode"]["medium"]))
						{
							playfx(level.chopper_fx["explode"]["medium"],var_07.origin);
						}

						if(isdefined(level.barrelexpsound))
						{
							var_07 playsound(level.barrelexpsound);
						}
					}

					if(isdefined(var_07.type) && var_07.type == "tracking_drone")
					{
						var_07 thread maps\mp\_tracking_drone::trackingdrone_leave();
					}
					else
					{
						param_00 thread projectileexplode(var_07,self);
						param_00 maps\mp\gametypes\_missions::processchallenge("ch_noboomforyou");
					}

					if(!param_02)
					{
						self.ammo--;
					}

					if(self.ammo <= 0)
					{
						thread trophybreak();
					}
				}
			}
		}
	}
}

//Function Number: 9
trophysetmindot(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	self.mindot = param_00;
	self.trophyangleoffset = param_01;
}

//Function Number: 10
trophywithinmindot(param_00)
{
	if(!isdefined(self.mindot))
	{
		return 1;
	}

	var_01 = anglestoforward(self.angles + self.trophyangleoffset);
	var_02 = vectornormalize(param_00.origin - self.origin);
	var_03 = vectordot(var_01,var_02);
	return var_03 > self.mindot;
}

//Function Number: 11
trophyhandlelaser(param_00,param_01)
{
	if(!isdefined(self.laserent))
	{
		return;
	}

	param_00 endon("disconnect");
	self endon("death");
	self endon("change_owner");
	self endon("trophyDisabled");
	self.laserent endon("death");
	self notify("trophyDelayClearLaser");
	self endon("trophyDelayClearLaser");
	self.laserent.angles = vectortoangles(param_01.origin - self.laserent.origin);
	self.laserent laseron("tracking_drone_laser");
	wait(0.7);
	self.laserent laseroff();
}

//Function Number: 12
trophyaddlaser(param_00,param_01)
{
	self.laserent = spawn("script_model",self.origin);
	self.laserent setmodel("tag_laser");
	self.laserent.angles = self.angles;
	self.laserent.laseroriginoffset = param_00;
	self.laserent.laserforwardangles = param_01;
	thread trophyupdatelaser();
}

//Function Number: 13
trophyupdatelaser()
{
	self endon("death");
	self endon("change_owner");
	self endon("trophyDisabled");
	self.laserent endon("death");
	for(;;)
	{
		var_00 = anglestoforward(self.angles + self.laserent.laserforwardangles);
		self.laserent.origin = self.origin + var_00 * self.laserent.laseroriginoffset;
		wait 0.05;
	}
}

//Function Number: 14
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

//Function Number: 15
trophydamage(param_00)
{
	self endon("death");
	param_00 endon("death");
	self endon("change_owner");
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
		if(isdefined(var_0B) && var_0B == "emp_grenade_mp" || var_0B == "emp_grenade_var_mp" || var_0B == "emp_grenade_killstreak_mp")
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
			if(isdefined(param_00) && var_02 != param_00)
			{
				var_02 notify("destroyed_explosive");
			}

			thread trophybreak();
		}
	}
}

//Function Number: 16
trophybreak()
{
	playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_origin");
	self playsound("sentry_explode");
	self notify("death");
	var_00 = self.origin;
	self.trigger makeunusable();
	if(isdefined(self.laserent))
	{
		self.laserent delete();
	}

	wait(3);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self))
	{
		self delete();
	}
}