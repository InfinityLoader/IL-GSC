/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_navy_sf_assault_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 4/22/2024 2:02:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("navy_body_c");
	self attach("navy_head_c","",1);
	self.headmodel = "navy_head_c";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("navy_body_c");
	precachemodel("navy_head_c");
}