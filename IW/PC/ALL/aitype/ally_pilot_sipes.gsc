/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_pilot_sipes.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 140 ms
 * Timestamp: 10/26/2023 11:58:14 PM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_17DB = "";
	self.team = "allies";
	self.type = "human";
	self.var_12BA4 = "soldier";
	self.var_111A4 = "regular";
	self.accuracy = 0.2;
	self.health = 150;
	self.var_166 = lib_0A2F::func_7BEB();
	self.var_162 = 1;
	self.var_F0C4 = "iw7_fhr+reflexsmg+silencersmg";
	self.var_101B4 = "";
	self.var_2A80 = "enemy_combatant";
	self.var_1FA9 = "soldier";
	if(isai(self))
	{
		self method_82DC(256,0);
		self method_82DB(768,1024);
	}

	self.var_394 = "iw7_fhr+reflexsmg+silencersmg";
	lib_082E::main();
}

//Function Number: 2
spawner()
{
	self method_833A("allies");
}

//Function Number: 3
precache()
{
	lib_082E::precache();
	lib_0A02::init();
	lib_09FD::func_103F2();
	lib_03AE::func_DEE8();
	lib_0C69::func_2371();
	precacheitem("iw7_fhr+reflexsmg+silencersmg");
	precacheitem("iw7_fhr+reflexsmg+silencersmg");
}