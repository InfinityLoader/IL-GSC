/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_knox_sentinel_udtgr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:02:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_cormack_sentinel_udt_grapple");
	self attach("head_hero_knox_sentinel_halo_blend","",1);
	self.headmodel = "head_hero_knox_sentinel_halo_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_cormack_sentinel_udt_grapple");
	precachemodel("head_hero_knox_sentinel_halo_blend");
}