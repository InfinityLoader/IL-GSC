/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_transients_cg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 56 ms
 * Timestamp: 4/22/2024 2:31:35 AM
*******************************************************************/

//Function Number: 1
transition_unload_then_load_safely(param_00,param_01,param_02)
{
	if(istransientloaded(param_00))
	{
		unloadtransient(param_00);
	}

	for(;;)
	{
		if(!istransientloaded(param_00))
		{
			break;
		}

		wait(0.1);
	}

	loadtransient(param_01);
	for(;;)
	{
		if(istransientloaded(param_01))
		{
			break;
		}

		wait(0.1);
	}

	level notify(param_02);
}

//Function Number: 2
check_wait_on_cg_notetracks(param_00,param_01,param_02)
{
	if(level.currentgen)
	{
		if(!issubstr(level.transient_zone,param_00))
		{
			level waittill(param_01);
		}
	}

	[[ param_02 ]]();
}

//Function Number: 3
setup_start_points_for_transients()
{
	var_00 = ["greece_intro_tr","greece_market_audio_tr"];
	maps\_utility::set_start_transients("start_safehouse_intro",var_00);
	maps\_utility::set_start_transients("start_safehouse_follow",var_00);
	var_00 = ["greece_intro_tr"];
	maps\_utility::set_start_transients("start_safehouse_xslice",var_00);
	maps\_utility::set_start_transients("start_safehouse_clear",var_00);
	maps\_utility::set_start_transients("start_safehouse_transition",var_00);
	maps\_utility::set_start_transients("start_conf_center_intro",var_00);
	var_00 = ["greece_confcenter_tr"];
	maps\_utility::set_start_transients("start_conf_center_support1",var_00);
	maps\_utility::set_start_transients("start_conf_center_support2",var_00);
	maps\_utility::set_start_transients("start_conf_center_support3",var_00);
	maps\_utility::set_start_transients("start_conf_center_kill",var_00);
	maps\_utility::set_start_transients("start_conf_center_combat",var_00);
	maps\_utility::set_start_transients("start_conf_center_outro",var_00);
	var_00 = ["greece_intro_tr"];
	maps\_utility::set_start_transients("start_safehouse_exit",var_00);
	maps\_utility::set_start_transients("start_alleys_transition",var_00);
	var_00 = ["greece_middle_tr"];
	maps\_utility::set_start_transients("start_alleys",var_00);
	maps\_utility::set_start_transients("start_alleys_art",var_00);
	maps\_utility::set_start_transients("start_alleys_art",var_00);
	maps\_utility::set_start_transients("start_alleys_end",var_00);
	maps\_utility::set_start_transients("start_sniper_scramble_intro",var_00);
	var_00 = ["greece_outro_tr"];
	maps\_utility::set_start_transients("start_sniper_scramble_hotel",var_00);
	maps\_utility::set_start_transients("start_sniper_scramble_drones",var_00);
	maps\_utility::set_start_transients("start_sniper_scramble_finale",var_00);
	var_00 = ["greece_hades_fight_tr"];
	maps\_utility::set_start_transients("start_ending_ambush",var_00);
	maps\_utility::set_start_transients("start_ending_fight",var_00);
	maps\_utility::set_start_transients("start_ending_hades",var_00);
	level.transient_zone = "";
	if(istransientloaded("greece_intro_tr"))
	{
		level.transient_zone = "intro";
	}

	if(istransientloaded("greece_confCenter_tr"))
	{
		level.transient_zone = level.transient_zone + "_confCenter";
	}
	else if(istransientloaded("greece_middle_tr"))
	{
		level.transient_zone = level.transient_zone + "_middle";
	}
	else if(istransientloaded("greece_outro_tr"))
	{
		level.transient_zone = level.transient_zone + "_outro";
	}
	else if(istransientloaded("greece_hades_fight_tr"))
	{
		level.transient_zone = level.transient_zone + "_hades_fight";
	}

	if(level.transient_zone == "intro")
	{
		level notify("transients_intro");
	}
}