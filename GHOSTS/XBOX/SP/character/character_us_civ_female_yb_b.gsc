/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_us_civ_female_yb_b.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:38:25 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self setmodel("body_us_civ_female_c");
	self attach("head_us_civ_female_c","",1);
	self.headmodel = "head_us_civ_female_c";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
func_6101()
{
	precachemodel("body_us_civ_female_c");
	precachemodel("head_us_civ_female_c");
}