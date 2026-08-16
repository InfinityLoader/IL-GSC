/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_udt_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_udt");
	self attach("head_riot_udt", "", 1);
	self.headmodel = "head_riot_udt";
	self setviewmodel("viewhands_udt");
	self.voice = "seal";
}

precache()
{
	precachemodel("mp_body_riot_udt");
	precachemodel("head_riot_udt");
	precachemodel("viewhands_udt");
}