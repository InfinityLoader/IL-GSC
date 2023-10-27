/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_helicopter_ai.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 183 ms
 * Timestamp: 10/27/2023 2:47:54 AM
*******************************************************************/

//Function Number: 1
evasive_think(param_00)
{
	param_00 endon("death");
	while(param_00.health > 0)
	{
		param_00 waittill("missile_lock",var_01);
		var_02 = evasive_createmaneuvers(param_00,"random");
		evasive_startmaneuvers(param_00,var_02);
		wait(0.05);
	}
}

//Function Number: 2
evasive_createmaneuvers(param_00,param_01)
{
	switch(param_01)
	{
		case "strafe_left_right":
			break;

		case "strafe_right_left":
			break;

		case "360_clockwise":
			break;

		case "360_counter_clockwise":
			break;

		case "random":
			break;
	}
}

//Function Number: 3
evasive_startmaneuvers(param_00,param_01)
{
	param_00 notify("taking_evasive_actions");
	param_00 endon("taking_evasive_actions");
	param_00 endon("death");
	param_00 notify("evasive_action_done");
	thread evasive_endmaneuvers(param_00);
	if(getdvar("cobrapilot_debug") == "1")
	{
		param_00 evasive_drawpoints(param_01);
	}

	param_00 neargoalnotifydist(1500);
	param_00 vehicle_setspeed(100,30,30);
	var_02 = param_00.angles[1];
	for(var_03 = 1;var_03 < param_01.size;var_03++)
	{
		if(isdefined(param_01[var_03 + 1]))
		{
			var_04 = vectortoangles(param_01[var_03 + 1]["pos"] - param_01[var_03]["pos"]);
		}
		else
		{
			var_04 = (0,var_02,0);
		}

		var_05 = var_04[1];
		if(param_01[var_03]["goalYawMethod"] == "average")
		{
			var_05 = var_04[1] + var_02 / 2;
		}
		else if(param_01[var_03]["goalYawMethod"] == "forward")
		{
			var_05 = param_00.angles[1];
		}

		if(getdvar("cobrapilot_debug") == "1")
		{
			thread maps\_utility::draw_line_until_notify(param_01[var_03]["pos"],param_01[var_03]["pos"] + anglestoforward((0,var_05,0)) * 250,1,1,0.2,param_00,"evasive_action_done");
		}

		param_00 settargetyaw(var_05);
		param_00 thread maps\_vehicle_code::setvehgoalpos_wrap(param_01[var_03]["pos"],0);
		param_00 waittill("near_goal");
	}

	param_00 notify("evasive_action_done");
	param_00 thread maps\_utility::vehicle_resumepath();
}

//Function Number: 4
evasive_endmaneuvers(param_00)
{
	param_00 notify("end_maneuvers");
	param_00 endon("end_maneuvers");
	param_00 endon("evasive_action_done");
	param_00 endon("death");
	param_00 waittill("missile_lock_ended");
	param_00 thread maps\_utility::vehicle_resumepath();
}

//Function Number: 5
evasive_addpoint(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.evasive_points))
	{
		self.evasive_points = [];
		self.evasive_points[0]["pos"] = self.origin;
		self.evasive_points[0]["ang"] = (0,self.angles[1],0);
	}

	var_04 = self.evasive_points.size;
	if(!isdefined(param_03))
	{
		param_03 = "none";
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.evasive_points[var_04]["forward"] = param_00;
	self.evasive_points[var_04]["side"] = param_01;
	self.evasive_points[var_04]["up"] = param_02;
	var_05 = anglestoforward(self.evasive_points[0]["ang"]);
	var_06 = anglestoright(self.evasive_points[0]["ang"]);
	self.evasive_points[var_04]["pos"] = self.evasive_points[var_04 - 1]["pos"] + var_05 * self.evasive_points[var_04]["forward"] + var_06 * self.evasive_points[var_04]["side"] + (0,0,param_02);
	self.evasive_points[var_04]["goalYawMethod"] = param_03;
}

//Function Number: 6
evasive_getallpoints(param_00)
{
	var_01 = param_00.evasive_points;
	param_00.evasive_points = undefined;
	return var_01;
}

//Function Number: 7
evasive_drawpoints(param_00)
{
	for(var_01 = 1;var_01 < param_00.size;var_01++)
	{
		thread maps\_utility::draw_line_until_notify(param_00[var_01 - 1]["pos"],param_00[var_01]["pos"],1,0.2,0.2,self,"evasive_action_done");
	}
}

//Function Number: 8
wingman_think(param_00)
{
	param_00 endon("death");
	level.playervehicle endon("death");
	var_01 = 2200;
	var_02 = 1500;
	var_03 = 0;
	var_04 = 1;
	var_05 = 1.2;
	var_06 = 50;
	var_07 = 60;
	var_08 = 2000;
	var_09 = getplayerhelispeed();
	var_0A = 0;
	var_0B = gettime();
	var_0C = wingman_getgoalpos(var_01,var_02,var_03);
	param_00 vehicle_setspeed(30,20,20);
	param_00 settargetyaw(level.playervehicle.angles[1]);
	param_00 setgoalpos(var_0C,1);
	for(;;)
	{
		var_0C = wingman_getgoalpos(var_01,var_02,var_03);
		if(getdvar("cobrapilot_debug") == "1")
		{
			thread common_scripts\utility::draw_line_for_time(level.playervehicle.origin,var_0C,0,1,0,var_04);
			thread common_scripts\utility::draw_line_for_time(level.playervehicle.origin,param_00.origin,0,0,1,var_04);
			thread common_scripts\utility::draw_line_for_time(param_00.origin,var_0C,1,1,0,var_04);
		}

		var_0D = gettime();
		if(var_0D >= var_0B + var_08)
		{
			var_0B = var_0D;
			var_0A = var_09;
			var_09 = getplayerhelispeed();
		}

		var_0E = 0;
		var_0F = 0;
		if(var_0A > 20)
		{
			var_0F = var_0A;
			var_0E = 1;
		}
		else if(var_0A <= 20 && getplayerhelispeed() > 20)
		{
			var_0F = getplayerhelispeed();
			var_0E = 1;
		}

		if(var_0E && var_0F > 0)
		{
			var_0F = var_0F * var_05;
			var_10 = var_06;
			var_11 = var_07;
			if(var_10 >= var_0F / 2)
			{
				var_10 = var_0F / 2;
			}

			if(var_11 >= var_0F / 2)
			{
				var_11 = var_0F / 2;
			}

			param_00 vehicle_setspeed(var_0F,var_10,var_11);
			param_00 settargetyaw(level.playervehicle.angles[1]);
			var_12 = 0;
			if(getplayerhelispeed() <= 30)
			{
				var_12 = 1;
			}

			if(getdvar("cobrapilot_debug") == "1")
			{
				iprintln("wingman speed: " + var_0F + " : " + var_12);
			}

			param_00 setgoalpos(var_0C,var_12);
		}

		wait(var_04);
	}
}

//Function Number: 9
wingman_getgoalpos(param_00,param_01,param_02)
{
	var_03 = anglestoforward(common_scripts\utility::flat_angle(level.playervehicle.angles));
	var_04 = anglestoright(common_scripts\utility::flat_angle(level.playervehicle.angles));
	var_05 = level.playervehicle.origin + var_03 * param_00 + var_04 * param_01 + (0,0,param_02);
	return var_05;
}

//Function Number: 10
getplayerhelispeed()
{
	return level.playervehicle vehicle_getspeed();
}