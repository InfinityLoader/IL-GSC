/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\debug_graycard.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 554 ms
 * Timestamp: 10/27/2023 12:03:18 AM
*******************************************************************/

//Function Number: 1
func_960D(param_00)
{
	precachemodel("refmat_plastic_black_matte");
	precachemodel("refmat_plastic_black_semiglossy");
	precachemodel("refmat_metal_steel_stainless");
	precachemodel("refmat_metal_steel_stainless_thinfilm");
	precachemodel("test_debug_greycard");
	precachemodel("misc_color_checker_01");
	level.var_4EE6 = 0;
	level.var_4EE8 = "test_debug_greycard";
}

//Function Number: 2
func_10AA0()
{
}

//Function Number: 3
func_C56E()
{
}

//Function Number: 4
func_4EE5()
{
	func_4EE4(1);
}

//Function Number: 5
func_4EE4(param_00)
{
}

//Function Number: 6
func_F336(param_00)
{
}

//Function Number: 7
func_E032()
{
}

//Function Number: 8
func_48F6()
{
}

//Function Number: 9
func_1071E()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel(level.var_4EE8);
	return var_00;
}

//Function Number: 10
func_4EE7(param_00)
{
}

//Function Number: 11
func_48BE(param_00)
{
	var_01 = func_1071E();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	if(!isdefined(level.var_4EE9))
	{
		level.var_4EE9 = [var_01];
		return;
	}

	if(level.var_4EE9.size > 50)
	{
		var_02 = [];
		level.var_4EE9[0] delete();
		for(var_03 = 1;var_03 < level.var_4EE9.size;var_03++)
		{
			var_02[var_02.size] = level.var_4EE9[var_03];
		}

		var_02[var_02.size] = var_01;
		level.var_4EE9 = var_02;
		return;
	}

	level.var_4EE9[level.var_4EE9.size] = var_01;
}