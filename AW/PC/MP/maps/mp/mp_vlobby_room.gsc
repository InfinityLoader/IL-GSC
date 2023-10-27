/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_vlobby_room.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 160 ms
 * Timestamp: 10/27/2023 1:46:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachemodel("archery_target_fr");
	precachemodel("bc_target_dummy_base");
	precachemodel("training_target_opfor1");
	precachemodel("training_target_civ1");
	precacheshader("ac130_overlay_pip_vignette_vlobby");
	precacheshader("ac130_overlay_pip_vignette_vlobby_cao");
	maps\mp\mp_vlobby_room_precache::main();
	maps\createart\mp_vlobby_room_art::main();
	maps\mp\mp_vlobby_room_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_vlobby_room_lighting::main();
	maps\mp\mp_vlobby_room_aud::main();
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.vl_dof_based_on_focus = ::vl_dof_based_on_focus;
	level.vl_handle_mode_change = ::vl_handle_mode_change;
	level.vl_lighting_setup = ::vl_lighting_setup;
	thread vl_ground_setup();
	maps\mp\_vl_base::vl_init();
	level.dof_tuner = spawnstruct();
	level.dof_tuner.fstopperunit = 0.25;
	level.dof_tuner.scaler = -0.3;
	level.dof_tuner.fstopbase = 3;
	thread fade_from_black();
}

//Function Number: 2
fade_from_black()
{
	level waittill("connected",var_00);
	var_00 waittill("fade_in");
	var_00 clientaddsoundsubmix("mp_no_foley",1);
}

//Function Number: 3
vl_ground_setup()
{
	var_00 = getent("teleport_from","targetname");
	var_01 = getent("teleport_to","targetname");
	var_02 = getentarray("vlobby_floor_b","targetname");
	foreach(var_04 in var_02)
	{
		var_04.origin = var_04.origin + var_01.origin - var_00.origin;
	}

	var_06 = getentarray("vlobby_floor_a","targetname");
	foreach(var_08 in var_06)
	{
		var_08 hide();
	}
}

//Function Number: 4
vl_lighting_setup()
{
	var_00 = self;
	var_00 enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		var_00 setphysicaldepthoffield(0.613159,89.8318,level.camparams.dof_time,level.camparams.dof_time * 2);
		return;
	}

	var_00 setphysicaldepthoffield(4.01284,95.2875,level.camparams.dof_time,level.camparams.dof_time * 2);
}

//Function Number: 5
vl_dof_based_on_focus(param_00)
{
	var_01 = level.camparams.dof_time;
	var_02 = self;
	var_03 = param_00;
	var_02 = self;
	var_04 = level.dof_tuner.fstopperunit;
	var_05 = level.dof_tuner.scaler;
	var_06 = level.dof_tuner.fstopbase;
	if(level.currentgen)
	{
		var_06 = var_06 + 2;
	}

	var_07 = 104;
	var_08 = var_07 - var_03 * var_04;
	var_09 = var_06 + var_08 + var_08 * var_05;
	if(var_09 < 0.125)
	{
		var_09 = 0.125;
	}
	else if(var_09 > 128)
	{
		var_09 = 128;
	}

	var_02 setphysicaldepthoffield(var_09,var_03,var_01,var_01 * 2);
}

//Function Number: 6
vl_handle_mode_change(param_00,param_01,param_02)
{
	var_03 = self;
	if(param_00 == "cac")
	{
		var_03 setdefaultpostfx();
	}
	else if(param_00 == "cao")
	{
	}

	if(param_01 == "cac")
	{
		var_03 visionsetnakedforplayer("mp_vlobby_room_cac",0);
		var_03 lightsetforplayer("mp_vl_create_a_class");
		return;
	}

	if(param_01 == "cao")
	{
		if(level.nextgen)
		{
			var_03 setphysicaldepthoffield(1.223,156.419,level.camparams.dof_time,level.camparams.dof_time);
			return;
		}

		var_03 setphysicaldepthoffield(3.223,156.419,level.camparams.dof_time,level.camparams.dof_time);
		return;
	}

	if(param_01 == "clanprofile")
	{
		var_03 setdefaultpostfx();
		var_03 maps\mp\_vl_camera::set_avatar_dof();
		return;
	}

	if(param_01 == "prelobby")
	{
		var_03 setdefaultdof();
		var_03 setdefaultpostfx();
		return;
	}

	if(param_00 == "prelobby_members")
	{
		return;
	}

	if(param_00 == "prelobby_loadout")
	{
		return;
	}

	if(param_00 == "prelobby_loot")
	{
		return;
	}

	if(param_01 == "game_lobby")
	{
		var_03 setdefaultpostfx();
		var_03 maps\mp\_vl_camera::set_avatar_dof();
		return;
	}

	if(param_00 == "startmenu")
	{
		return;
	}

	if(param_00 == "transition")
	{
		return;
	}

	if(param_01 == "clanprofile")
	{
		var_03 setdefaultdof();
		var_03 setdefaultpostfx();
		return;
	}
}

//Function Number: 7
setdefaultpostfx()
{
	var_00 = self;
	var_00 visionsetnakedforplayer("mp_vlobby_room",0);
	var_00 lightsetforplayer("mp_vlobby_room");
}

//Function Number: 8
setdefaultdof()
{
	var_00 = self;
	if(level.nextgen)
	{
		var_00 setphysicaldepthoffield(0.613159,89.8318,level.camparams.dof_time,level.camparams.dof_time);
		return;
	}

	var_00 setphysicaldepthoffield(4.01284,95.2875,level.camparams.dof_time,level.camparams.dof_time);
}