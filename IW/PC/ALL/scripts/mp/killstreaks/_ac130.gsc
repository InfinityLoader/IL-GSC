/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_ac130.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 89
 * Decompile Time: 3851 ms
 * Timestamp: 10/27/2023 12:27:59 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_153E = 40;
	func_1E73();
	level._effect["cloud"] = loadfx("vfx/misc/ac130_cloud");
	level._effect["beacon"] = loadfx("vfx/misc/ir_beacon_coop");
	level._effect["ac130_explode"] = loadfx("vfx/core/expl/aerial_explosion_ac130_coop");
	level._effect["ac130_flare"] = loadfx("vfx/misc/flares_cobra");
	level._effect["ac130_light_red"] = loadfx("vfx/core/vehicles/aircraft_light_wingtip_red");
	level._effect["ac130_light_white_blink"] = loadfx("vfx/core/vehicles/aircraft_light_white_blink");
	level._effect["ac130_light_red_blink"] = loadfx("vfx/core/vehicles/aircraft_light_red_blink");
	level._effect["ac130_engineeffect"] = loadfx("vfx/misc/jet_engine_ac130");
	level._effect["coop_muzzleflash_105mm"] = loadfx("vfx/core/muzflash/ac130_105mm");
	level._effect["coop_muzzleflash_40mm"] = loadfx("vfx/core/muzflash/ac130_40mm");
	level.var_DBFC = [];
	level.var_63AB = 0;
	level.var_A9D7 = gettime();
	level.color["white"] = (1,1,1);
	level.color["red"] = (1,0,0);
	level.color["blue"] = (0.1,0.3,1);
	level.var_46A1 = [];
	level.var_46A1["45"] = cos(45);
	level.var_46A1["5"] = cos(5);
	level.var_CB11["ac130_25mm_mp"] = 60;
	level.var_CB11["ac130_40mm_mp"] = 600;
	level.var_CB11["ac130_105mm_mp"] = 1000;
	level.var_CB10["ac130_25mm_mp"] = 0;
	level.var_CB10["ac130_40mm_mp"] = 3;
	level.var_CB10["ac130_105mm_mp"] = 6;
	level.var_13CC1["ac130_25mm_mp"] = 1.5;
	level.var_13CC1["ac130_40mm_mp"] = 3;
	level.var_13CC1["ac130_105mm_mp"] = 5;
	level.var_153D["move"] = 250;
	level.var_153D["rotate"] = 70;
	scripts\common\utility::flag_init("allow_context_sensative_dialog");
	scripts\common\utility::flag_set("allow_context_sensative_dialog");
	var_00 = getentarray("minimap_corner","targetname");
	var_01 = (0,0,0);
	if(var_00.size)
	{
		var_01 = scripts\mp\_spawnlogic::func_6CAF(var_00[0].origin,var_00[1].origin);
	}

	level.var_1537 = spawn("script_model",var_01);
	level.var_1537 setmodel("c130_zoomRig");
	level.var_1537.angles = (0,115,0);
	level.var_1537.var_222 = undefined;
	level.var_1537.var_1177A = "ac130_thermal_mp";
	level.var_1537.var_65D1 = "ac130_enhanced_mp";
	level.var_1537.var_336 = "ac130rig_script_model";
	level.var_1537 hide();
	level.var_1540 = 0;
	thread func_E72F("on");
	thread func_153C();
	thread func_C56E();
	scripts\mp\killstreaks\_killstreaks::func_DEFB("ac130",::func_128D2);
	level.var_1542 = [];
}

//Function Number: 2
func_128D2(param_00,param_01)
{
	if(isdefined(level.var_1541) || level.var_1540)
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9E68())
	{
		return 0;
	}

	scripts\mp\_utility::func_FB09("ac130");
	var_02 = scripts\mp\killstreaks\_killstreaks::func_98C2(param_01);
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			scripts\mp\_utility::func_41E9();
		}

		return 0;
	}

	var_02 = func_F62A(self);
	if(isdefined(var_02) && var_02)
	{
		level.var_1537.var_CC44.var_4824 = undefined;
		level.var_1540 = 1;
	}
	else
	{
		scripts\mp\_utility::func_41E9();
	}

	return isdefined(var_02) && var_02;
}

//Function Number: 3
func_9751()
{
	level.scr_sound["foo"]["bar"] = "";
	func_16B1("ai","in_sight",0,"ac130_fco_moreenemy");
	func_16B1("ai","in_sight",1,"ac130_fco_getthatguy");
	func_16B1("ai","in_sight",2,"ac130_fco_guymovin");
	func_16B1("ai","in_sight",3,"ac130_fco_getperson");
	func_16B1("ai","in_sight",4,"ac130_fco_guyrunnin");
	func_16B1("ai","in_sight",5,"ac130_fco_gotarunner");
	func_16B1("ai","in_sight",6,"ac130_fco_backonthose");
	func_16B1("ai","in_sight",7,"ac130_fco_gonnagethim");
	func_16B1("ai","in_sight",8,"ac130_fco_personnelthere");
	func_16B1("ai","in_sight",9,"ac130_fco_nailthoseguys");
	func_16B1("ai","in_sight",11,"ac130_fco_lightemup");
	func_16B1("ai","in_sight",12,"ac130_fco_takehimout");
	func_16B1("ai","in_sight",14,"ac130_plt_yeahcleared");
	func_16B1("ai","in_sight",15,"ac130_plt_copysmoke");
	func_16B1("ai","in_sight",16,"ac130_fco_rightthere");
	func_16B1("ai","in_sight",17,"ac130_fco_tracking");
	func_16B1("ai","in_sight",0,"ac130_fco_getthatguy");
	func_16B1("ai","in_sight",1,"ac130_fco_guymovin");
	func_16B1("ai","in_sight",2,"ac130_fco_getperson");
	func_16B1("ai","in_sight",3,"ac130_fco_guyrunnin");
	func_16B1("ai","in_sight",4,"ac130_fco_gotarunner");
	func_16B1("ai","in_sight",5,"ac130_fco_backonthose");
	func_16B1("ai","in_sight",6,"ac130_fco_gonnagethim");
	func_16B1("ai","in_sight",7,"ac130_fco_nailthoseguys");
	func_16B1("ai","in_sight",8,"ac130_fco_lightemup");
	func_16B1("ai","in_sight",9,"ac130_fco_takehimout");
	func_16B1("ai","in_sight",10,"ac130_plt_yeahcleared");
	func_16B1("ai","in_sight",11,"ac130_plt_copysmoke");
	func_16B1("ai","in_sight",0,"ac130_fco_moreenemy");
	func_16B1("ai","in_sight",1,"ac130_fco_getthatguy");
	func_16B1("ai","in_sight",2,"ac130_fco_guymovin");
	func_16B1("ai","in_sight",3,"ac130_fco_getperson");
	func_16B1("ai","in_sight",4,"ac130_fco_guyrunnin");
	func_16B1("ai","in_sight",5,"ac130_fco_gotarunner");
	func_16B1("ai","in_sight",6,"ac130_fco_backonthose");
	func_16B1("ai","in_sight",7,"ac130_fco_gonnagethim");
	func_16B1("ai","in_sight",8,"ac130_fco_personnelthere");
	func_16B1("ai","in_sight",9,"ac130_fco_nailthoseguys");
	func_16B1("ai","in_sight",11,"ac130_fco_lightemup");
	func_16B1("ai","in_sight",12,"ac130_fco_takehimout");
	func_16B1("ai","in_sight",14,"ac130_plt_yeahcleared");
	func_16B1("ai","in_sight",15,"ac130_plt_copysmoke");
	func_16B1("ai","in_sight",16,"ac130_fco_rightthere");
	func_16B1("ai","in_sight",17,"ac130_fco_tracking");
	func_16B1("ai","wounded_crawl",0,"ac130_fco_movingagain");
	func_16B2("ai","wounded_crawl",undefined,6);
	func_16B1("ai","wounded_pain",0,"ac130_fco_doveonground");
	func_16B1("ai","wounded_pain",1,"ac130_fco_knockedwind");
	func_16B1("ai","wounded_pain",2,"ac130_fco_downstillmoving");
	func_16B1("ai","wounded_pain",3,"ac130_fco_gettinbackup");
	func_16B1("ai","wounded_pain",4,"ac130_fco_yepstillmoving");
	func_16B1("ai","wounded_pain",5,"ac130_fco_stillmoving");
	func_16B2("ai","wounded_pain",undefined,12);
	func_16B1("weapons","105mm_ready",0,"ac130_gnr_gunready1");
	func_16B1("weapons","105mm_fired",0,"ac130_gnr_shot1");
	func_16B1("plane","rolling_in",0,"ac130_plt_rollinin");
	func_16B1("explosion","secondary",0,"ac130_nav_secondaries1");
	func_16B2("explosion","secondary",undefined,7);
	func_16B1("kill","single",0,"ac130_plt_gottahurt");
	func_16B1("kill","single",1,"ac130_fco_iseepieces");
	func_16B1("kill","single",2,"ac130_fco_oopsiedaisy");
	func_16B1("kill","single",3,"ac130_fco_goodkill");
	func_16B1("kill","single",4,"ac130_fco_yougothim");
	func_16B1("kill","single",5,"ac130_fco_yougothim2");
	func_16B1("kill","single",6,"ac130_fco_thatsahit");
	func_16B1("kill","single",7,"ac130_fco_directhit");
	func_16B1("kill","single",8,"ac130_fco_rightontarget");
	func_16B1("kill","single",9,"ac130_fco_okyougothim");
	func_16B1("kill","single",10,"ac130_fco_within2feet");
	func_16B1("kill","small_group",0,"ac130_fco_nice");
	func_16B1("kill","small_group",1,"ac130_fco_directhits");
	func_16B1("kill","small_group",2,"ac130_fco_iseepieces");
	func_16B1("kill","small_group",3,"ac130_fco_goodkill");
	func_16B1("kill","small_group",4,"ac130_fco_yougothim");
	func_16B1("kill","small_group",5,"ac130_fco_yougothim2");
	func_16B1("kill","small_group",6,"ac130_fco_thatsahit");
	func_16B1("kill","small_group",7,"ac130_fco_directhit");
	func_16B1("kill","small_group",8,"ac130_fco_rightontarget");
	func_16B1("kill","small_group",9,"ac130_fco_okyougothim");
	func_16B1("misc","action",0,"ac130_fco_tracking");
	func_16B2("misc","action",0,70);
	func_16B1("misc","action",1,"ac130_fco_moreenemy");
	func_16B2("misc","action",1,80);
	func_16B1("misc","action",2,"ac130_random");
	func_16B2("misc","action",2,55);
	func_16B1("misc","action",3,"ac130_fco_rightthere");
	func_16B2("misc","action",3,100);
}

//Function Number: 4
func_16B1(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_teams::func_81BC("allies") + param_03;
	var_04 = scripts\mp\_teams::func_81BC("axis") + param_03;
	if(!isdefined(level.scr_sound[param_00]) || !isdefined(level.scr_sound[param_00][param_01]) || !isdefined(level.scr_sound[param_00][param_01][param_02]))
	{
		level.scr_sound[param_00][param_01][param_02] = spawnstruct();
		level.scr_sound[param_00][param_01][param_02].var_CF2C = 0;
		level.scr_sound[param_00][param_01][param_02].var_1047D = [];
	}

	var_05 = level.scr_sound[param_00][param_01][param_02].var_1047D.size;
	level.scr_sound[param_00][param_01][param_02].var_1047D[var_05] = param_03;
}

//Function Number: 5
func_16B2(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_45A2))
	{
		level.var_45A2 = [];
	}

	var_04 = 0;
	if(!isdefined(level.var_45A2[param_00]))
	{
		var_04 = 1;
	}
	else if(!isdefined(level.var_45A2[param_00][param_01]))
	{
		var_04 = 1;
	}

	if(var_04)
	{
		level.var_45A2[param_00][param_01] = spawnstruct();
	}

	if(isdefined(param_02))
	{
		level.var_45A2[param_00][param_01].var_86A3 = [];
		level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)] = spawnstruct();
		level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)].var_13125["timeoutDuration"] = param_03 * 1000;
		level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)].var_13125["lastPlayed"] = param_03 * -1000;
		return;
	}

	level.var_45A2[param_00][param_01].var_13125["timeoutDuration"] = param_03 * 1000;
	level.var_45A2[param_00][param_01].var_13125["lastPlayed"] = param_03 * -1000;
}

//Function Number: 6
func_CE2F(param_00)
{
	scripts\mp\_utility::play_sound_on_tag(param_00);
}

//Function Number: 7
func_22B5(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] != param_01)
		{
			var_02[var_02.size] = param_00[var_03];
		}
	}

	return var_02;
}

//Function Number: 8
func_11145(param_00)
{
	return "" + param_00;
}

//Function Number: 9
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 10
func_C57B()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 11
func_51BD()
{
	level waittill("ac130player_removed");
	self delete();
}

//Function Number: 12
func_B9F1()
{
	level endon("game_ended");
	level endon("ac130player_removed");
	self endon("disconnect");
	level.var_1537 thread scripts\mp\killstreaks\_killstreaks::func_1CA5();
	level.var_1537 waittill("killstreakExit");
	if(isdefined(level.var_1537.var_222))
	{
		level thread func_E0B5(level.var_1537.var_222,0);
	}
}

//Function Number: 13
func_F62A(param_00)
{
	self endon("ac130player_removed");
	if(isdefined(level.var_1541))
	{
		return 0;
	}

	func_9751();
	level.var_1541 = param_00;
	level.var_1537.var_222 = param_00;
	level.var_1537.var_CC44 show();
	level.var_1537.var_CC44 thread func_CE9F();
	level.var_1537.var_93DA = 0;
	level.var_1537.var_CC44 playloopsound("veh_ac130iw6_ext_dist");
	level.var_1537.var_CC44 thread func_4D72();
	thread func_89B5();
	level.var_1537.var_CC44 method_83BC();
	var_01 = spawnplane(param_00,"script_model",level.var_1537.var_CC44.origin,"compass_objpoint_c130_friendly","compass_objpoint_c130_enemy");
	var_01 notsolid();
	var_01 linkto(level.var_1537,"tag_player",(0,80,32),(0,-90,0));
	var_01 thread func_51BD();
	thread scripts\mp\_utility::func_115DE("used_ac130",param_00);
	param_00 thread func_13714(1);
	param_00 thread scripts\mp\_utility::func_DF2E(level.var_1537.var_CC44);
	if(getdvarint("camera_thirdPerson"))
	{
		param_00 scripts\mp\_utility::setthirdpersondof(0);
	}

	param_00 scripts\mp\_utility::func_12C6("ac130_105mm_mp");
	param_00 scripts\mp\_utility::func_12C6("ac130_40mm_mp");
	param_00 scripts\mp\_utility::func_12C6("ac130_25mm_mp");
	param_00 scripts\mp\_utility::_switchtoweapon("ac130_105mm_mp");
	param_00 thread func_E0B6(level.var_153E * param_00.killstreakscaler);
	param_00 setclientomnvar("ui_ac130_hud",1);
	param_00 thread func_C7FE();
	param_00 setblurforplayer(1.2,0);
	param_00 thread func_24A4(param_00);
	param_00 thread func_3C5E();
	param_00 thread func_13C88();
	param_00 thread func_4594();
	param_00 thread func_FEF6();
	param_00 thread func_42CF();
	if(isbot(self))
	{
		self.var_131B5 = level.var_1537;
		param_00 thread func_1539();
	}

	param_00 thread func_13AA2();
	param_00 thread func_E0BA();
	param_00 thread func_E0B7();
	param_00 thread func_E0BD();
	param_00 thread func_E0B8();
	param_00 thread func_E0BB();
	param_00 thread func_B9F1();
	thread func_1538();
	return 1;
}

//Function Number: 14
func_97BC()
{
	self setclientomnvar("ui_ac130_hud",1);
	scripts\common\utility::func_136F7();
	scripts\mp\_utility::_switchtoweapon("ac130_105mm_mp");
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_weapon",0);
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_105mm_ammo",self getweaponammoclip("ac130_105mm_mp"));
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_40mm_ammo",self getweaponammoclip("ac130_40mm_mp"));
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_25mm_ammo",self getweaponammoclip("ac130_25mm_mp"));
	scripts\common\utility::func_136F7();
	thread func_C7FE();
}

//Function Number: 15
func_13AA2()
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		func_97BC();
	}
}

//Function Number: 16
func_13714(param_00)
{
	self endon("disconnect");
	level endon("ac130player_removed");
	wait(param_00);
	self visionsetthermalforplayer(game["thermal_vision"],0);
	self thermalvisionfofoverlayon();
	thread func_1177C();
}

//Function Number: 17
func_CE9F()
{
	wait(0.05);
	playfxontag(level._effect["ac130_light_red_blink"],self,"tag_light_belly");
	playfxontag(level._effect["ac130_engineeffect"],self,"tag_body");
	wait(0.5);
	playfxontag(level._effect["ac130_light_white_blink"],self,"tag_light_tail");
	playfxontag(level._effect["ac130_light_red"],self,"tag_light_top");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_light_L_wing");
	playfxontag(level.var_7546,self,"tag_light_R_wing");
}

//Function Number: 18
func_1538()
{
	foreach(var_01 in level.players)
	{
		if(var_01 != level.var_1541 && var_01.team == level.var_1541.team)
		{
			var_01 thread scripts\mp\_utility::func_F63E(level.var_1537.var_37C4,"tag_origin",20);
		}
	}
}

//Function Number: 19
func_E0BC()
{
	self endon("ac130player_removed");
	level waittill("game_ended");
	level thread func_E0B5(self,0);
}

//Function Number: 20
func_E0BB()
{
	self endon("ac130player_removed");
	level waittill("game_cleanup");
	level thread func_E0B5(self,0);
}

//Function Number: 21
func_E0B9()
{
	self endon("ac130player_removed");
	self waittill("death");
	level thread func_E0B5(self,0);
}

//Function Number: 22
func_E0B8()
{
	self endon("ac130player_removed");
	level.var_1537.var_CC44 waittill("crashing");
	level thread func_E0B5(self,0);
}

//Function Number: 23
func_E0BA()
{
	self endon("ac130player_removed");
	self waittill("disconnect");
	level thread func_E0B5(self,1);
}

//Function Number: 24
func_E0B7()
{
	self endon("ac130player_removed");
	self waittill("joined_team");
	level thread func_E0B5(self,0);
}

//Function Number: 25
func_E0BD()
{
	self endon("ac130player_removed");
	scripts\common\utility::waittill_any_3("joined_spectators","spawned");
	level thread func_E0B5(self,0);
}

//Function Number: 26
func_E0B6(param_00)
{
	self endon("ac130player_removed");
	var_01 = param_00;
	self setclientomnvar("ui_ac130_use_time",var_01 * 1000 + gettime());
	scripts\mp\_hostmigration::func_13708(var_01);
	self setclientomnvar("ui_ac130_use_time",0);
	level thread func_E0B5(self,0);
}

//Function Number: 27
func_E0B5(param_00,param_01)
{
	param_00 notify("ac130player_removed");
	level notify("ac130player_removed");
	level.var_1537.var_37C4 notify("death");
	waittillframeend;
	if(!param_01)
	{
		param_00 scripts\mp\_utility::func_41E9();
		param_00 stoplocalsound("missile_incoming");
		param_00 stoploopsound();
		param_00 show();
		param_00 unlink();
		if(isbot(param_00))
		{
			param_00 controlsunlink();
			param_00 cameraunlink();
			param_00.var_131B5 = undefined;
		}

		param_00 thermalvisionoff();
		param_00 thermalvisionfofoverlayoff();
		param_00 visionsetthermalforplayer(level.var_1537.var_1177A,0);
		param_00.var_AA42 = level.var_1537.var_1177A;
		param_00 setblurforplayer(0,0);
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 scripts\mp\_utility::setthirdpersondof(1);
		}

		var_02 = scripts\mp\_utility::func_7F55("ac130");
		param_00 scripts\mp\_utility::func_141E(var_02);
		param_00 scripts\mp\_utility::func_141E("ac130_105mm_mp");
		param_00 scripts\mp\_utility::func_141E("ac130_40mm_mp");
		param_00 scripts\mp\_utility::func_141E("ac130_25mm_mp");
		param_00 setclientomnvar("ui_ac130_hud",0);
	}

	func_E110();
	wait(0.5);
	level.var_1537.var_CC44 playsound("veh_ac130iw6_ext_dist_fade");
	wait(0.5);
	level.var_1541 = undefined;
	level.var_1537.var_CC44 hide();
	level.var_1537.var_CC44 stoploopsound();
	if(isdefined(level.var_1537.var_CC44.var_4824))
	{
		level.var_1540 = 0;
		return;
	}

	var_03 = spawn("script_model",level.var_1537.var_CC44 gettagorigin("tag_origin"));
	var_03.angles = level.var_1537.var_CC44.angles;
	var_03 setmodel("vehicle_y_8_gunship_mp");
	var_04 = var_03.origin + anglestoright(var_03.angles) * 20000;
	var_04 = var_04 + (0,0,10000);
	var_03 thread func_CE9F();
	var_03 moveto(var_04,40,0,0);
	var_05 = (0,var_03.angles[1],-20);
	var_03 rotateto(var_05,30,1,1);
	var_03 thread func_5231(1);
	wait(5);
	var_03 thread func_5231(1);
	wait(5);
	var_03 thread func_5231(1);
	level.var_1540 = 0;
	wait(30);
	var_03 delete();
}

//Function Number: 28
func_E110()
{
	var_00 = level.var_1537.var_CC44 getentitynumber();
	level.var_AD8B[var_00] = undefined;
}

//Function Number: 29
func_4D72()
{
	self endon("death");
	self endon("crashing");
	level endon("game_ended");
	level endon("ac130player_removed");
	self.health = 999999;
	self.maxhealth = 1000;
	self.var_E1 = 0;
	self.team = level.var_1541.team;
	scripts\mp\killstreaks\_helicopter::func_1852();
	self.var_2550 = missile_createattractorent(self,1000,4096);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(level.var_1541) && level.teambased && isplayer(var_01) && var_01.team == level.var_1541.team && !isdefined(level.var_C1BB))
		{
			continue;
		}

		if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET")
		{
			continue;
		}

		self.var_1390B = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 scripts\mp\_damagefeedback::func_12E84("ac130");
		}

		scripts\mp\killstreaks\_killstreaks::func_A6A0(var_01,var_09,level.var_1537);
		if(isdefined(var_01.var_222) && isplayer(var_01.var_222))
		{
			var_01.var_222 scripts\mp\_damagefeedback::func_12E84("ac130");
		}

		self.var_E1 = self.var_E1 + var_0A;
		if(self.var_E1 >= self.maxhealth)
		{
			if(isplayer(var_01))
			{
				thread scripts\mp\_utility::func_115DE("callout_destroyed_ac130",var_01);
				var_01 thread scripts\mp\_utility::func_83B4("kill",var_09,400);
				var_01 notify("destroyed_killstreak");
			}

			level thread func_482C(10);
		}
	}
}

//Function Number: 30
func_153C()
{
	wait(0.05);
	var_00 = spawn("script_model",level.var_1537 gettagorigin("tag_player"));
	var_00 setmodel("vehicle_y_8_gunship_mp");
	var_00.var_336 = "vehicle_y_8_gunship_mp";
	var_00 setcandamage(1);
	var_00.maxhealth = 1000;
	var_00.health = var_00.maxhealth;
	var_00 linkto(level.var_1537,"tag_player",(0,80,32),(-25,0,0));
	level.var_1537.var_CC44 = var_00;
	level.var_1537.var_CC44 hide();
	var_01 = spawn("script_model",level.var_1537 gettagorigin("tag_player"));
	var_01 setmodel("tag_origin");
	var_01 hide();
	var_01.var_336 = "ac130CameraModel";
	var_01 linkto(level.var_1537,"tag_player",(0,0,32),(5,0,0));
	level.var_1537.var_37C4 = var_01;
}

//Function Number: 31
func_C7FE()
{
	self endon("ac130player_removed");
	wait(0.05);
	thread func_12EED();
	thread func_12E57();
}

//Function Number: 32
func_12EED()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self setclientomnvar("ui_ac130_coord1_posx",abs(level.var_1537.var_CC44.origin[0]));
		self setclientomnvar("ui_ac130_coord1_posy",abs(level.var_1537.var_CC44.origin[1]));
		self setclientomnvar("ui_ac130_coord1_posz",abs(level.var_1537.var_CC44.origin[2]));
		wait(0.5);
	}
}

//Function Number: 33
func_12EF1()
{
	self endon("ac130player_removed");
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_coord2_posx",abs(self.origin[0]));
	self setclientomnvar("ui_ac130_coord2_posy",abs(self.origin[1]));
	self setclientomnvar("ui_ac130_coord2_posz",abs(self.origin[2]));
}

//Function Number: 34
func_12E57()
{
	self endon("ac130player_removed");
	for(;;)
	{
		var_00 = self geteye();
		var_01 = self getplayerangles();
		var_02 = anglestoforward(var_01);
		var_03 = var_00 + var_02 * 15000;
		var_04 = physicstrace(var_00,var_03);
		self setclientomnvar("ui_ac130_coord3_posx",abs(var_04[0]));
		self setclientomnvar("ui_ac130_coord3_posy",abs(var_04[1]));
		self setclientomnvar("ui_ac130_coord3_posz",abs(var_04[2]));
		wait(0.1);
	}
}

//Function Number: 35
func_1543()
{
	self endon("ac130player_removed");
	level endon("post_effects_disabled");
	var_00 = 5;
	for(;;)
	{
		self shellshock("ac130",var_00);
		wait(var_00);
	}
}

//Function Number: 36
func_E72F(param_00)
{
	level notify("stop_rotatePlane_thread");
	level endon("stop_rotatePlane_thread");
	if(param_00 == "on")
	{
		var_01 = 10;
		var_02 = level.var_153D["rotate"] / 360 * var_01;
		level.var_1537 rotateyaw(level.var_1537.angles[2] + var_01,var_02,var_02,0);
		for(;;)
		{
			level.var_1537 rotateyaw(360,level.var_153D["rotate"]);
			wait(level.var_153D["rotate"]);
		}

		return;
	}

	if(param_00 == "off")
	{
		var_03 = 10;
		var_02 = level.var_153D["rotate"] / 360 * var_03;
		level.var_1537 rotateyaw(level.var_1537.angles[2] + var_03,var_02,0,var_02);
	}
}

//Function Number: 37
func_24A4(param_00)
{
	if(isbot(param_00))
	{
		param_00 cameralinkto(level.var_1537,"tag_player");
	}

	self playerlinkweaponviewtodelta(level.var_1537.var_37C4,"tag_player",1,35,35,35,35);
	self setplayerangles(level.var_1537 gettagangles("tag_player"));
}

//Function Number: 38
func_3C5E()
{
	self endon("ac130player_removed");
	wait(0.05);
	self enableweapons();
	self enableweaponswitch();
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_105mm_ammo",self getweaponammoclip("ac130_105mm_mp"));
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_40mm_ammo",self getweaponammoclip("ac130_40mm_mp"));
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_ac130_25mm_ammo",self getweaponammoclip("ac130_25mm_mp"));
	for(;;)
	{
		self waittill("weapon_change",var_00);
		thread func_CE2F("ac130iw6_weapon_switch");
		self notify("reset_25mm");
		self stoploopsound("ac130iw6_25mm_fire_loop");
		switch(var_00)
		{
			case "ac130_105mm_mp":
				self setclientomnvar("ui_ac130_weapon",0);
				break;
	
			case "ac130_40mm_mp":
				self setclientomnvar("ui_ac130_weapon",1);
				break;
	
			case "ac130_25mm_mp":
				self setclientomnvar("ui_ac130_weapon",2);
				thread func_D522();
				break;
		}
	}
}

//Function Number: 39
func_13C88()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = self getcurrentweapon();
		switch(var_00)
		{
			case "ac130_105mm_mp":
				thread func_86D0();
				earthquake(0.2,1,level.var_1537.var_CC44.origin,1000);
				self setclientomnvar("ui_ac130_105mm_ammo",self getweaponammoclip(var_00));
				break;
	
			case "ac130_40mm_mp":
				earthquake(0.1,0.5,level.var_1537.var_CC44.origin,1000);
				self setclientomnvar("ui_ac130_40mm_ammo",self getweaponammoclip(var_00));
				break;
	
			case "ac130_25mm_mp":
				self setclientomnvar("ui_ac130_25mm_ammo",self getweaponammoclip(var_00));
				break;
		}

		if(self getweaponammoclip(var_00))
		{
			continue;
		}

		thread func_13CC0(var_00);
	}
}

//Function Number: 40
func_13CC0(param_00)
{
	self endon("ac130player_removed");
	wait(level.var_13CC1[param_00]);
	self setweaponammoclip(param_00,9999);
	switch(param_00)
	{
		case "ac130_105mm_mp":
			self setclientomnvar("ui_ac130_105mm_ammo",self getweaponammoclip(param_00));
			break;

		case "ac130_40mm_mp":
			self setclientomnvar("ui_ac130_40mm_ammo",self getweaponammoclip(param_00));
			break;

		case "ac130_25mm_mp":
			self setclientomnvar("ui_ac130_25mm_ammo",self getweaponammoclip(param_00));
			break;
	}

	if(self getcurrentweapon() == param_00)
	{
		scripts\mp\_utility::func_141E(param_00);
		scripts\mp\_utility::func_12C6(param_00);
		scripts\mp\_utility::_switchtoweapon(param_00);
	}
}

//Function Number: 41
func_D522()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("ac130player_removed");
	self endon("reset_25mm");
	var_00 = self getcurrentweapon();
	for(;;)
	{
		self waittill("weapon_fired");
		self stoplocalsound("ac130iw6_25mm_fire_loop_cooldown");
		self playloopsound("ac130iw6_25mm_fire_loop");
		while(self attackbuttonpressed() && self getweaponammoclip(var_00))
		{
			wait(0.05);
		}

		self stoploopsound();
		self playlocalsound("ac130iw6_25mm_fire_loop_cooldown");
	}
}

//Function Number: 42
func_1539()
{
	self endon("ac130player_removed");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_05 = undefined;
	var_06 = self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy") / 2;
	var_07 = 0;
	for(;;)
	{
		var_08 = 0;
		var_09 = 0;
		if(isdefined(var_01) && var_01.health <= 0 && gettime() - var_01.var_4E72 < 2000)
		{
			var_08 = 1;
			var_09 = 1;
		}
		else if(isalive(self.var_10C) && self botcanseeentity(self.var_10C) || gettime() - self lastknowntime(self.var_10C) <= 300)
		{
			var_08 = 1;
			var_01 = self.var_10C;
			var_0A = var_01.origin;
			var_00 = self.var_10C.origin;
			if(self botcanseeentity(self.var_10C))
			{
				var_07 = 0;
				var_09 = 1;
				var_0B = gettime();
			}
			else
			{
				var_07 = var_07 + 0.05;
				if(var_07 > 5)
				{
					var_08 = 0;
				}
			}
		}

		if(var_08)
		{
			if(isdefined(var_00))
			{
				var_02 = var_00;
			}

			if(var_09 && scripts\mp\bots\_bots_killstreaks_remote_vehicle::func_2D16() || distancesquared(var_02,level.var_1537.origin) > level.var_CB11["ac130_105mm_mp"] * level.var_CB11["ac130_105mm_mp"])
			{
				self botpressbutton("attack");
			}

			if(gettime() > var_04 + 500)
			{
				var_0C = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_0D = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_0E = randomfloatrange(-1 * var_06 / 2,var_06 / 2);
				var_05 = (150 * var_0C,150 * var_0D,150 * var_0E);
				var_04 = gettime();
			}

			var_02 = var_02 + var_05;
		}
		else if(gettime() > var_03)
		{
			var_03 = gettime() + randomintrange(1000,2000);
			var_02 = scripts\mp\bots\_bots_killstreaks_remote_vehicle::func_7BEE();
		}

		self botlookatpoint(var_02,0.2,"script_forced");
		wait(0.05);
	}
}

//Function Number: 43
func_1177C()
{
	self endon("ac130player_removed");
	self thermalvisionon();
	self visionsetthermalforplayer(level.var_1537.var_65D1,1);
	self.var_AA42 = level.var_1537.var_65D1;
	self visionsetthermalforplayer(level.var_1537.var_1177A,0.62);
	self.var_AA42 = level.var_1537.var_1177A;
	self setclientdvar("ui_ac130_thermal",1);
}

//Function Number: 44
func_42CF()
{
	self endon("ac130player_removed");
	wait(6);
	func_42D0();
	for(;;)
	{
		wait(randomfloatrange(40,80));
		func_42D0();
	}
}

//Function Number: 45
func_42D0()
{
	if(isdefined(level.var_D465) && issubstr(tolower(level.var_D465),"25"))
	{
		return;
	}

	playfxontagforclients(level._effect["cloud"],level.var_1537,"tag_player",level.var_1541);
}

//Function Number: 46
func_86D0()
{
	self endon("ac130player_removed");
	level notify("gun_fired_and_ready_105mm");
	level endon("gun_fired_and_ready_105mm");
	wait(0.5);
	if(randomint(2) == 0)
	{
		thread func_459F("weapons","105mm_fired");
	}

	wait(5);
	thread func_459F("weapons","105mm_ready");
}

//Function Number: 47
func_FEF6()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("projectile_impact",var_00,var_01,var_02);
		if(issubstr(tolower(var_00),"105"))
		{
			earthquake(0.4,1,var_01,3500);
			self setclientomnvar("ui_ac130_darken",1);
		}
		else if(issubstr(tolower(var_00),"40"))
		{
			earthquake(0.2,0.5,var_01,2000);
		}

		if(scripts\mp\_utility::func_7F1D("ac130_ragdoll_deaths",0))
		{
			thread func_FEF7(var_01,var_00);
		}

		wait(0.05);
	}
}

//Function Number: 48
func_FEF7(param_00,param_01)
{
	wait(0.1);
	physicsexplosionsphere(param_00,level.var_CB11[param_01],level.var_CB11[param_01] / 2,level.var_CB10[param_01]);
}

//Function Number: 49
func_169F()
{
	self endon("death");
	var_00 = 0.75;
	wait(randomfloat(3));
	for(;;)
	{
		if(level.var_1541)
		{
			playfxontagforclients(level._effect["beacon"],self,"j_spine4",level.var_1541);
		}

		wait(var_00);
	}
}

//Function Number: 50
func_4594()
{
	thread func_649A();
	thread func_4597();
	thread func_4596();
	thread func_4599();
	thread func_45A0();
	thread func_459B();
	thread func_459C();
	thread func_4595();
}

//Function Number: 51
func_4597()
{
	self endon("ac130player_removed");
	for(;;)
	{
		if(func_4598())
		{
			thread func_459F("ai","in_sight");
		}

		wait(randomfloatrange(1,3));
	}
}

//Function Number: 52
func_4598()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(!scripts\mp\_utility::func_9F19(var_02))
		{
			continue;
		}

		if(var_02.team == level.var_1541.team)
		{
			continue;
		}

		if(var_02.team == "spectator")
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		if(!isdefined(var_00[var_04]))
		{
			continue;
		}

		if(!isalive(var_00[var_04]))
		{
			continue;
		}

		if(scripts\common\utility::func_13D90(level.var_1541 geteye(),level.var_1541 getplayerangles(),var_00[var_04].origin,level.var_46A1["5"]))
		{
			return 1;
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 53
func_4596()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_crawling",var_00);
		thread func_459F("ai","wounded_crawl");
	}
}

//Function Number: 54
func_4599()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_pain",var_00);
		thread func_459F("ai","wounded_pain");
	}
}

//Function Number: 55
func_45A0()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("player_destroyed_car",var_00,var_01);
		wait(1);
		thread func_459F("explosion","secondary");
	}
}

//Function Number: 56
func_649A()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_killed",var_00);
		thread func_459A(var_00,level.var_1541);
	}
}

//Function Number: 57
func_459A(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	level.var_63AB++;
	level notify("enemy_killed");
}

//Function Number: 58
func_459B()
{
	self endon("ac130player_removed");
	var_00 = 1;
	for(;;)
	{
		level waittill("enemy_killed");
		wait(var_00);
		var_01 = "kill";
		var_02 = undefined;
		if(level.var_63AB >= 2)
		{
			var_02 = "small_group";
		}
		else
		{
			var_02 = "single";
			if(randomint(3) != 1)
			{
				level.var_63AB = 0;
				continue;
			}
		}

		level.var_63AB = 0;
		thread func_459F(var_01,var_02,1);
	}
}

//Function Number: 59
func_459C()
{
	scripts\common\utility::array_thread(getentarray("context_dialog_car","targetname"),::func_459D,"car");
	scripts\common\utility::array_thread(getentarray("context_dialog_truck","targetname"),::func_459D,"truck");
	scripts\common\utility::array_thread(getentarray("context_dialog_building","targetname"),::func_459D,"building");
	scripts\common\utility::array_thread(getentarray("context_dialog_wall","targetname"),::func_459D,"wall");
	scripts\common\utility::array_thread(getentarray("context_dialog_field","targetname"),::func_459D,"field");
	scripts\common\utility::array_thread(getentarray("context_dialog_road","targetname"),::func_459D,"road");
	scripts\common\utility::array_thread(getentarray("context_dialog_church","targetname"),::func_459D,"church");
	scripts\common\utility::array_thread(getentarray("context_dialog_ditch","targetname"),::func_459D,"ditch");
	thread func_459E();
}

//Function Number: 60
func_459E()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("context_location",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(!scripts\common\utility::flag("allow_context_sensative_dialog"))
		{
			continue;
		}

		thread func_459F("location",var_00);
		wait(5 + randomfloat(10));
	}
}

//Function Number: 61
func_459D(param_00)
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.team) || var_01.team != "axis")
		{
			continue;
		}

		level notify("context_location",param_00);
		wait(5);
	}
}

//Function Number: 62
func_45A4(param_00)
{
	if(param_00.var_EEDE != "axis")
	{
		return;
	}

	thread func_45A3(param_00);
	param_00 endon("death");
	while(!scripts\common\utility::func_13D90(level.var_1541 geteye(),level.var_1541 getplayerangles(),param_00.origin,level.var_46A1["45"]))
	{
		wait(0.5);
	}

	func_459F("vehicle","incoming");
}

//Function Number: 63
func_45A3(param_00)
{
	param_00 waittill("death");
	thread func_459F("vehicle","death");
}

//Function Number: 64
func_4595()
{
	self endon("ac130player_removed");
	for(;;)
	{
		if(isdefined(level.var_DBF7) && level.var_DBF7 == 1)
		{
			level waittill("radio_not_in_use");
		}

		var_00 = gettime();
		if(var_00 - level.var_A9D7 >= 3000)
		{
			level.var_A9D7 = var_00;
			thread func_459F("misc","action");
		}

		wait(0.25);
	}
}

//Function Number: 65
func_459F(param_00,param_01,param_02)
{
	level endon("ac130player_removed");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!scripts\common\utility::flag("allow_context_sensative_dialog"))
	{
		if(param_02)
		{
			scripts\common\utility::flag_wait("allow_context_sensative_dialog");
		}
		else
		{
			return;
		}
	}

	var_03 = undefined;
	var_04 = randomint(level.scr_sound[param_00][param_01].size);
	if(level.scr_sound[param_00][param_01][var_04].var_CF2C == 1)
	{
		for(var_05 = 0;var_05 < level.scr_sound[param_00][param_01].size;var_05++)
		{
			var_04++;
			if(var_04 >= level.scr_sound[param_00][param_01].size)
			{
				var_04 = 0;
			}

			if(level.scr_sound[param_00][param_01][var_04].var_CF2C == 1)
			{
				continue;
			}

			var_03 = var_04;
			break;
		}

		if(!isdefined(var_03))
		{
			for(var_05 = 0;var_05 < level.scr_sound[param_00][param_01].size;var_05++)
			{
				level.scr_sound[param_00][param_01][var_05].var_CF2C = 0;
			}

			var_03 = randomint(level.scr_sound[param_00][param_01].size);
		}
	}
	else
	{
		var_03 = var_04;
	}

	if(func_45A1(param_00,param_01,var_03))
	{
		return;
	}

	level.scr_sound[param_00][param_01][var_03].var_CF2C = 1;
	var_06 = randomint(level.scr_sound[param_00][param_01][var_03].size);
	func_D530(level.scr_sound[param_00][param_01][var_03].var_1047D[var_06],param_02);
}

//Function Number: 66
func_45A1(param_00,param_01,param_02)
{
	if(!isdefined(level.var_45A2))
	{
		return 0;
	}

	if(!isdefined(level.var_45A2[param_00]))
	{
		return 0;
	}

	if(!isdefined(level.var_45A2[param_00][param_01]))
	{
		return 0;
	}

	if(isdefined(level.var_45A2[param_00][param_01].var_86A3) && isdefined(level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)]))
	{
		var_03 = gettime();
		if(var_03 - level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)].var_13125["lastPlayed"] < level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)].var_13125["timeoutDuration"])
		{
			return 1;
		}

		level.var_45A2[param_00][param_01].var_86A3[func_11145(param_02)].var_13125["lastPlayed"] = var_03;
	}
	else if(isdefined(level.var_45A2[param_00][param_01].var_13125))
	{
		var_03 = gettime();
		if(var_03 - level.var_45A2[param_00][param_01].var_13125["lastPlayed"] < level.var_45A2[param_00][param_01].var_13125["timeoutDuration"])
		{
			return 1;
		}

		level.var_45A2[param_00][param_01].var_13125["lastPlayed"] = var_03;
	}

	return 0;
}

//Function Number: 67
func_D530(param_00,param_01,param_02)
{
	if(!isdefined(level.var_DBF7))
	{
		level.var_DBF7 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	param_02 = param_02 * 1000;
	var_03 = gettime();
	var_04 = 0;
	var_04 = func_CEA7(param_00);
	if(var_04)
	{
		return;
	}

	if(!param_01)
	{
		return;
	}

	level.var_DBFC[level.var_DBFC.size] = param_00;
	while(!var_04)
	{
		if(level.var_DBF7)
		{
			level waittill("radio_not_in_use");
		}

		if(param_02 > 0 && gettime() - var_03 > param_02)
		{
			break;
		}

		if(!isdefined(level.var_1541))
		{
			break;
		}

		var_04 = func_CEA7(level.var_DBFC[0]);
		if(!level.var_DBF7 && isdefined(level.var_1541) && !var_04)
		{
		}
	}

	level.var_DBFC = scripts\mp\_utility::func_22B0(level.var_DBFC,0);
}

//Function Number: 68
func_CEA7(param_00)
{
	if(level.var_DBF7)
	{
		return 0;
	}

	if(!isdefined(level.var_1541))
	{
		return 0;
	}

	level.var_DBF7 = 1;
	if(self.team == "allies" || self.team == "axis")
	{
		param_00 = scripts\mp\_teams::func_81BC(self.team) + param_00;
		level.var_1541 playlocalsound(param_00);
	}

	wait(4);
	level.var_DBF7 = 0;
	level.var_A9D7 = gettime();
	level notify("radio_not_in_use");
	return 1;
}

//Function Number: 69
func_4EBC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 16;
	var_07 = 360 / var_06;
	var_08 = [];
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		var_0A = var_07 * var_09;
		var_0B = cos(var_0A) * param_01;
		var_0C = sin(var_0A) * param_01;
		var_0D = param_00[0] + var_0B;
		var_0E = param_00[1] + var_0C;
		var_0F = param_00[2];
		var_08[var_08.size] = (var_0D,var_0E,var_0F);
	}

	if(isdefined(param_04))
	{
		wait(param_04);
	}

	thread func_4EBD(var_08,param_02,param_03,param_05,param_00);
}

//Function Number: 70
func_4EBD(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_03 = 0;
	}

	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_05 + 1 >= param_00.size)
		{
			var_07 = param_00[0];
		}
		else
		{
			var_07 = param_00[var_05 + 1];
		}

		thread func_4EEE(var_06,var_07,param_01,param_02);
		if(param_03)
		{
			thread func_4EEE(param_04,var_06,param_01,param_02);
		}
	}
}

//Function Number: 71
func_4EEE(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 72
func_89B5()
{
	level endon("game_ended");
	level.var_1537.var_CC44 thread func_6EAD(1);
}

//Function Number: 73
func_6EAD(param_00)
{
	self.var_6EB4 = param_00;
	self.var_6EB3 = [];
	thread func_A72B();
	thread func_A729();
}

//Function Number: 74
func_D47A(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		thread func_1E72();
		wait(randomfloatrange(0.1,0.25));
	}
}

//Function Number: 75
func_5231(param_00)
{
	self playsound("ac130iw6_flare_burst");
	if(!isdefined(param_00))
	{
		var_01 = spawn("script_origin",level.var_1537.var_CC44.origin);
		var_01.angles = level.var_1537.var_CC44.angles;
		var_01 movegravity((0,0,0),5);
		thread func_D47A(10);
		self.var_6EB3[self.var_6EB3.size] = var_01;
		var_01 thread func_51A6(5);
		return var_01;
	}

	thread func_D47A(5);
}

//Function Number: 76
func_6EA9(param_00)
{
	return param_00.var_6EB4;
}

//Function Number: 77
func_6E9D(param_00)
{
	func_6E9E(param_00);
	return param_00.var_6EB4 > 0 || param_00.var_6EB3.size > 0;
}

//Function Number: 78
func_6EA8(param_00)
{
	param_00.var_6EB4--;
	var_01 = param_00 func_5231();
	return var_01;
}

//Function Number: 79
func_6E9E(param_00)
{
	param_00.var_6EB3 = scripts\common\utility::func_22BC(param_00.var_6EB3);
}

//Function Number: 80
func_6EA7(param_00)
{
	func_6E9E(param_00);
	var_01 = undefined;
	if(param_00.var_6EB3.size > 0)
	{
		var_01 = param_00.var_6EB3[param_00.var_6EB3.size - 1];
	}

	return var_01;
}

//Function Number: 81
func_A72B()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	while(func_6E9D(self))
	{
		level waittill("laserGuidedMissiles_incoming",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		level.var_1541 playlocalsound("missile_incoming");
		level.var_1541 thread func_A731(self,"missile_incoming");
		foreach(var_04 in var_01)
		{
			if(isvalidmissile(var_04))
			{
				level thread func_A72C(var_04,var_00,var_00.team,var_02);
			}
		}
	}
}

//Function Number: 82
func_A72C(param_00,param_01,param_02,param_03)
{
	param_03 endon("death");
	param_00 endon("death");
	param_00 endon("missile_targetChanged");
	while(func_6E9D(param_03))
	{
		if(!isdefined(param_03) || !isvalidmissile(param_00))
		{
			break;
		}

		var_04 = param_03 method_8159(0,0,0);
		if(distancesquared(param_00.origin,var_04) < 4000000)
		{
			var_05 = func_6EA7(param_03);
			if(!isdefined(var_05))
			{
				var_05 = func_6EA8(param_03);
			}

			param_00 missile_settargetent(var_05);
			param_00 notify("missile_pairedWithFlare");
			level.var_1541 stoplocalsound("missile_incoming");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 83
func_A729()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	while(func_6E9D(self))
	{
		self waittill("targeted_by_incoming_missile",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		level.var_1541 playlocalsound("missile_incoming");
		level.var_1541 thread func_A731(self,"missile_incoming");
		foreach(var_02 in var_00)
		{
			if(isvalidmissile(var_02))
			{
				thread func_A72A(var_02);
			}
		}
	}
}

//Function Number: 84
func_A72A(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		if(!isdefined(self) || !isvalidmissile(param_00))
		{
			break;
		}

		var_01 = self method_8159(0,0,0);
		if(distancesquared(param_00.origin,var_01) < 4000000)
		{
			var_02 = func_6EA7(self);
			if(!isdefined(var_02) && self.var_6EB4 > 0)
			{
				var_02 = func_6EA8(self);
			}

			if(isdefined(var_02))
			{
				param_00 missile_settargetent(var_02);
				param_00 notify("missile_pairedWithFlare");
				level.var_1541 stoplocalsound("missile_incoming");
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 85
func_A731(param_00,param_01)
{
	self endon("disconnect");
	param_00 waittill("death");
	self stoplocalsound(param_01);
}

//Function Number: 86
func_51A6(param_00)
{
	wait(param_00);
	self delete();
}

//Function Number: 87
func_482C(param_00)
{
	level.var_1537.var_CC44 notify("crashing");
	level.var_1537.var_CC44.var_4824 = 1;
	playfxontag(level._effect["ac130_explode"],level.var_1537.var_CC44,"tag_deathfx");
	wait(0.25);
	level.var_1537.var_CC44 hide();
}

//Function Number: 88
func_1E73()
{
	level._effect["angel_flare_geotrail"] = loadfx("fx/smoke/angel_flare_geotrail");
	level._effect["angel_flare_swirl"] = loadfx("fx/smoke/angel_flare_swirl_runner");
}

//Function Number: 89
func_1E72()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("angel_flare_rig");
	var_00.origin = self gettagorigin("tag_flash_flares");
	var_00.angles = self gettagangles("tag_flash_flares");
	var_00.angles = (var_00.angles[0],var_00.angles[1] + 180,var_00.angles[2] + -90);
	var_01 = level._effect["angel_flare_geotrail"];
	var_00 scriptmodelplayanim("ac130_angel_flares0" + randomint(3) + 1);
	wait(0.1);
	playfxontag(var_01,var_00,"flare_left_top");
	playfxontag(var_01,var_00,"flare_right_top");
	wait(0.05);
	playfxontag(var_01,var_00,"flare_left_bot");
	playfxontag(var_01,var_00,"flare_right_bot");
	wait(3);
	stopfxontag(var_01,var_00,"flare_left_top");
	stopfxontag(var_01,var_00,"flare_right_top");
	stopfxontag(var_01,var_00,"flare_left_bot");
	stopfxontag(var_01,var_00,"flare_right_bot");
	var_00 delete();
}