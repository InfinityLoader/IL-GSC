/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_domeshield.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1257 ms
 * Timestamp: 10/27/2023 12:15:10 AM
*******************************************************************/

//Function Number: 1
domeshield_init()
{
	level.var_590F = [];
}

//Function Number: 2
func_5910(param_00)
{
	param_00 endon("death");
	param_00 thread domeshield_deleteondisowned(self);
	param_00 waittill("missile_stuck",var_01);
	param_00 method_859F();
	param_00 method_85A0();
	scripts\mp\_utility::func_1302("domeshield_plant_mp",param_00.origin,(0,0,0),100,1,param_00);
	if(isdefined(var_01))
	{
		param_00 linkto(var_01);
	}

	var_02 = domeshield_getplacementinfo(self,param_00.origin);
	if(var_02.var_38EE)
	{
		thread func_590C(param_00,var_01,var_02);
		return;
	}

	scripts\mp\_hud_message::func_10122("MP_CANNOT_PLACE_DOMESHIELD");
	scripts\mp\_powers::func_D74C("power_domeshield");
	param_00 delete();
}

//Function Number: 3
func_590C(param_00,param_01,param_02)
{
	foreach(var_04 in param_02.var_C7FC)
	{
		var_04 domeshield_awardpoints(self);
		var_04 domeshield_givedamagefeedback(self);
		var_04 thread domeshield_destroy(1);
	}

	if(!isdefined(self.var_590F))
	{
		self.var_590F = [];
	}

	if(self.var_590F.size + 1 > domeshield_getmax())
	{
		self.var_590F[0] thread domeshield_destroy(0);
	}

	param_00 method_831F(self);
	param_00 method_8317(1);
	var_06 = spawn("script_model",param_00.origin);
	var_06.angles = param_00.angles;
	var_06 method_831F(self);
	var_06 setmodel("prop_mp_domeshield_col");
	var_06 method_8318(1);
	var_06 method_8317(1);
	var_06 linkto(param_00);
	var_06.var_2B0E = 1;
	var_06.var_222 = self;
	var_06.var_7734 = param_00;
	var_06 thread domeshield_cleanuponparentdeath(param_00);
	param_00.var_58EF = var_06;
	var_07 = scripts\mp\_utility::_hasperk("specialty_rugged_eqp");
	if(var_07)
	{
		param_00.hasruggedeqp = 1;
		var_06.hasruggedeqp = 1;
	}

	var_08 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(var_07),"hitequip","");
	var_09 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(var_07),150,100);
	param_00 thread scripts\mp\_damage::func_B9C6(var_09,var_08,::domeshield_handledamagefatal,::domeshield_handledamage,0);
	var_09 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(var_07),600,450);
	var_06 thread scripts\mp\_damage::func_B9C6(var_09,var_08,::domeshield_domehandledamagefatal,::domeshield_domehandledamage,0);
	param_00 thread domeshield_destroyonemp();
	param_00 thread domeshield_destroyontimeout();
	param_00 thread domeshield_destroyongameend();
	param_00 thread domeshield_deploysequence();
	param_00 thread scripts\mp\perks\_perk_equipmentping::func_E84B(var_06);
	thread scripts\mp\_weapons::func_C798(param_00,self);
	domeshield_addtoarrays(param_00,self);
}

//Function Number: 4
domeshield_deploysequence()
{
	self endon("death");
	domeshield_setstate(1);
	wait(0.5);
	domeshield_setstate(2);
}

//Function Number: 5
domeshield_destroy(param_00)
{
	thread domeshield_delete(1.6);
	if(param_00)
	{
		domeshield_setstate(3);
	}
	else
	{
		domeshield_setstate(4);
	}

	wait(1.5);
	domeshield_setstate(5);
}

//Function Number: 6
domeshield_delete(param_00)
{
	self notify("death");
	self setcandamage(0);
	self.var_69BA = 1;
	thread domeshield_removefromarrays(self,self.var_222,self getentitynumber());
	if(isdefined(self.var_58EF))
	{
		self.var_58EF delete();
	}

	if(isdefined(param_00))
	{
		wait(param_00);
	}

	self delete();
}

//Function Number: 7
domeshield_handledamage(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	scripts\mp\_powers::equipmenthit(self.var_222,param_00,param_01,param_02);
	return var_05;
}

//Function Number: 8
domeshield_handledamagefatal(param_00,param_01,param_02,param_03,param_04)
{
	domeshield_awardpoints(param_00);
	if(isdefined(param_00) && isplayer(param_00) && isdefined(param_02) && scripts\common\utility::func_9D74(param_02) && param_00 != self.var_222)
	{
		param_00 scripts\mp\_missions::func_D991("ch_dome_kill");
	}

	thread domeshield_destroy(1);
}

//Function Number: 9
domeshield_domehandledamage(param_00,param_01,param_02,param_03,param_04)
{
	if(param_02 == "MOD_MELEE")
	{
		param_03 = 0;
	}
	else
	{
		param_03 = scripts\mp\_damage::func_89E2(param_01,param_02,param_03);
		param_03 = scripts\mp\_damage::func_8975(param_01,param_02,param_03);
		param_03 = domeshield_domehandlesuperdamage(param_01,param_02,param_03);
	}

	if(param_03 > 0)
	{
		self.var_222 scripts\mp\_missions::func_D991("ch_tactical_domeshield",param_03);
	}

	self.var_222 scripts\mp\_missions::func_D998(param_00,param_01,self);
	self.var_222 scripts\mp\_damage::combatrecordtacticalstat("power_domeshield",param_03);
	scripts\mp\_powers::equipmenthit(self.var_222,param_00,param_01,param_02);
	return param_03;
}

//Function Number: 10
domeshield_domehandledamagefatal(param_00,param_01,param_02,param_03,param_04)
{
	self.var_7734 thread domeshield_handledamagefatal(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 11
domeshield_domehandlesuperdamage(param_00,param_01,param_02)
{
	var_03 = 1;
	var_04 = getweaponbasename(param_00);
	if(isdefined(var_04))
	{
		param_00 = var_04;
	}

	switch(param_00)
	{
		case "micro_turret_gun_mp":
			var_03 = 3.75;
			break;

		case "iw7_penetrationrail_mp":
			var_03 = 1.75;
			break;

		case "iw7_atomizer_mp":
			var_03 = 1.75;
			break;
	}

	return int(ceil(var_03 * param_02));
}

//Function Number: 12
domeshield_destroyonemp()
{
	self endon("death");
	self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
	if(isdefined(var_03) && var_03 == "emp_grenade_mp")
	{
		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_00)))
		{
			var_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
		}
	}

	domeshield_awardpoints(var_00);
	domeshield_givedamagefeedback(var_00);
	thread domeshield_destroy(1);
}

//Function Number: 13
domeshield_destroyontimeout()
{
	self endon("death");
	wait(8);
	thread domeshield_destroy(1);
}

//Function Number: 14
domeshield_destroyongameend()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread domeshield_destroy(0);
}

//Function Number: 15
domeshield_deleteondisowned(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators","disconnect");
	thread domeshield_removefromarrays(self,self.var_222,self getentitynumber());
	if(isdefined(self.var_58EF))
	{
		self.var_58EF delete();
	}

	self delete();
}

//Function Number: 16
domeshield_getplacementinfo(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_38EE = 1;
	var_02.var_C7FC = [];
	var_03 = param_00.team;
	var_04 = pow(175,2);
	foreach(var_06 in level.var_590F)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		var_07 = length2dsquared(param_01 - var_06.origin);
		if(var_07 < var_04)
		{
			if(isdefined(var_06.var_222) && var_06.var_222 != param_00 && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_06.var_222,param_00)))
			{
				var_02.var_38EE = 0;
				break;
			}

			var_02.var_C7FC[var_02.var_C7FC.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 17
domeshield_setstate(param_00)
{
	if(!isdefined(self.var_10E19))
	{
		self.var_10E19 = -1;
	}

	if(self.var_10E19 == param_00)
	{
		return;
	}

	switch(param_00)
	{
		case 1:
			self.var_10E19 = 1;
			self setscriptablepartstate("plant","active",0);
			break;

		case 2:
			self.var_10E19 = 2;
			self setscriptablepartstate("plant","neutral",0);
			self setscriptablepartstate("armed","active",0);
			break;

		case 4:
			self.var_10E19 = 4;
			self setscriptablepartstate("plant","neutral",0);
			self setscriptablepartstate("armed","neutral",0);
			self setscriptablepartstate("destroy","activeStart",0);
			self setscriptablepartstate("domeDestroy","active",0);
			break;

		case 3:
			self.var_10E19 = 3;
			self setscriptablepartstate("plant","neutral",0);
			self setscriptablepartstate("armed","neutral",0);
			self setscriptablepartstate("destroy","activeStart",0);
			self setscriptablepartstate("domeDestroyDamage","active",0);
			break;

		case 5:
			self.var_10E19 = 3;
			self setscriptablepartstate("destroy","activeEnd",0);
			break;
	}
}

//Function Number: 18
domeshield_givedamagefeedback(param_00)
{
	var_01 = "";
	if(scripts\mp\_utility::func_9FB3(self.hasruggedeqp))
	{
		var_01 = "hitequip";
	}

	if(isplayer(param_00))
	{
		param_00 scripts\mp\_damagefeedback::func_12E84(var_01);
	}
}

//Function Number: 19
domeshield_awardpoints(param_00)
{
	if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
	{
		param_00 notify("destroyed_equipment");
		param_00 thread scripts\mp\_utility::func_83B4("destroyed_equipment");
	}
}

//Function Number: 20
domeshield_getmax()
{
	var_00 = 1;
	if(scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
	{
		var_00++;
	}

	return var_00;
}

//Function Number: 21
func_7E80(param_00)
{
	if(isdefined(level.var_590F))
	{
		var_01 = 14400;
		foreach(var_03 in level.var_590F)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			if(distancesquared(param_00.origin,var_03.origin) < var_01)
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 22
isdomeshield()
{
	return isdefined(level.var_590F[self getentitynumber()]);
}

//Function Number: 23
domeshield_addtoarrays(param_00,param_01)
{
	if(!isdefined(param_01.var_590F))
	{
		param_01.var_590F = [];
	}

	var_02 = [];
	foreach(var_04 in param_01.var_590F)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(var_04 == param_00)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	var_02[var_02.size] = param_00;
	param_01.var_590F = var_02;
	var_06 = param_00 getentitynumber();
	level.var_590F[var_06] = param_00;
	thread domeshield_removefromarraysondeath(param_00);
}

//Function Number: 24
domeshield_removefromarrays(param_00,param_01,param_02)
{
	param_00 notify("domeShield_removeFromArrays");
	if(isdefined(param_01) && isdefined(param_01.var_590F) && isdefined(param_00))
	{
		param_01.var_590F = scripts\common\utility::func_22A9(param_01.var_590F,param_00);
	}

	level.var_590F[param_02] = undefined;
}

//Function Number: 25
domeshield_removefromarraysondeath(param_00)
{
	param_00 notify("domeShield_removeFromArraysOnDeath");
	param_00 endon("domeShield_removeFromArraysOnDeath");
	param_00 endon("domeShield_removeFromArrays");
	var_01 = param_00.var_222;
	var_02 = param_00 getentitynumber();
	param_00 waittill("death");
	thread domeshield_removefromarrays(param_00,var_01,var_02);
}

//Function Number: 26
domeshield_cleanuponparentdeath(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}