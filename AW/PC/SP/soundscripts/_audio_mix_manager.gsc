/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts/_audio_mix_manager.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 219 ms
 * Timestamp: 10/27/2023 2:05:39 AM
*******************************************************************/

//Function Number: 1
mm_init()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.mix))
	{
		level._audio.mix = spawnstruct();
	}

	level._audio.mix.curr_preset = undefined;
	level._audio.mix.zonemix = [];
}

//Function Number: 2
mm_start_preset(param_00,param_01)
{
	if(!isdefined(level._audio.mix.curr_preset) || param_00 != level._audio.mix.curr_preset)
	{
		clearallsubmixes(0);
		if(isdefined(param_01))
		{
			addsoundsubmix(param_00,param_01);
		}
		else
		{
			addsoundsubmix(param_00);
		}

		level._audio.mix.curr_preset = param_00;
	}
}

//Function Number: 3
mm_start_zone_preset(param_00)
{
	foreach(var_02 in level._audio.mix.zonemix)
	{
		if(param_00 != var_02)
		{
			makesoundsubmixunsticky(var_02);
			clearsoundsubmix(var_02,1);
			level._audio.mix.zonemix[var_02] = undefined;
		}
	}

	mmx_start_zone_preset(param_00);
}

//Function Number: 4
mm_clear_zone_mix(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(!isdefined(param_00))
	{
		foreach(param_00 in level._audio.mix.zonemix)
		{
			makesoundsubmixunsticky(param_00);
			clearsoundsubmix(param_00,var_02);
			level._audio.mix.zonemix[param_00] = undefined;
		}

		return;
	}

	if(isdefined(level._audio.mix.zonemix[param_00]))
	{
		makesoundsubmixunsticky(param_00);
		clearsoundsubmix(param_00,var_02);
		level._audio.mix.zonemix[param_00] = undefined;
	}
}

//Function Number: 5
mm_blend_zone_mix(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00) && param_00 != "none")
	{
		if(param_01 == 0)
		{
			mm_clear_zone_mix(param_00,0);
		}
		else
		{
			mmx_start_zone_preset(param_00);
			blendsoundsubmix(param_00,param_01,0);
		}
	}

	if(isdefined(param_02) && param_02 != "none")
	{
		if(param_03 == 0)
		{
			mm_clear_zone_mix(param_02,0);
			return;
		}

		mmx_start_zone_preset(param_02);
		blendsoundsubmix(param_02,param_03,0);
	}
}

//Function Number: 6
mm_clear_submixes(param_00)
{
	clearallsubmixes(param_00);
	level._audio.mix.curr_preset = undefined;
}

//Function Number: 7
mm_make_submix_sticky(param_00)
{
	makesoundsubmixsticky(param_00);
}

//Function Number: 8
mm_make_submix_unsticky(param_00)
{
	makesoundsubmixunsticky(param_00);
}

//Function Number: 9
mm_add_submix(param_00,param_01)
{
	if(isdefined(param_01))
	{
		addsoundsubmix(param_00,param_01);
		return;
	}

	addsoundsubmix(param_00);
}

//Function Number: 10
mm_scale_submix(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	addsoundsubmix(param_00,var_03,param_01);
}

//Function Number: 11
mm_blend_submix(param_00,param_01,param_02)
{
	param_01 = clamp(param_01,0,1);
	var_03 = 0;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	blendsoundsubmix(param_00,param_01,var_03);
}

//Function Number: 12
mm_clear_submix(param_00,param_01)
{
	if(isdefined(param_01))
	{
		clearsoundsubmix(param_00,param_01);
	}
	else
	{
		clearsoundsubmix(param_00);
	}

	if(isdefined(level._audio.mix.curr_preset) && level._audio.mix.curr_preset == param_00)
	{
		level._audio.mix.curr_preset = undefined;
	}
}

//Function Number: 13
mm_add_dynamic_volmod_submix(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	addsoundsubmix(param_00,var_03,1,param_01);
}

//Function Number: 14
mm_mute_volmods(param_00,param_01)
{
	var_02 = [];
	if(isstring(param_00))
	{
		var_02[var_02.size] = param_00;
		var_02[var_02.size] = 0;
	}
	else
	{
		foreach(var_04 in param_00)
		{
			var_02[var_02.size] = var_04;
			var_02[var_02.size] = 0;
		}
	}

	mm_add_dynamic_volmod_submix("mm_mute",var_02,param_01);
}

//Function Number: 15
mm_clear_volmod_mute_mix(param_00)
{
	if(isdefined(param_00))
	{
		clearsoundsubmix("mm_mute",param_00);
		return;
	}

	clearsoundsubmix("mm_mute");
}

//Function Number: 16
mm_solo_volmods(param_00,param_01)
{
	var_02 = [];
	var_02[var_02.size] = "set_all";
	var_02[var_02.size] = 0;
	if(isstring(param_00))
	{
		var_02[var_02.size] = param_00;
		var_02[var_02.size] = 1;
	}
	else
	{
		foreach(var_04 in param_00)
		{
			var_02[var_02.size] = var_04;
			var_02[var_02.size] = 1;
		}
	}

	mm_add_dynamic_volmod_submix("mm_solo",var_02,param_01);
}

//Function Number: 17
mm_clear_solo_volmods(param_00)
{
	if(isdefined(param_00))
	{
		clearsoundsubmix("mm_solo",param_00);
		return;
	}

	clearsoundsubmix("mm_solo");
}

//Function Number: 18
mmx_start_zone_preset(param_00)
{
	if(!isdefined(level._audio.mix.zonemix[param_00]))
	{
		addsoundsubmix(param_00);
		makesoundsubmixsticky(param_00);
		level._audio.mix.zonemix[param_00] = param_00;
	}
}