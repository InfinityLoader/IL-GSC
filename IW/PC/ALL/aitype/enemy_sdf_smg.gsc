/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_sdf_smg.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 136 ms
 * Timestamp: 10/26/2023 11:58:17 PM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_17DB = "";
	self.team = "axis";
	self.type = "human";
	self.var_12BA4 = "soldier";
	self.var_111A4 = "regular";
	self.accuracy = 0.2;
	self.health = 150;
	self.var_166 = lib_0A2F::func_7BEB();
	self.var_162 = 1;
	self.var_F0C4 = "";
	self.var_101B4 = lib_0A2F::func_7BEC("pistol");
	self.var_2A80 = "enemy_combatant";
	self.var_1FA9 = "soldier";
	if(isai(self))
	{
		self method_82DC(256,0);
		self method_82DB(768,1024);
	}

	self.var_394 = lib_0A2F::func_7BEC("smg");
	var_00 = undefined;
	var_01 = ["character_sdf_army_ftl_1","character_sdf_army_light_1","character_sdf_army_heavy_4"];
	switch(scripts\code\character::func_7BE5(3,var_00,var_01))
	{
		case 0:
			lib_04D6::main();
			break;

		case 1:
			lib_04FF::main();
			break;

		case 2:
			lib_04EE::main();
			break;
	}
}

//Function Number: 2
spawner()
{
	self method_833A("axis");
}

//Function Number: 3
precache()
{
	lib_04D6::precache();
	lib_04FF::precache();
	lib_04EE::precache();
	lib_0A02::init();
	lib_09FD::func_103F2();
	lib_03AE::func_DEE8();
	lib_0C69::func_2371();
}