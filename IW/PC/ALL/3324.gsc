/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3324.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:32 AM
*******************************************************************/

//Function Number: 1
func_95C1()
{
	self.var_CA2F = [];
	self.var_CA2F["health"] = lib_0CFD::func_96C2();
	self.var_CA2F["damagemod"] = lib_0CFD::func_96BF();
	self.var_CA2F["medic"] = lib_0CFD::func_96C8();
	self.var_CA2F["rigger"] = lib_0CFD::func_96CB();
	self.var_CA2F["robotics"] = lib_0CFD::func_96CC();
	self.var_CA2F["demolition"] = lib_0CFD::func_96C0();
	self.var_CA2F["gunslinger"] = lib_0CFD::func_96C1();
	self.var_CA2F["hybrid"] = lib_0CFD::func_96C3();
	self.var_CA2F["pistol"] = lib_0CFD::func_96CA();
	self.var_CA2F["pistol"] = lib_0CFD::func_96CA();
	self.var_CA2F["pistol"] = lib_0CFD::func_96CA();
	self.var_CA2F["pistol"] = lib_0CFD::func_96CA();
	self.var_CA2F["none"] = lib_0CFD::func_96C9();
}

//Function Number: 2
func_CA3A()
{
	return self.var_CA2F["health"].var_B5AF;
}

//Function Number: 3
func_CA39()
{
	return self.var_CA2F["health"].var_B43C;
}

//Function Number: 4
func_CA32()
{
	return self.var_CA2F["damagemod"].var_3237;
}

//Function Number: 5
func_CA41()
{
	return self.var_CA2F["medic"].var_E4A5;
}

//Function Number: 6
func_CA37()
{
	return self.var_CA2F["medic"].var_76AC;
}

//Function Number: 7
func_CA3B()
{
	return self.var_CA2F["medic"].var_BC6F;
}

//Function Number: 8
func_CA40()
{
	return self.var_CA2F["medic"].var_E496;
}

//Function Number: 9
func_CA34()
{
	return self.var_CA2F["rigger"].var_5B99;
}

//Function Number: 10
func_CA35()
{
	return self.var_CA2F["rigger"].var_5BB8;
}

//Function Number: 11
func_CA42()
{
	return self.var_CA2F["rigger"].var_1269D;
}

//Function Number: 12
func_CA43()
{
	return self.var_CA2F["rigger"].var_1269E;
}

//Function Number: 13
func_CA44()
{
	return self.var_CA2F["rigger"].var_1269F;
}

//Function Number: 14
func_CA33()
{
	return self.var_CA2F["rigger"].var_4B35;
}

//Function Number: 15
func_CA3F()
{
	return self.var_CA2F["rigger"].var_E18F;
}

//Function Number: 16
func_CA30()
{
	return self.var_CA2F["robotics"].var_2180;
}

//Function Number: 17
func_CA31()
{
	return self.var_CA2F["robotics"].var_2181;
}

//Function Number: 18
func_CA36()
{
	return self.var_CA2F["demolition"].var_69F9;
}

//Function Number: 19
func_CA3C()
{
	return self.var_CA2F["demolition"].var_C32A;
}

//Function Number: 20
func_CA38()
{
	return self.var_CA2F["demolition"].var_AAAA;
}

//Function Number: 21
func_CA3E()
{
	return self.var_CA2F["pistol"].var_CBDC;
}

//Function Number: 22
func_CA3D()
{
	return self.var_CA2F["pistol"].var_CBDB;
}

//Function Number: 23
func_7C4D()
{
}

//Function Number: 24
func_7C4E()
{
	var_00 = "perk_none";
	return var_00;
}

//Function Number: 25
func_E2BC()
{
	var_00 = func_7C4D();
	var_01 = func_7B75();
	scripts\cp\_persistence::func_F4CA(func_7B79("perk_0",var_00,var_01));
	var_02 = func_7C4E();
	if(var_02 != "perk_none")
	{
		var_03 = level.var_1B8E["perk_0"][var_02];
		scripts\cp\_persistence::func_F4CA(func_7B79("perk_0",var_03.var_DE3F,var_01));
	}
}

//Function Number: 26
func_7B79(param_00,param_01,param_02)
{
	return level.var_1B8E[param_00][param_01].var_12F7A[param_02].var_DE3F;
}

//Function Number: 27
func_7B75()
{
	return self getplayerdata("cp","alienSession","perk_0_level");
}

//Function Number: 28
func_7B76()
{
	return self getplayerdata("cp","alienSession","perk_1_level");
}

//Function Number: 29
func_7B77()
{
	return self getplayerdata("cp","alienSession","perk_2_level");
}