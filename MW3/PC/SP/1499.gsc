/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1499.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:43 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_chemwar_russian_assault_dd");
	lib_0144::func_1E57("alias_chemwar_russian_heads_so",lib_05D9::main());
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("body_chemwar_russian_assault_dd");
	lib_0144::func_1E56(lib_05D9::main());
}