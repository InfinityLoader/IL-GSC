/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_ilana_atlas_pmc.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("ilana_atlas_pmc");
	self attach("head_hero_ilana_blend","",1);
	self.headmodel = "head_hero_ilana_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("ilana_atlas_pmc");
	precachemodel("head_hero_ilana_blend");
}