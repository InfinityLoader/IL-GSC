/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_us_civ_male_yb_d.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 56 ms
 * Timestamp: 10/27/2023 1:36:40 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self setmodel("body_us_civ_male_i");
	self attach("head_us_civ_male_i","",1);
	self.headmodel = "head_us_civ_male_i";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
func_6101()
{
	precachemodel("body_us_civ_male_i");
	precachemodel("head_us_civ_male_i");
}