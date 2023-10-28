/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_proximity_grenade.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 16
 * Decompile Time: 2 ms
 * Timestamp: 10/28/2023 12:13:50 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_weaponobjects;

//Function Number: 1
init()
{
	precacheshader("gfx_fxt_fx_screen_droplets_02");
	precacherumble("proximity_grenade");
	precacheitem("proximity_grenade_aoe_mp");
	level._effect["prox_grenade_friendly_default"] = loadfx("weapon/grenade/fx_prox_grenade_scan_grn");
	level._effect["prox_grenade_friendly_warning"] = loadfx("weapon/grenade/fx_prox_grenade_wrn_grn");
	level._effect["prox_grenade_enemy_default"] = loadfx("weapon/grenade/fx_prox_grenade_scan_red");
	level._effect["prox_grenade_enemy_warning"] = loadfx("weapon/grenade/fx_prox_grenade_wrn_red");
	level._effect["prox_grenade_player_shock"] = loadfx("weapon/grenade/fx_prox_grenade_impact_player_spwner");
	level.proximitygrenadedetectionradius = weapons_get_dvar_int("scr_proximityGrenadeDetectionRadius","150");
	level.proximitygrenadegraceperiod = weapons_get_dvar("scr_proximityGrenadeGracePeriod",0.1);
	level.proximitygrenadedamageradius = weapons_get_dvar_int("scr_proximityGrenadeDamageRadius","200");
	level.proximitygrenadedotdamageamount = weapons_get_dvar_int("scr_proximityGrenadeDOTDamageAmount","1");
	level.proximitygrenadedotdamageamounthardcore = weapons_get_dvar_int("scr_proximityGrenadeDOTDamageAmountHardcore","1");
	level.proximitygrenadedotdamagetime = weapons_get_dvar("scr_proximityGrenadeDOTDamageTime",0.15);
	level.proximitygrenadedotdamageinstances = weapons_get_dvar_int("scr_proximityGrenadeDOTDamageInstances","4");
	level.proximitygrenademaxinstances = weapons_get_dvar_int("scr_proximityGrenadeMaxInstances","3");
	level.proximitygrenadeeffectdebug = weapons_get_dvar_int("scr_proximityGrenadeEffectDebug","0");
	level.proximitygrenadeactivationtime = weapons_get_dvar("scr_proximityGrenadeActivationTime",0.1);
	level.poisonfxduration = 6;
/#
	level thread updatedvars();
#/
}

//Function Number: 2
register()
{
	registerclientfield("toplayer","tazered",1000,1,"int");
}

//Function Number: 3
updatedvars()
{
	while(1)
	{
		level.proximitygrenadedetectionradius = weapons_get_dvar_int("scr_proximityGrenadeDetectionRadius",level.proximitygrenadedetectionradius);
		level.proximitygrenadegraceperiod = weapons_get_dvar("scr_proximityGrenadeGracePeriod",level.proximitygrenadegraceperiod);
		level.proximitygrenadedamageradius = weapons_get_dvar_int("scr_proximityGrenadeDamageRadius",level.proximitygrenadedamageradius);
		level.proximitygrenadedotdamageamount = weapons_get_dvar_int("scr_proximityGrenadeDOTDamageAmount",level.proximitygrenadedotdamageamount);
		level.proximitygrenadedotdamageamounthardcore = weapons_get_dvar_int("scr_proximityGrenadeDOTDamageAmountHardcore",level.proximitygrenadedotdamageamounthardcore);
		level.proximitygrenadedotdamagetime = weapons_get_dvar("scr_proximityGrenadeDOTDamageTime",level.proximitygrenadedotdamagetime);
		level.proximitygrenadedotdamageinstances = weapons_get_dvar_int("scr_proximityGrenadeDOTDamageInstances",level.proximitygrenadedotdamageinstances);
		level.proximitygrenademaxinstances = weapons_get_dvar_int("scr_proximityGrenadeMaxInstances",level.proximitygrenademaxinstances);
		level.proximitygrenadeeffectdebug = weapons_get_dvar_int("scr_proximityGrenadeEffectDebug",level.proximitygrenadeeffectdebug);
		level.proximitygrenadeactivationtime = weapons_get_dvar("scr_proximityGrenadeActivationTime",level.proximitygrenadeactivationtime);
		wait(1);
	}
}

//Function Number: 4
createproximitygrenadewatcher()
{
	watcher = self maps/mp/gametypes/_weaponobjects::createproximityweaponobjectwatcher("proximity_grenade","proximity_grenade_mp",self.team);
	watcher.watchforfire = 1;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.headicon = 0;
	watcher.reconmodel = "t6_wpn_taser_mine_world_detect";
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
	watcher.detonateradius = level.proximitygrenadedetectionradius;
	watcher.stun = maps/mp/gametypes/_weaponobjects::weaponstun;
	watcher.stuntime = 1;
	watcher.detonate = ::proximitydetonate;
	watcher.activationdelay = level.proximitygrenadeactivationtime;
	watcher.onspawn = ::onspawnproximitygrenadeweaponobject;
}

//Function Number: 5
onspawnproximitygrenadeweaponobject(watcher,owner)
{
	self thread setupkillcament();
	owner addweaponstat("proximity_grenade_mp","used",1);
	onspawnproximityweaponobject(watcher,owner);
}

//Function Number: 6
setupkillcament()
{
	self endon("death");
	self waittillnotmoving();
	self.killcament = spawn("script_model",8 + VectorScale((0,0,1)));
	self thread cleanupkillcamentondeath();
}

//Function Number: 7
cleanupkillcamentondeath()
{
	self waittill("death");
	self.killcament deleteaftertime(3 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
}

//Function Number: 8
proximitydetonate(attacker,weaponname)
{
	if(IsDefined(weaponname))
	{
		if(IsDefined(attacker))
		{
			if(self.owner isenemyplayer(attacker))
			{
				attacker maps/mp/_challenges::destroyedexplosive(weaponname);
				maps/mp/_scoreevents::processscoreevent("destroyed_proxy",attacker,self.owner,weaponname);
			}
		}
	}

	maps/mp/gametypes/_weaponobjects::weapondetonate(attacker,weaponname);
}

//Function Number: 9
proximitygrenadedamageplayer(eattacker,einflictor)
{
	if(!(self hasperk("specialty_proximityprotection")))
	{
		if(!(level.proximitygrenadeeffectdebug))
		{
			self thread damageplayerinradius(einflictor.origin,eattacker,einflictor);
		}
	}
}

//Function Number: 10
watchproximitygrenadehitplayer(owner)
{
	self endon("death");
	self setowner(owner);
	self setteam(owner.team);
	while(1)
	{
		self waittill("grenade_bounce",pos,normal,ent,surface);
		if(IsDefined(ent) && isplayer(ent) && surface != "riotshield")
		{
			if(level.teambased && ent.team == self.owner.team)
			{
				continue;
			}

			self proximitydetonate(self.owner,undefined);
			return;
		}
	}
}

//Function Number: 11
performhudeffects(position,distancetogrenade)
{
	forwardvec = vectornormalize(AnglesToForward(self.angles));
	rightvec = vectornormalize(AnglesToRight(self.angles));
	explosionvec = vectornormalize(position - self.origin);
	fdot = vectordot(explosionvec,forwardvec);
	rdot = vectordot(explosionvec,rightvec);
	fangle = acos(fdot);
	rangle = acos(rdot);
}

//Function Number: 12
damageplayerinradius(position,owner,einflictor)
{
	self notify("proximityGrenadeDamageStart");
	self endon("proximityGrenadeDamageStart");
	self endon("disconnect");
	self endon("death");
	owner endon("disconnect");
	self thread watch_death();
	if(!(IsDefined(einflictor.killcament)))
	{
		killcament = spawn("script_model",8 + VectorScale((0,0,1)));
		killcament deleteaftertime(3 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
		killcament.soundmod = "taser_spike";
	}
	else
	{
		killcament = einflictor.killcament;
		killcament.soundmod = "taser_spike";
	}

	damage = level.proximitygrenadedotdamageamount;
	playfxontag(level._effect["prox_grenade_player_shock"],self,"J_SpineUpper");
	if(level.hardcoremode)
	{
		damage = level.proximitygrenadedotdamageamounthardcore;
	}

	if(self mayapplyscreeneffect())
	{
		shellshock_duration = 1.5;
		self shellshock("proximity_grenade",shellshock_duration,0);
		self setclientfieldtoplayer("tazered",1);
	}

	self playrumbleonentity("proximity_grenade");
	self playsound("wpn_taser_mine_zap");
	self setclientuivisibilityflag("hud_visible",0);
	for(i = 0;i < level.proximitygrenadedotdamageinstances;i++)
	{
		wait(level.proximitygrenadedotdamagetime);
/#
		assert(IsDefined(owner));
#/
/#
		assert(IsDefined(killcament));
#/
		self dodamage(damage,position,owner,killcament,"none","MOD_GAS",0,"proximity_grenade_aoe_mp");
	}

	wait(0.85);
	self shellshock("proximity_grenade_exit",0.6,0);
	self setclientuivisibilityflag("hud_visible",1);
	self setclientfieldtoplayer("tazered",0);
}

//Function Number: 13
deleteentonownerdeath(owner)
{
	self thread deleteentontimeout();
	self thread deleteentaftertime();
	self endon("delete");
	owner waittill("death");
	self notify("deleteSound");
}

//Function Number: 14
deleteentaftertime()
{
	self endon("delete");
	wait(10);
	self notify("deleteSound");
}

//Function Number: 15
deleteentontimeout()
{
	self endon("delete");
	self waittill("deleteSound");
	self delete();
}

//Function Number: 16
watch_death()
{
	self waittill("death");
	self stoprumble("proximity_grenade");
	self setblur(0,0);
	self setclientuivisibilityflag("hud_visible",1);
	self setclientfieldtoplayer("tazered",0);
}