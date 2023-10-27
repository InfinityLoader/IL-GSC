/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\so_survival_mp_village.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 2:19:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.wave_table = "sp/so_survival/tier_1.csv";
	level.var_3F63 = "sp/so_survival/tier_1.csv";
	lib_0390::main();
	lib_48E7::main();
	lib_0391::main();
	lib_48E8::main();
	lib_0623::func_3F65();
	maps\_load::main();
	if(!level.console)
	{
		setsaveddvar("r_ssaoStrength",0);
	}

	ambientplay("ambient_mp_village");
	maps\_utility::set_vision_set("mp_village",0);
	lib_0623::func_3F66();
	maps\_compass::setupminimap("compass_map_mp_village");
	lib_0623::func_3F67();
}