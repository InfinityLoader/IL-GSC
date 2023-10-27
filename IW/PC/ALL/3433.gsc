/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3433.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:27:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	lib_0D67::func_97D0();
	lib_0D70::func_97D0();
	lib_0D6B::func_97D0();
	lib_0D6F::func_97D0();
	lib_0D6C::func_97D0();
	level.var_2128 = [];
	level.var_2127 = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/battleRigTable.csv",var_00,0);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_01 = int(var_01);
		var_02 = tablelookupbyrow("mp/battleRigTable.csv",var_00,1);
		level.var_2128[var_01] = var_02;
		level.var_2127[var_02] = var_01;
		var_00++;
	}
}

//Function Number: 2
func_E0D0(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = undefined;
	switch(param_00)
	{
		case "archetype_assault":
			var_01 = ::lib_0D68::func_E0D0;
			break;

		case "archetype_heavy":
			var_01 = ::lib_0D6C::func_E0D0;
			break;

		case "archetype_scout":
			var_01 = ::lib_0D6F::func_E0D0;
			break;

		case "archetype_assassin":
			var_01 = ::lib_0D67::func_E0D0;
			break;

		case "archetype_engineer":
			var_01 = ::lib_0D6B::func_E0D0;
			break;

		case "archetype_sniper":
			var_01 = ::lib_0D70::func_E0D0;
			break;

		default:
			break;
	}

	if(isdefined(var_01))
	{
		self [[ var_01 ]]();
	}
}

//Function Number: 3
func_116E(param_00)
{
	if(param_00)
	{
		scripts\mp\_utility::func_8387("specialty_battleslide");
		return;
	}

	self notify("battleslide_unset");
}

//Function Number: 4
func_1170(param_00)
{
	if(param_00)
	{
		lib_0DE9::func_8659();
		return;
	}

	lib_0DE9::func_865A();
}

//Function Number: 5
func_EF38()
{
	self endon("death");
	self endon("disconnect");
	self notify("scriptableBoostFxManager");
	self endon("scriptableBoostFxManager");
	thread func_139CE();
	self setscriptablepartstate("jet_pack","neutral",0);
	for(;;)
	{
		self waittill("doubleJumpBoostBegin");
		if(lib_0DDF::func_9FC1() == 0)
		{
			self setscriptablepartstate("jet_pack","boost_on",0);
		}

		self waittill("doubleJumpBoostEnd");
		if(lib_0DDF::func_9FC1() == 0)
		{
			self setscriptablepartstate("jet_pack","neutral",0);
		}
	}
}

//Function Number: 6
func_139CE()
{
	self endon("scriptableBoostFxManager");
	self waittill("death");
	self setscriptablepartstate("jet_pack","off",0);
	self setscriptablepartstate("teamColorPins","off",0);
}

//Function Number: 7
func_EF41()
{
	self endon("death");
	self endon("disconnect");
	self notify("scriptableSlideBoostFxManager");
	self endon("scriptableSlideBoostFxManager");
	self setscriptablepartstate("jet_pack","neutral",0);
	thread func_139CF();
	for(;;)
	{
		self waittill("sprint_slide_begin");
		if(lib_0DDF::func_9FC1() == 0)
		{
			self setscriptablepartstate("jet_pack","boost_slide_on",0);
		}

		self waittill("sprint_slide_end");
		if(lib_0DDF::func_9FC1() == 0)
		{
			self setscriptablepartstate("jet_pack","neutral",0);
		}
	}
}

//Function Number: 8
func_139CF()
{
	self endon("scriptableSlideBoostFxManager");
	self waittill("death");
	self setscriptablepartstate("jet_pack","off",0);
	self setscriptablepartstate("teamColorPins","off",0);
}

//Function Number: 9
func_80F3(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	for(var_01 = 0;var_01 < level.var_2128.size;var_01++)
	{
		if(level.var_2128[var_01] == param_00)
		{
			return var_01;
		}
	}

	return 0;
}