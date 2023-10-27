/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3325.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 165
 * Decompile Time: 37 ms
 * Timestamp: 10/27/2023 12:26:33 AM
*******************************************************************/

//Function Number: 1
func_96C9()
{
	var_00 = spawnstruct();
	return var_00;
}

//Function Number: 2
func_F4EC()
{
}

//Function Number: 3
func_12C30()
{
}

//Function Number: 4
func_96C2()
{
	var_00 = spawnstruct();
	var_00.var_B5AF = 1;
	return var_00;
}

//Function Number: 5
func_F4DD()
{
	self.var_CA2F["health"].var_B43C = 125;
	self.var_CA2F["health"].var_B5AF = 1;
}

//Function Number: 6
func_12C21()
{
	self.var_CA2F["health"].var_B5AF = 1;
}

//Function Number: 7
func_F4DE()
{
	self.var_CA2F["health"].var_B43C = 125;
	self.maxhealth = self.var_CA2F["health"].var_B43C;
	self notify("health_perk_upgrade");
	self.var_CA2F["health"].var_B5AF = 1.25;
}

//Function Number: 8
func_12C22()
{
	self.var_CA2F["health"].var_B5AF = 1;
}

//Function Number: 9
func_F4DF()
{
	self.var_CA2F["health"].var_B43C = 150;
	self.maxhealth = self.var_CA2F["health"].var_B43C;
	self notify("health_perk_upgrade");
	self.var_CA2F["health"].var_B5AF = 1.25;
}

//Function Number: 10
func_12C23()
{
	self.var_CA2F["health"].var_B5AF = 1;
}

//Function Number: 11
func_F4E0()
{
	self.var_CA2F["health"].var_B43C = 175;
	self.maxhealth = self.var_CA2F["health"].var_B43C;
	self notify("health_perk_upgrade");
	self.var_CA2F["health"].var_B5AF = 1.5;
}

//Function Number: 12
func_12C24()
{
	self.var_CA2F["health"].var_B5AF = 1;
}

//Function Number: 13
func_F4E1()
{
	self.var_CA2F["health"].var_B43C = 200;
	self.maxhealth = self.var_CA2F["health"].var_B43C;
	self notify("health_perk_upgrade");
	self.var_CA2F["health"].var_B5AF = 2;
}

//Function Number: 14
func_12C25()
{
	self.var_CA2F["health"].var_B5AF = 1;
}

//Function Number: 15
func_96BF()
{
	var_00 = spawnstruct();
	var_00.var_3237 = 1;
	return var_00;
}

//Function Number: 16
func_F4CE()
{
	self.var_CA2F["damagemod"].var_3237 = 1.2;
}

//Function Number: 17
func_12C12()
{
	self.var_CA2F["damagemod"].var_3237 = 1;
}

//Function Number: 18
func_F4CF()
{
	self.var_CA2F["damagemod"].var_3237 = 1.2;
	scripts\cp\_utility::func_8387("specialty_quickswap");
	scripts\cp\_utility::func_8387("specialty_stalker");
	scripts\cp\_utility::func_8387("specialty_fastoffhand");
}

//Function Number: 19
func_12C13()
{
	self.var_CA2F["damagemod"].var_3237 = 1;
	scripts\cp\_utility::func_1430("specialty_quickswap");
	scripts\cp\_utility::func_1430("specialty_stalker");
	scripts\cp\_utility::func_1430("specialty_fastoffhand");
}

//Function Number: 20
func_F4D0()
{
	self.var_CA2F["damagemod"].var_3237 = 1.2;
	scripts\cp\_utility::func_8387("specialty_quickswap");
	scripts\cp\_utility::func_8387("specialty_stalker");
	scripts\cp\_utility::func_8387("specialty_fastoffhand");
	scripts\cp\_utility::func_8387("specialty_quickdraw");
}

//Function Number: 21
func_12C14()
{
	self.var_CA2F["damagemod"].var_3237 = 1;
	scripts\cp\_utility::func_1430("specialty_quickswap");
	scripts\cp\_utility::func_1430("specialty_stalker");
	scripts\cp\_utility::func_1430("specialty_fastoffhand");
	scripts\cp\_utility::func_1430("specialty_quickdraw");
}

//Function Number: 22
func_F4D1()
{
	self.var_CA2F["damagemod"].var_3237 = 1.2;
	scripts\cp\_utility::func_8387("specialty_quickswap");
	scripts\cp\_utility::func_8387("specialty_stalker");
	scripts\cp\_utility::func_8387("specialty_fastoffhand");
	scripts\cp\_utility::func_8387("specialty_quickdraw");
	scripts\cp\_utility::func_8387("specialty_fastreload");
}

//Function Number: 23
func_12C15()
{
	self.var_CA2F["damagemod"].var_3237 = 1;
	scripts\cp\_utility::func_1430("specialty_quickswap");
	scripts\cp\_utility::func_1430("specialty_stalker");
	scripts\cp\_utility::func_1430("specialty_fastoffhand");
	scripts\cp\_utility::func_1430("specialty_quickdraw");
	scripts\cp\_utility::func_8387("specialty_fastreload");
}

//Function Number: 24
func_F4D2()
{
	self.var_CA2F["damagemod"].var_3237 = 1.5;
	scripts\cp\_utility::func_8387("specialty_quickswap");
	scripts\cp\_utility::func_8387("specialty_stalker");
	scripts\cp\_utility::func_8387("specialty_fastoffhand");
	scripts\cp\_utility::func_8387("specialty_quickdraw");
	self method_829B(0.5);
	scripts\cp\_utility::func_8387("specialty_fastreload");
}

//Function Number: 25
func_12C16()
{
	self.var_CA2F["damagemod"].var_3237 = 1;
	scripts\cp\_utility::func_1430("specialty_quickswap");
	scripts\cp\_utility::func_1430("specialty_stalker");
	scripts\cp\_utility::func_1430("specialty_fastoffhand");
	scripts\cp\_utility::func_1430("specialty_quickdraw");
	self method_829B(1);
	scripts\cp\_utility::func_1430("specialty_fastreload");
}

//Function Number: 26
func_96C8()
{
	var_00 = spawnstruct();
	var_00.var_E4A5 = 1;
	var_00.var_76AC = 1;
	var_00.var_BC6F = 1;
	var_00.var_E496 = 1;
	return var_00;
}

//Function Number: 27
func_F4E7()
{
	self.var_CA2F["medic"].var_E4A5 = 1.5;
	self.var_BCF6 = lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
}

//Function Number: 28
func_12C2B()
{
	self.var_CA2F["medic"].var_E4A5 = 1;
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
}

//Function Number: 29
func_F4E8()
{
	self.var_CA2F["medic"].var_E4A5 = 1.5;
	self.var_BCF6 = 1.06 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	self.var_CA2F["medic"].var_E496 = 0.75;
}

//Function Number: 30
func_12C2C()
{
	self.var_CA2F["medic"].var_E4A5 = 1;
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	self.var_CA2F["medic"].var_E496 = 1;
}

//Function Number: 31
func_F4E9()
{
	scripts\cp\_utility::func_8387("specialty_longersprint");
	thread func_B526(65536);
	self.var_CA2F["medic"].var_E4A5 = 1.5;
	self.var_BCF6 = 1.06 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	self.var_CA2F["medic"].var_E496 = 0.75;
}

//Function Number: 32
func_12C2D()
{
	scripts\cp\_utility::func_1430("specialty_longersprint");
	self notify("end_medic_health_regen");
	self.var_CA2F["medic"].var_E4A5 = 1;
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	self.var_CA2F["medic"].var_E496 = 1;
}

//Function Number: 33
func_F4EA()
{
	self.var_CA2F["medic"].var_76AC = 0;
	scripts\cp\_utility::func_8387("specialty_longersprint");
	thread func_B526(65536);
	self.var_CA2F["medic"].var_E4A5 = 1.5;
	self.var_BCF6 = 1.06 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	self.var_CA2F["medic"].var_E496 = 0.75;
}

//Function Number: 34
func_12C2E()
{
	self.var_CA2F["medic"].var_76AC = 1;
	scripts\cp\_utility::func_1430("specialty_longersprint");
	self notify("end_medic_health_regen");
	self.var_CA2F["medic"].var_E4A5 = 1;
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	self.var_CA2F["medic"].var_E496 = 1;
}

//Function Number: 35
func_F4EB()
{
	self.var_CA2F["medic"].var_E4A5 = 1.5;
	self.var_CA2F["medic"].var_76AC = 0;
	thread func_B526(0);
	self.var_BCF6 = 1.12 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	scripts\cp\_utility::func_8387("specialty_longersprint");
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
	scripts\cp\_utility::func_8387("specialty_reducedsway");
	scripts\cp\_utility::func_8387("specialty_bulletpenetration");
	self.var_CA2F["medic"].var_E496 = 0.75;
}

//Function Number: 36
func_12C2F()
{
	self.var_CA2F["medic"].var_E4A5 = 1;
	self.var_CA2F["medic"].var_76AC = 1;
	self notify("end_medic_health_regen");
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["medic"].var_BC6F = self.var_BCF6;
	scripts\cp\_utility::func_1430("specialty_longersprint");
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
	scripts\cp\_utility::func_1430("specialty_reducedsway");
	scripts\cp\_utility::func_1430("specialty_bulletpenetration");
	self.var_CA2F["medic"].var_E496 = 1;
}

//Function Number: 37
func_B526(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("end_medic_health_regen");
	var_01 = param_00 > 0;
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(scripts\cp\_utility::func_9F19(var_03) && !isdefined(var_03.var_B528))
			{
				if(var_01 && distancesquared(self.origin,var_03.origin) > param_00)
				{
					continue;
				}

				var_03 thread func_B527();
			}
		}

		wait(1);
	}
}

//Function Number: 38
func_B527()
{
	self endon("death");
	self endon("disconnect");
	if(!func_8B7E())
	{
		self.var_B528 = 1;
		wait(1);
		self.health = int(min(self.maxhealth,self.health + 5));
		self.var_B528 = undefined;
	}
}

//Function Number: 39
func_96CB()
{
	var_00 = spawnstruct();
	var_00.var_5B99 = 1;
	var_00.var_5BB8 = 1;
	var_00.var_1269D = 1;
	var_00.var_1269F = 1;
	var_00.var_1269E = 1;
	var_00.var_4B35 = 1;
	var_00.var_E18F = 1;
	return var_00;
}

//Function Number: 40
func_F510()
{
	self.var_CA2F["rigger"].var_5B99 = 1.256;
	self.var_CA2F["rigger"].var_4B35 = 1.2;
}

//Function Number: 41
func_12C54()
{
	self.var_CA2F["rigger"].var_5B99 = 1;
	self.var_CA2F["rigger"].var_4B35 = 1;
}

//Function Number: 42
func_F511()
{
	self.var_CA2F["rigger"].var_5B99 = 1.256;
	self.var_CA2F["rigger"].var_4B35 = 1.2;
	self.var_CA2F["rigger"].var_5BB8 = 0.5;
}

//Function Number: 43
func_12C55()
{
	self.var_CA2F["rigger"].var_5B99 = 1;
	self.var_CA2F["rigger"].var_5BB8 = 1;
	self.var_CA2F["rigger"].var_4B35 = 1;
}

//Function Number: 44
func_F512()
{
	self.var_CA2F["rigger"].var_5B99 = 1.256;
	self.var_CA2F["rigger"].var_4B35 = 1.2;
	self.var_CA2F["rigger"].var_5BB8 = 0.5;
	self.var_CA2F["rigger"].var_1269D = 0.8;
}

//Function Number: 45
func_12C56()
{
	self.var_CA2F["rigger"].var_5B99 = 1;
	self.var_CA2F["rigger"].var_5BB8 = 1;
	self.var_CA2F["rigger"].var_1269D = 1;
	self.var_CA2F["rigger"].var_4B35 = 1;
}

//Function Number: 46
func_F513()
{
	self.var_CA2F["rigger"].var_5B99 = 1.256;
	self.var_CA2F["rigger"].var_4B35 = 1.2;
	self.var_CA2F["rigger"].var_5BB8 = 0.5;
	self.var_CA2F["rigger"].var_1269D = 0.8;
	self.var_CA2F["rigger"].var_1269F = 1.5;
	self.var_CA2F["rigger"].var_E18F = 0.75;
}

//Function Number: 47
func_12C57()
{
	self.var_CA2F["rigger"].var_5B99 = 1;
	self.var_CA2F["rigger"].var_5BB8 = 1;
	self.var_CA2F["rigger"].var_1269D = 1;
	self.var_CA2F["rigger"].var_1269F = 1;
	self.var_CA2F["rigger"].var_4B35 = 1;
	self.var_CA2F["rigger"].var_E18F = 1;
}

//Function Number: 48
func_F514()
{
	self.var_CA2F["rigger"].var_5B99 = 1.256;
	self.var_CA2F["rigger"].var_4B35 = 1.2;
	self.var_CA2F["rigger"].var_5BB8 = 0.5;
	self.var_CA2F["rigger"].var_1269D = 0.8;
	self.var_CA2F["rigger"].var_1269F = 1.5;
	self.var_CA2F["rigger"].var_1269E = 2;
	self [[ level.var_F480 ]](8000 * lib_0CFF::func_D87F());
	self.var_CA2F["rigger"].var_E18F = 0.75;
}

//Function Number: 49
func_12C58()
{
	self.var_CA2F["rigger"].var_5B99 = 1;
	self.var_CA2F["rigger"].var_5BB8 = 1;
	self.var_CA2F["rigger"].var_1269D = 1;
	self.var_CA2F["rigger"].var_1269F = 1;
	self.var_CA2F["rigger"].var_1269E = 1;
	self.var_CA2F["rigger"].var_4B35 = 1;
	self [[ level.var_F480 ]](6000 * lib_0CFF::func_D87F());
	self.var_CA2F["rigger"].var_E18F = 1;
}

//Function Number: 50
func_96CC()
{
	var_00 = spawnstruct();
	var_00.var_2183 = 0;
	var_00.var_2182 = 0;
	return var_00;
}

//Function Number: 51
func_F515()
{
	self.var_CA2F["robotics"].var_2180 = 25;
	self.var_CA2F["robotics"].var_2181 = 1;
}

//Function Number: 52
func_12C59()
{
	self.var_CA2F["robotics"].var_2180 = 0;
	self.var_CA2F["robotics"].var_2181 = 0;
}

//Function Number: 53
func_F516()
{
	self.var_CA2F["robotics"].var_2180 = 50;
	self.var_CA2F["robotics"].var_2181 = 2;
}

//Function Number: 54
func_12C5A()
{
	self.var_CA2F["robotics"].var_2180 = 0;
	self.var_CA2F["robotics"].var_2181 = 0;
}

//Function Number: 55
func_F517()
{
	self.var_CA2F["robotics"].var_2180 = 75;
	self.var_CA2F["robotics"].var_2181 = 3;
}

//Function Number: 56
func_12C5B()
{
	self.var_CA2F["robotics"].var_2180 = 0;
	self.var_CA2F["robotics"].var_2181 = 0;
}

//Function Number: 57
func_F518()
{
	self.var_CA2F["robotics"].var_2180 = 100;
	self.var_CA2F["robotics"].var_2181 = 4;
}

//Function Number: 58
func_12C5C()
{
	self.var_CA2F["robotics"].var_2180 = 0;
	self.var_CA2F["robotics"].var_2181 = 0;
}

//Function Number: 59
func_F519()
{
	self.var_CA2F["robotics"].var_2180 = 125;
	self.var_CA2F["robotics"].var_2181 = 5;
}

//Function Number: 60
func_12C5D()
{
	self.var_CA2F["robotics"].var_2180 = 0;
	self.var_CA2F["robotics"].var_2181 = 0;
}

//Function Number: 61
func_96C0()
{
	var_00 = spawnstruct();
	var_00.var_69F9 = 1;
	var_00.var_C32A = 0;
	var_00.var_AAAA = 0;
	return var_00;
}

//Function Number: 62
func_F4D3()
{
	self.var_CA2F["demolition"].var_69F9 = 1.1;
	self.var_CA2F["demolition"].var_C32A = 2;
	self.var_CA2F["demolition"].var_AAAA = 4;
}

//Function Number: 63
func_12C17()
{
	self.var_CA2F["demolition"].var_69F9 = 1;
	self.var_CA2F["demolition"].var_C32A = 0;
	self.var_CA2F["demolition"].var_AAAA = 0;
}

//Function Number: 64
func_F4D4()
{
	self.var_CA2F["demolition"].var_69F9 = 1.2;
	self.var_CA2F["demolition"].var_C32A = 3;
	self.var_CA2F["demolition"].var_AAAA = 6;
}

//Function Number: 65
func_12C18()
{
	self.var_CA2F["demolition"].var_69F9 = 1;
	self.var_CA2F["demolition"].var_C32A = 0;
	self.var_CA2F["demolition"].var_AAAA = 0;
}

//Function Number: 66
func_F4D5()
{
	self.var_CA2F["demolition"].var_69F9 = 1.3;
	self.var_CA2F["demolition"].var_C32A = 4;
	self.var_CA2F["demolition"].var_AAAA = 8;
}

//Function Number: 67
func_12C19()
{
	self.var_CA2F["demolition"].var_69F9 = 1;
	self.var_CA2F["demolition"].var_C32A = 0;
	self.var_CA2F["demolition"].var_AAAA = 0;
}

//Function Number: 68
func_F4D6()
{
	self.var_CA2F["demolition"].var_69F9 = 1.4;
	self.var_CA2F["demolition"].var_C32A = 4;
	self.var_CA2F["demolition"].var_AAAA = 10;
}

//Function Number: 69
func_12C1A()
{
	self.var_CA2F["demolition"].var_69F9 = 1;
	self.var_CA2F["demolition"].var_C32A = 0;
	self.var_CA2F["demolition"].var_AAAA = 0;
}

//Function Number: 70
func_F4D7()
{
	self.var_CA2F["demolition"].var_69F9 = 1.5;
	self.var_CA2F["demolition"].var_C32A = 5;
	self.var_CA2F["demolition"].var_AAAA = 12;
}

//Function Number: 71
func_12C1B()
{
	self.var_CA2F["demolition"].var_69F9 = 1;
	self.var_CA2F["demolition"].var_C32A = 0;
	self.var_CA2F["demolition"].var_AAAA = 0;
}

//Function Number: 72
func_DE49()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	var_00 = 5;
	for(;;)
	{
		var_01 = self method_80FB("aliensemtex_mp");
		if(var_01 == 0)
		{
			for(var_02 = 1;var_02 <= lib_0CFC::func_CA3C();var_02++)
			{
				self method_831C("other");
				scripts\cp\_utility::func_6C12("aliensemtex_mp",1);
				wait(var_00);
			}
		}

		wait(var_00);
	}
}

//Function Number: 73
func_96C1()
{
	var_00 = spawnstruct();
	var_00.var_8723 = 1;
	return var_00;
}

//Function Number: 74
func_F4D8()
{
	scripts\cp\_utility::func_8387("specialty_marathon");
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
	scripts\cp\_utility::func_8387("specialty_fastreload");
	self method_829B(0.5);
	self.var_CA2F["damagemod"].var_3237 = 1.5;
}

//Function Number: 75
func_12C1C()
{
	scripts\cp\_utility::func_1430("specialty_marathon");
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_1430("specialty_fastreload");
	self method_829B(1);
	self.var_CA2F["damagemod"].var_3237 = 1;
}

//Function Number: 76
func_F4D9()
{
	scripts\cp\_utility::func_8387("specialty_marathon");
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
	self.var_BCF6 = 1.1 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_8387("specialty_fastreload");
	self method_829B(0.5);
	self.var_CA2F["damagemod"].var_3237 = 1.5;
}

//Function Number: 77
func_12C1D()
{
	scripts\cp\_utility::func_1430("specialty_marathon");
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_1430("specialty_fastreload");
	self method_829B(1);
	self.var_CA2F["damagemod"].var_3237 = 1;
}

//Function Number: 78
func_F4DA()
{
	scripts\cp\_utility::func_8387("specialty_marathon");
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
	self.var_BCF6 = 1.15 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_8387("specialty_fastreload");
	self method_829B(0.5);
	self.var_CA2F["damagemod"].var_3237 = 1.5;
}

//Function Number: 79
func_12C1E()
{
	scripts\cp\_utility::func_1430("specialty_marathon");
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_1430("specialty_fastreload");
	self method_829B(1);
	self.var_CA2F["damagemod"].var_3237 = 1;
}

//Function Number: 80
func_F4DB()
{
	scripts\cp\_utility::func_8387("specialty_marathon");
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
	self.var_BCF6 = 1.2 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_8387("specialty_fastreload");
	self method_829B(0.5);
	self.var_CA2F["damagemod"].var_3237 = 1.5;
}

//Function Number: 81
func_12C1F()
{
	scripts\cp\_utility::func_1430("specialty_marathon");
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_1430("specialty_fastreload");
	self method_829B(1);
	self.var_CA2F["damagemod"].var_3237 = 1;
}

//Function Number: 82
func_F4DC()
{
	scripts\cp\_utility::func_8387("specialty_marathon");
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
	self.var_BCF6 = 1.25 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_8387("specialty_fastreload");
	self method_829B(0);
	self.var_CA2F["damagemod"].var_3237 = 1.5;
}

//Function Number: 83
func_12C20()
{
	scripts\cp\_utility::func_1430("specialty_marathon");
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
	self.var_CA2F["gunslinger"].var_8723 = self.var_BCF6;
	scripts\cp\_utility::func_1430("specialty_fastreload");
	self method_829B(1);
	self.var_CA2F["damagemod"].var_3237 = 1;
}

//Function Number: 84
func_F65B()
{
	level.var_28C9 = loadfx("vfx/core/mp/core/vfx_battle_slide_camera");
	thread func_28EC();
}

//Function Number: 85
func_12C7B()
{
	self notify("battleSlide_unset");
	func_28E5();
}

//Function Number: 86
func_28EC()
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	for(;;)
	{
		self waittill("sprint_slide_begin");
		func_28E2();
		self waittill("sprint_slide_end");
		func_28E5();
	}

	self notify("battleSlide_unset");
	self.var_28F7 = undefined;
}

//Function Number: 87
func_28E2()
{
	self.var_28E1 = 1;
	self.var_28F7 = [];
	thread func_28F3();
	thread func_28ED();
}

//Function Number: 88
func_28E5()
{
	self.var_28E1 = undefined;
	self.var_28F7 = undefined;
}

//Function Number: 89
func_28ED()
{
	self endon("death");
	self endon("disconnect");
	self endon("sprint_slide_end");
	self endon("battleSlide_unset");
	for(;;)
	{
		var_00 = self getvelocity();
		var_01 = lengthsquared(var_00);
		var_02 = anglestoup(self.angles);
		var_03 = anglestoforward(self.angles);
		var_04 = (0,0,0);
		var_05 = (0,0,0);
		var_06 = scripts\common\trace::func_48BC(0,1,1,0,1,0);
		if(var_01 > 100)
		{
			var_07 = vectortoangles(var_00);
			var_03 = anglestoforward(var_07);
			var_02 = anglestoup(var_07);
			var_04 = var_03 * 40;
			var_05 = var_02 * 28;
			var_08 = function_0287(self geteye(),self.origin + var_04 + var_05,var_06,undefined,0,"physicsquery_closest");
			if(isdefined(var_08) && var_08.size > 0)
			{
				var_04 = var_03 * vectordot(var_08[0]["position"] - self.origin,var_03);
				var_04 = var_04 - var_03 * 3;
			}
		}

		var_09 = level.spawned_enemies;
		foreach(var_0B in var_09)
		{
			if(!isdefined(var_0B) || var_0B == self || !scripts\cp\_utility::func_9F19(var_0B))
			{
				continue;
			}

			if(isdefined(var_0B.agent_type) && var_0B.agent_type == "zombie_brute" || var_0B.agent_type == "zombie_grey")
			{
				continue;
			}

			if(func_28EA(var_0B))
			{
				continue;
			}

			if(!func_D64A(2304,56,self.origin + var_04,var_02,var_0B gettagorigin("j_mainroot")))
			{
				continue;
			}

			if(func_28E8(var_0B,var_03))
			{
				continue;
			}

			if(func_28E7(var_0B,self.origin + var_04 + var_05,var_06))
			{
				continue;
			}

			func_28F5(var_0B);
			func_28E3(var_0B);
			func_28EB(var_0B,var_03);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 90
func_28F5(param_00)
{
	if(!isdefined(self.var_28F7))
	{
		self.var_28F7 = [];
	}

	if(!func_28EA(param_00))
	{
		self.var_28F7[self.var_28F7.size] = param_00 getentitynumber();
		return 1;
	}

	return 0;
}

//Function Number: 91
func_28E3(param_00)
{
	var_01 = int(min(param_00.maxhealth,1000));
	if(var_01 >= self.health)
	{
		self.var_4C87 = 1;
		thread func_28F0(param_00);
	}

	param_00 dodamage(var_01,self.origin,self,self,"MOD_EXPLOSIVE","battleslide_mp");
	thread func_28E4(param_00);
}

//Function Number: 92
func_28EB(param_00,param_01)
{
	var_02 = param_00.origin - self.origin;
	var_03 = length(var_02);
	if(var_03 != 0)
	{
		var_04 = var_02 / var_03;
		var_05 = param_00 getvelocity();
		var_05 = var_05 - var_04 * vectordot(var_05,var_04);
		var_05 = var_05 + var_04 * 800;
		var_05 = var_05 + (0,0,175);
		param_00 setvelocity(var_05);
		param_00 shellshock("battleslide_mp",1.5);
	}
}

//Function Number: 93
func_28E8(param_00,param_01)
{
	return vectordot(param_01,param_00.origin - self.origin) < 0;
}

//Function Number: 94
func_28E7(param_00,param_01,param_02)
{
	var_03 = function_0287(param_01,param_00 gettagorigin("j_mainroot"),param_02,undefined,0,"physicsquery_closest");
	if(isdefined(var_03) && var_03.size > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 95
func_28E9(param_00,param_01)
{
	if(isdefined(param_00.var_8C1E) && param_00.var_8C1E)
	{
		var_02 = param_01 - param_00.origin;
		var_03 = vectornormalize((var_02[0],var_02[1],0));
		var_04 = anglestoforward(param_00.angles);
		var_05 = vectordot(var_04,var_02);
		if(param_00.var_8C1F)
		{
			if(var_05 > 0.766)
			{
				return 1;
			}
		}
		else if(var_05 < -0.766)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 96
func_28EA(param_00)
{
	if(!isdefined(self.var_28F7))
	{
		return 0;
	}

	var_01 = param_00 getentitynumber();
	return scripts\common\utility::func_2286(self.var_28F7,var_01);
}

//Function Number: 97
func_28E6(param_00)
{
	return isdefined(param_00.var_28E6);
}

//Function Number: 98
func_28E4(param_00)
{
	self playrumbleonentity("artillery_rumble");
	param_00 playrumbleonentity("artillery_rumble");
	playrumbleonposition("slide_collision",self.origin);
	earthquake(0.5,0.5,self.origin,96);
	playsoundatpos(self.origin,"slide_impact");
	self setclientomnvar("ui_hud_shake",1);
	scripts\cp\_damage::func_12E84("hitcritical");
}

//Function Number: 99
func_28F3()
{
	self endon("death");
	self endon("disconnect");
	self endon("sprint_slide_end");
	self playlocalsound("melee_boost");
	self playsoundonmovingent("melee_boost_npc");
	var_00 = 0;
	var_01 = 5;
	while(var_01 > var_00)
	{
		var_02 = function_01E1(level.var_28C9,self geteye(),self);
		thread func_28F4(var_02,0.1);
		triggerfx(var_02);
		earthquake(0.2,0.25,self.origin,96);
		self playrumbleonentity("slide_loop");
		var_00++;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 100
func_28F4(param_00,param_01)
{
	wait(param_01);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 101
func_28F0(param_00)
{
	param_00 endon("disconnect");
	var_01 = self.origin;
	self waittill("start_instant_ragdoll");
	wait(0.1);
	physicsexplosionsphere(var_01,68,48,2.5);
}

//Function Number: 102
func_D64A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04 - param_02;
	var_06 = vectordot(var_05,param_03);
	if(var_06 < 0 || var_06 > param_01)
	{
		return 0;
	}

	var_05 = var_05 - var_06 * param_03;
	var_07 = lengthsquared(var_05);
	if(var_07 > param_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 103
func_96C3()
{
	var_00 = spawnstruct();
	return var_00;
}

//Function Number: 104
func_F4E2()
{
	self.var_BCF6 = 1.1 * lib_0CFF::func_D878();
}

//Function Number: 105
func_12C26()
{
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
}

//Function Number: 106
func_F4E3()
{
	self.var_BCF6 = 1.1 * lib_0CFF::func_D878();
}

//Function Number: 107
func_12C27()
{
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
}

//Function Number: 108
func_F4E4()
{
	self.var_BCF6 = 1.15 * lib_0CFF::func_D878();
}

//Function Number: 109
func_12C28()
{
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
}

//Function Number: 110
func_F4E5()
{
	self.var_BCF6 = 1.2 * lib_0CFF::func_D878();
}

//Function Number: 111
func_12C29()
{
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
}

//Function Number: 112
func_F4E6()
{
	self.var_BCF6 = 1.25 * lib_0CFF::func_D878();
}

//Function Number: 113
func_12C2A()
{
	self.var_BCF6 = 1 * lib_0CFF::func_D878();
}

//Function Number: 114
func_5AD3()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		if(!self isonground() && self method_81CE())
		{
			wait(0.2);
			earthquake(0.25,0.75,self.origin + (0,0,60),100);
			while(self method_81CE() && !self isonground())
			{
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 115
func_96CA()
{
	var_00 = spawnstruct();
	var_00.var_CBDB = 0;
	var_00.var_CBDC = 0;
	return var_00;
}

//Function Number: 116
func_3D92(param_00,param_01)
{
	self.var_AA45 = self getcurrentweapon();
	self.var_CBD8 = self getweaponammoclip(param_01,"right");
	self.var_CBD7 = self getweaponammostock(param_01);
}

//Function Number: 117
func_82F0(param_00)
{
	var_01 = param_00;
	scripts\cp\_utility::func_12C6(var_01);
	self setweaponammoclip(var_01,self.var_CBD8,"right");
	self setweaponammostock(var_01,self.var_CBD7);
	var_02 = self getweaponslistprimaries();
	if(!self hasweapon(self.var_AA45) && !scripts\cp\_utility::func_8BAE() && !scripts\cp\_utility::func_9C03())
	{
		self switchtoweapon(var_01);
	}
}

//Function Number: 118
func_F50B()
{
}

//Function Number: 119
func_12C4F()
{
	func_110A1("iw6_p226_mp");
}

//Function Number: 120
func_F50C()
{
	func_82F0("iw6_p226_mp_barrelrange02");
}

//Function Number: 121
func_12C50()
{
	func_110A1("iw6_p226_mp");
}

//Function Number: 122
func_F50D()
{
	func_82F0("iw6_p226_mp_barrelrange02_xmags");
}

//Function Number: 123
func_12C51()
{
	func_110A1("iw6_p226_mp");
}

//Function Number: 124
func_F50E()
{
	func_82F0("iw6_p226_mp_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 125
func_12C52()
{
	func_110A1("iw6_p226_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 126
func_F50F()
{
	func_82F0("iw6_p226_mp_akimbo_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 127
func_12C53()
{
	func_110A1("iw6_p226_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 128
func_F4F2()
{
}

//Function Number: 129
func_12C36()
{
	func_110A1("iw6_magnum_mp");
}

//Function Number: 130
func_F4F3()
{
	func_82F0("iw6_magnum_mp_barrelrange02");
}

//Function Number: 131
func_12C37()
{
	func_110A1("iw6_magnum_mp");
}

//Function Number: 132
func_F4F4()
{
	func_82F0("iw6_magnum_mp_barrelrange02_xmags");
}

//Function Number: 133
func_12C38()
{
	func_110A1("iw6_magnum_mp");
}

//Function Number: 134
func_F4F5()
{
	func_82F0("iw6_magnum_mp_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 135
func_12C39()
{
	func_110A1("iw6_magnum_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 136
func_F4F6()
{
	func_82F0("iw6_magnum_mp_akimbo_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 137
func_12C3A()
{
	func_110A1("iw6_alienmagnum_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 138
func_F506()
{
}

//Function Number: 139
func_12C4A()
{
	func_110A1("iw6_m9a1_mp");
}

//Function Number: 140
func_F507()
{
	func_82F0("iw6_m9a1_mp_barrelrange02");
}

//Function Number: 141
func_12C4B()
{
	func_110A1("iw6_m9a1_mp");
}

//Function Number: 142
func_F508()
{
	func_82F0("iw6_m9a1_mp_barrelrange02_xmags");
}

//Function Number: 143
func_12C4C()
{
	func_110A1("iw6_m9a1_mp");
}

//Function Number: 144
func_F509()
{
	func_82F0("iw6_m9a1_mp_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 145
func_12C4D()
{
	func_110A1("iw6_m9a1_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 146
func_F50A()
{
	func_82F0("iw6_m9a1_mp_akimbo_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 147
func_12C4E()
{
	func_110A1("iw6_m9a1_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 148
func_110A1(param_00)
{
	var_01 = func_7907();
	func_3D92(param_00,var_01);
	self takeweapon(var_01);
}

//Function Number: 149
func_F501()
{
}

//Function Number: 150
func_12C45()
{
	func_110A1("iw6_mp443_mp");
}

//Function Number: 151
func_F502()
{
	func_82F0("iw6_mp443_mp_barrelrange02");
}

//Function Number: 152
func_12C46()
{
	func_110A1("iw6_mp443_mp");
}

//Function Number: 153
func_F503()
{
	func_82F0("iw6_mp443_mp_barrelrange02_xmags");
}

//Function Number: 154
func_12C47()
{
	func_110A1("iw6_mp443_mp");
}

//Function Number: 155
func_F504()
{
	func_82F0("iw6_mp443_mp_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 156
func_12C48()
{
	func_110A1("iw6_mp443_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 157
func_F505()
{
	func_82F0("iw6_mp443_mp_akimbo_barrelrange02_xmags");
	self.var_CA2F["pistol"].var_CBDB = 1;
}

//Function Number: 158
func_12C49()
{
	func_110A1("iw6_mp443_mp");
	self.var_CA2F["pistol"].var_CBDB = 0;
}

//Function Number: 159
func_139D2()
{
	self endon("death");
	self endon("disconnect");
	self endon("last_stand");
	self.var_CBE0 = 1;
	self.var_1BD9 = 1;
	self.var_1BD8 = 0;
	self.var_440B = func_7E3B();
	self [[ level.var_BC70 ]]();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		var_01 = self getcurrentweapon();
		var_02 = scripts\cp\_utility::func_80D8(var_01);
		if(isdefined(var_02))
		{
			if(var_02 == "nrg" || var_02 == "zmagnum" || var_02 == "zg18" || var_02 == "emc")
			{
				self.var_CBE0 = 1.1;
			}
			else
			{
				self.var_CBE0 = 1;
			}

			wait(0.05);
			func_12E78();
		}

		wait(0.05);
	}
}

//Function Number: 160
func_12E78()
{
	self.var_440B = func_7E3B();
	self [[ level.var_BC70 ]]();
}

//Function Number: 161
func_7E3B()
{
	return self.var_CBE0 * self.var_1BD9;
}

//Function Number: 162
func_13A29()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(isdefined(var_00))
		{
			if(var_00 == "iw5_alienriotshield4_mp_camo05" && self.var_6D82 == 1)
			{
				playfxontag(level._effect["riotshield_fire"],self,"tag_origin");
				continue;
			}

			stopfxontag(level._effect["riotshield_fire"],self,"tag_origin");
		}
	}

	wait(0.05);
}

//Function Number: 163
func_8B7E()
{
	if(lib_0CFF::func_D87D() != 1 && self method_81BD())
	{
		return 1;
	}

	return 0;
}

//Function Number: 164
func_7907()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = scripts\cp\_utility::func_4626(var_02);
		if(var_03 == "weapon_pistol")
		{
			return var_02;
		}
	}
}

//Function Number: 165
func_20E0(param_00)
{
	if(isdefined(self.var_1119B))
	{
		return self.var_1119B * param_00;
	}

	return param_00;
}