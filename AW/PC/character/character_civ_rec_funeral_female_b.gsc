/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_female_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_funeral_female_body_b");
	self attach("head_f_gen_afr_waters","",1);
	self.headmodel = "head_f_gen_afr_waters";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_funeral_female_body_b");
	precachemodel("head_f_gen_afr_waters");
}