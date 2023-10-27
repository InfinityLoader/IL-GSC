/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1546.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_gign_paris_assault");
	lib_0144::func_1E57("alias_gign_heads",lib_053F::main());
	self.voice = "french";
}

//Function Number: 2
precache()
{
	precachemodel("body_gign_paris_assault");
	lib_0144::func_1E56(lib_053F::main());
}