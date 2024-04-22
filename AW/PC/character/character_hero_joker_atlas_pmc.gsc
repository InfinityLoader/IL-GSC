/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_joker_atlas_pmc.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 2:02:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("joker_atlas_pmc");
	self attach("head_hero_joker_goggles","",1);
	self.headmodel = "head_hero_joker_goggles";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("joker_atlas_pmc");
	precachemodel("head_hero_joker_goggles");
}