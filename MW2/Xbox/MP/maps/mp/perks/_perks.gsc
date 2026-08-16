/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perks.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level.perkfuncs = [];
	precacheshader("combathigh_overlay");
	precacheshader("specialty_painkiller");
	precachemodel("weapon_riot_shield_mp");
	precachemodel("viewmodel_riot_shield_mp");
	precachestring(&"MPUI_CHANGING_KIT");
	level.spawnglowmodel["enemy"] = "mil_emergency_flare_mp";
	level.spawnglowmodel["friendly"] = "mil_emergency_flare_mp";
	level.spawnglow["enemy"] = loadfx("misc/flare_ambient");
	level.spawnglow["friendly"] = loadfx("misc/flare_ambient_green");
	level.c4death = loadfx("explosions/oxygen_tank_explosion");
	level.spawnfire = loadfx("props/barrelexp");
	precachemodel(level.spawnglowmodel["friendly"]);
	precachemodel(level.spawnglowmodel["enemy"]);
	precachestring(&"MP_DESTROY_TI");
	precacheshaders();
	level._effect["ricochet"] = loadfx("impacts/large_metalhit_1");
	level.scriptperks = [];
	level.perksetfuncs = [];
	level.perkunsetfuncs = [];
	level.fauxperks = [];
	level.scriptperks["specialty_blastshield"] = 1;
	level.scriptperks["_specialty_blastshield"] = 1;
	level.scriptperks["specialty_akimbo"] = 1;
	level.scriptperks["specialty_siege"] = 1;
	level.scriptperks["specialty_falldamage"] = 1;
	level.scriptperks["specialty_fmj"] = 1;
	level.scriptperks["specialty_shield"] = 1;
	level.scriptperks["specialty_feigndeath"] = 1;
	level.scriptperks["specialty_shellshock"] = 1;
	level.scriptperks["specialty_delaymine"] = 1;
	level.scriptperks["specialty_localjammer"] = 1;
	level.scriptperks["specialty_thermal"] = 1;
	level.scriptperks["specialty_finalstand"] = 1;
	level.scriptperks["specialty_blackbox"] = 1;
	level.scriptperks["specialty_steelnerves"] = 1;
	level.scriptperks["specialty_flashgrenade"] = 1;
	level.scriptperks["specialty_smokegrenade"] = 1;
	level.scriptperks["specialty_concussiongrenade"] = 1;
	level.scriptperks["specialty_challenger"] = 1;
	level.scriptperks["specialty_tacticalinsertion"] = 1;
	level.scriptperks["specialty_saboteur"] = 1;
	level.scriptperks["specialty_endgame"] = 1;
	level.scriptperks["specialty_rearview"] = 1;
	level.scriptperks["specialty_hardline"] = 1;
	level.scriptperks["specialty_ac130"] = 1;
	level.scriptperks["specialty_sentry_minigun"] = 1;
	level.scriptperks["specialty_predator_missile"] = 1;
	level.scriptperks["specialty_helicopter_minigun"] = 1;
	level.scriptperks["specialty_tank"] = 1;
	level.scriptperks["specialty_precision_airstrike"] = 1;
	level.scriptperks["specialty_bling"] = 1;
	level.scriptperks["specialty_carepackage"] = 1;
	level.scriptperks["specialty_onemanarmy"] = 1;
	level.scriptperks["specialty_littlebird_support"] = 1;
	level.scriptperks["specialty_primarydeath"] = 1;
	level.scriptperks["specialty_secondarybling"] = 1;
	level.scriptperks["specialty_combathigh"] = 1;
	level.scriptperks["specialty_c4death"] = 1;
	level.scriptperks["specialty_explosivedamage"] = 1;
	level.scriptperks["specialty_copycat"] = 1;
	level.scriptperks["specialty_laststandoffhand"] = 1;
	level.scriptperks["specialty_dangerclose"] = 1;
	level.scriptperks["specialty_extraspecialduration"] = 1;
	level.scriptperks["specialty_rollover"] = 1;
	level.scriptperks["specialty_armorpiercing"] = 1;
	level.scriptperks["specialty_omaquickchange"] = 1;
	level.scriptperks["specialty_fastmeleerecovery"] = 1;
	level.scriptperks["_specialty_rearview"] = 1;
	level.scriptperks["_specialty_onemanarmy"] = 1;
	level.fauxperks["specialty_tacticalinsertion"] = 1;
	level.fauxperks["specialty_shield"] = 1;
	level.perksetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::setblastshield;
	level.perkunsetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::unsetblastshield;
	level.perksetfuncs["specialty_siege"] = ::maps\mp\perks\_perkfunctions::setsiege;
	level.perkunsetfuncs["specialty_siege"] = ::maps\mp\perks\_perkfunctions::unsetsiege;
	level.perksetfuncs["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::setfreefall;
	level.perkunsetfuncs["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::unsetfreefall;
	level.perksetfuncs["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::setlocaljammer;
	level.perkunsetfuncs["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::unsetlocaljammer;
	level.perksetfuncs["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::setthermal;
	level.perkunsetfuncs["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::unsetthermal;
	level.perksetfuncs["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::setblackbox;
	level.perkunsetfuncs["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::unsetblackbox;
	level.perksetfuncs["specialty_lightweight"] = ::maps\mp\perks\_perkfunctions::setlightweight;
	level.perkunsetfuncs["specialty_lightweight"] = ::maps\mp\perks\_perkfunctions::unsetlightweight;
	level.perksetfuncs["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::setsteelnerves;
	level.perkunsetfuncs["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::unsetsteelnerves;
	level.perksetfuncs["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::setdelaymine;
	level.perkunsetfuncs["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::unsetdelaymine;
	level.perksetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::setfinalstand;
	level.perkunsetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::unsetfinalstand;
	level.perksetfuncs["specialty_combathigh"] = ::maps\mp\perks\_perkfunctions::setcombathigh;
	level.perkunsetfuncs["specialty_combathigh"] = ::maps\mp\perks\_perkfunctions::unsetcombathigh;
	level.perksetfuncs["specialty_challenger"] = ::maps\mp\perks\_perkfunctions::setchallenger;
	level.perkunsetfuncs["specialty_challenger"] = ::maps\mp\perks\_perkfunctions::unsetchallenger;
	level.perksetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::setsaboteur;
	level.perkunsetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::unsetsaboteur;
	level.perksetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::setendgame;
	level.perkunsetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::unsetendgame;
	level.perksetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::setrearview;
	level.perkunsetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::unsetrearview;
	level.perksetfuncs["specialty_ac130"] = ::maps\mp\perks\_perkfunctions::setac130;
	level.perkunsetfuncs["specialty_ac130"] = ::maps\mp\perks\_perkfunctions::unsetac130;
	level.perksetfuncs["specialty_sentry_minigun"] = ::maps\mp\perks\_perkfunctions::setsentryminigun;
	level.perkunsetfuncs["specialty_sentry_minigun"] = ::maps\mp\perks\_perkfunctions::unsetsentryminigun;
	level.perksetfuncs["specialty_predator_missile"] = ::maps\mp\perks\_perkfunctions::setpredatormissile;
	level.perkunsetfuncs["specialty_predator_missile"] = ::maps\mp\perks\_perkfunctions::unsetpredatormissile;
	level.perksetfuncs["specialty_tank"] = ::maps\mp\perks\_perkfunctions::settank;
	level.perkunsetfuncs["specialty_tank"] = ::maps\mp\perks\_perkfunctions::unsettank;
	level.perksetfuncs["specialty_precision_airstrike"] = ::maps\mp\perks\_perkfunctions::setprecision_airstrike;
	level.perkunsetfuncs["specialty_precision_airstrike"] = ::maps\mp\perks\_perkfunctions::unsetprecision_airstrike;
	level.perksetfuncs["specialty_helicopter_minigun"] = ::maps\mp\perks\_perkfunctions::sethelicopterminigun;
	level.perkunsetfuncs["specialty_helicopter_minigun"] = ::maps\mp\perks\_perkfunctions::unsethelicopterminigun;
	level.perksetfuncs["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::setcarepackage;
	level.perkunsetfuncs["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::unsetcarepackage;
	level.perksetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::setonemanarmy;
	level.perkunsetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::unsetonemanarmy;
	level.perksetfuncs["specialty_littlebird_support"] = ::maps\mp\perks\_perkfunctions::setlittlebirdsupport;
	level.perkunsetfuncs["specialty_littlebird_support"] = ::maps\mp\perks\_perkfunctions::unsetlittlebirdsupport;
	level.perksetfuncs["specialty_c4death"] = ::maps\mp\perks\_perkfunctions::setc4death;
	level.perkunsetfuncs["specialty_c4death"] = ::maps\mp\perks\_perkfunctions::unsetc4death;
	level.perksetfuncs["specialty_tacticalinsertion"] = ::maps\mp\perks\_perkfunctions::settacticalinsertion;
	level.perkunsetfuncs["specialty_tacticalinsertion"] = ::maps\mp\perks\_perkfunctions::unsettacticalinsertion;
	initperkdvars();
	level thread onplayerconnect();
}

precacheshaders()
{
	precacheshader("specialty_blastshield");
}

giveperk(perkname)
{
	if(issubstr(perkname, "_mp"))
	{
		if(perkname == "frag_grenade_mp")
		{
			self setoffhandprimaryclass("frag");
		}

		if(perkname == "throwingknife_mp")
		{
			self setoffhandprimaryclass("throwingknife");
		}

		maps\mp\_utility::_giveweapon(perkname, 0);
		self givestartammo(perkname);
		self setperk(perkname, 0);
		return;
	}

	if(issubstr(perkname, "specialty_null") || issubstr(perkname, "specialty_weapon_"))
	{
		self setperk(perkname, 0);
		return;
	}

	maps\mp\_utility::_setperk(perkname);
}

validateperk(perkindex, perkname)
{
	if(getdvarint("scr_game_perks") == 0)
	{
		if(tablelookup("mp/perkTable.csv", 1, perkname, 5) != "equipment")
		{
			return "specialty_null";
		}
	}

	return perkname;
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	self.perks = [];
	self.weaponlist = [];
	self.omaclasschanged = 0;
	for(;;)
	{
		self waittill("spawned_player");
		self.omaclasschanged = 0;
		thread gambitusetracker();
	}
}

drawline(start, end, timeslice)
{
	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		wait 0.05;
	}
}

cac_modified_damage(victim, attacker, damage, meansofdeath, weapon, param_363, impactdir, hitloc)
{
	damageadd = 0;
	if(maps\mp\_utility::isprimarydamage(meansofdeath))
	{
		if(isplayer(attacker) && weaponinheritsperks(weapon) && attacker maps\mp\_utility::_hasperk("specialty_bulletdamage") && victim maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
			damageadd = damageadd + 0;
		}
		else if(isplayer(attacker) && weaponinheritsperks(weapon) && attacker maps\mp\_utility::_hasperk("specialty_bulletdamage"))
		{
			damageadd = damageadd + damage * level.bulletdamagemod;
		}
		else if(victim maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
			damageadd = damageadd - damage * 1 - level.armorvestmod;
		}

		if(isplayer(attacker) && attacker maps\mp\_utility::_hasperk("specialty_fmj") && victim maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
			damageadd = damageadd + damage * level.hollowpointdamagemod;
		}
	}
	else if(maps\mp\_utility::isexplosivedamage(meansofdeath))
	{
		if(isplayer(attacker) && weaponinheritsperks(weapon) && attacker maps\mp\_utility::_hasperk("specialty_explosivedamage") && victim maps\mp\_utility::_hasperk("_specialty_blastshield"))
		{
			damageadd = damageadd + 0;
		}
		else if(isplayer(attacker) && weaponinheritsperks(weapon) && attacker maps\mp\_utility::_hasperk("specialty_explosivedamage"))
		{
			damageadd = damageadd + damage * level.explosivedamagemod;
		}
		else if(victim maps\mp\_utility::_hasperk("_specialty_blastshield"))
		{
			damageadd = damageadd - damage * 1 - level.blastshieldmod;
		}

		if(maps\mp\_utility::iskillstreakweapon(weapon) && isplayer(attacker) && attacker maps\mp\_utility::_hasperk("specialty_dangerclose"))
		{
			damageadd = damageadd + damage * level.dangerclosemod;
		}
	}
	else if(meansofdeath == "MOD_FALLING")
	{
		if(victim maps\mp\_utility::_hasperk("specialty_falldamage"))
		{
			damageadd = 0;
			damage = 0;
		}
	}

	if(victim.xpscaler == 2 && isdefined(attacker) && isplayer(attacker) || attacker.classname == "scrip_vehicle")
	{
		damageadd = damageadd + 200;
	}

	if(victim maps\mp\_utility::_hasperk("specialty_combathigh"))
	{
		if(isdefined(self.damageblockedtotal) && !level.teambased || isdefined(attacker) && isdefined(attacker.team) && victim.team != attacker.team)
		{
			damagetotal = damage + damageadd;
			damageblocked = damagetotal - damagetotal / 3;
			self.damageblockedtotal = self.damageblockedtotal + damageblocked;
			if(self.damageblockedtotal >= 101)
			{
				self notify("combathigh_survived");
				self.damageblockedtotal = undefined;
			}
		}

		if(weapon != "throwingknife_mp")
		{
			switch(meansofdeath)
			{
				case "MOD_FALLING":
				case "MOD_MELEE":
					break;

				default:
					damage = damage / 3;
					damageadd = damageadd / 3;
					break;
			}
		}
	}

	return int(damage + damageadd);
}

initperkdvars()
{
	level.bulletdamagemod = maps\mp\_utility::getintproperty("perk_bulletDamage", 40) / 100;
	level.hollowpointdamagemod = maps\mp\_utility::getintproperty("perk_hollowPointDamage", 65) / 100;
	level.armorvestmod = maps\mp\_utility::getintproperty("perk_armorVest", 75) / 100;
	level.explosivedamagemod = maps\mp\_utility::getintproperty("perk_explosiveDamage", 40) / 100;
	level.blastshieldmod = maps\mp\_utility::getintproperty("perk_blastShield", 45) / 100;
	level.riotshieldmod = maps\mp\_utility::getintproperty("perk_riotShield", 100) / 100;
	level.dangerclosemod = maps\mp\_utility::getintproperty("perk_dangerClose", 100) / 100;
	level.armorpiercingmod = maps\mp\_utility::getintproperty("perk_armorPiercingDamage", 40) / 100;
}

cac_selector()
{
	perks = self.specialty;
}

gambitusetracker()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(getdvarint("scr_game_perks") != 1)
	{
		return;
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	self notifyonplayercommand("gambit_on", "+frag");
}