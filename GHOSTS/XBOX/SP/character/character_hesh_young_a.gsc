/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_hesh_young_a.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 10/27/2023 1:38:24 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self setmodel("body_hesh_young_a");
	self attach("head_hesh_young_x","",1);
	self.headmodel = "head_hesh_young_x";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
func_6101()
{
	precachemodel("body_hesh_young_a");
	precachemodel("head_hesh_young_x");
}