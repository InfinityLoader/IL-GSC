/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_ufo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 118
 * Decompile Time: 6139 ms
 * Timestamp: 10/27/2023 12:08:33 AM
*******************************************************************/

//Function Number: 1
init_ufo_quest()
{
	level endon("game_ended");
	scripts\mp\agents\zombie_grey\zombie_grey_agent::registerscriptedagent();
	level thread func_D749();
	var_00 = scripts\common\utility::getstruct("ufo_initial_position","targetname");
	func_9793();
	func_9790();
	wait(3);
	var_01 = spawn("script_model",var_00.origin);
	var_01.angles = var_00.angles;
	var_01 setmodel("zmb_spaceland_ufo_off");
	level.var_12B01 = var_01;
	level.var_85F1 = ::func_85F1;
	level.var_85F9 = ::func_DFB8;
	level.var_8600 = ::func_2456;
	level.var_C1E5 = 0;
	level.var_D7C2 = ::func_12B09;
	level.var_D6D2 = ::func_12B08;
	scripts\common\utility::flag_init("fuses_inserted");
	scripts\common\utility::flag_init("dj_ufo_destroy_nag");
}

//Function Number: 2
func_9790()
{
	precachempanim("zmb_spaceland_ufo_idle");
	precachempanim("zmb_spaceland_ufo_breakaway");
}

//Function Number: 3
func_9793()
{
	level._effect["ufo_explosion"] = loadfx("vfx/iw7/_requests/coop/vfx_ufo_explosion.vfx");
	level._effect["ufo_small_explosion"] = loadfx("vfx/iw7/core/zombie/ufo/ufo_explosion/vfx_ufo_expl_sm_body.vfx");
	level._effect["ufo_zombie_spawn_beam"] = loadfx("vfx/iw7/core/zombie/ufo/ufo_beam/vfx_ufo_beam_spawning.vfx");
	level._effect["ufo_lazer_beam"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_ufobeam.vfx");
	level._effect["powernode_arc_small"] = loadfx("vfx/iw7/core/zombie/ufo/vfx_sentry_shock_arc_s.vfx");
	level._effect["powernode_arc_medium"] = loadfx("vfx/iw7/core/zombie/ufo/vfx_sentry_shock_arc_m.vfx");
	level._effect["powernode_arc_big"] = loadfx("vfx/iw7/core/zombie/ufo/vfx_sentry_shock_arc_b.vfx");
	level._effect["ufo_elec_beam_impact"] = loadfx("vfx/iw7/core/zombie/ufo/vfx_ufo_elec_beam_impact.vfx");
	level._effect["soul_key_glow"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_soulkey_flames.vfx");
}

//Function Number: 4
func_D749()
{
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		level waittill("activate_power");
		var_00++;
		var_01 = func_7D2B(var_00);
		level.var_12B01 setmodel(var_01);
		if(var_00 == 5)
		{
			break;
		}
	}
}

//Function Number: 5
func_7D2B(param_00)
{
	switch(param_00)
	{
		case 1:
			return "zmb_spaceland_ufo_blue";

		case 2:
			return "zmb_spaceland_ufo_green";

		case 3:
			return "zmb_spaceland_ufo_yellow";

		case 4:
			return "zmb_spaceland_ufo_red";

		case 5:
			return "zmb_spaceland_ufo";

		default:
			break;
	}
}

//Function Number: 6
func_12B0D()
{
	level endon("debug_beat_UFO_suicide_bomber");
	var_00 = level.var_12B01;
	level thread func_12639();
	var_00 moveto((647,621,901),5);
	var_00 waittill("movedone");
	foreach(var_02 in level.fast_travel_spots)
	{
		var_02.var_55BA = undefined;
		lib_0D4E::func_1297F(0);
	}

	level.var_2A38 = func_CD1C(1,"ufo_lazer_beam",var_00.origin);
	var_04 = 50;
	var_05 = 50;
	level.var_C208 = 0;
	while(var_04 >= 0)
	{
		for(;;)
		{
			var_06 = func_B28B();
			var_07 = var_06 scripts\cp\zombies\zombies_spawning::func_1081B("generic_zombie",1);
			if(isdefined(var_07))
			{
				break;
			}

			wait(0.05);
		}

		var_04--;
		var_07.entered_playspace = 1;
		var_07.nocorpse = 1;
		var_07.health = 5000;
		var_07.var_9CDD = 1;
		var_07.var_9CA2 = 1;
		var_07 setscriptablepartstate("eyes","eye_glow_off");
		var_07 detachall();
		var_07 setmodel("park_clown_zombie");
		var_07.var_FF78 = 0;
		var_07 thread func_50F2(var_07);
		var_07 thread func_4E24(var_05);
		wait(randomfloatrange(0.05,1));
	}

	while(level.var_C208 < var_05)
	{
		wait(1);
	}

	level.var_2A38 delete();
	wait(1);
}

//Function Number: 7
func_12B12()
{
	level thread func_4DDA();
	level.savedcurrentdeaths = level.var_4B6E;
	level.savemaxspawns = level.var_B467;
	level.savedesireddeaths = level.var_5274;
	level.ufo_starting_wave = level.wave_num;
	level.var_13BD6 = 28;
	level.var_4B6E = 0;
	level.var_B467 = 24;
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		level.var_10847 = 0.7;
	}
	else
	{
		level.var_10847 = 0.35;
	}

	level thread force_zombie_sprint();
	scripts\common\utility::flag_set("pause_wave_progression");
	if(scripts\common\utility::func_6E34("tones_played_successfully"))
	{
		scripts\common\utility::flag_wait("tones_played_successfully");
	}
}

//Function Number: 8
force_zombie_sprint()
{
	level endon("complete_alien_grey_fight");
	foreach(var_01 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_dj::func_1887(var_01);
	}

	for(;;)
	{
		level waittill("agent_spawned",var_03);
		if(isdefined(var_03.agent_type) && var_03.agent_type == "zombie_brute")
		{
			continue;
		}

		var_03 thread scripts\cp\maps\cp_zmb\cp_zmb_dj::func_1887(var_03,1);
	}
}

//Function Number: 9
func_4DDA()
{
	level endon("game_ended");
	var_00 = level.var_1646;
	var_01 = getentarray("placed_transponder","script_noteworthy");
	foreach(var_03 in var_00)
	{
		if(var_03.var_28AB == "moon" || var_03.var_28AB == "front_gate")
		{
			continue;
		}

		var_03 scripts\cp\zombies\zombies_spawning::func_B292();
		foreach(var_05 in var_01)
		{
			if(function_010F(var_05.origin,var_03))
			{
				var_05 notify("detonateExplosive");
			}
		}
	}

	while(!scripts\common\utility::flag("disable_portals"))
	{
		wait(0.05);
	}

	scripts\common\utility::func_6E5A("disable_portals");
	foreach(var_09 in var_00)
	{
		var_09 scripts\cp\zombies\zombies_spawning::func_B291();
	}
}

//Function Number: 10
func_12B06()
{
	level thread func_CE72();
	var_00 = level.var_12B01;
	var_00.angles = vectortoangles((1,0,0));
	var_00 thread func_12B04();
	var_00 thread func_12B03(var_00);
	var_00 playloopsound("ufo_movement_lp");
	var_00.origin = (647,621,901);
	var_00.angles = (0,0,0);
	var_00 scriptmodelplayanim("zmb_spaceland_ufo_breakaway",1);
	var_00 setscriptablepartstate("thrusters","on");
	wait(7);
	var_00 scriptmodelplayanim("zmb_spaceland_ufo_idle");
	scripts\common\utility::flag_set("ufo_intro_reach_center_portal");
}

//Function Number: 11
func_10CA8()
{
	level endon("tones_played_successfully");
	var_00 = level.var_12B01;
	scripts\common\utility::flag_wait("ufo_intro_reach_center_portal");
	func_FA75();
	var_00 func_CD8C();
}

//Function Number: 12
func_FA75()
{
	var_00 = level.var_12B01;
	var_01 = [];
	for(var_02 = 0;var_02 < 4;var_02++)
	{
		var_03 = strtok(level.var_12B13[var_02],"_");
		var_01[var_01.size] = var_03[3];
	}

	var_00.var_119DA = scripts\common\utility::func_22A8(var_01);
}

//Function Number: 13
func_CD8C()
{
	level endon("tone_sequence_completed");
	var_00 = 5;
	var_01 = level.var_12B01;
	var_01 thread func_AD7C();
	for(;;)
	{
		func_D551();
		var_02 = 0;
		for(var_03 = 0;var_03 < var_00;var_03++)
		{
			var_04 = func_785D();
			var_05 = (var_04.origin[0],var_04.origin[1],var_01.origin[2]);
			var_06 = distance(var_01.origin,var_05);
			var_07 = var_06 / 150;
			var_01 playsound("ufo_movement_start");
			var_01 moveto(var_05,var_07);
			var_01 waittill("movedone");
		}

		var_06 = distance(var_01.origin,(647,621,901));
		var_07 = var_06 / 150;
		if(var_07 < 0.05)
		{
			var_07 = 0.05;
		}

		var_01 playsound("ufo_movement_start");
		var_01 moveto((647,621,901),var_07);
		var_01 waittill("movedone");
	}
}

//Function Number: 14
func_560B()
{
	scripts\common\utility::flag_set("disable_portals");
	foreach(var_01 in level.fast_travel_spots)
	{
		var_01.var_55BA = 1;
		var_01 func_12952();
		var_01 lib_0D4E::func_D678();
	}
}

//Function Number: 15
func_6279()
{
	scripts\common\utility::func_6E2A("disable_portals");
	foreach(var_01 in level.fast_travel_spots)
	{
		var_01.var_55BA = undefined;
	}
}

//Function Number: 16
func_CD0D()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("dj_deny");
	}

	wait(2);
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("ww_magicbox_laughter");
	}
}

//Function Number: 17
func_AD7C()
{
	level endon("tones_played_successfully");
	var_00 = level.var_12B01;
	scripts\cp\maps\cp_zmb\cp_zmb_dj::func_1602();
	var_01 = 1;
	var_02 = 0;
	var_03 = undefined;
	while(var_01)
	{
		var_04 = 0;
		var_05 = 0;
		var_06 = 1;
		for(;;)
		{
			scripts\cp\maps\cp_zmb\cp_zmb_dj::func_1602();
			level waittill("tone_played",var_07,var_03);
			if(!scripts\common\utility::flag("ufo_listening"))
			{
				break;
			}

			if(!isdefined(var_07))
			{
				level notify("played_tones_too_slowly");
				var_00 notify("played_tones_too_slowly");
				func_F63B("idle - on");
				level thread func_CD0D();
				scripts\cp\maps\cp_zmb\cp_zmb_dj::func_4DDD();
				wait(2);
				break;
			}

			if(!isdefined(var_03))
			{
				wait(2);
				break;
			}

			var_00 thread func_F7EC();
			var_08 = func_8182(var_07,"active");
			func_F890(var_03,var_08);
			var_05++;
			if(var_06 && var_07 == var_00.var_119DA[var_04])
			{
				var_04++;
				if(var_04 == 4)
				{
					var_02++;
					var_00 notify("completed_tone_match");
					scripts\common\utility::func_6E2A("force_spawn_boss");
					if(var_02 == 3)
					{
						var_01 = 0;
						wait(2);
						level notify("tone_sequence_completed");
						level thread scripts\cp\_vo::try_to_play_vo("ww_ufo_tonegen_complete","zmb_ww_vo","highest",60,1,0,1);
						break;
					}
					else
					{
						var_00.var_119DA = scripts\common\utility::func_22A8(var_00.var_119DA);
						scripts\cp\maps\cp_zmb\cp_zmb_dj::func_4DDD();
						wait(4);
						break;
					}
				}
				else
				{
					level notify("correct_tone_played");
					var_00 notify("correct_tone_played");
					continue;
				}

				continue;
			}

			level notify("incorrect_tone_played");
			var_06 = 0;
			if(var_05 == 4)
			{
				wait(1);
				var_00 notify("incorrect_tone_played");
				func_F63B("idle - on");
				level thread func_CD0D();
				scripts\cp\maps\cp_zmb\cp_zmb_dj::func_4DDD();
				wait(5);
				break;
			}
		}
	}

	scripts\common\utility::flag_set("tones_played_successfully");
}

//Function Number: 18
func_F63A()
{
	foreach(var_01 in level.alldjcenterstructs)
	{
		if(isdefined(var_01.var_119D9))
		{
			var_02 = strtok(var_01.var_119D9,"_");
			var_03 = func_8182(var_02[3],"neutral");
			var_01.model setscriptablepartstate("tone",var_03);
		}
	}
}

//Function Number: 19
func_52CC()
{
	foreach(var_01 in level.alldjcenterstructs)
	{
		if(isdefined(var_01.model))
		{
			var_01.model setscriptablepartstate("tone","explode");
		}
	}

	wait(0.1);
	foreach(var_01 in level.alldjcenterstructs)
	{
		var_01.model delete();
		var_01.var_55BA = 1;
		scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
	}
}

//Function Number: 20
func_F63B(param_00)
{
	foreach(var_02 in level.alldjcenterstructs)
	{
		if(isdefined(var_02.model))
		{
			var_02.model setscriptablepartstate("tone",param_00);
		}
	}
}

//Function Number: 21
func_12952()
{
	if(isdefined(level.var_695B))
	{
		level.var_695B delete();
	}
}

//Function Number: 22
func_F890(param_00,param_01)
{
	param_00.model setscriptablepartstate("tone",param_01);
}

//Function Number: 23
func_D551()
{
	var_00 = level.var_12B01;
	var_00.var_11901 = 15;
	level.var_13FA3 = 1;
	set_ufo_model_with_thrusters(var_00,"zmb_spaceland_ufo_off",1);
	func_F63B("neutral");
	func_D511(var_00.var_119DA,1);
	func_F63B("idle - on");
	scripts\common\utility::flag_set("ufo_listening");
	var_00 thread func_136F0(var_00);
	set_ufo_model_with_thrusters(var_00,"zmb_spaceland_ufo",1);
	playfxontag(level._effect["ufo_light_white"],var_00,"tag_origin");
	for(;;)
	{
		var_01 = var_00 scripts\common\utility::func_13734("completed_tone_match","incorrect_tone_played","ufo_timed_out","correct_tone_played","played_tones_too_slowly");
		if(var_01 == "completed_tone_match")
		{
			scripts\common\utility::flag_set("force_drop_max_ammo");
			thread func_6EE0(1);
			break;
		}
		else
		{
			if(var_01 == "correct_tone_played")
			{
				var_00.var_11901 = min(15,var_00.var_11901 + 4);
				continue;
			}

			if(var_01 == "incorrect_tone_played")
			{
				scripts\common\utility::flag_set("force_spawn_boss");
				break;
			}
			else
			{
				if(var_01 == "played_tones_too_slowly")
				{
					scripts\common\utility::flag_set("force_spawn_boss");
					continue;
				}

				if(var_01 == "ufo_timed_out")
				{
					break;
				}
			}
		}
	}

	stopfxontag(level._effect["ufo_light_white"],var_00,"tag_origin");
	level.var_13FA3 = 0;
	func_F63A();
	scripts\common\utility::func_6E2A("ufo_listening");
}

//Function Number: 24
func_136F0(param_00)
{
	param_00 endon("completed_tone_match");
	while(param_00.var_11901 >= 1)
	{
		wait(1);
		param_00.var_11901 = param_00.var_11901 - 1;
	}

	param_00 notify("ufo_timed_out");
}

//Function Number: 25
func_8182(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level.var_12B13)
	{
		var_05 = strtok(var_04,"_");
		if(param_00 == var_05[3])
		{
			break;
		}
	}

	switch(var_02)
	{
		case 0:
			return param_01 + " - red";

		case 1:
			return param_01 + " - green";

		case 2:
			return param_01 + " - blue";

		case 3:
			return param_01 + " - yellow";

		default:
			return "neutral";
	}
}

//Function Number: 26
func_6EE0(param_00)
{
	var_01 = level.var_12B01;
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo_off",param_00);
		wait(0.5);
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo",param_00);
		wait(0.5);
	}

	for(var_02 = 0;var_02 < 4;var_02++)
	{
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo_blue",param_00);
		wait(0.25);
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo_green",param_00);
		wait(0.25);
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo_yellow",param_00);
		wait(0.25);
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo_red",param_00);
		wait(0.25);
		set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo",param_00);
		wait(0.25);
	}

	set_ufo_model_with_thrusters(var_01,"zmb_spaceland_ufo",param_00);
}

//Function Number: 27
func_D511(param_00,param_01)
{
	var_02 = level.var_12B01;
	playsoundatpos(var_02.origin,"UFO_tone_playback_" + param_00[0]);
	var_03 = func_81E9(param_00[0]);
	set_ufo_model_with_thrusters(var_02,var_03,param_01);
	thread func_FC52();
	wait(3.5);
	playsoundatpos(var_02.origin,"UFO_tone_playback_" + param_00[1]);
	var_03 = func_81E9(param_00[1]);
	set_ufo_model_with_thrusters(var_02,var_03,param_01);
	thread func_FC52();
	wait(3.5);
	playsoundatpos(var_02.origin,"UFO_tone_playback_" + param_00[2]);
	var_03 = func_81E9(param_00[2]);
	set_ufo_model_with_thrusters(var_02,var_03,param_01);
	thread func_FC52();
	wait(3.5);
	playsoundatpos(var_02.origin,"UFO_tone_playback_" + param_00[3]);
	var_03 = func_81E9(param_00[3]);
	set_ufo_model_with_thrusters(var_02,var_03,param_01);
	thread func_FC52();
	wait(3.5);
	set_ufo_model_with_thrusters(var_02,"zmb_spaceland_ufo",param_01);
}

//Function Number: 28
set_ufo_model_with_thrusters(param_00,param_01,param_02)
{
	param_00 setmodel(param_01);
	if(scripts\common\utility::istrue(param_02))
	{
		param_00 thread delay_turn_on_thrusters(param_00);
	}
}

//Function Number: 29
delay_turn_on_thrusters(param_00)
{
	param_00 notify("ufo_delay_turn_on_thrusters");
	param_00 endon("death");
	param_00 endon("ufo_delay_turn_on_thrusters");
	wait(0.1);
	param_00 setscriptablepartstate("thrusters","on");
}

//Function Number: 30
func_81E9(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_12B13)
	{
		var_04 = strtok(var_03,"_");
		if(param_00 == var_04[3])
		{
			break;
		}
	}

	switch(var_01)
	{
		case 0:
			return "zmb_spaceland_ufo_red";

		case 1:
			return "zmb_spaceland_ufo_green";

		case 2:
			return "zmb_spaceland_ufo_blue";

		case 3:
			return "zmb_spaceland_ufo_yellow";

		default:
			return undefined;
	}
}

//Function Number: 31
func_FC52()
{
	foreach(var_01 in level.players)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_01.var_9C54))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_01.in_afterlife_arcade))
		{
			continue;
		}

		var_01 setclientomnvar("ui_hud_shake",1);
		var_01 playrumbleonentity("artillery_rumble");
	}
}

//Function Number: 32
func_F7EC()
{
	self notify("stop_playback_timer");
	self endon("stop_playback_timer");
	var_00 = scripts\common\utility::func_116D7(level.players.size == 1,4,2.5);
	wait(var_00);
	level notify("tone_played");
}

//Function Number: 33
func_CD1C(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_03) && isdefined(param_04))
	{
		var_05 = spawnfx(level._effect[param_01],param_02,param_03,param_04);
	}
	else
	{
		var_05 = spawnfx(level._effect[param_02],param_03);
	}

	wait(param_00);
	triggerfx(var_05);
	return var_05;
}

//Function Number: 34
func_A570(param_00)
{
	param_00 endon("death");
	param_00 endon("ufo_started_moving");
	var_01 = 0.4;
	for(;;)
	{
		var_02 = param_00.angles[0];
		param_00 rotateyaw(var_02 + 120,var_01);
		wait(var_01);
	}
}

//Function Number: 35
func_12B04()
{
	self endon("stop_quake");
	self endon("death");
	for(;;)
	{
		earthquake(randomfloatrange(0.05,0.15),3,self.origin + (0,0,-100),1500);
		wait(2);
	}
}

//Function Number: 36
func_50F2(param_00)
{
	param_00 endon("death");
	wait(1);
	param_00.health = 150;
	param_00.var_1F5 = "sprint";
	param_00.var_BCE4 = 0.8;
	param_00.var_126E8 = 0.8;
	param_00.var_772A = 0.8;
}

//Function Number: 37
func_4E24(param_00)
{
	self waittill("death");
	level.var_C208++;
}

//Function Number: 38
func_B26F(param_00)
{
	var_01 = spawnstruct();
	var_01.origin = param_00;
	var_01.angles = (0,90,0);
	var_01.var_9B95 = 1;
	return var_01;
}

//Function Number: 39
func_B28B()
{
	var_00 = [(647,621,80),(-40,658,1),(1286,658,1)];
	var_01 = spawnstruct();
	var_01.origin = scripts\common\utility::random(var_00);
	var_01.angles = (0,90,0);
	var_01.var_9B95 = 1;
	return var_01;
}

//Function Number: 40
func_10C6C()
{
	level endon("game_ended");
	scripts\cp\zombies\zombie_analytics::func_AF72(level.wave_num);
	wait(3);
	func_CE3F();
	var_00 = 0.3;
	var_01 = 0.7;
	var_02 = [(642,710,67),(996,657,11),(642,325,11),(303,651,11)];
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = func_B26F(var_02[var_03]);
		scripts\cp\zombies\zombies_spawning::func_93EB(1);
		for(;;)
		{
			var_05 = scripts\mp\_mp_agent::func_108E8("zombie_grey","axis",var_04.origin,var_04.angles,"iw7_zapper_grey");
			if(isdefined(var_05))
			{
				if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
				{
					var_05 scripts\mp\_mp_agent::func_F28C(int(700000));
				}

				var_05 thread func_9A9A(var_05);
				var_05 func_7A3B(var_05);
				var_05.favorite_target_player = level.players[var_03];
				var_05.var_594C = 1;
				lib_0C78::func_F5E8(var_05);
				break;
			}

			lib_0C78::func_12865(1);
			scripts\common\utility::func_136F7();
		}

		scripts\cp\zombies\zombies_spawning::func_4FB8(1);
		wait(randomfloatrange(var_00,var_01));
	}
}

//Function Number: 41
func_7A3B(param_00)
{
	foreach(var_02 in level.players)
	{
		param_00 getenemyinfo(var_02);
	}
}

//Function Number: 42
func_9A9A(param_00)
{
	var_01 = 7;
	param_00 endon("death");
	var_02 = param_00 scripts\cp\_utility::func_1372C(var_01,param_00,"damage");
	param_00.var_FF9F = 1;
	lib_0C2E::func_F499(param_00);
	lib_0C2E::func_F2F1(param_00,1);
}

//Function Number: 43
func_CE3F()
{
	level thread scripts\cp\_vo::try_to_play_vo("ww_alien_spawn","zmb_ww_vo","highest",60,1,0,1);
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("alien_first","zmb_comment_vo","low",10,0,0,0,50);
	}
}

//Function Number: 44
func_85F1(param_00,param_01,param_02,param_03,param_04)
{
	level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,param_00);
	level.var_10850 = scripts\common\utility::func_22A9(level.var_10850,param_00);
	if(level.var_10850.size == 0)
	{
		if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
		{
			level thread func_85F0(param_01);
			scripts\cp\_weaponrank::func_12861(param_01,param_02,param_03,param_04,param_00.agent_type);
		}

		level notify("stop_ufo_zombie_spawn");
		level notify("complete_alien_grey_fight");
	}
}

//Function Number: 45
func_85F0(param_00)
{
	level endon("game_ended");
	if(isdefined(param_00))
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("alien_defeat","zmb_comment_vo","highest",10,0,0,1);
	}

	wait(4);
	level thread scripts\cp\_vo::try_to_play_vo("ww_alien_death","zmb_ww_vo","highest",60,0,0,1);
}

//Function Number: 46
func_12B03(param_00)
{
	param_00 endon("death");
	param_00.maxhealth = 999999999;
	param_00.health = 999999999;
	param_00.var_6AEF = 3000;
	param_00 setcandamage(1);
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isdefined(var_0A))
		{
			if(func_13C01(var_0A))
			{
				break;
			}
			else if(isdefined(var_02) && isplayer(var_02))
			{
				var_0B = gettime();
				if(!isdefined(var_02.var_D8A8) || var_0B - var_02.var_D8A8 / 1000 > 3)
				{
					var_02 scripts\cp\_vo::try_to_play_vo("nag_ufo_shoot","zmb_comment_vo","high",100,0,0,1,100);
					var_02.var_D8A8 = var_0B;
				}
			}
		}
	}

	param_00 moveto((-554,-1488,2280),3,1.5);
	param_00 playsoundonmovingent("zmb_ufo_explo");
	playfxontag(level._effect["ufo_small_explosion"],param_00,"TAG_ORIGIN");
	wait(3);
	param_00 stoploopsound();
	level thread scripts\cp\_vo::func_E01F("nag_ufo_shoot");
	scripts\cp\zombies\zombie_analytics::func_AF8F(level.wave_num);
	level thread pausespawningfortime();
	level thread func_52BB();
	if(isdefined(param_00.var_12A83))
	{
		foreach(var_0D in param_00.var_12A83)
		{
			var_0D delete();
		}
	}

	playfx(level._effect["ufo_explosion"],param_00.origin);
	scripts\common\utility::flag_set("ufo_destroyed");
	param_00 delete();
}

//Function Number: 47
pausespawningfortime()
{
	level endon("game_ended");
	scripts\common\utility::flag_init("pause_spawn_after_UFO_destroyed");
	scripts\common\utility::flag_set("pause_spawn_after_UFO_destroyed");
	level.var_13FA3 = 1;
	scripts\common\utility::flag_set("pause_wave_progression");
	var_00 = spawn("script_model",level.players[0].origin);
	var_00 setmodel("tag_origin");
	var_00.team = "allies";
	level.var_72AA = 1;
	scripts\cp\zombies\_powerups::func_D980(level.players[0],"kill_50",var_00,0);
	wait(20);
	level.var_13FA3 = 0;
	scripts\common\utility::func_6E2A("pause_wave_progression");
	scripts\common\utility::func_6E2A("pause_spawn_after_UFO_destroyed");
}

//Function Number: 48
func_52BB()
{
	scripts\cp\_vo::try_to_play_vo_on_all_players("ufo_destroy");
	wait(5);
	level thread scripts\cp\_vo::try_to_play_vo("ww_ufo_spawn_cut","zmb_announcer_vo","highest",60,0,0,1);
}

//Function Number: 49
func_13C01(param_00)
{
	if(param_00 == "iw7_spaceland_wmd")
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
func_2456(param_00)
{
	param_00.var_269C = [];
	param_00.var_269C[param_00.var_269C.size] = func_4899(param_00,"tag_back_le");
	param_00.var_269C[param_00.var_269C.size] = func_4899(param_00,"tag_back_ri");
}

//Function Number: 51
func_4899(param_00,param_01)
{
	var_02 = (0,0,0);
	var_03 = spawn("script_model",param_00 gettagorigin(param_01));
	var_03 setmodel("park_alien_gray_fuse");
	var_03.angles = param_00 gettagangles(param_01);
	var_03 linkto(param_00,param_01,(0,0,0),var_02);
	var_03.var_222 = param_00;
	var_03.var_113E0 = param_01;
	return var_03;
}

//Function Number: 52
func_DFB8(param_00,param_01)
{
	param_01.var_222.var_269C = scripts\common\utility::func_22A9(param_01.var_222.var_269C,param_01);
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 53
func_5CDF()
{
	var_00 = spawn("script_model",(657,765,105));
	var_00 setmodel("park_alien_gray_fuse");
	var_00.angles = (randomintrange(0,360),randomintrange(0,360),randomintrange(0,360));
	var_01 = spawn("script_model",(641,765,105));
	var_01 setmodel("park_alien_gray_fuse");
	var_01.angles = (randomintrange(0,360),randomintrange(0,360),randomintrange(0,360));
	var_01 thread func_50D2(var_01,"souvenir_glow");
	var_01 thread func_A022(var_01);
	var_00 thread func_50D2(var_00,"souvenir_glow");
	var_00 thread func_A022(var_00);
	var_00 thread func_74E4(var_00,var_01);
}

//Function Number: 54
func_50D2(param_00,param_01)
{
	param_00 endon("death");
	wait(0.3);
	playfxontag(level._effect[param_01],param_00,"tag_origin");
}

//Function Number: 55
func_A022(param_00)
{
	param_00 endon("death");
	var_01 = param_00.angles;
	for(;;)
	{
		param_00 rotateto(var_01 + (randomintrange(-40,40),randomintrange(-40,90),randomintrange(-40,90)),3);
		wait(3);
	}
}

//Function Number: 56
func_74E4(param_00,param_01)
{
	param_00 endon("death");
	param_00 makeusable();
	param_00 sethintstring(&"CP_ZMB_UFO_PICK_UP_FUSE");
	foreach(var_03 in level.players)
	{
		var_03 thread scripts\cp\_vo::func_1769("nag_ufo_fusefail","zmb_comment_vo",60,15,6,1);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(isplayer(var_03))
		{
			var_03 playlocalsound("part_pickup");
			var_03 thread scripts\cp\_vo::try_to_play_vo("quest_ufo_collect_alienfuse_2","zmb_comment_vo","highest",10,0,0,1,100);
			break;
		}
	}

	level.var_C1E5++;
	scripts\cp\_interaction::add_to_current_interaction_list(scripts\common\utility::getstruct("pap_upgrade","script_noteworthy"));
	scripts\cp\_interaction::remove_from_current_interaction_list(scripts\common\utility::getstruct("weapon_upgrade","script_noteworthy"));
	level thread scripts\cp\_vo::func_E01F("nag_ufo_fusefail");
	foreach(var_03 in level.players)
	{
		var_03 setclientomnvar("zm_special_item",1);
	}

	param_01 delete();
	param_00 delete();
}

//Function Number: 57
func_5D12()
{
	var_00 = spawn("script_model",(646,774,105));
	var_00 setmodel("zmb_soul_key_base");
	var_01 = spawnfx(level._effect["soul_key_glow"],var_00.origin);
	triggerfx(var_01);
	var_00 thread func_A022(var_00);
	var_00 thread func_1044E(var_00,var_01);
}

//Function Number: 58
func_1044E(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 137;
	param_00 makeusable();
	param_00 sethintstring(&"CP_ZMB_UFO_PICK_UP_SOUL_KEY");
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(isplayer(var_03))
		{
			var_03 playlocalsound("part_pickup");
			scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
			foreach(var_03 in level.players)
			{
				check_willard_pick_up_soul_key(var_03);
				var_03 setplayerdata("cp","haveSoulKeys","any_soul_key",1);
				var_03 setplayerdata("cp","haveSoulKeys","soul_key_1",1);
				var_03 lib_0D2A::func_12D7C("SOUL_KEY",1);
			}

			if(any_player_is_willard())
			{
				stop_spawn_wave();
				clear_existing_enemies();
				stop_gameplay_audio();
				scripts\cp\_utility::play_bink_video("sysload_o4",var_02);
				wait(var_02);
				resume_spawn_wave();
				resume_gameplay_audio();
			}

			level thread scripts\cp\_vo::try_to_play_vo("dj_quest_ufo_soulkey_achieve","zmb_dj_vo","high",20,0,0,1);
			level thread func_10452(var_03);
			break;
		}
	}

	level thread scripts\cp\zombies\directors_cut::try_drop_talisman(param_00.origin,vectortoangles((0,1,0)));
	param_01 delete();
	param_00 delete();
}

//Function Number: 59
stop_gameplay_audio()
{
	scripts\cp\_vo::func_F60C(1);
	level.var_550B = 1;
	scripts\common\utility::flag_set("jukebox_paused");
	level notify("skip_song");
	foreach(var_01 in level.players)
	{
		scripts\cp\maps\cp_zmb\cp_zmb_vo::clear_up_all_vo(var_01);
		var_01 method_82C0("bink_fadeout_amb",0.66);
	}
}

//Function Number: 60
resume_gameplay_audio()
{
	scripts\cp\_vo::func_F60C(0);
	level.var_550B = undefined;
	scripts\common\utility::func_6E2A("jukebox_paused");
	foreach(var_01 in level.players)
	{
		var_01 method_8070(0);
	}
}

//Function Number: 61
clear_existing_enemies()
{
	foreach(var_01 in level.spawned_enemies)
	{
		var_01.var_54CB = 1;
		var_01.nocorpse = 1;
		var_01 suicide();
	}

	scripts\common\utility::func_136F7();
}

//Function Number: 62
stop_spawn_wave()
{
	scripts\common\utility::flag_set("pause_wave_progression");
	level.var_13FA3 = 1;
	level.dont_resume_wave_after_solo_afterlife = 1;
}

//Function Number: 63
resume_spawn_wave()
{
	level.dont_resume_wave_after_solo_afterlife = undefined;
	level.var_13FA3 = 0;
	scripts\common\utility::func_6E2A("pause_wave_progression");
}

//Function Number: 64
any_player_is_willard()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_134FD) && var_01.var_134FD == "p6_")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
check_willard_pick_up_soul_key(param_00)
{
	if(isdefined(param_00.var_134FD) && param_00.var_134FD == "p6_")
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_dlc4_troll");
	}
}

//Function Number: 66
func_10452(param_00)
{
	param_00 thread scripts\cp\_vo::try_to_play_vo("quest_ufo_collect_soulkey","zmb_comment_vo","highest",10,0,3,1,100);
	level thread scripts\cp\_vo::try_to_play_vo("collect_soulkey_1","zmb_dialogue_vo","highest",666,0,0,0,100);
	param_00 thread scripts\cp\_vo::func_1769("nag_return_arcanecore","zmb_comment_vo",60,120,6,1);
}

//Function Number: 67
func_C8AA(param_00,param_01)
{
	if(isdefined(level.var_C1E5) && level.var_C1E5 > 0)
	{
		return &"CP_ZMB_INTERACTIONS_PAP_UPGRADE";
	}

	return "";
}

//Function Number: 68
func_12F6F(param_00,param_01)
{
	level.var_C1E5--;
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	func_990B();
	scripts\common\utility::flag_set("fuses_inserted");
	level.var_C8A4 = int(min(level.var_C8A4 + 1,3));
	foreach(param_01 in level.players)
	{
		param_01 setclientomnvar("zm_special_item",0);
	}

	wait(3);
	scripts\cp\_interaction::add_to_current_interaction_list(scripts\common\utility::getstruct("weapon_upgrade","script_noteworthy"));
}

//Function Number: 69
func_990B()
{
	var_00 = getent("pap_machine","targetname");
	var_00 setscriptablepartstate("door","close");
	wait(0.5);
	var_00 setscriptablepartstate("machine","upgraded");
	wait(0.25);
	var_00 setscriptablepartstate("reels","neutral");
	wait(0.25);
	var_00 setscriptablepartstate("reels","on");
	wait(0.25);
	var_00 setscriptablepartstate("door","open_idle");
}

//Function Number: 70
func_96AB()
{
	var_00 = scripts\common\utility::getstructarray("pap_upgrade","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
	}
}

//Function Number: 71
func_3866(param_00,param_01)
{
	if(isdefined(level.var_C1E5) && level.var_C1E5 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 72
func_15F9(param_00)
{
	var_01 = [];
	var_02 = func_FA76(param_00 gettagorigin("tag_origin"));
	var_02 linkto(param_00,"tag_origin",(0,0,-100),(180,0,0));
	var_01[var_01.size] = var_02;
	param_00.var_12A83 = var_01;
}

//Function Number: 73
func_FA76(param_00)
{
	var_01 = spawnturret("misc_turret",param_00,"ufo_turret_gun_zombie");
	var_01 setmodel("weapon_ceiling_sentry_temp");
	var_01 method_81F5();
	var_01 makeunusable();
	var_01.team = "axis";
	var_01 method_835E("axis");
	var_01 method_830F("sentry");
	var_01 method_8336(undefined);
	var_01 method_82FB(360);
	var_01 method_8330(360);
	var_01 method_82B6(360);
	var_01 method_8353(360);
	var_01 method_81D9();
	var_01 thread func_12B0F(var_01);
	return var_01;
}

//Function Number: 74
func_12B0F(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		var_01 = func_7D2C();
		if(isdefined(var_01))
		{
			param_00 method_8347(var_01);
			var_02 = scripts\common\utility::waittill_any_timeout_1(2,"turret_on_target");
			if(var_02 == "turret_on_target")
			{
				var_03 = randomintrange(30,45);
				for(var_04 = 0;var_04 < var_03;var_04++)
				{
					if(!func_37FB(var_01))
					{
						break;
					}

					param_00 method_837E();
					wait(0.1);
				}
			}
		}

		param_00 method_807E();
	}
}

//Function Number: 75
func_7D2C()
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

	return scripts\common\utility::random(var_00);
}

//Function Number: 76
func_37FB(param_00)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 77
func_10D57()
{
	var_00 = level.var_12B01;
	level endon("game_ended");
	level endon("stop_ufo_zombie_spawn");
	var_00 endon("death");
	if(!scripts\common\utility::flag("ufo_intro_reach_center_portal"))
	{
		scripts\common\utility::flag_wait("ufo_intro_reach_center_portal");
	}

	level thread func_B46C();
	for(;;)
	{
		var_01 = func_7B39();
		for(var_02 = 0;var_02 < var_01;var_02++)
		{
			var_03 = func_785D();
			var_04 = (var_03.origin[0],var_03.origin[1],(647,621,901)[2]);
			func_12B05(var_04);
		}

		var_05 = func_7B3F();
		if(var_05 > 0)
		{
			level thread func_12B02(var_05);
			level waittill("beam_down_zombie_complete");
		}
	}
}

//Function Number: 78
func_7B39()
{
	return 1;
}

//Function Number: 79
func_B46C()
{
	level endon("game_ended");
	level endon("stop_ufo_zombie_spawn");
	var_00 = 24;
	level.var_B46B = 1;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		var_02 = func_7D32();
		wait(var_02);
		level.var_B46B++;
	}
}

//Function Number: 80
func_7D32()
{
	return 40;
}

//Function Number: 81
func_7B3F()
{
	var_00 = 24 - level.spawned_enemies.size - 3;
	var_01 = min(var_00,level.var_B46B);
	return var_01;
}

//Function Number: 82
func_12B02(param_00)
{
	var_01 = func_15F7("ufo_zombie_spawn_beam");
	func_10633(param_00);
	func_4DD3(var_01,"ufo_zombie_spawn_beam");
	level notify("beam_down_zombie_complete");
}

//Function Number: 83
func_12B05(param_00)
{
	var_01 = distance(level.var_12B01.origin,param_00);
	var_02 = var_01 / 150;
	level.var_12B01 moveto(param_00,var_02);
	level.var_12B01 waittill("movedone");
}

//Function Number: 84
func_15F7(param_00)
{
	var_01 = level.var_12B01;
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("tag_origin");
	var_02.angles = vectortoangles((0,0,1));
	wait(0.2);
	playfxontag(level._effect[param_00],var_02,"tag_origin");
	return var_02;
}

//Function Number: 85
func_4DD3(param_00,param_01)
{
	killfxontag(level._effect[param_01],param_00,"tag_origin");
	param_00 delete();
}

//Function Number: 86
func_10633(param_00)
{
	var_01 = level.var_12B01;
	level endon("stop_ufo_zombie_spawn");
	var_01 endon("death");
	wait(1);
	var_02 = func_7D2D(param_00);
	for(var_03 = 0;var_03 < param_00;var_03++)
	{
		level thread func_10632(var_02[var_03]);
		if(var_03 == param_00 - 1)
		{
			break;
		}

		wait(1);
	}

	wait(2);
}

//Function Number: 87
func_7D2D(param_00)
{
	var_01 = [];
	var_02 = level.var_12B01;
	var_03 = var_02.angles;
	var_04 = 360 / param_00;
	for(var_05 = 0;var_05 < param_00;var_05++)
	{
		var_06 = (var_03[0],var_03[1] + var_04 * var_05,var_03[2]);
		var_07 = var_02.origin + anglestoforward(var_06) * 30;
		var_01[var_01.size] = var_07;
	}

	return var_01;
}

//Function Number: 88
func_10632(param_00)
{
	var_01 = (0,0,-50);
	var_02 = (0,0,-4000);
	var_03 = scripts\mp\_mp_agent::func_108E8("generic_zombie","axis",param_00,level.var_12B01.angles,undefined);
	if(isdefined(var_03))
	{
		var_03.entered_playspace = 1;
		var_03 method_8287(var_03.var_503C);
		var_03.maxhealth = scripts\cp\zombies\zombies_spawning::func_3728("generic_zombie");
		var_03.health = var_03.maxhealth;
		var_03 thread func_12B10(var_03);
		level.spawned_enemies[level.spawned_enemies.size] = var_03;
		var_04 = spawn("script_model",var_03.origin);
		var_04 setmodel("tag_origin");
		var_03 linkto(var_04,"tag_origin");
		var_05 = bullettrace(param_00 + var_01,param_00 + var_02,0,level.var_12B01)["position"];
		var_04 moveto(var_05,1.5,0,0.75);
		var_04 waittill("movedone");
		var_03 unlink();
		var_04 delete();
	}
}

//Function Number: 89
func_12B10(param_00)
{
	param_00 waittill("death");
	level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,param_00);
}

//Function Number: 90
func_785D()
{
	var_00 = level.var_12B01;
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray("ufo_zombie_spawn_loc","targetname");
	foreach(var_04 in var_02)
	{
		if(distance2dsquared(var_00.origin,var_04.origin) < 250000)
		{
			continue;
		}

		if(distance2dsquared(var_00.origin,var_04.origin) > 1000000)
		{
			continue;
		}

		var_01[var_01.size] = var_04;
	}

	return scripts\common\utility::random(var_01);
}

//Function Number: 91
func_12B09(param_00)
{
	var_01 = level.var_12B01;
	level notify("stop_ufo_zombie_spawn");
	var_02 = (param_00.origin[0],param_00.origin[1],var_01.origin[2]);
	var_01 dontinterpolate();
	var_01.origin = var_02;
}

//Function Number: 92
func_12B08()
{
}

//Function Number: 93
func_BC31()
{
	level endon("game_ended");
	var_00 = getent("grey_fight_clip","targetname");
	if(isdefined(var_00))
	{
		var_01 = var_00.origin;
		var_02 = (var_01[0],var_01[1],var_01[2] - 1024);
		var_00 moveto(var_02,0.05);
		var_00 waittill("movedone");
		var_00 disconnectpaths();
	}
}

//Function Number: 94
func_4159()
{
	var_00 = getent("grey_fight_clip","targetname");
	if(isdefined(var_00))
	{
		var_00 connectpaths();
		var_00 delete();
	}
}

//Function Number: 95
func_10C6B()
{
	level.var_85ED = [];
	level.var_85EC = [];
	var_00 = [(438,-1353,125),(1379,660,85),(-137,645,100)];
	var_01 = [(0,40,0),(0,180,0),(0,0,0)];
	foreach(var_06, var_03 in var_00)
	{
		var_04 = scripts\common\utility::play_loopsound_in_space("zmb_portal_area_lock_in",var_03);
		var_05 = spawnfx(level._effect["moving_target_portal"],var_03,anglestoforward(var_01[var_06]),anglestoup(var_01[var_06]));
		triggerfx(var_05);
		level.var_85ED[level.var_85ED.size] = var_05;
		level.var_85EC[level.var_85EC.size] = var_04;
	}
}

//Function Number: 96
func_10FFE()
{
	if(!isdefined(level.var_85ED))
	{
		return;
	}

	foreach(var_01 in level.var_85ED)
	{
		var_01 delete();
	}
}

//Function Number: 97
func_10FFD()
{
	if(!isdefined(level.var_85EC))
	{
		return;
	}

	foreach(var_01 in level.var_85EC)
	{
		var_01 stoploopsound();
		wait(0.1);
		var_01 delete();
	}
}

//Function Number: 98
func_10D29(param_00)
{
	param_00 thread func_FE81(param_00);
	param_00 thread func_6F7E(param_00);
}

//Function Number: 99
func_6F7E(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	if(!scripts\common\utility::flag("ufo_intro_reach_center_portal"))
	{
		scripts\common\utility::flag_wait("ufo_intro_reach_center_portal");
	}

	for(;;)
	{
		var_01 = func_785D();
		var_02 = (var_01.origin[0],var_01.origin[1],(647,621,901)[2]);
		func_12B05(var_02);
	}
}

//Function Number: 100
func_FE81(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	var_01 = 5;
	for(;;)
	{
		wait(randomfloatrange(10,15));
		var_02 = func_7C70(level.var_12B01);
		if(var_02.size > 0)
		{
			var_03 = func_7C9D(level.var_12B01,var_01);
			foreach(var_05 in var_03)
			{
				level thread func_6D31(var_05,var_02[randomint(var_02.size)]);
			}
		}
	}
}

//Function Number: 101
func_7C9D(param_00,param_01)
{
	var_02 = 360 / param_01;
	var_03 = param_00.angles;
	var_04 = [];
	for(var_05 = 0;var_05 < param_01;var_05++)
	{
		var_06 = var_02 / 2 + var_05 * var_02;
		var_07 = (var_03[0],var_03[1] + var_06,var_03[2]);
		var_08 = anglestoforward(var_07);
		var_09 = param_00.origin + var_08 * 350 + (0,0,-200);
		var_04[var_04.size] = var_09;
	}

	return var_04;
}

//Function Number: 102
func_6D31(param_00,param_01)
{
	var_02 = magicbullet("iw7_ufo_proj",param_00,param_00 + (0,0,-100));
	wait(0.6);
	if(isdefined(var_02) && isdefined(param_01) && !scripts\cp\_laststand::player_in_laststand(param_01))
	{
		var_02 missile_settargetent(param_01);
	}
}

//Function Number: 103
func_7C70(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(!func_37FF(var_03,param_00))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 104
func_37FF(param_00,param_01)
{
	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return 0;
	}

	if(!bullettracepassed(param_01.origin,param_00 geteye(),0,param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 105
func_12639()
{
	level endon("game_ended");
	scripts\cp\zombies\zombie_analytics::func_AF8B(level.wave_num);
	foreach(var_01 in level.spawned_enemies)
	{
		if(isdefined(var_01.agent_type) && var_01.agent_type == "generic_zombie")
		{
			var_01 lib_0C75::func_129A3(1);
			var_01 method_84E6(4);
			wait(randomfloatrange(0.3,0.7));
		}
	}
}

//Function Number: 106
func_15E6()
{
	level thread func_1056C();
}

//Function Number: 107
func_1056C()
{
	var_00 = getent("main_gate_powernode_damage_trigger","targetname");
	var_00 setcandamage(1);
	for(;;)
	{
		var_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		var_0B = func_7BD0(var_04);
		if(!isdefined(var_0B))
		{
			if(randomint(100) > 85)
			{
				scripts\cp\_vo::try_to_play_vo_on_all_players("nag_ufo_signfail");
			}

			continue;
		}

		if(scripts\common\utility::istrue(var_0B.var_9B4E))
		{
			continue;
		}

		if(func_3803(var_0A,var_02))
		{
			change_gate_light_color(var_0B);
			var_0B.var_9B4E = 1;
			var_0C = var_0B.origin;
			playsoundatpos(var_0C,"zmb_ufo_spaceland_sign_charge");
			level thread func_CE6E();
			if(should_play_arc_vfx(var_0B))
			{
				var_0D = scripts\common\utility::getstruct(var_0B.target,"targetname");
				var_0E = var_0D.origin;
				level thread func_CC90("powernode_arc_small",var_0C,var_0E,"spaceland_arc_fired");
			}

			if(func_1BF2())
			{
				level thread func_127B8();
			}
		}
	}
}

//Function Number: 108
should_play_arc_vfx(param_00)
{
	if(param_00.var_336 == "main_gate_powernode_5")
	{
		return 0;
	}

	return 1;
}

//Function Number: 109
change_gate_light_color(param_00)
{
	var_01 = get_nearby_gate_light_scriptable(param_00);
	var_01 setscriptablepartstate("main_gate_light","charged");
}

//Function Number: 110
get_nearby_gate_light_scriptable(param_00)
{
	var_01 = 10000;
	for(var_02 = 1;var_02 <= 5;var_02++)
	{
		var_03 = getent("gate_light_0" + var_02,"targetname");
		if(distancesquared(param_00.origin,var_03.origin) < var_01)
		{
			return var_03;
		}
	}
}

//Function Number: 111
func_3803(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = getweaponbasename(param_00);
	switch(var_02)
	{
		case "iw7_headcutter_zm_pap1":
		case "iw7_headcutter_zm":
		case "iw7_facemelter_zm_pap1":
		case "iw7_facemelter_zm":
		case "iw7_dischord_zm_pap1":
		case "iw7_dischord_zm":
		case "iw7_shredder_zm_pap1":
		case "iw7_shredder_zm":
			if(param_01 scripts\cp\_weapon::func_7D62(param_00) == 2)
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		default:
			return 0;
	}
}

//Function Number: 112
func_CC90(param_00,param_01,param_02,param_03)
{
	var_04 = spawnfx(scripts\common\utility::getfx("ufo_elec_beam_impact"),param_01);
	var_05 = spawnfx(scripts\common\utility::getfx("ufo_elec_beam_impact"),param_02);
	var_06 = scripts\common\utility::play_loopsound_in_space("zmb_ufo_spaceland_sign_charge_lp",param_01);
	triggerfx(var_04);
	triggerfx(var_05);
	for(;;)
	{
		function_02E0(scripts\common\utility::getfx(param_00),param_01,vectortoangles(param_01 - param_02),param_02);
		var_07 = scripts\common\utility::waittill_any_timeout_1(1,param_03);
		if(var_07 == param_03)
		{
			break;
		}
	}

	var_06 delete();
	var_04 delete();
	var_05 delete();
}

//Function Number: 113
func_1BF2()
{
	var_00 = ["main_gate_powernode_1","main_gate_powernode_2","main_gate_powernode_3","main_gate_powernode_4","main_gate_powernode_5"];
	foreach(var_02 in var_00)
	{
		var_03 = scripts\common\utility::getstruct(var_02,"targetname");
		if(!scripts\common\utility::istrue(var_03.var_9B4E))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 114
func_127B8()
{
	var_00 = (726,1788,154);
	var_01 = (608,1793,154);
	var_02 = (668,1580,154);
	var_03 = (669,1237,154);
	var_04 = (648,611,281);
	var_05 = (647,632,86);
	var_06 = (646,694,51);
	var_07 = scripts\common\utility::getstruct("main_gate_powernode_1","targetname");
	var_08 = scripts\common\utility::getstruct("main_gate_powernode_2","targetname");
	var_09 = scripts\common\utility::getstruct("main_gate_powernode_3","targetname");
	var_0A = scripts\common\utility::getstruct("main_gate_powernode_4","targetname");
	var_0B = scripts\common\utility::getstruct("main_gate_powernode_5","targetname");
	level thread func_CC90("powernode_arc_medium",var_08.origin,var_00,"spaceland_arc_fired");
	level thread func_CC90("powernode_arc_medium",var_0A.origin,var_01,"spaceland_arc_fired");
	level thread func_CC90("powernode_arc_medium",var_09.origin,var_02,"spaceland_arc_fired");
	level thread func_CC90("powernode_arc_medium",var_00,var_02,"spaceland_arc_fired");
	level thread func_CC90("powernode_arc_medium",var_01,var_02,"spaceland_arc_fired");
	playsoundatpos(var_00,"zmb_ufo_spaceland_sign_build");
	wait(randomfloatrange(1.3,1.7));
	level thread func_CC90("powernode_arc_big",var_02,var_03,"spaceland_arc_fired");
	wait(randomfloatrange(1.3,1.7));
	level thread func_CC90("powernode_arc_big",var_03,var_05,"spaceland_arc_fired");
	var_07.var_9B4E = 0;
	var_08.var_9B4E = 0;
	var_09.var_9B4E = 0;
	var_0A.var_9B4E = 0;
	var_0B.var_9B4E = 0;
	scripts\common\utility::exploder(90);
	wait(2);
	playsoundatpos(var_05,"zmb_ufo_spaceland_sign_wmd");
	level notify("spaceland_arc_fired");
	magicbullet("iw7_spaceland_wmd",var_04 + (0,0,50),var_04 + (0,0,2000));
	change_gate_light_scriptable_to_on_state();
}

//Function Number: 115
change_gate_light_scriptable_to_on_state()
{
	for(var_00 = 1;var_00 <= 5;var_00++)
	{
		var_01 = getent("gate_light_0" + var_00,"targetname");
		var_01 setscriptablepartstate("main_gate_light","on");
	}
}

//Function Number: 116
func_CE6E()
{
	wait(0.1);
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("quest_ufo_signhit_5","zmb_comment_vo","highest",10,0,0,0,50);
	}
}

//Function Number: 117
func_7BD0(param_00)
{
	var_01 = 10000;
	var_02 = ["main_gate_powernode_1","main_gate_powernode_2","main_gate_powernode_3","main_gate_powernode_4","main_gate_powernode_5"];
	foreach(var_04 in var_02)
	{
		var_05 = scripts\common\utility::getstruct(var_04,"targetname");
		if(distancesquared(var_05.origin,param_00) < var_01)
		{
			return var_05;
		}
	}
}

//Function Number: 118
func_CE72()
{
	var_00 = (-1066.27,-2577.7,2051.62);
	var_01 = (-2164.96,-2780.52,1923.13);
	var_02 = (-1710.99,-2499.7,1618.13);
	var_03 = 0.8;
	playsoundatpos((-1198,-2137,1946),"zmb_ufo_break_free_ice");
	playfx(level._effect["vfx_ufo_snow"],var_00);
	playfx(level._effect["vfx_ufo_snow"],var_01);
	wait(var_03);
	playfx(level._effect["vfx_ufo_snow"],var_02);
}