/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: setposemovement.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 786 ms
 * Timestamp: 4/22/2024 2:00:53 AM
*******************************************************************/

//Function Number: 1
setposemovement(param_00,param_01)
{
	if(param_00 == "")
	{
		if(self.a.pose == "prone" && param_01 == "walk" || param_01 == "run")
		{
			param_00 = "crouch";
		}
		else
		{
			param_00 = self.a.pose;
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
	level.setposemovementfnarray["stand"]["stop"] = ::standstop_begin;
	level.setposemovementfnarray["stand"]["walk"] = ::standwalk_begin;
	level.setposemovementfnarray["stand"]["run"] = ::standrun_begin;
	level.setposemovementfnarray["crouch"]["stop"] = ::crouchstop_begin;
	level.setposemovementfnarray["crouch"]["walk"] = ::crouchwalk_begin;
	level.setposemovementfnarray["crouch"]["run"] = ::crouchrun_begin;
	level.setposemovementfnarray["prone"]["stop"] = ::pronestop_begin;
	level.setposemovementfnarray["prone"]["walk"] = ::pronewalk_begin;
	level.setposemovementfnarray["prone"]["run"] = ::pronerun_begin;
}

//Function Number: 3
standstop_begin()
{
	switch(self.a.pose)
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
					standruntostand();
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
standwalk_begin()
{
	switch(self.a.pose)
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
					crouchtostandwalk();
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
standrun_begin()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "walk":
				case "stop":
					return blendintostandrun();
	
				default:
					return 0;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					return crouchtostandrun();
	
				default:
					return blendintostandrun();
			}
			break;

		default:
			pronetostandrun();
			break;
	}

	return 1;
}

//Function Number: 6
crouchstop_begin()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					standtocrouch();
					break;
	
				case "walk":
					standwalktocrouch();
					break;
	
				case "run":
					standruntocrouch();
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
					crouchwalktocrouch();
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
crouchwalk_begin()
{
	switch(self.a.pose)
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
crouchrun_begin()
{
	switch(self.a.pose)
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
			pronetocrouchrun();
			break;
	}

	return 1;
}

//Function Number: 9
pronestop_begin()
{
	switch(self.a.pose)
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
					crouchtoprone();
					break;
	
				case "walk":
					crouchtoprone();
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
pronewalk_begin()
{
	switch(self.a.pose)
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
					pronetopronerun();
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
pronerun_begin()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					standtopronerun();
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
					crouchtopronerun();
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
					pronetopronerun();
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
playblendtransition(param_00,param_01,param_02,param_03)
{
	var_04 = gettime() + param_01 * 1000;
	if(isarray(param_00))
	{
		param_00 = param_00[randomint(param_00.size)];
	}

	self setflaggedanimknoball("blendTransition",param_00,%body,1,param_01,1);
	animscripts\notetracks::donotetracksfortime(param_01 / 2,"blendTransition");
	self.a.pose = param_02;
	self.a.movement = param_03;
	var_05 = var_04 - gettime() / 1000;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	animscripts\notetracks::donotetracksfortime(var_05,"blendTransition");
}

//Function Number: 13
playtransitionstandwalk(param_00,param_01)
{
	playtransitionanimation(param_00,"stand","walk",param_01);
}

//Function Number: 14
standwalktostand()
{
	self.a.movement = "stop";
}

//Function Number: 15
standwalktocrouch()
{
	standwalktostand();
	standtocrouch();
}

//Function Number: 16
standruntostand()
{
	self.a.movement = "stop";
}

//Function Number: 17
standruntocrouch()
{
	self.a.movement = "stop";
	self.a.pose = "crouch";
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

	playblendtransition(param_00,var_01,"stand","run");
}

//Function Number: 19
blendintostandrun()
{
	if(!self.facemotion)
	{
		self.a.movement = "run";
		self.a.pose = "stand";
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
		self setanimknoblimited(animscripts\utility::getmoveanim("sprint"),1,var_00,1);
	}
	else
	{
		self setanimknoblimited(animscripts\run::getrunanim(),1,var_00,1);
	}

	animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"),self.sidesteprate);
	thread animscripts\run::setcombatstandmoveanimweights("run");
	wait(0.05);
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

	if(!isdefined(self.alwaysrunforward) && self.a.pose != "prone")
	{
		animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"));
	}

	self.a.pose = "stand";
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

	if(animscripts\utility::usingsidearm())
	{
		playtransitionanimation(%pistol_crouchaimstraight2stand,"stand","stop",undefined,var_00);
		return;
	}

	animscripts\utility::randomizeidleset();
	playtransitionanimation(%crouch2stand,"stand","stop",undefined,var_00);
}

//Function Number: 22
crouchtocrouchwalk()
{
	blendintocrouchwalk();
}

//Function Number: 23
crouchtostandwalk()
{
	crouchtocrouchwalk();
	blendintostandwalk();
}

//Function Number: 24
crouchwalktocrouch()
{
	self.a.movement = "stop";
}

//Function Number: 25
crouchwalktostand()
{
	crouchwalktocrouch();
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
crouchtocrouchrun()
{
	blendintocrouchrun();
}

//Function Number: 29
crouchtostandrun()
{
	return blendintostandrun();
}

//Function Number: 30
blendintocrouchrun()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		playblendtransition(self.crouchrun_combatanim,0.6,"crouch","run");
		return;
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	if(animscripts\utility::usingsmg() && self.a.movement == "run" && !isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["run"]))
	{
		var_00 = "smg_crouch_run";
		thread animscripts\run::updatemoveanimweights("crouchrun",animscripts\utility::lookupanim(var_00,"crouch"),animscripts\utility::lookupanim(var_00,"crouch_b"),animscripts\utility::lookupanim(var_00,"crouch_l"),animscripts\utility::lookupanim(var_00,"crouch_r"));
	}
	else
	{
		thread animscripts\run::updatemoveanimweights("crouchrun",animscripts\utility::getmoveanim("crouch"),animscripts\utility::getmoveanim("crouch_b"),animscripts\utility::getmoveanim("crouch_l"),animscripts\utility::getmoveanim("crouch_r"));
	}

	wait(0.05);
	playblendtransition(%crouchrun,0.4,"crouch","run");
}

//Function Number: 31
pronetocrouchrun()
{
	self orientmode("face current");
	animscripts\utility::exitpronewrapper(1);
	pronelegsstraighttree(0.2);
	animscripts\cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_2_crouch,"crouch","run",animscripts\run::getcrouchrunanim());
}

//Function Number: 32
pronetostandrun()
{
	pronetocrouchrun();
	blendintostandrun();
}

//Function Number: 33
pronetocrouchwalk()
{
	pronetocrouchrun();
	blendintocrouchwalk();
}

//Function Number: 34
blendintocrouchwalk()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		self setanimknoball(self.crouchrun_combatanim,%body,1,0.4);
		playblendtransition(self.crouchrun_combatanim,0.6,"crouch","walk");
		self notify("BlendIntoCrouchWalk");
		return;
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts\run::updatemoveanimweights("crouchrun",animscripts\utility::getmoveanim("crouch"),animscripts\utility::getmoveanim("crouch_b"),animscripts\utility::getmoveanim("crouch_l"),animscripts\utility::getmoveanim("crouch_r"));
	wait(0.05);
	playblendtransition(%crouchrun,0.4,"crouch","run");
}

//Function Number: 35
standtocrouch()
{
	animscripts\utility::randomizeidleset();
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
	animscripts\utility::randomizeidleset();
	self orientmode("face current");
	animscripts\utility::exitpronewrapper(1);
	pronelegsstraighttree(0.1);
	animscripts\cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_2_crouch,"crouch","stop");
}

//Function Number: 37
pronetostand()
{
	self orientmode("face current");
	animscripts\utility::exitpronewrapper(1);
	pronelegsstraighttree(0.1);
	animscripts\cover_prone::updatepronewrapper(0.1);
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
	animscripts\cover_prone::updatepronewrapper(0.1);
}

//Function Number: 40
pronetopronerun()
{
	pronetopronemove("run");
}

//Function Number: 41
pronecrawltoprone()
{
	pronelegsstraighttree(0.1);
	animscripts\cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%prone_crawl_2_prone,"prone","stop");
}

//Function Number: 42
crouchtoprone()
{
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts\utility::enterpronewrapper(1);
	pronelegsstraighttree(0.3);
	animscripts\cover_prone::updatepronewrapper(0.1);
	playtransitionanimation(%crouch_2_prone,"prone","stop");
}

//Function Number: 43
crouchtopronewalk()
{
	crouchtoprone();
	pronetopronerun();
}

//Function Number: 44
crouchtopronerun()
{
	crouchtoprone();
	pronetopronerun();
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
	animscripts\utility::enterpronewrapper(var_00);
	self.a.movement = "stop";
	animscripts\cover_prone::updatepronewrapper(0.1);
	self waittillmatch("end","transAnimDone2");
	pronelegsstraighttree(0.2);
	self setanim(%prone_aim_idle,1,0.1);
}

//Function Number: 46
standtopronewalk()
{
	standtoprone();
	pronetopronerun();
}

//Function Number: 47
standtopronerun()
{
	standtoprone();
	pronetopronerun();
}

//Function Number: 48
crouchruntoprone()
{
	var_00 = 0.5;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts\utility::enterpronewrapper(var_00);
	pronelegsstraighttree(0.2);
	animscripts\cover_prone::updatepronewrapper(0.1);
	var_01 = animscripts\utility::getquadrant(self getmotionangle());
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
	pronetopronerun();
}

//Function Number: 50
crouchruntopronerun()
{
	crouchruntoprone();
	pronetopronerun();
}

//Function Number: 51
playtransitionanimationthread_withoutwaitsetstates(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("entered_pose" + param_01);
	playtransitionanimationfunc(param_00,param_01,param_02,param_03,param_04,0);
}

//Function Number: 52
playtransitionanimation(param_00,param_01,param_02,param_03,param_04)
{
	playtransitionanimationfunc(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 53
playtransitionanimationfunc(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_05)
	{
		thread waitsetstates(getanimlength(param_00) / 2,"killtimerscript",param_01);
	}

	self setflaggedanimknoballrestart("transAnimDone2",param_00,%body,1,0.2,param_04);
	if(!isdefined(self.a.pose))
	{
		self.pose = "undefined";
	}

	if(!isdefined(self.a.movement))
	{
		self.movement = "undefined";
	}

	var_06 = "";
	animscripts\shared::donotetracks("transAnimDone2",undefined,var_06);
	self notify("killtimerscript");
	self.a.pose = param_01;
	self notify("entered_pose" + param_01);
	self.a.movement = param_02;
	if(isdefined(param_03))
	{
		self setanimknoball(param_03,%body,1,0.3,param_04);
	}
}

//Function Number: 54
waitsetstates(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon(param_01);
	var_03 = self.a.pose;
	wait(param_00);
	if(var_03 != "prone" && param_02 == "prone")
	{
		animscripts\cover_prone::updatepronewrapper(0.1);
		animscripts\utility::enterpronewrapper(1);
		return;
	}

	if(var_03 == "prone" && param_02 != "prone")
	{
		animscripts\utility::exitpronewrapper(1);
		self orientmode("face default");
	}
}

//Function Number: 55
pronelegsstraighttree(param_00)
{
	self setanimknoball(%prone_legsstraight,%body,1,param_00,1);
}