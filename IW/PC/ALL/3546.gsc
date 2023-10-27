/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3546.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:30:38 AM
*******************************************************************/

//Function Number: 1
func_2B29()
{
	scripts\mp\_powerloot::func_DF06("power_blackhat",["passive_increased_radius"]);
}

//Function Number: 2
func_E0D4()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self playlocalsound("mp_overcharge_off");
}

//Function Number: 3
func_13073()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeBlackhat");
	level endon("game_ended");
	self playlocalsound("mp_overcharge_on");
	thread func_2B2D();
}

//Function Number: 4
func_2B2D()
{
	self endon("death");
	self endon("disconnect");
	self endon("blackhat_used");
	self iprintlnbold("Blackhat");
	var_00 = scripts\mp\_powers::func_D735("power_blackhat");
	var_01 = 0;
	self playgestureviewmodel("ges_hack_lock_in",undefined,var_01,0.5);
	for(;;)
	{
		if(!scripts\mp\_powers::func_9F09(var_00))
		{
			break;
		}

		if(scripts\mp\_powers::func_9F09(var_00))
		{
			thread func_2B2B(var_00);
			while(scripts\mp\_powers::func_9F09(var_00))
			{
				wait(0.05);
				if(!scripts\mp\_powers::func_9F09(var_00))
				{
					break;
				}
			}
		}

		wait(0.05);
	}

	self stopgestureviewmodel("ges_hack_lock_in");
}

//Function Number: 5
func_2B2E()
{
	self notify("powers_blackhat_used",1);
	self notify("blackhat_used");
	self stopgestureviewmodel("ges_hack_lock_in");
}

//Function Number: 6
func_2B2B(param_00)
{
	self notify("using_blackhat");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("blackhat_used");
	self endon("using_blackhat");
	var_01 = [];
	var_02 = [];
	var_03 = scripts\mp\_powerloot::func_7FC4("power_blackhat",20);
	for(;;)
	{
		if(scripts\mp\_powers::func_9F09(param_00))
		{
			var_04 = [];
			var_01 = func_7E94(self);
			foreach(var_06 in var_01)
			{
				var_07 = self method_8409(var_06.origin,65,var_03);
				if(var_07)
				{
					var_04[var_04.size] = var_06;
				}
			}

			if(var_04.size)
			{
				var_02 = sortbydistance(var_04,self.origin);
				self.var_AA25 = var_02[0];
				scripts\mp\_hostmigration::func_13708(0.25);
				if(isdefined(self.var_AA25) && isdefined(self.var_AA26) && self.var_AA26)
				{
					func_11375(self.var_AA25);
					self notify("blackhat_fired");
					func_2B2E();
				}
				else if(isdefined(self.var_AA25))
				{
					self.var_AA25 dodamage(1000,self.var_AA25.origin,self,self,"MOD_IMPACT","power_blackhat_mp");
					self notify("blackhat_fired");
					func_2B2E();
					scripts\mp\killstreaks\_killstreaks::func_839F();
				}
			}

			self.var_AA26 = 0;
			wait(0.1);
			scripts\mp\_hostmigration::func_13834();
			continue;
		}

		self notify("powers_blackhat_used",0);
		break;
	}
}

//Function Number: 7
func_11375(param_00)
{
}

//Function Number: 8
func_11319(param_00)
{
	var_01 = level.var_13C7D["sticky_mine_mp"];
	param_00 scripts\mp\_weapons::func_11061();
	param_00 thread scripts\mp\_weapons::func_57EB("tag_fx",var_01.var_B760["friendly"],var_01.var_B760["enemy"]);
}

//Function Number: 9
func_2B2A()
{
	var_00 = self getentitynumber();
	level.var_B779[var_00] = self;
	level notify("mine_planted");
}

//Function Number: 10
func_2B2C()
{
	var_00 = undefined;
	if(isdefined(self))
	{
		var_00 = self getentitynumber();
	}

	if(isdefined(var_00))
	{
		level.var_B779[var_00] = undefined;
	}
}

//Function Number: 11
func_E12A()
{
	if(!isdefined(self.var_6644))
	{
		return;
	}

	self.var_6644 destroy();
}

//Function Number: 12
func_7E94(param_00)
{
	var_01 = func_2B28();
	if(var_01.size)
	{
		var_02 = var_01;
		return var_02;
	}

	return var_02;
}

//Function Number: 13
func_2B28(param_00)
{
	var_01 = [];
	var_02 = scripts\mp\_utility::getotherteam(self.team);
	if(level.teambased)
	{
		if(isdefined(level.var_B779))
		{
			foreach(var_04 in level.var_B779)
			{
				if(isdefined(var_04) && var_04.team != self.team || isdefined(var_04.var_222) && var_04.var_222 != self)
				{
					self.var_AA26 = 1;
					var_01[var_01.size] = var_04;
				}
			}
		}

		if(isdefined(level.var_12A83))
		{
			foreach(var_07 in level.var_12A83)
			{
				if(isdefined(var_07) && var_07.team != self.team || isdefined(var_07.var_222) && var_07.var_222 != self)
				{
					var_01[var_01.size] = var_07;
				}
			}
		}

		if(isdefined(level.var_12AF3))
		{
			foreach(var_0A in level.var_12AF3[var_02])
			{
				if(isdefined(var_0A) && var_0A.team != self.team || isdefined(var_0A.var_222) && var_0A.var_222 != self)
				{
					var_01[var_01.size] = var_0A;
				}
			}
		}

		if(isdefined(level.var_3F14) && level.var_3F14.team != self.team || isdefined(level.var_3F14.var_222) && level.var_3F14.var_222 != self)
		{
			var_01[var_01.size] = level.var_3F14;
		}

		if(isdefined(level.var_AD8B))
		{
			foreach(var_0D in level.var_AD8B)
			{
				if(isdefined(var_0D) && var_0D.team != self.team || isdefined(var_0D.var_222) && var_0D.var_222 != self)
				{
					var_01[var_01.size] = var_0D;
				}
			}
		}

		if(isdefined(level.var_27EF))
		{
			foreach(var_10 in level.var_27EF)
			{
				if(isdefined(var_10) && var_10.team != self.team || isdefined(var_10.var_222) && var_10.var_222 != self)
				{
					var_01[var_01.size] = var_10;
				}
			}
		}

		if(isdefined(level.var_8B5F))
		{
			foreach(var_13 in level.var_8B5F)
			{
				if(isdefined(var_13) && var_13.team != self.team || isdefined(var_13.var_222) && var_13.var_222 != self)
				{
					var_01[var_01.size] = var_13;
				}
			}
		}

		if(isdefined(param_00) && param_00 == 1)
		{
			foreach(var_16 in level.var_3CB5)
			{
				if(isdefined(var_16) && isalive(var_16) && var_16.team != self.team || isdefined(var_16.var_222) && var_16.var_222 != self)
				{
					var_01[var_01.size] = var_16;
				}
			}
		}
	}
	else
	{
		if(isdefined(level.var_12A83))
		{
			foreach(var_07 in level.var_12A83)
			{
				if(!isdefined(var_07))
				{
					continue;
				}

				var_01[var_01.size] = var_07;
			}
		}

		if(isdefined(level.var_12AF3))
		{
			foreach(var_0A in level.var_12AF3)
			{
				if(!isdefined(var_0A))
				{
					continue;
				}

				var_01[var_01.size] = var_0A;
			}
		}

		if(isdefined(level.var_3F14))
		{
			var_01[var_01.size] = level.var_3F14;
		}

		if(isdefined(level.var_AD8B))
		{
			foreach(var_0D in level.var_AD8B)
			{
				if(!isdefined(var_0D))
				{
					continue;
				}

				var_01[var_01.size] = var_0D;
			}
		}

		if(isdefined(level.var_27EF))
		{
			foreach(var_10 in level.var_27EF)
			{
				if(!isdefined(var_10))
				{
					continue;
				}

				var_01[var_01.size] = var_10;
			}
		}

		if(isdefined(level.var_8B5F))
		{
			foreach(var_13 in level.var_8B5F)
			{
				if(!isdefined(var_13))
				{
					continue;
				}

				var_01[var_01.size] = var_13;
			}
		}

		if(isdefined(param_00) && param_00 == 1)
		{
			foreach(var_16 in level.var_3CB5)
			{
				if(!isdefined(var_16) || !isalive(var_16))
				{
					continue;
				}

				var_01[var_01.size] = var_16;
			}
		}
	}

	return var_01;
}