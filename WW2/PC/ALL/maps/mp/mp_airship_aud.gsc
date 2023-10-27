/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_airship_aud.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 196 ms
 * Timestamp: 10/27/2023 3:15:18 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_5C22();
}

//Function Number: 2
func_5C22()
{
	thread func_35E1();
	thread mp_airship_snow_01();
	thread mp_airship_snow_02();
	thread mp_airship_snow_03();
	thread mp_airship_cable_01();
	thread mp_airship_cable_02();
	thread mp_airship_cable_03();
	thread mp_airship_phone_01();
	thread mp_airship_phone_02();
	thread mp_airship_phone_03();
}

//Function Number: 3
func_35E1()
{
	wait(0.5);
	lib_0380::func_6842("emt_airship_prop_lp",undefined,(3239,681,1171));
	lib_0380::func_6842("emt_airship_flag",undefined,(2198,318,770));
	lib_0380::func_6842("emt_airship_flag",undefined,(-311,-177,875));
	lib_0380::func_6842("emt_airship_flag",undefined,(956,-805,791));
	lib_0380::func_6842("emt_airship_flag",undefined,(152,-1351,556));
	lib_0380::func_6842("emt_airship_flag",undefined,(-1022,843,983));
	lib_0380::func_6842("emt_airship_flag",undefined,(265,1971,879));
	lib_0380::func_6842("emt_airship_fire_mtl_lrg",undefined,(437,934,850));
}

//Function Number: 4
mp_airship_snow_01()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_foliage_snow",undefined,(1570,-162,933));
		wait(randomintrange(5,8));
	}
}

//Function Number: 5
mp_airship_snow_02()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_foliage_snow",undefined,(1327,-109,933));
		wait(randomintrange(3,8));
	}
}

//Function Number: 6
mp_airship_snow_03()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_foliage_snow",undefined,(1417,-208,933));
		wait(randomintrange(3,7));
	}
}

//Function Number: 7
mp_airship_cable_01()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_cable",undefined,(1462,-365,863));
		wait(randomintrange(3,8));
	}
}

//Function Number: 8
mp_airship_cable_02()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_cable",undefined,(1486,-101,940));
		wait(randomintrange(5,8));
	}
}

//Function Number: 9
mp_airship_cable_03()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_cable",undefined,(1490,-1323,604));
		wait(randomintrange(5,8));
	}
}

//Function Number: 10
mp_airship_phone_01()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_phone",undefined,(1310,593,636));
		wait(randomintrange(12,20));
	}
}

//Function Number: 11
mp_airship_phone_02()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_phone",undefined,(1654,-609,636));
		wait(randomintrange(12,20));
	}
}

//Function Number: 12
mp_airship_phone_03()
{
	level endon("death");
	for(;;)
	{
		lib_0380::func_2889("emt_airship_phone",undefined,(1654,-609,636));
		wait(randomintrange(12,20));
	}
}