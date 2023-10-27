/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_autosave.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1525 ms
 * Timestamp: 10/27/2023 12:23:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!scripts\common\utility::func_16F3("autosave",::main))
	{
		return;
	}

	level.var_2668 = spawnstruct();
	level.var_2668.var_A943 = 0;
	scripts\common\utility::flag_init("game_saving");
	scripts\common\utility::flag_init("can_save");
	scripts\common\utility::flag_set("can_save");
	scripts\common\utility::flag_init("disable_autosaves");
	scripts\common\utility::flag_init("ImmediateLevelStartSave");
	if(!isdefined(level.var_2668.var_6A42))
	{
		level.var_2668.var_6A42 = [];
	}

	level.var_2668.var_DAC8 = ::func_2674;
	func_2A6D();
}

//Function Number: 2
func_3D54()
{
	wait(2);
	level.player endon("death");
	setdvarifuninitialized("scr_savetest","0");
	for(;;)
	{
		if(getdvarint("scr_savetest") > 0)
		{
			setdvar("scr_savetest","0");
			scripts\sp\_utility::func_2669("cheat_save");
			wait(1);
		}

		wait(0.05);
	}
}

//Function Number: 3
func_7E6B()
{
	return &"AUTOSAVE_AUTOSAVE";
}

//Function Number: 4
func_7FD9(param_00)
{
	if(param_00 == 0)
	{
		var_01 = &"AUTOSAVE_GAME";
	}
	else
	{
		var_01 = &"AUTOSAVE_NOGAME";
	}

	return var_01;
}

//Function Number: 5
func_2A6D()
{
	thread immediatelevelstartsave();
	thread func_2A6E();
}

//Function Number: 6
immediatelevelstartsave()
{
	var_00 = scripts\sp\_utility::func_7F6E(level.script);
	if(!isdefined(var_00))
	{
		var_00 = 0;
	}

	var_00 = var_00 * 0.05;
	var_01 = scripts\sp\_utility::func_7E2C(level.script);
	if(!isdefined(var_01))
	{
		var_01 = 0;
	}

	var_01 = var_01 * 0.001;
	wait(var_01 + var_00 + 0.15);
	var_02 = 0;
	if(isdefined(level.var_4A3A))
	{
		var_02 = 1;
	}
	else if(level.var_B8D0)
	{
		var_02 = 1;
	}
	else if(scripts\common\utility::flag("game_saving"))
	{
		var_02 = 1;
	}

	if(var_02)
	{
		scripts\common\utility::flag_set("ImmediateLevelStartSave");
		return;
	}

	scripts\common\utility::flag_set("game_saving");
	if(!isalive(level.player))
	{
		return;
	}

	var_03 = "levelshots / autosave / autosave_" + level.script + "immediate_start";
	function_01A0("immediatelevelstart",&"AUTOSAVE_LEVELSTART",var_03,1);
	setdvar("ui_grenade_death","0");
	level.player method_8591(0);
	scripts\common\utility::func_6E2A("game_saving");
	scripts\common\utility::flag_set("ImmediateLevelStartSave");
}

//Function Number: 7
func_2A6E()
{
	if(isdefined(level.var_2A6F))
	{
		wait(level.var_2A6F);
	}
	else
	{
		wait(2);
	}

	if(isdefined(level.var_4A3A))
	{
		return;
	}

	if(level.var_B8D0)
	{
		return;
	}

	if(scripts\common\utility::flag("game_saving"))
	{
		return;
	}

	if(!scripts\common\utility::flag("ImmediateLevelStartSave"))
	{
		scripts\common\utility::flag_wait("ImmediateLevelStartSave");
		wait(1);
	}

	scripts\common\utility::flag_set("game_saving");
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	var_01 = waitfortransientloading("beginningOfLevelSave_thread()");
	if(!isdefined(var_01))
	{
		scripts\common\utility::func_6E2A("game_saving");
		return;
	}

	if(!isalive(level.player))
	{
		return;
	}

	function_01A0("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
	setdvar("ui_grenade_death","0");
	level.player method_8591(0);
	scripts\common\utility::func_6E2A("game_saving");
}

//Function Number: 8
func_12726(param_00)
{
	param_00 waittill("trigger");
	scripts\sp\_utility::func_2677();
}

//Function Number: 9
func_12727(param_00)
{
	param_00 waittill("trigger");
	scripts\sp\_utility::func_2679();
}

//Function Number: 10
func_12724(param_00)
{
	if(!isdefined(param_00.var_ED0D))
	{
		param_00.var_ED0D = 0;
	}

	func_268E(param_00);
}

//Function Number: 11
func_268E(param_00)
{
	var_01 = func_7FD9(param_00.var_ED0D);
	if(!isdefined(var_01))
	{
		return;
	}

	wait(1);
	param_00 waittill("trigger");
	var_02 = param_00.var_ED0D;
	var_03 = "levelshots / autosave / autosave_" + level.script + var_02;
	func_12891(var_02,var_01,var_03);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 12
func_268B(param_00)
{
	if(lib_0B79::func_9C4B())
	{
		return;
	}

	wait(1);
	param_00 waittill("trigger");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.var_ED0E;
	param_00 delete();
	if(isdefined(level.var_4C7F))
	{
		if(![[ level.var_4C7F ]]())
		{
			return;
		}
	}

	scripts\sp\_utility::func_2669(var_01);
}

//Function Number: 13
func_268D(param_00,param_01,param_02)
{
}

//Function Number: 14
func_1190(param_00,param_01)
{
	if(!specialistsavecheck())
	{
		return 0;
	}

	if(isdefined(level.var_B8D0) && level.var_B8D0)
	{
		return 0;
	}

	if(!isdefined(param_01) || !param_01)
	{
		level notify("trying_new_autosave");
	}

	if(scripts\common\utility::flag("game_saving"))
	{
		return 0;
	}

	scripts\common\utility::flag_set("game_saving");
	var_02 = waitfortransientloading("_autosave_game_now()");
	if(!isdefined(var_02))
	{
		scripts\common\utility::func_6E2A("game_saving");
		return 0;
	}

	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = level.players[var_03];
		if(!isalive(var_04))
		{
			return 0;
		}
	}

	var_05 = "save_now";
	var_06 = func_7E6B();
	if(getdvarint("reloading") != 0)
	{
		return 0;
	}

	if(isdefined(level.var_BF95))
	{
		return 0;
	}

	if(isdefined(param_00))
	{
		var_07 = function_01A1(var_05,var_06,"$default",1);
	}
	else
	{
		var_07 = function_01A1(var_06,var_07);
	}

	wait(0.05);
	if(function_0110())
	{
		level.var_2668.var_A943 = gettime();
		scripts\common\utility::func_6E2A("game_saving");
		return 0;
	}

	if(function_0319())
	{
		scripts\common\utility::func_6E2A("game_saving");
		return 0;
	}

	if(var_07 < 0)
	{
		scripts\common\utility::func_6E2A("game_saving");
		return 0;
	}

	if(!func_12878(var_07))
	{
		scripts\common\utility::func_6E2A("game_saving");
		return 0;
	}

	wait(2);
	scripts\common\utility::func_6E2A("game_saving");
	if(function_0319())
	{
		scripts\common\utility::func_6E2A("game_saving");
		return 0;
	}

	if(!function_004A(var_07))
	{
		return 0;
	}

	if(func_12878(var_07))
	{
		function_0049(var_07);
		level.player method_8591(0);
		setdvar("ui_grenade_death","0");
	}

	return 1;
}

//Function Number: 15
func_2671(param_00)
{
	param_00 waittill("trigger");
	scripts\sp\_utility::func_266F();
}

//Function Number: 16
func_12878(param_00)
{
	if(!function_0111())
	{
		return 0;
	}

	if(!level.player func_2688(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::func_D11B())
	{
		if(!level.var_D127 func_2689(param_00))
		{
			return 0;
		}
	}

	if(!scripts\common\utility::flag("can_save"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_12891(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(scripts\common\utility::flag("disable_autosaves"))
	{
		return 0;
	}

	if(!specialistsavecheck())
	{
		return 0;
	}

	level endon("nextmission");
	level.player endon("death");
	if(scripts\common\utility::flag("game_saving"))
	{
		return 0;
	}

	level notify("trying_new_autosave");
	if(isdefined(level.var_BF95))
	{
		return 0;
	}

	var_06 = 1.25;
	var_07 = 1.25;
	if(isdefined(param_03) && param_03 < var_06 + var_07)
	{
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = "$default";
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	scripts\common\utility::flag_set("game_saving");
	var_08 = func_7E6B();
	var_09 = gettime();
	var_0A = 0;
	for(;;)
	{
		if(func_2685(undefined,param_04))
		{
			waitfortransientloading("tryAutoSave()");
			if(getdvarint("reloading") != 0)
			{
				break;
			}

			if(isdefined(level.var_BF95))
			{
				break;
			}

			var_0A++;
			if(scripts\sp\_utility::func_93A6())
			{
				if(var_0A == 3)
				{
					break;
				}

				if(!specialistinjackal())
				{
					if(!specialistitemcheck())
					{
						break;
					}
				}
			}

			var_0B = function_01A1(param_00,var_08,param_02,param_05);
			if(var_0B < 0)
			{
				break;
			}

			wait(0.05);
			if(function_0110())
			{
				level.var_2668.var_A943 = gettime();
				break;
			}

			if(function_0319())
			{
				continue;
			}

			wait(var_06);
			if(function_0319())
			{
				continue;
			}

			if(func_6A43(var_0B))
			{
				continue;
			}

			if(!func_2685(undefined,param_04,var_0B))
			{
				continue;
			}

			wait(var_07);
			if(function_0319())
			{
				continue;
			}

			if(!func_2686(var_0B))
			{
				continue;
			}

			if(isdefined(param_03))
			{
				if(gettime() > var_09 + param_03 * 1000)
				{
					break;
				}
			}

			if(!scripts\common\utility::flag("can_save"))
			{
				break;
			}

			if(!function_004A(var_0B))
			{
				scripts\common\utility::func_6E2A("game_saving");
				return 0;
			}

			function_0049(var_0B);
			level.player method_8591(0);
			level.var_A9E7 = gettime();
			setdvar("ui_grenade_death","0");
			break;
		}

		wait(0.25);
	}

	scripts\common\utility::func_6E2A("game_saving");
	return 1;
}

//Function Number: 18
waitfortransientloading(param_00)
{
	level endon("trying_new_autosave");
	var_01 = 0;
	if(function_02B5())
	{
		while(!ispreloadzonescomplete())
		{
			if(gettime() > var_01)
			{
				var_01 = gettime() + 2000;
			}

			wait(0.05);
		}
	}

	while(function_0319())
	{
		if(gettime() > var_01)
		{
			var_01 = gettime() + 2000;
		}

		wait(0.05);
	}

	return 1;
}

//Function Number: 19
func_6A43(param_00)
{
	foreach(var_02 in level.var_2668.var_6A42)
	{
		if(![[ var_02["func"] ]]())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
func_2686(param_00)
{
	return func_2685(0,0,param_00);
}

//Function Number: 21
func_2685(param_00,param_01,param_02)
{
	if(isdefined(level.var_266C))
	{
		return [[ level.var_266C ]]();
	}

	if(isdefined(level.var_1093A) && ![[ level.var_1093A ]]())
	{
		return 0;
	}

	if(level.var_B8D0)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = level.var_5A5E;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		if(![[ level.var_83D2["_autosave_stealthcheck"] ]]())
		{
			return 0;
		}
	}

	if(scripts\common\utility::func_D11B())
	{
		if(!level.var_D127 func_2689(param_02))
		{
			return 0;
		}
	}
	else
	{
		if(!level.player func_2688(param_02))
		{
			return 0;
		}

		if(param_00 && !level.player func_2684(param_02))
		{
			return 0;
		}
	}

	if(level.var_2681)
	{
		if(!func_268F(param_00,param_02))
		{
			return 0;
		}
	}

	if(!level.player func_268C(param_00,param_02))
	{
		return 0;
	}

	if(isdefined(level.var_EB75) && !level.var_EB75)
	{
		return 0;
	}

	if(isdefined(level.var_3901) && !level.var_3901)
	{
		return 0;
	}

	if(!function_0111())
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_268C(param_00,param_01)
{
	if(self ismeleeing() && param_00)
	{
		return 0;
	}

	if(self method_81C6() && param_00)
	{
		return 0;
	}

	if(self method_819F() && param_00)
	{
		return 0;
	}

	if(isdefined(self.var_FC69) && self.var_FC69)
	{
		return 0;
	}

	if(!self islinked() && !scripts\common\utility::func_D11B() && !scripts\sp\_utility::func_93AC() && !self isonground())
	{
		if(bullettracepassed(level.player.origin + (0,0,5),level.player.origin + (0,0,-200),0,self))
		{
			return 0;
		}
	}

	if(self method_8446())
	{
		return 0;
	}

	if(scripts\common\utility::func_9DFB())
	{
		return 0;
	}

	if(isdefined(self.var_883A) && self.var_883A == 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
func_2684(param_00)
{
	var_01 = self getweaponslistprimaries();
	if(var_01.size == 0)
	{
		return 1;
	}

	var_02 = 1;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(function_0249(var_01[var_03]) > 0)
		{
			var_02 = 0;
		}

		var_04 = self getfractionmaxammo(var_01[var_03]);
		if(var_04 > 0.1)
		{
			return 1;
		}
	}

	if(var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_2688(param_00)
{
	var_01 = self.health / self.maxhealth;
	if(var_01 < 0.5)
	{
		return 0;
	}

	if(scripts\sp\_utility::func_65DB("player_has_red_flashing_overlay"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_2689(param_00)
{
	if(isdefined(self.var_5F6F))
	{
		return 0;
	}

	var_01 = scripts\sp\_utility::func_7B9D();
	if(var_01 < 0.5)
	{
		return 0;
	}

	if(isdefined(self.var_93D2) && self.var_93D2.size > 0)
	{
		return 0;
	}

	if(scripts\sp\_utility::func_A1A8("enemy_lockon"))
	{
		return 0;
	}

	if(func_268A())
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_268A(param_00)
{
	var_01 = self.var_2AC;
	var_02 = rotatevectorinverted(var_01,self.angles);
	param_00 = var_02[0];
	if(param_00 < 100)
	{
		return 0;
	}

	var_03 = param_00 * 10;
	var_03 = clamp(var_03,0,10000);
	var_04 = self.origin + anglestoforward(self.angles) * var_03;
	var_05 = scripts\common\trace::func_3A09(self.origin,var_04,200,400,self.angles,self);
	if(var_05["fraction"] < 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
func_268F(param_00,param_01)
{
	var_02 = function_0075("bad_guys","all");
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.var_10C))
		{
			continue;
		}

		if(!isplayer(var_04.var_10C))
		{
			continue;
		}

		if(isdefined(var_04.var_B55B) && isdefined(var_04.var_B55B.target) && isplayer(var_04.var_B55B.target))
		{
			return 0;
		}

		var_05 = [[ level.var_2668.var_DAC8 ]](var_04);
		if(var_05 == "return_even_if_low_accuracy")
		{
			return 0;
		}

		if(var_04.var_12F < 0.021 && var_04.var_12F > -1)
		{
			continue;
		}

		if(var_05 == "return")
		{
			return 0;
		}

		if(var_05 == "none")
		{
			continue;
		}

		var_06 = undefined;
		if(var_04.var_1491.var_A9ED > gettime() - 500)
		{
			var_06 = var_04 func_7E19();
			if(param_00 || var_06)
			{
				return 0;
			}
		}

		if(!isdefined(var_06))
		{
			var_06 = var_04 func_7E19();
		}

		if(isdefined(var_04.var_2303.var_11AC7) && var_04 lib_0A1A::func_231B(var_04.var_2303.var_11AC7,"aim") && var_06)
		{
			return 0;
		}
	}

	if(scripts\sp\_utility::func_D121())
	{
		return 0;
	}

	if(isdefined(level.var_CAF7))
	{
		foreach(var_09 in level.var_CAF7)
		{
			if(!isdefined(var_09.var_C528))
			{
				continue;
			}

			if(var_09.var_111AD == "antigrav")
			{
				continue;
			}

			if(distancesquared(var_09.origin,level.player.origin) < 122500)
			{
				return 0;
			}
		}
	}

	var_0B = getentarray("scriptable","code_classname");
	foreach(var_0D in var_0B)
	{
		if(!isdefined(var_0D.var_ED) || var_0D.var_ED != "vehicle")
		{
			continue;
		}

		if(!isdefined(var_0D.var_C528))
		{
			continue;
		}

		if(distancesquared(var_0D.origin,level.player.origin) < 160000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 28
func_7E19()
{
	return scripts\anim\utility_common::func_3907(0) && self method_8061(0);
}

//Function Number: 29
func_6489()
{
	if(self.var_12F >= 0.021)
	{
		return 1;
	}

	foreach(var_01 in level.players)
	{
		if(distance(self.origin,var_01.origin) < 500)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
func_2674(param_00)
{
	foreach(var_02 in level.players)
	{
		var_03 = distancesquared(param_00.origin,var_02.origin);
		if(var_03 < -25536)
		{
			return "return_even_if_low_accuracy";
		}
		else if(var_03 < 129600)
		{
			return "return";
		}
		else if(var_03 < 1000000)
		{
			return "threat_exists";
		}
	}

	return "none";
}

//Function Number: 31
specialistsavecheck()
{
	if(!scripts\sp\_utility::func_93A6())
	{
		return 1;
	}

	if(specialistinjackal())
	{
		return 1;
	}

	if(lib_0A2F::func_9CBB(level.var_116CC))
	{
		return 1;
	}

	if(isdefined(level.player.var_D430) && level.player.var_D430)
	{
		return 0;
	}

	if(!specialistitemcheck())
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
specialistinjackal()
{
	if(lib_0B78::func_2C97())
	{
		return 1;
	}

	if(scripts\common\utility::func_D11B())
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
specialistitemcheck()
{
	var_00 = 0;
	var_01 = 0;
	var_00 = level.player getweaponammostock("nanoshot");
	var_01 = level.player getweaponammostock("helmet");
	if(var_00 == 0)
	{
		if(level.player.var_110BD == "nanoshot")
		{
			var_00 = level.player.var_110BE;
		}
	}

	if(var_00 < 1)
	{
		return 0;
	}

	if(var_01 == 0)
	{
		if(level.player.var_110BA == "helmet")
		{
			var_01 = level.player.var_110BB;
		}
	}

	if(var_01 < 1)
	{
		return 0;
	}

	return 1;
}