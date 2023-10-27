/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\youngblood_exit_ride.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 96 ms
 * Timestamp: 10/27/2023 1:37:08 AM
*******************************************************************/

//Function Number: 1
func_3091()
{
	var_00 = maps\_utility::func_777F("player_rig",level.player.origin);
	common_scripts\utility::flag_set("truck_pickup_npcs");
	level.elias maps\_utility::func_252F(0.1,::maps\_utility::func_7628,"youngblood_els_itoldyouto");
	var_01 = getdvarint("awesome",1);
	var_02 = getdvarint("scr_art_tweak",0);
	if(!var_01)
	{
		var_03 = getnode("start_truck_part3","script_noteworthy");
	}
	else
	{
		var_03 = getnode("start_truck_part3_2","script_noteworthy");
	}

	level.var_83D3 attachpath(var_03);
	level.var_83D3 thread maps\_vehicle::func_8902(var_03);
	level.var_83D3 startpath(var_03);
	thread city_collapse();
	level.hesh linkto(level.var_83D3,"tag_body");
	level.elias linkto(level.var_83D3,"tag_body");
	thread hesh_getin_truck();
	level.var_83D3 thread maps\_anim::anim_loop_solo(var_00,"youngblood_truck_exit_idle_player");
	level.var_83D3 thread maps\_anim::anim_generic_loop(level.elias,"youngblood_truck_exit_idle_elias");
	level.player playerlinktodelta(var_00,"tag_player",0.5,0,45,25,25);
	var_00 show();
	var_00 linkto(level.var_83D3,"tag_body");
	level.player shellshock("ygb_end_lite",999);
	level notify("stop_vfx_on_player");
	level.var_5EB5 = 1;
	level.var_5E87 = "vfx_yb_onplayer_city_vista_a";
	level.player thread maps/youngblood_code::func_898F();
	wait(1.5);
	if(var_01)
	{
		maps\_utility::func_252F(0,::maps\_utility::func_8A02,"",2.3);
	}

	level thread maps\_hud_util::func_3131(0.6);
	level.player setblurforplayer(0,3);
	if(var_02)
	{
		level.var_83D3 setspeed(0,4,4);
		return;
	}

	level.var_83D3 setspeed(10,1);
	if(!isdefined(level.var_61E7) || isdefined(level.var_61E7) && level.var_61E7 == 0)
	{
		wait(7);
		mission_finished();
		return;
	}

	level.player common_scripts\utility::delaycall(5.75,::setblurforplayer,8,6);
	level maps\_utility::func_252F(5.25,::maps\_hud_util::fade_out,8);
	maps\_utility::func_252F(5.75,::fade_in_logo);
	wait(12);
	var_04 = maps\_hud_util::func_3920("black");
	var_04.sort = 3;
	var_04.foreground = 0;
	var_04 fadeovertime(1);
	level.var_4F1F fadeovertime(1);
	level.var_4F20 fadeovertime(1);
	level.var_4F20.alpha = 0.25;
	level.player method_83BF("youngblood_end_fade_out",3);
	wait(1.2);
	level.var_4F1F fadeovertime(1);
	level.var_4F1F.alpha = 0;
	level.var_4F20 fadeovertime(1);
	level.var_4F20.alpha = 0;
	wait(2);
	mission_finished();
}

//Function Number: 2
city_collapse()
{
	maps\_utility::trigger_wait("city_rog_trig","script_noteworthy");
	maps\_utility::activate_trigger_with_noteworthy("building_collapse_trig");
}

//Function Number: 3
hesh_getin_truck()
{
	level.hesh maps\_utility::func_252F(0.1,::maps/youngblood_util::_set_anim_time,"youngblood_truck_exit_getin_hesh",0.23);
	level.var_83D3 maps\_anim::anim_single_solo(level.hesh,"youngblood_truck_exit_getin_hesh");
	level.var_83D3 thread maps\_anim::anim_loop_solo(level.hesh,"youngblood_truck_exit_idle_hesh");
}

//Function Number: 4
fade_in_logo()
{
	var_00 = maps\_hud_util::func_3920("black");
	var_00.sort = 3;
	var_00.foreground = 0;
	wait(0.5);
	var_01 = level.player maps\_hud_util::createclienticon("logo_game_big_blur_blend",500,250);
	var_01.sort = 4;
	var_01 maps\_hud_util::func_70A4("CENTER","CENTER",0,0,0);
	var_01.alpha = 0;
	var_01 fadeovertime(1);
	var_01.alpha = 0.8;
	wait(0.25);
	var_02 = level.player maps\_hud_util::createclienticon("logo_game_big",500,250);
	var_02.sort = 5;
	var_02 maps\_hud_util::func_70A4("CENTER","CENTER",0,0,0);
	var_02.alpha = 0;
	var_02 fadeovertime(1);
	var_02.alpha = 1;
	level.var_4F1F = var_02;
	level.var_4F20 = var_01;
}

//Function Number: 5
func_777D()
{
	common_scripts\utility::trigger_off("player_get_in_truck","targetname");
	level.var_83D3 = maps\_vehicle::func_784E("truck");
	level.var_83D3.animname = "pickup";
	level.var_83D3 method_826D(level.var_6AED["pickup"]);
	level.var_83D3 thread maps\_anim::anim_single_solo(level.var_83D3,"youngblood_truck_gate_open");
	var_00 = getnode("start_truck_drive_in_b","script_noteworthy");
	level.var_83D3 teleport(var_00.origin,var_00.angles);
	level.var_83D3 maps\_vehicle::func_88F3("headlights");
	maps/youngblood_util::func_77AA();
	var_01 = common_scripts\utility::func_3C18("elias_pickup_exit_spawn","targetname");
	level.elias method_81FA(var_01.origin,var_01.angles);
	level.elias linkto(level.var_83D3,"tag_origin");
	level.var_83D3 thread maps\_anim::anim_generic_loop(level.elias,"youngblood_truck_exit_idle_elias","elias_car_stop");
	level.var_83D3 attachpath(var_00);
	level.var_83D3 thread maps\_vehicle::func_8902(var_00);
	level.var_83D3 startpath(var_00);
	common_scripts\utility::flag_wait("truck_2nd_position");
	var_00 = getnode("start_truck_part2","script_noteworthy");
	level.var_83D3 attachpath(var_00);
	level.var_83D3 thread maps\_vehicle::func_8902(var_00);
	level.var_83D3 startpath(var_00);
	common_scripts\utility::flag_wait("truck_3rd_position");
	level.var_83D3 notify("elias_car_stop");
	waittillframeend;
	level.player method_83BF("youngblood_end_black",3);
	level.elias maps\_utility::func_252F(2,::maps\_utility::func_7628,"youngblood_els_getinthetruck");
	level.var_83D3 maps\_anim::func_D64(level.elias,"youngblood_truck_exit_getin_elias");
	level.var_83D3 thread maps\_anim::anim_generic_loop(level.elias,"youngblood_truck_exit_idle_elias","elias_car_stop");
	if(getdvarint("chaos_long_end") == 1)
	{
		level.player setblurforplayer(10,1.8);
		level maps\_hud_util::fade_out(3.6);
		wait(5);
	}

	level.player setblurforplayer(10,1.8);
	level maps\_hud_util::fade_out(3.6);
	common_scripts\utility::flag_set("truck_1st_position");
	var_00 = getnode("start_truck_part3","script_noteworthy");
	level.var_83D3 attachpath(var_00);
	level.var_83D3 thread maps\_vehicle::func_8902(var_00);
	level.var_83D3 startpath(var_00);
	level.hesh linkto(level.var_83D3,"tag_origin");
	level.var_83D3 thread maps\_anim::anim_loop_solo(level.hesh,"youngblood_truck_exit_idle_hesh");
	var_02 = maps\_utility::func_777F("player_rig",level.player.origin);
	maps/youngblood_util::func_89B9();
	level.var_83D3 maps\_anim::anim_first_frame_solo(var_02,"youngblood_truck_exit_getin_player");
	level.player playerlinktodelta(var_02,"tag_player",1,45,45,25,25);
	var_02 show();
	level.var_83D3 maps\_anim::anim_single_solo(var_02,"youngblood_truck_exit_getin_player");
	level.var_83D3 thread maps\_anim::anim_loop_solo(var_02,"youngblood_truck_exit_idle_player");
	var_02 linkto(level.var_83D3,"tag_origin");
	level.player method_8301(65,0.1);
	level thread maps\_hud_util::func_3131(3);
	level.player setblurforplayer(0,6);
	wait(1);
	common_scripts\utility::flag_set("truck_pickup_npcs");
	level.var_83D3 setspeed(10,3);
	level.player thread func_5D9E();
	wait(1);
	etslowmotion(1,0.3,3);
	wait(3);
	level.player setblurforplayer(10,2);
	level maps\_hud_util::fade_out(4);
	thread mission_finished();
}

//Function Number: 6
func_5D9E()
{
	self endon("dying");
	for(;;)
	{
		wait(0.05);
		if(randomint(100) > 10)
		{
			continue;
		}

		var_00 = randomint(2) + 4;
		var_01 = randomfloatrange(0.1,0.3);
		var_02 = randomfloatrange(0.3,1);
		function_0195(var_00 * 1.2,var_01);
		wait(var_01);
		function_0195(0,var_02);
		wait(var_02);
		wait(randomfloatrange(0,1.5));
		common_scripts\utility::waittill_notify_or_timeout("blur",5);
	}
}

//Function Number: 7
mission_finished()
{
	maps\_utility::func_55F6();
}