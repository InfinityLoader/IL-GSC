/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_elias_e.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 1:38:23 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self setmodel("body_elias_e");
	self attach("head_elias_x","",1);
	self.headmodel = "head_elias_x";
	self.voice = "american";
	self setclothtype("cloth");
}

//Function Number: 2
func_6101()
{
	precachemodel("body_elias_e");
	precachemodel("head_elias_x");
}