/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_smg_seointro.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:02:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_assault_drop_pod");
	self attach("marines_head_a","",1);
	self.headmodel = "marines_head_a";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_assault_drop_pod");
	precachemodel("marines_head_a");
}