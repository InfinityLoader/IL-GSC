/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\setposemovement.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 55
 * Decompile Time: 878 ms
 * Timestamp: 10/27/2023 2:30:45 AM
*******************************************************************/

//Function Number: 1
setposemovement(param_00,param_01)
{
	if(param_00 == "")
	{
		if(self.a.var_911 == "prone" && param_01 == "walk" || param_01 == "run")
		{
			param_00 = "crouch";
		}
		else
		{
			param_00 = self.a.var_911;
		}
	}

	if(!isdefined(param_01) || param_01 == "")
	{
		param_01 = self.a.movement;
	}

	[[ level.setposemovementfnarray[param_00][param_01] ]]();
}

//Function Number: 2
initposemovementfunctions()
{
	level.setposemovementfnarray["stand"]["stop"] = ::beginstandstop;
	level.setposemovementfnarray["stand"]["walk"] = ::beginstandwalk;
	level.setposemovementfnarray["stand"]["run"] = ::beginstandrun;
	level.setposemovementfnarray["crouch"]["stop"] = ::func_1F92;
	level.setposemovementfnarray["crouch"]["walk"] = ::func_0C6E;
	level.setposemovementfnarray["crouch"]["run"] = ::begincrouchrun;
	level.setposemovementfnarray["prone"]["stop"] = ::func_1F93;
	level.setposemovementfnarray["prone"]["walk"] = ::beginpronewalk;
	level.setposemovementfnarray["prone"]["run"] = ::beginpronerun;
}

//Function Number: 3
beginstandstop()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					return 0;
	
				case "walk":
					standwalktostand();
					break;
	
				default:
					func_1F98();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					crouchtostand();
					break;
	
				case "walk":
					crouchwalktostand();
					break;
	
				default:
					crouchruntostand();
					break;
			}
			break;

		default:
			switch(self.a.movement)
			{
				case "stop":
					pronetostand();
					break;
	
				default:
					pronetostand();
					break;
			}
			break;
	}

	return 1;
}

//Function Number: 4
beginstandwalk()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
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
			switch(self.a.movement)
			{
				case "stop":
					func_1FA1();
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
			pronetostandwalk();
			break;
	}

	return 1;
}

//Function Number: 5
beginstandrun()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "walk":
				case "stop":
					return func_1F9B();
	
				default:
					return 0;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					return func_1FA7();
	
				default:
					return func_1F9B();
			}
			break;

		default:
			func_1FAA();
			break;
	}

	return 1;
}

//Function Number: 6
func_1F92()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					standtocrouch();
					break;
	
				case "walk":
					func_1F97();
					break;
	
				case "run":
					func_1F99();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					break;
	
				case "walk":
					func_1FA2();
					break;
	
				case "run":
					crouchruntocrouch();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			pronetocrouch();
			break;

		default:
			break;
	}
}

//Function Number: 7
func_0C6E()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
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
			switch(self.a.movement)
			{
				case "stop":
					crouchtocrouchwalk();
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
begincrouchrun()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
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
			switch(self.a.movement)
			{
				case "stop":
					func_1FA6();
					break;
	
				case "walk":
					blendintocrouchrun();
					break;
	
				default:
					return 0;
			}
			break;

		default:
			func_1FA9();
			break;
	}

	return 1;
}

//Function Number: 9
func_1F93()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					standtoprone();
					break;
	
				case "walk":
					standtoprone();
					break;
	
				case "run":
					crouchruntoprone();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_1FB5();
					break;
	
				case "walk":
					func_1FB5();
					break;
	
				case "run":
					crouchruntoprone();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			switch(self.a.movement)
			{
				case "stop":
					break;
	
				case "walk":
				case "run":
					pronecrawltoprone();
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
beginpronewalk()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					standtopronewalk();
					break;
	
				default:
					crouchruntopronewalk();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
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
			switch(self.a.movement)
			{
				case "stop":
					func_1FB3();
					break;
	
				default:
					self.a.movement = "walk";
					return 0;
			}
			break;
	}

	return 1;
}

//Function Number: 11
beginpronerun()
{
	switch(self.a.var_911)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_1FBA();
					break;
	
				default:
					crouchruntopronerun();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_1FB7();
					break;
	
				default:
					crouchruntopronerun();
					break;
			}
			break;

		default:
			switch(self.a.movement)
			{
				case "stop":
					func_1FB3();
					break;
	
				default:
					self.a.movement = "run";
					return 0;
			}
			break;
	}

	return 1;
}

//Function Number: 12
func_1F94(param_00,param_01,param_02,param_03)
{
	var_04 = gettime() + param_01 * 1000;
	if(isarray(param_00))
	{
		param_00 = param_00[randomint(param_00.size)];
	}

	self setflaggedanimknoball("blendTransition",param_00,%body,1,param_01,1);
	animscripts/notetracks::donotetracksfortime(param_01 / 2,"blendTransition");
	self.a.var_911 = param_02;
	self.a.movement = param_03;
	var_05 = var_04 - gettime() / 1000;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	animscripts/notetracks::donotetracksfortime(var_05,"blendTransition");
}

//Function Number: 13
func_1F95(param_00,param_01)
{
	playtransitionanimation(param_00,"stand","walk",param_01);
}

//Function Number: 14
standwalktostand()
{
	self.a.movement = "stop";
}

//Function Number: 15
func_1F97()
{
	standwalktostand();
	standtocrouch();
}

//Function Number: 16
func_1F98()
{
	self.a.movement = "stop";
}

//Function Number: 17
func_1F99()
{
	self.a.movement = "stop";
	self.a.var_911 = "crouch";
}

//Function Number: 18
playblendtransitionstandrun(param_00)
{
	var_01 = 0.3;
	if(self.a.movement != "stop")
	{
		self endon("movemode");
		var_01 = 1;
	}

	func_1F94(param_00,var_01,"stand","run");
}

//Function Number: 19
func_1F9B()
{
	if(!self.facemotion)
	{
		self.a.movement = "run";
		self.a.var_911 = "stand";
		return 0;
	}

	if(isdefined(self.run_overrideanim))
	{
		playblendtransitionstandrun(self.run_overrideanim);
		return 1;
	}

	var_00 = 0.1;
	if(self.a.movement != "stop" && self.stairsstate == "none")
	{
		var_00 = 0.5;
	}

	if(isdefined(self.sprint))
	{
		self setanimknoblimited(animscripts/utility::moveanim("sprint"),1,var_00,1);
	}
	else
	{
		self setanimknoblimited(animscripts/run::getrunanim(),1,var_00,1);
	}

	animscripts/run::setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"),self.sidesteprate);
	thread animscripts/run::setcombatstandmoveanimweights("run");
	wait 0.05;
	playblendtransitionstandrun(%combatrun);
	return 1;
}

//Function Number: 20
blendintostandwalk()
{
	if(self.a.movement != "stop")
	{
		self endon("movemode");
	}

	if(!isdefined(self.alwaysrunforward) && self.a.var_911 != "prone")
	{
		animscripts/run::setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"));
	}

	self.a.var_911 = "stand";
	self.a.movement = "walk";
}

//Function Number: 21
crouchtostand()
{
	var_00 = 1;
	if(isdefined(self.faststand))
	{
		var_00 = 1.8;
		self.faststand = undefined;
	}

	if(animscripts/utility::usingsidearm())
	{
		playtransitionanimation(%pistol_crouchaimstraight2stand,"stand","stop",undefined,var_00);
		return;
	}

	animscripts/utility::randomizeidleset();
	playtransitionanimation(%crouch2stand,"stand","stop",undefined,var_00);
}

//Function Number: 22
crouchtocrouchwalk()
{
	blendintocrouchwalk();
}

//Function Number: 23
func_1FA1()
{
	crouchtocrouchwalk();
	blendintostandwalk();
}

//Function Number: 24
func_1FA2()
{
	self.a.movement = "stop";
}

//Function Number: 25
crouchwalktostand()
{
	func_1FA2();
	crouchtostand();
}

//Function Number: 26
crouchruntocrouch()
{
	self.a.movement = "stop";
}

//Function Number: 27
crouchruntostand()
{
	crouchruntocrouch();
	crouchtostand();
}

//Function Number: 28
func_1FA6()
{
	blendintocrouchrun();
}

//Function Number: 29
func_1FA7()
{
	return func_1F9B();
}

//Function Number: 30
blendintocrouchrun()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		func_1F94(self.crouchrun_combatanim,0.6,"crouch","run");
		return;
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts/run::updatemoveanimweights("crouchrun",animscripts/utility::moveanim("crouch"),animscripts/utility::moveanim("crouch_b"),animscripts/utility::moveanim("crouch_l"),animscripts/utility::moveanim("crouch_r"));
	wait 0.05;
	func_1F94(%crouchrun,0.4,"crouch","run");
}

//Function Number: 31
func_1FA9()
{
	self orientmode("face current");
	animscripts/utility::exitpronewrapper(1);
	pronelegsstraighttree(0.2);
	animscripts/cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_2_crouch,"crouch","run",animscripts/run::getcrouchrunanim());
}

//Function Number: 32
func_1FAA()
{
	func_1FA9();
	func_1F9B();
}

//Function Number: 33
pronetocrouchwalk()
{
	func_1FA9();
	blendintocrouchwalk();
}

//Function Number: 34
blendintocrouchwalk()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		self setanimknoball(self.crouchrun_combatanim,%body,1,0.4);
		func_1F94(self.crouchrun_combatanim,0.6,"crouch","walk");
		self notify("BlendIntoCrouchWalk");
		return;
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts/run::updatemoveanimweights("crouchrun",animscripts/utility::moveanim("crouch"),animscripts/utility::moveanim("crouch_b"),animscripts/utility::moveanim("crouch_l"),animscripts/utility::moveanim("crouch_r"));
	wait 0.05;
	func_1F94(%crouchrun,0.4,"crouch","run");
}

//Function Number: 35
standtocrouch()
{
	animscripts/utility::randomizeidleset();
	var_00 = 1;
	if(isdefined(self.fastcrouch))
	{
		var_00 = 1.8;
		self.fastcrouch = undefined;
	}

	playtransitionanimation(%exposed_stand_2_crouch,"crouch","stop",undefined,var_00);
}

//Function Number: 36
pronetocrouch()
{
	animscripts/utility::randomizeidleset();
	self orientmode("face current");
	animscripts/utility::exitpronewrapper(1);
	pronelegsstraighttree(0.1);
	animscripts/cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_2_crouch,"crouch","stop");
}

//Function Number: 37
pronetostand()
{
	self orientmode("face current");
	animscripts/utility::exitpronewrapper(1);
	pronelegsstraighttree(0.1);
	animscripts/cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_2_stand,"stand","stop");
}

//Function Number: 38
pronetostandwalk()
{
	pronetocrouch();
	crouchtocrouchwalk();
	blendintostandwalk();
}

//Function Number: 39
pronetopronemove(param_00)
{
	pronelegsstraighttree(0.1);
	playtransitionanimation(%prone_2_prone_crawl,"prone",param_00,%prone_crawl);
	animscripts/cover_prone::updatepronewrapper(0.1);
}

//Function Number: 40
func_1FB3()
{
	pronetopronemove("run");
}

//Function Number: 41
pronecrawltoprone()
{
	pronelegsstraighttree(0.1);
	animscripts/cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_crawl_2_prone,"prone","stop");
}

//Function Number: 42
func_1FB5()
{
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
	pronelegsstraighttree(0.3);
	animscripts/cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%crouch_2_prone,"prone","stop");
}

//Function Number: 43
crouchtopronewalk()
{
	func_1FB5();
	func_1FB3();
}

//Function Number: 44
func_1FB7()
{
	func_1FB5();
	func_1FB3();
}

//Function Number: 45
standtoprone()
{
	self endon("entered_poseprone");
	var_00 = 0.5;
	thread playtransitionanimationthread_withoutwaitsetstates(%stand_2_prone,"prone","stop",undefined,var_00);
	self waittillmatch("anim_pose = \"crouch\","transAnimDone2");
	waittillframeend;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(var_00);
	self.a.movement = "stop";
	pronelegsstraighttree(0.2);
	animscripts/cover_prone::updatepronewrapper(0.1);
	self waittillmatch("end","transAnimDone2");
}

//Function Number: 46
standtopronewalk()
{
	standtoprone();
	func_1FB3();
}

//Function Number: 47
func_1FBA()
{
	standtoprone();
	func_1FB3();
}

//Function Number: 48
crouchruntoprone()
{
	var_00 = 0.5;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(var_00);
	pronelegsstraighttree(0.2);
	animscripts/cover_prone::updatepronewrapper(0.1);
	var_01 = animscripts/utility::getquadrant(self getmotionangle());
	var_02 = %crouch_2_prone;
	var_03 = getmovedelta(var_02,0,1);
	var_04 = self localtoworldcoords(var_03);
	if(self maymovetopoint(var_04))
	{
		playtransitionanimation(var_02,"prone","stop",undefined,var_00);
		return;
	}

	playtransitionanimation(%crouch_2_prone_firing,"prone","stop",undefined,var_00);
}

//Function Number: 49
crouchruntopronewalk()
{
	crouchruntoprone();
	func_1FB3();
}

//Function Number: 50
crouchruntopronerun()
{
	crouchruntoprone();
	func_1FB3();
}

//Function Number: 51
playtransitionanimationthread_withoutwaitsetstates(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("entered_pose" + param_01);
	func_1FC1(param_00,param_01,param_02,param_03,param_04,0);
}

//Function Number: 52
playtransitionanimation(param_00,param_01,param_02,param_03,param_04)
{
	func_1FC1(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 53
func_1FC1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_05)
	{
		thread func_1FC2(getanimlength(param_00) / 2,"killtimerscript",param_01);
	}

	self setflaggedanimknoballrestart("transAnimDone2",param_00,%body,1,0.2,param_04);
	if(!isdefined(self.a.var_911))
	{
		self.var_911 = "undefined";
	}

	if(!isdefined(self.a.movement))
	{
		self.movement = "undefined";
	}

	var_06 = "";
	animscripts/shared::donotetracks("transAnimDone2",undefined,var_06);
	self notify("killtimerscript");
	self.a.var_911 = param_01;
	self notify("entered_pose" + param_01);
	self.a.movement = param_02;
	if(isdefined(param_03))
	{
		self setanimknoball(param_03,%body,1,0.3,param_04);
	}
}

//Function Number: 54
func_1FC2(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon(param_01);
	var_03 = self.a.var_911;
	wait param_00;
	if(var_03 != "prone" && param_02 == "prone")
	{
		animscripts/cover_prone::updatepronewrapper(0.1);
		animscripts/utility::enterpronewrapper(1);
		return;
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