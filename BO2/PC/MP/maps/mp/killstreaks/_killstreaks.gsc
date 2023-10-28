/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_killstreaks.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 86
 * Decompile Time: 22 ms
 * Timestamp: 10/28/2023 12:10:44 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_class;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/killstreaks/_emp;
#include maps/mp/killstreaks/_helicopter;
#include maps/mp/killstreaks/_helicopter_guard;
#include maps/mp/killstreaks/_helicopter_gunner;
#include maps/mp/killstreaks/_killstreak_weapons;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/killstreaks/_missile_drone;
#include maps/mp/killstreaks/_missile_swarm;
#include maps/mp/killstreaks/_planemortar;
#include maps/mp/killstreaks/_qrdrone;
#include maps/mp/killstreaks/_radar;
#include maps/mp/killstreaks/_rcbomb;
#include maps/mp/killstreaks/_remote_weapons;
#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_remotemortar;
#include maps/mp/killstreaks/_spyplane;
#include maps/mp/killstreaks/_straferun;
#include maps/mp/killstreaks/_supplydrop;
#include maps/mp/killstreaks/_turret_killstreak;

//Function Number: 1
init()
{
	precachestring(&"MP_KILLSTREAK_N");
	if(GetDvar(#"2417B16D") == "")
	{
		setdvar("scr_allow_killstreak_building","0");
	}

	level.killstreaks = [];
	level.killstreakweapons = [];
	level.menureferenceforkillstreak = [];
	level.numkillstreakreservedobjectives = 0;
	level.killstreakcounter = 0;
	if(!(IsDefined(level.roundstartkillstreakdelay)))
	{
		level.roundstartkillstreakdelay = 0;
	}

	level.killstreak_timers = [];
	foreach(team in level.teams)
	{
		level.killstreak_timers[team] = [];
	}

	level.iskillstreakweapon = ::iskillstreakweapon;
	maps/mp/killstreaks/_supplydrop::init();
	maps/mp/killstreaks/_ai_tank::init();
	maps/mp/killstreaks/_airsupport::initairsupport();
	maps/mp/killstreaks/_dogs::initkillstreak();
	maps/mp/killstreaks/_radar::init();
	maps/mp/killstreaks/_emp::init();
	maps/mp/killstreaks/_helicopter::init();
	maps/mp/killstreaks/_helicopter_guard::init();
	maps/mp/killstreaks/_helicopter_gunner::init();
	maps/mp/killstreaks/_killstreakrules::init();
	maps/mp/killstreaks/_killstreak_weapons::init();
	maps/mp/killstreaks/_missile_drone::init();
	maps/mp/killstreaks/_missile_swarm::init();
	maps/mp/killstreaks/_planemortar::init();
	maps/mp/killstreaks/_rcbomb::init();
	maps/mp/killstreaks/_remote_weapons::init();
	maps/mp/killstreaks/_remotemissile::init();
	maps/mp/killstreaks/_remotemortar::init();
	maps/mp/killstreaks/_qrdrone::init();
	maps/mp/killstreaks/_spyplane::init();
	maps/mp/killstreaks/_straferun::init();
	maps/mp/killstreaks/_turret_killstreak::init();
	level thread onplayerconnect();
/#
	level thread killstreak_debug_think();
#/
}

//Function Number: 2
registerkillstreak(killstreaktype,killstreakweapon,killstreakmenuname,killstreakusagekey,killstreakusefunction,killstreakdelaystreak,weaponholdallowed,killstreakstatsname)
{
/#
	assert(IsDefined(killstreaktype),"Can not register a killstreak without a valid type name.");
#/
/#
	assert(!IsDefined(level.killstreaks[killstreaktype]),"Killstreak " + killstreaktype + " already registered");
#/
/#
	assert(IsDefined(killstreakusefunction),"No use function defined for killstreak " + killstreaktype);
#/
	level.killstreaks[killstreaktype] = spawnstruct();
	level.killstreaks[killstreaktype].killstreaklevel = int(tablelookup("mp/statstable.csv",4,killstreakmenuname,5));
	level.killstreaks[killstreaktype].momentumcost = int(tablelookup("mp/statstable.csv",4,killstreakmenuname,16));
	level.killstreaks[killstreaktype].iconmaterial = tablelookup("mp/statstable.csv",4,killstreakmenuname,6);
	level.killstreaks[killstreaktype].quantity = int(tablelookup("mp/statstable.csv",4,killstreakmenuname,5));
	level.killstreaks[killstreaktype].usagekey = killstreakusagekey;
	level.killstreaks[killstreaktype].usefunction = killstreakusefunction;
	level.killstreaks[killstreaktype].menuname = killstreakmenuname;
	level.killstreaks[killstreaktype].delaystreak = killstreakdelaystreak;
	level.killstreaks[killstreaktype].allowassists = 0;
	level.killstreaks[killstreaktype].overrideentitycameraindemo = 0;
	level.killstreaks[killstreaktype].teamkillpenaltyscale = 1;
	if(IsDefined(killstreakweapon))
	{
/#
		assert(!IsDefined(level.killstreakweapons[killstreakweapon]),"Can not have a weapon associated with multiple killstreaks.");
#/
		precacheitem(killstreakweapon);
		level.killstreaks[killstreaktype].weapon = killstreakweapon;
		level.killstreakweapons[killstreakweapon] = killstreaktype;
	}

	if(!(IsDefined(weaponholdallowed)))
	{
		weaponholdallowed = 0;
	}

	if(IsDefined(killstreakstatsname))
	{
		level.killstreaks[killstreaktype].killstreakstatsname = killstreakstatsname;
	}

	level.killstreaks[killstreaktype].weaponholdallowed = weaponholdallowed;
	level.menureferenceforkillstreak[killstreakmenuname] = killstreaktype;
}

//Function Number: 3
registerkillstreakstrings(killstreaktype,receivedtext,notusabletext,inboundtext,inboundnearplayertext)
{
/#
	assert(IsDefined(killstreaktype),"Can not register a killstreak without a valid type name.");
#/
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak needs to be registered before calling registerKillstreakStrings.");
#/
	level.killstreaks[killstreaktype].receivedtext = receivedtext;
	level.killstreaks[killstreaktype].notavailabletext = notusabletext;
	level.killstreaks[killstreaktype].inboundtext = inboundtext;
	level.killstreaks[killstreaktype].inboundnearplayertext = inboundnearplayertext;
	if(IsDefined(level.killstreaks[killstreaktype].receivedtext))
	{
		precachestring(level.killstreaks[killstreaktype].receivedtext);
	}

	if(IsDefined(level.killstreaks[killstreaktype].notavailabletext))
	{
		precachestring(level.killstreaks[killstreaktype].notavailabletext);
	}

	if(IsDefined(level.killstreaks[killstreaktype].inboundtext))
	{
		precachestring(level.killstreaks[killstreaktype].inboundtext);
	}

	if(IsDefined(level.killstreaks[killstreaktype].inboundnearplayertext))
	{
		precachestring(level.killstreaks[killstreaktype].inboundnearplayertext);
	}
}

//Function Number: 4
registerkillstreakdialog(killstreaktype,receiveddialog,friendlystartdialog,friendlyenddialog,enemystartdialog,enemyenddialog,dialog)
{
/#
	assert(IsDefined(killstreaktype),"Can not register a killstreak without a valid type name.");
#/
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak needs to be registered before calling registerKillstreakDialog.");
#/
	precachestring(istring(receiveddialog));
	level.killstreaks[killstreaktype].informdialog = receiveddialog;
	game["dialog"][killstreaktype + "_start"] = friendlystartdialog;
	game["dialog"][killstreaktype + "_end"] = friendlyenddialog;
	game["dialog"][killstreaktype + "_enemy_start"] = enemystartdialog;
	game["dialog"][killstreaktype + "_enemy_end"] = enemyenddialog;
	game["dialog"][killstreaktype] = dialog;
}

//Function Number: 5
registerkillstreakaltweapon(killstreaktype,weapon)
{
/#
	assert(IsDefined(killstreaktype),"Can not register a killstreak without a valid type name.");
#/
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak needs to be registered before calling registerKillstreakAltWeapon.");
#/
	if(level.killstreaks[killstreaktype].weapon == weapon)
	{
		return;
	}

	if(!(IsDefined(level.killstreaks[killstreaktype].altweapons)))
	{
		level.killstreaks[killstreaktype].altweapons = [];
	}

	if(!(IsDefined(level.killstreakweapons[weapon])))
	{
		level.killstreakweapons[weapon] = killstreaktype;
	}

	level.killstreaks[killstreaktype].altweapons[level.killstreaks[killstreaktype].altweapons.size] = weapon;
}

//Function Number: 6
registerkillstreakremoteoverrideweapon(killstreaktype,weapon)
{
/#
	assert(IsDefined(killstreaktype),"Can not register a killstreak without a valid type name.");
#/
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak needs to be registered before calling registerKillstreakAltWeapon.");
#/
	if(level.killstreaks[killstreaktype].weapon == weapon)
	{
		return;
	}

	if(!(IsDefined(level.killstreaks[killstreaktype].remoteoverrideweapons)))
	{
		level.killstreaks[killstreaktype].remoteoverrideweapons = [];
	}

	if(!(IsDefined(level.killstreakweapons[weapon])))
	{
		level.killstreakweapons[weapon] = killstreaktype;
	}

	level.killstreaks[killstreaktype].remoteoverrideweapons[level.killstreaks[killstreaktype].remoteoverrideweapons.size] = weapon;
}

//Function Number: 7
iskillstreakremoteoverrideweapon(killstreaktype,weapon)
{
	if(IsDefined(level.killstreaks[killstreaktype].remoteoverrideweapons))
	{
		for(i = 0;i < level.killstreaks[killstreaktype].remoteoverrideweapons.size;i++)
		{
			if(level.killstreaks[killstreaktype].remoteoverrideweapons[i] == weapon)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 8
registerkillstreakdevdvar(killstreaktype,dvar)
{
/#
	assert(IsDefined(killstreaktype),"Can not register a killstreak without a valid type name.");
#/
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak needs to be registered before calling registerKillstreakDevDvar.");
#/
	level.killstreaks[killstreaktype].devdvar = dvar;
}

//Function Number: 9
allowkillstreakassists(killstreaktype,allow)
{
	level.killstreaks[killstreaktype].allowassists = allow;
}

//Function Number: 10
setkillstreakteamkillpenaltyscale(killstreaktype,scale)
{
	level.killstreaks[killstreaktype].teamkillpenaltyscale = scale;
}

//Function Number: 11
overrideentitycameraindemo(killstreaktype,value)
{
	level.killstreaks[killstreaktype].overrideentitycameraindemo = value;
}

//Function Number: 12
iskillstreakavailable(killstreak)
{
	if(IsDefined(level.menureferenceforkillstreak[killstreak]))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

//Function Number: 13
getkillstreakbymenuname(killstreak)
{
	return level.menureferenceforkillstreak[killstreak];
}

//Function Number: 14
getkillstreakmenuname(killstreaktype)
{
/#
	assert(IsDefined(level.killstreaks[killstreaktype]));
#/
	return level.killstreaks[killstreaktype].menuname;
}

//Function Number: 15
drawline(start,end,timeslice,color)
{
/#
	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		line(start,end,(1,0,0),0,1);
		wait(0.05);
	}
#/
}

//Function Number: 16
getkillstreaklevel(index,killstreak)
{
	killstreaklevel = level.killstreaks[getkillstreakbymenuname(killstreak)].killstreaklevel;
	if(GetDvarInt(#"826EB3B9") == 2)
	{
		if(IsDefined(self.killstreak[index]) && killstreak == self.killstreak[index])
		{
			killsrequired = GetDvarInt(#"8F4AAEF4" + index + 1 + "_kills");
			if(killsrequired)
			{
				killstreaklevel = GetDvarInt(#"8F4AAEF4" + index + 1 + "_kills");
			}
		}
	}

	return killstreaklevel;
}

//Function Number: 17
givekillstreakifstreakcountmatches(index,killstreak,streakcount)
{
	pixbeginevent("giveKillstreakIfStreakCountMatches");
/#
	if(!(IsDefined(killstreak)))
	{
		println("Killstreak Undefined.\n");
	}

	if(IsDefined(killstreak))
	{
		println("Killstreak listed as." + killstreak + "\n");
	}

	if(!(iskillstreakavailable(killstreak)))
	{
		println("Killstreak Not Available.\n");
	}
#/
	if(self.pers["killstreaksEarnedThisKillstreak"] > index && isroundbased())
	{
		hasalreadyearnedkillstreak = 1;
	}
	else
	{
		hasalreadyearnedkillstreak = 0;
	}

	if(IsDefined(killstreak) && iskillstreakavailable(killstreak) && !hasalreadyearnedkillstreak)
	{
		killstreaklevel = getkillstreaklevel(index,killstreak);
		if(self hasperk("specialty_killstreak"))
		{
			reduction = GetDvarInt(#"9159E179");
			killstreaklevel = killstreaklevel - reduction;
			if(killstreaklevel <= 0)
			{
				killstreaklevel = 1;
			}
		}

		if(killstreaklevel == streakcount)
		{
			self givekillstreak(getkillstreakbymenuname(killstreak),streakcount);
			self.pers["killstreaksEarnedThisKillstreak"] = index + 1;
			pixendevent();
			return 1;
		}
	}

	pixendevent();
	return 0;
}

//Function Number: 18
givekillstreakforstreak()
{
	if(!(iskillstreaksenabled()))
	{
		return;
	}

	if(!(IsDefined(self.pers["totalKillstreakCount"])))
	{
		self.pers["totalKillstreakCount"] = 0;
	}

	given = 0;
	for(i = 0;i < self.killstreak.size;i++)
	{
		given = given | givekillstreakifstreakcountmatches(i,self.killstreak[i],self.pers["cur_kill_streak"]);
	}
}

//Function Number: 19
isonakillstreak()
{
	onkillstreak = 0;
	if(!(IsDefined(self.pers["kill_streak_before_death"])))
	{
		self.pers["kill_streak_before_death"] = 0;
	}

	streakplusone = self.pers["kill_streak_before_death"] + 1;
	if(self.pers["kill_streak_before_death"] >= 5)
	{
		onkillstreak = 1;
	}

	return onkillstreak;
}

//Function Number: 20
doesstreakcountmatch(killstreak,streakcount)
{
	if(IsDefined(killstreak) && iskillstreakavailable(killstreak))
	{
		killstreaklevel = level.killstreaks[getkillstreakbymenuname(killstreak)].killstreaklevel;
		if(killstreaklevel == streakcount)
		{
			return 1;
		}
	}
}

//Function Number: 21
streaknotify(streakval)
{
	self endon("disconnect");
	self waittill("playerKilledChallengesProcessed");
	wait(0.05);
	notifydata = spawnstruct();
	notifydata.titlelabel = &"MP_KILLSTREAK_N";
	notifydata.titletext = streakval;
	notifydata.iconheight = 32;
	self maps/mp/gametypes/_hud_message::notifymessage(notifydata);
}

//Function Number: 22
givekillstreak(killstreaktype,streak,suppressnotification,noxp)
{
	pixbeginevent("giveKillstreak");
	self endon("disconnect");
	level endon("game_ended");
	had_to_delay = 0;
	killstreakgiven = 0;
	if(IsDefined(noxp))
	{
		if(self givekillstreakinternal(killstreaktype,undefined,noxp))
		{
			killstreakgiven = 1;
			self addkillstreaktoqueue(level.killstreaks[killstreaktype].menuname,streak,killstreaktype,noxp);
		}
	}
	else if(self givekillstreakinternal(killstreaktype,noxp))
	{
		killstreakgiven = 1;
		self addkillstreaktoqueue(level.killstreaks[killstreaktype].menuname,streak,killstreaktype,noxp);
	}

	pixendevent();
}

//Function Number: 23
removeoldestkillstreak()
{
	if(IsDefined(self.pers["killstreaks"][0]))
	{
		currentweapon = self getcurrentweapon();
		if(currentweapon == self.pers["killstreaks"][0])
		{
			primaries = self getweaponslistprimaries();
			if(primaries.size > 0)
			{
				self switchtoweapon(primaries[0]);
			}
		}

		self notify("oldest_killstreak_removed",self.pers["killstreaks"][0],self.pers["killstreak_unique_id"][0]);
		self maps/mp/killstreaks/_killstreaks::removeusedkillstreak(self.pers["killstreaks"][0],self.pers["killstreak_unique_id"][0]);
	}
}

//Function Number: 24
givekillstreakinternal(killstreaktype,do_not_update_death_count,noxp)
{
	if(level.gameended)
	{
		return 0;
	}

	if(!(iskillstreaksenabled()))
	{
		return 0;
	}

	if(!(IsDefined(level.killstreaks[killstreaktype])))
	{
		return 0;
	}

	if(!(IsDefined(self.pers["killstreaks"])))
	{
		self.pers["killstreaks"] = [];
	}

	if(!(IsDefined(self.pers["killstreak_has_been_used"])))
	{
		self.pers["killstreak_has_been_used"] = [];
	}

	if(!(IsDefined(self.pers["killstreak_unique_id"])))
	{
		self.pers["killstreak_unique_id"] = [];
	}

	self.pers["killstreaks"][self.pers["killstreaks"].size] = killstreaktype;
	self.pers["killstreak_unique_id"][self.pers["killstreak_unique_id"].size] = level.killstreakcounter;
	level.killstreakcounter++;
	if(self.pers["killstreaks"].size > level.maxinventoryscorestreaks)
	{
		self removeoldestkillstreak();
	}

	if(IsDefined(noxp))
	{
		self.pers["killstreak_has_been_used"][self.pers["killstreak_has_been_used"].size] = noxp;
	}
	else
	{
		self.pers["killstreak_has_been_used"][self.pers["killstreak_has_been_used"].size] = 0;
	}

	weapon = getkillstreakweapon(killstreaktype);
	ammocount = givekillstreakweapon(weapon,1);
	self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size] = ammocount;
	return 1;
}

//Function Number: 25
addkillstreaktoqueue(menuname,streakcount,hardpointtype,nonotify)
{
	killstreaktablenumber = level.killstreakindices[menuname];
	if(!(IsDefined(killstreaktablenumber)))
	{
		return;
	}

	if(IsDefined(nonotify) && nonotify)
	{
		return;
	}

	informdialog = getkillstreakinformdialog(hardpointtype);
	self playkillstreakreadydialog(hardpointtype);
	self luinotifyevent(&"killstreak_received",2,killstreaktablenumber,istring(informdialog));
	self luinotifyeventtospectators(&"killstreak_received",2,killstreaktablenumber,istring(informdialog));
}

//Function Number: 26
haskillstreakequipped()
{
	currentweapon = self getcurrentweapon();
	keys = getarraykeys(level.killstreaks);
	for(i = 0;i < keys.size;i++)
	{
		if(level.killstreaks[keys[i]].weapon == currentweapon)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
getkillstreakfromweapon(weapon)
{
	keys = getarraykeys(level.killstreaks);
	for(i = 0;i < keys.size;i++)
	{
		if(level.killstreaks[keys[i]].weapon == weapon)
		{
			return keys[i];
		}

		if(IsDefined(level.killstreaks[keys[i]].altweapons))
		{
			foreach(altweapon in level.killstreaks[keys[i]].altweapons)
			{
				if(altweapon == weapon)
				{
					return keys[i];
				}
			}
		}
	}

	return undefined;
}

//Function Number: 28
givekillstreakweapon(weapon,isinventory,usestoredammo)
{
	currentweapon = self getcurrentweapon();
	if(!IsDefined(level.usingmomentum) || !level.usingmomentum)
	{
		weaponslist = self getweaponslist();
		for(idx = 0;idx < weaponslist.size;idx++)
		{
			carriedweapon = weaponslist[idx];
			if(currentweapon == carriedweapon)
			{
			}
			else if(currentweapon == "none")
			{
			}
			else
			{
				switch(carriedweapon)
				{
					case "m32_mp":
					case "minigun_mp":
						break;
				}

				if(iskillstreakweapon(carriedweapon))
				{
					self takeweapon(carriedweapon);
				}
			}
		}
	}

	if(currentweapon != weapon && self hasweapon(weapon) == 0)
	{
		self takeweapon(weapon);
		self giveweapon(weapon);
	}

	if(IsDefined(level.usingmomentum) && level.usingmomentum)
	{
		self setinventoryweapon(weapon);
		if(maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(weapon))
		{
			if(!(IsDefined(self.pers["held_killstreak_ammo_count"][weapon])))
			{
				self.pers["held_killstreak_ammo_count"][weapon] = 0;
			}

			if(!(IsDefined(self.pers["held_killstreak_clip_count"][weapon])))
			{
				self.pers["held_killstreak_clip_count"][weapon] = weaponclipsize(weapon);
			}

			if(!(IsDefined(self.pers["killstreak_quantity"][weapon])))
			{
				self.pers["killstreak_quantity"][weapon] = 0;
			}

			if(currentweapon == weapon && !maps/mp/killstreaks/_killstreak_weapons::isheldinventorykillstreakweapon(weapon))
			{
				return weaponmaxammo(weapon);
			}
			else if(IsDefined(usestoredammo) && usestoredammo && self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1] > 0)
			{
				switch(weapon)
				{
					case "inventory_minigun_mp":
						return self.pers["held_killstreak_ammo_count"][weapon];
IsDefined(self.minigunactive) && self.minigunactive
						break;

					case "inventory_m32_mp":
						return self.pers["held_killstreak_ammo_count"][weapon];
IsDefined(self.m32active) && self.m32active
						break;

					default:
						break;
				}

				self.pers["held_killstreak_ammo_count"][weapon] = self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1];
				self maps/mp/gametypes/_class::setweaponammooverall(weapon,self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1]);
			}
			else
			{
				self.pers["held_killstreak_ammo_count"][weapon] = weaponmaxammo(weapon);
				self.pers["held_killstreak_clip_count"][weapon] = weaponclipsize(weapon);
				self maps/mp/gametypes/_class::setweaponammooverall(weapon,self.pers["held_killstreak_ammo_count"][weapon]);
			}

			return self.pers["held_killstreak_ammo_count"][weapon];
		}
		else
		{
			if(weapon == "inventory_ai_tank_drop_mp" || weapon == "inventory_supplydrop_mp" || weapon == "inventory_minigun_drop_mp" || weapon == "inventory_m32_drop_mp" || weapon == "inventory_missile_drone_mp")
			{
				delta = 1;
			}
			else
			{
				delta = 0;
			}

			return changekillstreakquantity(weapon,delta);
		}
	}
	else
	{
		self setactionslot(4,"weapon",weapon);
		return 1;
	}
}

//Function Number: 29
activatenextkillstreak(do_not_update_death_count)
{
	if(level.gameended)
	{
		return 0;
	}

	if(IsDefined(level.usingmomentum) && level.usingmomentum)
	{
		self setinventoryweapon("");
	}
	else
	{
		self setactionslot(4,"");
	}

	if(!IsDefined(self.pers["killstreaks"]) || self.pers["killstreaks"].size == 0)
	{
		return 0;
	}

	killstreaktype = self.pers["killstreaks"][self.pers["killstreaks"].size - 1];
	if(!(IsDefined(level.killstreaks[killstreaktype])))
	{
		return 0;
	}

	weapon = level.killstreaks[killstreaktype].weapon;
	wait(0.05);
	ammocount = givekillstreakweapon(weapon,0,1);
	if(maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(weapon))
	{
		self setweaponammoclip(weapon,self.pers["held_killstreak_clip_count"][weapon]);
		self setweaponammostock(weapon,ammocount - self.pers["held_killstreak_clip_count"][weapon]);
	}

	if(!IsDefined(do_not_update_death_count) || do_not_update_death_count != 0)
	{
		self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
	}

	return 1;
}

//Function Number: 30
takekillstreak(killstreaktype)
{
	if(level.gameended)
	{
		return;
	}

	if(!(iskillstreaksenabled()))
	{
		return 0;
	}

	if(IsDefined(self.selectinglocation))
	{
		return 0;
	}

	if(!(IsDefined(level.killstreaks[killstreaktype])))
	{
		return 0;
	}

	self takeweapon(killstreaktype);
	self setactionslot(4,"");
	self.pers["killstreakItemDeathCount" + killstreaktype] = 0;
	return 1;
}

//Function Number: 31
giveownedkillstreak()
{
	if(IsDefined(self.pers["killstreaks"]) && self.pers["killstreaks"].size > 0)
	{
		self activatenextkillstreak(0);
	}
}

//Function Number: 32
switchtolastnonkillstreakweapon()
{
	if(IsDefined(self.laststand) && self.laststand && IsDefined(self.laststandpistol) && self hasweapon(self.laststandpistol))
	{
		self switchtoweapon(self.laststandpistol);
	}
	else if(self hasweapon(self.lastnonkillstreakweapon))
	{
		self switchtoweapon(self.lastnonkillstreakweapon);
	}
	else if(self hasweapon(self.lastdroppableweapon))
	{
		self switchtoweapon(self.lastdroppableweapon);
	}
	else
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
changeweaponafterkillstreak(killstreak,takeweapon)
{
	self endon("disconnect");
	self endon("death");
	killstreak_weapon = getkillstreakweapon(killstreak);
	currentweapon = self getcurrentweapon();
	result = self switchtolastnonkillstreakweapon();
}

//Function Number: 34
changekillstreakquantity(killstreakweapon,delta)
{
	quantity = self.pers["killstreak_quantity"][killstreakweapon];
	if(!(IsDefined(quantity)))
	{
		quantity = 0;
	}

	previousquantity = quantity;
	if(delta < 0)
	{
/#
		assert(quantity > 0);
	}
#/
	quantity = quantity + delta;
	if(quantity > level.scorestreaksmaxstacking)
	{
		quantity = level.scorestreaksmaxstacking;
	}

	if(self hasweapon(killstreakweapon) == 0)
	{
		self takeweapon(killstreakweapon);
		self giveweapon(killstreakweapon);
		self seteverhadweaponall(1);
	}

	self.pers["killstreak_quantity"][killstreakweapon] = quantity;
	self setweaponammoclip(killstreakweapon,quantity);
	return quantity;
}

//Function Number: 35
haskillstreakinclass(killstreakmenuname)
{
	foreach(equippedkillstreak in self.killstreak)
	{
		if(equippedkillstreak == killstreakmenuname)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 36
removekillstreakwhendone(killstreak,haskillstreakbeenused,isfrominventory)
{
	self endon("disconnect");
	self waittill("killstreak_done",successful,killstreaktype);
	if(successful)
	{
		logstring("killstreak: " + getkillstreakmenuname(killstreak));
		killstreak_weapon = getkillstreakweapon(killstreak);
		recordstreakindex = undefined;
		if(IsDefined(level.killstreaks[killstreak].menuname))
		{
			recordstreakindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
			if(IsDefined(recordstreakindex))
			{
				self recordkillstreakevent(recordstreakindex);
			}
		}

		if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks)
		{
			if(IsDefined(isfrominventory) && isfrominventory)
			{
				removeusedkillstreak(killstreak);
				if(self getinventoryweapon() == killstreak_weapon)
				{
					self setinventoryweapon("");
				}
			}
			else
			{
				self changekillstreakquantity(killstreak_weapon,-1);
			}
		}
		else if(IsDefined(level.usingmomentum) && level.usingmomentum)
		{
			if(IsDefined(isfrominventory) && isfrominventory && self getinventoryweapon() == killstreak_weapon)
			{
				removeusedkillstreak(killstreak);
				self setinventoryweapon("");
			}
			else
			{
				maps/mp/gametypes/_globallogic_score::_setplayermomentum(self,self.momentum - level.killstreaks[killstreaktype].momentumcost);
			}
		}
		else
		{
			removeusedkillstreak(killstreak);
		}

		if(!IsDefined(level.usingmomentum) || !level.usingmomentum)
		{
			self setactionslot(4,"");
		}

		success = 1;
	}

	waittillframeend;
	currentweapon = self getcurrentweapon();
	if(maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(killstreaktype) && currentweapon == killstreaktype)
	{
		return;
	}

	if(successful && !self haskillstreakinclass(getkillstreakmenuname(killstreak)) || IsDefined(isfrominventory) && isfrominventory)
	{
		changeweaponafterkillstreak(killstreak,1);
	}
	else
	{
		killstreakforcurrentweapon = getkillstreakfromweapon(currentweapon);
		if(maps/mp/killstreaks/_killstreak_weapons::isgameplayweapon(currentweapon))
		{
			if(is_true(self.isplanting) || is_true(self.isdefusing))
			{
				return;
			}
		}

		if(successful || !IsDefined(killstreakforcurrentweapon) || killstreakforcurrentweapon == killstreak)
		{
			changeweaponafterkillstreak(killstreak,0);
		}
	}

	if(!IsDefined(level.usingmomentum) || !level.usingmomentum || IsDefined(isfrominventory) && isfrominventory)
	{
		if(successful)
		{
			activatenextkillstreak();
		}
	}
}

//Function Number: 37
usekillstreak(killstreak,isfrominventory)
{
	haskillstreakbeenused = getiftopkillstreakhasbeenused();
	if(IsDefined(self.selectinglocation))
	{
		return;
	}

	self thread removekillstreakwhendone(killstreak,haskillstreakbeenused,isfrominventory);
	self thread triggerkillstreak(killstreak,isfrominventory);
}

//Function Number: 38
removeusedkillstreak(killstreak,killstreakid)
{
	killstreakindex = undefined;
	for(i = self.pers["killstreaks"].size - 1;i >= 0;i--)
	{
		if(self.pers["killstreaks"][i] == killstreak)
		{
			if(IsDefined(killstreakid) && self.pers["killstreak_unique_id"][i] != killstreakid)
			{
			}
			else
			{
				killstreakindex = i;
				break;
			}
		}
	}

	if(!(IsDefined(killstreakindex)))
	{
		return;
	}

	if(!(self haskillstreakinclass(getkillstreakmenuname(killstreak))))
	{
		self thread takeweaponafteruse(killstreak);
	}

	arraysize = self.pers["killstreaks"].size;
	for(i = killstreakindex;i < arraysize - 1;i++)
	{
		self.pers["killstreaks"][i] = self.pers["killstreaks"][i + 1];
		self.pers["killstreak_has_been_used"][i] = self.pers["killstreak_has_been_used"][i + 1];
		self.pers["killstreak_unique_id"][i] = self.pers["killstreak_unique_id"][i + 1];
		self.pers["killstreak_ammo_count"][i] = self.pers["killstreak_ammo_count"][i + 1];
	}

	self.pers["killstreaks"][arraysize - 1] = undefined;
	self.pers["killstreak_has_been_used"][arraysize - 1] = undefined;
	self.pers["killstreak_unique_id"][arraysize - 1] = undefined;
	self.pers["killstreak_ammo_count"][arraysize - 1] = undefined;
}

//Function Number: 39
takeweaponafteruse(killstreak)
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("joined_spectators");
	self waittill("weapon_change");
	inventoryweapon = self getinventoryweapon();
	if(inventoryweapon != killstreak)
	{
		self takeweapon(killstreak);
	}
}

//Function Number: 40
gettopkillstreak()
{
	if(self.pers["killstreaks"].size == 0)
	{
		return undefined;
	}

	return self.pers["killstreaks"][self.pers["killstreaks"].size - 1];
}

//Function Number: 41
getiftopkillstreakhasbeenused()
{
	if(!IsDefined(level.usingmomentum) || !level.usingmomentum)
	{
		if(self.pers["killstreak_has_been_used"].size == 0)
		{
			return undefined;
		}

		return self.pers["killstreak_has_been_used"][self.pers["killstreak_has_been_used"].size - 1];
	}
}

//Function Number: 42
gettopkillstreakuniqueid()
{
	if(self.pers["killstreak_unique_id"].size == 0)
	{
		return undefined;
	}

	return self.pers["killstreak_unique_id"][self.pers["killstreak_unique_id"].size - 1];
}

//Function Number: 43
getkillstreakindexbyid(killstreakid)
{
	for(index = self.pers["killstreak_unique_id"].size - 1;index >= 0;index--)
	{
		if(self.pers["killstreak_unique_id"][index] == killstreakid)
		{
			return index;
		}
	}

	return undefined;
}

//Function Number: 44
getkillstreakweapon(killstreak)
{
	if(!(IsDefined(killstreak)))
	{
		return "none";
	}

/#
	assert(IsDefined(level.killstreaks[killstreak]));
#/
	return level.killstreaks[killstreak].weapon;
}

//Function Number: 45
getkillstreakmomentumcost(killstreak)
{
	if(!IsDefined(level.usingmomentum) || !level.usingmomentum)
	{
		return 0;
	}

	if(!(IsDefined(killstreak)))
	{
		return 0;
	}

/#
	assert(IsDefined(level.killstreaks[killstreak]));
#/
	return level.killstreaks[killstreak].momentumcost;
}

//Function Number: 46
getkillstreakforweapon(weapon)
{
	return level.killstreakweapons[weapon];
}

//Function Number: 47
iskillstreakweapon(weapon)
{
	if(isweaponassociatedwithkillstreak(weapon))
	{
		return 1;
	}

	switch(weapon)
	{
		case "briefcase_bomb_defuse_mp":
		case "briefcase_bomb_mp":
		case "none":
		case "scavenger_item_mp":
		case "vcs_controller_mp":
			return 0;
	}

	if(isweaponspecificuse(weapon))
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
iskillstreakweaponassistallowed(weapon)
{
	killstreak = getkillstreakforweapon(weapon);
	if(!(IsDefined(killstreak)))
	{
		return 0;
	}

	if(level.killstreaks[killstreak].allowassists)
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
getkillstreakteamkillpenaltyscale(weapon)
{
	killstreak = getkillstreakforweapon(weapon);
	if(!(IsDefined(killstreak)))
	{
		return 1;
	}

	return level.killstreaks[killstreak].teamkillpenaltyscale;
}

//Function Number: 50
shouldoverrideentitycameraindemo(player,weapon)
{
	killstreak = getkillstreakforweapon(weapon);
	if(!(IsDefined(killstreak)))
	{
		return 0;
	}

	if(level.killstreaks[killstreak].overrideentitycameraindemo)
	{
		return 1;
	}

	if(IsDefined(player.remoteweapon) && IsDefined(player.remoteweapon.controlled) && player.remoteweapon.controlled)
	{
		return 1;
	}
}

//Function Number: 51
trackweaponusage()
{
	self endon("death");
	self endon("disconnect");
	self.lastnonkillstreakweapon = self getcurrentweapon();
	lastvalidpimary = self getcurrentweapon();
	if(self.lastnonkillstreakweapon == "none")
	{
		weapons = self getweaponslistprimaries();
		if(weapons.size > 0)
		{
			self.lastnonkillstreakweapon = weapons[0];
		}
		else
		{
			self.lastnonkillstreakweapon = "knife_mp";
		}
	}

/#
	assert(self.lastnonkillstreakweapon != "none");
	for(;;)
	{
#/
		currentweapon = self getcurrentweapon();
		self waittill("weapon_change",weapon);
		if(maps/mp/gametypes/_weapons::isprimaryweapon(weapon))
		{
			lastvalidpimary = weapon;
		}

		if(weapon == self.lastnonkillstreakweapon)
		{
			continue;
		}

		switch(weapon)
		{
			case "knife_mp":
			case "none":
				break;
		}

		if(maps/mp/killstreaks/_killstreak_weapons::isgameplayweapon(weapon))
		{
			continue;
		}

		name = getkillstreakforweapon(weapon);
		if(IsDefined(name) && !maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(weapon))
		{
			killstreak = level.killstreaks[name];
			continue;
		}

		if(currentweapon != "none" && isweaponequipment(currentweapon) && maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(self.lastnonkillstreakweapon))
		{
			self.lastnonkillstreakweapon = lastvalidpimary;
			continue;
		}

		if(isweaponequipment(weapon))
		{
			continue;
		}

		self.lastnonkillstreakweapon = weapon;
	}
}

//Function Number: 52
killstreakwaiter()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self thread trackweaponusage();
	self giveownedkillstreak();
	for(;;)
	{
		self waittill("weapon_change",weapon);
		if(!(iskillstreakweapon(weapon)))
		{
			continue;
		}

		killstreak = getkillstreakforweapon(weapon);
		if(!IsDefined(level.usingmomentum) || !level.usingmomentum)
		{
			killstreak = gettopkillstreak();
			if(weapon != getkillstreakweapon(killstreak))
			{
				continue;
			}
		}

		if(iskillstreakremoteoverrideweapon(killstreak,weapon))
		{
			continue;
		}

		inventorybuttonpressed = self inventorybuttonpressed() || IsDefined(self.pers["isBot"]);
		waittillframeend;
		if(IsDefined(self.usingkillstreakheldweapon) && self.usingkillstreakheldweapon && maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(killstreak))
		{
			continue;
		}

		isfrominventory = undefined;
		inventoryweapon = self getinventoryweapon();
		if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks)
		{
			if(weapon == inventoryweapon && inventorybuttonpressed)
			{
				isfrominventory = 1;
				continue;
			}

			if(weapon == inventoryweapon && weapon == "inventory_missile_drone_mp" || weapon == "inventory_ai_tank_drop_mp")
			{
				self switchtolastnonkillstreakweapon();
				continue;
			}
			else if(self getammocount(weapon) <= 0 && weapon != "killstreak_ai_tank_mp")
			{
				self switchtolastnonkillstreakweapon();
				continue;
			}
		}
		else if(IsDefined(level.usingmomentum) && level.usingmomentum)
		{
			if(weapon == self getinventoryweapon() && inventorybuttonpressed)
			{
				isfrominventory = 1;
			}
			else if(self.momentum < level.killstreaks[killstreak].momentumcost)
			{
				self switchtolastnonkillstreakweapon();
				continue;
			}
		}

		thread usekillstreak(killstreak,isfrominventory);
		if(IsDefined(self.selectinglocation) && GetDvarInt(#"27EB3EF") == 0)
		{
			event = self waittill_any_return("cancel_location","game_ended","used","weapon_change");
			if(event == "cancel_location" || event == "weapon_change")
			{
				wait(1);
			}
		}
	}
}

//Function Number: 53
shoulddelaykillstreak(killstreaktype)
{
	if(!(IsDefined(level.starttime)))
	{
		return 0;
	}

	if(level.roundstartkillstreakdelay < GetTime() - level.starttime - level.discardtime / 1000)
	{
		return 0;
	}

	if(!(isdelayablekillstreak(killstreaktype)))
	{
		return 0;
	}

	if(maps/mp/killstreaks/_killstreak_weapons::isheldkillstreakweapon(killstreaktype))
	{
		return 0;
	}

	if(isfirstround() || isoneround())
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
isdelayablekillstreak(killstreaktype)
{
	if(IsDefined(level.killstreaks[killstreaktype]) && IsDefined(level.killstreaks[killstreaktype].delaystreak) && level.killstreaks[killstreaktype].delaystreak)
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
getxpamountforkillstreak(killstreaktype)
{
	xpamount = 0;
	switch(level.killstreaks[killstreaktype].killstreaklevel)
	{
		case "1":
		case "2":
		case "3":
		case "4":
			xpamount = 100;
			break;

		case "5":
			xpamount = 150;
			break;

		case "6":
		case "7":
			xpamount = 200;
			break;

		case "8":
			xpamount = 250;
			break;

		case "9":
			xpamount = 300;
			break;

		case "10":
		case "11":
			xpamount = 350;
			break;

		case "12":
		case "13":
		case "14":
		case "15":
			xpamount = 500;
			break;
	}

	return xpamount;
}

//Function Number: 56
triggerkillstreak(killstreaktype,isfrominventory)
{
/#
	assert(IsDefined(level.killstreaks[killstreaktype].usefunction),"No use function defined for killstreak " + killstreaktype);
#/
	self.usingkillstreakfrominventory = isfrominventory;
	if(level.infinalkillcam)
	{
		return 0;
	}

	if(shoulddelaykillstreak(killstreaktype))
	{
		timeleft = int(level.roundstartkillstreakdelay - maps/mp/gametypes/_globallogic_utils::gettimepassed() / 1000);
		if(!(timeleft))
		{
			timeleft = 1;
		}

		self iprintlnbold(&"MP_UNAVAILABLE_FOR_N"," " + timeleft + " ",&"EXE_SECONDS");
	}
	else if([[ level.killstreaks[killstreaktype].usefunction ]](killstreaktype))
	{
		if(IsDefined(self))
		{
			if(!(IsDefined(self.pers[level.killstreaks[killstreaktype].usagekey])))
			{
				self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
			}

			self.pers[level.killstreaks[killstreaktype].usagekey]++;
			self notify("killstreak_used",killstreaktype);
			self notify("killstreak_done",1,killstreaktype);
		}

		self.usingkillstreakfrominventory = undefined;
		return 1;
	}

	self.usingkillstreakfrominventory = undefined;
	if(IsDefined(self))
	{
		self notify("killstreak_done",0,killstreaktype);
	}

	return 0;
}

//Function Number: 57
addtokillstreakcount(weapon)
{
	if(!(IsDefined(self.pers["totalKillstreakCount"])))
	{
		self.pers["totalKillstreakCount"] = 0;
	}

	self.pers["totalKillstreakCount"]++;
}

//Function Number: 58
isweaponassociatedwithkillstreak(weapon)
{
	return IsDefined(level.killstreakweapons[weapon]);
}

//Function Number: 59
getfirstvalidkillstreakaltweapon(killstreaktype)
{
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak not registered.");
#/
	if(IsDefined(level.killstreaks[killstreaktype].altweapons))
	{
		for(i = 0;i < level.killstreaks[killstreaktype].altweapons.size;i++)
		{
			if(IsDefined(level.killstreaks[killstreaktype].altweapons[i]))
			{
				return level.killstreaks[killstreaktype].altweapons[i];
			}
		}
	}

	return "none";
}

//Function Number: 60
shouldgivekillstreak(weapon)
{
	killstreakbuilding = GetDvarInt(#"2417B16D");
	if(killstreakbuilding == 0)
	{
		if(isweaponassociatedwithkillstreak(weapon))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 61
pointisindangerarea(point,targetpos,radius)
{
	return distance2d(point,targetpos) <= radius * 1.25;
}

//Function Number: 62
printkillstreakstarttext(killstreaktype,owner,team,targetpos,dangerradius)
{
	if(!(IsDefined(level.killstreaks[killstreaktype])))
	{
		return;
	}

	if(level.teambased)
	{
		players = level.players;
		if(!level.hardcoremode && IsDefined(level.killstreaks[killstreaktype].inboundnearplayertext))
		{
			for(i = 0;i < players.size;i++)
			{
				if(isalive(players[i]) && IsDefined(players[i].pers["team"]) && players[i].pers["team"] == team)
				{
					if(pointisindangerarea(players[i].origin,targetpos,dangerradius))
					{
						players[i] iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
					}
				}
			}
		}

		if(IsDefined(level.killstreaks[killstreaktype]))
		{
			for(i = 0;i < level.players.size;i++)
			{
				player = level.players[i];
				playerteam = player.pers["team"];
				if(IsDefined(playerteam))
				{
					if(playerteam == team)
					{
						player iprintln(level.killstreaks[killstreaktype].inboundtext,owner);
					}
				}
			}
		}
	}
	else if(!level.hardcoremode && IsDefined(level.killstreaks[killstreaktype].inboundnearplayertext))
	{
		if(pointisindangerarea(owner.origin,targetpos,dangerradius))
		{
			owner iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
		}
	}
}

//Function Number: 63
playkillstreakstartdialog(killstreaktype,team,playnonteambasedenemysounds)
{
	if(!(IsDefined(level.killstreaks[killstreaktype])))
	{
		return;
	}

	if(killstreaktype == "radar_mp" && level.teambased)
	{
		if(GetTime() - level.radartimers[team] > 30000)
		{
			maps/mp/gametypes/_globallogic_audio::leaderdialog(killstreaktype + "_start",team);
			maps/mp/gametypes/_globallogic_audio::leaderdialogforotherteams(killstreaktype + "_enemy_start",team);
			level.radartimers[team] = GetTime();
		}
		else
		{
			self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer(killstreaktype + "_start");
		}

		return;
	}

	if(level.teambased)
	{
		maps/mp/gametypes/_globallogic_audio::leaderdialog(killstreaktype + "_start",team);
		maps/mp/gametypes/_globallogic_audio::leaderdialogforotherteams(killstreaktype + "_enemy_start",team);
	}
	else
	{
		self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer(killstreaktype + "_start");
		selfarray = [];
		selfarray[0] = self;
		maps/mp/gametypes/_globallogic_audio::leaderdialog(killstreaktype + "_enemy_start",undefined,undefined,selfarray);
	}
}

//Function Number: 64
playkillstreakreadydialog(killstreaktype)
{
	if(!IsDefined(level.gameended) || !level.gameended)
	{
		self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer(killstreaktype);
	}
}

//Function Number: 65
getkillstreakinformdialog(killstreaktype)
{
/#
	assert(IsDefined(level.killstreaks[killstreaktype].informdialog));
#/
	if(IsDefined(level.killstreaks[killstreaktype].informdialog))
	{
		return level.killstreaks[killstreaktype].informdialog;
	}

	return "";
}

//Function Number: 66
playkillstreakenddialog(killstreaktype,team)
{
	if(!(IsDefined(level.killstreaks[killstreaktype])))
	{
		return;
	}

	if(level.teambased)
	{
		maps/mp/gametypes/_globallogic_audio::leaderdialog(killstreaktype + "_end",team);
		maps/mp/gametypes/_globallogic_audio::leaderdialogforotherteams(killstreaktype + "_enemy_end",team);
	}
	else
	{
		self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer(killstreaktype + "_end");
	}
}

//Function Number: 67
getkillstreakusagebykillstreak(killstreaktype)
{
/#
	assert(IsDefined(level.killstreaks[killstreaktype]),"Killstreak needs to be registered before calling getKillstreakUsage.");
#/
	return getkillstreakusage(level.killstreaks[killstreaktype].usagekey);
}

//Function Number: 68
getkillstreakusage(usagekey)
{
	if(!(IsDefined(self.pers[usagekey])))
	{
		return 0;
	}

	return self.pers[usagekey];
}

//Function Number: 69
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
		player thread onjoinedteam();
	}
}

//Function Number: 70
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		pixbeginevent("_killstreaks.gsc/onPlayerSpawned");
		giveownedkillstreak();
		if(!(IsDefined(self.pers["killstreaks"])))
		{
			self.pers["killstreaks"] = [];
		}

		if(!(IsDefined(self.pers["killstreak_has_been_used"])))
		{
			self.pers["killstreak_has_been_used"] = [];
		}

		if(!(IsDefined(self.pers["killstreak_unique_id"])))
		{
			self.pers["killstreak_unique_id"] = [];
		}

		if(!(IsDefined(self.pers["killstreak_ammo_count"])))
		{
			self.pers["killstreak_ammo_count"] = [];
		}

		size = self.pers["killstreaks"].size;
		if(size > 0)
		{
			playkillstreakreadydialog(self.pers["killstreaks"][size - 1]);
		}

		pixendevent();
	}
}

//Function Number: 71
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		self setinventoryweapon("");
		self.pers["cur_kill_streak"] = 0;
		self.pers["cur_total_kill_streak"] = 0;
		self setplayercurrentstreak(0);
		self.pers["totalKillstreakCount"] = 0;
		self.pers["killstreaks"] = [];
		self.pers["killstreak_has_been_used"] = [];
		self.pers["killstreak_unique_id"] = [];
		self.pers["killstreak_ammo_count"] = [];
		if(IsDefined(level.usingscorestreaks) && level.usingscorestreaks)
		{
			self.pers["killstreak_quantity"] = [];
			self.pers["held_killstreak_ammo_count"] = [];
			self.pers["held_killstreak_clip_count"] = [];
		}
	}
}

//Function Number: 72
createkillstreaktimerforteam(killstreaktype,xposition,team)
{
/#
	assert(IsDefined(level.killstreak_timers[team]));
#/
	killstreaktimer = spawnstruct();
	killstreaktimer.team = team;
	killstreaktimer.icon = createservericon(level.killstreaks[killstreaktype].iconmaterial,36,36,team);
	killstreaktimer.icon.horzalign = "user_left";
	killstreaktimer.icon.vertalign = "user_top";
	killstreaktimer.icon.x = xposition + 15;
	killstreaktimer.icon.y = 100;
	killstreaktimer.icon.alpha = 0;
	killstreaktimer.killstreaktype = killstreaktype;
	level.killstreak_timers[team][level.killstreak_timers[team].size] = killstreaktimer;
}

//Function Number: 73
createkillstreaktimer(killstreaktype)
{
	if(killstreaktype == "radar_mp")
	{
		xposition = 0;
	}
	else if(killstreaktype == "counteruav_mp")
	{
		xposition = 20;
	}
	else if(killstreaktype == "missile_swarm_mp")
	{
		xposition = 40;
	}
	else if(killstreaktype == "emp_mp")
	{
		xposition = 60;
	}
	else if(killstreaktype == "radardirection_mp")
	{
		xposition = 80;
	}
	else
	{
		xposition = 0;
	}

	foreach(team in level.teams)
	{
		createkillstreaktimerforteam(killstreaktype,xposition,team);
	}
}

//Function Number: 74
destroykillstreaktimers()
{
	level notify("endKillstreakTimers");
	if(IsDefined(level.killstreak_timers))
	{
		foreach(team in level.teams)
		{
			foreach(killstreaktimer in level.killstreak_timers[team])
			{
				killstreaktimer.icon destroyelem();
			}
		}

		level.killstreak_timers = undefined;
	}
}

//Function Number: 75
getkillstreaktimerforkillstreak(team,killstreaktype,duration)
{
	endtime = GetTime() + duration * 1000;
	numkillstreaktimers = level.killstreak_timers[team].size;
	killstreakslot = undefined;
	targetindex = 0;
	for(i = 0;i < numkillstreaktimers;i++)
	{
		killstreaktimer = level.killstreak_timers[team][i];
		if(IsDefined(killstreaktimer.killstreaktype) && killstreaktimer.killstreaktype == killstreaktype)
		{
			killstreakslot = i;
			break;
		}
		else if(!IsDefined(killstreaktimer.killstreaktype) && !IsDefined(killstreakslot))
		{
			killstreakslot = i;
		}
	}

	if(IsDefined(killstreakslot))
	{
		killstreaktimer = level.killstreak_timers[team][killstreakslot];
		killstreaktimer.endtime = endtime;
		killstreaktimer.icon.alpha = 1;
		return killstreaktimer;
	}
}

//Function Number: 76
freekillstreaktimer(killstreaktimer)
{
	killstreaktimer.icon.alpha = 0.2;
	killstreaktimer.endtime = undefined;
}

//Function Number: 77
killstreaktimer(killstreaktype,team,duration)
{
	level endon("endKillstreakTimers");
	if(level.gameended)
	{
		return;
	}

	killstreaktimer = getkillstreaktimerforkillstreak(team,killstreaktype,duration);
	if(!(IsDefined(killstreaktimer)))
	{
		return;
	}

	eventname = team + "_" + killstreaktype;
	level notify(eventname);
	level endon(eventname);
	blinkingduration = 5;
	if(duration > 0)
	{
		wait(duration - blinkingduration);
		while(blinkingduration > 0)
		{
			killstreaktimer.icon fadeovertime(0.5);
			killstreaktimer.icon.alpha = 1;
			wait(0.5);
			killstreaktimer.icon fadeovertime(0.5);
			killstreaktimer.icon.alpha = 0;
			wait(0.5);
			blinkingduration = blinkingduration - 1;
		}
	}

	freekillstreaktimer(killstreaktimer);
}

//Function Number: 78
setkillstreaktimer(killstreaktype,team,duration)
{
	thread killstreaktimer(killstreaktype,team,duration);
}

//Function Number: 79
initridekillstreak(streak)
{
	self disableusability();
	result = self initridekillstreak_internal(streak);
	if(IsDefined(self))
	{
		self enableusability();
	}

	return result;
}

//Function Number: 80
watchforemoveremoteweapon()
{
	self endon("endWatchFoRemoveRemoteWeapon");
	for(;;)
	{
		self waittill("remove_remote_weapon");
		self maps/mp/killstreaks/_killstreaks::switchtolastnonkillstreakweapon();
		self enableusability();
	}
}

//Function Number: 81
initridekillstreak_internal(streak)
{
	if(IsDefined(streak) && streak == "qrdrone" || streak == "killstreak_remote_turret_mp" || streak == "killstreak_ai_tank_mp" || streak == "qrdrone_mp")
	{
		laptopwait = "timeout";
	}
	else
	{
		laptopwait = self waittill_any_timeout(0.6,"disconnect","death","weapon_switch_started");
	}

	maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	if(laptopwait == "weapon_switch_started")
	{
		return "fail";
	}

	if(!(isalive(self)))
	{
		return "fail";
	}

	if(laptopwait == "disconnect" || laptopwait == "death")
	{
		if(laptopwait == "disconnect")
		{
			return "disconnect";
		}

		if(self.team == "spectator")
		{
			return "fail";
		}

		return "success";
	}

	if(self isempjammed())
	{
		return "fail";
	}

	if(self isinteractingwithobject())
	{
		return "fail";
	}

	self thread maps/mp/gametypes/_hud::fadetoblackforxsec(0,0.2,0.4,0.25);
	self thread watchforemoveremoteweapon();
	blackoutwait = self waittill_any_timeout(0.6,"disconnect","death");
	self notify("endWatchFoRemoveRemoteWeapon");
	maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	if(blackoutwait != "disconnect")
	{
		self thread clearrideintro(1);
		if(self.team == "spectator")
		{
			return "fail";
		}
	}

	if(self isonladder())
	{
		return "fail";
	}

	if(!(isalive(self)))
	{
		return "fail";
	}

	if(self isempjammed())
	{
		return "fail";
	}

	if(self isinteractingwithobject())
	{
		return "fail";
	}

	if(blackoutwait == "disconnect")
	{
		return "disconnect";
	}
	else
	{
		return "success";
	}
}

//Function Number: 82
clearrideintro(delay)
{
	self endon("disconnect");
	if(IsDefined(delay))
	{
		wait(delay);
	}

	self thread maps/mp/gametypes/_hud::fadetoblackforxsec(0,0,0,0);
}

//Function Number: 83
killstreak_debug_think()
{
/#
	setdvar("debug_killstreak","");
	for(;;)
	{
		cmd = GetDvar(#"C394DFE1");
		switch(cmd)
		{
			case "data_dump":
				killstreak_data_dump();
				break;
		}

		if(cmd != "")
		{
			setdvar("debug_killstreak","");
		}

		wait(0.5);
	}
#/
}

//Function Number: 84
killstreak_data_dump()
{
/#
	iprintln("Killstreak Data Sent to Console");
	println("##### Killstreak Data #####");
	println("killstreak,killstreaklevel,weapon,altweapon1,altweapon2,altweapon3,altweapon4,type1,type2,type3,type4");
	keys = getarraykeys(level.killstreaks);
	for(i = 0;i < keys.size;i++)
	{
		data = level.killstreaks[keys[i]];
		type_data = level.killstreaktype[keys[i]];
		print(keys[i] + ",");
		print(data.killstreaklevel + ",");
		print(data.weapon + ",");
		alt = 0;
		if(IsDefined(data.altweapons))
		{
/#
			assert(data.altweapons.size <= 4);
#/
			for(alt = 0;alt < data.altweapons.size;alt++)
			{
				print(data.altweapons[alt] + ",");
			}
		}

		while(alt < 4)
		{
			print(",");
			alt++;
		}

		type = 0;
		if(IsDefined(type_data))
		{
/#
			assert(type_data.size < 4);
#/
			type_keys = getarraykeys(type_data);
			while(type < type_keys.size)
			{
				if(type_data[type_keys[type]] == 1)
				{
					print(type_keys[type] + ",");
				}

				type++;
			}
		}

		while(type < 4)
		{
			print(",");
			type++;
		}

		println("");
	}

	println("##### End Killstreak Data #####");
#/
}

//Function Number: 85
isinteractingwithobject()
{
	if(self iscarryingturret())
	{
		return 1;
	}

	if(is_true(self.isplanting))
	{
		return 1;
	}

	if(is_true(self.isdefusing))
	{
		return 1;
	}

	return 0;
}

//Function Number: 86
clearusingremote()
{
	if(!(IsDefined(self)))
	{
		return;
	}

	if(IsDefined(self.carryicon))
	{
		self.carryicon.alpha = 1;
	}

	self.usingremote = undefined;
	self enableoffhandweapons();
	curweapon = self getcurrentweapon();
	if(isalive(self))
	{
		if(curweapon == "none" || maps/mp/killstreaks/_killstreaks::iskillstreakweapon(curweapon))
		{
			last_weapon = self getlastweapon();
			if(IsDefined(last_weapon))
			{
				self switchtoweapon(last_weapon);
			}
		}
	}

	self freezecontrolswrapper(0);
	self notify("stopped_using_remote");
}