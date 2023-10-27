/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1332.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:24 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	self.var_4B91 = 0;
	level.var_83C8 = 6;
	level.var_83C9 = 0.05;
	level.var_83C7 = 1.25;
	level.var_83CA = 4;
}

//Function Number: 2
func_3662()
{
	maps\mp\_utility::func_47A2("specialty_finalstand");
	self.var_4B91 = 1;
	self notify("self_revive");
}

//Function Number: 3
func_2F9E()
{
	maps\mp\_utility::func_735("specialty_finalstand");
	self.var_4B91 = 0;
	self waittill("revive");
	self.var_98E2 = undefined;
}