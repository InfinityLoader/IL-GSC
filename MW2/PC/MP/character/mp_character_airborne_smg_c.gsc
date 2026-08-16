/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_airborne_smg_c.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_airborne_smg_c");
	codescripts\character::attachhead("alias_airborne_heads", xmodelalias\alias_airborne_heads::main());
	self setviewmodel("viewhands_russian_airborne");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_airborne_smg_c");
	codescripts\character::precachemodelarray(xmodelalias\alias_airborne_heads::main());
	precachemodel("viewhands_russian_airborne");
}