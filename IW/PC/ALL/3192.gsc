/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3192.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 103
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 12:26:30 AM
*******************************************************************/

//Function Number: 1
func_FE6A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0F3E::func_FE89();
	var_04 = lib_0F3E::func_FE64();
	self method_83CE();
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	self.var_9CBD = 1;
	lib_0F3E::func_FE97(param_01,0.7,2);
	self.var_2303.var_FECD.var_C21C--;
	self.var_9CBD = 0;
	func_85F5();
	lib_0A1A::func_2330(param_01,"shoot_finished");
}

//Function Number: 2
func_8602()
{
	if(lib_0A1B::func_2955())
	{
		return 0;
	}

	if(!lib_0A1B::func_291C())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_85F5()
{
	var_00 = randomfloatrange(0.2,0.5);
	wait(var_00);
}

//Function Number: 4
func_13F91(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_9C9D);
}

//Function Number: 5
func_13F93(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_FF88);
}

//Function Number: 6
func_13F92(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_FF83);
}

//Function Number: 7
func_13F98(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_11630);
}

//Function Number: 8
func_13F95(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_58D3);
}

//Function Number: 9
func_13F97(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_58D5);
}

//Function Number: 10
func_13F96(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_58D4);
}

//Function Number: 11
func_13F8C(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_9B78);
}

//Function Number: 12
func_13F8E(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_58CD);
}

//Function Number: 13
func_13F6F(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.var_927D))
	{
		return lib_0A1A::func_2358(param_01,"cloneGreyIdle");
	}

	return lib_0A1A::func_2358(param_01,"masterGreyIdle");
}

//Function Number: 14
func_13F71(param_00,param_01,param_02,param_03)
{
	self takeweapon("iw7_zapper_grey");
	func_15A8(self,undefined,"prop_mp_dome_shield_scr");
	func_CD46();
	level thread func_10BF0(self);
	scripts\cp\_vo::try_to_play_vo_on_all_players("quest_ufo_spawn_minialiens");
	if(!scripts\common\utility::flag("clone_complete"))
	{
		scripts\common\utility::flag_wait("clone_complete");
	}

	self.var_58CD = 0;
	func_4131();
	func_4DB1(self);
}

//Function Number: 15
func_CD46()
{
	var_00 = lib_0A1A::func_2358("duplicating_attack","idle");
	self method_82AF("duplicating_attack",var_00,1);
}

//Function Number: 16
func_10BF0(param_00)
{
	level endon("game_ended");
	scripts\common\utility::func_6E2A("clone_complete");
	func_5CF8();
	func_F5F3(param_00);
	wait(1);
	func_10721(param_00);
	func_8E85();
	func_1870();
	func_1872();
	func_1871();
	func_23D7(param_00);
	level thread func_424F();
	wait(2);
	func_516E();
	scripts\common\utility::flag_set("clone_complete");
}

//Function Number: 17
func_23D7(param_00)
{
	var_01 = func_7CDC();
	var_02 = var_01.size;
	foreach(var_08, var_04 in level.var_10850)
	{
		var_04 method_834E("grey" + var_08 % var_02 + 1);
		foreach(var_06 in level.players)
		{
			var_04 getenemyinfo(var_06);
		}
	}

	foreach(var_0A, var_06 in var_01)
	{
		var_06 method_834E("player" + var_0A + 1);
	}
}

//Function Number: 18
func_8E85()
{
	foreach(var_01 in level.var_10850)
	{
		var_01 notify("update_mobile_shield_visibility",0);
	}
}

//Function Number: 19
func_7CDC()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_02))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 20
func_818D(param_00,param_01,param_02)
{
	var_03 = func_7B0B(param_00.origin);
	var_04 = func_7B0A(param_00 getplayerangles(),param_00.origin,func_7813(param_00,param_01),param_02);
	return func_7B09(param_00,var_03,var_04);
}

//Function Number: 21
func_7813(param_00,param_01)
{
	var_02 = 360 / param_01;
	var_03 = param_00.angles;
	var_04 = [];
	for(var_05 = 0;var_05 < param_01;var_05++)
	{
		var_04[var_04.size] = var_02 / 2 + var_05 * var_02;
	}

	return var_04;
}

//Function Number: 22
func_7B36(param_00)
{
	return param_00.var_C1F4;
}

//Function Number: 23
func_10721(param_00)
{
	level endon("game_ended");
	var_01 = func_7B36(param_00);
	func_F426(param_00,1);
	for(var_02 = 0;var_02 < var_01 - 1;var_02++)
	{
		var_03 = scripts\mp\_mp_agent::func_108E8("zombie_grey","axis",param_00.origin,param_00.angles);
		if(isdefined(var_03))
		{
			func_F426(var_03,1);
			func_F3E7(var_03);
			func_F5E8(var_03);
			func_F5F3(var_03);
			func_4644(var_03,param_00);
			func_463D(var_03,param_00);
		}
	}
}

//Function Number: 24
func_F426(param_00,param_01)
{
	param_00.var_9B78 = param_01;
}

//Function Number: 25
func_F5F3(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("tag_origin");
	var_01.angles = vectortoangles((0,0,1));
	var_01 linkto(param_00,"tag_origin");
	var_01 thread func_CD2C(var_01,param_00);
	var_01 thread func_13340(var_01,param_00);
	if(!isdefined(level.var_85EB))
	{
		level.var_85EB = [];
	}

	level.var_85EB[level.var_85EB.size] = var_01;
}

//Function Number: 26
func_516E()
{
	foreach(var_01 in level.var_85EB)
	{
		killfxontag(level._effect["zombie_grey_start_duplicate"],var_01,"tag_origin");
		var_01 delete();
	}

	level.var_85EB = [];
}

//Function Number: 27
func_CD2C(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	wait(0.2);
	playfxontag(level._effect["zombie_grey_start_duplicate"],param_00,"tag_origin");
}

//Function Number: 28
func_13340(param_00,param_01)
{
	param_00 endon("death");
	param_01 waittill("death");
	killfxontag(level._effect["zombie_grey_start_duplicate"],param_00,"tag_origin");
	param_00 delete();
}

//Function Number: 29
func_F3E7(param_00)
{
	foreach(var_02 in param_00.var_269C)
	{
		var_02 hide();
	}

	param_00 notify("stop_health_light_monitor");
	param_00.var_927D = 1;
	param_00.var_10AB7 = 1;
	param_00.desiredenemydistmax = 60;
	param_00.meleerangesq = 90000;
	param_00.strafeifwithindist = param_00.desiredenemydistmax + 100;
	param_00 setmodel("park_alien_gray_small");
}

//Function Number: 30
func_4131()
{
	foreach(var_01 in level.var_10850)
	{
		func_F426(var_01,0);
		wait(1);
	}
}

//Function Number: 31
func_1870()
{
	foreach(var_01 in level.var_10850)
	{
		var_01.health = level.var_424E;
	}
}

//Function Number: 32
func_1872()
{
	foreach(var_01 in level.var_10850)
	{
		func_F3E9(var_01,1);
	}
}

//Function Number: 33
func_F3E9(param_00,param_01)
{
	if(isdefined(param_00.var_BCD6))
	{
		param_00.var_D8A4 = param_00.var_BCD6;
	}

	param_00.var_BCD6 = param_01;
}

//Function Number: 34
func_E2FB(param_00)
{
	if(isdefined(param_00.var_D8A4))
	{
		param_00.var_BCD6 = param_00.var_D8A4;
		return;
	}

	param_00.var_BCD6 = undefined;
}

//Function Number: 35
func_1871()
{
	foreach(var_01 in level.var_10850)
	{
		func_F3E8(var_01,90000);
	}
}

//Function Number: 36
func_F3E8(param_00,param_01)
{
	param_00.var_D8A3 = param_00.meleerangesq;
	param_00.meleerangesq = param_01;
}

//Function Number: 37
func_E2FA(param_00)
{
	param_00.meleerangesq = param_00.var_D8A3;
}

//Function Number: 38
func_424F()
{
	wait(0.1);
	var_00 = ["jump_left","jump_right","jump_back","jump_left"];
	foreach(var_03, var_02 in level.var_10850)
	{
		var_02 thread func_CE3B(var_02,var_00[var_03]);
	}
}

//Function Number: 39
func_CE3B(param_00,param_01)
{
	param_00 endon("death");
	var_02 = "duplicating_attack";
	var_03 = lib_0A1A::func_2358(var_02,param_01);
	param_00 scripts\mp\agents\_scriptedagents::func_CED5(var_02,var_03,var_02,"end");
	param_00 func_CD46();
}

//Function Number: 40
func_13F72(param_00,param_01,param_02,param_03)
{
	self notify("grey play regen");
	self setscriptablepartstate("backpack_dome_shield","off");
	self setscriptablepartstate("regen_beam","on");
	self.actually_doing_regen = 1;
	lib_0A1D::func_235F(param_00,param_01,param_02,1,0);
}

//Function Number: 41
func_13F70(param_00,param_01,param_02,param_03)
{
	self setscriptablepartstate("backpack_dome_shield","on");
	self setscriptablepartstate("regen_beam","off");
}

//Function Number: 42
func_13F73(param_00,param_01,param_02,param_03)
{
	thread func_CE0A(self);
	lib_0A1D::func_2367(param_00,param_01,param_02,"end");
}

//Function Number: 43
func_13F74(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_2367(param_00,param_01,param_02,"early_end");
	lib_0A1A::func_2330(param_01,"early_end");
}

//Function Number: 44
func_13F76(param_00,param_01,param_02,param_03)
{
	self playsound("grey_shockwave_build");
	lib_0A1D::func_2367(param_00,param_01,param_02,"shock_wave_damage");
	self notify("shockwave_deploy");
	self notify("update_mobile_shield_visibility",1);
	self playsound("grey_shockwave");
	func_FE53(self);
}

//Function Number: 45
func_3EDC(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.var_927D))
	{
		return lib_0A1A::func_2358(param_01,"mini_grey_melee");
	}

	return lib_0A1A::func_2358(param_01,"master_grey_melee");
}

//Function Number: 46
func_13F75(param_00,param_01,param_02,param_03)
{
	func_15A8(self,undefined,"prop_mp_dome_shield_scr");
	lib_0A1D::func_2367(param_00,param_01,param_02,"start_summon_zombies");
	thread func_111C2(self);
	lib_0A1D::func_2367(param_00,param_01,param_02,"early_end");
	func_4DB1(self);
}

//Function Number: 47
func_111C2(param_00)
{
	func_12865(6);
	var_01 = func_818D(param_00,6,128);
	foreach(var_03 in var_01)
	{
		level thread func_111C0(var_03,0);
	}
}

//Function Number: 48
func_111C0(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_02.var_EE79 = "ground_spawn_no_boards";
	var_02.var_ECF5 = "spawn_ground";
	var_03 = var_02 scripts\cp\zombies\zombies_spawning::func_1081B("generic_zombie",1);
	if(isdefined(var_03))
	{
		if(scripts\common\utility::istrue(param_01))
		{
			var_03 method_8282(0,1);
		}

		var_04 = spawnfx(level._effect["summon_zombie_energy_ring"],param_00 + (0,0,-11),(0,0,1),(1,0,0));
		playsoundatpos(param_00 + (0,0,-11),"zmb_grey_energy_ring_activate");
		var_05 = thread scripts\common\utility::play_loopsound_in_space("zmb_grey_energy_ring_activate_lp",param_00 + (0,0,-11));
		triggerfx(var_04);
		var_03 scripts\common\utility::waittill_any_3("death","intro_vignette_done");
		if(scripts\common\utility::istrue(param_01) && isdefined(var_03))
		{
			var_03 method_8282(1,1);
		}

		playsoundatpos(param_00 + (0,0,-11),"zmb_grey_energy_ring_deactivate");
		var_05 stoploopsound();
		var_04 delete();
		wait(0.05);
		var_05 delete();
	}
}

//Function Number: 49
func_12865(param_00)
{
	var_01 = scripts\common\utility::func_116D7(isdefined(level.spawned_enemies),level.spawned_enemies.size,0);
	var_02 = 24 - var_01;
	if(var_02 < param_00)
	{
		var_03 = param_00 - var_02;
		scripts\cp\zombies\zombies_spawning::func_A5FA(var_03);
	}
}

//Function Number: 50
func_CE0A(param_00)
{
	var_01 = (0,0,150);
	var_02 = (0,0,15);
	var_03 = param_00.origin + var_02;
	var_04 = spawnfx(level._effect["zombie_grey_shockwave_begin"],var_03);
	triggerfx(var_04);
	param_00 thread func_5D40(param_00,param_00.origin + var_01,var_03);
	var_05 = param_00 scripts\common\utility::func_13734("shockwave_deploy");
	var_04 delete();
	if(isdefined(var_05) && var_05 == "shockwave_deploy")
	{
		playfx(level._effect["zombie_grey_shockwave_deploy"],var_03);
	}
}

//Function Number: 51
func_5D40(param_00,param_01,param_02)
{
	var_03 = 0.2;
	var_04 = func_7D01(param_00,"regen_pain_in","end");
	var_05 = func_7D01(param_00,"regen_pain_loop","early_end");
	var_06 = func_7D01(param_00,"shockwave","shock_wave_damage");
	var_07 = var_04 + var_05 + var_06;
	var_08 = spawn("script_model",param_01);
	var_08 setmodel("tag_origin");
	wait(var_03);
	playfxontag(level._effect["zombie_grey_teleport_trail"],var_08,"tag_origin");
	var_08 moveto(param_02,var_07 - var_03);
	scripts\common\utility::func_1372B(var_08,"movedone",param_00,"death");
	var_08 delete();
}

//Function Number: 52
func_7D01(param_00,param_01,param_02)
{
	var_03 = param_00 method_80FD(param_01,0);
	var_04 = getnotetracktimes(var_03,param_02);
	var_05 = getanimlength(var_03);
	var_06 = var_04[0] * var_05;
	return var_06;
}

//Function Number: 53
func_FE53(param_00)
{
	foreach(var_02 in level.players)
	{
		if(distancesquared(param_00.origin,var_02.origin) > 22500)
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(var_02))
		{
			continue;
		}

		var_03 = var_02.health;
		var_04 = int(var_03 * 0.9);
		var_02 dodamage(var_04,param_00.origin);
		scripts\mp\agents\zombie_grey\zombie_grey_agent::func_85F8(param_00,var_02);
	}
}

//Function Number: 54
func_13F79(param_00,param_01,param_02,param_03)
{
	self.var_DDC6 = [];
	var_04 = self.origin;
	var_05 = func_7CED(self);
	if(isdefined(var_05))
	{
		var_06 = func_7CEF(self,var_05);
		if(isdefined(var_06))
		{
			func_57CD(self,var_06,var_05);
			func_1164C(self,get_teleport_end_pos(var_04),"teleport_summon");
			lib_0C2E::func_F49B(self);
			lib_0C2E::set_next_melee_time(self);
			lib_0A1B::func_2914();
		}
	}

	self.var_58D5 = 0;
}

//Function Number: 55
func_13F78(param_00,param_01,param_02,param_03)
{
	var_04 = func_7CEC(self);
	if(isdefined(var_04))
	{
		var_05 = func_7CEB(var_04);
		if(isdefined(var_05))
		{
			func_1164C(self,var_05,"teleport_dash");
			lib_0C2E::func_F49A(self);
			lib_0C2E::set_next_melee_time(self);
			lib_0A1B::func_2914();
		}
	}

	self.var_58D4 = 0;
}

//Function Number: 56
func_13F77(param_00,param_01,param_02,param_03)
{
	self notify("update_mobile_shield_visibility",0);
	self.var_DDC6 = [];
	self.var_8B73 = 0;
	var_04 = self.origin;
	var_05 = randomintrange(2,5);
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_07 = func_7CEA(self);
		if(isdefined(var_07))
		{
			var_08 = func_7CEF(self,var_07);
			if(isdefined(var_08))
			{
				func_57CC(self,var_08,var_07);
			}
		}
	}

	if(self.var_8B73)
	{
		func_1164C(self,get_teleport_end_pos(var_04),"teleport_attack");
		lib_0C2E::func_F499(self);
		lib_0C2E::set_next_melee_time(self);
		lib_0A1B::func_2914();
	}

	self notify("update_mobile_shield_visibility",1);
	self.var_58D3 = 0;
}

//Function Number: 57
get_teleport_end_pos(param_00)
{
	if(clear_from_players(param_00))
	{
		return param_00;
	}

	var_01 = "ufo_zombie_spawn_loc";
	var_02 = 300;
	var_03 = scripts\common\utility::getstructarray(var_01,"targetname");
	var_03 = scripts\common\utility::func_782F(param_00,var_03,undefined,undefined,undefined,var_02);
	foreach(var_05 in var_03)
	{
		var_06 = scripts\common\utility::func_5D14(var_05.origin,5,-50);
		if(clear_from_players(var_06))
		{
			return var_06;
		}
	}

	return param_00;
}

//Function Number: 58
clear_from_players(param_00)
{
	var_01 = 10000;
	foreach(var_03 in level.players)
	{
		if(distancesquared(var_03.origin,param_00) < var_01)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 59
func_57CD(param_00,param_01,param_02)
{
	param_01.var_9B8C = 1;
	param_00.var_11643 = param_02;
	param_00 func_1164C(param_00,param_01.origin,"teleport_summon",param_00.var_11643);
	param_00 func_CECC("teleport_summon","summon",::func_11642);
	param_01.var_9B8C = 0;
}

//Function Number: 60
func_57CC(param_00,param_01,param_02)
{
	param_01.var_9B8C = 1;
	param_00.var_8B73 = 1;
	param_00.var_11618 = param_02;
	param_00 func_1164C(param_00,param_01.origin,"teleport_attack",param_00.var_11618);
	param_00 func_CECC("teleport_attack","attack",::func_11617);
	param_01.var_9B8C = 0;
}

//Function Number: 61
func_1164C(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_00.origin,param_01);
	var_05 = var_04 / 4000;
	var_06 = spawn("script_model",param_00.origin);
	var_06 setmodel("tag_origin");
	param_00 playsoundonmovingent("grey_teleport_start");
	var_06 thread func_4104(param_00,var_06);
	param_00 setscriptablepartstate("teleport_attack_trail","on");
	param_00 func_CECC(param_02,"start");
	param_00 linkto(var_06);
	var_06 moveto(param_01,var_05);
	var_06 waittill("movedone");
	param_00 playsound("grey_teleport_end");
	if(isdefined(param_03))
	{
		param_03 thread scripts\cp\_vo::try_to_play_vo("quest_ufo_alien_teleport","zmb_comment_vo","low",3,0,0,1,5);
	}

	param_00 unlink();
	var_06 delete();
	param_00 setscriptablepartstate("teleport_attack_trail","off");
	param_00 func_CECC(param_02,"end");
}

//Function Number: 62
func_4104(param_00,param_01)
{
	param_01 endon("death");
	param_00 waittill("death");
	param_01 delete();
}

//Function Number: 63
func_CECC(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_2358(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED5(param_00,var_03,param_00,"end",param_02);
}

//Function Number: 64
func_11617(param_00,param_01,param_02,param_03)
{
	if(param_00 == "fire")
	{
		var_04 = self getplayerangles();
		var_05 = anglestoforward(var_04);
		var_06 = self.origin + (0,0,60) + var_05 * 20;
		magicbullet("zmb_grey_teleport_attack",var_06,self.var_11618.origin);
	}
}

//Function Number: 65
func_11642(param_00,param_01,param_02,param_03)
{
	if(param_00 == "start_summon_zombies")
	{
		if(isdefined(self.var_11643) && !scripts\common\utility::istrue(self.var_11643.in_afterlife_arcade))
		{
			func_12865(6);
			var_04 = func_818D(self.var_11643,6,128);
			foreach(var_06 in var_04)
			{
				level thread func_111C0(var_06,1);
				wait(randomfloatrange(0.1,0.9));
			}
		}
	}
}

//Function Number: 66
func_7CED(param_00)
{
	if(isdefined(param_00.var_11539) && !scripts\common\utility::istrue(param_00.var_11539.in_afterlife_arcade))
	{
		return param_00.var_11539;
	}

	return undefined;
}

//Function Number: 67
func_7CEC(param_00)
{
	if(isdefined(param_00.var_11539) && !scripts\cp\_laststand::player_in_laststand(param_00.var_11539))
	{
		return param_00.var_11539;
	}

	return undefined;
}

//Function Number: 68
func_7CEA(param_00)
{
	return param_00.var_11539;
}

//Function Number: 69
func_7CEB(param_00)
{
	var_01 = 8;
	var_02 = func_818D(param_00,var_01,256);
	var_02 = [var_02[0],var_02[var_02.size - 1]];
	var_02 = scripts\common\utility::array_randomize(var_02);
	var_02 = func_12637(var_02);
	var_02 = scripts\common\utility::func_782F(param_00.origin,var_02);
	return var_02[var_02.size - 1].origin;
}

//Function Number: 70
func_12637(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = spawnstruct();
		var_04.origin = var_03;
		var_01[var_01.size] = var_04;
	}

	return var_01;
}

//Function Number: 71
func_7CEF(param_00,param_01)
{
	var_02 = scripts\common\utility::func_782F(param_01.origin,level.var_85F2,undefined,level.var_85F2.size,1400,200);
	var_03 = undefined;
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(scripts\common\utility::istrue(var_05.var_9B8C))
		{
			continue;
		}

		if(distancesquared(param_00.origin,var_05.origin) < 250000)
		{
			continue;
		}

		if(scripts\common\utility::func_2286(param_00.var_DDC6,var_05))
		{
			continue;
		}

		if(!sighttracepassed(var_05.origin + (0,0,60),param_01 geteye(),0,param_00) && !sighttracepassed(var_05.origin + (0,0,60),param_01.origin,0,param_00))
		{
			continue;
		}

		var_03 = var_05;
		param_00.var_DDC6 = scripts\common\utility::array_add(param_00.var_DDC6,var_03);
		break;
	}

	return var_03;
}

//Function Number: 72
func_13F7A(param_00,param_01,param_02,param_03)
{
	self notify("update_mobile_shield_visibility",0);
	var_04 = self.origin;
	var_05 = (650,625,100);
	self setorigin(var_05);
	var_06 = func_85F4(var_04);
	var_07 = self.var_11630;
	var_08 = func_7B0B(var_07.origin);
	var_09 = func_7B0A(var_07 getplayerangles(),var_07.origin,func_7CE9(),350);
	var_0A = func_7CEE(self,var_08,var_09);
	func_85F3(var_06,var_0A);
	self setorigin(var_0A);
	self.angles = vectortoangles(var_07.origin - self.origin);
	self show();
	self notify("update_mobile_shield_visibility",1);
	self.var_11630 = undefined;
}

//Function Number: 73
func_7CE9()
{
	var_00 = scripts\common\utility::array_randomize([10,350]);
	var_01 = scripts\common\utility::array_randomize([20,340]);
	var_02 = scripts\common\utility::array_randomize([30,330]);
	var_03 = [];
	var_03 = scripts\common\utility::array_combine(var_03,var_00);
	var_03 = scripts\common\utility::array_combine(var_03,var_01);
	var_03 = scripts\common\utility::array_combine(var_03,var_02);
	return var_03;
}

//Function Number: 74
func_7B0A(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	foreach(var_06 in param_02)
	{
		var_07 = (param_00[0],param_00[1] + var_06,param_00[2]);
		var_08 = anglestoforward(var_07);
		var_09 = param_01 + var_08 * param_03;
		var_09 = scripts\common\utility::func_5D14(var_09,200,-200);
		var_04[var_04.size] = var_09;
	}

	return var_04;
}

//Function Number: 75
func_7B0B(param_00)
{
	var_01 = scripts\common\utility::func_5D14(param_00,0,-200);
	var_02 = getclosestpointonnavmesh(var_01);
	if(var_01 == var_02)
	{
		return var_02;
	}

	var_03 = vectornormalize(var_02 - var_01);
	var_04 = var_02 + var_03;
	return getclosestpointonnavmesh(var_04);
}

//Function Number: 76
func_7B09(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_02)
	{
		var_06 = navtrace(param_01,var_05,param_00,1);
		var_03[var_03.size] = var_06["position"];
	}

	return var_03;
}

//Function Number: 77
func_7CEE(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = -1;
	foreach(var_06 in param_02)
	{
		var_07 = navtrace(param_01,var_06,param_00,1);
		var_08 = var_07["fraction"];
		if(var_08 > var_04)
		{
			var_03 = var_07["position"];
			var_04 = var_08;
		}
	}

	return var_03;
}

//Function Number: 78
func_85F4(param_00)
{
	playfx(level._effect["zombie_grey_teleport"],param_00);
	var_01 = spawn("script_model",param_00);
	var_01 setmodel("tag_origin");
	wait(0.2);
	playfxontag(level._effect["zombie_grey_teleport_trail"],var_01,"tag_origin");
	var_01 moveto((648,654,326),2,2);
	var_01 waittill("movedone");
	wait(1);
	return var_01;
}

//Function Number: 79
func_85F3(param_00,param_01)
{
	var_02 = spawnfx(level._effect["zombie_grey_teleport_trail"],param_01);
	triggerfx(var_02);
	param_00 moveto(param_01,1,1);
	param_00 waittill("movedone");
	param_00 delete();
	var_02 delete();
	playfx(level._effect["zombie_grey_teleport"],param_01);
}

//Function Number: 80
func_15A8(param_00,param_01,param_02)
{
	param_01 = scripts\common\utility::func_116D7(isdefined(param_01),param_01,(0,0,0));
	var_03 = spawn("script_model",param_00.origin + param_01);
	var_03 setmodel(param_02);
	playsoundatpos(param_00.origin + param_01,"grey_bubbleshield_start");
	var_03 thread setpartstates(param_00,var_03);
	var_03 thread func_58F8(var_03,param_00);
	var_04 = spawn("script_model",param_00.origin + param_01);
	var_04 setmodel("prop_mp_domeshield_col");
	var_04 thread func_58F8(var_04,param_00);
	param_00.var_58F7 = var_03;
	param_00.var_58F9 = var_04;
}

//Function Number: 81
setpartstates(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	param_01 setscriptablepartstate("plant","active",0);
	wait(0.5);
	param_01 setscriptablepartstate("plant","neutral",0);
	param_01 setscriptablepartstate("armed","active",0);
}

//Function Number: 82
func_4DB1(param_00)
{
	playsoundatpos(param_00.origin,"grey_bubbleshield_end");
	param_00.var_58F7 delete();
	param_00.var_58F9 delete();
}

//Function Number: 83
func_58F8(param_00,param_01)
{
	playsoundatpos(param_01.origin,"grey_bubbleshield_end");
	param_00 endon("death");
	param_01 waittill("death");
	param_00 delete();
}

//Function Number: 84
func_F5E8(param_00)
{
	if(!isdefined(level.var_10850))
	{
		level.var_10850 = [];
	}

	param_00.var_1491.var_E5DE = 3;
	param_00.entered_playspace = 1;
	param_00.var_9CA2 = 1;
	level.spawned_enemies[level.spawned_enemies.size] = param_00;
	level.var_10850[level.var_10850.size] = param_00;
}

//Function Number: 85
func_85FE(param_00,param_01,param_02,param_03)
{
	level.var_85EE = 1;
	self setscriptablepartstate("spawn_beam","on");
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 86
func_85FD(param_00,param_01,param_02,param_03)
{
	self setscriptablepartstate("spawn_beam","on");
	lib_0A1D::func_235F(param_00,param_01,param_02,1,0);
}

//Function Number: 87
func_85F7(param_00,param_01,param_02,param_03)
{
	self setscriptablepartstate("spawn_beam","off");
}

//Function Number: 88
func_8601(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.var_FF9F);
}

//Function Number: 89
func_85FF(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1B::func_2925();
	if(!isdefined(var_04))
	{
		self method_8289("face angle abs",self.angles);
	}
	else if(isplayer(var_04) && isdefined(self.var_10C) && var_04 == self.var_10C)
	{
		self method_8289("face enemy");
	}
	else
	{
		var_05 = var_04.origin - self.origin;
		var_06 = vectornormalize(var_05);
		var_07 = vectortoangles(var_06);
		self method_8289("face angle abs",var_07);
	}

	var_08 = scripts\common\utility::func_116D7(isdefined(self.var_BCD6),self.var_BCD6,1);
	var_09 = func_3EDC(param_00,param_01,param_03);
	self method_82AF(param_01,var_09,var_08);
	self endon(param_01 + "_finished");
	func_58BB(param_00,param_01);
	lib_0A1B::func_2914();
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 90
func_58BB(param_00,param_01)
{
	for(;;)
	{
		self waittill(param_01,var_02);
		if(!isarray(var_02))
		{
			var_02 = [var_02];
		}

		foreach(var_04 in var_02)
		{
			switch(var_04)
			{
				case "early_end":
				case "end":
					break;
	
				case "stop":
					var_05 = lib_0A1B::func_2925();
					if(!isdefined(var_05))
					{
						return;
					}
		
					if(!isalive(var_05))
					{
						return;
					}
		
					var_06 = distancesquared(var_05.origin,self.origin);
					if(var_06 > self.meleerangesq)
					{
						return;
					}
					break;
	
				case "start_melee":
				case "fire":
					var_05 = lib_0A1B::func_2925();
					if(!isdefined(var_05))
					{
						return;
					}
		
					if(isalive(var_05))
					{
						if(scripts\common\utility::istrue(self.var_927D))
						{
							func_B787(self,var_05);
						}
						else
						{
							lib_0C35::func_CA1F(var_05);
						}
					}
					break;
	
				default:
					lib_0A1D::func_2345(var_04,param_01);
					break;
			}
		}
	}
}

//Function Number: 91
func_B787(param_00,param_01)
{
	if(!func_FF46(param_00,param_01))
	{
		return;
	}

	if(!func_9B68(param_00))
	{
		var_02 = scripts\common\utility::func_5D14(self.origin,5,-50);
		var_03 = scripts\common\utility::func_5D14(param_01.origin,5,-50);
		var_04 = func_7C62();
		var_05 = var_02 + var_04;
		var_06 = var_03 + var_04;
		level thread func_6D07(var_05,700,2,var_06 - var_05,0);
	}
}

//Function Number: 92
func_FF46(param_00,param_01)
{
	if(!isalive(param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 93
func_9B68(param_00)
{
	var_01 = getentarray("mini_grey_shock_arc_trigger","targetname");
	foreach(var_03 in var_01)
	{
		if(scripts\common\utility::istrue(var_03.var_93A8) && distancesquared(param_00.origin,var_03.origin) < 640000)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 94
func_7C62()
{
	var_00 = [(0,0,20),(0,0,60)];
	return scripts\common\utility::random(var_00);
}

//Function Number: 95
func_6D07(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 125;
	var_06 = func_7AE5();
	if(!isdefined(var_06))
	{
		return;
	}

	param_03 = vectornormalize(param_03);
	var_06.origin = param_00;
	var_06.angles = func_7827(param_03,param_04);
	var_07 = int(param_02 * 20);
	var_08 = param_01 / var_07;
	var_06 thread func_FE3A(var_06);
	for(var_09 = 0;var_09 < var_07;var_09++)
	{
		var_0A = var_06.origin;
		var_0B = anglestoforward(var_06.angles);
		var_06.origin = var_0A + param_03 * var_08;
		var_0C = var_0B * var_05;
		var_0D = var_0A + var_0C;
		var_0E = var_0A - var_0C;
		function_02E0(level._effect["zombie_mini_grey_shock_arc"],var_0D,vectortoangles(var_0E - var_0D),var_0E);
		scripts\common\utility::func_136F7();
	}

	var_06.origin = var_06.var_C726;
	var_06.var_93A8 = 0;
	var_06 notify("stop_shock_arc_trigger_monitor");
}

//Function Number: 96
func_7827(param_00,param_01)
{
	var_02 = vectortoangles(param_00);
	switch(param_01)
	{
		case 0:
			var_03 = anglestoright(var_02);
			return vectortoangles(var_03);

		case 45:
			var_04 = anglestoright(var_03);
			var_05 = anglestoup(var_03);
			var_06 = var_04 + var_05;
			return vectortoangles(var_06);

		case 90:
			var_07 = anglestoup(var_06);
			return vectortoangles(var_07);

		case 135:
			var_08 = function_02D3(var_07);
			var_05 = anglestoup(var_07);
			var_06 = var_07 + var_08;
			return vectortoangles(var_08);
	}
}

//Function Number: 97
func_FE3A(param_00)
{
	param_00 endon("stop_shock_arc_trigger_monitor");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(func_37FC(var_01))
		{
			var_01 dodamage(60,param_00.origin);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 98
func_7AE5()
{
	var_00 = getentarray("mini_grey_shock_arc_trigger","targetname");
	foreach(var_02 in var_00)
	{
		if(scripts\common\utility::istrue(var_02.var_93A8))
		{
			continue;
		}

		var_02.var_C726 = var_02.origin;
		var_02.var_93A8 = 1;
		return var_02;
	}

	return undefined;
}

//Function Number: 99
func_37FC(param_00)
{
	var_01 = gettime();
	if(!isdefined(param_00.var_D8A5))
	{
		param_00.var_D8A5 = 0;
	}

	if(var_01 - param_00.var_D8A5 < 1000)
	{
		return 0;
	}

	param_00.var_D8A5 = var_01;
	return 1;
}

//Function Number: 100
func_5F35(param_00)
{
	level notify("grey_duplicating_attack_timer");
	level endon("grey_duplicating_attack_timer");
	level endon("grey_duplicating_attack_end");
	wait(420);
	scripts\mp\agents\zombie_grey\zombie_grey_agent::try_merge_clones();
}

//Function Number: 101
func_4644(param_00,param_01)
{
	param_00.var_15B5 = param_01.var_15B5;
	param_00.var_4C17 = param_01.var_4C17;
	param_00.var_B43F = param_01.var_B43F;
	param_00.var_B748 = param_01.var_B748;
	param_00.var_8CAA = param_01.var_8CAA;
	param_00.var_1272C = param_01.var_1272C;
	param_00.var_8CB2 = param_01.var_8CB2;
}

//Function Number: 102
func_463D(param_00,param_01)
{
	param_01.var_269D = [];
	foreach(var_03 in param_01.var_269C)
	{
		param_01.var_269D[param_01.var_269D.size] = var_03.var_113E0;
	}

	param_00.var_269D = param_01.var_269D;
}

//Function Number: 103
func_5CF8()
{
	scripts\common\utility::flag_set("force_drop_max_ammo");
}