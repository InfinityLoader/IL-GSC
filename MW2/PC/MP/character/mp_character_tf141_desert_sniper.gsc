/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_tf141_desert_sniper.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_tf141_desert_sniper");
	self attach("head_allies_tf141_desert_sniper", "", 1);
	self.headmodel = "head_allies_tf141_desert_sniper";
	self setviewmodel("viewhands_sniper_tf141_desert");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_tf141_desert_sniper");
	precachemodel("head_allies_tf141_desert_sniper");
	precachemodel("viewhands_sniper_tf141_desert");
}