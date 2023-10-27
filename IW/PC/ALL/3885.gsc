/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3885.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 58 ms
 * Timestamp: 10/27/2023 12:31:07 AM
*******************************************************************/

//Function Number: 1
func_1355D()
{
	precachemodel("vr_unfold_left_rig");
	precachemodel("vr_unfold_right_rig");
	lib_0F30::main();
	lib_0F2E::main();
	if(isdefined(level.var_13567))
	{
		scripts\common\utility::flag_wait(level.var_13567);
	}

	scripts\sp\_utility::func_9189("default_vroutline",-1,"default");
	level.var_74C2["player_grenade_thrown"] = ::func_13566;
	scripts\sp\_utility::func_22C9("vr_enemy_human",::func_D70F);
	lib_0F2F::main();
}

//Function Number: 2
func_661E(param_00)
{
	setomnvar("ui_in_vr",1);
	setomnvar("ui_close_vr_pause_menu",0);
	scripts\common\utility::flag_set("in_vr_mode");
	level.var_93A9 = 1;
	level.var_116D8.var_13558 = 1;
	level thread func_13598();
	level thread func_F61F();
	scripts\sp\_outline::func_91A1("default",::func_1356B);
	level thread func_6DA9(param_00);
}

//Function Number: 3
func_1356B()
{
	var_00["r_hudoutlineWidth"] = 3;
	var_00["cg_hud_outline_colors_5"] = "0.122 0.235 0.425 0.500";
	return var_00;
}

//Function Number: 4
func_6DA9(param_00)
{
	level endon("reset_vr");
	var_01 = undefined;
	var_02 = level.var_13563.var_E546[1].var_F18B[0];
	var_03 = scripts\common\utility::func_22A9(level.var_13563.var_E546[1].var_F18B,var_02);
	level thread func_A5D0();
	if(param_00)
	{
		func_9AD8();
	}
	else
	{
		func_9AD6();
	}

	for(var_04 = 0;var_04 < 3;var_04++)
	{
		func_669D(var_02,var_03,var_04);
		level thread func_2F0A(1);
		level thread func_4D96(level.var_13563.var_BF5A.var_CBFA.origin,1);
		wait(0.75);
		func_106C8(level.var_13563.var_BF5A,var_04);
		func_A62A();
		func_12B92();
		wait(1.75);
		func_6B73(level.var_13563.var_BF5A,0);
		level thread func_2F0A(0);
		var_05 = level.var_13563.var_BF5A.var_CBFA.origin + anglestoright(level.var_13563.var_BF5A.var_CBFA.angles) * -1792;
		level thread func_4D96(var_05,0,1,1);
		var_03 = scripts\common\utility::func_22A9(var_03,level.var_13563.var_BF5A);
		var_02 = level.var_13563.var_BF5A;
	}

	wait(0.5);
	level.player playsound("vr_course_complete");
	func_DFED();
	wait(0.5);
	level.player playsound("shipcrib_hud_complete_simulation");
	wait(2);
	scripts\sp\_utility::func_56BA("vr_tut_leave");
	level thread scripts\common\utility::func_6E3F("vr_tutorial_leave_shown",5);
}

//Function Number: 5
func_9AD8()
{
	level endon("reset_vr");
	scripts\common\utility::flag_set("vr_delete_thrown_grenades");
	var_00 = level.var_13563.var_E546;
	var_01 = level.var_13563.var_E546[1].var_F18B[0];
	level.var_13563.var_9B3D hide();
	foreach(var_03 in var_00)
	{
		var_04 = anglestoforward(var_03.angles) * 9408;
		var_05 = anglestoright(var_03.angles) * 608;
		var_03.origin = var_03.var_10CE2 + var_04 + var_05;
		var_03 thread func_E53E("passive",1,undefined,1);
		level notify("vr_ring" + var_03.var_EDD5 + "_intro_show_geo");
		foreach(var_07 in var_03.var_466A)
		{
			var_07 show();
		}

		foreach(var_0A in var_03.var_F18B)
		{
			if(isdefined(var_0A.var_6E86))
			{
				var_0A.var_6E86 show();
			}

			var_0A show();
		}

		if(var_03 == level.var_13563.var_E546[1])
		{
			continue;
		}

		var_03 rotateroll(90,0.05);
	}

	scripts\common\utility::func_136F7();
	foreach(var_0A in level.var_13563.var_E546[0].var_F18B)
	{
		var_0A.var_6E86 unlink();
		var_0A.var_6E86 rotateroll(-90,0.05);
	}

	wait(1);
	level.player playsound("scn_vr_rotate_90");
	level.var_13563.var_E546[1] func_E53E("active");
	var_0F = 1.5;
	var_10 = 0.35;
	level.var_13563.var_E546[1] rotateroll(90,var_0F,var_10,var_10);
	wait(var_0F + 0.1);
	level.var_13563.var_E546[1] func_E53E("passive");
	level.var_13563.var_2F09.origin = var_01.var_CBFA.origin;
	foreach(var_12 in level.var_13563.var_4D95)
	{
		var_12.origin = var_01.var_CBFA.origin + anglestoright(var_01.var_CBFA.angles) * -1792;
	}

	scripts\common\utility::func_6E2A("vr_delete_thrown_grenades");
	wait(0.25);
}

//Function Number: 6
func_9AD6()
{
	level endon("reset_vr");
	scripts\common\utility::flag_set("vr_delete_thrown_grenades");
	var_00 = level.var_13563.var_E546;
	var_01 = level.var_13563.var_E546[1].var_F18B[0];
	wait(1);
	level.player playsound("shipcrib_hud_loading_simulation");
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(var_02 == 0)
		{
			var_00[var_02] playsound("scn_vr_enter");
		}

		var_00[var_02] thread func_E539();
		wait(0.25);
	}

	var_00[var_00.size - 1] waittill("vr_intro_part1");
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = 608;
		var_04 = 1.5;
		var_05 = 0.35;
		if(var_02 == 0)
		{
			var_06 = level.var_13563.var_9B3D;
			var_06 thread func_3108(0,1);
		}

		var_00[var_02] thread func_E542(var_03,var_04,var_05);
		wait(0.125);
	}

	var_00[2] waittill("intro_finished");
	scripts\common\utility::func_6E2A("vr_delete_thrown_grenades");
	var_00[var_00.size - 1] waittill("intro_finished");
	level.var_13563.var_2F09.origin = var_01.var_CBFA.origin;
	foreach(var_08 in level.var_13563.var_4D95)
	{
		var_08.origin = var_01.var_CBFA.origin + anglestoright(var_01.var_CBFA.angles) * -1792;
	}

	wait(0.25);
}

//Function Number: 7
func_E539(param_00)
{
	level endon("reset_vr");
	thread lib_0B06::func_1EC3(self,"vr_intro_part1");
	func_E53E("passive",1,undefined,1);
	foreach(var_02 in self.var_466A)
	{
		var_02 show();
	}

	wait(0.5);
	thread lib_0B06::func_1F35(self,"vr_intro_part1");
	level waittill("vr_ring" + self.var_EDD5 + "_intro_show_geo");
	foreach(var_05 in self.var_F18B)
	{
		if(isdefined(var_05.var_6E86))
		{
			var_05.var_6E86 show();
		}

		var_05 show();
	}
}

//Function Number: 8
func_E542(param_00,param_01,param_02)
{
	level endon("reset_vr");
	func_E53E("active");
	self rotateroll(90,param_01,param_02,param_02);
	self moveto(self.origin + anglestoright(self.angles) * param_00,param_01,param_02,param_02);
	wait(param_01 + 0.05);
	func_E53E("passive");
	if(self == level.var_13563.var_E546[0])
	{
		self.var_F18B[0].var_6E86 playsound("scn_vr_enter_cap");
		foreach(var_04 in self.var_F18B)
		{
			var_04.var_6E86 unlink();
			var_04.var_6E86 rotateroll(-90,1,0.25,0.25);
		}
	}

	self notify("intro_finished");
}

//Function Number: 9
func_669D(param_00,param_01,param_02)
{
	level endon("reset_vr");
	if(param_02 == 0)
	{
		level.var_13563.var_BF5A = param_00;
		level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[0];
		level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[1];
		var_03 = undefined;
		var_04 = undefined;
		var_05 = 0;
	}
	else if(var_05 == 1)
	{
		var_04 = undefined;
		var_04 = level.var_13563.var_E546[1].var_F18B;
		level.var_13563.var_BF5A = param_02[randomint(param_02.size)];
		var_05 = 0;
	}
	else
	{
		var_04 = undefined;
		var_04 = level.var_13563.var_E546[1].var_F18B;
		level.var_13563.var_BF5A = param_02[randomint(param_02.size)];
		var_05 = 1;
	}

	if(param_02 == 0)
	{
		func_6B74(level.var_13563.var_BF5A,0);
		level thread func_F188(level.var_13563.var_BF5A,1);
		level.player playsound("shipcrib_hud_activate_simulation");
		return;
	}

	if(param_00 == var_03[0])
	{
		if(level.var_13563.var_BF5A == var_03[1])
		{
			var_04 = "negative_90";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
		}
		else if(level.var_13563.var_BF5A == var_03[2])
		{
			var_04 = "positive_180";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
		}
		else
		{
			var_04 = "positive_90";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
		}
	}
	else if(param_00 == var_03[1])
	{
		if(level.var_13563.var_BF5A == var_03[2])
		{
			var_04 = "negative_90";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
		}
		else if(level.var_13563.var_BF5A == var_03[3])
		{
			var_04 = "positive_180";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
		}
	}
	else if(param_00 == var_03[2])
	{
		if(level.var_13563.var_BF5A == var_03[1])
		{
			var_04 = "positive_90";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
		}
		else if(level.var_13563.var_BF5A == var_03[3])
		{
			var_04 = "negative_90";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[3];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[0];
		}
	}
	else if(param_00 == var_03[3])
	{
		if(level.var_13563.var_BF5A == var_03[1])
		{
			var_04 = "negative_180";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[1];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[2];
		}
		else if(level.var_13563.var_BF5A == var_03[2])
		{
			var_04 = "positive_90";
			level.var_13563.var_BF5B[0] = level.var_13563.var_E546[1].var_466A[2];
			level.var_13563.var_BF5B[1] = level.var_13563.var_E546[1].var_466A[3];
		}
	}

	level.player playsound("shipcrib_hud_cleared_simulation");
	level thread func_A62B(1);
	func_DFED();
	scripts\common\utility::flag_set("vr_delete_thrown_grenades");
	level thread func_A5BD(level.var_13563.var_E546[2]);
	switch(var_04)
	{
		case "positive_90":
		case "negative_90":
			level.player playsound("scn_vr_rotate_90");
			if(var_05)
			{
				level.player scripts\common\utility::delaycall(1.5,::playsound,"scn_vr_unfold_side");
			}
			break;

		case "negative_180":
		case "positive_180":
			level.player playsound("scn_vr_rotate_180");
			if(var_05)
			{
				level.player scripts\common\utility::delaycall(3,::playsound,"scn_vr_unfold_side");
			}
			break;

		default:
			break;
	}

	for(var_06 = 0;var_06 < level.var_13563.var_E546.size;var_06++)
	{
		if(level.var_13563.var_BF5A == var_03[1])
		{
			var_07 = 1;
		}
		else if(level.var_13563.var_BF5A == var_03[2])
		{
			var_07 = 2;
		}
		else
		{
			var_07 = 3;
		}

		if(var_06 == 0)
		{
			level.var_13563.var_E546[var_06] thread func_1266B(var_04,var_05,var_07);
		}
		else
		{
			level.var_13563.var_E546[var_06] thread func_12669(var_04,var_05,var_07);
		}

		wait(0.125);
	}

	level.var_13563.var_E546[1] scripts\sp\_utility::func_65E8("ring_spinning");
	level.var_13563.var_BF5A scripts\sp\_utility::func_65E8("segment_dropping_geo");
	level thread func_F188(level.var_13563.var_BF5A,1);
	wait(0.25);
}

//Function Number: 10
func_12669(param_00,param_01,param_02)
{
	level endon("reset_vr");
	scripts\sp\_utility::func_65E1("ring_spinning");
	func_E53E("active");
	var_03 = 1.5;
	var_04 = 0.35;
	if(param_00 == "positive_90")
	{
		self rotateroll(90,var_03,var_04,var_04);
	}
	else if(param_00 == "negative_90")
	{
		self rotateroll(-90,var_03,var_04,var_04);
	}
	else if(param_00 == "positive_180")
	{
		var_03 = var_03 * 2;
		var_04 = var_04 * 1.5;
		self rotateroll(180,var_03,var_04,var_04);
	}
	else if(param_00 == "negative_180")
	{
		var_03 = var_03 * 2;
		var_04 = var_04 * 1.5;
		self rotateroll(-180,var_03,var_04,var_04);
	}

	wait(var_03 + 0.1);
	self notify("rotation_done");
	if(self == level.var_13563.var_E546[1])
	{
		level thread func_6B74(level.var_13563.var_BF5A,0);
	}

	func_E53E("passive");
	scripts\sp\_utility::func_65DD("ring_spinning");
	if(param_01)
	{
		thread func_12673("left",param_02);
		thread func_12673("right",param_02);
		if(self == level.var_13563.var_E546[1])
		{
			level waittill("corner_dropping_geo");
			func_6B74(level.var_13563.var_BF5A,1);
		}
	}
}

//Function Number: 11
func_1266B(param_00,param_01,param_02)
{
	level endon("reset_vr");
	func_E53E("active");
	var_03 = 1.5;
	var_04 = 0.35;
	if(param_00 == "positive_180")
	{
		var_03 = var_03 * 2;
	}
	else if(param_00 == "negative_180")
	{
		var_03 = var_03 * 2;
	}

	wait(var_03 + 0.1);
	func_E53E("passive");
	if(param_01)
	{
		func_E53E("active");
		var_03 = getanimlength(%vr_unfold_left);
		wait(var_03);
		func_E53E("passive");
	}
}

//Function Number: 12
func_12673(param_00,param_01)
{
	level endon("reset_vr");
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	if(param_00 == "left")
	{
		if(param_01 == 0)
		{
			var_02 = "tag_corner0_bottom";
			var_03 = 3;
			var_04 = 0;
		}
		else if(param_01 == 1)
		{
			var_02 = "tag_corner1_bottom";
			var_03 = 0;
			var_04 = 1;
		}
		else if(param_01 == 2)
		{
			var_02 = "tag_corner2_bottom";
			var_03 = 1;
			var_04 = 2;
		}
		else if(param_01 == 3)
		{
			var_02 = "tag_corner3_bottom";
			var_03 = 2;
			var_04 = 3;
		}
	}
	else if(param_00 == "right")
	{
		if(param_01 == 0)
		{
			var_02 = "tag_corner1_top";
			var_03 = 1;
			var_04 = 1;
		}
		else if(param_01 == 1)
		{
			var_02 = "tag_corner2_top";
			var_03 = 2;
			var_04 = 2;
		}
		else if(param_01 == 2)
		{
			var_02 = "tag_corner3_top";
			var_03 = 3;
			var_04 = 3;
		}
		else if(param_01 == 3)
		{
			var_02 = "tag_corner0_top";
			var_03 = 0;
			var_04 = 0;
		}
	}

	func_12B95(param_00,var_02,param_01,var_03,var_04);
}

//Function Number: 13
func_12B95(param_00,param_01,param_02,param_03,param_04)
{
	level endon("reset_vr");
	var_05 = self gettagorigin(param_01);
	var_06 = vectortoangles(anglestoforward(self.angles));
	var_07 = scripts\sp\_utility::func_10639("vr_unfold_" + param_00 + "_rig",var_05,var_06);
	var_07 hide();
	level.var_13563.var_12B98[level.var_13563.var_12B98.size] = var_07;
	var_08 = self.var_F18B[param_03];
	var_09 = self.var_466A[param_04];
	var_08.var_CBFA unlink();
	var_08.var_CBFA linkto(var_07,"tag_segment",(0,0,0),(0,0,0));
	var_09.var_CBFA unlink();
	var_09.var_CBFA linkto(var_07,"tag_corner_bottom",(0,0,0),(0,0,0));
	func_E53E("active");
	scripts\sp\_utility::func_65E1("ring_unfolding");
	var_07 lib_0B06::func_1F35(var_07,"vr_unfold");
	func_E53E("passive");
	if(isdefined(var_09.var_1078F))
	{
		var_09.var_1078F.var_A534 = param_00;
		var_09 func_57F2(level.var_13563.var_BF5A);
		level thread func_6B74(var_08,1);
		wait(0.25);
		level thread func_6B74(var_09,1);
		level thread scripts\sp\_utility::func_C12D("corner_dropping_geo",0.25);
		var_09 scripts\sp\_utility::func_65E8("segment_dropping_geo");
	}

	scripts\sp\_utility::func_65DD("ring_unfolding");
}

//Function Number: 14
func_E53E(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_00 == "passive")
	{
		foreach(var_05 in self.var_466A)
		{
			var_05.var_AC84 method_82FC(var_05.var_AC84.var_10BF7);
			var_05.var_6128 show();
			var_05.var_6123 hide();
			if(param_01)
			{
				var_05.var_AC84 setlightintensity(var_05.var_AC84.var_EDED);
				continue;
			}

			if(param_02)
			{
				var_05.var_AC84 setlightintensity(0);
				var_05.var_6128 hide();
				var_05.var_6123 hide();
			}
		}
	}
	else if(param_00 == "active")
	{
		foreach(var_05 in self.var_466A)
		{
			var_05.var_AC84 method_82FC(var_05.var_AC84.var_62C0);
			var_05.var_6128 hide();
			var_05.var_6123 show();
			if(param_01)
			{
				var_05.var_AC84 setlightintensity(var_05.var_AC84.var_EDED);
				continue;
			}

			if(param_02)
			{
				var_05.var_AC84 setlightintensity(0);
				var_05.var_6128 hide();
				var_05.var_6123 hide();
			}
		}
	}

	if(self == level.var_13563.var_E546[0] || self == level.var_13563.var_E546[5])
	{
		thread func_E53F(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 15
func_E53F(param_00,param_01,param_02,param_03)
{
	level endon("reset_vr");
	var_04 = [self.var_F18B[1],self.var_F18B[3]];
	if(param_03)
	{
		level waittill("vr_ring" + self.var_EDD5 + "_intro_show_geo");
	}

	if(param_00 == "passive")
	{
		foreach(var_06 in var_04)
		{
			if(isdefined(var_06.var_6E86))
			{
				if(isdefined(var_06.var_6E86.var_6128))
				{
					var_06.var_6E86.var_6128 show();
					var_06.var_6E86.var_6123 hide();
					if(param_02)
					{
						var_06.var_6E86.var_6128 hide();
						var_06.var_6E86.var_6123 hide();
					}
				}
			}

			if(isdefined(var_06.var_6128))
			{
				var_06.var_6128 show();
				var_06.var_6123 hide();
				if(param_02)
				{
					var_06.var_6128 hide();
					var_06.var_6123 hide();
				}
			}
		}

		return;
	}

	if(param_00 == "active")
	{
		foreach(var_06 in self.var_F18B)
		{
			if(isdefined(var_06.var_6E86))
			{
				if(isdefined(var_06.var_6E86.var_6128))
				{
					var_06.var_6E86.var_6128 hide();
					var_06.var_6E86.var_6123 show();
					if(param_02)
					{
						var_06.var_6E86.var_6128 hide();
						var_06.var_6E86.var_6123 hide();
					}
				}
			}

			if(isdefined(var_06.var_6128))
			{
				var_06.var_6128 hide();
				var_06.var_6123 show();
				if(param_02)
				{
					var_06.var_6128 hide();
					var_06.var_6123 hide();
				}
			}
		}
	}
}

//Function Number: 16
func_6B74(param_00,param_01)
{
	level endon("reset_vr");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00.var_6B71))
	{
		param_00 scripts\sp\_utility::func_65E1("segment_dropping_geo");
		if(!param_01)
		{
			if(param_00 == level.var_13563.var_E546[1].var_F18B[0])
			{
				param_00 playsound("vr_blocks_in_and_hit_01");
			}
			else if(param_00 == level.var_13563.var_E546[1].var_F18B[1])
			{
				param_00 playsound("vr_blocks_in_and_hit_02");
			}
			else if(param_00 == level.var_13563.var_E546[1].var_F18B[2])
			{
				param_00 playsound("vr_blocks_in_and_hit_03");
			}
			else if(param_00 == level.var_13563.var_E546[1].var_F18B[3])
			{
				param_00 playsound("vr_blocks_in_and_hit_04");
			}
		}
		else if(isdefined(param_00.var_1078F))
		{
			if(param_00.var_1078F.var_A534 == "left")
			{
				param_00 playsound("vr_blocks_in_bridge_left");
			}
			else
			{
				param_00 playsound("vr_blocks_in_bridge_right");
			}
		}

		for(var_02 = 0;var_02 < param_00.var_6B71.size;var_02++)
		{
			var_03 = param_00.var_6B71[var_02];
			if(param_01)
			{
				if(!isdefined(var_03.var_EE79))
				{
					continue;
				}

				if(var_03.var_EE79 == "unfold")
				{
					var_03 thread func_6B72();
					wait(0.05);
				}

				continue;
			}

			if(isdefined(var_03.var_EE79))
			{
				if(var_03.var_EE79 == "unfold")
				{
					continue;
				}
			}

			var_03 thread func_6B72();
			wait(0.1);
		}

		wait(0.3);
		param_00 scripts\sp\_utility::func_65DD("segment_dropping_geo");
	}
}

//Function Number: 17
func_6B72()
{
	var_00 = self.var_8D0D * -1;
	var_01 = self.origin + (0,0,var_00);
	func_F188(level.var_13563.var_BF5A,0,self.var_7595,var_01,self.var_7587,anglestoup(self.angles));
	self unlink();
	self show();
	self moveto(var_01,0.25);
}

//Function Number: 18
func_2F0A(param_00)
{
	if(param_00)
	{
		level.var_13563.var_2F09 thread func_3108(1);
		return;
	}

	level.var_13563.var_2F09 thread func_3108(0);
}

//Function Number: 19
func_4D96(param_00,param_01,param_02,param_03)
{
	level notify("data_box_moving");
	level endon("reset_vr");
	level endon("data_box_moving");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	foreach(var_05 in level.var_13563.var_4D95)
	{
		var_05 thread func_4D97(param_00,param_01,param_02,param_03);
		if(!param_03)
		{
			wait(0.125);
		}
	}
}

//Function Number: 20
func_4D97(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		thread func_3108(1);
	}
	else if(param_02)
	{
		thread func_3108(0,1);
	}

	if(isdefined(self.var_A645) && param_01)
	{
		self.var_A645 playsound("killcounter_appear");
		self.var_A645 thread func_3108(1);
	}
	else if(isdefined(self.var_A645) && param_02)
	{
		self.var_A645 playsound("killcounter_disappear");
		self.var_A645 thread func_3108(0,1);
	}

	if(param_03)
	{
		self waittill("vr_flicker_done");
		self moveto(param_00,0.05);
		return;
	}

	self moveto(param_00,0.5,0.125,0.125);
}

//Function Number: 21
func_3108(param_00,param_01)
{
	self notify("vr_flicker");
	level endon("reset_vr");
	self endon("vr_flicker");
	var_02 = 0.1;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		var_03 = 3;
	}
	else
	{
		var_03 = 5;
	}

	if(param_00)
	{
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if(var_04 > 2)
			{
				var_02 = 0.15;
			}

			self hide();
			wait(randomfloatrange(0.05,var_02));
			self show();
			wait(randomfloatrange(0.05,var_02));
		}
	}
	else
	{
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if(var_04 > 2)
			{
				var_02 = 0.15;
			}

			self show();
			wait(randomfloatrange(0.05,var_02));
			self hide();
			wait(randomfloatrange(0.05,var_02));
		}
	}

	self notify("vr_flicker_done");
}

//Function Number: 22
func_A647()
{
	var_00 = level.var_13563.var_63A1;
	var_01 = var_00.size;
	var_02 = [level.var_13563.var_4D95["front_top_right"].var_A645,level.var_13563.var_4D95["rear_top_left"].var_A645,level.var_13563.var_4D95["rear_top_right"].var_A645];
	foreach(var_04 in var_02)
	{
		var_04 thread func_A646();
		if(var_01 != var_04.var_4B5B)
		{
			var_04 method_8187("tag_num" + var_04.var_4B5B);
			var_04 method_8387("tag_num" + var_01);
			var_04.var_4B5B = var_01;
		}

		if(var_01 == 0)
		{
			foreach(var_06 in var_04.var_1141C)
			{
				var_04 method_8187(var_06);
			}

			continue;
		}

		for(var_08 = 1;var_08 < var_04.var_1141C.size;var_08++)
		{
			if(var_08 <= var_01)
			{
				var_04 method_8387("tag_boxcounter" + var_08);
				continue;
			}

			var_04 method_8187("tag_boxcounter" + var_08);
		}
	}
}

//Function Number: 23
func_A646()
{
	level endon("reset_vr");
	if(scripts\sp\_utility::func_65DB("killcounter_animating"))
	{
		return;
	}

	scripts\sp\_utility::func_65E1("killcounter_animating");
	lib_0B06::func_1F35(self,"update");
	scripts\sp\_utility::func_65DD("killcounter_animating");
}

//Function Number: 24
func_106C8(param_00,param_01)
{
	level endon("reset_vr");
	var_02 = [];
	var_03 = [];
	if(isdefined(level.var_13563.var_46C6))
	{
		var_02 = func_799F(param_00,level.var_13563.var_46C6,4);
		if(isdefined(level.var_13563.var_46C7))
		{
			if(level.var_13563.var_46C7 != level.var_13563.var_46C6)
			{
				var_03 = func_799F(param_00,level.var_13563.var_46C7,4);
			}
		}
	}
	else
	{
		var_02 = func_799F(param_00,level.var_13563.var_46C7,4);
	}

	if(param_01 == 0)
	{
		level.var_13563.var_10691 = 2;
		level.var_13563.var_1087E[0] func_1085F(param_00,var_02[0],0);
		if(var_03.size > 0)
		{
			level.var_13563.var_1087E[1] func_1085F(param_00,var_03[0],0);
		}
		else
		{
			level.var_13563.var_1087E[1] func_1085F(param_00,var_02[1],0);
		}

		level waittill("equipment_range_enemies_dead");
		return;
	}

	if(param_01 == 1)
	{
		level.var_13563.var_10691 = 4;
		level.var_13563.var_1087E[0] func_1085F(param_00,var_02[0],0);
		if(var_03.size > 0)
		{
			level.var_13563.var_1087E[1] func_1085F(param_00,var_03[0],0);
		}
		else
		{
			level.var_13563.var_1087E[1] func_1085F(param_00,var_02[1],0);
		}

		wait(1);
		if(var_03.size > 0)
		{
			level.var_13563.var_1087E[2] func_1085F(param_00,var_02[1],0);
			level.var_13563.var_1087E[3] func_1085F(param_00,var_03[1],0);
		}
		else
		{
			level.var_13563.var_1087E[2] func_1085F(param_00,var_02[2],0);
			level.var_13563.var_1087E[3] func_1085F(param_00,var_02[3],0);
		}

		level waittill("equipment_range_enemies_dead");
		return;
	}

	if(param_01 > 1)
	{
		level.var_13563.var_10691 = 5;
		level.var_13563.var_1087E[0] func_1085F(param_00,var_02[0],0);
		if(var_03.size > 0)
		{
			level.var_13563.var_1087E[1] func_1085F(param_00,var_03[0],0);
			level.var_13563.var_1087E[2] func_1085F(param_00,var_02[1],0);
		}
		else
		{
			level.var_13563.var_1087E[1] func_1085F(param_00,var_02[1],0);
			level.var_13563.var_1087E[2] func_1085F(param_00,var_02[2],0);
		}

		wait(1);
		level.var_13563.var_E546[1] scripts\sp\_utility::func_65E8("ring_unfolding");
		for(var_04 = 3;var_04 < 4;var_04++)
		{
			var_05 = level.var_13563.var_BF5B[0];
			level.var_13563.var_1087E[var_04] func_1085F(var_05,var_05.var_1078F,1);
		}

		for(var_04 = 4;var_04 < 5;var_04++)
		{
			var_05 = level.var_13563.var_BF5B[1];
			level.var_13563.var_1087E[var_04] func_1085F(var_05,var_05.var_1078F,1);
		}

		level waittill("equipment_range_enemies_dead");
		return;
	}
}

//Function Number: 25
func_F60F()
{
	var_00 = level.player method_84C6("selectedLoadout");
	var_01 = level.player method_84C6("loadouts",var_00,"weaponSetups",0,"weapon");
	var_02 = level.player method_84C6("loadouts",var_00,"weaponSetups",1,"weapon");
	var_03 = lib_0B4A::func_31CE(0,var_00);
	var_04 = lib_0B4A::func_31CE(1,var_00);
	if(isdefined(var_03) || isdefined(var_04))
	{
		level.var_13563.var_46C6 = func_78E8(var_03);
		level.var_13563.var_46C7 = func_78E8(var_04);
		return;
	}

	level.var_13563.var_46C6 = "medium";
	level.var_13563.var_46C7 = undefined;
}

//Function Number: 26
func_78E8(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = weaponclass(param_00);
	switch(var_01)
	{
		case "rifle":
			var_02 = "medium";
			break;

		case "mg":
			var_02 = "medium";
			break;

		case "smg":
			var_02 = "close";
			break;

		case "sniper":
			var_02 = "long";
			break;

		case "pistol":
			var_02 = "close";
			break;

		case "spread":
			var_02 = "close";
			break;

		case "beam":
			var_02 = "medium";
			break;

		default:
			var_02 = "medium";
			break;
	}

	return var_02;
}

//Function Number: 27
func_799F(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = [];
	foreach(var_08 in param_00.var_10870)
	{
		if(var_08.var_EE79 == "long")
		{
			var_04[var_04.size] = var_08;
		}

		if(var_08.var_EE79 == "medium")
		{
			var_05[var_05.size] = var_08;
		}

		if(var_08.var_EE79 == "close")
		{
			var_06[var_06.size] = var_08;
		}
	}

	switch(param_01)
	{
		case "long":
			var_03 = scripts\common\utility::array_randomize(var_04);
			break;

		case "medium":
			var_03 = scripts\common\utility::array_randomize(var_05);
			break;

		case "close":
			var_03 = scripts\common\utility::array_randomize(var_06);
			break;
	}

	var_0A = [];
	for(var_0B = 0;var_0B < param_02;var_0B++)
	{
		if(var_0B > var_03.size - 1)
		{
			break;
		}

		var_0A[var_0A.size] = var_03[var_0B];
	}

	return scripts\common\utility::array_randomize(var_0A);
}

//Function Number: 28
func_1085F(param_00,param_01,param_02)
{
	level endon("reset_vr");
	if(param_02)
	{
		if(param_01.var_A534 == "left")
		{
			var_03 = level.var_13563.var_BF5A.var_12B96;
			self.angles = vectortoangles(anglestoforward(param_01.angles));
		}
		else
		{
			var_03 = level.var_13563.var_BF5A.var_12B97;
			self.angles = vectortoangles(anglestoforward(param_01.angles) * -1);
		}
	}
	else
	{
		var_03 = function_00B3(param_02.target,"targetname");
		self.angles = param_01.angles;
	}

	self.var_C1 = 1;
	self.target = var_03.var_336;
	self.origin = param_00.var_CBFA.origin + param_01.var_F187;
	self.var_EDE3 = 1;
	var_03.var_257 = 128;
	level thread scripts\common\utility::play_sound_in_space("vr_enemy_spawn",self.origin);
	var_04 = self.origin + anglestoup(self.angles) * 300;
	var_05 = anglestoup(self.angles) * -1;
	var_06 = anglestoforward(self.angles);
	func_F188(param_00,0,"vfx_vr_enemy_spawn",var_04,var_05,var_06);
	wait(0.65);
	scripts\sp\_utility::func_10619(1);
}

//Function Number: 29
func_D70F()
{
	level endon("reset_vr");
	self endon("death");
	level.var_13563.var_63A1[level.var_13563.var_63A1.size] = self;
	self.var_102 = 0;
	self.var_163 = 0;
	self.var_10264 = 1;
	self.var_28CF = 0;
	self.var_4E46 = ::func_643D;
	scripts\sp\_utility::func_5550();
	level thread func_A647();
	thread func_653A();
	scripts\sp\_utility::func_9196(4,1,0,"default_vroutline");
}

//Function Number: 30
func_D709()
{
	level endon("reset_vr");
	self endon("death");
	level.var_13563.var_639F[level.var_13563.var_639F.size] = self;
	self.var_102 = 0;
	self.var_163 = 0;
	self.var_4E46 = ::func_643C;
	scripts\sp\_utility::func_5550();
	level thread func_A647();
	thread func_653A();
	scripts\sp\_utility::func_9196(4,1,0,"default_vroutline");
}

//Function Number: 31
func_643D()
{
	if(!scripts\common\utility::func_2286(level.var_13563.var_63A1,self))
	{
		return 1;
	}

	level.var_13563.var_63A1 = scripts\common\utility::func_22A9(level.var_13563.var_63A1,self);
	level.var_13563.var_4E37 = level.var_13563.var_4E37 + 1;
	if(level.var_13563.var_4E37 >= level.var_13563.var_10691)
	{
		level notify("equipment_range_enemies_dead");
		level.var_13563.var_4E37 = 0;
	}

	level thread func_A647();
	self.var_13124 unlink();
	self.var_13124 setlightintensity(0);
	self.var_13124.var_19 = 0;
	var_00 = ["j_head","j_chest","j_shoulder_ri","j_shoulder_le","j_elbow_ri","j_elbow_le","j_hip_ri","j_hip_le","j_knee_ri","j_knee_le"];
	var_01 = var_00.size;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = var_00[var_02];
		var_04 = self gettagorigin(var_03);
		var_05 = self gettagangles(var_03);
		var_06 = self.var_DC;
		if(var_06 == (0,0,0))
		{
			var_07 = getent("start_vr_chamber","targetname");
			var_06 = anglestoforward(var_07.angles);
		}

		var_08 = anglestoup(var_05);
		func_F188(level.var_13563.var_BF5A,0,"vfx_vr_enemy_death",var_04,var_06,var_08);
	}

	if(!isdefined(self.var_4E68) || self.var_4E68 != 1)
	{
		level thread scripts\common\utility::play_sound_in_space("vr_enemy_death",self gettagorigin("J_Neck"));
	}

	wait(0.1);
	self delete();
	return 1;
}

//Function Number: 32
func_643C()
{
	if(!scripts\common\utility::func_2286(level.var_13563.var_639F,self))
	{
		return 1;
	}

	level.var_13563.var_639F = scripts\common\utility::func_22A9(level.var_13563.var_639F,self);
	level.var_13563.var_4E37 = level.var_13563.var_4E37 + 1;
	if(level.var_13563.var_4E37 >= level.var_13563.var_10691)
	{
		level notify("equipment_range_enemies_dead");
		level.var_13563.var_4E37 = 0;
	}

	level thread func_A647();
	self.var_13124 unlink();
	self.var_13124 setlightintensity(0);
	self.var_13124.var_19 = 0;
	var_00 = func_336D();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		var_03 = self gettagorigin(var_02);
		var_04 = self gettagangles(var_02);
		var_05 = self.var_DC;
		if(var_05 == (0,0,0))
		{
			var_06 = getent("start_vr_chamber","targetname");
			var_05 = anglestoforward(var_06.angles);
		}

		var_07 = anglestoup(var_04);
		func_F188(level.var_13563.var_BF5A,0,"vfx_vr_enemy_death",var_03,var_05,var_07);
	}

	if(!isdefined(self.var_4E68) || self.var_4E68 != 1)
	{
		level thread scripts\common\utility::play_sound_in_space("vr_enemy_death",self gettagorigin("J_Neck"));
	}

	wait(0.1);
	self delete();
	return 1;
}

//Function Number: 33
func_336D()
{
	var_00 = ["j_head","j_spineupper","j_shoulder_ri","j_shoulder_le","j_elbow_ri","j_elbow_le","j_hip_ri","j_hip_le","j_knee_ri","j_knee_le"];
	if(lib_0A0B::func_7C35("left_leg") == "dismember")
	{
		var_00 = scripts\common\utility::func_22AC(var_00,["j_hip_le","j_knee_le"]);
	}

	if(lib_0A0B::func_7C35("right_leg") == "dismember")
	{
		var_00 = scripts\common\utility::func_22AC(var_00,["j_hip_ri","j_knee_ri"]);
	}

	if(lib_0A0B::func_7C35("left_arm") == "dismember")
	{
		var_00 = scripts\common\utility::func_22AC(var_00,["j_shoulder_le","j_elbow_le"]);
	}

	if(lib_0A0B::func_7C35("right_arm") == "dismember")
	{
		var_00 = scripts\common\utility::func_22AC(var_00,["j_shoulder_ri","j_elbow_ri"]);
	}

	if(lib_0A0B::func_7C35("torso") == "dismember")
	{
		var_00 = scripts\common\utility::func_22AC(var_00,["j_spineupper"]);
	}

	return var_00;
}

//Function Number: 34
func_A62A()
{
	var_00 = level.var_13563.var_63A1;
	function_0042();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_FE4A))
		{
			if(var_02.var_FE4A)
			{
				killfxontag(level.var_7649[var_02.var_12BA4 + "_death"],var_02,"j_spine4");
			}
		}

		var_02.var_4E68 = 1;
		var_02 method_81D0();
	}
}

//Function Number: 35
func_13566(param_00)
{
	level endon("reset_vr");
	if(scripts\common\utility::flag("vr_delete_thrown_grenades"))
	{
		if(isdefined(param_00))
		{
			var_01 = undefined;
			if(issubstr(param_00.model,"seeker"))
			{
				var_02 = "seeker";
			}
			else if(issubstr(var_01.model,"emp"))
			{
				var_02 = "emp";
			}
			else if(issubstr(var_01.model,"anti_grav"))
			{
				var_02 = "antigrav";
			}
			else if(issubstr(var_01.model,"frag"))
			{
				var_02 = "frag";
			}
			else if(issubstr(var_01.model,"foam"))
			{
				var_02 = "coverwall";
			}
			else if(issubstr(var_01.model,"drone"))
			{
				var_02 = var_01.origin;
				var_02 = "drone";
			}
			else
			{
				return;
			}

			param_00 func_85AC();
			if(scripts\common\utility::flag("vr_delete_thrown_grenades"))
			{
				switch(var_02)
				{
					case "seeker":
						level thread lib_0E26::func_DFC1();
						scripts\common\utility::func_6E5A("seeker_force_delete");
						var_03 = level.var_F10A.var_A8C6;
						break;

					case "emp":
						level thread lib_0E25::func_DFBE();
						scripts\common\utility::func_6E5A("emp_force_delete");
						var_03 = level.var_612D.var_A8C6;
						break;

					case "antigrav":
						level thread lib_0E21::func_DFBA();
						scripts\common\utility::func_6E5A("antigrav_force_delete");
						var_03 = level.var_2006.var_A8C6;
						break;

					case "coverwall":
						level thread scripts\sp\_coverwall::func_DFBD();
						scripts\common\utility::func_6E5A("coverwall_force_delete");
						var_03 = level.player.var_4759.var_A8C6;
						break;

					case "frag":
						level thread scripts\sp\_detonategrenades::func_DFBF();
						scripts\common\utility::func_6E5A("frag_force_delete");
						var_03 = level.var_149.var_A8C6;
						break;

					case "drone":
						level thread lib_0E2D::func_5139();
						var_03 = var_02;
						break;

					default:
						var_03 = undefined;
						break;
				}

				if(var_02 == "drone")
				{
					level thread func_DFF0(0);
					return;
				}

				if(isdefined(var_03))
				{
					level thread func_859E("vfx_vr_equipment_derez",var_03);
					return;
				}

				return;
			}
		}
	}
}

//Function Number: 36
func_85AC()
{
	self endon("explode");
	self endon("missile_stuck");
	self endon("death");
	self endon("entitydeleted");
	level endon("reset_vr");
	var_00 = getent("vr_thrown_grenade_trigger","targetname");
	for(;;)
	{
		if(self istouching(var_00))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		break;
	}
}

//Function Number: 37
func_DFED(param_00)
{
	level endon("reset_vr");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	level thread func_DFF0(param_00);
	level thread func_DFF3(param_00);
	level thread func_DFF1(param_00);
	level thread func_DFEE(param_00);
	level thread func_DFEF(param_00);
	level thread func_DFF2(param_00);
	if(!param_00)
	{
		scripts\common\utility::func_6E5A("seeker_force_delete");
		scripts\common\utility::func_6E5A("emp_force_delete");
		scripts\common\utility::func_6E5A("antigrav_force_delete");
		scripts\common\utility::func_6E5A("coverwall_force_delete");
		scripts\common\utility::func_6E5A("frag_force_delete");
	}
}

//Function Number: 38
func_DFF0(param_00)
{
	level thread lib_0E2D::func_5139();
	level thread lib_0E2D::func_5138();
	foreach(var_02 in level.player.var_4C29)
	{
		if(isdefined(var_02.var_51BA))
		{
			if(var_02.var_51BA)
			{
				continue;
			}
		}

		if(isdefined(var_02.var_C7B4))
		{
			if(var_02.var_C7B4)
			{
				continue;
			}
		}

		if(!param_00)
		{
			level thread func_859F("vfx_vr_equipment_derez",var_02);
		}
	}
}

//Function Number: 39
func_DFF3(param_00)
{
	if(!param_00)
	{
		foreach(var_02 in level.var_F10A.var_162D)
		{
			level thread func_859E("vfx_vr_equipment_derez",var_02.origin);
		}

		foreach(var_05 in level.var_F10A.var_1633)
		{
			level thread func_859E("vfx_vr_equipment_derez",var_05.origin);
		}
	}

	lib_0E26::func_DFC1();
}

//Function Number: 40
func_DFF1(param_00)
{
	if(!param_00)
	{
		foreach(var_02 in level.var_612D.var_522C)
		{
			level thread func_859E("vfx_vr_equipment_derez",var_02.origin + (0,0,16));
		}
	}

	lib_0E25::func_DFBE();
}

//Function Number: 41
func_DFEE(param_00)
{
	if(!param_00)
	{
		foreach(var_02 in level.var_2006.var_522B)
		{
			level thread func_859E("vfx_vr_equipment_derez",var_02.origin + (0,0,16));
		}
	}

	lib_0E21::func_DFBA();
}

//Function Number: 42
func_DFEF(param_00)
{
	if(!param_00)
	{
		foreach(var_02 in level.player.var_4759.var_11168)
		{
			if(isdefined(var_02.var_15F))
			{
				var_03 = var_02.var_15F.origin;
			}
			else
			{
				var_03 = var_02.origin;
			}

			level thread func_859E("vfx_vr_equipment_derez",var_03 + (0,0,16));
		}
	}

	scripts\sp\_coverwall::func_DFBD();
}

//Function Number: 43
func_DFF2(param_00)
{
	if(!param_00)
	{
		foreach(var_02 in level.var_149.var_B37A)
		{
			var_03 = var_02.origin;
			level thread func_859E("vfx_vr_equipment_derez",var_03);
		}
	}

	scripts\sp\_detonategrenades::func_DFBF();
}

//Function Number: 44
func_859E(param_00,param_01)
{
	level endon("reset_vr");
	var_02 = spawnfx(scripts\common\utility::getfx(param_00),param_01);
	triggerfx(var_02);
	level thread scripts\common\utility::play_sound_in_space("emp_shock_short",param_01);
	var_02.var_F185 = 0;
	level.var_13563.var_760D[level.var_13563.var_760D.size] = var_02;
	wait(1.5);
	level.var_13563.var_760D = scripts\common\utility::func_22A9(level.var_13563.var_760D,var_02);
	var_02 delete();
}

//Function Number: 45
func_859F(param_00,param_01)
{
	level endon("reset_vr");
	if(isdefined(param_01.var_9A96))
	{
		while(param_01.var_9A96)
		{
			scripts\common\utility::func_136F7();
		}
	}

	var_02 = spawnfx(scripts\common\utility::getfx(param_00),param_01.var_5BD7.origin);
	triggerfx(var_02);
	level thread scripts\common\utility::play_sound_in_space("emp_shock_short",param_01.var_5BD7.origin);
	var_02.var_F185 = 0;
	level.var_13563.var_760D[level.var_13563.var_760D.size] = var_02;
	wait(1.5);
	level.var_13563.var_760D = scripts\common\utility::func_22A9(level.var_13563.var_760D,var_02);
	var_02 delete();
}

//Function Number: 46
func_A5BD(param_00)
{
	level endon("reset_vr");
	param_00 waittill("rotation_done");
	scripts\common\utility::func_6E2A("vr_delete_thrown_grenades");
}

//Function Number: 47
func_A5D0()
{
	level endon("reset_vr");
	var_00 = getent("vr_trigger_kill_equipment","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01.var_12BA4 == "seeker")
		{
			level thread func_859E("vfx_vr_equipment_derez",var_01.origin);
			var_01 thread lib_0E26::func_E084();
		}
	}
}

//Function Number: 48
func_1E3A()
{
	level endon("reset_vr");
	for(;;)
	{
		level.player scripts\common\utility::waittill_any_3("reload_start","weapon_switch_started","offhand_fired","weapon_fired");
		var_00 = undefined;
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = level.player getcurrentprimaryweapon();
		var_05 = weaponclipsize(var_04);
		var_06 = level.player getweaponammostock(var_04);
		var_07 = scripts\sp\_utility::func_7BD6();
		var_08 = scripts\sp\_utility::func_7C3D();
		var_09 = scripts\sp\_utility::func_7CAF();
		var_0A = scripts\sp\_utility::func_7CB1();
		if(isdefined(var_07) && var_07 != "none")
		{
			var_00 = level.player getweaponammoclip(var_07);
		}

		if(isdefined(var_08) && var_08 != "none")
		{
			var_01 = level.player getweaponammoclip(var_08);
		}

		if(isdefined(var_09) && var_09 != "none")
		{
			var_02 = level.player getweaponammoclip(var_09);
		}

		if(isdefined(var_0A) && var_0A != "none")
		{
			var_03 = level.player getweaponammoclip(var_0A);
		}

		if(lib_0A2F::func_DA40(var_04))
		{
			if(issubstr(var_04,"chargeshot") || issubstr(var_04,"penetrationrail"))
			{
				var_0B = 2;
				if(level.player method_8118() < var_0B)
				{
					level.player setweaponammoclip(var_04,var_05);
				}
			}
			else if(issubstr(var_04,"steeldragon"))
			{
				var_0B = 25;
				if(var_06 < var_05)
				{
					if(level.player method_8118() < var_0B)
					{
						level.player givemaxammo(var_04);
					}
				}
			}
			else if(issubstr(var_04,"lockon"))
			{
				if(var_06 <= var_05)
				{
					level.player givemaxammo(var_04);
				}
			}
		}
		else if(var_06 <= var_05)
		{
			level.player givemaxammo(var_04);
		}

		if(isdefined(var_00) && var_00 < 1)
		{
			level.player givemaxammo(var_07);
		}

		if(isdefined(var_01) && var_01 < 1)
		{
			level.player givemaxammo(var_08);
		}

		if(isdefined(var_02) && var_02 < 1)
		{
			level.player givemaxammo(var_09);
		}

		if(isdefined(var_03) && var_03 < 1)
		{
			level.player givemaxammo(var_0A);
		}
	}
}

//Function Number: 49
func_653A()
{
	level endon("reset_vr");
	self endon("death");
	foreach(var_01 in level.var_13563.var_653C)
	{
		if(!var_01.var_19)
		{
			var_01.var_19 = 1;
			self.var_13124 = var_01;
			break;
		}
	}

	self.var_13124 linkto(self,"tag_origin",(0,0,8),(0,0,0));
	scripts\common\utility::func_136F7();
	self.var_13124 setlightintensity(self.var_13124.var_10C89);
	self.var_13124 method_8300(37);
	for(;;)
	{
		func_653B(47,1);
		wait(0.25);
		func_653B(37,1);
	}
}

//Function Number: 50
func_653B(param_00,param_01)
{
	level endon("reset_vr");
	self endon("death");
	var_02 = int(param_01 * 20);
	var_03 = self.var_13124 method_8136();
	var_04 = param_00 - var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		self.var_13124 method_8300(var_03 + var_05 * var_04);
		wait(0.05);
	}

	self.var_13124 method_8300(param_00);
}

//Function Number: 51
func_F188(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		foreach(var_07 in param_00.var_75B5)
		{
			param_03 = param_00.var_CBFA.origin + var_07.var_F187;
			var_08 = spawnfx(scripts\common\utility::getfx(var_07.var_EE79),param_03);
			triggerfx(var_08);
			var_08.var_F185 = 1;
			level.var_13563.var_760D[level.var_13563.var_760D.size] = var_08;
		}

		return;
	}

	if(isdefined(param_05) && isdefined(var_08))
	{
		var_08 = spawnfx(scripts\common\utility::getfx(param_03),param_04,param_05,var_08);
	}
	else
	{
		var_08 = spawnfx(scripts\common\utility::getfx(param_03),param_04);
	}

	triggerfx(var_08);
	var_08.var_F185 = 1;
	level.var_13563.var_760D[level.var_13563.var_760D.size] = var_08;
}

//Function Number: 52
func_A62B(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = [];
	foreach(var_03 in level.var_13563.var_760D)
	{
		if(param_00)
		{
			if(isdefined(var_03.var_F185))
			{
				if(var_03.var_F185)
				{
					var_03 delete();
				}
			}
			else
			{
				var_01[var_01.size] = var_03;
			}

			continue;
		}

		var_03 delete();
	}

	level.var_13563.var_760D = var_01;
}

//Function Number: 53
create_fx_pause()
{
	foreach(var_01 in level.var_49C9)
	{
		if(isdefined(var_01.var_13125["exploder"]))
		{
			continue;
		}

		var_01 scripts\common\utility::func_C9CF();
	}
}

//Function Number: 54
create_fx_resume()
{
	foreach(var_01 in level.var_49C9)
	{
		if(isdefined(var_01.var_13125["exploder"]))
		{
			continue;
		}

		var_01 scripts\sp\_utility::func_E2B0();
	}
}

//Function Number: 55
func_E241()
{
	level notify("reset_vr");
	level.player notify("stop_delay_call");
	level.player freezecontrols(1);
	level.player setstance("stand");
	scripts\sp\_outline::func_91A1("default",::scripts\sp\_outline::func_9192);
	func_A62A();
	func_10FB6();
	func_DFED(1);
	scripts\common\utility::func_6E2A("vr_delete_thrown_grenades");
	func_12BA8();
	func_12B92();
	scripts\common\utility::func_136F7();
	level.var_13563.var_BF5B = [];
	foreach(var_01 in level.var_13563.var_12B98)
	{
		var_01 delete();
	}

	level.var_13563.var_12B98 = [];
	level.var_13563.var_2F09 hide();
	level.var_13563.var_9B3D show();
	foreach(var_04 in level.var_13563.var_653C)
	{
		var_04.var_19 = 0;
		var_04 setlightintensity(0);
	}

	func_E1A2();
	wait(0.1);
	level.var_13563.var_4E37 = 0;
	level.var_13563.var_5BDE = 0;
	func_A62B();
	foreach(var_07 in level.var_13563.var_E546)
	{
		if(var_07.var_EDD5 == 0)
		{
			var_07.var_D958 linkto(var_07,"tag_origin",(0,0,0),(0,90,0));
		}

		foreach(var_09 in var_07.var_466A)
		{
			func_465F(var_09,var_07);
		}

		foreach(var_0C in var_07.var_F18B)
		{
			func_F189(var_0C,var_07);
		}

		var_07 scripts\sp\_utility::func_65DD("ring_spinning");
		var_07 scripts\sp\_utility::func_65DD("ring_unfolding");
	}

	level.player freezecontrols(0);
}

//Function Number: 56
func_465F(param_00,param_01)
{
	if(isdefined(param_00.var_1078F))
	{
		param_00.var_1078F.var_A534 = undefined;
	}

	param_00.var_AC84 method_82FC(param_00.var_AC84.var_10BF7);
	param_00.var_AC84 setlightintensity(0);
	param_00.var_6128 hide();
	param_00.var_6123 hide();
	param_00 hide();
	param_00.var_CBFA linkto(param_01,"j_corner" + param_00.var_EDE8,(0,0,0),(0,0,0));
	func_6B73(param_00,1);
}

//Function Number: 57
func_F189(param_00,param_01)
{
	param_00 hide();
	if(isdefined(param_00.var_4381))
	{
		param_00.var_4381 hide();
	}

	if(isdefined(param_00.var_6128))
	{
		param_00.var_6128 hide();
	}

	if(isdefined(param_00.var_6123))
	{
		param_00.var_6123 hide();
	}

	if(isdefined(param_00.var_6E86))
	{
		if(isdefined(param_00.var_6E86.var_6128))
		{
			param_00.var_6E86.var_6128 hide();
		}

		if(isdefined(param_00.var_6E86.var_6123))
		{
			param_00.var_6E86.var_6123 hide();
		}

		param_00.var_6E86 hide();
		param_00.var_6E86 linkto(param_00.var_CBFA,"",param_00.var_6E86.var_D6A0,param_00.var_6E86.var_42);
	}

	param_00.var_CBFA linkto(param_01,"j_segment" + param_00.var_EDE8,(0,0,0),(0,0,0));
	func_6B73(param_00,1);
}

//Function Number: 58
func_6B73(param_00,param_01)
{
	if(isdefined(param_00.var_6B71))
	{
		foreach(var_03 in param_00.var_6B71)
		{
			if(param_01)
			{
				var_03 linkto(param_00.var_CBFA,"",var_03.var_D6A0,var_03.var_42);
				var_03 hide();
				continue;
			}

			var_03 linkto(param_00.var_CBFA);
		}
	}
}

//Function Number: 59
func_57F2(param_00)
{
	self method_80AF(param_00);
	level.var_13563.var_2BE3[level.var_13563.var_2BE3.size] = self;
}

//Function Number: 60
func_12B92()
{
	foreach(var_01 in level.var_13563.var_2BE3)
	{
		var_01 method_83C9();
	}

	level.var_13563.var_2BE3 = [];
}

//Function Number: 61
func_E1A2()
{
	level.var_13563.var_9B3D.var_CBFA.origin = level.var_13563.var_9B3D.var_CBFA.var_10CE2;
	foreach(var_01 in level.var_13563.var_E546)
	{
		var_01 moveto(var_01.var_10CE2,0.05);
		var_01 rotateto(var_01.var_10BA1,0.05);
		foreach(var_03 in var_01.var_466A)
		{
			if(isdefined(var_03.var_6B71))
			{
				foreach(var_05 in var_03.var_6B71)
				{
					var_05 moveto(var_05.origin,0.05);
					var_05 rotateto(var_05.angles,0.05);
				}
			}
		}

		foreach(var_09 in var_01.var_F18B)
		{
			if(isdefined(var_09.var_6E86))
			{
				var_09.var_6E86 rotateto(var_09.var_6E86.angles,0.05);
			}

			if(isdefined(var_09.var_6B71))
			{
				foreach(var_05 in var_09.var_6B71)
				{
					var_05 moveto(var_05.origin,0.05);
					var_05 rotateto(var_05.angles,0.05);
				}
			}
		}
	}

	foreach(var_0F in level.var_13563.var_4D95)
	{
		var_0F moveto(var_0F.origin,0.05);
		var_0F hide();
		if(isdefined(var_0F.var_A645))
		{
			var_0F.var_A645 hide();
			var_0F.var_A645 method_8187("tag_num" + var_0F.var_A645.var_4B5B);
			var_0F.var_A645 method_8387("tag_num0");
			var_0F.var_A645.var_4B5B = 0;
			foreach(var_11 in var_0F.var_A645.var_1141C)
			{
				var_0F.var_A645 method_8187(var_11);
			}
		}
	}
}

//Function Number: 62
func_10FB6()
{
	level.player method_83AD();
	foreach(var_01 in level.var_13563.var_E546)
	{
		var_01 method_83AD();
		var_01 method_83A1();
		var_01 method_806F(%root,0);
	}

	foreach(var_04 in level.var_13563.var_E546[1].var_466A)
	{
		var_04 method_83AD();
	}

	foreach(var_07 in level.var_13563.var_E546[1].var_F18B)
	{
		var_07 method_83AD();
	}

	foreach(var_07 in level.var_13563.var_E546[0].var_F18B)
	{
		var_07.var_6E86 method_83AD();
	}

	foreach(var_0C in level.var_13563.var_12B98)
	{
		var_0C method_83AD();
		var_0C method_83A1();
		var_0C method_806F(%root,0);
	}

	foreach(var_0F in level.var_13563.var_4D95)
	{
		if(isdefined(var_0F.var_A645))
		{
			var_0F.var_A645 method_83AD();
			var_0F.var_A645 method_83A1();
			var_0F.var_A645 method_806F(%root,0);
			var_0F.var_A645 scripts\sp\_utility::func_65DD("killcounter_animating");
		}
	}
}

//Function Number: 63
func_13598()
{
	for(;;)
	{
		level.player waittill("luinotifyserver",var_00,var_01);
		break;
	}

	switch(var_00)
	{
		case "player_vr_reset_request":
			scripts\common\utility::flag_set("vr_tutorial_leave_shown");
			function_01C5("bg_cinematicAboveUI","1");
			function_01C5("bg_cinematicFullScreen","1");
			function_01C5("bg_cinematicCanPause","1");
			func_CE8D(undefined,0);
			func_E241();
			func_F620();
			level thread func_661E(1);
			break;

		case "player_vr_exit_request":
			scripts\common\utility::flag_set("vr_tutorial_leave_shown");
			function_01C5("bg_cinematicAboveUI","1");
			function_01C5("bg_cinematicFullScreen","1");
			function_01C5("bg_cinematicCanPause","1");
			level.player method_8070(2);
			if(scripts\common\utility::func_6E34("acceped_vr"))
			{
				scripts\common\utility::func_6E2A("acceped_vr");
			}
	
			func_CE8D(undefined,0);
			func_E241();
			func_F620();
			setomnvar("ui_in_vr",0);
			scripts\common\utility::func_6E2A("in_vr_mode");
			level.var_93A9 = undefined;
			level thread lib_0EE8::func_C608(0);
			break;
	}
}

//Function Number: 64
func_F61F()
{
	level.player playerlinktoabsolute(getent("start_vr_chamber","targetname"));
	scripts\sp\_utility::func_28D7("axis");
	level.player scripts\sp\_utility::func_11428();
	level.player method_8559(0);
	if(issubstr(level.script,"shipcrib"))
	{
		function_01CB(0);
	}

	wait(0.75);
	level.player unlink();
	level.player method_80A8();
	if(issubstr(level.script,"shipcrib"))
	{
		level.var_EFED = "combat_vr";
	}
	else
	{
		level.player scripts\sp\_utility::func_F526("normal");
		level.player thread scripts\sp\_utility::func_2B77(0.5);
		level.player scripts\common\utility::func_1C52(1);
		level.player scripts\common\utility::func_1C76(1);
		level.player scripts\common\utility::func_1C60(1);
		level.player method_80A1();
		level.player method_80CB(1);
		level.player method_83B6(level.player getcurrentprimaryweapon());
		function_01C5("mantle_enable",1);
		function_01C5("cg_drawCrosshair",1);
		setomnvar("ui_hide_weapon_info",0);
		setomnvar("ui_hide_hud",0);
	}

	lib_0EE8::func_8311();
	level thread create_fx_pause();
	func_F60F();
	level thread func_1E3A();
}

//Function Number: 65
func_F620()
{
	level.player method_8475();
	level.player method_8559(1);
	level thread scripts\sp\_gameskill::func_E080();
	level.player method_80DA();
	scripts\sp\_utility::func_28D8("axis");
	level thread create_fx_resume();
	if(issubstr(level.script,"shipcrib"))
	{
		function_01CB(level.var_FD6E.var_111D7);
		return;
	}

	level.player scripts\sp\_utility::func_11428();
	level.player scripts\common\utility::func_1C52(0);
	level.player scripts\common\utility::func_1C76(0);
	level.player scripts\common\utility::func_1C60(0);
	level.player method_80D1();
	level.player method_80CB(0);
	function_01C5("mantle_enable",0);
	function_01C5("cg_drawCrosshair",0);
	setomnvar("ui_hide_weapon_info",1);
}

//Function Number: 66
func_12BA8()
{
	foreach(var_01 in level.var_13563.var_653C)
	{
		if(var_01 islinked())
		{
			var_01 unlink();
		}
	}

	foreach(var_04 in level.var_13563.var_E546)
	{
		if(var_04.var_EDD5 == 0)
		{
			var_04.var_D958 unlink();
		}

		foreach(var_06 in var_04.var_466A)
		{
			var_06.var_CBFA unlink();
			if(isdefined(var_06.var_6B71))
			{
				foreach(var_08 in var_06.var_6B71)
				{
					var_08 unlink();
				}
			}
		}

		foreach(var_0C in var_04.var_F18B)
		{
			var_0C.var_CBFA unlink();
			if(isdefined(var_0C.var_6E86))
			{
				var_0C.var_6E86 unlink();
			}

			if(isdefined(var_0C.var_6B71))
			{
				foreach(var_08 in var_0C.var_6B71)
				{
					var_08 unlink();
				}
			}
		}
	}
}

//Function Number: 67
waittilbinkend()
{
	while(function_0102())
	{
		scripts\common\utility::func_136F7();
	}

	function_01C5("bg_cinematicAboveUI","0");
}

//Function Number: 68
func_CE8D(param_00,param_01)
{
	level notify("playing_vr_tranistion_bink");
	level endon("playing_vr_tranistion_bink");
	if(!isdefined(param_00))
	{
		param_00 = "ship_enter_vr";
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	function_01F1();
	wait(0.1);
	function_01C5("bg_cinematicFullScreen","1");
	function_01C5("bg_cinematicCanPause","0");
	function_01C5("bg_cinematicAboveUI","1");
	if(param_01)
	{
		var_02 = "weapon_loadout_terminal_intro";
	}
	else
	{
		var_02 = "weapon_loadout_terminal_transition";
	}

	function_003D(var_02);
	while(!function_0102())
	{
		scripts\common\utility::func_136F7();
	}

	level.player playsound(param_00);
	level thread waittilbinkend();
	while(function_0102())
	{
		var_03 = function_003C();
		if(var_03 > 750)
		{
			level notify("vr_transition_bink_full_opacity");
			setomnvar("ui_close_vr_pause_menu",1);
			break;
		}

		scripts\common\utility::func_136F7();
	}
}