/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3419.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 12:27:10 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_26A0 = [];
	level.player_character_info = [];
	level thread func_50C9();
}

//Function Number: 2
func_50C9()
{
	wait(4.5);
	setomnvar("zm_player_photo",0);
	setomnvar("zm_player_status",0);
	setomnvar("zm_player_character",4095);
}

//Function Number: 3
func_8361(param_00,param_01)
{
	if(!isdefined(level.var_CA60))
	{
		func_958F();
	}

	var_02 = self;
	var_02.var_3C64 = undefined;
	var_02 method_83B7();
	if(!scripts\common\utility::istrue(var_02.keep_perks))
	{
		var_02 scripts\cp\_utility::func_11AA();
	}

	var_02 thread delayreturningperks(var_02);
	var_02 scripts\cp\_utility::func_11D7();
	var_02.var_108EF = 0;
	if(isdefined(var_02.var_8C98))
	{
		var_02.var_8C98 = undefined;
	}

	var_03 = func_7B89();
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	var_02 thread func_F7A2(var_03);
	var_04 = func_8078();
	var_05 = var_02 func_8070(var_04);
	var_02 method_82C6(var_05);
	scripts\common\utility::flag_wait("introscreen_over");
	if(isdefined(level.var_BC70))
	{
		self [[ level.var_BC70 ]]();
	}
	else
	{
		func_12ED5();
	}

	var_02.var_D8E1 = "none";
	var_02 thread scripts\cp\_weapon::func_FB18();
	var_02 notify("giveLoadout");
	var_02 scripts\cp\_utility::func_8387("specialty_pistoldeath");
	var_02 scripts\cp\_utility::func_8387("specialty_sprintreload");
	var_02 scripts\cp\_utility::func_8387("specialty_gung_ho");
	var_02.var_BCF6 = var_02 lib_0CFF::func_D878();
	if(isdefined(param_00) && param_00)
	{
		return;
	}

	var_06 = var_02.melee_weapon;
	if(isdefined(var_02.var_501B))
	{
		var_02.melee_weapon = var_02.var_501B;
		var_06 = var_02.var_501B;
	}

	var_02 giveweapon(var_06);
	var_02.var_501B = var_06;
	var_02.var_4BF5 = var_06;
	if(isdefined(var_02.starting_weapon))
	{
		var_02.var_501C = var_02.starting_weapon;
	}
	else if(isdefined(level.var_502E))
	{
		var_02.var_501C = level.var_502E;
	}
	else
	{
		var_02.var_501C = "iw7_g18_zmr";
	}

	var_07 = scripts\cp\_utility::func_80D8(var_02.var_501C);
	var_02.var_501C = return_wbk_version_of_weapon(var_02,var_07,var_02.var_501C);
	if(isdefined(level.var_A913))
	{
		var_02.var_A913 = level.var_A913;
	}
	else
	{
		var_02.var_A913 = var_02.var_501C;
	}

	var_08 = scripts\cp\_utility::func_80D8(var_02.var_501C);
	var_02 scripts\cp\_utility::func_12C6(var_02.var_501C,undefined,undefined,1);
	var_02 [[ level.var_BC70 ]]();
	var_09 = spawnstruct();
	var_09.var_B111 = func_785A(var_02,var_08);
	var_02.var_C8A2[var_08] = var_09;
	var_02 giveweapon("super_default_zm");
	var_02 method_84C2("super_default_zm");
	var_02.var_10967 = "super_default_zm";
	if(function_0114())
	{
		var_02 thread func_1358A(var_02.var_501C);
	}
	else
	{
		var_02 method_833B(var_02.var_501C,1);
	}

	if(isdefined(level.force_used_clip))
	{
		var_02 setweaponammoclip(var_02.var_501C,int(level.force_used_clip / 100 * weaponclipsize(var_02.var_501C)));
	}

	if(isdefined(level.force_starting_ammo))
	{
		var_02 setweaponammostock(var_02.var_501C,level.force_starting_ammo);
	}

	if(isdefined(level.additional_loadout_func))
	{
		[[ level.additional_loadout_func ]](var_02);
	}

	var_02 notify("weapon_level_changed");
	var_02 func_F53D();
	var_02 notify("loadout_given");
}

//Function Number: 4
return_wbk_version_of_weapon(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	if(!scripts\common\utility::istrue(param_00.weaponkitinitialized))
	{
		param_00 waittill("player_weapon_build_kit_initialized");
	}

	if(isdefined(param_00.var_13C00[param_01]))
	{
		return param_00.var_13C00[param_01];
	}

	return param_02;
}

//Function Number: 5
delayreturningperks(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	wait(1);
	if(scripts\common\utility::istrue(param_00.keep_perks))
	{
		if(isdefined(param_00.var_13FA4))
		{
			var_01 = getarraykeys(param_00.var_13FA4);
			foreach(var_03 in var_01)
			{
				if(isdefined(level.var_462C) && isdefined(level.var_462C[var_03]) && isdefined(level.var_462C[var_03].var_F286))
				{
					param_00 [[ level.var_462C[var_03].var_F286 ]]();
				}
			}
		}

		param_00.keep_perks = undefined;
	}
}

//Function Number: 6
release_character_number(param_00)
{
	var_01 = param_00.var_CFC4;
	if(!scripts\common\utility::func_2286(level.var_26A0,var_01) && var_01 != 5 && var_01 != 6)
	{
		level.var_26A0 = scripts\common\utility::array_add(level.var_26A0,var_01);
	}
}

//Function Number: 7
func_785A(param_00,param_01)
{
	if(isdefined(param_00.var_C8A2[param_01]))
	{
		return param_00.var_C8A2[param_01].var_B111;
	}

	return 1;
}

//Function Number: 8
func_F7A2(param_00)
{
	level endon("game_ended");
	var_01 = level.player_character_info[param_00];
	self.var_134FD = var_01.var_134FD;
	self.vo_suffix = var_01.vo_suffix;
	self.pap_gesture = var_01.pap_gesture;
	self.pap_gesture_anim = var_01.pap_gesture_anim;
	self.revive_gesture = var_01.revive_gesture;
	self.var_6BA3 = var_01.var_6BA3;
	self.intro_music = var_01.intro_music;
	self.intro_gesture = var_01.intro_gesture;
	self.melee_weapon = var_01.melee_weapon;
	self.starting_weapon = var_01.starting_weapon;
	wait(0.05);
	func_F68D(var_01.body_model,var_01.head_model,var_01.view_model,var_01.hair_model);
	thread func_F7F3(self,var_01.photo_index);
	if(isdefined(var_01.post_setup_func))
	{
		[[ var_01.post_setup_func ]](self);
	}
}

//Function Number: 9
func_7B89()
{
	var_01 = getdvar("ui_mapname");
	if(isdefined(self.var_CFC4))
	{
		return self.var_CFC4;
	}

	var_02 = scripts\common\utility::random(level.var_26A0);
	switch(var_01)
	{
		case "cp_zmb":
			if(self getplayerdata("cp","zombiePlayerLoadout","characterSelect") == 1)
			{
				var_02 = 5;
				self setplayerdata("cp","zombiePlayerLoadout","characterSelect",0);
			}
			else if(self getplayerdata("cp","zombiePlayerLoadout","characterSelect") == 5)
			{
				var_02 = 6;
				self setplayerdata("cp","zombiePlayerLoadout","characterSelect",0);
			}
	
			level.var_26A0 = scripts\common\utility::func_22A9(level.var_26A0,var_02);
			break;

		case "cp_rave":
			if(self getplayerdata("cp","zombiePlayerLoadout","characterSelect") == 2)
			{
				var_02 = 5;
				self setplayerdata("cp","zombiePlayerLoadout","characterSelect",0);
			}
			else
			{
				level.var_26A0 = scripts\common\utility::func_22A9(level.var_26A0,var_02);
			}
			break;

		case "cp_disco":
			if(self getplayerdata("cp","zombiePlayerLoadout","characterSelect") == 3)
			{
				var_02 = 5;
				self setplayerdata("cp","zombiePlayerLoadout","characterSelect",0);
			}
			else
			{
				level.var_26A0 = scripts\common\utility::func_22A9(level.var_26A0,var_02);
			}
			break;

		case "cp_town":
			if(self getplayerdata("cp","zombiePlayerLoadout","characterSelect") == 4)
			{
				var_02 = 5;
				self setplayerdata("cp","zombiePlayerLoadout","characterSelect",0);
			}
			else
			{
				level.var_26A0 = scripts\common\utility::func_22A9(level.var_26A0,var_02);
			}
			break;

		default:
			level.var_26A0 = scripts\common\utility::func_22A9(level.var_26A0,var_02);
			break;
	}

	self.var_CFC4 = var_02;
	return var_02;
}

//Function Number: 10
func_F7F3(param_00,param_01)
{
	param_00 endon("disconnect");
	var_02 = param_00 getentitynumber();
	if(var_02 == 4)
	{
		var_02 = 0;
	}

	param_00.var_2B17 = func_786B(var_02);
	param_00.var_CFC3 = param_01;
	wait(5);
	func_F53E(param_00,"zm_player_character",func_789E(param_01));
	func_F53F(param_00,"healthy");
}

//Function Number: 11
func_F53F(param_00,param_01)
{
	func_F53E(param_00,"zm_player_status",func_7CAB(param_01));
}

//Function Number: 12
func_F53E(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_2B17))
	{
		setomnvarbit(param_01,param_00.var_2B17.var_2B16,param_02.var_2B16);
		setomnvarbit(param_01,param_00.var_2B17.var_2B15,param_02.var_2B15);
		setomnvarbit(param_01,param_00.var_2B17.var_2B14,param_02.var_2B14);
		param_00.photosetup = 1;
	}
}

//Function Number: 13
func_786B(param_00)
{
	var_01 = spawnstruct();
	switch(param_00)
	{
		case 3:
			var_01.var_2B16 = 11;
			var_01.var_2B15 = 10;
			var_01.var_2B14 = 9;
			break;

		case 2:
			var_01.var_2B16 = 8;
			var_01.var_2B15 = 7;
			var_01.var_2B14 = 6;
			break;

		case 1:
			var_01.var_2B16 = 5;
			var_01.var_2B15 = 4;
			var_01.var_2B14 = 3;
			break;

		case 0:
			var_01.var_2B16 = 2;
			var_01.var_2B15 = 1;
			var_01.var_2B14 = 0;
			break;
	}

	return var_01;
}

//Function Number: 14
func_789E(param_00)
{
	var_01 = spawnstruct();
	switch(param_00)
	{
		case 0:
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 0;
			var_01.var_2B14 = 0;
			break;

		case 1:
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 0;
			var_01.var_2B14 = 1;
			break;

		case 2:
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 1;
			var_01.var_2B14 = 0;
			break;

		case 3:
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 1;
			var_01.var_2B14 = 1;
			break;

		case 4:
			var_01.var_2B16 = 1;
			var_01.var_2B15 = 0;
			var_01.var_2B14 = 0;
			break;

		case 5:
			var_01.var_2B16 = 1;
			var_01.var_2B15 = 0;
			var_01.var_2B14 = 1;
			break;
	}

	return var_01;
}

//Function Number: 15
func_7CAB(param_00)
{
	var_01 = spawnstruct();
	switch(param_00)
	{
		case "healthy":
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 0;
			var_01.var_2B14 = 0;
			break;

		case "damaged":
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 0;
			var_01.var_2B14 = 1;
			break;

		case "laststand":
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 1;
			var_01.var_2B14 = 0;
			break;

		case "afterlife":
			var_01.var_2B16 = 0;
			var_01.var_2B15 = 1;
			var_01.var_2B14 = 1;
			break;
	}

	return var_01;
}

//Function Number: 16
func_F68D(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98);
	}

	self.var_2C14 = param_00;
	self setmodel(param_00);
	self method_8369(param_02);
	if(isdefined(param_01))
	{
		self attach(param_01,"",1);
		self.var_8C98 = param_01;
	}

	if(isdefined(param_03))
	{
		self attach(param_03,"",1);
		self.var_8862 = param_03;
	}
}

//Function Number: 17
func_8078()
{
	return 0;
}

//Function Number: 18
func_8070(param_00)
{
	return tablelookup("mp/cac/bodies.csv",0,param_00,5);
}

//Function Number: 19
func_12ED5()
{
	var_00 = undefined;
	if(isdefined(self.var_D42F))
	{
		var_00 = 1;
		var_00 = var_00 + self.var_D42F;
	}
	else
	{
		var_00 = func_807F(self);
		if(isdefined(self.var_3D12))
		{
			var_00 = self.var_3D12;
		}
		else if(isdefined(self.var_101D3))
		{
			var_00 = self.var_101D3;
		}

		var_01 = self.var_3E6B;
		if(isdefined(var_01) && isdefined(var_01.var_109AE))
		{
			var_00 = var_00 + var_01.var_109AE;
		}

		if(isdefined(self.var_109BB))
		{
			var_00 = var_00 + self.var_109BB;
		}

		if(isdefined(self.var_CAB0))
		{
			var_00 = var_00 + self.var_CAB0;
		}

		if(isdefined(self.var_13C70))
		{
			var_00 = var_00 + self.var_13C70;
		}

		if(isdefined(self.var_13CB2))
		{
			var_00 = var_00 + self.var_13CB2;
		}

		if(isdefined(self.var_13CB3))
		{
			var_00 = var_00 + self.var_13CB3;
		}

		var_00 = min(1.5,var_00);
	}

	self.var_13CCF = var_00;
	if(!isdefined(self.var_440B))
	{
		self.var_440B = 1;
	}

	self setmovespeedscale(var_00 * self.var_BCF6 * self.var_440B);
}

//Function Number: 20
func_807F(param_00)
{
	var_01 = 1;
	self.var_13CA0 = self getweaponslistprimaries();
	if(getdvar("normalize_movement_speed","on") == "on")
	{
		return 1;
	}

	if(!self.var_13CA0.size)
	{
		var_01 = 0.9;
	}
	else
	{
		var_02 = self getcurrentweapon();
		if(scripts\cp\_utility::func_9F8D(var_02))
		{
			var_01 = level.var_112A9[var_02].var_BCEF;
		}
		else
		{
			var_03 = function_0244(var_02);
			if(var_03 != "primary" && var_03 != "altmode")
			{
				if(isdefined(self.var_EB6B))
				{
					var_02 = self.var_EB6B;
				}
				else
				{
					var_02 = undefined;
				}
			}

			if(!isdefined(var_02) || !self hasweapon(var_02))
			{
				var_01 = func_8237();
			}
			else
			{
				var_01 = func_8236(var_02);
			}
		}
	}

	var_01 = func_4001(var_01);
	return var_01;
}

//Function Number: 21
func_8236(param_00)
{
	var_01 = scripts\cp\_utility::func_7DF7(param_00);
	var_02 = level.var_13CA4[var_01];
	return var_02;
}

//Function Number: 22
func_8237()
{
	var_00 = 2;
	self.var_13CA0 = self getweaponslistprimaries();
	if(self.var_13CA0.size)
	{
		foreach(var_02 in self.var_13CA0)
		{
			var_03 = func_8236(var_02);
			if(var_03 == 0)
			{
				continue;
			}

			if(var_03 < var_00)
			{
				var_00 = var_03;
			}
		}
	}
	else
	{
		var_00 = 0.9;
	}

	var_00 = func_4001(var_00);
	return var_00;
}

//Function Number: 23
func_4001(param_00)
{
	return clamp(param_00,0,1);
}

//Function Number: 24
func_8226()
{
	var_00 = 1000;
	self.var_13CA0 = self getweaponslistprimaries();
	if(self.var_13CA0.size)
	{
		foreach(var_02 in self.var_13CA0)
		{
			var_03 = func_823B(var_02);
			if(var_03 == 0)
			{
				continue;
			}

			if(var_03 < var_00)
			{
				var_00 = var_03;
			}
		}
	}
	else
	{
		var_00 = 8;
	}

	var_00 = func_4003(var_00);
	return var_00;
}

//Function Number: 25
func_823B(param_00)
{
	var_01 = undefined;
	var_02 = scripts\cp\_utility::func_7DF7(param_00);
	var_01 = float(tablelookup(level.var_10E5A,4,var_02,8));
	if(!isdefined(var_01) || var_01 < 1)
	{
		var_01 = float(tablelookup(level.var_7666,4,var_02,8));
	}

	if(!isdefined(var_01) || var_01 < 1)
	{
		var_01 = 10;
	}

	return var_01;
}

//Function Number: 26
func_4003(param_00)
{
	return clamp(param_00,0,11);
}

//Function Number: 27
func_EBA1(param_00)
{
	var_01 = func_3D8F();
	if(var_01 != 1)
	{
		var_02 = function_0249(param_00);
		self setweaponammostock(param_00,int(var_02 * var_01));
	}
}

//Function Number: 28
func_3D8F()
{
	return lib_0CFF::func_D876();
}

//Function Number: 29
func_1358A(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(0.5);
	if(!self hasweapon(param_00))
	{
		param_00 = self getweaponslistprimaries()[0];
	}

	self method_833B(param_00);
}

//Function Number: 30
func_958F()
{
	level.var_CA60 = [];
	level.var_EF86 = [];
	level.var_CA66 = [];
	level.var_EF86["specialty_falldamage"] = 1;
	level.var_EF86["specialty_armorpiercing"] = 1;
	level.var_EF86["specialty_gung_ho"] = 1;
	level.var_EF86["specialty_momentum"] = 1;
	level.var_CA60["specialty_momentum"] = ::func_F7A4;
	level.var_CA66["specialty_momentum"] = ::func_12CF2;
	level.var_CA60["specialty_falldamage"] = ::func_F719;
	level.var_CA66["specialty_falldamage"] = ::func_12CC1;
}

//Function Number: 31
func_F7A4()
{
	thread func_E863();
}

//Function Number: 32
func_E863()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_unset");
	for(;;)
	{
		if(self method_81BD())
		{
			func_848B();
			self.var_BCF6 = 1;
			func_12ED5();
		}

		wait(0.1);
	}
}

//Function Number: 33
func_848B()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_reset");
	self endon("momentum_unset");
	thread func_B944();
	thread func_B943();
	var_00 = 0;
	while(var_00 < 0.08)
	{
		self.var_BCF6 = self.var_BCF6 + 0.01;
		func_12ED5();
		wait(0.4375);
		var_00 = var_00 + 0.01;
	}

	self playlocalsound("ftl_phase_in");
	self notify("momentum_max_speed");
	thread momentum_endaftermax();
	self waittill("momentum_reset");
}

//Function Number: 34
momentum_endaftermax()
{
	self endon("momentum_unset");
	self waittill("momentum_reset");
	self playlocalsound("ftl_phase_out");
}

//Function Number: 35
func_B944()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_unset");
	for(;;)
	{
		if(!self method_81BD() || self method_81BE() || !self isonground() || self method_8446())
		{
			wait(0.25);
			if(!self method_81BD() || self method_81BE() || !self isonground() || self method_8446())
			{
				self notify("momentum_reset");
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 36
func_B943()
{
	self endon("death");
	self endon("disconnect");
	self waittill("damage");
	self notify("momentum_reset");
}

//Function Number: 37
func_12CF2()
{
	self notify("momentum_unset");
}

//Function Number: 38
func_F719()
{
}

//Function Number: 39
func_12CC1()
{
}

//Function Number: 40
func_F53D()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("force_bleed_out");
	self endon("last_stand");
	self endon("death");
	self endon("revive_success");
	if(game["state"] != "postgame")
	{
		wait(0.1);
		var_00 = 1;
		var_01 = 2;
		var_02 = 4;
		var_03 = 8;
		var_04 = 16;
		var_05 = 32;
		var_06 = 64;
		var_07 = 0;
		var_08 = undefined;
		var_09 = undefined;
		var_0A = undefined;
		var_0B = 0;
		var_0C = undefined;
		var_0D = 400;
		var_0E = 1000;
		var_0F = 1500;
		var_10 = func_7AA8(self);
		var_0B = var_02;
		if(isdefined(level.player_suit))
		{
			self method_845A(level.player_suit);
		}
		else
		{
			self method_845A("zom_suit");
		}

		self.var_111BC = "zom_suit";
		self method_8422(0);
		self allowslide(var_0B & var_02);
		self method_8424(0);
		self method_8412(0);
		if(isdefined(var_08) && isdefined(var_09))
		{
			self method_8426(var_07);
			self method_8425(var_07);
			self method_8454(3);
		}
		else
		{
			self method_8426(var_07);
			self method_8425(var_07);
			self method_8454(3);
		}

		thread scripts\cp\powers\coop_powers::func_41D0();
		if(isdefined(var_10))
		{
			thread scripts\cp\powers\coop_powers::func_8397(var_10,"primary",undefined,undefined,undefined,0,1);
		}

		func_116E(var_0B & var_03);
		self method_842E(0,var_0D);
		self method_842C(0,var_0D);
		self method_8434(0,var_0E);
		self method_8430(0,var_0F);
		if(isdefined(var_0C))
		{
			self [[ var_0C ]]();
		}
	}

	self method_8472(0);
	if(!scripts\cp\_utility::func_9BA0("grenade_cooldown"))
	{
		scripts\cp\powers\coop_powers::func_D740(0);
	}

	scripts\cp\_utility::func_8387("specialty_throwback");
	self notify("set_player_perks");
}

//Function Number: 41
func_7AA8(param_00)
{
	return "power_frag";
}

//Function Number: 42
func_23C6()
{
	self.var_4004 = "none";
}

//Function Number: 43
func_116E(param_00)
{
	if(param_00)
	{
		thread lib_0CFD::func_F65B();
		return;
	}

	self notify("battleSlide_unset");
}

//Function Number: 44
register_player_character(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10)
{
	var_11 = spawnstruct();
	var_11.body_model = param_02;
	var_11.view_model = param_03;
	var_11.head_model = param_04;
	var_11.hair_model = param_05;
	var_11.var_134FD = param_06;
	var_11.vo_suffix = param_07;
	var_11.pap_gesture = param_08;
	var_11.revive_gesture = param_09;
	var_11.photo_index = param_0A;
	var_11.var_6BA3 = param_0B;
	var_11.intro_music = param_0C;
	var_11.intro_gesture = param_0D;
	var_11.melee_weapon = param_0E;
	var_11.starting_weapon = param_10;
	var_11.post_setup_func = param_0F;
	level.player_character_info[param_00] = var_11;
	if(param_01 == "yes")
	{
		level.var_26A0[level.var_26A0.size] = param_00;
	}
}

//Function Number: 45
func_D87D()
{
	return func_7B0E("nerf_fragile");
}

//Function Number: 46
func_D878()
{
	return func_7B0E("nerf_move_slower");
}

//Function Number: 47
func_D876()
{
	return func_7B0E("nerf_min_ammo");
}

//Function Number: 48
func_7B0E(param_00)
{
	return self.var_BEE9[param_00];
}