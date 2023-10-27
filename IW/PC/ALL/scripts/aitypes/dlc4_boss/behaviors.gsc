/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\dlc4_boss\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 110
 * Decompile Time: 4395 ms
 * Timestamp: 10/26/2023 11:58:44 PM
*******************************************************************/

//Function Number: 1
initbehaviors(param_00)
{
	setupbehaviorstates();
	setupblackboard();
	setupnodes();
	setupactions();
	self.desiredaction = undefined;
	self.lastenemyengagetime = 0;
	self.myenemy = undefined;
	self.timers = spawnstruct();
	self.timers.idletimer = 0;
	self setscriptablepartstate("flames","on");
	resetsoulhealth();
	self.var_71D0 = ::shouldplaydlc4bosspainanim;
	self.unlockedactions = [];
	self.forcingaction = 0;
	self.specialactionnames = scripts\common\utility::array_randomize(["clap","throw","air_pound","tornado"]);
	self.passivetimer = 0;
	self.specialactiontimer = 0;
	self.automaticspawntimer = 0;
	self.claponarena = 0;
	self.eclipseactive = 0;
	self.cantakedamage = 0;
	self.var_FCA5 = 1;
	self.showblood = 0;
	self.interruptable = 1;
	self.automaticspawn = 0;
	self.vulnerable = 0;
	self.damagecap = 0;
	self.maxdamagecap = scripts\asm\dlc4\dlc4_asm::gettunedata().frenzied_damage_cap;
	updateweights();
	return level.var_111AE;
}

//Function Number: 2
shouldplaydlc4bosspainanim()
{
	return 1;
}

//Function Number: 3
setupbehaviorstates()
{
	scripts\aitypes\dlc4\simple_action::setupsimplebtaction();
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("move_action",::moveaction_begin,::moveaction_tick,::moveaction_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("ground_pound",::groundpound_begin,::groundpound_tick,::groundpound_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("temp_idle",::tempidle_begin,::tempidle_tick,::tempidle_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("air_pound",::airpound_begin,::airpound_tick,::airpound_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("ground_vul",::groundvul_begin,::groundvul_tick,::groundvul_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("drop_move",::dropmove_begin,::dropmove_tick,::dropmove_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("fly_over",::flyover_begin,::flyover_tick,::flyover_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("teleport",::teleport_begin,::teleport_tick,::teleport_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("death",::death_begin,::death_tick,::death_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("simple_setup",::simplesetup_begin,::simplesetup_tick,::simplesetup_end);
	scripts\aitypes\dlc4\bt_action_api::setupbtaction("eclipse",::eclipse_begin,::eclipse_tick,::eclipse_end);
}

//Function Number: 4
setupblackboard()
{
	self.var_1198.var_4BF7 = undefined;
	self.var_1198.desirednode = undefined;
	self.var_1198.previousposition = undefined;
	self.var_1198.currentmovedirindex = 5;
	self.var_1198.nodestomove = 0;
	self.var_1198.movereadyforarrival = 0;
	self.var_1198.smoothmotion = 0;
	self.var_1198.facecenter = 0;
	self.var_1198.fastmovement = 0;
	self.var_1198.lookaheadorigin = undefined;
	self.var_1198.lookaheadcurrnode = undefined;
	self.var_1198.lookaheadnextnode = undefined;
	self.var_1198.strafeaction = "none";
	self.var_1198.groundpoundstate = 0;
	self.var_1198.painnotifytime = 0;
}

//Function Number: 5
setupnodes()
{
	self.arenacenter = scripts\common\utility::getstruct("arena_center","targetname").origin;
	var_00 = [];
	var_01 = scripts\common\utility::getstruct("boss_path","script_noteworthy");
	var_02 = var_01.var_336;
	for(;;)
	{
		var_01.var_1E75 = vectornormalize(self.arenacenter - var_01.origin * (1,1,0));
		var_00[var_00.size] = var_01;
		var_01 = scripts\common\utility::getstruct(var_01.target,"targetname");
		if(var_01.var_336 == var_02)
		{
			break;
		}
	}

	self.var_1198.var_C053 = var_00;
}

//Function Number: 6
setupactions()
{
	self.bossactions = [];
	self.bossactionsstruct = [];
	self.weightcopies = [];
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = spawnstruct();
	var_01.name = "fireball";
	var_01.dofunc = ::fireball;
	var_01.canfunc = ::canfireball;
	var_01.var_13CE8 = var_00.fireball_weight;
	var_01.var_11910 = 0;
	var_01.var_461D = var_00.fireball_cooldown_time;
	self.bossactions[self.bossactions.size] = var_01;
	self.bossactionsstruct[var_01.name] = var_01;
	var_02 = spawnstruct();
	var_02.name = "clap";
	var_02.dofunc = ::clap;
	var_02.canfunc = ::canclap;
	var_02.var_13CE8 = var_00.clap_weight;
	var_02.var_11910 = 0;
	var_02.var_461D = var_00.clap_cooldown_time;
	self.bossactions[self.bossactions.size] = var_02;
	self.bossactionsstruct[var_02.name] = var_02;
	var_03 = spawnstruct();
	var_03.name = "throw";
	var_03.dofunc = ::throw;
	var_03.canfunc = ::canthrow;
	var_03.var_13CE8 = var_00.throw_weight;
	var_03.var_11910 = 0;
	var_03.var_461D = var_00.throw_cooldown_time;
	self.bossactions[self.bossactions.size] = var_03;
	self.bossactionsstruct[var_03.name] = var_03;
	var_04 = spawnstruct();
	var_04.name = "tornado";
	var_04.dofunc = ::tornado;
	var_04.canfunc = ::cantornado;
	var_04.var_13CE8 = var_00.tornado_weight;
	var_04.var_11910 = 0;
	var_04.var_461D = var_00.tornado_cooldown_time;
	self.bossactions[self.bossactions.size] = var_04;
	self.bossactionsstruct[var_04.name] = var_04;
	var_05 = spawnstruct();
	var_05.name = "summon";
	var_05.dofunc = ::summon;
	var_05.canfunc = ::cansummon;
	var_05.var_13CE8 = var_00.summon_weight;
	var_05.var_11910 = 0;
	var_05.var_461D = var_00.summon_cooldown_time;
	self.bossactions[self.bossactions.size] = var_05;
	self.bossactionsstruct[var_05.name] = var_05;
	var_06 = spawnstruct();
	var_06.name = "move_left";
	var_06.dofunc = ::moveleft;
	var_06.canfunc = ::canmoveleft;
	var_06.var_13CE8 = var_00.move_left_weight;
	var_06.var_11910 = 0;
	var_06.var_461D = var_00.move_left_cooldown_time;
	self.bossactions[self.bossactions.size] = var_06;
	self.bossactionsstruct[var_06.name] = var_06;
	var_07 = spawnstruct();
	var_07.name = "move_right";
	var_07.dofunc = ::moveright;
	var_07.canfunc = ::canmoveright;
	var_07.var_13CE8 = var_00.move_right_weight;
	var_07.var_11910 = 0;
	var_07.var_461D = var_00.move_right_cooldown_time;
	self.bossactions[self.bossactions.size] = var_07;
	self.bossactionsstruct[var_07.name] = var_07;
	var_08 = spawnstruct();
	var_08.name = "temp_idle";
	var_08.dofunc = ::tempidle;
	var_08.canfunc = ::canidle;
	var_08.var_13CE8 = var_00.idle_weight;
	var_08.var_11910 = 0;
	var_08.var_461D = var_00.temp_idle_cooldown_time;
	self.bossactions[self.bossactions.size] = var_08;
	self.bossactionsstruct[var_08.name] = var_08;
	var_09 = spawnstruct();
	var_09.name = "move_fireball_left";
	var_09.dofunc = ::movefireballleft;
	var_09.canfunc = ::canmovefireballleft;
	var_09.var_13CE8 = var_00.move_fireball_left_weight;
	var_09.var_11910 = 0;
	var_09.var_461D = var_00.move_fireball_left_cooldown_time;
	self.bossactions[self.bossactions.size] = var_09;
	self.bossactionsstruct[var_09.name] = var_09;
	var_0A = spawnstruct();
	var_0A.name = "move_fireball_right";
	var_0A.dofunc = ::movefireballright;
	var_0A.canfunc = ::canmovefireballright;
	var_0A.var_13CE8 = var_00.move_fireball_right_weight;
	var_0A.var_11910 = 0;
	var_0A.var_461D = var_00.move_fireball_right_cooldown_time;
	self.bossactions[self.bossactions.size] = var_0A;
	self.bossactionsstruct[var_0A.name] = var_0A;
	var_0B = spawnstruct();
	var_0B.name = "air_pound";
	var_0B.dofunc = ::airpound;
	var_0B.canfunc = ::canairpound;
	var_0B.var_13CE8 = var_00.air_pound_weight;
	var_0B.var_11910 = 0;
	var_0B.var_461D = var_00.air_pound_cooldown_time;
	self.bossactions[self.bossactions.size] = var_0B;
	self.bossactionsstruct[var_0B.name] = var_0B;
	var_0C = spawnstruct();
	var_0C.name = "ground_vul";
	var_0C.dofunc = ::groundvul;
	var_0C.canfunc = ::cangroundvul;
	var_0C.var_13CE8 = 0;
	var_0C.var_11910 = 0;
	var_0C.var_461D = 0;
	self.bossactions[self.bossactions.size] = var_0C;
	self.bossactionsstruct[var_0C.name] = var_0C;
	var_0D = spawnstruct();
	var_0D.name = "drop_move";
	var_0D.dofunc = ::dropmove;
	var_0D.canfunc = ::candropmove;
	var_0D.var_13CE8 = var_00.drop_move_weight;
	var_0D.var_11910 = 0;
	var_0D.var_461D = var_00.drop_move_cooldown_time;
	self.bossactions[self.bossactions.size] = var_0D;
	self.bossactionsstruct[var_0D.name] = var_0D;
	var_0E = spawnstruct();
	var_0E.name = "fly_over";
	var_0E.dofunc = ::flyover;
	var_0E.canfunc = ::canflyover;
	var_0E.var_13CE8 = var_00.fly_over_weight;
	var_0E.var_11910 = 0;
	var_0E.var_461D = var_00.fly_over_cooldown_time;
	self.bossactions[self.bossactions.size] = var_0E;
	self.bossactionsstruct[var_0E.name] = var_0E;
	var_0F = spawnstruct();
	var_0F.name = "black_hole";
	var_0F.dofunc = ::func_2B2F;
	var_0F.canfunc = ::canblackhole;
	var_0F.var_13CE8 = var_00.black_hole_weight;
	var_0F.var_11910 = 0;
	var_0F.var_461D = var_00.black_hole_cooldown_time;
	self.bossactions[self.bossactions.size] = var_0F;
	self.bossactionsstruct[var_0F.name] = var_0F;
	var_10 = spawnstruct();
	var_10.name = "eclipse";
	var_10.dofunc = ::eclipse;
	var_10.canfunc = ::caneclipse;
	var_10.var_13CE8 = 0;
	var_10.var_11910 = 0;
	var_10.var_461D = 0;
	self.bossactions[self.bossactions.size] = var_10;
	self.bossactionsstruct[var_10.name] = var_10;
	var_11 = spawnstruct();
	var_11.name = "taunt";
	var_11.dofunc = ::taunt;
	var_11.canfunc = ::cantaunt;
	var_11.var_13CE8 = 0;
	var_11.var_11910 = 0;
	var_11.var_461D = 0;
	self.bossactions[self.bossactions.size] = var_11;
	self.bossactionsstruct[var_11.name] = var_11;
}

//Function Number: 7
entrance_begin(param_00)
{
	self.introfinished = 0;
	self method_8287(100000);
	self method_841F();
	self.var_1198.desirednode = 0;
	self.var_1198.smoothmotion = 0;
	self.var_1198.facecenter = 0;
	self.var_3135.var_9928[param_00] = spawnstruct();
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"entrance","move_back_arrival",undefined,undefined,undefined,2000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"entrance");
	moveaction_internalsetup(param_00);
}

//Function Number: 8
entrance_tick(param_00)
{
	var_01 = self.var_1198;
	var_02 = distance(self.origin,var_01.previousposition);
	var_03 = self.traversallength;
	if(!var_01.movereadyforarrival)
	{
		if(var_02 + var_01.movearrivaldist >= var_03)
		{
			var_01.movereadyforarrival = 1;
		}
	}
	else
	{
		if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
		{
			self.var_1198.var_4BF7 = self.var_1198.desirednode;
			return level.var_E87A;
		}

		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 9
entrance_end(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.lookaheadorigin = self.origin;
	self.introfinished = 1;
	self.automaticspawn = 1;
}

//Function Number: 10
updateeveryframe(param_00)
{
	scripts\aitypes\dlc4\behavior_utils::func_12E8A();
	func_12F46();
	self.var_1198.painnotifytime = max(self.var_1198.painnotifytime - 50,0);
	return level.var_6AD5;
}

//Function Number: 11
func_12F46(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(isdefined(self.bossactions))
	{
		foreach(var_03 in self.bossactions)
		{
			var_03.var_11910 = max(var_03.var_11910 - 50,0);
		}
	}

	self.passivetimer = max(self.passivetimer - 50,0);
	self.specialactiontimer = max(self.specialactiontimer - 50,0);
	if(isdefined(level.meph_battle_over))
	{
		return;
	}

	self.automaticspawntimer = max(self.automaticspawntimer - 50,0);
	if(self.automaticspawntimer == 0 && self.automaticspawn)
	{
		self.automaticspawntimer = var_01.automatic_spawn_time;
		var_06 = scripts\mp\_mp_agent::func_7D95("skeleton");
		if(var_06.size < int(max(var_01.automatic_spawn_cap,level.players.size)))
		{
			computespawnpoints(1,var_06);
			scripts\asm\dlc4_boss\dlc4_boss_asm::summonskeletons();
		}
	}
}

//Function Number: 12
taunt(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"taunt");
}

//Function Number: 13
fireball(param_00)
{
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"fireball");
}

//Function Number: 14
clap(param_00)
{
	if(self.forcingaction)
	{
		restoreweights();
	}

	self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
	scripts\asm\dlc4_boss\dlc4_boss_asm::facearenacenter();
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"clap");
}

//Function Number: 15
throw(param_00)
{
	if(self.forcingaction)
	{
		restoreweights();
	}

	self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"throw");
}

//Function Number: 16
tornado(param_00)
{
	if(self.forcingaction)
	{
		restoreweights();
	}

	self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"tornado");
}

//Function Number: 17
teleporttonode(param_00)
{
	var_01 = self.var_1198.var_C053.size;
	self.var_1198.desirednode = self.var_1198.var_4BF7 + randomint(var_01 - 1) + 1 % var_01;
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"teleport");
}

//Function Number: 18
groundpound(param_00)
{
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"ground_pound");
}

//Function Number: 19
summon(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_02 = scripts\mp\_mp_agent::func_7D95(var_01.summon_agent_type);
	var_03 = var_01.summon_min_spawn_num["" + level.players.size];
	var_04 = var_01.summon_max_spawn_num["" + level.players.size];
	var_05 = var_01.summon_max_total["" + level.players.size];
	var_06 = min(randomintrange(var_03,var_04),var_05 - var_02.size);
	computespawnpoints(var_06,var_02);
	scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(param_00,"summon");
}

//Function Number: 20
moveleft(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.var_1198.nodestomove = randomintrange(var_01.min_move_nodes,var_01.max_move_nodes + 1);
	self.passivetimer = var_01.passive_cooldown;
	self.var_1198.currentmovedirindex = 4;
	self.var_1198.desirednode = self.var_1198.var_4BF7 + 1 % self.var_1198.var_C053.size;
	self.var_1198.strafeaction = "none";
	self.var_1198.smoothmotion = 1;
	self.var_1198.facecenter = 1;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"move_action");
}

//Function Number: 21
moveright(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.var_1198.nodestomove = randomintrange(var_01.min_move_nodes,var_01.max_move_nodes + 1);
	self.passivetimer = var_01.passive_cooldown;
	self.var_1198.currentmovedirindex = 6;
	self.var_1198.desirednode = self.var_1198.var_4BF7 - 1 + self.var_1198.var_C053.size % self.var_1198.var_C053.size;
	self.var_1198.strafeaction = "none";
	self.var_1198.smoothmotion = 1;
	self.var_1198.facecenter = 1;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"move_action");
}

//Function Number: 22
tempidle(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.passivetimer = var_01.passive_cooldown;
	self.timers.idletimer = randomfloatrange(var_01.min_idle_time,var_01.max_idle_time);
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"temp_idle");
}

//Function Number: 23
movefireballleft(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.var_1198.nodestomove = var_01.strafe_move_nodes;
	self.var_1198.currentmovedirindex = 4;
	self.var_1198.desirednode = self.var_1198.var_4BF7 + 1 % self.var_1198.var_C053.size;
	self.var_1198.strafeaction = "fireball";
	self.var_1198.smoothmotion = 1;
	self.var_1198.facecenter = 1;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"move_action");
}

//Function Number: 24
movefireballright(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.var_1198.nodestomove = var_01.strafe_move_nodes;
	self.var_1198.currentmovedirindex = 6;
	self.var_1198.desirednode = self.var_1198.var_4BF7 - 1 + self.var_1198.var_C053.size % self.var_1198.var_C053.size;
	self.var_1198.strafeaction = "fireball";
	self.var_1198.smoothmotion = 1;
	self.var_1198.facecenter = 1;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"move_action");
}

//Function Number: 25
moveclapleft(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.var_1198.nodestomove = var_01.strafe_move_nodes;
	self.var_1198.currentmovedirindex = 4;
	self.var_1198.desirednode = self.var_1198.var_4BF7 + 1 % self.var_1198.var_C053.size;
	self.var_1198.strafeaction = "clap";
	self.var_1198.facecenter = 1;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"move_action");
}

//Function Number: 26
moveclapright(param_00)
{
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.var_1198.nodestomove = var_01.strafe_move_nodes;
	self.var_1198.currentmovedirindex = 6;
	self.var_1198.desirednode = self.var_1198.var_4BF7 - 1 + self.var_1198.var_C053.size % self.var_1198.var_C053.size;
	self.var_1198.strafeaction = "clap";
	self.var_1198.facecenter = 1;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"move_action");
}

//Function Number: 27
airpound(param_00)
{
	if(self.forcingaction)
	{
		restoreweights();
	}

	self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown + 5;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"air_pound");
}

//Function Number: 28
groundvul(param_00)
{
	restoreweights();
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"ground_vul");
}

//Function Number: 29
dropmove(param_00)
{
	var_01 = self.var_1198.var_C053.size;
	self.var_1198.desirednode = self.var_1198.var_4BF7 + randomint(var_01 - 5) + 3 % var_01;
	self.passivetimer = scripts\asm\dlc4\dlc4_asm::gettunedata().passive_cooldown;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"drop_move");
}

//Function Number: 30
flyover(param_00)
{
	if(self.forcingaction)
	{
		restoreweights();
	}

	self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
	var_01 = self.var_1198;
	var_01.desirednode = var_01.var_4BF7 + scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_nodes_travelled % var_01.var_C053.size;
	scripts\asm\dlc4_boss\dlc4_boss_asm::facedesirednode();
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"fly_over");
}

//Function Number: 31
func_2B2F(param_00)
{
	scripts\asm\dlc4_boss\dlc4_boss_asm::facearenacenter();
	self.simplesetupstartstate = "black_hole";
	self.simplesetupendstate = "black_hole_end";
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"simple_setup");
}

//Function Number: 32
func_00E6(param_00)
{
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"death");
}

//Function Number: 33
eclipse(param_00)
{
	restoreweights();
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"eclipse");
}

//Function Number: 34
cooldownfinished(param_00)
{
	if(!isdefined(self.bossactions))
	{
		return 0;
	}

	foreach(var_02 in self.bossactions)
	{
		if(var_02.name == param_00)
		{
			return var_02.var_11910 <= 0;
		}
	}

	return 1;
}

//Function Number: 35
canfireball()
{
	var_00 = undefined;
	var_01 = scripts\asm\dlc4_boss\dlc4_boss_asm::getspecialenemy();
	var_00 = self.arenacenter;
	if(isdefined(var_01))
	{
		var_00 = var_01.origin;
	}

	var_02 = scripts\common\trace::func_48CC(1);
	var_03 = scripts\common\trace::func_109DF(self.origin + (0,0,250),var_00 + (0,0,12),10,undefined,var_02);
	if(var_03)
	{
		self.fireballtargetpos = var_00;
		return 1;
	}

	return 0;
}

//Function Number: 36
canclap()
{
	if(self.specialactiontimer > 0)
	{
		return 0;
	}

	if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 10000)
	{
		return 0;
	}

	if(level.fbd.bossstate == "MAIN" && self.soulhealth <= 1)
	{
		return 0;
	}

	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = anglestoforward(self.angles);
	var_02 = var_00.staff_projectile_speed * var_00.staff_projectile_interval;
	var_03 = var_02 / 2;
	var_04 = self.origin + var_01 * var_03;
	var_05 = var_04 + var_01 * var_00.staff_projectile_range;
	var_06 = scripts\common\trace::func_48CC(1);
	var_07 = scripts\common\trace::func_DCF1(var_04 + (0,0,250),var_05 + (0,0,250),undefined,var_06);
	return var_07;
}

//Function Number: 37
canthrow()
{
	if(self.specialactiontimer > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 38
cantornado()
{
	if(self.specialactiontimer > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
canteleport()
{
	return 1;
}

//Function Number: 40
cangroundpound()
{
	return 1;
}

//Function Number: 41
cansummon()
{
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = scripts\mp\_mp_agent::func_7D95(var_00.summon_agent_type);
	return var_01.size <= var_00.summon_min_zombies_before_active;
}

//Function Number: 42
canmoveleft()
{
	if(self.passivetimer > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 43
canmoveright()
{
	if(self.passivetimer > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
canidle()
{
	return 1;
}

//Function Number: 45
canmovefireballleft()
{
	return 1;
}

//Function Number: 46
canmovefireballright()
{
	return 1;
}

//Function Number: 47
canmoveclapleft()
{
	return 1;
}

//Function Number: 48
canmoveclapright()
{
	return 1;
}

//Function Number: 49
canairpound()
{
	if(self.specialactiontimer > 0)
	{
		return 0;
	}

	if(self.claponarena)
	{
		return 0;
	}

	if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 100000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 50
cangroundvul()
{
	return 1;
}

//Function Number: 51
candropmove()
{
	if(self.passivetimer > 0)
	{
		return 0;
	}

	if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 100000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 52
canflyover()
{
	if(self.specialactiontimer > 0)
	{
		return 0;
	}

	if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 100000)
	{
		return 0;
	}

	var_00 = self.var_1198;
	var_01 = var_00.var_4BF7 + scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_nodes_travelled % var_00.var_C053.size;
	var_02 = var_00.var_C053[var_01].origin;
	var_03 = scripts\common\trace::func_48CC(1);
	var_04 = scripts\common\trace::func_DCF1(self.origin + (0,0,250),var_02 + (0,0,250),undefined,var_03);
	return var_04;
}

//Function Number: 53
canblackhole()
{
	return 1;
}

//Function Number: 54
caneclipse()
{
	return 1;
}

//Function Number: 55
cantaunt()
{
	return 1;
}

//Function Number: 56
decideaction(param_00)
{
	self.terminateaction = 0;
	if(isdefined(self.desiredaction))
	{
		return level.var_111AE;
	}

	if(isdefined(self.nextaction))
	{
		scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,self.nextaction);
		self.nextaction = undefined;
		return level.var_111AE;
	}

	if(isdefined(level.meph_battle_over))
	{
		scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"debug_handler");
		return level.var_111AE;
	}

	var_01 = pickrandomvalidaction(param_00);
	return scripts\common\utility::func_116D7(var_01,level.var_111AE,level.var_6AD5);
}

//Function Number: 57
pickrandomvalidaction(param_00)
{
	var_01 = [];
	var_02 = 0;
	foreach(var_04 in self.bossactions)
	{
		if(cooldownfinished(var_04.name) && [[ var_04.canfunc ]]())
		{
			var_01[var_01.size] = var_04;
			var_02 = var_02 + var_04.var_13CE8;
			continue;
		}
	}

	if(var_02 == 0)
	{
		return 0;
	}

	var_06 = randomfloat(var_02);
	foreach(var_04 in var_01)
	{
		var_06 = var_06 - var_04.var_13CE8;
		if(var_06 <= 0)
		{
			[[ var_04.dofunc ]](param_00);
			resettimer(var_04.name,var_04.var_461D);
			return 1;
		}
	}

	return 0;
}

//Function Number: 58
moveaction_begin(param_00)
{
	self method_8287(100000);
	self method_841F();
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	self setscriptablepartstate("flame_trail","on");
	var_01 = self.var_1198;
	var_01.lookaheadorigin = var_01.var_C053[var_01.desirednode].origin;
	var_01.lookaheadcurrnode = var_01.var_4BF7;
	var_01.lookaheadnextnode = var_01.desirednode;
	moveaction_internalsetup(param_00);
	func_F8A3(param_00,"move");
}

//Function Number: 59
moveaction_internalsetup(param_00)
{
	var_01 = self.var_1198;
	var_01.previousposition = self.origin;
	var_01.movereadyforarrival = 0;
	self.traversallength = distance(var_01.previousposition,var_01.var_C053[var_01.desirednode].origin);
}

//Function Number: 60
moveaction_tick(param_00)
{
	var_01 = self.var_1198;
	var_02 = distance(self.origin,var_01.previousposition);
	var_03 = self.traversallength;
	if(scripts\asm\dlc4_boss\dlc4_boss_asm::shouldterminateaction())
	{
		return level.var_111AE;
	}

	if(var_01.nodestomove > 1)
	{
		if(var_02 >= var_03)
		{
			var_01.var_4BF7 = var_01.desirednode;
			var_01.nodestomove--;
			if(var_01.currentmovedirindex == 4)
			{
				var_01.desirednode = var_01.var_4BF7 + 1 % var_01.var_C053.size;
			}
			else
			{
				var_01.desirednode = var_01.var_4BF7 - 1 + var_01.var_C053.size % var_01.var_C053.size;
			}

			moveaction_internalsetup(param_00);
			var_01.desireddir = vectornormalize(var_01.var_C053[var_01.desirednode].origin - self.origin);
		}
	}
	else if(var_01.nodestomove == 1)
	{
		if(var_02 + var_01.movearrivaldist >= var_03)
		{
			var_01.nodestomove--;
			var_01.movereadyforarrival = 1;
		}
	}
	else if(lib_0A1A::func_232A("move_arrival","end"))
	{
		var_01.var_4BF7 = var_01.desirednode;
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 61
moveaction_end(param_00)
{
	self setscriptablepartstate("flame_trail","off");
	func_4045("move");
	self.traversallength = undefined;
	var_01 = self.var_1198;
	var_01.var_4BF7 = var_01.desirednode;
}

//Function Number: 62
tempidle_begin(param_00)
{
	self method_8287(100000);
	self method_841F();
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	func_F8A3(param_00,"temp_idle");
}

//Function Number: 63
tempidle_tick(param_00)
{
	if(scripts\asm\dlc4\dlc4_asm::checkpainnotify())
	{
		return level.var_6AD5;
	}

	if(self.timers.idletimer <= 0)
	{
		return level.var_111AE;
	}

	self.timers.idletimer = self.timers.idletimer - 50;
	return level.var_E87A;
}

//Function Number: 64
tempidle_end(param_00)
{
	self.timers.idletimer = 0;
	func_4045("temp_idle");
}

//Function Number: 65
groundpound_begin(param_00)
{
	func_F8A3(param_00,"ground_pound");
	self.var_1198.desirednode = self.var_1198.var_4BF7;
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"ground_pound","ground_pound_launch",undefined,undefined,undefined,2000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"ground_pound");
}

//Function Number: 66
groundpound_tick(param_00)
{
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 67
groundpound_end(param_00)
{
	func_4045("ground_pound");
}

//Function Number: 68
airpound_begin(param_00)
{
	func_F8A3(param_00,"air_pound");
	self.var_1198.desirednode = self.var_1198.var_4BF7;
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"air_pound","air_pound_teleport_finish",undefined,undefined,undefined,2000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"air_pound");
	self.interruptable = 0;
}

//Function Number: 69
airpound_tick(param_00)
{
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 70
airpound_end(param_00)
{
	func_4045("air_pound");
	self.interruptable = 1;
}

//Function Number: 71
groundvul_begin(param_00)
{
	func_F8A3(param_00,"ground_vul");
	self.var_1198.desirednode = self.var_1198.var_4BF7;
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"ground_vul","ground_vul_finish",undefined,undefined,undefined,2000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"ground_vul");
	self setscriptablepartstate("flames","off");
	self.doinggroundvul = 1;
	self.teleportedin = 0;
	self.var_FCA5 = 0;
	if(level.fbd.bossstate == "MAIN")
	{
		thread scripts\cp\maps\cp_final\cp_final_final_boss::setupweakspot(level.fbd.activecircle);
	}
}

//Function Number: 72
groundvul_tick(param_00)
{
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 73
groundvul_end(param_00)
{
	func_4045("ground_vul");
	self.doinggroundvul = 0;
	resetsoulhealth();
	self.var_FCA5 = 1;
	if(isdefined(level.fbd.sectioncomplete) && level.fbd.sectioncomplete)
	{
		if(level.fbd.bossstate == "MAIN")
		{
			setnextaction("eclipse");
		}
		else if(level.fbd.bossstate == "FRENZIED")
		{
			setupfrenziedmode();
			self.var_FCA5 = 0;
		}

		level.fbd.sectioncomplete = 0;
	}
}

//Function Number: 74
setupfrenziedmode()
{
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.frenziedhealth = var_00.frenzied_health;
	self.cantakedamage = 1;
	self.automaticspawn = 0;
	thread frenzyspawnmonitor();
	thread frenzyarmageddonmonitor();
	var_01 = self.bossactionsstruct;
	var_01["temp_idle"].var_13CE8 = var_00.frenzied_idle_weight;
	var_01["move_left"].var_13CE8 = var_00.frenzied_move_weight;
	var_01["move_right"].var_13CE8 = var_00.frenzied_move_weight;
	var_01["drop_move"].var_13CE8 = var_00.frenzied_drop_move_weight;
	var_01["fireball"].var_13CE8 = var_00.frenzied_fireball_weight;
	var_01["move_fireball_left"].var_13CE8 = var_00.frenzied_move_fireball_weight;
	var_01["move_fireball_right"].var_13CE8 = var_00.frenzied_move_fireball_weight;
	var_01["black_hole"].var_13CE8 = var_00.frenzied_black_hole_weight;
	var_01["fly_over"].var_13CE8 = var_00.frenzied_fly_over_weight;
	var_01["summon"].var_13CE8 = var_00.frenzied_summon_weight;
	foreach(var_03 in self.unlockedactions)
	{
		var_01[var_03].var_13CE8 = var_00.frenzied_special_weight;
	}

	thread frenzydamagecap();
	thread scripts\cp\maps\cp_final\cp_final_final_boss::frenzyprogressmonitor();
}

//Function Number: 75
frenzyspawnmonitor()
{
	self endon("last_stand");
	self endon("death");
	level endon("STOP_FRENZY_SPAWN");
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = var_00.frenzied_summon_wave_period;
	var_02 = var_00.frenzied_summon_start_wave;
	var_03 = var_00.frenzied_summon_number;
	var_04 = var_03;
	var_05 = [];
	foreach(var_07 in var_00.frenzied_summon_agents)
	{
		var_05[var_07] = 0;
	}

	for(;;)
	{
		var_09 = scripts\mp\_mp_agent::func_7DB0("axis");
		var_09 = scripts\common\utility::func_22A9(var_09,level.dlc4_boss);
		if(var_09.size < var_04 || var_09.size < level.players.size)
		{
			var_0A = [];
			var_0B = [];
			for(var_0C = 0;var_0C < int(min(var_02,var_00.frenzied_summon_agents.size));var_0C++)
			{
				var_07 = var_00.frenzied_summon_agents[var_0C];
				if(var_05[var_07] == 0)
				{
					var_0A[var_0A.size] = var_07;
					var_0B[var_0B.size] = var_00.frenzied_summon_data[var_07][0];
					if(var_0B.size > 1)
					{
						var_0B[var_0B.size - 1] = var_0B[var_0B.size - 1] + var_0B[var_0B.size - 2];
					}
				}
			}

			var_07 = scripts\common\utility::func_3E83(var_0A,var_0B);
			if(!computespawnpoints(1,var_09))
			{
				wait(0.05);
				continue;
			}

			scripts\asm\dlc4_boss\dlc4_boss_asm::spawnzombie(var_07,var_00.var_108FB[0]);
			var_05[var_07] = var_05[var_07] + var_00.frenzied_summon_data[var_07][1];
			var_04 = max(var_04 - 1,0);
			foreach(var_07 in var_00.frenzied_summon_agents)
			{
				var_05[var_07] = max(var_05[var_07] - 1,0);
			}
		}

		var_0F = randomfloatrange(var_00.frenzied_summon_min_interval,var_00.frenzied_summon_max_interval);
		wait(var_0F);
		var_01 = var_01 - var_0F * 1000;
		if(var_01 <= 0)
		{
			var_01 = var_00.frenzied_summon_wave_period;
			var_02 = var_02 + 1;
			var_03 = var_03 + var_00.frenzied_summon_increase_per_wave;
			var_04 = var_04 + var_03;
			self.maxdamagecap = self.maxdamagecap + var_00.frenzied_damage_cap_wave_increase;
		}
	}
}

//Function Number: 76
frenzyarmageddonmonitor()
{
	self endon("last_stand");
	self endon("death");
	self endon("STOP_FRENZY_ARMAGEDDON");
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	for(;;)
	{
		if(level.fbd.bossstate == "LAST_STAND")
		{
			break;
		}

		var_01 = pow(1 * var_00.frenzied_meteor_target_min_radius / var_00.frenzied_meteor_target_radius,2);
		var_02 = sqrt(randomfloat(1 - var_01) + var_01) * var_00.frenzied_meteor_target_radius;
		var_03 = randomfloat(360);
		var_04 = self.arenacenter[0] + var_02 * cos(var_03);
		var_05 = self.arenacenter[1] + var_02 * sin(var_03);
		var_06 = (var_04,var_05,self.arenacenter[2]);
		magicbullet("iw7_dlc4eclipse_mp",(-17910.3,966.038,5116),var_06);
		wait(randomfloatrange(var_00.frenzied_meteor_min_period,var_00.frenzied_meteor_max_period));
	}
}

//Function Number: 77
frenzydamagecap()
{
	self endon("death");
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = var_00.frenzied_damage_cap_time;
	for(;;)
	{
		self.damagecap = self.maxdamagecap;
		wait(var_01);
	}
}

//Function Number: 78
dropmove_begin(param_00)
{
	func_F8A3(param_00,"drop_move");
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"drop_move","drop_move_arrival",undefined,undefined,undefined,2000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"drop_move");
	self playsound("final_meph_eclipse");
	self.interruptable = 0;
}

//Function Number: 79
dropmove_tick(param_00)
{
	self method_841F();
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 80
dropmove_end(param_00)
{
	func_4045("drop_move");
	self.interruptable = 1;
}

//Function Number: 81
computespawnpoints(param_00,param_01)
{
	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_03 = getrandomnavpoints(self.arenacenter,var_02.summon_max_radius,32);
	var_02.var_108FB = [];
	for(var_04 = 0;var_04 < 10;var_04++)
	{
		foreach(var_06 in var_03)
		{
			if(pointnearanyplayer(var_06,var_02.summon_min_dist_from_player))
			{
				continue;
			}

			if(isnearanypointinarray(var_06,var_02.var_108FB,var_02.summon_min_radius))
			{
				continue;
			}

			if(isnearagents(var_06,param_01,var_02.summon_min_radius))
			{
				continue;
			}

			var_02.var_108FB[var_02.var_108FB.size] = var_06;
			if(var_02.var_108FB.size >= param_00)
			{
				return 1;
			}
		}
	}

	return var_02.var_108FB.size > 0;
}

//Function Number: 82
flyover_begin(param_00)
{
	var_01 = self method_80FD("fly_over_arrival",0);
	self.var_1198.flyoverarrivaldist = length2d(getmovedelta(var_01,0,1)) * scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_speed;
	func_F8A3(param_00,"fly_over");
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"fly_over","fly_over_arrival",undefined,undefined,undefined,10000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"fly_over");
	thread stop_flame_trail(3.5);
	self.interruptable = 0;
}

//Function Number: 83
stop_flame_trail(param_00)
{
	wait(1);
	self setscriptablepartstate("flame_trail","on");
	wait(param_00);
	self setscriptablepartstate("flame_trail","off");
}

//Function Number: 84
flyover_tick(param_00)
{
	return scripts\common\utility::func_116D7(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00),level.var_E87A,level.var_111AE);
}

//Function Number: 85
flyover_end(param_00)
{
	self.var_1198.var_4BF7 = self.var_1198.desirednode;
	func_4045("fly_over");
	self.interruptable = 1;
}

//Function Number: 86
teleport_begin(param_00)
{
	func_F8A3(param_00,"teleport");
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"teleport","teleport_out",undefined,undefined,undefined,10000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"teleport");
}

//Function Number: 87
teleport_tick(param_00)
{
	return scripts\common\utility::func_116D7(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00),level.var_E87A,level.var_111AE);
}

//Function Number: 88
teleport_end(param_00)
{
	func_4045("teleport");
}

//Function Number: 89
death_begin(param_00)
{
	func_F8A3(param_00,"death");
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"death","death_death",undefined,undefined,undefined,10000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"death");
}

//Function Number: 90
death_tick(param_00)
{
	return scripts\common\utility::func_116D7(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00),level.var_E87A,level.var_111AE);
}

//Function Number: 91
death_end(param_00)
{
	func_4045("death");
}

//Function Number: 92
eclipse_begin(param_00)
{
	level.var_1096B = 3;
	if(level.players.size >= 3)
	{
		level.var_1096B = 5;
	}

	func_F8A3(param_00,"eclipse");
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,"eclipse","eclipse",undefined,undefined,undefined,10000000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,"eclipse");
	self.eclipseanimfinished = 0;
}

//Function Number: 93
eclipse_tick(param_00)
{
	if(!scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		self.eclipseanimfinished = 1;
	}

	return scripts\common\utility::func_116D7(self.eclipseanimfinished && !self.eclipseactive,level.var_111AE,level.var_E87A);
}

//Function Number: 94
eclipse_end(param_00)
{
	func_4045("eclipse");
	self.eclipseanimfinished = undefined;
	scripts\cp\maps\cp_final\cp_final_final_boss::setupfornextwave();
	setnextaction(self.unlockedactions[self.unlockedactions.size - 1]);
	self.automaticspawn = 1;
}

//Function Number: 95
clearweights()
{
	if(!isdefined(self.bossactions))
	{
		return;
	}

	foreach(var_01 in self.bossactions)
	{
		var_01.var_13CE8 = 0;
	}
}

//Function Number: 96
setweight(param_00,param_01)
{
	if(!isdefined(self.bossactions))
	{
		return;
	}

	foreach(var_03 in self.bossactions)
	{
		if(var_03.name == param_00)
		{
			var_03.var_13CE8 = param_01;
		}
	}
}

//Function Number: 97
updateweights()
{
	clearweights();
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = self.unlockedactions.size;
	var_02 = self.bossactionsstruct;
	var_02["move_left"].var_13CE8 = var_00.move_base_weight / 2 + var_01 * var_00.move_stage_multiplier;
	var_02["move_right"].var_13CE8 = var_02["move_left"].var_13CE8;
	var_02["temp_idle"].var_13CE8 = var_00.idle_base_weight + var_01 * var_00.idle_stage_multiplier;
	var_02["drop_move"].var_13CE8 = var_00.drop_move_base_weight + var_01 * var_00.drop_move_stage_multiplier;
	var_02["fireball"].var_13CE8 = var_00.fireball_base_weight + var_01 * var_00.fireball_stage_multiplier;
	var_02["move_fireball_left"].var_13CE8 = var_00.move_fireball_base_weight / 2 + var_01 * var_00.move_fireball_stage_multiplier;
	var_02["move_fireball_right"].var_13CE8 = var_02["move_fireball_left"].var_13CE8;
	var_02["summon"].var_13CE8 = var_00.summon_base_weight + var_01 * var_00.summon_stage_multiplier;
	var_03 = var_00.black_hole_base_weight;
	var_03 = var_03 + var_01 * var_00.black_hole_stage_multiplier;
	var_03 = var_03 + level.fbd.numplayerschargingcircle * var_00.black_hole_charge_multiplier;
	var_02["black_hole"].var_13CE8 = var_03;
	var_02["fly_over"].var_13CE8 = var_00.fly_over_base_weight + var_01 * var_00.fly_over_stage_multiplier;
	foreach(var_05 in self.unlockedactions)
	{
		var_02[var_05].var_13CE8 = var_00.special_base_weight + var_01 * var_00.special_stage_multiplier;
	}
}

//Function Number: 98
setnextaction(param_00)
{
	foreach(var_02 in self.bossactions)
	{
		self.weightcopies[var_02.name] = var_02.var_13CE8;
		var_02.var_13CE8 = 0;
		if(var_02.name == param_00)
		{
			var_02.var_13CE8 = 1;
		}
	}

	self.forcingaction = 1;
}

//Function Number: 99
restoreweights()
{
	foreach(var_01 in self.bossactions)
	{
		var_01.var_13CE8 = self.weightcopies[var_01.name];
	}

	self.forcingaction = 0;
}

//Function Number: 100
func_593B()
{
}

//Function Number: 101
func_F8A3(param_00,param_01)
{
	self method_8287(100000000);
	self method_841F();
	scripts\asm\dlc4\dlc4_asm::setasmaction(param_01);
}

//Function Number: 102
func_4045(param_00)
{
	self method_841F();
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	self notify(param_00 + "_done");
}

//Function Number: 103
pointnearanyplayer(param_00,param_01)
{
	var_02 = param_01 * param_01;
	foreach(var_04 in level.players)
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

		if(distancesquared(param_00,var_04.origin) < var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 104
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

//Function Number: 105
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

//Function Number: 106
resettimer(param_00,param_01)
{
	if(!isdefined(self.bossactions))
	{
		return 0;
	}

	foreach(var_03 in self.bossactions)
	{
		if(var_03.name == param_00)
		{
			var_03.var_11910 = param_01;
			return 1;
		}
	}

	return 0;
}

//Function Number: 107
simplesetup_begin(param_00)
{
	func_F8A3(param_00,self.simplesetupstartstate);
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,self.simplesetupstartstate,self.simplesetupendstate,undefined,undefined,undefined,100000);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,self.simplesetupstartstate);
}

//Function Number: 108
simplesetup_tick(param_00)
{
	if(scripts\asm\dlc4_boss\dlc4_boss_asm::shouldterminateaction())
	{
		return level.var_111AE;
	}

	return scripts\common\utility::func_116D7(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00),level.var_E87A,level.var_111AE);
}

//Function Number: 109
simplesetup_end(param_00)
{
	func_4045(self.simplesetupstartstate);
}

//Function Number: 110
resetsoulhealth(param_00)
{
	self.soulhealth = ceil(scripts\asm\dlc4\dlc4_asm::gettunedata().max_soul_health * level.players.size * pow(0.9,level.players.size - 1));
}