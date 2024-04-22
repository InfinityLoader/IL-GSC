/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _audio_whizby.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 135 ms
 * Timestamp: 4/22/2024 2:03:53 AM
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
		for(var_0C = 1;var_0C < var_05;var_0C++)
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
						var_09 = float(var_04);
						break;

					case "near_radius":
						var_06[0] = float(var_04);
						break;

					case "medium_radius":
						var_06[1] = float(var_04);
						break;

					case "far_radius":
						var_06[2] = float(var_04);
						break;

					case "near_spread":
						var_07[0] = float(var_04);
						break;

					case "medium_spread":
						var_07[1] = float(var_04);
						break;

					case "far_spread":
						var_07[2] = float(var_04);
						break;

					case "near_prob":
						var_08[0] = float(var_04);
						break;

					case "medium_prob":
						var_08[1] = float(var_04);
						break;

					case "far_prob":
						var_08[2] = float(var_04);
						break;
				}
			}
		}

		if(var_0A > 0)
		{
			var_02["radius"] = var_06;
			var_02["spread"] = var_07;
			var_02["probability"] = var_08;
			if(isdefined(var_09))
			{
				var_02["offset"] = var_09;
			}
		}

		return var_02;
	}
}