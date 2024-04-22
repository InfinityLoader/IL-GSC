/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_prison_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 36 ms
 * Timestamp: 4/22/2024 2:18:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("toy_locker_double",::destructible_scripts\toy_locker_double::main);
	destructible_scripts\toy_locker_double::main();
}