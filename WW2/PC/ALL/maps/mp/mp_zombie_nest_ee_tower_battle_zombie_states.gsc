/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 874 ms
 * Timestamp: 10/27/2023 3:19:46 AM
*******************************************************************/

//Function Number: 1
func_528A()
{
	lib_0547::func_7BD0("zombie_attack_tower_lever",::func_767A,::func_767B,3.75);
	lib_0547::func_7BD0("zombie_idle_at_tower",::func_767C,::func_767D,3.25);
}

//Function Number: 2
func_8601(param_00)
{
	func_85A9();
	self.var_9ACD = "attacking point";
	thread lib_0547::func_7D1A("zombie_attack_tower_lever",[param_00]);
}

//Function Number: 3
func_85A9()
{
	if(common_scripts\utility::func_562E(self.var_C29) || !isdefined(self.var_C29))
	{
		self.var_C2A = 1;
		self.var_C29 = 0;
	}
}

//Function Number: 4
func_85AA()
{
	if(common_scripts\utility::func_562E(self.var_C2A))
	{
		self.var_C2A = undefined;
		self.var_C29 = 1;
	}
}

//Function Number: 5
func_767A(param_00)
{
	func_7679(param_00,"zombie_attack_tower_lever");
}

//Function Number: 6
func_767B(param_00)
{
	func_85AA();
	self notify("clear_tower_behavior");
}

//Function Number: 7
func_8602(param_00)
{
	self.var_9ACD = "idling at tower";
	thread lib_0547::func_7D1A("zombie_idle_at_tower",[param_00]);
}

//Function Number: 8
func_767C(param_00)
{
	thread func_7679(param_00,"idle_noncombat");
}

//Function Number: 9
func_767D()
{
	self notify("clear_tower_behavior");
}

//Function Number: 10
func_8603(param_00)
{
	func_85A9();
	self.var_9ACD = "travel to attack";
	self.var_6941 = 1;
	thread func_84E7(param_00);
}

//Function Number: 11
func_8604(param_00)
{
	self.var_9ACD = "travel to idle";
	self.var_6941 = 1;
	thread func_84E8(param_00);
}

//Function Number: 12
func_23A0()
{
	var_00 = lib_0547::func_408F();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			var_02 func_8605();
		}
	}

	foreach(var_05 in level.var_8CB)
	{
		maps/mp/mp_zombie_nest_special_event_creator_interface::func_23C4(var_05);
	}
}

//Function Number: 13
func_8605(param_00)
{
	func_85AA();
	self.var_6941 = 0;
	self.var_9B61 = undefined;
	self.var_60D0 = undefined;
	self notify("clear_tower_behavior");
	if(!common_scripts\utility::func_562E(param_00))
	{
		self.var_9ACD = "not interested";
		return;
	}

	self.var_9ACD = "ignore the tower";
}

//Function Number: 14
func_9BCF(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_00.var_9B61))
	{
		var_04 = param_00.var_9B61;
		var_04.var_65FB = param_01;
		param_00 func_8605();
		param_01 func_8603(var_04);
		var_03 = 1;
	}

	return var_03;
}

//Function Number: 15
func_84E7(param_00)
{
	self endon("death");
	self endon("clear_tower_behavior");
	self.var_9B61 = param_00;
	func_A658(param_00,32,0);
	func_8601(param_00);
}

//Function Number: 16
func_84E8(param_00)
{
	self endon("death");
	self endon("clear_tower_behavior");
	func_A658(param_00,32,0);
	func_8602(param_00);
}

//Function Number: 17
func_24E4()
{
	var_00 = lib_0547::func_408F();
	var_01 = getdvarint("scr_zombieactivatehudoutline_tower",0);
	foreach(var_03 in var_00)
	{
		if(common_scripts\utility::func_562E(var_03.var_5539))
		{
			continue;
		}

		if(!isdefined(var_03.var_9ACD))
		{
			var_04 = "";
		}
		else
		{
			var_04 = var_03.var_9ACD;
		}

		var_03 hudoutlinedisable();
		switch(var_04)
		{
			case "not interested":
				if(var_01 == 3)
				{
					var_03 hudoutlineenable(0,0);
				}
				break;

			case "travel to idle":
				if(var_01 == 3)
				{
					var_03 hudoutlineenable(0,0);
				}
				break;

			case "travel to attack":
				if(var_01 >= 2)
				{
					var_03 hudoutlineenable(2,0);
				}
				break;

			case "idling at tower":
				if(var_01 == 3)
				{
					var_03 hudoutlineenable(0,0);
				}
				break;

			case "attacking point":
				if(var_01 >= 1)
				{
					var_03 hudoutlineenable(1,0);
				}
				break;

			case "ignore the tower":
				if(var_01 == 3)
				{
					var_03 hudoutlineenable(1,0);
				}
				break;
		}
	}
}

//Function Number: 18
func_250A(param_00)
{
}

//Function Number: 19
gator_quest_debug()
{
}

//Function Number: 20
func_A7F2()
{
	return isdefined(self.var_9ACD) && self.var_9ACD == "travel to attack" || self.var_9ACD == "attacking point";
}

//Function Number: 21
func_A7F4()
{
	return isdefined(self.var_9ACD) && self.var_9ACD == "travel to idle" || self.var_9ACD == "idling at tower";
}

//Function Number: 22
func_7679(param_00,param_01)
{
	self endon("death");
	self endon("clear_tower_behavior_handled");
	thread func_49A2(level.var_7AC8);
	self.var_1D = param_00.var_1D;
	self setorigin(param_00.var_116);
	maps/mp/mp_zombie_nest_ee_util::func_8579(param_00.var_1D);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"tower_objective");
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D(param_01,undefined,1);
	for(;;)
	{
		if(common_scripts\utility::func_562E(self.var_2FDA))
		{
			func_8605(1);
			break;
		}

		var_03 = maps/mp/mp_zombie_nest_ee_util::func_7AC3(var_02);
		maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_02,var_03,1,"scripted_anim");
	}
}

//Function Number: 23
func_3E77()
{
	return !lib_053C::func_AB86() || lib_053C::func_5686();
}

//Function Number: 24
func_561E()
{
	return common_scripts\utility::func_562E(self.var_561D);
}

//Function Number: 25
func_5629()
{
	return common_scripts\utility::func_562E(self.var_98EF) || common_scripts\utility::func_562E(self.var_AC06);
}

//Function Number: 26
func_9E0E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps/mp/mp_zombie_nest_special_event_creator_interface::func_9959();
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = common_scripts\utility::func_7A33(param_01);
		if(maps/mp/mp_zombie_nest_special_event_creator_interface::func_ABD2(param_00[var_06]))
		{
			continue;
		}

		if(param_00[var_06] func_A7F2())
		{
			continue;
		}

		if(common_scripts\utility::func_562E(param_00[var_06].var_60D0))
		{
			continue;
		}

		if(!param_00[var_06] lib_0547::func_4B2C())
		{
			continue;
		}

		if(!param_00[var_06] func_5552(param_03))
		{
			continue;
		}

		if(param_00[var_06] func_561C())
		{
			continue;
		}

		if(isdefined(var_07))
		{
			var_08 = func_412A(var_07);
			var_09 = func_AB87(param_00[var_06],var_08,var_07);
			var_0A = 0;
			if(isdefined(var_09))
			{
				var_0A = func_9BCF(var_09,param_00[var_06],var_07);
			}

			if(!var_0A && func_1172(param_01) && !func_AC05(var_08,param_04))
			{
				func_9E10(param_00[var_06],var_07);
			}
		}
	}

	if(var_05)
	{
		param_00 = lib_0547::func_408F();
		foreach(var_0C in param_00)
		{
			if(!var_0C func_A7F2())
			{
				var_0C func_8605();
			}
		}
	}
}

//Function Number: 27
func_5552(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(isdefined(self.var_A4B) && self.var_A4B == param_00[var_01])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 28
func_7C0F(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		for(var_04 = 0;var_04 < param_00[var_03].var_AB4E.size;var_04++)
		{
			var_05 = param_00[var_03].var_AB4E[var_04].var_65FB;
			if(isdefined(var_05) && isalive(var_05))
			{
				if(var_05 func_3E77())
				{
					if(var_05 func_561C() || common_scripts\utility::func_562E(var_05.var_2FDA) || !var_05 func_5552(param_01))
					{
						if(common_scripts\utility::func_562E(var_05.var_2FDA) || !var_05 func_5552(param_01))
						{
							var_05 func_8605(1);
						}
						else if(var_05 func_561C())
						{
							var_05 func_8605();
						}

						var_05 notify("is_tower_battle_distracted");
						param_00[var_03].var_AB4E[var_04] func_23D5();
					}
					else
					{
						var_05 notify("is_tower_battle_focused");
						var_05 func_8419(param_00[var_03].var_AB4E[var_04]);
					}

					continue;
				}

				var_05 notify("is_tower_battle_distracted");
				var_02 = 1;
			}
		}
	}

	return var_02;
}

//Function Number: 29
func_561C()
{
	return func_5629() || func_561E();
}

//Function Number: 30
func_A658(param_00,param_01,param_02)
{
	while(distance(param_00.var_116,self.var_116) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 31
func_49A2(param_00)
{
	self endon("death");
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		thread func_A645(param_00[var_01]);
	}

	self waittill("tower_behavior_cancel_reason_found");
	self notify("clear_tower_behavior_handled");
	func_8605();
	wait 0.05;
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"tower_objective");
	self scragentsetscripted(0);
	self method_839D("gravity");
}

//Function Number: 32
func_A645(param_00)
{
	self endon("tower_behavior_cancel_reason_found");
	self endon("death");
	self waittill(param_00);
	self notify("tower_behavior_cancel_reason_found");
}

//Function Number: 33
func_AB87(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(isdefined(param_01[var_04].var_9ACD) && common_scripts\utility::func_562E(param_01[var_04].var_9ACD != "attacking point") && distance(param_00.var_116,param_02.var_116) < distance(param_01[var_04].var_116,param_02.var_116))
		{
			return param_01[var_04];
		}
	}

	return undefined;
}

//Function Number: 34
func_A63F()
{
	var_00 = 1;
	while(var_00)
	{
		var_01 = lib_0547::func_408F();
		var_00 = 0;
		foreach(var_03 in var_01)
		{
			if(!var_03 func_3E77())
			{
				var_00 = 1;
				break;
			}
		}

		wait(0.125);
	}
}

//Function Number: 35
func_10DB(param_00,param_01)
{
	var_02 = func_459C(param_01);
	var_02.var_65FB = param_00;
	param_00.var_9B61 = var_02;
	param_00 func_8604(var_02);
}

//Function Number: 36
func_AC05(param_00,param_01)
{
	return !param_00.size < param_01;
}

//Function Number: 37
func_9E10(param_00,param_01)
{
	var_02 = func_9E0B(param_01);
	if(isdefined(var_02))
	{
		func_10CD(param_00,var_02,self);
	}
}

//Function Number: 38
func_ABF5(param_00)
{
	return !param_00 func_A7F4() || param_00 func_A7F2();
}

//Function Number: 39
func_1172(param_00)
{
	return param_00.size > 0;
}

//Function Number: 40
func_50A4()
{
	return isdefined(self.var_9ACD) && common_scripts\utility::func_562E(self.var_9ACD == "ignore the tower");
}

//Function Number: 41
func_8419(param_00)
{
	if(!isdefined(self.var_9ACD) || !self.var_9ACD == "travel to attack" || self.var_9ACD == "attacking point")
	{
		func_8603(param_00);
	}
}

//Function Number: 42
func_23D5()
{
	self.var_65FB = undefined;
}

//Function Number: 43
func_412A(param_00)
{
	var_01 = 0;
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.var_AB4E.size;var_03++)
	{
		var_04 = param_00.var_AB4E[var_03].var_65FB;
		if(isdefined(var_04) && isalive(var_04))
		{
			var_02 = common_scripts\utility::func_F6F(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 44
func_8F14(param_00,param_01)
{
	foreach(var_03 in level.var_744A)
	{
		if(distance(param_00,var_03.var_116) < param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 45
func_425A(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = lib_0547::func_4090(param_00[var_03]);
		var_02 = common_scripts\utility::func_F73(var_02,var_04);
	}

	var_02 = common_scripts\utility::func_40B0(param_01,var_02);
	return var_02;
}

//Function Number: 46
func_4082(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02] maps/mp/mp_zombie_nest_ee_util::func_442B();
		if(isdefined(var_03))
		{
			var_01 = common_scripts\utility::func_F6F(var_01,param_00[var_02]);
		}
	}

	return var_01;
}

//Function Number: 47
func_10CD(param_00,param_01,param_02)
{
	if(!func_7590(param_00,param_01.var_7588.var_AB4E))
	{
		param_00.var_9B61 = param_01.var_9110;
		param_00.var_60D0 = 1;
		param_01.var_9110.var_65FB = param_00;
	}
}

//Function Number: 48
func_52DD(param_00)
{
	for(var_01 = 0;var_01 < self.size;var_01++)
	{
		var_02 = param_00.var_38C4["objectiveHealth"];
		self[var_01].var_AB4E = common_scripts\utility::func_46B7(self[var_01].var_1A2,"targetname");
		for(var_03 = 0;var_03 < self[var_01].var_AB4E.size;var_03++)
		{
			self[var_01].var_AB4E[var_03].var_38B2 = param_00.var_38C3;
			self[var_01].var_AB4E[var_03].var_69A5 = 0;
		}

		self[var_01].var_28FC = 0;
		self[var_01].var_28FF = var_02;
		self[var_01].var_6057 = var_02;
		if(isdefined(self[var_01].var_65E8))
		{
			foreach(var_05 in self[var_01].var_65E8)
			{
				var_06 = common_scripts\utility::func_4461(var_05.var_116,param_00.var_ABEA.var_1176,250);
				if(isdefined(var_06))
				{
					var_05.var_65DE = var_06;
				}
			}
		}
	}
}

//Function Number: 49
func_459C(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01] maps/mp/mp_zombie_nest_ee_util::func_996A())
		{
			return param_00[var_01];
		}
	}

	return common_scripts\utility::func_7A33(param_00);
}

//Function Number: 50
func_7590(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_01[var_02] func_7591(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 51
func_7591(param_00)
{
	return isdefined(self.var_65FB) && isalive(self.var_65FB) && self.var_65FB == param_00;
}

//Function Number: 52
func_9E0B(param_00)
{
	var_01 = spawnstruct();
	var_01.var_7588 = param_00;
	var_01.var_9110 = var_01.var_7588 maps/mp/mp_zombie_nest_ee_util::func_442B();
	if(isdefined(var_01.var_7588) && isdefined(var_01.var_9110))
	{
		return var_01;
	}

	return undefined;
}