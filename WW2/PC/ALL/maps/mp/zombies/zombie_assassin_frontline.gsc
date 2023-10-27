/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\zombie_assassin_frontline.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 171 ms
 * Timestamp: 10/27/2023 3:14:11 AM
*******************************************************************/

//Function Number: 1
seek_special_ability_use()
{
	return !common_scripts\utility::func_562E(self.specialoverheated);
}

//Function Number: 2
activate_special_ability()
{
	self endon("death");
	childthread maps/mp/zombies/zombie_assassin::recharge_special_ability(14);
	childthread buff_nearby_zombies();
	lib_0378::func_8D74("aud_assassin_use_taunt");
}

//Function Number: 3
special_assassin_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
}

//Function Number: 4
buff_nearby_zombies()
{
	self notify("new_assassin_buff");
	self endon("new_assassin_buff");
	var_00 = 0;
	var_01 = gettime();
	self.assassinabilitysustained = 1;
	while(gettime() - var_01 / 1000 < 8)
	{
		var_02 = lib_0547::func_408F();
		foreach(var_04 in var_02)
		{
			if(isdefined(var_04.assassin_modifier) && var_04 maps/mp/zombies/zombie_assassin::is_boss_assassin())
			{
				continue;
			}

			if(var_04 is_boss_buffed())
			{
				continue;
			}

			if(distance(self.var_116,var_04.var_116) > 256)
			{
				continue;
			}

			var_04 thread apply_boss_buff(self);
		}

		wait(0.125);
	}

	self.assassinabilitysustained = 0;
	maps/mp/zombies/zombie_assassin::disable_assassin_chest_fx();
}

//Function Number: 5
apply_boss_buff(param_00)
{
	self endon("death");
	level.frontline_assassin_buff_count++;
	var_01 = undefined;
	self.started_boss_buff = 1;
	if(!isdefined(level.loc_beams))
	{
		level.loc_beams = [];
	}

	if(level.loc_beams.size < 3)
	{
		var_01 = launchbeam("zmb_tesla_storm_beam",param_00,"J_Spine4",self,"J_Spine4");
		level.loc_beams = common_scripts\utility::func_F6F(level.loc_beams,var_01);
	}

	wait(0.55);
	spawn_assassin_frontline_fx();
	if(isdefined(var_01))
	{
		level.loc_beams = common_scripts\utility::func_F93(level.loc_beams,var_01);
		var_01 delete();
	}

	set_boss_buff();
}

//Function Number: 6
spawn_assassin_frontline_fx()
{
	if(isdefined(self.bufffx))
	{
		self.bufffx delete();
	}

	var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmi_assassin_buff"),self,"J_Spine4");
	maps/mp/agents/_agent_utility::deleteentonagentdeath(var_00);
	triggerfx(var_00);
	self.bufffx = var_00;
}

//Function Number: 7
set_boss_buff()
{
	self endon("death");
	self.var_6941 = 1;
	self.zombie_shielding_func = ::handle_boss_buff;
	if(common_scripts\utility::func_562E(self.bossintrozombiespawn) && !common_scripts\utility::func_562E(self.var_2FDA) && lib_0547::func_5565(self.var_6250,0))
	{
		self notify("assassin_awoken");
		self.is_boss_buffed = 1;
		if(!lib_0547::func_5565(self.var_A4B,"zombie_generic"))
		{
			return;
		}

		self scragentsetscripted(1);
		maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"assassin intro taunt");
		var_00 = maps/mp/agents/_scripted_agent_anim_util::func_7A35("board_taunt_base");
		maps/mp/agents/_scripted_agent_anim_util::func_71FA("board_taunt_base",var_00,1,"taunt_anim");
		maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"assassin intro taunt");
		self scragentsetscripted(0);
	}
}

//Function Number: 8
handle_boss_buff(param_00)
{
	if(!isdefined(self.zombie_magic_sheild_health))
	{
		self.zombie_magic_sheild_health = 2500;
	}

	self.zombie_magic_sheild_health = self.zombie_magic_sheild_health - param_00;
	if(self.zombie_magic_sheild_health <= 0)
	{
		self_remove_boss_buff();
	}
}

//Function Number: 9
self_remove_boss_buff()
{
	self.started_boss_buff = 0;
	self.is_boss_buffed = 0;
	self.zombie_shielding_func = undefined;
	self.zombie_magic_sheild_health = 0;
	if(isdefined(self.bufffx))
	{
		self.bufffx delete();
	}
}

//Function Number: 10
is_boss_buffed()
{
	return common_scripts\utility::func_562E(self.is_boss_buffed) || common_scripts\utility::func_562E(self.started_boss_buff);
}