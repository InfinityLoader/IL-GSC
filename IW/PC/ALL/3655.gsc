/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3655.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 19 ms
 * Timestamp: 10/27/2023 12:31:00 AM
*******************************************************************/

//Function Number: 1
func_4D8A()
{
	self.var_4D8B = 1;
	thread func_11ABF();
	self notifyonplayercommand("jump","+gostand");
	self notifyonplayercommand("jump","+moveup");
	self.var_4D93 = undefined;
	var_00 = scripts\common\utility::spawn_tag_origin();
	var_00.angles = (0,0,0);
	self method_823F(var_00);
	thread func_A4D9();
	while(lib_0E4F::func_9C7B())
	{
		while(level.player method_8439() || level.player method_843B() || level.player method_81CE())
		{
			wait(0.05);
		}

		self waittill("juke");
		var_01 = self getnormalizedmovement();
		if(self adsbuttonpressed() || self getstance() == "prone")
		{
			continue;
		}

		var_02 = scripts\common\trace::func_DCED(self.origin + (0,0,1),self.origin - (0,0,32),self);
		self.var_4D93 = 1;
		self method_8009(0);
		var_03 = scripts\common\utility::spawn_tag_origin();
		var_03.origin = self.origin;
		var_03.angles = self.angles;
		var_04 = getdvarint("g_speed");
		thread scripts\sp\_utility::func_D2CD(50,0.1);
		self method_80D8(0.5,0.5);
		var_05 = anglestoup(level.player.angles);
		var_06 = undefined;
		var_07 = undefined;
		var_08 = 0;
		if(self method_843B())
		{
			var_01 = var_05 * -1;
			var_09 = 0.1;
			var_0A = 0.1;
			var_0B = 0.125;
			var_0C = 0.4;
			var_0D = 0.025;
			var_0E = 3000;
			var_08 = 1;
		}
		else if(self method_81CE())
		{
			var_01 = var_05;
			var_09 = 0.1;
			var_0A = 0.1;
			var_0B = 0.125;
			var_0C = 0.4;
			var_0D = 0.025;
			var_0E = 3000;
			var_08 = 1;
		}
		else if(var_01[0] > 0.7)
		{
			var_09 = 0.1;
			var_0A = 0.1;
			var_0B = 0.1;
			var_0C = 0.4;
			var_0D = 0.025;
			var_0E = 1;
		}
		else
		{
			var_09 = 0.1;
			var_0A = 0.1;
			var_0B = 0.1;
			var_0C = 0.6;
			var_0D = 0.2;
			var_0E = 20000;
		}

		if(var_08 == 1)
		{
			var_07 = var_01;
		}
		else
		{
			var_06 = 125;
			if(var_02["fraction"] > 0.3)
			{
				var_0F = self getplayerangles() - vectortoangles(var_01);
				var_0F = (min(0,var_0F[0]),var_0F[1],var_0F[2]);
				var_07 = anglestoforward(var_0F) * var_04 * min(1,length(var_01));
				if(isdefined(self.var_5AD4))
				{
					var_07 = var_07 * 1.2;
				}

				var_06 = 150;
			}
			else
			{
				var_0F = self.angles - vectortoangles(var_02);
				var_07 = anglestoforward(var_0F) * var_04 * min(1,length(var_01));
				var_07 = var_07 - (0,0,var_07[2]);
			}

			var_03 method_820E((0,0,15),15,var_07 * 0.25 + (0,0,var_06));
		}

		earthquake(var_0A,var_09 * 0.5,self.origin,512);
		self setstance("stand");
		if(func_9C57())
		{
			self playerlinkto(var_03,"tag_origin",1);
			earthquake(0.2,0.3,self.origin,256);
		}
		else
		{
			earthquake(var_0B,var_0C,self.origin,2048);
			level notify("player_SwimWaterCurrent_lerp_savedDvar");
			var_07 = vectornormalize(var_07);
			function_01C5("player_SwimWaterCurrent",var_07 * var_0E);
			if(var_08 != 1)
			{
				thread func_118C4(var_00,var_07);
			}
		}

		wait(var_09);
		var_10 = self getlinkedparent();
		if(isdefined(var_10) && var_10 == var_03)
		{
			self setvelocity(var_07 + (0,0,50));
			self unlink();
		}

		if(func_9C57())
		{
			thread scripts\sp\_utility::func_CE2F("land");
			self method_80A6();
		}
		else
		{
			scripts\common\utility::func_5127(var_0D,::func_AB9C,"player_SwimWaterCurrent",(0,0,0),0.5);
		}

		var_03 delete();
		self method_8009(1);
		thread scripts\sp\_utility::func_D2CD(100,var_0D);
		thread lib_0E48::func_C144();
		if(func_9C57())
		{
			self waittill("landed_on_ground");
		}

		wait(var_0D);
		self.var_4D93 = undefined;
	}
}

//Function Number: 2
func_AB9C(param_00,param_01,param_02)
{
	var_03 = getdvarvector(param_00);
	var_04 = var_03;
	level notify(param_00 + "_lerp_savedDvar");
	level endon(param_00 + "_lerp_savedDvar");
	var_05 = 0;
	var_06 = param_01 - var_03;
	var_07 = 0.05 / param_02;
	while(var_05 < 1)
	{
		var_04 = var_03 + var_05 * var_06;
		function_01C5(param_00,var_04);
		var_05 = var_05 + var_07;
		scripts\common\utility::func_136F7();
	}

	function_01C5(param_00,param_01);
}

//Function Number: 3
func_11ABF()
{
	self notify("track_sprint_button");
	self endon("track_sprint_button");
	while(level.player scripts\sp\_utility::func_65DB("player_gravity_off"))
	{
		var_00 = self getnormalizedmovement();
		var_01 = length(var_00);
		if((self buttonpressed("BUTTON_LSTICK") && var_01 > 0.3) || self method_843B() || self method_81CE())
		{
			if(self.var_4D8B)
			{
				self notify("juke");
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 4
func_A4D9()
{
	while(level.player scripts\sp\_utility::func_65DB("player_gravity_off"))
	{
		self waittill("jump");
		if(self buttonpressed("BUTTON_LSTICK"))
		{
			while(self buttonpressed("BUTTON_LSTICK"))
			{
				self notify("track_sprint_button");
				scripts\common\utility::func_136F7();
			}

			thread func_11ABF();
		}
	}
}

//Function Number: 5
func_118C4(param_00,param_01)
{
	var_02 = param_01;
	var_03 = anglestoright(self.angles);
	var_04 = var_02 - 2 * var_03 * vectordot(var_02,var_03);
	var_04 = -1 * var_04;
	var_05 = 8;
	var_06 = var_04[0] * var_05;
	var_07 = var_04[1] * -1 * var_05;
	var_08 = 0.25;
	param_00 rotateto((var_06,0,var_07),var_08,0,var_08);
	param_00 waittill("rotatedone");
	var_09 = 0.75;
	param_00 rotateto((0,0,0),var_09,var_09 * 0.25,var_09 * 0.5);
	param_00 waittill("rotatedone");
}

//Function Number: 6
func_9C57()
{
	return !isdefined(self.var_2A6) || !self.var_2A6.var_6F43;
}