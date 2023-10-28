/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_hacker_tool.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 7 ms
 * Timestamp: 10/28/2023 12:10:57 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_heatseekingmissile;
#include maps/mp/_utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_supplydrop;

//Function Number: 1
init()
{
	level.hackertoolmaxequipmentdistance = 2000;
	level.hackertoolmaxequipmentdistancesq = level.hackertoolmaxequipmentdistance * level.hackertoolmaxequipmentdistance;
	level.hackertoolnosighthackdistance = 750;
	level.hackertoollostsightlimitms = 450;
	level.hackertoollockonradius = 20;
	level.hackertoollockonfov = 65;
	level.hackertoolhacktimems = 0.5;
	level.equipmenthackertoolradius = 60;
	level.equipmenthackertooltimems = 50;
	level.carepackagehackertoolradius = 60;
	level.carepackagehackertooltimems = getgametypesetting("crateCaptureTime") * 500;
	level.carepackagefriendlyhackertooltimems = getgametypesetting("crateCaptureTime") * 2000;
	level.carepackageownerhackertooltimems = 250;
	level.sentryhackertoolradius = 80;
	level.sentryhackertooltimems = 4000;
	level.microwavehackertoolradius = 80;
	level.microwavehackertooltimems = 4000;
	level.vehiclehackertoolradius = 80;
	level.vehiclehackertooltimems = 4000;
	level.rcxdhackertooltimems = 1500;
	level.rcxdhackertoolradius = 20;
	level.uavhackertooltimems = 4000;
	level.uavhackertoolradius = 40;
	level.cuavhackertooltimems = 4000;
	level.cuavhackertoolradius = 40;
	level.carepackagechopperhackertooltimems = 3000;
	level.carepackagechopperhackertoolradius = 60;
	level.littlebirdhackertooltimems = 4000;
	level.littlebirdhackertoolradius = 80;
	level.qrdronehackertooltimems = 3000;
	level.qrdronehackertoolradius = 60;
	level.aitankhackertooltimems = 4000;
	level.aitankhackertoolradius = 60;
	level.stealthchopperhackertooltimems = 4000;
	level.stealthchopperhackertoolradius = 80;
	level.warthoghackertooltimems = 4000;
	level.warthoghackertoolradius = 80;
	level.lodestarhackertooltimems = 4000;
	level.lodestarhackertoolradius = 60;
	level.choppergunnerhackertooltimems = 4000;
	level.choppergunnerhackertoolradius = 260;
	thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self clearhackertarget();
		self thread watchhackertooluse();
		self thread watchhackertoolfired();
	}
}

//Function Number: 4
clearhackertarget()
{
	self notify("stop_lockon_sound");
	self notify("stop_locked_sound");
	self.stingerlocksound = undefined;
	self stoprumble("stinger_lock_rumble");
	self.hackertoollockstarttime = 0;
	self.hackertoollockstarted = 0;
	self.hackertoollockfinalized = 0;
	self.hackertoollocktimeelapsed = 0;
	self setweaponheatpercent("pda_hack_mp",0);
	if(IsDefined(self.hackertooltarget))
	{
		lockingon(self.hackertooltarget,0);
		lockedon(self.hackertooltarget,0);
	}

	self.hackertooltarget = undefined;
	self weaponlockfree();
	self weaponlocktargettooclose(0);
	self weaponlocknoclearance(0);
	self stoplocalsound(game["locking_on_sound"]);
	self stoplocalsound(game["locked_on_sound"]);
	self destroylockoncanceledmessage();
}

//Function Number: 5
watchhackertoolfired()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		self waittill("hacker_tool_fired",hackertooltarget);
		if(IsDefined(hackertooltarget))
		{
			if(isentityhackablecarepackage(hackertooltarget))
			{
				maps/mp/killstreaks/_supplydrop::givecratecapturemedal(hackertooltarget,self);
				hackertooltarget notify("captured",self,1);
			}

			if(isentityhackableweaponobject(hackertooltarget) || IsDefined(hackertooltarget.hackertrigger))
			{
				hackertooltarget.hackertrigger notify("trigger",self,1);
			}
			else
			{
				if(IsDefined(hackertooltarget.classname) && hackertooltarget.classname == "grenade")
				{
					damage = 1;
				}
				else if(IsDefined(hackertooltarget.maxhealth))
				{
					damage = hackertooltarget.maxhealth + 1;
				}
				else
				{
					damage = 999999;
				}

				if(IsDefined(hackertooltarget.numflares) && hackertooltarget.numflares > 0)
				{
					damage = 1;
					hackertooltarget.numflares--;
					hackertooltarget maps/mp/_heatseekingmissile::missiletarget_playflarefx();
				}

				hackertooltarget dodamage(damage,self.origin,self,self,0,"MOD_UNKNOWN",0,"pda_hack_mp");
			}

			self addplayerstat("hack_enemy_target",1);
			self addweaponstat("pda_hack_mp","used",1);
		}

		clearhackertarget();
		self forceoffhandend();
		clip_ammo = self getweaponammoclip("pda_hack_mp");
		clip_ammo--;
/#
/#
		assert(clip_ammo >= 0);
#/
#/
		self setweaponammoclip("pda_hack_mp",clip_ammo);
		self switchtoweapon(self getlastweapon());
	}
}

//Function Number: 6
watchhackertooluse()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self waittill("grenade_pullback",weapon);
		if(weapon == "pda_hack_mp")
		{
			wait(0.05);
			if(self isusingoffhand() && self getcurrentoffhand() == "pda_hack_mp")
			{
				self thread hackertooltargetloop();
				self thread watchhackertoolend();
				self thread watchforgrenadefire();
				self thread watchhackertoolinterrupt();
			}
		}
	}
}

//Function Number: 7
watchhackertoolinterrupt()
{
	self endon("disconnect");
	self endon("hacker_tool_fired");
	self endon("death");
	self endon("weapon_change");
	self endon("grenade_fire");
	while(1)
	{
		level waittill("use_interrupt",interrupttarget);
		if(self.hackertooltarget == interrupttarget)
		{
			clearhackertarget();
		}

		wait(0.05);
	}
}

//Function Number: 8
watchhackertoolend()
{
	self endon("disconnect");
	self endon("hacker_tool_fired");
	msg = self waittill_any_return("weapon_change","death");
	clearhackertarget();
}

//Function Number: 9
watchforgrenadefire()
{
	self endon("disconnect");
	self endon("hacker_tool_fired");
	self endon("weapon_change");
	self endon("death");
	while(1)
	{
		self waittill("grenade_fire",grenade,grenadename,respawnfromhack);
		if(IsDefined(respawnfromhack) && respawnfromhack)
		{
			continue;
		}

		clearhackertarget();
		clip_ammo = self getweaponammoclip("pda_hack_mp");
		clip_max_ammo = weaponclipsize("pda_hack_mp");
		if(clip_ammo < clip_max_ammo)
		{
			clip_ammo++;
		}

		self setweaponammoclip("pda_hack_mp",clip_ammo);
		break;
	}
}

//Function Number: 10
hackertooltargetloop()
{
	self endon("disconnect");
	self endon("death");
	self endon("weapon_change");
	self endon("grenade_fire");
	while(1)
	{
		wait(0.05);
		if(self.hackertoollockfinalized)
		{
			if(!(self isvalidhackertooltarget(self.hackertooltarget)))
			{
				self clearhackertarget();
				continue;
			}

			passed = self hackersoftsighttest();
			if(!(passed))
			{
				continue;
			}

			lockingon(self.hackertooltarget,0);
			lockedon(self.hackertooltarget,1);
			thread looplocallocksound(game["locked_on_sound"],0.75);
			self notify("hacker_tool_fired",self.hackertooltarget);
			return;
		}

		if(self.hackertoollockstarted)
		{
			if(!(self isvalidhackertooltarget(self.hackertooltarget)))
			{
				self clearhackertarget();
				continue;
			}

			locklengthms = self gethacktime(self.hackertooltarget);
			if(locklengthms == 0)
			{
				self clearhackertarget();
				continue;
			}

			if(self.hackertoollocktimeelapsed == 0)
			{
				self playlocalsound("evt_hacker_hacking");
			}

			lockingon(self.hackertooltarget,1);
			lockedon(self.hackertooltarget,0);
			passed = self hackersoftsighttest();
			if(!(passed))
			{
				continue;
			}

			if(self.hackertoollostsightlinetime == 0)
			{
				self.hackertoollocktimeelapsed = self.hackertoollocktimeelapsed + 0.05;
				hackpercentage = self.hackertoollocktimeelapsed / locklengthms / 1000;
				self setweaponheatpercent("pda_hack_mp",hackpercentage);
			}

			if(self.hackertoollocktimeelapsed < locklengthms / 1000)
			{
				continue;
			}

/#
			assert(IsDefined(self.hackertooltarget));
#/
			self notify("stop_lockon_sound");
			self.hackertoollockfinalized = 1;
			self weaponlockfinalize(self.hackertooltarget);
			continue;
		}

		besttarget = self getbesthackertooltarget();
		if(!(IsDefined(besttarget)))
		{
			self destroylockoncanceledmessage();
			continue;
		}

		if(!self locksighttest(besttarget) && distance2d(self.origin,besttarget.origin) > level.hackertoolnosighthackdistance)
		{
			self destroylockoncanceledmessage();
			continue;
		}

		if(self locksighttest(besttarget) && IsDefined(besttarget.lockondelay) && besttarget.lockondelay)
		{
			self displaylockoncanceledmessage();
			continue;
		}

		self destroylockoncanceledmessage();
		initlockfield(besttarget);
		self.hackertooltarget = besttarget;
		self.hackertoollockstarttime = GetTime();
		self.hackertoollockstarted = 1;
		self.hackertoollostsightlinetime = 0;
		self.hackertoollocktimeelapsed = 0;
		self setweaponheatpercent("pda_hack_mp",0);
		self thread looplocalseeksound(game["locking_on_sound"],0.6);
	}
}

//Function Number: 11
getbesthackertooltarget()
{
	targetsvalid = [];
	targetsall = arraycombine(target_getarray(),level.missileentities,0,0);
	targetsall = arraycombine(targetsall,level.hackertooltargets,0,0);
	for(idx = 0;idx < targetsall.size;idx++)
	{
		target_ent = targetsall[idx];
		if(!IsDefined(target_ent) || !IsDefined(target_ent.owner))
		{
		}
		else
		{
/#
			if(GetDvar(#"4C560F97") == "1")
			{
				if(self iswithinhackertoolreticle(targetsall[idx]))
				{
					targetsvalid[targetsvalid.size] = targetsall[idx];
				}
			}
			else
			{
#/
				if(level.teambased)
				{
					if(isentityhackablecarepackage(target_ent))
					{
						if(self iswithinhackertoolreticle(target_ent))
						{
							targetsvalid[targetsvalid.size] = target_ent;
						}

						continue;
					}

					if(IsDefined(target_ent.team))
					{
						if(target_ent.team != self.team)
						{
							if(self iswithinhackertoolreticle(target_ent))
							{
								targetsvalid[targetsvalid.size] = target_ent;
							}
						}

						continue;
					}

					if(IsDefined(target_ent.owner.team))
					{
						if(target_ent.owner.team != self.team)
						{
							if(self iswithinhackertoolreticle(target_ent))
							{
								targetsvalid[targetsvalid.size] = target_ent;
							}
						}
					}
				}
				else if(self iswithinhackertoolreticle(target_ent))
				{
					if(isentityhackablecarepackage(target_ent))
					{
						targetsvalid[targetsvalid.size] = target_ent;
					}
					else if(IsDefined(target_ent.owner) && self != target_ent.owner)
					{
						targetsvalid[targetsvalid.size] = target_ent;
					}
				}
			}
		}
	}

	chosenent = undefined;
	if(targetsvalid.size != 0)
	{
		chosenent = targetsvalid[0];
	}

	return chosenent;
}

//Function Number: 12
iswithinhackertoolreticle(target)
{
	radius = gethackertoolradius(target);
	return target_isincircle(target,self,level.hackertoollockonfov,radius,0);
}

//Function Number: 13
isentityhackableweaponobject(entity)
{
	if(IsDefined(entity.classname) && entity.classname == "grenade")
	{
		if(IsDefined(entity.name))
		{
			watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcherbyweapon(entity.name);
			if(IsDefined(watcher))
			{
				if(watcher.hackable)
				{
/#
/#
					assert(IsDefined(watcher.hackertoolradius));
#/
/#
					assert(IsDefined(watcher.hackertooltimems));
#/
#/
					return 1;
				}
			}
		}
	}
}

//Function Number: 14
getweaponobjecthackerradius(entity)
{
/#
/#
	assert(IsDefined(entity.classname));
#/
/#
	assert(IsDefined(entity.name));
#/
#/
	watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcherbyweapon(entity.name);
/#
/#
	assert(watcher.hackable);
#/
/#
	assert(IsDefined(watcher.hackertoolradius));
#/
#/
	return watcher.hackertoolradius;
}

//Function Number: 15
getweaponobjecthacktimems(entity)
{
/#
/#
	assert(IsDefined(entity.classname));
#/
/#
	assert(IsDefined(entity.name));
#/
#/
	watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcherbyweapon(entity.name);
/#
/#
	assert(watcher.hackable);
#/
/#
	assert(IsDefined(watcher.hackertooltimems));
#/
#/
	return watcher.hackertooltimems;
}

//Function Number: 16
isentityhackablecarepackage(entity)
{
	if(IsDefined(entity.model))
	{
		return entity.model == "t6_wpn_supply_drop_ally";
	}
	else
	{
		return 0;
	}
}

//Function Number: 17
isvalidhackertooltarget(ent)
{
	if(!(IsDefined(ent)))
	{
		return 0;
	}

	if(self isusingremote())
	{
		return 0;
	}

	if(self isempjammed())
	{
		return 0;
	}

	if(!target_istarget(ent) && !isentityhackableweaponobject(ent) && !isinarray(level.hackertooltargets,ent))
	{
		return 0;
	}

	if(isentityhackableweaponobject(ent))
	{
		if(distancesquared(self.origin,ent.origin) > level.hackertoolmaxequipmentdistancesq)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 18
hackersoftsighttest()
{
	passed = 1;
	locklengthms = 0;
	if(IsDefined(self.hackertooltarget))
	{
		locklengthms = self gethacktime(self.hackertooltarget);
	}

	if(self isempjammed() || locklengthms == 0)
	{
		self clearhackertarget();
		passed = 0;
	}
	else if(iswithinhackertoolreticle(self.hackertooltarget))
	{
		self.hackertoollostsightlinetime = 0;
	}
	else
	{
		if(self.hackertoollostsightlinetime == 0)
		{
			self.hackertoollostsightlinetime = GetTime();
		}

		timepassed = GetTime() - self.hackertoollostsightlinetime;
		if(timepassed >= level.hackertoollostsightlimitms)
		{
			self clearhackertarget();
			passed = 0;
		}
	}

	return passed;
}

//Function Number: 19
registerwithhackertool(radius,hacktimems)
{
	self endon("death");
	if(IsDefined(radius))
	{
		self.hackertoolradius = radius;
	}
	else
	{
		self.hackertoolradius = level.hackertoollockonradius;
	}

	if(IsDefined(hacktimems))
	{
		self.hackertooltimems = hacktimems;
	}
	else
	{
		self.hackertooltimems = level.hackertoolhacktimems;
	}

	self thread watchhackableentitydeath();
	level.hackertooltargets[level.hackertooltargets.size] = self;
}

//Function Number: 20
watchhackableentitydeath()
{
	self waittill("death");
	arrayremovevalue(level.hackertooltargets,self);
}

//Function Number: 21
gethackertoolradius(target)
{
	radius = 20;
	if(isentityhackablecarepackage(target))
	{
/#
/#
		assert(IsDefined(target.hackertoolradius));
#/
#/
		radius = target.hackertoolradius;
	}
	else if(isentityhackableweaponobject(target))
	{
		radius = getweaponobjecthackerradius(target);
	}
	else if(IsDefined(target.hackertoolradius))
	{
		radius = target.hackertoolradius;
	}
	else
	{
		radius = level.vehiclehackertoolradius;
		switch(target.model)
		{
			case "veh_t6_drone_uav":
					radius = level.uavhackertoolradius;
					break;

			case "veh_t6_drone_cuav":
					radius = level.cuavhackertoolradius;
					break;

			case "t5_veh_rcbomb_axis":
					radius = level.rcxdhackertoolradius;
					break;

			case "veh_iw_mh6_littlebird_mp":
					radius = level.carepackagechopperhackertoolradius;
					break;

			case "veh_t6_drone_quad_rotor_mp":
			case "veh_t6_drone_quad_rotor_mp_alt":
					radius = level.qrdronehackertoolradius;
					break;

			case "veh_t6_drone_tank":
			case "veh_t6_drone_tank_alt":
					radius = level.aitankhackertoolradius;
					break;

			case "veh_t6_air_attack_heli_mp_dark":
			case "veh_t6_air_attack_heli_mp_light":
					radius = level.stealthchopperhackertoolradius;
					break;

			case "veh_t6_drone_overwatch_dark":
			case "veh_t6_drone_overwatch_light":
					radius = level.littlebirdhackertoolradius;
					break;

			case "veh_t6_drone_pegasus":
					radius = level.lodestarhackertoolradius;
					break;

			case "veh_iw_air_apache_killstreak":
					radius = level.choppergunnerhackertoolradius;
					break;

			case "veh_t6_air_a10f":
			case "veh_t6_air_a10f_alt":
					radius = level.warthoghackertoolradius;
					break;
		}
	}

	return radius;
}

//Function Number: 22
gethacktime(target)
{
	time = 500;
	if(isentityhackablecarepackage(target))
	{
/#
/#
		assert(IsDefined(target.hackertooltimems));
#/
#/
		if(IsDefined(target.owner) && target.owner == self)
		{
			time = level.carepackageownerhackertooltimems;
		}
		else if(IsDefined(target.owner) && target.owner.team == self.team)
		{
			time = level.carepackagefriendlyhackertooltimems;
		}
		else
		{
			time = level.carepackagehackertooltimems;
		}
	}
	else if(isentityhackableweaponobject(target))
	{
		time = getweaponobjecthacktimems(target);
	}
	else if(IsDefined(target.hackertooltimems))
	{
		time = target.hackertooltimems;
	}
	else
	{
		time = level.vehiclehackertooltimems;
		switch(target.model)
		{
			case "veh_t6_drone_uav":
					time = level.uavhackertooltimems;
					break;

			case "veh_t6_drone_cuav":
					time = level.cuavhackertooltimems;
					break;

			case "t5_veh_rcbomb_axis":
					time = level.rcxdhackertooltimems;
					break;

			case "veh_t6_drone_supply_alt":
			case "veh_t6_drone_supply_alt":
					time = level.carepackagechopperhackertooltimems;
					break;

			case "veh_t6_drone_quad_rotor_mp":
			case "veh_t6_drone_quad_rotor_mp_alt":
					time = level.qrdronehackertooltimems;
					break;

			case "veh_t6_drone_tank":
			case "veh_t6_drone_tank_alt":
					time = level.aitankhackertooltimems;
					break;

			case "veh_t6_air_attack_heli_mp_dark":
			case "veh_t6_air_attack_heli_mp_light":
					time = level.stealthchopperhackertooltimems;
					break;

			case "veh_t6_drone_overwatch_dark":
			case "veh_t6_drone_overwatch_light":
					time = level.littlebirdhackertooltimems;
					break;

			case "veh_t6_drone_pegasus":
					time = level.lodestarhackertooltimems;
					break;

			case "veh_t6_air_v78_vtol_killstreak":
			case "veh_t6_air_v78_vtol_killstreak_alt":
					time = level.choppergunnerhackertooltimems;
					break;

			case "veh_t6_air_a10f":
			case "veh_t6_air_a10f_alt":
					time = level.warthoghackertooltimems;
					break;
		}
	}

	return time;
}

//Function Number: 23
tunables()
{
/#
	while(1)
	{
		level.hackertoollostsightlimitms = weapons_get_dvar_int("scr_hackerToolLostSightLimitMs",1000);
		level.hackertoollockonradius = weapons_get_dvar("scr_hackerToolLockOnRadius",20);
		level.hackertoollockonfov = weapons_get_dvar_int("scr_hackerToolLockOnFOV",65);
		level.rcxd_time = weapons_get_dvar("scr_rcxd_time",1.5);
		level.uav_time = weapons_get_dvar_int("scr_uav_time",4);
		level.cuav_time = weapons_get_dvar_int("scr_cuav_time",4);
		level.care_package_chopper_time = weapons_get_dvar_int("scr_care_package_chopper_time",3);
		level.guardian_time = weapons_get_dvar_int("scr_guardian_time",5);
		level.sentry_time = weapons_get_dvar_int("scr_sentry_time",5);
		level.wasp_time = weapons_get_dvar_int("scr_wasp_time",5);
		level.agr_time = weapons_get_dvar_int("scr_agr_time",5);
		level.stealth_helicopter_time = weapons_get_dvar_int("scr_stealth_helicopter_time",7);
		level.escort_drone_time = weapons_get_dvar_int("scr_escort_drone_time",7);
		level.warthog_time = weapons_get_dvar_int("scr_warthog_time",7);
		level.lodestar_time = weapons_get_dvar_int("scr_lodestar_time",7);
		level.chopper_gunner_time = weapons_get_dvar_int("scr_chopper_gunner_time",7);
		wait(1);
	}
#/
}