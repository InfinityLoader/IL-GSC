/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_lab_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 76 ms
 * Timestamp: 4/22/2024 2:19:46 AM
*******************************************************************/

//Function Number: 1
main()
{
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
	wait(1);
	ambientplay("amb_zmb_lab_ext");
}

//Function Number: 4
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