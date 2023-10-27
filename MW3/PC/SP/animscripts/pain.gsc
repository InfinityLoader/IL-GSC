/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\pain.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 900 ms
 * Timestamp: 10/27/2023 2:18:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.var_D0F))
	{
		self waittill("killanimscript");
		return;
	}

	if([[ level.pain_test ]]())
	{
		return;
	}

	if(self.a.disablepain)
	{
		return;
	}

	self notify("kill_long_death");
	if(isdefined(self.a.var_B29))
	{
		self.a.var_D12 = self.a.var_B29;
	}
	else
	{
		self.a.var_D12 = 0;
	}

	self.a.var_B29 = gettime();
	if(self.var_786 != "none")
	{
		self.a.var_D13 = 1;
	}
	else
	{
		self.a.var_D13 = undefined;
	}

	if(self.a.var_D14)
	{
		self.health = 1;
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = self.health / self.maxhealth;
	self notify("anim entered pain");
	self endon("killanimscript");
	animscripts/utility::func_D15("pain");
	self animmode("gravity");
	if(!isdefined(self.var_D16))
	{
		animscripts/face::func_C41("pain");
	}

	if(self.damagelocation == "helmet")
	{
		animscripts/death::func_D17();
	}
	else if(func_0D1F() && randomint(2) == 0)
	{
		animscripts/death::func_D17();
	}

	if(isdefined(self.var_D18))
	{
		self [[ self.var_D18 ]]();
		return;
	}

	if(func_0D3F())
	{
		return;
	}

	if(func_0D38(self.a.var_D19))
	{
		return;
	}

	var_03 = func_0D27();
	func_0D35(var_03);
}

//Function Number: 2
func_0D1A()
{
	level._effect["crawling_death_blood_smear"] = loadfx("impacts/blood_smear_decal");
}

//Function Number: 3
func_067F()
{
	if(isdefined(self.var_D1B))
	{
		self.var_D1C = undefined;
		self.var_D1B = undefined;
		self.allowpain = 1;
		if(!isdefined(self.var_D1D))
		{
			self.ignoreme = 0;
		}

		self.var_D1D = undefined;
	}

	if(isdefined(self.var_D1E))
	{
		self.var_D1E = undefined;
		self.allowpain = 1;
	}
}

//Function Number: 4
func_0D1F()
{
	if(isexplosivedamagemod(self.var_726))
	{
		return 1;
	}

	if(gettime() - level.var_D20 <= 50)
	{
		var_00 = level.var_D21 * level.var_D21 * 1.2 * 1.2;
		if(distancesquared(self.origin,level.var_D22) < var_00)
		{
			var_01 = var_00 * 0.5 * 0.5;
			self.var_D24 = distancesquared(self.origin,level.var_D23) < var_01;
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
func_0D25()
{
	if(self.a.pose == "prone")
	{
		return;
	}

	if(isdefined(self.lastattacker) && isdefined(self.lastattacker.team) && self.lastattacker.team == self.team)
	{
		return;
	}

	if(!isdefined(self.var_D1C) || gettime() - self.a.var_D12 > 1500)
	{
		self.var_D1C = randomintrange(2,3);
	}

	if(isdefined(self.lastattacker) && distancesquared(self.origin,self.lastattacker.origin) < squared(512))
	{
		self.var_D1C = 0;
	}

	if(self.var_D1C > 0)
	{
		self.var_D1C--;
		return;
	}

	self.var_D1B = 1;
	self.allowpain = 0;
	if(self.ignoreme)
	{
		self.var_D1D = 1;
	}
	else
	{
		self.ignoreme = 1;
	}

	if(animscripts/utility::func_C95())
	{
		animscripts/shared::func_C9B(self.primaryweapon,"right");
	}

	if(self.a.pose == "crouch")
	{
		return %exposed_crouch_extendedpaina;
	}

	var_00 = animscripts/utility::array(%stand_exposed_extendedpain_chest,%stand_exposed_extendedpain_head_2_crouch,%stand_exposed_extendedpain_hip_2_crouch);
	return var_00[randomint(var_00.size)];
}

//Function Number: 6
func_0D27()
{
	if(self.damageshield && !isdefined(self.var_D28))
	{
		var_00 = func_0D25();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.a.var_D29))
	{
		if(self.a.pose == "crouch")
		{
			return %back_pain;
		}
		else
		{
			animscripts/notetracks::func_D2A();
		}
	}

	if(self.a.pose == "stand")
	{
		var_01 = isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 4096;
		if(!var_01 && self.a.movement == "run" && abs(self getmotionangle()) < 60)
		{
			return func_0D2C();
		}

		self.a.movement = "stop";
		return func_0D30();
	}

	if(self.a.pose == "crouch")
	{
		self.a.movement = "stop";
		return func_0D33();
	}

	if(self.a.pose == "prone")
	{
		self.a.movement = "stop";
		return func_0D34();
	}
}

//Function Number: 7
func_0D2C()
{
	var_00 = [];
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(self maymovetopoint(self localtoworldcoords((300,0,0))))
	{
		var_02 = 1;
		var_01 = 1;
	}
	else if(self maymovetopoint(self localtoworldcoords((200,0,0))))
	{
		var_01 = 1;
	}

	if(isdefined(self.a.var_D2D))
	{
		var_02 = 0;
		var_01 = 0;
	}

	if(var_02)
	{
		var_00[var_00.size] = %run_pain_leg;
		var_00[var_00.size] = %run_pain_shoulder;
		var_00[var_00.size] = %run_pain_stomach_stumble;
		var_00[var_00.size] = %run_pain_head;
	}

	if(var_01)
	{
		var_00[var_00.size] = %run_pain_fallonknee_02;
		var_00[var_00.size] = %run_pain_stomach;
		var_00[var_00.size] = %run_pain_stumble;
		var_00[var_00.size] = %run_pain_stomach_fast;
		var_00[var_00.size] = %run_pain_leg_fast;
		var_00[var_00.size] = %run_pain_fall;
	}
	else if(self maymovetopoint(self localtoworldcoords((120,0,0))))
	{
		var_00[var_00.size] = %run_pain_fallonknee;
		var_00[var_00.size] = %run_pain_fallonknee_03;
	}

	if(!var_00.size)
	{
		self.a.movement = "stop";
		return func_0D30();
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 8
func_0D2E()
{
	var_00 = [];
	if(animscripts/utility::func_D2F("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
	{
	}

	if(animscripts/utility::func_D2F("torso_lower","left_leg_upper","right_leg_upper"))
	{
	}

	if(animscripts/utility::func_D2F("head","neck"))
	{
	}

	if(animscripts/utility::func_D2F("left_arm_lower","left_arm_upper","torso_upper"))
	{
	}

	if(animscripts/utility::func_D2F("right_arm_lower","right_arm_upper","torso_upper"))
	{
	}

	if(var_7B.size < 2)
	{
	}

	if(var_7B.size < 2)
	{
	}

	return var_7B[randomint(var_7B.size)];
}

//Function Number: 9
func_0D30()
{
	if(animscripts/utility::func_C95())
	{
		return func_0D2E();
	}

	var_00 = [];
	var_01 = [];
	if(animscripts/utility::func_D2F("torso_upper","torso_lower"))
	{
	}

	if(animscripts/utility::func_D2F("torso_upper","head","helmet","neck"))
	{
		var_01[var_01.size] = %exposed_pain_face;
		var_01[var_01.size] = %stand_exposed_extendedpain_neck;
	}

	if(animscripts/utility::func_D2F("right_arm_upper","right_arm_lower"))
	{
		var_01[var_01.size] = %exposed_pain_right_arm;
	}

	if(animscripts/utility::func_D2F("left_arm_lower","left_arm_upper"))
	{
		var_01[var_01.size] = %stand_exposed_extendedpain_shoulderswing;
	}

	if(animscripts/utility::func_D2F("torso_lower","left_leg_upper","right_leg_upper"))
	{
		var_01[var_01.size] = %exposed_pain_groin;
		var_01[var_01.size] = %stand_exposed_extendedpain_hip;
	}

	if(animscripts/utility::func_D2F("left_foot","right_foot","left_leg_lower","right_leg_lower"))
	{
		var_01[var_01.size] = %stand_exposed_extendedpain_thigh;
	}

	if(var_01.size < 2)
	{
		if(!self.a.disablelongdeath)
		{
			var_01[var_01.size] = %exposed_pain_2_crouch;
			var_01[var_01.size] = %stand_extendedpainb;
		}
		else
		{
			var_01[var_01.size] = %exposed_pain_right_arm;
			var_01[var_01.size] = %exposed_pain_face;
			var_01[var_01.size] = %exposed_pain_groin;
		}
	}

	if(var_7B.size < 2)
	{
	}

	if(!self.damageshield && !self.a.disablelongdeath)
	{
		var_02 = randomint(var_01.size + var_7B.size);
		if(var_02 < var_01.size)
		{
			return var_01[var_02];
		}
		else
		{
			return var_7B[var_02 - var_01.size];
		}
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 10
func_0D32(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		var_04 = 1;
		if(animhasnotetrack(var_03,"code_move"))
		{
			var_04 = getnotetracktimes(var_03,"code_move")[0];
		}

		var_05 = getmovedelta(var_03,0,var_04);
		var_06 = self localtoworldcoords(var_05);
		if(self maymovetopoint(var_06,1,1))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 11
func_0D33()
{
	var_00 = [];
	if(!self.damageshield && !self.a.disablelongdeath)
	{
	}

	if(animscripts/utility::func_D2F("left_hand","left_arm_lower","left_arm_upper"))
	{
	}

	if(animscripts/utility::func_D2F("right_hand","right_arm_lower","right_arm_upper"))
	{
	}

	return var_7B[randomint(var_7B.size)];
}

//Function Number: 12
func_0D34()
{
	if(randomint(2) == 0)
	{
		return %prone_reaction_a;
	}

	return %prone_reaction_b;
}

//Function Number: 13
func_0D35(param_00)
{
	var_01 = 1;
	self setflaggedanimknoballrestart("painanim",param_00,%body,1,0.1,var_01);
	if(self.a.pose == "prone")
	{
		self updateprone(%prone_legs_up,%prone_legs_down,1,0.1,1);
	}

	if(animhasnotetrack(param_00,"start_aim"))
	{
		thread func_0D36("painanim");
		self endon("start_aim");
	}

	if(animhasnotetrack(param_00,"code_move"))
	{
		animscripts/shared::donotetracks("painanim");
	}

	animscripts/shared::donotetracks("painanim");
}

//Function Number: 14
func_0D36(param_00)
{
	self endon("killanimscript");
	self waittillmatch("start_aim",param_00);
	self notify("start_aim");
}

//Function Number: 15
func_0D37()
{
	self endon("killanimscript");
	self.var_D1E = 1;
	self.allowpain = 0;
	wait 0.5;
	self.var_D1E = undefined;
	self.allowpain = 1;
}

//Function Number: 16
func_0D38(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	self.a.var_D19 = "none";
	thread func_0D37();
	switch(param_00)
	{
		case "cover_left":
			if(self.a.pose == "stand")
			{
				var_01 = [];
				func_0D3A(var_7B);
				var_01 = 1;
			}
			else if(self.a.pose == "crouch")
			{
				var_01 = [];
				func_0D3A(var_7B);
				var_01 = 1;
			}
			else
			{
				var_02 = 0;
			}
	
			break;
	var_7B[var_01.size]
	%cornercrl_painb
	var_7B[var_7B.size]
	%corner_standl_paine
	var_7B[var_7B.size]
	%corner_standl_paind
	var_7B[var_7B.size]
	%corner_standl_painc
	var_7B[var_01.size]
	%corner_standl_painb
			break;

		case "cover_right":
			if(self.a.pose == "stand")
			{
				var_01 = [];
				func_0D3A(var_7B);
				var_01 = 1;
			}
			else if(self.a.pose == "crouch")
			{
				var_01 = [];
				func_0D3A(var_7B);
				var_01 = 1;
			}
			else
			{
				var_02 = 0;
			}
	
			break;
	var_7B[var_7B.size]
	%cornercrr_alert_painc
	var_7B[var_01.size]
	%cornercrr_alert_paina
	var_7B[2]
	%corner_standr_painc
	var_7B[1]
	%corner_standr_painb
	var_7B[0]
	%corner_standr_pain
			break;

		case "cover_right_stand_A":
			var_02 = 0;
			break;

		case "cover_right_stand_B":
			func_0D3B(%corner_standr_pain_b_2_alert);
			var_02 = 1;
			break;

		case "cover_left_stand_A":
			func_0D3B(%corner_standl_pain_a_2_alert);
			var_02 = 1;
			break;

		case "cover_left_stand_B":
			func_0D3B(%corner_standl_pain_b_2_alert);
			var_02 = 1;
			break;

		case "cover_crouch":
			var_01 = [];
			func_0D3A(var_7B);
			var_01 = 1;
			break;
	var_7B[var_7B.size]
	%covercrouch_pain_left_3
	var_7B[var_7B.size]
	%covercrouch_pain_front
	var_7B[var_01.size]
	%covercrouch_pain_right
			break;

		case "cover_stand":
			var_01 = [];
			func_0D3A(var_7B);
			var_01 = 1;
			break;
	var_7B[var_7B.size]
	%coverstand_pain_leg
	var_7B[var_01.size]
	%coverstand_pain_groin
			break;

		case "cover_stand_aim":
			var_01 = [];
			func_0D3A(var_7B);
			var_01 = 1;
			break;
	var_7B[var_7B.size]
	%coverstand_pain_aim_2_hide_02
	var_7B[var_01.size]
	%coverstand_pain_aim_2_hide_01
			break;

		case "cover_crouch_aim":
			func_0D3B(%covercrouch_pain_aim_2_hide_01);
			var_02 = 1;
			break;

		case "saw":
			if(self.a.pose == "stand")
			{
				var_03 = %saw_gunner_pain;
			}
			else if(self.a.pose == "crouch")
			{
				var_03 = %saw_gunner_lowwall_pain_02;
			}
			else
			{
				var_03 = %saw_gunner_prone_pain;
			}
	
			self setflaggedanimknob("painanim",var_03,1,0.3,1);
			animscripts/shared::donotetracks("painanim");
			var_01 = 1;
			break;

		case "mg42":
			func_0D3C(self.a.pose);
			var_02 = 1;
			break;

		case "minigun":
			var_02 = 0;
			break;

		case "corner_right_martyrdom":
			var_02 = func_0D70();
			break;

		case "rambo":
		case "rambo_right":
		case "rambo_left":
		case "dying_crawl":
			var_02 = 0;
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_01;
}

//Function Number: 17
func_0D39()
{
	self endon("death");
	wait 0.05;
	self notify("pain_death");
}

//Function Number: 18
func_0D3A(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	self setflaggedanimknob("painanim",var_01,1,0.3,1);
	animscripts/shared::donotetracks("painanim");
}

//Function Number: 19
func_0D3B(param_00)
{
	self setflaggedanimknob("painanim",param_00,1,0.3,1);
	animscripts/shared::donotetracks("painanim");
}

//Function Number: 20
func_0D3C(param_00)
{
	self setflaggedanimknob("painanim",level.mg_animmg["pain_" + param_00],1,0.1,1);
	animscripts/shared::donotetracks("painanim");
}

//Function Number: 21
func_0D3E(param_00,param_01)
{
	self endon("killanimscript");
	self endon("death");
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	wait param_00;
	self.a.movement = "stop";
}

//Function Number: 22
func_0D3F()
{
	if(self.a.disablelongdeath || self.diequietly || self.damageshield)
	{
		return 0;
	}

	if(self.var_786 != "none")
	{
		return 0;
	}

	if(isdefined(self.a.var_D29))
	{
		return 0;
	}

	var_00["prone"] = animscripts/utility::array(%dying_crawl_2_back);
	self.a.var_D40 = var_7B[self.a.pose][randomint(var_7B[self.a.pose].size)];
	if(isdefined(self.forcelongdeath))
	{
		self.health = 10;
		thread func_0D4A();
		self waittill(animscripts/utility::array(%dying_stand_2_back_v1,%dying_stand_2_back_v2),var_7B["stand"],animscripts/utility::array(%dying_crouch_2_back),var_7B["crouch"],"killanimscript");
		return 1;
	}

	if(!func_0D46(self.a.var_D40))
	{
		return 0;
	}

	if(self.health > 100)
	{
		return 0;
	}

	var_01 = animscripts/utility::func_D2F("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot");
	if(var_01 && self.health < self.maxhealth * 0.4)
	{
		if(gettime() < level.var_D42)
		{
			return 0;
		}
	}
	else
	{
		if(level.var_D43 > 0)
		{
			return 0;
		}

		if(gettime() < level.var_D44)
		{
			return 0;
		}
	}

	if(isdefined(self.deathfunction))
	{
		return 0;
	}

	foreach(var_03 in level.players)
	{
		if(distance(self.origin,var_03.origin) < 175)
		{
			return 0;
		}
	}

	if(animscripts/utility::func_D2F("head","helmet","gun","right_hand","left_hand"))
	{
		return 0;
	}

	if(animscripts/utility::func_C95())
	{
		return 0;
	}

	anim.var_D44 = gettime() + 3000;
	anim.var_D42 = gettime() + 3000;
	thread func_0D4A();
	self waittill("killanimscript");
	return 1;
}

//Function Number: 23
func_0D46(param_00)
{
	if(isdefined(self.a.force_num_crawls))
	{
		return 1;
	}

	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self maymovetopoint(var_02);
}

//Function Number: 24
func_0D48()
{
	self.a.array = [];
	self.a.array["stand_2_crawl"] = animscripts/utility::array(%dying_stand_2_crawl_v1,%dying_stand_2_crawl_v2,%dying_stand_2_crawl_v3);
	self.a.array["crouch_2_crawl"] = animscripts/utility::array(%dying_crouch_2_crawl);
	self.a.array["crawl"] = %dying_crawl;
	self.a.array["death"] = animscripts/utility::array(%dying_crawl_death_v1,%dying_crawl_death_v2);
	self.a.array["back_idle"] = %dying_back_idle;
	self.a.array["back_idle_twitch"] = animscripts/utility::array(%dying_back_twitch_a,%dying_back_twitch_b);
	self.a.array["back_crawl"] = %dying_crawl_back;
	self.a.array["back_fire"] = %dying_back_fire;
	self.a.array["back_death"] = animscripts/utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3);
	if(isdefined(self.crawlingpainanimoverridefunc))
	{
		[[ self.crawlingpainanimoverridefunc ]]();
	}
}

//Function Number: 25
func_0D4A()
{
	self endon("kill_long_death");
	self endon("death");
	func_0D48();
	thread func_0D67("crawling");
	self.a.var_D19 = "none";
	self.var_D4B = undefined;
	thread func_0D39();
	level notify("ai_crawling",self);
	thread func_0D51();
	self setanimknoball(%dying,%body,1,0.1,1);
	if(!func_0D53())
	{
		return;
	}

	self setflaggedanimknob("transition",self.a.var_D40,1,0.5,1);
	animscripts/notetracks::func_D4C("transition",::func_0D5E);
	self.a.var_D19 = "dying_crawl";
	thread func_0D5A();
	if(isdefined(self.enemy))
	{
		self setlookatentity(self.enemy);
	}

	func_0D6D();
	while(func_0D6F())
	{
		var_00 = animscripts/utility::func_D4D("back_crawl");
		if(!func_0D46(var_00))
		{
			break;
		}

		self setflaggedanimknobrestart("back_crawl",var_00,1,0.1,1);
		animscripts/notetracks::func_D4C("back_crawl",::func_0D5E);
	}

	self.var_D4E = gettime() + randomintrange(4000,20000);
	while(func_0D52())
	{
		if(animscripts/utility::func_CE3() && func_0D60())
		{
			var_01 = animscripts/utility::func_D4D("back_fire");
			self setflaggedanimknobrestart("back_idle_or_fire",var_01,1,0.2,1);
			animscripts/shared::donotetracks("back_idle_or_fire");
			continue;
		}

		var_01 = animscripts/utility::func_D4D("back_idle");
		if(randomfloat(1) < 0.4)
		{
			var_01 = animscripts/utility::func_CA8("back_idle_twitch");
		}

		self setflaggedanimknobrestart("back_idle_or_fire",var_01,1,0.1,1);
		var_02 = getanimlength(var_01);
		while(var_02 > 0)
		{
			if(animscripts/utility::func_CE3() && func_0D60())
			{
				break;
			}

			var_03 = 0.5;
			if(var_03 > var_02)
			{
				var_03 = var_02;
				var_02 = 0;
				continue;
			}

			var_02 = var_02 - var_03;
			animscripts/notetracks::func_D4F(var_03,"back_idle_or_fire");
		}
	}

	self notify("end_dying_crawl_back_aim");
	self clearanim(%dying_back_aim_4_wrapper,0.3);
	self clearanim(%dying_back_aim_6_wrapper,0.3);
	self.deathanim = animscripts/utility::func_CA8("back_death");
	func_0D79();
	self.a.var_D19 = "none";
	self.var_D4B = undefined;
}

//Function Number: 26
func_0D51()
{
	if(self.team == "allies")
	{
		return;
	}

	self endon("end_dying_crawl_back_aim");
	self waittill("death",var_00,var_01);
	if(!isdefined(self) || !isdefined(var_00) || !isplayer(var_00))
	{
	}
}

//Function Number: 27
func_0D52()
{
	if(!func_0D66(anglestoforward(self.angles)))
	{
		return 0;
	}

	return gettime() < self.var_D4E;
}

//Function Number: 28
func_0D53()
{
	if(!isdefined(self.forcelongdeath))
	{
		if(self.a.pose == "prone")
		{
			return 1;
		}

		if(self.a.movement == "stop")
		{
			if(randomfloat(1) < 0.4)
			{
				if(randomfloat(1) < 0.5)
				{
					return 1;
				}
			}
			else if(abs(self.var_723) > 90)
			{
				return 1;
			}
		}
		else if(abs(self getmotionangle()) > 90)
		{
			return 1;
		}
	}

	if(self.a.pose != "prone")
	{
		var_00 = animscripts/utility::func_CA8(self.a.pose + "_2_crawl");
		if(!func_0D46(var_00))
		{
			return 1;
		}

		thread func_0D57();
		self setflaggedanimknob("falling",var_00,1,0.5,1);
		animscripts/shared::donotetracks("falling");
	}
	else
	{
		thread func_0D57();
	}

	self.a.var_D40 = %dying_crawl_2_back;
	self.a.var_D19 = "dying_crawl";
	func_0D6D();
	while(func_0D6F())
	{
		var_01 = animscripts/utility::func_D4D("crawl");
		if(!func_0D46(var_01))
		{
			return 1;
		}

		if(isdefined(self.var_D54))
		{
			self playsound(self.var_D54);
		}

		self setflaggedanimknobrestart("crawling",var_01,1,0.1,1);
		animscripts/shared::donotetracks("crawling");
	}

	self notify("done_crawling");
	if(!isdefined(self.forcelongdeath) && func_0D66(anglestoforward(self.angles) * -1))
	{
		return 1;
	}

	var_02 = animscripts/utility::func_CA8("death");
	if(var_02 != %dying_crawl_death_v2)
	{
		self.a.var_D55 = 1;
	}

	animscripts/death::func_D56(var_02);
	func_0D79();
	self.a.var_D19 = "none";
	self.var_D4B = undefined;
	return 0;
}

//Function Number: 29
func_0D57()
{
	self endon("death");
	if(self.a.pose != "prone")
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
	if(isdefined(self.a.crawl_fx_rate))
	{
		var_03 = self.a.crawl_fx_rate;
	}

	if(isdefined(self.a.crawl_fx))
	{
		var_04 = level._effect[self.a.crawl_fx];
	}

	while(var_03)
	{
		var_05 = self gettagorigin(var_01);
		var_06 = self gettagangles(var_02);
		var_07 = anglestoright(var_06);
		var_08 = anglestoforward((270,0,0));
		playfx(var_04,var_05,var_08,var_07);
		wait var_03;
	}
}

//Function Number: 30
func_0D5A()
{
	self endon("kill_long_death");
	self endon("death");
	self endon("end_dying_crawl_back_aim");
	if(isdefined(self.var_D5B))
	{
		return;
	}

	self.var_D5B = 1;
	self setanimlimited(%dying_back_aim_4,1,0);
	self setanimlimited(%dying_back_aim_6,1,0);
	var_00 = 0;
	for(;;)
	{
		var_01 = animscripts/utility::func_D5C();
		var_02 = angleclamp180(var_01 - var_00);
		if(abs(var_02) > 3)
		{
			var_02 = common_scripts\utility::sign(var_02) * 3;
		}

		var_01 = angleclamp180(var_00 + var_02);
		if(var_01 < 0)
		{
			if(var_01 < -45)
			{
				var_01 = -45;
			}

			var_03 = var_01 / -45;
			self setanim(%dying_back_aim_4_wrapper,var_03,0.05);
			self setanim(%dying_back_aim_6_wrapper,0,0.05);
		}
		else
		{
			if(var_01 > 45)
			{
				var_01 = 45;
			}

			var_03 = var_01 / 45;
			self setanim(%dying_back_aim_6_wrapper,var_03,0.05);
			self setanim(%dying_back_aim_4_wrapper,0,0.05);
		}

		var_00 = var_01;
		wait 0.05;
	}
}

//Function Number: 31
func_0D5D()
{
	self endon("kill_long_death");
	self endon("death");
	wait 0.5;
	thread func_0D5A();
}

//Function Number: 32
func_0D5E(param_00)
{
	if(param_00 == "fire_spray")
	{
		if(!animscripts/utility::func_CE3())
		{
			return 1;
		}

		if(!func_0D60())
		{
			return 1;
		}

		animscripts/utility::func_D5F();
		return 1;
	}
	else if(param_00 == "pistol_pickup")
	{
		thread func_0D5D();
		return 0;
	}

	return 0;
}

//Function Number: 33
func_0D60()
{
	var_00 = self.enemy getshootatpos();
	var_01 = self getmuzzleangle();
	var_02 = vectortoangles(var_00 - self getmuzzlepos());
	var_03 = animscripts/utility::func_D61(var_01[1] - var_02[1]);
	if(var_03 > level.var_D62)
	{
		if(distancesquared(self geteye(),var_00) > level.var_D63 || var_03 > level.var_D64)
		{
			return 0;
		}
	}

	return animscripts/utility::func_D61(var_01[0] - var_02[0]) <= level.var_D65;
}

//Function Number: 34
func_0D66(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	var_01 = vectornormalize(self.enemy getshootatpos() - self geteye());
	return vectordot(var_01,param_00) > 0.5;
}

//Function Number: 35
func_0D67(param_00)
{
	self endon("kill_long_death");
	self endon("death");
	self.flashbangimmunity = 1;
	self.var_D0F = 1;
	self.a.doinglongdeath = 1;
	self notify("long_death");
	self.health = 10000;
	self.threatbias = self.threatbias - 2000;
	wait 0.75;
	if(self.health > 1)
	{
		self.health = 1;
	}

	wait 0.05;
	self.var_D0F = undefined;
	self.a.var_D6A = 1;
	if(param_00 == "crawling")
	{
		wait 1;
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 1048576)
		{
			anim.var_D43 = randomintrange(10,30);
			anim.var_D44 = gettime() + randomintrange(15000,-5536);
		}
		else
		{
			anim.var_D43 = randomintrange(5,12);
			anim.var_D44 = gettime() + randomintrange(5000,25000);
		}

		anim.var_D42 = gettime() + randomintrange(7000,13000);
		return;
	}

	if(param_00 == "corner_grenade")
	{
		wait 1;
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 490000)
		{
			anim.var_D6B = randomintrange(10,30);
			anim.var_D6C = gettime() + randomintrange(15000,-5536);
			return;
		}

		anim.var_D6B = randomintrange(5,12);
		anim.var_D6C = gettime() + randomintrange(5000,25000);
		return;
	}
}

//Function Number: 36
func_0D6D()
{
	if(isdefined(self.a.force_num_crawls))
	{
		self.a.var_D6E = self.a.force_num_crawls;
		return;
	}

	self.a.var_D6E = randomintrange(1,5);
}

//Function Number: 37
func_0D6F()
{
	if(!self.a.var_D6E)
	{
		self.a.var_D6E = undefined;
		return 0;
	}

	self.a.var_D6E--;
	return 1;
}

//Function Number: 38
func_0D70()
{
	if(level.var_D6B > 0)
	{
		return 0;
	}

	if(gettime() < level.var_D6C)
	{
		return 0;
	}

	if(self.a.disablelongdeath || self.diequietly || self.damageshield)
	{
		return 0;
	}

	if(isdefined(self.deathfunction))
	{
		return 0;
	}

	if(distance(self.origin,level.player.origin) < 175)
	{
		return 0;
	}

	anim.var_D6C = gettime() + 3000;
	thread func_0D71();
	self waittill("killanimscript");
	return 1;
}

//Function Number: 39
func_0D71()
{
	self endon("kill_long_death");
	self endon("death");
	thread func_0D39();
	thread func_0D67("corner_grenade");
	thread maps\_utility::set_battlechatter(0);
	self.threatbias = -1000;
	self setflaggedanimknoballrestart("corner_grenade_pain",%corner_standr_death_grenade_hit,%body,1,0.1);
	self waittillmatch("dropgun","corner_grenade_pain");
	animscripts/shared::func_D73();
	self waittillmatch("anim_pose = \"back\","corner_grenade_pain");
	animscripts/notetracks::func_D74();
	self waittillmatch("grenade_left","corner_grenade_pain");
	var_00 = getweaponmodel("fraggrenade");
	self attach(var_00,"tag_inhand");
	self.deathfunction = ::func_0D7D;
	self waittillmatch("end","corner_grenade_pain");
	var_01 = gettime() + randomintrange(25000,-5536);
	self setflaggedanimknoballrestart("corner_grenade_idle",%corner_standr_death_grenade_idle,%body,1,0.2);
	thread func_0D80();
	while(!func_0D7B())
	{
		if(gettime() >= var_01)
		{
			break;
		}

		animscripts/notetracks::func_D4F(0.1,"corner_grenade_idle");
	}

	var_02 = %corner_standr_death_grenade_slump;
	self setflaggedanimknoballrestart("corner_grenade_release",var_02,%body,1,0.2);
	var_03 = getnotetracktimes(var_02,"grenade_drop");
	var_04 = var_03[0] * getanimlength(var_02);
	wait var_04 - 1;
	animscripts/death::playdeathsound();
	wait 0.7;
	self.deathfunction = ::func_0D7F;
	var_05 = (0,0,30) - anglestoright(self.angles) * 70;
	func_0D76(var_05,randomfloatrange(2,3));
	wait 0.05;
	self detach(var_00,"tag_inhand");
	thread func_0D78();
}

//Function Number: 40
func_0D76(param_00,param_01)
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

	thread func_0D77("grenade_bounce_" + var_06,var_02);
	self.grenadeweapon = "fraggrenade";
	self magicgrenademanual(var_02,param_00,param_01);
}

//Function Number: 41
func_0D77(param_00,param_01)
{
	var_02 = spawn("script_origin",param_01);
	var_02 playsound(param_00,"sounddone");
	var_02 waittill("sounddone");
	var_02 delete();
}

//Function Number: 42
func_0D78()
{
	self.a.var_D55 = 1;
	func_0D79();
	self startragdoll();
	wait 0.1;
	self notify("grenade_drop_done");
}

//Function Number: 43
func_0D79()
{
	if(isdefined(self.last_dmg_player))
	{
		self kill(self.origin,self.last_dmg_player);
		return;
	}

	self kill();
}

//Function Number: 44
func_0D7B()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) > 147456)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) < 16384)
	{
		return 1;
	}

	var_00 = self.enemy.origin + self.var_D7C * 3;
	var_01 = self.enemy.origin;
	if(self.enemy.origin != var_00)
	{
		var_01 = pointonsegmentnearesttopoint(self.enemy.origin,var_00,self.origin);
	}

	if(distancesquared(self.origin,var_01) < 16384)
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
func_0D7D()
{
	var_00 = animscripts/utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
	var_01 = var_00[randomint(var_00.size)];
	animscripts/death::playdeathsound();
	self setflaggedanimknoballrestart("corner_grenade_die",var_01,%body,1,0.2);
	var_02 = animscripts/combat_utility::func_D7E();
	func_0D76(var_02,3);
	var_03 = getweaponmodel("fraggrenade");
	self detach(var_03,"tag_inhand");
	wait 0.05;
	self startragdoll();
	self waittillmatch("end","corner_grenade_die");
}

//Function Number: 46
func_0D7F()
{
	self waittill("grenade_drop_done");
}

//Function Number: 47
func_0D80()
{
	self endon("kill_long_death");
	self endon("death");
	self.var_D7C = (0,0,0);
	var_00 = undefined;
	var_01 = self.origin;
	var_02 = 0.15;
	for(;;)
	{
		if(isdefined(self.enemy) && isdefined(var_00) && self.enemy == var_00)
		{
			var_03 = self.enemy.origin;
			self.var_D7C = var_03 - var_01 * 1 / var_02;
			var_01 = var_03;
		}
		else
		{
			if(isdefined(self.enemy))
			{
				var_01 = self.enemy.origin;
			}
			else
			{
				var_01 = self.origin;
			}

			var_00 = self.enemy;
			self.var_D81 = (0,0,0);
		}

		wait var_02;
	}
}

//Function Number: 48
func_0D82(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_D83))
	{
		return;
	}

	if(param_00 < self.minpaindamage)
	{
		return;
	}

	self.var_D83 = 1;
	var_07 = animscripts/utility::array(%pain_add_standing_belly,%pain_add_standing_left_arm,%pain_add_standing_right_arm);
	var_08 = %pain_add_standing_belly;
	if(animscripts/utility::func_D2F("left_arm_lower","left_arm_upper","left_hand"))
	{
		var_08 = %pain_add_standing_left_arm;
	}

	if(animscripts/utility::func_D2F("right_arm_lower","right_arm_upper","right_hand"))
	{
		var_08 = %pain_add_standing_right_arm;
	}
	else if(animscripts/utility::func_D2F("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_08 = %pain_add_standing_left_leg;
	}
	else if(animscripts/utility::func_D2F("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_08 = %pain_add_standing_right_leg;
	}
	else
	{
		var_08 = var_07[randomint(var_07.size)];
	}

	self setanimlimited(%add_pain,1,0.1,1);
	self setanimlimited(var_08,1,0,1);
	wait 0.4;
	self clearanim(var_08,0.2);
	self clearanim(%add_pain,0.2);
	self.var_D83 = undefined;
}