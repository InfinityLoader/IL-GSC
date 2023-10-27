/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2262.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sdf_army_light_2_kotch");
	self attach("head_sdf_kotch_hqss","",1);
	self.var_8C98 = "head_sdf_kotch_hqss";
	self.var_8C43 = "helmet_sdf_army_kotch";
	self attach(self.var_8C43);
	self.var_A489 = "sdf_army_boost_pack_zerog_snow";
	self attach(self.var_A489);
	self.var_1FEC = "generic_human";
	self.var_1FA8 = "soldier";
	self.var_13525 = "setdef";
	self method_82C6("vestheavy");
	if(issentient(self))
	{
		self method_8492("locdmgtable/ai_lochit_dmgtable");
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("body_sdf_army_light_2_kotch");
	precachemodel("head_sdf_kotch_hqss");
	precachemodel("helmet_sdf_army_kotch");
	precachemodel("sdf_army_boost_pack_zerog_snow");
}