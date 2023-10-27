/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_splashgrenade.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 841 ms
 * Timestamp: 10/27/2023 12:21:40 AM
*******************************************************************/

//Function Number: 1
func_10A34()
{
	level._effect["base_plasma_smoke"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_smoke");
	scripts\mp\_powerloot::func_DF06("power_splashGrenade",["passive_smoke","passive_increased_duration","passive_increased_spread","passive_increased_radius","passive_increased_entities"]);
}

//Function Number: 2
func_10A35(param_00)
{
	param_00.var_85D5 = [];
	var_01 = scripts\mp\_powerloot::func_7FC2("power_splashGrenade",6);
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = scripts\mp\_utility::func_1302("globproj_mp",(0,0,0),(0,0,0));
		var_03.var_222 = self;
		var_03.team = self.team;
		var_03.var_13C2E = "globproj_mp";
		var_03.parentinflictor = param_00 getentitynumber();
		var_03 linkto(param_00,"",(0,0,0),(0,0,0));
		var_03 hide(1);
		param_00.var_85D5[param_00.var_85D5.size] = var_03;
		var_03 thread func_85B4();
	}

	thread func_85CE(param_00);
	thread func_85CD(param_00);
	param_00 thread func_85B4();
}

//Function Number: 3
func_85CD(param_00,param_01)
{
	param_00 notify("grenadeOnExplode");
	param_00 endon("grenadeOnExplode");
	param_00 thread scripts\mp\_utility::func_C15A("death","end_explode");
	param_00 endon("end_explode");
	var_02 = param_00.var_222;
	var_03 = param_00.var_85D5;
	var_04 = param_00.var_D719;
	param_00 waittill("explode",var_05);
	if(!isdefined(var_02))
	{
		return;
	}

	func_85B9(var_05,param_01,var_03,var_04);
}

//Function Number: 4
func_85CE(param_00)
{
	param_00 endon("death");
	param_00 waittill("missile_stuck",var_01);
	param_00 setscriptablepartstate("beacon","active",0);
	if(isdefined(var_01) && isplayer(var_01))
	{
		scripts\mp\_weapons::func_85DD(param_00,var_01);
		foreach(var_03 in param_00.var_85D5)
		{
			var_03.var_9F7D = param_00.var_9F7D;
		}

		thread scripts\mp\_missions::func_D3A8(var_01,self);
		return;
	}

	thread func_85CD(param_00,param_00.angles);
}

//Function Number: 5
func_85B9(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = 0;
	var_06 = undefined;
	if(isdefined(param_01))
	{
		var_06 = anglestoup(param_01);
		var_07 = vectordot(var_06,(0,0,1));
		var_08 = acos(var_07);
		var_04 = var_08 >= 45;
		var_05 = var_08 >= 145;
	}

	var_09 = undefined;
	var_0A = [];
	if(level.teambased)
	{
		var_09 = scripts\mp\_utility::func_81A0(scripts\mp\_utility::getotherteam(self.team));
	}
	else
	{
		var_09 = level.var_3CB5;
	}

	var_0B = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_missileclip","physicscontents_clipshot"]);
	foreach(var_0D in var_09)
	{
		if(!isdefined(var_0D) || var_0D == self || !scripts\mp\_utility::func_9F19(var_0D))
		{
			continue;
		}

		var_0E = distancesquared(param_00,var_0D.origin);
		if(var_0E > 13225 || var_0E < 7225)
		{
			continue;
		}

		var_0F = function_0287(param_00,var_0D.origin,var_0B,undefined,0,"physicsquery_closest");
		if(!isdefined(var_0F) || var_0F.size > 0)
		{
			continue;
		}

		var_0A[var_0A.size] = var_0D;
	}

	if(var_0A.size > 0)
	{
		var_0A = scripts\common\utility::array_randomize(var_0A);
	}

	var_11 = 0;
	var_12 = 0;
	var_13 = scripts\mp\_powerloot::func_7FC1("power_splashGrenade",1.5);
	var_14 = (0,0,0);
	var_15 = (0,0,0);
	if(var_04 || var_05)
	{
		var_14 = var_06 * 115;
		var_15 = var_06 * 3;
	}

	var_16 = randomint(46);
	var_17 = 0;
	for(var_18 = 0;var_18 < param_02.size;var_18++)
	{
		var_19 = undefined;
		var_1A = randomint(2);
		if(var_1A && var_11 < var_0A.size)
		{
			var_1B = var_0A[var_11].origin - param_00;
			var_1B = (var_1B[0],var_1B[1],0);
			var_11++;
		}
		else if(var_17 < 6)
		{
			var_1C = var_16 + 72 * var_17;
			var_1D = 85 + randomint(31);
			if(var_17 == 5)
			{
				var_1D = 0;
			}

			var_1B = (cos(var_1C),sin(var_1C),0) * var_1D + var_14;
			var_17++;
		}
		else
		{
			var_1E = randomint(360);
			var_1F = 85 + randomint(31);
			var_1B = (cos(var_1E),sin(var_1E),0) * var_1F + var_14;
		}

		if(!var_05)
		{
			var_1B = var_1B + (0,0,200 + randomint(200));
		}

		var_1B = scripts\mp\_powerloot::func_7FC7("power_splashGrenade",var_1B);
		var_20 = param_00 + var_15;
		var_21 = param_02[var_18];
		var_21 show();
		var_21 unlink(1);
		var_21 = scripts\mp\_utility::func_1302("globproj_mp",var_20,var_1B,undefined,undefined,var_21);
		var_21.var_222 = self;
		var_21.team = self.team;
		var_21.var_13C2E = "globproj_mp";
		if(var_18 == 0)
		{
			var_21 setscriptablepartstate("explosionLarge","active");
		}

		var_21 setscriptablepartstate("trail","active");
		thread func_B79A(var_21,var_13);
	}
}

//Function Number: 6
func_B79A(param_00,param_01)
{
	param_00 endon("death");
	param_00 waittill("missile_stuck",var_02);
	var_03 = 3 + randomfloat(0.15);
	param_00 thread func_85B4(param_01 + var_03);
	param_00 setscriptablepartstate("trail","neutral");
	param_00 setscriptablepartstate("explosion","active");
	var_04 = scripts\mp\_powerloot::func_7FC4("power_splashGrenade",60);
	var_05 = spawn("trigger_rotatable_radius",param_00.origin,0,var_04,60);
	var_05.angles = param_00.angles;
	var_05.var_222 = self;
	var_05 enablelinkto();
	var_05 linkto(param_00);
	var_05 hide();
	var_05.var_B799 = param_00;
	var_05 thread func_13B91();
	var_06 = vectordot(anglestoup(var_05.angles),(0,0,1));
	if(var_06 <= 0)
	{
		param_00.var_D654 = "poolWall";
		param_00 setscriptablepartstate("poolWall","active");
	}
	else
	{
		param_00.var_D654 = "poolGround";
		param_00 setscriptablepartstate("poolGround","active");
	}

	wait(param_01);
	param_00 notify("extinguish");
	param_00 setscriptablepartstate(param_00.var_D654,"activeEnd",0);
}

//Function Number: 7
func_85B4(param_00)
{
	self endon("death");
	self notify("grenadeCleanup");
	self endon("grenadeCleanup");
	if(isdefined(param_00))
	{
		self.var_222 scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_00,"disconnect");
	}
	else
	{
		self.var_222 waittill("disconnect");
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 8
func_B24D(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self getentitynumber();
	self notify("mainScriptableCleanup" + var_03);
	self endon("mainScriptableCleanup" + var_03);
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		param_00 waittill("death");
	}

	if(isdefined(param_02))
	{
		wait(param_02);
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 9
func_13B91()
{
	self endon("death");
	self.var_222 endon("disconnect");
	var_00 = self.var_222;
	var_01 = var_00.team;
	if(!isdefined(self.var_127C0))
	{
		self.var_127C0 = [];
	}

	thread func_13B93();
	thread func_127B9();
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02) && !scripts\mp\_utility::func_9F22(var_02))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_02))
		{
			continue;
		}

		var_03 = scripts\common\utility::func_116D7(isdefined(var_02.var_222),var_02.var_222,var_02);
		if(!level.var_740A && var_03 != var_00 && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_03,var_00)))
		{
			continue;
		}

		thread scripts\mp\_missions::func_D3A8(var_02,var_00);
		self.var_127C0[var_02 getentitynumber()] = var_02;
		var_02 func_17B0(self.var_B799);
	}
}

//Function Number: 10
func_13B93()
{
	self endon("death");
	self.var_222 endon("disconnect");
	for(;;)
	{
		foreach(var_02, var_01 in self.var_127C0)
		{
			if(!isdefined(var_01))
			{
				self.var_127C0[var_02] = undefined;
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_01) || !var_01 istouching(self))
			{
				self.var_127C0[var_02] = undefined;
				var_01 thread func_E0DC(self.var_B799);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 11
func_127B9()
{
	self endon("death");
	self.var_B799 endon("death");
	self.var_B799 waittill("extinguish");
	foreach(var_01 in self.var_127C0)
	{
		if(isdefined(var_01))
		{
			var_01 thread func_E0DC(self.var_B799);
		}
	}

	self delete();
}

//Function Number: 12
func_D51E(param_00,param_01)
{
	var_02 = spawnfx(scripts\common\utility::getfx("base_plasma_smoke"),param_00);
	triggerfx(var_02);
	wait(param_01);
	var_02 delete();
}

//Function Number: 13
func_10D77()
{
	if(isplayer(self))
	{
		self setscriptablepartstate("burning","active",0);
	}

	thread func_139C0();
}

//Function Number: 14
func_6312()
{
	self notify("endBurning");
	self.var_3291 = undefined;
	if(isplayer(self))
	{
		self setscriptablepartstate("burning","neutral",0);
	}
}

//Function Number: 15
func_139C0()
{
	self endon("death");
	self endon("disconnect");
	self endon("endBurning");
	thread func_40E8();
	var_00 = self.var_3291;
	var_01 = 0;
	for(;;)
	{
		if(func_9D76())
		{
			var_00.var_32A1 = var_00.var_32A1 + 0.05;
			var_00.var_32A0 = 0;
			if(var_01 <= 0 && var_00.var_32A4.size > 0)
			{
				var_02 = var_00.var_32A4[0];
				var_03 = var_02.var_222;
				var_04 = var_02.var_13C2E;
				var_05 = func_7E11();
				self dodamage(var_05,var_02.origin,var_03,var_02,"MOD_EXPLOSIVE",var_04);
				var_01 = 0.25;
			}
			else
			{
				var_01 = var_01 - 0.05;
			}
		}
		else
		{
			var_00.var_32A0 = var_00.var_32A0 + 0.05;
			if(var_00.var_32A0 > 0.25)
			{
				thread func_6312();
			}
		}

		wait(0.05);
	}
}

//Function Number: 16
func_40E8()
{
	self endon("endBurning");
	self endon("disconnect");
	self waittill("death");
	thread func_6312();
}

//Function Number: 17
func_17B0(param_00)
{
	var_01 = self.var_3291;
	if(!isdefined(var_01))
	{
		var_01 = spawnstruct();
		var_01.var_32A4 = [];
		var_01.var_32A1 = 0;
		var_01.var_32A0 = 0;
		self.var_3291 = var_01;
	}

	var_02 = var_01.var_32A4.size;
	if(!func_8BD9(param_00))
	{
		var_01.var_32A4[var_02] = param_00;
	}

	if(var_02 == 0)
	{
		func_10D77();
	}
}

//Function Number: 18
func_E0DC(param_00)
{
	if(isdefined(self.var_3291))
	{
		var_01 = self.var_3291;
		var_02 = [];
		for(var_03 = 0;var_03 > var_01.var_32A4.size;var_03++)
		{
			var_04 = var_01.var_32A4[var_03];
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

		if(var_02.size > 0)
		{
			var_01.var_32A4 = var_02;
			return;
		}

		func_6312();
	}
}

//Function Number: 19
func_8BD9(param_00)
{
	if(isdefined(self.var_3291))
	{
		var_01 = self.var_3291;
		foreach(var_03 in var_01.var_32A4)
		{
			if(var_03 == param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 20
func_9D76()
{
	return isdefined(self.var_3291) && isdefined(self.var_3291.var_32A4) && self.var_3291.var_32A4.size > 0;
}

//Function Number: 21
func_7E11()
{
	var_00 = self.var_3291.var_32A1;
	var_01 = undefined;
	if(var_00 > 1)
	{
		var_01 = 25;
	}
	else if(var_00 > 0.5)
	{
		var_01 = 25;
	}
	else
	{
		var_01 = 25;
	}

	return var_01;
}