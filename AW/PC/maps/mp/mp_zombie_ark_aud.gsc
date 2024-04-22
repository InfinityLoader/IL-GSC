/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_ark_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 725 ms
 * Timestamp: 4/22/2024 2:18:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread onplayerconnectedaudio();
	level.radioalive = 1;
	level.radioent1 = spawn("script_origin",(21316,853,742));
	level.radioent2 = spawn("script_origin",(21316,853,742));
	level.radioent3 = spawn("script_origin",(21316,853,742));
	level.radioent4 = spawn("script_origin",(21316,853,742));
	level.radioent5 = spawn("script_origin",(21316,853,742));
	level.radiostate = 1;
	thread radioswitchinit();
	level.customzombiemusicstates = ::customzombiemusicstates;
	level.aud_drunk_ent = spawn("script_origin",(0,0,0));
	level.aud_cage_playing = 0;
	level.aud_plinko_moving = 0;
	level.aud_play_stop_sound = 0;
	level.aud_plinko_ent = spawn("script_origin",(-128,803,1149));
	level.aud_plinko_gate_last_loc = 0;
	level.aud_plinko_machine_activated = 0;
}

//Function Number: 2
onplayerconnectedaudio()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 clientaddsoundsubmix("master_mix");
		var_00 clientaddsoundsubmix("mute_security");
	}
}

//Function Number: 3
customzombiemusicstates()
{
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_normal",["zmb_mus_wave_07_lp","zmb_mus_wave_08_lp","zmb_mus_wave_05_lp","zmb_mus_wave_06_lp"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_dog",["zmb_mus_spec_02_lp","zmb_mus_wave_06_lp","zmb_mus_wave_04_lp"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_host",["zmb_mus_spec_02_lp","zmb_mus_wave_06_lp","zmb_mus_wave_04_lp"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(2,"round_intermission",["zmb_mus_postround","zmb_mus_postround_02","zmb_mus_postround_03","zmb_mus_postround_04"],0,1,1,0);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(0,"victory","zmb_mus_victory",0,0,0,0);
}

//Function Number: 4
grenade_in_hopper()
{
	level.aud_plinko_machine_activated = 1;
	playsoundatpos((-130,803,1157),"plinko_gren_in_hopper");
}

//Function Number: 5
gate_moving(param_00,param_01)
{
	if(param_00 < 0.2)
	{
		return;
	}

	if(param_00 < 1)
	{
		if(abs(level.aud_plinko_gate_last_loc - param_01) > 30)
		{
			playsoundatpos((-128,803,1149),"plinko_hopper_move_start_fast");
			level.aud_play_stop_sound = 1;
		}
		else
		{
			playsoundatpos((-128,803,1149),"plinko_hopper_move_start");
		}

		level.aud_plinko_moving = 1;
		level.aud_plinko_ent playloopsound("plinko_hopper_move");
		level.aud_plinko_gate_last_loc = param_01;
		return;
	}

	if(level.aud_plinko_moving == 0)
	{
		level.aud_plinko_moving = 1;
		level.aud_play_stop_sound = 1;
		playsoundatpos((-128,803,1149),"plinko_hopper_move_start");
		if(level.aud_plinko_machine_activated)
		{
			level.aud_plinko_ent playloopsound("plinko_hopper_move");
			return;
		}

		return;
	}
}

//Function Number: 6
gate_stopped()
{
	self endon("gates_moved");
	wait(0.1);
	if(level.aud_plinko_moving)
	{
		level.aud_plinko_ent stoploopsound();
		level.aud_plinko_moving = 0;
		if(level.aud_play_stop_sound)
		{
			playsoundatpos((-128,803,1149),"plinko_hopper_move_stop");
			level.aud_play_stop_sound = 0;
		}
	}
}

//Function Number: 7
got_code()
{
	self playlocalsound("ee_code_pickup");
}

//Function Number: 8
code_accepted()
{
	self playlocalsound("ee_code_accept");
}

//Function Number: 9
idle_shark_sound()
{
	for(;;)
	{
		self waittillmatch("shark_anim_start","shark_notetrack");
		self playsoundonmovingent("zombie_shark_in_tank");
	}
}

//Function Number: 10
start_obstacle_course()
{
	activateclientexploder(200);
}

//Function Number: 11
stop_obstacle_course()
{
	stopclientexploder(200);
	foreach(var_01 in level.players)
	{
		var_01 thread mute_obstacle_field_hum();
	}
}

//Function Number: 12
mute_obstacle_field_hum()
{
	self clientaddsoundsubmix("mute_security2");
	wait(2);
	self clientclearsoundsubmix("mute_security2");
}

//Function Number: 13
throw_rum_bottle(param_00)
{
	wait(0.3);
	param_00 playsound("ee_bottle_drop");
}

//Function Number: 14
drink_rum()
{
	if(maps\mp\zombies\_util::is_true(self.intoxicated))
	{
		return;
	}

	var_00 = "pilot_drink_exert";
	self playlocalsound("ee_drink_rum");
	wait(0.75);
	switch(self.characterindex)
	{
		case 0:
			var_00 = "guard_drink_exert";
			break;

		case 1:
			var_00 = "exec_drink_exert";
			break;

		case 2:
			var_00 = "it_drink_exert";
			break;

		case 3:
		default:
			if(maps\mp\zombies\_util::getzombieslevelnum() < 3)
			{
				var_00 = "janitor_drink_exert";
			}
			break;
	}

	self.isspeaking = 1;
	self playlocalsound(var_00);
	wait(0.75);
	self clientclearsoundsubmix("mute_security");
	self clientaddsoundsubmix("infected");
	level.aud_drunk_ent playloopsound("ee_drunk_loop");
	self.isspeaking = 0;
}

//Function Number: 15
rum_wears_off(param_00)
{
	param_00 clientaddsoundsubmix("mute_security");
	param_00 clientclearsoundsubmix("infected");
	wait(5);
	level.aud_drunk_ent stoploopsound();
}

//Function Number: 16
obstacle_course_complete()
{
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("ee_obstacle_course_complete");
	}
}

//Function Number: 17
teleporter_parts_missing()
{
	playsoundatpos((-1869,1181,815),"teleporter_broken");
}

//Function Number: 18
teleporter_place_parts(param_00)
{
	self playlocalsound("ee_teleport_machine_repair");
	wait(1);
	playsoundatpos((-1869,1181,815),"teleporter_repair_progress_" + param_00);
}

//Function Number: 19
teleporter_repaired()
{
	playsoundatpos((-1869,1181,815),"teleporter_power_on");
	var_00 = spawn("script_origin",(-1869,1181,815));
	var_00 playloopsound("teleporter_hum");
}

//Function Number: 20
get_weapon_disposal_item(param_00)
{
	self playlocalsound("ee_fishing_grab_item");
}

//Function Number: 21
use_fishing_item(param_00)
{
	if(param_00 == "reel")
	{
		playsoundatpos((-1647,-543,1017),"ee_fishing_install_reel");
		return;
	}

	if(param_00 == "line")
	{
		playsoundatpos((-1647,-543,1017),"ee_fishing_install_line");
		return;
	}

	if(param_00 == "hook")
	{
		playsoundatpos((-1647,-543,1017),"ee_fishing_install_hook");
		return;
	}
}

//Function Number: 22
fishing_cast_line()
{
	playsoundatpos((-1647,-543,1017),"ee_fishing_cast_line");
	wait(2);
	playsoundatpos((-1715,-543,903),"ee_fishing_cast_splash");
}

//Function Number: 23
fishing_retrieve_line()
{
	wait(0.5);
	playsoundatpos((-1647,-543,1017),"ee_fishing_retrieve_line");
	wait(1.3);
	playsoundatpos((-1715,-543,903),"ee_fishing_retrieve_splash");
}

//Function Number: 24
fishing_drop_item()
{
	self playlocalsound("ee_fishing_drop_item");
	wait(0.8);
	playsoundatpos((-1715,-543,903),"ee_fishing_cast_splash");
}

//Function Number: 25
fishing_grab_item(param_00)
{
	self playlocalsound("ee_fishing_grab_item");
}

//Function Number: 26
island_timer_start()
{
	self endon("disconnect");
	wait(5);
	self playlocalsound("ee_island_timer");
}

//Function Number: 27
dig()
{
	self playsound("ee_player_dig");
}

//Function Number: 28
treasure_found()
{
	self playsound("ee_treasure_found");
}

//Function Number: 29
treasure_opened()
{
	self playsound("ee_treasure_open");
}

//Function Number: 30
switch_pickup()
{
	self playlocalsound("ee_pickup_cage_switch");
}

//Function Number: 31
switch_place_in_socket()
{
	self playlocalsound("ee_cage_switch_place");
}

//Function Number: 32
cage_switch()
{
	playsoundatpos((157,602,890),"ee_cage_switch_throw");
}

//Function Number: 33
cage_down()
{
	playsoundatpos((731,420,958),"ee_shark_cage_lower");
	playsoundatpos((731,420,793),"zark_moonpool_doors_open");
	wait(3.5);
	playsoundatpos((731,420,793),"ee_shark_cage_splash");
}

//Function Number: 34
cage_up()
{
	if(level.aud_cage_playing == 0)
	{
		level.aud_cage_playing = 1;
		playsoundatpos((731,420,958),"ee_shark_cage_raise");
		wait(2.5);
		playsoundatpos((731,420,793),"zark_moonpool_doors_close");
		wait(5);
		level.aud_cage_playing = 0;
	}
}

//Function Number: 35
shark_enters()
{
}

//Function Number: 36
shark_loop()
{
}

//Function Number: 37
shark_leaves()
{
}

//Function Number: 38
shark_attack(param_00)
{
	param_00 playlocalsound("ee_shark_attack");
}

//Function Number: 39
grab_eyeball()
{
	self playlocalsound("ee_eyeball");
}

//Function Number: 40
open_locker(param_00)
{
	playsoundatpos(param_00.origin,"ee_locker_opened");
}

//Function Number: 41
radioswitchinit()
{
	thread radioalivemonitor();
	var_00 = getent("island_radio","targetname");
	var_01 = common_scripts\utility::cointoss();
	var_02 = "temp";
	if(var_01 == 0)
	{
		var_02 = "zmb_mus_radio_04";
	}
	else
	{
		var_02 = "zmb_mus_radio_05";
	}

	level.radioent2 scalevolume(0.02,0.1);
	level.radioent3 scalevolume(0.02,0.1);
	level.radioent4 scalevolume(0.02,0.1);
	level.radioent1 playloopsound("zmb_mus_radio_01");
	level.radioent2 playloopsound("zmb_mus_radio_02");
	level.radioent3 playloopsound("zmb_mus_radio_03");
	level.radioent4 playloopsound(var_02);
	if(isdefined(var_00))
	{
		for(;;)
		{
			var_00 waittill("trigger");
			if(level.radioalive == 1)
			{
				radiochangestation();
				level.radioent5 playsound("zmb_radio_change");
			}

			if(level.radioalive == 0)
			{
			}
		}
	}
}

//Function Number: 42
radiochangestation()
{
	if(level.radiostate == 1)
	{
		radiosetvolumes(2);
		level.radiostate = 2;
		return;
	}

	if(level.radiostate == 2)
	{
		radiosetvolumes(3);
		level.radiostate = 3;
		return;
	}

	if(level.radiostate == 3)
	{
		radiosetvolumes(1);
		level.radiostate = 4;
		return;
	}

	if(level.radiostate == 4)
	{
		radiosetvolumes(2);
		level.radiostate = 5;
		return;
	}

	if(level.radiostate == 5)
	{
		radiosetvolumes(3);
		level.radiostate = 6;
		return;
	}

	if(level.radiostate == 6)
	{
		radiosetvolumes(1);
		level.radiostate = 7;
		return;
	}

	if(level.radiostate == 7)
	{
		radiosetvolumes(2);
		level.radiostate = 8;
		return;
	}

	if(level.radiostate == 8)
	{
		radiosetvolumes(3);
		level.radiostate = 9;
		return;
	}

	if(level.radiostate == 9)
	{
		radiosetvolumes(1);
		level.radiostate = 10;
		return;
	}

	if(level.radiostate == 10)
	{
		radiosetvolumes(2);
		level.radiostate = 11;
		return;
	}

	if(level.radiostate == 11)
	{
		radiosetvolumes(3);
		level.radiostate = 12;
		return;
	}

	if(level.radiostate == 12)
	{
		radiosetvolumes(1);
		level.radiostate = 13;
		return;
	}

	if(level.radiostate == 13)
	{
		radiosetvolumes(4);
		level.radiostate = 1;
		return;
	}
}

//Function Number: 43
radiosetvolumes(param_00)
{
	var_01[1] = level.radioent1;
	var_01[2] = level.radioent2;
	var_01[3] = level.radioent3;
	var_01[4] = level.radioent4;
	var_01[1] scalevolume(0.02,0.1);
	var_01[2] scalevolume(0.02,0.1);
	var_01[3] scalevolume(0.02,0.1);
	var_01[4] scalevolume(0.02,0.1);
	var_01[param_00] scalevolume(1,0.1);
}

//Function Number: 44
radioalivemonitor()
{
	var_00 = getent("island_radio_dmg","targetname");
	wait(0.5);
	var_00 waittill("trigger",var_01);
	level.radioalive = 0;
	level.radioent1 scalevolume(0,0.1);
	level.radioent2 scalevolume(0,0.1);
	level.radioent3 scalevolume(0,0.1);
	level.radioent4 scalevolume(0,0.1);
	wait(1);
	level.radioent1 delete();
	level.radioent2 delete();
	level.radioent3 delete();
	level.radioent4 delete();
	level.radioent5 delete();
}