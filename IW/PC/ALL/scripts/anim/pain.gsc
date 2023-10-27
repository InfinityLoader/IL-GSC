/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\pain.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 2621 ms
 * Timestamp: 10/27/2023 12:00:50 AM
*******************************************************************/

//Function Number: 1
func_951B()
{
}

//Function Number: 2
main()
{
	self endon("killanimscript");
	lib_0A1E::func_C879();
}

//Function Number: 3
func_98AC()
{
	level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
}

//Function Number: 4
func_010B()
{
}

//Function Number: 5
func_1390C()
{
	if(!isdefined(self.var_DE))
	{
		return 0;
	}

	if(function_0107(self.var_DE))
	{
		return 1;
	}

	if(scripts\common\utility::func_1390D())
	{
		return 1;
	}

	if(self.var_DE == "MOD_MELEE" && isdefined(self.var_4F) && isdefined(self.var_4F.var_12BA4) && self.var_4F.var_12BA4 == "c8")
	{
		return 1;
	}

	if(gettime() - level.var_A955 <= 50)
	{
		var_00 = level.var_A954 * level.var_A954 * 1.2 * 1.2;
		if(distancesquared(self.origin,level.var_A952) < var_00)
		{
			var_01 = var_00 * 0.5 * 0.5;
			self.var_B4DF = distancesquared(self.origin,level.var_A953) < var_01;
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
func_7E5D()
{
	if(self.var_1491.var_D6A5 == "prone")
	{
		return;
	}

	if(isdefined(self.var_1B1) && isdefined(self.var_1B1.team) && self.var_1B1.team == self.team)
	{
		return;
	}

	if(!isdefined(self.var_4D68) || gettime() - self.var_1491.var_A9C8 > 1500)
	{
		self.var_4D68 = randomintrange(2,3);
	}

	if(isdefined(self.var_1B1) && distancesquared(self.origin,self.var_1B1.origin) < squared(512))
	{
		self.var_4D68 = 0;
	}

	if(self.var_4D68 > 0)
	{
		self.var_4D68--;
		return;
	}

	self.var_4D6A = 1;
	self.allowpain = 0;
	if(self.ignoreme)
	{
		self.var_D817 = 1;
	}
	else
	{
		self.ignoreme = 1;
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		scripts\anim\shared::func_CC2C(self.var_D8E1,"right");
	}

	if(self.var_1491.var_D6A5 == "crouch")
	{
		return scripts\anim\utility::func_B027("pain","damage_shield_crouch");
	}

	var_00 = scripts\anim\utility::func_B027("pain","damage_shield_pain_array");
	return var_00[randomint(var_00.size)];
}

//Function Number: 7
func_8041()
{
	if(self.var_E0 && !isdefined(self.var_55BF))
	{
		var_00 = func_7E5D();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.var_1491.var_C4C8))
	{
		if(self.var_1491.var_D6A5 == "crouch")
		{
			return scripts\anim\utility::func_B027("pain","back");
		}
		else
		{
			scripts\anim\notetracks::func_11082();
		}
	}

	if(self.var_1491.var_D6A5 == "stand")
	{
		var_01 = isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < 4096;
		if(!var_01 && self.var_1491.var_BCC8 == "run" && abs(self method_813E()) < 60)
		{
			return func_80FD();
		}

		self.var_1491.var_BCC8 = "stop";
		return func_815E();
	}

	if(self.var_1491.var_D6A5 == "crouch")
	{
		self.var_1491.var_BCC8 = "stop";
		return func_7E46();
	}

	if(self.var_1491.var_D6A5 == "prone")
	{
		self.var_1491.var_BCC8 = "stop";
		return func_80A0();
	}
}

//Function Number: 8
func_80FD()
{
	var_00 = [];
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(self method_8200(self method_81E7((300,0,0))))
	{
		var_02 = 1;
		var_01 = 1;
	}
	else if(self method_8200(self method_81E7((200,0,0))))
	{
		var_01 = 1;
	}

	if(isdefined(self.var_1491.var_55FD))
	{
		var_02 = 0;
		var_01 = 0;
	}

	if(var_02)
	{
		var_00 = scripts\anim\utility::func_B027("pain","run_long");
	}
	else if(var_01)
	{
		var_00 = scripts\anim\utility::func_B027("pain","run_medium");
	}
	else if(self method_8200(self method_81E7((120,0,0))))
	{
		var_00 = scripts\anim\utility::func_B027("pain","run_short");
	}

	if(!var_00.size)
	{
		self.var_1491.var_BCC8 = "stop";
		return func_815E();
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 9
func_8160()
{
	var_00 = [];
	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_torso_upper");
	}
	else if(scripts\common\utility::func_4D59("torso_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_torso_lower");
	}
	else if(scripts\common\utility::func_4D59("neck"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_neck");
	}
	else if(scripts\common\utility::func_4D59("head"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_head");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","right_leg_upper"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_leg");
	}
	else if(scripts\common\utility::func_4D59("left_arm_upper"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_left_arm_upper");
	}
	else if(scripts\common\utility::func_4D59("left_arm_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_left_arm_lower");
	}
	else if(scripts\common\utility::func_4D59("right_arm_upper"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_right_arm_upper");
	}
	else if(scripts\common\utility::func_4D59("right_arm_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","pistol_right_arm_lower");
	}

	if(var_00.size < 2)
	{
		var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","pistol_default1"));
	}

	if(var_00.size < 2)
	{
		var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","pistol_default2"));
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 10
func_815E()
{
	if(scripts\anim\utility_common::func_9FCA())
	{
		return func_8160();
	}

	var_00 = [];
	var_01 = [];
	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","torso_upper");
		var_01 = scripts\anim\utility::func_B027("pain","torso_upper_extended");
	}
	else if(scripts\common\utility::func_4D59("torso_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","torso_lower");
		var_01 = scripts\anim\utility::func_B027("pain","torso_lower_extended");
	}
	else if(scripts\common\utility::func_4D59("head","helmet","neck"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","head");
		var_01 = scripts\anim\utility::func_B027("pain","head_extended");
	}
	else if(scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","right_arm");
		var_01 = scripts\anim\utility::func_B027("pain","right_arm_extended");
	}
	else if(scripts\common\utility::func_4D59("left_arm_upper","left_arm_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","left_arm");
		var_01 = scripts\anim\utility::func_B027("pain","left_arm_extended");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","right_leg_upper"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","leg");
		var_01 = scripts\anim\utility::func_B027("pain","leg_extended");
	}
	else if(scripts\common\utility::func_4D59("left_foot","right_foot","left_leg_lower","right_leg_lower"))
	{
		var_00 = scripts\anim\utility::func_B027("pain","foot");
		var_01 = scripts\anim\utility::func_B027("pain","foot_extended");
	}

	if(var_00.size < 2)
	{
		if(!self.var_1491.var_55FC)
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","default_long"));
		}
		else
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","default_short"));
		}
	}

	if(var_01.size < 2)
	{
		var_01 = scripts\common\utility::array_combine(var_01,scripts\anim\utility::func_B027("pain","default_extended"));
	}

	if(!self.var_E0 && !self.var_1491.var_55FC)
	{
		var_02 = randomint(var_00.size + var_01.size);
		if(var_02 < var_00.size)
		{
			return var_00[var_02];
		}
		else
		{
			return var_01[var_02 - var_00.size];
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 11
func_7E46()
{
	var_00 = [];
	if(!self.var_E0 && !self.var_1491.var_55FC)
	{
		var_00 = scripts\anim\utility::func_B027("pain","crouch_longdeath");
	}

	var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","crouch_default"));
	if(scripts\common\utility::func_4D59("left_hand","left_arm_lower","left_arm_upper"))
	{
		var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","crouch_left_arm"));
	}

	if(scripts\common\utility::func_4D59("right_hand","right_arm_lower","right_arm_upper"))
	{
		var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("pain","crouch_right_arm"));
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 12
func_80A0()
{
	var_00 = scripts\anim\utility::func_B027("pain","prone");
	return var_00[randomint(var_00.size)];
}

//Function Number: 13
func_D4EE(param_00)
{
	var_01 = 1;
	func_C86D("painanim",param_00,%body,1,0.1,var_01);
	if(self.var_1491.var_D6A5 == "prone")
	{
		self method_83CF(%prone_legs_up,%prone_legs_down,1,0.1,1);
	}

	if(animhasnotetrack(param_00,"start_aim"))
	{
		thread func_C172("painanim");
		self endon("start_aim");
	}

	if(animhasnotetrack(param_00,"code_move"))
	{
		scripts\anim\shared::func_592B("painanim");
	}

	scripts\anim\shared::func_592B("painanim");
}

//Function Number: 14
func_C172(param_00)
{
	self endon("killanimscript");
	self waittillmatch("start_aim",param_00);
	self notify("start_aim");
}

//Function Number: 15
func_10969()
{
	self endon("killanimscript");
	self.var_2BB9 = 1;
	self.allowpain = 0;
	wait(0.5);
	self.var_2BB9 = undefined;
	self.allowpain = 1;
}

//Function Number: 16
func_10968(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	self.var_1491.var_10930 = "none";
	thread func_10969();
	switch(param_00)
	{
		case "cover_left":
			if(self.var_1491.var_D6A5 == "stand")
			{
				var_01 = scripts\anim\utility::func_B027("pain","cover_left_stand");
				func_5A5B(var_01);
				var_02 = 1;
			}
			else if(self.var_1491.var_D6A5 == "crouch")
			{
				var_01 = scripts\anim\utility::func_B027("pain","cover_left_crouch");
				func_5A5B(var_01);
				var_02 = 1;
			}
			else
			{
				var_02 = 0;
			}
			break;

		case "cover_right":
			if(self.var_1491.var_D6A5 == "stand")
			{
				var_01 = scripts\anim\utility::func_B027("pain","cover_right_stand");
				func_5A5B(var_01);
				var_02 = 1;
			}
			else if(self.var_1491.var_D6A5 == "crouch")
			{
				var_01 = scripts\anim\utility::func_B027("pain","cover_right_crouch");
				func_5A5B(var_01);
				var_02 = 1;
			}
			else
			{
				var_02 = 0;
			}
			break;

		case "cover_right_stand_A":
			var_02 = 0;
			break;

		case "cover_right_stand_B":
			func_5A5A(scripts\anim\utility::func_B027("pain","cover_right_stand_B"));
			var_02 = 1;
			break;

		case "cover_left_stand_A":
			func_5A5A(scripts\anim\utility::func_B027("pain","cover_left_stand_A"));
			var_02 = 1;
			break;

		case "cover_left_stand_B":
			func_5A5A(scripts\anim\utility::func_B027("pain","cover_left_stand_B"));
			var_02 = 1;
			break;

		case "cover_crouch":
			var_01 = scripts\anim\utility::func_B027("pain","cover_crouch");
			func_5A5B(var_01);
			var_02 = 1;
			break;

		case "cover_stand":
			var_01 = scripts\anim\utility::func_B027("pain","cover_stand");
			func_5A5B(var_01);
			var_02 = 1;
			break;

		case "cover_stand_aim":
			var_01 = scripts\anim\utility::func_B027("pain","cover_stand_aim");
			func_5A5B(var_01);
			var_02 = 1;
			break;

		case "cover_crouch_aim":
			var_01 = scripts\anim\utility::func_B027("pain","cover_crouch_aim");
			func_5A5B(var_01);
			var_02 = 1;
			break;

		case "saw":
			if(self.var_1491.var_D6A5 == "stand")
			{
				var_03 = scripts\anim\utility::func_B027("pain","saw_stand");
			}
			else if(self.var_1491.var_D6A5 == "crouch")
			{
				var_03 = scripts\anim\utility::func_B027("pain","saw_crouch");
			}
			else
			{
				var_03 = scripts\anim\utility::func_B027("pain","saw_prone");
			}
	
			func_C86C("painanim",var_03,1,0.3,1);
			scripts\anim\shared::func_592B("painanim");
			var_02 = 1;
			break;

		case "mg42":
			func_B6AE(self.var_1491.var_D6A5);
			var_02 = 1;
			break;

		case "minigun":
			var_02 = 0;
			break;

		case "corner_right_martyrdom":
			var_02 = func_12893();
			break;

		case "dying_crawl":
		case "rambo_right":
		case "rambo_left":
		case "rambo":
			var_02 = 0;
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_02;
}

//Function Number: 17
func_C874()
{
	self endon("death");
	wait(0.05);
	self notify("pain_death");
}

//Function Number: 18
func_5A5B(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	func_C86C("painanim",var_01,1,0.3,1);
	scripts\anim\shared::func_592B("painanim");
}

//Function Number: 19
func_5A5A(param_00)
{
	func_C86C("painanim",param_00,1,0.3,1);
	scripts\anim\shared::func_592B("painanim");
}

//Function Number: 20
func_B6AE(param_00)
{
	func_C86C("painanim",level.var_B6B0["pain_" + param_00],1,0.1,1);
	scripts\anim\shared::func_592B("painanim");
}

//Function Number: 21
func_13713(param_00,param_01)
{
	self endon("killanimscript");
	self endon("death");
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	wait(param_00);
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 22
func_4874()
{
	if(self.var_1491.var_55FC || self.var_EF || self.var_E0)
	{
		return 0;
	}

	if(self.var_2C0 != "none")
	{
		return 0;
	}

	if(isdefined(self.var_1491.var_C4C8))
	{
		return 0;
	}

	var_00 = scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot");
	if(isdefined(self.var_72CC))
	{
		func_F6AD(var_00);
		self.health = 10;
		thread func_4877();
		self waittill("killanimscript");
		return 1;
	}

	if(self.health > 100)
	{
		return 0;
	}

	if(var_00 && self.health < self.maxhealth * 0.4)
	{
		if(gettime() < level.var_BF78)
		{
			return 0;
		}
	}
	else
	{
		if(level.var_C222 > 0)
		{
			return 0;
		}

		if(gettime() < level.var_BF77)
		{
			return 0;
		}
	}

	if(isdefined(self.var_4E46))
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		if(distancesquared(self.origin,var_02.origin) < 30625)
		{
			return 0;
		}
	}

	if(scripts\common\utility::func_4D59("head","helmet","gun","right_hand","left_hand"))
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		return 0;
	}

	func_F6AD(var_00);
	if(!isdefined(self.var_1491.var_11188) && !func_9D9D(self.var_1491.var_4876))
	{
		return 0;
	}

	anim.var_BF77 = gettime() + 3000;
	anim.var_BF78 = gettime() + 3000;
	thread func_4877();
	self waittill("killanimscript");
	return 1;
}

//Function Number: 23
func_F6AD(param_00)
{
	var_01 = [];
	var_02 = undefined;
	if(self.var_1491.var_D6A5 == "stand")
	{
		var_02 = func_FFC3(param_00);
		if(isdefined(var_02))
		{
			var_01 = [var_02[0]];
		}
		else
		{
			var_01 = scripts\anim\utility::func_B027("crawl_death","stand_transition");
		}
	}
	else if(self.var_1491.var_D6A5 == "crouch")
	{
		var_01 = scripts\anim\utility::func_B027("crawl_death","crouch_transition");
	}
	else
	{
		var_01 = scripts\anim\utility::func_B027("crawl_death","prone_transition");
	}

	self.var_1491.var_4876 = var_01[randomint(var_01.size)];
	self.var_1491.var_11188 = var_02;
}

//Function Number: 24
func_9D9D(param_00)
{
	if(isdefined(self.var_1491.var_7280))
	{
		return 1;
	}

	var_01 = getmovedelta(param_00,0,1);
	var_02 = self method_81E7(var_01);
	return self method_8200(var_02);
}

//Function Number: 25
func_4877()
{
	self endon("kill_long_death");
	self endon("death");
	thread func_D899("crawling");
	self.var_1491.var_10930 = "none";
	self.var_10957 = undefined;
	self method_8306();
	thread func_C874();
	level notify("ai_crawling",self);
	self method_82A5(%dying,%body,1,0.1,1);
	if(isdefined(self.var_1491.var_11188))
	{
		func_11185();
		self.var_1491.var_11188 = undefined;
		return;
	}

	if(!func_5F71())
	{
		return;
	}

	func_C86C("transition",self.var_1491.var_4876,1,0.5,1);
	scripts\anim\notetracks::func_5936("transition",::func_8977);
	self.var_1491.var_10930 = "dying_crawl";
	thread func_5F73();
	if(isdefined(self.var_10C))
	{
		self method_8306(self.var_10C);
	}

	func_4F64();
	while(func_10031())
	{
		var_00 = scripts\anim\utility::func_B027("crawl_death","back_crawl");
		if(!func_9D9D(var_00))
		{
			break;
		}

		func_C86E("back_crawl",var_00,1,0.1,1);
		scripts\anim\notetracks::func_5936("back_crawl",::func_8977);
	}

	self.var_527E = gettime() + randomintrange(4000,20000);
	while(func_10099())
	{
		if(scripts\anim\utility_common::func_3907() && func_1A3C())
		{
			var_01 = scripts\anim\utility::func_B027("crawl_death","back_fire");
			func_C86E("back_idle_or_fire",var_01,1,0.2,1);
			scripts\anim\shared::func_592B("back_idle_or_fire");
			continue;
		}

		var_01 = scripts\anim\utility::func_B027("crawl_death","back_idle");
		if(randomfloat(1) < 0.4)
		{
			var_02 = scripts\anim\utility::func_B027("crawl_death","back_idle_twitch");
			var_01 = var_02[randomint(var_02.size)];
		}

		func_C86E("back_idle_or_fire",var_01,1,0.1,1);
		var_03 = getanimlength(var_01);
		while(var_03 > 0)
		{
			if(scripts\anim\utility_common::func_3907() && func_1A3C())
			{
				break;
			}

			var_04 = 0.5;
			if(var_04 > var_03)
			{
				var_04 = var_03;
				var_03 = 0;
				continue;
			}

			var_03 = var_03 - var_04;
			scripts\anim\notetracks::func_5931(var_04,"back_idle_or_fire");
		}
	}

	self notify("end_dying_crawl_back_aim");
	self method_806F(%dying_back_aim_4_wrapper,0.3);
	self method_806F(%dying_back_aim_6_wrapper,0.3);
	var_05 = scripts\anim\utility::func_B027("crawl_death","back_death");
	self.var_4E2A = var_05[randomint(var_05.size)];
	func_A6CE();
	self.var_1491.var_10930 = "none";
	self.var_10957 = undefined;
}

//Function Number: 26
func_FFC3(param_00)
{
	if(self.var_1491.var_D6A5 != "stand")
	{
		return;
	}

	var_01 = 2;
	if(randomint(10) > var_01)
	{
		return;
	}

	var_02 = 0;
	if(!param_00)
	{
		var_02 = scripts\common\utility::func_4D59("torso_upper","torso_lower");
		if(!var_02)
		{
			return;
		}
	}

	var_03 = 0;
	var_04 = "leg";
	var_05 = "b";
	if(param_00)
	{
		var_03 = 200;
	}
	else
	{
		var_04 = "gut";
		var_03 = 128;
		if(45 < self.var_E3 && self.var_E3 < 135)
		{
			var_05 = "l";
		}
		else if(-135 < self.var_E3 && self.var_E3 < -45)
		{
			var_05 = "r";
		}
		else if(-45 < self.var_E3 && self.var_E3 < 45)
		{
			return;
		}
	}

	switch(var_05)
	{
		case "b":
			var_06 = anglestoforward(self.angles);
			var_07 = self.origin - var_06 * var_03;
			break;

		case "l":
			var_08 = anglestoright(self.angles);
			var_07 = self.origin - var_08 * var_03;
			break;

		case "r":
			var_08 = anglestoright(self.angles);
			var_07 = self.origin + var_08 * var_03;
			break;

		default:
			break;
	}

	if(!self method_8200(var_07))
	{
		return;
	}

	var_09 = scripts\anim\utility::func_B027("crawl_death","longdeath");
	var_0A = var_04 + "_" + var_05;
	var_0B = randomint(var_09[var_0A].size);
	var_0C = var_09[var_0A][var_0B];
	return var_0C;
}

//Function Number: 27
func_11185()
{
	func_C86E("stumblingPainInto",self.var_1491.var_11188[0]);
	scripts\anim\shared::func_592B("stumblingPainInto");
	self.var_1491.var_10930 = "stumbling_pain";
	var_00 = getmovedelta(self.var_1491.var_11188[2]);
	var_01 = getanimlength(self.var_1491.var_11188[2]) * 1000;
	for(var_02 = randomint(2) + 1;var_02 > 0;var_02--)
	{
		var_03 = anglestoforward(self.angles);
		var_04 = self.origin + var_03 * var_00;
		if(!self method_8200(var_04))
		{
			break;
		}

		func_C86E("stumblingPain",self.var_1491.var_11188[1]);
		scripts\anim\shared::func_592B("stumblingPain");
	}

	self.var_1491.var_C043 = 1;
	self.var_1491.var_10930 = "none";
	func_C86E("stumblingPainCollapse",self.var_1491.var_11188[2],1,0.75);
	scripts\anim\notetracks::func_5936("stumblingPainCollapse",::func_11189);
	scripts\anim\shared::func_592B("stumblingPainCollapse");
	func_A6CE();
}

//Function Number: 28
func_11189(param_00)
{
	if(param_00 == "start_ragdoll")
	{
		scripts\anim\notetracks::func_89CB(param_00,"stumblingPainCollapse");
		return 1;
	}
}

//Function Number: 29
func_10099()
{
	if(!func_6562(anglestoforward(self.angles)))
	{
		return 0;
	}

	return gettime() < self.var_527E;
}

//Function Number: 30
func_5F71()
{
	if(!isdefined(self.var_72CC))
	{
		if(self.var_1491.var_D6A5 == "prone")
		{
			return 1;
		}

		if(self.var_1491.var_BCC8 == "stop")
		{
			if(randomfloat(1) < 0.4)
			{
				if(randomfloat(1) < 0.5)
				{
					return 1;
				}
			}
			else if(abs(self.var_E3) > 90)
			{
				return 1;
			}
		}
		else if(abs(self method_813E()) > 90)
		{
			return 1;
		}
	}

	if(self.var_1491.var_D6A5 != "prone")
	{
		var_00 = scripts\anim\utility::func_B027("crawl_death",self.var_1491.var_D6A5 + "_2_crawl");
		var_01 = var_00[randomint(var_00.size)];
		if(!func_9D9D(var_01))
		{
			return 1;
		}

		thread func_5F74();
		func_C86C("falling",var_01,1,0.5,1);
		scripts\anim\shared::func_592B("falling");
	}
	else
	{
		thread func_5F74();
	}

	self.var_1491.var_4876 = scripts\anim\utility::func_B027("crawl_death","default_transition");
	self.var_1491.var_10930 = "dying_crawl";
	func_4F64();
	var_02 = scripts\anim\utility::func_B027("crawl_death","crawl");
	while(func_10031())
	{
		if(!func_9D9D(var_02))
		{
			return 1;
		}

		if(isdefined(self.var_4C41))
		{
			self playsound(self.var_4C41);
		}

		func_C86E("crawling",var_02,1,0.1,1);
		scripts\anim\shared::func_592B("crawling");
	}

	self notify("done_crawling");
	if(!isdefined(self.var_72CC) && func_6562(anglestoforward(self.angles) * -1))
	{
		return 1;
	}

	var_03 = scripts\anim\utility::func_B027("crawl_death","death");
	var_04 = var_03[randomint(var_03.size)];
	scripts\anim\death::func_CF0E(var_04);
	func_A6CE();
	self.var_1491.var_10930 = "none";
	self.var_10957 = undefined;
	return 0;
}

//Function Number: 31
func_5F74()
{
	self endon("death");
	if(self.var_1491.var_D6A5 != "prone")
	{
		for(;;)
		{
			self waittill("falling",var_00);
			if(issubstr(var_00,"bodyfall"))
			{
				break;
			}
		}
	}

	var_01 = "J_SpineLower";
	var_02 = "tag_origin";
	var_03 = 0.25;
	var_04 = level._effect["crawling_death_blood_smear"];
	if(isdefined(self.var_1491.var_486A))
	{
		var_03 = self.var_1491.var_486A;
	}

	if(isdefined(self.var_1491.var_4869))
	{
		var_04 = level._effect[self.var_1491.var_4869];
	}

	while(var_03)
	{
		var_05 = self gettagorigin(var_01);
		var_06 = self gettagangles(var_02);
		var_07 = anglestoright(var_06);
		var_08 = anglestoforward((270,0,0));
		playfx(var_04,var_05,var_08,var_07);
		wait(var_03);
	}
}

//Function Number: 32
func_5F73()
{
	self endon("kill_long_death");
	self endon("death");
	self endon("end_dying_crawl_back_aim");
	if(isdefined(self.var_5F72))
	{
		return;
	}

	self.var_5F72 = 1;
	self method_82AC(scripts\anim\utility::func_B027("crawl_death","aim_4"),1,0);
	self method_82AC(scripts\anim\utility::func_B027("crawl_death","aim_6"),1,0);
	var_00 = 0;
	for(;;)
	{
		var_01 = scripts\anim\utility_common::func_824A();
		var_02 = angleclamp180(var_01 - var_00);
		if(abs(var_02) > 3)
		{
			var_02 = scripts\common\utility::func_101EA(var_02) * 3;
		}

		var_01 = angleclamp180(var_00 + var_02);
		if(var_01 < 0)
		{
			if(var_01 < -45)
			{
				var_01 = -45;
			}

			var_03 = var_01 / -45;
			self method_82A2(%dying_back_aim_4_wrapper,var_03,0.05);
			self method_82A2(%dying_back_aim_6_wrapper,0,0.05);
		}
		else
		{
			if(var_01 > 45)
			{
				var_01 = 45;
			}

			var_03 = var_01 / 45;
			self method_82A2(%dying_back_aim_6_wrapper,var_03,0.05);
			self method_82A2(%dying_back_aim_4_wrapper,0,0.05);
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 33
func_10D8E()
{
	self endon("kill_long_death");
	self endon("death");
	wait(0.5);
	thread func_5F73();
}

//Function Number: 34
func_8977(param_00)
{
	if(param_00 == "fire_spray")
	{
		if(!scripts\anim\utility_common::func_3907())
		{
			return 1;
		}

		if(!func_1A3C())
		{
			return 1;
		}

		scripts\anim\utility_common::func_FE9A();
		return 1;
	}
	else if(param_00 == "pistol_pickup")
	{
		thread func_10D8E();
		return 0;
	}

	return 0;
}

//Function Number: 35
func_1A3C()
{
	var_00 = self.var_10C method_815B();
	var_01 = self method_8141();
	var_02 = vectortoangles(var_00 - self method_8142());
	var_03 = scripts\common\utility::func_152F(var_01[1] - var_02[1]);
	if(var_03 > level.var_C88B)
	{
		if(distancesquared(self geteye(),var_00) > level.var_C889 || var_03 > level.var_C88A)
		{
			return 0;
		}
	}

	return scripts\common\utility::func_152F(var_01[0] - var_02[0]) <= level.var_C87D;
}

//Function Number: 36
func_6562(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	var_01 = vectornormalize(self.var_10C method_815B() - self geteye());
	return vectordot(var_01,param_00) > 0.5;
}

//Function Number: 37
func_D899(param_00)
{
	self endon("kill_long_death");
	self endon("death");
	self.var_6EC4 = 1;
	self.var_AFE7 = 1;
	self.var_1491.var_58DA = 1;
	self notify("long_death");
	self.health = 10000;
	self.var_33F = self.var_33F - 2000;
	wait(0.75);
	if(self.health > 1)
	{
		self.health = 1;
	}

	wait(0.05);
	self.var_AFE7 = undefined;
	self.var_1491.var_B4E7 = 1;
	if(param_00 == "crawling")
	{
		wait(1);
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 1048576)
		{
			anim.var_C222 = randomintrange(10,30);
			anim.var_BF77 = gettime() + randomintrange(15000,-5536);
		}
		else
		{
			anim.var_C222 = randomintrange(5,12);
			anim.var_BF77 = gettime() + randomintrange(5000,25000);
		}

		anim.var_BF78 = gettime() + randomintrange(7000,13000);
		return;
	}

	if(param_00 == "corner_grenade")
	{
		wait(1);
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 490000)
		{
			anim.var_C221 = randomintrange(10,30);
			anim.var_BF76 = gettime() + randomintrange(15000,-5536);
			return;
		}

		anim.var_C221 = randomintrange(5,12);
		anim.var_BF76 = gettime() + randomintrange(5000,25000);
		return;
	}
}

//Function Number: 38
func_4F64()
{
	if(isdefined(self.var_1491.var_7280))
	{
		self.var_1491.var_C21F = self.var_1491.var_7280;
		return;
	}

	self.var_1491.var_C21F = randomintrange(1,5);
}

//Function Number: 39
func_10031()
{
	if(!self.var_1491.var_C21F)
	{
		self.var_1491.var_C21F = undefined;
		return 0;
	}

	self.var_1491.var_C21F--;
	return 1;
}

//Function Number: 40
func_12893()
{
	if(level.var_C221 > 0)
	{
		return 0;
	}

	if(gettime() < level.var_BF76)
	{
		return 0;
	}

	if(self.var_1491.var_55FC || self.var_EF || self.var_E0)
	{
		return 0;
	}

	if(isdefined(self.var_4E46))
	{
		return 0;
	}

	if(distance(self.origin,level.player.origin) < 175)
	{
		return 0;
	}

	anim.var_BF76 = gettime() + 3000;
	thread func_4669();
	self waittill("killanimscript");
	return 1;
}

//Function Number: 41
func_4669()
{
	self endon("kill_long_death");
	self endon("death");
	thread func_C874();
	thread func_D899("corner_grenade");
	thread scripts\sp\_utility::func_F2DA(0);
	self.var_33F = -1000;
	func_C86D("corner_grenade_pain",scripts\anim\utility::func_B027("corner_grenade_death","pain"),%body,1,0.1);
	self waittillmatch("dropgun","corner_grenade_pain");
	scripts\anim\shared::func_5D1A();
	self waittillmatch("anim_pose = \"back\","corner_grenade_pain");
	scripts\anim\notetracks::func_C10B();
	self waittillmatch("grenade_left","corner_grenade_pain");
	var_00 = function_00EA("fraggrenade");
	self attach(var_00,"tag_inhand");
	self.var_4E46 = ::func_D850;
	self waittillmatch("end","corner_grenade_pain");
	var_01 = gettime() + randomintrange(25000,-5536);
	func_C86D("corner_grenade_idle",scripts\anim\utility::func_B027("corner_grenade_death","pain"),%body,1,0.2);
	thread func_13A17();
	while(!func_6560())
	{
		if(gettime() >= var_01)
		{
			break;
		}

		scripts\anim\notetracks::func_5931(0.1,"corner_grenade_idle");
	}

	var_02 = scripts\anim\utility::func_B027("corner_grenade_death","release");
	func_C86D("corner_grenade_release",var_02,%body,1,0.2);
	var_03 = getnotetracktimes(var_02,"grenade_drop");
	var_04 = var_03[0] * getanimlength(var_02);
	wait(var_04 - 1);
	scripts\anim\death::func_CF16();
	wait(0.7);
	self.var_4E46 = ::func_13833;
	var_05 = (0,0,30) - anglestoright(self.angles) * 70;
	func_4663(var_05,randomfloatrange(2,3));
	wait(0.05);
	self detach(var_00,"tag_inhand");
	thread func_A678();
}

//Function Number: 42
func_4663(param_00,param_01)
{
	var_02 = self gettagorigin("tag_inhand");
	var_03 = var_02 + (0,0,20);
	var_04 = var_02 - (0,0,20);
	var_05 = bullettrace(var_03,var_04,0,undefined);
	if(var_05["fraction"] < 0.5)
	{
		var_02 = var_05["position"];
	}

	var_06 = "default";
	if(var_05["surfacetype"] != "none")
	{
		var_06 = var_05["surfacetype"];
	}

	thread func_D527("grenade_bounce",var_02);
	self.var_166 = "fraggrenade";
	self method_81EE(var_02,param_00,param_01);
}

//Function Number: 43
func_D527(param_00,param_01)
{
	var_02 = spawn("script_origin",param_01);
	var_02 playsound(param_00,"sounddone");
	var_02 waittill("sounddone");
	var_02 delete();
}

//Function Number: 44
func_A678()
{
	self.var_1491.var_C043 = 1;
	func_A6CE();
	self method_839A();
	wait(0.1);
	self notify("grenade_drop_done");
}

//Function Number: 45
func_A6CE()
{
	if(isdefined(self.var_A8AA))
	{
		self method_81D0(self.origin,self.var_A8AA);
		return;
	}

	self method_81D0();
}

//Function Number: 46
func_6560()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_10C.origin) > 147456)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_10C.origin) < 16384)
	{
		return 1;
	}

	var_00 = self.var_10C.origin + self.var_6579 * 3;
	var_01 = self.var_10C.origin;
	if(self.var_10C.origin != var_00)
	{
		var_01 = pointonsegmentnearesttopoint(self.var_10C.origin,var_00,self.origin);
	}

	if(distancesquared(self.origin,var_01) < 16384)
	{
		return 1;
	}

	return 0;
}

//Function Number: 47
func_D850()
{
	var_00 = scripts\anim\utility::func_B027("corner_grenade_death","premature_death");
	var_01 = var_00[randomint(var_00.size)];
	scripts\anim\death::func_CF16();
	func_C86D("corner_grenade_die",var_01,%body,1,0.2);
	var_02 = scripts\anim\combat_utility::func_7EE3();
	func_4663(var_02,3);
	var_03 = function_00EA("fraggrenade");
	self detach(var_03,"tag_inhand");
	wait(0.05);
	self method_839A();
	self waittillmatch("end","corner_grenade_die");
}

//Function Number: 48
func_13833()
{
	self waittill("grenade_drop_done");
}

//Function Number: 49
func_13A17()
{
	self endon("kill_long_death");
	self endon("death");
	self.var_6579 = (0,0,0);
	var_00 = undefined;
	var_01 = self.origin;
	var_02 = 0.15;
	for(;;)
	{
		if(isdefined(self.var_10C) && isdefined(var_00) && self.var_10C == var_00)
		{
			var_03 = self.var_10C.origin;
			self.var_6579 = var_03 - var_01 * 1 / var_02;
			var_01 = var_03;
		}
		else
		{
			if(isdefined(self.var_10C))
			{
				var_01 = self.var_10C.origin;
			}
			else
			{
				var_01 = self.origin;
			}

			var_00 = self.var_10C;
			self.var_FE9F = (0,0,0);
		}

		wait(var_02);
	}
}

//Function Number: 50
func_17DD(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_58D6))
	{
		return;
	}

	if(param_00 < self.var_1DB)
	{
		return;
	}

	self.var_58D6 = 1;
	var_07 = undefined;
	if(scripts\common\utility::func_4D59("left_arm_lower","left_arm_upper","left_hand"))
	{
		var_07 = scripts\anim\utility::func_B027("additive_pain","left_arm");
	}

	if(scripts\common\utility::func_4D59("right_arm_lower","right_arm_upper","right_hand"))
	{
		var_07 = scripts\anim\utility::func_B027("additive_pain","right_arm");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_07 = scripts\anim\utility::func_B027("additive_pain","left_leg");
	}
	else if(scripts\common\utility::func_4D59("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_07 = scripts\anim\utility::func_B027("additive_pain","right_leg");
	}
	else
	{
		var_08 = scripts\anim\utility::func_B027("additive_pain","default");
		var_07 = var_08[randomint(var_08.size)];
	}

	self method_82AC(%add_pain,1,0.1,1);
	self method_82AC(var_07,1,0,1);
	wait(0.4);
	self method_806F(var_07,0.2);
	self method_806F(%add_pain,0.2);
	self.var_58D6 = undefined;
}

//Function Number: 51
func_C86C(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.2;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	self method_82E2(param_00,param_01,param_02,param_03,param_04);
	self.var_6A88 = scripts\anim\face::func_D475(param_01,"pain",self.var_6A88);
}

//Function Number: 52
func_C86E(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.2;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	self method_82E7(param_00,param_01,param_02,param_03,param_04);
	self.var_6A88 = scripts\anim\face::func_D475(param_01,"pain",self.var_6A88);
}

//Function Number: 53
func_C86D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.2;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	self method_82E4(param_00,param_01,param_02,param_03,param_04,param_05);
	self.var_6A88 = scripts\anim\face::func_D475(param_01,"pain",self.var_6A88);
}