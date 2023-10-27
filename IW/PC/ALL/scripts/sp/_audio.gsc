/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_audio.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 1018 ms
 * Timestamp: 10/27/2023 12:23:51 AM
*******************************************************************/

//Function Number: 1
func_9539()
{
	if(isdefined(level.var_1188))
	{
		return;
	}

	setdvarifuninitialized("debug_audio","0");
	setdvarifuninitialized("debug_headroom","-1");
	setdvarifuninitialized("music_enable","1");
	level.var_1188 = spawnstruct();
	func_9785();
	thread func_ABD5();
}

//Function Number: 2
func_9BB3()
{
	if(!isdefined(level.var_1188.var_4E60))
	{
		return 1;
	}

	return level.var_1188.var_4E60;
}

//Function Number: 3
func_E2BB()
{
	if(func_9BB3() || isdefined(level.var_1188.var_9392))
	{
		level.var_1188.var_9392 = undefined;
		level.player method_807B("deathsdoor");
		level.player method_84D6();
		if(isdefined(level.var_4E61))
		{
			level.var_4E61 method_8278(0,2);
			wait(2);
			if(isdefined(level.var_4E61))
			{
				level.var_4E61 stoploopsound("deaths_door_lp");
			}

			wait(0.05);
			if(isdefined(level.var_4E61))
			{
				level.var_4E61 delete();
				return;
			}
		}
	}
}

//Function Number: 4
func_F334()
{
	level.var_1188.var_9392 = 1;
	if(func_9BB3())
	{
		if(isdefined(level.var_4E62))
		{
			thread func_D0D0();
			level.player method_8329(level.var_4E62,"deathsdoor","reverb");
			level.player setsoundsubmix("deaths_door_sp");
		}
		else
		{
			thread func_D0D0();
			level.player method_8329("deathsdoor","deathsdoor","reverb");
			level.player setsoundsubmix("deaths_door_sp");
		}

		if(!isdefined(level.var_4E61))
		{
			level.var_4E61 = spawn("script_origin",level.player.origin);
			level.var_4E61 method_8278(0,0.05);
			wait(0.05);
		}

		level.var_4E61 method_8278(1,2);
		level.var_4E61 playloopsound("deaths_door_lp");
	}
}

//Function Number: 5
func_D0D0()
{
	self endon("death");
	var_00 = 0.85;
	wait(0.2);
	for(;;)
	{
		if(scripts\sp\_utility::func_65DB("player_has_red_flashing_overlay"))
		{
			self playlocalsound("breathing_heartbeat");
		}
		else
		{
			break;
		}

		wait(var_00);
	}

	self playlocalsound("breathing_heartbeat_fade1");
	wait(var_00 + 0.1);
	self playlocalsound("breathing_heartbeat_fade2");
}

//Function Number: 6
func_ABD5()
{
	if(!isdefined(level.var_1188.var_ABD4))
	{
		level.var_1188.var_ABD4 = 1;
	}

	wait(0.05);
	function_0129(1,level.var_1188.var_ABD4);
}

//Function Number: 7
func_257D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 2;
	}

	if(!isdefined(param_04))
	{
		param_04 = 2;
	}

	if(!isdefined(param_06))
	{
		param_06 = 2;
	}

	if(isdefined(param_05))
	{
		thread func_2AE8(param_00,param_05,param_06);
	}

	var_07 = param_04 + 0.05;
	var_08 = 1;
	if(isdefined(param_01))
	{
		level.player method_82C0(param_01);
	}

	while(!function_0102())
	{
		wait(0.05);
	}

	level.player method_82C0("fade_to_black_minus_music",param_02);
	while(1 && function_0102())
	{
		var_09 = function_003C() / 1000;
		var_0A = param_00 - var_09;
		if(var_0A <= var_07)
		{
			var_08 = 0;
			break;
		}

		wait(0.05);
	}

	if(var_08 == 0)
	{
		if(isdefined(param_03))
		{
			level.player method_82C0(param_03,param_04);
			wait(2);
			level.player method_8070(2);
			return;
		}

		level.player method_8070(param_04);
		return;
	}

	level.player method_8070();
}

//Function Number: 8
func_2AE8(param_00,param_01,param_02)
{
	var_03 = 1;
	var_04 = param_02 + 0.05;
	while(!function_0102())
	{
		wait(0.05);
	}

	while(1 && function_0102())
	{
		var_05 = function_003C() / 1000;
		var_06 = param_00 - var_05;
		if(var_06 <= var_04)
		{
			var_03 = 0;
			break;
		}

		wait(0.05);
	}

	if(var_03 == 0)
	{
		function_01BA(param_01);
	}
}

//Function Number: 9
func_257C(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 2;
	}

	if(isdefined(param_00))
	{
		level.player method_82C0(param_00);
	}

	while(!function_0102())
	{
		wait(0.05);
	}

	level.player method_82C0("fade_to_black_minus_music",param_01);
}

//Function Number: 10
func_257B(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 2;
	}

	var_05 = param_02 + 0.05;
	if(!isdefined(param_04))
	{
		param_04 = 2;
	}

	if(isdefined(param_03))
	{
		thread func_2AE8(param_00,param_03,param_04);
	}

	var_06 = 1;
	while(!function_0102())
	{
		wait(0.05);
	}

	while(1 && function_0102())
	{
		var_07 = function_003C() / 1000;
		var_08 = param_00 - var_07;
		if(var_08 <= var_05)
		{
			var_06 = 0;
			break;
		}

		wait(0.05);
	}

	if(var_06 == 0)
	{
		if(isdefined(param_01))
		{
			level.player method_82C0(param_01,param_02);
			wait(2);
			level.player method_8070(2);
			return;
		}

		level.player method_8070(param_02);
		return;
	}

	level.player method_8070();
}

//Function Number: 11
func_9785()
{
	level.var_1188.var_11926 = spawnstruct();
	level.var_1188.var_11926.var_C8 = "";
	func_F5CE("default");
	soundsettimescalefactor("music_lr",0);
	soundsettimescalefactor("music_lsrs",0);
	soundsettimescalefactor("musicnopause_lr",0);
	soundsettimescalefactor("musicnopause_lsrs",0);
	soundsettimescalefactor("mus_emitter_3d",0);
	soundsettimescalefactor("menu_unres_2d",0);
	soundsettimescalefactor("menu_1_2d_lim",0);
	soundsettimescalefactor("menu_2_2d_lim",0);
	soundsettimescalefactor("scn_fx_unres_2d",0);
	soundsettimescalefactor("scn_fx_res_3d",0);
	soundsettimescalefactor("scn_fx_unres_3d",0);
}

//Function Number: 12
func_F5A0()
{
	soundsettimescalefactor("voice_air_3d",0);
	soundsettimescalefactor("voice_special_2d",0);
	soundsettimescalefactor("voice_narration_2d",0);
	soundsettimescalefactor("voice_plr_2d",0);
	soundsettimescalefactor("voice_radio_2d",0);
	soundsettimescalefactor("voice_plr_efforts_2d",0);
	soundsettimescalefactor("voice_plr_breath_2d",0);
	soundsettimescalefactor("voice_animal_1_3d",0);
	soundsettimescalefactor("voice_bchatter_1_3d",0);
}

//Function Number: 13
func_F59F()
{
	soundsettimescalefactor("voice_air_3d",1);
	soundsettimescalefactor("voice_special_2d",1);
	soundsettimescalefactor("voice_narration_2d",1);
	soundsettimescalefactor("voice_plr_2d",1);
	soundsettimescalefactor("voice_radio_2d",1);
	soundsettimescalefactor("voice_plr_efforts_2d",1);
	soundsettimescalefactor("voice_plr_breath_2d",1);
	soundsettimescalefactor("voice_animal_1_3d",1);
	soundsettimescalefactor("voice_bchatter_1_3d",1);
}

//Function Number: 14
func_25C0(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 2.5;
	}

	if(!isdefined(param_01))
	{
		param_01 = "normal";
	}

	if(!isdefined(param_02))
	{
		param_02 = "clear_all";
	}

	level.player playsound("plr_helmet_on_visor_down_lr");
	if(param_00 != 0)
	{
		level.player scripts\common\utility::delaycall(0.5,::method_82C3,"helmet_on_visor_down",0.2,"mix","filter");
		wait(param_00);
		if(param_01 == "normal")
		{
			level.player scripts\common\utility::delaycall(0.1,::playsound,"plr_helmet_short_boot_up_lr");
		}
		else
		{
			level.player scripts\common\utility::delaycall(0.1,::playsound,"plr_helmet_boot_up_fast_lr");
		}

		if(param_02 == "clear_all")
		{
			level.player scripts\common\utility::delaycall(0.45,::method_8070,0.2);
			return;
		}

		level.player scripts\common\utility::delaycall(0.45,::method_82C0,param_02,0.2);
	}
}

//Function Number: 15
func_25C1()
{
}

//Function Number: 16
func_25C2(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 2.5;
	}

	if(!isdefined(param_01))
	{
		param_01 = "normal";
	}

	if(!isdefined(param_02))
	{
		param_02 = "clear_all";
	}

	level.player playsound("plr_helmet_visor_pull_down_w_air_lr");
	level.player scripts\common\utility::delaycall(0.5,::method_82C3,"helmet_on_visor_down",0.2,"mix","filter");
	wait(param_00);
	if(param_01 == "normal")
	{
		level.player scripts\common\utility::delaycall(0.1,::playsound,"plr_helmet_short_boot_up_lr");
	}
	else
	{
		level.player scripts\common\utility::delaycall(0.1,::playsound,"plr_helmet_boot_up_fast_lr");
	}

	if(param_02 == "clear_all")
	{
		level.player scripts\common\utility::delaycall(0.45,::method_8070,0.2);
		return;
	}

	level.player scripts\common\utility::delaycall(0.45,::method_82C0,param_02,0.2);
}

//Function Number: 17
func_25C3()
{
	level.player playsound("plr_helmet_visor_pull_up_w_air_lr");
}

//Function Number: 18
func_25BF()
{
	level.player playsound("plr_helmet_off_lr");
	level.player playsound("plr_helmet_off_lyr_lr");
	level.player method_8070(0.25);
}

//Function Number: 19
func_25BE()
{
	level.player playsound("plr_helmet_off_lr");
}

//Function Number: 20
func_F5CE(param_00)
{
	if(level.var_1188.var_11926.var_C8 == param_00)
	{
		return;
	}

	level.var_1188.var_11926.var_C8 = param_00;
	level.player method_8352(param_00);
}

//Function Number: 21
func_4F0F(param_00,param_01)
{
}

//Function Number: 22
func_4ED0()
{
	return 0;
}