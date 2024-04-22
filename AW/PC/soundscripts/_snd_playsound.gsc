/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _snd_playsound.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 336 ms
 * Timestamp: 4/22/2024 2:04:06 AM
*******************************************************************/

//Function Number: 1
snd_play_linked(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "oneshot";
	var_07 = undefined;
	var_08 = "3d";
	return sndx_play_alias(param_00,var_06,var_07,var_08,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 2
snd_play_at(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "oneshot";
	var_07 = param_01;
	var_08 = "3d";
	return sndx_play_alias(param_00,var_06,var_07,var_08,param_02,param_03,param_04,param_05);
}

//Function Number: 3
snd_play_2d(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "oneshot";
	var_06 = undefined;
	var_07 = "2d";
	return sndx_play_alias(param_00,var_05,var_06,var_07,param_01,param_02,param_03,param_04);
}

//Function Number: 4
snd_play_loop_linked(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "loop";
	var_07 = undefined;
	var_08 = "3d";
	return sndx_play_alias(param_00,var_06,var_07,var_08,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 5
snd_play_loop_at(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "loop";
	var_07 = param_01;
	var_08 = "3d";
	return sndx_play_alias(param_00,var_06,var_07,var_08,param_02,param_03,param_04,param_05);
}

//Function Number: 6
snd_play_loop_2d(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "loop";
	var_06 = undefined;
	var_07 = "2d";
	return sndx_play_alias(param_00,var_05,var_06,var_07,param_01,param_02,param_03,param_04);
}

//Function Number: 7
snd_play_delayed_linked(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = "oneshot";
	var_09 = undefined;
	var_0A = "3d";
	return sndx_play_alias(param_00,var_08,var_09,var_0A,param_03,param_04,param_05,param_06,param_07,param_01,param_02);
}

//Function Number: 8
snd_play_delayed_at(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = "oneshot";
	var_09 = param_01;
	var_0A = "3d";
	return sndx_play_alias(param_00,var_08,var_09,var_0A,param_04,param_05,param_06,param_07,(0,0,0),param_02,param_03);
}

//Function Number: 9
snd_play_delayed_2d(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = "oneshot";
	var_08 = undefined;
	var_09 = "2d";
	return sndx_play_alias(param_00,var_07,var_08,var_09,param_03,param_04,param_05,param_06,(0,0,0),param_01,param_02);
}

//Function Number: 10
snd_play_delayed_loop_linked(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = "loop";
	var_09 = undefined;
	var_0A = "3d";
	return sndx_play_alias(param_00,var_08,var_09,var_0A,param_03,param_04,param_05,param_06,param_07,param_01,param_02);
}

//Function Number: 11
snd_play_delayed_loop_at(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = "loop";
	var_09 = param_03;
	var_0A = "3d";
	return sndx_play_alias(param_00,var_08,var_09,var_0A,param_04,param_05,param_06,param_07,(0,0,0),param_01,param_02);
}

//Function Number: 12
snd_play_delayed_loop_2d(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = "loop";
	var_08 = undefined;
	var_09 = "2d";
	return sndx_play_alias(param_00,var_07,var_08,var_09,param_03,param_04,param_05,param_06,(0,0,0),param_01,param_02);
}

//Function Number: 13
snd_play_set_cleanup_msg(param_00)
{
}

//Function Number: 14
sndx_play_alias(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!soundexists(param_00))
	{
		return;
	}

	var_0C = param_03 == "3d" && !isdefined(param_02);
	var_0D = self;
	if(!var_0C)
	{
		var_0D = level.player;
	}

	if(!isdefined(var_0D))
	{
		return;
	}

	var_0E = var_0D.origin;
	if(isdefined(param_02))
	{
		var_0E = param_02;
	}

	var_0F = spawn("script_origin",var_0E);
	var_0D thread sndx_play_alias_thread(param_00,param_01,var_0C,param_02,param_03,var_0F,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	return var_0F;
}

//Function Number: 15
sndx_play_alias_thread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	var_0D = self;
	var_0E = "sndx_play_alias_" + soundscripts\_snd::snd_new_guid();
	level endon(var_0E);
	param_05 endon("death");
	param_06 = soundscripts\_audio::aud_get_optional_param(undefined,param_06);
	param_07 = soundscripts\_audio::aud_get_optional_param(0,param_07);
	param_08 = soundscripts\_audio::aud_get_optional_param(0.1,param_08);
	param_09 = soundscripts\_audio::aud_get_optional_param(1,param_09);
	param_0A = soundscripts\_audio::aud_get_optional_param((0,0,0),param_0A);
	param_0B = soundscripts\_audio::aud_get_optional_param(0,param_0B);
	param_0C = soundscripts\_audio::aud_get_optional_param(0,param_0C);
	if(param_02)
	{
		var_0F = "tag_origin";
		if(isdefined(var_0D.model) || var_0D.model != "" || var_0D gettagindex(var_0F) < 0)
		{
			var_0F = "";
		}

		param_05 linkto(var_0D,var_0F,param_0A,(0,0,0));
		param_05 thread sndx_play_alias_monitor_linkdeath(param_08,var_0E,var_0D);
	}

	if(param_0B > 0)
	{
		if(param_0C)
		{
			soundscripts\_audio::aud_slomo_wait(param_0B);
		}
		else
		{
			wait(param_0B);
		}
	}

	if(param_01 == "oneshot")
	{
		var_10 = "sounddone";
		var_11 = param_07;
		param_05 snd_play(param_00,var_10,var_11);
		param_05 thread sndx_play_alias_monitor_sounddone(0.05,var_0E,var_10);
	}
	else
	{
		param_05 snd_play_loop(param_00);
	}

	param_05 scalevolume(0,0);
	if(isstring(param_06))
	{
		param_05 thread sndx_play_alias_monitor_stopnotify(param_08,var_0E,param_06);
	}

	param_05 scalevolume(param_09,param_07);
}

//Function Number: 16
sndx_play_alias_monitor_linkdeath(param_00,param_01,param_02)
{
	level endon(param_01);
	self endon("death");
	var_03 = self;
	param_02 waittill("death");
	var_03 thread sndx_play_alias_fade_delete(param_00,param_01);
}

//Function Number: 17
sndx_play_alias_monitor_sounddone(param_00,param_01,param_02)
{
	level endon(param_01);
	self endon("death");
	var_03 = self;
	var_03 waittill(param_02);
	var_03 thread sndx_play_alias_fade_delete(undefined,param_01);
}

//Function Number: 18
sndx_play_alias_monitor_stopnotify(param_00,param_01,param_02)
{
	level endon(param_01);
	self endon("death");
	var_03 = self;
	level waittill(param_02);
	var_03 thread sndx_play_alias_fade_delete(param_00,param_01);
}

//Function Number: 19
sndx_play_alias_fade_delete(param_00,param_01)
{
	level notify(param_01);
	var_02 = self;
	if(isdefined(var_02))
	{
		if(isdefined(param_00))
		{
			var_02 scalevolume(0,param_00);
			wait(param_00);
			waittillframeend;
		}

		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 20
snd_play(param_00,param_01,param_02)
{
	if(soundexists(param_00))
	{
		self.guid = soundscripts\_snd::snd_new_guid();
		self.snd_is_one_shot = 1;
		param_01 = soundscripts\_audio::aud_get_optional_param(undefined,param_01);
		param_02 = soundscripts\_audio::aud_get_optional_param(0,param_02);
		self playsound(param_00,param_01,0,param_02);
	}
}

//Function Number: 21
snd_play_loop(param_00)
{
	if(soundexists(param_00))
	{
		if(!isdefined(self.snd_is_loop))
		{
			self playloopsound(param_00);
			self.guid = soundscripts\_snd::snd_new_guid();
			self.snd_is_loop = 1;
			return;
		}

		return;
	}
}

//Function Number: 22
snd_stop_sound()
{
	if(isdefined(self.snd_is_one_shot))
	{
		self.snd_is_one_shot = undefined;
		self stopsounds();
		return;
	}

	if(isdefined(self.snd_is_loop))
	{
		self.snd_is_loop = undefined;
		self stoploopsound();
		self notify("sounddone");
	}
}

//Function Number: 23
snd_play_amb_loop(param_00,param_01,param_02,param_03)
{
	if(soundexists(param_00))
	{
		var_04 = 0.1;
		var_05 = spawn("script_origin",param_01);
		var_05 playloopsound(param_00);
		level waittill(param_02);
		if(isdefined(param_03))
		{
			var_04 = param_03;
		}

		if(isdefined(var_05))
		{
			var_05 scalevolume(0,var_04);
			wait(0.05);
			var_05 delete();
			return;
		}
	}
}