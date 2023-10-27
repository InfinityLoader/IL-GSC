/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1476.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_russian_military_assault_a_black");
	lib_0144::func_1E57("alias_so_veteran_ar_heads",lib_05C3::main());
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("body_russian_military_assault_a_black");
	lib_0144::func_1E56(lib_05C3::main());
}