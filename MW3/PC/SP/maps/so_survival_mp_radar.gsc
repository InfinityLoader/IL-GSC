/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\so_survival_mp_radar.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 2:19:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.wave_table = "sp/so_survival/tier_3.csv";
	level.var_3F63 = "sp/so_survival/tier_3.csv";
	lib_03CB::main();
	lib_48E0::main();
	lib_03CC::main();
	lib_48E1::main();
	lib_0623::func_3F65();
	maps\_load::main();
	ambientplay("ambient_mp_radar");
	maps\_utility::set_vision_set("mp_radar",0);
	lib_0623::func_3F66();
	maps\_compass::setupminimap("compass_map_mp_radar");
	lib_0623::func_3F67();
	thread killtrigger((-5451,3761,1374),28,16);
	thread killtrigger((-5450,3606,1392),28,16);
	thread killtrigger((-5452,3712,1380),28,16);
	thread killtrigger((-5452,3656,1380),28,16);
	thread killtrigger((-5431,3781,1378),8,10);
	thread killtrigger((-5479,3781,1379),8,10);
	thread killtrigger((-3380,798,1234),28,16);
	thread killtrigger((-3379,644,1246),28,16);
	thread killtrigger((-3730,658,1234),28,16);
	thread killtrigger((-3794,640,1234),28,16);
	thread killtrigger((-3358,819,1238),8,10);
	thread killtrigger((-3680,669,1234),28,16);
	thread killtrigger((-3830,627,1250),28,16);
	thread killtrigger((-3382,738,1234),28,16);
	thread killtrigger((-3382,682,1234),28,16);
	thread killtrigger((-3655,657,1228),8,10);
	thread killtrigger((-3666,701,1238),8,10);
	thread killtrigger((-4812,-40,1256),32,24);
	thread killtrigger((-4763,-75,1301),10,10);
	thread killtrigger((-4893,-71,1128),100,10);
	thread killtrigger((-5017,-161,1128),100,10);
	thread killtrigger((-4864,3048,1344),4,20);
}

//Function Number: 2
killtrigger(param_00,param_01,param_02)
{
	var_03 = spawn("trigger_radius",param_00,0,param_01,param_02);
	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(!isplayer(var_04))
		{
			continue;
		}

		var_04 maps\_utility::kill_wrapper();
	}
}