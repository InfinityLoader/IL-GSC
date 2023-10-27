/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_code.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 55
 * Decompile Time: 873 ms
 * Timestamp: 10/27/2023 1:39:22 AM
*******************************************************************/

//Function Number: 1
get_channel_array()
{
	var_00 = [];
	var_00["physics"] = "physics";
	var_00["ambdist1"] = "ambdist1";
	var_00["ambdist2"] = "ambdist2";
	var_00["alarm"] = "alarm";
	var_00["auto"] = "auto";
	var_00["auto2"] = "auto2";
	var_00["auto2d"] = "auto2d";
	var_00["autodog"] = "autodog";
	var_00["explosiondist1"] = "explosiondist1";
	var_00["explosiondist2"] = "explosiondist2";
	var_00["explosiveimpact"] = "explosiveimpact";
	var_00["element"] = "element";
	var_00["foley_plr_mvmt"] = "foley_plr_mvmt";
	var_00["foley_plr_weap"] = "foley_plr_weap";
	var_00["foley_npc_mvmt"] = "foley_npc_mvmt";
	var_00["foley_npc_weap"] = "foley_npc_weap";
	var_00["element_int"] = "element_int";
	var_00["element_ext"] = "element_ext";
	var_00["foley_dog_mvmt"] = "foley_dog_mvmt";
	var_00["voice_dog"] = "voice_dog";
	var_00["element_lim"] = "element_lim";
	var_00["element2d"] = "element2d";
	var_00["voice_dog_dist"] = "voice_dog_dist";
	var_00["bulletflesh1npc_npc"] = "bulletflesh1npc_npc";
	var_00["bulletflesh2npc_npc"] = "bulletflesh2npc_npc";
	var_00["bulletimpact"] = "bulletimpact";
	var_00["bulletflesh1"] = "bulletflesh1";
	var_00["bulletflesh2"] = "bulletflesh2";
	var_00["vehicle"] = "vehicle";
	var_00["vehiclelimited"] = "vehiclelimited";
	var_00["menu"] = "menu";
	var_00["menulim1"] = "menulim1";
	var_00["menulim2"] = "menulim2";
	var_00["bulletflesh1npc"] = "bulletflesh1npc";
	var_00["bulletflesh2npc"] = "bulletflesh2npc";
	var_00["bulletwhizbyin"] = "bulletwhizbyin";
	var_00["bulletwhizbyout"] = "bulletwhizbyout";
	var_00["body"] = "body";
	var_00["body2d"] = "body2d";
	var_00["reload"] = "reload";
	var_00["reload2d"] = "reload2d";
	var_00["foley_plr_step"] = "foley_plr_step";
	var_00["foley_plr_step_unres"] = "foley_plr_step";
	var_00["foley_npc_step"] = "foley_npc_step";
	var_00["foley_dog_step"] = "foley_dog_step";
	var_00["item"] = "item";
	var_00["weapon_drone"] = "weapon_drone";
	var_00["explosion1"] = "explosion1";
	var_00["explosion2"] = "explosion2";
	var_00["explosion3"] = "explosion3";
	var_00["explosion4"] = "explosion4";
	var_00["explosion5"] = "explosion5";
	var_00["effects1"] = "effects1";
	var_00["effects2"] = "effects2";
	var_00["effects3"] = "effects3";
	var_00["effects2d1"] = "effects2d1";
	var_00["effects2d2"] = "effects2d2";
	var_00["norestrict"] = "norestrict";
	var_00["norestrict2d"] = "norestrict2d";
	var_00["aircraft"] = "aircraft";
	var_00["vehicle2d"] = "vehicle2d";
	var_00["weapon_dist"] = "weapon_dist";
	var_00["weapon_mid"] = "weapon_mid";
	var_00["weapon"] = "weapon";
	var_00["weapon2d"] = "weapon2d";
	var_00["nonshock"] = "nonshock";
	var_00["nonshock2"] = "nonshock2";
	var_00["voice"] = "voice";
	var_00["music_emitter"] = "music_emitter";
	var_00["voice_dog_attack"] = "voice_dog_attack";
	var_00["local"] = "local";
	var_00["local2"] = "local2";
	var_00["local3"] = "local3";
	var_00["ambient"] = "ambient";
	var_00["plr_weap_fire_2d"] = "plr_weap_fire_2d";
	var_00["plr_weap_mech_2d"] = "plr_weap_mech_2d";
	var_00["hurt"] = "hurt";
	var_00["player1"] = "player1";
	var_00["player2"] = "player2";
	var_00["music"] = "music";
	var_00["musicnopause"] = "musicnopause";
	var_00["mission"] = "mission";
	var_00["missionfx"] = "missionfx";
	var_00["announcer"] = "announcer";
	var_00["shellshock"] = "shellshock";
	return var_00;
}

//Function Number: 2
cache_ambient(param_00)
{
	if(isdefined(level._audio.ambient.cached_ambients[param_00]))
	{
	}

	var_01 = ["ambient_name","time_min","time_max"];
	var_02 = func_39B7(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	var_02["time_min"] = func_7CE3(var_02["time_min"]);
	var_02["time_max"] = func_7CE3(var_02["time_max"]);
	var_02["time"] = [var_02["time_min"],var_02["time_max"]];
	var_02["time_min"] = undefined;
	var_02["time_max"] = undefined;
	var_03 = addstruct();
	var_03.data = var_02;
	if(var_02["time"][0] > 0 && var_02["time"][1] > 0)
	{
		var_03.var_6E10 = 1;
	}

	level._audio.ambient.cached_ambients[param_00] = var_03;
	cache_ambient_event(param_00);
}

//Function Number: 3
cache_ambient_event(param_00)
{
	var_01 = ["ambient_event","element","weight"];
	var_02 = func_39B8(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	foreach(var_05, var_04 in var_02)
	{
		var_02[var_05]["weight"] = func_7CE3(var_04["weight"]);
	}

	var_06 = [];
	foreach(var_04 in var_02)
	{
		var_08 = addstruct();
		var_08.elem = var_04["element"];
		var_08.weight = var_04["weight"];
		var_06[var_06.size] = var_08;
		cache_ambient_element(var_08);
	}

	level._audio.ambient.cached_ambients[param_00].var_3039 = var_06;
}

//Function Number: 4
cache_ambient_element(param_00)
{
	var_01 = param_00.elem;
	if(isdefined(level._audio.ambient.cached_elems[var_01]))
	{
	}

	var_02 = ["ambient_element","alias","range_min","range_max","cone_min","cone_max","time_min","time_max","travel_min","travel_max","travel_time_min","travel_time_max"];
	var_03 = func_39B7(get_map_soundtable(),var_01,var_02);
	if(var_03.size == 0)
	{
	}

	foreach(var_06, var_05 in var_03)
	{
		if(var_05 == "")
		{
			var_03[var_06] = undefined;
			continue;
		}

		if(var_06 == "alias")
		{
			continue;
		}

		var_03[var_06] = func_7CE3(var_03[var_06]);
	}

	var_07 = ["range","cone","time","travel","travel_time"];
	foreach(var_09 in var_07)
	{
		if(isdefined(var_03[var_09 + "_min"]) && isdefined(var_03[var_09 + "_max"]))
		{
			var_03[var_09] = [var_03[var_09 + "_min"],var_03[var_09 + "_max"]];
			var_03[var_09 + "_min"] = undefined;
			var_03[var_09 + "_max"] = undefined;
		}
	}

	level._audio.ambient.cached_elems[var_01] = var_03;
}

//Function Number: 5
cache_zone(param_00)
{
	if(isdefined(level._audio.zone.cached[param_00]))
	{
	}

	var_01 = ["zone_name","ambience","ambient_name","mix","reverb","filter","occlusion"];
	var_02 = func_39B7(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	level._audio.zone.cached[param_00] = var_02;
}

//Function Number: 6
func_3A03(param_00,param_01)
{
	if(!isdefined(level._audio.zone.cached[param_00]))
	{
		cache_zone(param_00);
		if(!isdefined(level._audio.zone.cached[param_00]))
		{
			debug_warning("Couldn\'t find zone: " + param_00);
			return undefined;
		}
	}

	var_02 = level._audio.zone.cached[param_00];
	if(!isdefined(level._audio.zone.cached[param_01]))
	{
		cache_zone(param_01);
		if(!isdefined(level._audio.zone.cached[param_01]))
		{
			debug_warning("Couldn\'t find zone: " + param_01);
			return undefined;
		}
	}

	var_03 = level._audio.zone.cached[param_01];
	var_04 = ["ambience","occlusion","filter","reverb","mix"];
	var_05 = [];
	var_05["zone1"] = param_00;
	var_05["zone2"] = param_01;
	foreach(var_07 in var_04)
	{
		var_05[var_07 + "1"] = var_02[var_07];
		var_05[var_07 + "2"] = var_03[var_07];
	}

	var_05["ambient_name1"] = level._audio.ambient.var_21E6;
	maps\_audio_ambient::func_7C1A();
	var_05["ambient_name2"] = var_03["ambient_name"];
	return var_05;
}

//Function Number: 7
func_47E5(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 0;
	}

	if(isdefined(param_00) || isdefined(param_01))
	{
		return 1;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
is_ambience_blend_valid(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 0;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
blend_zones(param_00,param_01,param_02,param_03)
{
	var_04 = [param_00,param_01];
	var_05 = var_04;
	if(param_03)
	{
		var_05 = common_scripts\utility::array_reverse(var_05);
	}

	if(is_ambience_blend_valid(param_02["ambience1"],param_02["ambience2"]))
	{
		var_06 = [];
		for(var_07 = 0;var_07 < 2;var_07++)
		{
			var_08 = var_07 + 1;
			var_09 = "ambience" + var_08;
			if(isdefined(param_02[var_09]) && param_02[var_09] != "")
			{
				var_0A = level._audio.zone.cached[param_02["zone" + var_08]];
				var_06[var_07] = addstruct();
				var_06[var_07].alias = param_02[var_09];
				var_06[var_07].volume = var_04[var_07];
				var_06[var_07].fade = 0.5;
			}
		}

		if(var_06.size > 0)
		{
			maps\_audio::func_52FB(var_06);
		}
	}

	if(func_47E5(param_02["ambient_name1"],param_02["ambient_name2"]))
	{
		maps\_audio_ambient::func_7D8F(param_02["ambient_name1"],param_00,param_02["ambient_name2"],param_01);
	}

	var_0B = 0;
	for(var_07 = 0;var_07 < 2;var_07++)
	{
		var_08 = var_07 + 1;
		var_0C = undefined;
		if(isdefined(param_02["filter" + var_08]))
		{
			var_0B++;
			var_0C = param_02["filter" + var_08];
		}

		if(!isdefined(var_0C) || var_0C == "")
		{
			maps\_audio::clear_filter(var_07);
			continue;
		}

		maps\_audio::func_6EB5(var_0C,var_07);
	}

	if(var_0B == 2)
	{
		level.player method_8285(var_05[0],0);
	}

	if(param_00 >= 0.75)
	{
		if(isdefined(param_02["reverb1"]))
		{
			if(param_02["reverb1"] == "")
			{
			}
			else
			{
				maps\_audio::func_6F84(param_02["reverb1"]);
			}
		}

		if(isdefined(param_02["mix1"]))
		{
			if(param_02["mix1"] == "")
			{
				maps\_audio::clear_mix(2);
			}
			else
			{
				maps\_audio::func_6F26(param_02["mix1"]);
			}
		}

		if(isdefined(param_02["occlusion1"]))
		{
			if(param_02["occlusion1"] == "")
			{
				maps\_audio::deactivate_occlusion();
			}

			maps\_audio::func_6F37(param_02["occlusion1"]);
		}
	}

	if(param_01 >= 0.75)
	{
		if(isdefined(param_02["reverb2"]))
		{
			if(param_02["reverb2"] == "")
			{
			}
			else
			{
				maps\_audio::func_6F84(param_02["reverb2"]);
			}
		}

		if(isdefined(param_02["mix2"]))
		{
			if(param_02["mix2"] == "")
			{
				maps\_audio::clear_mix(2);
			}
			else
			{
				maps\_audio::func_6F26(param_02["mix2"]);
			}
		}

		if(isdefined(param_02["occlusion2"]))
		{
			if(param_02["occlusion2"] == "")
			{
				maps\_audio::deactivate_occlusion();
			}

			maps\_audio::func_6F37(param_02["occlusion2"]);
		}
	}
}

//Function Number: 10
func_3832()
{
	return level._audio.zone.var_21E6;
}

//Function Number: 11
func_6E6C(param_00)
{
	level._audio.zone.var_21E6 = param_00;
}

//Function Number: 12
func_8814(param_00,param_01)
{
}

//Function Number: 13
func_190B(param_00)
{
	if(isdefined(level._audio.filter.cached[param_00]))
	{
	}

	var_01 = ["filter_name","channel","band","type","freq","gain","q"];
	var_02 = func_39B8(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	foreach(var_05, var_04 in var_02)
	{
		var_02[var_05]["band"] = func_7CE4(var_04["band"]);
		var_02[var_05]["freq"] = func_7CE3(var_04["freq"]);
		var_02[var_05]["gain"] = func_7CE3(var_04["gain"]);
		var_02[var_05]["q"] = func_7CE3(var_04["q"]);
	}

	level._audio.filter.cached[param_00] = var_02;
}

//Function Number: 14
cache_occlusion(param_00)
{
	if(isdefined(level._audio.occlusion.cached[param_00]))
	{
	}

	var_01 = ["occlusion_name","channel","freq","type","gain","q"];
	var_02 = func_39B8(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	foreach(var_05, var_04 in var_02)
	{
		var_02[var_05]["freq"] = func_7CE3(var_04["freq"]);
		var_02[var_05]["gain"] = func_7CE3(var_04["gain"]);
		var_02[var_05]["q"] = func_7CE3(var_04["q"]);
	}

	level._audio.occlusion.cached[param_00] = var_02;
}

//Function Number: 15
func_190C(param_00)
{
	if(isdefined(level._audio.mix.cached[param_00]))
	{
	}

	var_01 = ["mix_name","mix_bus","volume","fade"];
	var_02 = func_39B8(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	foreach(var_05, var_04 in var_02)
	{
		var_02[var_05]["volume"] = func_7CE3(var_04["volume"]);
		var_02[var_05]["fade"] = func_7CE3(var_04["fade"]);
		var_02[var_05]["mix_bus"] = undefined;
	}

	level._audio.mix.cached[param_00] = var_02;
}

//Function Number: 16
cache_mix_default()
{
	var_00 = ["mix_bus","volume"];
	var_01 = func_63CB("soundaliases/volumemodgroups.svmod",var_00);
	foreach(var_04, var_03 in var_01)
	{
		var_01[var_04]["volume"] = func_7CE3(var_03["volume"]);
		var_01[var_04]["fade"] = 1;
		var_01[var_04]["mix_bus"] = undefined;
	}

	level._audio.mix.cached["default"] = var_01;
}

//Function Number: 17
cache_reverb(param_00)
{
	if(isdefined(level._audio.var_668D.cached[param_00]))
	{
	}

	var_01 = ["reverb_name","roomtype","drylevel","wetlevel","fade"];
	var_02 = func_39B7(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	var_02["drylevel"] = func_7CE3(var_02["drylevel"]);
	var_02["wetlevel"] = func_7CE3(var_02["wetlevel"]);
	var_02["fade"] = func_7CE3(var_02["fade"]);
	level._audio.var_668D.cached[param_00] = var_02;
}

//Function Number: 18
cache_whizby(param_00)
{
	if(isdefined(level._audio.var_8DE7.cached[param_00]))
	{
	}

	var_01 = ["whizby_name","near_radius","medium_radius","far_radius","radius_offset","near_spread","medium_spread","far_spread","near_prob","medium_prob","far_prob"];
	var_02 = func_39B7(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	foreach(var_05, var_04 in var_02)
	{
		var_02[var_05] = func_7CE3(var_02[var_05]);
	}

	level._audio.var_8DE7.cached[param_00] = var_02;
}

//Function Number: 19
cache_timescale(param_00)
{
	if(isdefined(level._audio.timescale.cached[param_00]))
	{
	}

	var_01 = ["timescale_name","channel","scale"];
	var_02 = func_39B8(get_map_soundtable(),param_00,var_01);
	if(var_02.size == 0)
	{
	}

	foreach(var_05, var_04 in var_02)
	{
		var_02[var_05]["scale"] = func_7CE3(var_04["scale"]);
	}

	level._audio.timescale.cached[param_00] = var_02;
}

//Function Number: 20
func_39B7(param_00,param_01,param_02)
{
	var_03 = [];
	if(tableexists(get_map_soundtable()))
	{
		var_03 = func_39B9(get_map_soundtable(),param_01,param_02,1);
	}

	if(var_03.size == 0)
	{
		func_2402("^2Looking in common soundtable for " + param_01);
		var_03 = func_39B9(func_3824(),param_01,param_02,1);
	}

	return var_03;
}

//Function Number: 21
func_39B8(param_00,param_01,param_02)
{
	var_03 = [];
	if(tableexists(get_map_soundtable()))
	{
		var_03 = func_39B9(get_map_soundtable(),param_01,param_02);
	}

	if(var_03.size == 0)
	{
		func_2402("^2Looking in common soundtable for " + param_01);
		var_03 = func_39B9(func_3824(),param_01,param_02);
	}

	return var_03;
}

//Function Number: 22
func_39B9(param_00,param_01,param_02,param_03)
{
	var_04 = param_02[0];
	var_05 = tablelookuprownum(param_00,0,var_04);
	var_06 = 0;
	var_07 = [];
	if(var_05 < 0)
	{
		return var_07;
	}

	var_08 = undefined;
	for(;;)
	{
		var_05++;
		var_09 = tablelookupbyrow(param_00,var_05,0);
		if(var_09 == "")
		{
			var_06++;
			if(var_06 > 10)
			{
				break;
			}

			continue;
		}

		var_06 = 0;
		if(isdefined(var_08) && var_08 != var_09)
		{
			break;
		}

		if(var_09 != param_01)
		{
			continue;
		}

		if(var_09 == "END_OF_FILE" || func_444E(var_04,var_09))
		{
			break;
		}

		var_08 = param_01;
		var_0A = [];
		var_0B = undefined;
		for(var_0C = 1;var_0C < param_02.size;var_0C++)
		{
			var_0D = tablelookupbyrow(param_00,var_05,var_0C);
			var_0A[param_02[var_0C]] = var_0D;
			if(var_0C == 1)
			{
				var_0B = var_0D;
			}
		}

		if(isdefined(param_03))
		{
			return var_0A;
		}

		var_07[var_0B] = var_0A;
	}

	return var_07;
}

//Function Number: 23
func_444E(param_00,param_01)
{
	var_02 = ["zone_name","whizby_name","reverb_name","mix_name","filter_name","occlusion_name","timescale_name","ambient_name","ambient_event","ambient_element","adsr_name","adsr_zone_player","adsr_zone_npc"];
	var_02 = common_scripts\utility::array_remove(var_02,param_00);
	foreach(var_04 in var_02)
	{
		if(var_04 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
func_63CB(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = [];
	for(;;)
	{
		var_02++;
		var_05 = tablelookupbyrow(param_00,var_02,0);
		if(var_05 == "")
		{
			var_03++;
			if(var_03 > 10)
			{
				break;
			}

			continue;
		}

		var_03 = 0;
		var_06 = [];
		var_06[param_01[0]] = var_05;
		for(var_07 = 1;var_07 < param_01.size;var_07++)
		{
			var_08 = tablelookupbyrow(param_00,var_02,var_07);
			var_06[param_01[var_07]] = var_08;
		}

		var_04[var_05] = var_06;
	}

	return var_04;
}

//Function Number: 25
get_map_soundtable()
{
	return "soundtables/" + common_scripts\utility::func_39CA() + ".csv";
}

//Function Number: 26
func_3824()
{
	return "soundtables/common.csv";
}

//Function Number: 27
func_7CE3(param_00)
{
	if(param_00 == "")
	{
		return 0;
	}

	return castfloat(param_00);
}

//Function Number: 28
func_7CE4(param_00)
{
	if(param_00 == "")
	{
		return 0;
	}

	return castint(param_00);
}

//Function Number: 29
func_6890(param_00,param_01)
{
	return castint(param_00 * param_01) / param_01;
}

//Function Number: 30
func_2402(param_00,param_01)
{
}

//Function Number: 31
func_23F0(param_00)
{
}

//Function Number: 32
func_23E1()
{
	return 0;
}

//Function Number: 33
debug_warning(param_00)
{
	func_2402("^2" + param_00);
}

//Function Number: 34
debug_error(param_00)
{
	func_2402("^3" + param_00);
}

//Function Number: 35
func_389C()
{
	return getdvarfloat("debug_headroom");
}

//Function Number: 36
func_20B7()
{
}

//Function Number: 37
func_2632()
{
}

//Function Number: 38
new_volmod_hud(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 39
new_submix_hud(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 40
delete_volmod_hud(param_00)
{
}

//Function Number: 41
func_20C4()
{
}

//Function Number: 42
func_2636()
{
}

//Function Number: 43
func_6536(param_00)
{
	if(!isdefined(level._audio.huds[param_00]))
	{
	}

	level._audio.huds[param_00] destroy();
	level._audio.huds = common_scripts\utility::array_removeundefined(level._audio.huds);
}

//Function Number: 44
debug_hud_disabled()
{
}

//Function Number: 45
debug_audio_hud()
{
}

//Function Number: 46
func_1B8E()
{
}

//Function Number: 47
check_submix_hud_dvar()
{
}

//Function Number: 48
create_hud(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
}

//Function Number: 49
func_455A(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 50
func_455B(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 51
func_455C(param_00,param_01,param_02,param_03,param_04,param_05)
{
}

//Function Number: 52
set_hud_value(param_00,param_01)
{
}

//Function Number: 53
func_6F08(param_00,param_01)
{
}

//Function Number: 54
set_hud_value_internal(param_00)
{
}

//Function Number: 55
set_hud_name_percent_value(param_00,param_01,param_02)
{
}