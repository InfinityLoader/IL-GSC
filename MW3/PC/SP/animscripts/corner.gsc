/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\corner.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 1002 ms
 * Timestamp: 10/27/2023 2:18:04 AM
*******************************************************************/

//Function Number: 1
func_2442(param_00,param_01)
{
	self endon("killanimscript");
	self.var_2443["exposed"]["stand"] = ::func_2476;
	self.var_2443["exposed"]["crouch"] = ::func_2477;
	self.var_CAF = self.node;
	self.var_2444 = param_00;
	self.a.var_CAE = "unknown";
	self.a.aimidlethread = undefined;
	animscripts/cover_behavior::func_F71(param_01);
	func_244A();
	self.var_2445 = 0;
	self.var_2446 = 0;
	self.var_2447 = 0;
	animscripts/track::func_CC4(0);
	self.var_2448 = 0;
	var_02 = spawnstruct();
	if(!self.fixednode)
	{
		var_02.var_F37 = ::animscripts/cover_behavior::func_F37;
	}

	var_02.var_F36 = ::func_0F36;
	var_02.var_F54 = ::func_246B;
	var_02.var_F55 = ::func_245E;
	var_02.var_7A8 = ::func_0F56;
	var_02.var_F57 = ::func_0F57;
	var_02.idle = ::idle;
	var_02.var_73C = ::func_0F61;
	var_02.var_F63 = ::func_0F9E;
	var_02.var_F64 = ::func_0F64;
	animscripts/cover_behavior::main(var_02);
}

//Function Number: 2
func_2449()
{
	self.var_CB5 = undefined;
	self.a.var_237C = undefined;
}

//Function Number: 3
func_244A()
{
	if(self.a.pose == "crouch")
	{
		func_246E("crouch");
		return;
	}

	if(self.a.pose == "stand")
	{
		func_246E("stand");
		return;
	}

	animscripts/utility::func_F7D(1);
	self.a.pose = "crouch";
	func_246E("crouch");
}

//Function Number: 4
func_244B()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(!isdefined(self.var_244C))
	{
		self.var_244C = gettime() + randomintrange(5000,20000);
	}

	if(gettime() > self.var_244C)
	{
		self.var_244C = gettime() + randomintrange(5000,20000);
		if(isdefined(self.rambochance) && self.a.pose == "stand")
		{
			return 0;
		}

		self.a.var_F3E = undefined;
		return 1;
	}

	return 0;
}

//Function Number: 5
func_0F36()
{
	var_00 = "stand";
	if(self.a.pose == "crouch")
	{
		var_00 = "crouch";
		if(self.var_CAF doesnodeallowstance("stand"))
		{
			if(!self.var_CAF doesnodeallowstance("crouch") || func_244B())
			{
				var_00 = "stand";
			}
		}
	}
	else if(self.var_CAF doesnodeallowstance("crouch"))
	{
		if(!self.var_CAF doesnodeallowstance("stand") || func_244B())
		{
			var_00 = "crouch";
		}
	}

	if(self.var_2448)
	{
		func_2470(var_00);
		return;
	}

	if(self.a.pose == var_00)
	{
		func_2471(animscripts/utility::func_D4D("alert_idle"),0.3,0.4);
	}
	else
	{
		var_01 = animscripts/utility::func_D4D("stance_change");
		func_2471(var_01,0.3,getanimlength(var_01));
		func_246E(var_00);
	}

	self.var_2448 = 1;
}

//Function Number: 6
func_244D()
{
	wait 2;
	for(;;)
	{
		func_2467();
		wait 0.05;
	}
}

//Function Number: 7
func_244E(param_00,param_01)
{
	var_02 = param_01 animscripts/utility::func_244F(param_00);
	if(var_02 > 60 || var_02 < -60)
	{
		return 0;
	}

	if(param_01.type == "Cover Left" && var_02 > 14)
	{
		return 0;
	}

	if(param_01.type == "Cover Right" && var_02 < -12)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_2450()
{
	if(!isdefined(self.var_CB1))
	{
		return 0;
	}

	var_00 = self.var_CAF animscripts/utility::func_244F(self.var_CB1);
	if(self.a.var_CAE == "over")
	{
		return var_00 < self.var_717 || self.var_716 < var_00;
	}

	if(self.var_2444 == "left")
	{
		if(self.a.var_CAE == "B")
		{
			return var_00 < 0 - self.var_2451 || var_00 > 14;
		}

		if(self.a.var_CAE == "A")
		{
			return var_00 > 0 - self.var_2451;
		}

		return var_00 < -50 || var_00 > 8;
	}

	if(self.a.var_CAE == "B")
	{
		return var_00 > self.var_2451 || var_00 < -12;
	}

	if(self.a.var_CAE == "A")
	{
		return var_00 < self.var_2451;
	}

	return var_00 > 50 || var_00 < -8;
}

//Function Number: 9
func_2452(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_00 animscripts/utility::func_244F(param_01);
	}

	var_04 = [];
	if(isdefined(param_00) && self.a.pose == "crouch" && var_03 > self.var_717 && self.var_716 > var_03)
	{
		var_04 = param_00 getvalidcoverpeekouts();
	}

	if(self.var_2444 == "left")
	{
		if(func_2455(var_03,-40,0))
		{
			var_02 = func_2456();
		}

		if(!var_03 && var_04 < 14)
		{
			if(var_04 < 0 - self.var_2451)
			{
			}
			else
			{
			}
		}
	}
	else
	{
		if(func_2455(var_04,0,40))
		{
			var_03 = func_2456();
		}

		if(!var_03 && var_04 > -12)
		{
			if(var_04 > self.var_2451)
			{
			}
			else
			{
			}
		}
	}

	return animscripts/combat_utility::func_FB6(var_7B);
}

//Function Number: 10
func_2453()
{
	var_00 = 0;
	if(animscripts/utility::func_CF3())
	{
		var_00 = self.var_CAF animscripts/utility::func_244F(animscripts/utility::func_CEE());
	}
	else if(self.var_748 && isdefined(self.var_CB1))
	{
		var_00 = self.var_CAF animscripts/utility::func_244F(self.var_CB1);
	}

	if(self.a.var_CAE == "lean")
	{
		return "lean";
	}

	if(self.a.var_CAE == "over")
	{
		return "over";
	}

	if(self.a.var_CAE == "B")
	{
		if(self.var_2444 == "left")
		{
			if(var_00 < 0 - self.var_2451)
			{
				return "A";
			}
		}
		else if(self.var_2444 == "right")
		{
			if(var_00 > self.var_2451)
			{
				return "A";
			}
		}

		return "B";
	}

	if(self.a.var_CAE == "A")
	{
		var_02 = "B";
		if(self.var_2444 == "left")
		{
			if(var_00 > 0 - self.var_2451)
			{
				return "B";
			}
		}
		else if(self.var_2444 == "right")
		{
			if(var_00 < self.var_2451)
			{
				return "B";
			}
		}

		return "A";
	}
}

//Function Number: 11
func_2454()
{
	self endon("killanimscript");
	var_00 = func_2453();
	if(var_00 == self.a.var_CAE)
	{
		return 0;
	}

	self.var_CDD = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.var_CAE + "_to_" + var_00;
	var_02 = animscripts/utility::func_CA8(var_01);
	var_03 = func_246D();
	if(!self maymovetopoint(var_03))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_03,animscripts/utility::func_F99(var_02)))
	{
		return 0;
	}

	animscripts/combat_utility::func_F9D();
	func_2459(0.3);
	var_04 = self.a.pose;
	self setanimlimited(animscripts/utility::func_D4D("straight_level"),0,0.2);
	self setflaggedanimknob("changeStepOutPos",var_02,1,0.2,1.2);
	thread func_112A("changeStepOutPos");
	if(animhasnotetrack(var_02,"start_aim"))
	{
		self waittillmatch("start_aim","changeStepOutPos");
	}
	else
	{
		self waittillmatch("end","changeStepOutPos");
	}

	thread func_2457(undefined,0,0.3);
	self waittillmatch("end","changeStepOutPos");
	self clearanim(var_02,0.1);
	self.a.var_CAE = var_00;
	self.var_CDD = 0;
	self.var_CFD = gettime();
	if(self.a.pose != var_04)
	{
		func_246E(self.a.pose);
	}

	thread func_2458(undefined,1,0.3);
	return 1;
}

//Function Number: 12
func_2455(param_00,param_01,param_02)
{
	if(self.a.var_20A5)
	{
		return 0;
	}

	return param_01 <= param_00 && param_00 <= param_02;
}

//Function Number: 13
func_2456()
{
	if(self.team == "allies")
	{
		return 1;
	}

	if(animscripts/utility::func_F62())
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
func_112A(param_00)
{
	self endon("killanimscript");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 15
func_2457(param_00,param_01,param_02)
{
	self.var_2447 = 1;
	if(self.a.var_CAE == "lean")
	{
		self.a.var_237C = 1;
	}
	else
	{
		self.a.var_237C = undefined;
	}

	func_245A(param_00,param_01,param_02);
}

//Function Number: 16
func_2458(param_00,param_01,param_02)
{
	if(self.a.var_CAE == "lean")
	{
		self.a.var_237C = 1;
	}
	else
	{
		self.a.var_237C = undefined;
	}

	func_245A(param_00,param_01,param_02);
}

//Function Number: 17
func_2459(param_00)
{
	self.var_2447 = 0;
	self clearanim(%add_fire,param_00);
	animscripts/track::func_CC4(0,param_00);
}

//Function Number: 18
func_245A(param_00,param_01,param_02)
{
	self.var_245B = param_00;
	self setanimlimited(%exposed_modern,1,param_02);
	self setanimlimited(%exposed_aiming,1,param_02);
	self setanimlimited(%add_idle,1,param_02);
	animscripts/track::func_CC4(1,param_02);
	var_03 = undefined;
	if(isdefined(self.a.array["lean_aim_straight"]))
	{
		var_03 = self.a.array["lean_aim_straight"];
	}

	thread animscripts/combat_utility::aimidlethread();
	if(isdefined(self.a.var_237C))
	{
		self setanimlimited(var_03,1,param_02);
		self setanimlimited(animscripts/utility::func_D4D("straight_level"),0,0);
		self setanimknoblimited(animscripts/utility::func_D4D("lean_aim_left"),1,param_02);
		self setanimknoblimited(animscripts/utility::func_D4D("lean_aim_right"),1,param_02);
		self setanimknoblimited(animscripts/utility::func_D4D("lean_aim_up"),1,param_02);
		self setanimknoblimited(animscripts/utility::func_D4D("lean_aim_down"),1,param_02);
		return;
	}

	if(param_01)
	{
		self setanimlimited(animscripts/utility::func_D4D("straight_level"),1,param_02);
		if(isdefined(var_03))
		{
			self setanimlimited(var_03,0,0);
		}

		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_up"),1,param_02);
		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_down"),1,param_02);
		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_left"),1,param_02);
		self setanimknoblimited(animscripts/utility::func_D4D("add_aim_right"),1,param_02);
		return;
	}

	self setanimlimited(animscripts/utility::func_D4D("straight_level"),0,param_02);
	if(isdefined(var_03))
	{
		self setanimlimited(var_03,0,0);
	}

	self setanimknoblimited(animscripts/utility::func_D4D("add_turn_aim_up"),1,param_02);
	self setanimknoblimited(animscripts/utility::func_D4D("add_turn_aim_down"),1,param_02);
	self setanimknoblimited(animscripts/utility::func_D4D("add_turn_aim_left"),1,param_02);
	self setanimknoblimited(animscripts/utility::func_D4D("add_turn_aim_right"),1,param_02);
}

//Function Number: 19
func_245C()
{
	if(self.a.var_CAE == "over")
	{
		return 1;
	}

	return animscripts/combat_utility::func_F97();
}

//Function Number: 20
func_245D()
{
	self.a.var_CAE = "alert";
	if(self.goalradius < 64)
	{
		self.goalradius = 64;
	}

	self animmode("zonly_physics");
	if(self.a.pose == "stand")
	{
		self.var_2451 = 38;
	}
	else
	{
		self.var_2451 = 31;
	}

	var_00 = self.a.pose;
	func_246E(var_00);
	self setdefaultaimlimits();
	var_01 = "none";
	if(animscripts/utility::func_F8C())
	{
		var_01 = func_2452(self.var_CAF,animscripts/utility::func_CEE());
	}
	else
	{
		var_01 = func_2452(self.var_CAF);
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = "alert_to_" + var_01;
	var_03 = animscripts/utility::func_CA8(var_02);
	if(var_01 == "lean" && !func_2468())
	{
		return 0;
	}

	if(var_01 != "over" && !func_246C(var_03,var_01 != "lean"))
	{
		return 0;
	}

	self.a.var_CAE = var_01;
	self.a.var_F3E = var_01;
	if(self.a.var_CAE == "lean")
	{
		self setdefaultaimlimits(self.var_CAF);
	}

	if(var_01 == "A" || var_01 == "B")
	{
		self.a.var_D19 = "cover_" + self.var_2444 + "_" + self.a.pose + "_" + var_01;
	}
	else if(var_01 == "over")
	{
		self.a.var_D19 = "cover_crouch_aim";
	}
	else
	{
		self.a.var_D19 = "none";
	}

	self.keepclaimednodeifvalid = 1;
	var_04 = 0;
	self.var_CDD = 1;
	self notify("done_changing_cover_pos");
	var_05 = func_245C();
	self.pushable = 0;
	self setflaggedanimknoballrestart("stepout",var_03,%root,1,0.2,var_05);
	thread func_112A("stepout");
	var_04 = animhasnotetrack(var_03,"start_aim");
	if(var_04)
	{
		self.var_CB5 = self.angles[1] + getangledelta(var_03,0,1);
		self waittillmatch("start_aim","stepout");
	}
	else
	{
		self waittillmatch("end","stepout");
	}

	if(var_01 == "B" && common_scripts\utility::cointoss() && self.var_2444 == "right")
	{
		self.a.var_D19 = "corner_right_martyrdom";
	}

	func_246F(var_00);
	var_06 = var_01 == "over";
	func_2457(undefined,var_06,0.3);
	thread animscripts/track::func_CA9();
	if(var_04)
	{
		self waittillmatch("end","stepout");
		self.var_CB5 = undefined;
	}

	func_2458(undefined,1,0.2);
	self clearanim(%cover,0.1);
	self clearanim(%corner,0.1);
	self.var_CDD = 0;
	self.var_CFD = gettime();
	self.pushable = 1;
	return 1;
}

//Function Number: 21
func_245E()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(func_0F8B())
		{
			return 1;
		}
	}

	if(!func_245D())
	{
		return 0;
	}

	func_0F88();
	if(isdefined(self.var_CB1))
	{
		var_00 = lengthsquared(self.origin - self.var_CB1);
		if(animscripts/utility::func_BB6() && var_00 < squared(512) || self.a.rockets < 1)
		{
			if(self.a.pose == "stand")
			{
				animscripts/shared::func_F87(%rpg_stand_throw);
			}
			else
			{
				animscripts/shared::func_F87(%rpg_crouch_throw);
			}

			thread func_2478();
			return;
		}
	}

	func_2465();
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 22
func_245F(param_00)
{
	if(!isdefined(self.var_F91))
	{
		return 1;
	}

	return gettime() - self.var_F91 > param_00 * 1000;
}

//Function Number: 23
func_0F8B()
{
	if(!animscripts/utility::func_F8C())
	{
		return 0;
	}

	var_00 = 0;
	var_01 = 90;
	var_02 = self.var_CAF animscripts/utility::func_244F(animscripts/utility::func_CEE());
	if(self.var_2444 == "left")
	{
		var_02 = 0 - var_02;
	}

	if(var_02 > 30)
	{
		var_01 = 45;
		if(self.var_2444 == "left")
		{
			var_00 = 45;
		}
		else
		{
			var_00 = -45;
		}
	}

	var_03 = "rambo" + var_01;
	if(!animscripts/utility::func_F8D(var_03))
	{
		return 0;
	}

	var_04 = animscripts/utility::func_CA8(var_03);
	var_05 = func_246D(48);
	if(!self maymovetopoint(var_05))
	{
		return 0;
	}

	self.var_CFD = gettime();
	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self.isrambo = 1;
	self.a.var_F3E = "rambo";
	self.var_CDD = 1;
	thread animscripts/shared::func_F90(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0,1);
	animscripts/shared::donotetracks("rambo");
	self notify("rambo_aim_end");
	self.var_CDD = 0;
	self.keepclaimednodeifvalid = 0;
	self.var_F91 = gettime();
	self.var_CDD = 0;
	self.isrambo = undefined;
	return 1;
}

//Function Number: 24
func_0F88()
{
	maps\_gameskill::didsomethingotherthanshooting();
	for(;;)
	{
		for(;;)
		{
			if(isdefined(self.var_CDC))
			{
				break;
			}

			if(!isdefined(self.var_CB1))
			{
				self waittill("do_slow_things");
				waittillframeend;
				if(isdefined(self.var_CB1))
				{
					continue;
				}

				break;
			}

			if(!self.bulletsinclip)
			{
				break;
			}

			if(func_2450())
			{
				if(!func_2454())
				{
					if(func_2453() == self.a.var_CAE)
					{
						break;
					}

					func_2460(0.2);
					continue;
				}

				if(func_2450())
				{
					break;
				}

				continue;
			}

			func_2462(1);
			self clearanim(%add_fire,0.2);
		}

		if(func_2464(self.a.var_CAE != "lean"))
		{
			break;
		}

		if(func_2450() && func_2454())
		{
			continue;
		}

		func_2460(0.2);
	}
}

//Function Number: 25
func_2460(param_00)
{
	thread func_2461(param_00);
	var_01 = gettime();
	func_2462(0);
	self notify("stopNotifyStopShootingAfterTime");
	var_02 = gettime() - var_01 / 1000;
	if(var_02 < param_00)
	{
		wait param_00 - var_02;
	}
}

//Function Number: 26
func_2461(param_00)
{
	self endon("killanimscript");
	self endon("stopNotifyStopShootingAfterTime");
	wait param_00;
	self notify("stopShooting");
}

//Function Number: 27
func_2462(param_00)
{
	self endon("return_to_cover");
	if(param_00)
	{
		thread func_0FB3();
	}

	thread animscripts/combat_utility::aimidlethread();
	animscripts/combat_utility::func_F06();
}

//Function Number: 28
func_0FB3()
{
	self endon("killanimscript");
	self notify("newAngleRangeCheck");
	self endon("newAngleRangeCheck");
	self endon("take_cover_at_corner");
	for(;;)
	{
		if(func_2450())
		{
			break;
		}

		wait 0.1;
	}

	self notify("stopShooting");
}

//Function Number: 29
func_2463()
{
	self.enemy endon("death");
	self endon("enemy");
	self endon("stopshowstate");
	wait 0.05;
}

//Function Number: 30
func_2464(param_00)
{
	if(param_00)
	{
		var_01 = func_246D();
		if(!self maymovetopoint(var_01))
		{
			return 0;
		}

		return self maymovefrompointtopoint(var_01,self.var_CAF.origin);
	}

	return self maymovetopoint(self.var_CAF.origin);
}

//Function Number: 31
func_2465()
{
	animscripts/combat_utility::func_F85();
	var_00 = animscripts/utility::func_F4C();
	self notify("take_cover_at_corner");
	self.var_CDD = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.var_CAE + "_to_alert";
	var_02 = animscripts/utility::func_CA8(var_01);
	func_2459(0.3);
	var_03 = 0;
	if(self.a.var_CAE != "lean" && var_00 && animscripts/utility::func_F8D(var_01 + "_reload") && randomfloat(100) < 75)
	{
		var_02 = animscripts/utility::func_CA8(var_01 + "_reload");
		var_03 = 1;
	}

	var_04 = func_245C();
	self clearanim(%body,0.1);
	self setflaggedanimrestart("hide",var_02,1,0.1,var_04);
	animscripts/shared::donotetracks("hide");
	if(var_03)
	{
		animscripts/weaponlist::func_CD0();
	}

	self.var_CDD = 0;
	if(self.var_2444 == "left")
	{
		self.a.var_D19 = "cover_left";
	}
	else
	{
		self.a.var_D19 = "cover_right";
	}

	self.keepclaimednodeifvalid = 0;
	self clearanim(var_02,0.2);
}

//Function Number: 32
func_0F64()
{
	if(!animscripts/utility::func_F8D("blind_fire"))
	{
		return 0;
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self setflaggedanimknoballrestart("blindfire",animscripts/utility::func_CA8("blind_fire"),%body,1,0,1);
	animscripts/shared::donotetracks("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 33
func_2466(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = (1,1,1);
	}

	for(var_03 = 0;var_03 < 100;var_03++)
	{
		wait 0.05;
	}
}

//Function Number: 34
func_0F9E(param_00)
{
	return func_0F61(param_00,1);
}

//Function Number: 35
func_0F61(param_00,param_01)
{
	if(!self maymovetopoint(func_246D()))
	{
		return 0;
	}

	if(isdefined(self.dontevershoot) || isdefined(param_00.var_FA0))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(isdefined(self.a.array["grenade_rambo"]))
		{
			var_02 = animscripts/utility::func_D4D("grenade_rambo");
		}
	}

	if(!isdefined(var_02))
	{
		if(isdefined(param_01) && param_01)
		{
			if(!isdefined(self.a.array["grenade_safe"]))
			{
				return 0;
			}

			var_02 = animscripts/utility::func_D4D("grenade_safe");
		}
		else
		{
			if(!isdefined(self.a.array["grenade_exposed"]))
			{
				return 0;
			}

			var_02 = animscripts/utility::func_D4D("grenade_exposed");
		}
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts/combat_utility::func_FA1(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 36
func_2467()
{
}

//Function Number: 37
func_0F56(param_00)
{
	if(!isdefined(self.a.array["alert_to_look"]))
	{
		return 0;
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	if(!func_0F94())
	{
		return 0;
	}

	animscripts/shared::func_F93(animscripts/utility::func_D4D("look_idle"),param_00,::func_246A);
	var_01 = undefined;
	if(animscripts/utility::func_F4C())
	{
		var_01 = animscripts/utility::func_D4D("look_to_alert_fast");
	}
	else
	{
		var_01 = animscripts/utility::func_D4D("look_to_alert");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1,1);
	animscripts/shared::donotetracks("looking_end");
	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 38
func_2468()
{
	var_00 = self geteye();
	var_01 = anglestoright(self.var_CAF.angles);
	if(self.var_2444 == "right")
	{
		var_00 = var_00 + var_01 * 30;
	}
	else
	{
		var_00 = var_00 - var_01 * 30;
	}

	var_02 = var_00 + anglestoforward(self.var_CAF.angles) * 30;
	return sighttracepassed(var_00,var_02,1,self);
}

//Function Number: 39
func_0F94()
{
	if(isdefined(self.var_CAF.var_F95))
	{
		return 0;
	}

	if(isdefined(self.var_2469) && gettime() < self.var_2469)
	{
		return 0;
	}

	if(!func_2468())
	{
		self.var_2469 = gettime() + 3000;
		return 0;
	}

	var_00 = animscripts/utility::func_D4D("alert_to_look");
	self setflaggedanimknoball("looking_start",var_00,%body,1,0.2,1);
	animscripts/shared::donotetracks("looking_start");
	return 1;
}

//Function Number: 40
func_246A()
{
	return self maymovetopoint(self.var_CAF.origin);
}

//Function Number: 41
func_0F57()
{
	return 0;
}

//Function Number: 42
func_246B()
{
	var_00 = animscripts/utility::func_CA8("reload");
	self setflaggedanimknobrestart("cornerReload",var_00,1,0.2);
	animscripts/shared::donotetracks("cornerReload");
	animscripts/weaponlist::func_CD0();
	self setanimrestart(animscripts/utility::func_D4D("alert_idle"),1,0.2);
	self clearanim(var_00,0.2);
	return 1;
}

//Function Number: 43
func_246C(param_00,param_01)
{
	if(param_01)
	{
		var_02 = func_246D();
		if(!self maymovetopoint(var_02))
		{
			return 0;
		}

		return self maymovefrompointtopoint(var_02,animscripts/utility::func_F99(param_00));
	}

	return self maymovetopoint(animscripts/utility::func_F99(param_01));
}

//Function Number: 44
func_246D(param_00)
{
	var_01 = self.var_CAF.angles;
	var_02 = anglestoright(var_01);
	if(!isdefined(param_00))
	{
		param_00 = 36;
	}

	switch(self.script)
	{
		case "cover_left":
			var_02 = var_02 * 0 - param_00;
			break;

		case "cover_right":
			var_02 = var_02 * param_00;
			break;

		default:
			break;
	}

	return self.var_CAF.origin + (var_02[0],var_02[1],0);
}

//Function Number: 45
idle()
{
	self endon("end_idle");
	for(;;)
	{
		var_00 = randomint(2) == 0 && animscripts/utility::func_F8D("alert_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts/utility::func_CA8("alert_idle_twitch");
		}
		else
		{
			var_01 = animscripts/utility::func_D4D("alert_idle");
		}

		func_0F92(var_01,var_00);
	}
}

//Function Number: 46
func_0F5B()
{
	if(!animscripts/utility::func_F8D("alert_idle_flinch"))
	{
		return 0;
	}

	func_0F92(animscripts/utility::func_CA8("alert_idle_flinch"),1);
	return 1;
}

//Function Number: 47
func_0F92(param_00,param_01)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("idle",param_00,%body,1,0.1,1);
	}
	else
	{
		self setflaggedanimknoball("idle",param_00,%body,1,0.1,1);
	}

	animscripts/shared::donotetracks("idle");
}

//Function Number: 48
func_246E(param_00)
{
	[[ self.var_2443["hiding"][param_00] ]]();
	[[ self.var_2443["exposed"][param_00] ]]();
}

//Function Number: 49
func_246F(param_00)
{
	[[ self.var_2443["exposed"][param_00] ]]();
}

//Function Number: 50
func_2470(param_00)
{
	if(self.a.pose == param_00)
	{
		func_246E(param_00);
		return;
	}

	self setflaggedanimknoballrestart("changeStance",animscripts/utility::func_D4D("stance_change"),%body);
	func_246E(param_00);
	animscripts/shared::donotetracks("changeStance");
	wait 0.2;
}

//Function Number: 51
func_2471(param_00,param_01,param_02)
{
	var_03 = animscripts/utility::func_2472();
	var_04 = animscripts/utility::func_2473();
	var_05 = var_03 + self.var_2474;
	self orientmode("face angle",var_05);
	self animmode("normal");
	thread animscripts/shared::func_F7C(var_04,param_01);
	self setflaggedanimknoballrestart("coveranim",param_00,%body,1,param_01);
	animscripts/notetracks::func_D4F(param_02,"coveranim");
	while(animscripts/utility::func_D61(self.angles[1] - var_05) > 1)
	{
		animscripts/notetracks::func_D4F(0.1,"coveranim");
	}

	self animmode("zonly_physics");
	if(self.var_2444 == "left")
	{
		self.a.var_D19 = "cover_left";
		return;
	}

	self.a.var_D19 = "cover_right";
}

//Function Number: 52
func_2475()
{
	self endon("killanimscript");
	wait 0.05;
}

//Function Number: 53
func_2476()
{
	if(!isdefined(self.a.array))
	{
	}

	self.a.array["add_aim_up"] = %exposed_aim_8;
	self.a.array["add_aim_down"] = %exposed_aim_2;
	self.a.array["add_aim_left"] = %exposed_aim_4;
	self.a.array["add_aim_right"] = %exposed_aim_6;
	self.a.array["add_turn_aim_up"] = %exposed_turn_aim_8;
	self.a.array["add_turn_aim_down"] = %exposed_turn_aim_2;
	self.a.array["add_turn_aim_left"] = %exposed_turn_aim_4;
	self.a.array["add_turn_aim_right"] = %exposed_turn_aim_6;
	self.a.array["straight_level"] = %exposed_aim_5;
	if(self.a.var_CAE == "lean")
	{
		var_00 = self.a.array["lean_fire"];
		var_01 = self.a.array["lean_single"];
		self.a.array["fire"] = var_00;
		self.a.array["single"] = animscripts/utility::array(var_01);
		self.a.array["semi2"] = var_01;
		self.a.array["semi3"] = var_01;
		self.a.array["semi4"] = var_01;
		self.a.array["semi5"] = var_01;
		self.a.array["burst2"] = var_00;
		self.a.array["burst3"] = var_00;
		self.a.array["burst4"] = var_00;
		self.a.array["burst5"] = var_00;
		self.a.array["burst6"] = var_00;
	}
	else
	{
		self.a.array["fire"] = %exposed_shoot_auto_v2;
		self.a.array["semi2"] = %exposed_shoot_semi2;
		self.a.array["semi3"] = %exposed_shoot_semi3;
		self.a.array["semi4"] = %exposed_shoot_semi4;
		self.a.array["semi5"] = %exposed_shoot_semi5;
		if(animscripts/utility::func_C97())
		{
			self.a.array["single"] = animscripts/utility::array(%shotgun_stand_fire_1a);
		}
		else
		{
			self.a.array["single"] = animscripts/utility::array(%exposed_shoot_semi1);
		}

		self.a.array["burst2"] = %exposed_shoot_burst3;
		self.a.array["burst3"] = %exposed_shoot_burst3;
		self.a.array["burst4"] = %exposed_shoot_burst4;
		self.a.array["burst5"] = %exposed_shoot_burst5;
		self.a.array["burst6"] = %exposed_shoot_burst6;
	}

	self.a.array["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
}

//Function Number: 54
func_2477()
{
	if(!isdefined(self.a.array))
	{
	}

	if(self.a.var_CAE == "over")
	{
		self.a.array["add_aim_up"] = %covercrouch_aim8_add;
		self.a.array["add_aim_down"] = %covercrouch_aim2_add;
		self.a.array["add_aim_left"] = %covercrouch_aim4_add;
		self.a.array["add_aim_right"] = %covercrouch_aim6_add;
		self.a.array["straight_level"] = %covercrouch_aim5;
		var_00["fire"] = %exposed_shoot_auto_v2;
		if(animscripts/utility::func_C97())
		{
		}
		else
		{
		}

		self.a.array["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
		return;
	}

	if(self.a.var_CAE == "lean")
	{
		var_01 = self.a.array["lean_fire"];
		var_02 = self.a.array["lean_single"];
		self.a.array["fire"] = var_01;
		self.a.array["single"] = animscripts/utility::array(var_02);
		self.a.array["semi2"] = var_02;
		self.a.array["semi3"] = var_02;
		self.a.array["semi4"] = var_02;
		self.a.array["semi5"] = var_02;
		self.a.array["burst2"] = var_01;
		self.a.array["burst3"] = var_01;
		self.a.array["burst4"] = var_01;
		self.a.array["burst5"] = var_01;
		self.a.array["burst6"] = var_01;
	}
	else
	{
		self.a.array["fire"] = %exposed_crouch_shoot_auto_v2;
		self.a.array["semi2"] = %exposed_crouch_shoot_semi2;
		self.a.array["semi3"] = %exposed_crouch_shoot_semi3;
		self.a.array["semi4"] = %exposed_crouch_shoot_semi4;
		self.a.array["semi5"] = %exposed_crouch_shoot_semi5;
		if(animscripts/utility::func_C97())
		{
			self.a.array["single"] = animscripts/utility::array(%shotgun_crouch_fire);
		}
		else
		{
			self.a.array["single"] = animscripts/utility::array(%exposed_crouch_shoot_semi1);
		}

		self.a.array["burst2"] = %exposed_crouch_shoot_burst3;
		self.a.array["burst3"] = %exposed_crouch_shoot_burst3;
		self.a.array["burst4"] = %exposed_crouch_shoot_burst4;
		self.a.array["burst5"] = %exposed_crouch_shoot_burst5;
		self.a.array["burst6"] = %exposed_crouch_shoot_burst6;
	}

	self.a.array["add_aim_up"] = %exposed_crouch_aim_8;
	self.a.array["add_aim_down"] = %exposed_crouch_aim_2;
	self.a.array["add_aim_left"] = %exposed_crouch_aim_4;
	self.a.array["add_aim_right"] = %exposed_crouch_aim_6;
	self.a.array["add_turn_aim_up"] = %exposed_crouch_turn_aim_8;
	self.a.array["add_turn_aim_down"] = %exposed_crouch_turn_aim_2;
	self.a.array["add_turn_aim_left"] = %exposed_crouch_turn_aim_4;
	self.a.array["add_turn_aim_right"] = %exposed_crouch_turn_aim_6;
	self.a.array["straight_level"] = %exposed_crouch_aim_5;
	self.a.array["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
}

//Function Number: 55
func_2478()
{
	self notify("killanimscript");
	thread animscripts/combat::main();
}