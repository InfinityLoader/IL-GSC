/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_audio_dlc3.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 500 ms
 * Timestamp: 4/22/2024 2:14:31 AM
*******************************************************************/

//Function Number: 1
initdlc3audio()
{
	level._zmbvoxlevelspecific = ::initleveldialog;
	level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp_dlc3.csv";
	level.zmbaudiozonetrackingdelay = 5;
	level.zmbplayersmet = 0;
	level.zmbaudioscheduleoz = randomintrange(10,21);
	level.zmballcustomozresponsesplayed = 0;
	level.numkitingconversations = 18;
	level.zmbaudiowave1vo = ::zmbaudiowave1vo;
	level.zmbwaveintermissionvo = ::zmbwaveintermissionvo;
	level.zmbaudiowavestartvo = ::zmbaudiowavestartvo;
	level.zmbdowaveendvo = ::zmbdowaveendvo;
	level.zmaudiocustomtrapvo = ::zmaudiocustomtrapvo;
	level.zmbaudioplayaltvofunc = ::zmbaudioplayaltvofunc;
	level.zmbaudioresponsetoannounceroverridefunc = ::zmbaudioresponsetoannounceroverridefunc;
	level.zmbcustomresponsetoannouncer = ::zmbcustomresponsetoannouncer;
	level.zmbcustomsupplydropvo = ::zmbcustomsupplydropvo;
	level.zmbaudiokitingcustom = ::zmbaudiokitingcustom;
	level thread zmbspotzombiesvo();
	level thread fixupterminalattractors();
}

//Function Number: 2
initleveldialog()
{
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","ignore_nearby","dlc3_open_01","dlc3_open_01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","ignore_nearby","dlc3_open_02","dlc3_open_02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","ignore_nearby","dlc3_open_03","dlc3_open_03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","ignore_nearby","intro","rnd_wave1",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","global_priority","meet1","meet_01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","global_priority","meet2","meet_02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","global_priority","meet3","meet_03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_goliath","goliath_spot_first",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_goliath","goliath_spot",undefined,40);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","goliath_shoot","goliath_shoot",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_spiked","dlc2_spike1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_spiked","dlc2_spikespot",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_teleport","dlc3_blink1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_teleport","dlc3_blink",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","td_spot","dlc3_td_spot",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","td_lose","dlc3_td_lose",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","td_win","dlc3_td_win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","turret_trap","trap_roomba",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","laser","traps_pckup",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","steam","trap_steam",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","water_floor_trap","trap_wtr",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","zomboni","dlc3_gtrap",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","plinko_see","dlc3_plinko_see",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","plinko_small","dlc3_plinko_small",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","plinko_med","dlc3_plinko_med",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","plinko_lrg","dlc3_plinko_lrg",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","atlas_react","dlc3_atlas",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","atlas_conv","atlas_conv",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","sentinel_conv","sentinel_conv",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","teleport_use","dlc3_teleport_use",undefined,20);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","ss_use_disruptor","ss_disrupt",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","chum_water","trap_shrk",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","oz_response","oz_response",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","monologue","oz_response","oz_response",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","teleport_zombies_mp","dlc3_teleport",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","teleport_throw_zombies_mp","dlc3_teleport",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_linegunzm_mp","dlc3_linegun",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_dlcgun2zm_mp","dlc3_ohm",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_dlcgun3zm_mp","dlc3_m1i",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","repulsor_zombie_mp","dlc3_repulsor",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","linegun","dlc3_linegun_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","ohm","dlc3_ohm_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","m1irons","dlc3_m1i_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","respulsor","dlc3_repulsor_kill",undefined,7);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","goliath_kill","goliath_kill",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","powerup","open_fire","dlc3_inf_ammo",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","powerup","ex_touch","dlc3_overcharge",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","perk","exo_tacticalArmor","dlc3_exo_stck",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","monologue","teleport_machine","dlc3_tele",undefined);
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
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_1","pilot_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_2","pilot_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_3","pilot_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_pilot_4","pilot_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_exec_5","pilot_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_exec_6","pilot_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_exec_7","pilot_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_1","it_guard_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_2","it_guard_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_3","it_guard_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_4","it_guard_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_5","it_guard_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_6","it_guard_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_7","it_guard_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_8","it_guard_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_9","it_guard_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_1","it_pilot_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_2","it_pilot_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_3","it_pilot_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_4","it_pilot_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_5","it_pilot_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_6","it_pilot_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_7","it_pilot_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_8","it_pilot_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_it_9","it_pilot_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_10","it_pilot_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_pilot_11","it_pilot_wave_intermission_ctx11",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_1","guard_pilot_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_guard_2","guard_pilot_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_guard_3","guard_pilot_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_4","guard_pilot_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_5","guard_pilot_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_pilot_6","guard_pilot_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","pilot_guard_7","guard_pilot_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","open_fire","open_fire","powerup,open_fire");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","ex_touch","ex_touch","powerup,ex_touch");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_rearbay","exp_rearbay","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_moonpool","exp_moonpool","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_armory","exp_armory","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_cargo_elevator","exp_cargo_elevator","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_cargo_bay","exp_cargo_bay","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_biomed","exp_biomed","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_medical","exp_medical","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_sidebay","exp_sidebay","general,atlas_react");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_fail1","exp_fail1",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_fail2","exp_fail2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_fail3","exp_fail3",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_win","exp_win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_round","exp_round",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exp_round_gol","exp_round_gol",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_rearbay","pow_rearbay","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_moonpool","pow_moonpool","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_armory","pow_armory","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_cargo_elevator","pow_cargo_elevator","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_cargo_01","pow_cargo_bay","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_biomed","pow_biomed","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_medbay","pow_medical","general,power_on");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_sidebay_01","pow_sidebay","general,power_on");
	var_00 = spawnstruct();
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("atlas","atlas_",var_00,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas","general","chatter","chatter",undefined,30);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas","general","trydefuse","trydefuse",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas","general","fail","fail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas","general","goliath","goliath",undefined);
	level.atlasdebouncevo = [];
	level.atlasdebouncevo["chatter"] = 0;
	level.atlasdebouncevo["trydefuse"] = 0;
	level.atlasdebouncevo["fail"] = 0;
	level.atlasdebouncevo["goliath"] = 0;
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
	var_01 = spawn("script_model",(0,0,0));
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz","janitor_",var_01,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","exo_suit_avail","exo_suit_avail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","exo_online","exo_online","general,thanks");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","hyper_dmg","hyper_dmg","powerup,insta_kill");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","dna_bomb","dna_bomb","powerup,apocalypse");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","pow_surge","pow_surge","powerup,pow_surge");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","full_reload","full_reload","powerup,max_ammo");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","multiplier","multiplier","powerup,2x_pts");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","security","security","powerup,traps");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","zombie_dog","mongrel",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","zombie_host","host",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","open_fire","inf_ammo","powerup,open_fire");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","ex_touch","overcharge","powerup,ex_touch");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global","door","door",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global","printer","printer_bk","general,printer_moved");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global","supply","supply",undefined,30);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global","rand","rand",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","host_cure","cure","general,cured");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","host_cure2","cure2",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","laser_trap","trap","general,laser_traps");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","jackpot","cash_ee",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","specialty_fastreload","exo_reload",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","exo_health","exo_health",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","exo_revive","exo_medic",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","exo_stabilizer","exo_soldier",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","exo_slam","exo_slam",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","wallbuy","wallbuy",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","printer","printer",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","weapon_upgrade","wpn_upgd",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_per_player","power_switch","pwr_swtich",undefined);
}

//Function Number: 3
fixupterminalattractors()
{
	var_00 = getentarray("perk_terminal","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_parameters) && var_02.script_parameters == "exo_stabilizer")
		{
			var_02.postpowerattractorwait = 3;
		}
	}

	var_04 = getentarray("weapon_level_box","targetname");
	foreach(var_06 in var_04)
	{
		var_06.firsttimeattractorwait = 5;
	}
}

//Function Number: 4
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

//Function Number: 5
waittilldonespeaking()
{
	while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking())
	{
		wait 0.05;
	}
}

//Function Number: 6
getclosestplayer(param_00)
{
	var_01 = sortbydistance(level.players,param_00,undefined,1);
	return var_01[0];
}

//Function Number: 7
zmbaudiowave1vo()
{
	if(level.players.size == 1)
	{
		level.players[0] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","intro");
		level.zmbplayersmet = 1;
		return;
	}

	var_00 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");
	var_01 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
	var_02 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
	var_03 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");
	if(level.players.size == 3)
	{
		if(isdefined(var_00) && !isdefined(var_01))
		{
			var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","intro",undefined,undefined,undefined,undefined,[var_00]);
		}
		else if(isdefined(var_01) && !isdefined(var_00))
		{
			var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","intro",undefined,undefined,undefined,undefined,[var_01]);
		}
		else if(isdefined(var_02) && !isdefined(var_03))
		{
			var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","intro",undefined,undefined,undefined,undefined,[var_02]);
		}
		else if(isdefined(var_03) && !isdefined(var_02))
		{
			var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","intro",undefined,undefined,undefined,undefined,[var_03]);
		}
	}

	if(isdefined(var_00) && isdefined(var_01))
	{
		level thread zmbintrodialogue(var_00,var_01);
	}

	if(isdefined(var_02) && isdefined(var_03))
	{
		level thread zmbintrodialogue(var_02,var_03);
	}

	if(level.players.size > 2 && isdefined(var_00))
	{
		level waittill("zmbIntroDialogue");
		level thread zmbaudioplayersmeet(var_00);
		return;
	}

	level.zmbplayersmet = 1;
}

//Function Number: 8
zmbintrodialogue(param_00,param_01)
{
	var_02 = isdefined(param_00) && isdefined(param_01);
	if(param_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","dlc3_open_01",undefined,undefined,undefined,undefined,[param_00,param_01]))
	{
		param_00 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		var_02 = isdefined(param_00) && isdefined(param_01);
	}

	if(var_02 && param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","dlc3_open_01",undefined,undefined,undefined,undefined,[param_00,param_01]))
	{
		param_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		var_02 = isdefined(param_00) && isdefined(param_01);
	}

	if(var_02 && param_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","dlc3_open_02",undefined,undefined,undefined,undefined,[param_00,param_01]))
	{
		param_00 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		var_02 = isdefined(param_00) && isdefined(param_01);
	}

	if(var_02 && param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","dlc3_open_02",undefined,undefined,undefined,undefined,[param_00,param_01]))
	{
		param_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		var_02 = isdefined(param_00) && isdefined(param_01);
	}

	if(var_02 && param_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby","dlc3_open_03",undefined,undefined,undefined,undefined,[param_00,param_01]))
	{
		param_00 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
	}

	level notify("zmbIntroDialogue");
}

//Function Number: 9
zmbaudioplayersmeet(param_00)
{
	while(!isdefined(level.zone_data))
	{
		wait(0.05);
	}

	for(;;)
	{
		if(!isdefined(param_00))
		{
			level.zmbplayersmet = 1;
			return;
		}

		if(anyplayersspeaking())
		{
			wait(1);
			continue;
		}

		var_01 = getarraykeys(level.zone_data.zones);
		foreach(var_03 in var_01)
		{
			var_04 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone(var_03,0);
			if(var_04.size > 1)
			{
				if(listincludescharacter(var_04,"pilot") && listincludescharacter(var_04,"guard") || listincludescharacter(var_04,"exec"))
				{
					var_05 = param_00;
					var_06 = getcharacterfromlist(var_04,"guard");
					var_07 = getcharacterfromlist(var_04,"exec");
					var_08 = var_06;
					if(!isdefined(var_06) || isdefined(var_07) && common_scripts\utility::cointoss())
					{
						var_08 = var_07;
					}

					var_09 = isdefined(var_05) && isdefined(var_08);
					maps\mp\zombies\_zombies_audio::zmbsetglobalpriorityonly(1);
					if(var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","meet1"))
					{
						var_05 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
						var_09 = isdefined(var_05) && isdefined(var_08);
					}

					if(var_09 && var_08 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","meet2"))
					{
						var_08 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
						var_09 = isdefined(var_05) && isdefined(var_08);
					}

					if(var_09 && var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","meet3"))
					{
						var_05 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
					}

					maps\mp\zombies\_zombies_audio::zmbsetglobalpriorityonly(0);
					level.zmbplayersmet = 1;
					return;
				}
			}
		}

		wait(1);
	}
}

//Function Number: 10
listincludescharacter(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03.characterindex == maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
getcharacterfromlist(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03.characterindex == maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix(param_01))
		{
			return var_03;
		}
	}
}

//Function Number: 12
zmbaudiowavestartvo(param_00)
{
	if(!param_00 && level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 20 || level.wavecounter == 35 || level.wavecounter == 50)
	{
		var_01 = randomintrange(0,level.players.size);
		level.players[var_01] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","round_" + level.wavecounter);
		param_00 = 1;
	}

	return param_00;
}

//Function Number: 13
zmbdowaveendvo()
{
	return !maps\mp\zombies\_area_invalidation::is_next_round_transition_venting();
}

//Function Number: 14
zmbwaveintermissionvo(param_00)
{
	if(!level.zmbplayersmet)
	{
		return 1;
	}
	else if(maps\mp\zombies\_area_invalidation::is_next_round_transition_venting())
	{
		level common_scripts\utility::waittill_notify_or_timeout("area_invalidation_vo_complete",8);
		return 1;
	}

	return 0;
}

//Function Number: 15
zmaudiocustomtrapvo(param_00,param_01)
{
	wait(1);
	if(!isdefined(param_00.script_noteworthy) || !isdefined(param_01))
	{
		return;
	}

	param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general",param_00.script_noteworthy);
}

//Function Number: 16
zmbspotzombiesvo()
{
	level thread zmbspotzombie("spiked");
	level thread zmbspotzombie("teleport");
	level thread zmbhandlegoliath();
}

//Function Number: 17
zmbhandlegoliath()
{
	level.zmbaudioplayedfirstspotmeleegoliath = 0;
	for(;;)
	{
		level waittill("onZombieMeleeGoliathSpawn",var_00);
		level thread zmbspotgoliath(var_00);
	}
}

//Function Number: 18
zmbspotgoliath(param_00)
{
	param_00 endon("death");
	var_01 = 1;
	level thread notifyongoliathdamaged(param_00,"waittillPlayerSpotsGoliathReturn","damage");
	level thread notifyonplayerclosetogoliath(param_00,"waittillPlayerSpotsGoliathReturn","close");
	for(;;)
	{
		param_00 waittill("waittillPlayerSpotsGoliathReturn",var_02,var_03);
		if(!isdefined(var_02))
		{
			continue;
		}

		if(!level.zmbaudioplayedfirstspotmeleegoliath)
		{
			if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","spot_first_goliath"))
			{
				var_01 = 0;
				level.zmbaudioplayedfirstspotmeleegoliath = 1;
			}
		}
		else if(var_01)
		{
			var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","spot_goliath");
			var_01 = 0;
		}
		else if(var_03 == "damage" && param_00.health <= param_00.maxhealth / 2)
		{
			if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","goliath_shoot"))
			{
				return;
			}
		}

		wait 0.05;
		level thread notifyongoliathdamaged(param_00,"waittillPlayerSpotsGoliathReturn","damage");
	}
}

//Function Number: 19
notifyongoliathdamaged(param_00,param_01,param_02)
{
	param_00 endon(param_01);
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("damage",var_03,var_04);
		param_00 notify(param_01,var_04,param_02);
	}
}

//Function Number: 20
notifyonplayerclosetogoliath(param_00,param_01,param_02)
{
	param_00 endon(param_01);
	param_00 endon("death");
	for(;;)
	{
		var_03 = getplayerclosetozombie(param_00);
		if(isdefined(var_03))
		{
			param_00 notify(param_01,var_03,param_02);
			return;
		}

		wait 0.05;
	}
}

//Function Number: 21
zmbspotzombie(param_00)
{
	level thread notifyonround(7,"end_spot_zombie_round_7");
	level endon("end_spot_zombie_round_7");
	var_01 = 0;
	for(;;)
	{
		var_02 = waittillplayerspotszombiereturn(param_00);
		if(!isdefined(var_02))
		{
			continue;
		}

		if(!var_01)
		{
			if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","spot_first_" + param_00))
			{
				var_01 = 1;
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
			var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","spot_" + param_00);
		}

		wait(15);
	}
}

//Function Number: 22
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

//Function Number: 23
waittillplayerspotszombiereturn(param_00)
{
	level thread notifyonzombiemutatordamaged(param_00,"waittillPlayerSpotsZombieReturn_" + param_00);
	level thread notifyonplayerclosetozombiemutator(param_00,"waittillPlayerSpotsZombieReturn_" + param_00);
	level waittill("waittillPlayerSpotsZombieReturn_" + param_00,var_01);
	return var_01;
}

//Function Number: 24
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

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
zmbaudioplayaltvofunc(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self.zmbvoxid == "announcer")
	{
		level.zmbaudioscheduleoz--;
		var_07 = level.zmbaudioscheduleoz <= 0;
		if(level.zmbaudioscheduleoz <= 0)
		{
			var_07 = 1;
			level.zmbaudioscheduleoz = randomintrange(10,21);
		}

		if(!var_07)
		{
			var_07 = randomint(100) <= level.wavecounter * 2;
		}

		if(var_07)
		{
			var_08 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
			var_08.origin = self.origin;
			return var_08 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
		}
	}

	return 0;
}

//Function Number: 28
zmbaudioresponsetoannounceroverridefunc(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01) || level.zmballcustomozresponsesplayed || param_00.zmbvoxid != "announcer_oz")
	{
		return 0;
	}

	return param_01 playerdoozresponse(param_02 == "machine_per_player");
}

//Function Number: 29
zmbcustomresponsetoannouncer(param_00,param_01,param_02,param_03,param_04)
{
	if(level.zmballcustomozresponsesplayed || param_00.zmbvoxid != "announcer_oz")
	{
		return 0;
	}

	if(isdefined(param_04))
	{
		param_04 = common_scripts\utility::array_removeundefined(param_04);
	}

	if(!isdefined(param_01))
	{
		if(maps\mp\zombies\_zombies_audio_announcer::announcercategoryisplaylocal(param_02))
		{
			param_01 = zmbgetplayerwithcustomozresponse();
		}
		else if(isdefined(param_04))
		{
			param_01 = zmbgetplayerwithcustomozresponse(undefined,param_04);
		}
		else
		{
			param_01 = zmbgetplayerwithcustomozresponse(param_00.origin);
		}
	}

	if(isdefined(param_01))
	{
		param_01 playerdoozresponse(param_02 == "machine_per_player");
	}
}

//Function Number: 30
playerdoozresponse(param_00)
{
	if(!isdefined(self.customozresponseindex))
	{
		self.customozresponseindex = 0;
	}

	var_01 = self.customozresponseindex + 1;
	var_02 = "general";
	if(param_00)
	{
		var_02 = "monologue";
	}

	if(maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_02,"oz_response","",var_01))
	{
		self.customozresponseindex++;
		if(self.customozresponseindex >= 2 && !isdefined(zmbgetplayerwithcustomozresponse()))
		{
			level.zmballcustomozresponsesplayed = 1;
			foreach(var_04 in level.players)
			{
				var_04.customozresponseindex = undefined;
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 31
zmbgetplayerwithcustomozresponse(param_00,param_01)
{
	var_02 = 250000;
	if(!isdefined(param_01))
	{
		param_01 = level.players;
	}

	foreach(var_04 in param_01)
	{
		if((!isdefined(var_04.customozresponseindex) || var_04.customozresponseindex < 2) && !isdefined(param_00) || distancesquared(var_04.origin,param_00) <= var_02)
		{
			return var_04;
		}
	}
}

//Function Number: 32
zmbcustomsupplydropvo()
{
	if(!maps\mp\zombies\_util::is_true(level.zmkillstreakcrateprevo) || level.wavecounter < 5)
	{
		return;
	}

	var_00 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global","supply");
}

//Function Number: 33
zmbaudiokitingcustom()
{
	level endon("zombie_wave_ended");
	wait(randomintrange(15,30));
	var_00 = level.kitingconversations.size - 1;
	var_01 = level.kitingconversations[var_00];
	var_02 = "global";
	var_03 = "rand";
	var_04 = 0;
	if(isdefined(level.vox.speaker["player"].alias[var_02]) && isdefined(level.vox.speaker["player"].alias[var_02][var_03]))
	{
		var_05 = common_scripts\utility::array_randomize(level.players);
		foreach(var_07 in var_05)
		{
			maps\mp\zombies\_zombies_audio::waituntilquietnearby(var_07,var_02);
			var_08 = var_07 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_02,var_03);
			if(var_08)
			{
				break;
			}
		}
	}
	else if(isdefined(level.vox.speaker["announcer_oz"].alias[var_02]) && isdefined(level.vox.speaker["announcer_oz"].alias[var_02][var_03]))
	{
		var_0A = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
		var_0A maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_02,var_03,undefined,undefined,undefined,level.players[0],level.players);
	}
	else
	{
	}

	level.kitingconversations[var_00] = undefined;
}