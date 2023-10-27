/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_oldschool.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 527 ms
 * Timestamp: 10/27/2023 2:37:57 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(maps\mp\_utility::invirtuallobby())
	{
		level.oldschool = 0;
		return;
	}

	if(!level.oldschool)
	{
		deletepickups();
		return;
	}

	if(getdvar("scr_os_pickupweaponrespawntime") == "")
	{
		setdvar("scr_os_pickupweaponrespawntime","15");
	}

	level.pickupweaponrespawntime = getdvarfloat("scr_os_pickupweaponrespawntime");
	if(getdvar("scr_os_pickupperkrespawntime") == "")
	{
		setdvar("scr_os_pickupperkrespawntime","25");
	}

	level.pickupperkrespawntime = getdvarfloat("scr_os_pickupperkrespawntime");
	oldschoolloadout();
	level.bypassclasschoicefunc = ::bypassclasschoicefunc;
	level.streamprimariesfunc = ::streamprimariesfunc;
	thread initpickups();
	thread onplayerconnect();
	level.oldschoolpickupsound = "oldschool_pickup";
	level.oldschoolrespawnsound = "oldschool_return";
	level.perkpickuphints = [];
	level.perkpickuphints["specialty_bulletdamage"] = &"PLATFORM_PICK_UP_STOPPING_POWER";
	level.perkpickuphints["specialty_armorvest"] = &"PLATFORM_PICK_UP_JUGGERNAUT";
	level.perkpickuphints["specialty_rof"] = &"PLATFORM_PICK_UP_DOUBLE_TAP";
	level.perkpickuphints["specialty_pistoldeath"] = &"PLATFORM_PICK_UP_LAST_STAND";
	level.perkpickuphints["specialty_grenadepulldeath"] = &"PLATFORM_PICK_UP_MARTYRDOM";
	level.perkpickuphints["specialty_fastreload"] = &"PLATFORM_PICK_UP_SLEIGHT_OF_HAND";
}

//Function Number: 2
bypassclasschoicefunc()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.pers["gamemodeLoadout"] = level.oldschool_loadout;
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
	self method_8508(level.oldschool_loadout["loadoutPrimary"]);
}

//Function Number: 3
streamprimariesfunc()
{
	var_00 = ["axis","allies"];
	var_01 = maps\mp\gametypes\_class::buildweaponname(level.oldschool_loadout["loadoutPrimary"]);
	var_02 = maps\mp\gametypes\_class::buildweaponname(level.oldschool_loadout["loadoutSecondary"]);
	var_03 = [];
	foreach(var_05 in var_00)
	{
		var_06 = spawnstruct();
		var_06.team = var_05;
		var_06.weapon = var_01;
		var_03[var_03.size] = var_06;
	}

	self method_8420(var_03,var_01,var_02);
}

//Function Number: 4
oldschoolloadout()
{
	level.oldschool_loadout = maps\mp\gametypes\_class::getemptyloadout();
	level.oldschool_loadout["loadoutPrimary"] = "h1_skorpion";
	level.oldschool_loadout["loadoutSecondary"] = "h1_beretta";
	level.oldschool_loadout["loadoutEquipment"] = "h1_fraggrenade_mp";
	level.oldschool_loadout["loadoutOffhand"] = "h1_flashgrenade_mp";
}

//Function Number: 5
deletepickups()
{
	var_00 = getentarray("oldschool_pickup","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].target))
		{
			getent(var_00[var_01].target,"targetname") delete();
		}

		var_00[var_01] delete();
	}
}

//Function Number: 6
converttoh1weaponclassname(param_00,param_01)
{
	switch(param_00)
	{
		case "weapon_h1_fraggrenade_mp":
		case "weapon_frag_grenade_mp":
			break;

		case "weapon_h1_smokegrenade_mp":
		case "weapon_smoke_grenade_mp":
			break;

		case "weapon_h1_flashgrenade_mp":
		case "weapon_flash_grenade_mp":
			break;

		default:
			break;
	}
}

//Function Number: 7
converttoh1pickup(param_00)
{
	var_01 = param_00.origin;
	var_02 = param_00.angles;
	var_03 = 19;
	var_04 = param_00.targetname;
	var_05 = converttoh1weaponclassname(param_00.classname,param_00.script_noteworthy);
	var_06 = spawn(var_05,var_01,var_03);
	var_06.angles = var_02;
	var_06.targetname = var_04;
	var_06.script_parameters = param_00.script_parameters;
	param_00 delete();
}

//Function Number: 8
isweaponpickup(param_00)
{
	var_01 = param_00.classname;
	return isdefined(var_01) && issubstr(var_01,"weapon_");
}

//Function Number: 9
usenormalfx()
{
	level.pickupavailableeffect = loadfx("misc/ui_pickup_available");
	level.pickupunavailableeffect = loadfx("misc/ui_pickup_unavailable");
}

//Function Number: 10
usebrightfx()
{
	level.pickupavailableeffect = loadfx("misc/ui_pickup_available_bright");
	level.pickupunavailableeffect = loadfx("misc/ui_pickup_unavailable_bright");
}

//Function Number: 11
useunlitfx()
{
	level.pickupavailableeffect = loadfx("misc/ui_pickup_available_unlit");
	level.pickupunavailableeffect = loadfx("misc/ui_pickup_unavailable_unlit");
}

//Function Number: 12
initpickups()
{
	if(!isdefined(level.oldschoolfxtype))
	{
		level.oldschoolfxtype = "normal";
	}

	switch(level.oldschoolfxtype)
	{
		case "unlit":
			break;

		case "bright":
			break;

		default:
			break;
	}
}

//Function Number: 13
spawnpickupfx(param_00,param_01)
{
	var_02 = spawnfx(param_01,param_00,(0,0,1),(1,0,0));
	triggerfx(var_02);
	return var_02;
}

//Function Number: 14
playeffectshortly(param_00)
{
	self endon("death");
	wait(0.05);
	playfxontag(param_00,self,"tag_origin");
}

//Function Number: 15
getpickupgroundpoint(param_00)
{
	var_01 = 44;
	var_02 = bullettrace(param_00.origin,param_00.origin + (0,0,-128),0,param_00);
	var_03 = var_02["position"];
	var_04 = var_03[2];
	for(var_05 = 1;var_05 <= 3;var_05++)
	{
		var_06 = var_05 / 3 * var_01;
		for(var_07 = 0;var_07 < 10;var_07++)
		{
			var_08 = var_07 / 10 * 360;
			var_09 = param_00.origin + (cos(var_08),sin(var_08),0) * var_06;
			var_02 = bullettrace(var_09,var_09 + (0,0,-128),0,param_00);
			var_0A = var_02["position"];
			if(var_0A[2] > var_04 && var_0A[2] < var_03[2] + 15)
			{
				var_04 = var_0A[2];
			}
		}
	}

	return (var_03[0],var_03[1],var_04);
}

//Function Number: 16
trackpickup(param_00,param_01)
{
	var_02 = getpickupgroundpoint(param_00);
	param_00.groundpoint = var_02;
	var_03 = spawnpickupfx(var_02,level.pickupavailableeffect);
	var_04 = param_00.classname;
	var_05 = param_00.origin;
	var_06 = param_00.angles;
	var_07 = param_00.spawnflags;
	var_08 = param_00.model;
	var_09 = param_00.targetname;
	var_0A = param_00.script_noteworthy;
	var_0B = 0;
	var_0C = 0;
	var_0D = undefined;
	var_0E = undefined;
	var_0F = undefined;
	var_10 = undefined;
	if(issubstr(var_04,"weapon_"))
	{
		var_0B = 1;
		var_0D = param_00 maps\mp\gametypes\_weapons::getitemweaponname();
		var_10 = level.pickupweaponrespawntime;
	}
	else if(var_04 == "script_model")
	{
		var_0C = 1;
		var_0E = param_00.script_noteworthy;
		if(!isdefined(level.perkpickuphints[var_0E]))
		{
			common_scripts\utility::error("oldschool_pickup with classname script_model does not have script_noteworthy set to a valid perk");
			return;
		}

		var_0F = getent(param_00.target,"targetname");
		var_10 = level.pickupperkrespawntime;
		if(!getdvarint("scr_game_perks"))
		{
			param_00 delete();
			var_0F delete();
			var_03 delete();
			return;
		}

		if(isdefined(level.perkpickuphints[var_0E]))
		{
			var_0F sethintstring(level.perkpickuphints[var_0E]);
		}
	}
	else
	{
		common_scripts\utility::error("oldschool_pickup with classname " + var_04 + " is not supported (at location " + param_00.origin + ")");
		return;
	}

	if(isdefined(param_00.script_delay))
	{
		var_10 = param_00.script_delay;
	}

	param_00.respawntime = var_10;
	for(;;)
	{
		var_11 = undefined;
		if(var_0B)
		{
			param_00 thread changesecondarygrenadetype(var_0D);
			param_00 setpickupstartammo(var_0D);
			for(;;)
			{
				param_00 waittill("trigger",var_11,var_12);
				if(!isdefined(param_00))
				{
					break;
				}
			}

			if(isdefined(var_12))
			{
				var_13 = 5;
				if(var_13 > var_10)
				{
					var_13 = var_10;
				}

				var_12 thread delayeddeletion(var_13);
			}
		}
		else
		{
			var_0F waittill("trigger",var_11);
			param_00 delete();
			var_0F common_scripts\utility::trigger_off();
		}

		if(var_0B)
		{
			if(weaponinventorytype(var_0D) == "item" && !isdefined(var_11.inventoryweapon) || var_0D != var_11.inventoryweapon)
			{
				var_11 removeinventoryweapon();
				var_11.inventoryweapon = var_0D;
				var_11 setactionslot(3,"weapon",var_0D);
			}
		}
		else if(!var_11 maps\mp\_utility::_hasperk(var_0E))
		{
			var_11 maps\mp\_utility::giveperk(var_0E,1,var_11.numperks);
			var_11.numperks++;
		}

		thread maps\mp\_utility::playsoundinspace(level.oldschoolpickupsound,var_05);
		var_03 delete();
		var_03 = spawnpickupfx(var_02,level.pickupunavailableeffect);
		wait(var_10);
		param_00 = spawn(var_04,var_05,var_07);
		param_00.angles = var_06;
		param_00.targetname = var_09;
		param_00.script_noteworthy = var_0A;
		param_00.groundpoint = var_02;
		param_00.respawntime = var_10;
		if(var_0C)
		{
			param_00 setmodel(var_08);
			var_0F common_scripts\utility::trigger_on();
		}

		param_00 playsound(level.oldschoolrespawnsound);
		var_03 delete();
		var_03 = spawnpickupfx(var_02,level.pickupavailableeffect);
	}
}

//Function Number: 17
setpickupstartammo(param_00)
{
	var_01 = param_00;
	for(var_02 = 0;var_02 == 0 || var_01 != param_00 && var_01 != "none";var_02++)
	{
		var_03 = weaponstartammo(var_01);
		var_04 = weaponclipsize(var_01);
		var_05 = 0;
		if(var_04 >= var_03)
		{
			var_04 = var_03;
		}
		else
		{
			var_05 = var_03 - var_04;
		}

		self itemweaponsetammo(var_04,var_05,var_04,var_02);
		var_01 = weaponaltweaponname(var_01);
	}
}

//Function Number: 18
changesecondarygrenadetype(param_00)
{
	self endon("trigger");
	var_01 = "h1_smokegrenade_mp";
	var_02 = "h1_flashgrenade_mp";
	var_03 = "h1_concussiongrenade_mp";
	if(param_00 != var_01 && param_00 != var_02 && param_00 != var_03)
	{
		return;
	}

	var_04 = spawn("trigger_radius",self.origin - (0,0,20),0,128,64);
	thread deletetriggerwhenpickedup(var_04);
	for(;;)
	{
		var_04 waittill("trigger",var_05);
		if(var_05 getweaponammototal(var_01) == 0 && var_05 getweaponammototal(var_02) == 0 && var_05 getweaponammototal(var_03) == 0)
		{
			var_05 setoffhandsecondaryclass(param_00);
		}
	}
}

//Function Number: 19
deletetriggerwhenpickedup(param_00)
{
	self waittill("trigger");
	param_00 delete();
}

//Function Number: 20
resetactionslottoaltmode(param_00)
{
	self notify("resetting_action_slot_to_alt_mode");
	self endon("resetting_action_slot_to_alt_mode");
	for(;;)
	{
		if(getweaponammototal(param_00) == 0)
		{
			var_01 = self getcurrentweapon();
			if(var_01 != param_00 && var_01 != "none")
			{
				break;
			}
		}

		wait(0.2);
	}

	removeinventoryweapon();
	self setactionslot(3,"altmode");
}

//Function Number: 21
getweaponammototal(param_00)
{
	return self getweaponammoclip(param_00) + self getweaponammostock(param_00);
}

//Function Number: 22
removeinventoryweapon()
{
	if(isdefined(self.inventoryweapon))
	{
		self takeweapon(self.inventoryweapon);
	}

	self.inventoryweapon = undefined;
}

//Function Number: 23
delayeddeletion(param_00)
{
	thread delayeddeletiononswappedweapons(param_00);
	wait(param_00);
	if(isdefined(self))
	{
		self notify("death");
		self delete();
	}
}

//Function Number: 24
delayeddeletiononswappedweapons(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		if(isdefined(var_02))
		{
			break;
		}
	}

	var_02 thread delayeddeletion(param_00);
}

//Function Number: 25
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 26
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.inventoryweapon = undefined;
		self clearperks();
		self.numperks = 0;
		thread clearperksondeath();
		thread watchweaponslist();
	}
}

//Function Number: 27
clearperksondeath()
{
	self endon("disconnect");
	self waittill("death");
	self clearperks();
	self.numperks = 0;
}

//Function Number: 28
watchweaponslist()
{
	self endon("death");
	waittillframeend;
	self.weapons = self getweaponslistall();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		thread updateweaponslist(0.05);
	}
}

//Function Number: 29
updateweaponslist(param_00)
{
	self endon("death");
	self notify("updating_weapons_list");
	self endon("updating_weapons_list");
	self.weapons = self getweaponslistall();
}

//Function Number: 30
hadweaponbeforepickingup(param_00)
{
	for(var_01 = 0;var_01 < self.weapons.size;var_01++)
	{
		if(self.weapons[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 31
givestartammooldschool(param_00)
{
	self setweaponammostock(param_00,self getweaponammostock(param_00) + self getweaponammoclip(param_00));
}