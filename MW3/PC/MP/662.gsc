/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 662.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_africa_militia_shotgun_b");
	lib_0144::func_1E57("alias_africa_militia_heads_mp",lib_028F::main());
	self setviewmodel("viewhands_african_militia");
	self.voice = "african";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_africa_militia_shotgun_b");
	lib_0144::func_1E56(lib_028F::main());
	precachemodel("viewhands_african_militia");
}