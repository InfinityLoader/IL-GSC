/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_us_army_sniper.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_army_sniper");
	self attach("head_allies_us_army_sniper", "", 1);
	self.headmodel = "head_allies_us_army_sniper";
	self setviewmodel("viewhands_sniper_us_army");
	self.voice = "american";
}

precache()
{
	precachemodel("mp_body_army_sniper");
	precachemodel("head_allies_us_army_sniper");
	precachemodel("viewhands_sniper_us_army");
}