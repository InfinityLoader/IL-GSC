/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3422.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 12:27:11 AM
*******************************************************************/

//Function Number: 1
func_96D5()
{
	scripts\common\utility::flag_init("can_drop_coins");
	scripts\common\utility::flag_init("pillage_enabled");
	level.var_B44A = 1;
	level.var_C1FC = 0;
	level.var_A8F5 = 30000;
	level.var_CB5D = 15000;
	level.var_CB5C = -20536;
	level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D,level.var_CB5C);
	level.var_CB5B = ::func_CB5B;
	level.should_drop_pillage = ::func_FF3D;
	level.var_163C = [];
}

//Function Number: 2
register_zombie_pillageable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.var_C909 = param_01;
	var_05.model = param_03;
	var_05.var_AAB6 = param_04;
	var_05.var_AAB3 = param_02;
	level.var_13F49[param_00] = var_05;
}

//Function Number: 3
func_6690(param_00)
{
	if(!scripts\common\utility::flag("pillage_enabled"))
	{
		return;
	}

	if(!func_381B(param_00))
	{
		return;
	}

	var_01 = scripts\common\utility::random(func_7B81(param_00));
	if(isdefined(var_01))
	{
		level.var_C1FC++;
		param_00 thread func_136B6(param_00);
		func_668F(param_00,var_01);
	}
}

//Function Number: 4
func_136B6(param_00)
{
	param_00 waittill("death");
	level.var_C1FC--;
}

//Function Number: 5
func_668F(param_00,param_01)
{
	var_02 = level.var_13F49[param_01].var_C909;
	param_00 setscriptablepartstate(var_02,param_01);
	param_00.var_8B66 = param_01;
}

//Function Number: 6
func_381B(param_00)
{
	if(param_00 lib_0C75::func_9E0F())
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.karatemaster))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_9BA7))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_50AF(param_00)
{
	wait(5);
	param_00 delete();
}

//Function Number: 8
func_7B81(param_00)
{
	if(level.var_C1FC >= level.var_B44A)
	{
		return [];
	}
	else if(level.var_BF51 > gettime())
	{
		return [];
	}
	else if(randomint(100) <= 100)
	{
		var_01 = func_7DB3(param_00.model);
		return var_01;
	}

	return [];
}

//Function Number: 9
func_7DB3(param_00)
{
	if(!isdefined(level.var_13F49))
	{
		return [];
	}

	switch(param_00)
	{
		case "zombie_female_outfit_7_3":
		case "zombie_female_outfit_7_2":
		case "zombie_female_outfit_7":
		case "zombie_female_outfit_6_3":
		case "zombie_female_outfit_6_2":
		case "zombie_female_outfit_6":
		case "zombie_female_outfit_5_3":
		case "zombie_female_outfit_5_2":
		case "zombie_female_outfit_5":
		case "zombie_female_outfit_4_3":
		case "zombie_female_outfit_4_2":
		case "zombie_female_outfit_4":
		case "zombie_female_outfit_3_3":
		case "zombie_female_outfit_3_2":
		case "zombie_female_outfit_3":
		case "zombie_female_outfit_2_3":
		case "zombie_female_outfit_2_2":
		case "zombie_female_outfit_2":
		case "zombie_female_outfit_1_2":
		case "zombie_female_outfit_1":
		case "zombie_male_outfit_6_2_c":
		case "zombie_male_outfit_6_c":
		case "zombie_male_outfit_5_3_c":
		case "zombie_male_outfit_5_2_c":
		case "zombie_male_outfit_5_c":
		case "zombie_male_outfit_4_3_c":
		case "zombie_male_outfit_4_2_c":
		case "zombie_male_outfit_4_c":
		case "zombie_male_outfit_3_3_c":
		case "zombie_male_outfit_3_2_c":
		case "zombie_male_outfit_3_c":
		case "zombie_male_outfit_2_6_c":
		case "zombie_male_outfit_2_5_c":
		case "zombie_male_outfit_2_4_c":
		case "zombie_male_outfit_2_3_c":
		case "zombie_male_outfit_2_2_c":
		case "zombie_male_outfit_2_c":
		case "zombie_male_outfit_1_2_c":
		case "zombie_male_outfit_1_c":
		case "zombie_male_outfit_6_2_b":
		case "zombie_male_outfit_6_b":
		case "zombie_male_outfit_5_3_b":
		case "zombie_male_outfit_5_2_b":
		case "zombie_male_outfit_5_b":
		case "zombie_male_outfit_4_3_b":
		case "zombie_male_outfit_4_2_b":
		case "zombie_male_outfit_4_b":
		case "zombie_male_outfit_3_3_b":
		case "zombie_male_outfit_3_2_b":
		case "zombie_male_outfit_3_b":
		case "zombie_male_outfit_2_6_b":
		case "zombie_male_outfit_2_5_b":
		case "zombie_male_outfit_2_4_b":
		case "zombie_male_outfit_2_3_b":
		case "zombie_male_outfit_2_2_b":
		case "zombie_male_outfit_2_b":
		case "zombie_male_outfit_1_2_b":
		case "zombie_male_outfit_1_b":
		case "zombie_male_outfit_6_2":
		case "zombie_male_outfit_6":
		case "zombie_male_outfit_5_3":
		case "zombie_male_outfit_5_2":
		case "zombie_male_outfit_5":
		case "zombie_male_outfit_4_3":
		case "zombie_male_outfit_4_2":
		case "zombie_male_outfit_4":
		case "zombie_male_outfit_3_3":
		case "zombie_male_outfit_3_2":
		case "zombie_male_outfit_3":
		case "zombie_male_outfit_2_6":
		case "zombie_male_outfit_2_5":
		case "zombie_male_outfit_2_4":
		case "zombie_male_outfit_2_3":
		case "zombie_male_outfit_2_2":
		case "zombie_male_outfit_2":
		case "zombie_male_outfit_1_2":
		case "zombie_male_outfit_1":
			return getarraykeys(level.var_13F49);

		case "zombie_male_bluejeans_c":
		case "zombie_male_bluejeans_b":
		case "zombie_male_bluejeans_a":
			return [];

		default:
			return getarraykeys(level.var_13F49);
	}
}

//Function Number: 10
func_CB84(param_00,param_01,param_02)
{
	var_03 = level.var_13F49[param_01].var_AAB3;
	var_04 = level.var_13F49[param_01].var_AAB6;
	var_05 = param_00 gettagorigin(var_04);
	var_06 = param_00 gettagangles(var_04);
	if(param_00 [[ level.should_drop_pillage ]](param_02,var_05))
	{
		level thread func_10798(var_05,var_06,var_03);
	}
}

//Function Number: 11
func_CB5A()
{
	level.var_CB58 = [];
	level.pillageable_powers = ["power_speedBoost","power_teleport","power_transponder","power_cloak","power_barrier","power_mortarMount"];
	level.pillageable_explosives = ["power_bioSpike","power_sensorGrenade","power_clusterGrenade","power_gasGrenade","power_splashGrenade","power_repulsor","power_semtex","power_c4","power_frag"];
	level.var_C32B = ["power_bioSpike","power_sensorGrenade","power_clusterGrenade","power_gasGrenade","power_splashGrenade","power_repulsor","power_semtex","power_c4","power_frag"];
	level.var_C32C = ["power_bioSpike","power_sensorGrenade","power_clusterGrenade","power_gasGrenade","power_splashGrenade","power_repulsor","power_semtex","power_c4","power_frag"];
	level.pillageable_attachments = ["reflex","grip","barrelrange","xmags","overclock","fastaim","rof"];
	if(isdefined(level.custom_pillageinitfunc))
	{
		[[ level.custom_pillageinitfunc ]]();
	}

	func_31AF();
}

//Function Number: 12
func_31AF(param_00)
{
	if(!isdefined(level.pillageinfo))
	{
		return;
	}

	if(!isdefined(level.var_CB87))
	{
		level.var_CB87 = [];
	}

	if(isdefined(level.pillageinfo.explosive))
	{
		func_31AE("explosive",level.pillageinfo.explosive);
	}

	if(isdefined(level.pillageinfo.clip))
	{
		func_31AE("clip",level.pillageinfo.clip);
	}

	if(isdefined(level.pillageinfo.money))
	{
		func_31AE("money",level.pillageinfo.money);
	}

	if(isdefined(level.pillageinfo.var_B47C))
	{
		func_31AE("maxammo",level.pillageinfo.var_B47C);
	}

	if(isdefined(level.pillageinfo.tickets))
	{
		func_31AE("tickets",level.pillageinfo.tickets);
	}

	if(isdefined(level.pillageinfo.var_D782))
	{
		func_31AE("powers",level.pillageinfo.var_D782);
	}

	if(isdefined(level.pillageinfo.var_28C2))
	{
		func_31AE("battery",level.pillageinfo.var_28C2);
	}

	if(isdefined(level.var_4C3F))
	{
		[[ level.var_4C3F ]]();
	}
}

//Function Number: 13
func_31AE(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.var_DE3F = param_00;
	var_02.var_3C35 = param_01;
	level.var_CB87[level.var_CB87.size] = var_02;
}

//Function Number: 14
func_D31E(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.inlaststand))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(param_01 scripts\cp\_utility::func_9C03() || param_01 scripts\cp\_utility::func_8BAE())
	{
		return;
	}

	switch(param_00.type)
	{
		case "explosive":
			param_00 notify("all_players_searched");
			param_01 func_12880(param_00,"primary",1);
			break;

		case "powers":
			param_00 notify("all_players_searched");
			param_01 func_12880(param_00,"secondary",0);
			break;

		case "maxammo":
			if(param_01 func_38BA())
			{
				param_01 func_82E8();
				param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,0,50);
				scripts\common\utility::func_136F7();
				param_00 notify("all_players_searched");
			}
			else
			{
				param_01 scripts\cp\_utility::setlowermessage("max_ammo",&"COOP_GAME_PLAY_AMMO_MAX",3);
			}
			break;

		case "money":
			if(param_01 scripts\cp\_persistence::func_7B8B() < param_01.var_B48A)
			{
				if(soundexists(param_01.var_134FD + "pillage_cash"))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_cash","zmb_comment_vo","medium",10,0,0,1,50);
				}
				else
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_generic","zmb_comment_vo","medium",10,0,0,1,50);
				}
	
				param_01 scripts\cp\_persistence::func_82F9(param_00.var_3C,undefined,undefined,1,"pillage");
				param_00 notify("all_players_searched");
			}
			else
			{
				param_01 scripts\cp\_utility::setlowermessage("max_money",&"COOP_GAME_PLAY_MONEY_MAX",3);
			}
			break;

		case "tickets":
			param_01 scripts\cp\zombies\arcade_game_utility::func_8317(param_01,param_00.var_3C);
			param_00 notify("all_players_searched");
			param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_generic","zmb_comment_vo","medium",10,0,1,0,50);
			break;

		case "clip":
			if(param_01 func_38B7())
			{
				param_01 func_829B();
				param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,0,50);
				scripts\common\utility::func_136F7();
				param_00 notify("all_players_searched");
			}
			else
			{
				var_02 = param_01 scripts\cp\_utility::getvalidtakeweapon();
				if(issubstr(var_02,"iw7_cutie_zm") || issubstr(var_02,"iw7_cutier_zm"))
				{
					param_01 scripts\cp\_utility::setlowermessage("invalid_ammo",&"CP_TOWN_INVALID_AMMO",3);
				}
				else
				{
					param_01 scripts\cp\_utility::setlowermessage("max_ammo",&"COOP_GAME_PLAY_AMMO_MAX",3);
				}
	
				return;
			}
			break;

		case "quest":
			if(isdefined(level.var_DB5C))
			{
				param_01 [[ level.var_DB5C ]](var_02,"pickup",param_01);
			}
	
			break;

		case "battery":
			if(scripts\common\utility::istrue(var_02.has_battery))
			{
				var_02 scripts\cp\_utility::setlowermessage("have_battery",&"CP_TOWN_HAVE_BATTERY",4);
				return;
			}
	
			if(isdefined(level.quest_pillage_give_func))
			{
				var_02 thread [[ level.quest_pillage_give_func ]](var_02);
			}
	
			param_01 notify("all_players_searched");
			var_02 thread scripts\cp\_vo::try_to_play_vo("pillage_generic","zmb_comment_vo","medium",10,0,1,0,50);
			break;

		default:
			if(isdefined(level.var_ABE7))
			{
				param_01 [[ level.var_ABE7 ]](var_02,"pick_up");
			}
			break;
	}

	if(isdefined(param_01.var_A038))
	{
		var_02 thread func_100F2(param_01.var_A038);
	}

	var_02 playlocalsound("zmb_item_pickup");
	var_02 thread scripts\cp\_utility::func_1308C(var_02,"iw7_pickup_zm");
}

//Function Number: 15
func_778A(param_00,param_01,param_02,param_03)
{
	self notify("forcingGesture");
	self endon("forcingGesture");
	self allowmelee(0);
	scripts\common\utility::func_1C35(0);
	if(scripts\common\utility::func_9EC1())
	{
		scripts\common\utility::func_1C58(0);
	}

	if(self isgestureplaying(param_00))
	{
		self stopgestureviewmodel(param_00,0);
	}

	var_04 = self method_8443(param_00) * 0.4;
	var_05 = self playgestureviewmodel(param_00,param_01,1);
	if(var_05)
	{
		var_06 = func_7DCA(param_00);
		self playanimscriptevent("power_active_cp",var_06);
		wait(var_04);
	}

	self allowmelee(1);
	scripts\common\utility::func_1C35(1);
	if(!scripts\common\utility::func_9EC1())
	{
		scripts\common\utility::func_1C58(1);
	}
}

//Function Number: 16
func_7DCA(param_00)
{
	switch(param_00)
	{
		default:
			return "gesture008";
	}
}

//Function Number: 17
func_831A(param_00)
{
	self endon("all_players_searched");
	if(scripts\cp\zombies\zmb_zombies_weapons::func_FFA6(param_00))
	{
		var_01 = param_00 getcurrentweapon();
		var_02 = scripts\cp\_utility::func_80D8(var_01);
		param_00 takeweapon(var_01);
		param_00.var_A037 = var_02;
		level.var_12631 = randomint(100);
		scripts\cp\zombies\zombie_analytics::func_AF76(param_00.var_A037,level.var_12631);
		if(isdefined(param_00.var_C8A2[var_02]))
		{
			param_00.var_C8A2[var_02] = undefined;
			param_00 notify("weapon_level_changed");
		}
	}

	var_03 = self.pillageinfo.var_195.var_394;
	var_04 = scripts\cp\_utility::func_80D8(var_03);
	param_00.var_A035 = var_04;
	param_00 giveweapon(var_03);
	if(!isdefined(param_00.var_A034[var_04]))
	{
		param_00.var_A034[var_04] = 0;
	}

	param_00 switchtoweapon(var_03);
	var_05 = spawnstruct();
	var_05.var_B111 = 1;
	param_00.var_C8A2[var_04] = var_05;
	param_00 notify("weapon_level_changed");
	self notify("weapon_taken");
}

//Function Number: 18
func_5135(param_00)
{
	thread func_13971();
	var_01 = scripts\common\utility::waittill_any_timeout_1(60,"stop_pillage_spot_think","all_players_searched","redistributed_pillage_spots");
	var_02 = var_01 != "redistributed_pillage_spots";
	self.var_A032 = param_00.model;
	thread func_5189(param_00,var_02);
}

//Function Number: 19
func_10D4C()
{
	wait(60);
	self notify("all_players_searched");
}

//Function Number: 20
func_13971()
{
	self endon("all_players_searched");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("picked_up","swapped");
		self.var_F073++;
		wait(0.25);
		if(self.var_F073 >= level.players.size)
		{
			self notify("all_players_searched");
			break;
		}
		else
		{
			wait(0.05);
		}
	}
}

//Function Number: 21
func_7A09(param_00)
{
	param_00 = "" + param_00;
	switch(param_00)
	{
		case "power_bolaSpray":
			return &"ZOMBIE_PILLAGE_FOUND_BOLA_BARRAGE";

		case "power_semtex":
			return &"ZOMBIE_PILLAGE_FOUND_SEMTEX";

		case "power_splashGrenade":
			return &"ZOMBIE_PILLAGE_FOUND_PLASMA_GRENADE";

		case "power_bioSpike":
			return &"COOP_PILLAGE_FOUND_BIO_SPIKE";

		case "power_gasGrenade":
			return &"COOP_PILLAGE_FOUND_GAS_GRENADE";

		case "power_clusterGrenade":
			return &"COOP_PILLAGE_FOUND_CLUSTER_GRENADE";

		case "power_repulsor":
			return &"COOP_PILLAGE_FOUND_REPULSOR";

		case "power_frag":
			return &"ZOMBIE_PILLAGE_FOUND_FRAG_GRENADE";

		case "power_arcGrenade":
			return &"ZOMBIE_PILLAGE_FOUND_ARC_GRENADE";

		case "power_c4":
			return &"ZOMBIE_PILLAGE_FOUND_C4";

		case "power_concussionGrenade":
			return &"ZOMBIE_PILLAGE_FOUND_CONCUSSION_GRENADES";

		case "maxammo":
			return &"COOP_PILLAGE_FOUND_MAX_AMMO";

		case "clip":
			return &"COOP_PILLAGE_FOUND_CLIP";

		case "tickets":
			return &"ZOMBIE_PILLAGE_FOUND_TICKETS";

		default:
			return undefined;
	}

	if(isdefined(level.var_7A0A))
	{
		return [[ level.var_7A0A ]](param_00);
	}
}

//Function Number: 22
func_7A06(param_00)
{
	param_00 = "" + param_00;
	switch(param_00)
	{
		case "power_frag":
			return &"ZOMBIE_PILLAGE_PICKUP_FRAG_GRENADE";

		case "power_splashGrenade":
			return &"ZOMBIE_PILLAGE_PICKUP_PLASMA_GRENADE";

		case "power_bolaSpray":
			return &"ZOMBIE_PILLAGE_PICKUP_BOLA_BARRAGE";

		case "power_semtex":
			return &"ZOMBIE_PILLAGE_PICKUP_SEMTEX";

		case "power_gasGrenade":
			return &"COOP_PILLAGE_PICKUP_GAS_GRENADE";

		case "power_clusterGrenade":
			return &"COOP_PILLAGE_PICKUP_CLUSTER_GRENADE";

		case "power_bioSpike":
			return &"COOP_PILLAGE_PICKUP_BIO_SPIKE";

		case "power_repulsor":
			return &"COOP_PILLAGE_PICKUP_REPULSOR";

		case "power_arcGrenade":
			return &"ZOMBIE_PILLAGE_PICKUP_ARC_GRENADE";

		case "power_c4":
			return &"ZOMBIE_PILLAGE_PICKUP_C4";

		case "power_concussionGrenade":
			return &"ZOMBIE_PILLAGE_PICKUP_CONCUSSION_GRENADE";

		case "maxammo":
			return &"COOP_PILLAGE_PICKUP_MAX_AMMO";

		case "money":
			return &"ZOMBIE_PILLAGE_PICKUP_POINTS";

		case "tickets":
			return &"ZOMBIE_PILLAGE_PICKUP_TICKETS";

		case "clip":
			return &"COOP_PILLAGE_PICKUP_CLIP";

		case "quest":
			return &"CP_QUEST_WOR_PART";

		case "battery":
			return &"CP_TOWN_PILLAGE_BATTERY";

		default:
			return undefined;
	}

	if(isdefined(level.var_7A07))
	{
		return [[ level.var_7A07 ]](param_00);
	}
}

//Function Number: 23
func_5D00()
{
	if(self.model != "tag_origin")
	{
		var_00 = 20;
		var_01 = (0,0,2);
		var_02 = (0,0,0);
		var_03 = getgroundposition(self.origin,5,var_00);
		switch(self.model)
		{
			case "attachment_zmb_arcane_muzzlebrake_wm":
				var_02 = (0,0,6);
				break;
		}

		self.origin = var_03 + var_02;
	}
}

//Function Number: 24
func_5189(param_00,param_01)
{
	wait(0.25);
	while(scripts\common\utility::istrue(self.var_9B04))
	{
		wait(0.1);
	}

	if(isdefined(self.pillageinfo) && isdefined(self.type))
	{
		self.pillageinfo.type = undefined;
	}

	if(isdefined(self.var_CB63))
	{
		self.var_CB63 delete();
	}

	if(isdefined(self.var_7542))
	{
		self.var_7542 delete();
	}

	if(isdefined(self.var_F07F))
	{
		self.var_F07F = undefined;
	}

	self.var_F073 = 4;
	if(scripts\common\utility::func_2286(level.var_163C,self))
	{
		level.var_163C = scripts\common\utility::func_22A9(level.var_163C,self);
	}

	self notify("stop_pillage_spot_think");
	param_00 delete();
}

//Function Number: 25
func_7B82(param_00,param_01)
{
	if(!scripts\common\utility::flag("can_drop_coins"))
	{
		var_05 = ["quest"];
	}
	else
	{
		var_05 = [];
	}

	var_02 = func_7BEF(level.var_CB87,var_05);
	if(isdefined(param_00.var_4FFB))
	{
		var_02 = param_00.var_4FFB;
	}

	switch(var_02)
	{
		case "explosive":
			param_00.var_195 = func_3E8D();
			param_00.type = "explosive";
			param_00.var_C1 = 0;
			break;

		case "powers":
			param_00.var_195 = func_3E8E();
			param_00.type = "powers";
			param_00.var_C1 = 0;
			break;

		case "clip":
			param_00.type = "clip";
			param_00.var_195 = "clip";
			param_00.var_C1 = 1;
			break;

		case "maxammo":
			param_00.type = "maxammo";
			param_00.var_195 = "maxammo";
			param_00.var_C1 = 1;
			break;

		case "money":
			param_00.type = "money";
			var_04 = int(scripts\common\utility::random([1000,500,250,200,100,50]));
			param_00.var_3C = var_04;
			param_00.var_195 = "money";
			break;

		case "tickets":
			param_00.type = "tickets";
			param_00.var_195 = "tickets";
			var_03 = randomint(100);
			param_00.var_3C = var_03;
			break;

		case "quest":
			if(isdefined(level.var_DB59))
			{
				[[ level.var_DB59 ]](param_00,param_01);
			}
			break;

		case "battery":
			param_00.type = "battery";
			param_00.var_195 = "battery";
			param_00.var_C1 = 1;
			break;
	}

	return param_00;
}

//Function Number: 26
func_7BEF(param_00,param_01)
{
	if(isdefined(level.var_DB5B))
	{
		var_02 = [[ level.var_DB5B ]]();
		if(isdefined(var_02))
		{
			return var_02;
		}
	}

	var_03 = [];
	var_04 = 0;
	foreach(var_06 in param_00)
	{
		if(scripts\common\utility::func_2286(param_01,var_06.var_DE3F))
		{
			continue;
		}

		if(var_06.var_3C35 == 0)
		{
			continue;
		}

		var_03[var_03.size] = var_06;
		var_04 = var_04 + var_06.var_3C35;
	}

	var_08 = randomintrange(0,var_04 + 1);
	var_09 = 0;
	foreach(var_06 in var_03)
	{
		var_09 = var_09 + var_06.var_3C35;
		if(var_08 <= var_09)
		{
			return var_06.var_DE3F;
		}
	}
}

//Function Number: 27
func_100F2(param_00)
{
	self endon("disconnect");
	if(isdefined(self.var_1304A))
	{
		return;
	}

	var_01 = level.primaryprogressbarfontsize;
	var_02 = "objective";
	if(level.splitscreen)
	{
		var_01 = 1.3;
	}

	self.var_1304A = scripts\cp\_utility::createprimaryprogressbartext(0,25,var_01,var_02);
	self.var_1304A settext(param_00);
	self.var_1304A setpulsefx(50,2000,800);
	scripts\common\utility::waittill_any_timeout_1(3,"death");
	self.var_1304A scripts\cp\_utility::destroyelem();
	self.var_1304A = undefined;
}

//Function Number: 28
func_3E90()
{
	return scripts\common\utility::random(level.var_138A1);
}

//Function Number: 29
func_3E8C()
{
	return scripts\common\utility::random(level.pillageable_attachments);
}

//Function Number: 30
func_3E8D()
{
	return scripts\common\utility::random(level.pillageable_explosives);
}

//Function Number: 31
func_3E8E()
{
	return scripts\common\utility::random(level.pillageable_powers);
}

//Function Number: 32
func_3E8F()
{
	return scripts\common\utility::random(["infinite_20","ammo_max","kill_50","cash_2","instakill_30"]);
}

//Function Number: 33
func_12880(param_00,param_01,param_02)
{
	var_03 = param_00.var_195;
	var_04 = param_00.var_1E2D;
	self.var_A035 = var_03;
	level.var_12631 = randomint(100);
	if(!isdefined(param_01))
	{
		param_01 = level.var_D782[var_03].var_504B;
	}

	thread scripts\cp\powers\coop_powers::func_8397(var_03,param_01,undefined,undefined,undefined,0,param_02);
	self playlocalsound("grenade_pickup");
	if(randomint(100) > 50)
	{
		thread scripts\cp\_vo::try_to_play_vo("pillage_grenade","zmb_comment_vo","medium",10,0,1,0,50);
	}
	else
	{
		thread scripts\cp\_vo::try_to_play_vo("pillage_generic","zmb_comment_vo","medium",5,0,0,0);
	}

	scripts\common\utility::func_136F7();
	scripts\cp\zombies\zombie_analytics::func_AF82(1,self,param_00.type,self.var_A035," None ",level.var_12631);
	param_00 notify("picked_up");
}

//Function Number: 34
func_1287B(param_00)
{
	var_01 = param_00.pillageinfo.var_195;
	var_02 = param_00.pillageinfo.var_1E2D;
	self.var_A035 = var_01;
	level.var_12631 = randomint(100);
	if(isdefined(level.var_1287A))
	{
		if(![[ level.var_1287A ]]())
		{
			return;
		}
	}

	if(self hasweapon(var_01) && self method_80FB(var_01) > 0)
	{
		var_03 = self getfractionmaxammo(var_01);
		if(var_03 < 1)
		{
			var_04 = self getweaponammoclip(var_01);
			self setweaponammoclip(var_01,var_04 + var_02);
			self playlocalsound("grenade_pickup");
			param_00.var_CB63 disableplayeruse(self);
			thread scripts\cp\_vo::try_to_play_vo("pillage_grenade","zmb_comment_vo","low",10,0,1,0,50);
			scripts\common\utility::func_136F7();
			scripts\cp\zombies\zombie_analytics::func_AF82(1,self,param_00.type,self.var_A035," None ",level.var_12631);
			param_00 notify("picked_up");
			return;
		}

		scripts\cp\_utility::setlowermessage("max_explosives",&"COOP_INTERACTIONS_EXPLO_MAX",3);
		return;
	}

	var_05 = func_FFA4(level.var_C32B);
	self method_831C("other");
	if(!isdefined(var_05))
	{
		self giveweapon(var_01);
		self setweaponammoclip(var_01,var_02);
		self playlocalsound("grenade_pickup");
		param_00.var_CB63 disableplayeruse(self);
		thread scripts\cp\_vo::try_to_play_vo("pillage_grenade","zmb_comment_vo","low",10,0,1,0,50);
		scripts\common\utility::func_136F7();
		scripts\cp\zombies\zombie_analytics::func_AF82(1,self,param_00.type,self.var_A035," None ",level.var_12631);
		param_00 notify("picked_up");
		return;
	}

	self.var_A035 = var_01;
	self.var_A037 = var_05;
	level.var_12631 = randomint(100);
	scripts\cp\zombies\zombie_analytics::func_AF76(self.var_A037,level.var_12631);
	self takeweapon(var_05);
	self giveweapon(var_01);
	self setweaponammoclip(var_01,var_02);
	self playlocalsound("grenade_pickup");
	thread scripts\cp\_vo::try_to_play_vo("pillage_grenade","zmb_comment_vo","low",10,0,1,0,50);
	scripts\cp\zombies\zombie_analytics::func_AF82(1,self,param_00.type,self.var_A035," None ",level.var_12631);
	param_00.var_CB63 setmodel(function_00EA(var_05));
	var_06 = func_7A06(var_05);
	param_00.var_CB63 sethintstring(var_06);
	param_00.var_CB63 makeusable();
	param_00.pillageinfo = spawnstruct();
	param_00.pillageinfo.type = "explosive";
	param_00.pillageinfo.var_195 = var_05;
	param_00.pillageinfo.var_1E2D = self.var_1131E;
	param_00.var_CB63 func_5D00();
}

//Function Number: 35
func_FFA4(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	var_03 = 0;
	var_04 = self getweaponslistoffhands();
	foreach(var_06 in var_04)
	{
		foreach(var_08 in param_00)
		{
			if(var_06 != var_08)
			{
				continue;
			}

			if(isdefined(var_06) && var_06 != "none" && self method_80FB(var_06) > 0)
			{
				var_02 = var_06;
				var_03 = self getweaponammoclip(var_06);
				var_01 = 1;
				break;
			}

			if(var_01)
			{
				break;
			}
		}
	}

	if(isdefined(var_02))
	{
		self.var_1131E = var_03;
	}

	return var_02;
}

//Function Number: 36
func_38B7()
{
	var_00 = scripts\cp\_utility::getvalidtakeweapon();
	if(issubstr(var_00,"iw7_cutie_zm") || issubstr(var_00,"iw7_cutier_zm"))
	{
		return 0;
	}

	var_01 = self getcurrentweapon();
	var_02 = function_0249(var_01);
	var_03 = weaponclipsize(var_01);
	var_04 = scripts\cp\_utility::func_80D8(var_01);
	if(var_01 == "iw7_axe_zm" || var_01 == "iw7_axe_zm_pap1" || var_01 == "iw7_axe_zm_pap2" || var_01 == "none" || scripts\cp\_utility::weapon_is_dlc_melee(var_01) || var_01 == "iw7_katana_zm" || issubstr(var_01,"iw7_entangler"))
	{
		return 0;
	}

	if(issubstr(var_01,"iw7_fists"))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		return 0;
	}

	if(self getweaponammostock(var_01) < var_02)
	{
		return 1;
	}

	if(function_024C(var_01) == "riotshield" || scripts\cp\_weapon::func_9C22(var_01))
	{
		var_05 = self getweaponslistprimaries();
		foreach(var_07 in var_05)
		{
			if(var_07 == var_01)
			{
				continue;
			}

			var_02 = function_0249(var_07);
			var_03 = weaponclipsize(var_07);
			var_04 = scripts\cp\_utility::func_80D8(var_07);
			if(self getweaponammostock(var_07) < var_02)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 37
func_829B()
{
	var_00 = self getcurrentweapon();
	var_01 = scripts\cp\_utility::func_80D8(var_00);
	var_02 = weaponclipsize(var_00);
	if(function_024C(var_00) == "riotshield" || scripts\cp\_weapon::func_9C22(var_00))
	{
		var_03 = self getweaponslistprimaries();
		foreach(var_05 in var_03)
		{
			if(var_05 == var_00)
			{
				continue;
			}

			if(!scripts\cp\_weapon::func_9D75(var_00))
			{
				continue;
			}

			var_02 = weaponclipsize(var_05);
			var_01 = scripts\cp\_utility::func_80D8(var_05);
			if(self getweaponammostock(var_05) < function_0249(var_05))
			{
				var_06 = self getweaponammostock(var_05);
				self setweaponammostock(var_05,var_02 + var_06);
				self.var_A035 = var_05;
			}

			return;
		}
	}
	else
	{
		var_06 = self getweaponammostock(var_00);
		self setweaponammostock(var_00,var_02 + var_06);
		self.var_A035 = scripts\cp\_utility::func_80D8(var_00);
	}

	self playlocalsound("weap_ammo_pickup");
}

//Function Number: 38
func_82E8()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(function_024C(var_02) == "riotshield")
		{
			continue;
		}

		if(scripts\cp\_weapon::func_9C22(var_02))
		{
			continue;
		}

		var_03 = scripts\cp\_utility::func_80D8(var_02);
		self.var_A035 = var_03;
		var_04 = function_0249(var_02);
		var_05 = int(var_04 * lib_0CFF::func_D876());
		self setweaponammostock(var_02,var_05);
	}

	self playlocalsound("weap_ammo_pickup");
}

//Function Number: 39
func_38BA()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(function_024C(var_02) == "riotshield")
		{
			continue;
		}

		if(scripts\cp\_weapon::func_9C22(var_02))
		{
			continue;
		}

		var_03 = scripts\cp\_utility::func_80D8(var_02);
		var_04 = function_0249(var_02);
		var_05 = var_04;
		var_06 = self getweaponammostock(var_02);
		if(var_06 < var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
func_CB5B(param_00,param_01,param_02)
{
	if(![[ level.should_drop_pillage ]](param_02,param_01))
	{
		return 0;
	}

	level thread func_10798(param_01);
	return 1;
}

//Function Number: 41
func_FF3D(param_00,param_01)
{
	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return 0;
	}

	if(isdefined(self.entered_playspace) && !self.entered_playspace)
	{
		return 0;
	}

	if(!is_in_active_volume(param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 42
is_in_active_volume(param_00)
{
	if(isdefined(level.var_9B0B))
	{
		if(!scripts\cp\_weapon::func_9E54(param_00,level.var_9B0B,undefined,undefined,1))
		{
			return 0;
		}
	}
	else if(!scripts\cp\_weapon::func_9E54(param_00,undefined,undefined,undefined,1))
	{
		return 0;
	}

	if(!isdefined(level.var_1646))
	{
		return 1;
	}

	foreach(var_02 in level.var_1646)
	{
		if(function_010F(param_00,var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 43
func_10798(param_00,param_01,param_02)
{
	var_03 = 0;
	if(var_03)
	{
		var_04 = 2;
		var_05 = -150;
		var_06 = 50;
		level.var_A8F5 = gettime();
		level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D,level.var_CB5C);
		var_07 = spawn("script_model",param_00 + (0,0,80));
		var_07.angles = (0,0,0);
		var_08 = scripts\common\utility::random(level.var_CB5E);
		var_07 setmodel(var_08);
		scripts\common\utility::func_136F7();
		var_09 = trajectorycalculateinitialvelocity(param_00 + (0,0,80),param_00 + (0,0,80) + (randomintrange(-10,10),randomintrange(-10,10),0),(0,0,var_05),2);
		var_07 physicslaunchserver(var_07.origin + (randomintrange(-5,5),randomintrange(-5,5),0),var_09 * var_04,var_06);
	}
	else
	{
		var_04 = 10;
		var_05 = 800;
		var_06 = 50;
		var_07 = spawn("script_model",param_01);
		if(isdefined(param_01))
		{
			var_07.angles = param_01;
		}
		else
		{
			var_07.angles = (0,0,0);
		}

		var_07 setmodel(param_02);
		scripts\common\utility::func_136F7();
		var_07 physicslaunchserver(var_07.origin + (12,0,0),(0,0,0));
	}

	for(;;)
	{
		var_0A = var_07.origin;
		wait(0.25);
		if(distance(var_0A,var_07.origin) < 8)
		{
			break;
		}
	}

	if(ispointonnavmesh(var_07.origin))
	{
		level.var_A8F5 = gettime();
		level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D,level.var_CB5C);
		var_0B = func_4934(var_07);
		return;
	}

	var_07 scripts\cp\_weapon::func_CC16("pillage",1,var_07.origin);
	var_07 delete();
}

//Function Number: 44
func_4934(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01.script_noteworthy = "pillage_item";
	var_01.var_457D = func_7B82(var_01,param_00);
	var_01.var_CB47 = func_7A06(var_01.var_195);
	var_01.var_A038 = func_7A09(var_01.var_195);
	var_01.var_E1B9 = 0;
	var_01.var_D776 = 1;
	var_01.var_EE79 = "default";
	var_01.var_4C72 = 96;
	var_01 setmodel(param_00.model);
	param_00 delete();
	var_01 thread func_13971();
	var_01 thread func_5135(var_01);
	level.var_163C[level.var_163C.size] = var_01;
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	if(var_01.type == "battery")
	{
		var_02 = spawn("script_model",var_01.origin + (0,0,20));
		var_03 = spawnfx(level._effect["pillage_box"],var_01.origin);
		scripts\common\utility::func_136F7();
		triggerfx(var_03);
		scripts\common\utility::func_136F7();
		var_02 setmodel("crafting_battery_single_01");
		var_01 scripts\common\utility::waittill_any_timeout_1(60,"all_players_searched");
		if(isdefined(var_02))
		{
			var_02 delete();
		}

		if(isdefined(var_03))
		{
			var_03 delete();
		}
	}
	else if(var_01.type != "quest" && var_01.type != "battery")
	{
		var_03 = spawnfx(level._effect["pillage_box"],var_01.origin);
		scripts\common\utility::func_136F7();
		triggerfx(var_03);
		var_01 scripts\common\utility::waittill_any_timeout_1(60,"all_players_searched");
		if(isdefined(var_03))
		{
			var_03 delete();
		}
	}
	else
	{
		var_01 scripts\common\utility::waittill_any_timeout_1(60,"all_players_searched");
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
}

//Function Number: 45
func_CB59(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.inlaststand))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return "";
	}

	if(isdefined(param_00.var_CB47))
	{
		return param_00.var_CB47;
	}

	return "";
}

//Function Number: 46
func_7B80(param_00)
{
	switch(param_00)
	{
	}
}

//Function Number: 47
func_4ED7(param_00)
{
	var_01 = strtok(param_00,"+");
	var_02 = var_01[0];
	var_03 = var_01[1];
	foreach(var_05 in level.spawned_enemies)
	{
		var_05 setscriptablepartstate(var_02,var_03);
	}
}