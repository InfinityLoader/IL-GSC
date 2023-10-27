/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3413.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 12:27:08 AM
*******************************************************************/

//Function Number: 1
func_6B8F()
{
	func_95D9();
	level.fast_travel_spots = [];
	level.zipline_negotiation = function_00B3("zombie_zipline","script_noteworthy");
	var_00 = getentarray("zipline_trigger","targetname");
	level.zipline_traversals = [];
	level.ziplines_achievement_trigger_list = [];
	level.ziplines_achievement_trigger_list = var_00;
	foreach(var_02 in var_00)
	{
		var_02 thread func_97AD();
	}

	level thread watch_for_zipline_achievement();
}

//Function Number: 2
watch_for_zipline_achievement()
{
	level endon("game_ended");
	level endon("zipline_achievement_done");
	while(level.ziplines_achievement_trigger_list.size > 0)
	{
		scripts\common\utility::func_136F7();
	}

	foreach(var_01 in level.players)
	{
		var_01 lib_0D2A::func_12D7C("RIDE_FOR_YOUR_LIFE",4);
	}

	level notify("zipline_achievement_done");
}

//Function Number: 3
func_95D9()
{
	level.var_28C9 = loadfx("vfx/core/mp/core/vfx_battle_slide_camera");
}

//Function Number: 4
func_97AD()
{
	level endon("game_ended");
	self.var_19 = 0;
	self.var_13EFC = scripts\common\utility::getstruct(self.target,"targetname");
	var_00 = scripts\common\utility::getstruct(self.var_13EFC.target,"targetname");
	while(isdefined(var_00.target))
	{
		var_00 = scripts\common\utility::getstruct(var_00.target,"targetname");
	}

	self.var_13EFB = var_00;
	scripts\common\utility::flag_wait("init_spawn_volumes_done");
	self.var_164A = undefined;
	foreach(var_02 in level.var_10816)
	{
		if(function_010F(self.var_13EFB.origin,var_02))
		{
			self.var_164A = var_02;
			break;
		}
	}

	if(!isdefined(self.var_164A))
	{
		return;
	}
	else
	{
	}

	self.var_13EFC.var_62E4 = self.var_13EFB;
	self.var_13EFC.trigger = self;
	self.var_13EFB.var_10CBA = self.var_13EFC;
	self.var_13EFB.trigger = self;
	for(;;)
	{
		level waittill("volume_activated",var_04);
		if(var_04 == self.var_164A.var_28AB)
		{
			activate_zipline();
			break;
		}
	}
}

//Function Number: 5
activate_zipline()
{
	self.var_19 = 1;
	thread func_AD5D();
	if(isdefined(level.zipline_negotiation))
	{
		var_00 = scripts\common\utility::func_5D14(self.var_13EFC.origin,0,-512);
		var_01 = scripts\common\utility::func_5D14(self.var_13EFB.origin,0,-512);
		level.zipline_traversals[level.zipline_traversals.size] = self;
		self.traversal_start = var_00;
		self.traversal_end = var_01;
		function_004D(self.target,var_00,var_01,level.zipline_negotiation,64,1);
	}
}

//Function Number: 6
func_AD5D()
{
	var_00 = 0.1;
	var_01 = gettime();
	var_02 = [];
	for(;;)
	{
		self waittill("trigger",var_03);
		if(isplayer(var_03))
		{
			var_03 method_80F4(&"CP_RAVE_USE_ZIPLINE");
			var_03 thread handle_zipline_hint(self);
			if(var_03 isjumping())
			{
				if(!scripts\common\utility::istrue(var_03.var_9BE1))
				{
					scripts\common\utility::trigger_off();
					var_03.var_9BE1 = 1;
					thread player_zipline_travel(var_03,var_01);
					var_03 scripts\cp\_merits::func_D9AD("mt_dlc1_all_ziplines");
					if(scripts\common\utility::func_2286(level.ziplines_achievement_trigger_list,self))
					{
						level.ziplines_achievement_trigger_list = scripts\common\utility::func_22A9(level.ziplines_achievement_trigger_list,self);
					}

					var_01 = gettime() + 500;
					wait(1);
					scripts\common\utility::trigger_on();
				}
			}
		}

		wait(var_00);
	}
}

//Function Number: 7
handle_zipline_hint(param_00)
{
	self endon("disconnect");
	if(isdefined(self.zipline_hint))
	{
		return;
	}

	self.zipline_hint = 1;
	while(!scripts\cp\_laststand::player_in_laststand(self) && !scripts\common\utility::istrue(self.var_9BE1) && self istouching(param_00))
	{
		wait(0.05);
	}

	self.zipline_hint = undefined;
	self method_80F3();
}

//Function Number: 8
func_5591(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.var_3859 = 0;
	param_00 waittill(param_02);
	wait(param_01);
	param_00.var_3859 = 1;
	param_00 notify("can_teleport");
}

//Function Number: 9
player_zipline_travel(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 thread scripts\cp\_vo::try_to_play_vo("zipline_use","rave_comment_vo");
	param_00 method_85B3("zipline",1);
	param_00 scripts\common\utility::func_1C40(0);
	param_00 scripts\common\utility::func_1C60(0);
	param_00 method_80A4();
	param_00.disable_consumables = 1;
	param_00 scripts\common\utility::func_1C35(0);
	param_00 scripts\common\utility::allow_jump(0);
	param_00 scripts\common\utility::func_1C53(0);
	param_00 scripts\common\utility::func_1C62(0);
	param_00 disableautoreload();
	param_00 scripts\common\utility::func_1C76(0);
	param_00 method_857E(1);
	var_02 = player_zipline(param_00,param_01);
	param_00 lerpfovbypreset("zombiedefault");
	wait(0.1);
	param_00 scripts\common\utility::func_1C35(1);
	param_00 scripts\common\utility::allow_jump(1);
	param_00 scripts\common\utility::func_1C53(1);
	param_00 scripts\common\utility::func_1C62(1);
	param_00 scripts\common\utility::func_1C40(1);
	param_00 scripts\common\utility::func_1C60(1);
	param_00 enableautoreload();
	param_00 scripts\common\utility::func_1C76(1);
	param_00 method_857E(0);
	param_00 notify("fast_travel_complete");
	param_00 thread scripts\cp\_vo::try_to_play_vo("zipline_exit","rave_comment_vo");
}

//Function Number: 10
delay_nearby_zombie_cleanup()
{
	var_00 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_10C) && var_02.var_10C == self && distancesquared(var_02.origin,self.origin) < 272144)
		{
			var_02.delay_cleanup_until = gettime() + 12000;
		}
	}
}

//Function Number: 11
player_zipline(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 earthquakeforplayer(0.3,0.2,param_00.origin,200);
	param_00 playsound("rave_zipline_start");
	var_02 = self.var_13EFC;
	var_03 = self.var_13EFB;
	param_00 cancelmantle();
	var_04 = var_02.origin + (0,0,-45);
	var_05 = var_03.origin + (0,0,-45);
	param_00.zipline = self;
	param_00 delay_nearby_zombie_cleanup();
	param_00 setorigin(var_04 + (0,0,-45));
	param_00 setplayerangles(var_02.angles);
	var_06 = spawn("script_model",var_04);
	var_06.angles = var_02.angles;
	var_06 setmodel("tag_origin");
	var_07 = getent("zipline_cord","targetname");
	if(isdefined(var_07))
	{
		var_07 linkto(var_06);
	}

	var_08 = getent("zipline_handle","targetname");
	if(isdefined(var_08))
	{
		var_08 linkto(var_06);
	}

	param_00 playerlinkto(var_06,undefined,0.5,20,10,50,40);
	var_06 playloopsound("rave_zipline_lp");
	param_00 playlocalsound("rave_zipline_wind_lr");
	param_00 playerlinkedoffsetenable();
	param_00 playgestureviewmodel("ges_zipline");
	while(param_01 > gettime())
	{
		wait(0.05);
	}

	wait(1);
	param_00 lerpfovbypreset("zombiearcade");
	var_09 = param_00 method_816D();
	param_00 method_8369("viewmodel_arms_invisi");
	var_0A = var_02;
	var_0B = scripts\common\utility::getstructarray(var_0A.target,"targetname");
	var_0C = scripts\common\utility::random(var_0B);
	var_0D = distance(var_0A.origin,var_05);
	param_01 = var_0D / 500;
	var_06 moveto(var_05,param_01);
	param_00 thread func_ECC7(param_01);
	wait(param_01);
	for(var_0A = var_0C;isdefined(var_0A.target);var_0A = var_0C)
	{
		var_0B = scripts\common\utility::getstructarray(var_0A.target,"targetname");
		var_0C = scripts\common\utility::random(var_0B);
		var_05 = var_0C.origin;
		var_0D = distance(var_0A.origin,var_05);
		param_01 = var_0D / 500;
		var_06 moveto(var_05,param_01);
		param_00 thread func_ECC7(param_01);
		wait(param_01);
	}

	param_00 stopgestureviewmodel("ges_zipline",0.1,0);
	param_00 playsound("rave_zipline_stop");
	var_06 stoploopsound("rave_zipline_lp");
	param_00 method_8369(var_09);
	param_00.var_9BE1 = undefined;
	param_00.zipline = undefined;
	param_00 limitedmovement(1);
	param_00.var_13EFD = vectornormalize(anglestoforward(param_00.angles)) * 500 * 0.1;
	param_00 unlink();
	param_00 stoplocalsound("rave_zipline_wind_lr");
	param_00 stoplocalsound("rave_zipline_wind_lsrs");
	param_00 method_85B3("zipline",0);
	param_00 setvelocity(param_00.var_13EFD);
	param_00.disable_consumables = undefined;
	param_00 method_80D6();
	var_06 notify("stop_sway");
	wait(0.5);
	var_06 delete();
	param_00 limitedmovement(0);
	param_00 thread clear_zipline_landing_area();
}

//Function Number: 12
clear_zipline_landing_area()
{
	self endon("disconnect");
	while(!self isonground())
	{
		foreach(var_01 in level.players)
		{
			if(var_01 == self)
			{
				continue;
			}

			if(distance2d(var_01.origin,self.origin) < 24)
			{
				var_01 setvelocity((-50,-100,0));
			}
		}

		wait(0.1);
	}
}

//Function Number: 13
func_11325(param_00,param_01,param_02)
{
	self endon("stop_sway");
	var_03 = 10;
	var_04 = 0.5;
	var_05 = self.angles;
	var_06 = int(param_00);
	var_07 = 1;
	for(var_08 = 0;var_08 < var_06;var_08++)
	{
		if(var_07)
		{
			var_07 = 0;
			self rotateyaw(var_03,var_04,0.2,0.2);
			wait(var_04);
			wait(0.1);
			self rotateyaw(var_03 * -1,var_04,0.2,0.2);
			wait(var_04);
			continue;
		}

		var_07 = 1;
		self rotateyaw(var_03 * -1,var_04,0.2,0.2);
		wait(var_04);
		wait(0.1);
		self rotateyaw(var_03,var_04,0.2,0.2);
		wait(var_04);
	}

	self rotateto(var_05,1);
}

//Function Number: 14
func_ECC7(param_00)
{
	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	var_03 = function_01E1(level.var_28C9,self geteye(),self);
	while(var_01 < var_02)
	{
		var_03.origin = self geteye();
		triggerfx(var_03);
		earthquake(0.2,0.25,self.origin,96);
		self playrumbleonentity("slide_loop");
		scripts\common\utility::func_136F7();
		var_01 = gettime();
	}

	if(isdefined(var_03))
	{
		var_03 delete();
	}
}

//Function Number: 15
func_1164E(param_00)
{
	var_01 = undefined;
	while(!isdefined(var_01))
	{
		foreach(var_03 in self.end_positions)
		{
			if(!positionwouldtelefrag(var_03.origin))
			{
				var_01 = var_03;
			}
		}

		wait(0.1);
	}

	param_00 unlink();
	param_00 dontinterpolate();
	param_00 setorigin(var_01.origin);
	param_00 setplayerangles(var_01.angles);
	param_00.disable_consumables = undefined;
	param_00 method_80D6();
}