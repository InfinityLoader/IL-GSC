/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3380.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:26:49 AM
*******************************************************************/

//Function Number: 1
func_95B0()
{
	if(scripts\common\utility::func_6E34("pre_game_over"))
	{
		scripts\common\utility::flag_wait("pre_game_over");
	}
	else
	{
		wait(3);
	}

	level.discotrapuses = 0;
	level.var_562E = scripts\common\utility::getstructarray("discoball_switch_fx_spot","script_noteworthy");
	var_00 = scripts\common\utility::getstructarray("interaction_discoballtrap","script_noteworthy");
	level.var_562F = getent(var_00[0].target,"targetname");
	level.var_562F enablelinkto();
	level.var_5631 = scripts\common\utility::getstruct(var_00[0].target,"targetname");
	level.var_5630 = spawn("script_model",level.var_5631.origin);
	level.var_5630 setmodel("zmb_spaceland_discoball_scriptable");
	level.var_4D7C = getent("dance_floor_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_5632();
	}

	wait(1);
	level.var_4D7A = scripts\common\utility::getstructarray("dance_floor_attract_spots","targetname");
	func_E1E0();
}

//Function Number: 2
func_5632()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	for(;;)
	{
		var_01 = "power_on";
		if(var_00)
		{
			var_01 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_01 == "power_off" && !scripts\common\utility::istrue(self.var_D776))
		{
			wait(0.25);
			continue;
		}

		if(var_01 != "power_off")
		{
			self.var_D776 = 1;
			level.var_562F linkto(level.var_5630);
			getent("dance_floor","targetname") setscriptablepartstate("dance_floor","on");
			level thread scripts\cp\_vo::func_1769("dj_traps_use_nag","zmb_dj_vo",60,15,2,1);
		}
		else
		{
			self.var_D776 = 0;
			level.var_562F unlink();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 3
func_12FC2(param_00,param_01)
{
	playfx(level._effect["console_spark"],param_00.origin + (0,0,40));
	var_02 = sortbydistance(scripts\common\utility::getstructarray("dischord_start_struct","targetname"),param_01.origin);
	level.discotrapuses++;
	level.var_563D = 1;
	level.var_562D = 0;
	level.var_54AD = var_02[0];
	scripts\cp\_interaction::func_554F(param_00);
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	param_00.var_126A4 = 0;
	param_00.var_126A5 = param_01;
	disablepaspeaker("astrocade");
	playsoundatpos(level.var_5630.origin + (0,0,-100),"discoball_anc_activate");
	wait(3);
	var_03 = spawn("script_origin",level.var_5630.origin + (0,0,-100));
	scripts\common\utility::func_136F7();
	var_03 playsound("mus_zombies_trap_disco");
	level thread func_254E();
	level.var_5630 rotateyaw(2880,31);
	getent("dance_floor","targetname") setscriptablepartstate("dance_floor","active");
	wait(23.5);
	level.var_5630 playsound("trap_disco_laser_start");
	wait(1.5);
	level.var_5630 setscriptablepartstate("lasers","on");
	level thread func_27C9(level.var_562F,level.var_5630,param_01,param_00);
	wait(5.2);
	level.var_5630 playsound("trap_disco_laser_start");
	wait(0.8);
	level notify("ball_trap_done");
	level.var_5630 setscriptablepartstate("lasers","off");
	func_E1E0();
	level.var_563D = undefined;
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		param_01.var_1189F = param_00.var_126A4;
		scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
	}

	getent("dance_floor","targetname") setscriptablepartstate("dance_floor","on");
	wait(3);
	var_03 delete();
	enablepaspeaker("astrocade");
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,max(level.discotrapuses * 45,45));
}

//Function Number: 4
func_254E()
{
	level endon("ball_trap_done");
	level.var_3BAA = 0;
	level.var_4D7B = 1;
	var_00 = [];
	var_01 = spawnstruct();
	var_02 = spawnstruct();
	var_01.origin = (2824.5,-1159.5,131);
	var_02.origin = (2998.5,-1306.5,131);
	var_00 = [var_01,var_02];
	for(;;)
	{
		var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_04 = scripts\common\utility::func_782F(level.var_5630.origin,var_03,undefined,24,600);
		var_05 = sortbydistance(var_04,level.var_5630.origin);
		foreach(var_07 in var_05)
		{
			if(!scripts\cp\_utility::func_FF18(var_07) || var_07.var_152C)
			{
				continue;
			}

			if(abs(level.var_5630.origin[2] - var_07.origin[2]) > 225)
			{
				continue;
			}

			var_08 = func_78B2(var_07,var_00);
			var_07 thread func_8401(var_08);
			var_07 thread func_DF45();
		}

		wait(0.1);
	}
}

//Function Number: 5
func_78B2(param_00,param_01)
{
	var_02 = sortbydistance(param_01,param_00.origin);
	return var_02[0];
}

//Function Number: 6
func_78B3(param_00)
{
	var_01 = sortbydistance(level.var_4D7A,param_00.origin);
	foreach(var_03 in var_01)
	{
		if(!var_03.var_C2CF)
		{
			var_03.var_C2CF = 1;
			param_00.var_4D7D = var_03;
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 7
func_E1E0()
{
	foreach(var_01 in level.var_4D7A)
	{
		var_01.var_C2CF = 0;
	}
}

//Function Number: 8
func_8401(param_00)
{
	self endon("death");
	self endon("turned");
	level endon("ball_trap_done");
	self.var_152C = 1;
	self.var_EF64 = 1;
	self.var_C37F = self.var_15C;
	self method_8287(32);
	var_01 = level.var_5631.origin - param_00.origin;
	var_02 = vectortoangles(var_01);
	self.var_5273 = (0,var_02[1],0);
	if(!self istouching(level.var_4D7C))
	{
		self method_8286(param_00.origin);
		scripts\common\utility::waittill_any_3("goal","goal_reached");
	}

	if(!level.var_3BAA)
	{
		var_03 = scripts\common\utility::getstruct("dance_floor_attract_spot_center","targetname");
		self method_8286(var_03.origin);
		scripts\common\utility::waittill_any_3("goal","goal_reached");
		if(scripts\common\utility::istrue(level.var_3BAA))
		{
			param_00 = func_78B3(self);
			if(!isdefined(param_00))
			{
				var_04 = sortbydistance(level.var_4D7A,self.origin);
				self method_8286(var_04[0].origin);
				scripts\common\utility::waittill_any_3("goal","goal_reached");
			}
			else
			{
				self method_8286(param_00.origin);
				scripts\common\utility::waittill_any_3("goal","goal_reached");
			}
		}
		else
		{
			level.var_3BAA = 1;
			self.var_9B6E = 1;
		}
	}
	else
	{
		var_05 = func_78B3(self);
		if(!isdefined(var_05))
		{
			var_04 = sortbydistance(level.var_4D7A,self.origin);
			var_05 = var_04[0];
		}

		self method_8286(var_05.origin);
		scripts\common\utility::waittill_any_3("goal","goal_reached");
	}

	self.do_immediate_ragdoll = 1;
	self.var_9BB0 = 1;
}

//Function Number: 9
func_DF45()
{
	self endon("death");
	level waittill("ball_trap_done");
	if(isdefined(self.var_C37F))
	{
		self method_8287(self.var_C37F);
	}

	self.var_C37F = undefined;
	self.var_152C = 0;
	self.var_EF64 = 0;
}

//Function Number: 10
func_27C9(param_00,param_01,param_02,param_03)
{
	level endon("ball_trap_done");
	for(;;)
	{
		param_00 waittill("trigger",var_04);
		if(isdefined(var_04.var_C85F))
		{
			continue;
		}

		if(isplayer(var_04))
		{
			if(!var_04 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			if(!var_04 istouching(level.var_4D7C))
			{
				continue;
			}

			var_04.var_C85F = 1;
			var_04 dodamage(25,var_04.origin);
			var_04 thread func_E069();
			continue;
		}

		if(scripts\cp\_utility::func_FF18(var_04,undefined,1))
		{
			if(!var_04 istouching(level.var_4D7C))
			{
				continue;
			}

			var_04.var_B36E = 1;
			var_04.var_126A3 = param_02;
			param_03.var_126A4 = param_03.var_126A4 + 2;
			if(scripts\common\utility::flag("mini_ufo_green_ready"))
			{
				level.var_562D++;
			}

			if(isdefined(param_02))
			{
				var_05 = ["kill_trap_generic","kill_trap_danceparty"];
				param_02 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo","highest",10,0,0,1,20);
				if(!isdefined(param_02.trapkills["trap_danceparty"]))
				{
					param_02.trapkills["trap_danceparty"] = 1;
				}
				else
				{
					param_02.trapkills["trap_danceparty"]++;
				}

				var_04 dodamage(var_04.health + 100,var_04.origin,param_02,param_02,"MOD_UNKNOWN","iw7_discotrap_zm");
				continue;
			}

			var_04 dodamage(var_04.health + 100,var_04.origin,undefined,undefined,"MOD_UNKNOWN","iw7_discotrap_zm");
		}
	}
}

//Function Number: 11
func_E069()
{
	self endon("disconnect");
	wait(0.25);
	self.var_C85F = undefined;
}