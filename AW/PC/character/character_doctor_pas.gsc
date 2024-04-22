/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_doctor_pas.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:01:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("dr_pas_body");
	self attach("dr_pas_head","",1);
	self.headmodel = "dr_pas_head";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("dr_pas_body");
	precachemodel("dr_pas_head");
}