/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3372.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 20 ms
 * Timestamp: 10/27/2023 12:26:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_138A1 = [];
	level.var_B15E = [];
	level.var_1BED = [];
	level.var_47AD = [];
	level.var_C8A2 = [];
	level.var_138CB = [];
	func_C906();
	var_00 = spawnstruct();
	var_00.var_DB01 = "tickets";
	var_00.model = "zmb_lethal_cryo_grenade_wm";
	var_00.var_39C = "zfreeze_semtex_mp";
	level.var_138A1["zfreeze_semtex_mp"] = var_00;
	scripts\common\utility::flag_init("wall_buy_setup_done");
}

//Function Number: 2
func_48CD(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	param_00 = int(param_00);
	var_05.var_394 = param_01;
	if(param_04 != "")
	{
		var_05.var_EC13 = param_04;
	}

	var_05.model = function_00EA(param_01);
	var_05.var_DB01 = param_03;
	level.var_138A1[param_02] = var_05;
}

//Function Number: 3
func_C906()
{
	var_00 = 0;
	if(isdefined(level.coop_weapontable))
	{
		var_01 = level.coop_weapontable;
	}
	else
	{
		var_01 = "cp/cp_weapontable.csv";
	}

	for(;;)
	{
		var_02 = tablelookupbyrow(var_01,var_00,0);
		if(var_02 == "")
		{
			break;
		}

		var_03 = tablelookupbyrow(var_01,var_00,1);
		var_04 = tablelookupbyrow(var_01,var_00,2);
		var_05 = tablelookupbyrow(var_01,var_00,4);
		var_06 = tablelookupbyrow(var_01,var_00,5);
		var_07 = scripts\cp\_utility::func_80D8(var_03);
		var_08 = strtok(var_04," ");
		foreach(var_0A in var_08)
		{
			switch(var_0A)
			{
				case "craft":
					level.var_47AD[var_07] = var_03;
					break;
	
				case "magic":
					level.var_B15E[var_07] = getweaponbasename(var_03);
					level.var_1BED[var_07] = var_03;
					break;
	
				case "upgrade":
					level.var_C8A2[var_07] = var_03;
					break;
	
				case "wall":
				case "tickets":
					func_48CD(var_02,var_03,var_07,var_0A,var_06);
					break;
			}
		}

		var_00++;
	}
}

//Function Number: 4
func_FA1D(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = 0;
	var_02 = 1;
	var_03 = 2;
	var_04 = 3;
	var_05 = 6;
	param_00.var_13C00 = [];
	param_00.var_E603 = [];
	param_00.var_13C38 = [];
	if(scripts\cp\_utility::map_check(2))
	{
		var_06 = "cp/cp_disco_wall_buy_models.csv";
	}
	else if(scripts\cp\_utility::map_check(3))
	{
		var_06 = "cp/cp_town_wall_buy_models.csv";
	}
	else if(scripts\cp\_utility::map_check(4))
	{
		var_06 = "cp/cp_final_wall_buy_models.csv";
	}
	else
	{
		var_06 = "cp/cp_wall_buy_models.csv";
	}

	var_07 = 0;
	for(;;)
	{
		var_08 = tablelookupbyrow(var_06,var_07,var_02);
		if(var_08 == "")
		{
			break;
		}

		var_09 = "none";
		var_0A = "none";
		var_0B = "none";
		var_0C = -1;
		if(isdefined(var_08))
		{
			var_0D = tablelookup(var_06,var_01,var_07,var_03);
			var_0E = tablelookup(var_06,var_01,var_07,var_04);
			var_0F = [];
			if(isdefined(var_0D) && var_0D != "")
			{
				var_10 = scripts\cp\_relics::func_7D6C(param_00,var_0D);
				if(var_10.size > 0)
				{
					param_00.var_13C38[var_0D] = var_10;
				}

				for(var_11 = 0;var_11 < var_05;var_11++)
				{
					var_12 = param_00 getplayerdata("cp","zombiePlayerLoadout","zombiePlayerWeaponModels",var_0D,"attachment",var_11);
					if(isdefined(var_12) && var_12 != "none")
					{
						var_0F[var_0F.size] = var_12;
					}
				}

				var_09 = scripts\cp\_utility::getweaponcamo(var_0D);
				var_0A = scripts\cp\_utility::getweaponcosmeticattachment(var_0D);
				var_0B = scripts\cp\_utility::getweaponreticle(var_0D);
				var_0C = scripts\cp\_utility::getweaponpaintjobid(var_0D);
			}

			param_00.var_13C00[var_08] = scripts\cp\_utility::func_BD68(scripts\cp\_utility::func_8234(var_0E),var_0F,var_09,var_0B,scripts\cp\_utility::func_7D72(param_00,var_0E),self getentitynumber(),self.var_41F0,var_0C,var_0A);
			if(var_08 == "g18")
			{
				param_00 loadweaponsforplayer([param_00.var_13C00[var_08]],1);
			}

			var_13 = function_00E3(param_00.var_13C00[var_08]);
			foreach(var_12 in var_13)
			{
				if(issubstr(var_12,"rof"))
				{
					param_00.var_E603[param_00.var_E603.size] = getweaponbasename(param_00.var_13C00[var_08]);
				}
			}
		}

		var_07++;
	}

	param_00.weaponkitinitialized = 1;
	param_00 notify("player_weapon_build_kit_initialized");
}

//Function Number: 5
func_23DA()
{
	if(scripts\cp\_utility::map_check(2))
	{
		var_00 = "cp/cp_disco_wall_buy_models.csv";
	}
	else if(scripts\cp\_utility::map_check(3))
	{
		var_00 = "cp/cp_town_wall_buy_models.csv";
	}
	else if(scripts\cp\_utility::map_check(4))
	{
		var_00 = "cp/cp_final_wall_buy_models.csv";
	}
	else
	{
		var_00 = "cp/cp_wall_buy_models.csv";
	}

	if(!scripts\common\utility::func_6E34("wall_buy_setup_done"))
	{
		scripts\common\utility::flag_init("wall_buy_setup_done");
	}

	var_01 = [];
	var_02 = 0;
	for(;;)
	{
		var_03 = tablelookupbyrow(var_00,var_02,1);
		if(var_03 == "")
		{
			break;
		}

		var_01[var_01.size] = var_03;
		var_02++;
	}

	var_04 = [];
	var_05 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_07 in var_05)
	{
		if(isdefined(var_07.name) && var_07.name == "wall_buy")
		{
			var_04[var_04.size] = var_07;
			if(isdefined(var_07.target))
			{
				if(scripts\common\utility::istrue(var_07.var_1D3F))
				{
					continue;
				}

				var_08 = scripts\common\utility::getstructarray(var_07.target,"target");
				foreach(var_0A in var_08)
				{
					if(var_0A == var_07)
					{
						continue;
					}

					var_0A.var_1D3F = 1;
					var_0A.parent_struct = var_07;
				}
			}
		}
	}

	while(level.players.size < 1)
	{
		wait(0.05);
	}

	var_0D = sortbydistance(var_04,level.players[0].origin);
	foreach(var_0F in var_0D)
	{
		var_0F.script_noteworthy = strtok(var_0F.script_noteworthy,"+")[0];
		var_10 = var_0F.script_noteworthy;
		var_11 = scripts\cp\_utility::func_80D8(var_0F.script_noteworthy);
		var_12 = undefined;
		if(!isdefined(level.var_138A1[var_11]))
		{
			var_0F.var_55BA = 1;
			continue;
		}

		if(!scripts\common\utility::istrue(var_0F.var_1D3F))
		{
			if(isdefined(var_0F.target))
			{
				var_13 = scripts\common\utility::getstruct(var_0F.target,"targetname");
				var_14 = var_13.origin;
				var_15 = var_13.angles;
			}
			else
			{
				var_14 = var_11.origin;
				var_15 = var_10.angles;
			}

			for(var_02 = 0;var_02 < var_01.size;var_02++)
			{
				if(var_01[var_02] == var_11)
				{
					var_12 = var_02;
					break;
				}
			}

			if(isdefined(var_12))
			{
				var_0F.trigger = spawn("script_weapon",var_14,0,0,var_12);
			}
			else
			{
				var_16 = (0,0,0);
				var_17 = (0,0,0);
				if(issubstr(var_0F.script_noteworthy,"forgefreeze"))
				{
					var_16 = (3.25,-18,9.75);
					var_17 = (0,0,-90);
				}

				if(isdefined(var_15))
				{
					var_15 = var_15 + var_17;
				}

				var_0F.trigger = spawn("script_model",var_14 + var_16);
				if(isdefined(var_10))
				{
					var_0F.trigger setmodel(level.var_138A1[var_11].model);
				}
				else
				{
					var_0F.trigger setmodel("tag_origin");
				}
			}

			if(isdefined(var_15))
			{
				var_0F.trigger.angles = var_15;
			}

			var_0F.trigger thread func_16F5(var_0F,var_0F.trigger,var_10,var_11);
			level.var_138CB[level.var_138CB.size] = var_0F.trigger;
		}
		else if(isdefined(var_0F.parent_struct.trigger))
		{
			var_0F.trigger = var_0F.parent_struct.trigger;
		}
		else
		{
			var_0F thread applyparentstructvalues(var_0F);
		}

		var_0F.var_394 = var_10;
	}

	scripts\common\utility::flag_set("wall_buy_setup_done");
}

//Function Number: 6
applyparentstructvalues(param_00)
{
	level endon("game_ended");
	while(!isdefined(param_00.parent_struct.trigger))
	{
		scripts\common\utility::func_136F7();
	}

	param_00.trigger = param_00.parent_struct.trigger;
}

//Function Number: 7
func_16F5(param_00,param_01,param_02,param_03)
{
	if(!scripts\common\utility::flag("init_interaction_done"))
	{
		scripts\common\utility::flag_wait("init_interaction_done");
	}

	param_01.cost = level.interactions[param_02].cost;
	param_01.struct = param_00;
	if(isdefined(param_03) && issubstr(param_03,"harpoon") || issubstr(param_03,"slasher") || issubstr(param_03,"katana"))
	{
		return;
	}

	if(param_00.var_EE79 != "tickets")
	{
		level.var_C785[level.var_C785.size] = param_01;
	}
}

//Function Number: 8
func_A02D(param_00)
{
	param_00 func_834A(self);
}

//Function Number: 9
givevalidweapon(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("game_ended");
	param_00 endon("disconnect");
	param_00 notify("weapon_purchased");
	if(scripts\common\utility::istrue(param_00.var_9FCB))
	{
		wait(0.5);
	}

	var_02 = undefined;
	if(scripts\cp\zombies\zmb_zombies_weapons::func_FFA6(param_00))
	{
		var_03 = param_00 scripts\cp\_utility::getvalidtakeweapon();
		var_04 = scripts\cp\_utility::func_80D8(var_03);
		param_00 takeweapon(var_03);
		if(isdefined(param_00.var_C8A2[var_04]))
		{
			param_00.var_C8A2[var_04] = undefined;
			param_00 notify("weapon_level_changed");
		}
	}

	var_05 = scripts\cp\_utility::func_80D8(param_01);
	param_00 scripts\cp\_utility::take_fists_weapon(param_00);
	if(isdefined(param_00.var_13C00[var_05]))
	{
		param_01 = param_00.var_13C00[var_05];
	}

	var_06 = function_00E3(param_01);
	param_01 = param_00 scripts\cp\_weapon::func_E469(param_01,undefined,var_06,undefined,undefined);
	param_01 = param_00 scripts\cp\_utility::func_12C6(param_01,undefined,undefined,0);
	var_07 = spawnstruct();
	var_07.var_B111 = 1;
	param_00.var_C8A2[var_05] = var_07;
	param_00 scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
	param_00 notify("weapon_level_changed");
	param_00 givemaxammo(param_01);
	param_00 switchtoweapon(param_01);
}

//Function Number: 10
func_834A(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	var_03 = param_00.trigger.cost;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = self getweaponslistprimaries();
	var_08 = self getweaponslistprimaries().size;
	var_09 = 3;
	var_0A = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
	if(param_00.script_noteworthy == "iw7_forgefreeze_zm")
	{
		level.var_B15E["forgefreeze"] = "iw7_forgefreeze_zm+forgefreezealtfire";
		var_01 = 1;
	}

	if(param_00.script_noteworthy == "iw7_venomx_zm")
	{
		level.var_B15E["venomx"] = "iw7_venomx_zm";
		if(isdefined(level.venomx_count) && level.venomx_count >= level.players.size)
		{
			var_01 = 1;
		}
	}

	if(scripts\cp\_utility::weapon_is_dlc_melee(param_00.script_noteworthy))
	{
		var_01 = 1;
	}

	if(!scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
	{
		var_0B = scripts\cp\_utility::getvalidtakeweapon();
		self.var_4B32 = var_0B;
		if(isdefined(var_0B))
		{
			var_02 = 1;
			var_0C = scripts\cp\_utility::func_80D8(var_0B);
			if(scripts\cp\_utility::func_8BAE() && var_08 < var_09 + 1)
			{
				var_02 = 0;
			}

			foreach(var_0E in var_07)
			{
				if(scripts\cp\_utility::isstrstart(var_0E,"alt_"))
				{
					var_09++;
				}
			}

			if(scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
			{
				var_09++;
			}

			if(var_07.size < var_09)
			{
				var_02 = 0;
			}

			if(var_02)
			{
				if(isdefined(self.var_C8A2[var_0C]))
				{
					self.var_C8A2[var_0C] = undefined;
					self notify("weapon_level_changed");
				}

				thread scripts\cp\_interaction::func_CE96(param_00,self);
				self takeweapon(var_0B);
			}
		}

		if(isdefined(self.var_13C00[var_0A]))
		{
			var_04 = self.var_13C00[var_0A];
		}
		else
		{
			var_04 = param_00.var_394;
		}

		if(scripts\cp\_utility::func_9BA0("wall_power"))
		{
			var_10 = scripts\common\utility::array_combine(function_00E3(var_04),["pap1"]);
			if(issubstr(var_04,"venomx"))
			{
				var_10 = undefined;
				var_06 = undefined;
				if(scripts\common\utility::istrue(level.completed_venomx_pap1_challenges))
				{
					var_04 = "iw7_venomx_zm_pap1";
					var_06 = level.pap_1_camo;
				}
			}
			else
			{
				if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,var_0A))
				{
					var_06 = undefined;
				}
				else if(isdefined(level.pap_1_camo))
				{
					var_06 = level.pap_1_camo;
				}

				switch(var_0A)
				{
					case "dischord":
						var_06 = "camo20";
						break;

					case "facemelter":
						var_06 = "camo22";
						break;

					case "headcutter":
						var_06 = "camo21";
						break;

					case "shredder":
						var_06 = "camo23";
						break;
				}
			}

			var_11 = scripts\cp\_weapon::func_E469(var_04,undefined,var_10,undefined,var_06);
			var_11 = scripts\cp\_utility::func_12C6(var_11,undefined,undefined,1);
			var_12 = scripts\cp\_utility::func_80D8(var_11);
			scripts\cp\_merits::func_D9AD("mt_upgrade_weapons");
			var_13 = spawnstruct();
			var_13.var_B111 = 2;
			self.var_C8A2[var_12] = var_13;
			if(!scripts\common\utility::istrue(level.completed_venomx_pap1_challenges) && issubstr(var_04,"venomx"))
			{
				scripts\cp\_utility::take_fists_weapon(self);
				self notify("wor_item_pickup",var_11);
				scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
				self givemaxammo(var_11);
				self notify("weapon_level_changed");
				self switchtoweapon(var_11);
				wait(0.25);
				while(self method_81C2())
				{
					wait(0.05);
				}

				self notify("weapon_purchased");
				wait(0.05);
				self.var_DB02 = undefined;
				scripts\cp\_interaction::func_DE6E();
				return;
			}

			scripts\cp\_utility::func_C151("wall_power");
			scripts\cp\_utility::take_fists_weapon(self);
		}
		else
		{
			var_10 = function_00E3(var_07);
			var_11 = scripts\cp\_weapon::func_E469(var_06,undefined,var_13);
			var_13 = scripts\cp\_utility::func_12C6(var_13,undefined,undefined,1);
			self.var_A035 = var_13;
			level.var_12631 = randomint(100);
			scripts\cp\zombies\zombie_analytics::func_AF86(1,self,self.var_A035,self.var_4B32,level.wave_num,var_01.name,self.var_13BE3,self.var_A682,self.var_5AFC);
			scripts\cp\_utility::take_fists_weapon(self);
			var_13 = spawnstruct();
			var_13.var_B111 = 1;
			self.var_C8A2[var_0A] = var_13;
		}

		if(var_01)
		{
			param_00.trigger delete();
			scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		}

		self notify("wor_item_pickup",var_11);
		scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
		self givemaxammo(var_11);
		self notify("weapon_level_changed");
		self switchtoweapon(var_11);
		wait(0.25);
		while(self method_81C2())
		{
			wait(0.05);
		}
	}
	else
	{
		self.var_DB02 = 1;
		var_0A = undefined;
		var_14 = self getweaponslistall();
		var_15 = self getcurrentweapon();
		var_16 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
		var_17 = undefined;
		foreach(var_19 in var_14)
		{
			var_0A = scripts\cp\_utility::func_80D8(var_19);
			if(var_0A == var_16)
			{
				var_17 = var_19;
				break;
			}
		}

		var_1B = function_0249(var_17);
		var_1C = lib_0CFF::func_D876();
		var_1D = int(var_1C * var_1B);
		var_1E = self getweaponammostock(var_17);
		if(var_1E < var_1D)
		{
			self setweaponammostock(var_17,var_1D);
		}

		if(self hasweapon("alt_" + var_17))
		{
			var_1B = function_0249("alt_" + var_17);
			var_1C = lib_0CFF::func_D876();
			var_1D = int(var_1C * var_1B);
			var_1E = self getweaponammostock("alt_" + var_17);
			if(var_1E < var_1D)
			{
				self setweaponammostock("alt_" + var_17,var_1D);
			}
		}

		thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,1,50);
	}

	self notify("weapon_purchased");
	wait(0.05);
	self.var_DB02 = undefined;
	scripts\cp\_interaction::func_DE6E();
}

//Function Number: 11
func_E229(param_00)
{
	if(isdefined(self.var_10936))
	{
		self.var_10936 = undefined;
	}

	if(isdefined(self.var_10939))
	{
		self.var_10939 = undefined;
	}

	if(isdefined(self.var_10938))
	{
		self.var_10938 = undefined;
	}

	if(isdefined(self.var_10937))
	{
		self.var_10937 = undefined;
	}

	if(isdefined(self.var_10935))
	{
		self.var_10935 = undefined;
	}
}

//Function Number: 12
func_82F4()
{
	if(lib_0CFF::func_D87B() == 1)
	{
		var_00 = self getweaponslistprimaries();
		foreach(var_02 in var_00)
		{
			var_03 = scripts\cp\_utility::func_4626(var_02);
			if(var_03 == "weapon_pistol")
			{
				var_04 = function_0249(var_02);
				var_05 = int(var_04 * 0.25);
				var_06 = self method_80FB(var_02);
				if(var_05 > var_06)
				{
					self setweaponammostock(var_02,var_05);
				}
			}
		}
	}
}

//Function Number: 13
func_7D6F(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		var_04 = scripts\cp\_persistence::func_7858(var_03);
		if(issubstr(param_00,var_04))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 14
func_7C04()
{
	var_00 = self getweaponslistprimaries();
	var_01 = 3;
	foreach(var_03 in var_00)
	{
		if(scripts\cp\_utility::isstrstart(var_03,"alt_"))
		{
			var_01++;
		}
	}

	if(scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
	{
		var_01++;
	}

	if(var_00.size >= var_01)
	{
		var_05 = self getcurrentweapon();
		var_06 = 0;
		if(var_05 == "none")
		{
			var_06 = 1;
		}
		else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,var_05))
		{
			var_06 = 1;
		}
		else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,getweaponbasename(var_05)))
		{
			var_06 = 1;
		}
		else if(scripts\cp\_utility::func_9C42(var_05,1))
		{
			var_06 = 1;
		}

		if(var_06)
		{
			self.var_4643 = self getweaponslistall();
			var_05 = scripts\cp\_laststand::func_3E88(level.additional_laststand_weapon_exclusion,1,1);
		}

		self.var_4643 = undefined;
		if(function_0244(var_05) == "altmode")
		{
			var_05 = func_7D66(var_05);
		}

		return var_05;
	}

	return undefined;
}

//Function Number: 15
func_7D66(param_00)
{
	if(function_0244(param_00) != "altmode")
	{
		return param_00;
	}

	return getsubstr(param_00,4);
}

//Function Number: 16
func_381D(param_00)
{
	var_01 = self getweaponslistprimaries();
	var_02 = self getcurrentweapon();
	var_03 = scripts\cp\_utility::func_4626(var_02);
	var_04 = scripts\cp\_utility::func_7DF7(var_02);
	foreach(param_00 in var_01)
	{
		if(scripts\cp\_utility::isstrstart(param_00,"alt_"))
		{
			var_01 = scripts\common\utility::func_22A9(var_01,param_00);
		}
	}

	var_07 = 0;
	if(!scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
	{
		var_08 = 3;
	}
	else
	{
		var_08 = 4;
	}

	if(isdefined(self.var_C20E))
	{
		var_08 = var_08 + self.var_C20E;
	}

	while(self method_81C2())
	{
		wait(0.05);
	}

	if(var_02 == "none")
	{
		return 0;
	}

	if(isdefined(level.var_4C40))
	{
		if(![[ level.var_4C40 ]](var_01,var_02,var_03,var_08))
		{
			return 0;
		}
	}

	if(isdefined(scripts\cp\_utility::func_8BAE()) && scripts\cp\_utility::func_8BAE())
	{
		return 0;
	}

	if(var_01.size >= var_08 + 1 && self.var_8C1E)
	{
		return 0;
	}

	if(var_01.size >= var_08 + 2 && self.var_8C1E)
	{
		return 0;
	}

	if(var_01.size >= var_08 + 1 && !self.var_8C1F)
	{
		return 0;
	}

	if(var_01.size >= var_08 + 2 && self.var_8C1F)
	{
		return 0;
	}

	if(self.var_8C1F && var_01.size >= var_08 + 1)
	{
		return 0;
	}

	if(self.var_8C1F && var_01.size >= var_08 + 1)
	{
		return 0;
	}

	if(!scripts\cp\_utility::func_9C03())
	{
		return 1;
	}
	else
	{
		return 0;
	}

	return 0;
}

//Function Number: 17
func_9A38(param_00,param_01)
{
	if(scripts\cp\_utility::func_9D18())
	{
		return;
	}

	if(issubstr(param_00.script_noteworthy,"venomx"))
	{
		var_02 = param_01 getweaponslistall();
		foreach(var_04 in var_02)
		{
			if(issubstr(var_04,"venomx"))
			{
				return;
			}
		}

		if(scripts\common\utility::func_6E34("completepuzzles_step4") && scripts\common\utility::flag("completepuzzles_step4"))
		{
			var_02 = param_01 getweaponslistall();
			foreach(var_04 in var_02)
			{
				if(issubstr(var_04,"venomx"))
				{
					return;
				}
			}

			param_01 thread scripts\cp\_vo::try_to_play_vo("quest_venx_weapon","final_comment_vo");
			if(!isdefined(level.venomx_count))
			{
				level.venomx_count = 1;
			}

			param_00 func_A02D(param_01);
			param_01.var_A8D3 = undefined;
			param_01 lib_0D2A::func_12D7C("EGG_SLAYER",1);
			scripts\cp\_interaction::func_E01A(param_00,param_01);
			return;
		}

		return;
	}

	var_02 func_A02D(var_03);
	var_03.var_A8D3 = undefined;
}

//Function Number: 18
func_7D50(param_00,param_01)
{
	if(issubstr(param_00.script_noteworthy,"venomx"))
	{
		if(!scripts\common\utility::flag("completepuzzles_step4"))
		{
			return "";
		}

		var_02 = param_01 getweaponslistall();
		foreach(var_04 in var_02)
		{
			if(issubstr(var_04,"venomx"))
			{
				return &"COOP_INTERACTIONS_CANNOT_BUY";
			}
		}
	}

	if(scripts\cp\_utility::func_9D18())
	{
		return &"CP_ZMB_INTERACTIONS_WALL_BUY_DISABLED";
	}

	if(!param_01 func_381D(param_00))
	{
		return &"COOP_INTERACTIONS_CANNOT_BUY";
	}

	var_06 = [[ level.var_13C1B ]](param_00,param_01);
	if(isdefined(var_06))
	{
		return var_06;
	}

	var_07 = getweaponbasename(param_00.script_noteworthy);
	return level.interaction_hintstrings[var_07];
}

//Function Number: 19
func_F617(param_00)
{
	level.var_13C41 = param_00;
}