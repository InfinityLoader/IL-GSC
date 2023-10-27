/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\consumables\inv_giest_shield.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 212 ms
 * Timestamp: 10/27/2023 3:12:14 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("power_shield",::useshieldconsumable,::canuseshieldconsumable,::getshieldconsumablecharges);
	common_scripts\utility::func_92C("tesla blood shock","vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
	common_scripts\utility::func_92C("tesla blood shock","vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
	level.giest_bubble_voulnerable_zombies = ["zombie_generic","zombie_berserker","zombie_heavy","zombie_exploder","zombie_sizzler","zombie_assassin"];
	if(!maps\mp\_utility::func_4571() == "mp_zombie_island")
	{
		level thread maps/mp/zombies/weapons/_zombie_aoe_grenade::init_pommel_aud();
	}

	common_scripts\utility::func_92C("zmb_player_consumable_bubble","vfx/zombie/zmb_csm_player_bubble");
}

//Function Number: 2
canuseshieldconsumable(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
useshieldconsumable(param_00)
{
	var_01 = self;
	var_01 thread spawn_a_giest_bubble_shield(var_01.var_116);
}

//Function Number: 4
shield_tesla_shock_params_create(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_29A8 = param_00;
	var_04.var_721C = param_01;
	var_04.var_6AA0 = param_02;
	var_04.var_8365 = param_03;
	return var_04;
}

//Function Number: 5
spawn_a_giest_bubble_shield(param_00,param_01)
{
	var_02 = self;
	var_02 endon("disconnect");
	var_03 = spawnstruct();
	var_03.var_116 = param_00;
	var_04 = lib_0547::func_8FBA(var_03,"zmb_player_consumable_bubble");
	triggerfx(var_04);
	lib_0378::func_8D74("zmb_pomel_grenade_detonate",var_03.var_116);
	lib_0378::func_8D74("zmb_pomel_grenade_force_field",var_03.var_116);
	var_05 = gettime();
	var_06 = 15;
	if(isdefined(param_01))
	{
		var_06 = param_01;
	}

	if(!isdefined(param_01))
	{
		var_02 thread lib_057A::func_259E("consumable_zm_weapon_shield",var_06);
	}

	while(int(gettime() - var_05) / 1000 < var_06)
	{
		foreach(var_08 in lib_0547::func_408F())
		{
			if(!isdefined(var_08.var_A4B) || !common_scripts\utility::func_F79(level.giest_bubble_voulnerable_zombies,var_08.var_A4B))
			{
				continue;
			}

			if(distance(var_03.var_116,var_08.var_116) > 120)
			{
				continue;
			}

			if(common_scripts\utility::func_562E(var_08.var_98EF))
			{
				continue;
			}

			var_08.geistshieldattacker = var_03;
			var_08.giest_shield_origin = var_03.var_116;
			var_09 = shield_tesla_shock_params_create(var_08.var_116,var_02);
			var_09.var_6AA0 = ::death_shock_launch;
			var_08 thread lib_0547::func_7D1A("tesla_shock",[var_09],2);
			var_08 thread loop_spark_fx();
		}

		foreach(var_0C in level.var_744A)
		{
			if(distance(var_03.var_116,var_0C.var_116) > 120 && !common_scripts\utility::func_562E(var_0C.isgiestshieldaffected))
			{
				var_0C.isgiestshieldaffected = 1;
				var_0C lib_0378::func_8D74("aud_strt_asn_camo_blur");
				continue;
			}

			if(common_scripts\utility::func_562E(var_0C.isgiestshieldaffected))
			{
				var_0C.isgiestshieldaffected = 1;
				var_0C lib_0378::func_8D74("aud_stp_asn_camo_blur");
			}
		}

		wait 0.05;
	}

	foreach(var_0F in lib_0547::func_408F())
	{
		if(!isdefined(var_0F.var_A4B) || !common_scripts\utility::func_F79(level.giest_bubble_voulnerable_zombies,var_0F.var_A4B))
		{
			continue;
		}

		if(lib_0547::func_5565(var_0F.geistshieldattacker,var_03))
		{
			var_0F thread death_shock_launch();
		}
	}

	var_04 delete();
	playfx(level.var_611["force_zombie_bubble_pop"],var_03.var_116);
	lib_0378::func_8D74("zmb_pomel_grenade_final_explosion",var_03.var_116);
}

//Function Number: 6
loop_spark_fx()
{
	self endon("death");
	self notify("new_loop_spark_fx");
	self endon("new_loop_spark_fx");
	while(!common_scripts\utility::func_562E(self.var_98EF))
	{
		wait 0.05;
	}

	while(common_scripts\utility::func_562E(self.var_98EF))
	{
		play_shield_zombie_shock_vfx();
		wait(randomfloat(1.7) + 0.8);
	}
}

//Function Number: 7
play_shield_zombie_shock_vfx()
{
	playfxontag(common_scripts\utility::func_44F5("tesla blood shock"),self,"j_spine4");
}

//Function Number: 8
death_shock_launch(param_00)
{
	var_01 = 10000;
	var_02 = self;
	var_03 = var_02.giest_shield_origin - var_02.var_116;
	var_03 = (var_03[0],var_03[1],0);
	var_03 = var_01 * vectornormalize(var_03) + (0,0,var_01);
	var_04 = var_02.giest_shield_origin;
	if(isdefined(var_02.geistshieldattacker))
	{
		if(!isdefined(var_02.geistshieldattacker.lastexplodetime))
		{
			var_02.geistshieldattacker.lastexplodetime = gettime();
		}

		if(gettime() - var_02.geistshieldattacker.lastexplodetime > 100)
		{
			var_02.geistshieldattacker.lastexplodetime = gettime();
			playfx(common_scripts\utility::func_44F5("tesla_blood_explosion"),var_02.giest_shield_origin);
			var_02 lib_0378::func_8D74("aud_ww_blood_explode");
		}
	}

	if(isdefined(param_00) && isdefined(param_00.var_721C))
	{
		self dodamage(level.heavy_giest_dmg,self.var_116,param_00.var_721C);
	}
	else
	{
		self dodamage(level.heavy_giest_dmg,self.var_116);
	}

	level thread run_explosion_sphere(var_04);
}

//Function Number: 9
run_explosion_sphere(param_00)
{
	wait 0.05;
	physicsexplosionsphere(param_00,250,150,2.7);
}

//Function Number: 10
getshieldconsumablecharges(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	switch(param_00)
	{
		case "epic":
			return 4;

		case "legendary":
			return 3;

		case "rare":
			return 2;

		case "common":
			return 1;

		default:
			return 0;
	}
}