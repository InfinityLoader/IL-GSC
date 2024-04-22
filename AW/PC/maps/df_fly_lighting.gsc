/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_fly_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 177 ms
 * Timestamp: 4/22/2024 2:28:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(level.currentgen)
	{
		thread df_fly_dof_presets();
	}

	thread df_fly_set_level_lighting_values();
	thread df_fly_lighting();
	thread df_fly_lighting_canyon();
	thread df_fly_lighting_canyon_finale();
	thread df_fly_lighting_end_pod();
	thread set_sun_flare();
	thread setup_vignette();
}

//Function Number: 2
df_fly_dof_presets()
{
	if(level.nextgen)
	{
		maps\_lighting::create_dof_preset("df_fly",10,60,0,0,7500,1,0.5);
		maps\_lighting::create_dof_preset("df_fly_intro",10,60,0,0,7500,1,0.5);
		maps\_lighting::create_dof_preset("df_fly_canyon",10,60,0,0,7500,1,0.5);
		maps\_lighting::create_dof_preset("df_fly_canyon_finale",10,60,0,0,7500,1,0.5);
		return;
	}

	setsaveddvar("r_dof_physical_enable",0);
	maps\_lighting::create_dof_preset("df_fly",0,100,0,18000,29000,1.1,0.5);
	maps\_lighting::create_dof_preset("df_fly_intro",0,100,0,18000,29000,1.1,0.5);
	maps\_lighting::create_dof_preset("df_fly_canyon",0,100,0,18000,29000,1.1,0.5);
	maps\_lighting::create_dof_preset("df_fly_canyon_finale",0,100,0,18000,29000,1.1,0.5);
}

//Function Number: 3
retarget_lighting()
{
	var_00 = getent("terrain_no_light","targetname");
	var_01 = getent("terrain_light","targetname");
	var_00 retargetscriptmodellighting(var_01);
}

//Function Number: 4
df_fly_set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disableLightSets",0);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}
}

//Function Number: 5
df_fly_lighting()
{
	level.player lightsetforplayer("df_fly_canyon");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_df_fly",0);
	}

	maps\_utility::vision_set_fog_changes("df_fly_canyon",0);
	if(level.currentgen)
	{
		maps\_lighting::blend_dof_presets("default","df_fly",0);
	}
}

//Function Number: 6
df_fly_lighting_canyon()
{
	level.player lightsetforplayer("df_fly_canyon");
	maps\_utility::vision_set_fog_changes("df_fly_canyon",0);
	if(level.currentgen)
	{
		maps\_lighting::blend_dof_presets("df_fly_intro","df_fly_canyon",0);
	}

	if(level.nextgen)
	{
		thread set_canyon_dof();
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_mbVelocityScalar","1");
	}
}

//Function Number: 7
set_canyon_dof()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,7000,50,50);
	level.player setphysicalviewmodeldepthoffield(1.25,30);
	common_scripts\utility::flag_wait("canyon_finished");
	wait(5);
	level.player setphysicaldepthoffield(5,660);
	wait(3);
	level.player setphysicaldepthoffield(5,28.8);
}

//Function Number: 8
set_sun_flare()
{
	thread maps\_shg_fx::vfx_sunflare("df_fly_sun_flare");
}

//Function Number: 9
setup_vignette()
{
	level.flyvignette = newhudelem(level.player);
	level.flyvignette.x = 0;
	level.flyvignette.y = 0;
	level.flyvignette.alpha = 1;
	level.flyvignette.horzalign = "fullscreen";
	level.flyvignette.vertalign = "fullscreen";
	level.flyvignette.sort = 3;
	level.flyvignette setshader("s1_railgun_hud_outer_shadow",640,480);
}

//Function Number: 10
df_fly_lighting_canyon_finale()
{
	common_scripts\utility::flag_wait("canyon_finished");
	level.player lightsetforplayer("df_fly_canyon");
	maps\_utility::vision_set_fog_changes("df_fly_canyon_finale",2);
	if(level.currentgen)
	{
		maps\_lighting::blend_dof_presets("df_fly_canyon","df_fly_canyon_finale",1);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_mbVelocityScalar","1");
	}
}

//Function Number: 11
df_fly_lighting_end_pod()
{
	common_scripts\utility::flag_wait("canyon_finished");
	wait(12);
	level.player lightsetforplayer("df_fly_canyon");
	maps\_utility::vision_set_fog_changes("df_fly_canyon_finale",2);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_mbVelocityScalar","1");
	}
}

//Function Number: 12
ambient_model_fix()
{
	wait(1);
	var_00 = getent("red_hoodoo2b","targetname");
	var_01 = getent("crumble_hoodoo_b","targetname");
	var_02 = getent("red_hoodoo2c","targetname");
	var_03 = getent("crumble_hoodoo_a","targetname");
	var_04 = getent("cliff_01_origin","targetname");
	var_05 = common_scripts\utility::getstruct("cliff_02_origin","targetname");
	var_00 overridelightingorigin(var_04.origin);
	var_01 overridelightingorigin(var_05.origin);
	var_02 overridelightingorigin(var_05.origin);
	var_03 overridelightingorigin(var_05.origin);
}