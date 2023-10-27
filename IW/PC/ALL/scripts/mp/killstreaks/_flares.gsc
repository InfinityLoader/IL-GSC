/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_flares.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 974 ms
 * Timestamp: 10/27/2023 12:28:33 AM
*******************************************************************/

//Function Number: 1
func_6EAD(param_00)
{
	self.var_6EB4 = param_00;
	self.var_6EB3 = [];
	thread func_A72B();
}

//Function Number: 2
func_6EAE(param_00)
{
	var_01 = "tag_origin";
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	playsoundatpos(self gettagorigin(var_01),"ks_warden_flares");
	for(var_02 = 0;var_02 < 10;var_02++)
	{
		if(!isdefined(self))
		{
			return;
		}

		playfxontag(level._effect["vehicle_flares"],self,var_01);
		wait(0.15);
	}
}

//Function Number: 3
func_6EA0()
{
	var_00 = spawn("script_origin",self.origin + (0,0,-256));
	var_00.angles = self.angles;
	var_00 movegravity((0,0,-1),5);
	self.var_6EB3[self.var_6EB3.size] = var_00;
	var_00 thread func_6E9F(5,2,self);
	playsoundatpos(var_00.origin,"veh_helo_flares_npc");
	return var_00;
}

//Function Number: 4
func_6E9F(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isdefined(param_02))
	{
		param_00 = param_00 - param_01;
		wait(param_01);
		if(isdefined(param_02))
		{
			param_02.var_6EB3 = scripts\common\utility::func_22A9(param_02.var_6EB3,self);
		}
	}

	wait(param_00);
	self delete();
}

//Function Number: 5
func_6EA9(param_00)
{
	return param_00.var_6EB4;
}

//Function Number: 6
func_6E9D(param_00)
{
	func_6E9E(param_00);
	return param_00.var_6EB4 > 0 || param_00.var_6EB3.size > 0;
}

//Function Number: 7
func_6EA8(param_00)
{
	param_00.var_6EB4--;
	param_00 thread func_6EAE();
	var_01 = param_00 func_6EA0();
	return var_01;
}

//Function Number: 8
func_6E9E(param_00)
{
	param_00.var_6EB3 = scripts\common\utility::func_22BC(param_00.var_6EB3);
}

//Function Number: 9
func_6EA7(param_00)
{
	func_6E9E(param_00);
	var_01 = undefined;
	if(param_00.var_6EB3.size > 0)
	{
		var_01 = param_00.var_6EB3[param_00.var_6EB3.size - 1];
	}

	return var_01;
}

//Function Number: 10
func_A72B()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	while(func_6E9D(self))
	{
		level waittill("laserGuidedMissiles_incoming",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		if(!isarray(var_01))
		{
			var_01 = [var_01];
		}

		foreach(var_04 in var_01)
		{
			if(isvalidmissile(var_04))
			{
				level thread func_A72C(var_04,var_00,var_00.team,var_02);
			}
		}
	}
}

//Function Number: 11
func_A72C(param_00,param_01,param_02,param_03)
{
	param_03 endon("death");
	param_00 endon("death");
	param_00 endon("missile_targetChanged");
	while(func_6E9D(param_03))
	{
		if(!isdefined(param_03) || !isvalidmissile(param_00))
		{
			break;
		}

		var_04 = param_03 method_8159(0,0,0);
		if(distancesquared(param_00.origin,var_04) < 4000000)
		{
			var_05 = func_6EA7(param_03);
			if(!isdefined(var_05))
			{
				var_05 = func_6EA8(param_03);
			}

			param_00 missile_settargetent(var_05);
			param_00 notify("missile_pairedWithFlare");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_6EAA(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("sam_fired",var_01,var_02,var_03);
		if(!isdefined(var_03) || var_03 != self)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			level thread [[ param_00 ]](var_01,var_01.team,var_03,var_02);
			continue;
		}

		level thread func_6EB1(var_01,var_01.team,var_03,var_02);
	}
}

//Function Number: 13
func_6EB1(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_02 endon("death");
	for(;;)
	{
		var_04 = param_02 method_8159(0,0,0);
		var_05 = [];
		for(var_06 = 0;var_06 < param_03.size;var_06++)
		{
			if(isdefined(param_03[var_06]))
			{
				var_05[var_06] = distance(param_03[var_06].origin,var_04);
			}
		}

		var_06 = 0;
		while(var_06 < var_05.size)
		{
			if(isdefined(var_05[var_06]))
			{
				if(var_05[var_06] < 4000 && param_02.var_6EB4 > 0)
				{
					param_02.var_6EB4--;
					param_02 thread func_6EAE();
					var_07 = param_02 func_6EA0();
					for(var_08 = 0;var_08 < param_03.size;var_08++)
					{
						if(isdefined(param_03[var_08]))
						{
							param_03[var_08] missile_settargetent(var_07);
							param_03[var_08] notify("missile_pairedWithFlare");
						}
					}

					return;
				}
			}

			var_08++;
		}

		wait(0.05);
	}
}

//Function Number: 14
func_6EAB(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("stinger_fired",var_02,var_03,var_04);
		if(!isdefined(var_04) || var_04 != self)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			var_03 thread [[ param_00 ]](var_02,var_02.team,var_04,param_01);
			continue;
		}

		var_03 thread func_6EB2(var_02,var_02.team,var_04,param_01);
	}
}

//Function Number: 15
func_6EB2(param_00,param_01,param_02,param_03)
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		var_04 = param_02 method_8159(0,0,0);
		var_05 = distance(self.origin,var_04);
		if(var_05 < 4000 && param_02.var_6EB4 > 0)
		{
			param_02.var_6EB4--;
			param_02 thread func_6EAE(param_03);
			var_06 = param_02 func_6EA0();
			self missile_settargetent(var_06);
			self notify("missile_pairedWithFlare");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 16
func_A730(param_00,param_01,param_02,param_03)
{
	self.var_6EB4 = param_00;
	self.var_6EB3 = [];
	if(isdefined(param_02))
	{
		self.var_222 setclientomnvar(param_02,param_00);
	}

	thread func_A72F(param_01,param_02);
	thread func_A72D(param_03);
}

//Function Number: 17
func_A72F(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	if(!isai(self.var_222))
	{
		self.var_222 notifyonplayercommand("manual_flare_popped",param_00);
	}

	while(func_6EA9(self))
	{
		self.var_222 waittill("manual_flare_popped");
		var_02 = func_6EA8(self);
		if(isdefined(var_02) && isdefined(self.var_222) && !isai(self.var_222))
		{
			self.var_222 playlocalsound("veh_helo_flares_plr");
			if(isdefined(param_01))
			{
				self.var_222 setclientomnvar(param_01,func_6EA9(self));
			}
		}
	}
}

//Function Number: 18
func_A72D(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	while(func_6E9D(self))
	{
		self waittill("targeted_by_incoming_missile",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		self.var_222 playlocalsound("missile_incoming");
		self.var_222 thread func_A731(self,"missile_incoming");
		if(isdefined(param_00))
		{
			var_02 = vectornormalize(var_01[0].origin - self.origin);
			var_03 = vectornormalize(anglestoright(self.angles));
			var_04 = vectordot(var_02,var_03);
			var_05 = 1;
			if(var_04 > 0)
			{
				var_05 = 2;
			}
			else if(var_04 < 0)
			{
				var_05 = 3;
			}

			self.var_222 setclientomnvar(param_00,var_05);
		}

		foreach(var_07 in var_01)
		{
			if(isvalidmissile(var_07))
			{
				thread func_A72E(var_07);
			}
		}
	}
}

//Function Number: 19
func_A72E(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		if(!isdefined(self) || !isvalidmissile(param_00))
		{
			break;
		}

		var_01 = self method_8159(0,0,0);
		if(distancesquared(param_00.origin,var_01) < 4000000)
		{
			var_02 = func_6EA7(self);
			if(isdefined(var_02))
			{
				param_00 missile_settargetent(var_02);
				param_00 notify("missile_pairedWithFlare");
				self.var_222 stoplocalsound("missile_incoming");
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 20
func_A731(param_00,param_01)
{
	self endon("disconnect");
	param_00 waittill("death");
	self stoplocalsound(param_01);
}