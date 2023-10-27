/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3382.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:26:49 AM
*******************************************************************/

//Function Number: 1
func_AA4B(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		param_00 notify("machine_used");
	}

	level.var_13BD4 = level.wave_num;
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("laughingclown",param_01);
	}
	else
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("laughingclown_afterlife",param_01);
	}

	if(isdefined(level.start_black_hole_func))
	{
		param_00 thread [[ level.start_black_hole_func ]](param_00,param_01);
	}

	var_02 = getentarray(param_00.target,"targetname");
	var_03 = scripts\common\utility::istrue(param_01.in_afterlife_arcade);
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	foreach(var_09 in var_02)
	{
		if(var_09.script_noteworthy == "clown_head")
		{
			var_04 = var_09;
			continue;
		}

		if(var_09.script_noteworthy == "ball_chute")
		{
			var_05 = var_09;
			continue;
		}

		if(var_09.script_noteworthy == "ball_chute_dir")
		{
			var_06 = var_09;
		}
	}

	var_0B = randomfloatrange(1,2);
	var_0C = 1;
	var_0D = 0;
	var_0E = var_06.origin + scripts\cp\_utility::func_13192(anglestoforward(var_06.angles),2);
	var_0F = spawn("script_model",var_0E);
	scripts\common\utility::func_136F7();
	var_0F playsound("arcade_blackhole_ball_release");
	var_0E = var_06.origin + scripts\cp\_utility::func_13192(anglestoforward(var_06.angles),2);
	var_0F setmodel("zmb_arcade_game_ball_small");
	var_0F.origin = var_06.origin + scripts\cp\_utility::func_13192(anglestoforward(var_06.angles),1) + (0,0,0.1);
	if(var_03)
	{
		var_0F.origin = var_06.origin + scripts\cp\_utility::func_13192(anglestoforward(var_06.angles),3) + (0,0,0.2);
	}

	var_0F physicslaunchserver(var_0E,vectornormalize(anglestoforward(var_06.angles)) * 65);
	var_10 = undefined;
	var_11 = 0;
	for(;;)
	{
		var_12 = var_0F.origin;
		wait(0.5);
		var_13 = scripts\common\utility::getstructarray(var_06.target,"targetname");
		var_10 = scripts\common\utility::getclosest(var_0F.origin,var_13,3);
		if(isdefined(var_10))
		{
			break;
		}

		if(distancesquared(var_12,var_0F.origin) < 0.05)
		{
			var_0F physicslaunchserver(var_0F.origin + (randomintrange(20,35),randomintrange(20,35),0),vectornormalize(anglestoforward(var_06.angles)) * 5);
		}

		var_11++;
		if(var_11 >= 5)
		{
			var_0F delete();
			scripts\cp\_interaction::add_to_current_interaction_list(param_00);
			return;
		}
	}

	wait(0.5);
	if(param_01 scripts\cp\_utility::is_valid_player())
	{
		param_01 playlocalsound("mp_slot_machine_coins");
	}

	if(var_03)
	{
		switch(var_10.script_noteworthy)
		{
			case "slot0":
				wait(0.25);
				param_01 playlocalsound("mp_slot_machine_coins");
				wait(0.25);
				param_01 playlocalsound("mp_slot_machine_coins");
				wait(0.5);
				func_1285F(param_01,50);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown_afterlife",1,50,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown_afterlife"]);
				break;

			case "slot1":
				wait(0.5);
				func_1285F(param_01,10);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown_afterlife",1,10,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown_afterlife"]);
				break;

			case "slot2":
				wait(0.5);
				func_1285F(param_01,5);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown_afterlife",1,5,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown_afterlife"]);
				break;

			case "slot3":
				wait(0.5);
				func_1285F(param_01,1);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown_afterlife",1,1,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown_afterlife"]);
				break;
		}
	}
	else if(param_01 scripts\cp\_utility::is_valid_player())
	{
		switch(var_10.script_noteworthy)
		{
			case "slot0":
				param_01 notify("hit_black_hole",50);
				wait(0.25);
				param_01 playlocalsound("mp_slot_machine_coins");
				wait(0.25);
				param_01 playlocalsound("mp_slot_machine_coins");
				wait(0.5);
				level notify("update_arcade_game_performance","black_hole",50);
				scripts\cp\zombies\arcade_game_utility::func_8317(param_01,50);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown",0,50,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown"]);
				break;

			case "slot1":
				param_01 notify("hit_black_hole",10);
				wait(0.5);
				scripts\cp\zombies\arcade_game_utility::func_8317(param_01,10);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown",0,10,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown"]);
				break;

			case "slot2":
				param_01 notify("hit_black_hole",5);
				wait(0.5);
				scripts\cp\zombies\arcade_game_utility::func_8317(param_01,5);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown",0,5,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown"]);
				break;

			case "slot3":
				param_01 notify("hit_black_hole",1);
				wait(0.5);
				scripts\cp\zombies\arcade_game_utility::func_8317(param_01,1);
				scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,"laughingclown",0,1,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["laughingclown"]);
				break;
		}
	}

	wait(1);
	var_0F delete();
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 2
func_1285F(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_8334(param_00,param_01);
	}
}

//Function Number: 3
func_FF2B(param_00,param_01)
{
	if(param_01 && !scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_94EE()
{
	var_00 = scripts\common\utility::getstructarray("laughingclown","script_noteworthy");
	var_01 = 4;
	var_02 = 7;
	foreach(var_04 in var_00)
	{
		var_04 thread func_9655();
		var_04 thread scripts\cp\zombies\arcade_game_utility::func_12962(var_01,var_02);
	}
}

//Function Number: 5
func_94EC()
{
	var_00 = scripts\common\utility::getstructarray("laughingclown_afterlife","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_9655();
	}
}

//Function Number: 6
func_9655()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = getentarray(self.target,"targetname");
	self.var_D63E = spawn("script_origin",self.origin + (0,0,40));
	foreach(var_07 in var_05)
	{
		if(var_07.script_noteworthy == "clown_head")
		{
			var_01 = var_07;
			continue;
		}

		if(var_07.script_noteworthy == "ball_chute")
		{
			var_02 = var_07;
			continue;
		}

		if(var_07.script_noteworthy == "ball_chute_dir")
		{
			var_03 = var_07;
			continue;
		}

		if(var_07.classname == "light_spot")
		{
			var_04 = var_07;
		}
	}

	var_03 linkto(var_02);
	var_02 linkto(var_01);
	if(isdefined(var_01))
	{
		var_01 thread func_42D6(self,var_00);
	}

	if(!var_00)
	{
		return;
	}

	for(;;)
	{
		var_09 = "power_on";
		if(var_00)
		{
			var_09 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
			if(var_09 != "power_off")
			{
				self.var_D776 = 1;
				continue;
			}

			self.var_D776 = 0;
			var_04 setlightintensity(0);
		}
	}
}

//Function Number: 7
func_42D6(param_00,param_01)
{
	self endon("stop_laughingclown");
	if(scripts\common\utility::istrue(param_01))
	{
		level scripts\common\utility::waittill_any_3("power_on",param_00.var_D71C + " power_on");
	}

	self rotateyaw(-30,0.75);
	for(;;)
	{
		var_02 = randomfloatrange(0.5,1.25);
		var_03 = randomfloat(var_02);
		var_04 = var_02 - var_03;
		self playsound("arcade_blackhole_mvmt");
		if(scripts\common\utility::istrue(param_01) && param_00.var_D776 == 0)
		{
			level scripts\common\utility::waittill_any_3("power_on",param_00.var_D71C + " power_on");
		}
		else
		{
			self waittill("rotatedone");
		}

		wait(randomfloatrange(0.1,0.25));
		self playsound("arcade_blackhole_mvmt");
		self rotateyaw(60,var_02,var_03,var_04);
		self waittill("rotatedone");
		wait(randomfloatrange(0.1,0.25));
		self rotateyaw(-60,var_02,var_03,var_04);
	}
}