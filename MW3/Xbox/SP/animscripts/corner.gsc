/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\corner.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 55
 * Decompile Time: 961 ms
 * Timestamp: 10/27/2023 2:30:08 AM
*******************************************************************/

//Function Number: 1
corner_think(param_00,param_01)
{
	self endon("killanimscript");
	self.animarrayfuncs["exposed"]["stand"] = ::set_standing_animarray_aiming;
	self.animarrayfuncs["exposed"]["crouch"] = ::set_crouching_animarray_aiming;
	self.covernode = self.node;
	self.var_1FC6 = param_00;
	self.a.var_899 = "unknown";
	self.a.aimidlethread = undefined;
	animscripts/cover_behavior::func_B5C(param_01);
	func_1FCC();
	self.var_1FC7 = 0;
	self.var_1FC8 = 0;
	self.var_1FC9 = 0;
	animscripts/track::setanimaimweight(0);
	self.havegonetocover = 0;
	var_02 = spawnstruct();
	if(!self.fixednode)
	{
		var_02.var_B22 = ::animscripts/cover_behavior::func_B22;
	}

	var_02.mainloopstart = ::mainloopstart;
	var_02.reload = ::cornerreload;
	var_02.leavecoverandshoot = ::func_1FE0;
	var_02.look = ::lookforenemy;
	var_02.fastlook = ::fastlook;
	var_02.idle = ::idle;
	var_02.grenade = ::trythrowinggrenade;
	var_02.grenadehidden = ::trythrowinggrenadestayhidden;
	var_02.blindfire = ::blindfire;
	animscripts/cover_behavior::main(var_02);
}

//Function Number: 2
func_1FCB()
{
	self.stepoutyaw = undefined;
	self.a.var_1EFE = undefined;
}

//Function Number: 3
func_1FCC()
{
	if(self.a.var_911 == "crouch")
	{
		set_anim_array("crouch");
		return;
	}

	if(self.a.var_911 == "stand")
	{
		set_anim_array("stand");
		return;
	}

	animscripts/utility::exitpronewrapper(1);
	self.a.var_911 = "crouch";
	set_anim_array("crouch");
}

//Function Number: 4
shouldchangestanceforfun()
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
		if(isdefined(self.rambochance) && self.a.var_911 == "stand")
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
	if(self.a.var_911 == "crouch")
	{
		var_00 = "crouch";
		if(self.covernode doesnodeallowstance("stand"))
		{
			if(!self.covernode doesnodeallowstance("crouch") || shouldchangestanceforfun())
			{
				var_00 = "stand";
			}
		}
	}
	else if(self.covernode doesnodeallowstance("crouch"))
	{
		if(!self.covernode doesnodeallowstance("stand") || shouldchangestanceforfun())
		{
			var_00 = "crouch";
		}
	}

	if(self.havegonetocover)
	{
		func_1FF2(var_00);
		return;
	}

	if(self.a.var_911 == var_00)
	{
		gotocover(animscripts/utility::animarray("alert_idle"),0.3,0.4);
	}
	else
	{
		var_01 = animscripts/utility::animarray("stance_change");
		gotocover(var_01,0.3,getanimlength(var_01));
		set_anim_array(var_00);
	}

	self.havegonetocover = 1;
}

//Function Number: 6
func_1FCF()
{
	wait 2;
	for(;;)
	{
		printyawtoenemy();
		wait 0.05;
	}
}

//Function Number: 7
canseepointfromexposedatcorner(param_00,param_01)
{
	var_02 = param_01 animscripts/utility::func_1FD1(param_00);
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
shootposoutsidelegalyawrange()
{
	if(!isdefined(self.shootpos))
	{
		return 0;
	}

	var_00 = self.covernode animscripts/utility::func_1FD1(self.shootpos);
	if(self.a.var_899 == "over")
	{
		return var_00 < self.leftaimlimit || self.rightaimlimit < var_00;
	}

	if(self.var_1FC6 == "left")
	{
		if(self.a.var_899 == "B")
		{
			return var_00 < 0 - self.var_1FD3 || var_00 > 14;
		}

		if(self.a.var_899 == "A")
		{
			return var_00 > 0 - self.var_1FD3;
		}

		return var_00 < -50 || var_00 > 8;
	}

	if(self.a.var_899 == "B")
	{
		return var_00 > self.var_1FD3 || var_00 < -12;
	}

	if(self.a.var_899 == "A")
	{
		return var_00 < self.var_1FD3;
	}

	return var_00 > 50 || var_00 < -8;
}

//Function Number: 9
func_1FD4(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_00 animscripts/utility::func_1FD1(param_01);
	}

	var_04 = [];
	if(isdefined(param_00) && self.a.var_911 == "crouch" && var_03 > self.leftaimlimit && self.rightaimlimit > var_03)
	{
		var_04 = param_00 getvalidcoverpeekouts();
	}

	if(self.var_1FC6 == "left")
	{
		if(func_1FD7(var_03,-40,0))
		{
			var_02 = shouldlean();
		}

		if(!var_03 && var_04 < 14)
		{
			if(var_04 < 0 - self.var_1FD3)
			{
			}
			else
			{
			}
		}
	}
	else
	{
		if(func_1FD7(var_04,0,40))
		{
			var_03 = shouldlean();
		}

		if(!var_03 && var_04 > -12)
		{
			if(var_04 > self.var_1FD3)
			{
			}
			else
			{
			}
		}
	}

	return animscripts/combat_utility::getrandomcovermode(var_41);
}

//Function Number: 10
func_1FD5()
{
	var_00 = 0;
	if(animscripts/utility::cansuppressenemy())
	{
		var_00 = self.covernode animscripts/utility::func_1FD1(animscripts/utility::getenemysightpos());
	}
	else if(self.doingambush && isdefined(self.shootpos))
	{
		var_00 = self.covernode animscripts/utility::func_1FD1(self.shootpos);
	}

	if(self.a.var_899 == "lean")
	{
		return "lean";
	}

	if(self.a.var_899 == "over")
	{
		return "over";
	}

	if(self.a.var_899 == "B")
	{
		if(self.var_1FC6 == "left")
		{
			if(var_00 < 0 - self.var_1FD3)
			{
				return "A";
			}
		}
		else if(self.var_1FC6 == "right")
		{
			if(var_00 > self.var_1FD3)
			{
				return "A";
			}
		}

		return "B";
	}

	if(self.a.var_899 == "A")
	{
		var_02 = "B";
		if(self.var_1FC6 == "left")
		{
			if(var_00 > 0 - self.var_1FD3)
			{
				return "B";
			}
		}
		else if(self.var_1FC6 == "right")
		{
			if(var_00 < self.var_1FD3)
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
	var_00 = func_1FD5();
	if(var_00 == self.a.var_899)
	{
		return 0;
	}

	self.var_8C8 = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.var_899 + "_to_" + var_00;
	var_02 = animscripts/utility::animarraypickrandom(var_01);
	var_03 = func_1FEF();
	if(!self maymovetopoint(var_03))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_03,animscripts/utility::getanimendpos(var_02)))
	{
		return 0;
	}

	animscripts/combat_utility::endaimidlethread();
	stopaiming(0.3);
	var_04 = self.a.var_911;
	self setanimlimited(animscripts/utility::animarray("straight_level"),0,0.2);
	self setflaggedanimknob("changeStepOutPos",var_02,1,0.2,1.2);
	thread donotetrackswithendon("changeStepOutPos");
	if(animhasnotetrack(var_02,"start_aim"))
	{
		self waittillmatch("start_aim","changeStepOutPos");
	}
	else
	{
		self waittillmatch("end","changeStepOutPos");
	}

	thread startaiming(undefined,0,0.3);
	self waittillmatch("end","changeStepOutPos");
	self clearanim(var_02,0.1);
	self.a.var_899 = var_00;
	self.var_8C8 = 0;
	self.var_8E8 = gettime();
	if(self.a.var_911 != var_04)
	{
		set_anim_array(self.a.var_911);
	}

	thread func_1FDA(undefined,1,0.3);
	return 1;
}

//Function Number: 12
func_1FD7(param_00,param_01,param_02)
{
	if(self.a.neverlean)
	{
		return 0;
	}

	return param_01 <= param_00 && param_00 <= param_02;
}

//Function Number: 13
shouldlean()
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
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 15
startaiming(param_00,param_01,param_02)
{
	self.var_1FC9 = 1;
	if(self.a.var_899 == "lean")
	{
		self.a.var_1EFE = 1;
	}
	else
	{
		self.a.var_1EFE = undefined;
	}

	setaimingparams(param_00,param_01,param_02);
}

//Function Number: 16
func_1FDA(param_00,param_01,param_02)
{
	if(self.a.var_899 == "lean")
	{
		self.a.var_1EFE = 1;
	}
	else
	{
		self.a.var_1EFE = undefined;
	}

	setaimingparams(param_00,param_01,param_02);
}

//Function Number: 17
stopaiming(param_00)
{
	self.var_1FC9 = 0;
	self clearanim(%add_fire,param_00);
	animscripts/track::setanimaimweight(0,param_00);
}

//Function Number: 18
setaimingparams(param_00,param_01,param_02)
{
	self.spot = param_00;
	self setanimlimited(%exposed_modern,1,param_02);
	self setanimlimited(%exposed_aiming,1,param_02);
	self setanimlimited(%add_idle,1,param_02);
	animscripts/track::setanimaimweight(1,param_02);
	var_03 = undefined;
	if(isdefined(self.a.array["lean_aim_straight"]))
	{
		var_03 = self.a.array["lean_aim_straight"];
	}

	thread animscripts/combat_utility::aimidlethread();
	if(isdefined(self.a.var_1EFE))
	{
		self setanimlimited(var_03,1,param_02);
		self setanimlimited(animscripts/utility::animarray("straight_level"),0,0);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_left"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_right"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_up"),1,param_02);
		self setanimknoblimited(animscripts/utility::animarray("lean_aim_down"),1,param_02);
		return;
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
		return;
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
stepoutandhidespeed()
{
	if(self.a.var_899 == "over")
	{
		return 1;
	}

	return animscripts/combat_utility::randomfasteranimspeed();
}

//Function Number: 20
stepout()
{
	self.a.var_899 = "alert";
	if(self.goalradius < 64)
	{
		self.goalradius = 64;
	}

	self animmode("zonly_physics");
	if(self.a.var_911 == "stand")
	{
		self.var_1FD3 = 38;
	}
	else
	{
		self.var_1FD3 = 31;
	}

	var_00 = self.a.var_911;
	set_anim_array(var_00);
	self setdefaultaimlimits();
	var_01 = "none";
	if(animscripts/utility::hasenemysightpos())
	{
		var_01 = func_1FD4(self.covernode,animscripts/utility::getenemysightpos());
	}
	else
	{
		var_01 = func_1FD4(self.covernode);
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = "alert_to_" + var_01;
	var_03 = animscripts/utility::animarraypickrandom(var_02);
	if(var_01 == "lean" && !func_1FEA())
	{
		return 0;
	}

	if(var_01 != "over" && !ispathclear(var_03,var_01 != "lean"))
	{
		return 0;
	}

	self.a.var_899 = var_01;
	self.a.prevattack = var_01;
	if(self.a.var_899 == "lean")
	{
		self setdefaultaimlimits(self.covernode);
	}

	if(var_01 == "A" || var_01 == "B")
	{
		self.a.special = "cover_" + self.var_1FC6 + "_" + self.a.var_911 + "_" + var_01;
	}
	else if(var_01 == "over")
	{
		self.a.special = "cover_crouch_aim";
	}
	else
	{
		self.a.special = "none";
	}

	self.keepclaimednodeifvalid = 1;
	var_04 = 0;
	self.var_8C8 = 1;
	self notify("done_changing_cover_pos");
	var_05 = stepoutandhidespeed();
	self.pushable = 0;
	self setflaggedanimknoballrestart("stepout",var_03,%root,1,0.2,var_05);
	thread donotetrackswithendon("stepout");
	var_04 = animhasnotetrack(var_03,"start_aim");
	if(var_04)
	{
		self.stepoutyaw = self.angles[1] + getangledelta(var_03,0,1);
		self waittillmatch("start_aim","stepout");
	}
	else
	{
		self waittillmatch("end","stepout");
	}

	if(var_01 == "B" && common_scripts\utility::cointoss() && self.var_1FC6 == "right")
	{
		self.a.special = "corner_right_martyrdom";
	}

	func_1FF1(var_00);
	var_06 = var_01 == "over";
	startaiming(undefined,var_06,0.3);
	thread animscripts/track::trackshootentorpos();
	if(var_04)
	{
		self waittillmatch("end","stepout");
		self.stepoutyaw = undefined;
	}

	func_1FDA(undefined,1,0.2);
	self clearanim(%cover,0.1);
	self clearanim(%corner,0.1);
	self.var_8C8 = 0;
	self.var_8E8 = gettime();
	self.pushable = 1;
	return 1;
}

//Function Number: 21
func_1FE0()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(func_0B76())
		{
			return 1;
		}
	}

	if(!stepout())
	{
		return 0;
	}

	func_0B73();
	if(isdefined(self.shootpos))
	{
		var_00 = lengthsquared(self.origin - self.shootpos);
		if(animscripts/utility::usingrocketlauncher() && var_00 < squared(512) || self.a.rockets < 1)
		{
			if(self.a.var_911 == "stand")
			{
				animscripts/shared::throwdownweapon(%rpg_stand_throw);
			}
			else
			{
				animscripts/shared::throwdownweapon(%rpg_crouch_throw);
			}

			thread func_1FFA();
			return;
		}
	}

	returntocover();
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 22
func_1FE1(param_00)
{
	if(!isdefined(self.var_B7C))
	{
		return 1;
	}

	return gettime() - self.var_B7C > param_00 * 1000;
}

//Function Number: 23
func_0B76()
{
	if(!animscripts/utility::hasenemysightpos())
	{
		return 0;
	}

	var_00 = 0;
	var_01 = 90;
	var_02 = self.covernode animscripts/utility::func_1FD1(animscripts/utility::getenemysightpos());
	if(self.var_1FC6 == "left")
	{
		var_02 = 0 - var_02;
	}

	if(var_02 > 30)
	{
		var_01 = 45;
		if(self.var_1FC6 == "left")
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
	var_05 = func_1FEF(48);
	if(!self maymovetopoint(var_05))
	{
		return 0;
	}

	self.var_8E8 = gettime();
	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self.isrambo = 1;
	self.a.prevattack = "rambo";
	self.var_8C8 = 1;
	thread animscripts/shared::ramboaim(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0,1);
	animscripts/shared::donotetracks("rambo");
	self notify("rambo_aim_end");
	self.var_8C8 = 0;
	self.keepclaimednodeifvalid = 0;
	self.var_B7C = gettime();
	self.var_8C8 = 0;
	self.isrambo = undefined;
	return 1;
}

//Function Number: 24
func_0B73()
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

			if(!isdefined(self.shootpos))
			{
				self waittill("do_slow_things");
				waittillframeend;
				if(isdefined(self.shootpos))
				{
					continue;
				}

				break;
			}

			if(!self.bulletsinclip)
			{
				break;
			}

			if(shootposoutsidelegalyawrange())
			{
				if(!changestepoutpos())
				{
					if(func_1FD5() == self.a.var_899)
					{
						break;
					}

					func_1FE2(0.2);
					continue;
				}

				if(shootposoutsidelegalyawrange())
				{
					break;
				}

				continue;
			}

			shootuntilshootbehaviorchange_corner(1);
			self clearanim(%add_fire,0.2);
		}

		if(canreturntocover(self.a.var_899 != "lean"))
		{
			break;
		}

		if(shootposoutsidelegalyawrange() && changestepoutpos())
		{
			continue;
		}

		func_1FE2(0.2);
	}
}

//Function Number: 25
func_1FE2(param_00)
{
	thread notifystopshootingaftertime(param_00);
	var_01 = gettime();
	shootuntilshootbehaviorchange_corner(0);
	self notify("stopNotifyStopShootingAfterTime");
	var_02 = gettime() - var_01 / 1000;
	if(var_02 < param_00)
	{
		wait param_00 - var_02;
	}
}

//Function Number: 26
notifystopshootingaftertime(param_00)
{
	self endon("killanimscript");
	self endon("stopNotifyStopShootingAfterTime");
	wait param_00;
	self notify("stopShooting");
}

//Function Number: 27
shootuntilshootbehaviorchange_corner(param_00)
{
	self endon("return_to_cover");
	if(param_00)
	{
		thread anglerangethread();
	}

	thread animscripts/combat_utility::aimidlethread();
	animscripts/combat_utility::shootuntilshootbehaviorchange();
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
		if(shootposoutsidelegalyawrange())
		{
			break;
		}

		wait 0.1;
	}

	self notify("stopShooting");
}

//Function Number: 29
showstate()
{
	self.enemy endon("death");
	self endon("enemy");
	self endon("stopshowstate");
	wait 0.05;
}

//Function Number: 30
canreturntocover(param_00)
{
	if(param_00)
	{
		var_01 = func_1FEF();
		if(!self maymovetopoint(var_01))
		{
			return 0;
		}

		return self maymovefrompointtopoint(var_01,self.covernode.origin);
	}

	return self maymovetopoint(self.covernode.origin);
}

//Function Number: 31
returntocover()
{
	animscripts/combat_utility::endfireandanimidlethread();
	var_00 = animscripts/utility::issuppressedwrapper();
	self notify("take_cover_at_corner");
	self.var_8C8 = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.var_899 + "_to_alert";
	var_02 = animscripts/utility::animarraypickrandom(var_01);
	stopaiming(0.3);
	var_03 = 0;
	if(self.a.var_899 != "lean" && var_00 && animscripts/utility::animarrayanyexist(var_01 + "_reload") && randomfloat(100) < 75)
	{
		var_02 = animscripts/utility::animarraypickrandom(var_01 + "_reload");
		var_03 = 1;
	}

	var_04 = stepoutandhidespeed();
	self clearanim(%body,0.1);
	self setflaggedanimrestart("hide",var_02,1,0.1,var_04);
	animscripts/shared::donotetracks("hide");
	if(var_03)
	{
		animscripts/weaponlist::refillclip();
	}

	self.var_8C8 = 0;
	if(self.var_1FC6 == "left")
	{
		self.a.special = "cover_left";
	}
	else
	{
		self.a.special = "cover_right";
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

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self setflaggedanimknoballrestart("blindfire",animscripts/utility::animarraypickrandom("blind_fire"),%body,1,0,1);
	animscripts/shared::donotetracks("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 33
func_1FE8(param_00,param_01,param_02)
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
trythrowinggrenadestayhidden(param_00)
{
	return trythrowinggrenade(param_00,1);
}

//Function Number: 35
trythrowinggrenade(param_00,param_01)
{
	if(!self maymovetopoint(func_1FEF()))
	{
		return 0;
	}

	if(isdefined(self.dontevershoot) || isdefined(param_00.dontattackme))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(isdefined(self.a.array["grenade_rambo"]))
		{
			var_02 = animscripts/utility::animarray("grenade_rambo");
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

			var_02 = animscripts/utility::animarray("grenade_safe");
		}
		else
		{
			if(!isdefined(self.a.array["grenade_exposed"]))
			{
				return 0;
			}

			var_02 = animscripts/utility::animarray("grenade_exposed");
		}
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts/combat_utility::trygrenade(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 36
printyawtoenemy()
{
}

//Function Number: 37
lookforenemy(param_00)
{
	if(!isdefined(self.a.array["alert_to_look"]))
	{
		return 0;
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	if(!peekout())
	{
		return 0;
	}

	animscripts/shared::func_B7E(animscripts/utility::animarray("look_idle"),param_00,::canstoppeeking);
	var_01 = undefined;
	if(animscripts/utility::issuppressedwrapper())
	{
		var_01 = animscripts/utility::animarray("look_to_alert_fast");
	}
	else
	{
		var_01 = animscripts/utility::animarray("look_to_alert");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1,1);
	animscripts/shared::donotetracks("looking_end");
	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 38
func_1FEA()
{
	var_00 = self geteye();
	var_01 = anglestoright(self.covernode.angles);
	if(self.var_1FC6 == "right")
	{
		var_00 = var_00 + var_01 * 30;
	}
	else
	{
		var_00 = var_00 - var_01 * 30;
	}

	var_02 = var_00 + anglestoforward(self.covernode.angles) * 30;
	return sighttracepassed(var_00,var_02,1,self);
}

//Function Number: 39
peekout()
{
	if(isdefined(self.covernode.script_dontpeek))
	{
		return 0;
	}

	if(isdefined(self.nextpeekoutattempttime) && gettime() < self.nextpeekoutattempttime)
	{
		return 0;
	}

	if(!func_1FEA())
	{
		self.nextpeekoutattempttime = gettime() + 3000;
		return 0;
	}

	var_00 = animscripts/utility::animarray("alert_to_look");
	self setflaggedanimknoball("looking_start",var_00,%body,1,0.2,1);
	animscripts/shared::donotetracks("looking_start");
	return 1;
}

//Function Number: 40
canstoppeeking()
{
	return self maymovetopoint(self.covernode.origin);
}

//Function Number: 41
fastlook()
{
	return 0;
}

//Function Number: 42
cornerreload()
{
	var_00 = animscripts/utility::animarraypickrandom("reload");
	self setflaggedanimknobrestart("cornerReload",var_00,1,0.2);
	animscripts/shared::donotetracks("cornerReload");
	animscripts/weaponlist::refillclip();
	self setanimrestart(animscripts/utility::animarray("alert_idle"),1,0.2);
	self clearanim(var_00,0.2);
	return 1;
}

//Function Number: 43
ispathclear(param_00,param_01)
{
	if(param_01)
	{
		var_02 = func_1FEF();
		if(!self maymovetopoint(var_02))
		{
			return 0;
		}

		return self maymovefrompointtopoint(var_02,animscripts/utility::getanimendpos(param_00));
	}

	return self maymovetopoint(animscripts/utility::getanimendpos(param_01));
}

//Function Number: 44
func_1FEF(param_00)
{
	var_01 = self.covernode.angles;
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

	return self.covernode.origin + (var_02[0],var_02[1],0);
}

//Function Number: 45
idle()
{
	self endon("end_idle");
	for(;;)
	{
		var_00 = randomint(2) == 0 && animscripts/utility::animarrayanyexist("alert_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts/utility::animarraypickrandom("alert_idle_twitch");
		}
		else
		{
			var_01 = animscripts/utility::animarray("alert_idle");
		}

		playidleanimation(var_01,var_00);
	}
}

//Function Number: 46
flinch()
{
	if(!animscripts/utility::animarrayanyexist("alert_idle_flinch"))
	{
		return 0;
	}

	playidleanimation(animscripts/utility::animarraypickrandom("alert_idle_flinch"),1);
	return 1;
}

//Function Number: 47
playidleanimation(param_00,param_01)
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
set_anim_array(param_00)
{
	[[ self.animarrayfuncs["hiding"][param_00] ]]();
	[[ self.animarrayfuncs["exposed"][param_00] ]]();
}

//Function Number: 49
func_1FF1(param_00)
{
	[[ self.animarrayfuncs["exposed"][param_00] ]]();
}

//Function Number: 50
func_1FF2(param_00)
{
	if(self.a.var_911 == param_00)
	{
		set_anim_array(param_00);
		return;
	}

	self setflaggedanimknoballrestart("changeStance",animscripts/utility::animarray("stance_change"),%body);
	set_anim_array(param_00);
	animscripts/shared::donotetracks("changeStance");
	wait 0.2;
}

//Function Number: 51
gotocover(param_00,param_01,param_02)
{
	var_03 = animscripts/utility::getnodedirection();
	var_04 = animscripts/utility::getnodeorigin();
	var_05 = var_03 + self.hideyawoffset;
	self orientmode("face angle",var_05);
	self animmode("normal");
	thread animscripts/shared::movetooriginovertime(var_04,param_01);
	self setflaggedanimknoballrestart("coveranim",param_00,%body,1,param_01);
	animscripts/notetracks::donotetracksfortime(param_02,"coveranim");
	while(animscripts/utility::absangleclamp180(self.angles[1] - var_05) > 1)
	{
		animscripts/notetracks::donotetracksfortime(0.1,"coveranim");
	}

	self animmode("zonly_physics");
	if(self.var_1FC6 == "left")
	{
		self.a.special = "cover_left";
		return;
	}

	self.a.special = "cover_right";
}

//Function Number: 52
func_1FF7()
{
	self endon("killanimscript");
	wait 0.05;
}

//Function Number: 53
set_standing_animarray_aiming()
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
	if(self.a.var_899 == "lean")
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
		if(animscripts/utility::weapon_pump_action_shotgun())
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
set_crouching_animarray_aiming()
{
	if(!isdefined(self.a.array))
	{
	}

	if(self.a.var_899 == "over")
	{
		self.a.array["add_aim_up"] = %covercrouch_aim8_add;
		self.a.array["add_aim_down"] = %covercrouch_aim2_add;
		self.a.array["add_aim_left"] = %covercrouch_aim4_add;
		self.a.array["add_aim_right"] = %covercrouch_aim6_add;
		self.a.array["straight_level"] = %covercrouch_aim5;
		var_00["fire"] = %exposed_shoot_auto_v2;
		if(animscripts/utility::weapon_pump_action_shotgun())
		{
		}
		else
		{
		}

		self.a.array["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
		return;
	}

	if(self.a.var_899 == "lean")
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
		if(animscripts/utility::weapon_pump_action_shotgun())
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
func_1FFA()
{
	self notify("killanimscript");
	thread animscripts/combat::main();
}