/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts/_audio_whizby.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 101 ms
 * Timestamp: 10/27/2023 2:05:50 AM
*******************************************************************/

//Function Number: 1
whiz_init()
{
	level._audio.whiz = spawnstruct();
	level._audio.whiz.use_string_table_presets = 0;
}

//Function Number: 2
whiz_use_string_table()
{
	level._audio.whiz.use_string_table_presets = 1;
}

//Function Number: 3
whiz_set_preset(param_00)
{
	var_01 = [];
	var_01 = whizx_get_stringtable_preset(param_00);
	var_01["name"] = param_00;
	var_02 = var_01["probability"];
	var_03 = var_01["spread"];
	var_04 = var_01["radius"];
	var_05 = var_01["offset"];
	level.player setwhizbyprobabilities(var_02[0],var_02[1],var_02[2]);
	level.player setwhizbyspreads(var_03[0],var_03[1],var_03[2]);
	level.player setwhizbyradii(var_04[0],var_04[1],var_04[2]);
	level.player setwhizbyoffset(var_05);
}

//Function Number: 4
whiz_set_probabilities(param_00,param_01,param_02)
{
	level.player setwhizbyprobabilities(param_00,param_01,param_02);
}

//Function Number: 5
whiz_set_spreads(param_00,param_01,param_02)
{
	level.player setwhizbyspreads(param_00,param_01,param_02);
}

//Function Number: 6
whiz_set_radii(param_00,param_01,param_02)
{
	level.player setwhizbyradii(param_00,param_01,param_02);
}

//Function Number: 7
whiz_set_offset(param_00)
{
	level.player setwhizbyoffset(param_00);
}

//Function Number: 8
whizx_get_stringtable_preset(param_00)
{
	var_01 = "soundtables/sp_defaults.csv";
	var_02 = [];
	var_02 = whizx_get_mix_preset_from_stringtable_internal(var_01,param_00);
	return var_02;
}

//Function Number: 9
whizx_get_mix_preset_from_stringtable_internal(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	var_04 = "";
	var_05 = 12;
	var_06 = [];
	var_07 = [];
	var_08 = [];
	var_09 = 0;
	var_0A = 0;
	var_0B = packedtablesectionlookup(param_00,"whizby_preset_names","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
	if(isdefined(var_0B))
	{
		var_0C = 1;
		if(var_0C < var_05)
		{
			var_03 = packedtablelookupwithrange(param_00,0,"whizby_preset_names",var_0C,var_0B[0],var_0B[1]);
			var_04 = packedtablelookupwithrange(param_00,0,param_01,var_0C,var_0B[0],var_0B[1]);
			if(!isdefined(var_04))
			{
				break;
			}

			if(var_04 != "" && var_04 != "comments")
			{
				var_0A++;
				switch(var_03)
				{
					case "radius_offset":
						break;

					case "near_radius":
						break;

					case "medium_radius":
						break;

					case "far_radius":
						break;

					case "near_spread":
						break;

					case "medium_spread":
						break;

					case "far_spread":
						break;

					case "near_prob":
						break;

					case "medium_prob":
						break;

					case "far_prob":
						break;
				}
			}
		}
	}
}