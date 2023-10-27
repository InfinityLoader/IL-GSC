/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_crafting.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 777 ms
 * Timestamp: 10/27/2023 12:03:48 AM
*******************************************************************/

//Function Number: 1
init_crafting()
{
	level.var_CC0C = [];
	level.crafting_icon_create_func = ::func_4939;
	func_9596("craft_lavalamp",(1,1,1));
	func_9596("craft_boombox",(1,0,0));
	func_9596("craft_turret",(0,1,0));
	func_9596("craft_robot",(0,0,1));
	func_9596("craft_zombgone",(1,1,0));
	var_00 = scripts\common\utility::getstructarray("puzzle","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_4C72 = 96;
		var_02.disable_guided_interactions = 1;
	}
}

//Function Number: 2
is_valid_tile_spot()
{
	var_00 = [(-1803,2629,937),(-1138,3784,782),(-2407.5,3456,494.5),(-1928.5,3815.5,750.5),(-1911,4188.5,742)];
	foreach(var_02 in var_00)
	{
		if(self.origin == var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 3
func_9596(param_00,param_01)
{
	var_02 = scripts\common\utility::getstruct(param_00,"script_noteworthy");
	var_02.var_1157E = getentarray(var_02.target,"targetname");
	foreach(var_04 in var_02.var_1157E)
	{
		if(issubstr(var_04.model,"tile"))
		{
			var_04.ispuzzlepiece = 1;
			var_04.table_pos = var_04.origin;
			var_05 = get_puzzle_piece_location(param_00);
			var_04.origin = var_05.origin;
			var_05.var_195 = var_04;
			if(isdefined(var_05.angles))
			{
				var_04.angles = var_05.angles;
			}

			continue;
		}

		var_02.crafted_item = var_04;
	}

	var_07 = scripts\common\utility::getstructarray("puzzle","script_noteworthy");
	foreach(var_09 in var_07)
	{
		if(var_09.name == param_00 && !scripts\common\utility::istrue(var_09.var_1305B))
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(var_09);
		}
	}

	var_02.remaining_pieces = 3;
	var_02.puzzle_complete = 0;
	level.interactions[param_00].disable_guided_interactions = 1;
}

//Function Number: 4
func_12FBE(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		param_01 playlocalsound("perk_machine_deny");
		return;
	}

	if(!scripts\common\utility::func_2286(level.current_interaction_structs,param_00))
	{
		return;
	}

	if(param_00.remaining_pieces > 0)
	{
		if(!isdefined(param_01.puzzle_piece))
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("missing_item_misc","disco_comment_vo");
			return;
		}

		if(param_01.puzzle_piece != param_00.script_noteworthy)
		{
			param_01 playlocalsound("perk_machine_deny");
			return;
		}

		param_01 playlocalsound("zmb_coin_sounvenir_place");
		param_01 thread scripts\cp\_vo::try_to_play_vo("place_puzzle","disco_comment_vo");
		show_next_piece(param_00);
		param_01 setclientomnvar("zombie_souvenir_piece_index",0);
		param_01.puzzle_piece = undefined;
		param_01.var_A8D3 = undefined;
		param_00.remaining_pieces--;
		param_01 scripts\cp\_merits::func_D9AD("mt_used_crafting");
		if(param_00.remaining_pieces > 0)
		{
			param_01 scripts\cp\_utility::play_interaction_gesture("iw7_souvenircoin_zm");
			return;
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		playfx(level._effect["crafting_souvenir"],param_00.crafted_item.origin);
		wait(2);
		param_00.crafted_item show();
		param_00.scriptable_part_name = param_00.script_noteworthy;
		param_00.crafted_item setscriptablepartstate("active",param_00.scriptable_part_name);
		param_00.puzzle_complete = 1;
		param_00.crafted_item playsound("zmb_coin_appear");
		if(param_01 scripts\cp\_utility::is_valid_player())
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("puzzle_craft_success","zmb_comment_vo","low",10,0,0,0,50);
		}

		scripts\cp\_vo::func_E01F("nag_puzzle");
		switch(param_00.script_noteworthy)
		{
			case "craft_zombgone":
				param_00.script_noteworthy = "purchase_zombgone";
				break;

			case "craft_turret":
				param_00.script_noteworthy = "purchase_turret";
				break;

			case "craft_boombox":
				param_00.script_noteworthy = "purchase_boombox";
				break;

			case "craft_lavalamp":
				param_00.script_noteworthy = "purchase_lavalamp";
				break;

			case "craft_robot":
				param_00.script_noteworthy = "purchase_robot";
				break;
		}

		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
		level.interactions[param_00.script_noteworthy].disable_guided_interactions = 0;
		return;
	}

	param_01 scripts\cp\_utility::play_interaction_gesture();
	param_01.craftables = scripts\common\utility::func_22A9(param_01.craftables,param_00.script_noteworthy);
	param_01 playlocalsound("part_pickup");
	switch(param_00.script_noteworthy)
	{
		case "purchase_zombgone":
			var_02 = ["collect_craft_misc","collect_craft_zombgone"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_02),"disco_comment_vo");
			param_01 thread scripts\cp\powers\coop_powers::func_8397("power_holyWater","secondary",undefined,undefined,undefined,0,0);
			param_00.crafted_item setscriptablepartstate("active","pickup_zbc");
			param_01 notify("new_power","crafted_zombgone");
			break;

		case "purchase_turret":
			param_01 thread scripts\cp\_vo::try_to_play_vo("collect_craft_misc","disco_comment_vo");
			scripts\cp\_weapon_autosentry::func_82BA(param_00,param_01);
			param_00.crafted_item setscriptablepartstate("active","pickup_turret");
			break;

		case "purchase_boombox":
			param_01 thread scripts\cp\_vo::try_to_play_vo("collect_craft_misc","disco_comment_vo");
			scripts\cp\zombies\craftables\_boombox::func_82B4(param_00,param_01);
			param_00.crafted_item setscriptablepartstate("active","pickup_boombox");
			break;

		case "purchase_lavalamp":
			var_02 = ["collect_craft_misc","collect_craft_lava"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_02),"disco_comment_vo");
			scripts\cp\crafted_trap_lavalamp::give_crafted_lavalamp_trap(param_00,param_01);
			param_00.crafted_item setscriptablepartstate("active","pickup_lavalamp");
			break;

		case "purchase_robot":
			param_01 thread scripts\cp\_vo::try_to_play_vo("collect_craft_misc","disco_comment_vo");
			scripts\cp\crafted_trap_robot::give_crafted_robot_trap(param_00,param_01);
			param_00.crafted_item setscriptablepartstate("active","pickup_robot");
			break;

		default:
			break;
	}

	crafting_cooldown(param_00);
	param_00.crafted_item setscriptablepartstate("active","default");
	wait(1);
	param_00.crafted_item setscriptablepartstate("active",param_00.scriptable_part_name);
}

//Function Number: 5
crafting_cooldown(param_00,param_01)
{
	param_00.var_4622 = 1;
	level scripts\common\utility::func_13734("regular_wave_starting","event_wave_starting");
	wait(1);
	level scripts\common\utility::func_13734("regular_wave_starting","event_wave_starting");
	param_00.var_4622 = undefined;
	var_02 = 5184;
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,param_00.origin) >= var_02)
		{
			continue;
		}

		var_04 scripts\cp\_interaction::func_DE6E();
	}
}

//Function Number: 6
show_next_piece(param_00)
{
	foreach(var_02 in param_00.var_1157E)
	{
		if(scripts\common\utility::istrue(var_02.ispuzzlepiece) && scripts\common\utility::istrue(var_02.hidden))
		{
			var_02.origin = var_02.table_pos;
			var_02 show();
			var_02.hidden = undefined;
			switch(param_00.script_noteworthy)
			{
				case "craft_zombgone":
					playfx(level._effect["zbc_tile_pup"],var_02.origin + (0,0,5));
					break;

				case "craft_turret":
					playfx(level._effect["turret_tile_pup"],var_02.origin + (0,0,5));
					break;

				case "craft_boombox":
					playfx(level._effect["boombox_tile_pup"],var_02.origin + (0,0,5));
					break;

				case "craft_lavalamp":
					playfx(level._effect["lavalamp_tile_pup"],var_02.origin + (0,0,5));
					break;

				case "craft_robot":
					playfx(level._effect["robot_tile_pup"],var_02.origin + (0,0,5));
					break;
			}

			return;
		}
	}
}

//Function Number: 7
func_4939()
{
	self setclientomnvar("zombie_souvenir_piece_index",1);
}

//Function Number: 8
func_47A5(param_00,param_01)
{
}

//Function Number: 9
func_113C5(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,param_01,param_02);
}

//Function Number: 10
func_7A27(param_00)
{
	return tablelookup("scripts/cp/maps/cp_zmb/cp_zmb_crafting.csv",1,param_00,0);
}

//Function Number: 11
get_puzzle_piece_location(param_00)
{
	var_01 = scripts\common\utility::getstructarray("puzzle","script_noteworthy");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!var_04 is_valid_tile_spot())
		{
			continue;
		}

		if(var_04.name == param_00 && !scripts\common\utility::istrue(var_04.var_1305B))
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_02 = scripts\common\utility::array_randomize(var_02);
	var_02[0].var_1305B = 1;
	return var_02[0];
}

//Function Number: 12
repopulate_puzzle_piece()
{
	self.puzzle_interaction.var_195 show();
	self.puzzle_interaction.var_195.hidden = undefined;
	scripts\cp\_interaction::add_to_current_interaction_list(self.puzzle_interaction);
	self.puzzle_piece = undefined;
	self.puzzle_interaction = undefined;
}

//Function Number: 13
pickup_puzzle(param_00,param_01)
{
	if(isdefined(param_01.puzzle_piece) || scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		param_01 playlocalsound("perk_machine_deny");
		return;
	}

	param_01 playlocalsound("zmb_coin_pickup");
	param_01 thread scripts\cp\_vo::try_to_play_vo("collect_puzzle","disco_comment_vo");
	param_01 scripts\cp\_vo::func_1769("nag_puzzle","disco_comment_vo",120,120,4,1);
	param_01.puzzle_piece = param_00.name;
	param_01.puzzle_interaction = param_00;
	param_00.var_195 hide();
	param_00.var_195.hidden = 1;
	var_02 = 1;
	switch(param_00.name)
	{
		case "craft_boombox":
			var_02 = 1;
			playfx(level._effect["boombox_tile_pup"],param_00.var_195.origin + (0,0,5));
			break;

		case "craft_zombgone":
			var_02 = 2;
			playfx(level._effect["zbc_tile_pup"],param_00.var_195.origin + (0,0,5));
			break;

		case "craft_turret":
			var_02 = 3;
			playfx(level._effect["turret_tile_pup"],param_00.var_195.origin + (0,0,5));
			break;

		case "craft_lavalamp":
			var_02 = 4;
			playfx(level._effect["lavalamp_tile_pup"],param_00.var_195.origin + (0,0,5));
			break;

		case "craft_robot":
			var_02 = 5;
			playfx(level._effect["robot_tile_pup"],param_00.var_195.origin + (0,0,5));
			break;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_01 setclientomnvar("zombie_souvenir_piece_index",var_02);
	param_01 thread reset_puzzle_piece_on_disconnect();
}

//Function Number: 14
reset_puzzle_piece_on_disconnect()
{
	self notify("reset_puzzle_piece_on_disconnect");
	self endon("reset_puzzle_piece_on_disconnect");
	self endon("death");
	var_00 = self.puzzle_interaction;
	self waittill("disconnect");
	var_00.var_195 show();
	var_00.var_195.hidden = undefined;
	scripts\cp\_interaction::add_to_current_interaction_list(var_00);
}