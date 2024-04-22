/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_ie_doctor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_g");
	self attach("dr_pas_head","",1);
	self.headmodel = "dr_pas_head";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_g");
	precachemodel("dr_pas_head");
}