/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1326.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:23 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.adrenalineshotmovespeedscale = 1.1;
	level.var_A0A = 100;
	level.var_A0B = 1.5;
	level.var_A0C = 13.33;
	level.var_A07 = 1;
	self.var_4B50 = 0;
}

//Function Number: 2
func_3662()
{
	maps\mp\_utility::func_870F(level.var_A0A);
	self.var_7AD7 = level.var_A0A;
	self.var_98E1 = level.var_A0B;
	self.var_98E2 = level.var_A0C;
	self.var_4B50 = 1;
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 3
func_2F9E()
{
	maps\mp\_utility::func_870F(0);
	self.var_7AD7 = 0;
	self.var_98E1 = undefined;
	self.var_98E2 = undefined;
	self.var_4B50 = 0;
	maps\mp\gametypes\_weapons::func_A13B();
}