/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1410.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:26:05 AM
*******************************************************************/

//Function Number: 1
func_2A99()
{
	common_scripts\utility::func_92C("death_sticky","vfx/zombie/abilities_perks/zmb_death_zmb_turn");
	common_scripts\utility::func_92C("tesla_death_explosion","vfx/explosion/zmb_tesla_death_suicide_explosion");
	common_scripts\utility::func_92C("death_stun","vfx/sparks/tesla_death_stun_sparks");
	common_scripts\utility::func_92C("head_sparks","vfx/unique/no_fx");
	common_scripts\utility::func_92C("tesla_death_ambience","vfx/zombie/tesla_guns/zmb_npc_tesla_tube_death_idle");
	lib_054D::func_7BC6(::func_29A5);
}

//Function Number: 2
func_29A5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = self;
	if(!lib_0547::func_5565(param_05,"teslagun_zm_death"))
	{
		return;
	}

	if(lib_0547::func_5565(param_04,"MOD_MELEE"))
	{
		return;
	}

	if(param_02 == lib_0580::func_4382())
	{
		return;
	}

	lib_0580::func_98FD(param_00,param_01,var_0B,"j_head",param_04,param_05,::func_7788,"death_stun");
}

//Function Number: 3
func_55EF(param_00,param_01)
{
	var_02 = self;
	if(common_scripts\utility::func_562E(var_02.var_5560))
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(param_01.var_4B2A))
	{
		return 0;
	}

	if(isdefined(var_02.var_A4B))
	{
		switch(var_02.var_A4B)
		{
			case "zombie_berserker":
			case "zombie_generic":
				break;

			default:
				return 0;
		}
	}

	if(isdefined(level.var_94DA))
	{
		var_03 = distance(var_02.var_116,level.var_94DA) < func_418A();
		var_04 = lib_0580::func_4385() - level.var_94DB < 0.5;
		if(var_03 && var_04)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 4
func_7788(param_00,param_01)
{
	var_02 = self;
	if(common_scripts\utility::func_562E(var_02.var_5560))
	{
		return;
	}

	if(var_02 func_55EF(param_00,param_01))
	{
		param_01.var_4B2A = 1;
		var_02.var_5560 = 1;
		var_03 = lib_0580::func_8317(param_00,param_01.var_721C,::func_5995,func_4324());
		var_02 thread lib_0547::func_7D1A("tesla_shock",[var_03],4);
		level.var_94DA = var_02.var_116;
		level.var_94DB = lib_0580::func_4385();
		var_04 = maps/mp/gametypes/zombies::func_1E59() * 1;
		lib_0580::func_98E9(var_02.var_116,func_41DC(),param_01.var_721C,var_02,param_01.var_953E,(0.6666667,0.4235294,0.2235294),var_04);
		return;
	}

	var_02 thread lib_0580::func_98EE(param_00,param_01.var_721C,param_01.var_8CD7,param_01.var_953E,1,"head_sparks");
}

//Function Number: 5
init_agent(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 method_8398(param_00);
	var_01.var_2A97 = param_00;
	param_00.var_5561 = 1;
	self.var_2A97 waittill("death");
	self.var_2A97 = undefined;
}

//Function Number: 6
func_5994(param_00)
{
	var_01 = self;
	var_01 waittill("death");
	playfx(common_scripts\utility::func_44F5("tesla_death_explosion"),var_01.var_116);
	var_01 lib_0378::func_8D74("aud_ww_death_explode");
	var_02 = maps/mp/gametypes/zombies::func_1E59() * 3;
	lib_0580::func_98E9(var_01.var_116,func_418A(),param_00.var_721C,undefined,"teslagun_zm_death",(0.6666667,0.4235294,0.2235294),var_02);
}

//Function Number: 7
func_5993()
{
	return "sprint";
}

//Function Number: 8
func_5995(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 thread func_5994(param_00);
	playfxontag(common_scripts\utility::func_44F5("death_sticky"),var_01,"j_neck");
	var_02 = 0;
	while(!var_02)
	{
		var_03 = [];
		var_04 = [];
		var_05 = [];
		foreach(var_07 in lib_0547::func_408F())
		{
			if(var_07 == var_01)
			{
				continue;
			}

			if(common_scripts\utility::func_562E(var_07.var_5560))
			{
				var_03 = common_scripts\utility::func_F6F(var_03,var_07);
				continue;
			}

			if(common_scripts\utility::func_562E(var_07.var_5560))
			{
				var_04 = common_scripts\utility::func_F6F(var_04,var_07);
				continue;
			}

			var_05 = common_scripts\utility::func_F6F(var_05,var_07);
		}

		var_07 = common_scripts\utility::func_4461(var_01.var_116,var_05);
		if(!isdefined(var_07))
		{
			var_07 = common_scripts\utility::func_4461(var_01.var_116,var_04);
		}

		if(!isdefined(var_07))
		{
			var_07 = common_scripts\utility::func_4461(var_01.var_116,var_03);
		}

		if(!isdefined(var_07))
		{
			var_02 = 1;
			break;
		}

		var_01.var_CA = 1;
		var_01 thread init_agent(var_07);
		if(isdefined(var_01.var_A4B) && common_scripts\utility::func_F79(["zombie_exploder","zombie_generic","zombie_heavy","zombie_berserker"],var_01.var_A4B))
		{
			var_01.var_297D = ::func_5993;
		}

		while(!var_02)
		{
			wait(0.7);
			if(!isdefined(var_01.var_2A97))
			{
				break;
			}

			var_01 method_8398(var_01.var_2A97);
			if(distance(var_01.var_116,var_01.var_2A97.var_116) < func_418B())
			{
				var_02 = 1;
			}
		}
	}

	var_01 thread lib_0580::func_98EE(var_01.var_116,param_00.var_721C,"MOD_ENERGY","teslagun_zm_death",1);
}

//Function Number: 9
func_41DC()
{
	return 240;
}

//Function Number: 10
func_418B()
{
	return 100;
}

//Function Number: 11
func_418A()
{
	return 228;
}

//Function Number: 12
func_4324()
{
	return 1.2;
}