/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_airborne_sniper.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_op_airborne_sniper");
	self attach("head_op_airborne_sniper", "", 1);
	self.headmodel = "head_op_airborne_sniper";
	self setviewmodel("viewhands_sniper_op_airborne");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_op_airborne_sniper");
	precachemodel("head_op_airborne_sniper");
	precachemodel("viewhands_sniper_op_airborne");
}