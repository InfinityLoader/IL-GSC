/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_brg_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 127 ms
 * Timestamp: 4/22/2024 2:19:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.customzombiemusicstates = ::customzombiemusicstates;
	thread setup_audio();
	thread horde_audio();
	thread onplayerconnectedaudio();
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
setup_audio()
{
	ambientplay("amb_brg_warehouse_front");
	thread exploder_7_audio_emitters();
	thread civilian_extraction_success_stinger();
	thread civilian_extraction_fail_stinger();
}

//Function Number: 4
exploder_7_audio_emitters()
{
	var_00 = spawn("script_origin",(3761,-2060,143));
	var_00 playloopsound("water_main_spray");
	var_01 = spawn("script_origin",(3602,-2074,-23));
	var_01 playloopsound("water_main_splash");
	var_02 = spawn("script_origin",(415,-5346,170));
	var_02 playloopsound("water_main_spray");
	level waittill("stop_audio_exloder_7");
	var_00 stoploopsound();
	var_02 stoploopsound();
	var_01 stoploopsound();
	wait 0.05;
	var_00 delete();
	var_02 delete();
	var_01 delete();
}

//Function Number: 5
civilian_extraction_success_stinger()
{
	for(;;)
	{
		level waittill("extraction_complete");
		playsoundatpos((0,0,0),"zmb_civ_extract_success");
	}
}

//Function Number: 6
civilian_extraction_fail_stinger()
{
	for(;;)
	{
		level waittill("extraction_failed");
		playsoundatpos((0,0,0),"zmb_civ_extract_fail");
	}
}

//Function Number: 7
horde_audio()
{
	self endon("death");
	wait(1);
	level.horde_audio_ent = spawn("script_origin",(0,0,0));
	for(;;)
	{
		level.horde_audio_ent scalevolume(0);
		level waittill("zombie_wave_started");
		wait(0.5);
		if(level.roundtype == "zombie_dog")
		{
			level.horde_audio_ent playloopsound("zmb_horde_dog");
		}

		if(level.roundtype == "zombie_host")
		{
			level.horde_audio_ent playloopsound("zmb_horde_host");
		}
		else
		{
			level.horde_audio_ent playloopsound("zmb_horde_general");
		}

		level.horde_audio_ent scalevolume(1,5);
		level waittill("zombie_wave_ended");
		level.horde_audio_ent stoploopsound();
	}
}

//Function Number: 8
customzombiemusicstates()
{
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_normal",["zmb_mus_wave_04_lp","zmb_mus_wave_05_lp","zmb_mus_wave_06_lp","zmb_mus_wave_01_lp","zmb_mus_wave_02_lp","zmb_mus_wave_03_lp"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_dog",["zmb_mus_spec_04_lp","zmb_mus_spec_05_lp","zmb_mus_spec_06_lp"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_host",["zmb_mus_spec_04_lp","zmb_mus_spec_05_lp","zmb_mus_spec_06_lp"],0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_civilian","zmb_mus_spec_03_lp",0,1,1,1);
	level thread maps\mp\zombies\_zombies_music::setupmusicstate(1,"round_zombie_melee_goliath",["zmb_mus_spec_01_lp","zmb_mus_spec_02_lp"],0,1,1,1);
}