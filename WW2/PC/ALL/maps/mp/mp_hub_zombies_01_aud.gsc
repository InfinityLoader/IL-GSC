/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_hub_zombies_01_aud.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 3:15:43 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	thread watchaudiologsubmixes();
}

//Function Number: 2
watchaudiologsubmixes()
{
	setdvar("snd_playing_log",0);
	var_00 = getdvarint("snd_playing_log");
	for(;;)
	{
		var_01 = getdvarint("snd_playing_log");
		if(var_01 != var_00)
		{
			if(var_01)
			{
				level.var_721C method_8626("zm_audio_log_mix");
			}
			else
			{
				level.var_721C method_8627("zm_audio_log_mix");
			}

			var_00 = var_01;
		}

		wait(0.5);
	}
}