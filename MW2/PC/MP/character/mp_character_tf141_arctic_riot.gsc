/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_tf141_arctic_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_tf141_arctic");
	self attach("head_riot_tf141_arctic", "", 1);
	self.headmodel = "head_riot_tf141_arctic";
	self setviewmodel("viewhands_arctic");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_riot_tf141_arctic");
	precachemodel("head_riot_tf141_arctic");
	precachemodel("viewhands_arctic");
}