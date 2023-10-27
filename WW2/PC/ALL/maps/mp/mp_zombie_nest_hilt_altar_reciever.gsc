/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_hilt_altar_reciever.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 161 ms
 * Timestamp: 10/27/2023 3:19:56 AM
*******************************************************************/

//Function Number: 1
func_84DB()
{
	wait(1);
	var_00 = %zmb_hilt_altar_receiver_down;
	self setscriptablepartstate("machine_main","closing");
	wait(getanimlength(var_00));
	self setscriptablepartstate("machine_main","closed");
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		func_84D7(var_01 + 1,"idle_down");
	}
}

//Function Number: 2
func_84DD(param_00)
{
	for(var_01 = 0;var_01 < self.size;var_01++)
	{
		if(isdefined(self[var_01].var_9045))
		{
			self[var_01].var_9045 delete();
		}
	}

	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		self[var_01].var_9045 = lib_0547::func_8FBA(self[var_01],"zmb_com_cart_full");
		triggerfx(self[var_01].var_9045);
	}
}

//Function Number: 3
func_84D6()
{
	self.var_5CCE = lib_0547::func_8FBA(self,"raven_upgrade_green_light");
	triggerfx(self.var_5CCE);
}

//Function Number: 4
func_84D5()
{
	if(isdefined(self.var_5CCE))
	{
		self.var_5CCE delete();
	}
}

//Function Number: 5
func_84DC()
{
	var_00 = %zmb_hilt_altar_receiver_up;
	self setscriptablepartstate("machine_main","opening");
	wait(getanimlength(var_00));
	self setscriptablepartstate("machine_main","opened");
}

//Function Number: 6
func_84DA()
{
	var_00 = %zmb_hilt_altar_receiver_down;
	self setscriptablepartstate("machine_main","closing");
	wait(getanimlength(var_00));
	self setscriptablepartstate("machine_main","closed");
}

//Function Number: 7
func_84D9(param_00)
{
	var_01 = [];
	var_01[0] = %zmb_hilt_altar_receiver_button_01_up;
	var_01[1] = %zmb_hilt_altar_receiver_button_02_up;
	var_01[2] = %zmb_hilt_altar_receiver_button_03_up;
	self setscriptablepartstate("button_" + param_00,"up");
	wait(getanimlength(var_01[param_00 - 1]));
	self setscriptablepartstate("button_" + param_00,"idle_up");
}

//Function Number: 8
func_84D8(param_00)
{
	var_01 = [];
	var_01[0] = %zmb_hilt_altar_receiver_button_01_down;
	var_01[1] = %zmb_hilt_altar_receiver_button_02_down;
	var_01[2] = %zmb_hilt_altar_receiver_button_03_down;
	self setscriptablepartstate("button_" + param_00,"down");
	wait(getanimlength(var_01[param_00 - 1]));
	self setscriptablepartstate("button_" + param_00,"idle_down");
}

//Function Number: 9
func_84D7(param_00,param_01)
{
	self setscriptablepartstate("button_" + param_00,param_01);
}