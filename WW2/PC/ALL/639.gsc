/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 639.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:08 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	self setmodel("mp_sentinel_body_nojet_b");
	lib_0281::func_114A("alias_mp_sentinel_heads",lib_03D7::func_F9());
	self setviewmodel("viewhands_s1_pmc");
	self.var_A600 = "american";
	self method_83E1("vestlight");
}

//Function Number: 2
func_0136()
{
	precachemodel("mp_sentinel_body_nojet_b");
	lib_0281::func_7653(lib_03D7::func_F9());
	precachemodel("viewhands_s1_pmc");
}