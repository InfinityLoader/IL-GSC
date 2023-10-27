/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3597.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:30:51 AM
*******************************************************************/

//Function Number: 1
func_12F9B()
{
	self setscriptablepartstate("amplify","active",0);
	self.var_1E57 = 500;
	level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_amplify",undefined,0.75);
	return 1;
}

//Function Number: 2
func_62A3(param_00)
{
	self notify("amplify_end");
	self.var_1E57 = undefined;
	if(self.var_AE62 == "archetype_assault")
	{
		self setscriptablepartstate("amplify","neutral",0);
	}
}

//Function Number: 3
func_12BF4()
{
	func_62A3();
}

//Function Number: 4
func_9D41()
{
	var_00 = scripts\mp\_supers::func_7E4F();
	if(!isdefined(var_00) || var_00 != "super_amplify")
	{
		return 0;
	}

	if(!scripts\mp\_supers::func_9F88())
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_1E58(param_00)
{
	if(!func_9D41())
	{
		return 0;
	}

	var_01 = int(min(self.var_1E57,param_00 * 1));
	self.var_1E57 = self.var_1E57 - var_01;
	var_02 = 100;
	if(self.var_1E57 > 0)
	{
		var_02 = int(min(floor(var_01 / 10),1));
	}

	for(var_03 = 0;var_03 <= var_02;var_03++)
	{
		scripts\mp\_supers::func_1613();
		if(!scripts\mp\_supers::func_9F88())
		{
			break;
		}
	}

	return var_01;
}