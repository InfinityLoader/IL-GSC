/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_movers.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 1016 ms
 * Timestamp: 10/27/2023 3:21:37 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(getdvar("233") == "1")
	{
		return;
	}

	level.var_8216 = [];
	level.var_8216["move_time"] = 5;
	level.var_8216["accel_time"] = 0;
	level.var_8216["decel_time"] = 0;
	level.var_8216["wait_time"] = 0;
	level.var_8216["delay_time"] = 0;
	level.var_8216["usable"] = 0;
	level.var_8216["hintstring"] = "activate";
	func_820C("activate",&"MP_ACTIVATE_MOVER");
	func_820D("none","");
	level.var_8226 = [];
	level.var_8211 = [];
	wait 0.05;
	var_00 = [];
	var_01 = func_8213();
	foreach(var_03 in var_01)
	{
		var_00 = common_scripts\utility::func_F73(var_00,getentarray(var_03,"classname"));
	}

	common_scripts\utility::func_FB2(var_00,::func_821E);
}

//Function Number: 2
func_8213()
{
	return ["script_model_mover","script_brushmodel_mover"];
}

//Function Number: 3
func_8222()
{
	if(isdefined(self.var_820A))
	{
		return self.var_820A;
	}

	var_00 = func_8213();
	foreach(var_02 in var_00)
	{
		if(self.var_3A == var_02)
		{
			self.var_820A = 1;
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
func_820C(param_00,param_01)
{
	if(!isdefined(level.var_821D))
	{
		level.var_821D = [];
	}

	level.var_821D[param_00] = param_01;
}

//Function Number: 5
func_820D(param_00,param_01)
{
	if(!isdefined(level.var_8229))
	{
		level.var_8229 = [];
	}

	level.var_8229[param_00] = param_01;
}

//Function Number: 6
func_820B(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_8211))
	{
		level.var_8211 = [];
	}

	if(!isdefined(param_03))
	{
		param_03 = "default";
	}

	if(!isdefined(level.var_8211[param_00]))
	{
		level.var_8211[param_00] = [];
	}

	var_04 = spawnstruct();
	var_04.var_EC4 = param_01;
	var_04.var_ED1 = param_02;
	level.var_8211[param_00][param_03] = var_04;
}

//Function Number: 7
func_821E()
{
	self.var_820A = 1;
	self.var_64E3 = 0;
	self.var_6C3E = self;
	self.var_A1F9 = [];
	self.var_5DAB = [];
	var_00 = [];
	if(isdefined(self.var_1A2))
	{
		var_00 = common_scripts\utility::func_46B7(self.var_1A2,"targetname");
	}

	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.var_165))
		{
			continue;
		}

		switch(var_02.var_165)
		{
			case "origin":
				if(!isdefined(var_02.var_1D))
				{
					var_02.var_1D = (0,0,0);
				}
	
				self.var_6C3E = spawn("script_model",var_02.var_116);
				self.var_6C3E.var_1D = var_02.var_1D;
				self.var_6C3E setmodel("tag_origin");
				self.var_6C3E linkto(self);
				break;

			case "scene_node":
			case "scripted_node":
				if(!isdefined(var_02.var_1D))
				{
					var_02.var_1D = (0,0,0);
				}
	
				self.var_830E = var_02;
				break;

			default:
				break;
		}
	}

	var_04 = [];
	if(isdefined(self.var_1A2))
	{
		var_04 = getentarray(self.var_1A2,"targetname");
	}

	foreach(var_02 in var_04)
	{
		if(!isdefined(var_02.var_165))
		{
			continue;
		}

		var_06 = strtok(var_02.var_165,";");
		foreach(var_08 in var_06)
		{
			switch(var_08)
			{
				case "use_trigger_link":
					var_02 enablelinkto();
					var_02 linkto(self);
					break;

				case "use_trigger":
					var_02 func_822D();
					thread func_823C(var_02);
					self.var_A1F9[self.var_A1F9.size] = var_02;
					break;

				case "link":
					var_02 linkto(self);
					self.var_5DAB[self.var_5DAB.size] = var_02;
					break;

				default:
					break;
			}
		}
	}

	thread func_822D();
	thread func_821F();
	thread func_8231();
	thread func_8232();
	thread func_8212(self);
	thread func_8230();
	func_8237();
	foreach(var_0C in self.var_A1F9)
	{
		func_8234(var_0C,1);
	}

	self.var_821E = 1;
	self notify("script_mover_init");
}

//Function Number: 8
func_8237()
{
	if(func_8220())
	{
		thread func_8210();
		return;
	}

	thread func_8225();
}

//Function Number: 9
func_8230()
{
	self.var_64C0 = self.var_116;
	self.var_64BF = self.var_1D;
}

//Function Number: 10
func_822F(param_00)
{
	self notify("mover_reset");
	if(func_8220())
	{
		self scriptmodelclearanim();
	}

	self.var_116 = self.var_64C0;
	self.var_1D = self.var_64BF;
	self notify("new_path");
	wait 0.05;
	func_8237();
}

//Function Number: 11
func_823C(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00 waittill("trigger");
		if(param_00.var_480C.size > 0)
		{
			self notify("new_path");
			thread func_8225(param_00);
			continue;
		}

		self notify("trigger");
	}
}

//Function Number: 12
func_8224(param_00)
{
	if(isdefined(level.var_8226[param_00]))
	{
		self notify("new_path");
		self.var_480C = level.var_8226[param_00];
		thread func_8225();
	}
}

//Function Number: 13
func_0DDE(param_00)
{
	return (angleclamp180(param_00[0]),angleclamp180(param_00[1]),angleclamp180(param_00[2]));
}

//Function Number: 14
func_822D()
{
	if(isdefined(self.var_6E88) && self.var_6E88)
	{
		return;
	}

	self.var_6E88 = 1;
	self.var_480C = [];
	self.var_64C5 = [];
	var_00 = [];
	var_01 = [];
	if(isdefined(self.var_1A2))
	{
		var_00 = common_scripts\utility::func_46B7(self.var_1A2,"targetname");
		var_01 = getentarray(self.var_1A2,"targetname");
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		if(!isdefined(var_03.var_165))
		{
			var_03.var_165 = "goal";
		}

		switch(var_03.var_165)
		{
			case "ignore":
				if(isdefined(var_03.var_1A2))
				{
					var_04 = common_scripts\utility::func_46B7(var_03.var_1A2,"targetname");
					foreach(var_06 in var_04)
					{
						var_00[var_00.size] = var_06;
					}
				}
				break;

			case "goal":
				var_03 func_821F();
				var_03 func_822D();
				self.var_480C[self.var_480C.size] = var_03;
				if(isdefined(var_03.var_6E5C["name"]))
				{
					if(!isdefined(level.var_8226[var_03.var_6E5C["name"]]))
					{
						level.var_8226[var_03.var_6E5C["name"]] = [];
					}
	
					var_08 = level.var_8226[var_03.var_6E5C["name"]].size;
					level.var_8226[var_03.var_6E5C["name"]][var_08] = var_03;
				}
				break;

			default:
				break;
		}
	}

	foreach(var_0A in var_01)
	{
		if(var_0A func_8222())
		{
			self.var_64C5[self.var_64C5.size] = var_0A;
		}

		thread func_822A(var_0A);
	}
}

//Function Number: 15
func_822A(param_00)
{
	if(!isdefined(param_00.var_165))
	{
		return;
	}

	if(param_00 func_8222() && !isdefined(param_00.var_821E))
	{
		param_00 waittill("script_mover_init");
	}

	var_01 = strtok(param_00.var_165,";");
	foreach(var_03 in var_01)
	{
		var_04 = strtok(var_03,"_");
		if(var_04.size < 3 || var_04[1] != "on")
		{
			continue;
		}

		var_05 = tolower(var_04[0]);
		var_06 = var_04[2];
		for(var_07 = 3;var_07 < var_04.size;var_07++)
		{
			var_06 = var_06 + "_" + var_04[var_07];
		}

		switch(var_05)
		{
			case "connectpaths":
				thread func_821A(param_00,var_06,::func_8215,::func_8219);
				break;

			case "disconnectpaths":
				thread func_821A(param_00,var_06,::func_8219,::func_8215);
				break;

			case "solid":
				param_00 notsolid();
				thread func_821A(param_00,var_06,::func_8236,::func_8228);
				break;

			case "notsolid":
				thread func_821A(param_00,var_06,::func_8228,::func_8236);
				break;

			case "delete":
				thread func_821A(param_00,var_06,::func_8218);
				break;

			case "hide":
				thread func_821A(param_00,var_06,::func_821C,::func_8235);
				break;

			case "show":
				param_00 method_805C();
				thread func_821A(param_00,var_06,::func_8235,::func_821C);
				break;

			case "triggerhide":
				thread func_821A(param_00,var_06,::func_8239,::func_823A);
				break;

			case "triggershow":
				param_00 common_scripts\utility::func_9D9F();
				thread func_821A(param_00,var_06,::func_823A,::func_8239);
				break;

			case "trigger":
				thread func_821A(param_00,var_06,::func_8238,::func_822F);
				break;

			default:
				break;
		}
	}
}

//Function Number: 16
func_8239(param_00)
{
	self method_808C();
	common_scripts\utility::func_9D9F();
}

//Function Number: 17
func_823A(param_00)
{
	self method_808C();
	common_scripts\utility::func_9DA3();
}

//Function Number: 18
func_8227(param_00,param_01)
{
	param_00 notify(param_01);
}

//Function Number: 19
func_8223(param_00,param_01)
{
	level notify(param_01);
}

//Function Number: 20
func_8215(param_00)
{
	self method_8060();
}

//Function Number: 21
func_8219(param_00)
{
	self method_805F(param_00);
}

//Function Number: 22
func_8236(param_00)
{
	self solid();
}

//Function Number: 23
func_8228(param_00)
{
	self notsolid();
}

//Function Number: 24
func_8218(param_00)
{
	self delete();
}

//Function Number: 25
func_821C(param_00)
{
	self method_805C();
}

//Function Number: 26
func_8235(param_00)
{
	self method_805B();
}

//Function Number: 27
func_8238(param_00)
{
	self notify("trigger");
}

//Function Number: 28
func_821A(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		self waittill(param_01,var_04);
		param_00 [[ param_02 ]](var_04);
		if(isdefined(param_03) && isdefined(var_04))
		{
			var_04 func_823D(param_00,param_03);
			continue;
		}

		break;
	}
}

//Function Number: 29
func_823B()
{
	var_00 = [];
	if(func_8221())
	{
		var_00[var_00.size] = self;
	}

	foreach(var_02 in self.var_5DAB)
	{
		if(var_02 func_8221())
		{
			var_00[var_00.size] = var_02;
		}
	}

	if(var_00.size == 0)
	{
		return;
	}

	for(;;)
	{
		foreach(var_05 in var_00)
		{
			var_05 func_8219();
		}

		self waittill("move_start");
		foreach(var_05 in var_00)
		{
			var_05 func_8215();
		}

		self waittill("move_end");
	}
}

//Function Number: 30
func_8210()
{
	childthread func_823B();
	var_00 = self.var_6E5C["animation"];
	if(isdefined(level.var_8211[var_00]["idle"]))
	{
		func_822E(level.var_8211[var_00]["idle"],0);
	}

	func_8217();
	self notify("move_start");
	self notify("start",self);
	var_01 = level.var_8211[var_00]["default"];
	if(isdefined(var_01))
	{
		func_822E(var_01,1);
		self waittill("end");
	}

	self notify("move_end");
}

//Function Number: 31
func_822E(param_00,param_01)
{
	self notify("play_animation");
	if(param_01)
	{
		thread func_821B();
	}

	if(isdefined(self.var_830E))
	{
		self method_8495(param_00.var_EC4,self.var_830E.var_116,self.var_830E.var_1D,"script_mover_anim");
		return;
	}

	self method_8278(param_00.var_EC4,"script_mover_anim");
}

//Function Number: 32
func_821B()
{
	self endon("play_animation");
	self endon("mover_reset");
	for(;;)
	{
		self waittill("script_mover_anim",var_00);
		self notify(var_00,self);
	}
}

//Function Number: 33
func_8217()
{
	if(isdefined(self.var_6E5C["delay_till"]))
	{
		level waittill(self.var_6E5C["delay_till"]);
	}

	if(isdefined(self.var_6E5C["delay_till_trigger"]) && self.var_6E5C["delay_till_trigger"])
	{
		self waittill("trigger");
	}

	if(self.var_6E5C["delay_time"] > 0)
	{
		wait(self.var_6E5C["delay_time"]);
	}
}

//Function Number: 34
func_8225(param_00)
{
	self endon("death");
	self endon("new_path");
	childthread func_823B();
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	while(param_00.var_480C.size != 0)
	{
		var_01 = common_scripts\utility::func_7A33(param_00.var_480C);
		var_02 = self;
		var_02 func_8212(var_01);
		var_02 func_8217();
		var_03 = var_02.var_6E5C["move_time"];
		var_04 = var_02.var_6E5C["accel_time"];
		var_05 = var_02.var_6E5C["decel_time"];
		var_06 = 0;
		var_07 = 0;
		var_08 = transformmove(var_01.var_116,var_01.var_1D,self.var_6C3E.var_116,self.var_6C3E.var_1D,self.var_116,self.var_1D);
		if(var_02.var_116 != var_01.var_116)
		{
			if(isdefined(var_02.var_6E5C["move_speed"]))
			{
				var_09 = distance(var_02.var_116,var_01.var_116);
				var_03 = var_09 / var_02.var_6E5C["move_speed"];
			}

			if(isdefined(var_02.var_6E5C["accel_frac"]))
			{
				var_04 = var_02.var_6E5C["accel_frac"] * var_03;
			}

			if(isdefined(var_02.var_6E5C["decel_frac"]))
			{
				var_05 = var_02.var_6E5C["decel_frac"] * var_03;
			}

			if(var_03 <= 0)
			{
				var_02 method_808C();
				var_02.var_116 = var_08["origin"];
			}
			else
			{
				var_02 moveto(var_08["origin"],var_03,var_04,var_05);
			}

			var_06 = 1;
		}

		if(func_0DDE(var_08["angles"]) != func_0DDE(var_02.var_1D))
		{
			if(var_03 <= 0)
			{
				var_02 method_808C();
				var_02.var_1D = var_08["angles"];
			}
			else
			{
				var_02 rotateto(var_08["angles"],var_03,var_04,var_05);
			}

			var_07 = 1;
		}

		foreach(var_0B in var_02.var_64C5)
		{
			var_0B notify("trigger");
			func_823D(var_0B,::func_822F);
		}

		var_02 notify("move_start");
		param_00 notify("depart",var_02);
		if(isdefined(var_02.var_6E5C["name"]))
		{
			var_0D = "mover_depart_" + var_02.var_6E5C["name"];
			var_02 notify(var_0D);
			level notify(var_0D,var_02);
		}

		var_02 func_820F(0);
		if(var_03 <= 0)
		{
		}
		else if(var_06)
		{
			var_02 waittill("movedone");
		}
		else if(var_07)
		{
			var_02 waittill("rotatedone");
		}
		else
		{
			wait(var_03);
		}

		var_02 notify("move_end");
		var_01 notify("arrive",var_02);
		if(isdefined(var_02.var_6E5C["name"]))
		{
			var_0D = "mover_arrive_" + var_02.var_6E5C["name"];
			var_02 notify(var_0D);
			level notify(var_0D,var_02);
		}

		if(isdefined(var_02.var_6E5C["solid"]))
		{
			if(var_02.var_6E5C["solid"])
			{
				var_02 solid();
			}
			else
			{
				var_02 notsolid();
			}
		}

		foreach(var_0B in var_01.var_64C5)
		{
			var_0B notify("trigger");
			func_823D(var_0B,::func_822F);
		}

		if(isdefined(var_02.var_6E5C["wait_till"]))
		{
			level waittill(var_02.var_6E5C["wait_till"]);
		}

		if(var_02.var_6E5C["wait_time"] > 0)
		{
			wait(var_02.var_6E5C["wait_time"]);
		}

		var_02 func_820F(1);
		param_00 = var_01;
	}
}

//Function Number: 35
func_823D(param_00,param_01)
{
	thread func_821A(param_00,"mover_reset",param_01);
}

//Function Number: 36
func_821F()
{
	self.var_6E5C = [];
	if(!isdefined(self.var_1D))
	{
		self.var_1D = (0,0,0);
	}

	self.var_1D = func_0DDE(self.var_1D);
	func_822B(self.var_8260);
}

//Function Number: 37
func_822B(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	var_01 = strtok(param_00,";");
	foreach(var_03 in var_01)
	{
		var_04 = strtok(var_03,"=");
		if(var_04.size != 2)
		{
			continue;
		}

		if(var_04[1] == "undefined" || var_04[1] == "default")
		{
			self.var_6E5C[var_04[0]] = "<undefined>";
			continue;
		}

		switch(var_04[0])
		{
			case "decel_frac":
			case "accel_frac":
			case "move_speed":
			case "delay_time":
			case "wait_time":
			case "decel_time":
			case "accel_time":
			case "move_time":
				self.var_6E5C[var_04[0]] = func_822C(var_04[1]);
				break;

			case "wait_till":
			case "delay_till":
			case "hintstring":
			case "animation":
			case "name":
				self.var_6E5C[var_04[0]] = var_04[1];
				break;

			case "delay_till_trigger":
			case "usable":
			case "solid":
				self.var_6E5C[var_04[0]] = int(var_04[1]);
				break;

			case "script_params":
				var_05 = var_04[1];
				var_06 = level.var_8229[var_05];
				if(isdefined(var_06))
				{
					func_822B(var_06);
				}
				break;

			default:
				break;
		}
	}
}

//Function Number: 38
func_822C(param_00)
{
	var_01 = 0;
	var_02 = strtok(param_00,",");
	if(var_02.size == 1)
	{
		var_01 = float(var_02[0]);
	}
	else if(var_02.size == 2)
	{
		var_03 = float(var_02[0]);
		var_04 = float(var_02[1]);
		if(var_03 >= var_04)
		{
			var_01 = var_03;
		}
		else
		{
			var_01 = randomfloatrange(var_03,var_04);
		}
	}

	return var_01;
}

//Function Number: 39
func_8212(param_00)
{
	foreach(var_03, var_02 in param_00.var_6E5C)
	{
		func_8233(var_03,var_02);
	}

	func_8232();
}

//Function Number: 40
func_8233(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 == "usable" && isdefined(param_01))
	{
		func_8234(self,param_01);
	}

	if(isdefined(param_01) && isstring(param_01) && param_01 == "<undefined>")
	{
		param_01 = undefined;
	}

	self.var_6E5C[param_00] = param_01;
}

//Function Number: 41
func_820F(param_00)
{
	if(self.var_6E5C["usable"])
	{
		func_8234(self,param_00);
	}

	foreach(var_02 in self.var_A1F9)
	{
		func_8234(var_02,param_00);
	}
}

//Function Number: 42
func_8234(param_00,param_01)
{
	if(param_01)
	{
		param_00 makeusable();
		param_00 setcursorhint("HINT_ACTIVATE");
		param_00 sethintstring(level.var_821D[self.var_6E5C["hintstring"]]);
		return;
	}

	param_00 makeunusable();
}

//Function Number: 43
func_8231()
{
	self.var_6E5D = [];
	foreach(var_02, var_01 in self.var_6E5C)
	{
		self.var_6E5D[var_02] = var_01;
	}
}

//Function Number: 44
func_8232()
{
	if(isdefined(self.var_6E5D))
	{
		foreach(var_02, var_01 in self.var_6E5D)
		{
			if(!isdefined(self.var_6E5C[var_02]))
			{
				func_8233(var_02,var_01);
			}
		}
	}

	foreach(var_02, var_01 in level.var_8216)
	{
		if(!isdefined(self.var_6E5C[var_02]))
		{
			func_8233(var_02,var_01);
		}
	}
}

//Function Number: 45
func_8221()
{
	return isdefined(self.var_187) && self.var_187 & 1;
}

//Function Number: 46
func_8220()
{
	return isdefined(self.var_6E5C["animation"]);
}

//Function Number: 47
func_00D5()
{
	level thread func_8214();
	level thread func_820E();
}

//Function Number: 48
func_8214()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_7388();
	}
}

//Function Number: 49
func_820E()
{
	for(;;)
	{
		level waittill("spawned_agent",var_00);
		var_00 thread func_7388();
	}
}

//Function Number: 50
func_7388()
{
	self endon("disconnect");
	if(function_01EF(self))
	{
		self endon("death");
	}

	self.var_A043 = 0;
	for(;;)
	{
		self waittill("unresolved_collision",var_00);
		if(function_01EF(self) && isdefined(self.var_EAE))
		{
			if(self method_8554() == "noclip")
			{
				continue;
			}
		}

		self.var_A043++;
		thread func_23D3();
		var_01 = 3;
		if(isdefined(var_00) && isdefined(var_00.var_A049))
		{
			var_01 = var_00.var_A049;
		}

		if(self.var_A043 >= var_01)
		{
			if(isdefined(var_00))
			{
				if(isdefined(var_00.var_A045))
				{
					var_00 [[ var_00.var_A045 ]](self);
				}
				else if(isdefined(var_00.var_A046) && var_00.var_A046)
				{
					var_00 func_A04A(self);
				}
				else
				{
					var_00 func_A047(self);
				}
			}
			else
			{
				func_A047(self);
			}

			self.var_A043 = 0;
		}
	}
}

//Function Number: 51
func_23D3()
{
	self endon("unresolved_collision");
	wait 0.05;
	if(isdefined(self))
	{
		self.var_A043 = 0;
	}
}

//Function Number: 52
func_A04A(param_00)
{
	var_01 = self;
	if(!isdefined(var_01.var_117))
	{
		param_00 func_64C1();
		return;
	}

	var_02 = 0;
	if(level.var_984D)
	{
		if(isdefined(var_01.var_117.var_1A7) && var_01.var_117.var_1A7 != param_00.var_1A7)
		{
			var_02 = 1;
		}
	}
	else if(param_00 != var_01.var_117)
	{
		var_02 = 1;
	}

	if(!var_02)
	{
		param_00 func_64C1();
		return;
	}

	var_03 = 1000;
	if(isdefined(var_01.var_A044))
	{
		var_03 = var_01.var_A044;
	}

	param_00 dodamage(var_03,var_01.var_116,var_01.var_117,var_01,"MOD_CRUSH");
}

//Function Number: 53
func_A047(param_00,param_01)
{
	var_02 = self.var_A048;
	var_03 = undefined;
	if(maps\mp\_utility::func_585F() && common_scripts\utility::func_562E(level.use_zombie_unresolved_collision))
	{
		if(!isdefined(var_02))
		{
			var_02 = [];
		}

		var_04 = getclosestpointonnavmesh(param_00.var_116);
		if(isdefined(var_04))
		{
			var_03 = spawnstruct();
			var_03.var_116 = getclosestpointonnavmesh(param_00.var_116);
			var_02 = common_scripts\utility::func_F6F(var_02,var_03);
		}

		var_02 = common_scripts\utility::func_F73(var_02,getnodesinradius(param_00.var_116,300,0,200,"End 3D"));
		if(isdefined(level.failsafe_collision_nodes) && isarray(level.failsafe_collision_nodes))
		{
			var_02 = common_scripts\utility::func_F73(var_02,level.failsafe_collision_nodes);
		}
	}

	if(isdefined(var_02))
	{
		var_02 = function_01AC(var_02,param_00.var_116);
	}
	else
	{
		var_02 = getnodesinradius(param_00.var_116,300,0,200);
		var_02 = function_01AC(var_02,param_00.var_116);
	}

	var_05 = (0,0,-100);
	param_00 method_843C();
	param_00 method_808C();
	param_00 setorigin(param_00.var_116 + var_05);
	for(var_06 = 0;var_06 < var_02.size;var_06++)
	{
		var_07 = var_02[var_06];
		var_08 = var_07.var_116;
		if(!canspawn(var_08))
		{
			continue;
		}

		if(positionwouldtelefrag(var_08))
		{
			continue;
		}

		if(param_00 playerisweaponplantenabled())
		{
			param_00 common_scripts\_plant_weapon::forcedismountweapon();
		}

		if(param_00 getstance() == "prone")
		{
			param_00 setstance("crouch");
		}

		param_00 setorigin(var_08);
		return;
	}

	if(level.var_15D == "mp_hub_allies_slim" && var_02.size == 0)
	{
		if(param_00 playerisweaponplantenabled())
		{
			param_00 common_scripts\_plant_weapon::forcedismountweapon();
		}

		return;
	}

	param_00 setorigin(param_00.var_116 - var_05);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		param_00 func_64C1();
	}
}

//Function Number: 54
func_A04B(param_00)
{
}

//Function Number: 55
func_64C1()
{
	maps\mp\_utility::func_728();
}

//Function Number: 56
func_7305(param_00)
{
	self endon("death");
	self endon("stop_player_pushed_kill");
	for(;;)
	{
		self waittill("player_pushed",var_01,var_02);
		if(isplayer(var_01) || function_01EF(var_01))
		{
			var_03 = length(var_02);
			if(var_03 >= param_00)
			{
				func_A04A(var_01);
			}
		}
	}
}

//Function Number: 57
func_93E1()
{
	self notify("stop_player_pushed_kill");
}

//Function Number: 58
func_67F9()
{
	var_00 = self getlinkedchildren(0);
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_66F0) && var_02.var_66F0)
		{
			continue;
		}

		var_02 unlink();
		var_02 notify("invalid_parent",self);
	}
}

//Function Number: 59
func_774B(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.var_66EF) && param_01.var_66EF)
	{
		return;
	}

	if(isdefined(param_00.var_720F))
	{
		playfx(common_scripts\utility::func_44F5("airdrop_crate_destroy"),self.var_116);
	}

	if(isdefined(param_00.var_2AA8))
	{
		self thread [[ param_00.var_2AA8 ]](param_00);
		return;
	}

	self delete();
}

//Function Number: 60
func_4A26(param_00)
{
	for(;;)
	{
		self waittill("touching_platform",var_01);
		if(isdefined(param_00.var_9AC2) && !self [[ param_00.var_9AC2 ]](var_01))
		{
			continue;
		}

		if(isdefined(param_00.var_A270) && param_00.var_A270)
		{
			if(!self istouching(var_01))
			{
				wait 0.05;
				continue;
			}
		}

		thread func_774B(param_00,var_01);
		break;
	}
}

//Function Number: 61
func_4A25(param_00)
{
	self waittill("invalid_parent",var_01);
	if(isdefined(param_00.var_54FA))
	{
		self thread [[ param_00.var_54FA ]](param_00);
		return;
	}

	thread func_774B(param_00,var_01);
}

//Function Number: 62
func_4A27(param_00)
{
	self notify("handle_moving_platforms");
	self endon("handle_moving_platforms");
	level endon("game_ended");
	self endon("death");
	self endon("stop_handling_moving_platforms");
	if(!isdefined(param_00))
	{
		param_00 = spawnstruct();
	}

	if(isdefined(param_00.var_36DE))
	{
		self endon(param_00.var_36DE);
	}

	if(isdefined(param_00.var_5DB9))
	{
		self linkto(param_00.var_5DB9);
	}

	childthread func_4A26(param_00);
	childthread func_4A25(param_00);
}

//Function Number: 63
func_93CE()
{
	self notify("stop_handling_moving_platforms");
}

//Function Number: 64
func_64E7(param_00)
{
}