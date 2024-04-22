/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_female_dead_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:01:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_female_dead_body_a");
	self attach("head_ilana_civilian","",1);
	self.headmodel = "head_ilana_civilian";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_female_dead_body_a");
	precachemodel("head_ilana_civilian");
}