/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_militia_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_op_militia");
	self attach("head_riot_op_militia", "", 1);
	self.headmodel = "head_riot_op_militia";
	self setviewmodel("viewhands_militia");
	self.voice = "portuguese";
}

precache()
{
	precachemodel("mp_body_riot_op_militia");
	precachemodel("head_riot_op_militia");
	precachemodel("viewhands_militia");
}