/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_acousticsensor.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 3:04:49 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_emp;

//Function Number: 1
init()
{
	level._effect["acousticsensor_enemy_light"] = loadfx("misc/fx_equip_light_red");
	level._effect["acousticsensor_friendly_light"] = loadfx("misc/fx_equip_light_green");
}

//Function Number: 2
createacousticsensorwatcher()
{
	watcher = self maps/mp/gametypes/_weaponobjects::createuseweaponobjectwatcher("acoustic_sensor","acoustic_sensor_mp",self.team);
	watcher.onspawn = ::onspawnacousticsensor;
	watcher.detonate = ::acousticsensordetonate;
	watcher.stun = maps/mp/gametypes/_weaponobjects::weaponstun;
	watcher.stuntime = 5;
	watcher.reconmodel = "t5_weapon_acoustic_sensor_world_detect";
	watcher.hackable = 1;
	watcher.ondamage = ::watchacousticsensordamage;
}

//Function Number: 3
onspawnacousticsensor(watcher,player)
{
	self endon("death");
	self thread maps/mp/gametypes/_weaponobjects::onspawnuseweaponobject(watcher,player);
	player.acousticsensor = self;
	self setowner(player);
	self setteam(player.team);
	self.owner = player;
	self playloopsound("fly_acoustic_sensor_lp");
	if(!(self maps/mp/_utility::ishacked()))
	{
		player addweaponstat("acoustic_sensor_mp","used",1);
	}

	self thread watchshutdown(player,self.origin);
}

//Function Number: 4
acousticsensordetonate(attacker,weaponname)
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
	self destroyent();
}

//Function Number: 5
destroyent()
{
	self delete();
}

//Function Number: 6
watchshutdown(player,origin)
{
	self waittill_any("death","hacked");
	if(IsDefined(player))
	{
		player.acousticsensor = undefined;
	}
}

//Function Number: 7
watchacousticsensordamage(watcher)
{
	self endon("death");
	self endon("hacked");
	self setcandamage(1);
	damagemax = 100;
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

		if(level.teambased && attacker.team == self.owner.team && attacker != self.owner)
		{
			continue;
		}

		if(IsDefined(weaponname))
		{
			switch(weaponname)
			{
				case "€GSC\r\n":
				case "€GSC\r\n":
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

				case "€GSC\r\n":
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

		if(isplayer(attacker) && level.teambased && IsDefined(attacker.team) && self.owner.team == attacker.team && attacker != self.owner)
		{
			continue;
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