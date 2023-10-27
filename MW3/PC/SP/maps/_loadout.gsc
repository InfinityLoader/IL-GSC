/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_loadout.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 61
 * Decompile Time: 984 ms
 * Timestamp: 10/27/2023 2:22:36 AM
*******************************************************************/

//Function Number: 1
init_loadout()
{
	if(!isdefined(level.dodgeloadout))
	{
		give_loadout();
	}

	level.loadoutcomplete = 1;
	level notify("loadout complete");
}

//Function Number: 2
setdefaultactionslot()
{
	self setactionslot(1,"");
	self setactionslot(2,"");
	self setactionslot(3,"altMode");
	self setactionslot(4,"");
}

//Function Number: 3
init_player()
{
	setdefaultactionslot();
	self takeallweapons();
}

//Function Number: 4
char_switcher()
{
	level.coop_player1 = level.player;
	level.coop_player2 = level.player2;
	if(isdefined(level.character_switched) && level.character_switched)
	{
		if(maps\_utility::is_coop())
		{
			foreach(var_01 in level.players)
			{
				var_01 init_player();
			}

			level.coop_player1 = level.player2;
			level.coop_player2 = level.player;
			level.character_switched = 1;
			return 1;
		}
		else
		{
			level.player init_player();
			level.coop_player1 = undefined;
			level.coop_player2 = level.player;
			level.character_switched = 1;
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
get_loadout()
{
	if(isdefined(level.loadout))
	{
		return level.loadout;
	}

	return level.script;
}

//Function Number: 6
give_loadout(param_00)
{
	var_01 = get_loadout();
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	level.character_selected = param_00;
	var_02 = [];
	level.player setdefaultactionslot();
	if(maps\_utility::is_coop())
	{
		level.player2 setdefaultactionslot();
	}

	if(!isdefined(game["expectedlevel"]))
	{
		game["expectedlevel"] = "";
	}

	if(!isdefined(level.campaign))
	{
		level.campaign = "american";
	}

	if(common_scripts\utility::string_starts_with(level.script,"pmc_"))
	{
		level.player setviewmodel("viewmodel_base_viewhands");
		if(maps\_utility::is_coop())
		{
			precachemodel("weapon_parabolic_knife");
			level.player maps\_utility::setmodelfunc(::so_body_player_ranger);
			level.player2 maps\_utility::setmodelfunc(::so_body_player_ranger);
			level.player2 setviewmodel("viewmodel_base_viewhands");
		}

		level.campaign = "american";
		return;
	}

	if(maps\_utility::is_specialop())
	{
		give_loadout_specialops(param_00);
		return;
	}

	if(level.script == "background")
	{
		level.player takeallweapons();
		return;
	}

	if(level.script == "iw4_credits")
	{
		level.player takeallweapons();
		return;
	}

	if(var_01 == "london")
	{
		level.player giveweapon("mp5_silencer_eotech");
		level.player giveweapon("usp_silencer");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("mp5_silencer_eotech");
		level.player setviewmodel("viewhands_sas");
		level.campaign = "british";
		return;
	}
	else if(var_01 == "innocent")
	{
		level.player setviewmodel("viewhands_sas");
		level.campaign = "british";
		if(!isdefined(game["previous_map"]))
		{
			level.player giveweapon("mp5_silencer_eotech");
			level.player giveweapon("usp_silencer");
			level.player giveweapon("fraggrenade");
			level.player giveweapon("flash_grenade");
			level.player setoffhandsecondaryclass("flash");
			level.player switchtoweapon("mp5_silencer_eotech");
		}
		else
		{
			level.player setoffhandsecondaryclass("flash");
			restoreplayerweaponstatepersistent("london",1);
		}

		return;
	}
	else if(var_01 == "hamburg")
	{
		level.player giveweapon("m4m203_acog_payback");
		level.player giveweapon("smaw_nolock");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("m4m203_acog_payback");
		level.player setviewmodel("viewhands_delta");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "prague")
	{
		level.default_weapon = "rsass_hybrid_silenced";
		level.player giveweapon(level.default_weapon);
		level.player giveweapon("usp_silencer");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon(level.default_weapon);
		level.player setviewmodel("viewhands_yuri_europe");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "warlord")
	{
		level.player giveweapon("m14ebr_scoped_silenced_warlord");
		level.player giveweapon("ak47_silencer_reflex");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("m14ebr_scoped_silenced_warlord");
		level.player setviewmodel("viewhands_yuri");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "castle")
	{
		level.castle_main_weapon = "mp5_silencer_reflex_castle";
		level.castle_side_weapon = "p99_tactical_silencer";
		level.player giveweapon(level.castle_main_weapon);
		level.player giveweapon(level.castle_side_weapon);
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon(level.castle_main_weapon);
		level.player setviewmodel("viewhands_yuri_europe");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "berlin")
	{
		level.player giveweapon("m14ebr_scope");
		level.player giveweapon("acr_hybrid_berlin");
		level.player giveweapon("fraggrenade");
		level.player setoffhandsecondaryclass("flash");
		level.player giveweapon("ninebang_grenade");
		level.player switchtoweapon("acr_hybrid_berlin");
		level.player setviewmodel("viewhands_delta");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "paris_a")
	{
		level.player giveweapon("scar_h_acog");
		level.player giveweapon("usp_no_knife");
		level.player giveweapon("fraggrenade");
		level.player setoffhandsecondaryclass("flash");
		level.player giveweapon("ninebang_grenade");
		level.player switchtoweapon("scar_h_acog");
		level.player setviewmodel("viewhands_delta");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "paris_b")
	{
		level.player giveweapon("scar_h_acog");
		level.player giveweapon("usp_no_knife");
		level.player giveweapon("fraggrenade");
		level.player setoffhandsecondaryclass("flash");
		level.player giveweapon("ninebang_grenade");
		level.player switchtoweapon("scar_h_acog");
		level.player setviewmodel("viewhands_delta");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "paris_ac130")
	{
		level.player setviewmodel("viewhands_delta");
		level.player giveweapon("m4m203_reflex");
		level.player givemaxammo("m4m203_reflex");
		level.player setoffhandprimaryclass("frag");
		level.player giveweapon("fraggrenade");
		level.player setoffhandsecondaryclass("flash");
		level.player giveweapon("flash_grenade");
		level.player switchtoweapon("m4m203_reflex");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "ny_manhattan")
	{
		level.player giveweapon("m4_hybrid_grunt_optim");
		level.player giveweapon("xm25");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("m4_hybrid_grunt_optim");
		level.player setviewmodel("viewhands_delta_shg");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "ny_harbor")
	{
		level.player giveweapon("mp5_silencer_reflex");
		level.player givemaxammo("mp5_silencer_reflex");
		level.player giveweapon("usp_no_knife");
		level.player givemaxammo("usp_no_knife");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("ninebang_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("mp5_silencer_reflex");
		level.player setviewmodel("viewhands_udt");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "dubai")
	{
		level.dubai_main_weapon = "pecheneg_fastreload";
		level.player giveweapon(level.dubai_main_weapon);
		level.player givemaxammo(level.dubai_main_weapon);
		level.player giveweapon("m4m203_acog");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon(level.dubai_main_weapon);
		level.player setviewmodel("viewhands_juggernaut_ally");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "payback")
	{
		level.player giveweapon("m4m203_acog_payback");
		level.player giveweapon("deserteagle");
		level.player giveweapon("fraggrenade");
		level.player setoffhandsecondaryclass("flash");
		level.player giveweapon("flash_grenade");
		level.player switchtoweapon("m4m203_acog_payback");
		level.player setviewmodel("viewhands_yuri");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "hijack")
	{
		level.player giveweapon("fnfiveseven");
		level.player switchtoweapon("fnfiveseven");
		level.player setviewmodel("viewhands_fso");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "prague_escape")
	{
		level.player giveweapon("deserteagle");
		level.player giveweapon("m4m203_reflex");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("m4m203_reflex");
		level.player setviewmodel("viewhands_yuri_europe");
		level.campaign = "delta";
		return;
	}
	else if(var_01 == "intro")
	{
		level.player giveweapon("ak47_reflex");
		level.player givemaxammo("ak47_reflex");
		level.player giveweapon("deserteagle");
		level.player givemaxammo("deserteagle");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandprimaryclass("frag");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon("ak47_reflex");
		level.player setviewmodel("viewhands_yuri");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "rescue")
	{
		level.default_weapon = "acr_hybrid_silenced";
		level.player giveweapon(level.default_weapon);
		level.player givemaxammo(level.default_weapon);
		level.player giveweapon("usp");
		level.player givemaxammo("usp");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandprimaryclass("frag");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon(level.default_weapon);
		level.player setviewmodel("viewmodel_base_viewhands");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "rescue_2")
	{
		level.default_weapon = "g36c_reflex";
		level.player giveweapon(level.default_weapon);
		level.player givemaxammo(level.default_weapon);
		level.player giveweapon("m4_grunt_acog");
		level.player givemaxammo("m4_grunt_acog");
		level.player giveweapon("fraggrenade");
		level.player giveweapon("flash_grenade");
		level.player setoffhandprimaryclass("frag");
		level.player setoffhandsecondaryclass("flash");
		level.player switchtoweapon(level.default_weapon);
		level.player setviewmodel("viewhands_yuri_europe");
		level.campaign = "american";
		return;
	}
	else if(var_01 == "innocent")
	{
		level.campaign = "british";
		return;
	}

	if(issubstr(var_01,"firingrange"))
	{
		return;
	}

	level.testmap = 1;
	give_default_loadout();
}

//Function Number: 7
give_loadout_specialops(param_00)
{
	var_01 = get_loadout();
	if(var_01 == "so_nyse_ny_manhattan")
	{
		level.so_campaign = "delta";
		foreach(var_06, var_03 in level.players)
		{
			so_player_num(var_06);
			var_04 = "m4_hybrid_grunt_optim";
			var_05 = "xm25";
			so_player_giveweapon(var_04);
			so_player_giveweapon(var_05);
			so_player_set_switchtoweapon(var_04);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_06);
		}

		so_players_give_loadout();
		return;
	}

	if(var_06 == "so_stealth_warlord")
	{
		level.so_campaign = "delta";
		level.coop_incap_weapon = level.so_warlord_secondary;
		foreach(var_06 in level.players)
		{
			so_player_num(var_07);
			so_player_giveweapon(level.so_warlord_primary);
			so_player_giveweapon(level.so_warlord_secondary);
			so_player_set_switchtoweapon(level.so_warlord_primary);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_07);
		}

		so_players_give_loadout();
		return;
	}

	if(var_07 == "so_littlebird_payback")
	{
		level.so_campaign = "delta";
		foreach(var_07 in level.players)
		{
			so_player_num(var_08);
			so_player_giveweapon(level.so_payback_primary);
			so_player_giveweapon(level.so_payback_secondary);
			so_player_set_switchtoweapon(level.so_payback_primary);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_08);
		}

		so_players_give_loadout();
		return;
	}

	if(var_08 == "so_ied_berlin")
	{
		level.so_campaign = "delta";
		if(maps\_utility::is_coop())
		{
			if(getdvar("coop_start") == "so_char_host")
			{
				var_09 = 0;
				var_0A = 1;
			}
			else
			{
				var_09 = 1;
				var_0A = 0;
			}
		}
		else
		{
			var_09 = 0;
			var_0A = 1;
		}

		so_player_num(var_09);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("flash_grenade");
		so_player_set_setoffhandsecondaryclass("flash");
		so_player_giveweapon("sa80lmg_fastreload_reflex");
		so_player_giveweapon("m320");
		so_player_set_switchtoweapon("sa80lmg_fastreload_reflex");
		so_player_setup_body(var_09);
		so_player_num(var_0A);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("semtex_grenade");
		so_player_set_setoffhandsecondaryclass("semtex_grenade");
		so_player_giveweapon("barrett");
		so_player_giveweapon("scar_h_thermal_silencer");
		so_player_set_switchtoweapon("barrett");
		so_player_setup_body(var_0A);
		so_players_give_loadout();
		return;
	}

	if(var_0A == "so_assault_rescue_2")
	{
		var_0B = "m4_grunt_acog";
		level.so_campaign = "delta";
		foreach(var_0B in level.players)
		{
			so_player_num(var_0C);
			so_player_giveweapon(var_09);
			so_player_set_maxammo(var_09);
			so_player_giveweapon("g36c_reflex");
			so_player_set_maxammo("g36c_reflex");
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_0C);
			so_player_set_switchtoweapon(var_09);
		}

		so_players_give_loadout();
		return;
	}

	if(var_0C == "so_heliswitch_berlin")
	{
		level.so_campaign = "delta";
		foreach(var_0C in level.players)
		{
			so_player_num(var_0D);
			so_player_giveweapon(level.primary_weapon);
			so_player_giveweapon(level.secondary_weapon);
			so_player_set_switchtoweapon(level.primary_weapon);
			so_player_giveweapon("fraggrenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_giveweapon("flash_grenade");
			so_player_setup_body(var_0D);
		}

		so_players_give_loadout();
		return;
	}

	if(var_0D == "so_killspree_paris_a")
	{
		level.so_campaign = "ranger";
		so_player_num(0);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("flash_grenade");
		so_player_set_setoffhandsecondaryclass("flash");
		so_player_giveweapon("pecheneg_so_fastreload");
		so_player_giveweapon("m320");
		so_player_set_switchtoweapon("pecheneg_so_fastreload");
		so_player_setup_body(0);
		so_player_num(1);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("flash_grenade");
		so_player_set_setoffhandsecondaryclass("flash");
		so_player_giveweapon("pecheneg_so_fastreload");
		so_player_giveweapon("m320");
		so_player_set_switchtoweapon("m320");
		so_player_setup_body(1);
		so_players_give_loadout();
		return;
	}

	if(var_0D == "so_zodiac2_ny_harbor")
	{
		level.so_campaign = "delta";
		foreach(var_0D in level.players)
		{
			so_player_num(var_0E);
			so_player_giveweapon(level.primary_weapon);
			so_player_giveweapon(level.secondary_weapon);
			so_player_set_switchtoweapon(level.primary_weapon);
			so_player_giveweapon("fraggrenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_giveweapon("flash_grenade");
			so_player_setup_body(var_0E);
		}

		so_players_give_loadout();
		return;
	}

	if(var_0E == "so_jeep_paris_b")
	{
		level.so_campaign = "delta";
		foreach(var_0C in level.players)
		{
			so_player_num(var_0F);
			var_0D = "m320";
			var_0E = "scar_h_grenadier_reflex";
			so_player_giveweapon(var_0D);
			so_player_giveweapon(var_0E);
			so_player_set_switchtoweapon(var_0D);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_0F);
		}

		so_players_give_loadout();
		return;
	}

	if(var_0F == "so_ac130_paris_ac130")
	{
		level.so_campaign = "delta";
		foreach(var_0D in level.players)
		{
			so_player_num(var_10);
			var_0E = "m4m203_reflex";
			var_0F = "fnfiveseven";
			so_player_giveweapon(var_0E);
			so_player_giveweapon(var_0F);
			so_player_set_switchtoweapon(var_0E);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_setup_body(var_10);
		}

		so_players_give_loadout();
		return;
	}

	if(var_10 == "so_stealth_prague")
	{
		level.so_campaign = "sas";
		level.so_stealth = 1;
		level.coop_incap_weapon = "usp_silencer";
		foreach(var_0E in level.players)
		{
			so_player_num(var_11);
			var_0F = "rsass_silenced";
			var_10 = "usp_silencer";
			so_player_giveweapon(var_0F);
			so_player_giveweapon(var_10);
			so_player_set_switchtoweapon(var_0F);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_11);
		}

		so_players_give_loadout();
		return;
	}

	if(var_11 == "so_stealth_london")
	{
		level.so_campaign = "sas";
		foreach(var_0F in level.players)
		{
			so_player_num(var_12);
			var_10 = "mp5_silencer_eotech";
			var_11 = "usp_silencer";
			so_player_giveweapon(var_10);
			so_player_giveweapon(var_11);
			so_player_set_switchtoweapon(var_10);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_12);
		}

		so_players_give_loadout();
		return;
	}

	if(var_12 == "so_timetrial_london")
	{
		level.so_campaign = "sas";
		foreach(var_10 in level.players)
		{
			so_player_num(var_13);
			var_11 = "mp5";
			var_12 = "spas12_silencer";
			so_player_giveweapon(var_11);
			so_player_giveweapon(var_12);
			so_player_set_switchtoweapon(var_11);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_13);
		}

		so_players_give_loadout();
		return;
	}

	if(var_13 == "so_assaultmine")
	{
		level.so_campaign = "delta";
		foreach(var_11 in level.players)
		{
			so_player_num(var_14);
			var_12 = "rsass";
			var_13 = "acr_hybrid";
			so_player_giveweapon(var_12);
			so_player_giveweapon(var_13);
			so_player_set_switchtoweapon(var_12);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_setup_body(var_14);
		}

		so_players_give_loadout();
		return;
	}

	if(var_14 == "so_deltacamp")
	{
		level.so_campaign = "delta";
		foreach(var_12 in level.players)
		{
			so_player_num(var_15);
			var_13 = "acr";
			var_14 = "usp";
			so_player_giveweapon(var_13);
			so_player_giveweapon(var_14);
			so_player_set_switchtoweapon(var_13);
			so_player_setup_body(var_15);
		}

		so_players_give_loadout();
		return;
	}

	if(var_15 == "so_trainer2_so_deltacamp")
	{
		level.so_campaign = "delta";
		foreach(var_13 in level.players)
		{
			so_player_num(var_16);
			var_14 = "mp5";
			var_15 = "usp";
			so_player_giveweapon(var_14);
			so_player_giveweapon(var_15);
			so_player_set_switchtoweapon(var_14);
			so_player_setup_body(var_16);
		}

		so_players_give_loadout();
		return;
	}

	if(var_16 == "so_milehigh_hijack")
	{
		level.so_campaign = "hijack";
		var_06 = 0;
		while(var_16 < level.players.size)
		{
			so_player_num(var_16);
			so_player_giveweapon("flash_grenade");
			so_player_set_setoffhandsecondaryclass("flash");
			so_player_giveweapon("ak47");
			so_player_giveweapon("fnfiveseven");
			so_player_set_switchtoweapon("ak47");
			so_player_setup_body(var_16);
			var_16++;
		}

		so_players_give_loadout();
		return;
	}

	if(var_16 == "so_rescue_hijack")
	{
		level.so_campaign = "fso";
		level.coop_incap_weapon = "usp_silencer_so";
		foreach(var_16 in level.players)
		{
			so_player_num(var_17);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("usp_silencer_so");
			so_player_set_switchtoweapon("usp_silencer_so");
			so_player_setup_body(var_17);
		}

		so_players_give_loadout();
		return;
	}

	if(var_17 == "so_javelin_hamburg")
	{
		level.so_campaign = "delta";
		foreach(var_15 in level.players)
		{
			so_player_num(var_18);
			var_16 = "javelin";
			var_17 = "scar_h_acog";
			so_player_giveweapon(var_16);
			so_player_giveweapon(var_17);
			so_player_set_switchtoweapon(var_16);
			so_player_giveweapon("fraggrenade");
			so_player_giveweapon("flash_grenade");
			so_player_setup_body(var_18);
		}

		so_players_give_loadout();
		return;
	}

	if(var_18 == "so_assassin_payback")
	{
		level.so_campaign = "delta";
		so_player_num(0);
		so_player_giveweapon(level.sniper_primary);
		so_player_giveweapon(level.sniper_secondary);
		so_player_set_switchtoweapon(level.sniper_primary);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("flash_grenade");
		so_player_setup_body(0);
		so_player_num(1);
		so_player_giveweapon(level.heavy_primary);
		so_player_giveweapon(level.heavy_secondary);
		so_player_set_switchtoweapon(level.heavy_primary);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("flash_grenade");
		so_player_setup_body(1);
		so_players_give_loadout();
		return;
	}

	if(maps\_utility::is_survival())
	{
		level.so_campaign = "delta";
		level.coop_incap_weapon = "fnfiveseven_mp";
		give_default_loadout();
		return;
	}

	level.testmap = 1;
	level.so_campaign = "ranger";
	give_default_loadout();
}

//Function Number: 8
possible_precache(param_00)
{
	foreach(var_02 in param_00)
	{
		precacheitem(var_02);
	}
}

//Function Number: 9
give_default_loadout()
{
	if(maps\_utility::is_coop() || maps\_utility::is_survival())
	{
		var_00 = char_switcher();
		foreach(var_03, var_02 in level.players)
		{
			give_default_loadout_coop(var_03);
		}

		so_players_give_loadout();
		return;
	}

	level.player giveweapon("fraggrenade");
	level.player setoffhandsecondaryclass("flash");
	level.player giveweapon("flash_grenade");
	if(maps\_utility::is_specialop())
	{
		level.player giveweapon("m1014");
	}

	level.player giveweapon("mp5");
	level.player switchtoweapon("mp5");
	level.player setviewmodel("viewmodel_base_viewhands");
}

//Function Number: 10
give_default_loadout_coop(param_00)
{
	so_player_num(param_00);
	so_player_giveweapon("fraggrenade");
	so_player_giveweapon("flash_grenade");
	so_player_set_setoffhandsecondaryclass("flash");
	so_player_giveweapon("mp5");
	so_player_giveweapon("m1014");
	if(param_00 == 0)
	{
		so_player_set_switchtoweapon("mp5");
	}
	else
	{
		so_player_set_switchtoweapon("m1014");
	}

	so_player_setup_body(param_00);
}

//Function Number: 11
saveplayerweaponstatepersistent(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	level.player endon("death");
	if(level.player.health == 0)
	{
		return;
	}

	var_02 = level.player getcurrentprimaryweapon();
	if(!isdefined(var_02) || var_02 == "none")
	{
	}

	game["weaponstates"][param_00]["current"] = var_02;
	var_03 = level.player getcurrentoffhand();
	game["weaponstates"][param_00]["offhand"] = var_03;
	game["weaponstates"][param_00]["list"] = [];
	var_04 = common_scripts\utility::array_combine(level.player getweaponslistprimaries(),level.player getweaponslistoffhands());
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		game["weaponstates"][param_00]["list"][var_05]["name"] = var_04[var_05];
		if(param_01)
		{
			game["weaponstates"][param_00]["list"][var_05]["clip"] = level.player getweaponammoclip(var_04[var_05]);
			game["weaponstates"][param_00]["list"][var_05]["stock"] = level.player getweaponammostock(var_04[var_05]);
		}
	}
}

//Function Number: 12
restoreplayerweaponstatepersistent(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(game["weaponstates"]))
	{
		return 0;
	}

	if(!isdefined(game["weaponstates"][param_00]))
	{
		return 0;
	}

	level.player takeallweapons();
	for(var_02 = 0;var_02 < game["weaponstates"][param_00]["list"].size;var_02++)
	{
		var_03 = game["weaponstates"][param_00]["list"][var_02]["name"];
		if(isdefined(level.legit_weapons))
		{
			if(!isdefined(level.legit_weapons[var_03]))
			{
				continue;
			}
		}

		if(var_03 == "c4")
		{
			continue;
		}

		if(var_03 == "claymore")
		{
			continue;
		}

		level.player giveweapon(var_03);
		level.player givemaxammo(var_03);
		if(param_01)
		{
			level.player setweaponammoclip(var_03,game["weaponstates"][param_00]["list"][var_02]["clip"]);
			level.player setweaponammostock(var_03,game["weaponstates"][param_00]["list"][var_02]["stock"]);
		}
	}

	if(isdefined(level.legit_weapons))
	{
		var_03 = game["weaponstates"][param_00]["offhand"];
		if(isdefined(level.legit_weapons[var_03]))
		{
			level.player switchtooffhand(var_03);
		}

		var_03 = game["weaponstates"][param_00]["current"];
		if(isdefined(level.legit_weapons[var_03]))
		{
			level.player switchtoweapon(var_03);
		}
	}
	else
	{
		level.player switchtooffhand(game["weaponstates"][param_00]["offhand"]);
		level.player switchtoweapon(game["weaponstates"][param_00]["current"]);
	}

	return 1;
}

//Function Number: 13
sniper_escape_initial_secondary_weapon_loadout()
{
	level.player giveweapon("claymore");
	level.player giveweapon("c4");
	if(level.gameskill >= 2)
	{
		level.player setweaponammoclip("claymore",10);
		level.player setweaponammoclip("c4",6);
	}
	else
	{
		level.player setweaponammoclip("claymore",8);
		level.player setweaponammoclip("c4",3);
	}

	level.player setactionslot(4,"weapon","claymore");
	level.player setactionslot(2,"weapon","c4");
	level.player giveweapon("fraggrenade");
	level.player giveweapon("flash_grenade");
	level.player setoffhandsecondaryclass("flash");
	level.player setviewmodel("viewhands_marine_sniper");
}

//Function Number: 14
set_legit_weapons_for_sniper_escape()
{
	var_00 = [];
	var_00 = [];
	level.legit_weapons = var_7B;
}

//Function Number: 15
set_legit_weapons_for_favela_escape()
{
	var_00 = [];
	level.legit_weapons = var_7B;
}

//Function Number: 16
set_legit_weapons_for_dc_whitehouse()
{
	var_00 = [];
	level.legit_weapons = var_7B;
}

//Function Number: 17
max_ammo_on_legit_sniper_escape_weapon()
{
	var_00 = level.player getweaponslistall();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(!isdefined(level.legit_weapons[var_02]))
		{
			continue;
		}

		if(var_02 == "rpg")
		{
			continue;
		}

		level.player givemaxammo(var_02);
	}
}

//Function Number: 18
force_player_to_use_legit_sniper_escape_weapon()
{
	var_00 = level.player getweaponslistall();
	var_01 = [];
	var_02 = 0;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_04 = var_00[var_03];
		var_01[var_04] = 1;
		if(isdefined(level.legit_weapons[var_04]))
		{
			var_02++;
			continue;
		}

		level.player takeweapon(var_04);
	}

	if(var_02 == 2)
	{
		return;
	}

	if(var_02 == 0)
	{
		level.player giveweapon("ak47");
		level.player switchtoweapon("ak47");
	}

	if(!isdefined(var_01[level.sniperescape_main_weapon]) && !isdefined(var_01["dragunov"]))
	{
		level.player giveweapon(level.sniperescape_main_weapon);
		level.player switchtoweapon(level.sniperescape_main_weapon);
	}
}

//Function Number: 19
coop_gamesetup_menu()
{
	maps\_gameskill::setglobaldifficulty();
	foreach(var_01 in level.players)
	{
		var_01 maps\_gameskill::setdifficulty();
	}

	level.character_switched = 0;
	common_scripts\utility::flag_init("character_selected");
	var_03 = "";
	var_04 = [];
	var_04 = strtok(var_03," ");
	foreach(var_06 in var_04)
	{
		if(var_06 == level.script)
		{
			common_scripts\utility::flag_set("character_selected");
		}
	}

	var_08 = "so_ac130_co_hunted co_hunted co_ac130";
	var_09 = [];
	var_09 = strtok(var_08," ");
	foreach(var_06 in var_09)
	{
		if(maps\_utility::is_coop() && var_06 == level.script)
		{
			var_0B = getdvar("ui_ac130_pilot_num");
			if(isdefined(var_0B) && var_0B != "0")
			{
				level.character_switched = 1;
			}

			common_scripts\utility::flag_set("character_selected");
		}
	}
}

//Function Number: 20
coop_gamesetup_ac130()
{
	if(level.specops_character_selector == "so_char_host")
	{
		return level.players[0];
	}

	if(level.specops_character_selector == "so_char_client")
	{
		return level.players[1];
	}

	return level.players[0];
}

//Function Number: 21
give_default_loadout_specialops()
{
	foreach(var_02, var_01 in level.players)
	{
		so_player_num(var_02);
		so_player_giveweapon("fraggrenade");
		so_player_giveweapon("flash_grenade");
		so_player_set_setoffhandsecondaryclass("flash");
		so_player_giveweapon("mp5");
		so_player_giveweapon("m1014");
		so_player_set_switchtoweapon("mp5");
		so_player_setup_body(var_02);
	}

	so_players_give_loadout();
}

//Function Number: 22
so_player_num(param_00)
{
	level.so_player_num = param_00;
	level.so_player_add_player_giveweapon[param_00] = [];
	if(!isdefined(level.so_player_set_maxammo))
	{
		level.so_player_set_maxammo = [];
	}

	if(!isdefined(level.so_player_set_setviewmodel))
	{
		level.so_player_set_setviewmodel = [];
	}

	if(!isdefined(level.so_player_add_player_giveweapon))
	{
		level.so_player_add_player_giveweapon = [];
	}

	if(!isdefined(level.so_player_set_setoffhandsecondaryclass))
	{
		level.so_player_set_setoffhandsecondaryclass = [];
	}

	if(!isdefined(level.so_player_set_switchtoweapon))
	{
		level.so_player_set_switchtoweapon = [];
	}

	if(!isdefined(level.so_player_setmodelfunc))
	{
		level.so_player_setmodelfunc = [];
	}

	if(!isdefined(level.so_player_setmodelfunc_precache))
	{
		level.so_player_setmodelfunc_precache = [];
	}

	if(!isdefined(level.so_player_setactionslot))
	{
		level.so_player_setactionslot = [];
	}

	level.so_player_set_maxammo[param_00] = [];
	level.so_player_set_setoffhandsecondaryclass[param_00] = [];
	level.so_player_add_player_giveweapon[param_00] = [];
}

//Function Number: 23
so_player_giveweapon(param_00)
{
	var_01 = level.so_player_num;
	if(!level.character_selected)
	{
		precacheitem(param_00);
	}

	level.so_player_add_player_giveweapon[var_01][param_00] = 1;
}

//Function Number: 24
so_player_set_maxammo(param_00)
{
	var_01 = level.so_player_num;
	level.so_player_set_maxammo[var_01][param_00] = 1;
}

//Function Number: 25
so_player_set_setoffhandsecondaryclass(param_00)
{
	var_01 = level.so_player_num;
	level.so_player_set_setoffhandsecondaryclass[var_01] = param_00;
}

//Function Number: 26
so_player_set_switchtoweapon(param_00)
{
	var_01 = level.so_player_num;
	level.so_player_set_switchtoweapon[var_01] = param_00;
}

//Function Number: 27
so_player_set_setviewmodel(param_00)
{
	var_01 = level.so_player_num;
	if(!level.character_selected)
	{
		precachemodel(param_00);
	}

	level.so_player_set_setviewmodel[var_01] = param_00;
}

//Function Number: 28
so_player_setmodelfunc(param_00,param_01)
{
	var_02 = level.so_player_num;
	level.so_player_setmodelfunc[var_02] = param_00;
	if(!level.character_selected)
	{
		[[ param_01 ]]();
	}
}

//Function Number: 29
so_player_setactionslot(param_00,param_01,param_02)
{
	var_03 = level.so_player_num;
	var_04 = spawnstruct();
	var_04.slot = param_00;
	var_04.parm1 = param_01;
	if(isdefined(param_02))
	{
		var_04.parm2 = param_02;
	}

	if(isdefined(level.so_player_setactionslot[var_03]))
	{
		var_05 = level.so_player_setactionslot[var_03].size;
	}
	else
	{
		var_05 = 0;
	}

	level.so_player_setactionslot[var_03][var_05] = var_04;
}

//Function Number: 30
so_player_give_loadout(param_00)
{
	var_01 = self;
	if(isdefined(level.so_player_setmodelfunc[param_00]))
	{
		var_01 maps\_utility::setmodelfunc(level.so_player_setmodelfunc[param_00]);
		var_01 setanim(%code,1,0);
	}

	var_02 = getarraykeys(level.so_player_add_player_giveweapon[param_00]);
	foreach(var_04 in var_02)
	{
		var_01 giveweapon(var_04);
		if(isdefined(level.so_player_set_maxammo[param_00][var_04]))
		{
			var_01 givemaxammo(var_04);
		}
	}

	if(isdefined(level.so_player_set_setoffhandsecondaryclass[param_00]))
	{
		var_01 setoffhandsecondaryclass("flash");
	}

	if(isdefined(level.so_player_setactionslot[param_00]))
	{
		var_01 so_players_give_action(param_00);
	}

	if(isdefined(level.so_player_set_switchtoweapon[param_00]))
	{
		var_01 switchtoweapon(level.so_player_set_switchtoweapon[param_00]);
	}

	if(isdefined(level.so_player_set_setviewmodel[param_00]))
	{
		var_01 setviewmodel(level.so_player_set_setviewmodel[param_00]);
	}
}

//Function Number: 31
so_players_give_action(param_00)
{
	var_01 = self;
	foreach(var_03 in level.so_player_setactionslot[param_00])
	{
		if(isdefined(var_03.parm2))
		{
			var_01 setactionslot(var_03.slot,var_03.parm1,var_03.parm2);
			continue;
		}

		var_01 setactionslot(var_03.slot,var_03.parm1);
	}
}

//Function Number: 32
so_players_give_loadout()
{
	foreach(var_02, var_01 in level.players)
	{
		var_01 so_player_give_loadout(var_02);
	}
}

//Function Number: 33
updatemodel(param_00)
{
	self notify("newupdatemodel");
	if(!isdefined(param_00))
	{
		self detachall();
		self setmodel("");
		return;
	}

	self.last_modelfunc = param_00;
	if(isdefined(self.is_hidden) && self.is_hidden)
	{
		return;
	}

	self endon("newupdatemodel");
	for(;;)
	{
		self detachall();
		[[ param_00 ]]();
		self updateplayermodelwithweapons();
		common_scripts\utility::waittill_any_return("weapon_change","weaponchange","player_update_model","player_downed","not_in_last_stand");
	}
}

//Function Number: 34
so_player_setup_body(param_00)
{
	so_player_set_setviewmodel(so_player_get_hands());
	if(maps\_utility::is_coop() || maps\_utility::is_survival())
	{
		so_player_setmodelfunc(so_player_get_bodyfunc(param_00),so_player_get_bodyfunc_precache(param_00));
	}
}

//Function Number: 35
so_player_get_bodyfunc(param_00)
{
	switch(level.so_campaign)
	{
		case "ranger":
			return ::so_body_player_ranger;

		case "seal":
			return ::so_body_player_seal;

		case "arctic":
			return ::so_body_player_arctic;

		case "woodland":
			return ::so_body_player_woodland;

		case "desert":
			return ::so_body_player_desert;

		case "ghillie":
			return ::so_body_player_ghillie;

		case "delta":
			return ::so_body_player_delta;

		case "sas":
			return ::so_body_player_sas;

		case "hijack":
			if(param_00 == 0)
			{
				return ::so_body_player_hijack_1;
			}
			else
			{
				return ::so_body_player_hijack_2;
			}
	
			break;

		case "fso":
			if(param_00 == 0)
			{
				return ::so_body_player_fso_1;
			}
			else
			{
				return ::so_body_player_fso_2;
			}
	
			break;

		default:
			break;
	}
}

//Function Number: 36
so_player_get_bodyfunc_precache(param_00)
{
	switch(level.so_campaign)
	{
		case "ranger":
			return ::so_body_player_ranger_precache;

		case "seal":
			return ::so_body_player_seal_precache;

		case "arctic":
			return ::so_body_player_arctic_precache;

		case "woodland":
			return ::so_body_player_woodland_precache;

		case "desert":
			return ::so_body_player_desert_precache;

		case "ghillie":
			return ::so_body_player_ghillie_precache;

		case "delta":
			return ::so_body_player_delta_precache;

		case "sas":
			return ::so_body_player_sas_precache;

		case "hijack":
			if(param_00 == 0)
			{
				return ::so_body_player_hijack_precache_1;
			}
			else
			{
				return ::so_body_player_hijack_precache_2;
			}
	
			break;

		case "fso":
			if(param_00 == 0)
			{
				return ::so_body_player_fso_precache_1;
			}
			else
			{
				return ::so_body_player_fso_precache_2;
			}
	
			break;
	}
}

//Function Number: 37
so_player_get_hands()
{
	switch(level.so_campaign)
	{
		case "ranger":
			return "viewmodel_base_viewhands";

		case "seal":
			return "viewhands_udt";

		case "arctic":
			return "viewhands_arctic";

		case "woodland":
			return "viewhands_sas_woodland";

		case "desert":
			return "viewhands_tf141";

		case "ghillie":
			return "viewhands_marine_sniper";

		case "delta":
			return "viewhands_delta";

		case "sas":
			return "viewhands_sas";

		case "hijack":
			return "viewhands_henchmen";

		case "fso":
			return "viewhands_fso";
	}
}

//Function Number: 38
so_body_player_ranger()
{
	self setmodel("coop_body_us_army");
	self attach("coop_head_us_army","",1);
}

//Function Number: 39
so_body_player_seal()
{
	self setmodel("coop_body_seal_udt");
	self attach("coop_head_seal_udt","",1);
}

//Function Number: 40
so_body_player_arctic()
{
	self setmodel("coop_body_tf141_arctic");
	self attach("coop_head_tf141_arctic","",1);
}

//Function Number: 41
so_body_player_woodland()
{
	self setmodel("coop_body_tf141_forest");
	self attach("coop_head_tf141_forest","",1);
}

//Function Number: 42
so_body_player_desert()
{
	self setmodel("coop_body_tf141_desert");
	self attach("coop_head_tf141_desert","",1);
}

//Function Number: 43
so_body_player_ghillie()
{
	self setmodel("coop_body_ghillie_forest");
	self attach("coop_head_ghillie_forest","",1);
}

//Function Number: 44
so_body_player_delta()
{
	self setmodel("mp_body_delta_elite_assault_bb");
	self attach("head_delta_elite_a","",1);
}

//Function Number: 45
so_body_player_sas()
{
	self setmodel("body_mp_sas_urban_specops");
}

//Function Number: 46
so_body_player_hijack_1()
{
	self setmodel("mp_body_henchmen_assault_d");
	self attach("head_henchmen_a","",1);
}

//Function Number: 47
so_body_player_hijack_2()
{
	self setmodel("mp_body_henchmen_shotgun_a");
	self attach("head_henchmen_c","",1);
}

//Function Number: 48
so_body_player_fso_1()
{
	self setmodel("mp_body_fso_vest_c_dirty");
	self attach("head_fso_e_dirty","",1);
}

//Function Number: 49
so_body_player_fso_2()
{
	self setmodel("mp_body_fso_vest_d_dirty");
	self attach("head_fso_d_dirty","",1);
}

//Function Number: 50
so_body_player_ranger_precache()
{
	precachemodel("coop_body_us_army");
	precachemodel("coop_head_us_army");
}

//Function Number: 51
so_body_player_seal_precache()
{
	precachemodel("coop_body_seal_udt");
	precachemodel("coop_head_seal_udt");
}

//Function Number: 52
so_body_player_arctic_precache()
{
	precachemodel("coop_body_tf141_arctic");
	precachemodel("coop_head_tf141_arctic");
}

//Function Number: 53
so_body_player_woodland_precache()
{
	precachemodel("coop_body_tf141_forest");
	precachemodel("coop_head_tf141_forest");
}

//Function Number: 54
so_body_player_desert_precache()
{
	precachemodel("coop_body_tf141_desert");
	precachemodel("coop_head_tf141_desert");
}

//Function Number: 55
so_body_player_ghillie_precache()
{
	precachemodel("coop_body_ghillie_forest");
	precachemodel("coop_head_ghillie_forest");
}

//Function Number: 56
so_body_player_delta_precache()
{
	precachemodel("mp_body_delta_elite_assault_bb");
	precachemodel("head_delta_elite_a");
}

//Function Number: 57
so_body_player_sas_precache()
{
	precachemodel("body_mp_sas_urban_specops");
}

//Function Number: 58
so_body_player_hijack_precache_1()
{
	precachemodel("mp_body_henchmen_assault_d");
	precachemodel("head_henchmen_a");
}

//Function Number: 59
so_body_player_hijack_precache_2()
{
	precachemodel("mp_body_henchmen_shotgun_a");
	precachemodel("head_henchmen_c");
}

//Function Number: 60
so_body_player_fso_precache_1()
{
	precachemodel("mp_body_fso_vest_c_dirty");
	precachemodel("head_fso_e_dirty");
}

//Function Number: 61
so_body_player_fso_precache_2()
{
	precachemodel("mp_body_fso_vest_d_dirty");
	precachemodel("head_fso_d_dirty");
}