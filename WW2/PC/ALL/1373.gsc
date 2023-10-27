/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1373.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 17 ms
 * Timestamp: 10/27/2023 3:25:51 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	lib_055B::waittill_jumpscare_initialized();
	level.var_AB58 = 0;
	level.var_AB59 = 0;
	var_00 = common_scripts\utility::func_46B7("birds","script_noteworthy");
	level.var_AB5A = var_00.size * 0.2;
	foreach(var_02 in var_00)
	{
		var_02 thread func_1769();
	}
}

//Function Number: 2
func_1769()
{
	self.var_1767 = 0;
	self.var_AA2A = self.var_116 + (0,0,16);
	var_00 = undefined;
	foreach(var_02 in getentarray(self.var_1A2,"targetname"))
	{
		switch(var_02.var_3B)
		{
			case "trigger_radius":
				self.var_78CB = var_02;
				self.var_78CB thread func_1768(self);
				break;

			case "trigger_damage":
				var_02 thread func_1765(self);
				break;
		}
	}

	self.var_175F = [];
	foreach(var_05 in common_scripts\utility::func_46B7(self.var_1A2,"targetname"))
	{
		if(isdefined(var_05.var_165))
		{
			switch(var_05.var_165)
			{
				case "birds_anims":
					self.var_175F[self.var_175F.size] = var_05;
					break;
			}
		}
	}

	for(;;)
	{
		var_07 = 1;
		if(var_07)
		{
			wait(randomfloatrange(10,30));
		}

		while(level.var_AB58 >= level.var_AB5A || func_0F0B(390) || func_0F0D(0))
		{
			wait(5);
		}

		thread func_1764();
		thread func_1766();
		level.var_AB58++;
		self.var_1767 = 1;
		lib_0378::func_8D74("play_bird_loop",self);
		self waittill("birds_command",var_08,var_09);
		level.var_AB58--;
		self.var_1767 = 0;
		var_0A = gettime() * 0.001;
		var_0B = 30;
		if(var_0A - level.var_AB59 < var_0B)
		{
			var_08 = "never_mind";
		}

		switch(var_08)
		{
			case "fly_away":
				level.var_AB59 = var_0A;
				if(isplayer(var_09))
				{
					lib_055B::func_5976(var_09);
				}
		
				thread func_8FAA(var_09);
				thread func_3D7C();
				lib_0378::func_8D74("stop_bird_loop",self);
				lib_0378::func_8D74("play_bird_retreat",self);
				break;
	
			case "never_mind":
				lib_0378::func_8D74("stop_bird_loop",self);
				break;
	
			default:
				break;
		}

		wait(5);
	}
}

//Function Number: 3
func_3D7C()
{
	wait(0.25);
	foreach(var_01 in level.var_744A)
	{
		if(isdefined(var_01) && var_01 istouching(self.var_78CB) && var_01 func_72E5(self.var_AA2A,0))
		{
			var_01 thread func_3D7B();
		}
	}
}

//Function Number: 4
func_3D7B()
{
	self endon("death");
	self endon("disconnect");
}

//Function Number: 5
func_8FAA(param_00)
{
	for(var_01 = 0;var_01 < 20;var_01++)
	{
		var_02 = common_scripts\utility::func_7A33(self.var_175F);
		thread func_1763(var_02,param_00);
	}

	wait(0.1);
	physicsexplosionsphere(self.var_AA2A,48,16,1,0);
	glassradiusdamage(self.var_AA2A,48,100,50);
	earthquake(0.5,1.5,self.var_78CB.var_116,self.var_78CB.var_14F * 2);
	function_01BB("zombie_birds_rumble",self.var_78CB.var_116);
}

//Function Number: 6
func_1763(param_00,param_01)
{
	var_02 = 2;
	var_03 = 40;
	var_04 = 10;
	wait(randomfloatrange(0,var_02));
	var_05 = undefined;
	if(isplayer(param_01))
	{
		if(distance(param_01.var_116,self.var_116) > 96)
		{
			var_05 = common_scripts\utility::func_4461(self.var_116,maps/mp/agents/_agent_utility::func_43FD("all"));
		}
		else
		{
			var_05 = param_01;
		}
	}

	if(isdefined(param_01))
	{
		var_06 = param_01.var_116 - self.var_116;
		var_07 = vectortoangles(var_06)[1];
		var_08 = var_07 - self.var_1D[1];
		var_08 = var_08 + randomfloatrange(0 - var_04,var_04);
		if(isendstr(param_00.var_8260,"_v1") || isendstr(param_00.var_8260,"_v3"))
		{
			var_09 = 0 - var_03;
			var_0A = 0;
		}
		else
		{
			var_09 = 0;
			var_0A = var_04;
		}

		var_08 = clamp(var_08,var_09,var_0A);
		var_0B = transformmove(self.var_116,self.var_1D + (0,var_08,0),self.var_116,self.var_1D,param_00.var_116,param_00.var_1D);
		var_0C = var_0B["origin"];
		var_0D = var_0B["angles"];
	}
	else
	{
		var_0C = var_02.var_116;
		var_0D = param_01.var_1D;
	}

	var_0E = spawn("script_model",var_0C);
	var_0E.var_1D = var_0D;
	var_0E setmodel("ani_raven_rig");
	var_0E method_8278(param_00.var_8260,"bird_anim");
	var_0E thread func_1760();
	var_0E waittillmatch("end","bird_anim");
	var_0E delete();
}

//Function Number: 7
func_1760()
{
	var_00 = 32;
	var_01 = 3;
	var_02 = 50;
	var_03 = 50;
	self endon("death");
	for(;;)
	{
		var_04 = 0;
		var_05 = 9999;
		foreach(var_07 in level.var_744A)
		{
			if(distance(var_07.var_116,self.var_116) < var_00 + 128)
			{
				var_04 = 1;
				if(var_07.var_BC < var_05)
				{
					var_05 = var_07.var_BC;
				}
			}
		}

		if(var_04 && var_05 - var_01 < var_03)
		{
			wait 0.05;
			continue;
		}

		if(var_04)
		{
			var_09 = var_01;
		}
		else
		{
			var_09 = var_02;
		}

		radiusdamage(self.var_116,var_00,var_09,var_09 * 0.5,undefined,undefined,undefined,undefined,0);
		break;
	}
}

//Function Number: 8
func_0F0B(param_00)
{
	if(!isdefined(level.var_744A))
	{
		return 0;
	}

	foreach(var_02 in level.var_744A)
	{
		if(distance(var_02.var_116,self.var_116) < param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_0F0D(param_00)
{
	if(param_00 == 0)
	{
		return 0;
	}

	foreach(var_02 in maps/mp/agents/_agent_utility::func_43FD("all"))
	{
		if(distance(var_02.var_116,self.var_116) < param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
func_1765(param_00)
{
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(randomfloat(1) < 0.9)
		{
			param_00 notify("birds_command","fly_away",var_01);
			continue;
		}

		param_00 notify("never_mind");
	}
}

//Function Number: 11
func_1768(param_00)
{
	var_01 = cos(32.5);
	param_00 lib_055B::func_84F0("birds");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		if(!param_00.var_1767)
		{
			continue;
		}

		var_03 = var_02 func_72E5(param_00.var_AA2A,var_01) && param_00 lib_055B::func_5977(var_02);
		if(var_03)
		{
			param_00 notify("birds_command","fly_away",var_02);
			continue;
		}

		param_00 notify("never_mind");
		while(isalive(var_02) && var_02 istouching(self))
		{
			wait(1);
		}

		wait(10);
	}
}

//Function Number: 12
func_1764()
{
	self endon("birds_command");
	for(;;)
	{
		wait(5);
		if(func_0F0D(0))
		{
			self notify("birds_command","never_mind");
		}
	}
}

//Function Number: 13
func_1766()
{
	self endon("birds_command");
	wait(randomfloatrange(15,45));
	self notify("birds_command","never_mind");
}

//Function Number: 14
func_72E5(param_00,param_01)
{
	return vectordot(vectornormalize(param_00 - self geteye()),anglestoforward(self getangles())) > param_01;
}