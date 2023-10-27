/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_hub_allies.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 741 ms
 * Timestamp: 10/27/2023 3:15:40 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_A1FE = getdvarint("4476",0) != 0;
	level.var_A220 = level.var_A1FE;
	maps\mp\gametypes\_hub_stats::func_4F3E();
	lib_04AC::func_F9();
	lib_0414::func_F9();
	lib_04AB::func_F9();
	maps\mp\_load::func_F9();
	maps/mp/mp_hub_allies_lighting::func_F9();
	maps/mp/mp_hub_allies_aud::func_F9();
	maps\mp\_compass::func_8A2F("");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.var_A4B5["intensity"] = 0.2;
	level.var_A4B5["falloff"] = 1.2;
	level.var_A4B5["scaleX"] = 1;
	level.var_A4B5["scaleY"] = 1;
	level.var_A4B5["squareAspectRatio"] = 0;
	level.var_A4B5["lerpDuration"] = 0.1;
	level.var_A4BE["intensity"] = 0.5;
	level.var_A4BE["falloff"] = 1.2;
	level.var_A4BE["scaleX"] = 1;
	level.var_A4BE["scaleY"] = 1;
	level.var_A4BE["squareAspectRatio"] = 0;
	level.var_A4BE["lerpDuration"] = 0.4;
	level.var_6465["velocityscaler"] = 0;
	level.var_6465["cameraRotationInfluence"] = 0;
	level.var_6465["cameraTranslationInfluence"] = 0;
	setdvar("4135","allies");
	level.var_ACBC = undefined;
	level.var_ACBA = undefined;
	level.var_ACC0 = undefined;
	level.var_ACBD = undefined;
	level.var_ACBB = undefined;
	level.var_ACBF = undefined;
	level.devicesbegintrigger = getent("resistance_discoverable_begin","targetname");
	level.devicestructs = [];
	level.deviceinteract = getent("device_interact","targetname");
	thread func_529F();
	thread func_8A3A();
	setdvar("4712","2");
	setdvar("3286",0);
	setdvar("3220","3");
}

//Function Number: 2
func_8A3A()
{
	maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_range_2_tr");
	func_897E();
	if(getdvarint("986",0) == 0)
	{
		maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_spawn_5_tr");
		func_897F();
		maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_main_2_tr");
		func_8980();
	}
}

//Function Number: 3
func_897E()
{
}

//Function Number: 4
func_897F()
{
	thread func_530F();
	thread func_5311();
	thread func_5376();
	thread handlespecialeventents();
	thread theaterscreenswap();
}

//Function Number: 5
func_8980()
{
	thread func_5318();
}

//Function Number: 6
func_529F()
{
	level endon("game_ended");
	setdvarifuninitialized("hub_reveal_remove_nametags_on_kit","");
	setdvarifuninitialized("hub_reveal_add_nametags_on_kit","");
	level.var_7E3B = ["SHG-DKendall"];
	level thread func_63D6();
	level thread func_6364();
}

//Function Number: 7
func_6363()
{
	level endon("game_ended");
	while(getdvar("hub_reveal_add_capture_kit") == "")
	{
		wait(1);
	}

	var_00 = tolower(getdvar("hub_reveal_add_capture_kit"));
	if(!common_scripts\utility::func_F79(level.var_7E3B,var_00))
	{
		level.var_7E3B[level.var_7E3B.size] = var_00;
	}

	setdvar("hub_reveal_add_capture_kit","");
	thread func_6363();
}

//Function Number: 8
func_63D5()
{
	level endon("game_ended");
	while(getdvar("hub_reveal_remove_capture_kit") == "")
	{
		wait(1);
	}

	var_00 = tolower(getdvar("hub_reveal_remove_capture_kit"));
	level.var_7E3B = common_scripts\utility::func_F93(level.var_7E3B,var_00);
	setdvar("hub_reveal_remove_capture_kit","");
	thread func_63D5();
}

//Function Number: 9
func_63D6()
{
	level endon("game_ended");
	while(getdvar("hub_reveal_remove_nametags_on_kit") == "")
	{
		wait(1);
	}

	var_00 = tolower(getdvar("hub_reveal_remove_nametags_on_kit"));
	foreach(var_02 in level.var_744A)
	{
		if(tolower(var_02.var_109) == var_00)
		{
			var_02 maps\mp\gametypes\_hub_unk1::func_4D02();
			break;
		}
	}

	setdvar("hub_reveal_remove_nametags_on_kit","");
	thread func_63D6();
}

//Function Number: 10
func_6364()
{
	level endon("game_ended");
	while(getdvar("hub_reveal_add_nametags_on_kit") == "")
	{
		wait(1);
	}

	var_00 = tolower(getdvar("hub_reveal_add_nametags_on_kit"));
	foreach(var_02 in level.var_744A)
	{
		if(tolower(var_02.var_109) == var_00)
		{
			var_02 maps\mp\gametypes\_hub_unk1::func_8BEB();
			break;
		}
	}

	setdvar("hub_reveal_add_nametags_on_kit","");
	thread func_6364();
}

//Function Number: 11
func_530F()
{
	var_00 = getentarray("animated_soldier","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_165))
		{
			var_02.color = var_02.var_165;
		}

		if(isdefined(var_02.var_106))
		{
			var_02.var_18A8 = var_02.var_106;
		}

		var_02 maps\mp\gametypes\_hub_unk1::func_8627();
		if(isdefined(var_02.var_EA4))
		{
			if(var_02.var_EA4 == "mp_hub_reading_a_guy01")
			{
				var_02 attach("cob_book_01","tag_weapon_right");
			}

			if(var_02.var_EA4 == "mp_hub_conversation_c_guy02")
			{
				var_02 attach("npc_usa_m1garand_base","tag_weapon_right");
			}

			if(var_02.var_EA4 == "mp_hub_cleaning_rifle_guy01")
			{
				var_03 = spawn("script_model",(0,0,0));
				var_03 setmodel("npc_usa_m1garand_base");
				var_03 hidepart("tag_clip_extmag");
				var_03 linkto(var_02,"tag_weapon_right",(0,0,0),(0,0,0));
			}

			var_02 thread func_71FE();
		}

		wait 0.05;
	}
}

//Function Number: 12
func_772F(param_00,param_01)
{
}

//Function Number: 13
func_92B9()
{
	var_00 = common_scripts\utility::func_46B5("baseball_scripted_node","targetname");
	func_772F("baseball_scripted_node",var_00);
	var_01 = spawn("script_model",var_00.var_116);
	var_01 maps\mp\gametypes\_hub_unk1::func_8627();
	var_02 = spawn("script_model",var_00.var_116);
	var_02 maps\mp\gametypes\_hub_unk1::func_8627();
	var_03 = spawn("script_model",var_00.var_116);
	var_03 setmodel("mp_hub_baseball_glove_01");
	var_03 linkto(var_01,"tag_weapon_left",(0,0,0),(0,0,0));
	var_04 = spawn("script_model",var_00.var_116);
	var_04 setmodel("mp_hub_baseball_glove_01");
	var_04 linkto(var_02,"tag_weapon_left",(0,0,0),(0,0,0));
	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel("mp_hub_baseball_01");
	var_05 linkto(var_01,"tag_weapon_right",(0,0,0),(0,0,0));
	var_03 scriptmodelplayanim("mp_hub_baseball_guy1_glove");
	var_04 scriptmodelplayanim("mp_hub_baseball_guy2_glove");
	var_05 scriptmodelplayanim("mp_hub_baseball");
	var_01 method_8495("mp_hub_baseball_guy1",var_00.var_116,var_00.var_1D);
	var_02 method_8495("mp_hub_baseball_guy2",var_00.var_116,var_00.var_1D);
}

//Function Number: 14
func_92E3()
{
	var_00 = common_scripts\utility::func_46B5("knife_thrower_scripted_node","targetname");
	func_772F("knife_thrower_scripted_node",var_00);
	var_01 = spawn("script_model",var_00.var_116);
	var_01 setmodel("usa_hubd_org1");
	var_01 maps\mp\gametypes\_hub_unk1::func_8627();
	var_02 = spawn("script_model",var_00.var_116);
	var_02 setmodel("npc_usa_combat_knife");
	var_02 linkto(var_01,"tag_weapon_right",(0,0,0),(0,0,0));
	var_01 method_8495("mp_hub_knife_throw_idle",var_00.var_116,var_00.var_1D);
	var_02 scriptmodelplayanim("mp_hub_knife");
}

//Function Number: 15
func_92FE()
{
	var_00 = common_scripts\utility::func_46B5("scripted_node_requisitions_background","targetname");
	func_772F("scripted_node_requisitions_background",var_00);
	var_01 = spawn("script_model",var_00.var_116);
	var_01 maps\mp\gametypes\_hub_unk1::func_8627();
	var_02 = spawn("script_model",var_00.var_116);
	var_02 maps\mp\gametypes\_hub_unk1::func_8627();
	var_03 = spawn("script_model",var_00.var_116);
	var_03 maps\mp\gametypes\_hub_unk1::func_8627();
	var_04 = spawn("script_model",var_00.var_116);
	var_04 maps\mp\gametypes\_hub_unk1::func_8627();
	var_05 = spawn("script_model",var_00.var_116);
	var_05 maps\mp\gametypes\_hub_unk1::func_8627();
	var_06 = spawn("script_model",var_00.var_116);
	var_06 setmodel("usa_phone_ee8");
	var_07 = spawn("script_model",var_00.var_116);
	var_07 setmodel("usa_phone_ee8");
	var_08 = spawn("script_model",var_00.var_116);
	var_08 setmodel("usa_phone_ee8");
	var_09 = spawn("script_model",var_00.var_116);
	var_09 maps\mp\gametypes\_hub_unk1::func_8627();
	var_0A = spawn("script_model",var_00.var_116);
	var_0A maps\mp\gametypes\_hub_unk1::func_8627();
	var_01 method_8495("mp_hub_ro_radio_guy_01_idle",var_00.var_116,var_00.var_1D);
	var_02 method_8495("mp_hub_ro_radio_guy_02_idle",var_00.var_116,var_00.var_1D);
	var_03 method_8495("mp_hub_ro_radio_guy_03_idle",var_00.var_116,var_00.var_1D);
	var_04 method_8495("mp_hub_ro_phone_guy_01_idle",var_00.var_116,var_00.var_1D);
	var_05 method_8495("mp_hub_ro_phone_guy_02_idle",var_00.var_116,var_00.var_1D);
	var_06 method_8495("mp_hub_ro_phone_guy_01_idle_phone",var_00.var_116,var_00.var_1D);
	var_07 method_8495("mp_hub_ro_phone_guy_02_idle_phone",var_00.var_116,var_00.var_1D);
	var_08 method_8495("mp_hub_ro_phone_guy_03_idle_phone",var_00.var_116,var_00.var_1D);
	var_09 method_8495("mp_hub_ro_teletype_guy_01_idle",var_00.var_116,var_00.var_1D);
	var_0A method_8495("mp_hub_ro_teletype_guy_02_idle",var_00.var_116,var_00.var_1D);
}

//Function Number: 16
func_64A6()
{
	var_00 = getent("firing_range_wall","targetname");
	var_01 = getent("firing_range_wall_clip","targetname");
	var_02 = common_scripts\utility::func_46B5("firing_range_wall_position","targetname");
	var_03 = common_scripts\utility::func_46B5("firing_range_wall_door_position","targetname");
	var_04 = spawn("script_model",var_02.var_116);
	var_04 clonebrushmodeltoscriptmodel(var_00);
	var_05 = spawn("script_model",var_02.var_116);
	var_05 clonebrushmodeltoscriptmodel(var_01);
	var_06 = spawn("script_model",var_03.var_116);
	var_06 setmodel("ndy_door_bunker_01");
	var_06.var_1D = (0,180,0);
	level.var_3C41 = 1;
	level thread func_6397(var_04,var_05,var_06);
}

//Function Number: 17
func_6397(param_00,param_01,param_02)
{
	level waittill("delete_fr_wall");
	param_00 delete();
	param_01 delete();
	param_02 delete();
	level.var_3C41 = 0;
}

//Function Number: 18
func_5311()
{
	level endon("game_ended");
}

//Function Number: 19
func_749F()
{
	playfxontag(common_scripts\utility::func_44F5("npc_footstep_spawner"),self,"J_Ankle_LE");
	playfxontag(common_scripts\utility::func_44F5("npc_footstep_spawner"),self,"J_Ankle_RI");
}

//Function Number: 20
func_71FE()
{
	wait(randomfloatrange(0.01,3));
	self scriptmodelplayanim(self.var_EA4);
}

//Function Number: 21
func_5319()
{
	level endon("game_ended");
	wait(5);
	var_00 = common_scripts\utility::func_46B5("animated_truck_scripted_node","targetname");
	var_01 = common_scripts\utility::func_46B7("animated_truck_spawner","targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_EA4))
		{
			var_03 thread func_9151(var_00);
		}

		wait 0.05;
	}
}

//Function Number: 22
func_9151(param_00)
{
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		var_01 = spawn("script_model",self.var_116);
		var_01 setmodel("vehicle_usa_trans_cckw_base_hub");
		var_01.var_1D = self.var_1D;
		var_01.var_1A5 = "truck";
		var_01 method_8495(self.var_EA4,param_00.var_116,param_00.var_1D,"animEnded");
		var_01 lib_0378::func_8D74("truck_grp_a_moving");
		var_02 = spawn("script_model",(0,0,0));
		var_02.var_1D = self.var_1D;
		var_02 maps\mp\gametypes\_hub_unk1::func_8627();
		switch(self.var_EA4)
		{
			case "mp_hub_beach_road_truck_a":
				var_03 = "mp_hub_beach_road_truck_driver_a";
				break;
	
			case "mp_hub_beach_road_truck_b":
				var_03 = "mp_hub_beach_road_truck_driver_b";
				break;
	
			case "mp_hub_beach_road_truck_c":
				var_03 = "mp_hub_beach_road_truck_driver_c";
				break;
	
			case "mp_hub_beach_road_truck_d":
				var_03 = "mp_hub_beach_road_truck_driver_d";
				break;
	
			default:
				var_03 = "";
				break;
		}

		var_02 method_8495(var_03,param_00.var_116,param_00.var_1D,"animEnded");
		var_02.var_1A5 = "truckDriver";
		var_01 thread maps\mp\gametypes\_hub_unk1::func_2DD4("animEnded");
		var_02 thread maps\mp\gametypes\_hub_unk1::func_2DD4("animEnded");
		wait(47.5);
	}
}

//Function Number: 23
func_9152()
{
	level endon("game_ended");
	var_00 = 2;
	var_01 = 0;
	while(var_01 < var_00)
	{
		var_02 = spawn("script_model",self.var_116);
		var_02 setmodel("vehicle_usa_trans_cckw_base_hub");
		var_02.var_1D = self.var_1D;
		var_02.var_1A5 = "truck";
		var_02 method_8278(self.var_EA4);
		playfxontag(common_scripts\utility::func_44F5("ambient_truck_tread_sand"),var_02,"tag_origin");
		var_03 = spawn("script_model",var_02.var_116);
		var_03 maps\mp\gametypes\_hub_unk1::func_8627();
		var_03.var_1D = var_02.var_1D;
		var_03 method_8278("generic_land_driver_idle");
		var_03.var_1A5 = "truckDriver";
		var_03 method_8449(var_02,"tag_origin",(38,10,42),(0,0,0));
		var_01++;
		wait(95);
	}
}

//Function Number: 24
func_4AF6()
{
	level waittill("connected");
	wait 0.05;
	if(level.var_4F50)
	{
		return;
	}

	wait(1);
	while(!isdefined(level.var_781C))
	{
		wait(1);
	}

	var_00 = common_scripts\utility::func_46B5("animated_truck_spawner_spawn_1","targetname");
	var_01 = common_scripts\utility::func_46B5("animated_truck_spawner_spawn_2","targetname");
	var_02 = spawn("script_model",var_00.var_116);
	var_02 setmodel("vehicle_usa_trans_cckw_base_hub");
	var_02.var_1D = var_00.var_1D;
	playfxontag(common_scripts\utility::func_44F5("ambient_truck_tread_sand"),var_02,"tag_origin");
	var_03 = spawn("script_model",var_00.var_116);
	var_03 maps\mp\gametypes\_hub_unk1::func_8627();
	var_03.var_1D = var_00.var_1D;
	var_03 method_8278("generic_land_driver_idle");
	var_03 method_8449(var_02,"tag_origin",(38,10,42),(0,0,0));
	var_04 = spawn("script_model",var_01.var_116);
	var_04 setmodel("vehicle_usa_trans_cckw_base_hub");
	var_04.var_1D = var_01.var_1D;
	playfxontag(common_scripts\utility::func_44F5("ambient_truck_tread_sand"),var_04,"tag_origin");
	var_05 = spawn("script_model",var_01.var_116);
	var_05 maps\mp\gametypes\_hub_unk1::func_8627();
	var_05.var_1D = var_01.var_1D;
	var_05 method_8278("generic_land_driver_idle");
	var_05 method_8449(var_04,"tag_origin",(38,10,42),(0,0,0));
	var_02 thread func_4AF5("mp_hub_beach_road_truck_f",var_00);
	var_04 thread func_4AF5("mp_hub_beach_road_truck_e",var_01);
	lib_0378::func_8D74("truck_grp_b_moving",var_02,var_04);
	level.var_781C.var_EAC["mp_hub_quarter_master_twitch_a"] = spawnstruct();
	level.var_781C.var_EAC["mp_hub_quarter_master_twitch_a"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
	level.var_781C.var_EAC["mp_hub_quarter_master_twitch_a"].var_F5D = [var_02,"truckDrive",var_04,"truckDrive"];
	level.var_781C.var_EAC["mp_hub_quarter_master_coffee_twitch_a"] = spawnstruct();
	level.var_781C.var_EAC["mp_hub_quarter_master_coffee_twitch_a"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
	level.var_781C.var_EAC["mp_hub_quarter_master_coffee_twitch_a"].var_F5D = [var_02,"truckDrive",var_04,"truckDrive"];
}

//Function Number: 25
func_4AF5(param_00,param_01)
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("truckDrive");
		self scriptmodelclearanim();
		self.var_116 = param_01.var_116;
		self.var_1D = param_01.var_1D;
		self method_8278(param_00,"animEnded");
	}
}

//Function Number: 26
func_5337()
{
	var_00 = common_scripts\utility::func_46B5("qmAnimEvent","targetname");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("usa_hube_org1");
	var_01 method_8495("mp_hub_qm_load_box_qm_private_idle",var_00.var_116,var_00.var_1D);
	wait(20);
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel("hub_lootcrate_a");
	var_02 method_8495("mp_hub_qm_load_box_crate",var_00.var_116,var_00.var_1D);
	var_01 method_8495("mp_hub_qm_load_box_private",var_00.var_116,var_00.var_1D);
	var_03 = spawn("script_model",(0,0,0));
	var_03 setmodel("usa_huba_org1");
	var_03 method_8495("mp_hub_qm_load_box_truck_guy",var_00.var_116,var_00.var_1D);
	var_03 = spawn("script_model",(0,0,0));
	var_03 setmodel("vehicle_usa_trans_cckw_base_hub");
	var_03 method_8495("mp_hub_qm_load_box_truck",var_00.var_116,var_00.var_1D);
	var_03 lib_0378::func_8D74("truck_load");
}

//Function Number: 27
func_5318()
{
	var_00 = getentarray("animated_blimp","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_EA4))
		{
			var_02 thread func_71FE();
		}

		wait 0.05;
	}
}

//Function Number: 28
func_4ABF()
{
	level endon("game_ended");
	setdvarifuninitialized("hub_fr_wall",0);
	level.var_3C41 = 0;
	if(getdvarint("986",0) == 1)
	{
		thread func_64A6();
	}
}

//Function Number: 29
handlespecialeventents()
{
	wait 0.05;
	if(getdvarint("spv_hub_zombie_siege_event_enabled",0) == 1)
	{
		var_00 = function_021F("scriptable pigeons","targetname");
		if(isdefined(var_00))
		{
			foreach(var_02 in var_00)
			{
				var_02 delete();
			}
		}

		var_04 = function_021F("scriptable vista flag","targetname");
		if(isdefined(var_04))
		{
			foreach(var_02 in var_04)
			{
				var_02 delete();
			}
		}
	}
}

//Function Number: 30
inithubholidayspawns()
{
	var_00 = spawn("script_model",(-182,827.5,-23.5));
	var_00.var_1D = (0,0,0);
	var_00 setmodel("foliage_s2_nor_spruce_tree_med_02");
}

//Function Number: 31
initresistancedevices()
{
	level endon("game_ended");
	if(getdvarint("spv_hub_resistance_event_enabled") == 1 && isdefined(level.devicesbegintrigger) && isdefined(level.deviceinteract))
	{
		level.devicesbegintrigger sethintstring(&"HUB_DEVICES_01");
		level.deviceinteract sethintstring(&"HUB_DEVICES_02");
		for(;;)
		{
			level.devicesbegintrigger waittill("trigger",var_00);
			if(isplayer(var_00))
			{
				thread begindevicesequence();
				common_scripts\utility::func_9D9F("resistance_discoverable_begin","targetname");
			}

			level.devicesbegintrigger waittill("event_complete");
			common_scripts\utility::func_9DA3("resistance_discoverable_begin","targetname");
		}
	}
}

//Function Number: 32
setupdevicestructs()
{
	if(!isdefined(level.device01))
	{
		level.device01 = spawnstruct();
	}

	level.device01.var_116 = (-1518,3728,-349.5);
	level.device01.var_1D = (0,333.8,0);
	level.devicestructs[0] = level.device01;
	if(!isdefined(level.device02))
	{
		level.device02 = spawnstruct();
	}

	level.device02.var_116 = (-1554,3407.5,-304.8);
	level.device02.var_1D = (0,77.6,0);
	level.devicestructs[1] = level.device02;
	if(!isdefined(level.device03))
	{
		level.device03 = spawnstruct();
	}

	level.device03.var_116 = (-994.5,3355.5,-309.5);
	level.device03.var_1D = (0,139.3,0);
	level.devicestructs[2] = level.device03;
	if(!isdefined(level.device04))
	{
		level.device04 = spawnstruct();
	}

	level.device04.var_116 = (-822,2697,-390);
	level.device04.var_1D = (0,125,0);
	level.devicestructs[3] = level.device04;
	if(!isdefined(level.device05))
	{
		level.device05 = spawnstruct();
	}

	level.device05.var_116 = (-105.5,3531,-321);
	level.device05.var_1D = (0,180,0);
	level.devicestructs[4] = level.device05;
	if(!isdefined(level.device06))
	{
		level.device06 = spawnstruct();
	}

	level.device06.var_116 = (738.5,3073.5,-182);
	level.device06.var_1D = (0,345,0);
	level.devicestructs[5] = level.device06;
	if(!isdefined(level.device07))
	{
		level.device07 = spawnstruct();
	}

	level.device07.var_116 = (183,3224,-252);
	level.device07.var_1D = (0,281,0);
	level.devicestructs[6] = level.device07;
	if(!isdefined(level.device08))
	{
		level.device08 = spawnstruct();
	}

	level.device08.var_116 = (-463.5,3611,-311);
	level.device08.var_1D = (0,308,0);
	level.devicestructs[7] = level.device08;
	if(!isdefined(level.device09))
	{
		level.device09 = spawnstruct();
	}

	level.device09.var_116 = (-692.5,3808.5,-341.3);
	level.device09.var_1D = (0,170,0);
	level.devicestructs[8] = level.device09;
	if(!isdefined(level.device10))
	{
		level.device10 = spawnstruct();
	}

	level.device10.var_116 = (-660,3373.5,-313.3);
	level.device10.var_1D = (0,36,0);
	level.devicestructs[9] = level.device10;
	if(!isdefined(level.device11))
	{
		level.device11 = spawnstruct();
	}

	level.device11.var_116 = (-1556,2323.5,-103);
	level.device11.var_1D = (0,155,0);
	level.devicestructs[10] = level.device11;
	if(!isdefined(level.device12))
	{
		level.device12 = spawnstruct();
	}

	level.device12.var_116 = (-511,2332.5,-118);
	level.device12.var_1D = (1.23696,172.769,2.94067);
	level.devicestructs[11] = level.device12;
	if(!isdefined(level.device13))
	{
		level.device13 = spawnstruct();
	}

	level.device13.var_116 = (-1085.5,2346,-1);
	level.device13.var_1D = (353.859,359.145,7.94397);
	level.devicestructs[12] = level.device13;
	if(!isdefined(level.device14))
	{
		level.device14 = spawnstruct();
	}

	level.device14.var_116 = (-174.5,2578,-144);
	level.device14.var_1D = (341.999,290.738,-18.5732);
	level.devicestructs[13] = level.device14;
	if(!isdefined(level.device15))
	{
		level.device15 = spawnstruct();
	}

	level.device15.var_116 = (-1183.5,3884.5,-321);
	level.device15.var_1D = (0,226,0);
	level.devicestructs[14] = level.device15;
	if(!isdefined(level.device16))
	{
		level.device16 = spawnstruct();
	}

	level.device16.var_116 = (-1603.5,1874.5,-104);
	level.device16.var_1D = (0,132,0);
	level.devicestructs[15] = level.device16;
	if(!isdefined(level.device17))
	{
		level.device17 = spawnstruct();
	}

	level.device17.var_116 = (-626,1594.5,59.8);
	level.device17.var_1D = (0,322,0);
	level.devicestructs[16] = level.device17;
	if(!isdefined(level.device18))
	{
		level.device18 = spawnstruct();
	}

	level.device18.var_116 = (265.5,1718,3.9);
	level.device18.var_1D = (0,253.7,0);
	level.devicestructs[17] = level.device18;
	if(!isdefined(level.device19))
	{
		level.device19 = spawnstruct();
	}

	level.device19.var_116 = (-531,793.5,7.7);
	level.device19.var_1D = (0,127,0);
	level.devicestructs[18] = level.device19;
	if(!isdefined(level.device20))
	{
		level.device20 = spawnstruct();
	}

	level.device20.var_116 = (416.5,597.5,7.2);
	level.device20.var_1D = (0,215.9,0);
	level.devicestructs[19] = level.device20;
}

//Function Number: 33
begindevicesequence()
{
	level endon("game_ended");
	setupdevicestructs();
	iprintln(&"HUB_DEVICES_03");
	var_00 = [];
	var_01 = 0;
	var_02 = 10;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = common_scripts\utility::func_7A33(level.devicestructs);
		var_00[var_03] = var_04;
		level.devicestructs = common_scripts\utility::func_F93(level.devicestructs,var_04);
	}

	foreach(var_06 in var_00)
	{
		level.deviceinteract thread devicetimeout();
		level.deviceinteract.var_116 = var_06.var_116;
		var_07 = spawn("script_model",var_06.var_116);
		var_07.var_1D = var_06.var_1D;
		var_07 setmodel("hub_resistance_device_radio");
		var_07 method_8617("mp_hammerhead_morse_lp");
		playfxontag(common_scripts\utility::func_44F5("hub_resistance_radio_ping"),var_07,"tag_origin");
		var_08 = level.deviceinteract common_scripts\utility::func_A715("timed_out","trigger");
		if(var_08 == "timed_out")
		{
			playsoundatpos(var_07.var_116,"mp_ui_resistance_decoder_shutoff");
			var_07 delete();
			var_01 = 0;
			break;
		}
		else
		{
			var_01++;
			if(var_01 != var_02)
			{
				iprintln(&"HUB_DEVICES_04");
			}

			level.deviceinteract notify("decoded");
			playfx(common_scripts\utility::func_44F5("hub_resistance_radio_ping"),var_07.var_116);
			playsoundatpos(var_07.var_116,"mp_ui_resistance_decoder_shutoff");
			var_07 delete();
		}
	}

	if(var_01 == var_02)
	{
		iprintln(&"HUB_DEVICES_05");
		level.deviceinteract.var_116 = (-936,4228,-544);
		thread spawnresistancebomber();
		wait(120);
	}
	else
	{
		iprintln(&"HUB_DEVICES_06");
	}

	level.deviceinteract.var_116 = (-936,4228,-544);
	level.devicesbegintrigger notify("event_complete");
}

//Function Number: 34
devicetimeout()
{
	level endon("game_ended");
	self endon("decoded");
	wait(20);
	self notify("timed_out");
}

//Function Number: 35
spawnresistancebomber()
{
	var_00 = getent("resistance_plane_spawn","targetname");
	var_01 = spawn("script_model",var_00.var_116);
	var_01.var_1D = (0,90,0);
	var_01 setmodel("usa_bomber_commando_vista");
	var_01 method_8278("mp_hub_resistance_bomber");
	var_01 lib_0378::func_8D74("res_bomber_flyby_start");
	wait(20);
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 36
monitorresistancebomber()
{
	level endon("game_ended");
	while(getdvarint("hub_complete_device_sequence",0) == 0)
	{
		wait(1);
	}

	spawnresistancebomber();
	setdvar("hub_complete_device_sequence",0);
	thread monitorresistancebomber();
}

//Function Number: 37
theaterscreenswap()
{
	var_00 = getdvarint("spv_hub_cwl_theater_screen",0);
	if(var_00 == 0)
	{
		return;
	}

	if(!level.var_148 && !level.var_149)
	{
		return;
	}

	var_01 = "hub_theatre_screen_card_foreground";
	switch(var_00)
	{
		case 1:
			var_01 = "hub_theatre_screen_foreground_cwl";
			break;

		case 2:
			var_01 = "hub_theatre_screen_foreground_cwl_championship";
			break;

		case 3:
			var_01 = "hub_theatre_screen_foreground_cwl_atlanta";
			break;

		case 4:
			var_01 = "hub_theatre_screen_foreground_cwl_birmingham";
			break;

		case 5:
			var_01 = "hub_theatre_screen_foreground_cwl_seattle";
			break;

		case 6:
			var_01 = "hub_theatre_screen_foreground_cwl_anaheim";
			break;

		default:
			break;
	}

	var_02 = getent("theater_screen_foreground","targetname");
	var_02 delete();
	var_03 = spawn("script_model",(-1516.1,2098.48,-21));
	var_03 setmodel(var_01);
	var_03.var_1D = (0,85.4998,0);
}

//Function Number: 38
func_5376()
{
	wait 0.05;
	thread func_52C5();
	thread func_5355();
	thread func_5298();
	thread func_5324();
	thread func_535F();
	thread func_52BA();
}

//Function Number: 39
func_52C5()
{
	var_00 = getent("hq_zone_trigger","targetname");
	level.var_ACBC = var_00;
	level.var_ACBC thread maps\mp\_dynamic_world::func_9DC3(::func_4F46,::func_4F47);
}

//Function Number: 40
func_5298()
{
	var_00 = getent("beach_zone_trigger","targetname");
	level.var_ACBA = var_00;
	level.var_ACBA thread maps\mp\_dynamic_world::func_9DC3(::func_4F46,::func_4F47);
}

//Function Number: 41
func_5355()
{
	var_00 = getent("spawn_zone_trigger","targetname");
	level.var_ACBF = var_00;
	level.var_ACBF thread maps\mp\_dynamic_world::func_9DC3(::func_4F46,::func_4F47);
}

//Function Number: 42
func_5324()
{
	var_00 = getent("offTower_zone_trigger","targetname");
	level.var_ACBE = var_00;
	level.var_ACBE thread maps\mp\_dynamic_world::func_9DC3(::func_4F46,::func_4F47);
}

//Function Number: 43
func_535F()
{
	var_00 = getent("theatre_zone_trigger","targetname");
	level.var_ACC0 = var_00;
	level.var_ACC0 thread maps\mp\_dynamic_world::func_9DC3(::func_4F46,::func_4F47);
}

//Function Number: 44
func_52BA()
{
	var_00 = getent("firingrange_zone_trigger","targetname");
	level.var_ACBB = var_00;
	level.var_ACBB thread maps\mp\_dynamic_world::func_9DC3(::func_4F46,::func_4F47);
}

//Function Number: 45
func_4F46(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_295A) && self.var_295A == param_00.var_1A5)
	{
		return;
	}

	if(!isdefined(self.var_56C8))
	{
		self.var_56C8 = 0;
	}

	if(self.var_56C8)
	{
		wait(2.5);
		if(!param_00 method_858B(self.var_116))
		{
			return;
		}
	}

	self.var_295A = param_00.var_1A5;
	if(!self.var_572F)
	{
		maps\mp\gametypes\_hub_unk1::func_4F44(self.var_295A);
	}
}

//Function Number: 46
func_4F47(param_00)
{
}