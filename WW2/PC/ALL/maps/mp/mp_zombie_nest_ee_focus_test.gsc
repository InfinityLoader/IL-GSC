/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_ee_focus_test.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 77 ms
 * Timestamp: 10/27/2023 3:19:22 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_6662 = common_scripts\utility::func_46B7("objective_testing_spawners","targetname");
	level.var_6664 = common_scripts\utility::func_46B7("objective_testing_spawners_salt","targetname");
	level.var_6663 = common_scripts\utility::func_46B7("objective_testing_spawners_com","targetname");
	level.var_6661 = common_scripts\utility::func_46B7("objective_testing_spawners_blimp","targetname");
}

//Function Number: 2
func_3DA6()
{
	thread maps/mp/mp_zombie_nest_ee_quicktest::func_CAE("teslagun_zm","stg44_pap_zm",5000,7);
	level.var_66D6 = 11;
	level thread func_8C92();
	level thread lib_057D::func_4769();
	wait(1);
	level.var_76CE = 1;
	common_scripts\utility::func_3C8F("5 Right Hand fuses");
	lib_0557::func_782D("1 fire well","gas flowing");
	maps/mp/mp_zombie_nest_ee_fire_well::func_7854();
}

//Function Number: 3
func_3DA4()
{
	thread maps/mp/mp_zombie_nest_ee_quicktest::func_CAE("teslagun_zm","stg44_pap_zm",5000,5);
	level.var_66D6 = 8;
	level thread func_8C92();
	level thread lib_057D::func_4769();
}

//Function Number: 4
func_8C92()
{
	if(isdefined(level.var_66D6))
	{
		level.var_A981 = level.var_66D6 - 1;
	}

	level.var_ABEC maps\mp\_utility::func_5DC7();
	level.var_ABED maps\mp\_utility::func_5DC7();
	level.var_AC12 maps\mp\_utility::func_5DC7();
	var_00 = maps/mp/agents/_agent_utility::func_43FD("all");
	foreach(var_02 in var_00)
	{
		if(lib_0547::func_5565(var_02.var_A4B,"zombie_boss_village"))
		{
			continue;
		}

		var_02 suicide();
	}

	level notify("skipWave");
}