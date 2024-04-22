/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 137
 * Decompile Time: 1953 ms
 * Timestamp: 4/22/2024 2:34:05 AM
*******************************************************************/

//Function Number: 1
drone_lookat_ent(param_00,param_01,param_02,param_03)
{
	self endon("fly_drone_done");
	self notify("start_new_drone_lookat");
	self endon("start_new_drone_lookat");
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_04 = getent(param_00,"targetname");
	var_05 = vectortoangles(var_04.origin - self.origin);
	if(!isdefined(param_01) || param_01 == 0)
	{
		self.angles = var_05;
	}
	else
	{
		self rotateto(var_05 + param_03,param_01,param_01 / 5,param_01 / 5);
		self waittill("rotatedone");
		self notify("drone_lookat_done");
	}

	if(isdefined(param_02) && param_02)
	{
		for(;;)
		{
			var_05 = vectortoangles(var_04.origin - self.origin) + param_03;
			self rotateto(var_05,0.1,0,0);
			wait(0.1);
		}
	}
}

//Function Number: 2
drone_moveto_ent(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_00,"targetname");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self moveto(var_04.origin,param_01,param_02,param_03);
	self waittill("movedone");
	self notify("drone_moveto_done");
}

//Function Number: 3
drone_view_shake(param_00)
{
	self notify("start_new_intro_shake");
	self endon("start_new_intro_shake");
	for(;;)
	{
		if(common_scripts\utility::flag("fly_drone_done"))
		{
			break;
		}

		earthquake(param_00,0.1,level.player.origin,200);
		wait(0.1);
	}
}

//Function Number: 4
showstatic(param_00)
{
	level.overlaystatic = newhudelem(level.player);
	level.overlaystatic.x = 0;
	level.overlaystatic.y = 0;
	level.overlaystatic.alpha = 1;
	level.overlaystatic.horzalign = "fullscreen";
	level.overlaystatic.vertalign = "fullscreen";
	level.overlaystatic.sort = 4;
	level.overlaystatic setshader("overlay_static_digital",640,480);
	wait(param_00);
	level.overlaystatic destroy();
}

//Function Number: 5
fly_drone_ui_on()
{
	setomnvar("ui_lagosflydrone",1);
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingame("flydrone_UI");
	common_scripts\utility::flag_wait("drone_fly_anim_done");
	fly_drone_ui_off();
}

//Function Number: 6
fly_drone_ui_off()
{
	stopcinematicingame();
	setomnvar("ui_lagosflydrone",0);
	wait(40.5);
	fly_drone_transition_on();
}

//Function Number: 7
fly_drone_transition_on()
{
	setomnvar("ui_lagosflydrone",1);
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingame("fly_drone_shut_down");
	wait(1);
	thread maps\_introscreen::introscreen_generic_black_fade_in(1,0.89,0.1);
	level.player.overlay["black"].sort = -1;
	level.player.overlay["black"].foreground = 0;
	wait(5);
	fly_drone_transition_off();
}

//Function Number: 8
fly_drone_transition_off()
{
	stopcinematicingame();
	setomnvar("ui_lagosflydrone",0);
}

//Function Number: 9
hide_friendname_until_flag_or_notify(param_00)
{
	if(!isdefined(self.name))
	{
		return;
	}

	level.player endon("death");
	self endon("death");
	self.old_name = self.name;
	self.name = " ";
	level waittill(param_00);
	self.name = self.old_name;
}

//Function Number: 10
calculateleftstickdeadzone()
{
	var_00 = level.player getnormalizedmovement();
	var_00 = (scalestickinput(var_00[0]),scalestickinput(var_00[1]),var_00[2]);
	return var_00;
}

//Function Number: 11
stickinputindeadzone(param_00,param_01)
{
	return abs(param_00) < param_01;
}

//Function Number: 12
scalestickinput(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.25;
	}

	if(stickinputindeadzone(param_00,param_01))
	{
		return 0;
	}

	return param_00 * abs(param_00) - param_01 / 1 - param_01;
}

//Function Number: 13
drone_panic_spawn(param_00)
{
	var_01 = param_00 maps\_utility::spawn_ai();
	var_01.goalradius = 32;
	var_01.ignoreall = 1;
	var_01.ignoreme = 1;
	var_01.animname = "civilian_run";
	var_02 = randomintrange(1,6);
	var_01 maps\_utility::set_run_anim("civ_run_panic_" + var_02,1);
	var_01.run_override_weights = undefined;
	var_01.alertlevelint = 2;
	var_01 thread drone_panic_delete();
}

//Function Number: 14
drone_panic_delete()
{
	self waittill("goal");
	self delete();
}

//Function Number: 15
populate_drone_civilians(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_01)
	{
		var_05 = param_00 maps\_utility::dronespawn();
		var_02 = common_scripts\utility::array_add(var_02,var_05);
		param_00.count = 1;
		var_05.origin = var_04.origin;
		var_05.angles = var_04.angles;
		var_05.allowdeath = 0;
		var_05 thread civilian_drone_runner_collision();
		wait 0.05;
		if(isdefined(var_04.script_squadname))
		{
			var_05 thread civilian_anim_setup(var_04);
		}
		else
		{
			var_05 thread loopingidleanimation(var_04);
		}

		if(isdefined(var_04.script_noteworthy))
		{
			var_05 thread stop_loop_and_react(var_04);
		}
	}

	return var_02;
}

//Function Number: 16
civilian_drone_runner_collision()
{
	self endon("goal");
	self endon("death");
	while(isdefined(self))
	{
		while(distance(self.origin,level.player.origin) > 100)
		{
			wait(0.1);
		}

		var_00 = self setcontents(0);
		while(distance(self.origin,level.player.origin) <= 100)
		{
			wait(0.1);
		}

		self setcontents(var_00);
	}
}

//Function Number: 17
populate_ai_civilians(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	foreach(var_06 in param_01)
	{
		var_07 = param_00 maps\_utility::spawn_ai();
		var_04 = common_scripts\utility::array_add(var_04,var_07);
		param_00.count = 1;
		var_08 = spawn("script_origin",var_06.origin);
		if(isdefined(var_06.angles))
		{
			var_08.angles = var_06.angles;
		}

		var_08.animation = var_06.animation;
		var_08.script_noteworthy = var_06.script_noteworthy;
		var_08.script_parameters = var_06.script_parameters;
		var_08.script_index = var_06.script_index;
		var_08.script_squadname = var_06.script_squadname;
		var_08.script_nodestate = var_06.script_nodestate;
		var_07 immune_sonic_blast();
		var_07 teleport(var_08.origin,var_08.angles);
		wait 0.05;
		if(isdefined(param_02) && param_02 == 1)
		{
			if(isdefined(var_08.script_squadname))
			{
				var_07 thread civilian_anim_setup(var_08,param_03);
			}
			else
			{
				var_07 thread loopingidleanimation(var_08);
				var_07 thread stop_loop_and_react(var_08);
			}

			continue;
		}

		var_07 thread loopingidleanimation(var_08);
	}

	return var_04;
}

//Function Number: 18
civilian_anim_setup(param_00,param_01)
{
	self endon("death");
	var_02 = float(param_00.script_index);
	var_03 = param_00.script_nodestate;
	var_04 = param_00.animation;
	var_05 = param_00.script_noteworthy;
	var_06 = param_00.script_parameters;
	var_07 = param_00.script_squadname;
	thread special_loopingidleanimation(param_00,var_04);
	self.alertlevelint = 0;
	if(isdefined(var_03))
	{
		common_scripts\utility::flag_wait(var_03);
		wait(randomfloatrange(0.1,0.75));
		param_00 notify("stop_loop");
		self.alertlevelint = 2;
		wait 0.05;
	}
	else
	{
		while(self.alertlevelint < 2)
		{
			wait(0.1);
			if(!isdefined(self))
			{
				return;
			}

			foreach(var_09 in level.alpha_squad_and_player)
			{
				if(distance(self.origin,var_09.origin) < var_02)
				{
					param_00 notify("stop_loop");
					self.alertlevelint = 2;
					wait 0.05;
				}
			}
		}
	}

	if(isdefined(var_06))
	{
		if(issubstr(var_06,"panic"))
		{
			self.animname = "civilian_react_move_back";
		}
		else if(issubstr(var_06,"run"))
		{
			self.animname = "civilian_react_then_run";
		}

		param_00 maps\_anim::anim_single_solo(self,var_06);
		param_00.origin = self.origin;
		param_00.angles = self.angles;
	}

	if(isdefined(var_05))
	{
		self.animname = "civilian_react";
		param_00 thread maps\_anim::anim_loop_solo(self,var_05,"stop_loop");
		common_scripts\utility::flag_wait(param_01);
		wait(randomfloatrange(0.1,0.5));
		param_00 notify("stop_loop");
	}

	self setgoalvolumeauto(getent(var_07,"targetname"));
	thread cleanup_on_goal();
	param_00 delete();
}

//Function Number: 19
walking_civilian_react()
{
	self endon("death");
	var_00 = getnode(self.target,"targetname");
	var_01 = var_00.script_nodestate;
	var_02 = float(var_00.script_index);
	var_03 = var_00.script_noteworthy;
	var_04 = var_00.script_parameters;
	var_05 = var_00.script_squadname;
	self.alertlevelint = 0;
	if(isdefined(var_01))
	{
		common_scripts\utility::flag_wait(var_01);
		self.alertlevelint = 2;
		wait 0.05;
	}
	else
	{
		while(self.alertlevelint < 2)
		{
			wait(0.1);
			if(!isdefined(self))
			{
				return;
			}

			foreach(var_07 in level.alpha_squad_and_player)
			{
				if(distance(self.origin,var_07.origin) < var_02)
				{
					self.alertlevelint = 2;
					wait 0.05;
				}
			}
		}
	}

	wait(randomfloatrange(0.1,0.75));
	var_00 = spawn("script_origin",self.origin);
	var_00.angles = self.angles;
	if(isdefined(var_04))
	{
		if(issubstr(var_04,"panic"))
		{
			self.animname = "civilian_react_move_back";
		}
		else if(issubstr(var_04,"run"))
		{
			self.animname = "civilian_react_then_run";
		}

		var_00 maps\_anim::anim_single_solo(self,var_04);
		var_00.origin = self.origin;
		var_00.angles = self.angles;
	}

	if(isdefined(var_03))
	{
		self.animname = "civilian_react";
		var_00 thread maps\_anim::anim_loop_solo(self,var_03,"stop_loop");
		common_scripts\utility::flag_wait("flag_Roundabout_Civilians_Flee");
		wait(randomfloatrange(0.1,0.75));
		var_00 notify("stop_loop");
	}

	self setgoalvolumeauto(getent(var_05,"targetname"));
	thread cleanup_on_goal();
	var_00 delete();
}

//Function Number: 20
randomidleanimation(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = common_scripts\utility::random(level.randomidleanims);
		param_00 maps\_anim::anim_generic(self,var_01);
		wait 0.05;
	}
}

//Function Number: 21
loopingidleanimation(param_00)
{
	self.animname = "generic";
	var_01 = param_00.animation;
	param_00 thread maps\_anim::anim_generic_loop(self,var_01,"stop_loop");
	var_02 = attachprops(var_01);
	common_scripts\utility::waittill_either("stop_loop","death");
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 22
attachprops(param_00)
{
	if(isdefined(self.hasattachedprops))
	{
		return;
	}

	initcivilianprops();
	var_01 = level.civilianprops[param_00];
	if(isdefined(var_01))
	{
		self.attachedpropmodel = var_01;
		self.attachedproptag = "tag_inhand";
		var_02 = self attach(self.attachedpropmodel,self.attachedproptag,1);
		self.hasattachedprops = 1;
		return var_02;
	}
}

//Function Number: 23
initcivilianprops()
{
	if(isdefined(level.civilianprops))
	{
		return;
	}

	anim.civilianprops = [];
	level.civilianprops["civilian_texting_standing"] = "electronics_pda";
	level.civilianprops["civilian_texting_sitting"] = "electronics_pda";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
	level.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
	level.civilianprops["civilian_smoking_A"] = "prop_cigarette";
	level.civilianprops["civilian_smoking_B"] = "prop_cigarette";
	level.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
	level.civilianprops["oilrig_balcony_smoke_idle"] = "prop_cigarette";
	level.civilianprops["guardB_sit_drinker_idle"] = "cs_coffeemug02";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
	level.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
	level.civilianprops["civilian_reader_1"] = "lab_tablet_flat_on";
	level.civilianprops["civilian_reader_2"] = "lab_tablet_flat_on";
	level.civilianprops["civilian_briefcase_walk"] = "hjk_metal_briefcase";
	level.civilianprops["civilian_crazy_walk"] = "electronics_pda";
	level.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
	level.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
	level.civilianprops["civilian_paper_walk"] = "paper_memo";
	level.civilianprops["civilian_coffee_walk"] = "cs_coffeemug02";
	level.civilianprops["civilian_pda_walk"] = "electronics_pda";
}

//Function Number: 24
stop_loop_and_react(param_00)
{
	switch(param_00.script_noteworthy)
	{
		case "location_rb_lobby_exit":
			common_scripts\utility::flag_wait("flag_roundabout_move_1");
			break;

		case "location_rb_lobby_exit_stairs":
			common_scripts\utility::flag_wait("flag_roundabout_move_1");
			break;

		case "location_rb_lobby_exit_sidewalk":
			common_scripts\utility::flag_wait("flag_roundabout_move_2");
			break;

		case "location_rb_street_northwest":
			common_scripts\utility::flag_wait("flag_roundabout_move_3");
			break;

		case "location_rb_street_middle":
			common_scripts\utility::flag_wait("roundabout_combat_begin");
			break;

		default:
			common_scripts\utility::flag_wait("flag_roundabout_move_5");
			break;
	}

	if(isdefined(self))
	{
		wait(randomfloatrange(0.1,0.75));
		param_00 notify("stop_loop");
		self.animname = "civilian_react";
		var_01 = randomintrange(1,5);
		var_02 = "civ_idle_panic_" + var_01;
		param_00 thread maps\_anim::anim_loop_solo(self,var_02,"stop_loop");
		common_scripts\utility::flag_wait("flag_Roundabout_Civilians_Flee");
		level.rb_flee_goal_pick++;
		var_03 = randomintrange(1,8);
		param_00 notify("stop_loop");
		wait(randomfloatrange(0.1,0.75));
		civilain_flee_to_goal();
	}

	param_00 delete();
}

//Function Number: 25
civilain_flee_to_goal()
{
	self endon("death");
	var_00 = level.roundabout_flee_goals;
	var_01 = 0;
	while(!var_01)
	{
		foreach(var_03 in var_00)
		{
			var_03.distance_to_goalvol_sq = distancesquared(self.origin,var_03.origin);
		}

		var_00 = common_scripts\utility::array_sort_with_func(var_00,::closer_to_goal_vol);
		self setgoalvolumeauto(var_00[0]);
		thread cleanup_on_goal();
		var_05 = common_scripts\utility::waittill_any_return("bad_path","goal");
		if(var_05 == "goal")
		{
			var_01 = 1;
		}
		else if(var_05 == "bad_path")
		{
			var_00 = common_scripts\utility::array_remove(var_00,var_00[0]);
		}

		if(var_00.size < 1)
		{
			if(isdefined(self) && isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
			{
				maps\_utility::stop_magic_bullet_shield();
			}

			maps\_shg_design_tools::delete_auto();
			return;
		}
	}
}

//Function Number: 26
closer_to_goal_vol(param_00,param_01)
{
	return param_00.distance_to_goalvol_sq < param_01.distance_to_goalvol_sq;
}

//Function Number: 27
farther_to_goal_vol(param_00,param_01)
{
	return param_00.distance_to_goalvol_sq > param_01.distance_to_goalvol_sq;
}

//Function Number: 28
special_loopingidleanimation(param_00,param_01)
{
	self.animname = "generic";
	var_02 = param_01;
	param_00 thread maps\_anim::anim_generic_loop(self,var_02,"stop_loop");
	var_03 = attachprops(var_02);
	self waittill("death");
	if(isdefined(var_03))
	{
		var_03 delete();
	}
}

//Function Number: 29
delete_at_path_end()
{
	self waittill("reached_path_end");
	self.allowdeath = 1;
	if(isalive(self))
	{
		self kill();
	}

	wait(0.1);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 30
bike_rider(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = getent(var_02.target,"targetname");
	var_04 = spawn("script_model",var_02.origin);
	var_04 setmodel("com_bike_animated");
	var_04 useanimtree(level.scr_animtree["bike"]);
	var_05 = spawn("script_model",var_04.origin);
	var_05 useanimtree(#animtree);
	if(!isdefined(level.spawned_bike_rider))
	{
		level.spawned_bike_rider = 1;
		var_05 character\character_civilian_slum_male_aa::main();
	}
	else
	{
		var_05 character\character_civilian_slum_male_ab::main();
	}

	var_05.origin = var_04 gettagorigin("j_frame");
	var_05.origin = var_05.origin + (-12,0,-30);
	var_05.angles = var_04 gettagangles("j_frame");
	var_05.angles = var_05.angles + (0,180,0);
	var_05 linkto(var_04,"j_frame");
	var_06 = vectortoangles(var_02.origin - var_03.origin);
	var_04.angles = (0,var_06[1],0);
	var_04 setanim(level.scr_anim["bike"]["pedal"]);
	var_05 setanim(level.scr_anim["generic"]["bike_rider"]);
	var_04 moveto(var_03.origin,param_01,0,0);
	wait(param_01);
	var_05 delete();
	var_04 delete();
}

//Function Number: 31
civilian_get_out_of_car_setup(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = get_civilian_car(param_00);
	if(isdefined(var_05))
	{
		var_06 = undefined;
		if(issubstr(param_01,"drone"))
		{
			var_06 = get_civilian_drone(param_01,var_05.animname);
		}
		else
		{
			var_06 = get_civilian_ai(param_01,var_05.animname);
		}

		if(issubstr(var_05.vehicle_spawner.targetname,"roundabout_lobby"))
		{
			var_06["ai"].target = var_05.vehicle_spawner.targetname + "_target";
		}

		level thread civilian_in_car_get_out(var_05,var_06,param_02,param_03,param_04);
	}
}

//Function Number: 32
get_civilian_car(param_00)
{
	var_01 = maps\_utility::get_vehicle(param_00,"targetname");
	if(issubstr(var_01.model,"sedan"))
	{
		var_01.animname = "sedan";
		var_01 useanimtree(#animtree);
	}
	else if(issubstr(var_01.model,"compact"))
	{
		var_01.animname = "compact";
		var_01 useanimtree(#animtree);
	}
	else if(issubstr(var_01.model,"truck"))
	{
		var_01.animname = "truck";
		var_01 useanimtree(#animtree);
	}
	else
	{
		var_01 = undefined;
	}

	return var_01;
}

//Function Number: 33
get_civilian_ai(param_00,param_01)
{
	var_02 = [];
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03.count) || var_03.count < 1)
	{
		var_03.count = 1;
	}

	var_02["ai"] = var_03 maps\_utility::spawn_ai(1,0);
	var_02["ai"] immune_sonic_blast();
	var_02["ai"].ignoreall = 1;
	var_02["ai"].animname = param_01 + "_driver";
	if(isdefined(var_03.target))
	{
		var_02["goal"] = getnode(var_03.target,"targetname");
	}

	return var_02;
}

//Function Number: 34
get_civilian_drone(param_00,param_01)
{
	var_02 = [];
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03.count) || var_03.count < 1)
	{
		var_03.count = 1;
	}

	var_02["ai"] = var_03 maps\_utility::dronespawn();
	var_02["ai"].ignoreall = 1;
	var_02["ai"].animname = param_01 + "_driver";
	var_02["ai"].allowdeath = 0;
	var_02["ai"].damageshield = 1;
	var_02["ai"] thread civilian_drone_runner_collision();
	return var_02;
}

//Function Number: 35
civilian_in_car_get_out(param_00,param_01,param_02,param_03,param_04)
{
	level.player endon("death");
	param_01["ai"] endon("death");
	var_05 = randomintrange(1,3);
	param_01["ai"] linkto(param_00,"tag_driver");
	param_00 thread maps\_anim::anim_loop_solo(param_01["ai"],"loop_0" + var_05,"stop_driver_loop","tag_driver");
	if(isdefined(param_01["ai"]))
	{
		level waittill(param_02);
		wait(randomfloatrange(0.1,0.6));
		param_01["ai"] unlink();
		param_01["ai"] maps\_utility::set_run_anim("run_0" + var_05,1);
		param_01["ai"].run_override_weights = undefined;
		param_00 notify("stop_driver_loop");
		param_00 thread maps\_anim::anim_single_solo(param_00,"get_out_0" + var_05);
		param_00 maps\_anim::anim_single_solo_run(param_01["ai"],"get_out_0" + var_05,"tag_driver");
		if(isdefined(param_01["ai"].script_moveoverride))
		{
			param_01["ai"] thread maps\_drone::drone_move();
		}
		else
		{
			param_01["ai"] civilain_flee_to_goal();
		}

		if(isdefined(param_01["ai"]) && isalive(param_01["ai"]))
		{
			param_01["ai"] thread cleanup_on_goal();
		}
	}
}

//Function Number: 36
roundabout_civilian_flee_path_and_run_select()
{
	level.rb_flee_goal_pick++;
	var_00 = randomintrange(1,8);
	if(isdefined(self) && isalive(self))
	{
		self.animname = "civilian_run";
		maps\_utility::set_run_anim("civ_run_panic_" + var_00);
		civilain_flee_to_goal();
	}
}

//Function Number: 37
cleanup_on_goal()
{
	self endon("death");
	if(isdefined(self))
	{
		self waittill("goal");
		if(isdefined(self) && isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
		{
			maps\_utility::stop_magic_bullet_shield();
		}

		maps\_shg_design_tools::delete_auto();
	}
}

//Function Number: 38
civilian_loop_setup(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = getent(param_00,"targetname");
	var_03[0] = var_04 maps\_utility::spawn_ai(1,0);
	if(!isdefined(var_03[0]))
	{
		return;
	}

	var_03[0].animname = "civilian";
	var_03[0].ignoreall = 1;
	if(isdefined(param_01))
	{
		var_05 = getent(param_01,"targetname");
		var_03[1] = var_05 maps\_utility::spawn_ai(1,0);
		if(!isdefined(var_03[1]))
		{
			var_03[0].script_noteworthy = "seated";
		}
		else
		{
			var_03[1].animname = "civilian_b";
			var_03[1].ignoreall = 1;
		}
	}

	level thread start_civilian_loop_anims(var_03,param_02);
	foreach(var_07 in var_03)
	{
		var_07 thread no_civilian_friendly_fire_until_seen();
	}
}

//Function Number: 39
no_civilian_friendly_fire_until_seen()
{
	self endon("death");
	self.no_friendly_fire_penalty = 1;
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0.5;
	}

	for(;;)
	{
		if(maps\_utility::player_can_see_ai(self))
		{
			break;
		}

		if(player_can_see_civ(self))
		{
			break;
		}

		wait(var_00);
	}

	self.no_friendly_fire_penalty = undefined;
}

//Function Number: 40
player_can_see_civ(param_00)
{
	if(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,param_00.origin,0.743))
	{
		return 0;
	}

	var_01 = level.player geteye();
	var_02 = undefined;
	for(var_03 = 0;var_03 < 2;var_03++)
	{
		var_04 = param_00.origin;
		var_05 = param_00 geteye();
		var_06 = var_05 + var_04 * 0.5;
		var_07 = bullettrace(var_01,var_06,0,var_02);
		if(var_07["fraction"] < 0.99)
		{
			if(isdefined(var_07["entity"]) && isai(var_07["entity"]) && var_07["entity"] != param_00)
			{
				var_02 = var_07["entity"];
			}
		}
		else
		{
			return 1;
		}

		if(!isdefined(var_02))
		{
			break;
		}
	}

	return 0;
}

//Function Number: 41
start_civilian_loop_anims(param_00,param_01)
{
	wait(randomfloatrange(0,0.25));
	if(isalive(param_00[0]) && !isalive(param_00[1]))
	{
		if(param_00[0].script_noteworthy == "paired")
		{
			param_00[0].script_noteworthy = "seated";
		}
	}
	else if(!isalive(param_00[0]) && isalive(param_00[1]))
	{
		param_00[0] = param_00[1];
		param_00[1] = undefined;
		param_00[0].script_noteworthy = "seated";
	}
	else if(!isalive(param_00[0]) && !isalive(param_00[1]))
	{
		return;
	}

	if(!isdefined(param_00[0].script_noteworthy))
	{
		return;
	}

	if(param_00[0].script_noteworthy == "laying")
	{
		if(randomint(100) < 50)
		{
			var_02 = "laying_1";
		}
		else
		{
			var_02 = "laying_2";
		}

		param_00[0] thread maps\_anim::anim_loop_solo(param_00[0],var_02,param_01);
	}
	else if(param_00[0].script_noteworthy == "seated")
	{
		var_03 = randomint(100);
		if(var_03 < 33)
		{
			var_02 = "seated_1";
		}
		else if(var_02 < 66)
		{
			var_02 = "seated_2";
		}
		else
		{
			var_02 = "seated_3";
		}

		param_00[0] thread maps\_anim::anim_loop_solo(param_00[0],var_02,param_01);
	}
	else if(param_00[0].script_noteworthy == "paired")
	{
		if(randomint(100) < 50)
		{
			var_02 = "paired_1";
		}
		else
		{
			var_02 = "paired_2";
		}

		param_00[0] thread maps\_anim::anim_loop(param_00,var_02,param_01);
	}
	else
	{
	}

	level thread civilian_clean_up(param_00,param_01);
}

//Function Number: 42
civilian_clean_up(param_00,param_01)
{
	level waittill(param_01);
	wait(1);
	foreach(var_03 in param_00)
	{
		if(isalive(var_03))
		{
			var_03 notify(param_01);
			var_03 delete();
		}
	}
}

//Function Number: 43
ignore_all_until_path_end()
{
	self endon("death");
	self.ignoreall = 1;
	self waittill("reached_path_end");
	self.ignoreall = 0;
}

//Function Number: 44
delete_civilian_at_trigger()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00.team == "neutral")
		{
			var_00 delete();
		}

		wait(0.1);
	}
}

//Function Number: 45
start_vehicle_traffic_highway_traverse()
{
	var_00 = getvehiclenodearray("highway_path_player_side_1","targetname");
	foreach(var_02 in var_00)
	{
		var_02.do_pathbased_avoidance = 1;
		var_02.dont_spawn_over_obstacles = 1;
		var_02.lagoshack = 1;
		var_02.vehicle_easy_crash_die = 1;
	}

	maps\_vehicle_traffic::mark_nodes_near_spawnnodes_and_startnodes("highway_path_player_side_1");
	maps\_vehicle_traffic::traffic_set_traffic_tuning_lagos_highway();
	wait(0.25);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("highway_path_other_side","highway_damageable_vehicle_spawner",1,level.player,10,1,1);
	thread start_vehicle_traffic_highway_traverse_player_side();
}

//Function Number: 46
start_vehicle_traffic_highway_traverse_player_side()
{
	if(common_scripts\utility::flag("flag_player_jump2"))
	{
		return;
	}

	change_spawn_chance_highway_path_player_side(["1","2","3","4"],100);
	change_spawn_dist_highway_path_player_side(["1","2","3","4"],4000);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("highway_path_player_side","highway_damageable_vehicle_spawner",1,level.player,20,1,1,0);
	common_scripts\utility::flag_wait("flag_highway_ledge_climb_started");
	thread maps\lagos_code::destroy_all_frogger_vehicles_lane(1);
	thread maps\lagos_code::destroy_all_frogger_vehicles_lane(2);
	thread maps\lagos_code::destroy_all_frogger_vehicles_lane(3);
	thread maps\lagos_code::destroy_all_frogger_vehicles_lane(4);
	if(level.currentgen)
	{
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(5);
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(6);
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(7);
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(8);
	}

	set_force_script_models_highway_path_player_side(["1","2","3","4"],0);
	common_scripts\utility::delay_script_call(0,::disable_highway_path_player_side,["1"]);
	common_scripts\utility::delay_script_call(5,::disable_highway_path_player_side,["3"]);
	common_scripts\utility::delay_script_call(7,::enable_highway_path_player_side,["1"]);
	level.player waittill("traffic_traverse_start_player");
	if(level.nextgen)
	{
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(5);
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(6);
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(7);
		thread maps\lagos_code::destroy_all_frogger_vehicles_lane(8);
	}

	change_spawn_dist_highway_path_player_side(["1","2","3","4"],2600);
	wait(2);
	change_spawn_dist_highway_path_player_side(["1","2","3","4"],10000);
	change_spawn_chance_highway_path_player_side(["1","2","3","4"],10);
}

//Function Number: 47
start_middle_takedown_highway_path_player_side()
{
	delete_highway_player_side();
}

//Function Number: 48
post_middle_takedown_highway_path_player_side()
{
	if(!isdefined(level.post_middle_takedown_traffic_done))
	{
		level.post_middle_takedown_traffic_done = 1;
	}
	else
	{
		return;
	}

	wait 0.05;
	reset_highway_path_player_side(["2","3","4"],10,8000);
	wait(2);
	enable_highway_path_player_side(["1"]);
}

//Function Number: 49
start_end_takedown_highway_path_player_side()
{
	if(!isdefined(level.start_end_takedown_traffic_done))
	{
		level.start_end_takedown_traffic_done = 1;
	}
	else
	{
		return;
	}

	delete_highway_player_side();
}

//Function Number: 50
set_force_script_models_highway_path_player_side(param_00,param_01)
{
	var_02 = getvehiclenodearray("highway_path_player_side_1","targetname");
	foreach(var_04 in var_02)
	{
		foreach(var_06 in param_00)
		{
			if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == var_06)
			{
				var_04.traffic_force_script_models_only = param_01;
			}
		}
	}
}

//Function Number: 51
enable_highway_path_player_side(param_00,param_01)
{
	disable_highway_path_player_side(param_00,0);
}

//Function Number: 52
disable_highway_path_player_side(param_00,param_01)
{
	var_02 = getvehiclenodearray("highway_path_player_side_1","targetname");
	foreach(var_04 in var_02)
	{
		foreach(var_06 in param_00)
		{
			if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == var_06)
			{
				if(!isdefined(param_01) || param_01)
				{
					var_04.nospawn = 1;
					continue;
				}

				var_04.nospawn = 0;
			}
		}
	}
}

//Function Number: 53
change_spawn_dist_highway_path_player_side(param_00,param_01)
{
	var_02 = getvehiclenodearray("highway_path_player_side_1","targetname");
	foreach(var_04 in var_02)
	{
		foreach(var_06 in param_00)
		{
			if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == var_06)
			{
				if(isdefined(param_01))
				{
					var_04.despawn_dist_sq = float(param_01) * float(param_01);
				}
			}
		}
	}
}

//Function Number: 54
change_spawn_chance_highway_path_player_side(param_00,param_01)
{
	var_02 = getvehiclenodearray("highway_path_player_side_1","targetname");
	foreach(var_04 in var_02)
	{
		foreach(var_06 in param_00)
		{
			if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == var_06)
			{
				if(isdefined(param_01))
				{
					var_04.spawn_chance_override = param_01;
				}
			}
		}
	}
}

//Function Number: 55
reset_highway_path_player_side(param_00,param_01,param_02,param_03)
{
	delete_highway_player_side();
	var_04 = undefined;
	var_05 = getvehiclenodearray("highway_path_player_side_1","targetname");
	foreach(var_07 in var_05)
	{
		var_07.nospawn = 1;
		var_07.despawn_dist_sq = float(param_02) * float(param_02);
	}

	foreach(var_07 in var_05)
	{
		foreach(var_0B in param_00)
		{
			if(isdefined(var_07.script_noteworthy) && var_07.script_noteworthy == var_0B)
			{
				var_07.nospawn = 0;
				if(isdefined(param_01))
				{
					var_07.spawn_chance_override = param_01;
				}
			}
		}
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	level.traffic_tune_no_spawn = undefined;
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("highway_path_player_side","highway_damageable_vehicle_spawner",1,level.player,20,1,param_03,0,var_04);
}

//Function Number: 56
delete_highway_player_side()
{
	level.traffic_tune_no_spawn = "highway_path_player_side";
	thread maps\_vehicle_traffic::delete_traffic_path("highway_path_player_side");
}

//Function Number: 57
start_vehicle_traffic_roundabout_straightways()
{
	wait(0.25);
	maps\_vehicle_traffic::traffic_set_traffic_tuning(1);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("east_lane_inner","roundabout_damageable_vehicle_spawner",1,undefined,10,1,1);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("east_lane_outer","roundabout_damageable_vehicle_spawner",1,undefined,10,1,1);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("east_lane_split","roundabout_damageable_vehicle_spawner",0,undefined,10,1,1);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("west_lane","roundabout_damageable_vehicle_spawner",1,undefined,10,1,1);
	thread maps\_vehicle_traffic::setup_traffic_path_with_options("highway_westward","roundabout_damageable_vehicle_spawner",1,undefined,10,1,1);
	thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam("west_lane");
	thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam("highway_westward");
	thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam("west_lane");
	thread maps\_vehicle_traffic::traffic_path_head_car_traffic_jam("east_lane_outer");
}

//Function Number: 58
resume_vehicle_traffic_roundabout_straightways()
{
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_inner",0);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_outer",0);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_split",0);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("west_lane",0);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("highway_westward",0);
	var_00 = getvehiclenode("pf2_auto4204","targetname");
	var_00.is_blockage = undefined;
	var_00 = getvehiclenode("pf2_auto4205","targetname");
	var_00.is_blockage = undefined;
	var_01 = 0;
}

//Function Number: 59
delete_vehicle_traffic_roundabout_straightways()
{
	thread maps\_vehicle_traffic::delete_traffic_path("east_lane_inner");
	thread maps\_vehicle_traffic::delete_traffic_path("east_lane_outer");
	thread maps\_vehicle_traffic::delete_traffic_path("east_lane_split");
	thread maps\_vehicle_traffic::delete_traffic_path("west_lane");
	thread maps\_vehicle_traffic::delete_traffic_path("highway_westward");
	var_00 = getvehiclenode("pf2_auto4204","targetname");
	var_00.is_blockage = undefined;
	var_00 = getvehiclenode("pf2_auto4205","targetname");
	var_00.is_blockage = undefined;
}

//Function Number: 60
stop_vehicle_traffic_roundabout_straightways()
{
	var_00 = getvehiclenode("east_lane_inner_1","targetname");
	var_01 = getvehiclenode("east_lane_outer_1","targetname");
	var_00 notify("stop_traffic_lane");
	var_01 notify("stop_traffic_lane");
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("west_lane",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("highway_westward",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_inner",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_outer",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_split",1);
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4204");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4205");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4206");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4207");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4208");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4209");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4196");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4197");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4198");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4199");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_split","pf2_highway_path_1");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_split","pf2_auto4232");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4200");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4202");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_inner","pf2_auto4210");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4201");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4203");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_outer","pf2_auto4211");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_split","pf2_auto4233");
	thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker("west_lane","pf2_auto4083");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("west_lane","pf2_auto4077");
	thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker("west_lane","pf2_auto4071");
	thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker("west_lane","pf2_auto4090");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("west_lane","pf2_auto4084");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("west_lane","pf2_auto4078");
	thread maps\_vehicle_traffic::traffic_path_set_cars_at_node_ai_path_blocker("west_lane","pf2_auto4072");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_split","pf2_auto4230");
	thread maps\_vehicle_traffic::traffic_path_remove_cars_at_node("east_lane_split","pf2_auto4231");
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_inner",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_outer",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("east_lane_split",1);
	thread maps\_vehicle_traffic::traffic_path_all_cars_set_force_stop("west_lane",1);
}

//Function Number: 61
rumble_flydrone_animation()
{
	wait(0.75);
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.08);
	common_scripts\utility::flag_wait("drone_fly_anim_done");
	wait(2.5);
	var_00 stoprumble("steady_rumble");
	var_00 delete();
}

//Function Number: 62
rumble_flydrone_control()
{
	if(common_scripts\utility::flag("intro_playerstart"))
	{
		return;
	}

	level.fly_drone_rumbling = 1;
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.08);
	level waittill("fly_drone_not_moving");
	var_00 stoprumble("steady_rumble");
	var_00 delete();
	level.fly_drone_rumbling = 0;
}

//Function Number: 63
rumble_roundabout_rpg_car_hit()
{
	if(distance(self.origin,level.player.origin) > 500)
	{
		return;
	}

	if(distance(self.origin,level.player.origin) <= 500 && distance(self.origin,level.player.origin) >= 250)
	{
		level.player playrumbleonentity("damage_heavy");
		earthquake(0.5,0.75,level.player.origin,1000);
		return;
	}

	if(distance(self.origin,level.player.origin) < 250)
	{
		level.player playrumbleonentity("artillery_rumble");
		earthquake(1,0.75,level.player.origin,1000);
		return;
	}
}

//Function Number: 64
rumble_roundabout_tanker()
{
	var_00 = getent("magicOrg_roundabout_tanker_dest","targetname");
	if(distance(var_00.origin,level.player.origin) > 1750)
	{
		return;
	}

	if(distance(var_00.origin,level.player.origin) <= 1750 && distance(var_00.origin,level.player.origin) >= 1200)
	{
		level.player playrumbleonentity("damage_heavy");
		return;
	}

	if(distance(var_00.origin,level.player.origin) < 1200)
	{
		level.player playrumbleonentity("artillery_rumble");
		return;
	}
}

//Function Number: 65
rumble_frogger_vehicles()
{
	var_00 = level.player maps\_utility::get_rumble_ent("heavy_1s");
	var_00 maps\_utility::set_rumble_intensity(0.01);
	var_00 maps\_utility::rumble_ramp_to(1,0.5);
	wait(0.5);
	var_00 stoprumble("heavy_1s");
	var_00 delete();
}

//Function Number: 66
disable_exo_for_highway()
{
	maps\_player_exo::player_exo_remove_single("boost_dash");
}

//Function Number: 67
challenge_point_award()
{
	if(isdefined(self.damagelocation) && issubstr(self.damagelocation,"head"))
	{
		level.player maps\_upgrade_challenge::give_player_challenge_headshot(1);
		return;
	}

	level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
}

//Function Number: 68
challenge_point_award_on_damage()
{
	self waittill("damage");
	challenge_point_award();
}

//Function Number: 69
hint_instant(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = 0.5;
	level endon("clearing_hints");
	if(isdefined(level.hintelement))
	{
		level.hintelement maps\_hud_util::destroyelem();
	}

	level.hintelement = maps\_hud_util::createfontstring("default",1.5);
	level.hintelement maps\_hud_util::setpoint("MIDDLE",undefined,0,30 + param_02);
	level.hintelement.color = (1,1,1);
	level.hintelement settext(param_00);
	level.hintelement.alpha = 0;
	level.hintelement.alpha = 1;
	wait(0.5);
	level.hintelement endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		return;
	}

	level.hintelement fadeovertime(var_03);
	level.hintelement.alpha = 0;
	wait(var_03);
	level.hintelement maps\_hud_util::destroyelem();
}

//Function Number: 70
hint_fade_instant()
{
	if(isdefined(level.hintelement))
	{
		level notify("clearing_hints");
		level.hintelement.alpha = 0;
	}
}

//Function Number: 71
ignore_until_goal_reached()
{
	self.ignoreall = 1;
	common_scripts\utility::waittill_notify_or_timeout("goal",5);
	if(isdefined(self) && isalive(self))
	{
		self.ignoreall = 0;
	}
}

//Function Number: 72
ignore_until_timeout(param_00)
{
	self.ignoreme = 1;
	wait(param_00);
	if(isdefined(self) && isalive(self))
	{
		self.ignoreme = 0;
	}
}

//Function Number: 73
lagos_custom_laser()
{
	thread animscripts\utility::follow_enemy_with_laser(self,"lag_snipper_laser");
}

//Function Number: 74
spawn_wave_upkeep_and_flag(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	while(!common_scripts\utility::flag(param_01))
	{
		param_00 = maps\_utility::array_removedead_or_dying(param_00);
		if(param_00.size <= param_02)
		{
			wait(param_03);
			common_scripts\utility::flag_set(param_01);
		}

		wait 0.05;
	}
}

//Function Number: 75
spawn_wave_upkeep_and_block(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(;;)
	{
		param_00 = maps\_utility::array_removedead_or_dying(param_00);
		if(param_00.size <= param_01)
		{
			wait(param_02);
			return;
		}

		wait 0.05;
	}
}

//Function Number: 76
kill_after_timeout(param_00,param_01,param_02)
{
	wait(param_01);
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04) && isalive(var_04))
		{
			var_04 kill();
			if(isdefined(param_02) && param_02)
			{
				wait(randomfloatrange(0.75,1.25));
			}
		}
	}
}

//Function Number: 77
timeout_and_flag(param_00,param_01)
{
	wait(param_01);
	if(!common_scripts\utility::flag(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 78
notify_on_flag(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_01);
	self notify(param_00);
}

//Function Number: 79
vehicle_unload_how_at_end(param_00)
{
	self waittill("reached_end_node");
	if(isdefined(param_00))
	{
		maps\_vehicle::vehicle_unload(param_00);
		return;
	}

	maps\_vehicle::vehicle_unload();
}

//Function Number: 80
delete_after_wait(param_00,param_01)
{
	wait(param_01);
	param_00 delete();
}

//Function Number: 81
equip_microwave_grenade()
{
	self.grenadeweapon = "microwave_grenade";
	self.grenadeammo = 2;
}

//Function Number: 82
immune_sonic_blast()
{
	self.ignoresonicaoe = 1;
}

//Function Number: 83
setup_ai_for_bus_sequence()
{
	self allowedstances("stand");
	self.a.disablepain = 1;
	self.dontavoidplayer = 1;
	self.nododgemove = 1;
	self.badplaceawareness = 0;
	self.dontmelee = 1;
	self.doorflashchance = 0.05;
	self.aggressivemode = 1;
	self.ignoresuppression = 1;
	self.no_pistol_switch = 1;
	self.norunngun = 1;
	self.disablebulletwhizbyreaction = 1;
	self.nogrenadereturnthrow = 1;
	var_00 = self.grenadeawareness;
	self.grenadeawareness = 0;
}

//Function Number: 84
disable_awareness()
{
	self.ignoreall = 1;
	self.dontmelee = 1;
	self.ignoresuppression = 1;
	self.suppressionwait_old = self.suppressionwait;
	self.suppressionwait = 0;
	maps\_utility::disable_surprise();
	self.ignorerandombulletdamage = 1;
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_pain();
	self.grenadeawareness = 0;
	maps\_utility::enable_dontevershoot();
	self.disablefriendlyfirereaction = 1;
	self.dodangerreact = 0;
}

//Function Number: 85
enable_awareness()
{
	self.ignoreall = 0;
	self.dontmelee = undefined;
	self.ignoresuppression = 0;
	if(isdefined(self.suppressionwait_old))
	{
		self.suppressionwait = self.suppressionwait_old;
	}

	self.suppressionwait_old = undefined;
	maps\_utility::enable_surprise();
	self.ignorerandombulletdamage = 0;
	maps\_utility::enable_bulletwhizbyreaction();
	maps\_utility::enable_pain();
	self.grenadeawareness = 1;
	self.ignoreme = 0;
	maps\_utility::disable_dontevershoot();
	self.disablefriendlyfirereaction = undefined;
	self.dodangerreact = 1;
}

//Function Number: 86
fake_linkto(param_00,param_01,param_02,param_03)
{
	thread fake_linkto_internal(param_00,param_01,param_02,param_03);
}

//Function Number: 87
fake_linkto_internal(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_00 endon("death");
	self notify("fake_unlink");
	self endon("fake_unlink");
	if(!isdefined(param_02) || !isdefined(param_03))
	{
		if(isdefined(param_01))
		{
			var_04 = param_00 gettagorigin(param_01);
			var_05 = param_00 gettagangles(param_01);
		}
		else
		{
			var_04 = param_02.origin;
			var_05 = param_01.angles;
		}

		var_06 = transformmove((0,0,0),(0,0,0),var_04,var_05,self.origin,self.angles);
		param_02 = var_06["origin"];
		param_03 = var_06["angles"];
	}

	for(;;)
	{
		if(isdefined(param_01))
		{
			var_04 = param_00 gettagorigin(param_01);
			var_05 = param_00 gettagangles(param_01);
		}
		else
		{
			var_04 = param_00.origin;
			var_05 = param_00.angles;
		}

		var_06 = transformmove(var_04,var_05,(0,0,0),(0,0,0),param_02,param_03);
		self.origin = var_06["origin"];
		self.angles = var_06["angles"];
		wait 0.05;
	}
}

//Function Number: 88
fake_unlink()
{
	self notify("fake_unlink");
}

//Function Number: 89
magic_threat_grenade(param_00,param_01,param_02)
{
	var_03 = magicgrenade("paint_grenade_var",param_00.origin,param_01.origin,param_02);
	if(isdefined(var_03))
	{
		var_03 thread maps\_variable_grenade::detection_grenade_think(level.player);
	}
}

//Function Number: 90
boost_jump_toggle()
{
	level.player notifyonplayercommand("use_boost_jump","+actionslot 1");
	for(;;)
	{
		level.player waittill("use_boost_jump");
		level.player maps\_player_high_jump::enable_high_jump();
		level.player maps\_utility::blend_movespeedscale_percent(150,1);
		level.player waittill("use_boost_jump");
		level.player maps\_player_high_jump::disable_high_jump();
		level.player maps\_utility::blend_movespeedscale_percent(100,1);
	}
}

//Function Number: 91
ally_redirect_goto_node(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = undefined;
	foreach(var_0A in level.alpha_squad)
	{
		if(isdefined(var_0A.script_friendname) && var_0A.script_friendname == param_00)
		{
			var_08 = var_0A;
		}
	}

	var_0C = getnode(param_01,"targetname");
	if(isdefined(var_08.node))
	{
		var_08.node maps\_utility::script_delay();
	}

	var_08 maps\_utility::enable_ai_color();
	var_08 maps\_utility::set_goal_node(var_0C);
	if(isdefined(param_03))
	{
		var_08 thread exec_function(param_02,param_03,param_04,param_05,param_06,param_07);
	}
}

//Function Number: 92
exec_function(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	if(isdefined(param_05))
	{
		var_06 = 4;
	}
	else if(isdefined(param_04))
	{
		var_06 = 3;
	}
	else if(isdefined(param_03))
	{
		var_06 = 2;
	}
	else if(isdefined(param_02))
	{
		var_06 = 1;
	}

	if(param_00 == 1)
	{
		switch(var_06)
		{
			case 0:
				thread [[ param_01 ]]();
				break;

			case 1:
				thread [[ param_01 ]](param_02);
				break;

			case 2:
				thread [[ param_01 ]](param_02,param_03);
				break;

			case 3:
				thread [[ param_01 ]](param_02,param_03,param_04);
				break;

			case 4:
				thread [[ param_01 ]](param_02,param_03,param_04,param_05);
				break;
		}

		return;
	}

	switch(var_06)
	{
		case 0:
			[[ param_01 ]]();
			break;

		case 1:
			[[ param_01 ]](param_02);
			break;

		case 2:
			[[ param_01 ]](param_02,param_03);
			break;

		case 3:
			[[ param_01 ]](param_02,param_03,param_04);
			break;

		case 4:
			[[ param_01 ]](param_02,param_03,param_04,param_05);
			break;
	}
}

//Function Number: 93
assign_goal_vol(param_00,param_01)
{
	if(isdefined(self))
	{
		var_02 = getent(param_00,"targetname");
		self setgoalvolumeauto(var_02);
		if(isdefined(param_01))
		{
			self.goalradius = param_01;
		}
	}
}

//Function Number: 94
assign_goal_node(param_00,param_01)
{
	if(isdefined(self))
	{
		var_02 = getnode(param_00,"targetname");
		self setgoalnode(var_02);
		if(isdefined(param_01))
		{
			self.goalradius = param_01;
		}
	}
}

//Function Number: 95
setupenemygoalvolumesettings(param_00,param_01)
{
	param_00 = common_scripts\utility::array_randomize(param_00);
	if(level.player istouching(param_00[0]))
	{
		self setgoalvolumeauto(param_00[1]);
		wait 0.05;
		if(isdefined(param_01))
		{
			self.goalradius = param_01;
			return;
		}

		return;
	}

	self setgoalvolumeauto(param_00[0]);
	wait 0.05;
	if(isdefined(param_01))
	{
		self.goalradius = param_01;
	}
}

//Function Number: 96
ally_move_dynamic_speed()
{
	self notify("start_dynamic_run_speed");
	self endon("death");
	self endon("stop_dynamic_run_speed");
	self endon("start_dynamic_run_speed");
	if(maps\_utility::ent_flag_exist("_stealth_custom_anim"))
	{
		maps\_utility::ent_flag_waitopen("_stealth_custom_anim");
	}

	self.run_speed_state = "";
	ally_reset_dynamic_speed();
	var_00 = 144;
	var_01 = ["sprint","run"];
	var_02 = [];
	var_02["player_sprint"]["sprint"][0] = 225 * var_00;
	var_02["player_sprint"]["sprint"][1] = 900 * var_00;
	var_02["player_sprint"]["run"][0] = 900 * var_00;
	var_02["player_sprint"]["run"][1] = 900 * var_00;
	var_02["player_run"]["sprint"][0] = 225 * var_00;
	var_02["player_run"]["sprint"][1] = 400 * var_00;
	var_02["player_run"]["run"][0] = 400 * var_00;
	var_02["player_run"]["run"][1] = 625 * var_00;
	var_02["player_crouch"]["run"][0] = 4 * var_00;
	var_02["player_crouch"]["run"][1] = 100 * var_00;
	var_03 = 123;
	var_04 = 189;
	var_05 = 283;
	for(;;)
	{
		wait(0.2);
		if(isdefined(self.force_run_speed_state))
		{
			ally_dynamic_run_set(self.force_run_speed_state);
			continue;
		}

		var_06 = vectornormalize(anglestoforward(self.angles));
		var_07 = vectornormalize(self.origin - level.player.origin);
		var_08 = vectordot(var_06,var_07);
		var_09 = distancesquared(self.origin,level.player.origin);
		if(isdefined(self.cqbwalking) && self.cqbwalking)
		{
			self.moveplaybackrate = 1;
		}

		if(common_scripts\utility::flag_exist("_stealth_spotted") && common_scripts\utility::flag("_stealth_spotted"))
		{
			ally_dynamic_run_set("run");
			continue;
		}

		if(var_08 < -0.25 && var_09 > 225 * var_00)
		{
			ally_dynamic_run_set("sprint");
			continue;
		}

		ally_dynamic_run_set("cqb");
	}
}

//Function Number: 97
ally_stop_dynamic_speed()
{
	self endon("death");
	self notify("stop_dynamic_run_speed");
	ally_reset_dynamic_speed();
}

//Function Number: 98
ally_reset_dynamic_speed()
{
	self endon("death");
	maps\_utility::disable_cqbwalk();
	self.moveplaybackrate = 1;
	maps\_utility::clear_run_anim();
	self notify("stop_loop");
}

//Function Number: 99
ally_dynamic_run_set(param_00)
{
	if(self.run_speed_state == param_00)
	{
		return;
	}

	self.run_speed_state = param_00;
	switch(param_00)
	{
		case "sprint":
			if(isdefined(self.cqbwalking) && self.cqbwalking)
			{
				self.moveplaybackrate = 1;
			}
			else
			{
				self.moveplaybackrate = 1;
			}
	
			maps\_utility::set_generic_run_anim("DRS_sprint");
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "run":
			self.moveplaybackrate = 1;
			maps\_utility::clear_run_anim();
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "jog":
			self.moveplaybackrate = 1;
			maps\_utility::set_generic_run_anim("DRS_combat_jog");
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "cqb":
			self.moveplaybackrate = 1;
			maps\_utility::enable_cqbwalk();
			self notify("stop_loop");
			break;
	}
}

//Function Number: 100
right_swing_pressed()
{
	if(level.console || level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		return level.player attackbuttonpressed();
	}

	return level.player buttonpressed("mouse2");
}

//Function Number: 101
left_swing_pressed()
{
	var_00 = "BUTTON_LTRIG";
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		var_00 = "mouse1";
	}

	return level.player buttonpressed(var_00);
}

//Function Number: 102
break_left_climb_hint()
{
	if(isdefined(level.player.waiting_on_left_swing) && level.player.waiting_on_left_swing == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 103
break_right_climb_hint()
{
	if(isdefined(level.player.waiting_on_right_swing) && level.player.waiting_on_right_swing == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 104
wait_until_right_swing_pressed()
{
	level.player.waiting_on_right_swing = 1;
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = level.player geteye() + anglestoforward(level.player getgunangles()) * 12 + anglestoright(level.player getgunangles()) * 6;
	var_00.angles = level.player.angles + (0,180,0);
	var_01 = display_hint_button(&"LAGOS_PRESS_CLIMB_RIGHT",var_00,"tag_origin",0);
	for(;;)
	{
		if(right_swing_pressed() && level.player.left_swing_released == 1)
		{
			level.player.waiting_on_right_swing = 0;
			clear_hint_button(var_01);
			soundscripts\_snd::snd_message("exo_climb_right_swing_pressed");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 105
wait_until_left_swing_pressed()
{
	level.player.waiting_on_left_swing = 1;
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = level.player geteye() + anglestoforward(level.player getgunangles()) * 12 - anglestoright(level.player getgunangles()) * 6;
	var_00.angles = level.player.angles + (0,180,0);
	var_01 = display_hint_button(&"LAGOS_PRESS_CLIMB_LEFT",var_00,"tag_origin",0);
	for(;;)
	{
		if(left_swing_pressed() && level.player.right_swing_released == 1)
		{
			level.player.waiting_on_left_swing = 0;
			clear_hint_button(var_01);
			var_00 delete();
			soundscripts\_snd::snd_message("exo_climb_left_swing_pressed");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 106
wait_until_next_right_swing()
{
	level.player.waiting_on_right_swing = 1;
	maps\_utility::display_hint_timeout("right_climb_hint",5);
	for(;;)
	{
		if(isdefined(level.player.right_swing_released) && level.player.right_swing_released == 1 && right_swing_pressed())
		{
			level.player.waiting_on_right_swing = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 107
wait_until_next_left_swing()
{
	level.player.waiting_on_left_swing = 1;
	maps\_utility::display_hint_timeout("left_climb_hint",5);
	for(;;)
	{
		if(isdefined(level.player.left_swing_released) && level.player.left_swing_released == 1 && left_swing_pressed())
		{
			level.player.waiting_on_left_swing = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 108
monitor_right_swing_released()
{
	level.player.right_swing_released = 0;
	for(;;)
	{
		if(!right_swing_pressed())
		{
			level.player.right_swing_released = 1;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 109
monitor_left_swing_released()
{
	level.player.left_swing_released = 0;
	for(;;)
	{
		if(!left_swing_pressed())
		{
			level.player.left_swing_released = 1;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 110
player_climb_wall_head_sway()
{
	level endon("stop_player_cam_sway");
	for(;;)
	{
		screenshake(level.player.origin,7,9,4,2,0.2,0.2,0,0.3,0.375,0.225);
		wait(1);
	}
}

//Function Number: 111
hint_string_disable_exo_door()
{
	if(level.player usebuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 112
hint_string_disable_exo_climb()
{
	if(level.player usebuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 113
hint_string_disable_mute_charge()
{
	if(level.player usebuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 114
hint_string_disable_place_sensor()
{
	if(level.player usebuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 115
display_hint_button(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(level.player);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.fontscale = 3;
	var_04.positioninworld = 1;
	if(isdefined(param_01))
	{
		if(isdefined(param_02))
		{
			var_04 settargetent(param_01,param_02);
		}
		else
		{
			var_04 settargetent(param_01);
		}
	}

	var_04 settext(param_00);
	var_04.hidewheninmenu = 1;
	var_04.sort = -1;
	var_04.alpha = 1;
	level.player.hint_button = var_04;
	var_04 thread scale_3d_hud_elem(param_01,param_02,level.player,param_03);
	return var_04;
}

//Function Number: 116
scale_3d_hud_elem(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_03))
	{
		param_03 = 40;
	}

	for(;;)
	{
		var_04 = distance(param_00 gettagorigin(param_01),param_02 geteye());
		self.fontscale = maps\_shg_utility::linear_map_clamp(var_04,16,1024,2.5,1.5);
		if(param_03 != 0 && var_04 > param_03)
		{
			self.alpha = 0.3;
		}
		else
		{
			self.alpha = 1;
		}

		wait 0.05;
	}
}

//Function Number: 117
clear_hint_button(param_00)
{
	param_00 destroy();
}

//Function Number: 118
keep_filling_clip_ammo(param_00)
{
	self endon("death");
	while(!common_scripts\utility::flag("flag_bus_traverse_5_start_takedown"))
	{
		wait(param_00);
		if(isdefined(self.weapon) && !issubstr(self.weapon,"rpg"))
		{
			self.bulletsinclip = weaponclipsize(self.weapon);
		}
	}
}

//Function Number: 119
give_player_more_ammo(param_00)
{
	self endon("death");
	while(!common_scripts\utility::flag("flag_bus_traverse_5_start_takedown"))
	{
		wait(param_00);
		var_01 = self getcurrentweapon();
		if(isdefined(var_01) && !issubstr(var_01,"rpg"))
		{
			self givemaxammo(var_01);
		}
	}
}

//Function Number: 120
bloody_death(param_00,param_01)
{
	self endon("death");
	if(!issentient(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(self.bloody_death) && self.bloody_death)
	{
		return;
	}

	self.bloody_death = 1;
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	var_02 = [];
	var_02[0] = "j_hip_le";
	var_02[1] = "j_hip_ri";
	var_02[2] = "j_head";
	var_02[3] = "j_spine4";
	var_02[4] = "j_elbow_le";
	var_02[5] = "j_elbow_ri";
	var_02[6] = "j_clavicle_le";
	var_02[7] = "j_clavicle_ri";
	var_03 = getdvarint("cg_fov");
	for(var_04 = 0;var_04 < 3 + randomint(5);var_04++)
	{
		var_05 = randomintrange(0,var_02.size);
		thread bloody_death_fx(var_02[var_05],undefined);
		wait(randomfloat(0.1));
		if(isdefined(param_01) && isai(param_01) && isalive(param_01))
		{
			if(!level.player worldpointinreticle_circle(param_01.origin,var_03,500))
			{
				param_01 shootblank();
			}
		}
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 121
bloody_death_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 122
alley1_stage3_refill_think()
{
	self endon("death");
	var_00 = 256;
	var_01 = 512;
	level.alley1_kva = common_scripts\utility::array_add(level.alley1_kva,self);
	thread assign_goal_vol("alley1_stage3_vol1");
	maps\_utility::disable_long_death();
	equip_microwave_grenade();
	self setengagementmaxdist(var_00,var_01);
}

//Function Number: 123
handle_vehicle_death()
{
	thread vehicle_crash_when_driver_dies();
	thread vehicle_crash_on_death();
}

//Function Number: 124
vehicle_crash_when_driver_dies()
{
	self endon("death");
	self.vehicle_keeps_going_after_driver_dies = 1;
	var_00 = vehicle_get_driver();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 waittill("death");
	var_01 = undefined;
	if(isdefined(var_00))
	{
		var_01 = var_00.lastattacker;
	}

	vehicle_crash_now(var_01);
}

//Function Number: 125
vehicle_crash_on_death()
{
	self.vehicle_stays_alive = 1;
	while(self.health > 0)
	{
		self waittill("damage");
		waittillframeend;
		if(self.health < self.healthbuffer)
		{
			break;
		}
	}

	vehicle_crash_now(self.attacker);
}

//Function Number: 126
vehicle_crash_when_blocked()
{
	self endon("death");
	var_00 = 24;
	var_01 = 39;
	var_02 = 156;
	var_03 = undefined;
	for(;;)
	{
		var_04 = self localtoworldcoords((var_01,0,var_00));
		var_05 = self localtoworldcoords((var_02,0,var_00));
		var_06 = bullettrace(var_04,var_05,0,self);
		var_07 = var_06["entity"];
		if(isdefined(var_07))
		{
			if(var_07.code_classname == "script_model" || var_07.code_classname == "script_vehicle" && var_07.health <= 0)
			{
				var_03 = var_07.attacker;
				break;
			}
		}

		if(isdefined(self.vehicle_crashing_now))
		{
			return;
		}

		wait(0.5);
	}

	thread vehicle_crash_now(var_03);
}

//Function Number: 127
vehicle_crash_now(param_00)
{
	var_01 = 0.75;
	var_02 = 3;
	var_03 = 60;
	var_04 = 1.5;
	var_05 = 39;
	var_06 = 1.8;
	if(isdefined(self.vehicle_crashing_now))
	{
		return;
	}

	self.vehicle_crashing_now = 1;
	self notify("vehicle_crashing_now");
	soundscripts\_snd::snd_message("bus_chase_suv_lose_control");
	var_07 = vehicle_get_crash_struct(var_01,var_02,var_03,var_04);
	if(isdefined(var_07))
	{
		var_07.used = 1;
		var_08 = spawnstruct();
		var_08.crash_struct = var_07;
		var_08.vehicle = self;
		var_08.vehicle_to_crash_struct = var_08.crash_struct.origin - var_08.vehicle.origin;
		var_08.vehicle_to_crash_struct_dir = vectornormalize(var_08.vehicle_to_crash_struct);
		var_08.right_dir = anglestoright(common_scripts\utility::flat_angle(vectortoangles(var_08.vehicle_to_crash_struct_dir)));
		var_08.goal_pos = var_08.crash_struct.origin + vectornormalize(var_08.vehicle_to_crash_struct) * var_05;
		var_08.crash_speed_ips = max(self vehicle_getspeed() * 17.6 * var_04,1);
		var_08.crash_speed_mph = var_08.crash_speed_ips / 17.6;
		var_08.wait_time = length(var_08.vehicle_to_crash_struct) / var_08.crash_speed_ips * var_06;
		thread vehicle_crazy_steering(var_08);
		vehicle_wait_for_crash(var_08);
	}
	else
	{
	}

	self.vehicle_stays_alive = undefined;
	if(isdefined(param_00))
	{
		self dodamage(self.health + 2000,self.origin,param_00,self);
		return;
	}

	self dodamage(self.health + 2000,self.origin);
}

//Function Number: 128
vehicle_get_driver()
{
	foreach(var_01 in self.attachedguys)
	{
		if(isdefined(var_01.drivingvehicle) && var_01.drivingvehicle)
		{
			return var_01;
		}
	}
}

//Function Number: 129
vehicle_get_crash_struct(param_00,param_01,param_02,param_03)
{
	var_04 = self vehicle_getspeed() * 17.6 * param_03;
	var_05 = squared(var_04 * param_00);
	var_06 = squared(var_04 * param_01);
	var_07 = cos(param_02);
	var_08 = sortbydistance(common_scripts\utility::getstructarray("vehicle_crash_struct","script_noteworthy"),self.origin);
	foreach(var_0A in var_08)
	{
		var_0B = distancesquared(var_0A.origin,self.origin);
		if(var_0B < var_05)
		{
			continue;
		}

		if(var_0B > var_06)
		{
			break;
		}

		if(isdefined(var_0A.used))
		{
			continue;
		}

		if(vectordot(vectornormalize(var_0A.origin - self.origin),anglestoforward(self.angles)) < var_07)
		{
			continue;
		}

		return var_0A;
	}

	return undefined;
}

//Function Number: 130
vehicle_wait_for_crash(param_00)
{
	thread maps\_utility::notify_delay("max_time",param_00.wait_time);
	thread vehicle_detect_crash(param_00);
	var_01 = common_scripts\utility::waittill_any_return("max_time","veh_collision","script_vehicle_collision","detect_crash");
	if(!isdefined(var_01))
	{
		var_01 = "unknown";
	}

	self notify("stop_vehicle_detect_crash");
}

//Function Number: 131
vehicle_detect_crash(param_00)
{
	self endon("stop_vehicle_detect_crash");
	waittillframeend;
	var_01 = squared(234);
	if(isdefined(level.vehicle_death_radiusdamage[self.classname]) && isdefined(level.vehicle_death_radiusdamage[self.classname].range))
	{
		var_01 = squared(level.vehicle_death_radiusdamage[self.classname].range * 0.75);
	}

	for(;;)
	{
		if(abs(angleclamp180(self.angles[0])) > 30 || abs(angleclamp180(self.angles[2])) > 30)
		{
			break;
		}

		if(distancesquared(self.origin,level.player.origin) < var_01)
		{
			break;
		}

		if(self vehicle_getspeed() / param_00.crash_speed_mph < 0.25)
		{
			break;
		}

		if(vectordot(param_00.goal_pos - self.origin,param_00.vehicle_to_crash_struct_dir) < 0)
		{
			break;
		}

		wait 0.05;
	}

	self notify("detect_crash");
	soundscripts\_snd::snd_message("bus_chase_suv_explode");
}

//Function Number: 132
vehicle_crazy_steering(param_00)
{
	var_01 = 20;
	var_02 = 4;
	var_03 = 195;
	var_04 = var_03 * tan(var_01);
	var_05 = self vehicle_getspeed();
	var_06 = 0;
	self endon("death");
	for(;;)
	{
		var_07 = 0;
		if(vectordot(param_00.crash_struct.origin - self.origin,param_00.right_dir) < 0)
		{
			var_07 = 1;
		}

		var_08 = randomfloat(var_04);
		if(var_07)
		{
			var_08 = var_08 * -1;
		}

		var_09 = self.origin + param_00.vehicle_to_crash_struct_dir * var_03 + param_00.right_dir * var_08;
		var_0A = clamp(var_06 / var_02,0,1);
		var_0B = maps\_utility::linear_interpolate(var_0A,var_05,param_00.crash_speed_mph);
		self vehicledriveto(var_09,param_00.crash_speed_mph);
		var_0C = randomfloatrange(0.05,0.2);
		var_06 = var_06 + var_0C;
		wait(var_0C);
	}
}

//Function Number: 133
vehicle_crazy_steering_frogger()
{
	var_00 = 10;
	var_01 = 4;
	var_02 = 195;
	var_03 = var_02 * tan(var_00);
	var_04 = self vehicle_getspeed();
	var_05 = 0;
	if(self.lane < 5)
	{
		var_06 = (30,-500,0);
	}
	else
	{
		var_06 = (30,500,0);
	}

	var_07 = self.origin + var_06;
	var_08 = vectornormalize(var_06);
	var_09 = anglestoright(common_scripts\utility::flat_angle(vectortoangles(var_08)));
	self.oldcontents = self setcontents(0);
	self endon("death");
	while(var_05 < 2)
	{
		var_0A = 0;
		if(vectordot(var_07 - self.origin,var_09) < 0)
		{
			var_0A = 1;
		}

		var_0B = randomfloat(var_03);
		if(var_0A)
		{
			var_0B = var_0B * -1;
		}

		var_0C = self.origin + var_08 * var_02 + var_09 * var_0B;
		self vehicledriveto(var_0C,30);
		var_0D = randomfloatrange(0.05,0.2);
		var_05 = var_05 + var_0D;
		wait(var_0D);
	}

	var_0E = getvehiclenode("frogger_lane_" + self.lane + "_mid","targetname");
	self vehicledriveto(var_0E.origin,70);
	wait(0.1);
	common_scripts\utility::delaycall(3,::setcontents,self.oldcontents);
	thread maps\_vehicle::vehicle_paths(var_0E);
	self startpath(var_0E);
}

//Function Number: 134
vehicle_crazy_steering_frogger_fail_check()
{
}

//Function Number: 135
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 136
play_cinematic(param_00,param_01,param_02)
{
	if(isdefined(level.current_cinematic))
	{
		pausecinematicingame(0);
		setsaveddvar("cg_cinematicFullScreen","1");
		level.current_cinematic = undefined;
	}
	else
	{
		cinematicingame(param_00);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","1");
	}

	wait(1);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","0");
	}
}

//Function Number: 137
ending_fade_out(param_00)
{
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	if(isdefined(param_00) && param_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(param_00);
		var_01.alpha = 1;
		wait(param_00);
	}

	wait(2);
	var_01 destroy();
}