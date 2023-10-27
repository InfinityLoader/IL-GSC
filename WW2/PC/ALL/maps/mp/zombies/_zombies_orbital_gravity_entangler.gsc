/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zombies_orbital_gravity_entangler.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 434 ms
 * Timestamp: 10/27/2023 3:13:48 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	var_00 = common_scripts\utility::func_46B5("orbital_gravity_entangler","targetname");
	var_01 = common_scripts\utility::func_46B5(var_00.var_1A2,"targetname");
	var_00.var_14F = distance(var_00.var_116,var_01.var_116);
	var_02 = var_00 common_scripts\utility::func_8FFC();
	var_02 method_805B();
	var_02 thread rotate_me();
	var_03 = var_00 common_scripts\utility::func_8FFC();
	var_03 method_805B();
	var_03 thread rotate_me(1);
	level.oribital_rotator_1 = var_02;
	level.oribital_rotator_2 = var_03;
	add_entangler_fx();
	var_00.rotator = var_02;
	level thread maps\mp\_utility::func_6F74(::watch_for_grenades_and_projectiles,var_00);
	level thread maps\mp\_utility::func_6F74(::watchplayerjump);
	level.grenades_in_orbit = [];
	level thread watch_for_entanglements();
	level.zmb_all_side_ee_colors = [];
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "white";
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "yellow";
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "red";
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "blue";
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "green";
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "magenta";
	level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "cyan";
}

//Function Number: 2
get_color_for_grenade(param_00)
{
	foreach(var_02 in level.zmb_all_side_ee_colors)
	{
		if(issubstr(param_00,var_02))
		{
			return var_02;
		}
	}

	return "";
}

//Function Number: 3
watch_for_grab()
{
	var_00 = self;
	var_00.grenadecolorsheld = [];
	for(;;)
	{
		wait 0.05;
		if(!var_00 usebuttonpressed())
		{
			continue;
		}

		level.grenades_in_orbit = common_scripts\utility::func_FA0(level.grenades_in_orbit);
		var_01 = common_scripts\utility::func_40B0(var_00.var_116,level.grenades_in_orbit);
		var_01 = common_scripts\utility::func_FA0(var_01);
		if(var_01.size == 0)
		{
			continue;
		}

		if(!isdefined(var_01[0]))
		{
			continue;
		}

		if(distance2d(var_00.var_116,var_01[0].var_116) > 70)
		{
			continue;
		}

		lib_0586::func_478A(var_00);
		var_00.grenadecolorsheld = common_scripts\utility::func_F6F(var_00.grenadecolorsheld,var_01[0].var_3F74);
		var_01[0] remove_fake_projectile();
	}
}

//Function Number: 4
watch_for_entanglements()
{
	for(;;)
	{
		var_00 = [];
		level.grenades_in_orbit = common_scripts\utility::func_FA0(level.grenades_in_orbit);
		foreach(var_02 in level.grenades_in_orbit)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			foreach(var_04 in level.grenades_in_orbit)
			{
				if(!isdefined(var_04))
				{
					continue;
				}

				if(var_04 != var_02 && distance2d(var_04.var_116,var_02.var_116) < 60)
				{
					level.grenades_in_orbit = common_scripts\utility::func_F93(level.grenades_in_orbit,var_04);
					var_05 = get_hyper_color(var_02.var_3F74,var_04.var_3F74);
					if(isdefined(var_05))
					{
						var_02 set_fx(var_05);
					}
					else
					{
						var_02 detonateusingweapon(var_02.var_A9E0,var_02.var_117,var_02);
						var_02 remove_fake_projectile();
					}

					var_04 remove_fake_projectile();
					break;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 5
watchplayerjump()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00 waittill("jumped");
}

//Function Number: 6
rotate_me(param_00)
{
	self endon("entitydeleted");
	for(;;)
	{
		var_01 = 1;
		if(common_scripts\utility::func_562E(param_00))
		{
			var_01 = -1;
		}

		if(function_0279(self))
		{
			return;
		}

		self rotateyaw(var_01 * 180,1);
		wait(1);
	}
}

//Function Number: 7
remove_grenade_color()
{
	var_00 = self;
	var_01 = var_00.grenadecolorsheld[0];
	if(var_00.grenadecolorsheld.size > 1)
	{
		var_00.grenadecolorsheld = common_scripts\utility::func_FA3(var_00.grenadecolorsheld,1);
	}
	else
	{
		var_00.grenadecolorsheld = [];
	}

	return var_01;
}

//Function Number: 8
watch_for_grenades_and_projectiles(param_00)
{
	var_01 = self;
	var_02 = 1200;
	var_01 endon("disconnect");
	var_03 = param_00.var_14F;
	var_04 = param_00.var_116;
	childthread watch_for_grab();
	var_05 = ["frag_grenade_zm","c4_zm","semtex_zm","throwingknife_zm"];
	common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_deathraven","quest_deathraven_survive_rush"));
	for(;;)
	{
		self waittill("grenade_fire",var_06,var_07);
		if(!common_scripts\utility::func_F79(var_05,var_07))
		{
			continue;
		}

		if(abs(self.var_116[2] - var_04[2]) > 60 || distance2d(var_06.var_116,var_04) > var_03)
		{
			if(var_01.grenadecolorsheld.size > 0)
			{
				var_08 = var_06 spawn_a_fake_grenade(var_01,var_07);
				if(function_0279(var_08))
				{
					continue;
				}

				var_08 set_fx(var_01 remove_grenade_color());
				var_08 thread move_no_gravity(var_01,var_02);
			}

			continue;
		}

		var_09 = get_is_facing_against_circle(var_01,var_04);
		var_08 = var_06 spawn_a_fake_grenade(var_01,var_07);
		if(!isdefined(var_08))
		{
			continue;
		}

		if(var_09)
		{
			var_08 method_8449(level.oribital_rotator_1);
		}
		else
		{
			var_08 method_8449(level.oribital_rotator_2);
		}

		if(!isdefined(var_08))
		{
			continue;
		}

		var_08.var_A9E0 = var_07;
		var_08.var_117 = self;
		level.grenades_in_orbit = common_scripts\utility::func_F6F(level.grenades_in_orbit,var_08);
		var_08 thread handle_detonation(self,var_07);
	}
}

//Function Number: 9
move_no_gravity(param_00,param_01)
{
	var_02 = self;
	var_02 endon("entitydeleted");
	var_03 = param_00 geteye() + 10000 * vectornormalize(anglestoforward(param_00 geteyeangles()));
	var_04 = param_00 geteye() + 32 * vectornormalize(anglestoforward(param_00 geteyeangles()));
	var_05 = bullettrace(var_04,var_03,0);
	var_06 = var_05["position"];
	if(!isdefined(var_06))
	{
		var_06 = var_03;
	}

	var_07 = distance(param_00 geteye(),var_06) / param_01;
	var_02 moveto(var_06,var_07);
	wait(var_07);
	var_02.forcedetonate = 1;
}

//Function Number: 10
spawn_a_fake_grenade(param_00,param_01)
{
	if(!isdefined(level.zmb_gravity_grenades))
	{
		level.zmb_gravity_grenades = [];
	}

	var_02 = self;
	var_03 = var_02 common_scripts\utility::func_8FFC();
	var_03 method_805B();
	var_03.var_1D = (30,0,15);
	var_04 = getzombielethalmodel(param_01);
	var_03 setmodel(var_04);
	var_03 childthread seek_enemy_targets(param_00,param_01);
	var_03 childthread rotate_me();
	var_02 thread delay_delete();
	level.zmb_gravity_grenades = get_all_magical_grenades();
	level.zmb_gravity_grenades[level.zmb_gravity_grenades.size] = var_03;
	return var_03;
}

//Function Number: 11
get_all_magical_grenades()
{
	if(!isdefined(level.zmb_gravity_grenades))
	{
		return [];
	}

	var_00 = [];
	foreach(var_02 in level.zmb_gravity_grenades)
	{
		if(!function_0279(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 12
get_is_facing_against_circle(param_00,param_01)
{
	var_02 = get_player_angle_flat();
	var_03 = (param_00.var_116[0],param_00.var_116[1],param_01[2]);
	var_04 = get_circle_angle_compare(var_03,param_01);
	var_05 = var_02 - var_04;
	var_06 = int(var_05 < -200 || var_05 <= 90 && var_05 >= 0);
	return !var_06;
}

//Function Number: 13
get_player_angle_flat()
{
	var_00 = common_scripts\utility::func_3D5C(self geteyeangles());
	var_00 = var_00[1];
	return int(var_00);
}

//Function Number: 14
get_circle_angle_compare(param_00,param_01)
{
	var_02 = param_01[0] - param_00[0];
	var_03 = param_01[1] - param_00[1];
	var_04 = function_01E3(var_03,var_02);
	return int(var_04);
}

//Function Number: 15
handle_detonation(param_00,param_01)
{
	self endon("entitydeleted");
	self.lethallevel = 0;
	set_fx("proj_trail_white");
	if(param_00.grenadecolorsheld.size > 0)
	{
		var_02 = param_00 remove_grenade_color();
		set_fx(var_02);
		return;
	}

	wait_frames(50);
	if(function_0279(self))
	{
		return;
	}

	self.lethallevel++;
	set_fx("proj_trail_yellow");
	wait_frames(100);
	if(function_0279(self))
	{
		return;
	}

	self.lethallevel++;
	set_fx("proj_trail_red");
	wait_frames(150);
	if(function_0279(self))
	{
		return;
	}

	self.lethallevel++;
	set_fx("proj_trail_blue");
}

//Function Number: 16
get_hyper_color(param_00,param_01)
{
	var_02 = [param_00,param_01];
	if(func_4B29("blue",var_02) && func_4B29("yellow",var_02))
	{
		return "proj_trail_green";
	}

	if(func_4B29("blue",var_02) && func_4B29("red",var_02))
	{
		return "proj_trail_magenta";
	}

	if(func_4B29("blue",var_02) && func_4B29("green",var_02))
	{
		return "proj_trail_cyan";
	}
}

//Function Number: 17
func_4B29(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(issubstr(var_03,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 18
wait_frames(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		wait 0.05;
	}
}

//Function Number: 19
set_fx(param_00)
{
	if(isdefined(self.var_3F2F))
	{
		self.var_3F2F delete();
	}

	self.var_3F74 = param_00;
	self.var_3F2F = spawnlinkedfx(common_scripts\utility::func_44F5(param_00),self,"tag_fx");
	self.ee_color = get_color_for_grenade(param_00);
	triggerfx(self.var_3F2F);
}

//Function Number: 20
seek_enemy_targets(param_00,param_01)
{
	self endon("entitydeleted");
	var_02 = 0;
	var_03 = 800;
	while(!common_scripts\utility::func_562E(self.forcedetonate) && var_03 > 0 && !var_02)
	{
		if(function_0279(self))
		{
			return;
		}

		var_04 = lib_0547::func_408F();
		foreach(var_06 in var_04)
		{
			if(distance(self.var_116,var_06.var_116) < 96)
			{
				var_02 = 1;
				break;
			}
		}

		var_03--;
		if(!var_02)
		{
			wait 0.05;
		}
	}

	if(function_0279(self))
	{
		return;
	}

	if(lib_0547::func_5565(param_01,"throwingknife_zm"))
	{
		if(!isdefined(self.lethallevel))
		{
			self.lethallevel = 0;
		}

		if(self.lethallevel == 0)
		{
			var_06 = common_scripts\utility::func_4461(self.var_116,lib_0547::func_408F());
			if(isdefined(var_06) && distance(self.var_116,var_06.var_116) < 96)
			{
				var_06 dodamage(var_06.var_BC + 1,self.var_116,param_00,self,"MOD_MELEE",param_01);
				remove_fake_projectile();
				return;
			}
		}
		else
		{
			param_01 = "frag_grenade_zm";
		}
	}

	self detonateusingweapon(param_01,param_00,self);
	remove_fake_projectile();
}

//Function Number: 21
remove_fake_projectile()
{
	if(isdefined(self.var_3F2F))
	{
		self.var_3F2F delete();
	}

	self delete();
}

//Function Number: 22
delay_delete()
{
	self endon("entitydeleted");
	self method_8511();
	wait 0.05;
	self delete();
}

//Function Number: 23
add_entangler_fx()
{
	common_scripts\utility::func_92C("proj_trail_white","vfx/map/mp_zombie_descent/side_ee/proj_trail_white");
	common_scripts\utility::func_92C("proj_trail_yellow","vfx/map/mp_zombie_descent/side_ee/proj_trail_yellow");
	common_scripts\utility::func_92C("proj_trail_red","vfx/map/mp_zombie_descent/side_ee/proj_trail_red");
	common_scripts\utility::func_92C("proj_trail_blue","vfx/map/mp_zombie_descent/side_ee/proj_trail_blue");
	common_scripts\utility::func_92C("proj_trail_green","vfx/map/mp_zombie_descent/side_ee/proj_trail_green");
	common_scripts\utility::func_92C("proj_trail_green_os","vfx/map/mp_zombie_descent/side_ee/proj_trail_green_os");
	common_scripts\utility::func_92C("proj_trail_magenta","vfx/map/mp_zombie_descent/side_ee/proj_trail_magenta");
	common_scripts\utility::func_92C("proj_trail_cyan","vfx/map/mp_zombie_descent/side_ee/proj_trail_cyan");
	common_scripts\utility::func_92C("zmb_ber_gun_cone_glow_pap","vfx/map/mp_zombie_dig02/dlc_zmb_gun_cone_glow_pap");
}

//Function Number: 24
getzombielethalmodel(param_00)
{
	var_01 = "npc_usa_frag";
	switch(param_00)
	{
		case "frag_grenade_zm":
			var_01 = "npc_usa_frag";
			break;

		case "c4_zm":
			var_01 = "gen_satchel_charge";
			break;

		case "semtex_zm":
			var_01 = "npc_eng_n74_mk1_sticky";
			break;

		case "bouncingbetty_zm":
			var_01 = "npc_usa_frag";
			break;

		case "thermite_zm":
			var_01 = "npc_usa_frag";
			break;

		case "throwingknife_zm":
			var_01 = "projectile_usa_phantom_throwing_knife";
			break;

		case "thermite_flames_mp":
			var_01 = "npc_usa_frag";
			break;

		case "killstreak_carepackage_grenade_mp":
			var_01 = "npc_usa_frag";
			break;

		case "alt+wunderbuss_zm":
			var_01 = "npc_usa_frag";
			break;

		case "frag_grenade_funderbuss_zm":
			var_01 = "npc_usa_frag";
			break;
	}

	return var_01;
}