/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts/_snd_pcap.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 160 ms
 * Timestamp: 10/27/2023 2:06:02 AM
*******************************************************************/

//Function Number: 1
snd_pcap_play_vo(param_00,param_01,param_02,param_03)
{
	thread sndx_pcap_play_vo_thread(param_00,param_01,param_02,param_03);
}

//Function Number: 2
snd_pcap_play_vo_30fps(param_00,param_01,param_02,param_03)
{
	thread sndx_pcap_play_vo_thread(param_00,param_01,param_02,30,param_03);
}

//Function Number: 3
snd_pcap_play_vo_20fps(param_00,param_01,param_02)
{
	thread sndx_pcap_play_vo_thread(param_00,param_01,param_02,20);
}

//Function Number: 4
snd_pcap_play_radio_vo(param_00,param_01,param_02,param_03)
{
	thread sndx_pcap_play_radio_vo_thread(param_00,param_01,param_02,param_03);
}

//Function Number: 5
snd_pcap_play_radio_vo_60fps(param_00,param_01,param_02)
{
	thread sndx_pcap_play_radio_vo_thread(param_00,param_01,param_02,60);
}

//Function Number: 6
snd_pcap_play_radio_vo_30fps(param_00,param_01,param_02)
{
	thread sndx_pcap_play_radio_vo_thread(param_00,param_01,param_02,30);
}

//Function Number: 7
snd_pcap_add_notetrack_mapping(param_00,param_01,param_02)
{
	var_03 = sndx_pcap_find_anime_and_animname(param_00);
	var_04 = var_03["animname"];
	var_05 = var_03["anime"];
	maps\_anim::addnotetrack_customfunction(var_04,param_01,param_02,var_05);
}

//Function Number: 8
sndx_pcap_play_vo_thread(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	param_02 = soundscripts\_audio::aud_get_optional_param(undefined,param_02);
	param_05 = soundscripts\_audio::aud_get_optional_param(0.1,param_05);
	sndx_pcap_wait(param_01,param_03);
	var_07 = spawn("script_origin",var_06.origin);
	var_07 linkto(var_06);
	var_07 scalevolume(1,0);
	var_07 soundscripts\_snd_playsound::snd_play(param_00,"sound_done");
	var_07 endon("death");
	if(isstring(param_04))
	{
		var_07 thread sndx_pcap_play_vo_monitor_stopnotify(param_05,param_04);
	}

	var_07 waittill("sound_done");
	if(isstring(param_02))
	{
		level notify(param_02);
	}

	wait(0.05);
	var_07 delete();
}

//Function Number: 9
sndx_pcap_play_vo_monitor_stopnotify(param_00,param_01)
{
	self endon("death");
	var_02 = self;
	level waittill(param_01);
	var_02 thread sndx_pcap_play_vo_fade_delete(param_00);
}

//Function Number: 10
sndx_pcap_play_vo_fade_delete(param_00)
{
	var_01 = self;
	if(isdefined(var_01))
	{
		if(isdefined(param_00))
		{
			var_01 scalevolume(0,param_00);
			wait(param_00);
			waittillframeend;
		}

		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 11
sndx_pcap_play_radio_vo_thread(param_00,param_01,param_02,param_03)
{
	param_02 = soundscripts\_audio::aud_get_optional_param(undefined,param_02);
	sndx_pcap_wait(param_01,param_03);
	level maps\_utility::dialogue_queue(param_00);
	if(isstring(param_02))
	{
		level notify(param_02);
	}
}

//Function Number: 12
sndx_pcap_wait(param_00,param_01)
{
	param_00 = soundscripts\_audio::aud_get_optional_param(0,param_00);
	param_01 = soundscripts\_audio::aud_get_optional_param(60,param_01);
	var_02 = floor(param_00);
	var_03 = param_00 - var_02 * 100;
	var_04 = var_02 + var_03 * 1 / param_01;
	wait(var_04);
}

//Function Number: 13
sndx_pcap_find_anime_and_animname(param_00)
{
	foreach(var_07, var_02 in level.scr_anim)
	{
		if(isstring(var_07) && isarray(var_02))
		{
			foreach(var_06, var_04 in var_02)
			{
				if(isstring(var_06) && !isarray(var_04))
				{
					if(param_00 == var_04)
					{
						var_05 = [];
						var_05["anime"] = var_06;
						var_05["animname"] = var_07;
						return var_05;
					}
				}
			}
		}
	}
}