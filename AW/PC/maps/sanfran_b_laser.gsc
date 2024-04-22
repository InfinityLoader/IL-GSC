/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_laser.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 289 ms
 * Timestamp: 4/22/2024 2:35:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	precacheshader("dpad_laser_designator");
	precacheshader("laser_designator_overlay_lr");
	precacheshader("nightvision_overlay_goggles");
	common_scripts\utility::flag_init("player_firing_mob_turret");
	common_scripts\utility::flag_init("laser_firing");
}

//Function Number: 2
is_player_using_laser()
{
	return isdefined(level.player.laser_on) && level.player.laser_on;
}

//Function Number: 3
vision_set_override()
{
	wait(0.25);
	visionsetnaked("sanfran_b_arclight_explosion",1.25);
	wait(0.75);
	visionsetnaked("sanfran_b_arclight_explosion_dark",1);
	wait(0.5);
	visionsetnaked("sanfran_b_bridge",1);
}

//Function Number: 4
test_lines(param_00)
{
	var_01 = 0;
	while(var_01 < param_00)
	{
		wait(0.05);
		var_01 = var_01 + 0.05;
	}
}

//Function Number: 5
stop_fx_on_death(param_00)
{
	self waittill("death");
}

//Function Number: 6
draw_final_line(param_00)
{
	var_01 = 0;
	while(var_01 < param_00)
	{
		var_01 = var_01 + 0.05;
		wait(0.05);
	}
}

//Function Number: 7
manage_laser_beams(param_00,param_01)
{
	var_02 = 2048;
	var_03 = 5;
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = param_00.origin;
	var_04.angles = (0,0,0);
	var_04 linkto(param_00);
	var_05 = 360 / var_03;
	var_06 = 0;
	var_07 = [];
	while(var_06 < var_03)
	{
		var_08 = common_scripts\utility::spawn_tag_origin();
		var_08 linkto(var_04);
		var_09 = var_06 * var_05;
		var_04.angles = (0,var_09,0);
		var_08.origin = var_04.origin + vectornormalize(anglestoforward(var_04.angles)) * var_02;
		var_07[var_07.size] = var_08;
		var_06++;
	}

	foreach(var_0B in var_07)
	{
		var_0B thread move_child_beams(var_04,param_01);
	}

	wait(param_01);
	return var_04;
}

//Function Number: 8
move_child_beams(param_00,param_01)
{
	self endon("stop_drawing_child_beam_fx");
	var_02 = 0;
	while(var_02 < param_01)
	{
		var_03 = param_00.origin - self.origin;
		self.origin = self.origin + var_03 * var_02 / param_01;
		var_02 = var_02 + 0.05;
		wait(0.05);
	}
}

//Function Number: 9
aim_hud_on()
{
	if(!isdefined(level.aim_hud))
	{
		level.aim_hud = [];
	}

	level.aim_hud[0] = create_hud_static_overlay("laser_designator_overlay_lr",1,1);
	level.aim_hud[1] = create_hud_static_overlay("nightvision_overlay_goggles",0,0.2);
}

//Function Number: 10
destroy_aim_hud()
{
	if(!isdefined(level.aim_hud))
	{
		return;
	}

	foreach(var_01 in level.aim_hud)
	{
		if(isdefined(var_01))
		{
			var_01 destroy();
		}
	}

	level.aim_hud = undefined;
}

//Function Number: 11
create_hud_static_overlay(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	var_03.x = 0;
	var_03.y = 0;
	var_03.sort = param_01;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = param_02;
	var_03 setshader(param_00,640,480);
	return var_03;
}

//Function Number: 12
manage_aim_cursor()
{
	level.player endon("death");
	level.player endon("laser_off");
	var_00 = common_scripts\utility::spawn_tag_origin();
	level.player.laser_aim_pos = var_00;
	var_00 thread wait_to_kill_aim_cursor();
	for(;;)
	{
		var_01 = level.player geteye();
		var_02 = var_01 + anglestoforward(level.player getplayerangles()) * 50000;
		var_03 = bullettrace(var_01,var_02,1,level.player,1);
		if(isdefined(var_03["position"]))
		{
			var_04 = undefined;
			var_00.origin = var_03["position"];
			if(isdefined(var_03["normal"]))
			{
				var_04 = vectortoangles(var_03["normal"]);
			}
			else
			{
				var_04 = vectortoangles((0,0,1));
			}

			var_00 rotateto(var_04,0.2);
		}

		wait(0.05);
	}
}

//Function Number: 13
wait_to_kill_aim_cursor()
{
	level.player endon("death");
	level.player waittill("laser_off");
	level.player.laser_aim_pos = undefined;
	self delete();
}

//Function Number: 14
tag_progress_bar(param_00,param_01)
{
	level endon("missionfailed");
	self endon("drone_finished_exiting");
	self endon("tag_interrupted");
	var_02 = maps\_hud_util::createclientfontstring("default",1.2);
	var_02 maps\_hud_util::setpoint("CENTER",undefined,0,75);
	var_02 settext(param_01);
	var_03 = maps\_hud_util::createclientprogressbar(self,90,"white","black",100,5);
	var_02 thread tag_bar_end_early();
	var_03 thread tag_bar_end_early();
	var_03 update_reloading_progress_bar(param_00);
	if(isdefined(var_02))
	{
		var_02 destroyhudelem();
	}

	if(isdefined(var_03))
	{
		var_03 destroyhudelem();
	}
}

//Function Number: 15
update_reloading_progress_bar(param_00)
{
	var_01 = 20 * param_00;
	var_02 = 0;
	while(var_02 < var_01 && isdefined(self))
	{
		maps\_hud_util::updatebar(var_02 / var_01);
		var_02++;
		wait(0.05);
	}
}

//Function Number: 16
tag_bar_end_early()
{
	thread wait_for_mission_fail();
	thread wait_for_drone_finished();
	thread wait_for_interrupted();
	self waittill("destroy_early_bar");
	destroyhudelem();
}

//Function Number: 17
wait_for_mission_fail()
{
	level.player endon("laser_off");
	level.player endon("tag_interrupted");
	level waittill("missionfailed");
	self notify("destroy_early_bar");
}

//Function Number: 18
wait_for_drone_finished()
{
	level endon("missionfailed");
	level.player endon("tag_interrupted");
	level.player waittill("laser_off");
	self notify("destroy_early_bar");
}

//Function Number: 19
wait_for_interrupted()
{
	level endon("missionfailed");
	level.player endon("laser_off");
	level.player waittill("tag_interrupted");
	self notify("destroy_early_bar");
}

//Function Number: 20
destroyhudelem()
{
	var_00 = [];
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		var_00[var_01] = self.children[var_01];
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] maps\_hud_util::setparent(maps\_hud_util::getparent());
	}

	if(isdefined(self.elemtype) && self.elemtype == "bar")
	{
		self.bar destroy();
	}

	if(isdefined(self))
	{
		self destroy();
	}
}