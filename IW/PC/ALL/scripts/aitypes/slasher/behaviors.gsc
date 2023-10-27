/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\slasher\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 2901 ms
 * Timestamp: 10/26/2023 11:58:59 PM
*******************************************************************/

//Function Number: 1
initslasher(param_00)
{
	setupslasherstates();
	self.desiredaction = undefined;
	self.var_A980 = 0;
	self.lastenemyengagetime = 0;
	self.slasherenemy = undefined;
	self.slasherenemystarttime = 0;
	self.last_health = self.health;
	return level.var_111AE;
}

//Function Number: 2
setupslasheraction(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.fnbegin = param_01;
	var_04.fntick = param_02;
	var_04.fnend = param_03;
	if(!isdefined(self.actions))
	{
		self.actions = [];
	}

	self.actions[param_00] = var_04;
}

//Function Number: 3
setupslasherstates()
{
	scripts\aitypes\slasher\bt_state_api::btstate_setupstate("aim",::sawbladeattack_aim_begin,::sawbladeattack_aim_tick,::sawbladeattack_aim_end);
	scripts\aitypes\slasher\bt_state_api::btstate_setupstate("shoot",::sawbladeattack_shoot_begin,::sawbladeattack_shoot_tick,::sawbladeattack_shoot_end);
	setupslasheraction("sawblade_attack",::sawbladeattack_begin,::sawbladeattack_tick,::sawbladeattack_end);
	setupslasheraction("ground_pound",::groundpoundattack_begin,::groundpoundattack_tick,::groundpoundattack_end);
	setupslasheraction("ram_attack",::ramattack_begin,::ramattack_tick,::ramattack_end);
	setupslasheraction("taunt",::taunt_begin,::taunt_tick,::taunt_end);
	setupslasheraction("teleport",::teleport_begin,::teleport_tick,::teleport_end);
	setupslasheraction("summon",::summon_begin,::summon_tick,::summon_end);
	setupslasheraction("block",::block_begin,::block_tick,::block_end);
	setupslasheraction("swipe_attack",::melee_begin,::melee_tick,::melee_end);
	setupslasheraction("melee_spin",::melee_begin,::melee_tick,::melee_end);
	setupslasheraction("grenade_throw",::grenadethrow_begin,::grenadethrow_tick,::grenadethrow_end);
	setupslasheraction("debug_handler",::debughandler_begin,::debughandler_tick,::debughandler_end);
}

//Function Number: 4
pickbetterenemy(param_00,param_01)
{
	if(isdefined(self.slasherenemy))
	{
		if(param_00 == self.slasherenemy)
		{
			if(gettime() - self.slasherenemystarttime < 3000)
			{
				return param_00;
			}
		}
		else if(param_01 == self.slasherenemy)
		{
			if(gettime() - self.slasherenemystarttime < 3000)
			{
				return param_01;
			}
		}
	}

	var_02 = self method_805F(param_00);
	var_03 = self method_805F(param_01);
	if(var_02 != var_03)
	{
		if(var_02)
		{
			return param_00;
		}

		return param_01;
	}

	var_04 = distancesquared(self.origin,param_00.origin);
	var_05 = distancesquared(self.origin,param_01.origin);
	if(var_04 < var_05)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 5
func_12E8A()
{
	var_00 = undefined;
	var_01 = self method_85B8();
	foreach(var_03 in level.players)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03.ignoreme || isdefined(var_03.var_222) && var_03.var_222.ignoreme)
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_03))
		{
			continue;
		}

		if(var_01 && !var_03 method_85BA())
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			var_00 = var_03;
			continue;
		}

		var_00 = pickbetterenemy(var_00,var_03);
	}

	if(!isdefined(var_00))
	{
		self.slasherenemy = undefined;
		return undefined;
	}

	if(!isdefined(self.slasherenemy) || var_00 != self.slasherenemy)
	{
		self.slasherenemy = var_00;
		self.slasherenemystarttime = gettime();
	}

	return self.slasherenemy;
}

//Function Number: 6
updateslashereveryframe(param_00)
{
	var_01 = func_12E8A();
	if(isdefined(var_01))
	{
		if(self method_805F(var_01))
		{
			self.var_A980 = gettime();
			self.var_1B2 = var_01.origin;
			if(!isdefined(self.enemyreacquiredtime))
			{
				self.enemyreacquiredtime = self.var_A980;
			}
		}
		else
		{
			self.enemyreacquiredtime = undefined;
		}
	}
	else
	{
		self.var_A980 = 0;
		self.var_1B2 = undefined;
		self.enemyreacquiredtime = undefined;
	}

	return level.var_6AD5;
}

//Function Number: 7
getcurrentdesiredaction(param_00)
{
	return self.var_3135.var_9928[param_00].slasheraction;
}

//Function Number: 8
calcenemytargetpos(param_00,param_01)
{
	var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	var_03 = var_02 getvelocity();
	var_04 = distance(var_02.origin,self.origin);
	var_05 = var_04 / 1500;
	var_06 = var_02 method_815B();
	var_07 = randomfloatrange(-20,-8);
	var_06 = var_06 + (0,0,var_07);
	var_08 = randomfloatrange(param_00,param_01);
	var_03 = var_03 * var_08;
	var_09 = var_03 * var_05;
	var_06 = var_06 + var_09;
	return var_06;
}

//Function Number: 9
sawbladeattack_aim_begin(param_00,param_01)
{
	self.aim_done_time = gettime() + 250;
}

//Function Number: 10
sawbladeattack_aim_tick(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.var_1C2 = calcenemytargetpos(var_02.sawblade_min_randomness,var_02.sawblade_max_randomness);
	if(gettime() >= self.aim_done_time)
	{
		if(self method_805F(var_01))
		{
			scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"shoot");
		}
		else
		{
			self.aim_done_time = gettime() + 100;
		}
	}

	return 1;
}

//Function Number: 11
sawbladeattack_aim_end(param_00,param_01)
{
	self.aim_done_time = undefined;
}

//Function Number: 12
sawbladeattack_shoot_begin(param_00,param_01)
{
	lib_0A1B::func_2962(1);
}

//Function Number: 13
sawbladeattack_shoot_tick(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(var_01) || !self method_805F(var_01))
	{
		scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"aim");
		return 0;
	}

	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.var_1C2 = calcenemytargetpos(var_02.sawblade_min_randomness,var_02.sawblade_max_randomness);
	return 1;
}

//Function Number: 14
sawbladeattack_shoot_end(param_00,param_01)
{
	lib_0A1B::func_2962(0);
}

//Function Number: 15
grenadethrow_begin(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	lib_0A1B::func_296C(1,var_01);
	scripts\asm\slasher\slasher_asm::setslasheraction("grenade_throw");
	self method_841F();
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"grenade_throw","grenade_throw");
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"grenade_throw");
}

//Function Number: 16
grenadethrow_tick(param_00)
{
	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 17
grenadethrow_end(param_00)
{
	scripts\asm\slasher\slasher_asm::clearslasheraction();
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.next_grenade_throw_time = gettime() + randomintrange(var_01.min_grenade_throw_interval,var_01.max_grenade_throw_interval);
	self.enemygrenadepos = undefined;
	lib_0A1B::func_296C(0);
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 18
melee_begin(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	scripts\asm\slasher\slasher_asm::setslasheraction(var_01);
	var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(var_01 == "swipe_attack")
	{
		var_03 = var_02 getvelocity();
		var_04 = length2dsquared(var_03);
		if(var_04 < 144)
		{
			self method_841F();
		}
		else
		{
			self.bmovingmelee = 1;
		}
	}
	else
	{
		self method_841F();
	}

	self.var_4B26 = var_02;
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,var_01,var_01);
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,var_01);
}

//Function Number: 19
melee_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 20
melee_end(param_00)
{
	self.var_4B26 = undefined;
	self.bmovingmelee = undefined;
	scripts\asm\slasher\slasher_asm::clearslasheraction();
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 21
block_begin(param_00)
{
	self method_841F();
	scripts\asm\slasher\slasher_asm::setslasheraction("block");
	var_01 = scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	var_01.blockendtime = gettime() + randomintrange(var_02.min_block_time,var_02.max_block_time);
}

//Function Number: 22
block_tick(param_00)
{
	var_01 = scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00);
	if(gettime() > var_01.blockendtime)
	{
		return level.var_6AD5;
	}

	if(gettime() - self.damageaccumulator.var_A96A > scripts\mp\agents\slasher\slasher_tunedata::gettunedata().quit_block_if_no_damage_time)
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 23
block_end(param_00)
{
	scripts\asm\slasher\slasher_asm::clearslasheraction();
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.nextblocktime = gettime() + randomintrange(var_01.min_block_interval,var_01.max_block_interval);
}

//Function Number: 24
summon_begin(param_00)
{
	self method_841F();
	scripts\asm\slasher\slasher_asm::setslasheraction("summon");
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"summon","summon");
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"summon");
}

//Function Number: 25
summon_tick(param_00)
{
	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 26
summon_end(param_00)
{
	scripts\asm\slasher\slasher_asm::clearslasheraction();
	self.lastsummontime = gettime();
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 27
teleport_begin(param_00)
{
	self method_841F();
	var_01 = getcurrentdesiredaction(param_00);
	scripts\asm\slasher\slasher_asm::setslasheraction(var_01);
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"teleport_in","teleport_in",::teleport_doteleport);
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"teleport_in");
}

//Function Number: 28
teleport_tick(param_00)
{
	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 29
teleport_doteleport(param_00,param_01)
{
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"teleport_out","teleport_out");
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"teleport_out");
}

//Function Number: 30
teleport_end(param_00)
{
	self show();
	self.teleportpos = undefined;
	self.nextteleporttesttime = gettime() + scripts\mp\agents\slasher\slasher_tunedata::gettunedata().min_time_between_teleports;
	self.brecentlyteleported = 1;
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
	scripts\asm\slasher\slasher_asm::clearslasheraction();
}

//Function Number: 31
taunt_begin(param_00)
{
	self method_841F();
	self.brecentlyteleported = undefined;
	scripts\asm\slasher\slasher_asm::setslasheraction("taunt");
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"taunt","taunt",undefined,undefined,3000);
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"taunt");
}

//Function Number: 32
taunt_tick(param_00)
{
	if(tryblock())
	{
		return level.var_6AD5;
	}

	if(trymeleeattacks())
	{
		return level.var_6AD5;
	}

	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 33
taunt_end(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.nexttaunttime = gettime() + randomintrange(var_01.min_taunt_interval,var_01.max_taunt_interval);
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
	scripts\asm\slasher\slasher_asm::clearslasheraction();
}

//Function Number: 34
debughandler_begin(param_00)
{
}

//Function Number: 35
debughandler_tick(param_00)
{
	if(!isdefined(level.slasherdebugdestination))
	{
		return level.var_6AD5;
	}

	self method_8287(16);
	self method_8286(level.slasherdebugdestination);
	return level.var_E87A;
}

//Function Number: 36
debughandler_end(param_00)
{
}

//Function Number: 37
ramattack_begin(param_00)
{
	self method_841F();
	scripts\asm\slasher\slasher_asm::setslasheraction("ram_attack");
	self method_84CC(1);
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	self.var_4B26 = var_01;
	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	scripts\aitypes\slasher\bt_state_api::chase_target_state_setup(param_00,var_02.ram_attack_chase_radius,self.var_4B26,::ramattack_chasedone,var_02.ram_attack_timeout);
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"chase");
}

//Function Number: 38
ramattack_tick(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_4B26))
	{
		return level.var_6AD5;
	}

	if(var_01 != self.var_4B26)
	{
		return level.var_6AD5;
	}

	var_02 = distancesquared(self.origin,var_01.origin);
	var_03 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(var_02 > var_03.ram_attack_abort_dist_sq)
	{
		return level.var_6AD5;
	}

	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		var_04 = scripts\aitypes\slasher\bt_state_api::btstate_getcurrentstatename(param_00);
		if(isdefined(var_04) && var_04 == "chase")
		{
			var_05 = var_01 getvelocity();
			var_06 = self getvelocity();
			if(vectordot(var_05,var_06) < 0)
			{
				if(var_02 < var_03.ram_attack_chase_radius_if_playing_chicken * var_03.ram_attack_chase_radius_if_playing_chicken)
				{
					ramattack_chasedone(param_00,"success");
				}
			}
		}

		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 39
ramattack_end(param_00)
{
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
	scripts\asm\slasher\slasher_asm::clearslasheraction();
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.nextramattacktesttime = gettime() + randomintrange(var_01.min_ram_attack_interval,var_01.max_ram_attack_interval);
	self.var_4B26 = undefined;
	self.bramattackdamageoccured = undefined;
	self method_84CC(0);
	lib_0A1B::func_2914();
}

//Function Number: 40
ramattack_chasedone(param_00,param_01)
{
	if(!isdefined(self.var_4B26) || !isalive(self.var_4B26))
	{
		scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
		return;
	}

	if(param_01 == "timeout")
	{
		scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
		return;
	}

	lib_0A1B::func_2965(self.var_4B26);
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"ram","ram_attack_anim",::ramattack_done,"end");
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"ram");
}

//Function Number: 41
ramattack_done(param_00,param_01)
{
	lib_0A1B::func_2915();
}

//Function Number: 42
groundpoundattack_begin(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	scripts\asm\slasher\slasher_asm::setslasheraction("ground_pound");
	self method_841F();
	scripts\aitypes\slasher\bt_state_api::asm_wait_state_setup(param_00,"slam","ground_pound");
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"slam");
}

//Function Number: 43
groundpoundattack_tick(param_00)
{
	if(scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 44
groundpoundattack_end(param_00)
{
	scripts\asm\slasher\slasher_asm::clearslasheraction();
}

//Function Number: 45
sawbladeattack_begin(param_00)
{
	scripts\asm\slasher\slasher_asm::setslasheraction("sawblade_attack");
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00).attackendtime = gettime() + randomintrange(var_01.min_sawblade_attack_time,var_01.max_sawblade_attack_time);
	self method_841F();
	scripts\aitypes\slasher\bt_state_api::btstate_transitionstate(param_00,"aim");
}

//Function Number: 46
sawbladeattack_tick(param_00)
{
	self method_841F();
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(isdefined(var_01))
	{
		var_02 = distancesquared(self.origin,var_01.origin);
		if(trymeleeattacks(var_02))
		{
			return level.var_6AD5;
		}

		if(tryblock())
		{
			return level.var_6AD5;
		}
	}
	else
	{
		return level.var_6AD5;
	}

	scripts\aitypes\slasher\bt_state_api::btstate_tickstates(param_00);
	if(gettime() >= scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00).attackendtime)
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 47
sawbladeattack_end(param_00)
{
	self.var_1C2 = undefined;
	scripts\aitypes\slasher\bt_state_api::btstate_getinstancedata(param_00).attackendtime = undefined;
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	self.nextsawbladeattacktime = gettime() + randomintrange(var_01.min_sawblade_attack_interval,var_01.max_sawblade_attack_interval);
	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
	scripts\asm\slasher\slasher_asm::clearslasheraction();
}

//Function Number: 48
trysawbladeattack(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	var_02 = gettime();
	if(!isdefined(self.nextsawbladeattacktime))
	{
		self.nextsawbladeattacktime = var_02 + randomintrange(var_01.min_sawblade_attack_interval,var_01.max_sawblade_attack_interval);
	}

	if(var_02 < self.nextsawbladeattacktime)
	{
		return 0;
	}

	if(param_00 < var_01.min_sawblade_attack_dist_sq)
	{
		return 0;
	}

	if(param_00 > var_01.max_sawblade_attack_dist_sq)
	{
		return 0;
	}

	var_03 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(self.enemyreacquiredtime) || var_02 - self.enemyreacquiredtime < var_01.min_clear_los_time_before_firing_saw)
	{
		return 0;
	}

	var_04 = anglestoforward(self.angles);
	var_05 = var_03.origin - self.origin;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = (var_05[0],var_05[1],0);
	var_05 = vectornormalize(var_05);
	var_06 = vectordot(var_04,var_05);
	if(var_06 < -0.259)
	{
		return 0;
	}

	var_07 = scripts\common\trace::func_48BC(0,1,1,0,1,0,0);
	var_08 = [];
	var_09 = var_03 geteye();
	var_0A = self geteye() - (0,0,12);
	var_0B = function_0288(var_0A,var_09,10,var_07,var_08,"physicsquery_closest");
	if(isdefined(var_0B) && var_0B.size > 0)
	{
		if(var_0B[0]["fraction"] < 0.8)
		{
			self.nextsawbladeattacktime = var_02 + 500;
			return 0;
		}
	}

	self.desiredaction = "sawblade_attack";
	return 1;
}

//Function Number: 49
tryramattack(param_00)
{
	if(isdefined(self.nextramattacktesttime) && gettime() < self.nextramattacktesttime)
	{
		return 0;
	}

	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(param_00 < var_01.ram_attack_mindist_sq)
	{
		return 0;
	}

	if(param_00 > var_01.ram_attack_maxdist_sq)
	{
		return 0;
	}

	self.nextramattacktesttime = gettime() + 5000;
	var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	var_03 = anglestoforward(self.angles);
	var_04 = var_02.origin;
	var_05 = var_04 - self.origin;
	var_03 = (var_03[0],var_03[1],0);
	var_05 = vectornormalize((var_05[0],var_05[1],0));
	var_06 = vectordot(var_03,var_05);
	if(var_06 < 0.707)
	{
		return 0;
	}

	if(!navisstraightlinereachable(self.origin,var_04,self))
	{
		self.nextramattacktesttime = gettime() + 500;
		return 0;
	}

	self.desiredaction = "ram_attack";
	return 1;
}

//Function Number: 50
trytaunt(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(!isdefined(self.nexttaunttime))
	{
		self.nexttaunttime = gettime() + randomintrange(var_01.min_taunt_interval,var_01.max_taunt_interval);
	}

	if(!scripts\common\utility::istrue(self.brecentlyteleported))
	{
		if(param_00 < var_01.min_dist_to_enemy_for_taunt_sq)
		{
			return 0;
		}
	}

	if(gettime() > self.nexttaunttime)
	{
		if(randomint(100) < var_01.taunt_chance)
		{
			self.desiredaction = "taunt";
			return 1;
		}
		else
		{
			self.nexttaunttime = gettime() + randomintrange(var_01.min_taunt_interval,var_01.max_taunt_interval);
		}
	}

	return 0;
}

//Function Number: 51
trysummon(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(!isdefined(self.nextsummontime))
	{
		self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval,var_01.max_summon_interval);
	}

	if(gettime() < self.nextsummontime)
	{
		return 0;
	}

	if(randomint(100) < var_01.summon_chance)
	{
		self.desiredaction = "summon";
		return 1;
	}
	else
	{
		self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval,var_01.max_summon_interval);
	}

	return 0;
}

//Function Number: 52
tryblock()
{
	if(!isdefined(self.damageaccumulator))
	{
		return 0;
	}

	if(isdefined(self.nextblocktime) && gettime() < self.nextblocktime)
	{
		return 0;
	}

	var_00 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(gettime() - self.damageaccumulator.var_A96A > var_00.max_time_after_last_damage_to_block)
	{
		self.damageaccumulator.accumulateddamage = 0;
		return 0;
	}

	var_00 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(self.damageaccumulator.accumulateddamage > var_00.need_to_block_damage_threshold)
	{
		if(randomint(100) < var_00.block_chance)
		{
			self.desiredaction = "block";
			self.damageaccumulator.accumulateddamage = 0;
			return 1;
		}
		else
		{
			self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage - var_00.need_to_block_damage_threshold / 2;
		}
	}

	return 0;
}

//Function Number: 53
findteleportdest()
{
	var_00 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	var_01 = anglestoforward(var_00.angles);
	var_02 = getrandomnavpoints(var_00.origin,1600,16,self);
	foreach(var_04 in var_02)
	{
		var_05 = var_04 - var_00.origin;
		var_06 = length2dsquared(var_05);
		if(var_06 < -7936)
		{
			continue;
		}

		var_07 = vectornormalize(var_05);
		var_08 = vectordot(var_01,var_07);
		if(var_08 < 0.707)
		{
			continue;
		}

		return var_04;
	}

	return undefined;
}

//Function Number: 54
tryemergencyteleport(param_00)
{
	if(isdefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime)
	{
		return 0;
	}

	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	var_02 = gettime();
	if(self.health >= self.last_health)
	{
		return 0;
	}

	self.last_health = self.health;
	var_03 = 0;
	var_04 = undefined;
	if(isdefined(self.var_233))
	{
		var_04 = self method_841E();
		if(var_04 < var_01.min_path_dist_for_teleport)
		{
			self.nextteleporttesttime = var_02 + 250;
			self notify("Abort_FindJumpScareTeleportPos");
			self.findteleportposstatus = undefined;
			return 0;
		}
	}

	if(!isdefined(self.lastenemyengagetime))
	{
		self.lastenemyengagetime = var_02;
	}

	if(!isdefined(self.findteleportposstatus))
	{
		thread findjumpscareteleportpos(scripts\mp\agents\slasher\slasher_agent::getenemy(),var_01.min_jump_scare_dist_to_player,var_01.max_jump_scare_dist_to_player);
		return 0;
	}

	if(self.findteleportposstatus == "working")
	{
		return 0;
	}

	if(self.findteleportposstatus == "invalid")
	{
		self.findteleportposstatus = undefined;
		var_05 = findteleportdest();
		if(isdefined(var_05))
		{
			self.teleportpos = var_05;
			self.desiredaction = "teleport";
			return 1;
		}
	}
	else if(self.findteleportposstatus == "success")
	{
		self.findteleportposstatus = undefined;
		self.desiredaction = "teleport";
		return 1;
	}
	else if(self.findteleportposstatus == "failure")
	{
		self.nextteleporttesttime = gettime() + 500;
		self.findteleportposstatus = undefined;
	}

	return 0;
}

//Function Number: 55
tryteleport(param_00)
{
	if(isdefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime)
	{
		return 0;
	}

	var_01 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	var_02 = gettime();
	var_03 = 0;
	var_04 = undefined;
	if(isdefined(self.var_233))
	{
		var_04 = self method_841E();
		if(var_04 < var_01.min_path_dist_for_teleport)
		{
			self.nextteleporttesttime = var_02 + 250;
			self notify("Abort_FindJumpScareTeleportPos");
			self.findteleportposstatus = undefined;
			return 0;
		}
	}

	if(!isdefined(self.lastenemyengagetime))
	{
		self.lastenemyengagetime = var_02;
	}

	if(var_02 - self.var_A980 > var_01.no_los_wait_time_before_teleport)
	{
		var_03 = 1;
	}
	else if(var_02 - self.lastenemyengagetime > var_01.attempt_teleport_if_no_engagement_within_time)
	{
		if(!isdefined(param_00))
		{
			var_05 = scripts\mp\agents\slasher\slasher_agent::getenemy();
			param_00 = distancesquared(self.origin,var_05.origin);
		}

		if(param_00 > var_01.teleport_min_dist_to_enemy_to_teleport_sq)
		{
			var_03 = 1;
		}
		else if(isdefined(var_04))
		{
			if(var_04 * var_04 > var_01.teleport_min_dist_to_enemy_to_teleport_sq)
			{
				var_03 = 1;
			}
		}
	}

	if(!var_03)
	{
		self.nextteleporttesttime = var_02 + 250;
		self notify("Abort_FindJumpScareTeleportPos");
		self.findteleportposstatus = undefined;
		return 0;
	}

	if(!isdefined(self.findteleportposstatus))
	{
		thread findjumpscareteleportpos(scripts\mp\agents\slasher\slasher_agent::getenemy(),var_01.min_jump_scare_dist_to_player,var_01.max_jump_scare_dist_to_player);
		return 0;
	}

	if(self.findteleportposstatus == "working")
	{
		return 0;
	}

	if(self.findteleportposstatus == "invalid")
	{
		self.findteleportposstatus = undefined;
		var_06 = findteleportdest();
		if(isdefined(var_06))
		{
			self.teleportpos = var_06;
			self.desiredaction = "teleport";
			return 1;
		}
	}
	else if(self.findteleportposstatus == "success")
	{
		self.findteleportposstatus = undefined;
		self.desiredaction = "teleport";
		return 1;
	}
	else if(self.findteleportposstatus == "failure")
	{
		self.nextteleporttesttime = gettime() + 500;
		self.findteleportposstatus = undefined;
	}

	return 0;
}

//Function Number: 56
trymeleeattacks(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(param_00))
	{
		param_00 = distancesquared(self.origin,var_01.origin);
	}

	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	if(param_00 > var_02.ground_pound_radius_sq)
	{
		return 0;
	}

	var_03 = 0;
	if(!ispointonnavmesh(var_01.origin))
	{
		if(param_00 > self.var_B631 * self.var_B631)
		{
			var_03 = 1;
		}
	}
	else if(param_00 > self.var_B62F)
	{
		var_03 = 1;
	}

	if(var_03)
	{
		return 0;
	}

	var_04 = var_01.origin - self.origin;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = anglestoforward(self.angles);
	var_06 = vectornormalize(var_04);
	var_07 = vectordot(var_05,var_06);
	if(var_07 < self.var_B607)
	{
		self.desiredaction = "melee_spin";
		return 1;
	}

	if(randomint(100) < self.meleeattackchance["melee_spin"])
	{
		self.desiredaction = "melee_spin";
		return 1;
	}

	self.desiredaction = "swipe_attack";
	return 1;
}

//Function Number: 57
func_128A2(param_00,param_01)
{
	var_02 = scripts\mp\agents\slasher\slasher_tunedata::gettunedata();
	var_03 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(param_01))
	{
		param_01 = var_03.origin;
	}

	if(!isdefined(self.next_grenade_throw_time))
	{
		self.next_grenade_throw_time = gettime() + randomintrange(var_02.min_grenade_throw_interval,var_02.max_grenade_throw_interval);
	}

	if(isdefined(self.next_grenade_throw_time) && gettime() < self.next_grenade_throw_time)
	{
		return 0;
	}

	self.next_grenade_throw_time = gettime() + 1000;
	if(param_00 < var_02.min_grenade_throw_dist_sq)
	{
		return 0;
	}

	if(param_00 > var_02.max_grenade_throw_dist_sq)
	{
		return 0;
	}

	var_04 = scripts\common\utility::func_824D(param_01);
	if(abs(var_04) > 60)
	{
		return 0;
	}

	if(!self method_81A2(var_03,param_01))
	{
		return 0;
	}

	var_05 = param_01;
	var_06 = scripts\mp\agents\slasher\slasher_agent::getslashergrenadehandoffset();
	var_07 = self method_806C(var_06,var_05,0,"min time","min energy");
	if(!isdefined(var_07))
	{
		self.next_grenade_throw_time = gettime() + 500;
		return 0;
	}

	self.desiredaction = "grenade_throw";
	self.enemygrenadepos = var_05;
	return 1;
}

//Function Number: 58
shouldtryramattack()
{
	if(!isdefined(level.slasher_level) || level.slasher_level > 3)
	{
		return 1;
	}

	return level.slasher_level >= 1;
}

//Function Number: 59
shouldtrygrenadethrow()
{
	if(!isdefined(level.slasher_level) || level.slasher_level > 3)
	{
		return 1;
	}

	return level.slasher_level >= 3;
}

//Function Number: 60
shouldtrysawbladeattack()
{
	if(!isdefined(level.slasher_level) || level.slasher_level > 3)
	{
		return 1;
	}

	return level.slasher_level >= 2;
}

//Function Number: 61
decideslasheraction(param_00)
{
	if(isdefined(level.slasherdebugdestination))
	{
		self.desiredaction = "debug_handler";
		return level.var_111AE;
	}

	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = gettime();
	if(tryblock())
	{
		self.lastenemyengagetime = var_02;
		return level.var_111AE;
	}

	if(var_02 - self.var_A980 < 500)
	{
		var_03 = distancesquared(var_01.origin,self.origin);
		if(scripts\common\utility::istrue(self.brecentlyteleported))
		{
			if(trytaunt(var_03))
			{
				self.brecentlyteleported = 0;
				return level.var_111AE;
			}
		}

		if(trymeleeattacks(var_03))
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}

		if(shouldtrygrenadethrow() && func_128A2(var_03))
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}

		if(shouldtrysawbladeattack() && trysawbladeattack(var_03))
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}

		if(shouldtryramattack() && tryramattack(var_03))
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}

		if(!scripts\common\utility::istrue(self.brecentlyteleported))
		{
			if(trytaunt(var_03))
			{
				return level.var_111AE;
			}
		}

		if(tryteleport(var_03))
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}
	}
	else
	{
		if(shouldtrygrenadethrow() && gettime() - self.var_A980 < 1200)
		{
			var_04 = distancesquared(self.origin,self.var_1B2);
			if(func_128A2(var_04,self.var_1B2))
			{
				self.lastenemyengagetime = var_02;
				return level.var_111AE;
			}
		}

		if(tryteleport())
		{
			self.lastenemyengagetime = var_02;
			return level.var_111AE;
		}
	}

	return level.var_6AD5;
}

//Function Number: 62
doslasheraction_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].slasheraction = self.desiredaction;
	var_01 = self.actions[self.desiredaction].fnbegin;
	self.desiredaction = undefined;
	if(isdefined(var_01))
	{
		[[ var_01 ]](param_00);
	}
}

//Function Number: 63
doslasheraction_tick(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	if(var_01 != "debug_handler")
	{
		var_02 = scripts\mp\agents\slasher\slasher_agent::getenemy();
		if(!isdefined(var_02))
		{
			return level.var_6AD5;
		}
	}

	var_03 = self.actions[var_01].fntick;
	if(isdefined(var_03))
	{
		var_04 = [[ var_03 ]](param_00);
		if(!isdefined(self.desiredaction))
		{
			return var_04;
		}
	}

	if(isdefined(self.desiredaction))
	{
		doslasheraction_end(param_00);
		doslasheraction_begin(param_00);
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 64
doslasheraction_end(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	var_02 = self.actions[var_01].fnend;
	if(isdefined(var_02))
	{
		[[ var_02 ]](param_00);
	}

	scripts\aitypes\slasher\bt_state_api::btstate_endstates(param_00);
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 65
followenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
}

//Function Number: 66
followenemy_tick(param_00)
{
	var_01 = scripts\mp\agents\slasher\slasher_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = getclosestpointonnavmesh(var_01.origin,self);
	self method_8286(var_02);
	return level.var_111AE;
}

//Function Number: 67
followenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 68
findenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
}

//Function Number: 69
findenemy_tick(param_00)
{
	return level.var_6AD5;
}

//Function Number: 70
findenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 71
findjumpscareteleportpos(param_00,param_01,param_02)
{
	self endon("death");
	self notify("Abort_FindJumpScareTeleportPos");
	self endon("Abort_FindJumpScareTeleportPos");
	if(!isdefined(level.slasherteleportpoints))
	{
		level.slasherteleportpoints = [];
		foreach(var_04 in function_00B4("slasher_teleport","targetname"))
		{
			level.slasherteleportpoints[level.slasherteleportpoints.size] = var_04.origin;
		}
	}

	if(level.slasherteleportpoints.size == 0)
	{
		self.findteleportposstatus = "invalid";
		return;
	}

	var_06 = param_00 getvelocity();
	self.findteleportposstatus = "working";
	if(length2d(var_06) < 1)
	{
		self.findteleportposstatus = "failure";
		return;
	}

	var_07 = vectornormalize(var_06);
	var_08 = getclosestpointonnavmesh(param_00.origin);
	var_09 = [];
	foreach(var_0B in level.slasherteleportpoints)
	{
		var_0C = distance2dsquared(var_0B,var_08);
		if(var_0C > param_01 * param_01 && var_0C < param_02 * param_02)
		{
			if(!is_near_any_player(var_0B))
			{
				var_09[var_09.size] = var_0B;
			}
		}
	}

	if(var_09.size == 0)
	{
		self.findteleportposstatus = "failure";
		return;
	}

	scripts\common\utility::array_randomize(var_09);
	foreach(var_0B in var_09)
	{
		var_0F = getclosestpointonnavmesh(var_0B);
		var_10 = self method_8428(var_08,var_0F);
		if(!isdefined(var_10) || var_10.size < 2)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		var_11 = vectornormalize(var_10[1] - var_08);
		var_12 = vectordot(var_11,var_07);
		if(var_12 < 0.707)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		var_13 = calcpathdist(var_10);
		var_14 = distance(var_10[0],var_10[var_10.size - 1]);
		if(var_13 > var_14 * 3)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		self.findteleportposstatus = "success";
		self.teleportpos = var_0B;
		return;
	}

	self.findteleportposstatus = "failure";
}

//Function Number: 72
calcpathdist(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		var_01 = var_01 + distance(param_00[var_02],param_00[var_02 + 1]);
	}

	return var_01;
}

//Function Number: 73
is_near_any_player(param_00)
{
	var_01 = 90000;
	foreach(var_03 in level.players)
	{
		if(distancesquared(param_00,var_03.origin) < var_01)
		{
			return 1;
		}
	}

	return 0;
}