/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civilian_india_male_d.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_india_male_b_alt");
	self attach("head_india_male_d","",1);
	self.headmodel = "head_india_male_d";
	self.voice = "arab";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_india_male_b_alt");
	precachemodel("head_india_male_d");
}