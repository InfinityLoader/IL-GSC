/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3387.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:26:54 AM
*******************************************************************/

//Function Number: 1
func_9713()
{
	level.rockettrapuses = 0;
	var_00 = scripts\common\utility::getstructarray("rockettrap","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_E5D9();
	}
}

//Function Number: 2
func_E5D9()
{
	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in var_00)
	{
		if(var_04.script_noteworthy == "rocket_blast_fx")
		{
			self.var_26C = var_04;
		}

		if(var_04.script_noteworthy == "rocket_blast_trigger")
		{
			self.var_4CDF = var_04;
		}
	}

	var_06 = getentarray(self.target,"targetname");
	var_07 = undefined;
	var_08 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	var_09 = "power_on";
	foreach(var_0B in var_06)
	{
		if(var_0B.classname == "light_spot")
		{
			var_07 = var_0B;
		}
	}

	var_07 setlightintensity(0);
	for(;;)
	{
		if(var_08)
		{
			var_09 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_09 != "power_off")
		{
			for(var_0D = 0;var_0D < 3;var_0D++)
			{
				var_07 setlightintensity(100);
				wait(randomfloatrange(0.5,1));
				var_07 setlightintensity(0);
				wait(randomfloatrange(0.5,1));
			}

			var_07 setlightintensity(100);
			self.var_D776 = 1;
			level thread func_E5D6();
			level thread scripts\cp\_vo::func_1769("dj_traps_use_nag","zmb_dj_vo",60,15,2,1);
		}
		else
		{
			var_07 setlightintensity(0);
			self.var_D776 = 0;
		}

		if(!var_08)
		{
			break;
		}
	}
}

//Function Number: 3
func_1300A(param_00,param_01)
{
	playfx(level._effect["console_spark"],param_00.origin + (0,0,40));
	var_02 = sortbydistance(scripts\common\utility::getstructarray("fm_start_struct","targetname"),param_01.origin);
	level.rockettrapuses++;
	level.var_E5D7 = 0;
	level.var_7047 = var_02[0];
	scripts\cp\_interaction::func_554F(param_00);
	if(!isdefined(level.var_E5D5))
	{
		level.var_E5D5 = spawn("trigger_radius",param_00.var_4CDF.origin,0,param_00.var_4CDF.var_257,128);
		level.var_E5D8 = spawn("script_origin",param_00.var_26C.origin);
	}

	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,0,0,50);
	param_00.var_126A4 = 0;
	param_00.var_126A5 = param_01;
	func_E5D3();
	level notify("rocket_idle_stop");
	scripts\common\utility::exploder(56);
	level thread func_E5D4(level.var_E5D5,param_01,param_00);
	if(scripts\common\utility::flag("mini_ufo_blue_ready"))
	{
		level thread func_13622();
	}

	level.var_E5D8 playsound("trap_rocket_start");
	wait(1.95);
	scripts\common\utility::exploder(57);
	earthquake(0.3,25,param_00.var_26C.origin,850);
	scripts\common\utility::func_136F7();
	level.var_E5D8 playloopsound("trap_rocket_lp");
	wait(21);
	level.var_E5D8 stoploopsound("trap_rocket_lp");
	level.var_E5D8 playsound("trap_rocket_stop");
	wait(0.75);
	level.var_E5D8 stoploopsound("trap_rocket_lp");
	level notify("rocket_trap_done");
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		param_01.var_1189F = param_00.var_126A4 * 2;
		scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
	}

	wait(3);
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,max(level.rockettrapuses * 45,45));
	level thread func_E5D6();
}

//Function Number: 4
func_E5D3()
{
	earthquake(0.12,4,level.var_E5D5.origin,1000);
	playsoundatpos(level.var_E5D5.origin,"trap_rocket_alarm");
	wait(1);
	playsoundatpos(level.var_E5D5.origin,"trap_rocket_alarm");
	wait(1);
}

//Function Number: 5
func_E5D4(param_00,param_01,param_02)
{
	level endon("rocket_trap_done");
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(isplayer(var_03) && isalive(var_03) && !scripts\cp\_laststand::player_in_laststand(var_03) && !isdefined(var_03.var_C85F))
		{
			var_03.var_C85F = 1;
			var_03 dodamage(35,var_03.origin,undefined,undefined,"MOD_UNKNOWN","iw7_rockettrap_zm");
			playfxontagforclients(level._effect["player_scr_fire"],var_03,"tag_eye",var_03);
			var_03 thread func_E069();
			continue;
		}

		if(scripts\cp\_utility::func_FF18(var_03,undefined,1))
		{
			if(scripts\common\utility::istrue(var_03.var_9B81))
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_03.var_9CDD))
			{
				var_03.var_9B81 = 1;
				level notify("rocket_trap_kill");
				param_02.var_126A4++;
				var_03 dodamage(var_03.health + 1000,var_03.origin,undefined,undefined,"MOD_UNKNOWN","iw7_rockettrap_zm");
				continue;
			}

			var_04 = ["kill_trap_generic","kill_trap_rocket"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_04),"zmb_comment_vo","highest",10,0,0,1,25);
			var_03.var_B36E = 1;
			var_03.var_126A3 = param_01;
			if(isdefined(param_01))
			{
				if(!isdefined(param_01.trapkills["trap_rocket"]))
				{
					param_01.trapkills["trap_rocket"] = 1;
				}
				else
				{
					param_01.trapkills["trap_rocket"]++;
				}

				param_02.var_126A4++;
				var_03 thread scripts\cp\_utility::func_4D0D(var_03,param_01,1.5,int(var_03.health + 100),"MOD_UNKNOWN","iw7_rockettrap_zm",1,"burning","rocket_trap_kill");
			}
			else
			{
				var_03 thread scripts\cp\_utility::func_4D0D(var_03,undefined,1.5,int(var_03.health + 100),"MOD_UNKNOWN","iw7_rockettrap_zm",1,"burning","rocket_trap_kill");
			}
		}
	}
}

//Function Number: 6
func_E069()
{
	self endon("disconnect");
	wait(0.25);
	self.var_C85F = undefined;
}

//Function Number: 7
func_13622()
{
	level endon("rocket_trap_done");
	for(;;)
	{
		level waittill("rocket_trap_kill");
		level.var_E5D7++;
	}
}

//Function Number: 8
func_E5D6()
{
	level endon("rocket_idle_stop");
	for(;;)
	{
		scripts\common\utility::exploder(55);
		wait(1);
	}
}