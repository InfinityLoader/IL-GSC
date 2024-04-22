/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_gambling.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 1001 ms
 * Timestamp: 4/22/2024 2:13:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["plinko_fraggrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_fraggrenade_trail");
	level._effect["plinko_contactgrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_contactgrenade_trail");
	level._effect["plinko_dnagrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_dnagrenade_trail");
	level._effect["plinko_explosive_drone_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_explosive_drone_trail");
	level._effect["plinko_distract_drone_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_distract_drone_trail");
	level._effect["plinko_teleportgrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_teleportgrenade_trail");
	level._effect["plinko_distract_drone_socket"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_distract_drone_socket");
	level._effect["plinko_dna_grenade_socket"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_dna_grenade_socket");
	level._effect["plinko_explosive_drone_socket"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_explosive_drone_socket");
	level._effect["plinko_grenade_break"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_grenade_removal");
	level._effect["plinko_credits_100"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_100");
	level._effect["plinko_credits_200"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_200");
	level._effect["plinko_credits_300"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_300");
	level._effect["plinko_credits_400"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_400");
	level._effect["plinko_credits_500"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_500");
	level._effect["plinko_credits_750"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_750");
	level._effect["plinko_credits_1000"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_1000");
	level._effect["plinko_light_green"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_light_green");
	level._effect["plinko_light_red"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_light_red");
	var_00 = common_scripts\utility::getstructarray("plinko","targetname");
	common_scripts\utility::array_thread(var_00,::plinko_init);
	level.zmbteleportgrenadestuckcustom = ::plink_do_grenade_in_all_hoppers_test;
}

//Function Number: 2
reward(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = strtok(param_00,";");
	foreach(var_05 in var_03)
	{
		var_06 = strtok(var_05," ");
		var_07 = var_06[0];
		var_08 = var_06[1];
		switch(var_07)
		{
			case "cash":
				var_09 = int(var_08);
				if(isdefined(param_01))
				{
					param_01 maps\mp\gametypes\zombies::givepointsforevent("gambling",var_09,1);
					param_01 thread playerplinkoplaypayoutvo(var_09);
					param_01 playlocalsound("interact_credit_machine");
					if(isdefined(param_02))
					{
						var_0A = common_scripts\utility::getfx("plinko_credits_" + var_09);
						playfx(var_0A,param_02.origin + self.fx_dir * 3,self.fx_dir);
					}
				}
				break;

			case "pickup":
				if(isdefined(level.pickup[var_08]) && isdefined(level.pickup[var_08]["func"]))
				{
					level thread [[ level.pickup[var_08]["func"] ]](param_01);
				}
				break;

			case "sq":
				common_scripts\utility::flag_set("sq_plinko_" + var_08,param_01);
				plinko_reset_chute_location();
				break;

			default:
				break;
		}
	}
}

//Function Number: 3
plinko_init()
{
	var_00 = getentarray(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	self.activetokencount = 0;
	self.tokens = [];
	self.starts = [];
	self.grenade_hoppers = [];
	self.gates = [];
	self.force_open = 0;
	self.sq_grenade_in_hopper_count = 0;
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	self.fx_dir = anglestoforward(self.angles);
	level thread discoverplinkologic(self);
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		switch(var_04.script_noteworthy)
		{
			case "token":
				var_04.inuse = 0;
				var_04 hide();
				self.tokens[self.tokens.size] = var_04;
				break;

			case "start":
				self.starts[self.starts.size] = var_04;
				break;

			case "trigger":
				self.trigger = var_04;
				break;

			case "grenade_hopper":
				self.grenade_hoppers[self.grenade_hoppers.size] = var_04;
				break;

			case "gate_left":
				plinko_init_gate(var_04);
				self.gate_left = var_04;
				break;

			case "gate_right":
				plinko_init_gate(var_04);
				self.gate_right = var_04;
				break;

			case "gate_top":
				plinko_init_gate(var_04);
				self.gate_top = var_04;
				break;

			case "gate_bottom":
				plinko_init_gate(var_04);
				self.gate_bottom = var_04;
				break;

			case "chute":
				self.chute = var_04;
				break;

			case "sq_goal":
				thread plinko_sq_goal(var_04);
				break;

			case "sq_geo":
				thread plinko_sq_geo(var_04);
				break;

			default:
				break;
		}
	}

	if(isdefined(self.chute))
	{
		plinko_init_chute(self.chute);
	}

	plinko_run();
}

//Function Number: 4
plinko_init_chute(param_00)
{
	param_00.default_location = spawnstruct();
	param_00.default_location.origin = param_00.origin;
	param_00.default_location.starts = self.starts;
	param_00.current_location = param_00.default_location;
	param_00.locations = common_scripts\utility::getstructarray(param_00.target,"targetname");
	foreach(var_02 in param_00.locations)
	{
		var_02.starts = common_scripts\utility::getstructarray(var_02.target,"targetname");
	}

	param_00.locations[param_00.locations.size] = param_00.default_location;
	plinko_reset_chute_location();
}

//Function Number: 5
plinko_chute_at_defualt_location()
{
	return self.chute.default_location == self.chute.current_location;
}

//Function Number: 6
plinko_reset_chute_location()
{
	plinko_set_chute_location(self.chute.default_location);
}

//Function Number: 7
plinko_set_chute_location(param_00)
{
	self.chute.origin = param_00.origin;
	self.starts = param_00.starts;
	self.chute.current_location = param_00;
	if(plinko_chute_at_defualt_location())
	{
		self notify("chute_at_default");
		return;
	}

	self notify("chute_not_at_default");
}

//Function Number: 8
plinko_sq_grenade_helper()
{
	common_scripts\utility::flag_wait("sq_plinko");
	var_00 = [];
	var_01 = [["sq_frag","npc_exo_launcher_grenade","plinko_fraggrenade_trail","tag_fx",(3,0,-7),(0,0,0)],["sq_explosive_drone","npc_drone_explosive_main","plinko_explosive_drone_socket","TAG_BEACON",(2,0,-6),(350,0,0)],["sq_distraction_drone","dlc_distraction_drone_01_scaled_open","plinko_distract_drone_socket","tag_weapon",(0,0,-8),(43,284,-69)],["sq_dna_grenade","npc_exo_launcher_grenade","plinko_dna_grenade_socket","tag_fx",(3,0,-7),(0,0,0)]];
	var_02 = (-124.5,860,1135);
	var_03 = (0,180,0);
	foreach(var_05 in var_01)
	{
		var_06 = var_05[0];
		var_07 = var_05[1];
		var_08 = var_05[2];
		var_09 = var_05[3];
		var_0A = var_05[4];
		var_0B = var_05[5];
		var_0C = var_02 + rotatevector(var_0A,var_03);
		var_0D = spawn("script_model",var_0C);
		var_0D setmodel(var_07);
		var_0D.angles = var_03 + var_0B;
		var_0D hide();
		var_0D.type = var_06;
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_08),var_0D,var_09);
		var_00[var_00.size] = var_0D;
	}

	var_00 = common_scripts\utility::array_randomize(var_00);
	var_0F = undefined;
	for(;;)
	{
		if(plinko_chute_at_defualt_location())
		{
			self waittill("chute_not_at_default");
		}

		plinko_sq_grenade_cylce(var_00);
		if(isdefined(self.sq_visible_grenade))
		{
			self.sq_visible_grenade hide();
			self.sq_visible_grenade = undefined;
		}
	}
}

//Function Number: 9
plinko_sq_grenade_cylce(param_00)
{
	self endon("chute_at_default");
	for(;;)
	{
		foreach(var_02 in param_00)
		{
			if(isdefined(self.sq_visible_grenade))
			{
				self.sq_visible_grenade hide();
			}

			self.sq_visible_grenade = var_02;
			self.sq_visible_grenade show();
			wait(3);
			while(self.sq_grenade_in_hopper_count)
			{
				wait 0.05;
			}
		}
	}
}

//Function Number: 10
plinko_init_gate(param_00)
{
	if(isdefined(param_00.spawnflags) && param_00.spawnflags & 1)
	{
		param_00 connectpaths();
	}

	param_00.activateexplosivedrone = 1;
	param_00.close_origin = param_00.origin;
	var_01 = common_scripts\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			var_03.script_noteworthy = "open";
		}

		switch(var_03.script_noteworthy)
		{
			case "open":
				param_00.open_origin = var_03.origin;
				break;

			case "close":
				param_00.origin = var_03.origin;
				param_00.close_origin = var_03.origin;
				break;

			default:
				break;
		}
	}

	var_05 = param_00.open_origin - param_00.close_origin;
	param_00.move_dist = length(var_05);
	param_00.move_dir = vectornormalize(var_05);
	self.gates[self.gates.size] = param_00;
}

//Function Number: 11
plinko_run()
{
	self.grenade_round_hopper_count = 0;
	self.pattern_complete_count = [];
	if(isdefined(self.gates.size))
	{
		thread plinko_gates_update_pattern();
	}

	if(self.grenade_hoppers.size)
	{
		thread plinko_run_hopper();
	}

	if(isdefined(self.trigger))
	{
		thread plinko_run_use_trigger();
	}

	thread plinko_sq_grenade_helper();
}

//Function Number: 12
plinko_move_gate(param_00,param_01,param_02)
{
	var_03 = param_00.close_origin + param_00.move_dir * param_01;
	if(var_03 != param_00.origin)
	{
		param_00 moveto(var_03,param_02);
	}
}

//Function Number: 13
plinko_move_gates(param_00,param_01,param_02,param_03,param_04)
{
	self notify("gates_moved");
	var_05 = plinko_calculate_gate_offsets(param_00,param_01,param_02,param_03);
	var_06 = var_05[0];
	var_07 = var_05[1];
	var_08 = var_05[2];
	var_09 = var_05[3];
	plinko_move_gate(self.gate_left,var_06,param_04);
	plinko_move_gate(self.gate_right,var_07,param_04);
	plinko_move_gate(self.gate_top,var_08,param_04);
	plinko_move_gate(self.gate_bottom,var_09,param_04);
	thread maps\mp\mp_zombie_ark_aud::gate_moving(param_04,var_06);
	wait(param_04);
	thread maps\mp\mp_zombie_ark_aud::gate_stopped();
}

//Function Number: 14
plinko_calculate_gate_offsets(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	if(param_00 < 0)
	{
		var_08 = self.gate_left.move_dist * abs(param_00) + param_02 / 2;
		var_04 = min(var_08,self.gate_left.move_dist);
		var_05 = -1 * var_04 + param_02;
	}
	else
	{
		var_09 = self.gate_right.move_dist * param_00 + param_02 / 2;
		var_05 = min(var_09,self.gate_right.move_dist);
		var_04 = -1 * var_05 + param_02;
	}

	if(param_01 < 0)
	{
		var_0A = self.gate_bottom.move_dist * abs(param_01) + param_03 / 2;
		var_07 = min(var_0A,self.gate_bottom.move_dist);
		var_06 = -1 * var_07 + param_03;
	}
	else
	{
		var_0B = self.gate_top.move_dist * param_01 + param_03 / 2;
		var_06 = min(var_0B,self.gate_top.move_dist);
		var_07 = -1 * var_06 + param_03;
	}

	return [var_04,var_05,var_06,var_07];
}

//Function Number: 15
plinko_gates_get_current_loc()
{
	var_00 = distance(self.gate_right.origin,self.gate_right.open_origin);
	var_01 = 1 - var_00 / self.gate_right.move_dist;
	var_02 = distance(self.gate_left.origin,self.gate_left.open_origin);
	var_03 = var_02 / self.gate_left.move_dist - 1;
	var_04 = var_01 + var_03 / 2;
	var_05 = distance(self.gate_top.origin,self.gate_top.open_origin);
	var_06 = 1 - var_05 / self.gate_top.move_dist;
	var_07 = distance(self.gate_bottom.origin,self.gate_bottom.open_origin);
	var_08 = var_07 / self.gate_bottom.move_dist - 1;
	var_09 = var_06 + var_08 / 2;
	return [var_04,var_09];
}

//Function Number: 16
plinko_gates_get_center()
{
	var_00 = self.gate_right.origin + self.gate_left.origin / 2;
	var_01 = self.gate_top.origin[2] + self.gate_bottom.origin[2] / 2;
	var_00 = (var_00[0],var_00[1],var_01);
	return var_00;
}

//Function Number: 17
plinko_gates_pattern_close_when_looked_at(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 1;
	var_07 = 0.999;
	var_08 = plinko_gates_get_center();
	for(;;)
	{
		var_09 = 0;
		foreach(var_0B in level.players)
		{
			var_0C = anglestoforward(var_0B getplayerangles());
			var_0D = vectornormalize(var_08 - var_0B getvieworigin());
			var_0E = vectordot(var_0C,var_0D);
			if(var_0E > var_07)
			{
				var_09 = 1;
				break;
			}
		}

		if(var_09 && var_06)
		{
			var_10 = plinko_gates_get_current_loc();
			var_11 = var_10[0];
			var_12 = var_10[1];
			plinko_move_gates(var_11,var_12,0,0,param_05);
			var_06 = 0;
		}
		else if(!var_09 && !var_06)
		{
			plinko_move_gates(param_00,param_01,param_02,param_03,param_04);
			var_06 = 1;
		}

		wait 0.05;
	}
}

//Function Number: 18
plinko_gates_update_pattern()
{
	self notify("new_pattern");
	self endon("new_pattern");
	var_00 = self.gate_left.move_dist + self.gate_right.move_dist;
	var_01 = self.gate_top.move_dist + self.gate_bottom.move_dist;
	var_02 = min(var_00,var_01);
	if(self.force_open)
	{
		self.force_open = 0;
		var_03 = plinko_gates_get_current_loc();
		var_04 = var_03[0];
		var_05 = var_03[1];
		plinko_move_gates(var_04,var_05,var_00,var_01,0.2);
		wait(3);
	}

	var_06 = plinko_gates_get_current_loc();
	var_04 = var_06[0];
	var_05 = var_06[1];
	plinko_move_gates(var_04,var_05,0,0,0.1);
	wait(0.1);
	plinko_move_gates(0,0,0,0,0.2);
	wait(1);
	var_07 = self.pattern_complete_count[self.grenade_round_hopper_count];
	if(!isdefined(var_07))
	{
		var_07 = 0;
	}

	if(self.grenade_round_hopper_count == 0)
	{
		if(var_07 == 0)
		{
			plinko_move_gates(0,0,var_02,var_02,1);
			return;
		}

		if(var_07 == 1)
		{
			var_08 = common_scripts\utility::random([-1,-0.5,0.5,1]);
			plinko_move_gates(var_08,0,var_02,var_02,1);
			return;
		}

		if(var_07 == 2)
		{
			var_09 = common_scripts\utility::random([-1,0,1]);
			plinko_move_gates(0,var_09,var_02 * 0.8,var_02 * 0.8,1);
			return;
		}

		if(var_09 == 3)
		{
			var_08 = common_scripts\utility::random([-1,-0.5,0.5,1]);
			var_09 = common_scripts\utility::random([-1,0,1]);
			plinko_move_gates(var_08,var_09,var_02 * 0.6,var_02 * 0.6,1);
			return;
		}

		if(var_08 == 4)
		{
			var_08 = randomfloatrange(-1,1);
			var_09 = randomfloatrange(-1,1);
			plinko_move_gates(var_08,var_09,var_02 * 0.5,var_02 * 0.5,1);
			return;
		}

		var_08 = randomfloatrange(-1,1);
		var_09 = randomfloatrange(-1,1);
		plinko_move_gates(var_08,var_09,var_02 * 0.4,var_02 * 0.4,1);
		return;
	}

	if(self.grenade_round_hopper_count == 1)
	{
		var_0A = 1.5;
		var_0B = 0.5;
		if(var_08 == 0)
		{
			var_0A = 3.5;
			var_0B = 1;
		}

		if(var_08 == 1)
		{
			var_0A = 3;
			var_0B = 1;
		}
		else if(var_08 == 2)
		{
			var_0A = 2.5;
			var_0B = 1;
		}
		else if(var_08 == 3)
		{
			var_0A = 2;
			var_0B = 0.75;
		}
		else if(var_08 == 4)
		{
			var_0A = 1.75;
			var_0B = 0.75;
		}

		var_0C = randomintrange(0,2) * 2 - 1;
		plinko_move_gates(var_0C,0,var_04 * var_0B,var_04 * var_0B,var_0A / 2);
		for(;;)
		{
			var_0C = var_0C * -1;
			plinko_move_gates(var_0C,0,var_04 * var_0B,var_04 * var_0B,var_0A);
		}

		return;
	}

	if(self.grenade_round_hopper_count == 2)
	{
		var_0A = 1.5;
		var_0D = 0;
		var_0B = 0.5;
		if(var_08 == 0)
		{
			var_0A = 3.5;
			var_0D = 0.75;
			var_0B = 1;
		}
		else if(var_08 == 1)
		{
			var_0A = 3;
			var_0D = 0.5;
			var_0B = 0.9;
		}
		else if(var_08 == 2)
		{
			var_0A = 2.5;
			var_0D = 0.5;
			var_0B = 0.8;
		}
		else if(var_08 == 3)
		{
			var_0A = 2;
			var_0D = 0.5;
			var_0B = 0.7;
		}
		else if(var_08 == 4)
		{
			var_0A = 1.5;
			var_0D = 0.25;
			var_0B = 0.7;
		}

		var_0C = randomintrange(0,2) * 2 - 1;
		for(;;)
		{
			plinko_move_gates(var_0C,0,var_04 * var_0B,var_04 * var_0B,0.2);
			wait(var_0D);
			plinko_move_gates(var_0C * -1,0,var_04 / 4,var_04 / 4,2);
			wait(var_0D);
			var_0C = var_0C * -1;
		}

		return;
	}

	if(self.grenade_round_hopper_count == 3)
	{
		var_0E = 0.4;
		var_0F = 0;
		var_0B = 0.3;
		if(var_08 == 0)
		{
			var_0E = 1;
			var_0F = 1;
			var_0B = 0.7;
		}
		else if(var_08 == 1)
		{
			var_0E = 0.8;
			var_0F = 1;
			var_0B = 0.7;
		}
		else if(var_08 == 2)
		{
			var_0E = 0.7;
			var_0F = 0.8;
			var_0B = 0.6;
		}
		else if(var_08 == 3)
		{
			var_0E = 0.6;
			var_0F = 0.6;
			var_0B = 0.5;
		}
		else if(var_08 == 4)
		{
			var_0E = 0.5;
			var_0F = 0.4;
			var_0B = 0.4;
		}

		var_0C = randomintrange(0,2) * 2 - 1;
		var_10 = randomintrange(0,2) * 2 - 1;
		plinko_move_gates(0,var_10,var_04 * var_0B,var_04 * var_0B,0.5 * var_0E);
		for(;;)
		{
			plinko_move_gates(var_0C,var_10 * -1,var_04 * var_0B,var_04 * var_0B,2 * var_0E);
			wait(0.5 * var_0F);
			plinko_move_gates(0,var_10,var_04 * var_0B,var_04 * var_0B,2 * var_0E);
			plinko_move_gates(var_0C * -1,var_10 * -1,var_04 * var_0B,var_04 * var_0B,2 * var_0E);
			wait(0.5 * var_0F);
			plinko_move_gates(0,var_10,var_04 * var_0B,var_04 * var_0B,2 * var_0E);
		}

		return;
	}

	var_0E = 0.2;
	var_0F = 0;
	var_0B = 0.3;
	if(var_08 == 0)
	{
		var_0E = 1;
		var_0F = 1;
		var_0B = 1;
	}
	else if(var_08 == 1)
	{
		var_0E = 0.75;
		var_0F = 0.75;
		var_0B = 0.8;
	}
	else if(var_08 == 2)
	{
		var_0E = 0.5;
		var_0F = 0.5;
		var_0B = 0.6;
	}
	else if(var_08 == 3)
	{
		var_0E = 0.35;
		var_0F = 0.35;
		var_0B = 0.5;
	}
	else if(var_08 == 4)
	{
		var_0E = 0.25;
		var_0F = 0.25;
		var_0B = 0.4;
	}

	for(;;)
	{
		var_11 = max(var_04 * 0.2,randomfloatrange(0,var_04) * var_0B);
		var_12 = max(var_04 * 0.2,randomfloatrange(0,var_04) * var_0B);
		var_13 = randomfloatrange(-1,1);
		var_14 = randomfloatrange(-1,1);
		var_15 = randomfloatrange(0.5,1) * var_0E;
		var_0D = randomfloatrange(0.25,1) * var_0F;
		plinko_move_gates(var_13,var_14,var_11,var_12,var_15);
		wait(var_0D);
	}
}

//Function Number: 19
plinko_reset_grenade_round_hopper_count()
{
	for(;;)
	{
		level waittill("zombie_wave_ended");
		for(var_00 = 0;var_00 < self.grenade_round_hopper_count;var_00++)
		{
			if(!isdefined(self.pattern_complete_count[var_00]))
			{
				self.pattern_complete_count[var_00] = 0;
			}

			self.pattern_complete_count[var_00] = int(min(self.pattern_complete_count[var_00] + 1,5));
		}

		self.grenade_round_hopper_count = 0;
		plinko_gates_update_pattern();
	}
}

//Function Number: 20
plinko_run_hopper()
{
	thread plinko_reset_grenade_round_hopper_count();
	thread plinko_grenade_watch();
}

//Function Number: 21
plinko_grenade_watch()
{
	foreach(var_01 in level.players)
	{
		thread plinko_player_grenade_watch(var_01);
	}

	for(;;)
	{
		level waittill("connected",var_01);
		thread plinko_player_grenade_watch(var_01);
		thread plinko_player_missile_watch(var_01);
	}
}

//Function Number: 22
plinko_player_missile_watch(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("missile_fire",var_01,var_02);
		thread plinko_grenade_in_hopper_watch(var_01,var_02,param_00);
	}
}

//Function Number: 23
plinko_player_grenade_watch(param_00)
{
	param_00 endon("disconnect");
	param_00.plinkousecount = 0;
	for(;;)
	{
		param_00 waittill("grenade_fire",var_01,var_02);
		if(isdefined(var_02) && var_02 == "repulsor_zombie_mp")
		{
			continue;
		}

		thread plinko_grenade_in_hopper_watch(var_01,var_02,param_00);
	}
}

//Function Number: 24
plinko_grenade_in_hopper_watch(param_00,param_01,param_02)
{
	param_00 endon("death");
	for(;;)
	{
		if(plinko_do_grenade_in_hopper_test(param_00,param_01,param_02))
		{
			return;
		}

		wait 0.05;
	}
}

//Function Number: 25
plink_do_grenade_in_all_hoppers_test(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray("plinko","targetname");
	foreach(var_05 in var_03)
	{
		if(var_05 plinko_do_grenade_in_hopper_test(param_00,param_01,param_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
plinko_do_grenade_in_hopper_test(param_00,param_01,param_02)
{
	foreach(var_04 in self.grenade_hoppers)
	{
		if(ispointinvolume(param_00.origin,var_04))
		{
			thread plinko_grenade_in_hopper(param_00,param_01,param_02,var_04);
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
plinko_sq_grenade_hopper_count()
{
	self.sq_grenade_in_hopper_count++;
	wait(0.45);
	self.sq_grenade_in_hopper_count--;
}

//Function Number: 28
plinko_grenade_in_hopper(param_00,param_01,param_02,param_03)
{
	thread maps\mp\mp_zombie_ark_aud::grenade_in_hopper();
	param_01 = getweaponbasename(param_01);
	if(!plinko_chute_at_defualt_location())
	{
		switch(param_01)
		{
			case "contact_grenade_throw_zombies_mp":
			case "contact_grenade_zombies_mp":
			case "frag_grenade_throw_zombies_mp":
			case "frag_grenade_zombies_mp":
				if(isdefined(self.sq_visible_grenade))
				{
					thread plinko_sq_grenade_hopper_count();
					param_01 = self.sq_visible_grenade.type;
				}
				break;

			default:
				break;
		}
	}

	var_04 = 1;
	switch(param_01)
	{
		case "sq_frag":
		case "frag_grenade_throw_zombies_mp":
		case "frag_grenade_zombies_mp":
			thread plinko_frag_grenade_in_hopper(param_00,param_01,param_02,param_03);
			break;

		case "contact_grenade_throw_zombies_mp":
		case "contact_grenade_zombies_mp":
			thread plinko_contact_grenade_in_hopper(param_00,param_01,param_02,param_03);
			break;

		case "sq_explosive_drone":
		case "explosive_drone_throw_zombie_mp":
		case "explosive_drone_zombie_mp":
			if(plinko_ent_linked_to_gates(param_00))
			{
				var_04 = 0;
			}
			else
			{
				thread plinko_explosive_drone_in_hopper(param_00,param_01,param_02,param_03);
			}
			break;

		case "sq_distraction_drone":
		case "distraction_drone_throw_zombie_mp":
		case "distraction_drone_zombie_mp":
			thread plinko_distraction_drone_in_hopper(param_00,param_01,param_02,param_03);
			break;

		case "sq_dna_grenade":
		case "dna_aoe_grenade_zombie_mp":
		case "dna_aoe_grenade_throw_zombie_mp":
			thread plinko_aoe_grenade_in_hopper(param_00,param_01,param_02,param_03);
			break;

		case "teleport_throw_zombies_mp":
		case "teleport_zombies_mp":
			thread plinko_teleport_grenade_in_hopper(param_00,param_01,param_02,param_03);
			break;

		case "iw5_mahemzm_mp":
		case "iw5_exocrossbowzm_mp":
			if(isdefined(self.pattern_complete_count[self.grenade_round_hopper_count]) && self.pattern_complete_count[self.grenade_round_hopper_count] > 0)
			{
				self.pattern_complete_count[self.grenade_round_hopper_count]--;
			}
	
			plinko_gates_update_pattern();
			var_04 = 0;
			break;

		default:
			var_04 = 0;
			break;
	}

	if(var_04)
	{
		self.grenade_round_hopper_count++;
		plinko_gates_update_pattern();
	}
}

//Function Number: 29
plinko_grenade_destroy(param_00)
{
	playfx(common_scripts\utility::getfx("plinko_grenade_break"),param_00.origin,self.fx_dir);
	playsoundatpos(param_00.origin,"plinko_grenade_destroyed");
	param_00 delete();
}

//Function Number: 30
plinko_grenade_fx_play(param_00,param_01,param_02)
{
	param_00.fx_name = param_01;
	param_00.fx_tag = param_02;
	playfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
}

//Function Number: 31
plinko_grenade_fx_stop(param_00)
{
	stopfxontag(common_scripts\utility::getfx(param_00.fx_name),param_00,param_00.fx_tag);
}

//Function Number: 32
plinko_frag_grenade_in_hopper(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_00.origin);
	param_00 delete();
	wait 0.05;
	var_05 = "npc_exo_launcher_grenade";
	var_04 setmodel(var_05);
	var_04.angles = (0,-90,0);
	plinko_grenade_fx_play(var_04,"plinko_fraggrenade_trail","tag_fx");
	var_04.object_offset = (0,0,2);
	wait(0.4);
	plinko_run_grenade(var_04,param_02);
	wait(1);
	plinko_grenade_destroy(var_04);
}

//Function Number: 33
plinko_contact_grenade_in_hopper(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_00.origin);
	param_00 delete();
	wait 0.05;
	var_05 = "npc_exo_launcher_grenade";
	var_04 setmodel(var_05);
	var_04.angles = (0,-90,0);
	plinko_grenade_fx_play(var_04,"plinko_contactgrenade_trail","tag_fx");
	var_04.object_offset = (0,0,2);
	wait(0.4);
	plinko_run_grenade(var_04,param_02);
	wait(1);
	plinko_grenade_destroy(var_04);
}

//Function Number: 34
plinko_explosive_drone_in_hopper(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_00.origin);
	param_00 delete();
	wait 0.05;
	var_05 = "npc_drone_explosive_main";
	var_04 setmodel(var_05);
	var_04.angles = (0,90,-90);
	plinko_grenade_fx_play(var_04,"plinko_explosive_drone_trail","TAG_BEACON");
	var_04.object_type = "explosive_drone";
	var_04.object_offset = (2,0,2);
	var_04.socketed = 0;
	var_04.socketed_fx_name = "plinko_explosive_drone_socket";
	var_04.socketed_fx_tag = "TAG_BEACON";
	wait(0.4);
	plinko_run_grenade(var_04,param_02);
	wait(1);
	if(!var_04.socketed)
	{
		plinko_grenade_destroy(var_04);
	}
}

//Function Number: 35
plinko_distraction_drone_in_hopper(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_00.origin);
	param_00 delete();
	wait 0.05;
	var_05 = "dlc_distraction_drone_01_scaled_closed";
	var_04 setmodel(var_05);
	var_04.angles = (45,-90,90);
	plinko_grenade_fx_play(var_04,"plinko_distract_drone_trail","tag_weapon");
	var_04.object_type = "distraction_drone";
	var_04.object_offset = (0,0,2);
	var_04.socketed = 0;
	var_04.socketed_fx_name = "plinko_distract_drone_socket";
	var_04.socketed_fx_tag = "tag_origin";
	wait(0.4);
	plinko_run_grenade(var_04,param_02);
	if(!var_04.socketed)
	{
		wait(1);
		plinko_grenade_destroy(var_04);
		return;
	}

	var_04 setmodel("dlc_distraction_drone_01_scaled_open");
	thread plinko_distraction_drone_spin(var_04);
}

//Function Number: 36
plinko_distraction_drone_spin(param_00)
{
	param_00 endon("death");
	param_00 thread audio_distraction_drone_sound();
	var_01 = (720,0,0);
	for(;;)
	{
		param_00 rotatevelocity(var_01,600);
		wait(600);
	}
}

//Function Number: 37
plinko_ent_linked_to_gates(param_00)
{
	var_01 = param_00 getlinkedparent();
	if(isdefined(var_01))
	{
		foreach(var_03 in self.gates)
		{
			if(var_03 == var_01)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 38
audio_distraction_drone_sound()
{
	self playloopsound("plinko_dist_gren_spin_lp");
}

//Function Number: 39
plinko_aoe_grenade_in_hopper(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_00.origin);
	param_00 notify("dud_explode");
	param_00 delete();
	wait 0.05;
	var_05 = "npc_exo_launcher_grenade";
	var_04 setmodel(var_05);
	var_04.angles = (0,-90,0);
	plinko_grenade_fx_play(var_04,"plinko_dnagrenade_trail","tag_fx");
	var_04.object_type = "aoe_grenade";
	var_04.object_offset = (2,0,0);
	var_04.socketed = 0;
	var_04.socketed_fx_name = "plinko_dna_grenade_socket";
	var_04.socketed_fx_tag = "tag_fx";
	wait(0.4);
	plinko_run_grenade(var_04,param_02);
	var_04 thread audio_aoe_grenade_socketed();
	wait(1);
	if(!var_04.socketed)
	{
		plinko_grenade_destroy(var_04);
	}
}

//Function Number: 40
audio_aoe_grenade_socketed()
{
	self playloopsound("plinko_aoe_lp");
}

//Function Number: 41
plinko_teleport_grenade_in_hopper(param_00,param_01,param_02,param_03)
{
	if(common_scripts\utility::flag("sq_plinko"))
	{
		if(isdefined(self.chute) && self.chute.locations.size)
		{
			self.chute.locations = common_scripts\utility::array_randomize(self.chute.locations);
			foreach(var_05 in self.chute.locations)
			{
				if(var_05 == self.chute.current_location)
				{
					continue;
				}

				plinko_set_chute_location(var_05);
				playsoundatpos(self.origin,"plinko_chute_teleport");
				break;
			}
		}
	}

	var_07 = spawn("script_model",param_00.origin);
	param_00 delete();
	wait 0.05;
	var_08 = "dlc3_teleport_grenade_01";
	var_07 setmodel(var_08);
	var_07.angles = (0,-90,0);
	plinko_grenade_fx_play(var_07,"plinko_teleportgrenade_trail","tag_fx");
	var_07.object_offset = (0,0,3);
	wait(0.4);
	plinko_run_grenade(var_07,param_02);
	wait(1);
	plinko_grenade_destroy(var_07);
}

//Function Number: 42
plinko_run_use_trigger()
{
	var_00 = 300;
	var_01 = 3;
	for(;;)
	{
		self.trigger setcursorhint("HINT_NOICON");
		self.trigger sethintstring("Activate Plinko");
		self.trigger setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_00));
		self.trigger waittill("trigger",var_02);
		var_03 = plinko_get_available_token();
		if(!isdefined(var_03))
		{
			continue;
		}

		if(!var_02 maps\mp\gametypes\zombies::attempttobuy(var_00))
		{
			continue;
		}

		self.trigger sethintstring("");
		self.trigger setsecondaryhintstring("");
		thread plinko_run_token(var_03,var_02);
		plinko_use_wait();
	}
}

//Function Number: 43
plinko_use_wait()
{
	var_00 = 0.2;
	var_01 = gettime();
	var_02 = plinko_get_available_token();
	if(!isdefined(var_02))
	{
		self waittill("token_available");
	}

	var_03 = gettime() - var_01 / 1000;
	if(var_03 < var_00)
	{
		wait(var_00 - var_03);
	}
}

//Function Number: 44
plinko_run_grenade(param_00,param_01)
{
	var_02 = common_scripts\utility::random(self.starts);
	param_00.origin = var_02.origin;
	param_00.angles = param_00.angles + var_02.angles;
	wait 0.05;
	plinko_run_move(var_02,param_00,param_01);
}

//Function Number: 45
plinko_run_token(param_00,param_01)
{
	param_00.inuse = 1;
	param_00 show();
	var_02 = common_scripts\utility::random(self.starts);
	param_00 dontinterpolate();
	param_00.origin = var_02.origin;
	wait(1);
	plinko_run_move(var_02,param_00,param_01);
	wait(1);
	param_00.inuse = 0;
	param_00 hide();
	self notify("token_available");
}

//Function Number: 46
plinko_give_achievement(param_00)
{
	if(isdefined(param_00) && param_00.plinkousecount == 30)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_PLINKO");
	}
}

//Function Number: 47
plinko_run_move(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		param_02.plinkousecount++;
		plinko_give_achievement(param_02);
	}

	var_03 = (0,0,-800);
	if(!isdefined(param_01.object_offset))
	{
		param_01.object_offset = (0,0,0);
	}

	if(isdefined(param_00.angles))
	{
		param_01.object_offset = rotatevector(param_01.object_offset,param_00.angles);
		param_01.angles = param_01.angles + param_00.angles;
	}

	if(!isdefined(param_01.object_type))
	{
		param_01.object_type = "default";
	}

	var_04 = 0;
	for(;;)
	{
		var_05 = plinko_new_link(param_00);
		var_06 = plinko_next_link(var_05,param_01.object_type);
		if(!isdefined(var_06))
		{
			break;
		}

		var_07 = var_06.node;
		var_08 = plinko_object_type_can_socket(param_01.object_type) && plinko_origin_type(var_07) == "socket";
		var_09 = param_01.origin;
		var_0A = var_07.origin;
		if(var_08)
		{
			param_01.socketed = 1;
			var_07.socket_object = param_01;
			var_0A = var_0A + param_01.object_offset * (1,1,0);
		}
		else
		{
			var_0A = var_0A + param_01.object_offset;
		}

		var_0B = distance2d(var_09,var_0A);
		var_0C = abs(var_09[2] - var_0A[2]);
		var_0D = 0.2;
		if(var_0B > 0)
		{
			var_0D = var_0D + 0.2;
		}

		if(var_0C > 40)
		{
			var_0D = var_0D + 0.1;
		}

		var_0D = ceil(var_0D / 0.05) * 0.05;
		var_0E = trajectorycalculateinitialvelocity(var_09,var_0A,var_03,var_0D);
		param_01 movegravity(var_0E,var_0D);
		wait(var_0D + 0.05);
		if(!isdefined(param_01))
		{
			break;
		}

		var_04++;
		thread maps\mp\zombies\_zombies_audio::plinko_clink(param_01,var_04);
		var_0F = var_06.parent_link;
		while(isdefined(var_0F))
		{
			var_10 = var_0F.node.socket_object;
			if(isdefined(var_10))
			{
				plinko_grenade_destroy(var_10);
			}

			var_0F = var_0F.parent_link;
		}

		if(var_08)
		{
			if(isdefined(param_01.socketed_fx_name))
			{
				plinko_grenade_fx_stop(param_01);
				plinko_grenade_fx_play(param_01,param_01.socketed_fx_name,param_01.socketed_fx_tag);
			}

			break;
		}

		plinko_give_reward(var_07,param_02,param_01);
		param_00 = var_07;
	}

	if(isdefined(param_01))
	{
		playsoundatpos(param_01.origin,"plinko_socketed");
	}
}

//Function Number: 48
plinko_object_type_can_socket(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "aoe_grenade":
		case "distraction_drone":
		case "explosive_drone":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 49
plinko_give_reward(param_00,param_01,param_02)
{
	reward(param_00.script_noteworthy,param_01,param_02);
}

//Function Number: 50
plinko_new_link(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.node = param_00;
	var_02.parent_link = param_01;
	return var_02;
}

//Function Number: 51
plinko_next_link(param_00,param_01)
{
	var_02 = plinko_next_links(param_00,param_01);
	if(!var_02.size)
	{
		return undefined;
	}

	var_03 = common_scripts\utility::random(var_02);
	return var_03;
}

//Function Number: 52
plinko_next_links(param_00,param_01)
{
	var_02 = [];
	var_03 = param_00.node;
	var_04 = var_03 get_linked_structs();
	foreach(var_06 in var_04)
	{
		if(plinko_origin_type(var_06) == "socket" && isdefined(var_06.socket_object) || !plinko_object_type_can_socket(param_01))
		{
			var_07 = var_06 get_linked_structs();
			if(isdefined(var_06.socket_object))
			{
				var_08 = var_06.socket_object.object_type + "_with_socket";
			}
			else
			{
				var_08 = "without_socket";
			}

			foreach(var_0A in var_07)
			{
				var_0B = var_0A.script_parameters;
				if(var_0B == var_08)
				{
					var_0C = plinko_new_link(var_0A,plinko_new_link(var_06,param_00));
					var_02 = common_scripts\utility::array_combine(plinko_next_links(var_0C,param_01),var_02);
				}
			}

			continue;
		}

		var_02[var_02.size] = plinko_new_link(var_06,param_00);
	}

	return var_02;
}

//Function Number: 53
plinko_origin_type(param_00)
{
	if(!isdefined(param_00.script_parameters))
	{
		return "default";
	}

	return param_00.script_parameters;
}

//Function Number: 54
plinko_get_available_token()
{
	foreach(var_01 in self.tokens)
	{
		if(!var_01.inuse)
		{
			return var_01;
		}
	}

	return undefined;
}

//Function Number: 55
get_linked_structs()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = common_scripts\utility::get_links();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = common_scripts\utility::getstruct(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 56
plinko_sq_goal(param_00)
{
	var_01 = "sq_plinko_" + param_00.script_parameters;
	thread plinko_sq_goal_fx(param_00);
	common_scripts\utility::flag_wait("sq_plinko");
}

//Function Number: 57
plinko_sq_goal_fx(param_00)
{
	var_01 = undefined;
	var_02 = "sq_plinko_" + param_00.script_parameters;
	for(;;)
	{
		if(common_scripts\utility::flag("sq_plinko"))
		{
			var_03 = "plinko_light_red";
			if(common_scripts\utility::flag(var_02))
			{
				var_03 = "plinko_light_green";
			}

			if(!isdefined(var_01) || var_01.name != var_03)
			{
				if(isdefined(var_01))
				{
					var_01 delete();
				}

				var_01 = spawnfx(common_scripts\utility::getfx(var_03),param_00.origin);
				var_01.name = var_03;
				triggerfx(var_01);
			}
		}
		else if(isdefined(var_01))
		{
			wait(3);
			var_01 delete();
		}

		level common_scripts\utility::waittill_any(var_02,"sq_plinko");
	}
}

//Function Number: 58
plinko_sq_geo(param_00)
{
	var_01 = param_00.origin;
	var_02 = common_scripts\utility::getstruct(param_00.target,"targetname").origin;
	param_00.origin = var_02;
	common_scripts\utility::flag_wait("sq_plinko");
	param_00 moveto(var_01,1);
	common_scripts\utility::flag_waitopen("sq_plinko");
	param_00 moveto(var_02,1);
}

//Function Number: 59
discoverplinkologic(param_00)
{
	level notify("discoverPlinkoLogic");
	level endon("discoverPlinkoLogic");
	var_01 = 90000;
	var_02 = 0.7;
	while(!isdefined(level.players) || level.players.size == 0)
	{
		wait 0.05;
	}

	foreach(var_04 in level.players)
	{
		var_04.plinkodiscovered = undefined;
	}

	var_06 = 0;
	var_07 = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(param_00.origin);
	while(var_06 < level.players.size)
	{
		foreach(var_04 in level.players)
		{
			if(maps\mp\zombies\_util::is_true(var_04.plinkodiscovered))
			{
				continue;
			}

			if(!maps\mp\zombies\_zombies_zone_manager::playerisinzone(var_04,var_07))
			{
				continue;
			}

			var_09 = distance2dsquared(var_04.origin,param_00.origin);
			if(var_09 > var_01)
			{
				continue;
			}

			var_0A = anglestoforward(var_04 getplayerangles());
			var_0B = vectornormalize(param_00.origin - var_04.origin);
			var_0C = vectordot(var_0A,var_0B);
			if(var_0C >= var_02)
			{
				var_0D = 0;
				if(isdefined(level.zmbfindgamblecustomvo))
				{
					var_0D = [[ level.zmbfindgamblecustomvo ]](var_04,param_00);
				}
				else
				{
					var_0D = var_04 playerplinkovosee();
				}

				if(var_0D)
				{
					var_04.plinkodiscovered = 1;
					var_06++;
					wait(15);
					break;
				}
			}
		}

		wait(0.1);
	}

	foreach(var_04 in level.players)
	{
		var_04.plinkodiscovered = undefined;
	}
}

//Function Number: 60
playerplinkovosee()
{
	return maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","plinko_see");
}

//Function Number: 61
playerplinkoplaypayoutvo(param_00)
{
	self endon("disconnect");
	wait(1);
	if(param_00 <= 200)
	{
		playerplinkovopayoutsmall();
		return;
	}

	if(param_00 >= 750)
	{
		playerplinkovopayoutlarge();
		return;
	}

	playerplinkovopayoutmedium();
}

//Function Number: 62
playerplinkovopayoutsmall()
{
	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","plinko_small");
}

//Function Number: 63
playerplinkovopayoutmedium()
{
	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","plinko_med");
}

//Function Number: 64
playerplinkovopayoutlarge()
{
	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","plinko_lrg");
}