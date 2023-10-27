/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sdf_army_heavy_3_snow_iced.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 105 ms
 * Timestamp: 10/26/2023 11:58:25 PM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sdf_army_heavy_3_snow");
	scripts\code\character::func_2483("alias_heads_sdf_army",lib_09C1::main());
	self.var_8C43 = "helmet_sdf_army_heavy_3_snow";
	self attach(self.var_8C43);
	self.var_A489 = "sdf_army_boost_pack_zerog";
	self attach(self.var_A489);
	self.var_1FEC = "generic_human";
	self.var_1FA8 = "soldier";
	self.var_13525 = "setdef";
	self method_82C6("vestheavy");
	if(issentient(self))
	{
		self method_8492("locdmgtable/ai_lochit_dmgtable");
	}

	self.var_8E1A = level.var_7649["iw7/core/human/helmet_sdf_army_broken"];
	if(issentient(self))
	{
		self method_849A();
		var_00 = [];
		var_00["helmet"] = spawnstruct();
		var_00["helmet"].var_B4B8 = 9999;
		var_00["helmet"].var_C92D = [];
		var_00["helmet"].var_C92D["helmet"] = spawnstruct();
		var_00["helmet"].var_C92D["helmet"].maxhealth = 50;
		var_00["helmet"].var_C92D["helmet"].var_9038 = "helmet";
		var_00["helmet"].var_C92D["helmet"].var_4D6F = "j_helmet";
		self method_849B("helmet",9999,"helmet",50,"helmet","j_helmet");
		self.var_4D5D = var_00;
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("body_sdf_army_heavy_3_snow");
	scripts\code\character::func_D811(lib_09C1::main());
	precachemodel("helmet_sdf_army_heavy_3_snow");
	precachemodel("sdf_army_boost_pack_zerog");
	level.var_7649["iw7/core/human/helmet_sdf_army_broken"] = loadfx("vfx/iw7/core/human/helmet_sdf_army_broken.vfx");
}