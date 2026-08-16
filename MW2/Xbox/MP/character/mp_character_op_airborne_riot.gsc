/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_airborne_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_op_airborne");
	self attach("head_riot_op_airborne", "", 1);
	self.headmodel = "head_riot_op_airborne";
	self setviewmodel("viewhands_russian_airborne");
	self.voice = "seal";
}

precache()
{
	precachemodel("mp_body_riot_op_airborne");
	precachemodel("head_riot_op_airborne");
	precachemodel("viewhands_russian_airborne");
}