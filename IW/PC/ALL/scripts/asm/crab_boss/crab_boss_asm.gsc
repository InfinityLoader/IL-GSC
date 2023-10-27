/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\crab_boss\crab_boss_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 76
 * Decompile Time: 4025 ms
 * Timestamp: 10/27/2023 12:01:25 AM
*******************************************************************/

//Function Number: 1
asminit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	if(!isdefined(level.crab_boss_arrival_data))
	{
		analyzecrabbossmovement();
	}
}

//Function Number: 2
analyzecrabbossmovement()
{
	level.crab_boss_arrival_data = [];
	level.crab_boss_move_data = [];
	for(var_00 = 1;var_00 <= 9;var_00++)
	{
		if(var_00 == 5)
		{
			continue;
		}

		var_01 = var_00;
		var_02 = lib_0A1A::func_2358("move_arrival",var_01);
		var_03 = self method_80FD("move_arrival",var_02);
		var_04 = getmovedelta(var_03,0,1);
		level.crab_boss_arrival_data[var_00] = var_04;
		level.crab_boss_arrival_time[var_00] = getanimlength(var_03);
		var_01 = var_00;
		var_02 = lib_0A1A::func_2358("move_loop",var_01);
		var_03 = self method_80FD("move_loop",var_02);
		var_04 = getmovedelta(var_03,0,1);
		level.crab_boss_move_data[var_00] = var_04;
		level.crab_boss_move_time[var_00] = getanimlength(var_03);
		var_02 = lib_0A1A::func_2358("move_exit",var_01);
		var_03 = self method_80FD("move_exit",var_02);
		var_04 = getmovedelta(var_03,0,1);
		level.crab_boss_exit_data[var_00] = var_04;
		level.crab_boss_exit_time[var_00] = getanimlength(var_03);
	}
}

//Function Number: 3
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "heal":
		case "move":
		case "toxic_spawn":
		case "smash_interrupted":
		case "beam_interrupted":
		case "submerge_bomb":
		case "submerge_spawn":
		case "turn":
		case "submerge":
		case "emerge":
		case "toxic":
		case "roar":
		case "beam":
		case "taunt":
		case "smash":
		case "pain":
		case "bomb":
		case "spawn":
		case "death":
			return 1;
	}

	return 0;
}

//Function Number: 4
setaction(param_00)
{
	self.requested_action = param_00;
}

//Function Number: 5
clearaction()
{
	self.requested_action = undefined;
}

//Function Number: 6
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return !scripts\common\utility::istrue(self.shouldabortentranceanim);
}

//Function Number: 7
isanimdone(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_232B(param_01,"end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"early_end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"finish_early"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
playbeamanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 9
stopcrabbossbeam()
{
	self notify("stop_beam");
	self.beamtargetpos = undefined;
	self.beamtargetdest = undefined;
}

//Function Number: 10
isbeamdone(param_00,param_01,param_02,param_03)
{
	return isanimdone(param_00,param_01,param_02,param_03);
}

//Function Number: 11
launchegg(param_00,param_01,param_02)
{
	var_03 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	if(scripts\common\utility::istrue(param_02))
	{
		scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(param_00,param_01,var_03.egg_sac_spawn_fly_time,0);
		return;
	}

	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(param_00,param_01,var_03.egg_sac_spawn_fly_time,1);
}

//Function Number: 12
doroarbomb()
{
	foreach(var_01 in level.players)
	{
		thread doroarbombnearplayer(var_01,self);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
doroarbombnearplayer(param_00,param_01)
{
	var_02 = getroarbombloc(param_00,param_01);
	foreach(var_04 in var_02)
	{
		var_05 = geteggsaclaunchpos();
		var_06 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
		scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_05,var_04,var_06.roar_bomb_fly_time,0);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 14
getroarbombloc(param_00,param_01)
{
	var_02 = [];
	if(players_commit_to_the_run() && level.players.size == 1)
	{
		var_02[var_02.size] = param_00.origin;
	}

	var_03 = vectortoangles(param_01.origin - param_00.origin);
	var_02[var_02.size] = gettargetbombloc(param_00.origin,var_03,30 + randomintrange(-5,5),adjust_roar_bomb_dist(145) + randomintrange(5,10));
	var_02[var_02.size] = gettargetbombloc(param_00.origin,var_03,-30 + randomintrange(-5,5),adjust_roar_bomb_dist(145) + randomintrange(5,10));
	var_02[var_02.size] = gettargetbombloc(param_00.origin,var_03,0 + randomintrange(-5,5),adjust_roar_bomb_dist(300) + randomintrange(5,10));
	return var_02;
}

//Function Number: 15
adjust_roar_bomb_dist(param_00)
{
	if(!players_commit_to_the_run())
	{
		return 1000;
	}

	var_01 = 35;
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_04))
		{
			continue;
		}

		var_02++;
	}

	return param_00 - var_02 - 1 * var_02;
}

//Function Number: 16
players_commit_to_the_run()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_02))
		{
			continue;
		}

		if(var_02.origin[1] > 1200)
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 17
gettargetbombloc(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 + (0,param_02,0);
	var_05 = anglestoforward(var_04);
	return param_00 + var_05 * param_03;
}

//Function Number: 18
playroarloop(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1D::func_235F(param_00,param_01,param_02,param_03);
}

//Function Number: 19
playroarend(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	self notify("roar_done");
}

//Function Number: 20
dospawnsovertime(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self endon("stop_spawns_over_time");
	var_02 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	var_03 = scripts\common\utility::array_randomize(var_02.egg_sack_launching_tags);
	var_04 = scripts\common\utility::array_randomize(self.spawnposarray);
	self.numofspawnrequested = self.spawnposarray.size;
	for(var_05 = 0;var_05 < self.numofspawnrequested;var_05++)
	{
		var_06 = var_05 % var_03.size;
		var_07 = var_05 % var_04.size;
		var_08 = self gettagorigin(var_03[var_06]);
		var_09 = var_04[var_07];
		launchegg(var_08,var_09,param_01);
		wait(randomfloatrange(var_02.spawn_interval_min,var_02.spawn_interval_max));
	}

	self.numofspawnrequested = 0;
}

//Function Number: 21
stopspawnsovertime()
{
	self notify("stop_spawns_over_time");
}

//Function Number: 22
func_5AAE()
{
	var_00 = ["j_thumb_ri_3","j_thumb_le_3"];
	foreach(var_02 in var_00)
	{
		level thread trycrabbosssmashattack(var_02,self);
	}
}

//Function Number: 23
trycrabbosssmashattack(param_00,param_01)
{
	var_02 = 300;
	var_03 = 10;
	var_04 = 250;
	var_05 = 0.2;
	var_06 = 300;
	var_07 = 80;
	var_08 = param_01 gettagorigin(param_00);
	var_09 = bullettrace(var_08,var_08 + (0,0,var_02 * -1),0,param_01)["position"];
	var_0A = param_01.angles;
	if(distancesquared(var_08,var_09) > var_02 * var_02)
	{
		return;
	}

	earthquake(0.5,3,var_08,5000);
	for(var_0B = 0;var_0B <= var_03;var_0B++)
	{
		var_0C = scripts\common\utility::func_5D14(param_01.origin + anglestoforward(var_0A) * var_04 * var_0B,1000,-3000);
		if(var_0B == 0)
		{
			playfx(level._effect["claw_trail"],var_0C);
		}
		else
		{
			playfx(level._effect["claw_trail_sand"],var_0C);
		}

		earthquake(0.8,1,var_0C,var_06);
		foreach(var_0E in level.players)
		{
			if(distancesquared(var_0E.origin,var_0C) < var_06 * var_06)
			{
				var_0E dodamage(var_07,var_0C);
			}
		}

		wait(var_05);
	}
}

//Function Number: 24
dogas()
{
	self endon("stop_gas");
	scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::activate_toxic_patch_and_trigger(level.crab_boss_toxic_attack_index);
}

//Function Number: 25
endgas()
{
	self notify("stop_gas");
}

//Function Number: 26
crabbossnotehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "spawn_group":
			break;

		case "start_sonic_beam":
			thread startsonicbeam();
			break;

		case "stop_sonic_beam":
			thread stopsonicbeam();
			break;

		case "roar_launch_bomb":
			thread doroarbomb();
			break;

		case "footstep_right_large":
			thread dorightfootstep(1);
			break;

		case "footstep_right_small":
			thread dorightfootstep(0);
			break;

		case "footstep_left_large":
			thread doleftfootstep(1);
			break;

		case "footstep_left_small":
			thread doleftfootstep(0);
			break;

		case "debris_vfx_1":
			thread dodebrisvfx_1();
			break;

		case "debris_vfx_2":
			thread dodebrisvfx_2();
			break;

		case "debris_vfx_3":
			thread dodebrisvfx_3();
			break;

		case "roar_loop_end":
			self.roar_loops--;
			if(self.roar_loops == 0)
			{
				self.roar_loops = undefined;
				lib_0A1A::func_2330(param_01,"roar_done");
			}
			break;

		case "spawn_start":
			thread dospawnsovertime(param_01);
			break;

		case "spawn_end":
			stopspawnsovertime();
			break;

		case "smash":
			func_5AAE();
			break;

		case "gas_start":
			thread dogas();
			break;

		case "gas_end":
			endgas();
			break;
	}
}

//Function Number: 27
dodebrisvfx_1()
{
	playfx(level._effect["food_search_debris"],self gettagorigin("tag_mouth"));
}

//Function Number: 28
dodebrisvfx_2()
{
	playfx(level._effect["food_search_debris"],self gettagorigin("tag_mouth"));
}

//Function Number: 29
dodebrisvfx_3()
{
	playfx(level._effect["food_search_debris"],self gettagorigin("tag_mouth"));
}

//Function Number: 30
dorightfootstep(param_00)
{
	if(scripts\common\utility::istrue(param_00))
	{
		earthquake(0.3,1,self.origin,7000);
	}

	var_01 = self gettagorigin("j_ball_ri");
	var_01 = bullettrace(var_01 + (0,0,1000),var_01,0,self)["position"];
	playfx(level._effect["leg_splashes_heavy"],var_01);
}

//Function Number: 31
doleftfootstep(param_00)
{
	if(scripts\common\utility::istrue(param_00))
	{
		earthquake(0.3,1,self.origin,7000);
	}

	var_01 = self gettagorigin("j_ball_le");
	var_01 = bullettrace(var_01 + (0,0,1000),var_01,0,self)["position"];
	playfx(level._effect["leg_splashes_heavy"],var_01);
}

//Function Number: 32
submerge_spawn_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "shoot_egg_sac_spawn":
			thread dosubmergespawn_asm(param_01);
			break;
	}
}

//Function Number: 33
toxic_spawn_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "gas_start":
			thread dogas();
			break;

		case "gas_end":
			endgas();
			break;
	}
}

//Function Number: 34
submerge_bomb_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "shoot_egg_sac_bomb":
			thread dosubmergebomb_asm(param_01);
			break;
	}
}

//Function Number: 35
bomb_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "calculate_target_pos":
			thread calculatetargetpos();
			break;

		case "spawn_start":
			thread dospawnsovertime(param_01,1);
			break;

		case "spawn_end":
			stopspawnsovertime();
			break;
	}
}

//Function Number: 36
calculatetargetpos()
{
	var_00 = self.bomb_target.origin;
	var_01 = getbombingradius();
	var_02 = getnumofbombs();
	var_03 = [];
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		var_05 = randomfloatrange(var_01 * -1,var_01);
		var_06 = randomfloatrange(var_01 * -1,var_01);
		var_03[var_04] = getclosestpointonnavmesh((var_00[0] + var_05,var_00[1] + var_06,var_00[2]));
	}

	self.spawnposarray = var_03;
}

//Function Number: 37
getbombingradius()
{
	var_00 = 100;
	if(isdefined(self.bombing_radius))
	{
		return self.bombing_radius;
	}

	return var_00;
}

//Function Number: 38
getnumofbombs()
{
	var_00 = 10;
	if(isdefined(self.num_of_bombs))
	{
		return self.num_of_bombs;
	}

	return var_00;
}

//Function Number: 39
dobeamattackposition(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self endon("stop_beam");
	var_02 = 2;
	var_03 = 200;
	var_04 = 80;
	self.var_1C2 = param_01;
	var_05 = var_02 * 20;
	playfx(level._effect["crab_boss_beam_impact_buildup"],param_01);
	var_06 = self gettagorigin("tag_laser");
	level thread crab_boss_lure_beam_sfx(var_06,param_01);
	for(var_07 = 0;var_07 < var_05;var_07++)
	{
		var_08 = self gettagorigin("tag_laser");
		function_02E0(level._effect["crab_boss_beam_attack"],var_08,vectortoangles(param_01 - var_08),param_01);
		scripts\common\utility::func_136F7();
	}

	level notify("stop_lure_beam_sfx");
	playfx(level._effect["crab_boss_beam_impact"],param_01);
	earthquake(0.7,1,param_01,var_03);
	foreach(var_0A in level.players)
	{
		if(distancesquared(var_0A.origin,param_01) < var_03 * var_03)
		{
			var_0A dodamage(var_04,param_01);
		}
	}
}

//Function Number: 40
crab_boss_lure_beam_sfx(param_00,param_01)
{
	var_02 = param_01 - param_00;
	var_03 = param_01 + var_02 * 0.3333333;
	var_04 = param_01 + var_02 * 0.6666667;
	var_05 = param_01 + var_02 * 0.5;
	level thread scripts\common\utility::play_sound_in_space("town_weap_beam_fire_npc_start",param_00);
	level.boss_beam_lure_loop_sfx = scripts\common\utility::play_loopsound_in_space("town_weap_beam_fire_npc_loop",param_00);
	level.boss_beam_lure_loop_sfx_1 = scripts\common\utility::play_loopsound_in_space("town_weap_beam_fire_npc_loop",var_05);
	level.boss_beam_lure_loop_sfx_2 = scripts\common\utility::play_loopsound_in_space("town_weap_apex_beam_fire_npc_loop",param_01);
	level waittill("stop_lure_beam_sfx");
	level thread scripts\common\utility::play_sound_in_space("town_weap_beam_fire_npc_end",param_00);
	level scripts\common\utility::play_sound_in_space("town_frag_grenade_explode",param_01);
	wait(0.15);
	level.boss_beam_lure_loop_sfx stoploopsound();
	level.boss_beam_lure_loop_sfx delete();
	level.boss_beam_lure_loop_sfx_1 stoploopsound();
	level.boss_beam_lure_loop_sfx_1 delete();
	level.boss_beam_lure_loop_sfx_2 stoploopsound();
	level.boss_beam_lure_loop_sfx_2 delete();
}

//Function Number: 41
beam_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "beam_start":
			thread dobeamattackposition(param_01,self.beamattacktarget.origin);
			break;

		case "beam_end":
			stopcrabbossbeam();
			break;

		case "show_weak_spot":
			thread showweakspot();
			break;

		case "hide_weak_spot":
			thread hideweakspot();
			break;

		case "interruptable_start":
			self.binterruptable = 1;
			break;

		case "interruptable_end":
			self.binterruptable = undefined;
			break;

		case "start_beam_fx":
			if(!scripts\common\utility::istrue(self.bbeamfxstarted))
			{
				var_04 = self gettagorigin("tag_laser");
				thread scripts\common\utility::play_sound_in_space("boss_crog_lure_build_up",var_04);
				playfxontag(scripts\common\utility::getfx("boss_crab_beam_start_fx"),self,"tag_laser");
				self.bbeamfxstarted = 1;
			}
			break;

		case "stop_beam_fx":
			self.bbeamfxstarted = undefined;
			stopfxontag(scripts\common\utility::getfx("boss_crab_beam_start_fx"),self,"tag_laser");
			break;
	}
}

//Function Number: 42
smash_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "show_weak_spot":
			thread showweakspot();
			break;

		case "hide_weak_spot":
			thread hideweakspot();
			break;

		case "interruptable_start":
			self.binterruptable = 1;
			break;

		case "interruptable_end":
			self.binterruptable = undefined;
			break;

		case "smash":
			thread func_5AAE();
			break;
	}
}

//Function Number: 43
dosubmergespawn_asm(param_00)
{
	var_01 = geteggsaclaunchpos();
	var_02 = self.spawnposarray[self.numofspawnrequested - 1];
	var_03 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(var_01,var_02,var_03.egg_sac_spawn_fly_time,1,vectortoangles(var_02 - var_01 * (1,1,0)));
	self.numofspawnrequested--;
}

//Function Number: 44
dosubmergebomb_asm(param_00)
{
	if(self.numofbombrequested <= 0)
	{
		return;
	}

	var_01 = geteggsaclaunchpos();
	var_02 = 0;
	if(isdefined(self.submergebombspawnindex) && scripts\common\utility::func_2286(self.submergebombspawnindex,self.numofbombrequested))
	{
		var_02 = 1;
	}

	thread launchonebomb(var_01,var_02);
}

//Function Number: 45
dotoxicspawn_asm(param_00)
{
	var_01 = geteggsaclaunchpos();
	thread launchtoxicspawn(var_01);
}

//Function Number: 46
showweakspot()
{
	if(isdefined(self.crab_boss_weak_spot))
	{
		self.crab_boss_weak_spot show();
		self.crab_boss_weak_vfx setscriptablepartstate("weak_spot","on");
	}
}

//Function Number: 47
hideweakspot()
{
	if(scripts\common\utility::istrue(self.reveal_weak_spot))
	{
		return;
	}

	if(isdefined(self.crab_boss_weak_spot))
	{
		self.crab_boss_weak_spot hide();
		self.crab_boss_weak_vfx setscriptablepartstate("weak_spot","off");
	}
}

//Function Number: 48
launchtoxicspawn(param_00)
{
	if(self.numofspawnrequested == 0)
	{
		return;
	}

	var_01 = self.spawnposarray[self.numofspawnrequested - 1 % self.spawnposarray.size];
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	var_04 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(param_00,var_02,var_04.egg_sac_toxic_spawn_fly_time,1,var_03);
	self.numofspawnrequested--;
}

//Function Number: 49
launchonebomb(param_00,param_01)
{
	var_02 = self.bombposarray[self.numofbombrequested - 1];
	var_03 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::launch_egg_sac(param_00,var_02,var_03.egg_sac_bomb_fly_time,param_01);
	self.numofbombrequested--;
}

//Function Number: 50
geteggsaclaunchpos()
{
	if(!isdefined(self.eggsaclaunchtagcounter))
	{
		self.eggsaclaunchtagcounter = 0;
	}

	var_00 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	var_01 = var_00.egg_sack_launching_tags;
	var_02 = var_01[self.eggsaclaunchtagcounter % var_01.size];
	self.eggsaclaunchtagcounter++;
	return self gettagorigin(var_02);
}

//Function Number: 51
shouldabortaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 1;
	}

	if(isdefined(param_03))
	{
		if(self.requested_action != param_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 52
shoulddoaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(self.requested_action == param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 54
chooseidleanim(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.blookatplayer))
	{
		return 0;
	}

	return lib_0A1A::func_2358(param_01,"idle");
}

//Function Number: 55
choosecrabbossturnanim(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = abs(self.desiredyaw);
	if(self.desiredyaw < 0)
	{
		if(var_04 < 67.5)
		{
			var_03 = 9;
		}
		else
		{
			var_03 = 6;
		}
	}
	else if(var_04 < 67.5)
	{
		var_03 = 7;
	}
	else
	{
		var_03 = 4;
	}

	var_05 = lib_0A1A::func_2358(param_01,var_03);
	var_06 = self method_80FD(param_01,var_05);
	var_07 = getangledelta(var_06,0,1);
	self.additionalyaw = self.desiredyaw - var_07;
	self.desiredyaw = undefined;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 56
shouldturn(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.desiredyaw))
	{
		return 0;
	}

	return 1;
}

//Function Number: 57
handleadditionalyaw(param_00,param_01)
{
	self endon(param_00 + "_finished");
	var_02 = self.additionalyaw / param_01;
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_04 = self.angles[1];
		var_04 = var_04 + var_02;
		var_05 = (self.angles[0],var_04,self.angles[2]);
		self method_8289("face angle abs",var_05);
		scripts\common\utility::func_136F7();
	}

	self.additionalyaw = undefined;
}

//Function Number: 58
playcrabbossturnanim(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getanimlength(var_05);
	if(isdefined(self.additionalyaw))
	{
		thread handleadditionalyaw(param_01,ceil(var_06 * 20));
	}

	return lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 59
playcrabbossemergeanim(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_2364(param_00,param_01,param_02);
	self notify("emerge_complete");
}

//Function Number: 60
healme(param_00)
{
	self.bhealing = 1;
	wait(param_00);
	self.bhealing = undefined;
}

//Function Number: 61
loophealanim(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\agents\crab_boss\crab_boss_tunedata::gettunedata();
	thread healme(var_04.heal_duration);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 62
isdonehealing(param_00,param_01,param_02,param_03)
{
	if(!scripts\common\utility::istrue(self.bhealing))
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
choosecrabbossmoveanim(param_00,param_01,param_02)
{
	var_03 = self.currentmovedirindex;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 64
playmovearrival(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.desiredbossmovepos))
	{
		var_04 = lib_0A1D::func_2337(param_00,param_01);
		var_05 = self method_80FD(param_01,var_04);
		thread applyallmotiontowards(param_01,self.desiredbossmovepos,var_05,self.moveloopscale);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 65
applyallmotiontowards(param_00,param_01,param_02,param_03)
{
	self endon(param_00 + "_finished");
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = 0;
	var_05 = getanimlength(param_02);
	while(var_04 < var_05)
	{
		var_06 = var_04 / var_05;
		var_07 = var_04 + 0.05 / var_05;
		if(var_07 > 1)
		{
			var_04 = 0;
			var_06 = 0;
			var_07 = var_06 + 0.05;
		}

		var_08 = getmovedelta(param_02,var_06,var_07);
		var_09 = length2d(var_08) * param_03;
		var_0A = vectornormalize(param_01 - self.origin);
		var_0B = self.origin + var_0A * var_09;
		self setorigin(var_0B,0);
		wait(0.05);
		var_04 = var_04 + 0.05;
	}
}

//Function Number: 66
playmoveexit(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.desiredbossmovepos))
	{
		var_04 = lib_0A1D::func_2337(param_00,param_01);
		var_05 = self method_80FD(param_01,var_04);
		thread applyallmotiontowards(param_01,self.desiredbossmovepos,var_05,self.moveloopscale);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 67
loopcrabbossmoveanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(isdefined(self.desiredbossmovepos))
	{
		var_04 = lib_0A1D::func_2337(param_00,param_01);
		var_05 = self method_80FD(param_01,var_04);
		thread applyallmotiontowards(param_01,self.desiredbossmovepos,var_05,self.moveloopscale);
	}

	var_06 = self.movedircount;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		var_08 = lib_0A1D::func_2337(param_00,param_01);
		self method_82AF(param_01,var_08);
		scripts\mp\agents\_scriptedagents::func_1384C(param_01,"end",param_01,var_08,::crabbossnotehandler);
	}

	clearaction();
}

//Function Number: 68
choosecrabbossarrivalanim(param_00,param_01,param_02)
{
	var_03 = self.currentmovedirindex;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 69
func_3EE4(param_00,param_01,param_02)
{
	if(!isdefined(self.painalias))
	{
		var_03 = self method_8100(param_01);
		return randomint(var_03);
	}

	return lib_0A1A::func_2358(param_02,self.painalias);
}

//Function Number: 70
choosesmashanim(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	var_04 = randomint(var_03);
	self.smashanimindex = var_04;
	return var_04;
}

//Function Number: 71
choosesmashinterruptedanim(param_00,param_01,param_02)
{
	var_03 = self.smashanimindex;
	self.smashanimindex = undefined;
	return var_03;
}

//Function Number: 72
toxicspawn_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "spawn_group":
			thread dogroupspawn();
			break;
	}
}

//Function Number: 73
dogroupspawn()
{
	var_00 = self.numofspawnrequested;
	for(var_01 = 1;var_01 <= var_00;var_01++)
	{
		var_02 = geteggsaclaunchpos();
		thread launchtoxicspawn(var_02);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 74
startsonicbeam()
{
	level thread scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring::activate_sonic_ring(self);
}

//Function Number: 75
stopsonicbeam()
{
}

//Function Number: 76
choosetauntanim(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(level.crab_boss_random_taunt_anim))
	{
		return lib_0F3C::func_3E96(param_00,param_01);
	}

	return lib_0F3C::func_3E96(param_00,param_01,"taunt");
}