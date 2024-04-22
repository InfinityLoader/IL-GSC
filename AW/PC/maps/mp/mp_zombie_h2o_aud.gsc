/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_h2o_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 574 ms
 * Timestamp: 4/22/2024 2:19:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.customzombiemusicstates = ::customzombiemusicstates;
	thread onplayerconnectedaudio();
	thread h2o_lobby_music();
}

//Function Number: 2
onplayerconnectedaudio()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 clientaddsoundsubmix("master_mix");
	}
}

//Function Number: 3
h2o_lobby_music()
{
	wait(10);
	for(;;)
	{
		playsoundatpos((-1021,1613,206),"h2o_lobby_music_loc1");
		playsoundatpos((1008,2095,243),"h2o_lobby_music_loc2");
		wait(50);
	}
}

//Function Number: 4
customzombiemusicstates()
{
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(0,"round_start_hard_mode","zmb_mus_nightmare_01",0,0,0.5,0);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_boss_oz_stage1",["zmb_mus_bossfight_01"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_boss_oz_stage2",["zmb_mus_bossfight_02"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"ee_bus_end",["zmb_mus_postround"],0,1,1,0);
}

//Function Number: 5
sndbossozstartstage1()
{
	foreach(var_01 in level.players)
	{
		var_01 clientaddsoundsubmix("boss_oz");
	}

	level waittill("teleport_players_back");
	foreach(var_01 in level.players)
	{
		var_01 clientclearsoundsubmix("boss_oz");
	}
}

//Function Number: 6
sndbossozstartstage2()
{
	foreach(var_01 in level.players)
	{
		var_01 clientaddsoundsubmix("boss_oz_2");
	}

	level waittill("boss_oz_killed");
	foreach(var_01 in level.players)
	{
		var_01 clientclearsoundsubmix("boss_oz_2");
	}
}

//Function Number: 7
sndbossozfire(param_00)
{
	var_01 = spawn("script_origin",param_00);
	var_01 playloopsound("boss_fire_large");
}

//Function Number: 8
sndtubestart(param_00,param_01)
{
	param_01 playlocalsound("evt_transit_tube_plr");
	var_02 = spawn("script_origin",param_00.origin);
	var_02 playsoundtoteam("evt_transit_tube_start_npc","allies",param_01);
	wait(4);
	var_02 delete();
}

//Function Number: 9
sndtubeend(param_00,param_01)
{
	var_02 = spawn("script_origin",param_00);
	wait(0.5);
	var_02 playsoundtoteam("evt_transit_tube_stop_npc","allies",param_01);
	wait(4);
	var_02 delete();
}

//Function Number: 10
sndvalvelight(param_00)
{
	var_01 = param_00 + (0,0,20);
	playsoundatpos(var_01,"ee_marker_light_off");
	var_02 = spawn("script_origin",var_01);
	var_02 playloopsound("ee_lightbulb_buzz_int_lp");
}

//Function Number: 11
sndcomputerloop()
{
	var_00 = spawn("script_origin",(-1781,5415,448));
	var_00 playloopsound("ee_computer_loop");
}

//Function Number: 12
sndcomputeracknowledge(param_00)
{
	playsoundatpos(param_00,"ee_pad_activated");
}

//Function Number: 13
sndcomputerfail(param_00)
{
	playsoundatpos(param_00,"ee_computer_negative");
}

//Function Number: 14
snddepressurizeloopstart(param_00)
{
	param_00 endon("depressurize_cancelled");
	playsoundatpos(param_00.origin,"ee_depressurize_start");
	wait(1);
	param_00 playloopsound("ee_depressurize_loop");
}

//Function Number: 15
snddepressurizeloopend(param_00)
{
	param_00 notify("depressurize_cancelled");
	param_00 stoploopsound("ee_depressurize_loop");
	playsoundatpos(param_00.origin,"ee_depressurize_loop_end");
}

//Function Number: 16
snddepressurizecomplete(param_00)
{
	playsoundatpos(param_00.origin,"ee_depressurize_loop_end");
	playsoundatpos(param_00.origin,"ee_depressurize_end");
}

//Function Number: 17
sndairlockdoorinteract(param_00)
{
	playsoundatpos(param_00,"ee_door_locked");
}

//Function Number: 18
sndfillwithwater()
{
	wait(0.5);
	playsoundatpos((2435,2183,86),"ee_depressurize_room_fill");
}

//Function Number: 19
snddrainwater()
{
	wait(0.65);
	playsoundatpos((2435,2183,86),"ee_depressurize_room_drain");
}

//Function Number: 20
sndunderwaterenter(param_00)
{
	param_00 setclienttriggeraudiozonelerp("underwater","underwater",0);
	param_00 playlocalsound("ee_underwater_enter");
}

//Function Number: 21
sndunderwaterexit(param_00)
{
	if(isalive(param_00))
	{
		param_00 playlocalsound("ee_underwater_exit");
	}

	param_00 clearclienttriggeraudiozone(0);
}

//Function Number: 22
sndunderwaterpanelaccessed(param_00)
{
	playsoundatpos(param_00,"ee_underwater_panel");
}

//Function Number: 23
sndbouncingenergypuzzlesuccess(param_00)
{
	playsoundatpos(param_00,"sentry_explode");
}

//Function Number: 24
sndcapacitorcoverblownoff(param_00)
{
	playsoundatpos(param_00,"ee_capacitor_cover_blown");
}

//Function Number: 25
sndcapacitorcharging(param_00)
{
	wait(0.3);
	playsoundatpos((-796,2631,-64),"ee_capacitor_charging_" + param_00);
}

//Function Number: 26
sndcapacitorchargedsuccess(param_00)
{
	playsoundatpos(param_00.origin,"ee_capacitor_charged");
	wait(1.5);
	thread common_scripts\utility::play_loopsound_in_space("ee_capacitor_electricity_loop",param_00.origin);
}

//Function Number: 27
sndjumpingpuzzlesucess(param_00)
{
	wait(0.5);
	param_00 playlocalsound("ee_step_success");
}

//Function Number: 28
sndjumpingpuzzleplatformlock(param_00)
{
	playsoundatpos(param_00,"ee_jumping_platform_lock");
}

//Function Number: 29
sndjumpingpuzzleplatformwhoosh()
{
	playsoundatpos((-1203,75,842),"ee_jumping_platform_whoosh");
}

//Function Number: 30
sndjumpingpuzzleplayerwhoosh()
{
	self playsoundtoplayer("ee_jumping_platform_player_whoosh",self);
}

//Function Number: 31
sndlightpuzzle(param_00,param_01)
{
	playsoundatpos(param_00,param_01);
}

//Function Number: 32
sndlightpuzzlefail()
{
	playsoundatpos((617,367,290),"ee_puzzle_beep_fail");
}

//Function Number: 33
sndlightpuzzlesuccess()
{
	playsoundatpos((617,367,290),"ee_puzzle_beep_success");
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("ee_step_success");
	}
}

//Function Number: 34
sndcounterdigitflip(param_00)
{
	playsoundatpos(param_00,"ee_counter_flip");
}

//Function Number: 35
sndcounterdigitsuccess()
{
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("ee_step_success");
	}
}

//Function Number: 36
sndusememorymachine(param_00)
{
	playsoundatpos(param_00.origin,"ee_computer_use");
	maps\mp\zombies\_zombies_music::disablemusicstatechanges();
}

//Function Number: 37
sndteleporttobuszone()
{
	self endon("disconnect");
	self setclienttriggeraudiozonelerp("mp_zombie_h2o_bus_sequence","mp_zombie_h2o_bus_sequence",0);
	level waittill("sq_teleport_players_back");
	self clearclienttriggeraudiozone();
}

//Function Number: 38
sndbusmusic()
{
	var_00 = spawn("script_origin",(0,0,0));
	level waittill("sq_player_teleport_to_bus_zone");
	wait(0.5);
	var_00 playloopsound("zmb_mus_memory_bus");
	level waittill("sq_teleport_players_back");
	maps\mp\zombies\_zombies_music::enablemusicstatechanges();
	wait(5.7);
	maps\mp\zombies\_zombies_music::changezombiemusic("ee_bus_end");
	var_00 scalevolume(0,2);
	wait(2.3);
	var_00 delete();
}