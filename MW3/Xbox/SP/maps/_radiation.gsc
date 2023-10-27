/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_radiation.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 17
 * Decompile Time: 289 ms
 * Timestamp: 10/27/2023 2:34:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachestring(&"SCOUTSNIPER_MRHR");
	precachestring(&"SCRIPT_RADIATION_DEATH");
	precacheshellshock("radiation_low");
	precacheshellshock("radiation_med");
	precacheshellshock("radiation_high");
	foreach(var_01 in level.players)
	{
		var_01.var_2719 = spawnstruct();
		var_01.var_2719.super_dose = 0;
		var_01.var_2719.inside = 0;
		var_01 maps\_utility::ent_flag_init("_radiation_poisoning");
	}

	common_scripts\utility::run_thread_on_targetname("radiation",::func_3C98);
	common_scripts\utility::run_thread_on_targetname("super_radiation",::func_3C9B);
	common_scripts\utility::array_thread(level.players,::func_3C9C);
	common_scripts\utility::array_thread(level.players,::updateradiationdosimeter);
	common_scripts\utility::array_thread(level.players,::func_3C9F);
	common_scripts\utility::array_thread(level.players,::func_3CA6);
	common_scripts\utility::array_thread(level.players,::func_3CA0);
	common_scripts\utility::array_thread(level.players,::func_3CA1);
	common_scripts\utility::array_thread(level.players,::func_3CA8);
}

//Function Number: 2
func_3C98()
{
	self.members = 0;
	for(;;)
	{
		self waittill("trigger",var_00);
		thread updateradiationtrigger_perplayer(var_00);
	}
}

//Function Number: 3
updateradiationtrigger_perplayer(param_00)
{
	if(param_00.var_2719.inside)
	{
		return;
	}

	param_00.var_2719.inside = 1;
	param_00.var_2719.var_3C9A[param_00.var_2719.var_3C9A.size] = self;
	while(param_00 istouching(self))
	{
		wait 0.05;
	}

	param_00.var_2719.inside = 0;
	param_00.var_2719.var_3C9A = common_scripts\utility::array_remove(param_00.var_2719.var_3C9A,self);
}

//Function Number: 4
func_3C9B()
{
	self waittill("trigger",var_00);
	var_00.var_2719.super_dose = 1;
}

//Function Number: 5
func_3C9C()
{
	self.var_2719.var_3C9A = [];
	self.var_2719.var_19E1 = 0;
	self.var_2719.var_3C9D = 0;
	self.var_2719.var_1D85 = 0;
	self.var_2719.var_3C9E = 0;
	var_00 = 1;
	var_01 = 0;
	var_02 = 1100000 / 60 * var_00;
	var_03 = 200000;
	var_04 = var_02 - var_01;
	for(;;)
	{
		var_05 = [];
		for(var_06 = 0;var_06 < self.var_2719.var_3C9A.size;var_06++)
		{
			var_07 = self.var_2719.var_3C9A[var_06];
			var_08 = distance(self.origin,var_07.origin) - 15;
			var_05[var_06] = var_02 - var_02 / var_07.radius * var_08;
		}

		var_09 = 0;
		for(var_06 = 0;var_06 < var_05.size;var_06++)
		{
			var_09 = var_09 + var_05[var_06];
		}

		if(var_09 < var_01)
		{
			var_09 = var_01;
		}

		if(var_09 > var_02)
		{
			var_09 = var_02;
		}

		self.var_2719.var_19E1 = var_09;
		self.var_2719.var_3C9D = var_09 - var_01 / var_04 * 100;
		if(self.var_2719.super_dose)
		{
			var_09 = var_02;
			self.var_2719.var_3C9D = 100;
		}

		if(self.var_2719.var_3C9D > 25)
		{
			self.var_2719.var_1D85 = self.var_2719.var_1D85 + var_09;
			self.var_2719.var_3C9E = self.var_2719.var_1D85 / var_03 * 100;
		}
		else if(self.var_2719.var_3C9D < 1 && self.var_2719.var_1D85 > 0)
		{
			self.var_2719.var_1D85 = self.var_2719.var_1D85 - 1500;
			if(self.var_2719.var_1D85 < 0)
			{
				self.var_2719.var_1D85 = 0;
			}

			self.var_2719.var_3C9E = self.var_2719.var_1D85 / var_03 * 100;
		}

		wait var_00;
	}
}

//Function Number: 6
func_3C9F()
{
	var_00 = 1;
	for(;;)
	{
		if(self.var_2719.var_3C9D >= 75)
		{
			self shellshock("radiation_high",5);
		}
		else if(self.var_2719.var_3C9D >= 50)
		{
			self shellshock("radiation_med",5);
		}
		else if(self.var_2719.var_3C9D > 25)
		{
			self shellshock("radiation_low",5);
		}

		wait var_00;
	}
}

//Function Number: 7
func_3CA0()
{
	thread func_3CA2();
	for(;;)
	{
		if(self.var_2719.var_3C9D >= 75)
		{
			self.var_2719.sound = "item_geigercouner_level4";
		}
		else if(self.var_2719.var_3C9D >= 50)
		{
			self.var_2719.sound = "item_geigercouner_level3";
		}
		else if(self.var_2719.var_3C9D >= 25)
		{
			self.var_2719.sound = "item_geigercouner_level2";
		}
		else if(self.var_2719.var_3C9D > 0)
		{
			self.var_2719.sound = "item_geigercouner_level1";
		}
		else
		{
			self.var_2719.sound = "none";
		}

		wait 0.05;
	}
}

//Function Number: 8
func_3CA1()
{
	for(;;)
	{
		if(self.var_2719.var_3C9D > 25)
		{
			maps\_utility::func_FA4("_radiation_poisoning");
		}
		else
		{
			maps\_utility::ent_flag_clear("_radiation_poisoning");
		}

		wait 0.05;
	}
}

//Function Number: 9
func_3CA2()
{
	wait 0.05;
	var_00 = spawn("script_origin",(0,0,0));
	var_00.origin = self.origin;
	var_00.angles = self.angles;
	var_00 linkto(self);
	var_01 = self.var_2719.sound;
	for(;;)
	{
		if(var_01 != self.var_2719.sound)
		{
			var_00 stoploopsound();
			if(isdefined(self.var_2719.sound) && self.var_2719.sound != "none")
			{
				var_00 playloopsound(self.var_2719.sound);
			}
		}

		var_01 = self.var_2719.sound;
		wait 0.05;
	}
}

//Function Number: 10
func_3CA3()
{
	var_00 = 0.05;
	var_01 = newclienthudelem(self);
	var_01.fontscale = 1.2;
	var_01.x = 670;
	var_01.y = 350;
	var_01.alignx = "right";
	var_01.label = "";
	var_01.alpha = 0;
	for(;;)
	{
		var_01.label = self.var_2719.var_3C9D;
		wait var_00;
	}
}

//Function Number: 11
updateradiationdosimeter()
{
	var_00 = 0.028;
	var_01 = 100;
	var_02 = 1;
	var_03 = var_01 - var_00;
	var_04 = self.origin;
	var_05 = newclienthudelem(self);
	var_05.fontscale = 1.2;
	var_05.x = 676;
	var_05.y = 360;
	var_05.alpha = 0;
	var_05.alignx = "right";
	var_05.label = &"SCOUTSNIPER_MRHR";
	var_05 thread updateradiationdosimetercolor(self);
	for(;;)
	{
		if(self.var_2719.var_19E1 <= var_00)
		{
			var_06 = randomfloatrange(-0.001,0.001);
			var_05 setvalue(var_00 + var_06);
		}
		else if(self.var_2719.var_19E1 > var_01)
		{
			var_05 setvalue(var_01);
		}
		else
		{
			var_05 setvalue(self.var_2719.var_19E1);
		}

		wait var_02;
	}
}

//Function Number: 12
updateradiationdosimetercolor(param_00)
{
	var_01 = 0.05;
	for(;;)
	{
		var_02 = 1;
		var_03 = 0.13;
		while(param_00.var_2719.var_19E1 >= 100)
		{
			if(var_02 <= 0 || var_02 >= 1)
			{
				var_03 = var_03 * -1;
			}

			var_02 = var_02 + var_03;
			if(var_02 <= 0)
			{
				var_02 = 0;
			}

			if(var_02 >= 1)
			{
				var_02 = 1;
			}

			self.color = (1,var_02,var_02);
			wait var_01;
		}

		self.color = (1,1,1);
		wait var_01;
	}
}

//Function Number: 13
func_3CA6()
{
	level endon("special_op_terminated");
	self endon("death");
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("black",640,480);
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	var_01 = 1;
	var_02 = 4;
	var_03 = 0.25;
	var_04 = 1;
	var_05 = 25;
	var_06 = 100;
	var_07 = 0;
	for(;;)
	{
		while(self.var_2719.var_3C9E > 25 && self.var_2719.var_3C9D > 25)
		{
			var_08 = var_06 - var_05;
			var_07 = self.var_2719.var_3C9E - var_05 / var_08;
			if(var_07 < 0)
			{
				var_07 = 0;
			}
			else if(var_07 > 1)
			{
				var_07 = 1;
			}

			var_09 = var_02 - var_01;
			var_0A = var_01 + var_09 * 1 - var_07;
			var_0B = var_04 - var_03;
			var_0C = var_03 + var_0B * var_07;
			var_0D = 7.2 * var_0C;
			var_0E = var_07 * 0.5;
			var_0F = 7.2 * var_0E;
			if(var_07 == 1)
			{
				break;
			}

			var_10 = var_0A / 2;
			var_00 func_2724(var_10,var_0C,var_0D,self);
			var_00 fadeoutblackout(var_10,var_0E,var_0F,self);
			wait var_07 * 0.5;
		}

		if(var_07 == 1)
		{
			break;
		}

		if(var_00.alpha != 0)
		{
			var_00 fadeoutblackout(1,0,0,self);
		}

		wait 0.05;
	}

	var_00 func_2724(2,1,6,self);
	thread func_3CA7();
}

//Function Number: 14
func_3CA7()
{
	self.var_1A89 = 1;
	self.specialdeath = 1;
	self.radiationdeath = 1;
	if(!maps\_utility::kill_wrapper())
	{
		return;
	}

	waittillframeend;
	var_00 = &"SCRIPT_RADIATION_DEATH";
	setdvar("ui_deadquote",var_00);
}

//Function Number: 15
func_2724(param_00,param_01,param_02,param_03)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_03 setblurforplayer(param_02,param_00);
	wait param_00;
}

//Function Number: 16
fadeoutblackout(param_00,param_01,param_02,param_03)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_03 setblurforplayer(param_02,param_00);
	wait param_00;
}

//Function Number: 17
func_3CA8()
{
	self endon("death");
	for(;;)
	{
		maps\_utility::func_121C("_radiation_poisoning");
		if(level.script == "scoutsniper" || level.script == "co_scoutsniper")
		{
			level thread maps\_utility::func_E1D(::maps\_utility::func_DDF,"scoutsniper_mcm_youdaft");
		}

		level notify("radiation_warning");
		maps\_utility::func_FA3("_radiation_poisoning");
		wait 10;
	}
}