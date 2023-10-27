/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\contractchallenges_coop.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1049 ms
 * Timestamp: 10/27/2023 12:09:10 AM
*******************************************************************/

//Function Number: 1
registercontractchallenges()
{
	level.contractchallenges = [];
	registercontractchallenge("con_test",::contracttestchallenge);
	registercontractchallenge("con_kills",::contractkills);
	registercontractchallenge("con_kills_AR",::contractkills);
	registercontractchallenge("con_kills_LMG",::contractkills);
	registercontractchallenge("con_kills_SG",::contractkills);
	registercontractchallenge("con_kills_Sniper",::contractkills);
	registercontractchallenge("con_kills_SMG",::contractkills);
	registercontractchallenge("con_kills_Pistol",::contractkills);
	registercontractchallenge("con_kills_explosive",::contractkills);
	registercontractchallenge("con_kills_head_zmb",::contractkills);
	registercontractchallenge("con_kills_head_rave",::contractkills);
	registercontractchallenge("con_kills_head_disco",::contractkills);
	registercontractchallenge("con_kills_head_town",::contractkills);
	registercontractchallenge("con_cash_earned_zmb",::contractmoneyearned);
	registercontractchallenge("con_cash_earned_rave",::contractmoneyearned);
	registercontractchallenge("con_cash_earned_disco",::contractmoneyearned);
	registercontractchallenge("con_cash_earned_town",::contractmoneyearned);
	registercontractchallenge("con_kills_golf_rave",::contractkills);
	registercontractchallenge("con_kills_bat_rave",::contractkills);
	registercontractchallenge("con_kills_machete_rave",::contractkills);
	registercontractchallenge("con_kills_axe_rave",::contractkills);
	registercontractchallenge("con_kills_axe_zmb",::contractkills);
	registercontractchallenge("con_kills_cleaver_town",::contractkills);
	registercontractchallenge("con_kills_crowbar_town",::contractkills);
	registercontractchallenge("con_doors",::contractdoors);
	registercontractchallenge("con_kills_dragon_disco",::contractkills);
	registercontractchallenge("con_kills_tiger_disco",::contractkills);
	registercontractchallenge("con_kills_snake_disco",::contractkills);
	registercontractchallenge("con_kills_crane_disco",::contractkills);
	registercontractchallenge("con_consumables_used",::contractconsumables);
	registercontractchallenge("con_reboard_windows",::contractreboard);
	registercontractchallenge("con_kills_clowns_zmb",::contractkills);
	registercontractchallenge("con_kills_sasquatch_rave",::contractkills);
	registercontractchallenge("con_kills_skaters_disco",::contractkills);
	registercontractchallenge("con_kills_crogs_town",::contractkills);
	registercontractchallenge("con_waves",::contractnewwave);
	registercontractchallenge("con_trap_kills_zmb",::contractkills);
	registercontractchallenge("con_trap_kills_rave",::contractkills);
	registercontractchallenge("con_trap_kills_disco",::contractkills);
	registercontractchallenge("con_trap_kills_town",::contractkills);
	registercontractchallenge("con_magic_wheel_uses",::contractmagicwheel);
	registercontractchallenge("con_hoff_spawn",::contracthoffspawn);
	registercontractchallenge("con_elvira_spawn",::contractelviraspawned);
	registercontractchallenge("con_cash_spent_zmb",::contractmoneyspent);
	registercontractchallenge("con_cash_spent_rave",::contractmoneyspent);
	registercontractchallenge("con_cash_spent_disco",::contractmoneyspent);
	registercontractchallenge("con_cash_spent_town",::contractmoneyspent);
	registercontractchallenge("con_challenge_badge_rave",::contractchallengebadges);
	registercontractchallenge("con_crafted_kills_town",::contractkills);
	registercontractchallenge("con_coaster_targets_zmb",::contractcoastertargets);
	registercontractchallenge("con_shooting_gallery_zmb",::contractshootinggallery);
	registercontractchallenge("con_spend_tickets",::contractspendtickets);
	registercontractchallenge("con_kills_head_final",::contractkills);
	registercontractchallenge("con_trap_kills_final",::contractkills);
	registercontractchallenge("con_entangler_kills_final",::contractkills);
	registercontractchallenge("con_venomx_kills_final",::contractkills);
	registercontractchallenge("con_goon_kills_final",::contractkills);
	registercontractchallenge("con_phantom_kills_final",::contractkills);
	registercontractchallenge("con_special_kills_final",::contractkills);
	registercontractchallenge("con_cash_earned_final",::contractmoneyearned);
	registercontractchallenge("con_cash_spent_final",::contractmoneyspent);
}

//Function Number: 2
registercontractchallenge(param_00,param_01)
{
	level.contractchallenges[param_00] = param_01;
}

//Function Number: 3
contractempty(param_00)
{
}

//Function Number: 4
contracttestchallenge(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		wait(1);
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 5
contractkills(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("kill_event_buffered",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		var_0A = 0;
		var_0B = scripts\cp\_utility::func_821F(var_05);
		var_0C = getdvar("ui_mapname");
		var_0D = scripts\common\utility::func_9D74(var_04);
		var_0E = isdefined(var_05) && var_05 == "iw7_dischorddummy_zm" || var_05 == "iw7_facemelterdummy_zm" || var_05 == "iw7_headcutterdummy_zm" || var_05 == "iw7_shredderdummy_zm";
		var_0F = issubstr(var_05,"venomx");
		var_10 = issubstr(var_05,"longshot");
		var_11 = issubstr(var_05,"m8");
		var_12 = var_0D && scripts\cp\_utility::func_9E27(var_05,var_07,var_04,var_02) && !var_0F;
		if(isdefined(var_01.var_222))
		{
			var_13 = var_02 scripts\cp\_utility::func_9CEB(var_01,var_05) && var_01.var_222 == var_02;
		}
		else
		{
			var_13 = var_02 scripts\cp\_utility::func_9CEB(var_01,var_05);
		}

		var_14 = function_0107(var_04);
		if(var_14)
		{
			if(issubstr(var_05,"shuriken"))
			{
				var_14 = 0;
			}
			else if(scripts\common\utility::istrue(var_02.kung_fu_mode))
			{
				var_14 = 0;
			}
		}

		switch(param_00.var_DE3F)
		{
			case "con_kills":
				var_0A = 1;
				break;
	
			case "con_kills_head_zmb":
				if(scripts\common\utility::istrue(var_12) && var_0C == "cp_zmb")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_head_rave":
				if(scripts\common\utility::istrue(var_12) && var_0C == "cp_rave")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_head_disco":
				if(scripts\common\utility::istrue(var_12) && var_0C == "cp_disco")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_head_town":
				if(scripts\common\utility::istrue(var_12) && var_0C == "cp_town")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_head_final":
				if(scripts\common\utility::istrue(var_12) && var_0C == "cp_final")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_AR":
				if(var_04 != "MOD_MELEE" && var_0B == "weapon_assault")
				{
					var_0A = 1;
				}
				else if(var_04 != "MOD_MELEE" && var_0B == "weapon_sniper" && var_11 && !lib_0CBC::checkaltmodestatus(var_05))
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_LMG":
				if(var_04 != "MOD_MELEE" && var_0B == "weapon_lmg")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_SG":
				if(var_04 != "MOD_MELEE" && var_0B == "weapon_shotgun" && !var_10)
				{
					var_0A = 1;
				}
				else if(var_04 != "MOD_MELEE" && var_0B == "weapon_sniper" && var_10 && !lib_0CBC::checkaltmodestatus(var_05))
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_Sniper":
				if(var_04 != "MOD_MELEE" && var_0B == "weapon_sniper" && !var_10 && !var_11)
				{
					var_0A = 1;
				}
				else if(var_04 != "MOD_MELEE" && var_0B == "weapon_sniper" && var_10 && lib_0CBC::checkaltmodestatus(var_05))
				{
					var_0A = 1;
				}
				else if(var_04 != "MOD_MELEE" && var_0B == "weapon_sniper" && var_11 && lib_0CBC::checkaltmodestatus(var_05))
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_SMG":
				if(var_04 != "MOD_MELEE" && var_0B == "weapon_smg")
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_Pistol":
				if(var_04 != "MOD_MELEE" && var_0B == "weapon_pistol")
				{
					var_0A = 1;
				}
				else if(var_0E)
				{
					var_0A = 1;
				}
				break;
	
			case "con_kills_explosive":
				var_0A = var_14;
				break;
	
			case "con_kills_golf_rave":
				if(var_0C == "cp_rave")
				{
					if(var_05 == "iw7_golf_club_mp" || var_05 == "iw7_golf_club_mp_pap1" || var_05 == "iw7_golf_club_mp_pap2")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_bat_rave":
				if(var_0C == "cp_rave")
				{
					if(var_05 == "iw7_spiked_bat_mp" || var_05 == "iw7_spiked_bat_mp_pap1" || var_05 == "iw7_spiked_bat_mp_pap2")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_axe_rave":
				if(var_0C == "cp_rave")
				{
					if(var_05 == "iw7_two_headed_axe_mp" || var_05 == "iw7_two_headed_axe_mp_pap1" || var_05 == "iw7_two_headed_axe_mp_pap2")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_machete_rave":
				if(var_0C == "cp_rave")
				{
					if(var_05 == "iw7_machete_mp" || var_05 == "iw7_machete_mp_pap1" || var_05 == "iw7_machete_mp_pap2")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_cleaver_town":
				if(var_0C == "cp_town")
				{
					if(var_05 == "iw7_knife_zm_cleaver")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_crowbar_town":
				if(var_0C == "cp_town")
				{
					if(var_05 == "iw7_knife_zm_crowbar")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_axe_zmb":
				if(var_0C == "cp_zmb")
				{
					if(var_05 == "iw7_axe_zm" || getweaponbasename(var_05) == "iw7_axe_zm_pap1" || getweaponbasename(var_05) == "iw7_axe_zm_pap2")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_entangler_kills_final":
				if(var_0C == "cp_final")
				{
					if(isdefined(var_05) && var_05 == "iw7_entangler2_zm" || var_05 == "ghost_grenade_launcher")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_venomx_kills_final":
				if(var_0C == "cp_final")
				{
					if(var_0F)
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_dragon_disco":
				if(var_0C == "cp_disco")
				{
					if(scripts\common\utility::istrue(var_02.kung_fu_mode) && !scripts\cp\_merits::is_crafted_trap_damage(var_05))
					{
						if(var_02.kungfu_style == "dragon")
						{
							var_0A = 1;
						}
					}
				}
				break;
	
			case "con_kills_tiger_disco":
				if(var_0C == "cp_disco")
				{
					if(scripts\common\utility::istrue(var_02.kung_fu_mode) && !scripts\cp\_merits::is_crafted_trap_damage(var_05))
					{
						if(var_02.kungfu_style == "tiger")
						{
							var_0A = 1;
						}
					}
				}
				break;
	
			case "con_kills_snake_disco":
				if(var_0C == "cp_disco")
				{
					if(scripts\common\utility::istrue(var_02.kung_fu_mode) && !scripts\cp\_merits::is_crafted_trap_damage(var_05))
					{
						if(var_02.kungfu_style == "snake")
						{
							var_0A = 1;
						}
					}
				}
				break;
	
			case "con_kills_crane_disco":
				if(var_0C == "cp_disco")
				{
					if(scripts\common\utility::istrue(var_02.kung_fu_mode) && !scripts\cp\_merits::is_crafted_trap_damage(var_05))
					{
						if(var_02.kungfu_style == "crane")
						{
							var_0A = 1;
						}
					}
				}
				break;
	
			case "con_kills_clowns_zmb":
				if(var_0C == "cp_zmb")
				{
					if(isdefined(var_09) && var_09 == "zombie_clown")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_sasquatch_rave":
				if(var_0C == "cp_rave")
				{
					if(isdefined(var_09) && var_09 == "zombie_sasquatch")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_skaters_disco":
				if(var_0C == "cp_disco")
				{
					if(isdefined(var_09) && var_09 == "skater")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_kills_crogs_town":
				if(var_0C == "cp_town")
				{
					if(isdefined(var_09) && var_09 == "crab_mini")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_special_kills_final":
				if(var_0C == "cp_final")
				{
					if(isdefined(var_09) && var_09 == "karatemaster" || var_09 == "zombie_clown" || var_09 == "slasher")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_goon_kills_final":
				if(var_0C == "cp_final")
				{
					if(isdefined(var_09) && var_09 == "alien_goon")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_phantom_kills_final":
				if(var_0C == "cp_final")
				{
					if(isdefined(var_09) && var_09 == "alien_phantom")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_trap_kills_zmb":
				if(var_0C == "cp_zmb")
				{
					if(scripts\common\utility::istrue(var_13))
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_trap_kills_rave":
				if(var_0C == "cp_rave")
				{
					if(scripts\common\utility::istrue(var_13))
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_trap_kills_disco":
				if(var_0C == "cp_disco")
				{
					if(scripts\common\utility::istrue(var_13))
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_trap_kills_town":
				if(var_0C == "cp_town")
				{
					if(var_05 == "iw7_electrictrap_zm")
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_trap_kills_final":
				if(var_0C == "cp_final")
				{
					if(scripts\common\utility::istrue(var_13))
					{
						var_0A = 1;
					}
				}
				break;
	
			case "con_crafted_kills_town":
				if(var_0C == "cp_town")
				{
					if(isdefined(var_02.var_20) && var_02.var_20 == "allies")
					{
						var_0A = 1;
					}
		
					if(var_05 == "iw7_fantrap_zm")
					{
						var_0A = 1;
					}
				}
				break;
		}

		if(var_0A)
		{
			scripts\cp\contracts_coop::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 6
contractmoneyearned(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("currency_earned_buffered",var_01);
		var_02 = getdvar("ui_mapname");
		var_03 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_cash_earned_zmb":
				if(var_02 == "cp_zmb")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_earned_rave":
				if(var_02 == "cp_rave")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_earned_disco":
				if(var_02 == "cp_disco")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_earned_town":
				if(var_02 == "cp_town")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_earned_final":
				if(var_02 == "cp_final")
				{
					var_03 = 1;
				}
				break;
		}

		if(var_03)
		{
			scripts\cp\contracts_coop::updatecontractprogress(param_00,var_01);
		}
	}
}

//Function Number: 7
contractdoors(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("door_opened_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 8
contractconsumables(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("consumable_selected");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 9
contractreboard(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("window_reboard_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 10
contractnewwave(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("next_wave_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 11
contractmagicwheel(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("magic_wheel_used");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 12
contracthoffspawn(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("hoff_spawned");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 13
contractelviraspawned(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("elvira_summoned_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 14
contractmoneyspent(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("currency_spent_buffered",var_01);
		var_02 = getdvar("ui_mapname");
		var_03 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_cash_spent_zmb":
				if(var_02 == "cp_zmb")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_spent_rave":
				if(var_02 == "cp_rave")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_spent_disco":
				if(var_02 == "cp_disco")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_spent_town":
				if(var_02 == "cp_town")
				{
					var_03 = 1;
				}
				break;
	
			case "con_cash_spent_final":
				if(var_02 == "cp_final")
				{
					var_03 = 1;
				}
				break;
		}

		if(var_03)
		{
			scripts\cp\contracts_coop::updatecontractprogress(param_00,var_01);
		}
	}
}

//Function Number: 15
contractchallengebadges(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("rave_challenge_badge_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 16
contractcraftedkills(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("crafted_kill_town_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 17
contractcoastertargets(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("coaster_target_hit_notify");
		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 18
contractshootinggallery(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("moving_target_hit_notify");
		if(scripts\common\utility::istrue(self.in_afterlife_arcade))
		{
			continue;
		}

		scripts\cp\contracts_coop::updatecontractprogress(param_00);
	}
}

//Function Number: 19
contractspendtickets(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("spent_tickets_notify",var_01);
		scripts\cp\contracts_coop::updatecontractprogress(param_00,var_01);
	}
}

//Function Number: 20
contractkillsrapid(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("update_rapid_kill_buffered",var_01);
		var_02 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_kills_double":
				if(var_01 % 2 == 0)
				{
					var_02 = 1;
				}
				break;
		}

		if(var_02)
		{
			scripts\cp\contracts_coop::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 21
contractnotifylistener(param_00,param_01)
{
	self waittill(param_00,var_02);
	self notify(param_01,var_02);
}