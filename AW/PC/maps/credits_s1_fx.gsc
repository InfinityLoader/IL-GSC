/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: credits_s1_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 36 ms
 * Timestamp: 4/22/2024 2:27:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["test_effect"] = loadfx("vfx/test/test_fx");
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\createfx\credits_s1_fx::main();
	}
}