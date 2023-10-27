/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1470.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_africa_militia_smg_b");
	self attach("head_africa_militia_b_hat","",1);
	self.var_1E5A = "head_africa_militia_b_hat";
	if(isendstr(self.var_1E5A,"_hat"))
	{
		lib_0144::func_1E5B("alias_africa_militia_hats_b",lib_05BB::main());
	}

	self.voice = "african";
}

//Function Number: 2
precache()
{
	precachemodel("body_africa_militia_smg_b");
	precachemodel("head_africa_militia_b_hat");
	lib_0144::func_1E56(lib_05BB::main());
}