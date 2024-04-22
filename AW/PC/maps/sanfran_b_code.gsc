/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 209
 * Decompile Time: 2975 ms
 * Timestamp: 4/22/2024 2:35:26 AM
*******************************************************************/

//Function Number: 1
spawn_allies()
{
	level.burke = getent("burke","targetname") maps\_utility::spawn_ai(1);
	level.cormack = getent("cormack","targetname") maps\_utility::spawn_ai(1);
	level.maddox = getent("maddox","targetname") maps\_utility::spawn_ai(1);
	level.burke setup_hero("burke");
	level.cormack setup_hero("cormack");
	level.maddox setup_hero("maddox");
}

//Function Number: 2
setup_hero(param_00)
{
	maps\_utility::magic_bullet_shield();
	self.animname = param_00;
	if(!isdefined(level.heroes))
	{
		level.heroes = [];
	}

	level.heroes[level.heroes.size] = self;
}

//Function Number: 3
bridge_idle_anims()
{
	var_00 = maps\_utility::spawn_anim_model("bridge_part_a");
	var_01 = maps\_utility::spawn_anim_model("bridge_part_b");
	var_02 = maps\_utility::spawn_anim_model("bridge_part_c");
	var_03 = maps\_utility::spawn_anim_model("bridge_part_d");
	var_04 = common_scripts\utility::getstruct("org_bridge_parts","targetname");
	var_05 = [var_00,var_01,var_02,var_03];
	var_04 thread maps\_anim::anim_loop(var_05,"bridge_parts_idle");
}

//Function Number: 4
tilt_boat(param_00)
{
	common_scripts\utility::flag_wait("intro_anim_finished");
	var_01 = common_scripts\utility::spawn_tag_origin();
	if(!isdefined(param_00) || !param_00)
	{
		var_01.angles = (0,0,0);
		var_01 rotateto((-5,0,5),2);
	}
	else
	{
		var_01.angles = (-5,0,5);
	}

	level.player playersetgroundreferenceent(var_01);
	level.ground_ref_ent = var_01;
	thread adjust_gravity();
	level.waves = 0;
}

//Function Number: 5
adjust_gravity()
{
	var_00 = level.ground_ref_ent.angles;
	var_01 = -1 * anglestoup(level.ground_ref_ent.angles);
	setphysicsgravitydir(var_01);
	var_02 = var_01;
	for(;;)
	{
		var_03 = -1 * anglestoup(var_00);
		var_01 = -1 * anglestoup(level.ground_ref_ent.angles);
		var_04 = vectornormalize(var_01 + var_01 - var_03 * 100);
		if(var_04 != var_02)
		{
			setphysicsgravitydir(var_04);
			var_02 = var_04;
		}

		level.physics_gravity_vector = var_01;
		var_00 = level.ground_ref_ent.angles;
		wait(0.05);
	}
}

//Function Number: 6
close_interior_door()
{
	var_00 = getent("interior_exit_clip","targetname");
	var_00 disconnectpaths();
	level.interior_door = maps\_utility::spawn_anim_model("interior_bulkhead");
	var_01 = common_scripts\utility::getstruct("org_squad_enter_mob","targetname");
	var_01 maps\_anim::anim_first_frame_solo(level.interior_door,"ripopen_bulkhead");
}

//Function Number: 7
mob_enter_player_clip()
{
	var_00 = getent("player_enter_mob_clip","targetname");
	var_00.old_origin = var_00.origin;
	var_00.origin = (0,0,0);
	var_00 disconnectpaths();
	common_scripts\utility::flag_wait("flag_obj_marker_enter_ship");
	var_00.origin = var_00.old_origin;
	common_scripts\utility::flag_wait("flag_player_entered_interior");
	var_00 common_scripts\utility::delaycall(0.5,::delete);
	var_00 common_scripts\utility::delaycall(0.55,::connectpaths);
}

//Function Number: 8
intro_scene()
{
	soundscripts\_snd::snd_message("intro_scene");
	thread maps\sanfran_b_lighting::play_flickering_fire_light();
	if(level.nextgen)
	{
		thread maps\_utility::vision_set_fog_changes("sfb_neutral",0);
		setsunlight(0,0,0);
		maps\_lighting::set_spot_color("fire_rim",(1,0.8,0.83));
		maps\_lighting::set_spot_intensity("fire_rim",300000);
	}
	else
	{
		thread maps\_utility::vision_set_fog_changes("sanfran_b_exterior_dark",0);
	}

	common_scripts\_exploder::exploder(4225);
	if(level.nextgen)
	{
		maps\_utility::delaythread(2,::maps\_utility::fog_set_changes,"sanfran_b_exterior_dark_fog",2);
		maps\_utility::delaythread(4,::maps\_utility::fog_set_changes,"sanfran_b_exterior_dark_nofog",1);
		maps\_utility::delaythread(3.5,::maps\_lighting::set_spot_intensity,"fire_rim",0);
		maps\_utility::delaythread(6,::maps\_utility::fog_set_changes,"sanfran_b_exterior_dark_fog",5);
		maps\_utility::delaythread(6,::maps\_lighting::lerp_spot_intensity,"fire_rim",0.5,300000);
	}
	else
	{
		maps\_utility::delaythread(2,::maps\_utility::vision_set_fog_changes,"sanfran_b_exterior_dark_fog",2);
		maps\_utility::delaythread(4,::maps\_utility::vision_set_fog_changes,"sanfran_b_exterior_dark_nofog",1);
		maps\_utility::delaythread(6,::maps\_utility::vision_set_fog_changes,"sanfran_b_exterior_dark_fog",1);
	}

	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player disableweapons();
	soundscripts\_snd::snd_message("sfb_intro_burke_foley");
	soundscripts\_snd::snd_message("sfb_intro_car_explode");
	var_00 = maps\_utility::spawn_anim_model("player_arms");
	level.player playerlinktodelta(var_00,"tag_player",1,8,8,4,4);
	level.player common_scripts\utility::delaycall(0.1,::playerlinktodelta,var_00,"tag_player",1,12,12,10,4);
	level.player enableslowaim();
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("littlebird_intro");
	var_01.animname = "littlebird";
	if(level.nextgen)
	{
		setsaveddvar("r_dynamicSpotLightShadows",0);
	}

	maps\_utility::delaythread(8,::common_scripts\_exploder::exploder,4222);
	maps\_utility::delaythread(8,::common_scripts\_exploder::exploder,1999);
	maps\_utility::delaythread(11,::maps\_utility::stop_exploder,4223);
	var_02 = maps\_utility::spawn_anim_model("pickup_truck");
	var_03 = maps\_utility::spawn_anim_model("domestic_mini");
	var_04 = [level.burke,level.cormack,level.maddox,var_00,var_01,var_02,var_03];
	var_05 = common_scripts\utility::getstruct("org_intro_anim","targetname");
	var_05 maps\_anim::anim_first_frame(var_04,"intro");
	foreach(var_07 in level.heroes)
	{
		var_07 thread maps\sanfran_b_util::hide_friendname_until_flag_or_notify("player_control_enabled");
		var_07 maps\sanfran_b_util::disable_awareness();
	}

	thread maps\_utility::flag_set_delayed("intro_dialogue",23);
	maps\_utility::delaythread(22.5,::maps\_utility::stop_exploder,1999);
	maps\_utility::delaythread(21,::common_scripts\_exploder::exploder,4443);
	level.burke soundscripts\_snd::snd_message("pcap_vo_sf_b_intro","burke");
	level.cormack soundscripts\_snd::snd_message("pcap_vo_sf_b_intro","cormack");
	var_05 thread maps\_anim::anim_single(var_04,"intro");
	level waittill("intro_scene_artillery_rumble");
	level.player playrumbleonentity("artillery_rumble");
	common_scripts\utility::flag_wait("intro_anim_finished");
	soundscripts\_snd::snd_message("intro_scene_done");
	level notify("player_control_enabled");
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	level.player unlink();
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player disableslowaim();
	setsaveddvar("ammoCounterHide","0");
	if(level.currentgen)
	{
		maps\_utility::vision_set_fog_changes("sanfran_b_exterior_dark_fog",1);
	}

	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("sanfran_b",4);
	}

	thread maps\sanfran_b_lighting::stop_flickering_fire_light();
	thread maps\_shg_fx::vfx_sunflare("sanfran_sunflare_a");
	common_scripts\_exploder::exploder(4444);
	maps\_utility::pauseexploder(4445);
	common_scripts\utility::flag_clear("msg_vfx_zone1000_disable");
	var_00 delete();
	var_01 delete();
	maps\_utility::stop_exploder(4222);
	maps\_utility::stop_exploder(4225);
	setsaveddvar("r_dynamicSpotLightShadows",1);
	setsaveddvar("r_fog_ev_adjust",1.5);
	if(level.nextgen)
	{
	}

	maps\_utility::autosave_by_name();
	thread squad_becomes_aware_after_intro();
	maps\_utility::activate_trigger_with_targetname("trig_squad_move_001");
}

//Function Number: 9
squad_becomes_aware_after_intro()
{
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	foreach(var_01 in level.heroes)
	{
		var_01 maps\sanfran_b_util::enable_awareness();
	}
}

//Function Number: 10
ambient_deck()
{
	level waittill("player_control_enabled");
	thread warbird_strafe_run();
	thread ambient_shrike_flyby();
	var_00 = getent("refl_probe_heli_open","targetname");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("ambient_warbird_1");
	var_01 soundscripts\_snd::snd_message("warbird_circling_perimeter");
	waittillframeend;
	var_01 maps\_vehicle::godon();
	var_01 overridereflectionprobe(var_00.origin);
	var_01 thread maps\sanfran_b_util::ambient_warbird_shooting_think(0);
	var_01 thread maps\sanfran_b_util::ambient_warbird_wait_to_fire();
	var_01 thread delete_ambient();
	var_01 setmaxpitchroll(10,60);
	var_01.ignoreme = 1;
	var_02 = getentarray("ambient_drone_swarm_1","script_noteworthy");
	if(!isdefined(level.ambient_drones))
	{
		level.ambient_drones = [];
	}

	foreach(var_04 in var_02)
	{
		var_05 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_04.targetname);
		var_05.ignoreme = 1;
		var_05 maps\_utility::ent_flag_set("fire_disabled");
		var_05 thread delete_ambient();
		level.ambient_drones[level.ambient_drones.size] = var_05;
	}
}

//Function Number: 11
warbird_strafe_run()
{
	maps\_utility::trigger_wait_targetname("trig_warbird_strafe");
	var_00 = getent("refl_probe_heli_open","targetname");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("warbird_strafe_1");
	var_01 soundscripts\_snd::snd_message("warbird_strafe_01");
	var_01 overridereflectionprobe(var_00.origin);
	waittillframeend;
	var_01 thread maps\sanfran_b_util::ambient_warbird_shooting_think(0);
	var_01 thread maps\sanfran_b_util::ambient_warbird_wait_to_fire();
	var_01 setmaxpitchroll(10,60);
}

//Function Number: 12
ambient_shrike_flyby()
{
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	var_00 = getent("refl_probe_heli_open","targetname");
	var_01 = maps\_utility::array_spawn_targetname("flyby_shrikes");
	var_01 soundscripts\_snd::snd_message("shrike_flyby_pair_01");
	foreach(var_03 in var_01)
	{
		var_03 overridereflectionprobe(var_00.origin);
	}

	common_scripts\utility::array_thread(var_01,::maps\_vehicle::gopath);
}

//Function Number: 13
ambient_explosions()
{
	level endon("jammer_2_deactivated");
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	wait(5);
	for(;;)
	{
		var_00 = anglestoforward(level.player.angles);
		var_01 = randomintrange(512,800);
		var_02 = anglestoright(level.player.angles);
		var_03 = randomintrange(-400,400);
		var_04 = level.player.origin + var_00 * var_01 + var_02 * var_03;
		var_05 = var_04;
		var_06 = var_04 - (0,0,150);
		var_07 = bullettrace(var_05,var_06,0,undefined);
		if(isdefined(var_07))
		{
			var_05 = var_07["position"];
			var_08 = vectortoangles(var_07["normal"]);
			var_08 = var_08 + (90,0,0);
			var_00 = anglestoforward(var_08);
			var_09 = anglestoup(var_08);
			playfx(common_scripts\utility::getfx("ambient_explosion"),var_05,var_09,var_00);
			radiusdamage(var_05,100,200,20);
			physicsexplosionsphere(var_05,100,50,2);
		}

		wait(randomfloatrange(5,10));
	}
}

//Function Number: 14
enemy_reinforcements()
{
	level endon("all_jammers_deactivated");
	for(;;)
	{
		var_00 = getaiarray("axis");
		if(var_00.size <= 2)
		{
			var_01 = enemy_reinforcements_think();
			if(isdefined(var_01))
			{
				var_01 thread deck_reinforcement_modify_accuracy();
				var_02 = randomint(100);
				if(var_02 >= 0 && var_02 < 50)
				{
					var_01 maps\_utility::set_goal_entity(level.burke);
				}
				else
				{
					var_01 maps\_utility::set_goal_entity(level.cormack);
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 15
enemy_reinforcements_think()
{
	var_00 = getent("enemy_reinforcement_spawner","targetname");
	var_01 = common_scripts\utility::getstructarray("enemy_reinforce_loc","targetname");
	var_02 = getdvarint("cg_fov");
	var_03 = cos(var_02);
	var_01 = sortbydistance(var_01,level.player.origin);
	var_01 = common_scripts\utility::array_reverse(var_01);
	foreach(var_05 in var_01)
	{
		var_06 = anglestoforward(level.player getplayerangles());
		var_07 = vectornormalize(var_05.origin - level.player.origin);
		if(vectordot(var_06,var_07) < var_03)
		{
			var_00.origin = var_05.origin;
			var_00.count++;
			var_08 = var_00 maps\_utility::spawn_ai();
			return var_08;
		}

		wait(0.05);
	}
}

//Function Number: 16
deck_reinforcement_modify_accuracy()
{
	self endon("death");
	var_00 = getdvarint("cg_fov");
	var_01 = cos(var_00);
	thread maps\sanfran_b_util::equip_microwave_grenade();
	createthreatbiasgroup("deck_reinforcements_behind_player");
	createthreatbiasgroup("deck_reinforcements_in_front_of_player");
	setthreatbias("player","deck_reinforcements_behind_player",-20000);
	setthreatbias("player","deck_reinforcements_in_front_of_player",0);
	self setthreatbiasgroup("deck_reinforcements_behind_player");
	for(;;)
	{
		var_02 = anglestoforward(level.player.angles);
		var_03 = vectornormalize(self.origin - level.player.origin);
		if(vectordot(var_02,var_03) < var_01)
		{
			self setthreatbiasgroup("deck_reinforcements_behind_player");
		}
		else
		{
			self setthreatbiasgroup("deck_reinforcements_in_front_of_player");
		}

		wait(0.05);
	}
}

//Function Number: 17
delete_ambient()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_information_center");
	self delete();
}

//Function Number: 18
cargo_ship_missiles()
{
	level endon("jammer_2_deactivated");
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	var_00 = common_scripts\utility::getstructarray("cargo_missile_orgs","targetname");
	var_01 = getentarray("cargo_missile_targets","targetname");
	for(;;)
	{
		var_02 = var_00[randomint(var_00.size)];
		var_03 = var_01[randomint(var_01.size)];
		var_04 = common_scripts\utility::getstruct(var_02.target,"targetname").origin;
		var_05 = vectortoangles(var_03.origin - var_02.origin);
		var_06 = magicbullet("cargo_ship_missile",var_02.origin,var_04);
		var_06 missile_settargetent(var_03);
		var_06 missile_setflightmodedirect();
		playfx(common_scripts\utility::getfx("missile_launch_smoke"),var_02.origin,anglestoforward(var_05),anglestoup(var_05));
		wait(randomfloatrange(5,10));
	}
}

//Function Number: 19
shrike_flyby()
{
	maps\_utility::trigger_wait_targetname("trig_shrike_flyby_1");
	if(level.nextgen)
	{
		var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("shrike_flyby_1");
		var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("shrike_flyby_2");
		soundscripts\_snd::snd_message("shrike_flyby_pair_02",var_00,var_01);
		return;
	}

	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("shrike_flyby_2");
	soundscripts\_snd::snd_message("shrike_flyby_pair_02",undefined,var_01);
}

//Function Number: 20
initial_combat()
{
	level.deck_navy_guys = maps\_utility::array_spawn_noteworthy("navy_deck_guys_initial",1);
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	level.enemy_deck_guys = maps\_utility::array_spawn_noteworthy("enemy_deck_guys_initial",1);
	common_scripts\utility::array_thread(level.enemy_deck_guys,::maps\_utility::set_grenadeammo,0);
	level notify("spawned_jammer_guards");
}

//Function Number: 21
shrike_takeoff()
{
	level.player endon("death");
	var_00 = getent("refl_probe_heli_open","targetname");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("heli_takeoff_pod_1");
	var_01.animname = "shrike_1";
	var_01 maps\_vehicle::godon();
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("heli_takeoff_pod_2");
	var_02.animname = "shrike_2";
	var_02 maps\_vehicle::godon();
	var_02 vehicle_removebrushmodelcollision();
	var_03 = common_scripts\utility::getstruct("org_shrike_takeoff","targetname");
	var_04 = [var_02,var_01];
	var_03 thread maps\_anim::anim_first_frame(var_04,"shrike_takeoff");
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	soundscripts\_snd::snd_message("shrike_takeoff",var_02,var_01);
	var_03 maps\_anim::anim_single(var_04,"shrike_takeoff");
	foreach(var_06 in var_04)
	{
		var_06 delete();
	}
}

//Function Number: 22
shrike_takeoff_cg()
{
	maps\_utility::trigger_wait_targetname("trig_heli_takeoff_pod_1");
	wait(5);
	common_scripts\utility::flag_set("useyourboosters_vo");
}

//Function Number: 23
initial_deck_guys_invuln()
{
	self endon("death");
	maps\_utility::magic_bullet_shield();
	thread maps\_utility::set_grenadeammo(0);
	wait(randomfloatrange(1,3));
	maps\_utility::stop_magic_bullet_shield();
	self.noragdoll = undefined;
}

//Function Number: 24
move_initial_enemies()
{
	var_00 = getent("trig_warbird_strafe","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isdefined(var_01) && isplayer(var_01) || maps\_utility::is_in_array(level.heroes,var_01))
		{
			break;
		}
	}

	var_02 = getent("vol_first_helipad","targetname");
	var_03 = getent("vol_second_helipad","targetname");
	var_04 = getent("vol_tall_helipad","targetname");
	var_05 = getaiarray("axis");
	var_06 = var_03;
	if(isdefined(var_05) && var_05.size > 0)
	{
		foreach(var_01 in var_05)
		{
			if(!var_01 istouching(var_02))
			{
				continue;
			}

			var_01 maps\sanfran_b_util::disable_awareness();
			var_01 thread become_aware_on_goal();
			var_01 thread become_aware_when_player_is_in_volume();
			var_01 setgoalvolumeauto(var_06);
			var_01 thread detect_when_player_is_in_volume(var_06);
			if(var_06 == var_03)
			{
				var_06 = var_04;
				continue;
			}

			var_06 = var_03;
		}
	}
}

//Function Number: 25
deck_reinforcement_ally_think()
{
	maps\_utility::pathrandompercent_set(500);
}

//Function Number: 26
become_aware_on_goal()
{
	self endon("death");
	self endon("player_touching_volume");
	self waittill("goal");
	maps\sanfran_b_util::enable_awareness();
	self cleargoalvolume();
	self notify("guys_aware_on_goal");
}

//Function Number: 27
become_aware_when_player_is_in_volume()
{
	self endon("death");
	self endon("guys_aware_on_goal");
	self waittill("player_touching_volume");
	maps\sanfran_b_util::enable_awareness();
	self cleargoalvolume();
}

//Function Number: 28
detect_when_player_is_in_volume(param_00)
{
	level.player endon("death");
	while(!level.player istouching(param_00))
	{
		wait(0.05);
	}

	self notify("player_touching_volume");
}

//Function Number: 29
manage_deck_combat()
{
	level.player endon("death");
	maps\_utility::trigger_wait_targetname("trig_deck_combat_first_wave");
	level.burke maps\_utility::enable_careful();
	level.cormack maps\_utility::enable_careful();
	level.maddox maps\_utility::enable_careful();
	resetsunlight();
	maps\_lighting::set_spot_intensity("fire_rim",0);
	thread thin_out_navy_guys(2);
	thread deck_jammers();
	if(level.currentgen)
	{
		var_00 = getentarray("deck_combat_first_wave_guys","targetname");
		foreach(var_02 in var_00)
		{
			var_03 = var_02 maps\_utility::spawn_ai();
			wait 0.05;
		}
	}
	else
	{
		maps\_utility::array_spawn_targetname("deck_combat_first_wave_guys");
	}

	thread check_player_deck_position_1();
	maps\_utility::trigger_wait_targetname("trig_shrike_flyby_1");
	var_05 = maps\_utility::array_spawn_noteworthy("jammer_1_defenders",0,1);
	common_scripts\utility::array_thread(var_05,::jammer_1_defenders_logic);
	common_scripts\utility::array_thread(var_05,::deck_reinforcement_modify_accuracy);
	maps\sanfran_b_util::wait_for_number_enemies_alive(5);
	thread deck_drones("left");
	common_scripts\utility::flag_wait("jammer_1_deactivated");
	thread check_player_deck_position_2();
	level.burke maps\_utility::disable_careful();
	level.cormack maps\_utility::disable_careful();
	level.maddox maps\_utility::disable_careful();
	foreach(var_07 in level.deck_drones)
	{
		if(isdefined(var_07) && isalive(var_07))
		{
			var_07 maps\_vehicle::vehicle_set_health(1);
			var_07 dodamage(9999,var_07.origin);
		}
	}

	maps\_utility::autosave_by_name();
	thread thin_out_navy_guys(1);
	thread on_the_way_to_jammer_2();
	maps\_utility::activate_trigger_with_targetname("trig_ally_move_jammer_2");
	var_09 = getent("refl_probe_heli_open","targetname");
	var_0A = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("heli_left_1");
	var_0A soundscripts\_snd::snd_message("warbird_dropoff_01");
	var_0A setmaxpitchroll(15,60);
	var_0A thread setup_deck_deploy_warbird();
	var_0A maps\_utility::ent_flag_init("dont_shoot_player");
	var_0A maps\_utility::ent_flag_set("dont_shoot_player");
	var_0A overridereflectionprobe(var_09.origin);
	wait(1);
	var_0B = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("heli_left_2");
	var_0B soundscripts\_snd::snd_message("warbird_dropoff_02");
	var_0B setmaxpitchroll(15,60);
	var_0B thread setup_deck_deploy_warbird();
	var_0B maps\_utility::ent_flag_init("dont_shoot_player");
	var_0B maps\_utility::ent_flag_set("dont_shoot_player");
	var_0B overridereflectionprobe(var_09.origin);
	common_scripts\utility::flag_set("deck_warbird_vo");
	maps\_utility::trigger_wait_targetname("trig_jammer_2_drones");
	var_0C = deck_drones("right");
	thread friendly_airstrike(var_0C);
	maps\_utility::activate_trigger_with_targetname("trig_post_jammer_2_squad_move");
	thread maps\_utility::flag_set_delayed("jammer_2_vo",3);
	common_scripts\utility::flag_wait("jammer_2_deactivated");
	common_scripts\utility::flag_set("flag_move_gideon_into_interior");
	thread thin_out_navy_guys(0);
	foreach(var_07 in level.deck_drones)
	{
		if(isdefined(var_07) && isalive(var_07))
		{
			var_07 maps\_vehicle::vehicle_set_health(1);
			var_07 dodamage(9999,var_07.origin);
		}
	}

	maps\_utility::autosave_by_name();
	level.cormack maps\_utility::teleport_ai(getnode("cormack_deck_end_cover","targetname"));
	level.maddox maps\_utility::teleport_ai(getnode("maddox_deck_end_cover","targetname"));
	level.burke maps\_utility::teleport_ai(getnode("burke_deck_end_cover","targetname"));
	maps\_utility::activate_trigger_with_targetname("trig_move_squad_to_pre_mob_enter");
	thread move_squad_into_ship();
	thread jammer_3_navy_drone_combat();
	maps\_utility::delaythread(3,::deck_enemies_cleared);
	var_0F = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("heli_back_2");
	var_0F soundscripts\_snd::snd_message("warbird_dropoff_03");
	var_0F setmaxpitchroll(10,60);
	var_0F thread setup_deck_deploy_warbird();
	var_0F overridereflectionprobe(var_09.origin);
	var_10 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("heli_back_1");
	var_10 soundscripts\_snd::snd_message("warbird_dropoff_04");
	var_10 setmaxpitchroll(10,60);
	var_10 thread setup_deck_deploy_warbird();
	var_10 overridereflectionprobe(var_09.origin);
	var_11 = getent("warbird_slide_trigger","targetname");
	var_11 enablelinkto();
	var_11 linkto(var_10);
	thread wait_for_all_deck_warbirds_to_unload();
	var_0F thread hangar_heli_wait_for_unload("deck_warbird_3_unloaded");
	var_10 thread hangar_heli_wait_for_unload("deck_warbird_4_unloaded");
	thread jammer_3_shrike_flyby(var_10);
	common_scripts\utility::flag_wait("all_deck_warbirds_deployed");
	var_12 = getaiarray("axis");
	while(var_12.size > 2)
	{
		var_12 = maps\_utility::remove_dead_from_array(var_12);
		wait(0.5);
	}

	if(common_scripts\utility::flag("player_near_mob_entrance") == 0)
	{
		common_scripts\utility::flag_set("rail_guns_secure_vo");
		maps\_utility::activate_trigger_with_targetname("trig_squad_move_into_boat");
		common_scripts\utility::flag_set("show_enter_ship_obj_marker");
		foreach(var_03 in level.heroes)
		{
			var_03 cleargoalvolume();
			var_03.fixednode = 1;
		}

		common_scripts\utility::flag_wait("all_jammers_deactivated");
		wait(0.25);
		var_12 = getaiarray("axis");
		if(var_12.size > 0)
		{
			foreach(var_03 in var_12)
			{
				var_03 thread maps\sanfran_b_util::bloody_death(randomfloatrange(0,2));
			}
		}

		common_scripts\utility::flag_set("flag_obj_marker_enter_ship");
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::set_ignoreme,1);
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::set_ignoreall,1);
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::disable_pain);
		maps\_utility::autosave_by_name();
		slow_player_inside();
	}
}

//Function Number: 30
check_player_deck_position_1()
{
	level endon("jammer_1_deactivated");
	maps\_utility::array_spawn_function_targetname("deck_top_combat_first_wave_guys",::maps\sanfran_b_util::equip_microwave_grenade);
	common_scripts\utility::flag_wait("flag_deck_top_combat_first_wave_guys");
	maps\_utility::array_spawn_targetname("deck_top_combat_first_wave_guys");
}

//Function Number: 31
check_player_deck_position_2()
{
	level endon("jammer_2_deactivated");
	maps\_utility::array_spawn_function_targetname("deck_top_combat_second_wave_guys",::maps\sanfran_b_util::equip_microwave_grenade);
	common_scripts\utility::flag_wait("flag_deck_top_combat_second_wave_guys");
	maps\_utility::array_spawn_targetname("deck_top_combat_second_wave_guys");
}

//Function Number: 32
move_squad_into_ship()
{
	common_scripts\utility::flag_wait("player_near_mob_entrance");
	if(common_scripts\utility::flag("flag_obj_marker_enter_ship") == 0)
	{
		common_scripts\utility::flag_set("show_enter_ship_obj_marker");
		common_scripts\utility::flag_set("flag_obj_marker_enter_ship");
		common_scripts\utility::flag_set("rail_guns_secure_vo");
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::set_ignoreme,1);
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::set_ignoreall,1);
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::disable_pain);
		var_00 = getaiarray("axis");
		if(var_00.size > 0)
		{
			foreach(var_02 in var_00)
			{
				var_02 thread maps\sanfran_b_util::bloody_death(randomfloatrange(0,2));
			}
		}

		maps\_utility::autosave_by_name();
		slow_player_inside();
		common_scripts\utility::flag_wait("boosters_off_anim_finished");
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::set_ignoreme,0);
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::set_ignoreall,0);
		common_scripts\utility::array_thread(level.heroes,::maps\_utility::enable_pain);
	}
}

//Function Number: 33
thin_out_navy_guys(param_00)
{
	while(level.deck_navy_guys.size > param_00)
	{
		level.deck_navy_guys[randomint(level.deck_navy_guys.size)] maps\sanfran_b_util::bloody_death(randomfloatrange(0.5,2));
		level.deck_navy_guys = maps\_utility::remove_dead_from_array(level.deck_navy_guys);
		wait(0.05);
	}
}

//Function Number: 34
deck_jammers()
{
	var_00 = getentarray("deck_jammers","script_noteworthy");
	common_scripts\utility::array_call(var_00,::hide);
	common_scripts\utility::array_thread(var_00,::turn_off_jammer_triggers);
	common_scripts\utility::array_thread(var_00,::jammer_think);
}

//Function Number: 35
turn_off_jammer_triggers()
{
	var_00 = getent(self.target,"targetname");
	var_00 common_scripts\utility::trigger_off();
}

//Function Number: 36
jammer_enemies_hint()
{
	level endon("jammer_guards_dead");
	var_00 = getent(self.target,"targetname");
	var_00 common_scripts\utility::trigger_on();
	var_00 usetriggerrequirelookat();
	var_00 sethintstring(&"SANFRAN_B_GUARD_HINT");
}

//Function Number: 37
jammer_enemies_spawn()
{
	var_00 = getent("jammer_guard_1","targetname") maps\_utility::spawn_ai(1);
	var_00 thread maps\sanfran_b_util::equip_microwave_grenade();
	var_00 thread jammer_enemy_1_think();
	var_01 = getent("jammer_guard_2","targetname") maps\_utility::spawn_ai(1);
	var_01 thread maps\sanfran_b_util::equip_microwave_grenade();
	var_01 thread jammer_enemy_2_think();
}

//Function Number: 38
jammer_enemy_1_think()
{
	var_00 = getent("trigger_jammer_enemy_touch1","targetname");
	while(isalive(self))
	{
		if(!self istouching(var_00))
		{
			break;
		}

		wait(0.5);
	}

	level.jammer_guards = level.jammer_guards + 1;
}

//Function Number: 39
jammer_enemy_2_think()
{
	var_00 = getent("trigger_jammer_enemy_touch2","targetname");
	while(isalive(self))
	{
		if(!self istouching(var_00))
		{
			break;
		}

		wait(0.5);
	}

	level.jammer_guards = level.jammer_guards + 1;
}

//Function Number: 40
jammer_think()
{
	level.jammer_objective = self;
	if(self.targetname == "jammer_1")
	{
		level.jammer_guards = 0;
		thread jammer_enemies_hint();
		thread jammer_enemies_spawn();
		while(level.jammer_guards < 2)
		{
			wait(0.15);
		}

		level notify("jammer_guards_dead");
		var_00 = getent(self.target,"targetname");
		var_00 common_scripts\utility::trigger_on();
		var_00 usetriggerrequirelookat();
		var_00 sethintstring(&"SANFRAN_B_DEACTIVATE_JAMMER");
		var_01 = var_00 maps\_shg_utility::hint_button_trigger("x",512);
		self setmodel("vm_jamming_device_obj");
		self show();
		var_00 waittill("trigger");
		var_00 common_scripts\utility::trigger_off();
		var_01 maps\_shg_utility::hint_button_clear();
		common_scripts\utility::flag_set("planting_jammer_1");
		self hide();
		play_jammer_1_anim();
	}
	else
	{
		common_scripts\utility::flag_wait("planting_jammer_1");
		var_00 = getent(self.target,"targetname");
		var_01 common_scripts\utility::trigger_on();
		var_01 usetriggerrequirelookat();
		var_01 sethintstring(&"SANFRAN_B_DEACTIVATE_JAMMER");
		var_01 = var_01 maps\_shg_utility::hint_button_trigger("x",512);
		self setmodel("vm_jamming_device_obj");
		self show();
		var_00 waittill("trigger");
		var_00 common_scripts\utility::trigger_off();
		var_01 maps\_shg_utility::hint_button_clear();
		common_scripts\utility::flag_set("planting_jammer_2");
		self hide();
		play_jammer_2_anim();
	}

	var_02 = self.script_parameters + "_deactivated";
	common_scripts\utility::flag_set(var_02);
}

//Function Number: 41
play_jammer_1_anim()
{
	var_00 = common_scripts\utility::getstruct("org_jammer_1","targetname");
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\sanfran_b_util::bloody_death();
	}

	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_05 = maps\_utility::spawn_anim_model("player_arms");
	var_05 hide();
	if(level.nextgen)
	{
		maps\_utility::delaythread(1.15,::player_jammer_movie);
	}

	var_00 maps\_anim::anim_first_frame_solo(var_05,"jammerplant_1");
	var_06 = maps\_utility::spawn_anim_model("jammer");
	var_06 soundscripts\_snd::snd_message("jammer_plant");
	var_01 = [var_05,var_06];
	level.player playerlinktoblend(var_05,"tag_player",0.4);
	wait(0.4);
	var_05 show();
	level.player enableinvulnerability();
	maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"boost_incoming_vo");
	thread deck_jammer_rumbles();
	var_00 maps\_anim::anim_single(var_01,"jammerplant_1");
	level.player disableinvulnerability();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	var_05 delete();
	level.player unlink();
}

//Function Number: 42
play_jammer_2_anim()
{
	soundscripts\_snd::snd_message("jammer_plant");
	var_00 = common_scripts\utility::getstruct("org_jammer_2","targetname");
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\sanfran_b_util::bloody_death();
	}

	level.player maps\_shg_utility::setup_player_for_scene(1);
	level notify("stop_jammer_movie");
	var_05 = maps\_utility::spawn_anim_model("player_arms");
	var_05 hide();
	if(level.nextgen)
	{
		maps\_utility::delaythread(1.15,::player_jammer_movie);
	}

	var_00 maps\_anim::anim_first_frame_solo(var_05,"jammerplant_2");
	var_06 = maps\_utility::spawn_anim_model("jammer");
	var_01 = [var_05,var_06];
	level.player playerlinktoblend(var_05,"tag_player",0.4);
	wait(0.4);
	var_05 show();
	level.player enableinvulnerability();
	thread deck_jammer_rumbles();
	var_00 maps\_anim::anim_single(var_01,"jammerplant_2");
	level.player disableinvulnerability();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	var_05 delete();
	level.player unlink();
}

//Function Number: 43
deck_jammer_rumbles()
{
	maps\sanfran_b_util::setup_level_rumble_ent();
	wait(0.5);
	thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.2);
	wait(0.5);
	thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.3);
	wait(0.5);
	thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.5,0.2);
}

//Function Number: 44
player_jammer_movie()
{
	level endon("stop_jammer_movie");
	level endon("boosters_off_anim_finished");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame("jammer_UI_loop",0,1,1);
	thread stop_jammer_movie();
}

//Function Number: 45
stop_jammer_movie()
{
	level endon("boosters_off_anim_finished");
	level waittill("stop_jammer_movie");
	stopcinematicingame();
}

//Function Number: 46
jammer_1_defenders_logic()
{
	maps\_utility::ent_flag_init("player_damaged_me");
	maps\_utility::add_damage_function(::defender_damage_func);
	thread track_player();
	thread unlock_on_death();
	thread maps\sanfran_b_util::equip_microwave_grenade();
}

//Function Number: 47
mob_entrance_defenders_logic()
{
	maps\_utility::ent_flag_init("player_damaged_me");
	maps\_utility::add_damage_function(::defender_damage_func);
}

//Function Number: 48
track_player()
{
	self endon("death");
	if(!isdefined(level.guy_tracking_player))
	{
		level.guy_tracking_player = 0;
	}

	for(;;)
	{
		if(common_scripts\utility::cointoss() && !level.guy_tracking_player)
		{
			maps\_utility::set_goal_entity(level.player);
			level.guy_tracking_player = 1;
		}

		wait(0.05);
	}
}

//Function Number: 49
unlock_on_death()
{
	self waittill("death");
	level.guy_tracking_player = 0;
}

//Function Number: 50
defender_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_01))
	{
		if(!isplayer(param_01))
		{
			if(!maps\_utility::ent_flag("player_damaged_me"))
			{
				return param_00 / 20;
			}

			return param_00;
		}

		if(!maps\_utility::ent_flag("player_damaged_me"))
		{
			maps\_utility::ent_flag_set("player_damaged_me");
		}

		return param_00;
	}
}

//Function Number: 51
on_the_way_to_jammer_2()
{
	var_00 = maps\_utility::array_spawn_noteworthy("jammer_2_enemies",1,1);
	common_scripts\utility::array_thread(var_00,::track_player);
	common_scripts\utility::array_thread(var_00,::unlock_on_death);
	common_scripts\utility::array_thread(var_00,::deck_reinforcement_modify_accuracy);
	maps\_utility::trigger_wait_targetname("trig_jammer_2_wave_2");
	var_00 = maps\_utility::array_spawn_noteworthy("jammer_2_enemies_wave_2",1,1);
	common_scripts\utility::array_thread(var_00,::track_player);
	common_scripts\utility::array_thread(var_00,::unlock_on_death);
	common_scripts\utility::array_thread(var_00,::deck_reinforcement_modify_accuracy);
}

//Function Number: 52
mobile_cover_anim()
{
	var_00 = common_scripts\utility::getstruct("org_mobile_cover","targetname");
	var_01 = getent("mobile_cover_guy1","targetname") maps\_utility::spawn_ai(1);
	var_01.animname = "guy1";
	var_01 maps\_utility::deletable_magic_bullet_shield();
	var_02 = getent("mobile_cover_guy2","targetname") maps\_utility::spawn_ai(1);
	var_02.animname = "guy2";
	var_02 maps\_utility::deletable_magic_bullet_shield();
	var_03 = spawn("script_model",var_00.origin);
	var_03 setmodel("vehicle_mobile_cover");
	var_03.animname = "mobile_cover";
	var_03 maps\_utility::assign_animtree("mobile_cover");
	var_03 thread mobile_cover_badplace();
	var_04 = [var_01,var_02,var_03];
	var_00 maps\_anim::anim_single_run(var_04,"deck_mobile_cover");
	var_02 maps\_utility::stop_magic_bullet_shield();
	var_02 kill();
	var_02 startragdoll();
	var_05 = spawn("script_origin",(0,0,0));
	var_05.origin = var_03.origin;
	var_06 = var_03.angles + (-90,90,0);
	var_03 setmodel("vehicle_mobile_cover_dstrypv");
	var_03 notify("stop_mobile_cover_badplace");
	earthquake(1,1.6,var_05.origin,625);
	radiusdamage(var_05.origin,200,200,100,undefined,"MOD_EXPLOSIVE");
	physicsexplosionsphere(var_05.origin,200,10,1);
}

//Function Number: 53
mobile_cover_badplace()
{
	self endon("stop_mobile_cover_badplace");
	for(;;)
	{
		badplace_cylinder("mobile_cover_badplace",0.25,self.origin,96,96,"axis","allies");
		wait(0.25);
	}
}

//Function Number: 54
setup_deck_deploy_warbird()
{
	maps\_vehicle::godon();
	thread warbird_turret_off_after_deploy();
	thread maps\sanfran_b_util::warbird_shooting_think(1);
	waittillframeend;
	self notify("warbird_fire");
	var_00 = maps\sanfran_b_util::get_passengers();
	var_00 thread maps\sanfran_b_util::ignore_until_unloaded();
	foreach(var_02 in var_00)
	{
		if(var_02.vehicle_position == 0)
		{
			var_02 maps\_utility::gun_remove();
		}
	}
}

//Function Number: 55
warbird_turret_off_after_deploy()
{
	self endon("death");
	self waittill("unloaded");
	self notify("warbird_stop_firing");
}

//Function Number: 56
friendly_airstrike(param_00)
{
	level.airstrike_drones = param_00;
	level.airstrike_drones common_scripts\utility::array_thread(param_00,::remove_from_array_when_dead);
	maps\_utility::trigger_wait_targetname("trig_friendly_airstrike");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("friendly_air_strike");
	var_01 soundscripts\_snd::snd_message("shrike_flyby_03");
	var_01 maps\_utility::ent_flag_init("airstrike_fire");
	var_01 thread maps\_vehicle::gopath();
	var_01 maps\_utility::ent_flag_wait("airstrike_fire");
}

//Function Number: 57
remove_from_array_when_dead()
{
	self waittill("death");
	level.airstrike_drones = common_scripts\utility::array_remove(level.airstrike_drones,self);
}

//Function Number: 58
deck_drones(param_00)
{
	var_01 = undefined;
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	if(param_00 == "left")
	{
		var_01 = vehicle_scripts\_pdrone::start_flying_attack_drones("deck_reinforcement_drones_left");
	}

	if(param_00 == "right")
	{
		var_01 = vehicle_scripts\_pdrone::start_flying_attack_drones("deck_reinforcement_drones_right");
	}

	if(isdefined(var_01))
	{
		common_scripts\utility::array_thread(var_01,::maps\sanfran_b_util::setup_atlas_drone,"flag_cleanup_deck_drones");
		return var_01;
	}
}

//Function Number: 59
jammer_3_navy_drone_combat()
{
	var_00 = maps\_utility::array_spawn_noteworthy("jammer_3_navy_drone_guys",0,1);
	level.jammer_3_navy_guys = [];
	level.jammer_3_navy_guys = var_00;
	common_scripts\utility::array_thread(var_00,::jammer_3_navy_drone_guy_setup);
	common_scripts\utility::array_thread(var_00,::jammer_3_remove_from_array_when_dead,"navy");
	maps\_utility::activate_trigger_with_targetname("trig_jammer_3_navy_drone_movement");
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	var_01 = vehicle_scripts\_pdrone::start_flying_attack_drones("jammer_3_navy_drone_drones");
	level.jammer_3_drones = [];
	level.jammer_3_drones = var_01;
	common_scripts\utility::array_thread(var_01,::maps\sanfran_b_util::setup_atlas_drone,"flag_cleanup_deck_drones");
	common_scripts\utility::array_thread(var_01,::jammer_3_remove_from_array_when_dead,"drones");
	common_scripts\utility::array_thread(var_01,::jammer_3_navy_drone_drones_setup);
}

//Function Number: 60
jammer_3_remove_from_array_when_dead(param_00)
{
	var_01 = undefined;
	self waittill("death");
	if(param_00 == "navy")
	{
		var_01 = level.jammer_3_navy_guys;
	}
	else
	{
		var_01 = level.jammer_3_drones;
	}

	var_01 = common_scripts\utility::array_remove(var_01,self);
}

//Function Number: 61
jammer_3_navy_drone_guy_setup()
{
	self endon("death");
	maps\_utility::add_damage_function(::navy_drone_guys_damage_func);
}

//Function Number: 62
deck_enemies_cleared()
{
	for(;;)
	{
		var_00 = getaiarray("axis");
		level.deck_drones = maps\_utility::array_removedead(level.deck_drones);
		if(var_00.size == 0 && level.deck_drones.size == 0)
		{
			break;
		}

		wait 0.05;
	}

	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		if(var_02 == level.cormack || var_02 == level.burke || var_02 == level.maddox)
		{
			continue;
		}
		else
		{
			var_02 thread maps\_utility::set_fixednode_true();
		}
	}
}

//Function Number: 63
navy_drone_guys_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_01) && param_01.classname == "script_vehicle_pdrone_atlas")
	{
		return param_00 * 2;
	}
}

//Function Number: 64
jammer_3_navy_drone_drones_setup()
{
	maps\_utility::add_damage_function(::navy_drone_drones_damage_func);
}

//Function Number: 65
navy_drone_drones_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_01) && maps\_utility::is_in_array(level.jammer_3_navy_guys,param_01))
	{
		return param_00 / 4;
	}
}

//Function Number: 66
jammer_3_shrike_flyby(param_00)
{
	param_00 waittill("unloaded");
	wait(3);
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jammer_3_shrike_1");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jammer_3_shrike_2");
	soundscripts\_snd::snd_message("shrike_flyby_pair_04",var_01,var_02);
}

//Function Number: 67
wait_for_all_deck_warbirds_to_unload()
{
	common_scripts\utility::flag_wait_all("deck_warbird_3_unloaded","deck_warbird_4_unloaded");
	common_scripts\utility::flag_set("all_deck_warbirds_deployed");
}

//Function Number: 68
missile_turrets_on()
{
	common_scripts\utility::flag_wait("all_deck_warbirds_deployed");
	wait(3);
	var_00 = getentarray("missile_launcher_1","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		var_02.missile_starts = getentarray(var_02.target,"targetname");
		if(!isdefined(var_02.missile_starts))
		{
			return;
		}

		foreach(var_04 in var_02.missile_starts)
		{
			var_04 linkto(var_02);
		}

		var_02 thread missile_turret_think();
	}
}

//Function Number: 69
missile_turret_think()
{
	level endon("stop_ship_weapons");
	for(;;)
	{
		self rotateto((0,randomintrange(180,360),0),1.5,0.25,0.25);
		wait(1.5);
		foreach(var_01 in self.missile_starts)
		{
			var_02 = anglestoforward(var_01.angles);
			var_02 = var_02 * 5000;
			var_02 = var_02 + (randomintrange(500,1000),randomintrange(500,1000),randomintrange(1000,2000));
			magicbullet("mob_missile",var_01.origin,var_01.origin + var_02);
			if(distance(self.origin,level.player.origin) <= 512)
			{
				earthquake(0.3,1,self.origin,1024);
				level.player playrumbleonentity("heavy_1s");
			}
		}

		wait(randomfloatrange(10,20));
	}
}

//Function Number: 70
boosters_off_anim(param_00)
{
	common_scripts\utility::flag_wait("flag_move_gideon_into_interior");
	var_01 = common_scripts\utility::getstruct("org_squad_enter_mob","targetname");
	level.burke maps\_utility::ent_flag_init("at_boosters_off");
	if(!isdefined(param_00) || !param_00)
	{
		level.burke thread go_to_boosters_off_and_first_frame(var_01);
	}

	common_scripts\utility::flag_wait("flag_obj_marker_enter_ship");
	level.cormack maps\_utility::ent_flag_init("at_boosters_off");
	level.maddox maps\_utility::ent_flag_init("at_boosters_off");
	var_02 = [level.cormack,level.burke,level.maddox];
	if(!isdefined(param_00) || !param_00)
	{
		level.cormack thread go_to_boosters_off_and_first_frame(var_01);
		level.maddox thread go_to_boosters_off_and_first_frame(var_01);
	}
	else
	{
		level.cormack maps\_utility::ent_flag_set("at_boosters_off");
		level.burke maps\_utility::ent_flag_set("at_boosters_off");
		level.maddox maps\_utility::ent_flag_set("at_boosters_off");
		var_01 maps\_anim::anim_first_frame(var_02,"boosters_off");
	}

	level.cormack maps\_utility::ent_flag_wait("at_boosters_off");
	level.burke maps\_utility::ent_flag_wait("at_boosters_off");
	level.maddox maps\_utility::ent_flag_wait("at_boosters_off");
	common_scripts\utility::flag_wait("flag_player_entered_interior");
	common_scripts\utility::flag_set("flag_cleanup_deck_drones");
	var_02 = getaiarray("axis");
	if(var_02.size > 0)
	{
		foreach(var_04 in var_02)
		{
			var_04 thread maps\sanfran_b_util::bloody_death(randomfloatrange(0,2));
		}
	}

	soundscripts\_snd::snd_message("enter_ship");
	common_scripts\utility::flag_set("boosters_off_anim_started");
	level.idle_org = var_01;
	var_01 notify("stop_wait_idle");
	level.burke thread play_boosters_off_anim(var_01);
	level.maddox thread play_boosters_off_anim(var_01);
	var_01 maps\_anim::anim_single_solo(level.cormack,"boosters_off");
	common_scripts\utility::flag_set("boosters_off_anim_finished");
	foreach(var_04 in var_02)
	{
		var_04 maps\_utility::enable_cqbwalk();
		var_04 maps\_utility::enable_ai_color();
		var_04.ignoreall = 0;
	}

	thread squad_move_interior();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
}

//Function Number: 71
play_boosters_off_anim(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"boosters_off");
	param_00 thread maps\_anim::anim_loop_solo(self,"boosters_off_idle","stop_idle");
}

//Function Number: 72
go_to_boosters_off_and_first_frame(param_00)
{
	param_00 maps\_anim::anim_reach_solo(self,"boosters_off");
	maps\_utility::ent_flag_set("at_boosters_off");
	param_00 maps\_anim::anim_first_frame_solo(self,"boosters_off");
	param_00 maps\_anim::anim_loop_solo(self,"boosters_off_wait_idle","stop_wait_idle");
}

//Function Number: 73
squad_move_interior()
{
	foreach(var_01 in level.heroes)
	{
		var_01 maps\_utility::enable_ai_color_dontmove();
		var_01.fixednode = 1;
	}
}

//Function Number: 74
crouch_until_door_open()
{
	self waittill("goal");
	self allowedstances("crouch");
	self waittill("door_open");
	self allowedstances("stand","crouch","prone");
}

//Function Number: 75
crouch_until_path_to_door(param_00)
{
	param_00 waittill("boosters_off");
	self allowedstances("crouch");
	self waittill("path_to_door");
	self allowedstances("stand","crouch","prone");
}

//Function Number: 76
cqb_test()
{
	level.player endon("end_cqb");
	level.player giveweapon("iw5_m160cqb_sp_cqbreddot");
	level.player giveweapon("iw5_m160_sp_deam160_variablereddot");
	level.player switchtoweaponimmediate("iw5_m160cqb_sp_cqbreddot");
	level.player setstance("crouch");
	thread player_cqb_on();
	level.player notifyonplayercommand("stance_switched","+stance");
	for(;;)
	{
		level.player waittill("stance_switched");
		wait(0.5);
		if(level.player getstance() == "crouch")
		{
			thread player_cqb_on();
			continue;
		}

		thread player_cqb_off();
	}
}

//Function Number: 77
rock_the_boat()
{
	thread boat_rock_check_triggers();
	var_00 = 3;
	for(;;)
	{
		while(level.waves == 1)
		{
			var_01 = getdvar("phys_gravityChangeWakeupRadius");
			setsaveddvar("phys_gravityChangeWakeupRadius",2000);
			level.ground_ref_ent rotateto((-1,0,0),var_00,1,1);
			soundscripts\_snd::snd_message("if_the_boat_is_a_rockin_dont_come_a_knockin","interior");
			wait(3.1);
			level.ground_ref_ent rotateto((-5,0,5),var_00,1,1);
			soundscripts\_snd::snd_message("if_the_boat_is_a_rockin_dont_come_a_knockin","interior");
			wait(3.3);
			setsaveddvar("phys_gravityChangeWakeupRadius",var_01);
		}

		wait(0.05);
	}
}

//Function Number: 78
boat_rock_check_triggers()
{
	thread wait_for_true();
	thread wait_for_true2();
	thread wait_for_true3();
	thread wait_for_true4();
	thread wait_for_true5();
	thread wait_for_false();
	thread wait_for_false2();
	thread wait_for_false3();
	thread wait_for_false4();
	thread wait_for_false5();
	thread wait_for_false6();
}

//Function Number: 79
wait_for_false()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_off");
		level.waves = 0;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 80
wait_for_false2()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_off2");
		level.waves = 0;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 81
wait_for_false3()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_off3");
		level.waves = 0;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 82
wait_for_false4()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_off4");
		level.waves = 0;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 83
wait_for_false5()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_off5");
		level.waves = 0;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 84
wait_for_false6()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_off6");
		level.waves = 0;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 85
wait_for_true()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_on");
		level.waves = 1;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 86
wait_for_true2()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_on2");
		level.waves = 1;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 87
wait_for_true3()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_on3");
		level.waves = 1;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 88
wait_for_true4()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_on4");
		level.waves = 1;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 89
wait_for_true5()
{
	for(;;)
	{
		maps\_utility::trigger_wait_targetname("waves_on5");
		level.waves = 1;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 90
end_cqb()
{
	level.player endon("death");
	maps\_utility::trigger_wait_targetname("trig_spawn_navy_allies_hangar");
	thread player_cqb_off();
	level.player notify("end_cqb");
	level.player takeweapon("iw5_m160cqb_sp_cqbreddot");
	level.player switchtoweaponimmediate("iw5_m160_sp_deam160_variablereddot");
}

//Function Number: 91
player_cqb_on()
{
	level.player notify("cqb_mode_toggled");
	level.player.cqb_mode = 1;
	level.player setmovespeedscale(1.25);
	thread maps\_utility::lerp_fov_overtime(0.15,60);
	if(level.nextgen)
	{
		thread cqb_dof_on();
	}
}

//Function Number: 92
player_cqb_off()
{
	level.player notify("cqb_mode_toggled");
	level.player.cqb_mode = undefined;
	level.player setmovespeedscale(1);
	thread maps\_utility::lerp_fov_overtime(0.15,65);
	if(level.nextgen)
	{
		thread cqb_dof_off();
	}
}

//Function Number: 93
cqb_dof_on()
{
	if(level.nextgen)
	{
		maps\_lighting::create_dof_preset("cqb_dof",10,250,10,3000,9000,3,0.5);
	}
}

//Function Number: 94
cqb_dof_off()
{
	if(level.nextgen)
	{
	}
}

//Function Number: 95
handle_enemy_when_player_is_in_cqb()
{
	self endon("death");
	for(;;)
	{
		level.player waittill("cqb_mode_toggled");
		if(isdefined(level.player.cqb_mode) && level.player.cqb_mode)
		{
			self.moveplaybackrate = 0.8;
			continue;
		}

		self.moveplaybackrate = 1;
	}
}

//Function Number: 96
open_door_anim()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("boosters_off_anim_finished");
	var_00 = common_scripts\utility::getstruct("org_squad_enter_mob","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.cormack,"boosters_off_idle","stop_loop");
	maps\_utility::trigger_wait_targetname("trig_open_initial_door_anim");
	if(level.currentgen)
	{
		thread transient_intro_to_middle();
	}

	var_01 = [level.interior_door,level.cormack];
	level.cormack notify("path_to_door");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_reach_solo(level.cormack,"ripopen_bulkhead");
	level.cormack soundscripts\_snd::snd_message("aud_burke_open_door");
	var_02 = getent("door_open_clip","targetname");
	var_02 linkto(level.interior_door,"doorhinge");
	var_00 thread maps\_anim::anim_single_solo_run(level.cormack,"ripopen_bulkhead");
	maps\_utility::activate_trigger_with_targetname("trig_cormack_move_interior_post_door");
	if(level.currentgen)
	{
		thread maps\_utility::tff_sync(11);
	}

	var_00 maps\_anim::anim_single_solo(level.interior_door,"ripopen_bulkhead");
	soundscripts\_snd::snd_message("interior_door1_done");
	var_03 = getent("interior_exit_clip","targetname");
	var_03 connectpaths();
	var_03 delete();
	var_02 connectpaths();
	maps\_utility::autosave_by_name();
}

//Function Number: 97
transient_intro_to_middle()
{
	level notify("tff_pre_transition_intro_to_outro");
	loadtransient("sanfran_b_outro_tr");
	while(!istransientloaded("sanfran_b_outro_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_transition_intro_to_outro");
	maps\_utility::trigger_wait_targetname("unload_intro_transient");
	unloadtransient("sanfran_b_intro_tr");
	level.interior_door clearanim(level.interior_door maps\_utility::getanim("ripopen_bulkhead"),1);
}

//Function Number: 98
exo_takedown()
{
	maps\_utility::trigger_wait_targetname("trig_squad_move_interior_post_door");
	level.idle_org notify("stop_idle");
	level.burke maps\_utility::anim_stopanimscripted();
	level.maddox maps\_utility::anim_stopanimscripted();
	level.burke notify("door_open");
	level.maddox notify("door_open");
	level.cormack notify("door_open");
	var_00 = common_scripts\utility::getstruct("org_exo_takedown","targetname");
	var_01 = getent("exo_takedown_guy2","targetname");
	var_00 maps\_anim::anim_reach_solo(level.cormack,"exo_takedown");
	var_02 = var_01 maps\_utility::spawn_ai();
	if(isdefined(var_02))
	{
		level.takedownenemy1 = var_02;
		var_02.animname = "guy2";
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
		var_02.ignoresonicaoe = 1;
		var_02 soundscripts\_snd::snd_message("aud_burke_takedown");
		var_03 = [level.cormack,var_02];
		common_scripts\utility::flag_set("exo_takedown_started");
		var_00 maps\_anim::anim_single_run(var_03,"exo_takedown");
	}
	else
	{
		common_scripts\utility::flag_set("exo_takedown_started");
		level.cormack maps\_utility::enable_ai_color_dontmove();
		maps\_utility::activate_trigger_with_targetname("trig_post_exo_takedown_move");
	}

	level.cormack thread hand_signal_to_cafeteria();
	var_03 = getaiarray("allies");
	foreach(var_05 in var_03)
	{
		if(maps\_utility::is_in_array(level.heroes,var_05))
		{
			continue;
		}
		else
		{
			var_05 delete();
		}
	}

	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	thread rock_the_boat();
}

//Function Number: 99
interior_shake_1()
{
	var_00 = getdvar("phys_gravityChangeWakeupRadius");
	setsaveddvar("phys_gravityChangeWakeupRadius",2000);
	maps\_utility::trigger_wait_targetname("trig_interior_shake_1");
	soundscripts\_snd::snd_message("if_the_boat_is_a_rockin_dont_come_a_knockin","interior");
	soundscripts\_snd::snd_message("power_outage_audio");
	level.player playrumbleonentity("heavy_2s");
	earthquake(0.3,2,level.player.origin,1024);
	wait(2.5);
	soundscripts\_snd::snd_message("if_the_boat_is_a_rockin_dont_come_a_knockin","interior");
	level.player playrumbleonentity("heavy_2s");
	earthquake(0.3,2,level.player.origin,1024);
	wait(3);
	setsaveddvar("phys_gravityChangeWakeupRadius",var_00);
}

//Function Number: 100
hangar_jet_flyby()
{
	level.player endon("death");
	maps\_utility::trigger_wait_targetname("trig_hangar_jet_flyby");
	level notify("stop_ship_weapons");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("hangar_jet_flyby_1");
	wait(0.5);
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("hangar_jet_flyby_2");
}

//Function Number: 101
give_night_vision()
{
	level endon("flag_end_sonar_vision");
	level.player setweaponhudiconoverride("actionslot1","dpad_icon_nvg");
	level.player notifyonplayercommand("sonar_vision","+actionslot 1");
	level.player thread thermal_with_nvg();
}

//Function Number: 102
hand_signal_to_cafeteria()
{
	self endon("end_hand_signal_to_caf");
	thread end_hand_signal_to_caf();
	self waittill("goal");
	maps\_utility::trigger_wait_targetname("trig_burke_hand_signal_to_caf");
	maps\_anim::anim_single_solo(self,"signal_moveout_coverL");
	maps\_utility::activate_trigger_with_targetname("trig_move_maddox_past_hand_signal");
	self notify("hand_signal_to_caf_finished");
}

//Function Number: 103
end_hand_signal_to_caf()
{
	self endon("hand_signal_to_caf_finished");
	maps\_utility::trigger_wait_targetname("trig_interior_vo_1");
	self notify("end_hand_signal_to_caf");
	maps\_utility::activate_trigger_with_targetname("trig_move_maddox_past_hand_signal");
}

//Function Number: 104
table_pulldown()
{
	maps\_utility::trigger_wait_targetname("trig_spawn_table_guy");
	var_00 = getent("table_pulldown_guy","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "guy";
	var_01.allowdeath = 1;
	var_01 endon("death");
	var_02 = maps\_utility::spawn_anim_model("cafeteria_table");
	var_03 = [var_01,var_02];
	var_04 = common_scripts\utility::getstruct("org_table_pulldown","targetname");
	if(isdefined(var_01) && isalive(var_01))
	{
		var_04 maps\_anim::anim_first_frame(var_03,"table_pulldown");
		common_scripts\utility::flag_wait("start_table_anim");
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01.allowdeath = 0;
			var_02 soundscripts\_snd::snd_message("aud_table_pulldown");
			var_04 maps\_anim::anim_single(var_03,"table_pulldown");
			var_01.allowdeath = 1;
			var_04 thread maps\_anim::anim_loop_solo(var_01,"table_pulldown_fire_loop");
			var_01 thread table_pulldown_distance_check();
			var_01 maps\_utility::set_deathanim("table_pullddown_death");
		}
	}
}

//Function Number: 105
table_pulldown_distance_check()
{
	self endon("death");
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < 250000)
		{
			self kill();
			return;
		}

		wait(0.1);
	}
}

//Function Number: 106
cafeteria_reinforcements()
{
	level endon("cafeteria_reinforcement_spawn");
	common_scripts\utility::flag_wait("start_table_anim");
	disable_cormack_obj();
	for(;;)
	{
		var_00 = getaicount("axis");
		if(var_00 > 4)
		{
			wait(0.05);
			continue;
		}

		maps\_utility::array_spawn_targetname("cafeteria_reinforcements",0,1);
		break;
	}

	thread cafeteria_squad_pressure();
}

//Function Number: 107
cafeteria_squad_pressure()
{
	var_00 = getaicount("axis");
	var_01 = 0;
	while(var_01 == 0)
	{
		var_02 = getaicount("axis");
		var_03 = getnode("red6ix","targetname");
		var_04 = getnode("macros","targetname");
		var_05 = level.cormack;
		if(var_00 <= 4)
		{
			level.burke maps\_utility::set_goal_node(var_04);
			level.cormack maps\_utility::set_goal_node(var_03);
			var_01 = 1;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 108
end_squad_cqb()
{
	maps\_utility::trigger_wait_targetname("trig_interior_vo_1");
	thread maps\_utility::blend_movespeedscale(1,3);
	foreach(var_01 in level.heroes)
	{
		var_01 maps\_utility::disable_cqbwalk();
	}
}

//Function Number: 109
move_to_hangar()
{
	maps\_utility::trigger_wait_targetname("trig_interior_vo_3");
	common_scripts\utility::flag_set("player_exit_cafeteria");
	maps\_utility::trigger_wait_targetname("trig_cleanup_cafe");
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		var_02 maps\sanfran_b_util::bloody_death();
		wait(0.4);
	}
}

//Function Number: 110
hand_signal_to_hangar()
{
	level.cormack endon("end_hand_signal_to_hangar");
	level.cormack thread end_hand_signal_to_hangar();
	maps\_utility::trigger_wait_targetname("trig_interior_vo_2");
	thread enable_cormack_obj();
	level.cormack waittill("goal");
	maps\_utility::trigger_wait_targetname("trig_interior_vo_3");
	thread maps\sanfran_b_util::hanger_bad_path();
	level.cormack maps\_anim::anim_single_solo(level.cormack,"signal_moveout_coverL");
	level.cormack notify("hand_signal_to_hangar_finished");
	maps\_utility::activate_trigger_with_targetname("trig_caf_to_hangar");
	common_scripts\utility::flag_set("flag_obj_leave_cafeteria");
}

//Function Number: 111
end_hand_signal_to_hangar()
{
	level.cormack endon("hand_signal_to_hangar_finished");
	maps\_utility::trigger_wait_targetname("trig_initial_hangar_fight");
	level.cormack notify("end_hand_signal_to_hangar");
	maps\_utility::activate_trigger_with_targetname("trig_caf_to_hangar");
	common_scripts\utility::flag_set("flag_obj_leave_cafeteria");
}

//Function Number: 112
get_fov_for_player(param_00)
{
	var_01 = getdvarint("cg_fov");
	var_02 = getdvarfloat("cg_playerFovScale0");
	if(isdefined(level.player2) && param_00 == level.player2)
	{
		var_02 = getdvarfloat("cg_playerFovScale1");
	}

	return var_01 * var_02;
}

//Function Number: 113
mark_enemies()
{
	level.player endon("sonar_vision_off");
	for(;;)
	{
		foreach(var_01 in getaiarray("axis"))
		{
			var_01 hudoutlineenable(1,1,0);
			var_01.hudoutlineenabledbysonarvision = 1;
		}

		foreach(var_04 in getaiarray("allies"))
		{
			var_04 hudoutlineenable(2,1,0);
			var_04.hudoutlineenabledbysonarvision = 1;
		}

		wait(0.1);
	}
}

//Function Number: 114
is_sonar_vision_allowed()
{
	var_00 = level.player getcurrentweapon();
	if(weaponhasthermalscope(var_00) && level.player playerads() > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 115
disable_sonar_when_not_allowed()
{
	level.player endon("sonar_vision_off");
	for(;;)
	{
		if(!is_sonar_vision_allowed())
		{
			break;
		}

		wait 0.05;
	}

	sonar_off();
}

//Function Number: 116
thermal_with_nvg()
{
	level endon("flag_end_sonar_vision");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	for(;;)
	{
		self waittill("sonar_vision");
		if(!is_sonar_vision_allowed())
		{
			continue;
		}

		if(!isdefined(level.player.sonar_vision) || !level.player.sonar_vision)
		{
			sonar_on();
			childthread disable_sonar_when_not_allowed();
			continue;
		}

		sonar_off();
	}
}

//Function Number: 117
sonar_save_and_set_dvars()
{
	if(!isdefined(level.player.sonarvisionsaveddvars))
	{
		level.player.sonarvisionsaveddvars = [];
	}

	level.player.sonarvisionsaveddvars["r_hudoutlineenable"] = getdvarint("r_hudoutlineenable",1);
	level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] = getdvar("r_hudoutlinepostmode",0);
	level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] = getdvarfloat("r_hudoutlinehaloblurradius",1);
	level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] = getdvarfloat("r_hudoutlinehalolumscale",1);
	level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] = getdvar("r_hudoutlinehalowhen",1);
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehaloblurradius",0.7);
	setsaveddvar("r_hudoutlinehalolumscale",2);
	setsaveddvar("r_hudoutlinehalowhen",0);
	level.player.sonarvisionsaveddvars["r_ssrBlendScale"] = getdvarfloat("r_ssrBlendScale",1);
	setsaveddvar("r_ssrBlendScale",0);
}

//Function Number: 118
sonar_reset_dvars()
{
	if(isdefined(level.player.sonarvisionsaveddvars))
	{
		setsaveddvar("r_hudoutlineenable",level.player.sonarvisionsaveddvars["r_hudoutlineenable"]);
		setsaveddvar("r_hudoutlinepostmode",level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"]);
		setsaveddvar("r_hudoutlinehaloblurradius",level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"]);
		setsaveddvar("r_hudoutlinehalolumscale",level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"]);
		setsaveddvar("r_hudoutlinehalowhen",level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"]);
		setsaveddvar("r_ssrBlendScale",level.player.sonarvisionsaveddvars["r_ssrBlendScale"]);
	}
}

//Function Number: 119
sonar_on()
{
	level.overlaysonar = create_hud_sonar_overlay(0,1);
	sonar_save_and_set_dvars();
	thread mark_enemies();
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0;
	}

	level.player lightsetoverrideenableforplayer("sanfran_b_sonar_vision",var_00);
	level.player setclutoverrideenableforplayer("clut_sonar",var_00);
	soundscripts\_snd::snd_message("aud_sonar_vision_on");
	level.player.sonar_vision = 1;
	level notify("sonar_update");
}

//Function Number: 120
sonar_off()
{
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0;
	}

	level.player lightsetoverrideenableforplayer(var_00);
	level.player setclutoverridedisableforplayer(var_00);
	soundscripts\_snd::snd_message("aud_sonar_vision_off");
	level.player.sonar_vision = 0;
	level notify("sonar_update");
	if(isdefined(level.overlay))
	{
		level.overlay destroy();
	}

	if(isdefined(level.overlaythreat))
	{
		level.overlaythreat destroy();
	}

	if(isdefined(level.overlaysonar))
	{
		level.overlaysonar destroy();
	}

	sonar_reset_dvars();
	foreach(var_02 in getaiarray("axis","allies"))
	{
		if(isdefined(var_02.hudoutlineenabledbysonarvision))
		{
			var_02 hudoutlinedisable();
			var_02.hudoutlineenabledbysonarvision = undefined;
		}
	}

	level.player notify("sonar_vision_off");
}

//Function Number: 121
create_hud_nvg_overlay(param_00,param_01,param_02)
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

//Function Number: 122
create_hud_sonar_overlay(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = 0;
	if(level.currentgen)
	{
		var_02.color = (1,0.6,0.2);
	}
	else
	{
		var_02.color = (0.1,0.1,1);
	}

	var_02.sort = param_00;
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02.alpha = param_01;
	var_02 setsonarvision(10);
	return var_02;
}

//Function Number: 123
create_hud_threat_overlay(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = 0;
	var_02.color = (1,0.1,0.1);
	var_02.sort = param_00;
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02.alpha = param_01;
	var_02 setradarhighlight(-1);
	return var_02;
}

//Function Number: 124
boat_rocking_hangar()
{
	maps\_utility::trigger_wait_targetname("trig_boat_rock_to_hangar");
	thread maps\sanfran_b_lighting::lerp_sun_01();
	var_00 = getdvar("phys_gravityChangeWakeupRadius");
	setsaveddvar("phys_gravityChangeWakeupRadius",2000);
	level.player playrumbleonentity("heavy_2s");
	earthquake(0.3,2,level.player.origin,1024);
	soundscripts\_snd::snd_message("pre_hangar_hall_explosion");
	wait(2.5);
	level.player playrumbleonentity("heavy_2s");
	earthquake(0.3,2,level.player.origin,1024);
	soundscripts\_snd::snd_message("pre_hangar_hall_explosion");
	wait(3);
	setsaveddvar("phys_gravityChangeWakeupRadius",var_00);
}

//Function Number: 125
boat_rocking_jet_moment()
{
}

//Function Number: 126
jet_moment(param_00,param_01,param_02)
{
	param_01 thread jet_badplace();
	param_00 maps\_anim::anim_single_solo(param_01,"shrike_slide");
	param_02 connectpaths();
	param_02 delete();
}

//Function Number: 127
jet_badplace()
{
	thread maps\_vehicle_code::disconnect_paths_whenstopped();
}

//Function Number: 128
ambient_hangar()
{
	common_scripts\utility::flag_wait("trig_hangar_vo_1");
	wait(3);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("hangar_ambient_shrike");
	var_00 soundscripts\_snd::snd_message("shrike_hanger_flyby");
	wait(1);
	var_01 = getentarray("hangar_ambient_drone_swarm","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_03.targetname);
		var_04 maps\_utility::ent_flag_set("fire_disabled");
	}
}

//Function Number: 129
initial_hangar_setup()
{
	level.player endon("death");
	maps\_utility::trigger_wait_targetname("trig_initial_hangar_fight");
	maps\_utility::array_spawn_noteworthy("initial_hangar_enemies");
	maps\_utility::disable_trigger_with_targetname("cine_copter_trigger");
}

//Function Number: 130
initial_hangar_guys_invuln()
{
	self endon("death");
	maps\_utility::magic_bullet_shield();
	maps\_utility::trigger_wait_targetname("trig_spawn_navy_allies_hangar");
	wait(randomfloatrange(0.5,1.5));
	maps\_utility::stop_magic_bullet_shield();
	if(self.team == "allies")
	{
		wait(randomfloatrange(2,7));
		maps\sanfran_b_util::bloody_death();
	}
}

//Function Number: 131
hangar_combat()
{
	level.player endon("death");
	maps\_utility::trigger_wait_targetname("trig_spawn_navy_allies_hangar");
	level.burke maps\_utility::disable_cqbwalk();
	level.cormack maps\_utility::disable_cqbwalk();
	level.maddox maps\_utility::disable_cqbwalk();
	var_00 = getent("refl_probe_heli_open","targetname");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mi17_hangar_1");
	var_01 soundscripts\_snd::snd_message("warbird_hanger_dropoff");
	var_01 setmaxpitchroll(25,60);
	var_01 overridereflectionprobe(var_00.origin);
	var_01 thread maps\sanfran_b_util::warbird_shooting_think(1);
	var_01 maps\_vehicle::godon();
	var_01 thread hangar_heli_wait_for_unload("hangar_fastzip_1");
	var_01 thread hangar_heli_wait_for_death("hangar_fastzip_1");
	thread hanger_warbird_clip_think("hangar_fastzip_1");
	waittillframeend;
	var_01 thread hanger_warbird_think();
	var_01 notify("warbird_fire");
	var_01 vehicle_removebrushmodelcollision();
	common_scripts\utility::flag_wait("hangar_fastzip_1");
	var_01 notify("warbird_stop_firing");
	maps\_utility::trigger_wait_targetname("trig_move_to_hangar_exit_door");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("littlebird_overwatch");
	var_02 soundscripts\_snd::snd_message("littlebird_hanger_flyby");
	var_02.ignoreme = 1;
	var_02 maps\_vehicle::godon();
	foreach(var_04 in var_02.riders)
	{
		var_04.ignoreme = 1;
		if(isalive(var_04))
		{
			var_04 maps\_utility::deletable_magic_bullet_shield();
		}

		if(var_04.vehicle_position == 6 || var_04.vehicle_position == 5)
		{
			var_04 laseron();
		}
	}
}

//Function Number: 132
hanger_warbird_clip_think(param_00)
{
	var_01 = getent("hanger_warbird_clip","targetname");
	common_scripts\utility::flag_wait(param_00);
	wait(2);
	var_01 notsolid();
}

//Function Number: 133
hanger_warbird_think()
{
	foreach(var_01 in self.riders)
	{
		if(var_01.vehicle_position == 0)
		{
			var_01 maps\_utility::gun_remove();
		}
	}
}

//Function Number: 134
hangar_heli_wait_for_unload(param_00)
{
	self endon("death");
	self waittill("unloaded");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 135
hangar_heli_wait_for_death(param_00)
{
	self endon("unloaded");
	self waittill("death");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 136
hangar_combat_reinforcements()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("hangar_fastzip_1");
	maps\sanfran_b_util::wait_for_number_enemies_alive(3);
	common_scripts\utility::flag_set("hangar_reinforcements");
	var_00 = getent("hangar_door_left","targetname");
	var_01 = getent("clip_hangar_door_left","targetname");
	var_02 = common_scripts\utility::getstruct("org_hangar_door_close_left","targetname");
	var_03 = getent("hangar_door_right","targetname");
	var_04 = getent("clip_hangar_door_right","targetname");
	var_05 = common_scripts\utility::getstruct("org_hangar_door_close_right","targetname");
	var_06 = 4;
	var_07 = [var_00,var_03];
	var_08 = var_03.origin;
	soundscripts\_snd::snd_message("hangar_doors_open",var_07,var_06,var_08);
	var_00 moveto(var_02.origin,var_06,0.05,0.15);
	var_01 moveto(var_02.origin,var_06,0.05,0.15);
	var_03 moveto(var_05.origin,var_06,0.05,0.15);
	var_04 moveto(var_05.origin,var_06,0.05,0.15);
	maps\_utility::activate_trigger_with_targetname("trig_move_allies_for_hangar_reinforcements");
	maps\_utility::array_spawn_noteworthy("hangar_enemy_reinforcements_1",1,1);
	var_09 = getent("hangar_enemy_reinforcements_1_mech","script_noteworthy") maps\_utility::spawn_ai(1);
	var_09 thread hanger_mech_think();
	level notify("hangar_reinforcements_spawned");
	maps\_utility::enable_trigger_with_targetname("cine_copter_trigger");
	wait(2);
	var_01 connectpaths();
	var_04 connectpaths();
	wait(5);
	common_scripts\utility::flag_set("ast_vo");
}

//Function Number: 137
hanger_mech_think()
{
	self endon("death");
	maps\_mech::mech_start_reduced_nonplayer_damage();
	self setgoalentity(level.player);
	self.favoriteenemy = level.player;
	createthreatbiasgroup("player");
	createthreatbiasgroup("mech");
	level.player setthreatbiasgroup("player");
	self setthreatbiasgroup("mech");
	setthreatbias("player","mech",900000);
	maps\_mech::mech_start_rockets();
	maps\_mech::mech_start_hunting();
}

//Function Number: 138
wait_for_mech_distance()
{
	self endon("death");
	var_00 = getent("obj_defend_01","targetname");
	var_01 = 600;
	var_02 = var_01 * var_01;
	while(distancesquared(self.origin,var_00.origin) < var_02)
	{
		wait(0.1);
	}
}

//Function Number: 139
hangar_exit_door()
{
	level.player endon("death");
	var_00 = common_scripts\utility::getstruct("org_hangar_exit_door","targetname");
	var_01 = maps\_utility::spawn_anim_model("hangar_exit_door");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"hangar_exit");
	level waittill("hangar_reinforcements_spawned");
	maps\sanfran_b_util::wait_for_number_enemies_alive(2);
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		wait(randomfloatrange(0.25,1.25));
		var_04 thread maps\_utility::player_seek_enable();
	}

	maps\sanfran_b_util::wait_for_number_enemies_alive(0);
	maps\_utility::activate_trigger_with_targetname("trig_move_to_hangar_exit_door");
	common_scripts\utility::flag_set("flag_obj_leave_hanger");
	maps\_utility::trigger_wait_targetname("trig_cormack_to_hangar_door");
	var_02 = [var_01,level.burke];
	var_00 maps\_anim::anim_reach_solo(level.burke,"hangar_exit");
	var_01 soundscripts\_snd::snd_message("aud_hangar_door_exit");
	thread send_cormack();
	var_00 maps\_anim::anim_single(var_02,"hangar_exit");
	level.cormack maps\_utility::enable_ai_color_dontmove();
	level.cormack maps\_utility::enable_sprint();
	maps\_utility::activate_trigger_with_targetname("trig_post_hangar_move");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
}

//Function Number: 140
send_cormack()
{
	wait(3.24);
	var_00 = getent("hangar_door_clip","targetname");
	var_00 connectpaths();
	var_00 delete();
	maps\_utility::activate_trigger_with_targetname("cormack_move_fast");
	common_scripts\utility::flag_set("through_door_vo");
}

//Function Number: 141
hand_signal_after_hangar()
{
	maps\_utility::trigger_wait_targetname("cormack_move_fast");
	wait(1.5);
	level.maddox.goalradius = 8;
	var_00 = getnode("maddoxnode","targetname");
	level.maddox maps\_utility::set_goal_node(var_00);
	level.maddox waittill("goal");
	wait(2.4);
	level.maddox maps\_anim::anim_single_solo(level.maddox,"signal_moveout_coverL");
	wait(0.1);
	level.maddox.goalradius = 1024;
	level.maddox maps\_utility::enable_ai_color_dontmove();
	maps\_utility::activate_trigger_with_targetname("maddox_move");
}

//Function Number: 142
sf_b_videolog()
{
	common_scripts\utility::flag_wait("trig_hangar_ambient_naval_combat");
	maps\_shg_utility::play_videolog("sanfran_b_videolog","screen_add");
}

//Function Number: 143
door_takedown_door()
{
	var_00 = maps\_utility::spawn_anim_model("takedown_door");
	var_01 = common_scripts\utility::getstruct("org_bulkhead_takedown","targetname");
	level.takedown_door = var_00;
	var_01 maps\_anim::anim_first_frame_solo(var_00,"door_takedown");
}

//Function Number: 144
ambient_combat()
{
	level.player endon("death");
	thread maps\sanfran_b_lighting::play_flickering_info_hallway_light();
	common_scripts\utility::flag_wait("trig_hangar_ambient_naval_combat");
}

//Function Number: 145
delete_hangar_allies_on_goal()
{
	if(!isdefined(self.script_parameters))
	{
		return;
	}

	if(self.script_parameters == "delete_on_goal")
	{
		self endon("death");
		self waittill("goal");
		self delete();
	}
}

//Function Number: 146
destroy_cine_helicopter()
{
	var_00 = getent("missile_launcher_special","targetname");
	var_00.missle_starts = getentarray(var_00.target,"targetname");
	foreach(var_02 in var_00.missle_starts)
	{
		var_02 linkto(var_00);
	}

	thread beginning_idle_cine_turret();
	common_scripts\utility::flag_wait("DestroyCineCopter");
	level.spawncopter = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("CineWarbird");
	level.spawncopter soundscripts\_snd::snd_message("warbird_flyover_shootdown");
	wait(2);
	var_00 thread turret_targeting();
	wait(1.5);
	shootcineturrets();
}

//Function Number: 147
turret_targeting()
{
	level endon("stop_ship_weapons");
	while(isdefined(level.spawncopter))
	{
		var_00 = vectornormalize(level.spawncopter.origin - self.origin);
		var_01 = anglestoforward(self.angles);
		var_02 = vectortoangles(var_00);
		var_03 = vectortoangles(var_01);
		if(var_03[1] > var_02[1])
		{
			var_04 = var_03[1] - var_02[1];
			maps\_utility::_rotateyaw(var_03[1] - var_02[1] * -1,0.5,0.05,0.05);
			continue;
		}

		if(var_03[1] < var_02[1])
		{
			var_04 = var_02[1] - var_03[1];
			maps\_utility::_rotateyaw(var_02[1] - var_03[1],0.5,0.05,0.05);
			continue;
		}

		wait(0.05);
		wait(0.05);
	}

	var_05 = common_scripts\utility::getstruct("helicopter_crash_location","targetname");
	earthquake(0.5,1.5,level.player.origin,1024);
	level.player playrumbleonentity("heavy_2s");
	start_idle_shooting();
}

//Function Number: 148
shootcineturrets()
{
	var_00 = getent("missile_launcher_special","targetname");
	var_00.missle_starts = getentarray(var_00.target,"targetname");
	foreach(var_02 in var_00.missle_starts)
	{
		var_03 = magicbullet("mob_missile",var_02.origin,level.spawncopter.origin);
		var_03 missile_settargetent(level.spawncopter);
		wait(0.05);
	}

	earthquake(0.3,1.5,level.player.origin,1024);
	level.player playrumbleonentity("heavy_2s");
}

//Function Number: 149
start_idle_shooting()
{
	level endon("stop_ship_weapons");
	var_00 = getent("missile_launcher_special","targetname");
	var_00.missle_starts = getentarray(var_00.target,"targetname");
	for(;;)
	{
		var_00 rotateto((0,randomintrange(180,360),0),1.5,0.25,0.25);
		wait(1.5);
		foreach(var_02 in var_00.missle_starts)
		{
			var_03 = anglestoforward(var_02.angles);
			var_03 = var_03 * 5000;
			var_03 = var_03 + (randomintrange(500,1000),randomintrange(500,1000),randomintrange(1000,2000));
			magicbullet("mob_missile",var_02.origin,var_02.origin + var_03);
		}

		wait(randomfloatrange(10,20));
	}
}

//Function Number: 150
beginning_idle_cine_turret()
{
	level endon("DestroyCineCopter");
	var_00 = getent("missile_launcher_special","targetname");
	var_00.missle_starts = getentarray(var_00.target,"targetname");
	for(;;)
	{
		var_00 rotateto((0,randomintrange(180,360),0),1.5,0.25,0.25);
		wait(1.5);
		foreach(var_02 in var_00.missle_starts)
		{
			var_03 = anglestoforward(var_02.angles);
			var_03 = var_03 * 5000;
			var_03 = var_03 + (randomintrange(500,1000),randomintrange(500,1000),randomintrange(1000,2000));
			magicbullet("mob_missile",var_02.origin,var_02.origin + var_03);
		}

		wait(randomfloatrange(10,20));
	}
}

//Function Number: 151
door_takedown()
{
	common_scripts\utility::flag_wait("flag_door_takedown");
	var_00 = getent("door_takedown_corner_clip","targetname");
	var_01 = getent("door_takedown_initial_clip","targetname");
	var_01 linkto(level.takedown_door,"doorhinge");
	var_02 = common_scripts\utility::getstruct("org_bulkhead_takedown","targetname");
	var_03 = getent("door_takedown_guy2","targetname");
	if(level.currentgen)
	{
		loadtransient("sanfran_b_intro_tr");
	}

	if(common_scripts\utility::flag("flag_door_takedown_cormack_ahead") == 1)
	{
		level.cormack maps\_utility::disable_sprint();
		level.cormack.moveplaybackrate = 1.1;
		level.cormack maps\_utility::place_weapon_on(level.cormack.primaryweapon,"chest");
		var_02 maps\_anim::anim_reach_solo(level.cormack,"door_takedown");
		level.cormack soundscripts\_snd::snd_message("aud_door_takedown_mix_handler");
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_04 thread maps\_utility::deletable_magic_bullet_shield();
		var_04.animname = "guy";
		var_04.ignoreme = 1;
		var_04.ignoreall = 1;
		var_04.ignoresonicaoe = 1;
		var_04 disableaimassist();
		var_04 soundscripts\_snd::snd_message("aud_door_takedown_scream");
		var_05 = [level.takedown_door,var_04];
		var_02 thread maps\_anim::anim_single_solo_run(level.cormack,"door_takedown");
		maps\_utility::activate_trigger_with_targetname("trig_move_cormack_after_takedown");
		var_02 maps\_anim::anim_single(var_05,"door_takedown");
		var_04 maps\_utility::stop_magic_bullet_shield();
		var_04 kill();
		var_04 startragdoll();
		var_01 connectpaths();
		var_00 connectpaths();
		var_00 delete();
		level.cormack thread maps\_utility::place_weapon_on(level.cormack.primaryweapon,"right");
		level.cormack.moveplaybackrate = 1;
		level.cormack maps\sanfran_b_util::disable_awareness();
		maps\_utility::activate_trigger_with_targetname("trig_information_center_vo_1");
		common_scripts\utility::flag_set("flag_information_center_vo_1");
		common_scripts\utility::flag_wait("CormackSafe");
		level.cormack maps\sanfran_b_util::enable_awareness();
		maps\_utility::battlechatter_on("allies");
		maps\_utility::battlechatter_on("axis");
		return;
	}

	var_04 = var_05 maps\_utility::spawn_ai(1);
	var_05.animname = "guy";
	var_05.ignoreme = 1;
	var_05.ignoresonicaoe = 1;
	var_05 thread enemy_door_ambush_monitor_health();
	var_05 = [level.takedown_door,var_05];
	var_02 maps\_anim::anim_single(var_05,"door_ambush");
	var_04.ignoreme = 0;
	var_01 connectpaths();
	var_00 connectpaths();
	var_00 delete();
	level waittill("surprise_enemy_dead");
	maps\_utility::activate_trigger_with_targetname("trig_move_cormack_after_takedown");
	maps\_utility::activate_trigger_with_targetname("trig_information_center_vo_1");
	common_scripts\utility::flag_set("flag_information_center_vo_1");
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
}

//Function Number: 152
enemy_door_ambush_monitor_health()
{
	self waittill("death");
	level notify("surprise_enemy_dead");
}

//Function Number: 153
player_entering_server_room()
{
	common_scripts\utility::flag_wait("entering_server_room");
	common_scripts\utility::flag_clear("sonar_threat_detection_off");
	soundscripts\_snd::snd_message("enter_server_room");
}

//Function Number: 154
information_center_combat()
{
	maps\_utility::trigger_wait_targetname("trig_initial_information_center_combat");
	level.burke maps\_utility::disable_cqbwalk();
	level.cormack maps\_utility::disable_cqbwalk();
	level.maddox maps\_utility::disable_cqbwalk();
	common_scripts\utility::flag_wait("BeginCheckingForLos");
	var_00 = getentarray("toplevelambush_ai","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread player_los_check();
	}

	thread information_center_enemies_charge();
	common_scripts\utility::flag_wait_either("information_center_cleared","information_center_enemies_killed");
	common_scripts\utility::flag_set("flag_bridge");
	soundscripts\_snd::snd_message("enter_bridge");
	thread maps\sanfran_b_lighting::play_flickering_info_light();
	thread maps\sanfran_b_lighting::play_flickering_info_hallway_light();
	thread maps\sanfran_b_lighting::lerp_sun_02();
}

//Function Number: 155
information_center_enemies_charge()
{
	level endon("information_center_cleared");
	var_00 = getaiarray("axis");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	while(var_00.size > 2)
	{
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		wait 0.05;
	}

	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 thread maps\_utility::player_seek_enable();
		}
	}
}

//Function Number: 156
spawn_last_two_guys()
{
	level endon("dontspawntroops");
	common_scripts\utility::flag_wait("information_center_enemies_killed");
	common_scripts\utility::flag_wait("toptouched");
	var_00 = getent("lasttroop1","targetname") maps\_utility::spawn_ai();
	var_01 = getent("lasttroop2","targetname") maps\_utility::spawn_ai();
}

//Function Number: 157
player_los_check()
{
	self endon("Death");
	for(;;)
	{
		if(self cansee(level.player))
		{
			wait(0.05);
			continue;
		}

		self findshufflecovernode();
		wait(0.05);
	}
}

//Function Number: 158
straighten_ship()
{
	level.ground_ref_ent rotatepitch(5,2);
	soundscripts\_snd::snd_message("if_the_boat_is_a_rockin_dont_come_a_knockin","interior");
	wait(2);
	level.ground_ref_ent rotateroll(-7,2);
	soundscripts\_snd::snd_message("if_the_boat_is_a_rockin_dont_come_a_knockin","interior");
}

//Function Number: 159
delete_specific_navy_ships()
{
	var_00 = getentarray("navy_ship","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_parameters) && var_02.script_parameters == "delete_on_bridge")
		{
			var_02 delete();
		}
	}
}

//Function Number: 160
move_squad_to_bridge()
{
	maps\_utility::activate_trigger_with_targetname("trig_move_squad_to_bridge");
	wait(0.05);
	maps\_utility::autosave_by_name();
	foreach(var_01 in level.heroes)
	{
		var_01.baseaccuracy = var_01.baseaccuracy * 10;
	}
}

//Function Number: 161
console_guy()
{
	soundscripts\_snd::snd_message("cormack_shoots_bridge_guy");
	maps\_utility::trigger_wait_targetname("trig_spawn_console_guy");
	common_scripts\_exploder::exploder(5234);
	thread maps\_shg_fx::vfx_sunflare("sanfran_sunflare_a");
	foreach(var_01 in level.heroes)
	{
		var_01 maps\sanfran_b_util::disable_awareness_limited();
	}

	level notify("console_guy_spawn");
	var_01 = getent("console_guy","targetname") maps\_utility::spawn_ai(1);
	var_01.animname = "guy";
	var_01 maps\_utility::battlechatter_off();
	var_01.allowdeath = 0;
	var_01 thread maps\_utility::deletable_magic_bullet_shield();
	var_01.ignoresonicaoe = 1;
	level.console_guy = var_01;
	var_03 = common_scripts\utility::getstruct("org_burke_control_room","targetname");
	var_03 thread maps\_anim::anim_loop_solo(var_01,"guy_control_idle","stop_console_loop");
	maps\_utility::trigger_wait_targetname("trig_console_guy_react");
	var_03 notify("stop_console_loop");
	var_01 maps\_utility::anim_stopanimscripted();
	var_01 thread play_blood_fx_when_shot();
	var_03 maps\_anim::anim_single_solo(var_01,"guy_control_to_fire");
	var_01 allowedstances("stand");
	var_01.goalradius = 4;
	var_01 maps\_utility::set_goal_pos(var_01.origin);
	var_01.dontmelee = 1;
	var_01.ignoresuppression = 1;
	var_01.suppressionwait_old = self.suppressionwait;
	var_01.suppressionwait = 0;
	var_01 maps\_utility::disable_surprise();
	var_01.ignorerandombulletdamage = 1;
	var_01 maps\_utility::disable_bulletwhizbyreaction();
	var_01 maps\_utility::disable_pain();
	var_01.grenadeawareness = 0;
	var_01.disablefriendlyfirereaction = 1;
	var_01.dodangerreact = 0;
	var_01 waittill("damage");
	var_01 notify("stop_console_guy_impact_fx");
	var_01.ignoreme = 1;
	var_01.ignoreall = 1;
	var_01 disableaimassist();
	var_01 maps\_utility::pretend_to_be_dead();
	var_03 maps\_anim::anim_single_solo(var_01,"guy_control_react");
	level notify("console_guy_dead");
	var_03 thread maps\_anim::anim_loop_solo(var_01,"guy_control_shot_idle","stop_shot_idle_loop");
	var_04 = var_01 setcontents(0);
	maps\_utility::activate_trigger_with_targetname("trig_control_room_anims");
	common_scripts\utility::flag_set("bridge_drones_dead");
	level.consoleguy = var_01;
}

//Function Number: 162
play_blood_fx_when_shot()
{
	self endon("stop_console_guy_impact_fx");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		playfx(common_scripts\utility::getfx("flesh_hit"),var_03);
		wait(0.05);
	}

	wait(2);
}

//Function Number: 163
control_room_anims()
{
	maps\_utility::trigger_wait_targetname("trig_control_room_anims");
	foreach(var_01 in level.heroes)
	{
		var_01 thread maps\sanfran_b_util::hide_friendname_until_flag_or_notify("forever");
	}

	var_03 = common_scripts\utility::getstruct("org_burke_control_room","targetname");
	var_03 maps\_anim::anim_reach_solo(level.cormack,"control_room_pulloff");
	var_03 notify("stop_shot_idle_loop");
	level.console_guy maps\_utility::anim_stopanimscripted();
	var_04 = [level.cormack,level.console_guy];
	common_scripts\utility::flag_set("pulloff_anim_started");
	thread maps\_utility::flag_set_delayed("target_vo",4);
	var_03 maps\_anim::anim_single(var_04,"control_room_pulloff");
	common_scripts\utility::flag_set("cormack_on_console");
	soundscripts\_snd::snd_message("objective_complete");
	var_05 = getent("objective_console","targetname");
	var_06 = getent("console_04a","targetname");
	var_07 = spawn("script_model",var_05.origin);
	var_07.angles = var_05.angles;
	var_07 setmodel("mob_bridge_console_04b_obj");
	var_08 = spawn("script_model",var_06.origin);
	var_08.angles = var_06.angles;
	var_08 setmodel("mob_bridge_console_04a_obj");
	var_03 thread maps\_anim::anim_loop_solo(level.console_guy,"guy_control_dead_idle","never");
	var_03 thread maps\_anim::anim_loop_solo(level.cormack,"console_idle","stop_operate_loop");
	level.player waittill("laser_off");
	clearallcorpses();
	level.consoleguy delete();
	foreach(var_0A in level.heroes)
	{
		var_0A maps\_utility::enable_dontevershoot();
	}

	var_04 = getaiarray("axis");
	foreach(var_0D in var_04)
	{
		if(!isdefined(var_0D.magic_bullet_shield))
		{
			var_0D.diequietly = 1;
			var_0D kill();
		}
	}

	if(isdefined(level.ambient_drones))
	{
		foreach(var_10 in level.ambient_drones)
		{
			if(isdefined(var_10) && isalive(var_10))
			{
				var_10 maps\_vehicle::vehicle_set_health(1);
				var_10 dodamage(99999,var_10.origin);
			}
		}
	}

	soundscripts\_snd::snd_message("rail_gun_done");
	thread maps\_sonicaoe::enablesonicaoe();
	common_scripts\utility::flag_clear("flag_end_sonar_vision");
	give_night_vision();
	var_07 delete();
	var_08 delete();
	var_03 notify("stop_operate_loop");
	level.burke maps\_utility::anim_stopanimscripted();
	var_12 = maps\_utility::spawn_anim_model("player_rig");
	var_03 maps\_anim::anim_first_frame_solo(var_12,"sf_b_bridge_dialog");
	level.player playerlinktodelta(var_12,"tag_player",1,0,0,0,0);
	var_04 = [var_12,level.burke,level.cormack,level.maddox];
	var_03 thread maps\_anim::anim_single(var_04,"sf_b_bridge_dialog");
	var_12 common_scripts\utility::delaycall(1,::hide);
	common_scripts\utility::flag_wait("outro_dialogue_finished");
}

//Function Number: 164
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

//Function Number: 165
setup_mob_turret_targets()
{
	common_scripts\utility::flag_wait("player_using_mob_turret");
	common_scripts\_exploder::exploder(3600);
	var_00 = getent("cargo_ship","targetname");
	var_01 = getent("cargo_ship_2","targetname");
	var_02 = var_00 setcontents(0);
	var_00 setcontents(var_02 | 1);
	var_03 = var_01 setcontents(0);
	var_01 setcontents(var_03 | 1);
	level.mob_turret_targets = [var_00,var_01];
	common_scripts\utility::array_thread(level.mob_turret_targets,::detect_cargo_ship_damage);
	common_scripts\utility::array_thread(level.mob_turret_targets,::detect_cargo_ship_death);
	foreach(var_05 in level.mob_turret_targets)
	{
		var_05 thread remove_from_target_array_on_death();
	}

	thread wait_for_mob_turret_targets_to_be_destroyed();
}

//Function Number: 166
cargo_ship_fights_back()
{
	common_scripts\utility::flag_wait("first_cargo_ship_destroyed");
	wait(2);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("cargo2_to_player_1");
	wait(randomfloatrange(0.3,1.3));
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("cargo2_to_player_2");
	wait(randomfloatrange(0.3,1.3));
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("cargo2_to_player_3");
	wait(randomfloatrange(0.3,1.3));
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("cargo2_to_player_4");
}

//Function Number: 167
detect_cargo_ship_damage()
{
	self endon("death");
	self setcandamage(1);
	var_00 = undefined;
	var_01 = undefined;
	var_02 = 2000;
	var_03 = 3000;
	if(level.currentgen)
	{
		var_02 = var_02 * 0.5;
		var_03 = var_03 * 0.5;
	}

	if(isdefined(self.script_parameters))
	{
		if(self.script_parameters == "1")
		{
			var_00 = 1;
			self.animname = "cargo_ship_1";
			self useanimtree(#animtree);
			thread maps\_anim::anim_loop_solo(self,"cargo_ship_idle_large");
		}

		if(self.script_parameters == "2")
		{
			var_00 = 2;
			self.animname = "cargo_ship_2";
			self useanimtree(#animtree);
			thread maps\_anim::anim_loop_solo(self,"cargo_ship_idle_large");
		}
	}

	var_04 = 0;
	var_05 = undefined;
	while(var_04 < 2)
	{
		self.health = 99999;
		self waittill("damage",var_06,var_07,var_08,var_09,var_0A);
		if((isdefined(var_07) && var_07 == level.player && isdefined(var_09) && isdefined(var_0A)) || var_0A == "projectile")
		{
			physicsexplosionsphere(var_09,2048,1024,var_02);
			wakeupphysicssphere(var_09,8000);
			var_04++;
			if(var_00 == 1)
			{
				var_0B = common_scripts\utility::spawn_tag_origin();
				var_0C = level.mob_turret_right gettagorigin("tag_flash");
				var_0D = level.mob_turret_right gettagorigin("tag_flash1");
				var_0E = anglestoforward(level.mob_turret_right gettagangles("tag_flash"));
				var_0F = anglestoforward(level.mob_turret_right gettagangles("tag_flash1"));
				var_10 = var_0C + var_0E * 20000;
				var_11 = var_0C + var_0F * 20000;
				var_12 = bullettrace(var_0C,var_10,0,level.mob_turret_right,1);
				if(var_12["fraction"] == 1)
				{
					var_12 = bullettrace(var_0D,var_11,0,level.mob_turret_right,1);
				}

				if(isdefined(var_12["entity"]) && var_12["entity"] == self)
				{
					if(isdefined(var_12["position"]))
					{
						var_0B.origin = var_12["position"];
						common_scripts\utility::noself_delaycall(0.6,::physicsexplosionsphere,var_0B.origin,1500,1000,var_03);
					}

					if(isdefined(var_12["normal"]))
					{
						var_13 = vectornormalize(var_12["normal"]);
						var_0B.angles = vectortoangles(var_13);
						playfx(common_scripts\utility::getfx("sfb_cargoship_impact_explosion"),var_0B.origin,var_13 + (180,0,0));
					}

					var_14 = getent("vol_crater_1","targetname");
					if(var_0B istouching(var_14))
					{
						var_0B thread spawn_cargo_crater(self,1);
					}
				}

				thread maps\_anim::anim_single_solo(self,"cargo_ship_hit_react");
				soundscripts\_snd::snd_message("cargo_ship_hit_react",1);
				if(var_04 == 1)
				{
					common_scripts\_exploder::exploder(3200);
				}

				common_scripts\utility::flag_set("first_cargo_ship_damaged");
				continue;
			}

			var_0B = common_scripts\utility::spawn_tag_origin();
			var_0C = level.mob_turret_left gettagorigin("tag_flash");
			var_0D = level.mob_turret_left gettagorigin("tag_flash1");
			var_0E = anglestoforward(level.mob_turret_left gettagangles("tag_flash"));
			var_0F = anglestoforward(level.mob_turret_left gettagangles("tag_flash1"));
			var_10 = var_0F + var_11 * 20000;
			var_11 = var_0E + var_11 * 20000;
			var_12 = bullettrace(var_0D,var_11,0,level.mob_turret_left,1);
			if(var_12["fraction"] == 1)
			{
				var_12 = bullettrace(var_0D,var_11,0,level.mob_turret_left,1);
			}

			if(isdefined(var_12["entity"]) && var_12["entity"] == self)
			{
				if(isdefined(var_12["position"]))
				{
					var_0B.origin = var_12["position"];
					common_scripts\utility::noself_delaycall(0.6,::physicsexplosionsphere,var_0B.origin,1500,1000,var_03);
				}

				if(isdefined(var_12["normal"]))
				{
					var_13 = vectornormalize(var_12["normal"]);
					var_0B.angles = vectortoangles(var_13);
					playfx(common_scripts\utility::getfx("sfb_cargoship_impact_explosion"),var_0B.origin,var_13 - (180,0,0));
				}

				var_14 = getent("vol_crater_2","targetname");
				if(var_0B istouching(var_14))
				{
					var_0B thread spawn_cargo_crater(self,0);
				}
			}

			thread maps\_anim::anim_single_solo(self,"cargo_ship_hit_react");
			soundscripts\_snd::snd_message("cargo_ship_hit_react",2);
			common_scripts\utility::flag_set("second_cargo_ship_damaged");
			if(var_04 == 1)
			{
				common_scripts\_exploder::exploder(3300);
			}
		}
	}

	if(var_00 == 1)
	{
		self notify("ship_destroyed");
		thread cargo_ship_death_fx("cargo_ship_1_death");
		common_scripts\utility::flag_set("first_cargo_ship_destroyed");
	}

	if(var_00 == 2)
	{
		self notify("ship_destroyed");
		thread cargo_ship_death_fx("cargo_ship_2_death");
		common_scripts\utility::flag_set("second_cargo_ship_destroyed");
	}

	thread deleteboat();
}

//Function Number: 168
deleteboat()
{
	wait(16);
	self delete();
}

//Function Number: 169
spawn_cargo_crater(param_00,param_01)
{
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel("vehicle_atlas_cargo_container_dmg_k");
	var_02 linkto(param_00);
	var_02.angles = self.angles;
	if(isdefined(param_01) && param_01)
	{
		self.angles = (0,180,0);
	}

	self linkto(param_00);
	playfxontag(common_scripts\utility::getfx("fire_lp_l_blacksmk_thick_nonlit"),self,"tag_origin");
	param_00 waittill("ship_destroyed");
	wait(2);
	var_02 delete();
	stopfxontag(common_scripts\utility::getfx("fire_lp_l_blacksmk_thick_nonlit"),self,"tag_origin");
}

//Function Number: 170
cargo_ship_rocking(param_00,param_01)
{
	if(isdefined(self.rocking) && self.rocking)
	{
		return;
	}

	self endon("death");
	var_02 = 0;
	if(isdefined(param_01) && param_01)
	{
		self moveto(self.origin + (0,0,-256),2);
	}

	var_03 = 3;
	while(isdefined(self))
	{
		self rotateroll(param_00,var_03,0.05,0.05);
		wait(var_03);
		self rotateroll(param_00 * -1,var_03,0.15,1.5);
		if(isdefined(param_01) && param_01 && !var_02)
		{
			self moveto(self.origin + (0,0,256),4);
			var_02 = 1;
		}

		wait(var_03);
	}
}

//Function Number: 171
cargo_ship_death_fx(param_00)
{
	maps\_utility::delaythread(2.15,::ship_explosion_rumble,0.35);
	maps\_utility::delaythread(2.15,::ship_explosion_screenblur);
	maps\_utility::delaythread(2.4,::ship_explosion_rumble,0.35);
	maps\_utility::delaythread(2.9,::ship_explosion_rumble,0.35);
	maps\_utility::delaythread(4.25,::ship_explosion_rumble,0.2);
	maps\_utility::delaythread(4.9,::ship_explosion_rumble,0.3);
}

//Function Number: 172
ship_explosion_rumble(param_00)
{
	level.player playrumbleonentity("heavy_2s");
	earthquake(param_00,1.75,level.player.origin,1024);
}

//Function Number: 173
ship_explosion_screenblur()
{
	wait(0.15);
	setblur(1,0.01);
	wait(0.05);
	setblur(0,0.05);
}

//Function Number: 174
detect_cargo_ship_death()
{
	self waittill("death");
	if(isdefined(self))
	{
		self delete();
	}

	common_scripts\utility::flag_set("cargo_ship_destroyed");
}

//Function Number: 175
remove_from_target_array_on_death()
{
	level.player endon("death");
	self waittill("death");
	level.mob_turret_targets = common_scripts\utility::array_remove(level.mob_turret_targets,self);
}

//Function Number: 176
update_trigger_pos(param_00,param_01)
{
	param_00 endon("death");
	level.player endon("death");
	param_01 endon("death");
	var_02 = transformmove((0,0,0),(0,0,0),param_00.origin,param_00.angles,param_01.origin,param_01.angles);
	for(;;)
	{
		var_03 = transformmove(param_00.origin,param_00.angles,(0,0,0),(0,0,0),var_02["origin"],var_02["angles"]);
		param_01.origin = var_03["origin"];
		param_01.angles = var_03["angles"];
		wait(0.05);
	}
}

//Function Number: 177
wait_for_mob_turret_targets_to_be_destroyed()
{
	level.player endon("death");
	while(level.mob_turret_targets.size > 0)
	{
		wait(0.2);
	}

	common_scripts\utility::flag_set("laser_targets_destroyed");
}

//Function Number: 178
handle_mob_turret()
{
	common_scripts\utility::flag_wait("obj_console");
	level.player endon("death");
	var_00 = getent("trig_use_console","targetname") maps\_shg_utility::hint_button_trigger("use",200);
	maps\_utility::trigger_wait_targetname("trig_use_console");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_00 maps\_shg_utility::hint_button_clear();
	thread maps\_sonicaoe::disablesonicaoe();
	maps\sanfran_b_sonar_vision::sonar_vision_off();
	sonar_off();
	common_scripts\utility::flag_set("flag_end_sonar_vision");
	common_scripts\utility::flag_set("player_using_mob_turret");
	soundscripts\_snd::snd_message("rail_gun_start");
	level.burke.ignoreme = 1;
	level.cormack.ignoreme = 1;
	level.maddox.ignoreme = 1;
	thread railgun_cargo_ship_missiles();
	thread railgun_minigun_1();
	level.player enableinvulnerability();
	maps\_utility::delaythread(0.5,::maps\_utility::autosave_by_name);
	thread maps\sanfran_b_mob_turret::setup_mob_turret();
	var_01 = getent("trig_use_console","targetname");
	var_01 common_scripts\utility::trigger_off();
	thread water_explosions();
	thread railgun_ambient_air();
	thread railgun_enemies();
	thread static_overlay();
	wait(0.5);
	setsaveddvar("cg_fov","75");
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehalolumscale",0.75);
	setsaveddvar("r_hudoutlinehaloblurradius",0.35);
}

//Function Number: 179
railgun_cargo_ship_missiles()
{
	while(!common_scripts\utility::flag("laser_targets_destroyed"))
	{
		if(common_scripts\utility::flag("cargo_ship_destroyed"))
		{
			wait(0.05);
			continue;
		}

		var_00 = [];
		var_01 = getent("cargo_ship","targetname");
		if(!common_scripts\utility::flag("switching_cargo_ships"))
		{
			var_00[0] = getent("railgun_cargo_ship_missiles_1","targetname");
			if(isdefined(var_01))
			{
				var_00[0] linkto(var_01);
			}

			var_02 = getentarray("railgun_cargo_missile_targets_1","targetname");
			var_00[1] = getent("railgun_cargo_ship_missiles_2","targetname");
			if(isdefined(var_01))
			{
				var_00[1] linkto(var_01);
			}

			var_02 = getentarray("railgun_cargo_missile_targets_2","targetname");
		}
		else
		{
			var_00[1] = getent("railgun_cargo_ship_missiles_2","targetname");
			if(isdefined(var_01))
			{
				var_00[1] linkto(var_01);
			}

			var_02 = getentarray("railgun_cargo_missile_targets_2","targetname");
		}

		var_03 = var_00[randomint(var_00.size)];
		var_04 = var_02[randomint(var_02.size)];
		var_05 = vectortoangles(var_04.origin - var_03.origin);
		var_06 = magicbullet("cargo_ship_missile_railgun",var_03.origin,var_04.origin);
		var_06 missile_settargetent(var_04);
		var_06 missile_setflightmodedirect();
		var_06 thread railgun_missile_impact();
		playfx(common_scripts\utility::getfx("missile_launch_smoke"),var_03.origin,anglestoforward(var_05),anglestoup(var_05));
		wait(randomfloatrange(4,8));
	}

	level notify("stop_cargo_ship_missiles");
}

//Function Number: 180
railgun_missile_impact()
{
	self waittill("death");
	level endon("stop_cargo_ship_missiles");
	if(distance(level.player.origin,self.origin) <= 2048)
	{
		earthquake(0.4,1,self.origin,2048);
		playrumbleonposition("heavy_1s",self.origin);
	}
}

//Function Number: 181
water_explosions()
{
	level.player endon("laser_off");
	common_scripts\utility::flag_wait("player_on_turret_1");
	var_00 = randomfloatrange(3,6);
	var_01 = getent("water_clip","targetname");
	for(;;)
	{
		var_02 = anglestoforward(level.player.angles) * randomintrange(2048,7000);
		var_03 = anglestoup(level.player.angles) * -1;
		var_04 = anglestoright(level.player.angles) * randomintrange(-2048,2048);
		var_05 = level.player.origin + var_02 + var_04;
		var_06 = var_05;
		var_07 = var_05 + var_03 * 20000;
		var_08 = bullettrace(var_06,var_07,0);
		if(var_08["fraction"] == 1)
		{
			wait(0.05);
			continue;
		}

		if((isdefined(var_08["surfacetype"]) && var_08["surfacetype"] == "water" && isdefined(var_08["position"])) || isdefined(var_01) && isdefined(var_08["position"]) && isdefined(var_08["entity"]) && var_08["entity"] == var_01)
		{
			playfx(common_scripts\utility::getfx("water_impact"),var_08["position"]);
		}

		wait(var_00);
	}
}

//Function Number: 182
railgun_ambient_air()
{
	level.player endon("laser_off");
	common_scripts\utility::flag_wait("player_on_turret_1");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("railgun_jet_flyby_1");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("railgun_jet_flyby_2");
	soundscripts\_snd::snd_message("shrike_railgun_flyby_01",var_00,var_01);
	common_scripts\utility::flag_wait("first_cargo_ship_damaged");
	wait(1);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("railgun_jet_flyby_3");
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("railgun_jet_flyby_4");
	soundscripts\_snd::snd_message("shrike_railgun_flyby_02",var_02,var_03);
	common_scripts\utility::flag_wait("player_on_turret_2");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("railgun_jet_flyby_5");
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("railgun_jet_flyby_6");
	soundscripts\_snd::snd_message("shrike_railgun_flyby_03",var_04,var_05);
}

//Function Number: 183
railgun_minigun_1()
{
	var_00 = getentarray("org_cargo_ship_minigun_1","targetname");
	common_scripts\utility::array_thread(var_00,::railgun_minigun_fire,1);
	common_scripts\utility::flag_wait("player_on_turret_2");
	var_00 = getentarray("org_cargo_ship_minigun_2","targetname");
	common_scripts\utility::array_thread(var_00,::railgun_minigun_fire,2);
}

//Function Number: 184
railgun_enemies()
{
	maps\_utility::array_spawn_function_noteworthy("rail_gun_warbird",::railgun_warbird_think);
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("rail_gun_1_warbird");
	common_scripts\utility::flag_wait("player_switching_to_turret_2");
	var_00 = maps\_utility::array_removedead(var_00);
	common_scripts\utility::array_call(var_00,::delete);
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("rail_gun_2_warbird");
	common_scripts\utility::flag_wait("second_cargo_ship_destroyed");
	wait(7.75);
	var_00 = maps\_utility::array_removedead(var_00);
	common_scripts\utility::array_call(var_00,::delete);
}

//Function Number: 185
railgun_warbird_think()
{
	self setmaxpitchroll(20,40);
	self.emp_hits = 1;
	maps\_utility::add_damage_function(::rail_gun_warbird_damage_function);
	thread maps\sanfran_b_util::warbird_heavy_shooting_think(1);
	self sethoverparams(1000,45,45);
	self hudoutlineenable(1,1);
	if(!isdefined(self.ent_flag["warbird_open_fire"]))
	{
		maps\_utility::ent_flag_init("warbird_open_fire");
	}

	maps\_utility::ent_flag_wait("warbird_open_fire");
	self notify("warbird_fire");
	maps\_utility::ent_flag_waitopen("warbird_open_fire");
	self notify("warbird_stop_firing");
}

//Function Number: 186
rail_gun_warbird_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_01 == level.player && param_04 == "MOD_PROJECTILE")
	{
		self kill();
		wait(0.05);
		if(isdefined(self))
		{
			self notify("crash_done");
			self notify("in_air_explosion");
		}
	}
}

//Function Number: 187
railgun_minigun_fire(param_00)
{
	var_01 = undefined;
	if(param_00 == 1)
	{
		level endon("first_cargo_ship_destroyed");
	}

	if(param_00 == 2)
	{
		level endon("second_cargo_ship_destroyed");
	}

	if(param_00 == 1)
	{
		var_01 = getent("cargo_ship","targetname");
	}

	if(param_00 == 2)
	{
		var_01 = getent("cargo_ship_2","targetname");
	}

	self linkto(var_01);
	for(;;)
	{
		var_02 = randomfloatrange(1.5,3);
		var_03 = randomfloatrange(1,2);
		var_04 = 0;
		while(var_04 < var_02)
		{
			var_05 = randomintrange(-64,64);
			var_06 = level.player.origin + (0,0,-120) + (var_05,var_05,var_05);
			magicbullet("cargoship_turret",self.origin,var_06);
			var_07 = var_06 - self.origin;
			playfx(common_scripts\utility::getfx("cargoship_turret"),self.origin,var_07);
			var_04 = var_04 + 0.05;
			wait(0.05);
		}

		wait(var_03);
	}
}

//Function Number: 188
draw_crosshair()
{
	var_00 = create_hud_laser_crosshair();
	self waittill("laser_off");
	var_00 destroy();
}

//Function Number: 189
create_hud_laser_crosshair()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00.sort = -5;
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00 setshader("reticle_center_cross",32,32);
	var_00.alpha = 1;
	return var_00;
}

//Function Number: 190
static_overlay(param_00)
{
	create_hud_static_overlay();
	soundscripts\_snd::snd_message("start_camera_static");
}

//Function Number: 191
create_hud_static_overlay()
{
	setsaveddvar("cg_cinematicFullScreen","1");
	cinematicingame("glitch_short");
}

//Function Number: 192
dismount_console()
{
	static_overlay(1);
	var_00 = getent("trig_use_console","targetname");
	var_00 common_scripts\utility::trigger_off();
	setsaveddvar("cg_fov","65");
	level.player unlink();
	level.player notify("laser_off");
}

//Function Number: 193
drone_combat()
{
	maps\_utility::trigger_wait_targetname("trig_spawn_bridge_drones");
	wait(2);
	level.burke maps\_utility::set_grenadeammo(0);
	level.cormack maps\_utility::set_grenadeammo(0);
	level.maddox maps\_utility::set_grenadeammo(0);
	var_00 = maps\_utility::array_spawn_noteworthy("bridge_drones");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_b_util::setup_atlas_drone,"flag_cleanup_deck_drones");
	disable_cormack_obj();
	wait(0.05);
	common_scripts\utility::flag_wait("bridge_drones_dead");
	maps\_utility::activate_trigger_with_targetname("trig_control_room_anims");
}

//Function Number: 194
disable_cormack_obj()
{
	objective_position(maps\_utility::obj("obj_bridge"),(0,0,0));
}

//Function Number: 195
enable_cormack_obj()
{
	objective_onentity(maps\_utility::obj("obj_bridge"),level.cormack);
}

//Function Number: 196
track_bridge_drone_deaths()
{
	if(!isdefined(level.num_bridge_drones_destroyed))
	{
		level.num_bridge_drones_destroyed = 0;
	}

	self waittill("death");
	level.num_bridge_drones_destroyed++;
}

//Function Number: 197
should_end_sonar_hint()
{
	return isdefined(level.player.sonar_vision) && level.player.sonar_vision;
}

//Function Number: 198
should_end_laser_hint()
{
	return maps\sanfran_b_laser::is_player_using_laser();
}

//Function Number: 199
should_end_align_hint()
{
	return level.player attackbuttonpressed();
}

//Function Number: 200
align_hint_think()
{
	level.player endon("death");
	level.player waittill("use_laser");
	maps\_utility::display_hint("hint_align_laser");
}

//Function Number: 201
enable_jump_jet_pathing()
{
	if(issubstr(self.classname,"jump"))
	{
		self.canjumppath = 1;
	}
}

//Function Number: 202
handle_sonar_hint()
{
	level.player endon("death");
	maps\_utility::trigger_wait_targetname("trig_display_sonar_hint");
	common_scripts\utility::flag_wait("flag_allow_night_vision_hint");
	wait(0.75);
	maps\_utility::display_hint_timeout("hint_use_sonar",5);
}

//Function Number: 203
sonar_hint_2()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_information_center_vo_2");
	if(!maps\_nightvision::nightvision_check(level.player))
	{
		maps\_utility::display_hint_timeout("hint_use_sonar",3);
	}
}

//Function Number: 204
disable_ir_in_nightvision()
{
	self.has_no_ir = 1;
}

//Function Number: 205
server_room_lasers()
{
	self laseron();
}

//Function Number: 206
enable_my_thermal()
{
	self thermaldrawenable();
}

//Function Number: 207
disable_my_thermal()
{
	self thermaldrawdisable();
}

//Function Number: 208
slow_player_inside()
{
	common_scripts\utility::flag_wait("flag_player_entered_interior");
	thread maps\_utility::blend_movespeedscale(0.85,3);
}

//Function Number: 209
missile_test()
{
	for(;;)
	{
		var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("cargo_to_player_1");
		wait(3);
	}

	wait(0.05);
}