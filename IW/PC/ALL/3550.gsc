/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3550.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 17 ms
 * Timestamp: 10/27/2023 12:30:39 AM
*******************************************************************/

//Function Number: 1
func_3CED()
{
	level._effect["chargemode_expl"] = loadfx("vfx/iw7/_requests/mp/super/vfx_chargemode_expl.vfx");
}

//Function Number: 2
func_3D0E()
{
}

//Function Number: 3
func_3D19()
{
	self notify("chargeMode_unset");
	if(self method_84CA())
	{
		func_3CDD();
	}
}

//Function Number: 4
func_3D1A()
{
	self.chargemode_epicimpactents = [];
	scripts\mp\_utility::func_1253(1);
	scripts\common\utility::func_1C6E(0);
	scripts\mp\_utility::func_2BBB("specialty_lightweight");
	scripts\mp\_utility::func_8387("specialty_stun_resistance");
	var_00 = self getcurrentweapon();
	if(issubstr(var_00,"iw7_nunchucks") || issubstr(var_00,"iw7_katana"))
	{
		if(!self.var_AE7F == "iw7_fists" || self.var_AE94 == "iw7_fists")
		{
			scripts\mp\_utility::func_12C6("iw7_fists_mp");
		}

		scripts\mp\_utility::_switchtoweaponimmediate("iw7_fists_mp");
		self.savedbullchargeweapon = var_00;
	}

	func_3CD3();
	thread func_3CF7();
	thread chargemode_monitorkillstreakusage();
	thread chargemode_monitorshield();
	thread chargemode_monitorarmor();
	thread func_3CFA();
	thread func_3D04();
	thread func_3CFB();
	thread func_3D02();
	thread func_3CF9();
	if(!scripts\mp\_utility::func_9D46())
	{
		thread scripts\mp\_supers::watchobjuse(125);
	}

	return 1;
}

//Function Number: 5
func_3CDD(param_00)
{
	self notify("chargeMode_end");
	self notify("obj_drain_end");
	if(self method_84CA())
	{
		self method_84CB();
	}

	self setscriptablepartstate("chargeModeMove","neutral",0);
	var_01 = self.var_3D11;
	self.var_3D11 = undefined;
	self.var_3D10 = undefined;
	self.var_3CEA = undefined;
	self.var_3CEC = undefined;
	self.var_3CEB = undefined;
	self.chargemode_epicimpactents = undefined;
	if(!scripts\mp\_utility::func_9FB3(param_00))
	{
		self setscriptablepartstate("chargeMode","activeEnd",0);
		scripts\mp\_utility::func_1253(0);
		scripts\common\utility::func_1C6E(1);
		scripts\mp\_utility::func_12B83("specialty_lightweight");
		scripts\mp\_utility::func_E150("specialty_stun_resistance");
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03))
				{
					var_03 delete();
				}
			}
		}

		func_3CD7();
		if(isdefined(self.savedbullchargeweapon))
		{
			if(!self.var_AE7F == "iw7_fists" || self.var_AE94 == "iw7_fists")
			{
				scripts\mp\_utility::func_141E("iw7_fists_mp");
			}

			scripts\mp\_utility::_switchtoweaponimmediate(self.savedbullchargeweapon);
			self.savedbullchargeweapon = undefined;
			return;
		}

		return;
	}

	self setscriptablepartstate("chargeMode","neutral",0);
}

//Function Number: 6
func_3CFB()
{
	self endon("death");
	self endon("disconnect");
	self endon("chargemode_end");
	var_00 = cos(30);
	for(;;)
	{
		self waittill("collided",var_01,var_02,var_03,var_04,var_05);
		if(!chargemode_validdatapoint(var_02,var_03))
		{
			continue;
		}

		var_06 = anglestoup(self.angles);
		var_07 = anglestoforward(self.angles);
		var_08 = var_02 - self.origin;
		var_09 = vectornormalize(var_08 - var_06 * vectordot(var_06,var_08));
		var_0A = vectordot(var_01,var_09);
		if(var_0A < 85)
		{
			continue;
		}

		if(vectordot(var_07,var_09) <= var_00)
		{
			continue;
		}

		self.chargemode_lastimpacttime = gettime();
	}
}

//Function Number: 7
chargemode_validdatapoint(param_00,param_01)
{
	var_02 = anglestoup(self.angles);
	var_03 = var_02 * -1;
	var_04 = self gettagorigin("j_helmet");
	var_05 = var_04 - param_00;
	var_06 = vectordot(var_05,var_02);
	if(var_06 >= 0 && var_06 <= 6)
	{
		if(acos(vectordot(param_01,var_03) <= 45))
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	var_07 = self gettagorigin("tag_origin");
	var_08 = var_07 - param_00;
	var_09 = vectordot(var_08,var_03);
	if(var_09 >= 0 || var_06 <= 6)
	{
		if(acos(vectordot(param_01,var_02) <= 45))
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	return 1;
}

//Function Number: 8
func_3CFD(param_00)
{
	var_01 = param_00 getentitynumber();
	self endon("death");
	self endon("disconnect");
	self endon("chargeMode_monitorKnockbackEnded_" + var_01);
	scripts\mp\_utility::func_1253(1);
	if(scripts\mp\_utility::func_9FB3(level.tactical))
	{
		scripts\common\utility::func_1C42(0);
	}

	thread func_3CFE(param_00);
	for(;;)
	{
		self waittill("collided",var_02,var_03,var_04,var_05,var_06);
		if(var_06 != "hittype_world")
		{
			continue;
		}

		var_02 = (var_02[0],var_02[1],max(0,var_02[2]));
		var_07 = -1 * vectordot(var_02,var_04);
		if(var_07 < 450)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			self dodamage(135,var_03,param_00,undefined,"MOD_EXPLOSIVE","chargemode_mp");
		}

		break;
	}

	if(!level.tactical)
	{
		scripts\common\utility::func_1C42(1);
	}

	scripts\mp\_utility::func_1253(0);
	self notify("chargeMode_monitorKnockbackEnded_" + var_01);
}

//Function Number: 9
func_3CFE(param_00)
{
	var_01 = param_00 getentitynumber();
	self endon("death");
	self endon("disconnect");
	self endon("chargeMode_monitorKnockbackEnded_" + var_01);
	wait(0.35);
	if(!level.tactical)
	{
		scripts\common\utility::func_1C42(1);
	}

	scripts\mp\_utility::func_1253(0);
	self notify("chargeMode_monitorKnockbackEnded_" + var_01);
}

//Function Number: 10
func_3CF7()
{
	self endon("death");
	self endon("disconnect");
	self endon("chargeMode_end");
	self waittill("bullChargeEnd",var_00,var_01);
	if(scripts\mp\_utility::func_9FB3(var_01) || var_00 && func_3CDF())
	{
		thread func_3CE9();
	}

	scripts\mp\_supers::func_DE3B(9999);
}

//Function Number: 11
chargemode_monitorkillstreakusage()
{
	self endon("death");
	self endon("disconnect");
	self endon("chargeMode_end");
	for(;;)
	{
		if(isdefined(self.var_13111))
		{
			waittillframeend;
			self notify("bullChargeEnd",0,0,1);
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
chargemode_monitorshield()
{
	self endon("death");
	self endon("disconnect");
	self endon("chargeMode_end");
	for(;;)
	{
		if(!self method_853E())
		{
			waittillframeend;
			self notify("bullChargeEnd",0,0,1);
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
chargemode_monitorarmor()
{
	self endon("death");
	self endon("disconnect");
	chargemode_monitorarmorendearly();
	if(isdefined(self) && scripts\mp\_utility::func_9F19(self))
	{
		scripts\mp\_lightarmor::func_F786(self,0,1,0);
	}
}

//Function Number: 14
chargemode_monitorarmorendearly()
{
	self endon("chargeMode_end");
	var_00 = gettime();
	var_01 = var_00 + 3000;
	for(;;)
	{
		if(gettime() > var_01)
		{
			return;
		}

		if(!isdefined(self.var_2777) && !scripts\mp\_utility::func_9FB3(self.var_10902))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	scripts\mp\_lightarmor::func_F786(self,19,1,0);
	var_02 = int(ceil(0.95));
	scripts\common\utility::func_136F7();
	for(;;)
	{
		if(gettime() > var_01)
		{
			return;
		}

		var_03 = scripts\mp\_lightarmor::func_7F73(self);
		scripts\mp\_lightarmor::func_F786(self,var_03 + var_02,1,0);
		scripts\common\utility::func_136F7();
	}

	self waittill("forever");
}

//Function Number: 15
func_3D02()
{
	self endon("death");
	self endon("disconnect");
	self endon("chargeMode_end");
	self.var_3D11 = [];
	for(;;)
	{
		self waittill("shield_hit",var_00);
		self.var_3D11[self.var_3D11.size] = var_00;
	}
}

//Function Number: 16
func_3CFA()
{
	self endon("disconnect");
	self endon("chargemode_unset");
	self endon("gracePeriodRaceEnd");
	var_00 = spawnstruct();
	childthread func_3CE2(var_00);
	childthread func_3CE4(var_00);
	childthread func_3CE3(var_00);
	childthread func_3CE5(var_00);
	self waittill("gracePeriodRaceBegin");
	waittillframeend;
	if(!scripts\mp\_utility::func_9FB3(var_00.var_8462))
	{
		if(scripts\mp\_utility::func_9FB3(var_00.var_E6) || scripts\mp\_utility::func_9FB3(var_00.var_6ABF))
		{
			scripts\mp\_supers::func_DE7D();
		}
		else
		{
			var_01 = getsubstr(self.var_AE62,10,self.var_AE62.size);
			scripts\mp\_missions::func_D991("ch_" + var_01 + "_super");
			scripts\mp\_supers::combatrecordsuperuse("super_chargemode");
		}
	}
	else
	{
		var_01 = getsubstr(self.var_AE62,10,self.var_AE62.size);
		scripts\mp\_missions::func_D991("ch_" + var_01 + "_super");
		scripts\mp\_supers::combatrecordsuperuse("super_chargemode");
	}

	self notify("gracePeriodRaceEnd");
}

//Function Number: 17
func_3CE2(param_00)
{
	self waittill("death");
	param_00.var_E6 = 1;
	self notify("gracePeriodRaceBegin");
}

//Function Number: 18
func_3CE4(param_00)
{
	for(;;)
	{
		self waittill("got_a_kill",var_01,var_02,var_03);
		if(var_02 == "chargemode_mp")
		{
			break;
		}
	}

	param_00.var_8462 = 1;
	self notify("gracePeriodRaceBegin");
}

//Function Number: 19
func_3CE3(param_00)
{
	self waittill("bullChargeEnd",var_01,var_02,var_03);
	if(scripts\mp\_utility::func_9FB3(var_03))
	{
		param_00.var_6ABF = 1;
	}
	else if(var_01 && !func_3CDF())
	{
		param_00.var_6ABF = 1;
	}

	self notify("gracePeriodRaceBegin");
}

//Function Number: 20
func_3CE5(param_00)
{
	wait(1);
	param_00.var_11901 = 1;
	self notify("gracePeriodRaceBegin");
}

//Function Number: 21
func_3D04()
{
	self endon("disconnect");
	self endon("chargeMode_end");
	self endon("chargeMode_unset");
	var_00 = spawn("trigger_rotatable_radius",self.origin,0,30,72);
	var_00 enablelinkto();
	var_00 endon("death");
	childthread func_3D07(var_00);
	childthread func_3D06(var_00);
	childthread chargemode_monitortriggerinteractionmanual(var_00);
	thread func_3D05(var_00);
}

//Function Number: 22
func_3D07(param_00)
{
	for(;;)
	{
		if(func_3D0C())
		{
			var_01 = self getvelocity();
			var_02 = vectortoangles(var_01);
			var_03 = anglestoforward(var_02);
			var_04 = anglestoup(var_02);
			var_05 = self.origin + anglestoup(self.angles) * 36;
			var_06 = var_05 + var_03 * 40;
			var_07 = scripts\common\trace::func_48BC(0,1,1,0,1,0);
			var_08 = function_0287(var_05,var_06,var_07,undefined,0,"physicsquery_closest");
			if(isdefined(var_08) && var_08.size > 0)
			{
				var_06 = var_08[0]["position"];
			}

			param_00 unlink();
			param_00 dontinterpolate();
			param_00.origin = var_06 - var_04 * 36;
			param_00.angles = var_02;
			param_00 linkto(self);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 23
func_3D06(param_00)
{
	param_00.var_11AD2 = [];
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(param_00.var_11AD2[var_01 getentitynumber()]))
		{
			continue;
		}

		if(!lib_0DF8::func_213D(var_01,self))
		{
			continue;
		}

		if(var_01 == self)
		{
			continue;
		}

		var_02 = scripts\common\utility::func_116D7(isdefined(var_01.var_222),var_01.var_222,var_01);
		if(!level.var_740A && var_02 != self && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_02,self)))
		{
			continue;
		}

		if(vectordot(var_01.origin - self.origin,anglestoforward(self.angles)) <= 0)
		{
			continue;
		}

		if(!isplayer(var_01) && !scripts\mp\_utility::func_9F22(var_01))
		{
			continue;
		}

		func_3D18(param_00,var_01);
	}
}

//Function Number: 24
func_3D18(param_00,param_01)
{
	if(!scripts\mp\_utility::func_9F19(param_01))
	{
		return;
	}

	if(isplayer(param_01))
	{
		if(param_01 method_8569())
		{
			return;
		}

		if(param_01 method_8568())
		{
			return;
		}
	}

	var_02 = scripts\common\trace::func_48BC(0,1,1,0,1,0);
	var_03 = function_0287(self geteye(),param_01 geteye(),var_02,undefined,0,"physicsquery_closest");
	if(isdefined(var_03) && var_03.size > 0)
	{
		return;
	}

	var_04 = self getvelocity();
	var_05 = vectortoangles(var_04);
	var_06 = anglestoforward(var_05);
	if(scripts\mp\_utility::func_9F22(param_01))
	{
		var_07 = vectornormalize(param_01.origin - self.origin * (1,1,0));
		var_08 = vectornormalize(var_06 * (1,1,0));
		var_09 = scripts\common\utility::func_1E7E(var_07,var_08);
		thread func_3D14(param_00,param_01);
		if(!func_3CE7(param_01))
		{
			func_3CD5(param_01);
		}

		if(var_09 <= 25)
		{
			func_3CE0();
			return;
		}

		return;
	}

	thread func_3D14(param_00,param_01);
	thread scripts\mp\_gamescore::func_11ACF(self,param_01,"chargemode_mp",5);
	if(!chargemode_isqueuedforepicimpact(param_01))
	{
		if(param_01 method_84CA() && func_3CE8(param_01))
		{
			if(param_01 func_3CE8(self))
			{
				thread chargemode_queueforepicimpact(param_01);
				param_01 thread chargemode_queueforepicimpact(self);
				return;
			}

			func_3CF5(param_01,var_06);
			return;
		}

		func_3CF5(param_01,var_06);
		func_3CD5(param_01);
		return;
	}
}

//Function Number: 25
chargemode_isqueuedforepicimpact(param_00)
{
	if(!isdefined(self.chargemode_epicimpactents))
	{
		return 0;
	}

	return isdefined(self.chargemode_epicimpactents[param_00 getentitynumber()]);
}

//Function Number: 26
chargemode_queueforepicimpact(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("chargeMode_queueEpicImpact");
	self endon("chargeMode_queueEpicImpact");
	self.chargemode_epicimpactents[param_00 getentitynumber()] = param_00;
	waittillframeend;
	func_3CE0();
}

//Function Number: 27
func_3D05(param_00)
{
	param_00 endon("death");
	scripts\common\utility::waittill_any_3("death","disconnect","chargeMode_end","chargeMode_unset");
	param_00 delete();
}

//Function Number: 28
chargemode_monitortriggerinteractionmanual(param_00)
{
	var_01 = 36;
	var_02 = 4096;
	var_03 = scripts\common\trace::func_48BC(0,1,1,0,1,1);
	for(;;)
	{
		var_04 = param_00.origin + anglestoup(param_00.angles) * var_01;
		var_05 = chargemode_gettriggermanualents();
		foreach(var_07 in var_05)
		{
			if(isdefined(param_00.var_11AD2[var_07 getentitynumber()]))
			{
				continue;
			}

			if(!lib_0DF8::func_213D(var_07,self))
			{
				continue;
			}

			var_08 = scripts\common\utility::func_116D7(isdefined(var_07.var_222),var_07.var_222,var_07);
			if(!level.var_740A && var_08 != self && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_08,self)))
			{
				continue;
			}

			var_09 = var_07.origin - self.origin;
			if(vectordot(var_09,anglestoforward(self.angles)) <= 0)
			{
				continue;
			}

			var_0A = var_07.origin - var_04;
			if(lengthsquared(var_0A) > var_02)
			{
				continue;
			}

			var_0B = function_0287(var_04,var_07.origin,var_03,[var_07],0,"physicsquery_closest",1);
			if(isdefined(var_0B) && var_0B.size > 0)
			{
				continue;
			}

			if(var_07 lib_0DE6::isexplodingdrone())
			{
				var_07 lib_0DE6::explodingdrone_makedamageimmune(self);
			}
			else if(var_07 scripts\mp\killstreaks\_venom::isvenom())
			{
				var_07 scripts\mp\killstreaks\_venom::makedamageimmune(self);
			}

			thread func_3D14(param_00,var_07);
			func_3CD5(var_07);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 29
func_3CD5(param_00)
{
	var_01 = 140;
	var_02 = param_00.var_110EA;
	if(isdefined(var_02))
	{
		switch(var_02)
		{
			case "remote_c8":
				var_01 = int(ceil(param_00.maxhealth / 4));
				break;

			case "ball_drone_backup":
				var_01 = int(ceil(param_00.maxhealth / 1));
				break;

			case "minijackal":
				var_01 = int(ceil(param_00.maxhealth / 4));
				break;

			case "dronedrop":
				var_01 = int(ceil(param_00.maxhealth / 1));
				break;

			case "sentry_shock":
				var_01 = int(ceil(param_00.maxhealth / 2));
				break;
		}
	}
	else
	{
		var_03 = param_00.var_13C2E;
		if(isdefined(var_03))
		{
			switch(var_03)
			{
				case "super_trophy_mp":
					var_01 = int(ceil(param_00.maxhealth / 2));
					break;

				case "micro_turret_mp":
					var_01 = int(ceil(param_00.maxhealth / 1));
					break;
			}
		}
	}

	param_00 dodamage(var_01,self.origin,self,self,"MOD_EXPLOSIVE","chargemode_mp");
	thread func_3CD6();
}

//Function Number: 30
func_3CF5(param_00,param_01)
{
	var_02 = param_00.origin - self.origin;
	var_03 = length(var_02);
	if(var_03 != 0)
	{
		var_04 = var_02 / var_03;
		var_05 = param_00 getvelocity();
		var_05 = var_05 - var_04 * vectordot(var_05,var_04);
		var_05 = var_05 + var_04 * 750;
		var_05 = var_05 + (0,0,250);
		var_06 = clamp(var_05[2],100,500);
		var_05 = (var_05[0],var_05[1],var_06);
		param_00 method_84DC(var_05,length(var_05));
		param_00 shellshock("chargemode_mp",0.85);
	}
}

//Function Number: 31
func_3CE9()
{
	thread chargemode_monitordestructibleimpactimmunity();
	self radiusdamage(self.origin,256,140,70,self,"MOD_EXPLOSIVE","chargemode_mp");
	scripts\mp\_shellshock::func_858B(self.origin);
	playfx(scripts\common\utility::getfx("chargemode_expl"),self.origin);
	self playsound("heavy_charge_impact_wall");
	self setclientomnvar("ui_hud_shake",1);
}

//Function Number: 32
func_3CD3()
{
	self attachshieldmodel("weapon_retract_shield_wm_mp","tag_weapon_left");
	self.var_3D10 = 1;
}

//Function Number: 33
func_3CD7()
{
	self detachshieldmodel("weapon_retract_shield_wm_mp","tag_weapon_left");
	self.var_3D10 = 0;
}

//Function Number: 34
func_3D14(param_00,param_01)
{
	param_00 endon("death");
	var_02 = param_01 getentitynumber();
	param_00.var_11AD2[var_02] = param_01;
	func_3D15(param_00,param_01);
	param_00.var_11AD2[var_02] = undefined;
}

//Function Number: 35
func_3D15(param_00,param_01)
{
	self endon("disconnect");
	self endon("chargeMode_end");
	param_01 endon("death");
	param_01 endon("disconnect");
	wait(0.2);
}

//Function Number: 36
func_3CEE(param_00)
{
	return param_00 method_84CA();
}

//Function Number: 37
func_3D0C()
{
	var_00 = self getvelocity();
	var_00 = (var_00[0],var_00[1],0);
	var_01 = lengthsquared(var_00);
	return var_01 >= -10311 && vectordot(var_00,anglestoforward(self.angles)) > 0 && !self method_8499();
}

//Function Number: 38
func_3CDF()
{
	var_00 = self.chargemode_lastimpacttime;
	if(isdefined(var_00) && gettime() - var_00 <= 50)
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
func_3CE0()
{
	self notify("bullChargeEnd",1,1);
}

//Function Number: 40
func_3CE8(param_00)
{
	var_01 = self.origin * (1,1,0);
	var_02 = param_00.origin * (1,1,0);
	if(var_01 == var_02)
	{
		return 0;
	}

	var_03 = var_01 - var_02;
	var_04 = anglestoforward(param_00.angles);
	var_05 = scripts\common\utility::func_1E7C(var_03,var_04);
	if(var_05 < 30)
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
func_3CE7(param_00)
{
	var_01 = self.origin * (1,1,0);
	var_02 = param_00.origin * (1,1,0);
	if(var_01 == var_02)
	{
		return 0;
	}

	var_03 = var_01 - var_02;
	var_04 = anglestoforward(param_00.angles);
	var_05 = anglestoright(param_00.angles);
	var_06 = scripts\common\utility::func_1E7C(var_03,var_04);
	if(vectordot(var_05,var_03) < 0)
	{
		var_06 = var_06 * -1;
	}

	if(param_00 method_853E())
	{
		if(var_06 >= -45 && var_06 <= 30)
		{
			return 1;
		}
	}
	else if(var_06 >= -75 && var_06 <= 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
chargemode_gettriggermanualents()
{
	var_00 = [];
	if(isdefined(level.var_12A83))
	{
		var_00[var_00.size] = level.var_12A83;
	}

	if(isdefined(level.var_AD8B))
	{
		var_00[var_00.size] = level.var_AD8B;
	}

	if(isdefined(level.var_105EA))
	{
		var_00[var_00.size] = level.var_105EA;
	}

	if(isdefined(level.var_27EF))
	{
		var_00[var_00.size] = level.var_27EF;
	}

	if(isdefined(level.var_11267) && isdefined(level.var_11267.var_12801))
	{
		var_00[var_00.size] = level.var_11267.var_12801;
	}

	if(isdefined(level.var_69D6))
	{
		var_00[var_00.size] = level.var_69D6;
	}

	return scripts\common\utility::func_2282(var_00);
}

//Function Number: 43
chargemode_modifieddamage(param_00,param_01,param_02,param_03,param_04)
{
	if(chargemode_isdamageimmune(param_00,param_01,param_02,param_03))
	{
		param_04 = 0;
	}

	return param_04;
}

//Function Number: 44
chargemode_isdamageimmune(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(!var_04)
	{
		var_04 = var_04 || chargemode_isdamageimmuneepicimpact(param_00,param_01,param_02);
	}

	if(!var_04)
	{
		var_04 = var_04 || chargemode_isdamageimmunedestructibleimpact(param_00,param_01,param_02,param_03);
	}

	return var_04;
}

//Function Number: 45
chargemode_isdamageimmuneepicimpact(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	if(param_02 != "chargemode_mp")
	{
		return 0;
	}

	if(!isdefined(param_00.chargemode_epicimpactents))
	{
		return 0;
	}

	return isdefined(param_00.chargemode_epicimpactents[param_01 getentitynumber()]);
}

//Function Number: 46
chargemode_isdamageimmunedestructibleimpact(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 != param_01)
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9FB3(param_01.chargemode_destructibleimpactimmune))
	{
		return 0;
	}

	if(!scripts\common\utility::string_starts_with(param_02,"destructible"))
	{
		return 0;
	}

	var_04 = anglestoforward(param_01.angles);
	var_05 = vectornormalize(param_03 - param_01.origin);
	return scripts\common\utility::func_1E7E(var_04,var_05) <= 65;
}

//Function Number: 47
chargemode_monitordestructibleimpactimmunity()
{
	self endon("disconnect");
	self.chargemode_destructibleimpactimmune = 1;
	wait(0.1);
	self.chargemode_destructibleimpactimmune = undefined;
}

//Function Number: 48
func_3CD6()
{
	if(isdefined(self.chargemode_damagefxtime) && self.chargemode_damagefxtime == gettime())
	{
		return;
	}

	self.chargemode_damagefxtime = gettime();
	if(!isdefined(self.chargemode_damagefxindex))
	{
		self.chargemode_damagefxindex = 1;
	}

	var_00 = "active" + self.chargemode_damagefxindex;
	self setclientomnvar("ui_hud_shake",1);
	self setscriptablepartstate("chargeModeImpact",var_00,0);
	self.chargemode_damagefxindex = 1 + scripts\common\utility::func_B8F8(self.chargemode_damagefxindex,3);
}

//Function Number: 49
func_3CF9()
{
	self endon("death");
	self endon("disconnect");
	self endon("chargemode_end");
	var_00 = 0;
	var_01 = undefined;
	self setscriptablepartstate("chargeMode","active",0);
	for(;;)
	{
		var_01 = func_3D0C();
		if(var_01 != var_00)
		{
			if(var_01)
			{
				self setscriptablepartstate("chargeModeMove","active",0);
			}
			else
			{
				self setscriptablepartstate("chargeModeMove","neutral",0);
			}
		}

		var_00 = var_01;
		wait(0.1);
	}
}