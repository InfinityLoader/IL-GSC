/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\perks\_perks.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 1189 ms
 * Timestamp: 10/27/2023 12:30:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread scripts\mp\perks\_weaponpassives::func_13CB1();
	level.var_CA51 = [];
	level.var_108D3["enemy"] = "tactical_insertion_marker_wm_dropmodel";
	level.var_108D3["friendly"] = "tactical_insertion_marker_wm_dropmodel";
	level.var_108D2["enemy"] = loadfx("vfx/core/mp/core/vfx_flare_glow_en.vfx");
	level.var_108D2["friendly"] = loadfx("vfx/core/mp/core/vfx_flare_glow_fr.vfx");
	level.var_10888 = loadfx("vfx/props/barrelexp.vfx");
	level._effect["ricochet"] = loadfx("vfx/core/impacts/large_metalhit_1");
	level._effect["tracker_cloak_tag"] = loadfx("vfx/iw7/_requests/mp/vfx_tesla_shock_sparks_tracker.vfx");
	level.var_B674 = [];
	level.var_EF86 = [];
	level.var_CA60 = [];
	level.var_CA66 = [];
	level.var_6A50 = [];
	level.var_B676 = [];
	level.var_EF86["specialty_afterburner"] = 1;
	level.var_EF86["specialty_blastshield"] = 1;
	level.var_EF86["specialty_autospot"] = 1;
	level.var_EF86["specialty_boom"] = 1;
	level.var_EF86["specialty_delaymine"] = 1;
	level.var_EF86["specialty_dexterity"] = 1;
	level.var_EF86["specialty_empimmune"] = 1;
	level.var_EF86["specialty_engineer"] = 1;
	level.var_EF86["specialty_explosivedamage"] = 1;
	level.var_EF86["specialty_extraammo"] = 1;
	level.var_EF86["specialty_falldamage"] = 1;
	level.var_EF86["specialty_ghost"] = 1;
	level.var_EF86["specialty_hard_shell"] = 1;
	level.var_EF86["specialty_hardline"] = 1;
	level.var_EF86["specialty_powercell"] = 1;
	level.var_EF86["specialty_hunter"] = 1;
	level.var_EF86["specialty_incog"] = 1;
	level.var_EF86["specialty_localjammer"] = 1;
	level.var_EF86["specialty_overclock"] = 1;
	level.var_EF86["specialty_outlinekillstreaks"] = 1;
	level.var_EF86["specialty_pitcher"] = 1;
	level.var_EF86["specialty_regenfaster"] = 1;
	level.var_EF86["specialty_stun_resistance"] = 1;
	level.var_EF86["specialty_tracker"] = 1;
	level.var_EF86["specialty_twoprimaries"] = 1;
	level.var_EF86["specialty_bullet_outline"] = 1;
	level.var_EF86["specialty_activereload"] = 1;
	level.var_EF86["specialty_sixth_sense"] = 1;
	level.var_EF86["specialty_enhanced_sixth_sense"] = 1;
	level.var_EF86["specialty_meleekill"] = 1;
	level.var_EF86["specialty_gung_ho"] = 1;
	level.var_EF86["specialty_man_at_arms"] = 1;
	level.var_EF86["specialty_blast_suppressor"] = 1;
	level.var_EF86["specialty_momentum"] = 1;
	level.var_EF86["specialty_improvedmelee"] = 1;
	level.var_EF86["specialty_thief"] = 1;
	level.var_EF86["specialty_silentkill"] = 1;
	level.var_EF86["specialty_armorpiercingks"] = 1;
	level.var_EF86["specialty_fastcrouch"] = 1;
	level.var_EF86["specialty_battleslide"] = 1;
	level.var_EF86["specialty_battleslide_offense"] = 1;
	level.var_EF86["specialty_battleslide_shield"] = 1;
	level.var_EF86["specialty_disruptor_punch"] = 1;
	level.var_EF86["specialty_ground_pound"] = 1;
	level.var_EF86["specialty_ground_pound_shield"] = 1;
	level.var_EF86["specialty_ground_pound_shock"] = 1;
	level.var_EF86["specialty_thruster"] = 1;
	level.var_EF86["specialty_dodge"] = 1;
	level.var_EF86["specialty_extra_dodge"] = 1;
	level.var_EF86["specialty_extend_dodge"] = 1;
	level.var_EF86["specialty_phase_slide"] = 1;
	level.var_EF86["specialty_tele_slide"] = 1;
	level.var_EF86["specialty_phaseslash"] = 1;
	level.var_EF86["specialty_phaseslash_rephase"] = 1;
	level.var_EF86["specialty_phase_fall"] = 1;
	level.var_EF86["specialty_aura_regen"] = 1;
	level.var_EF86["specialty_aura_quickswap"] = 1;
	level.var_EF86["specialty_aura_speed"] = 1;
	level.var_EF86["specialty_mark_targets"] = 1;
	level.var_EF86["specialty_batterypack"] = 1;
	level.var_EF86["specialty_camo_elite"] = 1;
	level.var_EF86["specialty_scorestreakpack"] = 1;
	level.var_EF86["specialty_superpack"] = 1;
	level.var_EF86["specialty_dodge_defense"] = 1;
	level.var_EF86["specialty_spawncloak"] = 1;
	level.var_EF86["specialty_commando"] = 1;
	level.var_EF86["specialty_personal_trophy"] = 1;
	level.var_EF86["specialty_equipment_ping"] = 1;
	level.var_EF86["specialty_rugged_eqp"] = 1;
	level.var_EF86["specialty_cloak"] = 1;
	level.var_EF86["specialty_wall_lock"] = 1;
	level.var_EF86["specialty_rush"] = 1;
	level.var_EF86["specialty_hover"] = 1;
	level.var_EF86["specialty_scavenger_eqp"] = 1;
	level.var_EF86["specialty_spawnview"] = 1;
	level.var_EF86["specialty_headgear"] = 1;
	level.var_EF86["specialty_ftlslide"] = 1;
	level.var_EF86["specialty_improved_prone"] = 1;
	level.var_EF86["specialty_support_killstreaks"] = 1;
	level.var_EF86["specialty_overrideweaponspeed"] = 1;
	level.var_EF86["specialty_ballcarrier"] = 1;
	level.var_EF86["specialty_cloak_aerial"] = 1;
	level.var_EF86["specialty_spawn_radar"] = 1;
	level.var_EF86["specialty_ads_awareness"] = 1;
	level.var_EF86["specialty_rearguard"] = 1;
	level.var_EF86["specialty_sharp_focus"] = 1;
	level.var_EF86["specialty_bling"] = 1;
	level.var_EF86["specialty_moredamage"] = 1;
	level.var_EF86["specialty_comexp"] = 1;
	level.var_EF86["specialty_paint"] = 1;
	level.var_EF86["specialty_paint_pro"] = 1;
	level.var_EF86["specialty_adrenaline"] = 1;
	level.var_EF86["specialty_adrenaline_lite"] = 1;
	level.var_EF86["specialty_block_health_regen"] = 1;
	level.var_EF86["specialty_rshieldradar"] = 1;
	level.var_EF86["specialty_rshieldscrambler"] = 1;
	level.var_EF86["specialty_combathigh"] = 1;
	level.var_EF86["specialty_finalstand"] = 1;
	level.var_EF86["specialty_c4death"] = 1;
	level.var_EF86["specialty_juiced"] = 1;
	level.var_EF86["specialty_revenge"] = 1;
	level.var_EF86["specialty_light_armor"] = 1;
	level.var_EF86["specialty_carepackage"] = 1;
	level.var_EF86["specialty_stopping_power"] = 1;
	level.var_EF86["specialty_uav"] = 1;
	level.var_EF86["specialty_viewkickoverride"] = 1;
	level.var_EF86["specialty_affinityspeedboost"] = 1;
	level.var_EF86["specialty_affinityextralauncher"] = 1;
	level.var_EF86["bouncingbetty_mp"] = 1;
	level.var_EF86["c4_mp"] = 1;
	level.var_EF86["claymore_mp"] = 1;
	level.var_EF86["frag_grenade_mp"] = 1;
	level.var_EF86["semtex_mp"] = 1;
	level.var_EF86["cluster_grenade_mp"] = 1;
	level.var_EF86["throwingknife_mp"] = 1;
	level.var_EF86["throwingknifec4_mp"] = 1;
	level.var_EF86["throwingknifeteleport_mp"] = 1;
	level.var_EF86["throwingknifejugg_mp"] = 1;
	level.var_EF86["throwingknifesmokewall_mp"] = 1;
	level.var_EF86["proximity_explosive_mp"] = 1;
	level.var_EF86["mortar_shelljugg_mp"] = 1;
	level.var_EF86["case_bomb_mp"] = 1;
	level.var_EF86["blackhole_grenade_mp"] = 1;
	level.var_EF86["throwingreaper_mp"] = 1;
	level.var_EF86["transponder_mp"] = 1;
	level.var_EF86["sonic_sensor_mp"] = 1;
	level.var_EF86["sticky_mine_mp"] = 1;
	level.var_EF86["throwingknifedisruptor_mp"] = 1;
	level.var_EF86["pulse_grenade_mp"] = 1;
	level.var_EF86["portal_grenade_mp"] = 1;
	level.var_EF86["virus_grenade_mp"] = 1;
	level.var_EF86["concussion_grenade_mp"] = 1;
	level.var_EF86["sensor_grenade_mp"] = 1;
	level.var_EF86["gravity_grenade_mp"] = 1;
	level.var_EF86["flash_grenade_mp"] = 1;
	level.var_EF86["smoke_grenade_mp"] = 1;
	level.var_EF86["smoke_grenadejugg_mp"] = 1;
	level.var_EF86["emp_grenade_mp"] = 1;
	level.var_EF86["specialty_tacticalinsertion"] = 1;
	level.var_EF86["trophy_mp"] = 1;
	level.var_EF86["motion_sensor_mp"] = 1;
	level.var_EF86["proto_ricochet_device_mp"] = 1;
	level.var_EF86["bulletstorm_device_mp"] = 1;
	level.var_EF86["mobile_radar_mp"] = 1;
	level.var_EF86["gas_grenade_mp"] = 1;
	level.var_EF86["blackout_grenade_mp"] = 1;
	level.var_EF86["proxy_bomb_mp"] = 1;
	level.var_EF86["adrenaline_mist_mp"] = 1;
	level.var_EF86["domeshield_mp"] = 1;
	level.var_EF86["copycat_grenade_mp"] = 1;
	level.var_EF86["speed_strip_mp"] = 1;
	level.var_EF86["shard_ball_mp"] = 1;
	level.var_EF86["splash_grenade_mp"] = 1;
	level.var_EF86["forcepush_mp"] = 1;
	level.var_EF86["portal_generator_mp"] = 1;
	level.var_EF86["ammo_box_mp"] = 1;
	level.var_EF86["blackhat_mp"] = 1;
	level.var_EF86["flare_mp"] = 1;
	var_00 = scripts\mp\_passives::func_8239();
	foreach(var_02 in var_00)
	{
		level.var_EF86[var_02] = 1;
		var_03 = scripts\mp\_passives::func_804A(var_02);
		if(isdefined(var_03))
		{
			level.var_6A50[var_02] = [var_03];
		}
	}

	level.var_EF86["specialty_null"] = 1;
	level.var_CA60["specialty_afterburner"] = ::scripts\mp\perks\_perkfunctions::func_F634;
	level.var_CA66["specialty_afterburner"] = ::scripts\mp\perks\_perkfunctions::func_12C6E;
	level.var_CA60["specialty_blastshield"] = ::scripts\mp\perks\_perkfunctions::func_F667;
	level.var_CA66["specialty_blastshield"] = ::scripts\mp\perks\_perkfunctions::func_12C82;
	level.var_CA60["specialty_falldamage"] = ::scripts\mp\perks\_perkfunctions::func_F719;
	level.var_CA66["specialty_falldamage"] = ::scripts\mp\perks\_perkfunctions::func_12CC1;
	level.var_CA60["specialty_localjammer"] = ::scripts\mp\perks\_perkfunctions::func_F78A;
	level.var_CA66["specialty_localjammer"] = ::scripts\mp\perks\_perkfunctions::func_12CE9;
	level.var_CA60["specialty_thermal"] = ::scripts\mp\perks\_perkfunctions::func_F885;
	level.var_CA66["specialty_thermal"] = ::scripts\mp\perks\_perkfunctions::func_12D49;
	level.var_CA60["specialty_lightweight"] = ::scripts\mp\perks\_perkfunctions::func_F788;
	level.var_CA66["specialty_lightweight"] = ::scripts\mp\perks\_perkfunctions::func_12CE6;
	level.var_CA60["specialty_steelnerves"] = ::scripts\mp\perks\_perkfunctions::func_F862;
	level.var_CA66["specialty_steelnerves"] = ::scripts\mp\perks\_perkfunctions::func_12D39;
	level.var_CA60["specialty_delaymine"] = ::scripts\mp\perks\_perkfunctions::func_F6C1;
	level.var_CA66["specialty_delaymine"] = ::scripts\mp\perks\_perkfunctions::func_12CA1;
	level.var_CA60["specialty_saboteur"] = ::scripts\mp\perks\_perkfunctions::func_F827;
	level.var_CA66["specialty_saboteur"] = ::scripts\mp\perks\_perkfunctions::func_12D21;
	level.var_CA60["specialty_endgame"] = ::scripts\mp\perks\_perkfunctions::func_F6DE;
	level.var_CA66["specialty_endgame"] = ::scripts\mp\perks\_perkfunctions::func_12CAA;
	level.var_CA60["specialty_onemanarmy"] = ::scripts\mp\perks\_perkfunctions::func_F7C6;
	level.var_CA66["specialty_onemanarmy"] = ::scripts\mp\perks\_perkfunctions::func_12CF9;
	level.var_CA60["specialty_tacticalinsertion"] = ::scripts\mp\perks\_perkfunctions::func_F870;
	level.var_CA66["specialty_tacticalinsertion"] = ::scripts\mp\perks\_perkfunctions::func_12D41;
	level.var_CA60["specialty_weaponlaser"] = ::scripts\mp\perks\_perkfunctions::func_FB17;
	level.var_CA66["specialty_weaponlaser"] = ::scripts\mp\perks\_perkfunctions::func_12D68;
	level.var_CA60["specialty_steadyaimpro"] = ::scripts\mp\perks\_perkfunctions::func_F860;
	level.var_CA66["specialty_steadyaimpro"] = ::scripts\mp\perks\_perkfunctions::func_12D37;
	level.var_CA60["specialty_stun_resistance"] = ::scripts\mp\perks\_perkfunctions::func_F869;
	level.var_CA66["specialty_stun_resistance"] = ::scripts\mp\perks\_perkfunctions::func_12D3C;
	level.var_CA60["specialty_marksman"] = ::scripts\mp\perks\_perkfunctions::func_F78F;
	level.var_CA66["specialty_marksman"] = ::scripts\mp\perks\_perkfunctions::func_12CEC;
	level.var_CA60["specialty_rshieldradar"] = ::scripts\mp\perks\_perkfunctions::func_F821;
	level.var_CA66["specialty_rshieldradar"] = ::scripts\mp\perks\_perkfunctions::func_12D1D;
	level.var_CA60["specialty_rshieldscrambler"] = ::scripts\mp\perks\_perkfunctions::func_F823;
	level.var_CA66["specialty_rshieldscrambler"] = ::scripts\mp\perks\_perkfunctions::func_12D1E;
	level.var_CA60["specialty_double_load"] = ::scripts\mp\perks\_perkfunctions::func_F6D7;
	level.var_CA66["specialty_double_load"] = ::scripts\mp\perks\_perkfunctions::func_12CA8;
	level.var_CA60["specialty_sharp_focus"] = ::scripts\mp\perks\_perkfunctions::func_F83C;
	level.var_CA66["specialty_sharp_focus"] = ::scripts\mp\perks\_perkfunctions::func_12D29;
	level.var_CA60["specialty_hard_shell"] = ::scripts\mp\perks\_perkfunctions::func_F73A;
	level.var_CA66["specialty_hard_shell"] = ::scripts\mp\perks\_perkfunctions::func_12CCC;
	level.var_CA60["specialty_regenfaster"] = ::scripts\mp\perks\_perkfunctions::func_F81B;
	level.var_CA66["specialty_regenfaster"] = ::scripts\mp\perks\_perkfunctions::func_12D19;
	level.var_CA60["specialty_autospot"] = ::scripts\mp\perks\_perkfunctions::func_F650;
	level.var_CA66["specialty_autospot"] = ::scripts\mp\perks\_perkfunctions::func_12C76;
	level.var_CA60["specialty_empimmune"] = ::scripts\mp\perks\_perkfunctions::func_F6DC;
	level.var_CA66["specialty_empimmune"] = ::scripts\mp\perks\_perkfunctions::func_12CA9;
	level.var_CA60["specialty_overkill_pro"] = ::scripts\mp\perks\_perkfunctions::func_F7D0;
	level.var_CA66["specialty_overkill_pro"] = ::scripts\mp\perks\_perkfunctions::func_12D01;
	level.var_CA60["specialty_refill_grenades"] = ::scripts\mp\perks\_perkfunctions::func_F819;
	level.var_CA66["specialty_refill_grenades"] = ::scripts\mp\perks\_perkfunctions::func_12D17;
	level.var_CA60["specialty_refill_ammo"] = ::scripts\mp\perks\_perkfunctions::func_F818;
	level.var_CA66["specialty_refill_ammo"] = ::scripts\mp\perks\_perkfunctions::func_12D16;
	level.var_CA60["specialty_combat_speed"] = ::scripts\mp\perks\_perkfunctions::func_F698;
	level.var_CA66["specialty_combat_speed"] = ::scripts\mp\perks\_perkfunctions::func_12C95;
	level.var_CA60["specialty_gambler"] = ::scripts\mp\perks\_perkfunctions::func_F71F;
	level.var_CA66["specialty_gambler"] = ::scripts\mp\perks\_perkfunctions::func_12CC5;
	level.var_CA60["specialty_comexp"] = ::scripts\mp\perks\_perkfunctions::func_F69B;
	level.var_CA66["specialty_comexp"] = ::scripts\mp\perks\_perkfunctions::func_12C97;
	level.var_CA60["specialty_gunsmith"] = ::scripts\mp\perks\_perkfunctions::func_F737;
	level.var_CA66["specialty_gunsmith"] = ::scripts\mp\perks\_perkfunctions::func_12CCB;
	level.var_CA60["specialty_tagger"] = ::scripts\mp\perks\_perkfunctions::func_F871;
	level.var_CA66["specialty_tagger"] = ::scripts\mp\perks\_perkfunctions::func_12D42;
	level.var_CA60["specialty_pitcher"] = ::scripts\mp\perks\_perkfunctions::func_F7E9;
	level.var_CA66["specialty_pitcher"] = ::scripts\mp\perks\_perkfunctions::func_12D0C;
	level.var_CA60["specialty_boom"] = ::scripts\mp\perks\_perkfunctions::func_F670;
	level.var_CA66["specialty_boom"] = ::scripts\mp\perks\_perkfunctions::func_12C87;
	level.var_CA60["specialty_triggerhappy"] = ::scripts\mp\perks\_perkfunctions::func_F897;
	level.var_CA66["specialty_triggerhappy"] = ::scripts\mp\perks\_perkfunctions::func_12D51;
	level.var_CA60["specialty_incog"] = ::scripts\mp\perks\_perkfunctions::func_F754;
	level.var_CA66["specialty_incog"] = ::scripts\mp\perks\_perkfunctions::func_12CD7;
	level.var_CA60["specialty_blindeye"] = ::scripts\mp\perks\_perkfunctions::func_F668;
	level.var_CA66["specialty_blindeye"] = ::scripts\mp\perks\_perkfunctions::func_12C83;
	level.var_CA60["specialty_quickswap"] = ::scripts\mp\perks\_perkfunctions::func_F810;
	level.var_CA66["specialty_quickswap"] = ::scripts\mp\perks\_perkfunctions::func_12D13;
	level.var_CA60["specialty_extraammo"] = ::scripts\mp\perks\_perkfunctions::func_F6F4;
	level.var_CA66["specialty_extraammo"] = ::scripts\mp\perks\_perkfunctions::func_12CB3;
	level.var_CA60["specialty_extra_equipment"] = ::scripts\mp\perks\_perkfunctions::func_F6F8;
	level.var_CA66["specialty_extra_equipment"] = ::scripts\mp\perks\_perkfunctions::func_12CB7;
	level.var_CA60["specialty_extra_deadly"] = ::scripts\mp\perks\_perkfunctions::func_F6F6;
	level.var_CA66["specialty_extra_deadly"] = ::scripts\mp\perks\_perkfunctions::func_12CB5;
	level.var_CA60["specialty_fastcrouch"] = ::scripts\mp\perks\_perkfunctions::setfastcrouch;
	level.var_CA66["specialty_fastcrouch"] = ::scripts\mp\perks\_perkfunctions::unsetfastcrouch;
	level.var_CA60["specialty_battleslide"] = ::scripts\mp\perks\_perkfunctions::func_F65B;
	level.var_CA66["specialty_battleslide"] = ::scripts\mp\perks\_perkfunctions::func_12C7B;
	level.var_CA60["specialty_battleslide_shield"] = ::scripts\mp\perks\_perkfunctions::func_F65D;
	level.var_CA66["specialty_battleslide_shield"] = ::scripts\mp\perks\_perkfunctions::func_12C7D;
	level.var_CA60["specialty_bullet_outline"] = ::scripts\mp\perks\_perkfunctions::func_F675;
	level.var_CA66["specialty_bullet_outline"] = ::scripts\mp\perks\_perkfunctions::func_12C88;
	level.var_CA60["specialty_twoprimaries"] = ::scripts\mp\perks\_perkfunctions::func_F7CF;
	level.var_CA66["specialty_twoprimaries"] = ::scripts\mp\perks\_perkfunctions::func_12D00;
	level.var_CA60["specialty_activereload"] = ::scripts\mp\perks\_perkfunctions::func_F62C;
	level.var_CA66["specialty_activereload"] = ::scripts\mp\perks\_perkfunctions::func_12C66;
	level.var_CA60["specialty_lifepack"] = ::scripts\mp\perks\_perkfunctions::func_F782;
	level.var_CA66["specialty_lifepack"] = ::scripts\mp\perks\_perkfunctions::func_12CE4;
	level.var_CA60["specialty_toughenup"] = ::scripts\mp\perks\_perkfunctions::func_F891;
	level.var_CA66["specialty_toughenup"] = ::scripts\mp\perks\_perkfunctions::func_12D4D;
	level.var_CA60["specialty_scoutping"] = ::scripts\mp\perks\_perkfunctions::func_F82D;
	level.var_CA66["specialty_scoutping"] = ::scripts\mp\perks\_perkfunctions::func_12D26;
	level.var_CA60["specialty_corpse_steal"] = ::scripts\mp\perks\_perkfunctions::func_F6A1;
	level.var_CA66["specialty_corpse_steal"] = ::scripts\mp\perks\_perkfunctions::func_12C9A;
	level.var_CA60["specialty_phase_speed"] = ::scripts\mp\perks\_perkfunctions::func_F7E6;
	level.var_CA66["specialty_phase_speed"] = ::scripts\mp\perks\_perkfunctions::func_12D0A;
	level.var_CA60["specialty_dodge"] = ::scripts\mp\perks\_perkfunctions::func_F6CC;
	level.var_CA66["specialty_dodge"] = ::scripts\mp\perks\_perkfunctions::func_12CA4;
	level.var_CA60["specialty_extra_dodge"] = ::scripts\mp\perks\_perkfunctions::func_F6F7;
	level.var_CA66["specialty_extra_dodge"] = ::scripts\mp\perks\_perkfunctions::func_12CB6;
	level.var_CA60["specialty_ground_pound"] = ::scripts\mp\perks\_perkfunctions::func_F72D;
	level.var_CA66["specialty_ground_pound"] = ::scripts\mp\perks\_perkfunctions::func_12CC7;
	level.var_CA60["specialty_ground_pound_shock"] = ::scripts\mp\perks\_perkfunctions::func_F730;
	level.var_CA66["specialty_ground_pound_shock"] = ::scripts\mp\perks\_perkfunctions::func_12CCA;
	level.var_CA60["specialty_ground_pound_shield"] = ::scripts\mp\perks\_perkfunctions::func_F72F;
	level.var_CA66["specialty_ground_pound_shield"] = ::scripts\mp\perks\_perkfunctions::func_12CC9;
	level.var_CA60["specialty_thruster"] = ::scripts\mp\perks\_perkfunctions::func_F888;
	level.var_CA66["specialty_thruster"] = ::scripts\mp\perks\_perkfunctions::func_12D4B;
	level.var_CA60["specialty_phase_slide"] = ::scripts\mp\perks\_perkfunctions::func_F7E5;
	level.var_CA66["specialty_phase_slide"] = ::scripts\mp\perks\_perkfunctions::func_12D09;
	level.var_CA60["specialty_tele_slide"] = ::scripts\mp\perks\_perkfunctions::func_F880;
	level.var_CA66["specialty_tele_slide"] = ::scripts\mp\perks\_perkfunctions::func_12D46;
	level.var_CA60["specialty_phaseslash_rephase"] = ::scripts\mp\perks\_perkfunctions::func_F7E4;
	level.var_CA66["specialty_phaseslash_rephase"] = ::scripts\mp\perks\_perkfunctions::func_12D08;
	level.var_CA60["specialty_phase_fall"] = ::scripts\mp\perks\_perkfunctions::func_F7E0;
	level.var_CA66["specialty_phase_fall"] = ::scripts\mp\perks\_perkfunctions::func_12D05;
	level.var_CA60["specialty_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::func_F846;
	level.var_CA66["specialty_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::func_12D2E;
	level.var_CA60["specialty_enchanced_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::func_F6E9;
	level.var_CA66["specialty_enhanced_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::func_12CAD;
	level.var_CA60["specialty_adrenaline"] = ::scripts\mp\perks\_perkfunctions::func_F62F;
	level.var_CA66["specialty_adrenaline"] = ::scripts\mp\perks\_perkfunctions::func_12C68;
	level.var_CA60["specialty_adrenaline_lite"] = ::scripts\mp\perks\_perkfunctions::func_F630;
	level.var_CA66["specialty_adrenaline_lite"] = ::scripts\mp\perks\_perkfunctions::func_12C69;
	level.var_CA60["specialty_extend_dodge"] = ::scripts\mp\perks\_perkfunctions::func_F6F1;
	level.var_CA66["specialty_extend_dodge"] = ::scripts\mp\perks\_perkfunctions::func_12CB1;
	level.var_CA60["specialty_aura_regen"] = ::scripts\mp\perks\_perkfunctions::func_F64E;
	level.var_CA66["specialty_aura_regen"] = ::scripts\mp\perks\_perkfunctions::func_12C74;
	level.var_CA60["specialty_aura_quickswap"] = ::scripts\mp\perks\_perkfunctions::func_F64D;
	level.var_CA66["specialty_aura_quickswap"] = ::scripts\mp\perks\_perkfunctions::func_12C73;
	level.var_CA60["specialty_aura_speed"] = ::scripts\mp\perks\_perkfunctions::func_F64F;
	level.var_CA66["specialty_aura_speed"] = ::scripts\mp\perks\_perkfunctions::func_12C75;
	level.var_CA60["specialty_mark_targets"] = ::scripts\mp\perks\_perkfunctions::func_F790;
	level.var_CA66["specialty_mark_targets"] = ::scripts\mp\perks\_perkfunctions::func_12CED;
	level.var_CA60["specialty_batterypack"] = ::scripts\mp\perks\_perkfunctions::func_F65A;
	level.var_CA66["specialty_batterypack"] = ::scripts\mp\perks\_perkfunctions::func_12C7A;
	level.var_CA60["specialty_camo_clone"] = ::scripts\mp\perks\_perkfunctions::func_F67A;
	level.var_CA66["specialty_camo_clone"] = ::scripts\mp\perks\_perkfunctions::func_12C8B;
	level.var_CA60["specialty_camo_elite"] = ::scripts\mp\perks\_perkfunctions::func_F67B;
	level.var_CA66["specialty_camo_elite"] = ::scripts\mp\perks\_perkfunctions::func_12C8C;
	level.var_CA60["specialty_block_health_regen"] = ::scripts\mp\perks\_perkfunctions::func_F669;
	level.var_CA66["specialty_block_health_regen"] = ::scripts\mp\perks\_perkfunctions::func_12C84;
	level.var_CA60["specialty_scorestreakpack"] = ::scripts\mp\perks\_perkfunctions::func_F82C;
	level.var_CA66["specialty_scorestreakpack"] = ::scripts\mp\perks\_perkfunctions::func_12D25;
	level.var_CA60["specialty_superpack"] = ::scripts\mp\perks\_perkfunctions::func_F86B;
	level.var_CA66["specialty_superpack"] = ::scripts\mp\perks\_perkfunctions::func_12D3E;
	level.var_CA60["specialty_dodge_defense"] = ::scripts\mp\perks\_perkfunctions::func_F6CE;
	level.var_CA66["specialty_dodge_defense"] = ::scripts\mp\perks\_perkfunctions::func_12CA5;
	level.var_CA60["specialty_battleslide_offense"] = ::scripts\mp\perks\_perkfunctions::func_F65C;
	level.var_CA66["specialty_battleslide_offense"] = ::scripts\mp\perks\_perkfunctions::func_12C7C;
	level.var_CA60["specialty_spawncloak"] = ::scripts\mp\perks\_perkfunctions::func_F84F;
	level.var_CA66["specialty_spawncloak"] = ::scripts\mp\perks\_perkfunctions::func_12D32;
	level.var_CA60["specialty_meleekill"] = ::scripts\mp\perks\_perkfunctions::func_F793;
	level.var_CA66["specialty_meleekill"] = ::scripts\mp\perks\_perkfunctions::func_12CEE;
	level.var_CA60["specialty_powercell"] = ::scripts\mp\perks\_perkfunctions::func_F807;
	level.var_CA66["specialty_powercell"] = ::scripts\mp\perks\_perkfunctions::func_12D0F;
	level.var_CA60["specialty_hardline"] = ::scripts\mp\perks\_perkfunctions::sethardline;
	level.var_CA66["specialty_hardline"] = ::scripts\mp\perks\_perkfunctions::unsethardline;
	level.var_CA60["specialty_hunter"] = ::scripts\mp\perks\_perkfunctions::func_F74A;
	level.var_CA66["specialty_hunter"] = ::scripts\mp\perks\_perkfunctions::func_12CD3;
	level.var_CA60["specialty_overclock"] = ::scripts\mp\perks\_perkfunctions::func_F7CD;
	level.var_CA66["specialty_overclock"] = ::scripts\mp\perks\_perkfunctions::func_12CFE;
	level.var_CA60["specialty_tracker"] = ::scripts\mp\perks\_perkfunctions::func_F894;
	level.var_CA66["specialty_tracker"] = ::scripts\mp\perks\_perkfunctions::func_12D4E;
	level.var_CA60["specialty_personal_trophy"] = ::scripts\mp\perks\_perkfunctions::func_F7DE;
	level.var_CA66["specialty_personal_trophy"] = ::scripts\mp\perks\_perkfunctions::func_12D04;
	level.var_CA60["specialty_disruptor_punch"] = ::scripts\mp\perks\_perkfunctions::func_F6CA;
	level.var_CA66["specialty_disruptor_punch"] = ::scripts\mp\perks\_perkfunctions::func_12CA3;
	level.var_CA60["specialty_equipment_ping"] = ::scripts\mp\perks\_perkfunctions::func_F6EB;
	level.var_CA66["specialty_equipment_ping"] = ::scripts\mp\perks\_perkfunctions::func_12CAE;
	level.var_CA60["specialty_rugged_eqp"] = ::scripts\mp\perks\_perkfunctions::func_F825;
	level.var_CA66["specialty_rugged_eqp"] = ::scripts\mp\perks\_perkfunctions::func_12D1F;
	level.var_CA60["specialty_man_at_arms"] = ::scripts\mp\perks\_perkfunctions::func_F78D;
	level.var_CA66["specialty_man_at_arms"] = ::scripts\mp\perks\_perkfunctions::func_12CEB;
	level.var_CA60["specialty_outlinekillstreaks"] = ::scripts\mp\perks\_perkfunctions::func_F7CB;
	level.var_CA66["specialty_outlinekillstreaks"] = ::scripts\mp\perks\_perkfunctions::func_12CFC;
	level.var_CA60["specialty_engineer"] = ::scripts\mp\perks\_perkfunctions::func_F6E4;
	level.var_CA66["specialty_engineer"] = ::scripts\mp\perks\_perkfunctions::func_12CAB;
	level.var_CA60["specialty_cloak"] = ::scripts\mp\perks\_perkfunctions::func_F693;
	level.var_CA66["specialty_cloak"] = ::scripts\mp\perks\_perkfunctions::func_12C90;
	level.var_CA60["specialty_wall_lock"] = ::scripts\mp\perks\_perkfunctions::func_FB15;
	level.var_CA66["specialty_wall_lock"] = ::scripts\mp\perks\_perkfunctions::func_12D66;
	level.var_CA60["specialty_momentum"] = ::scripts\mp\perks\_perkfunctions::func_F7A4;
	level.var_CA66["specialty_momentum"] = ::scripts\mp\perks\_perkfunctions::func_12CF2;
	level.var_CA60["specialty_hover"] = ::scripts\mp\perks\_perkfunctions::func_F747;
	level.var_CA66["specialty_hover"] = ::scripts\mp\perks\_perkfunctions::func_12CD2;
	level.var_CA60["specialty_rush"] = ::scripts\mp\perks\_perkfunctions::func_F826;
	level.var_CA66["specialty_rush"] = ::scripts\mp\perks\_perkfunctions::func_12D20;
	level.var_CA60["specialty_scavenger_eqp"] = ::scripts\mp\perks\_perkfunctions::func_F829;
	level.var_CA66["specialty_scavenger_eqp"] = ::scripts\mp\perks\_perkfunctions::func_12D22;
	level.var_CA60["specialty_spawnview"] = ::scripts\mp\perks\_perkfunctions::func_F854;
	level.var_CA66["specialty_spawnview"] = ::scripts\mp\perks\_perkfunctions::func_12D34;
	level.var_CA60["specialty_headgear"] = ::scripts\mp\perks\_perkfunctions::func_F73C;
	level.var_CA66["specialty_headgear"] = ::scripts\mp\perks\_perkfunctions::func_12CCD;
	level.var_CA60["specialty_ftlslide"] = ::scripts\mp\perks\_perkfunctions::func_F71D;
	level.var_CA66["specialty_ftlslide"] = ::scripts\mp\perks\_perkfunctions::func_12CC3;
	level.var_CA60["specialty_improved_prone"] = ::scripts\mp\perks\_perkfunctions::func_F753;
	level.var_CA66["specialty_improved_prone"] = ::scripts\mp\perks\_perkfunctions::func_12CD6;
	level.var_CA60["specialty_ghost"] = ::scripts\mp\perks\_perkfunctions::func_F721;
	level.var_CA66["specialty_ghost"] = ::scripts\mp\perks\_perkfunctions::func_12CC6;
	level.var_CA60["specialty_support_killstreaks"] = ::scripts\mp\perks\_perkfunctions::func_F86D;
	level.var_CA66["specialty_support_killstreaks"] = ::scripts\mp\perks\_perkfunctions::func_12D40;
	level.var_CA60["specialty_overrideweaponspeed"] = ::scripts\mp\perks\_perkfunctions::func_F7D2;
	level.var_CA66["specialty_overrideweaponspeed"] = ::scripts\mp\perks\_perkfunctions::func_12D02;
	level.var_CA60["specialty_ballcarrier"] = ::scripts\mp\perks\_perkfunctions::func_F657;
	level.var_CA66["specialty_ballcarrier"] = ::scripts\mp\perks\_perkfunctions::func_12C77;
	level.var_CA60["specialty_cloak_aerial"] = ::scripts\mp\perks\_perkfunctions::func_F694;
	level.var_CA66["specialty_cloak_aerial"] = ::scripts\mp\perks\_perkfunctions::func_12C91;
	level.var_CA60["specialty_spawn_radar"] = ::scripts\mp\perks\_perkfunctions::func_F852;
	level.var_CA66["specialty_spawn_radar"] = ::scripts\mp\perks\_perkfunctions::func_12D33;
	level.var_CA60["specialty_improvedmelee"] = ::scripts\mp\perks\_perkfunctions::func_F752;
	level.var_CA66["specialty_improvedmelee"] = ::scripts\mp\perks\_perkfunctions::func_12CD5;
	level.var_CA60["specialty_thief"] = ::scripts\mp\perks\_perkfunctions::func_F886;
	level.var_CA66["specialty_thief"] = ::scripts\mp\perks\_perkfunctions::func_12D4A;
	level.var_CA60["specialty_ads_awareness"] = ::scripts\mp\perks\_perkfunctions::func_F631;
	level.var_CA66["specialty_ads_awareness"] = ::scripts\mp\perks\_perkfunctions::func_12C6B;
	level.var_CA60["specialty_rearguard"] = ::scripts\mp\perks\_perkfunctions::func_F815;
	level.var_CA66["specialty_rearguard"] = ::scripts\mp\perks\_perkfunctions::func_12D14;
	level.var_CA60["specialty_combathigh"] = ::scripts\mp\perks\_perkfunctions::func_F696;
	level.var_CA66["specialty_combathigh"] = ::scripts\mp\perks\_perkfunctions::func_12C92;
	level.var_CA60["specialty_light_armor"] = ::scripts\mp\perks\_perkfunctions::func_F785;
	level.var_CA66["specialty_light_armor"] = ::scripts\mp\perks\_perkfunctions::func_12CE5;
	level.var_CA60["specialty_revenge"] = ::scripts\mp\perks\_perkfunctions::func_F81D;
	level.var_CA66["specialty_revenge"] = ::scripts\mp\perks\_perkfunctions::func_12D1A;
	level.var_CA60["specialty_c4death"] = ::scripts\mp\perks\_perkfunctions::func_F678;
	level.var_CA66["specialty_c4death"] = ::scripts\mp\perks\_perkfunctions::func_12C8A;
	level.var_CA60["specialty_finalstand"] = ::scripts\mp\perks\_perkfunctions::func_F704;
	level.var_CA66["specialty_finalstand"] = ::scripts\mp\perks\_perkfunctions::func_12CBD;
	level.var_CA60["specialty_juiced"] = ::scripts\mp\perks\_perkfunctions::func_F769;
	level.var_CA66["specialty_juiced"] = ::scripts\mp\perks\_perkfunctions::func_12CDC;
	level.var_CA60["specialty_carepackage"] = ::scripts\mp\perks\_perkfunctions::func_F67E;
	level.var_CA66["specialty_carepackage"] = ::scripts\mp\perks\_perkfunctions::func_12C8D;
	level.var_CA60["specialty_stopping_power"] = ::scripts\mp\perks\_perkfunctions::func_F864;
	level.var_CA66["specialty_stopping_power"] = ::scripts\mp\perks\_perkfunctions::func_12D3A;
	level.var_CA60["specialty_uav"] = ::scripts\mp\perks\_perkfunctions::func_F89F;
	level.var_CA66["specialty_uav"] = ::scripts\mp\perks\_perkfunctions::func_12D53;
	level.var_CA60["specialty_viewkickoverride"] = ::scripts\mp\perks\_perkfunctions::func_FB0D;
	level.var_CA66["specialty_viewkickoverride"] = ::scripts\mp\perks\_perkfunctions::func_12D64;
	level.var_CA60["specialty_affinityspeedboost"] = ::scripts\mp\perks\_perkfunctions::func_F633;
	level.var_CA66["specialty_affinityspeedboost"] = ::scripts\mp\perks\_perkfunctions::func_12C6D;
	level.var_CA60["specialty_affinityextralauncher"] = ::scripts\mp\perks\_perkfunctions::func_F632;
	level.var_CA66["specialty_affinityextralauncher"] = ::scripts\mp\perks\_perkfunctions::func_12C6C;
	level.var_CA60["passive_minimap_decoys"] = ::scripts\mp\perks\_weaponpassives::func_F79A;
	level.var_CA66["passive_minimap_decoys"] = ::scripts\mp\perks\_weaponpassives::func_12CF0;
	level.var_CA60["passive_headshot_ammo"] = ::scripts\mp\perks\_weaponpassives::func_F73F;
	level.var_CA66["passive_headshot_ammo"] = ::scripts\mp\perks\_weaponpassives::func_12CCE;
	level.var_CA60["passive_scrambler"] = ::scripts\mp\perks\_weaponpassives::func_F82F;
	level.var_CA66["passive_scrambler"] = ::scripts\mp\perks\_weaponpassives::func_12D27;
	level.var_CA60["passive_last_shots_ammo"] = ::scripts\mp\perks\_weaponpassives::func_F77D;
	level.var_CA66["passive_last_shots_ammo"] = ::scripts\mp\perks\_weaponpassives::func_12CE2;
	level.var_CA60["passive_health_on_kill"] = ::scripts\mp\perks\_weaponpassives::func_F740;
	level.var_CA66["passive_health_on_kill"] = ::scripts\mp\perks\_weaponpassives::func_12CCF;
	level.var_CA60["passive_double_kill_reload"] = ::scripts\mp\perks\_weaponpassives::func_F6D6;
	level.var_CA66["passive_double_kill_reload"] = ::scripts\mp\perks\_weaponpassives::func_12CA7;
	level.var_CA60["passive_explosive_kills"] = ::scripts\mp\perks\_weaponpassives::func_F6F0;
	level.var_CA66["passive_explosive_kills"] = ::scripts\mp\perks\_weaponpassives::func_12CB0;
	level.var_CA60["passive_miss_refund"] = ::scripts\mp\perks\_weaponpassives::func_F79B;
	level.var_CA66["passive_miss_refund"] = ::scripts\mp\perks\_weaponpassives::func_12CF1;
	level.var_CA60["passive_move_speed"] = ::scripts\mp\perks\_weaponpassives::func_F7AA;
	level.var_CA66["passive_move_speed"] = ::scripts\mp\perks\_weaponpassives::func_12CF5;
	level.var_CA60["passive_fast_rechamber_move_speed"] = ::scripts\mp\perks\_weaponpassives::setrechambermovespeedpassive;
	level.var_CA66["passive_fast_rechamber_move_speed"] = ::scripts\mp\perks\_weaponpassives::unsetrechambermovespeedpassive;
	level.var_CA60["passive_extra_xp"] = ::scripts\mp\perks\_weaponpassives::func_F6FD;
	level.var_CA66["passive_extra_xp"] = ::scripts\mp\perks\_weaponpassives::func_12CBA;
	level.var_CA60["passive_nuke"] = ::scripts\mp\perks\_weaponpassives::func_F7BD;
	level.var_CA66["passive_nuke"] = ::scripts\mp\perks\_weaponpassives::func_12CF8;
	level.var_CA60["passive_berserk"] = ::scripts\mp\perks\_weaponpassives::setquadfeederpassive;
	level.var_CA66["passive_berserk "] = ::scripts\mp\perks\_weaponpassives::unsetquadfeederpassive;
	level.var_CA60["passive_streak_ammo"] = ::scripts\mp\perks\_weaponpassives::func_F865;
	level.var_CA66["passive_streak_ammo"] = ::scripts\mp\perks\_weaponpassives::func_12D3B;
	level.var_CA60["passive_score_bonus_kills"] = ::scripts\mp\perks\_weaponpassives::func_F82A;
	level.var_CA66["passive_score_bonus_kills"] = ::scripts\mp\perks\_weaponpassives::func_12D23;
	level.var_CA60["passive_score_bonus_objectives"] = ::scripts\mp\perks\_weaponpassives::func_F82B;
	level.var_CA66["passive_score_bonus_objectives"] = ::scripts\mp\perks\_weaponpassives::func_12D24;
	level.var_CA60["passive_hivemind"] = ::scripts\mp\perks\_weaponpassives::func_F746;
	level.var_CA66["passive_hivemind"] = ::scripts\mp\perks\_weaponpassives::func_12CD1;
	level.var_CA60["passive_scoutping"] = ::scripts\mp\perks\_perkfunctions::func_F82D;
	level.var_CA66["passive_scoutping"] = ::scripts\mp\perks\_perkfunctions::func_12D26;
	level.var_CA60["passive_hunter_killer"] = ::scripts\mp\perks\_weaponpassives::func_F74B;
	level.var_CA66["passive_hunter_killer"] = ::scripts\mp\perks\_weaponpassives::func_12CD4;
	level.var_CA66["passive_double_kill_super"] = ::scripts\mp\perks\_weaponpassives::unsetdoublekillsuperpassive;
	level.var_CA60["passive_wallrun_quieter"] = ::scripts\mp\perks\_weaponpassives::setwallrunquieterpassive;
	level.var_CA66["passive_wallrun_quieter"] = ::scripts\mp\perks\_weaponpassives::unsetwallrunquieterpassive;
	level.var_CA60["passive_slide_blastshield"] = ::scripts\mp\perks\_weaponpassives::setslideblastshield;
	level.var_CA66["passive_slide_blastshield"] = ::scripts\mp\perks\_weaponpassives::unsetslideblastshield;
	level.var_CA60["passive_prone_blindeye"] = ::scripts\mp\perks\_weaponpassives::setproneblindeye;
	level.var_CA66["passive_prone_blindeye"] = ::scripts\mp\perks\_weaponpassives::unsetproneblindeye;
	level.var_CA60["passive_stationary_engineer"] = ::scripts\mp\perks\_weaponpassives::setstationaryengineer;
	level.var_CA66["passive_stationary_engineer"] = ::scripts\mp\perks\_weaponpassives::unsetstationaryengineer;
	level.var_CA60["passive_doppleganger"] = ::scripts\mp\perks\_weaponpassives::setdoppleganger;
	level.var_CA66["passive_doppleganger"] = ::scripts\mp\perks\_weaponpassives::unsetdoppleganger;
	level.var_CA60["passive_collat_streak"] = ::scripts\mp\perks\_weaponpassives::setcollatstreak;
	level.var_CA66["passive_collat_streak"] = ::scripts\mp\perks\_weaponpassives::unsetcollatstreak;
	level.var_6A50["specialty_coldblooded"] = ["specialty_spygame","specialty_heartbreaker","specialty_radarringresist"];
	level.var_6A50["specialty_blindeye"] = ["specialty_noplayertarget"];
	level.var_6A50["specialty_quickswap"] = ["specialty_fastoffhand"];
	level.var_6A50["specialty_improvedgunkick"] = ["specialty_reducedsway"];
	level.var_6A50["specialty_dexterity"] = ["specialty_fastreload","specialty_quickswap"];
	level.var_6A50["specialty_engineer"] = ["specialty_detectexplosive","specialty_delaymine","specialty_outlinekillstreaks","specialty_drawenemyturrets"];
	level.var_6A50["specialty_empimmune"] = ["specialty_tracker_jammer","specialty_noscopeoutline"];
	level.var_6A50["specialty_afterburner"] = ["specialty_thruster"];
	level.var_6A50["specialty_man_at_arms"] = ["specialty_extraammo","specialty_overrideweaponspeed"];
	level.var_6A50["specialty_phaseslash"] = ["specialty_phaseslash_rephase"];
	level.var_6A50["specialty_ghost"] = ["specialty_gpsjammer"];
	level.var_6A50["specialty_equipment_ping"] = ["specialty_paint"];
	level.var_6A50["specialty_blast_suppressor"] = ["specialty_silentdoublejump","specialty_silentdoublejump_audio"];
	level.var_6A50["specialty_quieter"] = ["specialty_silentdoublejump_audio"];
	level.var_6A50["specialty_improvedmelee"] = ["specialty_extendedmelee","specialty_fastermelee","specialty_thief"];
	level.var_6A50["specialty_marksman"] = ["specialty_viewkickoverride"];
	level.var_6A50["specialty_tracker"] = ["specialty_selectivehearing","specialty_tracker_pro"];
	level.var_6A50["specialty_sprintfire"] = ["specialty_fastsprintrecovery"];
	func_98B0();
	func_B675();
	func_B673();
	func_98B2();
	level thread func_C56E();
}

//Function Number: 2
func_B675()
{
	if(!isdefined(level.var_B676))
	{
		level.var_B676 = [];
	}

	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/menuRigPerks.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/menuRigPerks.csv",var_00,1);
		var_03 = tablelookupbyrow("mp/menuRigPerks.csv",var_00,2);
		var_04 = spawnstruct();
		var_04.var_92B8 = var_01;
		var_04.var_DE3F = var_03;
		var_04.var_2123 = var_02;
		if(!isdefined(level.var_B676[var_03]))
		{
			level.var_B676[var_03] = var_04;
		}

		var_00++;
	}
}

//Function Number: 3
func_B673()
{
	if(!isdefined(level.var_B674))
	{
		level.var_B674 = [];
	}

	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/menuPerks.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/menuPerks.csv",var_00,1);
		var_03 = tablelookupbyrow("mp/menuPerks.csv",var_00,2);
		var_04 = spawnstruct();
		var_04.name = var_03;
		var_04.var_DE3F = var_03;
		var_04.var_10307 = var_02;
		if(!isdefined(level.var_B674[var_03]))
		{
			level.var_B674[var_03] = var_04;
		}

		var_00++;
	}
}

//Function Number: 4
func_98B2()
{
	if(!isdefined(level.var_CA63))
	{
		level.var_CA63 = [];
	}

	level.var_CA5E = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/perkTable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/perkTable.csv",var_00,1);
		var_03 = spawnstruct();
		var_03.var_DE3F = var_02;
		var_03.var_92B8 = int(var_01);
		if(!isdefined(level.var_CA63[var_02]))
		{
			level.var_CA63[var_02] = var_03;
		}

		level.var_CA5E[var_03.var_92B8] = var_03.var_DE3F;
		var_00++;
	}
}

//Function Number: 5
func_7DE8()
{
	var_00 = [];
	foreach(var_02 in level.var_B674)
	{
		if(scripts\mp\_utility::_hasperk(var_02.name))
		{
			continue;
		}

		var_00[var_00.size] = var_02.name;
	}

	return var_00;
}

//Function Number: 6
func_805C(param_00)
{
	var_01 = level.var_B674[param_00];
	if(!isdefined(var_01))
	{
		return undefined;
	}

	return int(var_01.var_10307);
}

//Function Number: 7
func_13144(param_00)
{
	if(!scripts\mp\_utility::func_CA5F())
	{
		param_00 = "specialty_null";
	}
	else
	{
		switch(param_00)
		{
			case "specialty_deadeye":
			case "specialty_scavenger":
			case "specialty_bulletaccuracy":
			case "specialty_lightweight":
			case "specialty_selectivehearing":
			case "specialty_gpsjammer":
			case "specialty_detectexplosive":
			case "specialty_reducedsway":
			case "specialty_silentkill":
			case "specialty_chain_reaction":
			case "specialty_corpse_steal":
			case "specialty_extra_deadly":
			case "specialty_gambler":
			case "specialty_explosivedamage":
			case "specialty_paint":
			case "specialty_comexp":
			case "specialty_superpack":
			case "specialty_scorestreakpack":
			case "specialty_batterypack":
			case "specialty_extend_dodge":
			case "specialty_extra_dodge":
			case "specialty_gung_ho":
			case "specialty_activereload":
			case "specialty_twoprimaries":
			case "specialty_pitcher":
			case "specialty_falldamage":
			case "specialty_extraammo":
			case "specialty_battleslide":
			case "specialty_blindeye":
			case "specialty_sixth_sense":
			case "specialty_quieter":
			case "specialty_stun_resistance":
			case "specialty_blastshield":
			case "specialty_regenfaster":
			case "specialty_boom":
			case "specialty_sharp_focus":
			case "specialty_null":
			case "specialty_hardline":
			case "specialty_stalker":
			case "specialty_quickswap":
			case "specialty_marathon":
			case "specialty_fastsprintrecovery":
			case "specialty_quickdraw":
			case "specialty_fastreload":
				break;

			default:
				param_00 = "specialty_null";
				break;
		}
	}

	return param_00;
}

//Function Number: 8
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 9
func_C57B()
{
	self endon("disconnect");
	self.var_CA5B = [];
	self.var_CA5D = [];
	self.var_11B2C = undefined;
	self.var_13CA0 = [];
	self.var_C47E = 0;
	for(;;)
	{
		self waittill("spawned_player");
		self.var_C47E = 0;
		thread scripts\mp\killstreaks\_portableaoegenerator::func_7737();
	}
}

//Function Number: 10
func_98B0()
{
	level.var_8488 = 0.08;
	level.var_A4A7 = 0.08;
	level.var_A4A6 = 0.08;
	level.var_218B = 1.5;
	level.armorpiercingmodks = 1.25;
	level.var_DE8A = scripts\mp\_utility::func_7F1D("perk_fastRegenWaitMS",800) / 1000;
	level.var_DE89 = scripts\mp\_utility::func_7F1D("perk_fastRegenRate",2);
	level.var_3245 = scripts\mp\_utility::func_7F1D("perk_bulletDamage",40) / 100;
	level.var_69FE = scripts\mp\_utility::func_7F1D("perk_explosiveDamage",40) / 100;
	level.var_2B68 = scripts\mp\_utility::func_7F1D("perk_blastShieldScale",65) / 100;
	level.var_2B67 = scripts\mp\_utility::func_7F1D("perk_blastShieldClampHP",80);
	level.var_1177E = scripts\mp\_utility::func_7F1D("weap_thermoDebuffMod",185) / 100;
	level.var_E559 = scripts\mp\_utility::func_7F1D("perk_riotShield",100) / 100;
	level.var_21A3 = scripts\mp\_utility::func_7F1D("perk_armorVest",75) / 100;
	level.var_8C74 = scripts\mp\_utility::func_7F1D("perk_headgear",55) / 100;
	level.var_848A = scripts\mp\_utility::func_7F1D("perk_gpsjammer_graceperiods",4);
	level.var_B7CB = scripts\mp\_utility::func_7F1D("perk_gpsjammer_min_speed",100);
	level.var_B75C = scripts\mp\_utility::func_7F1D("perk_gpsjammer_min_distance",10);
	level.var_1190C = scripts\mp\_utility::func_7F1D("perk_gpsjammer_time_period",200) / 1000;
	level.var_B7CC = level.var_B7CB * level.var_B7CB;
	level.var_B75E = level.var_B75C * level.var_B75C;
	if(isdefined(level.var_8B38) && level.var_8B38)
	{
		level.var_2B68 = scripts\mp\_utility::func_7F1D("perk_blastShieldScale_HC",20) / 100;
		level.var_2B67 = scripts\mp\_utility::func_7F1D("perk_blastShieldClampHP_HC",20);
	}

	if(level.tactical)
	{
		level.var_2B68 = 0.65;
		level.var_2B67 = 50;
	}
}

//Function Number: 11
func_838A(param_00,param_01)
{
	param_01 = scripts\common\utility::func_116D7(isdefined(param_01),param_01,1);
	foreach(var_03 in param_00)
	{
		if(param_01)
		{
			var_03 = func_13144(var_03);
		}

		scripts\mp\_utility::func_8387(var_03);
	}
}

//Function Number: 12
func_13D1(param_00)
{
	if(!isdefined(self.var_CA5B[param_00]))
	{
		self.var_CA5B[param_00] = 1;
	}
	else
	{
		self.var_CA5B[param_00]++;
	}

	if(self.var_CA5B[param_00] == 1 && !isdefined(self.var_CA5D[param_00]))
	{
		func_13D2(param_00);
	}
}

//Function Number: 13
func_13D2(param_00)
{
	var_01 = level.var_CA60[param_00];
	if(isdefined(var_01))
	{
		self thread [[ var_01 ]]();
	}

	self method_8320(param_00,!isdefined(level.var_EF86[param_00]));
}

//Function Number: 14
func_13CC(param_00)
{
	foreach(var_06, var_02 in level.var_6A50)
	{
		if(param_00 == var_06)
		{
			foreach(var_04 in var_02)
			{
				func_13D1(var_04);
			}

			break;
		}
	}
}

//Function Number: 15
func_142F(param_00)
{
	foreach(var_06, var_02 in level.var_6A50)
	{
		if(param_00 == var_06)
		{
			foreach(var_04 in var_02)
			{
				func_1430(var_04);
			}

			break;
		}
	}
}

//Function Number: 16
func_1430(param_00)
{
	if(!isdefined(self.var_CA5B[param_00]))
	{
		return;
	}

	self.var_CA5B[param_00]--;
	if(self.var_CA5B[param_00] == 0)
	{
		if(!isdefined(self.var_CA5D[param_00]))
		{
			func_1431(param_00);
		}

		self.var_CA5B[param_00] = undefined;
	}
}

//Function Number: 17
func_1431(param_00)
{
	if(isdefined(level.var_CA66[param_00]))
	{
		self thread [[ level.var_CA66[param_00] ]]();
	}

	self method_83CC(param_00,!isdefined(level.var_EF86[param_00]));
}

//Function Number: 18
func_11AA()
{
	foreach(var_02, var_01 in self.var_CA5B)
	{
		if(isdefined(level.var_CA66[var_02]))
		{
			self [[ level.var_CA66[var_02] ]]();
		}
	}

	self.var_CA5B = [];
	self.var_CA5D = [];
	self method_8077();
}

//Function Number: 19
func_E130(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(func_13144(var_03) != "specialty_null")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 20
func_838B()
{
	self endon("death");
	self endon("disconnect");
	self endon("giveLoadout_start");
	scripts\mp\_utility::func_8387("specialty_blindeye");
	scripts\mp\_utility::func_8387("specialty_gpsjammer");
	scripts\mp\_utility::func_8387("specialty_noscopeoutline");
	while(self.var_26B9 > 0)
	{
		self.var_26B9 = self.var_26B9 - 0.05;
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9EF0(self) && isdefined(self.var_D3E7) && isalive(self.var_D3E7))
	{
		return;
	}

	scripts\mp\_utility::func_E150("specialty_blindeye");
	scripts\mp\_utility::func_E150("specialty_gpsjammer");
	scripts\mp\_utility::func_E150("specialty_noscopeoutline");
	self notify("removed_spawn_perks");
}

//Function Number: 21
func_12E55(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = isdefined(param_00) && isplayer(param_00);
	var_09 = scripts\mp\_utility::func_8234(param_05);
	var_0A = isdefined(var_09) && var_09 == "iw7_axe";
	var_0B = isdefined(var_09) && var_09 == "iw7_tacburst" && param_01 method_8519(param_05);
	var_0C = var_0A && isdefined(param_00) && isdefined(param_00.classname) && param_00.classname == "grenade";
	var_0D = isdefined(param_01) && isplayer(param_01) && param_01 != param_02;
	if(var_0D && var_08 || var_0C || var_0B)
	{
		thread scripts\mp\perks\_weaponpassives::func_12F61(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
		if(param_01 scripts\mp\_utility::_hasperk("specialty_triggerhappy"))
		{
			param_01 thread scripts\mp\perks\_perkfunctions::func_F898();
		}

		if(param_01 scripts\mp\_utility::_hasperk("specialty_boom"))
		{
			param_02 thread scripts\mp\perks\_perkfunctions::func_F671(param_01);
		}

		if(param_01 scripts\mp\_utility::_hasperk("specialty_deadeye"))
		{
			param_01.var_4DF0++;
		}

		var_0E = param_01.pers["abilityRecharging"];
		if(isdefined(var_0E) && var_0E)
		{
			param_01 notify("abilityFastRecharge");
		}

		var_0F = param_01.pers["abilityOn"];
		if(isdefined(var_0F) && var_0F)
		{
			param_01 notify("abilityExtraTime");
		}
	}
}

//Function Number: 22
func_F7C5(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_01)
	{
		if(!isdefined(level.var_CA63[var_04]))
		{
			continue;
		}

		var_05 = func_805C(var_04);
		if(!isdefined(var_05))
		{
			continue;
		}

		if(!isdefined(var_02[var_05]))
		{
			var_02[var_05] = [];
		}

		var_02[var_05][var_02[var_05].size] = level.var_CA63[var_04].var_92B8;
	}

	var_07 = [];
	for(var_05 = 1;var_05 < 4;var_05++)
	{
		if(isdefined(var_02[var_05]))
		{
			foreach(var_04 in var_02[var_05])
			{
				var_07[var_07.size] = var_04;
			}
		}
	}

	for(var_0A = 0;var_0A < 6;var_0A++)
	{
		var_0B = var_07[var_0A];
		if(!isdefined(var_0B))
		{
			var_0B = -1;
		}

		self setclientomnvar(param_00 + var_0A,var_0B);
	}
}

//Function Number: 23
func_9EDF(param_00)
{
	var_01 = self.pers["loadoutPerks"];
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
func_805A(param_00)
{
	if(!isdefined(param_00) || !isdefined(level.var_CA63[param_00]))
	{
		return 0;
	}

	return level.var_CA63[param_00].var_92B8;
}