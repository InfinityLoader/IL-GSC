/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_tf141_desert_riot.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_riot_tf141_desert");
	self attach("head_riot_tf141_desert", "", 1);
	self.headmodel = "head_riot_tf141_desert";
	self setviewmodel("viewhands_tf141");
	self.voice = "taskforce";
}

precache()
{
	precachemodel("mp_body_riot_tf141_desert");
	precachemodel("head_riot_tf141_desert");
	precachemodel("viewhands_tf141");
}