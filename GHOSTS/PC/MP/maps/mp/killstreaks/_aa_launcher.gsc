/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_aa_launcher.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 211 ms
 * Timestamp: 10/27/2023 1:20:08 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["aa_launcher"] = ::func_8423;
	maps\mp\_laserguidedlauncher::func_4DC6("vfx/gameplay/mp/killstreaks/vfx_maaws_split","vfx/gameplay/mp/killstreaks/vfx_maaws_homing");
}

//Function Number: 2
func_3A08()
{
	return "iw6_maaws_mp";
}

//Function Number: 3
func_3A06()
{
	return "iw6_maawschild_mp";
}

//Function Number: 4
func_3A07()
{
	return "iw6_maawshoming_mp";
}

//Function Number: 5
getaalauncherammo(param_00)
{
	var_01 = getaalauncheruniqueindex(param_00);
	var_02 = 0;
	if(isdefined(param_00.pers["aaLauncherAmmo"][var_01]))
	{
		var_02 = param_00.pers["aaLauncherAmmo"][var_01];
	}

	return var_02;
}

//Function Number: 6
clearaalauncherammo(param_00)
{
	var_01 = getaalauncheruniqueindex(param_00);
	param_00.pers["aaLauncherAmmo"][var_01] = undefined;
}

//Function Number: 7
setaalauncherammo(param_00,param_01,param_02)
{
	var_03 = getaalauncheruniqueindex(param_00);
	param_00.pers["aaLauncherAmmo"][var_03] = param_01;
	if(!isdefined(param_02) || param_02)
	{
		if(param_00 hasweapon(func_3A08()))
		{
			param_00 setweaponammoclip(func_3A08(),param_01);
		}
	}
}

//Function Number: 8
getaalauncheruniqueindex(param_00)
{
	return param_00.pers["killstreaks"][param_00.killstreakindexweapon].kid;
}

//Function Number: 9
func_8423(param_00,param_01)
{
	return func_87A3(self,param_00);
}

//Function Number: 10
func_87A3(param_00,param_01)
{
	if(!isdefined(self.pers["aaLauncherAmmo"]))
	{
		self.pers["aaLauncherAmmo"] = [];
	}

	if(getaalauncherammo(param_00) == 0)
	{
		setaalauncherammo(self,2,0);
	}

	level thread func_53DB(param_00);
	level thread func_53A1(param_00);
	thread maps\mp\_laserguidedlauncher::lgm_firing_monitormissilefire(func_3A08(),func_3A06(),func_3A07());
	var_02 = 0;
	var_03 = param_00 common_scripts\utility::func_8B33("aa_launcher_switch","aa_launcher_empty","death","disconnect");
	if(var_03 == "aa_launcher_empty")
	{
		param_00 common_scripts\utility::func_8B2A("weapon_change","LGM_player_allMissilesDestroyed","death","disconnect");
		var_02 = 1;
	}
	else
	{
		if(param_00 hasweapon(func_3A08()) && param_00 getammocount(func_3A08()) == 0)
		{
			clearaalauncherammo(param_00);
		}

		if(getaalauncherammo(param_00) == 0)
		{
			var_02 = 1;
		}
	}

	param_00 notify("aa_launcher_end");
	maps\mp\_laserguidedlauncher::func_4DC2();
	return var_02;
}

//Function Number: 11
func_53DB(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("aa_launcher_empty");
	param_00 endon("aa_launcher_end");
	var_01 = param_00 getcurrentweapon();
	while(var_01 == func_3A08())
	{
		param_00 waittill("weapon_change",var_01);
	}

	param_00 notify("aa_launcher_switch");
}

//Function Number: 12
func_53A1(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("aa_launcher_switch");
	param_00 endon("aa_launcher_end");
	setaalauncherammo(param_00,getaalauncherammo(param_00),1);
	for(;;)
	{
		param_00 waittill("weapon_fired",var_01);
		if(var_01 != func_3A08())
		{
			continue;
		}

		var_02 = param_00 getammocount(func_3A08());
		setaalauncherammo(param_00,var_02,0);
		if(getaalauncherammo(param_00) == 0)
		{
			clearaalauncherammo(param_00);
			param_00 notify("aa_launcher_empty");
			break;
		}
	}
}