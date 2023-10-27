/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 451.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:15:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_delta_elite_assault_aa");
	lib_0144::func_1E57("alias_delta_elite_heads",lib_019D::main());
	self setviewmodel("viewhands_delta");
	self.voice = "delta";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_delta_elite_assault_aa");
	lib_0144::func_1E56(lib_019D::main());
	precachemodel("viewhands_delta");
}