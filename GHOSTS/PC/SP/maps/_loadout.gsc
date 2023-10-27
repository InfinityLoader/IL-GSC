/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_loadout.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:24:52 AM
*******************************************************************/

//Function Number: 1
func_4568()
{
	if(!isdefined(level.var_1973))
	{
		level.var_1973 = "american";
	}

	give_loadout();
	maps\_loadout_code::func_4E9E();
}

//Function Number: 2
give_loadout()
{
	if(isdefined(level.var_2868))
	{
	}

	var_00 = maps\_loadout_code::get_loadout();
	level.player maps\_loadout_code::func_7014();
	level.has_loadout = 0;
	maps\_loadout_code::func_1973("british");
	maps\_loadout_code::persist("innocent","london","flash");
	maps\_loadout_code::func_4E9D("london","mp5_silencer_eotech","fraggrenade","flash_grenade",undefined,"viewhands_sas","flash");
	maps\_loadout_code::func_4E9D("innocent","mp5_silencer_eotech","usp_silencer","flash_grenade","fraggrenade","viewhands_sas","flash");
	maps\_loadout_code::func_1973("delta");
	maps\_loadout_code::func_4E9D("prologue","noweapon_youngblood",undefined,undefined,undefined,"viewhands_gs_hostage",undefined);
	maps\_loadout_code::func_4E9D("deer_hunt","honeybadger+acog_sp","m9a1","fraggrenade",undefined,"viewhands_us_rangers",undefined);
	maps\_loadout_code::func_4E9D("nml","honeybadger+acog_sp","p226",undefined,undefined,"viewhands_us_rangers",undefined);
	maps\_loadout_code::func_4E9D("enemyhq","sc2010+reflex_sp",undefined,"flash_grenade","fraggrenade","viewhands_us_rangers",undefined);
	maps\_loadout_code::func_4E9D("homecoming","cz805bren+acog_sp","m9a1","flash_grenade","fraggrenade","viewhands_us_rangers","flash");
	maps\_loadout_code::func_4E9D("flood","r5rgp+reflex_sp","p226","flash_grenade","fraggrenade","viewhands_gs_flood","flash");
	maps\_loadout_code::func_4E9D("cornered","imbel+acog_sp+silencer_sp","kriss+eotechsmg_sp+silencer_sp","flash_grenade","fraggrenade","viewhands_gs_stealth","flash");
	maps\_loadout_code::func_4E9D("oilrocks","sc2010+acog_sp","m9a1","flash_grenade","fraggrenade","viewhands_devgru_elite","flash");
	maps\_loadout_code::func_4E9D("jungle_ghosts","m4_silencer_reflex","fraggrenade",undefined,undefined,"viewhands_gs_jungle_b",undefined);
	maps\_loadout_code::func_4E9D("clockwork","gm6+scopegm6_sp+silencer03_sp","cz805bren+reflex_sp+silencer_sp","flash_grenade","fraggrenade","viewhands_player_fed_army_arctic","flash");
	maps\_loadout_code::func_4E9D("black_ice","r5rgp+reflex_sp","p226","flash_grenade","fraggrenade","viewhands_us_udt","flash");
	maps\_loadout_code::func_4E9D("ship_graveyard","aps_underwater+swim",undefined,undefined,undefined,"viewhands_us_udt",undefined);
	maps\_loadout_code::func_4E9D("factory","honeybadger+grip_sp+reflex_sp","p226_tactical+silencerpistol_sp+tactical_sp","flash_grenade","fraggrenade","viewhands_devgru_elite","flash");
	maps\_loadout_code::func_4E9D("las_vegas","r5rgp+acog_sp","fraggrenade",undefined,undefined,"viewhands_gs_hostage","flash");
	maps\_loadout_code::func_4E9D("carrier","g28+acog_sp","msbs+eotech_sp","flash_grenade","fraggrenade","viewhands_gs_stealth","flash");
	maps\_loadout_code::func_4E9D("satfarm","lsat","kriss+eotechsmg_sp","flash_grenade","fraggrenade","viewhands_gs_stealth","flash");
	maps\_loadout_code::func_4E9D("loki","arx160_space+acog_sp+glarx160_sp",undefined,undefined,undefined,"viewhands_us_space",undefined);
	maps\_loadout_code::func_4E9D("skyway","fads+acog_sp","k7+reflexsmg_sp","flash_grenade","semtex_grenade","viewhands_gs_stealth","flash");
	maps\_loadout_code::func_4E9D("youngblood","noweapon_youngblood",undefined,undefined,undefined,"viewhands_gs_hostage",undefined);
	maps\_loadout_code::func_4E9D("odin","microtar_space_interior+acogsmg_sp",undefined,undefined,undefined,"viewhands_us_space",undefined);
	maps\_loadout_code::func_4E9D("hamburg","m4m203_acog_payback","smaw_nolock","flash_grenade","fraggrenade","viewhands_delta","flash");
	maps\_loadout_code::func_4E9D("prague","rsass_hybrid_silenced","usp_silencer","flash_grenade","fraggrenade","viewhands_yuri_europe","flash");
	maps\_loadout_code::func_4E9D("payback","m4m203_acog_payback","deserteagle","flash_grenade","fraggrenade","viewhands_yuri","flash");
	maps\_loadout_code::default_loadout_if_notset();
}