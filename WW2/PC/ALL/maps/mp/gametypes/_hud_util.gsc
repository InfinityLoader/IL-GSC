/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_util.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 916 ms
 * Timestamp: 10/27/2023 3:23:49 AM
*******************************************************************/

//Function Number: 1
func_86EF(param_00)
{
	if(isdefined(self.var_6E74) && self.var_6E74 == param_00)
	{
		return;
	}

	if(isdefined(self.var_6E74))
	{
		self.var_6E74 func_7CD5(self);
	}

	self.var_6E74 = param_00;
	self.var_6E74 func_09A6(self);
	if(isdefined(self.var_7538))
	{
		func_8707(self.var_7538,self.var_7C16,self.var_AACD,self.var_AAEB);
		return;
	}

	func_8707("TOPLEFT");
}

//Function Number: 2
func_45FC()
{
	return self.var_6E74;
}

//Function Number: 3
func_09A6(param_00)
{
	param_00.var_D4 = self.var_21F6.size;
	self.var_21F6[self.var_21F6.size] = param_00;
}

//Function Number: 4
func_7CD5(param_00)
{
	param_00.var_6E74 = undefined;
	if(self.var_21F6[self.var_21F6.size - 1] != param_00)
	{
		self.var_21F6[param_00.var_D4] = self.var_21F6[self.var_21F6.size - 1];
		self.var_21F6[param_00.var_D4].var_D4 = param_00.var_D4;
	}

	self.var_21F6[self.var_21F6.size - 1] = undefined;
	param_00.var_D4 = undefined;
}

//Function Number: 5
func_8707(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = func_45FC();
	if(param_04)
	{
		self moveovertime(param_04);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.var_AACD = param_02;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self.var_AAEB = param_03;
	self.var_7538 = param_00;
	self.accuracy = "center";
	self.var_11 = "middle";
	if(issubstr(param_00,"TOP"))
	{
		self.var_11 = "top";
	}

	if(issubstr(param_00,"BOTTOM"))
	{
		self.var_11 = "bottom";
	}

	if(issubstr(param_00,"LEFT"))
	{
		self.accuracy = "left";
	}

	if(issubstr(param_00,"RIGHT"))
	{
		self.accuracy = "right";
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.var_7C16 = param_01;
	var_06 = "center_adjustable";
	var_07 = "middle";
	if(issubstr(param_01,"TOP"))
	{
		var_07 = "top_adjustable";
	}

	if(issubstr(param_01,"BOTTOM"))
	{
		var_07 = "bottom_adjustable";
	}

	if(issubstr(param_01,"LEFT"))
	{
		var_06 = "left_adjustable";
	}

	if(issubstr(param_01,"RIGHT"))
	{
		var_06 = "right_adjustable";
	}

	if(var_05 == level.var_A012)
	{
		self.var_C6 = var_06;
		self.var_1CA = var_07;
	}
	else
	{
		self.var_C6 = var_05.var_C6;
		self.var_1CA = var_05.var_1CA;
	}

	if(function_02FF(var_06,"_adjustable") == var_05.accuracy)
	{
		var_08 = 0;
		var_09 = 0;
	}
	else if(var_08 == "center" || var_07.accuracy == "center")
	{
		var_08 = int(var_07.var_1D2 / 2);
		if(var_07 == "left_adjustable" || var_06.accuracy == "right")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}
	else
	{
		var_08 = var_07.var_1D2;
		if(var_07 == "left_adjustable")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}

	self.maxsightdistsqrd = var_05.maxsightdistsqrd + var_08 * var_09;
	if(function_02FF(var_07,"_adjustable") == var_05.var_11)
	{
		var_0A = 0;
		var_0B = 0;
	}
	else if(var_09 == "middle" || var_07.var_11 == "middle")
	{
		var_0A = int(var_07.var_BD / 2);
		if(var_08 == "top_adjustable" || var_06.var_11 == "bottom")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}
	else
	{
		var_0A = var_07.var_BD;
		if(var_08 == "top_adjustable")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}

	self.var_1D7 = var_05.var_1D7 + var_0A * var_0B;
	self.maxsightdistsqrd = self.maxsightdistsqrd + self.var_AACD;
	self.var_1D7 = self.var_1D7 + self.var_AAEB;
	switch(self.var_35B2)
	{
		case "bar":
			func_8708(param_00,param_01,param_02,param_03);
			break;
	}

	func_A0F5();
}

//Function Number: 6
func_8708(param_00,param_01,param_02,param_03)
{
	self.var_1586.var_C6 = self.var_C6;
	self.var_1586.var_1CA = self.var_1CA;
	self.var_1586.accuracy = "left";
	self.var_1586.var_11 = self.var_11;
	self.var_1586.var_1D7 = self.var_1D7;
	if(self.accuracy == "left")
	{
		self.var_1586.maxsightdistsqrd = self.maxsightdistsqrd;
	}
	else if(self.accuracy == "right")
	{
		self.var_1586.maxsightdistsqrd = self.maxsightdistsqrd - self.var_1D2;
	}
	else
	{
		self.var_1586.maxsightdistsqrd = self.maxsightdistsqrd - int(self.var_1D2 / 2);
	}

	if(self.var_11 == "top")
	{
		self.var_1586.var_1D7 = self.var_1D7;
	}
	else if(self.var_11 == "bottom")
	{
		self.var_1586.var_1D7 = self.var_1D7;
	}

	func_A0E3(self.var_1586.var_3E6E);
}

//Function Number: 7
func_A0E3(param_00,param_01)
{
	if(self.var_35B2 == "bar")
	{
		func_A0E5(param_00,param_01);
	}
}

//Function Number: 8
func_A0E5(param_00,param_01)
{
	var_02 = int(self.var_1D2 * param_00 + 0.5);
	if(!var_02)
	{
		var_02 = 1;
	}

	self.var_1586.var_3E6E = param_00;
	self.var_1586 setshader(self.var_1586.var_8AC7,var_02,self.var_BD);
	if(isdefined(param_01) && var_02 < self.var_1D2)
	{
		if(param_01 > 0)
		{
			self.var_1586 scaleovertime(1 - param_00 / param_01,self.var_1D2,self.var_BD);
		}
		else if(param_01 < 0)
		{
			self.var_1586 scaleovertime(param_00 / -1 * param_01,1,self.var_BD);
		}
	}

	self.var_1586.var_7A78 = param_01;
	self.var_1586.var_5C09 = gettime();
}

//Function Number: 9
func_27ED(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.var_35B2 = "font";
	var_02.var_9A = param_00;
	var_02.var_17A = 1;
	var_02.var_9B = param_01;
	var_02.var_15FC = param_01;
	var_02.maxsightdistsqrd = 0;
	var_02.var_1D7 = 0;
	var_02.var_1D2 = 0;
	var_02.var_BD = int(level.var_3DD8 * param_01);
	var_02.var_AACD = 0;
	var_02.var_AAEB = 0;
	var_02.var_21F6 = [];
	var_02 func_86EF(level.var_A012);
	var_02.var_4CC7 = 0;
	return var_02;
}

//Function Number: 10
func_2829(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = newteamhudelem(param_02);
	}
	else
	{
		var_03 = newhudelem();
	}

	var_03.var_35B2 = "font";
	var_03.var_9A = param_00;
	var_03.var_17A = 1;
	var_03.var_9B = param_01;
	var_03.var_15FC = param_01;
	var_03.maxsightdistsqrd = 0;
	var_03.var_1D7 = 0;
	var_03.var_1D2 = 0;
	var_03.var_BD = int(level.var_3DD8 * param_01);
	var_03.var_AACD = 0;
	var_03.var_AAEB = 0;
	var_03.var_21F6 = [];
	var_03 func_86EF(level.var_A012);
	var_03.var_4CC7 = 0;
	return var_03;
}

//Function Number: 11
func_282B(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = newteamhudelem(param_02);
	}
	else
	{
		var_03 = newhudelem();
	}

	var_03.var_35B2 = "timer";
	var_03.var_9A = param_00;
	var_03.var_17A = 1;
	var_03.var_9B = param_01;
	var_03.var_15FC = param_01;
	var_03.maxsightdistsqrd = 0;
	var_03.var_1D7 = 0;
	var_03.var_1D2 = 0;
	var_03.var_BD = int(level.var_3DD8 * param_01);
	var_03.var_AACD = 0;
	var_03.var_AAEB = 0;
	var_03.var_21F6 = [];
	var_03 func_86EF(level.var_A012);
	var_03.var_4CC7 = 0;
	return var_03;
}

//Function Number: 12
func_2833(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.var_35B2 = "timer";
	var_02.var_9A = param_00;
	var_02.var_17A = 1;
	var_02.var_9B = param_01;
	var_02.var_15FC = param_01;
	var_02.maxsightdistsqrd = 0;
	var_02.var_1D7 = 0;
	var_02.var_1D2 = 0;
	var_02.var_BD = int(level.var_3DD8 * param_01);
	var_02.var_AACD = 0;
	var_02.var_AAEB = 0;
	var_02.var_21F6 = [];
	var_02 func_86EF(level.var_A012);
	var_02.var_4CC7 = 0;
	return var_02;
}

//Function Number: 13
func_280B(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(self);
	var_03.var_35B2 = "icon";
	var_03.maxsightdistsqrd = 0;
	var_03.var_1D7 = 0;
	var_03.var_1D2 = param_01;
	var_03.var_BD = param_02;
	var_03.var_1630 = var_03.var_1D2;
	var_03.var_15FD = var_03.var_BD;
	var_03.var_AACD = 0;
	var_03.var_AAEB = 0;
	var_03.var_21F6 = [];
	var_03 func_86EF(level.var_A012);
	var_03.var_4CC7 = 0;
	if(isdefined(param_00))
	{
		var_03 setshader(param_00,param_01,param_02);
		var_03.var_8AC7 = param_00;
	}

	return var_03;
}

//Function Number: 14
func_282A(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		var_04 = newteamhudelem(param_03);
	}
	else
	{
		var_04 = newhudelem();
	}

	var_04.var_35B2 = "icon";
	var_04.maxsightdistsqrd = 0;
	var_04.var_1D7 = 0;
	var_04.var_1D2 = param_01;
	var_04.var_BD = param_02;
	var_04.var_1630 = var_04.var_1D2;
	var_04.var_15FD = var_04.var_BD;
	var_04.var_AACD = 0;
	var_04.var_AAEB = 0;
	var_04.var_21F6 = [];
	var_04 func_86EF(level.var_A012);
	var_04.var_4CC7 = 0;
	if(isdefined(param_00))
	{
		var_04 setshader(param_00,param_01,param_02);
		var_04.var_8AC7 = param_00;
	}

	return var_04;
}

//Function Number: 15
func_2828(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_04))
	{
		var_06 = newteamhudelem(param_04);
	}
	else
	{
		var_06 = newhudelem();
	}

	var_06.maxsightdistsqrd = 0;
	var_06.var_1D7 = 0;
	var_06.var_3E6E = 0;
	var_06.var_56 = param_00;
	var_06.ignoreme = -2;
	var_06.var_8AC7 = "progress_bar_fill";
	var_06 setshader("progress_bar_fill",param_01,param_02);
	var_06.var_4CC7 = 0;
	if(isdefined(param_03))
	{
		var_06.var_3D49 = param_03;
	}

	if(isdefined(param_04))
	{
		var_07 = newteamhudelem(param_04);
	}
	else
	{
		var_07 = newhudelem();
	}

	var_07.var_35B2 = "bar";
	var_07.maxsightdistsqrd = 0;
	var_07.var_1D7 = 0;
	var_07.var_1D2 = param_01;
	var_07.var_BD = param_02;
	var_07.var_AACD = 0;
	var_07.var_AAEB = 0;
	var_07.var_1586 = var_06;
	var_07.var_21F6 = [];
	var_07.ignoreme = -3;
	var_07.var_56 = (0,0,0);
	var_07.var_18 = 0.5;
	var_07 func_86EF(level.var_A012);
	var_07 setshader("progress_bar_bg",param_01,param_02);
	var_07.var_4CC7 = 0;
	return var_07;
}

//Function Number: 16
func_27CF(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(self);
	var_04.maxsightdistsqrd = 0;
	var_04.var_1D7 = 0;
	var_04.var_3E6E = 0;
	var_04.var_56 = param_00;
	var_04.ignoreme = -2;
	var_04.var_8AC7 = "progress_bar_fill";
	var_04 setshader("progress_bar_fill",param_01,param_02);
	var_04.var_4CC7 = 0;
	if(isdefined(param_03))
	{
		var_04.var_3D49 = param_03;
	}

	var_05 = newclienthudelem(self);
	var_05.var_35B2 = "bar";
	var_05.var_1D2 = param_01;
	var_05.var_BD = param_02;
	var_05.var_AACD = 0;
	var_05.var_AAEB = 0;
	var_05.var_1586 = var_04;
	var_05.var_21F6 = [];
	var_05.ignoreme = -3;
	var_05.var_56 = (0,0,0);
	var_05.var_18 = 0.5;
	var_05 func_86EF(level.var_A012);
	var_05 setshader("progress_bar_bg",param_01 + 4,param_02 + 4);
	var_05.var_4CC7 = 0;
	return var_05;
}

//Function Number: 17
func_447D()
{
	var_00 = self.var_1586.var_3E6E;
	if(isdefined(self.var_1586.var_7A78))
	{
		var_00 = var_00 + gettime() - self.var_1586.var_5C09 * self.var_1586.var_7A78 / 1000;
		if(var_00 > 1)
		{
			var_00 = 1;
		}

		if(var_00 < 0)
		{
			var_00 = 0;
		}
	}

	return var_00;
}

//Function Number: 18
func_2821(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(self issplitscreenplayer() && !function_03BA())
	{
		param_01 = param_01 + 20;
	}

	if(function_0367())
	{
		var_03 = func_27CF((0.25,0.58,0.53),level.var_76FD,level.var_76FA);
	}
	else
	{
		var_03 = func_27CF((1,1,1),level.var_76FD,level.var_76FA);
	}

	var_03 func_8707("CENTER",undefined,level.var_76FE + param_00,level.var_76FF + param_01);
	return var_03;
}

//Function Number: 19
func_2822(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(self issplitscreenplayer() && !function_03BA())
	{
		param_01 = param_01 + 20;
	}

	if(function_0367())
	{
		var_02 = func_27ED("mphubfont",1.4);
	}
	else
	{
		var_02 = func_27ED("hudbig",level.var_76F9);
	}

	var_02 func_8707("CENTER",undefined,level.var_76FB + param_00,level.var_76FC + param_01);
	var_02.ignoreme = -1;
	return var_02;
}

//Function Number: 20
func_2830(param_00)
{
	var_01 = func_2828((1,0,0),level.var_9867,level.var_9865,undefined,param_00);
	var_01 func_8707("TOP",undefined,0,level.var_9868);
	return var_01;
}

//Function Number: 21
func_2831(param_00)
{
	var_01 = func_2829("default",level.var_9864,param_00);
	var_01 func_8707("TOP",undefined,0,level.var_9866);
	return var_01;
}

//Function Number: 22
func_8685(param_00)
{
	self.var_1586.var_3D49 = param_00;
}

//Function Number: 23
func_4D06()
{
	if(self.var_4CC7)
	{
		return;
	}

	self.var_4CC7 = 1;
	if(self.var_18 != 0)
	{
		self.var_18 = 0;
	}

	if(self.var_35B2 == "bar" || self.var_35B2 == "bar_shader")
	{
		self.var_1586.var_4CC7 = 1;
		if(self.var_1586.var_18 != 0)
		{
			self.var_1586.var_18 = 0;
		}
	}
}

//Function Number: 24
func_8BF6()
{
	if(!self.var_4CC7)
	{
		return;
	}

	self.var_4CC7 = 0;
	if(self.var_35B2 == "bar" || self.var_35B2 == "bar_shader")
	{
		if(self.var_18 != 0.5)
		{
			self.var_18 = 0.5;
		}

		self.var_1586.var_4CC7 = 0;
		if(self.var_1586.var_18 != 1)
		{
			self.var_1586.var_18 = 1;
			return;
		}

		return;
	}

	if(self.var_18 != 1)
	{
		self.var_18 = 1;
	}
}

//Function Number: 25
func_3D59()
{
	self endon("death");
	if(!self.var_4CC7)
	{
		self.var_18 = 1;
	}

	for(;;)
	{
		if(self.var_3E6E >= self.var_3D49)
		{
			if(!self.var_4CC7)
			{
				self fadeovertime(0.3);
				self.var_18 = 0.2;
				wait(0.35);
				self fadeovertime(0.3);
				self.var_18 = 1;
			}

			wait(0.7);
			continue;
		}

		if(!self.var_4CC7 && self.var_18 != 1)
		{
			self.var_18 = 1;
		}

		wait 0.05;
	}
}

//Function Number: 26
func_2DCC()
{
	var_00 = [];
	for(var_01 = 0;var_01 < self.var_21F6.size;var_01++)
	{
		if(isdefined(self.var_21F6[var_01]))
		{
			var_00[var_00.size] = self.var_21F6[var_01];
		}
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] func_86EF(func_45FC());
	}

	if(self.var_35B2 == "bar" || self.var_35B2 == "bar_shader")
	{
		self.var_1586 destroy();
	}

	self destroy();
}

//Function Number: 27
func_86AA(param_00)
{
	self setshader(param_00,self.var_1D2,self.var_BD);
	self.var_8AC7 = param_00;
}

//Function Number: 28
func_4519(param_00)
{
	return self.var_8AC7;
}

//Function Number: 29
func_86AB(param_00,param_01)
{
	self setshader(self.var_8AC7,param_00,param_01);
}

//Function Number: 30
func_8A69(param_00)
{
	self.var_1D2 = param_00;
}

//Function Number: 31
func_86A1(param_00)
{
	self.var_BD = param_00;
}

//Function Number: 32
func_8723(param_00,param_01)
{
	self.var_1D2 = param_00;
	self.var_BD = param_01;
}

//Function Number: 33
func_A0F5()
{
	for(var_00 = 0;var_00 < self.var_21F6.size;var_00++)
	{
		var_01 = self.var_21F6[var_00];
		var_01 func_8707(var_01.var_7538,var_01.var_7C16,var_01.var_AACD,var_01.var_AAEB);
	}
}

//Function Number: 34
func_9C7F()
{
	self.maxsightdistsqrd = self.var_AACD;
	self.var_1D7 = self.var_AAEB;
	if(self.var_35B2 == "font")
	{
		self.var_9B = self.var_15FC;
		self.var_E5 = &"";
	}
	else if(self.var_35B2 == "icon")
	{
		self setshader(self.var_8AC7,self.var_1D2,self.var_BD);
	}

	self.var_18 = 0;
}

//Function Number: 35
func_9C84(param_00)
{
	switch(self.var_35B2)
	{
		case "timer":
		case "font":
			self.var_9B = 6.3;
			self changefontscaleovertime(param_00);
			self.var_9B = self.var_15FC;
			break;

		case "icon":
			self setshader(self.var_8AC7,self.var_1D2 * 6,self.var_BD * 6);
			self scaleovertime(param_00,self.var_1D2,self.var_BD);
			break;
	}
}

//Function Number: 36
func_9C7E(param_00,param_01)
{
	var_02 = int(param_00) * 1000;
	var_03 = int(param_01) * 1000;
	switch(self.var_35B2)
	{
		case "timer":
		case "font":
			self setpulsefx(var_02 + 250,var_03 + var_02,var_02 + 250);
			break;

		default:
			break;
	}
}

//Function Number: 37
func_9C81(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "left";
	}

	switch(param_01)
	{
		case "left":
			self.maxsightdistsqrd = self.maxsightdistsqrd + 1000;
			break;

		case "right":
			self.maxsightdistsqrd = self.maxsightdistsqrd - 1000;
			break;

		case "up":
			self.var_1D7 = self.var_1D7 - 1000;
			break;

		case "down":
			self.var_1D7 = self.var_1D7 + 1000;
			break;
	}

	self moveovertime(param_00);
	self.maxsightdistsqrd = self.var_AACD;
	self.var_1D7 = self.var_AAEB;
}

//Function Number: 38
func_9C82(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "left";
	}

	var_02 = self.var_AACD;
	var_03 = self.var_AAEB;
	switch(param_01)
	{
		case "left":
			var_02 = var_02 + 1000;
			break;

		case "right":
			var_02 = var_02 - 1000;
			break;

		case "up":
			var_03 = var_03 - 1000;
			break;

		case "down":
			var_03 = var_03 + 1000;
			break;
	}

	self.var_18 = 1;
	self moveovertime(param_00);
	self.maxsightdistsqrd = var_02;
	self.var_1D7 = var_03;
}

//Function Number: 39
func_9C85(param_00)
{
	switch(self.var_35B2)
	{
		case "timer":
		case "font":
			self changefontscaleovertime(param_00);
			self.var_9B = 6.3;
			break;

		case "icon":
			self scaleovertime(param_00,self.var_1D2 * 6,self.var_BD * 6);
			break;
	}
}

//Function Number: 40
func_9C78(param_00)
{
	self fadeovertime(param_00);
	if(isdefined(self.var_6073))
	{
		self.var_18 = self.var_6073;
		return;
	}

	self.var_18 = 1;
}

//Function Number: 41
func_9C79(param_00)
{
	self fadeovertime(0.15);
	self.var_18 = 0;
}

//Function Number: 42
func_5807(param_00)
{
	if(issubstr(param_00,"ch_limited"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
func_5850(param_00)
{
	if(common_scripts\utility::func_9467(param_00,"ch_attach_unlock_kills"))
	{
		return 1;
	}

	if(common_scripts\utility::func_9467(param_00,"ch_attach_unlock_hipfirekills"))
	{
		return 1;
	}

	if(common_scripts\utility::func_9467(param_00,"ch_attach_unlock_headShots"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_2097(param_00)
{
	if(func_5850(param_00))
	{
		return func_775C(param_00);
	}

	return self getrankedplayerdata(common_scripts\utility::func_46AE(),"challengeProgress",param_00);
}

//Function Number: 45
func_2098(param_00)
{
	if(func_5850(param_00))
	{
		return func_775D(param_00);
	}

	return self getrankedplayerdata(common_scripts\utility::func_46AE(),"challengeState",param_00);
}

//Function Number: 46
func_209E(param_00,param_01)
{
	if(func_5850(param_00))
	{
		return;
	}

	var_02 = maps\mp\_utility::func_2315(param_01);
	self setrankedplayerdata(common_scripts\utility::func_46AE(),"challengeProgress",param_00,var_02);
	if(issubstr(param_00,"ch_daily_") && var_02 > 0)
	{
		thread maps\mp\gametypes\_hud_message::func_9102(param_00,var_02);
	}
}

//Function Number: 47
func_209F(param_00,param_01)
{
	if(func_5850(param_00))
	{
		return;
	}

	self setrankedplayerdata(common_scripts\utility::func_46AE(),"challengeState",param_00,param_01);
}

//Function Number: 48
func_2099(param_00,param_01)
{
	if(issubstr(param_00,"ch_daily"))
	{
		var_02 = tablelookup("mp/dailyChallengesTable.csv",0,param_00,9);
	}
	else
	{
		var_02 = tablelookup("mp/allChallengesTable.csv",0,param_01,9 + var_02 - 1 * 2);
	}

	if(isdefined(var_02) && var_02 != "")
	{
		return int(var_02);
	}

	return 0;
}

//Function Number: 49
func_3005(param_00,param_01,param_02,param_03)
{
	var_04 = func_27ED("hudbig",param_02);
	var_04 func_8707("CENTER","CENTER",0,param_01);
	var_04.ignoreme = 1001;
	var_04.var_56 = (1,1,1);
	var_04.var_A0 = 0;
	var_04.var_C2 = 1;
	var_04 settext(param_00);
	common_scripts\utility::knock_off_battery(param_03,"joined_team","death");
	if(isdefined(var_04))
	{
		var_04 func_2DCC();
	}
}

//Function Number: 50
func_775C(param_00)
{
	if(common_scripts\utility::func_9467(param_00,"ch_attach_unlock_hipfirekills"))
	{
		return func_9AB0(param_00,"hipfirekills");
	}
	else if(common_scripts\utility::func_9467(param_00,"ch_attach_unlock_kills"))
	{
		return func_9AB0(param_00,"kills");
	}
	else if(common_scripts\utility::func_9467(param_00,"ch_attach_unlock_headShots"))
	{
		return func_9AB0(param_00,"headShots");
	}
}

//Function Number: 51
func_775D(param_00)
{
	var_01 = func_775C(param_00);
	var_02 = 1;
	for(var_03 = func_2099(param_00,var_02);var_03 > 0 && var_01 >= var_03;var_03 = func_2099(param_00,var_02))
	{
		var_02++;
	}

	return var_02;
}

//Function Number: 52
func_9AB0(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	var_04 = strtok(param_00,"_");
	for(var_05 = 0;var_05 < var_04.size - 1;var_05++)
	{
		if(var_04[var_05] == param_01)
		{
			var_02 = var_04[var_05 + 1];
			break;
		}
	}

	if(isdefined(var_02))
	{
		var_06 = tablelookuprownum("mp/statstable.csv",28,var_02);
		while(var_06 >= 0)
		{
			var_07 = tablelookupbyrow("mp/statstable.csv",var_06,2);
			var_03 = var_03 + self getrankedplayerdata(common_scripts\utility::func_46AE(),"weaponStats",var_07,param_01);
			var_06 = tablelookuprownum("mp/statstable.csv",28,var_02,var_06 - 1);
		}

		if(param_01 == "kills" && isdefined(self.var_9BBA))
		{
			var_03 = var_03 + self.var_9BBA;
		}

		if(param_01 == "hipfirekills" && isdefined(self.var_9BB8))
		{
			var_03 = var_03 + self.var_9BB8;
		}

		if(param_01 == "headShots" && isdefined(self.var_9BB7))
		{
			var_03 = var_03 + self.var_9BB7;
		}

		var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(),"attachUnlock_" + param_01,var_02);
		if(var_08 > var_03)
		{
			var_08 = 0;
		}

		return var_03 - var_08;
	}
}

//Function Number: 53
func_5527()
{
	return function_0367() && function_02C6(getdvar("1673"),"mp_hub_zombies");
}

//Function Number: 54
shoulddohubtutorialflow()
{
	return !func_5527() && !maps\mp\_utility::func_585F() && getdvarint("mm_hub_tutorial_enabled",0) == 1;
}