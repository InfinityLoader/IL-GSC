/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zombies_event_mtx7.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 422 ms
 * Timestamp: 10/27/2023 3:13:43 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.zmb_total_fish_collected = 0;
	var_00 = getdvarint("spv_zmb_event_mtx7_active",-1);
	if(var_00 == -1)
	{
		var_00 = 1;
	}

	var_01 = var_00;
	if(!function_02A3())
	{
		var_01 = 0;
	}

	if(!maps\mp\_utility::isproductionlevelactive(16))
	{
		return;
	}

	if(!var_01)
	{
		if(maps\mp\_utility::func_4571() == "mp_zombie_island" || maps\mp\_utility::func_4571() == "mp_zombie_dnk" || maps\mp\_utility::func_4571() == "mp_zombie_dnk_srv")
		{
			apply_cosmetic_changes(1);
			level.zmb_additional_look_check = ::limit_oceanic_zombies;
		}

		return;
	}

	if(!issubstr(maps\mp\_utility::func_4571(),"mp_zombie"))
	{
		return;
	}

	common_scripts\utility::func_92C("mtx_fish_despawn","vfx/map/mp_zombie_island/zmb_isl_beach_fish_flop_mtx7");
	if(maps\mp\_utility::func_4571() == "mp_zombie_island")
	{
		level thread run_fish_quest();
	}

	apply_cosmetic_changes();
	level.zmb_additional_look_check = ::limit_oceanic_zombies;
}

//Function Number: 2
limit_oceanic_zombies(param_00)
{
	var_01 = 0;
	foreach(var_03 in lib_0547::func_408F())
	{
		if(lib_0547::is_wet_zombie(undefined,var_03))
		{
			var_01++;
		}
	}

	var_05 = 3;
	if(getdvarint("scr_zmbMaxOceanicZombies",0) > 0)
	{
		var_05 = getdvarint("scr_zmbMaxOceanicZombies",0);
	}

	if(var_01 >= var_05)
	{
		param_00 = common_scripts\utility::func_F94(param_00,["oceana","oceanb"]);
	}

	return param_00;
}

//Function Number: 3
apply_cosmetic_changes(param_00)
{
	level.zombie_prevent_fx_play_func = ::has_body_model;
	level thread add_ocean_zombie_look();
	if(!common_scripts\utility::func_562E(param_00))
	{
		level.zmb_mtx7_event_attached_props = [];
		register_prop_placement("zom_harpoon","J_Shoulder_RI",(12,0,0),(-20,0,0));
		register_prop_placement("zom_harpoon","J_Shoulder_LE",(0,0,0),(30,0,0));
		register_prop_placement("zom_harpoon","J_HipTwist_RI",(0,0,0),(270,0,0));
		register_prop_placement("zom_harpoon","J_SpineLower",(6,0,0),(0,90,0));
		level thread lib_0547::perzombiethread(::spawn_fish_on_zombies);
		lib_0547::func_7BA9(::remove_fish_from_zombies);
	}
}

//Function Number: 4
spawn_fish_on_zombies()
{
	if(!lib_0547::is_wet_zombie(undefined,self))
	{
		return;
	}

	if(!lib_0547::func_5565(self.var_A4B,"zombie_generic"))
	{
		return;
	}

	if(randomint(100) < 75)
	{
		return;
	}

	var_00 = get_random_attached_prop();
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel(var_00.char_model);
	var_01 method_8449(self,var_00.joint,var_00.pos_offset,var_00.var_DD2);
	self.attached_ocean_model = var_01;
}

//Function Number: 5
remove_fish_from_zombies(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(self.attached_ocean_model))
	{
		self.attached_ocean_model delete();
	}

	if(lib_0547::is_wet_zombie(undefined,self))
	{
		level thread spawn_pickupable_fish(self.var_116,self geteyeangles());
	}
}

//Function Number: 6
spawn_pickupable_fish(param_00,param_01)
{
	if(!isdefined(level.mtx7_fish_array))
	{
		level.mtx7_fish_array = [];
	}

	var_02 = undefined;
	if(level.mtx7_fish_array.size < 2)
	{
		var_02 = spawn("script_model",param_00);
		var_02 setmodel("zmi_fish_single_01");
		level.mtx7_fish_array = common_scripts\utility::func_F6F(level.mtx7_fish_array,var_02);
	}
	else
	{
		foreach(var_04 in level.mtx7_fish_array)
		{
			if(!common_scripts\utility::func_562E(var_04.var_8BE))
			{
				var_02 = var_04;
				var_02 method_805B();
				break;
			}
		}
	}

	if(!isdefined(var_02))
	{
		return;
	}

	var_02 thread fall_onto_ground(param_00,param_01);
	var_02.var_8BE = 1;
	var_06 = var_02 wait_for_player_close_to_fish(60,1);
	if(isdefined(var_06))
	{
		var_06 thread maps/mp/_events_z::contracts_report_player_picked_up_fish();
		var_06 thread maps/mp/gametypes/zombies::func_4798(10);
		if(!common_scripts\utility::func_562E(var_06.foundafish) && maps\mp\_utility::func_4571() == "mp_zombie_island")
		{
			lib_0555::func_83DD("fish_single",var_06);
			var_06.foundafish = 1;
		}

		lib_0378::func_8D74("zmb_points_pickup",var_06.var_116);
		level.zmb_total_fish_collected++;
	}

	var_02 remove_fish(isdefined(var_06));
}

//Function Number: 7
fall_onto_ground(param_00,param_01)
{
	var_02 = 0.4;
	self.var_116 = param_00 + (0,0,40) + 18 * vectornormalize(anglestoforward(param_01));
	self.var_1D = (0,randomint(360),0);
	self gravitymove((0,0,175),2);
	self.var_6C48 = self.var_1D;
	self rotateby((180,180,0),var_02);
	wait(var_02);
	self.var_1D = self.var_6C48;
	self.var_116 = param_00;
}

//Function Number: 8
remove_fish(param_00)
{
	if(!common_scripts\utility::func_562E(param_00))
	{
		playfx(common_scripts\utility::func_44F5("mtx_fish_despawn"),self.var_116);
	}

	self method_8511();
	self.var_8BE = 0;
}

//Function Number: 9
wait_for_player_close_to_fish(param_00,param_01)
{
	var_02 = gettime();
	for(;;)
	{
		if(isdefined(param_01) && gettime() - var_02 > 4000)
		{
			return;
		}

		foreach(var_04 in level.var_744A)
		{
			if(distance(var_04.var_116,self.var_116) < param_00)
			{
				return var_04;
			}
		}

		wait 0.05;
	}
}

//Function Number: 10
register_prop_placement(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.char_model = param_00;
	var_04.joint = param_01;
	var_04.pos_offset = param_02;
	var_04.var_DD2 = param_03;
	level.zmb_mtx7_event_attached_props = common_scripts\utility::func_F6F(level.zmb_mtx7_event_attached_props,var_04);
}

//Function Number: 11
get_random_attached_prop()
{
	return common_scripts\utility::func_7A33(level.zmb_mtx7_event_attached_props);
}

//Function Number: 12
add_ocean_zombie_look()
{
	if(!isdefined(level.var_A50))
	{
		level.var_A50 = [];
	}

	var_00 = ["zombie_generic","zombie_heavy"];
	foreach(var_02 in var_00)
	{
		if(!isdefined(level.var_A50[var_02]))
		{
			level.var_A50[var_02] = [];
		}

		if(!isdefined(level.var_A50[var_02].var_5ED2))
		{
			level.var_A50[var_02].var_5ED2 = [];
		}
	}

	add_ocean_look("a");
	add_ocean_look("b");
	add_ocean_look_follower();
}

//Function Number: 13
add_ocean_look_follower()
{
	level.var_A50["zombie_heavy"].var_5ED2["ocean"]["whole_body"] = "zom_follower_wet_base";
}

//Function Number: 14
add_ocean_look(param_00)
{
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00] = [];
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["whole_body"] = "zom_infantry" + param_00 + "_wet_bodywhole";
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["torso"] = "zom_infantry" + param_00 + "_wet_torso_slice";
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["left_arm"] = "zom_infantrya_wet_l_arm_slice";
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["left_leg"] = "zom_infantrya_wet_l_leg_slice";
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["right_arm"] = "zom_infantrya_wet_r_arm_slice";
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["right_leg"] = "zom_infantrya_wet_r_leg_slice";
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["heads"] = ["zom_head_wet_fdr02_org1","zom_head_wet_fdr03_org1","zom_head_wet_fdr04_org1"];
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["helmets"] = level.var_A50["zombie_generic"].var_5ED2["guts"]["helmets"];
	level.var_A50["zombie_generic"].var_5ED2["ocean" + param_00]["facegear"] = level.var_A50["zombie_generic"].var_5ED2["guts"]["facegear"];
}

//Function Number: 15
has_body_model()
{
	var_00 = ["zombie_assassin"];
	return common_scripts\utility::func_F79(var_00,self.var_A4B) || isdefined(self.var_18A8) && self.var_18A8.var_106 == "";
}

//Function Number: 16
run_fish_quest()
{
	var_00 = spawn("script_model",(432,1824,-8));
	var_00.var_1D = (0,174,0);
	var_00 setmodel("zdu_red_herring_obj_01");
	var_00 scriptmodelplayanim("zmb_follow_the_fish_loop",undefined,0,0.4);
	var_01 = spawn("script_model",(432,1824,-8));
	var_01.var_1D = (13,80,-7);
	var_01 setmodel("ger_crate_ammo_closed_01_dirty");
	var_01.var_116 = var_01.var_116 + (0,0,-32);
	var_00 thread move_current();
	wait_for_required_fish();
	foreach(var_03 in level.var_744A)
	{
		lib_0555::func_83DD("fish_total_ee",var_03);
	}

	var_00 wait_for_player_close_to_fish(130);
	wait(1);
	var_00 notify("leaving");
	var_00 movez(-12,2,1);
	var_00 rotateyaw(170,3);
	wait(3);
	var_01 moveto(var_01.var_116 + (0,0,32),6,0,1);
	var_01 thread vibrate_box();
	var_01 lib_0547::func_AC41(&"ZOMBIES_EMPTY_STRING",(0,0,16));
	level thread maps\mp\_utility::func_6F74(::collect_teslaguns,var_01);
}

//Function Number: 17
collect_teslaguns(param_00)
{
	param_00 waittill("player_used",var_01);
	var_01 thread ee_give_teslagun_rental("teslagun_zm");
}

//Function Number: 18
wait_for_required_fish()
{
	while(!isdefined(level.zmb_total_fish_collected) || level.zmb_total_fish_collected < 50)
	{
		wait(1);
	}
}

//Function Number: 19
vibrate_box()
{
	for(;;)
	{
		self vibrate(anglestoforward(self.var_1D),2.1,3,3);
		wait(3);
	}
}

//Function Number: 20
ee_give_teslagun_rental(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("disconnect");
	var_01 lib_0586::func_78C(param_00);
	var_01 lib_0586::func_78E(param_00);
	lib_0555::func_83DD("teslagun_found",var_01);
	wait_for_usage_done(param_00);
	if(var_01 hasweapon(param_00))
	{
		var_02 = var_01 getweaponslistprimaries();
		var_01 lib_0586::func_790(param_00);
		var_01 lib_0586::func_78E(var_02[0]);
	}
}

//Function Number: 21
wait_for_usage_done(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("disconnect");
	wait(180);
}

//Function Number: 22
force_take_tesla()
{
	var_00 = self;
	var_00 notify("force_take_tesla");
}

//Function Number: 23
move_current()
{
	self endon("leaving");
	var_00 = self.var_116 + 7 * vectornormalize(anglestoright(self.var_1D));
	self.var_6C4E = self.var_116;
	for(;;)
	{
		self moveto(var_00,2,1,1);
		wait(2);
		self moveto(self.var_6C4E,2,1,1);
		wait(4);
	}
}