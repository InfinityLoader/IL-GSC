/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\zombie_assassin_freefire_basic.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 124 ms
 * Timestamp: 10/27/2023 3:14:11 AM
*******************************************************************/

//Function Number: 1
seek_special_ability_use()
{
	return !common_scripts\utility::func_562E(self.specialoverheated) && player_in_view();
}

//Function Number: 2
activate_special_ability()
{
	self endon("death");
	childthread maps/mp/zombies/zombie_assassin_basic::recharge_special_ability(5.5);
}

//Function Number: 3
special_assassin_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
}

//Function Number: 4
throw_razors_at_players()
{
	self endon("death");
	self endon("assin_stop_fire");
	var_00 = ["J_poker2_LE","J_poker1_RI"];
	var_01 = 512 * vectornormalize(anglestoforward(self.var_1D));
	foreach(var_03 in var_00)
	{
		var_04 = self gettagorigin(var_03);
		var_05 = var_04 + (0,0,-32) + var_01;
		if(isdefined(self.forcedtarget))
		{
			var_05 = self.forcedtarget.var_116 + (0,0,40);
		}

		var_06 = magicbullet("razergun_zm",var_04,var_05,level.var_721C);
		var_06 maps/mp/zombies/weapons/_zombie_razer_gun::transform_razer_projectile(self,"razergun_zm","zmb_razergun_yellow_trail",1);
	}
}

//Function Number: 5
player_in_view()
{
	self endon("death");
	foreach(var_01 in level.var_744A)
	{
		if(distance(var_01.var_116,self.var_116) < 712 && maps\mp\_utility::func_3B8E(self,var_01,35))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
assassin_throw_notetrack_handler(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	switch(param_00)
	{
		case "aud_assassin_melee_hit_vox":
			self.myprojectilefx = [];
			self.myprojectilefx[self.myprojectilefx.size] = maps/mp/zombies/zombie_assassin_basic::play_fx_on_zmb_assassin("razergun_projectile_assassin","J_poker1_RI");
			self.myprojectilefx[self.myprojectilefx.size] = maps/mp/zombies/zombie_assassin_basic::play_fx_on_zmb_assassin("zmb_razergun_yellow_trail","J_poker1_RI");
			self.myprojectilefx[self.myprojectilefx.size] = maps/mp/zombies/zombie_assassin_basic::play_fx_on_zmb_assassin("razergun_projectile_assassin","J_poker2_LE");
			self.myprojectilefx[self.myprojectilefx.size] = maps/mp/zombies/zombie_assassin_basic::play_fx_on_zmb_assassin("zmb_razergun_yellow_trail","J_poker2_LE");
			var_05 = get_closest_alive_player(self.var_116);
			self.target_origin = var_05.var_116;
			break;

		case "footstep_walk_right_asn":
			if(isdefined(self.myprojectilefx))
			{
				foreach(var_07 in self.myprojectilefx)
				{
					var_07 delete();
				}
	
				self.myprojectilefx = [];
			}
	
			thread throw_razors_at_players();
			break;
	}
}

//Function Number: 7
get_closest_alive_player(param_00)
{
	var_01 = common_scripts\utility::func_40B0(param_00,level.var_744A);
	foreach(var_03 in var_01)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_03.var_5728))
		{
			continue;
		}

		return var_03;
	}

	return level.var_721C;
}