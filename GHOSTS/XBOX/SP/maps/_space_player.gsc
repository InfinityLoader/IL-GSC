/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_space_player.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 39
 * Decompile Time: 636 ms
 * Timestamp: 10/27/2023 1:37:29 AM
*******************************************************************/

//Function Number: 1
init_player_space()
{
	precacheshellshock("underwater_swim");
	precachemodel("viewhands_us_space");
	precachemodel("viewhands_player_us_space");
	precacherumble("light_1s");
	common_scripts\utility::func_3385("spacesprint");
	common_scripts\utility::func_3385("boostAnim");
	common_scripts\utility::func_3385("wall_push_flag_left");
	common_scripts\utility::func_3385("floor_push");
	common_scripts\utility::func_3385("no_push_zone");
	common_scripts\utility::func_3385("stop_wall_pushing");
	common_scripts\utility::func_3385("wall_push_tweak_player");
	common_scripts\utility::func_3385("set_player_interior_speed");
	common_scripts\utility::func_3385("set_player_exterior_speed");
	common_scripts\utility::func_3385("clear_to_tweak_player");
	common_scripts\utility::func_3385("enable_player_thruster_audio");
	common_scripts\utility::func_3385("prologue_ready_for_thrusters");
	level.sfx_player_breathing_started = 0;
}

//Function Number: 2
func_4591()
{
	func_5F14();
}

//Function Number: 3
func_73FC()
{
}

//Function Number: 4
enable_player_space()
{
	function_0168("cg_footsteps",0);
	function_0168("cg_equipmentSounds",0);
	function_0168("cg_landingSounds",0);
	thread func_73FC();
	level.var_8D38 = (0,0,0);
	level.var_2A92 = (0,0,0);
	thread moving_water();
	thread impulse_push();
	self.var_5EA4 = common_scripts\utility::func_7836();
	thread maps\_space::func_5F13();
	thread func_7746();
	function_0168("player_spaceEnabled","1");
	thread func_648D();
	self method_8276(1);
	level.var_773A = 15;
	level.var_7742 = 80;
	level.space_accel = 75;
	level.var_7748 = 65;
	level.var_7747 = 85;
	function_0168("player_swimFriction",level.var_773A);
	function_0168("player_swimAcceleration",level.space_accel);
	function_0168("player_swimVerticalFriction",45);
	function_0168("player_swimVerticalSpeed",65);
	function_0168("player_swimVerticalAcceleration",85);
	function_0168("player_swimSpeed",level.var_7742);
	thread direction_change_smoothing();
	thread func_7743();
	function_0168("player_sprintUnlimited","1");
	wait(1);
	if(isdefined(level.player.var_3FE7) && level.player.var_3FE7 == 1)
	{
		var_00 = maps\_utility::func_777F("player_rig");
		var_00 method_82C8();
		var_00.origin = level.player.origin;
		var_00.angles = level.player.angles;
		var_00 method_8021(level.player,"tag_origin",(0,0,0),(0,0,0),1);
		var_00 hide();
		thread func_8BFB(var_00);
		thread func_78FF();
		thread contuing_to_move_check();
	}
}

//Function Number: 5
func_2778()
{
	level notify("disable_space");
	self notify("disable_space");
	function_0168("cg_footsteps",1);
	function_0168("cg_equipmentSounds",1);
	function_0168("cg_landingSounds",1);
	function_0168("player_swimFriction",30);
	function_0168("player_swimAcceleration",100);
	function_0168("player_swimVerticalFriction",40);
	function_0168("player_swimVerticalSpeed",120);
	function_0168("player_swimVerticalAcceleration",160);
	function_0168("player_swimSpeed",80);
	function_0168("player_sprintUnlimited","1");
	function_0168("player_swimWaterCurrent",(0,0,0));
	function_0168("player_spaceEnabled","0");
	thread maps\_space::func_5F18();
	thread maps\_space::space_hud_enable(0);
	self method_8275(1);
	self allowsprint(1);
	self method_8276(0);
}

//Function Number: 6
player_location_check(param_00)
{
	if(!isdefined(param_00))
	{
	}

	switch(param_00)
	{
		case "exterior":
			level.var_7742 = level.var_7742 * 1.5;
			function_0168("player_swimSpeed",level.var_7742);
			break;

		case "interior":
			level.var_7742 = level.var_7742 / 1.5;
			function_0168("player_swimSpeed",level.var_7742);
			break;
	}
}

//Function Number: 7
func_648D()
{
	level endon("stop_weapon_drop_scripts");
	if(level.script == "loki" || level.script == "odin" || level.script == "prologue")
	{
		for(;;)
		{
			var_00 = level.player getcurrentweapon();
			if(var_00 == "arx160_space+acog_sp+glarx160_sp" || var_00 == "microtar_space_interior+acogsmg_sp" || var_00 == "microtar_space+acogsmg_sp" || var_00 == "microtar_space_interior+acogsmg_sp+spaceshroud_sp" || var_00 == "microtar_space+acogsmg_sp+spaceshroud_sp")
			{
				level.player waittill("reload_start");
				if(level.player isreloading() == 1)
				{
					var_01 = spawn("script_model",(0,0,0));
					var_01 setmodel("tag_origin");
					if(var_00 == "microtar_space_interior+acogsmg_sp+spaceshroud_sp" || var_00 == "microtar_space_interior+acogsmg_sp")
					{
						wait(1.3);
						var_01 method_8021(self,"magazine0_JNT",(0,0,0),(0,0,0),1);
						playfxontag(common_scripts\utility::func_3AB9("space_clip_reload"),var_01,"tag_origin");
					}
					else if(var_00 == "microtar_space+acogsmg_sp+spaceshroud_sp" || var_00 == "microtar_space+acogsmg_sp")
					{
					}
					else
					{
						wait(0.7);
						var_01 method_8021(self,"J_WristTwist_LE",(0,-10,0),(-30,-20,0),1);
						playfxontag(common_scripts\utility::func_3AB9("space_clip_reload_arx"),var_01,"tag_origin");
					}

					wait(1);
					var_01 delete();
				}
			}

			wait(0.75);
		}
	}
}

//Function Number: 8
func_8BFB(param_00)
{
	level endon("wall_push_over");
	level endon("start_transition_to_youngblood");
	thread func_7C4D(param_00);
	while(!common_scripts\utility::flag("stop_wall_pushing"))
	{
		common_scripts\utility::flag_wait("wall_push_flag");
		common_scripts\utility::func_33A0("no_push_zone");
		var_01 = undefined;
		var_02 = undefined;
		var_03 = getentarray("wall_push_org","targetname");
		foreach(var_05 in var_03)
		{
			var_06 = distancesquared(level.player.origin,var_05.origin);
			if(!isdefined(var_01) || var_06 < var_01)
			{
				var_01 = var_06;
				var_02 = var_05;
			}
		}

		switch(var_02.script_parameters)
		{
			case "left":
				random_player_wall_push(var_02,param_00);
				break;

			case "up":
				break;

			case "down":
				random_player_wall_pushdownup(var_02,param_00);
				break;
		}

		wait(0.1);
	}

	param_00 unlink();
	param_00 delete();
}

//Function Number: 9
func_7C4D(param_00)
{
	common_scripts\utility::flag_wait("stop_wall_pushing");
	level notify("wall_push_over");
	param_00 unlink();
	param_00 delete();
}

//Function Number: 10
func_78FF()
{
	level endon("disable_space");
	level.timecheck = 0;
	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(var_00[0] > 0.4)
		{
			wait(0.1);
			level.timecheck = level.timecheck + 0.1;
			continue;
		}

		level.timecheck = 0;
		wait(0.1);
	}
}

//Function Number: 11
contuing_to_move_check()
{
	level endon("start_transition_to_youngblood");
	level.bmovingstraight = 0;
	var_00 = level.player getorigin();
	var_01[0] = var_00[0];
	var_01[1] = var_00[1];
	var_02[0] = var_01[0];
	var_02[1] = var_01[1];
	for(;;)
	{
		var_00 = level.player getorigin();
		var_01[0] = var_00[0];
		var_01[1] = var_00[1];
		for(var_03 = 0;var_03 < 2;var_03++)
		{
			if(var_01[var_03] < 0)
			{
				var_01[var_03] = var_01[var_03] * -1;
			}

			if(var_02[var_03] < 0)
			{
				var_02[var_03] = var_02[var_03] * -1;
			}

			var_04 = var_01[var_03] - var_02[var_03];
			var_05 = var_02[var_03] - var_01[var_03];
			if((var_01[var_03] - var_02[var_03] >= 2 || var_01[var_03] - var_02[var_03] <= -2) && level.player isreloading() == 0 && level.player maps\_utility::func_4864() == 0)
			{
				level.bmovingstraight = 1;
				break;
			}
			else
			{
				level.bmovingstraight = 0;
			}
		}

		wait(0.01);
		var_02[0] = var_01[0];
		var_02[1] = var_01[1];
	}
}

//Function Number: 12
random_player_wall_push(param_00,param_01)
{
	var_02 = [];
	var_02["player_rig"] = param_01;
	var_03 = param_00.angles[1];
	var_04 = 0;
	var_05 = 40;
	if(var_03 <= 0)
	{
		var_03 = var_03 + 360;
	}

	var_06 = 0;
	while(common_scripts\utility::flag("wall_push_flag"))
	{
		var_07 = randomintrange(1,10);
		var_08 = level.player getnormalizedmovement();
		var_09 = level.player getnormalizedmovement();
		level.player maps\_anim::anim_first_frame(var_02,"viewmodel_space_l_arm_sidepush");
		var_0A = level.player.angles[1];
		if(var_0A <= 0)
		{
			var_0A = var_0A + 360;
		}

		if(var_03 + var_05 > 360)
		{
			var_04 = var_03 + var_05 - 360;
			if(var_0A > var_03 || var_0A < var_04)
			{
				var_06 = 1;
			}
		}
		else if(var_0A > var_03 - var_05 && var_0A < var_03 + var_05)
		{
			var_06 = 1;
		}

		if(var_07 < 6)
		{
		}

		var_0B = 1;
		if(common_scripts\utility::flag("spacesprint"))
		{
			var_0B = 1.1;
		}

		if(var_06 == 1 && var_09[0] > 0.4 && level.timecheck > 1 && level.bmovingstraight == 1)
		{
			param_01 show();
			var_08;
			common_scripts\utility::flag_set("wall_push_tweak_player");
			if(level.script == "odin" || level.script == "prologue")
			{
				level.player playsound("space_plr_wall_push");
			}

			wait(1);
			thread anim_boost();
			wait(0.67);
			var_02 hide();
			wait(1);
		}

		var_07 = 0;
		wait(0.05);
	}
}

//Function Number: 13
random_player_wall_pushdownup(param_00,param_01)
{
	var_02 = [];
	var_02["player_rig"] = param_01;
	var_03 = param_00.angles[1];
	var_04 = 0;
	var_05 = 40;
	if(var_03 <= 0)
	{
		var_03 = var_03 + 360;
	}

	var_06 = 0;
	while(common_scripts\utility::flag("wall_push_flag"))
	{
		var_07 = randomintrange(1,10);
		var_08 = level.player getangles();
		var_09 = level.player getnormalizedmovement();
		level.player maps\_anim::anim_first_frame(var_02,"viewmodel_space_l_arm_downpush");
		var_0A = level.player.angles[1];
		if(var_0A <= 0)
		{
			var_0A = var_0A + 360;
		}

		if(var_03 + var_05 > 360)
		{
			var_04 = var_03 + var_05 - 360;
			if(var_0A > var_03 - var_05 || var_0A < var_04)
			{
				if(var_08[0] > -10 && var_08[0] < 30)
				{
					var_06 = 1;
				}
			}
		}
		else if(var_0A > var_03 - var_05 && var_0A < var_03 + var_05)
		{
			if(var_08[0] > -20 && var_08[0] < 30)
			{
				var_06 = 1;
			}
		}

		if(var_07 < 6)
		{
		}

		var_0B = 1;
		if(common_scripts\utility::flag("spacesprint"))
		{
			var_0B = 1.1;
		}

		if(var_06 == 1 && var_09[0] > 0.4 && level.timecheck > 1 && level.bmovingstraight == 1)
		{
			param_01 show();
			var_08;
			common_scripts\utility::flag_set("wall_push_tweak_player");
			if(level.script == "odin" || level.script == "prologue")
			{
				level.player playsound("space_plr_wall_push");
			}

			wait(1);
			thread anim_up_down_boost();
			wait(0.67);
			var_02 hide();
			wait(1);
		}

		var_07 = 0;
		wait(0.05);
	}
}

//Function Number: 14
anim_up_down_boost()
{
	common_scripts\utility::flag_set("boostAnim");
	function_0168("player_swimSpeed",level.var_7742 * 1.1);
	wait(0.7);
	common_scripts\utility::func_337C("boostAnim");
	function_0168("player_swimSpeed",level.var_7742);
}

//Function Number: 15
anim_boost()
{
	common_scripts\utility::flag_set("boostAnim");
	function_0168("player_swimSpeed",level.var_7742 * 1.1);
	wait(0.5);
	common_scripts\utility::func_337C("boostAnim");
	function_0168("player_swimSpeed",level.var_7742);
}

//Function Number: 16
moving_water()
{
	var_00 = getentarray("moving_water_flags","script_noteworthy");
	foreach(var_02 in var_00)
	{
		thread func_54DF(var_02);
	}
}

//Function Number: 17
func_54DF(param_00)
{
	level endon("disable_space");
	var_01 = 40;
	var_02 = getent(param_00.target,"targetname");
	var_03 = anglestoforward(var_02.angles) * var_01;
	for(;;)
	{
		common_scripts\utility::flag_wait(param_00.script_flag);
		level.var_8D38 = var_03;
		common_scripts\utility::func_33A0(param_00.script_flag);
		level.var_8D38 = (0,0,0);
	}
}

//Function Number: 18
func_5F14()
{
	level.var_6AED["layerhands"] = #animtree;
	level.var_6AF3["playerhands"] = "viewhands_player_us_space";
}

//Function Number: 19
direction_change_smoothing()
{
	level endon("start_transition_to_youngblood");
	level endon("disable_space");
	self endon("death");
	var_00 = level.player getnormalizedmovement();
	var_01 = var_00;
	if(!isdefined(level.wall_friction_enabled))
	{
		level.wall_friction_enabled = 1;
	}

	if(!isdefined(level.wall_friction_trace_dist))
	{
		level.wall_friction_trace_dist = 5;
	}

	if(!isdefined(level.var_8BF3))
	{
		level.var_8BF3 = 2;
	}

	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(var_00[0] > 0.15)
		{
			var_02 = "positive";
		}
		else
		{
			var_02 = "neutral";
		}

		if(var_00[1] > 0.15)
		{
			var_03 = "positive";
		}
		else
		{
			var_03 = "neutral";
		}

		if(var_00[0] < -0.15)
		{
			var_02 = "negative";
		}

		if(var_00[1] < -0.15)
		{
			var_03 = "negative";
		}

		if(var_01[0] > 0.15)
		{
			var_04 = "positive";
		}
		else
		{
			var_04 = "neutral";
		}

		if(var_01[1] > 0.15)
		{
			var_05 = "positive";
		}
		else
		{
			var_05 = "neutral";
		}

		if(var_01[0] < -0.15)
		{
			var_04 = "negative";
		}

		if(var_01[1] < -0.15)
		{
			var_05 = "negative";
		}

		var_06 = 0;
		if(level.wall_friction_enabled)
		{
			var_07 = vectornormalize(level.player getvelocity());
			var_08 = anglestoright(vectortoangles(var_07));
			var_09 = anglestoup(vectortoangles(var_07));
			var_0A = level.var_8BF3;
			var_0B = level.player.origin + (var_08[0] * var_0A,var_08[1] * var_0A,var_08[2] * var_0A);
			var_0B = var_0B + (var_09[0] * var_0A,var_09[1] * var_0A,var_09[2] * var_0A);
			var_0C = level.player.origin - (var_08[0] * var_0A,var_08[1] * var_0A,var_08[2] * var_0A);
			var_0C = var_0C - (var_09[0] * var_0A,var_09[1] * var_0A,var_09[2] * var_0A);
			var_0A = level.wall_friction_trace_dist;
			var_0D = var_0B + (var_07[0] * var_0A,var_07[1] * var_0A,var_07[2] * var_0A);
			var_0E = level.player aiphysicstrace(var_0B,var_0D);
			if(var_0D != var_0E)
			{
				var_06 = 1;
			}
			else
			{
				var_0D = var_0C + (var_07[0] * var_0A,var_07[1] * var_0A,var_07[2] * var_0A);
				var_0E = level.player aiphysicstrace(var_0C,var_0D);
				if(var_0D != var_0E)
				{
					var_06 = 1;
				}
			}
		}

		if(level.wall_friction_enabled && var_06 == 1)
		{
			function_0168("player_swimFriction",120);
			wait(0.15);
		}
		else if((var_03 == "neutral" && var_02 == "neutral") || var_05 == "positive" && var_04 == "positive" && var_03 == "positive" && var_02 == "positive" || var_05 == "negative" && var_04 == "negative" && var_03 == "negative" && var_02 == "negative" || var_05 == "negative" && var_04 == "positive" && var_03 == "negative" && var_02 == "positive" || var_05 == "positive" && var_04 == "negative" && var_03 == "positive" && var_02 == "negative")
		{
			if(getdvarint("player_swimFriction",15) != level.var_773A)
			{
				function_0168("player_swimFriction",level.var_773A);
			}

			if(getdvarint("player_swimAcceleration",66) != 66)
			{
				function_0168("player_swimAcceleration",66);
			}
		}
		else
		{
			function_0168("player_swimFriction",120);
			function_0168("player_swimAcceleration",200);
			wait(0.1);
		}

		if(var_02 != "neutral" && var_03 != "neutral ")
		{
			var_01 = var_00;
		}

		wait(0.1);
	}
}

//Function Number: 20
func_7743()
{
	level endon("disable_space");
	var_00 = 0;
	for(;;)
	{
		if(level.player issprinting())
		{
			if(var_00 == 0)
			{
				level.player playrumbleonentity("light_1s");
				wait(0.05);
				level.player stoprumble("light_1s");
				var_00 = 1;
			}
		}
		else
		{
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 21
func_797E(param_00)
{
	level endon("sprinting");
	for(;;)
	{
		if(param_00 > 1)
		{
			function_0168("player_swimSpeed",level.var_7742 * param_00);
			param_00 = param_00 - 0.05;
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 22
impulse_push()
{
	level endon("disable_space");
	for(;;)
	{
		level.player waittill("damage",var_00,var_01,var_02,var_03,var_04);
		common_scripts\utility::func_337C("clear_to_tweak_player");
		var_05 = [];
		var_05[0] = var_02[0];
		var_05[1] = var_02[1];
		var_05[2] = var_02[2];
		var_06 = 0.25;
		var_07 = 3000;
		var_08 = 1;
		if(var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE" || var_04 == "MOD_GRENADE_SPLASH")
		{
			var_06 = 0.5;
			var_07 = 7000;
			var_08 = 1;
		}

		for(var_09 = 0;var_09 < 3;var_09++)
		{
			var_05[var_09] = var_05[var_09] * 0.25 * var_00 * var_06;
			if(var_05[var_09] > var_07)
			{
				var_05[var_09] = var_07;
			}

			if(var_05[var_09] < 0 - var_07)
			{
				var_05[var_09] = 0 - var_07;
			}
		}

		function_0168("player_swimWaterCurrent",(var_05[0],var_05[1],var_05[2]));
		wait(var_08);
		for(var_09 = 0;var_09 < 3;var_09++)
		{
			for(var_09 = 0;var_09 < 3;var_09++)
			{
				var_05[var_09] = var_05[var_09] * 0.5;
			}

			function_0168("player_swimWaterCurrent",(var_05[0],var_05[1],var_05[2]));
			wait(var_08 * 0.25);
		}

		function_0168("player_swimWaterCurrent",(0,0,0));
		common_scripts\utility::flag_set("clear_to_tweak_player");
	}
}

//Function Number: 23
player_recoil()
{
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = level.player getcurrentweapon();
		if(var_00 == "microtar_space")
		{
			common_scripts\utility::func_337C("clear_to_tweak_player");
			var_01 = self getangles();
			var_02 = anglestoforward(var_01);
			var_03 = [];
			var_03[0] = var_02[0];
			var_03[1] = var_02[1];
			var_03[2] = var_02[2];
			var_04 = 2500;
			var_05 = 1;
			for(var_06 = 0;var_06 < 3;var_06++)
			{
				var_03[var_06] = var_03[var_06] * var_04 * -1;
			}

			function_0168("player_swimWaterCurrent",(var_03[0],var_03[1],var_03[2]));
			wait(var_05);
			for(var_06 = 0;var_06 < 3;var_06++)
			{
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					var_03[var_06] = var_03[var_06] * 0.5;
				}

				function_0168("player_swimWaterCurrent",(var_03[0],var_03[1],var_03[2]));
				wait(var_05 * 0.25);
			}

			function_0168("player_swimWaterCurrent",(0,0,0));
			common_scripts\utility::flag_set("clear_to_tweak_player");
		}
	}
}

//Function Number: 24
func_7746()
{
	level endon("disable_space");
	common_scripts\utility::flag_set("enable_player_thruster_audio");
	level.var_80C6 = 1;
	level.thruster_sprint_timer = 1;
	level.thruster_sprint = spawn("script_origin",(0,0,0));
	level.var_80C5 = spawn("script_origin",(0,0,0));
	level.axes = ["x","y","z_up","z_down"];
	level.player thread func_5F48();
	level.player thread func_80C4();
	level waittill("kill_thrusters");
	level.thruster_sprint delete();
	level.var_80C5 delete();
}

//Function Number: 25
func_5F16()
{
	wait(0.02);
	if(level.sfx_player_breathing_started == 0)
	{
		level.sfx_player_breathing_started = 1;
		if(!issplitscreen())
		{
			thread player_space_breathe_sound();
		}

		if(self == level.player)
		{
			thread player_space_breathe_sound();
		}
	}
}

//Function Number: 26
player_space_breathe_sound()
{
	level endon("start_transition_to_youngblood");
	self endon("death");
	self notify("start_scuba_breathe");
	self endon("start_scuba_breathe");
	self endon("stop_scuba_breathe");
	level.pressurized = 0;
	level.var_773E = 0;
	for(;;)
	{
		if(level.var_773E == 1)
		{
			wait(0.75);
		}
		else if(level.var_773E == 2)
		{
			wait(0.01);
		}
		else if(level.var_773E == 3)
		{
			wait(0.25);
		}
		else
		{
			wait(2.75);
		}

		if(level.space_breathing_enabled == 1)
		{
			if(level.pressurized == 0)
			{
				if(level.var_773E == 1 || level.var_773E == 2)
				{
					self playlocalsound("space_breathe_player_fast_inhale","scuba_breathe_sound_done");
				}
				else if(level.var_773E == 3)
				{
					self playlocalsound("space_breathe_player_inhale_slomo","scuba_breathe_sound_done");
				}
				else
				{
					self playlocalsound("space_breathe_player_inhale","scuba_breathe_sound_done");
				}

				self waittill("scuba_breathe_sound_done");
			}

			if(level.pressurized == 0)
			{
				if(level.var_773E == 1 || level.var_773E == 2)
				{
					self playlocalsound("space_breathe_player_fast_exhale","scuba_breathe_sound_done");
				}
				else if(level.var_773E == 3)
				{
					self playlocalsound("space_breathe_player_exhale_slomo","scuba_breathe_sound_done");
				}
				else
				{
					self playlocalsound("space_breathe_player_exhale","scuba_breathe_sound_done");
				}

				self waittill("scuba_breathe_sound_done");
			}
		}
	}
}

//Function Number: 27
attach_audio_points_to_player()
{
	level endon("kill_thrusters");
	for(;;)
	{
		common_scripts\utility::flag_wait("enable_player_thruster_audio");
		level._thruster_rig = spawn("script_model",(0,0,0));
		level._thruster_rig.origin = self.origin;
		level._thruster_rig.angles = self.angles;
		level._thruster_rig setmodel("viewhands_us_space");
		level._thruster_rig method_82C8();
		level._thruster_rig hide();
		level._thruster_rig method_8021(self,"tag_player",(0,0,0),(0,0,0),1);
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			var_01 = spawn("script_model",(0,0,0));
			var_01 setmodel("tag_origin");
			if(var_00 == 0)
			{
				var_01.origin = level._thruster_rig gettagorigin("tag_jet_top");
				var_01 linkto(level._thruster_rig,"tag_jet_top",(0,0,0),(0,0,0));
			}
			else if(var_00 == 1)
			{
				var_01.origin = level._thruster_rig gettagorigin("tag_jet_bottom");
				var_01 linkto(level._thruster_rig,"tag_jet_bottom",(0,0,0),(0,0,0));
			}
			else if(var_00 == 2)
			{
				var_01.origin = level._thruster_rig gettagorigin("tag_jet_front");
				var_01 linkto(level._thruster_rig,"tag_jet_front",(0,0,0),(0,0,0));
			}
			else if(var_00 == 3)
			{
				var_01.origin = level._thruster_rig gettagorigin("tag_jet_left");
				var_01 linkto(level._thruster_rig,"tag_jet_left",(0,0,0),(0,0,0));
			}
			else if(var_00 == 4)
			{
				var_01.origin = level._thruster_rig gettagorigin("tag_jet_right");
				var_01 linkto(level._thruster_rig,"tag_jet_right",(0,0,0),(0,0,0));
			}
			else if(var_00 == 5)
			{
				var_01.origin = level._thruster_rig gettagorigin("tag_jet_back");
				var_01 linkto(level._thruster_rig,"tag_jet_back",(0,0,0),(0,0,0));
			}

			var_01 thread func_80C4(var_00);
			level._thruster_ents[var_00] = var_01;
		}

		common_scripts\utility::func_33A0("enable_player_thruster_audio");
		foreach(var_01 in level._thruster_ents)
		{
			var_01 notify("stop");
			var_01 delete();
		}

		level._thruster_rig delete();
	}
}

//Function Number: 28
func_80C4()
{
	level endon("kill_thrusters");
	self endon("death");
	self.var_6158 = [];
	self.var_6158["x"] = 0;
	self.var_6158["y"] = 0;
	self.var_6158["z_up"] = 0;
	self.var_6158["z_down"] = 0;
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		common_scripts\utility::flag_wait("prologue_ready_for_thrusters");
	}

	for(;;)
	{
		self waittill("thruster_update",var_00,var_01);
		level.bob_value = var_00;
		if("z_up" == var_01 || "z_down" == var_01)
		{
			level.bob_axis = "z";
		}
		else
		{
			level.bob_axis = var_01;
		}

		if(castint(var_00) != self.var_6158[var_01])
		{
			thread func_5D33(abs(var_00));
		}

		self.var_6158[var_01] = castint(var_00);
	}
}

//Function Number: 29
func_5D33(param_00)
{
	switch(castint(param_00))
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			if(level.var_80C6 > 0)
			{
				thread thruster_timer_logic();
				level.var_80C5 stopsounds();
				level.var_80C5 playsound("space_jetpack_boost_oneshot");
			}
			break;

		case 3:
			if(level.var_80C6 > 0)
			{
				self playsound("space_jetpack_boost_start_large");
				thread thruster_timer_logic();
				level.var_80C5 stopsounds();
				level.var_80C5 playsound("space_jetpack_boost_oneshot_big");
			}
			break;

		case 4:
			if(level.thruster_sprint_timer > 0)
			{
				self playsound("space_jetpack_boost_start_sprint");
				thread thruster_sprint_interval();
				level.thruster_sprint stopsounds();
				level.thruster_sprint playsound("space_jetpack_boost_oneshot_sprint");
			}
			break;
	}
}

//Function Number: 30
thruster_sprint_interval()
{
	level.thruster_sprint_timer = 0;
	wait(0.5);
	level.thruster_sprint_timer = 1;
}

//Function Number: 31
thruster_timer_logic()
{
	level.var_80C6 = 0;
	wait(0.1);
	level.var_80C6 = 1;
}

//Function Number: 32
func_5F48()
{
	level endon("kill_thrusters");
	self endon("death");
	for(;;)
	{
		common_scripts\utility::flag_wait("enable_player_thruster_audio");
		var_00 = [0,0,0,0];
		while(common_scripts\utility::flag("enable_player_thruster_audio"))
		{
			var_01 = func_5AEF();
			if(var_01[0] != var_00[0] || var_01[1] != var_00[1] || var_01[2] != var_00[2] || var_01[3] != var_00[3])
			{
				func_6F7E(var_01,var_00);
			}

			var_00 = var_01;
			wait(0.05);
		}
	}
}

//Function Number: 33
func_5AEF()
{
	var_00 = [0,0,0,0];
	var_01 = self getnormalizedmovement();
	for(var_02 = 0;var_02 < 2;var_02++)
	{
		var_00[var_02] = 0;
		if(abs(var_01[var_02]) > 0.1)
		{
			var_00[var_02] = 2;
		}

		if(var_00[var_02] > 0 && self issprinting())
		{
			var_00[var_02] = 4;
		}

		if(var_01[var_02] < 0)
		{
			var_00[var_02] = var_00[var_02] * -1;
		}
	}

	if(self jumpbuttonpressed() || self fragbuttonpressed())
	{
		var_00[2] = var_00[2] + common_scripts\utility::func_803F(self fragbuttonpressed(),3,2);
	}

	if(func_47C9() || self secondaryoffhandbuttonpressed())
	{
		var_00[3] = var_00[3] + common_scripts\utility::func_803F(self secondaryoffhandbuttonpressed(),3,2);
	}

	return var_00;
}

//Function Number: 34
func_47C9()
{
	var_00 = 0;
	if(self buttonpresseddevonly("BUTTON_CROUCH") || self buttonpresseddevonly("BUTTON_PRONE") || self buttonpresseddevonly("BUTTON_B") || self buttonpresseddevonly("BUTTON_RSTICK"))
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 35
func_6F7E(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] != param_01[var_02])
		{
			level.player notify("thruster_update",param_00[var_02],level.axes[var_02]);
			wait(0.05);
		}
	}
}

//Function Number: 36
func_39CC(param_00,param_01)
{
	var_02 = [];
	switch(param_00)
	{
		case 0:
			if(param_01 >= 0)
			{
				var_02[var_02.size] = 5;
			}
	
			if(param_01 <= 0)
			{
				var_02[var_02.size] = 2;
			}
			break;

		case 1:
			if(param_01 >= 0)
			{
				var_02[var_02.size] = 3;
			}
	
			if(param_01 <= 0)
			{
				var_02[var_02.size] = 4;
			}
			break;

		case 2:
			if(param_01 >= 0)
			{
				var_02[var_02.size] = 1;
			}
	
			if(param_01 <= 0)
			{
				var_02[var_02.size] = 0;
			}
			break;

		default:
			break;
	}

	return var_02;
}

//Function Number: 37
debug_thruster_text(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00))
	{
		if(0 == param_00)
		{
			var_02[var_02.size] = "TOP";
		}
		else if(1 == param_00)
		{
			var_02[var_02.size] = "BOTTOM";
		}
		else if(2 == param_00)
		{
			var_02[var_02.size] = "FRONT";
		}
		else if(3 == param_00)
		{
			var_02[var_02.size] = "LEFT";
		}
		else if(4 == param_00)
		{
			var_02[var_02.size] = "RIGHT";
		}
		else if(5 == param_00)
		{
			var_02[var_02.size] = "BACK";
		}
	}
	else
	{
		var_02[var_02.size] = "";
	}

	if(isdefined(param_01))
	{
		if(0 == param_01)
		{
			var_02[var_02.size] = "OFF";
		}
		else if(1 == param_01)
		{
			var_02[var_02.size] = "LOW";
		}
		else if(2 == param_01)
		{
			var_02[var_02.size] = "MEDIUM";
		}
		else
		{
			var_02[var_02.size] = "HIGH";
		}
	}
	else
	{
		var_02[var_02.size] = "";
	}

	return var_02;
}

//Function Number: 38
debug_test_thruster_audio()
{
	for(;;)
	{
		for(var_00 = 1;var_00 < 4;var_00++)
		{
			for(var_01 = 0;var_01 < level._thruster_ents.size;var_01++)
			{
				var_02 = debug_thruster_text(var_01,var_00);
				iprintln("Playing thruster " + var_02[0] + "\'s " + var_02[1] + " burst audio");
				switch(var_00)
				{
					case 1:
						level._thruster_ents[var_01] playsound("space_jetpack_boost_start_small");
						break;
	
					case 2:
						level._thruster_ents[var_01] playsound("space_jetpack_boost_start_med");
						break;
	
					case 3:
						level._thruster_ents[var_01] playsound("space_jetpack_boost_start_large");
						break;
				}

				wait(2);
			}
		}

		for(var_00 = 0;var_00 < 2;var_00++)
		{
			for(var_01 = 0;var_01 < level._thruster_ents.size;var_01++)
			{
				var_02 = debug_thruster_text(var_01,var_00);
				switch(var_00)
				{
					case 0:
						iprintln("Playing thruster " + var_02[0] + "\'s loop audio");
						break;
	
					case 1:
						iprintln("Playing thruster " + var_02[0] + "\'s sprint loop audio");
						break;
				}

				wait(2);
				level._thruster_ents[var_01] stoploopsound();
				wait(1);
			}
		}
	}
}

//Function Number: 39
func_8E5D(param_00,param_01)
{
	for(;;)
	{
		var_02 = level.player.origin;
		if(isdefined(param_01))
		{
		}
		else
		{
		}

		wait(1);
	}
}