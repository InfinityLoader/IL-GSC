/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\kung_fu_mode.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 106
 * Decompile Time: 5372 ms
 * Timestamp: 10/27/2023 12:04:26 AM
*******************************************************************/

//Function Number: 1
setup_kung_fu_powers()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\powers\coop_powers::func_D787("power_holdHere",::func_2B53,::func_2B53,::use_hold_here,undefined,"hold_here_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_ohStop",::func_2B53,::func_2B53,::use_oh_stop,undefined,undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_headPinch",::func_2B53,::func_2B53,::use_head_pinch,undefined,"head_pinch_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_fingerGun",::func_2B53,::func_2B53,::use_finger_gun,undefined,"finger_gun_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_neckSlice",::func_2B53,::func_2B53,::use_neck_slice,undefined,undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_wipeAway",::func_2B53,::func_2B53,::use_wipe_away,undefined,"wipe_away_used",undefined);
	level.kungfu_weapons[0] = ["iw7_fists_zm_tiger","iw7_fists_zm_monkey","iw7_fists_zm_snake","iw7_fists_zm_crane","iw7_fists_zm_dragon"];
	level.kungfu_weapons[1] = ["power_shuriken_tiger","power_fireball","power_shuriken_snake","iw7_shuriken_dragon_proj","iw7_shuriken_tiger_proj","iw7_shuriken_snake_proj","iw7_shuriken_crane_proj","power_shuriken_crane","power_shuriken_dragon"];
	level.kungfu_weapons[2] = ["power_black_hole_tiger","power_fingerGun","power_summon_pet_snake","power_holdHere","power_neckSlice","power_headPinch","power_fingerGun","power_fingerGun","power_wipeAway","power_wipeAway"];
	level.var_7456 = ::func_7383;
}

//Function Number: 2
iskungfuweapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	for(var_01 = 0;var_01 < level.kungfu_weapons.size;var_01++)
	{
		if(scripts\common\utility::func_2286(level.kungfu_weapons[var_01],param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 3
set_gourd(param_00)
{
	param_00 playlocalsound("zmb_kung_fu_gourd_pickup");
	param_00 thread watchforrightdpad(param_00);
	param_00.has_gourd = 1;
}

//Function Number: 4
unset_gourd(param_00)
{
	param_00 notify("kill_gourd_watchers");
	param_00.has_gourd = undefined;
}

//Function Number: 5
use_gourd(param_00)
{
	param_00 endon("death");
	param_00 endon("last_stand");
	param_00 endon("disconnect");
	param_00.is_using_gourd = 1;
	if(param_00 getstance() == "prone")
	{
		param_00 setstance("crouch");
	}

	param_00 scripts\common\utility::func_1C53(0);
	var_01 = param_00 getcurrentweapon();
	level thread use_gourd_handle_early_end(param_00);
	if(issubstr(var_01,"nunchucks") || issubstr(var_01,"katana"))
	{
		wait(0.75);
	}

	param_00 thread unset_gourd(param_00);
	param_00 thread playgourdgesture(param_00);
	param_00 thread sfx_use_gourd();
	if(isdefined(level.use_gourd_func))
	{
		thread [[ level.use_gourd_func ]](param_00);
	}

	wait(3.5);
	param_00 scripts\common\utility::func_1C53(1);
	param_00.is_using_gourd = 0;
	param_00 notify("no_early_end");
	thread start_tracking_kung_fu_discipline(param_00);
}

//Function Number: 6
use_gourd_handle_early_end(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("no_early_end");
	var_01 = param_00 scripts\common\utility::func_13734("death","last_stand");
	param_00 scripts\common\utility::func_1C53(1);
	param_00.is_using_gourd = 0;
}

//Function Number: 7
sfx_use_gourd()
{
	self playlocalsound("zmb_challenge_gourd_use");
	self playlocalsound("zmb_kung_fu_gourd_drink");
}

//Function Number: 8
playgourdgesture(param_00)
{
	var_01 = "crane";
	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_01 = self.kung_fu_progression.active_discipline;
	}

	thread play_gourd_vo(param_00,var_01);
	thread scripts\cp\_utility::firegesturegrenade(param_00,"iw7_gourd_zm_" + var_01);
}

//Function Number: 9
attach_fake_gourd(param_00)
{
	param_00 attach("weapon_zmb_gourd_wm","tag_accessory_left",1);
	wait(3);
	param_00 detach("weapon_zmb_gourd_wm","tag_accessory_left");
}

//Function Number: 10
play_gourd_vo(param_00,param_01)
{
	switch(param_01)
	{
		case "crane":
			param_00 thread scripts\cp\_vo::try_to_play_vo("gourd_crane","zmb_comment_vo","medium",10,0,0,1,50);
			break;

		case "tiger":
			param_00 thread scripts\cp\_vo::try_to_play_vo("gourd_tiger","zmb_comment_vo","medium",10,0,0,1,50);
			break;

		case "dragon":
			param_00 thread scripts\cp\_vo::try_to_play_vo("gourd_dragon","zmb_comment_vo","medium",10,0,0,1,50);
			break;

		case "snake":
			param_00 thread scripts\cp\_vo::try_to_play_vo("gourd_snake","zmb_comment_vo","medium",10,0,0,1,50);
			break;

		default:
			param_00 thread scripts\cp\_vo::try_to_play_vo("gourd_misc","zmb_comment_vo","medium",10,0,0,1,50);
			break;
	}
}

//Function Number: 11
watchforrightdpad(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("kill_gourd_watchers");
	param_00 setclientomnvar("zm_ui_general_two",0);
	wait(0.1);
	param_00 setclientomnvar("zm_ui_general_two",1);
	param_00 notifyonplayercommand("use_gourd","+actionslot 4");
	for(;;)
	{
		param_00 waittill("use_gourd");
		if(can_enter_kung_fu_mode(param_00))
		{
			break;
		}

		wait(0.1);
	}

	param_00 setclientomnvar("zm_ui_general_two",0);
	if(!scripts\common\utility::istrue(param_00.first_kung_fu))
	{
		param_00.first_kung_fu = 1;
		if(!scripts\common\utility::flag("first_kung_fu_mode"))
		{
			scripts\common\utility::flag_set("first_kung_fu_mode");
			increase_trainer_interaction_progression();
		}
	}

	param_00 thread use_gourd(param_00);
}

//Function Number: 12
can_enter_kung_fu_mode(param_00)
{
	if(scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.inlaststand))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_9FCB))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.playing_game))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.isrewinding))
	{
		return 0;
	}

	if(lib_0F74::func_9EFA(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.disable_kung_fu_mode))
	{
		return 0;
	}

	if(isdefined(level.clock_interaction))
	{
		if(isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == param_00)
		{
			return 0;
		}
	}

	if(isdefined(level.clock_interaction_q2))
	{
		if(isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == param_00)
		{
			return 0;
		}
	}

	if(isdefined(level.clock_interaction_q3))
	{
		if(isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == param_00)
		{
			return 0;
		}
	}

	if(scripts\common\utility::istrue(self.start_breaking_clock))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
usegourdhint(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("use_gourd");
	param_00 endon("kill_gourd_watchers");
	param_00.gourd_hint_display = 0;
	while(param_00.gourd_hint_display < 5)
	{
		param_00 scripts\cp\_utility::setlowermessage("msg_kung_fu_exit_hint",&"CP_DISCO_USE_GOURD_HINT",4);
		param_00.gourd_hint_display = param_00.gourd_hint_display + 1;
		wait(randomfloatrange(5,10));
	}
}

//Function Number: 14
use_wipe_away(param_00)
{
	self endon("disconnect");
	scripts\cp\powers\coop_powers::func_D728();
	var_01 = 250;
	if(self.chi_meter_amount - var_01 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	self playlocalsound("disco_gest_push_away");
	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_02 = self.kung_fu_progression.active_discipline;
		var_03 = level.kung_fu_upgrades[var_02].melee_weapon;
	}
	else
	{
		var_03 = scripts\cp\_utility::getvalidtakeweapon();
	}

	thread run_wipe_away_effects(self,var_03);
	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
	wait_for_gesture_length("ges_plyr_gesture041");
	self.kung_fu_exit_delay = 0;
	scripts\cp\powers\coop_powers::func_D72E();
	self notify("wipe_away_used",1);
}

//Function Number: 15
run_wipe_away_effects(param_00,param_01)
{
	param_00 endon("disconnect");
	wait(0.2);
	if(scripts\common\utility::istrue(self.crane_super))
	{
		return;
	}

	var_02 = getenemiesleftofcenter(20,750,3);
	foreach(var_04 in var_02)
	{
		if(!var_04 scripts\cp\_utility::agentisinstakillimmune())
		{
			var_04 thread throw_zombie_left(var_04.maxhealth,param_00,param_00,param_01);
		}
	}

	wait(0.6);
	var_02 = getenemiesleftofcenter(15,750,2);
	foreach(var_04 in var_02)
	{
		if(!var_04 scripts\cp\_utility::agentisinstakillimmune())
		{
			var_04 thread throw_zombie_left(var_04.maxhealth,param_00,param_00,param_01);
		}
	}

	wait(0.3);
	var_02 = getenemiesleftofcenter(10,750,1);
	foreach(var_04 in var_02)
	{
		if(!var_04 scripts\cp\_utility::agentisinstakillimmune())
		{
			var_04 thread throw_zombie_left(var_04.maxhealth,param_00,param_00,param_01);
		}
	}
}

//Function Number: 16
throw_zombie_left(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	var_04 = vectortoangles(self.origin - param_02.origin);
	var_05 = function_02D3(var_04);
	var_06 = vectornormalize(var_05) * 2000;
	self setvelocity(var_06 + (0,0,200));
	wait(0.1);
	self dodamage(self.health + 1000,param_01.origin,param_02,param_01,"MOD_UNKNOWN",param_03);
}

//Function Number: 17
use_hold_here(param_00)
{
	self endon("disconnect");
	scripts\cp\powers\coop_powers::func_D728();
	thread run_hold_here_effects(self);
	wait_for_gesture_length("ges_plyr_gesture015");
	self.kung_fu_exit_delay = 0;
	scripts\cp\powers\coop_powers::func_D72E();
	self notify("hold_here_used",1);
}

//Function Number: 18
run_hold_here_effects(param_00,param_01)
{
	param_00 endon("disconnect");
	wait(0.3);
	if(scripts\common\utility::istrue(self.crane_super))
	{
		return;
	}

	var_02 = 250;
	if(self.chi_meter_amount - var_02 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_03 = self.kung_fu_progression.active_discipline;
		param_01 = level.kung_fu_upgrades[var_03].melee_weapon;
	}
	else
	{
		param_01 = scripts\cp\_utility::getvalidtakeweapon();
	}

	var_04 = get_enemies_within_fov(50,750,8);
	var_04 = sortbydistance(var_04,self.origin);
	foreach(var_06 in var_04)
	{
		if(!var_06 scripts\cp\_utility::agentisinstakillimmune())
		{
			var_06 thread freeze_and_kill(var_06.maxhealth,param_00,param_00,param_01);
			wait(0.1);
		}
	}
}

//Function Number: 19
freeze_and_kill(param_00,param_01,param_02,param_03)
{
	self.var_9E0C = 1;
	self.crane_chi_kill = 1;
	if(self.agent_type == "karatemaster")
	{
		thread func_7383(self);
	}

	wait(1);
	self.var_9E0C = undefined;
	self dodamage(self.health + 1000,param_01.origin,param_02,param_01,"MOD_UNKNOWN",param_03);
}

//Function Number: 20
func_7383(param_00)
{
	param_00 endon("death");
	param_00.var_9E0C = 1;
	param_00.var_180 = 1;
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	param_00.var_C189 = 1;
	if(scripts\common\utility::istrue(param_00.crane_chi_kill))
	{
		thread scripts\common\utility::play_sound_in_space("chi_crane_freeze",param_00.origin);
		param_00 setscriptablepartstate("crane_chi_fx","active",1);
	}

	wait(10.1);
	param_00.var_9E0C = undefined;
}

//Function Number: 21
use_oh_stop(param_00)
{
	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
}

//Function Number: 22
use_head_pinch(param_00)
{
	self endon("disconnect");
	scripts\cp\powers\coop_powers::func_D728();
	var_01 = 250;
	if(self.chi_meter_amount - var_01 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_02 = self.kung_fu_progression.active_discipline;
		var_03 = level.kung_fu_upgrades[var_02].melee_weapon;
	}
	else
	{
		var_03 = scripts\cp\_utility::getvalidtakeweapon();
	}

	thread run_head_pinch_effects(self,var_03);
	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
	wait_for_gesture_length("ges_plyr_gesture002");
	self.kung_fu_exit_delay = 0;
	scripts\cp\powers\coop_powers::func_D72E();
	self notify("head_pinch_used",1);
}

//Function Number: 23
run_head_pinch_effects(param_00,param_01)
{
	param_00 endon("last_stand");
	param_00 endon("disconnect");
	wait(1);
	var_02 = get_enemies_within_reticle(750,10);
	foreach(var_05, var_04 in var_02)
	{
		if(!var_04 scripts\cp\_utility::agentisinstakillimmune())
		{
			thread apply_head_pinch_effects(var_04,var_05,param_01,param_00);
		}
	}

	wait(0.75);
	var_02 = get_enemies_within_reticle(750,10);
	foreach(var_05, var_04 in var_02)
	{
		if(!var_04 scripts\cp\_utility::agentisinstakillimmune())
		{
			thread apply_head_pinch_effects(var_04,var_05,param_01,param_00);
		}
	}

	wait(0.4);
	var_02 = get_enemies_within_reticle(750,10);
	foreach(var_05, var_04 in var_02)
	{
		if(!var_04 scripts\cp\_utility::agentisinstakillimmune())
		{
			thread apply_head_pinch_effects(var_04,var_05,param_01,param_00);
		}
	}
}

//Function Number: 24
apply_head_pinch_effects(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00.pinched = 1;
	if(isdefined(param_00.var_8C98))
	{
		param_00 detach(param_00.var_8C98);
	}

	param_00.var_180 = 1;
	param_00 dodamage(1,param_00.origin,param_03,param_03,"MOD_UNKNOWN",param_02);
	playfx(level._effect["head_loss"],param_00 gettagorigin("j_head"));
	param_00 setscriptablepartstate("head","detached");
	wait(0.5);
	param_00 dodamage(param_00.health + 1000,param_00.origin,param_03,param_03,"MOD_UNKNOWN",param_02);
}

//Function Number: 25
get_enemies_within_reticle(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 6;
	}

	var_02 = [];
	var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_04 = scripts\common\utility::func_782F(self.origin,var_03,undefined,24,param_00,1);
	var_05 = anglestoforward(self.angles);
	var_06 = vectornormalize(var_05) * -35;
	var_07 = 0;
	foreach(var_09 in var_04)
	{
		if(scripts\common\utility::istrue(var_09.pinched))
		{
			continue;
		}

		var_0A = 0;
		var_0B = var_09.origin;
		var_0C = self method_8409(var_09 geteye(),65,40);
		if(var_0C)
		{
			if(isdefined(param_00))
			{
				var_0D = distance2d(self.origin,var_0B);
				if(var_0D < param_00)
				{
					var_0A = 1;
				}
			}
			else
			{
				var_0A = 1;
			}
		}

		if(var_0A && var_02.size < param_01)
		{
			var_02[var_02.size] = var_09;
			var_04 = scripts\common\utility::func_22A9(var_04,var_09);
		}

		if(var_02.size >= param_01)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 26
use_finger_gun(param_00)
{
	self endon("disconnect");
	scripts\cp\powers\coop_powers::func_D728();
	var_01 = 250;
	if(self.chi_meter_amount - var_01 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	self playlocalsound("disco_gest_fingergun");
	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_02 = self.kung_fu_progression.active_discipline;
		var_03 = level.kung_fu_upgrades[var_02].melee_weapon;
	}
	else
	{
		var_03 = scripts\cp\_utility::getvalidtakeweapon();
	}

	var_04 = get_enemies_within_fov(15,750,2);
	foreach(var_07, var_06 in var_04)
	{
		if(!var_06 scripts\cp\_utility::agentisinstakillimmune())
		{
			thread apply_finger_gun_effects(var_06,var_07,var_03);
		}
	}

	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(100);
	wait_for_gesture_length("ges_plyr_gesture010");
	self.kung_fu_exit_delay = 0;
	scripts\cp\powers\coop_powers::func_D72E();
	self notify("finger_gun_used",1);
}

//Function Number: 27
apply_finger_gun_effects(param_00,param_01,param_02)
{
	param_00 endon("death");
	switch(param_01)
	{
		case 1:
			wait(0.4);
			break;

		case 0:
			wait(0.5);
			break;

		default:
			wait(0.5);
			break;
	}

	param_00 thread throw_zombie(param_00.maxhealth,self,self,0,param_02);
}

//Function Number: 28
wait_for_gesture_length(param_00)
{
	self endon("disconnect");
	self endon("last_stand");
	while(self isgestureplaying(param_00))
	{
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 29
throw_zombie(param_00,param_01,param_02,param_03,param_04)
{
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	wait(0.05);
	if(scripts\common\utility::istrue(param_03))
	{
		self.nocorpse = 1;
		self.full_gib = 1;
		if(isdefined(param_02))
		{
			self dodamage(self.health + 1000,self.origin,param_02,param_02,"MOD_UNKNOWN",param_04);
			return;
		}

		self dodamage(self.health + 1000,self.origin,level.players[0],level.players[0],"MOD_UNKNOWN",param_04);
		return;
	}

	self setvelocity(vectornormalize(self.origin - param_01.origin) * 500 + (0,0,100));
	wait(0.1);
	if(isdefined(param_02))
	{
		self dodamage(self.health + 1000,param_01.origin,param_02,param_01,"MOD_UNKNOWN",param_04);
		return;
	}

	self dodamage(self.health + 1000,param_01.origin,param_01,param_01,"MOD_UNKNOWN",param_04);
}

//Function Number: 30
use_neck_slice(param_00)
{
	self endon("disconnect");
	scripts\cp\powers\coop_powers::func_D728();
	thread run_neck_slice_logic();
	var_01 = self method_8443("ges_plyr_gesture010");
	wait(var_01 - 1);
	self.kung_fu_exit_delay = 0;
	scripts\cp\powers\coop_powers::func_D72E();
	self notify("neck_slice_used",1);
}

//Function Number: 31
run_neck_slice_logic()
{
	self endon("disconnect");
	wait(0.3);
	if(scripts\common\utility::istrue(self.dragon_super))
	{
		return;
	}

	var_00 = 250;
	if(self.chi_meter_amount - var_00 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	self playlocalsound("chi_dragon_activate");
	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_01 = self.kung_fu_progression.active_discipline;
		var_02 = level.kung_fu_upgrades[var_01].melee_weapon;
	}
	else
	{
		var_02 = scripts\cp\_utility::getvalidtakeweapon();
	}

	var_03 = 1;
	var_04 = 5;
	for(;;)
	{
		if(var_03 > var_04)
		{
			break;
		}

		var_05 = get_enemies_within_fov(50,750,8);
		var_06 = [];
		foreach(var_08 in var_05)
		{
			if(!scripts\common\utility::istrue(var_08.dragon_chi))
			{
				var_06[var_06.size] = var_08;
			}
		}

		var_05 = var_06;
		if(var_05.size > 0)
		{
			var_05 = sortbydistance(var_05,self.origin);
			var_0A = var_05[0];
			if(!var_0A scripts\cp\_utility::agentisinstakillimmune())
			{
				if(var_03 == 0)
				{
					thread scripts\common\utility::play_sound_in_space("chi_dragon_strike_first",var_0A.origin);
				}
				else
				{
					thread scripts\common\utility::play_sound_in_space("chi_dragon_strike",var_0A.origin);
				}

				thread remove_head_and_kill(var_0A,var_02);
			}
		}

		var_03++;
		wait(0.1);
	}

	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
}

//Function Number: 32
remove_head_and_kill(param_00,param_01)
{
	param_00 endon("death");
	param_00.var_EF64 = 1;
	param_00.dragon_chi = 1;
	param_00 method_82EF(self.origin);
	wait(0.1);
	param_00 setscriptablepartstate("dragon_chi_fx","active",1);
	wait(0.4);
	thread scripts\common\utility::play_sound_in_space("chi_dragon_blood",param_00.origin);
	var_02 = playfxontag(level._effect["blood_fountain"],param_00,"J_neck");
	param_00.var_EF64 = 1;
	param_00 method_82EF(param_00.origin);
	wait(0.5);
	param_00 thread kill_zombie(self,param_01);
}

//Function Number: 33
kill_zombie(param_00,param_01)
{
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	self.dragon_chi = undefined;
	wait(0.05);
	if(isdefined(param_00))
	{
		self dodamage(self.health + 1000,self.origin,param_00,param_00,"MOD_UNKNOWN",param_01);
		return;
	}

	self dodamage(self.health + 1000,self.origin,level.players[0],level.players[0],"MOD_UNKNOWN",param_01);
}

//Function Number: 34
getenemiesleftofcenter(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = [];
	var_04 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_05 = scripts\common\utility::func_782F(self.origin,var_04,undefined,24,param_01,1);
	var_06 = anglestoforward(self.angles);
	var_07 = vectornormalize(var_06) * -35;
	var_08 = 0;
	var_09 = anglestoup(self.angles);
	for(var_0A = 1;var_0A <= param_00;var_0A++)
	{
		if(var_05.size < 1)
		{
			break;
		}

		if(var_08)
		{
			break;
		}

		var_0B = cos(var_0A);
		foreach(var_0D in var_05)
		{
			var_0E = 0;
			var_0F = var_0D.origin;
			var_10 = vectornormalize(var_0D.origin - self.origin);
			var_11 = scripts\common\utility::func_1E7D(var_06,var_10,var_09);
			if(var_11 > 0 && var_11 < 30)
			{
				if(isdefined(param_01))
				{
					var_12 = distance2d(self.origin,var_0F);
					if(var_12 < param_01)
					{
						var_0E = 1;
					}
				}
				else
				{
					var_0E = 1;
				}
			}

			if(var_0E && var_03.size < param_02)
			{
				var_03[var_03.size] = var_0D;
				var_05 = scripts\common\utility::func_22A9(var_05,var_0D);
			}

			if(var_03.size >= param_02)
			{
				var_08 = 1;
				break;
			}
		}
	}

	return var_03;
}

//Function Number: 35
get_enemies_within_fov(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = [];
	var_04 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_05 = scripts\common\utility::func_782F(self.origin,var_04,undefined,24,param_01,1);
	var_06 = anglestoforward(self.angles);
	var_07 = vectornormalize(var_06) * -35;
	var_08 = 0;
	for(var_09 = 1;var_09 <= param_00;var_09++)
	{
		if(var_05.size < 1)
		{
			break;
		}

		if(var_08)
		{
			break;
		}

		var_0A = cos(var_09);
		foreach(var_0C in var_05)
		{
			var_0D = 0;
			var_0E = var_0C.origin;
			var_0F = scripts\common\utility::func_13D90(self geteye() + var_07,self.angles,var_0E + (0,0,30),var_0A);
			if(var_0F)
			{
				if(isdefined(param_01))
				{
					var_10 = distance2d(self.origin,var_0E);
					if(var_10 < param_01)
					{
						var_0D = 1;
					}
				}
				else
				{
					var_0D = 1;
				}
			}

			if(var_0D && var_03.size < param_02)
			{
				var_03[var_03.size] = var_0C;
				var_05 = scripts\common\utility::func_22A9(var_05,var_0C);
			}

			if(var_03.size >= param_02)
			{
				var_08 = 1;
				break;
			}
		}
	}

	return var_03;
}

//Function Number: 36
use_fireball(param_00)
{
	scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(100);
}

//Function Number: 37
func_2B53(param_00)
{
}

//Function Number: 38
setup_kung_fu_mode_upgrades()
{
	level.kung_fu_upgrades = [];
	register_kung_fu_upgrade("tiger","iw7_fists_zm_tiger","power_shuriken_tiger","power_headPinch","power_black_hole_tiger","power_repulsor");
	register_kung_fu_upgrade("monkey","iw7_fists_zm_monkey","power_fireball","power_fingerGun","power_fingerGun","power_repulsor");
	register_kung_fu_upgrade("snake","iw7_fists_zm_snake","power_shuriken_snake","power_fingerGun","power_summon_pet_snake","power_repulsor");
	register_kung_fu_upgrade("crane","iw7_fists_zm_crane","power_shuriken_crane","power_wipeAway","power_holdHere","power_repulsor");
	register_kung_fu_upgrade("dragon","iw7_fists_zm_dragon","power_shuriken_dragon","power_wipeAway","power_neckSlice","power_repulsor");
}

//Function Number: 39
register_kung_fu_upgrade(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.melee_weapon = param_01;
	var_06.rb = param_02;
	var_06.lb = param_04;
	var_06.var_11234 = param_05;
	level.kung_fu_upgrades[param_00] = var_06;
}

//Function Number: 40
setup_player_kung_fu_progression(param_00)
{
	var_01 = spawnstruct();
	var_01.disciplines_xp = [];
	var_01.disciplines_xp["tiger"] = 0;
	var_01.disciplines_xp["monkey"] = 0;
	var_01.disciplines_xp["snake"] = 0;
	var_01.disciplines_xp["crane"] = 0;
	var_01.disciplines_xp["dragon"] = 0;
	var_01.disciplines_levels = [];
	var_01.disciplines_levels["tiger"] = 0;
	var_01.disciplines_levels["monkey"] = 0;
	var_01.disciplines_levels["snake"] = 0;
	var_01.disciplines_levels["crane"] = 0;
	var_01.disciplines_levels["dragon"] = 0;
	var_01.challenge_progress = [];
	var_01.challenge_progress["tiger"] = 0;
	var_01.challenge_progress["monkey"] = 0;
	var_01.challenge_progress["snake"] = 0;
	var_01.challenge_progress["crane"] = 0;
	var_01.challenge_progress["dragon"] = 0;
	var_01.has_used = [];
	var_01.has_used["tiger"] = 0;
	var_01.has_used["monkey"] = 0;
	var_01.has_used["snake"] = 0;
	var_01.has_used["crane"] = 0;
	var_01.has_used["dragon"] = 0;
	var_01.disciplines_levels["active"] = "none";
	param_00.kung_fu_progression = var_01;
}

//Function Number: 41
ma_style_init()
{
	var_00 = scripts\common\utility::getstructarray("martial_arts_animals","script_noteworthy");
	level.all_animal_structs = [];
	level.special_mode_activation_funcs["martial_arts_animals"] = ::setstylescriptables;
	level.normal_mode_activation_funcs["martial_arts_animals"] = ::setstylescriptables;
	foreach(var_02 in var_00)
	{
		switch(var_02.name)
		{
			case "tiger":
				var_02.gourd_model = "tag_origin_ma_selection";
				break;

			case "snake":
				var_02.gourd_model = "tag_origin_ma_selection";
				break;

			case "crane":
				var_02.gourd_model = "tag_origin_ma_selection";
				break;

			case "dragon":
				var_02.gourd_model = "tag_origin_ma_selection";
				break;
		}

		if(isdefined(var_02.target))
		{
			var_03 = scripts\common\utility::getstruct(var_02.target,"targetname");
			var_03.origin = var_03.origin + (0,0,8);
			var_03.gourd_model = var_02.gourd_model;
			var_03.name = var_02.name;
		}

		scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_02);
		level.all_animal_structs[level.all_animal_structs.size] = var_02;
	}
}

//Function Number: 42
setstylescriptables(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::istrue(param_03.kung_fu_mode);
	var_05 = scripts\common\utility::istrue(param_03.kung_fu_cooldown);
	if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != param_01.gourd_model)
	{
		param_00 setmodel(param_01.gourd_model);
	}

	var_06 = 0;
	if(isdefined(param_03.kung_fu_progression.active_discipline) && getactivekungfustyle(param_03) == param_01.name)
	{
		var_06 = 1;
	}

	if(!scripts\common\utility::flag("skq_phase_1") || var_04 || var_05 || var_06 && isdefined(param_03.has_gourd))
	{
		param_00 setscriptablepartstate("base_model",param_01.name);
		return;
	}

	param_00 setscriptablepartstate("base_model","alt_" + param_01.name);
}

//Function Number: 43
guord_interaction_init()
{
	var_00 = scripts\common\utility::getstructarray("gourd_station","script_noteworthy");
	level.all_gourds = [];
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.target))
		{
			var_03 = scripts\common\utility::getstruct(var_02.target,"targetname");
			var_03.origin = var_03.origin + (0,0,2);
		}
		else
		{
			var_02.origin = var_02.origin + (0,0,2);
			var_02.var_86A2 = "locOverride";
		}

		var_02.var_1D45 = 1;
		var_02.currentlyownedby = [];
		level.all_gourds[level.all_gourds.size] = var_02;
		scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_02);
	}

	level.special_mode_activation_funcs["gourd_station"] = ::setgourdstationscriptables;
	level.normal_mode_activation_funcs["gourd_station"] = ::setgourdstationscriptables;
}

//Function Number: 44
setgourdonplayerconnect()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		foreach(var_03 in level.all_gourds)
		{
			scripts\cp\_interaction::func_E01A(var_03,var_01);
		}
	}

	for(;;)
	{
		level waittill("connected",var_06);
		var_06 thread removegourdswhenable(var_06);
	}
}

//Function Number: 45
removegourdswhenable(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	while(!isdefined(param_00.var_55BB))
	{
		scripts\common\utility::func_136F7();
	}

	foreach(var_02 in level.all_gourds)
	{
		scripts\cp\_interaction::func_E01A(var_02,param_00);
	}
}

//Function Number: 46
setgourdstationscriptables(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::istrue(param_03.kung_fu_mode);
	var_05 = scripts\common\utility::istrue(param_03.kung_fu_cooldown);
	if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != "tag_origin_ma_selection")
	{
		param_00 setmodel("tag_origin_ma_selection");
	}

	var_06 = getactivekungfustyle(param_03);
	var_07 = isdefined(var_06) && isdefined(param_01.var_1D45) && param_03.kung_fu_progression.disciplines_levels[var_06] >= 2;
	var_07 = !var_05 && !var_04 && !isdefined(param_03.has_gourd);
	if(isdefined(var_06))
	{
		if(var_07)
		{
			param_00 setscriptablepartstate("base_model","alt_" + var_06);
			return;
		}

		param_00 setscriptablepartstate("base_model",var_06);
		return;
	}

	param_00 setscriptablepartstate("base_model","dragon");
}

//Function Number: 47
init_martial_arts_trainer()
{
	scripts\common\utility::flag_init("first_kung_fu_mode");
	var_00 = scripts\common\utility::getstructarray("martial_arts_trainer","script_noteworthy");
	level.current_trainer_quest = 0;
	level.current_trainer_quest_backup = 0;
	level.trainer_quests = [];
	level.trainer_quests[level.trainer_quests.size] = ::first_trainer_interaction;
	level.trainer_quests[level.trainer_quests.size] = ::complete_trainer_quest_1;
	level.trainer_quests[level.trainer_quests.size] = ::start_phase_2_task1;
	level.trainer_quests[level.trainer_quests.size] = ::start_phase_2_task2;
	level.trainer_quests[level.trainer_quests.size] = ::start_phase_2_task3;
	level.trainer_quests[level.trainer_quests.size] = ::completephase3;
	level.trainer = getent("ma_trainer","targetname");
	level.trainer.origin = level.trainer.origin + (25,0,-25);
	if(isdefined(level.trainer))
	{
		level.trainer thread handle_trainer_anims();
	}
}

//Function Number: 48
first_trainer_interaction()
{
	scripts\common\utility::flag_set("skq_phase_1");
}

//Function Number: 49
complete_trainer_quest_1()
{
	if(scripts\common\utility::flag("skq_phase_1"))
	{
		increase_trainer_interaction_progression();
		[[ level.trainer_quests[level.current_trainer_quest] ]]();
		return;
	}

	foreach(var_01 in level.players)
	{
		var_02 = ["pam_generic_response","pam_return_nothing"];
		if(isdefined(var_01))
		{
			var_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_02),"pam_dialogue_vo","highest",100,1);
		}
	}

	disable_trainer_interactions();
	level thread wait_for_trainer_challenge();
}

//Function Number: 50
wait_for_trainer_challenge()
{
	level endon("game_ended");
	var_00 = ["snake","tiger","crane","dragon","monkey"];
	var_01 = 0;
	while(!var_01)
	{
		foreach(var_03 in var_00)
		{
			foreach(var_05 in level.players)
			{
				if(var_05.kung_fu_progression.disciplines_levels[var_03] >= 1)
				{
					var_01 = 1;
					break;
				}
			}

			if(var_01)
			{
				break;
			}
		}

		if(var_01)
		{
			break;
		}

		wait(1);
	}

	wait(0.5);
	enable_trainer_interactions();
	increase_trainer_interaction_progression();
}

//Function Number: 51
disable_trainer_interactions()
{
	level.current_trainer_quest = -1;
}

//Function Number: 52
enable_trainer_interactions()
{
	level.current_trainer_quest = level.current_trainer_quest_backup;
}

//Function Number: 53
increase_trainer_interaction_progression()
{
	enable_trainer_interactions();
	level.current_trainer_quest++;
	level.current_trainer_quest_backup = level.current_trainer_quest;
}

//Function Number: 54
talk_to_trainer(param_00,param_01)
{
	if(level.wave_num < 5)
	{
		if(isdefined(level.spoke_to_pam_first) && level.spoke_to_pam_first == param_01)
		{
			var_02 = ["pam_generic_response","pam_return_nothing"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_02),"pam_dialogue_vo","highest",100,1);
			return;
		}
		else if(!isdefined(level.spoke_to_pam_first))
		{
			level.spoke_to_pam_first = var_02;
			switch(var_02.var_134FD)
			{
				case "p1_":
					var_02 thread scripts\cp\_vo::try_to_play_vo("sally_pam_first_1","pam_dialogue_vo","highest",20,1);
					break;

				case "p2_":
					var_02 thread scripts\cp\_vo::try_to_play_vo("pdex_pam_first_1","pam_dialogue_vo","highest",20,1);
					break;

				case "p3_":
					var_02 thread scripts\cp\_vo::try_to_play_vo("andre_pam_first_1","pam_dialogue_vo","highest",20,1);
					break;

				case "p4_":
					var_02 thread scripts\cp\_vo::try_to_play_vo("aj_pam_first_1","pam_dialogue_vo","highest",20,1);
					break;

				case "p5_":
					var_02 thread scripts\cp\_vo::try_to_play_vo("pam_generic_response","pam_dialogue_vo","highest",20,1);
					break;

				default:
					break;
			}
		}

		return;
	}

	level.spoke_to_pam_first_after_wave_five = var_02;
	foreach(var_04 in level.players)
	{
		var_04 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_04);
	}

	if(scripts\common\utility::func_6E34("heart_picked") && scripts\common\utility::flag("heart_picked") && !scripts\common\utility::istrue(var_02.played_heart_vo))
	{
		if(var_02.var_134FD == "p5_")
		{
			var_02 thread scripts\cp\_vo::try_to_play_vo("pam_return_rat_heart","disco_comment_vo");
			var_02.played_heart_vo = 1;
		}
	}
	else if(scripts\common\utility::func_6E34("brain_picked") && scripts\common\utility::flag("brain_picked") && !scripts\common\utility::istrue(var_02.played_brain_vo))
	{
		if(var_02.var_134FD == "p5_")
		{
			var_02 thread scripts\cp\_vo::try_to_play_vo("pam_return_rat_brain","disco_comment_vo");
			var_02.played_brain_vo = 1;
		}
	}

	if(isdefined(level.trainer_quests[level.current_trainer_quest]))
	{
		[[ level.trainer_quests[level.current_trainer_quest] ]]();
	}
	else if(isdefined(level.current_trainer_quest) && level.current_trainer_quest == -1)
	{
		var_02 thread scripts\cp\_vo::try_to_play_vo("pam_quest_return_none","pam_dialogue_vo","highest",100,1);
	}
	else
	{
		var_02 = ["pam_generic_response","pam_return_nothing"];
		param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"pam_dialogue_vo","highest",100,1);
	}

	scripts\cp\_vo::func_E01F("pam_quest_return");
}

//Function Number: 55
blackcathintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 56
blackcatusefunc(param_00,param_01)
{
	if(isdefined(param_01.kung_fu_progression.active_discipline))
	{
		var_02 = param_01.kung_fu_progression.active_discipline;
	}
	else
	{
		return;
	}

	param_01 playlocalsound("part_pickup");
	var_03 = scripts\common\utility::random(["power_fingerGun","power_wipeAway","power_headPinch"]);
	param_01 thread scripts\cp\powers\coop_powers::func_8397(var_03,"secondary",undefined,undefined,undefined,1,1);
	param_01.chi_meter_adustment = 1000;
	deactivateblackcats(param_01);
}

//Function Number: 57
blackcatinitfunc()
{
	level.special_mode_activation_funcs["black_cat"] = ::blackcatinteractions;
	level.normal_mode_activation_funcs["black_cat"] = ::blackcatblank;
	var_00 = scripts\common\utility::getstructarray("black_cat","script_noteworthy");
	level.allcatstructs = var_00;
	level thread watchforplayerconnect(var_00);
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02 scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_02);
		foreach(var_04 in level.players)
		{
			var_04 scripts\cp\_interaction::func_E01A(var_02,var_04);
		}
	}
}

//Function Number: 58
watchforplayerconnect(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread removeblackcatsfrompents(var_01,param_00);
	}
}

//Function Number: 59
removeblackcatsfrompents(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	while(!isdefined(param_00.var_55BB))
	{
		scripts\common\utility::func_136F7();
	}

	foreach(var_03 in param_01)
	{
		param_00 scripts\cp\_interaction::func_E01A(var_03,param_00);
	}
}

//Function Number: 60
blackcatblank(param_00,param_01,param_02,param_03)
{
	param_00 setmodel("tag_origin");
}

//Function Number: 61
blackcatinteractions(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::istrue(param_03.kung_fu_mode);
	if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != "tag_origin_black_cat")
	{
		param_00 setmodel("tag_origin_black_cat");
	}

	if(var_04)
	{
		param_00 setscriptablepartstate("effects","active");
	}
}

//Function Number: 62
trainer_hint_func(param_00,param_01)
{
	return &"CP_DISCO_CHALLENGES_TALK_TO_TRAINER";
}

//Function Number: 63
start_phase_2_task1()
{
	scripts\common\utility::flag_set("skq_p2t1_0");
}

//Function Number: 64
start_phase_2_task2()
{
	scripts\common\utility::flag_set("skq_p2t1_5");
}

//Function Number: 65
start_phase_2_task3()
{
	scripts\common\utility::flag_set("skq_p2t2_7");
}

//Function Number: 66
completephase3()
{
	scripts\common\utility::flag_set("skq_p2t3_6");
	if(level.players.size == 4)
	{
		level thread scripts\cp\_vo::try_to_play_vo("final_rat_king_1","rave_dialogue_vo");
		return;
	}

	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("pg_final_rat_king_1");
	}
}

//Function Number: 67
style_hint_func(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_cooldown))
	{
		return "";
	}

	if(!scripts\common\utility::flag("skq_phase_1"))
	{
		return "";
	}

	var_02 = param_01.kung_fu_progression.disciplines_levels[param_00.name];
	var_03 = undefined;
	if(isdefined(param_01.kung_fu_progression.active_discipline))
	{
		var_03 = param_01.kung_fu_progression.active_discipline;
	}

	if(isdefined(var_03) && getactivekungfustyle(param_01) == param_00.name && isdefined(param_01.has_gourd))
	{
		return "";
	}

	switch(param_00.name)
	{
		case "snake":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_SNAKE");
			break;

		case "tiger":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_TIGER");
			break;

		case "crane":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_CRANE");
			break;

		case "dragon":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_DRAGON");
			break;
	}

	if(var_02 < 1 && !isdefined(var_03) || var_03 != param_00.name)
	{
		return &"CP_DISCO_CHALLENGES_TRAINING_BEGIN";
	}

	if(var_02 < 3)
	{
		return &"CP_DISCO_CHALLENGES_CONTINUE";
	}

	return &"CP_DISCO_CHALLENGES_DRINK_GOURD";
}

//Function Number: 68
usegourd_hint_func(param_00,param_01)
{
	if(!isdefined(param_01.kung_fu_progression.active_discipline))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_01.has_gourd))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_cooldown))
	{
		return "";
	}

	var_02 = param_01.kung_fu_progression.active_discipline;
	switch(var_02)
	{
		case "snake":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_SNAKE");
			break;

		case "tiger":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_TIGER");
			break;

		case "crane":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_CRANE");
			break;

		case "dragon":
			param_01.var_9A3F method_852E(&"CP_DISCO_CHALLENGES_DRAGON");
			break;
	}

	if(!scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return &"CP_DISCO_CHALLENGES_DRINK_GOURD";
	}
}

//Function Number: 69
direct_boss_give_kung_fu(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	param_01.kung_fu_progression.active_discipline = param_00;
	if(isdefined(param_01.last_animal_interaction))
	{
		param_01 setclientomnvar("zm_ui_show_general",0);
	}

	param_01.kung_fu_progression.disciplines_levels["snake"] = 3;
	param_01.kung_fu_progression.disciplines_levels["tiger"] = 3;
	param_01.kung_fu_progression.disciplines_levels["crane"] = 3;
	param_01.kung_fu_progression.disciplines_levels["dragon"] = 3;
	var_02 = spawnstruct();
	param_01.last_animal_interaction = var_02;
	param_01 unset_gourd(param_01);
	checkgourdstates(var_02,param_01);
	var_03 = param_01.kung_fu_progression.active_discipline;
	var_04 = param_01.kung_fu_progression.disciplines_levels[param_01.kung_fu_progression.active_discipline];
	var_05 = 1;
	switch(param_00)
	{
		case "tiger":
			var_05 = 3;
			break;

		case "snake":
			var_05 = 6;
			break;

		case "crane":
			var_05 = 4;
			break;

		case "dragon":
			var_05 = 5;
			break;
	}

	var_06 = var_05 + var_04 * 4;
	if(var_04 == 3)
	{
		var_06 = var_05;
	}

	param_01 setclientomnvar("ui_intel_active_index",var_06);
	param_01 thread set_gourd(param_01);
	param_01 scripts\cp\_interaction::func_DE6E();
	param_01 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_01);
}

//Function Number: 70
choose_martial_arts_style(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_cooldown))
	{
		return;
	}

	if(!scripts\common\utility::flag("skq_phase_1"))
	{
		return;
	}

	param_01.kung_fu_progression.active_discipline = param_00.name;
	if(isdefined(param_01.last_animal_interaction))
	{
		param_01 setclientomnvar("zm_ui_show_general",0);
	}

	param_01.last_animal_interaction = param_00;
	param_01 unset_gourd(param_01);
	checkgourdstates(param_00,param_01);
	var_02 = param_01.kung_fu_progression.active_discipline;
	var_03 = param_01.kung_fu_progression.disciplines_levels[param_01.kung_fu_progression.active_discipline];
	var_04 = 1;
	switch(param_00.name)
	{
		case "tiger":
			var_04 = 3;
			var_05 = ["gourd_misc","gourd_tiger"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo");
			break;

		case "snake":
			var_04 = 6;
			var_05 = ["gourd_misc","gourd_snake"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo");
			break;

		case "crane":
			var_04 = 4;
			var_05 = ["gourd_misc","gourd_crane"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo");
			break;

		case "dragon":
			var_04 = 5;
			var_05 = ["gourd_misc","gourd_dragon"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo");
			break;
	}

	var_06 = var_04 + var_03 * 4;
	if(var_03 == 3)
	{
		var_06 = var_04;
	}

	param_01 setclientomnvar("ui_intel_active_index",var_06);
	param_01 thread set_gourd(param_01);
	level thread scripts\cp\maps\cp_disco\cp_disco_challenges::chi_challenge_activate(param_01);
	param_01 scripts\cp\_interaction::func_DE6E();
	param_01 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_01);
	param_01 thread updategourdinteractions(param_00,param_01);
}

//Function Number: 71
checkgourdstates(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_cooldown))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.has_gourd))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	foreach(var_03 in level.all_gourds)
	{
		scripts\cp\_interaction::func_175D(var_03,param_01);
	}
}

//Function Number: 72
usegourdstation(param_00,param_01)
{
	if(!isdefined(param_01.kung_fu_progression.active_discipline))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_cooldown))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.has_gourd))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight() && !scripts\common\utility::flag("skq_phase_1"))
	{
		return;
	}

	var_02 = param_01.kung_fu_progression.active_discipline;
	param_01 thread set_gourd(param_01);
	param_00 thread cooldown_struct(param_00,param_01);
}

//Function Number: 73
cooldown_struct(param_00,param_01)
{
	param_01 scripts\cp\_interaction::func_DE6E();
	param_01 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_01);
	param_01 thread updategourdinteractions(param_00,param_01);
}

//Function Number: 74
updategourdinteractions(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	param_01 waittill("spawn_gourds");
	foreach(var_03 in level.all_gourds)
	{
		scripts\cp\_interaction::func_175D(var_03,param_01);
	}

	foreach(var_03 in level.all_animal_structs)
	{
		scripts\cp\_interaction::func_175D(var_03,param_01);
	}

	param_01 scripts\cp\_interaction::func_DE6E();
	param_01 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_01);
}

//Function Number: 75
start_tracking_kung_fu_discipline(param_00)
{
	param_00 thread enter_kung_fu(param_00,getactivekungfustyle(param_00));
}

//Function Number: 76
update_player_abilities(param_00,param_01)
{
	if(param_00.kung_fu_progression.disciplines_levels[param_01] < 3)
	{
		param_00.kung_fu_progression.disciplines_levels[param_01]++;
	}

	var_02 = param_00.kung_fu_progression.disciplines_levels[param_01];
	wait(1);
	switch(var_02)
	{
		case 1:
			if(!scripts\common\utility::flag("skq_phase_1"))
			{
				scripts\common\utility::flag_set("skq_phase_1");
			}
	
			var_03 = level.kung_fu_upgrades[param_01].rb;
			if(!scripts\common\utility::istrue(param_00.kung_fu_exit_delay) && scripts\common\utility::istrue(param_00.kung_fu_mode))
			{
				param_00 thread scripts\cp\powers\coop_powers::func_8397(var_03,"primary",undefined,undefined,undefined,1,1);
			}
			break;

		case 2:
			var_03 = level.kung_fu_upgrades[param_01].lb;
			if(!scripts\common\utility::istrue(param_00.kung_fu_exit_delay) && scripts\common\utility::istrue(param_00.kung_fu_mode))
			{
				param_00 thread scripts\cp\powers\coop_powers::func_8397(var_03,"secondary",undefined,undefined,undefined,1,1);
			}
			break;

		case 3:
			if(!scripts\common\utility::istrue(param_00.kung_fu_exit_delay) && scripts\common\utility::istrue(param_00.kung_fu_mode))
			{
				if(param_01 == "snake")
				{
					param_00 setclientomnvar("zm_hud_inventory_1",1);
				}
				else if(param_01 == "tiger")
				{
					param_00 setclientomnvar("zm_hud_inventory_1",2);
				}
				else if(param_01 == "crane")
				{
					param_00 setclientomnvar("zm_hud_inventory_1",3);
				}
				else if(param_01 == "dragon")
				{
					param_00 setclientomnvar("zm_hud_inventory_1",4);
				}
	
				param_00 thread activate_level_3_power(param_00,param_01);
				level thread activateblackcats(param_00);
			}
			break;

		default:
			break;
	}
}

//Function Number: 77
activateblackcats(param_00)
{
	foreach(var_02 in level.allcatstructs)
	{
		scripts\cp\_interaction::func_175D(var_02,param_00);
	}

	param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
}

//Function Number: 78
deactivateblackcats(param_00)
{
	if(scripts\common\utility::flag("rk_fight_started"))
	{
		return;
	}

	foreach(var_02 in level.allcatstructs)
	{
		scripts\cp\_interaction::func_E01A(var_02,param_00);
	}

	param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
}

//Function Number: 79
activate_level_3_power(param_00,param_01)
{
	wait(0.1);
	if(scripts\common\utility::istrue(param_00.kung_fu_exit_delay))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_00.kung_fu_mode))
	{
		return;
	}

	param_00 thread watch_for_kung_fu_super_button(param_00,param_01);
}

//Function Number: 80
watch_for_kung_fu_super_button(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 notify("end_super_watcher");
	param_00 endon("end_super_watcher");
	if(param_00 hasweapon("super_default_zm"))
	{
		param_00 takeweapon("super_default_zm");
	}

	var_02 = "kung_fu_super_zm";
	param_00 giveweapon(var_02);
	param_00 method_84C2(var_02);
	for(;;)
	{
		param_00 setweaponammoclip(var_02,1);
		param_00 waittill("offhand_fired",var_03);
		if(var_03 == var_02)
		{
			param_00 notify("super_fired");
		}

		if(scripts\common\utility::istrue(self.tiger_super_use) || scripts\common\utility::istrue(self.crane_super_use) || scripts\common\utility::istrue(self.snake_super_use) || scripts\common\utility::istrue(self.dragon_super_use))
		{
			wait(0.1);
			continue;
		}

		if(!param_00 isonground())
		{
			wait(0.1);
			continue;
		}

		if(var_03 == var_02)
		{
			scripts\cp\powers\coop_powers::func_D728();
			param_00 notify("put_shuriken_away");
			switch(param_01)
			{
				case "tiger":
					param_00 notify("super_used");
					param_00 playanimscriptevent("power_active_cp","gesture021");
					param_00 scripts\cp\maps\cp_disco\kung_fu_mode_tiger::tiger_ground_pound_use(param_01);
					break;
	
				case "snake":
					param_00 notify("super_used");
					param_00 playanimscriptevent("power_active_cp","gesture022");
					param_00 scripts\cp\maps\cp_disco\kung_fu_mode_snake::snake_super_use(param_01);
					break;
	
				case "dragon":
					param_00 notify("super_used");
					param_00 playanimscriptevent("power_active_cp","gesture020");
					param_00 scripts\cp\maps\cp_disco\kung_fu_mode_dragon::dragon_super_use(param_01);
					break;
	
				case "crane":
					param_00 notify("super_used");
					param_00 scripts\cp\maps\cp_disco\kung_fu_mode_crane::crane_super_use(param_01);
					break;
	
				default:
					break;
			}

			param_00 scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(500);
			wait(1);
		}

		wait(0.1);
	}
}

//Function Number: 81
play_kung_fu_enter_vo(param_00)
{
	param_00 thread scripts\cp\_vo::try_to_play_vo("enter_kungfu","zmb_comment_vo","medium",10,0,0,1,50);
	wait(7);
	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_kungfu_mode","rave_announcer_vo","highest",70,0,0,1,100,1);
}

//Function Number: 82
enter_kung_fu(param_00,param_01)
{
	param_00 endon("disconnect");
	if(scripts\common\utility::istrue(param_00.inlaststand))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.var_9FCB))
	{
		return;
	}

	param_00.pre_kung_fu_powers = param_00 scripts\cp\powers\coop_powers::func_7A3C(param_00);
	foreach(var_03 in getarraykeys(param_00.var_D782))
	{
		param_00 scripts\cp\powers\coop_powers::func_E15E(var_03);
	}

	level thread play_kung_fu_enter_vo(param_00);
	level.var_C9C1 = 1;
	param_00.disable_consumables = 1;
	param_00.kung_fu_mode = 1;
	param_00.allow_carry = 0;
	[[ level.kung_fu_interaction_func ]](param_00);
	param_00.kungfu_style = param_01;
	param_00.no_deadeye = 1;
	param_01 = param_00.kung_fu_progression.active_discipline;
	param_00 method_80AB();
	param_00 allowprone(0);
	var_05 = 0;
	if(playerhasusedstyle(param_00))
	{
		var_05 = 1;
	}
	else
	{
		param_00.kung_fu_progression.has_used[param_01]++;
	}

	var_06 = level.kung_fu_upgrades[param_01].melee_weapon;
	param_00 scripts\cp\_utility::func_12C6(var_06,undefined,undefined,var_05);
	param_00 method_83B6(var_06);
	param_00 thread scripts\cp\zombies\zombies_chi_meter::chi_meter_on(param_00,param_01);
	if(param_00.kung_fu_progression.disciplines_levels[param_01] >= 1)
	{
		var_07 = level.kung_fu_upgrades[param_01].rb;
		param_00 thread scripts\cp\powers\coop_powers::func_8397(var_07,"primary",undefined,undefined,undefined,1,1);
	}

	if(param_00.kung_fu_progression.disciplines_levels[param_01] >= 2)
	{
		var_07 = level.kung_fu_upgrades[param_01].lb;
		param_00 thread scripts\cp\powers\coop_powers::func_8397(var_07,"secondary",undefined,undefined,undefined,1,1);
	}

	if(param_00.kung_fu_progression.disciplines_levels[param_01] >= 3)
	{
		thread activateblackcats(param_00);
		param_00 thread watch_for_kung_fu_super_button(param_00,param_01);
		if(param_01 == "snake")
		{
			param_00 setclientomnvar("zm_hud_inventory_1",1);
		}
		else if(param_01 == "tiger")
		{
			param_00 setclientomnvar("zm_hud_inventory_1",2);
		}
		else if(param_01 == "crane")
		{
			param_00 setclientomnvar("zm_hud_inventory_1",3);
		}
		else if(param_01 == "dragon")
		{
			param_00 setclientomnvar("zm_hud_inventory_1",4);
		}
	}
	else
	{
		param_00 setclientomnvar("zm_hud_inventory_1",0);
	}

	param_00 thread sfx_kungfu_enter(param_01);
	param_00 thread turn_off_wall_buys(param_00);
	param_00 thread kung_fu_symbol_on(param_01);
	param_00 thread watchforforcedexit(param_00);
	param_00 thread handle_kung_fu_on_revive(param_00);
	thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
}

//Function Number: 83
turn_off_wall_buys(param_00)
{
	param_00 endon("disconnect");
	foreach(var_02 in level.wall_buy_interactions)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "iw7_katana_zm")
		{
			continue;
		}

		if(isdefined(var_02.trigger))
		{
			var_02.trigger method_8429(param_00);
		}

		scripts\cp\_interaction::func_E01A(var_02,param_00);
	}
}

//Function Number: 84
turn_on_wall_buys(param_00)
{
	param_00 endon("disconnect");
	foreach(var_02 in level.wall_buy_interactions)
	{
		if(isdefined(var_02.trigger))
		{
			var_02.trigger showtoplayer(param_00);
		}

		scripts\cp\_interaction::func_175D(var_02,param_00);
	}
}

//Function Number: 85
sfx_kungfu_enter(param_00)
{
	switch(param_00)
	{
		case "snake":
			self playlocalsound("zmb_kung_fu_style_snake");
			break;

		case "tiger":
			self playlocalsound("zmb_kung_fu_style_tiger");
			break;

		case "crane":
			self playlocalsound("zmb_kung_fu_style_crane");
			break;

		case "dragon":
			self playlocalsound("zmb_kung_fu_style_dragon");
			break;
	}
}

//Function Number: 86
unset_kung_fu_mode(param_00,param_01)
{
	var_02 = param_00.kung_fu_progression.active_discipline;
	var_03 = level.kung_fu_upgrades[var_02].melee_weapon;
	param_00 notify("put_shuriken_away");
	param_00 takeweapon(var_03);
	param_00 thread scripts\cp\_vo::try_to_play_vo("exit_kungfu","zmb_comment_vo","medium",10,0,0,1,50);
	param_00 thread delayed_remove_kung_fu_powers(5,param_00,param_00.pre_kung_fu_powers);
	param_00 restore_pre_kung_fu_powers(param_00,param_00.pre_kung_fu_powers);
	param_00.pre_kung_fu_powers = undefined;
	level.var_C9C1 = 0;
	param_00.pre_kung_fu_rb_powers = undefined;
	param_00.pre_kung_fu_lb_powers = undefined;
	param_00.kung_fu_mode = undefined;
	param_00.kung_fu_shield = undefined;
	if(scripts\common\utility::istrue(param_00.refill_powers_after_kungfu))
	{
		level scripts\cp\gametypes\zombie::func_E197(param_00);
		param_00.refill_powers_after_kungfu = undefined;
	}

	param_00.allow_carry = undefined;
	[[ level.kung_fu_interaction_func ]](param_00);
	if(!param_00 hasweapon(param_01))
	{
		param_01 = param_00 scripts\cp\_utility::getvalidtakeweapon();
	}

	param_00.disable_consumables = undefined;
	param_00.pre_kung_fu_weapon = undefined;
	param_00.no_deadeye = undefined;
	param_00 thread disable_grenades_for_time(1.5);
	param_00 enableweaponswitch();
	param_00 switchtoweapon(param_01);
	if(param_00 hasweapon("kung_fu_super_zm"))
	{
		param_00 takeweapon("kung_fu_super_zm");
	}

	param_00 scripts\cp\_utility::func_E2D4();
	param_00 kungfu_buff_cleanup();
	param_00 thread applykungfucooldown(param_00);
	thread deactivateblackcats(param_00);
	param_00 thread turn_on_wall_buys(param_00);
	param_00 allowprone(1);
	param_00 notify("kung_fu_style_timeout");
	param_00 thread scripts\cp\zombies\zombies_chi_meter::chi_meter_off(param_00);
	param_00.shuriken_charged = undefined;
	param_00 setscriptablepartstate("shuriken","inactive");
}

//Function Number: 87
delayed_remove_kung_fu_powers(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("last_stand");
	param_01 notify("end_delaye_remove_func");
	param_01 endon("end_delaye_remove_func");
	wait(param_00);
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	var_03 = 0;
	foreach(var_05 in level.kung_fu_upgrades)
	{
		if(isdefined(var_05.rb))
		{
			var_06 = var_05.rb;
			if(param_01 scripts\cp\powers\coop_powers::func_8C17(var_06))
			{
				var_03 = 1;
			}
		}

		if(isdefined(var_05.lb))
		{
			var_06 = var_05.lb;
			if(param_01 scripts\cp\powers\coop_powers::func_8C17(var_06))
			{
				var_03 = 1;
			}
		}

		if(param_01 hasweapon("kung_fu_super_zm"))
		{
			var_03 = 1;
		}
	}

	if(!var_03)
	{
		return;
	}

	param_01 restore_pre_kung_fu_powers(param_01,param_02);
	param_01.pre_kung_fu_powers = undefined;
	param_01.pre_kung_fu_rb_powers = undefined;
	param_01.pre_kung_fu_lb_powers = undefined;
	if(scripts\common\utility::istrue(param_01.refill_powers_after_kungfu))
	{
		level scripts\cp\gametypes\zombie::func_E197(param_01);
		param_01.refill_powers_after_kungfu = undefined;
	}

	param_01 thread disable_grenades_for_time(1.5);
	if(param_01 hasweapon("kung_fu_super_zm"))
	{
		param_01 takeweapon("kung_fu_super_zm");
	}

	param_01 scripts\cp\_utility::func_E2D4();
	param_01 kungfu_buff_cleanup();
	param_01 notify("kung_fu_style_timeout");
}

//Function Number: 88
restoreknifeweapon(param_00)
{
	var_01 = param_00.melee_weapon;
	if(!param_00 hasweapon(var_01))
	{
		param_00 giveweapon(var_01);
	}
}

//Function Number: 89
disable_grenades_for_time(param_00)
{
	scripts\cp\powers\coop_powers::func_D728();
	wait(param_00);
	scripts\cp\powers\coop_powers::func_D72E();
}

//Function Number: 90
applykungfucooldown(param_00)
{
	param_00 endon("disconnect");
	param_00.kung_fu_cooldown = 1;
	if(scripts\common\utility::flag("rk_fight_started"))
	{
		return;
	}

	level scripts\common\utility::waittill_any_timeout_1(300,"wave_starting");
	param_00.kung_fu_cooldown = undefined;
	param_00 notify("spawn_gourds");
}

//Function Number: 91
restore_pre_kung_fu_powers(param_00,param_01)
{
	foreach(var_03 in getarraykeys(param_00.var_D782))
	{
		scripts\cp\powers\coop_powers::func_E15E(var_03);
	}

	foreach(var_03, var_06 in param_01)
	{
		var_07 = undefined;
		var_08 = 0;
		if(scripts\common\utility::istrue(var_06.var_4613))
		{
			var_07 = 1;
		}

		if(scripts\common\utility::istrue(var_06.permanent))
		{
			var_08 = 1;
		}

		if(var_06.var_10307 == "secondary")
		{
			param_00 scripts\cp\powers\coop_powers::func_8397(var_03,var_06.var_10307,undefined,undefined,undefined,var_07,var_08);
			param_00 scripts\cp\powers\coop_powers::func_D71A(var_06.var_3D23,var_06.var_10307,1);
			continue;
		}

		param_00 scripts\cp\powers\coop_powers::func_8397(var_03,var_06.var_10307,undefined,undefined,undefined,var_07,var_08);
		param_00 scripts\cp\powers\coop_powers::func_D71A(var_06.var_3D23,var_06.var_10307,1);
	}
}

//Function Number: 92
clean_up_kung_fu_mode_on_last_stand(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("kung_fu_style_timeout");
	param_00 scripts\common\utility::waittill_either("last_stand","death");
	unset_kung_fu_mode(param_00,param_01);
}

//Function Number: 93
handle_kung_fu_on_revive(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("kung_fu_style_timeout");
	for(;;)
	{
		param_00 waittill("stop_revive");
		var_01 = param_00.kung_fu_progression.active_discipline;
		param_00 method_80AB();
		var_02 = level.kung_fu_upgrades[var_01].melee_weapon;
		param_00 switchtoweapon(var_02);
		wait(0.1);
	}
}

//Function Number: 94
cp_punch_fx(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("stop_kung_fu");
	param_00 endon("kung_fu_style_timeout");
	var_01 = 2000;
	for(;;)
	{
		param_00 waittill("melee_fired");
		wait(0.1);
	}
}

//Function Number: 95
handle_trainer_anims()
{
	level endon("game_ended");
	level endon("stop_trainer_idles");
	self.desired_loop = "idle";
	var_00 = undefined;
	for(;;)
	{
		var_01 = [%iw7_cp_pam_lotus_idle_01,%iw7_cp_pam_lotus_idle_02,%iw7_cp_pam_lotus_idle_03];
		var_02 = ["IW7_cp_pam_lotus_idle_01","IW7_cp_pam_lotus_idle_02","IW7_cp_pam_lotus_idle_03"];
		var_03 = [%iw7_cp_pam_lotus_idle_04,%iw7_cp_pam_lotus_idle_05];
		var_04 = ["IW7_cp_pam_lotus_idle_04","IW7_cp_pam_lotus_idle_05"];
		var_05 = scripts\common\utility::random(var_02);
		var_06 = scripts\common\utility::random(var_04);
		switch(self.desired_loop)
		{
			case "idle":
				switch(var_05)
				{
					case "IW7_cp_pam_lotus_idle_01":
						var_00 = %iw7_cp_pam_lotus_idle_01;
						break;
		
					case "IW7_cp_pam_lotus_idle_02":
						var_00 = %iw7_cp_pam_lotus_idle_02;
						break;
		
					case "IW7_cp_pam_lotus_idle_03":
						var_00 = %iw7_cp_pam_lotus_idle_03;
						break;
				}
				break;
	
			case "talk":
				switch(var_06)
				{
					case "IW7_cp_pam_lotus_idle_04":
						var_00 = %iw7_cp_pam_lotus_idle_04;
						break;
		
					case "IW7_cp_pam_lotus_idle_05":
						var_00 = %iw7_cp_pam_lotus_idle_05;
						break;
				}
				break;
		}

		var_07 = getanimlength(var_00);
		self scriptmodelplayanimdeltamotionfrompos(var_00,self.origin,self.angles);
		wait(var_07);
		self.desired_loop = scripts\common\utility::random(["idle","talk"]);
	}
}

//Function Number: 96
kungfuexithint(param_00)
{
	if(isdefined(level.wave_num) && level.wave_num >= 15)
	{
		return;
	}

	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	param_00 endon("stop_kung_fu");
	param_00 endon("kung_fu_style_timeout");
	param_00.kung_fu_hint_display = 0;
	while(param_00.kung_fu_hint_display < 5)
	{
		param_00 scripts\cp\_utility::setlowermessage("msg_kung_fu_exit_hint",&"CP_DISCO_EXIT_KUNG_FU",4);
		param_00.kung_fu_hint_display = param_00.kung_fu_hint_display + 1;
		wait(randomfloatrange(5,10));
	}
}

//Function Number: 97
kungfu_buff_watcher(param_00)
{
	self endon("disconnect");
	self endon("stop_kung_fu");
	self endon("kung_fu_style_timeout");
	kungfu_buff_cleanup();
	self.kungfu_style = param_00;
	var_01 = ["crane","dragon","snake","tiger"];
	setkungfubuffstate(param_00,"on");
	for(;;)
	{
		var_02 = [];
		var_02[self.kungfu_style] = 1;
		var_03 = scripts\common\utility::func_782F(self.origin,level.players,undefined,undefined,1024,0);
		foreach(var_05 in var_03)
		{
			if(var_05 == self)
			{
				continue;
			}

			if(!isdefined(self.kungfu_style))
			{
				break;
			}

			var_02[self.kungfu_style] = 1;
		}

		foreach(param_00 in var_01)
		{
			if(isdefined(var_02[param_00]))
			{
				setkungfubuffstate(param_00,"on");
				continue;
			}

			setkungfubuffstate(param_00,"off");
		}

		wait(1);
	}
}

//Function Number: 98
kung_fu_symbol_on(param_00)
{
	setkungfubuffstate(param_00,"on");
}

//Function Number: 99
kungfu_buff_cleanup()
{
	self setscriptablepartstate("kungfu_seal_crane","off");
	self setscriptablepartstate("kungfu_seal_dragon","off");
	self setscriptablepartstate("kungfu_seal_snake","off");
	self setscriptablepartstate("kungfu_seal_tiger","off");
	self setscriptablepartstate("shuriken","inactive");
	self setscriptablepartstate("kung_fu_super_fx","off");
}

//Function Number: 100
setkungfubuffstate(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 == "on")
	{
		self setscriptablepartstate("kungfu_seal_" + param_00,"on");
		return;
	}

	self setscriptablepartstate("kungfu_seal_" + param_00,"off");
}

//Function Number: 101
watchforforcedexit(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("stop_kung_fu");
	param_00 endon("kung_fu_style_timeout");
	param_00 notifyonplayercommand("exit_kung_fu_requested","+actionslot 4");
	wait(1);
	for(;;)
	{
		param_00 waittill("exit_kung_fu_requested");
		if(scripts\common\utility::istrue(param_00.kung_fu_exit_delay))
		{
			wait(0.1);
			continue;
		}

		param_00.pre_kung_fu_weapon = scripts\cp\_utility::getvalidtakeweapon();
		thread unset_kung_fu_mode(param_00,param_00.pre_kung_fu_weapon);
	}
}

//Function Number: 102
getrbabilitycost()
{
	return 100;
}

//Function Number: 103
getlbabilitycost()
{
	return 250;
}

//Function Number: 104
getsuperabilitycost()
{
	return 500;
}

//Function Number: 105
playerhasusedstyle(param_00)
{
	return isdefined(getactivekungfustyle(param_00)) && scripts\common\utility::istrue(param_00.kung_fu_progression.has_used[getactivekungfustyle(param_00)]);
}

//Function Number: 106
getactivekungfustyle(param_00)
{
	if(isdefined(param_00.kung_fu_progression.active_discipline))
	{
		return param_00.kung_fu_progression.active_discipline;
	}

	return undefined;
}