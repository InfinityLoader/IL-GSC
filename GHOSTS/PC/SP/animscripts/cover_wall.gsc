/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_wall.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 709 ms
 * Timestamp: 10/27/2023 1:23:53 AM
*******************************************************************/

//Function Number: 1
init_animset_cover_wall()
{
	var_00 = [];
	var_00["add_aim_up"] = %covercrouch_aim8_add;
	var_00["add_aim_down"] = %covercrouch_aim2_add;
	var_00["add_aim_left"] = %covercrouch_aim4_add;
	var_00["add_aim_right"] = %covercrouch_aim6_add;
	var_00["straight_level"] = %covercrouch_aim5;
	var_00["hide_idle"] = %covercrouch_hide_idle;
	var_00["hide_idle_twitch"] = animscripts/utility::func_ED8(%covercrouch_twitch_1,%covercrouch_twitch_2,%covercrouch_twitch_3,%covercrouch_twitch_4);
	var_00["hide_idle_flinch"] = animscripts/utility::func_ED8();
	var_00["hide_2_crouch"] = %covercrouch_hide_2_aim;
	var_00["hide_2_stand"] = %covercrouch_hide_2_stand;
	var_00["hide_2_lean"] = %covercrouch_hide_2_lean;
	var_00["hide_2_right"] = %covercrouch_hide_2_right;
	var_00["hide_2_left"] = %covercrouch_hide_2_left;
	var_00["crouch_2_hide"] = %covercrouch_aim_2_hide;
	var_00["stand_2_hide"] = %covercrouch_stand_2_hide;
	var_00["lean_2_hide"] = %covercrouch_lean_2_hide;
	var_00["right_2_hide"] = %covercrouch_right_2_hide;
	var_00["left_2_hide"] = %covercrouch_left_2_hide;
	var_00["crouch_aim"] = %covercrouch_aim5;
	var_00["stand_aim"] = %exposed_aim_5;
	var_00["lean_aim"] = %covercrouch_lean_aim5;
	var_00["fire"] = %exposed_shoot_auto_v2;
	var_00["semi2"] = %exposed_shoot_semi2;
	var_00["semi3"] = %exposed_shoot_semi3;
	var_00["semi4"] = %exposed_shoot_semi4;
	var_00["semi5"] = %exposed_shoot_semi5;
	var_00["single"] = [%exposed_shoot_semi1];
	var_00["burst2"] = %exposed_shoot_burst3;
	var_00["burst3"] = %exposed_shoot_burst3;
	var_00["burst4"] = %exposed_shoot_burst4;
	var_00["burst5"] = %exposed_shoot_burst5;
	var_00["burst6"] = %exposed_shoot_burst6;
	var_00["blind_fire"] = animscripts/utility::func_ED8(%covercrouch_blindfire_1,%covercrouch_blindfire_2,%covercrouch_blindfire_3,%covercrouch_blindfire_4);
	var_00["reload"] = %covercrouch_reload_hide;
	var_00["grenade_safe"] = animscripts/utility::func_ED8(%covercrouch_grenadea,%covercrouch_grenadeb);
	var_00["grenade_exposed"] = animscripts/utility::func_ED8(%covercrouch_grenadea,%covercrouch_grenadeb);
	var_00["exposed_idle"] = animscripts/utility::func_ED8(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	var_00["look"] = animscripts/utility::func_ED8(%covercrouch_hide_look);
	level.archetypes["soldier"]["cover_crouch"] = var_00;
	var_00 = [];
	var_00["add_aim_up"] = %coverstandaim_aim8_add;
	var_00["add_aim_down"] = %coverstandaim_aim2_add;
	var_00["add_aim_left"] = %coverstandaim_aim4_add;
	var_00["add_aim_right"] = %coverstandaim_aim6_add;
	var_00["straight_level"] = %coverstandaim_aim5;
	var_00["hide_idle"] = %coverstand_hide_idle;
	var_00["hide_idle_twitch"] = animscripts/utility::func_ED8(%coverstand_hide_idle_twitch01,%coverstand_hide_idle_twitch02,%coverstand_hide_idle_twitch03,%coverstand_hide_idle_twitch04,%coverstand_hide_idle_twitch05);
	var_00["hide_idle_flinch"] = animscripts/utility::func_ED8(%coverstand_react01,%coverstand_react02,%coverstand_react03,%coverstand_react04);
	var_00["hide_2_stand"] = %coverstand_hide_2_aim;
	var_00["stand_2_hide"] = %coverstand_aim_2_hide;
	var_00["hide_2_over"] = %coverstand_2_coverstandaim;
	var_00["over_2_hide"] = %coverstandaim_2_coverstand;
	var_00["over_aim"] = %coverstandaim_aim5;
	var_00["fire"] = %coverstandaim_autofire;
	var_00["semi2"] = %coverstandaim_fire;
	var_00["semi3"] = %coverstandaim_fire;
	var_00["semi4"] = %coverstandaim_fire;
	var_00["semi5"] = %coverstandaim_fire;
	var_00["single"] = animscripts/utility::func_ED8(%coverstandaim_fire);
	var_00["burst2"] = %coverstandaim_autofire;
	var_00["burst3"] = %coverstandaim_autofire;
	var_00["burst4"] = %coverstandaim_autofire;
	var_00["burst5"] = %coverstandaim_autofire;
	var_00["burst6"] = %coverstandaim_autofire;
	var_00["blind_fire"] = animscripts/utility::func_ED8(%coverstand_blindfire_1,%coverstand_blindfire_2);
	var_00["reload"] = %coverstand_reloada;
	var_00["look"] = animscripts/utility::func_ED8(%coverstand_look_quick,%coverstand_look_quick_v2);
	var_00["grenade_safe"] = animscripts/utility::func_ED8(%coverstand_grenadea,%coverstand_grenadeb);
	var_00["grenade_exposed"] = animscripts/utility::func_ED8(%coverstand_grenadea,%coverstand_grenadeb);
	var_00["exposed_idle"] = animscripts/utility::func_ED8(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	var_00["hide_to_look"] = %coverstand_look_moveup;
	var_00["look_idle"] = %coverstand_look_idle;
	var_00["look_to_hide"] = %coverstand_look_movedown;
	var_00["look_to_hide_fast"] = %coverstand_look_movedown_fast;
	level.archetypes["soldier"]["cover_stand"] = var_00;
}

//Function Number: 2
func_1FA9(param_00)
{
	self endon("killanimscript");
	self.var_1FCA = self.node;
	self.covertype = param_00;
	if(!isdefined(self.node.turret))
	{
		animscripts/cover_behavior::func_84C1(0);
	}

	if(param_00 == "crouch")
	{
		func_711E("unknown");
		self.var_1FCA func_45FC();
	}
	else
	{
		func_7120("unknown");
	}

	self.a.aimidlethread = undefined;
	self orientmode("face angle",self.var_1FCA.angles[1]);
	if(isdefined(self.weapon) && animscripts/utility::usingmg() && isdefined(self.node) && isdefined(self.node.turretinfo) && canspawnturret())
	{
		if(param_00 == "crouch")
		{
			if(func_4951(self.weapon))
			{
				var_01 = "rpd_bipod_crouch";
			}
			else
			{
				var_01 = "saw_bipod_crouch";
			}
		}
		else if(func_4951(self.weapon))
		{
			var_01 = "rpd_bipod_stand";
		}
		else
		{
			var_01 = "saw_bipod_stand";
		}

		if(func_4951(self.weapon))
		{
			var_02 = "weapon_rpd_MG_Setup";
		}
		else
		{
			var_02 = "weapon_saw_MG_Setup";
		}

		func_87D1(var_01,var_02);
	}
	else if(isdefined(self.node) && isdefined(self.node.turret))
	{
		func_87D6();
	}

	self animmode("normal");
	if(param_00 == "crouch" && self.a.var_60B1 == "stand")
	{
		var_03 = animscripts/utility::animarray("stand_2_hide");
		var_04 = getanimlength(var_03);
		self setanimknoballrestart(var_03,%body,1,0.2,animscripts/combat_utility::func_31EE());
		thread animscripts/shared::func_54BF(self.var_1FCA,var_04);
		wait(var_04);
		self.a.covermode = "hide";
	}
	else
	{
		func_4F7D(0.4);
		if(distancesquared(self.origin,self.var_1FCA.origin) > 1)
		{
			thread animscripts/shared::func_54BF(self.var_1FCA,0.4);
			wait(0.2);
			if(param_00 == "crouch")
			{
				self.a.var_60B1 = "crouch";
			}

			wait(0.2);
		}
		else
		{
			wait(0.1);
		}
	}

	func_7019();
	if(param_00 == "crouch")
	{
		if(self.a.var_60B1 == "prone")
		{
			animscripts/utility::exitpronewrapper(1);
		}

		self.a.var_60B1 = "crouch";
	}

	if(self.covertype == "stand")
	{
		self.a.var_78D0 = "cover_stand";
	}
	else
	{
		self.a.var_78D0 = "cover_crouch";
	}

	var_05 = spawnstruct();
	if(!self.fixednode)
	{
		var_05.var_54BE = ::animscripts/cover_behavior::func_54BE;
	}

	var_05.reload = ::coverreload;
	var_05.leavecoverandshoot = ::func_609F;
	var_05.look = ::look;
	var_05.var_31EF = ::func_31EF;
	var_05.var_43C6 = ::func_43C6;
	var_05.var_3427 = ::func_3427;
	var_05.grenade = ::func_8406;
	var_05.var_3DB1 = ::func_8407;
	var_05.blindfire = ::blindfire;
	animscripts/cover_behavior::func_4FDD(var_05);
}

//Function Number: 3
func_4951(param_00)
{
	return getsubstr(param_00,0,3) == "rpd" && param_00.size == 3 || param_00[3] == "_";
}

//Function Number: 4
func_45FC()
{
	if(isdefined(self.var_2151))
	{
	}

	var_00 = (0,0,42);
	var_01 = anglestoforward(self.angles);
	self.var_2151 = sighttracepassed(self.origin + var_00,self.origin + var_00 + var_01 * 64,0,undefined);
}

//Function Number: 5
func_711E(param_00)
{
	animscripts/combat::func_6E7C(self.var_1FCA);
	func_7122(param_00);
}

//Function Number: 6
func_7120(param_00)
{
	animscripts/combat::func_6E7C(self.var_1FCA);
	func_71CE(param_00);
}

//Function Number: 7
coverreload()
{
	var_00 = animscripts/combat_utility::reload(2,animscripts/utility::animarray("reload"));
	if(isdefined(var_00) && var_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_609F()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.var_62FD) && randomfloat(1) < self.var_62FD)
	{
		if(func_62F8())
		{
			return 1;
		}
	}

	if(!func_6099())
	{
		return 0;
	}

	func_7430();
	animscripts/combat_utility::func_2D52();
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
		}
	}

	func_3D56();
	self.covercrouchlean_aimmode = undefined;
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 9
func_7430()
{
	self endon("return_to_cover");
	maps\_gameskill::didsomethingotherthanshooting();
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

		if(self.covertype == "crouch" && func_5594())
		{
			break;
		}

		func_744F();
		self clearanim(%add_fire,0.2);
	}
}

//Function Number: 10
func_744F()
{
	if(self.covertype == "crouch")
	{
		thread anglerangethread();
	}

	thread animscripts/combat_utility::aimidlethread();
	animscripts/combat_utility::func_744D();
}

//Function Number: 11
func_62F8()
{
	if(!animscripts/utility::hasenemysightpos())
	{
		return 0;
	}

	var_00 = "rambo";
	if(randomint(10) < 2)
	{
		var_00 = "rambo_fail";
	}

	if(!animscripts/utility::animarrayanyexist(var_00))
	{
		return 0;
	}

	if(self.covertype == "crouch" && !self.var_1FCA.var_2151)
	{
		return 0;
	}

	var_01 = func_3BE6(self.var_1FCA.origin + animscripts/utility::func_3B50(self.var_1FCA));
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

	self.coverposestablishedtime = gettime();
	func_7019();
	self.keepclaimednodeifvalid = 1;
	self.var_4940 = 1;
	self.a.prevattack = "rambo";
	self.changingcoverpos = 1;
	thread animscripts/shared::func_62FA(0);
	var_04 = animscripts/utility::animarraypickrandom(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0.2,1);
	func_1FA7(var_04);
	animscripts/shared::func_2986("rambo");
	self notify("rambo_aim_end");
	self.changingcoverpos = 0;
	self.keepclaimednodeifvalid = 0;
	self.var_4C90 = gettime();
	self.changingcoverpos = 0;
	self.var_4940 = undefined;
	return 1;
}

//Function Number: 12
func_43C6()
{
	self endon("end_idle");
	for(;;)
	{
		var_00 = randomint(2) == 0 && animscripts/utility::animarrayanyexist("hide_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts/utility::animarraypickrandom("hide_idle_twitch");
		}
		else
		{
			var_01 = animscripts/utility::animarray("hide_idle");
		}

		func_6017(var_01,var_00);
	}
}

//Function Number: 13
func_3427()
{
	if(!animscripts/utility::animarrayanyexist("hide_idle_flinch"))
	{
		return 0;
	}

	var_00 = anglestoforward(self.angles);
	var_01 = self.origin + var_00 * -16;
	if(!self maymovetopoint(var_01,!self.swimmer))
	{
		return 0;
	}

	func_7019();
	self.keepclaimednodeifvalid = 1;
	var_02 = animscripts/utility::animarraypickrandom("hide_idle_flinch");
	func_6017(var_02,1);
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 14
func_6017(param_00,param_01)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("idle",param_00,%body,1,0.25,1);
	}
	else
	{
		self setflaggedanimknoball("idle",param_00,%body,1,0.25,1);
	}

	func_1FA7(param_00);
	self.a.covermode = "hide";
	animscripts/shared::func_2986("idle");
}

//Function Number: 15
look(param_00)
{
	if(!isdefined(self.a.var_ED8["hide_to_look"]))
	{
		return 0;
	}

	if(!func_5B75())
	{
		return 0;
	}

	animscripts/shared::playlookanimation(animscripts/utility::animarray("look_idle"),param_00);
	var_01 = undefined;
	if(animscripts/utility::func_4979())
	{
		var_01 = animscripts/utility::animarray("look_to_hide_fast");
	}
	else
	{
		var_01 = animscripts/utility::animarray("look_to_hide");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1);
	func_1FA7(var_01);
	animscripts/shared::func_2986("looking_end");
	return 1;
}

//Function Number: 16
func_5B75()
{
	if(isdefined(self.var_1FCA.var_6B93))
	{
		return 0;
	}

	var_00 = animscripts/utility::animarray("hide_to_look");
	self setflaggedanimknoball("looking_start",var_00,%body,1,0.2);
	func_1FA7(var_00);
	animscripts/shared::func_2986("looking_start");
	return 1;
}

//Function Number: 17
func_31EF()
{
	var_00 = animscripts/utility::animarraypickrandom("look");
	self setflaggedanimknoballrestart("look",var_00,%body,1,0.1);
	func_1FA7(var_00);
	animscripts/shared::func_2986("look");
	return 1;
}

//Function Number: 18
func_609A()
{
	if(self.a.covermode == "left" || self.a.covermode == "right" || self.a.covermode == "over")
	{
		return 1;
	}

	return animscripts/combat_utility::func_6332();
}

//Function Number: 19
func_6099()
{
	var_00 = func_3A38();
	var_01 = 0.1;
	var_02 = animscripts/utility::animarray("hide_2_" + var_00);
	var_03 = !self.swimmer;
	if(!self maymovetopoint(animscripts/utility::func_3A23(var_02),var_03))
	{
		return 0;
	}

	if(self.script == "cover_crouch" && var_00 == "lean")
	{
		self.covercrouchlean_aimmode = 1;
	}

	if(self.covertype == "crouch")
	{
		func_711E(var_00);
	}
	else
	{
		func_7120(var_00);
	}

	self.a.var_78D0 = "none";
	self.var_78EB = undefined;
	if(self.covertype == "stand")
	{
		self.a.var_78D0 = "cover_stand_aim";
	}
	else
	{
		self.a.var_78D0 = "cover_crouch_aim";
	}

	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	func_7019();
	var_04 = func_609A();
	self setflaggedanimknoballrestart("pop_up",var_02,%body,1,0.1,var_04);
	thread donotetracksforpopup("pop_up");
	if(animhasnotetrack(var_02,"start_aim"))
	{
		self waittillmatch("start_aim","pop_up");
		var_01 = getanimlength(var_02) / var_04 * 1 - self getanimtime(var_02);
	}
	else
	{
		self waittillmatch("end","pop_up");
		var_01 = 0.1;
	}

	self clearanim(var_02,var_01 + 0.05);
	self.a.covermode = var_00;
	self.a.prevattack = var_00;
	func_70F1(var_01);
	thread animscripts/track::trackshootentorpos();
	wait(var_01);
	if(animscripts/combat_utility::issniper())
	{
		thread animscripts/shoot_behavior::func_7665();
	}

	self.changingcoverpos = 0;
	self.coverposestablishedtime = gettime();
	self notify("stop_popup_donotetracks");
	return 1;
}

//Function Number: 20
donotetracksforpopup(param_00)
{
	self endon("killanimscript");
	self endon("stop_popup_donotetracks");
	animscripts/shared::func_2986(param_00);
}

//Function Number: 21
func_70F1(param_00)
{
	if(self.a.covermode == "left" || self.a.covermode == "right")
	{
		var_01 = "crouch";
	}
	else
	{
		var_01 = self.a.covermode;
	}

	self setanimknoball(animscripts/utility::animarray(var_01 + "_aim"),%body,1,param_00);
	if(var_01 == "crouch")
	{
		self setanimlimited(animscripts/utility::lookupanim("cover_crouch","add_aim_down"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("cover_crouch","add_aim_left"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("cover_crouch","add_aim_up"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("cover_crouch","add_aim_right"),1,0);
	}

	if(var_01 == "stand")
	{
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_right"),1,0);
	}

	if(var_01 == "lean")
	{
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("default_stand","add_aim_right"),1,0);
	}

	if(var_01 == "over")
	{
		self setanimlimited(animscripts/utility::lookupanim("cover_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("cover_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("cover_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts/utility::lookupanim("cover_stand","add_aim_right"),1,0);
	}
}

//Function Number: 22
func_3D56()
{
	self notify("return_to_cover");
	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	animscripts/combat_utility::func_2D4B();
	var_00 = func_609A();
	self setflaggedanimknoball("go_to_hide",animscripts/utility::animarray(self.a.covermode + "_2_hide"),%body,1,0.2,var_00);
	self clearanim(%exposed_modern,0.2);
	animscripts/shared::func_2986("go_to_hide");
	self.a.covermode = "hide";
	if(self.covertype == "stand")
	{
		self.a.var_78D0 = "cover_stand";
	}
	else
	{
		self.a.var_78D0 = "cover_crouch";
	}

	self.changingcoverpos = 0;
}

//Function Number: 23
func_8407(param_00)
{
	return func_8406(param_00,1);
}

//Function Number: 24
func_8406(param_00,param_01)
{
	if(isdefined(self.var_29AA) || isdefined(param_00.var_29A1))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.var_62FD) && randomfloat(1) < self.var_62FD)
	{
		var_02 = animscripts/utility::animarraypickrandom("grenade_rambo");
	}
	else if(isdefined(param_01) && param_01)
	{
		var_02 = animscripts/utility::animarraypickrandom("grenade_safe");
	}
	else
	{
		var_02 = animscripts/utility::animarraypickrandom("grenade_exposed");
	}

	func_7019();
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts/combat_utility::func_8400(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 25
blindfire()
{
	if(!animscripts/utility::animarrayanyexist("blind_fire"))
	{
		return 0;
	}

	func_7019();
	self.keepclaimednodeifvalid = 1;
	self setflaggedanimknoballrestart("blindfire",animscripts/utility::animarraypickrandom("blind_fire"),%body,1,0.2,1);
	animscripts/shared::func_2986("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 26
createturret(param_00,param_01,param_02)
{
	var_03 = spawnturret("misc_turret",param_00.origin,param_01);
	var_03.angles = param_00.angles;
	var_03.aiowner = self;
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

//Function Number: 27
deleteifnotused(param_00)
{
	self endon("death");
	self endon("being_used");
	wait(0.1);
	if(isdefined(param_00))
	{
		param_00 notify("turret_use_failed");
	}

	self delete();
}

//Function Number: 28
func_87D1(param_00,param_01)
{
	var_02 = createturret(self.node.turretinfo,param_00,param_01);
	if(self useturret(var_02))
	{
		var_02 thread deleteifnotused(self);
		if(isdefined(self.turret_function))
		{
			thread [[ self.turret_function ]](var_02);
		}

		self waittill("turret_use_failed");
	}

	var_02 delete();
}

//Function Number: 29
func_87D6()
{
	var_00 = self.node.turret;
	if(!var_00.issetup)
	{
	}

	thread maps\_mg_penetration::func_3E14(var_00);
	self waittill("continue_cover_script");
}

//Function Number: 30
func_7122(param_00)
{
	self.a.var_ED8 = animscripts/utility::func_4F5D("cover_crouch");
	if(animscripts/utility::func_8D9B())
	{
		if(param_00 == "lean" || param_00 == "stand")
		{
			self.a.var_ED8["single"] = animscripts/utility::lookupanim("shotgun_stand","single");
		}
		else
		{
			self.a.var_ED8["single"] = animscripts/utility::lookupanim("shotgun_crouch","single");
		}
	}

	if(isdefined(level.var_62FC))
	{
		self.a.var_ED8["rambo"] = level.var_62FC.var_1FAC;
		self.a.var_ED8["rambo_fail"] = level.var_62FC.covercrouchfail;
		self.a.var_ED8["grenade_rambo"] = level.var_62FC.covercrouchgrenade;
	}
}

//Function Number: 31
func_71CE(param_00)
{
	self.a.var_ED8 = animscripts/utility::func_4F5D("cover_stand");
	if(param_00 != "over")
	{
		var_01 = animscripts/utility::func_4F5D("default_stand");
		self.a.var_ED8["stand_aim"] = var_01["straight_level"];
		self.a.var_ED8["fire"] = var_01["fire_corner"];
		self.a.var_ED8["semi2"] = var_01["semi2"];
		self.a.var_ED8["semi3"] = var_01["semi3"];
		self.a.var_ED8["semi4"] = var_01["semi4"];
		self.a.var_ED8["semi5"] = var_01["semi5"];
		if(animscripts/utility::func_8D9B())
		{
			self.a.var_ED8["single"] = animscripts/utility::lookupanim("shotgun_stand","single");
		}
		else
		{
			self.a.var_ED8["single"] = var_01["single"];
		}

		self.a.var_ED8["burst2"] = var_01["burst2"];
		self.a.var_ED8["burst3"] = var_01["burst3"];
		self.a.var_ED8["burst4"] = var_01["burst4"];
		self.a.var_ED8["burst5"] = var_01["burst5"];
		self.a.var_ED8["burst6"] = var_01["burst6"];
	}

	if(isdefined(level.var_62FC))
	{
		self.a.var_ED8["rambo"] = level.var_62FC.coverstand;
		self.a.var_ED8["rambo_fail"] = level.var_62FC.coverstandfail;
		self.a.var_ED8["grenade_rambo"] = level.var_62FC.coverstandgrenade;
	}
}

//Function Number: 32
func_4F7D(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.1;
	}

	self setanimknoballrestart(animscripts/utility::animarray("hide_idle"),%body,1,param_00);
	self.a.covermode = "hide";
}

//Function Number: 33
anglerangethread()
{
	self endon("killanimscript");
	self notify("newAngleRangeCheck");
	self endon("newAngleRangeCheck");
	self endon("return_to_cover");
	for(;;)
	{
		if(func_5594())
		{
			break;
		}

		wait(0.1);
	}

	self notify("stopShooting");
}

//Function Number: 34
func_5594()
{
	if(self.covertype != "crouch")
	{
		return 0;
	}

	var_00 = func_3BE6(self geteye());
	if(self.a.covermode == "lean")
	{
		return var_00 < 10;
	}

	return var_00 > 45;
}

//Function Number: 35
func_3A38()
{
	var_00 = [];
	if(self.covertype == "stand")
	{
		var_00 = self.var_1FCA getvalidcoverpeekouts();
		var_00[var_00.size] = "stand";
	}
	else
	{
		var_01 = func_3BE6(self.var_1FCA.origin + animscripts/utility::func_3B50(self.var_1FCA));
		if(var_01 > 30)
		{
			return "lean";
		}

		if(var_01 > 15 || !self.var_1FCA.var_2151)
		{
			return "stand";
		}

		var_00 = self.var_1FCA getvalidcoverpeekouts();
		var_00[var_00.size] = "crouch";
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(!isdefined(self.a.var_ED8["hide_2_" + var_00[var_02]]))
		{
			var_00[var_02] = var_00[var_00.size - 1];
			var_00[var_00.size - 1] = undefined;
			continue;
		}
	}

	return animscripts/combat_utility::func_3BB6(var_00);
}

//Function Number: 36
func_3BE6(param_00)
{
	var_01 = animscripts/utility::getenemyeyepos();
	return angleclamp180(vectortoangles(var_01 - param_00)[0]);
}

//Function Number: 37
func_7019()
{
	if(self.swimmer)
	{
		self animmode("nogravity");
	}

	self animmode("zonly_physics");
}

//Function Number: 38
func_1FA7(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "run";
	}

	self.facialidx = animscripts/face::func_6004(param_00,param_01,self.facialidx);
}

//Function Number: 39
func_1FA3()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}