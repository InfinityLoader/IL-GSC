/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 543.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_pmc_africa_assault_aa");
	lib_0144::func_1E57("alias_pmc_africa_heads",lib_021D::main());
	self setviewmodel("viewhands_pmc");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_pmc_africa_assault_aa");
	lib_0144::func_1E56(lib_021D::main());
	precachemodel("viewhands_pmc");
}