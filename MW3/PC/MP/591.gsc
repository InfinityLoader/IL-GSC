/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 591.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_ally_pmc_sniper");
	self setviewmodel("viewhands_pmc");
	self.voice = "taskforce";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_ally_pmc_sniper");
	precachemodel("viewhands_pmc");
}