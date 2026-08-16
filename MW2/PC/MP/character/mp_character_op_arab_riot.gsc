/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_arab_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_op_arab");
	self attach("head_riot_op_arab", "", 1);
	self.headmodel = "head_riot_op_arab";
	self setviewmodel("viewhands_militia");
	self.voice = "arab";
}

precache()
{
	precachemodel("mp_body_riot_op_arab");
	precachemodel("head_riot_op_arab");
	precachemodel("viewhands_militia");
}