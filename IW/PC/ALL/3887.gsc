/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3887.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 21 ms
 * Timestamp: 10/27/2023 12:31:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F990();
	func_F9AF();
	func_F930();
	func_FA28();
	func_F921();
	func_FA3C();
	func_F927();
	level thread lib_0F2D::func_E241();
}

//Function Number: 2
func_F990()
{
	level.var_13563 = spawnstruct();
	level.var_13563.var_1087E = function_00C8("vr_spawner_human");
	level.var_13563.var_63A1 = [];
	level.var_13563.var_12B98 = [];
	level.var_13563.var_2BE3 = [];
	level.var_13563.var_4E37 = 0;
	level.var_13563.var_BF5B = [];
	level.var_13563.var_653C = getentarray("vr_enemy_uv_light","targetname");
	foreach(var_01 in level.var_13563.var_653C)
	{
		var_01.var_19 = 0;
		var_01.var_10C89 = 0.01;
		var_01.var_10CF0 = var_01 method_8136();
	}

	level.var_13563.var_2F09 = getent("vr_boundary_wall","targetname");
	level.var_13563.var_2F09 hide();
	level.var_13563.var_760D = [];
	level.var_13563.var_5BDE = 0;
	level.var_BFED = 1;
	level.var_55F0 = 1;
	scripts\common\utility::flag_init("vr_delete_thrown_grenades");
	scripts\common\utility::flag_init("vr_tutorial_leave_shown");
}

//Function Number: 3
func_1355F()
{
	precachestring(&"SHIPCRIB_VR_TUT_LEAVE");
	scripts\sp\_utility::func_16EB("vr_tut_leave",&"SHIPCRIB_VR_TUT_LEAVE",::func_13569);
}

//Function Number: 4
func_13569()
{
	return scripts\common\utility::flag("vr_tutorial_leave_shown");
}

//Function Number: 5
func_F9AF()
{
	level.var_13563.var_9B3D = getent("vr_iris","targetname");
	level.var_13563.var_9B3D.var_CBFA = getent("vr_iris_pivot","targetname");
	level.var_13563.var_9B3D.var_CBFA.var_10CE2 = level.var_13563.var_9B3D.var_CBFA.origin;
	level.var_13563.var_9B3D linkto(level.var_13563.var_9B3D.var_CBFA);
}

//Function Number: 6
func_F930()
{
	level.var_13563.var_4D95 = [];
	var_00 = getentarray("vr_data_box","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			continue;
		}

		if(isdefined(var_02.target))
		{
			var_02.var_A645 = getent(var_02.target,"targetname");
			var_02.var_A645 thread func_F9BC(var_02);
		}

		var_02 hide();
		level.var_13563.var_4D95[var_02.var_336] = var_02;
	}
}

//Function Number: 7
func_F9BC(param_00)
{
	self.var_1FBB = "killcounter";
	self.var_4B5B = 0;
	scripts\sp\_utility::func_23B7("killcounter");
	scripts\sp\_utility::func_65E0("killcounter_animating");
	var_01 = scripts\sp\_utility::func_7CCC(self.model);
	self.var_1141E = [];
	self.var_1141C = [];
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"tag_num"))
		{
			self method_8187(var_03);
			self.var_1141E[self.var_1141E.size] = var_03;
			continue;
		}

		if(issubstr(var_03,"tag_boxcounter"))
		{
			self method_8187(var_03);
			self.var_1141C[self.var_1141C.size] = var_03;
		}
	}

	self hide();
	self linkto(param_00,"tag_enemy_counter",(0,0,0),(0,0,0));
}

//Function Number: 8
func_FA28()
{
	var_00 = getentarray("vr_ring_rig","targetname");
	foreach(var_02 in var_00)
	{
		level.var_13563.var_E546[var_02.var_EDD5] = var_02;
		var_03 = scripts\common\utility::getstruct("vr_ring" + var_02.var_EDD5 + "_start","targetname");
		var_02.var_10CE2 = var_03.origin;
		var_02.var_10BA1 = var_03.angles;
		var_02 scripts\sp\_utility::func_65E0("ring_spinning");
		var_02 scripts\sp\_utility::func_65E0("ring_unfolding");
		var_02.var_1FBB = "ring" + var_02.var_EDD5;
		var_02 scripts\sp\_utility::func_23B7("ring" + var_02.var_EDD5);
		var_02 hide();
		if(var_02.var_EDD5 == 0)
		{
			var_02.var_D958 = getent("vr_ring" + var_02.var_EDD5 + "_probe","targetname");
			var_02.var_D958 linkto(var_02,"tag_origin",(0,0,0),(0,90,0));
		}
	}
}

//Function Number: 9
func_F921()
{
	foreach(var_01 in level.var_13563.var_E546)
	{
		var_02 = func_7834("vr_corner_helper","targetname",var_01.var_EDD5);
		var_03 = func_7834("vr_cornerpiece","script_noteworthy",var_01.var_EDD5);
		foreach(var_05 in var_02)
		{
			var_01.var_466A[var_05.var_EDE8] = func_7989(var_03,var_05.var_EDE8);
			var_06 = var_01.var_466A[var_05.var_EDE8];
			var_06.var_6B71 = getentarray("vr_ring" + var_01.var_EDD5 + "_corner" + var_06.var_EDE8 + "_falling_geo","script_noteworthy");
			var_07 = func_7AFE(var_05.target,"targetname");
			func_4660(var_07,var_01,var_06);
			var_06.var_6128 hide();
			var_06.var_6123 hide();
			if(var_06.var_EDD5 == 1)
			{
				var_06 scripts\sp\_utility::func_65E0("segment_dropping_geo");
				var_06.var_1078F.var_F187 = var_06.var_1078F.origin - var_06.var_CBFA.origin;
				var_06.var_1078F.var_A534 = undefined;
			}

			if(isdefined(var_06.var_6B71))
			{
				var_08 = [];
				foreach(var_0A in var_06.var_6B71)
				{
					var_0A.var_7595 = "vfx_vr_blockdrop_extra_small";
					var_08[var_0A.var_EE8C] = var_0A;
					var_0A.var_8D0D = 512;
					var_0A.var_D6A0 = var_0A.origin + (0,0,var_0A.var_8D0D) - var_06.var_CBFA.origin;
					var_0A.var_42 = var_0A.angles - var_06.var_CBFA.angles;
					var_0A linkto(var_06.var_CBFA,"",var_0A.var_D6A0,var_0A.var_42);
				}

				var_06.var_6B71 = var_08;
			}

			var_06 linkto(var_06.var_CBFA);
			var_06.var_AC84 linkto(var_06.var_CBFA);
			var_06.var_6128 linkto(var_06.var_CBFA);
			var_06.var_6123 linkto(var_06.var_CBFA);
			var_06.var_CBFA linkto(var_01,"j_corner" + var_06.var_EDE8,(0,0,0),(0,0,0));
		}
	}
}

//Function Number: 10
func_4660(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(function_02A6(var_04))
		{
			if(isdefined(var_04.script_noteworthy))
			{
				if(var_04.script_noteworthy == "pivot")
				{
					param_02.var_CBFA = var_04;
				}
				else if(var_04.script_noteworthy == "emissive_passive")
				{
					param_02.var_6128 = var_04;
				}
				else if(var_04.script_noteworthy == "emissive_active")
				{
					param_02.var_6123 = var_04;
				}
				else if(var_04.script_noteworthy == "light_center")
				{
					param_02.var_AC84 = var_04;
				}
			}

			continue;
		}

		if(function_02A4(var_04))
		{
			if(isdefined(var_04.script_noteworthy))
			{
				if(var_04.script_noteworthy == "spawn_org")
				{
					param_02.var_1078F = var_04;
				}
			}
		}
	}
}

//Function Number: 11
func_FA3C()
{
	foreach(var_01 in level.var_13563.var_E546)
	{
		var_02 = func_7834("vr_segment_helper","targetname",var_01.var_EDD5);
		foreach(var_04 in var_02)
		{
			if(isdefined(var_04.target))
			{
				var_05 = func_7AFE(var_04.target,"targetname");
			}
			else
			{
				var_05 = [];
			}

			var_01.var_F18B[var_04.var_EDE8] = getent("vr_ring" + var_01.var_EDD5 + "_" + var_04.var_EDE8,"targetname");
			var_06 = func_7835("traverse","targetname",var_01.var_EDD5,var_04.var_EDE8);
			var_05 = scripts\common\utility::array_combine(var_05,var_06);
			var_07 = var_01.var_F18B[var_04.var_EDE8];
			var_07.var_CBFA = undefined;
			var_07.var_10870 = [];
			var_07.var_B7D5 = [];
			var_07.var_4381 = undefined;
			if(var_01.var_EDD5 == 0)
			{
				if(var_07.var_EDE8 == 0 || var_07.var_EDE8 == 2)
				{
					var_07.var_6E86 = getent("vr_cap" + var_07.var_EDE8,"targetname");
				}
				else
				{
					var_08 = getentarray("vr_cap" + var_07.var_EDE8,"targetname");
					foreach(var_0A in var_08)
					{
						if(var_0A.var_EE79 == "flap")
						{
							var_07.var_6E86 = var_0A;
						}
					}

					foreach(var_0A in var_08)
					{
						if(var_0A.var_EE79 == "blue_lights")
						{
							var_07.var_6E86.var_6128 = var_0A;
							var_07.var_6E86.var_6128 hide();
							continue;
						}

						if(var_0A.var_EE79 == "red_lights")
						{
							var_07.var_6E86.var_6123 = var_0A;
							var_07.var_6E86.var_6123 hide();
						}
					}
				}
			}
			else if(var_01.var_EDD5 == 1)
			{
				var_07 scripts\sp\_utility::func_65E0("segment_dropping_geo");
				var_07.var_12B96 = function_00B3("vr_ring0_" + var_07.var_EDE8 + "_leftnode","targetname");
				var_07.var_12B97 = function_00B3("vr_ring0_" + var_07.var_EDE8 + "_rightnode","targetname");
				var_07.var_6B71 = getentarray("vr_ring" + var_01.var_EDD5 + "_" + var_07.var_EDE8 + "_falling_geo","script_noteworthy");
				var_07.var_75B5 = scripts\common\utility::getstructarray("vr_ring" + var_01.var_EDD5 + "_" + var_07.var_EDE8 + "_fx","targetname");
			}

			if(var_01.var_EDD5 == 5)
			{
				if(var_07.var_EDE8 == 1)
				{
					var_07.var_6128 = getent("vr_ring5_1_blue_light","targetname");
					var_07.var_6123 = getent("vr_ring5_1_red_light","targetname");
					var_07.var_6128 hide();
					var_07.var_6123 hide();
				}
				else if(var_07.var_EDE8 == 3)
				{
					var_07.var_6128 = getent("vr_ring5_3_blue_light","targetname");
					var_07.var_6123 = getent("vr_ring5_3_red_light","targetname");
					var_07.var_6128 hide();
					var_07.var_6123 hide();
				}
			}

			func_F18A(var_05,var_01,var_07);
			var_07 linkto(var_07.var_CBFA);
			foreach(var_0F in var_07.var_10870)
			{
				var_0F.var_F187 = var_0F.origin - var_07.var_CBFA.origin;
			}

			foreach(var_0F in var_07.var_B7D5)
			{
				var_0F.var_F187 = var_0F.origin - var_07.var_CBFA.origin;
			}

			if(isdefined(var_07.var_75B5))
			{
				foreach(var_0F in var_07.var_75B5)
				{
					var_0F.var_F187 = var_0F.origin - var_07.var_CBFA.origin;
				}
			}

			if(isdefined(var_07.var_6E86))
			{
				var_07.var_6E86.var_42 = var_07.var_6E86.angles - var_07.var_CBFA.angles;
				var_07.var_6E86.var_D6A0 = var_07.var_6E86.origin - var_07.var_CBFA.origin;
				if(isdefined(var_07.var_6E86.var_6128))
				{
					var_07.var_6E86.var_6128 linkto(var_07.var_6E86,"",(0,0,0),(0,0,0));
					var_07.var_6E86.var_6123 linkto(var_07.var_6E86,"",(0,0,0),(0,0,0));
				}

				var_07.var_6E86 linkto(var_07.var_CBFA,"",var_07.var_6E86.var_D6A0,var_07.var_6E86.var_42);
			}

			if(isdefined(var_07.var_6128))
			{
				var_07.var_6128 linkto(var_07.var_CBFA,"",(0,0,0),(0,0,0));
			}

			if(isdefined(var_07.var_6123))
			{
				var_07.var_6123 linkto(var_07.var_CBFA,"",(0,0,0),(0,0,0));
			}

			if(isdefined(var_07.var_6B71))
			{
				var_15 = [];
				foreach(var_17 in var_07.var_6B71)
				{
					var_15[var_17.var_EE8C] = var_17;
					var_17.var_8D0D = 512;
					var_17.var_D6A0 = var_17.origin + (0,0,var_17.var_8D0D) - var_07.var_CBFA.origin;
					var_17.var_42 = var_17.angles - var_07.var_CBFA.angles;
					var_17.var_7587 = anglestoright(var_07.var_CBFA.angles);
					var_17.var_7595 = "vfx_vr_blockdrop";
					if(isdefined(var_17.var_EE79))
					{
						if(var_17.var_EE79 == "vfx_3block")
						{
							var_17.var_7595 = "vfx_vr_blockdrop_small";
						}
						else if(var_17.var_EE79 == "unfold")
						{
							var_17.var_7595 = "vfx_vr_blockdrop_extra_small";
						}
						else if(var_17.var_EE79 == "angled")
						{
							var_0F = scripts\common\utility::getstruct(var_17.target,"targetname");
							var_17.var_7587 = anglestoforward(var_0F.angles);
						}
					}

					var_17 linkto(var_07.var_CBFA,"",var_17.var_D6A0,var_17.var_42);
				}

				var_07.var_6B71 = var_15;
			}

			if(isdefined(var_07.var_4381))
			{
				var_07.var_4381 linkto(var_07.var_CBFA);
			}

			var_07.var_CBFA linkto(var_01,"j_segment" + var_07.var_EDE8,(0,0,0),(0,0,0));
		}
	}
}

//Function Number: 12
func_F18A(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(function_02A6(var_04))
		{
			if(isdefined(var_04.script_noteworthy))
			{
				if(var_04.script_noteworthy == "pivot")
				{
					param_02.var_CBFA = var_04;
				}
				else if(var_04.script_noteworthy == "collision")
				{
					param_02.var_4381 = var_04;
				}
			}

			continue;
		}

		if(function_02A4(var_04))
		{
			if(var_04.script_noteworthy == "spawn_org")
			{
				func_FA4A(var_04,param_01,param_02);
			}
		}
	}
}

//Function Number: 13
func_FA4A(param_00,param_01,param_02)
{
	var_03 = param_02.var_10870.size;
	param_02.var_10870[var_03] = param_00;
	if(!isdefined(param_02.var_10870[var_03].var_EEBA))
	{
		param_02.var_10870[var_03].var_EEBA = 1;
	}
}

//Function Number: 14
func_F9EB(param_00,param_01,param_02)
{
	if(isdefined(param_00.script_noteworthy))
	{
		if(param_00.script_noteworthy == "left")
		{
			param_02.var_12B96 = param_00;
			return;
		}

		param_02.var_12B97 = param_00;
	}
}

//Function Number: 15
func_F927()
{
	var_00 = getent("start_vr_chamber","targetname").origin;
	var_01 = getent("start_vr_chamber","targetname").angles;
	var_02 = (11008,3712,2362);
	var_03 = (0,90,0);
	var_04 = (11235.1,3926.81,2380.24) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_01";
	var_04 = (10732.1,3453.25,2451) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_01";
	var_04 = (11284.2,3450.01,2460) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_01";
	var_04 = (10768.8,3945.5,2371.24) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_01";
	var_04 = (11281.1,3659.77,2460) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_02";
	var_04 = (10704.5,3634.39,2462) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_02";
	var_04 = (11009.5,3421.3,2461) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_03";
	var_04 = (11005,3955.25,2374.24) - var_02;
	var_05 = (270,0,0) - var_03;
	var_06 = scripts\common\createfx::func_49E7();
	var_06 scripts\common\createfx::func_F4AD(var_00 + var_04,var_01 + var_05);
	var_06.var_13125["soundalias"] = "emt_vr_hum_lp_03";
}

//Function Number: 16
func_7834(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = func_7AFE(param_00,param_01);
	foreach(var_06 in var_04)
	{
		if(!isdefined(var_06.var_EDD5))
		{
			continue;
		}

		if(var_06.var_EDD5 == param_02)
		{
			var_03[var_03.size] = var_06;
		}
	}

	return var_03;
}

//Function Number: 17
func_7835(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_05 = func_7834(param_00,param_01,param_02);
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07.var_EDE8))
		{
			continue;
		}

		if(var_07.var_EDE8 == param_03)
		{
			var_04[var_04.size] = var_07;
		}
	}

	return var_04;
}

//Function Number: 18
func_7989(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03.var_EDE8 == param_01)
		{
			return var_03;
		}
	}
}

//Function Number: 19
func_7AFE(param_00,param_01)
{
	var_02 = [];
	var_03 = scripts\common\utility::getstructarray(param_00,param_01);
	var_04 = getentarray(param_00,param_01);
	var_05 = function_00B4(param_00,param_01);
	var_06 = scripts\common\utility::array_combine(var_03,var_04);
	var_06 = scripts\common\utility::array_combine(var_05,var_06);
	foreach(var_08 in var_06)
	{
		if(isdefined(var_08))
		{
			var_02[var_02.size] = var_08;
		}
	}

	return var_02;
}