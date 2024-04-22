/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_drag.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 218 ms
 * Timestamp: 4/22/2024 2:29:10 AM
*******************************************************************/

//Function Number: 1
get_starting_offset_from_org(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.origin = param_00.origin;
	var_02.angles = param_00.angles;
	var_03 = spawn_new_ally(param_00);
	var_02 maps\_anim::anim_first_frame_solo(var_03,"drag_putdown");
	var_04 = var_03.origin - var_02.origin;
	var_05 = var_03.angles - var_02.angles;
	var_06 = rotatevector(var_04,-1 * var_05);
	var_03 delete();
	return [var_06,var_05];
}

//Function Number: 2
drag_player_from_current_position(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = undefined;
	if(param_05)
	{
		var_06 = "drag_pickup02";
	}
	else
	{
		var_06 = param_02;
	}

	var_07 = get_starting_offset_from_org(param_00,var_06);
	var_08 = var_07[0];
	var_09 = var_07[1];
	var_0A = spawnstruct();
	var_0A.origin = param_00.origin - var_08;
	var_0A.angles = param_00.angles - var_09;
	return drag_player_internal(var_0A,param_00,param_01,param_02,undefined,param_03,param_04,param_05,"drag_pickup02");
}

//Function Number: 3
spawn_new_ally(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel(param_00.model);
	var_01.angles = param_00.angles;
	var_01.animname = "gideon";
	var_01 useanimtree(#animtree);
	return var_01;
}

//Function Number: 4
drag_player_from_start_to_end(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = spawnstruct();
	var_08.origin = param_00.origin;
	var_09 = param_01.origin - param_00.origin;
	var_09 = (var_09[0],var_09[1],var_09[2]);
	var_0A = vectortoangles(var_09);
	var_08.angles = (0,var_0A[1] + 90,0);
	return drag_player_internal(var_08,param_02,param_03,param_04,param_01.origin,param_05,param_06,param_07);
}

//Function Number: 5
drag_player_until_time_or_pos(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return drag_player_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 6
drag_player_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	while(isdefined(param_02.wait_ref_count) && param_02.wait_ref_count > 0)
	{
		wait 0.05;
	}

	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = "drag_run01";
	}

	if(!isdefined(param_08))
	{
		param_08 = "drag_pickup01";
	}

	param_00 maps\_anim::anim_first_frame_solo(param_01,"drag_putdown");
	var_09 = param_01.origin;
	if(!isdefined(param_02))
	{
		param_02 = maps\_utility::spawn_anim_model("world_body_damaged");
	}

	level.player playerlinktodelta(param_02,"TAG_PLAYER",1,0,0,0,0,1,1);
	level.player common_scripts\utility::delaycall(1,::playerlinktodelta,param_02,"TAG_PLAYER",1,30,30,30,10,1,1);
	level.player maps\_shg_utility::setup_player_for_scene();
	var_0A = [param_01,param_02];
	if(param_07)
	{
		param_00 maps\_anim::anim_single(var_0A,param_08);
	}

	if(param_03 == "none")
	{
		return finish_drag_player_internal(param_00,var_09,param_01,param_02,var_0A,param_06);
	}

	param_00 thread maps\_anim::anim_single(var_0A,param_03);
	waituntil_stop_time_or_posreached(param_04,param_00,param_01,param_03);
	if(isdefined(param_05) && param_05 != 0)
	{
		if(!isdefined(param_02.wait_ref_count))
		{
			param_02.wait_ref_count = 0;
		}

		param_02.wait_ref_count++;
		thread finish_drag_player_internal_delayed(param_05,param_00,var_09,param_01,param_02,var_0A,param_06);
		return param_02;
	}

	finish_drag_player_internal(param_00,var_09,param_01,param_02,var_0A,param_06);
	return param_02;
}

//Function Number: 7
finish_drag_player_internal_delayed(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_04 endon("death");
	wait(param_00);
	finish_drag_player_internal(param_01,param_02,param_03,param_04,param_05,param_06);
	param_04.wait_ref_count--;
}

//Function Number: 8
finish_drag_player_internal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_05)
	{
		var_06 = param_01 - param_02.origin;
		var_07 = param_00.origin - var_06;
		var_08 = spawn("script_origin",var_07);
		var_08.angles = param_00.angles;
		param_00 = var_08;
		param_00 maps\_anim::anim_first_frame(param_04,"drag_putdown");
		param_00 maps\_anim::anim_single(param_04,"drag_putdown");
		var_08 delete();
	}
	else
	{
		foreach(var_0A in param_04)
		{
			if(isdefined(var_0A))
			{
				var_0A maps\_utility::anim_stopanimscripted();
			}
		}
	}

	if(isdefined(param_03))
	{
		level.player playerlinktodelta(param_03,"TAG_PLAYER",1,30,30,30,5,1,0);
	}

	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableoffhandweapons();
	return param_03;
}

//Function Number: 9
waituntil_stop_time_or_posreached(param_00,param_01,param_02,param_03)
{
	param_02 endon("death");
	if(!isdefined(param_00))
	{
		if(isdefined(param_01.target))
		{
			var_04 = maps\_utility::getent_or_struct(param_01.target,"targetname");
			waittill_marker_passed(var_04.origin,param_01,param_02,param_03);
			return;
		}

		param_00 = getanimlength(param_02 maps\_utility::getanim(param_03));
		wait(param_00);
		return;
	}

	if(isnumber(param_00))
	{
		wait(param_00);
		return;
	}

	waittill_marker_passed(param_00,param_01,param_02,param_03);
}

//Function Number: 10
waittill_marker_passed(param_00,param_01,param_02,param_03)
{
	param_02 endon("death");
	wait 0.05;
	var_04 = param_00 - param_01.origin;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = vectornormalize(var_04);
	var_06 = length2dsquared(var_04);
	var_07 = 0;
	var_08 = param_02.origin;
	for(;;)
	{
		var_09 = param_02.origin - param_01.origin;
		var_0A = vectordot(var_09,var_05);
		if(squared(var_0A) > var_06)
		{
			break;
		}

		if(param_02.origin == var_08)
		{
			var_07++;
			if(var_07 > 100)
			{
				break;
			}
		}

		var_08 = param_02.origin;
		wait 0.05;
	}
}

//Function Number: 11
notetrack_drag_cover_pickup(param_00)
{
	param_00.pickup_allowed = 1;
}

//Function Number: 12
notetrack_drag_cover_dont_pickup(param_00)
{
	param_00.pickup_allowed = 0;
}

//Function Number: 13
shooting_head_sway()
{
	level.player endon("death");
	level.player endon("end_head_sway");
	for(;;)
	{
		screenshake(level.player.origin,2,3,1,2,0.2,0.2,0,0.3,0.375,0.225);
		wait(1);
	}
}