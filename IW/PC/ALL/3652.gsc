/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3652.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:30:59 AM
*******************************************************************/

//Function Number: 1
func_952C()
{
	level.player scripts\sp\_utility::func_65E0("using_arm_device");
	level.player scripts\sp\_utility::func_65E1("using_arm_device");
}

//Function Number: 2
func_169B(param_00,param_01,param_02,param_03)
{
	var_04 = func_2164(param_00);
	level notify("arm_device_remove_slot_" + var_04);
	self notifyonplayercommand("action_slot_used_" + var_04,"+actionslot " + var_04);
	thread func_2167(var_04,param_01,param_02,param_03);
}

//Function Number: 3
func_2167(param_00,param_01,param_02,param_03)
{
	level endon("stop_arm_device");
	level endon("arm_device_remove_slot_" + param_00);
	self endon("death");
	var_04 = 0;
	for(;;)
	{
		var_05 = scripts\common\utility::func_13734("action_slot_used_" + param_00,param_03);
		if(isdefined(self.var_55BD) && self.var_55BD > 0)
		{
			continue;
		}

		if(scripts\sp\_utility::func_65DB("using_arm_device") || isdefined(param_03) && var_05 == param_03)
		{
			if(var_04 == 1 && isdefined(param_02) || isdefined(param_03))
			{
				if(isdefined(param_02))
				{
					level thread [[ param_02 ]]();
				}

				var_04 = 0;
				continue;
			}

			if(!isdefined(param_03) || var_05 != param_03)
			{
				level thread [[ param_01 ]]();
				var_04 = 1;
			}
		}
	}
}

//Function Number: 4
func_2163()
{
	level notify("stop_arm_device");
}

//Function Number: 5
func_2165()
{
	scripts\sp\_utility::func_65DD("using_arm_device");
}

//Function Number: 6
func_2168()
{
	scripts\sp\_utility::func_65E1("using_arm_device");
}

//Function Number: 7
func_2166(param_00)
{
	var_01 = func_2164(param_00);
	level notify("arm_device_remove_slot_" + var_01);
}

//Function Number: 8
func_2164(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "up":
			var_01 = 1;
			break;

		case "down":
			var_01 = 2;
			break;

		case "left":
			var_01 = 3;
			break;

		case "right":
			var_01 = 4;
			break;
	}

	return var_01;
}