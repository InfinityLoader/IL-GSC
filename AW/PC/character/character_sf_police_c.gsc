/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sf_police_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sf_police_body");
	self attach("sf_police_head_c","",1);
	self.headmodel = "sf_police_head_c";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sf_police_body");
	precachemodel("sf_police_head_c");
}