/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:22:58 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_stealth_visibility_system::stealth_visibility_system_main();
	maps\_stealth_behavior_system::stealth_behavior_system_main();
	maps\_stealth_corpse_system::stealth_corpse_system_main();
	maps\_stealth_anims::main();
	level.global_callbacks["_autosave_stealthcheck"] = ::maps\_stealth_shared_utilities::_autosave_stealthcheck;
	level.global_callbacks["_patrol_endon_spotted_flag"] = ::maps\_stealth_shared_utilities::_patrol_endon_spotted_flag;
	level.global_callbacks["_spawner_stealth_default"] = ::maps\_stealth_shared_utilities::_spawner_stealth_default;
}