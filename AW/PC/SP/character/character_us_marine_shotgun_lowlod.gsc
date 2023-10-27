/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_us_marine_shotgun_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:57:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_shotgun_lowlod");
	self attach("marines_head_b_lowlod","",1);
	self.headmodel = "marines_head_b_lowlod";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_shotgun_lowlod");
	precachemodel("marines_head_b_lowlod");
}