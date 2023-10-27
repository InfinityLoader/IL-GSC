/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_mg_penetration.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 16
 * Decompile Time: 192 ms
 * Timestamp: 10/27/2023 1:37:17 AM
*******************************************************************/

//Function Number: 1
func_3E14(param_00)
{
	self endon("death");
	self notify("end_mg_behavior");
	self endon("end_mg_behavior");
	self.var_1983 = 1;
	self.wants_to_fire = 0;
	if(!maps\_mgturret::func_879D(param_00))
	{
		self notify("continue_cover_script");
		return;
	}

	self.var_4BFE = undefined;
	thread func_640B();
	var_01 = anglestoforward(param_00.angles);
	var_02 = spawn("script_origin",(0,0,0));
	thread target_ent_cleanup(var_02);
	var_02.origin = param_00.origin + var_01 * 500;
	if(isdefined(self.var_4BFE))
	{
		var_02.origin = self.var_4BFE;
	}

	param_00 settargetentity(var_02);
	var_03 = undefined;
	for(;;)
	{
		if(!isalive(self.current_enemy))
		{
			func_7C27();
			self waittill("new_enemy");
		}

		func_7A39();
		func_7422(var_02);
		if(!isalive(self.current_enemy))
		{
			continue;
		}

		if(self method_81F2(self.current_enemy))
		{
			continue;
		}

		self waittill("saw_enemy");
	}
}

//Function Number: 2
target_ent_cleanup(param_00)
{
	common_scripts\utility::func_8B4F("death","end_mg_behavior");
	param_00 delete();
}

//Function Number: 3
func_7422(param_00)
{
	self endon("death");
	self endon("new_enemy");
	self.current_enemy endon("death");
	var_01 = self.current_enemy;
	while(self method_81F2(var_01))
	{
		var_02 = vectortoangles(var_01 geteye() - param_00.origin);
		var_02 = anglestoforward(var_02);
		param_00 moveto(param_00.origin + var_02 * 12,0.1);
		wait(0.1);
	}

	if(isplayer(var_01))
	{
		self endon("saw_enemy");
		var_03 = var_01 geteye();
		var_02 = vectortoangles(var_03 - param_00.origin);
		var_02 = anglestoforward(var_02);
		var_04 = 150;
		var_05 = distance(param_00.origin,self.var_4BFE) / var_04;
		if(var_05 > 0)
		{
			param_00 moveto(self.var_4BFE,var_05);
			wait(var_05);
		}

		var_06 = param_00.origin + var_02 * 180;
		var_07 = get_suppress_point(self geteye(),param_00.origin,var_06);
		if(!isdefined(var_07))
		{
			var_07 = param_00.origin;
		}

		param_00 moveto(param_00.origin + var_02 * 80 + (0,0,randomfloatrange(15,50) * -1),3,1,1);
		wait(3.5);
		param_00 moveto(var_07 + var_02 * -20,3,1,1);
	}

	wait(randomfloatrange(2.5,4));
	func_7C27();
}

//Function Number: 4
set_firing(param_00)
{
	if(param_00)
	{
		self.var_1983 = 1;
		if(self.wants_to_fire)
		{
			self.turret notify("startfiring");
		}
	}

	self.var_1983 = 0;
	self.turret notify("stopfiring");
}

//Function Number: 5
func_7C27()
{
	self.wants_to_fire = 0;
	self.turret notify("stopfiring");
}

//Function Number: 6
func_7A39()
{
	self.wants_to_fire = 1;
	if(self.var_1983)
	{
		self.turret notify("startfiring");
	}
}

//Function Number: 7
func_209B()
{
	if(isdefined(level.mg_gunner_team))
	{
		level.mg_gunner_team[level.mg_gunner_team.size] = self;
	}

	level.mg_gunner_team = [];
	level.mg_gunner_team[level.mg_gunner_team.size] = self;
	waittillframeend;
	var_00 = addstruct();
	common_scripts\utility::func_F1B(level.mg_gunner_team,::func_5202,var_00);
	var_01 = level.mg_gunner_team;
	level.mg_gunner_team = undefined;
	var_00 waittill("gunner_died");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02]))
		{
			continue;
		}

		var_01[var_02] notify("stop_using_built_in_burst_fire");
		var_01[var_02] thread func_76BC();
	}
}

//Function Number: 8
func_5202(param_00)
{
	self waittill("death");
	param_00 notify("gunner_died");
}

//Function Number: 9
func_520A(param_00)
{
	wait(1);
	level notify("new_mg_firing_team" + param_00[0].script_noteworthy);
	level endon("new_mg_firing_team" + param_00[0].script_noteworthy);
	for(;;)
	{
		dual_firing(param_00);
		func_76BD(param_00);
	}
}

//Function Number: 10
func_76BD(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isalive(param_00[var_02]))
		{
			continue;
		}

		var_01 = param_00[var_02];
		break;
	}

	if(!isdefined(var_01))
	{
	}
}

//Function Number: 11
func_76BC()
{
	self endon("death");
	for(;;)
	{
		self.turret startfiring();
		wait(randomfloatrange(0.3,0.7));
		self.turret stopfiring();
		wait(randomfloatrange(0.1,1.1));
	}
}

//Function Number: 12
dual_firing(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] endon("death");
	}

	var_02 = 0;
	var_03 = 1;
	for(;;)
	{
		if(isalive(param_00[var_02]))
		{
			param_00[var_02] set_firing(1);
		}

		if(isalive(param_00[var_03]))
		{
			param_00[var_03] set_firing(0);
		}

		var_04 = var_02;
		var_02 = var_03;
		var_03 = var_04;
		wait(randomfloatrange(2.3,3.5));
	}
}

//Function Number: 13
spotted_an_enemy(param_00,param_01)
{
	func_7A39();
	self endon("death");
	self endon("new_enemy");
	param_01 endon("death");
	while(self method_81F2(param_01))
	{
		var_02 = vectortoangles(param_01 geteye() - param_00.origin);
		var_02 = anglestoforward(var_02);
		param_00 moveto(param_00.origin + var_02 * 10,0.2);
		wait(0.2);
	}

	var_02 = vectortoangles(param_01 geteye() - param_00.origin);
	var_02 = anglestoforward(var_02);
	var_03 = 150;
	var_04 = distance(param_00.origin,self.var_4BFE) / var_03;
	param_00 moveto(self.var_4BFE,var_04);
	wait(var_04);
	var_05 = param_00.origin;
	param_00 moveto(param_00.origin + var_02 * 80 + (0,0,-25),3,1,1);
	wait(3.5);
	param_00 moveto(var_05 + var_02 * -20,3,1,1);
	wait(1);
	func_7C27();
}

//Function Number: 14
get_suppress_point(param_00,param_01,param_02)
{
	var_03 = distance(param_01,param_02) * 0.05;
	if(var_03 < 5)
	{
		var_03 = 5;
	}

	if(var_03 > 20)
	{
		var_03 = 20;
	}

	var_04 = param_02 - param_01;
	var_04 = (var_04[0] / var_03,var_04[1] / var_03,var_04[2] / var_03);
	var_05 = (0,0,0);
	var_06 = undefined;
	for(var_07 = 0;var_07 < var_03 + 2;var_07++)
	{
		var_08 = bullettrace(param_00,param_01 + var_05,0,undefined);
		if(var_08["fraction"] < 1)
		{
			var_06 = var_08["position"];
			break;
		}

		var_05 = var_05 + var_04;
	}

	return var_06;
}

//Function Number: 15
func_640B()
{
	self endon("death");
	self endon("end_mg_behavior");
	self.current_enemy = undefined;
	for(;;)
	{
		func_640D();
		wait(0.05);
	}
}

//Function Number: 16
func_640D()
{
	if(!isalive(self.enemy))
	{
	}

	if(!self method_81F2(self.enemy))
	{
	}

	self.var_4BFE = self.enemy geteye();
	self notify("saw_enemy");
	if(!isalive(self.current_enemy) || self.current_enemy != self.enemy)
	{
		self.current_enemy = self.enemy;
		self notify("new_enemy");
	}
}