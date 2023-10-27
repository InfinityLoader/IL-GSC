/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\corner.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1099 ms
 * Timestamp: 10/27/2023 2:43:48 AM
*******************************************************************/

//Function Number: 1
corner_think(param_00,param_01)
{
	self endon("killanimscript");
	self.animarrayfuncs["exposed"]["stand"] = ::set_standing_animarray_aiming;
	self.animarrayfuncs["exposed"]["crouch"] = ::set_crouching_animarray_aiming;
	self.covernode = self.node;
	self.cornerdirection = param_00;
	self.a.cornermode = "unknown";
	self.a.aimidlethread = undefined;
	animscripts\cover_behavior::turntomatchnodedirection(param_01);
	set_corner_anim_array();
	self.isshooting = 0;
	self.tracking = 0;
	self.corneraiming = 0;
	animscripts\track::setanimaimweight(0);
	self.havegonetocover = 0;
	var_02 = spawnstruct();
	if(!self.fixednode)
	{
		var_02.movetonearbycover = ::animscripts\cover_behavior::movetonearbycover;
	}

	var_02.mainloopstart = ::mainloopstart;
	var_02.reload = ::cornerreload;
	var_02.leavecoverandshoot = ::stepoutandshootenemy;
	var_02.look = ::lookforenemy;
	var_02.fastlook = ::fastlook;
	var_02.idle = ::idle;
	var_02.grenade = ::trythrowinggrenade;
	var_02.grenadehidden = ::trythrowinggrenadestayhidden;
	var_02.blindfire = ::blindfire;
	animscripts\cover_behavior::main(var_02);
}

//Function Number: 2
end_script_corner()
{
	self.stepoutyaw = undefined;
	self.a.leanaim = undefined;
}

//Function Number: 3
set_corner_anim_array()
{
	if(self.a.pose == "crouch")
	{
		set_anim_array("crouch");
		return;
	}

	if(self.a.pose == "stand")
	{
		set_anim_array("stand");
		return;
	}

	animscripts\utility::exitpronewrapper(1);
	self.a.pose = "crouch";
	set_anim_array("crouch");
}

//Function Number: 4
shouldchangestanceforfun()
{
	if(!isdefined(self.allowstancechangesforfun))
	{
		return 0;
	}

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
		if(isdefined(self.rambochance) && self.a.pose == "stand")
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
	var_00 = gettime();
	var_01 = "stand";
	if(self.a.pose == "crouch")
	{
		var_01 = "crouch";
		if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
		{
			if(self.script == "cover_right")
			{
				var_01 = "crouch_r";
			}
			else if(self.script == "cover_left")
			{
				var_01 = "crouch_l";
			}
		}

		if(self.covernode doesnodeallowstance("stand"))
		{
			if(!self.covernode doesnodeallowstance("crouch") || shouldchangestanceforfun())
			{
				var_01 = "stand";
			}
		}
	}
	else if(self.covernode doesnodeallowstance("crouch"))
	{
		if(!self.covernode doesnodeallowstance("stand") || shouldchangestanceforfun())
		{
			var_01 = "crouch";
			if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
			{
				if(self.script == "cover_right")
				{
					var_01 = "crouch_r";
				}
				else if(self.script == "cover_left")
				{
					var_01 = "crouch_l";
				}
			}
		}
	}

	if(self.havegonetocover)
	{
		if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
		{
			if(var_01 == "crouch_l" || var_01 == "crouch_r")
			{
				var_01 = "crouch";
			}
		}

		transitiontostance(var_01);
	}
	else
	{
		var_02 = undefined;
		if(self.a.pose == var_01)
		{
			var_03 = 0.4;
			if(isdefined(self.cover) && isdefined(self.cover.hidestate) && self.cover.hidestate == "back")
			{
				var_04 = animscripts\utility::animarray("alert_idle_back");
			}
			else if(var_02 == "crouch" && shouldplayalerttransition(self))
			{
				var_04 = animscripts\utility::animarray("AW_to_MW_alert_trans");
				var_03 = getanimlength(var_04);
			}
			else if(var_02 == "stand" && shouldplayalerttransition(self))
			{
				var_04 = animscripts\utility::animarray("exposed_2_alert");
				var_03 = getanimlength(var_04);
			}
			else
			{
				var_04 = animscripts\utility::animarray("alert_idle");
			}

			gotocover(var_04,0.3,var_03);
		}
		else
		{
			if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
			{
				if(var_01 == "crouch_l")
				{
					var_02 = animscripts\utility::lookupanim("combat","trans_to_crouch_l");
					var_01 = "crouch";
				}
				else if(var_01 == "crouch_r")
				{
					var_02 = animscripts\utility::lookupanim("combat","trans_to_crouch_r");
					var_01 = "crouch";
				}
			}

			if(!isdefined(var_02))
			{
				var_02 = animscripts\utility::animarray("stance_change");
			}

			gotocover(var_02,0.3,getanimlength(var_02));
			set_anim_array(var_01);
		}

		self.havegonetocover = 1;
	}

	return gettime() - var_00 > 0;
}

//Function Number: 6
hasonekneeup()
{
	var_00 = [%cornercrr_alert_painc,%cornercrr_alert_paina,%cornercrl_painb,%exposed_crouch_pain_headsnap,%exposed_crouch_pain_flinch,%exposed_crouch_pain_chest,%exposed_crouch_pain_left_arm,%exposed_crouch_pain_right_arm,%exposed_stand_2_crouch,%cornercrl_lean_2_alert,%run_2_crouch_f,%run_2_crouch_90l,%run_2_crouch_90r,%run_2_crouch_180l,%run_2_crouch_idle_1,%run_2_crouch_idle_3,%run_2_crouch_idle_7,%run_2_crouch_idle_9,%cornercrr_lean_2_alert,%cornercrl_reloada,%cornercrr_reload,%cornercrl_cqb_trans_in_1,%cornercrl_cqb_trans_in_2,%cornercrl_cqb_trans_in_3,%cornercrl_cqb_trans_in_4,%cornercrl_cqb_trans_in_6,%cornercrl_cqb_trans_in_7,%cornercrl_cqb_trans_in_8,%grenade_return_cornercrl_1knee_throw,%grenade_return_cornercrr_1knee_throw];
	foreach(var_02 in var_00)
	{
		if(self getanimweight(var_02) != 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
shouldplayalerttransition(param_00)
{
	if(!animscripts\utility::using_improved_transitions())
	{
		return 0;
	}

	var_01 = [%cornercrl_trans_a_2_alert,%cornercrr_trans_a_2_alert,%cornercrl_trans_b_2_alert,%cornercrr_trans_b_2_alert,%cornercrouchr_crouchidle_2_alert,%cornercrouchl_crouchidle_2_alert,%h1_cornercrr_alert_paina_2,%h1_cornercrr_alert_painb_2,%h1_cornercrr_alert_painc_2,%h1_cornercrl_painb_2,%h1_cornercrl_trans_2_2knees,%h1_cornercrouch_trans_2_2knee,%h1_cornercrr_alert_paina_2,%h1_cornercrr_alert_painb_2,%h1_cornercrr_alert_painc_2,%cornercrr_reloada,%cornercrr_reloadb,%cornercrl_reloadb];
	var_02 = [%walk_backward,%walk_left,%walk_right,%walk_forward];
	foreach(var_04 in var_01)
	{
		if(param_00 getanimweight(var_04) != 0)
		{
			return 0;
		}
	}

	if(param_00 hasonekneeup())
	{
		return 1;
	}

	if(param_00 getanimweight(%exposed_modern) != 0 && param_00 getanimweight(%exposed_aiming) != 0)
	{
		return 1;
	}

	foreach(var_07 in var_02)
	{
		if(param_00 getanimweight(var_07) != 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
printyaws()
{
	wait(2);
	for(;;)
	{
		printyawtoenemy();
		wait(0.05);
	}
}

//Function Number: 9
canseepointfromexposedatcorner(param_00,param_01)
{
	var_02 = param_01 animscripts\utility::getyawtoorigin(param_00);
	if(var_02 > 60 || var_02 < -60)
	{
		return 0;
	}

	if(animscripts\utility::isnodecoverleft(param_01) && var_02 > 14)
	{
		return 0;
	}

	if(animscripts\utility::isnodecoverright(param_01) && var_02 < -12)
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
shootposoutsidelegalyawrange()
{
	if(!isdefined(self.shootpos))
	{
		return 0;
	}

	var_00 = self.covernode animscripts\utility::getyawtoorigin(self.shootpos);
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

//Function Number: 11
getcornermode(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_00 animscripts\utility::getyawtoorigin(param_01);
	}

	var_04 = [];
	if(isdefined(param_00) && self.a.pose == "crouch" && var_03 > self.leftaimlimit && self.rightaimlimit > var_03)
	{
		var_04 = param_00 getvalidcoverpeekouts();
	}

	if(self.cornerdirection == "up")
	{
		if(animscripts\utility::isspaceai())
		{
			var_05 = 0;
			if(isdefined(param_01))
			{
				var_06 = anglestoup(self.angles);
				var_05 = animscripts\combat_utility::getpitchtoorgfromorg(param_01,self geteye() + (var_06[0] * 12,var_06[1] * 12,var_06[2] * 12));
			}

			if(canlean(var_05,-5,80))
			{
				var_02 = shouldlean();
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
			var_02 = shouldlean();
			if(var_02)
			{
				var_04[var_04.size] = "lean";
			}
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
			var_02 = shouldlean();
			if(var_02)
			{
				var_04[var_04.size] = "lean";
			}
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

	return animscripts\combat_utility::getrandomcovermode(var_04);
}

//Function Number: 12
getbeststepoutpos()
{
	var_00 = 0;
	if(animscripts\utility::cansuppressenemy())
	{
		var_00 = self.covernode animscripts\utility::getyawtoorigin(animscripts\utility::getenemysightpos());
	}
	else if(self.doingambush && isdefined(self.shootpos))
	{
		var_00 = self.covernode animscripts\utility::getyawtoorigin(self.shootpos);
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

//Function Number: 13
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
	var_02 = animscripts\utility::animarraypickrandom(var_01);
	if(animscripts\utility::isspaceai() && var_01 == "A_to_B" || var_01 == "B_to_A")
	{
		return 0;
	}

	var_03 = !self.swimmer;
	var_04 = getpredictedpathmidpoint();
	if(!self maymovetopoint(var_04,var_03))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_04,animscripts\utility::getanimendpos(var_02),var_03))
	{
		return 0;
	}

	animscripts\combat_utility::endaimidlethread();
	stopaiming(0.3);
	var_05 = self.a.pose;
	self setanimlimited(animscripts\utility::animarray("straight_level"),0,0.2);
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

	thread startaiming(undefined,0,0.3);
	if(var_06)
	{
		self waittillmatch("end","changeStepOutPos");
	}

	self clearanim(var_02,0.1);
	self.a.cornermode = var_00;
	self.changingcoverpos = 0;
	self.coverposestablishedtime = gettime();
	if(self.a.pose != var_05)
	{
		set_anim_array(self.a.pose);
	}

	thread changeaiming(undefined,1,0.3);
	return 1;
}

//Function Number: 14
canlean(param_00,param_01,param_02)
{
	if(self.a.neverlean)
	{
		return 0;
	}

	return param_01 <= param_00 && param_00 <= param_02;
}

//Function Number: 15
shouldlean()
{
	if(!animscripts\utility::using_improved_transitions() && self.a.pose != "stand")
	{
		return 0;
	}

	if(self.team == "allies")
	{
		return 1;
	}

	if(animscripts\utility::ispartiallysuppressedwrapper())
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
donotetrackswithendon(param_00)
{
	self endon("killanimscript");
	animscripts\shared::donotetracks(param_00);
}

//Function Number: 17
startaiming(param_00,param_01,param_02)
{
	self.corneraiming = 1;
	if(self.a.cornermode == "lean")
	{
		self.a.leanaim = 1;
	}
	else
	{
		self.a.leanaim = undefined;
	}

	setaimingparams(param_00,param_01,param_02);
}

//Function Number: 18
changeaiming(param_00,param_01,param_02)
{
	if(self.a.cornermode == "lean")
	{
		self.a.leanaim = 1;
	}
	else
	{
		self.a.leanaim = undefined;
	}

	setaimingparams(param_00,param_01,param_02);
}

//Function Number: 19
stopaiming(param_00)
{
	self.corneraiming = 0;
	self clearanim(%add_fire,param_00);
	animscripts\track::setanimaimweight(0,param_00);
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}

//Function Number: 20
setaimingparams(param_00,param_01,param_02)
{
	self.spot = param_00;
	self setanimlimited(%exposed_modern,1,param_02);
	self setanimlimited(%exposed_aiming,1,param_02);
	self setanimlimited(%add_idle,1,param_02);
	animscripts\track::setanimaimweight(1,param_02);
	corner_playaimfacialanim(undefined);
	var_03 = undefined;
	if(isdefined(self.a.array["lean_aim_straight"]))
	{
		var_03 = self.a.array["lean_aim_straight"];
	}

	thread animscripts\combat_utility::aimidlethread();
	if(isdefined(self.a.leanaim))
	{
		self setanimlimited(var_03,1,param_02);
		self setanimlimited(animscripts\utility::animarray("straight_level"),0,0);
		self setanimknoblimited(animscripts\utility::animarray("lean_aim_left"),1,param_02);
		self setanimknoblimited(animscripts\utility::animarray("lean_aim_right"),1,param_02);
		self setanimknoblimited(animscripts\utility::animarray("lean_aim_up"),1,param_02);
		self setanimknoblimited(animscripts\utility::animarray("lean_aim_down"),1,param_02);
		return;
	}

	if(param_01)
	{
		self setanimlimited(animscripts\utility::animarray("straight_level"),1,param_02);
		if(isdefined(var_03))
		{
			self setanimlimited(var_03,0,0);
		}

		self setanimknoblimited(animscripts\utility::animarray("add_aim_up"),1,param_02);
		self setanimknoblimited(animscripts\utility::animarray("add_aim_down"),1,param_02);
		self setanimknoblimited(animscripts\utility::animarray("add_aim_left"),1,param_02);
		self setanimknoblimited(animscripts\utility::animarray("add_aim_right"),1,param_02);
		return;
	}

	self setanimlimited(animscripts\utility::animarray("straight_level"),0,param_02);
	if(isdefined(var_03))
	{
		self setanimlimited(var_03,0,0);
	}

	self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_up"),1,param_02);
	self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_down"),1,param_02);
	self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_left"),1,param_02);
	self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_right"),1,param_02);
}

//Function Number: 21
stepoutandhidespeed()
{
	if(self.a.cornermode == "over")
	{
		return 1;
	}

	return animscripts\combat_utility::randomfasteranimspeed();
}

//Function Number: 22
stepout()
{
	self.a.cornermode = "alert";
	if(isdefined(self.disablestepout) && self.disablestepout)
	{
		return 0;
	}

	setdefaultcorneranimmode();
	if(self.a.pose == "stand")
	{
		self.abanglecutoff = 38;
	}
	else
	{
		self.abanglecutoff = 31;
	}

	var_00 = self.a.pose;
	set_anim_array(var_00);
	animscripts\combat::set_default_aim_limits();
	var_01 = "none";
	if(animscripts\utility::hasenemysightpos())
	{
		var_01 = getcornermode(self.covernode,animscripts\utility::getenemysightpos());
	}
	else
	{
		var_01 = getcornermode(self.covernode);
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = "alert_to_" + var_01;
	if(!animscripts\utility::animarrayanyexist(var_02))
	{
		return 0;
	}

	var_03 = animscripts\utility::animarraypickrandom(var_02);
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
		animscripts\combat::set_default_aim_limits(self.covernode);
	}

	if(var_01 == "A" || var_01 == "B")
	{
		self.a.special = "cover_" + self.cornerdirection + "_" + self.a.pose + "_" + var_01;
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
	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	var_05 = stepoutandhidespeed();
	self.pushable = 0;
	self setflaggedanimknoballrestart("stepout",var_03,%animscript_root,1,0.2,var_05);
	corner_playcornerfacialanim(var_03);
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

	if(var_01 == "B" && common_scripts\utility::cointoss() && self.cornerdirection == "right")
	{
		self.a.special = "corner_right_martyrdom";
	}

	set_anim_array_aiming(var_00);
	var_06 = var_01 == "over" || animscripts\utility::isspaceai();
	startaiming(undefined,var_06,0.3);
	thread animscripts\track::trackshootentorpos();
	if(var_04)
	{
		self waittillmatch("end","stepout");
		self.stepoutyaw = undefined;
	}

	changeaiming(undefined,1,0.2);
	self clearanim(%cover,0.1);
	self clearanim(%corner,0.1);
	self.changingcoverpos = 0;
	self.coverposestablishedtime = gettime();
	self.pushable = 1;
	return 1;
}

//Function Number: 23
stepoutandshootenemy()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(rambo())
		{
			return 1;
		}
	}

	if(!stepout())
	{
		return 0;
	}

	shootastold();
	if(isdefined(self.shootpos))
	{
		var_00 = lengthsquared(self.origin - self.shootpos);
		if(animscripts\utility::usingrocketlauncher() && animscripts\utility::shoulddroprocketlauncher(var_00))
		{
			if(self.a.pose == "stand")
			{
				animscripts\shared::throwdownweapon(animscripts\utility::lookupanim("combat","drop_rpg_stand"));
			}
			else
			{
				animscripts\shared::throwdownweapon(animscripts\utility::lookupanim("combat","drop_rpg_crouch"));
			}

			thread runcombat();
			return;
		}
	}

	returntocover();
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 24
haventramboedwithintime(param_00)
{
	if(!isdefined(self.lastrambotime))
	{
		return 1;
	}

	return gettime() - self.lastrambotime > param_00 * 1000;
}

//Function Number: 25
rambo()
{
	if(!animscripts\utility::hasenemysightpos())
	{
		return 0;
	}

	var_00 = 0;
	var_01 = 90;
	var_02 = self.covernode animscripts\utility::getyawtoorigin(animscripts\utility::getenemysightpos());
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
	if(!animscripts\utility::animarrayanyexist(var_03))
	{
		return 0;
	}

	var_04 = animscripts\utility::animarraypickrandom(var_03);
	var_05 = getpredictedpathmidpoint(48);
	if(!self maymovetopoint(var_05,!self.swimmer))
	{
		return 0;
	}

	self.coverposestablishedtime = gettime();
	setdefaultcorneranimmode();
	self.keepclaimednodeifvalid = 1;
	self.isrambo = 1;
	self.a.prevattack = "rambo";
	self.changingcoverpos = 1;
	thread animscripts\shared::ramboaim(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0,1);
	corner_playcornerfacialanim(var_04);
	animscripts\shared::donotetracks("rambo");
	self notify("rambo_aim_end");
	self.changingcoverpos = 0;
	self.keepclaimednodeifvalid = 0;
	self.lastrambotime = gettime();
	self.changingcoverpos = 0;
	self.isrambo = undefined;
	return 1;
}

//Function Number: 26
shootastold()
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
					if(getbeststepoutpos() == self.a.cornermode)
					{
						break;
					}

					shootuntilshootbehaviorchangefortime(0.2);
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

		if(canreturntocover(self.a.cornermode != "lean"))
		{
			break;
		}

		if(shootposoutsidelegalyawrange() && changestepoutpos())
		{
			continue;
		}

		shootuntilshootbehaviorchangefortime(0.2);
	}
}

//Function Number: 27
shootuntilshootbehaviorchangefortime(param_00)
{
	thread notifystopshootingaftertime(param_00);
	var_01 = gettime();
	shootuntilshootbehaviorchange_corner(0);
	self notify("stopNotifyStopShootingAfterTime");
	var_02 = gettime() - var_01 / 1000;
	if(var_02 < param_00)
	{
		wait(param_00 - var_02);
	}
}

//Function Number: 28
notifystopshootingaftertime(param_00)
{
	self endon("killanimscript");
	self endon("stopNotifyStopShootingAfterTime");
	wait(param_00);
	self notify("stopShooting");
}

//Function Number: 29
shootuntilshootbehaviorchange_corner(param_00)
{
	self endon("return_to_cover");
	if(param_00)
	{
		thread anglerangethread();
	}

	thread animscripts\combat_utility::aimidlethread();
	animscripts\combat_utility::shootuntilshootbehaviorchange();
}

//Function Number: 30
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

		wait(0.1);
	}

	self notify("stopShooting");
}

//Function Number: 31
showstate()
{
	self.enemy endon("death");
	self endon("enemy");
	self endon("stopshowstate");
	wait(0.05);
}

//Function Number: 32
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

		return self maymovefrompointtopoint(var_02,self.covernode.origin,var_01);
	}

	return self maymovetopoint(self.covernode.origin,var_02);
}

//Function Number: 33
returntocover()
{
	animscripts\combat_utility::endfireandanimidlethread();
	var_00 = animscripts\utility::issuppressedwrapper();
	self notify("take_cover_at_corner");
	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	var_01 = self.a.cornermode + "_to_alert";
	var_02 = animscripts\utility::animarraypickrandom(var_01);
	stopaiming(0.3);
	var_03 = 0;
	if(self.a.cornermode != "lean" && var_00 && animscripts\utility::animarrayanyexist(var_01 + "_reload") && randomfloat(100) < 75)
	{
		var_02 = animscripts\utility::animarraypickrandom(var_01 + "_reload");
		var_03 = 1;
	}

	var_04 = stepoutandhidespeed();
	if(animscripts\utility::isspaceai())
	{
		self clearanim(%exposed_modern,0.2);
	}
	else
	{
		self clearanim(%body,0.1);
	}

	self setflaggedanimrestart("hide",var_02,1,0.1,var_04);
	corner_playcornerfacialanim(var_02);
	animscripts\shared::donotetracks("hide");
	if(var_03)
	{
		animscripts\weaponlist::refillclip();
	}

	self.changingcoverpos = 0;
	if(self.cornerdirection == "up")
	{
		self.a.special = "cover_up";
	}
	else if(self.cornerdirection == "left")
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

//Function Number: 34
blindfire()
{
	if(!animscripts\utility::animarrayanyexist("blind_fire"))
	{
		return 0;
	}

	behaviorstransitiontocorrectpose();
	setdefaultcorneranimmode();
	self.keepclaimednodeifvalid = 1;
	var_00 = animscripts\utility::animarraypickrandom("blind_fire");
	self setflaggedanimknoballrestart("blindfire",var_00,%body,1,0,1);
	corner_playcornerfacialanim(var_00);
	animscripts\shared::donotetracks("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 35
linethread(param_00,param_01,param_02)
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

//Function Number: 36
trythrowinggrenadestayhidden(param_00)
{
	if(self.a.pose == "crouch" && shouldplayalerttransition(self))
	{
		return 0;
	}

	return trythrowinggrenade(param_00,1);
}

//Function Number: 37
trythrowinggrenade(param_00,param_01)
{
	if(!self maymovetopoint(getpredictedpathmidpoint()))
	{
		return 0;
	}

	if(isdefined(self.dontevershoot) || isdefined(param_00.dontattackme))
	{
		return 0;
	}

	if(self.a.pose == "crouch" && shouldplayalerttransition(self))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(isdefined(self.a.array["grenade_rambo"]))
		{
			var_02 = animscripts\utility::animarray("grenade_rambo");
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

			var_02 = animscripts\utility::animarray("grenade_safe");
		}
		else
		{
			if(!isdefined(self.a.array["grenade_exposed"]))
			{
				return 0;
			}

			var_02 = animscripts\utility::animarray("grenade_exposed");
		}
	}

	setdefaultcorneranimmode();
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts\combat_utility::trygrenade(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 38
printyawtoenemy()
{
}

//Function Number: 39
lookforenemy(param_00)
{
	if(!isdefined(self.a.array["alert_to_look"]))
	{
		return 0;
	}

	setdefaultcorneranimmode();
	self.keepclaimednodeifvalid = 1;
	if(!peekout())
	{
		return 0;
	}

	behaviorstransitiontocorrectpose();
	animscripts\shared::playlookanimation(animscripts\utility::animarray("look_idle"),param_00,::canstoppeeking);
	var_01 = undefined;
	if(animscripts\utility::issuppressedwrapper())
	{
		var_01 = animscripts\utility::animarray("look_to_alert_fast");
	}
	else
	{
		var_01 = animscripts\utility::animarray("look_to_alert");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1,1);
	corner_playcornerfacialanim(var_01);
	animscripts\shared::donotetracks("looking_end");
	setdefaultcorneranimmode();
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 40
ispeekoutposclear()
{
	var_00 = self.covernode.angles;
	if(animscripts\utility::isspaceai())
	{
		var_00 = animscripts\utility::gettruenodeangles(self.covernode);
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

	if(self.team == "allies" && level.player maps\_utility::isads())
	{
		if(maps\_utility::player_looking_at(var_01,0.95,undefined,level.player))
		{
			return 0;
		}
	}

	var_04 = var_01 + anglestoforward(var_00) * 30;
	return sighttracepassed(var_01,var_04,1,self);
}

//Function Number: 41
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

	if(!ispeekoutposclear())
	{
		self.nextpeekoutattempttime = gettime() + 3000;
		return 0;
	}

	var_00 = animscripts\utility::animarray("alert_to_look");
	self setflaggedanimknoball("looking_start",var_00,%body,1,0.2,1);
	corner_playcornerfacialanim(var_00);
	animscripts\shared::donotetracks("looking_start");
	return 1;
}

//Function Number: 42
canstoppeeking()
{
	return self maymovetopoint(self.covernode.origin,!self.swimmer);
}

//Function Number: 43
fastlook()
{
	return 0;
}

//Function Number: 44
cornerreload()
{
	if(self.a.pose == "crouch" && shouldplayalerttransition(self))
	{
		animscripts\weaponlist::refillclip();
		return 0;
	}

	var_00 = "reload";
	if(animscripts\utility::isshotgun(self.weapon) && animscripts\utility::animarrayanyexist("shotgun_reload"))
	{
		var_00 = "shotgun_reload";
	}

	var_01 = animscripts\utility::animarraypickrandom(var_00);
	self setflaggedanimknobrestart("cornerReload",var_01,1,0.2);
	corner_playcornerfacialanim(var_01);
	animscripts\shared::donotetracks("cornerReload");
	self notify("abort_reload");
	animscripts\weaponlist::refillclip();
	self setanimrestart(animscripts\utility::animarray("alert_idle"),1,0.2);
	self clearanim(var_01,0.2);
	return 1;
}

//Function Number: 45
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

		return self maymovefrompointtopoint(var_03,animscripts\utility::getanimendpos(param_00),var_02);
	}

	if(self.swimmer)
	{
		return 1;
	}

	return self maymovetopoint(animscripts\utility::getanimendpos(param_01),var_03);
}

//Function Number: 46
getpredictedpathmidpoint(param_00)
{
	var_01 = self.covernode.angles;
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
		return self.covernode.origin + var_04 * param_00;
	}

	switch(var_04)
	{
		case "cover_swim_left":
		case "cover_left":
			break;

		case "cover_swim_right":
		case "cover_right":
			break;

		default:
			break;
	}
}

//Function Number: 47
behaviorstransitiontocorrectpose()
{
	if(self.a.pose == "crouch" && shouldplayalerttransition(self))
	{
		var_00 = animscripts\utility::animarray("1knee_2_2knees");
		var_01 = getanimlength(var_00);
		gotocover(var_00,0.3,var_01);
	}
}

//Function Number: 48
idle()
{
	self endon("end_idle");
	for(;;)
	{
		behaviorstransitiontocorrectpose();
		var_00 = randomint(2) == 0 && isdefined(self.a.array["alert_idle_twitch"]) && animscripts\utility::animarrayanyexist("alert_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts\utility::animarraypickrandom("alert_idle_twitch");
		}
		else
		{
			var_01 = animscripts\utility::animarray("alert_idle");
		}

		playidleanimation(var_01,var_00);
	}
}

//Function Number: 49
flinch()
{
	if(!animscripts\utility::animarrayanyexist("alert_idle_flinch"))
	{
		return 0;
	}

	playidleanimation(animscripts\utility::animarraypickrandom("alert_idle_flinch"),1);
	return 1;
}

//Function Number: 50
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

	corner_playcornerfacialanim(param_00);
	animscripts\shared::donotetracks("idle");
}

//Function Number: 51
set_anim_array(param_00)
{
	[[ self.animarrayfuncs["hiding"][param_00] ]]();
	[[ self.animarrayfuncs["exposed"][param_00] ]]();
}

//Function Number: 52
set_anim_array_aiming(param_00)
{
	[[ self.animarrayfuncs["exposed"][param_00] ]]();
}

//Function Number: 53
transitiontostance(param_00)
{
	if(self.a.pose == param_00)
	{
		set_anim_array(param_00);
		return;
	}

	var_01 = animscripts\utility::animarray("stance_change");
	self setflaggedanimknoballrestart("changeStance",var_01,%body);
	corner_playcornerfacialanim(var_01);
	set_anim_array(param_00);
	animscripts\shared::donotetracks("changeStance");
	wait(0.2);
}

//Function Number: 54
gotocover(param_00,param_01,param_02)
{
	var_03 = animscripts\utility::getnodedirection();
	var_04 = animscripts\utility::getclaimednode();
	var_05 = var_03 + self.hideyawoffset;
	if(animscripts\utility::isspaceai())
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
		thread animscripts\shared::movetonodeovertime(var_04,param_01);
	}

	self setflaggedanimknoballrestart("coveranim",param_00,%body,1,param_01);
	corner_playcornerfacialanim(param_00);
	animscripts\notetracks::donotetracksfortime(param_02,"coveranim");
	while(animscripts\utility::absangleclamp180(self.angles[1] - var_05) > 1)
	{
		animscripts\notetracks::donotetracksfortime(0.1,"coveranim");
		var_03 = animscripts\utility::getnodedirection();
		var_05 = var_03 + self.hideyawoffset;
	}

	setdefaultcorneranimmode();
	if(self.cornerdirection == "left")
	{
		self.a.special = "cover_left";
		return;
	}

	if(self.cornerdirection == "right")
	{
		self.a.special = "cover_right";
		return;
	}

	self.a.special = "cover_up";
}

//Function Number: 55
drawoffset()
{
	self endon("killanimscript");
	wait(0.05);
}

//Function Number: 56
set_standing_animarray_aiming()
{
	if(self.swimmer && isdefined(self.node))
	{
		set_swimming_animarray_aiming();
		return;
	}

	if(!isdefined(self.a.array))
	{
	}

	var_00 = animscripts\utility::lookupanimarray("default_stand");
	self.a.array["add_aim_up"] = var_00["add_aim_up"];
	self.a.array["add_aim_down"] = var_00["add_aim_down"];
	self.a.array["add_aim_left"] = var_00["add_aim_left"];
	self.a.array["add_aim_right"] = var_00["add_aim_right"];
	self.a.array["add_turn_aim_up"] = var_00["add_turn_aim_up"];
	self.a.array["add_turn_aim_down"] = var_00["add_turn_aim_down"];
	self.a.array["add_turn_aim_left"] = var_00["add_turn_aim_left"];
	self.a.array["add_turn_aim_right"] = var_00["add_turn_aim_right"];
	self.a.array["straight_level"] = var_00["straight_level"];
	if(self.a.cornermode == "lean")
	{
		var_01 = self.a.array["lean_fire"];
		var_02 = self.a.array["lean_single"];
		self.a.array["fire"] = var_01;
		self.a.array["single"] = animscripts\utility::array(var_02);
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
		self.a.array["fire"] = var_00["fire_corner"];
		self.a.array["semi2"] = var_00["semi2"];
		self.a.array["semi3"] = var_00["semi3"];
		self.a.array["semi4"] = var_00["semi4"];
		self.a.array["semi5"] = var_00["semi5"];
		if(animscripts\utility::weapon_pump_action_shotgun())
		{
			self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand","single");
		}
		else
		{
			self.a.array["single"] = var_00["single"];
		}

		self.a.array["burst2"] = var_00["burst2"];
		self.a.array["burst3"] = var_00["burst3"];
		self.a.array["burst4"] = var_00["burst4"];
		self.a.array["burst5"] = var_00["burst5"];
		self.a.array["burst6"] = var_00["burst6"];
	}

	self.a.array["exposed_idle"] = var_00["exposed_idle"];
}

//Function Number: 57
set_crouching_animarray_aiming()
{
	if(self.swimmer && isdefined(self.node))
	{
		set_swimming_animarray_aiming();
		return;
	}

	if(!isdefined(self.a.array))
	{
	}

	var_00 = animscripts\utility::lookupanimarray("default_crouch");
	var_01["add_aim_up"] = animscripts\utility::lookupanim("cover_crouch","add_aim_up");
	var_02["add_aim_up"] = animscripts\utility::lookupanim("cover_crouch","add_aim_up");
	var_03[0] = animscripts\utility::lookupanim("cover_crouch","add_aim_up");
	if(self.a.cornermode == "over")
	{
		self.a.array["add_aim_up"] = animscripts\utility::lookupanim("cover_crouch","add_aim_up");
		self.a.array["add_aim_down"] = animscripts\utility::lookupanim("cover_crouch","add_aim_down");
		self.a.array["add_aim_left"] = animscripts\utility::lookupanim("cover_crouch","add_aim_left");
		self.a.array["add_aim_right"] = animscripts\utility::lookupanim("cover_crouch","add_aim_right");
		self.a.array["straight_level"] = animscripts\utility::lookupanim("cover_crouch","straight_level");
		self.a.array["exposed_idle"] = animscripts\utility::lookupanim("default_stand","exposed_idle");
		return;
	}

	if(self.a.cornermode == "lean")
	{
		var_04 = self.a.array["lean_fire"];
		var_05 = self.a.array["lean_single"];
		self.a.array["fire"] = var_04;
		self.a.array["single"] = animscripts\utility::array(var_05);
		self.a.array["semi2"] = var_05;
		self.a.array["semi3"] = var_05;
		self.a.array["semi4"] = var_05;
		self.a.array["semi5"] = var_05;
		self.a.array["burst2"] = var_04;
		self.a.array["burst3"] = var_04;
		self.a.array["burst4"] = var_04;
		self.a.array["burst5"] = var_04;
		self.a.array["burst6"] = var_04;
	}
	else
	{
		self.a.array["fire"] = var_00["fire"];
		self.a.array["semi2"] = var_00["semi2"];
		self.a.array["semi3"] = var_00["semi3"];
		self.a.array["semi4"] = var_00["semi4"];
		self.a.array["semi5"] = var_00["semi5"];
		if(animscripts\utility::weapon_pump_action_shotgun())
		{
			self.a.array["single"] = animscripts\utility::lookupanim("shotgun_crouch","single");
		}
		else
		{
			self.a.array["single"] = var_00["single"];
		}

		self.a.array["burst2"] = var_00["burst2"];
		self.a.array["burst3"] = var_00["burst3"];
		self.a.array["burst4"] = var_00["burst4"];
		self.a.array["burst5"] = var_00["burst5"];
		self.a.array["burst6"] = var_00["burst6"];
	}

	self.a.array["add_aim_up"] = var_00["add_aim_up"];
	self.a.array["add_aim_down"] = var_00["add_aim_down"];
	self.a.array["add_aim_left"] = var_00["add_aim_left"];
	self.a.array["add_aim_right"] = var_00["add_aim_right"];
	self.a.array["add_turn_aim_up"] = var_00["add_turn_aim_up"];
	self.a.array["add_turn_aim_down"] = var_00["add_turn_aim_down"];
	self.a.array["add_turn_aim_left"] = var_00["add_turn_aim_left"];
	self.a.array["add_turn_aim_right"] = var_00["add_turn_aim_right"];
	self.a.array["straight_level"] = var_00["straight_level"];
	self.a.array["exposed_idle"] = var_00["exposed_idle"];
}

//Function Number: 58
set_swimming_animarray_aiming()
{
	if(!isdefined(self.a.array))
	{
	}

	var_00 = [];
	if(self.approachtype == "cover_corner_r")
	{
		var_00 = animscripts\swim::getswimanim("cover_corner_r");
	}
	else if(self.approachtype == "cover_corner_l")
	{
		var_00 = animscripts\swim::getswimanim("cover_corner_l");
	}
	else if(self.approachtype == "cover_u")
	{
		var_00 = animscripts\swim::getswimanim("cover_u");
	}
	else if(self.approachtype == "exposed")
	{
		var_00 = animscripts\swim::getswimanim("exposed");
	}
	else
	{
	}

	self.a.array["add_aim_up"] = var_00["add_aim_up"];
	self.a.array["add_aim_down"] = var_00["add_aim_down"];
	self.a.array["add_aim_left"] = var_00["add_aim_left"];
	self.a.array["add_aim_right"] = var_00["add_aim_right"];
	self.a.array["add_turn_aim_up"] = var_00["add_aim_up"];
	self.a.array["add_turn_aim_down"] = var_00["add_aim_down"];
	self.a.array["add_turn_aim_left"] = var_00["add_aim_left"];
	self.a.array["add_turn_aim_right"] = var_00["add_aim_right"];
	self.a.array["straight_level"] = var_00["straight_level"];
	self.a.array["fire"] = var_00["add_aim_straight"];
	self.a.array["semi2"] = var_00["add_aim_straight"];
	self.a.array["semi3"] = var_00["add_aim_straight"];
	self.a.array["semi4"] = var_00["add_aim_straight"];
	self.a.array["semi5"] = var_00["add_aim_straight"];
	self.a.array["single"] = animscripts\utility::array(var_00["add_aim_straight"]);
	self.a.array["burst2"] = var_00["add_aim_straight"];
	self.a.array["burst3"] = var_00["add_aim_straight"];
	self.a.array["burst4"] = var_00["add_aim_straight"];
	self.a.array["burst5"] = var_00["add_aim_straight"];
	self.a.array["burst6"] = var_00["add_aim_straight"];
	self.a.array["exposed_idle"] = animscripts\utility::array(var_00["add_aim_idle"]);
}

//Function Number: 59
runcombat()
{
	self notify("killanimscript");
	thread animscripts\combat::main();
}

//Function Number: 60
setdefaultcorneranimmode()
{
	if(self.swimmer)
	{
		self animmode("nogravity");
		return;
	}

	self animmode("zonly_physics");
}

//Function Number: 61
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

	self.facialidx = animscripts\face::playfacialanim(param_00,var_01,self.facialidx);
}

//Function Number: 62
corner_playaimfacialanim(param_00)
{
	self.facialidx = animscripts\face::playfacialanim(param_00,"aim",self.facialidx);
}

//Function Number: 63
corner_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}