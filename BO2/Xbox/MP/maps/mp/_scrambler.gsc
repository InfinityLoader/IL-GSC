/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_scrambler.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 24 ms
 * Timestamp: 10/27/2023 3:05:10 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_emp;

//Function Number: 1
init()
{
	level._effect["scrambler_enemy_light"] = loadfx("misc/fx_equip_light_red");
	level._effect["scrambler_friendly_light"] = loadfx("misc/fx_equip_light_green");
	level.scramblerweapon = "scrambler_mp";
	level.scramblerlength = 30;
	level.scramblerouterradiussq = 1000000;
	level.scramblerinnerradiussq = 360000;
}

//Function Number: 2
createscramblerwatcher()
{
	watcher = self maps/mp/gametypes/_weaponobjects::createuseweaponobjectwatcher("scrambler","scrambler_mp",self.team);
	watcher.onspawn = ::onspawnscrambler;
	watcher.detonate = ::scramblerdetonate;
	watcher.stun = maps/mp/gametypes/_weaponobjects::weaponstun;
	watcher.stuntime = 5;
	watcher.reconmodel = "t5_weapon_scrambler_world_detect";
	watcher.hackable = 1;
	watcher.ondamage = ::watchscramblerdamage;
}

//Function Number: 3
onspawnscrambler(watcher,player)
{
	player endon("disconnect");
	self endon("death");
	self thread maps/mp/gametypes/_weaponobjects::onspawnuseweaponobject(watcher,player);
	player.scrambler = self;
	self setowner(player);
	self setteam(player.team);
	self.owner = player;
	self setclientflag(3);
	if(!(self maps/mp/_utility::ishacked()))
	{
		player addweaponstat("scrambler_mp","used",1);
	}

	self thread watchshutdown(player);
	level notify("scrambler_spawn");
}

//Function Number: 4
scramblerdetonate(attacker,weaponname)
{
	from_emp = maps/mp/killstreaks/_emp::isempweapon(weaponname);
	if(!(from_emp))
	{
		playfx(level._equipment_explode_fx,self.origin);
	}

	if(self.owner isenemyplayer(attacker))
	{
		attacker maps/mp/_challenges::destroyedequipment(weaponname);
	}

	playsoundatposition("dst_equipment_destroy",self.origin);
	self delete();
}

//Function Number: 5
watchshutdown(player)
{
	self waittill_any("death","hacked");
	level notify("scrambler_death");
	if(IsDefined(player))
	{
		player.scrambler = undefined;
	}
}

//Function Number: 6
destroyent()
{
	self delete();
}

//Function Number: 7
watchscramblerdamage(watcher)
{
	self endon("death");
	self endon("hacked");
	self setcandamage(1);
	damagemax = 100;
	if(!(self maps/mp/_utility::ishacked()))
	{
		self.damagetaken = 0;
	}

	while(1)
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

//Function Number: 8
ownersameteam(owner1,owner2)
{
	if(!(level.teambased))
	{
		return 0;
	}

	if(!IsDefined(owner1) || !IsDefined(owner2))
	{
		return 0;
	}

	if(!IsDefined(owner1.team) || !IsDefined(owner2.team))
	{
		return 0;
	}

	return owner1.team == owner2.team;
}

//Function Number: 9
checkscramblerstun()
{
	scramblers = getentarray("grenade","classname");
	if(IsDefined(self.name) && self.name == "scrambler_mp")
	{
		return 0;
	}

	for(i = 0;i < scramblers.size;i++)
	{
		scrambler = scramblers[i];
		if(!(isalive(scrambler)))
		{
		}
		else if(!(IsDefined(scrambler.name)))
		{
		}
		else if(scrambler.name != "scrambler_mp")
		{
		}
		else if(ownersameteam(self.owner,scrambler.owner))
		{
		}
		else
		{
			flattenedselforigin = (self.origin[0],self.origin[1],0);
			flattenedscramblerorigin = (scrambler.origin[0],scrambler.origin[1],0);
			if(distancesquared(flattenedselforigin,flattenedscramblerorigin) < level.scramblerouterradiussq)
			{
				return 1;
			}
		}
	}

	return 0;
}