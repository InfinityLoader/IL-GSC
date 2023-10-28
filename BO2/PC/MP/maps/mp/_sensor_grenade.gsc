/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_sensor_grenade.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 2 ms
 * Timestamp: 10/28/2023 12:11:02 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_hacker_tool;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_emp;

//Function Number: 1
init()
{
	level.isplayertrackedfunc = ::isplayertracked;
}

//Function Number: 2
createsensorgrenadewatcher()
{
	watcher = self maps/mp/gametypes/_weaponobjects::createuseweaponobjectwatcher("sensor_grenade","sensor_grenade_mp",self.team);
	watcher.headicon = 0;
	watcher.onspawn = ::onspawnsensorgrenade;
	watcher.detonate = ::sensorgrenadedestroyed;
	watcher.stun = maps/mp/gametypes/_weaponobjects::weaponstun;
	watcher.stuntime = 0;
	watcher.reconmodel = "t6_wpn_motion_sensor_world_detect";
	watcher.ondamage = ::watchsensorgrenadedamage;
	watcher.enemydestroy = 1;
}

//Function Number: 3
onspawnsensorgrenade(watcher,player)
{
	self endon("death");
	self thread maps/mp/gametypes/_weaponobjects::onspawnuseweaponobject(watcher,player);
	self setowner(player);
	self setteam(player.team);
	self.owner = player;
	self playloopsound("fly_sensor_nade_lp");
	self maps/mp/_hacker_tool::registerwithhackertool(level.equipmenthackertoolradius,level.equipmenthackertooltimems);
	player addweaponstat("sensor_grenade_mp","used",1);
	self thread watchforstationary(player);
	self thread watchforexplode(player);
}

//Function Number: 4
watchforstationary(owner)
{
	self endon("death");
	self endon("hacked");
	self endon("explode");
	owner endon("death");
	owner endon("disconnect");
	self waittill("stationary");
	checkfortracking(self.origin);
}

//Function Number: 5
watchforexplode(owner)
{
	self endon("hacked");
	self endon("delete");
	owner endon("death");
	owner endon("disconnect");
	self waittill("explode",origin);
	checkfortracking(origin + (0,0,1));
}

//Function Number: 6
checkfortracking(origin)
{
	if(IsDefined(self.owner) == 0)
	{
		return;
	}

	players = level.players;
	foreach(player in level.players)
	{
		if(player isenemyplayer(self.owner))
		{
			if(!(player hasperk("specialty_nomotionsensor")))
			{
				if(distancesquared(player.origin,origin) < 562500)
				{
					trace = bullettrace(origin,12 + VectorScale((0,0,1)),player.origin,0);
					if(trace["fraction"] == 1)
					{
						self.owner tracksensorgrenadevictim(player);
					}
				}
			}
		}
	}
}

//Function Number: 7
tracksensorgrenadevictim(victim)
{
	if(!(IsDefined(self.sensorgrenadedata)))
	{
		self.sensorgrenadedata = [];
	}

	if(!(IsDefined(self.sensorgrenadedata[victim.clientid])))
	{
		self.sensorgrenadedata[victim.clientid] = GetTime();
	}
}

//Function Number: 8
isplayertracked(player,time)
{
	playertracked = 0;
	if(IsDefined(self.sensorgrenadedata) && IsDefined(self.sensorgrenadedata[player.clientid]))
	{
		if(self.sensorgrenadedata[player.clientid] + 10000 > time)
		{
			playertracked = 1;
		}
	}

	return playertracked;
}

//Function Number: 9
sensorgrenadedestroyed(attacker,weaponname)
{
	from_emp = maps/mp/killstreaks/_emp::isempweapon(weaponname);
	if(!(from_emp))
	{
		playfx(level._equipment_explode_fx,self.origin);
	}

	if(IsDefined(attacker))
	{
		if(self.owner isenemyplayer(attacker))
		{
			attacker maps/mp/_challenges::destroyedequipment(weaponname);
			maps/mp/_scoreevents::processscoreevent("destroyed_motion_sensor",attacker,self.owner,weaponname);
		}
	}

	playsoundatposition("dst_equipment_destroy",self.origin);
	self delete();
}

//Function Number: 10
watchsensorgrenadedamage(watcher)
{
	self endon("death");
	self endon("hacked");
	self setcandamage(1);
	damagemax = 1;
	if(!(self maps/mp/_utility::ishacked()))
	{
		self.damagetaken = 0;
	}

	if(1)
	{
		self.maxhealth = 100000;
		self.health = self.maxhealth;
		self waittill("damage",damage,attacker,direction,point,type,tagname,modelname,partname,weaponname,idflags);
		if(!IsDefined(attacker) || !isplayer(attacker))
		{
			continue;
		}

		if(level.teambased && isplayer(attacker))
		{
			if(!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker)
			{
				continue;
			}
		}

		if(IsDefined(weaponname))
		{
			switch(weaponname)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
					self thread maps/mp/gametypes/_weaponobjects::stunstart(watcher,watcher.stuntime);
					attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
					continue;
					attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
					continue;
	maps/mp/gametypes/_globallogic_player::dodamagefeedback(weaponname,attacker)
	!level.teambased && self.owner != attacker
	maps/mp/gametypes/_globallogic_player::dodamagefeedback(weaponname,attacker)
	level.teambased && self.owner.team != attacker.team
	watcher.stuntime > 0
					break;

				case "emp_grenade_mp":
					damage = damagemax;
					break;

				default:
					attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
					break;
	maps/mp/gametypes/_globallogic_player::dodamagefeedback(weaponname,attacker)
					break;
			}
		}
		else
		{
			weaponname = "";
		}

		if(type == "MOD_MELEE")
		{
			self.damagetaken = damagemax;
		}
		else
		{
			self.damagetaken = self.damagetaken + damage;
		}

		if(self.damagetaken >= damagemax)
		{
			watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(self,0,attacker,weaponname);
		}
	}
}