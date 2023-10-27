/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\karatemaster\karatemaster_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1707 ms
 * Timestamp: 10/27/2023 12:01:48 AM
*******************************************************************/

//Function Number: 1
setupmeleeanimdistances(param_00)
{
	if(isdefined(level.karatemastermeleedist))
	{
		return;
	}

	level.karatemastermeleedist = [];
	setupmeleedistances(param_00,"slow_walk_melee");
	setupmeleedistances(param_00,"walk_melee");
	setupmeleedistances(param_00,"run_melee");
	setupmeleedistances(param_00,"sprint_melee");
	setupmeleedistances(param_00,"stand_melee");
}

//Function Number: 2
getfirstattacknotetracktime(param_00)
{
	var_01 = 99999;
	var_02 = getnotetracktimes(param_00,"r_kick");
	if(var_02.size > 0)
	{
		var_01 = var_02[var_02.size - 1];
	}

	var_02 = getnotetracktimes(param_00,"l_kick");
	if(var_02.size > 0 && var_02[0] < var_01)
	{
		var_01 = var_02[var_02.size - 1];
	}

	var_02 = getnotetracktimes(param_00,"r_punch");
	if(var_02.size > 0 && var_02[0] < var_01)
	{
		var_01 = var_02[0];
	}

	var_02 = getnotetracktimes(param_00,"l_punch");
	if(var_02.size > 0 && var_02[0] < var_01)
	{
		var_01 = var_02[0];
	}

	if(var_01 > 999)
	{
		return undefined;
	}

	return var_01;
}

//Function Number: 3
distcompare(param_00,param_01)
{
	return param_00 < param_01;
}

//Function Number: 4
setupmeleedistances(param_00,param_01)
{
	var_02 = self method_8100(param_01);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = self method_80FD(param_01,var_03);
		var_05 = getfirstattacknotetracktime(var_04);
		var_06 = getmovedelta(var_04,0,var_05);
		var_07 = length(var_06);
		level.karatemastermeleedist[param_01][var_03] = var_07;
		var_08 = getanimlength(var_04);
		var_09 = var_05 * var_08;
		level.karatemastermeleetimetoimpact[param_01][var_03] = var_09;
	}

	level.karatemastermeleedist[param_01] = scripts\common\utility::func_22C3(level.karatemastermeleedist[param_01],::distcompare);
}

//Function Number: 5
karatemasterinit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	lib_0A1B::func_2968("run");
	self.var_55B0 = 1;
	setupmeleeanimdistances(param_00);
	self.desiredmovemeleeindex = [];
}

//Function Number: 6
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 7
playanimandlookatenemy(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\karatemaster\karatemaster_agent::getenemy());
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 8
faceenemyhelper(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self endon(param_02 + "_finished");
	}

	var_03 = gettime() + param_01;
	while(gettime() <= var_03 && isdefined(param_00) && isalive(param_00))
	{
		var_04 = param_00.origin - self.origin;
		if(length2dsquared(var_04) > 1024)
		{
			var_05 = vectortoyaw(var_04);
			self method_8289("face angle abs",(0,var_05,0));
		}

		wait(0.05);
	}

	self method_8289("face angle abs",self.angles);
}

//Function Number: 9
isanimdone(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_232B(param_01,"end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"early_end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"finish_early"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 11
func_BEA0(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_65D3))
	{
		var_04 = self.var_1198.var_FECD.var_65D3.origin;
	}
	else if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_D699))
	{
		var_04 = self.var_1198.var_FECD.var_D699;
	}
	else if(isdefined(var_05))
	{
		var_04 = var_05.origin;
	}

	if(!isdefined(var_04))
	{
		return 0;
	}

	var_06 = self.angles[1] - vectortoyaw(var_04 - self.origin);
	var_07 = distancesquared(self.origin,var_04);
	if(var_07 < 65536)
	{
		var_08 = sqrt(var_07);
		if(var_08 > 3)
		{
			var_06 = var_06 + asin(-3 / var_08);
		}
	}

	if(abs(angleclamp180(var_06)) > self.var_129AF)
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_81DE()
{
	var_00 = 0.25;
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(self.var_1198.var_FECD))
	{
		if(isdefined(self.var_1198.var_FECD.var_65D3))
		{
			var_01 = self.var_1198.var_FECD.var_65D3;
		}
		else if(isdefined(self.var_1198.var_FECD.var_D699))
		{
			var_02 = self.var_1198.var_FECD.var_D699;
		}
	}

	var_03 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	if(isdefined(var_03))
	{
		if(!isdefined(var_01) && !isdefined(var_02))
		{
			var_01 = var_03;
		}
	}

	if(isdefined(var_01) && !issentient(var_01))
	{
		var_00 = 1.5;
	}

	var_04 = scripts\common\utility::func_8094(var_00,var_01,var_02);
	return var_04;
}

//Function Number: 13
func_3F0A(param_00,param_01,param_02)
{
	var_03 = func_81DE();
	if(var_03 < 0)
	{
		var_04 = "right";
	}
	else
	{
		var_04 = "left";
	}

	var_03 = abs(var_03);
	var_05 = 0;
	if(var_03 > 157.5)
	{
		var_05 = 180;
	}
	else if(var_03 > 112.5)
	{
		var_05 = 135;
	}
	else if(var_03 > 67.5)
	{
		var_05 = 90;
	}
	else
	{
		var_05 = 45;
	}

	var_06 = var_04 + "_" + var_05;
	var_07 = lib_0A1A::func_2358(param_01,var_06);
	var_08 = self method_8101(param_01,var_07);
	return var_07;
}

//Function Number: 14
func_D56A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self.var_233;
	self method_8289("face angle abs",self.angles);
	self method_8281("anim deltas");
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
	if(!isdefined(var_05) && isdefined(self.var_233))
	{
		self method_841F();
	}

	lib_0A1D::func_237F("face current");
	lib_0A1D::func_237E("code_move");
}

//Function Number: 15
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 16
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233))
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,1);
		return;
	}

	lib_0A1D::func_2364(param_01,param_02,param_03,var_04);
}

//Function Number: 17
shoulddomelee(param_00,param_01,param_02,param_03)
{
	if(!scripts\common\utility::istrue(self.var_1198.bmeleerequested))
	{
		return 0;
	}

	if(!isdefined(self.var_1198.meleetype))
	{
		return 0;
	}

	if(self.var_1198.meleetype == param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
playanim_melee(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_1198.var_B64D);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	self method_85C9(16);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 19
terminate_melee(param_00,param_01,param_02)
{
	self method_85C9(0);
}

//Function Number: 20
choosestandmeleeanim(param_00,param_01,param_02)
{
	return choosemovingmeleeanim(param_00,param_01,param_02);
}

//Function Number: 21
choosemovingmeleeanim(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	var_04 = self method_80FD(param_01,self.desiredmovemeleeindex[param_01]);
	return self.desiredmovemeleeindex[param_01];
}

//Function Number: 22
choosemeleeanim(param_00,param_01,param_02)
{
	if(self.var_2303.var_7257.var_7254 == "left")
	{
		return lib_0A1A::func_2358(param_01,"left");
	}

	return lib_0A1A::func_2358(param_01,"right");
}

//Function Number: 23
teleportrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bteleportrequested);
}

//Function Number: 24
playanim_teleportin(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(scripts\common\utility::istrue(self.var_1198.bfastteleport))
	{
		var_04 = 3;
	}

	playanimwithplaybackrate(param_00,param_01,param_02,var_04);
}

//Function Number: 25
playanim_teleportout(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\karatemaster\karatemaster_agent::getenemy());
	var_04 = 1;
	if(scripts\common\utility::istrue(self.var_1198.bfastteleport))
	{
		var_04 = 1.5;
	}

	playanimwithplaybackrate(param_00,param_01,param_02,var_04);
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		self.var_9CEC = undefined;
		self.btraversalteleport = undefined;
		self notify("traverse_end");
		lib_0A1A::func_237C("decide_idle",param_03);
	}
}

//Function Number: 26
terminate_teleport(param_00,param_01,param_02)
{
	if(!isanimdone(param_00,param_01,undefined,param_02))
	{
		self show();
		self.ishidden = undefined;
	}
}

//Function Number: 27
teleportnotehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "teleport_in":
			thread doteleportin(param_01);
			break;

		case "teleport_out":
			thread doteleportout(param_01);
			break;
	}
}

//Function Number: 28
playspawnin(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self setscriptablepartstate("teleport","tele_out");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	wait(0.1);
	self setscriptablepartstate("teleport","neutral");
}

//Function Number: 29
doteleportin(param_00)
{
	self endon(param_00 + "_finished");
	self setscriptablepartstate("teleport","tele_in");
	wait(0.1);
	self hide();
	self.ishidden = 1;
	self setscriptablepartstate("teleport","neutral");
}

//Function Number: 30
doteleportout(param_00)
{
	self endon(param_00 + "_finished");
	var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
	var_02 = self.var_1198.teleportspot;
	self dontinterpolate();
	self setorigin(var_02);
	if(isdefined(var_01))
	{
		self.angles = (0,vectortoyaw(var_01.origin - self.origin),0);
	}

	wait(0.1);
	self show();
	self.ishidden = undefined;
	self setscriptablepartstate("teleport","tele_out");
	wait(0.1);
	self setscriptablepartstate("teleport","neutral");
}

//Function Number: 31
meleenotehandler(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = undefined;
	var_06 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	if(param_00 == "r_kick")
	{
		var_04 = var_06.ckickmeleedamage;
		var_05 = self gettagorigin("j_ankle_ri");
		self method_8282(1,1);
	}
	else if(param_00 == "l_kick")
	{
		var_04 = var_06.ckickmeleedamage;
		var_05 = self gettagorigin("j_ankle_le");
		self method_8282(1,1);
	}
	else if(param_00 == "r_punch")
	{
		var_04 = var_06.cpunchmeleedamage;
		var_05 = self gettagorigin("j_wrist_ri");
		self method_8282(1,1);
	}
	else if(param_00 == "l_punch")
	{
		var_04 = var_06.cpunchmeleedamage;
		var_05 = self gettagorigin("j_wrist_le");
		self method_8282(1,1);
	}
	else if(param_00 == "flex_start")
	{
		var_07 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
		if(isdefined(var_07))
		{
			var_08 = self method_80FD(param_01,param_02);
			var_09 = getfirstattacknotetracktime(var_08);
			if(var_09 > param_03)
			{
				var_0A = getmovedelta(var_08,param_03,var_09);
				var_0B = length2d(var_0A);
				var_0C = getanimlength(var_08);
				var_0D = var_09 * var_0C - param_03 * var_0C;
				var_0E = var_07 getvelocity();
				var_0F = var_07.origin + var_0E * var_0D;
				var_10 = distance(var_0F,self.origin);
				var_11 = 1;
				if(var_10 > var_0B && var_0B > 0)
				{
					var_11 = var_10 / var_0B;
					if(var_11 > var_06.cmaxmeleeflexscale)
					{
						var_11 = var_06.cmaxmeleeflexscale;
					}
				}

				self method_8282(var_11,1);
			}
		}
	}

	if(isdefined(var_04))
	{
		var_07 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
		if(isdefined(var_07))
		{
			var_12 = distance2dsquared(var_07.origin,self.origin);
			var_13 = distance2dsquared(var_05,var_07.origin);
			if(var_13 < var_06.cpunchandkickmeleeradiussq || var_12 < var_06.cpunchandkickmeleeradiussq)
			{
				self notify("attack_hit",var_07);
				lib_0C73::func_5904(var_07,var_04,"MOD_IMPACT");
				return;
			}

			self notify("attack_miss",var_07);
			return;
		}
	}
}

//Function Number: 32
ontraversalteleport(param_00,param_01,param_02,param_03)
{
	self.var_1198.teleportspot = self method_8146();
	self.btraversalteleport = 1;
	return 1;
}