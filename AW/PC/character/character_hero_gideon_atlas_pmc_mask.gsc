/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_gideon_atlas_pmc_mask.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:02:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_body_assault");
	self attach("head_hero_gideon_mask","",1);
	self.headmodel = "head_hero_gideon_mask";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_body_assault");
	precachemodel("head_hero_gideon_mask");
}