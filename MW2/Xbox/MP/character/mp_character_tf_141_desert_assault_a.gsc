/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_tf_141_desert_assault_a.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_desert_tf141_assault_a");
	codescripts\character::attachhead("alias_tf141_heads_desert", xmodelalias\alias_tf141_heads_desert::main());
	self setviewmodel("viewhands_tf141");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_desert_tf141_assault_a");
	codescripts\character::precachemodelarray(xmodelalias\alias_tf141_heads_desert::main());
	precachemodel("viewhands_tf141");
}