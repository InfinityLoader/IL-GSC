/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_usa_bomber_b17_mp.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 259 ms
 * Timestamp: 10/27/2023 3:20:30 AM
*******************************************************************/

//Function Number: 1
func_51FB()
{
	thread func_14D1();
}

//Function Number: 2
func_14D1()
{
	self.var_29B1 = [];
	self.var_3785 = [];
	self.var_3786 = 0;
	thread func_14D0();
	var_00 = spawnstruct();
	var_00.var_109 = "prop_out_le";
	var_00.var_56C0 = 0;
	self.var_3785[self.var_3785.size] = var_00;
	var_00 = spawnstruct();
	var_00.var_109 = "prop_in_le";
	var_00.var_56C0 = 0;
	self.var_3785[self.var_3785.size] = var_00;
	var_00 = spawnstruct();
	var_00.var_109 = "prop_out_ri";
	var_00.var_56C0 = 0;
	self.var_3785[self.var_3785.size] = var_00;
	var_00 = spawnstruct();
	var_00.var_109 = "prop_in_ri";
	var_00.var_56C0 = 0;
	self.var_3785[self.var_3785.size] = var_00;
	thread func_14C9();
}

//Function Number: 3
func_14C9()
{
	self endon("b17_shot_down");
	thread func_14DA();
	var_00 = common_scripts\utility::func_44F5("b17_dmg_impact");
	var_01 = common_scripts\utility::func_44F5("b17_dmg_impact_notrail");
	var_02 = 0;
	var_03 = 0.2;
	while(!maps/mp/gametypes/_raid_bomber::b17_is_dead())
	{
		self waittill("damage",var_04,var_05,var_06,var_07,var_08);
		if(!isdefined(var_07))
		{
			continue;
		}

		var_09 = 0;
		var_0A = [];
		foreach(var_0C in level.var_744A)
		{
			if(isdefined(var_0C.b17) && isalive(var_0C) && self == var_0C.b17)
			{
				var_0A = common_scripts\utility::func_F6F(var_0A,var_0C);
			}
		}

		if(var_0A.size > 0 && gettime() - var_02 > var_03 * 1000)
		{
			earthquake(0.15,var_03,self.var_116,5000,var_0A);
			var_02 = gettime();
		}

		if(randomint(100) > 50 && !var_09)
		{
			var_0E = 1;
		}
		else
		{
			var_0E = 0;
		}

		if(var_0E && self.var_29B1.size < 4)
		{
			var_0F = lib_0502::raid_spawn_tag_origin();
			var_0F.var_3F2F = var_00;
			var_0F.var_116 = var_07;
			var_0F.var_1D = self gettagangles("body_animate_jnt");
			var_0F linkto(self,"body_animate_jnt");
			self.var_29B1[self.var_29B1.size] = var_0F;
			playfxontag(var_0F.var_3F2F,var_0F,"tag_origin");
		}
		else
		{
			playfx(var_01,var_07,anglestoforward(self.var_1D),anglestoup(self.var_1D));
		}

		if(0 && self.var_BC < self.var_FB * 0.5)
		{
			var_10 = func_14D4(var_07);
			if(isdefined(var_10) && !var_10.var_56C0)
			{
				func_14D6(var_10);
			}
		}
	}

	self notify("b17_shot_down");
}

//Function Number: 4
func_14C4(param_00)
{
	var_01 = anglestoforward(self.var_1D);
	var_02 = anglestoright(self.var_1D);
	var_03 = self gettagorigin("body_animate_jnt");
	if(isdefined(self.var_29B1))
	{
		var_04 = common_scripts\utility::func_44F5("b17_dmg_impact");
		var_05 = 0;
		foreach(var_07 in self.var_29B1)
		{
			var_08 = var_07.var_116 - var_03;
			if(param_00 == "left" || param_00 == "right")
			{
				var_09 = vectordot(var_08,var_02);
				if((param_00 == "left" && var_09 < 0) || param_00 == "right" && var_09 > 0)
				{
					stopfxontag(var_04,var_07,"tag_origin");
					var_05++;
					continue;
				}
			}

			if(param_00 == "tail")
			{
				var_09 = vectordot(var_08,var_01);
				if(var_09 < 0)
				{
					stopfxontag(var_04,var_07,"tag_origin");
					var_05++;
					continue;
				}
			}

			if(param_00 == "all")
			{
				stopfxontag(var_04,var_07,"tag_origin");
				var_05++;
				continue;
			}
		}
	}

	if(0 && isdefined(self.var_3785))
	{
		foreach(var_0C in self.var_3785)
		{
			if(param_00 == "left" || param_00 == "right")
			{
				var_08 = self gettagorigin(var_0C.var_109) - var_03;
				var_09 = vectordot(var_08,var_02);
				if((param_00 == "left" && var_09 < 0) || param_00 == "right" && var_09 > 0)
				{
					func_14D2(var_0C);
					continue;
				}

				if(!var_0C.var_56C0)
				{
					func_14D6(var_0C);
					continue;
				}
			}

			if(param_00 == "all")
			{
				func_14D2(var_0C);
				continue;
			}
		}
	}
}

//Function Number: 5
func_14C7(param_00)
{
	wait(param_00);
	thread func_14C4("right");
}

//Function Number: 6
func_14C6(param_00)
{
	wait(param_00);
	thread func_14C4("left");
}

//Function Number: 7
func_14C8(param_00)
{
	wait(param_00);
	thread func_14C4("tail");
}

//Function Number: 8
func_14C5(param_00)
{
	wait(param_00);
	thread func_14C4("all");
}

//Function Number: 9
func_14D0()
{
	self waittill("b17_remove");
	if(isdefined(self.var_29B1))
	{
		foreach(var_01 in self.var_29B1)
		{
			stopfxontag(var_01.var_3F2F,var_01,"tag_origin");
			var_01 delete();
		}
	}

	if(isdefined(self.var_3785))
	{
		foreach(var_04 in self.var_3785)
		{
			if(isdefined(var_04.var_95A6))
			{
				stopfxontag(var_04.var_95A6.var_3F2F,var_04.var_95A6,"tag_origin");
				var_04.var_95A6 delete();
			}
		}
	}
}

//Function Number: 10
b17_check_health_and_remove_fx()
{
	if(self.var_BC < self.var_FB * 0.5)
	{
		return;
	}

	thread func_14C5(0);
}

//Function Number: 11
func_14D4(param_00)
{
	var_01 = undefined;
	var_02 = 300;
	foreach(var_04 in self.var_3785)
	{
		var_05 = distance(param_00,self gettagorigin(var_04.var_109));
		if(var_05 < var_02)
		{
			if(!isdefined(var_01))
			{
				var_01 = var_04;
			}

			if(var_05 < distance(param_00,self gettagorigin(var_01.var_109)))
			{
				var_01 = var_04;
			}
		}
	}

	return var_01;
}

//Function Number: 12
func_14D6(param_00)
{
	var_01 = lib_0502::raid_spawn_tag_origin();
	var_01.var_116 = self gettagorigin(param_00.var_109);
	var_01.var_1D = self gettagangles("body_animate_jnt");
	var_01.var_3F2F = common_scripts\utility::func_44F5("b17_dmg_engine");
	var_01 linkto(self,"body_animate_jnt");
	param_00.var_95A6 = var_01;
	param_00.var_56C0 = 1;
	self.var_3786++;
	playfxontag(param_00.var_95A6.var_3F2F,param_00.var_95A6,"tag_origin");
	var_02 = var_01 maps\mp\_audio_submixes::func_8004("bulge_b17_fire_lp");
}

//Function Number: 13
func_14D2(param_00)
{
	if(!isdefined(param_00.var_95A6))
	{
		return;
	}

	stopfxontag(param_00.var_95A6.var_3F2F,param_00.var_95A6,"tag_origin");
	param_00.var_56C0 = 0;
	self.var_3786--;
	self method_8614();
}

//Function Number: 14
func_9193()
{
	var_00 = ["blg_b17_lp_1","blg_b17_lp_2"];
	var_01 = "blg_b17_int_lp";
	if(lib_02EF::func_56DB(self) == 0)
	{
		return;
	}

	if(!isdefined(level.var_744A) || level.var_744A.size == 0)
	{
		level waittill("connected",var_02);
		var_02 waittill("spawned_player");
	}

	wait 0.05;
	if(isdefined(self.var_5F03) == 0)
	{
		var_03 = lib_02EF::func_42DD(var_00,"b17_engine_aliases",1);
		self.var_5F04 = "stop_engine_loop_" + self getentitynumber();
		self.var_5F03 = maps\mp\_audio_submixes::func_8004(var_03,self.var_5F04,0,1.5,1,(0,0,200));
		self.var_5F03 = maps\mp\_audio_submixes::func_8004(var_01,self.var_5F04,0,1.5,1,(0,0,200));
	}
}

//Function Number: 15
func_14DA()
{
	if(lib_02EF::func_56DB(self) == 0)
	{
		return;
	}

	self endon("b17_shot_down");
	level endon("dogfight_done");
	self endon("b17_death_sound");
	self endon("death");
	thread func_9193();
}