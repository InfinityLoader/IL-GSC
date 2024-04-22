/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createfx\credits_s1_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:07:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = common_scripts\utility::createoneshoteffect("test_effect");
	var_00.v["origin"] = (0,0,64);
	var_00.v["angles"] = (270,0,0);
	var_00.v["fxid"] = "test_effect";
	var_00.v["delay"] = -15;
}