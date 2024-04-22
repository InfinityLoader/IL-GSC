/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_zombie_dog_traverse.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 58 ms
 * Timestamp: 4/22/2024 2:08:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.zombietraverseanims) || !isdefined(level.zombietraverseanims["dog"]))
	{
		initzombiedogtraverseanims();
	}

	maps\mp\agents\humanoid\_humanoid_traverse::dotraverse();
}

//Function Number: 2
end_script()
{
	maps\mp\agents\humanoid\_humanoid_traverse::end_script();
}

//Function Number: 3
initzombiedogtraverseanims()
{
	if(!isdefined(level.zombietraverseanims))
	{
		level.zombietraverseanims = [];
	}

	if(!isdefined(level.zombietraverseanims["dog"]))
	{
		level.zombietraverseanims["dog"] = [];
	}

	level.zombietraverseanims["dog"]["jump_across_100"] = "traverse_jump_over_24";
	level.zombietraverseanims["dog"]["jump_across_196"] = "traverse_jump_over_24";
	level.zombietraverseanims["dog"]["boost_jump_across_100"] = level.zombietraverseanims["dog"]["jump_across_100"];
	level.zombietraverseanims["dog"]["boost_jump_across_196"] = level.zombietraverseanims["dog"]["jump_across_196"];
	level.zombietraverseanims["dog"]["jump_down_40"] = "traverse_jump_down_40";
	level.zombietraverseanims["dog"]["jump_down_slow"] = "traverse_jump_down_70";
	level.zombietraverseanims["dog"]["jump_down_fast"] = "traverse_jump_down_70";
	level.zombietraverseanims["dog"]["step_over_40"] = "traverse_jump_over_36";
	level.zombietraverseanims["dog"]["window_over_36"] = "traverse_jump_over_36";
	level.zombietraverseanims["dog"]["step_up_40"] = "traverse_jump_up_40";
	level.zombietraverseanims["dog"]["wall_over_40"] = "traverse_jump_over_36";
	level.zombietraverseanims["dog"]["boost_jump_up"] = "traverse_jump_up_70";
	level.zombietraverseanims["dog"]["climbup_shaft"] = "traverse_climbup_shaft";
	level.zombietraverseanims["dog"]["spawn_closet_door"] = "traverse_spawn_closet_door";
	level.zombietraverseanims["dog"]["spawn_closet_vault"] = "traverse_spawn_closet_vault";
	level.zombietraverseanims["dog"]["spawn_closet_window"] = "traverse_spawn_closet_window";
	level.zombietraverseanims["dog"]["spawn_closet_high_window"] = "traverse_jump_over_36";
	if(!isdefined(level.zombietraverseanimchance))
	{
		level.zombietraverseanimchance = [];
	}

	if(!isdefined(level.zombietraverseanimchance["dog"]))
	{
		level.zombietraverseanimchance["dog"] = [];
	}

	level.zombietraverseanimchance["dog"]["traverse_jump_up_70"][0] = 0.7;
	level.zombietraverseanimchance["dog"]["traverse_jump_up_70"][1] = 0.3;
	foreach(var_01 in level.zombietraverseanimchance["dog"])
	{
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			var_02 = var_02 + var_04;
		}
	}
}