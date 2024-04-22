/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_african_male_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_african_male_body_b");
	self attach("head_male_sp_gartei","",1);
	self.headmodel = "head_male_sp_gartei";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_african_male_body_b");
	precachemodel("head_male_sp_gartei");
}