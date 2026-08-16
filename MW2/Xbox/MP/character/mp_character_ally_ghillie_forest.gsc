/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_ally_ghillie_forest.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_ally_sniper_ghillie_forest");
	self attach("head_allies_sniper_ghillie_forest", "", 1);
	self.headmodel = "head_allies_sniper_ghillie_forest";
	self setviewmodel("viewhands_ghillie_forest");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_ally_sniper_ghillie_forest");
	precachemodel("head_allies_sniper_ghillie_forest");
	precachemodel("viewhands_ghillie_forest");
}