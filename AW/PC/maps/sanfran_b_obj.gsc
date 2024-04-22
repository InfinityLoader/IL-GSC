/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_obj.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 121 ms
 * Timestamp: 4/22/2024 2:35:32 AM
*******************************************************************/

//Function Number: 1
obj_secure_deck()
{
	level waittill("player_control_enabled");
	objective_add(maps\_utility::obj("obj_plant_jammers"),"current",&"SANFRAN_B_OBJ_PLANT_JAMMERS");
	objective_onentity(maps\_utility::obj("obj_plant_jammers"),level.cormack);
	common_scripts\utility::flag_wait("obj_track_jammers");
	var_00 = getent("jammer_1","targetname");
	var_01 = getent("jammer_2","targetname");
	var_02 = (0,0,16);
	objective_position(maps\_utility::obj("obj_plant_jammers"),var_00.origin + var_02);
	objective_setpointertextoverride(maps\_utility::obj("obj_plant_jammers"),&"SANFRAN_B_OBJ_JAMMER");
	common_scripts\utility::flag_wait("planting_jammer_1");
	objective_position(maps\_utility::obj("obj_plant_jammers"),(0,0,0));
	common_scripts\utility::flag_wait("jammer_1_deactivated");
	objective_position(maps\_utility::obj("obj_plant_jammers"),var_01.origin + var_02);
	objective_setpointertextoverride(maps\_utility::obj("obj_plant_jammers"),&"SANFRAN_B_OBJ_JAMMER");
	common_scripts\utility::flag_wait("planting_jammer_2");
	objective_position(maps\_utility::obj("obj_plant_jammers"),(0,0,0));
	common_scripts\utility::flag_wait("jammer_2_deactivated");
	maps\_utility::objective_complete(maps\_utility::obj("obj_plant_jammers"));
	common_scripts\utility::flag_set("obj_bridge_start");
}

//Function Number: 2
track_reinforcement_location(param_00,param_01,param_02)
{
	level endon(param_01);
	common_scripts\utility::flag_clear("obj_track_enemies");
	var_03 = 0;
	var_04 = spawn("script_model",(0,0,0));
	var_04 thread clean_up_target_pos_ent(param_00,param_01);
	objective_onentity(param_00,var_04);
	for(;;)
	{
		if(isdefined(param_02) && param_02.size > 0)
		{
			var_05 = (0,0,0);
			var_06 = 0;
			foreach(var_08 in param_02)
			{
				if(isdefined(var_08) && isalive(var_08))
				{
					var_05 = var_05 + var_08.origin;
					var_06++;
				}
			}

			if(var_06 > 0)
			{
				var_05 = var_05 / var_06;
				if(var_03)
				{
					var_04 moveto(var_05,0.2);
				}
				else
				{
					var_03 = 1;
					var_04.origin = var_05;
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 3
clean_up_target_pos_ent(param_00,param_01)
{
	level waittill(param_01);
	objective_position(param_00,(0,0,0));
	self delete();
}

//Function Number: 4
obj_bridge_start()
{
	common_scripts\utility::flag_wait("obj_bridge_start");
	objective_add(maps\_utility::obj("obj_bridge"),"current",&"SANFRAN_B_OBJ_BRIDGE");
	objective_onentity(maps\_utility::obj("obj_bridge"),level.cormack);
	objective_setpointertextoverride(maps\_utility::obj("obj_bridge"),"");
	common_scripts\utility::flag_set("all_jammers_deactivated");
	common_scripts\utility::flag_wait("show_enter_ship_obj_marker");
	var_00 = getent("org_enter_ship","targetname");
	wait(0.5);
	objective_position(maps\_utility::obj("obj_bridge"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("obj_bridge"),"");
	common_scripts\utility::flag_wait("flag_player_entered_interior");
	common_scripts\utility::flag_set("obj_secure_deck_complete");
	common_scripts\utility::flag_set("obj_bridge");
}

//Function Number: 5
obj_bridge()
{
	common_scripts\utility::flag_wait("obj_bridge");
	objective_onentity(maps\_utility::obj("obj_bridge"),level.cormack);
	common_scripts\utility::flag_wait("flag_obj_leave_cafeteria");
	var_00 = common_scripts\utility::getstruct("obj_marker_exit_cafeteria","targetname");
	objective_position(maps\_utility::obj("obj_bridge"),var_00.origin);
	common_scripts\utility::flag_wait("obj_marker_follow_cormack_to_hanger");
	objective_onentity(maps\_utility::obj("obj_bridge"),level.cormack);
	common_scripts\utility::flag_wait("flag_obj_enter_hanger");
	objective_position(maps\_utility::obj("obj_bridge"),(0,0,0));
	common_scripts\utility::flag_wait("flag_obj_leave_hanger");
	objective_onentity(maps\_utility::obj("obj_bridge"),level.cormack);
	common_scripts\utility::flag_wait("cormack_on_console");
	maps\_utility::objective_complete(maps\_utility::obj("obj_bridge"));
	wait(0.5);
	common_scripts\utility::flag_set("obj_console");
}

//Function Number: 6
obj_console()
{
	common_scripts\utility::flag_wait("obj_console");
	var_00 = common_scripts\utility::getstruct("org_obj_console","targetname");
	objective_add(maps\_utility::obj("obj_laser"),"current",&"SANFRAN_B_OBJ_CONSOLE");
	objective_position(maps\_utility::obj("obj_laser"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("obj_laser"),&"SANFRAN_B_OBJ_USE");
	var_01 = getent("trig_use_console","targetname");
	var_01 common_scripts\utility::trigger_on();
	var_01 sethintstring(&"SANFRAN_B_CONSOLE_HINT");
	var_01 waittill("trigger");
	common_scripts\utility::flag_set("obj_laser");
}

//Function Number: 7
obj_laser()
{
	common_scripts\utility::flag_wait("obj_laser");
	var_00 = getent("cargo_ship","targetname");
	var_01 = getent("cargo_ship_2","targetname");
	objective_string_nomessage(maps\_utility::obj("obj_laser"),&"SANFRAN_B_OBJ_LASER");
	objective_position(maps\_utility::obj("obj_laser"),(0,0,0));
	common_scripts\utility::flag_wait("second_cargo_ship_destroyed");
	maps\_utility::objective_complete(maps\_utility::obj("obj_laser"));
}

//Function Number: 8
enable_cormack_follow()
{
	common_scripts\utility::flag_wait("CormackSafe");
	objective_position(maps\_utility::obj("obj_bridge"),(0,0,0));
	common_scripts\utility::flag_wait_either("information_center_cleared","information_center_enemies_killed");
	objective_onentity(maps\_utility::obj("obj_bridge"),level.cormack);
}