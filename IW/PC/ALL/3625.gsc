/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3625.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 135
 * Decompile Time: 91 ms
 * Timestamp: 10/27/2023 12:30:57 AM
*******************************************************************/

//Function Number: 1
func_87ED(param_00)
{
	level.player.var_885C = 1;
}

//Function Number: 2
func_87E2(param_00)
{
	level.player.var_8855 = param_00;
}

//Function Number: 3
func_878C()
{
	level.player.var_8855 = undefined;
}

//Function Number: 4
func_87CB(param_00,param_01)
{
	if(param_00)
	{
		level.player.var_8856 = param_01;
		return;
	}

	level.player.var_8856 = undefined;
}

//Function Number: 5
func_87E0(param_00)
{
	level.player notify("hack_reset_timeout");
	thread func_5C97(param_00);
}

//Function Number: 6
func_8781(param_00)
{
	level.player.var_8803 = !param_00;
}

//Function Number: 7
func_87A1()
{
	level.player notify("drone_timeout");
}

//Function Number: 8
func_87F3()
{
	level.player waittill("player_is_hacked_robot",var_00,var_01);
	if(isdefined(var_01))
	{
		return var_01;
	}

	return var_00;
}

//Function Number: 9
func_8795(param_00,param_01)
{
	if(!isdefined(level.var_8850))
	{
		level.var_8850 = [];
	}

	param_00.var_1B07 = param_01;
	level.var_8850 = scripts\common\utility::array_add(level.var_8850,param_00);
}

//Function Number: 10
func_87D1(param_00)
{
	level.var_8850 = scripts\common\utility::func_22A9(level.var_8850,param_00);
}

//Function Number: 11
func_87BC(param_00)
{
	if(!isdefined(level.var_8850))
	{
		return 0;
	}

	return scripts\common\utility::func_2286(level.var_8850,param_00);
}

//Function Number: 12
func_87C9(param_00,param_01)
{
	param_00.var_884B = param_01;
}

//Function Number: 13
func_8780(param_00)
{
	if(param_00 == 1)
	{
		level.player.var_87F9 = param_00;
		return;
	}

	level.player.var_87F9 = undefined;
}

//Function Number: 14
func_8782(param_00)
{
	if(param_00 == 1)
	{
		level.player.var_87FA = param_00;
		return;
	}

	level.player.var_87FA = undefined;
}

//Function Number: 15
func_87A7()
{
	if(!isdefined(level.player.var_883D))
	{
		return "none";
	}

	return level.player.var_883D;
}

//Function Number: 16
func_87BA()
{
	return func_87A7() != "none";
}

//Function Number: 17
func_877F(param_00)
{
	if(isarray(param_00))
	{
		level.player.var_8839 = scripts\common\utility::array_combine(level.player.var_8839,param_00);
		foreach(var_02 in param_00)
		{
			var_02 notify("hack_added_to_blacklist");
		}

		return;
	}

	level.player.var_8839 = scripts\common\utility::array_add(level.player.var_8839,param_00);
	param_00 notify("hack_added_to_blacklist");
}

//Function Number: 18
func_87D0(param_00)
{
	if(isarray(param_00))
	{
		level.player.var_8839 = scripts\common\utility::func_22AC(level.player.var_8839,param_00);
		return;
	}

	level.player.var_8839 = scripts\common\utility::func_22A9(level.player.var_8839,param_00);
}

//Function Number: 19
func_87E1(param_00,param_01,param_02)
{
	level.player.var_C391 = param_00;
	level.player.var_C378 = param_01;
	if(isdefined(param_02))
	{
		level.player.var_C396 = param_02;
	}
}

//Function Number: 20
func_87CC(param_00,param_01)
{
	if(param_00)
	{
		level.player.var_884D = param_01;
		return;
	}

	level.player.var_884D = undefined;
}

//Function Number: 21
func_87CD(param_00,param_01)
{
	if(param_00)
	{
		level.player.var_884E = param_01;
		return;
	}

	level.player.var_884E = undefined;
}

//Function Number: 22
func_8799(param_00)
{
	if(param_00)
	{
		level.player.var_8803 = 1;
		if(func_87A7() == "controllingrobot")
		{
			setomnvar("ui_hack_control_selfdestruct",0);
			return;
		}

		return;
	}

	level.player.var_8803 = undefined;
	if(func_87A7() == "controllingrobot")
	{
		setomnvar("ui_hack_control_selfdestruct",1);
	}
}

//Function Number: 23
func_87A0(param_00,param_01)
{
	if(isdefined(param_00))
	{
		level.player.var_8859 = param_00;
	}

	if(isdefined(param_01))
	{
		level.player.var_8858 = param_01;
	}
}

//Function Number: 24
func_878D()
{
	level.player.var_8859 = undefined;
	level.player.var_8858 = undefined;
}

//Function Number: 25
func_87CA(param_00,param_01)
{
	if(param_00)
	{
		level.player.var_884C = param_01;
		return;
	}

	level.player.var_884C = undefined;
}

//Function Number: 26
func_879F(param_00)
{
	if(param_00)
	{
		level.player.var_8849 = 1;
		return;
	}

	level.player.var_8849 = undefined;
}

//Function Number: 27
hack_blacklist_all_robots(param_00)
{
	if(param_00)
	{
		level.player.hackallrobotsblacklisted = 1;
		return;
	}

	level.player.hackallrobotsblacklisted = 0;
}

//Function Number: 28
hack_enable_enemy_melee(param_00)
{
	if(param_00)
	{
		level.player.hackenableenemymelee = 1;
		return;
	}

	level.player.hackenableenemymelee = undefined;
}

//Function Number: 29
func_8829()
{
	precacheitem("hackingdevice");
	precachesuit("hacked_c6");
	precacheitem("offhandshield_c8");
	precachesuit("hacked_c8");
	precacheitem("iw7_c6hack_melee");
	precacheitem("iw7_c6worker_fists");
	precacheshader("ac130_hud_friendly_vehicle_diamond_s_w");
	precacheshader("cb_remotemissile_target_hostile");
	precacheshader("hack_tool_reticule_lock1");
	precacheshader("hack_tool_reticule_lock2");
	precacheshader("hack_tool_reticule_lock3");
	precacheshader("hack_tool_reticule_lock4");
	precacheshader("hack_tool_reticule_lock5");
	precacheshader("hack_tool_reticule_lock6");
	precacheshader("hack_tool_reticule_lock7");
	precacheshader("hack_tool_reticule_lock8");
	precacheshader("hack_tool_reticule_lock9");
	precacheshader("hack_tool_reticule_nolock");
	precacheshader("visor_opaque_l");
	precacheshader("visor_opaque_r");
	precacheshader("visor_opaque_border");
	precacheshader("hack_tool_pip_frame");
	precacheshader("robot_control_dot_overlay");
	precacheshader("apache_zoom_overlay");
	level._effect["drone_suicide"] = loadfx("vfx/iw7/core/expl/weap/hydra_grenade/vfx_exp_gre_hydra_aerial.vfx");
	precacheshader("reticle_center_shard_ball");
	precacheshader("apache_target_lock");
	level.player scripts\sp\_utility::func_65E0("is_controlling_robot");
	level.player scripts\sp\_utility::func_65E0("is_hacked_robot");
	level.player scripts\sp\_utility::func_65E0("hack_reticle_disabled");
	level.player scripts\sp\_utility::func_65E0("hack_control_outro_done");
	level.player scripts\sp\_utility::func_65E0("hack_raise_autohold_period");
	setomnvar("ui_hack_control_overlay",0);
	setomnvar("ui_hack_targeting",0);
	setomnvar("ui_hack_control_signal_failing",0);
	setomnvar("ui_hack_control_selfdestruct",0);
	setomnvar("ui_hack_control_selfdestruct_timer",0);
	setomnvar("ui_hack_control_selfdestruct_show_timer",0);
	level._effect["robot_explosion"] = loadfx("vfx/iw7/_requests/europa/vfx_beam_rifle_robot_explode.vfx");
	func_1EE6();
	func_5C25();
	scripts\common\utility::flag_init("hack_device_target_locked");
	scripts\common\utility::flag_init("hack_device_target_delay");
	scripts\common\utility::flag_init("hack_hud_control_intro_black");
	scripts\common\utility::flag_init("hack_hud_control_intro_finished");
	scripts\common\utility::flag_init("hack_hud_control_outro_black");
	scripts\common\utility::flag_init("hack_hud_control_outro_finished");
	level.player.var_8839 = [];
	scripts\sp\_utility::func_9187("hackTarget",100,::func_919C);
	scripts\sp\_utility::func_9187("hackControl",101,::func_91A4);
	level.player.var_883D = "none";
	if(!is_console())
	{
		level.player scripts\sp\_utility::func_65E0("hack_toggled_off");
		level.player scripts\sp\_utility::func_65E0("hack_toggle_fired");
		level.player notifyonplayercommand("hack_fire","+attack");
		level.player notifyonplayercommand("hack_weap_switch","+weapnext");
	}
}

//Function Number: 30
func_1EE6()
{
	func_8784();
	func_E578();
	func_D304();
}

//Function Number: 31
func_5C25()
{
	function_004E("hacked_drone");
	function_004E("op_for");
	function_01B2("hacked_drone","op_for");
	level.player.var_9BFA = 0;
	level.var_6AFC = getent("fake_player_spawn","targetname");
	if(isdefined(level.var_6AFC))
	{
		level.var_6AFC.dontdeletemehacking = 1;
	}
}

//Function Number: 32
func_87F0()
{
	self endon("death");
	self endon("stop_hack_unequipped_think");
	self notify("hack_unequipped_think");
	self endon("hack_unequipped_think");
	self waittill("secondary_equipment_change");
	self notify("hack_unequipped");
}

//Function Number: 33
func_879A()
{
	self endon("death");
	self endon("hack_unequipped");
	self endon("stop_hack_disabled_think");
	self notify("hack_disabled_think");
	self endon("hack_disabled_think");
	for(;;)
	{
		if(!func_381E())
		{
			break;
		}

		wait(0.05);
	}

	self notify("hack_disabled");
}

//Function Number: 34
func_8836()
{
	self endon("death");
	self endon("hack_unequipped");
	self.var_9E1C = 0;
	thread func_87F0();
	var_00 = 1;
	var_01 = 0;
	for(;;)
	{
		if(is_mouse_and_keyboard() || !func_9BF9())
		{
			self waittill("secondary_equipment_pressed");
		}

		self.var_9E1D = 0;
		self.var_8816 = 0;
		self.var_2A94 = undefined;
		if(!func_381E())
		{
			wait(0.05);
			continue;
		}

		var_02 = self method_80FB("hackingdevice");
		if(var_02 <= 0)
		{
			wait(0.05);
			continue;
		}

		var_03 = self playgestureviewmodel("ges_hack_loop",undefined,1,0.2);
		if(!var_03)
		{
			wait(0.05);
			continue;
		}

		thread func_879A();
		if(!is_console())
		{
			level.player scripts\sp\_utility::func_65DD("hack_toggled_off");
			level.player scripts\sp\_utility::func_65DD("hack_toggle_fired");
			thread hack_toggled_off_think();
		}

		level.player.var_883D = "scanning";
		level.player.var_883A = 1;
		self.var_9E1C = 1;
		level notify("pause_jackal_streak_message");
		scripts\common\utility::flag_set("secondary_equipment_in_use");
		level.player scripts\sp\_utility::func_1C49(0);
		level.player scripts\sp\_utility::func_65DD("hack_control_outro_done");
		level.player scripts\sp\_utility::func_65E1("hack_raise_autohold_period");
		level.player scripts\common\utility::func_5127(0.4,::scripts\sp\_utility::func_65DD,"hack_raise_autohold_period");
		scripts\common\utility::func_1C62(0);
		scripts\common\utility::func_1C35(0);
		scripts\common\utility::func_1C46(0);
		scripts\common\utility::func_1C55(0);
		scripts\sp\_utility::func_1C34(0);
		scripts\common\utility::func_1C76(0);
		scripts\common\utility::func_1C3A(0);
		scripts\common\utility::func_1C6E(0);
		scripts\common\utility::func_1C53(0);
		thread func_8825();
		wait(0.3);
		level.player thread scripts\anim\battlechatter_ai::func_67CF("hackingdevice");
		if((!is_mouse_and_keyboard() && func_9BF9() && func_381E()) || is_mouse_and_keyboard() && !is_hack_toggled_off() && func_381E())
		{
			scripts\common\utility::func_6E2A("hack_device_target_locked");
			func_882C();
			scripts\sp\_utility::func_65DD("hack_reticle_disabled");
			thread func_5C8A();
			thread func_11AA1();
			while((!is_mouse_and_keyboard() && func_9BF9()) || is_mouse_and_keyboard() && !is_hack_toggled_off())
			{
				func_8830();
				if(isdefined(self.var_AEFA))
				{
					self method_846F("ges_hack_lock_in",undefined,0.01,0,1,1);
					wait(0.05);
					var_04 = func_882A();
					if(isdefined(var_04) && var_04 == "hack")
					{
						level.player notify("stop_hack_disabled_think");
						level.player notify("stop_hack_unequipped_think");
						level.player.var_883D = "transitiontorobot";
						level.player.var_883A = 1;
						thread player_lookat_ent_wrapper(self.var_AEFA,0.65);
						self method_80A6();
						self notify("hack_control_target");
						level.player scripts\sp\_utility::func_2B76(0,0.5);
						self method_846F("ges_hack_lock_fire",undefined,0.2,0,1,1);
						thread func_E592(self.var_AEFA);
						wait(1);
						self notify("hack_intro_done");
						self method_80AA();
						level.var_D365 = scripts\sp\_utility::func_10639("player_arms");
						var_05 = level.player method_84C6("currentViewModel");
						if(isdefined(var_05))
						{
							level.var_D365 setmodel(var_05);
						}

						level.var_D365 method_81E2(self,"tag_origin",(0,0,0),(0,0,0),1);
						level.var_D365 hide();
						level.player scripts\sp\_utility::func_65E3("hack_control_outro_done");
						break;
					}

					self method_846F("ges_hack_lock_out",undefined,0.01,0,1,1);
					continue;
				}

				break;
			}
		}
		else
		{
		}

		self notify("hackingdevice_end");
	}
}

//Function Number: 35
func_8825()
{
	self endon("death");
	self endon("stop_hacking_end_think");
	scripts\common\utility::waittill_any_3("hack_unequipped","hackingdevice_end","hack_disabled");
	hacking_end();
}

//Function Number: 36
hacking_end()
{
	var_00 = func_87A7();
	if(var_00 == "scanning" || var_00 == "locking" || var_00 == "locked")
	{
		self method_846F("ges_hack_loop_end",undefined,0.2,0,1,1);
		scripts\common\utility::func_5127(0.15,::func_8823);
	}
	else if(var_00 == "transitiontorobot")
	{
	}

	self notify("hack_device_closing");
	scripts\common\utility::func_6E2A("secondary_equipment_in_use");
	level.player scripts\sp\_utility::func_1C49(1);
	if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
	{
		level.player.var_5966 = undefined;
	}

	self.var_9E1C = 0;
	setomnvar("ui_hack_target_entity",undefined);
	level notify("unpause_jackal_streak_message");
	self notify("hack_device_closed");
	self method_80A6();
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C62,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C35,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C55,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C46,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C6E,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C53,1);
	scripts\common\utility::func_5127(0.75,::scripts\sp\_utility::func_1C34,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C76,1);
	scripts\common\utility::func_5127(0.75,::scripts\common\utility::func_1C3A,1);
	self.hackdoingoutro = 1;
	thread func_882D();
	if(isdefined(self.var_8824))
	{
		self.var_8824 = undefined;
		wait(1);
		return;
	}

	wait(0.05);
}

//Function Number: 37
func_882D()
{
	level.player endon("death");
	wait(0.3);
	level.player.var_883D = "none";
	level.player.var_883A = undefined;
	level.player notify("stop_hack_disabled_think");
	level.player.hackdoingoutro = undefined;
}

//Function Number: 38
func_381E()
{
	if(!self method_843C() || self method_81B8())
	{
		return 0;
	}

	if(!isdefined(level.player getcurrentprimaryweapon()) || level.player getcurrentprimaryweapon() == "none")
	{
		return 0;
	}

	if(!scripts\common\utility::func_9EC1() || !scripts\common\utility::func_9EBF())
	{
		return 0;
	}

	if(self method_81C6())
	{
		return 0;
	}

	if(scripts\sp\_utility::func_D123())
	{
		return 0;
	}

	if(isdefined(level.player.hackdoingoutro) && level.player.hackdoingoutro)
	{
		return 0;
	}

	if(scripts\sp\_utility::func_93A6() && scripts\common\utility::istrue(level.var_10964.var_D430))
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
func_1D5E(param_00,param_01)
{
	level endon("StopRotatingPlayer");
	level thread scripts\sp\_utility::func_C12D("StopRotatingPlayer",param_01);
	for(;;)
	{
		var_02 = vectortoangles(param_00.origin - (0,0,30) - level.player.origin);
		level.player setplayerangles(var_02);
		wait(0.05);
	}
}

//Function Number: 40
func_5C8A()
{
	self endon("hack_device_closing");
	self endon("hack_control_target");
	self endon("death");
	for(;;)
	{
		self waittill("damage");
		setomnvar("ui_hack_targeting_damage",1);
		scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_hack_targeting_damage",0);
		level.player scripts\sp\_utility::func_65E1("hack_reticle_disabled");
		wait(0.4);
		level.player scripts\sp\_utility::func_65DD("hack_reticle_disabled");
	}
}

//Function Number: 41
func_882C()
{
	self.var_883E = 1;
	thread func_87E4();
	scripts\sp\_utility::func_2B76(0.75,0.2);
	self playsound("hack_open_targeting_hud_lr");
	level.player method_82C2("hacking_targeting_hud","mix","filter","ambient");
	scripts\sp\_utility::func_9199("hackTarget",1);
	setomnvar("ui_wrist_pc",5);
}

//Function Number: 42
func_8823()
{
	if(isdefined(self.var_883E))
	{
		func_87B3();
		self.var_883E = undefined;
	}

	scripts\sp\_utility::func_2B76(1,0.2);
	thread scripts\sp\_utility::func_CE2F("hack_close_targeting_hud_lr");
	level.player method_8070(0.2);
	scripts\sp\_utility::func_9199("hackTarget",0);
	setomnvar("ui_wrist_pc",1);
}

//Function Number: 43
func_B2B5()
{
	self.var_5923 = undefined;
}

//Function Number: 44
func_882A()
{
	self endon("hack_unequipped");
	self endon("hack_disabled");
	if(isdefined(self.var_AEFA))
	{
		self.var_AEFA func_8827(1);
	}

	if(!is_console())
	{
		level.player scripts\sp\_utility::func_65DD("hack_toggle_fired");
		thread hacking_locked_fire_think();
	}

	for(;;)
	{
		if(!isdefined(self.var_AEFA) || !func_9CAA(self.var_AEFA) || !func_3DD2(self.var_AEFA) || is_mouse_and_keyboard() && is_hack_toggled_off())
		{
			scripts\common\utility::func_6E2A("hack_device_target_locked");
			func_11050(self.var_AEFA);
			self.var_4B20 = undefined;
			self.var_AEFA = undefined;
			level.player.var_883D = "scanning";
			if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
			{
				level.player.var_5966 = undefined;
			}

			self method_80D8(0.4,0.45);
			self notify("hack_lost_target");
			if(!is_console())
			{
				self notify("hack_locked_hold_done");
			}

			return "lost_target";
		}

		if((!is_mouse_and_keyboard() && !func_9BF9()) || is_mouse_and_keyboard() && level.player scripts\sp\_utility::func_65DB("hack_toggle_fired"))
		{
			if(!is_console())
			{
				self notify("hack_locked_hold_done");
				level.player scripts\sp\_utility::func_65E1("hack_toggled_off");
				level.player notify("hack_input_on_locked_robot");
			}

			return "hack";
		}

		wait(0.05);
	}
}

//Function Number: 45
func_87E4()
{
	self.var_8802 = [];
	scripts\common\utility::func_6E2A("hack_hud_control_intro_black");
	scripts\common\utility::func_6E2A("hack_hud_control_intro_finished");
	scripts\common\utility::func_6E2A("hack_hud_control_outro_black");
	scripts\common\utility::func_6E2A("hack_hud_control_outro_finished");
	level.player scripts\sp\_utility::func_1C3E(0);
	setomnvar("ui_hack_targeting",1);
	function_0237("hack_targeting",0);
	thread func_87B8();
	thread func_87B7();
}

//Function Number: 46
func_87B7()
{
	self endon("hack_device_closed");
	self waittill("death");
	func_87B3();
}

//Function Number: 47
func_87B8()
{
	self endon("death");
	self endon("hack_device_closed");
	self.var_8853 = newhudelem();
	self.var_8853.sort = 0;
	self.var_8853.x = 0;
	self.var_8853.y = 0;
	self.var_8853.hidewheninmenu = 1;
	self.var_8853.var_175 = 1;
	self.var_8853.alignx = "center";
	self.var_8853.aligny = "middle";
	self.var_8853.horzalign = "center";
	self.var_8853.vertalign = "middle";
	self.var_8853.alpha = 1;
	self.var_8802 = scripts\common\utility::array_add(self.var_8802,self.var_8853);
	self.var_8852 = newhudelem();
	self.var_8852.sort = 0;
	self.var_8852.x = 0;
	self.var_8852.y = 0;
	self.var_8852.hidewheninmenu = 1;
	self.var_8852.var_175 = 1;
	self.var_8852.alignx = "center";
	self.var_8852.aligny = "middle";
	self.var_8852.horzalign = "center";
	self.var_8852.vertalign = "middle";
	self.var_8852.alpha = 0;
	self.var_8802 = scripts\common\utility::array_add(self.var_8802,self.var_8852);
	setomnvar("ui_hack_targeting_status","searching");
	var_00 = 1;
	for(;;)
	{
		var_01 = ["hack_acquired_target","hack_lost_target","hack_locked_target","hack_control_target","hack_done_control_target","hack_acquired_non_hackable","hack_acquired_need_upgrade","hack_no_target","hack_suicide","hack_shutdown_sequence"];
		var_02 = scripts\common\utility::func_13730(var_01);
		if(var_02 == "hack_acquired_target")
		{
			setomnvar("ui_hack_targeting_status","connecting");
			setomnvar("ui_hack_target_entity",self.var_4B20);
			var_03 = self.var_4B20 func_12A5();
			if(var_03 == "C8")
			{
				var_03 = 1;
			}
			else
			{
				var_03 = 2;
			}

			setomnvar("ui_hack_control_robot_type",var_03);
			continue;
		}

		if(var_02 == "hack_lost_target")
		{
			self notify("hack_hud_stop_tracking_target");
			self.var_8853.x = 0;
			self.var_8853.y = 0;
			self.var_8852.alpha = 0;
			setomnvar("ui_hack_targeting_status","searching");
			setomnvar("ui_hack_target_entity",self.var_4B20);
			continue;
		}

		if(var_02 == "hack_locked_target")
		{
			setomnvar("ui_hack_targeting_status","locked");
			continue;
		}

		if(var_02 == "hack_control_target")
		{
			func_87AF();
			continue;
		}

		if(var_02 == "hack_suicide")
		{
			func_87B2();
			continue;
		}

		if(var_02 == "hack_shutdown_sequence")
		{
			func_87B1();
			continue;
		}

		if(var_02 == "hack_done_control_target")
		{
			func_87B0();
			continue;
		}

		if(var_02 == "hack_acquired_non_hackable" && var_00)
		{
			setomnvar("ui_hack_targeting_status","notcompatible");
			var_00 = 0;
			continue;
		}

		if(var_02 == "hack_acquired_need_upgrade" && var_00)
		{
			setomnvar("ui_hack_targeting_status","needupgrade");
			var_00 = 0;
			continue;
		}

		if(var_02 == "hack_no_target" && !var_00)
		{
			setomnvar("ui_hack_targeting_status","searching");
			var_00 = 1;
		}
	}
}

//Function Number: 48
func_87AF()
{
	if(isdefined(level.var_8826) && level.var_8826)
	{
		setomnvar("ui_hack_ethan_overlay",1);
	}
	else
	{
		setomnvar("ui_hack_control_overlay",1);
	}

	scripts\common\utility::func_5127(0.35,::func_87B6);
	thread scripts\sp\_utility::func_C12D("hack_hud_stop_tracking_target",0.35);
	if(isdefined(level.player.var_884D))
	{
		scripts\common\utility::func_C0A6(0.6,::function_0237,level.player.var_884D,0);
	}
	else if(level.player.var_8820 == "C6" || level.player.var_8820 == "C6Worker")
	{
		scripts\common\utility::func_C0A6(0.6,::function_0237,"hack_c6_control",0);
	}
	else if(level.player.var_8820 == "C8")
	{
		scripts\common\utility::func_C0A6(0.6,::function_0237,"hack_c8_control",0);
	}

	thread scripts\common\utility::func_6E3F("hack_hud_control_intro_black",0.6);
	scripts\common\utility::func_C0A6(0.6,::setomnvar,"ui_wrist_pc",0);
	thread scripts\common\utility::func_6E3F("hack_hud_control_intro_finished",1);
	scripts\common\utility::delaycall(0.65,::playsound,"hack_start_hud_lr");
	level.player scripts\common\utility::delaycall(0.65,::method_82C2,"hacking_hud_transition","mix");
}

//Function Number: 49
func_87B2()
{
	setomnvar("ui_hack_control_signal_failing",0);
	setomnvar("ui_hack_control_outro",1);
	scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_hack_control_outro",0);
}

//Function Number: 50
func_87B1()
{
	setomnvar("ui_hack_control_signal_failing",0);
	setomnvar("ui_hack_control_outro",3);
	scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_hack_control_outro",0);
}

//Function Number: 51
func_87B0()
{
	setomnvar("ui_hack_control_outro",2);
	scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_hack_control_outro",0);
	level.player notify("stop soundhacked_drone_dmg_alarm");
	scripts\common\utility::func_C0A6(0.1,::function_0237,"",0);
	thread scripts\common\utility::func_6E3F("hack_hud_control_outro_black",0.2);
	scripts\common\utility::func_C0A6(0,::setomnvar,"ui_wrist_pc",5);
	scripts\common\utility::func_C0A6(0,::setomnvar,"ui_hack_targeting_status","closing");
	scripts\common\utility::func_C0A6(1.5,::setomnvar,"ui_wrist_pc",1);
	scripts\common\utility::func_C0A6(1.5,::setomnvar,"ui_hack_targeting_status","searching");
	thread scripts\common\utility::func_6E3F("hack_hud_control_outro_finished",0.7);
	scripts\common\utility::delaycall(0,::playsound,"hack_hud_outro_lr");
	level.player scripts\common\utility::delaycall(0.01,::method_82C2,"hacking_hud_transition","ambient","mix");
	level.player scripts\common\utility::delaycall(0.7,::method_8070,0.2);
	level.player scripts\common\utility::func_5127(1.4,::func_87B3);
}

//Function Number: 52
func_87B4(param_00)
{
	return func_87A8(param_00);
}

//Function Number: 53
func_87B5(param_00)
{
	return level.player method_840B(param_00 gettagorigin(func_87A8(param_00)),getdvarint("cg_fov"));
}

//Function Number: 54
func_87B3()
{
	if(isdefined(level.var_8826) && level.var_8826)
	{
		setomnvar("ui_hack_ethan_overlay",0);
	}
	else
	{
		setomnvar("ui_hack_control_overlay",0);
	}

	setomnvar("ui_hack_targeting",0);
	setomnvar("ui_hack_control_signal_failing",0);
	setomnvar("ui_hack_control_selfdestruct",0);
	setomnvar("ui_hack_control_selfdestruct_timer",0);
	setomnvar("ui_hack_control_selfdestruct_show_timer",0);
	level.player scripts\sp\_utility::func_1C3E(1);
	foreach(var_01 in self.var_8802)
	{
		if(isdefined(var_01.bar))
		{
			var_01.bar destroy();
		}

		var_01 destroy();
	}

	function_0237("",0);
}

//Function Number: 55
func_87B6()
{
	setomnvar("ui_hack_targeting",0);
	foreach(var_01 in self.var_8802)
	{
		if(isdefined(var_01.bar))
		{
			var_01.bar.alpha = 0;
		}

		var_01.alpha = 0;
	}

	function_0237("",0);
}

//Function Number: 56
func_9BF9()
{
	if(level.player scripts\sp\_utility::func_65DB("hack_raise_autohold_period"))
	{
		return 1;
	}

	if(scripts\common\utility::flag("secondary_equipment_input_down"))
	{
		return 1;
	}

	level.player notify("hack_button_released");
	return 0;
}

//Function Number: 57
is_hack_toggled_off()
{
	if(is_console())
	{
		return 0;
	}

	if(level.player scripts\sp\_utility::func_65DB("hack_raise_autohold_period"))
	{
		return 0;
	}

	if(!level.player scripts\sp\_utility::func_65DB("hack_toggled_off"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 58
func_13644()
{
	scripts\common\utility::func_6E5A("secondary_equipment_input_down");
}

//Function Number: 59
func_87A8(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00.classname != "script_model" && !isdefined(param_00.var_6554))
	{
		return "j_SpineUpper";
	}

	return "tag_origin";
}

//Function Number: 60
func_8830()
{
	self endon("hack_unequipped");
	self endon("hack_disabled");
	self endon("hack_close_pressed");
	self endon("robot_hacked");
	self endon("hack_locked_target");
	self.var_A997 = undefined;
	self.var_4B20 = undefined;
	self.var_AEFA = undefined;
	self method_80D8(0.4,0.45);
	scripts\common\utility::flag_set("hack_device_target_delay");
	thread scripts\sp\_utility::func_6E2B("hack_device_target_delay",0.4);
	while((!is_mouse_and_keyboard() && func_9BF9()) || is_mouse_and_keyboard() && !is_hack_toggled_off())
	{
		if(!isdefined(self.var_4B20) && !scripts\common\utility::flag("hack_device_target_delay"))
		{
			self.var_4B20 = func_2A91();
			if(isdefined(self.var_4B20))
			{
				thread func_10D4E(self.var_4B20);
				level.player.var_883D = "locking";
				level.player.var_883A = 1;
				if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
				{
					level.player.var_5966 = 1;
				}

				self notify("hack_acquired_target");
				self method_80D8(0.2,0.25);
			}

			continue;
		}

		if(!scripts\common\utility::flag("hack_device_target_delay"))
		{
			if(!func_3DD2(self.var_4B20))
			{
				scripts\common\utility::func_6E2A("hack_device_target_locked");
				func_11050(self.var_4B20);
				self.var_4B20 = undefined;
				self.var_AEFA = undefined;
				level.player.var_883D = "scanning";
				if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
				{
					level.player.var_5966 = undefined;
				}

				self notify("hack_lost_target");
				self method_80D8(0.4,0.45);
			}
		}

		wait(0.05);
	}
}

//Function Number: 61
func_11AA1()
{
	self endon("hack_unequipped");
	self endon("hack_disabled");
	self endon("hack_button_released");
	if(!is_console())
	{
		self endon("hack_toggled_off");
	}
	else
	{
		self endon("secondary_equipment_released");
	}

	self endon("hack_close_pressed");
	self endon("robot_hacked");
	thread func_11AA0();
	for(;;)
	{
		self.var_87F8 = [];
		self.var_C123 = [];
		var_00 = function_0072("bad_guys");
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02.var_111A4) && var_02.var_111A4 != "C6" && var_02.var_111A4 != "C8" && var_02.var_111A4 != "C12")
			{
				continue;
			}

			if(!func_9CAA(var_02))
			{
				self.var_C123[self.var_C123.size] = var_02;
				continue;
			}

			self.var_87F8[self.var_87F8.size] = var_02;
		}

		if(isdefined(level.var_8850))
		{
			level.var_8850 = scripts\common\utility::func_22BC(level.var_8850);
			self.var_87F8 = scripts\common\utility::array_combine(self.var_87F8,level.var_8850);
		}

		foreach(var_05 in self.var_87F8)
		{
			var_06 = 0;
			if(isdefined(self.var_4B20) && var_05 == self.var_4B20)
			{
				var_06 = 1;
			}

			var_05 func_8827(var_06);
		}

		foreach(var_05 in self.var_C123)
		{
			var_05 scripts\sp\_utility::func_9193("hackTarget");
		}

		wait(0.05);
	}
}

//Function Number: 62
func_11AA0()
{
	if(!is_console())
	{
		var_00 = ["hack_unequipped","hack_disabled","hack_button_released","hack_close_pressed","robot_hacked","hack_toggled_off"];
		scripts\common\utility::func_13730(var_00);
	}
	else
	{
		scripts\common\utility::waittill_any_3("hack_unequipped","hack_disabled","hack_button_released","secondary_equipment_released","hack_close_pressed","robot_hacked");
	}

	foreach(var_02 in self.var_87F8)
	{
		var_02 scripts\sp\_utility::func_9193("hackTarget");
	}

	foreach(var_02 in self.var_C123)
	{
		var_02 scripts\sp\_utility::func_9193("hackTarget");
	}

	self.var_87F8 = undefined;
	self.var_C123 = undefined;
}

//Function Number: 63
func_9CAA(param_00)
{
	if(!isdefined(level.player.var_885D))
	{
		if(!func_87BC(param_00) && param_00.var_111A4 == "C8" || param_00.var_111A4 == "C12")
		{
			return 0;
		}
	}
	else if(!func_87BC(param_00) && param_00.var_111A4 == "C12")
	{
		return 0;
	}

	if(!func_3DC7(param_00))
	{
		return 0;
	}

	if(!func_3DC6(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_87F6) && !param_00.var_87F6)
	{
		return 0;
	}

	if(isdefined(param_00.var_2303) && isdefined(param_00.var_2303.var_2F3A) && param_00.var_2303.var_2F3A)
	{
		return 0;
	}

	if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "nohack")
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(level.player.var_8839,param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_2F39) && param_00.var_2F39 == 1)
	{
		return 0;
	}

	if(isdefined(param_00.var_8804))
	{
		return 0;
	}

	if(!func_9CA9(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.player.hackallrobotsblacklisted))
	{
		return 0;
	}

	return 1;
}

//Function Number: 64
func_9CA9(param_00)
{
	if(!isdefined(param_00.var_884B) && distancesquared(level.player.origin,param_00.origin) > squared(1500))
	{
		return 0;
	}
	else if(isdefined(param_00.var_884B) && distancesquared(level.player.origin,param_00.origin) > squared(param_00.var_884B))
	{
		return 0;
	}

	return 1;
}

//Function Number: 65
func_2A91()
{
	if(level.player scripts\sp\_utility::func_65DB("hack_reticle_disabled"))
	{
		return undefined;
	}

	if(!isdefined(self.var_87F8) || !isdefined(self.var_C123))
	{
		return undefined;
	}

	var_00 = scripts\common\utility::array_combine(self.var_87F8,self.var_C123);
	var_01 = 0;
	var_02 = 0;
	var_03 = undefined;
	var_04 = [];
	foreach(var_06 in var_00)
	{
		if(isdefined(var_06.var_C124))
		{
			continue;
		}

		if(isdefined(var_06) && check_robot_in_sights(var_06))
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(var_04.size > 0)
	{
		var_04 = sortbydistance(var_04,level.player.origin);
		foreach(var_06 in var_04)
		{
			if(scripts\common\utility::func_2286(self.var_87F8,var_06))
			{
				var_03 = var_06;
				break;
			}
		}

		if(!isdefined(var_03))
		{
			foreach(var_06 in var_04)
			{
				if(scripts\common\trace::func_DCF1(var_06 gettagorigin(func_87A8(var_06)),level.player geteye(),var_06,scripts\common\trace::func_4956(1)) && func_9CA9(var_06))
				{
					var_01 = 1;
					if(var_06 func_12A5() == "C8")
					{
						var_02 = 1;
					}

					break;
				}
			}
		}
	}

	if(!isdefined(var_03) && var_01 && var_02)
	{
		self notify("hack_acquired_need_upgrade");
	}
	else if(!isdefined(var_03) && var_01)
	{
		self notify("hack_acquired_non_hackable");
	}
	else if(!isdefined(var_03) && !var_01)
	{
		self notify("hack_no_target");
	}

	return var_03;
}

//Function Number: 66
func_3DC7(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isalive(param_00) && param_00.classname != "script_model")
	{
		return 0;
	}

	return 1;
}

//Function Number: 67
func_3DC6(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(issubstr(param_00.classname,"worker"))
	{
		return 1;
	}

	if(!isdefined(param_00.var_394) || param_00.var_394 == "" || param_00.var_394 == "none")
	{
		return 0;
	}

	return 1;
}

//Function Number: 68
func_3DD2(param_00)
{
	if(level.player scripts\sp\_utility::func_65DB("hack_reticle_disabled"))
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(self.var_8839,param_00))
	{
		return 0;
	}

	if(!func_9CAA(param_00))
	{
		return 0;
	}

	return check_robot_in_sights(param_00,1);
}

//Function Number: 69
check_robot_in_sights(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = param_00 gettagorigin(func_87A8(param_00));
	var_03 = distancesquared(param_00.origin,level.player.origin);
	var_04 = 100;
	if(var_03 < squared(var_04))
	{
		var_05 = 200;
		var_06 = 75;
		var_07 = 30;
		var_08 = var_04;
		var_09 = 1.1;
		var_0A = 1.25;
	}
	else
	{
		var_05 = 75;
		var_06 = 15;
		var_07 = var_08;
		var_08 = 500;
		var_09 = 1.25;
		var_0A = 3;
	}

	if(var_03 <= squared(var_07))
	{
		var_0B = var_05;
		var_0C = var_09;
	}
	else if(var_05 >= squared(var_0A))
	{
		var_0B = var_08;
		var_0C = var_0B;
	}
	else
	{
		var_0D = sqrt(var_05);
		var_0E = var_0D - var_07 / var_08 - var_07;
		var_0B = var_0E * var_06 - var_05 + var_05;
		var_0C = var_0E * var_0A - var_09 + var_09;
	}

	if(param_01)
	{
		var_0B = var_0B * var_0C;
	}

	return level.player method_8409(var_02,65,var_0B);
}

//Function Number: 70
func_10D4E(param_00)
{
	self endon("hack_unequipped");
	self endon("hack_disabled");
	self endon("hack_close_pressed");
	self endon("robot_hacked");
	self endon("hack_lost_target");
	if(!is_console())
	{
		self endon("hack_toggled_off");
	}
	else
	{
		self endon("secondary_equipment_released");
	}

	self endon("hack_button_released");
	var_01 = func_129E(param_00) / 2;
	self playsound("hack_target_reticule");
	setomnvar("ui_hack_targeting_ping",1);
	scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_hack_targeting_ping",0);
	wait(var_01);
	self playsound("hack_target_reticule");
	setomnvar("ui_hack_targeting_ping",1);
	scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_hack_targeting_ping",0);
	wait(var_01);
	self playsound("hack_target_reticule_locked");
	scripts\common\utility::flag_set("hack_device_target_locked");
	level.player.var_883D = "locked";
	level.player.var_883A = 1;
	if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
	{
		level.player.var_5966 = 1;
	}

	self notify("hack_locked_target");
	self.var_AEFA = param_00;
}

//Function Number: 71
func_129E(param_00)
{
	var_01 = 0.8;
	if(isdefined(level.player.var_885E))
	{
		var_01 = 0.5;
	}

	if(param_00 func_12A5() == "C8")
	{
		var_01 = 2;
	}

	return var_01;
}

//Function Number: 72
func_11050(param_00)
{
	self notify("hack_targeting_released");
}

//Function Number: 73
func_8827(param_00)
{
	var_01 = self;
	if(isdefined(self.var_6554))
	{
		var_01 = self.var_5CBA;
	}

	if(param_00)
	{
		if(isdefined(level.player.var_AEFA) && level.player.var_AEFA == self)
		{
			var_01 scripts\sp\_utility::func_9196(1,0,1,"hackTarget");
		}
		else
		{
			var_01 scripts\sp\_utility::func_9196(4,0,1,"hackTarget");
		}
	}
	else if(isdefined(level.player.var_8846))
	{
		var_01 scripts\sp\_utility::func_9193("hackTarget");
	}
	else
	{
		var_01 scripts\sp\_utility::func_9196(0,0,1,"hackTarget");
	}

	thread func_8828();
}

//Function Number: 74
func_8828()
{
	if(isdefined(self.var_87FC))
	{
		return;
	}

	self.var_87FC = 1;
	level.player scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"death");
	level.player scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"hack_device_closing");
	level.player scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"hack_control_target");
	scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"player_controlled");
	scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"death");
	scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"hack_added_to_blacklist");
	scripts\sp\_utility::func_57D6();
	if(isdefined(self.var_6554))
	{
		self.var_5CBA scripts\sp\_utility::func_9193("hackTarget");
	}
	else if(isdefined(level.player.var_AEFA) && self == level.player.var_AEFA)
	{
		scripts\common\utility::func_5127(1,::scripts\sp\_utility::func_9193,"hackTarget");
	}
	else
	{
		scripts\sp\_utility::func_9193("hackTarget");
	}

	self.var_87FC = undefined;
}

//Function Number: 75
func_E592(param_00)
{
	self endon("death");
	self.var_8816 = 1;
	if(isdefined(param_00.var_1B07))
	{
		func_87D1(param_00);
		level.player.var_8844 = param_00;
		param_00 = param_00.var_1B07;
	}

	param_00.var_8804 = 1;
	self.var_8816 = 1;
	level.var_880A = param_00;
	self.var_8820 = level.var_880A func_12A5();
	param_00.var_8804 = 1;
	param_00.var_BFED = 1;
	self waittill("hack_intro_done");
	self notify("robot_hacked",param_00);
	thread func_E57D(param_00);
}

//Function Number: 76
func_4FBB()
{
	var_00 = self method_80FB("hackingdevice");
	self setweaponammoclip("hackingdevice",var_00 - 1);
	self notify("offhand_fired");
}

//Function Number: 77
func_12A5()
{
	if(!isdefined(self.var_111A4) || self.var_111A4 == "C6")
	{
		if(issubstr(self.classname,"worker"))
		{
			return "C6Worker";
		}
		else
		{
			return "C6";
		}
	}
	else if(self.var_111A4 == "C8")
	{
		return "C8";
	}
	else if(issubstr(self.classname,"eth3n"))
	{
		return "C6";
	}

	return "unhackable";
}

//Function Number: 78
func_E57D(param_00)
{
	param_00 notify("player_controlled");
	if(func_3DC7(param_00) && func_3DC6(param_00))
	{
		param_00 thread func_2A46(self.var_8820);
		return;
	}

	func_E588();
}

//Function Number: 79
func_E588()
{
	level notify("robot_died_during_intro");
	scripts\sp\_utility::func_9199("hackTarget",0);
	if(isdefined(level.player.var_883E))
	{
		level.player.var_883E = undefined;
	}

	level.player scripts\sp\_utility::func_65E1("is_hacked_robot");
	wait(0.05);
	scripts\common\utility::flag_wait("hack_hud_control_intro_black");
	level.player notify("hack_done_control_target");
	level.player scripts\sp\_utility::func_65DD("is_hacked_robot");
	level.player scripts\sp\_utility::func_2B76(1,0.5);
	level.player thread func_87F0();
	func_8793(1);
}

//Function Number: 80
func_2A46(param_00)
{
	level endon("robot_died_during_intro");
	if(isalive(level.player))
	{
		scripts\common\utility::flag_wait("hack_hud_control_intro_black");
		if(!func_3DC7(self) || !func_3DC6(self))
		{
			level.player thread func_E588();
		}

		scripts\sp\_utility::func_9199("hackTarget",0);
		if(isdefined(level.player.var_883E))
		{
			level.player.var_883E = undefined;
		}

		var_01 = "hackControl";
		if(isdefined(level.player.var_8858))
		{
			var_01 = level.player.var_8858;
		}

		scripts\sp\_utility::func_9199(var_01,1);
		if(!func_3DC7(self) || !func_3DC6(self))
		{
			level.player thread func_E588();
		}

		self notify("stop_loop");
		lib_0A1E::func_2386();
		waittillframeend;
		if(!func_3DC7(self) || !func_3DC6(self))
		{
			level.player thread func_E588();
		}

		level.player func_4FBB();
		if(!isdefined(level.player.var_87F9) || level.player.var_87F9 == 0)
		{
			func_54FD();
			level.player.var_885B = 1;
		}

		if(isdefined(level.player.var_87FA) && level.player.var_87FA == 1)
		{
			level.player scripts\common\utility::func_1C6E(1);
			level.player.var_8860 = 1;
		}

		level.var_87FF = [];
		for(var_02 = 0;var_02 < 24;var_02++)
		{
			level.var_87FF[var_02] = 0;
		}

		level.player.var_9BFA = 1;
		level.player.var_9BA2 = 1;
		level.player method_834E("hacked_drone");
		level.player.var_C391 = level.player.origin;
		level.player.var_C378 = level.player.angles;
		level.player.var_C396 = level.player getstance();
		level.player.var_C384 = level.player.health;
		level.player.og_maxhealth = level.player.maxhealth;
		level.player thread func_6AFD();
		level.player scripts\common\utility::func_1C67(0);
		level.player scripts\common\utility::func_1C53(1);
		level.player scripts\common\utility::func_1C42(0);
		level.player scripts\common\utility::func_1C70(0);
		level.player scripts\common\utility::func_1C60(0);
		level.player setstance("stand");
		level.player scripts\common\utility::func_1C40(0);
		level.player scripts\common\utility::func_5127(0.5,::scripts\common\utility::func_1C40,1);
		level.player scripts\common\utility::func_1C3A(1);
		level.var_ECA4["autopickup"] = 0;
		level.player disableweaponpickup();
		level.player scripts\common\utility::func_1C35(1);
		level.player scripts\common\utility::func_1C46(1);
		level.player scripts\sp\_utility::func_1C75(0);
		level.player method_8559(0);
		level.player method_80CB(1);
		level.player scripts\common\utility::func_1C76(1);
		if(isdefined(level.player.var_28CF))
		{
			level.var_884F = level.player.var_28CF;
		}

		scripts\sp\_utility::func_CF8B();
		if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
		{
			level.player.var_5966 = 1;
		}

		lib_0E4B::func_8DEA();
		level.player lib_0E42::func_838A(["specialty_fastreload"]);
		level.player method_84FE();
		level.player notify("stop_hacking_end_think");
		lib_0B2A::func_11429();
		level.player notify("hack_unequipped");
		var_03 = level.player scripts\sp\_utility::func_7D74();
		level.player.var_C39E = [];
		level.player.var_C37C = level.player getcurrentweapon();
		for(var_02 = 0;var_02 < var_03.size;var_02++)
		{
			level.player.var_C39E[var_02] = spawnstruct();
			level.player.var_C39E[var_02].var_394 = var_03[var_02];
			level.player.var_C39E[var_02].var_1E40 = level.player getweaponammoclip(var_03[var_02]);
			level.player.var_C39E[var_02].var_1E4D = level.player getweaponammostock(var_03[var_02]);
			level.player takeweapon(var_03[var_02]);
		}

		level.player.var_C376 = level.player scripts\sp\_utility::func_77C9();
		if(isdefined(level.player.var_C376) && level.player.var_C376 != "")
		{
			level.player scripts\sp\_utility::func_11425();
		}

		if(level.var_880A islinked() && !isdefined(level.var_880A.var_2029))
		{
			level.player.var_883C = scripts\common\utility::func_107CE();
			level.player.var_883C.origin = level.player.origin;
			level.player.var_883C.angles = level.player.angles;
			level.player playerlinktodelta(level.player.var_883C,undefined,1,0,0,0,0,1);
			if(isdefined(level.var_880A.var_87BD))
			{
				var_04 = level.var_880A.var_87BD;
				level.player scripts\common\utility::delaycall(0.25,::playerlinktodelta,level.player.var_883C,undefined,1,var_04,var_04,var_04,var_04,1);
			}

			level.player.var_883C.origin = level.var_880A.origin;
			if(isdefined(level.var_880A.var_87CF))
			{
				level.player.var_883C.origin = level.player.var_883C.origin + level.var_880A.var_87CF;
			}

			level.player.var_883C.angles = level.var_880A.angles;
			var_05 = level.var_880A getlinkedparent();
			level.player.var_883C linkto(var_05);
		}
		else
		{
			level.player setorigin(level.var_880A.origin);
			level.player setplayerangles(level.var_880A.angles);
		}

		level.player enableweapons();
		level.player.var_87FE = 1;
		level.var_880C = 100 / level.player.var_DF * 1.5;
		if(isdefined(level.player.var_8856))
		{
			level.var_880C = level.player.var_8856;
		}

		if(param_00 == "flying")
		{
			level.player method_8014(1);
			level.player method_800E(0);
			level.player scripts\common\utility::func_1C40(0);
			level.player method_818A();
			level.var_880A thread func_E0E3();
		}
		else if(param_00 == "C6")
		{
			func_61E0(1);
			level.var_880A thread func_E0E3();
		}
		else if(param_00 == "C8")
		{
			func_61E2(1);
			level.var_880A thread func_E0E3();
		}
		else if(param_00 == "C6Worker")
		{
			func_61E1(1);
			level.var_880A thread func_E0E3();
		}

		level.player scripts\sp\_utility::func_65E1("is_hacked_robot");
		if(isdefined(level.player.var_8844))
		{
			level.player notify("player_is_hacked_robot",self,level.player.var_8844);
			level.player.var_8844 = undefined;
		}
		else
		{
			level.player notify("player_is_hacked_robot",self);
		}

		scripts\common\utility::flag_wait("hack_hud_control_intro_finished");
		level.player thread func_11AA2();
		level.player thread func_5C2E(param_00);
		level.player thread func_880B(param_00);
		level.player.var_883D = "controllingrobot";
		level.player scripts\sp\_utility::func_65E1("is_controlling_robot");
		var_06 = function_0072("bad_guys");
		var_07 = function_00C9("bad_guys");
		foreach(var_09 in var_06)
		{
			var_09 thread func_19C8(1);
			var_09 thread func_1933();
			var_09.var_884A = var_09.var_162;
			var_09 scripts\sp\_utility::func_F3E6(0);
		}

		scripts\sp\_utility::func_22C7(var_07,::func_19C8,1);
		scripts\sp\_utility::func_22C7(var_07,::func_1933);
		level.player thread func_5C97();
		if(isdefined(level.player.var_884C))
		{
			level.player.var_87FE = level.player.var_884C;
		}

		level.player scripts\sp\_utility::func_2B76(level.player.var_87FE,0.5);
		level.player thread func_5C86(level.var_880A,param_00);
		var_0B = level.player scripts\common\utility::func_13734("drone_timeout","hack_player_took_damage","hack_drone_took_damage","player_suicided_drone","hack_drone_took_damage_trigger_hurt");
		level.player scripts\sp\_utility::func_65DD("is_controlling_robot");
		level.player.var_883D = "selfdestruct";
		var_0C = 0;
		if(param_00 == "C8")
		{
			var_0C = 1;
		}

		if(var_0B == "hack_drone_took_damage_trigger_hurt")
		{
			thread func_5C3B(level.var_880A,var_0C);
		}
		else if(isdefined(level.player.var_8849) && level.player.var_8849)
		{
			thread func_5C77(level.var_880A);
		}
		else if(var_0B == "player_suicided_drone")
		{
			thread func_5C85(level.var_880A,1,var_0C);
		}
		else
		{
			thread func_5C85(level.var_880A,0,var_0C);
			level.player waittill("suicide_control_done");
		}

		level.player scripts\common\utility::func_1C35(0);
		level.player scripts\common\utility::func_1C46(0);
		level.player scripts\common\utility::func_1C76(0);
		level.player scripts\common\utility::allow_jump(0);
		level.player scripts\common\utility::func_1C52(0);
		level.player scripts\sp\_utility::func_2B76(0,0.5);
		level.player method_80D8(0.03,0.03);
		setomnvar("ui_hack_control_selfdestruct",0);
		setomnvar("ui_hack_control_selfdestruct_timer",0);
		setomnvar("ui_hack_control_selfdestruct_show_timer",0);
		var_07 = function_00C9("bad_guys");
		scripts\common\utility::array_thread(var_07,::scripts\sp\_utility::func_E08B,::func_19C8);
		scripts\common\utility::array_thread(var_07,::scripts\sp\_utility::func_E08B,::func_1933);
		level.player thread func_2A47(param_00);
	}
}

//Function Number: 81
func_61E0(param_00)
{
	if(param_00)
	{
		level.player method_82C6("c6servo");
		level.player method_845A("hacked_c6");
		level.player.var_C37E = getdvar("cg_fov");
		function_01C5("cg_fov",75);
		level.player method_81DE(75,0.05);
		level.player scripts\common\utility::func_1C62(1);
		level.player.health = self.health;
		level.player.var_C39C = level.player method_816D();
		if(level.player.var_C39C == "")
		{
			level.player.var_C39C = "viewmodel_base_viewhands_iw7";
		}

		level.player method_8369("viewmodel_robot_c6");
		func_12C5();
		level.player scripts\common\utility::func_5127(1.25,::scripts\sp\_utility::func_D090,"ges_c6raise");
		level.player.var_C389 = level.player scripts\sp\_utility::func_7AD7();
		level.player scripts\sp\_utility::func_82EA("iw7_c6hack_melee");
		level.player.var_87FE = 0.9;
		return;
	}

	var_01 = level.player getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		level.player takeweapon(var_03);
	}

	if(isdefined(level.player.var_C389))
	{
		level.player scripts\sp\_utility::func_82EA(level.player.var_C389);
	}

	level.player method_8369(level.player.var_C39C);
	level.player.var_C39C = undefined;
	level.player method_82C6("vestlight");
	level.player method_845A("normal_sp");
	level.player method_81DE(float(level.player.var_C37E),0.05);
	level.player scripts\common\utility::func_1C62(0);
}

//Function Number: 82
func_61E2(param_00)
{
	if(param_00)
	{
		function_01C5("offhandShield_useCustomShader",0);
		level.player method_82C6("c8servo");
		level.player method_845A("hacked_c8");
		level.player.var_C37E = getdvar("cg_fov");
		function_01C5("cg_fov",75);
		level.player method_81DE(75,0.05);
		level.player.health = self.health;
		level.player.var_C39C = level.player method_816D();
		if(level.player.var_C39C == "")
		{
			level.player.var_C39C = "viewmodel_base_viewhands_iw7";
		}

		level.player method_8369("vm_robot_c8_base");
		scripts\common\utility::func_5127(1.35,::func_3464);
		level.player.var_C389 = level.player scripts\sp\_utility::func_7AD7();
		if(isdefined(level.player.var_C389))
		{
			level.player scripts\sp\_utility::func_1143E();
		}

		level.player.var_87FE = 0.7;
		return;
	}

	function_01C5("offhandShield_useCustomShader",1);
	level.player scripts\sp\_utility::func_11428();
	level.player notify("hack_stop_sustaining_ammo");
	if(isdefined(level.player.var_C389))
	{
		level.player scripts\sp\_utility::func_82EA(level.player.var_C389);
	}

	level.player method_8369(level.player.var_C39C);
	level.player.var_C39C = undefined;
	level.player method_82C6("vestlight");
	level.player method_845A("normal_sp");
	level.player method_81DE(float(level.player.var_C37E),0.05);
	level.player scripts\common\utility::func_1C55(0);
}

//Function Number: 83
func_3464()
{
	level.player giveweapon("iw7_mauler_c8hack");
	level.player method_83B6("iw7_mauler_c8hack");
	level.player giveweapon("offhandshield_c8");
	thread func_34E4();
	level.player scripts\common\utility::func_1C55(1);
}

//Function Number: 84
func_34E4()
{
	level.player endon("hack_stop_sustaining_ammo");
	for(;;)
	{
		var_00 = level.player getcurrentprimaryweapon();
		var_01 = level.player method_8118();
		var_02 = weaponclipsize(var_00);
		if(var_01 < var_02)
		{
			level.player setweaponammoclip(var_00,var_02);
		}

		wait(0.05);
	}
}

//Function Number: 85
func_61E1(param_00)
{
	if(param_00)
	{
		level.player method_82C6("c6servo");
		level.player method_845A("hacked_c6");
		level.player.var_C37E = getdvar("cg_fov");
		function_01C5("cg_fov",75);
		level.player method_81DE(75,0.05);
		level.player scripts\common\utility::func_1C62(1);
		level.player.health = self.health;
		level.player giveweapon("iw7_c6worker_fists");
		level.player method_83B6("iw7_c6worker_fists");
		level.player.var_C39C = level.player method_816D();
		if(level.player.var_C39C == "")
		{
			level.player.var_C39C = "viewmodel_base_viewhands_iw7";
		}

		level.player method_8369("viewmodel_robot_c6");
		level.player.var_87FE = 1.2;
		return;
	}

	var_01 = level.player getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		level.player takeweapon(var_03);
	}

	level.player method_8369(level.player.var_C39C);
	level.player.var_C39C = undefined;
	level.player method_82C6("vestlight");
	level.player method_845A("normal_sp");
	level.player method_81DE(float(level.player.var_C37E),0.05);
	level.player scripts\common\utility::func_1C62(0);
}

//Function Number: 86
func_12C5()
{
	if(isdefined(level.player.var_884E))
	{
		level.player giveweapon(level.player.var_884E);
		level.player method_83B6(level.player.var_884E);
		return;
	}

	var_00 = strtok(self.var_394,"+");
	var_01 = var_00[0];
	var_02 = scripts\sp\_utility::func_22B0(var_00,0);
	var_02[var_02.size] = "hacked";
	var_02 = scripts\common\utility::func_1D3A(var_02);
	foreach(var_04 in var_02)
	{
		var_01 = var_01 + "+" + var_04;
	}

	level.player giveweapon(var_01);
	level.player method_83B6(var_01);
}

//Function Number: 87
func_880B(param_00)
{
	level.player endon("stop drone sounds");
	level.player playsound("hacked_drone_on");
	wait(0.2);
	if(isdefined(level.var_8805))
	{
		level.player method_82C0(level.var_8805,0.4);
	}
	else if(param_00 == "C6" || param_00 == "C6Worker")
	{
		wait(0.3);
		level.player method_82C3("hacking_hud_c6",0.3,"reverb","mix","filter","ambient","player_adsr");
	}
	else
	{
		wait(0.3);
		level.player method_82C3("hacking_hud_c8",0.3,"mix","filter","ambient");
	}

	level.player.var_10466 = spawn("script_origin",level.player.origin);
	level.player.var_10466 linkto(level.player);
	for(;;)
	{
		level.player playsound("hacked_drone_hacking");
		wait(randomintrange(1,3));
	}
}

//Function Number: 88
func_8809()
{
	level.player endon("stop drone sounds");
	var_00 = 1;
	var_01 = 0;
	var_02 = -1;
	var_03 = 0;
	thread func_3367();
	for(;;)
	{
		if(!level.player isonground())
		{
			var_02 = -1;
		}

		if(var_02 != -1 && var_02 <= gettime())
		{
			var_01 = gettime();
			level.player playsound("c6_hacked_step");
			if(var_00)
			{
				level.player playsound("c6_hacked_step_servo_l");
			}
			else
			{
				level.player playsound("c6_hacked_step_servo_r");
			}

			var_00 = !var_00;
		}

		if(self.var_87FB < var_03 || var_02 <= gettime())
		{
			if(self.var_87FB == -1)
			{
				var_02 = -1;
			}
			else
			{
				var_02 = var_01 + self.var_87FB * 1000;
			}
		}

		var_03 = self.var_87FB;
		wait(0.05);
	}
}

//Function Number: 89
func_3367()
{
	level.player endon("stop drone sounds");
	self.var_87FB = -1;
	var_00 = 0.4;
	var_01 = 0.8;
	var_02 = 2.2;
	var_03 = 170;
	var_04 = 90;
	var_05 = 32;
	for(;;)
	{
		var_06 = level.player.origin;
		var_07 = distance2d(level.player getvelocity(),(0,0,0));
		if(var_07 < var_05)
		{
			self.var_87FB = -1;
			wait(0.05);
			continue;
		}

		if(var_07 < var_04)
		{
			var_08 = var_07 - var_05 / var_04 - var_05;
			var_08 = abs(var_08 - 1);
			var_09 = var_01 + var_08 * var_02 - var_01;
			self.var_87FB = var_09;
			wait(0.05);
			continue;
		}

		if(var_07 >= var_03)
		{
			self.var_87FB = var_00;
			wait(0.05);
			continue;
		}

		var_08 = var_07 - var_04 / var_03 - var_04;
		var_08 = abs(var_08 - 1);
		var_09 = var_00 + var_08 * var_01 - var_00;
		self.var_87FB = var_09;
		wait(0.05);
	}
}

//Function Number: 90
func_11AA2()
{
	level.player endon("death");
	level.player endon("faded_out");
	level.player endon("stop_track_hacked_drone_health");
	var_00 = 0;
	var_01 = 0;
	level.player.health = 100;
	for(;;)
	{
		level.player waittill("damage",var_02,var_03);
		self playsound("hack_hud_static_impact");
		var_00 = var_00 + var_02;
		var_04 = 0;
		if(isdefined(var_03) && isdefined(var_03.classname) && var_03.classname == "trigger_hurt")
		{
			var_04 = 1;
		}

		level.player.health = 100;
		if(var_00 > level.var_880C)
		{
			if(!var_04)
			{
				level.player notify("hack_drone_took_damage");
			}
			else
			{
				level.player notify("hack_drone_took_damage_trigger_hurt");
			}
		}

		if(var_00 > level.var_880C / 1.4 && !var_01)
		{
			level.player thread scripts\common\utility::func_CD7F("hacked_drone_dmg_alarm");
			var_01 = 1;
		}
	}
}

//Function Number: 91
func_1933()
{
	if(!issentient(self))
	{
		return;
	}

	self.var_C3DE = self method_8163();
	self method_834E("op_for");
	thread func_1934();
	thread func_19CA();
}

//Function Number: 92
func_19CA()
{
	var_00 = "hackControl";
	if(isdefined(level.player.var_8858))
	{
		var_00 = level.player.var_8858;
	}

	if(!isdefined(level.player.var_8859))
	{
		scripts\sp\_utility::func_9196(1,0,1,var_00);
		var_01 = func_E5B9(self,0);
		thread func_19D5(var_01,var_00);
		return;
	}

	if(scripts\common\utility::func_2286(level.player.var_8859,self))
	{
		scripts\sp\_utility::func_9196(1,0,1,var_00);
		var_01 = func_E5B9(self,0);
		thread func_19D5(var_01,var_00);
		return;
	}

	scripts\sp\_utility::func_9196(1,0,0,var_00);
	thread func_19D5(-1,var_00);
}

//Function Number: 93
func_19D5(param_00,param_01)
{
	scripts\common\utility::waittill_any_3("death","player_hack_faded_out");
	scripts\sp\_utility::func_9193(param_01);
	if(param_00 != -1)
	{
		func_E5B8(param_00);
	}
}

//Function Number: 94
func_1934()
{
	level.player endon("faded_out");
	self endon("death");
	if(!issentient(self))
	{
		return;
	}

	thread func_1932();
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(var_01 == level.player)
		{
			if(isdefined(self.var_C3DE) && self.var_C3DE != "")
			{
				self method_834E(self.var_C3DE);
			}
			else
			{
				self method_834E();
			}

			level notify("ai_aware_of_hacked_drone");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 95
func_1932()
{
	level.player endon("faded_out");
	self waittill("death",var_00);
	level notify("ai_aware_of_hacked_drone");
}

//Function Number: 96
func_19C8(param_00)
{
	self endon("death");
	self endon("entitydeleted");
	if(!issentient(self))
	{
		return;
	}

	if(param_00)
	{
		level.player endon("faded_out");
		level waittill("ai_aware_of_hacked_drone");
		if(!isalive(self))
		{
			return;
		}

		var_01 = distance(self.origin,level.player.origin);
		if(var_01 <= 512)
		{
			var_02 = 0.8;
		}
		else if(var_02 >= 1024)
		{
			var_02 = 3;
		}
		else
		{
			var_03 = var_02 - 512 / 512;
			var_02 = 0.8 + var_03 * 2.2;
		}

		var_02 = var_02 + randomfloat(0.4);
		wait(var_02);
	}

	if(isalive(self))
	{
		if(isdefined(self.var_C3DE) && self.var_C3DE != "")
		{
			self method_834E(self.var_C3DE);
		}
		else
		{
			self method_834E();
		}

		if(param_00)
		{
			wait(randomintrange(1,3));
		}
	}
}

//Function Number: 97
func_5C2E(param_00)
{
	if(param_00 == "flying")
	{
		level.player scripts\sp\_utility::func_1C3E(0);
	}

	level.player waittill("faded_out");
	if(isdefined(level.var_5C24))
	{
		foreach(var_02 in level.var_5C24)
		{
			var_02 destroy();
		}
	}

	if(isdefined(level.var_54D5))
	{
		level.var_54D5 destroy();
	}

	if(isdefined(level.var_54D6))
	{
		level.var_54D6 destroy();
	}

	if(param_00 == "flying")
	{
		level.player scripts\sp\_utility::func_1C3E(1);
	}
}

//Function Number: 98
func_5C97(param_00)
{
	level.player endon("hack_reset_timeout");
	level.player endon("hack_done_control_target");
	level.player endon("player_suicided_drone");
	level.player endon("hack_player_took_damage");
	level.player endon("hack_drone_took_damage");
	level.player endon("hack_drone_took_damage_trigger_hurt");
	level.player endon("faded_out");
	for(;;)
	{
		var_01 = 20;
		if(isdefined(param_00))
		{
			var_01 = param_00;
		}
		else if(isdefined(level.player.var_8855))
		{
			var_01 = level.player.var_8855;
		}

		if(var_01 > 5)
		{
			scripts\common\utility::func_5127(var_01 - 5,::func_12851);
		}
		else
		{
			thread func_12851();
		}

		wait(var_01);
		if(!isdefined(level.player.var_885C) || level.player.var_885C == 0)
		{
			break;
		}
	}

	level.player notify("drone_timeout");
}

//Function Number: 99
func_12851()
{
	if(!level.player scripts\sp\_utility::func_65DB("is_controlling_robot"))
	{
		return;
	}

	if(!isdefined(level.player.var_885C) || level.player.var_885C == 0)
	{
		setomnvar("ui_hack_control_signal_failing",1);
	}
}

//Function Number: 100
func_5C86(param_00,param_01)
{
	level.player endon("hack_done_control_target");
	wait(1);
	if(!isdefined(level.player.var_8803) || level.player.var_8803 == 0)
	{
		scripts\common\utility::func_C0A6(2.5,::setomnvar,"ui_hack_control_selfdestruct",1);
	}

	for(;;)
	{
		level.player waittill("primary_equipment_pressed");
		if(!isdefined(level.player.var_8803) || level.player.var_8803 == 0)
		{
			break;
		}
	}

	level.player notify("player_suicided_drone");
}

//Function Number: 101
func_5C85(param_00,param_01,param_02)
{
	if(isdefined(level.var_8826) && level.var_8826)
	{
		wait(2);
	}

	level.player notify("hack_suicide");
	level.player playsound("hack_hud_self_destruct_start");
	level.player thread scripts\common\utility::func_CD7F("hack_hud_self_destruct_alarm");
	level.player notify("player_suicided_drone");
	var_03 = function_0313(level.player.origin,(150,150,25),(0,0,0));
	thread scripts\common\utility::func_C0A6(4.5,::destroynavobstacle,var_03);
	level.player scripts\common\utility::func_1C55(0);
	level.player scripts\common\utility::func_1C53(0);
	if(!param_02)
	{
		level.player playgestureviewmodel("ges_shocknade_loop",undefined,1);
	}
	else
	{
		level.player playgestureviewmodel("ges_c8_shield_damage",undefined,1);
	}

	var_04 = scripts\common\utility::spawn_tag_origin();
	var_05 = level.player geteye();
	var_06 = level.player getplayerangles();
	var_07 = anglestoforward(var_06);
	var_08 = anglestoup(var_06);
	var_04.origin = var_05;
	var_04.angles = vectortoangles(var_07);
	var_04 thread func_113DC();
	playfxontag(level._effect["hack_pov_suicide_loop"],var_04,"tag_origin");
	level.player.var_843F = 1;
	var_09 = 0.65;
	if(param_01)
	{
		level.player playsound("c6_hack_self_destruct_initiate_short_plr");
		thread func_992D();
		wait(var_09);
		level.player thread scripts\sp\_utility::func_C12D("hack_done_control_target",var_09);
	}
	else
	{
		var_04 playsound("c6_hack_self_destruct_initiate_plr");
		var_0A = int(gettime() + 3000);
		setomnvar("ui_hack_control_selfdestruct_timer",var_0A);
		setomnvar("ui_hack_control_selfdestruct_show_timer",1);
		if(!isdefined(level.player.var_8803) || level.player.var_8803 == 0)
		{
			scripts\common\utility::func_5127(0.25,::func_AFE2);
		}

		thread func_AFE1();
		thread func_AFE3();
		var_0B = level.player scripts\common\utility::func_13734("long_suicide_done","player_suicided_drone","hack_drone_took_damage_trigger_hurt");
		setomnvar("ui_hack_control_selfdestruct_timer",0);
		setomnvar("ui_hack_control_selfdestruct_show_timer",0);
		level.player notify("suicide_control_done");
		thread func_992D();
		if(var_0B != "hack_drone_took_damage_trigger_hurt")
		{
			wait(var_09);
		}

		level.player thread scripts\sp\_utility::func_C12D("hack_done_control_target",var_09);
	}

	level.player notify("stop soundhack_hud_self_destruct_alarm");
	stopfxontag(level._effect["hack_pov_suicide_loop"],var_04,"tag_origin");
	playfxontag(level._effect["hack_pov_explode"],var_04,"tag_origin");
	var_0C = level.player.origin;
	thread func_5C84(var_0C);
	if(!param_02)
	{
		level.player playgestureviewmodel("ges_player_death_drop1",undefined,1);
	}
	else
	{
		level.player playgestureviewmodel("ges_c8_shield_death",undefined,1);
	}

	scripts\common\utility::flag_wait("hack_hud_control_outro_black");
	level.player scripts\common\utility::func_1C55(1);
	level.player scripts\common\utility::func_1C53(1);
	var_04 method_83AD();
	var_04 scripts\common\utility::delaycall(0.05,::delete);
	level.player.var_843F = undefined;
	if(!param_02)
	{
		level.player stopgestureviewmodel("ges_player_death_drop1",0.05);
	}
	else
	{
		level.player stopgestureviewmodel("ges_c8_shield_death",0.05);
	}

	level.player stoprumble("damage_heavy");
	if(isdefined(param_00) && isai(param_00) && isalive(param_00))
	{
		param_00.var_6D = 16;
		param_00 method_8481(var_0C);
		param_00 method_81D0();
	}
}

//Function Number: 102
func_AFE3()
{
	level.player endon("death");
	level.player endon("player_suicided_drone");
	wait(3);
	level.player notify("long_suicide_done");
}

//Function Number: 103
func_AFE2()
{
	level.player endon("death");
	level.player endon("long_suicide_done");
	level.player waittill("primary_equipment_pressed");
	level.player notify("player_suicided_drone");
}

//Function Number: 104
func_AFE1()
{
	level.player endon("death");
	level.player endon("long_suicide_done");
	for(;;)
	{
		level.player waittill("damage",var_00,var_01);
		if(isdefined(var_01) && isdefined(var_01.classname) && var_01.classname == "trigger_hurt")
		{
			break;
		}
	}

	level.player notify("hack_drone_took_damage_trigger_hurt");
}

//Function Number: 105
func_5C3B(param_00,param_01)
{
	level.player notify("hack_suicide");
	level.player notify("player_suicided_drone");
	var_02 = function_0313(level.player.origin,(150,150,25),(0,0,0));
	thread scripts\common\utility::func_C0A6(4.5,::destroynavobstacle,var_02);
	thread func_992D();
	var_03 = scripts\common\utility::spawn_tag_origin();
	var_04 = level.player geteye();
	var_05 = level.player getplayerangles();
	var_06 = anglestoforward(var_05);
	var_07 = anglestoup(var_05);
	var_03.origin = var_04;
	var_03.angles = vectortoangles(var_06);
	var_03 thread func_113DC();
	level.player.var_843F = 1;
	var_08 = 0.65;
	level.player thread scripts\sp\_utility::func_C12D("hack_done_control_target",var_08);
	level.player notify("stop soundhack_hud_self_destruct_alarm");
	playfxontag(level._effect["hack_pov_explode"],var_03,"tag_origin");
	var_09 = level.player.origin;
	thread func_5C84(var_09);
	level.player scripts\common\utility::func_1C55(0);
	level.player scripts\common\utility::func_1C53(0);
	if(!param_01)
	{
		level.player playgestureviewmodel("ges_player_death_drop1",undefined,1);
	}
	else
	{
		level.player playgestureviewmodel("ges_c8_shield_death",undefined,1);
	}

	scripts\common\utility::flag_wait("hack_hud_control_outro_black");
	level.player scripts\common\utility::func_1C55(1);
	level.player scripts\common\utility::func_1C53(1);
	var_03 delete();
	level.player.var_843F = undefined;
	if(!param_01)
	{
		level.player stopgestureviewmodel("ges_player_death_drop1",0.05);
	}
	else
	{
		level.player stopgestureviewmodel("ges_c8_shield_death",0.05);
	}

	level.player stoprumble("damage_heavy");
	if(isdefined(param_00) && isai(param_00) && isalive(param_00))
	{
		param_00.var_6D = 16;
		param_00 method_8481(var_09);
		param_00 method_81D0();
	}
}

//Function Number: 106
func_992D()
{
	level.player endon("death");
	var_00 = getdvarfloat("bg_viewKickMin",5);
	var_01 = getdvarfloat("bg_viewKickScale",0.8);
	function_01C5("bg_viewKickMin",2);
	function_01C5("bg_viewKickScale",0);
	scripts\common\utility::flag_wait("hack_hud_control_outro_black");
	function_01C5("bg_viewKickMin",var_00);
	function_01C5("bg_viewKickScale",var_01);
}

//Function Number: 107
func_113DC()
{
	self endon("death");
	for(;;)
	{
		self.origin = level.player geteye();
		self.angles = level.player getplayerangles();
		wait(0.05);
	}
}

//Function Number: 108
func_B068()
{
	self endon("hack_returned_to_player_position");
	for(;;)
	{
		playfx(level._effect["drone_suicide"],level.player.origin);
		earthquake(randomfloatrange(0.25,0.5),0.35,self.origin,200);
		wait(0.35);
	}
}

//Function Number: 109
func_5C84(param_00)
{
	var_01 = param_00 + (0,0,48);
	var_02 = 300;
	var_03 = 300;
	var_04 = 80;
	if(isdefined(level.override_hack_eplo_dmg_min))
	{
		var_04 = level.override_hack_eplo_dmg_min;
	}

	if(isdefined(level.override_hack_eplo_dmg_max))
	{
		var_03 = level.override_hack_eplo_dmg_max;
	}

	var_05 = level.player.var_C391 + (0,0,48);
	if(distance(var_01,var_05) < var_02)
	{
		if(scripts\common\trace::func_DCF1(var_01,var_05,undefined,scripts\common\trace::func_4956(1)))
		{
			level.drone_explosion_near_player = 1;
		}
	}

	if(!isdefined(level.var_1024F))
	{
		var_06 = level.player scripts\sp\_detonategrenades::func_734E();
		level.player scripts\common\utility::func_5127(2.4,::scripts\sp\_detonategrenades::func_734D,var_01,var_06,var_02);
	}

	radiusdamage(var_01,var_02,var_03,var_04,level.player);
	physicsexplosionsphere(var_01,500,50,1);
	playfx(level._effect["drone_suicide"],var_01);
	level.player playsound("c6_hack_self_destruct_explo_plr","sounddone");
	scripts\common\utility::func_C0A6(2,::function_0178,"c6_destruct",param_00);
	scripts\common\utility::func_C0A6(2,::playfx,level._effect["drone_suicide"],var_01);
	level.player scripts\common\utility::func_5127(2,::drone_suide_explosion_player_damage);
}

//Function Number: 110
drone_suide_explosion_player_damage()
{
	if(scripts\common\utility::istrue(level.drone_explosion_near_player))
	{
		wait(0.2);
		if(isalive(level.player))
		{
			level.player dodamage(level.player.health * 0.66,level.player.origin);
			thread scripts\sp\_gameskill::func_2BDB(3.6,2);
		}

		level.drone_explosion_near_player = undefined;
	}
}

//Function Number: 111
func_6AFB()
{
	level.player endon("player_suicided_drone");
	level.player endon("hack_player_took_damage");
	level.player endon("hack_drone_took_damage");
	level.player endon("hack_drone_took_damage_trigger_hurt");
	level.player endon("faded_out");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(!isdefined(level.var_CFEF))
		{
			level.var_CFEF = 0;
		}

		level.var_CFEF = level.var_CFEF + var_00;
		if(level.var_CFEF > 200)
		{
			level.var_CFEE = 200;
			break;
		}
	}

	level.player notify("hack_player_took_damage");
}

//Function Number: 112
func_5C77(param_00)
{
	level.player notify("hack_shutdown_sequence");
	level.player notify("player_suicided_drone");
	var_01 = function_0313(level.player.origin,(150,150,25),(0,0,0));
	thread scripts\common\utility::func_C0A6(4.5,::destroynavobstacle,var_01);
	level.player playgestureviewmodel("ges_shocknade_loop",undefined,1);
	var_02 = scripts\common\utility::spawn_tag_origin();
	var_03 = level.player geteye();
	var_04 = level.player getplayerangles();
	var_05 = anglestoforward(var_04);
	var_06 = anglestoup(var_04);
	var_02.origin = var_03;
	var_02.angles = vectortoangles(var_05);
	var_02 thread func_113DC();
	playfxontag(level._effect["hack_pov_suicide_loop"],var_02,"tag_origin");
	level.player.var_843F = 1;
	var_07 = 0.65;
	level.player playsound("c6_shutdown");
	wait(var_07);
	level.player thread scripts\sp\_utility::func_C12D("hack_done_control_target",var_07);
	stopfxontag(level._effect["hack_pov_suicide_loop"],var_02,"tag_origin");
	var_08 = level.player.origin;
	scripts\common\utility::flag_wait("hack_hud_control_outro_black");
	var_02 delete();
	level.player.var_843F = undefined;
	level.player stopgestureviewmodel("ges_shocknade_loop",0.05);
	level.player stoprumble("damage_heavy");
	if(isdefined(param_00) && isai(param_00) && isalive(param_00))
	{
		param_00.var_6D = 16;
		param_00 method_8481(var_08);
		param_00 method_81D0();
	}
}

//Function Number: 113
func_E0E3()
{
	level.player.var_8815 = spawn("script_model",level.var_880A.origin);
	level.var_880A hide();
	level.var_880A linkto(level.player.var_8815);
	level.player.var_8815.origin = level.player.var_8815.origin - (0,0,10000);
}

//Function Number: 114
func_E44E()
{
	if(isdefined(level.var_880A) && isalive(level.var_880A))
	{
		level.var_880A show();
		level.var_880A unlink();
		if(isai(level.var_880A))
		{
			level.var_880A method_80F1(level.player.origin,level.player.angles);
		}
		else
		{
			level.var_880A.origin = level.player.origin;
			level.var_880A.angles = level.player.angles;
		}

		level.var_880A.var_8804 = undefined;
	}

	level.player.var_8815 delete();
	level.player notify("drone_reset");
}

//Function Number: 115
func_2A47(param_00)
{
	scripts\common\utility::flag_wait("hack_hud_control_outro_black");
	level.player notify("faded_out");
	var_01 = "hackControl";
	if(isdefined(level.player.var_8858))
	{
		var_01 = level.player.var_8858;
	}

	scripts\sp\_utility::func_9199(var_01,0);
	var_02 = function_0072("bad_guys");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.var_884A))
		{
			var_04 scripts\sp\_utility::func_F3E6(var_04.var_884A);
		}

		var_04 notify("player_hack_faded_out");
	}

	level.var_ECA4["autopickup"] = 1;
	if(isalive(level.player))
	{
		level.player.var_9BA2 = 0;
		level.player.var_9BFA = 0;
		if(scripts\sp\_utility::func_93A6())
		{
			level.player.health = level.player.var_C384;
			level.player.maxhealth = level.player.og_maxhealth;
		}
		else
		{
			level.player.health = level.player.og_maxhealth;
		}

		if(isdefined(level.var_CFEF))
		{
			level.player dodamage(level.var_CFEF,level.player.origin);
			level.var_CFEF = undefined;
		}

		var_02 = function_0072("bad_guys");
		scripts\common\utility::array_thread(var_02,::func_19C8,0);
		level.player thread func_2A48();
		level.var_880A thread func_E44E();
		level.player method_834E();
		if(isdefined(level.player.var_883C))
		{
			level.player.var_883C unlink();
			level.player.var_883C dontinterpolate();
			level.player.var_883C.origin = level.player.var_C391;
			level.player.var_883C.angles = level.player.var_C378;
			level.player method_81DF(0,0,0,0,0,0,0);
			scripts\common\utility::func_5127(0.1,::func_62D5,level.player.var_C396);
		}
		else
		{
			level.player setorigin(level.player.var_C391);
			if(isdefined(level.var_880A) && isalive(level.var_880A))
			{
				var_06 = vectortoangles(level.var_880A.origin - level.player.origin);
				level.player setplayerangles(var_06);
			}
			else
			{
				level.player setplayerangles(level.player.var_C378);
			}
		}

		if(!isdefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee)
		{
			level.player.var_5966 = 1;
		}

		level.player scripts\common\utility::func_5127(3,::func_B2B5);
		level.player method_8389();
		level.player method_8014(0);
		level.player method_800E(1);
		level.player thermalvisionoff();
		level.player scripts\common\utility::func_1C67(1);
		level.player scripts\common\utility::func_1C53(0);
		level.player scripts\common\utility::func_1C42(1);
		level.player scripts\common\utility::func_1C70(1);
		level.player scripts\common\utility::func_1C60(1);
		level.player setstance(level.player.var_C396);
		level.player.var_C396 = undefined;
		level.player scripts\common\utility::func_1C3A(0);
		level.player enableweaponpickup();
		if(scripts\common\utility::istrue(level.var_884F))
		{
			scripts\sp\_utility::func_CF8D();
			level.var_884F = undefined;
		}

		if(!getdvarint("exec_review",0))
		{
			level.player method_80CB(0);
		}

		level.player scripts\sp\_utility::func_1C75(1);
		level.player method_8559(1);
		lib_0E4B::func_8E0A();
		level.player lib_0E42::func_E150("specialty_fastreload");
		level.player method_84FD();
		level.player method_8475();
		level.var_87FF = undefined;
		if(isdefined(level.player.var_8860))
		{
			level.player scripts\common\utility::func_1C6E(0);
			level.player.var_8860 = undefined;
		}

		if(param_00 == "flying")
		{
			level.player scripts\common\utility::func_1C40(1);
		}
		else if(param_00 == "C6")
		{
			func_61E0(0);
		}
		else if(param_00 == "C8")
		{
			func_61E2(0);
		}
		else if(param_00 == "C6Worker")
		{
			func_61E1(0);
		}

		lib_0B2A::func_E2C0();
		level.player notify("hack_returned_to_player_position");
		scripts\common\utility::flag_wait("hack_hud_control_outro_finished");
		if(isdefined(level.player.var_885B))
		{
			func_61D0();
			level.player.var_885B = undefined;
		}

		level.player scripts\common\utility::func_5127(0.4,::func_2A49);
		level.player scripts\common\utility::allow_jump(1);
		level.player scripts\common\utility::func_1C52(1);
		level.player scripts\common\utility::delaycall(0.3,::method_80A6);
		for(var_07 = 0;var_07 < level.player.var_C39E.size;var_07++)
		{
			var_08 = level.player.var_C39E[var_07];
			level.player giveweapon(var_08.var_394);
			level.player setweaponammoclip(var_08.var_394,var_08.var_1E40);
			level.player setweaponammostock(var_08.var_394,var_08.var_1E4D);
		}

		level.player switchtoweapon(level.player.var_C37C);
		if(isdefined(level.player.var_C376) && level.player.var_C376 != "")
		{
			level.player scripts\sp\_utility::func_8294(level.player.var_C376);
		}

		level.player.var_C376 = undefined;
		level.player scripts\sp\_utility::func_65DD("is_hacked_robot");
		func_8793();
	}
}

//Function Number: 116
func_62D5(param_00)
{
	var_01 = ["stand","crouch","prone"];
	var_01 = scripts\common\utility::func_22A9(var_01,param_00);
	foreach(var_03 in var_01)
	{
		if(var_03 == "stand")
		{
			level.player scripts\common\utility::func_1C68(0);
		}

		if(var_03 == "crouch")
		{
			level.player scripts\common\utility::func_1C40(0);
		}

		if(var_03 == "prone")
		{
			level.player scripts\common\utility::func_1C60(0);
		}
	}

	level.player setstance(param_00);
	wait(1);
	level.player unlink();
	level.player.var_883C delete();
	foreach(var_03 in var_01)
	{
		if(var_03 == "stand")
		{
			level.player scripts\common\utility::func_1C68(1);
		}

		if(var_03 == "crouch")
		{
			level.player scripts\common\utility::func_1C40(1);
		}

		if(var_03 == "prone")
		{
			level.player scripts\common\utility::func_1C60(1);
		}
	}
}

//Function Number: 117
func_2A49()
{
	level.player scripts\sp\_utility::func_2B76(1,0.5);
}

//Function Number: 118
func_8793(param_00)
{
	level.player.var_883D = "end";
	self method_80AA();
	if(isdefined(level.var_D365))
	{
		level.var_D365 show();
		lib_0B06::func_1EC7(level.var_D365,"hack_control_end");
		if(isdefined(level.var_D365))
		{
			level.var_D365 delete();
		}
	}

	level.var_D365 = undefined;
	self enableweapons();
	if(!isdefined(param_00) || !param_00)
	{
		level.player thread hacking_end();
	}

	self.var_8824 = 1;
	level.player scripts\sp\_utility::func_65E1("hack_control_outro_done");
}

//Function Number: 119
func_2A48()
{
	level.player notify("stop drone sounds");
	if(isdefined(level.player.var_10466))
	{
		level.player.var_10466 unlink();
		level.player.var_10466 delete();
	}
}

//Function Number: 120
func_6AFD()
{
	if(!isdefined(level.var_6AFC))
	{
		return;
	}

	level.var_6AFC.angles = level.player.angles;
	level.var_6AFC.origin = level.player.origin;
	var_00 = level.var_6AFC method_838F();
	var_01 = level.player getmovingplatformparent();
	if(isdefined(var_01))
	{
		var_00 linkto(var_01);
	}

	level.player.var_6AF9 = var_00;
	var_00 method_83D0(#animtree);
	var_00.var_1FBB = "fake_player";
	var_00 thread lib_0B06::func_1EEA(var_00,"drone_use_idle","stop_loop");
	level.player waittill("faded_out");
	var_00 method_83A1();
	var_00 method_81D0();
	wait(0.05);
	var_00 delete();
}

//Function Number: 121
func_54FD()
{
	level.player method_84CE(["trigger_hurt"]);
}

//Function Number: 122
func_61D0()
{
	level.player method_84CD();
}

//Function Number: 123
func_E5B9(param_00,param_01)
{
	var_02 = -1;
	for(var_03 = 0;var_03 < 24;var_03++)
	{
		if(level.var_87FF[var_03] == 0)
		{
			var_02 = var_03;
			level.var_87FF[var_03] = 1;
			break;
		}
	}

	if(getdvarint("exec_review"))
	{
		return var_02;
	}

	if(var_02 != -1)
	{
		setomnvar("ui_reticles_" + var_02 + "_target_ent",param_00);
		setomnvar("ui_reticles_" + var_02 + "_lock_state",param_01);
	}

	return var_02;
}

//Function Number: 124
func_E5B8(param_00)
{
	level.var_87FF[param_00] = 0;
	setomnvar("ui_reticles_" + param_00 + "_target_ent",undefined);
	setomnvar("ui_reticles_" + param_00 + "_lock_state",0);
}

//Function Number: 125
func_79CE(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_02 - param_00);
	var_04 = anglestoforward(param_01);
	var_05 = vectordot(var_04,var_03);
	return var_05;
}

//Function Number: 126
func_919C()
{
	var_00 = [];
	var_00["r_hudoutlineWidth"] = 2;
	var_00["r_hudoutlineFillColor0"] = "1 1 1 0.8";
	var_00["r_hudoutlineFillColor1"] = "1 1 1 0.8";
	var_00["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
	var_00["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.8";
	var_00["r_hudoutlineOccludedInteriorColor"] = "1 1 1 0.8";
	var_00["r_hudOutlineOccludedColorFromFill"] = 1;
	return var_00;
}

//Function Number: 127
func_91A4()
{
	var_00 = [];
	var_00["r_hudoutlineWidth"] = 1;
	var_00["r_hudoutlineFillColor0"] = "1 1 1 0.4";
	var_00["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 0.4";
	var_00["r_hudoutlineOccludedOutlineColor"] = "1 1 1 0";
	var_00["r_hudoutlineOccludedInlineColor"] = "0.6 0.6 0.6 0.8";
	var_00["r_hudoutlineOccludedInteriorColor"] = "0.6 0.6 0.6 0.1";
	var_00["r_hudOutlineOccludedColorFromFill"] = 1;
	return var_00;
}

//Function Number: 128
func_8784()
{
	level.var_EC87["player_arms"] = #animtree;
	level.var_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
	level.var_EC85["generic"]["hack_control_end"] = %vm_gauntlet_hack_control_end;
}

//Function Number: 129
func_E578()
{
	level.var_EC85["generic"]["robot_hacked"][0] = %pain_electric_claymore;
}

//Function Number: 130
func_D304()
{
	level.var_EC85["fake_player"]["drone_use_idle"][0] = %shipcrib_crouch_point_idle_01;
}

//Function Number: 131
player_lookat_ent_wrapper(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("entitydeleted");
	func_1D5E(param_00,param_01);
}

//Function Number: 132
is_console()
{
	return level.console;
}

//Function Number: 133
is_mouse_and_keyboard()
{
	if(is_console())
	{
		return 0;
	}

	return !level.player usinggamepad();
}

//Function Number: 134
hack_toggled_off_think()
{
	self endon("death");
	self endon("hack_unequipped");
	self endon("stop_hack_disabled_think");
	self notify("hack_toggled_off_think");
	self endon("hack_toggled_off_think");
	scripts\common\utility::waittill_any_3("secondary_equipment_pressed","hack_weap_switch","hack_input_on_locked_robot");
	level.player scripts\sp\_utility::func_65E1("hack_toggled_off");
	level.player notify("hack_toggled_off");
}

//Function Number: 135
hacking_locked_fire_think()
{
	self endon("hack_unequipped");
	self endon("hack_disabled");
	self endon("hack_locked_hold_done");
	self waittill("hack_fire");
	level.player scripts\sp\_utility::func_65E1("hack_toggle_fired");
}