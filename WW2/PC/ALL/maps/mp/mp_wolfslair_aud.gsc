/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_wolfslair_aud.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 105 ms
 * Timestamp: 10/27/2023 3:17:06 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_5C22();
	func_5C18();
}

//Function Number: 2
func_5C22()
{
	thread small_pipe_steam();
	thread wood_debris_and_creaks();
	thread concrete_debris();
}

//Function Number: 3
func_5C18()
{
	lib_0380::func_6842("mp_wolfslair_water_heater",undefined,(-135,-753,733));
	lib_0380::func_6842("mp_wolfslair_broken_vent",undefined,(-1763,396,820));
	lib_0380::func_6842("mp_wolfslair_rattle_lp_1",undefined,(-1566,115,749));
	lib_0380::func_6842("mp_wolfslair_rattle_lp_2",undefined,(-1425,986,749));
	lib_0380::func_6842("mp_wolfslair_rattle_lp_1",undefined,(-51,637,700));
	lib_0380::func_6842("mp_wolfslair_water_heater",undefined,(-25,254,733));
	lib_0380::func_6842("mp_wolfslair_rattle_lp_1",undefined,(-195,356,755));
}

//Function Number: 4
small_pipe_steam()
{
	for(;;)
	{
		wait(randomfloatrange(0.5,5));
		lib_0380::func_6842("mp_wolfslair_small_pipes",undefined,(-1417,389,739));
		lib_0380::func_6842("mp_wolfslair_small_pipes",undefined,(-128,-749,732));
	}
}

//Function Number: 5
wood_debris_and_creaks()
{
	for(;;)
	{
		wait(randomfloatrange(1,10));
		lib_0380::func_6842("damb_building_stress_int",undefined,(991,675,744));
	}
}

//Function Number: 6
concrete_debris()
{
	for(;;)
	{
		wait(randomfloatrange(1,10));
		lib_0380::func_6842("mp_wolfslair_concrete_debris",undefined,(-10332,2660,718));
		lib_0380::func_6842("mp_wolfslair_concrete_debris",undefined,(261,1789,758));
		lib_0380::func_6842("mp_wolfslair_concrete_debris",undefined,(892,-1089,698));
	}
}