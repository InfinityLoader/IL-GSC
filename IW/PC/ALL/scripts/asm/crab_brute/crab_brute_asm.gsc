/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\crab_brute\crab_brute_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 2218 ms
 * Timestamp: 10/27/2023 12:01:29 AM
*******************************************************************/

//Function Number: 1
asminit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	self.var_71D0 = ::shouldbruteplaypainanim;
}

//Function Number: 2
shouldbruteplaypainanim()
{
	if(isdefined(self.bforceallowpain) && self.bforceallowpain)
	{
		return 1;
	}

	return lib_0C75::func_1004F();
}

//Function Number: 3
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "flash":
		case "summon":
		case "tired":
		case "charge":
		case "burrow":
		case "taunt":
		case "melee_attack":
			return 1;
	}

	return 0;
}

//Function Number: 4
setaction(param_00)
{
	self.requested_action = param_00;
	self.current_action = undefined;
}

//Function Number: 5
clearaction()
{
	self.requested_action = undefined;
	self.current_action = undefined;
}

//Function Number: 6
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 7
playanimandlookatenemy(param_00,param_01,param_02,param_03)
{
	thread lib_0C73::func_6A6A(param_01,scripts\mp\agents\crab_brute\crab_brute_agent::getenemy());
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 8
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

//Function Number: 9
summonnotehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "flash":
			dosummon();
			break;
	}
}

//Function Number: 10
crabbrutenotehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "flash":
			doflash();
			break;

		case "fx_playfxontag, vfx/iw7/levels/cp_town/crog/vfx_brute_burrow_down.vfx, tag_origin":
			thread starting_burrow_sfx(param_01);
			break;

		case "fx_playfxontag, vfx/iw7/levels/cp_town/crog/vfx_brute_flash_build.vfx, j_lure_5":
			thread starting_flash_sfx();
			break;
	}
}

//Function Number: 11
starting_burrow_sfx(param_00)
{
	if(param_00 == "burrow_intro")
	{
		thread scripts\common\utility::play_sound_in_space("brute_burrow_in_ground",self.origin + (0,0,30));
		var_01 = 1;
	}
}

//Function Number: 12
starting_flash_sfx()
{
	thread scripts\common\utility::play_sound_in_space("brute_crog_build_up_to_flash",self.origin + (0,0,80));
}

//Function Number: 13
dosummonfromfakecrabboss(param_00)
{
	self.spawnposarray = param_00;
	self.numofspawnrequested = self.spawnposarray.size;
	thread scripts\asm\crab_boss\crab_boss_asm::dospawnsovertime("none",0);
}

//Function Number: 14
dosummon()
{
	self setscriptablepartstate("lure_fx","summon");
	if(isdefined(level.crab_boss))
	{
		scripts\cp\zombies\cp_town_spawning::brute_goon_summon();
	}
}

//Function Number: 15
doflash()
{
	var_00 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
	foreach(var_02 in level.players)
	{
		if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_02))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.isfasttravelling))
		{
			continue;
		}

		var_03 = distance2dsquared(self.origin,var_02.origin);
		if(var_03 > var_00.flash_radius_sq)
		{
			continue;
		}

		var_04 = var_02 getplayerangles();
		var_05 = anglestoforward(var_04);
		var_06 = vectornormalize(self.origin - var_02.origin * (1,1,0));
		var_07 = vectordot(var_05,var_06);
		if(var_07 < var_00.flash_dot)
		{
			continue;
		}

		var_08 = scripts\common\trace::func_48CC(1);
		if(scripts\common\trace::func_DCF1(self geteye(),var_02 geteye(),var_02,var_08))
		{
			var_02 func_20CA(var_00.flash_duration,var_00.flash_rumble_duration);
		}
	}
}

//Function Number: 16
func_20CA(param_00,param_01)
{
	if(!isdefined(self.var_6EC8) || param_00 > self.var_6EC8)
	{
		self.var_6EC8 = param_00;
	}

	if(!isdefined(self.var_6EDB) || param_01 > self.var_6EDB)
	{
		self.var_6EDB = param_01;
	}

	wait(0.05);
	if(isdefined(self.var_6EC8))
	{
		self shellshock("flashbang_mp",self.var_6EC8);
		self.var_6ECA = gettime() + self.var_6EC8 * 1000;
	}

	if(isdefined(self.var_6EDB))
	{
		thread func_6EDC(self.var_6EDB);
	}

	self.var_6EC8 = undefined;
	self.var_6EDB = undefined;
}

//Function Number: 17
func_6EDC(param_00)
{
	self endon("stop_monitoring_flash");
	self endon("flash_rumble_loop");
	self notify("flash_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 18
meleenotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
		if(isdefined(var_04))
		{
			if(distancesquared(var_04.origin,self.origin) < -25536)
			{
				self notify("attack_hit",var_04);
				lib_0C73::func_5904(var_04,self.var_B601,"MOD_IMPACT");
			}
			else
			{
				self notify("attack_miss",var_04);
			}
		}

		if(!scripts\common\utility::istrue(self.bmovingmelee))
		{
			self notify("stop_melee_face_enemy");
		}
	}
}

//Function Number: 19
shouldabortaction(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		return 0;
	}

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

//Function Number: 20
shoulddoaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(self.requested_action == param_02)
	{
		if(isdefined(self.current_action) && self.current_action == param_02)
		{
			return 0;
		}

		self.current_action = param_02;
		return 1;
	}

	return 0;
}

//Function Number: 21
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	if(param_01 == "burrow_loop")
	{
		thread play_burrow_loop_sfx();
	}

	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 22
play_burrow_loop_sfx()
{
	if(isdefined(self.burrow_loop_obj))
	{
		return;
	}

	var_00 = self gettagorigin("j_lure_5",1);
	if(isdefined(var_00))
	{
		self.burrow_loop_obj = spawn("script_origin",var_00);
		self.burrow_loop_obj linkto(self,"j_lure_5");
		self.burrow_loop_obj playloopsound("brute_crog_move_underground_lp");
	}
}

//Function Number: 23
playmeleeattack(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
}

//Function Number: 24
choosemeleeattack(param_00,param_01,param_02)
{
	var_03 = self.var_4B26;
	if(!isdefined(var_03))
	{
		var_03 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
	}

	var_04 = 0;
	if(isdefined(var_03))
	{
		var_04 = length(var_03 getvelocity());
	}

	if(lib_0A1B::func_2955() || var_04 > 0)
	{
		var_05 = lib_0A1A::func_2358(param_01,"attack_moving");
	}
	else
	{
		var_05 = lib_0A1A::func_2358(param_02,"attack");
	}

	return var_05;
}

//Function Number: 25
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 26
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233) || self method_841E() < scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata().min_moving_pain_dist)
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,1);
		return;
	}

	lib_0A1D::func_2364(param_01,param_02,param_03,var_04);
}

//Function Number: 27
doteleporthack(param_00,param_01,param_02,param_03)
{
	var_06 = self method_8146();
	self setorigin(var_06,0);
	var_06 = getgroundposition(var_06,15);
	self.var_9CEC = undefined;
	self notify("traverse_end");
	lib_0A1A::func_237C("decide_idle",param_03);
}

//Function Number: 28
shouldstopshield(param_00,param_01,param_02,param_03)
{
	if(shoulddoshield(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	if(gettime() < self.minshieldstoptime)
	{
		return 0;
	}

	return 1;
}

//Function Number: 29
shoulddoshield(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 30
ismyenemyinfrontofme(param_00,param_01)
{
	var_02 = vectornormalize(param_00.origin - self.origin * (1,1,0));
	var_03 = anglestoforward(self.angles);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
shouldmeleeattackhit(param_00,param_01,param_02)
{
	if(lib_0F74::func_9DE0(param_00))
	{
		return 1;
	}

	var_03 = distance2dsquared(param_00.origin,self.origin);
	if(var_03 > param_01)
	{
		return 0;
	}

	if(!ismyenemyinfrontofme(param_00,param_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
domeleedamageoncontact(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self endon("DoMeleeDamageOnContact_stop");
	var_02 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
	var_03 = 0;
	while(!var_03)
	{
		foreach(var_05 in level.players)
		{
			if(scripts\mp\agents\crab_brute\crab_brute_agent::shouldignoreenemy(var_05))
			{
				continue;
			}

			var_06 = distancesquared(self.origin,var_05.origin);
			if(var_06 < var_02.charge_attack_stop_facing_enemy_dist_sq)
			{
				lib_0C73::func_1106E();
				self method_8281("code_move");
				self method_8289("face angle abs",self.angles);
			}

			if(shouldmeleeattackhit(var_05,var_02.charge_attack_damage_radius_sq,var_02.charge_attack_damage_dot))
			{
				lib_0C73::func_1106E();
				self method_8281("code_move");
				self method_8289("face angle abs",self.angles);
				lib_0C73::func_5904(var_05,var_02.charge_attack_damage_amt,"MOD_IMPACT");
				clearaction();
				self.bchargehit = 1;
				var_03 = 1;
				break;
			}
			else
			{
				var_07 = vectornormalize(var_05.origin - self.origin * (1,1,0));
				var_08 = anglestoforward(self.angles);
				var_09 = vectordot(var_07,var_08);
				if(var_09 < var_02.charge_abort_dot)
				{
					self.bchargehit = 0;
					clearaction();
					var_03 = 1;
					break;
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 33
playchargeloop(param_00,param_01,param_02,param_03)
{
	self.bchargehit = undefined;
	if(isdefined(self.var_4B26))
	{
		thread domeleedamageoncontact(param_01,self.var_4B26);
		thread lib_0C73::func_6A6A(param_01,self.var_4B26);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 34
choosechargeoutroanim(param_00,param_01,param_02)
{
	var_03 = "charge_miss";
	if(scripts\common\utility::istrue(self.bchargehit))
	{
		var_03 = "charge_hit";
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 35
choosecrabbruteturnanim(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = abs(self.desiredyaw);
	if(self.desiredyaw < 0)
	{
		if(var_04 < 67.5)
		{
			var_03 = 9;
		}
		else if(var_04 < 112.5)
		{
			var_03 = 6;
		}
		else if(var_04 < 157.5)
		{
			var_03 = 3;
		}
		else
		{
			var_03 = "2r";
		}
	}
	else if(self.desiredyaw < 67.5)
	{
		var_03 = 7;
	}
	else if(self.desiredyaw < 112.5)
	{
		var_03 = 4;
	}
	else if(self.desiredyaw < 157.5)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = "2l";
	}

	self.desiredyaw = undefined;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 36
shouldturn(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.desiredyaw))
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
shouldcrabbrutestartarrival(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\agents\crab_brute\crab_brute_agent::getenemy();
	if(!isdefined(var_04))
	{
		return lib_0C75::func_10092(param_00,param_01,param_02,param_03);
	}

	var_05 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
	var_06 = distancesquared(self.origin,var_04.origin);
	if(var_06 < var_05.min_dist_to_enemy_to_do_arrival_sq)
	{
		return 0;
	}

	return lib_0C75::func_10092(param_00,param_01,param_02,param_03);
}

//Function Number: 38
playchargeintro(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_233))
	{
		var_04 = self method_845D(50);
		if(isdefined(var_04))
		{
			var_05 = vectornormalize(var_04 - self.origin) * (1,1,0);
			var_06 = vectortoangles(var_05);
			self method_8289("face angle abs",var_06);
		}
	}
	else if(isdefined(self.var_4B26))
	{
		var_05 = vectornormalize(self.var_4B26.origin - self.origin) * (1,1,0);
		var_06 = vectortoangles(var_05);
		self method_8289("face angle abs",var_06);
	}

	return lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 39
doburrowoutrodamage(param_00)
{
	self endon(param_00 + "_finished");
	thread play_burrow_outro_sfx();
	var_01 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
	wait(var_01.burrow_outro_damage_wait_time);
	radiusdamage(self.origin,var_01.burrow_outro_damage_radius,var_01.burrow_outro_max_damage_amt,var_01.burrow_outro_min_damage_amt,self,"MOD_IMPACT");
}

//Function Number: 40
play_burrow_outro_sfx()
{
	if(isdefined(self.burrow_loop_obj))
	{
		thread stop_burrow_loop();
	}

	thread scripts\common\utility::play_sound_in_space("brute_burrow_out_of_ground",self.origin + (0,0,30));
}

//Function Number: 41
stop_burrow_loop()
{
	self.burrow_loop_obj method_83AD();
	wait(0.1);
	if(isdefined(self.burrow_loop_obj))
	{
		self.burrow_loop_obj delete();
	}
}

//Function Number: 42
playburrowoutro(param_00,param_01,param_02,param_03)
{
	thread doburrowoutrodamage(param_01);
	return playanimandlookatenemy(param_00,param_01,param_02,param_03);
}