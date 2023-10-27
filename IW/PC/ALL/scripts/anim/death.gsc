/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\death.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 1865 ms
 * Timestamp: 10/27/2023 12:00:32 AM
*******************************************************************/

//Function Number: 1
func_9510()
{
}

//Function Number: 2
func_95A2()
{
	scripts\common\utility::add_fx("deathfx_bloodpool_generic","vfx/core/impacts/deathfx_bloodpool_generic.vfx");
}

//Function Number: 3
main()
{
	self endon("killanimscript");
	if(getdvarint("ai_iw7",0) != 0)
	{
		self waittill("hellfreezesover");
	}

	self method_83AC("voice_bchatter_1_3d");
	var_00 = 0.3;
	self method_806F(%scripted_talking,var_00);
	lib_0B06::func_55C7(0);
	if(self.var_1491.var_C043 == 1)
	{
		return;
	}

	if(isdefined(self.var_4E46))
	{
		var_01 = self [[ self.var_4E46 ]]();
		if(!isdefined(var_01))
		{
			var_01 = 1;
		}

		if(var_01)
		{
			return;
		}
	}

	scripts\anim\utility::func_9832("death");
	func_E166(self.origin);
	level.var_C222--;
	level.var_C221--;
	if(isdefined(self.var_DC1A) || self.var_13F)
	{
		func_58CB();
	}

	if(isdefined(self.var_4E2A))
	{
		func_CF0E(self.var_4E2A);
		if(isdefined(self.var_4E2E))
		{
			self [[ self.var_4E2E ]]();
		}

		return;
	}

	var_02 = scripts\anim\pain::func_1390C();
	if(self.var_DD == "helmet" || self.var_DD == "head")
	{
		func_8E17();
	}
	else if(var_02 && randomint(3) == 0)
	{
		func_8E17();
	}

	self method_806F(%root,0.3);
	if(!scripts\common\utility::func_4D59("head","helmet"))
	{
		if(self.var_EF)
		{
		}
		else
		{
			func_CF16();
		}
	}

	if(var_02 && func_D469())
	{
		return;
	}

	if(isdefined(self.var_10957))
	{
		if([[ self.var_10957 ]]())
		{
			return;
		}
	}

	if(func_10956())
	{
		return;
	}

	var_03 = func_7E5F();
	func_CF0E(var_03);
}

//Function Number: 4
func_58CB()
{
	scripts\anim\shared::func_5D1A();
	self.var_10265 = 1;
	var_00 = 10;
	var_01 = scripts\common\utility::func_7E5E(self.var_DE);
	if(isdefined(self.var_4F) && self.var_4F == level.player && var_01 == "melee")
	{
		var_00 = 5;
	}

	var_02 = self.var_E1;
	if(var_01 == "bullet")
	{
		var_02 = max(var_02,300);
	}

	var_03 = var_00 * var_02;
	var_04 = max(0.3,self.var_DC[2]);
	var_05 = (self.var_DC[0],self.var_DC[1],var_04);
	if(isdefined(self.var_DC15))
	{
		var_05 = var_05 * self.var_DC15;
	}
	else
	{
		var_05 = var_05 * var_03;
	}

	if(self.var_13F)
	{
		var_05 = var_05 + self.var_249 * 20 * 10;
	}

	if(isdefined(self.var_DC1D))
	{
		var_05 = var_05 + self.var_DC1D * 10;
	}

	self method_839B(self.var_DD,var_05);
	wait(0.05);
}

//Function Number: 5
func_4A7E(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

//Function Number: 6
func_B60C(param_00,param_01)
{
	var_02 = vectordot(param_01,param_00);
	var_03 = cos(60);
	if(squared(var_02) < squared(var_03))
	{
		if(func_4A7E(param_00,param_01) > 0)
		{
			return 1;
		}

		return 3;
	}

	if(var_02 < 0)
	{
		return 0;
	}

	return 2;
}

//Function Number: 7
func_C703()
{
	if(self.var_DE == "MOD_MELEE" && isdefined(self.var_4F))
	{
		var_00 = self.origin - self.var_4F.origin;
		var_01 = anglestoforward(self.angles);
		var_02 = vectornormalize((var_00[0],var_00[1],0));
		var_03 = vectornormalize((var_01[0],var_01[1],0));
		var_04 = func_B60C(var_03,var_02);
		var_05 = var_04 * 90;
		var_06 = (-1 * var_02[0],-1 * var_02[1],0);
		var_07 = rotatevector(var_06,(0,var_05,0));
		var_08 = vectortoyaw(var_07);
		self method_8221("face angle",var_08);
	}
}

//Function Number: 8
func_CF0E(param_00)
{
	if(!animhasnotetrack(param_00,"dropgun") && !animhasnotetrack(param_00,"fire_spray"))
	{
		scripts\anim\shared::func_5D1A();
	}

	func_C703();
	self method_82E4("deathanim",param_00,%body,1,0.1);
	scripts\anim\face::func_D475(param_00,"death");
	if(isdefined(self.var_10265))
	{
		if(!isdefined(self.var_C089))
		{
			self method_839A();
		}

		wait(0.05);
		self method_8016("gravity");
	}
	else if(isdefined(self.var_DC23))
	{
		thread func_136DF(self.var_DC23);
	}
	else if(!animhasnotetrack(param_00,"start_ragdoll"))
	{
		if(self.var_DE == "MOD_MELEE")
		{
			var_01 = 0.7;
		}
		else
		{
			var_01 = 0.35;
		}

		thread func_136DF(getanimlength(param_00) * var_01);
	}

	if(!isdefined(self.var_10265))
	{
		thread func_CF14();
	}

	scripts\anim\shared::func_592B("deathanim");
	scripts\anim\shared::func_5D1A();
	self notify("endPlayDeathAnim");
}

//Function Number: 9
func_136DF(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		scripts\anim\shared::func_5D1A();
	}

	if(isdefined(self) && !isdefined(self.var_C089))
	{
		self method_839A();
	}
}

//Function Number: 10
func_CF14()
{
	self endon("killanimscript");
	if(self.var_2C0 != "none")
	{
		return;
	}

	wait(2);
	func_CCAA();
}

//Function Number: 11
func_CCAA(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_10264))
	{
		return;
	}

	var_02 = self gettagorigin("j_SpineUpper");
	var_03 = self gettagangles("j_SpineUpper");
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	var_06 = anglestoright(var_03);
	var_02 = var_02 + var_04 * -8.5 + var_05 * 5 + var_06 * 0;
	var_07 = bullettrace(var_02 + (0,0,30),var_02 - (0,0,100),0,undefined);
	if(var_07["normal"][2] > 0.9)
	{
		playfx(level._effect["deathfx_bloodpool_generic"],var_02);
	}
}

//Function Number: 12
func_10956()
{
	if(self.var_1491.var_10930 == "none")
	{
		return 0;
	}

	if(self.var_DE == "MOD_MELEE")
	{
		return 0;
	}

	switch(self.var_1491.var_10930)
	{
		case "cover_right":
			if(self.var_1491.var_D6A5 == "stand")
			{
				var_00 = scripts\anim\utility::func_B027("death","cover_right_stand");
				func_57FC(var_00);
			}
			else
			{
				var_00 = [];
				if(scripts\common\utility::func_4D59("head","neck"))
				{
					var_00 = scripts\anim\utility::func_B027("death","cover_right_crouch_head");
				}
				else
				{
					var_00 = scripts\anim\utility::func_B027("death","cover_right_crouch_default");
				}
	
				func_57FC(var_00);
			}
			return 1;

		case "cover_left":
			if(self.var_1491.var_D6A5 == "stand")
			{
				var_00 = scripts\anim\utility::func_B027("death","cover_left_stand");
				func_57FC(var_00);
			}
			else
			{
				var_00 = scripts\anim\utility::func_B027("death","cover_left_crouch");
				func_57FC(var_00);
			}
			return 1;

		case "cover_stand":
			var_00 = scripts\anim\utility::func_B027("death","cover_stand");
			func_57FC(var_00);
			return 1;

		case "cover_crouch":
			var_00 = [];
			if(scripts\common\utility::func_4D59("head","neck") && self.var_E3 > 135 || self.var_E3 <= -45)
			{
				var_00[var_00.size] = scripts\anim\utility::func_B027("death","cover_crouch_head");
			}
	
			if(self.var_E3 > -45 && self.var_E3 <= 45)
			{
				var_00[var_00.size] = scripts\anim\utility::func_B027("death","cover_crouch_back");
			}
	
			var_00[var_00.size] = scripts\anim\utility::func_B027("death","cover_crouch_default");
			func_57FC(var_00);
			return 1;

		case "saw":
			if(self.var_1491.var_D6A5 == "stand")
			{
				func_57FC(scripts\anim\utility::func_B027("death","saw_stand"));
			}
			else if(self.var_1491.var_D6A5 == "crouch")
			{
				func_57FC(scripts\anim\utility::func_B027("death","saw_crouch"));
			}
			else
			{
				func_57FC(scripts\anim\utility::func_B027("death","saw_prone"));
			}
			return 1;

		case "dying_crawl":
			if(isdefined(self.var_1491.var_C4C8) && self.var_1491.var_D6A5 == "crouch")
			{
				var_00 = scripts\anim\utility::func_B027("death","dying_crawl_crouch");
				func_57FC(var_00);
			}
			else
			{
				var_00 = scripts\anim\utility::func_B027("death","dying_crawl_prone");
				func_57FC(var_00);
			}
			return 1;

		case "stumbling_pain":
			func_CF0E(self.var_1491.var_11188[self.var_1491.var_11188.size - 1]);
			return 1;
	}

	return 0;
}

//Function Number: 13
func_57FC(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	func_CF0E(var_01);
	if(isdefined(self.var_4E2E))
	{
		self [[ self.var_4E2E ]]();
	}
}

//Function Number: 14
func_CF16()
{
	scripts\anim\face::func_EB83("death");
}

//Function Number: 15
func_D8ED(param_00,param_01,param_02)
{
	var_03 = param_02 * 20;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 16
func_8E17()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_8C43))
	{
		return;
	}

	var_00 = function_00BF(self.var_8C43,0);
	var_01 = spawn("script_model",self.origin + (0,0,64));
	var_01 setmodel(self.var_8C43);
	var_01.origin = self gettagorigin(var_00);
	var_01.angles = self gettagangles(var_00);
	var_01 thread func_8E13(self.var_DC);
	var_02 = self.var_8C43;
	self.var_8C43 = undefined;
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self detach(var_02,"");
}

//Function Number: 17
func_8E13(param_00)
{
	var_01 = param_00;
	var_01 = var_01 * randomfloatrange(2000,4000);
	var_02 = var_01[0];
	var_03 = var_01[1];
	var_04 = randomfloatrange(1500,3000);
	var_05 = self.origin + (randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1)) * 5;
	self physicslaunchclient(var_05,(var_02,var_03,var_04));
	wait(60);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(distancesquared(self.origin,level.player.origin) > 262144)
		{
			break;
		}

		wait(30);
	}

	self delete();
}

//Function Number: 18
func_E166(param_00)
{
	for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
	{
		level.var_10AE5[var_01] func_41DC(param_00);
	}
}

//Function Number: 19
func_41DC(param_00)
{
	if(!isdefined(self.var_101E5))
	{
		return;
	}

	if(distance(param_00,self.var_101E5) < 80)
	{
		self.var_101E5 = undefined;
		self.var_101E8 = gettime();
	}
}

//Function Number: 20
func_FFF4()
{
	if(self.var_1491.var_BCC8 != "run")
	{
		return 0;
	}

	if(self method_813E() > 60 || self method_813E() < -60)
	{
		return 0;
	}

	if(self.var_DE == "MOD_MELEE")
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_FFFA(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_1491.var_58DA))
	{
		return 0;
	}

	if(self.var_1491.var_D6A5 == "prone" || isdefined(self.var_1491.var_C4C8))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(param_02 > 500)
	{
		return 1;
	}

	if(param_01 == "MOD_MELEE")
	{
		return 0;
	}

	if(self.var_1491.var_BCC8 == "run" && !func_9D59(param_03,275))
	{
		if(randomint(100) < 65)
		{
			return 0;
		}
	}

	if(scripts\anim\utility_common::func_9F62(param_00) && self.maxhealth < param_02)
	{
		return 1;
	}

	if(scripts\anim\utility_common::func_9F4F(param_00) && func_9D59(param_03,512))
	{
		return 1;
	}

	if(func_9DBE(param_00) && func_9D59(param_03,425))
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
func_9DBE(param_00)
{
	if(param_00 == "deserteagle")
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_9D59(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(distancesquared(self.origin,param_00.origin) > param_01 * param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_7E5F()
{
	if(func_FFFA(self.var_E2,self.var_DE,self.var_E1,self.var_4F))
	{
		var_00 = func_817D();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.var_1491.var_C4C8))
	{
		if(self.var_1491.var_D6A5 == "crouch")
		{
			return func_7DF1();
		}
		else
		{
			scripts\anim\notetracks::func_11082();
		}
	}

	if(self.var_1491.var_D6A5 == "stand")
	{
		if(func_FFF4())
		{
			return func_80FC();
		}

		return func_815D();
	}

	if(self.var_1491.var_D6A5 == "crouch")
	{
		return func_7E45();
	}

	if(self.var_1491.var_D6A5 == "prone")
	{
		return func_809F();
	}
}

//Function Number: 25
func_817D()
{
	var_00 = abs(self.var_E3);
	if(var_00 < 45)
	{
		return;
	}

	if(var_00 > 150)
	{
		if(scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot"))
		{
			var_01 = scripts\anim\utility::func_B027("death","strong_legs");
		}
		else if(self.var_DD == "torso_lower")
		{
			var_01 = scripts\anim\utility::func_B027("death","strong_torso_lower");
		}
		else
		{
			var_01 = scripts\anim\utility::func_B027("death","strong_default");
		}
	}
	else if(self.var_E3 < 0)
	{
		var_01 = scripts\anim\utility::func_B027("death","strong_right");
	}
	else
	{
		var_01 = scripts\anim\utility::func_B027("death","strong_left");
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 26
func_80FC()
{
	if(abs(self.var_E3) < 45)
	{
		var_00 = scripts\anim\utility::func_B027("death","running_forward_f");
		var_01 = func_80C3(var_00);
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_00 = scripts\anim\utility::func_B027("death","running_forward");
	var_01 = func_80C3(var_00);
	if(isdefined(var_01))
	{
		return var_01;
	}

	return func_815D();
}

//Function Number: 27
func_80C3(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	for(var_02 = param_00.size;var_02 > 0;var_02--)
	{
		var_03 = randomint(var_02);
		var_01 = param_00[var_03];
		if(!func_9D42(var_01))
		{
			return var_01;
		}

		param_00[var_03] = param_00[var_02 - 1];
		param_00[var_02 - 1] = undefined;
	}

	return undefined;
}

//Function Number: 28
func_E184(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02]))
		{
			continue;
		}

		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 29
func_9D42(param_00)
{
	var_01 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_01 = getnotetracktimes(param_00,"code_move")[0];
	}

	var_02 = getmovedelta(param_00,0,var_01);
	var_03 = self method_81E7(var_02);
	return !self method_8200(var_03,1,1);
}

//Function Number: 30
func_815F()
{
	var_00 = [];
	if(abs(self.var_E3) < 50)
	{
		var_00 = scripts\anim\utility::func_B027("death","stand_pistol_forward");
	}
	else
	{
		if(abs(self.var_E3) < 110)
		{
			var_00 = scripts\anim\utility::func_B027("death","stand_pistol_front");
		}

		if(self.var_DD == "torso_upper")
		{
			var_00 = scripts\common\utility::array_combine(scripts\anim\utility::func_B027("death","stand_pistol_torso_upper"),var_00);
		}
		else if(scripts\common\utility::func_4D59("torso_lower","left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower"))
		{
			var_00 = scripts\common\utility::array_combine(scripts\anim\utility::func_B027("death","stand_pistol_torso_upper"),var_00);
		}

		if(!scripts\common\utility::func_4D59("head","neck","helmet","left_foot","right_foot","left_hand","right_hand","gun") && randomint(2) == 0)
		{
			var_00 = scripts\common\utility::array_combine(scripts\anim\utility::func_B027("death","stand_pistol_upper_body"),var_00);
		}

		if(var_00.size == 0 || scripts\common\utility::func_4D59("torso_lower","torso_upper","neck","head","helmet","right_arm_upper","left_arm_upper"))
		{
			var_00 = scripts\common\utility::array_combine(scripts\anim\utility::func_B027("death","stand_pistol_default"),var_00);
		}
	}

	return var_00;
}

//Function Number: 31
func_815D()
{
	var_00 = [];
	var_01 = [];
	if(scripts\anim\utility_common::func_9FCA())
	{
		var_00 = func_815F();
	}
	else if(isdefined(self.var_4F) && self method_8381(self.var_4F))
	{
		if(self.var_E3 <= 120 || self.var_E3 > -120)
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_standing_front");
		}
		else if(self.var_E3 <= -60 && self.var_E3 > 60)
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_standing_back");
		}
		else if(self.var_E3 < 0)
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_standing_left");
		}
		else
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_standing_right");
		}
	}
	else
	{
		if(scripts\common\utility::func_4D59("torso_lower","left_leg_upper","left_leg_lower","right_leg_lower","right_leg_lower"))
		{
			var_00 = scripts\anim\utility::func_B027("death","stand_lower_body");
			var_01 = scripts\anim\utility::func_B027("death","stand_lower_body_extended");
		}
		else if(scripts\common\utility::func_4D59("head","helmet"))
		{
			var_00 = scripts\anim\utility::func_B027("death","stand_head");
		}
		else if(scripts\common\utility::func_4D59("neck"))
		{
			var_00 = scripts\anim\utility::func_B027("death","stand_neck");
		}
		else if(scripts\common\utility::func_4D59("torso_upper","left_arm_upper"))
		{
			var_00 = scripts\anim\utility::func_B027("death","stand_left_shoulder");
		}

		if(scripts\common\utility::func_4D59("torso_upper"))
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","stand_torso_upper"));
			var_01 = scripts\common\utility::array_combine(var_01,scripts\anim\utility::func_B027("death","stand_torso_upper_extended"));
		}

		if(self.var_E3 > 135 || self.var_E3 <= -135)
		{
			if(scripts\common\utility::func_4D59("neck","head","helmet"))
			{
				var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","stand_front_torso"));
				var_01 = scripts\common\utility::array_combine(var_01,scripts\anim\utility::func_B027("death","stand_front_torso_extended"));
			}

			if(scripts\common\utility::func_4D59("torso_upper"))
			{
				var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","stand_front_torso"));
				var_01 = scripts\common\utility::array_combine(var_01,scripts\anim\utility::func_B027("death","stand_front_torso_extended"));
			}
		}
		else if(self.var_E3 > -45 && self.var_E3 <= 45)
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","stand_back"));
		}

		var_02 = var_00.size > 0;
		if(!var_02 || randomint(100) < 15)
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","stand_default"));
		}

		if(randomint(100) < 10 && func_6DB2())
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","stand_default_firing"));
			var_00 = func_E184(var_00);
		}
	}

	if(var_00.size == 0)
	{
		var_00[var_00.size] = scripts\anim\utility::func_B027("death","stand_backup_default");
	}

	if(!self.var_1491.var_55FC && self.var_2C0 == "none" && !isdefined(self.var_1491.var_C87B))
	{
		var_03 = randomint(var_00.size + var_01.size);
		if(var_03 < var_00.size)
		{
			return var_00[var_03];
		}
		else
		{
			return var_01[var_03 - var_00.size];
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 32
func_7E45()
{
	var_00 = [];
	if(isdefined(self.var_4F) && self method_8381(self.var_4F))
	{
		if(self.var_E3 <= 120 || self.var_E3 > -120)
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_crouching_front");
		}
		else if(self.var_E3 <= -60 && self.var_E3 > 60)
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_crouching_back");
		}
		else if(self.var_E3 < 0)
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_crouching_left");
		}
		else
		{
			var_00 = scripts\anim\utility::func_B027("death","melee_crouching_right");
		}
	}
	else
	{
		if(scripts\common\utility::func_4D59("head","neck"))
		{
			var_00 = scripts\anim\utility::func_B027("death","crouch_head");
		}

		if(scripts\common\utility::func_4D59("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","crouch_torso"));
		}

		if(var_00.size < 2)
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","crouch_default1"));
		}

		if(var_00.size < 2)
		{
			var_00 = scripts\common\utility::array_combine(var_00,scripts\anim\utility::func_B027("death","crouch_default2"));
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 33
func_809F()
{
}

//Function Number: 34
func_7DF1()
{
}

//Function Number: 35
func_6DB2()
{
	if(!isdefined(self.var_394) || !scripts\anim\utility_common::func_1311A() || !function_0245(self.var_394) || !function_02BE(self.var_394) || self.var_EF)
	{
		return 0;
	}

	if(self.var_1491.var_13CBA["right"] == "none")
	{
		return 0;
	}

	return 1;
}

//Function Number: 36
func_1288D(param_00)
{
	return param_00;
}

//Function Number: 37
func_1288E(param_00)
{
	return param_00;
}

//Function Number: 38
func_D469()
{
	if(isdefined(self.var_A4A3))
	{
		return 0;
	}

	if(self.var_DD != "none")
	{
		return 0;
	}
}