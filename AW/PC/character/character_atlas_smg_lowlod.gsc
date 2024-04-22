/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_smg_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_body_all");
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_body_all");
}