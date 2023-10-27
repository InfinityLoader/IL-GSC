/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_challenges.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 60
 * Decompile Time: 3092 ms
 * Timestamp: 10/27/2023 12:06:14 AM
*******************************************************************/

//Function Number: 1
register_default_challenges()
{
	scripts\common\utility::flag_init("pause_challenges");
	scripts\cp\zombies\solo_challenges::func_DEA1("long_shot",undefined,0,::transponder_challenge_success_func,undefined,::func_15CC,::func_4DB0,undefined,::func_7779);
	scripts\cp\zombies\solo_challenges::func_DEA1("kill_melee",undefined,0,::rewind_challenge_success_func,undefined,::func_7742,::blank_deactivate_challenge,undefined,::func_7779);
	scripts\cp\zombies\solo_challenges::func_DEA1("kill_crawlers",undefined,0,::armageddon_challenge_success_func,undefined,::func_7742,::blank_deactivate_challenge,undefined,::func_7779);
	scripts\cp\zombies\solo_challenges::func_DEA1("multikills",undefined,0,::blackhole_challenge_success_func,undefined,::func_7742,::blank_deactivate_challenge,undefined,::func_7779);
	scripts\cp\zombies\solo_challenges::func_DEA1("window_boards",undefined,0,::repulsor_challenge_success_func,undefined,::func_15FE,::blank_deactivate_challenge,undefined,::func_7779);
	scripts\cp\zombies\solo_challenges::func_DEA1("challenge_failed",undefined,0,undefined,undefined,::scripts\cp\zombies\solo_challenges::func_5010,::scripts\cp\zombies\solo_challenges::func_5010,undefined,undefined);
	scripts\cp\zombies\solo_challenges::func_DEA1("challenge_success",undefined,0,undefined,undefined,::scripts\cp\zombies\solo_challenges::func_5010,::scripts\cp\zombies\solo_challenges::func_5010,undefined,undefined);
	scripts\cp\zombies\solo_challenges::func_DEA1("next_challenge",undefined,0,undefined,undefined,::scripts\cp\zombies\solo_challenges::func_5010,::scripts\cp\zombies\solo_challenges::func_5010,undefined,undefined);
	level.challenge_list = ["long_shot","kill_melee","kill_crawlers","multikills","window_boards"];
}

//Function Number: 2
func_7742(param_00)
{
	param_00 scripts\cp\zombies\solo_challenges::func_5010();
	param_00.var_4B4A.var_4BA0 = 0;
	param_00 scripts\cp\zombies\solo_challenges::func_12D9E(0,param_00.var_4B4A.var_155);
}

//Function Number: 3
func_7779(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_4B4A.var_4BA0 = self.var_4B4A.var_4BA0 + param_00;
	if(self.var_4B4A.var_4BA0 >= self.var_4B4A.var_155)
	{
		self.var_4B4A.var_111AE = 1;
	}

	scripts\cp\zombies\solo_challenges::func_12D9E(self.var_4B4A.var_4BA0,self.var_4B4A.var_155);
	if(self.var_4B4A.var_111AE)
	{
		self notify("current_challenge_ended");
		scripts\cp\zombies\solo_challenges::func_4DAE(self);
		return;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		self notify("current_challenge_ended");
		self.var_4B4A.var_111AE = 0;
		scripts\cp\zombies\solo_challenges::func_4DAE(self);
	}
}

//Function Number: 4
enable_interaction_on_new_or_completed_challenge(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	var_03 = param_01 scripts\common\utility::waittill_any_return_no_endon_death_3("challenge_complete","new_challenge_started");
	scripts\cp\_interaction::func_175D(param_00,param_01);
	if(var_03 == "new_challenge_started" && isdefined(param_02))
	{
		level thread [[ param_02 ]](param_01);
	}
}

//Function Number: 5
rave_challenge_activate(param_00,param_01,param_02,param_03)
{
	scripts\cp\zombies\solo_challenges::func_15D7(param_00,param_01);
	scripts\cp\_interaction::func_E01A(param_02,param_01);
	level thread enable_interaction_on_new_or_completed_challenge(param_02,param_01,param_03);
	param_01.current_challenge_kiosk = get_client_challenge_station(param_01,param_02);
	param_01.current_challenge_kiosk setscriptablepartstate("light","complete");
	playsoundatpos(param_01.current_challenge_kiosk.origin,"challenge_station_light");
}

//Function Number: 6
get_client_challenge_station(param_00,param_01)
{
	var_02 = param_00 getentitynumber();
	foreach(var_04 in param_01.challenge_stations)
	{
		if(int(var_04.script_noteworthy) == var_02)
		{
			return var_04;
		}
	}
}

//Function Number: 7
activate_armageddon_challenge(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_armageddon_badge))
	{
		rave_challenge_activate("kill_crawlers",param_01,param_00);
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	var_02 = "power_armageddon";
	if(isdefined(level.var_D782[var_02].var_504B))
	{
		var_03 = level.var_D782[var_02].var_504B;
	}
	else
	{
		var_03 = "secondary";
	}

	param_01 playlocalsound("purchase_generic");
	param_01 scripts\cp\powers\coop_powers::func_8397(var_02,var_03,undefined,undefined,undefined,0,0);
	param_01 thread challenge_interaction_cooldown(param_00,2);
}

//Function Number: 8
armageddon_challenge_success_func(param_00)
{
	param_00.has_armageddon_badge = 1;
	param_00 setclientomnvarbit("zm_challenges_completed",5,1);
	param_00 scripts\cp\_merits::func_D9AD("mt_dlc1_challenge_badge");
	param_00 notify("rave_challenge_badge_notify");
	param_00 add_to_completed_challenges("armageddon");
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 9
armageddon_challenge_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_armageddon_badge))
	{
		return &"CP_RAVE_CHALLENGES_ARMAGEDDON_CHALLENGE";
	}

	return &"CP_RAVE_CHALLENGES_PURCHASE_ARMAGEDDON";
}

//Function Number: 10
activate_repulsor_challenge(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_repulsor_badge))
	{
		rave_challenge_activate("window_boards",param_01,param_00);
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	var_02 = "power_repulsor";
	if(isdefined(level.var_D782[var_02].var_504B))
	{
		var_03 = level.var_D782[var_02].var_504B;
	}
	else
	{
		var_03 = "secondary";
	}

	param_01 playlocalsound("purchase_generic");
	param_01 scripts\cp\powers\coop_powers::func_8397(var_02,var_03,undefined,undefined,undefined,0,0);
	param_01 thread challenge_interaction_cooldown(param_00,2);
}

//Function Number: 11
repulsor_challenge_success_func(param_00)
{
	param_00.has_repulsor_badge = 1;
	param_00 setclientomnvarbit("zm_challenges_completed",3,1);
	param_00 scripts\cp\_merits::func_D9AD("mt_dlc1_challenge_badge");
	param_00 notify("rave_challenge_badge_notify");
	param_00 add_to_completed_challenges("repulsor");
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 12
repulsor_challenge_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_repulsor_badge))
	{
		return &"CP_RAVE_CHALLENGES_REPULSOR_CHALLENGE";
	}

	return &"CP_RAVE_CHALLENGES_PURCHASE_REPULSOR";
}

//Function Number: 13
activate_blackhole_challenge(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_blackhole_badge))
	{
		rave_challenge_activate("multikills",param_01,param_00);
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	var_02 = "power_blackholeGrenade";
	if(isdefined(level.var_D782[var_02].var_504B))
	{
		var_03 = level.var_D782[var_02].var_504B;
	}
	else
	{
		var_03 = "secondary";
	}

	param_01 playlocalsound("purchase_generic");
	param_01 scripts\cp\powers\coop_powers::func_8397(var_02,var_03,undefined,undefined,undefined,0,0);
	param_01 thread challenge_interaction_cooldown(param_00,2);
}

//Function Number: 14
blackhole_challenge_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_blackhole_badge))
	{
		return &"CP_RAVE_CHALLENGES_BLACKHOLE_CHALLENGE";
	}

	return &"CP_RAVE_CHALLENGES_PURCHASE_BLACKHOLE";
}

//Function Number: 15
blackhole_challenge_success_func(param_00)
{
	param_00.has_blackhole_badge = 1;
	param_00 setclientomnvarbit("zm_challenges_completed",2,1);
	param_00 scripts\cp\_merits::func_D9AD("mt_dlc1_challenge_badge");
	param_00 notify("rave_challenge_badge_notify");
	param_00 add_to_completed_challenges("blackhole");
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 16
activate_transponder_challenge(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_transponder_badge))
	{
		rave_challenge_activate("long_shot",param_01,param_00,::func_4DB0);
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	var_02 = "power_transponder";
	if(isdefined(level.var_D782[var_02].var_504B))
	{
		var_03 = level.var_D782[var_02].var_504B;
	}
	else
	{
		var_03 = "secondary";
	}

	param_01 playlocalsound("purchase_generic");
	param_01 scripts\cp\powers\coop_powers::func_8397(var_02,var_03,undefined,undefined,undefined,0,0);
	param_01 thread challenge_interaction_cooldown(param_00,2);
}

//Function Number: 17
transponder_challenge_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_transponder_badge))
	{
		return &"CP_RAVE_CHALLENGES_TRANSPONDER_CHALLENGE";
	}

	return &"CP_RAVE_CHALLENGES_PURCHASE_TRANSPONDER";
}

//Function Number: 18
transponder_challenge_success_func(param_00)
{
	param_00.has_transponder_badge = 1;
	param_00 setclientomnvarbit("zm_challenges_completed",4,1);
	param_00 scripts\cp\_merits::func_D9AD("mt_dlc1_challenge_badge");
	param_00 notify("rave_challenge_badge_notify");
	param_00 add_to_completed_challenges("transponder");
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 19
activate_rewind_challenge(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_rewind_badge))
	{
		rave_challenge_activate("kill_melee",param_01,param_00);
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	var_02 = "power_rewind";
	if(isdefined(level.var_D782[var_02].var_504B))
	{
		var_03 = level.var_D782[var_02].var_504B;
	}
	else
	{
		var_03 = "secondary";
	}

	param_01 playlocalsound("purchase_generic");
	param_01 scripts\cp\powers\coop_powers::func_8397(var_02,var_03,undefined,undefined,undefined,0,0);
	param_01 thread challenge_interaction_cooldown(param_00,2);
}

//Function Number: 20
rewind_challenge_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_rewind_badge))
	{
		return &"CP_RAVE_CHALLENGES_REWIND_CHALLENGE";
	}

	return &"CP_RAVE_CHALLENGES_PURCAHSE_REWIND";
}

//Function Number: 21
rewind_challenge_success_func(param_00)
{
	param_00.has_rewind_badge = 1;
	param_00 setclientomnvarbit("zm_challenges_completed",1,1);
	param_00 scripts\cp\_merits::func_D9AD("mt_dlc1_challenge_badge");
	param_00 notify("rave_challenge_badge_notify");
	param_00 add_to_completed_challenges("rewind");
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 22
add_to_completed_challenges(param_00)
{
	if(!isdefined(self.completed_challenges))
	{
		self.completed_challenges = [];
	}

	self.completed_challenges = scripts\common\utility::array_add_safe(self.completed_challenges,param_00);
	if(self.completed_challenges.size == level.challenge_list.size)
	{
		lib_0D2A::func_12D7C("TOP_CAMPER",1);
	}

	self.current_challenge_kiosk.var_9A09.var_D719 hudoutlineenableforclient(self,3,1,1);
}

//Function Number: 23
power_visiblity_monitor(param_00,param_01)
{
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03.completed_challenges))
			{
				param_00 method_8429(var_03);
			}
			else if(!scripts\common\utility::func_2286(var_03.completed_challenges,param_01))
			{
				param_00 method_8429(var_03);
			}
			else
			{
				param_00 showtoplayer(var_03);
			}

			wait(0.05);
		}

		wait(1);
	}
}

//Function Number: 24
challenge_station_visibility_monitor()
{
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			var_02 = var_01 getentitynumber();
			if(int(self.script_noteworthy) != var_02)
			{
				self method_8429(var_01);
			}
			else
			{
				self showtoplayer(var_01);
				if(isdefined(var_01.completed_challenges) && scripts\common\utility::func_2286(var_01.completed_challenges,self.var_9A09.var_EEFA))
				{
					self setscriptablepartstate("light","complete");
				}
				else if(isdefined(var_01.current_challenge_kiosk) && self == var_01.current_challenge_kiosk)
				{
					self setscriptablepartstate("light","complete");
				}
				else
				{
					self setscriptablepartstate("light","off");
				}
			}

			wait(0.05);
		}

		wait(1);
	}
}

//Function Number: 25
func_15FE(param_00)
{
	func_7742(param_00);
	param_00 thread func_13D38();
}

//Function Number: 26
func_13D38()
{
	self endon("stop_windowboard_logic");
	self endon("challenge_deactivated");
	self endon("new_challenge_started");
	self endon("disconnect");
	for(;;)
	{
		level waittill("reboard",var_00,var_01);
		if(self != var_01)
		{
			continue;
		}

		scripts\cp\zombies\solo_challenges::func_12D9C("window_boards",var_00);
	}
}

//Function Number: 27
blank_deactivate_challenge(param_00)
{
}

//Function Number: 28
add_to_dismember_queue(param_00)
{
	if(!isdefined(level.dismember_queue))
	{
		level.dismember_queue = [];
	}

	var_01 = spawnstruct();
	var_01.var_ACD9 = param_00;
	var_01.processed = 0;
	level.dismember_queue = scripts\common\utility::array_add_safe(level.dismember_queue,var_01);
}

//Function Number: 29
func_15A6()
{
	level.dismember_queue_func = ::add_to_dismember_queue;
	level.dismember_queue = [];
	func_7742();
	level thread func_565B("arm");
}

//Function Number: 30
func_15A7()
{
	level.dismember_queue_func = ::add_to_dismember_queue;
	level.dismember_queue = [];
	func_7742();
	level thread func_565B("leg");
}

//Function Number: 31
func_565B(param_00)
{
	level endon("stop_dismember_logic");
	level endon("challenge_deactivated");
	for(;;)
	{
		if(level.dismember_queue.size > 0)
		{
			foreach(var_02 in level.dismember_queue)
			{
				if(var_02.processed)
				{
					continue;
				}

				if(param_00 == "arm")
				{
					if(var_02.var_ACD9 == 1 || var_02.var_ACD9 == 2)
					{
						scripts\cp\zombies\solo_challenges::func_12D9C("dismember_arm",1);
					}
				}
				else if(param_00 == "leg")
				{
					if(var_02.var_ACD9 == 4 || var_02.var_ACD9 == 8)
					{
						scripts\cp\zombies\solo_challenges::func_12D9C("dismember_leg",1);
					}
				}

				var_02.processed = 1;
			}

			level.dismember_queue = [];
		}

		wait(0.1);
	}
}

//Function Number: 32
func_4DAF()
{
	level.dismember_queue_func = undefined;
	level.dismember_queue = undefined;
	level notify("stop_dismember_logic");
	scripts\cp\zombies\solo_challenges::func_5010();
}

//Function Number: 33
func_15CC(param_00)
{
	func_7742(param_00);
	param_00 thread func_5700("long_shot");
}

//Function Number: 34
func_1597()
{
	func_7742();
	level thread func_5700("close_shot");
}

//Function Number: 35
func_5700(param_00)
{
	self endon("stop_distanceshot_logic");
	self endon("challenge_deactivated");
	self endon("new_challenge_started");
	self endon("disconnect");
	for(;;)
	{
		if(scripts\common\utility::flag("pause_challenges"))
		{
			foreach(var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
			{
				if(scripts\common\utility::istrue(var_02.var_B36D))
				{
					scripts\cp\_outline::func_5561(var_02,self);
					var_02.var_B36D = undefined;
				}
			}

			scripts\common\utility::func_6E5A("pause_challenges");
		}

		foreach(var_03, var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
		{
			if(!isdefined(var_02.agent_type))
			{
				continue;
			}

			if(!scripts\cp\_utility::func_FF18(var_02,1,1) && var_02.agent_type != "zombie_brute")
			{
				continue;
			}

			var_05 = undefined;
			if(func_9BBE(self,undefined,var_02,param_00))
			{
				var_05 = 1;
				scripts\cp\_outline::func_6220(var_02,self,0,1,0,"high");
			}
			else
			{
				scripts\cp\_outline::func_5561(var_02,self);
			}

			var_02.var_B36D = var_05;
			if(var_03 % 2 == 0)
			{
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 36
func_4DB0(param_00)
{
	param_00 notify("stop_distanceshot_logic");
	wait(1);
	foreach(var_02 in scripts\mp\_mp_agent::func_7DAF())
	{
		if(!isdefined(var_02.var_B36D))
		{
			continue;
		}

		var_02.var_B36D = undefined;
		scripts\cp\_outline::func_5561(var_02,param_00);
	}
}

//Function Number: 37
func_15C7()
{
	func_7742();
	level thread func_135EC(self);
}

//Function Number: 38
func_135EC(param_00)
{
	level endon("current_challenge_ended");
	level endon("challenge_deactivated");
	level.var_C20A = 0;
	level.var_C1EF = 0;
	for(;;)
	{
		if(scripts\common\utility::flag("pause_challenges"))
		{
			foreach(var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
			{
				if(scripts\common\utility::istrue(var_02.var_B36D))
				{
					foreach(var_04 in level.players)
					{
						scripts\cp\_outline::func_5561(var_02,var_04);
					}

					level.var_C20A--;
					var_02.var_B36D = undefined;
				}
			}

			scripts\common\utility::func_6E5A("pause_challenges");
		}

		var_07 = scripts\mp\_mp_agent::func_7DAF();
		foreach(var_02 in var_07)
		{
			if(!scripts\cp\_utility::func_FF18(var_02,1,1))
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_02.var_B36D))
			{
				continue;
			}

			var_02.var_B36D = 1;
			scripts\cp\_outline::func_621F(var_02,0,1,0);
			var_02 thread func_E068();
			level.var_C20A++;
			while(level.var_C20A >= param_00.var_155)
			{
				if(scripts\common\utility::flag("pause_challenges"))
				{
					foreach(var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
					{
						if(scripts\common\utility::istrue(var_02.var_B36D))
						{
							foreach(var_04 in level.players)
							{
								scripts\cp\_outline::func_5561(var_02,var_04);
							}

							level.var_C20A--;
							var_02.var_B36D = undefined;
						}
					}

					scripts\common\utility::func_6E5A("pause_challenges");
				}

				wait(0.1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 39
func_4DC2()
{
	foreach(var_01 in scripts\mp\_mp_agent::func_7DAF())
	{
		if(isdefined(var_01.var_B36D))
		{
			var_01.var_B36D = undefined;
			scripts\cp\_outline::func_5560(var_01);
		}
	}

	scripts\cp\zombies\solo_challenges::func_5010();
}

//Function Number: 40
func_158B()
{
	func_7742();
	level thread func_2134(self);
}

//Function Number: 41
func_2134(param_00)
{
	var_01 = scripts\cp\zombies\zombies_spawning::func_7C83(undefined,1);
	var_02 = scripts\common\utility::random(var_01);
	if(!isdefined(var_02))
	{
		var_02 = spawnstruct();
		var_02.var_28AB = "moon";
	}
	else if(var_02.var_28AB == "arcade_back" || var_02.var_28AB == "underground_route" || var_02.var_28AB == "hidden_room")
	{
		var_02 = spawnstruct();
		var_02.var_28AB = "moon";
	}

	var_03 = func_7A64(var_02);
	level.var_2132 = spawnfx(level._effect["challenge_ring"],var_03.origin + (0,0,-15),anglestoforward((0,0,0)),anglestoup((0,0,0)));
	level.var_3C11 = spawnstruct();
	level.var_3C11.origin = var_03.origin + (0,0,-20);
	level.var_3C11.var_257 = -27120;
	wait(0.1);
	triggerfx(level.var_2132);
	wait(0.1);
}

//Function Number: 42
func_7A64(param_00)
{
	var_01 = scripts\common\utility::getstructarray("area_kill_" + param_00.var_28AB,"targetname");
	return scripts\common\utility::random(var_01);
}

//Function Number: 43
func_4DA8(param_00)
{
	scripts\cp\zombies\solo_challenges::func_5010();
	level.var_2132 delete();
	level.var_3C11 = undefined;
}

//Function Number: 44
func_15CB()
{
	func_7742();
}

//Function Number: 45
func_4DC3(param_00)
{
	func_4DB0();
}

//Function Number: 46
func_15C8()
{
	func_7742();
	level thread func_6AC2(self);
	foreach(var_01 in level.players)
	{
		var_01 thread func_A5F8();
	}
}

//Function Number: 47
func_6AC2(param_00)
{
	level endon("kill_nodamage_complete");
	level endon("challenge_deactivated");
	level waittill("kill_nodamage_failed");
	param_00.var_111AE = 0;
	scripts\cp\zombies\solo_challenges::func_4DAE();
	level notify("kill_nodamage_complete");
}

//Function Number: 48
func_A5F8()
{
	level endon("kill_nodamage_complete");
	level endon("challenge_deactivated");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(scripts\common\utility::flag("pause_challenges"))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.ability_invulnerable))
		{
			continue;
		}

		if(isdefined(var_01) && isplayer(var_01) && scripts\cp\_utility::func_9BFB())
		{
			level notify("kill_nodamage_failed");
			return;
		}
		else if(isdefined(var_01) && isagent(var_01))
		{
			level notify("kill_nodamage_failed");
			return;
		}
	}
}

//Function Number: 49
func_12DD7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_4BA0 = self.var_4BA0 + param_00;
	if(self.var_4BA0 >= self.var_155)
	{
		self.var_111AE = 1;
	}

	scripts\cp\zombies\solo_challenges::func_12D9E(self.var_4BA0,self.var_155);
	if(self.var_111AE)
	{
		level notify("kill_nodamage_complete");
		scripts\cp\zombies\solo_challenges::func_4DAE();
	}
}

//Function Number: 50
challenge_scalar_func(param_00)
{
	var_01 = func_7C28(param_00);
	return var_01;
}

//Function Number: 51
func_7C28(param_00)
{
	var_01 = level.var_13F16;
	var_02 = 0;
	var_03 = 1;
	var_04 = 99;
	var_05 = 1;
	var_06 = 9;
	for(var_07 = var_03;var_07 <= var_04;var_07++)
	{
		var_08 = tablelookup(var_01,var_02,var_07,var_05);
		if(var_08 == "")
		{
			return undefined;
		}

		if(var_08 != param_00)
		{
			continue;
		}

		var_09 = tablelookup(var_01,var_02,var_07,var_06);
		if(isdefined(var_09))
		{
			var_09 = strtok(var_09," ");
			if(var_09.size > 0)
			{
				return int(var_09[0]);
			}
		}
	}
}

//Function Number: 52
default_playerdamage_challenge_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_4B4A))
	{
		return 0;
	}

	if(scripts\common\utility::flag("pause_challenges"))
	{
		return 0;
	}

	switch(level.var_4B4A)
	{
		case "kill_zombiewhodamagedme":
			if(!scripts\common\utility::istrue(param_01.var_B36D))
			{
				param_01 hudoutlineenableforclient(self,0,1,0);
				param_01.var_B36D = 1;
			}
	
			if(!scripts\common\utility::func_2286(param_01.var_4D3C,self))
			{
				param_01.var_4D3C[param_01.var_4D3C.size] = self;
			}
			return 0;
	}

	return 1;
}

//Function Number: 53
default_death_challenge_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_01.current_player_challenge))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return 0;
	}

	switch(param_01.current_player_challenge)
	{
		case "long_shot":
			if(func_9BBE(param_01,param_04,self,"long_shot"))
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("long_shot",1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,param_01);
			}
			return 0;

		case "close_shot":
			if(func_9BBE(param_01,param_04,self,"close_shot"))
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("close_shot",1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,param_01);
			}
			return 0;

		case "jump_shot":
			if(isdefined(param_01) && isplayer(param_01) && isdefined(param_04))
			{
				if(((isdefined(self.var_A64E) && param_01 == self.var_A64E) || param_04 == param_01 getcurrentweapon()) && !param_01 isonground())
				{
					scripts\cp\zombies\solo_challenges::func_12D9C("jump_shot",1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,param_01);
				}
	
				return 0;
			}
	
			break;

		case "kill_marked":
			if(isdefined(self.var_B36D) && param_03 != "MOD_SUICIDE")
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_marked",1);
			}
			else if(param_03 != "MOD_SUICIDE" || isdefined(self.var_B36D) && param_03 == "MOD_SUICIDE")
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_marked",0,1);
			}
			return 0;

		case "kill_melee":
			if(isdefined(param_01) && isplayer(param_01) && param_03 == "MOD_MELEE" || param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2")
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_melee",1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,param_01);
			}
			return 0;

		case "kill_nodamage":
			if(isdefined(param_01) && isplayer(param_01))
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_nodamage",1);
			}
			return 0;

		case "kill_headshots":
			if(scripts\cp\_utility::func_9E27(param_04,param_06,param_03,param_01) && !isdefined(self.var_B36E))
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_headshots",1);
			}
			return 0;

		case "kill_crawlers":
			if(scripts\cp\_utility::func_9D20() && scripts\common\utility::istrue(self.var_9BAC))
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_crawlers",1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,param_01);
			}
			return 0;

		case "kill_before_enter":
			if(scripts\cp\_utility::func_9D20() && !self.entered_playspace)
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_before_enter",1);
			}
			return 0;

		case "multikills":
			if(!isdefined(param_01.lastkilltime) || !isdefined(param_01.lastmultikilltime))
			{
				return 0;
			}
	
			if(gettime() != param_01.lastkilltime)
			{
				param_01.lastkilltime = gettime();
				return 0;
			}
			else if(gettime() == param_01.lastkilltime && param_01.lastmultikilltime != gettime())
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("multikills",1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,param_01);
				param_01.lastmultikilltime = gettime();
				param_01.lastkilltime = gettime() + 50;
				return 0;
			}
			return 0;

		case "area_kills":
			if(isdefined(level.var_3C11))
			{
				if(isdefined(param_01) && isplayer(param_01))
				{
					if(distancesquared(param_01.origin,level.var_3C11.origin) < level.var_3C11.var_257)
					{
						scripts\cp\zombies\solo_challenges::func_12D9C("area_kills",1);
					}
				}
			}
			return 0;

		case "kill_zombiewhodamagedme":
			if(!isplayer(param_01))
			{
				return 0;
			}
	
			if(scripts\common\utility::func_2286(self.var_4D3C,param_01))
			{
				scripts\cp\zombies\solo_challenges::func_12D9C("kill_zombiewhodamagedme",1);
			}
	
			break;
	}

	return 1;
}

//Function Number: 54
func_9BBE(param_00,param_01,param_02,param_03)
{
	if(isplayer(param_00) && isalive(param_00) && !param_00 scripts\cp\_utility::func_9FC6())
	{
		if(param_03 == "long_shot")
		{
			return distancesquared(param_00.origin,param_02.origin) >= 90000;
		}
		else if(param_03 == "close_shot")
		{
			return distancesquared(param_00.origin,param_02.origin) <= 90000;
		}
	}

	return 0;
}

//Function Number: 55
func_E068()
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(self.var_B36D))
	{
		scripts\cp\_outline::func_5560(self);
	}
}

//Function Number: 56
func_15D9()
{
}

//Function Number: 57
func_12DF3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_111AE = 0;
	scripts\cp\_challenge::func_4DAE();
}

//Function Number: 58
func_15DA()
{
}

//Function Number: 59
func_12DF4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_111AE = 0;
	scripts\cp\_challenge::func_4DAE();
}

//Function Number: 60
challenge_interaction_cooldown(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_interaction::func_E01A(param_00,self);
	param_00.var_D719 hudoutlineenableforclient(self,1,1,1);
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		level scripts\common\utility::waittill_either("event_wave_starting","regular_wave_starting");
	}

	scripts\cp\_interaction::func_175D(param_00,self);
	param_00.var_D719 hudoutlineenableforclient(self,3,1,1);
}