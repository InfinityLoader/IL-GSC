/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_house_aud.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 284 ms
 * Timestamp: 10/27/2023 3:18:55 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	lib_0367::func_8E3E("house");
	func_7BBA();
	thread func_526E();
}

//Function Number: 2
func_7BBA()
{
	lib_0378::func_8DC7("player_connect_map",::func_7248);
	lib_0378::func_8DC7("player_spawned",::func_7330);
	lib_0378::func_8DC7("wave_begin",::func_A979);
	lib_0378::func_8DC7("wave_end",::func_A97A);
	lib_0378::func_8DC7("enter_last_stand",::func_37B4);
	lib_0378::func_8DC7("revive",::func_7E51);
	lib_0378::func_8DC7("death",::func_2A83);
	lib_0378::func_8DC7("end_respawn",::func_36A1);
	lib_0378::func_8DC7("end_joined_spectators",::func_3689);
	lib_0378::func_8DC7("door_open",::func_326F);
	lib_0378::func_8DC7("door_close",::func_3257);
	lib_0378::func_8DC7("ee_complete",::func_3577);
	lib_0378::func_8DC7("ee_update",::func_3598);
	lib_0378::func_8DC7("ee_piano_use",::func_358B);
}

//Function Number: 3
func_526E()
{
}

//Function Number: 4
func_7248()
{
}

//Function Number: 5
func_7330()
{
	lib_0366::func_AB0D();
	self method_8622("int_house_downstairs");
	self method_8626("house_global",0.25);
	lib_0366::snd_zmb_set_plr_vox_scare_count_max(1);
}

//Function Number: 6
func_A979()
{
}

//Function Number: 7
func_A97A()
{
}

//Function Number: 8
func_37B4()
{
}

//Function Number: 9
func_7E51()
{
}

//Function Number: 10
func_2A83()
{
	var_00 = 5;
	lib_0366::func_8E32(var_00);
}

//Function Number: 11
func_36A1()
{
}

//Function Number: 12
func_3689()
{
}

//Function Number: 13
func_326F()
{
}

//Function Number: 14
func_3257()
{
	level.var_120E = lib_0380::func_2889("training_house_door_close",undefined,self.var_116);
	lib_0378::func_8D14(level.var_120E);
}

//Function Number: 15
func_3577()
{
	lib_0380::func_2889("house_ee_door_open",undefined,self.var_116);
}

//Function Number: 16
func_3598()
{
	lib_0380::func_2889("training_crow_caw",undefined,self.var_116);
}

//Function Number: 17
func_358B(param_00,param_01)
{
	if(param_01 == 1)
	{
		lib_0380::func_2889("zmb_piano_success",undefined,param_00);
		return;
	}

	lib_0380::func_2889("zmb_piano_fail",undefined,param_00);
}