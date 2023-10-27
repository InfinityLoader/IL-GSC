/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\elvira\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 2604 ms
 * Timestamp: 10/26/2023 11:58:47 PM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	setupbtstates();
	var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	self.desiredaction = undefined;
	self.var_A980 = 0;
	self.lastenemyengagetime = 0;
	self.var_A981 = 0;
	self.myenemy = undefined;
	self.myenemystarttime = 0;
	self.last_health = self.health;
	self.return_home_time = gettime() + var_01.var_AC71;
	return level.var_111AE;
}

//Function Number: 2
setupbtstates()
{
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("combat",::combat_begin,::combat_tick,::combat_end);
	scripts\aitypes\dlc3\bt_state_api::btstate_setupstate("acquire",::acquire_begin,::acquire_tick,::acquire_end);
	scripts\aitypes\dlc3\bt_state_api::btstate_setupstate("backpedal",::backpedal_begin,::backpedal_tick,::backpedal_end);
	scripts\aitypes\dlc3\bt_state_api::btstate_setupstate("reload",::reload_begin,::reload_tick,::reload_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("idle",::idle_begin,::idle_tick,::idle_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("melee_attack",::melee_begin,::melee_tick,::melee_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("revive_player",::reviveplayer_begin,::reviveplayer_tick,::reviveplayer_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("rejoin_player",::rejoinplayer_begin,::rejoinplayer_tick,::rejoinplayer_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("reveal_anomaly",::revealanomaly_begin,::revealanomaly_tick,::revealanomaly_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("return_home",::returnhome_begin,::returnhome_tick,::returnhome_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("cast_spell",::castspell_begin,::castspell_tick,::castspell_end);
}

//Function Number: 3
aimattarget()
{
	self.var_1C4 = undefined;
	if(!isdefined(self.var_719B) || !isdefined(self.var_BFB1) || gettime() > self.var_BFB1)
	{
		self.var_719B = scripts\mp\agents\elvira\elvira_agent::func_CB30();
		self.var_BFB1 = gettime() + randomintrange(1500,2500);
	}

	if(isdefined(self.var_719B))
	{
		var_00 = self [[ self.var_719B ]]();
		if(!self method_8060(var_00))
		{
			var_00 = scripts\mp\agents\elvira\elvira_agent::func_7E66();
		}
	}
	else
	{
		var_00 = scripts\mp\agents\elvira\elvira_agent::func_7E66();
	}

	self.var_1C2 = var_00;
}

//Function Number: 4
shootattarget()
{
	var_00 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = self.var_3135.var_FECD;
	var_01.var_C274 = "normal";
	self.var_1C4 = undefined;
	var_01.var_D699 = self.var_1C2;
	var_01.var_65D3 = undefined;
	lib_0A1B::func_2983(var_01,undefined);
	if(lib_0A06::func_9D2E())
	{
		if(!scripts\common\utility::istrue(self.var_3135.var_B117))
		{
			lib_0A06::func_E259();
			lib_0A06::func_3EF9(var_01);
			lib_0A06::func_3EE3(var_01);
		}

		var_01.var_C274 = "normal";
		self.var_3135.var_B117 = 1;
	}
	else
	{
		self.var_3135.var_B117 = 0;
	}

	if(!isdefined(var_01.var_D699) && !isdefined(var_01.var_65D3))
	{
		return 0;
	}

	lib_0A1B::func_2962(self.var_3135.var_B117);
	return self.var_3135.var_B117;
}

//Function Number: 5
stopshootingattarget()
{
	self.var_3135.var_B117 = 0;
	lib_0A1B::func_2962(self.var_3135.var_B117);
}

//Function Number: 6
func_12E8A()
{
	return scripts\mp\agents\elvira\elvira_agent::getenemy();
}

//Function Number: 7
checkforearlyteleport(param_00)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	var_02 = self method_841E();
	if(var_02 > var_01.max_teleport_lookahead_dist)
	{
		var_02 = var_01.max_teleport_lookahead_dist;
	}

	if(lib_0A1A::func_2354("traverse_external"))
	{
		return 0;
	}

	var_03 = self method_84F9(var_02);
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_04 = var_03["node"];
	var_05 = var_03["position"];
	var_06 = var_04.var_48;
	if(!isdefined(var_06))
	{
		return 0;
	}

	var_07 = self.var_238F;
	var_08 = level.var_2303[var_07];
	var_09 = var_08.var_10E2F[var_06];
	if(!isdefined(var_09))
	{
		var_06 = "traverse_external";
	}

	if(var_06 == "traverse_external")
	{
		self.earlytraversalteleportpos = var_05;
		lib_0A1A::func_237C("traverse_external");
		return 1;
	}

	return 0;
}

//Function Number: 8
updateeveryframe(param_00)
{
	var_01 = func_12E8A();
	if(isdefined(var_01))
	{
		self.var_A981 = gettime();
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

//Function Number: 9
func_4F62(param_00,param_01)
{
	var_02 = gettime();
	var_03 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	if(self.last_enemy_sight_time < 0 || var_02 - self.last_enemy_sight_time < var_03.maxtimetostrafewithoutlos)
	{
		lib_0C33::func_295C();
		return;
	}

	if(param_01 < var_03.strafeifwithindist)
	{
		lib_0C33::func_295C();
		return;
	}

	if(!param_00)
	{
		lib_0C33::func_295A();
		return;
	}

	lib_0C33::func_295C();
}

//Function Number: 10
idle_begin(param_00)
{
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.idle_start_time = gettime();
}

//Function Number: 11
idle_tick(param_00)
{
	self method_841F();
	if(trycastspell(param_00))
	{
		return level.var_111AE;
	}

	if(tryrevealanomaly(param_00))
	{
		return level.var_111AE;
	}

	if(tryreturnhome(param_00))
	{
		return level.var_111AE;
	}

	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	if(tryreviveplayer(param_00))
	{
		return level.var_111AE;
	}

	if(tryreturntoclosestplayer(param_00))
	{
		return level.var_111AE;
	}

	var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(!isdefined(var_01))
	{
		var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
		if(gettime() > var_02.idle_start_time + 250)
		{
			if(self.var_3250 < weaponclipsize(self.var_394) * 0.75)
			{
				doreloadstate(param_00);
			}
		}

		return level.var_E87A;
	}

	if(shouldtrymeleeattack() && trymeleeattacks(var_01))
	{
		return level.var_111AE;
	}

	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(var_01,"combat");
	return level.var_E87A;
}

//Function Number: 12
idle_end(param_00)
{
}

//Function Number: 13
setgoaltoreviveplayer(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_03 = anglestoright(param_00.angles);
	var_04 = param_00.origin + var_02 * param_01.revive_forward_offset + var_03 * param_01.revive_right_offset;
	var_05 = param_00.origin - var_04;
	var_06 = vectortoangles(var_05);
	var_06 = (0,var_06[1],0);
	var_07 = getclosestpointonnavmesh(var_04,self);
	self method_8286(var_07);
}

//Function Number: 14
reviveplayer_begin(param_00,param_01)
{
	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.brevivedone = undefined;
	self.var_55B0 = 0;
	self.ignoreme = 1;
	self.var_3135.var_FECD = spawnstruct();
	self.var_3135.var_FECD.var_1158F = param_00;
	self.var_3135.var_FECD.var_10DFF = gettime();
}

//Function Number: 15
reviveplayer_tick(param_00)
{
	var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(!isdefined(var_01) && gettime() - self.var_A981 > 500)
	{
		checkforearlyteleport();
	}

	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	if(!isdefined(self.reviveplayer) || !scripts\common\utility::istrue(self.reviveplayer.inlaststand))
	{
		return level.var_111AE;
	}

	var_02 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	setgoaltoreviveplayer(self.reviveplayer,var_02);
	var_03 = distance2dsquared(self.reviveplayer.origin,self.origin);
	if(var_03 < var_02.max_dist_to_revive_player_sq)
	{
		stopshootingattarget();
		scripts\asm\elvira\elvira_asm::setaction("revive_player");
		scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"revive_player","revive_player_intro",::reviveplayer_revivedone,undefined,undefined,8000);
		scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"revive_player");
	}
	else
	{
		var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
		if(isdefined(var_01))
		{
			var_04 = 1;
			var_05 = self method_805F(var_01);
			if(var_05)
			{
				var_04 = self method_8060(scripts\mp\agents\elvira\elvira_agent::func_7E66());
			}

			if(var_04)
			{
				lib_0A1B::func_297E(1);
				lib_0A1B::func_2968("combat");
				self.var_3250 = weaponclipsize(self.var_394);
				aimattarget();
				shootattarget();
			}
			else
			{
				lib_0A1B::func_297E(0);
				lib_0A1B::func_2968("run");
				stopshootingattarget();
			}
		}
		else
		{
			lib_0A1B::func_297E(0);
			lib_0A1B::func_2968("run");
			stopshootingattarget();
		}
	}

	return level.var_E87A;
}

//Function Number: 16
reviveplayer_end(param_00,param_01)
{
	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.brevivedone = undefined;
	stopshootingattarget();
	var_03 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	self.var_55B0 = 0;
	self.forcenextrevivetime = undefined;
	if(isdefined(self.reviveplayer))
	{
		if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
		{
			self.nextrevivetime = gettime() + var_03.min_time_between_revivals_solo;
		}
		else
		{
			self.nextrevivetime = gettime() + var_03.min_time_between_revivals;
		}
	}
	else
	{
		self.nextrevivetime = gettime() + var_03.min_time_between_revivals;
	}

	self.reviveplayer = undefined;
	scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
	scripts\asm\elvira\elvira_asm::clearaction();
	self.var_3135.var_FECD = undefined;
}

//Function Number: 17
reviveplayer_revivedone(param_00,param_01)
{
}

//Function Number: 18
findplayertorevive()
{
	var_00 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	var_01 = sortbydistance(level.players,self.origin);
	foreach(var_03 in var_01)
	{
		var_04 = distancesquared(self.origin,var_03.origin);
		if(var_04 > var_00.max_revive_search_dist_sq)
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_03.inlaststand) && !scripts\common\utility::istrue(var_03.var_9B79) && !scripts\common\utility::istrue(var_03.in_afterlife_arcade))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 19
reviveplayer(param_00,param_01)
{
	self.reviveplayer = param_01;
	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"revive_player");
}

//Function Number: 20
tryreviveplayer(param_00)
{
	if(!scripts\common\utility::istrue(1))
	{
		return 0;
	}

	if(isdefined(self.nextrevivetime))
	{
		if(gettime() < self.nextrevivetime)
		{
			return 0;
		}
	}

	var_01 = findplayertorevive();
	if(!isdefined(var_01))
	{
		return 0;
	}

	reviveplayer(param_00,var_01);
	return 1;
}

//Function Number: 21
melee_begin(param_00)
{
	self.var_4B26 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	scripts\asm\elvira\elvira_asm::setaction("melee");
	lib_0A1B::func_2965(self.var_4B26);
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"melee","melee_attack");
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"melee");
}

//Function Number: 22
melee_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 23
melee_end(param_00)
{
	self.var_4B26 = undefined;
	self.bmovingmelee = undefined;
	scripts\asm\elvira\elvira_asm::clearaction();
	scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
	lib_0A1B::func_2914();
}

//Function Number: 24
rejoinplayer_begin(param_00)
{
	self.var_3135.var_FECD = spawnstruct();
	self.var_3135.var_FECD.var_1158F = param_00;
	self.var_3135.var_FECD.var_10DFF = gettime();
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.nextclosestplayerchecktime = gettime() + 1000;
}

//Function Number: 25
rejoinplayer_tick(param_00)
{
	var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(!isdefined(var_01) && gettime() - self.var_A981 > 500)
	{
		checkforearlyteleport();
	}

	if(!isdefined(self.rejoinplayer))
	{
		return level.var_6AD5;
	}

	var_02 = gettime();
	var_03 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(var_02 > var_03.nextclosestplayerchecktime)
	{
		var_03.nextclosestplayerchecktime = var_02 + 1000;
		var_04 = getclosestplayer();
		if(isdefined(var_04))
		{
			if(var_04 != self.rejoinplayer)
			{
				self.rejoinplayer = var_04;
			}
		}
	}

	var_05 = distancesquared(self.rejoinplayer.origin,self.origin);
	var_06 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	var_07 = var_06.return_to_closest_player_dist_in_combat_sq;
	var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(isdefined(var_01))
	{
		var_08 = 1;
		var_09 = self method_805F(var_01);
		if(var_09)
		{
			var_08 = self method_8060(scripts\mp\agents\elvira\elvira_agent::func_7E66());
		}

		if(var_08)
		{
			lib_0A1B::func_297E(1);
			lib_0A1B::func_2968("combat");
			self.var_3250 = weaponclipsize(self.var_394);
			aimattarget();
			shootattarget();
		}
		else
		{
			lib_0A1B::func_297E(0);
			lib_0A1B::func_2968("run");
			stopshootingattarget();
		}
	}
	else
	{
		var_07 = var_06.return_to_closest_player_dist_sq;
		stopshootingattarget();
		lib_0A1B::func_297E(0);
		lib_0A1B::func_2968("run");
	}

	if(var_05 < var_07)
	{
		self method_841F();
		return level.var_111AE;
	}

	var_0A = getclosestpointonnavmesh(self.rejoinplayer.origin);
	self method_8286(var_0A);
	return level.var_E87A;
}

//Function Number: 26
rejoinplayer_end(param_00)
{
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.nextclosestplayerchecktime = undefined;
	self.rejoinplayer = undefined;
	stopshootingattarget();
	self.var_3135.var_FECD = undefined;
}

//Function Number: 27
returntoplayer(param_00,param_01)
{
	self.rejoinplayer = param_01;
	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"rejoin_player");
}

//Function Number: 28
getclosestplayer()
{
	var_00 = sortbydistance(level.players,self.origin);
	if(var_00.size == 0)
	{
		return undefined;
	}

	return var_00[0];
}

//Function Number: 29
tryreturntoclosestplayer(param_00)
{
	var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	if(!isdefined(self.nextplayerleashchecktime))
	{
		self.nextplayerleashchecktime = gettime() + var_01.check_for_closest_player_interval_ms;
	}

	if(gettime() < self.nextplayerleashchecktime)
	{
		return 0;
	}

	var_02 = getclosestplayer();
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = var_01.max_dist_from_closest_player_sq;
	if(isdefined(scripts\mp\agents\elvira\elvira_agent::getenemy()))
	{
		var_03 = var_01.max_dist_from_closest_player_in_combat_sq;
	}

	if(distancesquared(self.origin,var_02.origin) < var_03)
	{
		return 0;
	}

	returntoplayer(param_00,var_02);
	return 1;
}

//Function Number: 30
reload_begin(param_00,param_01)
{
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_begin(param_00,param_01);
	stopshootingattarget();
	scripts\asm\elvira\elvira_asm::setaction("reload");
	lib_0A1B::func_2983(undefined,undefined);
	self method_841F();
}

//Function Number: 31
reload_tick(param_00)
{
	return scripts\aitypes\dlc3\bt_state_api::asm_wait_state_tick(param_00);
}

//Function Number: 32
reload_end(param_00,param_01)
{
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_end(param_00,param_01);
	lib_0A1B::func_2969(0);
	scripts\asm\elvira\elvira_asm::clearaction();
}

//Function Number: 33
doreloadstate(param_00,param_01)
{
	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.endevent = "ASM_Finished";
	var_02.asmstate = "exposed_reload";
	var_02.fncallback = param_01;
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"reload");
}

//Function Number: 34
acquire_begin(param_00,param_01)
{
	lib_0C33::func_295A();
	stopshootingattarget();
}

//Function Number: 35
acquire_tick(param_00)
{
	var_01 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = 1;
	var_03 = self method_805F(var_01);
	var_04 = distance2d(self.origin,var_01.origin);
	if(var_03)
	{
		if(trymeleeattacks(param_00,var_04 * var_04))
		{
			return 0;
		}

		var_02 = self method_8060(scripts\mp\agents\elvira\elvira_agent::func_7E66());
	}
	else
	{
		var_02 = 0;
	}

	var_05 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_06 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	if(var_02)
	{
		if(isdefined(var_05.targetacquiredtime))
		{
			if(gettime() - var_05.targetacquiredtime > 500 || var_04 < var_06.desiredenemydistmin + 50)
			{
				self method_841F();
				return 0;
			}
			else
			{
				aimattarget();
				shootattarget();
			}
		}
		else
		{
			var_05.targetacquiredtime = gettime();
		}
	}
	else
	{
		stopshootingattarget();
		var_05.targetacquiredtime = undefined;
	}

	var_07 = getclosestpointonnavmesh(var_01.origin);
	self method_8286(var_07);
	return 1;
}

//Function Number: 36
acquire_end(param_00,param_01)
{
	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.targetacquiredtime = undefined;
}

//Function Number: 37
backpedal_begin(param_00,param_01)
{
	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.nextcalculatetime = gettime() + 50;
}

//Function Number: 38
backpedal_tick(param_00)
{
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(gettime() > var_01.nextcalculatetime)
	{
		var_02 = self method_841E();
		if(var_02 <= 4)
		{
			return 0;
		}
	}

	var_03 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	var_04 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	if(isdefined(var_03))
	{
		if(distance(self.origin,self.var_10C.origin) < var_04.backupdist * 1.2)
		{
			var_05 = getbackpedalspot();
			if(isdefined(var_05))
			{
				var_01.backpedalspot = var_05;
				var_01.nextcalculatetime = gettime() + 50;
			}
		}
	}

	aimattarget();
	shootattarget();
	if(!lib_0A06::func_8BC8())
	{
		doreloadstate(param_00);
		return 1;
	}

	self method_8286(var_01.backpedalspot);
	lib_0C33::func_295C();
	return 1;
}

//Function Number: 39
backpedal_end(param_00,param_01)
{
	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.backpedalspot = undefined;
	var_02.nextcalculatetime = undefined;
	self method_841F();
}

//Function Number: 40
getbackpedalspot()
{
	if(!isdefined(self.var_10C))
	{
		return undefined;
	}

	var_00 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	var_01 = vectornormalize(self.origin - self.var_10C.origin);
	var_02 = var_00.backupdist;
	var_03 = self.origin + var_01 * var_02;
	var_03 = getclosestpointonnavmesh(var_03,self);
	var_04 = var_03 - self.origin;
	var_04 = (var_04[0],var_04[1],0);
	var_05 = vectornormalize(var_04);
	var_06 = vectordot(var_05,var_01);
	if(var_06 > 0)
	{
		return var_03;
	}

	return undefined;
}

//Function Number: 41
dobackpedal(param_00)
{
	var_01 = getbackpedalspot();
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02.backpedalspot = var_01;
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"backpedal");
	return 1;
}

//Function Number: 42
combat_begin(param_00)
{
	lib_0A1B::func_297E(1);
	lib_0A1B::func_2968("combat");
	self.var_3135.var_FECD = spawnstruct();
	self.var_3135.var_FECD.var_1158F = param_00;
	self.var_3135.var_FECD.var_10DFF = gettime();
	self.var_3135.var_B117 = 0;
}

//Function Number: 43
combat_tick(param_00)
{
	self endon("newaction");
	if(tryreviveplayer(param_00))
	{
		return level.var_6AD5;
	}

	if(trycastspell(param_00))
	{
		return level.var_6AD5;
	}

	if(tryreturntoclosestplayer(param_00))
	{
		return level.var_6AD5;
	}

	var_01 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	var_02 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	if(!isdefined(var_02))
	{
		return level.var_111AE;
	}

	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	var_03 = 1;
	var_04 = self method_805F(self.var_10C);
	var_05 = distance2d(self.origin,self.var_10C.origin);
	if(var_04)
	{
		var_03 = self method_8060(scripts\mp\agents\elvira\elvira_agent::func_7E66());
	}
	else
	{
		var_03 = 0;
	}

	if(!var_03)
	{
		scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"acquire");
		return level.var_E87A;
	}

	if(trymeleeattacks(param_00,var_05 * var_05))
	{
		return level.var_6AD5;
	}

	if(!lib_0A06::func_8BC8())
	{
		doreloadstate(param_00);
		return level.var_E87A;
	}

	self.last_enemy_sight_time = gettime();
	self.var_A8B7 = self.var_10C;
	if(var_05 > var_01.desiredenemydistmax)
	{
		if(self.var_3250 < weaponclipsize(self.var_394) * 0.4)
		{
			doreloadstate(param_00);
			return level.var_E87A;
		}

		func_4F62(1,var_05);
		self method_8286(self.var_10C.origin);
		return level.var_E87A;
	}

	if(var_05 < var_01.var_272A)
	{
		dobackpedal(param_00);
	}
	else if(var_05 < var_01.desiredenemydistmin)
	{
		self method_841F();
	}

	aimattarget();
	shootattarget();
	return level.var_E87A;
}

//Function Number: 44
combat_end(param_00)
{
	lib_0A1B::func_297E(0);
	stopshootingattarget();
	self method_841F();
	self.var_3135.var_FECD = undefined;
	self.var_3135.var_B117 = 0;
}

//Function Number: 45
revealanomaly_begin(param_00)
{
	self method_8286(self.reveal_anomaly_origin);
	self.var_C37F = self.var_15C;
	self method_8287(108);
	self.reveal_dialogue_spoken = undefined;
	self.started_reveal_dialogue = undefined;
	thread elvira_reveal_vo();
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.breveal_started = 0;
}

//Function Number: 46
elvira_reveal_vo()
{
	self.started_reveal_dialogue = 1;
	if(!scripts\cp\_vo::func_9D13())
	{
		scripts\cp\_vo::func_F60C(1);
		scripts\common\utility::play_sound_in_space("el_pap_energy_pap_restore",level.elvira.origin,0,level.elvira);
		var_00 = scripts\cp\_vo::func_7C76("el_pap_energy_pap_restore");
		wait(var_00);
		scripts\cp\_vo::func_F60C(0);
	}

	self.reveal_dialogue_spoken = 1;
}

//Function Number: 47
revealanomaly_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(isdefined(self.reveal_anomaly_origin) && !scripts\common\utility::istrue(var_01.breveal_started))
	{
		if(distance2dsquared(self.reveal_anomaly_origin,self.origin) <= 16384 && scripts\common\utility::istrue(self.reveal_dialogue_spoken))
		{
			stopshootingattarget();
			scripts\asm\elvira\elvira_asm::setaction("cast_reveal_spell");
			scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"cast_reveal_spell","cast_reveal_spell",::revealanomaly_revealdone,undefined,undefined,8000);
			scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"cast_reveal_spell");
			var_01.breveal_started = 1;
			return level.var_E87A;
		}
		else
		{
			if(distance2dsquared(self.reveal_anomaly_origin,self.origin) <= 16384 && !scripts\common\utility::istrue(self.started_reveal_dialogue))
			{
				self method_8286(self.origin);
			}
			else
			{
				self method_8286(self.reveal_anomaly_origin);
			}

			return level.var_E87A;
		}
	}

	return level.var_111AE;
}

//Function Number: 48
revealanomaly_end(param_00)
{
	self method_8287(self.var_C37F);
	self.var_C37F = undefined;
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.breveal_started = undefined;
	self.reveal_anomaly_origin = undefined;
	scripts\asm\elvira\elvira_asm::clearaction();
}

//Function Number: 49
tryrevealanomaly(param_00)
{
	if(scripts\common\utility::istrue(level.anomaly_revealed))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.started_reveal_dialogue))
	{
		return 0;
	}

	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(isdefined(level.secretpapstructs) && level.secretpapstructs.size > 0 && !scripts\common\utility::istrue(var_01.breveal_started))
	{
		var_02 = sortbydistance(level.secretpapstructs,self.origin);
		if(distance2dsquared(self.origin,var_02[0].origin) < 65536)
		{
			self.reveal_anomaly_origin = var_02[0].origin;
			scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"reveal_anomaly");
			return 1;
		}
		else
		{
			var_03 = scripts\cp\_utility::func_7833(1,self.origin);
			var_04 = scripts\common\utility::getclosest(self.origin,var_03);
			if(isdefined(var_04))
			{
				if(distancesquared(var_04.origin,var_02[0].origin) < 65536)
				{
					self.reveal_anomaly_origin = var_02[0].origin;
					scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"reveal_anomaly");
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 50
revealanomaly_revealdone(param_00,param_01)
{
	level.anomaly_revealed = 1;
	var_02 = scripts\common\utility::getclosest(self.origin,level.secretpapstructs);
	var_02.revealed = 1;
	var_02.teleporter_active = 1;
	level.active_pap_teleporter = var_02;
	level thread elvirarevealdialogue();
	return 0;
}

//Function Number: 51
elvirarevealdialogue()
{
	if(scripts\cp\_music_and_dialog::func_3837())
	{
		var_00 = scripts\common\utility::random(level.players);
		if(isdefined(var_00.var_134FD))
		{
			switch(var_00.var_134FD)
			{
				case "p1_":
					level thread scripts\cp\_vo::try_to_play_vo("sally_pap_1","rave_dialogue_vo","highest",666,0,0,0,100);
					break;

				case "p2_":
					level thread scripts\cp\_vo::try_to_play_vo("pdex_pap_1","rave_dialogue_vo","highest",666,0,0,0,100);
					break;

				case "p3_":
					level thread scripts\cp\_vo::try_to_play_vo("andre_pap_1","rave_dialogue_vo","highest",666,0,0,0,100);
					break;

				case "p4_":
					level thread scripts\cp\_vo::try_to_play_vo("aj_pap_1","rave_dialogue_vo","highest",666,0,0,0,100);
					break;

				default:
					break;
			}
		}
	}
	else
	{
		scripts\cp\_vo::try_to_play_vo_on_all_players("pap_quest_success",0);
	}

	foreach(var_02 in level.players)
	{
		var_02 thread scripts\cp\_vo::func_1769("nag_find_pap","town_comment_vo",120,120,4,1);
	}
}

//Function Number: 52
tryreturnhome(param_00)
{
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(scripts\common\utility::istrue(var_01.breturn_started))
	{
		return 0;
	}

	if(gettime() < self.return_home_time)
	{
		return 0;
	}

	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"return_home");
	return 1;
}

//Function Number: 53
returnhome_begin(param_00)
{
}

//Function Number: 54
returnhome_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(!scripts\common\utility::istrue(var_01.breturn_started))
	{
		stopshootingattarget();
		scripts\asm\elvira\elvira_asm::setaction("cast_return_spell");
		scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"cast_return_spell","cast_return_spell",::returnhome_done,undefined,undefined,8000);
		scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"cast_return_spell");
		var_01.breturn_started = 1;
		level.elvira_returned_to_couch = 1;
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 55
returnhome_end(param_00)
{
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.breturn_started = undefined;
	self.return_time = undefined;
	scripts\asm\elvira\elvira_asm::clearaction();
}

//Function Number: 56
returnhome_done(param_00,param_01)
{
	thread return_elvira_to_couch();
	return 0;
}

//Function Number: 57
return_elvira_to_couch()
{
	playfx(level._effect["elvira_stand_smoke"],self.origin);
	playsoundatpos(self.origin,"town_elvira_vanish");
	wait(0.1);
	self.nocorpse = 1;
	self.var_C089 = 1;
	var_00 = self.origin;
	self setcandamage(1);
	self suicide();
	level.elvira_ai = undefined;
	level.elvira_available_again = gettime() + 300000;
	var_01 = scripts\common\utility::random(["ammo_max","instakill_30","cash_2","instakill_30","cash_2","instakill_30","cash_2"]);
	wait(2);
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
	level scripts\cp\zombies\_powerups::drop_loot(var_00,undefined,var_01);
	wait(10);
	if(scripts\common\utility::flag("spellbook_placed") && !scripts\common\utility::flag("spellbook_page1_found") && !scripts\common\utility::flag("boss_fight_active"))
	{
		level thread elvira_spellbook_pages();
	}

	wait(290);
	scripts\common\utility::func_6E2A("elvira_summoned");
	playfx(level._effect["elvira_couch_smoke"],level.elvira.origin);
	playsoundatpos(level.elvira.origin,"town_elvira_appear");
	level.elvira show();
	level thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_idle_loop();
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.var_A8D3) && isdefined(var_03.var_A8D3.script_noteworthy == "elvira_talk"))
		{
			var_03 notify("stop_interaction_logic");
			var_03.var_9A3F makeunusable();
			var_03.var_A8D3 = undefined;
		}
	}
}

//Function Number: 58
elvira_spellbook_pages()
{
	if(!scripts\common\utility::istrue(level.var_C9C1) && !scripts\common\utility::istrue(level.var_13517))
	{
		scripts\cp\_vo::func_F60C(1);
		if(!scripts\common\utility::istrue(level.has_nagged_for_pages))
		{
			scripts\common\utility::play_sound_in_space("el_nag_spellbook_pages",level.elvira.origin,0,level.elvira);
			var_00 = scripts\cp\_vo::func_7C76("el_nag_spellbook_pages");
			wait(var_00);
		}
		else
		{
			var_01 = scripts\common\utility::random(["el_nag_spellbook_pages_2","el_nag_spellbook_pages_3"]);
			scripts\common\utility::play_sound_in_space(var_01,level.elvira.origin,0,level.elvira);
			var_00 = scripts\cp\_vo::func_7C76(var_01);
			wait(var_00);
		}

		scripts\cp\_vo::func_F60C(0);
	}

	level.has_nagged_for_pages = 1;
}

//Function Number: 59
castspell_begin(param_00)
{
}

//Function Number: 60
castspell_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	if(!scripts\common\utility::istrue(var_01.spellcast_started))
	{
		stopshootingattarget();
		scripts\asm\elvira\elvira_asm::setaction("cast_spell");
		scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"cast_spell","cast_spell",::castspell_castdone,undefined,undefined,8000);
		scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"cast_spell");
		var_01.spellcast_started = 1;
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 61
castspell_end(param_00)
{
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.spellcast_started = undefined;
	scripts\asm\elvira\elvira_asm::clearaction();
}

//Function Number: 62
trycastspell(param_00)
{
	if(!scripts\common\utility::flag("spellbook_page1_placed"))
	{
		return 0;
	}

	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	var_03 = 0;
	if(!isdefined(self.next_spellcast_time))
	{
		self.next_spellcast_time = gettime() + var_02.init_spellcast_delay;
		return 0;
	}
	else if(gettime() < self.next_spellcast_time)
	{
		return 0;
	}

	if(isdefined(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) < var_02.max_dist_for_spell_cast_sq)
	{
		var_04 = scripts\mp\_mp_agent::func_7DB0("axis");
		var_05 = 0;
		foreach(var_07 in var_04)
		{
			if(!sighttracepassed(self.origin + (0,0,40),var_07.origin + (0,0,40),0,self))
			{
				continue;
			}

			if(distancesquared(var_07.origin,self.var_10C.origin) < var_02.max_enemy_spell_radius_sq)
			{
				var_05++;
			}
		}

		if(var_05 < var_02.min_enemies_for_spellcast)
		{
			return 0;
		}

		self.next_spellcast_time = gettime() + var_02.spellcast_interval;
		scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"cast_spell");
		return 1;
	}

	return 0;
}

//Function Number: 63
castspell_castdone(param_00,param_01)
{
	return 0;
}

//Function Number: 64
shouldtrymeleeattack()
{
	return 1;
}

//Function Number: 65
trymeleeattacks(param_00,param_01)
{
	var_02 = scripts\mp\agents\elvira\elvira_agent::getenemy();
	var_03 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	if(abs(var_02.origin[2] - self.origin[2]) > var_03.melee_max_z_diff)
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = distancesquared(self.origin,var_02.origin);
	}

	if(!ispointonnavmesh(var_02.origin))
	{
		if(param_01 > self.var_B631 * self.var_B631)
		{
			return 0;
		}
	}
	else if(param_01 > self.var_B62F)
	{
		return 0;
	}

	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"melee_attack");
	return 1;
}

//Function Number: 66
decideaction(param_00)
{
	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"idle");
	return level.var_111AE;
}