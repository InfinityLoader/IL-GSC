/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_us_marine_smg_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:57:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_smg_lowlod");
	self attach("marines_head_b_lowlod","",1);
	self.headmodel = "marines_head_b_lowlod";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_smg_lowlod");
	precachemodel("marines_head_b_lowlod");
}