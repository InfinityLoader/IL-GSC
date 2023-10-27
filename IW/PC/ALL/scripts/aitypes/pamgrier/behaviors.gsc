/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\pamgrier\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 1793 ms
 * Timestamp: 10/26/2023 11:58:51 PM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	setupbtstates();
	self.desiredaction = undefined;
	self.var_A980 = 0;
	self.lastenemyengagetime = 0;
	self.myenemy = undefined;
	self.myenemystarttime = 0;
	self.last_health = self.health;
	self.needtochilltime = undefined;
	self.numteleportattacks = 0;
	var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	self.nextattacktime = gettime() + var_01.max_time_between_attacks;
	self.nextrevivetime = gettime() + var_01.min_time_between_revivals;
	return level.var_111AE;
}

//Function Number: 2
setupaction(param_00,param_01,param_02,param_03)
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
setupbtstates()
{
	setupaction("chillin",::chillin_begin,::chillin_tick,::chillin_end);
	setupaction("revive_player",::reviveplayer_begin,::reviveplayer_tick,::reviveplayer_end);
	setupaction("teleport_attack",::teleportattack_begin,::teleportattack_tick,::teleportattack_end);
	setupaction("melee_attack",::melee_begin,::melee_tick,::melee_end);
	setupaction("return_home",::returnhome_begin,::returnhome_tick,::returnhome_end);
	setupaction("wait",::wait_begin,::wait_tick,::wait_end);
}

//Function Number: 4
func_12E8A()
{
	return scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
}

//Function Number: 5
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

//Function Number: 6
getcurrentdesiredaction(param_00)
{
	return self.var_3135.var_9928[param_00].desiredaction;
}

//Function Number: 7
findnearbypamtarget()
{
	var_00 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	var_01 = [];
	foreach(var_03 in var_00.target_agent_types)
	{
		var_04 = scripts\mp\_mp_agent::func_7D95(var_03);
		var_01 = scripts\common\utility::array_combine(var_01,var_04);
	}

	if(!isdefined(var_01) || var_01.size == 0)
	{
		return undefined;
	}

	var_06 = undefined;
	var_07 = 0;
	foreach(var_09 in var_01)
	{
		var_0A = distancesquared(var_09.origin,self.origin);
		if(var_0A > var_00.melee_attack_range_sq)
		{
			continue;
		}

		if(!isalive(var_09))
		{
			continue;
		}

		if(!isdefined(var_06))
		{
			var_06 = var_09;
			var_07 = var_0A;
			continue;
		}

		if(var_0A < var_07)
		{
			var_06 = var_09;
			var_07 = var_0A;
		}
	}

	if(!isdefined(var_06))
	{
		return undefined;
	}

	return var_06;
}

//Function Number: 8
teleporttargetcompare(param_00,param_01)
{
	var_02 = distance2dsquared(self.origin,param_00.origin);
	var_03 = distance2dsquared(self.origin,param_01.origin);
	return var_02 < var_03;
}

//Function Number: 9
shoultryteleportattack()
{
	return level.pam_grier_toggles["teleport_attack"];
}

//Function Number: 10
findpamteleporttarget(param_00)
{
	var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	var_02 = [];
	foreach(var_04 in var_01.target_agent_types)
	{
		var_05 = scripts\mp\_mp_agent::func_7D95(var_04);
		var_02 = scripts\common\utility::array_combine(var_02,var_05);
	}

	if(!isdefined(var_02) || var_02.size == 0)
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00))
	{
		var_02 = scripts\common\utility::array_randomize(var_02);
	}
	else
	{
		var_02 = scripts\common\utility::func_22C3(var_02,::teleporttargetcompare);
	}

	foreach(var_08 in var_02)
	{
		if(!isalive(var_08))
		{
			continue;
		}

		if(scripts\common\utility::istrue(param_00) && isdefined(var_08.var_233))
		{
			if(scripts\common\utility::istrue(var_08.var_2BE7))
			{
				continue;
			}

			var_09 = var_08 method_841E();
			if(var_09 < var_01.min_target_path_dist_to_goal)
			{
				continue;
			}

			var_0A = var_08 method_845D(var_01.teleport_attack_dist_to_target);
		}
		else
		{
			var_0B = vectornormalize(var_09.origin - self.origin);
			var_0A = var_08.origin - var_0B * var_01.teleport_attack_dist_to_target;
		}

		var_08.bdisableteleport = 1;
		self.pamenemy = var_08;
		self.teleportpos = var_0A;
		self.teleportangles = vectortoangles(var_08.origin - var_0A);
		self.teleportfromchillin = scripts\common\utility::istrue(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 11
isvalidteleportposition(param_00)
{
	if(!isdefined(level.pamvalidteleportpositioncenter))
	{
		return 1;
	}

	var_01 = distance2dsquared(level.pamvalidteleportpositioncenter,param_00);
	if(var_01 > level.pamvalidteleportradius * level.pamvalidteleportradius)
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
shouldtryplayerrevive()
{
	return level.pam_grier_toggles["revive_player"];
}

//Function Number: 13
findplayertorevive()
{
	var_00 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	var_01 = sortbydistance(level.players,self.origin);
	foreach(var_03 in var_01)
	{
		if(!isvalidteleportposition(var_03.origin))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_03.inlaststand) && !scripts\common\utility::istrue(var_03.var_9B79) && !scripts\common\utility::istrue(var_03.in_afterlife_arcade))
		{
			var_04 = anglestoforward(var_03.angles);
			var_05 = anglestoright(var_03.angles);
			var_06 = var_03.origin + var_04 * var_00.revive_forward_offset + var_05 * var_00.revive_right_offset;
			var_07 = var_03.origin - var_06;
			var_08 = vectortoangles(var_07);
			var_08 = (0,var_08[1],0);
			var_09 = getclosestpointonnavmesh(var_06,self);
			if(abs(var_09[2] - var_06[2]) > var_00.max_revive_snap_z_dist)
			{
				continue;
			}

			var_0A = distance2dsquared(var_06,var_09);
			if(var_0A > var_00.max_revive_snapp_2d_dist_sq)
			{
				continue;
			}

			self.reviveplayer = var_03;
			self.revivepos = var_09;
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
wait_begin(param_00)
{
	var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	var_01.teleporttime = gettime() + var_02.min_wait_time_before_teleport;
	var_01.waitendtime = gettime() + randomintrange(var_02.min_wait_time,var_02.max_wait_time);
}

//Function Number: 15
wait_tick(param_00)
{
	var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = gettime();
	self method_841F();
	var_03 = 0;
	if(!isdefined(self.forcenextrevivetime) || var_02 < self.forcenextrevivetime)
	{
		self.pamenemy = findnearbypamtarget();
		if(isdefined(self.pamenemy))
		{
			if(shouldtrymeleeattack() && trymeleeattacks())
			{
				return level.var_6AD5;
			}

			self.pamenemy = undefined;
		}
	}
	else
	{
		self.pamenemy = undefined;
		var_03 = 1;
	}

	if(scripts\common\utility::istrue(var_03) || var_02 > self.nextrevivetime)
	{
		if(shouldtryplayerrevive() && findplayertorevive())
		{
			self.desiredaction = "revive_player";
			return level.var_6AD5;
		}
		else
		{
			self.nextrevivetime = var_02 + 1000;
			self.forcenextrevivetime = undefined;
		}
	}

	if(var_02 < var_01.teleporttime)
	{
		return level.var_E87A;
	}

	if(isdefined(self.needtochilltime) && var_02 > self.needtochilltime)
	{
		self.desiredaction = "return_home";
		return level.var_6AD5;
	}

	var_04 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	if(self.numteleportattacks >= var_04.max_teleports_per_chill)
	{
		self.desiredaction = "return_home";
		return level.var_6AD5;
	}

	if(shoultryteleportattack() && findpamteleporttarget())
	{
		self.desiredaction = "teleport_attack";
		self.numteleportattacks = self.numteleportattacks + 1;
		var_05 = vectortoangles(self.teleportpos - self.origin);
		self.desiredyaw = var_05[1];
		return level.var_6AD5;
	}

	if(var_03 > var_02.waitendtime)
	{
		self.desiredaction = "return_home";
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 16
wait_end(param_00)
{
	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
	scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

//Function Number: 17
chillin_begin(param_00)
{
	self.bchillin = 1;
	scripts\mp\agents\pamgrier\pamgrier_agent::clearpassive();
	var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	var_02 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
	var_02.endchilltime = gettime() + randomintrange(var_01.min_chillin_time,var_01.max_chillin_time);
	self.numteleportattacks = 0;
}

//Function Number: 18
chillin_tick(param_00)
{
	var_01 = scripts\aitypes\ratking\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = gettime();
	if(var_02 < var_01.endchilltime)
	{
		return level.var_E87A;
	}

	if(var_02 > self.nextrevivetime)
	{
		if(findplayertorevive())
		{
			self.desiredaction = "revive_player";
			return level.var_111AE;
		}
		else
		{
			self.nextrevivetime = var_02 + 1000;
		}
	}

	if(var_02 > self.nextattacktime)
	{
		if(shoultryteleportattack() && findpamteleporttarget(1))
		{
			self.desiredaction = "teleport_attack";
			return level.var_111AE;
		}
		else
		{
			self.nextattacktime = var_02 + 500;
		}
	}

	return level.var_E87A;
}

//Function Number: 19
chillin_end(param_00)
{
	self.bchillin = 0;
	self.needtochilltime = gettime() + scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().max_non_chillin_time;
}

//Function Number: 20
teleportattack_begin(param_00)
{
	requestteleport(self.teleportpos,self.teleportangles,"teleport_attack");
	self method_841F();
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"teleport","teleport_out",::teleportattack_teleportdone,undefined,undefined,8000);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"teleport");
}

//Function Number: 21
teleportattack_teleportdone(param_00,param_01)
{
	scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

//Function Number: 22
teleportattack_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.desiredaction = "wait";
	return level.var_6AD5;
	return level.var_6AD5;
}

//Function Number: 23
teleportattack_end(param_00)
{
	var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	self.nextattacktime = gettime() + randomintrange(var_01.min_time_between_attacks,var_01.max_time_between_attacks);
	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
	scripts\asm\pamgrier\pamgrier_asm::clearaction();
	self.desiredyaw = undefined;
}

//Function Number: 24
reviveplayer_begin(param_00)
{
	var_01 = distancesquared(self.reviveplayer.origin,self.origin);
	var_02 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	if(var_01 > var_02.max_dist_to_revive_player_sq)
	{
		var_03 = self.reviveplayer.origin - self.revivepos;
		var_04 = vectortoangles(var_03);
		var_04 = (0,var_04[1],0);
		requestteleport(self.revivepos,var_04,"revive_player");
		scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"teleport","teleport_out",::reviveplayer_teleportdone,undefined,undefined,8000);
		scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"teleport");
		return;
	}

	scripts\asm\pamgrier\pamgrier_asm::setaction("revive_player");
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"revive_player","revive_player_outro",::reviveplayer_revivedone,undefined,undefined,8000);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"revive_player");
}

//Function Number: 25
reviveplayer_tick(param_00)
{
	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 26
reviveplayer_teleportdone(param_00,param_01)
{
	if(isdefined(self.forcenextrevivetime) && gettime() > self.forcenextrevivetime)
	{
		self.pamenemy = undefined;
		self.forcenextrevivetime = undefined;
	}
	else
	{
		self.pamenemy = findnearbypamtarget();
		if(isdefined(self.pamenemy))
		{
			if(trymeleeattacks())
			{
				return;
			}
		}
	}

	scripts\asm\pamgrier\pamgrier_asm::setaction("revive_player");
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"revive_player","revive_player_outro",::reviveplayer_revivedone,undefined,undefined,8000);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"revive_player");
}

//Function Number: 27
reviveplayer_revivedone(param_00,param_01)
{
}

//Function Number: 28
reviveplayer_end(param_00)
{
	var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
	self.var_55B0 = 0;
	self.forcenextrevivetime = undefined;
	if(isdefined(self.reviveplayer))
	{
		if(!scripts\common\utility::istrue(self.reviveplayer.inlaststand))
		{
			if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
			{
				self.nextrevivetime = gettime() + var_01.min_time_between_revivals_solo;
			}
			else
			{
				self.nextrevivetime = gettime() + var_01.min_time_between_revivals;
			}
		}
		else
		{
			self.forcenextrevivetime = gettime() + var_01.max_time_to_attack_targets_when_player_needs_revive_ms;
		}
	}
	else
	{
		self.nextrevivetime = gettime() + var_01.min_time_between_revivals;
	}

	self.reviveplayer = undefined;
	self.reviveanimindex = undefined;
	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
	scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

//Function Number: 29
melee_begin(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	scripts\asm\pamgrier\pamgrier_asm::setaction(var_01);
	var_02 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
	if(var_01 == "melee_attack")
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
	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,var_01,var_01);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,var_01);
}

//Function Number: 30
melee_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 31
melee_end(param_00)
{
	self.var_4B26 = undefined;
	self.bmovingmelee = undefined;
	scripts\asm\pamgrier\pamgrier_asm::clearaction();
	scripts\aitypes\ratking\bt_state_api::btstate_endstates(param_00);
}

//Function Number: 32
requestteleport(param_00,param_01,param_02)
{
	self.teleportpos = param_00;
	self.teleportangles = param_01;
	self.teleporttype = param_02;
	scripts\asm\pamgrier\pamgrier_asm::setaction("teleport");
}

//Function Number: 33
returnhome_begin(param_00)
{
	if(!isdefined(level.pam_grier_chillin_origins) || level.pam_grier_chillin_origins.size == 0)
	{
		requestteleport(self.chillinpos,self.chillinangles,"return_home");
	}
	else
	{
		var_01 = randomint(level.pam_grier_chillin_origins.size);
		var_02 = vectortoangles(level.pam_grier_chillin_origins[var_01] - self.origin);
		self.desiredyaw = var_02[1];
		requestteleport(level.pam_grier_chillin_origins[var_01],level.pam_grier_chillin_angles[var_01],"return_home");
	}

	scripts\aitypes\ratking\bt_state_api::asm_wait_state_setup(param_00,"return_home","teleport_out",undefined,undefined,undefined,8000);
	scripts\aitypes\ratking\bt_state_api::btstate_transitionstate(param_00,"return_home");
}

//Function Number: 34
returnhome_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\ratking\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	self.desiredaction = "chillin";
	return level.var_6AD5;
}

//Function Number: 35
returnhome_end(param_00)
{
	self.desiredyaw = undefined;
	scripts\asm\pamgrier\pamgrier_asm::clearaction();
}

//Function Number: 36
shouldtrymeleeattack()
{
	return level.pam_grier_toggles["melee_attack"];
}

//Function Number: 37
trymeleeattacks(param_00)
{
	var_01 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
	if(!isdefined(param_00))
	{
		param_00 = distancesquared(self.origin,var_01.origin);
	}

	if(!ispointonnavmesh(var_01.origin))
	{
		if(param_00 > self.var_B631 * self.var_B631)
		{
			return 0;
		}
	}
	else if(param_00 > self.var_B62F)
	{
		return 0;
	}

	self.desiredaction = "melee_attack";
	return 1;
}

//Function Number: 38
decideaction(param_00)
{
	if(!isdefined(self.needtochilltime))
	{
		self.desiredaction = "return_home";
	}
	else
	{
		self.desiredaction = "wait";
	}

	return level.var_111AE;
}

//Function Number: 39
doaction_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].desiredaction = self.desiredaction;
	var_01 = self.actions[self.desiredaction].fnbegin;
	self.desiredaction = undefined;
	if(isdefined(var_01))
	{
		[[ var_01 ]](param_00);
	}
}

//Function Number: 40
doaction_tick(param_00)
{
	var_01 = getcurrentdesiredaction(param_00);
	var_02 = self.actions[var_01].fntick;
	if(isdefined(var_02))
	{
		var_03 = [[ var_02 ]](param_00);
		if(!isdefined(self.desiredaction))
		{
			return var_03;
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

//Function Number: 41
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

//Function Number: 42
followenemy_begin(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
}

//Function Number: 43
followenemy_tick(param_00)
{
	return level.var_111AE;
}

//Function Number: 44
followenemy_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}