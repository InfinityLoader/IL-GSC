/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: free_run.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 121 ms
 * Timestamp: 4/22/2024 2:00:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	waittillframeend;
	waittillframeend;
	setup_free_run_move_anims();
	setup_free_run_cover_crouch_anims();
	setup_free_run_transition_anims();
}

//Function Number: 2
setup_free_run_move_anims()
{
	var_00 = [];
	var_00["sprint"] = %freerunnerb_loop;
	var_00["move_f"] = %freerunnerb_loop;
	var_00["move_l"] = %freerunnerb_loop;
	var_00["move_r"] = %freerunnerb_loop;
	var_00["move_b"] = %freerunnerb_loop;
	level.archetypes["soldier"]["free_run_move"] = var_00;
}

//Function Number: 3
setup_free_run_cover_crouch_anims()
{
	var_00 = [];
	var_00["hide_idle"] = %unarmed_covercrouch_hide_idle;
	var_00["hide_idle_twitch"] = animscripts\utility::array(%unarmed_covercrouch_twitch_1,%unarmed_covercrouch_twitch_2,%unarmed_covercrouch_twitch_3,%unarmed_covercrouch_twitch_4);
	var_00["look"] = animscripts\utility::array(%unarmed_covercrouch_hide_look);
	var_00["add_aim_up"] = %covercrouch_aim8_add;
	var_00["add_aim_down"] = %covercrouch_aim2_add;
	var_00["add_aim_left"] = %covercrouch_aim4_add;
	var_00["add_aim_right"] = %covercrouch_aim6_add;
	var_00["straight_level"] = %covercrouch_aim5;
	var_00["hide_idle_flinch"] = animscripts\utility::array();
	var_00["hide_2_crouch"] = %covercrouch_hide_2_aim;
	var_00["hide_2_stand"] = %covercrouch_hide_2_stand;
	var_00["hide_2_lean"] = %covercrouch_hide_2_lean;
	var_00["hide_2_right"] = %covercrouch_hide_2_right;
	var_00["hide_2_left"] = %covercrouch_hide_2_left;
	var_00["crouch_2_hide"] = %covercrouch_aim_2_hide;
	var_00["stand_2_hide"] = %covercrouch_stand_2_hide;
	var_00["lean_2_hide"] = %covercrouch_lean_2_hide;
	var_00["right_2_hide"] = %covercrouch_right_2_hide;
	var_00["left_2_hide"] = %covercrouch_left_2_hide;
	var_00["smg_hide_2_stand"] = %smg_covercrouch_hide_2_stand;
	var_00["smg_stand_2_hide"] = %smg_covercrouch_stand_2_hide;
	var_00["crouch_aim"] = %covercrouch_aim5;
	var_00["stand_aim"] = %exposed_aim_5;
	var_00["lean_aim"] = %covercrouch_lean_aim5;
	var_00["fire"] = %exposed_shoot_auto_v2;
	var_00["semi2"] = %exposed_shoot_semi2;
	var_00["semi3"] = %exposed_shoot_semi3;
	var_00["semi4"] = %exposed_shoot_semi4;
	var_00["semi5"] = %exposed_shoot_semi5;
	var_00["single"] = [%exposed_shoot_semi1];
	var_00["burst2"] = %exposed_shoot_burst3;
	var_00["burst3"] = %exposed_shoot_burst3;
	var_00["burst4"] = %exposed_shoot_burst4;
	var_00["burst5"] = %exposed_shoot_burst5;
	var_00["burst6"] = %exposed_shoot_burst6;
	var_00["blind_fire"] = animscripts\utility::array(%covercrouch_blindfire_1,%covercrouch_blindfire_2,%covercrouch_blindfire_3,%covercrouch_blindfire_4);
	var_00["reload"] = %covercrouch_reload_hide;
	var_00["grenade_safe"] = animscripts\utility::array(%covercrouch_grenadea,%covercrouch_grenadeb);
	var_00["grenade_exposed"] = animscripts\utility::array(%covercrouch_grenadea,%covercrouch_grenadeb);
	var_00["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.archetypes["soldier"]["free_run_cover_crouch"] = var_00;
}

//Function Number: 4
setup_free_run_transition_anims()
{
	var_00 = "free_run_into_cover_crouch";
	var_01 = [];
	var_01[1] = %unarmed_covercrouch_arrive_7;
	var_01[2] = %unarmed_covercrouch_arrive_8;
	var_01[3] = %unarmed_covercrouch_arrive_9;
	var_01[4] = %unarmed_covercrouch_arrive_4;
	var_01[6] = %unarmed_covercrouch_arrive_6;
	level.archetypes["soldier"]["cover_trans"][var_00] = var_01;
	var_02 = "free_run_out_of_cover_crouch";
	var_01 = [];
	var_01[1] = %unarmed_covercrouch_exit_1;
	var_01[2] = %unarmed_covercrouch_exit_2;
	var_01[3] = %unarmed_covercrouch_exit_3;
	var_01[4] = %unarmed_covercrouch_exit_4;
	var_01[6] = %unarmed_covercrouch_exit_6;
	level.archetypes["soldier"]["cover_exit"][var_02] = var_01;
	for(var_03 = 1;var_03 <= 6;var_03++)
	{
		if(var_03 == 5)
		{
			continue;
		}

		level.archetypes["soldier"]["cover_trans_dist"][var_00][var_03] = getmovedelta(level.archetypes["soldier"]["cover_trans"][var_00][var_03],0,1);
		level.archetypes["soldier"]["cover_trans_angles"][var_00][var_03] = getangledelta(level.archetypes["soldier"]["cover_trans"][var_00][var_03],0,1);
		if(animhasnotetrack(level.archetypes["soldier"]["cover_exit"][var_02][var_03],"code_move"))
		{
			var_04 = getnotetracktimes(level.archetypes["soldier"]["cover_exit"][var_02][var_03],"code_move")[0];
		}
		else
		{
			var_04 = 1;
		}

		level.archetypes["soldier"]["cover_exit_dist"][var_02][var_03] = getmovedelta(level.archetypes["soldier"]["cover_exit"][var_02][var_03],0,var_04);
		level.archetypes["soldier"]["cover_exit_angles"][var_02][var_03] = getangledelta(level.archetypes["soldier"]["cover_exit"][var_02][var_03],0,1);
	}

	level.archetypes["soldier"]["CoverTransLongestDist"][var_00] = 0;
	for(var_03 = 1;var_03 <= 6;var_03++)
	{
		if(var_03 == 5)
		{
			continue;
		}

		var_05 = lengthsquared(level.archetypes["soldier"]["cover_trans_dist"][var_00][var_03]);
		if(level.archetypes["soldier"]["CoverTransLongestDist"][var_00] < var_05)
		{
			level.archetypes["soldier"]["CoverTransLongestDist"][var_00] = var_05;
		}
	}

	level.arrivalendstance[var_00] = "crouch";
}

//Function Number: 5
move_free_run()
{
	if(self.a.pose != "stand")
	{
		self clearanim(%animscript_root,0.2);
		if(self.a.pose == "prone")
		{
			animscripts\utility::exitpronewrapper(1);
		}

		self.a.pose = "stand";
	}

	self.a.movement = self.movemode;
	var_00 = animscripts\utility::lookupanim("free_run_move","sprint");
	var_01 = self.moveplaybackrate;
	var_02 = 0.3;
	if(self.movemode == "walk")
	{
		var_01 = var_01 * 0.6;
	}

	self setflaggedanimknoball("runanim",var_00,%walk_and_run_loops,1,var_02,var_01,1);
	animscripts\run::setmovenonforwardanims(animscripts\utility::lookupanim("free_run_move","move_b"),animscripts\utility::lookupanim("free_run_move","move_l"),animscripts\utility::lookupanim("free_run_move","move_r"));
	thread animscripts\run::setcombatstandmoveanimweights("free_run_move");
	animscripts\notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 6
enable_free_running(param_00)
{
	if(!isdefined(param_00) || param_00 == 0)
	{
		self.free_running_hidden_weapon = self.weapon;
		maps\_utility::gun_remove();
		self.weapon = "none";
	}
	else if(isdefined(self.free_running_hidden_weapon))
	{
		self.free_running_hidden_weapon = undefined;
	}

	self.free_running = 1;
	animscripts\move::register_pluggable_move_loop_override(::move_free_run);
}

//Function Number: 7
disable_free_running()
{
	if(isdefined(self.free_running))
	{
		if(isdefined(self.free_running_hidden_weapon))
		{
			animscripts\shared::placeweaponon(self.free_running_hidden_weapon,"right");
			self.free_running_hidden_weapon = undefined;
		}

		self.free_running = undefined;
		animscripts\move::clear_pluggable_move_loop_override();
	}
}