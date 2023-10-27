/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_movers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 2479 ms
 * Timestamp: 10/27/2023 12:09:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		return;
	}

	level.var_EE36 = [];
	level.var_EE36["move_time"] = 5;
	level.var_EE36["accel_time"] = 0;
	level.var_EE36["decel_time"] = 0;
	level.var_EE36["wait_time"] = 0;
	level.var_EE36["delay_time"] = 0;
	level.var_EE36["usable"] = 0;
	level.var_EE36["hintstring"] = "activate";
	func_EE2E("activate",&"MP_ACTIVATE_MOVER");
	func_EE2F("none","");
	level.var_EE41 = [];
	scripts\common\utility::func_136F7();
	var_00 = [];
	var_01 = func_EE34();
	foreach(var_03 in var_01)
	{
		var_00 = scripts\common\utility::array_combine(var_00,getentarray(var_03,"classname"));
	}

	scripts\common\utility::array_thread(var_00,::func_EE3C);
}

//Function Number: 2
func_EE34()
{
	return ["script_model_mover","script_brushmodel_mover"];
}

//Function Number: 3
func_EE3D()
{
	if(isdefined(self.var_EE2D))
	{
		return self.var_EE2D;
	}

	var_00 = func_EE34();
	foreach(var_02 in var_00)
	{
		if(self.classname == var_02)
		{
			self.var_EE2D = 1;
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
func_EE2E(param_00,param_01)
{
	if(!isdefined(level.var_EE3A))
	{
		level.var_EE3A = [];
	}

	level.var_EE3A[param_00] = param_01;
}

//Function Number: 5
func_EE2F(param_00,param_01)
{
	if(!isdefined(level.var_EE42))
	{
		level.var_EE42 = [];
	}

	level.var_EE42[param_00] = param_01;
}

//Function Number: 6
func_EE3C()
{
	if(!isdefined(self.target))
	{
		return;
	}

	self.var_EE2D = 1;
	self.var_BD30 = 0;
	self.var_C714 = self;
	self.var_13034 = [];
	self.var_AD1E = [];
	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		switch(var_02.script_noteworthy)
		{
			case "origin":
				if(!isdefined(var_02.angles))
				{
					var_02.angles = (0,0,0);
				}
	
				self.var_C714 = spawn("script_model",var_02.origin);
				self.var_C714.angles = var_02.angles;
				self.var_C714 setmodel("tag_origin");
				self.var_C714 linkto(self);
				break;

			default:
				break;
		}
	}

	var_04 = getentarray(self.target,"targetname");
	foreach(var_02 in var_04)
	{
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		switch(var_02.script_noteworthy)
		{
			case "use_trigger_link":
				var_02 enablelinkto();
				var_02 linkto(self);
				break;

			case "use_trigger":
				var_02 func_EE45();
				thread func_EE4F(var_02);
				self.var_13034[self.var_13034.size] = var_02;
				break;

			case "link":
				var_02 linkto(self);
				self.var_AD1E[self.var_AD1E.size] = var_02;
				break;

			default:
				break;
		}
	}

	thread func_EE45();
	thread func_EE3B();
	thread func_EE47();
	thread func_EE32(self);
	thread func_EE40();
	foreach(var_08 in self.var_13034)
	{
		func_EE4A(var_08,1);
	}
}

//Function Number: 7
func_EE4F(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00 waittill("trigger");
		if(param_00.var_8436.size > 0)
		{
			self notify("new_path");
			thread func_EE40(param_00);
			continue;
		}

		self notify("trigger");
	}
}

//Function Number: 8
func_EE3F(param_00)
{
	if(isdefined(level.var_EE41[param_00]))
	{
		self notify("new_path");
		self.var_8436 = [level.var_EE41[param_00]];
		thread func_EE40();
	}
}

//Function Number: 9
func_1E8B(param_00)
{
	return (angleclamp180(param_00[0]),angleclamp180(param_00[1]),angleclamp180(param_00[2]));
}

//Function Number: 10
func_EE45()
{
	if(isdefined(self.var_C907) && self.var_C907)
	{
		return;
	}

	self.var_C907 = 1;
	self.var_8436 = [];
	self.var_BCEA = [];
	self.var_ABDF = [];
	var_00 = [];
	var_01 = [];
	if(isdefined(self.target))
	{
		var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
		var_01 = getentarray(self.target,"targetname");
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		if(!isdefined(var_03.script_noteworthy))
		{
			var_03.script_noteworthy = "goal";
		}

		switch(var_03.script_noteworthy)
		{
			case "ignore":
				if(isdefined(var_03.target))
				{
					var_04 = scripts\common\utility::getstructarray(var_03.target,"targetname");
					foreach(var_06 in var_04)
					{
						var_00[var_00.size] = var_06;
					}
				}
				break;

			case "goal":
				var_03 func_EE3B();
				var_03 func_EE45();
				self.var_8436[self.var_8436.size] = var_03;
				if(isdefined(var_03.var_C8F0["name"]))
				{
					level.var_EE41[var_03.var_C8F0["name"]] = var_03;
				}
				break;

			case "level_notify":
				if(isdefined(var_03.var_EE79))
				{
					self.var_ABDF[self.var_ABDF.size] = var_03;
				}
				break;

			default:
				break;
		}
	}

	foreach(var_09 in var_01)
	{
		if(var_09 func_EE3D())
		{
			self.var_BCEA[self.var_BCEA.size] = var_09;
			continue;
		}

		if(!isdefined(var_09.script_noteworthy))
		{
			continue;
		}

		var_0A = strtok(var_09.script_noteworthy,"_");
		if(var_0A.size != 3 || var_0A[1] != "on")
		{
			continue;
		}

		switch(var_0A[0])
		{
			case "delete":
				thread func_EE33(var_09,::delete,var_0A[2]);
				break;

			case "hide":
				thread func_EE33(var_09,::hide,var_0A[2]);
				break;

			case "show":
				var_09 hide();
				thread func_EE33(var_09,::show,var_0A[2]);
				break;

			case "triggerHide":
			case "triggerhide":
				thread func_EE37(var_09,::scripts\common\utility::trigger_off,var_0A[2]);
				break;

			case "triggerShow":
			case "triggershow":
				var_09 scripts\common\utility::trigger_off();
				thread func_EE37(var_09,::scripts\common\utility::trigger_on,var_0A[2]);
				break;

			default:
				break;
		}
	}
}

//Function Number: 11
func_EE37(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		self waittill(param_02);
		param_00 [[ param_01 ]]();
	}
}

//Function Number: 12
func_EE33(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		self waittill(param_02);
		param_00 [[ param_01 ]]();
	}
}

//Function Number: 13
func_EE4C()
{
	scripts\common\utility::trigger_on();
}

//Function Number: 14
func_EE40(param_00)
{
	self endon("death");
	self endon("new_path");
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	while(param_00.var_8436.size != 0)
	{
		var_01 = scripts\common\utility::random(param_00.var_8436);
		var_02 = self;
		var_02 func_EE32(var_01);
		if(isdefined(var_02.var_C8F0["delay_till"]))
		{
			level waittill(var_02.var_C8F0["delay_till"]);
		}

		if(isdefined(var_02.var_C8F0["delay_till_trigger"]) && var_02.var_C8F0["delay_till_trigger"])
		{
			self waittill("trigger");
		}

		if(var_02.var_C8F0["delay_time"] > 0)
		{
			wait(var_02.var_C8F0["delay_time"]);
		}

		var_03 = var_02.var_C8F0["move_time"];
		var_04 = var_02.var_C8F0["accel_time"];
		var_05 = var_02.var_C8F0["decel_time"];
		var_06 = 0;
		var_07 = 0;
		var_08 = transformmove(var_01.origin,var_01.angles,self.var_C714.origin,self.var_C714.angles,self.origin,self.angles);
		if(var_02.origin != var_01.origin)
		{
			if(isdefined(var_02.var_C8F0["move_speed"]))
			{
				var_09 = distance(var_02.origin,var_01.origin);
				var_03 = var_09 / var_02.var_C8F0["move_speed"];
			}

			if(isdefined(var_02.var_C8F0["accel_frac"]))
			{
				var_04 = var_02.var_C8F0["accel_frac"] * var_03;
			}

			if(isdefined(var_02.var_C8F0["decel_frac"]))
			{
				var_05 = var_02.var_C8F0["decel_frac"] * var_03;
			}

			var_02 moveto(var_08["origin"],var_03,var_04,var_05);
			foreach(var_0B in var_01.var_ABDF)
			{
				thread func_EE46(var_0B.origin,var_0B.var_EE79,self.origin,var_01.origin);
			}

			var_06 = 1;
		}

		if(func_1E8B(var_08["angles"]) != func_1E8B(var_02.angles))
		{
			var_02 rotateto(var_08["angles"],var_03,var_04,var_05);
			var_07 = 1;
		}

		foreach(var_0E in var_02.var_BCEA)
		{
			var_0E notify("trigger");
		}

		param_00 notify("depart");
		var_02 func_EE31(0);
		self.var_BD30 = 1;
		if(isdefined(var_02.var_C8F0["move_time_offset"]) && var_02.var_C8F0["move_time_offset"] + var_03 > 0)
		{
			wait(var_02.var_C8F0["move_time_offset"] + var_03);
		}
		else if(var_06)
		{
			self waittill("movedone");
		}
		else if(var_07)
		{
			self waittill("rotatedone");
		}
		else
		{
			wait(var_03);
		}

		self.var_BD30 = 0;
		self notify("move_end");
		var_01 notify("arrive");
		if(isdefined(var_02.var_C8F0["solid"]))
		{
			if(var_02.var_C8F0["solid"])
			{
				var_02 solid();
			}
			else
			{
				var_02 notsolid();
			}
		}

		foreach(var_0E in var_01.var_BCEA)
		{
			var_0E notify("trigger");
		}

		if(isdefined(var_02.var_C8F0["wait_till"]))
		{
			level waittill(var_02.var_C8F0["wait_till"]);
		}

		if(var_02.var_C8F0["wait_time"] > 0)
		{
			wait(var_02.var_C8F0["wait_time"]);
		}

		var_02 func_EE31(1);
		param_00 = var_01;
	}
}

//Function Number: 15
func_EE46(param_00,param_01,param_02,param_03)
{
	self endon("move_end");
	var_04 = self;
	var_05 = vectornormalize(param_03 - param_02);
	for(;;)
	{
		var_06 = vectornormalize(param_00 - var_04.origin);
		if(vectordot(var_05,var_06) <= 0)
		{
			break;
		}

		wait(0.05);
	}

	level notify(param_01);
}

//Function Number: 16
func_EE3B()
{
	self.var_C8F0 = [];
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	self.angles = func_1E8B(self.angles);
	func_EE43(self.var_EE79);
}

//Function Number: 17
func_EE43(param_00)
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
			self.var_C8F0[var_04[0]] = undefined;
			continue;
		}

		switch(var_04[0])
		{
			case "move_time_offset":
			case "decel_frac":
			case "accel_frac":
			case "move_speed":
			case "delay_time":
			case "wait_time":
			case "decel_time":
			case "accel_time":
			case "move_time":
				self.var_C8F0[var_04[0]] = func_EE44(var_04[1]);
				break;

			case "wait_till":
			case "delay_till":
			case "hintstring":
			case "name":
				self.var_C8F0[var_04[0]] = var_04[1];
				break;

			case "delay_till_trigger":
			case "usable":
			case "solid":
				self.var_C8F0[var_04[0]] = int(var_04[1]);
				break;

			case "script_params":
				var_05 = var_04[1];
				var_06 = level.var_EE42[var_05];
				if(isdefined(var_06))
				{
					func_EE43(var_06);
				}
				break;

			default:
				break;
		}
	}
}

//Function Number: 18
func_EE44(param_00)
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

//Function Number: 19
func_EE32(param_00)
{
	foreach(var_03, var_02 in param_00.var_C8F0)
	{
		func_EE49(var_03,var_02);
	}

	func_EE48();
}

//Function Number: 20
func_EE49(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 == "usable" && isdefined(param_01))
	{
		func_EE4A(self,param_01);
	}

	self.var_C8F0[param_00] = param_01;
}

//Function Number: 21
func_EE31(param_00)
{
	if(self.var_C8F0["usable"])
	{
		func_EE4A(self,param_00);
	}

	foreach(var_02 in self.var_13034)
	{
		func_EE4A(var_02,param_00);
	}
}

//Function Number: 22
func_EE4A(param_00,param_01)
{
	if(param_01)
	{
		param_00 makeusable();
		param_00 setcursorhint("HINT_NOICON");
		param_00 sethintstring(level.var_EE3A[self.var_C8F0["hintstring"]]);
		return;
	}

	param_00 makeunusable();
}

//Function Number: 23
func_EE47()
{
	self.var_C8F1 = [];
	foreach(var_02, var_01 in self.var_C8F0)
	{
		self.var_C8F1[var_02] = var_01;
	}
}

//Function Number: 24
func_EE48()
{
	foreach(var_02, var_01 in level.var_EE36)
	{
		if(!isdefined(self.var_C8F0[var_02]))
		{
			func_EE49(var_02,var_01);
		}
	}

	if(isdefined(self.var_C8F1))
	{
		foreach(var_02, var_01 in self.var_C8F1)
		{
			if(!isdefined(self.var_C8F0[var_02]))
			{
				func_EE49(var_02,var_01);
			}
		}
	}
}

//Function Number: 25
init()
{
	level thread func_EE30();
}

//Function Number: 26
func_EE30()
{
	for(;;)
	{
		level waittill("spawned_agent",var_00);
		var_00 thread func_D312();
	}
}

//Function Number: 27
func_D312()
{
	self endon("disconnect");
	if(isagent(self))
	{
		self endon("death");
	}

	self.var_12BE5 = 0;
	for(;;)
	{
		self waittill("unresolved_collision",var_00);
		self.var_12BE5++;
		thread func_418E();
		var_01 = 3;
		if(isdefined(var_00) && isdefined(var_00.var_12BEC))
		{
			var_01 = var_00.var_12BEC;
		}

		if(self.var_12BE5 >= var_01)
		{
			if(isdefined(var_00))
			{
				if(isdefined(var_00.var_12BE7))
				{
					var_00 [[ var_00.var_12BE7 ]](self);
				}
				else if(isdefined(var_00.var_12BE8) && var_00.var_12BE8)
				{
					var_00 func_12BED(self);
				}
				else
				{
					var_00 func_12BEA(self);
				}
			}
			else
			{
				func_12BEA(self);
			}

			self.var_12BE5 = 0;
		}
	}
}

//Function Number: 28
func_418E()
{
	self endon("unresolved_collision");
	scripts\common\utility::func_136F7();
	if(isdefined(self))
	{
		self.var_12BE5 = 0;
	}
}

//Function Number: 29
func_12BED(param_00)
{
	var_01 = self;
	if(!isdefined(var_01.var_222))
	{
		param_00 func_BCDE();
		return;
	}

	var_02 = 0;
	if(level.teambased)
	{
		if(isdefined(var_01.var_222.team) && var_01.var_222.team != param_00.team)
		{
			var_02 = 1;
		}
	}
	else if(param_00 != var_01.var_222)
	{
		var_02 = 1;
	}

	if(!var_02)
	{
		param_00 func_BCDE();
		return;
	}

	var_03 = 1000;
	if(isdefined(var_01.var_12BE6))
	{
		var_03 = var_01.var_12BE6;
	}

	param_00 dodamage(var_03,var_01.origin,var_01.var_222,var_01,"MOD_CRUSH");
}

//Function Number: 30
func_12BEA(param_00,param_01)
{
	if(isdefined(level.var_C81D))
	{
		self [[ level.var_C81D ]](param_00,param_01);
		return;
	}

	var_02 = self.var_12BEB;
	if(isdefined(var_02))
	{
		var_02 = sortbydistance(var_02,param_00.origin);
	}
	else
	{
		var_02 = getnodesinradius(param_00.origin,300,0,200);
		var_02 = sortbydistance(var_02,param_00.origin);
	}

	var_03 = (0,0,-100);
	param_00 cancelmantle();
	param_00 dontinterpolate();
	param_00 setorigin(param_00.origin + var_03);
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		var_06 = var_05.origin;
		if(!canspawn(var_06))
		{
			continue;
		}

		if(positionwouldtelefrag(var_06))
		{
			continue;
		}

		if(param_00 getstance() == "prone")
		{
			param_00 setstance("crouch");
		}

		param_00 setorigin(var_06);
		return;
	}

	param_00 setorigin(param_00.origin - var_03);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		param_00 func_BCDE();
	}
}

//Function Number: 31
func_12BEE(param_00)
{
}

//Function Number: 32
func_BCDE()
{
	if(isdefined(level.var_9E36) && !isagent(self))
	{
		return;
	}

	scripts\cp\_utility::func_1417();
}

//Function Number: 33
func_D246(param_00)
{
	self endon("death");
	self endon("stop_player_pushed_kill");
	for(;;)
	{
		self waittill("player_pushed",var_01,var_02);
		if(isplayer(var_01) || isagent(var_01))
		{
			var_03 = length(var_02);
			if(var_03 >= param_00)
			{
				func_12BED(var_01);
			}
		}
	}
}

//Function Number: 34
func_11030()
{
	self notify("stop_player_pushed_kill");
}

//Function Number: 35
func_EE38()
{
	var_00 = self getlinkedparent();
	for(var_01 = var_00;isdefined(var_01);var_01 = var_01 getlinkedparent())
	{
		var_00 = var_01;
	}

	return var_00;
}

//Function Number: 36
func_EE4B(param_00)
{
	var_01 = param_00 func_EE38();
	if(isdefined(var_01))
	{
		var_01.var_10E07 = var_01.origin;
	}

	self.var_10E06 = self getmovingplatformparent();
	if(isdefined(self.var_10E06))
	{
		var_02 = self.var_10E06 func_EE38();
		if(isdefined(var_02))
		{
			self.var_10E06 = var_02;
		}

		self.var_10E06.var_10E07 = self.var_10E06.origin;
	}
}

//Function Number: 37
func_EE39(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return lengthsquared(param_00.origin - param_00.var_10E07) > 0.001;
}

//Function Number: 38
func_EE4E(param_00)
{
	if(!isplayer(self))
	{
		return 1;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00 func_EE38();
	var_02 = self.var_10E06;
	if(!isdefined(var_01) && !isdefined(var_02))
	{
		return 1;
	}

	if(isdefined(var_01) && isdefined(var_02) && var_01 == var_02)
	{
		return 1;
	}

	if(func_EE39(var_01))
	{
		return 0;
	}

	if(func_EE39(var_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
func_EE3E(param_00)
{
	if(isplayer(param_00))
	{
		param_00 func_EE4B(self);
		var_01 = param_00 getmovingplatformparent();
		var_02 = undefined;
		if(isdefined(var_01))
		{
			var_02 = var_01;
		}
		else if(!isdefined(func_EE38()))
		{
			var_02 = self;
		}
		else
		{
			var_02 = spawn("script_model",param_00.origin);
			var_02 setmodel("tag_origin");
			param_00.var_EF85 = var_02;
			param_00 thread func_EC11(var_02);
		}

		param_00 playerlinkto(var_02);
	}
	else
	{
		param_00 linkto(self);
	}

	param_00 playerlinkedoffsetenable();
}

//Function Number: 40
func_EE4D(param_00)
{
	param_00 unlink();
	if(isdefined(param_00.var_EF85))
	{
		param_00 notify("removeMoverLinkDummy");
		param_00.var_EF85 delete();
		param_00.var_EF85 = undefined;
	}
}

//Function Number: 41
func_EC11(param_00)
{
	self endon("removeMoverLinkDummy");
	scripts\common\utility::waittill_any_3("death","disconnect");
	self.var_EF85 delete();
	self.var_EF85 = undefined;
}

//Function Number: 42
func_C13B()
{
	var_00 = self getlinkedchildren(0);
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_C000) && var_02.var_C000)
		{
			continue;
		}

		var_02 unlink();
		var_02 notify("invalid_parent",self);
	}
}

//Function Number: 43
func_D981(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.var_BFFF) && param_01.var_BFFF)
	{
		return;
	}

	if(isdefined(param_00.var_CF14))
	{
		playfx(scripts\common\utility::getfx("airdrop_crate_destroy"),self.origin);
	}

	if(isdefined(param_00.var_4E53))
	{
		param_00.var_AA33 = param_01;
		self thread [[ param_00.var_4E53 ]](param_00);
		return;
	}

	self delete();
}

//Function Number: 44
func_892E(param_00)
{
	self notify("handle_moving_platform_touch");
	self endon("handle_moving_platform_touch");
	level endon("game_ended");
	self endon("death");
	self endon("stop_handling_moving_platforms");
	if(isdefined(param_00.var_6371))
	{
		self endon(param_00.var_6371);
	}

	for(;;)
	{
		self waittill("touching_platform",var_01);
		if(isdefined(param_00.var_13139) && param_00.var_13139)
		{
			if(!self istouching(var_01))
			{
				wait(0.05);
				continue;
			}
		}

		thread func_D981(param_00,var_01);
		break;
	}
}

//Function Number: 45
func_892D(param_00)
{
	self notify("handle_moving_platform_invalid");
	self endon("handle_moving_platform_invalid");
	level endon("game_ended");
	self endon("death");
	self endon("stop_handling_moving_platforms");
	if(isdefined(param_00.var_6371))
	{
		self endon(param_00.var_6371);
	}

	self waittill("invalid_parent",var_01);
	if(isdefined(param_00.var_9B11))
	{
		self thread [[ param_00.var_9B11 ]](param_00);
		return;
	}

	thread func_D981(param_00,var_01);
}

//Function Number: 46
func_892F(param_00)
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

	if(isdefined(param_00.var_6371))
	{
		self endon(param_00.var_6371);
	}

	if(isdefined(param_00.var_AD39))
	{
		var_01 = self getlinkedparent();
		if(!isdefined(var_01) || var_01 != param_00.var_AD39)
		{
			self linkto(param_00.var_AD39);
		}
	}

	thread func_892E(param_00);
	thread func_892D(param_00);
}

//Function Number: 47
func_11001()
{
	self notify("stop_handling_moving_platforms");
}

//Function Number: 48
func_BD3C(param_00)
{
}