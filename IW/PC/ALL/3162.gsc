/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3162.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:26:21 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("shoot_c12_right"))
	{
		return;
	}

	lib_0A1A::func_230B("shoot_c12_right","shoot_init");
	lib_0A1A::func_2374("shoot_rocket",::lib_0C41::func_35D6,undefined,undefined,::lib_0C41::func_3613,undefined,::lib_0C41::func_3526,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_rocket_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("shoot_rocket_idle",undefined,::lib_0C42::func_3517,undefined);
	lib_0A1A::func_2374("shoot_minigun",::lib_0C41::func_35D5,undefined,undefined,::lib_0C41::func_3612,undefined,::lib_0C41::func_3525,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_minigun_idle",undefined,::lib_0C42::func_3519,"minigun");
	lib_0A1A::func_2375("shoot_minigun_idle",undefined,::lib_0C42::func_3517,undefined);
	lib_0A1A::func_2374("shoot_minigun_idle",::lib_0C41::func_35D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_minigun",undefined,::lib_0C42::func_351A,"minigun");
	lib_0A1A::func_2374("shoot_init",::lib_0C42::func_35E3,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_rocket_idle",undefined,::lib_0C42::func_3514,"rocket");
	lib_0A1A::func_2375("shoot_minigun_idle",undefined,::lib_0C42::func_3514,"minigun");
	lib_0A1A::func_2374("shoot_rocket_idle",::lib_0C41::func_35D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_rocket",undefined,::lib_0C42::func_351A,"rocket");
	lib_0A1A::func_2327();
}