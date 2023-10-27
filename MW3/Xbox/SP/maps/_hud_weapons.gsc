/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hud_weapons.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 195 ms
 * Timestamp: 10/27/2023 2:34:23 AM
*******************************************************************/

//Function Number: 1
registerweaponinfo(param_00,param_01,param_02,param_03)
{
	level.weaponinfo[param_00]["type"] = param_02;
	level.weaponinfo[param_00]["clip"] = param_03;
	level.weaponinfo[param_00]["string"] = param_01;
	precachestring(param_01);
}

//Function Number: 2
func_3BB0(param_00)
{
	if(!isdefined(level.weaponinfo[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_3BB1(param_00)
{
	return level.weaponinfo[param_00]["type"];
}

//Function Number: 4
func_3BB2(param_00)
{
	return level.weaponinfo[param_00]["clip"];
}

//Function Number: 5
getweaponinfostring(param_00)
{
	return level.weaponinfo[param_00]["string"];
}

//Function Number: 6
init()
{
	precacheshader("hud_bullets_rifle");
	precacheshader("hud_bullets_pistol");
	precacheshader("hud_bullets_sniper");
	precacheshader("hud_bullets_spread");
	precacheshader("hud_bullets_support_front");
	precacheshader("hud_bullets_support_back");
	level.bulletalphas = [];
	level.bulletalphas[level.bulletalphas.size] = 1;
	level.bulletalphas[level.bulletalphas.size] = 0.996;
	level.bulletalphas[level.bulletalphas.size] = 0.949;
	level.bulletalphas[level.bulletalphas.size] = 0.909;
	level.bulletalphas[level.bulletalphas.size] = 0.87;
	level.bulletalphas[level.bulletalphas.size] = 0.835;
	level.bulletalphas[level.bulletalphas.size] = 0.803;
	level.bulletalphas[level.bulletalphas.size] = 0.776;
	level.bulletalphas[level.bulletalphas.size] = 0.749;
	level.bulletalphas[level.bulletalphas.size] = 0.721;
	level.bulletalphas[level.bulletalphas.size] = 0.698;
	level.bulletalphas[level.bulletalphas.size] = 0.674;
	level.bulletalphas[level.bulletalphas.size] = 0.654;
	level.bulletalphas[level.bulletalphas.size] = 0.635;
	level.bulletalphas[level.bulletalphas.size] = 0.615;
	level.bulletalphas[level.bulletalphas.size] = 0.596;
	level.bulletalphas[level.bulletalphas.size] = 0.58;
	level.bulletalphas[level.bulletalphas.size] = 0.564;
	level.bulletalphas[level.bulletalphas.size] = 0.549;
	level.bulletalphas[level.bulletalphas.size] = 0.537;
	level.bulletalphas[level.bulletalphas.size] = 0.521;
	level.bulletalphas[level.bulletalphas.size] = 0.509;
	level.bulletalphas[level.bulletalphas.size] = 0.498;
	level.weaponinfo = [];
	registerweaponinfo("ak47",&"WEAPON_AK47_FULLAUTO","rifle",30);
	registerweaponinfo("ak47_semi",&"WEAPON_AK47_SEMIAUTO","rifle",30);
	registerweaponinfo("ak47_grenadier",&"WEAPON_AK47","rifle",30);
	registerweaponinfo("ak74u",&"WEAPON_AK74U_FULLAUTO","rifle",30);
	registerweaponinfo("ak74u_semi",&"WEAPON_AK74U_SEMIAUTO","rifle",30);
	registerweaponinfo("beretta",&"WEAPON_BERETTA","pistol",15);
	registerweaponinfo("g36c",&"WEAPON_G36C","rifle",30);
	registerweaponinfo("m14_scoped",&"WEAPON_M14","sniper",10);
	registerweaponinfo("m16_basic",&"WEAPON_M16A4_FULLAUTO","rifle",30);
	registerweaponinfo("m16_basic_semi",&"WEAPON_M16A4_SEMIAUTO","rifle",30);
	registerweaponinfo("m16_grenadier",&"WEAPON_M16","rifle",30);
	registerweaponinfo("m203",&"WEAPON_M203","grenade",1);
	registerweaponinfo("rpg",&"WEAPON_RPG","grenade",5);
	registerweaponinfo("saw",&"WEAPON_SAW","support",100);
	registerweaponinfo("m4_grunt",&"WEAPON_M4_FULLAUTO","rifle",30);
	registerweaponinfo("m4_grunt_semi",&"WEAPON_M4_SEMIAUTO","rifle",30);
	registerweaponinfo("m4_grenadier",&"WEAPON_M4","rifle",30);
	registerweaponinfo("m40a3",&"WEAPON_M40A3","sniper",10);
	registerweaponinfo("mp5",&"WEAPON_MP5","smg",30);
	registerweaponinfo("mp5_silencer",&"WEAPON_MP5SD","smg",30);
	registerweaponinfo("usp",&"WEAPON_USP","pistol",10);
	registerweaponinfo("at4",&"WEAPON_AT4","rocketlauncher",1);
	registerweaponinfo("dragunov",&"WEAPON_DRAGUNOV","sniper",10);
	registerweaponinfo("g3",&"WEAPON_G3","rifle",30);
	registerweaponinfo("winchester1200",&"WEAPON_WINCHESTER1200","shotgun",4);
	registerweaponinfo("uzi",&"WEAPON_UZI","smg",32);
	level.player func_3BB5();
}

//Function Number: 7
func_3BB5()
{
	if(!isdefined(self.var_3BB6))
	{
		self.var_3BB6 = [];
	}

	if(!isdefined(self.var_3BB6[0]))
	{
		self.var_3BB6[0] = maps\_hud_util::createicon(undefined,24,96);
		self.var_3BB6[0] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
		self.var_3BB6[0].sort = 10;
	}

	if(!isdefined(self.var_3BB6[1]))
	{
		self.var_3BB6[1] = maps\_hud_util::createicon(undefined,24,96);
		self.var_3BB6[1] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
		self.var_3BB6[1].color = (0.7,0.7,0.7);
		self.var_3BB6[1].sort = 9;
	}

	if(!isdefined(self.var_3BB6[2]))
	{
		self.var_3BB6[2] = maps\_hud_util::createicon(undefined,24,96);
		self.var_3BB6[2] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
		self.var_3BB6[2].sort = 10;
	}

	if(!isdefined(self.var_3BB6[3]))
	{
		self.var_3BB6[3] = maps\_hud_util::createicon(undefined,24,96);
		self.var_3BB6[3] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
		self.var_3BB6[3].color = (0.7,0.7,0.7);
		self.var_3BB6[3].sort = 9;
	}

	if(!isdefined(self.var_3BB6[4]))
	{
		self.var_3BB6[4] = maps\_hud_util::createicon(undefined,24,96);
		self.var_3BB6[4] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
		self.var_3BB6[4].sort = 10;
	}

	thread func_3BB7();
}

//Function Number: 8
func_3BB7()
{
	self endon("death");
	var_00 = -1;
	var_01 = "";
	var_02 = "";
	for(;;)
	{
		var_03 = self getcurrentweapon();
		if(func_3BB0(var_03))
		{
			var_04 = func_3BB1(var_03);
			var_05 = self getweaponammoclip(self getcurrentweapon());
			if(var_03 != var_01 && var_04 != var_02)
			{
				func_3BB8(var_04);
				var_01 = var_03;
				var_02 = var_04;
				var_00 = -1;
			}

			if(var_05 != var_00)
			{
				updatehudweaponammo(var_03,var_05);
				var_00 = var_05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 9
func_3BB8(param_00)
{
	self.pers["weaponType"] = param_00;
	if(!isdefined(self.var_3BB6))
	{
		return;
	}

	for(var_01 = 0;var_01 < self.var_3BB6.size;var_01++)
	{
		self.var_3BB6[var_01].alpha = 0;
	}

	switch(param_00)
	{
		case "pistol":
			self.var_3BB6[0] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
			self.var_3BB6[0] maps\_hud_util::seticonshader("hud_bullets_pistol");
			self.var_3BB6[0].alpha = 1;
			break;

		case "smg":
			self.var_3BB6[0] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
			self.var_3BB6[0] maps\_hud_util::seticonshader("hud_bullets_rifle");
			self.var_3BB6[1] maps\_hud_util::seticonshader("hud_bullets_rifle");
			self.var_3BB6[1] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-4,-50);
			self.var_3BB6[0].alpha = 1;
			self.var_3BB6[1].alpha = 1;
			break;

		case "rifle":
			self.var_3BB6[0] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
			self.var_3BB6[0] maps\_hud_util::seticonshader("hud_bullets_rifle");
			self.var_3BB6[1] maps\_hud_util::seticonshader("hud_bullets_rifle");
			self.var_3BB6[1] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-4,-50);
			self.var_3BB6[0].alpha = 1;
			self.var_3BB6[1].alpha = 1;
			break;

		case "sniper":
			self.var_3BB6[0] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
			self.var_3BB6[0] maps\_hud_util::seticonshader("hud_bullets_sniper");
			self.var_3BB6[0].alpha = 1;
			break;

		case "spread":
			self.var_3BB6[0] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6,-47);
			self.var_3BB6[0] maps\_hud_util::seticonshader("hud_bullets_spread");
			self.var_3BB6[0].alpha = 1;
			break;

		case "support":
			var_02 = 0;
			for(var_01 = 0;var_01 < 5;var_01++)
			{
				self.var_3BB6[var_01] maps\_hud_util::setpoint("BOTTOMRIGHT","BOTTOMRIGHT",-6 + var_02,-70);
				self.var_3BB6[var_01].alpha = 1;
				if(var_01 % 2)
				{
					self.var_3BB6[var_01] maps\_hud_util::seticonshader("hud_bullets_support_back");
				}
				else
				{
					self.var_3BB6[var_01] maps\_hud_util::seticonshader("hud_bullets_support_front");
				}
	
				var_02 = var_02 - 14;
			}
			break;
	}
}

//Function Number: 10
gethudweapontype()
{
	return self.pers["weaponType"];
}

//Function Number: 11
updatehudweaponammo(param_00,param_01)
{
	if(!isdefined(self.var_3BB6))
	{
		return;
	}

	switch(gethudweapontype())
	{
		case "pistol":
			var_02 = 15 - func_3BB2(param_00);
			var_03 = func_3BB2(param_00) - param_01;
			self.var_3BB6[0].alpha = level.bulletalphas[var_02 + var_03];
			break;

		case "rifle":
			var_03 = func_3BB2(param_00) - param_01;
			var_04 = int(var_03 / 2);
			var_04 = var_04 + var_03 % 2;
			var_05 = int(var_03 / 2);
			self.var_3BB6[0].alpha = level.bulletalphas[var_04];
			self.var_3BB6[1].alpha = level.bulletalphas[var_05];
			break;

		case "smg":
			var_03 = func_3BB2(param_00) - param_01;
			var_04 = int(var_03 / 2);
			var_04 = var_04 + var_03 % 2;
			var_05 = int(var_03 / 2);
			self.var_3BB6[0].alpha = level.bulletalphas[var_04];
			self.var_3BB6[1].alpha = level.bulletalphas[var_05];
			break;

		case "sniper":
			var_02 = 15 - func_3BB2(param_00);
			var_03 = func_3BB2(param_00) - param_01;
			self.var_3BB6[0].alpha = level.bulletalphas[var_02 + var_03];
			break;

		case "spread":
			var_02 = 15 - func_3BB2(param_00);
			var_03 = func_3BB2(param_00) - param_01;
			self.var_3BB6[0].alpha = level.bulletalphas[var_02 + var_03];
			break;

		case "support":
			var_02 = 100 - func_3BB2(param_00);
			var_03 = func_3BB2(param_00) - param_01;
			var_03 = var_02 + var_03;
			var_06 = 20;
			for(var_07 = 4;var_07 >= 0;var_07--)
			{
				if(var_03 > var_06)
				{
					self.var_3BB6[var_07].alpha = 0;
				}
				else if(var_06 - var_03 <= 20)
				{
					self.var_3BB6[var_07].alpha = level.bulletalphas[var_03 - var_06 - 20];
				}
				else
				{
					self.var_3BB6[var_07].alpha = 1;
				}
	
				var_06 = var_06 + 20;
			}
			break;
	}
}