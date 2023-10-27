/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\interaction_rave_openareas.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 316 ms
 * Timestamp: 10/27/2023 12:09:04 AM
*******************************************************************/

//Function Number: 1
init_all_debris_and_door_positions()
{
	func_F945("debris_350");
	func_F945("debris_1000");
	func_F945("debris_1500");
	func_F945("debris_2000");
	func_F945("debris_1250");
	func_F945("debris_750");
}

//Function Number: 2
func_F945(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		func_F4A1(var_03);
	}
}

//Function Number: 3
func_F4A1(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 method_8318(1);
		wait(0.1);
	}
}

//Function Number: 4
func_9749()
{
	var_00 = scripts\common\utility::getstructarray("power_door_sliding","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_102F8();
	}
}

//Function Number: 5
func_102F8()
{
	if(scripts\common\utility::istrue(self.var_E1B9))
	{
		level scripts\common\utility::waittill_any_3("power_on",self.var_D71C + " power_on");
	}

	self.var_D776 = 1;
	if(isdefined(self.script_sound))
	{
		playsoundatpos(self.origin,self.script_sound);
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.moved))
		{
			continue;
		}

		if(var_02.classname == "script_brushmodel")
		{
			var_02.moved = 1;
			var_02 connectpaths();
			var_02 notsolid();
		}

		if(var_02.classname == "script_model")
		{
			var_02.moved = 1;
			var_02 moveto(var_02.origin + var_02.var_ECF3,0.5);
		}
	}

	scripts\cp\_interaction::func_554F(self);
	scripts\cp\zombies\zombies_spawning::func_F28B(self);
	scripts\cp\zombies\zombies_spawning::func_15FC(self.script_area);
}