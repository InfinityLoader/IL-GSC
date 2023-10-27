/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1464.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0144::func_1E55(lib_05B7::main());
	self attach("head_opforce_arab_c","",1);
	self.var_1E5A = "head_opforce_arab_c";
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	lib_0144::func_1E56(lib_05B7::main());
	precachemodel("head_opforce_arab_c");
}