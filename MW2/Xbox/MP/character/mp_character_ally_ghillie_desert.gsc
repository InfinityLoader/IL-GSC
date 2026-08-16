/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_ally_ghillie_desert.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_ally_sniper_ghillie_desert");
	self attach("head_allies_sniper_ghillie_desert", "", 1);
	self.headmodel = "head_allies_sniper_ghillie_desert";
	self setviewmodel("viewhands_ghillie_desert");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_ally_sniper_ghillie_desert");
	precachemodel("head_allies_sniper_ghillie_desert");
	precachemodel("viewhands_ghillie_desert");
}