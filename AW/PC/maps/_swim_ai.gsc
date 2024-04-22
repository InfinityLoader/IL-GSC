/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _swim_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 267 ms
 * Timestamp: 4/22/2024 2:23:23 AM
*******************************************************************/

//Function Number: 1
init_ai_swim()
{
}

//Function Number: 2
enable_ai_swim()
{
	setsaveddvar("phys_gravity_ragdoll",-10);
	setsaveddvar("phys_gravity",-10);
	setsaveddvar("ragdoll_max_life",15000);
	setsaveddvar("phys_autoDisableLinear",0.25);
	level thread maps\_swim_ai_common::override_footsteps();
	maps\_utility::battlechatter_off("axis");
}

//Function Number: 3
disable_ai_swim()
{
	setsaveddvar("phys_gravity_ragdoll",-800);
	setsaveddvar("phys_gravity",-800);
	setsaveddvar("ragdoll_max_life",4500);
	setsaveddvar("phys_autoDisableLinear",20);
	level thread maps\_swim_ai_common::restore_footsteps();
	maps\_utility::battlechatter_on("axis");
}

//Function Number: 4
enable_swim(param_00)
{
	if(!isai(self))
	{
		return;
	}

	self.swimmer = 1;
	self.health = 50;
	self.grenadeammo = 0;
	self.goalradius = 128;
	self.goalheight = 96;
	maps\_utility::disable_surprise();
	thread unlimited_ammo();
	if(isdefined(param_00) && param_00 == 1)
	{
		maps\_utility::forceuseweapon("aps_underwater+swim","primary");
		thread glint_behavior();
	}
	else
	{
		maps\_utility::gun_remove();
	}

	self.bdisabledefaultfacialanims = 1;
	self.dontmelee = 1;
	self.no_pistol_switch = 1;
	self.ignoresuppression = 1;
	self.norunreload = 1;
	self.disablebulletwhizbyreaction = 1;
	self.usechokepoints = 0;
	self.disabledoorbehavior = 1;
	self.combatmode = "cover";
	self.oldgrenadeawareness = self.grenadeawareness;
	self.grenadeawareness = 0;
	self.oldgrenadereturnthrow = self.nogrenadereturnthrow;
	self.nogrenadereturnthrow = 1;
	self.norunngun = 1;
	init_ai_swim_animsets();
	thread maps\_underwater::friendly_bubbles();
	thread underwater_blood();
	if(!isdefined(level.archetypes["soldier"]["swim"]))
	{
		init_swim_anims();
	}

	animscripts\swim::swim_begin();
}

//Function Number: 5
disable_swim()
{
	self.custommovetransition = undefined;
	self.permanentcustommovetransition = 0;
	self.bdisabledefaultfacialanims = undefined;
	animscripts\swim::swim_end();
	self notify("stop_glint_thread");
}

//Function Number: 6
init_swim_anims()
{
	var_00 = [];
	var_00["forward"] = %swimming_forward;
	var_00["forward_aim"] = %swimming_aiming_move_f;
	var_00["idle_to_forward"] = [];
	var_00["idle_to_forward"][2] = [];
	var_00["idle_to_forward"][4] = [];
	var_00["idle_to_forward"][4][4] = %swimming_idle_to_forward;
	var_00["idle_to_forward"][6] = [];
	var_00["idle_ready_to_forward"] = [];
	var_00["idle_ready_to_forward"][4] = [];
	var_00["idle_ready_to_forward"][4][4] = %swimming_idle_ready_to_forward;
	var_00["aim_stand_D"] = %swimming_fire_d;
	var_00["aim_stand_L"] = %swimming_fire_l;
	var_00["aim_stand_R"] = %swimming_fire_r;
	var_00["aim_move_R"] = %swimming_aiming_move_f_fire_r;
	var_00["aim_move_L"] = %swimming_aiming_move_f_fire_l;
	var_00["strafe_B"] = %swimming_aiming_move_b;
	var_00["strafe_L"] = %swimming_aiming_move_l;
	var_00["strafe_R"] = %swimming_aiming_move_r;
	var_00["strafe_L_aim_R"] = %swimming_aiming_move_l_fire_r;
	var_00["strafe_L_aim_L"] = %swimming_aiming_move_l_fire_l;
	var_00["strafe_L_aim_U"] = %swimming_aiming_move_l_fire_u;
	var_00["strafe_L_aim_D"] = %swimming_aiming_move_l_fire_d;
	var_00["strafe_R_aim_R"] = %swimming_aiming_move_r_fire_r;
	var_00["strafe_R_aim_L"] = %swimming_aiming_move_r_fire_l;
	var_00["strafe_R_aim_U"] = %swimming_aiming_move_r_fire_u;
	var_00["strafe_R_aim_D"] = %swimming_aiming_move_r_fire_d;
	var_00["strafe_B_aim_R"] = %swimming_aiming_move_b_fire_r;
	var_00["strafe_B_aim_L"] = %swimming_aiming_move_b_fire_l;
	var_00["strafe_B_aim_U"] = %swimming_aiming_move_b_fire_u;
	var_00["strafe_B_aim_D"] = %swimming_aiming_move_b_fire_d;
	var_00["turn_left_45"] = %swimming_aiming_turn_l45;
	var_00["turn_left_90"] = %swimming_aiming_turn_l90;
	var_00["turn_left_135"] = %swimming_aiming_turn_l135;
	var_00["turn_left_180"] = %swimming_aiming_turn_l180;
	var_00["turn_right_45"] = %swimming_aiming_turn_r45;
	var_00["turn_right_90"] = %swimming_aiming_turn_r90;
	var_00["turn_right_135"] = %swimming_aiming_turn_r135;
	var_00["turn_right_180"] = %swimming_aiming_turn_r180;
	var_00["idle_turn"] = [];
	var_00["surprise_stop"] = %swimming_surprise_stop;
	var_00["arrival_cover_corner_r"] = [];
	var_00["arrival_cover_corner_r"][2] = [];
	var_00["arrival_cover_corner_r"][3] = [];
	var_00["arrival_cover_corner_r"][3][4] = %swimming_aiming_move_to_cover_r1_r45;
	var_00["arrival_cover_corner_r"][4] = [];
	var_00["arrival_cover_corner_r"][4][4] = %swimming_aiming_move_to_cover_r1;
	var_00["arrival_cover_corner_r"][5] = [];
	var_00["arrival_cover_corner_r"][5][4] = %swimming_aiming_move_to_cover_r1_l45;
	var_00["arrival_cover_corner_r"][6] = [];
	var_00["arrival_cover_corner_l"] = [];
	var_00["arrival_cover_corner_l"][2] = [];
	var_00["arrival_cover_corner_l"][3] = [];
	var_00["arrival_cover_corner_l"][3][4] = %swimming_aiming_move_to_cover_l1_r45;
	var_00["arrival_cover_corner_l"][4] = [];
	var_00["arrival_cover_corner_l"][4][4] = %swimming_aiming_move_to_cover_l1;
	var_00["arrival_cover_corner_l"][5] = [];
	var_00["arrival_cover_corner_l"][5][4] = %swimming_aiming_move_to_cover_l1_l45;
	var_00["arrival_cover_corner_l"][6] = [];
	var_00["arrival_cover_u"] = [];
	var_00["arrival_cover_u"][2] = [];
	var_00["arrival_cover_u"][3] = [];
	var_00["arrival_cover_u"][3][4] = %swimming_aiming_move_to_cover_u1_r45;
	var_00["arrival_cover_u"][4] = [];
	var_00["arrival_cover_u"][4][4] = %swimming_aiming_move_to_cover_u1;
	var_00["arrival_cover_u"][5] = [];
	var_00["arrival_cover_u"][5][4] = %swimming_aiming_move_to_cover_u1_l45;
	var_00["arrival_cover_u"][6] = [];
	var_00["arrival_exposed"] = [];
	var_00["arrival_exposed"][4] = [];
	var_00["arrival_exposed"][4][4] = %swimming_forward_to_idle_ready;
	var_00["arrival_exposed_noncombat"] = [];
	var_00["arrival_exposed_noncombat"][4] = [];
	var_00["arrival_exposed_noncombat"][4][4] = %swimming_forward_to_idle;
	var_00["exit_cover_corner_r"] = [];
	var_00["exit_cover_corner_r"][2] = [];
	var_00["exit_cover_corner_r"][3] = [];
	var_00["exit_cover_corner_r"][4] = [];
	var_00["exit_cover_corner_r"][4][4] = %swimming_cover_r1_to_aiming_move;
	var_00["exit_cover_corner_r"][5] = [];
	var_00["exit_cover_corner_r"][6] = [];
	var_00["exit_cover_corner_l"] = [];
	var_00["exit_cover_corner_l"][2] = [];
	var_00["exit_cover_corner_l"][3] = [];
	var_00["exit_cover_corner_l"][4] = [];
	var_00["exit_cover_corner_l"][5] = [];
	var_00["exit_cover_corner_l"][6] = [];
	var_00["exit_cover_u"] = [];
	var_00["exit_cover_u"][2] = [];
	var_00["exit_cover_u"][3] = [];
	var_00["exit_cover_u"][4] = [];
	var_00["exit_cover_u"][5] = [];
	var_00["exit_cover_u"][6] = [];
	var_00["turn"] = [];
	var_00["turn"] = [];
	var_00["turn"][0] = [];
	var_00["turn"][0][4] = %swimming_swim_turn_l180;
	var_00["turn"][1] = [];
	var_00["turn"][1][4] = %swimming_swim_turn_l135;
	var_00["turn"][2] = [];
	var_00["turn"][2][4] = %swimming_swim_turn_l90;
	var_00["turn"][3] = [];
	var_00["turn"][3][3] = %swimming_swim_turn_d45_l45;
	var_00["turn"][3][4] = %swimming_swim_turn_l45;
	var_00["turn"][3][5] = %swimming_swim_turn_u45_l45;
	var_00["turn"][4] = [];
	var_00["turn"][4][3] = %swimming_swim_turn_d45;
	var_00["turn"][4][5] = %swimming_swim_turn_u45;
	var_00["turn"][5] = [];
	var_00["turn"][5][3] = %swimming_swim_turn_d45_r45;
	var_00["turn"][5][4] = %swimming_swim_turn_r45;
	var_00["turn"][5][5] = %swimming_swim_turn_u45_r45;
	var_00["turn"][6] = [];
	var_00["turn"][6][4] = %swimming_swim_turn_r90;
	var_00["turn"][7] = [];
	var_00["turn"][7][4] = %swimming_swim_turn_r135;
	var_00["turn"][8] = [];
	var_00["turn"][8][4] = %swimming_swim_turn_l180;
	var_00["turn_add_r"] = %swimming_slight_turn_r;
	var_00["turn_add_l"] = %swimming_slight_turn_l;
	var_00["turn_add_u"] = %swimming_slight_turn_u;
	var_00["turn_add_d"] = %swimming_slight_turn_d;
	var_00["cover_corner_r"] = [];
	var_00["cover_corner_r"]["straight_level"] = %swimming_fire;
	var_00["cover_corner_r"]["alert_idle"] = %swimming_cover_r1_loop;
	var_00["cover_corner_r"]["alert_to_A"] = [%swimming_cover_r1_full_expose];
	var_00["cover_corner_r"]["alert_to_B"] = [%swimming_cover_r1_full_expose];
	var_00["cover_corner_r"]["A_to_alert"] = [%swimming_cover_r1_full_hide];
	var_00["cover_corner_r"]["A_to_B"] = [%swimming_fire];
	var_00["cover_corner_r"]["B_to_alert"] = [%swimming_cover_r1_full_hide];
	var_00["cover_corner_r"]["B_to_A"] = [%swimming_fire];
	var_00["cover_corner_r"]["lean_to_alert"] = [%swimming_cover_r1_hide];
	var_00["cover_corner_r"]["alert_to_lean"] = [%swimming_cover_r1_expose];
	var_00["cover_corner_r"]["look"] = %swimming_cover_r1_expose;
	var_00["cover_corner_r"]["reload"] = [%swimming_cover_r1_reload];
	var_00["cover_corner_r"]["alert_to_look"] = %swimming_cover_r1_expose;
	var_00["cover_corner_r"]["look_to_alert"] = %swimming_cover_r1_hide;
	var_00["cover_corner_r"]["look_to_alert_fast"] = %swimming_cover_r1_hide;
	var_00["cover_corner_r"]["look_idle"] = %swimming_cover_r1_exposed_idle;
	var_00["cover_corner_r"]["lean_aim_down"] = %swimming_cover_r1_exposed_aim_d;
	var_00["cover_corner_r"]["lean_aim_left"] = %swimming_cover_r1_exposed_aim_l;
	var_00["cover_corner_r"]["lean_aim_straight"] = %swimming_cover_r1_exposed_fire;
	var_00["cover_corner_r"]["lean_aim_right"] = %swimming_cover_r1_exposed_aim_r;
	var_00["cover_corner_r"]["lean_aim_up"] = %swimming_cover_r1_exposed_aim_u;
	var_00["cover_corner_r"]["lean_reload"] = %swimming_cover_r1_reload;
	var_00["cover_corner_r"]["lean_idle"] = [%swimming_cover_r1_exposed_idle];
	var_00["cover_corner_r"]["lean_single"] = %swimming_cover_r1_exposed_fire;
	var_00["cover_corner_r"]["lean_fire"] = %swimming_cover_r1_exposed_fire;
	var_00["cover_corner_r"]["add_aim_down"] = %swimming_fire_d;
	var_00["cover_corner_r"]["add_aim_left"] = %swimming_fire_l;
	var_00["cover_corner_r"]["add_aim_straight"] = %swimming_firing;
	var_00["cover_corner_r"]["add_aim_right"] = %swimming_fire_r;
	var_00["cover_corner_r"]["add_aim_idle"] = %swimming_firing_idle;
	var_00["cover_corner_l"] = [];
	var_00["cover_corner_l"]["straight_level"] = %swimming_fire;
	var_00["cover_corner_l"]["alert_idle"] = %swimming_cover_l1_idle;
	var_00["cover_corner_l"]["alert_to_A"] = [%swimming_cover_l1_full_expose];
	var_00["cover_corner_l"]["alert_to_B"] = [%swimming_cover_l1_full_expose];
	var_00["cover_corner_l"]["A_to_alert"] = [%swimming_cover_l1_full_hide];
	var_00["cover_corner_l"]["A_to_B"] = [%swimming_fire];
	var_00["cover_corner_l"]["B_to_alert"] = [%swimming_cover_l1_full_hide];
	var_00["cover_corner_l"]["B_to_A"] = [%swimming_fire];
	var_00["cover_corner_l"]["lean_to_alert"] = [%swimming_cover_l1_hide];
	var_00["cover_corner_l"]["alert_to_lean"] = [%swimming_cover_l1_expose];
	var_00["cover_corner_l"]["look"] = %swimming_cover_l1_expose;
	var_00["cover_corner_l"]["reload"] = [%swimming_cover_l1_reload];
	var_00["cover_corner_l"]["alert_to_look"] = %swimming_cover_l1_expose;
	var_00["cover_corner_l"]["look_to_alert"] = %swimming_cover_l1_hide;
	var_00["cover_corner_l"]["look_to_alert_fast"] = %swimming_cover_l1_hide;
	var_00["cover_corner_l"]["look_idle"] = %swimming_cover_l1_exposed_idle;
	var_00["cover_corner_l"]["lean_aim_down"] = %swimming_cover_l1_exposed_aim_d;
	var_00["cover_corner_l"]["lean_aim_left"] = %swimming_cover_l1_exposed_aim_l;
	var_00["cover_corner_l"]["lean_aim_straight"] = %swimming_cover_l1_exposed_fire;
	var_00["cover_corner_l"]["lean_aim_right"] = %swimming_cover_l1_exposed_aim_r;
	var_00["cover_corner_l"]["lean_aim_up"] = %swimming_cover_l1_exposed_aim_u;
	var_00["cover_corner_l"]["lean_reload"] = %swimming_cover_l1_reload;
	var_00["cover_corner_l"]["lean_idle"] = [%swimming_cover_l1_exposed_idle];
	var_00["cover_corner_l"]["lean_single"] = %swimming_cover_l1_exposed_fire;
	var_00["cover_corner_l"]["lean_fire"] = %swimming_cover_l1_exposed_fire;
	var_00["cover_corner_l"]["add_aim_down"] = %swimming_fire_d;
	var_00["cover_corner_l"]["add_aim_left"] = %swimming_fire_l;
	var_00["cover_corner_l"]["add_aim_straight"] = %swimming_firing;
	var_00["cover_corner_l"]["add_aim_right"] = %swimming_fire_r;
	var_00["cover_corner_l"]["add_aim_idle"] = %swimming_firing_idle;
	var_00["cover_u"] = [];
	var_00["cover_u"]["straight_level"] = %swimming_fire;
	var_00["cover_u"]["alert_idle"] = %swimming_cover_u1_idle;
	var_00["cover_u"]["alert_to_A"] = [%swimming_cover_u1_full_expose];
	var_00["cover_u"]["alert_to_B"] = [%swimming_cover_u1_full_expose];
	var_00["cover_u"]["A_to_alert"] = [%swimming_cover_u1_full_hide];
	var_00["cover_u"]["A_to_B"] = [%swimming_fire];
	var_00["cover_u"]["B_to_alert"] = [%swimming_cover_u1_full_hide];
	var_00["cover_u"]["B_to_A"] = [%swimming_fire];
	var_00["cover_u"]["lean_to_alert"] = [%swimming_cover_u1_hide];
	var_00["cover_u"]["alert_to_lean"] = [%swimming_cover_u1_expose];
	var_00["cover_u"]["look"] = %swimming_cover_u1_expose;
	var_00["cover_u"]["reload"] = [%swimming_cover_u1_reload];
	var_00["cover_u"]["alert_to_look"] = %swimming_cover_u1_expose;
	var_00["cover_u"]["look_to_alert"] = %swimming_cover_u1_hide;
	var_00["cover_u"]["look_to_alert_fast"] = %swimming_cover_u1_hide;
	var_00["cover_u"]["look_idle"] = %swimming_cover_u1_exposed_idle;
	var_00["cover_u"]["lean_aim_down"] = %swimming_cover_u1_exposed_aim_d;
	var_00["cover_u"]["lean_aim_left"] = %swimming_cover_u1_exposed_aim_l;
	var_00["cover_u"]["lean_aim_straight"] = %swimming_cover_u1_exposed_fire;
	var_00["cover_u"]["lean_aim_right"] = %swimming_cover_u1_exposed_aim_r;
	var_00["cover_u"]["lean_aim_up"] = %swimming_cover_u1_exposed_aim_u;
	var_00["cover_u"]["lean_reload"] = %swimming_cover_u1_reload;
	var_00["cover_u"]["lean_idle"] = [%swimming_cover_u1_exposed_idle];
	var_00["cover_u"]["lean_single"] = %swimming_cover_u1_exposed_fire;
	var_00["cover_u"]["lean_fire"] = %swimming_cover_u1_exposed_fire;
	var_00["cover_u"]["add_aim_down"] = %swimming_fire_d;
	var_00["cover_u"]["add_aim_left"] = %swimming_fire_l;
	var_00["cover_u"]["add_aim_straight"] = %swimming_firing;
	var_00["cover_u"]["add_aim_right"] = %swimming_fire_r;
	var_00["cover_u"]["add_aim_idle"] = %swimming_firing_idle;
	level.archetypes["soldier"]["swim"] = var_00;
	level.archetypes["soldier"]["swim"]["maxDelta"] = [];
	init_swim_anim_deltas("soldier","arrival_exposed");
	init_swim_anim_deltas("soldier","arrival_exposed_noncombat");
	init_swim_anim_deltas("soldier","arrival_cover_corner_r");
	init_swim_anim_deltas("soldier","arrival_cover_corner_l");
	init_swim_anim_deltas("soldier","arrival_cover_u");
	init_swim_anim_deltas("soldier","exit_cover_corner_r",0);
	init_swim_anim_deltas("soldier","exit_cover_corner_l",0);
	init_swim_anim_deltas("soldier","exit_cover_u",0);
	init_swim_anim_deltas("soldier","idle_to_forward",0);
}

//Function Number: 7
init_swim_anim_deltas(param_00,param_01,param_02)
{
	var_03 = param_01 + "_delta";
	var_04 = param_01 + "_angleDelta";
	var_05 = 1;
	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	level.archetypes[param_00]["swim"][var_03] = [];
	foreach(var_0E, var_07 in level.archetypes[param_00]["swim"][param_01])
	{
		if(!isdefined(level.archetypes[param_00]["swim"][var_03][var_0E]))
		{
			level.archetypes[param_00]["swim"][var_03][var_0E] = [];
			level.archetypes[param_00]["swim"][var_04][var_0E] = [];
		}

		var_08 = 0;
		foreach(var_0D, var_0A in var_07)
		{
			var_0B = getmovedelta(var_0A,0,1);
			level.archetypes[param_00]["swim"][var_03][var_0E][var_0D] = var_0B;
			level.archetypes[param_00]["swim"][var_04][var_0E][var_0D] = getangledelta3d(var_0A,0,1);
			if(var_05)
			{
				var_0C = lengthsquared(var_0B);
				if(var_0C > var_08)
				{
					var_08 = var_0C;
				}
			}
		}

		if(var_05)
		{
			level.archetypes[param_00]["swim"][param_01]["maxDelta"] = sqrt(var_08);
		}
	}
}

//Function Number: 8
init_ai_swim_animsets()
{
	self.customidleanimset = [];
	self.customidleanimset["stand"] = %swimming_idle;
	self.a.pose = "stand";
	self allowedstances("stand");
	var_00 = level.archetypes["soldier"]["default_stand"];
	var_00["straight_level"] = %swimming_idle_ready;
	var_00["exposed_idle"] = undefined;
	var_00["reload"] = [%swimming_reload];
	var_00["reload_crouchhide"] = [%swimming_reload];
	var_00["turn_left_45"] = %swimming_aiming_turn_l45;
	var_00["turn_left_90"] = %swimming_aiming_turn_l90;
	var_00["turn_left_135"] = %swimming_aiming_turn_l135;
	var_00["turn_left_180"] = %swimming_aiming_turn_l180;
	var_00["turn_right_45"] = %swimming_aiming_turn_r45;
	var_00["turn_right_90"] = %swimming_aiming_turn_r90;
	var_00["turn_right_135"] = %swimming_aiming_turn_r135;
	var_00["turn_right_180"] = %swimming_aiming_turn_r180;
	animscripts\animset::init_animset_complete_custom_stand(var_00);
	animscripts\animset::init_animset_complete_custom_crouch(var_00);
	self.painfunction = ::ai_swim_pain;
	self.deathfunction = ::ai_swim_death;
}

//Function Number: 9
ai_swim_pain()
{
	if(self.a.movement == "run")
	{
		var_00 = %swimming_pain_1;
	}
	else
	{
		var_00 = %swimming_pain_1;
	}

	var_01 = 1;
	self setflaggedanimknoballrestart("painanim",var_00,%body,1,0.1,var_01);
	if(self.a.pose == "prone")
	{
		self updateprone(%prone_legs_up,%prone_legs_down,1,0.1,1);
	}

	if(animhasnotetrack(var_00,"start_aim"))
	{
		thread animscripts\pain::notifystartaim("painanim");
		self endon("start_aim");
	}

	if(animhasnotetrack(var_00,"code_move"))
	{
		animscripts\shared::donotetracks("painanim");
	}

	animscripts\shared::donotetracks("painanim");
}

//Function Number: 10
unlimited_ammo()
{
	self endon("death");
	for(;;)
	{
		self.a.rockets = 100;
		wait(0.2);
	}
}

//Function Number: 11
ai_swim_death()
{
	playfxontag(common_scripts\utility::getfx("swim_ai_death_blood"),self,"j_spineupper");
	if(!isdefined(self.deathanim))
	{
		if(self.damageyaw > -60 && self.damageyaw <= 60)
		{
		}
		else if(self.a.movement == "run")
		{
			self.deathanim = %swimming_death_1;
		}
		else if(animscripts\utility::damagelocationisany("left_arm_upper"))
		{
			self.deathanim = %swimming_firing_death_1;
		}
		else if(animscripts\utility::damagelocationisany("head","helmet"))
		{
		}
		else
		{
		}
	}

	if(!isdefined(self.nodeathsound))
	{
		animscripts\death::playdeathsound();
	}

	return 0;
}

//Function Number: 12
underwater_blood()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_04 != "MOD_EXPLOSIVE")
		{
			if(var_02 != (0,0,0))
			{
				playfx(common_scripts\utility::getfx("swim_ai_blood_impact"),var_03,var_02);
			}
		}
	}
}

//Function Number: 13
jumpintowater(param_00)
{
	self endon("death");
	var_01 = (0,0,5);
	var_02 = level.water_level_z + 64;
	if(!isdefined(param_00))
	{
		var_03 = (self.origin[0],self.origin[1],var_02);
		var_04 = bullettrace(var_03 - (0,0,10),var_03 - (0,0,700),0,self);
		param_00 = var_04["position"];
	}
	else
	{
		var_03 = (var_01[0],var_01[1],var_03);
	}

	var_03 = var_03 + var_01;
	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05.origin = var_03;
	var_06 = common_scripts\utility::spawn_tag_origin();
	self forceteleport(var_03,self.angles);
	self linkto(var_05);
	var_06 linkto(self,"tag_origin",(0,0,0),(90,0,0));
	self hide();
	maps\_utility::script_delay();
	self show();
	self.allowdeath = 1;
	var_07 = 400;
	var_08 = var_02 - param_00[2];
	var_09 = min(var_08 - 100,var_08 * 0.9);
	var_0A = var_08 - var_09;
	var_0B = var_0A / var_07;
	var_0C = var_09 / var_07 / 2;
	self playsound("enemy_water_splash");
	playfx(common_scripts\utility::getfx("jump_into_water_splash"),var_03 - (0,0,64),(0,0,-1),(1,0,0));
	playfxontag(common_scripts\utility::getfx("jump_into_water_trail"),var_06,"tag_origin");
	var_05 movez(-1 * var_09,var_0C,0,0);
	wait(var_0C * 0.9);
	var_05 notify("stop_first_frame");
	self notify("stop_first_frame");
	var_06 thread mover_delete();
	if(isalive(self))
	{
		self unlink();
		if(!self.swimmer)
		{
			thread enable_swim();
		}
	}

	self notify("done_jumping_in");
	if(!common_scripts\utility::flag_exist("_stealth_spotted") || !common_scripts\utility::flag("_stealth_spotted") || !common_scripts\utility::flag_exist("_stealth_enabled") || !common_scripts\utility::flag("_stealth_enabled"))
	{
		maps\_utility::disable_exits();
		var_05 delete();
		wait(0.1);
		maps\_utility::enable_exits();
		return;
	}

	var_05 delete();
}

//Function Number: 14
mover_delete()
{
	wait(1.5);
	stopfxontag(common_scripts\utility::getfx("jump_into_water_trail"),self,"tag_origin");
	wait(1);
	self unlink();
	wait(1);
	self delete();
}

//Function Number: 15
glint_behavior()
{
	self notify("new_glint_thread");
	self endon("new_glint_thread");
	self endon("stop_glint_thread");
	self endon("death");
	if(!isdefined(level._effect["sniper_glint"]))
	{
		return;
	}

	if(!isalive(self.enemy))
	{
		return;
	}

	var_00 = common_scripts\utility::getfx("sniper_glint");
	wait(0.2);
	for(;;)
	{
		if(self.weapon == self.primaryweapon && animscripts\combat_utility::player_sees_my_scope() && isdefined(self.enemy))
		{
			if(distancesquared(self.origin,self.enemy.origin) > 65536)
			{
				playfxontag(var_00,self,"tag_eye");
			}

			var_01 = randomfloatrange(3,5);
			wait(var_01);
		}

		wait(0.2);
	}
}