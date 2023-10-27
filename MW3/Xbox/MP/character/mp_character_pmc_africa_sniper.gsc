/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_pmc_africa_sniper.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 2:28:19 AM
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