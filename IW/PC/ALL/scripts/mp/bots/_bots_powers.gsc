/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_powers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 580 ms
 * Timestamp: 10/27/2023 12:27:42 AM
*******************************************************************/

//Function Number: 1
func_2E53()
{
	level.var_2D1C = [];
	level.var_2D1C["power_domeshield"] = ::lib_0D77::func_8995;
	level.var_2D1C["power_overCharge"] = ::func_5234;
	level.var_2D1C["power_adrenaline"] = ::func_5234;
	level.var_2D1C["power_deployableCover"] = ::func_8991;
	level.var_2D1C["power_rewind"] = ::lib_0D78::func_89DC;
	level.var_2D1C["power_adrenaline"] = ::func_5234;
	level.var_2D1C["power_multiVisor"] = ::func_5234;
	level.var_2D1C["power_blinkKnife"] = ::func_897E;
}

//Function Number: 2
func_2D5A()
{
	self notify("bot_detect_friendly_domeshields");
	self endon("bot_detect_friendly_domeshields");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_00 = 0;
	self botsetflag("disable_attack",0);
	for(;;)
	{
		if(var_00)
		{
			wait(0.05);
		}
		else
		{
			wait(0.5);
		}

		if(var_00)
		{
			self botsetflag("disable_attack",0);
			var_00 = 0;
		}

		if(isdefined(self.var_10C))
		{
			var_01 = self geteye();
			var_02 = self.var_10C geteye();
			var_03 = bullettrace(var_01,var_02,0,self);
			var_04 = var_03["entity"];
			if(!isdefined(var_04) || !isdefined(var_04.var_2B0E))
			{
				continue;
			}

			if(!isdefined(var_04.var_222))
			{
				continue;
			}

			if(var_04.var_222.team == self.team)
			{
				self botsetflag("disable_attack",1);
				var_00 = 1;
				continue;
			}
		}
	}
}

//Function Number: 3
func_2EB4()
{
	self notify("bot_think_powers");
	self endon("bot_think_powers");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	thread func_2D5A();
	if(isdefined(self.var_D782) && self.var_D782.size > 0)
	{
		if(isdefined(self.var_AE7B) && isdefined(self.var_D782[self.var_AE7B]))
		{
			if(isdefined(level.var_2D1C[self.var_AE7B]))
			{
				self thread [[ level.var_2D1C[self.var_AE7B] ]](self.var_AE7B,"primary");
			}
		}

		if(isdefined(self.var_AE7D) && isdefined(self.var_D782[self.var_AE7D]))
		{
			if(isdefined(level.var_2D1C[self.var_AE7D]))
			{
				self thread [[ level.var_2D1C[self.var_AE7D] ]](self.var_AE7D,"secondary");
			}
		}
	}

	for(;;)
	{
		self waittill("power_available",var_00,var_01);
		if(isdefined(level.var_2D1C[var_00]))
		{
			self thread [[ level.var_2D1C[var_00] ]](var_00,var_01);
		}
	}
}

//Function Number: 4
func_1384F(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	for(;;)
	{
		self waittill("power_activated",var_02,var_03);
		if(var_02 == param_00 && var_03 == param_01)
		{
			break;
		}
	}
}

//Function Number: 5
func_5234(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	for(;;)
	{
		while(!isdefined(self.var_10C) || !isalive(self.var_10C))
		{
			wait(0.1);
		}

		if(!self botcanseeentity(self.var_10C))
		{
			wait(0.1);
			continue;
		}

		var_02 = 0;
		var_03 = 1400;
		var_04 = distance(self.origin,self.var_10C.origin);
		if(self method_8520())
		{
			var_02 = 700;
		}

		if(var_02 != 0)
		{
			if(var_04 < var_02)
			{
				wait(0.5);
				continue;
			}
		}

		if(var_04 > var_03)
		{
			wait(0.5);
			continue;
		}

		break;
	}

	var_05 = param_01 + "_power_ready";
	self botsetflag(var_05,1);
	func_1384F(param_00,param_01);
	self botsetflag(var_05,0);
}

//Function Number: 6
func_897E(param_00,param_01)
{
	var_02 = self botgetdifficultysetting("throwKnifeChance");
	self method_804D("throwKnifeChance",0.25);
}

//Function Number: 7
func_8BEE()
{
	if(!isalive(self) || !isdefined(self.var_10C))
	{
		return 0;
	}

	if(self botcanseeentity(self.var_10C) && self method_8520())
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_130C0(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	var_02 = param_01 + "_power_ready";
	self botsetflag(var_02,1);
	func_1384F(param_00,param_01);
	self botsetflag(var_02,0);
}

//Function Number: 9
func_9D7E()
{
	if(isdefined(self.var_11A46))
	{
		foreach(var_01 in self.var_11A46)
		{
			if(!isdefined(var_01.var_130AC) || !isdefined(var_01.var_130AC.var_92B8))
			{
				continue;
			}

			if(var_01.var_130AC.var_92B8 == "domFlag")
			{
				if(scripts\mp\bots\gametype_dom::func_2DD6(var_01))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 10
func_130C1(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("domeshield_used");
	self endon("powers_cleanUp");
	if(!isdefined(param_03))
	{
		param_03 = ::func_130C0;
	}

	for(;;)
	{
		wait(0.05);
		while(!func_8BEE() && !func_9D7E())
		{
			wait(0.25);
		}

		if(!func_9D7E())
		{
			for(var_04 = self method_8118();var_04 > 0;var_04 = self method_8118())
			{
				wait(0.05);
				if(!func_8BEE())
				{
					break;
				}
			}
		}

		if(func_8BEE() || func_9D7E())
		{
			if(isdefined(self.var_10C))
			{
				var_05 = distance(self.origin,self.var_10C.origin);
				if(var_05 < param_02)
				{
					wait(0.25);
					continue;
				}
			}

			self thread [[ param_03 ]](param_00,param_01);
			break;
		}
	}
}

//Function Number: 11
func_130C2(param_00,param_01,param_02,param_03,param_04)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("domeshield_used");
	self endon("powers_cleanUp");
	if(!isdefined(param_04))
	{
		param_04 = ::func_130C0;
	}

	for(;;)
	{
		self waittill("damage");
		if(isdefined(self.var_10C))
		{
			var_05 = distancesquared(self.origin,self.var_10C.origin);
			if(var_05 < param_02 * param_02)
			{
				continue;
			}
		}

		if(self.health < param_03)
		{
			self thread [[ param_04 ]](param_00,param_01);
			break;
		}
	}
}

//Function Number: 12
func_8991(param_00,param_01)
{
	thread func_130C1(param_00,param_01,400,::func_130C0);
	thread func_130C2(param_00,param_01,450,80,::func_130C0);
}