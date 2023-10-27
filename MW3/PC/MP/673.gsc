/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 673.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_henchmen_lmg_b");
	lib_0144::func_1E57("alias_henchmen_heads_mp",lib_029B::main());
	self setviewmodel("viewhands_henchmen");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_henchmen_lmg_b");
	lib_0144::func_1E56(lib_029B::main());
	precachemodel("viewhands_henchmen");
}