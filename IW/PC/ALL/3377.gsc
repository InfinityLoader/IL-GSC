/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3377.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:26:48 AM
*******************************************************************/

//Function Number: 1
func_954A()
{
	var_00 = scripts\common\utility::getstructarray("bowling_for_planets","script_noteworthy");
	var_01 = 2;
	var_02 = 4;
	foreach(var_04 in var_00)
	{
		var_04 thread func_F8CC();
		var_04 thread scripts\cp\zombies\arcade_game_utility::func_12962(var_01,var_02);
		wait(0.05);
	}
}

//Function Number: 2
func_9549()
{
	var_00 = scripts\common\utility::getstructarray("bowling_for_planets_afterlife","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_F8CC();
		wait(0.05);
	}
}

//Function Number: 3
func_F8CC()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	var_01 = getentarray(self.target,"targetname");
	self.var_EC20 = [];
	self.var_11806 = [];
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "light_spot")
		{
			self.var_1B9 = var_03;
			continue;
		}

		if(var_03.classname == "trigger_multiple")
		{
			self.var_EC20[self.var_EC20.size] = var_03;
			continue;
		}

		if(var_03.classname == "script_brushmodel")
		{
			var_03 delete();
		}
	}

	var_05 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_03 in var_05)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			continue;
		}

		switch(var_03.script_noteworthy)
		{
			case "plane":
				self.var_11806[self.var_11806.size] = var_03;
				break;

			case "fx":
				self.var_5AD9 = var_03;
				break;
		}
	}

	self.var_5AD7 = 0;
	if(isdefined(self.var_1B9))
	{
		self.var_1B9 setlightintensity(0);
	}

	for(;;)
	{
		var_08 = "power_on";
		if(var_00)
		{
			var_08 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		setomnvar("zombie_arcade_skeeball_power_" + self.var_EE04,1);
		if(var_08 == "power_off" && !scripts\common\utility::istrue(self.var_D776))
		{
			wait(0.25);
			continue;
		}

		if(var_08 != "power_off")
		{
			self.var_D776 = 1;
			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(5);
			}

			if(isdefined(self.var_2BAE))
			{
				self.var_2BAE delete();
			}
		}
		else
		{
			self.var_D776 = 0;
			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(0);
			}
		}

		if(!var_00)
		{
			break;
		}
	}
}

//Function Number: 4
func_12FAB(param_00,param_01)
{
	param_01 endon("last_stand");
	param_01 endon("disconnect");
	param_01 endon("spawned");
	param_01 notify("cancel_sentry");
	param_01 notify("cancel_medusa");
	param_01 notify("cancel_trap");
	param_01 notify("cancel_boombox");
	param_01 notify("cancel_revocator");
	param_01 notify("cancel_ims");
	param_01 notify("cancel_gascan");
	scripts\cp\zombies\arcade_game_utility::func_F2C7(param_01);
	param_01.playing_game = 1;
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	level.var_13BD4 = level.wave_num;
	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("bowling_for_planets",param_01);
	}
	else
	{
		scripts\cp\zombies\zombie_analytics::func_AF8C("bowling_for_planets_afterlife",param_01);
	}

	if(!scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		param_00 notify("machine_used");
	}

	param_01 playlocalsound("arcade_insert_coin_01");
	if(!isdefined(param_00.var_10226))
	{
		param_00.var_10226 = spawn("script_origin",param_00.origin);
	}

	if(!scripts\common\utility::istrue(param_00.song_playing))
	{
		param_00.var_10226 playsound("mus_arcade_skeeball_game_start");
		level thread scripts\cp\zombies\arcade_game_utility::update_song_playing(param_00,"mus_arcade_skeeball_game_start");
	}

	param_00.var_5AD7 = 0;
	scripts\common\utility::func_136F7();
	param_00.var_10227 = 0;
	param_00.var_2802 = 3;
	param_00.var_2801 = 0;
	setomnvar("zombie_arcade_skeeball_score_" + param_00.var_EE04,0);
	setomnvar("zombie_arcade_skeeball_balls_" + param_00.var_EE04,param_00.var_2802);
	param_01 setclientomnvar("zombie_arcade_game_time",1);
	param_01 setclientomnvar("zombie_bfp_widget",1);
	param_01 thread func_CE0F(param_00);
	param_01 thread scripts\cp\zombies\arcade_game_utility::func_2111(param_01,param_00,"iw7_cpskeeball_mp",::func_10228);
	param_01 thread scripts\cp\zombies\arcade_game_utility::func_2112(param_01,param_00,"iw7_cpskeeball_mp",::func_10228,"mus_arcade_skeeball_game_end",4096);
}

//Function Number: 5
func_10228(param_00,param_01)
{
	param_01 setclientomnvar("zombie_arcade_game_time",-1);
	setomnvar("zombie_arcade_skeeball_balls_" + param_00.var_EE04,0);
	param_01 setclientomnvar("ui_hide_weapon_info",0);
	param_01 setclientomnvar("ui_securing_progress",0);
	param_01 setclientomnvar("ui_securing",0);
	param_01 setclientomnvar("zombie_bfp_widget",0);
	param_01.playing_game = undefined;
	if(param_00.var_10227 >= 1)
	{
		var_02 = param_00.var_10227 * 1;
		if(param_01.var_210E == "soul_power")
		{
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,param_00.name,1,var_02,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["bowling_for_planets_afterlife"]);
			param_01 scripts\cp\zombies\zombie_afterlife_arcade::func_8334(param_01,var_02);
			return;
		}

		scripts\cp\zombies\zombie_analytics::func_AF6E(1,param_01,level.var_13BD4,param_00.name,0,var_02,param_01.pers["timesPerWave"].var_11930[level.var_13BD4]["bowling_for_planets"]);
		param_01 scripts\cp\zombies\arcade_game_utility::func_8317(param_01,var_02);
	}
}

//Function Number: 6
func_CE0F(param_00)
{
	self notify("arcade_game_over_for_player");
	self endon("arcade_game_over_for_player");
	self endon("last_stand");
	self endon("spawned");
	self endon("disconnect");
	if(isdefined(level.start_bowling_for_planets_func))
	{
		param_00 thread [[ level.start_bowling_for_planets_func ]](param_00,self);
	}

	if(!scripts\common\utility::istrue(self.in_afterlife_arcade))
	{
		while(self getcurrentprimaryweapon() == "none" || self method_81C2())
		{
			wait(0.1);
		}
	}

	self notify("cancel_sentry");
	self notify("cancel_medusa");
	self notify("cancel_trap");
	self notify("cancel_boombox");
	self notify("cancel_revocator");
	self notify("cancel_ims");
	self notify("cancel_gascan");
	self.var_D7AB = scripts\cp\zombies\arcade_game_utility::func_EB76(self);
	scripts\common\utility::func_1C76(0);
	scripts\common\utility::func_1C6E(0);
	scripts\cp\zombies\arcade_game_utility::func_11447();
	while(param_00.var_2802 > 0)
	{
		self giveweapon("iw7_cpskeeball_mp");
		self switchtoweapon("iw7_cpskeeball_mp");
		func_1397C(param_00);
		param_00.var_2802--;
		if(param_00.var_2802 < 0)
		{
			param_00.var_2802 = 0;
		}

		setomnvar("zombie_arcade_skeeball_balls_" + param_00.var_EE04,param_00.var_2802);
		wait(0.25);
	}

	self notify("stop_too_far_check");
	while(param_00.var_2801 != 3)
	{
		wait(1);
	}

	self setclientomnvar("zombie_arcade_game_time",-1);
	self setclientomnvar("zombie_bfp_widget",0);
	self.playing_game = undefined;
	self takeweapon("iw7_cpskeeball_mp");
	param_00.var_10226 playsound("mus_arcade_skeeball_game_end");
	scripts\common\utility::func_1C76(1);
	if(!scripts\common\utility::func_9FBE())
	{
		scripts\common\utility::func_1C6E(1);
	}

	scripts\cp\zombies\arcade_game_utility::func_82F5(self);
	scripts\cp\zombies\arcade_game_utility::func_E2CB();
	if(param_00.var_10227 >= 1)
	{
		var_01 = param_00.var_10227 * 1;
		if(self.var_210E == "soul_power")
		{
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,self,level.var_13BD4,param_00.name,1,var_01,self.pers["timesPerWave"].var_11930[level.var_13BD4]["bowling_for_planets_afterlife"]);
			scripts\cp\zombies\zombie_afterlife_arcade::func_8334(self,var_01);
		}
		else
		{
			scripts\cp\zombies\zombie_analytics::func_AF6E(1,self,level.var_13BD4,param_00.name,0,var_01,self.pers["timesPerWave"].var_11930[level.var_13BD4]["bowling_for_planets"]);
			scripts\cp\zombies\arcade_game_utility::func_8317(self,var_01);
		}
	}

	scripts\common\utility::func_5127(2,::scripts\cp\_interaction::add_to_current_interaction_list,param_00);
	self notify("arcade_game_over_for_player");
}

//Function Number: 7
func_7A4F(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return "Score 10 points per basket";
	}

	return "Win 1 ticket per 10!";
}

//Function Number: 8
func_1397C(param_00)
{
	self endon("arcade_game_over_for_player");
	for(;;)
	{
		self waittill("grenade_pullback",var_01);
		if(var_01 != "iw7_cpskeeball_mp")
		{
			continue;
		}

		var_02 = spawn("script_model",param_00.origin);
		self.var_27BB = gettime();
		var_03 = param_00 scripts\cp\_utility::func_D1EB(self,1000,10000,21,undefined,1);
		self.var_278B = gettime();
		self waittill("grenade_fire",var_04,var_01);
		if(var_01 == "iw7_cpskeeball_mp")
		{
			thread func_11805(param_00,var_04,var_02);
			return;
		}
	}
}

//Function Number: 9
func_11805(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("throw_a_bowling_for_planet");
	var_06 = 0;
	param_03 = anglestoforward(self getplayerangles(1));
	param_04 = bullettrace(self geteye(),self geteye() + param_03 * 64,1,self,0,0,1);
	param_05 = scripts\common\utility::getclosest(param_04["position"],param_00.var_11806,64);
	if(!isdefined(param_05))
	{
		var_07 = self geteye();
		param_04["position"] = var_07 + param_03 * 20;
		param_04["position"] = (param_04["position"][0],param_04["position"][1],param_00.var_11806[0].origin[2]);
	}
	else
	{
		param_04["position"] = param_05.origin + (0,0,1);
	}

	param_02.origin = param_04["position"];
	param_02.angles = param_03;
	param_02 setmodel("cp_game_ball");
	var_08 = 950;
	var_09 = 600;
	var_0A = self.var_278B - self.var_27BB;
	if(var_0A < 1000)
	{
		var_0B = var_0A / 1000;
		var_09 = var_09 * var_0B;
	}

	var_09 = var_08 + var_09;
	param_02 physicslaunchserver(param_04["position"] + (0,0,0.1),param_03 * var_09);
	param_02 playsoundonmovingent("arcade_skiball_ball_throw");
	param_02 thread func_1397B(param_00,self);
	scripts\common\utility::func_136F7();
	param_01 delete();
	wait(3);
	if(isdefined(param_02))
	{
		if(!isdefined(param_02.var_46B3))
		{
			param_00.var_2801++;
		}

		param_02 delete();
	}
}

//Function Number: 10
func_1397B(param_00,param_01)
{
	self endon("arcade_game_over_for_player");
	self endon("death");
	var_02 = undefined;
	for(;;)
	{
		foreach(var_04 in param_00.var_EC20)
		{
			if(self istouching(var_04))
			{
				var_02 = var_04;
				break;
			}
		}

		if(isdefined(var_02))
		{
			break;
		}

		wait(0.05);
	}

	param_00.var_10227 = param_00.var_10227 + int(var_02.script_noteworthy);
	param_00.var_5AD7 = 0;
	param_01 notify("score_in_bowling_for_planet",int(var_02.script_noteworthy));
	setomnvar("zombie_arcade_skeeball_score_" + param_00.var_EE04,param_00.var_10227);
	param_00.var_2801++;
	self.var_46B3 = 1;
}