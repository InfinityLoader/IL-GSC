/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_ca_beautiful_corner.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 298 ms
 * Timestamp: 10/27/2023 2:45:25 AM
*******************************************************************/

//Function Number: 1
initialize()
{
	if(getdvar("beautiful_corner") != "1")
	{
		cleanup();
		return 0;
	}

	level.beautiful_views = [];
	level.beautiful_visions = [];
	level.beautiful_lightsets = [];
	level.beautiful_cluts = [];
	level.beautiful_dof = [];
	level.beautiful_view_static = 1;
	level.beautiful_view_index = 0;
	level.beautiful_weapon = undefined;
	return 1;
}

//Function Number: 2
activate()
{
	thread beautiful_player();
	thread beautiful_guys();
	thread beautiful_views();
}

//Function Number: 3
cleanup()
{
	var_00 = getentarray("beautiful_guy","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 4
beautiful_player()
{
	level.player takeallweapons();
	level.player disableoffhandweapons();
	if(isdefined(level.beautiful_weapon))
	{
		level.player giveweapon(level.beautiful_weapon);
		level.player switchtoweapon(level.beautiful_weapon);
	}

	level.player thread beautiful_player_ammo();
	level.friendlyfiredisabled = 1;
	level.player enableinvulnerability();
}

//Function Number: 5
beautiful_player_ammo()
{
	var_00 = self getweaponslistall();
	self.maintain_stock = [];
	foreach(var_02 in var_00)
	{
		if(!isdefined(self.maintain_stock[var_02]))
		{
			self.maintain_stock[var_02] = self getweaponammostock(var_02);
		}
	}

	for(;;)
	{
		foreach(var_02 in var_00)
		{
			self setweaponammostock(var_02,self.maintain_stock[var_02]);
		}

		wait(1);
	}
}

//Function Number: 6
beautiful_guys()
{
	var_00 = getentarray("beautiful_guy","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_shg_design_tools::actual_spawn();
		if(!isdefined(var_03))
		{
			return;
		}

		var_03 maps\_utility::make_hero();
		var_03 maps\_utility::ai_ignore_everything();
		var_03 maps\_utility::magic_bullet_shield();
		var_03.script_friendname = "none";
		if(isdefined(level.beautiful_weapon))
		{
			var_03 maps\_utility::forceuseweapon(level.beautiful_weapon,"primary");
		}

		if(isdefined(var_02.script_noteworthy))
		{
			var_03.animname = "beautiful_guy";
			var_03 thread maps\_anim::anim_loop_solo(var_03,var_02.script_noteworthy,undefined,"stop_idle");
		}
	}
}

//Function Number: 7
beautiful_views()
{
	beautiful_view_origin_offsets();
	beautiful_view_init();
	thread beautiful_view_move_request();
	thread beautiful_view_state_request();
}

//Function Number: 8
beautiful_view_origin_offsets()
{
	var_00 = [0,0,-60];
	foreach(var_02 in level.beautiful_views)
	{
		var_03 = getent(var_02,"targetname");
		beautiful_offset_view_origin(var_03,var_00);
		var_04 = getent(var_02 + "_static","targetname");
		beautiful_offset_view_origin(var_04,var_00);
	}
}

//Function Number: 9
beautiful_offset_view_origin(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.script_noteworthy))
	{
		return;
	}

	if(param_00.script_noteworthy != "view_pos")
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.entity = param_00;
	var_02.forward = param_01[0];
	var_02.right = param_01[1];
	var_02.up = param_01[2];
	var_02 maps\_utility::translate_local();
}

//Function Number: 10
beautiful_view_init()
{
	if(level.beautiful_views.size <= 0)
	{
		return;
	}

	common_scripts\utility::flag_init("beautiful_view_transitioning");
	common_scripts\utility::flag_clear("beautiful_view_transitioning");
	level.black_overlay = maps\_hud_util::create_client_overlay("black",1);
	level.black_overlay.sort = 1000;
	level.player takeweapon("beretta");
	level.player takeweapon("fraggrenade");
	level.player takeweapon("flash_grenade");
	beautiful_view_position(level.beautiful_views[level.beautiful_view_index]);
	wait(0.05);
	setsaveddvar("compass","0");
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showStance","0");
	setsaveddvar("actionSlotsHide","1");
	wait(0.5);
	level.player disableweapons();
	level.player freezecontrols(1);
	wait(1);
	beautiful_view_fade_in();
}

//Function Number: 11
beautiful_view_move_request()
{
	for(;;)
	{
		while(!level.player buttonpressed("DPAD_UP") || level.player buttonpressed("HOME"))
		{
			wait(0.05);
		}

		if(!common_scripts\utility::flag("beautiful_view_transitioning"))
		{
			beautiful_view_get_next_position();
			beautiful_view_update(level.beautiful_views[level.beautiful_view_index]);
		}

		wait(0.05);
	}
}

//Function Number: 12
beautiful_view_get_next_position()
{
	for(var_00 = undefined;!isdefined(var_00);var_00 = getent(var_01,"targetname"))
	{
		level.beautiful_view_index++;
		if(level.beautiful_view_index >= level.beautiful_views.size)
		{
			level.beautiful_view_index = 0;
		}

		var_01 = level.beautiful_views[level.beautiful_view_index];
		if(level.beautiful_view_static)
		{
			var_01 = var_01 + "_static";
		}
	}
}

//Function Number: 13
beautiful_view_state_request()
{
	for(;;)
	{
		while(!level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("END"))
		{
			wait(0.05);
		}

		if(!common_scripts\utility::flag("beautiful_view_transitioning"))
		{
			level.beautiful_view_static = !level.beautiful_view_static;
			beautiful_view_update(level.beautiful_views[level.beautiful_view_index]);
		}

		wait(0.05);
	}
}

//Function Number: 14
beautiful_view_update(param_00)
{
	common_scripts\utility::flag_set("beautiful_view_transitioning");
	beautiful_view_fade_out();
	beautiful_view_position(param_00);
	wait(0.25);
	beautiful_view_fade_in();
	wait(0.25);
	common_scripts\utility::flag_clear("beautiful_view_transitioning");
}

//Function Number: 15
beautiful_view_fade_in()
{
	wait(0.1);
	level.black_overlay fadeovertime(0.3);
	level.black_overlay.alpha = 0;
	if(!level.beautiful_view_static)
	{
		level.player enableweapons();
	}

	wait(0.3);
	if(!level.beautiful_view_static)
	{
		level.player freezecontrols(0);
	}

	level.player hidehud();
}

//Function Number: 16
beautiful_view_fade_out()
{
	level.player showhud();
	level.player setstance("stand");
	level.black_overlay fadeovertime(0.3);
	level.black_overlay.alpha = 1;
	level.player disableweapons();
	wait(0.3);
	level.player freezecontrols(1);
	wait(0.1);
}

//Function Number: 17
beautiful_view_position(param_00)
{
	if(level.beautiful_visions[param_00] != "")
	{
		maps\_utility::vision_set_fog_changes(level.beautiful_visions[param_00],0);
	}

	if(level.beautiful_lightsets[param_00] != "")
	{
		level.player lightsetforplayer(level.beautiful_lightsets[param_00]);
	}

	if(level.beautiful_cluts[param_00] != "")
	{
		level.player method_848C(level.beautiful_cluts[param_00],0);
	}

	if(level.beautiful_view_static && isdefined(level.beautiful_dof[param_00]))
	{
		var_01 = level.beautiful_dof[param_00];
		level.player method_84A5();
		level.player method_84A7(var_01["fstop"],var_01["focus_distance"],var_01["focus_speed"],var_01["aperture_speed"]);
	}
	else
	{
		level.player method_84A6();
	}

	level.player setstance("stand");
	if(level.beautiful_view_static)
	{
		beautiful_view_position_static(param_00 + "_static");
		return;
	}

	beautiful_view_position_dynamic(param_00);
}

//Function Number: 18
beautiful_view_position_dynamic(param_00)
{
	level.player unlink();
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	level.player setorigin(var_01.origin);
	level.player setplayerangles(var_01.angles);
}

//Function Number: 19
beautiful_view_position_static(param_00)
{
	level.player unlink();
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	if(!isdefined(level.beautiful_view_ent))
	{
		level.beautiful_view_ent = common_scripts\utility::spawn_tag_origin();
	}

	level.beautiful_view_ent.origin = var_01.origin;
	level.beautiful_view_ent.angles = var_01.angles;
	level.player setorigin(level.beautiful_view_ent.origin);
	level.player setplayerangles(level.beautiful_view_ent.angles);
	level.player playerlinktoabsolute(level.beautiful_view_ent,"tag_origin");
}