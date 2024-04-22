/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_smart_grenade.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 217 ms
 * Timestamp: 4/22/2024 2:09:42 AM
*******************************************************************/

//Function Number: 1
init_smart_grenade()
{
	precache_var_grenade_fx();
}

//Function Number: 2
monitorsmartgrenade(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("grenade_fire",var_01,var_02);
		if(issubstr(var_02,"smart"))
		{
			var_01 thread tracking_grenade_think(param_00);
		}
	}
}

//Function Number: 3
precache_var_grenade_fx()
{
}

//Function Number: 4
tracking_grenade_think(param_00)
{
	var_01 = 40;
	var_02 = 20;
	var_03 = 195;
	var_04 = 1.5;
	var_05 = 2;
	var_06 = 0.35;
	var_07 = 88;
	var_08 = 7;
	var_09 = 1056;
	var_0A = 2;
	var_0B = 0.05;
	var_0C = (0,0,-300 * var_0B);
	var_0D = 3000 * var_0B;
	var_0E = 600 * var_0B;
	var_0F = 0.2;
	var_10 = 0.6;
	var_11 = 2;
	var_12 = sin(2);
	var_13 = 0.05;
	var_14 = make_tracking_grenade(self);
	var_14 thread tracking_grenade_handle_damage(param_00);
	var_15 = common_scripts\utility::spawn_tag_origin();
	var_15 linkto(var_14,"",(0,0,0),(-90,0,0));
	var_16 = param_00 geteye();
	var_17 = anglestoforward(param_00.angles);
	var_18 = bullettrace(var_16,var_16 + var_17 * 7000,0,var_14);
	var_19 = var_18["position"];
	var_1A = var_14 tracking_grenade_get_target(param_00);
	var_1B = var_17 + (0,0,0.2) * 50 * 17.6;
	var_1C = (0,0,0);
	var_1A = undefined;
	var_1D = (0,0,0);
	var_1E = (0,0,0);
	var_1F = 0;
	var_20 = 0;
	while(var_20 < var_08)
	{
		if(!isalive(var_1A))
		{
			var_1A = var_14 tracking_grenade_get_target(param_00);
		}

		if(var_20 > var_05 && !var_1F)
		{
			var_21 = var_14 tracking_grenade_get_target(param_00);
			if(isdefined(var_21))
			{
				var_1F = 1;
				var_1A = var_21;
				tracking_grenade_scare_enemies(var_1A.origin);
			}
		}

		if(var_20 > var_05)
		{
			if(isdefined(var_1A))
			{
				var_19 = var_1A.origin + var_1A get_npc_center_offset();
			}
		}
		else
		{
			var_16 = param_00 geteye();
			var_17 = anglestoforward(param_00.angles);
			var_18 = bullettrace(var_16,var_16 + var_17 * 7000,0,var_14);
			var_22 = var_18["position"];
			if(distancesquared(var_22,param_00.origin) > distancesquared(var_14.origin,param_00.origin))
			{
				var_19 = var_22;
			}
		}

		if(vectordot(var_19 - var_14.origin,var_19 - param_00.origin) < 0)
		{
			break;
		}

		if(var_20 > var_05)
		{
			var_23 = linear_map_clamp(var_20 - var_05 - var_06,0,var_0A,0,var_09);
			var_1C = vectornormalize(var_19 - var_14.origin) * var_23;
			if(var_20 < var_05 + var_06)
			{
				var_1C = (0,0,var_07);
			}
		}
		else
		{
			var_16 = param_00 geteye();
			var_24 = param_00.angles;
			var_17 = anglestoforward(var_24);
			var_25 = anglestoright(var_24);
			var_26 = -1 * common_scripts\utility::sign(vectordot(var_16 - var_14.origin,var_25));
			var_27 = var_16 + var_17 * var_03 + (0,0,var_01) + var_25 * var_26 * var_02;
			var_28 = var_27 - var_14.origin;
			var_1C = var_28 * var_04;
		}

		var_29 = vectorclamp(var_1C - var_1B * var_10 - var_0C,var_0D);
		var_29 = vectorlerp(var_29,var_1D,var_0F);
		var_1E = var_1E + var_29;
		var_1E = var_1E + common_scripts\utility::randomvector(var_13 * length(var_1E));
		var_2A = length(var_1E);
		if(var_2A > 0)
		{
			var_2B = anglestoup(var_14.angles);
			var_14.angles = combineangles(vectortoangles(var_1E),(90,0,0));
			var_2C = vectornormalize(var_1E);
			var_2D = vectorcross(var_2C,var_2B);
			var_2E = vectorcross(var_2C,var_2D);
			var_2F = length(var_2E);
			if(var_2F > var_12)
			{
				var_14 tracking_grenade_thrust_effect(var_2E,"tracking_grenade_spray_small",var_2C * var_11);
				if(var_2F > 2 * var_12)
				{
					var_14 tracking_grenade_thrust_effect(-1 * var_2E,"tracking_grenade_spray_small",var_2C * var_11 * -1);
				}
			}

			if(var_2A > var_0E)
			{
				foreach(var_31 in level.players)
				{
					playfxontagforclients(common_scripts\utility::getfx("tracking_grenade_spray_large"),var_14,"tag_fx",var_31);
				}

				var_1E = (0,0,0);
				var_1B = var_1B + vectorclamp(var_29,var_0D,var_0E);
			}

			var_1B = var_1B + var_0C;
		}

		var_1E = (0,0,0);
		var_33 = var_14.origin + var_1B * 0.05;
		var_34 = bullettrace(var_14.origin,var_33,1,param_00);
		if(var_34["fraction"] < 1)
		{
			break;
		}

		var_14.origin = var_33;
		var_1D = var_29;
		if(var_20 == var_05)
		{
		}
		else if(var_20 == var_05 + var_06)
		{
		}

		wait(0.05);
		var_20 = var_20 + 0.05;
	}

	var_14 tracking_grenade_detonate(param_00,var_1B);
	var_15 delete();
}

//Function Number: 5
tracking_grenade_detonate(param_00,param_01)
{
	var_02 = 300;
	if(distance(param_00.origin,self.origin) > var_02)
	{
		magicgrenademanual("frag_grenade_mp",self.origin,param_01,0.05,param_00);
		self delete();
		return;
	}

	self physicslaunchserver(self.origin,param_01 * 0.1);
	common_scripts\utility::delaycall(3,::delete);
}

//Function Number: 6
tracking_grenade_handle_damage(param_00)
{
	self endon("death");
	self makeentitysentient(param_00.team,1);
	self waittill("damage");
	tracking_grenade_detonate();
}

//Function Number: 7
tracking_grenade_scare_enemies(param_00)
{
	badplace_cylinder("",4,param_00 + (0,0,-64),117,128,"all");
}

//Function Number: 8
tracking_grenade_get_target(param_00)
{
	var_01 = param_00 geteye();
	var_02 = anglestoforward(param_00.angles);
	var_03 = cos(20);
	var_04 = undefined;
	var_05 = [];
	foreach(var_07 in level.agentarray)
	{
		if(var_07.team == "axis")
		{
			var_05[var_05.size] = var_07;
		}
	}

	foreach(var_0A in var_05)
	{
		var_0B = var_0A geteye();
		var_0C = vectordot(vectornormalize(var_0B - var_01),var_02);
		if(var_0C <= var_03)
		{
			continue;
		}

		if(distancesquared(var_0B,var_01) < distancesquared(self.origin,var_01))
		{
			continue;
		}

		if(!sighttracepassed(self.origin,var_0B,0,self))
		{
			continue;
		}

		if(isdefined(var_04) && !sighttracepassed(self.origin,var_0B,0,self,param_00))
		{
			continue;
		}

		var_03 = var_0C;
		var_04 = var_0A;
	}

	return var_04;
}

//Function Number: 9
tracking_grenade_thrust_effect(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::spawn_tag_origin();
	if(isdefined(param_02))
	{
		var_03.origin = var_03.origin + param_02;
	}

	var_03.angles = vectortoangles(param_00);
	var_03 linkto(self);
	foreach(var_05 in level.players)
	{
		playfxontagforclients(common_scripts\utility::getfx(param_01),self,"tag_fx",var_05);
	}

	var_03 common_scripts\utility::delaycall(0.3,::delete);
}

//Function Number: 10
make_tracking_grenade(param_00)
{
	var_01 = param_00.origin;
	param_00 delete();
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("npc_variable_grenade_lethal");
	return var_02;
}

//Function Number: 11
get_npc_center_offset()
{
	if(isai(self) && isalive(self))
	{
		var_00 = self geteye()[2];
		var_01 = self.origin[2];
		var_02 = var_00 - var_01;
		return (0,0,var_02);
	}

	return (0,0,0);
}

//Function Number: 12
linear_map_clamp(param_00,param_01,param_02,param_03,param_04)
{
	return clamp(linear_map(param_00,param_01,param_02,param_03,param_04),min(param_03,param_04),max(param_03,param_04));
}

//Function Number: 13
linear_map(param_00,param_01,param_02,param_03,param_04)
{
	return param_03 + param_00 - param_01 * param_04 - param_03 / param_02 - param_01;
}