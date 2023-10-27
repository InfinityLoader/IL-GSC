/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_final\cp_final_venomx_quest.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 146
 * Decompile Time: 7669 ms
 * Timestamp: 10/27/2023 12:05:41 AM
*******************************************************************/

//Function Number: 1
venomx_init()
{
	venomxquestregistration();
	initvenomxquestflags();
	level thread init_door_ent_model_update();
	level thread display_maze_hints_on_crt();
	level thread show_unsolved_mazes_on_crt();
	level thread init_tv_model_lines();
	level thread init_containment_pad_stuff();
}

//Function Number: 2
init_door_ent_model_update()
{
	var_00 = getent("fuse_box_door","script_noteworthy");
	var_00 setmodel("cp_final_ship_hallway_control_box_door");
}

//Function Number: 3
init_containment_pad_stuff()
{
	level.zomb_goal_containment_struct = scripts\common\utility::getstruct("zomb_goal_containment","script_noteworthy");
	level.containmentpadtop = getent("pad_top","script_noteworthy");
	level.openpositioncontainmenttop = (939.5,5620,264);
	level.closedpositioncontainmenttop = level.containmentpadtop.origin;
	level.containmentpadbottom = getent("pad_bottom","script_noteworthy");
	level.closedpositioncontainmentbottom = level.containmentpadbottom.origin;
	level.openpositioncontainmentbottom = (939.5,5620,-8);
	level.timeperiodmodel = getent("timeperiod_model","script_noteworthy");
	wait(10);
	level thread unblock_venomx_pad();
}

//Function Number: 4
unblock_venomx_pad()
{
	level.containmentpadtop moveto(level.openpositioncontainmenttop,0.2);
	level.containmentpadbottom moveto(level.openpositioncontainmentbottom,0.2);
	var_00 = getent("venomx_pad_blocker","script_noteworthy");
	var_00 notsolid();
	var_00 connectpaths();
	scripts\common\utility::play_sound_in_space("zmb_containment_pod_open",level.zomb_goal_containment_struct.origin);
	level.zombie_trap = getent("zombie_trap","script_noteworthy");
	level.zombie_trap hide();
}

//Function Number: 5
block_venomx_pad()
{
	level.containmentpadtop moveto(level.closedpositioncontainmenttop,0.2);
	level.containmentpadbottom moveto(level.closedpositioncontainmentbottom,0.2);
	var_00 = getent("venomx_pad_blocker","script_noteworthy");
	var_00 solid();
	var_00 disconnectpaths();
	scripts\common\utility::play_sound_in_space("zmb_containment_pod_close",level.zomb_goal_containment_struct.origin);
	level.zombie_trap show();
}

//Function Number: 6
movemodelwithdpad(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self notifyonplayercommand("pad_up","+actionslot 1");
	self notifyonplayercommand("pad_down","+actionslot 2");
	self notifyonplayercommand("pad_left","+actionslot 3");
	self notifyonplayercommand("pad_right","+actionslot 4");
	var_02 = "";
	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("pad_up","pad_down","pad_left","pad_right");
		if(!isdefined(var_02))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		switch(var_02)
		{
			case "pad_up":
				param_00 moveto(level.openpositioncontainmenttop,0.2);
				break;
	
			case "pad_down":
				param_01 moveto(level.openpositioncontainmentbottom,0.2);
				break;
	
			case "pad_left":
				param_00 moveto(level.closedpositioncontainmenttop,0.2);
				break;
	
			case "pad_right":
				param_01 moveto(level.closedpositioncontainmentbottom,0.2);
				break;
	
			default:
				wait(1);
				break;
		}
	}
}

//Function Number: 7
init_tv_model_lines()
{
	wait(5);
	var_00 = [];
	var_01 = [(1574,5393,157.5),(1574,5372.5,157.5),(1570.5,5393,137.5),(1570.5,5372.5,137.5),(1362,5372,157.5),(1362,5392.5,157.5),(1365.5,5372,137.5),(1365.5,5392.5,137.5),(408.174,5408.47,184.5),(393.678,5393.97,184.5),(405.699,5410.94,164.5),(391.203,5396.45,164.5),(511.5,4249.5,288.5),(532,4249.5,288.5),(511.5,4246,268.5),(532,4246,268.5)];
	var_02 = [(0,0,0),(0,0,0),(12,0,0),(12,0,0),(0,180,0),(0,180,0),(12,180,0),(12,180,0),(0,315,0),(0,315,0),(12,315,0),(12,315,0),(0,90,0),(0,90,0),(12,90,0),(12,90,0)];
	for(var_03 = 0;var_03 < 16;var_03++)
	{
		var_04 = spawn("script_model",var_01[var_03]);
		var_04 setmodel("tag_origin_venomx_puzzle");
		var_04.angles = var_02[var_03];
		var_04 setscriptablepartstate("solved_grid","neutral");
		level.array_of_small_crt_script_models[var_03] = var_04;
	}
}

//Function Number: 8
init_timer_texture()
{
	wait(10);
	level.timertexturearr = getentarray("venomx_timer","script_noteworthy");
	setomnvar("zombie_venomxTimer",666);
	foreach(var_01 in level.timertexturearr)
	{
		switch(var_01.name)
		{
			case "venomx_timer_01":
				var_01.origin = (865.5,5620,201);
				var_01.angles = (0,270,90);
				setomnvar("zm_ui_venomx_timer_ent_0",var_01);
				break;

			case "venomx_timer_02":
				var_01.origin = (939.5,5694,201);
				var_01.angles = (0,180,90);
				setomnvar("zm_ui_venomx_timer_ent_1",var_01);
				break;

			case "venomx_timer_03":
				var_01.origin = (939.5,5546,201);
				var_01.angles = (0,0,90);
				setomnvar("zm_ui_venomx_timer_ent_2",var_01);
				break;

			case "venomx_timer_04":
				var_01.origin = (1013.5,5620,201);
				var_01.angles = (0,90,90);
				setomnvar("zm_ui_venomx_timer_ent_3",var_01);
				break;
		}
	}
}

//Function Number: 9
move_venomx_locker_door(param_00)
{
	var_01 = getent("venomx_locker_door","script_noteworthy");
	if(param_00)
	{
		var_01 rotateto((0,105,0),0.1);
		return;
	}

	var_01 rotateto((0,315,0),0.1);
}

//Function Number: 10
setup_wire_models()
{
	level.number_of_wires = reroll_number_of_wires();
	level.wire_active_fx = spawnfx(level._effect["vfx_venmox_spark"],(812,4730,175));
	setup_wires(level.number_of_wires);
}

//Function Number: 11
setup_wires(param_00)
{
	level.wire_models = [];
	var_01 = scripts\common\utility::getstructarray("wire_puzzle_model","script_noteworthy");
	var_02 = ["red","blue","green","black","white","yellow"];
	var_03 = ["cp_final_control_box_button_01_red","cp_final_control_box_button_01_black","cp_final_control_box_button_01_blue","cp_final_control_box_button_01_green","cp_final_control_box_button_01_white","cp_final_control_box_button_01_yellow"];
	var_04 = [(813.5,4734.1,165.9),(813.5,4734.1,160.9),(813.5,4734.1,156.9),(813.5,4734.1,152.9),(813.5,4734.1,148.9),(813.5,4734.1,144.9)];
	for(var_05 = 0;var_05 < param_00;var_05++)
	{
		var_06 = scripts\common\utility::random(var_01);
		level.wire_models[var_05] = var_06;
		switch(var_06.name)
		{
			case "wire_puzzle_6":
			case "wire_puzzle_5":
			case "wire_puzzle_4":
			case "wire_puzzle_3":
			case "wire_puzzle_2":
			case "wire_puzzle_1":
				break;
		}

		level.wire_models[var_05].wire_num = var_05 + 1;
		var_07 = spawn("script_model",var_04[var_05]);
		var_08 = scripts\common\utility::random(var_03);
		var_07 setmodel(var_08);
		var_07.angles = (0,180,0);
		var_09 = strtok(var_08,"_");
		level.wire_models[var_05].model = var_07;
		level.wire_models[var_05].color = var_09[6];
		var_01 = scripts\common\utility::func_22A9(var_01,var_06);
	}
}

//Function Number: 12
setup_maze_models()
{
	level.unsolved_struct_positions_array = scripts\common\utility::getstructarray("unsolved_grid_start","script_noteworthy");
	foreach(var_01 in level.unsolved_struct_positions_array)
	{
		var_02 = strtok(var_01.name,"_");
		var_01.x_coord = int(var_02[3]);
		var_01.y_coord = int(var_02[4]);
	}

	level.test_model = spawn("script_model",level.unsolved_struct_positions_array[1].origin + (-1,0,0));
	level.test_model.mod_name = "maze1";
	level.test_model.angles = (340.8,269.6,-0.00136747);
	level.test_model setmodel("tag_origin_venomx_puzzle");
	level.test_model setscriptablepartstate("maze_puzzle","neutral");
	level.unsolved_struct_positions_array_2 = scripts\common\utility::getstructarray("unsolved_grid_start_2","script_noteworthy");
	foreach(var_05 in level.unsolved_struct_positions_array_2)
	{
		var_02 = strtok(var_05.name,"_");
		var_05.x_coord = int(var_02[3]);
		var_05.y_coord = int(var_02[4]);
	}

	level.test_model_2 = spawn("script_model",level.unsolved_struct_positions_array_2[1].origin + (-1,0,0));
	level.test_model_2.mod_name = "maze2";
	level.test_model_2.angles = (340.8,269.6,-0.00136747);
	level.test_model_2 setmodel("tag_origin_venomx_puzzle");
	level.test_model_2 setscriptablepartstate("maze_puzzle","neutral");
}

//Function Number: 13
start_maze_instance(param_00)
{
	level.test_model = spawn("script_model",level.unsolved_struct_positions_array[1].origin + (-1,0,0));
	level.test_model.mod_name = "maze1";
	level.test_model.angles = (340.099,270.085,0.00674522);
	level.test_model setmodel("tag_origin_venomx_puzzle");
	level.test_model setscriptablepartstate("maze_puzzle","neutral");
	level.test_model_2 = spawn("script_model",level.unsolved_struct_positions_array_2[1].origin + (-1,0,0));
	level.test_model_2.mod_name = "maze2";
	level.test_model_2.angles = (340.8,269.6,-0.00136747);
	level.test_model_2 setmodel("tag_origin_venomx_puzzle");
	level.test_model_2 setscriptablepartstate("maze_puzzle","neutral");
	level.test_model.newmodelsspawned = 1;
	level.test_model.othermodel = level.test_model_2;
	level.test_model_2.newmodelsspawned = 1;
	level.test_model_2.othermodel = level.test_model;
	level.maze_completed["maze1"] = 0;
	level.maze_completed["maze2"] = 0;
	createmaze(level.test_model,level.test_model_2,param_00);
}

//Function Number: 14
start_maze_instance_on_model(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_02.name == "unsolved_console_venomx")
	{
		var_03 = spawn("script_model",level.unsolved_struct_positions_array[1].origin + (-1,0,0));
		var_03.mod_name = "maze1";
		var_03.angles = (340.8,269.6,-0.00136747);
		var_03 setmodel("tag_origin_venomx_puzzle");
		var_03 setscriptablepartstate("maze_puzzle","neutral");
		level.test_model = var_03;
		level.test_model_2.othermodel = level.test_model;
	}
	else
	{
		var_03 = spawn("script_model",level.unsolved_struct_positions_array_2[1].origin + (-1,0,0));
		var_03.mod_name = "maze2";
		var_03.angles = (340.8,269.6,-0.00136747);
		var_03 setmodel("tag_origin_venomx_puzzle");
		var_03 setscriptablepartstate("maze_puzzle","neutral");
		level.test_model_2 = var_03;
		level.test_model.othermodel = level.test_model_2;
	}

	var_03.newmodelsspawned = param_01.newmodelsspawned;
	param_01 delete();
	if(var_03.mod_name == "maze1")
	{
		var_03.othermodel = level.test_model_2;
		var_03.othermodel.newmodelsspawned = level.test_model_2.newmodelsspawned;
	}
	else
	{
		var_03.othermodel = level.test_model;
		var_03.othermodel.newmodelsspawned = level.test_model.newmodelsspawned;
	}

	createmazeonmodel(var_03,param_00,param_02);
}

//Function Number: 15
createmazeonmodel(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_04 thread control_puzzle_cursor(param_00);
	}

	if(!isdefined(level.maze_attributes))
	{
		level.maze_attributes = [];
	}

	level.random_maze_roll = [];
	level.maze_attributes[param_00.mod_name] = spawnstruct();
	level.maze_attributes[param_00.mod_name].maze = [];
	for(var_06 = 0;var_06 < 6;var_06++)
	{
		for(var_07 = 0;var_07 < 6;var_07++)
		{
			foreach(var_0A, var_09 in level.maze_attributes)
			{
				if(var_0A == param_00.mod_name)
				{
					var_09.maze[var_06][var_07] = spawnstruct();
					var_09.maze[var_06][var_07].wall_directions = [];
					var_09.maze[var_06][var_07].var_13484 = 0;
				}
			}
		}
	}

	param_00 setscriptablepartstate("maze_puzzle","cursor");
	foreach(var_0E, var_0C in level.array_of_small_crt_script_models)
	{
		var_0D = var_0E;
		if(var_0D > 10)
		{
			var_0D = randomintrange(0,11);
		}

		var_0C setscriptablepartstate("solved_grid","solved_puzzle_" + var_0D);
	}

	if(!isdefined(level.mazerollsarray))
	{
		level.mazerollsarray = [];
	}

	foreach(var_0E, var_10 in level.maze_attributes)
	{
		if(var_0E == param_00.mod_name)
		{
			level.random_maze_roll[var_0E] = random_maze_roll();
			level thread store_wall_directions(var_10,level.random_maze_roll[var_0E]);
		}
	}

	level thread choose_start_end_mazepos(param_00,level.random_maze_roll[param_00.mod_name]);
	param_02 setscriptablepartstate("unsolved_grid","unsolved_maze_" + level.random_maze_roll[param_00.mod_name]);
}

//Function Number: 16
disable_scriptables_for_mazes(param_00)
{
	if(param_00.mod_name == "maze1")
	{
		level.test_model setscriptablepartstate("maze_puzzle","neutral");
		level.unsolved_crt_model setscriptablepartstate("unsolved_grid","neutral");
		return;
	}

	level.test_model_2 setscriptablepartstate("maze_puzzle","neutral");
	level.unsolved_crt_model_2 setscriptablepartstate("unsolved_grid","neutral");
}

//Function Number: 17
disable_solved_grids()
{
	foreach(var_01 in level.array_of_small_crt_script_models)
	{
		var_01 setscriptablepartstate("solved_grid","neutral");
	}
}

//Function Number: 18
return_position_x_y(param_00,param_01,param_02)
{
	if(param_02.mod_name == "maze1")
	{
		foreach(var_04 in level.unsolved_struct_positions_array)
		{
			if(var_04.x_coord == param_00 && var_04.y_coord == param_01)
			{
				return var_04.origin;
			}
		}

		return;
	}

	foreach(var_07 in level.unsolved_struct_positions_array_2)
	{
		if(var_07.x_coord == param_00 && var_07.y_coord == param_01)
		{
			return var_07.origin;
		}
	}
}

//Function Number: 19
input_cursor(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("one_cursor_thread_for_" + param_00.mod_name + "_for_" + self.name);
	self endon("one_cursor_thread_for_" + param_00.mod_name + "_for_" + self.name);
	self endon("end_thread_for_" + param_00.mod_name);
	level endon("end_locking_threads_on_the_player_for_venomx_cursor");
	self notifyonplayercommand("venomxmove_up","+actionslot 1");
	self notifyonplayercommand("venomxmove_down","+actionslot 2");
	self notifyonplayercommand("venomxmove_left","+actionslot 3");
	self notifyonplayercommand("venomxmove_right","+actionslot 4");
	var_02 = "";
	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("venomxmove_up","venomxmove_down","venomxmove_left","venomxmove_right");
		if(distance2dsquared(param_00.origin,self.origin) > 8100)
		{
			param_00 hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!self method_8409(param_00.origin,100,90))
		{
			param_00 hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isdefined(var_02))
		{
			param_00 hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isdefined(level.trapped_zombie) || !isdefined(param_00))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!scripts\common\utility::istrue(level.masterpcinteraction.triggeredsuser))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(isdefined(level.maze_completed))
		{
			if(scripts\common\utility::istrue(level.maze_completed[param_00.mod_name]))
			{
				scripts\common\utility::func_136F7();
				continue;
			}
		}

		if(scripts\common\utility::istrue(level.failed_puzzle))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		param_00 hudoutlineenableforclient(self,3,1,0);
		thread run_disable_player_actions_logic();
		self playlocalsound("cp_final_venom_quest_move_red_square");
		switch(var_02)
		{
			case "venomxmove_up":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord - 1,param_00.ycoord,"up",param_00,self,param_01);
				wait(1);
				break;
	
			case "venomxmove_down":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord + 1,param_00.ycoord,"down",param_00,self,param_01);
				wait(1);
				break;
	
			case "venomxmove_left":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord,param_00.ycoord - 1,"left",param_00,self,param_01);
				wait(1);
				break;
	
			case "venomxmove_right":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord,param_00.ycoord + 1,"right",param_00,self,param_01);
				wait(1);
				break;
	
			default:
				wait(1);
				break;
		}

		self._phone_exit_move = undefined;
		self._phone_exit_damage = undefined;
		self notify("phonebooth_end");
		self notify("moved_cursor");
	}
}

//Function Number: 20
input_cursor_maze2(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("one_cursor_thread_for_" + param_00.mod_name + "_for_" + self.name);
	self endon("one_cursor_thread_for_" + param_00.mod_name + "_for_" + self.name);
	self endon("end_thread_for_" + param_00.mod_name);
	level endon("end_locking_threads_on_the_player_for_venomx_cursor");
	self notifyonplayercommand("venomxmove_up","+actionslot 1");
	self notifyonplayercommand("venomxmove_down","+actionslot 2");
	self notifyonplayercommand("venomxmove_left","+actionslot 3");
	self notifyonplayercommand("venomxmove_right","+actionslot 4");
	var_02 = "";
	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("venomxmove_up","venomxmove_down","venomxmove_left","venomxmove_right");
		if(distance2dsquared(param_00.origin,self.origin) > 8100)
		{
			param_00 hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!self method_8409(param_00.origin,100,90))
		{
			param_00 hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isdefined(var_02))
		{
			param_00 hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isdefined(level.trapped_zombie) || !isdefined(param_00))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!scripts\common\utility::istrue(level.masterpcinteraction.triggeredsuser))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(isdefined(level.maze_completed))
		{
			if(scripts\common\utility::istrue(level.maze_completed[param_00.mod_name]))
			{
				scripts\common\utility::func_136F7();
				continue;
			}
		}

		if(scripts\common\utility::istrue(level.failed_puzzle))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		param_00 hudoutlineenableforclient(self,3,1,0);
		thread run_disable_player_actions_logic();
		self playlocalsound("cp_final_venom_quest_move_red_square");
		switch(var_02)
		{
			case "venomxmove_up":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord - 1,param_00.ycoord,"up",param_00,self,param_01);
				wait(1);
				break;
	
			case "venomxmove_down":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord + 1,param_00.ycoord,"down",param_00,self,param_01);
				wait(1);
				break;
	
			case "venomxmove_left":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord,param_00.ycoord - 1,"left",param_00,self,param_01);
				wait(1);
				break;
	
			case "venomxmove_right":
				runmazeinstanceforpoint(level.maze_attributes[param_00.mod_name].maze,param_00.xcoord,param_00.ycoord + 1,"right",param_00,self,param_01);
				wait(1);
				break;
	
			default:
				wait(1);
				break;
		}

		self._phone_exit_move = undefined;
		self._phone_exit_damage = undefined;
		self notify("phonebooth_end");
		self notify("moved_cursor");
	}
}

//Function Number: 21
run_disable_player_actions_logic()
{
	self endon("disconnect");
	self notify("one_cursor_thread_only_for" + self.name);
	self endon("one_cursor_thread_only_for" + self.name);
	var_00 = self;
	var_00.attemptingpuzzle = 1;
	var_00 thread phone_exit_move();
	var_00 thread phone_exit_damage();
	var_00 notifyonplayercommand("exit_phonebooth","+stance");
	var_00 notifyonplayercommand("exit_phonebooth","+goStand");
	var_00 notifyonplayercommand("exit_phonebooth","+melee_zoom");
	var_00 notifyonplayercommand("exit_phonebooth","+breath_sprint");
	var_00 notifyonplayercommand("exit_phonebooth","+frag");
	var_00 notifyonplayercommand("exit_phonebooth","+smoke");
	scripts\common\utility::func_1372B(var_00,"exit_phonebooth",level,"end_locking_threads_on_the_player_for_venomx_cursor");
	wait(0.05);
	var_00.attemptingpuzzle = undefined;
}

//Function Number: 22
phone_exit_move()
{
	self endon("phonebooth_end");
	self endon("disconnect");
	level endon("end_locking_threads_on_the_player_for_venomx_cursor");
	var_00 = 0;
	for(;;)
	{
		var_01 = self getnormalizedmovement();
		if(var_01[0] != 0 || var_01[1] != 0)
		{
			var_00++;
			if(var_00 == 1)
			{
				self._phone_exit_move = 1;
				self notify("exit_phonebooth");
			}
		}
		else
		{
			var_00 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 23
phone_exit_damage()
{
	self endon("disconect");
	self endon("phonebooth_end");
	level endon("end_locking_threads_on_the_player_for_venomx_cursor");
	self waittill("damage");
	self._phone_exit_damage = 1;
	self notify("exit_phonebooth");
}

//Function Number: 24
player_clock_tick_sfx(param_00)
{
	var_01 = spawn("script_origin",param_00.origin);
	var_01 linkto(param_00);
	var_01 playloopsound("quest_rewind_clock_tick_long");
	level waittill("containment_timer_sfx_done");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 25
timer_progress(param_00,param_01,param_02,param_03)
{
	var_04 = level.puzzles_duration;
	if(getdvar("scr_puzzles_timer","") != "")
	{
		var_04 = 500000;
	}

	if(level.players.size < 2)
	{
		var_04 = 300000;
	}

	setomnvar("zombie_venomxTimer",int(var_04 / 1000));
	wait(1);
	level thread player_clock_tick_sfx(param_02);
	while(gettime() <= param_00 + var_04)
	{
		if(!scripts\common\utility::flag("completepuzzles_step4"))
		{
			if(scripts\common\utility::istrue(level.failed_puzzle))
			{
				break;
			}

			if(!scripts\common\utility::istrue(param_01.stop_triggering_zombies))
			{
				break;
			}

			if(!isdefined(level.trapped_zombie))
			{
				break;
			}

			if(isdefined(level.maze_completed))
			{
				if(scripts\common\utility::istrue(level.maze_completed["maze1"]) && scripts\common\utility::istrue(level.maze_completed["maze2"]))
				{
					break;
				}
			}
		}

		setomnvar("zombie_venomxTimer",int(var_04 + param_00 - gettime() / 1000));
		wait(1);
	}

	level notify("containment_timer_sfx_done");
	level notify("end_locking_threads_on_the_player_for_venomx_cursor");
	wait(1);
	level thread unblock_venomx_pad();
	setomnvar("zombie_venomxTimer",0);
	scripts\cp\_interaction::add_to_current_interaction_list(param_03);
	if(isdefined(level.masterpcinteraction))
	{
		scripts\cp\_interaction::add_to_current_interaction_list(level.masterpcinteraction);
	}

	param_01.stop_triggering_zombies = 0;
	if(isdefined(level.trapped_zombie) && level.trapped_zombie scripts\cp\_utility::func_9D20())
	{
		level.trapped_zombie.var_180 = 0;
		level.trapped_zombie.dont_cleanup = 0;
		level.trapped_zombie.var_5273 = (0,0,0);
		level.trapped_zombie.var_594C = 0;
		level.trapped_zombie.dontmutilate = 0;
		level.trapped_zombie.full_gib = 1;
		level.trapped_zombie.nocorpse = 1;
		level.trapped_zombie.var_EF64 = 0;
		playfx(level._effect["vfx_venmox_spark_expl"],level.trapped_zombie.origin);
		level.trapped_zombie dodamage(level.trapped_zombie.health + 100000,level.trapped_zombie.origin,param_02,param_02);
	}

	level.no_zombie_trapped = 1;
	if(isdefined(level.masterpcinteraction))
	{
		level.masterpcinteraction.triggeredsuser = 0;
		level.masterpcinteraction.triggeredsuser_ent = undefined;
	}

	if(isdefined(level.puzzles_solved) && level.puzzles_solved == 4)
	{
		return;
	}

	if(isdefined(level.maze_completed))
	{
		if(scripts\common\utility::istrue(level.maze_completed["maze1"]))
		{
			level.maze_completed["maze1"] = 0;
		}

		if(scripts\common\utility::istrue(level.maze_completed["maze2"]))
		{
			level.maze_completed["maze2"] = 0;
		}
	}

	level.test_model.newmodelsspawned = 1;
	level.test_model_2.newmodelsspawned = 1;
	level.puzzles_solved = 0;
	param_02 thread scripts\cp\_vo::try_to_play_vo("quest_venx_detainment_kill","final_comment_vo","highest",999,1,0,1,100);
	level thread delay_containment_for_a_wave(param_02);
}

//Function Number: 26
delay_containment_for_a_wave(param_00)
{
	level thread disable_scriptables_for_mazes(level.test_model);
	level thread disable_scriptables_for_mazes(level.test_model_2);
	level thread disable_solved_grids();
	var_01 = getrandomnavpoints(param_00.origin,200,5);
	level thread start_fake_spawn_sequence(param_00,scripts\common\utility::random(var_01));
	level.disable_containment = 1;
	level waittill("spawn_wave_done");
	level.disable_containment = 0;
	level.failed_puzzle = 0;
}

//Function Number: 27
update_player_monitor_wires(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	level endon("end_wire_threads");
	self notify("one_player_monitor_thread_for_" + self.name + param_00.name);
	self endon("one_player_monitor_thread_for_" + self.name + param_00.name);
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(distancesquared(self.origin,param_00.origin) > 8100)
		{
			continue;
		}

		if(!scripts\common\utility::istrue(level.electric_phantom_completed))
		{
			continue;
		}

		update_wires_state_for_player(self,param_00);
	}
}

//Function Number: 28
move_fuse_box_door(param_00)
{
	var_01 = getent("fuse_box_door","script_noteworthy");
	var_02 = "";
	if(param_00)
	{
		var_02 = "zmb_venx_fuse_box_open";
		var_01 rotateto((0,57.6995,0),0.1);
	}
	else
	{
		var_02 = "zmb_venx_fuse_box_close";
		var_01 rotateto((0,180,0),0.1);
	}

	playsoundatpos(var_01.origin,var_02);
}

//Function Number: 29
update_wires_state_for_player(param_00,param_01)
{
	param_00 endon("disconnect");
	level endon("end_wire_threads");
	param_00 notify("one_wirestate_thread_for_" + param_00.name + param_01.name);
	param_00 endon("one_wirestate_thread_for_" + param_00.name + param_01.name);
	if(!param_00 method_8409(param_01.model.origin,25,90))
	{
		param_01.model hudoutlinedisableforclient(param_00);
		scripts\common\utility::func_136F7();
		return;
	}

	level thread show_hint_for_time(2,param_00,param_01);
	param_01.model hudoutlineenableforclient(param_00,3,1,0);
}

//Function Number: 30
show_hint_for_time(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_01 notify("end_thread_instance");
	param_01 endon("end_thread_instance");
	level endon("end_wire_threads");
}

//Function Number: 31
watch_for_input_entered_on_button(param_00)
{
	self endon("disconnect");
	level endon("end_wire_threads");
	self notify("one_wireinput_thread_for_" + self.name + param_00.name);
	self endon("one_wireinput_thread_for_" + self.name + param_00.name);
	self notifyonplayercommand("select_button","+usereload");
	self notifyonplayercommand("select_button","+activate");
	var_01 = "";
	for(;;)
	{
		var_01 = scripts\common\utility::func_13734("select_button");
		if(distance2dsquared(param_00.origin,self.origin) > 8100)
		{
			param_00.model hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!self method_8409(param_00.model.origin,25,90))
		{
			param_00.model hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(scripts\common\utility::istrue(level.wire_struct_disabled))
		{
			thread scripts\cp\_vo::try_to_play_vo("quest_venx_fusebox_disabled_fail","final_comment_vo","highest",999,1,0,1,100);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isdefined(var_01))
		{
			param_00.model hudoutlinedisableforclient(self);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!scripts\common\utility::istrue(level.electric_phantom_completed))
		{
			thread scripts\cp\_vo::try_to_play_vo("quest_venx_fusebox_disabled","final_comment_vo","highest",999,1,0,1,100);
			scripts\common\utility::func_136F7();
			continue;
		}

		param_00.model hudoutlineenableforclient(self,3,1,0);
		if(var_01 == "select_button")
		{
			thread scripts\cp\_vo::try_to_play_vo("quest_venx_fusebox_interact","final_comment_vo","highest",999,1,0,1,100);
			if(validate_wire_logic(param_00))
			{
				self playlocalsound("zmb_item_pickup");
				param_00.model hudoutlinedisableforclient(self);
				level.unlocked_zombie_containment_device = 1;
				level.wire_struct_disabled = undefined;
				thread scripts\cp\_vo::try_to_play_vo("quest_venx_fusebox_success","final_comment_vo","highest",999,1,0,1,100);
				playsoundatpos(param_00.origin,"zmb_venx_success");
				scripts\common\utility::flag_set("disablesecurity_step3");
				continue;
			}

			if(randomint(100) > 50)
			{
				thread scripts\cp\_vo::try_to_play_vo("quest_venx_safe_input_fail","final_comment_vo","highest",999,1,0,1,100);
			}
			else
			{
				thread scripts\cp\_vo::try_to_play_vo("quest_venx_fusebox_fail","final_comment_vo","highest",999,1,0,1,100);
			}

			playsoundatpos(param_00.model.origin,"mpq_fail_buzzer");
			var_02 = getrandomnavpoints((255,4960,120),500,5);
			level thread start_fake_spawn_sequence(self,scripts\common\utility::random(var_02));
			wait(2);
			level.wire_struct_disabled = 1;
			level thread enable_wire_struct_next_wave();
		}
	}
}

//Function Number: 32
wire_color_count_func(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.wire_models)
	{
		if(var_03.color == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 33
validate_wire_logic(param_00)
{
	switch(level.number_of_wires)
	{
		case 3:
			if(wire_color_count_func("black") == 0)
			{
				if(param_00.wire_num == 3)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(level.wire_models[level.wire_models.size - 1].color == "green")
			{
				if(param_00.wire_num == 1)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(wire_color_count_func("red") > 1)
			{
				var_01 = level.wire_models[0];
				for(var_02 = level.wire_models.size - 1;var_02 >= 0;var_02--)
				{
					if(level.wire_models[var_02].color == "red")
					{
						var_01 = level.wire_models[var_02];
						break;
					}
				}
	
				if(var_01 == param_00)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(param_00.wire_num == 2)
			{
				return 1;
			}
			else
			{
				return 0;
			}
			break;

		case 4:
			if(wire_color_count_func("yellow") > 1 && level.specialwavescompleted >= 2)
			{
				var_01 = level.wire_models[0];
				for(var_02 = level.wire_models.size - 1;var_02 >= 0;var_02--)
				{
					if(level.wire_models[var_02].color == "yellow")
					{
						var_01 = level.wire_models[var_02];
						break;
					}
				}
	
				if(var_01 == param_00)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else
			{
				var_03 = level.wire_models[level.wire_models.size - 1];
				if(var_03.color == "white" && wire_color_count_func("blue") == 0)
				{
					if(param_00.wire_num == 1)
					{
						return 1;
					}
					else
					{
						return 0;
					}
				}
				else if(wire_color_count_func("black") > 1)
				{
					if(param_00.wire_num == level.number_of_wires)
					{
						return 1;
					}
					else
					{
						return 0;
					}
				}
				else if(param_00.wire_num == 3)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			break;

		case 5:
			if(level.wave_num <= 3)
			{
				if(param_00.wire_num == 1)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(wire_color_count_func("white") == 1 && wire_color_count_func("blue") > 1)
			{
				if(param_00.wire_num == 2)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(wire_color_count_func("red") == 0 && level.wave_num % 2 == 0 && level.specialwavescompleted < 4)
			{
				if(param_00.wire_num == level.number_of_wires)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(param_00.wire_num == 1)
			{
				return 1;
			}
			else
			{
				return 0;
			}
			break;

		case 6:
			if(wire_color_count_func("yellow") != 0)
			{
				if(param_00.wire_num == 3)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(wire_color_count_func("black") == 1 && wire_color_count_func("white") > 1)
			{
				if(param_00.wire_num == 4)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(level.specialwavescompleted >= 1 && wire_color_count_func("red") > 1)
			{
				if(param_00.wire_num == 5)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(param_00.wire_num == level.number_of_wires)
			{
				return 1;
			}
			else
			{
				return 0;
			}
			break;

		default:
			break;
	}
}

//Function Number: 34
enable_wire_struct_next_wave()
{
	level thread move_fuse_box_door(0);
	foreach(var_01 in level.wire_models)
	{
		var_01.model delete();
	}

	if(isdefined(level.wire_active_fx))
	{
		level.wire_active_fx delete();
	}

	level.wire_models = [];
	level notify("end_wire_threads");
	level waittill("spawn_wave_done");
	level thread move_fuse_box_door(1);
	setup_wire_models();
	foreach(var_04 in level.players)
	{
		foreach(var_01 in level.wire_models)
		{
			var_04 thread update_player_monitor_wires(var_01);
			var_04 thread watch_for_input_entered_on_button(var_01);
		}
	}

	level.wire_struct_disabled = undefined;
}

//Function Number: 35
setup_backstory_interaction(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = spawnstruct();
	var_0A.script_noteworthy = "backstory_interaction";
	var_0A.origin = (-213.9,5640,95.6);
	var_0A.angles = (0,288.9,0);
	var_0A.name = "backstory_interaction";
	var_0A.var_8FFA = param_04;
	var_0A.var_109DA = param_02;
	var_0A.var_12AA2 = param_03;
	var_0A.var_161A = param_05;
	var_0A.var_6261 = 1;
	var_0A.disable_guided_interactions = 0;
	var_0A.var_EE79 = "default";
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_0A.cost = param_06;
	var_0A.var_E1B9 = 0;
	var_0A.var_D776 = 1;
	var_0A.var_95F2 = param_08;
	var_0A.var_3865 = param_09;
	level.interactions[param_01] = var_0A;
	scripts\cp\_interaction::add_to_current_interaction_list(var_0A);
}

//Function Number: 36
init_venomx_models_interactions()
{
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"containment_interaction",undefined,undefined,::containmentinteractionhintfunc,::containmentinteractionusefunc,0,1,::func_2B53);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"master_pc_interaction",undefined,undefined,::master_pcinteractionhintfunc,::master_pcinteractionusefunc,0,1,::func_2B53);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"timeperiod_interaction",undefined,undefined,::timeperiodinteractionhintfunc,::timeperiodinteractionusefunc,0,1,::func_2B53);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"morsecode_interaction",undefined,undefined,::morsecodeinteractionhintfunc,::morsecodeinteractionusefunc,0,1,::func_2B53);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"key_interaction",undefined,undefined,::keyinteractionhintfunc,::keyinteractionusefunc,0,1,::func_2B53);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"dot_interaction",undefined,undefined,::dotinteractionhintfunc,::dotinteractionusefunc,0,1,::func_2B53);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1,"dash_interaction",undefined,undefined,::dashinteractionhintfunc,::dashinteractionusefunc,0,1,::func_2B53);
	level thread setup_backstory_interaction(1,"backstory_interaction",undefined,undefined,::backstoryinteractionhintfunc,::backstoryinteractionusefunc,0,0,::func_2B53);
	level thread setup_wire_models();
	level thread init_timer_texture();
	if(!isdefined(level.alphabets))
	{
		level.alphabets = [];
		level.alphabets["a"] = level.alphabets.size;
		level.alphabets["b"] = level.alphabets.size;
		level.alphabets["c"] = level.alphabets.size;
		level.alphabets["d"] = level.alphabets.size;
		level.alphabets["e"] = level.alphabets.size;
		level.alphabets["f"] = level.alphabets.size;
		level.alphabets["g"] = level.alphabets.size;
		level.alphabets["h"] = level.alphabets.size;
		level.alphabets["i"] = level.alphabets.size;
		level.alphabets["j"] = level.alphabets.size;
		level.alphabets["k"] = level.alphabets.size;
		level.alphabets["l"] = level.alphabets.size;
		level.alphabets["m"] = level.alphabets.size;
		level.alphabets["n"] = level.alphabets.size;
		level.alphabets["o"] = level.alphabets.size;
		level.alphabets["p"] = level.alphabets.size;
		level.alphabets["q"] = level.alphabets.size;
		level.alphabets["r"] = level.alphabets.size;
		level.alphabets["s"] = level.alphabets.size;
		level.alphabets["t"] = level.alphabets.size;
		level.alphabets["u"] = level.alphabets.size;
		level.alphabets["v"] = level.alphabets.size;
		level.alphabets["w"] = level.alphabets.size;
		level.alphabets["x"] = level.alphabets.size;
		level.alphabets["y"] = level.alphabets.size;
		level.alphabets["z"] = level.alphabets.size;
	}

	if(!isdefined(level.alphabets_capped))
	{
		level.alphabets_capped = [];
		level.alphabets_capped["A"] = level.alphabets_capped.size;
		level.alphabets_capped["B"] = level.alphabets_capped.size;
		level.alphabets_capped["C"] = level.alphabets_capped.size;
		level.alphabets_capped["D"] = level.alphabets_capped.size;
		level.alphabets_capped["E"] = level.alphabets_capped.size;
		level.alphabets_capped["F"] = level.alphabets_capped.size;
		level.alphabets_capped["G"] = level.alphabets_capped.size;
		level.alphabets_capped["H"] = level.alphabets_capped.size;
		level.alphabets_capped["I"] = level.alphabets_capped.size;
		level.alphabets_capped["J"] = level.alphabets_capped.size;
		level.alphabets_capped["K"] = level.alphabets_capped.size;
		level.alphabets_capped["L"] = level.alphabets_capped.size;
		level.alphabets_capped["M"] = level.alphabets_capped.size;
		level.alphabets_capped["N"] = level.alphabets_capped.size;
		level.alphabets_capped["O"] = level.alphabets_capped.size;
		level.alphabets_capped["P"] = level.alphabets_capped.size;
		level.alphabets_capped["Q"] = level.alphabets_capped.size;
		level.alphabets_capped["R"] = level.alphabets_capped.size;
		level.alphabets_capped["S"] = level.alphabets_capped.size;
		level.alphabets_capped["T"] = level.alphabets_capped.size;
		level.alphabets_capped["U"] = level.alphabets_capped.size;
		level.alphabets_capped["V"] = level.alphabets_capped.size;
		level.alphabets_capped["W"] = level.alphabets_capped.size;
		level.alphabets_capped["X"] = level.alphabets_capped.size;
		level.alphabets_capped["Y"] = level.alphabets_capped.size;
		level.alphabets_capped["Z"] = level.alphabets_capped.size;
	}

	level.specialwavescompleted = 0;
	level.chosen_number_for_morse_code = 30;
	level.splcharbounties = ["fifteen","eighteen","twenty","twentyfive","thirty"];
	level.chosennumtext = scripts\common\utility::random(level.splcharbounties);
	level.splcharbounties = scripts\common\utility::func_22A9(level.splcharbounties,level.chosennumtext);
	level.chosennumtextpap2 = scripts\common\utility::random(level.splcharbounties);
	switch(level.chosennumtext)
	{
		case "fifteen":
			level.chosen_number_for_morse_code = 15;
			break;

		case "eighteen":
			level.chosen_number_for_morse_code = 18;
			break;

		case "twenty":
			level.chosen_number_for_morse_code = 20;
			break;

		case "twentyfive":
			level.chosen_number_for_morse_code = 25;
			break;

		case "thirty":
			level.chosen_number_for_morse_code = 30;
			break;
	}

	switch(level.chosennumtextpap2)
	{
		case "fifteen":
			level.chosen_number_for_morse_code_pap2 = 15;
			break;

		case "eighteen":
			level.chosen_number_for_morse_code_pap2 = 18;
			break;

		case "twenty":
			level.chosen_number_for_morse_code_pap2 = 20;
			break;

		case "twentyfive":
			level.chosen_number_for_morse_code_pap2 = 25;
			break;

		case "thirty":
			level.chosen_number_for_morse_code_pap2 = 30;
			break;
	}

	level.splcharagents = ["cryptids","special.zombies"];
	level.splchosenagent = level.splcharagents[0];
	level.splcharagents = scripts\common\utility::func_22A9(level.splcharagents,level.splchosenagent);
	level.splchosenagentpap2 = scripts\common\utility::random(level.splcharagents);
	var_00 = get_chars_of_word_with_spaces_between_letters(level.chosennumtext);
	var_00 = changearraytoword(var_00);
	var_01 = get_chars_of_word_with_spaces_between_letters(level.chosennumtextpap2);
	var_01 = changearraytoword(var_01);
	var_02 = get_chars_of_word_with_spaces_between_letters(level.splchosenagent);
	var_02 = changearraytoword(var_02);
	var_03 = get_chars_of_word_with_spaces_between_letters(level.splchosenagentpap2);
	var_03 = changearraytoword(var_03);
	level.mission_intel_array = ["i,n,t,e,l,o,n,e.z,o,n,e,o,f,a,c,t,i,o,n.p,o,r,t,a,l.","i,n,t,e,l,t,w,o.o,n,e,j,o,e.a,t,f,r,o,n,t,l,i,n,e.","i,n,t,e,l,t,h,r,e,e.t,h,e.n,u,m,b,e,r,s.m,e,a,n.e,v,e,r,y,t,h,i,n,g."];
	level.morsecodemessagesarray = ["k,i,l,l.o,v,e,r." + var_00 + "." + var_02,"k,i,l,l.o,v,e,r." + var_01 + "." + var_03 + ".a,n,d." + var_01 + "." + "h,i,d,d,e,n,f,i,g,u,r,e,s."];
	level.morsecodekeysarray = ["cross","archer"];
	level.morsecodekeypap1 = scripts\common\utility::random(level.morsecodekeysarray);
	level.morsecodekeysarray = scripts\common\utility::func_22A9(level.morsecodekeysarray,level.morsecodekeypap1);
	level.morsecodekeypap2 = scripts\common\utility::random(level.morsecodekeysarray);
	level.morsedashmodel = getent("dot_button","script_noteworthy");
	level.morsedotmodel = getent("dash_button","script_noteworthy");
	level.zombie_venomx_containment_trigger = getent("zombie_containment_volume","targetname");
	level.zombie_venomx_containment_trigger thread watch_for_containment_trigger();
	level.hidden_figures_volume = getent("hidden_figures_volume","script_noteworthy");
	if(!isdefined(level.hidden_figures))
	{
		level.hidden_figures = [];
	}

	level.hidden_figures[0] = spawnstruct();
	level.hidden_figures[0].origin = (3764,6940,227);
	level.hidden_figures[0].var_D776 = 0;
	level.hidden_figures[0].var_E1B9 = 0;
	level.hidden_figures[0].name = "hidden_figure_objects";
	level.hidden_figures[0].script_noteworthy = "fig_1";
	level.hidden_figures[0].var_EE79 = "default";
	level.hidden_figures[0].var_336 = "interaction";
	var_04 = scripts\common\utility::getstructarray("fig_1","script_noteworthy");
	level.hidden_figures[1] = spawnstruct();
	level.hidden_figures[1].origin = (3764,6940,227);
	level.hidden_figures[1].var_D776 = 0;
	level.hidden_figures[1].var_E1B9 = 0;
	level.hidden_figures[1].name = "hidden_figure_objects";
	level.hidden_figures[1].script_noteworthy = "fig_2";
	level.hidden_figures[1].var_EE79 = "default";
	level.hidden_figures[1].var_336 = "interaction";
	var_04 = scripts\common\utility::getstructarray("fig_2","script_noteworthy");
	level.hidden_figures[2] = spawnstruct();
	level.hidden_figures[2].origin = (3764,6940,227);
	level.hidden_figures[2].var_D776 = 0;
	level.hidden_figures[2].var_E1B9 = 0;
	level.hidden_figures[2].name = "hidden_figure_objects";
	level.hidden_figures[2].script_noteworthy = "fig_3";
	level.hidden_figures[2].var_EE79 = "default";
	level.hidden_figures[2].var_336 = "interaction";
	var_04 = scripts\common\utility::getstructarray("fig_3","script_noteworthy");
	level.hidden_figures[3] = spawnstruct();
	level.hidden_figures[3].origin = (3764,6940,227);
	level.hidden_figures[3].var_D776 = 0;
	level.hidden_figures[3].var_E1B9 = 0;
	level.hidden_figures[3].name = "hidden_figure_objects";
	level.hidden_figures[3].script_noteworthy = "fig_4";
	level.hidden_figures[3].var_EE79 = "default";
	level.hidden_figures[3].var_336 = "interaction";
	var_04 = scripts\common\utility::getstructarray("fig_4","script_noteworthy");
	foreach(var_06 in level.hidden_figures)
	{
		var_06.var_86A2 = "locOverride";
		var_06.playeroffset = [];
		setup_hidden_figure_models(var_06,var_06.script_noteworthy);
	}
}

//Function Number: 37
get_chars_of_word_with_spaces_between_letters(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01[var_02] = param_00[var_02] + ",";
	}

	return var_01;
}

//Function Number: 38
keyconversiontomorse(param_00)
{
	convertwordintomorse(param_00,1);
}

//Function Number: 39
watch_for_containment_trigger()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00) && var_00 scripts\cp\_utility::is_valid_player())
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(scripts\common\utility::istrue(self.stop_triggering_zombies))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(scripts\common\utility::istrue(level.disable_containment))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(var_00 scripts\cp\_utility::func_9D20())
		{
			level.trapped_zombie = var_00;
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 40
watch_for_zombie_death_containment(param_00)
{
	self waittill("death");
	self.var_EF64 = 0;
	self.var_180 = 0;
	self.bhasdiscofever = 0;
	self.dontmutilate = 0;
	self.full_gib = 1;
	self.nocorpse = 1;
	self.dont_cleanup = 0;
	self.var_594C = 0;
	self.var_EF64 = 0;
	param_00.stop_triggering_zombies = 0;
	level.no_zombie_trapped = 1;
	level.trapped_zombie = undefined;
}

//Function Number: 41
containmentinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	if(scripts\common\utility::func_6E34("disablesecurity_step3") && !scripts\common\utility::flag("disablesecurity_step3"))
	{
		return;
	}

	if(scripts\common\utility::istrue(level.disable_containment))
	{
		param_01 playlocalsound("perk_machine_deny");
		return;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(isdefined(level.trapped_zombie) && level.trapped_zombie istouching(level.zombie_venomx_containment_trigger))
	{
		earthquake(0.45,3,param_00.origin,750);
		level.zombie_venomx_containment_trigger.stop_triggering_zombies = 1;
		level.trapped_zombie.var_EF64 = 1;
		level.trapped_zombie.var_180 = 1;
		level.trapped_zombie.dont_cleanup = 1;
		level.trapped_zombie.var_594C = 1;
		level.trapped_zombie.var_5273 = (0,0,0);
		level.trapped_zombie.dontmutilate = 1;
		level.trapped_zombie method_82EF(level.zomb_goal_containment_struct.origin);
		var_02 = level.trapped_zombie scripts\common\utility::func_13734("goal","goal_reached","death");
		if(var_02 == "death")
		{
			playsoundatpos(param_00.origin,"mpq_fail_buzzer");
			wait(3);
			scripts\cp\_interaction::add_to_current_interaction_list(param_00);
			return;
		}

		playfx(level._effect["temp_circuit_fx"],level.trapped_zombie.origin);
		level thread block_venomx_pad();
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_venx_detainment_capture","final_comment_vo","highest",999,1,0,1,100);
		level.trapped_zombie thread watch_for_zombie_death_containment(level.zombie_venomx_containment_trigger);
		var_03 = gettime();
		level thread timer_progress(var_03,level.zombie_venomx_containment_trigger,param_01,param_00);
		return;
	}

	playsoundatpos(param_00.origin,"mpq_fail_buzzer");
	wait(3);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 42
containmentinteractionhintfunc(param_00,param_01)
{
	if(scripts\common\utility::flag("disablesecurity_step3"))
	{
		return &"CP_FINAL_CONTAINMENT_CHAMBER";
	}

	return "";
}

//Function Number: 43
master_pcinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	level.masterpcinteraction = param_00;
	if(!isdefined(param_01.samcrossvoarr))
	{
		param_01.samcrossvoarr = ["final_cross_log_1","final_cross_log_2","final_cross_log_3"];
	}

	param_01.chosensamcrossvo = scripts\common\utility::random(param_01.samcrossvoarr);
	if(scripts\common\utility::flag("completepuzzles_step4"))
	{
		if(param_01.samcrossvoarr.size > 0)
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo(param_01.chosensamcrossvo,"final_backstory_vo","highest",999,1,0,1,100);
			return;
		}

		return;
	}

	if(scripts\common\utility::istrue(level.zombie_venomx_containment_trigger.stop_triggering_zombies) && !scripts\common\utility::istrue(level.masterpcinteraction.triggeredsuser))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(level.masterpcinteraction);
		param_01 playlocalsound("cp_final_venom_quest_turn_on_console");
		playfx(level._effect["temp_circuit_fx"],param_00.origin);
		level thread start_maze_instance(param_01);
		level.masterpcinteraction.triggeredsuser = 1;
		level.masterpcinteraction.triggeredsuser_ent = param_01;
		return;
	}
}

//Function Number: 44
master_pcinteractionhintfunc(param_00,param_01)
{
	if(scripts\common\utility::flag("disablesecurity_step3") && !scripts\common\utility::flag("completepuzzles_step4"))
	{
		return &"CP_FINAL_SUPER_USER";
	}

	return "";
}

//Function Number: 45
watch_for_player_laststand(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 waittill("last_stand");
	scripts\cp\_interaction::add_to_current_interaction_list(param_01);
}

//Function Number: 46
watch_for_player_disconnect(param_00,param_01)
{
	param_00 waittill("disconnect");
	scripts\cp\_interaction::add_to_current_interaction_list(param_01);
}

//Function Number: 47
start_timing_sequence(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_01 endon("death");
	level endon("game_ended");
	var_03 = 0;
	while(gettime() <= param_02 + -15536)
	{
		if(param_01.hidden_figures_hit >= level.chosen_number_for_morse_code_pap2)
		{
			foreach(var_05 in level.players)
			{
				var_05 playlocalsound("zmb_item_pickup");
			}

			foreach(var_08 in param_01.personalents)
			{
				if(isdefined(var_08.model) && var_08.model == "tag_origin_hidden_figure_final")
				{
					var_08 setscriptablepartstate("figure_effect","neutral");
					scripts\common\utility::func_136F7();
					var_08 setscriptablepartstate("figure_effect","death");
				}
			}

			break;
		}

		if(!scripts\common\utility::istrue(var_03))
		{
			if(function_010F(param_01.origin,level.hidden_figures_volume))
			{
				var_03 = 1;
				param_01 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(param_01);
			}
		}

		wait(1);
	}

	param_01.triggeredtimequest = 0;
	level notify("end_timing_sequence");
}

//Function Number: 48
delay_enable_linked_interaction(param_00,param_01)
{
	param_01 endon("disconnect");
	level waittill("spawn_wave_done");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 49
timeperiodinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	if(!isdefined(param_00.time_periods))
	{
		param_00.time_periods = [1950,1980,1970,1990];
		param_00.pointer = 0;
	}

	var_02 = param_00.time_periods[param_00.pointer];
	param_00.pointer++;
	if(param_00.pointer == param_00.time_periods.size - 1)
	{
		param_00.pointer = 0;
	}

	level thread changetimeperiodmodel(var_02);
	if(var_02 == 1950)
	{
		if(scripts\common\utility::istrue(param_01.canattempthiddenfigureschallenge))
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
			param_01.hidden_figures_hit = 0;
			level.hidden_figures_killed = 0;
			param_01.triggeredtimequest = 1;
			var_03 = gettime();
			level thread watch_for_player_disconnect(param_01,param_00);
			level thread watch_for_player_laststand(param_01,param_00);
			level thread start_timing_sequence(param_00,param_01,var_03);
			level thread delay_enable_linked_interaction(param_00,param_01);
			level waittill("end_timing_sequence");
			return;
		}

		return;
	}

	if(var_03 == 1970)
	{
		level notify("70s_activated");
	}
}

//Function Number: 50
changetimeperiodmodel(param_00)
{
	switch(param_00)
	{
		case 1950:
			level.timeperiodmodel setmodel("cp_final_console_standing_timeperiod_50s");
			break;

		case 1980:
			level.timeperiodmodel setmodel("cp_final_console_standing_timeperiod_80s");
			break;

		case 1970:
			level.timeperiodmodel setmodel("cp_final_console_standing_timeperiod_70s");
			break;

		case 1990:
			level.timeperiodmodel setmodel("cp_final_console_standing_timeperiod_90s");
			break;
	}
}

//Function Number: 51
timeperiodinteractionhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 52
morsecodeinteractionusefunc(param_00,param_01)
{
	if(!scripts\common\utility::flag("completepuzzles_step4"))
	{
		return;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!isdefined(level.morsecodecomponent))
	{
		var_02 = spawn("script_model",(609,4388.5,88));
		var_02 setmodel("tag_origin_morse_code");
		var_02.angles = (0,180,0);
		level.morsecodecomponent = var_02;
	}

	level.morsecodecomponent setscriptablepartstate("morse_code","off");
	if(!scripts\common\utility::istrue(level.completed_venomx_pap1_challenges))
	{
		level thread keyconversiontomorse(level.chosennumtext);
		param_01 thread venomx_morse_code(level.morsecodemessagesarray,level.morsecodekeypap1,param_00);
		return;
	}

	level thread keyconversiontomorse(level.chosennumtextpap2);
	param_01 thread venomx_morse_code(level.morsecodemessagesarray,level.morsecodekeypap2,param_00);
}

//Function Number: 53
morsecodeinteractionhintfunc(param_00,param_01)
{
	param_01 endon("disconnect");
	return "";
}

//Function Number: 54
keyinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	if(!scripts\common\utility::flag("completepuzzles_step4"))
	{
		return;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!isdefined(level.keycodecomponent))
	{
		var_02 = spawn("script_model",(-232.5,4294,224));
		var_02 setmodel("tag_origin_morse_code");
		var_02.angles = (0,90,0);
		level.keycodecomponent = var_02;
	}

	if(!scripts\common\utility::istrue(level.completed_venomx_pap1_challenges))
	{
		level thread keyconversiontomorse(level.chosennumtext);
		level convertwordintomorse(level.morsecodekeypap1,0,level.keycodecomponent);
	}
	else if(!scripts\common\utility::istrue(level.completed_venomx_pap2_challenges))
	{
		level thread keyconversiontomorse(level.chosennumtextpap2);
		if(randomint(100) > 80)
		{
			level convertwordintomorse(scripts\common\utility::random(level.mission_intel_array),0,level.keycodecomponent);
		}
		else
		{
			level convertwordintomorse(level.morsecodekeypap2,0,level.keycodecomponent);
		}
	}

	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 55
keyinteractionhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 56
dotinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	if(!scripts\common\utility::flag("completepuzzles_step4"))
	{
		return;
	}

	if(!isdefined(level.dotinteraction))
	{
		level.dotinteraction = param_00;
	}

	scripts\cp\_utility::func_D52A("payphone_plr_morse_dot",param_00.origin);
	if(!isdefined(level.inputkeyword))
	{
		level.inputkeyword = "";
	}

	level.inputkeyword = level.inputkeyword + ".";
	if(!scripts\common\utility::istrue(level.completedpap2morsecode))
	{
		if(!scripts\common\utility::istrue(param_00.entered_key))
		{
			if(isdefined(level.convertedword))
			{
				if(level.convertedword == level.inputkeyword)
				{
					foreach(var_03 in level.players)
					{
						var_03 playlocalsound("zmb_item_pickup");
						var_03 thread spawnthreadsforvenomxchallenges(var_03);
					}

					level.inputkeyword = "";
					param_00.entered_key = 1;
					level.dashinteraction.entered_key = 1;
				}
			}
		}

		level thread clearinputafterwaveend(param_00);
	}
}

//Function Number: 57
clearinputafterwaveend(param_00)
{
	level notify("one_thread_for_clearInput");
	level endon("one_thread_for_clearInput");
	level waittill("spawn_wave_done");
	level.inputkeyword = "";
	playsoundatpos(param_00.origin,"mpq_fail_buzzer");
}

//Function Number: 58
dotinteractionhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 59
dashinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	if(!scripts\common\utility::flag("completepuzzles_step4"))
	{
		return;
	}

	if(!isdefined(level.dashinteraction))
	{
		level.dashinteraction = param_00;
	}

	scripts\cp\_utility::func_D52A("payphone_plr_morse_dash",param_00.origin);
	if(!isdefined(level.inputkeyword))
	{
		level.inputkeyword = "";
	}

	level.inputkeyword = level.inputkeyword + "-";
	if(!scripts\common\utility::istrue(level.completedpap2morsecode))
	{
		if(!scripts\common\utility::istrue(param_00.entered_key))
		{
			if(isdefined(level.convertedword))
			{
				if(level.convertedword == level.inputkeyword)
				{
					foreach(var_03 in level.players)
					{
						var_03 playlocalsound("zmb_item_pickup");
						var_03 thread spawnthreadsforvenomxchallenges(var_03);
					}

					level.inputkeyword = "";
					param_00.entered_key = 1;
					level.dotinteraction.entered_key = 1;
				}
			}
		}

		level thread clearinputafterwaveend(param_00);
	}
}

//Function Number: 60
dashinteractionhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 61
backstoryinteractionusefunc(param_00,param_01)
{
	param_01 endon("disconnect");
	level.backstoryinteraction = param_00;
	if(!isdefined(param_01.backstoryvoarr))
	{
		param_01.backstoryvoarr = ["crew1_quest","crew3_quest","crew4_quest","final_crew_shen_log_1","final_crew_shen_log_2","final_crew_shen_log_3","final_crew_shen_log_4","final_crew_adamson_log_1","final_crew_adamson_log_2","final_crew_adamson_log_3","final_crew_adamson_log_4"];
	}

	param_01.chosenbackstoryvo = scripts\common\utility::random(param_01.backstoryvoarr);
	if(scripts\common\utility::flag("disable_evil_neil"))
	{
		if(param_01.backstoryvoarr.size <= 0)
		{
			param_01.backstoryvoarr = ["crew1_quest","crew3_quest","crew4_quest","final_crew_shen_log_1","final_crew_shen_log_2","final_crew_shen_log_3","final_crew_shen_log_4","final_crew_adamson_log_1","final_crew_adamson_log_2","final_crew_adamson_log_3","final_crew_adamson_log_4"];
			param_01.chosenbackstoryvo = scripts\common\utility::random(param_01.backstoryvoarr);
		}

		var_02 = "";
		switch(param_01.chosenbackstoryvo)
		{
			case "final_crew_shen_log_1":
				var_02 = "final_n31l_log_shen_1";
				break;

			case "final_crew_shen_log_2":
				var_02 = "final_n31l_log_shen_2";
				break;

			case "final_crew_shen_log_3":
				var_02 = "final_n31l_log_shen_3";
				break;

			case "final_crew_shen_log_4":
				var_02 = "final_n31l_log_shen_4";
				break;

			case "final_crew_adamson_log_1":
				var_02 = "final_n31l_log_adamson_1";
				break;

			case "final_crew_adamson_log_2":
				var_02 = "final_n31l_log_adamson_2";
				break;

			case "final_crew_adamson_log_3":
				var_02 = "final_n31l_log_adamson_3";
				break;

			case "final_crew_adamson_log_4":
				var_02 = "final_n31l_log_adamson_4";
				break;
		}

		if(isdefined(var_02) && var_02 != "")
		{
			scripts\cp\maps\cp_final\cp_final_mpq::playneilvo(var_02);
			var_03 = scripts\cp\_vo::func_7C76(var_02);
			wait(var_03);
		}

		param_01 thread scripts\cp\_vo::try_to_play_vo(param_01.chosenbackstoryvo,"final_backstory_vo","highest",999,1,0,1,100);
	}

	var_03 = scripts\cp\_vo::func_7C76(param_01.chosenbackstoryvo);
	wait(var_03);
	scripts\cp\_vo::func_12BE3([param_01]);
}

//Function Number: 62
backstoryinteractionhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 63
spawnthreadsforvenomxchallenges(param_00)
{
	if(!scripts\common\utility::istrue(level.completed_venomx_pap1_challenges))
	{
		level.cryptidkillswithvenomx = 0;
		level thread venomx_charge_meter();
		param_00 thread runkillswatcherforcryptids();
		return;
	}

	setomnvar("zm_venomx_state",1);
	setomnvar("zom_general_fill_percent_2",0);
	foreach(var_02 in level.players)
	{
		var_02.hidden_figures_hit = 0;
		var_02 thread keyconversiontomorse(level.chosennumtextpap2);
	}

	level.hidden_figures_killed = 0;
	level.completedpap2morsecode = 1;
	param_00.canattempthiddenfigureschallenge = 1;
	level.cryptidkillswithvenomxpap2 = 0;
	param_00 thread runkillswatcherforcryptidspap2();
	level thread venomx_charge_meter();
}

//Function Number: 64
runkillswatcherforcryptidspap2()
{
	self endon("disconnected");
	for(;;)
	{
		if(level.cryptidkillswithvenomxpap2 >= level.chosen_number_for_morse_code_pap2 && isdefined(level.hidden_figures_killed) && level.hidden_figures_killed >= level.chosen_number_for_morse_code_pap2)
		{
			foreach(var_01 in level.players)
			{
				var_01 playlocalsound("part_pickup");
			}

			level.completed_venomx_pap2_challenges = 1;
			break;
		}

		wait(1);
	}
}

//Function Number: 65
runkillswatcherforcryptids()
{
	self endon("disconnected");
	for(;;)
	{
		if(level.cryptidkillswithvenomx >= level.chosen_number_for_morse_code)
		{
			level.completed_venomx_pap1_challenges = 1;
			level.inputkeyword = "";
			level.dashinteraction.entered_key = 0;
			level.dotinteraction.entered_key = 0;
			if(level.morsecodemessagesarray.size > 1)
			{
				level.morsecodemessagesarray = scripts\common\utility::func_22A9(level.morsecodemessagesarray,level.morsecodemessagesarray[0]);
			}

			foreach(var_01 in level.players)
			{
				var_01 thread keyconversiontomorse(level.chosennumtextpap2);
			}

			break;
		}

		wait(1);
	}
}

//Function Number: 66
venomx_charge_meter()
{
	level notify("only_one_thread_for_charge_meter");
	level endon("only_one_thread_for_charge_meter");
	for(;;)
	{
		var_00 = level scripts\common\utility::func_13734("venomx_kill","venomx_pap1_kill");
		var_01 = 0;
		if(var_00 == "venomx_kill")
		{
			var_01 = level.cryptidkillswithvenomx / level.chosen_number_for_morse_code;
		}
		else if(var_00 == "venomx_pap1_kill")
		{
			if(isdefined(level.hidden_figures_killed))
			{
				var_01 = level.cryptidkillswithvenomxpap2 + level.hidden_figures_killed / level.chosen_number_for_morse_code_pap2 * 2;
			}
			else
			{
				var_01 = level.cryptidkillswithvenomxpap2 / level.chosen_number_for_morse_code_pap2;
			}
		}

		if(var_01 >= 1)
		{
			setomnvar("zom_general_fill_percent_2",1);
			continue;
		}

		setomnvar("zom_general_fill_percent_2",var_01);
	}
}

//Function Number: 67
venomxquestregistration()
{
	finalqueststepregistration("Venom Quest",0,::func_2B53,::restore_power_to_ship,::complete_restore_power_to_ship,::debug_restore_power_to_ship,1,"Restore Power to the Ship");
	finalqueststepregistration("Venom Quest",1,::func_2B53,::electric_phantom,::complete_electric_phantom,::debug_electric_phantom,1,"Drag a Rhino Into the Electric Trap");
	finalqueststepregistration("Venom Quest",2,::func_2B53,::disable_security_protocol,::complete_disable_security_protocol,::debug_disable_security_protocol,1,"Disable Security Protocol");
	finalqueststepregistration("Venom Quest",3,::func_2B53,::interact_and_complete_puzzles,::complete_interact_and_complete_puzzles,::debug_interact_and_complete_puzzles,1,"Interact and Complete All Puzzles");
}

//Function Number: 68
initvenomxquestflags()
{
	level.puzzles_duration = 180000;
	level.puzzles_solved = 0;
	level.electric_phantom_completed = 0;
	scripts\common\utility::flag_init("restorepower_step1");
	scripts\common\utility::flag_init("electricphantom_step2");
	scripts\common\utility::flag_init("disablesecurity_step3");
	scripts\common\utility::flag_init("completepuzzles_step4");
}

//Function Number: 69
reroll_number_of_wires()
{
	return randomintrange(3,7);
}

//Function Number: 70
func_2B53()
{
}

//Function Number: 71
restore_power_to_ship()
{
	scripts\common\utility::flag_wait("restorepower_step1");
}

//Function Number: 72
complete_restore_power_to_ship()
{
}

//Function Number: 73
debug_restore_power_to_ship()
{
}

//Function Number: 74
electric_phantom()
{
	scripts\common\utility::flag_wait("electricphantom_step2");
}

//Function Number: 75
complete_electric_phantom()
{
	level thread move_fuse_box_door(1);
	triggerfx(level.wire_active_fx);
	level.electric_phantom_completed = 1;
}

//Function Number: 76
debug_electric_phantom()
{
	scripts\common\utility::flag_set("electricphantom_step2");
}

//Function Number: 77
disable_security_protocol()
{
	scripts\common\utility::flag_wait("disablesecurity_step3");
}

//Function Number: 78
complete_disable_security_protocol()
{
	move_fuse_box_door(0);
	foreach(var_01 in level.wire_models)
	{
		var_01.model delete();
	}

	if(isdefined(level.wire_active_fx))
	{
		level.wire_active_fx delete();
	}

	level.wire_models = [];
	level notify("end_wire_threads");
}

//Function Number: 79
debug_disable_security_protocol()
{
	scripts\common\utility::flag_set("disablesecurity_step3");
}

//Function Number: 80
interact_and_complete_puzzles()
{
	scripts\common\utility::flag_wait("completepuzzles_step4");
}

//Function Number: 81
complete_interact_and_complete_puzzles()
{
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("quest_venx_safe_success","zmb_comment_vo");
		var_01 thread keyconversiontomorse(level.chosennumtext);
	}

	move_venomx_locker_door(1);
	unblock_venomx_door();
	scripts\cp\_utility::set_quest_icon(5);
	if(!isdefined(level.morsecodecomponent))
	{
		var_03 = spawn("script_model",(609,4388.5,88));
		var_03 setmodel("tag_origin_morse_code");
		var_03.angles = (0,180,0);
		level.morsecodecomponent = var_03;
		level.morsecodecomponent setscriptablepartstate("morse_code","off");
	}

	if(!isdefined(level.keycodecomponent))
	{
		var_03 = spawn("script_model",(-232.5,4294,224));
		var_03 setmodel("tag_origin_morse_code");
		var_03.angles = (0,90,0);
		level.keycodecomponent = var_03;
		level.keycodecomponent setscriptablepartstate("morse_code","off");
	}
}

//Function Number: 82
debug_interact_and_complete_puzzles()
{
	scripts\common\utility::flag_set("completepuzzles_step4");
	level.puzzles_solved = 4;
}

//Function Number: 83
venomx_weapon_logic_start(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.var_222.basetriggercount))
	{
		param_00.var_222.basetriggercount = 0;
	}

	if(issubstr(param_00.var_13C2E,"pap1"))
	{
		param_00.var_222 thread explode_venomx_projectile_early(param_00,2);
		param_00.var_222 thread venomx_pap1_effects(param_00);
		return;
	}

	if(issubstr(param_00.var_13C2E,"pap2"))
	{
		param_00.var_222 thread explode_venomx_projectile_early(param_00,3);
		param_00.var_222 thread venomx_pap2_effects(param_00);
		return;
	}

	param_00.var_222 thread explode_venomx_projectile_early(param_00,1);
	param_00.var_222 thread deal_venomx_projectile_damage(param_00,1);
}

//Function Number: 84
explode_venomx_projectile_early(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("one_instance_of_explode_early_" + self.name);
	self endon("one_instance_of_explode_early_" + self.name);
	var_02 = self;
	for(;;)
	{
		scripts\common\utility::waittill_any_3("detonate_venomx_projectile_early","detonate_pap1venomx_projectile_early","detonate_pap2venomx_projectile_early");
		if(!isdefined(param_00.origin) || !isdefined(param_00.angles))
		{
			return;
		}

		var_03 = param_00.origin;
		var_04 = param_00.angles;
		param_00 method_8099(self);
		break;
	}

	self notify("delete_older_overlapping_threads");
	switch(param_01)
	{
		case 1:
			var_05 = gettime();
			var_06 = spawn("trigger_radius",var_03,0,400,64);
			self.basetriggercount++;
			var_06.name = "venomx_triggered_early" + self.basetriggercount;
			var_06 thread deal_venomx_damage_to_enemies(var_02,var_05);
			var_06 thread delete_venomx_trigger_after_time(var_02,var_05);
			break;

		case 2:
			level thread slow_mo_sphere(var_02,var_03,128,4,1,var_04);
			thread remove_frozen_effects_on_disconnect(1);
			var_05 = gettime();
			thread delete_venomxpap_effects_after_time(var_05,4);
			break;

		case 3:
			level thread slow_mo_sphere(var_02,var_03,175,7,2,var_04);
			thread remove_frozen_effects_on_disconnect(2);
			var_05 = gettime();
			thread delete_venomxpap_effects_after_time(var_05,7);
			break;
	}
}

//Function Number: 85
deal_venomx_projectile_damage(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	self endon("delete_older_overlapping_threads");
	var_02 = param_00.angles;
	var_03 = param_00.origin;
	var_04 = 200;
	if(param_01 == 1)
	{
		var_04 = 200;
	}

	param_00 scripts\common\utility::waittill_any_3("missile_stuck","death");
	if(!isdefined(param_00.origin))
	{
		return;
	}

	var_05 = param_00.origin;
	while(isdefined(param_00.origin))
	{
		var_05 = param_00.origin;
		scripts\common\utility::func_136F7();
	}

	var_06 = gettime();
	var_07 = spawn("trigger_radius",var_05,0,var_04,64);
	self.basetriggercount++;
	var_07.name = "venomx_triggered_afterT" + self.basetriggercount;
	var_07 thread deal_venomx_damage_to_enemies(self,var_06);
	var_07 thread delete_venomx_trigger_after_time(self,var_06);
}

//Function Number: 86
deal_venomx_damage_to_enemies(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	self endon("death");
	param_00 notify("one_instance_of_deal_damage_" + self.name);
	param_00 endon("one_instance_of_deal_damage_" + self.name);
	while(gettime() <= param_01 + 5000)
	{
		self waittill("trigger",var_02);
		if(!isdefined(var_02))
		{
			continue;
		}

		if(isplayer(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.agent_type))
		{
			continue;
		}

		if(!var_02 scripts\cp\_utility::func_9D20() && var_02.agent_type != "alien_goon")
		{
			continue;
		}

		if(isdefined(param_00))
		{
			if(var_02 scripts\cp\_utility::agentisinstakillimmune())
			{
				var_02.var_6E82 = gettime() + 200;
				var_02 dodamage(10,var_02.origin,param_00,param_00,"MOD_RIFLE_BULLET","iw7_venomx_zm");
			}
			else
			{
				var_02.var_6E82 = gettime() + 200;
				var_02 dodamage(30,var_02.origin,param_00,param_00,"MOD_RIFLE_BULLET","iw7_venomx_zm");
			}

			continue;
		}

		var_02.var_6E82 = gettime() + 200;
		var_02 thread scripts\cp\_utility::func_4D0D(var_02,undefined,5000,2500,undefined,"iw7_venomx_zm",undefined,"iw7_venomx_zm");
	}
}

//Function Number: 87
delete_venomx_trigger_after_time(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	param_00 notify("delete_venomx_trigger_after_time" + self.name);
	param_00 endon("delete_venomx_trigger_after_time" + self.name);
	while(gettime() <= param_01 + 5000)
	{
		scripts\common\utility::func_136F7();
	}

	foreach(var_03 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		if(isalive(var_03))
		{
			var_03.var_6E82 = undefined;
		}
	}

	self delete();
}

//Function Number: 88
venomx_pap1_effects(param_00)
{
	self endon("delete_older_overlapping_threads");
	self endon("disconnect");
	var_01 = self;
	param_00 scripts\common\utility::waittill_any_3("missile_stuck","detonateExplosive");
	var_02 = param_00.origin;
	var_03 = param_00.angles;
	while(isdefined(param_00.origin))
	{
		var_02 = param_00.origin;
		var_03 = param_00.angles;
		scripts\common\utility::func_136F7();
	}

	level thread slow_mo_sphere(var_01,var_02,128,4,1,var_03);
	thread remove_frozen_effects_on_disconnect(1);
	var_04 = gettime();
	thread delete_venomxpap_effects_after_time(var_04,4);
}

//Function Number: 89
venomx_pap2_effects(param_00)
{
	self endon("delete_older_overlapping_threads");
	self endon("disconnect");
	var_01 = self;
	param_00 scripts\common\utility::waittill_any_3("missile_stuck","detonateExplosive");
	var_02 = param_00.origin;
	var_03 = param_00.angles;
	while(isdefined(param_00.origin))
	{
		var_02 = param_00.origin;
		var_03 = param_00.angles;
		scripts\common\utility::func_136F7();
	}

	level thread slow_mo_sphere(var_01,var_02,175,7,2,var_03);
	thread remove_frozen_effects_on_disconnect(2);
	var_04 = gettime();
	thread delete_venomxpap_effects_after_time(var_04,7);
}

//Function Number: 90
remove_frozen_effects_on_disconnect(param_00)
{
	self notify("one_thread_of_removal_for_" + self.name);
	self endon("one_thread_of_removal_for_" + self.name);
	scripts\common\utility::waittill_any_3("disconnect","death");
	if(isdefined(self.sacred_grounds))
	{
		foreach(var_02 in self.sacred_grounds)
		{
			var_02 delete();
		}
	}

	if(param_00 == 1)
	{
		self.slow_mo_active = 0;
	}
	else
	{
		self.slow_mo_active_pap2 = 0;
	}

	level.var_7456 = ::scripts\cp\zombies\zombie_scriptable_states::func_7383;
	level.var_11768 = ::scripts\cp\zombies\zombie_scriptable_states::func_12B9A;
}

//Function Number: 91
delete_venomxpap_effects_after_time(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	while(gettime() <= param_00 + param_01 * 1000)
	{
		scripts\common\utility::func_136F7();
	}

	level.var_7456 = ::scripts\cp\zombies\zombie_scriptable_states::func_7383;
	level.var_11768 = ::scripts\cp\zombies\zombie_scriptable_states::func_12B9A;
}

//Function Number: 92
slow_mo_sphere(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	if(!isdefined(self.sacred_ground))
	{
		self.sacred_grounds = [];
	}

	if(param_04 == 1)
	{
		self.slow_mo_active = 1;
	}
	else
	{
		self.slow_mo_active_pap2 = 1;
	}

	level.var_7456 = ::custom_slow_time_func;
	level.var_11768 = ::custom_unslow_func;
	var_06 = (0,0,180);
	var_07 = spawn("trigger_rotatable_radius",param_01,0,param_02,256);
	self.sacred_grounds[self.sacred_grounds.size] = var_07;
	if(param_04 == 1)
	{
		playfx(level._effect["pap1_slowtime"],param_01 + (0,0,5),anglestoforward(param_05),anglestoup(param_05 + (-90,0,0)));
	}
	else
	{
		playfx(level._effect["pap2_slowtime"],param_01 + (0,0,5),anglestoforward(param_05),anglestoup(param_05 + (-90,0,0)));
	}

	self.zombie_list = [];
	var_07 thread apply_slow_mo_on_trigger(param_00,param_04);
	wait(param_03);
	if(param_04 == 1)
	{
		self.slow_mo_active = 0;
	}
	else
	{
		self.slow_mo_active_pap2 = 0;
	}

	if(isdefined(var_07))
	{
		var_07 delete();
	}

	level.var_7456 = ::scripts\cp\zombies\zombie_scriptable_states::func_7383;
	level.var_11768 = ::scripts\cp\zombies\zombie_scriptable_states::func_12B9A;
	var_08 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_0A in var_08)
	{
		if(issubstr(var_0A.agent_type,"alien"))
		{
			var_0A.var_BCE4 = 0.9;
			var_0A.var_C081 = 1;
			var_0A.var_126E8 = 1;
		}
		else
		{
			var_0A scripts\mp\agents\_scriptedagents::func_F85E(0,"DoAttack");
		}

		var_0A.activated_venomx_sphere = 0;
		var_0A.var_C189 = 0;
		var_0A.var_9E0C = undefined;
		var_0A notify("unslow_zombie");
	}
}

//Function Number: 93
custom_unslow_func(param_00)
{
	param_00 endon("death");
	if(!isalive(param_00))
	{
		return;
	}

	param_00.var_180 = 0;
	param_00.nocorpse = undefined;
	param_00.full_gib = undefined;
	param_00.var_C189 = undefined;
}

//Function Number: 94
custom_slow_time_func(param_00)
{
	param_00 endon("death");
	param_00.var_9E0C = 1;
	param_00.var_180 = 1;
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	param_00.var_C189 = 1;
	param_00 waittill("unslow_zombie");
	param_00.var_9E0C = undefined;
}

//Function Number: 95
apply_slow_mo_on_trigger(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(var_03 istouching(self))
			{
				if(!scripts\common\utility::istrue(var_03.inside_slow_sphere))
				{
				}

				var_03.inside_slow_sphere = 1;
				continue;
			}

			if(scripts\common\utility::istrue(var_03.inside_slow_sphere))
			{
			}

			var_03.inside_slow_sphere = 0;
		}

		var_05 = scripts\cp\_agent_utils::func_7DB0("axis");
		level.zombie_list = var_05;
		foreach(var_07 in level.zombie_list)
		{
			if(!isdefined(var_07))
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(var_07 scripts\cp\_utility::agentisfnfimmune())
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(scripts\common\utility::istrue(var_07.dot_triggerd))
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(var_07 istouching(self))
			{
				if(!scripts\common\utility::istrue(var_07.dot_triggered))
				{
					if(isdefined(var_07))
					{
						if(isdefined(var_07.agent_type) && issubstr(var_07.agent_type,"alien"))
						{
							if(var_07.agent_type == "alien_rhino")
							{
								if(param_01 == 1)
								{
									var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,7,var_07.health / 3,"MOD_EXPLOSIVE","iw7_venomx_zm_pap1");
								}
								else
								{
									var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,3,var_07.health + 10000,"MOD_EXPLOSIVE","iw7_venomx_zm_pap2");
								}
							}

							if(var_07.agent_type == "alien_phantom")
							{
								if(param_01 == 1)
								{
									var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,7,var_07.health / 2,"MOD_EXPLOSIVE","iw7_venomx_zm_pap1");
								}
								else
								{
									var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,3,var_07.health + 10000,"MOD_EXPLOSIVE","iw7_venomx_zm_pap2");
								}
							}
							else if(param_01 == 1)
							{
								var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,7,var_07.health + 10000,"MOD_EXPLOSIVE","iw7_venomx_zm_pap1");
							}
							else
							{
								var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,3,var_07.health + 10000,"MOD_EXPLOSIVE","iw7_venomx_zm_pap2");
							}

							var_07.var_BCE4 = 0.2;
							var_07.var_C081 = 0.1;
							var_07.var_126E8 = 0.1;
						}
						else if(param_01 == 1)
						{
							var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,7,var_07.health + 10000,"MOD_EXPLOSIVE","iw7_venomx_zm_pap1");
						}
						else
						{
							var_07 thread scripts\cp\_utility::func_4D0D(var_07,param_00,3,var_07.health + 10000,"MOD_EXPLOSIVE","iw7_venomx_zm_pap2");
						}
					}
				}

				var_07 scripts\mp\agents\_scriptedagents::func_F85E(1,"DoAttack");
				var_07.activated_venomx_sphere = 1;
				var_07.var_C189 = 1;
				var_07.var_9E0C = 1;
				var_07.dot_triggered = 1;
				continue;
			}

			if(isdefined(var_07))
			{
				if(isdefined(var_07.agent_type) && !issubstr(var_07.agent_type,"alien"))
				{
					var_07 scripts\mp\agents\_scriptedagents::func_F85E(0,"DoAttack");
					var_07.activated_venomx_sphere = 0;
					var_07.var_C189 = 0;
					var_07.var_9E0C = undefined;
					var_07 notify("unslow_zombie");
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 96
finalqueststepregistration(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level.var_13F4D[param_00]))
	{
		level.var_13F4D[param_00] = [];
	}

	if(!isdefined(level.var_13F4C[param_00]))
	{
		level.var_13F4C[param_00] = -1;
	}

	var_08 = spawnstruct();
	var_08.var_95F2 = param_02;
	var_08.var_DB5D = param_03;
	var_08.var_446D = param_04;
	var_08.var_4EB1 = param_05;
	var_08.step_description = param_07;
	level.var_13F4D[param_00][param_01] = var_08;
}

//Function Number: 97
spawn_egg_interaction_for_players(param_00)
{
	level endon("delete_this_eggthread");
	var_01 = spawnstruct();
	var_01.script_noteworthy = "venomx_egg";
	var_01.origin = scripts\common\utility::func_5D14(param_00 + (0,0,10),0,-200);
	var_01.angles = (0,0,0);
	var_01.var_E1B9 = 0;
	var_01.var_D776 = 1;
	var_01.var_EE79 = "default";
	var_01.name = "venomx_egg";
	var_01.var_109DA = undefined;
	var_01.cost = 0;
	var_01.model = spawn("script_model",var_01.origin + (0,0,35));
	var_01.model setmodel("weapon_zmb_venomx_egg_static");
	var_01.model.angles = (180,0,0);
	var_01.var_8FFA = ::venomx_pickup_hint_func;
	var_01.var_161A = ::venomx_add_ammo;
	var_01.var_6261 = 1;
	var_01.disable_guided_interactions = 1;
	level.interactions[var_01.name] = var_01;
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	var_02 = gettime();
	var_01.model thread deletemodelaftertimeout(var_01,var_02);
	var_01.model thread spinegg();
}

//Function Number: 98
spinegg()
{
	self endon("death");
	wait(0.25);
	playfxontag(level._effect["vfx_eggsac_glow"],self,"tag_origin");
	for(;;)
	{
		self rotateyaw(36,0.1);
		wait(0.1);
	}
}

//Function Number: 99
deletemodelaftertimeout(param_00,param_01)
{
	self endon("death");
	while(gettime() <= param_01 + 20000)
	{
		scripts\common\utility::func_136F7();
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	level notify("delete_this_eggthread");
	param_00.model delete();
}

//Function Number: 100
venomx_pickup_hint_func(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_01 getweaponslistall();
	foreach(var_05 in var_03)
	{
		if(issubstr(var_05,"venomx"))
		{
			var_02 = 1;
			break;
		}
	}

	if(scripts\common\utility::istrue(var_02))
	{
		return &"CP_FINAL_VENOMX_AMMO";
	}

	return "";
}

//Function Number: 101
cangive_ammo(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00;
	var_02 = self getweaponammoclip(var_01);
	var_03 = weaponclipsize(var_01);
	var_04 = function_0249(var_01);
	var_05 = self getweaponammostock(var_01);
	if(var_05 < var_04 || var_02 < var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 102
give_ammo_to_player_through_egg(param_00)
{
	if(!scripts\cp\_utility::is_valid_player())
	{
		return;
	}

	var_01 = 0;
	var_02 = undefined;
	var_03 = self getweaponslistall();
	foreach(var_05 in var_03)
	{
		if(issubstr(var_05,"venomx"))
		{
			var_01 = 1;
			var_02 = var_05;
			break;
		}
	}

	if(!var_01)
	{
		self playlocalsound("perk_machine_deny");
		return;
	}

	var_07 = weaponclipsize(var_02);
	adjust_clip_ammo_from_stock(self,var_02,"right",var_07,0);
	self playlocalsound("weap_ammo_pickup");
}

//Function Number: 103
adjust_clip_ammo_from_stock(param_00,param_01,param_02,param_03,param_04)
{
	if(!scripts\common\utility::istrue(param_04))
	{
		var_05 = function_0249(param_01);
		var_06 = param_00 getweaponammostock(param_01);
		var_07 = var_05 - var_06;
		var_08 = scripts\common\utility::func_116D7(var_07 >= param_03,var_06 + param_03,var_05);
		param_00 setweaponammostock(param_01,var_08);
	}

	var_09 = param_00 getweaponammoclip(param_01,param_02);
	var_0A = param_03 - var_09;
	var_0B = min(var_09 + var_0A,param_03);
	param_00 setweaponammoclip(param_01,int(var_0B),param_02);
}

//Function Number: 104
venomx_add_ammo(param_00,param_01)
{
	var_02 = undefined;
	var_03 = param_01 getweaponslistall();
	foreach(var_05 in var_03)
	{
		if(issubstr(var_05,"venomx"))
		{
			var_02 = var_05;
			break;
		}
	}

	if(param_01 cangive_ammo(var_02))
	{
		param_01 give_ammo_to_player_through_egg(var_02);
		param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,0,50);
		scripts\common\utility::func_136F7();
		playfx(level._effect["vfx_eggsac_pup"],param_00.model.origin);
		param_00.model delete();
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		return;
	}

	param_01 scripts\cp\_utility::setlowermessage("max_ammo",&"COOP_GAME_PLAY_AMMO_MAX",3);
	param_01 playlocalsound("perk_machine_deny");
}

//Function Number: 105
questdevguientries(param_00,param_01,param_02,param_03)
{
}

//Function Number: 106
is_this_position_safe(param_00,param_01,param_02,param_03,param_04)
{
	if(param_01 < 0 || param_01 >= 6)
	{
		return 0;
	}

	if(param_02 < 0 || param_02 >= 6)
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(param_00[param_04.xcoord][param_04.ycoord].wall_directions,param_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 107
runmazeinstanceforpoint(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(is_this_position_safe(param_00,param_01,param_02,param_03,param_04))
	{
		param_00[param_01][param_02].var_13484 = 1;
		if(param_01 == level.maze_attributes[param_04.mod_name].endpoint_x && param_02 == level.maze_attributes[param_04.mod_name].endpoint_y)
		{
			param_05 thread scripts\cp\_vo::try_to_play_vo("quest_venx_puzzle_success","final_comment_vo");
			level.puzzles_solved++;
			if(param_04.newmodelsspawned == 3 && param_04.othermodel.newmodelsspawned == 1)
			{
				level.maze_completed[param_04.mod_name] = 1;
			}
			else if(param_04.newmodelsspawned == 2 && param_04.othermodel.newmodelsspawned == 2)
			{
				level.maze_completed[param_04.mod_name] = 1;
			}
			else if(param_04.newmodelsspawned == 1 && param_04.othermodel.newmodelsspawned == 3)
			{
				level.maze_completed[param_04.mod_name] = 1;
			}

			if(level.puzzles_solved >= 4)
			{
				level.maze_completed["maze1"] = 1;
				level.maze_completed["maze2"] = 1;
				level thread disable_solved_grids();
				foreach(var_08 in level.players)
				{
					var_08 playlocalsound("zmb_item_pickup");
				}

				scripts\common\utility::flag_set("completepuzzles_step4");
				level thread disable_scriptables_for_mazes(param_04);
				param_04.xcoord = param_01;
				param_04.ycoord = param_02;
				var_0A = return_position_x_y(param_01,param_02,param_04);
				param_04 moveto(var_0A,0.1);
				param_05 thread scripts\cp\_vo::try_to_play_vo("quest_venx_puzzle_all_complete","final_comment_vo");
				param_05 notify("end_thread_for_" + param_04.mod_name);
			}
			else if(!scripts\common\utility::istrue(level.maze_completed[param_04.mod_name]))
			{
				param_04.newmodelsspawned++;
				level thread disable_scriptables_for_mazes(param_04);
				level thread start_maze_instance_on_model(param_05,param_04,param_06);
			}
			else
			{
				level thread disable_scriptables_for_mazes(param_04);
			}
		}

		param_04.xcoord = param_01;
		param_04.ycoord = param_02;
		var_0A = return_position_x_y(param_01,param_02,param_04);
		param_04 moveto(var_0A,0.1);
		return;
	}

	param_05 thread scripts\cp\_vo::try_to_play_vo("quest_venx_puzzle_fail","final_comment_vo");
	level.test_model.newmodelsspawned = 1;
	level.test_model_2.newmodelsspawned = 1;
	level.maze_completed["maze1"] = 0;
	level.maze_completed["maze2"] = 0;
	playfx(level._effect["temp_circuit_fx"],param_04.origin);
	param_05 playlocalsound("cp_final_venom_quest_fail_maze");
	param_05 playrumbleonentity("damage_light");
	level.failed_puzzle = 1;
	level.puzzles_solved = 0;
}

//Function Number: 108
show_unsolved_mazes_on_crt()
{
	wait(15);
	level.unsolved_crt_model = getent("unsolved_console_venomx","script_noteworthy");
	level.unsolved_crt_model setscriptablepartstate("unsolved_grid","neutral");
	level.unsolved_crt_model_2 = getent("unsolved_console_venomx_2","script_noteworthy");
	level.unsolved_crt_model_2 setscriptablepartstate("unsolved_grid","neutral");
	level thread setup_maze_models();
}

//Function Number: 109
display_maze_hints_on_crt()
{
	wait(10);
	foreach(var_01 in level.array_of_small_crt_script_models)
	{
		var_01 setscriptablepartstate("solved_grid","neutral");
	}
}

//Function Number: 110
random_maze_roll()
{
	for(;;)
	{
		var_00 = randomintrange(0,11);
		if(level.mazerollsarray.size >= 11)
		{
			level.mazerollsarray = [];
		}

		if(!scripts\common\utility::func_2286(level.mazerollsarray,var_00))
		{
			level.mazerollsarray[level.mazerollsarray.size] = var_00;
			return var_00;
		}
		else
		{
			scripts\common\utility::func_136F7();
			continue;
		}
	}
}

//Function Number: 111
choose_start_end_mazepos(param_00,param_01)
{
	level.maze_attributes[param_00.mod_name].endpoint_x = 0;
	level.maze_attributes[param_00.mod_name].endpoint_y = 0;
	param_00.xcoord = 0;
	param_00.ycoord = 0;
	switch(param_01)
	{
		case 0:
			param_00.xcoord = 4;
			param_00.ycoord = 4;
			level.maze_attributes[param_00.mod_name].endpoint_x = 2;
			level.maze_attributes[param_00.mod_name].endpoint_y = 2;
			break;

		case 1:
			param_00.xcoord = 3;
			param_00.ycoord = 2;
			level.maze_attributes[param_00.mod_name].endpoint_x = 4;
			level.maze_attributes[param_00.mod_name].endpoint_y = 1;
			break;

		case 2:
			param_00.xcoord = 3;
			param_00.ycoord = 4;
			level.maze_attributes[param_00.mod_name].endpoint_x = 2;
			level.maze_attributes[param_00.mod_name].endpoint_y = 1;
			break;

		case 3:
			param_00.xcoord = 3;
			param_00.ycoord = 1;
			level.maze_attributes[param_00.mod_name].endpoint_x = 1;
			level.maze_attributes[param_00.mod_name].endpoint_y = 2;
			break;

		case 4:
			param_00.xcoord = 3;
			param_00.ycoord = 1;
			level.maze_attributes[param_00.mod_name].endpoint_x = 0;
			level.maze_attributes[param_00.mod_name].endpoint_y = 4;
			break;

		case 5:
			param_00.xcoord = 1;
			param_00.ycoord = 1;
			level.maze_attributes[param_00.mod_name].endpoint_x = 4;
			level.maze_attributes[param_00.mod_name].endpoint_y = 3;
			break;

		case 6:
			param_00.xcoord = 4;
			param_00.ycoord = 5;
			level.maze_attributes[param_00.mod_name].endpoint_x = 3;
			level.maze_attributes[param_00.mod_name].endpoint_y = 3;
			break;

		case 7:
			param_00.xcoord = 1;
			param_00.ycoord = 4;
			level.maze_attributes[param_00.mod_name].endpoint_x = 5;
			level.maze_attributes[param_00.mod_name].endpoint_y = 0;
			break;

		case 8:
			param_00.xcoord = 2;
			param_00.ycoord = 0;
			level.maze_attributes[param_00.mod_name].endpoint_x = 2;
			level.maze_attributes[param_00.mod_name].endpoint_y = 3;
			break;

		case 9:
			param_00.xcoord = 1;
			param_00.ycoord = 2;
			level.maze_attributes[param_00.mod_name].endpoint_x = 5;
			level.maze_attributes[param_00.mod_name].endpoint_y = 3;
			break;

		case 10:
			param_00.xcoord = 1;
			param_00.ycoord = 2;
			level.maze_attributes[param_00.mod_name].endpoint_x = 4;
			level.maze_attributes[param_00.mod_name].endpoint_y = 4;
			break;

		case 11:
			param_00.xcoord = 0;
			param_00.ycoord = 1;
			level.maze_attributes[param_00.mod_name].endpoint_x = 5;
			level.maze_attributes[param_00.mod_name].endpoint_y = 3;
			break;

		case 12:
			param_00.xcoord = 0;
			param_00.ycoord = 5;
			level.maze_attributes[param_00.mod_name].endpoint_x = 3;
			level.maze_attributes[param_00.mod_name].endpoint_y = 4;
			break;

		case 13:
			param_00.xcoord = 0;
			param_00.ycoord = 4;
			level.maze_attributes[param_00.mod_name].endpoint_x = 4;
			level.maze_attributes[param_00.mod_name].endpoint_y = 2;
			break;

		case 14:
			param_00.xcoord = 0;
			param_00.ycoord = 5;
			level.maze_attributes[param_00.mod_name].endpoint_x = 4;
			level.maze_attributes[param_00.mod_name].endpoint_y = 0;
			break;

		case 15:
			param_00.xcoord = 2;
			param_00.ycoord = 0;
			level.maze_attributes[param_00.mod_name].endpoint_x = 2;
			level.maze_attributes[param_00.mod_name].endpoint_y = 3;
			break;

		default:
			break;
	}

	param_00.origin = return_position_x_y(param_00.xcoord,param_00.ycoord,param_00);
}

//Function Number: 112
store_wall_directions(param_00,param_01)
{
	switch(param_01)
	{
		case 0:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["left"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left","down"];
			param_00.maze[2][1].wall_directions = ["down","up"];
			param_00.maze[3][1].wall_directions = ["up","left","down"];
			param_00.maze[4][1].wall_directions = ["up"];
			param_00.maze[5][1].wall_directions = ["down"];
			param_00.maze[0][2].wall_directions = ["up","down"];
			param_00.maze[1][2].wall_directions = ["up","down"];
			param_00.maze[2][2].wall_directions = ["up","down"];
			param_00.maze[3][2].wall_directions = ["up","down"];
			param_00.maze[4][2].wall_directions = ["up","right"];
			param_00.maze[5][2].wall_directions = ["down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["up","down"];
			param_00.maze[2][3].wall_directions = ["up"];
			param_00.maze[3][3].wall_directions = ["right","down"];
			param_00.maze[4][3].wall_directions = ["up","left"];
			param_00.maze[5][3].wall_directions = ["down"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","down"];
			param_00.maze[2][4].wall_directions = ["down","up","right"];
			param_00.maze[3][4].wall_directions = ["up","left"];
			param_00.maze[4][4].wall_directions = ["down","right"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right","down"];
			param_00.maze[1][5].wall_directions = ["right","up"];
			param_00.maze[2][5].wall_directions = ["right","left"];
			param_00.maze[3][5].wall_directions = ["right","down"];
			param_00.maze[4][5].wall_directions = ["left","right","up"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 1:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["left"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["down","left"];
			param_00.maze[3][1].wall_directions = ["up","down","left"];
			param_00.maze[4][1].wall_directions = ["up","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up","right"];
			param_00.maze[1][2].wall_directions = ["down","right"];
			param_00.maze[2][2].wall_directions = ["up","down"];
			param_00.maze[3][2].wall_directions = ["up","down"];
			param_00.maze[4][2].wall_directions = ["up","down"];
			param_00.maze[5][2].wall_directions = ["up","down"];
			param_00.maze[0][3].wall_directions = ["up","right","left"];
			param_00.maze[1][3].wall_directions = ["down","left"];
			param_00.maze[2][3].wall_directions = ["up"];
			param_00.maze[3][3].wall_directions = ["right","down"];
			param_00.maze[4][3].wall_directions = ["up","down"];
			param_00.maze[5][3].wall_directions = ["down","up"];
			param_00.maze[0][4].wall_directions = ["up","down","left"];
			param_00.maze[1][4].wall_directions = ["up","right"];
			param_00.maze[2][4].wall_directions = ["down","right"];
			param_00.maze[3][4].wall_directions = ["up","left"];
			param_00.maze[4][4].wall_directions = ["right","down"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right","left"];
			param_00.maze[3][5].wall_directions = ["right","down"];
			param_00.maze[4][5].wall_directions = ["up","right","left"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 2:
			param_00.maze[0][0].wall_directions = ["up","left","down"];
			param_00.maze[1][0].wall_directions = ["up","left"];
			param_00.maze[2][0].wall_directions = ["left"];
			param_00.maze[3][0].wall_directions = ["left"];
			param_00.maze[4][0].wall_directions = ["left","right"];
			param_00.maze[5][0].wall_directions = ["down","left","right"];
			param_00.maze[0][1].wall_directions = ["up"];
			param_00.maze[1][1].wall_directions = ["right"];
			param_00.maze[2][1].wall_directions = ["down"];
			param_00.maze[3][1].wall_directions = ["up","right","down"];
			param_00.maze[4][1].wall_directions = ["up","left"];
			param_00.maze[5][1].wall_directions = ["down","left"];
			param_00.maze[0][2].wall_directions = ["up","right"];
			param_00.maze[1][2].wall_directions = ["left","down","right"];
			param_00.maze[2][2].wall_directions = ["up","right"];
			param_00.maze[3][2].wall_directions = ["left","right"];
			param_00.maze[4][2].wall_directions = ["down","right"];
			param_00.maze[5][2].wall_directions = ["down","up"];
			param_00.maze[0][3].wall_directions = ["up","left"];
			param_00.maze[1][3].wall_directions = ["left","down","right"];
			param_00.maze[2][3].wall_directions = ["up","left"];
			param_00.maze[3][3].wall_directions = ["right","left"];
			param_00.maze[4][3].wall_directions = ["down","left"];
			param_00.maze[5][3].wall_directions = ["down","up"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","left","right"];
			param_00.maze[2][4].wall_directions = ["down"];
			param_00.maze[3][4].wall_directions = ["up","left","down"];
			param_00.maze[4][4].wall_directions = ["down","up"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right","down"];
			param_00.maze[3][5].wall_directions = ["right","up"];
			param_00.maze[4][5].wall_directions = ["right"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 3:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["down","left","right"];
			param_00.maze[4][0].wall_directions = ["left","up"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["down","left"];
			param_00.maze[3][1].wall_directions = ["up","right","left"];
			param_00.maze[4][1].wall_directions = ["down"];
			param_00.maze[5][1].wall_directions = ["up","down","right"];
			param_00.maze[0][2].wall_directions = ["up","down"];
			param_00.maze[1][2].wall_directions = ["down","up"];
			param_00.maze[2][2].wall_directions = ["up","right"];
			param_00.maze[3][2].wall_directions = ["left","down"];
			param_00.maze[4][2].wall_directions = ["up","right"];
			param_00.maze[5][2].wall_directions = ["left","down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["down","up"];
			param_00.maze[2][3].wall_directions = ["up","left"];
			param_00.maze[3][3].wall_directions = ["right","down"];
			param_00.maze[4][3].wall_directions = ["up","left"];
			param_00.maze[5][3].wall_directions = ["down"];
			param_00.maze[0][4].wall_directions = ["up","right"];
			param_00.maze[1][4].wall_directions = ["down","right"];
			param_00.maze[2][4].wall_directions = ["down","up"];
			param_00.maze[3][4].wall_directions = ["up","left"];
			param_00.maze[4][4].wall_directions = ["right","down"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right","left"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right"];
			param_00.maze[3][5].wall_directions = ["right","down"];
			param_00.maze[4][5].wall_directions = ["up","right","left"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 4:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["left","right","down"];
			param_00.maze[3][0].wall_directions = ["right","left","up"];
			param_00.maze[4][0].wall_directions = ["left","down"];
			param_00.maze[5][0].wall_directions = ["down","left","up"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["left","right"];
			param_00.maze[3][1].wall_directions = ["left","down"];
			param_00.maze[4][1].wall_directions = ["up","right"];
			param_00.maze[5][1].wall_directions = ["down"];
			param_00.maze[0][2].wall_directions = ["up","down"];
			param_00.maze[1][2].wall_directions = ["up","right"];
			param_00.maze[2][2].wall_directions = ["left","down"];
			param_00.maze[3][2].wall_directions = ["up","down"];
			param_00.maze[4][2].wall_directions = ["up","left"];
			param_00.maze[5][2].wall_directions = ["down","right"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["up","left"];
			param_00.maze[2][3].wall_directions = ["down","right"];
			param_00.maze[3][3].wall_directions = ["right","up"];
			param_00.maze[4][3].wall_directions = ["down","right"];
			param_00.maze[5][3].wall_directions = ["up","left","down"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","right"];
			param_00.maze[2][4].wall_directions = ["down","left"];
			param_00.maze[3][4].wall_directions = ["up","left","right"];
			param_00.maze[4][4].wall_directions = ["left"];
			param_00.maze[5][4].wall_directions = ["down"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right"];
			param_00.maze[3][5].wall_directions = ["right","left"];
			param_00.maze[4][5].wall_directions = ["down","right"];
			param_00.maze[5][5].wall_directions = ["down","right","up"];
			break;

		case 5:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["right","left"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["down","left"];
			param_00.maze[3][1].wall_directions = ["up","left"];
			param_00.maze[4][1].wall_directions = ["left","down"];
			param_00.maze[5][1].wall_directions = ["up","down","right"];
			param_00.maze[0][2].wall_directions = ["up"];
			param_00.maze[1][2].wall_directions = ["down","right"];
			param_00.maze[2][2].wall_directions = ["up","right"];
			param_00.maze[3][2].wall_directions = ["right","down"];
			param_00.maze[4][2].wall_directions = ["up","right"];
			param_00.maze[5][2].wall_directions = ["left","down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["down","left","up"];
			param_00.maze[2][3].wall_directions = ["up","left","right"];
			param_00.maze[3][3].wall_directions = ["right","left"];
			param_00.maze[4][3].wall_directions = ["left","down"];
			param_00.maze[5][3].wall_directions = ["down","up"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up"];
			param_00.maze[2][4].wall_directions = ["left","right"];
			param_00.maze[3][4].wall_directions = ["down","left"];
			param_00.maze[4][4].wall_directions = ["up","down"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","down"];
			param_00.maze[2][5].wall_directions = ["right","left","up"];
			param_00.maze[3][5].wall_directions = ["right","down"];
			param_00.maze[4][5].wall_directions = ["up","right"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 6:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["down","left"];
			param_00.maze[2][0].wall_directions = ["left","up"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["left","right"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","right","down"];
			param_00.maze[2][1].wall_directions = ["up","right","down"];
			param_00.maze[3][1].wall_directions = ["up","left","down"];
			param_00.maze[4][1].wall_directions = ["up","left"];
			param_00.maze[5][1].wall_directions = ["down","right"];
			param_00.maze[0][2].wall_directions = ["up"];
			param_00.maze[1][2].wall_directions = ["left","right"];
			param_00.maze[2][2].wall_directions = ["left"];
			param_00.maze[3][2].wall_directions = ["down"];
			param_00.maze[4][2].wall_directions = ["up","down"];
			param_00.maze[5][2].wall_directions = ["down","up","left"];
			param_00.maze[0][3].wall_directions = ["up"];
			param_00.maze[1][3].wall_directions = ["left","down","right"];
			param_00.maze[2][3].wall_directions = ["up","down"];
			param_00.maze[3][3].wall_directions = ["right","down","up"];
			param_00.maze[4][3].wall_directions = ["up","down"];
			param_00.maze[5][3].wall_directions = ["down","up"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","left"];
			param_00.maze[2][4].wall_directions = ["down","right"];
			param_00.maze[3][4].wall_directions = ["up","left"];
			param_00.maze[4][4].wall_directions = ["down","right"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right","down"];
			param_00.maze[1][5].wall_directions = ["right","up"];
			param_00.maze[2][5].wall_directions = ["right","left"];
			param_00.maze[3][5].wall_directions = ["right"];
			param_00.maze[4][5].wall_directions = ["left","right"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 7:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["down","left"];
			param_00.maze[2][0].wall_directions = ["up","left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["left","right"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","down"];
			param_00.maze[2][1].wall_directions = ["up","right"];
			param_00.maze[3][1].wall_directions = ["left","right"];
			param_00.maze[4][1].wall_directions = ["left","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up","down"];
			param_00.maze[1][2].wall_directions = ["up","right"];
			param_00.maze[2][2].wall_directions = ["left","right"];
			param_00.maze[3][2].wall_directions = ["left","right"];
			param_00.maze[4][2].wall_directions = ["right","down"];
			param_00.maze[5][2].wall_directions = ["up","down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["up","left"];
			param_00.maze[2][3].wall_directions = ["left","down"];
			param_00.maze[3][3].wall_directions = ["up","left"];
			param_00.maze[4][3].wall_directions = ["left","down"];
			param_00.maze[5][3].wall_directions = ["down","up"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","right","down"];
			param_00.maze[2][4].wall_directions = ["down","up"];
			param_00.maze[3][4].wall_directions = ["up","down"];
			param_00.maze[4][4].wall_directions = ["right","up"];
			param_00.maze[5][4].wall_directions = ["down","right"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left","down"];
			param_00.maze[2][5].wall_directions = ["right","up"];
			param_00.maze[3][5].wall_directions = ["right"];
			param_00.maze[4][5].wall_directions = ["right","left"];
			param_00.maze[5][5].wall_directions = ["down","right","left"];
			break;

		case 8:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["left"];
			param_00.maze[3][0].wall_directions = ["down","left","right"];
			param_00.maze[4][0].wall_directions = ["left","up"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left","down"];
			param_00.maze[2][1].wall_directions = ["up","right"];
			param_00.maze[3][1].wall_directions = ["right","left"];
			param_00.maze[4][1].wall_directions = ["right","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up","down"];
			param_00.maze[1][2].wall_directions = ["up"];
			param_00.maze[2][2].wall_directions = ["left","right"];
			param_00.maze[3][2].wall_directions = ["left","down"];
			param_00.maze[4][2].wall_directions = ["up","left"];
			param_00.maze[5][2].wall_directions = ["right","down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["down","up"];
			param_00.maze[2][3].wall_directions = ["up","left","right"];
			param_00.maze[3][3].wall_directions = ["down"];
			param_00.maze[4][3].wall_directions = ["up","down","right"];
			param_00.maze[5][3].wall_directions = ["down","left","up"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","right"];
			param_00.maze[2][4].wall_directions = ["down","left"];
			param_00.maze[3][4].wall_directions = ["up","right"];
			param_00.maze[4][4].wall_directions = ["right","left"];
			param_00.maze[5][4].wall_directions = ["down"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right","down"];
			param_00.maze[3][5].wall_directions = ["right","up","left"];
			param_00.maze[4][5].wall_directions = ["right","left"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 9:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["left","right","down"];
			param_00.maze[5][0].wall_directions = ["down","left","up"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["right","left"];
			param_00.maze[3][1].wall_directions = ["right","left"];
			param_00.maze[4][1].wall_directions = ["left","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up"];
			param_00.maze[1][2].wall_directions = ["down","right"];
			param_00.maze[2][2].wall_directions = ["up","left"];
			param_00.maze[3][2].wall_directions = ["left","down"];
			param_00.maze[4][2].wall_directions = ["up","right"];
			param_00.maze[5][2].wall_directions = ["right","down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["up","left"];
			param_00.maze[2][3].wall_directions = ["right","down"];
			param_00.maze[3][3].wall_directions = ["up","right"];
			param_00.maze[4][3].wall_directions = ["left","down"];
			param_00.maze[5][3].wall_directions = ["down","up","left"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","down"];
			param_00.maze[2][4].wall_directions = ["up","left"];
			param_00.maze[3][4].wall_directions = ["right","left","down"];
			param_00.maze[4][4].wall_directions = ["right","up"];
			param_00.maze[5][4].wall_directions = ["down"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","down"];
			param_00.maze[2][5].wall_directions = ["right","up"];
			param_00.maze[3][5].wall_directions = ["right","left"];
			param_00.maze[4][5].wall_directions = ["right","left"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 10:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["down","left"];
			param_00.maze[2][0].wall_directions = ["left","up","right"];
			param_00.maze[3][0].wall_directions = ["left"];
			param_00.maze[4][0].wall_directions = ["left"];
			param_00.maze[5][0].wall_directions = ["down","left","right"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","right"];
			param_00.maze[2][1].wall_directions = ["down","left"];
			param_00.maze[3][1].wall_directions = ["up","right","down"];
			param_00.maze[4][1].wall_directions = ["up","right"];
			param_00.maze[5][1].wall_directions = ["down","left"];
			param_00.maze[0][2].wall_directions = ["up","right"];
			param_00.maze[1][2].wall_directions = ["left","down"];
			param_00.maze[2][2].wall_directions = ["up","right"];
			param_00.maze[3][2].wall_directions = ["left","right"];
			param_00.maze[4][2].wall_directions = ["left","down"];
			param_00.maze[5][2].wall_directions = ["down","up"];
			param_00.maze[0][3].wall_directions = ["up","left"];
			param_00.maze[1][3].wall_directions = ["right","down"];
			param_00.maze[2][3].wall_directions = ["up","left"];
			param_00.maze[3][3].wall_directions = ["right","down","left"];
			param_00.maze[4][3].wall_directions = ["up","right"];
			param_00.maze[5][3].wall_directions = ["down"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","left"];
			param_00.maze[2][4].wall_directions = ["right"];
			param_00.maze[3][4].wall_directions = ["right","left"];
			param_00.maze[4][4].wall_directions = ["down","left"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right","down"];
			param_00.maze[1][5].wall_directions = ["right","up"];
			param_00.maze[2][5].wall_directions = ["right","left"];
			param_00.maze[3][5].wall_directions = ["right","down","left"];
			param_00.maze[4][5].wall_directions = ["right","up"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 11:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["down","left"];
			param_00.maze[2][0].wall_directions = ["right","left","up"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["left"];
			param_00.maze[5][0].wall_directions = ["down","left","right"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","right"];
			param_00.maze[2][1].wall_directions = ["right","left"];
			param_00.maze[3][1].wall_directions = ["down","left"];
			param_00.maze[4][1].wall_directions = ["up"];
			param_00.maze[5][1].wall_directions = ["left","down"];
			param_00.maze[0][2].wall_directions = ["up","right"];
			param_00.maze[1][2].wall_directions = ["down","right","left"];
			param_00.maze[2][2].wall_directions = ["up","left"];
			param_00.maze[3][2].wall_directions = ["right","down"];
			param_00.maze[4][2].wall_directions = ["up","down","right"];
			param_00.maze[5][2].wall_directions = ["up","down"];
			param_00.maze[0][3].wall_directions = ["up","left"];
			param_00.maze[1][3].wall_directions = ["down","left","right"];
			param_00.maze[2][3].wall_directions = ["up","right"];
			param_00.maze[3][3].wall_directions = ["right","left"];
			param_00.maze[4][3].wall_directions = ["right","left"];
			param_00.maze[5][3].wall_directions = ["down"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","left"];
			param_00.maze[2][4].wall_directions = ["down","left"];
			param_00.maze[3][4].wall_directions = ["up","left"];
			param_00.maze[4][4].wall_directions = ["left"];
			param_00.maze[5][4].wall_directions = ["down"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","down"];
			param_00.maze[2][5].wall_directions = ["right","up"];
			param_00.maze[3][5].wall_directions = ["right"];
			param_00.maze[4][5].wall_directions = ["right"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 12:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["right","left"];
			param_00.maze[5][0].wall_directions = ["down","left","right"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["left","right"];
			param_00.maze[3][1].wall_directions = ["left","down"];
			param_00.maze[4][1].wall_directions = ["up","left"];
			param_00.maze[5][1].wall_directions = ["down","left"];
			param_00.maze[0][2].wall_directions = ["up","right"];
			param_00.maze[1][2].wall_directions = ["right","down"];
			param_00.maze[2][2].wall_directions = ["up","left"];
			param_00.maze[3][2].wall_directions = ["right","down"];
			param_00.maze[4][2].wall_directions = ["up","down"];
			param_00.maze[5][2].wall_directions = ["down","up"];
			param_00.maze[0][3].wall_directions = ["up","left"];
			param_00.maze[1][3].wall_directions = ["left","right"];
			param_00.maze[2][3].wall_directions = ["down"];
			param_00.maze[3][3].wall_directions = ["left","up"];
			param_00.maze[4][3].wall_directions = ["down","right"];
			param_00.maze[5][3].wall_directions = ["down","up"];
			param_00.maze[0][4].wall_directions = ["up"];
			param_00.maze[1][4].wall_directions = ["left","down"];
			param_00.maze[2][4].wall_directions = ["down","up","right"];
			param_00.maze[3][4].wall_directions = ["down","up","right"];
			param_00.maze[4][4].wall_directions = ["down","up","left"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right","down"];
			param_00.maze[1][5].wall_directions = ["right","up"];
			param_00.maze[2][5].wall_directions = ["right","left"];
			param_00.maze[3][5].wall_directions = ["right","left"];
			param_00.maze[4][5].wall_directions = ["right"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 13:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["right","left"];
			param_00.maze[4][0].wall_directions = ["right","left"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left"];
			param_00.maze[2][1].wall_directions = ["down","left"];
			param_00.maze[3][1].wall_directions = ["up","right","left"];
			param_00.maze[4][1].wall_directions = ["left","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up"];
			param_00.maze[1][2].wall_directions = ["down","right"];
			param_00.maze[2][2].wall_directions = ["up","right"];
			param_00.maze[3][2].wall_directions = ["left","down"];
			param_00.maze[4][2].wall_directions = ["up","right"];
			param_00.maze[5][2].wall_directions = ["right","down"];
			param_00.maze[0][3].wall_directions = ["up","right"];
			param_00.maze[1][3].wall_directions = ["down","left"];
			param_00.maze[2][3].wall_directions = ["up","left"];
			param_00.maze[3][3].wall_directions = ["down"];
			param_00.maze[4][3].wall_directions = ["up","left"];
			param_00.maze[5][3].wall_directions = ["down","left"];
			param_00.maze[0][4].wall_directions = ["up","down","left"];
			param_00.maze[1][4].wall_directions = ["up","down"];
			param_00.maze[2][4].wall_directions = ["down","up"];
			param_00.maze[3][4].wall_directions = ["up","right","down"];
			param_00.maze[4][4].wall_directions = ["up","right","down"];
			param_00.maze[5][4].wall_directions = ["down","up"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","down"];
			param_00.maze[2][5].wall_directions = ["right","up"];
			param_00.maze[3][5].wall_directions = ["right","left"];
			param_00.maze[4][5].wall_directions = ["right","left"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		case 14:
			param_00.maze[0][0].wall_directions = ["up","left","right"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["right","left"];
			param_00.maze[3][0].wall_directions = ["left"];
			param_00.maze[4][0].wall_directions = ["left"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","left"];
			param_00.maze[1][1].wall_directions = ["right","left"];
			param_00.maze[2][1].wall_directions = ["down","left"];
			param_00.maze[3][1].wall_directions = ["up","down"];
			param_00.maze[4][1].wall_directions = ["up","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up"];
			param_00.maze[1][2].wall_directions = ["left","down"];
			param_00.maze[2][2].wall_directions = ["up","down"];
			param_00.maze[3][2].wall_directions = ["up","down","right"];
			param_00.maze[4][2].wall_directions = ["up","down"];
			param_00.maze[5][2].wall_directions = ["up","down"];
			param_00.maze[0][3].wall_directions = ["up","down","right"];
			param_00.maze[1][3].wall_directions = ["up","down"];
			param_00.maze[2][3].wall_directions = ["up","right"];
			param_00.maze[3][3].wall_directions = ["right","left"];
			param_00.maze[4][3].wall_directions = ["right","down"];
			param_00.maze[5][3].wall_directions = ["up","down"];
			param_00.maze[0][4].wall_directions = ["up","left"];
			param_00.maze[1][4].wall_directions = ["right","down"];
			param_00.maze[2][4].wall_directions = ["up","left"];
			param_00.maze[3][4].wall_directions = ["down","left","right"];
			param_00.maze[4][4].wall_directions = ["up","left"];
			param_00.maze[5][4].wall_directions = ["down","right"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right","down"];
			param_00.maze[3][5].wall_directions = ["right","up","left"];
			param_00.maze[4][5].wall_directions = ["right"];
			param_00.maze[5][5].wall_directions = ["down","right","left"];
			break;

		case 15:
			param_00.maze[0][0].wall_directions = ["up","left"];
			param_00.maze[1][0].wall_directions = ["right","left"];
			param_00.maze[2][0].wall_directions = ["left"];
			param_00.maze[3][0].wall_directions = ["down","left","right"];
			param_00.maze[4][0].wall_directions = ["left","up"];
			param_00.maze[5][0].wall_directions = ["down","left"];
			param_00.maze[0][1].wall_directions = ["up","down"];
			param_00.maze[1][1].wall_directions = ["up","left","down"];
			param_00.maze[2][1].wall_directions = ["up","right"];
			param_00.maze[3][1].wall_directions = ["right","left"];
			param_00.maze[4][1].wall_directions = ["right","down"];
			param_00.maze[5][1].wall_directions = ["up","down"];
			param_00.maze[0][2].wall_directions = ["up","down"];
			param_00.maze[1][2].wall_directions = ["up"];
			param_00.maze[2][2].wall_directions = ["left","right"];
			param_00.maze[3][2].wall_directions = ["left","down"];
			param_00.maze[4][2].wall_directions = ["up","left"];
			param_00.maze[5][2].wall_directions = ["right","down"];
			param_00.maze[0][3].wall_directions = ["up","down"];
			param_00.maze[1][3].wall_directions = ["down","up"];
			param_00.maze[2][3].wall_directions = ["up","left","right"];
			param_00.maze[3][3].wall_directions = ["down"];
			param_00.maze[4][3].wall_directions = ["up","down","right"];
			param_00.maze[5][3].wall_directions = ["down","left","up"];
			param_00.maze[0][4].wall_directions = ["up","down"];
			param_00.maze[1][4].wall_directions = ["up","right"];
			param_00.maze[2][4].wall_directions = ["down","left"];
			param_00.maze[3][4].wall_directions = ["up","right"];
			param_00.maze[4][4].wall_directions = ["right","left"];
			param_00.maze[5][4].wall_directions = ["down"];
			param_00.maze[0][5].wall_directions = ["up","right"];
			param_00.maze[1][5].wall_directions = ["right","left"];
			param_00.maze[2][5].wall_directions = ["right","down"];
			param_00.maze[3][5].wall_directions = ["right","up","left"];
			param_00.maze[4][5].wall_directions = ["right","left"];
			param_00.maze[5][5].wall_directions = ["down","right"];
			break;

		default:
			break;
	}
}

//Function Number: 113
createmaze(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_04 thread control_puzzle_cursor(param_00);
		var_04 thread control_puzzle_cursor(param_01);
	}

	level.maze_attributes = [];
	level.random_maze_roll = [];
	level.maze_attributes[param_00.mod_name] = spawnstruct();
	level.maze_attributes[param_00.mod_name].maze = [];
	level.maze_attributes[param_01.mod_name] = spawnstruct();
	level.maze_attributes[param_01.mod_name].maze = [];
	for(var_06 = 0;var_06 < 6;var_06++)
	{
		for(var_07 = 0;var_07 < 6;var_07++)
		{
			foreach(var_09 in level.maze_attributes)
			{
				var_09.maze[var_06][var_07] = spawnstruct();
				var_09.maze[var_06][var_07].wall_directions = [];
				var_09.maze[var_06][var_07].var_13484 = 0;
			}
		}
	}

	param_00 setscriptablepartstate("maze_puzzle","cursor");
	param_01 setscriptablepartstate("maze_puzzle","cursor");
	foreach(var_0E, var_0C in level.array_of_small_crt_script_models)
	{
		var_0D = var_0E;
		if(var_0D > 10)
		{
			var_0D = randomintrange(0,11);
		}

		var_0C setscriptablepartstate("solved_grid","solved_puzzle_" + var_0D);
	}

	if(!isdefined(level.mazerollsarray))
	{
		level.mazerollsarray = [];
	}

	foreach(var_0E, var_10 in level.maze_attributes)
	{
		level.random_maze_roll[var_0E] = random_maze_roll();
		level thread store_wall_directions(var_10,level.random_maze_roll[var_0E]);
	}

	level thread choose_start_end_mazepos(param_00,level.random_maze_roll["maze1"]);
	level.unsolved_crt_model setscriptablepartstate("unsolved_grid","unsolved_maze_" + level.random_maze_roll["maze1"]);
	level thread choose_start_end_mazepos(param_01,level.random_maze_roll["maze2"]);
	level.unsolved_crt_model_2 setscriptablepartstate("unsolved_grid","unsolved_maze_" + level.random_maze_roll["maze2"]);
}

//Function Number: 114
player_disconnect_during_maze(param_00)
{
	param_00 notify("end_disconnect_thread" + param_00.name);
	param_00 endon("end_disconnect_thread" + param_00.name);
	level endon("end_locking_threads_on_the_player_for_venomx_cursor");
	param_00 waittill("disconnect");
	level.test_model.newmodelsspawned = 1;
	level.test_model_2.newmodelsspawned = 1;
	level.maze_completed["maze1"] = 0;
	level.maze_completed["maze2"] = 0;
	level.failed_puzzle = 1;
	level.puzzles_solved = 0;
}

//Function Number: 115
control_puzzle_cursor(param_00)
{
	level thread player_disconnect_during_maze(self);
	if(param_00.mod_name == "maze2")
	{
		thread input_cursor_maze2(param_00,level.unsolved_crt_model_2);
		return;
	}

	thread input_cursor(param_00,level.unsolved_crt_model);
}

//Function Number: 116
get_chars_of_word_as_array(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01[var_02] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 117
solvecipher(param_00,param_01,param_02)
{
	level.ciphered_word = cipher(level.morse_phrase,param_00,1);
	level.decipheredword = cipher(level.ciphered_word,param_00,0);
	level.ciphered_word = changearraytoword(level.ciphered_word);
	level.decipheredword = changearraytoword(level.decipheredword);
	level convertwordintomorse(level.ciphered_word,0,level.morsecodecomponent);
	scripts\cp\_interaction::add_to_current_interaction_list(param_02);
}

//Function Number: 118
convertwordintomorse(param_00,param_01,param_02)
{
	if(param_01)
	{
		level.convertedword = "";
	}

	var_03 = get_chars_of_word_as_array(param_00);
	var_04 = undefined;
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		if(var_05 + 1 == var_03.size)
		{
			var_04 = getsubstr(param_00,var_05);
		}
		else
		{
			var_04 = getsubstr(param_00,var_05,var_05 + 1);
		}

		switch(var_04)
		{
			case "0":
				for(var_06 = 0;var_06 < 5;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "1":
				play_morse_dot(param_01,param_02);
				for(var_06 = 0;var_06 < 4;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "2":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "3":
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "4":
				for(var_06 = 0;var_06 < 4;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				play_morse_dash(param_01,param_02);
				break;

			case "5":
				for(var_06 = 0;var_06 < 5;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "6":
				play_morse_dash(param_01,param_02);
				for(var_06 = 0;var_06 < 4;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "7":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "8":
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "9":
				for(var_06 = 0;var_06 < 4;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				play_morse_dot(param_01,param_02);
				break;

			case "A":
			case "a":
				play_morse_dot(param_01,param_02);
				for(var_06 = 0;var_06 < 1;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "B":
			case "b":
				play_morse_dash(param_01,param_02);
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "C":
			case "c":
				play_morse_dash(param_01,param_02);
				for(var_06 = 0;var_06 < 1;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 1;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 1;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "D":
			case "d":
				play_morse_dash(param_01,param_02);
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "E":
			case "e":
				play_morse_dot(param_01,param_02);
				break;

			case "F":
			case "f":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				play_morse_dash(param_01,param_02);
				play_morse_dot(param_01,param_02);
				break;

			case "G":
			case "g":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				play_morse_dot(param_01,param_02);
				break;

			case "H":
			case "h":
				for(var_06 = 0;var_06 < 4;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "I":
			case "i":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "J":
			case "j":
				play_morse_dot(param_01,param_02);
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "K":
			case "k":
				play_morse_dash(param_01,param_02);
				play_morse_dot(param_01,param_02);
				play_morse_dash(param_01,param_02);
				break;

			case "L":
			case "l":
				play_morse_dot(param_01,param_02);
				play_morse_dash(param_01,param_02);
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "M":
			case "m":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "N":
			case "n":
				play_morse_dash(param_01,param_02);
				play_morse_dot(param_01,param_02);
				break;

			case "O":
			case "o":
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "P":
			case "p":
				play_morse_dot(param_01,param_02);
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				play_morse_dot(param_01,param_02);
				break;

			case "Q":
			case "q":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				play_morse_dot(param_01,param_02);
				play_morse_dash(param_01,param_02);
				break;

			case "R":
			case "r":
				play_morse_dot(param_01,param_02);
				play_morse_dash(param_01,param_02);
				play_morse_dot(param_01,param_02);
				break;

			case "S":
			case "s":
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case "T":
			case "t":
				play_morse_dash(param_01,param_02);
				break;

			case "U":
			case "u":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				play_morse_dash(param_01,param_02);
				break;

			case "V":
			case "v":
				for(var_06 = 0;var_06 < 3;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				play_morse_dash(param_01,param_02);
				break;

			case "W":
			case "w":
				play_morse_dot(param_01,param_02);
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "X":
			case "x":
				play_morse_dash(param_01,param_02);
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				play_morse_dash(param_01,param_02);
				break;

			case "Y":
			case "y":
				play_morse_dash(param_01,param_02);
				play_morse_dot(param_01,param_02);
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
				break;

			case "Z":
			case "z":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case ".":
				wait(1.5);
				break;

			case ",":
				wait(1);
				break;

			case "?":
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dash(param_01,param_02);
				}
	
				for(var_06 = 0;var_06 < 2;var_06++)
				{
					play_morse_dot(param_01,param_02);
				}
				break;

			case " ":
				wait(1);
				break;

			default:
				break;
		}
	}

	if(!param_01)
	{
		param_02 setscriptablepartstate("morse_code","off");
	}
}

//Function Number: 119
venomx_morse_code(param_00,param_01,param_02)
{
	param_00 = scripts\common\utility::array_randomize(param_00);
	level.morse_phrase = param_00[0];
	level thread solvecipher(param_01,self,param_02);
}

//Function Number: 120
turn_model_on_off(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01))
	{
		param_00 setscriptablepartstate("morse_code","off");
		wait(0.3);
		param_00 setscriptablepartstate("morse_code","off");
		return;
	}

	param_00 setscriptablepartstate("morse_code","off");
	wait(0.5);
	param_00 setscriptablepartstate("morse_code","off");
}

//Function Number: 121
play_morse_dot(param_00,param_01)
{
	if(!param_00)
	{
		level thread turn_model_on_off(param_01,1);
		scripts\cp\_utility::func_D52A("payphone_plr_morse_dot",param_01.origin);
		wait(0.3);
		param_01 setscriptablepartstate("morse_code","off");
		return;
	}

	level.convertedword = level.convertedword + ".";
}

//Function Number: 122
play_morse_dash(param_00,param_01)
{
	if(!param_00)
	{
		level thread turn_model_on_off(param_01,0);
		scripts\cp\_utility::func_D52A("payphone_plr_morse_dash",param_01.origin);
		wait(0.5);
		param_01 setscriptablepartstate("morse_code","off");
		return;
	}

	level.convertedword = level.convertedword + "-";
}

//Function Number: 123
unblock_venomx_door()
{
	var_00 = getent("venomx_door_blocker","script_noteworthy");
	var_00 notsolid();
	var_00 connectpaths();
}

//Function Number: 124
choose_number_of_goons()
{
	var_00 = 1;
	if(isdefined(level.players.size) && level.players.size > 0)
	{
		switch(level.players.size)
		{
			case 1:
				var_00 = 1;
				break;

			case 2:
				var_00 = 1;
				break;

			case 3:
				var_00 = 2;
				break;

			case 4:
				var_00 = 2;
				break;

			default:
				var_00 = 1;
				break;
		}

		return var_00;
	}
}

//Function Number: 125
start_fake_spawn_sequence(param_00,param_01)
{
	level endon("game_ended");
	var_02 = choose_number_of_goons();
	var_03 = var_02;
	level.goons_alive = var_03;
	var_04 = 0;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	param_00 thread watch_for_disconnected_player_during_spawn();
	var_09 = getrandomnavpoints(param_01,128,var_03);
	scripts\cp\zombies\zombies_spawning::func_93EB(var_03);
	wait(2);
	var_0A = skeleton_spawner(var_09,param_00);
	while(level.goons_alive > 0)
	{
		wait(0.1);
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(var_03);
	return 1;
}

//Function Number: 126
watch_for_disconnected_player_during_spawn()
{
	self waittill("disconnect");
	level.goons_alive = 0;
}

//Function Number: 127
get_rand_point(param_00,param_01)
{
	param_01 endon("disconnect");
	while(![[ level.var_164B ]](param_00))
	{
		param_00 = getrandomnavpoint(param_00,128);
		scripts\common\utility::func_136F7();
	}

	return param_00;
}

//Function Number: 128
skeleton_spawner(param_00,param_01)
{
	param_01 endon("disconnect");
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] = get_rand_point(param_00[var_03],param_01);
		var_04 = spawn_skeleton_solo(param_00[var_03],param_01);
		if(isdefined(var_04))
		{
			var_04 thread skeleton_death_watcher();
			var_02[var_02.size] = var_04;
			var_04 thread set_skeleton_attributes();
			wait(1);
			continue;
		}

		level.goons_alive--;
	}

	return var_02;
}

//Function Number: 129
skeleton_death_watcher()
{
	level endon("game_ended");
	self waittill("death");
	level.goons_alive--;
}

//Function Number: 130
spawn_skeleton_solo(param_00,param_01)
{
	param_01 endon("disconnect");
	param_00 = scripts\common\utility::func_5D14(param_00,30,-100);
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_02.var_EE79 = "ground_spawn_no_boards";
	var_02.var_ECF5 = "spawn_ground";
	var_03 = 4;
	var_04 = 2.7;
	for(var_05 = 0;var_05 < var_03;var_05++)
	{
		thread scripts\cp\_utility::func_D52A("zombie_spawn_lightning",param_00);
		var_06 = level._effect["goon_spawn_bolt"];
		playfx(var_06,param_00);
		playfx(level._effect["drone_ground_spawn"],param_00,(0,0,1));
		playrumbleonposition("grenade_rumble",param_00);
		earthquake(0.3,0.2,param_00,500);
		var_07 = var_02 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
		if(isdefined(var_07))
		{
			return var_07;
		}

		wait(var_04);
	}

	return undefined;
}

//Function Number: 131
set_skeleton_attributes()
{
	level endon("game_ended");
	self endon("death");
	self.dont_cleanup = 1;
	self.var_1F5 = "sprint";
	if(!scripts\common\utility::istrue(self.aj_goon))
	{
		self.aj_goon = 1;
	}

	self.health = scripts\cp\zombies\cp_final_spawning::func_3728("alien_phantom");
	self.maxhealth = scripts\cp\zombies\cp_final_spawning::func_3728("alien_phantom");
}

//Function Number: 132
init_fig1()
{
	level.special_mode_activation_funcs["fig_1"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["fig_1"] = ::showhiddenfigurestoplayer;
	var_00 = scripts\common\utility::getstructarray("fig_1","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"fig_1");
	}
}

//Function Number: 133
init_fig2()
{
	level.special_mode_activation_funcs["fig_2"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["fig_2"] = ::showhiddenfigurestoplayer;
	var_00 = scripts\common\utility::getstructarray("fig_2","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"fig_2");
	}
}

//Function Number: 134
init_fig3()
{
	level.special_mode_activation_funcs["fig_3"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["fig_3"] = ::showhiddenfigurestoplayer;
	var_00 = scripts\common\utility::getstructarray("fig_3","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"fig_3");
	}
}

//Function Number: 135
init_fig4()
{
	level.special_mode_activation_funcs["fig_4"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["fig_4"] = ::showhiddenfigurestoplayer;
	var_00 = scripts\common\utility::getstructarray("fig_4","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"fig_4");
	}
}

//Function Number: 136
fig_hint(param_00,param_01)
{
	return "";
}

//Function Number: 137
fig_func(param_00,param_01)
{
}

//Function Number: 138
activatefiguredamage(param_00,param_01,param_02)
{
	level notify(param_00.script_noteworthy + "_" + param_01.name);
	level endon(param_00.script_noteworthy + "_" + param_01.name);
	level endon("game_ended");
	param_01 endon("disconnect");
	param_01 endon("last_stand");
	level endon("end_hidden_figures_sequence_for_" + param_01.name);
	param_02 endon("p_ent_reset");
	if(!isdefined(param_02))
	{
		return;
	}

	param_02.health = 99999999;
	param_02.maxhealth = 99999999;
	param_02 setcandamage(1);
	param_02 endon("end_thread_for_" + param_02.model);
	for(;;)
	{
		param_02 waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
		if(!isplayer(var_04))
		{
			continue;
		}

		if(var_04 != param_01)
		{
			continue;
		}

		if(!var_04 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(param_02.got_hit_by_player))
		{
			param_02 setscriptablepartstate("figure_effect","death");
			var_04 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_04);
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!function_010F(var_04.origin,level.hidden_figures_volume))
		{
			var_04 playlocalsound("perk_machine_deny");
			continue;
		}

		param_02 setscriptablepartstate("figure_effect","death");
		param_02.health = 9999999;
		param_02.maxhealth = 9999999;
		playsoundatpos(param_02.origin,"town_kill_black_ghost_success");
		param_02.got_hit_by_player = 1;
		if(isdefined(var_04.hidden_figures_hit))
		{
			var_04.hidden_figures_hit++;
			if(var_04.hidden_figures_hit >= 4)
			{
				var_04 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_04);
			}
		}

		if(isdefined(level.hidden_figures_killed))
		{
			if(level.hidden_figures_killed >= level.chosen_number_for_morse_code_pap2)
			{
				level.hidden_figures_killed = level.chosen_number_for_morse_code_pap2;
			}
			else
			{
				level thread scripts\cp\_utility::add_to_notify_queue("venomx_pap1_kill",param_02,param_02.origin,var_0C);
				level.hidden_figures_killed++;
			}
		}

		param_02 notify("end_thread_for_" + param_02.model);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 139
showhiddenfigurestoplayer(param_00,param_01,param_02,param_03)
{
	param_03 notify("one_instance_of_" + param_01.script_noteworthy + "_for_" + param_03.name);
	param_03 endon("one_instance_of_" + param_01.script_noteworthy + "_for_" + param_03.name);
	param_03 endon("death");
	param_03 endon("disconnect");
	level endon("game_ended");
	level endon("end_hidden_figures_sequence_for_" + param_03.name);
	if(!isdefined(param_03.var_134FD))
	{
		return;
	}

	if(!isdefined(param_01.script_noteworthy))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_03.triggeredtimequest))
	{
		return;
	}

	var_04 = 2;
	var_05 = 100000;
	var_06 = [];
	var_07 = gettime();
	param_00.got_hit_by_player = 0;
	if(!isdefined(param_03.hidden_figures_hit))
	{
		param_03.hidden_figures_hit = 0;
	}

	if(!isdefined(level.hidden_figures_killed))
	{
		level.hidden_figures_killed = 0;
	}

	thread activatefiguredamage(param_01,param_03,param_00);
	param_00 showtoplayer(param_03);
	for(;;)
	{
		if(!scripts\common\utility::istrue(param_03.triggeredtimequest))
		{
			break;
		}

		var_08 = randomintrange(-200,200);
		var_09 = randomintrange(-200,200);
		var_0A = randomintrange(90,200);
		param_03.figure_one_offset = (var_08,var_09,var_0A);
		var_0B = randomintrange(-200,200);
		var_0C = randomintrange(-200,200);
		var_0D = randomintrange(90,200);
		param_03.figure_two_offset = (var_0B,var_0C,var_0D);
		var_0E = randomintrange(-200,200);
		var_0F = randomintrange(-200,200);
		var_10 = randomintrange(90,200);
		param_03.figure_three_offset = (var_0E,var_0F,var_10);
		var_11 = randomintrange(-200,200);
		var_12 = randomintrange(-200,200);
		var_13 = randomintrange(90,200);
		param_03.figure_four_offset = (var_11,var_12,var_13);
		switch(param_01.script_noteworthy)
		{
			case "fig_1":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_one_offset;
				param_00 setmodel("tag_origin_hidden_figure_final");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_one_offset;
				break;
	
			case "fig_2":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_two_offset;
				param_00 setmodel("tag_origin_hidden_figure_final");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_two_offset;
				break;
	
			case "fig_3":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_three_offset;
				param_00 setmodel("tag_origin_hidden_figure_final");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_three_offset;
				break;
	
			case "fig_4":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_four_offset;
				param_00 setmodel("tag_origin_hidden_figure_final");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_four_offset;
				break;
		}

		if(int(distance(param_00.origin,param_03.origin)) <= 120)
		{
			if(param_03 method_843B())
			{
				if(randomint(100) > 50)
				{
					param_03 dodamage(int(param_03.health / 4),param_03.origin);
				}
			}
			else
			{
				param_03 dodamage(int(param_03.health / 4),param_03.origin);
			}
		}

		param_00.angles = vectortoangles(param_03.origin - param_00.origin);
		param_01.model = param_00;
		wait(var_04);
	}

	param_00 setscriptablepartstate("figure_effect","neutral");
	scripts\common\utility::func_136F7();
	param_00 setscriptablepartstate("figure_effect","death");
	level notify("end_hidden_figures_sequence_for_" + param_03.name);
}

//Function Number: 140
setup_hidden_figure_models(param_00,param_01)
{
	scripts\cp\maps\cp_final\cp_final::addtopersonalinteractionlist(param_00);
	switch(param_01)
	{
		case "fig_4":
		case "fig_3":
		case "fig_2":
		case "fig_1":
			break;
	}
}

//Function Number: 141
modfunc(param_00,param_01)
{
	return param_00 % param_01 + param_01 % param_01;
}

//Function Number: 142
isalphabet(param_00)
{
	foreach(var_03, var_02 in level.alphabets)
	{
		if(param_00 == var_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 143
cipher(param_00,param_01,param_02)
{
	var_03 = param_01.size;
	var_04 = param_00.size;
	var_05 = 0;
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		if(isalphabet(param_00[var_07]))
		{
			var_08 = var_07 - var_05 % var_03;
			var_09 = param_01[var_08];
			if(!param_02)
			{
				var_09 = -1 * derivenumberfromletter(var_09);
			}
			else
			{
				var_09 = derivenumberfromletter(var_09);
			}

			var_0A = modfunc(derivenumberfromletter(param_00[var_07]) + var_09,26);
			var_06[var_07] = deriveletterfromnumber(var_0A);
			continue;
		}

		var_06[var_07] = param_00[var_07];
		var_05++;
	}

	return var_06;
}

//Function Number: 144
derivenumberfromletter(param_00)
{
	foreach(var_03, var_02 in level.alphabets)
	{
		if(param_00 == var_03)
		{
			return var_02;
		}
	}

	foreach(var_06, var_05 in level.alphabets_capped)
	{
		if(param_00 == var_06)
		{
			return var_05;
		}
	}
}

//Function Number: 145
deriveletterfromnumber(param_00)
{
	foreach(var_03, var_02 in level.alphabets)
	{
		if(var_02 == param_00)
		{
			return var_03;
		}
	}

	foreach(var_06, var_05 in level.alphabets_capped)
	{
		if(var_05 == param_00)
		{
			return var_06;
		}
	}
}

//Function Number: 146
changearraytoword(param_00)
{
	var_01 = "";
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02]))
		{
			continue;
		}

		var_01 = var_01 + param_00[var_02];
	}

	return var_01;
}