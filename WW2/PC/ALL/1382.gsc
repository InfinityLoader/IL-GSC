/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1382.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 3:25:55 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_A41["zombie_generic"] = level.var_A41["zombie"];
	level.var_A41["zombie_generic"]["think"] = ::func_ABB3;
	level.var_A41["zombie_generic"]["on_damaged"] = ::func_ABB2;
	level.var_A41["zombie_generic"]["get_action_params"] = ::zombie_generic_get_action_params;
	var_00 = ["zom_head_fdr02_org1","zom_head_fdr03_org1","zom_head_fdr04_org1"];
	var_01 = ["zom_m40helmet_net1","zom_m40helmet_org1","zom_m40helmet_org2"];
	var_02 = ["zom_m34cap_org1","zom_m40officercap_org1","zom_m42cap_org1","zom_m43cap_org1","zom_m43cap_org2","zom_m43overseacap_org1"];
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = spawnstruct();
	var_06.var_5ED2["guts"]["whole_body"] = "zom_infantrya_bodywhole";
	var_06.var_5ED2["guts"]["torso"] = "zom_infantrya_torso_slice";
	var_06.var_5ED2["guts"]["left_arm"] = "zom_infantrya_l_arm_slice";
	var_06.var_5ED2["guts"]["left_leg"] = "zom_infantrya_l_leg_slice";
	var_06.var_5ED2["guts"]["right_arm"] = "zom_infantrya_r_arm_slice";
	var_06.var_5ED2["guts"]["right_leg"] = "zom_infantrya_r_leg_slice";
	var_06.var_5ED2["guts"]["heads"] = var_00;
	var_06.var_5ED2["guts"]["caps"] = var_02;
	var_06.var_5ED2["guts"]["helmets"] = var_01;
	var_06.var_5ED2["guts"]["facegear"] = var_05;
	var_06.var_5ED2["poncho"]["whole_body"] = "zom_snipera_bodywhole";
	var_06.var_5ED2["poncho"]["torso"] = "zom_snipera_torso_slice";
	var_06.var_5ED2["poncho"]["left_arm"] = "zom_snipera_l_arm_slice";
	var_06.var_5ED2["poncho"]["left_leg"] = "zom_snipera_l_leg_slice";
	var_06.var_5ED2["poncho"]["right_arm"] = "zom_snipera_r_arm_slice";
	var_06.var_5ED2["poncho"]["right_leg"] = "zom_snipera_r_leg_slice";
	var_06.var_5ED2["poncho"]["heads"] = var_00;
	var_06.var_5ED2["poncho"]["caps"] = var_02;
	var_06.var_5ED2["poncho"]["helmets"] = var_01;
	var_06.var_5ED2["poncho"]["facegear"] = var_05;
	var_06.var_5ED2["possum"]["whole_body"] = "zom_infantrya_bodywhole";
	var_06.var_5ED2["possum"]["torso"] = "zom_infantrya_torso_slice";
	var_06.var_5ED2["possum"]["left_arm"] = "zom_infantrya_l_arm_slice";
	var_06.var_5ED2["possum"]["left_leg"] = "zom_infantrya_l_leg_slice";
	var_06.var_5ED2["possum"]["right_arm"] = "zom_infantrya_r_arm_slice";
	var_06.var_5ED2["possum"]["right_leg"] = "zom_infantrya_r_leg_slice";
	var_06.var_5ED2["possum"]["heads"] = ["zom_head_fdr02_org1"];
	var_06.var_5ED2["possum"]["request only"] = 1;
	var_06.var_5ED2["soldier"]["whole_body"] = "zom_inf_smga_org1_mm3";
	var_06.var_5ED2["soldier"]["request only"] = 1;
	var_06.var_5ED2["soldier_rus"]["whole_body"] = "zom_rus_infantry_org1";
	var_06.var_5ED2["soldier_rus"]["request only"] = 1;
	var_06.var_A4B = "zombie_generic";
	var_06.var_EAE = "zombie_animclass";
	var_06.var_879 = "zombie_generic";
	var_06.var_4C12 = 1;
	var_06.var_60E2 = 40;
	var_06.var_8302 = 65;
	var_06.var_8303 = 15;
	var_06.suppressive_fire_speed_multiplier = 0.3;
	var_06.tacklebymelee = 1;
	var_06.tacklebycharge = 1;
	var_06.knockbyravensword = 1;
	var_06.shockbyteslablood = 1;
	var_06.knockbybladebarbarossa = 1;
	var_06.energyhold = 1;
	var_06.energyholdkill = 1;
	var_06.energyholdsecondary = 1;
	var_06.throwable = 1;
	if(isdefined(level.var_62AB))
	{
		var_06 = [[ level.var_62AB ]](var_06);
	}

	lib_0547::func_A52(var_06,"zombie_generic");
	lib_0547::registeranimtree("zombie_generic",#animtree);
}

//Function Number: 2
func_ABB5()
{
	maps/mp/agents/humanoid/_humanoid::func_8A27();
	thread lib_054D::func_AC15();
	thread lib_0547::func_A692();
	thread func_AB4F();
	thread lib_054D::func_A0EE();
	thread lib_054D::func_A146();
	thread lib_053C::func_778();
	thread lib_053C::func_4F95();
	thread lib_053C::func_635C();
	if(self.var_A4B == "zombie_generic")
	{
		if(!isdefined(level.var_scaling_reach_max_wave))
		{
			var_00 = 47;
		}
		else
		{
			var_00 = level.var_scaling_reach_max_wave;
		}

		if(!isdefined(level.var_scaling_reach_min_wave))
		{
			var_01 = 25;
		}
		else
		{
			var_01 = level.var_scaling_reach_min_wave;
		}

		var_02 = self.var_901F - var_01 / var_00 - var_01;
		var_03 = lerp(60,72,var_02);
		var_03 = clamp(var_03,60,72);
		lib_0547::func_86C7(var_03);
	}
}

//Function Number: 3
func_ABB3()
{
	self method_85A1("zombie");
	func_ABB4();
}

//Function Number: 4
zombie_generic_think_wait(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	wait(common_scripts\utility::func_98E7(isdefined(self.has_think_waited),param_00,randomfloat(param_00)));
	self.has_think_waited = 1;
}

//Function Number: 5
func_ABB4()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	func_ABB5();
	for(;;)
	{
		if(lib_053C::func_4F8C())
		{
		}
		else if(lib_053C::func_4F84())
		{
		}
		else if(lib_053C::func_4F9B())
		{
		}
		else if(lib_053C::func_4F9A())
		{
		}
		else
		{
			lib_053C::func_647();
		}

		zombie_generic_think_wait();
	}
}

//Function Number: 6
func_AB4F()
{
	self endon("death");
	for(;;)
	{
		var_00 = common_scripts\utility::func_A717("attack_hit","attack_miss");
		switch(var_00[0])
		{
			case "attack_hit":
				if(isdefined(self.var_71D))
				{
					thread lib_054E::func_3102("attack_hit",self.var_71D.var_A47);
				}
		
				var_01 = var_00[1];
				if(isdefined(var_01) && isplayer(var_01))
				{
					if(self.var_A4B == "zombie_generic" || self.var_A4B == "zombie_assassin" || self.var_A4B == "zombie_sizzler")
					{
						if(isalive(var_01))
						{
							var_01 lib_0380::func_2888("zmb_hit",var_01);
						}
						else
						{
							var_01 lib_0380::func_288B("zmb_hit",var_01,var_01);
						}
					}
					else if(self.var_A4B == "zombie_heavy" && isdefined(self.var_1F52))
					{
						if(isalive(var_01))
						{
							var_01 lib_0380::func_2888("zmb_follower_mace_imp",var_01);
						}
						else
						{
							var_01 lib_0380::func_288B("zmb_follower_mace_imp",var_01,var_01);
						}
					}
					else if(self.var_A4B == "zombie_bob" && isdefined(self.var_1F52))
					{
						if(isalive(var_01))
						{
							var_01 lib_0380::func_2888("zmb_bob_melee_hit",var_01);
						}
						else
						{
							var_01 lib_0380::func_288B("zmb_bob_melee_hit",var_01,var_01);
						}
					}
					else if(self.var_A4B == "zombie_guardian" && isdefined(self.var_1F52))
					{
						if(isalive(var_01))
						{
							var_01 lib_0380::func_2888("zmb_hit",var_01);
						}
						else
						{
							var_01 lib_0380::func_288B("zmb_hit",var_01,var_01);
						}
					}
				}
				break;
	
			case "attack_miss":
				thread lib_054E::func_3102("attack_miss",self.var_A4B);
				break;
		}
	}
}

//Function Number: 7
func_ABB2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(param_05 == "panzerschreck_zm" || param_05 == "bazooka_zm")
	{
		param_02 = self.var_FB;
	}

	if(param_05 == "turretweapon_zeppelin_gun_zm")
	{
		param_04 = "MOD_RIFLE_BULLET";
		if(common_scripts\utility::func_562E(self.var_A87C))
		{
			param_02 = param_02 * 0;
		}
		else
		{
			param_02 = param_02 * 1;
		}
	}

	if(isdefined(self.prop_decorator))
	{
		if(param_08 == "head")
		{
			if(self.prop_decorator.var_106 == "usa_water_bucket_01" || self.prop_decorator.var_106 == "aac_kitchen_skillet_01")
			{
				var_0B = spawn("script_model",self.prop_decorator.var_116);
				var_0B setmodel(self.prop_decorator.var_106);
				var_0B.var_1D = self.prop_decorator.var_1D;
				self.prop_decorator delete();
				param_02 = 1;
				var_0C = spawn("script_model",var_0B.var_116);
				var_0C setmodel("helmet_collision");
				var_0C.var_1D = var_0B.var_1D;
				var_0B linkto(var_0C);
				var_0C.var_6292 = var_0B;
				var_0C thread decoratorlaunch(param_07);
				var_0C hideallparts();
			}
		}
	}

	lib_054D::func_6BD1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 8
decoratorlaunch(param_00)
{
	level endon("game_ended");
	var_01 = 5000;
	var_02 = 3000;
	if(!isdefined(param_00))
	{
		param_00 = anglestoforward(self.var_1D);
	}

	var_03 = param_00;
	var_04 = var_03[0] * var_01;
	var_05 = var_03[1] * var_01;
	var_06 = var_03[2] * var_02;
	var_07 = self.var_116 + param_00 * -5;
	self method_82C5(var_07,(var_04,var_05,var_06));
	wait(15);
	self.var_6292 delete();
	self delete();
}

//Function Number: 9
zombie_generic_get_action_params()
{
	if(isdefined(self.action_param_override_func))
	{
		var_00 = [[ self.action_param_override_func ]]();
	}
	else
	{
		var_00 = lib_054D::func_AC22();
	}

	return var_00;
}