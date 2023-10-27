/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_playertrophy_system.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 497 ms
 * Timestamp: 10/27/2023 12:21:16 AM
*******************************************************************/

//Function Number: 1
func_D446()
{
	self endon("death");
	self endon("disconnect");
	self endon("player_trophy_unset");
	if(!isdefined(level._effect["pts_detonate"]))
	{
		level._effect["pts_detonate"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
	}

	if(!isdefined(level._effect["pts_drone_drop"]))
	{
		level._effect["pts_drone_drop"] = loadfx("vfx/iw7/_requests/mp/vfx_pts_drone_drop.vfx");
	}

	for(;;)
	{
		func_D447();
		wait(40);
	}
}

//Function Number: 2
func_D448()
{
	self notify("player_trophy_unset");
	func_D441();
}

//Function Number: 3
func_D447()
{
	self endon("player_trophy_end");
	self notify("player_trophy_start");
	self endon("player_trophy_start");
	self setclientomnvar("ui_dodge_charges",5);
	if(self.var_AE62 == "archetype_engineer")
	{
		self setscriptablepartstate("pts_drone","active");
	}

	thread playertrophy_watchemp();
	thread playertrophy_watchownerdeath();
	func_D449();
}

//Function Number: 4
func_D441()
{
	self notify("player_trophy_end");
	self setclientomnvar("ui_dodge_charges",0);
	if(self.var_AE62 == "archetype_engineer")
	{
		self setscriptablepartstate("pts_drone","off");
	}
}

//Function Number: 5
func_D449()
{
	var_00 = scripts\mp\_trophy_system::func_12804();
	for(;;)
	{
		var_01 = func_D444();
		var_02 = [];
		var_02[0] = level.var_85D5;
		var_02[1] = level.var_B898;
		var_02[2] = level.var_B779;
		var_03 = scripts\common\utility::func_2282(var_02);
		foreach(var_05 in var_03)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(scripts\mp\_utility::func_9FB3(var_05.var_69BA))
			{
				continue;
			}

			if(playertrophy_checkignorelist(var_05))
			{
				continue;
			}

			var_06 = var_05.var_222;
			if(!isdefined(var_06) && isdefined(var_05.var_13C2E) && weaponclass(var_05.var_13C2E) == "grenade")
			{
				var_06 = getmissileowner(var_05);
			}

			if(isdefined(var_06) && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self,var_05.var_222)))
			{
				continue;
			}

			if(distancesquared(var_05.origin,var_01) > scripts\mp\_trophy_system::trophy_modifiedprotectiondistsqr(var_05,65536))
			{
				continue;
			}

			var_07 = function_0287(var_01,var_05.origin,var_00,[self,var_05],0,"physicsquery_closest");
			if(isdefined(var_07) && var_07.size > 0)
			{
				continue;
			}

			thread func_D445(var_05);
			thread func_D441();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 6
func_D445(param_00)
{
	scripts\mp\_missions::func_D991("ch_trait_personal_trophy");
	scripts\mp\killstreaks\_killstreaks::func_83A1();
	param_00 setcandamage(0);
	param_00.var_69BA = 1;
	param_00 method_83AD();
	scripts\mp\_trophy_system::func_12821(param_00);
	scripts\mp\_trophy_system::func_12817(param_00,"player_trophy_system_mp",self);
	var_01 = param_00.origin;
	var_02 = param_00.angles;
	if(scripts\mp\_weapons::func_9EE5(param_00))
	{
		param_00 scripts\mp\_weapons::func_51B5();
	}
	else if(param_00 scripts\mp\_domeshield::isdomeshield())
	{
		param_00 thread scripts\mp\_domeshield::domeshield_delete();
	}
	else
	{
		param_00 delete();
	}

	radiusdamage(var_01,128,70,10,self,"MOD_EXPLOSIVE","player_trophy_system_mp");
	thread playertrophy_protectionfx(var_01,var_02);
}

//Function Number: 7
playertrophy_watchemp()
{
	self endon("death");
	self endon("disconnect");
	self endon("player_trophy_end");
	while(!scripts\mp\killstreaks\_emp_common::isemped())
	{
		scripts\common\utility::func_136F7();
	}

	thread func_D441();
}

//Function Number: 8
playertrophy_watchownerdeath()
{
	self endon("player_trophy_end");
	self waittill("death");
	playfx(scripts\common\utility::getfx("pts_drone_drop"),self gettagorigin("tag_shield_back"));
	thread func_D441();
}

//Function Number: 9
func_D444()
{
	var_00 = scripts\mp\_utility::isinarbitraryup();
	var_01 = scripts\common\utility::func_116D7(var_00,self gettagorigin("tag_shield_back",1,1),self gettagorigin("tag_shield_back"));
	var_02 = scripts\common\utility::func_116D7(var_00,self getworldupreferenceangles(),self.angles);
	return var_01 + anglestoup(var_02) * 20;
}

//Function Number: 10
playertrophy_checkignorelist(param_00)
{
	var_01 = scripts\mp\_trophy_system::trophy_checkignorelist(param_00);
	if(isdefined(param_00.var_13C2E) && issubstr(param_00.var_13C2E,"iw7_tacburst") || issubstr(param_00.var_13C2E,"power_smoke_drone_mp"))
	{
		var_01 = 1;
	}

	if(!var_01 && isdefined(param_00.var_13C2E))
	{
		var_02 = scripts\mp\_utility::func_7E9D(param_00.var_13C2E);
		if(isdefined(var_02) && var_02 != "lethal")
		{
			var_01 = 1;
		}
	}

	if(!var_01 && scripts\mp\_weapons::func_9EE5(param_00))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 11
playertrophy_modifieddamage(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02) || param_02 != "player_trophy_system_mp")
	{
		return param_04;
	}

	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return param_04;
	}

	return scripts\common\utility::func_116D7(param_00 == param_01,0,param_04);
}

//Function Number: 12
playertrophy_protectionfx(param_00,param_01)
{
	self playsound("trophy_detect_projectile");
	playfx(scripts\common\utility::getfx("pts_detonate"),param_00,anglestoforward(param_01),anglestoup(param_01));
	playsoundatpos(param_00,"trophy_fire");
}