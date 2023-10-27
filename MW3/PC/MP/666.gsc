/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 666.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_africa_militia_sniper");
	self attach("head_opforce_africa_sniper","",1);
	self.var_1E5A = "head_opforce_africa_sniper";
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