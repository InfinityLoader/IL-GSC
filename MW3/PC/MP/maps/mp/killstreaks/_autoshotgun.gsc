/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_autoshotgun.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 173 ms
 * Timestamp: 10/27/2023 2:13:54 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["auto_shotgun"] = ::tryuseautoshotgun;
	level.killstreaksetupfuncs["auto_shotgun"] = ::shotgunsetup;
	level.killstreakfuncs["thumper"] = ::tryusethumper;
	level.killstreaksetupfuncs["thumper"] = ::thumpersetup;
	thread onplayerconnect();
}

//Function Number: 2
shotgunsetup()
{
	self givemaxammo("aa12_mp");
	thread saveweaponammoondeath("aa12_mp");
}

//Function Number: 3
tryuseautoshotgun(param_00)
{
	thread removeweapononoutofammo("aa12_mp");
	return 1;
}

//Function Number: 4
thumpersetup()
{
	self givemaxammo("m79_mp");
	thread saveweaponammoondeath("m79_mp");
}

//Function Number: 5
tryusethumper()
{
	thread removeweapononoutofammo("m79_mp");
	return 1;
}

//Function Number: 6
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 7
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(!isdefined(self.pers["ksWeapon_clip_ammo"]) || !isdefined(self.pers["ksWeapon_name"]))
		{
			continue;
		}

		var_00 = self.pers["ksWeapon_name"];
		if(isdefined(self.pers["killstreak"]) && maps\mp\killstreaks\_killstreaks::getkillstreakweapon(self.pers["killstreak"]) != var_00)
		{
			self.pers["ksWeapon_name"] = undefined;
			self.pers["ksWeapon_clip_ammo"] = undefined;
			self.pers["ksWeapon_stock_ammo"] = undefined;
			continue;
		}

		maps\mp\killstreaks\_killstreaks::givekillstreakweapon(var_00);
		self setweaponammostock(var_00,self.pers["ksWeapon_stock_ammo"]);
		self setweaponammoclip(var_00,self.pers["ksWeapon_clip_ammo"]);
		thread removeweapononoutofammo(var_00);
		thread saveweaponammoondeath(var_00);
	}
}

//Function Number: 8
saveweaponammoondeath(param_00)
{
	self endon("disconnect");
	self endon("got_killstreak");
	self notify("saveWeaponAmmoOnDeath");
	self endon("saveWeaponAmmoOnDeath");
	self.pers["ksWeapon_name"] = undefined;
	self.pers["ksWeapon_clip_ammo"] = undefined;
	self.pers["ksWeapon_stock_ammo"] = undefined;
	self waittill("death");
	if(!self hasweapon(param_00))
	{
		return;
	}

	self.pers["ksWeapon_name"] = param_00;
	self.pers["ksWeapon_clip_ammo"] = self getweaponammoclip(param_00);
	self.pers["ksWeapon_stock_ammo"] = self getweaponammostock(param_00);
}

//Function Number: 9
removeweapononoutofammo(param_00)
{
	self endon("disconnect");
	self endon("death");
	self notify(param_00 + "_ammo_monitor");
	self endon(param_00 + "_ammo_monitor");
	for(;;)
	{
		self waittill("end_firing");
		if(self getcurrentweapon() != param_00)
		{
			continue;
		}

		var_01 = self getweaponammoclip(param_00) + self getweaponammostock(param_00);
		if(var_01)
		{
			continue;
		}

		self takeweapon(param_00);
	}
}