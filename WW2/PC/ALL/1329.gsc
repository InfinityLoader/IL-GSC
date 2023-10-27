/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1329.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:23 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.extremeconditioningmovespeedscale = 1.4;
	self.var_4B66 = 0;
}

//Function Number: 2
func_3662()
{
	self.var_4B66 = 1;
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 3
func_2F9E()
{
	self.var_4B66 = 0;
	maps\mp\gametypes\_weapons::func_A13B();
}