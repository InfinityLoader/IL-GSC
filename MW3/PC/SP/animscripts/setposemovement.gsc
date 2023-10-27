/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\setposemovement.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 837 ms
 * Timestamp: 10/27/2023 2:18:41 AM
*******************************************************************/

//Function Number: 1
func_10F1(param_00,param_01)
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

	[[ level.var_240E[param_00][param_01] ]]();
}

//Function Number: 2
func_20D9()
{
	level.var_240E["stand"]["stop"] = ::func_240F;
	level.var_240E["stand"]["walk"] = ::func_1080;
	level.var_240E["stand"]["run"] = ::func_0FBB;
	level.var_240E["crouch"]["stop"] = ::func_2410;
	level.var_240E["crouch"]["walk"] = ::func_1083;
	level.var_240E["crouch"]["run"] = ::func_0FBF;
	level.var_240E["prone"]["stop"] = ::func_2411;
	level.var_240E["prone"]["walk"] = ::func_1084;
	level.var_240E["prone"]["run"] = ::func_0FC1;
}

//Function Number: 3
func_240F()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					return 0;
	
				case "walk":
					func_2414();
					break;
	
				default:
					func_2416();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_241C();
					break;
	
				case "walk":
					func_2421();
					break;
	
				default:
					func_2423();
					break;
			}
			break;

		default:
			switch(self.a.movement)
			{
				case "stop":
					func_242E();
					break;
	
				default:
					func_242E();
					break;
			}
			break;
	}

	return 1;
}

//Function Number: 4
func_1080()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_241A();
					break;
	
				case "walk":
					return 0;
	
				default:
					func_241A();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_241F();
					break;
	
				case "walk":
					func_241A();
					break;
	
				default:
					func_241A();
					break;
			}
			break;

		default:
			func_242F();
			break;
	}

	return 1;
}

//Function Number: 5
func_0FBB()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "walk":
				case "stop":
					return func_2419();
	
				default:
					return 0;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					return func_2425();
	
				default:
					return func_2419();
			}
			break;

		default:
			func_2428();
			break;
	}

	return 1;
}

//Function Number: 6
func_2410()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_242B();
					break;
	
				case "walk":
					func_2415();
					break;
	
				case "run":
					func_2417();
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
					func_2420();
					break;
	
				case "run":
					func_2422();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			func_242D();
			break;

		default:
			break;
	}
}

//Function Number: 7
func_1083()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_242A();
					break;
	
				case "walk":
					func_242A();
					break;
	
				default:
					func_242A();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_241E();
					break;
	
				case "walk":
					return 0;
	
				default:
					func_242A();
					break;
			}
			break;

		default:
			func_2429();
			break;
	}

	return 1;
}

//Function Number: 8
func_0FBF()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_2426();
					break;
	
				default:
					func_2426();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_2424();
					break;
	
				case "walk":
					func_2426();
					break;
	
				default:
					return 0;
			}
			break;

		default:
			func_2427();
			break;
	}

	return 1;
}

//Function Number: 9
func_2411()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_2436();
					break;
	
				case "walk":
					func_2436();
					break;
	
				case "run":
					func_2439();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_2433();
					break;
	
				case "walk":
					func_2433();
					break;
	
				case "run":
					func_2439();
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
					func_2432();
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
func_1084()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_2437();
					break;
	
				default:
					func_243B();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_2434();
					break;
	
				default:
					func_243B();
					break;
			}
			break;

		default:
			switch(self.a.movement)
			{
				case "stop":
					func_2431();
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
func_0FC1()
{
	switch(self.a.pose)
	{
		case "stand":
			switch(self.a.movement)
			{
				case "stop":
					func_2438();
					break;
	
				default:
					func_243C();
					break;
			}
			break;

		case "crouch":
			switch(self.a.movement)
			{
				case "stop":
					func_2435();
					break;
	
				default:
					func_243C();
					break;
			}
			break;

		default:
			switch(self.a.movement)
			{
				case "stop":
					func_2431();
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
func_2412(param_00,param_01,param_02,param_03)
{
	var_04 = gettime() + param_01 * 1000;
	if(isarray(param_00))
	{
		param_00 = param_00[randomint(param_00.size)];
	}

	self setflaggedanimknoball("blendTransition",param_00,%body,1,param_01,1);
	animscripts/notetracks::func_D4F(param_01 / 2,"blendTransition");
	self.a.pose = param_02;
	self.a.movement = param_03;
	var_05 = var_04 - gettime() / 1000;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	animscripts/notetracks::func_D4F(var_05,"blendTransition");
}

//Function Number: 13
func_2413(param_00,param_01)
{
	func_243E(param_00,"stand","walk",param_01);
}

//Function Number: 14
func_2414()
{
	self.a.movement = "stop";
}

//Function Number: 15
func_2415()
{
	func_2414();
	func_242B();
}

//Function Number: 16
func_2416()
{
	self.a.movement = "stop";
}

//Function Number: 17
func_2417()
{
	self.a.movement = "stop";
	self.a.pose = "crouch";
}

//Function Number: 18
func_2418(param_00)
{
	var_01 = 0.3;
	if(self.a.movement != "stop")
	{
		self endon("movemode");
		var_01 = 1;
	}

	func_2412(param_00,var_01,"stand","run");
}

//Function Number: 19
func_2419()
{
	if(!self.var_781)
	{
		self.a.movement = "run";
		self.a.pose = "stand";
		return 0;
	}

	if(isdefined(self.run_overrideanim))
	{
		func_2418(self.run_overrideanim);
		return 1;
	}

	var_00 = 0.1;
	if(self.a.movement != "stop" && self.var_786 == "none")
	{
		var_00 = 0.5;
	}

	if(isdefined(self.sprint))
	{
		self setanimknoblimited(animscripts/utility::func_FC3("sprint"),1,var_00,1);
	}
	else
	{
		self setanimknoblimited(animscripts/run::func_FC2(),1,var_00,1);
	}

	animscripts/run::func_FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"),self.var_FE0);
	thread animscripts/run::func_FF8("run");
	wait 0.05;
	func_2418(%combatrun);
	return 1;
}

//Function Number: 20
func_241A()
{
	if(self.a.movement != "stop")
	{
		self endon("movemode");
	}

	if(!isdefined(self.alwaysrunforward) && self.a.pose != "prone")
	{
		animscripts/run::func_FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"));
	}

	self.a.pose = "stand";
	self.a.movement = "walk";
}

//Function Number: 21
func_241C()
{
	var_00 = 1;
	if(isdefined(self.var_241D))
	{
		var_00 = 1.8;
		self.var_241D = undefined;
	}

	if(animscripts/utility::func_C95())
	{
		func_243E(%pistol_crouchaimstraight2stand,"stand","stop",undefined,var_00);
		return;
	}

	animscripts/utility::func_10F0();
	func_243E(%crouch2stand,"stand","stop",undefined,var_00);
}

//Function Number: 22
func_241E()
{
	func_242A();
}

//Function Number: 23
func_241F()
{
	func_241E();
	func_241A();
}

//Function Number: 24
func_2420()
{
	self.a.movement = "stop";
}

//Function Number: 25
func_2421()
{
	func_2420();
	func_241C();
}

//Function Number: 26
func_2422()
{
	self.a.movement = "stop";
}

//Function Number: 27
func_2423()
{
	func_2422();
	func_241C();
}

//Function Number: 28
func_2424()
{
	func_2426();
}

//Function Number: 29
func_2425()
{
	return func_2419();
}

//Function Number: 30
func_2426()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		func_2412(self.crouchrun_combatanim,0.6,"crouch","run");
		return;
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts/run::func_FF9("crouchrun",animscripts/utility::func_FC3("crouch"),animscripts/utility::func_FC3("crouch_b"),animscripts/utility::func_FC3("crouch_l"),animscripts/utility::func_FC3("crouch_r"));
	wait 0.05;
	func_2412(%crouchrun,0.4,"crouch","run");
}

//Function Number: 31
func_2427()
{
	self orientmode("face current");
	animscripts/utility::func_F7D(1);
	func_2441(0.2);
	animscripts/cover_prone::func_10E2(0.1);
	func_243E(%prone_2_crouch,"crouch","run",animscripts/run::func_FC4());
}

//Function Number: 32
func_2428()
{
	func_2427();
	func_2419();
}

//Function Number: 33
func_2429()
{
	func_2427();
	func_242A();
}

//Function Number: 34
func_242A()
{
	if(isdefined(self.crouchrun_combatanim))
	{
		self setanimknoball(self.crouchrun_combatanim,%body,1,0.4);
		func_2412(self.crouchrun_combatanim,0.6,"crouch","walk");
		self notify("BlendIntoCrouchWalk");
		return;
	}

	self setanimknob(%crouchrun,1,0.4,self.moveplaybackrate);
	thread animscripts/run::func_FF9("crouchrun",animscripts/utility::func_FC3("crouch"),animscripts/utility::func_FC3("crouch_b"),animscripts/utility::func_FC3("crouch_l"),animscripts/utility::func_FC3("crouch_r"));
	wait 0.05;
	func_2412(%crouchrun,0.4,"crouch","run");
}

//Function Number: 35
func_242B()
{
	animscripts/utility::func_10F0();
	var_00 = 1;
	if(isdefined(self.var_242C))
	{
		var_00 = 1.8;
		self.var_242C = undefined;
	}

	func_243E(%exposed_stand_2_crouch,"crouch","stop",undefined,var_00);
}

//Function Number: 36
func_242D()
{
	animscripts/utility::func_10F0();
	self orientmode("face current");
	animscripts/utility::func_F7D(1);
	func_2441(0.1);
	animscripts/cover_prone::func_10E2(0.1);
	func_243E(%prone_2_crouch,"crouch","stop");
}

//Function Number: 37
func_242E()
{
	self orientmode("face current");
	animscripts/utility::func_F7D(1);
	func_2441(0.1);
	animscripts/cover_prone::func_10E2(0.1);
	func_243E(%prone_2_stand,"stand","stop");
}

//Function Number: 38
func_242F()
{
	func_242D();
	func_241E();
	func_241A();
}

//Function Number: 39
func_2430(param_00)
{
	func_2441(0.1);
	func_243E(%prone_2_prone_crawl,"prone",param_00,%prone_crawl);
	animscripts/cover_prone::func_10E2(0.1);
}

//Function Number: 40
func_2431()
{
	func_2430("run");
}

//Function Number: 41
func_2432()
{
	func_2441(0.1);
	animscripts/cover_prone::func_10E2(0.1);
	func_243E(%prone_crawl_2_prone,"prone","stop");
}

//Function Number: 42
func_2433()
{
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::func_10E1(1);
	func_2441(0.3);
	animscripts/cover_prone::func_10E2(0.1);
	func_243E(%crouch_2_prone,"prone","stop");
}

//Function Number: 43
func_2434()
{
	func_2433();
	func_2431();
}

//Function Number: 44
func_2435()
{
	func_2433();
	func_2431();
}

//Function Number: 45
func_2436()
{
	self endon("entered_poseprone");
	var_00 = 0.5;
	thread func_243D(%stand_2_prone,"prone","stop",undefined,var_00);
	self waittillmatch("anim_pose = \"crouch\","transAnimDone2");
	waittillframeend;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::func_10E1(var_00);
	self.a.movement = "stop";
	func_2441(0.2);
	animscripts/cover_prone::func_10E2(0.1);
	self waittillmatch("end","transAnimDone2");
}

//Function Number: 46
func_2437()
{
	func_2436();
	func_2431();
}

//Function Number: 47
func_2438()
{
	func_2436();
	func_2431();
}

//Function Number: 48
func_2439()
{
	var_00 = 0.5;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::func_10E1(var_00);
	func_2441(0.2);
	animscripts/cover_prone::func_10E2(0.1);
	var_01 = animscripts/utility::func_243A(self getmotionangle());
	var_02 = %crouch_2_prone;
	var_03 = getmovedelta(var_02,0,1);
	var_04 = self localtoworldcoords(var_03);
	if(self maymovetopoint(var_04))
	{
		func_243E(var_02,"prone","stop",undefined,var_00);
		return;
	}

	func_243E(%crouch_2_prone_firing,"prone","stop",undefined,var_00);
}

//Function Number: 49
func_243B()
{
	func_2439();
	func_2431();
}

//Function Number: 50
func_243C()
{
	func_2439();
	func_2431();
}

//Function Number: 51
func_243D(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("entered_pose" + param_01);
	func_243F(param_00,param_01,param_02,param_03,param_04,0);
}

//Function Number: 52
func_243E(param_00,param_01,param_02,param_03,param_04)
{
	func_243F(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 53
func_243F(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_05)
	{
		thread func_2440(getanimlength(param_00) / 2,"killtimerscript",param_01);
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
	animscripts/shared::donotetracks("transAnimDone2",undefined,var_06);
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
func_2440(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon(param_01);
	var_03 = self.a.pose;
	wait param_00;
	if(var_03 != "prone" && param_02 == "prone")
	{
		animscripts/cover_prone::func_10E2(0.1);
		animscripts/utility::func_10E1(1);
		return;
	}

	if(var_03 == "prone" && param_02 != "prone")
	{
		animscripts/utility::func_F7D(1);
		self orientmode("face default");
	}
}

//Function Number: 55
func_2441(param_00)
{
	self setanimknoball(%prone_legsstraight,%body,1,param_00,1);
}