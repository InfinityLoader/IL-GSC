/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\utility.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 317
 * Decompile Time: 5385 ms
 * Timestamp: 10/27/2023 3:26:58 AM
*******************************************************************/

//Function Number: 1
func_55BF(param_00)
{
	if(function_0296(param_00))
	{
		return func_55BF(param_00[0]) || func_55BF(param_00[1]) || func_55BF(param_00[2]);
	}
	else if(function_02A2(param_00))
	{
		return !param_00 < 0 || param_00 > 0 || param_00 == 0;
	}

	return 0;
}

//Function Number: 2
func_562E(param_00)
{
	return isdefined(param_00) && param_00;
}

//Function Number: 3
func_6756(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_3F02))
	{
		return;
	}

	if(!isdefined(level.var_3F02[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		[[ level.var_3F02[param_00] ]]();
		return;
	}

	if(!isdefined(param_02))
	{
		[[ level.var_3F02[param_00] ]](param_01);
		return;
	}

	if(!isdefined(param_03))
	{
		[[ level.var_3F02[param_00] ]](param_01,param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		[[ level.var_3F02[param_00] ]](param_01,param_02,param_03);
		return;
	}

	[[ level.var_3F02[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 4
func_83BE(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_3F02[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		self [[ level.var_3F02[param_00] ]]();
		return;
	}

	if(!isdefined(param_02))
	{
		self [[ level.var_3F02[param_00] ]](param_01);
		return;
	}

	if(!isdefined(param_03))
	{
		self [[ level.var_3F02[param_00] ]](param_01,param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		self [[ level.var_3F02[param_00] ]](param_01,param_02,param_03);
		return;
	}

	self [[ level.var_3F02[param_00] ]](param_01,param_02,param_03,param_04);
}

//Function Number: 5
func_7A5F(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 6
func_7A61(param_00,param_01)
{
	var_02 = randomfloatrange(param_00,param_01);
	if(randomint(2) == 0)
	{
		var_02 = var_02 * -1;
	}

	var_03 = randomfloatrange(param_00,param_01);
	if(randomint(2) == 0)
	{
		var_03 = var_03 * -1;
	}

	var_04 = randomfloatrange(param_00,param_01);
	if(randomint(2) == 0)
	{
		var_04 = var_04 * -1;
	}

	return (var_02,var_03,var_04);
}

//Function Number: 7
func_7A60(param_00,param_01)
{
	var_02 = randomfloat(param_01);
	var_03 = randomfloat(360);
	var_04 = sin(var_02);
	var_05 = cos(var_02);
	var_06 = sin(var_03);
	var_07 = cos(var_03);
	var_08 = (var_05,var_07 * var_04,var_06 * var_04);
	return rotatevector(var_08,vectortoangles(param_00));
}

//Function Number: 8
func_8C4F(param_00)
{
	if(param_00 >= 0)
	{
		return 1;
	}

	return -1;
}

//Function Number: 9
func_627D(param_00,param_01)
{
	var_02 = int(param_00 / param_01);
	if(param_00 * param_01 < 0)
	{
		var_02 = var_02 - 1;
	}

	return param_00 - var_02 * param_01;
}

//Function Number: 10
func_9AAD(param_00)
{
	return "" + param_00;
}

//Function Number: 11
func_9B8A(param_00)
{
	if(isdefined(self.var_2919))
	{
		if(param_00 == self.var_2919)
		{
			return;
		}
	}

	self.var_2919 = param_00;
}

//Function Number: 12
func_416F(param_00)
{
	var_01 = [];
	var_01["axis"] = "allies";
	var_01["allies"] = "axis";
	return var_01[param_00];
}

//Function Number: 13
func_23B8(param_00)
{
	self.var_38CE[param_00] = level.var_2BC3;
}

//Function Number: 14
func_8487(param_00,param_01)
{
	self.var_38CE[param_00] = param_01;
}

//Function Number: 15
func_840A(param_00)
{
	var_01 = getarraykeys(self.var_38CE);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		self.var_38CE[var_01[var_02]] = param_00;
	}
}

//Function Number: 16
func_24A6()
{
	return randomint(100) >= 50;
}

//Function Number: 17
func_2205(param_00,param_01)
{
	var_02 = randomint(param_01[param_01.size - 1] + 1);
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(var_02 <= param_01[var_03])
		{
			return param_00[var_03];
		}
	}
}

//Function Number: 18
func_4127(param_00)
{
	var_01 = [];
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_02 = var_02 + param_00[var_03];
		var_01[var_03] = var_02;
	}

	return var_01;
}

//Function Number: 19
func_67EC(param_00,param_01)
{
	wait(param_00);
	self notify(param_01);
}

//Function Number: 20
func_A75D(param_00,param_01)
{
	if(param_00 != "death")
	{
		self endon("death");
	}

	param_01 endon("die");
	self waittill(param_00);
	param_01 notify("returned",param_00,self);
}

//Function Number: 21
func_A75F(param_00,param_01)
{
	if(param_00 != "death")
	{
		self endon("death");
	}

	param_01 endon("die");
	self waittill(param_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	var_0C = [];
	var_0C[0] = param_00;
	if(isdefined(var_02))
	{
		var_0C[1] = var_02;
	}

	if(isdefined(var_03))
	{
		var_0C[2] = var_03;
	}

	if(isdefined(var_04))
	{
		var_0C[3] = var_04;
	}

	if(isdefined(var_05))
	{
		var_0C[4] = var_05;
	}

	if(isdefined(var_06))
	{
		var_0C[5] = var_06;
	}

	if(isdefined(var_07))
	{
		var_0C[6] = var_07;
	}

	if(isdefined(var_08))
	{
		var_0C[7] = var_08;
	}

	if(isdefined(var_09))
	{
		var_0C[8] = var_09;
	}

	if(isdefined(var_0A))
	{
		var_0C[9] = var_0A;
	}

	if(isdefined(var_0B))
	{
		var_0C[10] = var_0B;
	}

	param_01 notify("returned",var_0C,self);
}

//Function Number: 22
func_A75E(param_00,param_01)
{
	param_01 endon("die");
	self waittill(param_00);
	param_01 notify("returned",param_00);
}

//Function Number: 23
func_A746(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05 = spawnstruct();
	var_05.var_996E = 0;
	if(isdefined(param_00))
	{
		childthread func_A75D(param_00,var_05);
		var_05.var_996E++;
	}

	if(isdefined(param_01))
	{
		childthread func_A75D(param_01,var_05);
		var_05.var_996E++;
	}

	if(isdefined(param_02))
	{
		childthread func_A75D(param_02,var_05);
		var_05.var_996E++;
	}

	if(isdefined(param_03))
	{
		childthread func_A75D(param_03,var_05);
		var_05.var_996E++;
	}

	if(isdefined(param_04))
	{
		childthread func_A75D(param_04,var_05);
		var_05.var_996E++;
	}

	while(var_05.var_996E)
	{
		var_05 waittill("returned");
		var_05.var_996E--;
	}

	var_05 notify("die");
}

//Function Number: 24
func_A747(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	var_08 = spawnstruct();
	var_08.var_996E = 0;
	if(isdefined(param_00))
	{
		param_00 childthread func_A75D(param_01,var_08);
		var_08.var_996E++;
	}

	if(isdefined(param_02))
	{
		param_02 childthread func_A75D(param_03,var_08);
		var_08.var_996E++;
	}

	if(isdefined(param_04))
	{
		param_04 childthread func_A75D(param_05,var_08);
		var_08.var_996E++;
	}

	if(isdefined(param_06))
	{
		param_06 childthread func_A75D(param_07,var_08);
		var_08.var_996E++;
	}

	while(var_08.var_996E)
	{
		var_08 waittill("returned");
		var_08.var_996E--;
	}

	var_08 notify("die");
}

//Function Number: 25
func_A748(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	var_09 = spawnstruct();
	var_09.var_996E = 0;
	if(isdefined(param_01))
	{
		param_01 childthread func_A75E(param_02,var_09);
		var_09.var_996E++;
	}

	if(isdefined(param_03))
	{
		param_03 childthread func_A75E(param_04,var_09);
		var_09.var_996E++;
	}

	if(isdefined(param_05))
	{
		param_05 childthread func_A75E(param_06,var_09);
		var_09.var_996E++;
	}

	if(isdefined(param_07))
	{
		param_07 childthread func_A75E(param_08,var_09);
		var_09.var_996E++;
	}

	var_0A = "ents_notified";
	while(var_09.var_996E)
	{
		if(isdefined(param_00))
		{
			var_0B = var_09 func_A74D("returned",param_00);
			if(isdefined(var_0B) && var_0B == "timeout")
			{
				var_09.var_996E = 0;
				var_0A = "timeout";
			}
			else
			{
				var_09.var_996E--;
			}

			continue;
		}

		var_09 waittill("returned");
		var_09.var_996E--;
	}

	var_09 notify("die");
	return var_0A;
}

//Function Number: 26
func_A715(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if((!isdefined(param_00) || param_00 != "death") && (!isdefined(param_01) || param_01 != "death") && (!isdefined(param_02) || param_02 != "death") && (!isdefined(param_03) || param_03 != "death") && (!isdefined(param_04) || param_04 != "death") && (!isdefined(param_05) || param_05 != "death") && (!isdefined(param_06) || param_06 != "death") && (!isdefined(param_07) || param_07 != "death") && !isdefined(param_08) || param_08 != "death")
	{
		self endon("death");
	}

	var_09 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_A75D(param_00,var_09);
	}

	if(isdefined(param_01))
	{
		childthread func_A75D(param_01,var_09);
	}

	if(isdefined(param_02))
	{
		childthread func_A75D(param_02,var_09);
	}

	if(isdefined(param_03))
	{
		childthread func_A75D(param_03,var_09);
	}

	if(isdefined(param_04))
	{
		childthread func_A75D(param_04,var_09);
	}

	if(isdefined(param_05))
	{
		childthread func_A75D(param_05,var_09);
	}

	if(isdefined(param_06))
	{
		childthread func_A75D(param_06,var_09);
	}

	if(isdefined(param_07))
	{
		childthread func_A75D(param_07,var_09);
	}

	if(isdefined(param_08))
	{
		childthread func_A75D(param_08,var_09);
	}

	var_09 waittill("returned",var_0A);
	var_09 notify("die");
	return var_0A;
}

//Function Number: 27
func_A717(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if((!isdefined(param_00) || param_00 != "death") && (!isdefined(param_01) || param_01 != "death") && (!isdefined(param_02) || param_02 != "death") && (!isdefined(param_03) || param_03 != "death") && (!isdefined(param_04) || param_04 != "death") && (!isdefined(param_05) || param_05 != "death") && (!isdefined(param_06) || param_06 != "death") && !isdefined(param_07) || param_07 != "death")
	{
		self endon("death");
	}

	var_08 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_A75F(param_00,var_08);
	}

	if(isdefined(param_01))
	{
		childthread func_A75F(param_01,var_08);
	}

	if(isdefined(param_02))
	{
		childthread func_A75F(param_02,var_08);
	}

	if(isdefined(param_03))
	{
		childthread func_A75F(param_03,var_08);
	}

	if(isdefined(param_04))
	{
		childthread func_A75F(param_04,var_08);
	}

	if(isdefined(param_05))
	{
		childthread func_A75F(param_05,var_08);
	}

	if(isdefined(param_06))
	{
		childthread func_A75F(param_06,var_08);
	}

	if(isdefined(param_07))
	{
		childthread func_A75F(param_07,var_08);
	}

	var_08 waittill("returned",var_09);
	var_08 notify("die");
	return var_09;
}

//Function Number: 28
func_A70F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10)
{
	self endon("death");
	var_11 = spawnstruct();
	if((!isdefined(param_02) || param_02 != "death") && (!isdefined(param_04) || param_04 != "death") && (!isdefined(param_06) || param_06 != "death") && (!isdefined(param_08) || param_08 != "death") && (!isdefined(param_0A) || param_0A != "death") && (!isdefined(param_0C) || param_0C != "death") && (!isdefined(param_0E) || param_0E != "death") && !isdefined(param_10) || param_10 != "death")
	{
		self endon("death");
	}

	if(isdefined(param_01) && isdefined(param_02))
	{
		param_01 childthread func_A75F(param_02,var_11);
	}

	if(isdefined(param_03) && isdefined(param_04))
	{
		param_03 childthread func_A75F(param_04,var_11);
	}

	if(isdefined(param_05) && isdefined(param_06))
	{
		param_05 childthread func_A75F(param_06,var_11);
	}

	if(isdefined(param_07) && isdefined(param_08))
	{
		param_07 childthread func_A75F(param_08,var_11);
	}

	if(isdefined(param_09) && isdefined(param_0A))
	{
		param_09 childthread func_A75F(param_0A,var_11);
	}

	if(isdefined(param_0B) && isdefined(param_0C))
	{
		param_0B childthread func_A75F(param_0C,var_11);
	}

	if(isdefined(param_0D) && isdefined(param_0E))
	{
		param_0D childthread func_A75F(param_0E,var_11);
	}

	if(isdefined(param_0F) && isdefined(param_10))
	{
		param_0F childthread func_A75F(param_10,var_11);
	}

	if(param_00 > 0)
	{
		childthread func_A763(var_11,"returned",param_00);
	}

	var_11 waittill("returned",var_12,var_13);
	if(isdefined(var_12) && !isarray(var_12) && var_12 == "timeout")
	{
		var_11 notify("die");
		return ["timeout","timeout"];
	}

	var_11 notify("die");
	var_14 = func_0F73([var_13],var_12);
	return var_14;
}

//Function Number: 29
func_A719(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	if((!isdefined(param_01) || param_01 != "death") && (!isdefined(param_02) || param_02 != "death") && (!isdefined(param_03) || param_03 != "death") && (!isdefined(param_04) || param_04 != "death") && (!isdefined(param_05) || param_05 != "death") && (!isdefined(param_06) || param_06 != "death") && (!isdefined(param_07) || param_07 != "death") && !isdefined(param_08) || param_08 != "death")
	{
		self endon("death");
	}

	var_09 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread func_A75F(param_01,var_09);
	}

	if(isdefined(param_02))
	{
		childthread func_A75F(param_02,var_09);
	}

	if(isdefined(param_03))
	{
		childthread func_A75F(param_03,var_09);
	}

	if(isdefined(param_04))
	{
		childthread func_A75F(param_04,var_09);
	}

	if(isdefined(param_05))
	{
		childthread func_A75F(param_05,var_09);
	}

	if(isdefined(param_06))
	{
		childthread func_A75F(param_06,var_09);
	}

	if(isdefined(param_07))
	{
		childthread func_A75F(param_07,var_09);
	}

	if(isdefined(param_08))
	{
		childthread func_A75F(param_08,var_09);
	}

	childthread func_A763(var_09,"returned",param_00);
	var_09 waittill("returned",var_0A);
	if(isdefined(var_0A) && !isarray(var_0A) && var_0A == "timeout")
	{
		var_09 notify("die");
		return ["timeout"];
	}

	var_09 notify("die");
	return var_0A;
}

//Function Number: 30
func_A763(param_00,param_01,param_02)
{
	self endon(param_01);
	wait(param_02);
	param_00 notify("returned","timeout");
}

//Function Number: 31
func_A716(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_A75E(param_00,var_07);
	}

	if(isdefined(param_01))
	{
		childthread func_A75E(param_01,var_07);
	}

	if(isdefined(param_02))
	{
		childthread func_A75E(param_02,var_07);
	}

	if(isdefined(param_03))
	{
		childthread func_A75E(param_03,var_07);
	}

	if(isdefined(param_04))
	{
		childthread func_A75E(param_04,var_07);
	}

	if(isdefined(param_05))
	{
		childthread func_A75E(param_05,var_07);
	}

	if(isdefined(param_06))
	{
		childthread func_A75E(param_06,var_07);
	}

	var_07 waittill("returned",var_08);
	var_07 notify("die");
	return var_08;
}

//Function Number: 32
func_A712(param_00)
{
	var_01 = spawnstruct();
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		childthread func_A75D(var_04,var_01);
		if(var_04 == "death")
		{
			var_02 = 1;
		}
	}

	if(!var_02)
	{
		self endon("death");
	}

	var_01 waittill("returned",var_06);
	var_01 notify("die");
	return var_06;
}

//Function Number: 33
func_A713(param_00)
{
	var_01 = spawnstruct();
	foreach(var_03 in param_00)
	{
		childthread func_A75E(var_03,var_01);
	}

	var_01 waittill("returned",var_05);
	var_01 notify("die");
	return var_05;
}

//Function Number: 34
func_A710(param_00,param_01)
{
	var_02 = spawnstruct();
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		childthread func_A75D(var_05,var_02);
		if(var_05 == "death")
		{
			var_03 = 1;
		}
	}

	if(!var_03)
	{
		self endon("death");
	}

	var_02 childthread func_0730(param_01);
	var_02 waittill("returned",var_07);
	var_02 notify("die");
	return var_07;
}

//Function Number: 35
func_A711(param_00,param_01)
{
	var_02 = spawnstruct();
	foreach(var_04 in param_00)
	{
		childthread func_A75E(var_04,var_02);
	}

	var_02 thread func_0730(param_01);
	var_02 waittill("returned",var_06);
	var_02 notify("die");
	return var_06;
}

//Function Number: 36
func_A71A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if((!isdefined(param_01) || param_01 != "death") && (!isdefined(param_02) || param_02 != "death") && (!isdefined(param_03) || param_03 != "death") && (!isdefined(param_04) || param_04 != "death") && (!isdefined(param_05) || param_05 != "death") && !isdefined(param_06) || param_06 != "death")
	{
		self endon("death");
	}

	var_07 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread func_A75D(param_01,var_07);
	}

	if(isdefined(param_02))
	{
		childthread func_A75D(param_02,var_07);
	}

	if(isdefined(param_03))
	{
		childthread func_A75D(param_03,var_07);
	}

	if(isdefined(param_04))
	{
		childthread func_A75D(param_04,var_07);
	}

	if(isdefined(param_05))
	{
		childthread func_A75D(param_05,var_07);
	}

	if(isdefined(param_06))
	{
		childthread func_A75D(param_06,var_07);
	}

	var_07 childthread func_0730(param_00);
	var_07 waittill("returned",var_08);
	var_07 notify("die");
	return var_08;
}

//Function Number: 37
func_0730(param_00)
{
	self endon("die");
	wait(param_00);
	self notify("returned","timeout");
}

//Function Number: 38
func_A71B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	if(isdefined(param_01))
	{
		childthread func_A75E(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		childthread func_A75E(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		childthread func_A75E(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		childthread func_A75E(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		childthread func_A75E(param_05,var_06);
	}

	var_06 childthread func_0730(param_00);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 39
knock_off_battery(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	if(isdefined(param_04))
	{
		self endon(param_04);
	}

	if(isdefined(param_05))
	{
		self endon(param_05);
	}

	if(isdefined(param_06))
	{
		self endon(param_06);
	}

	if(isdefined(param_07))
	{
		self endon(param_07);
	}

	self waittill(param_00);
}

//Function Number: 40
func_A63E(param_00,param_01,param_02,param_03)
{
	self endon(param_01);
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	wait(param_00);
}

//Function Number: 41
func_A70C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(isdefined(param_02) && isdefined(param_03))
	{
		param_02 endon(param_03);
	}

	if(isdefined(param_04) && isdefined(param_05))
	{
		param_04 endon(param_05);
	}

	if(isdefined(param_06) && isdefined(param_07))
	{
		param_06 endon(param_07);
	}

	if(isdefined(param_08) && isdefined(param_09))
	{
		param_08 endon(param_09);
	}

	if(isdefined(param_0A) && isdefined(param_0B))
	{
		param_0A endon(param_0B);
	}

	if(isdefined(param_0C) && isdefined(param_0D))
	{
		param_0C endon(param_0D);
	}

	param_00 waittill(param_01);
}

//Function Number: 42
func_A70E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F)
{
	var_10 = spawnstruct();
	if(isdefined(param_01))
	{
		param_00 childthread func_A75D(param_01,var_10);
	}

	if(isdefined(param_03))
	{
		param_02 childthread func_A75D(param_03,var_10);
	}

	if(isdefined(param_05))
	{
		param_04 childthread func_A75D(param_05,var_10);
	}

	if(isdefined(param_07))
	{
		param_06 childthread func_A75D(param_07,var_10);
	}

	if(isdefined(param_09))
	{
		param_08 childthread func_A75D(param_09,var_10);
	}

	if(isdefined(param_0B))
	{
		param_0A childthread func_A75D(param_0B,var_10);
	}

	if(isdefined(param_0D))
	{
		param_0C childthread func_A75D(param_0D,var_10);
	}

	if(isdefined(param_0F))
	{
		param_0E childthread func_A75D(param_0F,var_10);
	}

	var_10 waittill("returned",var_11,var_12);
	var_10 notify("die");
	return [var_11,var_12];
}

//Function Number: 43
func_A70D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	if(isdefined(param_03) && isdefined(param_04))
	{
		param_03 endon(param_04);
	}

	if(isdefined(param_05) && isdefined(param_06))
	{
		param_05 endon(param_06);
	}

	if(isdefined(param_07) && isdefined(param_08))
	{
		param_07 endon(param_08);
	}

	if(isdefined(param_09) && isdefined(param_0A))
	{
		param_09 endon(param_0A);
	}

	if(isdefined(param_0B) && isdefined(param_0C))
	{
		param_0B endon(param_0C);
	}

	if(isdefined(param_0D) && isdefined(param_0E))
	{
		param_0D endon(param_0E);
	}

	param_01 func_A74B(param_02,param_00);
}

//Function Number: 44
func_A70B(param_00,param_01)
{
	var_02 = spawnstruct();
	foreach(var_04 in param_00)
	{
		var_04 childthread func_A75D(param_01,var_02);
	}

	var_02 waittill("returned",var_06,var_07);
	var_02 notify("die");
	return var_07;
}

//Function Number: 45
func_0161()
{
	if(isdefined(self.var_161) && self.var_161 > 0)
	{
		wait(self.var_161);
		return 1;
	}
	else if(isdefined(self.var_8154) && isdefined(self.var_8153))
	{
		wait(randomfloatrange(self.var_8154,self.var_8153));
		return 1;
	}

	return 0;
}

//Function Number: 46
func_4B3F()
{
	if(isdefined(self.var_161))
	{
		return 1;
	}

	if(isdefined(self.var_8154) && isdefined(self.var_8153))
	{
		return 1;
	}

	return 0;
}

//Function Number: 47
func_8155()
{
	if(isdefined(self.var_8155))
	{
		wait(self.var_8155);
		return 1;
	}
	else if(isdefined(self.var_8157) && isdefined(self.var_8156))
	{
		wait(randomfloatrange(self.var_8157,self.var_8156));
		return 1;
	}

	return 0;
}

//Function Number: 48
func_82E5()
{
	var_00 = gettime();
	if(isdefined(self.var_82E5))
	{
		wait(self.var_82E5);
		if(isdefined(self.var_82E6))
		{
			self.var_82E5 = self.var_82E5 + self.var_82E6;
		}
	}
	else if(isdefined(self.var_82E8) && isdefined(self.var_82E7))
	{
		wait(randomfloatrange(self.var_82E8,self.var_82E7));
		if(isdefined(self.var_82E6))
		{
			self.var_82E8 = self.var_82E8 + self.var_82E6;
			self.var_82E7 = self.var_82E7 + self.var_82E6;
		}
	}

	return gettime() - var_00;
}

//Function Number: 49
func_0F91(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(self))
	{
		self endon("death");
		self endon("array_random_iterate_stop");
	}

	if(isdefined(param_0A))
	{
		level endon(param_0A);
	}

	var_0B = [];
	foreach(var_0D in param_00)
	{
		var_0B[var_0B.size] = var_0D;
	}

	var_0F = 0;
	while(!isdefined(param_09) && param_09 == 1)
	{
		if(var_0F)
		{
			wait 0.05;
			if(param_02 <= param_01)
			{
				wait(param_01);
			}
			else
			{
				wait(randomfloatrange(param_01,param_02));
			}
		}

		var_0F = 1;
		var_10 = var_0B.size;
		while(var_10 > 0)
		{
			var_11 = randomint(var_10);
			var_12 = var_0B[var_11];
			var_10 = var_10 - 1;
			var_0B[var_11] = var_0B[var_10];
			var_0B[var_10] = var_12;
			if(!isdefined(param_05))
			{
				if(!isdefined(param_04))
				{
					var_13 = [[ param_03 ]](var_12);
				}
				else
				{
					var_13 = param_04 [[ param_03 ]](var_12);
				}
			}
			else if(!isdefined(param_06))
			{
				if(!isdefined(param_04))
				{
					var_13 = [[ param_03 ]](var_12,param_05);
				}
				else
				{
					var_13 = param_04 [[ param_03 ]](var_12,param_05);
				}
			}
			else if(!isdefined(param_07))
			{
				if(!isdefined(param_04))
				{
					var_13 = [[ param_03 ]](var_12,param_05,param_06);
				}
				else
				{
					var_13 = param_04 [[ param_03 ]](var_12,param_05,param_06);
				}
			}
			else if(!isdefined(param_08))
			{
				if(!isdefined(param_04))
				{
					var_13 = [[ param_03 ]](var_12,param_05,param_06,param_07);
				}
				else
				{
					var_13 = param_04 [[ param_03 ]](var_12,param_05,param_06,param_07);
				}
			}
			else if(!isdefined(param_04))
			{
				var_13 = [[ param_03 ]](var_12,param_05,param_06,param_07,param_08);
			}
			else
			{
				var_13 = param_04 [[ param_03 ]](var_12,param_05,param_06,param_07,param_08);
			}

			if(!isdefined(var_13) || var_13)
			{
				var_0F = 0;
				if(param_02 <= param_01)
				{
					wait(param_01);
					continue;
				}

				wait(randomfloatrange(param_01,param_02));
			}
		}
	}
}

//Function Number: 50
func_56F4()
{
	var_00 = gettime();
	if(isdefined(self.var_3D48) && var_00 < self.var_3D48)
	{
		return 1;
	}

	return 0;
}

//Function Number: 51
func_56B5()
{
	var_00 = gettime();
	if(isdefined(self.var_2577) && var_00 < self.var_2577)
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
func_56F2()
{
	var_00 = gettime();
	if(isdefined(self.var_3D39) && var_00 < self.var_3D39)
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
func_5701()
{
	var_00 = gettime();
	if(isdefined(self.var_3FE5) && var_00 < self.var_3FE5)
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
func_57D0()
{
	var_00 = gettime();
	if(isdefined(self.var_8C5E) && var_00 < self.var_8C5E)
	{
		return 1;
	}

	if(isdefined(self.var_8C5B) && var_00 < self.var_8C5B)
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
func_3C83(param_00)
{
	return isdefined(level.var_3C77[param_00]);
}

//Function Number: 56
func_3C77(param_00)
{
	return level.var_3C77[param_00];
}

//Function Number: 57
func_3C89(param_00)
{
	if(!func_3C83(param_00))
	{
		return 0;
	}

	return func_3C77(param_00);
}

//Function Number: 58
func_51D1()
{
	level.var_3C77 = [];
	level.var_3CC6 = [];
	level.var_402A = 0;
	if(!isdefined(level.var_8F64))
	{
		level.var_8F64 = ::func_35FA;
	}

	level.var_3C92 = spawnstruct();
	level.var_3C92 func_10DA();
}

//Function Number: 59
func_3C87(param_00)
{
	if(!isdefined(level.var_3C77))
	{
		func_51D1();
	}

	level.var_3C77[param_00] = 0;
	if(!isdefined(level.var_9D7B))
	{
		func_5275();
		level.var_9D7B[param_00] = [];
	}
	else if(!isdefined(level.var_9D7B[param_00]))
	{
		level.var_9D7B[param_00] = [];
	}

	if(func_578E(param_00,"aa_"))
	{
		thread [[ level.var_8F64 ]](param_00);
	}
}

//Function Number: 60
func_35FA(param_00)
{
}

//Function Number: 61
func_57E9(param_00,param_01,param_02,param_03)
{
	if(param_01.size > param_00.size)
	{
		return 0;
	}

	var_04 = getsubstr(param_00,param_02,param_03);
	return var_04 == param_01;
}

//Function Number: 62
func_578E(param_00,param_01)
{
	return func_57E9(param_00,param_01,0,param_01.size);
}

//Function Number: 63
func_57EF(param_00,param_01)
{
	return func_57E9(param_00,param_01,param_00.size - param_01.size,param_00.size);
}

//Function Number: 64
func_3C8F(param_00,param_01)
{
	level.var_3C77[param_00] = 1;
	func_85AF(param_00);
	if(isdefined(param_01))
	{
		level notify(param_00,param_01);
		return;
	}

	level notify(param_00);
}

//Function Number: 65
func_10DA()
{
	self.var_A01E = "generic" + level.var_402A;
	level.var_402A++;
}

//Function Number: 66
func_3C9F(param_00)
{
	var_01 = undefined;
	while(!func_3C77(param_00))
	{
		var_01 = undefined;
		level waittill(param_00,var_01);
	}

	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 67
func_3C7B(param_00,param_01)
{
	if(!func_3C77(param_00))
	{
		return;
	}

	level.var_3C77[param_00] = 0;
	func_85AF(param_00);
	if(isdefined(param_01))
	{
		level notify(param_00,param_01);
		return;
	}

	level notify(param_00);
}

//Function Number: 68
func_3CA9(param_00)
{
	var_01 = undefined;
	while(func_3C77(param_00))
	{
		var_01 = undefined;
		level waittill(param_00,var_01);
	}

	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 69
func_3799(param_00)
{
	if(!isdefined(self.var_3794))
	{
		self.var_3794 = [];
		self.var_37A3 = [];
	}

	self.var_3794[param_00] = 0;
}

//Function Number: 70
func_3798(param_00)
{
	if(isdefined(self.var_3794) && isdefined(self.var_3794[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 71
func_379B(param_00,param_01)
{
	self endon("death");
	wait(param_01);
	func_379A(param_00);
}

//Function Number: 72
func_379A(param_00)
{
	self.var_3794[param_00] = 1;
	self notify(param_00);
}

//Function Number: 73
func_3796(param_00,param_01)
{
	if(self.var_3794[param_00])
	{
		self.var_3794[param_00] = 0;
		self notify(param_00);
	}

	if(isdefined(param_01) && param_01)
	{
		self.var_3794[param_00] = undefined;
	}
}

//Function Number: 74
func_3797(param_00,param_01)
{
	wait(param_01);
	func_3796(param_00);
}

//Function Number: 75
func_3794(param_00)
{
	return self.var_3794[param_00];
}

//Function Number: 76
func_379C(param_00)
{
	while(isdefined(self) && !self.var_3794[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 77
func_37A0(param_00)
{
	while(isdefined(self) && !self.var_3794[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 78
func_379E(param_00,param_01)
{
	while(isdefined(self))
	{
		if(func_3794(param_00))
		{
			return;
		}

		if(func_3794(param_01))
		{
			return;
		}

		func_A732(param_00,param_01);
	}
}

//Function Number: 79
func_379F(param_00,param_01)
{
	var_02 = gettime();
	while(isdefined(self))
	{
		if(self.var_3794[param_00])
		{
			break;
		}

		if(gettime() >= var_02 + param_01 * 1000)
		{
			break;
		}

		func_37AF(param_00,param_01);
	}
}

//Function Number: 80
func_37AF(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 81
func_37A1(param_00)
{
	while(isdefined(self) && self.var_3794[param_00])
	{
		self waittill(param_00);
	}
}

//Function Number: 82
func_3795(param_00)
{
}

//Function Number: 83
func_37A2(param_00,param_01)
{
	while(isdefined(self))
	{
		if(!func_3794(param_00))
		{
			return;
		}

		if(!func_3794(param_01))
		{
			return;
		}

		func_A732(param_00,param_01);
	}
}

//Function Number: 84
func_A732(param_00,param_01)
{
	self endon(param_00);
	self waittill(param_01);
}

//Function Number: 85
func_0FB2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(param_0A))
	{
		foreach(var_0C in param_00)
		{
			var_0C thread [[ param_01 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		}

		return;
	}

	if(isdefined(var_0C))
	{
		foreach(var_0E in param_03)
		{
			var_0E thread [[ param_03 ]](param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0B);
		}

		return;
	}

	if(isdefined(var_0D))
	{
		foreach(var_10 in param_05)
		{
			var_10 thread [[ param_05 ]](param_06,param_07,param_08,param_09,param_0A,var_0B,var_0C);
		}

		return;
	}

	if(isdefined(var_0E))
	{
		foreach(var_12 in param_07)
		{
			var_12 thread [[ param_07 ]](param_08,param_09,param_0A,var_0B,var_0C,var_0D);
		}

		return;
	}

	if(isdefined(var_0F))
	{
		foreach(var_14 in param_09)
		{
			var_14 thread [[ param_09 ]](param_0A,var_0B,var_0C,var_0D,var_0E);
		}

		return;
	}

	if(isdefined(var_10))
	{
		foreach(var_16 in var_0B)
		{
			var_16 thread [[ var_0B ]](var_0C,var_0D,var_0E,var_0F);
		}

		return;
	}

	if(isdefined(var_11))
	{
		foreach(var_18 in var_0D)
		{
			var_18 thread [[ var_0D ]](var_0E,var_0F,var_10);
		}

		return;
	}

	if(isdefined(var_12))
	{
		foreach(var_1A in var_0F)
		{
			var_1A thread [[ var_0F ]](var_10,var_11);
		}

		return;
	}

	if(isdefined(var_13))
	{
		foreach(var_1C in var_11)
		{
			var_1C thread [[ var_11 ]](var_12);
		}

		return;
	}

	foreach(var_1E in var_13)
	{
		var_1E thread [[ var_13 ]]();
	}
}

//Function Number: 86
func_0F71(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_05))
	{
		foreach(var_07 in param_00)
		{
			var_07 [[ param_01 ]](param_02,param_03,param_04,param_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_09 in param_03)
		{
			var_09 [[ param_03 ]](param_04,param_05,var_06);
		}

		return;
	}

	if(isdefined(var_08))
	{
		foreach(var_0B in param_05)
		{
			var_0B [[ param_05 ]](var_06,var_07);
		}

		return;
	}

	if(isdefined(var_09))
	{
		foreach(var_0D in var_07)
		{
			var_0D [[ var_07 ]](var_08);
		}

		return;
	}

	foreach(var_0F in var_09)
	{
		var_0F [[ var_09 ]]();
	}
}

//Function Number: 87
func_6753(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			[[ param_01 ]](var_06,param_02,param_03,param_04);
		}

		return;
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			[[ param_03 ]](var_08,param_04,var_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			[[ var_05 ]](var_0A,var_06);
		}

		return;
	}

	foreach(var_0C in var_07)
	{
		[[ var_07 ]](var_0C);
	}
}

//Function Number: 88
func_0FB5(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_0FB2(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 89
func_0FB6(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_0FB2(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 90
func_9DA3(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		func_0FB2(var_02,::func_9DA4);
		return;
	}

	func_9DA4();
}

//Function Number: 91
func_9DA4()
{
	if(isdefined(self.var_7AC4))
	{
		self.var_116 = self.var_7AC4;
	}

	self.var_9D9F = undefined;
}

//Function Number: 92
func_9D9F(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		func_0FB2(var_02,::func_9DA1);
		return;
	}

	func_9DA1();
}

//Function Number: 93
func_9DA1()
{
	if(!isdefined(self.var_7AC4))
	{
		self.var_7AC4 = self.var_116;
	}

	if(self.var_116 == self.var_7AC4)
	{
		self.var_116 = self.var_116 + (0,0,-10000);
	}

	self.var_9D9F = 1;
}

//Function Number: 94
func_85AF(param_00)
{
	if(!isdefined(level.var_9D7B))
	{
		return;
	}

	level.var_9D7B[param_00] = func_0FA0(level.var_9D7B[param_00]);
	func_0FB2(level.var_9D7B[param_00],::func_A0D3);
}

//Function Number: 95
func_A0D3()
{
	var_00 = 1;
	if(isdefined(self.var_81A1))
	{
		var_00 = 0;
		var_01 = func_2798(self.var_81A1);
		foreach(var_03 in var_01)
		{
			if(func_3C77(var_03))
			{
				var_00 = 1;
				break;
			}
		}
	}

	var_05 = 1;
	if(isdefined(self.var_819E))
	{
		var_01 = func_2798(self.var_819E);
		foreach(var_03 in var_01)
		{
			if(func_3C77(var_03))
			{
				var_05 = 0;
				break;
			}
		}
	}

	[[ level.var_9D81[var_00 && var_05] ]]();
}

//Function Number: 96
func_2798(param_00)
{
	var_01 = strtok(param_00," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(level.var_3C77[var_01[var_02]]))
		{
			func_3C87(var_01[var_02]);
		}
	}

	return var_01;
}

//Function Number: 97
func_5275()
{
	level.var_9D7B = [];
	level.var_9D81[1] = ::func_9DA3;
	level.var_9D81[0] = ::func_9D9F;
}

//Function Number: 98
func_4395()
{
	if(isdefined(self.var_819A))
	{
		return self.var_819A;
	}
}

//Function Number: 99
func_46B5(param_00,param_01)
{
	var_02 = level.var_947C[param_01][param_00];
	if(!isdefined(var_02))
	{
		return undefined;
	}

	if(var_02.size > 1)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 100
func_46B7(param_00,param_01)
{
	var_02 = level.var_947C[param_01][param_00];
	if(!isdefined(var_02))
	{
		return [];
	}

	return var_02;
}

//Function Number: 101
func_44BD(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return func_46B5(param_00,param_01);
}

//Function Number: 102
func_44BE(param_00,param_01)
{
	var_02 = func_46B7(param_00,param_01);
	var_03 = getentarray(param_00,param_01);
	if(var_03.size > 0)
	{
		var_02 = func_0F73(var_02,var_03);
	}

	return var_02;
}

//Function Number: 103
func_44BF(param_00,param_01)
{
	var_02 = func_44BD(param_00,param_01);
	if(!isdefined(var_02))
	{
		var_02 = getnode(param_00,param_01);
	}

	if(!isdefined(var_02))
	{
		var_02 = getvehiclenode(param_00,param_01);
	}

	return var_02;
}

//Function Number: 104
func_44C0(param_00,param_01)
{
	var_02 = func_46B7(param_00,param_01);
	var_03 = getentarray(param_00,param_01);
	if(var_03.size > 0)
	{
		var_02 = func_0F73(var_02,var_03);
	}

	var_03 = getnodearray(param_00,param_01);
	if(var_03.size > 0)
	{
		var_02 = func_0F73(var_02,var_03);
	}

	var_03 = function_01DC(param_00,param_01);
	if(var_03.size > 0)
	{
		var_02 = func_0F73(var_02,var_03);
	}

	return var_02;
}

//Function Number: 105
func_947B()
{
	level.var_947C = [];
	level.var_947C["target"] = [];
	level.var_947C["targetname"] = [];
	level.var_947C["script_noteworthy"] = [];
	level.var_947C["script_linkname"] = [];
	foreach(var_01 in level.var_9478)
	{
		func_096C(var_01);
	}
}

//Function Number: 106
func_096C(param_00)
{
	if(isdefined(param_00.var_1A5))
	{
		if(!isdefined(level.var_947C["targetname"][param_00.var_1A5]))
		{
			level.var_947C["targetname"][param_00.var_1A5] = [];
		}

		var_01 = level.var_947C["targetname"][param_00.var_1A5].size;
		level.var_947C["targetname"][param_00.var_1A5][var_01] = param_00;
	}

	if(isdefined(param_00.var_1A2))
	{
		if(!isdefined(level.var_947C["target"][param_00.var_1A2]))
		{
			level.var_947C["target"][param_00.var_1A2] = [];
		}

		var_01 = level.var_947C["target"][param_00.var_1A2].size;
		level.var_947C["target"][param_00.var_1A2][var_01] = param_00;
	}

	if(isdefined(param_00.var_165))
	{
		if(!isdefined(level.var_947C["script_noteworthy"][param_00.var_165]))
		{
			level.var_947C["script_noteworthy"][param_00.var_165] = [];
		}

		var_01 = level.var_947C["script_noteworthy"][param_00.var_165].size;
		level.var_947C["script_noteworthy"][param_00.var_165][var_01] = param_00;
	}

	if(isdefined(param_00.var_164))
	{
		if(!isdefined(level.var_947C["script_linkname"][param_00.var_164]))
		{
			level.var_947C["script_linkname"][param_00.var_164] = [];
		}

		var_01 = level.var_947C["script_linkname"][param_00.var_164].size;
		level.var_947C["script_linkname"][param_00.var_164][var_01] = param_00;
	}
}

//Function Number: 107
func_3ABC(param_00)
{
}

//Function Number: 108
func_3ABA()
{
}

//Function Number: 109
func_3AB8(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}
}

//Function Number: 110
func_3AB9(param_00,param_01)
{
}

//Function Number: 111
func_3AB7()
{
}

//Function Number: 112
func_3AB6()
{
}

//Function Number: 113
func_3ABB(param_00)
{
}

//Function Number: 114
func_0F93(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(var_04 != param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 115
func_0F7D(param_00,param_01)
{
	var_02 = param_00;
	var_02 = func_0F94(var_02,param_01);
	return var_02;
}

//Function Number: 116
func_0F94(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		param_00 = func_0F93(param_00,var_03);
	}

	return param_00;
}

//Function Number: 117
func_0F98(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return undefined;
	}

	var_02 = [];
	foreach(var_04 in param_01)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(isdefined(param_00))
		{
			if(param_00 != var_04)
			{
				var_02[var_02.size] = var_04;
			}

			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 118
func_0FA0(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 119
func_0F97(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = 1;
		foreach(var_06 in var_01)
		{
			if(var_03 == var_06)
			{
				var_04 = 0;
				break;
			}
		}

		if(var_04)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 120
func_0F8A(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			thread [[ param_01 ]](var_06,param_02,param_03,param_04);
		}

		return;
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			thread [[ param_03 ]](var_08,param_04,var_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			thread [[ var_05 ]](var_0A,var_06);
		}

		return;
	}

	foreach(var_0C in var_07)
	{
		thread [[ var_07 ]](var_0C);
	}
}

//Function Number: 121
func_0F89(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		foreach(var_06 in param_00)
		{
			[[ param_01 ]](var_06,param_02,param_03,param_04);
		}

		return;
	}

	if(isdefined(var_06))
	{
		foreach(var_08 in param_03)
		{
			[[ param_03 ]](var_08,param_04,var_05);
		}

		return;
	}

	if(isdefined(var_07))
	{
		foreach(var_0A in var_05)
		{
			[[ var_05 ]](var_0A,var_06);
		}

		return;
	}

	foreach(var_0C in var_07)
	{
		[[ var_07 ]](var_0C);
	}
}

//Function Number: 122
func_0F8C(param_00,param_01)
{
	if(param_00.size == 0)
	{
		return param_01;
	}

	if(param_01.size == 0)
	{
		return param_00;
	}

	var_02 = param_00;
	foreach(var_04 in param_01)
	{
		var_05 = 0;
		foreach(var_07 in param_00)
		{
			if(var_07 == var_04)
			{
				var_05 = 1;
				break;
			}
		}

		if(var_05)
		{
			continue;
		}
		else
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 123
func_0972(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	if(!isdefined(param_00))
	{
		param_00[0] = param_01;
	}
	else
	{
		param_00[param_00.size] = param_01;
	}

	return param_00;
}

//Function Number: 124
func_0FA3(param_00,param_01,param_02)
{
	if(param_00.size <= 0)
	{
		return [];
	}

	if(!isdefined(param_02) || param_02 > param_00.size)
	{
		param_02 = param_00.size;
	}

	if(param_01 == 0 && param_02 == param_00.size)
	{
		return param_00;
	}

	var_03 = [];
	for(var_04 = param_01;var_04 < param_02;var_04++)
	{
		var_03[var_03.size] = param_00[var_04];
	}

	return var_03;
}

//Function Number: 125
func_3C78(param_00)
{
}

//Function Number: 126
func_3CA5(param_00,param_01)
{
	for(;;)
	{
		if(func_3C77(param_00))
		{
			return;
		}

		if(func_3C77(param_01))
		{
			return;
		}

		level func_A732(param_00,param_01);
	}
}

//Function Number: 127
func_3CA6(param_00,param_01)
{
	for(;;)
	{
		if(func_3C77(param_00))
		{
			return param_00;
		}

		if(func_3C77(param_01))
		{
			return param_01;
		}

		var_02 = level func_A715(param_00,param_01);
		return var_02;
	}
}

//Function Number: 128
func_3CAB(param_00,param_01)
{
	for(;;)
	{
		if(!func_3C77(param_00))
		{
			return param_00;
		}

		if(!func_3C77(param_01))
		{
			return param_01;
		}

		level func_A732(param_00,param_01);
	}
}

//Function Number: 129
func_3CAC(param_00,param_01)
{
	return func_3CAB(param_00,param_01);
}

//Function Number: 130
func_3CA3(param_00)
{
	foreach(var_02 in param_00)
	{
		if(func_3C77(var_02))
		{
			return var_02;
		}
	}

	return level func_A712(param_00);
}

//Function Number: 131
func_3CA2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	if(isdefined(param_05))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
		var_06[var_06.size] = param_03;
		var_06[var_06.size] = param_04;
		var_06[var_06.size] = param_05;
	}
	else if(isdefined(param_04))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
		var_06[var_06.size] = param_03;
		var_06[var_06.size] = param_04;
	}
	else if(isdefined(param_03))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
		var_06[var_06.size] = param_03;
	}
	else if(isdefined(param_02))
	{
		var_06[var_06.size] = param_00;
		var_06[var_06.size] = param_01;
		var_06[var_06.size] = param_02;
	}
	else if(isdefined(param_01))
	{
		func_3CA5(param_00,param_01);
		return;
	}
	else
	{
		return;
	}

	for(;;)
	{
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			if(func_3C77(var_06[var_07]))
			{
				return;
			}
		}

		level knock_off_battery(param_00,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 132
func_3CA4(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	if(isdefined(param_04))
	{
		var_05[var_05.size] = param_00;
		var_05[var_05.size] = param_01;
		var_05[var_05.size] = param_02;
		var_05[var_05.size] = param_03;
		var_05[var_05.size] = param_04;
	}
	else if(isdefined(param_03))
	{
		var_05[var_05.size] = param_00;
		var_05[var_05.size] = param_01;
		var_05[var_05.size] = param_02;
		var_05[var_05.size] = param_03;
	}
	else if(isdefined(param_02))
	{
		var_05[var_05.size] = param_00;
		var_05[var_05.size] = param_01;
		var_05[var_05.size] = param_02;
	}
	else if(isdefined(param_01))
	{
		var_06 = func_3CA6(param_00,param_01);
		return var_06;
	}
	else
	{
		return;
	}

	for(;;)
	{
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			if(func_3C77(var_06[var_07]))
			{
				return var_06[var_07];
			}
		}

		var_06 = level func_A715(param_01,param_02,param_03,param_04,var_05);
		return var_07;
	}
}

//Function Number: 133
func_3CA0(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		func_3C9F(param_00);
	}

	if(isdefined(param_01))
	{
		func_3C9F(param_01);
	}

	if(isdefined(param_02))
	{
		func_3C9F(param_02);
	}

	if(isdefined(param_03))
	{
		func_3C9F(param_03);
	}
}

//Function Number: 134
func_3CA1(param_00)
{
	param_00 = func_0FA0(param_00);
	for(;;)
	{
		foreach(var_02 in param_00)
		{
			func_3C9F(var_02);
		}

		var_04 = 0;
		foreach(var_02 in param_00)
		{
			if(func_3C77(var_02))
			{
				var_04++;
			}
		}

		if(var_04 == param_00.size)
		{
			break;
		}
	}
}

//Function Number: 135
func_3CA8(param_00,param_01)
{
	var_02 = param_01 * 1000;
	var_03 = gettime();
	for(;;)
	{
		if(func_3C77(param_00))
		{
			break;
		}

		if(gettime() >= var_03 + var_02)
		{
			break;
		}

		var_04 = var_02 - gettime() - var_03;
		var_05 = var_04 / 1000;
		func_A64B(param_00,var_05);
	}
}

//Function Number: 136
func_3CAD(param_00,param_01)
{
	var_02 = gettime();
	for(;;)
	{
		if(!func_3C77(param_00))
		{
			break;
		}

		if(gettime() >= var_02 + param_01 * 1000)
		{
			break;
		}

		func_A64B(param_00,param_01);
	}
}

//Function Number: 137
func_A64B(param_00,param_01)
{
	level endon(param_00);
	wait(param_01);
}

//Function Number: 138
func_2CBE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	thread func_2CBF(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 139
func_2CBF(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(func_57D7())
	{
		self endon("death");
		self endon("stop_delay_call");
	}

	wait(param_01);
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_0A))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		return;
	}

	if(isdefined(param_09))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		return;
	}

	if(isdefined(param_08))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		return;
	}

	if(isdefined(param_07))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		self [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		self [[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self [[ param_00 ]](param_02);
		return;
	}

	self [[ param_00 ]]();
}

//Function Number: 140
func_2CB7(param_00)
{
	self endon("death");
	self notify("cancel_delayed_show");
	self endon("cancel_delayed_show");
	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}

	if(isdefined(self))
	{
		self method_805B();
	}
}

//Function Number: 141
func_2CB4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	thread func_2CB5(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 142
func_2CB5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	wait(param_01);
	if(isdefined(param_0A))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		return;
	}

	if(isdefined(param_09))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		return;
	}

	if(isdefined(param_08))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		return;
	}

	if(isdefined(param_07))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		self [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		self [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		self [[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self [[ param_00 ]](param_02);
		return;
	}

	self [[ param_00 ]]();
}

//Function Number: 143
func_8134(param_00)
{
	switch(param_00.size)
	{
		case 1:
			return self [[ param_00[0] ]]();

		case 2:
			return self [[ param_00[0] ]](param_00[1]);

		case 3:
			return self [[ param_00[0] ]](param_00[1],param_00[2]);

		case 4:
			return self [[ param_00[0] ]](param_00[1],param_00[2],param_00[3]);

		case 5:
			return self [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4]);

		case 6:
			return self [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4],param_00[5]);

		case 7:
			return self [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4],param_00[5],param_00[6]);

		case 8:
			return self [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4],param_00[5],param_00[6],param_00[7]);

		default:
			break;
	}
}

//Function Number: 144
func_8133(param_00,param_01)
{
	if(!isdefined(param_01) || param_01.size == 0)
	{
		self [[ param_00 ]]();
		return;
	}

	switch(param_01.size)
	{
		case 1:
			self [[ param_00 ]](param_01[0]);
			break;

		case 2:
			self [[ param_00 ]](param_01[0],param_01[1]);
			break;

		case 3:
			self [[ param_00 ]](param_01[0],param_01[1],param_01[2]);
			break;

		case 4:
			self [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3]);
			break;

		case 5:
			self [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4]);
			break;

		case 6:
			self [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5]);
			break;

		case 7:
			self [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6]);
			break;

		case 8:
			self [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7]);
			break;

		default:
			break;
	}
}

//Function Number: 145
func_248D(param_00)
{
	switch(param_00.size)
	{
		case 1:
			return [[ param_00[0] ]]();

		case 2:
			return [[ param_00[0] ]](param_00[1]);

		case 3:
			return [[ param_00[0] ]](param_00[1],param_00[2]);

		case 4:
			return [[ param_00[0] ]](param_00[1],param_00[2],param_00[3]);

		case 5:
			return [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4]);

		case 6:
			return [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4],param_00[5]);

		case 7:
			return [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4],param_00[5],param_00[6]);

		case 8:
			return [[ param_00[0] ]](param_00[1],param_00[2],param_00[3],param_00[4],param_00[5],param_00[6],param_00[7]);

		default:
			break;
	}
}

//Function Number: 146
func_6754(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread func_6755(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 147
func_6755(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	wait(param_01);
	if(isdefined(param_07))
	{
		[[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		[[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		[[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		[[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		[[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		[[ param_00 ]](param_02);
		return;
	}

	[[ param_00 ]]();
}

//Function Number: 148
func_57D7()
{
	if(!isdefined(level.var_57D7))
	{
		level.var_57D7 = !func_9467(getdvar("1673"),"mp_");
	}

	return level.var_57D7;
}

//Function Number: 149
func_57D8()
{
	if(!isdefined(level.var_57D8))
	{
		level.var_57D8 = func_9467(getdvar("1673"),"so_td_");
	}

	return level.var_57D8;
}

//Function Number: 150
func_9467(param_00,param_01)
{
	if(param_00.size < param_01.size)
	{
		return 0;
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(tolower(param_00[var_02]) != tolower(param_01[var_02]))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 151
func_9462(param_00,param_01)
{
	if(param_00.size < param_01.size)
	{
		return -1;
	}

	if(param_01.size == 0)
	{
		return 0;
	}

	var_02 = 0;
	var_03 = 0;
	while(var_02 < param_00.size)
	{
		if(tolower(param_00[var_02]) == tolower(param_01[var_03]))
		{
			var_03++;
		}
		else
		{
			var_03 = 0;
			if(tolower(param_00[var_02]) == tolower(param_01[var_03]))
			{
				var_03++;
			}
			else if(var_02 > param_00.size - param_01.size)
			{
				return -1;
			}
		}

		if(var_03 >= param_01.size)
		{
			return var_02 - var_03 + 1;
		}

		var_02++;
	}

	return -1;
}

//Function Number: 152
func_74F1(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00[0];
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.05;
	}

	for(var_06 = 1;var_06 < param_00.size;var_06++)
	{
		thread func_33BA(var_05,param_00[var_06],param_01,param_02,param_03,param_04);
		var_05 = param_00[var_06];
	}
}

//Function Number: 153
func_33BA(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}
}

//Function Number: 154
func_9580(param_00,param_01)
{
	var_02 = [];
	foreach(var_05, var_04 in param_00)
	{
		var_02[var_05] = var_04;
	}

	foreach(var_05, var_04 in param_01)
	{
		var_02[var_05] = var_04;
	}

	return var_02;
}

//Function Number: 155
func_0F73(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isdefined(var_05) || param_02)
		{
			var_03[var_03.size] = var_05;
		}
	}

	foreach(var_05 in param_01)
	{
		if(isdefined(var_05) || param_02)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 156
func_0F76(param_00,param_01)
{
	var_02 = [];
	foreach(var_05, var_04 in param_00)
	{
		var_02[var_05] = var_04;
	}

	foreach(var_05, var_04 in param_01)
	{
		var_02[var_05] = var_04;
	}

	return var_02;
}

//Function Number: 157
func_0F92(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = randomint(param_00.size);
		var_03 = param_00[var_01];
		param_00[var_01] = param_00[var_02];
		param_00[var_02] = var_03;
	}

	return param_00;
}

//Function Number: 158
func_0F6F(param_00,param_01)
{
	param_00[param_00.size] = param_01;
	return param_00;
}

//Function Number: 159
func_0F82(param_00)
{
	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		var_01 = var_03;
		break;
	}

	return var_01;
}

//Function Number: 160
func_0F88(param_00,param_01)
{
	var_02 = [];
	var_03 = 0;
	foreach(var_06, var_05 in param_00)
	{
		if(var_03 < param_01)
		{
			var_02[var_06] = var_05;
		}
		else
		{
			break;
		}

		var_03++;
	}

	return var_02;
}

//Function Number: 161
func_0F86(param_00,param_01,param_02)
{
	if(param_02 == param_00.size)
	{
		var_03 = param_00;
		var_03[var_03.size] = param_01;
		return var_03;
	}

	var_03 = [];
	var_04 = 0;
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		if(var_05 == param_02)
		{
			var_03[var_05] = param_01;
			var_04 = 1;
		}

		var_03[var_05 + var_04] = param_00[var_05];
	}

	return var_03;
}

//Function Number: 162
func_0F9B(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] != param_01)
		{
			var_02[var_02.size] = param_00[var_03];
		}
	}

	return var_02;
}

//Function Number: 163
func_0F9A(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		if(var_02 == param_01)
		{
			param_00[var_02] = param_00[var_02 + 1];
			param_01++;
		}
	}

	param_00[param_00.size - 1] = undefined;
	return param_00;
}

//Function Number: 164
func_0F8E(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		var_04 notify(param_01,param_02);
	}
}

//Function Number: 165
func_0F79(param_00,param_01)
{
	if(param_00.size <= 0)
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 166
func_0F7E(param_00,param_01)
{
	foreach(var_04, var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 167
func_0F78(param_00,param_01)
{
	if(param_00.size != param_01.size)
	{
		return 0;
	}

	foreach(var_05, var_03 in param_00)
	{
		if(!isdefined(param_01[var_05]))
		{
			return 0;
		}

		var_04 = param_01[var_05];
		if(var_04 != var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 168
func_3D5C(param_00)
{
	var_01 = (0,param_00[1],0);
	return var_01;
}

//Function Number: 169
func_3D5D(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	return var_01;
}

//Function Number: 170
func_33A0(param_00,param_01,param_02,param_03)
{
	level endon("newpath");
	var_04 = [];
	var_05 = vectortoangles(param_00 - param_01);
	var_06 = anglestoright(var_05);
	var_07 = anglestoforward(var_05);
	var_08 = anglestoup(var_05);
	var_09 = distance(param_00,param_01);
	var_0A = [];
	var_0B = 0.1;
	var_0A[0] = param_00;
	var_0A[1] = param_00 + var_06 * var_09 * var_0B + var_07 * var_09 * -0.1;
	var_0A[2] = param_01;
	var_0A[3] = param_00 + var_06 * var_09 * -1 * var_0B + var_07 * var_09 * -0.1;
	var_0A[4] = param_00;
	var_0A[5] = param_00 + var_08 * var_09 * var_0B + var_07 * var_09 * -0.1;
	var_0A[6] = param_01;
	var_0A[7] = param_00 + var_08 * var_09 * -1 * var_0B + var_07 * var_09 * -0.1;
	var_0A[8] = param_00;
	var_0C = param_02[0];
	var_0D = param_02[1];
	var_0E = param_02[2];
	func_74F1(var_0A,var_0C,var_0D,var_0E,param_03);
}

//Function Number: 171
func_41F0()
{
	var_00 = [];
	if(isdefined(self.var_81EF))
	{
		var_01 = func_41F3();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = func_46B7(var_01[var_02],"script_linkname");
			if(var_03.size > 0)
			{
				var_00 = func_0F73(var_00,var_03);
			}
		}
	}

	return var_00;
}

//Function Number: 172
func_41ED()
{
	var_00 = [];
	if(isdefined(self.var_81EF))
	{
		var_01 = func_41F3();
		foreach(var_03 in var_01)
		{
			var_04 = getentarray(var_03,"script_linkname");
			if(var_04.size > 0)
			{
				var_00 = func_0F73(var_00,var_04);
			}
		}
	}

	return var_00;
}

//Function Number: 173
func_41EE()
{
	var_00 = [];
	if(isdefined(self.var_81EF))
	{
		var_01 = func_41F3();
		foreach(var_03 in var_01)
		{
			var_04 = getnodearray(var_03,"script_linkname");
			if(var_04.size > 0)
			{
				var_00 = func_0F73(var_00,var_04);
			}
		}
	}

	return var_00;
}

//Function Number: 174
func_41F2()
{
	var_00 = [];
	if(isdefined(self.var_81EF))
	{
		var_01 = func_41F3();
		foreach(var_03 in var_01)
		{
			var_04 = function_01DC(var_03,"script_linkname");
			if(var_04.size > 0)
			{
				var_00 = func_0F73(var_00,var_04);
			}
		}
	}

	return var_00;
}

//Function Number: 175
func_41EC()
{
	var_00 = func_41ED();
	return var_00[0];
}

//Function Number: 176
func_41F1()
{
	var_00 = func_41F2();
	return var_00[0];
}

//Function Number: 177
func_41F3()
{
	return strtok(self.var_81EF," ");
}

//Function Number: 178
func_7F77(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"targetname");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
	var_05 = func_46B7(param_00,"targetname");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
	var_05 = [[ level.var_45B1 ]](param_00,"targetname");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
	var_05 = function_01DC(param_00,"targetname");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 179
func_7F76(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"script_noteworthy");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
	var_05 = func_46B7(param_00,"script_noteworthy");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
	var_05 = [[ level.var_45B1 ]](param_00,"script_noteworthy");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
	var_05 = function_01DC(param_00,"script_noteworthy");
	func_0FB2(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 180
func_339D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = -1 * param_04;
	var_09 = undefined;
	for(var_0A = 0;var_0A <= param_05;var_0A++)
	{
		var_0B = vectornormalize(rotatevector(param_03,(0,var_08,0)));
		var_0C = var_0B * param_01;
		if(var_0A == 0 || var_0A == param_05)
		{
		}

		if(isdefined(var_09))
		{
		}

		var_09 = var_0C;
		var_08 = var_08 + param_04 * 2 * 1 / param_05;
	}
}

//Function Number: 181
func_339F(param_00,param_01,param_02)
{
	level endon("newpath");
	var_03 = [];
	var_04 = vectortoangles(param_00 - param_01);
	var_05 = anglestoright(var_04);
	var_06 = anglestoforward(var_04);
	var_07 = distance(param_00,param_01);
	var_08 = [];
	var_09 = 0.05;
	var_08[0] = param_00;
	var_08[1] = param_00 + var_05 * var_07 * var_09 + var_06 * var_07 * -0.2;
	var_08[2] = param_01;
	var_08[3] = param_00 + var_05 * var_07 * -1 * var_09 + var_06 * var_07 * -0.2;
	for(var_0A = 0;var_0A < 4;var_0A++)
	{
		var_0B = var_0A + 1;
		if(var_0B >= 4)
		{
			var_0B = 0;
		}
	}
}

//Function Number: 182
func_33B7(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = (0,1,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.05;
	}

	if(param_03)
	{
		var_05 = int(param_04 / 0.05);
	}
	else
	{
		var_05 = int(param_02 / 0.05);
	}

	var_06 = [];
	var_07 = [];
	var_08 = gettime();
	var_09 = var_08 + param_01 * 1000;
	while(var_08 < var_09 && isdefined(param_00))
	{
		var_06[0] = param_00 method_8216(1,1,1);
		var_06[1] = param_00 method_8216(1,1,-1);
		var_06[2] = param_00 method_8216(-1,1,-1);
		var_06[3] = param_00 method_8216(-1,1,1);
		var_07[0] = param_00 method_8216(1,-1,1);
		var_07[1] = param_00 method_8216(1,-1,-1);
		var_07[2] = param_00 method_8216(-1,-1,-1);
		var_07[3] = param_00 method_8216(-1,-1,1);
		for(var_0A = 0;var_0A < 4;var_0A++)
		{
			var_0B = var_0A + 1;
			if(var_0B == 4)
			{
				var_0B = 0;
			}
		}

		if(!param_03)
		{
			return;
		}

		wait(param_04);
		var_08 = gettime();
	}
}

//Function Number: 183
func_33D1(param_00,param_01,param_02,param_03,param_04)
{
	func_33B7(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 184
func_33CD(param_00,param_01,param_02,param_03,param_04)
{
	func_33B7(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 185
func_339C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = getanimlength(param_00);
	if(!isdefined(param_04))
	{
		param_04 = var_07;
	}

	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	var_08 = 0.05;
	for(var_09 = 0;var_09 <= var_07;var_09 = var_09 + var_08)
	{
		var_0A = param_06 * getmovedelta(param_00,0,var_09 / var_07);
		var_0B = param_06 * getmovedelta(param_00,0,min(var_09 + 0.05 / var_07,1));
		var_0C = transformmove(param_01,param_02,(0,0,0),(0,0,0),var_0A,(0,0,0))["origin"];
		var_0D = transformmove(param_01,param_02,(0,0,0),(0,0,0),var_0B,(0,0,0))["origin"];
		func_33A0(var_0C,var_0D,param_03,param_04);
		if(isdefined(param_05) && var_09 + var_08 >= var_07)
		{
		}
	}
}

//Function Number: 186
func_44F5(param_00)
{
	return level.var_611[param_00];
}

//Function Number: 187
func_3F6F(param_00)
{
	return isdefined(level.var_611[param_00]);
}

//Function Number: 188
gator_mouth(param_00,param_01)
{
	var_02 = param_01 + "," + param_00;
	if(isdefined(level.var_2895[var_02]))
	{
		return;
	}

	level.var_2895[var_02] = 1;
}

//Function Number: 189
func_3AB2(param_00)
{
}

//Function Number: 190
func_4550()
{
	return self.var_8061;
}

//Function Number: 191
func_747D()
{
}

//Function Number: 192
func_5818()
{
	return !self.var_2F80;
}

//Function Number: 193
func_0601()
{
	if(!isdefined(self.var_2F80))
	{
		self.var_2F80 = 0;
	}

	self.var_2F80++;
	self disableusability();
}

//Function Number: 194
func_0615()
{
	if(!isdefined(self.var_2F80))
	{
		self.var_2F80 = 0;
		return;
	}

	if(self.var_2F80 > 0)
	{
		self.var_2F80--;
		if(self.var_2F80 == 0)
		{
			self enableusability();
			return;
		}
	}
}

//Function Number: 195
func_7D75()
{
	self.var_2F80 = 0;
	self enableusability();
}

//Function Number: 196
func_0602()
{
	if(!isdefined(self.var_2F81))
	{
		self.var_2F81 = 0;
	}

	self.var_2F81++;
	self method_8322();
}

//Function Number: 197
func_0616()
{
	if(!isdefined(self.var_2F81))
	{
		self.var_2F81 = 0;
	}

	self.var_2F81--;
	if(!self.var_2F81)
	{
		self method_8323();
	}
}

//Function Number: 198
func_5851()
{
	return !self.var_2F81;
}

//Function Number: 199
func_0603()
{
	if(!isdefined(self.var_2F82))
	{
		self.var_2F82 = 0;
	}

	self.var_2F82++;
	self method_8326();
}

//Function Number: 200
func_0617()
{
	if(!isdefined(self.var_2F82))
	{
		self.var_2F82 = 0;
	}

	self.var_2F82--;
	if(!self.var_2F82)
	{
		self method_8327();
	}
}

//Function Number: 201
func_0668()
{
	return !self.var_2F82;
}

//Function Number: 202
func_0600()
{
	if(!isdefined(self.var_2F7E))
	{
		self.var_2F7E = 0;
	}

	self.var_2F7E++;
	self method_8324();
}

//Function Number: 203
func_0614()
{
	if(!isdefined(self.var_2F7E))
	{
		self.var_2F7E = 0;
	}

	self.var_2F7E--;
	if(!self.var_2F7E)
	{
		self method_8325();
	}
}

//Function Number: 204
func_5763()
{
	return !self.var_2F7E;
}

//Function Number: 205
func_0613(param_00,param_01)
{
	if(!self hasweapon(param_00))
	{
		return;
	}

	if(self getdetonateenabled(param_00) == param_01)
	{
		return;
	}

	self enabledetonate(param_00,param_01);
	if(param_01)
	{
		self notify("WeaponDetonateEnabled",param_00);
		return;
	}

	self notify("WeaponDetonateDisabled",param_00);
}

//Function Number: 206
func_7A33(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03;
	}

	if(!var_01.size)
	{
		return undefined;
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 207
func_7A46(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03;
	}

	if(!var_01.size)
	{
		return undefined;
	}

	var_05 = randomint(var_01.size * var_01.size);
	return var_01[var_01.size - 1 - int(sqrt(var_05))];
}

//Function Number: 208
func_7A45(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	foreach(var_04 in param_00)
	{
		var_05 = 1;
		if(isdefined(var_04.var_82E9))
		{
			var_05 = max(1,int(var_04.var_82E9));
		}

		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			var_01 = var_01 + 1;
			if(randomfloatrange(0,1) <= 1 / var_01)
			{
				var_02 = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 209
func_8FFC()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 method_805C();
	if(isdefined(self.var_116))
	{
		var_00.var_116 = self.var_116;
	}

	if(isdefined(self.var_1D))
	{
		var_00.var_1D = self.var_1D;
	}

	return var_00;
}

//Function Number: 210
func_A74B(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 211
func_A74D(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
	return "timeout";
}

//Function Number: 212
func_3AB5()
{
	level.var_3ABD = 0;
	level.var_3AB3 = 1;
	func_3AB3("GAMEPRINTSTARTFILE:");
}

//Function Number: 213
func_3AB3(param_00)
{
	level.var_3ABD++;
	if(level.var_3ABD > 200)
	{
		wait 0.05;
		level.var_3ABD = 0;
	}
}

//Function Number: 214
func_3AB4(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		func_3AB3("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + param_00);
	}
	else
	{
		func_3AB3("GAMEPRINTENDFILE:" + param_00);
	}

	var_02 = gettime() + 4000;
	while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_02)
	{
		wait 0.05;
	}

	if(!gettime() < var_02)
	{
		iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
		level.var_3AB3 = undefined;
		return 0;
	}

	var_03 = getdvar("LAUNCHER_PRINT_FAIL");
	if(var_03 != "0")
	{
		iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var_03 + " ): launcherconflict? restart launcher and try again? ");
		level.var_3AB3 = undefined;
		return 0;
	}

	level.var_3AB3 = undefined;
	return 1;
}

//Function Number: 215
func_5C25(param_00)
{
	level.var_3ABD = 0;
	func_3AB3("LAUNCHER_CLIP:" + param_00);
}

//Function Number: 216
func_56C3()
{
	if(!isdefined(self))
	{
		return 0;
	}

	return isdefined(self.var_75);
}

//Function Number: 217
func_6F21()
{
	common_scripts\_createfx::func_93CD();
}

//Function Number: 218
func_0894()
{
	common_scripts\_exploder::func_895();
}

//Function Number: 219
func_4375(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.var_1A2;
	}

	var_01 = getent(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(func_57D7())
	{
		var_01 = [[ level.var_45B4 ]](param_00,"targetname");
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_01 = func_46B5(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = getvehiclenode(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 220
func_424D(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(func_57D7())
	{
		var_01 = [[ level.var_45B4 ]](param_00,"script_noteworthy");
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_01 = func_46B5(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = getvehiclenode(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 221
func_30AE(param_00,param_01)
{
	var_02 = level.var_353D[param_00];
	earthquake(var_02["magnitude"],var_02["duration"],param_01,var_02["radius"]);
}

//Function Number: 222
func_7157(param_00,param_01)
{
	if(!function_0344(param_00))
	{
		return;
	}

	var_02 = spawn("script_origin",(0,0,0));
	if(!isdefined(param_01))
	{
		param_01 = self.var_116;
	}

	var_02.var_116 = param_01;
	var_02 method_861D(param_00);
	return var_02;
}

//Function Number: 223
func_71AA(param_00,param_01,param_02,param_03)
{
	if(!function_0344(param_00))
	{
		return;
	}

	var_04 = spawn("script_origin",(0,0,1));
	if(!isdefined(param_01))
	{
		param_01 = self.var_116;
	}

	var_04.var_116 = param_01;
	var_04.var_1D = param_02;
	if(isdefined(param_03) && param_03)
	{
		var_04 method_861C(param_00,"sounddone");
	}
	else
	{
		var_04 method_8617(param_00,"sounddone");
	}

	var_04 waittill("sounddone");
	var_04 delete();
}

//Function Number: 224
func_71A9(param_00,param_01,param_02)
{
	func_71AA(param_00,param_01,(0,0,0),param_02);
}

//Function Number: 225
func_5EDF(param_00,param_01,param_02,param_03,param_04)
{
	if(!function_0344(param_00))
	{
		return;
	}

	if(isdefined(param_03))
	{
		param_02 = undefined;
	}

	self.var_A265["snd_ent"] = func_3F50(param_00,param_01);
	if(isdefined(param_03))
	{
		thread func_5EE9(param_03);
	}
}

//Function Number: 226
func_5EE2(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!function_0344(param_00))
	{
		return;
	}

	func_5EDF(param_00,param_01,param_03,param_04,param_05);
}

//Function Number: 227
func_5EE0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_5EE1(param_00,param_01,(0,0,0),param_02,param_03,param_04,param_05);
}

//Function Number: 228
func_5EE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	if(param_05 >= param_06)
	{
		wait 0.05;
	}

	if(!function_0344(param_00))
	{
		wait 0.05;
	}

	for(;;)
	{
		wait(randomfloatrange(param_05,param_06));
		func_5E61("createfx_looper");
		func_3F50(param_00,param_01);
		func_A038("createfx_looper");
	}
}

//Function Number: 229
func_3F50(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(!function_0344(param_00))
	{
		return undefined;
	}

	if(issoundaliaslooping(param_00))
	{
		var_03 = 0.05;
	}

	var_04 = spawnsoundentity(param_00,param_01,var_02,var_03);
	return var_04;
}

//Function Number: 230
func_3F51()
{
	if(isdefined(self) && isdefined(self.var_A265["snd_ent"]))
	{
		self.var_A265["snd_ent"] method_863F(0.05);
		self.var_A265["snd_ent"] = undefined;
	}
}

//Function Number: 231
func_5EE9(param_00)
{
	var_01 = self.var_A265["snd_ent"];
	self endon("death");
	self waittill(param_00);
	if(isdefined(var_01))
	{
		var_01 method_863F(0.05);
	}
}

//Function Number: 232
func_2814(param_00)
{
	var_01 = common_scripts\_createfx::func_27E5("loopfx",param_00);
	var_01.var_A265["delay"] = common_scripts\_createfx::func_4566();
	return var_01;
}

//Function Number: 233
func_281B(param_00)
{
	var_01 = common_scripts\_createfx::func_27E5("oneshotfx",param_00);
	var_01.var_A265["delay"] = common_scripts\_createfx::func_45D9();
	return var_01;
}

//Function Number: 234
func_27E7(param_00)
{
	var_01 = common_scripts\_createfx::func_27E5("exploder",param_00);
	var_01.var_A265["delay"] = common_scripts\_createfx::func_44D0();
	var_01.var_A265["exploder_type"] = "normal";
	return var_01;
}

//Function Number: 235
func_0C9E(param_00)
{
	if(param_00.size <= 1)
	{
		return param_00;
	}

	var_01 = 0;
	for(var_02 = param_00.size - 1;var_02 >= 1;var_02--)
	{
		var_03 = param_00[var_02];
		var_04 = var_02;
		for(var_05 = 0;var_05 < var_02;var_05++)
		{
			var_06 = param_00[var_05];
			if(stricmp(var_06,var_03) > 0)
			{
				var_03 = var_06;
				var_04 = var_05;
			}
		}

		if(var_04 != var_02)
		{
			param_00[var_04] = param_00[var_02];
			param_00[var_02] = var_03;
		}
	}

	return param_00;
}

//Function Number: 236
func_55AF(param_00,param_01)
{
	return stricmp(param_00,param_01) > 0;
}

//Function Number: 237
func_7153(param_00,param_01)
{
	if(!function_0344(param_00))
	{
		return;
	}

	var_02 = spawn("script_origin",(0,0,0));
	var_02 endon("death");
	thread func_2D18(var_02);
	if(isdefined(param_01))
	{
		var_02.var_116 = self.var_116 + param_01;
		var_02.var_1D = self.var_1D;
		var_02 method_8449(self);
	}
	else
	{
		var_02.var_116 = self.var_116;
		var_02.var_1D = self.var_1D;
		var_02 method_8449(self);
	}

	var_02 method_861D(param_00);
	self waittill("stop sound" + param_00);
	var_02 stoploopsound(param_00);
	var_02 delete();
}

//Function Number: 238
func_93D5(param_00)
{
	self notify("stop sound" + param_00);
}

//Function Number: 239
func_2D18(param_00)
{
	param_00 endon("death");
	knock_off_battery("death","disconnect");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 240
func_3809(param_00)
{
}

//Function Number: 241
func_2793(param_00,param_01)
{
	setdvarifuninitialized(param_00,param_01);
}

//Function Number: 242
func_A60A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
}

//Function Number: 243
func_95AC(param_00,param_01)
{
	var_02 = self gettagorigin(param_00);
	var_03 = self gettagangles(param_00);
	var_04 = anglestoforward(var_03);
	var_04 = vectornormalize(var_04) * param_01;
	return var_02 + var_04;
}

//Function Number: 244
func_98E7(param_00,param_01,param_02)
{
	if(param_00)
	{
		return param_01;
	}

	return param_02;
}

//Function Number: 245
func_27A6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(level.var_5E61))
	{
		level.var_5E61 = [];
	}

	var_02 = spawnstruct();
	var_02.var_6048 = param_01;
	var_02.var_5C = 0;
	level.var_5E61[param_00] = var_02;
}

//Function Number: 246
func_5E62(param_00)
{
	if(!isdefined(level.var_5E61))
	{
		return 0;
	}

	return isdefined(level.var_5E61[param_00]);
}

//Function Number: 247
func_5E61(param_00)
{
	for(var_01 = level.var_5E61[param_00];var_01.var_5C >= var_01.var_6048;var_01 waittill("unlocked"))
	{
	}

	var_01.var_5C++;
}

//Function Number: 248
func_55B2(param_00)
{
	var_01 = level.var_5E61[param_00];
	return var_01.var_5C > var_01.var_6048;
}

//Function Number: 249
func_A03A(param_00)
{
	thread func_A039(param_00);
	wait 0.05;
}

//Function Number: 250
func_A038(param_00)
{
	thread func_A039(param_00);
}

//Function Number: 251
func_A039(param_00)
{
	wait 0.05;
	var_01 = level.var_5E61[param_00];
	var_01.var_5C--;
	var_01 notify("unlocked");
}

//Function Number: 252
func_4381()
{
	var_00 = level.var_15D;
	if(isdefined(level.var_98DC))
	{
		var_00 = level.var_98DC;
	}

	return var_00;
}

//Function Number: 253
func_0FA2(param_00)
{
	var_01 = [];
	var_02 = param_00.size > 0 && isstring(getfirstarraykey(param_00));
	if(var_02)
	{
		var_03 = getarraykeys(param_00);
		for(var_04 = var_03.size - 1;var_04 >= 0;var_04--)
		{
			var_05 = var_03[var_04];
			var_01[var_05] = param_00[var_05];
		}
	}
	else
	{
		for(var_04 = var_01.size - 1;var_04 >= 0;var_04--)
		{
			var_01[var_01.size] = param_00[var_04];
		}
	}

	return var_01;
}

//Function Number: 254
func_302B(param_00,param_01)
{
	return length2dsquared(param_00 - param_01);
}

//Function Number: 255
func_40B1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_40B0(param_00,param_01,param_02,param_03,param_04,param_05);
	var_06 = func_0FA2(var_06);
	return var_06;
}

//Function Number: 256
func_40B0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = param_01.size;
	}

	if(!isdefined(param_02))
	{
		param_02 = [];
	}

	var_06 = undefined;
	if(isdefined(param_04))
	{
		var_06 = param_04 * param_04;
	}

	var_07 = 0;
	if(isdefined(param_05))
	{
		var_07 = param_05 * param_05;
	}

	if(param_02.size == 0 && param_03 >= param_01.size && var_07 == 0 && !isdefined(var_06))
	{
		return function_01AC(param_01,param_00);
	}

	var_08 = [];
	foreach(var_0A in param_01)
	{
		var_0B = 0;
		foreach(var_0D in param_02)
		{
			if(var_0A == var_0D)
			{
				var_0B = 1;
				break;
			}
		}

		if(var_0B)
		{
			continue;
		}

		var_0F = distancesquared(param_00,var_0A.var_116);
		if(isdefined(var_06) && var_0F > var_06)
		{
			continue;
		}

		if(var_0F < var_07)
		{
			continue;
		}

		var_08[var_08.size] = var_0A;
	}

	var_08 = function_01AC(var_08,param_00);
	if(param_03 >= var_08.size)
	{
		return var_08;
	}

	var_11 = [];
	for(var_12 = 0;var_12 < param_03;var_12++)
	{
		var_11[var_12] = var_08[var_12];
	}

	return var_11;
}

//Function Number: 257
func_55E0()
{
	if(!level.var_258F)
	{
		var_00 = self method_834E();
		if(isdefined(var_00))
		{
			return var_00;
		}
		else
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 258
func_348B(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1500;
	}

	if(!isdefined(param_02))
	{
		param_02 = -12000;
	}

	return physicstrace(param_00 + (0,0,param_01),param_00 + (0,0,param_02));
}

//Function Number: 259
func_091E(param_00,param_01)
{
	if(!isdefined(level.var_2DFA))
	{
		level.var_2DFA = [];
	}

	level.var_2DFA[param_00] = param_01;
}

//Function Number: 260
func_091F(param_00,param_01)
{
	if(!isdefined(level.var_2E1E))
	{
		level.var_2E1E = [];
	}

	level.var_2E1E[param_00] = param_01;
}

//Function Number: 261
func_AA4A(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_02 - param_00);
	var_05 = anglestoforward(param_01);
	var_06 = vectordot(var_05,var_04);
	return var_06 >= param_03;
}

//Function Number: 262
func_7237(param_00,param_01,param_02)
{
	if(isdefined(self.var_2418))
	{
		var_03 = self.var_2418;
	}
	else
	{
		var_03 = 0;
	}

	var_04 = gettime();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_05 = 0.766;
	if(isdefined(param_02))
	{
		var_05 = cos(param_02);
	}

	if(!isdefined(param_00.var_7453))
	{
		param_00.var_7453 = [];
		param_00.var_7452 = [];
	}

	if(isdefined(param_00.var_7453[var_03]) && param_00.var_7453[var_03] + param_01 >= var_04)
	{
		return param_00.var_7452[var_03];
	}

	param_00.var_7453[var_03] = var_04;
	if(!func_AA4A(self.var_116,self geteyeangles(),param_00.var_116,var_05))
	{
		param_00.var_7452[var_03] = 0;
		return 0;
	}

	var_06 = self geteye();
	var_07 = param_00.var_116;
	if(sighttracepassed(var_06,var_07,1,self,param_00))
	{
		param_00.var_7452[var_03] = 1;
		return 1;
	}

	var_08 = param_00 geteye();
	if(sighttracepassed(var_06,var_08,1,self,param_00))
	{
		param_00.var_7452[var_03] = 1;
		return 1;
	}

	var_09 = var_08 + var_07 * 0.5;
	if(sighttracepassed(var_06,var_09,1,self,param_00))
	{
		param_00.var_7452[var_03] = 1;
		return 1;
	}

	param_00.var_7452[var_03] = 0;
	return 0;
}

//Function Number: 263
func_37CE(param_00)
{
	self notify("entity_path_disconnect_thread");
	self endon("entity_path_disconnect_thread");
	self endon("death");
	level endon("game_ended");
	var_01 = 0;
	self.var_3E18 = 0;
	for(;;)
	{
		var_02 = self.var_116;
		var_03 = func_A71A(param_00,"path_disconnect");
		var_04 = 0;
		var_05 = distancesquared(self.var_116,var_02) > 0;
		if(var_05)
		{
			var_04 = 1;
		}

		if(isdefined(var_03) && var_03 == "path_disconnect")
		{
			var_04 = 1;
		}

		if(gettime() < self.var_3E18)
		{
			var_04 = 1;
		}

		foreach(var_07 in function_02D1())
		{
			if(isai(var_07) && distancesquared(self.var_116,var_07.var_116) < 250000)
			{
				var_04 = 1;
				self.var_3E18 = max(gettime() + 30000,self.var_3E18);
			}
		}

		if(var_04 != var_01 || var_05)
		{
			if(var_04)
			{
				self method_805F();
			}
			else
			{
				self method_8060();
			}

			var_01 = var_04;
		}
	}
}

//Function Number: 264
func_5FA9(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bots_make_entity_sentient"]))
	{
		return self [[ level.var_19D5["bots_make_entity_sentient"] ]](param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 265
free_entity_sentient_mp()
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bots_free_entity_sentient"]))
	{
		return self [[ level.var_19D5["bots_free_entity_sentient"] ]]();
	}
}

//Function Number: 266
func_64F3()
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bot_bots_enabled_or_added"]))
	{
		return self [[ level.var_19D5["bot_bots_enabled_or_added"] ]]();
	}

	return 0;
}

//Function Number: 267
func_0A63(param_00)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["ai_3d_sighting_model"]))
	{
		return self [[ level.var_19D5["ai_3d_sighting_model"] ]](param_00);
	}
}

//Function Number: 268
func_841D(param_00,param_01,param_02)
{
	if(!isdefined(level.var_E2F))
	{
		level.var_E2F = [];
	}

	var_03 = tolower(getdvar("1673"));
	var_04 = 1;
	if(func_9467(var_03,"mp_"))
	{
		var_04 = 0;
	}

	if(var_04)
	{
		level.var_E2F[param_00]["basic"] = param_01;
		return;
	}

	level.var_E2F[param_00]["basic"] = param_02;
}

//Function Number: 269
func_4461(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		var_06 = distance(var_05.var_116,param_00);
		if(var_06 >= param_02)
		{
			continue;
		}

		param_02 = var_06;
		var_03 = var_05;
	}

	return var_03;
}

//Function Number: 270
func_4467(param_00,param_01)
{
	var_02 = 0;
	var_03 = distance(param_00,param_01[0]);
	for(var_04 = 1;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_00,param_01[var_04]);
		if(var_05 < var_03)
		{
			var_02 = var_04;
			var_03 = var_05;
		}
	}

	return param_01[var_02];
}

//Function Number: 271
func_44D6(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	var_03 = 0;
	var_04 = undefined;
	foreach(var_06 in param_01)
	{
		var_07 = distance(var_06.var_116,param_00);
		if(var_07 <= var_03 || var_07 >= param_02)
		{
			continue;
		}

		var_03 = var_07;
		var_04 = var_06;
	}

	return var_04;
}

//Function Number: 272
func_6240(param_00,param_01,param_02)
{
	param_02 = func_98E7(isdefined(param_02),param_02,(0,0,0));
	self method_81D9(param_00,param_02);
	switch(param_01)
	{
		case "direct":
			self method_81DC();
			break;

		case "top":
			self method_81DD();
			break;
	}
}

//Function Number: 273
func_38CA(param_00)
{
	return function_00D8(param_00 + 6.1E-05) / function_00D8(2) + 2.84;
}

//Function Number: 274
func_5D94(param_00)
{
	if(param_00 <= 0.0031308)
	{
		return param_00 * 12.92;
	}

	return pow(param_00,0.4166667) * 1.055 - 0.055;
}

//Function Number: 275
func_2617(param_00)
{
}

//Function Number: 276
func_2616(param_00)
{
	if(isdefined(level.var_38D0))
	{
		switch(level.var_38D0)
		{
			case "alfog":
				break;

			case "normal_fog":
				break;

			default:
				break;
		}
	}
}

//Function Number: 277
func_84A0(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	func_2617(param_00);
	func_2616(param_00);
	if(isdefined(param_00.var_1103))
	{
		if(level.var_10B)
		{
			if(param_00.var_1103)
			{
				if(isplayer(self))
				{
					self playersetatmosfog(param_00.var_1103,param_01,param_00.var_1128,param_00.var_1108,param_00.var_110A,param_00.var_1109,param_00.var_1105,param_00.var_1106,param_00.var_1110,param_00.var_1107,param_00.var_1126,param_00.var_1102,int(param_00.var_1112),param_00.var_1111,param_00.var_1114,param_00.var_1113,param_00.var_1127,param_00.var_110C,param_00.var_110B,param_00.var_110D,param_00.var_110E,param_00.var_110F,param_00.var_1104,param_00.var_10FF,param_00.var_1100,param_00.var_1101,param_00.var_111F,param_00.var_1120,param_00.var_1115,param_00.var_1116,param_00.var_1117,param_00.var_111C,param_00.var_111D,param_00.var_111E,param_00.var_1122,param_00.var_1125,param_00.var_1123,param_00.var_111B,param_00.var_1124,param_00.var_1118,param_00.var_1119,param_00.var_111A,param_00.var_1121);
					return;
				}

				setatmosfog(param_00.var_1103,param_01,param_00.var_1128,param_00.var_1108,param_00.var_110A,param_00.var_1109,param_00.var_1105,param_00.var_1106,param_00.var_1110,param_00.var_1107,param_00.var_1126,param_00.var_1102,int(param_00.var_1112),param_00.var_1111,param_00.var_1114,param_00.var_1113,param_00.var_1127,param_00.var_110C,param_00.var_110B,param_00.var_110D,param_00.var_110E,param_00.var_110F,param_00.var_1104,param_00.var_10FF,param_00.var_1100,param_00.var_1101,param_00.var_111F,param_00.var_1120,param_00.var_1115,param_00.var_1116,param_00.var_1117,param_00.var_111C,param_00.var_111D,param_00.var_111E,param_00.var_1122,param_00.var_1125,param_00.var_1123,param_00.var_111B,param_00.var_1124,param_00.var_1118,param_00.var_1119,param_00.var_111A,param_00.var_1121);
				return;
			}

			if(isplayer(self))
			{
				self playersetatmosfog(param_00.var_1103,param_01);
				return;
			}

			setatmosfog(param_00.var_1103,param_01);
			return;
		}
	}
}

//Function Number: 278
func_092C(param_00,param_01)
{
	if(!isdefined(level.var_611))
	{
		level.var_611 = [];
	}

	level.var_611[param_00] = loadfx(param_01);
}

//Function Number: 279
func_0FA4(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		for(var_03 = var_02 + 1;var_03 < param_00.size;var_03++)
		{
			if(param_00[var_03] [[ param_01 ]]() < param_00[var_02] [[ param_01 ]]())
			{
				var_04 = param_00[var_03];
				param_00[var_03] = param_00[var_02];
				param_00[var_02] = var_04;
			}
		}
	}

	return param_00;
}

//Function Number: 280
func_0FA5(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = -1;
	}

	for(var_03 = 1;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		for(var_05 = var_03 - 1;var_05 >= 0 && ![[ param_01 ]](param_00[var_05],var_04);var_05--)
		{
			param_00[var_05 + 1] = param_00[var_05];
		}

		param_00[var_05 + 1] = var_04;
		if(param_02 > 0 && var_03 % param_02 == 0)
		{
			wait 0.05;
		}
	}

	return param_00;
}

//Function Number: 281
func_4CEB()
{
	if(!isdefined(self.var_6A55))
	{
		self.var_6A55 = self method_80B1();
	}

	self method_805C();
}

//Function Number: 282
func_8BE0()
{
	if(!isai(self))
	{
		self solid();
	}

	if(isdefined(self.var_6A55))
	{
		self method_80B0(self.var_6A55);
	}

	self method_805B();
}

//Function Number: 283
func_A2BE()
{
	return (0,0,0);
}

//Function Number: 284
func_A2BA(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01) || !function_0296(param_01) || !function_0296(param_01))
	{
		return 0;
	}

	return param_00[0] == param_01[0] && param_00[1] == param_01[1] && param_00[2] == param_01[2];
}

//Function Number: 285
func_A2B9(param_00)
{
	var_01 = func_A2BE();
	if(!isdefined(param_00) || !isarray(param_00))
	{
		return var_01;
	}

	if(param_00.size == 0)
	{
		return var_01;
	}

	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03;
	}

	var_01 = var_01 / param_00.size;
	return var_01;
}

//Function Number: 286
func_6880(param_00)
{
	if(!param_00.size)
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03;
	}

	var_05 = var_01 / param_00.size;
	return var_05;
}

//Function Number: 287
func_86BE(param_00)
{
	var_01 = getentarray();
	setomnvar("lighting_state",param_00);
	if(!getdvarint("233"))
	{
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.var_5D56) && isdefined(var_03.var_3A) && var_03.var_3A == "script_brushmodel" || var_03.var_3A == "script_model")
			{
				if(var_03.var_5D56 == 0)
				{
					continue;
				}

				if(var_03.var_5D56 == param_00)
				{
					var_03 func_8BE0();
					continue;
				}

				var_03 func_4CEB();
			}
		}
	}
}

//Function Number: 288
func_46AE()
{
	if(func_562E(level.var_585D))
	{
		return "zombiePlayerStats";
	}

	return "rankedPlayerStats";
}

//Function Number: 289
func_46A8()
{
	return "zombiePlayerStats";
}

//Function Number: 290
func_46A7()
{
	return "commonData";
}

//Function Number: 291
func_46AF()
{
	return "rankedloadouts";
}

//Function Number: 292
func_46AC()
{
	return "privateloadouts";
}

//Function Number: 293
func_46AD()
{
	return "raidData";
}

//Function Number: 294
func_46AA()
{
	return "hubData";
}

//Function Number: 295
func_46A9()
{
	return "costumesData";
}

//Function Number: 296
func_46AB()
{
	return "leaderboardData";
}

//Function Number: 297
func_ACEE()
{
	return "competitiveloadouts";
}

//Function Number: 298
func_339E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_03))
	{
		param_03 = 180;
	}

	if(!isdefined(param_02))
	{
		param_02 = 100;
	}

	if(!isdefined(param_01) && isdefined(self.var_1D))
	{
		param_01 = self.var_1D;
	}

	if(!isdefined(param_00) && isdefined(self.var_116))
	{
		param_00 = self.var_116;
	}

	var_08 = 16;
	var_09 = 360 / var_08;
	var_0A = param_03;
	var_0B = var_0A - param_03 * 2;
	var_0C = var_0A;
	var_0D = [];
	var_0D[var_0D.size] = param_00;
	var_0D[var_0D.size] = param_00 + anglestoforward(combineangles(param_01,(0,var_0C,0))) * param_02;
	var_0D[var_0D.size] = param_00;
	while(var_0C > var_0B)
	{
		var_0C = max(var_0B,var_0C - var_09);
		var_0D[var_0D.size] = var_0D[var_0D.size - 1];
		var_0D[var_0D.size - 2] = param_00 + anglestoforward(combineangles(param_01,(0,var_0C,0))) * param_02;
	}

	thread func_33A6(var_0D,param_04,param_05,param_06,param_07);
}

//Function Number: 299
func_33A4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 16;
	var_07 = 360 / var_06;
	var_08 = [];
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		var_0A = var_07 * var_09;
		var_0B = cos(var_0A) * param_01;
		var_0C = sin(var_0A) * param_01;
		var_0D = param_00[0] + var_0B;
		var_0E = param_00[1] + var_0C;
		var_0F = param_00[2];
		var_08[var_08.size] = (var_0D,var_0E,var_0F);
	}

	thread func_33A6(var_08,param_02,param_03,param_04,param_05);
}

//Function Number: 300
func_33A6(param_00,param_01,param_02,param_03,param_04)
{
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_05 + 1 >= param_00.size)
		{
			var_07 = param_00[0];
		}
		else
		{
			var_07 = param_00[var_05 + 1];
		}

		thread func_33BA(var_06,var_07,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 301
func_33A5(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 16;
	var_06 = 360 / var_05;
	var_07 = [];
	for(var_08 = 0;var_08 < var_05;var_08++)
	{
		var_09 = anglestoforward(param_02);
		var_0A = vectorcross(var_09,(0,0,1));
		var_0B = vectorcross(var_0A,var_09);
		var_0C = var_06 * var_08;
		var_0D = cos(var_0C) * param_01;
		var_0E = sin(var_0C) * param_01;
		var_07[var_07.size] = param_00 + var_0A * var_0D + var_0B * var_0E;
	}

	thread func_33A6(var_07,param_03[0],param_03[1],param_03[2],param_04);
}

//Function Number: 302
func_33B0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = (1,1,1);
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = 1;
	var_07 = 0;
	param_01 = vectornormalize(param_01);
	if(param_01 == (0,0,1))
	{
		var_08 = (1,0,0);
	}

	var_08 = vectornormalize(vectorcross(param_01,(0,0,1)));
	var_09 = vectorcross(param_01,var_08);
	var_0A = param_01 * param_03 * cos(param_02);
	var_0B = param_03 * sin(param_02);
	var_0C = (0,0,0);
	var_0D = int(20 * param_05);
	var_0E = 16;
	for(var_0F = 0;var_0F <= var_0E;var_0F++)
	{
		var_10 = var_0F / var_0E * 360;
		var_11 = param_00 + var_0A + var_0B * var_08 * cos(var_10) + var_09 * sin(var_10);
		if(var_0F > 0)
		{
		}

		var_0C = var_11;
	}
}

//Function Number: 303
func_5D92(param_00,param_01,param_02,param_03,param_04)
{
	return param_03 + param_00 - param_01 * param_04 - param_03 / param_02 - param_01;
}

//Function Number: 304
func_5D93(param_00,param_01,param_02,param_03,param_04)
{
	return clamp(func_5D92(param_00,param_01,param_02,param_03,param_04),min(param_03,param_04),max(param_03,param_04));
}

//Function Number: 305
func_7716(param_00,param_01,param_02,param_03,param_04)
{
	level endon(param_00);
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = "*";
	}

	if(!isdefined(param_03))
	{
		param_03 = (1,1,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = 3;
	}

	for(;;)
	{
		if(function_0279(self))
		{
			return;
		}

		wait 0.05;
	}
}

//Function Number: 306
func_9468(param_00)
{
	var_01 = strtok(param_00,".");
	var_02 = int(var_01[0]);
	if(isdefined(var_01[1]))
	{
		var_03 = 1;
		for(var_04 = 0;var_04 < var_01[1].size;var_04++)
		{
			var_03 = var_03 * 0.1;
		}

		var_02 = var_02 + int(var_01[1]) * var_03;
	}

	return var_02;
}

//Function Number: 307
func_7F03(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "nearest";
	}

	var_03 = 1;
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_03 = var_03 * 10;
	}

	var_05 = param_00 * var_03;
	if(param_02 == "up")
	{
		var_06 = ceil(var_05);
	}
	else if(var_03 == "down")
	{
		var_06 = floor(var_06);
	}
	else
	{
		var_06 = var_06 + 0.5;
	}

	var_05 = int(var_06);
	var_05 = var_05 / var_03;
	return var_05;
}

//Function Number: 308
func_40B5()
{
	var_00 = spawnstruct();
	var_01 = getdvar("r_mode","1280x720 [16:9]");
	var_02 = strtok(var_01," ");
	var_03 = strtok(var_02[0],"x");
	var_00.var_1D2 = func_9468(var_03[0]);
	var_00.var_BD = func_9468(var_03[1]);
	var_00.var_1083 = func_7F03(var_00.var_1D2 / var_00.var_BD,3);
	return var_00;
}

//Function Number: 309
func_6FA9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getdvarint("turret_plant_debug") == 2;
	var_07 = [];
	var_08 = [];
	var_09 = 20;
	var_0A = undefined;
	if(param_03 > 0)
	{
		var_0A = int(param_03 / var_09) + 2;
	}
	else
	{
		var_09 = -1 * var_09;
		var_0A = int(param_03 / var_09) + 2;
	}

	var_0B = invertangles(param_01);
	var_0C = 0;
	for(var_0D = 0;var_0D < var_0A;var_0D++)
	{
		if(var_0D == var_0A - 1)
		{
			var_0C = param_03;
		}
		else
		{
			var_0C = var_0D * var_09;
		}

		if(var_0D == var_0A - 1)
		{
			var_0C = param_03;
		}
		else
		{
			var_0C = var_0D * var_09;
		}

		var_0E = combineangles(param_01,(0,var_0C,0));
		var_0F = anglestoforward(var_0E) * param_02;
		var_08[var_0D] = var_0F + param_00;
	}

	var_07["is_hit"] = 0;
	var_07["arc_end"] = var_08[var_0D];
	for(var_0D = 0;var_0D < var_08.size - 1;var_0D++)
	{
		var_10 = var_08[var_0D];
		var_11 = var_08[var_0D + 1];
		if(!isdefined(param_05))
		{
			var_12 = physicstrace(var_10,var_11,param_04);
		}
		else
		{
			var_13 = function_0335(var_10,var_11,param_05,undefined,param_04);
			if(var_13["is_matching_hit_found"])
			{
				var_12 = var_13["position"];
			}
			else
			{
				var_12 = var_11;
			}
		}

		var_14 = undefined;
		if(!func_5646(var_12,var_11))
		{
			var_15 = rotatevector(var_12 - param_00,var_0B);
			var_14 = asin(var_15[1] / param_02);
			if(var_07["is_hit"] == 0)
			{
				var_07["hit_angle"] = var_14;
				var_07["hit_point"] = var_12;
				var_07["is_hit"] = 1;
			}
			else if(!var_06)
			{
				break;
			}
		}
	}

	return var_07;
}

//Function Number: 310
func_5646(param_00,param_01)
{
	var_02 = 0.001;
	return abs(param_00[0] - param_01[0]) < var_02 && abs(param_00[1] - param_01[1]) < var_02 && abs(param_00[2] - param_01[2]) < var_02;
}

//Function Number: 311
func_A087(param_00)
{
	var_01 = "0123456789ABCDEF";
	if(param_00 == 0)
	{
		return var_01[0];
	}

	var_02 = "";
	while(param_00 > 0)
	{
		var_02 = var_01[int(param_00 % 16)] + var_02;
		param_00 = floor(param_00 / 16);
	}

	var_02 = "0x" + var_02;
	return var_02;
}

//Function Number: 312
func_7897(param_00,param_01)
{
	var_02 = func_789B(param_00,0,param_00.size - 1,param_01);
	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_03[var_04] = var_02[var_04];
	}

	return var_03;
}

//Function Number: 313
func_789B(param_00,param_01,param_02,param_03)
{
	var_04 = param_01;
	var_05 = param_02;
	if(!isdefined(param_03))
	{
		param_03 = ::func_7898;
	}

	if(param_02 - param_01 >= 1)
	{
		var_06 = param_00[param_01];
		while(var_05 > var_04)
		{
			while([[ param_03 ]](param_00[var_04],var_06) && var_04 <= param_02 && var_05 > var_04)
			{
				var_04++;
			}

			while(![[ param_03 ]](param_00[var_05],var_06) && var_05 > param_01 && var_05 >= var_04)
			{
				var_05--;
			}

			if(var_05 > var_04)
			{
				param_00 = func_9530(param_00,var_04,var_05);
			}
		}

		param_00 = func_9530(param_00,param_01,var_05);
		param_00 = func_789B(param_00,param_01,var_05 - 1,param_03);
		param_00 = func_789B(param_00,var_05 + 1,param_02,param_03);
	}
	else
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 314
func_7898(param_00,param_01)
{
	return param_00 <= param_01;
}

//Function Number: 315
func_7899(param_00,param_01)
{
	return param_00 > param_01;
}

//Function Number: 316
func_9530(param_00,param_01,param_02)
{
	var_03 = param_00[param_01];
	param_00[param_01] = param_00[param_02];
	param_00[param_02] = var_03;
	return param_00;
}

//Function Number: 317
func_73F5(param_00)
{
	foreach(var_02 in param_00.var_12C["killstreaks"])
	{
		if(var_02.var_13AF == 1)
		{
			return 1;
		}
	}

	return 0;
}