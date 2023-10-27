/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_canon_farm_lighting.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 3:15:22 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	setdvar("2893",7);
}

//Function Number: 2
func_6B82()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(!isdefined(level.var_A4B5))
		{
			level.var_A4B5["intensity"] = 0.1;
			level.var_A4B5["falloff"] = 1.2;
			level.var_A4B5["scaleX"] = 1;
			level.var_A4B5["scaleY"] = 1;
			level.var_A4B5["squareAspectRatio"] = 0;
		}

		if(isdefined(level.var_A4B5))
		{
			var_00 vignettesetparams(level.var_A4B5["intensity"],level.var_A4B5["falloff"],level.var_A4B5["scaleX"],level.var_A4B5["scaleY"],level.var_A4B5["squareAspectRatio"]);
			var_00 setscriptmotionblurparams(level.var_6465["velocityscaler"],level.var_6465["cameraRotationInfluence"],level.var_6465["cameraTranslationInfluence"]);
		}

		if(isdefined(level.var_6465))
		{
			var_00 setscriptmotionblurparams(level.var_6465["velocityscaler"],level.var_6465["cameraRotationInfluence"],level.var_6465["cameraTranslationInfluence"]);
		}
	}
}