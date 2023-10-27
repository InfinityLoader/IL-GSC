/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\crab_boss\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 2735 ms
 * Timestamp: 10/26/2023 11:58:30 PM
*******************************************************************/

//Function Number: 1
initbehaviors(param_00)
{
	setupbehaviorstates();
	self.desiredaction = undefined;
	self.lastenemyengagetime = 0;
	self.myenemy = undefined;
	return level.var_111AE;
}

//Function Number: 2
setupbehaviorstates()
{
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("simple_action",::simpleaction_begin,::simpleaction_tick,::simpleaction_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("boss_movement",::move_begin,::move_tick,::move_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("heal",::heal_begin,::heal_tick,::heal_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("beam",::beam_begin,::beam_tick,::func_2A1D);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("roar",::roar_begin,::roar_tick,::roar_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("submerge_spawn",::submerge_spawn_begin,::submerge_spawn_tick,::submerge_spawn_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("spawn",::spawn_begin,::spawn_tick,::spawn_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("bomb",::bomb_begin,::bomb_tick,::bomb_end);
	scripts\aitypes\dlc3\bt_action_api::setupbtaction("submerge_bomb",::submerge_bomb_begin,::submerge_bomb_tick,::submerge_bomb_end);
}

//Function Number: 3
updateeveryframe(param_00)
{
	self method_841F();
	self method_8287(9999999);
	return level.var_6AD5;
}

//Function Number: 4
simpleaction_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction(self.simple_action);
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,self.simple_action,self.simple_action);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,self.simple_action);
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_01.simple_action = self.simple_action;
	self.simple_action = undefined;
}

//Function Number: 5
simpleaction_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 6
simpleaction_end(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	var_01 = scripts\aitypes\dlc3\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = var_01.simple_action;
	var_01.simple_action = undefined;
	self notify(var_02 + "_done");
}

//Function Number: 7
dosimpleaction_immediate(param_00,param_01)
{
	self.simple_action = param_01;
	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"simple_action");
}

//Function Number: 8
dosimpleaction(param_00,param_01)
{
	self.simple_action = param_01;
	self.nextaction = "simple_action";
}

//Function Number: 9
facepoint(param_00,param_01)
{
	var_02 = scripts\common\utility::func_824D(param_01);
	if(abs(var_02) < 16)
	{
		return 0;
	}

	self.desiredyaw = var_02;
	dosimpleaction_immediate(param_00,"turn");
	return 1;
}

//Function Number: 10
initialmovedone(param_00,param_01)
{
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"arrival_wait","move_arrival",::arrivalmovedone,undefined,undefined,1000);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"arrival_wait");
	return 1;
}

//Function Number: 11
arrivalmovedone(param_00,param_01)
{
	return 0;
}

//Function Number: 12
planscaledrouteto(param_00)
{
	var_01 = getdesiredmovedirindex(self.origin,param_00);
	var_02 = level.crab_boss_exit_data[var_01];
	var_03 = level.crab_boss_arrival_data[var_01];
	var_04 = level.crab_boss_move_data[var_01];
	var_05 = length2d(var_04);
	var_06 = distance2d(param_00,self.origin);
	var_07 = length2d(var_02) + length2d(var_03);
	var_08 = var_06 - var_07;
	var_09 = var_08 / var_05;
	var_0A = ceil(var_09);
	if(var_0A - var_09 < 0.5)
	{
		var_09 = var_0A;
	}
	else
	{
		var_09 = floor(var_09);
	}

	var_0B = var_05 * var_09;
	var_0C = var_07 + var_0B;
	self.moveloopscale = var_06 / var_0C;
	self.currentmovedirindex = var_01;
	self.movedircount = var_09;
}

//Function Number: 13
getyawfrompointtospot(param_00,param_01)
{
	var_02 = vectortoyaw(param_01 - param_00);
	var_02 = angleclamp180(var_02);
	var_02 = var_02 - self.angles[1];
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 14
getdesiredmovedirindex(param_00,param_01)
{
	var_02 = getyawfrompointtospot(param_00,param_01);
	var_03 = abs(var_02);
	if(var_03 <= 22.5)
	{
		return 8;
	}

	if(var_03 >= 157.5)
	{
		return 2;
	}

	if(var_02 > 0)
	{
		if(var_02 < 67.5)
		{
			return 7;
		}

		if(var_02 < 112.5)
		{
			return 4;
		}

		return 1;
	}
	else
	{
		if(var_03 < 67.5)
		{
			return 9;
		}

		if(var_03 < 112.5)
		{
			return 6;
		}

		return 2;
	}

	return 8;
}

//Function Number: 15
move_begin(param_00)
{
	planscaledrouteto(self.desiredbossmovepos);
	scripts\asm\crab_boss\crab_boss_asm::setaction("move");
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"initial_move","move_loop",::initialmovedone,undefined,undefined,6000);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"initial_move");
}

//Function Number: 16
move_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 17
move_end(param_00)
{
	self.desiredbossmovepos = undefined;
	self.currentmovedirindex = undefined;
	self.movedircount = undefined;
	self notify("move_complete");
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

//Function Number: 18
bossmoveto(param_00,param_01)
{
	self.desiredbossmovepos = param_01;
	facepoint(param_00,param_01);
	return 1;
}

//Function Number: 19
bomb_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("bomb");
}

//Function Number: 20
bomb_tick(param_00)
{
	if(self.numofspawnrequested > 0)
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 21
bomb_end(param_00)
{
	self.spawnposarray = undefined;
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	self notify("bomb_complete");
}

//Function Number: 22
spawn_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("spawn");
}

//Function Number: 23
spawn_tick(param_00)
{
	if(self.numofspawnrequested > 0)
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 24
spawn_end(param_00)
{
	self.spawnposarray = undefined;
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	self notify("spawn_complete");
}

//Function Number: 25
submerge_spawn_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("submerge_spawn");
}

//Function Number: 26
submerge_spawn_tick(param_00)
{
	if(self.numofspawnrequested > 0)
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 27
submerge_spawn_end(param_00)
{
	self.spawnposarray = undefined;
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	self notify("submerge_spawn_complete");
}

//Function Number: 28
submerge_bomb_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("submerge_bomb");
}

//Function Number: 29
submerge_bomb_tick(param_00)
{
	if(self.numofbombrequested > 0)
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 30
submerge_bomb_end(param_00)
{
	self.bombposarray = undefined;
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	self notify("submerge_bomb_complete");
}

//Function Number: 31
heal_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("heal");
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"heal","heal_loop",undefined,undefined,undefined,3000);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"heal");
}

//Function Number: 32
heal_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 33
heal_end(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

//Function Number: 34
roar_begin(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("roar");
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"roar","roar_loop",undefined,undefined,undefined,3000);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"roar");
}

//Function Number: 35
roar_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 36
roar_end(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
}

//Function Number: 37
beam_begin(param_00)
{
	self.var_1C2 = self.beamattacktarget.origin;
	scripts\aitypes\dlc3\bt_state_api::wait_state_setup(param_00,750,::beam_waitdone);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"wait");
}

//Function Number: 38
beam_tick(param_00)
{
	if(scripts\aitypes\dlc3\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	return level.var_111AE;
}

//Function Number: 39
func_2A1D(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::clearaction();
	self.var_1C2 = undefined;
	self notify("beam_done");
	self.beamfollowtargetstartpos = undefined;
	self.beamfollowtarget = undefined;
	self.beamtargetpos = undefined;
	self.beamattacktarget = undefined;
}

//Function Number: 40
beam_waitdone(param_00)
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("beam");
	scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"beaming","beam",::beam_attackdone);
	scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"beaming");
	return 1;
}

//Function Number: 41
beam_attackdone(param_00,param_01)
{
	if(isdefined(self.requested_action) && self.requested_action == "beam_interrupted")
	{
		scripts\aitypes\dlc3\bt_state_api::asm_wait_state_setup(param_00,"beam_interrupted","beam_interrupted",::beaminterrupted_attackdone);
		scripts\aitypes\dlc3\bt_state_api::btstate_transitionstate(param_00,"beam_interrupted");
	}

	return 1;
}

//Function Number: 42
beaminterrupted_attackdone(param_00,param_01)
{
	return 0;
}

//Function Number: 43
func_5ABE(param_00)
{
	dosimpleaction(param_00,"taunt");
	return 1;
}

//Function Number: 44
beamattackposition(param_00,param_01)
{
	self.beamattacktarget = param_01;
	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,"beam");
}

//Function Number: 45
dodeath(param_00)
{
	dosimpleaction(param_00,"death");
	return 1;
}

//Function Number: 46
dospawnattack(param_00)
{
	dosimpleaction(param_00,"spawn");
	return 1;
}

//Function Number: 47
dobombattack(param_00)
{
	dosimpleaction(param_00,"bomb");
	return 1;
}

//Function Number: 48
dosmashattack(param_00)
{
	dosimpleaction(param_00,"smash");
	return 1;
}

//Function Number: 49
dosmashinterrupted()
{
	dosimpleaction_immediate(0,"smash_interrupted");
	return 1;
}

//Function Number: 50
dobeaminterrupted()
{
	scripts\asm\crab_boss\crab_boss_asm::setaction("beam_interrupted");
}

//Function Number: 51
dogasattack(param_00)
{
	self.spawnposarray = getspawnposarray(getnumofgasspawn());
	self.numofspawnrequested = self.spawnposarray.size;
	dosimpleaction(param_00,"toxic");
	return 1;
}

//Function Number: 52
dosubmerge(param_00)
{
	dosimpleaction(param_00,"submerge");
	return 1;
}

//Function Number: 53
getnumofgasspawn()
{
	var_00 = 23 - level.spawned_enemies.size;
	var_01 = 23;
	return min(var_00,var_01);
}

//Function Number: 54
getspawnposarray(param_00)
{
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray("death_wall_spawner","targetname");
	var_02 = scripts\common\utility::array_randomize(var_02);
	for(var_03 = 0;var_03 < param_00;var_03++)
	{
		var_04 = spawnstruct();
		var_05 = var_02[var_03 % var_02.size];
		var_04.origin = getclosestpointonnavmesh(var_05.origin);
		var_04.angles = var_05.angles;
		var_01[var_03] = var_04;
	}

	return var_01;
}

//Function Number: 55
doheal(param_00)
{
	dosimpleaction(param_00,"heal");
	return 1;
}

//Function Number: 56
oncrabbrutesummon(param_00)
{
	self.spawnposarray = param_00;
	self.numofspawnrequested = self.spawnposarray.size;
	if(lib_0A1A::func_2354("submerge_loop"))
	{
		self.nextaction = "submerge_spawn";
		return;
	}

	self.nextaction = "spawn";
}

//Function Number: 57
dosubmergespawn()
{
	self.spawnposarray = scripts\cp\maps\cp_town\cp_town_crab_boss_escort::calculate_egg_sac_spawn_pos();
	self.numofspawnrequested = self.spawnposarray.size;
	self.nextaction = "submerge_spawn";
	return 1;
}

//Function Number: 58
dosubmergebomb()
{
	self.bombposarray = scripts\cp\maps\cp_town\cp_town_crab_boss_escort::calculate_egg_sac_bomb_pos();
	self.numofbombrequested = self.bombposarray.size;
	self.submergebombspawnindex = getsubmergebombspawnindex();
	self.nextaction = "submerge_bomb";
	return 1;
}

//Function Number: 59
getsubmergebombspawnindex()
{
	var_00 = 4;
	var_01 = var_00;
	if(isdefined(level.crab_boss_num_submerge_spawn))
	{
		var_01 = level.crab_boss_num_submerge_spawn;
	}

	var_02 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
	var_03 = max(0,var_01 - var_02);
	var_04 = scripts\common\utility::array_randomize([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]);
	var_05 = [];
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		var_05[var_06] = var_04[var_06];
	}

	return var_05;
}

//Function Number: 60
doemerge()
{
	dosimpleaction(0,"emerge");
	return 1;
}

//Function Number: 61
dodeathrayspawn(param_00)
{
	self.spawnposarray = getdeathrayspawnpos(param_00);
	self.numofspawnrequested = self.spawnposarray.size;
	dosimpleaction(0,"toxic_spawn");
	return 1;
}

//Function Number: 62
getdeathrayspawnpos(param_00)
{
	var_01 = 100;
	var_02 = 8;
	var_03 = 8;
	var_04 = [];
	var_05 = scripts\cp\maps\cp_town\cp_town_crab_boss_fight::get_num_alive_agent_of_type("crab_mini");
	var_06 = max(0,var_02 - var_05);
	var_06 = min(var_06,var_03);
	var_07 = vectornormalize(param_00.origin - level.crab_boss.origin);
	for(var_08 = 0;var_08 < var_06;var_08++)
	{
		var_09 = randomfloatrange(var_01 * -1,var_01);
		var_0A = randomfloatrange(var_01 * -1,var_01);
		var_0B = vectortoangles(var_07);
		var_0C = spawnstruct();
		var_0C.origin = (param_00.origin[0] + var_09,param_00.origin[1] + var_0A,param_00.origin[2]);
		var_0C.angles = var_0B;
		var_04[var_04.size] = var_0C;
	}

	return var_04;
}

//Function Number: 63
dotoxicspawn()
{
	self.spawnposarray = gettoxicspawnpos(self);
	self.numofspawnrequested = self.spawnposarray.size;
	dosimpleaction(0,"toxic_spawn");
	return 1;
}

//Function Number: 64
gettoxicspawnpos(param_00)
{
	var_01 = 350;
	var_02 = 4;
	var_03 = 150;
	var_04 = var_02 + level.players.size;
	var_05 = [];
	var_06 = [];
	foreach(var_08 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_08))
		{
			continue;
		}

		var_06[var_06.size] = var_08;
	}

	if(var_06.size == 0)
	{
		var_0A = (2826,1244,-91);
		var_0B = spawnstruct();
		var_0B.origin = var_0A;
		var_0B.angles = vectortoangles(vectornormalize(var_0A - param_00.origin));
		var_05[var_05.size] = var_0B;
	}
	else
	{
		for(var_0C = 1;var_0C <= var_04;var_0C++)
		{
			var_08 = scripts\common\utility::random(var_06);
			var_0D = vectornormalize(var_08.origin - param_00.origin);
			var_0E = scripts\common\utility::func_5D14(var_08.origin + var_0D * -1 * var_01,50,-2000);
			var_0F = randomfloatrange(var_03 * -1,var_03);
			var_10 = randomfloatrange(var_03 * -1,var_03);
			var_0E = var_0E + (var_0F,var_10,0);
			var_0E = getclosestpointonnavmesh(var_0E);
			var_11 = vectortoangles(var_0D);
			var_0B = spawnstruct();
			var_0B.origin = var_0E;
			var_0B.angles = var_11;
			var_05[var_05.size] = var_0B;
		}
	}

	return var_05;
}

//Function Number: 65
startroarattack(param_00)
{
	self.roar_loops = param_00;
	scripts\aitypes\dlc3\bt_action_api::setdesiredaction(0,"roar");
	return 1;
}

//Function Number: 66
endroarattack()
{
	lib_0A1A::func_2330("roar_done");
	return 1;
}

//Function Number: 67
func_5A5A(param_00)
{
	self.painalias = param_00;
	dosimpleaction(0,"pain");
}

//Function Number: 68
interruptcurrentstate()
{
	if(!scripts\common\utility::istrue(self.binterruptable))
	{
		return;
	}

	var_00 = lib_0A1A::func_233A("crab_boss");
	switch(var_00)
	{
		case "beam":
			dobeaminterrupted();
			break;

		case "smash":
			dosmashinterrupted();
			break;
	}
}

//Function Number: 69
decideaction(param_00)
{
	if(isdefined(self.desiredaction))
	{
		return level.var_111AE;
	}

	if(!isdefined(self.nextaction) && isdefined(self.desiredbossmovepos))
	{
		self.nextaction = "boss_movement";
	}

	if(isdefined(self.nextaction))
	{
		scripts\aitypes\dlc3\bt_action_api::setdesiredaction(param_00,self.nextaction);
		self.nextaction = undefined;
		return level.var_111AE;
	}

	return level.var_6AD5;
}