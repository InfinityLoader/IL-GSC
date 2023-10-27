/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_exploderanim.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 89 ms
 * Timestamp: 10/27/2023 2:45:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = getentarray("script_model","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_exploder))
		{
			var_02 thread exploderanim_think();
		}
	}
}

//Function Number: 2
exploderanim_think()
{
	for(;;)
	{
		self waittill("play_exploder_anim");
		thread anim_play();
	}
}

//Function Number: 3
anim_play()
{
	var_00 = undefined;
	var_01 = strtok(self.targetname,":;, ");
	if(var_01.size > 1 && isdefined(var_01[1]))
	{
		var_00 = var_01[1];
	}
	else
	{
		var_00 = self.model + "_anim";
	}

	var_02 = get_animtree(var_00);
	maps\_utility::assign_animtree(var_02);
	maps\_anim::anim_single_solo(self,var_00);
}

//Function Number: 4
get_animtree(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.exploder_animtrees.size;var_02++)
	{
		var_03 = getarraykeys(level.scr_anim[level.exploder_animtrees[var_02]]);
		if(common_scripts\utility::array_contains(var_03,param_00))
		{
			var_01 = level.exploder_animtrees[var_02];
			break;
		}
	}

	return var_01;
}