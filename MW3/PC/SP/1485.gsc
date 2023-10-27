/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1485.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_chemwar_russian_assault_b");
	lib_0144::func_1E57("alias_chemwar_russian_heads_masked",lib_05CB::main());
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("body_chemwar_russian_assault_b");
	lib_0144::func_1E56(lib_05CB::main());
}