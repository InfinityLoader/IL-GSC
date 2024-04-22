/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_mutators_teleport.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 149 ms
 * Timestamp: 4/22/2024 2:13:49 AM
*******************************************************************/

//Function Number: 1
initteleportmutator()
{
	level._effect["teleport_pre_fx"] = loadfx("vfx/unique/dlc_teleport_zm_start");
	level._effect["teleport_post_fx"] = loadfx("vfx/unique/dlc_teleport_zombie");
	maps\mp\zombies\_mutators::addmutatortotable("teleport",::mutatorteleport,"zmb_mut_emz_spawn");
	maps\mp\zombies\_mutators::disablemutatorfortypes("teleport",["zombie_ranged_goliath"]);
}

//Function Number: 2
mutatorteleport()
{
	if(self.agent_type == "zombie_dog")
	{
		mutatorteleport_base();
		return;
	}

	if(!maps\mp\zombies\_util::is_true(self.nomutatormodelswap))
	{
		var_00 = ["zom_blink_torso_a_slice"];
		var_01 = ["zom_blink_torso_a_slice"];
		var_02 = ["zom_blink_head_a"];
		var_03 = ["zom_blink_r_leg_a_slice"];
		var_04 = ["zom_blink_r_leg_a_slice"];
		var_05 = ["zom_blink_l_leg_a_slice"];
		var_06 = ["zom_blink_l_leg_a_slice"];
		var_07 = ["zom_blink_r_arm_a_slice"];
		var_08 = ["zom_blink_r_arm_a_slice"];
		var_09 = ["zom_blink_l_arm_a_slice"];
		var_0A = ["zom_blink_l_arm_a_slice"];
		var_0B = randomint(var_00.size);
		var_0C = randomint(var_02.size);
		var_0D = randomint(var_03.size);
		var_0E = randomint(var_05.size);
		var_0F = randomint(var_07.size);
		var_10 = randomint(var_09.size);
		self.precloneswapfunc = ::maps\mp\zombies\_mutators::mutator_precloneswap;
		self detachall();
		self setmodel(var_00[var_0B]);
		self.swapbody = var_01[var_0B];
		self attach(var_02[var_0C]);
		self.headmodel = var_02[var_0C];
		self attach(var_03[var_0D]);
		self attach(var_05[var_0E]);
		self attach(var_07[var_0F]);
		self attach(var_09[var_10]);
		self.limbmodels["right_leg"] = var_03[var_0D];
		self.limbmodels["left_leg"] = var_05[var_0E];
		self.limbmodels["right_arm"] = var_07[var_0F];
		self.limbmodels["left_arm"] = var_09[var_10];
		self.swaplimbmodels["right_leg"] = var_04[var_0D];
		self.swaplimbmodels["left_leg"] = var_06[var_0E];
		self.swaplimbmodels["right_arm"] = var_08[var_0F];
		self.swaplimbmodels["left_arm"] = var_0A[var_10];
	}

	mutatorteleport_base();
}

//Function Number: 3
mutatorteleport_base()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("teleport");
	mutatorteleport_startfx();
	thread mutatorteleport_handleteleport();
	self waittill("death");
}

//Function Number: 4
mutatorteleport_startfx()
{
	mutatorteleport_starteyefx();
	mutatorteleport_startbodyfx();
}

//Function Number: 5
mutatorteleport_starteyefx()
{
	if(self.agent_type == "zombie_dog")
	{
		maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_emp");
		return;
	}

	if(isdefined(self.eyefxfunc))
	{
		self [[ self.eyefxfunc ]]();
		return;
	}

	maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_emp");
}

//Function Number: 6
mutatorteleport_startbodyfx()
{
}

//Function Number: 7
mutatorteleport_handleteleport()
{
	self endon("death");
	maps\mp\zombies\_util::waittill_enter_game();
	for(;;)
	{
		self.teleport_min_time_between = 0.5 / self.generalspeedratescale;
		self.teleport_max_time_between = 3.2 / self.generalspeedratescale;
		wait(randomfloatrange(self.teleport_min_time_between,self.teleport_max_time_between));
		if(!isalive(self))
		{
			continue;
		}

		if(self.aistate != "move")
		{
			continue;
		}

		if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || maps\mp\zombies\_util::is_true(self.inturnanim))
		{
			continue;
		}

		if(maps\mp\zombies\_util::is_true(self.hasexploded))
		{
			continue;
		}

		if(isdefined(self.spikeblastready))
		{
			continue;
		}

		var_00 = anglestoforward(self.angles);
		var_01 = self scragentgetnodesonpath();
		var_02 = self getpathgoalpos();
		var_03 = distancesquared(self.origin,var_02);
		var_04 = [];
		self.teleport_min_dist_sq = squared(50 * self.generalspeedratescale);
		self.teleport_max_dist_sq = squared(450 * self.generalspeedratescale);
		for(var_05 = 0;var_05 < var_01.size;var_05++)
		{
			var_06 = var_01[var_05];
			var_07 = distancesquared(self.origin,var_06.origin);
			if(var_07 < self.teleport_min_dist_sq)
			{
				continue;
			}

			if(var_07 > self.teleport_max_dist_sq)
			{
				continue;
			}

			if(var_07 > var_03)
			{
				continue;
			}

			var_08 = vectornormalize(var_06.origin - self.origin);
			var_09 = vectordot(var_08,var_00);
			if(var_09 < 0)
			{
				continue;
			}

			var_04[var_04.size] = [var_06,var_05];
		}

		if(var_04.size > 0)
		{
			var_0A = common_scripts\utility::random(var_04);
			var_0B = var_0A[0];
			var_0C = var_0A[1];
			if(var_0C + 1 < var_01.size)
			{
				var_0D = var_01[var_0C + 1].origin - var_0B.origin;
			}
			else
			{
				var_0D = var_03 - var_0C.origin;
			}

			var_0E = vectortoangles(var_0D * (1,1,0));
			if(isdefined(self.teleportprefxoverride))
			{
				playfx(self.teleportprefxoverride,self.origin,(1,0,0),(0,0,1));
			}
			else
			{
				playfx(level._effect["teleport_pre_fx"],self.origin,(1,0,0),(0,0,1));
			}

			if(isdefined(self.teleportpostfxoverride))
			{
				playfx(self.teleportpostfxoverride,var_0B.origin,(1,0,0),(0,0,1));
			}
			else
			{
				playfx(level._effect["teleport_post_fx"],var_0B.origin,(1,0,0),(0,0,1));
			}

			thread play_zombie_teleport_sound();
			var_0F = self getvelocity();
			self setorigin(var_0B.origin,1);
			self setplayerangles(var_0E);
			self setvelocity(anglestoforward(var_0E) * length(var_0F));
			self scragenttrimpath(var_0B);
			wait(0.05);
			mutatorteleport_startfx();
		}
	}
}

//Function Number: 8
play_zombie_teleport_sound()
{
	if(self.agent_type == "zombie_generic")
	{
		self playsoundonmovingent("teleport_blink_zombie");
		return;
	}

	if(self.agent_type == "zombie_dog")
	{
		self playsoundonmovingent("teleport_dog_zombie");
		return;
	}

	if(self.agent_type == "zombie_melee_goliath")
	{
		self playsoundonmovingent("teleport_goliath_zombie");
		return;
	}

	self playsoundonmovingent("teleport_blink_zombie");
}