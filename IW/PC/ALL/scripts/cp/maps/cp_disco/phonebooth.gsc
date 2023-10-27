/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\phonebooth.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 2048 ms
 * Timestamp: 10/27/2023 12:04:34 AM
*******************************************************************/

//Function Number: 1
hint_phonebooth(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_00.var_D776))
	{
		return &"CP_DISCO_INTERACTIONS_PHONEBOOTH_USE";
	}

	return &"COOP_INTERACTIONS_REQUIRES_POWER";
}

//Function Number: 2
init_phonebooth()
{
	level.var_CACC = spawnstruct();
	level.var_CACC.numbers["666"] = ::beast;
	level.var_CACC.numbers["369686337"] = ::downunder;
	level.var_CACC.numbers["49"] = ::iw;
	level.var_CACC.numbers["736348"] = ::sendit;
	level.var_CACC.numbers["69"] = ::prank;
	level.var_CACC.numbers["2333"] = ::burgertown;
	level.var_CACC.numbers["7399"] = ::crystal;
	level.var_CACC.numbers["3323"] = ::deadwoman;
	level.var_CACC.numbers["34726"] = ::disco;
	level.var_CACC.numbers["411"] = ::func_94B8;
	level.var_CACC.numbers["0"] = ::operator;
	level.var_CACC.numbers["911"] = ::emergency;
	level.var_CACC.numbers["232"] = ::cdc;
	level.var_CACC.numbers["9328437"] = ::weather;
	level.var_CACC.numbers["5550152"] = ::skullbuster;
	snd_setup();
	level.var_CACC.booths = [];
	foreach(var_01 in scripts\common\utility::getstructarray("phonebooth","script_noteworthy"))
	{
		var_01 thread init_phone();
		wait(0.1);
	}
}

//Function Number: 3
beast()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = randomint(2);
	var_01 = undefined;
	switch(var_00)
	{
		case 0:
			var_01 = "beast_01";
			break;

		case 1:
			var_01 = "beast_02";
			break;
	}

	playlocalsound_phone(var_01,1,1);
}

//Function Number: 4
downunder()
{
	thread playlocalsound_phone("ring_foreign");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_foreign");
	playlocalsound_phone("downunda");
}

//Function Number: 5
iw()
{
	wait(2);
	playlocalsound_phone("busy");
}

//Function Number: 6
sendit()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	playlocalsound_phone("payphone_plr_fax_modem");
}

//Function Number: 7
prank()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = randomint(5);
	var_01 = undefined;
	switch(var_00)
	{
		case 1:
		case 0:
			var_01 = "prank_call_02";
			break;

		case 2:
			var_01 = "prank_call_03";
			break;

		case 3:
			var_01 = "prank_call_04";
			break;

		case 4:
			var_01 = "prank_call_05";
			break;

		default:
			var_01 = "prank_call_05";
			break;
	}

	playlocalsound_phone(var_01,1,1);
}

//Function Number: 8
burgertown()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = "burger_town";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 9
crystal()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = "crystal";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 10
deadwoman()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = "dead_woman";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 11
disco()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = "disco";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 12
func_94B8()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(2.2,5.5));
	stoplocalsound_phone("ring_usa");
	var_00 = "info";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 13
operator()
{
	var_00 = undefined;
	var_01 = randomint(9);
	switch(var_01)
	{
		case 0:
			var_00 = "operator_01";
			break;

		case 1:
			var_00 = "operator_02";
			break;

		case 2:
			var_00 = "operator_03";
			break;

		case 3:
			var_00 = "operator_04";
			break;

		case 4:
			var_00 = "operator_05";
			break;

		case 5:
			var_00 = "operator_06";
			break;

		case 6:
			var_00 = "operator_07";
			break;

		case 7:
			var_00 = "operator_08";
			break;

		case 8:
			var_00 = "operator_09";
			break;
	}

	playlocalsound_phone(var_00,1,1);
}

//Function Number: 14
emergency()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(6,10));
	stoplocalsound_phone("ring_usa");
	var_00 = "911";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 15
cdc()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(6,10));
	stoplocalsound_phone("ring_usa");
	var_00 = "cdc";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 16
weather()
{
	thread playlocalsound_phone("ring_usa");
	wait(randomfloatrange(6,10));
	stoplocalsound_phone("ring_usa");
	var_00 = "weather";
	playlocalsound_phone(var_00,1,1);
}

//Function Number: 17
skullbuster()
{
	var_00 = getomnvar("zm_num_ghost_n_skull_coin");
	if(scripts\common\utility::istrue(level.skullbuster_service_available) && isdefined(var_00) && var_00 >= 5)
	{
		thread playlocalsound_phone("ring_usa");
		wait(randomfloatrange(2.2,5.5));
		stoplocalsound_phone("ring_usa");
		playlocalsound_phone("prank_call_01",1,1);
		level notify("skullbuster_service_called");
		return;
	}

	wait(2);
	playlocalsound_phone("busy");
}

//Function Number: 18
phonebooth_update_scriptable_state(param_00)
{
	if(!isdefined(param_00.pb_scriptable))
	{
		return;
	}

	if(!isdefined(param_00.var_D776) || param_00.var_D776 == 0)
	{
		param_00.pb_scriptable setscriptablepartstate("phonebooth","power_off");
		return;
	}

	if(isdefined(param_00.quest_state))
	{
		if(param_00.quest_state == 1)
		{
			param_00.pb_scriptable setscriptablepartstate("phonebooth","power_red");
			return;
		}

		param_00.pb_scriptable setscriptablepartstate("phonebooth","power_on");
		return;
	}

	param_00.pb_scriptable setscriptablepartstate("phonebooth","power_on");
}

//Function Number: 19
update_all_phonebooth_scriptable_states()
{
	foreach(var_01 in level.var_CACC.booths)
	{
		phonebooth_update_scriptable_state(var_01);
	}
}

//Function Number: 20
init_phone()
{
	level.var_CACC.booths[level.var_CACC.booths.size] = self;
	self.linkpoint_struct = undefined;
	self.keypad_buttons = [];
	self.quest_state = 0;
	foreach(var_01 in scripts\common\utility::getstructarray(self.target,"targetname"))
	{
		if(var_01.var_EE79 == "linkpoint")
		{
			self.linkpoint_struct = var_01;
		}
	}

	self.keypad_frame = undefined;
	foreach(var_04 in getentarray(self.target,"targetname"))
	{
		if(var_04.classname == "script_model")
		{
			self.keypad_frame = var_04;
			self.keypad_frame.var_10CE2 = var_04.origin;
			for(var_05 = 0;var_05 < 12;var_05++)
			{
				var_06 = undefined;
				var_07 = undefined;
				var_08 = undefined;
				var_09 = undefined;
				if(var_05 == 10)
				{
					var_06 = "tag_key_star";
					var_07 = "cp_disco_payphone_key_star";
					var_08 = "*";
					var_09 = 10;
				}
				else if(var_05 == 11)
				{
					var_06 = "tag_key_pound";
					var_07 = "cp_disco_payphone_key_pound";
					var_08 = "#";
					var_09 = 11;
				}
				else
				{
					var_06 = "tag_key_" + var_05;
					var_07 = "cp_disco_payphone_key_" + var_05;
					var_08 = "" + var_05;
					var_09 = var_05;
				}

				var_01 = spawnstruct();
				var_01.keypos = var_04 gettagorigin(var_06);
				var_01.keyang = var_04 gettagangles(var_06);
				var_01.var_1F2 = var_07;
				var_01.var_A59F = var_08;
				var_01.keyvalue = var_09;
				self.keypad_buttons[var_05] = var_01;
			}
		}

		if(issubstr(var_04.classname,"scriptable"))
		{
			self.pb_scriptable = var_04;
		}
	}

	if(isdefined(level.players))
	{
		foreach(var_0C in level.players)
		{
			if(isdefined(self.keypad_frame))
			{
				self.keypad_frame method_8429(var_0C);
			}
		}
	}

	if(scripts\common\utility::istrue(self.var_E1B9))
	{
		var_0E = undefined;
		if(isdefined(self.script_area))
		{
			var_0E = self.script_area;
		}
		else
		{
			var_0E = scripts\cp\_interaction::func_7829(self);
		}

		if(isdefined(var_0E))
		{
			level scripts\common\utility::waittill_any_3("power_on",var_0E + " power_on");
		}
	}

	self.var_D776 = 1;
	phonebooth_update_scriptable_state(self);
}

//Function Number: 21
snd_setup()
{
	var_00["0"] = "payphone_plr_button_press_0";
	var_00["1"] = "payphone_plr_button_press_1";
	var_00["2"] = "payphone_plr_button_press_2";
	var_00["3"] = "payphone_plr_button_press_3";
	var_00["4"] = "payphone_plr_button_press_4";
	var_00["5"] = "payphone_plr_button_press_5";
	var_00["6"] = "payphone_plr_button_press_6";
	var_00["7"] = "payphone_plr_button_press_7";
	var_00["8"] = "payphone_plr_button_press_8";
	var_00["9"] = "payphone_plr_button_press_9";
	var_00["#"] = "payphone_plr_button_press_pound";
	var_00["*"] = "payphone_plr_button_press_star";
	var_00["ring_usa"] = "payphone_plr_ringing_usa_oneshot";
	var_00["ring_foreign"] = "payphone_plr_ringing_foreign_oneshot";
	var_00["coin_insert"] = "payphone_plr_start_insert_coin";
	var_00["coin_return_denied"] = "payphone_plr_denied_use";
	var_00["coin_return"] = "payphone_plr_end_hangup_coin_returned";
	var_00["coin_accept"] = "payphone_plr_end_hangup_coin_deposited";
	var_00["busy"] = "payphone_plr_busy_oneshot";
	var_00["invalid_number"] = "payphone_plr_wrong_number_pickup";
	var_00["payphone_plr_fax_modem"] = "payphone_plr_fax_modem";
	var_00["receiver_pickup"] = "payphone_plr_start_pickup_receiver";
	var_00["receiver_hangup"] = "payphone_plr_end_hangup_receiver";
	var_00["timeout_vo"] = "payphone_plr_timeout_start";
	var_00["timeout_tone"] = "payphone_plr_timeout_oneshot";
	var_00["prank_call_01"] = "disco_phone_prankcall_01";
	var_00["prank_call_02"] = "disco_phone_prankcall_02";
	var_00["prank_call_03"] = "disco_phone_prankcall_03";
	var_00["prank_call_04"] = "disco_phone_prankcall_04";
	var_00["prank_call_05"] = "disco_phone_prankcall_05";
	var_00["prank_call_06"] = "disco_phone_prankcall_06";
	var_00["burger_town"] = "disco_phone_burgertown_01";
	var_00["crystal"] = "disco_phone_crystal_01";
	var_00["dead_woman"] = "disco_phone_deadwoman_01";
	var_00["disco"] = "disco_phone_disco_01";
	var_00["beast_01"] = "disco_phone_beast_01";
	var_00["beast_02"] = "disco_phone_beast_02";
	var_00["info"] = "disco_phone_infohotline_01";
	var_00["operator_01"] = "disco_phone_operator_01";
	var_00["operator_02"] = "disco_phone_operator_02";
	var_00["operator_03"] = "disco_phone_operator_03";
	var_00["operator_04"] = "disco_phone_operator_04";
	var_00["operator_05"] = "disco_phone_operator_05";
	var_00["operator_06"] = "disco_phone_operator_06";
	var_00["operator_07"] = "disco_phone_operator_07";
	var_00["operator_08"] = "disco_phone_operator_08";
	var_00["operator_09"] = "disco_phone_operator_09";
	var_00["cdc"] = "disco_phone_operator_10";
	var_00["911"] = "disco_phone_operator_11";
	var_00["weather"] = "disco_phone_operator_15";
	var_00["downunda"] = "payphone_plr_australia_didgeridoo";
	level.var_CACC.var_1047D = var_00;
}

//Function Number: 22
use_phonebooth(param_00,param_01)
{
	if(!isdefined(param_00.keypad_frame))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	foreach(var_03 in level.players)
	{
		if(var_03 == param_01)
		{
			continue;
		}

		if(distancesquared(var_03.origin,param_00.linkpoint_struct.origin) < 4096)
		{
			param_01 playlocalsound("perk_machine_deny");
			return;
		}
	}

	scripts\cp\_interaction::func_554F(param_00);
	param_01.var_9D81 = 1;
	param_01 notify("force_cancel_placement");
	var_05 = 1;
	if(isdefined(level.phone_preuse_func))
	{
		var_05 = [[ level.phone_preuse_func ]]();
	}

	if(isdefined(level.phone_puzzle_phone) && param_00 == level.phone_puzzle_phone)
	{
		phone_puzzle_call(param_00,param_01);
		var_05 = 0;
	}

	if(var_05)
	{
		param_01._phone_sounds_played = [];
		param_01._phone_sounds_active = [];
		param_01 thread snd_phone_intro();
		param_00.var_AD3C = spawn("script_model",param_00.linkpoint_struct.origin);
		param_00.var_AD3C setmodel("tag_origin");
		param_00.var_AD3C.angles = param_00.linkpoint_struct.angles;
		param_01 playerlinktodelta(param_00.var_AD3C,"tag_origin",1,0,0,0,0);
		var_06 = 0.1;
		var_07 = param_01 getstance();
		if(var_07 == "prone")
		{
			var_06 = 0.7;
		}
		else if(var_07 == "crouch")
		{
			var_06 = 0.3;
		}

		param_01 scripts\common\utility::func_1C60(0);
		param_01 scripts\common\utility::func_1C40(0);
		param_01 method_800C(0);
		param_01 scripts\common\utility::func_1C58(0);
		foreach(var_03 in level.players)
		{
			if(var_03 == param_01)
			{
				param_00.keypad_frame showtoplayer(var_03);
				continue;
			}

			param_00.keypad_frame method_8429(var_03);
		}

		param_01 clear_phone_omnvars_for_player();
		param_01 setclientomnvar("zm_ui_dialpad_ent",param_00.keypad_frame);
		foreach(var_0B in param_00.keypad_buttons)
		{
			if(!isdefined(var_0B.model))
			{
				var_0C = spawn("script_model",var_0B.keypos);
				var_0C setmodel(var_0B.var_1F2);
				var_0C.origin = var_0B.keypos;
				var_0C.angles = var_0B.keyang;
				var_0B.model = var_0C;
				foreach(var_03 in level.players)
				{
					if(var_03 == param_01)
					{
						var_0B.model showtoplayer(var_03);
						continue;
					}

					var_0B.model method_8429(var_03);
				}
			}
		}

		var_10 = use_phone_keypad(param_00,param_01,var_06);
		if(isdefined(param_01))
		{
			param_01 thread snd_phone_outro(var_10);
			param_01 scripts\common\utility::waittill_any_3("exit_phonebooth","phone_outro_end");
		}

		if(isdefined(param_01))
		{
			param_01.var_9D81 = undefined;
		}

		wait(0.1);
		foreach(var_0B in param_00.keypad_buttons)
		{
			if(isdefined(var_0B.model))
			{
				if(isdefined(param_01))
				{
					scripts\cp\_outline::func_5561(var_0B.model,param_01);
				}

				var_0B.model delete();
			}
		}

		if(isdefined(param_01))
		{
			param_01 scripts\common\utility::func_1C60(1);
			param_01 scripts\common\utility::func_1C40(1);
			param_01 method_800C(1);
			param_01 scripts\common\utility::func_1C58(1);
			param_01 unlink();
			foreach(var_03 in level.players)
			{
				param_00.keypad_frame method_8429(var_03);
			}
		}

		param_00.var_AD3C delete();
		if(isdefined(param_01))
		{
			param_01 clear_phone_omnvars_for_player();
			param_01 stoplocalsoundall();
			param_01 thread playlocalsound_phone("receiver_hangup");
			if(!isdefined(var_10) || var_10 == "invalid_number")
			{
				param_01 thread playlocalsound_phone("coin_return",0);
				playsoundatpos(param_00.origin,"payphone_npc_end_hangup_coin_returned");
			}
			else
			{
				param_01 thread playlocalsound_phone("coin_accept",0);
				playsoundatpos(param_00.origin,"payphone_npc_end_hangup_coin_deposited");
			}

			param_01._phone_sounds_played = undefined;
			param_01._phone_sounds_active = undefined;
			param_01._phone_exit_move = undefined;
			param_01._phone_exit_damage = undefined;
			param_01 notify("phonebooth_end");
		}
	}

	scripts\cp\_interaction::func_9A0D(param_00,1);
	scripts\cp\_interaction::func_6214(param_00);
}

//Function Number: 23
snd_phone_intro(param_00)
{
	self endon("exit_phonebooth");
	self endon("dialed");
	if(!isdefined(param_00))
	{
		playlocalsound_phone("receiver_pickup");
	}
	else
	{
		thread playlocalsound_phone("payphone_npc_start_pickup_receiver");
		wait(10.358);
	}

	self notify("timeout");
}

//Function Number: 24
snd_phone_outro(param_00)
{
	self endon("phonebooth_end");
	self endon("exit_phonebooth");
	self notify("stop_delay_thread");
	stoplocalsoundall();
	if(!scripts\common\utility::istrue(self._phone_exit_move) && !scripts\common\utility::istrue(self._phone_exit_damage))
	{
		if(!isdefined(param_00))
		{
			playlocalsound_phone("operator_05");
			playlocalsound_phone("timeout_tone");
		}
		else if(param_00 == "invalid_number")
		{
			thread playlocalsound_phone("invalid_number");
			wait(8);
			playlocalsound_phone("timeout_tone");
		}
	}

	scripts\common\utility::func_136F7();
	self notify("phone_outro_end");
}

//Function Number: 25
use_phone_keypad(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_01 endon("left_stick_moved");
	param_01 endon("exit_phonebooth");
	param_01 endon("timeout");
	param_01 thread phone_exit_move();
	param_01 thread phone_exit_damage();
	wait(param_02);
	var_03 = param_01 geteye();
	foreach(var_05 in param_00.keypad_buttons)
	{
		var_05.var_13191 = vectornormalize(var_05.keypos - var_03);
	}

	param_01 thread phone_hilight_focused_button(param_00,param_01);
	param_01 thread phone_exit_look(param_00);
	param_01 method_81DF(0.05,0,0,30,30,30,30);
	param_01 notifyonplayercommand("use_button_pressed","+usereload");
	param_01 notifyonplayercommand("use_button_pressed","+activate");
	param_01 notifyonplayercommand("use_button_pressed","+attack");
	param_01 notifyonplayercommand("use_button_released","-usereload");
	param_01 notifyonplayercommand("use_button_released","-activate");
	param_01 notifyonplayercommand("use_button_released","-attack");
	param_01 notifyonplayercommand("exit_phonebooth","+stance");
	param_01 notifyonplayercommand("exit_phonebooth","+goStand");
	param_01 notifyonplayercommand("exit_phonebooth","+melee_zoom");
	param_01 notifyonplayercommand("exit_phonebooth","+breath_sprint");
	param_01 notifyonplayercommand("exit_phonebooth","+frag");
	param_01 notifyonplayercommand("exit_phonebooth","+smoke");
	var_07 = [];
	var_08 = undefined;
	var_09 = 0;
	for(;;)
	{
		var_0A = undefined;
		param_01 childthread phone_exit_timeout();
		param_01 waittill("use_button_pressed");
		if(!param_01 scripts\cp\_utility::is_valid_player())
		{
			return;
		}

		var_0B = anglestoforward(param_01 getplayerangles());
		foreach(var_0D in param_00.keypad_buttons)
		{
			var_0E = vectordot(var_0B,var_0D.var_13191);
			if(var_0E > 0.999)
			{
				param_01 notify("dialed");
				param_01 notify("stop_delay_thread");
				param_01 thread stoplocalsound_phone("receiver_pickup");
				var_0A = var_0D.var_A59F;
				var_0F = var_0D.keyvalue;
				param_01 thread playlocalsound_phone(var_0A);
				if(isdefined(var_08))
				{
					var_08 = var_08 + var_0A;
				}
				else
				{
					var_08 = var_0A;
				}

				var_07[var_09] = var_0F;
				var_09++;
				break;
			}
		}

		for(var_11 = 0;var_11 < var_07.size;var_11++)
		{
			var_12 = "zm_ui_dialpad_" + 9 - var_11;
			param_01 setclientomnvar(var_12,var_07[var_07.size - var_11 - 1]);
		}

		var_13 = gettime();
		param_01 waittill("use_button_released");
		var_14 = gettime();
		var_15 = var_14 - var_13;
		if(var_15 < 250)
		{
			var_16 = 250 - var_15 / 1000;
			if(var_16 >= 0.05)
			{
				wait(var_16);
			}
		}

		if(isdefined(var_0A))
		{
			param_01 stoplocalsound_phone(var_0A);
		}
		else
		{
			continue;
		}

		foreach(var_19, var_18 in level.var_CACC.numbers)
		{
			if(var_08 == var_19)
			{
				param_01 notify("dial_complete");
				param_01 stoplocalsoundall();
				param_01 notify("stop_delay_thread");
				param_01 [[ var_18 ]]();
				return "valid";
			}
		}

		if(var_09 >= 9)
		{
			return "invalid_number";
		}
	}
}

//Function Number: 26
clear_phone_omnvars_for_player()
{
	self setclientomnvar("zm_ui_dialpad_ent",undefined);
	self setclientomnvar("zm_ui_dialpad_0",12);
	self setclientomnvar("zm_ui_dialpad_1",12);
	self setclientomnvar("zm_ui_dialpad_2",12);
	self setclientomnvar("zm_ui_dialpad_3",12);
	self setclientomnvar("zm_ui_dialpad_4",12);
	self setclientomnvar("zm_ui_dialpad_5",12);
	self setclientomnvar("zm_ui_dialpad_6",12);
	self setclientomnvar("zm_ui_dialpad_7",12);
	self setclientomnvar("zm_ui_dialpad_8",12);
	self setclientomnvar("zm_ui_dialpad_9",12);
}

//Function Number: 27
phone_hilight_focused_button(param_00,param_01)
{
	param_01 endon("phonebooth_end");
	param_01 endon("disconnect");
	for(;;)
	{
		var_02 = anglestoforward(param_01 getplayerangles());
		var_03 = 0;
		foreach(var_05 in param_00.keypad_buttons)
		{
			var_06 = vectordot(var_02,var_05.var_13191);
			if(var_06 > 0.999 && !var_03)
			{
				scripts\cp\_outline::func_6220(var_05.model,param_01,1,1,0,"low");
				var_03 = 1;
				continue;
			}

			scripts\cp\_outline::func_5561(var_05.model,param_01);
		}

		wait(0.05);
	}
}

//Function Number: 28
phone_exit_move()
{
	self endon("phonebooth_end");
	self endon("disconnect");
	var_00 = 0;
	for(;;)
	{
		var_01 = self getnormalizedmovement();
		if(var_01[0] != 0 || var_01[1] != 0)
		{
			var_00++;
			if(var_00 == 3)
			{
				self._phone_exit_move = 1;
				self notify("exit_phonebooth");
			}
		}
		else
		{
			var_00 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 29
phone_exit_look(param_00)
{
	self endon("disconnect");
	self endon("phonebooth_end");
	var_01 = anglestoforward(param_00.var_AD3C.angles);
	for(;;)
	{
		var_02 = anglestoforward(self getplayerangles());
		if(scripts\common\utility::func_1E7C(var_02,var_01) >= 30)
		{
			self._phone_exit_move = 1;
			self notify("exit_phonebooth");
		}

		wait(0.1);
	}
}

//Function Number: 30
phone_exit_damage()
{
	self endon("disconect");
	self endon("phonebooth_end");
	self waittill("damage");
	self._phone_exit_damage = 1;
	self notify("exit_phonebooth");
}

//Function Number: 31
phone_exit_timeout()
{
	self endon("disconect");
	self notify("stop_timeout");
	self endon("dial_complete");
	self endon("stop_timeout");
	wait(7);
	self notify("timeout");
}

//Function Number: 32
playlocalsound_phone(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconect");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	param_02 = 0;
	if(scripts\common\utility::istrue(param_01) && self._phone_sounds_played.size > 0)
	{
		foreach(var_04 in self._phone_sounds_played)
		{
			stoplocalsound_phone(var_04);
		}

		self._phone_sounds_played = [];
	}

	if(!isdefined(level.var_CACC.var_1047D[param_00]))
	{
		return;
	}

	if(issubstr(level.var_CACC.var_1047D[param_00],"_lp"))
	{
		if(isdefined(self._phone_sounds_played))
		{
			self._phone_sounds_played[self._phone_sounds_played.size] = param_00;
			self._phone_sounds_active[self._phone_sounds_active.size] = param_00;
		}

		scripts\cp\_utility::func_CD85(level.var_CACC.var_1047D[param_00]);
		self waittill("stop_loop");
		if(isdefined(self._phone_sounds_active))
		{
			self._phone_sounds_active = scripts\common\utility::func_22A9(self._phone_sounds_active,param_00);
			return;
		}

		return;
	}

	if(param_02)
	{
		return;
	}

	if(isdefined(self._phone_sounds_played))
	{
		self._phone_sounds_played[self._phone_sounds_played.size] = param_00;
		self._phone_sounds_active[self._phone_sounds_active.size] = param_00;
	}

	self playlocalsound(level.var_CACC.var_1047D[param_00],"sounddone","stop_" + param_00);
	var_06 = lookupsoundlength(level.var_CACC.var_1047D[param_00]);
	wait(var_06 / 1000 + 0.05);
	if(isdefined(self._phone_sounds_active))
	{
		self._phone_sounds_active = scripts\common\utility::func_22A9(self._phone_sounds_active,param_00);
		return;
	}
}

//Function Number: 33
stoplocalsound_phone(param_00)
{
	if(!isdefined(level.var_CACC.var_1047D[param_00]))
	{
		return;
	}

	if(issubstr(level.var_CACC.var_1047D[param_00],"_lp"))
	{
		self stoploopsound(level.var_CACC.var_1047D[param_00]);
	}
	else
	{
		self stoplocalsound(level.var_CACC.var_1047D[param_00]);
	}

	self notify("stop_" + param_00);
	if(isdefined(self._phone_sounds_played))
	{
		self._phone_sounds_active = scripts\common\utility::func_22A9(self._phone_sounds_active,param_00);
	}
}

//Function Number: 34
stoplocalsoundall()
{
	stop_secondary_aliases();
	if(self._phone_sounds_played.size == 0)
	{
		return;
	}

	foreach(var_01 in self._phone_sounds_played)
	{
		thread stoplocalsound_phone(var_01);
	}

	self._phone_sounds_played = [];
}

//Function Number: 35
stop_secondary_aliases()
{
	self stoplocalsound("payphone_plr_start_dialtone_initial");
	self stoplocalsound("payphone_plr_start_insert_coin");
	self stoplocalsound("payphone_plr_wrong_number_vo");
	self stoplocalsound("payphone_plr_timeout_vo");
}

//Function Number: 36
phone_puzzle_call(param_00,param_01)
{
	level notify("puzzle_phone_answered");
	level endon("puzzle_phone_reset");
	var_02 = 1;
	param_00 notify("phone_answered");
	if(var_02)
	{
		param_01._phone_sounds_played = [];
		param_01._phone_sounds_active = [];
		param_01 thread snd_phone_intro(1);
		scripts\cp\_utility::func_D52A("payphone_npc_start_pickup_receiver",param_00.linkpoint_struct.origin);
		param_00.var_AD3C = spawn("script_model",param_00.linkpoint_struct.origin);
		param_00.var_AD3C setmodel("tag_origin");
		param_00.var_AD3C.angles = param_00.linkpoint_struct.angles;
		param_01 playerlinktodelta(param_00.var_AD3C,"tag_origin",1,0,0,0,0);
		param_01 scripts\common\utility::func_1C60(0);
		param_01 scripts\common\utility::func_1C40(0);
		param_01 method_800C(0);
		param_01 scripts\common\utility::func_1C58(0);
		param_01 thread phone_morse_code(param_00.var_AD3C);
		param_01 thread phone_exit_move();
		param_01 thread phone_exit_damage();
		param_01 notifyonplayercommand("exit_phonebooth","+stance");
		param_01 notifyonplayercommand("exit_phonebooth","+goStand");
		param_01 notifyonplayercommand("exit_phonebooth","+melee_zoom");
		param_01 notifyonplayercommand("exit_phonebooth","+breath_sprint");
		param_01 notifyonplayercommand("exit_phonebooth","+frag");
		param_01 notifyonplayercommand("exit_phonebooth","+smoke");
		param_01 scripts\common\utility::waittill_any_3("exit_phonebooth","morse_ended");
		wait(0.1);
		param_01 scripts\common\utility::func_1C60(1);
		param_01 scripts\common\utility::func_1C40(1);
		param_01 method_800C(1);
		param_01 scripts\common\utility::func_1C58(1);
		param_01.var_9D81 = undefined;
		param_01 unlink();
		param_00.var_AD3C delete();
		foreach(var_04 in level.players)
		{
			param_00.keypad_frame method_8429(var_04);
		}

		param_01 stoplocalsoundall();
		param_01 thread playlocalsound_phone("receiver_hangup");
		param_01 thread playlocalsound_phone("coin_accept",0);
		param_01._phone_sounds_played = undefined;
		param_01._phone_sounds_active = undefined;
		param_01._phone_exit_move = undefined;
		param_01._phone_exit_damage = undefined;
		param_01 notify("phonebooth_end");
	}
}

//Function Number: 37
phone_morse_code(param_00)
{
	self endon("left_stick_moved");
	self endon("exit_phonebooth");
	self endon("timeout");
	level endon("puzzle_phone_reset");
	if(!isdefined(level.morse_number))
	{
		var_01 = ["281","407","420","596","713","818"];
		var_01 = scripts\common\utility::array_randomize(var_01);
		level.morse_number = var_01[0];
	}

	wait(2);
	var_02 = undefined;
	for(var_03 = 0;var_03 < 3;var_03++)
	{
		if(var_03 + 1 == 3)
		{
			var_02 = getsubstr(level.morse_number,var_03);
		}
		else
		{
			var_02 = getsubstr(level.morse_number,var_03,var_03 + 1);
		}

		switch(var_02)
		{
			case "0":
				for(var_04 = 0;var_04 < 5;var_04++)
				{
					play_morse_dash(param_00);
				}
				break;

			case "1":
				play_morse_dot(param_00);
				for(var_04 = 0;var_04 < 4;var_04++)
				{
					play_morse_dash(param_00);
				}
				break;

			case "2":
				for(var_04 = 0;var_04 < 2;var_04++)
				{
					play_morse_dot(param_00);
				}
	
				for(var_04 = 0;var_04 < 3;var_04++)
				{
					play_morse_dash(param_00);
				}
				break;

			case "3":
				for(var_04 = 0;var_04 < 3;var_04++)
				{
					play_morse_dot(param_00);
				}
	
				for(var_04 = 0;var_04 < 2;var_04++)
				{
					play_morse_dash(param_00);
				}
				break;

			case "4":
				for(var_04 = 0;var_04 < 4;var_04++)
				{
					play_morse_dot(param_00);
				}
	
				play_morse_dash(param_00);
				break;

			case "5":
				for(var_04 = 0;var_04 < 5;var_04++)
				{
					play_morse_dot(param_00);
				}
				break;

			case "6":
				play_morse_dash(param_00);
				for(var_04 = 0;var_04 < 4;var_04++)
				{
					play_morse_dot(param_00);
				}
				break;

			case "7":
				for(var_04 = 0;var_04 < 2;var_04++)
				{
					play_morse_dash(param_00);
				}
	
				for(var_04 = 0;var_04 < 3;var_04++)
				{
					play_morse_dot(param_00);
				}
				break;

			case "8":
				for(var_04 = 0;var_04 < 3;var_04++)
				{
					play_morse_dash(param_00);
				}
	
				for(var_04 = 0;var_04 < 2;var_04++)
				{
					play_morse_dot(param_00);
				}
				break;

			case "9":
				for(var_04 = 0;var_04 < 4;var_04++)
				{
					play_morse_dash(param_00);
				}
	
				play_morse_dot(param_00);
				break;

			default:
				break;
		}
	}

	thread scripts\cp\maps\cp_disco\disco_mpq::play_phone_vo();
	self notify("morse_ended");
	scripts\common\utility::flag_set("morse_code_heard");
}

//Function Number: 38
play_morse_dot(param_00)
{
	level endon("puzzle_phone_reset");
	self playlocalsound("payphone_plr_morse_dot");
	wait(0.3);
}

//Function Number: 39
play_morse_dash(param_00)
{
	level endon("puzzle_phone_reset");
	self playlocalsound("payphone_plr_morse_dash");
	wait(0.5);
}