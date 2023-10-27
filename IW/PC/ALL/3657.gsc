/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3657.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:31:00 AM
*******************************************************************/

//Function Number: 1
func_660C()
{
	thread func_F34E("normal");
	thread func_51E0(::func_694B);
}

//Function Number: 2
func_694B()
{
}

//Function Number: 3
func_660D()
{
	thread func_F34E("relaxed");
	thread func_51E0(::func_694C);
}

//Function Number: 4
func_694C()
{
}

//Function Number: 5
func_660E(param_00)
{
	thread func_F34E("safe");
	if(!isdefined(param_00) || param_00 == 0)
	{
		thread scripts\sp\_utility::func_2B76(0.8,0.2);
		self.var_77C1.var_51E5 = 1;
	}

	self method_80D8(0.7,0.7);
	thread func_EA1E();
	scripts\common\utility::func_1C53(0);
	scripts\common\utility::func_1C58(0);
	scripts\common\utility::func_1C42(0);
	scripts\common\utility::func_1C70(0);
	scripts\common\utility::func_1C35(0);
	thread func_51E0(::func_694D);
}

//Function Number: 6
func_694D(param_00)
{
	if(isdefined(self.var_77C1.var_51E5) && self.var_77C1.var_51E5 == 1)
	{
		thread scripts\sp\_utility::func_2B77(0.2);
		self.var_77C1.var_51E5 = 0;
	}

	self method_80A6();
	scripts\common\utility::func_1C53(1);
	scripts\common\utility::func_1C58(1);
	scripts\common\utility::func_1C42(1);
	scripts\common\utility::func_1C70(1);
	scripts\common\utility::func_1C35(1);
}

//Function Number: 7
func_660B()
{
	self method_846C("safe","ges_demeanor_magboots");
	thread func_51E0(::func_694A);
}

//Function Number: 8
func_694A()
{
}

//Function Number: 9
func_EA1E()
{
	self endon("entering_new_demeanor");
	self endon("death");
	self.var_77C1.var_EA1F = getdvarint("cg_fov");
	childthread func_EA1C();
	childthread func_EA1D();
	thread func_EA1B();
}

//Function Number: 10
func_EA1C()
{
	level.player notifyonplayercommand("safe_zoom_pressed","+toggleads_throw");
	level.player notifyonplayercommand("safe_zoom_pressed","+ads_akimbo_accessible");
	level.player notifyonplayercommand("safe_zoom_pressed","+speed_throw");
	for(;;)
	{
		self waittill("safe_zoom_pressed");
		self method_81DE(self.var_77C1.var_EA1F - 9,0.14);
	}
}

//Function Number: 11
func_EA1D()
{
	level.player notifyonplayercommand("safe_zoom_released","-toggleads_throw");
	level.player notifyonplayercommand("safe_zoom_released","-ads_akimbo_accessible");
	level.player notifyonplayercommand("safe_zoom_released","-speed_throw");
	for(;;)
	{
		self waittill("safe_zoom_released");
		self method_81DE(self.var_77C1.var_EA1F,0.1);
	}
}

//Function Number: 12
func_EA1B()
{
	self endon("death");
	self waittill("entering_new_demeanor");
	self method_81DE(self.var_77C1.var_EA1F,0.1);
}

//Function Number: 13
func_51E0(param_00)
{
	self waittill("entering_new_demeanor");
	self [[ param_00 ]]();
}

//Function Number: 14
func_F34E(param_00)
{
	self endon("entering_new_demeanor");
	self endon("death");
	for(;;)
	{
		var_01 = self method_846C(param_00);
		if(var_01)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 15
func_D092(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	self endon("death");
	if(!isdefined(self.var_77C1))
	{
		self.var_77C1 = spawnstruct();
	}

	if(isdefined(param_01) && param_01 == 1)
	{
		if(level.player getstance() == "prone")
		{
			if(isdefined(self.var_77C1.var_DA82))
			{
			}
			else if(isdefined(level.player.var_BCF5))
			{
				self.var_77C1.var_DA82 = level.player.var_BCF5;
			}
			else
			{
				self.var_77C1.var_DA82 = 1;
			}

			scripts\sp\_utility::func_2B76(0);
			thread func_D094(param_00);
			if(!isdefined(self.var_77C1.var_E2F4))
			{
				self.var_77C1.var_E2F4 = 0;
			}

			self.var_77C1.var_E2F4++;
		}
		else
		{
			if(!isdefined(self.var_77C1.var_E2F5))
			{
				self.var_77C1.var_E2F5 = 0;
			}

			self.var_77C1.var_E2F5++;
			scripts\common\utility::func_1C60(0);
		}

		self.var_77C1.var_E2F3 = 1;
	}

	if(isdefined(param_02) && param_02 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F0))
		{
			self.var_77C1.var_E2F0 = 0;
		}

		self.var_77C1.var_E2F0++;
		scripts\common\utility::func_1C52(0);
	}

	if(isdefined(param_03) && param_03 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F7))
		{
			self.var_77C1.var_E2F7 = 0;
		}

		self.var_77C1.var_E2F7++;
		scripts\common\utility::func_1C67(0);
	}

	if(isdefined(param_04) && param_04 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2EF))
		{
			self.var_77C1.var_E2EF = 0;
		}

		self.var_77C1.var_E2EF++;
		scripts\common\utility::func_1C46(0);
	}

	if(isdefined(param_05) && param_05 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F6))
		{
			self.var_77C1.var_E2F6 = 0;
		}

		self.var_77C1.var_E2F6++;
		scripts\common\utility::func_1C62(0);
	}

	if(isdefined(param_06) && param_06 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F9))
		{
			self.var_77C1.var_E2F9 = 0;
		}

		self.var_77C1.var_E2F9++;
		scripts\common\utility::func_1C76(0);
	}

	if(isdefined(param_07) && param_07 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2ED))
		{
			self.var_77C1.var_E2ED = 0;
		}

		self.var_77C1.var_E2ED++;
		scripts\common\utility::func_1C35(0);
	}

	if(isdefined(param_08) && param_08 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F8))
		{
			self.var_77C1.var_E2F8 = 0;
		}

		self.var_77C1.var_E2F8++;
		scripts\common\utility::func_1C70(0);
	}

	if(isdefined(param_09) && param_09 == 1)
	{
		if(!isdefined(self.var_77C1.var_E2EE))
		{
			self.var_77C1.var_E2EE = 0;
		}

		self.var_77C1.var_E2EE++;
		scripts\common\utility::func_1C42(0);
	}

	if(isdefined(param_0A) && param_0A == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F1))
		{
			self.var_77C1.var_E2F1 = 0;
		}

		self.var_77C1.var_E2F1++;
		scripts\common\utility::func_1C53(0);
	}

	if(isdefined(param_0B) && param_0B == 1)
	{
		if(!isdefined(self.var_77C1.var_E2F2))
		{
			self.var_77C1.var_E2F2 = 0;
		}

		self.var_77C1.var_E2F2++;
		scripts\common\utility::func_1C58(0);
	}

	if(isdefined(param_0C))
	{
		wait(param_0C);
	}
	else
	{
		self waittill("gesture_stopped",var_0D);
		if(var_0D != param_00)
		{
			for(;;)
			{
				if(!self isgestureplaying(param_00))
				{
					break;
				}

				wait(0.05);
			}
		}
	}

	self notify(param_00 + "gesture_stopped_internal");
	func_D093(param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 16
func_D093(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(self.var_77C1))
	{
		self.var_77C1 = spawnstruct();
	}

	if(isdefined(param_00) && param_00 > 0)
	{
		if(isdefined(self.var_77C1.var_E2F4) && self.var_77C1.var_E2F4 > 0)
		{
			if(isdefined(level.player.var_BCF5) && level.player.var_BCF5 == 0)
			{
				self.var_77C1.var_E2F4--;
				if(self.var_77C1.var_E2F4 <= 0)
				{
					scripts\sp\_utility::func_2B76(self.var_77C1.var_DA82);
					self.var_77C1.var_DA82 = undefined;
				}
			}
		}

		if(isdefined(self.var_77C1.var_E2F5) && self.var_77C1.var_E2F5 > 0)
		{
			self.var_77C1.var_E2F5--;
			scripts\common\utility::func_1C60(1);
		}
	}

	if(isdefined(param_01) && param_01 == 1)
	{
		scripts\common\utility::func_1C52(1);
	}

	if(isdefined(param_02) && param_02 == 1)
	{
		scripts\common\utility::func_1C67(1);
	}

	if(isdefined(param_03) && param_03 == 1)
	{
		scripts\common\utility::func_1C46(1);
	}

	if(isdefined(param_04) && param_04 == 1)
	{
		scripts\common\utility::func_1C62(1);
	}

	if(isdefined(param_05) && param_05 == 1)
	{
		scripts\common\utility::func_1C76(1);
	}

	if(isdefined(param_06) && param_06 == 1)
	{
		scripts\common\utility::func_1C35(1);
	}

	if(isdefined(param_07) && param_07 == 1)
	{
		scripts\common\utility::func_1C70(1);
	}

	if(isdefined(param_08) && param_08 == 1)
	{
		scripts\common\utility::func_1C42(1);
	}

	if(isdefined(param_09) && param_09 == 1)
	{
		scripts\common\utility::func_1C53(1);
	}

	if(isdefined(param_0A) && param_0A == 1)
	{
		scripts\common\utility::func_1C58(1);
	}
}

//Function Number: 17
func_D094(param_00)
{
	self endon("death");
	self endon(param_00 + "gesture_stopped_internal");
	var_01 = 1;
	while(var_01)
	{
		if(self getstance() != "prone")
		{
			waittillframeend;
			if(isdefined(level.player.var_BCF5) && level.player.var_BCF5 == 0)
			{
				self.var_77C1.var_E2F4--;
				if(self.var_77C1.var_E2F4 <= 0)
				{
					scripts\sp\_utility::func_2B76(self.var_77C1.var_DA82);
					self.var_77C1.var_DA82 = undefined;
				}
			}

			if(!isdefined(self.var_77C1.var_E2F5))
			{
				self.var_77C1.var_E2F5 = 0;
			}

			self.var_77C1.var_E2F5++;
			scripts\common\utility::func_1C60(0);
			var_01 = 0;
		}

		wait(0.05);
	}
}