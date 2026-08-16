/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_ally_ghillie_arctic.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_ally_sniper_ghillie_arctic");
	self attach("head_allies_sniper_ghillie_arctic", "", 1);
	self.headmodel = "head_allies_sniper_ghillie_arctic";
	self setviewmodel("viewhands_ghillie_arctic");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_ally_sniper_ghillie_arctic");
	precachemodel("head_allies_sniper_ghillie_arctic");
	precachemodel("viewhands_ghillie_arctic");
}