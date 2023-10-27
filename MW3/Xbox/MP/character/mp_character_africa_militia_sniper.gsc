/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_africa_militia_sniper.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:28:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_africa_militia_sniper");
	self attach("head_opforce_africa_sniper","",1);
	self.headmodel = "head_opforce_africa_sniper";
	self setviewmodel("viewhands_african_militia");
	self.voice = "african";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_africa_militia_sniper");
	precachemodel("head_opforce_africa_sniper");
	precachemodel("viewhands_african_militia");
}