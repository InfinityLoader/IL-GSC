/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1469.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_africa_militia_smg_a");
	lib_0144::func_1E57("alias_africa_militia_heads_a",lib_05B9::main());
	if(isendstr(self.var_1E5A,"_hat"))
	{
		lib_0144::func_1E5B("alias_africa_militia_hats_a",lib_05BA::main());
	}

	self.voice = "african";
}

//Function Number: 2
precache()
{
	precachemodel("body_africa_militia_smg_a");
	lib_0144::func_1E56(lib_05B9::main());
	lib_0144::func_1E56(lib_05BA::main());
}