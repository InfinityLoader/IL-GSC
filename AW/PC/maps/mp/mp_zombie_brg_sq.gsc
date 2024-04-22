/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_brg_sq.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 206
 * Decompile Time: 3162 ms
 * Timestamp: 4/22/2024 2:19:24 AM
*******************************************************************/

//Function Number: 1
init_sidequest()
{
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("main",::init_main_sidequest,::sidequest_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage1",::stage1_init,::stage1_logic,::stage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage2",::stage2_init,::stage2_logic,::stage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage3",::stage3_init,::stage3_logic,::stage3_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage4",::stage4_init,::stage4_logic,::stage4_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage5",::stage5_init,::stage5_logic,::stage5_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage6",::stage6_init,::stage6_logic,::stage6_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage7",::stage7_init,::stage7_logic,::stage7_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage8",::stage8_init,::stage8_logic,::stage8_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage9",::stage9_init,::stage9_logic,::stage9_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage10",::stage10_init,::stage10_logic,::stage10_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage11",::stage11_init,::stage11_logic,::stage11_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage12",::stage12_init,::stage12_logic,::stage12_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage13",::stage13_init,::stage13_logic,::stage13_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage14",::stage14_init,::stage14_logic,::stage14_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage15",::stage15_init,::stage15_logic,::stage15_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage16",::stage16_init,::stage16_logic,::stage16_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage17",::stage17_init,::stage17_logic,::stage17_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("song",::init_song_sidequest,::sidequest_logic_song);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage1",::songstage1_init,::songstage1_logic,::songstage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage2",::songstage2_init,::songstage2_logic,::songstage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage3",::songstage3_init,::songstage3_logic,::songstage3_end);
	precachemodel("det_basement_valve_01_anim");
	precachemodel("dlc2_brg_bun");
	precachemodel("dlc2_brg_burger_bomb");
	precachemodel("dlc2_zom_gib_arm_pickup");
	precachempanim("mp_dogtag_spin");
	precachempanim("zom_mbot_activation_yumm");
	precachempanim("zom_mbot_activation_key");
	precachestring(&"ZOMBIE_BRG_BOMB_THROW");
	common_scripts\utility::flag_init("sewermain_to_sewercave");
	common_scripts\utility::flag_init("sewer_to_burgertown");
	common_scripts\utility::create_dvar("battery_open",0);
	common_scripts\utility::create_dvar("secret_cave_open",0);
	level thread randomizemeatchunks();
	level thread start_brg_sidequest();
	level thread beauford_greetings();
	level thread beauford_interact();
	level thread beauford_hit();
	level thread beauford_kills();
	thread toilet_interact();
	thread fingerprint_scanner_fail_fx();
	level thread onplayerconnected();
	level thread onanyplayerspawned();
	level thread initvo();
}

//Function Number: 2
start_brg_sidequest()
{
	wait(3);
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

//Function Number: 3
init_main_sidequest()
{
	level.sidequeststarted = 0;
	level.burgerhatchlocked = 1;
	thread sidequest_init_hidden();
	thread init_burger_teleporter();
	thread burger_room_valve_lock("locked");
	thread burger_room_locked_audio();
	foreach(var_01 in level.players)
	{
		thread init_player_variables();
		thread playertakeitemondisconnect();
	}
}

//Function Number: 4
init_burger_teleporter()
{
	common_scripts\utility::flag_wait("sewer_to_burgertown");
	foreach(var_01 in level.zombieteleporters)
	{
		if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "burgertower_teleport")
		{
			var_01 thread maps\mp\zombies\_teleport::teleporter_disable();
		}
	}
}

//Function Number: 5
init_player_variables()
{
	self.hasskilletgolden = undefined;
	self.hasskilletseasoned = undefined;
	self.hasmeat = 0;
	self.batteryisopen = undefined;
	self.hasbun = undefined;
	self.hasburgerinfected = undefined;
	self.hasburger = undefined;
	self.hasbatterydepleted = undefined;
	self.hasbatterycharged = undefined;
	self.hasarm = undefined;
	self.hasdriveencrypted = undefined;
	self.hasdrivedecrypted = undefined;
	self.haskey = undefined;
}

//Function Number: 6
sidequest_init_hidden()
{
	var_00 = getentarray("sq_hidden","target");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_04 = getentarray("burger_rocket_fin","targetname");
	foreach(var_06 in var_04)
	{
		var_06 hide();
	}

	var_08 = getentarray("zombie_meat_chunk_gs","targetname");
	var_09 = getentarray("zombie_meat_chunk_ac","targetname");
	var_0A = getentarray("zombie_meat_chunk_sw","targetname");
	var_0B = getentarray("zombie_meat_chunk_bt","targetname");
	var_0C = common_scripts\utility::array_combine(var_08,var_09);
	var_0D = common_scripts\utility::array_combine(var_0A,var_0B);
	var_0E = common_scripts\utility::array_combine(var_0C,var_0D);
	foreach(var_10 in var_0E)
	{
		var_10 hide();
	}
}

//Function Number: 7
sidequest_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage1");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage2");
	level common_scripts\utility::waittill_multiple("main_stage1_over","main_stage2_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage3");
	level waittill("main_stage3_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage4");
	level waittill("main_stage4_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage5");
	level waittill("main_stage5_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage6");
	level waittill("main_stage6_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage7");
	level waittill("main_stage7_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage8");
	level waittill("main_stage8_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage9");
	level waittill("main_stage9_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage10");
	level waittill("main_stage10_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage11");
	level waittill("main_stage11_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage12");
	level waittill("main_stage12_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage13");
	level waittill("main_stage13_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage14");
	level waittill("main_stage14_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage15");
	level waittill("main_stage15_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage16");
	level waittill("main_stage16_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage17");
	level waittill("main_stage17_over");
}

//Function Number: 8
complete_sidequest()
{
}

//Function Number: 9
generic_stage_start()
{
	level._stage_active = 1;
}

//Function Number: 10
generic_stage_complete()
{
	level._stage_active = 0;
}

//Function Number: 11
onanyplayerspawned()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(isdefined(var_00) && isdefined(var_00.hasskilletgolden))
		{
			var_00 setclientomnvar("ui_zm_ee_int",4);
		}

		if(isdefined(var_00) && isdefined(var_00.hasskilletseasoned))
		{
			var_00 setclientomnvar("ui_zm_ee_int",2);
		}

		if(isdefined(var_00) && isdefined(var_00.hasmeat) && var_00.hasmeat)
		{
			var_00 setclientomnvar("ui_zm_ee_int",1);
		}

		if(isdefined(var_00) && isdefined(var_00.hasbun))
		{
			var_00 setclientomnvar("ui_zm_ee_int",11);
		}

		if(isdefined(var_00) && isdefined(var_00.hasburgerinfected))
		{
			var_00 setclientomnvar("ui_zm_ee_int",7);
			var_00 thread stage8_infected_burger();
		}

		if(isdefined(var_00) && isdefined(var_00.hasburger))
		{
			var_00 setclientomnvar("ui_zm_ee_int",8);
		}

		if(isdefined(var_00) && isdefined(var_00.hasbatterydepleted))
		{
			var_00 setclientomnvar("ui_zm_ee_int",10);
		}

		if(isdefined(var_00) && isdefined(var_00.hasbatterycharged))
		{
			var_00 setclientomnvar("ui_zm_ee_int",9);
		}

		if(isdefined(var_00) && isdefined(var_00.haskey))
		{
			var_00 setclientomnvar("ui_zm_ee_int",12);
		}

		if(isdefined(var_00) && isdefined(var_00.hasarm))
		{
			var_00 setclientomnvar("ui_zm_ee_int",3);
		}

		if(isdefined(var_00) && isdefined(var_00.hasdriveencrypted))
		{
			var_00 setclientomnvar("ui_zm_ee_int",5);
		}

		if(isdefined(var_00) && isdefined(var_00.hasdrivedecrypted))
		{
			var_00 setclientomnvar("ui_zm_ee_int",6);
		}
	}
}

//Function Number: 12
onplayerconnected()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 init_player_variables();
	}
}

//Function Number: 13
playertakeitemondisconnect()
{
	self waittill("disconnect");
	self setclientomnvar("ui_zm_ee_int",0);
}

//Function Number: 14
initvo()
{
	wait 0.05;
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","sq","sq","dlc2_easter",undefined);
	var_00 = spawn("script_model",(329,-4087,240));
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_beauford","beauford_",var_00,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford","machine_all_players","greeting","greeting",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford","machine_all_players","response","response",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford","machine_all_players","hit","hit",undefined,25);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford","machine_all_players","killzombie","killzombie",undefined,75);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford","machine_all_players","sq","sq",undefined);
}

//Function Number: 15
playerplaysqvo(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(maps\mp\zombies\_util::is_true(self.speaking))
	{
		self waittill("done_speaking");
	}

	thread maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq","sq",undefined,param_00);
}

//Function Number: 16
waittilldonespeaking(param_00)
{
	param_00 endon("disconnect");
	if(maps\mp\zombies\_util::is_true(param_00.isspeaking))
	{
		param_00 waittill("done_speaking");
	}
}

//Function Number: 17
playsqvowaittilldone(param_00,param_01,param_02)
{
	var_03 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(param_00);
	if(isdefined(var_03))
	{
		var_03 playerplaysqvo(param_01,0);
		wait 0.05;
		waittilldonespeaking(var_03);
		if(isdefined(param_02))
		{
			wait(param_02);
		}
	}
}

//Function Number: 18
playbeaufordsqvo(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
	var_03 = var_02[0];
	if(!isdefined(var_03))
	{
		return;
	}

	if(maps\mp\zombies\_util::is_true(var_03.speaking))
	{
		var_03 waittill("done_speaking");
	}

	var_03 thread maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players","sq",undefined,param_00);
}

//Function Number: 19
playbeaufordsqvowaitilldone(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
	var_03 = var_02[0];
	if(!isdefined(var_03))
	{
		return;
	}

	if(maps\mp\zombies\_util::is_true(var_03.speaking))
	{
		var_03 waittill("done_speaking");
	}

	if(var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players","sq",undefined,param_00))
	{
		var_03 waittill("done_speaking");
	}
}

//Function Number: 20
playbeaufordvo(param_00)
{
	var_01 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
	var_02 = var_01[0];
	if(!isdefined(var_02))
	{
		return;
	}

	return var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players",param_00);
}

//Function Number: 21
murderbot_animate(param_00)
{
	var_01 = getent("murderbot_animscripted","targetname");
	var_01 scriptmodelplayanim(param_00);
	var_01 playsound("sq_burger_offering");
}

//Function Number: 22
toilet_interact()
{
	level endon("game_ended");
	var_00 = common_scripts\utility::getstruct("toilet_use","targetname");
	for(;;)
	{
		var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("flushed",undefined,undefined,undefined,80);
		var_00 waittill("flushed",var_01);
		maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Toilet flushed!!");
		playsoundatpos(var_00.origin,"ee_toilet_flush");
		wait(3);
	}
}

//Function Number: 23
fingerprint_scanner_fail_fx()
{
	level endon("main_stage13_over");
	var_00 = common_scripts\utility::getstruct("warehouse_safe_use","targetname");
	var_01 = getent("fingerprint_scanner","targetname");
	for(;;)
	{
		wait(1);
		var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"main_stage13_over",80);
		var_00 waittill("activated",var_02);
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_fail"),var_01,"tag_origin");
		var_01 playsound("sq_safe_denied");
	}
}

//Function Number: 24
stage1_init()
{
}

//Function Number: 25
stage1_logic()
{
	var_00 = getent("golden_skillet_roof","targetname");
	var_01 = common_scripts\utility::getstruct("golden_skillet_roof_use","targetname");
	var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("grabbed",undefined,undefined,"main_stage1_over",100);
	var_01 waittill("grabbed",var_02);
	playsoundatpos(var_00.origin,"sq_skillet_grab");
	var_02 playerplaysqvo(14);
	var_00 delete();
	var_02 playergiveskillet("unseasoned");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage1");
}

//Function Number: 26
stage1_end(param_00)
{
	level.sidequeststarted = 1;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I got the skillet");
}

//Function Number: 27
playerhasskilletgolden()
{
	return maps\mp\zombies\_util::is_true(self.hasskilletgolden);
}

//Function Number: 28
playerhasskilletseasoned()
{
	return maps\mp\zombies\_util::is_true(self.hasskilletseasoned);
}

//Function Number: 29
playergiveskillet(param_00)
{
	switch(param_00)
	{
		case "unseasoned":
			self setclientomnvar("ui_zm_ee_int",4);
			self.hasskilletgolden = 1;
			break;

		case "seasoned":
			self setclientomnvar("ui_zm_ee_int",2);
			self.hasskilletseasoned = 1;
			break;
	}
}

//Function Number: 30
playertakeitem(param_00)
{
	switch(param_00)
	{
		case "skillet_golden":
			self.hasskilletgolden = undefined;
			break;

		case "skillet_seasoned":
			self.hasskilletseasoned = undefined;
			break;

		case "meat":
			self.hasmeat = 0;
			break;

		case "bun":
			self.hasbun = undefined;
			break;

		case "burger":
			self.hasburger = undefined;
			break;

		case "battery_depleted":
			self.hasbatterydepleted = undefined;
			break;

		case "battery_charged":
			self.hasbatterycharged = undefined;
			break;

		case "key":
			self.haskey = undefined;
			break;

		case "arm":
			self.hasarm = undefined;
			break;

		case "drive_encrypted":
			self.hasdriveencrypted = undefined;
			break;

		case "drive_decrypted":
			self.hasdrivedecrypted = undefined;
			break;
	}

	self setclientomnvar("ui_zm_ee_int",0);
}

//Function Number: 31
stage2_init()
{
	thread maps\mp\mp_zombie_brg::initgranulardoors("sewermain_to_sewercave",0.05);
}

//Function Number: 32
stage2_logic()
{
	level.sewer_cave_valve_count = 0;
	thread stage2_cave_valves();
	while(level.sewer_cave_valve_count < 4)
	{
		if(getdvarint("secret_cave_open") > 0)
		{
			break;
		}
		else
		{
			wait(0.5);
		}
	}

	level notify("sewer_cave_open");
	level thread stage2_open_door();
	common_scripts\utility::flag_set("sewermain_to_sewercave");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage2");
}

//Function Number: 33
stage2_open_door()
{
	level.zmbstage2dooropen = 1;
	var_00 = getentarray("sewers_waterfall","targetname");
	foreach(var_02 in var_00)
	{
		var_02 movez(-256,0.5);
		var_02 connectpaths();
	}

	var_04 = getentarray("secret_cave_door","targetname");
	foreach(var_02 in var_04)
	{
		var_02 movey(-128,3);
		var_02 connectpaths();
		playsoundatpos((3233,-2112,-329),"sq_door_stone_open");
	}
}

//Function Number: 34
stage2_cave_valves()
{
	var_00 = common_scripts\utility::getstructarray("cave_valve_loc","targetname");
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		var_02 = common_scripts\utility::random(var_00);
		var_00 = common_scripts\utility::array_remove(var_00,var_02);
		var_03 = spawn("script_model",var_02.origin);
		var_03 setmodel("det_basement_valve_01_anim");
		var_03.origin = var_02.origin;
		var_03.angles = var_02.angles;
		var_03.target = var_02.target;
		var_04 = 0;
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "downward_steam")
		{
			var_04 = 1;
		}

		var_03 thread stage2_cave_triggers(var_04);
	}
}

//Function Number: 35
stage2_cave_triggers(param_00)
{
	if(param_00 == 1)
	{
		var_01 = spawnfx(common_scripts\utility::getfx("steam_pipe_leak_interior_sm"),self.origin,(1,0,0),(0,1,0));
	}
	else
	{
		var_01 = spawnfx(common_scripts\utility::getfx("steam_pipe_leak_interior_sm"),self.origin,anglestoforward(self.angles + (0,-90,0)));
	}

	var_02 = common_scripts\utility::getstruct(self.target,"targetname");
	var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"main_stage2_over",100);
	var_02 waittill("activated",var_03);
	if(!isdefined(var_03.playedstage2vo))
	{
		var_03 thread playerplaysqvo(10,1);
		var_03.playedstage2vo = 1;
	}

	playsoundatpos(self.origin,"sq_sewer_valve_turn");
	self rotateroll(-270,2);
	wait(2);
	level.sewer_cave_valve_count++;
	triggerfx(var_01);
	self playloopsound("sq_sewer_valve_steam");
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I wonder what that did...");
	level waittill("sewer_cave_open");
	if(isdefined(var_03))
	{
		var_03 thread playerplaysqvo(11);
	}

	wait(5);
	self stoploopsound();
	var_01 delete();
	if(level.currentgen)
	{
		self delete();
	}
}

//Function Number: 36
stage2_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I feel a draft coming from somewhere");
}

//Function Number: 37
stage3_init()
{
	level.sacrificekillcount = 0;
}

//Function Number: 38
stage3_logic()
{
	level thread stage3_playerenter();
	var_00 = getent("golden_skillet_unseasoned","targetname");
	var_01 = common_scripts\utility::getstruct("skillet_unseasoned_use","targetname");
	var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed",::playerhasskilletgolden,undefined,"main_stage3_over",80);
	if(level.nextgen)
	{
		thread maps\mp\mp_zombie_brg::alterjumpexploit(var_01);
	}

	var_01 waittill("placed",var_02);
	var_00 playsoundonmovingent("sq_skillet_put_down_altar");
	var_02 playertakeitem("skillet_golden");
	var_00 show();
	var_03 = getent("golden_skillet_seasoned","targetname");
	var_04 = getent("skillet_altar","targetname");
	var_05 = getent("skillet_altar_coll","targetname");
	var_03 linkto(var_04);
	var_00 linkto(var_04);
	var_04 thread stage3_altar_move();
	var_05 thread stage3_altar_move();
	earthquake(0.15,3,var_04.origin,200);
	playrumbleonposition("artillery_rumble",var_04.origin);
	var_05 waittill("lowered");
	var_05 connectpaths();
	earthquake(0.15,3,var_04.origin,200);
	level.sacrificeactive = 1;
	thread stage3_sacrifice_setup();
	thread stage3_sacrifice_killcounter();
	level waittill("sq_raise_altar");
	earthquake(0.15,3,var_04.origin,200);
	playrumbleonposition("artillery_rumble",var_04.origin);
	level waittill("sq_altar_raised");
	earthquake(0.15,3,var_04.origin,200);
}

//Function Number: 39
stage3_playerenter()
{
	level endon("main_stage3_over");
	var_00 = getent("sacrifice_trigger","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(var_02 istouching(var_00))
			{
				var_02 thread playerplaysqvo(12);
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 40
stage3_altar_move()
{
	self movez(-32,3);
	self playsound("sq_alter_lower");
	playfx(common_scripts\utility::getfx("brg_altar_dust"),self.origin);
	wait(3);
	self notify("lowered");
	level waittill("sq_raise_altar");
	self movez(32,3);
	self playsound("sq_alter_raise");
	playfx(common_scripts\utility::getfx("brg_altar_dust"),self.origin);
	wait(3);
	level notify("sq_altar_raised");
}

//Function Number: 41
stage3_sacrifice_setup()
{
	level endon("main_stage3_over");
	var_00 = getent("sacrifice_trigger","targetname");
	var_01 = getent("blood_pool_mover","targetname");
	var_01 thread stage3_raise_blood();
	while(level.sacrificeactive == 1)
	{
		var_00 waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			continue;
		}
		else if(isdefined(var_02.agentteam) && var_02.agentteam == level.playerteam)
		{
			continue;
		}
		else if(!isdefined(var_02.alreadytriggered))
		{
			var_02 thread stage3_sacrifice_trigmonitor(var_00);
			var_02 thread stage3_sacrifice_killmonitor(var_01);
		}

		var_02.alreadytriggered = 1;
	}
}

//Function Number: 42
stage3_sacrifice_trigmonitor(param_00)
{
	self endon("death");
	level endon("main_stage3_over");
	while(self istouching(param_00))
	{
		wait(0.1);
	}

	self notify("ZombieLeftSacrificeArea");
	self.alreadytriggered = 0;
}

//Function Number: 43
stage3_sacrifice_killmonitor(param_00)
{
	self endon("ZombieLeftSacrificeArea");
	level endon("main_stage3_over");
	var_01 = common_scripts\utility::getstruct("skillet_glow_fx","targetname");
	if(!isdefined(self.alreadytriggered))
	{
		self.alreadytriggered = 0;
	}

	if(self.alreadytriggered == 0)
	{
		self waittill("death",var_02);
		if(level.sacrificekillcount < 66)
		{
			if(isdefined(var_02) && !isdefined(var_02.playedseasoningvo))
			{
				var_02 playerplaysqvo(15);
				var_02.playedseasoningvo = 1;
			}

			level.sacrificekillcount++;
			playfx(common_scripts\utility::getfx("brg_skillet_gleam"),var_01.origin);
			maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Number of Sacrifices:" + level.sacrificekillcount);
		}
	}
}

//Function Number: 44
stage3_raise_blood()
{
	level endon("main_stage3_over");
	var_00 = self.origin;
	for(;;)
	{
		wait(2);
		if(level.sacrificekillcount > 0 && level.sacrificekillcount < 66)
		{
			var_01 = level.sacrificekillcount * 2;
			self moveto(var_00 + (0,0,var_01),2);
		}
	}
}

//Function Number: 45
stage3_sacrifice_killcounter()
{
	while(level.sacrificekillcount < 66)
	{
		wait(0.1);
	}

	level.sacrificeactive = 0;
	var_00 = getent("golden_skillet_unseasoned","targetname");
	var_01 = getent("golden_skillet_seasoned","targetname");
	var_00 delete();
	var_01 show();
	level notify("sq_raise_altar");
	level waittill("sq_altar_raised");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage3");
}

//Function Number: 46
stage3_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Ritual complete. The skillet is properly seasoned");
}

//Function Number: 47
stage4_init()
{
}

//Function Number: 48
stage4_logic()
{
	var_00 = getent("golden_skillet_seasoned","targetname");
	var_01 = common_scripts\utility::getstruct("skillet_unseasoned_use","targetname");
	var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage4_over",80);
	var_01 waittill("acquired",var_02);
	playsoundatpos(var_00.origin,"sq_skillet_grab");
	var_00 hide();
	var_02 playergiveskillet("seasoned");
	var_03 = getent("golden_skillet_stove","targetname");
	var_04 = common_scripts\utility::getstruct("burgertown_stove_interact","targetname");
	var_04 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed",::playerhasskilletseasoned,undefined,"main_stage4_over");
	var_04 waittill("placed",var_02);
	var_03 show();
	var_03 playsoundonmovingent("sq_skillet_put_down_stove");
	var_02 playertakeitem("skillet_seasoned");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage4");
}

//Function Number: 49
stage4_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Put down the skillet");
}

//Function Number: 50
stage5_init()
{
}

//Function Number: 51
randomizemeatchunks()
{
	stage5_initrandommeatchunks(getentarray("zombie_meat_chunk_gs","targetname"));
	stage5_initrandommeatchunks(getentarray("zombie_meat_chunk_ac","targetname"));
	stage5_initrandommeatchunks(getentarray("zombie_meat_chunk_sw","targetname"));
	stage5_initrandommeatchunks(getentarray("zombie_meat_chunk_bt","targetname"));
}

//Function Number: 52
stage5_initrandommeatchunks(param_00)
{
	var_01 = common_scripts\utility::random(param_00);
	param_00 = common_scripts\utility::array_remove(param_00,var_01);
	foreach(var_03 in param_00)
	{
		var_03 delete();
	}
}

//Function Number: 53
stage5_logic()
{
	var_00 = getent("zombie_meat_chunk_gs","targetname");
	if(isdefined(var_00))
	{
		var_00 thread stage5_meat_handler();
	}

	var_01 = getent("zombie_meat_chunk_ac","targetname");
	if(isdefined(var_01))
	{
		var_01 thread stage5_meat_handler();
	}

	var_02 = getent("zombie_meat_chunk_sw","targetname");
	if(isdefined(var_02))
	{
		var_02 thread stage5_meat_handler();
	}

	var_03 = getent("zombie_meat_chunk_bt","targetname");
	if(isdefined(var_03))
	{
		var_03 thread stage5_meat_handler();
	}

	var_04 = common_scripts\utility::getstruct("burgertown_stove_interact","targetname");
	var_04 thread stage5_stove_handler();
}

//Function Number: 54
stage5_meat_handler()
{
	level endon("main_stage5_over");
	self show();
	var_00 = spawnfx(common_scripts\utility::getfx("insects_flies_landing"),self.origin);
	triggerfx(var_00);
	var_01 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",::playerhasnomeat,undefined,"main_stage5_over",80);
	var_01 waittill("acquired",var_02);
	if(!isdefined(var_02.playedpickupmeat))
	{
		var_02 thread playerplaysqvo(1,0.5);
		var_02.playedpickupmeat = 1;
	}

	var_02 playergivemeat();
	playsoundatpos(self.origin,"sq_pick_up_meat");
	self delete();
	var_00 delete();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("This looks tasty. Just need a place to cook it.");
}

//Function Number: 55
playerhasmeat()
{
	return maps\mp\zombies\_util::is_true(self.hasmeat);
}

//Function Number: 56
playerhasnomeat()
{
	return maps\mp\zombies\_util::is_true(!self.hasmeat);
}

//Function Number: 57
playergivemeat()
{
	self setclientomnvar("ui_zm_ee_int",1);
	self.hasmeat = 1;
}

//Function Number: 58
stage5_stove_handler()
{
	level endon("main_stage5_over");
	var_00 = getentarray("placed_zombie_meat_chunks","targetname");
	var_01 = undefined;
	while(var_00.size > 0)
	{
		thread maps\mp\zombies\_zombies_sidequests::fake_use("used",::playerhasmeat,undefined,"main_stage5_over");
		self waittill("used",var_01);
		var_02 = common_scripts\utility::random(var_00);
		var_02 show();
		playfx(common_scripts\utility::getfx("dlc_zombie_blood_splat_sm"),var_02.origin);
		playsoundatpos(var_02.origin,"sq_place_meat");
		var_00 = common_scripts\utility::array_remove(var_00,var_02);
		var_01 thread playertakeitem("meat");
		if(!isdefined(var_01.playedstovemeat))
		{
			var_01 thread playerplaysqvo(2,0.5);
			var_01.playedstovemeat = 1;
		}

		maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Hmm...gonna need more meat than this");
	}

	if(isdefined(var_01))
	{
		var_01 thread playerplaysqvo(6,1);
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage5");
}

//Function Number: 59
stage5_end(param_00)
{
	var_04 = getentarray("placed_zombie_meat_chunks","targetname");
	foreach(var_06 in var_04)
	{
		var_06 delete();
	}

	var_08 = getent("zombie_patty_raw","targetname");
	var_08 show();
	playfx(common_scripts\utility::getfx("dlc_zombie_blood_splat_sm"),var_08.origin);
	playsoundatpos(var_08.origin,"sq_meat_patty");
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Looks like we need something to cook it with");
}

//Function Number: 60
stage6_init()
{
}

//Function Number: 61
stage6_logic()
{
	var_00 = getent("zombie_patty_raw","targetname");
	level waittill("burger_patty_cooked",var_01);
	if(isdefined(var_01))
	{
		var_01 thread playerplaysqvo(7,0.5);
	}

	var_00 thread stage6_cookedpattyfx();
	playsoundatpos(var_00.origin,"sq_patty_finished");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage6");
}

//Function Number: 62
stage6_cookedpattyfx()
{
	var_00 = spawnfx(common_scripts\utility::getfx("brg_skillet_charbroil"),self.origin);
	triggerfx(var_00);
	self playloopsound("sq_meat_patty_cook");
	self waittill("kill_cooked_fx");
	var_00 delete();
}

//Function Number: 63
stage6_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("It\'s cooked to perfection! Now all we need is a bun...");
}

//Function Number: 64
stage7_init()
{
	level.processenemykilledfunc = ::processenemykilled;
	level.sq_droppedbuns = [];
	level.pickedupbun = 0;
}

//Function Number: 65
stage7_logic()
{
	while(level.pickedupbun == 0)
	{
		wait(0.05);
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage7");
}

//Function Number: 66
playerhasbun()
{
	return maps\mp\zombies\_util::is_true(self.hasbun);
}

//Function Number: 67
playergivebun()
{
	self setclientomnvar("ui_zm_ee_int",11);
	self.hasbun = 1;
}

//Function Number: 68
processenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("main_stage7_over");
	if(level.pickedupbun == 1)
	{
		return;
	}

	if(!isdefined(self.burgertownemployee) || !self.burgertownemployee)
	{
		return;
	}

	if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self))
	{
		return;
	}

	if(isdefined(param_03) && param_03 == "MOD_SUICIDE")
	{
		return;
	}

	if(maps\mp\zombies\_util::istrapweapon(param_04))
	{
		return;
	}

	if(level.sq_droppedbuns.size >= 1)
	{
		return;
	}

	var_09 = randomfloat(1);
	if(var_09 < 0.25)
	{
		level thread dropbun(self.origin);
	}
}

//Function Number: 69
dropbun(param_00)
{
	level endon("main_stage7_over");
	param_00 = param_00 + (0,0,16);
	var_01 = spawn("script_model",param_00);
	var_01.angles = (0,0,0);
	var_01 setmodel("dlc2_brg_bun");
	var_01 notsolid();
	var_02 = spawn("trigger_radius",param_00,0,32,32);
	var_01.trigger = var_02;
	level.sq_droppedbuns[level.sq_droppedbuns.size] = var_01;
	var_01 thread bunpickup();
	var_01 thread buntimer();
	var_01 thread bunbounce();
}

//Function Number: 70
bunbounce()
{
	self scriptmodelplayanimdeltamotion("mp_dogtag_spin");
}

//Function Number: 71
bunpickup()
{
	self endon("deleted");
	level endon("main_stage7_over");
	var_00 = self.origin;
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(isplayer(var_01) && !var_01 playerhasbun())
		{
			var_01 playergivebun();
			var_01 playlocalsound("sq_bun_pickup");
			level.pickedupbun = 1;
			thread removebun(self);
			return;
		}
	}
}

//Function Number: 72
buntimer()
{
	self endon("deleted");
	wait(15);
	thread bunstartflashing();
	wait(8);
	level thread removebun(self);
}

//Function Number: 73
bunstartflashing()
{
	self endon("deleted");
	level endon("main_stage7_over");
	for(;;)
	{
		self ghost();
		wait(0.25);
		self show();
		wait(0.25);
	}
}

//Function Number: 74
removebun(param_00,param_01)
{
	param_00 notify("deleted");
	wait 0.05;
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
	if(!maps\mp\zombies\_util::is_true(param_01))
	{
		level.sq_droppedbuns = common_scripts\utility::array_removeundefined(level.sq_droppedbuns);
	}
}

//Function Number: 75
stage7_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I\'ve got the bun.");
}

//Function Number: 76
stage8_init()
{
}

//Function Number: 77
playergiveburgerinfected()
{
	self setclientomnvar("ui_zm_ee_int",7);
	self.hasburgerinfected = 1;
	thread playerplaysqvo(8,0.5);
}

//Function Number: 78
stage8_logic()
{
	var_00 = getent("zombie_patty_raw","targetname");
	var_01 = getent("zombie_burger","targetname");
	var_02 = common_scripts\utility::getstruct("burgertown_stove_interact","targetname");
	var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("assembled",::playerhasbun,undefined,"main_stage8_over");
	var_02 waittill("assembled",var_03);
	var_03 thread playertakeitem("bun");
	var_00 notify("kill_cooked_fx");
	var_00 stoploopsound();
	var_00 delete();
	var_01 show();
	var_01 playsound("sq_burger_created");
	var_04 = spawnfx(common_scripts\utility::getfx("brg_infected_burger"),var_01.origin);
	triggerfx(var_04);
	wait(1);
	var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage8_over");
	var_02 waittill("acquired",var_03);
	playsoundatpos(var_01.origin,"sq_burger_pickup");
	var_04 delete();
	var_01 delete();
	var_03 playergiveburgerinfected();
	var_03 thread stage8_infected_burger();
}

//Function Number: 79
stage8_infected_burger()
{
	thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
	self waittill("cured");
	thread playergiveburger();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage8");
}

//Function Number: 80
stage8_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Cured from infected burger");
}

//Function Number: 81
stage9_init()
{
}

//Function Number: 82
playergiveburger()
{
	self setclientomnvar("ui_zm_ee_int",8);
	self.hasburger = 1;
	self.hasburgerinfected = undefined;
	thread playerplaysqvo(9,1);
}

//Function Number: 83
playerhasburger()
{
	return maps\mp\zombies\_util::is_true(self.hasburger);
}

//Function Number: 84
stage9_logic()
{
	var_00 = getent("murderbot_static_thumbsup","targetname");
	var_01 = getent("murderbot_animscripted","targetname");
	level.zmbsqbeaufordnoresponse = 1;
	var_02 = common_scripts\utility::getstruct("murderbot_use","targetname");
	var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("feed",::playerhasburger,undefined,"main_stage9_over",80);
	var_02 waittill("feed",var_03);
	var_00 delete();
	var_01 show();
	thread murderbot_animate("zom_mbot_activation_yumm");
	var_03 playertakeitem("burger");
	playsoundatpos((325,-4086,209),"zmb_murderbot_bellyrub");
	level thread beaufordburgerbatteryhint();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage9");
}

//Function Number: 85
beaufordburgerbatteryhint()
{
	playbeaufordsqvo(4,0.5);
	var_00 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
	var_01 = var_00[0];
	if(!isdefined(var_01))
	{
		return;
	}

	var_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
	var_02 = 2;
	if(common_scripts\utility::cointoss())
	{
		var_02 = 3;
	}

	playbeaufordsqvo(var_02);
	wait(2);
	level.zmbsqbeaufordnoresponse = undefined;
}

//Function Number: 86
stage9_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Beauford enjoyed your offering!");
	var_04 = getent("battery_screen_on","targetname");
	var_04 playloopsound("sq_screen_on_lp");
	var_05 = getent("battery_screen_off","targetname");
	var_05 hide();
	var_04 show();
	var_04 playsound("sq_screen_on");
}

//Function Number: 87
stage10_init()
{
	level.batteryacquired = 0;
	var_00 = common_scripts\utility::getstruct("battery_pickup_use","targetname");
	var_00 thread stage10_battery_pickup();
}

//Function Number: 88
batterydooropen()
{
	return maps\mp\zombies\_util::is_true(self.batteryisopen);
}

//Function Number: 89
playerhasbatteryempty()
{
	return maps\mp\zombies\_util::is_true(self.hasbatterydepleted);
}

//Function Number: 90
playerhasbatteryfull()
{
	return maps\mp\zombies\_util::is_true(self.hasbatterycharged);
}

//Function Number: 91
playergivebattery(param_00)
{
	switch(param_00)
	{
		case "depleted":
			self setclientomnvar("ui_zm_ee_int",10);
			self.hasbatterydepleted = 1;
			thread playerplaysqvo(16,0.5);
			break;

		case "charged":
			self setclientomnvar("ui_zm_ee_int",9);
			self.hasbatterycharged = 1;
			thread playerplaysqvo(17,0.5);
			break;
	}
}

//Function Number: 92
stage10_logic()
{
	var_00 = common_scripts\utility::getstruct("battery_compartment_activate","targetname");
	var_01 = getent("battery_door","targetname");
	while(level.batteryacquired == 0)
	{
		if(getdvarint("battery_open") == 0)
		{
			var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened",undefined,undefined,"main_stage10_over",80);
			var_00 waittill("opened",var_02);
			var_02 thread playbatterysounds(var_01);
			foreach(var_02 in level.players)
			{
				var_02.batteryisopen = 1;
			}

			var_01 movez(12,0.25);
			wait(7);
			var_01 movez(-12,0.25);
			var_01 playsound("sq_battery_door_close");
			wait(0.25);
			foreach(var_02 in level.players)
			{
				var_02.batteryisopen = 0;
			}

			continue;
		}

		wait(3);
		var_01 movez(12,0.25);
		wait(7);
		var_01 movez(-12,0.25);
	}
}

//Function Number: 93
playbatterysounds(param_00)
{
	self playlocalsound("sq_screen_interact");
	wait(1.3);
	param_00 playsound("sq_battery_door_open");
}

//Function Number: 94
stage10_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got battery");
}

//Function Number: 95
stage10_battery_pickup()
{
	var_00 = getent("battery_depleted","targetname");
	thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",::batterydooropen,undefined,"main_stage10_over");
	self waittill("acquired",var_01);
	var_00 playsound("sq_battery_grab");
	var_00 delete();
	level.batteryacquired = 1;
	var_01 thread playergivebattery("depleted");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage10");
}

//Function Number: 96
stage11_init()
{
	createthreatbiasgroup("charging_battery");
	level.batterychargecount = 0;
}

//Function Number: 97
stage11_logic()
{
	var_00 = getent("battery_charging","targetname");
	var_01 = getent("battery_charged","targetname");
	var_02 = getent("battery_charge_fxorg","targetname");
	var_00.charged = 0;
	var_00 thread stage11_battery_fx(var_02);
	var_03 = common_scripts\utility::getstruct("battery_charge_use","targetname");
	var_03 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed",::playerhasbatteryempty,undefined,"main_stage11_over");
	var_03 waittill("placed",var_04);
	var_00 playsound("sq_battery_plugin");
	var_04 thread playertakeitem("battery_depleted");
	var_00 thread stage11_battery_setup();
	var_00 thread stage11_battery_charge_counter();
}

//Function Number: 98
stage11_battery_setup()
{
	self show();
	self.charging = 1;
	self notify("charging");
	self makeentitysentient("allies");
	self setthreatbiasgroup("charging_battery");
	setthreatbias("zombies","charging_battery",1000);
	self playloopsound("sq_battery_charge");
	thread maps\mp\gametypes\_damage::setentitydamagecallback(100000,undefined,::stage11_onbatterydeath);
	thread stage11_monitor_battery_damage();
	thread stage11_knockout_battery();
	thread stage11_battery_charge_monitor();
	thread stage11_swap_batteries();
}

//Function Number: 99
stage11_monitor_battery_damage()
{
	level endon("main_stage11_over");
	self endon("death");
	for(;;)
	{
		if(self.damagetaken < 200)
		{
			wait(0.5);
			continue;
		}
		else
		{
			self notify("removed");
			self.charging = 0;
			maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Battery down!!");
			self waittill("charging");
		}

		wait(0.5);
	}
}

//Function Number: 100
stage11_knockout_battery()
{
	level endon("main_stage11_over");
	self endon("charged");
	var_00 = getent("battery_removed","targetname");
	var_01 = common_scripts\utility::getstruct("battery_replace_use","targetname");
	for(;;)
	{
		self waittill("removed");
		var_02 = spawnfx(common_scripts\utility::getfx("spark_burst_runner_brg"),var_00.origin);
		triggerfx(var_02);
		self stoploopsound();
		self freeentitysentient();
		self.damagetaken = 0;
		stage11_battery_move(var_00);
		var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("replaced",undefined,undefined,"main_stage11_over");
		var_01 waittill("replaced",var_03);
		var_02 delete();
		var_00 hide();
		self show();
		self makeentitysentient("allies");
		self setthreatbiasgroup("charging_battery");
		self.charging = 1;
		self notify("charging");
		self playloopsound("sq_battery_charge");
	}
}

//Function Number: 101
stage11_battery_move(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles;
	self moveto(param_00.origin,0.35);
	self rotateto(param_00.angles,0.35);
	wait(0.35);
	self hide();
	param_00 show();
	self.origin = var_01;
	self.angles = var_02;
}

//Function Number: 102
stage11_battery_fx(param_00)
{
	level endon("game_ended");
	for(var_01 = spawnfx(common_scripts\utility::getfx("dlc_elec_panel_charging"),param_00.origin,anglestoforward(param_00.angles + (0,0,0)),anglestoup(param_00.angles + (0,0,90)));self.charged == 0;var_01 delete())
	{
		self waittill("charging");
		if(!isdefined(var_01))
		{
			var_01 = spawnfx(common_scripts\utility::getfx("dlc_elec_panel_charging"),param_00.origin,anglestoforward(param_00.angles + (0,0,0)),anglestoup(param_00.angles + (0,0,90)));
		}

		triggerfx(var_01);
		common_scripts\utility::waittill_any("removed","charged");
	}

	var_02 = spawnfx(common_scripts\utility::getfx("dlc_elec_panel_charge_full"),param_00.origin,anglestoforward(param_00.angles + (0,0,0)),anglestoup(param_00.angles + (0,0,90)));
	triggerfx(var_02);
}

//Function Number: 103
stage11_battery_charge_monitor()
{
	while(level.batterychargecount < 60)
	{
		wait(0.5);
	}

	self notify("charged");
	self.charged = 1;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Battery is fully charged!");
}

//Function Number: 104
stage11_battery_charge_counter()
{
	self endon("charged");
	for(;;)
	{
		if(self.charging == 1)
		{
			wait(1);
			level.batterychargecount++;
			continue;
		}

		self waittill("charging");
	}
}

//Function Number: 105
stage11_swap_batteries()
{
	var_00 = getent("battery_charging","targetname");
	var_01 = getent("battery_charged","targetname");
	var_02 = common_scripts\utility::getstruct("battery_charge_use","targetname");
	self waittill("charged");
	self stoploopsound();
	var_00 delete();
	var_01 show();
	var_01 playsound("sq_battery_charged");
	var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage11_over");
	var_02 waittill("acquired",var_03);
	var_01 playsound("sq_battery_grab");
	var_03 thread playergivebattery("charged");
	var_01 delete();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage11");
}

//Function Number: 106
stage11_onbatterydeath(param_00,param_01,param_02,param_03)
{
	self notify("damaged",param_00,param_02,param_01);
}

//Function Number: 107
stage11_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got charged battery");
}

//Function Number: 108
stage12_init()
{
	thread burger_room_escape();
}

//Function Number: 109
playerhaskey()
{
	return maps\mp\zombies\_util::is_true(self.haskey);
}

//Function Number: 110
playergivekey()
{
	self setclientomnvar("ui_zm_ee_int",12);
	self.haskey = 1;
	playerplaysqvo(13,1);
}

//Function Number: 111
stage12_logic()
{
	level.zmbsqbeaufordnoresponse = 1;
	var_00 = common_scripts\utility::getstruct("murderbot_use","targetname");
	var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("offered",undefined,undefined,"main_stage12_over",80);
	var_00 waittill("offered",var_01);
	var_01 playlocalsound("sq_battery_grab");
	var_01 thread playertakeitem("battery_charged");
	thread murderbot_animate("zom_mbot_activation_key");
	playsoundatpos((325,-4086,209),"zmb_murderbot_give_key");
	thread stage12_spawn_key();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Beauford is energized!");
	level thread playbeaufordsqvo(5);
	var_02 = common_scripts\utility::getstruct("burger_tower_use","targetname");
	var_02 thread stage12_tower_access();
}

//Function Number: 112
stage12_spawn_key()
{
	var_00 = common_scripts\utility::getstruct("burgerkey_use","targetname");
	var_01 = getent("burger_tower_key","targetname");
	wait(1.5);
	var_01 show();
	var_01 scriptmodelplayanimdeltamotion("mp_dogtag_spin");
	var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage12_over",80);
	var_00 waittill("acquired",var_02);
	var_01 playsound("sq_key_receive");
	var_01 delete();
	var_02 thread playergivekey();
	level notify("player_has_key");
	wait(4);
	level.zmbsqbeaufordnoresponse = undefined;
}

//Function Number: 113
stage12_tower_access()
{
	var_00 = common_scripts\utility::getstructarray("burger_tower_destination","targetname");
	var_01 = common_scripts\utility::getstruct("drive_decrypted_use","targetname");
	var_02 = getent("burger_screen_disabled","targetname");
	var_03 = getent("burger_screen_decrypt","targetname");
	thread maps\mp\zombies\_zombies_sidequests::fake_use("unlocked",::playerhaskey,undefined,"main_stage12_over",100);
	self waittill("unlocked",var_04);
	level.burgerhatchlocked = 0;
	var_04 playlocalsound("sq_burger_door_opened_2D");
	playsoundatpos((1135,-3494,494),"sq_burger_door_opened");
	var_04 playertakeitem("key");
	var_05 = common_scripts\utility::random(var_00);
	var_04 thread burger_teleport(var_05.origin,var_05.angles);
	level notify("burger_is_occupied");
	level.burgerhatchlocked = 1;
	thread burger_room_valve_lock("locked");
	var_04 playerhide();
	var_04 thread burger_room_monitor();
	level thread burger_room_free_access();
	var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"main_stage12_over",80);
	var_01 waittill("activated",var_04);
	var_03 hide();
	var_02 show();
	var_02 playsound("screen_negative_interact");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage12");
}

//Function Number: 114
burger_room_valve_lock(param_00)
{
	var_01 = getent("burger_tower_valve","targetname");
	var_01.islocked = 1;
	switch(param_00)
	{
		case "locked":
			level.burgerislocked = 1;
			var_01 rotateto((0,-90,90),0.2);
			break;

		case "unlocked":
			level.burgerislocked = 0;
			var_01 rotateto((0,0,90),0.2);
			break;
	}
}

//Function Number: 115
burger_room_locked_audio()
{
	level endon("game_ended");
	var_00 = common_scripts\utility::getstruct("burger_tower_lock_use","targetname");
	for(;;)
	{
		var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("used",undefined,undefined,undefined,80);
		var_00 waittill("used",var_01);
		if(level.burgerhatchlocked == 1)
		{
			var_01 playlocalsound("sq_burger_door_locked");
		}

		wait(1);
	}
}

//Function Number: 116
burger_room_free_access()
{
	level endon("close_burger_for_rocket");
	if(isdefined(level.zmbsqburgerroomopen))
	{
		return;
	}

	level.zmbsqburgerroomopen = 1;
	var_00 = common_scripts\utility::getstructarray("burger_tower_destination","targetname");
	var_01 = common_scripts\utility::getstruct("burger_tower_use","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	for(;;)
	{
		level waittill("burger_is_empty");
		if(isdefined(level.burgerislocked) && !level.burgerislocked)
		{
			thread burger_room_valve_lock("locked");
		}

		level.burgerhatchlocked = 1;
		wait(10);
		level.burgerhatchlocked = 0;
		var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened",undefined,undefined,undefined,100);
		if(isdefined(level.burgerislocked) && level.burgerislocked)
		{
			thread burger_room_valve_lock("unlocked");
		}

		var_01 waittill("opened",var_02);
		var_03 = common_scripts\utility::random(var_00);
		var_02 thread burger_teleport(var_03.origin,var_03.angles);
		level notify("burger_is_occupied");
		level.burgerhatchlocked = 1;
		var_02 thread burger_room_monitor();
		if(isdefined(level.burgerislocked) && !level.burgerislocked)
		{
			thread burger_room_valve_lock("locked");
		}

		var_02 maps\mp\zombies\_util::setallignoreme(1);
		var_02 playerhide();
		var_02 playlocalsound("sq_burger_door_opened_2D");
		playsoundatpos((1135,-3494,494),"sq_burger_door_opened");
	}
}

//Function Number: 117
burger_room_lockdown()
{
	var_00 = common_scripts\utility::getstructarray("burger_tower_exit","targetname");
	var_01 = getent("burger_tower_vol","targetname");
	wait(2);
	level notify("close_burger_for_rocket");
	if(isdefined(level.burgerislocked) && !level.burgerislocked)
	{
		thread burger_room_valve_lock("locked");
	}

	level.burgerhatchlocked = 1;
	foreach(var_03 in level.players)
	{
		if(var_03 istouching(var_01))
		{
			var_04 = common_scripts\utility::random(var_00);
			var_03 thread burger_teleport(var_04.origin,var_04.angles);
			var_03 maps\mp\zombies\_util::setallignoreme(0);
			var_03 playershow();
			level notify("burger_is_empty");
		}
	}

	level waittill("drive_is_decrypted");
	level.zmbsqburgerroomopen = undefined;
	level thread burger_room_free_access();
	wait 0.05;
	level notify("burger_is_empty");
}

//Function Number: 118
burger_room_monitor()
{
	var_00 = common_scripts\utility::getstructarray("burger_tower_exit","targetname");
	var_01 = getent("burger_tower_vol","targetname");
	var_02 = gettime() + 20000;
	while(gettime() < var_02)
	{
		wait(0.2);
		if(self istouching(var_01))
		{
			continue;
		}
		else
		{
			return;
		}
	}

	foreach(var_04 in level.players)
	{
		if(var_04 istouching(var_01))
		{
			var_05 = common_scripts\utility::random(var_00);
			var_04 thread burger_teleport(var_05.origin,var_05.angles);
			var_04 maps\mp\zombies\_util::setallignoreme(0);
			var_04 playershow();
			level notify("burger_is_empty");
		}
	}
}

//Function Number: 119
burger_room_escape()
{
	var_00 = common_scripts\utility::getstructarray("burger_tower_exit","targetname");
	var_01 = common_scripts\utility::getstruct("burger_tower_escape_use","targetname");
	for(;;)
	{
		var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("used",undefined,undefined,undefined,80);
		var_01 waittill("used",var_02);
		var_03 = common_scripts\utility::random(var_00);
		var_02 thread burger_teleport(var_03.origin,var_03.angles);
		var_02 maps\mp\zombies\_util::setallignoreme(0);
		var_02 playershow();
		level notify("burger_is_empty");
		var_02 playlocalsound("sq_burger_door_closed_2D");
	}
}

//Function Number: 120
burger_teleport(param_00,param_01)
{
	thread maps\mp\zombies\_teleport::player_teleport(param_00,param_01);
}

//Function Number: 121
stage12_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Finished burger room");
}

//Function Number: 122
stage13_init()
{
	level.gator_kills_active = 1;
}

//Function Number: 123
playerhasarm()
{
	return maps\mp\zombies\_util::is_true(self.hasarm);
}

//Function Number: 124
playergivearm()
{
	self setclientomnvar("ui_zm_ee_int",3);
	self.hasarm = 1;
	thread playerplaysqvo(19,0.5);
}

//Function Number: 125
stage13_logic()
{
	var_00 = common_scripts\utility::getstruct("warehouse_safe_use","targetname");
	for(;;)
	{
		var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened",undefined,undefined,"main_stage13_over");
		var_00 waittill("opened",var_01);
		playsoundatpos(var_00.origin,"ui_button_error");
		if(!isdefined(var_01.playedseveredhandhint))
		{
			var_01 playerplaysqvo(18);
			var_01.playedseveredhandhint = 1;
		}

		wait(1);
	}
}

//Function Number: 126
stage13_spawn_arm()
{
	level notify("arm_spawned");
	level.sqarmspawned = 1;
	var_00 = common_scripts\utility::getstruct("gator_water_level","script_noteworthy");
	var_01 = var_00.origin[2] - self.origin[2];
	var_02 = spawn("script_model",self.origin + (0,0,var_01));
	var_02 setmodel("dlc2_zom_gib_arm_pickup");
	var_02 scriptmodelplayanimdeltamotion("mp_dogtag_spin");
	var_03 = spawn("script_origin",var_02.origin);
	var_03 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage13_over",100);
	var_03 waittill("acquired",var_04);
	var_04 thread playergivearm();
	playsoundatpos(var_02.origin,"sq_severedhand_grab");
	var_02 delete();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage13");
}

//Function Number: 127
stage13_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got severed arm");
	level.gator_kills_active = 0;
}

//Function Number: 128
stage14_init()
{
}

//Function Number: 129
playerhasdriveencrypted()
{
	return maps\mp\zombies\_util::is_true(self.hasdriveencrypted);
}

//Function Number: 130
playergivedriveencrypted()
{
	self setclientomnvar("ui_zm_ee_int",5);
	self.hasdriveencrypted = 1;
	var_00 = 20;
	if(maps\mp\zombies\_util::get_player_index(self) == maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix("it"))
	{
		if(randomint(100) < 10)
		{
			var_00 = 23;
		}
	}

	thread playerplaysqvo(var_00,0.5);
}

//Function Number: 131
stage14_logic()
{
	var_00 = getent("safe_door_org","targetname");
	var_01 = getentarray("warehouse_safe_door","targetname");
	var_02 = getent("thumb_drive_encrypted","targetname");
	var_03 = getent("fingerprint_scanner","targetname");
	foreach(var_05 in var_01)
	{
		var_05 vehicle_jetbikesethoverforcescale(var_00);
	}

	var_07 = common_scripts\utility::getstruct("warehouse_safe_use","targetname");
	var_07 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened",::playerhasarm,undefined,"main_stage14_over",80);
	var_07 waittill("opened",var_08);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_pass"),var_03,"tag_origin");
	var_08 playertakeitem("arm");
	var_00 rotateyaw(-125,1);
	var_00 playsound("sq_safe_door_open");
	var_09 = common_scripts\utility::getstruct("thumb_drive_use","targetname");
	var_09 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage14_over",80);
	var_09 waittill("acquired",var_08);
	var_02 playsound("sq_drive_grab");
	var_02 delete();
	var_08 thread playergivedriveencrypted();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage14");
}

//Function Number: 132
stage14_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Took encrypted thumb drive");
}

//Function Number: 133
stage15_init()
{
}

//Function Number: 134
stage15_logic()
{
	var_00 = getent("thumb_drive_decrypting","targetname");
	var_01 = getent("burger_screen_decrypt","targetname");
	var_02 = getent("burger_screen_disabled","targetname");
	var_03 = common_scripts\utility::getstruct("drive_decrypted_use","targetname");
	var_03 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed",::playerhasdriveencrypted,undefined,"main_stage15_over",80);
	var_03 waittill("placed",var_04);
	var_00 show();
	var_02 delete();
	var_01 show();
	var_04 playertakeitem("drive_encrypted");
	thread drive_decrypt_audio(var_00,var_01);
	level thread stage15_decryptiontimer();
	thread burger_firing_event();
	thread burger_room_lockdown();
	level waittill("drive_is_decrypted");
	var_01 stoploopsound();
	var_01 playsound("sq_drive_finished");
}

//Function Number: 135
drive_decrypt_audio(param_00,param_01)
{
	param_00 playsound("sq_drive_plugin");
	wait(0.2);
	param_01 playloopsound("sq_drive_decrypt");
}

//Function Number: 136
stage15_decryptiontimer()
{
	wait(30);
	foreach(var_01 in level.players)
	{
		var_01 thread rocket_countdowntimer();
	}

	level waittill("rocket_countdown_complete");
	level notify("drive_is_decrypted");
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Drive is Decrypted!!");
	thread burger_rocket_launch();
}

//Function Number: 137
rocket_countdowntimer()
{
	self endon("disconnect");
	var_00 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,0);
	var_00 thread update_countdown();
	var_00.fontscale = 2;
	level waittill("rocket_countdown_complete");
	var_00 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 138
update_countdown()
{
	self endon("disconnect");
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		var_01 = undefined;
		switch(5 - var_00)
		{
			case 5:
				var_01 = &"ZOMBIE_CIVILIANS_5";
				break;

			case 4:
				var_01 = &"ZOMBIE_CIVILIANS_4";
				break;

			case 3:
				var_01 = &"ZOMBIE_CIVILIANS_3";
				break;

			case 2:
				var_01 = &"ZOMBIE_CIVILIANS_2";
				break;

			case 1:
				var_01 = &"ZOMBIE_CIVILIANS_1";
				break;
		}

		self settext(var_01);
		playsoundatpos((0,0,0),"zmb_weapon_upgrade_countdown");
		wait(1);
	}

	level notify("rocket_countdown_complete");
}

//Function Number: 139
burger_rocket_launch()
{
	var_00 = getent("burger_rocket_org","targetname");
	var_01 = getent("burger_rocket_dest","targetname");
	var_02 = getent("burger_rocket","targetname");
	var_03 = getent("burger_rocket_fins","targetname");
	var_04 = getentarray("burger_rocket_static","targetname");
	var_00 thread rocket_attach(var_02,var_03);
	var_00 thread rocket_thruster_fx();
	var_00 thread rocket_move();
	var_04 thread rocket_static_hide();
	playrumblelooponposition("artillery_rumble",var_00.origin);
	earthquake(0.5,8,var_00.origin,1500);
	playsoundatpos((1217,-3418,459),"sq_rocket_screen_shake_front");
	wait(8);
	stopallrumbles();
	var_00 waittill("finished");
}

//Function Number: 140
rocket_attach(param_00,param_01)
{
	param_00 vehicle_jetbikesethoverforcescale(self);
	if(level.nextgen)
	{
		param_01 vehicle_jetbikesethoverforcescale(self);
		wait(2);
		param_01 show();
	}

	self waittill("finished");
	param_00 delete();
	if(level.nextgen)
	{
		param_01 delete();
	}

	self delete();
}

//Function Number: 141
rocket_thruster_fx()
{
	var_00 = getent("burger_rocket_fx","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("dlc2_brg_burger_bomb");
	var_01 vehicle_jetbikesethoverforcescale(self);
	var_02 = spawnlinkedfx(common_scripts\utility::getfx("brg_rocket_thruster"),var_01,"tag_fx");
	wait(2);
	triggerfx(var_02);
	playsoundatpos((1217,-3418,459),"sq_rocket_launch");
	self waittill("finished");
	var_02 delete();
	var_01 delete();
}

//Function Number: 142
rocket_move()
{
	self movez(11744,20,4);
	wait(20);
	self notify("finished");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage15");
}

//Function Number: 143
rocket_static_hide()
{
	foreach(var_01 in self)
	{
		var_01 notsolid();
		var_01 delete();
	}

	if(level.nextgen)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2200,-4840,444),(90,0,0));
	}
}

//Function Number: 144
burger_firing_event()
{
	bombs_init();
	var_00 = level.bombsonstandby.size;
	level.bomb_targets = common_scripts\utility::array_randomize(level.bomb_targets);
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		if(isdefined(level.bombsonstandby[0]))
		{
			level.bombsonstandby[0] bomb_fires(var_01);
			wait(4);
		}
	}

	wait(1);
}

//Function Number: 145
bombs_init()
{
	wait(1);
	level.bombsonstandby = [];
	level.launch_point = common_scripts\utility::getstruct("org_bomb_launch","targetname");
	level.bomb_targets = common_scripts\utility::getstructarray("org_bomb_targets","targetname");
	level.bomb_count_max = 12;
	level.bomb_count_min = 2;
	for(var_00 = 0;var_00 < level.bomb_count_max;var_00++)
	{
		var_01 = spawn("script_model",(0,0,-10));
		var_01 setmodel("dlc2_brg_burger_bomb");
		var_01 thread bomb_physics_impact_watch();
		var_02 = 24;
		var_03 = getent("bomb_pickup_" + var_00 + 1,"targetname");
		if(isdefined(var_03))
		{
			var_03.origin = var_01.origin;
		}
		else
		{
			var_03 = spawn("trigger_radius",var_01.origin - (0,0,var_02 / 2),0,var_02,var_02);
		}

		var_03 enablelinkto();
		var_03 linkto(var_01);
		var_03.no_moving_platfrom_unlink = 1;
		var_04 = [var_01];
		var_05 = maps\mp\gametypes\_gameobjects::createcarryobject("any",var_03,var_04,(0,0,32));
		var_05 maps\mp\gametypes\_gameobjects::allowcarry("any");
		var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_05.objidpingenemy = 1;
		var_05.objpingdelay = 1;
		var_05.allowweapons = 0;
		var_05.carryweapon = "iw5_dlc2burgergun_mp";
		var_05.keepcarryweapon = 1;
		var_05.waterbadtrigger = 0;
		var_05.visualgroundoffset = (0,0,30);
		var_05.canuseobject = ::bomb_can_pickup;
		var_05.onpickup = ::bomb_on_pickup;
		var_05.setdropped = ::bomb_set_dropped;
		var_05.carryweaponthink = ::bomb_throw;
		var_05.requireslos = 1;
		maps\mp\_utility::_objective_delete(var_05.objidallies);
		maps\mp\_utility::_objective_delete(var_05.objidaxis);
		maps\mp\_utility::_objective_delete(var_05.objidmlgspectator);
		var_05.compassicons = undefined;
		var_05.objidallies = undefined;
		var_05.objidaxis = undefined;
		var_05.objidmlgspectator = undefined;
		level.bombsonstandby[level.bombsonstandby.size] = var_05;
		wait 0.05;
	}
}

//Function Number: 146
bomb_fires(param_00)
{
	var_01 = level.bomb_targets[param_00];
	var_02 = self.visuals[0];
	var_02 show();
	var_02 dontinterpolate();
	self.bomb_fx_active = 0;
	var_02 physicsstop();
	var_02.origin = level.launch_point.origin;
	level.mines[level.mines.size] = var_02;
	var_03 = var_01.origin + (randomfloatrange(-10,10),randomfloatrange(-10,10),randomfloatrange(-10,10));
	var_01.origin = (var_01.origin[0],var_01.origin[1],var_02.origin[2] + 600);
	var_04 = vectornormalize(var_01.origin - var_02.origin) * randomintrange(200,300);
	var_05 = (0,0,0);
	var_02 physicslaunchserver(var_02.origin + var_05,var_04);
	aud_event_fire_bomb();
	thread bomb_fuse_default();
	level.bombsonstandby = common_scripts\utility::array_remove(level.bombsonstandby,self);
	bomb_fx_start();
	playfx(common_scripts\utility::getfx("cannon_firing"),level.launch_point.origin + (0,0,35));
	var_06 = anglestoforward(level.launch_point.origin);
	var_07 = anglestoup(level.launch_point.origin);
}

//Function Number: 147
bomb_fuse_default()
{
	self endon("stop_fuse");
	self endon("pickup_object");
	var_00 = 30;
	var_01 = self.visuals[0];
	playfxontag(common_scripts\utility::getfx("burger_bomb_fuse"),var_01,"tag_fx");
	while(var_00 > 0)
	{
		if(isdefined(self) && var_00 < 4)
		{
			playfx(common_scripts\utility::getfx("ball_flash"),self.visuals[0].origin);
		}

		wait(1);
		var_00 = var_00 - 1;
	}

	magicgrenademanual("iw5_dlc2burgerbomb_mp",self.visuals[0].origin,(0,0,0),0);
	thread bomb_cleanup();
}

//Function Number: 148
bomb_fuse_short()
{
	self endon("stop_fuse");
	self endon("pickup_object");
	for(var_00 = 3;var_00 > 0;var_00 = var_00 - 1)
	{
		if(isdefined(self) && var_00 < 4)
		{
			playfx(common_scripts\utility::getfx("ball_flash"),self.visuals[0].origin);
		}

		wait(1);
	}

	magicgrenademanual("iw5_dlc2burgerbomb_mp",self.visuals[0].origin,(0,0,0),0);
	thread bomb_cleanup();
}

//Function Number: 149
bomb_can_pickup(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		return 0;
	}

	if(isdefined(self.droptime) && self.droptime >= gettime())
	{
		return 0;
	}

	if(!param_00 common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	if(param_00 isusingturret())
	{
		return 0;
	}

	if(isdefined(param_00.manuallyjoiningkillstreak) && param_00.manuallyjoiningkillstreak)
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(isdefined(var_01))
	{
		if(!valid_bomb_pickup_weapon(var_01))
		{
			return 0;
		}
	}

	var_02 = param_00.changingweapon;
	if(isdefined(var_02) && param_00 isreloading())
	{
		if(!valid_bomb_pickup_weapon(var_02))
		{
			return 0;
		}
	}

	if(isdefined(param_00.exo_shield_on) && param_00.exo_shield_on == 1)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isbot(param_00) || isagent(param_00))
	{
		return 0;
	}

	if(param_00 player_no_pickup_time())
	{
		return 0;
	}

	return 1;
}

//Function Number: 150
valid_bomb_pickup_weapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(param_00 == "iw5_dlc2burgergun_mp")
	{
		return 0;
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return 0;
	}

	if(param_00 == "iw5_combatknifegoliath_mp")
	{
		return 0;
	}

	return 1;
}

//Function Number: 151
player_no_pickup_time()
{
	return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

//Function Number: 152
bomb_on_pickup(param_00)
{
	level.usestartspawns = 0;
	self notify("pickup_object");
	level.mines = common_scripts\utility::array_remove(level.mines,self.visuals[0]);
	var_01 = self.visuals[0] getlinkedparent();
	if(isdefined(var_01))
	{
		self.visuals[0] unlink();
	}

	self.visuals[0] physicsstop();
	self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
	self.visuals[0] show();
	self.visuals[0] ghost();
	self.trigger maps\mp\_movers::stop_handling_moving_platforms();
	bomb_fx_stop();
	param_00 setweaponammoclip("iw5_dlc2burgergun_mp",1);
	param_00 maps\mp\_utility::giveperk("specialty_ballcarrier",0);
	param_00 thread display_bomb_prompt();
	thread bomb_last_stand(param_00);
	thread bomb_infected(param_00);
	param_00.hasbomb = 1;
	param_00 common_scripts\utility::_disableusability();
}

//Function Number: 153
display_bomb_prompt()
{
	var_00 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,145);
	var_00 settext(&"ZOMBIE_BRG_BOMB_THROW");
	var_00.fontscale = 0.65;
	common_scripts\utility::waittill_any("weapon_fired","drop_object","begin_last_stand","player_infected");
	self.hasbomb = 0;
	var_00 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 154
bomb_last_stand(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("drop_object");
	param_00 endon("weapon_fired");
	param_00 waittill("enter_last_stand");
	param_00 thread bomb_player_revived();
	thread bomb_carrier_cleanup();
	maps\mp\gametypes\_gameobjects::clearcarrier();
}

//Function Number: 155
bomb_player_revived()
{
	self waittill("revive");
	var_00 = self getweaponslistprimaries();
	self switchtoweaponimmediate(var_00[0]);
}

//Function Number: 156
bomb_infected(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("weapon_fired");
	param_00 waittill("player_infected");
	thread bomb_carrier_cleanup();
	maps\mp\gametypes\_gameobjects::clearcarrier();
}

//Function Number: 157
bomb_throw()
{
	self endon("disconnect");
	thread bomb_throw_watch();
	self.carryobject waittill("dropped");
}

//Function Number: 158
bomb_throw_watch()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	var_00 = getdvarfloat("scr_ball_shoot_extra_pitch",-12);
	var_01 = getdvarfloat("scr_ball_shoot_force",320);
	for(;;)
	{
		self waittill("weapon_fired",var_02);
		if(var_02 != "iw5_dlc2burgergun_mp")
		{
			continue;
		}

		break;
	}

	if(isdefined(self.carryobject))
	{
		var_03 = self getplayerangles();
		var_03 = var_03 + (var_00,0,0);
		var_03 = (clamp(var_03[0],-85,85),var_03[1],var_03[2]);
		var_04 = anglestoforward(var_03);
		thread bomb_throw_active();
		wait(0.25);
		self playsound("mp_ul_ball_throw");
		self.carryobject bomb_create_killcam_ent();
		self.carryobject thread bomb_physics_launch_drop(var_04 * var_01,self);
	}
}

//Function Number: 159
bomb_physics_impact_watch()
{
	self endon("death");
	for(;;)
	{
		self waittill("physics_impact",var_00,var_01,var_02,var_03);
		var_04 = level._effect["ball_physics_impact"];
		if(isdefined(var_03) && isdefined(level._effect["ball_physics_impact_" + var_03]))
		{
			var_04 = level._effect["ball_physics_impact_" + var_03];
		}

		playfx(var_04,var_00,var_01);
		wait(0.3);
	}
}

//Function Number: 160
bomb_throw_active()
{
	self endon("death");
	self endon("disconnect");
	self.pass_or_throw_active = 1;
	self allowmelee(0);
	while("iw5_dlc2burgergun_mp" == self getcurrentweapon())
	{
		wait 0.05;
	}

	self allowmelee(1);
	self.pass_or_throw_active = 0;
}

//Function Number: 161
bomb_physics_launch_drop(param_00,param_01)
{
	bomb_carrier_cleanup();
	self.ownerteam = "any";
	maps\mp\gametypes\_gameobjects::clearcarrier();
	bomb_physics_launch(param_00,param_01);
}

//Function Number: 162
bomb_physics_launch(param_00,param_01)
{
	var_02 = self.visuals[0];
	var_02.origin_prev = undefined;
	bomb_cleanup();
	var_03 = anglestoforward(param_01 getplayerangles()) * 940 + anglestoup(param_01 getplayerangles()) * 120;
	var_04 = param_01 geteye();
	var_05 = magicgrenademanual("iw5_dlc2burgerbomb_mp",var_04,var_03,2,param_01);
}

//Function Number: 163
bomb_create_killcam_ent()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	self.killcament = spawn("script_model",self.visuals[0].origin);
	self.killcament linkto(self.visuals[0]);
	self.killcament setcontents(0);
	self.killcament setscriptmoverkillcam("explosive");
}

//Function Number: 164
bomb_set_dropped(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self.isresetting = 1;
	self.droptime = gettime();
	self notify("dropped");
	var_01 = self.carrier;
	if(isdefined(var_01) && var_01.team != "spectator")
	{
		var_02 = var_01.origin;
	}
	else
	{
		var_02 = self.safeorigin;
	}

	var_03 = self.visuals[0];
	var_03.origin = var_02;
	var_03 show();
	var_03 physicslaunchserver(var_03.origin + (0,1,0));
	level.mines[level.mines.size] = var_03;
	thread bomb_fuse_short();
	bomb_carrier_cleanup();
	bomb_fx_start();
	self.ownerteam = "any";
	maps\mp\gametypes\_gameobjects::clearcarrier();
	return 1;
}

//Function Number: 165
bomb_carrier_cleanup()
{
	if(isdefined(self.carrier))
	{
		self.carrier.nopickuptime = gettime() + 500;
		self.carrier maps\mp\_utility::_unsetperk("specialty_ballcarrier");
		self.carrier common_scripts\utility::_enableusability();
	}
}

//Function Number: 166
bomb_dont_interpolate()
{
	self.visuals[0] dontinterpolate();
	self.bomb_fx_active = 0;
}

//Function Number: 167
bomb_cleanup()
{
	self notify("stop_fuse");
	bomb_fx_stop();
	self.visuals[0] dontinterpolate();
	self.bomb_fx_active = 0;
	self.visuals[0] physicsstop();
	self.visuals[0].origin = (0,0,0);
	level.mines = common_scripts\utility::array_remove(level.mines,self.visuals[0]);
	foreach(var_01 in self.visuals)
	{
		var_01 delete();
	}

	self.trigger delete();
}

//Function Number: 168
bomb_fx_start()
{
	if(!bomb_fx_active())
	{
		var_00 = self.visuals[0];
		playfxontag(common_scripts\utility::getfx("dlc_burger_bomb_trail"),var_00,"body_animate_jnt");
		playfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"body_animate_jnt");
		var_00 hudoutlineenable(0,0);
		self.bomb_fx_active = 1;
	}
}

//Function Number: 169
bomb_fx_stop()
{
	if(bomb_fx_active())
	{
		var_00 = self.visuals[0];
		stopfxontag(common_scripts\utility::getfx("dlc_burger_bomb_trail"),var_00,"body_animate_jnt");
		killfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"body_animate_jnt");
		killfxontag(common_scripts\utility::getfx("burger_bomb_fuse"),var_00,"tag_fx");
		var_00 hudoutlinedisable();
		var_00 stopsounds();
	}

	self.bomb_fx_active = 0;
}

//Function Number: 170
bomb_fx_active()
{
	return isdefined(self.bomb_fx_active) && self.bomb_fx_active;
}

//Function Number: 171
aud_play_bomb_bounce()
{
	if(isdefined(self))
	{
		maps\mp\_audio::snd_play_in_space("wpn_clown_bomb_bounce",self.origin);
	}
}

//Function Number: 172
aud_event_fire_bomb()
{
	maps\mp\_audio::snd_play_in_space("ct3_cannon_shot",level.launch_point.origin);
}

//Function Number: 173
stage15_end(param_00)
{
	level thread playbeaufordsqvo(6,3);
}

//Function Number: 174
stage16_init()
{
	var_00 = getent("thumb_drive_decrypted","targetname");
	var_01 = getent("thumb_drive_decrypting","targetname");
	var_01 delete();
	var_00 show();
}

//Function Number: 175
playerhasdrivedecrypted()
{
	return maps\mp\zombies\_util::is_true(self.hasdrivedecrypted);
}

//Function Number: 176
playergivedrivedecrypted()
{
	self setclientomnvar("ui_zm_ee_int",6);
	self.hasdrivedecrypted = 1;
	thread playerplaysqvo(21,0.5);
}

//Function Number: 177
stage16_logic()
{
	var_00 = getent("thumb_drive_decrypted","targetname");
	var_01 = common_scripts\utility::getstruct("drive_decrypted_use","targetname");
	var_01 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired",undefined,undefined,"main_stage16_over",80);
	var_01 waittill("acquired",var_02);
	var_00 playsound("sq_drive_grab");
	var_00 delete();
	var_02 thread playergivedrivedecrypted();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage16");
}

//Function Number: 178
stage16_end(param_00)
{
}

//Function Number: 179
stage17_init()
{
}

//Function Number: 180
stage17_logic()
{
	level.zmbsqbeaufordnoresponse = 1;
	var_00 = common_scripts\utility::getstruct("murderbot_use","targetname");
	var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playerhasdrivedecrypted,undefined,"main_stage17_over",80);
	var_00 waittill("activated",var_01);
	var_01 playertakeitem("drive_decrypted");
	playsoundatpos(var_00.origin,"sq_drive_grab");
	spawn_murderbot(var_01);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage17");
}

//Function Number: 181
stage17_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Beauford is loose!!");
	maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_MEATISMURDER");
	set_side_quest_coop_data_burgertown();
}

//Function Number: 182
set_side_quest_coop_data_burgertown()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_02 = var_01 getcoopplayerdatareservedint("eggData");
		var_02 = var_02 | 4;
		var_01.sidequest = 1;
		var_01 setcoopplayerdatareservedint("eggData",var_02);
		setmatchdata("players",var_01.clientid,"startPrestige",var_01.sidequest);
	}
}

//Function Number: 183
murderbot_test_setup()
{
	var_00 = common_scripts\utility::getstruct("murderbot_use","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"main_stage1_over");
		var_00 waittill("activated",var_01);
		if(getdvarint("scr_zombieSidequestDebug",0) == 1 && level.sidequeststarted == 0 && !isdefined(level.zmbsqmurderbotstarted) || !level.zmbsqmurderbotstarted)
		{
			spawn_murderbot(var_01);
		}

		wait(1);
	}
}

//Function Number: 184
beauford_greetings()
{
	level endon("main_stage16_over");
	while(!isdefined(level.players))
	{
		wait 0.05;
	}

	var_00 = 10000;
	var_01 = common_scripts\utility::getstruct("murderbot_use","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	for(;;)
	{
		if(maps\mp\zombies\_util::is_true(level.zmbsqbeaufordnoresponse))
		{
			wait 0.05;
			continue;
		}

		foreach(var_03 in level.players)
		{
			var_04 = distancesquared(var_03.origin,var_01.origin);
			if(var_04 < var_00)
			{
				playbeaufordvo("greeting");
				wait(30);
			}
		}

		wait 0.05;
	}
}

//Function Number: 185
playercanhearbeaufordresponse()
{
	return !playerhasburger() && !playerhasbatteryfull() && !playerhasdriveencrypted() && !playerhasdrivedecrypted() && !maps\mp\zombies\_util::is_true(level.zmbsqbeaufordnoresponse);
}

//Function Number: 186
beauford_interact()
{
	level endon("main_stage16_over");
	var_00 = common_scripts\utility::getstruct("murderbot_use","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playercanhearbeaufordresponse,undefined,"main_stage16_over");
		var_00 waittill("activated",var_01);
		playbeaufordvo("response");
		wait(20);
	}
}

//Function Number: 187
beauford_hit()
{
	level endon("main_stage16_over");
	var_00 = getent("murderbot_static_thumbsup","targetname");
	var_00.health = 99999;
	var_00.maxhealth = 99999;
	var_00 setcandamage(1);
	var_00 setdamagecallbackon(1);
	var_00.damagecallback = ::_beauford_hit_internal;
	level.zmbsqbeaufordnexthitvo = 0;
}

//Function Number: 188
_beauford_hit_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(gettime() > level.zmbsqbeaufordnexthitvo && !maps\mp\zombies\_util::is_true(level.zmbsqbeaufordnoresponse))
	{
		if(playbeaufordvo("hit"))
		{
			level.zmbsqbeaufordnexthitvo = gettime() + 20000;
		}
	}
}

//Function Number: 189
beauford_kills()
{
	wait 0.05;
	var_00 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
	var_01 = var_00[0];
	if(!isdefined(var_01))
	{
		return;
	}

	level waittill("beauford_spawned",var_02);
	var_02 endon("death");
	for(;;)
	{
		level waittill("zombie_damaged",var_03,var_04);
		if(isdefined(var_04) && var_04 == var_02)
		{
			playbeaufordvo("killzombie");
			wait(3);
		}
	}
}

//Function Number: 190
spawn_murderbot(param_00)
{
	level.zmbsqmurderbotstarted = 1;
	var_01 = getent("murderbot_animscripted","targetname");
	var_02 = getent("speaker_box","targetname");
	var_03 = getentarray("speaker_box_coll","targetname");
	var_04 = getent("bubby_clip","targetname");
	var_04 notsolid();
	var_04 delete();
	foreach(var_06 in var_03)
	{
		var_06 notsolid();
		var_06 delete();
	}

	var_08 = common_scripts\utility::getstruct("murderbot_start","script_noteworthy");
	var_09 = maps\mp\zombies\zombie_murderbot::spawnmurderbot(var_08,var_01,var_02);
	level notify("beauford_spawned",var_09);
	var_0A = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
	var_0B = var_0A[0];
	if(isdefined(var_0B))
	{
		var_0B linkto(var_09,"j_head",(0,0,0),(0,0,0));
	}

	level thread spawn_murderbot_vo(param_00);
}

//Function Number: 191
spawn_murderbot_vo(param_00)
{
	wait 0.05;
	playbeaufordsqvowaitilldone(1,0.5);
	wait(0.5);
	if(isdefined(param_00))
	{
		param_00 thread playerplaysqvo(22,0.5);
	}
}

//Function Number: 192
init_song_sidequest()
{
	level.sq_song_ent = getent("sq_song","targetname");
	if(!isdefined(level.sq_song_ent))
	{
		level.sq_song_ent = spawn("script_model",(0,0,0));
	}
}

//Function Number: 193
sidequest_logic_song()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage1");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage2");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage3");
	var_03 = 0;
	for(;;)
	{
		var_04 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over","song_stage2_over","song_stage3_over");
		var_03++;
		if(var_03 < 3)
		{
			thread song_play(var_03);
			continue;
		}

		thread song_play();
		break;
	}
}

//Function Number: 194
song_play(param_00)
{
	level notify("sq_song_play");
	level endon("sq_song_play");
	level endon("sq_song_stop");
	if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing))
	{
		level.sq_song_ent stopsounds();
		level.sq_song_ent.playing = 0;
		wait(0.2);
	}

	var_01 = "zmb_mus_ee_02";
	if(!isdefined(param_00) || param_00 <= 0)
	{
		param_00 = musiclength("zmb_mus_ee_02");
	}
	else
	{
		var_01 = "zmb_mus_ee_02_prvw";
	}

	level.sq_song_ent playsoundonmovingent(var_01);
	level.sq_song_ent.playing = 1;
	wait(param_00);
	level.sq_song_ent scalevolume(0,0.2);
	wait(0.2);
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
	level.sq_song_ent scalevolume(1);
}

//Function Number: 195
song_stop()
{
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
	level notify("sq_song_stop");
}

//Function Number: 196
song_fake_use(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.origin = param_00;
	var_03 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"song_stage" + param_01 + "_over",param_02);
	var_03 waittill("activated",var_04);
	return var_04;
}

//Function Number: 197
songstage1_init()
{
}

//Function Number: 198
songstage1_logic()
{
	var_00 = common_scripts\utility::getstruct("song_use_1","targetname");
	var_01 = song_fake_use(var_00.origin,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage1");
}

//Function Number: 199
songstage1_end(param_00)
{
}

//Function Number: 200
songstage2_init()
{
}

//Function Number: 201
songstage2_logic()
{
	var_00 = common_scripts\utility::getstruct("song_use_2","targetname");
	var_01 = song_fake_use(var_00.origin,2);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage2");
}

//Function Number: 202
songstage2_end(param_00)
{
}

//Function Number: 203
songstage3_init()
{
}

//Function Number: 204
songstage3_logic()
{
	var_00 = common_scripts\utility::getstruct("song_use_3","targetname");
	var_01 = song_fake_use(var_00.origin,3);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage3");
}

//Function Number: 205
songstage3_end(param_00)
{
}

//Function Number: 206
musiclength(param_00)
{
	var_01 = tablelookup(level.zmbsoundlengthpath,0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return 2;
	}

	var_01 = int(var_01);
	var_01 = var_01 * 0.001;
	return var_01;
}