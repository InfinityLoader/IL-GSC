/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_init_mp.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 53 ms
 * Timestamp: 10/27/2023 12:28:51 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_9888();
	level.var_A6B2 = [];
	thread scripts\mp\killstreaks\_target_marker::init();
	thread scripts\mp\killstreaks\_uav::init();
	thread scripts\mp\killstreaks\_plane::init();
	thread scripts\mp\killstreaks\_airdrop::init();
	thread scripts\mp\killstreaks\_helicopter::init();
	thread scripts\mp\killstreaks\_nuke::init();
	thread scripts\mp\killstreaks\_a10::init();
	thread scripts\mp\killstreaks\_portableaoegenerator::init();
	thread scripts\mp\killstreaks\_ims::init();
	thread scripts\mp\killstreaks\_perkstreaks::init();
	thread scripts\mp\killstreaks\_juggernaut::init();
	thread scripts\mp\killstreaks\_ball_drone::init();
	thread scripts\mp\killstreaks\_autosentry::init();
	thread scripts\mp\killstreaks\_remotemissile::init();
	thread scripts\mp\killstreaks\_deployablebox::init();
	thread scripts\mp\killstreaks\_deployablebox_vest::init();
	thread scripts\mp\killstreaks\_deployablebox_gun::init();
	thread scripts\mp\killstreaks\_helisniper::init();
	thread scripts\mp\killstreaks\_helicopter_pilot::init();
	thread scripts\mp\killstreaks\_vanguard::init();
	thread scripts\mp\killstreaks\_uplink::init();
	thread scripts\mp\killstreaks\_dronehive::init();
	thread scripts\mp\killstreaks\_jammer_drone::init();
	thread scripts\mp\killstreaks\_air_superiority::init();
	thread scripts\mp\killstreaks\_odin::init();
	thread scripts\mp\killstreaks\_highvaluetarget::init();
	thread scripts\mp\killstreaks\_aalauncher::init();
	thread scripts\mp\killstreaks\_airstrike::init();
	thread scripts\mp\killstreaks\_orbital_deployment::init();
	thread scripts\mp\killstreaks\_deployable_speed_strip::init();
	thread scripts\mp\killstreaks\_deployable_adrenaline_mist::init();
	thread scripts\mp\killstreaks\_minijackal::init();
	thread scripts\mp\killstreaks\_spiderbot::init();
	thread scripts\mp\killstreaks\_thor::init();
	thread scripts\mp\killstreaks\_rc8::init();
	thread scripts\mp\killstreaks\_bombardment::init();
	thread scripts\mp\killstreaks\_venom::init();
	level.var_A6C5 = [];
	level.var_A6C5["sentry_minigun_mp"] = "sentry";
	level.var_A6C5["sentry_laser_mp"] = "sentry";
	level.var_A6C5["sentry_shock_mp"] = "sentry_shock";
	level.var_A6C5["sentry_shock_fast_mp"] = "sentry_shock";
	level.var_A6C5["sentry_shock_missile_mp"] = "sentry_shock";
	level.var_A6C5["sentry_shock_grenade_mp"] = "sentry_shock";
	level.var_A6C5["hind_bomb_mp"] = "helicopter";
	level.var_A6C5["hind_missile_mp"] = "helicopter";
	level.var_A6C5["cobra_20mm_mp"] = "helicopter";
	level.var_A6C5["nuke_mp"] = "nuke";
	level.var_A6C5["manned_littlebird_sniper_mp"] = "heli_sniper";
	level.var_A6C5["iw6_minigunjugg_mp"] = "airdrop_juggernaut";
	level.var_A6C5["iw6_p226jugg_mp"] = "airdrop_juggernaut";
	level.var_A6C5["mortar_shelljugg_mp"] = "airdrop_juggernaut";
	level.var_A6C5["iw6_riotshieldjugg_mp"] = "airdrop_juggernaut_recon";
	level.var_A6C5["iw6_magnumjugg_mp"] = "airdrop_juggernaut_recon";
	level.var_A6C5["smoke_grenadejugg_mp"] = "airdrop_juggernaut_recon";
	level.var_A6C5["iw7_knifejugg_mp"] = "airdrop_juggernaut_maniac";
	level.var_A6C5["throwingknifejugg_mp"] = "airdrop_juggernaut_maniac";
	level.var_A6C5["deployable_vest_marker_mp"] = "deployable_vest";
	level.var_A6C5["deployable_weapon_crate_marker_mp"] = "deployable_ammo";
	level.var_A6C5["heli_pilot_turret_mp"] = "heli_pilot";
	level.var_A6C5["guard_dog_mp"] = "guard_dog";
	level.var_A6C5["ims_projectile_mp"] = "ims";
	level.var_A6C5["ball_drone_gun_mp"] = "ball_drone_backup";
	level.var_A6C5["drone_hive_projectile_mp"] = "drone_hive";
	level.var_A6C5["switch_blade_child_mp"] = "drone_hive";
	level.var_A6C5["drone_hive_impulse_mp"] = "drone_hive";
	level.var_A6C5["switch_blade_impulse_mp"] = "drone_hive";
	level.var_A6C5["killstreak_uplink_mp"] = "uplink";
	level.var_A6C5["odin_projectile_large_rod_mp"] = "odin_assault";
	level.var_A6C5["odin_projectile_small_rod_mp"] = "odin_assault";
	level.var_A6C5["iw6_gm6helisnipe_mp"] = "heli_sniper";
	level.var_A6C5["iw6_gm6helisnipe_mp_gm6scope"] = "heli_sniper";
	level.var_A6C5["aamissile_projectile_mp"] = "air_superiority";
	level.var_A6C5["airdrop_marker_mp"] = "airdrop";
	level.var_A6C5["remote_tank_projectile_mp"] = "vanguard";
	level.var_A6C5["killstreak_vanguard_mp"] = "vanguard";
	level.var_A6C5["agent_mp"] = "agent";
	level.var_A6C5["agent_support_mp"] = "recon_agent";
	level.var_A6C5["iw6_axe_mp"] = "juggernaut_swamp_slasher";
	level.var_A6C5["venomxgun_mp"] = "venom_x_gun";
	level.var_A6C5["venomxproj_mp"] = "venom_x_projectile";
	level.var_A6C5["artillery_mp"] = "precision_airstrike";
	level.var_A6C5["deployable_speed_strip_marker_mp"] = "deployable_speed_strip";
	level.var_A6C5["deployable_adrenaline_mist_marker_mp"] = "deployable_adrenaline_mist";
	level.var_A6C5["killstreak_fleet_swarm_mp"] = "fleet_swarm";
	level.var_A6C5["fleet_swarm_projectile_mp"] = "fleet_swarm";
	level.var_A6C5["killstreak_orbital_deployment_mp"] = "orbital_deployment";
	level.var_A6C5["shockproj_mp"] = "minijackal";
	level.var_A6C5["thorproj_mp"] = "thor";
	level.var_A6C5["thorproj_tracking_mp"] = "thor";
	level.var_A6C5["thorproj_zoomed_mp"] = "thor";
	level.var_A6C5["minijackal_strike_mp"] = "minijackal";
	level.var_A6C5["minijackal_assault_mp"] = "minijackal";
	level.var_A6C5["killstreak_spiderbot_mp"] = "spiderbot";
	level.var_A6C5["iw7_webhook_mp"] = "spiderbot";
	level.var_A6C5["bombproj_mp"] = "bombardment";
	level.var_A6C5["dummy_spike_large_mp"] = "remote_c8";
	level.var_A6C5["iw7_c8destruct_mp"] = "remote_c8";
	level.var_A6C5["iw7_c8shutdown_mp"] = "remote_c8";
	level.var_A6C5["iw7_c8landing_mp"] = "remote_c8";
	level.var_A6C5["iw7_c8offhandshield_mp"] = "remote_c8";
	level.var_A6C5["iw7_chargeshot_c8_mp"] = "remote_c8";
	level.var_A6C5["iw7_minigun_c8_mp"] = "remote_c8";
	level.var_A6C5["dummy_spike_mp"] = "remote_c8";
	level.var_A6C5["venomproj_mp"] = "venom";
	level.var_A6C5["shard_ball_mp"] = "venom";
	level.var_A6C5["jackal_turret_mp"] = "jackal";
	level.var_A6C5["jackal_cannon_mp"] = "jackal";
	level.var_A6C5["jackal_fast_cannon_mp"] = "airdrop";
	level.var_A6C5["jackal_airstrike_turret_mp"] = "precision_airstrike";
	level.var_A6C5["deploy_dronepackage_mp"] = "marker";
	level.var_A6C5["deploy_rc8_mp"] = "marker";
	level.var_A6C5["deploy_warden_mp"] = "marker";
	if(isdefined(level.var_B334))
	{
		[[ level.var_B334 ]]();
	}

	level.var_A6AA = scripts\mp\_utility::func_7F1D("scr_game_killstreakdelay",12);
	level thread scripts\mp\killstreaks\_killstreaks::func_C56E();
	scripts\mp\killstreaks\_mapselect::func_B337();
}