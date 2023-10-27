/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 599.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_assault_a_arctic");
	lib_0144::func_1E57("alias_russian_military_arctic_heads",lib_0256::main());
	self setviewmodel("viewhands_russian_d");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_assault_a_arctic");
	lib_0144::func_1E56(lib_0256::main());
	precachemodel("viewhands_russian_d");
}