/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_hospital.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 132
 * Decompile Time: 1964 ms
 * Timestamp: 4/22/2024 2:27:57 AM
*******************************************************************/

//Function Number: 1
hospital_main()
{
	thread final_approach();
	thread doctor_capture_inner_fight();
	thread hidden_kva();
	thread grenade_ambush();
	thread magic_grenades_thrown();
	thread hospital_desk_door_open();
	thread kva_last_heavy();
	if(level.nextgen)
	{
		thread setup_hospital_bodies();
	}
	else
	{
		thread maps\detroit_transients_cg::cg_setup_hospital_bodies();
	}

	thread hospital_escape_door_function();
	thread doctor_capture_dialogue();
	thread kva_sentinel_atlas_reveal_moment();
	thread maps\detroit_streets::shoot_at_sentinel_agents();
	thread disable_enable_exit_flags();
	thread doctor_capture_door_breach_anim();
	thread doctor_capture_breach_door_prompt();
	if(level.currentgen)
	{
		thread transient_middle_remove_nightclub_interior_begin();
		thread cg_visibility_proxy_office_interior();
	}
}

//Function Number: 2
cg_visibility_proxy_office_interior()
{
	if(level.currentgen && issubstr(level.transient_zone,"middle"))
	{
		var_00 = getent("office_interior_model","targetname");
		var_00 hide();
		var_00 setcontents(0);
	}

	if(level.currentgen && issubstr(level.transient_zone,"hospital"))
	{
		var_00 = getent("office_interior_model","targetname");
		var_00 show();
	}
}

//Function Number: 3
transient_middle_remove_nightclub_interior_begin()
{
	maps\_utility::trigger_wait_targetname("CG_LoadHospitalTrigger");
	level notify("tff_pre_middle_remove_nightclub");
	unloadtransient("detroit_nightclub_interior_tr");
	var_00 = getent("office_interior_model","targetname");
	var_00 show();
	thread transient_middle_add_hospital_interior_begin();
}

//Function Number: 4
transient_middle_add_hospital_interior_begin()
{
	loadtransient("detroit_hospital_interior_tr");
	for(;;)
	{
		if(istransientloaded("detroit_hospital_interior_tr"))
		{
			var_00 = getent("office_interior_model","targetname");
			var_00 show();
			level notify("tff_post_middle_add_hospital");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 5
grenade_ambush()
{
	maps\_utility::trigger_wait_targetname("grenade_trigger");
	wait(0.9);
	var_00 = getentarray("kva_grenade","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03.goalradius = 15;
		var_03.ignoreall = 1;
		var_03 maps\_utility::magic_bullet_shield();
		thread guy_toss_grenade(var_03);
	}
}

//Function Number: 6
guy_toss_grenade(param_00)
{
	maps\_utility::trigger_wait_targetname("kva_grenade_throw_trigger");
	param_00 maps\_utility::stop_magic_bullet_shield();
	param_00 maps\_utility::throwgrenadeatplayerasap();
	param_00.ignoreall = 0;
}

//Function Number: 7
magic_grenades_thrown()
{
	maps\_utility::trigger_wait_targetname("kva_grenade_throw_trigger");
	thread grenade_1();
	thread grenade_2();
	thread grenade_3();
	common_scripts\utility::flag_set("flashbang");
	wait(2.25);
	level.player shellshock("paris_scripted_flashbang",4);
	common_scripts\utility::flag_set("player_is_shocked");
	thread maps\_shg_design_tools::white_out(0.12,0.4);
	thread flash_mob1();
	thread flash_mob2();
	thread flash_mob3();
}

//Function Number: 8
hospital_desk_door_open()
{
	var_00 = getent("kva_door_buster","targetname");
	var_01 = getent("hospital_door_clip_open","targetname");
	var_02 = getent("first_hospital_door_open","targetname");
	var_01 notsolid();
	var_03 = getent("hospital_door_clip_closed","targetname");
	var_04 = getent("first_hospital_door_closed","targetname");
	var_02 hide();
	common_scripts\utility::flag_wait("player_is_shocked");
	var_04 delete();
	var_03 connectpaths();
	var_03 delete();
	var_02 show();
	var_01 solid();
	wait(0.05);
	var_05 = var_00 maps\_utility::spawn_ai(1);
	var_05.goalradius = 15;
	var_05 maps\_utility::disable_surprise();
	var_05 maps\_utility::disable_careful();
	var_06 = getnode("kva_door_buster_goal","targetname");
	var_05 setgoalnode(var_06);
}

//Function Number: 9
grenade_1()
{
	var_00 = getent("magic_grenade_start","targetname");
	var_01 = getent("magic_grenade_target","targetname");
	var_02 = magicgrenade("flash_grenade_var",var_00.origin,var_01.origin,2.25,1);
	soundscripts\_snd::snd_message("hospital_flashbang1",2.25,var_01.origin);
}

//Function Number: 10
grenade_2()
{
	var_00 = getent("magic_grenade_start2","targetname");
	var_01 = getent("magic_grenade_target2","targetname");
	var_02 = magicgrenade("flash_grenade_var",var_00.origin,var_01.origin,2.25,1);
	soundscripts\_snd::snd_message("hospital_flashbang2",2.25,var_01.origin);
}

//Function Number: 11
grenade_3()
{
	var_00 = getent("magic_grenade_start3","targetname");
	var_01 = getent("magic_grenade_target3","targetname");
	var_02 = magicgrenade("flash_grenade_var",var_00.origin,var_01.origin,2.25,1);
	soundscripts\_snd::snd_message("hospital_flashbang3",2.25,var_01.origin);
}

//Function Number: 12
flash_mob1()
{
	var_00 = getent("flash_mob_1","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "generic";
	var_01.ignoreall = 1;
	var_01.allowdeath = 1;
	var_02 = getent("hospital_mantle_1","targetname");
	var_02 maps\_anim::anim_single_solo(var_01,"hospital_mantle");
	var_01.ignoreall = 0;
	var_03 = getnode("kva_jumper_1_goal","targetname");
	var_01 setgoalnode(var_03);
}

//Function Number: 13
flash_mob2()
{
	var_00 = getent("flash_mob_2","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "generic";
	var_01.ignoreall = 1;
	var_01.allowdeath = 1;
	var_02 = getent("hospital_mantle_2","targetname");
	var_02 maps\_anim::anim_single_solo(var_01,"hospital_mantle_2");
	var_01.ignoreall = 0;
	var_03 = getnode("kva_jumper_2_goal","targetname");
	var_01 setgoalnode(var_03);
}

//Function Number: 14
flash_mob3()
{
	var_00 = getent("flash_mob_3","targetname");
	var_01 = var_00 maps\_utility::spawn_ai();
	if(isdefined(var_01))
	{
		var_02 = getent("hospital_fight_goal1","targetname");
		var_01 setgoalvolumeauto(var_02);
	}
}

//Function Number: 15
setup_hospital()
{
	thread team_move_hospital();
	thread hospital_kva_cleanup();
	thread make_gate_close_down();
	level.burke maps\_utility::enable_careful();
	level.joker maps\_utility::enable_careful();
	level.bones maps\_utility::enable_careful();
	var_00 = getent("dr_first_anim_org","targetname");
	maps\_utility::trigger_wait_targetname("kva_grenade_throw_trigger");
	var_00 notify("finish");
	thread kva_ar();
	var_01 = getent("kva_hospital_heavy_special","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02.combatmode = "no_cover";
	var_03 = getent("hospital_fight_goal1","targetname");
	var_02 setgoalvolumeauto(var_03);
	common_scripts\utility::flag_set("obj_capture_doctor_pos_doctor");
	common_scripts\utility::flag_set("doctor_inside_office_now");
}

//Function Number: 16
make_gate_close_down()
{
	var_00 = getent("gate_close_clip","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	maps\_utility::trigger_wait_targetname("doctor_chase_gate_close_trig");
	var_00 solid();
	var_00 disconnectpaths();
	var_01 = getent("hospital_gate_animated","targetname");
	var_02 = getent("gate_close_origin","targetname");
	var_01 soundscripts\_snd::snd_message("det_hospital_gate_close");
	var_01 moveto(var_02.origin,1,0.9,0.1);
	var_03 = getent("gate_lock_kva","targetname");
	var_04 = var_03 maps\_utility::spawn_ai(0,0);
	var_04 waittill("goal");
	var_04 maps\_utility::player_seek_enable();
}

//Function Number: 17
hospital_kva_cleanup()
{
	var_00 = getent("kickdown","targetname");
	var_00 waittill("trigger");
	var_01 = 0;
	var_02 = getentarray("killable","script_noteworthy");
	foreach(var_04 in var_02)
	{
		if(isalive(var_04))
		{
			var_04 thread maps\detroit_streets::random_bloody_death(1.25);
			var_01++;
		}
	}
}

//Function Number: 18
hidden_kva()
{
	maps\_utility::trigger_wait_targetname("kva_grenade_throw_trigger");
	var_00 = getent("special_KVA_cover_spawner","targetname");
	var_01 = var_00 maps\_utility::spawn_ai();
	var_01.ignoreall = 1;
	var_01.goalradius = 15;
	var_01 endon("death");
	maps\_utility::trigger_wait_targetname("trigger_hidden_kva");
	if(isalive(var_01))
	{
		var_01.ignoreall = 0;
	}
}

//Function Number: 19
check_if_hurt(param_00)
{
	while(param_00.ignoreall == 1)
	{
		if(param_00.health < 100)
		{
			param_00.ignoreall = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 20
retreating_kva()
{
	self endon("death");
	maps\_utility::trigger_wait_targetname("team_move_hospital");
	var_00 = getentarray("hospital_retreat_troops","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03 maps\_utility::enable_careful();
		var_03 maps\_utility::set_moveplaybackrate(0.8);
		thread retreat_function(var_03);
	}

	var_05 = getent("hospital_retreat_shooter","targetname");
	var_06 = var_05 maps\_utility::spawn_ai(1);
	var_06.ignoreall = 1;
	var_06.animname = "generic";
	var_06 disable_awareness();
	var_07 = getent("test_anim_spot","targetname");
	common_scripts\utility::flag_wait("send_hospital_runner");
	if(isalive(var_06))
	{
		var_06 maps\_utility::set_allowdeath(1);
		var_07 maps\_anim::anim_reach_solo(var_06,"run_and_shoot_behind");
		if(isalive(var_06))
		{
			var_07 thread maps\_anim::anim_single_solo(var_06,"run_and_shoot_behind");
		}

		var_06 enable_awareness();
		var_08 = getent("hospital_fight_goal1","targetname");
		var_06 setgoalvolumeauto(var_08);
	}

	if(isalive(var_06))
	{
		var_06 waittill("goal");
		var_06 maps\detroit::bloody_death(0.25);
	}
}

//Function Number: 21
retreat_function(param_00)
{
	common_scripts\utility::flag_wait("go_go_go");
	wait(randomintrange(4,8));
	if(isdefined(param_00))
	{
		var_01 = getent("hospital_fight_goal1","targetname");
		param_00 setgoalvolumeauto(var_01);
	}
}

//Function Number: 22
team_move_hospital()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	level.burke stopanimscripted();
	level.burke unlink();
	wait(0.25);
	thread burke_advance_hospital();
	wait(0.25);
	thread joker_advance_hospital();
	wait(0.5);
	thread bones_advance_hospital();
	level.bones maps\_utility::set_force_color("y");
	level.joker maps\_utility::set_force_color("o");
}

//Function Number: 23
hospital_escape_door_function()
{
	var_00 = getent("hospital_escape_door_open","targetname");
	var_01 = getent("hospital_escape_door_open_clip","targetname");
	var_02 = getent("hospital_escape_door_closed","targetname");
	var_03 = getent("hospital_escape_door_closed_clip","targetname");
	var_01 notsolid();
	var_00 hide();
	common_scripts\utility::flag_wait("player_captured_doctor");
	var_00 show();
	var_01 solid();
	var_03 connectpaths();
	var_02 delete();
	var_03 delete();
}

//Function Number: 24
burke_advance_hospital()
{
	var_00 = getnode("burke_holdup_before_going_upstairs_node","targetname");
	var_01 = getnode("burke_hospital_hide","targetname");
	level.burke.ignoreall = 0;
	level.burke.goalradius = 15;
	wait(0.9);
	thread doctor_capture_new_breach_doctor_takedown();
	common_scripts\utility::flag_set("go_go_go");
	level.burke setgoalnode(var_00);
	common_scripts\utility::flag_wait("send_all_teammates_upstairs");
	wait(0.5);
	level.burke setgoalnode(var_01);
}

//Function Number: 25
kva_sentinel_atlas_reveal_moment()
{
	var_00 = getent("kva_sentinel_squad_reveal_animnode","targetname");
	thread player_sentinel_kva_reveal();
	thread bouncing_betty_animated();
	thread maps\detroit_lighting::sentinel_reveal_lighting();
	thread pay_machine();
	maps\_utility::trigger_wait_targetname("sentinel_reveal_moment_trigger");
	maps\_utility::delaythread(6.69,::common_scripts\utility::flag_set,"show_sentinel_guys_now");
	level notify("stop_180_burke_now");
	thread player_jumped_out_vol();
	thread maps\detroit_streets::sneaky_reload();
	common_scripts\utility::flag_set("reveal_the_sentinels");
	common_scripts\utility::flag_set("joker_wait_before_reveal");
	thread sentinel_kva_fov_function();
	var_00 thread burke_sentinel_kva_reveal();
	var_00 thread guy1_sentinel_kva_reveal();
	var_00 thread guy2_sentinel_kva_reveal();
	if(level.nextgen)
	{
		var_00 thread guy3_sentinel_kva_reveal();
		var_00 thread kva2_sentinel_kva_reveal();
	}

	var_00 thread kva1_sentinel_kva_reveal();
	var_00 thread kva3_sentinel_kva_reveal();
	var_00 thread joker_sentinel_kva_reveal();
	thread doctor_kva_reveal();
	thread kva_ambush_last_group_reveal();
	wait(28);
	common_scripts\utility::flag_set("begin_kva_assault_on_sentinel");
	wait(10.65);
}

//Function Number: 26
player_jumped_out_vol()
{
	level.player endon("death");
	var_00 = getent("player_jumped_out_sentinel","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			common_scripts\utility::flag_set("exit_drive_cinematic_start");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 27
pay_machine()
{
	if(level.currentgen)
	{
		if(!istransientloaded("detroit_hospital_interior_tr"))
		{
			for(;;)
			{
				wait(0.25);
				if(istransientloaded("detroit_hospital_interior_tr"))
				{
					break;
				}
			}
		}
	}

	var_00 = maps\_utility::spawn_anim_model("pay_machine");
	var_01 = getent("kva_sentinel_squad_reveal_animnode","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"sentinel_kva_reveal");
	common_scripts\utility::flag_wait("knock_over_paymachine");
	var_01 maps\_anim::anim_single_solo(var_00,"sentinel_kva_reveal");
}

//Function Number: 28
bouncing_betty_animated()
{
	var_00 = getent("animated_destroy_box","targetname");
	var_01 = getent("animated_bouncing_betty","targetname");
	var_02 = getent("new_grenade_org","targetname");
	maps\_utility::trigger_wait_targetname("sentinel_reveal_moment_trigger");
	level notify("no_more_random_trains");
	setdemigodmode(level.player,1);
	soundscripts\_snd::snd_message("reveal_scene_start");
	var_01 moveto(var_01.origin + (0,0,50),0.6,0.3,0.2);
	wait(0.6);
	level.player shellshock("paris_scripted_flashbang",4);
	var_03 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_03 maps\_utility::set_rumble_intensity(0.5);
	var_03 maps\_utility::delaythread(0.8,::maps\_utility::set_rumble_intensity,0.01);
	thread maps\detroit_fx::cg_sentinel_fx_light();
	soundscripts\_snd::snd_message("reveal_explosion");
	wait(0.3);
	common_scripts\utility::flag_set("knock_over_paymachine");
	var_01 delete();
	var_00 delete();
	wait(2);
	setdemigodmode(level.player,0);
}

//Function Number: 29
sentinel_kva_fov_function()
{
	level.player lerpfov(55,2);
	common_scripts\utility::flag_wait("sentinel_kva_fov_lerp_out");
	level.player lerpfov(65,1);
}

//Function Number: 30
joker_sentinel_kva_reveal()
{
	level.doctor.ignoreme = 1;
	level.joker hide();
	var_00 = getnode("joker_with_doctor_waitnode","targetname");
	var_01 = getnode("joker_with_doctor_goal_node","targetname");
	level.joker maps\_utility::teleport_ai(var_00);
	level.joker setgoalnode(var_00);
	level.joker maps\_utility::delaythread(0.25,::show_me_now);
	var_02 = getent("joker_pickup_doctor_reveal_org","targetname");
	level.joker maps\_utility::gun_recall();
	thread maps\_anim::anim_single_solo(level.joker,"sentinel_kva_reveal");
	common_scripts\utility::flag_wait("send_joker_and_doctor_to_bikes");
	var_02 thread maps\_anim::anim_first_frame_solo(level.doctor,"carry_doc_lift");
	var_03 = getnode("joker_with_doctor_waitnode_beforehall","targetname");
	thread doctor_capture_doctor_carry(var_02,"player_on_exitdrive_jetbike",var_03);
	wait(5);
	common_scripts\utility::flag_set("sentinel_reveal_animation_complete");
	common_scripts\utility::flag_wait("exit_drive_cinematic_start");
	var_04 = getnode("joker_wait_withdoc_after_reveal","targetname");
	level.joker setgoalnode(var_04);
}

//Function Number: 31
doctor_kva_reveal()
{
	var_00 = getent("joker_pickup_doctor_reveal_org","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.doctor,"carry_doc_lift");
}

//Function Number: 32
show_me_now()
{
	self show();
}

//Function Number: 33
burke_pre_sentinel_kva_reveal()
{
	level.burke thread final_flag_wait();
	var_00 = getnode("burke_first_wait_after_capture_node","targetname");
	level.burke setgoalnode(var_00);
	common_scripts\utility::flag_wait("send_burke_to_stairs_waitpoint");
	var_01 = getnode("burke_wait_by_railwaydoor_node","targetname");
	level.burke setgoalnode(var_01);
	common_scripts\utility::flag_wait("send_burke_to_railway_half");
	var_02 = getnode("burke_half_railway_wait","targetname");
	level.burke setgoalnode(var_02);
	common_scripts\utility::flag_wait("send_burke_fully_across");
	var_03 = getnode("burke_post_before_sentinel_room","targetname");
	level.burke setgoalnode(var_03);
	level.burke.radius = 15;
	maps\detroit_school::is_1_near_2(level.burke,var_03,60);
	common_scripts\utility::flag_wait("make_burke_anim_reach_sentinel");
	common_scripts\utility::flag_wait("let_burke_reach_sentinel_reveal");
	var_04 = getent("burke_180_animorg","targetname");
	thread burke_180_function();
	common_scripts\utility::flag_wait("joker_wait_before_doorway");
	var_04 notify("ender");
	level.burke stopanimscripted();
	var_05 = getent("kva_sentinel_squad_reveal_animnode","targetname");
	var_06 = getnode("burke_wait_after_sentinel_moment","targetname");
	level.burke setgoalnode(var_06);
}

//Function Number: 34
burke_180_function()
{
	level.burke.animname = "burke";
	var_00 = getent("burke_180_animorg","targetname");
	var_01 = getnode("burke_wait_before_180","targetname");
	level.burke setgoalnode(var_01);
	maps\detroit_school::is_1_near_2(level.burke,var_01,100);
	var_02 = getnode("burke_wait_before_bomb","targetname");
	level.burke setgoalnode(var_02);
}

//Function Number: 35
final_flag_wait()
{
	var_00 = getnode("burke_post_before_sentinel_room","targetname");
	for(;;)
	{
		if(distance2d(level.burke.origin,var_00.origin) < 50)
		{
			common_scripts\utility::flag_set("let_burke_reach_sentinel_reveal");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 36
burke_sentinel_kva_reveal()
{
	level.burke stopanimscripted();
	var_00 = getent("kva_sentinel_squad_reveal_animnode","targetname");
	var_00 thread maps\_anim::anim_single_solo(level.burke,"sentinel_kva_reveal");
	level.burke.ignoreall = 1;
	level.burke.goalradius = 15;
	var_01 = getnode("burke_wait_after_sentinel_moment","targetname");
	level.burke setgoalnode(var_01);
}

//Function Number: 37
kva_show_timer()
{
	self hide();
	wait(3.27);
	self show();
}

//Function Number: 38
kill_me(param_00)
{
	self endon("death");
	var_01 = self geteye();
	wait(param_00);
	if(isalive(self))
	{
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
	}

	wait(0.1);
	if(isalive(self))
	{
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
	}

	wait(0.1);
	if(isalive(self))
	{
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
	}

	wait(0.1);
	if(isalive(self))
	{
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
	}

	wait(0.1);
	if(isalive(self))
	{
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
		magicbullet("iw5_bal27_sp",level.sentinel_guy1 gettagorigin("tag_flash"),var_01);
	}
}

//Function Number: 39
kva1_sentinel_kva_reveal()
{
	var_00 = getent("kva_reveal_spawner1","targetname");
	var_00.count = 1;
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "kva1";
	var_01 thread kva_show_timer();
	thread maps\_anim::anim_single_solo(var_01,"sentinel_kva_reveal");
	var_01 setcontents(0);
	thread maps\detroit_lighting::sentinel_reveal_lighting_origins(var_01);
	wait(10);
	var_02 = [var_01];
	maps\_anim::anim_set_rate(var_02,"sentinel_kva_reveal",0);
	var_01.ignoreme = 1;
	var_01.ignoresonicaoe = 1;
	var_01 maps\_utility::pretend_to_be_dead();
}

//Function Number: 40
kva2_sentinel_kva_reveal()
{
	var_00 = getent("kva_reveal_spawner2","targetname");
	var_00.count = 1;
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "kva2";
	var_01 thread kva_show_timer();
	thread maps\_anim::anim_single_solo(var_01,"sentinel_kva_reveal");
	var_01 setcontents(0);
	thread maps\detroit_lighting::sentinel_reveal_lighting_origins(var_01);
	wait(10);
	var_02 = [var_01];
	maps\_anim::anim_set_rate(var_02,"sentinel_kva_reveal",0);
	var_01.ignoreme = 1;
	var_01.ignoresonicaoe = 1;
	var_01 maps\_utility::pretend_to_be_dead();
}

//Function Number: 41
kva3_sentinel_kva_reveal()
{
	var_00 = getent("kva_reveal_spawner3","targetname");
	var_00.count = 1;
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "kva3";
	var_01 thread kva_show_timer();
	thread maps\_anim::anim_single_solo(var_01,"sentinel_kva_reveal");
	var_01 setcontents(0);
	thread maps\detroit_lighting::sentinel_reveal_lighting_origins(var_01);
	wait(10);
	var_02 = [var_01];
	maps\_anim::anim_set_rate(var_02,"sentinel_kva_reveal",0);
	var_01.ignoreme = 1;
	var_01.ignoresonicaoe = 1;
	var_01 maps\_utility::pretend_to_be_dead();
}

//Function Number: 42
player_sentinel_kva_reveal()
{
	var_00 = getent("kva_sentinel_squad_reveal_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("world_body");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"sentinel_kva_reveal");
	var_01 hide();
	maps\_utility::trigger_wait_targetname("sentinel_reveal_moment_trigger");
	thread maps\detroit_school::gideon_keep_up_fail_trigger("player_escaping_animation_sentreveal_beforestairs");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	common_scripts\utility::flag_set("burke_180_loop_end");
	thread maps\detroit::battle_chatter_off_both();
	thread maps\detroit::hud_off();
	common_scripts\utility::flag_set("obj_escape_detroit_pos_sentinel_reveal");
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player thread maps\_player_exo::player_exo_deactivate();
	var_02 = 0.01;
	level.player playerlinktoblend(var_01,"tag_player",var_02);
	level.player common_scripts\utility::delaycall(var_02,::playerlinktodelta,var_01,"tag_player",1,0,0,0,0,1);
	var_01 common_scripts\utility::delaycall(var_02,::show);
	var_01 thread view_clamping_unlock();
	if(level.currentgen)
	{
		var_00.origin = var_00.origin + (0,0,1.5);
	}

	var_00 thread maps\_anim::anim_single_solo(var_01,"sentinel_kva_reveal");
	wait(37);
	var_03 = level.player common_scripts\utility::spawn_tag_origin();
	var_03.origin = var_03.origin + (0,0,0.268);
	level.player maps\_utility::teleport_player(var_03);
	level.player unlink();
	var_01 delete();
	common_scripts\utility::flag_set("obj_escape_detroit_pos_exit_stairs");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player thread maps\_player_exo::player_exo_activate();
	thread maps\detroit::hud_on();
	common_scripts\utility::flag_set("send_joker_and_doctor_to_bikes");
}

//Function Number: 43
wait_for_trigger_set_flag()
{
	maps\_utility::trigger_wait_targetname("joker_pick_up_doctor");
	common_scripts\utility::flag_set("joker_pickup_doctor_is_ok_now");
}

//Function Number: 44
view_clamping_unlock()
{
	wait(8);
	level.player playerlinktodelta(self,"tag_player",1,20,20,20,20,1);
}

//Function Number: 45
decloak_wait_1()
{
	common_scripts\utility::flag_wait("sentinel_reveal_guy1_decloak");
	wait(1.9);
	thread cloak_off();
	thread set_helmet_open(3,2.45);
	soundscripts\_snd::snd_message("sent_guy_1_decloak");
	maps\_utility::gun_remove();
	maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	wait(5.2);
	common_scripts\utility::flag_wait("sentinel_recloak");
	wait(2.9);
	thread set_helmet_closed(1.25,1.1);
	wait(1.5);
	wait(1.5);
	cloak_on();
}

//Function Number: 46
decloak_wait_2()
{
	common_scripts\utility::flag_wait("sentinel_reveal_guy2_decloak");
	thread cloak_off();
	soundscripts\_snd::snd_message("sent_guy_2_decloak");
	common_scripts\utility::flag_wait("sentinel_recloak");
	wait(1.2);
	cloak_on();
}

//Function Number: 47
decloak_wait_3()
{
	common_scripts\utility::flag_wait("sentinel_reveal_guy3_decloak");
	thread cloak_off();
	soundscripts\_snd::snd_message("sent_guy_3_decloak");
	common_scripts\utility::flag_wait("sentinel_recloak");
	wait(1.7);
	cloak_on();
}

//Function Number: 48
unhide_me_on_flag(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	wait(randomfloatrange(0.2,0.6));
	self show();
}

//Function Number: 49
guy1_sentinel_kva_reveal()
{
	var_00 = getnode("sentinel_cover_4","targetname");
	var_01 = getent("sentinel_revealed_spawner3","targetname");
	var_01.count = 1;
	level.sentinel_guy1 = var_01 maps\_utility::spawn_ai(1);
	level.sentinel_guy1 thread unhide_me_on_flag("show_sentinel_guys_now");
	level.sentinel_guy1 maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	level.sentinel_guy1 thread decloak_wait_1();
	level.sentinel_guy1 overridematerial("mtl_burke_sentinel_covert_headgear_a","mc/mtl_burke_sentinel_covert_headgear_a_cloak");
	level.sentinel_guy1 assign_cloak_model("sentinel_covert_body_a");
	level.sentinel_guy1 cloak_on();
	level.sentinel_guy1 maps\_utility::magic_bullet_shield();
	level.sentinel_guy1.ignoreall = 1;
	level.sentinel_guy1.ignoreme = 1;
	level.sentinel_guy1.animname = "guy1";
	maps\_anim::anim_single_solo(level.sentinel_guy1,"sentinel_kva_reveal");
	thread maps\_anim::anim_loop_solo(level.sentinel_guy1,"sentinel_kva_reveal_idle");
	level waittill("cleanup_sentinel_guys");
	level.sentinel_guy1 maps\_utility::stop_magic_bullet_shield();
	level.sentinel_guy1 delete();
}

//Function Number: 50
guy2_sentinel_kva_reveal()
{
	var_00 = getnode("sentinel_cover_1","targetname");
	var_01 = getent("sentinel_revealed_spawner2","targetname");
	var_01.count = 1;
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02 thread unhide_me_on_flag("show_sentinel_guys_now");
	var_02 maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	var_02 thread decloak_wait_2();
	var_02 overridematerial("mtl_burke_sentinel_covert_headgear_a","mc/mtl_burke_sentinel_covert_headgear_a_cloak");
	var_02 assign_cloak_model("body_hero_burke_sentinel_covert_cloak");
	var_02 cloak_on();
	var_02 maps\_utility::magic_bullet_shield();
	var_02.ignoreall = 1;
	var_02.ignoreme = 1;
	var_02.animname = "guy2";
	maps\_anim::anim_single_solo(var_02,"sentinel_kva_reveal");
	thread maps\_anim::anim_loop_solo(var_02,"sentinel_kva_reveal_idle");
	level waittill("cleanup_sentinel_guys");
	var_02 maps\_utility::stop_magic_bullet_shield();
	var_02 delete();
}

//Function Number: 51
guy3_sentinel_kva_reveal()
{
	var_00 = getnode("sentinel_cover_3","targetname");
	var_01 = getent("sentinel_revealed_spawner1","targetname");
	var_01.count = 1;
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02 thread unhide_me_on_flag("show_sentinel_guys_now");
	var_02 maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	var_02 thread decloak_wait_3();
	var_02 overridematerial("mtl_burke_sentinel_covert_headgear_a","mc/mtl_burke_sentinel_covert_headgear_a_cloak");
	var_02 assign_cloak_model("body_hero_burke_sentinel_covert_cloak");
	var_02 cloak_on();
	var_02 maps\_utility::magic_bullet_shield();
	var_02.ignoreall = 1;
	var_02.ignoreme = 1;
	var_02.animname = "guy3";
	maps\_anim::anim_single_solo(var_02,"sentinel_kva_reveal");
	thread maps\_anim::anim_loop_solo(var_02,"sentinel_kva_reveal_idle");
	maps\_utility::battlechatter_on("axis");
	level waittill("cleanup_sentinel_guys");
	var_02 maps\_utility::stop_magic_bullet_shield();
	var_02 delete();
}

//Function Number: 52
reverse_cloak()
{
	common_scripts\utility::flag_wait("decloak");
}

//Function Number: 53
temporary_sentinel_reveal_timing()
{
	wait(8.87);
	common_scripts\utility::flag_set("vo_sentinel_reveal");
}

//Function Number: 54
kva_ambush_last_group_reveal()
{
	var_00 = getentarray("sentinel_fight_kva_spawner","targetname");
	common_scripts\utility::flag_wait("begin_kva_assault_on_sentinel");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03.accuracy = 0;
		var_03.goalradius = 15;
		var_03 thread maps\_utility::set_grenadeammo(0);
		var_03 thread kill_me_on_sentrev_cleanup();
	}

	maps\_utility::trigger_wait_targetname("bikes_reached");
	if(level.currentgen)
	{
		level.burke_bike show();
		level.joker_bike show();
		level.bones_bike show();
		if(isdefined(level.player_bike))
		{
			level.player_bike show();
		}
	}

	var_05 = getent("player_backtracking_sentinel_warning_vol","targetname");
	common_scripts\utility::flag_set("vo_exit_drive_bikes_reached");
	level notify("cleanup_sentinel_guys");
	var_06 = getent("player_trying_to_exit_garage_warning","targetname");
	thread maps\detroit_school::player_exiting();
	thread mission_fail_warning(var_06);
}

//Function Number: 55
mission_fail_warning(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		level endon("ok_to_stop_sentinel_reveal_warnings");
	}

	level.player endon("death");
	for(;;)
	{
		if(level.player istouching(param_00))
		{
			maps\_utility::hint(&"DETROIT_LEAVING_MISSION",3);
			wait(8);
		}

		wait(0.05);
	}
}

//Function Number: 56
kill_me_on_sentrev_cleanup()
{
	level waittill("cleanup_sentinel_guys");
	wait(randomfloatrange(0.25,0.8));
	if(isdefined(self))
	{
		self kill();
	}
}

//Function Number: 57
cloak_again()
{
	wait(21);
	wait(randomfloatrange(3,8));
	if(isdefined(self))
	{
		cloak_on();
	}
}

//Function Number: 58
run_train_with_shaking(param_00,param_01,param_02,param_03)
{
	var_04 = 650;
	var_05 = 3;
	if(!isdefined(param_03))
	{
		var_06 = "vehicle_civ_det_train_car_01";
		param_03 = spawn("script_model",param_00.origin);
		param_03 setmodel(var_06);
		param_03 thread maps\detroit_exit_drive::run_train_shaker(var_04,var_05);
	}

	var_07 = common_scripts\utility::spawn_tag_origin();
	var_07 linkto(param_03,"",(300,0,80),(25,0,0));
	var_08 = common_scripts\utility::spawn_tag_origin();
	var_08 linkto(param_03,"",(300,0,80),(0,0,0));
	var_09 = common_scripts\utility::spawn_tag_origin();
	var_09 linkto(param_03,"",(200,0,15),(0,90,0));
	thread maps\detroit_lighting::train_lighting(var_07,var_08,var_09);
	if(!isdefined(param_03.tags))
	{
		param_03.tags = [];
	}

	param_03.tags[param_03.tags.size] = var_07;
	param_03.tags[param_03.tags.size] = var_08;
	param_03.tags[param_03.tags.size] = var_09;
	param_03.origin = param_00.origin;
	param_03.angles = param_00.angles;
	param_01 = sortbydistance(param_01,param_00.origin);
	param_03 thread maps\detroit_streets::train_gopath(param_01,param_02);
	return param_03;
}

//Function Number: 59
delay_linkto_anim()
{
	level.player common_scripts\utility::delaycall(10.94,::playerlinktodelta,self,"tag_player",15,15,15,15,0,1);
}

//Function Number: 60
mission_fail_on_dead()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage");
		if(isdefined(self.lastattacker) && self.lastattacker == level.player)
		{
			maps\_player_death::set_deadquote(&"DETROIT_DOCTOR_DEAD");
			maps\_utility::missionfailedwrapper();
			common_scripts\utility::flag_set("doctor_can_be_killed_now");
		}

		wait(0.05);
	}
}

//Function Number: 61
passoja_death_wait_function()
{
	self endon("death");
	level endon("doctor_cant_die_anymore");
	common_scripts\utility::flag_wait("doctor_can_be_killed_now");
	if(isalive(self))
	{
		maps\_utility::stop_magic_bullet_shield();
		self stopanimscripted();
		doimmediateragdolldeath();
	}
}

//Function Number: 62
doimmediateragdolldeath()
{
	animscripts\shared::dropallaiweapons();
	self.skipdeathanim = 1;
	var_00 = 10;
	var_01 = common_scripts\_destructible::getdamagetype(self.damagemod);
	if(isdefined(self.attacker) && self.attacker == level.player && var_01 == "melee")
	{
		var_00 = 5;
	}

	var_02 = self.damagetaken;
	if(var_01 == "bullet")
	{
		var_02 = max(var_02,300);
	}

	var_03 = var_00 * var_02;
	var_04 = max(0.3,self.damagedir[2]);
	var_05 = (self.damagedir[0],self.damagedir[1],var_04);
	if(isdefined(self.ragdoll_directionscale))
	{
		var_05 = var_05 * self.ragdoll_directionscale;
	}
	else
	{
		var_05 = var_05 * var_03;
	}

	if(self.forceragdollimmediate)
	{
		var_05 = var_05 + self.prevanimdelta * 20 * 10;
	}

	if(isdefined(self.ragdoll_start_vel))
	{
		var_05 = var_05 + self.ragdoll_start_vel * 10;
	}

	self startragdollfromimpact(self.damagelocation,var_05);
	wait(0.05);
}

//Function Number: 63
doctor_capture_dialogue()
{
	level waittill("can_takedown_doctor");
	common_scripts\utility::flag_set("vo_hospital_capture");
}

//Function Number: 64
doctor_capture_check_takedown()
{
	level endon("can_takedown_doctor");
	for(;;)
	{
		if(level.guys_to_wait == 3)
		{
			wait(2);
			level notify("can_takedown_doctor");
			common_scripts\utility::flag_set("show_grab_doctor_prompt");
		}

		wait(0.1);
	}
}

//Function Number: 65
doctor_capture_breach_door_prompt()
{
	var_00 = getent("kickdown","targetname") maps\_shg_utility::hint_button_trigger("use",200);
	maps\_utility::trigger_wait_targetname("kickdown");
	var_00 maps\_shg_utility::hint_button_clear();
}

//Function Number: 66
doctor_capture_new_breach_doctor_takedown()
{
	thread doctor_capture_stop_spawning_school_trains();
	var_00 = getent("breach_clip","targetname");
	var_01 = getent("hospital_outside_clip","targetname");
	var_02 = getent("dr_capture_pcap_animnode","targetname");
	var_03 = getent("dr_carry_animnode","targetname");
	var_04 = getent("dr_pickup_placed_org","targetname");
	var_05 = getnode("burke_first_wait_after_capture_node","targetname");
	var_06 = getent("kickdown","targetname");
	var_06 usetriggerrequirelookat();
	var_06 sethintstring(&"DETROIT_PROMPT_BREACH");
	var_06 waittill("trigger");
	thread breach_backtrack_fail();
	objective_position(maps\_utility::obj("Capture the doctor"),(0,0,0));
	maps\_player_exo::player_exo_deactivate();
	common_scripts\utility::flag_set("doctor_inside_office_now");
	level notify("player breached and survived");
	thread maps\detroit::battle_chatter_off_both();
	var_06 delete();
	maps\detroit::spawn_doctor();
	level.doctor thread mission_fail_on_dead();
	level.doctor thread passoja_death_wait_function();
	thread doctor_capture_player_breach();
	var_07 = getent("breach_kva_guard1","targetname");
	var_08 = getent("breach_kva_guard2","targetname");
	var_09 = getent("breach_kva_guard3","targetname");
	var_0A = [];
	var_0A[var_0A.size] = var_07 maps\_utility::spawn_ai(1);
	var_0A[var_0A.size] = var_08 maps\_utility::spawn_ai(1);
	var_0A[var_0A.size] = var_09 maps\_utility::spawn_ai(1);
	level.guys_to_wait = 0;
	thread doctor_capture_check_takedown();
	var_0A[0] thread doctor_capture_firstguy_breach();
	var_0A[1] thread doctor_capture_thirdguy_breach();
	var_0A[1] thread doctor_capture_thirdguy_notify_when_dead();
	var_0A[2] thread doctor_capture_forthguy_breach();
	thread doctor_capture_doctor_breach();
	thread doctor_capture_bookshelf1();
	thread doctor_capture_bookshelf2();
	soundscripts\_snd::snd_message("hospital_breach_gun_away");
	level waittill("breach_begin");
	thread maps\detroit_lighting::hospital_breach_dof();
	soundscripts\_snd::snd_message("hostpital_breach_start");
	thread doctor_capture_bones_breach_functionality();
	var_00 delete();
	var_01 delete();
	level waittill("can_takedown_doctor");
	var_0B = getent("dr_capture_use_trigger","targetname");
	level.doctor thread doctor_capture_doctor_takedown_xprompt(var_0B);
	objective_setpointertextoverride(maps\_utility::obj("Capture the doctor"),&"OBJECTIVE_CAPTURE");
	common_scripts\utility::flag_set("obj_capture_doctor_pos_doctor_breached");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	var_0B sethintstring(&"DETROIT_DOCTOR_GRAB");
	var_0B waittill("trigger");
	common_scripts\utility::flag_set("doctor_grabbed");
	maps\_player_exo::player_exo_deactivate();
	thread clear_doctor_head();
	thread maps\detroit_streets::sneaky_reload();
	level notify("begin_takedown_animation");
	var_0B delete();
	var_0C = maps\_utility::spawn_anim_model("world_body");
	var_0C hide();
	var_02 thread maps\_anim::anim_first_frame_solo(var_0C,"doctor_capture");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_0D = 0.3;
	var_0C hide();
	level.player playerlinktoblend(var_0C,"tag_player",var_0D,var_0D * 0.5,var_0D * 0.5);
	level.player common_scripts\utility::delaycall(var_0D,::playerlinktodelta,var_0C,"tag_player",0,0,0,0,0,1);
	level.player common_scripts\utility::delaycall(var_0D,::enableslowaim);
	var_0C common_scripts\utility::delaycall(var_0D,::show);
	thread maps\detroit_lighting::capture_lighting();
	common_scripts\utility::flag_set("player_captured_doctor");
	thread wait_for_trigger_set_flag();
	soundscripts\_snd::snd_message("capture_doctor_scene_start");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"obj_capture_doctor_complete");
	level.doctor thread doctor_capture_doctor_head_swap_function();
	var_02 notify("stop_doctor_loop");
	var_0C thread doctor_capture_player_capture_thread();
	var_0E = maps\_utility::spawn_anim_model("capture_bag");
	var_0E hide();
	var_02 thread doctor_capture_bag_capture_anim(var_0E);
	level.burke stopanimscripted();
	level notify("kill_burke_loop");
	var_02 notify("no_more_door_looping_burke");
	var_0F = [level.joker,level.doctor];
	thread doctor_blood_swap();
	var_02 thread maps\_anim::anim_single_solo(level.burke,"doctor_capture");
	thread doctor_capture_set_new_objective_outside_breach();
	level.burke setgoalnode(var_05);
	var_02 thread maps\_anim::anim_single_solo(var_0E,"doctor_capture");
	var_02 thread maps\_anim::anim_single(var_0F,"doctor_capture");
	wait(24);
	level.player enableweapons();
	wait(6);
	level.doctor setanimrate(level.doctor maps\_utility::getanim("doctor_capture"),0);
	common_scripts\utility::flag_set("capture_animation_complete");
	common_scripts\utility::flag_set("obj_escape_detroit_give");
	level.burke maps\_utility::set_moveplaybackrate(1);
	if(isalive(level.doctor))
	{
		thread maps\_utility::autosave_by_name("seeker");
	}

	var_10 = getnode("joker_with_doctor_waitnode","targetname");
	thread doctor_carry_wait_breach(var_02,"reveal_the_sentinels",var_10);
	common_scripts\utility::flag_set("swap_to_head_bagged");
	var_0E delete();
	thread escape_hospital_trains();
}

//Function Number: 67
doctor_capture_set_new_objective_outside_breach()
{
	wait(26.3);
	common_scripts\utility::flag_set("obj_escape_detroit_give");
}

//Function Number: 68
doctor_capture_doctor_takedown_xprompt(param_00)
{
	var_01 = maps\_shg_utility::hint_button_tag("x","j_spine4",128,200,undefined,param_00);
	level waittill("begin_takedown_animation");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 69
doctor_capture_stop_spawning_school_trains()
{
	maps\_utility::disable_trigger_with_targetname("no_more_trains_trigger");
	common_scripts\utility::flag_wait("player_captured_doctor");
	maps\_utility::enable_trigger_with_targetname("no_more_trains_trigger");
	common_scripts\utility::flag_wait("no_more_trains");
	common_scripts\utility::flag_set("hospital_escape_trains_only");
}

//Function Number: 70
doctor_blood_swap()
{
	wait(5.12);
	level.doctor overridematerial("mtl_dr_pas_head","mtl_dr_pas_head_damaged");
	level.doctor maps\_utility::dialogue_queue("det_dcr_painreaction");
}

//Function Number: 71
doctor_capture_hospital_breach_autosave()
{
	maps\_utility::trigger_wait_targetname("hospital_breach_autosave");
	maps\_utility::disable_trigger_with_targetname("hospital_breach_autosave");
}

//Function Number: 72
doctor_capture_xprompt()
{
	common_scripts\utility::flag_wait("show_grab_doctor_prompt");
	var_00 = getent("dr_pickup_placed_prompt","targetname") maps\_shg_utility::hint_button_trigger("use",200);
	level waittill("begin_takedown_animation");
	var_00 maps\_shg_utility::hint_button_clear();
}

//Function Number: 73
doctor_capture_bag_capture_anim(param_00)
{
	common_scripts\utility::flag_wait("show_capture_bag");
	param_00 show();
}

//Function Number: 74
doctor_capture_doctor_head_swap_function()
{
	common_scripts\utility::flag_wait("swap_to_head_bagged");
	self detach("dr_pas_head");
	self attach("det_doctor_head_bagA");
}

//Function Number: 75
doctor_capture_player_capture_thread()
{
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_00 thread maps\_anim::anim_single_solo(self,"doctor_capture");
	wait(0.8);
	maps\detroit::controller_rumble_heavy0();
	wait(0.22);
	maps\detroit::controller_rumble_light1();
	wait(1);
	maps\detroit::controller_rumble_heavy0();
	wait(3.05);
	maps\detroit::controller_rumble_light1();
	wait(13.25);
	maps\detroit::controller_rumble_heavy0();
	wait(5.25);
	level.player unlink();
	level.player disableslowaim();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	level notify("doctor_cant_die_anymore");
	self delete();
}

//Function Number: 76
doctor_carry_wait_breach(param_00,param_01,param_02)
{
	param_00 thread maps\_anim::anim_loop_solo(level.joker,"doctor_capture_idle");
	common_scripts\utility::flag_wait("joker_pickup_doctor_is_ok_now");
	level notify("pick_up_doctor_move_on");
	wait(2.3);
	param_00 notify("stop_loop");
	thread doctor_capture_doctor_carry(param_00,param_01,param_02);
}

//Function Number: 77
keep_stair_override(param_00)
{
	while(!common_scripts\utility::flag(param_00))
	{
		if(isdefined(self.a.moveanimset))
		{
			self.a.moveanimset["stairs_up"] = level.scr_anim[self.animname]["carry_doc_upstairs_loop"];
			self.a.moveanimset["stairs_down"] = level.scr_anim[self.animname]["carry_doc_downstairs_loop"];
			self.a.moveanimset["stairs_down_out"] = self.a.moveanimset["stairs_down"];
			self.a.moveanimset["stairs_up_out"] = self.a.moveanimset["stairs_up"];
			self.a.moveanimset["stairs_down_in"] = self.a.moveanimset["stairs_down"];
			self.a.moveanimset["stairs_up_in"] = self.a.moveanimset["stairs_up"];
		}

		wait 0.05;
	}
}

//Function Number: 78
doctor_capture_doctor_carry(param_00,param_01,param_02)
{
	if(isai(level.doctor))
	{
		level.doctor setcontents(0);
		level.doctor notify("killanimscript");
		level.doctor maps\_utility::disable_pain();
		level.doctor maps\_utility::disable_bulletwhizbyreaction();
		level.doctor maps\_utility::disable_danger_react();
		level.doctor notify("internal_stop_magic_bullet_shield");
		level.doctor notify("death");
		level.doctor stop_current_animations(param_00);
		var_03 = spawn("script_model",level.doctor.origin);
		var_03.angles = level.doctor.angles;
		var_04 = level.doctor.animname;
		var_03.animname = var_04;
		var_03 useanimtree(#animtree);
		var_03 setmodel(level.doctor getmodelfromentity(),0);
		var_03 attach("det_doctor_head_bagA");
		var_03.name = "scriptmodelDoc";
		var_03 setcandamage(1);
		var_03.health = 100;
		var_03 thread mission_fail_on_dead();
		var_03 setlookattext("Doctor",&"");
		level.doctor delete();
		level.doctor = var_03;
	}

	level.joker stop_current_animations(param_00);
	param_00 maps\_anim::anim_single([level.joker,level.doctor],"carry_doc_lift");
	param_00 maps\_anim::anim_first_frame_solo(level.doctor,"carry_doc_stop");
	level.joker maps\_utility::ai_ignore_everything();
	level.joker pushplayer(1);
	level.joker maps\_utility::disable_turnanims();
	level.joker.run_overrideanim_hasstairanimarray = 1;
	level.joker.disablearrivals = 1;
	level.joker.disableexits = 1;
	level.joker.run_overrideanim = level.scr_anim[level.joker.animname]["carry_doc_walk"];
	level.joker.walk_overrideanim = level.scr_anim[level.joker.animname]["carry_doc_walk"];
	level.joker.specialidleanim = [level.scr_anim[level.joker.animname]["carry_doc_stop"]];
	level.joker allowedstances("stand");
	level.joker animmode("gravity");
	level.joker orientmode("face default");
	level.joker thread keep_stair_override(param_01);
	level.doctor setanimknob(level.scr_anim[level.doctor.animname]["carry_doc_stop"],1,0,0);
	level.doctor setanimtime(level.scr_anim[level.doctor.animname]["carry_doc_stop"],0);
	level.doctor linkto(level.joker,"j_spine4",(0,0,0),(0,0,0));
	level.doctor dontinterpolate();
	level.doctor thread sync_anim_times_with_carrier(level.joker,param_01);
	level.joker setgoalnode(param_02);
	common_scripts\utility::flag_wait(param_01);
	level.doctor unlink();
	level.joker maps\_utility::ai_unignore_everything();
	level.joker pushplayer(0);
	level.joker maps\_utility::enable_turnanims();
	level.joker allowedstances("stand","crouch","prone");
	level.joker.run_overrideanim_hasstairanimarray = undefined;
	level.joker.disablearrivals = undefined;
	level.joker.disableexits = undefined;
	level.joker.run_overrideanim = undefined;
	level.joker.walk_overrideanim = undefined;
	level.joker.specialidleanim = undefined;
}

//Function Number: 79
clear_doctor_head()
{
	level.doctor clearanim(%head,0.1);
}

//Function Number: 80
doctor_capture_bones_breach_functionality()
{
	var_00 = getnode("bones_guard_capture_node","targetname");
	var_01 = getnode("bones_guard_doctor_node","targetname");
	var_02 = getnode("bones_guard_bikes_node","targetname");
	level.bones setgoalnode(var_00);
	common_scripts\utility::flag_wait("capture_animation_complete");
	level.bones setgoalnode(var_01);
	common_scripts\utility::flag_wait("sentinel_reveal_animation_complete");
	level.bones setgoalnode(var_02);
}

//Function Number: 81
doctor_capture_bookshelf1()
{
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("shelf");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"det_hos_breach_success_shelf01");
	var_02 = getent("det_hos_breach_shelf_01","targetname");
	var_02 hide();
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles + (0,90,0);
	var_02 linkto(var_01,"TAG_ORIGIN");
	level waittill("begin_second_half_of_breach");
	var_00 maps\_anim::anim_single_solo(var_01,"det_hos_breach_success_shelf01");
	common_scripts\utility::flag_wait("player_captured_doctor");
	wait(1.25);
	var_02 show();
	var_01 delete();
}

//Function Number: 82
doctor_capture_bookshelf2()
{
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("shelf");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"det_hos_breach_success_shelf02");
	var_02 = getent("det_hos_breach_shelf_02","targetname");
	var_02 hide();
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles + (0,90,0);
	var_02 linkto(var_01,"TAG_ORIGIN");
	level waittill("begin_second_half_of_breach");
	var_00 maps\_anim::anim_single_solo(var_01,"det_hos_breach_success_shelf02");
	common_scripts\utility::flag_wait("player_captured_doctor");
	wait(1.25);
	var_02 show();
	var_01 delete();
}

//Function Number: 83
doctor_capture_lerp_wait_function(param_00)
{
	wait(param_00);
	iprintlnbold("this is the right slowmo function");
	maps\_utility::slowmo_lerp_in();
}

//Function Number: 84
doctor_capture_door_breach_anim()
{
	if(level.currentgen)
	{
		if(!istransientloaded("detroit_hospital_interior_tr"))
		{
			for(;;)
			{
				wait(0.25);
				if(istransientloaded("detroit_hospital_interior_tr"))
				{
					break;
				}
			}
		}
	}

	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("hospital_door");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"hospital_breach");
	wait(0.05);
	var_02 = getent("reflection_green","targetname");
	var_01 overridereflectionprobe(var_02.origin);
	var_01 overridelightingorigin(var_02.origin);
	level waittill("breach_begin");
	var_00 maps\_anim::anim_single_solo(var_01,"hospital_breach");
}

//Function Number: 85
doctor_capture_player_breach()
{
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("world_body",level.player.origin);
	var_01.animname = "world_body";
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"det_hos_breach_vm");
	var_01 hide();
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,100);
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_02 = 0.3;
	var_01 hide();
	level.player playerlinktoblend(var_01,"tag_player",var_02,var_02 * 0.5,var_02 * 0.5);
	wait(var_02);
	var_01 show();
	level.player playerlinktodelta(var_01,"tag_player",0,0,0,0,0,1);
	thread doctor_capture_burke_enter_doctor_room();
	thread doctor_capture_burke_takedown_finish();
	level notify("breach_begin");
	thread maps\detroit_streets::sneaky_reload();
	var_00 maps\_anim::anim_single_solo(var_01,"det_hos_breach_vm");
	if(common_scripts\utility::flag("qte_success_breach"))
	{
		soundscripts\_snd::snd_message("player_exo_breach_begin");
		thread maps\_utility::slowmo_lerp_out();
		var_00 thread maps\_anim::anim_single_solo(var_01,"det_hos_breach_fail_vm");
		wait(3);
		var_01 setanimrate(var_01 maps\_utility::getanim("det_hos_breach_fail_vm"),0);
		return;
	}

	soundscripts\_snd::snd_message("push_dude_into_shelves");
	var_00 maps\_anim::anim_single_solo(var_01,"det_hos_breach_success_vm");
	level.player unlink();
	var_01 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	wait(2);
	maps\_utility::slowmo_lerp_out();
	soundscripts\_snd::snd_message("breach_slo_mo_exit");
	maps\_player_exo::player_exo_activate();
}

//Function Number: 86
doctor_capture_burke_enter_doctor_room()
{
	level endon("begin_takedown_animation");
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_01 = "det_hos_breach_burke";
	var_02 = getanimlength(level.burke maps\_utility::getanim(var_01));
	var_03 = 3;
	wait(var_03);
	thread doctor_capture_burke_shooting();
	var_00 thread maps\_anim::anim_single_solo(level.burke,var_01);
	wait(0.05);
	level.burke setanimtime(level.burke maps\_utility::getanim(var_01),var_03 + 0.05 / var_02);
	wait(var_02 - var_03);
	doctor_capture_burke_alternate_point_anim();
}

//Function Number: 87
doctor_capture_burke_alternate_point_anim()
{
	level endon("begin_takedown_animation");
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	common_scripts\utility::flag_set("grab_the_doctor");
	doctor_capture_burke_doctorroom_idle();
}

//Function Number: 88
doctor_capture_burke_doctorroom_idle()
{
	level endon("begin_takedown_animation");
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"doctor_capture_idle","stop_burke_idling_before_capture");
}

//Function Number: 89
doctor_capture_burke_takedown_finish()
{
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	common_scripts\utility::flag_wait("player_captured_doctor");
	var_00 notify("stop_burke_idling_before_capture");
	level.burke notify("stop_burke_idling_before_capture");
	thread burke_pre_sentinel_kva_reveal();
}

//Function Number: 90
doctor_capture_burke_shooting()
{
	wait(5);
	if(!common_scripts\utility::flag("player_captured_doctor"))
	{
		level notify("burke_shoot_1");
	}

	wait(1.25);
	if(!common_scripts\utility::flag("player_captured_doctor"))
	{
		level notify("burke_shoot_2");
	}
}

//Function Number: 91
doctor_capture_doctor_breach()
{
	wait 0.05;
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	level waittill("breach_begin");
	var_00 maps\_anim::anim_single_solo(level.doctor,"det_hos_breach_doctor");
	var_00 thread maps\_anim::anim_loop_solo(level.doctor,"det_hos_breach_idle_doctor","stop_doctor_loop");
}

//Function Number: 92
doctor_capture_shoot_the_player()
{
	self endon("death");
	self endon("stop_shooting");
	for(;;)
	{
		wait(randomfloatrange(0.25,1));
		if(isalive(self))
		{
			magicbullet("iw5_bal27_sp",self gettagorigin("tag_flash"),level.player.origin);
			continue;
		}
	}
}

//Function Number: 93
breach_backtrack_fail()
{
	var_00 = getent("backtrack_warning_breach","targetname");
	thread mission_fail_warning(var_00);
	thread player_exit_breach_fail();
}

//Function Number: 94
player_exit_breach_fail()
{
	level endon("player_progressed_to_exit_drive");
	maps\_utility::trigger_wait_targetname("backtrack_breach_fail_trigger");
	maps\_player_death::set_deadquote(&"DETROIT_ABANDONED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 95
doctor_capture_firstguy_breach()
{
	self endon("death");
	self.animname = "generic";
	self.ignoreme = 1;
	thread doctor_capture_guy1_health_check_killfunction();
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_00 maps\_anim::anim_first_frame_solo(self,"det_hos_breach_guy1");
	level waittill("breach_begin");
	thread doctor_capture_did_burke_kill_me_1();
	var_00 maps\_anim::anim_single_solo(self,"det_hos_breach_guy1");
	if(isalive(self))
	{
		thread doctor_capture_shoot_the_player();
		self.ignoreme = 0;
		var_00 maps\_anim::anim_loop_solo(self,"det_hos_breach_aim_idle_guy1");
	}
}

//Function Number: 96
doctor_capture_guy1_health_check_killfunction()
{
	var_00 = getent("player_success_hospital_glass_clip","targetname");
	var_00 notsolid();
	var_01 = getglass("player_success_hospital_glass");
	var_02 = 0.2;
	var_03 = getent("dr_capture_pcap_animnode","targetname");
	var_04 = self.health;
	for(;;)
	{
		var_05 = self.health;
		if(var_04 > var_05)
		{
			self notify("stop_shooting");
			level.guys_to_wait = level.guys_to_wait + 1;
			self.allowdeath = 1;
			soundscripts\_snd::snd_message("shoot_dude_through_window");
			self.a.nodeath = 1;
			self.ignoreall = 1;
			self.ignoreme = 1;
			self setcontents(0);
			thread doctor_capture_destroy_this_glass(var_01,var_02);
			var_00 solid();
			var_03 maps\_anim::anim_single_solo(self,"det_hos_breach_success_guy1");
			self delete();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 97
doctor_capture_destroy_this_glass(param_00,param_01)
{
	wait(param_01);
	if(isdefined(param_00))
	{
		destroyglass(param_00);
	}
}

//Function Number: 98
doctor_capture_thirdguy_notify_when_dead()
{
	self waittill("death");
	self stopanimscripted();
}

//Function Number: 99
doctor_capture_guy3_health_check_killfunction()
{
	var_00 = getent("guy3_death_animnode","targetname");
	var_01 = self.health;
	for(;;)
	{
		if(var_01 > self.health)
		{
			self notify("stop_shooting");
			level.guys_to_wait = level.guys_to_wait + 1;
			soundscripts\_snd::snd_message("breach_bad_guy2_gets_shot");
			self.a.nodeath = 1;
			self.ignoreall = 1;
			self.ignoreme = 1;
			var_00 maps\_anim::anim_single_solo(self,"det_hos_breach_success_guy3");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 100
doctor_capture_thirdguy_breach()
{
	self endon("death");
	self.ignoreme = 1;
	self.animname = "generic";
	thread doctor_capture_guy3_health_check_killfunction();
	var_00 = getent("guy3_death_animnode","targetname");
	var_00 maps\_anim::anim_first_frame_solo(self,"det_hos_breach_guy3");
	level waittill("breach_begin");
	thread doctor_capture_did_burke_kill_me_2();
	thread doctor_capture_guy_3_kill_player();
	var_00 maps\_anim::anim_single_solo(self,"det_hos_breach_guy3");
	if(isalive(self))
	{
		thread doctor_capture_shoot_the_player();
		self.ignoreme = 0;
		var_00 thread maps\_anim::anim_loop_solo(self,"det_hos_breach_aim_idle_guy3");
	}
}

//Function Number: 101
doctor_capture_guy_3_kill_player()
{
	var_00 = self.health;
	wait(6.5);
	if(var_00 == self.health)
	{
		magicbullet("iw5_bal27_sp",self geteye(),level.player geteye());
		level.player kill();
		maps\_player_death::set_deadquote(&"DETROIT_QTE_FAIL");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 102
doctor_capture_did_burke_kill_me_2()
{
	level waittill("burke_shoot_2");
	if(isalive(self))
	{
		var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
		wait(0.02);
		if(isalive(self))
		{
			var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
		}

		var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
		var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
	}
}

//Function Number: 103
doctor_capture_did_burke_kill_me_1()
{
	level waittill("burke_shoot_1");
	if(isalive(self))
	{
		var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
		var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
		wait(0.02);
		if(isalive(self))
		{
			var_00 = magicbullet("iw5_bal27_sp",level.burke gettagorigin("tag_flash"),self gettagorigin("tag_eye"));
		}
	}
}

//Function Number: 104
doctor_capture_forthguy_breach()
{
	common_scripts\utility::flag_set("qte_success_breach");
	self endon("death");
	self.animname = "generic";
	self.ignoreme = 1;
	var_00 = getent("dr_capture_pcap_animnode","targetname");
	var_00 maps\_anim::anim_first_frame_solo(self,"det_hos_breach_guy4");
	level waittill("breach_begin");
	thread doctor_capture_success_trigger();
	var_00 maps\_anim::anim_single_solo(self,"det_hos_breach_guy4");
	if(common_scripts\utility::flag("qte_success_breach"))
	{
		var_00 thread maps\_anim::anim_single_solo(self,"det_hos_breach_fail_guy4");
		wait(2.25);
		self setanimrate(maps\_utility::getanim("det_hos_breach_fail_guy4"),0);
		return;
	}

	level.guys_to_wait = level.guys_to_wait + 1;
	self.allowdeath = 1;
	self.a.nodeath = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
	common_scripts\utility::delaycall(3,::kill);
	level notify("begin_second_half_of_breach");
	var_00 maps\_anim::anim_single_solo(self,"det_hos_breach_success_guy4");
	var_00 maps\_anim::anim_last_frame_solo(self,"det_hos_breach_success_guy4");
}

//Function Number: 105
doctor_capture_success_trigger()
{
	level.player endon("death");
	level.player endon("success");
	wait(1.95);
	thread doctor_capture_use_hint_blinks_melee();
	var_00 = 0;
	while(var_00 < 2)
	{
		if(level.player meleebuttonpressed())
		{
			thread fade_out_use_hint(0.1);
			common_scripts\utility::flag_clear("qte_success_breach");
			level.player notify("success");
			return;
		}

		wait(0.05);
		var_00 = var_00 + 0.05;
	}

	thread fade_out_use_hint(0.1);
}

//Function Number: 106
doctor_capture_draw_use_hint()
{
	var_00 = 200;
	var_01 = 0;
	var_02 = level.player maps\_hud_util::createclientfontstring("default",2);
	var_02.x = var_01 * -1;
	var_02.y = var_00;
	var_02.horzalign = "center";
	var_02.alignx = "center";
	var_02 settext(&"DETROIT_FLASH_USE");
	var_03 = [];
	var_03["text"] = var_02;
	level.use_hint = var_03;
}

//Function Number: 107
doctor_capture_draw_use_hint_melee()
{
	var_00 = 200;
	var_01 = 0;
	var_02 = level.player maps\_hud_util::createclientfontstring("default",2);
	var_02.x = var_01 * -1;
	var_02.y = var_00;
	var_02.horzalign = "center";
	var_02.alignx = "center";
	var_02 settext(&"DETROIT_MELEE");
	var_03 = [];
	var_03["text"] = var_02;
	level.use_hint = var_03;
}

//Function Number: 108
doctor_capture_use_hint_blinks_melee(param_00)
{
	level notify("fade_out_use_hint");
	level endon("fade_out_use_hint");
	if(!isdefined(param_00))
	{
		param_00 = 3;
	}

	doctor_capture_draw_use_hint_melee();
	var_01 = 0.1;
	var_02 = 0.2;
	level.use_hint_active = 1;
	foreach(var_04 in level.use_hint)
	{
		var_04 fadeovertime(0.1);
		var_04.alpha = 0.95;
	}

	wait(0.1);
	var_06 = level.use_hint["text"];
	for(;;)
	{
		if(isdefined(level.use_hint["icon"]))
		{
			level.use_hint["icon"].alpha = 0.95;
		}

		var_06 fadeovertime(0.01);
		var_06.alpha = 0.95;
		var_06 changefontscaleovertime(0.01);
		var_06.fontscale = param_00;
		wait(0.1);
		var_06 fadeovertime(var_01);
		var_06.alpha = 0;
		var_06 changefontscaleovertime(var_01);
		var_06.fontscale = 0.25;
		wait(var_02);
		if(!isdefined(level.use_hint_active))
		{
			foreach(var_04 in level.use_hint)
			{
				var_04.alpha = 0;
			}

			return;
		}
	}
}

//Function Number: 109
doctor_capture_inner_fight()
{
	common_scripts\utility::flag_wait("hospital_inner_fight");
	var_00 = getentarray("kva_hospital_ar_special3","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai();
	}
}

//Function Number: 110
escape_hospital_trains()
{
	level endon("no_more_random_trains");
	common_scripts\utility::flag_wait("spawn_escape_train1");
	maps\detroit_school::spawn_right_hospital_train(1500);
	common_scripts\utility::flag_wait("spawn_escape_train2");
	maps\detroit_school::spawn_left_hospital_train(1500);
	for(;;)
	{
		var_00 = randomint(2) + 1;
		if(var_00 == 1)
		{
			maps\detroit_school::spawn_right_hospital_train(1500);
		}
		else if(var_00 == 2)
		{
			maps\detroit_school::spawn_left_hospital_train(1500);
		}

		wait(20);
	}
}

//Function Number: 111
fade_out_use_hint(param_00)
{
	level notify("fade_out_use_hint");
	if(!isdefined(param_00))
	{
		param_00 = 1.5;
	}

	if(!isdefined(level.use_hint))
	{
		doctor_capture_draw_use_hint();
	}

	foreach(var_02 in level.use_hint)
	{
		var_02 fadeovertime(param_00);
		var_02.alpha = 0;
	}

	level.use_hint_active = undefined;
}

//Function Number: 112
use_hint_blinks(param_00)
{
	level notify("fade_out_use_hint");
	level endon("fade_out_use_hint");
	if(!isdefined(param_00))
	{
		param_00 = 3;
	}

	if(!isdefined(level.use_hint))
	{
		doctor_capture_draw_use_hint();
	}

	var_01 = 0.1;
	var_02 = 0.2;
	level.use_hint_active = 1;
	foreach(var_04 in level.use_hint)
	{
		var_04 fadeovertime(0.1);
		var_04.alpha = 0.95;
	}

	wait(0.1);
	var_06 = level.use_hint["text"];
	for(;;)
	{
		if(isdefined(level.use_hint["icon"]))
		{
			level.use_hint["icon"].alpha = 0.95;
		}

		var_06 fadeovertime(0.01);
		var_06.alpha = 0.95;
		var_06 changefontscaleovertime(0.01);
		var_06.fontscale = param_00;
		wait(0.1);
		var_06 fadeovertime(var_01);
		var_06.alpha = 0;
		var_06 changefontscaleovertime(var_01);
		var_06.fontscale = 0.25;
		wait(var_02);
		if(!isdefined(level.use_hint_active))
		{
			foreach(var_04 in level.use_hint)
			{
				var_04.alpha = 0;
			}

			return;
		}
	}
}

//Function Number: 113
joker_advance_hospital()
{
	var_00 = getnode("joker_hospital","targetname");
	var_01 = getnode("joker_cover_inside_hospital","targetname");
	var_02 = getnode("joker_holdup_before_going_upstairs_node","targetname");
	level.joker.ignoreall = 0;
	level.joker.goalradius = 15;
	level.joker setgoalnode(var_00);
	level.joker waittill("goal");
	wait(5);
	level.joker setgoalnode(var_02);
	common_scripts\utility::flag_wait("send_all_teammates_upstairs");
	wait(1.5);
	level.joker setgoalnode(var_01);
}

//Function Number: 114
bones_advance_hospital()
{
	var_00 = getnode("bones_cover_outside","targetname");
	var_01 = getnode("bones_cover_inside_hospital","targetname");
	var_02 = getnode("bones_holdup_before_going_upstairs_node","targetname");
	level.bones.ignoreall = 0;
	level.bones.goalradius = 15;
	level.bones setgoalnode(var_00);
	level.bones waittill("goal");
	wait(4);
	level.bones setgoalnode(var_02);
	common_scripts\utility::flag_wait("send_all_teammates_upstairs");
	wait(2);
	level.bones setgoalnode(var_01);
}

//Function Number: 115
hospital_stairs_autosave()
{
	maps\_utility::trigger_wait_targetname("hospital_stairs_autosave");
	maps\_utility::disable_trigger_with_noteworthy("hospital_stairs_autosave");
}

//Function Number: 116
stop_current_animations(param_00)
{
	self endon("death");
	self stopanimscripted();
	self notify("drone_stop");
	self notify("stop_loop");
	self notify("single anim","end");
	self notify("looping anim","end");
	if(isdefined(param_00))
	{
		param_00 notify("drone_stop");
		param_00 notify("stop_loop");
		param_00 notify("single anim","end");
		param_00 notify("looping anim","end");
	}
}

//Function Number: 117
sync_anim_times_with_carrier(param_00,param_01)
{
	self endon("death");
	var_02 = ["carry_doc_walk","carry_doc_stop","carry_doc_downstairs_loop","carry_doc_upstairs_loop"];
	var_03 = undefined;
	while(!common_scripts\utility::flag(param_01))
	{
		waittillframeend;
		if(common_scripts\utility::flag(param_01))
		{
			return;
		}

		var_04 = param_00 getactiveanimations();
		foreach(var_06 in var_04)
		{
			foreach(var_08 in var_02)
			{
				if(var_06["animation"] == level.scr_anim[param_00.animname][var_08])
				{
					if(!isdefined(var_03) || var_03 != var_06["animation"])
					{
						self setanimknobrestart(level.scr_anim[self.animname][var_08],1,0.2,1);
						var_03 = var_06["animation"];
					}

					self setanimtime(level.scr_anim[self.animname][var_08],var_06["currentAnimTime"]);
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 118
kva_ar()
{
	var_00 = getent("hospital_fight_goal1","targetname");
	var_01 = getentarray("kva_hospital_ar","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_04 setgoalvolumeauto(var_00);
	}

	maps\_utility::trigger_wait_targetname("doctor_chase_gate_close_trig");
	common_scripts\utility::flag_set("hospital_wave_2");
	wait(2);
	var_06 = getentarray("kva_hospital_ar_wave2","targetname");
	foreach(var_03 in var_06)
	{
		var_04 = var_03 maps\_utility::spawn_ai();
		if(isdefined(var_04))
		{
			var_04 maps\_utility::player_seek_enable();
		}

		wait(0.05);
	}
}

//Function Number: 119
kva_heavy()
{
	var_00 = getent("hospital_fight_goal1","targetname");
	wait(6);
	var_01 = getentarray("kva_hospital_heavy","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_ai();
		var_04 maps\_utility::set_moveplaybackrate(0.75);
		var_04 setgoalvolumeauto(var_00);
	}

	maps\_utility::trigger_wait_targetname("doctor_chase_gate_close_trig");
	var_01 = getentarray("kva_hospital_heavy","targetname");
	wait(2);
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_ai();
		if(isdefined(var_04))
		{
			var_00 = getent("hospital_fight_goal1","targetname");
			var_04 maps\_utility::set_moveplaybackrate(0.75);
			var_04.combatmode = "no_cover";
			var_04 setgoalvolumeauto(var_00);
			wait(4);
		}

		wait(0.05);
	}
}

//Function Number: 120
kva_last_heavy()
{
}

//Function Number: 121
special_kva()
{
	maps\_utility::trigger_wait_targetname("kva_grenade_throw_trigger");
	var_00 = getent("kva_hospital_ar_special1","targetname");
	var_01 = getent("kva_hospital_ar_special2","targetname");
	var_02 = getnode("kva_special_spot_1","targetname");
	var_03 = getnode("kva_special_spot_2","targetname");
	var_04 = var_00 maps\_utility::spawn_ai(1);
	var_05 = var_01 maps\_utility::spawn_ai(1);
	var_04.goalradius = 15;
	var_05.goalradius = 15;
	var_04 setgoalnode(var_02);
	var_05 setgoalnode(var_03);
}

//Function Number: 122
final_approach()
{
	maps\_utility::trigger_wait_targetname("last_room_setup_trigger");
	level.burke maps\_utility::disable_careful();
	level.joker maps\_utility::disable_careful();
	level.bones maps\_utility::disable_careful();
}

//Function Number: 123
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
	self.ignoreme = 1;
	maps\_utility::enable_dontevershoot();
	self.disablefriendlyfirereaction = 1;
	maps\_utility::setflashbangimmunity(1);
}

//Function Number: 124
enable_awareness()
{
	self.ignoreall = 0;
	self.dontmelee = undefined;
	self.ignoresuppression = 0;
	if(isdefined(self.suppressionwait_old))
	{
		self.suppressionwait = self.suppressionwait_old;
		self.suppressionwait_old = undefined;
	}

	maps\_utility::enable_surprise();
	self.ignorerandombulletdamage = 0;
	maps\_utility::enable_bulletwhizbyreaction();
	maps\_utility::enable_pain();
	self.grenadeawareness = 1;
	self.ignoreme = 0;
	maps\_utility::disable_dontevershoot();
	self.disablefriendlyfirereaction = undefined;
	maps\_utility::setflashbangimmunity(0);
}

//Function Number: 125
cloak_off(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.75;
	}

	var_01 = 0;
	self setmaterialscriptparam(1,param_00);
	wait(param_00);
	self drawpostresolveoff();
	self setmodel(self.defaultmodel);
	self.cloak = "off";
	self overridematerialreset();
	self overridematerial("mtl_burke_sentinel_covert_headgear_a","mc/mtl_burke_sentinel_covert_headgear_a_cloak");
}

//Function Number: 126
set_cloak_material_for_npc_weapon()
{
	if(self.weapon != "iw5_unarmed")
	{
		self overridematerial("_base_black","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("_iron_sights_black","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("_iron_sights_color","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_weapon_suppressor_b","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_bal27_screen_a_green","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_bal27_magazine_out","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_bal27_magazine_inside","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_optics_variable_red_dot","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_optics_variable_red_dot_lens_02","m/mtl_burke_sentinel_covert_headgear_a_cloak");
		self overridematerial("mtl_bal27_iron_sights","m/mtl_burke_sentinel_covert_headgear_a_cloak");
	}
}

//Function Number: 127
assign_cloak_model(param_00)
{
	self.cloakedmodel = param_00;
	self.defaultmodel = self.model;
}

//Function Number: 128
cloak_on(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.75;
	}

	var_01 = 0;
	self setmodel(self.cloakedmodel);
	self drawpostresolve();
	self setmaterialscriptparam(0,param_00);
	self.cloak = "on";
	wait(0.1);
	set_cloak_material_for_npc_weapon();
}

//Function Number: 129
disable_enable_exit_flags()
{
	maps\_utility::disable_trigger_with_targetname("send_burke_to_stairs_waitpoint");
	maps\_utility::disable_trigger_with_targetname("send_burke_to_railway_half");
	maps\_utility::disable_trigger_with_targetname("send_burke_fully_across");
	maps\_utility::disable_trigger_with_targetname("make_burke_anim_reach_sentinel");
	common_scripts\utility::flag_wait("player_captured_doctor");
	maps\_utility::enable_trigger_with_targetname("send_burke_to_stairs_waitpoint");
	maps\_utility::enable_trigger_with_targetname("send_burke_to_railway_half");
	maps\_utility::enable_trigger_with_targetname("send_burke_fully_across");
	maps\_utility::enable_trigger_with_targetname("make_burke_anim_reach_sentinel");
}

//Function Number: 130
set_helmet_open(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	wait(param_01);
	self setanimknobrestart(%sentinel_covert_helmet_open_idle,1,param_00);
}

//Function Number: 131
set_helmet_closed(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	wait(param_01);
	self setanimknobrestart(%sentinel_covert_helmet_closed_idle,1,param_00);
}

//Function Number: 132
setup_hospital_bodies()
{
	maps\_utility::trigger_wait_targetname("hospital_start");
	var_00 = getent("dead_spot","targetname");
	var_01 = getent("civ_spawner_hospital_2","targetname");
	var_02 = maps\detroit_school::school_drone_spawn(var_01);
	var_02 setcontents(0);
	var_00 maps\_anim::anim_first_frame_solo(var_02,"deadpose_1");
}