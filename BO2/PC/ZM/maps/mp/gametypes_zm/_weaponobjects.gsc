/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_weaponobjects.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 97
 * Decompile Time: 31 ms
 * Timestamp: 10/28/2023 12:11:40 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_ballistic_knife;
#include maps/mp/_challenges;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_damagefeedback;
#include maps/mp/gametypes_zm/_globallogic_audio;
#include maps/mp/gametypes_zm/_globallogic_player;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_weaponobjects;

//Function Number: 1
init()
{
/#
	debug = weapons_get_dvar_int("scr_weaponobject_debug","0");
#/
	coneangle = weapons_get_dvar_int("scr_weaponobject_coneangle","70");
	mindist = weapons_get_dvar_int("scr_weaponobject_mindist","20");
	graceperiod = weapons_get_dvar("scr_weaponobject_graceperiod","0.6");
	radius = weapons_get_dvar_int("scr_weaponobject_radius","192");
	level thread onplayerconnect();
	level.watcherweapons = [];
	level.watcherweapons = getwatcherweapons();
	level.watcherweaponnames = [];
	level.watcherweaponnames = getwatchernames(level.watcherweapons);
	level.retrievableweapons = [];
	level.retrievableweapons = getretrievableweapons();
	level.retrievableweaponnames = [];
	level.retrievableweaponnames = getwatchernames(level.retrievableweapons);
	level.weaponobjects_headicon_offset = [];
	level.weaponobjects_headicon_offset["default"] = VectorScale((0,0,1));
	level.weaponobjectexplodethisframe = 0;
	if(GetDvar(#"8E9CA497") == "")
	{
		setdvar("scr_deleteexplosivesonspawn",1);
	}

	level.deleteexplosivesonspawn = GetDvarInt(#"8E9CA497");
	if(sessionmodeiszombiesgame())
	{
		return;
	}

	precachestring(&"MP_DEFUSING_EXPLOSIVE");
	level.claymorefxid = loadfx("weapon/claymore/fx_claymore_laser");
	level._equipment_spark_fx = loadfx("weapon/grenade/fx_spark_disabled_weapon");
	level._equipment_emp_destroy_fx = loadfx("weapon/emp/fx_emp_explosion_equip");
	level._equipment_explode_fx = loadfx("explosions/fx_exp_equipment");
	level._equipment_explode_fx_lg = loadfx("explosions/fx_exp_equipment_lg");
	level._effect["powerLight"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
	setupretrievablehintstrings();
	level.weaponobjects_headicon_offset["acoustic_sensor_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["sensor_grenade_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["camera_spike_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["claymore_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["bouncingbetty_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["satchel_charge_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["scrambler_mp"] = VectorScale((0,0,1));
	level.weaponobjects_headicon_offset["trophy_system_mp"] = VectorScale((0,0,1));
	level.weaponobjects_hacker_trigger_width = 32;
	level.weaponobjects_hacker_trigger_height = 32;
}

//Function Number: 2
getwatchernames(weapons)
{
	names = [];
	foreach(index, weapon in weapons)
	{
		names[index] = getsubstr(weapon,0,weapon.size - 3);
	}

	return names;
}

//Function Number: 3
weapons_get_dvar_int(dvar,def)
{
	return int(weapons_get_dvar(dvar,def));
}

//Function Number: 4
weapons_get_dvar(dvar,def)
{
	if(GetDvar(dvar) != "")
	{
		return GetDvarFloat(dvar);
	}
	else
	{
		setdvar(dvar,def);
		return def;
	}
}

//Function Number: 5
setupretrievablehintstrings()
{
	createretrievablehint("hatchet",&"MP_HATCHET_PICKUP");
	createretrievablehint("claymore",&"MP_CLAYMORE_PICKUP");
	createretrievablehint("bouncingbetty",&"MP_BOUNCINGBETTY_PICKUP");
	createretrievablehint("trophy_system",&"MP_TROPHY_SYSTEM_PICKUP");
	createretrievablehint("acoustic_sensor",&"MP_ACOUSTIC_SENSOR_PICKUP");
	createretrievablehint("camera_spike",&"MP_CAMERA_SPIKE_PICKUP");
	createretrievablehint("satchel_charge",&"MP_SATCHEL_CHARGE_PICKUP");
	createretrievablehint("scrambler",&"MP_SCRAMBLER_PICKUP");
	createdestroyhint("trophy_system",&"MP_TROPHY_SYSTEM_DESTROY");
	createdestroyhint("sensor_grenade",&"MP_SENSOR_GRENADE_DESTROY");
	createhackerhint("claymore_mp",&"MP_CLAYMORE_HACKING");
	createhackerhint("bouncingbetty_mp",&"MP_BOUNCINGBETTY_HACKING");
	createhackerhint("trophy_system_mp",&"MP_TROPHY_SYSTEM_HACKING");
	createhackerhint("acoustic_sensor_mp",&"MP_ACOUSTIC_SENSOR_HACKING");
	createhackerhint("camera_spike_mp",&"MP_CAMERA_SPIKE_HACKING");
	createhackerhint("satchel_charge_mp",&"MP_SATCHEL_CHARGE_HACKING");
	createhackerhint("scrambler_mp",&"MP_SCRAMBLER_HACKING");
}

//Function Number: 6
onplayerconnect()
{
	if(IsDefined(level._weaponobjects_on_player_connect_override))
	{
		level thread [[ level._weaponobjects_on_player_connect_override ]]();
		return;
	}

	for(;;)
	{
		level waittill("connecting",player);
		player.usedweapons = 0;
		player.hits = 0;
		player thread onplayerspawned();
	}
}

//Function Number: 7
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		pixbeginevent("onPlayerSpawned");
		if(!(IsDefined(self.watchersinitialized)))
		{
			self createbasewatchers();
			self setupretrievablewatcher();
			self thread watchweaponobjectusage();
			self.watchersinitialized = 1;
		}

		self resetwatchers();
		pixendevent();
	}
}

//Function Number: 8
resetwatchers()
{
	if(!(IsDefined(self.weaponobjectwatcherarray)))
	{
		return undefined;
	}

	team = self.team;
	foreach(watcher in self.weaponobjectwatcherarray)
	{
		resetweaponobjectwatcher(watcher,team);
	}
}

//Function Number: 9
createbasewatchers()
{
	foreach(index, weapon in level.watcherweapons)
	{
		self createweaponobjectwatcher(level.watcherweaponnames[index],weapon,self.team);
	}

	foreach(index, weapon in level.retrievableweapons)
	{
		self createweaponobjectwatcher(level.retrievableweaponnames[index],weapon,self.team);
	}
}

//Function Number: 10
setupretrievablewatcher()
{
	for(i = 0;i < level.retrievableweapons.size;i++)
	{
		watcher = getweaponobjectwatcherbyweapon(level.retrievableweapons[i]);
		if(!(IsDefined(watcher.onspawnretrievetriggers)))
		{
			watcher.onspawnretrievetriggers = ::onspawnretrievableweaponobject;
		}

		if(!(IsDefined(watcher.ondestroyed)))
		{
			watcher.ondestroyed = ::ondestroyed;
		}

		if(!(IsDefined(watcher.pickup)))
		{
			watcher.pickup = ::pickup;
		}
	}
}

//Function Number: 11
createballisticknifewatcher()
{
	watcher = self createuseweaponobjectwatcher("knife_ballistic","knife_ballistic_mp",self.team);
	watcher.onspawn = maps/mp/_ballistic_knife::onspawn;
	watcher.detonate = ::deleteent;
	watcher.onspawnretrievetriggers = maps/mp/_ballistic_knife::onspawnretrievetrigger;
	watcher.storedifferentobject = 1;
}

//Function Number: 12
createhatchetwatcher()
{
	watcher = self createuseweaponobjectwatcher("hatchet","hatchet_mp",self.team);
	watcher.detonate = ::deleteent;
	watcher.onspawn = ::voidonspawn;
	watcher.onspawnretrievetriggers = ::onspawnhatchettrigger;
}

//Function Number: 13
createtactinsertwatcher()
{
	watcher = self createuseweaponobjectwatcher("tactical_insertion","tactical_insertion_mp",self.team);
	watcher.playdestroyeddialog = 0;
}

//Function Number: 14
creatercbombwatcher()
{
}

//Function Number: 15
createqrdronewatcher()
{
}

//Function Number: 16
createplayerhelicopterwatcher()
{
	watcher = self createuseweaponobjectwatcher("helicopter_player","helicopter_player_mp",self.team);
	watcher.altdetonate = 1;
	watcher.headicon = 0;
}

//Function Number: 17
createclaymorewatcher()
{
	watcher = self createproximityweaponobjectwatcher("claymore","claymore_mp",self.team);
	watcher.watchforfire = 1;
	watcher.detonate = ::claymoredetonate;
	watcher.activatesound = "wpn_claymore_alert";
	watcher.hackable = 1;
	watcher.hackertoolradius = level.claymorehackertoolradius;
	watcher.hackertooltimems = level.claymorehackertooltimems;
	watcher.reconmodel = "t6_wpn_claymore_world_detect";
	watcher.ownergetsassist = 1;
	detectionconeangle = weapons_get_dvar_int("scr_weaponobject_coneangle");
	watcher.detectiondot = cos(detectionconeangle);
	watcher.detectionmindist = weapons_get_dvar_int("scr_weaponobject_mindist");
	watcher.detectiongraceperiod = weapons_get_dvar("scr_weaponobject_graceperiod");
	watcher.detonateradius = weapons_get_dvar_int("scr_weaponobject_radius");
	watcher.stun = ::weaponstun;
	watcher.stuntime = 5;
}

//Function Number: 18
waittillnotmoving_and_notstunned()
{
	prevorigin = self.origin;
	while(1)
	{
		wait(0.15);
		if(self.origin == prevorigin && !self isstunned())
		{
			break;
		}

		prevorigin = self.origin;
	}
}

//Function Number: 19
voidonspawn(unused0,unused1)
{
}

//Function Number: 20
deleteent(attacker,emp)
{
	self delete();
}

//Function Number: 21
clearfxondeath(fx)
{
	fx endon("death");
	self waittill_any("death","hacked");
	fx delete();
}

//Function Number: 22
deleteweaponobjectarray()
{
	if(IsDefined(self.objectarray))
	{
		for(i = 0;i < self.objectarray.size;i++)
		{
			if(IsDefined(self.objectarray[i]))
			{
				self.objectarray[i] delete();
			}
		}
	}

	self.objectarray = [];
}

//Function Number: 23
claymoredetonate(attacker,weaponname)
{
	from_emp = 0;
	if(!IsDefined(from_emp) || !from_emp)
	{
		if(IsDefined(attacker))
		{
			if((level.teambased && attacker.team != self.owner.team) || attacker != self.owner)
			{
				attacker maps/mp/_challenges::destroyedexplosive();
			}
		}
	}

	maps/mp/gametypes_zm/_weaponobjects::weapondetonate(attacker,weaponname);
}

//Function Number: 24
weapondetonate(attacker,weaponname)
{
	from_emp = 0;
	if(from_emp)
	{
		self delete();
		return;
	}

	if(IsDefined(attacker))
	{
		self detonate(attacker);
	}
	else if(IsDefined(self.owner) && isplayer(self.owner))
	{
		self detonate(self.owner);
	}
	else
	{
		self detonate();
	}
}

//Function Number: 25
waitanddetonate(object,delay,attacker,weaponname)
{
	object endon("death");
	object endon("hacked");
	from_emp = 0;
	if(from_emp)
	{
		object setclientflag(15);
		object setclientflag(9);
		object.stun_fx = 1;
		if(IsDefined(object.name) && object.name == "qrdrone_turret_mp")
		{
			playfx(level._equipment_emp_destroy_fx,object.origin + (0,0,0),(0,randomfloat(360),0));
		}
		else
		{
			playfx(level._equipment_emp_destroy_fx,5 + VectorScale((0,0,1)),object.origin);
		}

		delay = 1.1;
	}

	if(delay)
	{
		wait(delay);
	}

	if(IsDefined(object.detonated) && object.detonated == 1)
	{
		return;
	}

	if(!(IsDefined(self.detonate)))
	{
		return;
	}

	if(IsDefined(attacker) && isplayer(attacker) && IsDefined(attacker.pers["team"]) && IsDefined(object.owner) && IsDefined(object.owner.pers["team"]))
	{
		if(level.teambased)
		{
			if(attacker.pers["team"] != object.owner.pers["team"])
			{
				attacker notify("destroyed_explosive",(0,randomfloat(360),0));
			}
		}
		else if(attacker != object.owner)
		{
			attacker notify("destroyed_explosive");
		}
	}

	object.detonated = 1;
	object [[ self.detonate ]](attacker,weaponname);
}

//Function Number: 26
detonateweaponobjectarray(forcedetonation,weapon)
{
	undetonated = [];
	if(IsDefined(self.objectarray))
	{
		for(i = 0;i < self.objectarray.size;i++)
		{
			if(IsDefined(self.objectarray[i]))
			{
				if(self.objectarray[i] isstunned() && forcedetonation == 0)
				{
					undetonated[undetonated.size] = self.objectarray[i];
				}
				else if(IsDefined(weapon))
				{
					if(weapon ishacked() && weapon.name != self.objectarray[i].name)
					{
						undetonated[undetonated.size] = self.objectarray[i];
					}
					else if(self.objectarray[i] ishacked() && weapon.name != self.objectarray[i].name)
					{
						undetonated[undetonated.size] = self.objectarray[i];
					}
					else
					{
						self thread waitanddetonate(self.objectarray[i],0.1,undefined,weapon);
					}
				}
			}
		}
	}

	self.objectarray = undetonated;
}

//Function Number: 27
addweaponobjecttowatcher(watchername,weapon)
{
	watcher = getweaponobjectwatcher(watchername);
/#
	assert(IsDefined(watcher),"Weapon object watcher " + watchername + " does not exist");
#/
	self addweaponobject(watcher,weapon);
}

//Function Number: 28
addweaponobject(watcher,weapon)
{
	if(!(IsDefined(watcher.storedifferentobject)))
	{
		watcher.objectarray[watcher.objectarray.size] = weapon;
	}

	weapon.owner = self;
	weapon.detonated = 0;
	weapon.name = watcher.weapon;
	if(IsDefined(watcher.ondamage))
	{
		weapon thread [[ watcher.ondamage ]](watcher);
	}
	else
	{
		weapon thread weaponobjectdamage(watcher);
	}

	weapon.ownergetsassist = watcher.ownergetsassist;
	if(IsDefined(watcher.onspawn))
	{
		weapon thread [[ watcher.onspawn ]](watcher,self);
	}

	if(IsDefined(watcher.onspawnfx))
	{
		weapon thread [[ watcher.onspawnfx ]]();
	}

	if(IsDefined(watcher.reconmodel))
	{
		weapon thread attachreconmodel(watcher.reconmodel,self);
	}

	if(IsDefined(watcher.onspawnretrievetriggers))
	{
		weapon thread [[ watcher.onspawnretrievetriggers ]](watcher,self);
	}

	if(watcher.hackable)
	{
		weapon thread hackerinit(watcher);
	}

	if(IsDefined(watcher.stun))
	{
		weapon thread watchscramble(watcher);
	}

	if(watcher.playdestroyeddialog)
	{
		weapon thread playdialogondeath(self);
		weapon thread watchobjectdamage(self);
	}

	if(watcher.deleteonkillbrush)
	{
		weapon thread deleteonkillbrush(self);
	}
}

//Function Number: 29
watchscramble(watcher)
{
}

//Function Number: 30
deleteweaponobjecthelper(weapon_ent)
{
	if(!(IsDefined(weapon_ent.name)))
	{
		return;
	}

	watcher = self getweaponobjectwatcherbyweapon(weapon_ent.name);
	if(!(IsDefined(watcher)))
	{
		return;
	}

	watcher.objectarray = deleteweaponobject(watcher,weapon_ent);
}

//Function Number: 31
deleteweaponobject(watcher,weapon_ent)
{
	temp_objectarray = watcher.objectarray;
	watcher.objectarray = [];
	j = 0;
	for(i = 0;i < temp_objectarray.size;i++)
	{
		if(!IsDefined(temp_objectarray[i]) || temp_objectarray[i] == weapon_ent)
		{
		}
		else
		{
			watcher.objectarray[j] = temp_objectarray[i];
			j++;
		}
	}

	return watcher.objectarray;
}

//Function Number: 32
weaponobjectdamage(watcher)
{
	self endon("death");
	self endon("hacked");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	attacker = undefined;
	while(1)
	{
		self waittill("damage",damage,attacker,direction_vec,point,type,modelname,tagname,partname,weaponname,idflags);
		if(IsDefined(weaponname))
		{
			switch(weaponname)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
				case "proximity_grenade_mp":
					self thread stunstart(watcher,watcher.stuntime);
					attacker maps/mp/gametypes_zm/_damagefeedback::updatedamagefeedback();
					continue;
					attacker maps/mp/gametypes_zm/_damagefeedback::updatedamagefeedback();
					continue;
	maps/mp/gametypes_zm/_globallogic_player::dodamagefeedback(weaponname,attacker)
	!level.teambased && self.owner != attacker
	maps/mp/gametypes_zm/_globallogic_player::dodamagefeedback(weaponname,attacker)
	level.teambased && self.owner.team != attacker.team
	watcher.stuntime > 0
					break;

				case "willy_pete_mp":
					continue;

				case "emp_grenade_mp":
					attacker maps/mp/gametypes_zm/_damagefeedback::updatedamagefeedback();
					continue;
					attacker maps/mp/gametypes_zm/_damagefeedback::updatedamagefeedback();
					break;
	maps/mp/gametypes_zm/_globallogic_player::dodamagefeedback(weaponname,attacker)
	!level.teambased && self.owner != attacker
	maps/mp/gametypes_zm/_globallogic_player::dodamagefeedback(weaponname,attacker)
	level.teambased && self.owner.team != attacker.team
					break;

				default:
					break;
			}
		}

		if(!isplayer(attacker) && IsDefined(attacker.owner))
		{
			attacker = attacker.owner;
		}

		if(level.teambased && isplayer(attacker))
		{
			if(!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker)
			{
				continue;
			}
		}

		if(maps/mp/gametypes_zm/_globallogic_player::dodamagefeedback(weaponname,attacker))
		{
			attacker maps/mp/gametypes_zm/_damagefeedback::updatedamagefeedback();
		}

		if(!isvehicle(self) && !friendlyfirecheck(self.owner,attacker))
		{
			continue;
		}

		break;
	}

	if(level.weaponobjectexplodethisframe)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		wait(0.05);
	}

	if(!(IsDefined(self)))
	{
		return;
	}

	level.weaponobjectexplodethisframe = 1;
	thread resetweaponobjectexplodethisframe();
	if(IsDefined(type) && issubstr(type,"MOD_GRENADE_SPLASH") || issubstr(type,"MOD_GRENADE") || issubstr(type,"MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(IsDefined(idflags) && idflags & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	watcher thread waitanddetonate(self,0,attacker,weaponname);
}

//Function Number: 33
playdialogondeath(owner)
{
	owner endon("death");
	owner endon("disconnect");
	self endon("hacked");
	self waittill("death");
	if(IsDefined(self.playdialog) && self.playdialog)
	{
		owner maps/mp/gametypes_zm/_globallogic_audio::leaderdialogonplayer("equipment_destroyed","item_destroyed");
	}
}

//Function Number: 34
watchobjectdamage(owner)
{
	owner endon("death");
	owner endon("disconnect");
	self endon("hacked");
	self endon("death");
	while(1)
	{
		self waittill("damage",damage,attacker);
		if(IsDefined(attacker) && isplayer(attacker) && attacker != owner)
		{
			self.playdialog = 1;
			continue;
		}

		self.playdialog = 0;
	}
}

//Function Number: 35
stunstart(watcher,time)
{
	self endon("death");
	if(self isstunned())
	{
		return;
	}

	if(IsDefined(self.camerahead))
	{
		self.camerahead setclientflag(9);
	}

	self setclientflag(9);
	if(IsDefined(watcher.stun))
	{
		self thread [[ watcher.stun ]]();
	}

	if(watcher.name == "rcbomb")
	{
		self.owner freezecontrolswrapper(1);
	}

	if(IsDefined(time))
	{
		wait(time);
	}
	else
	{
		return;
	}

	if(watcher.name == "rcbomb")
	{
		self.owner freezecontrolswrapper(0);
	}

	self stunstop();
}

//Function Number: 36
stunstop()
{
	self notify("not_stunned");
	if(IsDefined(self.camerahead))
	{
		self.camerahead clearclientflag(9);
	}

	self clearclientflag(9);
}

//Function Number: 37
weaponstun()
{
	self endon("death");
	self endon("not_stunned");
	origin = self gettagorigin("tag_fx");
	if(!(IsDefined(origin)))
	{
		origin = 10 + VectorScale((0,0,1));
	}

	self.stun_fx = spawn("script_model",origin);
	self.stun_fx setmodel("tag_origin");
	self thread stunfxthink(self.stun_fx);
	wait(0.1);
	playfxontag(level._equipment_spark_fx,self.stun_fx,"tag_origin");
	self.stun_fx playsound("dst_disable_spark");
}

//Function Number: 38
stunfxthink(fx)
{
	fx endon("death");
	self waittill_any("death","not_stunned");
	fx delete();
}

//Function Number: 39
isstunned()
{
	return IsDefined(self.stun_fx);
}

//Function Number: 40
resetweaponobjectexplodethisframe()
{
	wait(0.05);
	level.weaponobjectexplodethisframe = 0;
}

//Function Number: 41
getweaponobjectwatcher(name)
{
	if(!(IsDefined(self.weaponobjectwatcherarray)))
	{
		return undefined;
	}

	for(watcher = 0;watcher < self.weaponobjectwatcherarray.size;watcher++)
	{
		if(self.weaponobjectwatcherarray[watcher].name == name)
		{
			return self.weaponobjectwatcherarray[watcher];
		}
	}

	return undefined;
}

//Function Number: 42
getweaponobjectwatcherbyweapon(weapon)
{
	if(!(IsDefined(self.weaponobjectwatcherarray)))
	{
		return undefined;
	}

	for(watcher = 0;watcher < self.weaponobjectwatcherarray.size;watcher++)
	{
		if(IsDefined(self.weaponobjectwatcherarray[watcher].weapon) && self.weaponobjectwatcherarray[watcher].weapon == weapon)
		{
			return self.weaponobjectwatcherarray[watcher];
		}

		if(IsDefined(self.weaponobjectwatcherarray[watcher].weapon) && IsDefined(self.weaponobjectwatcherarray[watcher].altweapon) && self.weaponobjectwatcherarray[watcher].altweapon == weapon)
		{
			return self.weaponobjectwatcherarray[watcher];
		}
	}

	return undefined;
}

//Function Number: 43
resetweaponobjectwatcher(watcher,ownerteam)
{
	if(level.deleteexplosivesonspawn == 1)
	{
		self notify("weapon_object_destroyed");
		watcher deleteweaponobjectarray();
	}

	watcher.ownerteam = ownerteam;
}

//Function Number: 44
createweaponobjectwatcher(name,weapon,ownerteam)
{
	if(!(IsDefined(self.weaponobjectwatcherarray)))
	{
		self.weaponobjectwatcherarray = [];
	}

	weaponobjectwatcher = getweaponobjectwatcher(name);
	if(!(IsDefined(weaponobjectwatcher)))
	{
		weaponobjectwatcher = spawnstruct();
		self.weaponobjectwatcherarray[self.weaponobjectwatcherarray.size] = weaponobjectwatcher;
		weaponobjectwatcher.name = name;
		weaponobjectwatcher.type = "use";
		weaponobjectwatcher.weapon = weapon;
		weaponobjectwatcher.weaponidx = getweaponindexfromname(weapon);
		weaponobjectwatcher.watchforfire = 0;
		weaponobjectwatcher.hackable = 0;
		weaponobjectwatcher.altdetonate = 0;
		weaponobjectwatcher.detectable = 1;
		weaponobjectwatcher.headicon = 1;
		weaponobjectwatcher.stuntime = 0;
		weaponobjectwatcher.activatesound = undefined;
		weaponobjectwatcher.ignoredirection = undefined;
		weaponobjectwatcher.immediatedetonation = undefined;
		weaponobjectwatcher.deploysound = getweaponfiresound(weaponobjectwatcher.weaponidx);
		weaponobjectwatcher.deploysoundplayer = getweaponfiresoundplayer(weaponobjectwatcher.weaponidx);
		weaponobjectwatcher.pickupsound = getweaponpickupsound(weaponobjectwatcher.weaponidx);
		weaponobjectwatcher.pickupsoundplayer = getweaponpickupsoundplayer(weaponobjectwatcher.weaponidx);
		weaponobjectwatcher.altweapon = undefined;
		weaponobjectwatcher.ownergetsassist = 0;
		weaponobjectwatcher.playdestroyeddialog = 1;
		weaponobjectwatcher.deleteonkillbrush = 1;
		weaponobjectwatcher.deleteondifferentobjectspawn = 1;
		weaponobjectwatcher.enemydestroy = 0;
		weaponobjectwatcher.onspawn = undefined;
		weaponobjectwatcher.onspawnfx = undefined;
		weaponobjectwatcher.onspawnretrievetriggers = undefined;
		weaponobjectwatcher.ondetonated = undefined;
		weaponobjectwatcher.detonate = undefined;
		weaponobjectwatcher.stun = undefined;
		weaponobjectwatcher.ondestroyed = undefined;
		if(!(IsDefined(weaponobjectwatcher.objectarray)))
		{
			weaponobjectwatcher.objectarray = [];
		}
	}

	resetweaponobjectwatcher(weaponobjectwatcher,ownerteam);
	return weaponobjectwatcher;
}

//Function Number: 45
createuseweaponobjectwatcher(name,weapon,ownerteam)
{
	weaponobjectwatcher = createweaponobjectwatcher(name,weapon,ownerteam);
	weaponobjectwatcher.type = "use";
	weaponobjectwatcher.onspawn = ::onspawnuseweaponobject;
	return weaponobjectwatcher;
}

//Function Number: 46
createproximityweaponobjectwatcher(name,weapon,ownerteam)
{
	weaponobjectwatcher = createweaponobjectwatcher(name,weapon,ownerteam);
	weaponobjectwatcher.type = "proximity";
	weaponobjectwatcher.onspawn = ::onspawnproximityweaponobject;
	detectionconeangle = weapons_get_dvar_int("scr_weaponobject_coneangle");
	weaponobjectwatcher.detectiondot = cos(detectionconeangle);
	weaponobjectwatcher.detectionmindist = weapons_get_dvar_int("scr_weaponobject_mindist");
	weaponobjectwatcher.detectiongraceperiod = weapons_get_dvar("scr_weaponobject_graceperiod");
	weaponobjectwatcher.detonateradius = weapons_get_dvar_int("scr_weaponobject_radius");
	return weaponobjectwatcher;
}

//Function Number: 47
commononspawnuseweaponobject(watcher,owner)
{
	if(watcher.detectable)
	{
		if(IsDefined(watcher.ismovable) && watcher.ismovable)
		{
			self thread weaponobjectdetectionmovable(owner.pers["team"]);
		}
		else
		{
			self thread weaponobjectdetectiontrigger_wait(owner.pers["team"]);
		}

		if(watcher.headicon && level.teambased)
		{
			self waittillnotmoving();
			offset = level.weaponobjects_headicon_offset["default"];
			if(IsDefined(level.weaponobjects_headicon_offset[self.name]))
			{
				offset = level.weaponobjects_headicon_offset[self.name];
			}
		}
	}
}

//Function Number: 48
onspawnuseweaponobject(watcher,owner)
{
	self commononspawnuseweaponobject(watcher,owner);
}

//Function Number: 49
onspawnproximityweaponobject(watcher,owner)
{
	self thread commononspawnuseweaponobject(watcher,owner);
	self thread proximityweaponobjectdetonation(watcher);
/#
	if(GetDvarInt(#"38868733"))
	{
		self thread proximityweaponobjectdebug(watcher);
	}
#/
}

//Function Number: 50
watchweaponobjectusage()
{
	self endon("disconnect");
	if(!(IsDefined(self.weaponobjectwatcherarray)))
	{
		self.weaponobjectwatcherarray = [];
	}

	self thread watchweaponobjectspawn();
	self thread watchweaponprojectileobjectspawn();
	self thread watchweaponobjectdetonation();
	self thread watchweaponobjectaltdetonation();
	self thread watchweaponobjectaltdetonate();
	self thread deleteweaponobjectson();
}

//Function Number: 51
watchweaponobjectspawn()
{
	self notify("watchWeaponObjectSpawn");
	self endon("watchWeaponObjectSpawn");
	self endon("disconnect");
	while(1)
	{
		self waittill("grenade_fire",weapon,weapname);
		switch(weapname)
		{
			case "acoustic_sensor_mp":
			case "bouncingbetty_mp":
			case "camera_spike_mp":
			case "scrambler_mp":
			case "tactical_insertion_mp":
				break;

			case "bouncingbetty_mp":
			case "claymore_mp":
			case "proximity_grenade_mp":
			case "satchel_charge_mp":
			case "sensor_grenade_mp":
			case "trophy_system_mp":
				i = 0;
				for(;;)
				{
					objectarray_size = self.weaponobjectwatcherarray[i].objectarray.size;
					j = 0;
					for(;;)
					{
						self.weaponobjectwatcherarray[i].objectarray = deleteweaponobject(self.weaponobjectwatcherarray[i],weapon);
						j++;
					}
	
					numallowed = 2;
					numallowed = weapons_get_dvar_int("scr_proximityGrenadeMaxInstances");
					self.weaponobjectwatcherarray[i] thread waitanddetonate(self.weaponobjectwatcherarray[i].objectarray[0],0.1,undefined,weapname);
					i++;
				}
	
				break;
	IsDefined(self.weaponobjectwatcherarray[i].detonate) && self.weaponobjectwatcherarray[i].objectarray.size > numallowed - 1
	weapname == "proximity_grenade_mp"
	IsDefined(self.weaponobjectwatcherarray[i].objectarray[j])
	j < objectarray_size
	self.weaponobjectwatcherarray[i].weapon != weapname
	i < self.weaponobjectwatcherarray.size
				break;

			default:
				break;
		}

		if(!(self ishacked()))
		{
			if(weapname == "claymore_mp" || weapname == "satchel_charge_mp" || weapname == "bouncingbetty_mp")
			{
				self addweaponstat(weapname,"used",1);
			}
		}

		watcher = getweaponobjectwatcherbyweapon(weapname);
		if(IsDefined(watcher))
		{
			self addweaponobject(watcher,weapon);
		}
	}
}

//Function Number: 52
watchweaponprojectileobjectspawn()
{
	self endon("disconnect");
	while(1)
	{
		self waittill("missile_fire",weapon,weapname);
		watcher = getweaponobjectwatcherbyweapon(weapname);
		if(IsDefined(watcher))
		{
			self addweaponobject(watcher,weapon);
			objectarray_size = watcher.objectarray.size;
			for(j = 0;j < objectarray_size;j++)
			{
				if(!(IsDefined(watcher.objectarray[j])))
				{
					watcher.objectarray = deleteweaponobject(watcher,weapon);
				}
			}

			if(IsDefined(watcher.detonate) && watcher.objectarray.size > 1)
			{
				watcher thread waitanddetonate(watcher.objectarray[0],0.1);
			}
		}
	}
}

//Function Number: 53
proximityweaponobjectdebug(watcher)
{
/#
	self waittillnotmoving();
	self thread showcone(acos(watcher.detectiondot),watcher.detonateradius,(1,0.85,0));
	self thread showcone(60,256,(1,0,0));
#/
}

//Function Number: 54
vectorcross(v1,v2)
{
/#
	return (v1[1] * v2[2] - v1[2] * v2[1],v1[2] * v2[0] - v1[0] * v2[2],v1[0] * v2[1] - v1[1] * v2[0]);
#/
}

//Function Number: 55
showcone(angle,range,color)
{
/#
	self endon("death");
	start = self.origin;
	forward = AnglesToForward(self.angles);
	right = vectorcross(forward,(0,0,1));
	up = vectorcross(forward,right);
	fullforward = forward * range * cos(angle);
	sideamnt = range * sin(angle);
	while(1)
	{
		prevpoint = (0,0,0);
		for(i = 0;i <= 20;i++)
		{
			coneangle = i / 20 * 360;
			point = start + fullforward + sideamnt * right * cos(coneangle) + up * sin(coneangle);
			if(i > 0)
			{
				line(start,point,color);
				line(prevpoint,point,color);
			}

			prevpoint = point;
		}

		wait(0.05);
	}
#/
}

//Function Number: 56
weaponobjectdetectionmovable(ownerteam)
{
	self endon("end_detection");
	level endon("game_ended");
	self endon("death");
	self endon("hacked");
	if(level.oldschool)
	{
		return;
	}

	if(!(level.teambased))
	{
		return;
	}

	self.detectid = "rcBomb" + GetTime() + randomint(1000000);
	while(!(level.gameended))
	{
		wait(1);
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(isai(player))
			{
			}
			else
			{
				if(IsDefined(self.model_name) && player hasperk("specialty_detectexplosive"))
				{
					switch(self.model_name)
					{
						case "t6_wpn_c4_world_detect":
						case "t6_wpn_claymore_world_detect":
							break;

						default:
							break;
					}
				}
				else
				{
				}

				if(player.team == ownerteam)
				{
				}
				else if(IsDefined(player.bombsquadids[self.detectid]))
				{
				}
				else
				{
				}
			}
		}
	}
}

//Function Number: 57
seticonpos(item,icon,heightincrease)
{
	icon.x = item.origin[0];
	icon.y = item.origin[1];
	icon.z = item.origin[2] + heightincrease;
}

//Function Number: 58
weaponobjectdetectiontrigger_wait(ownerteam)
{
	self endon("death");
	self endon("hacked");
	waittillnotmoving();
	if(level.oldschool)
	{
		return;
	}

	self thread weaponobjectdetectiontrigger(ownerteam);
}

//Function Number: 59
weaponobjectdetectiontrigger(ownerteam)
{
	trigger = spawn("trigger_radius",128 - VectorScale((0,0,1)),self.origin,0,512);
	trigger.detectid = "trigger" + GetTime() + randomint(1000000);
	trigger sethintlowpriority(1);
	self waittill_any("death","hacked");
	trigger notify("end_detection",256);
	if(IsDefined(trigger.bombsquadicon))
	{
		trigger.bombsquadicon destroy();
	}

	trigger delete();
}

//Function Number: 60
hackertriggersetvisibility(owner)
{
	self endon("death");
/#
	assert(isplayer(owner));
#/
	ownerteam = owner.pers["team"];
	for(;;)
	{
		if(level.teambased)
		{
			self setvisibletoallexceptteam(ownerteam);
			self setexcludeteamfortrigger(ownerteam);
		}
		else
		{
			self setvisibletoall();
			self setteamfortrigger("none");
		}

		self setinvisibletoplayer(owner);
		level waittill_any("player_spawned","joined_team");
	}
}

//Function Number: 61
hackernotmoving()
{
	self endon("death");
	self waittillnotmoving();
	self notify("landed");
}

//Function Number: 62
hackerinit(watcher)
{
	self thread hackernotmoving();
	event = self waittill_any_return("death","landed");
	if(event == "death")
	{
		return;
	}

	triggerorigin = self.origin;
	if(IsDefined(self.name) && self.name == "satchel_charge_mp")
	{
		triggerorigin = self gettagorigin("tag_fx");
	}

	self.hackertrigger = spawn("trigger_radius_use",triggerorigin,level.weaponobjects_hacker_trigger_width,level.weaponobjects_hacker_trigger_height);
/#
#/
	self.hackertrigger sethintlowpriority(1);
	self.hackertrigger setcursorhint("HINT_NOICON",self);
	self.hackertrigger setignoreentfortrigger(self);
	self.hackertrigger enablelinkto();
	self.hackertrigger linkto(self);
	if(IsDefined(level.hackerhints[self.name]))
	{
		self.hackertrigger sethintstring(level.hackerhints[self.name].hint);
	}
	else
	{
		self.hackertrigger sethintstring(&"MP_GENERIC_HACKING");
	}

	self.hackertrigger setperkfortrigger("specialty_disarmexplosive");
	self.hackertrigger thread hackertriggersetvisibility(self.owner);
	self thread hackerthink(self.hackertrigger,watcher);
}

//Function Number: 63
hackerthink(trigger,watcher)
{
	self endon("death");
	for(;;)
	{
		trigger waittill("trigger",player,instant);
		if(!IsDefined(instant) && !trigger hackerresult(player,self.owner))
		{
			continue;
		}

		self.owner hackerremoveweapon(self);
		self.owner maps/mp/gametypes_zm/_globallogic_audio::leaderdialogonplayer("hacked_equip","item_destroyed");
		self.hacked = 1;
		self setmissileowner(player);
		self setteam(player.pers["team"]);
		self.owner = player;
		if(isweaponequipment(self.name))
		{
		}

		if(self.name == "satchel_charge_mp" && IsDefined(player.lowermessage))
		{
			player.lowermessage settext(&"PLATFORM_SATCHEL_CHARGE_DOUBLE_TAP");
			player.lowermessage.alpha = 1;
			player.lowermessage fadeovertime(2);
			player.lowermessage.alpha = 0;
		}

		self notify("hacked",player);
		level notify("hacked",self,player);
		if(self.name == "camera_spike_mp" && IsDefined(self.camerahead))
		{
			self.camerahead notify("hacked",player);
		}

/#
#/
		if(IsDefined(watcher.stun))
		{
			self thread stunstart(watcher,0.75);
			wait(0.75);
		}
		else
		{
			wait(0.05);
		}

		if(IsDefined(player) && player.sessionstate == "playing")
		{
			player notify("grenade_fire",self,self.name);
		}
		else
		{
			watcher thread waitanddetonate(self,0);
		}

		return;
	}
}

//Function Number: 64
ishacked()
{
	return IsDefined(self.hacked) && self.hacked;
}

//Function Number: 65
hackerunfreezeplayer(player)
{
	self endon("hack_done");
	self waittill("death");
	if(IsDefined(player))
	{
		player freeze_player_controls(0);
		player enableweapons();
	}
}

//Function Number: 66
hackerresult(player,owner)
{
	success = 1;
	time = GetTime();
	hacktime = GetDvarFloat(#"773B1EE4");
	if(!(canhack(player,owner,1)))
	{
		return 0;
	}

	self thread hackerunfreezeplayer(player);
	while(time + hacktime * 1000 > GetTime())
	{
		if(!(canhack(player,owner,0)))
		{
			success = 0;
			break;
		}

		if(!(player usebuttonpressed()))
		{
			success = 0;
			break;
		}

		if(!(IsDefined(self)))
		{
			success = 0;
			break;
		}

		player freeze_player_controls(1);
		player disableweapons();
		if(!(IsDefined(self.progressbar)))
		{
			self.progressbar = player createprimaryprogressbar();
			self.progressbar.lastuserate = -1;
			self.progressbar showelem();
			self.progressbar updatebar(0.01,1 / hacktime);
			self.progresstext = player createprimaryprogressbartext();
			self.progresstext settext(&"MP_HACKING");
			self.progresstext showelem();
			player playlocalsound("evt_hacker_hacking");
		}

		wait(0.05);
	}

	if(IsDefined(player))
	{
		player freeze_player_controls(0);
		player enableweapons();
	}

	if(IsDefined(self.progressbar))
	{
		self.progressbar destroyelem();
		self.progresstext destroyelem();
	}

	if(IsDefined(self))
	{
		self notify("hack_done");
	}

	return success;
}

//Function Number: 67
canhack(player,owner,weapon_check)
{
	if(!(IsDefined(player)))
	{
		return 0;
	}

	if(!(isplayer(player)))
	{
		return 0;
	}

	if(!(isalive(player)))
	{
		return 0;
	}

	if(!(IsDefined(owner)))
	{
		return 0;
	}

	if(owner == player)
	{
		return 0;
	}

	if(level.teambased && player.team == owner.team)
	{
		return 0;
	}

	if(IsDefined(player.isdefusing) && player.isdefusing)
	{
		return 0;
	}

	if(IsDefined(player.isplanting) && player.isplanting)
	{
		return 0;
	}

	if(IsDefined(player.proxbar) && !player.proxbar.hidden)
	{
		return 0;
	}

	if(IsDefined(player.revivingteammate) && player.revivingteammate == 1)
	{
		return 0;
	}

	if(!(player isonground()))
	{
		return 0;
	}

	if(player isinvehicle())
	{
		return 0;
	}

	if(player isweaponviewonlylinked())
	{
		return 0;
	}

	if(!(player hasperk("specialty_disarmexplosive")))
	{
		return 0;
	}

	if(player isempjammed())
	{
		return 0;
	}

	if(IsDefined(player.laststand) && player.laststand)
	{
		return 0;
	}

	if(weapon_check)
	{
		if(player isthrowinggrenade())
		{
			return 0;
		}

		if(player isswitchingweapons())
		{
			return 0;
		}

		if(player ismeleeing())
		{
			return 0;
		}

		weapon = player getcurrentweapon();
		if(!(IsDefined(weapon)))
		{
			return 0;
		}

		if(weapon == "none")
		{
			return 0;
		}

		if(isweaponequipment(weapon) && player isfiring())
		{
			return 0;
		}

		if(isweaponspecificuse(weapon))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 68
hackerremoveweapon(weapon)
{
	for(i = 0;i < self.weaponobjectwatcherarray.size;i++)
	{
		if(self.weaponobjectwatcherarray[i].weapon != weapon.name)
		{
		}
		else
		{
			objectarray_size = self.weaponobjectwatcherarray[i].objectarray.size;
			for(j = 0;j < objectarray_size;j++)
			{
				self.weaponobjectwatcherarray[i].objectarray = deleteweaponobject(self.weaponobjectwatcherarray[i],weapon);
			}

			return;
		}
	}
}

//Function Number: 69
proximityweaponobjectdetonation(watcher)
{
	self endon("death");
	self endon("hacked");
	self waittillnotmoving();
	if(IsDefined(watcher.activationdelay))
	{
		wait(watcher.activationdelay);
	}

	damagearea = spawn("trigger_radius",self.origin + (0,0,0 - watcher.detonateradius),level.aitriggerspawnflags | level.vehicletriggerspawnflags,watcher.detonateradius,watcher.detonateradius * 2);
	damagearea enablelinkto();
	damagearea linkto(self);
	self thread deleteondeath(damagearea);
	up = AnglesToUp(self.angles);
	traceorigin = self.origin + up;
	while(1)
	{
		damagearea waittill("trigger",ent);
		if(GetDvarInt(#"38868733") != 1)
		{
			if(IsDefined(self.owner) && ent == self.owner)
			{
				continue;
			}

			if(IsDefined(self.owner) && isvehicle(ent) && IsDefined(ent.owner) && self.owner == ent.owner)
			{
				continue;
			}

			if(!(friendlyfirecheck(self.owner,ent,0)))
			{
				continue;
			}
		}

		if(lengthsquared(ent getvelocity()) < 10 && !IsDefined(watcher.immediatedetonation))
		{
			continue;
		}

		if(!(ent shouldaffectweaponobject(self,watcher)))
		{
			continue;
		}

		if(self isstunned())
		{
			continue;
		}

		if(isplayer(ent) && !isalive(ent))
		{
			continue;
		}

		if(ent damageconetrace(traceorigin,self) > 0)
		{
			break;
		}
	}

	if(IsDefined(watcher.activatesound))
	{
		self playsound(watcher.activatesound);
	}

	if(IsDefined(watcher.activatefx))
	{
		self setclientflag(4);
	}

	ent thread deathdodger(watcher.detectiongraceperiod);
	wait(watcher.detectiongraceperiod);
	if(isplayer(ent) && ent hasperk("specialty_delayexplosive"))
	{
		wait(GetDvarFloat(#"AACD4273"));
	}

	self.origin = traceorigin;
	if(IsDefined(self.owner) && isplayer(self.owner))
	{
		self [[ watcher.detonate ]](self.owner);
	}
	else
	{
		self [[ watcher.detonate ]]();
	}
}

//Function Number: 70
shouldaffectweaponobject(object,watcher)
{
	pos = 32 + VectorScale((0,0,1));
	if(IsDefined(watcher.ignoredirection))
	{
		return 1;
	}

	dirtopos = pos - object.origin;
	objectforward = AnglesToForward(object.angles);
	dist = vectordot(dirtopos,objectforward);
	if(dist < watcher.detectionmindist)
	{
		return 0;
	}

	dirtopos = vectornormalize(dirtopos);
	dot = vectordot(dirtopos,objectforward);
	return dot > watcher.detectiondot;
}

//Function Number: 71
deathdodger(graceperiod)
{
	self endon("death");
	self endon("disconnect");
	wait(0.2 + graceperiod);
	self notify("death_dodger");
}

//Function Number: 72
deleteondeath(ent)
{
	self waittill_any("death","hacked");
	wait(0.05);
	if(IsDefined(ent))
	{
		ent delete();
	}
}

//Function Number: 73
deleteonkillbrush(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("stationary");
	killbrushes = getentarray("trigger_hurt","classname");
	while(1)
	{
		for(i = 0;i < killbrushes.size;i++)
		{
			if(self istouching(killbrushes[i]))
			{
				if(self.origin[2] > player.origin[2])
				{
					break;
				}

				if(IsDefined(self))
				{
					self delete();
				}

				return;
			}
		}

		wait(0.1);
	}
}

//Function Number: 74
watchweaponobjectaltdetonation()
{
	self endon("disconnect");
	while(1)
	{
		self waittill("alt_detonate");
		if(!(isalive(self)))
		{
			continue;
		}

		for(watcher = 0;watcher < self.weaponobjectwatcherarray.size;watcher++)
		{
			if(self.weaponobjectwatcherarray[watcher].altdetonate)
			{
				self.weaponobjectwatcherarray[watcher] detonateweaponobjectarray(0);
			}
		}
	}
}

//Function Number: 75
watchweaponobjectaltdetonate()
{
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	buttontime = 0;
	for(;;)
	{
		self waittill("doubletap_detonate");
		if(!(isalive(self)))
		{
			continue;
		}

		self notify("alt_detonate");
		wait(0.05);
	}
}

//Function Number: 76
watchweaponobjectdetonation()
{
	self endon("disconnect");
	while(1)
	{
		self waittill("detonate");
		if(self isusingoffhand())
		{
			weap = self getcurrentoffhand();
		}
		else
		{
			weap = self getcurrentweapon();
		}

		watcher = getweaponobjectwatcherbyweapon(weap);
		if(IsDefined(watcher))
		{
			watcher detonateweaponobjectarray(0);
		}
	}
}

//Function Number: 77
deleteweaponobjectson()
{
	while(1)
	{
		msg = self waittill_any_return("disconnect","joined_team","joined_spectators","death");
		if(msg == "death")
		{
			continue;
		}

		if(!(IsDefined(self.weaponobjectwatcherarray)))
		{
			return;
		}

		watchers = [];
		for(watcher = 0;watcher < self.weaponobjectwatcherarray.size;watcher++)
		{
			weaponobjectwatcher = spawnstruct();
			watchers[watchers.size] = weaponobjectwatcher;
			weaponobjectwatcher.objectarray = [];
			if(IsDefined(self.weaponobjectwatcherarray[watcher].objectarray))
			{
				weaponobjectwatcher.objectarray = self.weaponobjectwatcherarray[watcher].objectarray;
			}
		}

		wait(0.05);
		for(watcher = 0;watcher < watchers.size;watcher++)
		{
			watchers[watcher] deleteweaponobjectarray();
		}

		if(msg == "disconnect")
		{
			return;
		}
	}
}

//Function Number: 78
saydamaged(orig,amount)
{
/#
	for(i = 0;i < 60;i++)
	{
		print3d(orig,"damaged! " + amount);
		wait(0.05);
	}
#/
}

//Function Number: 79
showheadicon(trigger)
{
	triggerdetectid = trigger.detectid;
	useid = -1;
	for(index = 0;index < 4;index++)
	{
		detectid = self.bombsquadicons[index].detectid;
		if(detectid == triggerdetectid)
		{
			return;
		}

		if(detectid == "")
		{
			useid = index;
		}
	}

	if(useid < 0)
	{
		return;
	}

	self.bombsquadids[triggerdetectid] = 1;
	self.bombsquadicons[useid].x = trigger.origin[0];
	self.bombsquadicons[useid].y = trigger.origin[1];
	self.bombsquadicons[useid].z = trigger.origin[2] + 24 + 128;
	self.bombsquadicons[useid] fadeovertime(0.25);
	self.bombsquadicons[useid].alpha = 1;
	self.bombsquadicons[useid].detectid = trigger.detectid;
	while(isalive(self) && IsDefined(trigger) && self istouching(trigger))
	{
		wait(0.05);
	}

	if(!(IsDefined(self)))
	{
		return;
	}

	self.bombsquadicons[useid].detectid = "";
	self.bombsquadicons[useid] fadeovertime(0.25);
	self.bombsquadicons[useid].alpha = 0;
	self.bombsquadids[triggerdetectid] = undefined;
}

//Function Number: 80
friendlyfirecheck(owner,attacker,forcedfriendlyfirerule)
{
	if(!(IsDefined(owner)))
	{
		return 1;
	}

	if(!(level.teambased))
	{
		return 1;
	}

	friendlyfirerule = level.friendlyfire;
	if(IsDefined(forcedfriendlyfirerule))
	{
		friendlyfirerule = forcedfriendlyfirerule;
	}

	if(friendlyfirerule != 0)
	{
		return 1;
	}

	if(attacker == owner)
	{
		return 1;
	}

	if(isplayer(attacker))
	{
		if(!(IsDefined(attacker.pers["team"])))
		{
			return 1;
		}

		if(attacker.pers["team"] != owner.pers["team"])
		{
			return 1;
		}
	}
	else if(isai(attacker))
	{
		if(attacker.aiteam != owner.pers["team"])
		{
			return 1;
		}
	}
	else if(isvehicle(attacker))
	{
		if(IsDefined(attacker.owner) && isplayer(attacker.owner))
		{
			if(attacker.owner.pers["team"] != owner.pers["team"])
			{
				return 1;
			}
		}
	}
}

//Function Number: 81
onspawnhatchettrigger(watcher,player)
{
	self endon("death");
	self setowner(player);
	self setteam(player.pers["team"]);
	self.owner = player;
	self.oldangles = self.angles;
	self waittillnotmoving();
	waittillframeend;
	if(player.pers["team"] == "spectator")
	{
		return;
	}

	triggerorigin = self.origin;
	triggerparentent = undefined;
	if(IsDefined(self.stucktoplayer))
	{
		if(isalive(self.stucktoplayer) || !IsDefined(self.stucktoplayer.body))
		{
			if(isalive(self.stucktoplayer))
			{
				triggerparentent = self;
				self unlink();
				self.angles = self.oldangles;
				self launch(VectorScale((1,1,1)));
				self waittillnotmoving();
				waittillframeend;
			}
			else
			{
				triggerparentent = self.stucktoplayer;
			}
		}
		else
		{
			triggerparentent = self.stucktoplayer.body;
		}
	}

	if(IsDefined(triggerparentent))
	{
		triggerorigin = 10 + VectorScale((0,0,1));
	}

	self.hatchetpickuptrigger = spawn("trigger_radius",triggerorigin,0,50,50);
	self.hatchetpickuptrigger enablelinkto();
	self.hatchetpickuptrigger linkto(self);
	if(IsDefined(triggerparentent))
	{
		self.hatchetpickuptrigger linkto(triggerparentent);
	}

	self thread watchhatchettrigger(self.hatchetpickuptrigger,watcher.pickup,watcher.pickupsoundplayer,watcher.pickupsound);
/#
	thread switch_team(self,watcher.weapon,player);
#/
	self thread watchshutdown(player);
}

//Function Number: 82
watchhatchettrigger(trigger,callback,playersoundonuse,npcsoundonuse)
{
	self endon("delete");
	self endon("hacked");
	while(1)
	{
		trigger waittill("trigger",player);
		if(!(isalive(player)))
		{
			continue;
		}

		if(!(player isonground()))
		{
			continue;
		}

		if(IsDefined(trigger.claimedby) && player != trigger.claimedby)
		{
			continue;
		}

		if(!(player hasweapon(self.name)))
		{
			continue;
		}

		curr_ammo = player getweaponammostock("hatchet_mp");
		maxammo = weaponmaxammo("hatchet_mp");
		if(player.grenadetypeprimary == "hatchet_mp")
		{
			maxammo = player.grenadetypeprimarycount;
		}
		else if(IsDefined(player.grenadetypesecondary) && player.grenadetypesecondary == "hatchet_mp")
		{
			maxammo = player.grenadetypesecondarycount;
		}

		if(curr_ammo >= maxammo)
		{
			continue;
		}

		if(IsDefined(playersoundonuse))
		{
			player playlocalsound(playersoundonuse);
		}

		if(IsDefined(npcsoundonuse))
		{
			player playsound(npcsoundonuse);
		}

		self thread [[ callback ]](player);
	}
}

//Function Number: 83
onspawnretrievableweaponobject(watcher,player)
{
	self endon("death");
	self endon("hacked");
	if(ishacked())
	{
		self thread watchshutdown(player);
		return;
	}

	self setowner(player);
	self setteam(player.pers["team"]);
	self.owner = player;
	self.oldangles = self.angles;
	self waittillnotmoving();
	if(IsDefined(watcher.activationdelay))
	{
		wait(watcher.activationdelay);
	}

	waittillframeend;
	if(player.pers["team"] == "spectator")
	{
		return;
	}

	triggerorigin = self.origin;
	triggerparentent = undefined;
	if(IsDefined(self.stucktoplayer))
	{
		if(isalive(self.stucktoplayer) || !IsDefined(self.stucktoplayer.body))
		{
			triggerparentent = self.stucktoplayer;
		}
		else
		{
			triggerparentent = self.stucktoplayer.body;
		}
	}

	if(IsDefined(triggerparentent))
	{
		triggerorigin = 10 + VectorScale((0,0,1));
	}
	else
	{
		up = AnglesToUp(self.angles);
		triggerorigin = self.origin + up;
	}

	if(IsDefined(watcher.adjusttriggerorigin))
	{
		triggerorigin = self [[ watcher.adjusttriggerorigin ]](triggerorigin);
	}

	self.pickuptrigger = spawn("trigger_radius_use",triggerorigin);
	self.pickuptrigger sethintlowpriority(1);
	self.pickuptrigger setcursorhint("HINT_NOICON",self);
	self.pickuptrigger enablelinkto();
	self.pickuptrigger linkto(self);
	self.pickuptrigger setinvisibletoall();
	self.pickuptrigger setvisibletoplayer(player);
	if(IsDefined(level.retrievehints[watcher.name]))
	{
		self.pickuptrigger sethintstring(level.retrievehints[watcher.name].hint);
	}
	else
	{
		self.pickuptrigger sethintstring(&"MP_GENERIC_PICKUP");
	}

	if(level.teambased)
	{
		self.pickuptrigger setteamfortrigger(player.pers["team"]);
	}
	else
	{
		self.pickuptrigger setteamfortrigger("none");
	}

	if(IsDefined(triggerparentent))
	{
		self.pickuptrigger linkto(triggerparentent);
	}

	if(watcher.enemydestroy)
	{
		self.enemytrigger = spawn("trigger_radius_use",triggerorigin);
		self.enemytrigger setcursorhint("HINT_NOICON",self);
		self.enemytrigger enablelinkto();
		self.enemytrigger linkto(self);
		self.enemytrigger setinvisibletoplayer(player);
		if(level.teambased)
		{
			self.enemytrigger setexcludeteamfortrigger(player.team);
			self.enemytrigger.triggerteamignore = self.team;
		}

		if(IsDefined(level.destroyhints[watcher.name]))
		{
			self.enemytrigger sethintstring(level.destroyhints[watcher.name].hint);
		}
		else
		{
			self.enemytrigger sethintstring(&"MP_GENERIC_DESTROY");
		}

		self thread watchusetrigger(self.enemytrigger,watcher.ondestroyed);
	}

	self thread watchusetrigger(self.pickuptrigger,watcher.pickup,watcher.pickupsoundplayer,watcher.pickupsound);
/#
	thread switch_team(self,watcher.weapon,player);
#/
	if(IsDefined(watcher.pickup_trigger_listener))
	{
		self thread [[ watcher.pickup_trigger_listener ]](self.pickuptrigger,player);
	}

	self thread watchshutdown(player);
}

//Function Number: 84
watch_trigger_visibility(triggers,weap_name)
{
	self notify("watchTriggerVisibility");
	self endon("watchTriggerVisibility");
	self endon("death");
	self endon("hacked");
	max_ammo = weaponmaxammo(weap_name);
	start_ammo = weaponstartammo(weap_name);
	ammo_to_check = 0;
	while(1)
	{
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			if(players[i] hasweapon(weap_name))
			{
				ammo_to_check = max_ammo;
				if(self.owner == players[i])
				{
					curr_ammo = players[i] getweaponammostock(weap_name) + players[i] getweaponammoclip(weap_name);
					if(weap_name == "hatchet_mp")
					{
						curr_ammo = players[i] getweaponammostock(weap_name);
					}

					if(curr_ammo < ammo_to_check)
					{
						triggers["owner_pickup"] setvisibletoplayer(players[i]);
						triggers["enemy_pickup"] setinvisibletoplayer(players[i]);
						continue;
					}

					triggers["owner_pickup"] setinvisibletoplayer(players[i]);
					triggers["enemy_pickup"] setinvisibletoplayer(players[i]);
					continue;
				}

				curr_ammo = players[i] getweaponammostock(weap_name) + players[i] getweaponammoclip(weap_name);
				if(weap_name == "hatchet_mp")
				{
					curr_ammo = players[i] getweaponammostock(weap_name);
				}

				if(curr_ammo < ammo_to_check)
				{
					triggers["owner_pickup"] setinvisibletoplayer(players[i]);
					triggers["enemy_pickup"] setvisibletoplayer(players[i]);
					continue;
				}

				triggers["owner_pickup"] setinvisibletoplayer(players[i]);
				triggers["enemy_pickup"] setinvisibletoplayer(players[i]);
			}
			else
			{
				triggers["owner_pickup"] setinvisibletoplayer(players[i]);
				triggers["enemy_pickup"] setinvisibletoplayer(players[i]);
			}
		}

		wait(0.05);
	}
}

//Function Number: 85
destroyent()
{
	self delete();
}

//Function Number: 86
pickup(player)
{
	if(self.name != "hatchet_mp" && IsDefined(self.owner) && self.owner != player)
	{
		return;
	}

	self.playdialog = 0;
	self destroyent();
	player giveweapon(self.name);
	clip_ammo = player getweaponammoclip(self.name);
	clip_max_ammo = weaponclipsize(self.name);
	if(clip_ammo < clip_max_ammo)
	{
		clip_ammo++;
	}

	player setweaponammoclip(self.name,clip_ammo);
}

//Function Number: 87
ondestroyed(attacker)
{
	playfx(level._effect["tacticalInsertionFizzle"],self.origin);
	self playsound("dst_tac_insert_break");
	self.owner maps/mp/gametypes_zm/_globallogic_audio::leaderdialogonplayer("equipment_destroyed","item_destroyed");
	self delete();
}

//Function Number: 88
watchshutdown(player)
{
	self waittill_any("death","hacked");
	pickuptrigger = self.pickuptrigger;
	hackertrigger = self.hackertrigger;
	hatchetpickuptrigger = self.hatchetpickuptrigger;
	enemytrigger = self.enemytrigger;
	if(IsDefined(pickuptrigger))
	{
		pickuptrigger delete();
	}

	if(IsDefined(hackertrigger))
	{
		if(IsDefined(hackertrigger.progressbar))
		{
			hackertrigger.progressbar destroyelem();
			hackertrigger.progresstext destroyelem();
		}

		hackertrigger delete();
	}

	if(IsDefined(hatchetpickuptrigger))
	{
		hatchetpickuptrigger delete();
	}

	if(IsDefined(enemytrigger))
	{
		enemytrigger delete();
	}
}

//Function Number: 89
watchusetrigger(trigger,callback,playersoundonuse,npcsoundonuse)
{
	self endon("delete");
	self endon("hacked");
	while(1)
	{
		trigger waittill("trigger",player);
		if(!(isalive(player)))
		{
			continue;
		}

		if(!(player isonground()))
		{
			continue;
		}

		if(IsDefined(trigger.triggerteam) && player.pers["team"] != trigger.triggerteam)
		{
			continue;
		}

		if(IsDefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore)
		{
			continue;
		}

		if(IsDefined(trigger.claimedby) && player != trigger.claimedby)
		{
			continue;
		}

		grenade = player.throwinggrenade;
		isequipment = isweaponequipment(player getcurrentweapon());
		if(IsDefined(isequipment) && isequipment)
		{
			grenade = 0;
		}

		if(player usebuttonpressed() && !grenade && !player meleebuttonpressed())
		{
			if(IsDefined(playersoundonuse))
			{
				player playlocalsound(playersoundonuse);
			}

			if(IsDefined(npcsoundonuse))
			{
				player playsound(npcsoundonuse);
			}

			self thread [[ callback ]](player);
		}
	}
}

//Function Number: 90
createretrievablehint(name,hint)
{
	retrievehint = spawnstruct();
	retrievehint.name = name;
	retrievehint.hint = hint;
	level.retrievehints[name] = retrievehint;
}

//Function Number: 91
createhackerhint(name,hint)
{
	hackerhint = spawnstruct();
	hackerhint.name = name;
	hackerhint.hint = hint;
	level.hackerhints[name] = hackerhint;
}

//Function Number: 92
createdestroyhint(name,hint)
{
	destroyhint = spawnstruct();
	destroyhint.name = name;
	destroyhint.hint = hint;
	level.destroyhints[name] = destroyhint;
}

//Function Number: 93
attachreconmodel(modelname,owner)
{
	if(!(IsDefined(self)))
	{
		return;
	}

	reconmodel = spawn("script_model",self.origin);
	reconmodel.angles = self.angles;
	reconmodel setmodel(modelname);
	reconmodel.model_name = modelname;
	reconmodel linkto(self);
	reconmodel setcontents(0);
	reconmodel resetreconmodelvisibility(owner);
	reconmodel thread watchreconmodelfordeath(self);
	reconmodel thread resetreconmodelonevent("joined_team",owner);
	reconmodel thread resetreconmodelonevent("player_spawned",owner);
}

//Function Number: 94
resetreconmodelvisibility(owner)
{
	if(!(IsDefined(self)))
	{
		return;
	}

	self setinvisibletoall();
	self setforcenocull();
	if(!(IsDefined(owner)))
	{
		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		if(!level.players[i] hasperk("specialty_detectexplosive") && !level.players[i] hasperk("specialty_showenemyequipment"))
		{
		}
		else if(level.players[i].team == "spectator")
		{
		}
		else
		{
			hasreconmodel = 0;
			if(level.players[i] hasperk("specialty_detectexplosive"))
			{
				switch(self.model_name)
				{
					case "t6_wpn_c4_world_detect":
					case "t6_wpn_claymore_world_detect":
						hasreconmodel = 1;
						break;

					default:
						break;
				}
			}

			if(level.players[i] hasperk("specialty_showenemyequipment"))
			{
				switch(self.model_name)
				{
					case "t5_weapon_scrambler_world_detect":
					case "t6_wpn_bouncing_betty_world_detect":
					case "t6_wpn_c4_world_detect":
					case "t6_wpn_claymore_world_detect":
					case "t6_wpn_motion_sensor_world_detect":
					case "t6_wpn_tac_insert_detect":
					case "t6_wpn_taser_mine_world_detect":
					case "t6_wpn_trophy_system_world_detect":
						hasreconmodel = 1;
						break;

					default:
						break;
				}
			}

			if(!(hasreconmodel))
			{
			}
			else
			{
				isenemy = 1;
				if(level.teambased)
				{
					if(level.players[i].team == owner.team)
					{
						isenemy = 0;
					}
				}
				else if(level.players[i] == owner)
				{
					isenemy = 0;
				}

				if(isenemy)
				{
					self setvisibletoplayer(level.players[i]);
				}
			}
		}
	}
}

//Function Number: 95
watchreconmodelfordeath(parentent)
{
	self endon("death");
	parentent waittill_any("death","hacked");
	self delete();
}

//Function Number: 96
resetreconmodelonevent(eventname,owner)
{
	self endon("death");
	for(;;)
	{
		level waittill(eventname,newowner);
		if(IsDefined(newowner))
		{
			owner = newowner;
		}

		self resetreconmodelvisibility(owner);
	}
}

//Function Number: 97
switch_team(entity,weapon_name,owner)
{
/#
#/
}