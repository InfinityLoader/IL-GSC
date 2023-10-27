/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_speedboost.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 896 ms
 * Timestamp: 10/27/2023 12:21:39 AM
*******************************************************************/

//Function Number: 1
func_109B8()
{
	level.var_109BE = [];
	level.var_109BE = scripts\common\utility::array_add_safe(level.var_109BE,"specialty_fastreload");
	level.var_109BE = scripts\common\utility::array_add_safe(level.var_109BE,"specialty_quickdraw");
	level.var_109BE = scripts\common\utility::array_add_safe(level.var_109BE,"specialty_quickswap");
}

//Function Number: 2
func_109C1(param_00)
{
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	param_00 waittill("missile_stuck",var_01);
	var_02 = self canplayerplacesentry(1,12);
	var_03 = spawn("script_model",param_00.origin);
	var_03.angles = param_00.angles;
	var_03.team = self.team;
	var_03.var_222 = self;
	var_03 setmodel("prop_mp_speed_strip_temp");
	var_03 thread func_109B4(self);
	var_03 thread func_109C3();
	var_03 thread func_109B5(self);
	var_03 thread func_109BF(self);
	var_03 thread scripts\mp\_weapons::func_66B4();
	var_03 method_831F(self);
	var_03 scripts\mp\_weapons::func_69FF(var_02["entity"],1);
	if(isdefined(param_00))
	{
		param_00 delete();
	}

	var_03 thread func_109B3(self);
	var_03 thread func_109B9(45);
	if(isdefined(var_01))
	{
		var_03 scripts\mp\_weapons::func_69FF(var_01,1);
	}

	if(level.teambased)
	{
		var_03 scripts\mp\_entityheadicons::func_F877(self.team,(0,0,40));
	}
	else
	{
		var_03 scripts\mp\_entityheadicons::func_F7F2(self,(0,0,40));
	}

	scripts\mp\_weapons::func_C5AC(var_03,"power_speedStrip");
}

//Function Number: 3
func_109B4(param_00)
{
	scripts\mp\_damage::func_B9C6(100,"trophy",::func_109B7,::func_109BC,0);
}

//Function Number: 4
func_109B7(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 scripts\mp\killstreaks\_killstreaks::func_83A0();
		param_00 notify("destroyed_equipment");
	}

	self notify("detonateExplosive");
}

//Function Number: 5
func_109BC(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 6
func_109C3()
{
	level endon("game_ended");
	self waittill("detonateExplosive");
	self method_8292();
	self stoploopsound();
	scripts\mp\_weapons::func_66A6();
	self notify("death");
	var_00 = self.origin;
	wait(3);
	if(isdefined(self))
	{
		if(isdefined(self.var_A63A))
		{
			self.var_A63A delete();
		}

		scripts\mp\_weapons::func_66A8();
		scripts\mp\_weapons::func_51B5();
	}
}

//Function Number: 7
func_109B5(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self notify("detonateExplosive");
}

//Function Number: 8
func_109BF(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("spawned_player");
	self notify("detonateExplosive");
}

//Function Number: 9
func_109C2(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self.trigger setcursorhint("HINT_NOICON");
	self.trigger sethintstring(&"MP_PICKUP_SPEED_STRIP");
	self.trigger scripts\mp\_utility::func_F838(param_00);
	self.trigger thread scripts\mp\_utility::notusableforjoiningplayers(param_00);
	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		self stoploopsound();
		self method_8292();
		param_00 setweaponammoclip("speed_strip_mp",1);
		scripts\mp\_weapons::func_51B5();
		self notify("death");
	}
}

//Function Number: 10
func_109B9(param_00)
{
	self endon("death");
	wait(param_00);
	self notify("detonateExplosive");
}

//Function Number: 11
func_109B3(param_00)
{
	var_01 = spawn("trigger_rotatable_radius",self.origin,0,50,100);
	var_01.angles = self.angles;
	var_01 thread func_13B54(param_00,self);
	var_01 thread func_13B4E(self,1);
	var_01 thread func_13B51(self);
	self.var_72FE = ::func_109C0;
	self.var_72F5 = ::func_109B6;
	self.var_109AB = 5;
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03) || !scripts\mp\_utility::func_9F19(var_03))
		{
			continue;
		}

		var_03 thread func_D534(self,self.origin);
	}
}

//Function Number: 12
func_13B54(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(var_02.team != param_00.team)
		{
			continue;
		}

		if(lib_0DDE::func_3CEE(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.var_109B2))
		{
			var_02.var_109B2 = 1;
			foreach(var_04 in level.var_109BE)
			{
				var_02 scripts\mp\_utility::func_8387(var_04);
			}

			if(!isdefined(var_02.var_D782) && var_02 scripts\mp\_powers::func_8C17("power_speedBoost") && var_02.var_D782["power_speedBoost"].var_19)
			{
				var_02.var_109BB = 0.2;
				var_02 scripts\mp\_weapons::func_12ED5();
				var_02 thread func_13B53();
				var_02.var_109BD = param_00;
				scripts\mp\_gamescore::func_11AC9(param_00,var_02,"power_speedBoost");
			}

			if(isplayer(var_02))
			{
				var_02.var_109A9 = function_01E1(scripts\common\utility::getfx("speed_strip_screen"),var_02 geteye(),var_02);
				triggerfx(var_02.var_109A9);
			}

			var_02 notify("speed_strip_start");
			var_02 thread func_13B50(param_01.var_109AB);
			var_02 thread func_13B86(self);
			var_02 thread func_13B4F();
		}
	}
}

//Function Number: 13
func_13B86(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self))
		{
			if(!isdefined(param_00) || !self istouching(param_00))
			{
				self notify("start_speed_strip_linger");
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 14
func_13B50(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("start_speed_strip_linger");
	wait(param_00);
	self notify("speed_strip_end");
}

//Function Number: 15
func_13B4F()
{
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("speed_strip_end","death","disconnect");
	if(isdefined(self))
	{
		func_41E0();
	}
}

//Function Number: 16
func_41E0()
{
	if(isdefined(self.var_109B2))
	{
		self.var_109B2 = undefined;
		self.var_109BA = undefined;
		foreach(var_01 in level.var_109BE)
		{
			scripts\mp\_utility::func_E150(var_01);
		}

		if(isdefined(self.var_109BB))
		{
			self.var_109BB = undefined;
			scripts\mp\_weapons::func_12ED5();
			scripts\mp\_gamescore::func_12D6E(self.var_109BD,self,"power_speedBoost");
			self.var_109BD = undefined;
		}

		if(isdefined(self.var_109A9))
		{
			self.var_109A9 delete();
		}
	}
}

//Function Number: 17
func_13B4E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	if(isdefined(param_05))
	{
		self endon(param_05);
	}

	param_00 waittill("death");
	if(isdefined(param_02))
	{
		if(isdefined(param_03))
		{
			switch(param_03)
			{
				case "player_linger":
					if(isplayer(self) && isdefined(self.var_109B2) && !isdefined(self.var_109BA))
					{
						self notify(param_04);
						self.var_109BA = 1;
					}
					break;
			}
		}
	}
	else if(isdefined(param_04))
	{
		self notify(param_04);
	}

	if(isdefined(param_01))
	{
		if(isdefined(self))
		{
			self delete();
		}
	}
}

//Function Number: 18
func_13B53()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = 0.2;
	var_01 = 0.1;
	while(var_00 >= var_01)
	{
		wait(1.5);
		var_00 = var_00 - 0.05;
		self.var_109BB = var_00;
		scripts\mp\_weapons::func_12ED5();
	}
}

//Function Number: 19
func_13B51(param_00)
{
	self endon("death");
	for(;;)
	{
		if(self.origin != param_00.origin)
		{
			self.origin = param_00.origin;
		}

		wait(0.5);
	}
}

//Function Number: 20
func_D534(param_00,param_01)
{
	param_00 endon("death");
	var_02 = undefined;
	var_03 = param_01;
	var_04 = 1;
	for(;;)
	{
		if(isdefined(param_00) && var_04)
		{
			if(self.team == param_00.team)
			{
				var_02 = function_01E1(scripts\common\utility::getfx("speed_strip_friendly"),var_03,self,anglestoup(param_00.angles),anglestoforward(param_00.angles));
			}
			else
			{
				var_02 = function_01E1(scripts\common\utility::getfx("speed_strip_enemy"),var_03,self,anglestoup(param_00.angles),anglestoforward(param_00.angles));
			}

			if(isdefined(var_02))
			{
				triggerfx(var_02);
				var_02 thread func_13B4E(param_00,1);
				thread func_13B52(param_00,var_03,var_02,"disconnect","spawned_player",1);
				thread func_13B52(param_00,var_03,var_02,undefined,"disconnect",0);
			}

			var_04 = 0;
		}

		wait(0.5);
		if(var_03 != param_00.origin)
		{
			if(isdefined(var_02))
			{
				var_02 delete();
			}

			var_03 = param_00.origin;
			self notify("speed_strip_moved");
			var_04 = 1;
		}
	}
}

//Function Number: 21
func_13B52(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("death");
	self endon("speed_strip_moved");
	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	self waittill(param_04);
	if(isdefined(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_05) && param_05)
	{
		thread func_D534(param_00,param_01);
	}
}

//Function Number: 22
func_109C0()
{
	self.var_109AB = 10;
}

//Function Number: 23
func_109B6()
{
	self.var_109AB = 5;
}