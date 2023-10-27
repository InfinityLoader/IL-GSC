/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic_vehicle.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 3:00:07 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/_vehicles;
#include maps/mp/gametypes/_class;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_weapons;

//Function Number: 1
callback_vehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,damagefromunderneath,modelindex,partname)
{
	if(!(level.idflags_radius & idflags))
	{
		idamage = maps/mp/gametypes/_class::cac_modified_vehicle_damage(self,eattacker,idamage,smeansofdeath,sweapon,einflictor);
	}

	self.idflags = idflags;
	self.idflagstime = GetTime();
	if(game["state"] == "postgame")
	{
		return;
	}

	if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return;
	}

	if(!(IsDefined(vdir)))
	{
		idflags = idflags | level.idflags_no_knockback;
	}

	friendly = 0;
	if((IsDefined(self.maxhealth) && self.health == self.maxhealth) || !IsDefined(self.attackers))
	{
		self.attackers = [];
		self.attackerdata = [];
		self.attackerdamage = [];
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
		if(self isvehicleimmunetodamage(idflags,smeansofdeath,sweapon))
		{
			return;
		}

		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
		{
		}
		else if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE")
		{
			idamage = idamage * getvehicleprojectilescalar(sweapon);
			idamage = int(idamage);
			if(idamage == 0)
			{
				return;
			}
		}
		else if(smeansofdeath == "MOD_GRENADE_SPLASH")
		{
			idamage = idamage * getvehicleunderneathsplashscalar(sweapon);
			idamage = int(idamage);
			if(idamage == 0)
			{
				return;
			}
		}

		idamage = idamage * level.vehicledamagescalar;
		idamage = int(idamage);
		if(isplayer(eattacker))
		{
			eattacker.pers["participation"]++;
		}

		prevhealthratio = self.health / self.maxhealth;
		if(IsDefined(self.owner) && isplayer(self.owner))
		{
			team = self.owner.pers["team"];
		}
		else
		{
			team = self maps/mp/_vehicles::vehicle_get_occupant_team();
		}

		if(level.teambased && isplayer(eattacker) && team == eattacker.pers["team"])
		{
			if(level.friendlyfire == 0)
			{
				if(!(allowfriendlyfiredamage(einflictor,eattacker,smeansofdeath,sweapon)))
				{
					return;
				}

				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,damagefromunderneath,modelindex,partname,1);
			}
			else if(level.friendlyfire == 1)
			{
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,damagefromunderneath,modelindex,partname,0);
			}
			else if(level.friendlyfire == 2)
			{
				if(!(allowfriendlyfiredamage(einflictor,eattacker,smeansofdeath,sweapon)))
				{
					return;
				}

				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,damagefromunderneath,modelindex,partname,1);
			}
			else if(level.friendlyfire == 3)
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,damagefromunderneath,modelindex,partname,0);
			}

			friendly = 1;
		}
		else if(!level.hardcoremode && IsDefined(self.owner) && IsDefined(eattacker.owner) && self.owner == eattacker.owner)
		{
			return;
		}
		else
		{
			if(IsDefined(self.owner) && IsDefined(eattacker) && self.owner == eattacker)
			{
				return;
			}

			if(idamage < 1)
			{
				idamage = 1;
			}

			if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(sweapon))
			{
				eattacker thread maps/mp/gametypes/_weapons::checkhit(sweapon);
			}

			if(issubstr(smeansofdeath,"MOD_GRENADE") && IsDefined(einflictor.iscooked))
			{
				self.wascooked = GetTime();
			}
			else
			{
				self.wascooked = undefined;
			}

			attacker_seat = undefined;
			if(IsDefined(eattacker))
			{
				attacker_seat = self getoccupantseat(eattacker);
			}

			self.lastdamagewasfromenemy = IsDefined(eattacker) && !IsDefined(attacker_seat);
			self finishvehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,damagefromunderneath,modelindex,partname,0);
			if(level.gametype == "hack" && sweapon != "emp_grenade_mp")
			{
				idamage = 0;
			}
		}

		if(IsDefined(eattacker) && eattacker != self)
		{
			if(maps/mp/gametypes/_globallogic_player::dodamagefeedback(sweapon,einflictor))
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
		lpselfteam = "";
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

		logprint("VD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sweapon + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
	}
}

//Function Number: 2
callback_vehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,psoffsettime)
{
	idamage = maps/mp/gametypes/_class::cac_modified_vehicle_damage(self,eattacker,idamage,smeansofdeath,sweapon,einflictor);
	finnerdamage = maps/mp/gametypes/_class::cac_modified_vehicle_damage(self,eattacker,finnerdamage,smeansofdeath,sweapon,einflictor);
	fouterdamage = maps/mp/gametypes/_class::cac_modified_vehicle_damage(self,eattacker,fouterdamage,smeansofdeath,sweapon,einflictor);
	self.idflags = idflags;
	self.idflagstime = GetTime();
	if(game["state"] == "postgame")
	{
		return;
	}

	if(IsDefined(eattacker) && isplayer(eattacker) && IsDefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return;
	}

	friendly = 0;
	if(!(idflags & level.idflags_no_protection))
	{
		if(self isvehicleimmunetodamage(idflags,smeansofdeath,sweapon))
		{
			return;
		}

		if(smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE")
		{
			scalar = getvehicleprojectilesplashscalar(sweapon);
			idamage = int(idamage * scalar);
			finnerdamage = finnerdamage * scalar;
			fouterdamage = fouterdamage * scalar;
			if(finnerdamage == 0)
			{
				return;
			}

			if(idamage < 1)
			{
				idamage = 1;
			}
		}

		occupant_team = self maps/mp/_vehicles::vehicle_get_occupant_team();
		if(level.teambased && isplayer(eattacker) && occupant_team == eattacker.pers["team"])
		{
			if(level.friendlyfire == 0)
			{
				if(!(allowfriendlyfiredamage(einflictor,eattacker,smeansofdeath,sweapon)))
				{
					return;
				}

				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,psoffsettime);
			}
			else if(level.friendlyfire == 1)
			{
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,psoffsettime);
			}
			else if(level.friendlyfire == 2)
			{
				if(!(allowfriendlyfiredamage(einflictor,eattacker,smeansofdeath,sweapon)))
				{
					return;
				}

				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,psoffsettime);
			}
			else if(level.friendlyfire == 3)
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				self.lastdamagewasfromenemy = 0;
				self finishvehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,psoffsettime);
			}

			friendly = 1;
		}
		else if(!level.hardcoremode && IsDefined(self.owner) && IsDefined(eattacker.owner) && self.owner == eattacker.owner)
		{
			return;
		}
		else
		{
			if(idamage < 1)
			{
				idamage = 1;
			}

			self finishvehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,psoffsettime);
		}
	}
}

//Function Number: 3
vehiclecrush()
{
	self endon("disconnect");
	if(IsDefined(level._effect) && IsDefined(level._effect["tanksquish"]))
	{
		playfx(level._effect["tanksquish"],30 + VectorScale((0,0,1)));
	}

	self playsound("chr_crunch");
}

//Function Number: 4
getvehicleprojectilescalar(sweapon)
{
	if(sweapon == "remote_missile_missile_mp")
	{
		scale = 10;
	}
	else if(sweapon == "remote_mortar_missile_mp")
	{
		scale = 10;
	}
	else if(sweapon == "smaw_mp")
	{
		scale = 0.2;
	}
	else if(sweapon == "fhj18_mp")
	{
		scale = 0.2;
	}
	else
	{
		scale = 1;
	}

	return scale;
}

//Function Number: 5
getvehicleprojectilesplashscalar(sweapon)
{
	if(sweapon == "remote_missile_missile_mp")
	{
		scale = 10;
	}
	else if(sweapon == "remote_mortar_missile_mp")
	{
		scale = 4;
	}
	else if(sweapon == "chopper_minigun_mp")
	{
		scale = 0.5;
	}
	else
	{
		scale = 1;
	}

	return scale;
}

//Function Number: 6
getvehicleunderneathsplashscalar(sweapon)
{
	if(sweapon == "satchel_charge_mp")
	{
		scale = 10;
		scale = scale * 3;
	}
	else
	{
		scale = 1;
	}

	return scale;
}

//Function Number: 7
getvehiclebulletdamage(sweapon)
{
	if(issubstr(sweapon,"ptrs41_"))
	{
		idamage = 25;
	}
	else if(issubstr(sweapon,"gunner"))
	{
		idamage = 5;
	}
	else if(issubstr(sweapon,"mg42_bipod") || issubstr(sweapon,"30cal_bipod"))
	{
		idamage = 5;
	}
	else
	{
		idamage = 1;
	}

	return idamage;
}

//Function Number: 8
allowfriendlyfiredamage(einflictor,eattacker,smeansofdeath,sweapon)
{
	if(IsDefined(self.allowfriendlyfiredamageoverride))
	{
		return [[ self.allowfriendlyfiredamageoverride ]](einflictor,eattacker,smeansofdeath,sweapon);
	}

	vehicle = eattacker getvehicleoccupied();
	return 0;
}