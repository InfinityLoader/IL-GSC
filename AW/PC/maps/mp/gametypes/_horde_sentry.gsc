/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_sentry.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 159 ms
 * Timestamp: 4/22/2024 2:09:41 AM
*******************************************************************/

//Function Number: 1
hordesentryinit()
{
	level.hordesentryspawns = getentarray("horde_sentry","targetname");
	level.hordesentryarray = [];
	if(maps\mp\_utility::getmapname() == "mp_recovery")
	{
		foreach(var_01 in level.hordesentryspawns)
		{
			if(distancesquared(var_01.origin,(-2099,719.9,120)) < 4096)
			{
				level.hordesentryspawns = common_scripts\utility::array_remove(level.hordesentryspawns,var_01);
			}
		}
	}
}

//Function Number: 2
hordespawnenemyturret(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,param_00);
	var_02.angles = param_01.angles;
	var_02.owner = undefined;
	var_02.health = 500;
	var_02.maxhealth = 500;
	var_02.turrettype = "mg_turret";
	var_02.stunned = 0;
	var_02.directhacked = 0;
	var_02.stunnedtime = 5;
	var_02.issentry = 1;
	var_02.weaponinfo = param_00;
	var_02.energyturret = 0;
	var_02.rocketturret = 0;
	var_02.guardian = 0;
	var_02.ishordeenemysentry = 1;
	var_02.isalive = 1;
	var_02 setmodel("npc_sentry_energy_turret_base");
	var_02 setmode("sentry");
	var_02 setturretteam("axis");
	var_02 setsentryowner(undefined);
	var_02 setturretminimapvisible(1,param_00);
	var_02 setleftarc(360);
	var_02 setrightarc(360);
	var_02 setbottomarc(90);
	var_02 setdefaultdroppitch(-89);
	var_02 setcandamage(1);
	var_02.damagefade = 1;
	var_02 thread hordeturretpicktarget();
	var_02 thread hordeturretshoot();
	var_02 thread hordeturret_setactive();
	var_02 thread maps\mp\killstreaks\_remoteturret::turret_watchdisabled();
	level.hordesentryarray[level.hordesentryarray.size] = var_02;
	playfx(level._effect["spawn_effect"],var_02.origin);
	return var_02;
}

//Function Number: 3
hordeturretshoot()
{
	self endon("death");
	self endon("deleting");
	level endon("game_ended");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.targetplayer) && isplayer(self.targetplayer) && self.targetplayer.ignoreme)
		{
			continue;
		}

		if(isdefined(self.targetplayer))
		{
			if(isdefined(self getturrettarget(1)))
			{
				var_00 = randomintrange(25,50);
				for(var_01 = 0;var_01 < var_00;var_01++)
				{
					self shootturret();
					wait(0.1);
				}

				wait(randomintrange(3,5));
				continue;
			}

			wait(randomintrange(1,3));
		}
	}
}

//Function Number: 4
hordeturretpicktarget()
{
	self endon("death");
	self endon("deleting");
	level endon("game_ended");
	for(;;)
	{
		var_00 = maps\mp\gametypes\_horde_util::hordegetclosehealthyenemyforturret(self);
		if(!self.stunned && !isdefined(self.waitingtodie) && isdefined(var_00))
		{
			if(isdefined(var_00.isaerialassaultdrone) && var_00.isaerialassaultdrone)
			{
				self settargetentity(var_00,(0,0,-20));
			}
			else
			{
				self settargetentity(var_00);
			}

			self.targetplayer = var_00;
		}
		else
		{
			self cleartargetentity();
			self.targetplayer = undefined;
		}

		wait(0.1);
	}
}

//Function Number: 5
hordeturret_setactive()
{
	self endon("death");
	self setdefaultdroppitch(0);
	self makeunusable();
	self maketurretsolid();
	self.team = "axis";
	self setturretteam("axis");
	thread hordeturret_handledeath();
	thread hordeturret_setupdamagecallback();
}

//Function Number: 6
hordeturret_handledeath()
{
	var_00 = self getentitynumber();
	self waittill("death",var_01,var_02,var_03);
	self.isalive = 0;
	if(isdefined(var_01))
	{
		if(isplayer(var_01))
		{
			maps\mp\gametypes\_horde_util::awardhordekill(var_01);
			var_01 thread maps\mp\gametypes\_rank::xppointspopup("kill",200);
			level thread maps\mp\gametypes\_horde_util::hordeupdatescore(var_01,200);
		}
		else if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			maps\mp\gametypes\_horde_util::awardhordekill(var_01.owner);
			var_01.owner thread maps\mp\gametypes\_rank::xppointspopup("kill",200);
			level thread maps\mp\gametypes\_horde_util::hordeupdatescore(var_01.owner,200);
		}
	}

	level.hordesentryarray = common_scripts\utility::array_remove(level.hordesentryarray,self);
	self.damagecallback = undefined;
	self setcandamage(0);
	self setdamagecallbackon(0);
	self freeentitysentient();
	if(!isdefined(self))
	{
		return;
	}

	hordeturret_setinactive();
	self setdefaultdroppitch(35);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	var_04 = self.owner;
	self.waitingtodie = 1;
	self playsound("sentry_explode");
	playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_aim");
	playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
	self playsound("sentry_explode_smoke");
	wait(1.5);
	self notify("deleting");
	if(isdefined(self.target_ent))
	{
		self.target_ent delete();
	}

	if(isdefined(self.ownertrigger))
	{
		self.ownertrigger delete();
	}

	if(isdefined(self.pickupent))
	{
		self.pickupent delete();
	}

	if(isdefined(self.remoteent))
	{
		self.remoteent delete();
	}

	self delete();
}

//Function Number: 7
hordeturret_setupdamagecallback()
{
	self.damagecallback = ::hordeturret_handledamagecallback;
	self setcandamage(1);
	self setdamagecallbackon(1);
}

//Function Number: 8
hordeturret_handledamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if((!isdefined(param_01) || param_01.classname == "worldspawn") && isdefined(param_05) && param_05 == "killstreak_strike_missile_gas_mp" || param_05 == "warbird_missile_mp")
	{
		return;
	}

	var_0C = param_02;
	if(maps\mp\_utility::ismeleemod(param_04))
	{
		var_0C = var_0C + self.maxhealth;
	}

	if(isdefined(param_03) && param_03 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	self.damagefade = 0;
	if(isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_turret");
		if(param_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
		{
			var_0C = var_0C * level.armorpiercingmod;
		}
	}

	if(isdefined(param_01.owner) && isplayer(param_01.owner))
	{
		param_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_turret");
	}

	if(isdefined(param_05))
	{
		var_0D = maps\mp\_utility::strip_suffix(param_05,"_lefthand");
		switch(var_0D)
		{
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
			case "stinger_mp":
			case "remotemissile_projectile_mp":
				self.largeprojectiledamage = 1;
				var_0C = self.maxhealth + 1;
				break;

			case "stealth_bomb_mp":
			case "artillery_mp":
				self.largeprojectiledamage = 0;
				var_0C = var_0C + param_02 * 4;
				break;

			case "emp_grenade_killstreak_mp":
			case "emp_grenade_var_mp":
			case "emp_grenade_mp":
			case "bomb_site_mp":
				self.largeprojectiledamage = 0;
				var_0C = self.maxhealth + 1;
				break;

			case "semtex_horde_mp":
			case "frag_grenade_horde_mp":
				var_0C = int(self.maxhealth / 2 + 1);
				break;
		}
	}

	self finishentitydamage(param_00,param_01,var_0C,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 9
hordeturret_setinactive()
{
	self setmode("sentry_offline");
}