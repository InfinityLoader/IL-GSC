/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_wall.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 35
 * Decompile Time: 577 ms
 * Timestamp: 10/27/2023 2:30:18 AM
*******************************************************************/

//Function Number: 1
cover_wall_think(param_00)
{
	self endon("killanimscript");
	self.covernode = self.node;
	self.covertype = param_00;
	if(!isdefined(self.node.turret))
	{
		animscripts/cover_behavior::func_B5C(0);
	}

	if(param_00 == "crouch")
	{
		setup_cover_crouch("unknown");
		self.covernode func_0B6A();
	}
	else
	{
		setup_cover_stand("unknown");
	}

	self.a.aimidlethread = undefined;
	self orientmode("face angle",self.covernode.angles[1]);
	if(isdefined(self.weapon) && animscripts/utility::usingmg() && isdefined(self.node) && isdefined(self.node.turretinfo) && canspawnturret())
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
		func_0B92();
	}

	self animmode("normal");
	if(param_00 == "crouch" && self.a.var_911 == "stand")
	{
		var_03 = animscripts/utility::animarray("stand_2_hide");
		var_04 = getanimlength(var_03);
		self setanimknoballrestart(var_03,%body,1,0.2,animscripts/combat_utility::fasteranimspeed());
		thread animscripts/shared::movetooriginovertime(self.covernode.origin,var_04);
		wait var_04;
		self.a.var_8E3 = "hide";
	}
	else
	{
		loophide(0.4);
		if(distancesquared(self.origin,self.covernode.origin) > 1)
		{
			thread animscripts/shared::movetooriginovertime(self.covernode.origin,0.4);
			wait 0.2;
			if(param_00 == "crouch")
			{
				self.a.var_911 = "crouch";
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
		if(self.a.var_911 == "prone")
		{
			animscripts/utility::exitpronewrapper(1);
		}

		self.a.var_911 = "crouch";
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
		var_05.var_B22 = ::animscripts/cover_behavior::func_B22;
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
	animscripts/cover_behavior::main(var_05);
}

//Function Number: 2
isrpd(param_00)
{
	return getsubstr(param_00,0,3) == "rpd" && param_00.size == 3 || param_00[3] == "_";
}

//Function Number: 3
func_0B6A()
{
	if(isdefined(self.crouchingisok))
	{
		return;
	}

	var_00 = (0,0,42);
	var_01 = anglestoforward(self.angles);
	self.crouchingisok = sighttracepassed(self.origin + var_00,self.origin + var_00 + var_01 * 64,0,undefined);
}

//Function Number: 4
setup_cover_crouch(param_00)
{
	self setdefaultaimlimits(self.covernode);
	func_0B94(param_00);
}

//Function Number: 5
setup_cover_stand(param_00)
{
	self setdefaultaimlimits(self.covernode);
	setup_standing_anim_array(param_00);
}

//Function Number: 6
coverreload()
{
	animscripts/combat_utility::reload(2,animscripts/utility::animarray("reload"));
	return 1;
}

//Function Number: 7
popupandshoot()
{
	self.keepclaimednodeifvalid = 1;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
	{
		if(func_0B76())
		{
			return 1;
		}
	}

	if(!pop_up())
	{
		return 0;
	}

	func_0B73();
	animscripts/combat_utility::endfireandanimidlethread();
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
		}
	}

	go_to_hide();
	self.var_897 = undefined;
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 8
func_0B73()
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

//Function Number: 9
shootuntilshootbehaviorchange_coverwall()
{
	if(self.covertype == "crouch")
	{
		thread anglerangethread();
	}

	thread animscripts/combat_utility::aimidlethread();
	animscripts/combat_utility::shootuntilshootbehaviorchange();
}

//Function Number: 10
func_0B76()
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

	if(self.covertype == "crouch" && !self.covernode.crouchingisok)
	{
		return 0;
	}

	var_01 = getshootpospitch(self.covernode.origin + animscripts/utility::getnodeoffset(self.covernode));
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

	self.var_8E8 = gettime();
	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self.isrambo = 1;
	self.a.prevattack = "rambo";
	self.var_8C8 = 1;
	thread animscripts/shared::ramboaim(0);
	var_04 = animscripts/utility::animarraypickrandom(var_00);
	self setflaggedanimknoballrestart("rambo",var_04,%body,1,0.2,1);
	animscripts/shared::donotetracks("rambo");
	self notify("rambo_aim_end");
	self.var_8C8 = 0;
	self.keepclaimednodeifvalid = 0;
	self.var_B7C = gettime();
	self.var_8C8 = 0;
	self.isrambo = undefined;
	return 1;
}

//Function Number: 11
idle()
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

		playidleanimation(var_01,var_00);
	}
}

//Function Number: 12
flinch()
{
	if(!animscripts/utility::animarrayanyexist("hide_idle_flinch"))
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
	var_02 = animscripts/utility::animarraypickrandom("hide_idle_flinch");
	playidleanimation(var_02,1);
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 13
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

	self.a.var_8E3 = "hide";
	animscripts/shared::donotetracks("idle");
}

//Function Number: 14
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

	animscripts/shared::func_B7E(animscripts/utility::animarray("look_idle"),param_00);
	var_01 = undefined;
	if(animscripts/utility::issuppressedwrapper())
	{
		var_01 = animscripts/utility::animarray("look_to_hide_fast");
	}
	else
	{
		var_01 = animscripts/utility::animarray("look_to_hide");
	}

	self setflaggedanimknoballrestart("looking_end",var_01,%body,1,0.1);
	animscripts/shared::donotetracks("looking_end");
	return 1;
}

//Function Number: 15
peekout()
{
	if(isdefined(self.covernode.script_dontpeek))
	{
		return 0;
	}

	self setflaggedanimknoball("looking_start",animscripts/utility::animarray("hide_to_look"),%body,1,0.2);
	animscripts/shared::donotetracks("looking_start");
	return 1;
}

//Function Number: 16
fastlook()
{
	self setflaggedanimknoballrestart("look",animscripts/utility::animarraypickrandom("look"),%body,1,0.1);
	animscripts/shared::donotetracks("look");
	return 1;
}

//Function Number: 17
pop_up_and_hide_speed()
{
	if(self.a.var_8E3 == "left" || self.a.var_8E3 == "right" || self.a.var_8E3 == "over")
	{
		return 1;
	}

	return animscripts/combat_utility::randomfasteranimspeed();
}

//Function Number: 18
pop_up()
{
	var_00 = getbestcovermode();
	var_01 = 0.1;
	var_02 = animscripts/utility::animarray("hide_2_" + var_00);
	if(!self maymovetopoint(animscripts/utility::getanimendpos(var_02)))
	{
		return 0;
	}

	if(self.script == "cover_crouch" && var_00 == "lean")
	{
		self.var_897 = 1;
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
		self.a.special = "cover_stand_aim";
	}
	else
	{
		self.a.special = "cover_crouch_aim";
	}

	self.var_8C8 = 1;
	self notify("done_changing_cover_pos");
	self animmode("zonly_physics");
	var_03 = pop_up_and_hide_speed();
	self setflaggedanimknoballrestart("pop_up",var_02,%body,1,0.1,var_03);
	thread func_0B85("pop_up");
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
	self.a.var_8E3 = var_00;
	self.a.prevattack = var_00;
	setup_additive_aim(var_01);
	thread animscripts/track::trackshootentorpos();
	wait var_01;
	if(animscripts/combat_utility::issniper())
	{
		thread animscripts/shoot_behavior::sniper_glint_behavior();
	}

	self.var_8C8 = 0;
	self.var_8E8 = gettime();
	self notify("stop_popup_donotetracks");
	return 1;
}

//Function Number: 19
func_0B85(param_00)
{
	self endon("killanimscript");
	self endon("stop_popup_donotetracks");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 20
setup_additive_aim(param_00)
{
	if(self.a.var_8E3 == "left" || self.a.var_8E3 == "right")
	{
		var_01 = "crouch";
	}
	else
	{
		var_01 = self.a.var_8E3;
	}

	self setanimknoball(animscripts/utility::animarray(var_01 + "_aim"),%body,1,param_00);
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
go_to_hide()
{
	self notify("return_to_cover");
	self.var_8C8 = 1;
	self notify("done_changing_cover_pos");
	animscripts/combat_utility::endaimidlethread();
	var_00 = pop_up_and_hide_speed();
	self setflaggedanimknoball("go_to_hide",animscripts/utility::animarray(self.a.var_8E3 + "_2_hide"),%body,1,0.2,var_00);
	self clearanim(%exposed_modern,0.2);
	animscripts/shared::donotetracks("go_to_hide");
	self.a.var_8E3 = "hide";
	if(self.covertype == "stand")
	{
		self.a.special = "cover_stand";
	}
	else
	{
		self.a.special = "cover_crouch";
	}

	self.var_8C8 = 0;
}

//Function Number: 22
trythrowinggrenadestayhidden(param_00)
{
	return trythrowinggrenade(param_00,1);
}

//Function Number: 23
trythrowinggrenade(param_00,param_01)
{
	if(isdefined(self.dontevershoot) || isdefined(param_00.dontattackme))
	{
		return 0;
	}

	var_02 = undefined;
	if(isdefined(self.rambochance) && randomfloat(1) < self.rambochance)
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

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_03 = animscripts/combat_utility::trygrenade(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_03;
}

//Function Number: 24
blindfire()
{
	if(!animscripts/utility::animarrayanyexist("blind_fire"))
	{
		return 0;
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	self setflaggedanimknoballrestart("blindfire",animscripts/utility::animarraypickrandom("blind_fire"),%body,1,0.2,1);
	animscripts/shared::donotetracks("blindfire");
	self.keepclaimednodeifvalid = 0;
	return 1;
}

//Function Number: 25
createturret(param_00,param_01,param_02)
{
	var_03 = spawnturret("misc_turret",param_00.origin,param_01);
	var_03.angles = param_00.angles;
	var_03.var_B8E = self;
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
func_0B8F(param_00)
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
useselfplacedturret(param_00,param_01)
{
	var_02 = createturret(self.node.turretinfo,param_00,param_01);
	if(self useturret(var_02))
	{
		var_02 thread func_0B8F(self);
		if(isdefined(self.turret_function))
		{
			thread [[ self.turret_function ]](var_02);
		}

		self waittill("turret_use_failed");
		return;
	}

	var_02 delete();
}

//Function Number: 28
func_0B92()
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
func_0B94(param_00)
{
	var_01 = [];
	if(animscripts/utility::weapon_pump_action_shotgun())
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

	self.a.array = var_41;
}

//Function Number: 30
setup_standing_anim_array(param_00)
{
	var_01 = [];
	if(var_01 == "over")
	{
	}
	else if(animscripts/utility::weapon_pump_action_shotgun())
	{
	}
	else
	{
	}

	if(isdefined(level.ramboanims))
	{
	}

	self.a.array = var_41;
}

//Function Number: 31
loophide(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.1;
	}

	self setanimknoballrestart(animscripts/utility::animarray("hide_idle"),%body,1,param_00);
	self.a.var_8E3 = "hide";
}

//Function Number: 32
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

		wait 0.1;
	}

	self notify("stopShooting");
}

//Function Number: 33
needtochangecovermode()
{
	if(self.covertype != "crouch")
	{
		return 0;
	}

	var_00 = getshootpospitch(self geteye());
	if(self.a.var_8E3 == "lean")
	{
		return var_00 < 10;
	}

	return var_00 > 45;
}

//Function Number: 34
getbestcovermode()
{
	var_00 = [];
	if(self.covertype == "stand")
	{
		var_00 = self.covernode getvalidcoverpeekouts();
	}
	else
	{
		var_01 = getshootpospitch(self.covernode.origin + animscripts/utility::getnodeoffset(self.covernode));
		if(var_01 > 30)
		{
			return "lean";
		}

		if(var_01 > 15 || !self.covernode.crouchingisok)
		{
			return "stand";
		}

		var_41 = self.covernode getvalidcoverpeekouts();
		var_41[var_41.size] = "crouch";
	}

	return animscripts/combat_utility::getrandomcovermode(var_41);
}

//Function Number: 35
getshootpospitch(param_00)
{
	var_01 = animscripts/utility::getenemyeyepos();
	return angleclamp180(vectortoangles(var_01 - param_00)[0]);
}