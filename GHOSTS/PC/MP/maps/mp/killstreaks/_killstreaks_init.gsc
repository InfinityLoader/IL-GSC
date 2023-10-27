/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_killstreaks_init.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 34 ms
 * Timestamp: 10/27/2023 1:21:12 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	maps\mp\killstreaks\_killstreaks::func_4632();
	level.killstreakfuncs = [];
	level.killstreaksetupfuncs = [];
	level.killstreakweapons = [];
	thread maps\mp\killstreaks\_uav::func_44DF();
	thread maps\mp\killstreaks\_plane::func_44DF();
	thread maps\mp\killstreaks\_airdrop::func_44DF();
	thread maps\mp\killstreaks\_helicopter::func_44DF();
	thread maps\mp\killstreaks\_nuke::func_44DF();
	thread maps\mp\killstreaks\_a10::func_44DF();
	thread maps\mp\killstreaks\_portableaoegenerator::func_44DF();
	thread maps\mp\killstreaks\_ims::func_44DF();
	thread maps\mp\killstreaks\_perkstreaks::func_44DF();
	thread maps\mp\killstreaks\_juggernaut::func_44DF();
	thread lib_05F3::func_44DF();
	thread maps\mp\killstreaks\_autosentry::func_44DF();
	thread maps\mp\killstreaks\_remotemissile::func_44DF();
	thread maps\mp\killstreaks\_deployablebox::func_44DF();
	thread maps\mp\killstreaks\_deployablebox_vest::func_44DF();
	thread maps\mp\killstreaks\_deployablebox_gun::func_44DF();
	thread maps\mp\killstreaks\_helisniper::func_44DF();
	thread maps\mp\killstreaks\_helicopter_pilot::func_44DF();
	thread maps\mp\killstreaks\_vanguard::func_44DF();
	thread maps\mp\killstreaks\_uplink::func_44DF();
	thread maps\mp\killstreaks\_dronehive::func_44DF();
	thread maps\mp\killstreaks\_jammer::func_44DF();
	thread maps\mp\killstreaks\_air_superiority::func_44DF();
	thread maps\mp\killstreaks\_odin::func_44DF();
	thread lib_0608::func_44DF();
	thread lib_05E9::func_44DF();
	level.killstreakweildweapons = [];
	level.killstreakweildweapons["sentry_minigun_mp"] = "sentry";
	level.killstreakweildweapons["hind_bomb_mp"] = "helicopter";
	level.killstreakweildweapons["hind_missile_mp"] = "helicopter";
	level.killstreakweildweapons["cobra_20mm_mp"] = "helicopter";
	level.killstreakweildweapons["nuke_mp"] = "nuke";
	level.killstreakweildweapons["manned_littlebird_sniper_mp"] = "heli_sniper";
	level.killstreakweildweapons["iw6_minigunjugg_mp"] = "airdrop_juggernaut";
	level.killstreakweildweapons["iw6_p226jugg_mp"] = "airdrop_juggernaut";
	level.killstreakweildweapons["mortar_shelljugg_mp"] = "airdrop_juggernaut";
	level.killstreakweildweapons["iw6_riotshieldjugg_mp"] = "airdrop_juggernaut_recon";
	level.killstreakweildweapons["iw6_magnumjugg_mp"] = "airdrop_juggernaut_recon";
	level.killstreakweildweapons["smoke_grenadejugg_mp"] = "airdrop_juggernaut_recon";
	level.killstreakweildweapons["iw6_knifeonlyjugg_mp"] = "airdrop_juggernaut_maniac";
	level.killstreakweildweapons["throwingknifejugg_mp"] = "airdrop_juggernaut_maniac";
	level.killstreakweildweapons["deployable_vest_marker_mp"] = "deployable_vest";
	level.killstreakweildweapons["deployable_weapon_crate_marker_mp"] = "deployable_ammo";
	level.killstreakweildweapons["heli_pilot_turret_mp"] = "heli_pilot";
	level.killstreakweildweapons["guard_dog_mp"] = "guard_dog";
	level.killstreakweildweapons["ims_projectile_mp"] = "ims";
	level.killstreakweildweapons["ball_drone_gun_mp"] = "ball_drone_backup";
	level.killstreakweildweapons["drone_hive_projectile_mp"] = "drone_hive";
	level.killstreakweildweapons["switch_blade_child_mp"] = "drone_hive";
	level.killstreakweildweapons["iw6_maaws_mp"] = "aa_launcher";
	level.killstreakweildweapons["iw6_maawschild_mp"] = "aa_launcher";
	level.killstreakweildweapons["iw6_maawshoming_mp"] = "aa_launcher";
	level.killstreakweildweapons["killstreak_uplink_mp"] = "uplink";
	level.killstreakweildweapons["odin_projectile_large_rod_mp"] = "odin_assault";
	level.killstreakweildweapons["odin_projectile_small_rod_mp"] = "odin_assault";
	level.killstreakweildweapons["iw6_gm6helisnipe_mp"] = "heli_sniper";
	level.killstreakweildweapons["iw6_gm6helisnipe_mp_gm6scope"] = "heli_sniper";
	level.killstreakweildweapons["aamissile_projectile_mp"] = "air_superiority";
	level.killstreakweildweapons["airdrop_marker_mp"] = "airdrop_assault";
	level.killstreakweildweapons["remote_tank_projectile_mp"] = "vanguard";
	level.killstreakweildweapons["killstreak_vanguard_mp"] = "vanguard";
	level.killstreakweildweapons["agent_mp"] = "agent";
	level.killstreakweildweapons["agent_support_mp"] = "recon_agent";
	level.killstreakweildweapons["iw6_axe_mp"] = "juggernaut_swamp_slasher";
	level.killstreakweildweapons["venomxgun_mp"] = "venom_x_gun";
	level.killstreakweildweapons["venomxproj_mp"] = "venom_x_projectile";
	level.killstreakweildweapons["iw6_predatorcannon_mp"] = "juggernaut_predator";
	level.killstreakweildweapons["iw6_predatorsuicide_mp"] = "juggernaut_predator";
	level.killstreakweildweapons["volcano_rock_mp"] = "volcano";
	level.killstreakweildweapons["ac130_105mm_mp"] = "ac130";
	level.killstreakweildweapons["ac130_40mm_mp"] = "ac130";
	level.killstreakweildweapons["ac130_25mm_mp"] = "ac130";
	level.killstreakweildweapons["iw6_mariachimagnum_mp_akimbo"] = "juggernaut_death_mariachi";
	level.killstreakweildweapons["harrier_20mm_mp"] = "harrier_airstrike";
	level.killstreakweildweapons["artillery_mp"] = "harrier_airstrike";
	if(isdefined(level.mapcustomkillstreakfunc))
	{
		[[ level.mapcustomkillstreakfunc ]]();
	}

	level.killstreakrounddelay = maps\mp\_utility::func_3ADD("scr_game_killstreakdelay",8);
	level thread maps\mp\killstreaks\_killstreaks::func_595D();
}