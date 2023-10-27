/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_trophy_system.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1247 ms
 * Timestamp: 10/27/2023 12:21:50 AM
*******************************************************************/

//Function Number: 1
func_12813()
{
	var_00 = spawnstruct();
	var_00.var_1141B = [];
	var_00.var_1141B[0] = "tag_sensor_1";
	var_00.var_1141B[1] = "tag_sensor_2";
	var_00.var_1141B[2] = "tag_sensor_3";
	level.var_12802 = var_00;
}

//Function Number: 2
func_12820()
{
	func_12806();
	func_1281A();
}

//Function Number: 3
func_12825()
{
	func_12806();
}

//Function Number: 4
func_12827(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	scripts\mp\_utility::func_D915("trophy spawned",self);
	thread scripts\mp\_weapons::monitordisownedgrenade(self,param_00);
	param_00 waittill("missile_stuck",var_01);
	param_00 method_831F(self);
	param_00 method_8317(1);
	var_02 = scripts\mp\_utility::_hasperk("specialty_rugged_eqp");
	if(var_02)
	{
		param_00.hasruggedeqp = 1;
	}

	param_00.var_1E2D = func_1281F();
	if(!isdefined(param_00.var_1E2D))
	{
		param_00.var_1E2D = 2;
	}

	scripts\mp\_weapons::func_C5AC(param_00,"power_trophy");
	thread scripts\mp\_weapons::func_B9CA(self,param_00);
	param_00 thread scripts\mp\_weapons::func_B2A7("tag_use",1);
	param_00.var_69DA = trophy_createexplosion(param_00);
	var_03 = scripts\common\utility::func_116D7(var_02,200,100);
	var_04 = scripts\common\utility::func_116D7(var_02,"hitequip","");
	param_00 thread scripts\mp\_damage::func_B9C6(var_03,var_04,::func_12812,::func_12811,0);
	param_00 thread trophy_destroyonemp();
	param_00 thread trophy_destroyongameend();
	param_00 thread func_1282B();
	param_00 method_859F();
	param_00 method_85A0();
	param_00 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static",self);
	param_00 thread scripts\mp\_entityheadicons::func_F73E(self,(0,0,38),1.3);
	thread scripts\mp\_weapons::func_C798(param_00,self);
	param_00 thread func_1280B();
	param_00 thread scripts\mp\perks\_perk_equipmentping::func_E84B();
}

//Function Number: 5
trophy_destroy()
{
	thread trophy_delete(1.6);
	self setscriptablepartstate("effects","activeDestroyStart",0);
	wait(1.5);
	self setscriptablepartstate("effects","activeDestroyEnd",0);
}

//Function Number: 6
trophy_delete(param_00)
{
	self notify("death");
	level.var_B779[self getentitynumber()] = undefined;
	self setcandamage(0);
	self makeunusable();
	scripts\mp\_weapons::func_B2A4();
	self.var_69BA = 1;
	var_01 = self.var_222;
	if(isdefined(self.var_222))
	{
		var_01.var_CC4D = scripts\common\utility::func_22A9(var_01.var_CC4D,self);
		var_01 notify("trophy_update",0);
	}

	wait(param_00);
	self delete();
}

//Function Number: 7
func_1280B()
{
	self endon("death");
	self setscriptablepartstate("effects","activeDeployStart");
	wait(1.25);
	self setscriptablepartstate("effects","activeDeployEnd");
}

//Function Number: 8
func_1282B()
{
	self endon("death");
	self.var_222 endon("disconnect");
	if(!isdefined(level.var_85D5))
	{
		level.var_85D5 = [];
	}

	if(!isdefined(level.var_B898))
	{
		level.var_B898 = [];
	}

	if(!isdefined(level.var_B779))
	{
		level.var_B779 = [];
	}

	var_00 = func_12804();
	for(;;)
	{
		var_01 = func_12805();
		var_02 = [];
		var_02[0] = level.var_85D5;
		var_02[1] = level.var_B898;
		var_02[2] = level.var_B779;
		var_03 = scripts\common\utility::func_2282(var_02);
		foreach(var_05 in var_03)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(scripts\mp\_utility::func_9FB3(var_05.var_69BA))
			{
				continue;
			}

			if(trophy_checkignorelist(var_05))
			{
				continue;
			}

			var_06 = var_05.var_222;
			if(!isdefined(var_06) && isdefined(var_05.var_13C2E) && weaponclass(var_05.var_13C2E) == "grenade")
			{
				var_06 = getmissileowner(var_05);
			}

			if(isdefined(var_06) && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_06)))
			{
				continue;
			}

			if(distancesquared(var_05.origin,self.origin) > trophy_modifiedprotectiondistsqr(var_05,65536))
			{
				continue;
			}

			var_07 = function_0287(var_01,var_05.origin,var_00,[self,var_05],0,"physicsquery_closest");
			if(isdefined(var_07) && var_07.size > 0)
			{
				continue;
			}

			func_1281E(var_05);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 9
func_1281E(param_00)
{
	self.var_222 thread scripts\mp\_utility::func_83B4("trophy_defense");
	self.var_222 scripts\mp\_missions::func_D991("ch_tactical_trophy");
	self.var_222 thread scripts\mp\_gamelogic::func_117B7("trophy_mp",1,"hits");
	self.var_222 scripts\mp\_damage::combatrecordtacticalstat("power_trophy");
	param_00 setcandamage(0);
	param_00.var_69BA = 1;
	param_00 method_83AD();
	func_12821(param_00);
	func_12817(param_00,"trophy_mp",self.var_222);
	var_01 = param_00.origin;
	var_02 = param_00.angles;
	if(scripts\mp\_weapons::func_9EE5(param_00))
	{
		param_00 scripts\mp\_weapons::func_51B5();
	}
	else if(param_00 scripts\mp\_domeshield::isdomeshield())
	{
		param_00 thread scripts\mp\_domeshield::domeshield_delete();
	}
	else
	{
		param_00 delete();
	}

	var_03 = trophy_getbesttag(var_01);
	var_04 = trophy_getpartbytag(var_03);
	self setscriptablepartstate(var_04,"active",0);
	self.var_69DA thread trophy_explode(var_01,var_02);
	self.var_1E2D--;
	if(self.var_1E2D <= 0)
	{
		thread trophy_destroy();
	}
}

//Function Number: 10
func_12811(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	scripts\mp\_powers::equipmenthit(self.var_222,param_00,param_01,param_02);
	return var_05;
}

//Function Number: 11
func_12812(param_00,param_01,param_02,param_03,param_04)
{
	trophy_givepointsfordeath(param_00);
	thread trophy_destroy();
}

//Function Number: 12
trophy_destroyonemp()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("emp_damage",var_00,var_01);
	trophy_givepointsfordeath(var_00);
	trophy_givedamagefeedback(var_00);
	thread trophy_destroy();
}

//Function Number: 13
trophy_destroyongameend()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread trophy_destroy();
}

//Function Number: 14
func_12818()
{
	if(self.var_222 scripts\mp\_powers::func_8C17("power_trophy"))
	{
		self.var_222 func_12803(self.var_1E2D);
	}
}

//Function Number: 15
trophy_createexplosion(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.var_A63A = param_00;
	var_01.var_222 = param_00.var_222;
	var_01.team = param_00.team;
	var_01.var_D719 = param_00.var_D719;
	var_01.var_13C2E = param_00.var_13C2E;
	var_01 method_831F(var_01.var_222);
	var_01 method_82DD(var_01.var_222);
	var_01 setmodel("trophy_system_mp_explode");
	var_01.explode1available = 1;
	var_01.explode2available = 1;
	var_01 thread trophy_cleanuponparentdeath(param_00,0.1);
	return var_01;
}

//Function Number: 16
trophy_explode(param_00,param_01)
{
	self dontinterpolate();
	self.origin = param_00;
	self.angles = param_01;
	if(self.explode1available)
	{
		self setscriptablepartstate("explode1","active",0);
		self.explode1available = 0;
		return;
	}

	if(self.explode2available)
	{
		self setscriptablepartstate("explode2","active",0);
		self.explode1available = 0;
	}
}

//Function Number: 17
func_12805()
{
	return self.origin + anglestoup(self.angles) * 45;
}

//Function Number: 18
func_12804()
{
	return physics_createcontents(["physicscontents_solid","physicscontents_vehicle","physicscontents_glass","physicscontents_water","physicscontents_sky","physicscontents_item"]);
}

//Function Number: 19
trophy_modifiedprotectiondistsqr(param_00,param_01)
{
	if(isdefined(param_00.var_13C2E) && isdefined(param_00.var_222))
	{
		switch(param_00.var_13C2E)
		{
			case "jackal_cannon_mp":
			case "shockproj_mp":
			case "switch_blade_child_mp":
			case "thorproj_zoomed_mp":
			case "drone_hive_projectile_mp":
				if(147456 > param_01)
				{
					param_01 = 147456;
				}
				break;

			case "iw7_arclassic_mp":
			case "iw7_chargeshot_mp":
			case "iw7_lockon_mp":
			case "wristrocket_proj_mp":
				if(65536 > param_01)
				{
					param_01 = 65536;
				}
				break;
		}
	}

	return param_01;
}

//Function Number: 20
trophy_checkignorelist(param_00)
{
	if(isdefined(param_00.var_13C2E))
	{
		if(scripts\mp\_utility::func_9E6C(param_00.var_13C2E))
		{
			return 1;
		}

		if(scripts\mp\_weapons::isaxeweapon(param_00.var_13C2E))
		{
			return 1;
		}

		switch(param_00.var_13C2E)
		{
			case "domeshield_mp":
				if(scripts\mp\_weapons::func_9EE5(param_00))
				{
					return 1;
				}
				break;

			case "trophy_mp":
				if(scripts\mp\_weapons::func_9EE5(param_00))
				{
					return 1;
				}
				break;

			case "uplinkball_tracking_mp":
			case "blackholegun_indicator_mp":
			case "cluster_grenade_indicator_mp":
			case "micro_turret_mp":
			case "iw7_cheytac_mpr_projectile":
			case "iw7_blackholegun_mp":
			case "globproj_mp":
			case "transponder_mp":
			case "throwingknifeteleport_mp":
			case "throwingknife_mp":
			case "wristrocket_mp":
			case "throwingknifec4_mp":
				return 1;
		}
	}

	return 0;
}

//Function Number: 21
func_12821(param_00)
{
	if(getdvarint("showArchetypes",0) > 0)
	{
		param_00 scripts\mp\_powers::func_C179();
	}
}

//Function Number: 22
func_12817(param_00,param_01,param_02)
{
	if(!isdefined(param_00.var_222) || !isplayer(param_00.var_222))
	{
		return;
	}

	param_00.var_222 thread scripts\mp\_damagefeedback::func_12E84("hiticontrophysystem");
	if(isdefined(param_00.var_13C2E))
	{
		switch(param_00.var_13C2E)
		{
			case "jackal_cannon_mp":
			case "shockproj_mp":
			case "switch_blade_child_mp":
			case "thorproj_tracking_mp":
			case "thorproj_zoomed_mp":
			case "drone_hive_projectile_mp":
				param_00.var_222 notify("destroyed_by_trophy",param_02,param_01,param_00.var_13C2E,param_00.origin,param_00.angles);
				break;
		}
	}
}

//Function Number: 23
trophy_getbesttag(param_00)
{
	var_01 = level.var_12802.var_1141B;
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_0A, var_05 in var_01)
	{
		var_06 = self gettagorigin(var_05);
		var_07 = self gettagangles(var_05);
		var_08 = anglestoforward(var_07);
		var_09 = vectordot(vectornormalize(param_00 - var_06),var_08);
		if(var_0A == 0 || var_09 > var_02)
		{
			var_02 = var_09;
			var_03 = var_05;
		}
	}

	return var_03;
}

//Function Number: 24
trophy_getpartbytag(param_00)
{
	var_01 = level.var_12802.var_1141B;
	foreach(var_04, var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return "protect" + var_04 + 1;
		}
	}

	return undefined;
}

//Function Number: 25
trophy_givepointsfordeath(param_00)
{
	if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
	{
		param_00 notify("destroyed_equipment");
		param_00 thread scripts\mp\_utility::func_83B4("destroyed_equipment");
	}
}

//Function Number: 26
trophy_givedamagefeedback(param_00)
{
	var_01 = "";
	if(scripts\mp\_utility::func_9FB3(self.hasruggedeqp))
	{
		var_01 = "hitequip";
	}

	if(isplayer(param_00))
	{
		param_00 scripts\mp\_damagefeedback::func_12E84(var_01);
	}
}

//Function Number: 27
func_12803(param_00)
{
	if(!isdefined(self.var_12801))
	{
		self.var_12801 = [];
	}

	if(self.var_12801.size < func_12814())
	{
		if(!isdefined(param_00))
		{
			param_00 = 2;
		}

		self.var_12801[self.var_12801.size] = param_00;
	}
}

//Function Number: 28
func_1281F()
{
	if(isdefined(self.var_12801) && self.var_12801.size > 0)
	{
		var_00 = self.var_12801[self.var_12801.size - 1];
		self.var_12801[self.var_12801.size - 1] = undefined;
		return var_00;
	}

	return undefined;
}

//Function Number: 29
func_12806()
{
	self.var_12801 = undefined;
}

//Function Number: 30
func_1281A()
{
	var_00 = scripts\mp\_powers::func_D736("power_trophy");
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		func_12803();
	}
}

//Function Number: 31
func_12814()
{
	return scripts\mp\_powers::func_D736("power_trophy");
}

//Function Number: 32
trophy_modifieddamage(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		return [param_03,param_04];
	}

	if(param_03 == 0)
	{
		return [param_03,param_04];
	}

	var_05 = undefined;
	if(level.var_8B38)
	{
		switch(param_02)
		{
			case "super_trophy_mp":
			case "player_trophy_system_mp":
			case "trophy_mp":
				var_05 = 20;
				break;
		}
	}

	var_06 = param_04;
	if(isdefined(var_05))
	{
		var_06 = var_05 - param_03;
	}

	var_06 = min(var_06,param_04);
	return [param_03,param_04];
}

//Function Number: 33
trophy_cleanuponparentdeath(param_00,param_01)
{
	self endon("death");
	param_00 waittill("death");
	wait(param_01);
	self delete();
}