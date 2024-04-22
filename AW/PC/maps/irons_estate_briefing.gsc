/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_briefing.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 251 ms
 * Timestamp: 4/22/2024 2:31:45 AM
*******************************************************************/

//Function Number: 1
briefing_start()
{
	level.start_point_scripted = "briefing";
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	level.player maps\_grapple::grapple_take();
	level.player maps\_tagging::tagging_set_enabled(0);
}

//Function Number: 2
briefing_main()
{
	level.start_point_scripted = "briefing";
	thread briefing_begin();
	soundscripts\_snd::snd_message("aud_briefing");
	common_scripts\utility::flag_wait("briefing_end");
	maps\_utility::autosave_stealth();
}

//Function Number: 3
briefing_begin()
{
	level.briefing_anim_struct = common_scripts\utility::getstruct("briefing_anim_struct_new","targetname");
	thread handle_briefing();
	level.allies[0] thread briefing_allies();
	level.allies[1] thread briefing_allies();
	level.allies[2] thread briefing_allies();
	level.allies[0] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify("player_can_move");
	level.allies[1] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify("player_can_move");
	level.allies[2] thread maps\irons_estate_code::hide_friendname_until_flag_or_notify("player_can_move");
	thread briefing_ambient_allies();
	thread brief_fx();
}

//Function Number: 4
handle_briefing()
{
	thread briefing_player();
	thread introscreen();
	common_scripts\utility::flag_wait("introscreen1_complete");
	thread briefing_obj();
	level waittill("player_can_move");
	wait(1);
	thread maps\_utility::center_screen_text(&"IRONS_ESTATE_CENTER_SCREEN_TEXT1");
	level.allies[0] waittillmatch("fade_start","single anim");
	thread maps\_hud_util::fade_out(2,"black");
	wait(2);
	common_scripts\utility::flag_set("teleport_to_base");
	wait(3);
	common_scripts\utility::flag_set("briefing_end");
}

//Function Number: 5
briefing_player()
{
	level.player freezecontrols(1);
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player lerpfov(50,0.05);
	level.player giveweapon("s1_unarmed");
	level.player switchtoweaponimmediate("s1_unarmed");
	level.player disableweaponswitch();
	level.player disableweapons();
	level.player allowmelee(0);
	level.player allowsprint(0);
	level.player allowads(0);
	level.player setmovespeedscale(0.5);
	level.player setstance("stand");
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.player_rig hide();
	level.briefing_anim_struct maps\_anim::anim_first_frame_solo(level.player_rig,"briefing_start");
	level.player playerlinktodelta(level.player_rig,"tag_player",0,0,0,0,0,1);
	common_scripts\utility::flag_wait("introscreen1_complete");
	thread look_control_on();
	thread lerp_fov_wait();
	level.briefing_anim_struct maps\_anim::anim_single_solo(level.player_rig,"briefing_start");
	level.player_rig delete();
	level notify("player_can_move");
	level.player unlink();
	level.player enableweapons();
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player freezecontrols(0);
	common_scripts\utility::flag_wait("teleport_to_base");
	var_00 = common_scripts\utility::getstruct("intro_start","targetname");
	level.player maps\_utility::teleport_player(var_00);
	var_00 = common_scripts\utility::getstruct("intro_start","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("tag_origin");
	var_01.angles = var_00.angles;
	level.player playerlinkto(var_01,"tag_origin",0,0,0,0,0,0);
}

//Function Number: 6
lerp_fov_wait()
{
	level.player_rig waittillmatch("fov_lerp_start","single anim");
	level.player lerpfov(65,3);
}

//Function Number: 7
look_control_on()
{
	wait(2);
	level.player lerpviewangleclamp(1,1,1,5,5,3,3);
}

//Function Number: 8
introscreen()
{
	thread maps\_shg_utility::play_chyron_video("chyron_text_irons_estate",undefined,2);
	common_scripts\utility::flag_wait("chyron_video_done");
	common_scripts\utility::flag_set("introscreen1_complete");
}

//Function Number: 9
briefing_obj()
{
}

//Function Number: 10
briefing_allies()
{
	self.ignoreall = 1;
	maps\_utility::gun_remove();
	var_00 = undefined;
	level.briefing_anim_struct maps\_anim::anim_first_frame_solo(self,"briefing_start");
	if(self == level.allies[2])
	{
		var_00 = spawn("script_model",(0,0,0));
		var_00 setmodel("greece_drone_control_pad");
		playfxontag(level._effect["ie_light_teal_briefing_knox"],var_00,"tag_origin");
		var_00 linkto(self,"tag_weapon_left",(0,0,0),(0,0,0));
	}

	common_scripts\utility::flag_wait("introscreen1_complete");
	level.briefing_anim_struct thread maps\_anim::anim_single_solo(self,"briefing_start");
	common_scripts\utility::flag_wait("teleport_to_base");
	maps\_utility::anim_stopanimscripted();
	maps\_utility::gun_recall();
	if(self == level.allies[2])
	{
		killfxontag(level._effect["ie_light_teal_briefing_knox"],var_00,"tag_origin");
		wait(0.05);
		var_00 delete();
	}

	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self delete();
}

//Function Number: 11
briefing_ambient_allies()
{
	maps\_utility::array_spawn_function_targetname("briefing_ally_spawner",::briefing_ambient_ally_setup);
	var_00 = maps\_utility::array_spawn_targetname("briefing_ally_spawner",1);
}

//Function Number: 12
briefing_ambient_ally_setup()
{
	self.ignoreall = 1;
	self.animname = self.script_noteworthy;
	level.briefing_anim_struct maps\_anim::anim_first_frame_solo(self,"briefing_start_" + self.script_noteworthy);
	if(self.animname == "worker1" || self.animname == "worker2" || self.animname == "worker3")
	{
		maps\_utility::gun_remove();
	}

	common_scripts\utility::flag_wait("introscreen1_complete");
	level.briefing_anim_struct maps\_anim::anim_single_solo(self,"briefing_start_" + self.script_noteworthy);
	common_scripts\utility::flag_wait("teleport_to_base");
	self delete();
}

//Function Number: 13
briefing_vignettes()
{
	var_00 = common_scripts\utility::getstructarray("briefing_vignette","targetname");
	var_01 = getent("briefing_spawner","targetname");
	foreach(var_03 in var_00)
	{
		var_01.count = 1;
		var_04 = var_01 maps\_utility::spawn_ai(1);
		var_04 thread briefing_vignette_anims(var_03);
		thread briefing_vignette_cleanup(var_03,var_04);
		wait 0.05;
	}

	var_06 = common_scripts\utility::getstructarray("briefing_business_male_vignette","targetname");
	var_07 = getent("briefing_business_male_spawner","targetname");
	foreach(var_09 in var_06)
	{
		var_07.count = 1;
		var_0A = var_07 maps\_utility::spawn_ai(1);
		var_0A thread briefing_vignette_anims(var_09);
		thread briefing_vignette_cleanup(var_09,var_0A);
		wait 0.05;
	}

	var_0C = common_scripts\utility::getstructarray("briefing_business_female_vignette","targetname");
	var_0D = getent("briefing_business_female_spawner","targetname");
	foreach(var_0F in var_0C)
	{
		var_0D.count = 1;
		var_10 = var_0D maps\_utility::spawn_ai(1);
		var_10 thread briefing_vignette_anims(var_0F);
		thread briefing_vignette_cleanup(var_0F,var_10);
		wait 0.05;
	}
}

//Function Number: 14
briefing_vignette_anims(param_00)
{
	self.animname = "generic";
	if(self.classname == "actor_ally_sentinel_bal27")
	{
		maps\_utility::gun_remove();
	}

	wait(randomfloatrange(0.05,0.5));
	param_00 thread maps\_anim::anim_loop_solo(self,param_00.animation);
}

//Function Number: 15
briefing_vignette_cleanup(param_00,param_01)
{
	common_scripts\utility::flag_wait("teleport_to_base");
	param_00 notify("stop_loop");
	param_01 delete();
}

//Function Number: 16
brief_fx()
{
	common_scripts\_exploder::exploder(4300);
	common_scripts\utility::flag_wait("briefing_end");
	maps\_utility::stop_exploder(4300);
}