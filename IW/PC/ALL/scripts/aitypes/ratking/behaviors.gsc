/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\ratking\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 93
 * Decompile Time: 3644 ms
 * Timestamp: 10/26/2023 11:58:54 PM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	setupbehaviorstates();
	self.desiredaction = undefined;
	self.var_A980 = 0;
	self.lastenemyengagetime = 0;
	self.ratkingenemy = undefined;
	self.ratkingenemystarttime = 0;
	self.last_health = self.health;
	self.battackzombies = 0;
	lib_0A1B::func_2968("run");
	return level.var_111AE;
}

//Function Number: 2
setupbtaction(param_00,param_01,param_02,param_03)
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
setupbehaviorstates()
{
	setupbtaction("melee_attack",::melee_begin,::melee_tick,::melee_end);
	setupbtaction("staff_stomp",::staffstompattack_begin,::staffstompattack_tick,::staffstompattack_end);
	setupbtaction("summon",::summon_begin,::summon_tick,::summon_end);
	setupbtaction("block",::block_begin,::block_tick,::block_end);
	setupbtaction("staff_projectile",::staffprojectile_begin,::staffprojectile_tick,::staffprojectile_end);
	setupbtaction("shield_attack",::shieldattack_begin,::shieldattack_tick,::shieldattack_end);
	setupbtaction("shield_attack_spot",::shieldattackspot_begin,::shieldattackspot_tick,::shieldattackspot_end);
	setupbtaction("teleport",::teleport_begin,::teleport_tick,::teleport_end);
	setupbtaction("debug_handler",::debughandler_begin,::debughandler_tick,::debughandler_end);
}

//Function Number: 4
pickbetterenemy(param_00,param_01)
{
	if(isdefined(self.ratkingenemy))
	{
		if(param_00 == self.ratkingenemy)
		{
			if(gettime() - self.ratkingenemystarttime < 3000)
			{
				return param_00;
			}
		}
		else if(param_01 == self.ratkingenemy)
		{
			if(gettime() - self.ratkingenemystarttime < 3000)
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
	if(scripts\common\utility::istrue(self.outofplayspace))
	{
		self.ratkingenemy = undefined;
		return undefined;
	}

	if(scripts\common\utility::istrue(self.battackzombies) && isdefined(self.zombietarget))
	{
		if(isalive(self.zombietarget) && self.zombietarget.health >= 1)
		{
			if(isdefined(self.ratkingenemy) && self.zombietarget == self.ratkingenemy)
			{
				return self.ratkingenemy;
			}
		}
	}

	if(isdefined(self.ratkingenemy) && !shouldignoreenemy(self.ratkingenemy))
	{
		if(gettime() - self.ratkingenemystarttime < 3000)
		{
			return self.ratkingenemy;
		}
	}
	else
	{
		self.ratkingenemy = undefined;
	}

	if(isdefined(self.ratkingenemy))
	{
		var_00 = self.ratkingenemy;
	}
	else
	{
		var_00 = undefined;
	}

	foreach(var_02 in level.players)
	{
		if(shouldignoreenemy(var_02))
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_02))
		{
			continue;
		}

		if(isdefined(var_00) && isdefined(self.ratkingenemy) && self.ratkingenemy == var_02)
		{
			continue;
		}
		else
		{
			if(!isdefined(var_00))
			{
				var_00 = var_02;
				continue;
			}

			var_00 = pickbetterenemy(var_00,var_02);
		}
	}

	if(!isdefined(var_00))
	{
		self.ratkingenemy = undefined;
		return undefined;
	}

	if(!isdefined(self.ratkingenemy) || var_00 != self.ratkingenemy)
	{
		self.ratkingenemy = var_00;
		self.ratkingenemystarttime = gettime();
	}

	return self.ratkingenemy;
}

//Function Number: 6
updateeveryframe(param_00)
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
	return self.var_3135.var_9928[param_00].ratkingaction;
}

//Function Number: 8
melee_begin(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	scripts\asm\ratking\ratking_asm::setaction(var_01);
	var_02 = scripts\mp\agents\ratking\ratking_agent::getenemy();
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

	self.var_4B26 = var_02;
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,var_01,var_01);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,var_01);
}

//Function Number: 9
melee_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	self method_841F();
	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 10
melee_end(param_00)
{
	self.var_4B26 = undefined;
	self.bmovingmelee = undefined;
	scripts\asm\ratking\ratking_asm::clearaction();
	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 11
block_begin(param_00)
{
	self method_841F();
	scripts\asm\ratking\ratking_asm::setaction("block");
	var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_01.blockendtime = gettime() + randomintrange(var_02.min_block_time,var_02.max_block_time);
	self.var_2BB8 = 1;
}

//Function Number: 12
block_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = gettime();
	if(var_02 > var_01.blockendtime)
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.remove_shield))
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	var_03 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	if(var_02 - self.damageaccumulator.var_A96A > var_03.quit_block_if_no_damage_time)
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 13
block_end(param_00)
{
	scripts\asm\ratking\ratking_asm::clearaction();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	self.nextblocktime = gettime() + randomintrange(var_01.min_block_interval,var_01.max_block_interval);
	self.var_2BB8 = undefined;
}

//Function Number: 14
summon_begin(param_00)
{
	self method_841F();
	scripts\asm\ratking\ratking_asm::setaction("summon");
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"summon","summon");
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"summon");
}

//Function Number: 15
summon_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.remove_staff))
	{
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.remove_staff = undefined;
	return level.var_6AD5;
}

//Function Number: 16
summon_end(param_00)
{
	scripts\asm\ratking\ratking_asm::clearaction();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval,var_01.max_summon_interval);
	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 17
debughandler_begin(param_00)
{
}

//Function Number: 18
debughandler_tick(param_00)
{
	if(!isdefined(level.ratkingdebugdestination))
	{
		return level.var_6AD5;
	}

	self method_8287(16);
	self method_8286(level.ratkingdebugdestination);
	return level.var_E87A;
}

//Function Number: 19
debughandler_end(param_00)
{
}

//Function Number: 20
shieldattackspot_begin(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
	scripts\asm\ratking\ratking_asm::setaction("shield_throw_at_spot");
	self method_841F();
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"shieldattack","shield_throw_at_spot");
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"shieldattack");
}

//Function Number: 21
shieldattack_begin(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	scripts\asm\ratking\ratking_asm::setaction("shield_throw");
	self method_841F();
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"shieldattack","shield_throw");
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"shieldattack");
}

//Function Number: 22
shieldattackspot_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.remove_shield))
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.remove_shield = undefined;
	return level.var_6AD5;
}

//Function Number: 23
shieldattack_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.remove_shield))
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		self.remove_shield = undefined;
		return level.var_6AD5;
	}

	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.remove_shield = undefined;
	return level.var_6AD5;
}

//Function Number: 24
shieldattackspot_end(param_00)
{
	scripts\asm\ratking\ratking_asm::clearaction();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	self.ratkingbouncetarget = undefined;
	var_02 = randomintrange(var_01.staff_shield_attack_interval_min,var_01.staff_shield_attack_interval_max);
	self.nextshieldattacktime = gettime() + var_02;
}

//Function Number: 25
shieldattack_end(param_00)
{
	scripts\asm\ratking\ratking_asm::clearaction();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_02 = randomintrange(var_01.staff_shield_attack_interval_min,var_01.staff_shield_attack_interval_max);
	self.nextshieldattacktime = gettime() + var_02;
}

//Function Number: 26
staffprojectile_begin(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	scripts\asm\ratking\ratking_asm::setaction("staff_projectile");
	self method_841F();
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"projectile","staff_projectile");
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"projectile");
	self.staffproj = 1;
}

//Function Number: 27
staffprojectile_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.remove_staff))
	{
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.remove_staff = undefined;
	return level.var_6AD5;
}

//Function Number: 28
staffprojectile_end(param_00)
{
	scripts\asm\ratking\ratking_asm::clearaction();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_02 = randomintrange(var_01.staff_projectile_interval_min,var_01.staff_projectile_interval_max);
	self.nextstaffprojectiletime = gettime() + var_02;
	self.staffproj = undefined;
}

//Function Number: 29
staffstompattack_begin(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	scripts\asm\ratking\ratking_asm::setaction("staff_stomp");
	self method_841F();
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"stomp","staff_stomp");
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"stomp");
	self.stomp = 1;
}

//Function Number: 30
staffstompattack_tick(param_00)
{
	if(scripts\common\utility::istrue(self.force_teleport))
	{
		self.remove_shield = undefined;
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.remove_staff))
	{
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		self.remove_staff = undefined;
		return level.var_6AD5;
	}

	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.remove_staff = undefined;
	return level.var_6AD5;
}

//Function Number: 31
staffstompattack_end(param_00)
{
	scripts\asm\ratking\ratking_asm::clearaction();
	self.nextstaffstomptime = gettime() + scripts\mp\agents\ratking\ratking_tunedata::gettunedata().staff_stomp_interval;
	self.nextstaffstompinnertime = gettime() + scripts\mp\agents\ratking\ratking_tunedata::gettunedata().staff_stomp_inner_interval;
	self.stomp = undefined;
}

//Function Number: 32
teleport_begin(param_00)
{
	self method_841F();
	var_01 = getcurrentdesiredaction(param_00);
	scripts\asm\ratking\ratking_asm::setaction(var_01);
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"teleport_in","teleport_in",::teleport_doteleport);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"teleport_in");
}

//Function Number: 33
teleport_tick(param_00)
{
	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 34
teleport_doteleport(param_00,param_01)
{
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"teleport_out","teleport_out");
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"teleport_out");
}

//Function Number: 35
teleport_end(param_00)
{
	self show();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	self.nextteleporttesttime = gettime() + var_01.min_time_between_teleports;
	self.nexttraversalteleporttesttime = gettime() + var_01.min_time_between_traversal_teleports;
	self.brecentlyteleported = 1;
	self.teleporttospot = undefined;
	if(scripts\common\utility::istrue(level.rat_king.force_teleport))
	{
		thread scripts\cp\maps\cp_disco\rat_king_fight::restorerktuning();
		thread scripts\cp\maps\cp_disco\rat_king_fight::restorerkstagetoggles();
		level.rat_king.force_teleport = undefined;
	}

	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
	scripts\asm\ratking\ratking_asm::clearaction();
}

//Function Number: 36
isnearanypointinarray(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		var_05 = distancesquared(var_04,param_00);
		if(var_05 < param_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 37
isnearagents(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		var_05 = distancesquared(var_04.origin,param_00);
		if(var_05 < param_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 38
calcsummonspawnpoints(param_00,param_01)
{
	var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_03 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	if(scripts\common\utility::flag("rk_fight_started"))
	{
		var_04 = getrandomnavpoints(level.rk_center_arena_struct.origin,var_02.summon_max_radius,64,self);
	}
	else if(isdefined(var_04))
	{
		var_04 = getrandomnavpoints(var_04.origin,var_03.summon_max_radius,64,self);
	}
	else
	{
		var_04 = getrandomnavpoints(self.origin,var_03.summon_max_radius,64,self);
	}

	scripts\common\utility::array_randomize(var_04);
	var_05 = var_02.summon_min_radius * var_02.summon_min_radius;
	self.var_108FB = [];
	foreach(var_07 in var_04)
	{
		var_08 = distancesquared(var_07,self.origin);
		if(var_08 < var_05)
		{
			continue;
		}

		if(isdefined(level.pam_grier))
		{
			var_08 = distancesquared(var_07,level.pam_grier.origin);
			if(var_08 < var_05)
			{
				continue;
			}
		}

		if(is_near_any_player(var_07))
		{
			continue;
		}

		if(isnearanypointinarray(var_07,self.var_108FB,var_02.summon_spawn_min_dist_between_agents_sq))
		{
			continue;
		}

		if(isnearagents(var_07,param_01,var_02.summon_spawn_min_dist_between_agents_sq))
		{
			continue;
		}

		self.var_108FB[self.var_108FB.size] = var_07;
		if(self.var_108FB.size >= param_00)
		{
			break;
		}
	}

	if(self.var_108FB.size > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
trysummon(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(!isdefined(self.nextsummontime))
	{
		self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval,var_01.max_summon_interval);
	}

	if(gettime() < self.nextsummontime)
	{
		return 0;
	}

	var_02 = scripts\mp\_mp_agent::func_7D95(var_01.summon_agent_type);
	if(var_02.size > var_01.max_num_agents_to_allow_summon)
	{
		self.nextsummontime = gettime() + 1000;
		return 0;
	}

	if(isdefined(self.lastsummontime))
	{
		self.lastsummontime = undefined;
		self.nextsummontime = gettime() + var_01.min_time_between_summon_rounds;
	}

	if(randomint(100) < var_01.summon_chance)
	{
		var_03 = randomintrange(var_01.summon_min_spawn_num,var_01.summon_max_spawn_num);
		if(calcsummonspawnpoints(var_03,var_02))
		{
			self.desiredaction = "summon";
			self.lastsummontime = gettime();
			return 1;
		}
	}

	self.nextsummontime = gettime() + randomintrange(var_01.min_summon_interval,var_01.max_summon_interval);
	return 0;
}

//Function Number: 40
tryblock()
{
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		return 0;
	}

	if(!isdefined(self.damageaccumulator))
	{
		return 0;
	}

	if(isdefined(self.nextblocktime) && gettime() < self.nextblocktime)
	{
		return 0;
	}

	var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(gettime() - self.damageaccumulator.var_A96A > var_00.max_time_after_last_damage_to_block)
	{
		self.damageaccumulator.accumulateddamage = 0;
		return 0;
	}

	var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
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

//Function Number: 41
tryshieldattackatpos(param_00)
{
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		return 0;
	}

	var_01 = level.rat_king_bounce_structs;
	if(isdefined(level.inactive_eye_targets))
	{
		var_01 = level.inactive_eye_targets;
	}

	var_02 = gettime();
	if(isdefined(self.nextshieldattacktime))
	{
		if(var_02 < self.nextshieldattacktime)
		{
			return 0;
		}
	}

	var_03 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(param_00 < var_03.staff_shield_attack_min_dist_sq)
	{
		return 0;
	}

	if(param_00 > var_03.staff_shield_attack_max_dist_sq)
	{
		return 0;
	}

	if(!isdefined(self.enemyreacquiredtime) || var_02 - self.enemyreacquiredtime < var_03.min_clear_los_time_before_shield_attack)
	{
		return 0;
	}

	var_01 = scripts\common\utility::func_22A8(var_01);
	foreach(var_05 in var_01)
	{
		var_06 = anglestoforward(self.angles);
		var_07 = var_05.origin - self.origin;
		var_06 = (var_06[0],var_06[1],0);
		var_07 = (var_07[0],var_07[1],0);
		var_07 = vectornormalize(var_07);
		var_08 = vectordot(var_06,var_07);
		if(var_08 < -0.259)
		{
			continue;
		}

		var_09 = scripts\common\trace::func_48BC(0,1,1,1,1,0,0);
		var_0A = [];
		var_0B = var_05.origin;
		var_0C = self.origin + (0,0,30);
		var_0D = function_0288(var_0C,var_0B,10,var_09,var_0A,"physicsquery_closest");
		if(isdefined(var_0D) && var_0D.size > 0)
		{
			if(var_0D[0]["fraction"] < 0.95)
			{
				continue;
			}
		}

		self.desiredaction = "shield_attack_spot";
		self.ratkingbouncetarget = var_05;
		return 1;
	}

	self.nextshieldattacktime = var_02 + 500;
	return 0;
}

//Function Number: 42
tryshieldattack(param_00)
{
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		return 0;
	}

	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	var_02 = gettime();
	if(isdefined(self.nextshieldattacktime))
	{
		if(var_02 < self.nextshieldattacktime)
		{
			return 0;
		}
	}

	var_03 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(param_00 < var_03.staff_shield_attack_min_dist_sq)
	{
		return 0;
	}

	if(param_00 > var_03.staff_shield_attack_max_dist_sq)
	{
		return 0;
	}

	if(!isdefined(self.enemyreacquiredtime) || var_02 - self.enemyreacquiredtime < var_03.min_clear_los_time_before_shield_attack)
	{
		return 0;
	}

	var_04 = anglestoforward(self.angles);
	var_05 = var_01.origin - self.origin;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = (var_05[0],var_05[1],0);
	var_05 = vectornormalize(var_05);
	var_06 = vectordot(var_04,var_05);
	if(var_06 < -0.259)
	{
		self.nextshieldattacktime = var_02 + 500;
		return 0;
	}

	var_07 = scripts\common\trace::func_48BC(0,1,1,0,1,0,0);
	var_08 = [];
	var_09 = var_01 geteye() - (0,0,12);
	var_0A = self geteye() - (0,0,12);
	var_0B = function_0288(var_0A,var_09,10,var_07,var_08,"physicsquery_closest");
	if(isdefined(var_0B) && var_0B.size > 0)
	{
		if(var_0B[0]["fraction"] < 0.8)
		{
			self.nextshieldattacktime = var_02 + 500;
			return 0;
		}
	}

	self.desiredaction = "shield_attack";
	return 1;
}

//Function Number: 43
trystaffprojectile(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	if(isdefined(self.nextstaffprojectiletime))
	{
		if(gettime() < self.nextstaffprojectiletime)
		{
			return 0;
		}
	}

	var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(param_00 < var_02.staff_projectile_min_dist_sq)
	{
		return 0;
	}

	if(param_00 > var_02.staff_projectile_max_dist_sq)
	{
		return 0;
	}

	if(!navisstraightlinereachable(self.origin,var_01.origin,self))
	{
		self.nextstaffprojectiletime = gettime() + 500;
		return 0;
	}

	self.desiredaction = "staff_projectile";
	return 1;
}

//Function Number: 44
trystaffstomp(param_00)
{
	if(rk_isonplatform())
	{
		return 0;
	}

	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	if(!isdefined(param_00))
	{
		param_00 = distancesquared(self.origin,var_01.origin);
	}

	var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(param_00 > var_02.staff_stomp_outer_radius_sq)
	{
		return 0;
	}

	self.desiredaction = "staff_stomp";
	return 1;
}

//Function Number: 45
trymeleeattacks(param_00)
{
	if(rk_isonplatform())
	{
		return 0;
	}

	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	if(!isdefined(param_00))
	{
		param_00 = distancesquared(self.origin,var_01.origin);
	}

	var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_03 = gettime();
	var_04 = shouldtrystomp();
	var_05 = 0;
	var_06 = 0;
	if(param_00 > var_02.staff_stomp_inner_radius_sq)
	{
		if(param_00 > var_02.staff_stomp_outer_radius_sq)
		{
			return 0;
		}

		if(isdefined(self.nextstaffstomptime) && var_03 < self.nextstaffstomptime)
		{
			return 0;
		}
	}
	else if(isdefined(self.nextstaffstompinnertime) && var_03 < self.nextstaffstompinnertime)
	{
		var_06 = 1;
	}

	if(!ispointonnavmesh(var_01.origin))
	{
		if(param_00 > self.var_B631 * self.var_B631)
		{
			var_06 = 1;
		}
	}
	else if(param_00 > self.var_B62F)
	{
		var_06 = 1;
	}

	if(var_04 && var_06 && !var_05)
	{
		self.desiredaction = "staff_stomp";
		return 1;
	}

	var_07 = var_01.origin - self.origin;
	var_07 = (var_07[0],var_07[1],0);
	var_08 = anglestoforward(self.angles);
	var_09 = vectornormalize(var_07);
	var_0A = vectordot(var_08,var_09);
	if(var_0A < self.var_B607)
	{
		if(var_04)
		{
			return 0;
		}

		if(var_05)
		{
			return 0;
		}

		self.desiredaction = "staff_stomp";
		return 1;
	}

	if(var_04 && !var_05)
	{
		if(randomint(100) < self.meleeattackchance["staff_stomp"])
		{
			self.desiredaction = "staff_stomp";
			return 1;
		}
	}
	else if(var_06)
	{
		return 0;
	}

	self.desiredaction = "melee_attack";
	return 1;
}

//Function Number: 46
distancecompare(param_00,param_01)
{
	var_02 = distance2dsquared(level.rk_center_arena_struct.origin,param_00.origin);
	var_03 = distance2dsquared(level.rk_center_arena_struct.origin,param_01.origin);
	return var_02 < var_03;
}

//Function Number: 47
tryattackzombies()
{
	var_00 = gettime();
	if(isdefined(self.nextstaffstomptime) && var_00 < self.nextstaffstomptime)
	{
		return 0;
	}

	var_01 = scripts\cp\maps\cp_disco\rat_king_fight::getbrainattractorzombies();
	var_02 = scripts\common\utility::func_22C3(var_01,::distancecompare);
	self.zombietarget = undefined;
	foreach(var_04 in var_02)
	{
		if(var_04 == self)
		{
			continue;
		}

		if(var_04 == self)
		{
			continue;
		}

		if(!isalive(var_04))
		{
			continue;
		}

		if(var_04.health < 1)
		{
			continue;
		}

		if(distance(var_04.origin,level.rk_center_arena_struct.origin) >= 250)
		{
			continue;
		}

		if(isdefined(var_04.var_10C))
		{
			if(isplayer(var_04.var_10C))
			{
				continue;
			}
		}

		self.zombietarget = var_04;
		break;
	}

	if(!isdefined(self.zombietarget))
	{
		return 0;
	}

	self.ratkingenemy = self.zombietarget;
	var_06 = distancesquared(self.origin,self.zombietarget.origin);
	if(trystaffstomp(var_06))
	{
		return 1;
	}

	self.teleportpos = self.zombietarget.origin - anglestoforward(self.zombietarget.angles) * 48;
	self.findteleportposstatus = undefined;
	self.desiredaction = "teleport";
	return 1;
}

//Function Number: 48
tryteleport(param_00)
{
	if(!scripts\common\utility::istrue(self.force_teleport))
	{
		if(isdefined(self.nextteleporttesttime) && gettime() < self.nextteleporttesttime)
		{
			return 0;
		}
	}

	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_02 = gettime();
	var_03 = 0;
	var_04 = undefined;
	if(isdefined(self.var_233))
	{
		var_04 = self method_841E();
		if(var_04 < var_01.min_path_dist_for_teleport)
		{
			self.nextteleporttesttime = var_02 + 250;
			self notify("Abort_FindTeleportPos");
			self.findteleportposstatus = undefined;
			return 0;
		}

		var_05 = self method_84F9(var_04);
		if(shouldtrytraversalteleport() && isdefined(var_05))
		{
			var_06 = var_05["node"];
			var_07 = var_05["position"];
			var_08 = var_06.var_48;
			if(isdefined(var_08))
			{
				var_09 = self.var_238F;
				var_0A = level.var_2303[var_09];
				var_0B = var_0A.var_10E2F[var_08];
				if(!isdefined(var_0B))
				{
					var_08 = "traverse_external";
				}

				if(var_08 == "traverse_external")
				{
					self.teleportpos = var_07;
					self.desiredaction = "teleport";
					return level.var_111AE;
				}
			}
		}
	}

	if(!isdefined(self.lastenemyengagetime))
	{
		self.lastenemyengagetime = var_02;
	}

	if(rk_shouldbeonplatform())
	{
		var_03 = 1;
	}
	else if(var_02 - self.var_A980 > var_01.no_los_wait_time_before_teleport)
	{
		var_03 = 1;
	}
	else if(var_02 - self.lastenemyengagetime > var_01.attempt_teleport_if_no_engagement_within_time)
	{
		if(!isdefined(param_00))
		{
			var_0C = scripts\mp\agents\ratking\ratking_agent::getenemy();
			param_00 = distancesquared(self.origin,var_0C.origin);
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

	if(scripts\common\utility::istrue(self.bshouldfastteleport))
	{
		var_0D = getdamageaccumulator();
		if(isdefined(var_0D))
		{
			if(var_01.cfastteleportduetodamagechance > 0 && var_0D.accumulateddamage > 0)
			{
				var_0E = var_0D.accumulateddamage / self.maxhealth;
				if(var_0E >= var_01.cfastteleportdamagepct)
				{
					cleardamageaccumulator();
					var_0F = randomint(100);
					if(var_0F < var_01.cfastteleportduetodamagechance)
					{
						var_03 = 1;
						self.findteleportposstatus = undefined;
					}
				}
			}
		}
	}

	if(!var_03)
	{
		self.nextteleporttesttime = var_02 + 250;
		self notify("Abort_FindTeleportPos");
		self.findteleportposstatus = undefined;
		return 0;
	}

	if(!scripts\common\utility::flag("rk_fight_started"))
	{
		self.findteleportposstatus = "invalid";
	}

	if(!isdefined(self.findteleportposstatus))
	{
		thread findteleportpos(scripts\mp\agents\ratking\ratking_agent::getenemy(),var_01.min_teleport_dist_to_player,var_01.max_teleport_dist_to_player,var_01.telefrag_dist_sq,var_01);
		return 0;
	}

	if(self.findteleportposstatus == "working")
	{
		return 0;
	}

	if(self.findteleportposstatus == "invalid")
	{
		self.findteleportposstatus = undefined;
		var_10 = findteleportposinfrontofenemy();
		if(isdefined(var_10))
		{
			var_0C = scripts\mp\agents\ratking\ratking_agent::getenemy();
			if(!isdefined(var_0C))
			{
				return 0;
			}

			var_11 = self method_8428(var_10,var_0C.origin);
			if(!isdefined(var_11) || var_11.size < 2)
			{
				return 0;
			}

			var_12 = distance(var_10,var_0C.origin);
			var_04 = calcpathdist(var_11);
			if(var_04 > var_12 * 3)
			{
				return 0;
			}

			self.teleportpos = var_10;
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

//Function Number: 49
findteleportspotinenemyview(param_00,param_01)
{
	var_02 = param_00.angles[1];
	var_03 = param_00.angles;
	var_04 = randomintrange(param_01.cfastteleportminangledelta,param_01.cfastteleportmaxangledelta);
	if(randomint(100) < 50)
	{
		var_04 = var_04 * -1;
	}

	var_05 = distance(self.origin,param_00.origin);
	var_06 = randomfloatrange(param_01.cfastteleportcloseindistpctmin,param_01.cfastteleportcloseindistpctmax);
	var_07 = var_05 * var_06;
	if(var_07 < param_01.cfastteleportmindisttoenemytoteleport)
	{
		var_07 = param_01.cfastteleportmindisttoenemytoteleport;
	}

	var_08 = angleclamp180(var_03[1] + var_04);
	var_09 = anglestoforward((0,var_08,0));
	var_0A = param_00.origin + var_09 * var_07;
	var_0A = getclosestpointonnavmesh(var_0A,self);
	return var_0A;
}

//Function Number: 50
cleardamageaccumulator()
{
	self.damageaccumulator.accumulateddamage = 0;
	self.damageaccumulator.var_A96A = 0;
}

//Function Number: 51
getdamageaccumulator()
{
	if(!isdefined(self.damageaccumulator))
	{
		self.damageaccumulator = spawnstruct();
		self.damageaccumulator.accumulateddamage = 0;
	}

	var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	if(!isdefined(self.damageaccumulator.var_A96A) || gettime() > self.damageaccumulator.var_A96A + var_00.cdamageaccumulationcleartimems)
	{
		self.damageaccumulator.accumulateddamage = 0;
		self.damageaccumulator.var_A96A = 0;
	}

	if(self.damageaccumulator.accumulateddamage == 0)
	{
		return undefined;
	}

	return self.damageaccumulator;
}

//Function Number: 52
findteleportpos(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self notify("Abort_FindTeleportPos");
	self endon("Abort_FindTeleportPos");
	if(!isdefined(param_00))
	{
		self.findteleportposstatus = "invalid";
		return;
	}

	var_05 = getvalidteleportpoints();
	if(!isdefined(var_05))
	{
		var_05 = [];
		foreach(var_07 in function_00B4("ratking_teleport","targetname"))
		{
			var_05[var_05.size] = var_07.origin;
		}
	}

	if(var_05.size == 0)
	{
		self.findteleportposstatus = "invalid";
		return;
	}

	var_09 = rk_isonplatform() && rk_shouldbeonplatform();
	var_0A = param_00 getvelocity();
	if(!var_09)
	{
		self.findteleportposstatus = "working";
		if(length2d(var_0A) < 1)
		{
			self.findteleportposstatus = "failure";
			return;
		}
	}

	var_0B = vectornormalize(var_0A);
	var_0C = getclosestpointonnavmesh(param_00.origin);
	var_0D = [];
	var_0E = [];
	foreach(var_10 in var_05)
	{
		var_11 = distance2dsquared(var_10,var_0C);
		if(var_11 > param_01 * param_01 && var_11 < param_02 * param_02)
		{
			var_0E[var_0E.size] = var_10;
			if(!is_near_any_targets(var_10))
			{
				var_0D[var_0D.size] = var_10;
			}
		}
	}

	if(var_0D.size == 0)
	{
		if(scripts\common\utility::istrue(self.force_teleport))
		{
			var_0D = var_0E;
		}
		else if(var_0E.size <= 0)
		{
			self.findteleportposstatus = "failure";
			return;
		}
		else
		{
			var_0D = var_0E;
		}
	}

	var_0D = scripts\common\utility::func_22A8(var_0D);
	foreach(var_10 in var_0D)
	{
		if(isdefined(level.pam_grier))
		{
			var_11 = distancesquared(var_10,level.pam_grier.origin);
			if(var_11 < param_03)
			{
				continue;
			}
		}

		var_14 = getclosestpointonnavmesh(var_10);
		var_15 = distance(self.origin,var_14);
		if(var_15 < param_04.min_path_dist_for_teleport)
		{
			continue;
		}

		var_16 = self method_8428(var_0C,var_14);
		if(!var_09)
		{
			if(!isdefined(var_16) || var_16.size < 2)
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			var_17 = vectornormalize(var_16[1] - var_0C);
			var_18 = vectordot(var_17,var_0B);
			if(var_18 < 0.707)
			{
				scripts\common\utility::func_136F7();
				continue;
			}
		}

		var_19 = calcpathdist(var_16);
		var_1A = distance(var_16[0],var_16[var_16.size - 1]);
		if(var_19 > var_1A * 3)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		self.findteleportposstatus = "success";
		self.teleportpos = var_10;
		return;
	}

	self.teleporttospot = undefined;
	self.findteleportposstatus = "failure";
}

//Function Number: 53
getvalidteleportpoints()
{
	var_00 = undefined;
	var_01 = rk_isonplatform();
	var_02 = scripts\common\utility::istrue(self.shouldbeonplatform);
	if(var_02)
	{
		self.teleporttospot = 1;
		var_00 = level.ratkingplatformteleportpoints;
	}
	else if(var_01)
	{
		if(var_02)
		{
			self.teleporttospot = 1;
			var_00 = level.ratkingplatformteleportpoints;
		}
		else
		{
			self.teleporttospot = undefined;
			var_00 = level.ratkingteleportpoints;
		}
	}
	else
	{
		self.teleporttospot = undefined;
		var_00 = level.ratkingteleportpoints;
	}

	return var_00;
}

//Function Number: 54
calcpathdist(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		var_01 = var_01 + distance(param_00[var_02],param_00[var_02 + 1]);
	}

	return var_01;
}

//Function Number: 55
is_near_any_targets(param_00)
{
	if(isdefined(level.active_eye_targets))
	{
		var_01 = scripts\common\utility::array_combine(level.players,level.active_eye_targets);
	}
	else
	{
		var_01 = level.players;
	}

	var_02 = 250000;
	foreach(var_04 in var_01)
	{
		if(isplayer(var_04))
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(var_04.ignoreme || isdefined(var_04.var_222) && var_04.var_222.ignoreme)
			{
				continue;
			}

			if(lib_0F74::func_1002C(var_04))
			{
				continue;
			}
		}

		if(distancesquared(param_00,var_04.origin) < var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 56
is_near_any_player(param_00)
{
	var_01 = 90000;
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

		if(distancesquared(param_00,var_03.origin) < var_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 57
findteleportposinfrontofenemy()
{
	var_00 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	var_01 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
	var_02 = var_01.min_teleport_dist_to_player * var_01.min_teleport_dist_to_player;
	var_03 = var_01.max_teleport_dist_to_player * var_01.max_teleport_dist_to_player;
	var_04 = var_00 getvelocity();
	var_05 = length2d(var_04);
	if(var_05 < 1)
	{
		var_06 = anglestoforward(var_00.angles);
		var_07 = var_01.min_teleport_dist_to_player;
	}
	else
	{
		var_06 = vectornormalize(var_06);
		var_06 = var_06 * 1.1;
		var_07 = var_06 * 1.75;
	}

	var_08 = var_00.origin + var_06 * var_01.max_teleport_dist_to_player;
	var_09 = 0;
	var_0A = getrandomnavpoints(var_08,var_01.max_teleport_dist_to_player,64,self);
	scripts\common\utility::array_randomize(var_0A);
	foreach(var_0C in var_0A)
	{
		if(distance(self.origin,var_0C) < var_01.min_travel_dist_for_teleport)
		{
			continue;
		}

		var_0D = var_0C - var_00.origin;
		var_0E = length2dsquared(var_0D);
		if(var_0E < var_02)
		{
			continue;
		}

		if(var_0E > var_03)
		{
			continue;
		}

		var_0F = vectornormalize(var_0D);
		var_10 = vectordot(var_06,var_0F);
		if(var_10 < 0.707)
		{
			continue;
		}

		var_11 = var_00 method_8428(var_00.origin,var_0C);
		if(var_11.size < 1)
		{
			continue;
		}

		var_12 = scripts\common\trace::func_48CC(1);
		if(!scripts\common\trace::func_DCF1(var_0C,var_00 geteye(),self,var_12))
		{
			var_09++;
			if(var_09 >= 10)
			{
				self.nextteleporttesttime = gettime() + 200;
				return undefined;
			}

			continue;
		}

		return var_0C;
	}

	return undefined;
}

//Function Number: 58
shouldtrymelee()
{
	return level.rat_king_toggles["melee_attack"];
}

//Function Number: 59
shouldtrystomp()
{
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		return 0;
	}

	return level.rat_king_toggles["staff_stomp"];
}

//Function Number: 60
shouldtrysummon()
{
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		return 0;
	}

	return level.rat_king_toggles["summon"];
}

//Function Number: 61
shouldtrystaffprojectile()
{
	if(!scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		return 0;
	}

	if(rk_isonplatform())
	{
		return 0;
	}

	return level.rat_king_toggles["staff_projectile"];
}

//Function Number: 62
shouldtryshieldattack()
{
	return level.rat_king_toggles["shield_attack"];
}

//Function Number: 63
shouldtryshieldattackatpos()
{
	if(level.rat_king_toggles["shield_attack_spot"])
	{
		if(scripts\cp\maps\cp_disco\rat_king_fight::canspawneyetarget())
		{
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 64
shouldtryblock()
{
	return level.rat_king_toggles["block"];
}

//Function Number: 65
shouldtryteleport()
{
	return level.rat_king_toggles["teleport"];
}

//Function Number: 66
tryforcedteleport()
{
	if(!scripts\common\utility::istrue(self.force_teleport))
	{
		return 0;
	}

	var_00 = getvalidteleportpoints();
	var_01 = scripts\common\utility::func_22A8(var_00);
	self.teleportpos = var_01[0];
	self.desiredaction = "teleport";
	return 1;
}

//Function Number: 67
shouldtrytraversalteleport()
{
	if(scripts\common\utility::func_6E34("rk_fight_started") && scripts\common\utility::flag("rk_fight_started"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 68
trytraversalteleport()
{
	if(isdefined(self.nexttraversalteleporttesttime) && gettime() < self.nexttraversalteleporttesttime)
	{
		return 0;
	}

	if(isdefined(self.var_233))
	{
		var_00 = self method_841E();
		var_01 = self method_84F9(var_00);
		if(isdefined(var_01))
		{
			var_02 = var_01["node"];
			var_03 = var_01["position"];
			var_04 = var_02.var_48;
			if(isdefined(var_04))
			{
				var_05 = self.var_238F;
				var_06 = level.var_2303[var_05];
				var_07 = var_06.var_10E2F[var_04];
				if(!isdefined(var_07))
				{
					var_04 = "traverse_external";
				}

				if(var_04 == "traverse_external")
				{
					self.teleportpos = var_03;
					self.desiredaction = "teleport";
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 69
shouldtryattackzombies()
{
	return level.rat_king_toggles["attack_zombies"];
}

//Function Number: 70
decideaction(param_00)
{
	if(tryforcedteleport())
	{
		return level.var_111AE;
	}

	if(shouldtrytraversalteleport() && trytraversalteleport())
	{
		return level.var_111AE;
	}

	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = gettime();
	if(var_02 - self.var_A980 < 500)
	{
		var_03 = distancesquared(var_01.origin,self.origin);
		foreach(var_05 in level.rat_king_attack_priorities)
		{
			switch(var_05)
			{
				case "attack_zombies":
					if(shouldtryattackzombies() && tryattackzombies())
					{
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "block":
					if(shouldtryblock() && tryblock())
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "melee_attack":
					if(shouldtrymelee() && trymeleeattacks(var_03))
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "staff_stomp":
					if(shouldtrystomp() && trymeleeattacks(var_03))
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "summon":
					if(shouldtrysummon() && trysummon(var_03))
					{
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "staff_projectile":
					if(shouldtrystaffprojectile() && trystaffprojectile(var_03))
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "shield_attack":
					if(shouldtryshieldattack() && tryshieldattack(var_03))
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "shield_attack_spot":
					if(shouldtryshieldattackatpos() && tryshieldattackatpos(var_03))
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				case "teleport":
					if(shouldtryteleport() && tryteleport(var_03))
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;

				default:
					if(shouldtryteleport() && tryteleport())
					{
						self.lastenemyengagetime = var_02;
						return level.var_111AE;
					}
					else
					{
						break;
					}
	
					break;
			}
		}
	}

	return level.var_6AD5;
}

//Function Number: 71
doaction_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].ratkingaction = self.desiredaction;
	var_01 = self.actions[self.desiredaction].fnbegin;
	self.desiredaction = undefined;
	if(isdefined(var_01))
	{
		[[ var_01 ]](param_00);
	}
}

//Function Number: 72
doaction_tick(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	if(var_01 != "debug_handler")
	{
		var_02 = scripts\mp\agents\ratking\ratking_agent::getenemy();
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
		doaction_end(param_00);
		doaction_begin(param_00);
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 73
doaction_end(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	var_02 = self.actions[var_01].fnend;
	if(isdefined(var_02))
	{
		[[ var_02 ]](param_00);
	}

	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 74
followenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
}

//Function Number: 75
followenemy_tick(param_00)
{
	var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = getclosestpointonnavmesh(var_01.origin,self);
	self method_8286(var_02);
	return level.var_111AE;
}

//Function Number: 76
followenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 77
rk_isonplatform()
{
	if(scripts\common\utility::istrue(self.isonplatform))
	{
		return 1;
	}

	return 0;
}

//Function Number: 78
rk_setonplatform(param_00)
{
	self.isonplatform = param_00;
}

//Function Number: 79
rk_shouldbeonplatform()
{
	if(scripts\common\utility::istrue(self.shouldbeonplatform))
	{
		return 1;
	}

	return 0;
}

//Function Number: 80
getrkstage()
{
	return level.rat_king_stage;
}

//Function Number: 81
bt_rk_isonplatform(param_00)
{
	if(scripts\common\utility::istrue(self.isonplatform))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 82
setplatformstate()
{
	if(scripts\common\utility::istrue(self.teleporttospot))
	{
		rk_setonplatform(1);
		self notify("teleport_to_platform");
		return;
	}

	rk_setonplatform(0);
}

//Function Number: 83
togglerkhasstaff(param_00)
{
	if(!isdefined(self.hasstaff) || self.hasstaff != param_00)
	{
		self.bstaffchanged = 1;
		self.hasstaff = param_00;
		self.nostaff = !param_00;
	}
}

//Function Number: 84
rkdropshield()
{
	self.var_1198.requestedshieldstate = "dropped";
}

//Function Number: 85
rkthrowshield()
{
	self.var_1198.requestedshieldstate = "thrown";
}

//Function Number: 86
rkretrieveshield()
{
	self.var_1198.requestedshieldstate = "equipped";
}

//Function Number: 87
retrieveshieldaftertime(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("fake_death");
	self notify("retrieveShieldAfterTime");
	self endon("retrieveShieldAfterTime");
	if(scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		self.remove_shield = 1;
		rkdropshield();
	}

	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(60);
	}

	rkretrieveshield();
	scripts\cp\maps\cp_disco\rat_king_fight::addblockcooldown(10000);
}

//Function Number: 88
throwandrecovershield(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("fake_death");
	self notify("retrieveShieldAfterTime");
	self endon("retrieveShieldAfterTime");
	if(scripts\mp\agents\ratking\ratking_agent::rkhasshield())
	{
		rkthrowshield();
	}

	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(60);
	}

	rkretrieveshield();
}

//Function Number: 89
rkisstaffstomp()
{
	var_00 = lib_0A1A::func_233A("ratking");
	if(var_00 == "staff_stomp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 90
rkisblocking()
{
	var_00 = lib_0A1A::func_233A("ratking");
	if(isdefined(var_00) && var_00 == "block_intro" || var_00 == "block_loop")
	{
		return 1;
	}

	return 0;
}

//Function Number: 91
rkissummoning()
{
	var_00 = lib_0A1A::func_233A("ratking");
	if(isdefined(var_00) && var_00 == "summon")
	{
		return 1;
	}

	return 0;
}

//Function Number: 92
retrievestaffaftertime(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("fake_death");
	self notify("retrieveStaffAfterTime");
	self endon("retrieveStaffAfterTime");
	if(scripts\mp\agents\ratking\ratking_agent::rkhasstaff())
	{
		self.remove_staff = 1;
		togglerkhasstaff(0);
		self setscriptablepartstate("staff","staff_dissolve");
	}

	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(60);
	}

	togglerkhasstaff(1);
	self setscriptablepartstate("staff","staff_activate");
	scripts\cp\maps\cp_disco\rat_king_fight::addstaffstompcooldown(10000);
	scripts\cp\maps\cp_disco\rat_king_fight::addinnerstaffstompcooldown(10000);
	scripts\cp\maps\cp_disco\rat_king_fight::addstaffprojcooldown(10000);
}

//Function Number: 93
shouldignoreenemy(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(param_00.ignoreme || isdefined(param_00.var_222) && param_00.var_222.ignoreme)
	{
		return 1;
	}

	if(scripts\common\utility::istrue(param_00.isfasttravelling))
	{
		return 1;
	}

	if(lib_0F74::func_1002C(param_00))
	{
		return 1;
	}

	return 0;
}