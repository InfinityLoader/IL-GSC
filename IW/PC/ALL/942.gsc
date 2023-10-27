/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 942.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:32:11 AM
*******************************************************************/

//Function Number: 1
func_63EC(param_00)
{
	return lib_0A0A::func_10067(param_00,0.3);
}

//Function Number: 2
func_63ED(param_00)
{
	return lib_0A0A::func_4746(param_00,"hide");
}

//Function Number: 3
func_63EE(param_00)
{
	return lib_0A0A::func_B4ED(param_00,1);
}

//Function Number: 4
func_63EF(param_00)
{
	return lib_0A0A::func_10067(param_00,0);
}

//Function Number: 5
func_63F0(param_00)
{
	return lib_0A09::func_E478(param_00,isdefined(self.var_1491.var_2411) && self.var_1491.var_2411 && scripts\anim\utility_common::func_3907());
}

//Function Number: 6
func_63F1(param_00)
{
	return lib_0A09::func_E478(param_00,scripts\anim\utility_common::func_3918());
}

//Function Number: 7
func_63F2(param_00)
{
	return lib_0A09::func_9FEE(param_00,level.var_11813);
}

//Function Number: 8
func_63F3(param_00)
{
	return lib_0A09::func_9309(param_00,level.player);
}

//Function Number: 9
func_63F4(param_00)
{
	return lib_0A0A::func_10067(param_00,0.1);
}

//Function Number: 10
func_63F5(param_00)
{
	return lib_0A09::func_E478(param_00,isdefined(self.var_190C) || scripts\anim\utility_common::func_6561());
}

//Function Number: 11
func_63F6(param_00)
{
	return lib_0A12::func_9ED9(param_00,"continue");
}

//Function Number: 12
func_63F7(param_00)
{
	return lib_0A12::func_8471(param_00,self.var_15C);
}

//Function Number: 13
func_63F8(param_00)
{
	return lib_0A12::func_9ED9(param_00,"stop");
}

//Function Number: 14
func_63F9(param_00)
{
	return lib_0A12::func_8471(param_00,0);
}

//Function Number: 15
func_2AD0()
{
	if(isdefined(level.var_119E["enemy_combatant"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::lib_0A08::func_103F5;
	var_00.var_1581[1] = ::lib_0A10::func_9898;
	var_00.var_1581[2] = ::lib_0A08::func_97EC;
	var_00.var_1581[3] = ::lib_0A06::func_12E90;
	var_00.var_1581[4] = ::lib_0A09::func_9307;
	var_00.var_1581[5] = ::lib_0A06::func_93B6;
	var_00.var_1581[6] = ::lib_0A06::func_2753;
	var_00.var_1581[7] = ::lib_0A06::func_1384E;
	var_00.var_1581[8] = ::lib_0A06::func_275A;
	var_00.var_1581[9] = ::lib_0A06::func_24D4;
	var_00.var_1581[10] = ::lib_0A0A::func_41A3;
	var_00.var_1581[11] = ::lib_0A06::func_E84D;
	var_00.var_1581[12] = ::lib_0A06::func_E84E;
	var_00.var_1581[13] = ::lib_0A06::func_E84F;
	var_00.var_1581[14] = ::lib_0A0C::func_10020;
	var_00.var_1581[15] = ::lib_0A0C::func_85D3;
	var_00.var_1581[16] = ::lib_0A0C::func_85D4;
	var_00.var_1581[17] = ::lib_0A0C::func_1001E;
	var_00.var_1581[18] = ::lib_0A0C::func_85AF;
	var_00.var_1581[19] = ::lib_0A0C::func_85B0;
	var_00.var_1581[20] = ::lib_0A0C::func_85B1;
	var_00.var_1581[21] = ::lib_0A17::func_9308;
	var_00.var_1581[22] = ::lib_0A17::func_12F2D;
	var_00.var_1581[23] = ::lib_0A06::func_9E40;
	var_00.var_1581[24] = ::lib_0A06::func_12F64;
	var_00.var_1581[25] = ::lib_0A06::func_12F1D;
	var_00.var_1581[26] = ::lib_0A06::func_12E93;
	var_00.var_1581[27] = ::lib_0A19::func_12F5C;
	var_00.var_1581[28] = ::lib_0A0A::func_12E92;
	var_00.var_1581[29] = ::lib_0A0A::func_9E43;
	var_00.var_1581[30] = ::lib_0A0A::func_97EF;
	var_00.var_1581[31] = ::lib_0A0A::func_FFE1;
	var_00.var_1581[32] = ::lib_0A0A::func_12DDF;
	var_00.var_1581[33] = ::lib_0A06::func_B4EB;
	var_00.var_1581[34] = ::lib_0A06::func_FE88;
	var_00.var_1581[35] = ::lib_0A06::func_FE6E;
	var_00.var_1581[36] = ::lib_0A06::func_FE83;
	var_00.var_1581[37] = ::func_63EC;
	var_00.var_1581[38] = ::lib_0A0A::func_4742;
	var_00.var_1581[39] = ::lib_0A0A::func_98C1;
	var_00.var_1581[40] = ::lib_0A0A::func_116FD;
	var_00.var_1581[41] = ::lib_0A09::func_E475;
	var_00.var_1581[42] = ::func_63ED;
	var_00.var_1581[43] = ::lib_0A0A::func_BDF3;
	var_00.var_1581[44] = ::lib_0A0A::func_4712;
	var_00.var_1581[45] = ::lib_0A0A::func_97E4;
	var_00.var_1581[46] = ::lib_0A0A::func_116F1;
	var_00.var_1581[47] = ::lib_0A09::func_E470;
	var_00.var_1581[48] = ::func_63EE;
	var_00.var_1581[49] = ::lib_0A0A::func_2546;
	var_00.var_1581[50] = ::func_63EF;
	var_00.var_1581[51] = ::lib_0A0A::func_9D97;
	var_00.var_1581[52] = ::lib_0A0A::func_4721;
	var_00.var_1581[53] = ::lib_0A0A::func_9814;
	var_00.var_1581[54] = ::lib_0A09::func_4347;
	var_00.var_1581[55] = ::lib_0A0A::func_B4ED;
	var_00.var_1581[56] = ::lib_0A0A::func_B019;
	var_00.var_1581[57] = ::func_63F0;
	var_00.var_1581[58] = ::lib_0A0A::func_9DDA;
	var_00.var_1581[59] = ::func_63F1;
	var_00.var_1581[60] = ::func_63F2;
	var_00.var_1581[61] = ::func_63F3;
	var_00.var_1581[62] = ::lib_0A0A::func_474F;
	var_00.var_1581[63] = ::lib_0A0A::func_98DB;
	var_00.var_1581[64] = ::lib_0A0A::func_11700;
	var_00.var_1581[65] = ::lib_0A0A::func_FFCC;
	var_00.var_1581[66] = ::lib_0A0A::func_4711;
	var_00.var_1581[67] = ::lib_0A0A::func_116F0;
	var_00.var_1581[68] = ::lib_0A0A::func_100AD;
	var_00.var_1581[69] = ::func_63F4;
	var_00.var_1581[70] = ::lib_0A0A::func_4726;
	var_00.var_1581[71] = ::lib_0A0A::func_9894;
	var_00.var_1581[72] = ::lib_0A0A::func_116F9;
	var_00.var_1581[73] = ::lib_0A0A::func_9D71;
	var_00.var_1581[74] = ::lib_0A0A::func_4749;
	var_00.var_1581[75] = ::lib_0A0A::func_471E;
	var_00.var_1581[76] = ::lib_0A0A::func_9803;
	var_00.var_1581[77] = ::lib_0A0A::func_116F4;
	var_00.var_1581[78] = ::func_63F5;
	var_00.var_1581[79] = ::lib_0A0A::func_9D40;
	var_00.var_1581[80] = ::lib_0A18::func_8BF7;
	var_00.var_1581[81] = ::lib_0A0A::func_10038;
	var_00.var_1581[82] = ::lib_0A0A::func_38CB;
	var_00.var_1581[83] = ::lib_0A0A::func_38E8;
	var_00.var_1581[84] = ::lib_0A0A::func_473E;
	var_00.var_1581[85] = ::lib_0A0A::func_116FC;
	var_00.var_1581[86] = ::lib_0A0A::func_453E;
	var_00.var_1581[87] = ::lib_0A06::func_12F28;
	var_00.var_1581[88] = ::lib_0A0E::func_10039;
	var_00.var_1581[89] = ::lib_0A0E::func_B599;
	var_00.var_1581[90] = ::lib_0A0E::func_B5F0;
	var_00.var_1581[91] = ::lib_0A0E::func_B5E8;
	var_00.var_1581[92] = ::lib_0A0E::func_B5EE;
	var_00.var_1581[93] = ::lib_0A0E::func_5903;
	var_00.var_1581[94] = ::lib_0A0E::func_9896;
	var_00.var_1581[95] = ::lib_0A0E::func_41C6;
	var_00.var_1581[96] = ::lib_0A06::func_8C24;
	var_00.var_1581[97] = ::lib_0A18::func_3929;
	var_00.var_1581[98] = ::lib_0A18::func_1182E;
	var_00.var_1581[99] = ::lib_0A18::func_1182C;
	var_00.var_1581[100] = ::lib_0A18::func_1182D;
	var_00.var_1581[101] = ::lib_0A06::func_8BF6;
	var_00.var_1581[102] = ::lib_0A18::func_3928;
	var_00.var_1581[103] = ::lib_0A18::func_11812;
	var_00.var_1581[104] = ::lib_0A18::func_1180F;
	var_00.var_1581[105] = ::lib_0A18::func_11811;
	var_00.var_1581[106] = ::lib_0A06::func_43EB;
	var_00.var_1581[107] = ::lib_0A06::func_DF56;
	var_00.var_1581[108] = ::lib_0A06::func_DF53;
	var_00.var_1581[109] = ::lib_0A06::func_DF55;
	var_00.var_1581[110] = ::lib_0A06::func_8BC6;
	var_00.var_1581[111] = ::lib_0A06::func_2542;
	var_00.var_1581[112] = ::lib_0A06::func_2544;
	var_00.var_1581[113] = ::lib_0A06::func_2545;
	var_00.var_1581[114] = ::lib_0A06::func_12E91;
	var_00.var_1581[115] = ::lib_0A12::func_C565;
	var_00.var_1581[116] = ::lib_0A12::func_F7B2;
	var_00.var_1581[117] = ::func_63F6;
	var_00.var_1581[118] = ::func_63F7;
	var_00.var_1581[119] = ::func_63F8;
	var_00.var_1581[120] = ::func_63F9;
	var_00.var_1581[121] = ::lib_0A12::func_D4A0;
	var_00.var_1581[122] = ::lib_0A09::func_E477;
	var_00.var_1581[123] = ::lib_09FC::func_57DF;
	level.var_119E["enemy_combatant"] = var_00;
}

//Function Number: 16
func_DEE8()
{
	func_2AD0();
	function_02D8("enemy_combatant");
}