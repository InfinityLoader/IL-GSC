/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_tf_141_arctic_smg.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_tf141_smg");
	codescripts\character::attachhead("alias_tf141_heads_arctic", xmodelalias\alias_tf141_heads_arctic::main());
	self setviewmodel("viewhands_tf141");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_tf141_smg");
	codescripts\character::precachemodelarray(xmodelalias\alias_tf141_heads_arctic::main());
	precachemodel("viewhands_tf141");
}