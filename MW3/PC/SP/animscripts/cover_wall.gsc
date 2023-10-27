/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_wall.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 592 ms
 * Timestamp: 10/27/2023 2:18:14 AM
*******************************************************************/

//Function Number: 1
func_0F76(param_00)
{
	self endon("killanimscript");
	self.var_CAF = self.node;
	self.var_F77 = param_00;
	if(!isdefined(self.node.turret))
	{
		animscripts/cover_behavior::func_F71(0);
	}

	if(param_00 == "crouch")
	{
		func_0F81("unknown");
		self.var_CAF func_0F7F();
	}
	else
	{
		func_0F82("unknown");
	}

	self.a.aimidlethread = undefined;
	self orientmode("face angle",self.var_CAF.angles[1]);
	if(isdefined(self.weapon) && animscripts/utility::func_F79() && isdefined(self.node) && isdefined(self.node.turretinfo) && canspawnturret())
	{
		if(param_00 == "crouch")
		{
			if(func_0F7E(self.weapon))
			{
				var_01 = "rpd_bipod_crouch";
			}
			else
			{
				var_01 = "saw_bipod_crouch";
			}
		}
		else if(func_0F7E(self.weapon))
		{
			var_01 = "rpd_bipod_stand";
		}
		else
		{
			var_01 = "saw_bipod_stand";
		}

		if(func_0F7E(self.weapon))
		{
			var_02 = "weapon_rpd_MG_Setup";
		}
		else
		{
			var_02 = "weapon_saw_MG_Setup";
		}

		func_0FA5(var_01,var_02);
	}
	else if(isdefined(self.node) && isdefined(self.node.turret))
	{
		func_0FA7();
	}

	self animmode("normal");
	if(param_00 == "crouch" && self.a.pose == "stand")
	{
		var_03 = animscripts/utility::func_D4D("stand_2_hide");
		var_04 = getanimlength(var_03);
		self setanimknoballrestart(var_03,%body,1,0.2,animscripts/combat_utility::func_F7B());
		thread animscripts/shared::func_F7C(self.var_CAF.origin,var_04);
		wait var_04;
		self.a.var_CF8 = "hide";
	}
	else
	{
		func_0FB2(0.4);
		if(distancesquared(self.origin,self.var_CAF.origin) > 1)
		{
			thread animscripts/shared::func_F7C(self.var_CAF.origin,0.4);
			wait 0.2;
			if(param_00 == "crouch")
			{
				self.a.pose = "crouch";
			}

			wait 0.2;
		}
		else
		{
			wait 0.1;
		}
	}

	self animmode("zonly_physics");
	if(param_00 == "crouch")
	{
		if(self.a.pose == "prone")
		{
			animscripts/utility::func_F7D(1);
		}

		self.a.pose = "crouch";
	}

	if(self.var_F77 == "stand")
	{
		self.a.var_D19 = "cover_stand";
	}
	else
	{
		self.a.var_D19 = "cover_crouch";
	}

	var_05 = spawnstruct();
	if(!self.fixednode)
	{
		var_05.var_F37 = ::animscripts/cover_behavior::func_F37;
	}

	var_05.var_F54 = ::func_0F52;
	var_05.var_F55 = ::func_0F83;
	var_05.var_7A8 = ::func_07A8;
	var_05.var_F57 = ::func_0F57;
	var_05.idle = ::idle;
	var_05.var_F5B = ::func_0F5B;
	var_05.var_73C = ::func_0F61;
	var_05.var_F63 = ::func_0F9E;
	var_05.var_F64 = ::func_0F64;
	animscripts/cover_behavior::main(var_05);
}

//Function Number: 2
func_0F7E(param_00)
{
	return getsubstr(param_00,0,3) == "rpd" && param_00.size == 3 || param_00[3] == "_";
}

//Function Number: 3
func_0F7F()
{
	if(isdefined(self.var_F80))
	{
		return;
	}

	var_00 = (0,0,42);
	var_01 = anglestoforward(self.angles);
	self.var_F80 = sighttracepassed(self.origin + var_00,self.origin + var_00 + var_01 * 64,0,undefined);
}

//Function Number: 4
func_0F81(param_00)
{
	self setdefaultaimlimits(self.var_CAF);
	func_0FA9(param_00);
}

//Function Number: 5
func_0F82(param_00)
{
	self setdefaultaimlimits(self.var_CAF);
	func_0FAE(param_00);
}

//Function Number: 6
func_0F52()
{
	animscripts/combat_utility::func_F54(2,animscripts/utility::func_D4D("reload"));
	return 1;
}

//Function Number: 7
func_0F83()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(func_0F8B())
		{
			return 1;
		}
	}

	if(!func_0F98())
	{
		return 0;
	}

	func_0F88();
	animscripts/combat_utility::func_F85();
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
		}
	}

	func_0F9C();
	self.var_CAC = undefined;
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 8
func_0F88()
{
	self endon("return_to_cover");
	maps\_gameskill::didsomethingotherthanshooting();
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

		if(self.var_F77 == "crouch" && func_0FB4())
		{
			break;
		}

		func_0F8A();
		self clearanim(%add_fire,0.2);
	}
}

//Function Number: 9
func_0F8A()
{
	if(self.var_F77 == "crouch")
	{
		thread func_0FB3();
	}

	thread animscripts/combat_utility::aimidlethread();
	animscripts/combat_utility::func_F06();
}

//Function Number: 10
func_0F8B()
{
	if(!animscripts/utility::func_F8C())
	{
		return 0;
	}

	var_00 = "rambo";
	if(randomint(10) < 2)
	{
		var_00 = "rambo_fail";
	}

	if(!animscripts/utility::func_F8D(var_00))
	{
		return 0;
	}

	if(self.var_F77 == "crouch" && !self.var_CAF.var_F80)
	{
		return 0;
	}

	var_01 = func_0FB7(self.var_CAF.origin + animscripts/utility::func_F8E(self.var_CAF));
	if(var_01 > 15)
	{
		return 0;
	}

	var_02 = anglestoforward(self.angles);
	var_03 = self.origin + var_02 * -16;
	if(!self maymovetopoint(var_03))
	{
		return 0;
	}

	self.var_CFD = gettime();
	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self.isrambo = 1;
	self.a.var_F3E = "rambo";
	self.var_CDD = 1;
	thread animscripts/shared::func_F90(0);
	var_04 = animscripts/utility::func_CA8(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0.2,1);
	animscripts/shared::donotetracks("rambo");
	self notify("rambo_aim_end");
	self.var_CDD = 0;
	self.keepclaimednodeifvalid = 0;
	self.var_F91 = gettime();
	self.var_CDD = 0;
	self.isrambo = undefined;
	return 1;
}

//Function Number: 11
idle()
{
	self endon("end_idle");
	for(;;)
	{
		var_00 = randomint(2) == 0 && animscripts/utility::func_F8D("hide_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts/utility::func_CA8("hide_idle_twitch");
		}
		else
		{
			var_01 = animscripts/utility::func_D4D("hide_idle");
		}

		func_0F92(var_01,var_00);
	}
}

//Function Number: 12
func_0F5B()
{
	if(!animscripts/utility::func_F8D("hide_idle_flinch"))
	{
		return 0;
	}

	var_00 = anglestoforward(self.angles);
	var_01 = self.origin + var_00 * -16;
	if(!self maymovetopoint(var_01))
	{
		return 0;
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_02 = animscripts/utility::func_CA8("hide_idle_flinch");
	func_0F92(var_02,1);
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 13
func_0F92(param_00,param_01)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("idle",param_00,%body,1,0.25,1);
	}
	else
	{
		self setflaggedanimknoball("idle",param_00,%body,1,0.25,1);
	}

	self.a.var_CF8 = "hide";
	animscripts/shared::donotetracks("idle");
}

//Function Number: 14
func_07A8(param_00)
{
	if(!isdefined(self.a.array["hide_to_look"]))
	{
		return 0;
	}

	if(!func_0F94())
	{
		return 0;
	}

	animscripts/shared::func_F93(animscripts/utility::func_D4D("look_idle"),param_00);
	var_01 = undefined;
	if(animscripts/utility::func_F4C())
	{
		var_01 = animscripts/utility::func_D4D("look_to_hide_fast");
	}
	else
	{
		var_01 = animscripts/utility::func_D4D("look_to_hide");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1);
	animscripts/shared::donotetracks("looking_end");
	return 1;
}

//Function Number: 15
func_0F94()
{
	if(isdefined(self.var_CAF.var_F95))
	{
		return 0;
	}

	self setflaggedanimknoball("looking_start",animscripts/utility::func_D4D("hide_to_look"),%body,1,0.2);
	animscripts/shared::donotetracks("looking_start");
	return 1;
}

//Function Number: 16
func_0F57()
{
	self setflaggedanimknoballrestart("look",animscripts/utility::func_CA8("look"),%body,1,0.1);
	animscripts/shared::donotetracks("look");
	return 1;
}

//Function Number: 17
func_0F96()
{
	if(self.a.var_CF8 == "left" || self.a.var_CF8 == "right" || self.a.var_CF8 == "over")
	{
		return 1;
	}

	return animscripts/combat_utility::func_F97();
}

//Function Number: 18
func_0F98()
{
	var_00 = func_0FB5();
	var_01 = 0.1;
	var_02 = animscripts/utility::func_D4D("hide_2_" + var_00);
	if(!self maymovetopoint(animscripts/utility::func_F99(var_02)))
	{
		return 0;
	}

	if(self.script == "cover_crouch" && var_00 == "lean")
	{
		self.var_CAC = 1;
	}

	if(self.var_F77 == "crouch")
	{
		func_0F81(var_00);
	}
	else
	{
		func_0F82(var_00);
	}

	self.a.var_D19 = "none";
	self.var_D4B = undefined;
	if(self.var_F77 == "stand")
	{
		self.a.var_D19 = "cover_stand_aim";
	}
	else
	{
		self.a.var_D19 = "cover_crouch_aim";
	}

	self.var_CDD = 1;
	self notify("done_changing_cover_pos");
	self animmode("zonly_physics");
	var_03 = func_0F96();
	self setflaggedanimknoballrestart("pop_up",var_02,%body,1,0.1,var_03);
	thread func_0F9A("pop_up");
	if(animhasnotetrack(var_02,"start_aim"))
	{
		self waittillmatch("start_aim","pop_up");
		var_01 = getanimlength(var_02) / var_03 * 1 - self getanimtime(var_02);
	}
	else
	{
		self waittillmatch("end","pop_up");
		var_01 = 0.1;
	}

	self clearanim(var_02,var_01 + 0.05);
	self.a.var_CF8 = var_00;
	self.a.var_F3E = var_00;
	func_0F9B(var_01);
	thread animscripts/track::func_CA9();
	wait var_01;
	if(animscripts/combat_utility::issniper())
	{
		thread animscripts/shoot_behavior::func_D0C();
	}

	self.var_CDD = 0;
	self.var_CFD = gettime();
	self notify("stop_popup_donotetracks");
	return 1;
}

//Function Number: 19
func_0F9A(param_00)
{
	self endon("killanimscript");
	self endon("stop_popup_donotetracks");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 20
func_0F9B(param_00)
{
	if(self.a.var_CF8 == "left" || self.a.var_CF8 == "right")
	{
		var_01 = "crouch";
	}
	else
	{
		var_01 = self.a.var_CF8;
	}

	self setanimknoball(animscripts/utility::func_D4D(var_01 + "_aim"),%body,1,param_00);
	if(var_01 == "crouch")
	{
		self setanimlimited(%covercrouch_aim2_add,1,0);
		self setanimlimited(%covercrouch_aim4_add,1,0);
		self setanimlimited(%covercrouch_aim6_add,1,0);
		self setanimlimited(%covercrouch_aim8_add,1,0);
		return;
	}

	if(var_01 == "stand")
	{
		self setanimlimited(%exposed_aim_2,1,0);
		self setanimlimited(%exposed_aim_4,1,0);
		self setanimlimited(%exposed_aim_6,1,0);
		self setanimlimited(%exposed_aim_8,1,0);
		return;
	}

	if(var_01 == "lean")
	{
		self setanimlimited(%exposed_aim_2,1,0);
		self setanimlimited(%exposed_aim_4,1,0);
		self setanimlimited(%exposed_aim_6,1,0);
		self setanimlimited(%exposed_aim_8,1,0);
		return;
	}

	if(var_01 == "over")
	{
		self setanimlimited(%coverstandaim_aim2_add,1,0);
		self setanimlimited(%coverstandaim_aim4_add,1,0);
		self setanimlimited(%coverstandaim_aim6_add,1,0);
		self setanimlimited(%coverstandaim_aim8_add,1,0);
		return;
	}
}

//Function Number: 21
func_0F9C()
{
	self notify("return_to_cover");
	self.var_CDD = 1;
	self notify("done_changing_cover_pos");
	animscripts/combat_utility::func_F9D();
	var_00 = func_0F96();
	self setflaggedanimknoball("go_to_hide",animscripts/utility::func_D4D(self.a.var_CF8 + "_2_hide"),%body,1,0.2,var_00);
	self clearanim(%exposed_modern,0.2);
	animscripts/shared::donotetracks("go_to_hide");
	self.a.var_CF8 = "hide";
	if(self.var_F77 == "stand")
	{
		self.a.var_D19 = "cover_stand";
	}
	else
	{
		self.a.var_D19 = "cover_crouch";
	}

	self.var_CDD = 0;
}

//Function Number: 22
func_0F9E(param_00)
{
	return func_0F61(param_00,1);
}

//Function Number: 23
func_0F61(param_00,param_01)
{
	if(isdefined(self.dontevershoot) || isdefined(param_00.var_FA0))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		var_02 = animscripts/utility::func_CA8("grenade_rambo");
	}
	else if(isdefined(param_01) && param_01)
	{
		var_02 = animscripts/utility::func_CA8("grenade_safe");
	}
	else
	{
		var_02 = animscripts/utility::func_CA8("grenade_exposed");
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts/combat_utility::func_FA1(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 24
func_0F64()
{
	if(!animscripts/utility::func_F8D("blind_fire"))
	{
		return 0;
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self setflaggedanimknoballrestart("blindfire",animscripts/utility::func_CA8("blind_fire"),%body,1,0.2,1);
	animscripts/shared::donotetracks("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 25
func_0FA2(param_00,param_01,param_02)
{
	var_03 = spawnturret("misc_turret",param_00.origin,param_01);
	var_03.angles = param_00.angles;
	var_03.var_FA3 = self;
	var_03 setmodel(param_02);
	var_03 makeusable();
	var_03 setdefaultdroppitch(0);
	if(isdefined(param_00.leftarc))
	{
		var_03.leftarc = param_00.leftarc;
	}

	if(isdefined(param_00.rightarc))
	{
		var_03.rightarc = param_00.rightarc;
	}

	if(isdefined(param_00.toparc))
	{
		var_03.toparc = param_00.toparc;
	}

	if(isdefined(param_00.bottomarc))
	{
		var_03.bottomarc = param_00.bottomarc;
	}

	return var_03;
}

//Function Number: 26
func_0FA4(param_00)
{
	self endon("death");
	self endon("being_used");
	wait 0.1;
	if(isdefined(param_00))
	{
		param_00 notify("turret_use_failed");
	}

	self delete();
}

//Function Number: 27
func_0FA5(param_00,param_01)
{
	var_02 = func_0FA2(self.node.turretinfo,param_00,param_01);
	if(self useturret(var_02))
	{
		var_02 thread func_0FA4(self);
		if(isdefined(self.var_FA6))
		{
			thread [[ self.var_FA6 ]](var_02);
		}

		self waittill("turret_use_failed");
		return;
	}

	var_02 delete();
}

//Function Number: 28
func_0FA7()
{
	var_00 = self.node.turret;
	if(!var_00.issetup)
	{
		return;
	}

	thread maps\_mg_penetration::gunner_think(var_00);
	self waittill("continue_cover_script");
}

//Function Number: 29
func_0FA9(param_00)
{
	var_01 = [];
	if(animscripts/utility::func_C97())
	{
		if(var_01 == "lean" || var_01 == "stand")
		{
		}
		else
		{
		}
	}
	else
	{
	}

	if(isdefined(level.ramboanims))
	{
	}

	self.a.array = var_7B;
}

//Function Number: 30
func_0FAE(param_00)
{
	var_01 = [];
	if(var_01 == "over")
	{
	}
	else if(animscripts/utility::func_C97())
	{
	}
	else
	{
	}

	if(isdefined(level.ramboanims))
	{
	}

	self.a.array = var_7B;
}

//Function Number: 31
func_0FB2(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.1;
	}

	self setanimknoballrestart(animscripts/utility::func_D4D("hide_idle"),%body,1,param_00);
	self.a.var_CF8 = "hide";
}

//Function Number: 32
func_0FB3()
{
	self endon("killanimscript");
	self notify("newAngleRangeCheck");
	self endon("newAngleRangeCheck");
	self endon("return_to_cover");
	for(;;)
	{
		if(func_0FB4())
		{
			break;
		}

		wait 0.1;
	}

	self notify("stopShooting");
}

//Function Number: 33
func_0FB4()
{
	if(self.var_F77 != "crouch")
	{
		return 0;
	}

	var_00 = func_0FB7(self geteye());
	if(self.a.var_CF8 == "lean")
	{
		return var_00 < 10;
	}

	return var_00 > 45;
}

//Function Number: 34
func_0FB5()
{
	var_00 = [];
	if(self.var_F77 == "stand")
	{
		var_00 = self.var_CAF getvalidcoverpeekouts();
	}
	else
	{
		var_01 = func_0FB7(self.var_CAF.origin + animscripts/utility::func_F8E(self.var_CAF));
		if(var_01 > 30)
		{
			return "lean";
		}

		if(var_01 > 15 || !self.var_CAF.var_F80)
		{
			return "stand";
		}

		var_7B = self.var_CAF getvalidcoverpeekouts();
		var_7B[var_7B.size] = "crouch";
	}

	return animscripts/combat_utility::func_FB6(var_7B);
}

//Function Number: 35
func_0FB7(param_00)
{
	var_01 = animscripts/utility::func_FB8();
	return angleclamp180(vectortoangles(var_01 - param_00)[0]);
}