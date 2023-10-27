/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2095.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_t");
	self attach("head_hero_t","",1);
	self.var_8C98 = "head_hero_t";
	self.var_8C43 = "head_hero_t_helmet";
	self attach(self.var_8C43);
	self.var_A489 = "pack_un_jackal_pilots_zerog";
	self attach(self.var_A489);
	self.var_1FEC = "generic_human";
	self.var_1FA8 = "hero_t";
	self.var_13525 = "unitednationshelmet";
	self method_82C6("vestlight");
	if(issentient(self))
	{
		self method_8492("locdmgtable/ai_lochit_dmgtable");
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_t");
	precachemodel("head_hero_t");
	precachemodel("head_hero_t_helmet");
	precachemodel("pack_un_jackal_pilots_zerog");
}