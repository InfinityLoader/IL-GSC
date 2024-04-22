/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_audio_dlc4.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 272 ms
 * Timestamp: 4/22/2024 2:14:32 AM
*******************************************************************/

//Function Number: 1
initdlc4audio()
{
	level._zmbvoxlevelspecific = ::initleveldialog;
	level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp_dlc4.csv";
	level.zmbaudiozonetrackingdelay = 5;
	level.numkitingconversations = 9;
	level.zmbaudioskiprandomizingkitingvo = 1;
	level.zmbaudiokitingstartwave = 2;
	level.zmbaudiowave1vo = ::zmbaudiowave1vo;
	level.zmbdowaveendvo = ::zmbdowaveendvo;
	level.zmbaudiowavestartvo = ::zmbaudiowavestartvo;
	level.zmaudiocustomtrapvo = ::zmaudiocustomtrapvo;
	level.zmbaudiokitingcustom = ::zmbaudiokitingcustom;
	level thread zmbspotzombiesvo();
}

//Function Number: 2
initleveldialog()
{
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_spiked","dlc2_spike1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_spiked","dlc2_spikespot",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_teleport","dlc3_blink1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_teleport","dlc3_blink",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_combo_spike_teleport","dlc4_telespike1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_combo_spike_teleport","dlc4_telespike",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_combo_armor_emz","dlc4_armoremz1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_combo_armor_emz","dlc4_armoremz",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_combo_exploder_teleport","dlc4_telexp1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_combo_exploder_teleport","dlc4_telexp",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_combo_emz_spike","dlc4_emzspike1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_combo_emz_spike","dlc4_emzspike",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","td_spot","dlc3_td_spot",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","td_lose","dlc3_td_lose",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","td_win","dlc3_td_win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","turret_trap","trap_roomba",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","laser","traps_pckup",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","steam","trap_steam",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","water_floor_trap","trap_wtr",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","sentinel_conv","sentinel_conv",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","teleport_use","dlc3_teleport_use",undefined,20);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","ss_use_disruptor","ss_disrupt",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","gol_drop_pre","gol_drop_pre",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","gol_react","gol_react",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","teleport_zombies_mp","dlc3_teleport",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","teleport_throw_zombies_mp","dlc3_teleport",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_dlcgun2zm_mp","dlc3_ohm",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_dlcgun3zm_mp","dlc3_m1i",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","repulsor_zombie_mp","dlc3_repulsor",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_tridentzm_mp","dlc4_trident",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_dlcgun4zm_mp","dlc4_weap",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","ohm","dlc3_ohm_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","m1irons","dlc3_m1i_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","respulsor","dlc3_repulsor_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","trident","dlc4_trident_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","blunderbuss","dlc4_weap_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","gol_melee_kill","gol_melee_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","gol_missile_kill","gol_missile_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","gol_rocket_kill","gol_rocket_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","powerup","open_fire","dlc3_inf_ammo",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","powerup","ex_touch","dlc3_overcharge",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","perk","exo_tacticalArmor","dlc3_exo_stck",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","monologue","teleport_machine","dlc3_tele",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","monologue","tube","tube",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","monologue","goliath","dlc4_goliath",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","ignore_nearby","intro","rnd_wave1",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo1","convo1","oz,an_conv,convo1b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo3b","convo3b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo4","convo4","oz,an_conv,convo4b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo5b","convo5b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo6b","convo6b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo8","convo8","oz,an_conv,convo8b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","an_conv","convo9b","convo9b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_s0_react","dlc4_s0_react",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_s0_traps","dlc4_s0_traps",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_s0_back","dlc4_s0_back",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_ozsee","dlc4_ozsee",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_shieldup","dlc4_shieldup",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_turret","dlc4_turret",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_sentry","dlc4_sentry",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_laser","dlc4_laser",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_elect","dlc4_elect",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_gas","dlc4_gas",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_host","dlc4_host",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_dog","dlc4_dog",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_zomb","dlc4_zomb",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_mut","dlc4_mut",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_shielddown","dlc4_shielddown",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_ozhurt","dlc4_ozhurt",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_progress","dlc4_progress",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_s1win","dlc4_s1win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","dlc4_oz2","dlc4_oz2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_exec_1","pilot_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_2","pilot_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_3","pilot_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_4","pilot_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_5","pilot_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_6","pilot_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_7","pilot_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_1","it_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_2","it_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_3","it_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_4","it_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_5","it_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_6","it_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_7","it_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_1","guard_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_2","guard_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_3","guard_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_4","guard_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_1","it_pilot_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_2","it_pilot_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_3","it_pilot_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_4","it_pilot_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_5","it_pilot_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_6","it_pilot_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_7","it_pilot_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_8","it_pilot_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_9","it_pilot_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_10","it_pilot_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_11","it_pilot_wave_intermission_ctx11",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_1","it_guard_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_2","it_guard_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_3","it_guard_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_4","it_guard_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_5","it_guard_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_6","it_guard_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_7","it_guard_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_8","it_guard_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_9","it_guard_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_1","guard_pilot_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_guard_2","guard_pilot_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_guard_3","guard_pilot_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_4","guard_pilot_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_5","guard_pilot_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_6","guard_pilot_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_guard_7","guard_pilot_wave_intermission_ctx07",undefined);
	var_00 = spawnstruct();
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("sentinel","sent_",var_00,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel","general","spawn","spawn",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel","general","kill","kill",undefined,30);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel","general","chatter","chatter",undefined,40);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel","general","defuse","defuse",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel","general","revive","revive",undefined);
	level.sentineldebouncevo = [];
	level.sentineldebouncevo["spawn"] = 0;
	level.sentineldebouncevo["kill"] = 0;
	level.sentineldebouncevo["chatter"] = 0;
	level.sentineldebouncevo["revive"] = 0;
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","open_fire","open_fire","powerup,open_fire");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","ex_touch","ex_touch","powerup,ex_touch");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","exo_tacticalArmor","exo_stock",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","stage0","stage0",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","stage1_start","stage1_start",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","stage1_shield","stage1_shield",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","stage1_end3","stage1_end3",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_atrium","pow_galleria","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_start_01","pow_landing","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_zone_01","pow_hall","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_zone_04","pow_tidal","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_venthall","pow_annex","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_zone_03","pow_lounge","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","gol_start","gol_start","monologue,goliath");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","gol_armor1","gol_armor1",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","gol_armor2","gol_armor2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","gol_armor3","gol_armor3",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","gol_armor4","gol_armor4",undefined);
	level.announceroz = spawnstruct();
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz","janitor_",level.announceroz,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dlc4_s0intro","dlc4_s0intro",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_s0intro2","dlc4_s0intro2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_s0fun","dlc4_s0fun",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dlc4_s0ang","dlc4_s0ang",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dlc4_tele","dlc4_tele",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dlc4_count","dlc4_count",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_tele2","dlc4_tele2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_intro","dlc4_intro",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_toolong","dlc4_toolong",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_shieldup","dlc4_shieldup",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_turret","dlc4_turret","general,dlc4_turret");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_sentry","dlc4_sentry","general,dlc4_sentry");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_laser","dlc4_laser","general,dlc4_laser");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_elect","dlc4_elect","general,dlc4_elect");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_gas","dlc4_gas","general,dlc4_gas");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_host","dlc4_host","general,dlc4_host");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_dog","dlc4_dog","general,dlc4_dog");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_zomb","dlc4_zomb","general,dlc4_zomb");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_mut","dlc4_mut","general,dlc4_mut");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_trapstart","dlc4_trapstart",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_shielddown","dlc4_shielddown","general,dlc4_shielddown");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_hurt","dlc4_hurt","general,dlc4_ozhurt",5);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_progress","dlc4_progress","general,dlc4_progress");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","dlc4_rand1","dlc4_rand1",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dlc4_s1win","dlc4_s1win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dlc4_count2","dlc4_count2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo1b","convo1b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo2","convo2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo3","convo3","an_conv,convo3b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo4b","convo4b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo5","convo5","an_conv,convo5b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo6","convo6","an_conv,convo6b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo7","convo7",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo8b","convo8b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","an_conv","convo9","convo9","an_conv,convo9b");
}

//Function Number: 3
anyplayersspeaking()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\zombies\_util::is_true(var_01.isspeaking))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
waittilldonespeaking()
{
	while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking())
	{
		wait 0.05;
	}
}

//Function Number: 5
zmbaudiowave1vo()
{
	foreach(var_01 in level.players)
	{
		var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","intro",undefined,undefined,undefined,undefined,[var_01]);
	}
}

//Function Number: 6
zmbaudiowavestartvo(param_00)
{
	if(!param_00 && level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 21 || level.wavecounter == 35 || level.wavecounter == 50)
	{
		var_01 = randomintrange(0,level.players.size);
		level.players[var_01] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","round_" + level.wavecounter);
		param_00 = 1;
	}
	else if(!param_00 && level.wavecounter == 6 || level.wavecounter == 13 || level.wavecounter == 20)
	{
		param_00 = 1;
	}
	else if(level.wavecounter == 1 && maps\mp\zombies\_util::iszombieshardmode())
	{
		[[ level.zmbhardmodeintro ]]();
	}

	return param_00;
}

//Function Number: 7
zmbdowaveendvo()
{
	return level.wavecounter != 14 && level.wavecounter != 21;
}

//Function Number: 8
zmaudiocustomtrapvo(param_00,param_01)
{
	wait(1);
	if(!isdefined(param_00.script_noteworthy) || !isdefined(param_01))
	{
		return;
	}

	param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general",param_00.script_noteworthy);
}

//Function Number: 9
zmbspotzombiesvo()
{
	level thread zmbspotzombie("spiked",7);
	level thread zmbspotzombie("teleport",7);
	level thread zmbspotzombie("combo_spike_teleport",25);
	level thread zmbspotzombie("combo_exploder_teleport",25);
	level thread zmbspotzombie("combo_armor_emz",25);
	level thread zmbspotzombie("combo_emz_spike",25);
}

//Function Number: 10
zmbspotzombie(param_00,param_01)
{
	if(isdefined(param_01))
	{
		level thread notifyonround(param_01,"end_spot_zombie_round_" + param_01);
		level endon("end_spot_zombie_round_" + param_01);
	}

	var_02 = 0;
	for(;;)
	{
		var_03 = waittillplayerspotszombiereturn(param_00);
		if(!isdefined(var_03))
		{
			continue;
		}

		if(!var_02)
		{
			if(var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","spot_first_" + param_00))
			{
				var_02 = 1;
				wait(15);
			}
			else
			{
				wait(1);
			}

			continue;
		}
		else
		{
			var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","spot_" + param_00);
		}

		wait(15);
	}
}

//Function Number: 11
notifyonround(param_00,param_01)
{
	for(;;)
	{
		level waittill("zombie_wave_started");
		if(level.wavecounter >= param_00)
		{
			level notify(param_01);
			return;
		}
	}
}

//Function Number: 12
waittillplayerspotszombiereturn(param_00)
{
	level thread notifyonzombiemutatordamaged(param_00,"waittillPlayerSpotsZombieReturn_" + param_00);
	level thread notifyonplayerclosetozombiemutator(param_00,"waittillPlayerSpotsZombieReturn_" + param_00);
	level waittill("waittillPlayerSpotsZombieReturn_" + param_00,var_01);
	return var_01;
}

//Function Number: 13
notifyonzombiemutatordamaged(param_00,param_01)
{
	level endon(param_01);
	level endon("end_spot_zombie_round_7");
	for(;;)
	{
		level waittill("zombie_damaged",var_02,var_03);
		if(!isdefined(var_03) || !isdefined(var_02) || !var_02 maps\mp\zombies\_util::checkactivemutator(param_00))
		{
			continue;
		}

		level notify(param_01,var_03);
	}
}

//Function Number: 14
notifyonplayerclosetozombiemutator(param_00,param_01)
{
	level endon(param_01);
	level endon("end_spot_zombie_round_7");
	for(;;)
	{
		var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		foreach(var_04 in var_02)
		{
			if(var_04.team == level.playerteam || !var_04 maps\mp\zombies\_util::checkactivemutator(param_00))
			{
				continue;
			}

			var_05 = getplayerclosetozombie(var_04);
			if(isdefined(var_05))
			{
				level notify(param_01,var_05);
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 15
getplayerclosetozombie(param_00)
{
	var_01 = 90000;
	foreach(var_03 in level.players)
	{
		var_04 = distancesquared(var_03.origin,param_00.origin);
		if(var_04 <= var_01)
		{
			return var_03;
		}
	}
}

//Function Number: 16
zmbaudiokitingcustom()
{
	level endon("zombie_wave_ended");
	wait(randomintrange(15,30));
	if(!isdefined(level.zmbkitingvoindex))
	{
		level.zmbkitingvoindex = 0;
	}

	var_00 = level.kitingconversations[level.zmbkitingvoindex];
	var_01 = "an_conv";
	var_02 = "convo" + var_00;
	var_03 = 0;
	if(isdefined(level.vox.speaker["player"].alias[var_01]) && isdefined(level.vox.speaker["player"].alias[var_01][var_02]))
	{
		var_04 = common_scripts\utility::array_randomize(level.players);
		foreach(var_06 in var_04)
		{
			waittilldonespeaking();
			var_03 = var_06 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_01,var_02);
			if(var_03)
			{
				break;
			}
		}
	}
	else if(isdefined(level.vox.speaker["announcer_oz"].alias[var_01]) && isdefined(level.vox.speaker["announcer_oz"].alias[var_01][var_02]))
	{
		var_08 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
		var_03 = var_08 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_01,var_02);
	}
	else
	{
	}

	if(var_03)
	{
		level.zmbkitingvoindex++;
	}
}