/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 638.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:08 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	self setmodel("mp_body_cloak_test");
	self attach("mp_head_cloak_test","",1);
	self.var_4BF2 = "mp_head_cloak_test";
	self setviewmodel("mp_viewhands_cloak_test");
	self.var_A600 = "american";
	self method_83E1("vestlight");
}

//Function Number: 2
func_0136()
{
	precachemodel("mp_body_cloak_test");
	precachemodel("mp_head_cloak_test");
	precachemodel("mp_viewhands_cloak_test");
}