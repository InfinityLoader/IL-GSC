/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_rippedturret.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 301 ms
 * Timestamp: 10/27/2023 2:10:00 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["ripped_turret"] = ::tryuserippedturret;
	level.killstreakwieldweapons["turretheadmg_mp"] = "ripped_turret";
	level.killstreakwieldweapons["turretheadenergy_mp"] = "ripped_turret";
	level.killstreakwieldweapons["turretheadrocket_mp"] = "ripped_turret";
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level thread onplayerspawned(var_00);
	}
}

//Function Number: 3
onplayerspawned(param_00)
{
	for(;;)
	{
		param_00 waittill("killstreakUseWaiter");
		level thread updateammo(param_00);
	}
}

//Function Number: 4
updateammo(param_00)
{
	param_00 setclientomnvar("ui_energy_ammo",1);
	if(!isdefined(param_00.pers["rippableSentry"]))
	{
		return;
	}

	var_01 = undefined;
	if(param_00 hasweapon("turretheadmg_mp"))
	{
		var_01 = "turretheadmg_mp";
	}
	else if(param_00 hasweapon("turretheadenergy_mp"))
	{
		var_01 = "turretheadenergy_mp";
	}
	else if(param_00 hasweapon("turretheadrocket_mp"))
	{
		var_01 = "turretheadrocket_mp";
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = param_00 playergetrippableammo();
	if(isturretenergyweapon(var_01))
	{
		var_03 = getammoforturretweapontype(var_01);
		var_04 = var_02 / var_03;
		param_00 setclientomnvar("ui_energy_ammo",var_04);
		return;
	}

	param_00 setweaponammoclip(var_01,var_02);
}

//Function Number: 5
tryuserippedturret(param_00,param_01)
{
	var_02 = tryuserippedturretinternal(param_01);
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("ripped_turret",self.origin);
	}

	return var_02;
}

//Function Number: 6
tryuserippedturretinternal(param_00)
{
	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	var_01 = playersetuprecordedturrethead(param_00);
	return var_01;
}

//Function Number: 7
playergiveturrethead(param_00)
{
	maps\mp\killstreaks\_killstreaks::givekillstreak("ripped_turret",0,0,self,[param_00]);
	if(!isdefined(self.pers["rippableSentry"]))
	{
		self.pers["rippableSentry"] = spawnstruct();
	}

	var_01 = getammoforturretweapontype(param_00);
	playerrecordrippableammo(var_01);
	if(!common_scripts\utility::is_player_gamepad_enabled())
	{
		self notify("streakUsed1");
		waittillframeend;
	}

	self switchtoweapon(param_00);
}

//Function Number: 8
playermoduleshaverippedturret(param_00)
{
	foreach(var_02 in param_00)
	{
		if(var_02 == "turretheadenergy_mp" || var_02 == "turretheadrocket_mp" || var_02 == "turretheadmg_mp")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
playersetuprecordedturrethead(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	var_01 = playergetrippableammo();
	var_02 = param_00[0];
	if(!isturretenergyweapon(var_02))
	{
		self setweaponammoclip(var_02,var_01);
	}

	self setweaponammostock(var_02,0);
	thread playermonitorweaponswitch(var_02);
	if(isturretenergyweapon(var_02))
	{
		thread playersetupturretenergybar(var_02,var_01);
	}
	else
	{
		thread playertrackturretammo(var_02);
	}

	common_scripts\utility::waittill_any_return("death","rippable_complete","rippable_switch");
	if(!isdefined(self))
	{
		return 0;
	}

	if(isturretenergyweapon(var_02))
	{
		self notifyonplayercommandremove("fire_turret_weapon","+attack");
		self notifyonplayercommandremove("fire_turret_weapon","+attack_akimbo_accessible");
	}

	var_03 = !playerhasrippableturretinfo();
	return var_03;
}

//Function Number: 10
playermonitorweaponswitch(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("rippable_complete");
	var_01 = self getcurrentweapon();
	while(var_01 == param_00 || maps\mp\_utility::isbombsiteweapon(var_01))
	{
		self waittill("weapon_change",var_01);
	}

	if(maps\mp\_utility::iskillstreakweapon(var_01))
	{
		self.justswitchedtokillstreakweapon = var_01;
	}

	self notify("rippable_switch");
}

//Function Number: 11
playertrackturretammo(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("rippable_switch");
	for(;;)
	{
		var_01 = self getweaponammoclip(param_00);
		playerrecordrippableammo(var_01);
		if(var_01 == 0)
		{
			playerclearrippableturretinfo();
			self notify("rippable_complete");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 12
playerhasturretheadweapon()
{
	if(playerhasrippableturretinfo())
	{
		return 1;
	}

	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(var_02 == "turretheadenergy_mp" || var_02 == "turretheadrocket_mp" || var_02 == "turretheadmg_mp")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
getammoforturretweapontype(param_00)
{
	if(param_00 == "turretheadmg_mp")
	{
		return 100;
	}

	if(param_00 == "turretheadrocket_mp")
	{
		return 6;
	}

	return getfullenergy();
}

//Function Number: 14
isturretenergyweapon(param_00)
{
	return param_00 == "turretheadenergy_mp";
}

//Function Number: 15
playersetupturretenergybar(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("rippable_switch");
	var_02 = getfullenergy();
	self notifyonplayercommand("fire_turret_weapon","+attack");
	self notifyonplayercommand("fire_turret_weapon","+attack_akimbo_accessible");
	param_01 = playergetrippableammo();
	var_03 = param_01 / var_02;
	self setclientomnvar("ui_energy_ammo",var_03);
	for(;;)
	{
		if(!self attackbuttonpressed())
		{
			self waittill("fire_turret_weapon");
		}

		if(self isreloading() || self getcurrentweapon() != "turretheadenergy_mp" || !self isfiring() || self isusingoffhand())
		{
			wait 0.05;
			continue;
		}

		param_01 = playergetrippableammo();
		param_01 = clamp(param_01 - 1,0,getfullenergy());
		var_03 = param_01 / var_02;
		self setclientomnvar("ui_energy_ammo",var_03);
		if(param_01 <= 0)
		{
			var_04 = self getweaponslistprimaries();
			if(var_04.size > 0)
			{
				self switchtoweapon(var_04[0]);
			}
			else
			{
				self takeweapon(param_00);
			}

			playerclearrippableturretinfo();
			self notify("rippable_complete");
			return;
		}

		wait 0.05;
		playerrecordrippableammo(var_02);
	}
}

//Function Number: 16
getfullenergy()
{
	return 200;
}

//Function Number: 17
playergetrippableammo()
{
	return self.pers["rippableSentry"].ammo;
}

//Function Number: 18
playerrecordrippableammo(param_00)
{
	self.pers["rippableSentry"].ammo = param_00;
}

//Function Number: 19
playerhasrippableturretinfo()
{
	return isdefined(self.pers["rippableSentry"]) && playergetrippableammo() > 0;
}

//Function Number: 20
playerclearrippableturretinfo()
{
	self.pers["rippableSentry"] = undefined;
}