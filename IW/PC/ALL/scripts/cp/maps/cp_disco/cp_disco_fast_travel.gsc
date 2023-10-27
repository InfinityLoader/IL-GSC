/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_fast_travel.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 767 ms
 * Timestamp: 10/27/2023 12:03:50 AM
*******************************************************************/

//Function Number: 1
init_teleport_portals()
{
	wait(5);
	var_00 = scripts\common\utility::getstructarray("fast_travel_portal","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread trigger_when_player_close_by();
		wait(0.1);
	}
}

//Function Number: 2
trigger_when_player_close_by()
{
	var_00 = getentarray("chi_door_fast_travel_portal_trigger","targetname");
	self.trigger = scripts\common\utility::getclosest(self.origin,var_00,500);
	self.start_point_name = self.script_noteworthy;
	self.end_point_name = self.var_EE79;
	self.end_point = scripts\common\utility::getstruct(self.var_EE79,"script_noteworthy");
	self.teleport_door = scripts\common\utility::getclosest(self.origin,getentarray("chi_door_fast_travel","targetname"));
	var_01 = getentarray("chi_door_fast_travel_symbol","targetname");
	if(isdefined(var_01))
	{
		self.teleport_door_symbol = scripts\common\utility::getclosest(self.origin,var_01);
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
	foreach(var_03 in self.teleport_spots)
	{
		if(!isdefined(var_03.angles))
		{
			var_03.angles = (0,0,0);
		}
	}

	self.teleport_door setcandamage(1);
	self.teleport_door setcanradiusdamage(1);
	self.teleport_door.health = 10000000;
	for(;;)
	{
		self.teleport_door waittill("damage",var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E);
		if(is_shuriken(var_0E))
		{
			break;
		}

		if(isplayer(var_06) && scripts\common\utility::istrue(var_06.kung_fu_mode))
		{
			break;
		}

		wait(0.1);
	}

	self.var_C626 = 1;
	self.teleport_door hide();
	if(isdefined(self.teleport_door_symbol))
	{
		self.teleport_door_symbol hide();
	}

	var_0F = scripts\common\utility::getstructarray("chi_door_fast_travel_portal_spot","targetname");
	self.portal_spot = scripts\common\utility::getclosest(self.origin,var_0F,500);
	self.portal_scriptable = spawn("script_model",self.portal_spot.origin + (0,0,53));
	self.portal_scriptable setmodel("tag_origin_chi_portal");
	self.portal_scriptable.angles = self.angles;
	playsoundatpos(self.portal_spot.origin,"cp_disco_doorbuy_wood_break");
	self.portal_scriptable setscriptablepartstate("portal","door_break");
	var_06 thread scripts\cp\_vo::try_to_play_vo("door_wooden_sucess","disco_comment_vo");
	thread portal_cooldown_monitor();
	wait(1);
	for(;;)
	{
		self.trigger waittill("trigger",var_10);
		if(scripts\common\utility::istrue(var_10.isrewinding))
		{
			scripts\common\utility::func_136F7();
			var_10 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_10);
			continue;
		}

		if(scripts\common\utility::istrue(var_10.inlaststand))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isplayer(var_10))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(self.end_point.var_C626 && self.var_4613 <= 0)
		{
			if(isdefined(level.clock_interaction_q2))
			{
				if(scripts\common\utility::istrue(level.clock_interaction_q2.clock_active))
				{
					self.end_point.var_4613 = 0;
					var_10.travelled_thru_portal = 1;
					var_10.portal_start_origin = var_10.origin;
				}
				else
				{
					self.end_point.var_4613 = self.end_point.var_4613 + 30;
				}
			}
			else if(isdefined(level.clock_interaction_q3))
			{
				if(scripts\common\utility::istrue(level.clock_interaction_q3.clock_active))
				{
					self.end_point.var_4613 = 0;
					var_10.travelled_thru_portal = 1;
					var_10.portal_start_origin = var_10.origin;
				}
				else
				{
					self.end_point.var_4613 = self.end_point.var_4613 + 30;
				}
			}
			else
			{
				self.end_point.var_4613 = self.end_point.var_4613 + 30;
			}

			move_player_through_portal_tube(var_10);
		}

		wait(0.1);
	}
}

//Function Number: 3
is_shuriken(param_00)
{
	if(isdefined(param_00))
	{
		if(issubstr(param_00,"shuriken"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
script_add_teleport_spots()
{
	var_00 = [];
	if(self.teleport_spots[0].origin == (-758,1902,800))
	{
		var_00 = [(-758,1928,800),(-730,1902,800),(-758,1878,800)];
	}
	else if(self.teleport_spots[0].origin == (-2332,3146,266))
	{
		var_00 = [(-2308,3146,266),(-2332,3122,266),(-2356,3146,266)];
	}
	else if(self.teleport_spots[0].origin == (-970,514,944))
	{
		var_00 = [(-1004,514,944),(-970,542,944),(-938,514,944)];
	}
	else if(self.teleport_spots[0].origin == (-2288,4728,784))
	{
		var_00 = [(-2314,4728,784),(-2288,4700,784),(-2264,4728,784)];
	}

	var_01 = self.teleport_spots[0].angles;
	foreach(var_03 in var_00)
	{
		var_04 = spawnstruct();
		var_04.origin = var_03;
		var_04.angles = var_01;
		var_04.var_336 = self.teleport_spots[0].var_336;
		self.teleport_spots[self.teleport_spots.size] = var_04;
	}
}

//Function Number: 5
turn_on_portal()
{
	self.portal_scriptable setscriptablepartstate("portal","active");
}

//Function Number: 6
watch_for_rewind_quest()
{
	self endon("disconnect");
	for(;;)
	{
		if(!scripts\common\utility::istrue(self.isrewinding))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isdefined(self.rewindmover))
		{
			if(isdefined(self.quest_num))
			{
				self.quest_num = int(self.quest_num);
				scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
				thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.05);
				thread scripts\cp\maps\cp_disco\cp_disco_interactions::play_fx_rewind(0.05);
				var_00 = level.clock[self.quest_num - 1].origin;
				var_01 = level.clock[self.quest_num - 1].angles;
				var_02 = getclosestpointonnavmesh(var_00);
				self setorigin(var_02,0);
				self setvelocity((0,0,0));
				self setstance("stand");
			}

			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 7
move_player_through_portal_tube(param_00)
{
	param_00 endon("disconnect");
	param_00 thread watch_for_rewind_quest();
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00.disable_consumables = 1;
	param_00.isfasttravelling = 1;
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = scripts\cp\maps\cp_disco\cp_disco::func_BC83(param_00,"fast_travel_tube_start","fast_travel_tube_end",1);
	self.var_4613 = self.var_4613 + 30;
	teleport_to_portal_safe_spot(param_00);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_01 delete();
	if(scripts\common\utility::istrue(param_00.travelled_thru_portal))
	{
		if(isdefined(level.clock_interaction_q2))
		{
			if(!scripts\common\utility::istrue(level.clock_interaction_q2.clock_active))
			{
				param_00.travelled_thru_portal = undefined;
			}
		}
	}
	else if(scripts\common\utility::istrue(param_00.travelled_thru_portal))
	{
		if(isdefined(level.clock_interaction_q3))
		{
			if(!scripts\common\utility::istrue(level.clock_interaction_q3.clock_active))
			{
				param_00.travelled_thru_portal = undefined;
			}
		}
	}

	if(scripts\common\utility::istrue(param_00.var_13DB4))
	{
		param_00 lib_0D12::func_6978(1);
		param_00.var_13DB4 = 0;
	}

	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00.isfasttravelling = undefined;
	param_00 notify("fast_travel_complete");
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 thread update_personal_ents_after_delay();
	if(param_00.var_134FD == "p5_")
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("fasttravel_exit","disco_comment_vo");
	}
}

//Function Number: 8
move_zombie_through_portal_tube(param_00)
{
	param_00.isfasttravelling = 1;
	var_01 = scripts\cp\maps\cp_disco\cp_disco::func_BC83(param_00,"fast_travel_tube_start","fast_travel_tube_end",1);
	teleport_to_portal_safe_spot(param_00);
	wait(0.1);
	var_01 delete();
	param_00.isfasttravelling = undefined;
}

//Function Number: 9
update_personal_ents_after_delay()
{
	self endon("disconnect");
	scripts\common\utility::func_136F7();
	scripts\cp\_interaction::func_DE6E();
	thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(self);
}

//Function Number: 10
unlinkplayerafterduration()
{
	while(scripts\common\utility::istrue(self.isrewinding) || isdefined(self.rewindmover))
	{
		wait(0.1);
	}

	self unlink();
}

//Function Number: 11
teleport_to_portal_safe_spot(param_00)
{
	var_01 = self.teleport_spots;
	var_02 = undefined;
	while(!isdefined(var_02))
	{
		foreach(var_04 in var_01)
		{
			if(!positionwouldtelefrag(var_04.origin))
			{
				var_02 = var_04;
			}
		}

		if(!isdefined(var_02))
		{
			if(!isdefined(var_01[0].angles))
			{
				var_01[0].angles = (0,0,0);
			}

			var_06 = scripts\cp\_utility::func_13192(anglestoforward(var_01[0].angles),64);
			var_02 = spawnstruct();
			var_02.origin = var_01[0].origin + var_06;
			var_02.angles = var_01[0].angles;
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
	param_00 setorigin(var_02.origin);
	param_00 setplayerangles(var_02.angles);
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00.portal_end_origin = var_02.origin;
}

//Function Number: 12
delay_portal_trigger_on_player(param_00,param_01)
{
	wait(param_01);
	param_00.recently_used_portal = undefined;
	wait(param_01 * 2);
	self.var_DDC4 = scripts\common\utility::func_22A9(self.var_DDC4,param_00);
}

//Function Number: 13
portal_cooldown_monitor()
{
	self.portal_scriptable setscriptablepartstate("portal","cooldown");
	while(!self.end_point.var_C626)
	{
		wait(0.1);
	}

	var_00 = 0.1;
	for(;;)
	{
		if(self.var_4613 > 0)
		{
			self.var_4613 = self.var_4613 - var_00;
			if(self.portal_scriptable method_8551("portal") != "cooldown")
			{
				self.portal_scriptable setscriptablepartstate("portal","cooldown");
			}
		}
		else
		{
			self.portal_scriptable setscriptablepartstate("portal",self.end_point_name);
		}

		if(self.var_4613 < 0)
		{
			self.var_4613 = 0;
		}

		wait(var_00);
	}
}