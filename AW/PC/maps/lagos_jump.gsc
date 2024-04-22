/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_jump.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 271 ms
 * Timestamp: 4/22/2024 2:33:49 AM
*******************************************************************/

//Function Number: 1
main()
{
}

//Function Number: 2
exo_jump_process()
{
	level.player endon("exo_jump_process_end");
	common_scripts\utility::flag_wait("flag_setup_highway_vehicles");
	wait 0.05;
	level.player notifyonplayercommand("exo_jump_button","+gostand");
	thread exo_jump_button_listener();
	level.player.exo_jump_button_pressed = 0;
	level.jumping_rig = maps\_utility::spawn_anim_model("player_arms",(0,0,0));
	level.handplant_target = spawn("script_origin",(0,0,0));
	level.script_origin_target_array = getentarray("jump_target","targetname");
	var_00 = 999999999;
	for(var_01 = 0;var_01 < level.script_origin_target_array.size;var_01++)
	{
		var_02 = distancesquared(level.script_origin_target_array[var_01].origin,level.player.origin);
		if(var_00 > var_02)
		{
			var_00 = var_02;
			level.jump_target = level.script_origin_target_array[var_01];
		}
	}

	level.player.jump_state = 1;
	for(;;)
	{
		waittillframeend;
		switch(level.player.jump_state)
		{
			case 1:
				if(level.player.exo_jump_button_pressed)
				{
					player_assisted_jump(level.script_origin_target_array);
				}
				break;
	
			case 2:
				break;
	
			case 3:
				if(level.player buttonpressed("DPAD_UP"))
				{
					player_unlock();
					level.player.jump_state = 1;
				}
				else if(level.player isonground() && level.player.exo_jump_button_pressed)
				{
					player_assisted_jump(level.script_origin_target_array);
				}
				break;
		}

		wait 0.05;
	}
}

//Function Number: 3
exo_jump_button_listener()
{
	level.player endon("exo_jump_process_end");
	for(;;)
	{
		level.player waittill("exo_jump_button");
		var_00 = getgroundposition(level.player.origin,16);
		var_01 = abs(var_00[2] - level.player.origin[2]);
		if(var_01 < 20)
		{
			level.player.exo_jump_button_pressed = 1;
		}

		wait 0.05;
		level.player.exo_jump_button_pressed = 0;
	}
}

//Function Number: 4
exo_jump_end()
{
	level.player notify("exo_jump_process_end");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player maps\_utility::restore_players_weapons("traffic_weapons");
	level.player.jump_state = 1;
	if(isdefined(level.jumping_rig))
	{
		level.player unlink();
	}

	if(isdefined(level.jumping_rig))
	{
		level.jumping_rig delete();
	}

	if(isdefined(level.handplant_target))
	{
		level.handplant_target delete();
	}

	level.player notifyonplayercommandremove("exo_jump_button","+gostand");
	level.player.exo_jump_button_pressed = undefined;
}

//Function Number: 5
player_exo_jump_hint(param_00)
{
	for(;;)
	{
		var_01 = get_best_jump_target(param_00);
		if(isdefined(var_01))
		{
			maps\_utility::display_hint_timeout("player_exo_jump",20);
			break;
		}

		wait(0.1);
	}
}

//Function Number: 6
player_assisted_jump(param_00)
{
	var_01 = get_best_jump_target(param_00);
	if(isdefined(var_01))
	{
		level.jump_target = var_01;
		var_02 = (0,0,0);
		if(isdefined(level.burke_bus_goal))
		{
			var_03 = 40;
			if(distance2dsquared(level.burke_bus_goal.origin,var_01.origin) < var_03 * var_03)
			{
				var_04 = vectornormalize(var_01.origin - level.burke_bus_goal.origin);
				var_02 = level.burke_bus_goal.origin + var_03 * var_04 - var_01.origin;
			}
		}

		var_05 = var_01.origin + var_02;
		var_06 = var_05 - level.player.origin;
		var_07 = distance2d(var_05,level.player.origin);
		level.player.jump_state = 2;
		level.player maps\_shg_utility::setup_player_for_scene();
		level.player maps\_utility::store_players_weapons("traffic_weapons");
		level.player takeallweapons();
		thread animate_script_origin(var_01,var_02,var_06,var_07,1);
		player_unlock();
	}
}

//Function Number: 7
player_handplant()
{
	level.jumping_rig waittill("notetrack_vm_exo_magnet_start");
	maps\_anim::anim_set_rate_single(level.jumping_rig,level.jump_animstring,0);
	level.player.jump_state = 3;
	maps\_utility::display_hint_timeout("player_exo_jump_release",5);
}

//Function Number: 8
player_handplant_standalone()
{
	var_00 = level.handplant_target;
	level.jump_target = var_00;
	level.jumping_rig showallparts();
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player maps\_utility::store_players_weapons("traffic_weapons");
	level.player takeallweapons();
	match_angles_pos(level.jumping_rig,level.player);
	match_angles_pos(var_00,level.jumping_rig);
	level.jumping_rig linkto(var_00);
	level.player playerlinktoblend(level.jumping_rig,"tag_player",1,0.1,0.1);
	level.jump_animstring = "bus_jump_vm_handplant";
	level.jumping_rig thread maps\_anim::anim_single_solo(level.jumping_rig,level.jump_animstring);
	thread player_handplant();
}

//Function Number: 9
player_link_to(param_00,param_01)
{
	level.player endon("exo_jump_process_end");
	level.player endon("exo_jump_stop_view_clamp");
	level.player endon("death");
	var_02 = 1;
	switch(param_00)
	{
		case "bus_jump_vm_a":
			var_02 = 0.75 / param_01;
			break;

		case "bus_jump_vm_b":
			var_02 = 0.9 / param_01;
			break;

		case "bus_jump_vm_c":
			var_02 = 1.1 / param_01;
			break;

		default:
			break;
	}

	level.player playerlinktoblend(level.jumping_rig,"tag_player",var_02);
	level.jumping_rig hide();
	wait(var_02);
	level.jumping_rig show();
	level waittill("bus_jump_player_landed");
	wait(1);
	level.player playerlinktodelta(level.jumping_rig,"tag_player");
	level.player lerpviewangleclamp(1,0.2,0.2,70,35,70,10);
}

//Function Number: 10
player_unlock()
{
	maps\_anim::anim_set_rate_single(level.jumping_rig,level.jump_animstring,1);
	level.jumping_rig waittill("notetrack_vm_exo_magnet_end");
	level.player unlink();
	level.player playerlinktodelta(level.jump_target,"");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player maps\_utility::restore_players_weapons("traffic_weapons");
	wait(0.5);
	level.player unlink();
	level.player.jump_state = 1;
}

//Function Number: 11
get_stick_dir_in_world_coor()
{
	var_00 = level.player getnormalizedmovement();
	var_00 = (var_00[0],var_00[1] * -1,0);
	var_01 = rotatevector(var_00,level.player.angles);
	var_01 = vectornormalize(var_01);
	return var_01;
}

//Function Number: 12
get_best_jump_target(param_00)
{
	if(!isdefined(level.const_cosine_stick_angle))
	{
		level.const_cosine_stick_angle = cos(30);
	}

	if(!isdefined(level.const_cosine_bunched_angle))
	{
		level.const_cosine_bunched_angle = cos(2);
	}

	var_01 = level.player getnormalizedmovement();
	var_02 = vectortoyaw(var_01);
	var_03 = 45;
	if(common_scripts\utility::flag("flag_bus_traverse_4"))
	{
		var_03 = 60;
	}

	if(var_03 < var_02 && var_02 < 360 - var_03)
	{
		return undefined;
	}

	var_04 = get_stick_dir_in_world_coor();
	if(distance2d(var_04,(0,0,0)) < 0.1)
	{
		return undefined;
	}

	var_05 = 0;
	var_06 = -1;
	var_07 = 99999;
	for(var_08 = 0;var_08 < param_00.size;var_08++)
	{
		var_09 = param_00[var_08] getlinkedparent();
		var_0A = level.jump_target getlinkedparent();
		if(isdefined(var_09) && isdefined(var_0A) && var_09 == var_0A)
		{
			continue;
		}

		if(level.player.origin[2] - param_00[var_08].origin[2] < -120)
		{
			continue;
		}

		var_0B = distance2dsquared(param_00[var_08].origin,level.player.origin);
		if(var_0B > 360000 || var_0B < 100)
		{
			continue;
		}

		var_0C = sqrt(var_0B);
		var_0D = param_00[var_08].origin - level.player.origin;
		var_0E = var_0D * 1 / var_0C;
		var_0F = vectordot(var_04,var_0E);
		if(var_06 != -1 && abs(var_05 - var_0F) < abs(var_05 - level.const_cosine_bunched_angle) && abs(var_0C - var_07) < 50)
		{
			if((var_01[0] < 0.5 && var_0C < var_07) || var_01[0] > 0.5 && var_0C > var_07)
			{
				var_05 = var_0F;
				var_06 = var_08;
				var_07 = var_0C;
			}
			else
			{
			}

			continue;
		}

		if(var_0F > var_05)
		{
			var_05 = var_0F;
			var_06 = var_08;
			var_07 = var_0C;
		}
	}

	if(var_05 < level.const_cosine_stick_angle || var_06 == -1)
	{
		return undefined;
	}

	return param_00[var_06];
}

//Function Number: 13
orient_facing(param_00,param_01)
{
	var_02 = param_01.origin - param_00.origin;
	var_03 = vectortoangles(var_02);
	param_00.angles = var_03;
}

//Function Number: 14
match_angles_pos(param_00,param_01)
{
	param_00.angles = param_01.angles;
	param_00.origin = param_01.origin;
}

//Function Number: 15
animate_script_origin(param_00,param_01,param_02,param_03,param_04)
{
	level.player endon("exo_jump_process_end");
	level.jumping_rig.origin = param_00.origin;
	var_05 = vectortoangles(param_02);
	param_00 linkto(param_00.linkparent_ent,param_00.linkparent_tag,param_01,var_05 - param_00.linkparent_ent.angles);
	level.jumping_rig linkto(param_00);
	level.jump_animstring = "";
	if(param_03 < 118.5)
	{
		level.jump_animstring = "bus_jump_vm_a";
	}
	else if(param_03 < 240.93)
	{
		level.jump_animstring = "bus_jump_vm_b";
	}
	else
	{
		level.jump_animstring = "bus_jump_vm_c";
	}

	var_06 = level.player getmovingplatformparent();
	if(isdefined(var_06) && isdefined(var_06.targetname) && var_06.targetname == "sb_bus_traverse_4")
	{
		common_scripts\utility::flag_set("flag_bus_traverse_5_start_takedown");
	}

	var_07 = 1.2;
	if(param_04)
	{
		thread player_link_to(level.jump_animstring,var_07);
	}

	param_00 maps\_utility::delaythread(0.05,::maps\_anim::anim_set_rate_single,level.jumping_rig,level.jump_animstring,var_07);
	param_00 maps\_anim::anim_single_solo(level.jumping_rig,level.jump_animstring);
	if(isdefined(level.jumping_rig))
	{
		level.jumping_rig hide();
	}
}

//Function Number: 16
notetrack_vm_exo_magnet_start(param_00)
{
}

//Function Number: 17
notetrack_vm_exo_magnet_end(param_00)
{
	if(isdefined(level.jumping_rig))
	{
		level.jumping_rig notify("notetrack_vm_exo_magnet_end");
	}
}

//Function Number: 18
spawn_vehicle_from_targetname_and_setup_jump_targets(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname(param_00);
	var_06 = "";
	var_05.script_origin_roof = [];
	if(!isdefined(param_01))
	{
		param_01 = 4;
	}

	var_07 = 0;
	for(var_08 = 0;var_08 < param_01;var_08++)
	{
		if(var_08 == 0)
		{
			var_06 = "tag_roof_a";
		}
		else if(var_08 == 1)
		{
			var_06 = "tag_roof_b";
		}
		else if(var_08 == 2)
		{
			var_06 = "tag_roof_c";
		}
		else if(var_08 == 3)
		{
			var_06 = "tag_roof_d";
		}

		if(isdefined(param_02) && param_02 == var_06)
		{
			continue;
		}
		else if(isdefined(param_03) && param_03 == var_06)
		{
			continue;
		}
		else if(isdefined(param_04) && param_04 == var_06)
		{
			continue;
		}

		if(isdefined(var_05 gettagorigin(var_06)))
		{
			var_05.script_origin_roof[var_07] = spawn("script_origin",(0,0,0));
			var_05.script_origin_roof[var_07].origin = var_05 gettagorigin(var_06);
			var_05.script_origin_roof[var_07].targetname = "jump_target";
			var_05.script_origin_roof[var_07] linkto(var_05,var_06);
			var_05.script_origin_roof[var_07].linkparent_tag = var_06;
			var_05.script_origin_roof[var_07].linkparent_ent = var_05;
			var_07++;
		}
	}

	var_05 thread test();
	return var_05;
}

//Function Number: 19
test()
{
	wait 0.05;
}