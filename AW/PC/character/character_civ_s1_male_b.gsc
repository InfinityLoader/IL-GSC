/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:01:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_b");
	self attach("civ_urban_male_head_kanik","",1);
	self.headmodel = "civ_urban_male_head_kanik";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_b");
	precachemodel("civ_urban_male_head_kanik");
}