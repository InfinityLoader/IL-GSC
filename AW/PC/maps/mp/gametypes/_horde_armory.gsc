/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_armory.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 469 ms
 * Timestamp: 4/22/2024 2:09:35 AM
*******************************************************************/

//Function Number: 1
initarmories()
{
	level.hordearmories = getentarray("horde_armory","targetname");
	foreach(var_01 in level.hordearmories)
	{
		var_01.monitors = getentarray(var_01.target,"targetname");
		var_01 thread armorythink();
	}
}

//Function Number: 2
armorythink()
{
	level endon("armories_online");
	level endon("game_ended");
	self makeusable();
	self hudoutlineenable(5,1);
	foreach(var_01 in self.monitors)
	{
		if(self.script_parameters == "specops_ui_equipmentstore" && var_01.model == "mp_exo_upgrade_screen_01_glass")
		{
			var_01 setmodel("mp_weapon_upgrade_screen_01_glass");
		}

		var_01 hudoutlineenable(5,1);
	}

	var_03 = &"HORDE_ARMORY_EXO";
	var_04 = "specops_ui_exostore";
	if(self.script_parameters == "specops_ui_equipmentstore")
	{
		var_04 = "specops_ui_weaponstore";
		var_03 = &"HORDE_ARMORY_WEAPONS";
	}

	self sethintstring(var_03);
	foreach(var_06 in level.players)
	{
		self.headicon = maps\mp\_entityheadicons::setheadicon(var_06,var_04,(0,0,48),4,4,undefined,undefined,0,1,undefined,0);
	}

	var_08 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_08,"active",self.origin,var_04);
	self.objectiveindex = var_08;
	for(;;)
	{
		self waittill("trigger",var_06);
		if(iscarryingturrethead(var_06))
		{
			var_06 iprintlnbold(&"HORDE_ARMORY_TURRET_DENIED");
			level thread armorypurchasefail(var_06);
			continue;
		}

		if(isdefined(var_06.changingweapon) && maps\mp\_utility::iskillstreakweapon(var_06.changingweapon))
		{
			level thread armorypurchasefail(var_06);
			continue;
		}

		if(var_06 isusingoffhand() || var_06 isthrowinggrenade() || isdefined(var_06.changingweapon) && var_06.changingweapon == var_06 gettacticalweapon() || var_06.changingweapon == var_06 getlethalweapon())
		{
			level thread armorypurchasefail(var_06);
			continue;
		}

		if(!isdefined(level.empowner))
		{
			var_06 setclientomnvar("ui_horde_armory_type",self.script_noteworthy);
			var_06 setclientomnvar("ui_horde_show_armory",1);
			var_06.usingarmory = 1;
			var_06 disableusability();
			var_06 notify("exo_cloak_cancel");
			continue;
		}

		var_06 iprintlnbold(&"HORDE_ARMORY_OFFLINE");
	}
}

//Function Number: 3
iscarryingturrethead(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(issubstr(var_01,"turret"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
hordedisablearmories()
{
	level endon("game_ended");
	foreach(var_01 in level.hordearmories)
	{
		foreach(var_03 in level.players)
		{
			var_01 maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
		}

		if(isdefined(var_01.headicon))
		{
			var_01.headicon destroy();
		}

		maps\mp\_utility::_objective_delete(var_01.objectiveindex);
		var_01 hudoutlinedisable();
		foreach(var_06 in var_01.monitors)
		{
			var_06 hudoutlinedisable();
		}
	}

	thread hordearmoryemptimeout();
	level waittill("armories_online");
	foreach(var_01 in level.hordearmories)
	{
		var_01 thread armorythink();
	}
}

//Function Number: 5
hordearmoryemptimeout()
{
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.hordeempduration);
	level notify("armories_online");
}

//Function Number: 6
closehordearmoryonoffhandweapon()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_switch_started",var_00);
		if(self getclientomnvar("ui_horde_show_armory") == 1 && var_00 == self gettacticalweapon() || var_00 == self getlethalweapon())
		{
			var_01 = self getclientomnvar("ui_horde_armory_type");
			if(var_01 != "killstreak_armory" && var_01 != "perk_armory")
			{
				hordecleanuparmory(self);
			}
		}
	}
}

//Function Number: 7
classswitchwait()
{
	wait(1);
	self.classswitchwaiting = 0;
}

//Function Number: 8
monitorupgrades(param_00)
{
	level endon("game_ended");
	level thread horderesetarmory(param_00);
	for(;;)
	{
		param_00.isrunningarmorycommand = 0;
		param_00 waittill("luinotifyserver",var_01,var_02);
		if(maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00))
		{
			continue;
		}

		param_00.isrunningarmorycommand = 1;
		if(!hordeisarmoryupgrade(var_01))
		{
			continue;
		}

		var_03 = "mp/hordeMenus.csv";
		var_04 = tablelookup(var_03,0,var_02,2);
		var_05 = int(tablelookup(var_03,0,var_02,6));
		if(var_02 == 9999)
		{
			addarmorypoints(param_00,"support_bar_filled");
			param_00 playsoundtoplayer("new_title_unlocks",param_00);
			continue;
		}

		if(var_01 == "horde_stat_upgrade")
		{
			var_06 = 0;
			switch(var_04)
			{
				case "horde_weapon_proficiency":
					var_06 = param_00.weaponproficiency;
					break;
	
				case "horde_armor":
					var_06 = param_00.hordearmor;
					break;
	
				case "horde_exo_battery":
					var_06 = param_00.hordeexobattery;
					break;
			}

			if(var_06 > 9)
			{
				var_05 = 10 + int(var_06 - 10 * 0.5);
			}
			else if(var_06 > 7)
			{
				var_05 = var_05 + 3;
			}
			else if(var_06 > 5)
			{
				var_05 = var_05 + 2;
			}
			else if(var_06 > 2)
			{
				var_05 = var_05 + 1;
			}
		}

		if(hordeshouldupgradefail(param_00,var_01,var_04,var_05))
		{
			level thread armorypurchasefail(param_00);
			continue;
		}

		param_00 playsoundtoplayer("new_title_unlocks",param_00);
		param_00 setclientomnvar("ui_horde_armory_purchase",var_02);
		switch(var_01)
		{
			case "horde_exo_class":
				if(var_04 == "light" || var_04 == "heavy" || var_04 == "support" || var_04 == "demolition")
				{
					param_00 notify("horde_class_change");
					param_00.usingarmory = 0;
					param_00.classselection = 0;
					var_07 = param_00 getclientomnvar("ui_horde_player_class");
					maps\mp\gametypes\_horde_util::check_class_time(param_00);
					param_00.classdmgmod = param_00.classsettings[var_04]["classDmgMod"];
					param_00.classmaxhealth = param_00.classsettings[var_04]["classhealth"];
					var_08 = param_00.health / param_00.maxhealth;
					param_00.maxhealth = param_00.classmaxhealth + param_00.hordearmor * 40;
					param_00.health = int(param_00.maxhealth * var_08);
					param_00.movespeedscaler = param_00.classsettings[var_04]["speed"];
					param_00 maps\mp\_utility::playerallowdodge(param_00.classsettings[var_04]["allowDodge"],"class");
					param_00 maps\mp\_utility::playerallowpowerslide(param_00.classsettings[var_04]["allowSlide"],"class");
					var_09 = param_00 gettacticalweapon();
					param_00.classsettings[var_07]["battery"] = param_00 getweaponammoclip(var_09);
					if(isdefined(var_07) && var_07 != "none" && isdefined(param_00.loadoutequipment))
					{
						var_0A = param_00 getlethalweapon();
						param_00.hordeclassweapons[var_07]["lethalStoredGrenade"] = var_0A;
						param_00.hordeclassweapons[var_07]["lethalStoredGrenadeStock"] = param_00 setweaponammostock(var_0A);
					}
		
					if(isdefined(var_07) && var_07 != "none" && isdefined(param_00.hordeclassweapons[var_07]["primary"]))
					{
						param_00.hordeclassweapons[var_07]["primaryStoredAmmoClip"] = param_00 getweaponammoclip(param_00.hordeclassweapons[var_07]["primary"]);
						param_00.hordeclassweapons[var_07]["primaryStoredAmmoStock"] = param_00 setweaponammostock(param_00.hordeclassweapons[var_07]["primary"]);
					}
		
					if(isdefined(var_07) && var_07 != "none" && isdefined(param_00.hordeclassweapons[var_07]["secondary"]))
					{
						param_00.hordeclassweapons[var_07]["secondaryStoredAmmoClip"] = param_00 getweaponammoclip(param_00.hordeclassweapons[var_07]["secondary"]);
						param_00.hordeclassweapons[var_07]["secondaryStoredAmmoStock"] = param_00 setweaponammostock(param_00.hordeclassweapons[var_07]["secondary"]);
					}
		
					param_00 setclientomnvar("ui_horde_player_class",var_04);
					hordegiveability(param_00,var_04);
					var_0B = param_00 getweaponslistprimaries();
					foreach(var_0D in var_0B)
					{
						if(param_00 getclientomnvar("horde_first_spawn") == 1)
						{
							if(var_0D != param_00.hordeclassweapons[var_04]["primary"])
							{
								param_00 takeweapon(var_0D);
							}
		
							continue;
						}
		
						param_00 takeweapon(var_0D);
					}
		
					param_00.isrunningweapongive = 1;
					thread hordegiveclassweapons(param_00,var_04,var_07);
					param_00 armorygiveexoability(param_00.classsettings[var_04]["exoAbility"],1);
					wait(0.1);
					if(param_00 getclientomnvar("horde_first_spawn") == 1)
					{
						thread hordeclassrunfirstspawn(param_00);
					}
		
					param_00.classswitchwaiting = 1;
					param_00 thread classswitchwait();
				}
				break;
	
			case "horde_exo_upgrade":
				param_00 armorygiveexoability(var_04);
				break;
	
			case "horde_equipment_upgrade":
				var_0F = param_00 getlethalweapon();
				if(var_04 != param_00 getlethalweapon())
				{
					param_00 setlethalweapon(var_04);
					param_00 giveweapon(var_04);
					param_00 setweaponammostock(var_0F,0);
					param_00 setweaponammoclip(var_0F,0);
				}
				else
				{
					param_00 setweaponammoclip(var_04,4);
				}
				break;
	
			case "horde_weapon_upgrade":
				if(!issubstr(var_04,"iw5") && !issubstr(var_04,"ammo") && !issubstr(var_04,"turrethead"))
				{
					var_10 = param_00 getcurrentprimaryweapon();
					if(issubstr(var_04,"scopevz"))
					{
						if(issubstr(var_10,"mors"))
						{
							var_04 = "morsscopevz";
						}
						else if(issubstr(var_10,"thor"))
						{
							var_04 = "thorscopevz";
						}
						else if(issubstr(var_10,"gm6"))
						{
							var_04 = "gm6scopevz";
						}
						else if(issubstr(var_10,"m990"))
						{
							var_04 = "m990scopevz";
						}
					}
		
					var_11 = maps\mp\gametypes\_horde_util::hordegetweaponupgrades(var_10,param_00);
					var_12 = maps\mp\gametypes\_horde_util::hordegetattachmentstring(var_11,var_04);
					wait(0.05);
					var_13 = getweaponbasename(var_10);
					maps\mp\gametypes\_horde_util::trygivehordeweapon(param_00,var_13 + var_12,1,1);
				}
				else if(issubstr(var_04,"ammo"))
				{
					var_0B = param_00 getweaponslistprimaries();
					foreach(var_15 in var_0B)
					{
						var_16 = weaponclipsize(var_15);
						param_00 setweaponammoclip(var_15,var_16);
						param_00 givemaxammo(var_15);
					}
				}
				else
				{
					wait(0.05);
					if(issubstr(var_04,"turrethead"))
					{
						param_00 thread maps\mp\killstreaks\_rippedturret::playergiveturrethead(var_04);
					}
					else
					{
						maps\mp\gametypes\_horde_util::trygivehordeweapon(param_00,var_04,1,1);
					}
				}
				break;
	
			case "horde_perk_upgrade":
				if(issubstr(var_04,"oost"))
				{
					setdvar("high_jump_height",512);
				}
				else if(issubstr(var_04,"upgrade_points"))
				{
					addarmorypoints(param_00,"round");
				}
				else
				{
					param_00 hordegiveperk(var_04);
				}
				break;
	
			case "horde_killstreak_upgrade":
				param_00 hordegivekillstreak(var_04,var_02);
				break;
	
			case "horde_stat_upgrade":
				switch(var_04)
				{
					case "horde_weapon_proficiency":
						param_00.weaponproficiency++;
						param_00 setclientomnvar(var_04,param_00.weaponproficiency);
						level thread hordeweaponlevel(param_00);
						maps\mp\gametypes\_horde_util::givegearformaxweaponproficiency(param_00);
						break;
		
					case "horde_armor":
						param_00.hordearmor++;
						param_00 setclientomnvar(var_04,param_00.hordearmor);
						param_00.maxhealth = param_00.classmaxhealth + param_00.hordearmor * 40;
						param_00.health = param_00.maxhealth;
						maps\mp\gametypes\_horde_util::givegearformaxarmorproficiency(param_00);
						break;
		
					case "horde_exo_battery":
						param_00.hordeexobattery = param_00.hordeexobattery + 1;
						level thread hordebatterylevel(param_00);
						param_00 setclientomnvar(var_04,param_00.hordeexobattery);
						var_09 = param_00 gettacticalweapon();
						param_00 batteryfullrecharge(var_09);
						param_00 setclientomnvar("ui_exo_battery_level0",param_00 batterygetsize(var_09));
						break;
				}
				break;
	
			case "horde_ability_upgrade":
				hordegivescorestreakupgrade(param_00,var_04);
				break;
		}

		if(getdvarint("horde_ignore_cost") == 0)
		{
			if(var_05 > 0)
			{
				param_00.armorypoints = param_00.armorypoints - var_05;
				param_00 setclientomnvar("ui_horde_player_points",param_00.armorypoints);
			}
		}

		wait(0.05);
	}
}

//Function Number: 9
horderesetarmory(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = 0;
	for(;;)
	{
		param_00 waittill("luinotifyserver",var_02,var_03);
		if(var_02 == "horde_reset_armory")
		{
			param_00 setclientomnvar("ui_horde_armory_type","none");
			if(var_03 == 2)
			{
				hordecleanuparmory(param_00);
			}

			continue;
		}

		if(var_02 == "ui_horde_secondary_index")
		{
			var_04 = param_00 getweaponslistprimaries();
			var_05 = maps\mp\gametypes\_horde_util::hordegetweaponbasenamespecial(param_00 getcurrentprimaryweapon());
			foreach(var_07 in var_04)
			{
				var_08 = maps\mp\gametypes\_horde_util::hordegetweaponbasenamespecial(var_07);
				if(var_08 != var_05)
				{
					var_01 = int(tablelookup("mp/hordeMenus.csv",2,var_08,0));
				}
			}

			param_00 setclientomnvar("ui_horde_secondary_index",var_01);
		}
	}
}

//Function Number: 10
hordecleanuparmory(param_00)
{
	if(isdefined(param_00.usingarmory))
	{
		param_00.usingarmory = undefined;
		param_00 setclientomnvar("ui_horde_show_armory",0);
		if(!maps\mp\gametypes\_horde_util::isplayerinlaststand(param_00))
		{
			param_00 enableusability();
		}
	}
}

//Function Number: 11
hordeclassrunfirstspawn(param_00)
{
	param_00.health = param_00.classmaxhealth;
	param_00.ignoreme = 0;
	param_00 setclientomnvar("horde_first_spawn",0);
	param_00 setclientomnvar("ui_horde_show_armory",0);
	param_00.classchosen = 1;
	param_00 hordeequipstartgrenade();
	level.noonespawnedyet = 0;
}

//Function Number: 12
hordeequipstartgrenade()
{
	var_00 = 4;
	var_01 = self getclientomnvar("ui_horde_player_class");
	var_02 = self.classsettings[var_01]["classGrenade"];
	self setlethalweapon(var_02);
	self setweaponammoclip(var_02,var_00);
	self giveweapon(var_02);
}

//Function Number: 13
hordegiveclassweapons(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	var_03 = undefined;
	var_04 = undefined;
	if(param_02 != "none")
	{
		var_03 = param_00.hordeclassweapons[param_02]["secondary"];
		var_04 = param_00.hordeclassweapons[param_02]["primary"];
	}

	maps\mp\gametypes\_horde_util::trygivehordeweapon(param_00,param_00.hordeclassweapons[param_01]["secondary"],1,0,var_03,"secondary");
	if(param_00 getclientomnvar("horde_first_spawn") == 0 || param_00 getclientomnvar("horde_first_spawn") == 1 && param_00.hordeclassweapons[param_01]["primary"] != "iw5_kf5_mp")
	{
		maps\mp\gametypes\_horde_util::trygivehordeweapon(param_00,param_00.hordeclassweapons[param_01]["primary"],1,1,var_04,"primary");
	}

	if(isdefined(param_01) && isdefined(param_02) && param_02 != "none")
	{
		if(isdefined(param_00.hordeclassweapons[param_01]["primaryStoredAmmoClip"]))
		{
			param_00 setweaponammoclip(param_00.hordeclassweapons[param_01]["primary"],param_00.hordeclassweapons[param_01]["primaryStoredAmmoClip"]);
		}

		if(isdefined(param_00.hordeclassweapons[param_01]["primaryStoredAmmoStock"]))
		{
			param_00 setweaponammostock(param_00.hordeclassweapons[param_01]["primary"],param_00.hordeclassweapons[param_01]["primaryStoredAmmoStock"]);
		}

		if(isdefined(param_00.hordeclassweapons[param_01]["secondaryStoredAmmoClip"]))
		{
			param_00 setweaponammoclip(param_00.hordeclassweapons[param_01]["secondary"],param_00.hordeclassweapons[param_01]["secondaryStoredAmmoClip"]);
		}

		if(isdefined(param_00.hordeclassweapons[param_01]["secondaryStoredAmmoStock"]))
		{
			param_00 setweaponammostock(param_00.hordeclassweapons[param_01]["secondary"],param_00.hordeclassweapons[param_01]["secondaryStoredAmmoStock"]);
		}

		if(!isdefined(param_00.hordeclassweapons[param_01]["lethalStoredGrenade"]))
		{
			param_00 hordeequipstartgrenade();
		}
		else
		{
			param_00 setlethalweapon(param_00.hordeclassweapons[param_01]["lethalStoredGrenade"]);
			param_00 giveweapon(param_00.hordeclassweapons[param_01]["lethalStoredGrenade"]);
			param_00 setweaponammostock(param_00.hordeclassweapons[param_01]["lethalStoredGrenade"],param_00.hordeclassweapons[param_01]["lethalStoredGrenadeStock"]);
			param_00 setweaponammoclip(param_00.hordeclassweapons[param_01]["lethalStoredGrenade"],param_00.hordeclassweapons[param_01]["lethalStoredGrenadeStock"]);
		}
	}

	param_00.isrunningweapongive = 0;
}

//Function Number: 14
addarmorypoints(param_00,param_01)
{
	var_02 = 0;
	switch(param_01)
	{
		case "round":
			var_02 = 2;
			break;

		case "support_bar_filled":
			var_02 = 1;
			break;

		case "objective_complete":
			var_02 = 2;
			break;
	}

	param_00.armorypoints = param_00.armorypoints + var_02;
	param_00.armorypoints = int(min(param_00.armorypoints,999));
	param_00 setclientomnvar("ui_horde_player_points",param_00.armorypoints);
	param_00.roundupgradepoints = param_00.roundupgradepoints + var_02;
}

//Function Number: 15
armorygiveexoability(param_00,param_01)
{
	var_02 = self getclientomnvar("ui_horde_player_class");
	var_03 = self gettacticalweapon();
	switch(var_03)
	{
		case "exocloakhorde_equipment_mp":
			maps\mp\_exo_cloak::take_exo_cloak();
			break;

		case "exohoverhorde_equipment_mp":
			maps\mp\_exo_hover::take_exo_hover();
			break;

		case "exoshieldhorde_equipment_mp":
			maps\mp\_exo_shield::take_exo_shield();
			break;

		case "exoping_equipment_mp":
			maps\mp\_exo_ping::take_exo_ping();
			break;

		case "exorepulsor_equipment_mp":
			maps\mp\_exo_repulsor::take_exo_repulsor();
			break;

		case "extra_health_mp":
			maps\mp\_extrahealth::take_exo_health();
			break;
	}

	wait(0.05);
	self settacticalweapon(param_00);
	switch(param_00)
	{
		case "exocloakhorde_equipment_mp":
			maps\mp\_exo_cloak::give_exo_cloak();
			break;

		case "exohoverhorde_equipment_mp":
			maps\mp\_exo_hover::give_exo_hover();
			break;

		case "exoshieldhorde_equipment_mp":
			maps\mp\_exo_shield::give_exo_shield();
			break;

		case "exoping_equipment_mp":
			maps\mp\_exo_ping::give_exo_ping();
			break;

		case "exorepulsor_equipment_mp":
			maps\mp\_exo_repulsor::give_exo_repulsor();
			break;

		case "extra_health_mp":
			maps\mp\_extrahealth::give_exo_health();
			break;
	}

	wait 0.05;
	if(isdefined(param_01) && param_01)
	{
		self batterysetcharge(param_00,self.classsettings[var_02]["battery"]);
		self setclientomnvar("ui_exo_battery_level0",self.classsettings[var_02]["battery"]);
	}
	else
	{
		self batteryfullrecharge(param_00);
	}

	self.classsettings[var_02]["exoAbility"] = param_00;
	level thread hordebatterylevel(self);
}

//Function Number: 16
armorypurchasefail(param_00)
{
	param_00 playsoundtoplayer("disable_activeperk",param_00);
}

//Function Number: 17
hordeweaponlevel(param_00)
{
	var_01 = param_00.weaponproficiency;
	while(isdefined(param_00.updatinglootweapon) && param_00.updatinglootweapon)
	{
		wait 0.05;
	}

	if(param_00.weaponproficiency > var_01)
	{
		return;
	}

	var_02 = getweaponbasename(param_00 getcurrentprimaryweapon());
	if(isdefined(var_02))
	{
		var_02 = maps\mp\_utility::strip_suffix(var_02,"_mp");
	}

	var_03 = param_00 getweaponslistprimaries();
	foreach(var_05 in var_03)
	{
		var_06 = 0;
		if(!isdefined(var_02) || issubstr(var_05,var_02))
		{
			var_06 = 1;
		}

		if(issubstr(var_05,"alt_iw5"))
		{
			continue;
		}

		var_07 = getweaponbasename(var_05);
		var_08 = getsubstr(var_05,var_07.size);
		var_09 = var_07 + var_08;
		maps\mp\gametypes\_horde_util::trygivehordeweapon(param_00,var_09,1,var_06,var_05);
	}

	param_00.weapondmgmod = param_00.weapondmgmod + 0.2;
}

//Function Number: 18
hordebatterylevel(param_00)
{
	var_01 = -0.1;
	param_00 batterysetdischargescale("exocloakhorde_equipment_mp",1 + param_00.hordeexobattery * var_01);
	param_00 batterysetdischargescale("exoshieldhorde_equipment_mp",1 + param_00.hordeexobattery * var_01);
	param_00 batterysetdischargescale("exohoverhorde_equipment_mp",1 + param_00.hordeexobattery * var_01);
	param_00 batterysetdischargescale("exorepulsor_equipment_mp",1 + param_00.hordeexobattery * var_01);
	param_00 batterysetdischargescale("extra_health_mp",1 + param_00.hordeexobattery * var_01);
}

//Function Number: 19
hordegiveability(param_00,param_01)
{
	param_00.currentkillstreaks[1] = param_00.classsettings[param_01]["killstreak"];
	if(param_00.classabilityready)
	{
		var_02 = param_00 maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex(1);
		param_00 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(param_00.currentkillstreaks[1],self.owner,param_00.hordekillstreakmodules,1,1);
		thread maps\mp\gametypes\_horde_util::hordescorestreaksplash(param_00,param_00.currentkillstreaks[1],"horde_ss_splash_" + param_00.currentkillstreaks[1],var_02);
	}
	else
	{
		param_00 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(param_00.currentkillstreaks[1],self.owner,param_00.hordekillstreakmodules,1,0);
	}

	level thread hordemonitorclassability(param_00,param_01);
}

//Function Number: 20
hordemonitorclassability(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("horde_class_change");
	param_00 endon("ability_upgraded");
	param_00 endon("horde_end_spectate");
	level endon("game_ended");
	level endon("zombies_start");
	for(;;)
	{
		if(param_01 == "light")
		{
			param_00 waittill("used_horde_uav");
		}
		else if(param_01 == "heavy")
		{
			param_00 waittill("used_horde_goliath");
		}
		else if(param_01 == "demolition")
		{
			param_00 waittill("used_horde_missile_strike");
		}
		else if(param_01 == "support")
		{
			while(!isdefined(param_00.hordeclassturret) || isdefined(param_00.hordeclassturret) && isdefined(param_00.iscarrying) && param_00.iscarrying)
			{
				wait(0.1);
			}
		}

		param_00.classabilityready = 0;
		var_02 = getabilitywaittime(param_00);
		if(param_01 == "support")
		{
			level thread hordewaitforturretdeath(param_00,var_02);
		}
		else if(param_01 == "heavy")
		{
			level thread hordewaitforgoliathdeath(param_00,var_02);
		}
		else
		{
			level thread hordeabilityregenbar(param_00,var_02);
		}

		param_00 waittill("ability_regenerated");
	}
}

//Function Number: 21
getabilitywaittime(param_00)
{
	var_01 = 120;
	if(param_00 maps\mp\_utility::_hasperk("specialty_class_hardline"))
	{
		var_01 = 90;
	}

	return var_01;
}

//Function Number: 22
hordeabilityregenbar(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("horde_end_spectate");
	level endon("game_ended");
	level endon("zombies_start");
	var_02 = 0;
	while(var_02 < 1)
	{
		wait(1);
		var_02 = var_02 + 1 / param_01;
		param_00 setclientomnvar("ks_count1",var_02);
		param_00 setclientomnvar("ks_count_updated",1);
	}

	param_00 setclientomnvar("ks_count1",0);
	param_00 setclientomnvar("ks_count_updated",1);
	param_00.classabilityready = 1;
	var_03 = param_00 maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex(1);
	param_00 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(param_00.currentkillstreaks[1],self.owner,param_00.hordekillstreakmodules,1,1);
	thread maps\mp\gametypes\_horde_util::hordescorestreaksplash(param_00,param_00.currentkillstreaks[1],"horde_ss_splash_" + param_00.currentkillstreaks[1],var_03);
	param_00 notify("ability_regenerated");
}

//Function Number: 23
hordewaitforturretdeath(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("becameSpectator");
	level endon("game_ended");
	level endon("zombies_start");
	param_00.hordeclassturret waittill("death");
	param_00.hordeclassturret = undefined;
	level thread hordeabilityregenbar(param_00,param_01);
}

//Function Number: 24
hordewaitforgoliathdeath(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("becameSpectator");
	param_00 endon("cancel_goliath_wait");
	level endon("game_ended");
	level endon("zombies_start");
	param_00 waittill("startJuggCooldown");
	level thread hordeabilityregenbar(param_00,param_01);
}

//Function Number: 25
hordeisarmoryupgrade(param_00)
{
	if(param_00 == "horde_stat_upgrade" || param_00 == "horde_weapon_upgrade" || param_00 == "horde_perk_upgrade" || param_00 == "horde_killstreak_upgrade" || param_00 == "horde_exo_upgrade" || param_00 == "horde_exo_class" || param_00 == "horde_equipment_upgrade" || param_00 == "horde_ability_upgrade")
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
hordeisinscorestreakmodules(param_00,param_01)
{
	if(param_01 == "sentry_machinegun_turret")
	{
		if(common_scripts\utility::array_contains(param_00.hordekillstreakmodules,"sentry_energy_turret"))
		{
			return 0;
		}

		if(common_scripts\utility::array_contains(param_00.hordekillstreakmodules,"sentry_rocket_turret"))
		{
			return 0;
		}

		return 1;
	}

	return common_scripts\utility::array_contains(param_00.hordekillstreakmodules,param_01);
}

//Function Number: 27
hordeshouldupgradefail(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 getclientomnvar("ui_horde_armory_type");
	if(param_00.classswitchwaiting)
	{
		return 1;
	}

	if(getdvarint("horde_ignore_cost") == 1)
	{
		return 0;
	}

	var_05 = param_00 getweaponslistprimaries();
	var_06 = param_00 getcurrentprimaryweapon();
	var_07 = param_00 gettacticalweapon();
	var_08 = param_00 getlethalweapon();
	var_09 = 9;
	var_0A = 9;
	if(var_06 == "none")
	{
		return 1;
	}

	if((issubstr(var_06,"turret") || isdefined(param_00.iscarrying) && param_00.iscarrying) && !var_04 == "perk_armory" || var_04 == "killstreak_armory")
	{
		return 1;
	}

	if(param_02 == var_07 || param_02 == var_08 || hordeisinscorestreakmodules(param_00,param_02))
	{
		if(var_07 == param_02)
		{
			if(param_00 getfractionmaxammo(param_02) == 1)
			{
				param_00 setclientomnvar("ui_horde_armory_purchase_fail",6);
				return 1;
			}
		}
		else if(param_02 == var_08)
		{
			if(param_00 getfractionmaxammo(param_02) == 1)
			{
				param_00 setclientomnvar("ui_horde_armory_purchase_fail",5);
				return 1;
			}
		}
		else
		{
			param_00 setclientomnvar("ui_horde_armory_purchase_fail",1);
			return 1;
		}
	}

	if(param_01 == "horde_stat_upgrade")
	{
		if((param_02 == "horde_weapon_proficiency" && param_00.weaponproficiency > var_09) || param_02 == "horde_armor" && param_00.hordearmor > var_0A || param_02 == "horde_exo_battery" && param_00.hordeexobattery > 4)
		{
			param_00 setclientomnvar("ui_horde_armory_purchase_fail",3);
			return 1;
		}
	}

	if(param_03 > param_00.armorypoints)
	{
		param_00 setclientomnvar("ui_horde_armory_purchase_fail",0);
		return 1;
	}

	if(param_01 == "horde_exo_class" && param_00 getclientomnvar("ui_horde_player_class") == param_02)
	{
		param_00 setclientomnvar("ui_horde_armory_purchase_fail",1);
		return 1;
	}

	if(((param_01 == "horde_exo_class" && param_00.classchosen) || param_01 == "horde_weapon_upgrade" || param_02 == "horde_weapon_proficiency") && level.hordeweaponsjammed)
	{
		param_00 setclientomnvar("ui_horde_armory_purchase_fail",4);
		return 1;
	}

	if(param_01 == "horde_weapon_upgrade")
	{
		if(param_02 == "ammo")
		{
			if(hordeammofull(param_00,var_05))
			{
				param_00 setclientomnvar("ui_horde_armory_purchase_fail",5);
				return 1;
			}

			return 0;
		}
		else if(!issubstr(param_02,"iw5_"))
		{
			var_0B = maps\mp\gametypes\_horde_util::hordegetweaponupgrades(var_06,param_00);
			var_0C = maps\mp\gametypes\_horde_util::hordegetattachmentstring(var_0B,param_02);
			var_0D = 3;
			if(issubstr(var_0C,"optics") || issubstr(var_0C,"variablereddot") || issubstr(var_0C,"scope") || issubstr(var_06,"akimbosac3"))
			{
				var_0D = 4;
			}

			if(issubstr(param_02,"optics") || issubstr(param_02,"variablereddot") || issubstr(param_02,"scope"))
			{
				return 0;
			}

			if(var_0B.size + 1 > var_0D)
			{
				param_00 setclientomnvar("ui_horde_armory_purchase_fail",2);
				return 1;
			}
		}
		else
		{
			foreach(var_0F in var_05)
			{
				var_10 = getweaponbasename(var_0F);
				var_11 = maps\mp\gametypes\_horde_util::hordegetweaponsuffixspecial(param_02);
				param_02 = maps\mp\_utility::strip_suffix(param_02,var_11);
				if(issubstr(var_10,param_02))
				{
					param_00 setclientomnvar("ui_horde_armory_purchase_fail",1);
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 28
hordeammofull(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(issubstr(var_03,"turret"))
		{
			continue;
		}
		else if(param_00 setweaponammostock(var_03) < weaponmaxammo(var_03) || param_00 getweaponammoclip(var_03) < weaponclipsize(var_03))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 29
hordegiveperk(param_00)
{
	if(!maps\mp\_utility::_hasperk(param_00))
	{
		maps\mp\_utility::giveperk(param_00,1,1);
		maps\mp\perks\_perks::applyperks();
		var_01 = tablelookup("mp/hordeMenus.csv",2,param_00,0);
		self setclientomnvar("ui_horde_update_perk",int(var_01));
		var_02 = self.horde_perks.size;
		self.horde_perks[var_02]["name"] = param_00;
		self.horde_perks[var_02]["index"] = int(var_01);
		if(param_00 == "specialty_horde_weaponsfree")
		{
			self setclientomnvar("horde_has_weaponsfree",1);
		}
	}
}

//Function Number: 30
hordegivekillstreak(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_horde_util::getslotnumber(self);
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = strtok(tablelookup("mp/hordeMenus.csv",0,param_01,8)," ");
	var_03 = common_scripts\utility::array_combine(var_03,self.hordekillstreakmodules);
	var_03 = common_scripts\utility::array_remove_duplicates(var_03);
	self playlocalsound("ammo_crate_use");
	var_04 = maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex(var_02);
	thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(param_00,self,var_03,var_02,1);
	self.currentkillstreaks[var_02] = param_00;
	thread maps\mp\gametypes\_horde_util::hordescorestreaksplash(self,param_00,"horde_ss_splash_" + param_00,var_04);
}

//Function Number: 31
hordegivescorestreakupgrade(param_00,param_01)
{
	var_02 = param_00 getclientomnvar("ui_horde_player_class");
	param_00.hordekillstreakmodules[param_00.hordekillstreakmodules.size] = param_01;
	if(param_01 == "sentry_machinegun_turret" || param_01 == "sentry_energy_turret" || param_01 == "sentry_rocket_turret")
	{
		if(param_01 == "sentry_machinegun_turret")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "sentry_machinegun_turret")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"sentry_machinegun_turret");
				}
			}

			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "sentry_energy_turret")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"sentry_energy_turret");
				}
			}

			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "sentry_rocket_turret")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"sentry_rocket_turret");
				}
			}
		}
		else if(param_01 == "sentry_energy_turret")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "sentry_rocket_turret")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"sentry_rocket_turret");
				}
			}
		}
		else if(param_01 == "sentry_rocket_turret")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "sentry_energy_turret")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"sentry_energy_turret");
				}
			}
		}
	}
	else if(param_01 == "warbird_ai_attack" || param_01 == "warbird_ai_follow")
	{
		if(param_01 == "warbird_ai_attack")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "warbird_ai_follow")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"warbird_ai_follow");
				}
			}
		}
		else if(param_01 == "warbird_ai_follow")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "warbird_ai_attack")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"warbird_ai_attack");
				}
			}
		}
	}
	else if(param_01 == "missile_strike_hellfire" || param_01 == "missile_strike_cluster" || param_01 == "missile_strike_chem")
	{
		if(param_01 == "missile_strike_cluster")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "missile_strike_hellfire")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"missile_strike_hellfire");
				}

				if(var_04 == "missile_strike_chem")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"missile_strike_chem");
				}
			}
		}
		else if(param_01 == "missile_strike_hellfire")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "missile_strike_cluster")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"missile_strike_cluster");
				}

				if(var_04 == "missile_strike_chem")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"missile_strike_chem");
				}
			}
		}
		else if(param_01 == "missile_strike_chem")
		{
			foreach(var_04 in param_00.hordekillstreakmodules)
			{
				if(var_04 == "missile_strike_cluster")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"missile_strike_cluster");
				}

				if(var_04 == "missile_strike_hellfire")
				{
					param_00.hordekillstreakmodules = common_scripts\utility::array_remove(param_00.hordekillstreakmodules,"missile_strike_hellfire");
				}
			}
		}
	}

	for(var_18 = param_00.currentkillstreaks.size;var_18 >= 0;var_18--)
	{
		if(param_00.pers["killstreaks"][var_18].available == 1)
		{
			param_00 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(param_00.currentkillstreaks[var_18],self.owner,param_00.hordekillstreakmodules,var_18,1);
		}
	}
}