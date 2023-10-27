/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\crafted_entangler.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1446 ms
 * Timestamp: 10/27/2023 12:10:18 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_11901 = 60;
	var_00.var_9F43 = 0;
	if(!isdefined(level.var_47B3))
	{
		level.var_47B3 = [];
	}

	level.var_47B3["crafted_entangler"] = var_00;
	level thread watchforentangleractivation();
	initentanglermodels();
}

//Function Number: 2
watchforentangleractivation()
{
	level endon("game_ended");
	level waittill("complete_stay_on_pressure_plates");
	scripts\cp\_utility::set_quest_icon(2);
	scripts\cp\maps\cp_final\cp_final_mpq::activateinteractionsbynoteworthy("entangler_spawner");
	var_00 = scripts\common\utility::getstruct("entangler_spawner","script_noteworthy");
	var_01 = spawn("script_model",var_00.origin);
	var_01.angles = var_00.angles;
	var_01 setmodel("weapon_entangler_wm");
	var_01 thread moveandrotateentangler(var_01,var_00.origin);
	var_02 = spawn("script_model",scripts\common\utility::func_5D14(var_00.origin,12,-100) + (0,0,1));
	var_02 setmodel("final_gns_quest_origin");
	var_01.var_7542 = var_02;
	var_01.var_7542 setscriptablepartstate("pressure_plate","on");
	var_00.var_870F = var_01;
}

//Function Number: 3
moveandrotateentangler(param_00,param_01)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 rotateyaw(360,6);
		param_00 moveto(param_01 + (0,0,48),3,1,1);
		wait(3);
		param_00 moveto(param_01,3,0.5,0.5);
		wait(3);
	}
}

//Function Number: 4
give_crafted_entangler(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_entangler");
	param_01 setclientomnvar("zom_crafted_weapon",19);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	param_01.hascraftedentangler = 1;
	scripts\cp\_utility::func_F313("crafted_entangler",::give_crafted_entangler,param_01);
}

//Function Number: 5
unsetentanglerflagondeath(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("craft_dpad_watcher");
	param_00 waittill("death");
	param_00.hascollectedentangler = undefined;
}

//Function Number: 6
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self.hascollectedentangler = 1;
	thread unsetentanglerflagondeath(self);
	self notifyonplayercommand("pullout_trap","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_trap");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			self playlocalsound("perk_machine_deny");
			continue;
		}

		if(scripts\common\utility::istrue(self.var_9FCB))
		{
			self playlocalsound("perk_machine_deny");
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			self playlocalsound("perk_machine_deny");
			continue;
		}

		if(scripts\common\utility::istrue(self.attemptingpuzzle))
		{
			continue;
		}

		if(isdefined(self.allow_carry) && self.allow_carry == 0)
		{
			self playlocalsound("perk_machine_deny");
			continue;
		}

		if(scripts\common\utility::istrue(self.var_3AA5))
		{
			self playlocalsound("perk_machine_deny");
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread give_entangler(self);
}

//Function Number: 7
give_entangler(param_00)
{
	param_00 endon("disconnect");
	foreach(var_02 in level.wall_buy_interactions)
	{
		if(isdefined(var_02.trigger))
		{
			var_02.trigger method_8429(param_00);
		}

		scripts\cp\_interaction::func_E01A(var_02,param_00);
	}

	level notify("entangler_given",param_00);
	param_00.hasentanglerequipped = 1;
	param_00 scripts\cp\_utility::clearlowermessage("msg_power_hint");
	param_00.var_A039 = "entangler";
	param_00 func_E152();
	param_00.var_E2E6 = param_00 scripts\cp\_utility::getvalidtakeweapon();
	var_04 = "iw7_entangler2_zm";
	if(scripts\common\utility::flag("meph_fight"))
	{
		var_04 = "iw7_entangler_zm";
	}

	param_00.var_9FCB = 1;
	param_00 scripts\cp\_utility::func_12C6(var_04,undefined,undefined,1);
	param_00 switchtoweapon(var_04);
	var_05 = param_00 watchforputaway();
	param_00.hasentanglerequipped = undefined;
	foreach(var_02 in level.wall_buy_interactions)
	{
		if(scripts\common\utility::istrue(var_02.should_be_hidden))
		{
			continue;
		}

		if(isdefined(var_02.trigger))
		{
			var_02.trigger showtoplayer(param_00);
		}

		scripts\cp\_interaction::func_175D(var_02,param_00);
	}

	param_00.var_9FCB = undefined;
	param_00.var_3AA5 = undefined;
	param_00 thread func_1370F();
	param_00 func_E2E8();
	param_00.var_9D81 = 0;
	param_00 notify("entangler_removed");
	level notify("entangler_removed_" + param_00.name);
}

//Function Number: 8
watchforputaway()
{
	self endon("disconnect");
	scripts\common\utility::func_1C76(0);
	self notifyonplayercommand("cancel_entangler","+actionslot 3");
	self notifyonplayercommand("cancel_entangler","+weapnext");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_entangler","+actionslot 5");
		self notifyonplayercommand("cancel_entangler","+actionslot 6");
		self notifyonplayercommand("cancel_entangler","+actionslot 7");
	}

	for(;;)
	{
		var_00 = scripts\cp\_utility::func_1372D(self,"cancel_entangler",self,"craft_dpad_watcher",self,"weapon_purchased",self,"last_stand",self,"death",level,"players_activated_gns");
		if(scripts\common\utility::istrue(self.playing_ghosts_n_skulls))
		{
			continue;
		}

		if(isdefined(var_00))
		{
			if(var_00 == "death")
			{
				self.hascollectedentangler = undefined;
			}

			if(var_00 == "craft_dpad_watcher")
			{
				if(!scripts\common\utility::func_A009())
				{
					scripts\common\utility::func_1C76(1);
				}

				if(scripts\common\utility::flag("meph_fight"))
				{
					var_01 = "iw7_entangler_zm";
				}
				else
				{
					var_01 = "iw7_entangler2_zm";
					self.hascollectedentangler = undefined;
				}

				if(self hasweapon(var_01))
				{
					self takeweapon(var_01);
				}

				scripts\cp\_utility::func_DFE0(self);
				self notify("end_Ghost_Idle_Loop");
				break;
			}
			else
			{
				if(!scripts\common\utility::func_A009())
				{
					scripts\common\utility::func_1C76(1);
				}

				var_01 = "iw7_entangler2_zm";
				if(scripts\common\utility::flag("meph_fight"))
				{
					var_01 = "iw7_entangler_zm";
				}

				if(self hasweapon(var_01))
				{
					self takeweapon(var_01);
				}

				self notify("end_Ghost_Idle_Loop");
				thread func_13932();
				break;
			}
		}
	}
}

//Function Number: 9
func_E152()
{
	if(scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\cp\_utility::func_1430("specialty_explosivebullets");
	}
}

//Function Number: 10
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		if(self hasweapon(self.var_E2E6))
		{
			self switchtoweapon(self.var_E2E6);
		}
		else
		{
			self switchtoweapon(scripts\cp\_utility::getvalidtakeweapon());
		}
	}
	else
	{
		self switchtoweapon(scripts\cp\_utility::getvalidtakeweapon());
	}

	self.var_E2E6 = undefined;
}

//Function Number: 11
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\cp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 12
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 13
entangleitem(param_00,param_01,param_02)
{
	param_02 endon("death");
	if(isdefined(param_00))
	{
		param_00 notifyonplayercommand("item_released","-attack");
		param_00 setscriptablepartstate("entangler","active");
	}

	param_02 notify("item_entangled");
	if(param_00 scripts\cp\_utility::isweaponfireenabled())
	{
		param_00 scripts\common\utility::func_1C46(0);
	}

	if(param_00 scripts\cp\_utility::issprintenabled())
	{
		param_00 scripts\common\utility::func_1C67(0);
	}

	if(param_02.model == "cp_final_brute_mascot_mask")
	{
		param_02 scripts\cp\maps\cp_final\cp_final_interactions::helmet_not_useable();
	}

	var_03 = gettagfrommodel(param_02);
	var_04 = function_02DF(level._effect["entangler_beam"],param_00,"tag_flash",param_02,var_03);
	param_02.entangled = 1;
	param_02.var_3A9D = param_00;
	moveitemtowardsplayer(param_00,param_01,var_03);
	if(!isdefined(param_00))
	{
		param_02.forcerelease = 1;
	}

	if(isdefined(param_00))
	{
		param_00 notify("end_move_towards_player");
		param_00 setscriptablepartstate("entangler","fired");
	}

	if(isdefined(var_04))
	{
		var_04 delete();
	}

	if(isdefined(param_00))
	{
		if(!param_00 scripts\cp\_utility::isweaponfireenabled())
		{
			param_00 scripts\common\utility::func_1C46(1);
		}

		if(!param_00 scripts\cp\_utility::issprintenabled())
		{
			param_00 scripts\common\utility::func_1C67(1);
		}
	}

	if(isdefined(param_02.customlaunchfunc))
	{
		thread [[ param_02.customlaunchfunc ]](param_00,param_02,param_01);
		return;
	}

	launchitem(param_00,param_02,param_01);
}

//Function Number: 14
releaseitemaftertime(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("item_released");
	param_00 endon("entangler_removed");
	wait(gettimeoutfrommodel(param_01));
	param_01.forcerelease = 1;
	param_00 notify("item_released");
}

//Function Number: 15
gettimeoutfrommodel(param_00)
{
	switch(param_00.model)
	{
		case "ref_space_helmet_02":
			return 60;

		default:
			return 90;
	}
}

//Function Number: 16
gettagfrommodel(param_00)
{
	switch(param_00.model)
	{
		case "ref_space_helmet_02":
			return "us_space_helmet_a_lod1";

		default:
			return "tag_origin";
	}
}

//Function Number: 17
initentanglermodels()
{
	var_00 = scripts\common\utility::getstructarray("entangler_structs","targetname");
	foreach(var_02 in var_00)
	{
		level thread spawnentanglermodel(var_02);
	}
}

//Function Number: 18
spawnentanglermodel(param_00,param_01,param_02)
{
	if(isdefined(param_00.entanglemodel))
	{
		param_00.entanglemodel scripts\cp\_weapon::func_CC16("pillage",1,param_00.entanglemodel.origin);
		param_00.entanglemodel delete();
	}

	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = param_01.origin;
	}

	if(isdefined(param_02))
	{
		var_04 = param_02;
	}
	else if(isdefined(param_01.angles))
	{
		var_04 = param_01.angles;
	}
	else
	{
		var_04 = (0,0,0);
	}

	var_05 = spawn("script_model",var_03);
	var_05.angles = var_04;
	if(isdefined(param_00.script_noteworthy))
	{
		var_05 setmodel(param_00.script_noteworthy);
	}
	else
	{
		var_05 setmodel("ref_space_helmet_02");
	}

	param_00.entanglemodel = var_05;
	param_00 notify("new_model_created");
	var_05.parent_struct = param_00;
	var_05 thread watchforentanglerdamage(param_00,var_05);
	var_05 thread outlineitemforplayers(param_00,var_05);
}

//Function Number: 19
watchforentanglerdamage(param_00,param_01)
{
	param_01 notify("watchForEntanglerDamage");
	param_01 endon("watchForEntanglerDamage");
	level endon("game_ended");
	param_00 endon("new_model_created");
	param_00 endon("vent_grabbed_puzzle_piece");
	param_01 endon("end_entangler_funcs");
	param_00 endon("stop_watching_for_entangler_damage");
	param_01 setcandamage(1);
	param_01.health = 9999999;
	param_01.maxhealth = 9999999;
	for(;;)
	{
		param_01 waittill("damage",var_02,var_03,var_02,var_02,var_02,var_02,var_02,var_02,var_02,var_04);
		if(isdefined(var_04) && getweaponbasename(var_04) == "iw7_entangler2_zm")
		{
			var_03.entangledmodel = param_01;
			thread entangleitem(var_03,param_00,param_01);
			param_01 waittill("released",var_05,var_06,var_07);
			var_08 = isdefined(param_00.var_86A2);
			var_09 = param_01.origin;
			if(param_01 istouching(getent("electric_trap_trig","targetname")))
			{
				var_05 = 1;
			}

			if(!scripts\common\utility::istrue(var_05) && scripts\cp\maps\cp_final\cp_final::validateplayspace(var_09,var_03,var_08,var_08,var_07))
			{
				if(param_01.model == "cp_final_brute_mascot_mask")
				{
					param_01 scripts\cp\maps\cp_final\cp_final_interactions::helmet_useable();
				}
				else
				{
					param_01 method_851B();
					if(isdefined(param_00.var_86A2))
					{
						level.undergratepuzzlepiece = param_01;
						level notify("vent_fx");
					}

					if(scripts\common\utility::istrue(var_06))
					{
						param_01 notify("end_entangler_funcs");
					}
				}
			}
			else if(isdefined(param_00.var_1088C))
			{
				thread [[ param_00.var_1088C ]](param_00.var_92B8,param_00);
			}
			else if(param_01.model == "cp_final_brute_mascot_mask")
			{
				param_01 scripts\cp\maps\cp_final\cp_final_interactions::helmet_useable();
				level.brute_helm_out_of_bounds = 1;
			}
			else
			{
				level thread spawnentanglermodel(param_00,param_00.origin,param_00.angles);
			}
		}
	}
}

//Function Number: 20
moveitemtowardsplayer(param_00,param_01,param_02)
{
	param_00 endon("entangler_removed");
	param_00 endon("disconnect");
	param_00 endon("item_released");
	level endon("entangler_removed_" + param_00.name);
	wait(0.1);
	var_03 = 1250;
	var_04 = 0;
	var_05 = 72;
	var_06 = 0;
	var_07 = param_00.entangledmodel;
	var_08 = 1;
	var_09 = scripts\common\trace::func_48BC(1,1,1,1,0,0,1);
	var_0A = scripts\common\trace::func_48BC(1,1,1,1,1,0,0);
	var_0B = getcapsulefrommodel(var_07);
	var_07 endon("end_entangle_move_to_logic");
	var_07.lasteffecttime = 0;
	if(isdefined(var_07.var_EE79) && var_07.var_EE79 == "heavy_helmet")
	{
		var_05 = 100;
		var_03 = 250;
		var_08 = 0;
	}

	playfxontag(level._effect["vfx_item_entagled"],var_07,param_02);
	thread delaykillfx(var_07,param_02,param_00);
	param_00 thread monitorplayerviewangles(param_00,var_07);
	var_0C = 0;
	var_0D = 0;
	for(var_0E = 0;isdefined(param_00) && param_00 getcurrentweapon() == "iw7_entangler2_zm";var_0E++)
	{
		var_0F = gettime();
		if(var_07.lasteffecttime + 250 <= var_0F)
		{
			var_07.lasteffecttime = var_0F;
		}

		var_05 = 72;
		var_10 = param_00 getvelocity();
		var_11 = vectordot(var_10,param_00.angles);
		if(var_11 >= 1)
		{
			var_12 = length(var_10);
			if(var_12 >= 250)
			{
				var_05 = var_05 + 48;
			}
			else if(var_12 >= 185)
			{
				var_05 = var_05 + 24;
			}
			else if(var_12 >= 100)
			{
				var_05 = var_05 + 12;
			}
		}

		var_13 = var_0C >= 10;
		var_14 = var_0C >= 20;
		var_0D = var_0E >= 5;
		var_15 = scripts\common\utility::array_combine(level.players,[var_07]);
		var_16 = param_00 geteye();
		var_17 = param_00.origin + (0,0,56);
		var_18 = (0,var_05,0);
		var_19 = param_00 getplayerangles();
		var_1A = anglestoforward(var_19);
		var_1B = anglestoup(var_19);
		var_1C = anglestoright(var_19);
		var_1D = var_06;
		var_17 = var_17 + var_18[0] * var_1C;
		var_17 = var_17 + var_18[1] * var_1A;
		var_17 = var_17 + var_18[2] * var_1B;
		var_1E = rotatepointaroundvector(anglestoup(var_19),anglestoforward(var_19),var_1D);
		var_1F = var_17 + var_1E;
		var_20 = var_1F[2];
		var_21 = scripts\common\utility::func_5D14(var_16,12,-100)[2] + 16;
		var_22 = min(var_16[2] + 12,var_21 + 56);
		var_20 = clamp(var_1F[2],var_21,var_22);
		var_1F = (var_1F[0],var_1F[1],var_20);
		if(isdefined(param_01.entanglerangleupdate))
		{
			var_17 = [[ param_01.entanglerangleupdate ]](param_00,param_01,var_07);
			var_23 = vectortoangles(var_17 - var_07.origin);
		}
		else
		{
			var_23 = vectortoangles(param_00.origin - var_07.origin);
		}

		if(var_07.model == "cp_final_subway_turnstyle_arm")
		{
			var_07.angles = (var_23[0],var_23[1],var_23[2]);
		}
		else
		{
			var_07.angles = (var_07.angles[0],var_23[1],var_23[2]);
		}

		var_24 = distance(var_07.origin,var_1F);
		var_04 = var_24 / var_03;
		if(var_04 < 0.05)
		{
			var_04 = 0.05;
		}

		if(var_08)
		{
			if(scripts\common\utility::istrue(param_00.var_9C54) || scripts\common\utility::istrue(param_00.isfasttravelling))
			{
				var_13 = 0;
				var_0C = 0;
				var_07.origin = var_1F;
			}
			else if(!isdefined(param_01.entanglemovetofunc))
			{
				if(var_0D)
				{
					var_25 = var_07.origin + anglestoforward(vectortoangles(param_00.origin - var_07.origin)) * 12;
					var_26 = scripts\common\trace::func_3A09(var_25,var_1F,var_0B[0],var_0B[1],undefined,var_15,var_09,1);
					var_1F = var_26["shape_position"] - (0,0,var_26["shape_position"][2]) + (0,0,var_20);
				}

				if(var_24 <= 64)
				{
					var_07.origin = var_1F;
				}
				else
				{
					var_07 moveto(var_1F,var_04);
					param_00 scripts\common\utility::waittill_any_timeout_1(var_04,"update_item_pos","delete_equipment");
				}
			}
			else if(isdefined(param_01.entanglemovetofunc))
			{
				var_13 = 0;
				if([[ param_01.entanglemovetofunc ]](param_01,var_1F,var_07,param_00))
				{
					if(var_24 <= 64)
					{
						var_07.origin = var_1F;
					}
					else
					{
						var_07 moveto(var_1F,var_04);
						param_00 scripts\common\utility::waittill_any_timeout_1(var_04,"update_item_pos","delete_equipment");
					}
				}
				else
				{
					var_15 = scripts\common\utility::array_combine(level.players,[var_07]);
					var_26 = scripts\common\trace::func_3A09(param_01.origin,param_00.origin,var_0B[0],var_0B[1],undefined,var_15,var_09,24);
					var_27 = var_26["shape_position"] + (0,0,32);
					var_07.origin = var_27;
				}
			}
			else if(var_24 <= 56)
			{
				var_07.origin = var_1F;
			}
			else
			{
				var_07 moveto(var_1F,var_04);
				param_00 scripts\common\utility::waittill_any_timeout_1(var_04,"update_item_pos","delete_equipment");
			}

			scripts\common\utility::func_136F7();
			if(var_13)
			{
				var_25 = var_07.origin + anglestoforward(var_07.angles) * 18;
				var_15 = scripts\common\utility::array_combine(level.players,[var_07]);
				var_28 = scripts\common\trace::func_DCED(var_16,var_25 + (0,0,16),var_15,var_0A);
				if(isdefined(var_28["hittype"]) && var_28["hittype"] != "hittype_none")
				{
					if(var_28["hittype"] == "hittype_entity" && isdefined(var_28["entity"]) && !isplayer(var_28["entity"]))
					{
						if(var_14)
						{
							var_07.forcerelease = 1;
							param_00 notify("item_released");
						}
					}
					else
					{
						var_07.forcerelease = 1;
						param_00 notify("item_released");
					}
				}
				else
				{
					var_0C = 0;
					continue;
				}
			}
		}
		else if(var_24 >= 8)
		{
			var_07 moveto(var_1F,var_04);
			param_00 scripts\common\utility::waittill_any_timeout_1(var_04,"update_item_pos","delete_equipment");
		}
		else
		{
			scripts\common\utility::func_136F7();
			if(var_13)
			{
				var_25 = var_07.origin + anglestoforward(var_07.angles) * 18;
				var_15 = scripts\common\utility::array_combine(level.players,[var_07]);
				var_28 = scripts\common\trace::func_DCED(var_16,var_25 + (0,0,16),var_15,var_0A);
				if(isdefined(var_28["hittype"]) && var_28["hittype"] != "hittype_none")
				{
					if(var_28["hittype"] == "hittype_entity" && isdefined(var_28["entity"]) && !isplayer(var_28["entity"]))
					{
						if(var_14)
						{
							var_07.forcerelease = 1;
							param_00 notify("item_released");
						}
					}
					else
					{
						var_07.forcerelease = 1;
						param_00 notify("item_released");
					}
				}
				else
				{
					var_0C = 0;
					continue;
				}
			}
		}

		var_0C++;
	}
}

//Function Number: 21
delaykillfx(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_02 scripts\common\utility::waittill_any_3("disconnect","end_move_towards_player");
	stopfxontag(level._effect["vfx_item_entagled"],param_00,param_01);
}

//Function Number: 22
getcapsulefrommodel(param_00)
{
	switch(param_00.model)
	{
		case "cp_final_brute_mascot_mask":
			return [16,32];

		case "final_kevin_head":
			return [10,20];

		case "ref_space_helmet_02":
			return [8,16];

		default:
			return [12,24];
	}
}

//Function Number: 23
monitorplayerviewangles(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("death");
	param_00 endon("item_released");
	level endon("entangler_removed_" + param_00.name);
	for(;;)
	{
		var_02 = param_00 geteye();
		var_03 = vectornormalize(anglestoforward(param_00 getplayerangles())) * 72;
		var_04 = var_02 + var_03;
		if(distance(param_01.origin,var_04) >= 5)
		{
			param_00 notify("update_item_pos");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 24
launchitem(param_00,param_01,param_02)
{
	level endon("game_ended");
	if(isdefined(param_00))
	{
		param_00 endon("disconnect");
		var_03 = [param_00,param_01];
	}
	else
	{
		var_03 = [param_02];
	}

	if(!isdefined(param_01))
	{
		if(isdefined(param_00) && isdefined(param_00.entangledmodel))
		{
			param_01 = param_00.entangledmodel;
		}
		else
		{
			return;
		}
	}

	if(isdefined(param_00))
	{
		param_00.entangledmodel = undefined;
	}

	param_01.var_AAA8 = 1;
	if(isdefined(param_00))
	{
		var_04 = param_00 geteye();
	}
	else
	{
		var_04 = param_02.origin;
	}

	var_05 = param_01.origin;
	var_06 = (0,10000,0);
	if(isdefined(param_00))
	{
		var_07 = param_00 getplayerangles();
	}
	else
	{
		var_07 = anglestoforward(param_02.angles) * -1;
	}

	var_08 = 0;
	var_05 = var_05 + var_06[0] * anglestoright(var_07);
	var_05 = var_05 + var_06[1] * anglestoforward(var_07);
	var_05 = var_05 + var_06[2] * anglestoup(var_07);
	var_09 = rotatepointaroundvector(anglestoup(var_07),anglestoforward(var_07),var_08);
	var_0A = scripts\common\trace::func_48BC(1,1,1,1,0,0,1);
	var_0B = scripts\common\trace::func_3A09(var_04,var_05 + var_09,16,32,undefined,var_03,var_0A,24);
	var_0C = var_0B["shape_position"];
	var_0D = var_05;
	var_0E = vectornormalize(var_05 - var_0C);
	var_0E = var_0E * 10000;
	if(isdefined(param_01.var_EE79) && param_01.var_EE79 == "heavy_helmet")
	{
		var_0E = var_0E / 2;
	}

	if(scripts\common\utility::istrue(param_01.forcerelease))
	{
		var_0F = scripts\common\utility::func_5D14(param_01.origin,24,-200);
		var_10 = -150;
		var_0E = trajectorycalculateinitialvelocity(var_0F + (0,0,20),var_0F + (0,0,20) + (randomintrange(-10,10),randomintrange(-10,10),0),(0,0,var_10),2);
		param_01.forcerelease = undefined;
	}

	param_01 physicslaunchserver(var_0D,var_0E);
	param_01 method_84D1();
	if(isdefined(param_01.collisionfunc))
	{
		thread [[ param_01.collisionfunc ]](param_01,param_02,param_00);
		return;
	}

	thread delaykillitem(param_01,param_02,param_00);
}

//Function Number: 25
delaykillitem(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 waittill("collision",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
	var_0B = gettime();
	param_00.soundlastplayed = var_0B;
	playsoundatpos(param_00.origin,"weap_axe_throw_impact");
	var_0C = param_00.origin;
	for(var_0D = 0;var_0D <= 20;var_0D++)
	{
		var_0E = param_00.origin;
		var_0F = param_00.angles;
		param_00 scripts\common\utility::waittill_any_timeout_1(0.1,"collision");
		level notify("entangler_item_collision",param_00.origin);
		if(distance(var_0E,param_00.origin) < 1 && var_0F == param_00.angles)
		{
			break;
		}

		var_0B = gettime();
		if(param_00.soundlastplayed <= var_0B - 250)
		{
			param_00.soundlastplayed = var_0B;
			playsoundatpos(param_00.origin,"weap_axe_throw_impact");
		}
	}

	if(var_0D >= 20)
	{
		param_00.forcedrespawn = 1;
	}

	param_00.hasbeenthrown = 1;
	param_00.var_AAA8 = undefined;
	param_00 notify("released");
	param_00.var_A5AB = 0;
}

//Function Number: 26
outlineitemforplayers(param_00,param_01)
{
}

//Function Number: 27
outlineitemforplayer(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	level endon("game_ended");
	param_00 endon("disconnect");
	param_01 endon("death");
	entangleritemoutlinemonitor(param_00,param_01);
	if(!isdefined(param_01))
	{
		return;
	}

	param_01 hudoutlinedisableforclient(param_00);
}

//Function Number: 28
entangleritemoutlinemonitor(param_00,param_01)
{
	level endon("game_ended");
	level endon("entangler_removed_" + param_00.name);
	param_00 endon("disconnect");
	param_01 endon("end_entangler_funcs");
	param_01 endon("death");
	for(;;)
	{
		if(isdefined(param_01))
		{
			if(isdefined(param_00.entangledmodel) && param_00.entangledmodel == param_01)
			{
				param_01 hudoutlinedisableforclient(param_00);
			}
			else if(scripts\common\utility::istrue(param_01.var_AAA8))
			{
				param_01 hudoutlinedisableforclient(param_00);
			}
			else if(distance(param_00.origin,param_01.origin) <= 500)
			{
				param_01 hudoutlineenableforclient(param_00,5,1,0,0);
			}
			else
			{
				param_01 hudoutlinedisableforclient(param_00);
			}
		}
		else
		{
			break;
		}

		wait(0.25);
	}
}