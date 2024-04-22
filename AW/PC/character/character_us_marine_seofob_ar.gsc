/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_seofob_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:02:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_assault");
	self attach("marines_head_a","",1);
	self.headmodel = "marines_head_a";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_assault");
	precachemodel("marines_head_a");
}