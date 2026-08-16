/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_us_army_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_us_army_riot");
	codescripts\character::attachhead("alias_us_army_riot", xmodelalias\alias_us_army_riot::main());
	self setviewmodel("viewhands_us_army");
	self.voice = "american";
}

precache()
{
	precachemodel("mp_body_us_army_riot");
	codescripts\character::precachemodelarray(xmodelalias\alias_us_army_riot::main());
	precachemodel("viewhands_us_army");
}