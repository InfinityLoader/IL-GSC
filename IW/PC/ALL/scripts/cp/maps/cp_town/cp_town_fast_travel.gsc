/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_fast_travel.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 516 ms
 * Timestamp: 10/27/2023 12:07:19 AM
*******************************************************************/

//Function Number: 1
init_teleport_portals()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("fast_travel_portal","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getentarray("chi_door_fast_travel_portal_trigger","targetname");
		self.trigger = scripts\common\utility::getclosest(self.origin,var_03,500);
		self.start_point_name = self.script_noteworthy;
		self.end_point_name = self.var_EE79;
		self.end_point = scripts\common\utility::getstruct(self.var_EE79,"script_noteworthy");
		self.teleport_door = scripts\common\utility::getclosest(self.origin,getentarray("chi_door_fast_travel","targetname"));
		var_04 = getentarray("chi_door_fast_travel_symbol","targetname");
		if(isdefined(var_04))
		{
			self.teleport_door_symbol = scripts\common\utility::getclosest(self.origin,var_04);
		}

		self.var_DDC4 = [];
		self.var_4613 = 0;
		self.var_C626 = 0;
		if(!isdefined(self.angles))
		{
			self.angles = (0,0,0);
		}

		self.teleport_spots = scripts\common\utility::getstructarray(self.end_point.target,"targetname");
		script_add_teleport_spots();
		foreach(var_06 in self.teleport_spots)
		{
			if(!isdefined(var_06.angles))
			{
				var_06.angles = (0,0,0);
			}
		}
	}
}

//Function Number: 2
script_add_teleport_spots()
{
	var_00 = [];
	var_01 = (0,0,0);
	foreach(var_03 in var_00)
	{
		var_04 = spawnstruct();
		var_04.origin = var_03;
		var_04.angles = var_01;
		var_04.var_336 = self.teleport_spots[0].var_336;
		self.teleport_spots[self.teleport_spots.size] = var_04;
	}
}

//Function Number: 3
move_player_through_portal_tube(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00.disable_consumables = 1;
	param_00.isfasttravelling = 1;
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_02 = func_BC83(param_00,"fast_travel_tube_start","fast_travel_tube_end");
	if(isdefined(self.var_4613))
	{
		self.var_4613 = self.var_4613 + 30;
	}

	teleport_to_portal_safe_spot(param_00,param_01);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_02 delete();
	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00.isfasttravelling = undefined;
	param_00.disable_consumables = undefined;
	param_00 notify("fast_travel_complete");
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 thread update_personal_ents_after_delay();
	if(param_00.var_134FD == "p5_")
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("fasttravel_exit","town_comment_vo");
	}
}

//Function Number: 4
func_BC83(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("move_through_tube");
	param_00 earthquakeforplayer(0.3,0.2,param_00.origin,200);
	var_03 = getent(param_01,"targetname");
	var_04 = getent(param_02,"targetname");
	param_00 cancelmantle();
	param_00.var_C004 = 1;
	param_00.var_C016 = 1;
	var_05 = var_03.origin + (0,0,-45);
	var_06 = var_04.origin + (0,0,-45);
	param_00.var_9BE1 = 1;
	param_00 scripts\cp\_utility::func_17C0("fast_travel",0,0);
	param_00 scripts\cp\_utility::func_1C5C(1);
	param_00 dontinterpolate();
	param_00 setorigin(var_05);
	param_00 setplayerangles(var_03.angles);
	param_00 playlocalsound("zmb_portal_travel_lr");
	var_07 = spawn("script_origin",var_05);
	param_00 playerlinkto(var_07);
	param_00 method_8232();
	wait(0.1);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	var_07 moveto(var_06,1);
	wait(1);
	param_00.var_9BE1 = undefined;
	param_00 scripts\cp\_utility::func_E0E6("fast_travel",0);
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	param_00.var_9BE1 = undefined;
	param_00.var_C004 = 0;
	param_00.var_C016 = 0;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	return var_07;
}

//Function Number: 5
move_zombie_through_portal_tube(param_00)
{
	param_00.isfasttravelling = 1;
	var_01 = func_BC83(param_00,"fast_travel_tube_start","fast_travel_tube_end",1);
	teleport_to_portal_safe_spot(param_00);
	wait(0.1);
	var_01 delete();
	param_00.isfasttravelling = undefined;
}

//Function Number: 6
update_personal_ents_after_delay()
{
	self endon("disconnect");
	scripts\common\utility::func_136F7();
	scripts\cp\_interaction::func_DE6E();
}

//Function Number: 7
unlinkplayerafterduration()
{
	while(scripts\common\utility::istrue(self.isrewinding) || isdefined(self.rewindmover))
	{
		scripts\common\utility::func_136F7();
	}

	self unlink();
}

//Function Number: 8
teleport_to_portal_safe_spot(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = self.teleport_spots;
	}

	var_03 = undefined;
	while(!isdefined(var_03))
	{
		foreach(var_05 in var_02)
		{
			if(!positionwouldtelefrag(var_05.origin))
			{
				var_03 = var_05;
			}
		}

		if(!isdefined(var_03))
		{
			if(!isdefined(var_02[0].angles))
			{
				var_02[0].angles = (0,0,0);
			}

			var_07 = scripts\cp\_utility::func_13192(anglestoforward(var_02[0].angles),64);
			var_03 = spawnstruct();
			var_03.origin = var_02[0].origin + var_07;
			var_03.angles = var_02[0].angles;
		}

		wait(0.1);
	}

	param_00 method_8447();
	if(scripts\common\utility::istrue(param_00.isrewinding) || isdefined(self.rewindmover))
	{
		param_00 thread unlinkplayerafterduration();
	}
	else
	{
		param_00 unlink();
	}

	param_00 dontinterpolate();
	param_00 setorigin(var_03.origin);
	param_00 setplayerangles(var_03.angles);
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00.portal_end_origin = var_03.origin;
}

//Function Number: 9
delay_portal_trigger_on_player(param_00,param_01)
{
	wait(param_01);
	param_00.recently_used_portal = undefined;
	wait(param_01 * 2);
	self.var_DDC4 = scripts\common\utility::func_22A9(self.var_DDC4,param_00);
}