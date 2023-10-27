/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\corner.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 60
 * Decompile Time: 1017 ms
 * Timestamp: 10/27/2023 1:23:40 AM
*******************************************************************/

//Function Number: 1
func_1F52(param_00,param_01)
{
	self endon("killanimscript");
	self.animarrayfuncs["exposed"]["stand"] = ::func_6F9B;
	self.animarrayfuncs["exposed"]["crouch"] = ::func_6E69;
	self.var_1FCA = self.node;
	self.cornerdirection = param_00;
	self.a.cornermode = "unknown";
	self.a.aimidlethread = undefined;
	animscripts/cover_behavior::func_84C1(param_01);
	func_6E66();
	self.isshooting = 0;
	self.var_8216 = 0;
	self.var_1F53 = 0;
	animscripts/track::setanimaimweight(0);
	self.var_4030 = 0;
	var_02 = spawnstruct();
	if(!self.fixednode)
	{
		var_02.var_54BE = ::animscripts/cover_behavior::func_54BE;
	}

	var_02.mainloopstart = ::mainloopstart;
	var_02.reload = ::cornerreload;
	var_02.leavecoverandshoot = ::func_7BEC;
	var_02.look = ::lookforenemy;
	var_02.var_31EF = ::func_31EF;
	var_02.var_43C6 = ::func_43C6;
	var_02.grenade = ::func_8406;
	var_02.var_3DB1 = ::func_8407;
	var_02.blindfire = ::blindfire;
	animscripts/cover_behavior::func_4FDD(var_02);
}

//Function Number: 2
end_script_corner()
{
	self.var_7BED = undefined;
	self.a.var_4D3C = undefined;
}

//Function Number: 3
func_6E66()
{
	if(self.a.var_60B1 == "crouch")
	{
		func_6E31("crouch");
	}

	if(self.a.var_60B1 == "stand")
	{
		func_6E31("stand");
	}

	animscripts/utility::exitpronewrapper(1);
	self.a.var_60B1 = "crouch";
	func_6E31("crouch");
}

//Function Number: 4
func_74A2()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(!isdefined(self.changestanceforfuntime))
	{
		self.changestanceforfuntime = gettime() + randomintrange(5000,20000);
	}

	if(gettime() > self.changestanceforfuntime)
	{
		self.changestanceforfuntime = gettime() + randomintrange(5000,20000);
		if(isdefined(self.var_62FD) && self.a.var_60B1 == "stand")
		{
			return 0;
		}

		self.a.prevattack = undefined;
		return 1;
	}

	return 0;
}

//Function Number: 5
mainloopstart()
{
	var_00 = "stand";
	if(self.a.var_60B1 == "crouch")
	{
		var_00 = "crouch";
		if(self.var_1FCA doesnodeallowstance("stand"))
		{
			if(!self.var_1FCA doesnodeallowstance("crouch") || func_74A2())
			{
				var_00 = "stand";
			}
		}
	}
	else if(self.var_1FCA doesnodeallowstance("crouch"))
	{
		if(!self.var_1FCA doesnodeallowstance("stand") || func_74A2())
		{
			var_00 = "crouch";
		}
	}

	if(self.var_4030)
	{
		func_8272(var_00);
	}

	if(self.a.var_60B1 == var_00)
	{
		if(isdefined(self.cover) && isdefined(self.cover.var_420D) && self.cover.var_420D == "back")
		{
			var_01 = animscripts/utility::animarray("alert_idle_back");
		}
		else
		{
			var_01 = animscripts/utility::animarray("alert_idle");
		}

		gotocover(var_01,0.3,0.4);
	}
	else
	{
		var_02 = animscripts/utility::animarray("stance_change");
		gotocover(var_02,0.3,getanimlength(var_02));
		func_6E31(var_00);
	}

	self.var_4030 = 1;
}

//Function Number: 6
func_61B2()
{
	wait(2);
	for(;;)
	{
		func_61B3();
		wait(0.05);
	}
}

//Function Number: 7
func_19F8(param_00,param_01)
{
	var_02 = param_01 animscripts/utility::getyawtoorigin(param_00);
	if(var_02 > 60 || var_02 < -60)
	{
		return 0;
	}

	if(animscripts/utility::func_4917(param_01) && var_02 > 14)
	{
		return 0;
	}

	if(animscripts/utility::func_491A(param_01) && var_02 < -12)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_7446()
{
	if(!isdefined(self.var_7445))
	{
		return 0;
	}

	var_00 = self.var_1FCA animscripts/utility::getyawtoorigin(self.var_7445);
	if(self.a.cornermode == "over")
	{
		return var_00 < self.leftaimlimit || self.rightaimlimit < var_00;
	}

	if(self.cornerdirection == "up")
	{
		return var_00 < -50 || var_00 > 50;
	}

	if(self.cornerdirection == "left")
	{
		if(self.a.cornermode == "B")
		{
			return var_00 < 0 - self.abanglecutoff || var_00 > 14;
		}

		if(self.a.cornermode == "A")
		{
			return var_00 > 0 - self.abanglecutoff;
		}

		return var_00 < -50 || var_00 > 8;
	}

	if(self.a.cornermode == "B")
	{
		return var_00 > self.abanglecutoff || var_00 < -12;
	}

	if(self.a.cornermode == "A")
	{
		return var_00 < self.abanglecutoff;
	}

	return var_00 > 50 || var_00 < -8;
}

//Function Number: 9
func_3A61(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_00 animscripts/utility::getyawtoorigin(param_01);
	}

	var_04 = [];
	if(isdefined(param_00) && self.a.var_60B1 == "crouch" && var_03 > self.leftaimlimit && self.rightaimlimit > var_03)
	{
		var_04 = param_00 getvalidcoverpeekouts();
	}

	if(self.cornerdirection == "up")
	{
		if(animscripts/utility::func_4965())
		{
			var_05 = 0;
			if(isdefined(param_01))
			{
				var_06 = anglestoup(self.angles);
				var_05 = animscripts/combat_utility::func_3B8F(param_01,self geteye() + (var_06[0] * 12,var_06[1] * 12,var_06[2] * 12));
			}

			if(canlean(var_05,-5,80))
			{
				var_02 = func_74B6();
				var_04[var_04.size] = "lean";
				var_04[var_04.size] = "lean";
			}

			if(!var_02)
			{
				var_04[var_04.size] = "A";
			}
		}
		else
		{
			var_04[var_04.size] = "A";
		}
	}
	else if(self.cornerdirection == "left")
	{
		if(canlean(var_03,-40,0))
		{
			var_02 = func_74B6();
			var_04[var_04.size] = "lean";
		}

		if(!var_02 && var_03 < 14)
		{
			if(var_03 < 0 - self.abanglecutoff)
			{
				var_04[var_04.size] = "A";
			}
			else
			{
				var_04[var_04.size] = "B";
			}
		}
	}
	else
	{
		if(canlean(var_03,0,40))
		{
			var_02 = func_74B6();
			var_04[var_04.size] = "lean";
		}

		if(!var_02 && var_03 > -12)
		{
			if(var_03 > self.abanglecutoff)
			{
				var_04[var_04.size] = "A";
			}
			else
			{
				var_04[var_04.size] = "B";
			}
		}
	}

	return animscripts/combat_utility::func_3BB6(var_04);
}

//Function Number: 10
getbeststepoutpos()
{
	var_00 = 0;
	if(animscripts/utility::cansuppressenemy())
	{
		var_00 = self.var_1FCA animscripts/utility::getyawtoorigin(animscripts/utility::func_3A97());
	}
	else if(self.doingambush && isdefined(self.var_7445))
	{
		var_00 = self.var_1FCA animscripts/utility::getyawtoorigin(self.var_7445);
	}

	if(self.a.cornermode == "lean")
	{
		return "lean";
	}

	if(self.a.cornermode == "over")
	{
		return "over";
	}

	if(self.a.cornermode == "B")
	{
		if(self.cornerdirection == "left")
		{
			if(var_00 < 0 - self.abanglecutoff)
			{
				return "A";
			}
		}
		else if(self.cornerdirection == "right")
		{
			if(var_00 > self.abanglecutoff)
			{
				return "A";
			}
		}

		return "B";
	}

	if(self.a.cornermode == "A")
	{
		if(self.cornerdirection == "up")
		{
			return "A";
		}
		else if(self.cornerdirection == "left")
		{
			if(var_00 > 0 - self.abanglecutoff)
			{
				return "B";
			}
		}
		else if(self.cornerdirection == "right")
		{
			if(var_00 < self.abanglecutoff)
			{
				return "B";
			}
		}

		return "A";
	}
}

//Function Number: 11
changestepoutpos()
{
	self endon("killanimscript");
	var_00 = getbeststepoutpos();
	if(var_00 == self.a.cornermode)
	{
		return 0;
	}

	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.cornermode + "_to_" + var_00;
	var_02 = animscripts/utility::animarraypickrandom(var_01);
	if(animscripts/utility::func_4965() && var_01 == "A_to_B" || var_01 == "B_to_A")
	{
		return 0;
	}

	var_03 = !self.swimmer;
	var_04 = getpredictedpathmidpoint();
	if(!self maymovetopoint(var_04,var_03))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_04,animscripts/utility::func_3A23(var_02),var_03))
	{
		return 0;
	}

	animscripts/combat_utility::func_2D4B();
	func_7C5A(0.3);
	var_05 = self.a.var_60B1;
	self setanimlimited(animscripts/utility::animarray("straight_level"),0,0.2);
	self setflaggedanimknob("changeStepOutPos",var_02,1,0.2,1.2);
	corner_playcornerfacialanim(var_02);
	thread donotetrackswithendon("changeStepOutPos");
	var_06 = animhasnotetrack(var_02,"start_aim");
	if(var_06)
	{
		self waittillmatch("start_aim","changeStepOutPos");
	}
	else
	{
		self waittillmatch("end","changeStepOutPos");
	}

	thread func_7AC0(undefined,0,0.3);
	if(var_06)
	{
		self waittillmatch("end","changeStepOutPos");
	}

	self clearanim(var_02,0.1);
	self.a.cornermode = var_00;
	self.changingcoverpos = 0;
	self.coverposestablishedtime = gettime();
	if(self.a.var_60B1 != var_05)
	{
		func_6E31(self.a.var_60B1);
	}

	thread func_1AD9(undefined,1,0.3);
	return 1;
}

//Function Number: 12
canlean(param_00,param_01,param_02)
{
	if(self.a.var_55A8)
	{
		return 0;
	}

	return param_01 <= param_00 && param_00 <= param_02;
}

//Function Number: 13
func_74B6()
{
	if(self.team == "allies")
	{
		return 1;
	}

	if(animscripts/utility::ispartiallysuppressedwrapper())
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
donotetrackswithendon(param_00)
{
	self endon("killanimscript");
	animscripts/shared::func_2986(param_00);
}

//Function Number: 15
func_7AC0(param_00,param_01,param_02)
{
	self.var_1F53 = 1;
	if(self.a.cornermode == "lean")
	{
		self.a.var_4D3C = 1;
	}
	else
	{
		self.a.var_4D3C = undefined;
	}

	func_6FD7(param_00,param_01,param_02);
}

//Function Number: 16
func_1AD9(param_00,param_01,param_02)
{
	if(self.a.cornermode == "lean")
	{
		self.a.var_4D3C = 1;
	}
	else
	{
		self.a.var_4D3C = undefined;
	}

	func_6FD7(param_00,param_01,param_02);
}

//Function Number: 17
func_7C5A(param_00)
{
	self.var_1F53 = 0;
	self clearanim(%add_fire,param_00);
	animscripts/track::setanimaimweight(0,param_00);
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}

//Function Number: 18
func_6FD7(param_00,param_01,param_02)
{
	self.var_7966 = param_00;
	self setanimlimited(%exposed_modern,1,param_02);
	self setanimlimited(%exposed_aiming,1,param_02);
	self setanimlimited(%add_idle,1,param_02);
	animscripts/track::setanimaimweight(1,param_02);
	corner_playaimfacialanim(undefined);
	var_03 = undefined;
	if(isdefined(self.a.var_ED8["lean_aim_straight"]))
	{
		var_03 = self.a.var_ED8["lean_aim_straight"];
	}

	thread animscripts/combat_utility::aimidlethread();
	if(isdefined(self.a.var_4D3C))
	{
		self setanimlimited(var_03,1,param_02);
		self setanimlimited(animscripts/utility::animarray("straight_level"),0,0);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_left"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_right"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_up"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_down"),1,param_02);
	}

	if(param_01)
	{
		self setanimlimited(animscripts/utility::animarray("straight_level"),1,param_02);
		if(isdefined(var_03))
		{
			self setanimlimited(var_03,0,0);
		}

		self setanimknoblimited(animscripts/utility::animarray("add_aim_up"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("add_aim_down"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("add_aim_left"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("add_aim_right"),1,param_02);
	}

	self setanimlimited(animscripts/utility::animarray("straight_level"),0,param_02);
	if(isdefined(var_03))
	{
		self setanimlimited(var_03,0,0);
	}

	self setanimknoblimited(animscripts/utility::animarray("add_turn_aim_up"),1,param_02);
	self setanimknoblimited(animscripts/utility::animarray("add_turn_aim_down"),1,param_02);
	self setanimknoblimited(animscripts/utility::animarray("add_turn_aim_left"),1,param_02);
	self setanimknoblimited(animscripts/utility::animarray("add_turn_aim_right"),1,param_02);
}

//Function Number: 19
func_7BEB()
{
	if(self.a.cornermode == "over")
	{
		return 1;
	}

	return animscripts/combat_utility::func_6332();
}

//Function Number: 20
func_7BEA()
{
	self.a.cornermode = "alert";
	if(self.goalradius < 64)
	{
		self.goalradius = 64;
	}

	func_7017();
	if(self.a.var_60B1 == "stand")
	{
		self.abanglecutoff = 38;
	}
	else
	{
		self.abanglecutoff = 31;
	}

	var_00 = self.a.var_60B1;
	func_6E31(var_00);
	animscripts/combat::func_6E7C();
	var_01 = "none";
	if(animscripts/utility::hasenemysightpos())
	{
		var_01 = func_3A61(self.var_1FCA,animscripts/utility::func_3A97());
	}
	else
	{
		var_01 = func_3A61(self.var_1FCA);
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = "alert_to_" + var_01;
	if(!animscripts/utility::animarrayanyexist(var_02))
	{
		return 0;
	}

	var_03 = animscripts/utility::animarraypickrandom(var_02);
	if(var_01 == "lean" && !ispeekoutposclear())
	{
		return 0;
	}

	if(var_01 != "over" && !ispathclear(var_03,var_01 != "lean"))
	{
		return 0;
	}

	self.a.cornermode = var_01;
	self.a.prevattack = var_01;
	if(self.a.cornermode == "lean")
	{
		animscripts/combat::func_6E7C(self.var_1FCA);
	}

	if(var_01 == "A" || var_01 == "B")
	{
		self.a.var_78D0 = "cover_" + self.cornerdirection + "_" + self.a.var_60B1 + "_" + var_01;
	}
	else if(var_01 == "over")
	{
		self.a.var_78D0 = "cover_crouch_aim";
	}
	else
	{
		self.a.var_78D0 = "none";
	}

	self.keepclaimednodeifvalid = 1;
	var_04 = 0;
	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	var_05 = func_7BEB();
	self.pushable = 0;
	self setflaggedanimknoballrestart("stepout",var_03,%root,1,0.2,var_05);
	corner_playcornerfacialanim(var_03);
	thread donotetrackswithendon("stepout");
	var_04 = animhasnotetrack(var_03,"start_aim");
	if(var_04)
	{
		self.var_7BED = self.angles[1] + getangledelta(var_03,0,1);
		self waittillmatch("start_aim","stepout");
	}
	else
	{
		self waittillmatch("end","stepout");
	}

	if(var_01 == "B" && common_scripts\utility::func_1DE9() && self.cornerdirection == "right")
	{
		self.a.var_78D0 = "corner_right_martyrdom";
	}

	func_6E32(var_00);
	var_06 = var_01 == "over" || animscripts/utility::func_4965();
	func_7AC0(undefined,var_06,0.3);
	thread animscripts/track::trackshootentorpos();
	if(var_04)
	{
		self waittillmatch("end","stepout");
		self.var_7BED = undefined;
	}

	func_1AD9(undefined,1,0.2);
	self clearanim(%cover,0.1);
	self clearanim(%corner,0.1);
	self.changingcoverpos = 0;
	self.coverposestablishedtime = gettime();
	self.pushable = 1;
	return 1;
}

//Function Number: 21
func_7BEC()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.var_62FD) && randomfloat(1) < self.var_62FD)
	{
		if(func_62F8())
		{
			return 1;
		}
	}

	if(!func_7BEA())
	{
		return 0;
	}

	func_7430();
	if(isdefined(self.var_7445))
	{
		var_00 = lengthsquared(self.origin - self.var_7445);
		if(animscripts/utility::func_87FA() && animscripts/utility::func_74AE(var_00))
		{
			if(self.a.var_60B1 == "stand")
			{
				animscripts/shared::func_80AC(animscripts/utility::lookupanim("combat","drop_rpg_stand"));
			}
			else
			{
				animscripts/shared::func_80AC(animscripts/utility::lookupanim("combat","drop_rpg_crouch"));
			}

			thread func_6988();
		}
	}

	func_6689();
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 22
func_4033(param_00)
{
	if(!isdefined(self.var_4C90))
	{
		return 1;
	}

	return gettime() - self.var_4C90 > param_00 * 1000;
}

//Function Number: 23
func_62F8()
{
	if(!animscripts/utility::hasenemysightpos())
	{
		return 0;
	}

	var_00 = 0;
	var_01 = 90;
	var_02 = self.var_1FCA animscripts/utility::getyawtoorigin(animscripts/utility::func_3A97());
	if(self.cornerdirection == "left")
	{
		var_02 = 0 - var_02;
	}

	if(var_02 > 30)
	{
		var_01 = 45;
		if(self.cornerdirection == "left")
		{
			var_00 = 45;
		}
		else
		{
			var_00 = -45;
		}
	}

	var_03 = "rambo" + var_01;
	if(!animscripts/utility::animarrayanyexist(var_03))
	{
		return 0;
	}

	var_04 = animscripts/utility::animarraypickrandom(var_03);
	var_05 = getpredictedpathmidpoint(48);
	if(!self maymovetopoint(var_05,!self.swimmer))
	{
		return 0;
	}

	self.coverposestablishedtime = gettime();
	func_7017();
	self.keepclaimednodeifvalid = 1;
	self.var_4940 = 1;
	self.a.prevattack = "rambo";
	self.changingcoverpos = 1;
	thread animscripts/shared::func_62FA(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0,1);
	corner_playcornerfacialanim(var_04);
	animscripts/shared::func_2986("rambo");
	self notify("rambo_aim_end");
	self.changingcoverpos = 0;
	self.keepclaimednodeifvalid = 0;
	self.var_4C90 = gettime();
	self.changingcoverpos = 0;
	self.var_4940 = undefined;
	return 1;
}

//Function Number: 24
func_7430()
{
	maps\_gameskill::didsomethingotherthanshooting();
	for(;;)
	{
		for(;;)
		{
			if(isdefined(self.shouldreturntocover))
			{
				break;
			}

			if(!isdefined(self.var_7445))
			{
				self waittill("do_slow_things");
				waittillframeend;
				if(isdefined(self.var_7445))
				{
					continue;
				}

				break;
			}

			if(!self.bulletsinclip)
			{
				break;
			}

			if(func_7446())
			{
				if(!changestepoutpos())
				{
					if(getbeststepoutpos() == self.a.cornermode)
					{
						break;
					}

					func_7450(0.2);
					continue;
				}

				if(func_7446())
				{
					break;
				}

				continue;
			}

			func_744E(1);
			self clearanim(%add_fire,0.2);
		}

		if(canreturntocover(self.a.cornermode != "lean"))
		{
			break;
		}

		if(func_7446() && changestepoutpos())
		{
			continue;
		}

		func_7450(0.2);
	}
}

//Function Number: 25
func_7450(param_00)
{
	thread func_5731(param_00);
	var_01 = gettime();
	func_744E(0);
	self notify("stopNotifyStopShootingAfterTime");
	var_02 = gettime() - var_01 / 1000;
	if(var_02 < param_00)
	{
		wait(param_00 - var_02);
	}
}

//Function Number: 26
func_5731(param_00)
{
	self endon("killanimscript");
	self endon("stopNotifyStopShootingAfterTime");
	wait(param_00);
	self notify("stopShooting");
}

//Function Number: 27
func_744E(param_00)
{
	self endon("return_to_cover");
	if(param_00)
	{
		thread anglerangethread();
	}

	thread animscripts/combat_utility::aimidlethread();
	animscripts/combat_utility::func_744D();
}

//Function Number: 28
anglerangethread()
{
	self endon("killanimscript");
	self notify("newAngleRangeCheck");
	self endon("newAngleRangeCheck");
	self endon("take_cover_at_corner");
	for(;;)
	{
		if(func_7446())
		{
			break;
		}

		wait(0.1);
	}

	self notify("stopShooting");
}

//Function Number: 29
func_7524()
{
	self.enemy endon("death");
	self endon("enemy");
	self endon("stopshowstate");
	wait(0.05);
}

//Function Number: 30
canreturntocover(param_00)
{
	var_01 = !self.swimmer;
	if(param_00)
	{
		var_02 = getpredictedpathmidpoint();
		if(!self maymovetopoint(var_02,var_01))
		{
			return 0;
		}

		return self maymovefrompointtopoint(var_02,self.var_1FCA.origin,var_01);
	}

	return self maymovetopoint(self.var_1FCA.origin,var_02);
}

//Function Number: 31
func_6689()
{
	animscripts/combat_utility::func_2D52();
	var_00 = animscripts/utility::func_4979();
	self notify("take_cover_at_corner");
	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.cornermode + "_to_alert";
	var_02 = animscripts/utility::animarraypickrandom(var_01);
	func_7C5A(0.3);
	var_03 = 0;
	if(self.a.cornermode != "lean" && var_00 && animscripts/utility::animarrayanyexist(var_01 + "_reload") && randomfloat(100) < 75)
	{
		var_02 = animscripts/utility::animarraypickrandom(var_01 + "_reload");
		var_03 = 1;
	}

	var_04 = func_7BEB();
	if(animscripts/utility::func_4965())
	{
		self clearanim(%exposed_modern,0.2);
	}
	else
	{
		self clearanim(%body,0.1);
	}

	self setflaggedanimrestart("hide",var_02,1,0.1,var_04);
	corner_playcornerfacialanim(var_02);
	animscripts/shared::func_2986("hide");
	if(var_03)
	{
		animscripts/weaponlist::refillclip();
	}

	self.changingcoverpos = 0;
	if(self.cornerdirection == "up")
	{
		self.a.var_78D0 = "cover_up";
	}
	else if(self.cornerdirection == "left")
	{
		self.a.var_78D0 = "cover_left";
	}
	else
	{
		self.a.var_78D0 = "cover_right";
	}

	self.keepclaimednodeifvalid = 0;
	self clearanim(var_02,0.2);
}

//Function Number: 32
blindfire()
{
	if(!animscripts/utility::animarrayanyexist("blind_fire"))
	{
		return 0;
	}

	func_7017();
	self.keepclaimednodeifvalid = 1;
	var_00 = animscripts/utility::animarraypickrandom("blind_fire");
	self setflaggedanimknoballrestart("blindfire",var_00,%body,1,0,1);
	corner_playcornerfacialanim(var_00);
	animscripts/shared::func_2986("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 33
func_4E20(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = (1,1,1);
	}

	for(var_03 = 0;var_03 < 100;var_03++)
	{
		wait(0.05);
	}
}

//Function Number: 34
func_8407(param_00)
{
	return func_8406(param_00,1);
}

//Function Number: 35
func_8406(param_00,param_01)
{
	if(!self maymovetopoint(getpredictedpathmidpoint()))
	{
		return 0;
	}

	if(isdefined(self.var_29AA) || isdefined(param_00.var_29A1))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.var_62FD) && randomfloat(1) < self.var_62FD)
	{
		if(isdefined(self.a.var_ED8["grenade_rambo"]))
		{
			var_02 = animscripts/utility::animarray("grenade_rambo");
		}
	}

	if(!isdefined(var_02))
	{
		if(isdefined(param_01) && param_01)
		{
			if(!isdefined(self.a.var_ED8["grenade_safe"]))
			{
				return 0;
			}

			var_02 = animscripts/utility::animarray("grenade_safe");
		}
		else
		{
			if(!isdefined(self.a.var_ED8["grenade_exposed"]))
			{
				return 0;
			}

			var_02 = animscripts/utility::animarray("grenade_exposed");
		}
	}

	func_7017();
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts/combat_utility::func_8400(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 36
func_61B3()
{
}

//Function Number: 37
lookforenemy(param_00)
{
	if(!isdefined(self.a.var_ED8["alert_to_look"]))
	{
		return 0;
	}

	func_7017();
	self.keepclaimednodeifvalid = 1;
	if(!func_5B75())
	{
		return 0;
	}

	animscripts/shared::playlookanimation(animscripts/utility::animarray("look_idle"),param_00,::canstoppeeking);
	var_01 = undefined;
	if(animscripts/utility::func_4979())
	{
		var_01 = animscripts/utility::animarray("look_to_alert_fast");
	}
	else
	{
		var_01 = animscripts/utility::animarray("look_to_alert");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1,1);
	corner_playcornerfacialanim(var_01);
	animscripts/shared::func_2986("looking_end");
	func_7017();
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 38
ispeekoutposclear()
{
	var_00 = self.var_1FCA.angles;
	if(animscripts/utility::func_4965())
	{
		var_00 = animscripts/utility::gettruenodeangles(self.var_1FCA);
	}

	var_01 = self geteye();
	var_02 = anglestoright(var_00);
	var_03 = anglestoup(var_00);
	if(self.cornerdirection == "right")
	{
		var_01 = var_01 + var_02 * 30;
	}
	else if(self.cornerdirection == "left")
	{
		var_01 = var_01 - var_02 * 30;
	}
	else
	{
		var_01 = var_01 + var_03 * 30;
	}

	var_04 = var_01 + anglestoforward(var_00) * 30;
	return sighttracepassed(var_01,var_04,1,self);
}

//Function Number: 39
func_5B75()
{
	if(isdefined(self.var_1FCA.var_6B93))
	{
		return 0;
	}

	if(isdefined(self.nextpeekoutattempttime) && gettime() < self.nextpeekoutattempttime)
	{
		return 0;
	}

	if(!ispeekoutposclear())
	{
		self.nextpeekoutattempttime = gettime() + 3000;
		return 0;
	}

	var_00 = animscripts/utility::animarray("alert_to_look");
	self setflaggedanimknoball("looking_start",var_00,%body,1,0.2,1);
	corner_playcornerfacialanim(var_00);
	animscripts/shared::func_2986("looking_start");
	return 1;
}

//Function Number: 40
canstoppeeking()
{
	return self maymovetopoint(self.var_1FCA.origin,!self.swimmer);
}

//Function Number: 41
func_31EF()
{
	return 0;
}

//Function Number: 42
cornerreload()
{
	var_00 = animscripts/utility::animarraypickrandom("reload");
	self setflaggedanimknobrestart("cornerReload",var_00,1,0.2);
	corner_playcornerfacialanim(var_00);
	animscripts/shared::func_2986("cornerReload");
	self notify("abort_reload");
	animscripts/weaponlist::refillclip();
	self setanimrestart(animscripts/utility::animarray("alert_idle"),1,0.2);
	self clearanim(var_00,0.2);
	return 1;
}

//Function Number: 43
ispathclear(param_00,param_01)
{
	var_02 = !self.swimmer;
	if(param_01)
	{
		var_03 = getpredictedpathmidpoint();
		if(!self maymovetopoint(var_03,var_02))
		{
			return 0;
		}

		if(self.swimmer)
		{
			return 1;
		}

		return self maymovefrompointtopoint(var_03,animscripts/utility::func_3A23(param_00),var_02);
	}

	if(self.swimmer)
	{
		return 1;
	}

	return self maymovetopoint(animscripts/utility::func_3A23(param_01),var_03);
}

//Function Number: 44
getpredictedpathmidpoint(param_00)
{
	var_01 = self.var_1FCA.angles;
	var_02 = anglestoright(var_01);
	if(!isdefined(param_00))
	{
		param_00 = 36;
	}

	var_03 = self.script;
	if(var_03 == "cover_multi")
	{
		if(self.cover.state == "right")
		{
			var_03 = "cover_right";
		}
		else if(self.cover.state == "left")
		{
			var_03 = "cover_left";
		}
	}

	if(var_03 == "cover_swim_up")
	{
		var_04 = anglestoup(var_01);
		return self.var_1FCA.origin + var_04 * param_00;
	}

	switch(var_04)
	{
		case "cover_swim_left":
		case "cover_left":
			var_03 = var_03 * 0 - var_01;
			break;

		case "cover_swim_right":
		case "cover_right":
			var_03 = var_03 * var_01;
			break;

		default:
			break;
	}

	return self.var_1FCA.origin + (var_03[0],var_03[1],0);
}

//Function Number: 45
func_43C6()
{
	self endon("end_idle");
	for(;;)
	{
		var_00 = randomint(2) == 0 && isdefined(self.a.var_ED8["alert_idle_twitch"]) && animscripts/utility::animarrayanyexist("alert_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts/utility::animarraypickrandom("alert_idle_twitch");
		}
		else
		{
			var_01 = animscripts/utility::animarray("alert_idle");
		}

		func_6017(var_01,var_00);
	}
}

//Function Number: 46
func_3427()
{
	if(!animscripts/utility::animarrayanyexist("alert_idle_flinch"))
	{
		return 0;
	}

	func_6017(animscripts/utility::animarraypickrandom("alert_idle_flinch"),1);
	return 1;
}

//Function Number: 47
func_6017(param_00,param_01)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("idle",param_00,%body,1,0.1,1);
	}
	else
	{
		self setflaggedanimknoball("idle",param_00,%body,1,0.1,1);
	}

	corner_playcornerfacialanim(param_00);
	animscripts/shared::func_2986("idle");
}

//Function Number: 48
func_6E31(param_00)
{
	[[ self.animarrayfuncs["hiding"][param_00] ]]();
	[[ self.animarrayfuncs["exposed"][param_00] ]]();
}

//Function Number: 49
func_6E32(param_00)
{
	[[ self.animarrayfuncs["exposed"][param_00] ]]();
}

//Function Number: 50
func_8272(param_00)
{
	if(self.a.var_60B1 == param_00)
	{
		func_6E31(param_00);
	}

	var_01 = animscripts/utility::animarray("stance_change");
	self setflaggedanimknoballrestart("changeStance",var_01,%body);
	corner_playcornerfacialanim(var_01);
	func_6E31(param_00);
	animscripts/shared::func_2986("changeStance");
	wait(0.2);
}

//Function Number: 51
gotocover(param_00,param_01,param_02)
{
	var_03 = animscripts/utility::func_3B4A();
	var_04 = animscripts/utility::func_3A52();
	var_05 = var_03 + self.var_420F;
	if(animscripts/utility::func_4965())
	{
		self notify("force_space_rotation_update",0,0);
	}
	else
	{
		self orientmode("face angle",var_05);
	}

	self animmode("normal");
	if(isdefined(var_04))
	{
		thread animscripts/shared::func_54BF(var_04,param_01);
	}

	self setflaggedanimknoballrestart("coveranim",param_00,%body,1,param_01);
	corner_playcornerfacialanim(param_00);
	animscripts/notetracks::donotetracksfortime(param_02,"coveranim");
	while(animscripts/utility::absangleclamp180(self.angles[1] - var_05) > 1)
	{
		animscripts/notetracks::donotetracksfortime(0.1,"coveranim");
		var_03 = animscripts/utility::func_3B4A();
		var_05 = var_03 + self.var_420F;
	}

	func_7017();
	if(self.cornerdirection == "left")
	{
		self.a.var_78D0 = "cover_left";
	}

	if(self.cornerdirection == "right")
	{
		self.a.var_78D0 = "cover_right";
	}

	self.a.var_78D0 = "cover_up";
}

//Function Number: 52
drawoffset()
{
	self endon("killanimscript");
	wait(0.05);
}

//Function Number: 53
func_6F9B()
{
	if(self.swimmer && isdefined(self.node))
	{
		func_6FA2();
	}

	if(!isdefined(self.a.var_ED8))
	{
	}

	var_00 = animscripts/utility::func_4F5D("default_stand");
	self.a.var_ED8["add_aim_up"] = var_00["add_aim_up"];
	self.a.var_ED8["add_aim_down"] = var_00["add_aim_down"];
	self.a.var_ED8["add_aim_left"] = var_00["add_aim_left"];
	self.a.var_ED8["add_aim_right"] = var_00["add_aim_right"];
	self.a.var_ED8["add_turn_aim_up"] = var_00["add_turn_aim_up"];
	self.a.var_ED8["add_turn_aim_down"] = var_00["add_turn_aim_down"];
	self.a.var_ED8["add_turn_aim_left"] = var_00["add_turn_aim_left"];
	self.a.var_ED8["add_turn_aim_right"] = var_00["add_turn_aim_right"];
	self.a.var_ED8["straight_level"] = var_00["straight_level"];
	if(self.a.cornermode == "lean")
	{
		var_01 = self.a.var_ED8["lean_fire"];
		var_02 = self.a.var_ED8["lean_single"];
		self.a.var_ED8["fire"] = var_01;
		self.a.var_ED8["single"] = animscripts/utility::func_ED8(var_02);
		self.a.var_ED8["semi2"] = var_02;
		self.a.var_ED8["semi3"] = var_02;
		self.a.var_ED8["semi4"] = var_02;
		self.a.var_ED8["semi5"] = var_02;
		self.a.var_ED8["burst2"] = var_01;
		self.a.var_ED8["burst3"] = var_01;
		self.a.var_ED8["burst4"] = var_01;
		self.a.var_ED8["burst5"] = var_01;
		self.a.var_ED8["burst6"] = var_01;
	}
	else
	{
		self.a.var_ED8["fire"] = var_00["fire_corner"];
		self.a.var_ED8["semi2"] = var_00["semi2"];
		self.a.var_ED8["semi3"] = var_00["semi3"];
		self.a.var_ED8["semi4"] = var_00["semi4"];
		self.a.var_ED8["semi5"] = var_00["semi5"];
		if(animscripts/utility::func_8D9B())
		{
			self.a.var_ED8["single"] = animscripts/utility::lookupanim("shotgun_stand","single");
		}
		else
		{
			self.a.var_ED8["single"] = var_00["single"];
		}

		self.a.var_ED8["burst2"] = var_00["burst2"];
		self.a.var_ED8["burst3"] = var_00["burst3"];
		self.a.var_ED8["burst4"] = var_00["burst4"];
		self.a.var_ED8["burst5"] = var_00["burst5"];
		self.a.var_ED8["burst6"] = var_00["burst6"];
	}

	self.a.var_ED8["exposed_idle"] = var_00["exposed_idle"];
}

//Function Number: 54
func_6E69()
{
	if(self.swimmer && isdefined(self.node))
	{
		func_6FA2();
	}

	if(!isdefined(self.a.var_ED8))
	{
	}

	var_00 = animscripts/utility::func_4F5D("default_crouch");
	var_01["add_aim_up"] = animscripts/utility::lookupanim("cover_crouch","add_aim_up");
	var_02["add_aim_up"] = animscripts/utility::lookupanim("cover_crouch","add_aim_up");
	var_03[0] = animscripts/utility::lookupanim("cover_crouch","add_aim_up");
	if(self.a.cornermode == "over")
	{
		self.a.var_ED8["add_aim_up"] = animscripts/utility::lookupanim("cover_crouch","add_aim_up");
		self.a.var_ED8["add_aim_down"] = animscripts/utility::lookupanim("cover_crouch","add_aim_down");
		self.a.var_ED8["add_aim_left"] = animscripts/utility::lookupanim("cover_crouch","add_aim_left");
		self.a.var_ED8["add_aim_right"] = animscripts/utility::lookupanim("cover_crouch","add_aim_right");
		self.a.var_ED8["straight_level"] = animscripts/utility::lookupanim("cover_crouch","straight_level");
		self.a.var_ED8["exposed_idle"] = animscripts/utility::lookupanim("default_stand","exposed_idle");
	}

	if(self.a.cornermode == "lean")
	{
		var_04 = self.a.var_ED8["lean_fire"];
		var_05 = self.a.var_ED8["lean_single"];
		self.a.var_ED8["fire"] = var_04;
		self.a.var_ED8["single"] = animscripts/utility::func_ED8(var_05);
		self.a.var_ED8["semi2"] = var_05;
		self.a.var_ED8["semi3"] = var_05;
		self.a.var_ED8["semi4"] = var_05;
		self.a.var_ED8["semi5"] = var_05;
		self.a.var_ED8["burst2"] = var_04;
		self.a.var_ED8["burst3"] = var_04;
		self.a.var_ED8["burst4"] = var_04;
		self.a.var_ED8["burst5"] = var_04;
		self.a.var_ED8["burst6"] = var_04;
	}
	else
	{
		self.a.var_ED8["fire"] = var_00["fire"];
		self.a.var_ED8["semi2"] = var_00["semi2"];
		self.a.var_ED8["semi3"] = var_00["semi3"];
		self.a.var_ED8["semi4"] = var_00["semi4"];
		self.a.var_ED8["semi5"] = var_00["semi5"];
		if(animscripts/utility::func_8D9B())
		{
			self.a.var_ED8["single"] = animscripts/utility::lookupanim("shotgun_crouch","single");
		}
		else
		{
			self.a.var_ED8["single"] = var_00["single"];
		}

		self.a.var_ED8["burst2"] = var_00["burst2"];
		self.a.var_ED8["burst3"] = var_00["burst3"];
		self.a.var_ED8["burst4"] = var_00["burst4"];
		self.a.var_ED8["burst5"] = var_00["burst5"];
		self.a.var_ED8["burst6"] = var_00["burst6"];
	}

	self.a.var_ED8["add_aim_up"] = var_00["add_aim_up"];
	self.a.var_ED8["add_aim_down"] = var_00["add_aim_down"];
	self.a.var_ED8["add_aim_left"] = var_00["add_aim_left"];
	self.a.var_ED8["add_aim_right"] = var_00["add_aim_right"];
	self.a.var_ED8["add_turn_aim_up"] = var_00["add_turn_aim_up"];
	self.a.var_ED8["add_turn_aim_down"] = var_00["add_turn_aim_down"];
	self.a.var_ED8["add_turn_aim_left"] = var_00["add_turn_aim_left"];
	self.a.var_ED8["add_turn_aim_right"] = var_00["add_turn_aim_right"];
	self.a.var_ED8["straight_level"] = var_00["straight_level"];
	self.a.var_ED8["exposed_idle"] = var_00["exposed_idle"];
}

//Function Number: 55
func_6FA2()
{
	if(!isdefined(self.a.var_ED8))
	{
	}

	var_00 = [];
	if(self.var_EB9 == "cover_corner_r")
	{
		var_00 = animscripts/swim::func_3C1D("cover_corner_r");
	}
	else if(self.var_EB9 == "cover_corner_l")
	{
		var_00 = animscripts/swim::func_3C1D("cover_corner_l");
	}
	else if(self.var_EB9 == "cover_u")
	{
		var_00 = animscripts/swim::func_3C1D("cover_u");
	}
	else if(self.var_EB9 == "exposed")
	{
		var_00 = animscripts/swim::func_3C1D("exposed");
	}
	else
	{
	}

	self.a.var_ED8["add_aim_up"] = var_00["add_aim_up"];
	self.a.var_ED8["add_aim_down"] = var_00["add_aim_down"];
	self.a.var_ED8["add_aim_left"] = var_00["add_aim_left"];
	self.a.var_ED8["add_aim_right"] = var_00["add_aim_right"];
	self.a.var_ED8["add_turn_aim_up"] = var_00["add_aim_up"];
	self.a.var_ED8["add_turn_aim_down"] = var_00["add_aim_down"];
	self.a.var_ED8["add_turn_aim_left"] = var_00["add_aim_left"];
	self.a.var_ED8["add_turn_aim_right"] = var_00["add_aim_right"];
	self.a.var_ED8["straight_level"] = var_00["straight_level"];
	self.a.var_ED8["fire"] = var_00["add_aim_straight"];
	self.a.var_ED8["semi2"] = var_00["add_aim_straight"];
	self.a.var_ED8["semi3"] = var_00["add_aim_straight"];
	self.a.var_ED8["semi4"] = var_00["add_aim_straight"];
	self.a.var_ED8["semi5"] = var_00["add_aim_straight"];
	self.a.var_ED8["single"] = animscripts/utility::func_ED8(var_00["add_aim_straight"]);
	self.a.var_ED8["burst2"] = var_00["add_aim_straight"];
	self.a.var_ED8["burst3"] = var_00["add_aim_straight"];
	self.a.var_ED8["burst4"] = var_00["add_aim_straight"];
	self.a.var_ED8["burst5"] = var_00["add_aim_straight"];
	self.a.var_ED8["burst6"] = var_00["add_aim_straight"];
	self.a.var_ED8["exposed_idle"] = animscripts/utility::func_ED8(var_00["add_aim_idle"]);
}

//Function Number: 56
func_6988()
{
	self notify("killanimscript");
	thread animscripts/combat::func_4FDD();
}

//Function Number: 57
func_7017()
{
	if(self.swimmer)
	{
		self animmode("nogravity");
	}

	self animmode("zonly_physics");
}

//Function Number: 58
corner_playcornerfacialanim(param_00)
{
	if(self.cornerdirection == "left")
	{
		var_01 = "corner_stand_L";
	}
	else
	{
		var_01 = "corner_stand_R";
	}

	self.facialidx = animscripts/face::func_6004(param_00,var_01,self.facialidx);
}

//Function Number: 59
corner_playaimfacialanim(param_00)
{
	self.facialidx = animscripts/face::func_6004(param_00,"aim",self.facialidx);
}

//Function Number: 60
corner_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}