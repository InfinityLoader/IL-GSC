/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_sotf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 604 ms
 * Timestamp: 10/27/2023 12:12:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8E1();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["dropped_weapon_think"] = ::func_10441;
	level.var_2D9E["dropped_weapon_cancel"] = ::func_10448;
	level.var_2D9E["crate_low_ammo_check"] = ::func_10444;
	level.var_2D9E["crate_should_claim"] = ::func_10445;
	level.var_2D9E["crate_wait_use"] = ::func_10446;
	level.var_2D9E["crate_in_range"] = ::func_10443;
	level.var_2D9E["crate_can_use"] = ::func_10442;
}

//Function Number: 3
func_F8E1()
{
	level.var_2EF2 = 1;
}

//Function Number: 4
func_10448(param_00)
{
	if(scripts\mp\bots\_bots_util::func_2DB8() > 0)
	{
		var_01 = scripts\mp\_utility::func_8225(self getcurrentweapon());
		if(isdefined(param_00.var_C270))
		{
			var_02 = param_00.var_C270.classname;
			if(scripts\common\utility::string_starts_with(var_02,"weapon_"))
			{
				var_02 = getsubstr(var_02,7);
			}

			var_03 = scripts\mp\_utility::func_8225(var_02);
			if(!func_2ED7(var_01,var_03))
			{
				return 1;
			}
		}
	}

	if(!isdefined(param_00.var_C270))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_10441()
{
	self notify("bot_think_seek_dropped_weapons");
	self endon("bot_think_seek_dropped_weapons");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		var_00 = 0;
		if(self [[ level.var_2D9E["should_pickup_weapons"] ]]() && !scripts\mp\bots\_bots_util::func_2DE0())
		{
			if(scripts\mp\bots\_bots_util::func_2E3B())
			{
				var_01 = getentarray("dropped_weapon","targetname");
				var_02 = scripts\common\utility::func_782F(self.origin,var_01);
				if(var_02.size > 0)
				{
					var_03 = var_02[0];
					scripts\mp\bots\_bots::func_2E6F(var_03);
				}
			}
			else
			{
				var_01 = getentarray("dropped_weapon","targetname");
				var_02 = scripts\common\utility::func_782F(self.origin,var_02);
				if(var_02.size > 0)
				{
					var_04 = self getnearestnode();
					if(isdefined(var_04))
					{
						var_05 = scripts\mp\_utility::func_8225(self getcurrentweapon());
						foreach(var_03 in var_02)
						{
							var_07 = var_03.classname;
							if(scripts\common\utility::string_starts_with(var_07,"weapon_"))
							{
								var_07 = getsubstr(var_07,7);
							}

							var_08 = scripts\mp\_utility::func_8225(var_07);
							if(func_2ED7(var_05,var_08))
							{
								if(!isdefined(var_03.calculated_nearest_node) || !var_03.calculated_nearest_node)
								{
									var_03.nearest_node = getclosestnodeinsight(var_03.origin);
									var_03.calculated_nearest_node = 1;
								}

								if(isdefined(var_03.nearest_node) && nodesvisible(var_04,var_03.nearest_node,1))
								{
									scripts\mp\bots\_bots::func_2E6F(var_03);
									break;
								}
							}
						}
					}
				}
			}
		}

		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 6
func_2E60(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "weapon_other":
		case "weapon_explosive":
		case "weapon_grenade":
		case "weapon_projectile":
			break;

		case "weapon_pistol":
			var_01 = 1;
			break;

		case "weapon_dmr":
		case "weapon_sniper":
			var_01 = 2;
			break;

		case "weapon_shotgun":
		case "weapon_lmg":
		case "weapon_assault":
		case "weapon_smg":
			var_01 = 3;
			break;
	}

	return var_01;
}

//Function Number: 7
func_2ED7(param_00,param_01)
{
	var_02 = func_2E60(param_00);
	var_03 = func_2E60(param_01);
	return var_03 > var_02;
}

//Function Number: 8
func_10444()
{
	var_00 = self getcurrentweapon();
	var_01 = self getweaponammoclip(var_00);
	var_02 = self getweaponammostock(var_00);
	var_03 = weaponclipsize(var_00);
	return var_01 + var_02 < var_03 * 0.25;
}

//Function Number: 9
func_10445()
{
	return 0;
}

//Function Number: 10
func_10446()
{
	scripts\mp\bots\_bots_util::func_2ECC(5000);
}

//Function Number: 11
func_10443(param_00)
{
	return 1;
}

//Function Number: 12
func_10442(param_00)
{
	if(scripts\mp\bots\_bots::func_4831(param_00))
	{
		if(isdefined(param_00) && isdefined(param_00.var_2EFA) && scripts\common\utility::func_2286(param_00.var_2EFA,self))
		{
			if(scripts\mp\bots\_bots_util::func_2E3B())
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}

		var_01 = scripts\mp\_utility::func_8225(self getcurrentweapon());
		if(func_2E60(var_01) <= 1)
		{
			return 1;
		}

		if(func_10444())
		{
			return 1;
		}

		return 0;
	}

	return 0;
}