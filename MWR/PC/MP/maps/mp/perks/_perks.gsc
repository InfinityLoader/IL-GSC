/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perks.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 287 ms
 * Timestamp: 10/27/2023 2:42:32 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.perkfuncs = [];
	level.specialty_finalstand_icon = "specialty_pistoldeath";
	level.specialty_c4_death_icon = "specialty_s1_temp";
	level.specialty_compassping_revenge_icon = "specialty_s1_temp";
	level.specialty_juiced_icon = "specialty_s1_temp";
	precacheshader(level.specialty_finalstand_icon);
	level.scriptperks = [];
	level.perksetfuncs = [];
	level.perkunsetfuncs = [];
	level.scriptperks["specialty_blastshield"] = 1;
	level.scriptperks["specialty_blastshield2"] = 1;
	level.scriptperks["specialty_akimbo"] = 1;
	level.scriptperks["specialty_falldamage"] = 1;
	level.scriptperks["specialty_shield"] = 1;
	level.scriptperks["specialty_feigndeath"] = 1;
	level.scriptperks["specialty_shellshock"] = 1;
	level.scriptperks["specialty_delaymine"] = 1;
	level.scriptperks["specialty_localjammer"] = 1;
	level.scriptperks["specialty_thermal"] = 1;
	level.scriptperks["specialty_blackbox"] = 1;
	level.scriptperks["specialty_steelnerves"] = 1;
	level.scriptperks["specialty_flashgrenade"] = 1;
	level.scriptperks["specialty_smokegrenade"] = 1;
	level.scriptperks["specialty_concussiongrenade"] = 1;
	level.scriptperks["specialty_saboteur"] = 1;
	level.scriptperks["specialty_endgame"] = 1;
	level.scriptperks["specialty_rearview"] = 1;
	level.scriptperks["specialty_hardline"] = 1;
	level.scriptperks["specialty_onemanarmy"] = 1;
	level.scriptperks["specialty_primarydeath"] = 1;
	level.scriptperks["specialty_secondarybling"] = 1;
	level.scriptperks["specialty_explosivedamage"] = 1;
	level.scriptperks["specialty_laststandoffhand"] = 1;
	level.scriptperks["specialty_dangerclose"] = 1;
	level.scriptperks["specialty_hardjack"] = 1;
	level.scriptperks["specialty_extraspecialduration"] = 1;
	level.scriptperks["specialty_rollover"] = 1;
	level.scriptperks["specialty_armorpiercing"] = 1;
	level.scriptperks["specialty_omaquickchange"] = 1;
	level.scriptperks["_specialty_rearview"] = 1;
	level.scriptperks["_specialty_onemanarmy"] = 1;
	level.scriptperks["specialty_steadyaimpro"] = 1;
	level.scriptperks["specialty_stun_resistance"] = 1;
	level.scriptperks["specialty_double_load"] = 1;
	level.scriptperks["specialty_regenspeed"] = 1;
	level.scriptperks["specialty_twoprimaries"] = 1;
	level.scriptperks["specialty_autospot"] = 1;
	level.scriptperks["specialty_overkillpro"] = 1;
	level.scriptperks["specialty_anytwo"] = 1;
	level.scriptperks["specialty_fasterlockon"] = 1;
	level.scriptperks["specialty_paint"] = 1;
	level.scriptperks["specialty_paint_pro"] = 1;
	level.scriptperks["specialty_silentkill"] = 1;
	level.scriptperks["specialty_crouchmovement"] = 1;
	level.scriptperks["specialty_personaluav"] = 1;
	level.scriptperks["specialty_unwrapper"] = 1;
	level.scriptperks["specialty_class_blindeye"] = 1;
	level.scriptperks["specialty_class_lowprofile"] = 1;
	level.scriptperks["specialty_class_coldblooded"] = 1;
	level.scriptperks["specialty_class_hardwired"] = 1;
	level.scriptperks["specialty_class_scavenger"] = 1;
	level.scriptperks["specialty_class_hoarder"] = 1;
	level.scriptperks["specialty_class_gungho"] = 1;
	level.scriptperks["specialty_class_steadyhands"] = 1;
	level.scriptperks["specialty_class_hardline"] = 1;
	level.scriptperks["specialty_class_peripherals"] = 1;
	level.scriptperks["specialty_class_quickdraw"] = 1;
	level.scriptperks["specialty_class_toughness"] = 1;
	level.scriptperks["specialty_class_lightweight"] = 1;
	level.scriptperks["specialty_class_engineer"] = 1;
	level.scriptperks["specialty_class_dangerclose"] = 1;
	level.scriptperks["specialty_horde_weaponsfree"] = 1;
	level.scriptperks["specialty_horde_dualprimary"] = 1;
	level.scriptperks["specialty_marksman"] = 1;
	level.scriptperks["specialty_sharp_focus"] = 1;
	level.scriptperks["specialty_moredamage"] = 1;
	level.scriptperks["specialty_copycat"] = 1;
	level.scriptperks["specialty_finalstand"] = 1;
	level.scriptperks["specialty_juiced"] = 1;
	level.scriptperks["specialty_light_armor"] = 1;
	level.scriptperks["specialty_stopping_power"] = 1;
	level.scriptperks["specialty_uav"] = 1;
	level.scriptperks["h1_concussiongrenade_mp"] = 1;
	level.scriptperks["h1_flashgrenade_mp"] = 1;
	level.scriptperks["h1_fraggrenade_mp"] = 1;
	level.scriptperks["h1_smokegrenade_mp"] = 1;
	level.scriptperks["bouncingbetty_mp"] = 1;
	level.scriptperks["c4_mp"] = 1;
	level.scriptperks["claymore_mp"] = 1;
	level.scriptperks["frag_grenade_mp"] = 1;
	level.scriptperks["rpg_mp"] = 1;
	level.scriptperks["concussion_grenade_mp"] = 1;
	level.scriptperks["flash_grenade_mp"] = 1;
	level.scriptperks["smoke_grenade_mp"] = 1;
	level.scriptperks["portable_radar_mp"] = 1;
	level.scriptperks["scrambler_mp"] = 1;
	level.scriptperks["trophy_mp"] = 1;
	level.scriptperks["specialty_wildcard_perkslot1"] = 1;
	level.scriptperks["specialty_wildcard_perkslot2"] = 1;
	level.scriptperks["specialty_wildcard_perkslot3"] = 1;
	level.scriptperks["specialty_wildcard_primaryattachment"] = 1;
	level.scriptperks["specialty_wildcard_secondaryattachment"] = 1;
	level.scriptperks["specialty_wildcard_extrastreak"] = 1;
	level.scriptperks["specialty_extraammo"] = 1;
	level.scriptperks["specialty_bulletdamage"] = 1;
	level.scriptperks["specialty_armorvest"] = 1;
	level.scriptperks["specialty_twoprimaries"] = 1;
	level.scriptperks["specialty_explosivedamage"] = 1;
	level.scriptperks["specialty_null"] = 1;
	level.perksetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::setblastshield;
	level.perkunsetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::unsetblastshield;
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
	level.perksetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::setsaboteur;
	level.perkunsetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::unsetsaboteur;
	level.perksetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::setendgame;
	level.perkunsetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::unsetendgame;
	level.perksetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::setrearview;
	level.perkunsetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::unsetrearview;
	level.perksetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::setonemanarmy;
	level.perkunsetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::unsetonemanarmy;
	level.perksetfuncs["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::setsteadyaimpro;
	level.perkunsetfuncs["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::unsetsteadyaimpro;
	level.perksetfuncs["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::setstunresistance;
	level.perkunsetfuncs["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::unsetstunresistance;
	level.perksetfuncs["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::setmarksman;
	level.perkunsetfuncs["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::unsetmarksman;
	level.perksetfuncs["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::setdoubleload;
	level.perkunsetfuncs["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::unsetdoubleload;
	level.perksetfuncs["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::setsharpfocus;
	level.perkunsetfuncs["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::unsetsharpfocus;
	level.perksetfuncs["specialty_regenspeed"] = ::maps\mp\perks\_perkfunctions::setregenspeed;
	level.perkunsetfuncs["specialty_regenspeed"] = ::maps\mp\perks\_perkfunctions::unsetregenspeed;
	level.perksetfuncs["specialty_autospot"] = ::maps\mp\perks\_perkfunctions::setautospot;
	level.perkunsetfuncs["specialty_autospot"] = ::maps\mp\perks\_perkfunctions::unsetautospot;
	level.perksetfuncs["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::setempimmune;
	level.perkunsetfuncs["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::unsetempimmune;
	level.perksetfuncs["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::setoverkillpro;
	level.perkunsetfuncs["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::unsetoverkillpro;
	level.perksetfuncs["specialty_personaluav"] = ::maps\mp\perks\_perkfunctions::setpersonaluav;
	level.perkunsetfuncs["specialty_personaluav"] = ::maps\mp\perks\_perkfunctions::unsetpersonaluav;
	level.perksetfuncs["specialty_crouchmovement"] = ::maps\mp\perks\_perkfunctions::setcrouchmovement;
	level.perkunsetfuncs["specialty_crouchmovement"] = ::maps\mp\perks\_perkfunctions::unsetcrouchmovement;
	level.perksetfuncs["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::setlightarmor;
	level.perkunsetfuncs["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::unsetlightarmor;
	level.perksetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::setfinalstand;
	level.perkunsetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::unsetfinalstand;
	level.perksetfuncs["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::setjuiced;
	level.perkunsetfuncs["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::unsetjuiced;
	level.perksetfuncs["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::setstoppingpower;
	level.perkunsetfuncs["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::unsetstoppingpower;
	level.perksetfuncs["specialty_uav"] = ::maps\mp\perks\_perkfunctions::setuav;
	level.perkunsetfuncs["specialty_uav"] = ::maps\mp\perks\_perkfunctions::unsetuav;
	initperkdvars();
	level thread onplayerconnect();
}

//Function Number: 2
perktablelookupgroup(param_00)
{
	return tablelookup("mp/perktable.csv",1,param_00,13);
}

//Function Number: 3
perktablelookupcount(param_00)
{
	return int(tablelookup("mp/perktable.csv",1,param_00,6));
}

//Function Number: 4
perktablelookupslot(param_00)
{
	return int(tablelookup("mp/perktable.csv",1,param_00,12));
}

//Function Number: 5
perktablelookuplocalizedname(param_00)
{
	return tablelookupistring("mp/perktable.csv",1,param_00,2);
}

//Function Number: 6
perktablelookupimage(param_00)
{
	return tablelookup("mp/perktable.csv",1,param_00,3);
}

//Function Number: 7
validateperk(param_00,param_01)
{
	if(getdvarint("scr_game_perks") == 0)
	{
		return "specialty_null";
	}

	if(param_00 == 0)
	{
		switch(param_01)
		{
			case "specialty_detectexplosive":
			case "specialty_fraggrenade":
			case "rpg_mp":
			case "c4_mp":
			case "specialty_extraammo":
			case "specialty_specialgrenade":
			case "claymore_mp":
				break;

			default:
				break;
		}
	}
}

//Function Number: 8
getemptyperks()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		var_00[var_01] = "specialty_null";
	}

	return var_00;
}

//Function Number: 9
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 10
onplayerspawned()
{
	self endon("disconnect");
	self.perks = [];
	self.weaponlist = [];
}

//Function Number: 11
cac_modified_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_00) || !isdefined(param_01) || !isplayer(param_01) || !maps\mp\_utility::invirtuallobby() && !isplayer(param_00))
	{
		return param_02;
	}

	if(param_01.sessionstate != "playing" || !isdefined(param_02) || !isdefined(param_03))
	{
		return param_02;
	}

	if(param_03 == "")
	{
		return param_02;
	}

	var_09 = param_02;
	var_0A = param_02;
	if(isdefined(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_bulletdamage") && maps\mp\_utility::isbulletdamage(param_03))
	{
		if(isdefined(param_00) && isplayer(param_00) && param_00 maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
			var_0A = var_09;
		}
		else
		{
			var_0A = var_0A + param_02 * level.bulletdamagemod;
		}
	}
	else if(isdefined(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_explosivedamage") && isexplosivedamagemod(param_03))
	{
		if(isdefined(param_00) && isplayer(param_00) && param_00 maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
			var_0A = var_09;
		}
		else
		{
			var_0A = var_0A + param_02 * level.explosivedamagemod;
		}
	}
	else if(isdefined(param_00) && isplayer(param_00) && param_00 maps\mp\_utility::_hasperk("specialty_armorvest"))
	{
		var_0A = var_0A - param_02 * level.armorvestmod;
	}
	else
	{
		var_0A = var_09;
	}

	if(isexplosivedamagemod(param_03))
	{
		if(maps\mp\gametypes\_weapons::ingrenadegraceperiod())
		{
			var_0A = var_0A * level.juggernautmod;
		}
	}

	if(var_0A <= 1)
	{
		var_0A = 1;
		return var_0A;
	}

	return int(var_0A);
}

//Function Number: 12
initperkdvars()
{
	level.juggernautmod = 0.08;
	level.juggernatudefmod = 0.08;
	level.armorpiercingmod = 1.5;
	level.regenhealthmod = 0.25;
	level.bulletdamagemod = maps\mp\_utility::getintproperty("perk_bulletDamage",40) / 100;
	level.explosivedamagemod = maps\mp\_utility::getintproperty("perk_explosiveDamage",25) / 100;
	level.armorvestmod = maps\mp\_utility::getintproperty("perk_armorVest",25) / 100;
}

//Function Number: 13
cac_selector()
{
}

//Function Number: 14
giveblindeyeafterspawn()
{
	self endon("death");
	self endon("disconnect");
	maps\mp\_utility::giveperk("specialty_blindeye",0);
	self.spawnperk = 1;
	while(self.avoidkillstreakonspawntimer > 0)
	{
		self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
		wait(0.05);
	}

	maps\mp\_utility::_unsetperk("specialty_blindeye");
	self.spawnperk = 0;
}

//Function Number: 15
applyperks()
{
	self setviewkickscale(1);
	if(maps\mp\_utility::_hasperk("specialty_extended_battery"))
	{
		maps\mp\_utility::giveperk("specialty_exo_slamboots",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_lowprofile"))
	{
		maps\mp\_utility::giveperk("specialty_radarimmune",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_flakjacket"))
	{
		maps\mp\_utility::giveperk("specialty_hard_shell",0);
		maps\mp\_utility::giveperk("specialty_throwback",0);
		maps\mp\_utility::giveperk("specialty_blastshield2",0);
		self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale",45) / 100;
		if(isdefined(level.hardcoremode) && level.hardcoremode)
		{
			self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC",50) / 100;
		}
	}

	if(maps\mp\_utility::_hasperk("specialty_class_lightweight"))
	{
		maps\mp\_utility::giveperk("specialty_lightweight",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_dangerclose"))
	{
		maps\mp\_utility::giveperk("specialty_explosivedamage",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_blindeye"))
	{
		maps\mp\_utility::giveperk("specialty_blindeye",0);
		maps\mp\_utility::giveperk("specialty_plainsight",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_coldblooded"))
	{
		maps\mp\_utility::giveperk("specialty_coldblooded",0);
		maps\mp\_utility::giveperk("specialty_spygame",0);
		maps\mp\_utility::giveperk("specialty_heartbreaker",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_peripherals"))
	{
		maps\mp\_utility::giveperk("specialty_moreminimap",0);
		maps\mp\_utility::giveperk("specialty_silentkill",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_fasthands"))
	{
		maps\mp\_utility::giveperk("specialty_quickswap",0);
		maps\mp\_utility::giveperk("specialty_fastoffhand",0);
		maps\mp\_utility::giveperk("specialty_sprintreload",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_dexterity"))
	{
		maps\mp\_utility::giveperk("specialty_sprintfire",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_hardwired"))
	{
		maps\mp\_utility::giveperk("specialty_empimmune",0);
		maps\mp\_utility::giveperk("specialty_stun_resistance",0);
		self.stunscaler = 0.1;
	}

	if(maps\mp\_utility::_hasperk("specialty_class_toughness"))
	{
		self setviewkickscale(0.2);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_scavenger"))
	{
		self.ammopickup_scalar = 0.2;
		maps\mp\_utility::giveperk("specialty_scavenger",0);
		maps\mp\_utility::giveperk("specialty_bulletresupply",0);
		maps\mp\_utility::giveperk("specialty_extraammo",0);
	}

	if(maps\mp\_utility::_hasperk("specialty_class_hardline"))
	{
		maps\mp\_utility::giveperk("specialty_hardline",0);
	}
}

//Function Number: 16
get_specialtydata(param_00,param_01,param_02)
{
	var_03 = perktablelookupgroup(param_00);
	var_04 = perktablelookupcount(param_00);
	if(param_01 == "specialty1")
	{
		if(issubstr(var_03,"grenade"))
		{
			if(param_00 == "specialty_fraggrenade")
			{
				self.perkscustom["grenades_count"] = var_04;
			}
			else
			{
				self.perkscustom["grenades_count"] = 1;
			}

			if(param_00 == "specialty_specialgrenade" && isdefined(param_02.offhand) && param_02.offhand != "h1_smokegrenade_mp")
			{
				self.perkscustom["specialgrenades_count"] = var_04;
			}
			else
			{
				self.perkscustom["specialgrenades_count"] = 1;
			}

			return;
		}
		else
		{
			self.perkscustom["grenades_count"] = 1;
			self.perkscustom["specialgrenades_count"] = 1;
		}
	}

	if(var_03 == "inventory")
	{
		self.perkscustom["inventory"] = param_00;
		self.perkscustom["inventory_count"] = var_04;
	}
}

//Function Number: 17
giveperkinventory()
{
	var_00 = self.perkscustom["inventory"];
	if(isdefined(var_00) && var_00 != "")
	{
		var_00 = "h1_" + var_00;
		self giveweapon(var_00);
		setweaponammooverall(var_00,self.perkscustom["inventory_count"]);
		self setactionslot(3,"weapon",var_00);
		return;
	}

	self setactionslot(3,"altMode");
}

//Function Number: 18
setweaponammooverall(param_00,param_01)
{
	if(isweaponcliponly(param_00))
	{
		self setweaponammoclip(param_00,param_01);
		return;
	}

	self setweaponammoclip(param_00,param_01);
	var_02 = param_01 - self getweaponammoclip(param_00);
	self setweaponammostock(param_00,var_02);
}