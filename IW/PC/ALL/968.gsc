/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 968.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:32:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_civ_facility_worker_lt");
	self attach("head_bg_male_06_blast_damage","",1);
	self.var_8C98 = "head_bg_male_06_blast_damage";
	self.var_8C43 = "head_bg_male_06_hair_a_grey";
	self attach(self.var_8C43);
	self.var_1FEC = "generic_human";
	self.var_1FA8 = "civilian";
	self.var_13525 = "unitednations";
	self method_82C6("cloth");
	if(issentient(self))
	{
		self method_8492("locdmgtable/ai_lochit_dmgtable");
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("body_civ_facility_worker_lt");
	precachemodel("head_bg_male_06_blast_damage");
	precachemodel("head_bg_male_06_hair_a_grey");
}