/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zombies_chi_meter.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 505 ms
 * Timestamp: 10/27/2023 12:09:08 AM
*******************************************************************/

//Function Number: 1
init_chi_meter(param_00)
{
	param_00.chi_meter_adustment = 0;
}

//Function Number: 2
chi_meter_on(param_00,param_01)
{
	var_02 = 1;
	switch(param_01)
	{
		case "snake":
			var_02 = 1;
			break;

		case "tiger":
			var_02 = 2;
			break;

		case "crane":
			var_02 = 3;
			break;

		case "dragon":
			var_02 = 4;
			break;
	}

	param_00 setclientomnvar("zm_ui_show_general",var_02);
	param_00 thread clean_up_chi_meter_on_last_stand(param_00);
	param_00 chi_drain_time(600);
}

//Function Number: 3
chi_meter_off(param_00)
{
	param_00 setclientomnvar("zm_ui_show_general",0);
	param_00 setclientomnvar("zom_general_fill_percent",0);
	param_00 notify("chi_mode_exited");
}

//Function Number: 4
clean_up_chi_meter_on_last_stand(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("chi_mode_exited");
	for(;;)
	{
		param_00 waittill("last_stand");
		if(scripts\common\utility::istrue(param_00.unlimited_chi))
		{
			continue;
		}
		else
		{
			param_00 chi_meter_off(param_00);
		}
	}
}

//Function Number: 5
chi_drain_time(param_00)
{
	self endon("disconnect");
	self endon("chi_mode_exited");
	level endon("game_ended");
	var_01 = 1000;
	var_02 = var_01 / 1000;
	var_03 = var_01 / param_00;
	self.chi_meter_amount = var_01;
	for(;;)
	{
		if(!scripts\common\utility::istrue(self.var_1097A) && !scripts\common\utility::istrue(self.inlaststand))
		{
			if(scripts\common\utility::istrue(self.chi_mode_od))
			{
				self.chi_meter_adustment = 0;
			}

			if(!scripts\common\utility::istrue(self.unlimited_chi))
			{
				var_01 = var_01 + self.chi_meter_adustment;
			}

			if(var_01 > 1000)
			{
				var_01 = 1000;
			}
			else if(var_01 <= 0)
			{
				var_01 = 0;
			}

			self.chi_meter_adustment = 0;
			var_02 = var_01 / 1000;
			if(var_02 > 1)
			{
				var_02 = 1;
			}

			var_04 = var_02;
			self setclientomnvar("zom_general_fill_percent",var_04);
			if(var_02 <= 0)
			{
				while(scripts\common\utility::istrue(self.kung_fu_exit_delay))
				{
					wait(0.1);
				}

				self setclientomnvar("zom_general_fill_percent",0);
				self.pre_kung_fu_weapon = scripts\cp\_utility::getvalidtakeweapon();
				scripts\cp\maps\cp_disco\kung_fu_mode::unset_kung_fu_mode(self,self.pre_kung_fu_weapon);
				break;
			}
		}

		self.chi_meter_amount = var_01;
		wait(0.1);
	}
}

//Function Number: 6
chi_meter_small_bump()
{
	self.chi_meter_adustment = self.chi_meter_adustment + 100;
}

//Function Number: 7
chi_meter_large_bump()
{
	self.chi_meter_adustment = self.chi_meter_adustment + 500;
}

//Function Number: 8
chi_meter_kill_decrement(param_00)
{
	self.chi_meter_adustment = self.chi_meter_adustment - param_00;
}

//Function Number: 9
flash_chi_meter_glow()
{
	if(!scripts\common\utility::istrue(self.unlimited_chi))
	{
		self setclientomnvar("zm_ui_show_general",2);
		wait(0.5);
		if(scripts\common\utility::istrue(self.chi_mode))
		{
			self setclientomnvar("zm_ui_show_general",4);
			return;
		}

		self setclientomnvar("zm_ui_show_general",1);
	}
}

//Function Number: 10
watchforearlychiexit()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("chi_mode_exited");
}