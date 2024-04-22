/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_african_male_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:01:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_african_male_body_c");
	self attach("head_male_mp_brickerson","",1);
	self.headmodel = "head_male_mp_brickerson";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_african_male_body_c");
	precachemodel("head_male_mp_brickerson");
}