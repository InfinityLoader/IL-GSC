/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 937.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:32:10 AM
*******************************************************************/

//Function Number: 1
func_3387(param_00)
{
	return lib_0A06::func_9E8B(param_00,0);
}

//Function Number: 2
func_3388(param_00)
{
	return lib_0A09::func_13157(param_00,[distance(self.origin,self.var_10C.origin),512,1024]);
}

//Function Number: 3
func_2AD0()
{
	if(isdefined(level.var_119E["c6_mp"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::lib_0A14::func_98C5;
	var_00.var_1581[1] = ::lib_0A0F::func_9898;
	var_00.var_1581[2] = ::lib_0A07::func_97ED;
	var_00.var_1581[3] = ::lib_0A06::func_12E90;
	var_00.var_1581[4] = ::lib_0BFA::func_3E49;
	var_00.var_1581[5] = ::lib_0BFA::func_3DE6;
	var_00.var_1581[6] = ::lib_0A06::func_9E40;
	var_00.var_1581[7] = ::lib_0BFA::func_12F35;
	var_00.var_1581[8] = ::lib_0A19::func_12F5C;
	var_00.var_1581[9] = ::lib_0A06::func_12F28;
	var_00.var_1581[10] = ::lib_0BFA::func_930A;
	var_00.var_1581[11] = ::lib_0BFA::func_930D;
	var_00.var_1581[12] = ::lib_0BFA::func_5813;
	var_00.var_1581[13] = ::lib_0BFA::func_97FA;
	var_00.var_1581[14] = ::lib_0BFA::func_116F3;
	var_00.var_1581[15] = ::lib_0A06::func_FE88;
	var_00.var_1581[16] = ::lib_0A06::func_FE6E;
	var_00.var_1581[17] = ::lib_0A06::func_FE83;
	var_00.var_1581[18] = ::lib_0A09::func_E475;
	var_00.var_1581[19] = ::lib_0A0E::func_10039;
	var_00.var_1581[20] = ::lib_0A0E::func_B599;
	var_00.var_1581[21] = ::lib_0A0E::func_B5F0;
	var_00.var_1581[22] = ::lib_0A0E::func_B5E8;
	var_00.var_1581[23] = ::lib_0A0E::func_B5EE;
	var_00.var_1581[24] = ::lib_0A0E::func_5903;
	var_00.var_1581[25] = ::lib_0A0E::func_9896;
	var_00.var_1581[26] = ::lib_0A0E::func_41C6;
	var_00.var_1581[27] = ::lib_0A06::func_8BF6;
	var_00.var_1581[28] = ::lib_0A18::func_8BF7;
	var_00.var_1581[29] = ::lib_0A06::func_B4EB;
	var_00.var_1581[30] = ::lib_0A18::func_3928;
	var_00.var_1581[31] = ::lib_0A18::func_11812;
	var_00.var_1581[32] = ::lib_0A18::func_1180F;
	var_00.var_1581[33] = ::lib_0A18::func_11811;
	var_00.var_1581[34] = ::lib_0A06::func_8BC6;
	var_00.var_1581[35] = ::func_3387;
	var_00.var_1581[36] = ::func_3388;
	var_00.var_1581[37] = ::lib_0A06::func_DF56;
	var_00.var_1581[38] = ::lib_0A06::func_DF53;
	var_00.var_1581[39] = ::lib_0A06::func_DF55;
	var_00.var_1581[40] = ::lib_0A06::func_8C0B;
	var_00.var_1581[41] = ::lib_0BFA::func_3401;
	level.var_119E["c6_mp"] = var_00;
}

//Function Number: 4
func_DEE8()
{
	func_2AD0();
	function_02D8("c6_mp");
}