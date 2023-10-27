/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_kyra_us_space_a.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 1:38:24 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self setmodel("us_space_a_body");
	self attach("head_kyra_space_a","",1);
	self.headmodel = "head_kyra_space_a";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
func_6101()
{
	precachemodel("us_space_a_body");
	precachemodel("head_kyra_space_a");
}