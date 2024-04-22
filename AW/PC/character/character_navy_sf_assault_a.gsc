/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_navy_sf_assault_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("navy_body_c");
	self attach("navy_head_a","",1);
	self.headmodel = "navy_head_a";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("navy_body_c");
	precachemodel("navy_head_a");
}