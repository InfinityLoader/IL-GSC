/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_arctic_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_op_arctic");
	self attach("head_riot_op_arctic", "", 1);
	self.headmodel = "head_riot_op_arctic";
	self setviewmodel("viewhands_arctic_opforce");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_riot_op_arctic");
	precachemodel("head_riot_op_arctic");
	precachemodel("viewhands_arctic_opforce");
}