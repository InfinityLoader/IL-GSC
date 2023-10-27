/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\_agents.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 473 ms
 * Timestamp: 10/27/2023 12:32:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	func_F8F4();
	level.var_274F = ::badplace_cylinder;
	level.var_2750 = ::badplace_delete;
	scripts\mp\_mp_agent::init_agent("mp/default_agent_definition.csv");
	lib_0F6E::registerscriptedagent();
	level thread scripts\mp\agents\_agent_common::init();
	level thread scripts\mp\killstreaks\_agent_killstreak::init();
}

//Function Number: 2
func_F8F4()
{
	if(!isdefined(level.agent_funcs))
	{
		level.agent_funcs = [];
	}

	level.agent_funcs["player"] = [];
	level.agent_funcs["player"]["spawn"] = ::func_10618;
	level.agent_funcs["player"]["think"] = ::scripts\mp\bots\gametype_war::func_2ECE;
	level.agent_funcs["player"]["on_killed"] = ::func_C4A9;
	level.agent_funcs["player"]["on_damaged"] = ::func_C4A8;
	level.agent_funcs["player"]["on_damaged_finished"] = ::func_18EC;
	lib_0F6E::func_FA99();
	lib_0DF9::func_CAC9();
	scripts\mp\killstreaks\_agent_killstreak::func_F8F4();
	scripts\mp\killstreaks\_rc8::func_F8F4();
}

//Function Number: 3
func_13672()
{
	while(!isdefined(level.agent_funcs))
	{
		wait(0.05);
	}
}

//Function Number: 4
func_16F2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = scripts\mp\agents\_agent_common::func_4535(param_00,param_01,param_02);
	if(isdefined(param_09))
	{
		var_0E.var_4009 = param_09;
	}

	if(isdefined(var_0E))
	{
		var_0E thread [[ var_0E lib_0D65::func_1908("spawn") ]](param_03,param_04,param_05,param_06,param_07,param_08,param_0A,param_0B,param_0C,param_0D);
	}

	return var_0E;
}

//Function Number: 5
func_10618(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("disconnect");
	while(!isdefined(level.var_8136))
	{
		scripts\common\utility::func_136F7();
	}

	if(self.var_8BE2)
	{
		wait(randomintrange(6,10));
	}

	lib_0D65::func_98BB(1);
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_0A = param_00;
		var_0B = param_01;
		self.var_A9F4 = spawnstruct();
		self.var_A9F4.origin = var_0A;
		self.var_A9F4.angles = var_0B;
	}
	else
	{
		var_0C = self [[ level.var_8136 ]]();
		var_0A = var_0C.origin;
		var_0B = var_0C.angles;
		self.var_A9F4 = var_0C;
	}

	lib_0D65::func_1601();
	self.var_A9F6 = gettime();
	self.var_10916 = gettime();
	var_0D = var_0A + (0,0,25);
	var_0E = var_0A;
	var_0F = playerphysicstrace(var_0D,var_0E);
	if(distancesquared(var_0F,var_0D) > 1)
	{
		var_0A = var_0F;
	}

	self method_838E(var_0A,var_0B);
	if(isdefined(param_03) && param_03)
	{
		scripts\mp\bots\_bots_personality::func_2D0C();
	}
	else
	{
		scripts\mp\bots\_bots_util::func_2E83("default");
	}

	if(isdefined(param_05))
	{
		scripts\mp\bots\_bots_util::func_2E81(param_05);
	}

	func_98B6();
	scripts\mp\agents\_agent_common::func_F28C(100);
	if(isdefined(param_04) && param_04)
	{
		self.var_E28C = 1;
	}

	if(isdefined(param_02))
	{
		lib_0D65::func_F290(param_02.team,param_02);
	}

	if(isdefined(self.var_222))
	{
		thread func_5320(self.var_222);
	}

	thread scripts\mp\_flashgrenades::func_B9D9();
	self method_80C8(0);
	self method_83B7();
	self [[ level.onspawnplayer ]]();
	if(!scripts\mp\_utility::func_9FB3(param_06))
	{
		scripts\mp\_class::func_8379(self.team,self.var_4004,1);
	}

	thread scripts\mp\bots\_bots::func_2EBA(1);
	thread scripts\mp\bots\_bots::func_2EAF();
	if(self.agent_type == "player")
	{
		thread scripts\mp\bots\_bots::func_2EB3();
	}
	else if(self.agent_type == "odin_juggernaut")
	{
		thread scripts\mp\bots\_bots::func_2EB3(128);
	}

	thread scripts\mp\bots\_bots_strategy::func_2EB8();
	self thread [[ lib_0D65::func_1908("think") ]]();
	if(!self.var_8BE2)
	{
		scripts\mp\_spawnlogic::func_1855();
	}

	self.var_8BE2 = 0;
	if(!scripts\mp\_utility::func_9FB3(param_07))
	{
		thread scripts\mp\_weapons::func_C57B();
	}

	if(!scripts\mp\_utility::func_9FB3(param_08))
	{
		thread scripts\mp\_healthoverlay::func_D3A5();
	}

	if(!scripts\mp\_utility::func_9FB3(param_09))
	{
		thread scripts\mp\_battlechatter_mp::func_C57B();
	}

	level notify("spawned_agent_player",self);
	level notify("spawned_agent",self);
	self notify("spawned_player");
}

//Function Number: 6
func_5320(param_00)
{
	self endon("death");
	param_00 waittill("killstreak_disowned");
	self notify("owner_disconnect");
	if(scripts\mp\_hostmigration::func_13834())
	{
		wait(0.05);
	}

	self suicide();
}

//Function Number: 7
func_18EC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isalive(self))
	{
		if(isdefined(param_00) || isdefined(param_01))
		{
			if(!isdefined(param_00))
			{
				param_00 = param_01;
			}

			if(isdefined(self.var_1CB0) && !self.var_1CB0)
			{
				if(isdefined(param_00.classname) && param_00.classname == "script_vehicle")
				{
					return 0;
				}
			}

			if(isdefined(param_00.classname) && param_00.classname == "auto_turret")
			{
				param_01 = param_00;
			}

			if(isdefined(param_01) && param_04 != "MOD_FALLING" && param_04 != "MOD_SUICIDE")
			{
				if(level.teambased)
				{
					if(isdefined(param_01.team) && param_01.team != self.team)
					{
						self method_829A(param_01);
					}
				}
				else
				{
					self method_829A(param_01);
				}
			}
		}

		self method_80E9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
		if(!isdefined(self.var_9D25))
		{
			self.var_136FD = 1;
		}

		return 1;
	}
}

//Function Number: 8
func_C4A7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = isdefined(param_01) && isdefined(self.var_222) && self.var_222 == param_01;
	var_0D = scripts\mp\_utility::func_24F0(self.var_222,param_01) || var_0C;
	if(!var_0C && self.agent_type == "playerProxy")
	{
		if(level.teambased && var_0D && !level.var_740A)
		{
			return 0;
		}

		if(!level.teambased && var_0C)
		{
			return 0;
		}
	}

	if(isdefined(param_04) && param_04 == "MOD_CRUSH" && isdefined(param_00) && isdefined(param_00.classname) && param_00.classname == "script_vehicle")
	{
		return 0;
	}

	if(!isdefined(self) || !scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	if(isdefined(param_01) && param_01.classname == "script_origin" && isdefined(param_01.type) && param_01.type == "soft_landing")
	{
		return 0;
	}

	if(param_05 == "killstreak_emp_mp")
	{
		return 0;
	}

	if(param_05 == "bouncingbetty_mp" && !scripts\mp\_weapons::func_B767(param_00,self))
	{
		return 0;
	}

	if(issubstr(param_05,"throwingknife") && param_04 == "MOD_IMPACT")
	{
		param_02 = self.health + 1;
	}

	if(isdefined(param_00) && isdefined(param_00.var_11180) && param_00.var_11180 == self)
	{
		param_02 = self.health + 1;
	}

	if(param_02 <= 0)
	{
		return 0;
	}

	if(isdefined(param_01) && param_01 != self && param_02 > 0 && !isdefined(param_08) || param_08 != "shield")
	{
		if(param_03 & level.var_92CA)
		{
			var_0E = "stun";
		}
		else if(!scripts\mp\_damage::func_100C1(param_06))
		{
			var_0E = "none";
		}
		else
		{
			var_0E = "standard";
		}

		param_01 thread scripts\mp\_damagefeedback::func_12E84(var_0E,param_02 >= self.health);
	}

	if(isdefined(level.var_B93A))
	{
		param_02 = [[ level.var_B93A ]](self,param_01,param_02,param_04,param_05,param_06,param_07,param_08);
	}

	return self [[ lib_0D65::func_1908("on_damaged_finished") ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 9
func_C4A8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = isdefined(param_01) && isdefined(self.var_222) && self.var_222 == param_01;
	if(!level.teambased && var_0C)
	{
		return 0;
	}

	if(isdefined(level.var_13CA6))
	{
		param_05 = [[ level.var_13CA6 ]](param_05,param_00);
	}

	scripts\mp\_damage::func_374D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 10
func_C4A9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,1);
	if(isplayer(param_01) && !isdefined(self.var_222) || param_01 != self.var_222)
	{
		scripts\mp\_damage::func_C548("squad_mate",param_01,param_04,param_03,param_02,"destroyed_squad_mate");
	}

	scripts\mp\_weapons::func_5D52(param_01);
	if(self.var_9D25)
	{
		self.var_8BE2 = 1;
		if(scripts\mp\_utility::func_7ECE() != 1 && isdefined(self.var_E28C) && self.var_E28C)
		{
			self thread [[ lib_0D65::func_1908("spawn") ]]();
			return;
		}

		lib_0D65::func_4DDB();
	}
}

//Function Number: 11
func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.var_8C1F) && self.var_8C1F)
	{
		scripts\mp\_damage::func_AAB5(param_02,param_03);
		if(!param_09)
		{
			var_0A = self method_80B8(self getcurrentweapon());
			if(isdefined(var_0A))
			{
				var_0A thread scripts\mp\_weapons::func_51CC();
				var_0A.var_222 = self;
				var_0A.var_C83A = param_01;
				var_0A makeunusable();
			}
		}
	}

	if(param_09)
	{
		self [[ level.var_13C82 ]](param_01,param_03);
	}

	scripts\mp\_utility::func_E54E();
	if(isdefined(self.nocorpse))
	{
		return;
	}

	self.var_2C09 = self method_8084(param_08);
	thread scripts\mp\_damage::func_5124(self.var_2C09,param_06,param_05,param_04,param_00,param_03);
}

//Function Number: 12
func_98B6()
{
	if(isdefined(self.var_4007))
	{
		self.var_4004 = self.var_4007;
		return;
	}

	if(scripts\mp\bots\_bots_loadout::func_2E89())
	{
		self.var_4004 = "callback";
		return;
	}

	self.var_4004 = "class1";
}