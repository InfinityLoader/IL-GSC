/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\maps\europa\europa_outro.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 1427 ms
 * Timestamp: 10/27/2023 12:23:05 AM
*******************************************************************/

//Function Number: 1
func_C7C6()
{
	setdvarifuninitialized("outro_nohelmet","0");
	setdvarifuninitialized("new_dof","1");
	var_00 = getent("nrg_weapon","targetname");
	var_00 delete();
	precachemodel("vm_hero_protagonist_helmet_glass_crack_clear");
	precachemodel("vm_hero_protagonist_helmet_glass_crack_01_clear");
	precachemodel("vm_hero_protagonist_helmet_glass_crack_02_clear");
	precachemodel("vm_hero_protagonist_helmet_glass_crack_03_clear");
	precachemodel("veh_mil_air_ca_olympus_mons");
	precachemodel("veh_mil_air_ca_olympus_mons_detail_01");
	precachemodel("oxygen_bottle_air_boss");
	precachemodel("helmet_hero_sipes_crushed");
	precachemodel("helmet_hero_t_crushed");
	thread func_FC0E();
	level._effect["kotch_muzzleflash"] = loadfx("vfx/iw7/core/muzflash/emc/vfx_muz_emc_v.vfx");
	var_01 = [];
	var_01[var_01.size] = getent("outro_dropship_static","targetname");
	var_01[var_01.size] = getent("outro_mons","targetname");
	var_02 = getent("outro_tram_brushmodel","targetname");
	var_01[var_01.size] = var_02;
	var_01 = scripts\common\utility::array_combine(var_01,getentarray(var_02.target,"targetname"));
	foreach(var_04 in var_01)
	{
		var_04 hide();
		var_04 notsolid();
	}

	scripts\common\utility::flag_init("outro_freeze");
	scripts\common\utility::flag_init("helmet_critical_paused");
	scripts\common\utility::flag_init("pause_dynamic_dof");
	thread func_94FB();
}

//Function Number: 2
func_C7D3()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	level.player method_83B7();
	level.player setclientomnvar("ui_hide_hud",1);
	scripts\common\utility::flag_set("start_decompress_player");
	setdvar("skip_outro","0");
	var_00 = scripts\sp\_hud_util::func_7B4F();
	var_00.alpha = 1;
	level.player method_82C0("europa_suck_out_hit_fade_to_black",0);
	function_01BA("");
	scripts\common\utility::flag_set("player_holding_on");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"done",&"EUROPA_OBJECTIVE_ACCESS");
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"done",&"EUROPA_OBJECTIVE_FSPAR");
	thread scripts\sp\maps\europa\europa_util::func_67B6(3,"current",&"EUROPA_OBJECTIVE_ESCAPE");
}

//Function Number: 3
func_94FB()
{
	var_00 = scripts\common\utility::array_combine(getentarray("europa_lights_outro_1","targetname"),getentarray("europa_lights_outro_2","targetname"));
	if(!var_00.size)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		var_02.var_99E5 = var_02 method_8134();
		var_02.color = var_02 method_8131();
		var_02 setlightintensity(0);
	}
}

//Function Number: 4
func_6222()
{
	var_00 = scripts\common\utility::array_combine(getentarray("europa_lights_outro_1","targetname"),getentarray("europa_lights_outro_2","targetname"));
	if(!var_00.size)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_99E5))
		{
			var_02 setlightintensity(var_02.var_99E5);
			continue;
		}

		if(isdefined(self.var_EDED))
		{
			var_02 setlightintensity(var_02.var_EDED);
		}
	}
}

//Function Number: 5
func_C7B4()
{
	wait(2.5);
	setomnvar("ui_show_compass",0);
	scripts\common\utility::func_5127(0.6,::func_6222);
	function_0237("europa_outro",1);
	var_00 = getdvarint("skip_outro");
	scripts\sp\_utility::func_28D7();
	physics_setgravity((0,0,-386.09));
	thread func_ABE1();
	function_01C5("r_mbRadialoverridechromaticAberration",0);
	function_01C5("r_mbradialoverridestrength",0);
	function_02A9("storm","storm_ext",1);
	function_02A9("atmosphere","helmet",1);
	scripts\common\utility::exploder("outro_amb_fx");
	var_01 = getent("intro_surface_vista_01","targetname");
	var_01 show();
	scripts\sp\maps\europa\europa_util::func_119B1(0);
	if(getdvarint("debug_europa"))
	{
		level.var_37CE = 0;
	}

	if(!var_00)
	{
		func_11628();
		func_EBEA();
	}

	level notify("end_europa_mission");
	scripts\sp\_utility::func_BF95();
}

//Function Number: 6
func_ABE1()
{
	scripts\sp\_utility::func_1264E("europa_fatty_tr");
	wait(0.05);
	thread scripts\sp\_utility::func_BF97();
}

//Function Number: 7
func_EBEA()
{
	level.var_C7BD = [];
	function_01C5("r_mbenable","0");
	var_00 = scripts\sp\_utility::func_22CD("outro_enemies",1);
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.var_1FBB == "sdf1")
		{
			var_03 scripts\sp\_utility::func_72EC("iw7_m4","primary");
			var_03.var_1491.var_C043 = 1;
			var_01[var_01.size] = var_03;
			level.var_C7D2 = var_03;
			continue;
		}
		else if(var_03.var_1FBB == "sdf2")
		{
			var_03 scripts\sp\_utility::func_72EC("iw7_m4","primary");
			var_01[var_01.size] = var_03;
			var_03 scripts\sp\_utility::func_F6FE("vignette");
			var_03 lib_0A1E::func_2318();
			continue;
		}
		else
		{
			if(var_03.var_1FBB == "kotch")
			{
				var_03 scripts\sp\_utility::func_86E4();
				level.var_A70E = var_03;
				level.var_C7BD[level.var_C7BD.size] = var_03;
				continue;
			}

			if(var_03.var_12BA4 == "c6" || var_03.var_1FBB == "sdf4")
			{
				level.var_C7BD[level.var_C7BD.size] = var_03;
				var_03 scripts\sp\_utility::func_72EC("iw7_m4","primary");
				continue;
			}

			if(var_03.var_1FBB == "sdf3")
			{
				level.var_C7C1 = var_03;
			}
		}
	}

	foreach(var_06 in level.var_EBCA)
	{
		var_06 scripts\common\utility::func_5127(0.5,::scripts\sp\_utility::func_86E4);
	}

	var_08 = 0;
	if(scripts\sp\_utility::func_93A6())
	{
		lib_0B78::func_F52F(1);
		level.player.var_8DDA = level.var_10964.var_8DDA;
	}

	if(!var_08)
	{
		level.player.var_8DDA notsolid();
		level.player.var_8DDA method_83CB(level.player);
		level.player.var_8DDA setmodel("vm_hero_protagonist_helmet_glass_crack_01_clear");
		level.player.var_8DDA method_81E2(level.player,"tag_playerhelmet",(-2,0,0),(12,0,0),1,"view_jostle");
		lib_0E4B::func_8E0A();
	}

	var_09 = scripts\common\utility::getstruct("outro_anim_spot","targetname");
	level.player thread scripts\sp\maps\europa\europa_util::func_8E34(1);
	thread scripts\sp\maps\europa\europa_util::func_8E46(1);
	level.var_A70E attach("oxygen_bottle_air_boss","tag_accessory_right");
	thread func_C7C9();
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"lower");
	level.player.var_E505 = lib_0B62::func_7BAD(1);
	var_01[var_01.size] = level.player.var_E505;
	var_01[var_01.size] = level.var_EBBB;
	var_01[var_01.size] = level.var_EBBC;
	level.player.var_E505 setmodel("viewmodel_un_jackal_pilots_frost");
	level.player.var_8632 = spawn("script_origin",level.player.origin);
	level.player.var_8632 linkto(level.player.var_E505,"tag_player",(0,0,0),(0,0,0));
	level.player method_83B7();
	level.player method_80AA();
	level.player method_80D8(0.2,0.2);
	level.player method_8367(5,5,5,5,1);
	level.player playerlinktodelta(level.player.var_E505,"tag_player",1,0,0,0,0,1);
	var_0A = getdvarint("skip_outro_fadeup");
	var_09 lib_0B06::func_1EC1(var_01,"outro");
	if(!var_0A)
	{
		wait(1);
	}

	thread func_FB84();
	level.player method_82C0("europa_wake_up_scene",12);
	wait(8);
	thread func_912F();
	level.player scripts\common\utility::delaycall(4.5,::setclientomnvar,"ui_hide_hud",0);
	thread scripts\sp\_hud_util::func_6A99(8);
	thread func_C7BC();
	function_01BA("mx_173_cine_europaoutro");
	level.player.var_8632 = spawn("script_origin",level.player.origin);
	level.player.var_8632 linkto(level.player.var_E505,"tag_player",(0,0,0),(0,0,0));
	level.player.var_E505 thread func_D20A(var_09);
	thread func_C7D7();
	level.player method_8392(1,1,1);
	level.player method_81DF(3,1.5,1.5,20,20,20,20);
	var_09 thread lib_0B06::func_1F2C(var_01,"outro");
	scripts\common\utility::func_C0A6(112,::function_0162,3,"failed");
	scripts\common\utility::flag_wait("outro_freeze");
	level.player method_82C0("europa_end_cut_hard",0.05);
}

//Function Number: 8
func_DB9C()
{
	wait(0.05);
}

//Function Number: 9
func_912F()
{
	thread scripts\sp\_hud::func_8DFD(2,1);
	thread scripts\sp\_hud::func_8DFF(-280,1);
	level.player waittill("o2_in");
	thread scripts\sp\_hud::func_8DFD(7,10);
	level.player waittill("o2_out");
	thread scripts\sp\_hud::func_8DFD(0,1);
}

//Function Number: 10
func_C7D7()
{
	if(getdvarint("new_dof"))
	{
		thread func_BF03();
		return;
	}

	thread func_584C();
	wait(0.05);
	func_F4B0(30,0.1);
}

//Function Number: 11
func_BF03()
{
	scripts\sp\_art::func_583F(0,60,1,0,0,0,0.5);
	level.player waittill("kotch_intro");
	level waittill("kotch_kneel");
	scripts\sp\_art::func_583F(0,0,0,53,88,1.28,1);
	level waittill("look_at_friendlies");
	scripts\sp\_art::func_583D(1.5);
	level waittill("kotch_stands");
	level waittill("kotch_kneel2");
	scripts\sp\_art::func_583F(0,0,0,53,88,1.5,2);
	level.player waittill("o2_out");
	scripts\sp\_art::func_583D(0.5);
	level.player waittill("connor");
	scripts\sp\_art::func_583F(0,35,3,0,0,0,2);
}

//Function Number: 12
func_584C()
{
	level endon("stop_dof_target_thread");
	var_00 = spawn("script_origin",level.player geteye());
	level.var_584B = level.var_EBBB;
	var_01 = vectornormalize(level.var_584B gettagorigin("j_neck") - level.player geteye());
	var_00.origin = level.player geteye() + var_01 * 2;
	level.var_5840 = var_00;
	wait(5);
	var_00 thread func_5841();
	var_02 = scripts\common\utility::array_combine(level.var_C7BD,level.var_EBCA);
	for(;;)
	{
		var_03 = level.player getplayerangles();
		var_04 = level.player geteye();
		var_05 = func_77D9(level.var_584B,var_04,var_03);
		var_06 = scripts\common\utility::func_22A9(var_02,level.var_584B);
		var_07 = level.var_584B;
		foreach(var_09 in var_02)
		{
			if(!isalive(var_09))
			{
				continue;
			}

			var_0A = func_77D9(var_09,var_04,var_03);
			if(var_0A > var_05)
			{
				var_07 = var_09;
				var_05 = var_0A;
			}
		}

		level.var_584B = var_07;
		wait(0.05);
	}
}

//Function Number: 13
func_77D9(param_00,param_01,param_02)
{
	var_03 = param_00 gettagorigin("j_neck");
	var_04 = vectornormalize(var_03 - param_01);
	var_05 = anglestoforward(param_02);
	return vectordot(var_05,var_04);
}

//Function Number: 14
func_5841()
{
	level notify("stop_dof_ent_thread");
	level endon("stop_dof_ent_thread");
	var_00 = 15;
	var_01 = squared(8);
	var_02 = 1;
	for(;;)
	{
		scripts\common\utility::func_6E5A("pause_dynamic_dof");
		var_03 = level.var_584B gettagorigin("j_neck");
		var_04 = vectornormalize(var_03 - self.origin);
		if(distancesquared(self.origin,var_03) > var_01)
		{
			self.origin = self.origin + var_04 * var_00;
			var_02 = distance(self.origin,level.player geteye());
		}

		var_05 = 0;
		if(isdefined(level.var_584B) && level.var_584B == level.var_A70E)
		{
			var_05 = 1;
		}

		func_F4B0(var_02,0,var_05);
		wait(0.05);
	}
}

//Function Number: 15
func_F4B0(param_00,param_01,param_02)
{
	level endon("pause_dynamic_dof");
	var_03 = 1;
	var_04 = 0.1;
	var_05 = 0.28;
	var_06 = 0.85;
	var_07 = 1.5;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_02)
	{
		var_08 = param_00 * 0.7;
	}
	else
	{
		var_08 = param_01 * 0.2;
	}

	var_09 = param_00 * 1.15;
	if(isdefined(level.var_5844))
	{
		var_08 = var_08 * 0.5;
	}

	if(var_08 < 1)
	{
		var_08 = 1;
	}

	if(var_09 < param_00)
	{
		var_09 = param_00;
	}

	var_0A = var_08 * var_05;
	var_0B = var_09 + 150;
	scripts\sp\_art::func_583F(var_0A,var_08,var_03,var_09,var_0B,var_04,param_01);
}

//Function Number: 16
func_D20A(param_00)
{
	for(;;)
	{
		self waittill("single anim",var_01);
		if(isstring(var_01))
		{
			var_01 = [var_01];
		}

		foreach(var_03 in var_01)
		{
			switch(var_03)
			{
				case "start_anim_kotch":
					level.player notify("kotch_intro");
					func_C7BD(param_00);
					break;
	
				case "start_anim_sdf03":
					func_C7C0(param_00);
					break;
	
				case "cam_lock_on":
					func_CFA4();
					break;
	
				case "cam_lock_off":
					func_CFA5();
					break;
			}
		}
	}
}

//Function Number: 17
func_CFA4()
{
	level.player method_81DF(0.25,0.25,0,0,0,0,0);
}

//Function Number: 18
func_CFA5()
{
	level.player method_81DF(0.5,0.5,0,20,20,20,20);
}

//Function Number: 19
func_C06D()
{
	level.player method_81DF(0.5,0.5,0,20,0,20,20);
}

//Function Number: 20
func_C7BD(param_00)
{
	level.var_A70E scripts\sp\_utility::func_72EC("iw7_nrg","primary");
	level.var_A70E scripts\anim\shared::func_CC2C("iw7_nrg","left");
	var_01 = scripts\sp\_utility::func_10639("kotch_gun",level.var_A70E.origin);
	level.var_A70E.var_1FB6 = var_01;
	var_02 = level.var_C7BD;
	var_02[var_02.size] = var_01;
	scripts\common\utility::func_5127(8,::func_C06D);
	scripts\common\utility::func_5127(11,::func_CFA5);
	var_03 = scripts\sp\maps\europa\europa_util::func_5F32(param_00);
	wait(0.05);
	var_03 thread lib_0B06::func_1F2C(var_02,"outro");
}

//Function Number: 21
func_C7C0(param_00)
{
	var_01 = scripts\sp\maps\europa\europa_util::func_5F32(param_00);
	level.var_C7C1 scripts\sp\_utility::func_86E4();
	var_02 = scripts\sp\_utility::func_10639("flag");
	var_03 = [level.var_C7C1,var_02];
	var_01 thread lib_0B06::func_1F2C(var_03,"outro");
}

//Function Number: 22
func_C7C9()
{
	var_00 = getent("outro_mons","targetname");
	var_00 show();
	var_00 attach("veh_mil_air_ca_olympus_mons_detail_01","tag_origin");
	var_00 attach("veh_mil_air_ca_olympus_mons","tag_origin");
	var_01 = scripts\common\utility::getstruct(var_00.target,"targetname");
	var_00 scripts\common\utility::delaycall(15,::moveto,var_01.origin,60,0,10);
	var_00.var_5020 = "idle";
	var_00.var_501F = "idle";
	playfxontag(scripts\common\utility::getfx("mons_thrust_bottom_front_idle"),var_00,"tag_engine_bottom_front");
	playfxontag(scripts\common\utility::getfx("mons_thrust_bottom_middle_idle"),var_00,"tag_engine_bottom_front");
	playfxontag(scripts\common\utility::getfx("mons_thrust_bottom_rear_idle"),var_00,"tag_engine_bottom_rear");
	playfxontag(scripts\common\utility::getfx("mons_thrust_rear_idle"),var_00,"tag_engine_rear");
}

//Function Number: 23
func_BA4A(param_00)
{
}

//Function Number: 24
func_C7BC()
{
	var_00 = getent("outro_dropship_static","targetname");
	var_00 show();
	var_00 thread func_5E0B();
	wait(22);
	var_01 = scripts\sp\_vehicle::func_1080C("outro_dropship");
	var_01.var_55A4 = 1;
	var_01 notsolid();
	foreach(var_03 in var_01.var_B6BD)
	{
		var_03 notsolid();
	}

	wait(1);
	var_01 lib_0B98::func_845A();
}

//Function Number: 25
func_5E0B()
{
	thread func_5E0C();
	thread func_5E0E();
	var_00 = self.origin;
	var_01 = 4;
	var_02 = 5;
	var_03 = -20;
	var_04 = 20;
	var_05 = -20;
	var_06 = 20;
	var_07 = -20;
	var_08 = 20;
	for(;;)
	{
		var_09 = randomfloatrange(var_03,var_04);
		var_0A = randomfloatrange(var_05,var_06);
		var_0B = randomfloatrange(var_07,var_08);
		var_0C = var_00 + (var_09,var_0A,var_0B);
		var_0D = randomfloatrange(var_01,var_02);
		self moveto(var_0C,var_0D,var_0D * 0.5,var_0D * 0.5);
		wait(var_0D);
		var_09 = randomfloatrange(var_03,var_04);
		var_0A = randomfloatrange(var_05,var_06);
		var_0B = randomfloatrange(var_07,var_08) * -1;
		var_0C = var_00 + (var_09,var_0A,var_0B);
		var_0D = randomfloatrange(var_01,var_02);
		self moveto(var_0C,var_0D,var_0D * 0.5,var_0D * 0.5);
		wait(var_0D);
	}
}

//Function Number: 26
func_5E0C()
{
	var_00 = scripts\common\utility::getfx("axis_dropship_thrust_landed");
	var_01 = ["tag_front_thruster_1_le","tag_front_thruster_2_le","tag_front_thruster_1_ri","tag_front_thruster_2_ri"];
	var_02 = ["tag_back_thruster_1_le","tag_back_thruster_2_le","tag_back_thruster_1_ri","tag_back_thruster_2_ri"];
	var_03 = ["tag_back_thruster_3_le","tag_back_thruster_4_le","tag_back_thruster_3_ri","tag_back_thruster_4_ri"];
	var_04 = ["tag_front_thruster_1_le","tag_front_thruster_1_ri","tag_back_thruster_1_le","tag_back_thruster_1_ri"];
	func_5E0D(var_01,var_00);
	wait(0.1);
	func_5E0D(var_02,var_00);
	wait(0.1);
	func_5E0D(var_03,var_00);
	wait(0.1);
	func_5E0D(var_04,var_00);
}

//Function Number: 27
func_5E0D(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		playfxontag(param_01,self,var_03);
	}
}

//Function Number: 28
func_5E0E()
{
	var_00 = self.origin;
	var_01 = self.angles[1];
	var_02 = 0;
	var_03 = -5;
	var_04 = 5;
	var_05 = 10;
	var_06 = 15;
	for(;;)
	{
		var_07 = randomfloatrange(var_05,var_06);
		var_08 = randomfloatrange(0,var_04);
		var_09 = var_02 * -1;
		var_0A = var_08 + var_09;
		self rotateyaw(var_0A,var_07,var_07 * 0.5,var_07 * 0.5);
		var_02 = var_0A;
		wait(var_07);
		var_07 = randomfloatrange(var_05,var_06);
		var_08 = randomfloatrange(var_03,0);
		var_09 = var_02 * -1;
		var_0A = var_08 + var_09;
		self rotateyaw(var_0A,var_07,var_07 * 0.5,var_07 * 0.5);
		var_02 = var_0A;
		wait(var_07);
	}
}

//Function Number: 29
func_EBEF()
{
	var_00 = 3;
	wait(level.var_C7D5 - var_00);
	thread scripts\sp\_hud_util::func_6AA3(var_00);
	waittillframeend;
	var_01 = scripts\sp\_hud_util::func_7B4F();
	var_01.foreground = 0;
	wait(var_00);
}

//Function Number: 30
func_8E0B()
{
	level endon("outro_freeze");
	level.var_8E0F = "critical";
	var_00["critical"] = "europa_cmp_oxygenlevelcrit";
	var_00["depleted"] = "europa_cmp_oxygendepleted";
	var_00["good"] = "DONT HAVE ANYTHING!";
	var_01 = 5000;
	var_02 = "critical";
	var_03 = 0;
	var_04["critical"] = 500;
	var_04["depleted"] = 200;
	var_04["good"] = 99999;
	for(;;)
	{
		if(var_02 != level.var_8E0F)
		{
			var_02 = level.var_8E0F;
			var_01 = gettime() + 500;
			var_03 = gettime() + var_04[level.var_8E0F];
			if(level.var_8E0F == "good")
			{
				var_03 = 999999;
				var_01 = 999999;
			}
		}

		if(gettime() > var_01)
		{
			var_01 = gettime() + 6000;
			thread scripts\sp\_utility::func_10350(var_00[level.var_8E0F]);
		}

		if(gettime() > var_03)
		{
			level.player playsound("helmet_critical_beep");
			var_03 = gettime() + var_04[level.var_8E0F];
		}

		wait(0.05);
	}
}

//Function Number: 31
func_11628()
{
	var_00 = [level.player,level.var_EBBB,level.var_EBBC];
	if(level.player islinked())
	{
		level.player unlink(1);
	}

	var_01 = scripts\common\utility::getstructarray("outro_spot","targetname");
	foreach(var_03 in var_01)
	{
		foreach(var_05 in var_00)
		{
			if(isplayer(var_05) && var_03.script_noteworthy == "player")
			{
				var_05 setorigin(var_03.origin);
				var_05 setplayerangles(var_03.angles);
				var_05 freezecontrols(1);
				break;
			}
			else if(isai(var_05) && var_03.script_noteworthy == var_05.script_noteworthy)
			{
				var_05 method_80F1(var_03.origin);
				var_05 method_82EF(var_03.origin);
				break;
			}
		}
	}
}

//Function Number: 32
func_D906()
{
}

//Function Number: 33
func_FC0E()
{
	soundsettimescalefactor("scn_fx_unres_2d",0);
	soundsettimescalefactor("scn_fx_unres_3d",0);
	soundsettimescalefactor("plr_ui_ingame_unres_2d",0);
	soundsettimescalefactor("music_lr",0);
	soundsettimescalefactor("music_lsrs",0);
}

//Function Number: 34
func_FB84()
{
	var_00 = spawn("script_origin",level.player.origin);
	var_00 linkto(level.player);
	var_01 = spawn("script_origin",level.player.origin);
	var_01 linkto(level.player);
	var_00 thread func_FB47();
	var_01 thread func_FB33();
	level.player playsound("scn_europa_outro_fadeup");
	wait(13.1);
	level.player notify("o2_lvl_2");
	wait(11);
	level.player notify("o2_lvl_3");
	level.player waittill("o2_in");
	level.player playsound("scn_europa_outro_air_swt_01");
	wait(0.1);
	level.player playsound("scn_europa_outro_air_hookup");
	level.player waittill("o2_out");
	wait(0.2);
	level.player playsound("scn_europa_outro_air_detach");
	wait(8);
	level.player notify("o2_lvl_4");
}

//Function Number: 35
func_FB33()
{
	scripts\sp\_utility::func_10461("plr_helmet_air_leak_lp",1,4,1);
	level.player waittill("o2_in");
	self stoploopsound();
	level.player waittill("o2_out");
	scripts\common\utility::func_5127(11,::scripts\sp\_utility::func_10461,"plr_helmet_air_leak_lp",1,2,1);
	level.player waittill("sfx_beep_fade");
	scripts\sp\_utility::func_10460(1);
}

//Function Number: 36
func_FB47()
{
	scripts\sp\_utility::func_10461("plr_helmet_o2_level_ok_lp",1,4,1);
	wait(6);
	level.player thread scripts\sp\_utility::func_10350("europa_cmp_oxygendepleted");
	level.player waittill("o2_lvl_2");
	self stoploopsound();
	self playloopsound("plr_helmet_o2_level_low_lp");
	thread scripts\sp\_utility::func_10350("europa_cmp_oxygendepleted");
	level.player waittill("o2_lvl_3");
	thread scripts\sp\_utility::func_10350("europa_cmp_oxygenlevelcrit");
	wait(1);
	self stoploopsound();
	self playloopsound("plr_helmet_o2_level_critical_lp");
	wait(4.1);
	thread scripts\sp\_utility::func_10350("europa_cmp_oxygenlevelcrit");
	wait(8);
	thread scripts\sp\_utility::func_10350("europa_cmp_oxygenlevelcrit");
	level.player waittill("o2_in");
	self stoploopsound();
	level.player waittill("o2_out");
	wait(0.6);
	scripts\sp\_utility::func_10461("plr_helmet_o2_level_low_lp",1,2,1);
	wait(2);
	thread scripts\sp\_utility::func_10350("europa_cmp_oxygendepleted");
	level.player waittill("o2_lvl_4");
	thread scripts\sp\_utility::func_10350("europa_cmp_oxygenlevelcrit");
	self stoploopsound();
	self playloopsound("plr_helmet_o2_level_critical_lp");
	level.player waittill("sfx_beep_fade");
	scripts\sp\_utility::func_10460(1);
}