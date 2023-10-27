/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_autoshotgun.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 177 ms
 * Timestamp: 10/27/2023 1:20:29 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["auto_shotgun"] = ::func_842B;
	level.killstreaksetupfuncs["auto_shotgun"] = ::func_7460;
	level.killstreakfuncs["thumper"] = ::func_8459;
	level.killstreaksetupfuncs["thumper"] = ::func_80C8;
	thread func_595D();
}

//Function Number: 2
func_7460()
{
	self givemaxammo("aa12_mp");
	thread func_6AAD("aa12_mp");
}

//Function Number: 3
func_842B(param_00)
{
	thread func_65BC("aa12_mp");
	return 1;
}

//Function Number: 4
func_80C8()
{
	self givemaxammo("m79_mp");
	thread func_6AAD("m79_mp");
}

//Function Number: 5
func_8459()
{
	thread func_65BC("m79_mp");
	return 1;
}

//Function Number: 6
func_595D()
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
		if(isdefined(self.pers["killstreak"]) && maps\mp\_utility::getkillstreakweapon(self.pers["killstreak"]) != var_00)
		{
			self.pers["ksWeapon_name"] = undefined;
			self.pers["ksWeapon_clip_ammo"] = undefined;
			self.pers["ksWeapon_stock_ammo"] = undefined;
			continue;
		}

		maps\mp\killstreaks\_killstreaks::givekillstreakweapon(var_00);
		self setweaponammostock(var_00,self.pers["ksWeapon_stock_ammo"]);
		self setweaponammoclip(var_00,self.pers["ksWeapon_clip_ammo"]);
		thread func_65BC(var_00);
		thread func_6AAD(var_00);
	}
}

//Function Number: 8
func_6AAD(param_00)
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
	}

	self.pers["ksWeapon_name"] = param_00;
	self.pers["ksWeapon_clip_ammo"] = self getweaponammoclip(param_00);
	self.pers["ksWeapon_stock_ammo"] = self getweaponammostock(param_00);
}

//Function Number: 9
func_65BC(param_00)
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