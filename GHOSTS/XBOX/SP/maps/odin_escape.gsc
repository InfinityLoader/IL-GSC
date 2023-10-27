/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_escape.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 65
 * Decompile Time: 876 ms
 * Timestamp: 10/27/2023 1:36:51 AM
*******************************************************************/

//Function Number: 1
func_2FD5()
{
	maps/odin_util::move_player_to_start_point("start_odin_escape");
	wait(0.1);
	maps/odin_util::actor_teleport(level.ally,"odin_escape_ally_tp");
	level.ally.animname = "odin_ally";
	maps/odin_util::func_3637();
	thread maps/odin_util::func_2BAB();
	level.player thread maps/odin::func_3CD8();
	common_scripts\utility::flag_set("ally_clear");
	common_scripts\utility::flag_set("ally_out_of_z");
	thread crew_quarters_combat();
	thread maps/odin_audio::func_732C();
	thread maps\odin_fx::func_6A5C();
	maps\_utility::func_252F(2,::maps/odin_ally::func_60D0);
	wait(1);
	thread maps/odin_util::create_sliding_space_door("z_hall_close_door",1,0,0,0,"lock_z_hall_close_door","unlock_z_hall_close_door");
	common_scripts\utility::flag_set("lock_z_hall_close_door");
}

//Function Number: 2
func_6D5B()
{
	precacheitem("odin_rod_missile");
	precachestring(&"ODIN_ADS_TIP");
	precachestring(&"ODIN_ESCAPE_DOOR_PROMPT");
}

//Function Number: 3
func_6D56()
{
	common_scripts\utility::func_3385("escape_clear");
	common_scripts\utility::func_3385("player_open_escape_door");
	common_scripts\utility::func_3385("kyra_push_bag_anim");
	common_scripts\utility::func_3385("window_VO_Done");
	common_scripts\utility::func_3385("remove_window_blocker");
	common_scripts\utility::func_3385("open_second_pod");
	common_scripts\utility::func_3385("escape_blocker_door_trig");
	common_scripts\utility::func_3385("clear_to_tweak_player");
	common_scripts\utility::func_3385("lock_escape_window_auto_door");
	common_scripts\utility::func_3385("unlock_escape_window_auto_door");
	common_scripts\utility::func_3385("lock_z_hall_close_door");
	common_scripts\utility::func_3385("lock_escape_door_blocker");
	common_scripts\utility::func_3385("unlock_escape_door_blocker");
	common_scripts\utility::func_3385("lock_spin_door_blocker");
	common_scripts\utility::func_3385("unlock_spin_door_blocker");
	common_scripts\utility::func_3385("escape_enc_activated");
	common_scripts\utility::func_3385("cq_killer_dead");
	common_scripts\utility::func_3385("enc_movement_token_taken");
	common_scripts\utility::func_3385("esc_combat_done");
	common_scripts\utility::func_3385("ready_to_fire_next_salvo");
	common_scripts\utility::func_3385("fire_rog");
	common_scripts\utility::func_3385("ally_at_console");
	common_scripts\utility::func_3385("ally_console_scene_done");
	common_scripts\utility::func_3385("destruction_sequence_started");
	common_scripts\utility::func_3385("objective_escape_sat");
	common_scripts\utility::func_3385("escape_overlap_dialogue");
}

//Function Number: 4
func_6D58()
{
	maps\_utility::add_hint_string("escape_ADS_Hint",&"ODIN_ADS_TIP",::func_4265);
	maps\_utility::add_hint_string("escape_door_prompt",&"ODIN_ESCAPE_DOOR_PROMPT",::func_4265);
}

//Function Number: 5
func_4265()
{
	if(common_scripts\utility::flag("esc_combat_done") || level.player adsbuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
escape_main()
{
	common_scripts\utility::flag_wait("ally_clear");
	common_scripts\utility::flag_set("unlock_escape_window_auto_door");
	function_0168("ammoCounterHide","0");
	thread escape_combat_door();
	escape_setup();
	common_scripts\utility::flag_wait("esc_combat_done");
	maps\_utility::autosave_by_name("escape_combat_done");
	func_2139();
	thread func_2BC4();
	ally_console_scene();
	maps\_utility::autosave_by_name("escape_window_done");
	if(!common_scripts\utility::flag("absolute_fire_decompression"))
	{
		func_26A8();
	}

	common_scripts\utility::flag_wait_all("escape_clear","player_exited_escape_hallway");
	func_2FA5();
}

//Function Number: 7
escape_combat_door()
{
	level endon("kyra_got_impatient");
	thread func_2FC1();
	var_00 = maps\_utility::func_777F("space_square_hatch");
	var_00.targetname = "escape_door_to_open";
	var_01 = getent("player_escape_door_blocker","targetname");
	var_02 = getent("player_escape_door_blocker_origin","targetname");
	var_03 = common_scripts\utility::func_3C18("kyra_move_node01","targetname");
	var_03 maps\_anim::anim_first_frame_solo(var_00,"odin_escape_open_door_player");
	var_02 linkto(var_00,"tag_origin");
	var_01 linkto(var_02);
	common_scripts\utility::flag_wait("esc_combat_done");
	common_scripts\utility::func_337C("clear_to_tweak_player");
	var_00 makeusable();
	var_00 sethintstring(&"ODIN_ESCAPE_DOOR_PROMPT");
	var_00 waittill("trigger");
	thread func_5DE0(var_03,var_00);
	var_00 makeunusable();
	common_scripts\utility::flag_wait("player_open_escape_door");
	var_03 maps\_anim::anim_single_solo(var_00,"odin_escape_open_door_player");
	common_scripts\utility::flag_set("clear_to_tweak_player");
	var_01 delete();
	var_02 delete();
}

//Function Number: 8
func_2FC1()
{
	level endon("escape_clear");
	wait(1);
	while(!common_scripts\utility::flag("player_open_escape_door"))
	{
		if(common_scripts\utility::flag("player_at_escape_door"))
		{
			common_scripts\utility::flag_set("no_push_zone");
			continue;
		}

		common_scripts\utility::func_337C("no_push_zone");
		wait(0.05);
	}
}

//Function Number: 9
func_2F9C()
{
	level endon("player_opened_escape_door");
	var_00 = common_scripts\utility::func_3C18("kyra_move_node01","targetname");
	thread func_4B6B(var_00);
	var_00 notify("stop_loop");
	thread kyra_grabs_escape_gun(var_00);
	var_00 maps\_anim::anim_single_solo(self,"odin_escape_first_encounter_end_ally01");
	var_00 thread maps\_anim::anim_loop_solo(self,"odin_escape_first_encounter_end_loop_ally01","stop_loop");
	thread maps/odin_util::func_323C(var_00,"stop_loop");
	ally_wait_to_get_impatient(4.5);
	common_scripts\utility::func_33A0("player_at_escape_door");
	level notify("kyra_got_impatient");
	var_00 notify("stop_loop");
	var_01 = getent("escape_door_to_open","targetname");
	var_01 makeunusable();
	level.ally.var_2FA0 = "odin_escape_zigzag_bag_02";
	common_scripts\utility::flag_set("kyra_push_bag_anim");
	thread maps/odin_util::push_out_of_doorway("X","<",1000,1000);
	var_00 thread maps\_anim::anim_single_solo(var_01,"odin_escape_zigzag_start_door");
	common_scripts\utility::flag_set("clear_to_tweak_player");
	thread maps/odin_audio::func_72F6();
	var_00 maps\_anim::anim_single_solo(self,"odin_escape_zigzag_start_ally01");
	thread func_2F9D(var_00);
}

//Function Number: 10
func_2F9D(param_00)
{
	level endon("early_decomp");
	thread maps/odin_spin::func_6146();
	param_00 notify("stop_loop");
	param_00 thread maps\_anim::anim_loop_solo(self,"odin_escape_zigzag_start_loop_ally01","stop_loop");
	thread maps/odin_util::func_323C(param_00,"stop_loop");
	common_scripts\utility::flag_wait("escape_blocker_door_trig");
	param_00 notify("stop_loop");
	param_00 = common_scripts\utility::func_3C18("kyra_move_node02","targetname");
	param_00 maps\_anim::anim_single_solo(self,"odin_escape_zigzag_second_ally01");
	param_00 maps\_anim::anim_single_solo(self,"odin_escape_zigzag_to_spin_ally01");
	param_00 thread maps\_anim::anim_loop_solo(self,"odin_escape_zigzag_to_spin_loop_ally01","stop_loop");
	thread maps/odin_util::func_323C(param_00,"stop_loop");
	self method_8225(self.origin);
	common_scripts\utility::flag_set("escape_clear");
	self notify("done_with_escape");
	common_scripts\utility::flag_wait("start_near_explosion_sequence");
	param_00 notify("stop_loop");
}

//Function Number: 11
kyra_grabs_escape_gun(param_00)
{
	level.ally maps\_utility::func_3DFD();
	var_01 = maps\_utility::func_777F("kyra_gun");
	var_01 attach("weapon_acog_iw6","tag_acog_2",1);
	var_01 attach("weapon_barrel_shroud_iw6","tag_silencer",1);
	param_00 maps\_anim::anim_single_solo(var_01,"odin_escape_first_encounter_end_tar21");
	var_01 delete();
	level.ally maps\_utility::gun_recall();
}

//Function Number: 12
ally_wait_to_get_impatient(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		if(level.ally.origin[0] < level.player.origin[0] - 64)
		{
			break;
		}

		wait(1);
	}
}

//Function Number: 13
func_4B6B(param_00)
{
	var_01 = maps\_utility::func_777F("space_escape_pack");
	param_00 maps\_anim::anim_first_frame_solo(var_01,"odin_escape_zigzag_bag_01");
	common_scripts\utility::flag_wait("kyra_push_bag_anim");
	param_00 maps\_anim::anim_single_solo(var_01,level.ally.var_2FA0);
}

//Function Number: 14
func_5DE0(param_00,param_01)
{
	level endon("kyra_got_impatient");
	level notify("player_opened_escape_door");
	var_02 = maps\_utility::func_777F("player_rig");
	var_02 hide();
	param_00 maps\_anim::anim_first_frame_solo(var_02,"odin_escape_open_door_player");
	var_03 = 0;
	thread maps/odin_audio::func_733C();
	level.player disableweapons();
	level.player playerlinktoblend(var_02,"tag_player",0.5,0,0);
	wait(0.5);
	level.player playerlinktodelta(var_02,"tag_player",1,var_03,var_03,var_03,var_03,1);
	thread escape_door_anim_player(param_00,var_02);
	param_00 notify("stop_loop");
	level.ally.var_2FA0 = "odin_escape_zigzag_bag_01";
	common_scripts\utility::flag_set("kyra_push_bag_anim");
	param_00 maps\_anim::anim_single_solo(level.ally,"odin_escape_open_door_player");
	level.ally thread func_2F9D(param_00);
}

//Function Number: 15
escape_door_anim_player(param_00,param_01)
{
	var_02 = maps\_utility::func_777F("finale_gun");
	var_02.origin = param_01 gettagorigin("tag_weapon");
	var_02.angles = param_01 gettagangles("tag_weapon");
	var_02 linkto(param_01,"tag_weapon");
	param_01 show();
	param_00 maps\_anim::anim_single_solo(param_01,"odin_escape_open_door_player");
	common_scripts\utility::func_337C("no_push_zone");
	level.player unlink();
	var_02 delete();
	param_01 delete();
	level.player enableweapons();
	wait(1);
}

//Function Number: 16
escape_door_open_rumble(param_00)
{
	level.player playrumbleonentity("light_1s");
}

//Function Number: 17
func_2FAE(param_00)
{
	common_scripts\utility::flag_set("player_open_escape_door");
}

//Function Number: 18
escape_setup()
{
	function_0168("ragdoll_max_life",90000);
	thread maps/odin_util::func_3432("floaters_zigzag_module");
	thread maps/odin_util::create_sliding_space_door("post_z_door",1.2,0.1,0,0,"lock_post_z_room","unlock_post_z_room");
	thread maps/odin_util::create_sliding_space_door("escape_window_auto_door",1.2,0.1,0,0,"lock_escape_window_auto_door","unlock_escape_window_auto_door");
	thread maps/odin_util::create_sliding_space_door("escape_door_blocker",1,0,0,0,"lock_escape_door_blocker","unlock_escape_door_blocker");
	thread maps/odin_util::create_sliding_space_door("spin_door_blocker",0.75,0,0,0,"lock_spin_door_blocker","unlock_spin_door_blocker");
	thread func_2FA1();
	common_scripts\utility::flag_set("unlock_escape_door_blocker");
	common_scripts\utility::flag_set("unlock_spin_door_blocker");
	thread func_5069("show");
	var_00 = maps/odin_util::func_6A53();
	var_01 = getent("escape_sat_orientation","targetname");
	var_00 moveto(var_01.origin,0.1,0,0);
	var_00 rotateto(var_01.angles,0.1,0,0);
	wait(0.15);
	thread func_6138();
	level.var_245C = thread maps/odin_util::create_sliding_space_door("spin_decomp_door",0.3,0.1,0,0,"lock_decomp_room","open_decomp_room_door");
}

//Function Number: 19
func_6138()
{
	level.var_57FB maps\_anim::anim_single(level.animated_sat_part,"sat_blossom_close");
	var_00 = [];
	var_01 = [];
	var_02 = [];
	var_00["odin_sat_section_04_pod_doorR_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_01"];
	var_02["odin_sat_section_04_pod_doorR_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_02"];
	var_01["odin_sat_section_04_pod_doorR_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_03"];
	var_00["odin_sat_section_04_pod_doorR_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_04"];
	var_00["odin_sat_section_04_pod_doorL_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_01"];
	var_02["odin_sat_section_04_pod_doorL_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_02"];
	var_01["odin_sat_section_04_pod_doorL_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_03"];
	var_00["odin_sat_section_04_pod_doorL_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_04"];
	level.var_57FB maps\_anim::anim_first_frame(var_00,"sat_blossom_open");
	level.var_57FB maps\_anim::anim_first_frame(var_01,"sat_blossom_open");
	level.var_57FB maps\_anim::anim_first_frame(var_02,"sat_blossom_open");
	level thread maps\odin_fx::fx_sat_doors_open(var_00);
	level.var_57FB thread maps\_anim::anim_single(var_00,"sat_blossom_open");
	common_scripts\utility::flag_wait("start_odin_firing_scene");
	level thread maps\odin_fx::fx_sat_doors_open(var_01);
	level.var_57FB thread maps\_anim::anim_single(var_01,"sat_blossom_open");
	wait(5);
	level thread maps\odin_fx::fx_sat_doors_open(var_02);
	level.var_57FB thread maps\_anim::anim_single(var_02,"sat_blossom_open");
}

//Function Number: 20
func_2FA1()
{
	var_00 = getent("escape_door_blocker_lens_cap","targetname");
	var_01 = getent("escape_door_blocker_lens_cap_origin","targetname");
	var_02 = var_01.origin;
	var_00 linkto(var_01);
	var_01 moveto((0,0,0),0.1,0,0);
	var_00 hide();
	common_scripts\utility::flag_wait("lock_escape_door_blocker");
	var_01 moveto(var_02,0.1,0,0);
	wait(1);
	var_00 show();
}

//Function Number: 21
crew_quarters_combat()
{
	level.ally maps\_utility::set_ignoreall(1);
	level.ally maps\_utility::func_3DFD();
	level.ally.ignoreme = 1;
	common_scripts\utility::flag_set("unlock_post_z_room");
	func_213B();
	level.ally thread func_542B();
	wait(1);
	thread func_6EC4("escape_enc_activated");
	crew_quarters_crew_killed();
	common_scripts\utility::flag_wait_all("first_enc_dead","cq_killer_dead");
	common_scripts\utility::flag_set("esc_combat_done");
	common_scripts\utility::flag_set("kyra_ally_vo_01");
}

//Function Number: 22
create_escape_doors()
{
}

//Function Number: 23
func_542B()
{
	maps\_utility::func_252F(3,::maps\_utility::smart_radio_dialogue,"odin_kyr_budlookouttheres");
	common_scripts\utility::flag_wait("ally_out_of_z");
	var_00 = common_scripts\utility::func_3C18("kyra_move_node01","targetname");
	var_00 maps\_anim::anim_single_solo(self,"odin_escape_first_encounter_ally01");
	var_00 thread maps\_anim::anim_loop_solo(self,"odin_escape_first_encounter_loop_ally01","stop_loop");
	thread maps/odin_util::func_323C(var_00,"stop_loop");
}

//Function Number: 24
crew_quarters_crew_killed()
{
	var_00 = getent("cq_enc_enemy_killer","script_noteworthy");
	var_01 = var_00 maps/odin_util::func_7806(1);
	var_01 maps\_utility::func_34E3(level.player.var_8D96,"primary");
	var_01 hidepart("tag_silencer");
	var_02 = getent("cq_killed_crew","targetname");
	var_03 = var_02 maps/odin_util::func_7806(1);
	var_03.team = "neutral";
	var_01.ignoreall = 1;
	var_01.animname = "odin_opfor";
	var_01.allowdeath = 1;
	var_01 thread maps/odin_util::odin_drop_weapon();
	var_03.ignoreall = 1;
	var_03.var_5650 = 1;
	var_03.animname = "odin_redshirt";
	var_03 maps\_utility::func_3DFD();
	var_04 = common_scripts\utility::func_3C18("kyra_move_node01","targetname");
	var_04 thread maps\_anim::anim_single_solo(var_01,"odin_escape_first_encounter_opfor");
	thread redshirt_cq_enc_handles(var_03,var_04);
	var_04 = getnode("node_cq_enc_middle_middle","targetname");
	if(isalive(var_01))
	{
		var_01.fixednode = 1;
		var_01.ignoreall = 0;
		var_01 method_8225(var_01.origin);
		var_01.favoriteenemy = level.player;
	}

	while(isalive(var_01))
	{
		wait(0.01);
	}

	if(isalive(var_03))
	{
		var_03 method_82E7();
	}

	wait(1.5);
	for(var_05 = 0;var_05 < 25;var_05++)
	{
		physicsexplosionsphere(var_04.origin,48,32,0.1);
		wait(0.05);
	}
}

//Function Number: 25
redshirt_cq_enc_handles(param_00,param_01)
{
	param_00 endon("death");
	param_00.forceragdollimmediate = 1;
	param_01 maps\_anim::anim_single_solo(param_00,"odin_escape_first_encounter_redshirt");
	wait(0.1);
	if(isalive(param_00))
	{
		param_00 method_82E7();
	}
}

//Function Number: 26
func_2FAA(param_00)
{
	var_01 = lookupsoundlength(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		wait(randomfloatrange(0.2,0.6));
		magicbullet("microtar_space_interior+acogsmg_sp+spaceshroud_sp",var_03.origin + (randomfloatrange(1,2),randomfloatrange(1,2),randomfloatrange(1,2)),var_03.origin);
	}
}

//Function Number: 27
func_213B()
{
	var_00 = getentarray("cq_enc_enemies","targetname");
	level.aenemies = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		switch(var_00[var_01].script_noteworthy)
		{
			case "cq_enc_enemy_00":
				var_00[var_01] maps\_utility::add_spawn_function(::func_2FB1);
				break;

			case "cq_enc_enemy_01":
				var_00[var_01] maps\_utility::add_spawn_function(::escape_enemy_01_think);
				break;

			case "cq_enc_enemy_02":
				var_00[var_01] maps\_utility::add_spawn_function(::escape_enemy_02_think);
				break;

			case "cq_enc_enemy_03":
				var_00[var_01] maps\_utility::add_spawn_function(::escape_enemy_03_think);
				break;
		}

		level.cq_enemies[var_01] = var_00[var_01] maps/odin_util::func_7806(1);
	}
}

//Function Number: 28
cq_room_destruction()
{
	level endon("enter_window_scene");
	common_scripts\utility::flag_wait("escape_enc_activated");
	var_00 = getent("escape_crates_damage_check","targetname");
	var_00 setcandamage(1);
	var_00 waittill("damage");
	var_01 = getentarray("cq_dyn_cargo_01_static","targetname");
	foreach(var_03 in var_01)
	{
		var_03 delete();
	}
}

//Function Number: 29
escape_enemy_setup()
{
	self.ignoreall = 1;
	self.moveplaybackrate = 1;
	self.goalradius = 16;
	thread maps/odin_util::odin_drop_weapon();
}

//Function Number: 30
cq_combat_movement()
{
	self endon("stop_combat");
	self endon("death");
	var_00 = getnodearray("nodes_cq_enc","script_noteworthy");
	for(;;)
	{
		wait(randomfloatrange(0.5,2.5));
		if(common_scripts\utility::flag("enc_movement_token_taken"))
		{
			common_scripts\utility::func_33A2("enc_movement_token_taken",4);
		}

		if(function_016A("axis") == 1)
		{
			self endon("death");
			self.goalradius = 64;
			for(;;)
			{
				self method_8225(level.player.origin);
				wait(2);
			}

			continue;
		}

		var_01 = var_00[randomintrange(0,var_00.size)];
		self.goalradius = 16;
		if(!function_01CF(var_01))
		{
			common_scripts\utility::flag_set("enc_movement_token_taken");
			self method_8224(var_01);
			self waittill("goal");
			common_scripts\utility::func_337C("enc_movement_token_taken");
			wait(2);
		}
	}

	common_scripts\utility::func_337C("enc_movement_token_taken");
}

//Function Number: 31
func_2FB1()
{
	self endon("death");
	maps\_utility::func_3DFD();
	maps\_utility::func_34E3(level.player.var_8D96,"primary");
	self.fixednode = 1;
	maps\_utility::func_6EFD(2);
	thread maps/odin_util::npc_physics_pulse();
	escape_enemy_setup();
	common_scripts\utility::flag_wait_or_timeout("escape_enc_activated",6);
	common_scripts\utility::flag_set("escape_enc_activated");
	wait(randomfloatrange(0.3,1));
	self.ignoreall = 0;
	self.favoriteenemy = level.player;
	var_00 = getnode("node_cq_enc_forward_left","targetname");
	self method_8224(var_00);
	self waittill("goal");
}

//Function Number: 32
escape_enemy_01_think()
{
	maps\_utility::func_3DFD();
	maps\_utility::func_34E3(level.player.var_8D96,"primary");
	self.fixednode = 1;
	maps\_utility::func_6EFD(2);
	thread maps/odin_util::npc_physics_pulse();
	escape_enemy_setup();
	common_scripts\utility::flag_wait_or_timeout("escape_enc_activated",6);
	common_scripts\utility::flag_set("escape_enc_activated");
	wait(randomfloatrange(0.3,1));
	self.ignoreall = 0;
	self.favoriteenemy = level.player;
	var_00 = getnode("node_cq_enc_middle_right","targetname");
	self method_8224(var_00);
	self waittill("goal");
	thread cq_combat_movement();
	self waittill("death");
	common_scripts\utility::func_337C("enc_movement_token_taken");
	self notify("stop_combat");
}

//Function Number: 33
escape_enemy_02_think()
{
	maps\_utility::func_3DFD();
	maps\_utility::func_34E3(level.player.var_8D96,"primary");
	thread maps/odin_util::npc_physics_pulse();
	var_00 = getent("cq_killed_crew2","targetname");
	var_01 = var_00 maps/odin_util::func_7806(1);
	var_01.team = "neutral";
	self.ignoreall = 1;
	self.animname = "odin_opfor";
	self.allowdeath = 1;
	var_01.ignoreall = 1;
	var_01.var_5650 = 1;
	var_01.animname = "odin_redshirt";
	var_01 maps\_utility::func_3DFD();
	var_02 = common_scripts\utility::func_3C18("kyra_move_node01","targetname");
	var_02 thread maps\_anim::anim_single_solo(self,"odin_escape_first_encounter_opfor02");
	thread func_6419(var_01,var_02);
	var_02 = getnode("node_cq_enc_middle_right","targetname");
	if(isalive(self))
	{
		self.fixednode = 1;
		self.ignoreall = 0;
		self method_8224(var_02);
		thread cq_combat_movement();
		self.favoriteenemy = level.player;
	}

	self.fixednode = 1;
	maps\_utility::func_6EFD(2);
	escape_enemy_setup();
	thread firing_into_bunks();
	common_scripts\utility::flag_wait_or_timeout("escape_enc_activated",6);
	common_scripts\utility::flag_set("escape_enc_activated");
	wait(randomfloatrange(0.3,1));
	self.ignoreall = 0;
	self.favoriteenemy = level.player;
	var_03 = getnode("node_cq_enc_middle_right","targetname");
	self method_8224(var_03);
	self waittill("death");
	thread func_2FAA("esc_fuse_boxes_01_exploder");
	common_scripts\utility::flag_set("trigger_third_guy");
	common_scripts\utility::func_337C("enc_movement_token_taken");
	self notify("stop_combat");
}

//Function Number: 34
func_6419(param_00,param_01)
{
	param_01 maps\_anim::anim_single_solo(param_00,"odin_escape_first_encounter_redshirt02");
	param_00.forceragdollimmediate = 1;
	wait(0.1);
	if(isalive(param_00))
	{
		param_00 method_82E7();
	}
}

//Function Number: 35
escape_enemy_03_think()
{
	self endon("death");
	maps\_utility::func_3DFD();
	maps\_utility::func_34E3(level.player.var_8D96,"primary");
	var_00 = level.player.threatbias;
	var_01 = level.ally.threatbias;
	var_02 = getent("thirdGuyTarget","targetname");
	maps\_utility::func_6EFD(2);
	self method_8225(var_02.origin);
	self.fixednode = 1;
	maps\_utility::magic_bullet_shield();
	maps\_utility::disable_arrivals();
	thread maps/odin_util::odin_drop_weapon();
	thread maps/odin_util::npc_physics_pulse();
	common_scripts\utility::flag_wait_or_timeout("trigger_third_guy",8);
	thread maps/odin_audio::sfx_phantom_door_close();
	maps\_utility::func_7C38();
	level.ally.ignoreme = 1;
	var_02 = getnode("third_guy_destination","targetname");
	self method_8225(var_02.origin);
	self.ignoreall = 0;
	self.favoriteenemy = level.ally;
	level.ally.threatbias = 10000;
	self waittill("goal");
	level.player.threatbias = var_00;
	level.ally.threatbias = var_01;
	level.player.ignoreme = 0;
	level.ally.ignoreme = 1;
	self waittill("death");
	thread func_2FAA("esc_fuse_boxes_02_exploder");
	common_scripts\utility::func_337C("enc_movement_token_taken");
	self notify("stop_combat");
}

//Function Number: 36
func_8088()
{
	self endon("death");
	var_00 = gettime();
	var_01 = gettime() - 3000;
	var_02 = getnode("cq_ally_position","targetname");
	while(var_01 < var_00)
	{
		var_01 = gettime() - 3000;
		var_03 = randomfloatrange(0.1,0.5);
		for(var_04 = 0;var_04 < 3;var_04++)
		{
			if(isalive(self))
			{
				self method_81D1(1,var_02.origin,1);
			}
			else
			{
				break;
			}

			wait(0.05);
		}

		wait(var_03);
	}
}

//Function Number: 37
firing_into_bunks()
{
	self endon("death");
	level endon("escape_enc_activated");
	self.goalradius = 16;
	self waittill("goal");
	maps\_utility::disable_pain();
	var_00 = getent(self.script_noteworthy + "_aim","targetname");
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		magicbullet(self.weapon,self gettagorigin("tag_flash"),var_00.origin);
		wait(randomfloatrange(0.1,0.5));
	}

	self method_8225(self.origin);
}

//Function Number: 38
func_6EC4(param_00)
{
	level endon(param_00);
	if(common_scripts\utility::flag(param_00))
	{
	}

	for(;;)
	{
		level.player waittill("weapon_fired");
		break;
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 39
func_2139()
{
	level.ally thread func_2F9C();
	thread escape_dialogue();
	common_scripts\utility::flag_wait("start_odin_firing_scene");
}

//Function Number: 40
escape_dialogue()
{
	maps\_utility::smart_radio_dialogue("odin_shq_odinpayload1uploading");
	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_atl_targetinglosangeles");
	}

	wait(0.9);
	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_atl_sandiegolocked");
	}

	wait(1.2);
	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_atl_phoenixlocked");
	}

	wait(0.4);
	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_atl_targetinghouston");
	}

	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_atl_targetingmiami");
	}

	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_shq_odintargetingsolutionsare");
	}

	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_shq_rodfeedengaging");
	}

	if(!common_scripts\utility::flag("start_odin_firing_scene"))
	{
		maps\_utility::smart_radio_dialogue("odin_kyr_budfollowmewe");
	}
}

//Function Number: 41
check_for_escape_dialogue_overlap(param_00)
{
	common_scripts\utility::flag_set("escape_overlap_dialogue");
	maps\_utility::smart_radio_dialogue(param_00);
	common_scripts\utility::func_337C("escape_overlap_dialogue");
}

//Function Number: 42
ally_console_scene()
{
	level endon("early_decomp");
	common_scripts\utility::flag_wait("start_odin_firing_scene");
	thread func_4EC8();
	thread console_scene_player_blocker();
	level.ally play_console_scene();
}

//Function Number: 43
func_4EC8()
{
	level endon("early_decomp");
	common_scripts\utility::flag_wait("escape_blocker_door_trig");
	common_scripts\utility::flag_set("lock_escape_window_auto_door");
}

//Function Number: 44
play_console_scene()
{
	level endon("early_decomp");
	thread func_580B();
	console_scene_dialogue();
}

//Function Number: 45
ally_dialogue_overlap_check(param_00)
{
	if(common_scripts\utility::flag("escape_overlap_dialogue"))
	{
		maps\_utility::func_762F(param_00);
	}

	maps\_utility::smart_radio_dialogue(param_00);
}

//Function Number: 46
func_8E03(param_00)
{
	ally_dialogue_overlap_check("odin_ast1_ohnoodinis");
}

//Function Number: 47
func_8E04(param_00)
{
	common_scripts\utility::flag_set("open_second_pod");
	ally_dialogue_overlap_check("odin_kyr_theyreuploadingmore");
	common_scripts\utility::flag_set("fire_rog");
}

//Function Number: 48
func_8E05(param_00)
{
	maps\_utility::func_62C7();
	maps\_utility::smart_radio_dialogue("odin_ast1_houstonwhatdowe");
}

//Function Number: 49
func_8E06(param_00)
{
	maps\_utility::func_62C7();
	maps\_utility::smart_radio_dialogue("odin_ho2_odincontrolwehave");
}

//Function Number: 50
func_8E07(param_00)
{
	maps\_utility::func_62C7();
	maps\_utility::smart_radio_dialogue("odin_ho2_imsorrymosley");
}

//Function Number: 51
func_8E08(param_00)
{
	maps\_utility::func_62C7();
	maps\_utility::smart_radio_dialogue("odin_ast1_copyhouston");
	common_scripts\utility::flag_set("remove_window_blocker");
}

//Function Number: 52
func_8E09(param_00)
{
	maps\_utility::func_62C7();
	thread maps\_utility::smart_radio_dialogue("odin_ho2_initiatingin10seconds_2");
	maps\_utility::func_762F("odin_kyr_budweneedto_2");
	common_scripts\utility::flag_set("window_VO_Done");
}

//Function Number: 53
console_scene_dialogue()
{
	level endon("early_decomp");
	common_scripts\utility::flag_set("fire_rog");
	level notify("player_has_shroud_now");
	check_for_escape_dialogue_overlap("odin_shq_estimatedcasualties112");
	common_scripts\utility::flag_wait("window_VO_Done");
	common_scripts\utility::func_337C("clear_to_tweak_player");
	common_scripts\utility::flag_set("objective_escape_sat");
	common_scripts\utility::flag_set("ally_console_scene_done");
	thread maps\_utility::smart_radio_dialogue("odin_kyr_comeonbudif");
	common_scripts\utility::flag_set("fire_rog");
	thread maps/odin_audio::func_7368();
	wait(2);
	maps\_utility::func_762F("odin_shq_stationdetonationin3");
	common_scripts\utility::flag_set("destruction_sequence_started");
	thread func_60CF();
}

//Function Number: 54
func_60CF()
{
	level endon("early_decomp");
	level endon("player_exited_escape_hallway");
	var_00 = 4;
	for(;;)
	{
		wait(var_00);
		maps\_utility::smart_radio_dialogue("odin_kyr_budweneedto_2");
		var_00 = var_00 + 2;
		if(var_00 > 20)
		{
			var_00 = 20;
		}
	}
}

//Function Number: 55
func_580B()
{
	level endon("player_exited_escape_hallway");
	thread func_6139();
	thread maps\odin_fx::func_3607();
	common_scripts\utility::flag_wait("ally_at_console");
	wait(3);
}

//Function Number: 56
func_6139()
{
	level endon("player_exited_escape_hallway");
	common_scripts\utility::flag_wait("ready_to_fire_next_salvo");
	for(var_00 = 1;var_00 <= 4;var_00++)
	{
		common_scripts\utility::exploder("fx_odin_pods_opening_0" + var_00);
		var_01 = getentarray("odin_pod_panels_0" + var_00,"targetname");
		foreach(var_03 in var_01)
		{
			var_04 = getent(var_03.target,"targetname");
			var_03 moveto(var_04.origin,randomfloatrange(10,14),0.5,5);
			var_03 rotateto((var_03.angles[0] + randomint(4),var_03.angles[1] + randomint(4),var_03.angles[2] + randomint(4)),12,0.5,10);
		}

		common_scripts\utility::func_337C("ready_to_fire_next_salvo");
		common_scripts\utility::flag_wait("ready_to_fire_next_salvo");
		wait(0.1);
	}
}

//Function Number: 57
add_dialogue_line_timed(param_00,param_01,param_02,param_03)
{
	thread maps\_utility::add_dialogue_line(param_00,param_01,param_02);
	wait(param_03);
}

//Function Number: 58
console_scene_player_blocker()
{
	var_00 = getent("console_player_blocker","targetname");
	common_scripts\utility::flag_wait("remove_window_blocker");
	var_00 delete();
}

//Function Number: 59
func_26A8()
{
	common_scripts\utility::flag_wait("destruction_sequence_started");
	thread ramping_explosions();
	thread func_6307();
	thread func_2FB6();
	common_scripts\utility::flag_wait("player_exited_escape_hallway");
}

//Function Number: 60
ramping_explosions()
{
	level endon("start_near_explosion_sequence");
	level.var_5D19 = 1;
	var_00 = 0.02;
	var_01 = 0.1;
	thread maps/odin_audio::sfx_escape_destruction_fire_puffs();
	common_scripts\utility::exploder("escape_destruction");
	if(maps\_utility::func_47F6())
	{
		common_scripts\utility::exploder("escape_destruction_ng");
	}

	thread maps/odin_audio::func_7367();
	for(;;)
	{
		thread maps/odin_audio::func_736E();
		earthquake(randomfloatrange(var_00,var_01),1,level.player.origin,500);
		if(common_scripts\utility::func_1DE9())
		{
			level.player playrumbleonentity("light_3s");
		}
		else
		{
			level.player playrumbleonentity("heavy_1s");
		}

		common_scripts\utility::exploder("escape_destruction_random");
		wait(randomfloatrange(0.8,2.4));
		var_00 = var_00 + 0.05;
		var_01 = var_01 + 0.08;
		if(var_00 > 0.15)
		{
			var_00 = 0.15;
		}

		if(var_01 > 0.35)
		{
			var_01 = 0.35;
		}
	}
}

//Function Number: 61
func_6307()
{
	level endon("player_exited_escape_hallway");
	wait(randomfloatrange(1.2,2.2));
	common_scripts\utility::exploder("escape_destruction_random");
}

//Function Number: 62
func_2FB6()
{
	level endon("odin_start_spin_decomp");
	wait(20);
	var_00 = getentarray("escape_fail_explosion_FX_Origin","script_noteworthy");
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	foreach(var_05 in var_00)
	{
		var_01 = randomintrange(-40,40);
		var_02 = randomintrange(-40,40);
		var_03 = randomintrange(0,40);
		var_05.origin = level.player.origin + (var_01,var_02,var_03);
		playfx(common_scripts\utility::func_3AB9("spc_explosion_1200"),var_05.origin);
	}

	level.player playsound("scn_odin_decompression_explode2_ss");
	wait(0.5);
	foreach(var_05 in var_00)
	{
		playfx(common_scripts\utility::func_3AB9("spc_explosion_1200"),var_05.origin);
	}

	wait(0.5);
	level.player method_82E7();
	level notify("new_quote_string");
	setdvar("ui_deadquote",&"ODIN_WINDOW_TIMEOUT");
	maps\_utility::func_52F2();
}

//Function Number: 63
func_2BC4()
{
	common_scripts\utility::flag_wait("absolute_fire_decompression");
	level notify("early_decomp");
	level notify("player_exited_escape_hallway");
	level notify("odin_start_spin_decomp");
	level notify("start_near_explosion_sequence");
	common_scripts\utility::flag_set("start_near_explosion_sequence");
	common_scripts\utility::flag_set("player_exited_escape_hallway");
	common_scripts\utility::flag_set("escape_clear");
}

//Function Number: 64
func_2FA5(param_00)
{
	var_01 = getentarray("space_cover_test","targetname");
	foreach(var_03 in var_01)
	{
		var_03 delete();
	}

	var_05 = getentarray("cq_dynamic_objects","script_noteworthy");
	foreach(var_07 in var_05)
	{
		var_07 delete();
	}
}

//Function Number: 65
func_5069(param_00)
{
	var_01 = getent("fake_earth","targetname");
	if(!isdefined(var_01))
	{
	}

	switch(param_00)
	{
		case "hide":
			var_01 hide();
			break;

		case "show":
			var_01 show();
			break;

		case "delete":
			var_01 delete();
			break;
	}
}