/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1473.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_russian_military_smg_a_airborne");
	lib_0144::func_1E57("alias_so_regular_smg_heads",lib_05C0::main());
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("body_russian_military_smg_a_airborne");
	lib_0144::func_1E56(lib_05C0::main());
}