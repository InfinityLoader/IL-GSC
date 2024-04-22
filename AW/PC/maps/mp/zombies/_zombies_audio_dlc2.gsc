/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_audio_dlc2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 500 ms
 * Timestamp: 4/22/2024 2:14:29 AM
*******************************************************************/

//Function Number: 1
initdlc2audio()
{
	level._zmbvoxlevelspecific = ::initleveldialog;
	level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp_dlc2.csv";
	level.zmbaudiowave1vo = ::zmbaudiowave1vo;
	level.zmbaudiowavestartvo = ::zmbaudiowavestartvo;
	level.zmbwaveintermissionvo = ::zmbwaveintermissionvo;
	level._audio_custom_response_line = ::zmbcustomresponseline;
	level.zmaudiocustomtrapvo = ::zmaudiocustomtrapvo;
	level thread zoneopenedvo();
	level thread zmbaudiomidroundwavelogic();
	level thread zmbspotzombiesvo();
	level thread zmbaudioacidpoolvo();
}

//Function Number: 2
initleveldialog()
{
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","wave1","dlc2_gameopen",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","wave1b","dlc2_gameopenb",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","pilot_conv","wave1_int","wave1_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","pilot_conv","wave2_int","wave2_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","pilot_conv","wave3_int","wave3_int","global_priority,wave3b_int");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","pilot_conv","wave3b_int","wave3b_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","pilot_conv","wave5_int","wave5_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","pilot_conv","wave5b_int","wave5b_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","to_burgertown","burgertown",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","to_sewers","sewers",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","to_voltage","voltage",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","to_atlas","atlasfac",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","trap_snipers","dlc2_sniper",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","trap_gators","dlc2_gator",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","trap_airstrike","dlc2_ostrike",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","trap_electric_floor","dlc2_ftrap",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","trap_ambulance","dlc2_ambulance",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","toxic_zone","dlc2_gastrap",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_acid","acid_spot_first",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_acid","acid_spot",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_spiked","dlc2_spike1st",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_spiked","dlc2_spikespot",undefined,10);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_first_goliath","goliath_spot_first",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","spot_goliath","goliath_spot",undefined,40);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","goliath_shoot","goliath_shoot",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","general","acid_pool","acid_encounter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_win_first","success",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_fail_first","1stfail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_prewave","rescue_prewave1",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_prewave_tense","rescue_pretensewave",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_wave","rescue_wave",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_wave_tense","rescue_tensewave",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_win","rescue_win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_win_tense","rescue_tense_win",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_fail","rescue_fail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_fail_tense","rescue_tense_fail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_remind","remind_wave",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","rescue_remind_tense","rescue_tense_remind",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","survivor_callout","survivor_callout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","survivor_response","survivor_response",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","survivor_instruct","survivor_instruct",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","civilian","survivor_exit","survivor_exit",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","microwave","dlc2_microgun_kill",undefined,75);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","goliath_kill","goliath_kill",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","acid_kill","acid_kill",undefined,25);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","kill","acid_pool","acid_encounter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","weapon_pickup","iw5_microwavezm_mp","dlc2_microgun",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_1","it_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_2","it_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_3","it_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_4","it_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_5","it_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_6","it_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_7","it_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_8","it_exec_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_9","it_exec_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_10","it_exec_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_1","guard_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_2","guard_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_3","guard_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_4","guard_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_5","guard_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_6","guard_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_7","guard_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_8","guard_exec_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_9","guard_exec_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_10","guard_exec_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_1","janitor_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_2","janitor_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_3","janitor_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_4","janitor_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_exec_5","janitor_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_6","janitor_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_7","janitor_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_8","janitor_exec_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_9","janitor_exec_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_10","janitor_exec_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_1","it_guard_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_2","it_guard_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_3","it_guard_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_4","it_guard_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_5","it_guard_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_6","it_guard_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_7","it_guard_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_8","it_guard_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_9","it_guard_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_10","it_guard_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_1","it_janitor_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_2","it_janitor_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_3","it_janitor_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_4","it_janitor_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_5","it_janitor_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_6","it_janitor_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_7","it_janitor_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_8","it_janitor_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_9","it_janitor_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_10","it_janitor_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_1","guard_janitor_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_2","guard_janitor_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_3","guard_janitor_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_4","guard_janitor_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_5","guard_janitor_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_6","guard_janitor_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_guard_7","guard_janitor_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_8","guard_janitor_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_9","guard_janitor_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_10","guard_janitor_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","gas_warning","trap",undefined);
	var_00 = spawn("script_model",(0,0,0));
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_pilot","pilot_",var_00,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","wave1_int","wave1_int","pilot_conv,wave1_int");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","wave3_int","wave3_int","pilot_conv,wave3_int");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","wave3b_int","wave3b_int","pilot_conv,wave3b_int");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","wave5_int","wave5_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","wave5b_int","wave5b_int",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_win_first","success",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_fail_first","1stfail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_prewave","rescue_prewave1",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_prewave_tense","rescue_pretensewave",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_wave","rescue_wave","civilian,rescue_wave");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_wave_tense","rescue_tensewave","civilian,rescue_wave_tense");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_win","rescue_win","civilian,rescue_win");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_win_tense","rescue_tense_win","civilian,rescue_win_tense");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_fail","rescue_fail","civilian,rescue_fail");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_fail_tense","rescue_tense_fail","civilian,rescue_fail_tense");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_remind","remind_wave","civilian,rescue_remind");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_pilot","global_priority","rescue_remind_tense","rescue_tense_remind","civilian,rescue_remind_tense");
	var_01 = spawn("script_model",(0,0,0));
	level.survivorvoent = var_01;
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("survivor1","survivor_",var_01,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("survivor2","survivor02_",var_01,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("survivor3","survivor03_",var_01,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1","general","callout","callout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2","general","callout","callout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3","general","callout","callout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1","general","greet","greet",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2","general","greet","greet",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3","general","greet","greet",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1","general","freakout","freakout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2","general","freakout","freakout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3","general","freakout","freakout",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1","general","instruct","instruct",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2","general","instruct","instruct",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3","general","instruct","instruct",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor1","general","exit","exit",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor2","general","exit","exit",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("survivor3","general","exit","exit",undefined);
}

//Function Number: 3
zmbaudiomidroundwavelogic()
{
	level.zmlastcivilianchatterplayed = 0;
	level.zmnumcivilianroundsattempted = 0;
	for(;;)
	{
		level waittill("zombie_wave_started");
		if(level.wavecounter + 1 == level.nextcivilianround)
		{
			level thread zmbtrackzombiesprecivilianchatter();
		}

		if(level.roundtype == "civilian")
		{
			level thread zmbcivilianremindervo();
			level thread zmbciviliansurvivorvo();
			level thread zmbcivilianroundfinishedvo();
		}
	}
}

//Function Number: 4
zmbtrackzombiesprecivilianchatter()
{
	wait 0.05;
	while(level.zombie_spawning_active)
	{
		wait(1);
	}

	var_00 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();
	for(;;)
	{
		if(var_00 <= 10)
		{
			break;
		}

		var_00 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();
		wait 0.05;
	}

	var_01 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
	var_02 = var_01[0];
	var_03 = "rescue_prewave";
	if(zmbaudioiscivilianroundtense())
	{
		var_03 = var_03 + "_tense";
	}

	waittilldonespeaking();
	if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority",var_03))
	{
		var_02 common_scripts\utility::waittill_notify_or_timeout("done_speaking",12);
		var_04 = randomintrange(0,level.players.size);
		var_05 = level.players[var_04];
		if(var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian",var_03))
		{
			var_05 common_scripts\utility::waittill_notify_or_timeout("done_speaking",12);
		}
	}

	level.zmlastcivilianchatterplayed = level.wavecounter;
	level notify("civilianPreChatterComplete");
}

//Function Number: 5
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

//Function Number: 6
waittilldonespeaking()
{
	while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking())
	{
		wait 0.05;
	}
}

//Function Number: 7
zmbcivilianremindervo()
{
	level endon("civilian_spawned");
	wait(30);
	var_00 = "rescue_remind";
	if(zmbaudioiscivilianroundtense())
	{
		var_00 = var_00 + "_tense";
	}

	var_01 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
	var_02 = var_01[0];
	if(isdefined(var_02))
	{
		var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority",var_00);
	}
}

//Function Number: 8
zmbciviliansurvivorvo()
{
	level waittill("civilian_spawned",var_00);
	var_00 endon("death");
	var_01 = level.survivorvoent;
	var_01.zmbvoxid = "survivor" + randomintrange(1,4);
	var_01 linkto(var_00,"tag_origin",(0,0,60),(0,0,0));
	wait 0.05;
	if(var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","callout"))
	{
		var_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		var_02 = getclosestplayer(var_01.origin);
		if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian","survivor_callout"))
		{
			var_02 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		}
	}

	var_03 = 65536;
	while(!var_00 maps\mp\zombies\_civilians::areplayerswithinrange(var_03))
	{
		wait 0.05;
	}

	if(var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","greet"))
	{
		var_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		var_02 = getclosestplayer(var_01.origin);
		if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian","survivor_response"))
		{
			var_02 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		}
	}

	var_04 = 8000;
	var_05 = 0;
	for(;;)
	{
		var_06 = var_00 common_scripts\utility::waittill_any_return_no_endon_death("damage","begin_extraction","extraction_started");
		if(var_06 == "damage" && gettime() > var_05)
		{
			var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","freakout");
			var_05 = gettime() + var_04;
		}

		if(var_06 == "begin_extraction")
		{
			var_02 = getclosestplayer(var_01.origin);
			if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian","survivor_instruct"))
			{
				var_02 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
				if(var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","instruct"))
				{
					var_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
				}
			}
		}

		if(var_06 == "extraction_started")
		{
			var_02 = getclosestplayer(var_01.origin);
			if(var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian","survivor_exit"))
			{
				var_02 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
				if(var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","exit"))
				{
					var_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
				}
			}

			return;
		}
	}
}

//Function Number: 9
getclosestplayer(param_00)
{
	var_01 = sortbydistance(level.players,param_00,undefined,1);
	return var_01[0];
}

//Function Number: 10
zmbcivilianroundfinishedvo()
{
	var_00 = level common_scripts\utility::waittill_any_return("extraction_failed","extraction_complete");
	wait(3);
	var_01 = "rescue";
	if(var_00 == "extraction_complete")
	{
		var_01 = var_01 + "_win";
	}
	else
	{
		var_01 = var_01 + "_fail";
	}

	if(level.wavecounter == level.firstcivilianround)
	{
		var_01 = var_01 + "_first";
		var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
		var_03 = var_02[0];
		if(isdefined(var_03) && var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority",var_01))
		{
			var_03 common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
		}

		var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
		if(isdefined(var_04) && var_04 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian",var_01))
		{
			var_04 common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
		}

		var_05 = maps\mp\zombies\_zombies_audio::getanycharacterbyprefixexcept("it");
		if(isdefined(var_05) && var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("civilian",var_01))
		{
			var_05 common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
		}
	}
	else
	{
		if(zmbaudioiscivilianroundtense())
		{
			var_03 = var_03 + "_tense";
		}

		var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
		var_03 = var_03[0];
		if(isdefined(var_03))
		{
			var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority",var_01);
		}
	}

	level.zmnumcivilianroundsattempted++;
}

//Function Number: 11
zmbaudioiscivilianroundtense()
{
	return level.zmnumcivilianroundsattempted > 4;
}

//Function Number: 12
zmbaudiowave1vo()
{
	if(level.players.size == 1 && maps\mp\zombies\_util::get_player_index(level.players[0]) != maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix("it"))
	{
		level.players[0] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","intro");
		return;
	}

	var_00 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
	if(isdefined(var_00) && var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","wave1"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
	}

	if(level.players.size == 1)
	{
		return;
	}

	var_00 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
	if(isdefined(var_00) && var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","wave1"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
	}

	var_00 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");
	if(isdefined(var_00) && var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","wave1"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
	}

	var_00 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
	if(isdefined(var_00) && var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","wave1b"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
	}

	var_00 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("janitor");
	if(isdefined(var_00) && var_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","wave1"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",5);
	}
}

//Function Number: 13
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

//Function Number: 14
zmbwaveintermissionvo(param_00)
{
	var_01 = param_00;
	if(level.wavecounter == 1)
	{
		var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
		var_03 = var_02[0];
		var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","wave1_int");
		var_01 = 1;
	}
	else if(level.wavecounter == 2)
	{
		level thread maps\mp\zombies\_zombies_audio::playwavenumintrodialog("wave2_int",2,0,1,3,"pilot_conv");
		var_01 = 1;
	}
	else if(level.wavecounter == 3)
	{
		var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
		var_03 = var_02[0];
		var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","wave3_int");
		var_01 = 1;
	}
	else if(level.wavecounter == 5)
	{
		var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
		var_03 = var_02[0];
		if(var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","wave5_int"))
		{
			var_03 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		}

		var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("janitor");
		if(isdefined(var_04) && var_04 maps\mp\zombies\_zombies_audio::create_and_play_dialog("pilot_conv","wave5_int"))
		{
			var_04 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		}

		waittilldonespeaking();
		if(var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","wave5b_int"))
		{
			var_03 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		}

		var_05 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
		if(isdefined(var_05) && var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("pilot_conv","wave5b_int"))
		{
			var_05 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
		}

		var_01 = 1;
	}
	else if(level.wavecounter + 1 == level.nextcivilianround)
	{
		level thread zmplaycivilianmissionstartvo();
	}

	return var_01;
}

//Function Number: 15
zmplaycivilianmissionstartvo()
{
	if(level.zmlastcivilianchatterplayed < level.wavecounter)
	{
		level waittill("civilianPreChatterComplete");
	}

	var_00 = "rescue_wave";
	if(zmbaudioiscivilianroundtense())
	{
		var_00 = var_00 + "tense";
	}

	var_01 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
	var_02 = var_01[0];
	var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority",var_00);
}

//Function Number: 16
zoneopenedvo()
{
	level thread _waitandplayzonevo("sewer_to_burgertown",undefined,"to_burgertown");
	level thread _waitandplayzonevo("gas_station_to_sewer","atlas_to_sewer","to_sewers");
	level thread _waitandplayzonevo("warehouse_to_gas_station","gas_station_to_sewer","to_voltage");
	level thread _waitandplayzonevo("warehouse_to_atlas","atlas_to_sewer","to_atlas");
}

//Function Number: 17
_waitandplayzonevo(param_00,param_01,param_02)
{
	var_03 = level common_scripts\utility::waittill_any_return_parms(param_00,param_01);
	var_04 = var_03[0];
	var_05 = var_03[1];
	var_06 = maps\mp\zombies\_zombies_audio_announcer::getannouncer();
	var_06 common_scripts\utility::waittill_notify_or_timeout("done_speaking",3);
	wait(0.5);
	if(isdefined(var_05))
	{
		var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general",param_02);
	}
}

//Function Number: 18
zmbcustomresponseline(param_00,param_01,param_02,param_03,param_04)
{
	if(param_02 == "pilot_conv")
	{
		level thread setup_pilot_conversation_response_line(param_00,param_02,param_03);
		return;
	}

	if(param_02 == "an_conv" || param_02 == "civilian")
	{
		level thread maps\mp\zombies\_zombies_audio::setup_announcer_conversation_response_line(param_00,param_02,param_03);
		return;
	}

	level thread maps\mp\zombies\_zombies_audio::setup_response_line(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 19
setup_pilot_conversation_response_line(param_00,param_01,param_02)
{
	var_03 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("pilot");
	var_04 = var_03[0];
	var_05 = level.vox.speaker[param_00.zmbvoxid].response[param_01][param_02];
	var_06 = strtok(var_05,",");
	if(var_06.size == 2)
	{
		param_01 = var_06[0];
		param_02 = var_06[1];
		var_04 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_01,param_02);
		return;
	}

	if(var_06.size == 1)
	{
		param_02 = var_06[0];
		var_07 = common_scripts\utility::array_randomize(level.players);
		foreach(param_00 in var_07)
		{
			var_09 = param_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_01,param_02,"");
			if(var_09)
			{
				break;
			}
		}
	}
}

//Function Number: 20
zmaudiocustomtrapvo(param_00,param_01)
{
	wait(1);
	if(!isdefined(param_00.script_noteworthy) || !isdefined(param_01))
	{
		return;
	}

	param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general",param_00.script_noteworthy);
}

//Function Number: 21
zmaudiotoxiczonesvo(param_00)
{
	var_01 = common_scripts\utility::array_randomize(level.players);
	foreach(var_03 in param_00)
	{
		foreach(var_05 in var_01)
		{
			if(maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_03))
			{
				var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","toxic_zone");
				return;
			}
		}
	}
}

//Function Number: 22
zmbspotzombiesvo()
{
	level thread zmbspotzombie("spiked");
	level thread zmbspotzombie("acid");
	level thread zmbhandlegoliath();
}

//Function Number: 23
zmbhandlegoliath()
{
	level.zmbaudioplayedfirstspotmeleegoliath = 0;
	for(;;)
	{
		level waittill("onZombieMeleeGoliathSpawn",var_00);
		level thread zmbspotgoliath(var_00);
	}
}

//Function Number: 24
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

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
zmbspotzombie(param_00)
{
	level thread notifyonround(7,"end_spot_zombie_round_7");
	level endon("end_spot_zombie_round_7");
	var_01 = 1;
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

//Function Number: 28
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

//Function Number: 29
waittillplayerspotszombiereturn(param_00)
{
	level thread notifyonzombiemutatordamaged(param_00,"waittillPlayerSpotsZombieReturn_" + param_00);
	level thread notifyonplayerclosetozombiemutator(param_00,"waittillPlayerSpotsZombieReturn_" + param_00);
	level waittill("waittillPlayerSpotsZombieReturn_" + param_00,var_01);
	return var_01;
}

//Function Number: 30
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

//Function Number: 31
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

//Function Number: 32
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

//Function Number: 33
zmbaudioacidpoolvo()
{
	for(;;)
	{
		if(level.nextgen)
		{
			level waittill("acid_zone_created",var_00);
			var_01 = getclosestplayer(var_00.origin);
		}
		else
		{
			level waittill("acid_zone_created",var_02);
			var_01 = getclosestplayer(var_02);
		}

		if(var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","acid_pool"))
		{
			level waittill("zombie_wave_started");
			if(level.wavecounter > 6)
			{
				return;
			}
		}
	}
}