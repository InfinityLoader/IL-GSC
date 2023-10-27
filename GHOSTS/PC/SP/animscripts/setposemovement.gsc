/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\setposemovement.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 940 ms
 * Timestamp: 10/27/2023 1:24:23 AM
*******************************************************************/

//Function Number: 1
func_70A7(param_00,param_01)
{
	if(param_00 == "")
	{
		if(self.a.var_60B1 == "prone" && param_01 == "walk" || param_01 == "run")
		{
			param_00 = "crouch";
		}
		else
		{
			param_00 = self.a.var_60B1;
		}
	}

	if(!isdefined(param_01) || param_01 == "")
	{
		param_01 = self.a.var_5486;
	}

	[[ level.setposemovementfnarray[param_00][param_01] ]]();
}

//Function Number: 2
func_4645()
{
	level.setposemovementfnarray["stand"]["stop"] = ::func_79DE;
	level.setposemovementfnarray["stand"]["walk"] = ::standwalk_begin;
	level.setposemovementfnarray["stand"]["run"] = ::standrun_begin;
	level.setposemovementfnarray["crouch"]["stop"] = ::crouchstop_begin;
	level.setposemovementfnarray["crouch"]["walk"] = ::func_2164;
	level.setposemovementfnarray["crouch"]["run"] = ::func_2152;
	level.setposemovementfnarray["prone"]["stop"] = ::func_6203;
	level.setposemovementfnarray["prone"]["walk"] = ::func_620D;
	level.setposemovementfnarray["prone"]["run"] = ::func_6201;
}

//Function Number: 3
func_79DE()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					return 0;
	
				case "walk":
					func_79E5();
					break;
	
				default:
					standruntostand();
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					crouchtostand();
					break;
	
				case "walk":
					func_2166();
					break;
	
				default:
					func_215A();
					break;
			}
			break;

		default:
			switch(self.a.var_5486)
			{
				case "stop":
					func_620A();
					break;
	
				default:
					func_620A();
					break;
			}
			break;
	}

	return 1;
}

//Function Number: 4
standwalk_begin()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					blendintostandwalk();
					break;
	
				case "walk":
					return 0;
	
				default:
					blendintostandwalk();
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					func_2163();
					break;
	
				case "walk":
					blendintostandwalk();
					break;
	
				default:
					blendintostandwalk();
					break;
			}
			break;

		default:
			func_620C();
			break;
	}

	return 1;
}

//Function Number: 5
standrun_begin()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "walk":
				case "stop":
					return blendintostandrun();
	
				default:
					return 0;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					return func_2162();
	
				default:
					return blendintostandrun();
			}
			break;

		default:
			func_620B();
			break;
	}

	return 1;
}

//Function Number: 6
crouchstop_begin()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					func_79DF();
					break;
	
				case "walk":
					func_79E4();
					break;
	
				case "run":
					func_79DB();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					break;
	
				case "walk":
					func_2165();
					break;
	
				case "run":
					crouchruntocrouch();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			func_6205();
			break;

		default:
			break;
	}
}

//Function Number: 7
func_2164()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					blendintocrouchwalk();
					break;
	
				case "walk":
					blendintocrouchwalk();
					break;
	
				default:
					blendintocrouchwalk();
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					func_215D();
					break;
	
				case "walk":
					return 0;
	
				default:
					blendintocrouchwalk();
					break;
			}
			break;

		default:
			pronetocrouchwalk();
			break;
	}

	return 1;
}

//Function Number: 8
func_2152()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					blendintocrouchrun();
					break;
	
				default:
					blendintocrouchrun();
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					crouchtocrouchrun();
					break;
	
				case "walk":
					blendintocrouchrun();
					break;
	
				default:
					return 0;
			}
			break;

		default:
			func_6206();
			break;
	}

	return 1;
}

//Function Number: 9
func_6203()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					func_79E0();
					break;
	
				case "walk":
					func_79E0();
					break;
	
				case "run":
					func_2157();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					crouchtoprone();
					break;
	
				case "walk":
					crouchtoprone();
					break;
	
				case "run":
					func_2157();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			switch(self.a.var_5486)
			{
				case "stop":
					break;
	
				case "walk":
				case "run":
					func_61FE();
					break;
	
				default:
					break;
			}
			break;

		default:
			break;
	}
}

//Function Number: 10
func_620D()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					func_79E2();
					break;
	
				default:
					crouchruntopronewalk();
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					crouchtopronewalk();
					break;
	
				default:
					crouchruntopronewalk();
					break;
			}
			break;

		default:
			switch(self.a.var_5486)
			{
				case "stop":
					func_6209();
					break;
	
				default:
					self.a.var_5486 = "walk";
					return 0;
			}
			break;
	}

	return 1;
}

//Function Number: 11
func_6201()
{
	switch(self.a.var_60B1)
	{
		case "stand":
			switch(self.a.var_5486)
			{
				case "stop":
					func_79E1();
					break;
	
				default:
					crouchruntopronerun();
					break;
			}
			break;

		case "crouch":
			switch(self.a.var_5486)
			{
				case "stop":
					func_215F();
					break;
	
				default:
					crouchruntopronerun();
					break;
			}
			break;

		default:
			switch(self.a.var_5486)
			{
				case "stop":
					func_6209();
					break;
	
				default:
					self.a.var_5486 = "run";
					return 0;
			}
			break;
	}

	return 1;
}

//Function Number: 12
func_5D4F(param_00,param_01,param_02,param_03)
{
	var_04 = gettime() + param_01 * 1000;
	if(isarray(param_00))
	{
		param_00 = param_00[randomint(param_00.size)];
	}

	self setflaggedanimknoball("blendTransition",param_00,%body,1,param_01,1);
	animscripts/notetracks::donotetracksfortime(param_01 / 2,"blendTransition");
	self.a.var_60B1 = param_02;
	self.a.var_5486 = param_03;
	var_05 = var_04 - gettime() / 1000;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	animscripts/notetracks::donotetracksfortime(var_05,"blendTransition");
}

//Function Number: 13
func_6050(param_00,param_01)
{
	func_604D(param_00,"stand","walk",param_01);
}

//Function Number: 14
func_79E5()
{
	self.a.var_5486 = "stop";
}

//Function Number: 15
func_79E4()
{
	func_79E5();
	func_79DF();
}

//Function Number: 16
standruntostand()
{
	self.a.var_5486 = "stop";
}

//Function Number: 17
func_79DB()
{
	self.a.var_5486 = "stop";
	self.a.var_60B1 = "crouch";
}

//Function Number: 18
func_5D50(param_00)
{
	var_01 = 0.3;
	if(self.a.var_5486 != "stop")
	{
		self endon("movemode");
		var_01 = 1;
	}

	func_5D4F(param_00,var_01,"stand","run");
}

//Function Number: 19
blendintostandrun()
{
	if(!self.facemotion)
	{
		self.a.var_5486 = "run";
		self.a.var_60B1 = "stand";
		return 0;
	}

	if(isdefined(self.run_overrideanim))
	{
		func_5D50(self.run_overrideanim);
		return 1;
	}

	var_00 = 0.1;
	if(self.a.var_5486 != "stop" && self.stairsstate == "none")
	{
		var_00 = 0.5;
	}

	if(isdefined(self.var_797D))
	{
		self setanimknoblimited(animscripts/utility::getmoveanim("sprint"),1,var_00,1);
	}
	else
	{
		self setanimknoblimited(animscripts/run::func_3BDB(),1,var_00,1);
	}

	animscripts/run::setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"),self.sidesteprate);
	thread animscripts/run::func_7008("run");
	wait(0.05);
	func_5D50(%combatrun);
	return 1;
}

//Function Number: 20
blendintostandwalk()
{
	if(self.a.var_5486 != "stop")
	{
		self endon("movemode");
	}

	if(!isdefined(self.alwaysrunforward) && self.a.var_60B1 != "prone")
	{
		animscripts/run::setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"));
	}

	self.a.var_60B1 = "stand";
	self.a.var_5486 = "walk";
}

//Function Number: 21
crouchtostand()
{
	var_00 = 1;
	if(isdefined(self.var_31F3))
	{
		var_00 = 1.8;
		self.var_31F3 = undefined;
	}

	if(animscripts/utility::func_87FE())
	{
		func_604D(%pistol_crouchaimstraight2stand,"stand","stop",undefined,var_00);
	}

	animscripts/utility::func_633A();
	func_604D(%crouch2stand,"stand","stop",undefined,var_00);
}

//Function Number: 22
func_215D()
{
	blendintocrouchwalk();
}

//Function Number: 23
func_2163()
{
	func_215D();
	blendintostandwalk();
}

//Function Number: 24
func_2165()
{
	self.a.var_5486 = "stop";
}

//Function Number: 25
func_2166()
{
	func_2165();
	crouchtostand();
}

//Function Number: 26
crouchruntocrouch()
{
	self.a.var_5486 = "stop";
}

//Function Number: 27
func_215A()
{
	crouchruntocrouch();
	crouchtostand();
}

//Function Number: 28
crouchtocrouchrun()
{
	blendintocrouchrun();
}

//Function Number: 29
func_2162()
{
	return blendintostandrun();
}

//Function Number: 30
blendintocrouchrun()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		func_5D4F(self.crouchrun_combatanim,0.6,"crouch","run");
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts/run::func_8705("crouchrun",animscripts/utility::getmoveanim("crouch"),animscripts/utility::getmoveanim("crouch_b"),animscripts/utility::getmoveanim("crouch_l"),animscripts/utility::getmoveanim("crouch_r"));
	wait(0.05);
	func_5D4F(%crouchrun,0.4,"crouch","run");
}

//Function Number: 31
func_6206()
{
	self orientmode("face current");
	animscripts/utility::exitpronewrapper(1);
	pronelegsstraighttree(0.2);
	animscripts/cover_prone::func_8716(0.1);
	func_604D(%prone_2_crouch,"crouch","run",animscripts/run::func_3A69());
}

//Function Number: 32
func_620B()
{
	func_6206();
	blendintostandrun();
}

//Function Number: 33
pronetocrouchwalk()
{
	func_6206();
	blendintocrouchwalk();
}

//Function Number: 34
blendintocrouchwalk()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		self setanimknoball(self.crouchrun_combatanim,%body,1,0.4);
		func_5D4F(self.crouchrun_combatanim,0.6,"crouch","walk");
		self notify("BlendIntoCrouchWalk");
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts/run::func_8705("crouchrun",animscripts/utility::getmoveanim("crouch"),animscripts/utility::getmoveanim("crouch_b"),animscripts/utility::getmoveanim("crouch_l"),animscripts/utility::getmoveanim("crouch_r"));
	wait(0.05);
	func_5D4F(%crouchrun,0.4,"crouch","run");
}

//Function Number: 35
func_79DF()
{
	animscripts/utility::func_633A();
	var_00 = 1;
	if(isdefined(self.fastcrouch))
	{
		var_00 = 1.8;
		self.fastcrouch = undefined;
	}

	func_604D(%exposed_stand_2_crouch,"crouch","stop",undefined,var_00);
}

//Function Number: 36
func_6205()
{
	animscripts/utility::func_633A();
	self orientmode("face current");
	animscripts/utility::exitpronewrapper(1);
	pronelegsstraighttree(0.1);
	animscripts/cover_prone::func_8716(0.1);
	func_604D(%prone_2_crouch,"crouch","stop");
}

//Function Number: 37
func_620A()
{
	self orientmode("face current");
	animscripts/utility::exitpronewrapper(1);
	pronelegsstraighttree(0.1);
	animscripts/cover_prone::func_8716(0.1);
	func_604D(%prone_2_stand,"stand","stop");
}

//Function Number: 38
func_620C()
{
	func_6205();
	func_215D();
	blendintostandwalk();
}

//Function Number: 39
pronetopronemove(param_00)
{
	pronelegsstraighttree(0.1);
	func_604D(%prone_2_prone_crawl,"prone",param_00,%prone_crawl);
	animscripts/cover_prone::func_8716(0.1);
}

//Function Number: 40
func_6209()
{
	pronetopronemove("run");
}

//Function Number: 41
func_61FE()
{
	pronelegsstraighttree(0.1);
	animscripts/cover_prone::func_8716(0.1);
	func_604D(%prone_crawl_2_prone,"prone","stop");
}

//Function Number: 42
crouchtoprone()
{
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
	pronelegsstraighttree(0.3);
	animscripts/cover_prone::func_8716(0.1);
	func_604D(%crouch_2_prone,"prone","stop");
}

//Function Number: 43
crouchtopronewalk()
{
	crouchtoprone();
	func_6209();
}

//Function Number: 44
func_215F()
{
	crouchtoprone();
	func_6209();
}

//Function Number: 45
func_79E0()
{
	self endon("entered_poseprone");
	var_00 = 0.5;
	thread playtransitionanimationthread_withoutwaitsetstates(%stand_2_prone,"prone","stop",undefined,var_00);
	self waittillmatch("anim_pose = \"crouch\","transAnimDone2");
	waittillframeend;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(var_00);
	self.a.var_5486 = "stop";
	animscripts/cover_prone::func_8716(0.1);
	self waittillmatch("end","transAnimDone2");
	pronelegsstraighttree(0.2);
	self setanim(%prone_aim_idle,1,0.1);
}

//Function Number: 46
func_79E2()
{
	func_79E0();
	func_6209();
}

//Function Number: 47
func_79E1()
{
	func_79E0();
	func_6209();
}

//Function Number: 48
func_2157()
{
	var_00 = 0.5;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(var_00);
	pronelegsstraighttree(0.2);
	animscripts/cover_prone::func_8716(0.1);
	var_01 = animscripts/utility::getquadrant(self getmotionangle());
	var_02 = %crouch_2_prone;
	var_03 = getmovedelta(var_02,0,1);
	var_04 = self localtoworldcoords(var_03);
	if(self maymovetopoint(var_04))
	{
		func_604D(var_02,"prone","stop",undefined,var_00);
	}

	func_604D(%crouch_2_prone_firing,"prone","stop",undefined,var_00);
}

//Function Number: 49
crouchruntopronewalk()
{
	func_2157();
	func_6209();
}

//Function Number: 50
crouchruntopronerun()
{
	func_2157();
	func_6209();
}

//Function Number: 51
playtransitionanimationthread_withoutwaitsetstates(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("entered_pose" + param_01);
	func_604E(param_00,param_01,param_02,param_03,param_04,0);
}

//Function Number: 52
func_604D(param_00,param_01,param_02,param_03,param_04)
{
	func_604E(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 53
func_604E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_05)
	{
		thread func_8B14(getanimlength(param_00) / 2,"killtimerscript",param_01);
	}

	self setflaggedanimknoballrestart("transAnimDone2",param_00,%body,1,0.2,param_04);
	if(!isdefined(self.a.var_60B1))
	{
		self.var_60B1 = "undefined";
	}

	if(!isdefined(self.a.var_5486))
	{
		self.var_5486 = "undefined";
	}

	var_06 = "";
	animscripts/shared::func_2986("transAnimDone2",undefined,var_06);
	self notify("killtimerscript");
	self.a.var_60B1 = param_01;
	self notify("entered_pose" + param_01);
	self.a.var_5486 = param_02;
	if(isdefined(param_03))
	{
		self setanimknoball(param_03,%body,1,0.3,param_04);
	}
}

//Function Number: 54
func_8B14(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon(param_01);
	var_03 = self.a.var_60B1;
	wait(param_00);
	if(var_03 != "prone" && param_02 == "prone")
	{
		animscripts/cover_prone::func_8716(0.1);
		animscripts/utility::enterpronewrapper(1);
	}

	if(var_03 == "prone" && param_02 != "prone")
	{
		animscripts/utility::exitpronewrapper(1);
		self orientmode("face default");
	}
}

//Function Number: 55
pronelegsstraighttree(param_00)
{
	self setanimknoball(%prone_legsstraight,%body,1,param_00,1);
}