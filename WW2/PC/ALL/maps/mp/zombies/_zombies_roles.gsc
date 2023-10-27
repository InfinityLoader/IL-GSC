/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zombies_roles.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 141 ms
 * Timestamp: 10/27/2023 3:25:43 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_AB43 = 0;
}

//Function Number: 2
func_7BF6()
{
	lib_0533::func_7BCE("role_ability_camo_zm",::lib_0537::func_D5,::lib_0537::func_3662,::lib_0537::func_2F9E);
	lib_0533::func_7BCE("role_ability_mad_minute_zm",::lib_0538::func_D5,::lib_0538::func_3662,::lib_0538::func_2F9E);
	lib_0533::func_7BCE("role_ability_melee_frenzy_zm",::lib_0539::func_D5,::lib_0539::func_3662,::lib_0539::func_2F9E);
	lib_0533::func_7BCE("role_ability_taunt_zm",::lib_053B::func_D5,::lib_053B::func_3662,::lib_053B::func_2F9E);
	lib_0533::func_7BCE("role_ability_stunning_burst_zm",::lib_053A::func_D5,::lib_053A::func_3662,::lib_053A::func_2F9E);
}

//Function Number: 3
func_6B6C(param_00)
{
	param_00.var_7ECB = 1200;
	if(common_scripts\utility::func_562E(0))
	{
		var_01 = getarraykeys(level.var_7ED0);
		if(isdefined(var_01) && var_01.size > 0)
		{
			param_00.var_7A3F = common_scripts\utility::func_7A33(var_01);
		}
	}
}

//Function Number: 4
func_6B81()
{
	if(common_scripts\utility::func_562E(0))
	{
		if(isdefined(self.var_7A3F))
		{
			lib_0586::func_78C(self.var_7A3F);
		}
	}
}

//Function Number: 5
func_6AB2(param_00)
{
	self endon("death");
	self endon("begin_last_stand");
	if(!lib_0547::func_5565(self.rentingability,param_00))
	{
	}

	self.var_90CC++;
	level notify("special_ability_used");
	var_01 = self getentitynumber();
	function_0327(&"activate_special_teammate",3,var_01,param_00,1);
	lib_0555::func_83DD("ability",self,param_00);
	thread lib_054E::func_7486(param_00);
	level.var_400E[level.var_400E.size] = ["assassin_set 4 -1",self];
	level.var_400E[level.var_400E.size] = ["bat_elite_set 4 -1",self];
	if(level.var_AB43)
	{
		thread func_6AB3();
		lib_0586::func_78E(param_00);
		common_scripts\utility::func_603();
		var_02 = undefined;
		for(;;)
		{
			self waittill("weapon_change",var_03);
			if(var_03 == param_00)
			{
				break;
			}
		}

		thread func_956B(param_00);
		switch(param_00)
		{
			case "role_ability_melee_frenzy_zm":
			case "role_ability_mad_minute_zm":
			case "role_ability_taunt_zm":
			case "role_ability_camo_zm":
			case "role_ability_stunning_burst_zm":
			default:
				wait(0.26);
				break;
		}
	}

	if(!isdefined(self.var_7ECC))
	{
		var_04 = 1;
		if(lib_0547::func_4BA7("specialty_class_specialist_zm"))
		{
			var_04 = 0.75;
		}

		self.var_7ECB = self.var_7ECB + 400 * var_04;
		self.var_7ECB = get_additional_scaling_value();
	}
	else
	{
		self.var_7ECC = undefined;
		self setclientomnvar("ui_zm_free_ability",0);
	}

	thread disableabilityondowned(param_00);
}

//Function Number: 6
get_additional_scaling_value()
{
	if(isdefined(level.zmb_zm_roles_exponential_cost))
	{
		return self.var_7ECB * level.zmb_zm_roles_exponential_cost;
	}

	return self.var_7ECB;
}

//Function Number: 7
disableabilityondowned(param_00)
{
	self endon("DisabledRoleAbility");
	self waittill("enter_last_stand");
	lib_0533::func_2F9E(param_00);
}

//Function Number: 8
func_956B(param_00)
{
	switch(param_00)
	{
		case "role_ability_melee_frenzy_zm":
		case "role_ability_mad_minute_zm":
		case "role_ability_taunt_zm":
		case "role_ability_camo_zm":
		case "role_ability_stunning_burst_zm":
		default:
			wait(0.44);
			break;
	}

	var_01 = lib_0547::func_AB2B();
	common_scripts\utility::func_617();
	lib_0586::func_78E(var_01);
	self notify("zm_role_putaway");
}

//Function Number: 9
func_6AB3()
{
	self endon("zm_role_putaway");
	common_scripts\utility::knock_off_battery("death","begin_last_stand");
	common_scripts\utility::func_617();
}

//Function Number: 10
func_6B84(param_00,param_01,param_02)
{
	if(0 && isdefined(param_02))
	{
		param_00 = param_02;
	}

	var_03 = 0;
	if(var_03 && maps\mp\_utility::func_3FA0("double_points"))
	{
		param_00 = int(param_00 * 2);
	}

	var_05 = param_00 / self.var_7ECB;
	lib_0533::func_F37(var_05);
}

//Function Number: 11
func_4789()
{
	foreach(var_01 in level.var_744A)
	{
		if(maps\mp\_utility::func_57A0(var_01))
		{
			var_01 lib_0533::func_F37(1,1,1);
		}
	}
}