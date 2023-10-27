/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_heatseekingmissile.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 131 ms
 * Timestamp: 10/27/2023 3:01:25 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_weapon_utils;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_helicopter;

//Function Number: 1
init()
{
	precacherumble("stinger_lock_rumble");
	game["locking_on_sound"] = "uin_alert_lockon_start";
	game["locked_on_sound"] = "uin_alert_lockon";
	precachestring(&"MP_CANNOT_LOCKON_TO_TARGET");
	thread onplayerconnect();
	level.fx_flare = loadfx("vehicle/vexplosion/fx_heli_chaff");
/#
	setdvar("scr_freelock","0");
#/
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
		self clearirtarget();
		thread stingertoggleloop();
		self thread stingerfirednotify();
	}
}

//Function Number: 4
clearirtarget()
{
	self notify("stinger_irt_cleartarget");
	self notify("stop_lockon_sound");
	self notify("stop_locked_sound");
	self.stingerlocksound = undefined;
	self stoprumble("stinger_lock_rumble");
	self.stingerlockstarttime = 0;
	self.stingerlockstarted = 0;
	self.stingerlockfinalized = 0;
	if(IsDefined(self.stingertarget))
	{
		lockingon(self.stingertarget,0);
		lockedon(self.stingertarget,0);
	}

	self.stingertarget = undefined;
	self weaponlockfree();
	self weaponlocktargettooclose(0);
	self weaponlocknoclearance(0);
	self stoplocalsound(game["locking_on_sound"]);
	self stoplocalsound(game["locked_on_sound"]);
	self destroylockoncanceledmessage();
}

//Function Number: 5
stingerfirednotify()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		self waittill("missile_fire",missile,weap);
		if(maps/mp/gametypes/_weapon_utils::isguidedrocketlauncherweapon(weap))
		{
			if(IsDefined(self.stingertarget) && self.stingerlockfinalized)
			{
				self.stingertarget notify("stinger_fired_at_me",missile,weap,self);
			}

			level notify("missile_fired",self,missile,self.stingertarget,self.stingerlockfinalized);
			self notify("stinger_fired",missile,weap);
		}
	}
}

//Function Number: 6
stingertoggleloop()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self waittill("weapon_change",weapon);
		while(maps/mp/gametypes/_weapon_utils::isguidedrocketlauncherweapon(weapon))
		{
			abort = 0;
			while(!(self playerstingerads()))
			{
				wait(0.05);
				if(!(maps/mp/gametypes/_weapon_utils::isguidedrocketlauncherweapon(self getcurrentweapon())))
				{
					abort = 1;
					break;
				}
			}

			if(abort)
			{
				break;
			}

			self thread stingerirtloop();
			while(self playerstingerads())
			{
				wait(0.05);
			}

			self notify("stinger_IRT_off");
			self clearirtarget();
			weapon = self getcurrentweapon();
		}
	}
}

//Function Number: 7
stingerirtloop()
{
	self endon("disconnect");
	self endon("death");
	self endon("stinger_IRT_off");
	locklength = self getlockonspeed();
	for(;;)
	{
		wait(0.05);
		if(self.stingerlockfinalized)
		{
			passed = softsighttest();
			if(!(passed))
			{
				continue;
			}

			if(!(isstillvalidtarget(self.stingertarget)))
			{
				self clearirtarget();
				continue;
			}

			if(!(self.stingertarget.locked_on))
			{
				self.stingertarget notify("missile_lock",self);
			}

			lockingon(self.stingertarget,0);
			lockedon(self.stingertarget,1);
			thread looplocallocksound(game["locked_on_sound"],0.75);
			continue;
		}

		if(self.stingerlockstarted)
		{
			if(!(isstillvalidtarget(self.stingertarget)))
			{
				self clearirtarget();
				continue;
			}

			lockingon(self.stingertarget,1);
			lockedon(self.stingertarget,0);
			passed = softsighttest();
			if(!(passed))
			{
				continue;
			}

			timepassed = GetTime() - self.stingerlockstarttime;
			if(timepassed < locklength)
			{
				continue;
			}

/#
			assert(IsDefined(self.stingertarget));
#/
			self notify("stop_lockon_sound");
			self.stingerlockfinalized = 1;
			self weaponlockfinalize(self.stingertarget);
			continue;
		}

		besttarget = self getbeststingertarget();
		if(!(IsDefined(besttarget)))
		{
			self destroylockoncanceledmessage();
			continue;
		}

		if(!(self locksighttest(besttarget)))
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
		self.stingertarget = besttarget;
		self.stingerlockstarttime = GetTime();
		self.stingerlockstarted = 1;
		self.stingerlostsightlinetime = 0;
		self thread looplocalseeksound(game["locking_on_sound"],0.6);
	}
}

//Function Number: 8
destroylockoncanceledmessage()
{
	if(IsDefined(self.lockoncanceledmessage))
	{
		self.lockoncanceledmessage destroy();
	}
}

//Function Number: 9
displaylockoncanceledmessage()
{
	if(IsDefined(self.lockoncanceledmessage))
	{
		return;
	}

	self.lockoncanceledmessage = newclienthudelem(self);
	self.lockoncanceledmessage.fontscale = 1.25;
	self.lockoncanceledmessage.x = 0;
	self.lockoncanceledmessage.y = 50;
	self.lockoncanceledmessage.alignx = "center";
	self.lockoncanceledmessage.aligny = "top";
	self.lockoncanceledmessage.horzalign = "center";
	self.lockoncanceledmessage.vertalign = "top";
	self.lockoncanceledmessage.foreground = 1;
	self.lockoncanceledmessage.hidewhendead = 0;
	self.lockoncanceledmessage.hidewheninmenu = 1;
	self.lockoncanceledmessage.archived = 0;
	self.lockoncanceledmessage.alpha = 1;
	self.lockoncanceledmessage settext(&"MP_CANNOT_LOCKON_TO_TARGET");
}

//Function Number: 10
getbeststingertarget()
{
	targetsall = target_getarray();
	targetsvalid = [];
	for(idx = 0;idx < targetsall.size;idx++)
	{
/#
		targetsvalid[targetsvalid.size] = targetsall[idx];
self insidestingerreticlenolock(targetsall[idx])
GetDvar(#"4C560F97") == "1"
#/
		if(level.teambased)
		{
			if(IsDefined(targetsall[idx].team) && targetsall[idx].team != self.team)
			{
				if(self insidestingerreticlenolock(targetsall[idx]))
				{
					targetsvalid[targetsvalid.size] = targetsall[idx];
				}
			}
		}
		else if(self insidestingerreticlenolock(targetsall[idx]))
		{
			if(IsDefined(targetsall[idx].owner) && self != targetsall[idx].owner)
			{
				targetsvalid[targetsvalid.size] = targetsall[idx];
			}
		}
	}

	if(targetsvalid.size == 0)
	{
		return undefined;
	}

	chosenent = targetsvalid[0];
	if(targetsvalid.size > 1)
	{
	}

	return chosenent;
}

//Function Number: 11
insidestingerreticlenolock(target)
{
	radius = self getlockonradius();
	return target_isincircle(target,self,65,radius);
}

//Function Number: 12
insidestingerreticlelocked(target)
{
	radius = self getlockonradius();
	return target_isincircle(target,self,65,radius);
}

//Function Number: 13
isstillvalidtarget(ent)
{
	if(!(IsDefined(ent)))
	{
		return 0;
	}

	if(!(target_istarget(ent)))
	{
		return 0;
	}

	if(!(insidestingerreticlelocked(ent)))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
playerstingerads()
{
	return self playerads() == 1;
}

//Function Number: 15
looplocalseeksound(alias,interval)
{
	self endon("stop_lockon_sound");
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self playlocalsound(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 2);
	}
}

//Function Number: 16
looplocallocksound(alias,interval)
{
	self endon("stop_locked_sound");
	self endon("disconnect");
	self endon("death");
	if(IsDefined(self.stingerlocksound))
	{
		return;
	}

	self.stingerlocksound = 1;
	for(;;)
	{
		self playlocalsound(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 6);
		self playlocalsound(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 6);
		self playlocalsound(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 6);
		self stoprumble("stinger_lock_rumble");
	}

	self.stingerlocksound = undefined;
}

//Function Number: 17
locksighttest(target)
{
	eyepos = self geteye();
	if(!(IsDefined(target)))
	{
		return 0;
	}

	passed = bullettracepassed(eyepos,target.origin,0,target);
	if(passed)
	{
		return 1;
	}

	front = target getpointinbounds(1,0,0);
	passed = bullettracepassed(eyepos,front,0,target);
	if(passed)
	{
		return 1;
	}

	back = target getpointinbounds(-1,0,0);
	passed = bullettracepassed(eyepos,back,0,target);
	if(passed)
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
softsighttest()
{
	lost_sight_limit = 500;
	if(self locksighttest(self.stingertarget))
	{
		self.stingerlostsightlinetime = 0;
		return 1;
	}

	if(self.stingerlostsightlinetime == 0)
	{
		self.stingerlostsightlinetime = GetTime();
	}

	timepassed = GetTime() - self.stingerlostsightlinetime;
	if(timepassed >= lost_sight_limit)
	{
		self clearirtarget();
		return 0;
	}

	return 1;
}

//Function Number: 19
initlockfield(target)
{
	if(IsDefined(target.locking_on))
	{
		return;
	}

	target.locking_on = 0;
	target.locked_on = 0;
}

//Function Number: 20
lockingon(target,lock)
{
/#
	assert(IsDefined(target.locking_on));
#/
	clientnum = self getentitynumber();
	if(lock)
	{
		target notify("locking on");
		target.locking_on = target.locking_on | 1 << clientnum;
		self thread watchclearlockingon(target,clientnum);
	}
	else
	{
		self notify("locking_on_cleared");
		target.locking_on = target.locking_on & ~1 << clientnum;
	}
}

//Function Number: 21
watchclearlockingon(target,clientnum)
{
	target endon("death");
	self endon("locking_on_cleared");
	self waittill_any("death","disconnect");
	target.locking_on = target.locking_on & ~1 << clientnum;
}

//Function Number: 22
lockedon(target,lock)
{
/#
	assert(IsDefined(target.locked_on));
#/
	clientnum = self getentitynumber();
	if(lock)
	{
		target.locked_on = target.locked_on | 1 << clientnum;
		self thread watchclearlockedon(target,clientnum);
	}
	else
	{
		self notify("locked_on_cleared");
		target.locked_on = target.locked_on & ~1 << clientnum;
	}
}

//Function Number: 23
watchclearlockedon(target,clientnum)
{
	self endon("locked_on_cleared");
	self waittill_any("death","disconnect");
	if(IsDefined(target))
	{
		target.locked_on = target.locked_on & ~1 << clientnum;
	}
}

//Function Number: 24
missiletarget_lockonmonitor(player,endon1,endon2)
{
	self endon("death");
	if(IsDefined(endon1))
	{
		self endon(endon1);
	}

	if(IsDefined(endon2))
	{
		self endon(endon2);
	}

	for(;;)
	{
		if(target_istarget(self))
		{
		}

		wait(0.1);
	}
}

//Function Number: 25
_incomingmissile(missile)
{
	if(!(IsDefined(self.incoming_missile)))
	{
		self.incoming_missile = 0;
	}

	self.incoming_missile++;
	self thread _incomingmissiletracker(missile);
}

//Function Number: 26
_incomingmissiletracker(missile)
{
	self endon("death");
	missile waittill("death");
	self.incoming_missile--;
/#
	assert(self.incoming_missile >= 0);
#/
}

//Function Number: 27
missiletarget_ismissileincoming()
{
	if(!(IsDefined(self.incoming_missile)))
	{
		return 0;
	}

	if(self.incoming_missile)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
missiletarget_handleincomingmissile(responsefunc,endon1,endon2)
{
	level endon("game_ended");
	self endon("death");
	if(IsDefined(endon1))
	{
		self endon(endon1);
	}

	if(IsDefined(endon2))
	{
		self endon(endon2);
	}

	for(;;)
	{
		self waittill("stinger_fired_at_me",missile,weap,attacker);
		_incomingmissile(missile);
		if(IsDefined(responsefunc))
		{
			[[ responsefunc ]](missile,attacker,weap,endon1,endon2);
		}
	}
}

//Function Number: 29
missiletarget_proximitydetonateincomingmissile(endon1,endon2)
{
	missiletarget_handleincomingmissile(::missiletarget_proximitydetonate,endon1,endon2);
}

//Function Number: 30
_missiledetonate(attacker,weapon)
{
	self endon("death");
	radiusdamage(self.origin,500,600,600,attacker,undefined,weapon);
	wait(0.05);
	self detonate();
	wait(0.05);
	self delete();
}

//Function Number: 31
missiletarget_proximitydetonate(missile,attacker,weapon,endon1,endon2)
{
	level endon("game_ended");
	missile endon("death");
	if(IsDefined(endon1))
	{
		self endon(endon1);
	}

	if(IsDefined(endon2))
	{
		self endon(endon2);
	}

	mindist = distance(missile.origin,self.origin);
	lastcenter = self.origin;
	missile missile_settarget(self);
	for(;;)
	{
		if(!(IsDefined(self)))
		{
			center = lastcenter;
		}
		else
		{
			center = self.origin;
		}

		lastcenter = center;
		curdist = distance(missile.origin,center);
		if(curdist < 3500 && IsDefined(self.numflares) && self.numflares > 0)
		{
			self.numflares--;
			self thread missiletarget_playflarefx();
			self maps/mp/killstreaks/_helicopter::trackassists(attacker,0,1);
			newtarget = self missiletarget_deployflares(missile.origin,missile.angles);
			missile missile_settarget(newtarget);
			missiletarget = newtarget;
			return;
		}

		if(curdist < mindist)
		{
			mindist = curdist;
		}

		if(curdist > mindist)
		{
			if(curdist > 500)
			{
				return;
			}

			missile thread _missiledetonate(attacker,weapon);
		}

		wait(0.05);
	}
}

//Function Number: 32
missiletarget_playflarefx()
{
	if(!(IsDefined(self)))
	{
		return;
	}

	flare_fx = level.fx_flare;
	if(IsDefined(self.fx_flare))
	{
		flare_fx = self.fx_flare;
	}

	if(IsDefined(self.flare_ent))
	{
		playfxontag(flare_fx,self.flare_ent,"tag_origin");
	}
	else
	{
		playfxontag(flare_fx,self,"tag_origin");
	}

	if(IsDefined(self.owner))
	{
		self playsoundtoplayer("veh_huey_chaff_drop_plr",self.owner);
	}

	self playsound("veh_huey_chaff_explo_npc");
}

//Function Number: 33
missiletarget_deployflares(origin,angles)
{
	vec_toforward = AnglesToForward(self.angles);
	vec_toright = AnglesToRight(self.angles);
	vec_tomissileforward = AnglesToForward(angles);
	delta = self.origin - origin;
	dot = vectordot(vec_tomissileforward,vec_toright);
	sign = 1;
	if(dot > 0)
	{
		sign = -1;
	}

	flare_dir = vectornormalize(sign + VectorScale(vec_toright));
	velocity = VectorScale(flare_dir);
	velocity = (velocity[0],velocity[1],velocity[2] - randomintrange(10,100));
	flareorigin = self.origin;
	flareorigin = randomintrange(500,700) + VectorScale(flare_dir);
	flareorigin = 500 + VectorScale((0,0,1));
	if(IsDefined(self.flareoffset))
	{
		flareorigin = flareorigin + self.flareoffset;
	}

	flareobject = spawn("script_origin",flareorigin);
	flareobject.angles = self.angles;
	flareobject setmodel("tag_origin");
	flareobject movegravity(velocity,5);
	flareobject thread deleteaftertime(5);
	self thread debug_tracker(flareobject);
	return flareobject;
}

//Function Number: 34
debug_tracker(target)
{
	target endon("death");
	while(1)
	{
		maps/mp/killstreaks/_airsupport::debug_sphere(target.origin,10,(1,0,0),1,1);
		wait(0.05);
	}
}