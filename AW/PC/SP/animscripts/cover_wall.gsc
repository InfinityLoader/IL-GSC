/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_wall.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 681 ms
 * Timestamp: 10/27/2023 1:54:56 AM
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
	var_00["hide_idle_twitch"] = animscripts\utility::array(%covercrouch_twitch_1,%covercrouch_twitch_2,%covercrouch_twitch_3,%covercrouch_twitch_4);
	var_00["hide_idle_flinch"] = animscripts\utility::array();
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
	var_00["smg_hide_2_stand"] = %smg_covercrouch_hide_2_stand;
	var_00["smg_stand_2_hide"] = %smg_covercrouch_stand_2_hide;
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
	var_00["blind_fire"] = animscripts\utility::array(%covercrouch_blindfire_1,%covercrouch_blindfire_2,%covercrouch_blindfire_3,%covercrouch_blindfire_4);
	var_00["reload"] = %covercrouch_reload_hide;
	var_00["grenade_safe"] = animscripts\utility::array(%covercrouch_grenadea,%covercrouch_grenadeb);
	var_00["grenade_exposed"] = animscripts\utility::array(%covercrouch_grenadea,%covercrouch_grenadeb);
	var_00["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	var_00["look"] = animscripts\utility::array(%covercrouch_hide_look);
	level.archetypes["soldier"]["cover_crouch"] = var_00;
	var_00 = [];
	var_00["add_aim_up"] = %coverstandaim_aim8_add;
	var_00["add_aim_down"] = %coverstandaim_aim2_add;
	var_00["add_aim_left"] = %coverstandaim_aim4_add;
	var_00["add_aim_right"] = %coverstandaim_aim6_add;
	var_00["straight_level"] = %coverstandaim_aim5;
	var_00["hide_idle"] = %coverstand_hide_idle;
	var_00["hide_idle_twitch"] = animscripts\utility::array(%coverstand_hide_idle_twitch01,%coverstand_hide_idle_twitch02,%coverstand_hide_idle_twitch03,%coverstand_hide_idle_twitch04,%coverstand_hide_idle_twitch05);
	var_00["hide_idle_flinch"] = animscripts\utility::array(%coverstand_react01,%coverstand_react02,%coverstand_react03,%coverstand_react04);
	var_00["hide_2_stand"] = %coverstand_hide_2_aim;
	var_00["stand_2_hide"] = %coverstand_aim_2_hide;
	var_00["smg_hide_2_stand"] = %smg_coverstand_hide_2_aim;
	var_00["smg_stand_2_hide"] = %smg_coverstand_aim_2_hide;
	var_00["hide_2_over"] = %coverstand_2_coverstandaim;
	var_00["over_2_hide"] = %coverstandaim_2_coverstand;
	var_00["over_aim"] = %coverstandaim_aim5;
	var_00["fire"] = %coverstandaim_autofire;
	var_00["semi2"] = %coverstandaim_fire;
	var_00["semi3"] = %coverstandaim_fire;
	var_00["semi4"] = %coverstandaim_fire;
	var_00["semi5"] = %coverstandaim_fire;
	var_00["single"] = animscripts\utility::array(%coverstandaim_fire);
	var_00["burst2"] = %coverstandaim_autofire;
	var_00["burst3"] = %coverstandaim_autofire;
	var_00["burst4"] = %coverstandaim_autofire;
	var_00["burst5"] = %coverstandaim_autofire;
	var_00["burst6"] = %coverstandaim_autofire;
	var_00["blind_fire"] = animscripts\utility::array(%coverstand_blindfire_1,%coverstand_blindfire_2);
	var_00["reload"] = %coverstand_reloada;
	var_00["look"] = animscripts\utility::array(%coverstand_look_quick,%coverstand_look_quick_v2);
	var_00["grenade_safe"] = animscripts\utility::array(%coverstand_grenadea,%coverstand_grenadeb);
	var_00["grenade_exposed"] = animscripts\utility::array(%coverstand_grenadea,%coverstand_grenadeb);
	var_00["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	var_00["hide_to_look"] = %coverstand_look_moveup;
	var_00["look_idle"] = %coverstand_look_idle;
	var_00["look_to_hide"] = %coverstand_look_movedown;
	var_00["look_to_hide_fast"] = %coverstand_look_movedown_fast;
	level.archetypes["soldier"]["cover_stand"] = var_00;
}

//Function Number: 2
cover_wall_think(param_00)
{
	self endon("killanimscript");
	self.covernode = self.node;
	self.covertype = param_00;
	if(!isdefined(self.node.turret))
	{
		animscripts\cover_behavior::turntomatchnodedirection(0);
	}

	if(param_00 == "crouch")
	{
		setup_cover_crouch("unknown");
		self.covernode initcovercrouchnode();
	}
	else
	{
		setup_cover_stand("unknown");
		self.covernode initcoverstandnode();
	}

	self.a.aimidlethread = undefined;
	self orientmode("face angle",self.covernode.angles[1]);
	if(isdefined(self.weapon) && animscripts\utility::usingmg() && isdefined(self.node) && isdefined(self.node.turretinfo) && canspawnturret())
	{
		if(param_00 == "crouch")
		{
			if(isrpd(self.weapon))
			{
				var_01 = "rpd_bipod_crouch";
			}
			else
			{
				var_01 = "saw_bipod_crouch";
			}
		}
		else if(isrpd(self.weapon))
		{
			var_01 = "rpd_bipod_stand";
		}
		else
		{
			var_01 = "saw_bipod_stand";
		}

		if(isrpd(self.weapon))
		{
			var_02 = "weapon_rpd_MG_Setup";
		}
		else
		{
			var_02 = "weapon_saw_MG_Setup";
		}

		useselfplacedturret(var_01,var_02);
	}
	else if(isdefined(self.node) && isdefined(self.node.turret))
	{
		usestationaryturret();
	}

	self animmode("normal");
	if(param_00 == "crouch" && self.a.pose == "stand")
	{
		var_03 = animscripts\utility::animarray("stand_2_hide");
		if(animscripts\utility::usingsmg())
		{
			var_03 = animscripts\utility::animarray("smg_stand_2_hide");
		}

		var_04 = getanimlength(var_03);
		self setanimknoballrestart(var_03,%body,1,0.2,animscripts\combat_utility::fasteranimspeed());
		thread animscripts\shared::movetonodeovertime(self.covernode,var_04);
		wait(var_04);
		self.a.covermode = "hide";
	}
	else
	{
		loophide(0.4);
		if(distancesquared(self.origin,self.covernode.origin) > 1)
		{
			thread animscripts\shared::movetonodeovertime(self.covernode,0.4);
			wait(0.2);
			if(param_00 == "crouch")
			{
				self.a.pose = "crouch";
			}

			wait(0.2);
		}
		else
		{
			wait(0.1);
		}
	}

	setdefaultwallanimmode();
	if(param_00 == "crouch")
	{
		if(self.a.pose == "prone")
		{
			animscripts\utility::exitpronewrapper(1);
		}

		self.a.pose = "crouch";
	}

	if(self.covertype == "stand")
	{
		self.a.special = "cover_stand";
	}
	else
	{
		self.a.special = "cover_crouch";
	}

	var_05 = spawnstruct();
	if(!self.fixednode)
	{
		var_05.movetonearbycover = ::animscripts\cover_behavior::movetonearbycover;
	}

	var_05.reload = ::coverreload;
	var_05.leavecoverandshoot = ::popupandshoot;
	var_05.look = ::look;
	var_05.fastlook = ::fastlook;
	var_05.idle = ::idle;
	var_05.flinch = ::flinch;
	var_05.grenade = ::trythrowinggrenade;
	var_05.grenadehidden = ::trythrowinggrenadestayhidden;
	var_05.blindfire = ::blindfire;
	animscripts\cover_behavior::main(var_05);
}

//Function Number: 3
isrpd(param_00)
{
	return getsubstr(param_00,0,3) == "rpd" && param_00.size == 3 || param_00[3] == "_";
}

//Function Number: 4
initcovercrouchnode()
{
	if(isdefined(self.crouchingisok))
	{
		return;
	}

	var_00 = (0,0,42);
	var_01 = anglestoforward(self.angles);
	self.crouchingisok = sighttracepassed(self.origin + var_00,self.origin + var_00 + var_01 * 64,0,undefined);
}

//Function Number: 5
initcoverstandnode()
{
	if(isdefined(self.lowstandisok))
	{
		return;
	}

	var_00 = (0,0,48);
	var_01 = anglestoforward(self.angles);
	self.lowstandisok = sighttracepassed(self.origin + var_00,self.origin + var_00 + var_01 * 64,0,undefined);
}

//Function Number: 6
setup_cover_crouch(param_00)
{
	animscripts\combat::set_default_aim_limits(self.covernode);
	setup_crouching_anim_array(param_00);
}

//Function Number: 7
setup_cover_stand(param_00)
{
	animscripts\combat::set_default_aim_limits(self.covernode);
	setup_standing_anim_array(param_00);
}

//Function Number: 8
coverreload()
{
	var_00 = animscripts\combat_utility::reload(2,animscripts\utility::animarray("reload"));
	if(isdefined(var_00) && var_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
popupandshoot()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(rambo())
		{
			return 1;
		}
	}

	if(!pop_up())
	{
		return 0;
	}

	shootastold();
	animscripts\combat_utility::endfireandanimidlethread();
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
		}
	}

	go_to_hide();
	self.covercrouchlean_aimmode = undefined;
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 10
shootastold()
{
	self endon("return_to_cover");
	maps\_gameskill::didsomethingotherthanshooting();
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

		if(self.covertype == "crouch" && needtochangecovermode())
		{
			break;
		}

		shootuntilshootbehaviorchange_coverwall();
		self clearanim(%add_fire,0.2);
	}
}

//Function Number: 11
shootuntilshootbehaviorchange_coverwall()
{
	if(self.covertype == "crouch")
	{
		thread anglerangethread();
	}

	thread animscripts\combat_utility::aimidlethread();
	animscripts\combat_utility::shootuntilshootbehaviorchange();
}

//Function Number: 12
rambo()
{
	if(!animscripts\utility::hasenemysightpos())
	{
		return 0;
	}

	var_00 = "rambo";
	if(randomint(10) < 2)
	{
		var_00 = "rambo_fail";
	}

	if(!animscripts\utility::animarrayanyexist(var_00))
	{
		return 0;
	}

	if(self.covertype == "crouch" && !self.covernode.crouchingisok)
	{
		return 0;
	}

	var_01 = getshootpospitch(self.covernode.origin + animscripts\utility::getnodeoffset(self.covernode));
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
	setdefaultwallanimmode();
	self.keepclaimednodeifvalid = 1;
	self.isrambo = 1;
	self.a.prevattack = "rambo";
	self.changingcoverpos = 1;
	thread animscripts\shared::ramboaim(0);
	var_04 = animscripts\utility::animarraypickrandom(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0.2,1);
	cover_playfacialanim(var_04);
	animscripts\shared::donotetracks("rambo");
	self notify("rambo_aim_end");
	self.changingcoverpos = 0;
	self.keepclaimednodeifvalid = 0;
	self.lastrambotime = gettime();
	self.changingcoverpos = 0;
	self.isrambo = undefined;
	return 1;
}

//Function Number: 13
idle()
{
	self endon("end_idle");
	for(;;)
	{
		var_00 = randomint(2) == 0 && animscripts\utility::animarrayanyexist("hide_idle_twitch");
		if(var_00)
		{
			var_01 = animscripts\utility::animarraypickrandom("hide_idle_twitch");
		}
		else
		{
			var_01 = animscripts\utility::animarray("hide_idle");
		}

		playidleanimation(var_01,var_00);
	}
}

//Function Number: 14
flinch()
{
	if(!animscripts\utility::animarrayanyexist("hide_idle_flinch"))
	{
		return 0;
	}

	var_00 = anglestoforward(self.angles);
	var_01 = self.origin + var_00 * -16;
	if(!self maymovetopoint(var_01,!self.swimmer))
	{
		return 0;
	}

	setdefaultwallanimmode();
	self.keepclaimednodeifvalid = 1;
	var_02 = animscripts\utility::animarraypickrandom("hide_idle_flinch");
	playidleanimation(var_02,1);
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 15
playidleanimation(param_00,param_01)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("idle",param_00,%body,1,0.25,1);
	}
	else
	{
		self setflaggedanimknoball("idle",param_00,%body,1,0.25,1);
	}

	cover_playfacialanim(param_00);
	self.a.covermode = "hide";
	animscripts\shared::donotetracks("idle");
}

//Function Number: 16
look(param_00)
{
	if(!isdefined(self.a.array["hide_to_look"]))
	{
		return 0;
	}

	if(!peekout())
	{
		return 0;
	}

	animscripts\shared::playlookanimation(animscripts\utility::animarray("look_idle"),param_00);
	var_01 = undefined;
	if(animscripts\utility::issuppressedwrapper())
	{
		var_01 = animscripts\utility::animarray("look_to_hide_fast");
	}
	else
	{
		var_01 = animscripts\utility::animarray("look_to_hide");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1);
	cover_playfacialanim(var_01);
	animscripts\shared::donotetracks("looking_end");
	return 1;
}

//Function Number: 17
peekout()
{
	if(isdefined(self.covernode.script_dontpeek))
	{
		return 0;
	}

	var_00 = animscripts\utility::animarray("hide_to_look");
	self setflaggedanimknoball("looking_start",var_00,%body,1,0.2);
	cover_playfacialanim(var_00);
	animscripts\shared::donotetracks("looking_start");
	return 1;
}

//Function Number: 18
fastlook()
{
	var_00 = animscripts\utility::animarraypickrandom("look");
	self setflaggedanimknoballrestart("look",var_00,%body,1,0.1);
	cover_playfacialanim(var_00);
	animscripts\shared::donotetracks("look");
	return 1;
}

//Function Number: 19
pop_up_and_hide_speed()
{
	if(self.a.covermode == "left" || self.a.covermode == "right" || self.a.covermode == "over")
	{
		return 1;
	}

	return animscripts\combat_utility::randomfasteranimspeed();
}

//Function Number: 20
pop_up()
{
	var_00 = getbestcovermode();
	var_01 = 0.1;
	var_02 = animscripts\utility::animarray("hide_2_" + var_00);
	var_03 = !self.swimmer;
	if(!self maymovetopoint(animscripts\utility::getanimendpos(var_02),var_03))
	{
		return 0;
	}

	if(self.script == "cover_crouch" && var_00 == "lean")
	{
		self.covercrouchlean_aimmode = 1;
	}

	if(self.covertype == "crouch")
	{
		setup_cover_crouch(var_00);
	}
	else
	{
		setup_cover_stand(var_00);
	}

	self.a.special = "none";
	self.specialdeathfunc = undefined;
	if(self.covertype == "stand")
	{
		if(animscripts\utility::usingsmg())
		{
			self.a.special = "smg_cover_stand_aim";
		}
		else
		{
			self.a.special = "cover_stand_aim";
		}
	}
	else
	{
		self.a.special = "cover_crouch_aim";
	}

	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	setdefaultwallanimmode();
	var_04 = pop_up_and_hide_speed();
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
	setup_additive_aim(var_01);
	thread animscripts\track::trackshootentorpos();
	wait(var_01);
	if(animscripts\combat_utility::issniper())
	{
		thread animscripts\shoot_behavior::sniper_glint_behavior();
	}

	self.changingcoverpos = 0;
	self.coverposestablishedtime = gettime();
	self notify("stop_popup_donotetracks");
	return 1;
}

//Function Number: 21
donotetracksforpopup(param_00)
{
	self endon("killanimscript");
	self endon("stop_popup_donotetracks");
	animscripts\shared::donotetracks(param_00);
}

//Function Number: 22
setup_additive_aim(param_00)
{
	if(self.a.covermode == "left" || self.a.covermode == "right")
	{
		var_01 = "crouch";
	}
	else
	{
		var_01 = self.a.covermode;
	}

	self setanimknoball(animscripts\utility::animarray(var_01 + "_aim"),%body,1,param_00);
	if(var_01 == "crouch")
	{
		self setanimlimited(animscripts\utility::lookupanim("cover_crouch","add_aim_down"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("cover_crouch","add_aim_left"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("cover_crouch","add_aim_up"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("cover_crouch","add_aim_right"),1,0);
		return;
	}

	if(var_01 == "stand")
	{
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_right"),1,0);
		return;
	}

	if(var_01 == "stand_tall")
	{
		self setanimlimited(animscripts\utility::lookupanim("old_default_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("old_default_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("old_default_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("old_default_stand","add_aim_right"),1,0);
		return;
	}

	if(var_01 == "lean")
	{
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("default_stand","add_aim_right"),1,0);
		return;
	}

	if(var_01 == "over")
	{
		self setanimlimited(animscripts\utility::lookupanim("cover_stand","add_aim_down"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("cover_stand","add_aim_left"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("cover_stand","add_aim_up"),1,0);
		self setanimlimited(animscripts\utility::lookupanim("cover_stand","add_aim_right"),1,0);
		return;
	}
}

//Function Number: 23
go_to_hide()
{
	self notify("return_to_cover");
	self.changingcoverpos = 1;
	self notify("done_changing_cover_pos");
	animscripts\combat_utility::endaimidlethread();
	var_00 = pop_up_and_hide_speed();
	self setflaggedanimknoball("go_to_hide",animscripts\utility::animarray(self.a.covermode + "_2_hide"),%body,1,0.2,var_00);
	self clearanim(%exposed_modern,0.2);
	animscripts\shared::donotetracks("go_to_hide");
	self.a.covermode = "hide";
	if(self.covertype == "stand")
	{
		self.a.special = "cover_stand";
	}
	else
	{
		self.a.special = "cover_crouch";
	}

	self.changingcoverpos = 0;
}

//Function Number: 24
trythrowinggrenadestayhidden(param_00)
{
	return trythrowinggrenade(param_00,1);
}

//Function Number: 25
trythrowinggrenade(param_00,param_01)
{
	if(isdefined(self.dontevershoot) || isdefined(param_00.dontattackme))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		var_02 = animscripts\utility::animarraypickrandom("grenade_rambo");
	}
	else if(isdefined(param_01) && param_01)
	{
		var_02 = animscripts\utility::animarraypickrandom("grenade_safe");
	}
	else
	{
		var_02 = animscripts\utility::animarraypickrandom("grenade_exposed");
	}

	setdefaultwallanimmode();
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts\combat_utility::trygrenade(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 26
blindfire()
{
	if(!animscripts\utility::animarrayanyexist("blind_fire"))
	{
		return 0;
	}

	setdefaultwallanimmode();
	self.keepclaimednodeifvalid = 1;
	self setflaggedanimknoballrestart("blindfire",animscripts\utility::animarraypickrandom("blind_fire"),%body,1,0.2,1);
	animscripts\shared::donotetracks("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 27
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

//Function Number: 28
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

//Function Number: 29
useselfplacedturret(param_00,param_01)
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
		return;
	}

	var_02 delete();
}

//Function Number: 30
usestationaryturret()
{
	var_00 = self.node.turret;
	if(!var_00.issetup)
	{
		return;
	}

	thread maps\_mg_penetration::gunner_think(var_00);
	self waittill("continue_cover_script");
}

//Function Number: 31
setup_crouching_anim_array(param_00)
{
	if(animscripts\utility::is_free_running())
	{
		self.a.array = animscripts\utility::lookupanimarray("free_run_cover_crouch");
		return;
	}

	self.a.array = animscripts\utility::lookupanimarray("cover_crouch");
	if(animscripts\utility::weapon_pump_action_shotgun())
	{
		if(param_00 == "lean" || param_00 == "stand")
		{
			self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand","single");
		}
		else
		{
			self.a.array["single"] = animscripts\utility::lookupanim("shotgun_crouch","single");
		}
	}

	if(isdefined(level.ramboanims))
	{
		self.a.array["rambo"] = level.ramboanims.covercrouch;
		self.a.array["rambo_fail"] = level.ramboanims.covercrouchfail;
		self.a.array["grenade_rambo"] = level.ramboanims.covercrouchgrenade;
	}
}

//Function Number: 32
setup_standing_anim_array(param_00)
{
	self.a.array = animscripts\utility::lookupanimarray("cover_stand");
	if(param_00 != "over")
	{
		if(param_00 == "stand_tall" && maps\_utility::s1_motionset_avaliable())
		{
			var_01 = animscripts\utility::lookupanimarray("old_default_stand");
			self.a.array["stand_tall_aim"] = var_01["straight_level"];
		}
		else
		{
			var_01 = animscripts\utility::lookupanimarray("default_stand");
		}

		self.a.array["add_aim_left"] = var_01["add_aim_left"];
		self.a.array["add_aim_right"] = var_01["add_aim_right"];
		self.a.array["add_aim_up"] = var_01["add_aim_up"];
		self.a.array["add_aim_down"] = var_01["add_aim_down"];
		self.a.array["stand_aim"] = var_01["straight_level"];
		self.a.array["fire"] = var_01["fire_corner"];
		self.a.array["semi2"] = var_01["semi2"];
		self.a.array["semi3"] = var_01["semi3"];
		self.a.array["semi4"] = var_01["semi4"];
		self.a.array["semi5"] = var_01["semi5"];
		if(animscripts\utility::weapon_pump_action_shotgun())
		{
			self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand","single");
		}
		else
		{
			self.a.array["single"] = var_01["single"];
		}

		self.a.array["burst2"] = var_01["burst2"];
		self.a.array["burst3"] = var_01["burst3"];
		self.a.array["burst4"] = var_01["burst4"];
		self.a.array["burst5"] = var_01["burst5"];
		self.a.array["burst6"] = var_01["burst6"];
	}

	if(isdefined(level.ramboanims))
	{
		self.a.array["rambo"] = level.ramboanims.coverstand;
		self.a.array["rambo_fail"] = level.ramboanims.coverstandfail;
		self.a.array["grenade_rambo"] = level.ramboanims.coverstandgrenade;
	}
}

//Function Number: 33
loophide(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.1;
	}

	self setanimknoballrestart(animscripts\utility::animarray("hide_idle"),%body,1,param_00);
	self.a.covermode = "hide";
}

//Function Number: 34
anglerangethread()
{
	self endon("killanimscript");
	self notify("newAngleRangeCheck");
	self endon("newAngleRangeCheck");
	self endon("return_to_cover");
	for(;;)
	{
		if(needtochangecovermode())
		{
			break;
		}

		wait(0.1);
	}

	self notify("stopShooting");
}

//Function Number: 35
needtochangecovermode()
{
	if(self.covertype != "crouch")
	{
		return 0;
	}

	var_00 = getshootpospitch(self geteye());
	if(self.a.covermode == "lean")
	{
		return var_00 < 10;
	}

	return var_00 > 45;
}

//Function Number: 36
getbestcovermode()
{
	var_00 = [];
	if(self.covertype == "stand")
	{
		if(!self.covernode.lowstandisok && isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
		{
			var_00 = self.covernode getvalidcoverpeekouts();
			var_00[var_00.size] = "stand_tall";
		}
		else
		{
			var_00 = self.covernode getvalidcoverpeekouts();
			if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
			{
				var_00[var_00.size] = "over";
			}
			else
			{
				var_00[var_00.size] = "stand";
			}
		}
	}
	else
	{
		var_01 = getshootpospitch(self.covernode.origin + animscripts\utility::getnodeoffset(self.covernode));
		if(var_01 > 30)
		{
			return "lean";
		}

		if(var_01 > 15 || !self.covernode.crouchingisok)
		{
			return "stand";
		}

		var_00 = self.covernode getvalidcoverpeekouts();
		var_00[var_00.size] = "crouch";
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(!isdefined(self.a.array["hide_2_" + var_00[var_02]]))
		{
			var_00[var_02] = var_00[var_00.size - 1];
			var_00[var_00.size - 1] = undefined;
			continue;
		}
	}

	return animscripts\combat_utility::getrandomcovermode(var_00);
}

//Function Number: 37
getshootpospitch(param_00)
{
	var_01 = animscripts\utility::getenemyeyepos();
	return angleclamp180(vectortoangles(var_01 - param_00)[0]);
}

//Function Number: 38
setdefaultwallanimmode()
{
	if(self.swimmer)
	{
		self animmode("nogravity");
		return;
	}

	self animmode("zonly_physics");
}

//Function Number: 39
cover_playfacialanim(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "run";
	}

	self.facialidx = animscripts\face::playfacialanim(param_00,param_01,self.facialidx);
}

//Function Number: 40
cover_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}