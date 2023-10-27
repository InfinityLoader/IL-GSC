/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic_actor.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 10/27/2023 3:00:01 AM
*******************************************************************/

#include maps/mp/_burnplayer;
#include maps/mp/_challenges;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_weapons;

//Function Number: 1
callback_actordamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex)
{
	if(game["state"] == "postgame")
	{
		return;
	}

	if(self.aiteam == "spectator")
	{
		return;
	}

	if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return;
	}

	self.idflags = idflags;
	self.idflagstime = GetTime();
	eattacker = maps/mp/gametypes/_globallogic_player::figureoutattacker(eattacker);
	if(!(IsDefined(vdir)))
	{
		idflags = idflags | level.idflags_no_knockback;
	}

	friendly = 0;
	if(self.health == self.maxhealth || !IsDefined(self.attackers))
	{
		self.attackers = [];
		self.attackerdata = [];
		self.attackerdamage = [];
	}

	if(maps/mp/gametypes/_globallogic_utils::isheadshot(sweapon,shitloc,smeansofdeath,einflictor))
	{
		smeansofdeath = "MOD_HEAD_SHOT";
	}

	if(level.onlyheadshots)
	{
		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
		{
			return;
		}
		else if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			idamage = 150;
		}
	}

	if(smeansofdeath == "MOD_BURNED")
	{
		if(sweapon == "none")
		{
			self maps/mp/_burnplayer::walkedthroughflames();
		}

		if(sweapon == "m2_flamethrower_mp")
		{
			self maps/mp/_burnplayer::burnedwithflamethrower();
		}
	}

	if(sweapon == "none" && IsDefined(einflictor))
	{
		if(IsDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel")
		{
			sweapon = "explodable_barrel_mp";
		}
		else if(IsDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type,"vehicle_"))
		{
			sweapon = "destructible_car_mp";
		}
	}

	if(!(idflags & level.idflags_no_protection))
	{
		if(isplayer(eattacker))
		{
			eattacker.pers["participation"]++;
		}

		prevhealthratio = self.health / self.maxhealth;
		if(level.teambased && isplayer(eattacker) && self != eattacker && self.aiteam == eattacker.pers["team"])
		{
			if(level.friendlyfire == 0)
			{
				return;
			}
			else if(level.friendlyfire == 1)
			{
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishactordamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
			}
			else if(level.friendlyfire == 2)
			{
				return;
			}
			else if(level.friendlyfire == 3)
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishactordamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
			}

			friendly = 1;
		}
		else
		{
			if(IsDefined(eattacker) && IsDefined(self.script_owner) && eattacker == self.script_owner && !level.hardcoremode)
			{
				return;
			}

			if(IsDefined(eattacker) && IsDefined(self.script_owner) && IsDefined(eattacker.script_owner) && eattacker.script_owner == self.script_owner)
			{
				return;
			}

			if(idamage < 1)
			{
				idamage = 1;
			}

			if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(sweapon) && !issubstr(smeansofdeath,"MOD_MELEE"))
			{
				eattacker thread maps/mp/gametypes/_weapons::checkhit(sweapon);
			}

			if(issubstr(smeansofdeath,"MOD_GRENADE") && IsDefined(einflictor) && IsDefined(einflictor.iscooked))
			{
				self.wascooked = GetTime();
			}
			else
			{
				self.wascooked = undefined;
			}

			self.lastdamagewasfromenemy = IsDefined(eattacker) && eattacker != self;
			self finishactordamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex);
		}

		if(IsDefined(eattacker) && eattacker != self)
		{
			if(sweapon != "artillery_mp" && !IsDefined(einflictor) || !isai(einflictor))
			{
				if(idamage > 0)
				{
					eattacker thread maps/mp/gametypes/_damagefeedback::updatedamagefeedback(smeansofdeath,einflictor);
				}
			}
		}
	}

/#
	println("actor:" + self getentitynumber() + " health:" + self.health + " attacker:" + eattacker.clientid + " inflictor is player:" + isplayer(einflictor) + " damage:" + idamage + " hitLoc:" + shitloc);
GetDvarInt(#"B1AE74B1")
#/
	if(1)
	{
		lpselfnum = self getentitynumber();
		lpselfteam = self.aiteam;
		lpattackerteam = "";
		if(isplayer(eattacker))
		{
			lpattacknum = eattacker getentitynumber();
			lpattackguid = eattacker getguid();
			lpattackname = eattacker.name;
			lpattackerteam = eattacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackguid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		logprint("AD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sweapon + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + ";" + boneindex + "\n");
	}
}

//Function Number: 2
callback_actorkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime)
{
	if(game["state"] == "postgame")
	{
		return;
	}

	if(isai(attacker) && IsDefined(attacker.script_owner))
	{
		if(attacker.script_owner.team != self.aiteam)
		{
			attacker = attacker.script_owner;
		}
	}

	if(attacker.classname == "script_vehicle" && IsDefined(attacker.owner))
	{
		attacker = attacker.owner;
	}

	if(IsDefined(attacker) && isplayer(attacker))
	{
		if(!level.teambased || self.aiteam != attacker.pers["team"])
		{
			level.globalkillstreaksdestroyed++;
			attacker addweaponstat("dogs_mp","destroyed",1);
			maps/mp/_scoreevents::processscoreevent("killed_dog",attacker,self,sweapon);
			attacker maps/mp/_challenges::killeddog();
		}
	}
}