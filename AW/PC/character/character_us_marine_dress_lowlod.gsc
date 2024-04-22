/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_dress_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 2:02:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marine_dress_body_a_lowlod");
	self attach("marine_dress_head_a_lowlod","",1);
	self.headmodel = "marine_dress_head_a_lowlod";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marine_dress_body_a_lowlod");
	precachemodel("marine_dress_head_a_lowlod");
}