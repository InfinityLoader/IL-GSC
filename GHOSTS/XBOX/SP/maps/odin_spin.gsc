/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_spin.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 35
 * Decompile Time: 524 ms
 * Timestamp: 10/27/2023 1:36:57 AM
*******************************************************************/

//Function Number: 1
func_791F()
{
	maps/odin_util::move_player_to_start_point("start_odin_spin");
	level.player thread maps/odin::func_3CD8();
	thread maps/odin_util::create_sliding_space_door("spin_door_blocker",0.75,0,0,0,"lock_spin_door_blocker","unlock_spin_door_blocker");
	common_scripts\utility::flag_set("unlock_spin_door_blocker");
	thread func_6146();
	wait(0.1);
	maps/odin_util::actor_teleport(level.ally,"odin_spin_ally_tp");
	thread maps/odin_intro::func_8546();
	thread maps/odin_escape::func_5069("delete");
	thread maps\odin_fx::func_6A5C();
	level.var_245C = thread maps/odin_util::create_sliding_space_door("spin_decomp_door",0.3,0.1,0,0,"lock_decomp_room","open_decomp_room_door");
}

//Function Number: 2
func_6D5B()
{
	precacherumble("heavy_3s");
}

//Function Number: 3
func_6D56()
{
	common_scripts\utility::func_3385("EarthSetupComplete");
	common_scripts\utility::func_3385("odin_start_spin_decomp_real");
	common_scripts\utility::func_3385("start_near_explosion_sequence");
	common_scripts\utility::func_3385("spin_start_exterior_dialogue");
	common_scripts\utility::func_3385("player_in_outside_spin");
	common_scripts\utility::func_3385("spin_approaching_enemies");
	common_scripts\utility::func_3385("spin_clear");
	common_scripts\utility::func_3385("stop_spinning_room");
	common_scripts\utility::func_3385("delete_spinning_room");
	common_scripts\utility::func_3385("open_decomp_room_door");
	common_scripts\utility::func_3385("lgt_flag_spin_over");
	common_scripts\utility::func_3385("player_is_decompressing");
	common_scripts\utility::func_3385("decomp_done");
	common_scripts\utility::func_3385("trigger_spacejump");
	common_scripts\utility::func_3385("stop_moving_sun");
	common_scripts\utility::func_3385("landed_on_satellite");
	common_scripts\utility::func_3385("spacejump_clear");
	common_scripts\utility::func_3385("player_linked_with_legs");
	common_scripts\utility::func_3385("spin_room_start_corpses");
	common_scripts\utility::func_3385("decomp_anim_VO_complete");
	common_scripts\utility::func_3385("hold_satellite_back_thrusters");
	common_scripts\utility::func_3385("cue_crates_decomp");
	common_scripts\utility::func_3385("playsound");
	common_scripts\utility::func_3385("lgt_spin_setup");
	common_scripts\utility::func_3385("player_spin_decomp_anim_done");
}

//Function Number: 4
func_6D58()
{
}

//Function Number: 5
func_7918()
{
	func_791E();
	thread spin_ally_logic();
	func_69D6(1);
	thread func_7923("stunnel_grp03_big_int_01","simple_spin_aligned_rotator_org_1",-60,18,(0,0,50));
	thread func_7923("stunnel_grp04_big_int_01","simple_spin_aligned_rotator_org_2",-40,25,(0,0,50));
	thread spin_dialogue();
	func_5837();
	maps\_utility::func_252F(10,::maps\odin_fx::func_3681);
	thread func_791C();
	common_scripts\utility::flag_wait("spin_clear");
	common_scripts\utility::flag_set("hold_satellite_back_thrusters");
	maps\_utility::func_7C22("post_decomp_01");
	thread func_790F();
	thread maps\_utility::autosave_by_name("spacejump_begin");
	common_scripts\utility::flag_wait("player_in_smash_range");
	common_scripts\utility::flag_set("spacejump_clear");
	common_scripts\utility::flag_set("objective_destroy_sat");
}

//Function Number: 6
func_791E()
{
	common_scripts\utility::flag_set("lgt_spin_setup");
	thread func_791D();
	thread func_790E();
	thread spin_do_moving_debris("decomp_moving_debris","odin_start_spin_decomp_real",15);
	thread spin_do_moving_debris("spin_moving_debris","odin_start_spin_decomp_real",25,14);
	thread func_7916("spin_moving_debris","odin_start_spin_decomp_real",25,14);
	thread do_spacejump_debris("spacejump_debris_small");
	thread do_spacejump_debris("spacejump_debris_large");
	thread do_unique_debris();
	function_0168("ragdoll_max_life",90000);
}

//Function Number: 7
spin_dialogue()
{
	common_scripts\utility::flag_wait("odin_pre_decomp_dialog");
	maps\_utility::func_62C7();
	common_scripts\utility::flag_wait("odin_start_spin_decomp");
	common_scripts\utility::flag_set("lock_spin_door_blocker");
	common_scripts\utility::flag_set("odin_start_spin_decomp_real");
	wait(0.5);
	maps\_utility::smart_radio_dialogue("odin_kyr_argh_2");
	maps\_utility::smart_radio_dialogue("odin_kyr_lookout");
	wait(7.2);
	maps\_utility::smart_radio_dialogue("odin_shq_odincontrol");
	wait(0.5);
	maps\_utility::smart_radio_dialogue("odin_kyr_ugh");
	maps\_utility::smart_radio_dialogue("odin_shq_odincontrolareyou");
	common_scripts\utility::flag_wait("decomp_anim_VO_complete");
	maps\_utility::smart_radio_dialogue("odin_kyr_mygod");
	maps\_utility::smart_radio_dialogue("odin_shq_targetingonpayloads3");
	common_scripts\utility::flag_wait("spin_start_exterior_dialogue");
	common_scripts\utility::flag_set("mus_odin_end");
	maps\_utility::smart_radio_dialogue("odin_shq_butpayload2is");
	maps\_utility::smart_radio_dialogue("odin_shq_odinpayload2targeting");
	maps\_utility::smart_radio_dialogue("odin_kyr_werenotdonebud");
	maps\_utility::smart_radio_dialogue("odin_kyr_letsmovetoodin");
	common_scripts\utility::flag_set("objective_destroy_sat");
	wait(0.7);
	maps\_utility::smart_radio_dialogue("odin_ast1_idontthinkwere");
}

//Function Number: 8
func_5837()
{
	common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
	if(maps\_utility::func_47F6())
	{
		function_0168("r_mbFastEnable",1);
		function_0168("r_mbFastPreset",0);
		function_0168("r_mbCameraRotationInfluence",0.6);
		function_0168("r_mbCameraTranslationInfluence",2);
		function_0168("r_mbViewmodelVelocityScalar",0.04);
		function_0168("r_mbStaticVelocityScalar",0.56);
		function_0168("r_mbViewmodelEnable",1);
	}

	thread func_41F7();
	if(isdefined(level.var_245C))
	{
		common_scripts\utility::flag_set("open_decomp_room_door");
	}

	var_00 = [];
	var_01 = [];
	var_00 = prespawn_decomp_enemies();
	var_02 = func_6148();
	var_03 = [];
	wait(0.1);
	thread maps/odin_anim::func_7911();
	common_scripts\utility::flag_set("start_near_explosion_sequence");
	var_04 = common_scripts\utility::func_3C18("kyra_move_node02","targetname");
	var_04 notify("stop_loop");
	maps\_utility::func_252F(1,::maps/odin_escape::func_5069,"hide");
	function_0168("player_swimWaterCurrent",(0,0,0));
	level notify("player_exited_escape_hallway");
	thread spin_colliders_go();
	common_scripts\utility::flag_set("cue_crates_decomp");
	thread maps/odin_anim::decomp_explosion_anim_ally();
	thread maps/odin_anim::decomp_explosion_anim_enemies(var_00);
	thread maps/odin_anim::decomp_explosion_anim_player_legs(var_02);
	thread maps\odin_fx::fx_spin_create_rog_plumes();
	wait(1.8);
	earthquake(0.3,3,level.player.origin,500);
	level.player playrumbleonentity("heavy_3s");
	maps\_utility::func_7C22("escape_destruction");
	maps\_utility::func_7C22("escape_destruction_ng");
	common_scripts\utility::exploder("spin_implosion");
	thread maps/odin_audio::sfx_odin_decompress_explode();
	if(isdefined(level.var_245C))
	{
		thread maps/odin_util::func_69CE(level.var_245C.parts);
	}

	maps\_utility::func_8A02("odin_implosion",0.5);
	level thread maps\odin_fx::fx_spin_player_debris();
	wait(2);
	common_scripts\utility::exploder("spin_decompression");
	maps\_utility::func_8A02("",0.5);
	wait(4.4);
	maps\_utility::func_7C22("spin_implosion");
	common_scripts\utility::flag_set("spin_room_start_corpses");
	wait(5.5);
	thread maps/odin_audio::func_737A();
	wait(0.5);
	thread maps/odin_audio::sfx_spin_emt();
	level waittill("decomp_player_anim_done");
	common_scripts\utility::flag_set("decomp_done");
	wait(0.1);
	level.var_5D19 = 3;
	thread maps/odin_audio::func_7332();
	thread maps\_utility::autosave_by_name("spin_outside");
	common_scripts\utility::flag_set("player_in_outside_spin");
	function_0168("player_swimFriction",1);
	function_0168("player_swimWaterCurrent",(-500,0,0));
	thread maps\_utility::autosave_by_name("spin_begin");
	wait(2.4);
	common_scripts\utility::flag_set("spin_start_exterior_dialogue");
}

//Function Number: 9
spin_colliders_go()
{
	var_00 = getent("colliding_debris_node","targetname");
	var_01 = [];
	var_01["space_crate_01_burned"] = maps\_utility::func_777F("space_crate_01_burned");
	var_01["space_debris_01"] = maps\_utility::func_777F("space_debris_01");
	var_01["space_debris_02"] = maps\_utility::func_777F("space_debris_02");
	var_01["airplane_debris_destroyed_03_iw6a"] = maps\_utility::func_777F("airplane_debris_destroyed_03_iw6a");
	var_01["airplane_debris_destroyed_03_iw6b"] = maps\_utility::func_777F("airplane_debris_destroyed_03_iw6b");
	var_00 maps\_anim::anim_first_frame(var_01,"sat_colliders_go");
	common_scripts\utility::flag_wait("player_spin_decomp_anim_done");
	var_00 maps\_anim::anim_single(var_01,"sat_colliders_go");
	foreach(var_03 in var_01)
	{
		var_04 = randomfloatrange(300,800);
		var_05 = randomfloatrange(100,300);
		var_06 = randomfloatrange(-360,360);
		var_07 = common_scripts\utility::func_7836();
		var_07.origin = var_03.origin;
		var_03 linkto(var_07);
		var_07 moveto((var_07.origin[0] + 0,var_07.origin[1] + var_04,var_07.origin[2] + var_05),10,0,10);
		var_07 rotateby((var_06,var_06,var_06),10,0,10);
		level.var_6A3F[level.var_6A3F.size] = var_07;
		level.var_6A3F[level.var_6A3F.size] = var_03;
	}

	var_00 delete();
}

//Function Number: 10
func_41F7()
{
	var_00 = getentarray("sat_ROGS","script_noteworthy");
	var_00[1] hide();
}

//Function Number: 11
spin_ally_logic()
{
	level.ally.var_6B1C = 0.001;
	level.ally.ignoreme = 1;
	level.ally.ignoreall = 1;
	common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
	maps/odin_util::func_69DE("start_ally_spin_pathing");
	level.ally maps\_utility::func_2C96();
	common_scripts\utility::flag_wait("disable_kyra_leader");
	level.ally maps\_utility::func_2743();
	var_00 = getnode("spacejump_final_goal","targetname");
	level.ally method_8224(var_00);
}

//Function Number: 12
prespawn_decomp_enemies()
{
	var_00 = maps/odin_util::func_7805("decomp_enemy",1);
	foreach(var_02 in var_00)
	{
		var_02.animname = "generic";
		var_02.goalradius = 0;
		var_02.allowdeath = 1;
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
		var_02.var_29AA = 1;
		var_02.diequietly = 1;
		var_02.health = 1000;
	}

	return var_00;
}

//Function Number: 13
func_6148()
{
	var_00 = maps\_utility::func_777F("decomp_legs");
	var_00 hide();
	var_00.animname = "decomp_legs";
	var_00 maps\_utility::assign_animtree("decomp_legs");
	return var_00;
}

//Function Number: 14
func_6146()
{
	var_00 = getent("odin_decomp_anim","targetname");
	var_01 = getent("spin_decomp_container_01","targetname");
	prepare_crates_for_anim(var_01,"decomp_crate_01");
	var_02 = getent("spin_decomp_container_02","targetname");
	prepare_crates_for_anim(var_02,"decomp_crate_02");
	var_03 = getent("spin_decomp_container_03","targetname");
	prepare_crates_for_anim(var_03,"decomp_crate_03");
	var_04 = [];
	var_04["space_storage_container_01"] = maps\_utility::func_777F("space_storage_container_01");
	var_04["space_ata_box"] = maps\_utility::func_777F("space_ata_box");
	var_04["decomp_crate_01"] = var_01;
	var_04["decomp_crate_02"] = var_02;
	var_04["decomp_crate_03"] = var_03;
	link_bags_to_spin_crates("spin_decomp_bags_1",var_04["decomp_crate_01"]);
	link_bags_to_spin_crates("spin_decomp_bags_2",var_04["decomp_crate_02"]);
	link_bags_to_spin_crates("spin_decomp_bags_3",var_04["decomp_crate_03"]);
	foreach(var_06 in var_04)
	{
		level.var_6A3F[level.var_6A3F.size] = var_06;
	}

	var_00 maps\_anim::anim_first_frame(var_04,"decompression_props");
	common_scripts\utility::flag_wait("cue_crates_decomp");
	thread maps/odin_anim::func_2461(var_04);
}

//Function Number: 15
prepare_crates_for_anim(param_00,param_01)
{
	param_00 maps\_utility::assign_animtree(param_01);
	param_00.animname = param_01;
}

//Function Number: 16
link_bags_to_spin_crates(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	foreach(var_04 in var_02)
	{
		level.var_6A3F[level.var_6A3F.size] = var_04;
		var_04 linkto(param_01);
	}
}

//Function Number: 17
func_6149()
{
	var_00 = [];
	var_00[0] = getent("decomp_anim_panel_01","targetname");
	var_00[1] = getent("decomp_anim_panel_02","targetname");
	var_00[2] = getent("decomp_anim_panel_03","targetname");
	var_00[3] = getent("decomp_anim_panel_04","targetname");
	var_00[4] = getent("decomp_anim_panel_05","targetname");
	var_00[5] = getent("decomp_anim_panel_06","targetname");
	var_01 = [];
	var_01[0] = maps\_utility::func_777F("decomp_pannel_01",var_00[0].origin);
	var_01[1] = maps\_utility::func_777F("decomp_pannel_02",var_00[1].origin);
	var_01[2] = maps\_utility::func_777F("decomp_pannel_03",var_00[2].origin);
	var_01[3] = maps\_utility::func_777F("decomp_pannel_04",var_00[3].origin);
	var_01[4] = maps\_utility::func_777F("decomp_pannel_05",var_00[4].origin);
	var_01[5] = maps\_utility::func_777F("decomp_pannel_06",var_00[5].origin);
	var_01[0].angles = var_00[0].angles;
	var_01[1].angles = var_00[1].angles;
	var_01[2].angles = var_00[2].angles;
	var_01[3].angles = var_00[3].angles;
	var_01[4].angles = var_00[4].angles;
	var_01[5].angles = var_00[5].angles;
	foreach(var_08, var_03 in var_00)
	{
		var_04 = getentarray(var_03.target,"targetname");
		foreach(var_06 in var_04)
		{
			var_06 linkto(var_01[var_08]);
		}

		var_03 linkto(var_01[var_08]);
	}

	return var_01;
}

//Function Number: 18
func_790F(param_00)
{
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_wait("kickoff_player_finale");
		wait(3);
	}

	wait(0.2);
	common_scripts\utility::flag_set("stop_spinning_room");
	level notify("stop_weapon_drop_scripts");
	level notify("stop_spinning_debris");
	maps/odin_util::func_69D0("spin_trigger");
	maps/odin_util::func_69D0("spin_spawner");
	maps/odin_util::func_69D0("spin_ents");
	maps/odin_util::func_69D0("spin_parts");
	maps/odin_util::func_69D0("flying_debris_sparks");
	maps/odin_util::func_69D0("flying_debris_fire");
	maps/odin_util::func_69D0("flying_debris_sparks_metal");
	maps/odin_util::func_69D0("flying_debris_sparks_fire_metal");
	maps/odin_util::func_69D0("spacejump_ent");
	maps/odin_util::func_69D1("spacejump_debris_small");
	maps/odin_util::func_69D1("spacejump_debris_large");
}

//Function Number: 19
func_7923(param_00,param_01,param_02,param_03,param_04)
{
	level.var_7924 = [];
	var_05 = getent(param_01,"targetname");
	var_06 = getentarray(param_00,"targetname");
	foreach(var_08 in var_06)
	{
		var_08 linkto(var_05);
	}

	var_0A = getent("spin_geo_final_pos","targetname");
	var_05 moveto(var_0A.origin,0.1);
	var_05 waittill("movedone");
	common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
	common_scripts\utility::exploder("spin02_airlock_breach_steam01");
	level endon("stop_spinning_room");
	var_05.angles = var_05.angles + param_04;
	for(;;)
	{
		var_05 rotateroll(param_02 * 6,param_03 * 6);
		var_05 waittill("rotatedone");
	}
}

//Function Number: 20
func_790E()
{
	level endon("spin_clear");
	var_00 = getentarray("spin_busted_module","targetname");
	var_01 = getent("busted_module_path1","targetname");
	var_02 = getent("busted_module_path2","targetname");
	foreach(var_04 in var_00)
	{
		var_04 linkto(var_01);
	}

	common_scripts\utility::flag_wait("playsound");
	common_scripts\utility::flag_wait("spin_approaching_enemies");
	var_01 moveto(var_02.origin,95,3,0.1);
	var_01 rotatevelocity((1.75,0,0.8),90,0.1,0.1);
	while(!common_scripts\utility::flag("spin_clear"))
	{
		thread maps/odin_audio::func_7281(level.player);
		playfx(level._effect["spc_explosion_240"],var_01.origin);
		wait(randomfloatrange(2,8));
	}
}

//Function Number: 21
func_791C()
{
	level.forwardpush = -1600;
	thread adjust_forward_push();
	var_00 = 10;
	var_01 = getent("spin_push_desired_pos","targetname");
	var_02 = var_01.origin[1];
	var_03 = var_01.origin[2];
	level.spin_allowance_y = 40;
	level.var_790C = 40;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = 80;
	var_09 = level.ally.moveplaybackrate;
	level.ally.moveplaybackrate = 2;
	var_0A = getent("spin_skybox_rotator","targetname");
	var_0B = 5;
	var_0C = getent("box_animNode","script_noteworthy");
	var_0D = getent("spin_deadguy_static_node_05","targetname");
	for(;;)
	{
		if(level.player.origin[1] < var_02 - level.spin_allowance_y)
		{
			var_04 = 0 - level.player.origin[1] - var_02 + level.spin_allowance_y * var_00;
		}
		else if(level.player.origin[1] > var_02 + level.spin_allowance_y)
		{
			var_04 = 0 - level.player.origin[1] - var_02 - level.spin_allowance_y * var_00;
		}
		else
		{
			var_04 = 0;
		}

		if(level.player.origin[2] < var_03 - level.var_790C)
		{
			var_05 = 0 - level.player.origin[2] - var_03 + level.var_790C * var_00;
		}
		else if(level.player.origin[2] > var_03 + level.var_790C)
		{
			var_05 = 0 - level.player.origin[2] - var_03 - level.var_790C * var_00;
		}
		else
		{
			var_05 = 0;
		}

		if(var_04 > 20000)
		{
			var_04 = 20000;
		}

		if(var_04 < -20000)
		{
			var_04 = -20000;
		}

		if(var_05 > 20000)
		{
			var_05 = 20000;
		}

		if(var_05 < -20000)
		{
			var_05 = -20000;
		}

		if(var_04 == 0 && var_06 < 200 || var_06 > -200)
		{
			var_06 = 0;
		}
		else if(var_06 > var_04)
		{
			var_06 = var_06 - 100;
		}
		else
		{
			var_06 = var_06 + 100;
		}

		if(var_05 == 0 && var_07 < 200 || var_07 > -200)
		{
			var_07 = 0;
		}
		else if(var_07 > var_05)
		{
			var_07 = var_07 - 100;
		}
		else
		{
			var_07 = var_07 + 100;
		}

		function_0168("player_swimWaterCurrent",(level.forwardpush,var_06,var_07));
		if(common_scripts\utility::flag("spin_clear"))
		{
			var_02 = var_0C.origin[1];
			var_03 = var_0C.origin[2];
			if(level.player.origin[0] > var_0C.origin[0] + 1500)
			{
				if(var_0B < 10)
				{
					var_0B = var_0B + 0.03;
				}

				var_0A movex(var_0B,0.05,0,0);
			}
			else
			{
				common_scripts\utility::flag_set("spacejump_clear");
			}
		}

		if(common_scripts\utility::flag("landed_on_satellite") || common_scripts\utility::flag("disable_push_current"))
		{
			break;
		}

		var_0E = distance(var_0C.origin,level.player.origin);
		if(level.player.origin[0] <= var_0D.origin[0])
		{
			if(!common_scripts\utility::flag("disable_kyra_leader"))
			{
				level.ally.moveplaybackrate = 3;
			}
			else
			{
				level.ally.moveplaybackrate = 1;
			}

			if(var_0E >= 1000)
			{
				var_08 = 80;
				level.forwardpush = level.forwardpush - 300;
				if(level.forwardpush <= -9000)
				{
					level.forwardpush = -9000;
				}
			}

			if(var_0E >= 750 && var_0E < 1000)
			{
				var_08 = 75;
				level.forwardpush = level.forwardpush - 300;
				if(level.forwardpush <= -6500)
				{
					level.forwardpush = -6500;
				}
			}

			if(var_0E >= 500 && var_0E < 750)
			{
				level.forwardpush = level.forwardpush - 300;
				if(level.forwardpush <= -5000)
				{
					level.forwardpush = -5000;
				}
			}

			if(var_0E >= 250 && var_0E < 500)
			{
				var_08 = 70;
				level.forwardpush = level.forwardpush - 300;
				if(level.forwardpush <= -2800)
				{
					level.forwardpush = -2800;
				}
			}

			if(var_0E >= 0 && var_0E < 250)
			{
				level.forwardpush = level.forwardpush - 300;
				if(level.forwardpush <= -2000)
				{
					level.forwardpush = -2000;
				}
			}
		}

		function_0168("player_swimSpeed",var_08);
		if(var_0E <= 128 || level.player.origin[0] < -9850)
		{
			var_0F = 1;
		}

		wait(0.1);
	}

	common_scripts\utility::flag_set("landed_on_satellite");
	function_0168("player_swimWaterCurrent",(0,0,0));
}

//Function Number: 22
adjust_forward_push()
{
	var_00 = getent("ally_shooting_target","script_noteworthy");
	common_scripts\utility::flag_wait("spin_approaching_enemies");
	level.forwardpush = -1900;
	wait(2);
	level.forwardpush = -2200;
	common_scripts\utility::flag_wait("spin_clear");
	level.forwardpush = -4000;
	level.spin_allowance_y = 1820;
	level.var_790C = 1520;
	while(level.player.origin[0] > var_00.origin[0] + 5500)
	{
		wait(0.05);
	}

	level.spin_allowance_y = 1200;
	level.var_790C = 1000;
	while(level.player.origin[0] > var_00.origin[0] + 3000)
	{
		wait(0.05);
	}

	level.spin_allowance_y = 600;
	level.var_790C = 400;
	while(level.player.origin[0] > var_00.origin[0] + 2200)
	{
		wait(0.05);
	}

	level.spin_allowance_y = 155;
	level.var_790C = 100;
	while(level.player.origin[0] > var_00.origin[0] + 1500)
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("spacejump_clear");
	level.forwardpush = 0;
}

//Function Number: 23
func_791D(param_00)
{
	var_01 = maps/odin_util::func_6A53();
	var_01 unlink();
	var_02 = maps/odin_util::func_2BCF();
	var_03 = getent("spin_skybox_rotator","targetname");
	var_04 = getent("sunflare_origin","targetname");
	var_05 = getent("space_mover","targetname");
	var_06 = getent("initial_sat_orientation","targetname");
	var_07 = getent("spin_earth_front_pos","targetname");
	var_08 = 20;
	if(!isdefined(var_03) || !isdefined(var_05) || !isdefined(var_02))
	{
	}

	var_01 moveto(var_06.origin,0.1);
	var_01 rotateto(var_06.angles,0.1);
	wait(0.2);
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_wait("start_near_explosion_sequence");
	}

	var_01 unlink();
	wait(0.05);
	var_09 = getent("spin_aligned_rotator_org","targetname");
	var_05 linkto(var_09);
	var_01 linkto(var_09);
	var_02 linkto(var_09);
	var_0A = 400;
	var_09 rotateroll(var_0A * -1,0.1);
	var_09 waittill("rotatedone");
	var_0B = 25;
	if(isdefined(param_00))
	{
		var_0B = 1;
	}

	if(!isdefined(param_00))
	{
		wait(3.5);
	}

	var_09 rotateroll(var_0A,var_0B,0.1,var_0B * 0.8);
	var_09 waittill("rotatedone");
	var_09 unlink();
	var_09 delete();
	var_05 unlink();
	var_0B = 17;
	if(isdefined(param_00))
	{
		var_0B = 1;
	}

	var_0C = var_0B * 0.1;
	var_0D = var_0B * 0.5;
	var_05 linkto(var_02);
	var_02 moveto(var_07.origin,var_0B,var_0C,var_0D);
	var_02 rotateto(var_07.angles,var_0B,var_0C,var_0D);
	var_0E = getent("final_sat_orientation","targetname");
	var_01 moveto(var_0E.origin,var_0B,var_0C,var_0D);
	var_01 rotateto(var_0E.angles,var_0B,var_0C,var_0D);
	var_01 waittill("rotatedone");
	common_scripts\utility::flag_set("lgt_flag_spin_over");
}

//Function Number: 24
func_69D6(param_00)
{
	var_01 = [];
	var_02 = getentarray("spin_parts","script_noteworthy");
	var_03 = getentarray("flying_debris_sparks","script_noteworthy");
	var_04 = getentarray("flying_debris_sparks_metal","script_noteworthy");
	var_05 = getentarray("flying_debris_fire","script_noteworthy");
	var_06 = getentarray("flying_debris_sparks_fire_metal","script_noteworthy");
	var_07 = common_scripts\utility::array_combine(var_01,var_02);
	var_08 = common_scripts\utility::array_combine(var_03,var_04);
	var_09 = common_scripts\utility::array_combine(var_05,var_06);
	var_0A = common_scripts\utility::array_combine(var_07,var_08);
	var_0B = common_scripts\utility::array_combine(var_09,var_0A);
	var_0C = common_scripts\utility::array_combine(var_0A,var_0B);
	foreach(var_0E in var_0C)
	{
		if(isdefined(var_0E))
		{
			if(isdefined(param_00))
			{
				var_0E show();
				continue;
			}

			var_0E hide();
		}
	}
}

//Function Number: 25
spin_do_moving_debris(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_00,"targetname");
	var_05 = param_02;
	var_06 = 0;
	var_07 = 25;
	var_08 = 75;
	common_scripts\utility::flag_wait(param_01);
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	foreach(var_0A in var_04)
	{
		if(isdefined(var_0A.target))
		{
			var_0B = getent(var_0A.target,"targetname");
			if(isdefined(var_0B))
			{
				var_0C = var_05;
				var_0D = randomfloatrange(15,45);
				var_0E = randomfloatrange(6,18);
				var_0F = randomfloatrange(0.2,0.55);
				if(common_scripts\utility::func_1DE9())
				{
					var_0D = var_0D * -1;
				}

				if(common_scripts\utility::func_1DE9())
				{
					var_0E = var_0E * -1;
				}

				if(common_scripts\utility::func_1DE9())
				{
					var_0F = var_0F * -1;
				}

				var_0A thread spin_do_moving_debris_fx(var_0A.origin,var_0B.origin,var_0C);
				var_0A moveto(var_0B.origin,var_0C);
				var_10 = randomint(3);
				if(var_10 == 0)
				{
					var_0A thread func_7912(var_0D,var_0F,var_0E);
				}
				else if(var_10 == 1)
				{
					var_0A thread func_7912(var_0E,var_0D,var_0F);
				}
				else if(var_10 == 2)
				{
					var_0A thread func_7912(var_0F,var_0E,var_0D);
				}
			}
		}
	}
}

//Function Number: 26
func_7916(param_00,param_01,param_02,param_03)
{
	var_04 = 15;
	var_05 = param_02;
	var_06 = 0;
	var_07 = [];
	for(var_08 = 1;var_08 <= var_04;var_08++)
	{
		if(var_08 < 10)
		{
			var_09 = "0" + var_08;
		}
		else
		{
			var_09 = "" + var_08;
		}

		var_0A = param_00 + "_" + var_09;
		var_0B = getentarray(var_0A,"targetname");
		if(!isdefined(var_0B) || var_0B.size == 0)
		{
			continue;
		}

		var_0C = var_0B[0];
		var_0C.target = var_0A + "_node";
		foreach(var_0E in var_0B)
		{
			if(var_0E != var_0C)
			{
				var_0E linkto(var_0C);
			}
		}

		var_07[var_07.size] = var_0C;
		wait(0.1);
	}

	if(var_07.size == 0)
	{
	}

	common_scripts\utility::flag_wait(param_01);
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	foreach(var_11 in var_07)
	{
		if(isdefined(var_11.target))
		{
			var_12 = getent(var_11.target,"targetname");
			if(!isdefined(var_12))
			{
				continue;
			}

			var_13 = var_05;
			var_14 = randomfloatrange(15,45);
			var_15 = randomfloatrange(6,18);
			var_16 = randomfloatrange(0.2,0.55);
			if(common_scripts\utility::func_1DE9())
			{
				var_14 = var_14 * -1;
			}

			if(common_scripts\utility::func_1DE9())
			{
				var_15 = var_15 * -1;
			}

			if(common_scripts\utility::func_1DE9())
			{
				var_16 = var_16 * -1;
			}

			var_11 moveto(var_12.origin,var_13);
			var_17 = randomint(3);
			if(var_17 == 0)
			{
				var_11 thread func_7912(var_14,var_16,var_15);
			}
			else if(var_17 == 1)
			{
				var_11 thread func_7912(var_15,var_14,var_16);
			}
			else if(var_17 == 2)
			{
				var_11 thread func_7912(var_16,var_15,var_14);
			}
		}
	}
}

//Function Number: 27
spin_do_moving_debris_fx(param_00,param_01,param_02)
{
	wait(4);
	if(self.script_noteworthy != "spin_parts")
	{
		var_03 = common_scripts\utility::func_3AB9("spc_fire_puff_bigger_light");
		if(self.script_noteworthy == "flying_debris_sparks")
		{
			thread spin_piece_sparks();
		}

		if(self.script_noteworthy == "flying_debris_fire")
		{
			thread func_7919(param_00,param_01);
		}

		if(self.script_noteworthy == "flying_debris_sparks_metal")
		{
			thread func_791A();
			thread spin_piece_sparks();
		}

		if(self.script_noteworthy == "flying_debris_sparks_fire_metal")
		{
			thread spin_piece_sparks();
			thread func_7919(param_00,param_01);
			thread func_791A();
		}
	}

	wait(param_02 * randomfloatrange(0.2,0.5));
	var_04 = common_scripts\utility::func_7836();
	var_04.origin = self.origin;
	var_05 = param_00 - param_01;
	var_04.angles = vectortoangles(var_05);
	var_04 linkto(self);
	wait(param_02 * randomfloatrange(0.2,0.4));
	playfxontag(level._effect["odin_spin_piece_debris_runner"],var_04,"tag_origin");
	wait(3);
	stopfxontag(level._effect["odin_spin_piece_debris_runner"],var_04,"tag_origin");
	var_04 delete();
}

//Function Number: 28
func_7919(param_00,param_01)
{
	self endon("death");
	var_02 = common_scripts\utility::func_7836();
	var_02.origin = self.origin;
	var_03 = param_00 - param_01;
	var_02.angles = vectortoangles(var_03);
	playfxontag(common_scripts\utility::func_3AB9("spc_fire_big_light"),var_02,"tag_origin");
	for(var_04 = 0;var_04 < 300;var_04++)
	{
		var_02.origin = self.origin;
		common_scripts\utility::func_8AFE();
	}

	stopfxontag(common_scripts\utility::func_3AB9("spc_fire_big_light"),var_02,"tag_origin");
	var_02 delete();
}

//Function Number: 29
spin_piece_sparks()
{
	self endon("death");
	for(var_00 = 0;var_00 < 70;var_00++)
	{
		playfx(common_scripts\utility::func_3AB9("zg_electrical_sparks_big_single_runner"),self.origin + (randomfloatrange(-20,20),randomfloatrange(-20,20),randomfloatrange(-20,20)));
		wait(randomfloatrange(0.1,0.4));
	}
}

//Function Number: 30
func_791A()
{
	self endon("death");
	for(var_00 = 0;var_00 < 128;var_00++)
	{
		playfx(level._effect["odin_spin_piece_debris"],self.origin);
		wait(randomfloatrange(0.05,0.2));
	}
}

//Function Number: 31
do_unique_debris()
{
	var_00 = 400;
	var_01 = getent("spin_unique_debris_reaching_guy","targetname");
	var_02 = getentarray(var_01.target,"targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_01))
		{
			var_04 linkto(var_01);
			var_01 rotatevelocity((0,0,12),var_00);
		}
	}

	var_01 = getent("spin_unique_debris_rotating_01","targetname");
	if(isdefined(var_01))
	{
		var_01 rotatevelocity((10,0,0),var_00);
	}

	var_01 = getent("spin_unique_debris_rotating_02","targetname");
	if(isdefined(var_01))
	{
		var_01 rotatevelocity((0,24,0),var_00);
	}

	var_01 = getent("spin_unique_debris_rotating_03","targetname");
	if(isdefined(var_01))
	{
		var_01 rotatevelocity((0,0,14),var_00);
	}

	var_01 = getent("spin_unique_debris_rotating_05","targetname");
	if(isdefined(var_01))
	{
		var_01 rotatevelocity((6,0,0),var_00);
	}
}

//Function Number: 32
do_spacejump_debris(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_origin")
		{
			var_04 = getentarray(var_03.script_linkto,"script_linkname");
			foreach(var_06 in var_04)
			{
				var_06 linkto(var_03);
			}

			var_08 = randomfloatrange(15,45);
			var_09 = randomfloatrange(6,18);
			var_0A = randomfloatrange(0.2,0.55);
			if(common_scripts\utility::func_1DE9())
			{
				var_08 = var_08 * -1;
			}

			if(common_scripts\utility::func_1DE9())
			{
				var_09 = var_09 * -1;
			}

			if(common_scripts\utility::func_1DE9())
			{
				var_0A = var_0A * -1;
			}

			var_0B = randomint(3);
			if(var_0B == 0)
			{
				var_03 thread func_7912(var_08,var_0A,var_09);
			}
			else if(var_0B == 1)
			{
				var_03 thread func_7912(var_09,var_08,var_0A);
			}
			else if(var_0B == 2)
			{
				var_03 thread func_7912(var_0A,var_09,var_08);
			}
		}
	}
}

//Function Number: 33
decomp_anim_line_1(param_00)
{
	maps\_utility::func_62C7();
	maps\_utility::smart_radio_dialogue("odin_kyr_houston");
}

//Function Number: 34
decomp_anim_line_2(param_00)
{
	maps\_utility::func_62C7();
	maps\_utility::smart_radio_dialogue("odin_kyr_houstonbudandi");
	common_scripts\utility::flag_set("decomp_anim_VO_complete");
}

//Function Number: 35
func_7912(param_00,param_01,param_02)
{
	self endon("death");
	level endon("stop_spinning_debris");
	var_03 = param_00 / 10;
	var_04 = param_01 / 10;
	var_05 = param_02 / 10;
	for(;;)
	{
		var_06 = combineangles(self.angles,(var_03,var_04,var_05));
		self rotateto(var_06,0.1);
		wait(0.05);
	}
}