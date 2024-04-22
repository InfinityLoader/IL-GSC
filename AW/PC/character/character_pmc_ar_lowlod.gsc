/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_pmc_ar_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 2:02:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_assault_lowlod");
	self attach("pmc_casual_head_c_lowlod","",1);
	self.headmodel = "pmc_casual_head_c_lowlod";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_assault_lowlod");
	precachemodel("pmc_casual_head_c_lowlod");
}