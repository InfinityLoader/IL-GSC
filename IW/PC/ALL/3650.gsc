/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3650.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 12 ms
 * Timestamp: 10/27/2023 12:30:59 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_CA60 = [];
	level.var_CA66 = [];
	level.player.var_CA5B = [];
	level.player.var_CA5D = [];
	level.var_12F75 = [];
	level.var_12F79 = [];
	level.var_EF86 = [];
	level.var_EF86["specialty_steadyaim"] = 1;
	level.var_EF86["specialty_quickswap"] = 1;
	level.var_EF86["specialty_quickdraw"] = 1;
	level.var_EF86["specialty_focus"] = 1;
	level.var_EF86["specialty_fastreload"] = 1;
	level.var_EF86["specialty_agility"] = 1;
	level.var_EF86["specialty_extraequipment"] = 1;
	level.var_EF86["specialty_blastshield"] = 1;
	level.var_EF86["specialty_fastregen"] = 1;
	level.var_EF86["specialty_slasher"] = 1;
	level.var_EF86["specialty_shocker"] = 1;
	level.var_EF86["upgrade_frag_1"] = 1;
	level.var_EF86["upgrade_frag_2"] = 1;
	level.var_EF86["upgrade_shock_1"] = 1;
	level.var_EF86["upgrade_shock_2"] = 1;
	level.var_EF86["upgrade_antigrav_1"] = 1;
	level.var_EF86["upgrade_antigrav_2"] = 1;
	level.var_EF86["upgrade_seeker_1"] = 1;
	level.var_EF86["upgrade_seeker_2"] = 1;
	level.var_EF86["upgrade_hack_1"] = 1;
	level.var_EF86["upgrade_shield_1"] = 1;
	level.var_EF86["upgrade_drone_1"] = 1;
	level.var_EF86["upgrade_cover_1"] = 1;
	level.var_CA60["specialty_fastreload"] = ::lib_0E41::func_F701;
	level.var_CA66["specialty_fastreload"] = ::lib_0E41::func_12CBC;
	level.var_CA60["specialty_steadyaim"] = ::lib_0E41::func_F85F;
	level.var_CA66["specialty_steadyaim"] = ::lib_0E41::func_12D36;
	level.var_CA60["specialty_quickswap"] = ::lib_0E41::func_F810;
	level.var_CA66["specialty_quickswap"] = ::lib_0E41::func_12D13;
	level.var_CA60["specialty_focus"] = ::lib_0E41::func_F712;
	level.var_CA66["specialty_focus"] = ::lib_0E41::func_12CBE;
	level.var_CA60["specialty_quickdraw"] = ::lib_0E41::func_F80F;
	level.var_CA66["specialty_quickdraw"] = ::lib_0E41::func_12D12;
	level.var_CA60["specialty_agility"] = ::lib_0E41::func_F636;
	level.var_CA66["specialty_agility"] = ::lib_0E41::func_12C6F;
	level.var_CA60["specialty_extraequipment"] = ::lib_0E41::func_F6F8;
	level.var_CA66["specialty_extraequipment"] = ::lib_0E41::func_12CB7;
	level.var_CA60["specialty_blastshield"] = ::lib_0E41::func_F667;
	level.var_CA66["specialty_blastshield"] = ::lib_0E41::func_12C82;
	level.var_CA60["specialty_fastregen"] = ::lib_0E41::func_F700;
	level.var_CA66["specialty_fastregen"] = ::lib_0E41::func_12CBB;
	level.var_CA60["specialty_slasher"] = ::lib_0E41::func_F849;
	level.var_12F75["specialty_slasher"] = "specialty_shocker";
	level.var_CA66["specialty_slasher"] = ::lib_0E41::func_12D2F;
	level.var_CA60["specialty_shocker"] = ::lib_0E41::func_F83E;
	level.var_12F75["specialty_shocker"] = "specialty_slasher";
	level.var_CA66["specialty_shocker"] = ::lib_0E41::func_12D2A;
	level.var_CA60["upgrade_frag_1"] = ::lib_0E41::func_FAB8;
	level.var_CA66["upgrade_frag_1"] = ::lib_0E41::func_12D5A;
	level.var_12F79[level.var_12F79.size] = "upgrade_frag_1";
	level.var_CA60["upgrade_frag_2"] = ::lib_0E41::func_FAB9;
	level.var_CA66["upgrade_frag_2"] = ::lib_0E41::func_12D5B;
	level.var_12F75["upgrade_frag_2"] = "upgrade_frag_1";
	level.var_12F79[level.var_12F79.size] = "upgrade_frag_2";
	level.var_CA60["upgrade_shock_1"] = ::lib_0E41::func_FAC0;
	level.var_CA66["upgrade_shock_1"] = ::lib_0E41::func_12D62;
	level.var_12F79[level.var_12F79.size] = "upgrade_shock_1";
	level.var_CA60["upgrade_shock_2"] = ::lib_0E41::func_FAC1;
	level.var_CA66["upgrade_shock_2"] = ::lib_0E41::func_12D63;
	level.var_12F75["upgrade_shock_2"] = "upgrade_shock_1";
	level.var_12F79[level.var_12F79.size] = "upgrade_shock_2";
	level.var_CA60["upgrade_antigrav_1"] = ::lib_0E41::func_FAB2;
	level.var_CA66["upgrade_antigrav_1"] = ::lib_0E41::func_12D54;
	level.var_12F79[level.var_12F79.size] = "upgrade_antigrav_1";
	level.var_CA60["upgrade_antigrav_2"] = ::lib_0E41::func_FAB3;
	level.var_CA66["upgrade_antigrav_2"] = ::lib_0E41::func_12D55;
	level.var_12F75["upgrade_antigrav_2"] = "upgrade_antigrav_1";
	level.var_12F79[level.var_12F79.size] = "upgrade_antigrav_2";
	level.var_CA60["upgrade_seeker_1"] = ::lib_0E41::func_FABC;
	level.var_CA66["upgrade_seeker_1"] = ::lib_0E41::func_12D5E;
	level.var_12F79[level.var_12F79.size] = "upgrade_seeker_1";
	level.var_CA60["upgrade_seeker_2"] = ::lib_0E41::func_FABD;
	level.var_CA66["upgrade_seeker_2"] = ::lib_0E41::func_12D5F;
	level.var_12F75["upgrade_seeker_2"] = "upgrade_seeker_1";
	level.var_12F79[level.var_12F79.size] = "upgrade_seeker_2";
	level.var_CA60["upgrade_hack_1"] = ::lib_0E41::func_FABA;
	level.var_CA66["upgrade_hack_1"] = ::lib_0E41::func_12D5C;
	level.var_12F79[level.var_12F79.size] = "upgrade_hack_1";
	level.var_CA60["upgrade_shield_1"] = ::lib_0E41::func_FABE;
	level.var_CA66["upgrade_shield_1"] = ::lib_0E41::func_12D60;
	level.var_12F79[level.var_12F79.size] = "upgrade_shield_1";
	level.var_CA60["upgrade_drone_1"] = ::lib_0E41::func_FAB6;
	level.var_CA66["upgrade_drone_1"] = ::lib_0E41::func_12D58;
	level.var_12F79[level.var_12F79.size] = "upgrade_drone_1";
	level.var_CA60["upgrade_cover_1"] = ::lib_0E41::func_FAB4;
	level.var_CA66["upgrade_cover_1"] = ::lib_0E41::func_12D56;
	level.var_12F79[level.var_12F79.size] = "upgrade_cover_1";
	func_98B0();
}

//Function Number: 2
func_98B0()
{
}

//Function Number: 3
func_838A(param_00)
{
	foreach(var_02 in param_00)
	{
		func_8387(var_02);
	}
}

//Function Number: 4
func_8387(param_00)
{
	func_13D1(param_00);
}

//Function Number: 5
func_E150(param_00)
{
	func_1430(param_00);
}

//Function Number: 6
func_83B7(param_00)
{
	foreach(var_02 in param_00)
	{
		func_83B6(var_02);
	}
}

//Function Number: 7
func_83B6(param_00)
{
	if(isdefined(level.var_12F75[param_00]))
	{
		var_01 = level.var_12F75[param_00];
		while(_hasperk(var_01))
		{
			func_1430(var_01);
		}
	}

	func_13D1(param_00);
}

//Function Number: 8
func_E187(param_00)
{
	func_1430(param_00);
}

//Function Number: 9
func_13D1(param_00)
{
	if(!isdefined(self.var_CA5B[param_00]))
	{
		self.var_CA5B[param_00] = 1;
	}
	else
	{
		self.var_CA5B[param_00]++;
	}

	if(self.var_CA5B[param_00] == 1 && !isdefined(self.var_CA5D[param_00]))
	{
		func_13D2(param_00);
	}
}

//Function Number: 10
func_13D2(param_00)
{
	var_01 = level.var_CA60[param_00];
	if(isdefined(var_01))
	{
		self thread [[ var_01 ]]();
	}

	self method_8320(param_00,!isdefined(level.var_EF86[param_00]));
}

//Function Number: 11
func_1430(param_00)
{
	if(!isdefined(self.var_CA5B[param_00]))
	{
		return;
	}

	self.var_CA5B[param_00]--;
	if(self.var_CA5B[param_00] == 0)
	{
		if(!isdefined(self.var_CA5D[param_00]))
		{
			func_1431(param_00);
		}

		self.var_CA5B[param_00] = undefined;
	}
}

//Function Number: 12
func_1431(param_00)
{
	if(isdefined(level.var_CA66[param_00]))
	{
		self thread [[ level.var_CA66[param_00] ]]();
	}
}

//Function Number: 13
_hasperk(param_00)
{
	return isdefined(self.var_CA5B) && isdefined(self.var_CA5B[param_00]);
}

//Function Number: 14
func_11AA()
{
	foreach(var_02, var_01 in self.var_CA5B)
	{
		if(func_12F9(var_02))
		{
			continue;
		}

		if(isdefined(level.var_CA66[var_02]))
		{
			self [[ level.var_CA66[var_02] ]]();
		}

		self.var_CA5B[var_02] = undefined;
	}

	self.var_CA5D = [];
}

//Function Number: 15
func_11AB()
{
	foreach(var_02, var_01 in self.var_CA5B)
	{
		if(!func_12F9(var_02))
		{
			continue;
		}

		if(isdefined(level.var_CA66[var_02]))
		{
			self [[ level.var_CA66[var_02] ]]();
		}

		self.var_CA5B[var_02] = undefined;
	}

	self.var_CA5D = [];
}

//Function Number: 16
func_12F9(param_00)
{
	if(scripts\common\utility::func_2286(level.var_12F79,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
func_8059(param_00)
{
	return tablelookup("sp/perkTable.csv",1,param_00,3);
}

//Function Number: 18
func_805B(param_00)
{
	return tablelookupistring("sp/perkTable.csv",1,param_00,2);
}

//Function Number: 19
func_2BBB(param_00)
{
	if(!isdefined(self.var_CA5D[param_00]))
	{
		self.var_CA5D[param_00] = 1;
	}
	else
	{
		self.var_CA5D[param_00]++;
	}

	if(self.var_CA5D[param_00] == 1 && _hasperk(param_00))
	{
		func_1431(param_00);
	}
}

//Function Number: 20
func_12B83(param_00)
{
	self.var_CA5D[param_00]--;
	if(self.var_CA5D[param_00] == 0)
	{
		self.var_CA5D[param_00] = undefined;
		if(_hasperk(param_00))
		{
			func_13D2(param_00);
		}
	}
}