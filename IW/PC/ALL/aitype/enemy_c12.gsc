/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_c12.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 133 ms
 * Timestamp: 10/26/2023 11:58:15 PM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_17DB = "ai\\c12_assets.csv";
	self.team = "axis";
	self.type = "human";
	self.var_12BA4 = "C12";
	self.var_111A4 = "C12";
	self.accuracy = 0.2;
	self.health = 10000;
	self.var_166 = "";
	self.var_162 = 0;
	self.var_F0C4 = "iw7_c12gatling";
	self.var_101B4 = "";
	self.var_2A80 = "c12";
	self.var_1FA9 = "C12";
	if(isai(self))
	{
		self method_82DC(256,0);
		self method_82DB(768,1024);
	}

	self.var_394 = "iw7_c12rocket";
	lib_04B2::main();
}

//Function Number: 2
spawner()
{
	self method_833A("axis");
}

//Function Number: 3
precache()
{
	lib_04B2::precache();
	lib_0A02::init();
	lib_09FD::func_3508();
	lib_03AC::func_DEE8();
	lib_0C48::func_2371();
	precacheitem("iw7_c12rocket");
	precacheitem("iw7_c12gatling");
}