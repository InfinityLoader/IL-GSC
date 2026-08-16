/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_seal_udt_sniper.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_seal_udt_sniper");
	self attach("head_allies_seal_udt_sniper", "", 1);
	self.headmodel = "head_allies_seal_udt_sniper";
	self setviewmodel("viewhands_sniper_udt");
	self.voice = "seal";
}

precache()
{
	precachemodel("mp_body_seal_udt_sniper");
	precachemodel("head_allies_seal_udt_sniper");
	precachemodel("viewhands_sniper_udt");
}