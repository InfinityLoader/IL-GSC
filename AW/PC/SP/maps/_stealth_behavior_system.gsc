/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_behavior_system.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:00:47 AM
*******************************************************************/

//Function Number: 1
stealth_behavior_system_main()
{
	stealth_behavior_system_init();
}

//Function Number: 2
stealth_behavior_system_init()
{
	level._stealth.behavior = spawnstruct();
	level._stealth.node_search = spawnstruct();
	level._stealth.behavior.sound = [];
	level._stealth.behavior.sound["huh"] = 0;
	level._stealth.behavior.sound["hmph"] = 0;
	level._stealth.behavior.sound["name"] = 0;
	level._stealth.behavior.sound["wtf"] = 0;
	level._stealth.behavior.sound["spotted"] = [];
	level._stealth.behavior.sound["corpse"] = 0;
	level._stealth.behavior.sound["alert"] = 0;
	level._stealth.behavior.sound["acknowledge"] = 0;
	level._stealth.behavior.sound_reset_time = 3;
}