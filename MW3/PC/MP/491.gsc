/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 491.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:15:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_sas_urban_assault");
	lib_0144::func_1E57("alias_sas_heads",lib_01EA::main());
	self setviewmodel("viewhands_sas");
	self.voice = "british";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_sas_urban_assault");
	lib_0144::func_1E56(lib_01EA::main());
	precachemodel("viewhands_sas");
}