/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2092.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_un_jackal_pilots");
	scripts\code\character::func_2483("alias_heads_un_jackal_pilots_pt2",lib_09CB::main());
	self.var_8C43 = "helmet_un_jackal_pilots_generic";
	self attach(self.var_8C43);
	self.var_A489 = "pack_un_jackal_pilots";
	self attach(self.var_A489);
	self.var_1FEC = "generic_human";
	self.var_1FA8 = "soldier";
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
	precachemodel("body_un_jackal_pilots");
	scripts\code\character::func_D811(lib_09CB::main());
	precachemodel("helmet_un_jackal_pilots_generic");
	precachemodel("pack_un_jackal_pilots");
}