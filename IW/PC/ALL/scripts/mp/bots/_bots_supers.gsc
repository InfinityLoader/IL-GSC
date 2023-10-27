/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_supers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 303 ms
 * Timestamp: 10/27/2023 12:27:47 AM
*******************************************************************/

//Function Number: 1
func_2EA3()
{
	level.var_2D1D["super_claw"] = ::func_89EF;
	level.var_2D1D["super_steeldragon"] = ::func_89EF;
	level.var_2D1D["super_armmgs"] = ::func_89EF;
	level.var_2D1D["super_atomizer"] = ::func_89EF;
	level.var_2D1D["super_blackholegun"] = ::func_89EF;
	level.var_2D1D["super_penetrationrailgun"] = ::func_89EF;
	level.var_2D1D["super_amplify"] = ::func_89EE;
	level.var_2D1D["super_overdrive"] = ::func_89EE;
	level.var_2D1D["super_armorup"] = ::func_89EE;
	level.var_2D1D["super_rewind"] = ::func_89EE;
	level.var_2D1D["super_phaseshift"] = ::func_89EE;
	level.var_2D1D["super_teleport"] = ::func_89EE;
	level.var_2D1D["super_invisible"] = ::func_89EE;
	level.var_2D1D["super_visionpulse"] = ::func_89EE;
}

//Function Number: 2
func_9F8B(param_00)
{
	if(!isdefined(level.var_2D1D))
	{
		return 0;
	}

	if(!isdefined(level.var_2D1D[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_2EE9()
{
	var_00 = self.var_2ED8;
	var_01 = randomint(level.var_2EFC[var_00].size);
	return level.var_2EFC[var_00][var_01];
}

//Function Number: 4
botpicktrait()
{
	var_00 = self.var_2ED8;
	if(!isdefined(level.botsupportedarchetypetraits))
	{
		level.botsupportedarchetypetraits = [];
		level.botsupportedarchetypetraits["archetype_assault"] = [];
		level.botsupportedarchetypetraits["archetype_heavy"] = [];
		level.botsupportedarchetypetraits["archetype_scout"] = [];
		level.botsupportedarchetypetraits["archetype_assassin"] = [];
		level.botsupportedarchetypetraits["archetype_engineer"] = [];
		level.botsupportedarchetypetraits["archetype_sniper"] = [];
		level.botsupportedarchetypetraits["archetype_assault"][level.botsupportedarchetypetraits["archetype_assault"].size] = "specialty_boom";
		level.botsupportedarchetypetraits["archetype_heavy"][level.botsupportedarchetypetraits["archetype_heavy"].size] = "specialty_regenfaster";
		level.botsupportedarchetypetraits["archetype_heavy"][level.botsupportedarchetypetraits["archetype_heavy"].size] = "specialty_man_at_arms";
		level.botsupportedarchetypetraits["archetype_scout"][level.botsupportedarchetypetraits["archetype_scout"].size] = "specialty_afterburner";
		level.botsupportedarchetypetraits["archetype_scout"][level.botsupportedarchetypetraits["archetype_scout"].size] = "specialty_rush";
		level.botsupportedarchetypetraits["archetype_assassin"][level.botsupportedarchetypetraits["archetype_assassin"].size] = "specialty_sixth_sense";
		level.botsupportedarchetypetraits["archetype_engineer"][level.botsupportedarchetypetraits["archetype_engineer"].size] = "specialty_personal_trophy";
		level.botsupportedarchetypetraits["archetype_engineer"][level.botsupportedarchetypetraits["archetype_engineer"].size] = "specialty_rugged_eqp";
		level.botsupportedarchetypetraits["archetype_sniper"][level.botsupportedarchetypetraits["archetype_sniper"].size] = "specialty_rearguard";
		level.botsupportedarchetypetraits["archetype_sniper"][level.botsupportedarchetypetraits["archetype_sniper"].size] = "specialty_mark_targets";
	}

	var_01 = randomint(level.botsupportedarchetypetraits[var_00].size);
	return level.botsupportedarchetypetraits[var_00][var_01];
}

//Function Number: 5
func_2EB7()
{
	if(isdefined(self.var_2EB7))
	{
		return;
	}

	self notify("bot_think_supers");
	self endon("bot_think_supers");
	self endon("disconnect");
	level endon("game_ended");
	self.var_2EB7 = 1;
	for(;;)
	{
		self waittill("super_ready");
		if(!isdefined(self.var_AEAA))
		{
			continue;
		}

		if(isdefined(level.var_2D1D[self.var_AEAA]))
		{
			self [[ level.var_2D1D[self.var_AEAA] ]]();
		}
		else
		{
		}

		self botsetflag("super_ready",0);
		self waittill("super_finished");
	}
}

//Function Number: 6
func_89EF()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = randomfloatrange(3,6);
		wait(var_00);
		if(!isalive(self))
		{
			continue;
		}

		if(!isdefined(self.var_10C) || !isalive(self.var_10C))
		{
			scripts\common\utility::waittill_any_3("enemy","death");
		}

		if(!isalive(self))
		{
			continue;
		}

		if(!isdefined(self.var_10C))
		{
			continue;
		}

		var_01 = distance(self.var_10C.origin,self.origin);
		if(var_01 < 800 && scripts\mp\bots\_bots_powers::func_8BEE())
		{
			if(var_01 < 550)
			{
				continue;
			}
		}

		self botsetflag("super_ready",1);
		break;
	}

	self waittill("super_started");
}

//Function Number: 7
func_89EE()
{
	level endon("game_ended");
	self endon("disconnect");
	wait(randomfloatrange(1,3));
	for(;;)
	{
		wait(0.25);
		if(!isalive(self))
		{
			continue;
		}

		if(!isdefined(self.var_10C) || !isalive(self.var_10C))
		{
			scripts\common\utility::waittill_any_3("enemy","death");
		}

		if(!isalive(self))
		{
			continue;
		}

		if(scripts\mp\bots\_bots_powers::func_8BEE())
		{
			var_00 = distance(self.var_10C.origin,self.origin);
			if(var_00 < 600)
			{
				continue;
			}
		}

		break;
	}

	self botsetflag("super_ready",1);
	self waittill("super_started");
}