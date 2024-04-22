/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_ar_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 2:02:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_assault_lowlod");
	self attach("marines_head_b_lowlod","",1);
	self.headmodel = "marines_head_b_lowlod";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_assault_lowlod");
	precachemodel("marines_head_b_lowlod");
}