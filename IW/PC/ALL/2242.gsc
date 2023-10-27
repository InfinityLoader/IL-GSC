/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2242.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\code\character::func_F7A1(lib_0942::main());
	scripts\code\character::func_2483("heads_un_marines_male",lib_09F6::main());
	self.var_A489 = "pack_un_jackal_pilots";
	self attach(self.var_A489);
	self.var_1FEC = "generic_human";
	self.var_1FA8 = "soldier";
	self.var_13525 = "unitednations";
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
	scripts\code\character::func_D811(lib_0942::main());
	scripts\code\character::func_D811(lib_09F6::main());
	precachemodel("pack_un_jackal_pilots");
}