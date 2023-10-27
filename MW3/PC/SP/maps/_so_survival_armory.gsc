/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_armory.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 104
 * Decompile Time: 1731 ms
 * Timestamp: 10/27/2023 2:21:25 AM
*******************************************************************/

//Function Number: 1
armory_preload()
{
	maps\_sp_airdrop::sp_airdrop_preload();
	maps\_sp_killstreaks::sp_killstreaks_global_preload();
	lib_0616::main();
	level.remote_missile_grain_overlay = 1;
	level.visionthermaldefault = "thermal_mp";
	level.var_3BDB = "thermal_mp";
	maps\_so_survival_code::delete_on_load();
	maps\_so_survival_code::remotemissile_infantry_kills_dialogue_setup();
	precachestring(&"SO_SURVIVAL_ARMORY_USE_WEAPON");
	precachestring(&"SO_SURVIVAL_ARMORY_USE_EQUIPMENT");
	precachestring(&"SO_SURVIVAL_ARMORY_USE_AIRSUPPORT");
	precacheshader("specops_ui_equipmentstore");
	precacheshader("specops_ui_weaponstore");
	precacheshader("specops_ui_airsupport");
	precacheshader("specops_ui_deltasupport");
	precacheshader("specops_ui_riotshieldsupport");
	precachemenu("survival_armory_equipment");
	precachemenu("survival_armory_airsupport");
	precachemenu("survival_armory_weapon");
	precachemenu("survival_armory_replacement_warning");
	maps\_utility::add_hint_string("dpad_right_slot_full",&"SO_SURVIVAL_DPAD_RIGHT_SLOT_FULL");
	for(var_00 = 0;var_00 <= 64;var_00++)
	{
		var_01 = get_ref_by_index(var_00);
		if(isdefined(var_01) && var_01 != "" && var_01 != "ammo" && get_type(var_01) == "weapon")
		{
			maps\_so_survival_code::precache_loadout_item(var_01);
		}
	}

	precacheitem("claymore");
	precacheitem("rpg_survival");
	precacheitem("iw5_riotshield_so");
	precacheitem("air_support_strobe");
	level.air_support_sticky_marker_fx = loadfx("smoke/signal_smoke_air_support_pulse");
	precachemodel("vehicle_ac130_coop");
	precachemodel("c130_zoomrig");
	level.armory = [];
	level.armory_all_items = [];
	armory_populate(100,120,"weaponupgrade");
	armory_populate(0,64,"weapon");
	armory_populate(1000,1020,"equipment");
	armory_populate(10000,10020,"airsupport");
}

//Function Number: 2
armory_postload()
{
	maps\_sp_killstreaks::sp_killstreaks_init();
	level.airdropcrateusetime = 0;
	level.airdropcratetimeout = 60;
	level.airdropcrateunstuck = 1;
	maps\_sp_killstreaks::add_sp_killstreak("carepackage");
	maps\_sp_killstreaks::add_sp_killstreak("remote_missile");
	maps\_sp_killstreaks::add_sp_killstreak("sentry");
	maps\_sp_killstreaks::add_sp_killstreak("sentry_gl");
	maps\_sp_killstreaks::add_sp_killstreak("specialty_longersprint");
	maps\_sp_killstreaks::add_sp_killstreak("specialty_fastreload");
	maps\_sp_killstreaks::add_sp_killstreak("specialty_quickdraw");
	maps\_sp_killstreaks::add_sp_killstreak("specialty_detectexplosive");
	maps\_sp_killstreaks::add_sp_killstreak("specialty_bulletaccuracy");
	maps\_sp_killstreaks::add_sp_killstreak("specialty_stalker");
	maps\_remotemissile::init();
	level thread maps\_so_survival_code::remotemissile_uav();
	level thread maps\_so_survival_code::remotemissile_infantry_kills_dialogue();
	level.claymoresentientfunc = ::claymoresentientfunc;
	maps\_air_support_strobe::main();
	ac130_traverse();
}

//Function Number: 3
ac130_traverse()
{
	level.ac130_speed["move"] = 250;
	level.ac130_speed["rotate"] = 70;
	level.strobe_no_vis_check = 1;
	level.strobe_no_badplace = 1;
	var_00 = getentarray("minimap_corner","targetname");
	var_01 = (0,0,0);
	if(var_00.size)
	{
		var_01 = findboxcenter(var_00[0].origin,var_00[1].origin);
	}

	level.ac130 = spawn("script_model",var_01);
	level.ac130 setmodel("c130_zoomrig");
	level.ac130.angles = (0,115,0);
	level.ac130 hide();
	level thread rotateplane();
	level thread ac130_spawn();
}

//Function Number: 4
findboxcenter(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 5
rotateplane()
{
	level notify("stop_rotatePlane_thread");
	level endon("stop_rotatePlane_thread");
	var_00 = 10;
	var_01 = level.ac130_speed["rotate"] / 360 * var_00;
	level.ac130 rotateyaw(level.ac130.angles[2] + var_00,var_01,var_01,0);
	for(;;)
	{
		level.ac130 rotateyaw(360,level.ac130_speed["rotate"]);
		wait level.ac130_speed["rotate"];
	}
}

//Function Number: 6
ac130_spawn()
{
	wait 0.05;
	var_00 = spawn("script_model",level.ac130 gettagorigin("tag_origin") + (0,3000,4500));
	var_00 setmodel("vehicle_ac130_coop");
	var_00 setcandamage(0);
	var_00.health = 1000;
	var_00 linkto(level.ac130,"tag_origin",(0,3000,4500),(25,-90,0));
	level.ac130.planemodel = var_00;
	level.ac130.planemodel hide();
	wait 0.05;
	level.ac130.planemodel show();
	maps\_air_support_strobe::set_aircraft(level.ac130.planemodel);
}

//Function Number: 7
armory_init()
{
	var_00 = armory_setup("weapon","specops_ui_weaponstore",&"SO_SURVIVAL_ARMORY_USE_WEAPON");
	var_01 = armory_setup("equipment","specops_ui_equipmentstore",&"SO_SURVIVAL_ARMORY_USE_EQUIPMENT");
	var_02 = armory_setup("airsupport","specops_ui_airsupport",&"SO_SURVIVAL_ARMORY_USE_AIRSUPPORT");
	level thread armory_usage_think(var_00);
	level thread armory_usage_think(var_01);
	level thread armory_usage_think(var_02);
	foreach(var_04 in level.players)
	{
		var_04 thread track_ownership();
		var_04 thread sentry_setup();
	}
}

//Function Number: 8
armory_populate(param_00,param_01,param_02)
{
	for(var_03 = param_00;var_03 <= param_01;var_03++)
	{
		var_04 = get_ref_by_index(var_03);
		if(!isdefined(var_04) || var_04 == "")
		{
			continue;
		}

		var_05 = spawnstruct();
		var_05.idx = var_03;
		var_05.ref = var_04;
		var_05.type = param_02;
		var_05.sub_type = get_sub_type(var_04);
		var_05.name = get_name(var_04);
		var_05.var_189B = get_desc(var_04);
		var_05.cost = get_cost(var_04);
		var_05.icon = get_icon(var_04);
		var_05.unlockrank = get_unlock_rank(var_04);
		var_05.func_can_give = get_func_can_give(param_02,var_04);
		var_05.func_give = get_func_give(param_02,var_04);
		if(param_02 == "weaponupgrade")
		{
			var_05.slot = get_slot(var_04);
		}

		if(param_02 == "weapon" && var_04 != "ammo")
		{
			var_05.maxstock = 1;
			var_05.upgrades = get_upgrades_possible(var_04);
			var_05.dropclip = get_item_drop_clip(var_04);
			var_05.dropstock = get_item_drop_stock(var_04);
		}
		else
		{
			var_05.enabled = is_item_enabled(var_04);
			var_05.maxstock = get_maxstock(var_04);
		}

		level.armory[param_02][var_04] = var_05;
		level.armory_all_items[var_04] = var_05;
	}
}

//Function Number: 9
armory_setup(param_00,param_01,param_02,param_03)
{
	var_04 = getent("armory_" + param_00,"targetname");
	if(!isdefined(var_04))
	{
		return;
	}

	var_04.armory_type = param_00;
	var_04.icon = param_01;
	var_04.usehint = param_02;
	var_04.menu = "survival_armory_" + param_00;
	var_04.laptop_locked = getent(var_04.target,"targetname");
	var_04.laptop = getent(var_04.laptop_locked.target,"targetname");
	var_04.laptop hide();
	var_04 thread armory_use_monitor();
	return var_04;
}

//Function Number: 10
armory_setup_players()
{
	foreach(var_01 in level.armory)
	{
		foreach(var_03 in var_01)
		{
			foreach(var_05 in level.players)
			{
				var_06 = var_03.type;
				var_07 = var_03.ref;
				var_08 = var_05 get_ownership_val(var_03.ref);
				var_05 set_ownership(var_06,var_07,var_08);
			}
		}
	}
}

//Function Number: 11
get_ownership_val(param_00)
{
	var_01 = armory_can_give(param_00);
	if(var_01 == 0)
	{
		return 1;
	}

	if(var_01 == 2)
	{
		return 2;
	}

	return 0;
}

//Function Number: 12
armory_use_monitor()
{
	level endon("special_op_terminated");
	waittill_armory_unlocked();
	self.laptop show();
	self.laptop_locked hide();
	var_00 = newhudelem();
	var_00.archived = 1;
	var_00.x = self.origin[0];
	var_00.y = self.origin[1];
	var_00.z = self.origin[2];
	var_00.alpha = 0.75;
	var_00 setshader(self.icon,12,12);
	var_00 setwaypoint(1,1,0);
	self.crateworldicon = var_00;
	self sethintstring(self.usehint);
	self makeusable();
	level notify("armory_open",self);
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		wait 0.1;
		if(!var_01 usebuttonpressed())
		{
			continue;
		}

		self notify("armory_use",var_01);
	}
}

//Function Number: 13
waittill_armory_unlocked()
{
	level endon("special_op_terminated");
	for(;;)
	{
		level waittill("wave_ended",var_00);
		if(level.armory_unlock[self.armory_type] == var_00)
		{
			return;
		}
	}
}

//Function Number: 14
waittill_armory_warning_respond(param_00)
{
	level endon("special_op_terminated");
	self endon("armory_closed");
	self endon("armory_interrupted");
	self endon("dog_attacks_player");
	for(;;)
	{
		self waittill("menuresponse",var_01,var_02);
		if(var_01 != param_00)
		{
			continue;
		}
		else
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 15
waittill_armory_respond()
{
	level endon("special_op_terminated");
	self endon("armory_closed");
	self endon("armory_interrupted");
	self endon("dog_attacks_player");
	self waittill("menuresponse",var_00,var_01);
	return var_01;
}

//Function Number: 16
armory_downed_interrupt()
{
	level endon("special_op_terminated");
	self endon("armory_closed");
	self endon("dog_attacks_player");
	for(;;)
	{
		self waittill("player_downed");
		self notify("armory_interrupted");
	}
}

//Function Number: 17
armory_usage_think(param_00)
{
	level endon("special_op_terminated");
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		var_02.using_armory = 0;
	}

	for(;;)
	{
		param_00 waittill("armory_use",var_04);
		if(!var_04.using_armory)
		{
			var_04 thread armory_user_thread(param_00);
		}
	}
}

//Function Number: 18
armory_user_thread(param_00)
{
	level endon("special_op_terminated");
	self endon("death");
	thread armory_downed_interrupt();
	if(!isdefined(self) || !isplayer(self) || !isalive(self))
	{
		return;
	}

	if(param_00.armory_type == "airsupport" && !has_open_slot_right())
	{
		maps\_utility::display_hint("dpad_right_slot_full");
		return;
	}

	self notify("armory_opened",param_00);
	self.using_armory = 1;
	var_01 = param_00.menu;
	self openpopupmenu(param_00.menu);
	self freezecontrols(1);
	for(;;)
	{
		var_02 = waittill_armory_respond();
		if(!isdefined(var_02))
		{
			close_armory_interface();
			break;
		}

		if(var_02 == "quit")
		{
			self.selected_weapon = undefined;
			close_armory_interface();
			break;
		}

		if(var_02 == "share")
		{
			if(self.survival_credit == 0)
			{
				continue;
			}

			var_03 = 500;
			if(self.survival_credit < 500)
			{
				var_03 = self.survival_credit;
			}

			foreach(var_05 in level.players)
			{
				if(var_05 == self)
				{
					var_05.survival_credit = var_05.survival_credit - var_03;
				}

				if(var_05 != self)
				{
					var_05.survival_credit = var_05.survival_credit + var_03;
				}

				var_06 = 1;
				var_05 notify("credit_updated",var_06);
			}
		}

		if(issubstr(var_02,"weaponswitch"))
		{
			var_08 = strtok(var_02,"_")[1];
			var_09 = get_ref_by_index(var_08);
			if(!isdefined(var_09) || var_09 == "")
			{
				continue;
			}

			var_0A = self getweaponslistprimaries();
			foreach(var_0C in var_0A)
			{
				if(weaponclass(var_0C) == "rocketlauncher" || weaponclass(var_0C) == "item" || weaponclass(var_0C) == "none")
				{
					continue;
				}

				if(get_weapon_base_name(var_0C) == var_09)
				{
					self.selected_weapon = var_0C;
					self notify("new_weapon_selected");
					break;
				}
			}
		}

		if(issubstr(var_02,"purchase"))
		{
			var_0E = strtok(var_02,"_")[1];
			var_0F = get_ref_by_index(var_0E);
			var_10 = get_cost(var_0F);
			var_11 = 0;
			if((var_0F == "rpg_survival" || var_0F == "iw5_riotshield_so") && !self hasweapon(var_0F) && isdefined(get_replaceable_weapon()))
			{
				self openpopupmenu("survival_armory_replacement_warning");
				var_02 = waittill_armory_warning_respond("survival_armory_replacement_warning");
				if(!isdefined(var_02) || var_02 != "continue")
				{
					close_armory_interface();
					thread armory_user_thread(param_00);
					return;
				}
				else
				{
					var_11 = 1;
				}
			}

			if(self.survival_credit >= var_10)
			{
				if(armory_can_give(var_0F))
				{
					self notify("armory_opened",param_00);
					armory_give(var_0F);
					if(get_sub_type(var_0F) == "sniper")
					{
						self.selected_weapon = var_0F;
						give_weapon_upgrade(strtok(var_0F,"_")[1] + "scope");
					}

					self.survival_credit = self.survival_credit - var_10;
					self notify("credit_updated");
					var_12 = get_type(var_0F);
					if(var_12 == "weapon" || var_12 == "weaponupgrade")
					{
						maps\_specialops::so_achievement_update("ARMS_DEALER",var_0F);
					}

					if(get_sub_type(var_0F) == "sniper")
					{
						maps\_specialops::so_achievement_update("ARMS_DEALER",strtok(var_0F,"_")[1] + "scope");
					}

					if(var_12 == "airsupport")
					{
						maps\_specialops::so_achievement_update("DANGER_ZONE",var_0F);
					}

					if(var_12 == "equipment")
					{
						maps\_specialops::so_achievement_update("DEFENSE_SPENDING",var_0F);
					}
				}
			}

			if(var_11)
			{
				close_armory_interface();
				thread armory_user_thread(param_00);
				return;
			}

			if(param_00.armory_type == "airsupport")
			{
				close_armory_interface();
				break;
			}
		}
	}
}

//Function Number: 19
close_armory_interface()
{
	self closepopupmenu();
	self freezecontrols(0);
	self notify("armory_closed");
	self.using_armory = 0;
}

//Function Number: 20
create_player_pip()
{
	if(!isdefined(self.pip))
	{
		self.pip = self newpip();
	}

	self.pip.entity = spawn("script_model",self.origin);
	self.pip.entity setmodel("tag_origin");
	wait 0.05;
	self.pip.tag = "tag_origin";
	self.pip.fov = 65;
	self.pip.freecamera = 1;
	self.pip.enableshadows = 0;
	self.pip.x = -40;
	self.pip.y = 310;
	self.pip.width = 240;
	self.pip.height = 135;
	self.pip.enable = 0;
}

//Function Number: 21
sentry_setup()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("new_sentry",var_00);
		var_00 setthreatbiasgroup("sentry");
		if(weapontype(var_00.weaponname) == "projectile")
		{
			var_00 setconvergenceheightpercent(0);
			continue;
		}

		var_00 setconvergenceheightpercent(0.7);
	}
}

//Function Number: 22
sentry_pip_cam(param_00)
{
	self endon("death");
	param_00 endon("death");
	thread death_pip_disable(param_00);
	for(;;)
	{
		link_pip_cam_to(param_00);
		setup_pip_name(param_00);
		if(!self.pip.enable)
		{
			self.pip.enable = 1;
		}

		param_00 waittill("sentry_move_started");
		self.pip.entity unlink();
		if(self.pip.enable)
		{
			self.pip.enable = 0;
		}

		if(isdefined(self.pip_display_name))
		{
			self.pip_display_name destroy();
		}

		param_00 waittill("sentry_move_finished");
	}
}

//Function Number: 23
cycle_sentry_pip()
{
	self endon("death");
	self notifyonplayercommand("pip_cycle","+actionslot 2");
	if(!isdefined(self.pip_sentry_id))
	{
		self.pip_sentry_id = 0;
	}

	for(;;)
	{
		self waittill("pip_cycle");
		if(isdefined(level.placed_sentry) && level.placed_sentry.size)
		{
			if(self.pip_sentry_id > level.placed_sentry.size - 1)
			{
				self.pip_sentry_id = 0;
			}

			pip_patch_into(self.pip_sentry_id);
			self.pip_sentry_id++;
		}
	}
}

//Function Number: 24
death_pip_disable(param_00)
{
	self endon("death");
	param_00 waittill("death");
	if(self.pip.enable)
	{
		self.pip.enable = 0;
	}

	self.pip_display_name destroy();
}

//Function Number: 25
pip_patch_into(param_00)
{
	var_01 = level.placed_sentry[param_00];
	if(!isdefined(var_01))
	{
		return;
	}

	if(self.pip.enable)
	{
		self.pip.enable = 0;
	}

	link_pip_cam_to(var_01);
	setup_pip_name(self);
	if(!self.pip.enable)
	{
		self.pip.enable = 1;
	}

	self.pip.display_id = param_00;
}

//Function Number: 26
setup_pip_name(param_00)
{
	if(isdefined(self.pip_display_name))
	{
		self.pip_display_name destroy();
	}

	self.pip_display_name = newhudelem();
	self.pip_display_name.alpha = 1;
	self.pip_display_name.x = self.pip.x;
	self.pip_display_name.y = self.pip.y - 20;
	self.pip_display_name.hidewheninmenu = 0;
	self.pip_display_name.hidewhendead = 1;
	self.pip_display_name.fontscale = 1.25;
	if(!isdefined(self.pip.display_id))
	{
		self.pip.display_id = 0;
	}

	self.pip_display_name.label = "Sentry #" + self.pip.display_id + " [Dpad down to cycle]";
}

//Function Number: 27
link_pip_cam_to(param_00)
{
	var_01 = -12 * vectornormalize(anglestoforward(param_00.angles));
	var_02 = param_00 gettagorigin("mg01") + (0,0,12) + var_01;
	self.pip.entity unlink();
	self.pip.entity.origin = var_02;
	self.pip.entity.angles = param_00.angles;
	self.pip.entity linkto(param_00,"mg01");
}

//Function Number: 28
get_total_sentries()
{
	var_00 = 0;
	if(isdefined(level.placed_sentry) && level.placed_sentry.size)
	{
		var_00 = var_00 + level.placed_sentry.size;
	}

	foreach(var_02 in level.players)
	{
		if(var_02 maps\_sp_killstreaks::has_killstreak("sentry"))
		{
			var_00++;
		}

		if(var_02 maps\_sp_killstreaks::has_killstreak("sentry_gl"))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 29
has_sentry()
{
	if(maps\_sp_killstreaks::has_killstreak("sentry"))
	{
		return 1;
	}

	if(maps\_sp_killstreaks::has_killstreak("sentry_gl"))
	{
		return 1;
	}

	foreach(var_01 in level.placed_sentry)
	{
		if(isdefined(var_01) && isdefined(var_01.attacker) && isplayer(var_01.attacker) && var_01.attacker == self)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
track_ownership()
{
	self endon("death");
	wait 0.05;
	for(;;)
	{
		self waittill("armory_opened",var_00);
		for(;;)
		{
			foreach(var_02 in level.armory[var_00.armory_type])
			{
				var_03 = get_ownership_val(var_02.ref);
				set_ownership(var_02.type,var_02.ref,var_03);
			}

			if(var_00.armory_type == "weapon")
			{
				foreach(var_02 in level.armory["weaponupgrade"])
				{
					var_03 = get_ownership_val(var_02.ref);
					set_ownership(var_02.type,var_02.ref,var_03);
				}
			}

			var_07 = common_scripts\utility::waittill_any_timeout(0.05,"armory_closed","new_weapon_selected");
			if(var_07 == "armory_closed")
			{
				break;
			}
		}
	}
}

//Function Number: 31
set_ownership(param_00,param_01,param_02)
{
	maps\_specialops::_setplayerdata_array("armory" + param_00,param_01,param_02);
}

//Function Number: 32
claymoresentientfunc(param_00)
{
	self makeentitysentient(param_00,1);
	self.attackeraccuracy = 2;
	self.maxvisibledist = 356;
	self.threatbias = -1000;
	self.detonateradius = 96;
}

//Function Number: 33
has_open_slot_right()
{
	var_00 = self getweaponhudiconoverride("actionslot4");
	if(isdefined(var_00) && var_00 != "none")
	{
		return 0;
	}

	if(self hasweapon("air_support_strobe"))
	{
		return 0;
	}

	return !maps\_sp_killstreaks::has_any_killstreak();
}

//Function Number: 34
hint_bubble()
{
}

//Function Number: 35
item_exist(param_00)
{
	return isdefined(level.armory_all_items) && isdefined(level.armory_all_items[param_00]);
}

//Function Number: 36
get_index(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].idx;
	}

	return int(tablelookup("sp/survival_armories.csv",1,param_00,0));
}

//Function Number: 37
get_ref_by_index(param_00)
{
	return tablelookup("sp/survival_armories.csv",0,param_00,1);
}

//Function Number: 38
get_icon(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].icon;
	}

	return tablelookup("sp/survival_armories.csv",1,param_00,6);
}

//Function Number: 39
get_slot(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].slot;
	}

	return tablelookup("sp/survival_armories.csv",1,param_00,2);
}

//Function Number: 40
get_type(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].type;
	}

	return tablelookup("sp/survival_armories.csv",1,param_00,2);
}

//Function Number: 41
get_sub_type(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].sub_type;
	}

	return tablelookup("sp/survival_armories.csv",1,param_00,11);
}

//Function Number: 42
get_maxstock(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].maxstock;
	}

	return int(tablelookup("sp/survival_armories.csv",1,param_00,10));
}

//Function Number: 43
get_upgrades_possible(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].upgrades;
	}

	var_01 = tablelookup("sp/survival_armories.csv",1,param_00,8);
	var_01 = strtok(var_01," ");
	return var_01;
}

//Function Number: 44
get_name(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].name;
	}

	return tablelookup("sp/survival_armories.csv",1,param_00,4);
}

//Function Number: 45
get_desc(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].var_189B;
	}

	return tablelookup("sp/survival_armories.csv",1,param_00,5);
}

//Function Number: 46
get_cost(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].cost;
	}

	return int(tablelookup("sp/survival_armories.csv",1,param_00,3));
}

//Function Number: 47
get_unlock_rank(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].unlockrank;
	}

	return int(tablelookup("sp/survival_armories.csv",1,param_00,7));
}

//Function Number: 48
is_item_enabled(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].enabled;
	}

	var_01 = tablelookup("sp/survival_armories.csv",1,param_00,9);
	if(!isdefined(var_01) || var_01 == "")
	{
		return 1;
	}

	if(!issubstr(var_01,level.script))
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
get_item_drop_stock(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].dropstock;
	}

	return int(strtok(tablelookup("sp/survival_armories.csv",1,param_00,9)," ")[1]);
}

//Function Number: 50
get_item_drop_clip(param_00)
{
	if(item_exist(param_00))
	{
		return level.armory_all_items[param_00].dropclip;
	}

	return int(strtok(tablelookup("sp/survival_armories.csv",1,param_00,9)," ")[0]);
}

//Function Number: 51
armory_can_give(param_00)
{
	var_01 = level.armory_all_items[param_00];
	if(!isdefined(var_01))
	{
		return 0;
	}

	return self [[ var_01.func_can_give ]](param_00);
}

//Function Number: 52
armory_give(param_00)
{
	var_01 = level.armory_all_items[param_00];
	self [[ var_01.func_give ]](param_00);
}

//Function Number: 53
get_func_can_give(param_00,param_01)
{
	if(item_exist(param_01))
	{
		return level.armory_all_items[param_01].func_can_give;
	}

	var_02 = ::can_give_default;
	if(param_00 == "weapon")
	{
		if(param_01 == "ammo")
		{
			var_02 = ::can_give_ammo;
		}
		else
		{
			var_02 = ::can_give_weapon;
		}
	}
	else if(param_00 == "weaponupgrade")
	{
		var_02 = ::can_give_weapon_upgrade;
	}
	else if(param_00 == "equipment")
	{
		switch(param_01)
		{
			case "flash_grenade":
			case "fraggrenade":
					var_02 = ::can_give_grenade;
					break;

			case "c4":
			case "claymore":
					var_02 = ::can_give_slotted_explosive;
					break;

			case "rpg_survival":
					var_02 = ::can_give_launcher;
					break;

			case "iw5_riotshield_so_upgrade":
			case "iw5_riotshield_so":
					var_02 = ::can_give_riotshield_so;
					break;

			case "sentry_gl":
			case "sentry":
					var_02 = ::can_give_sentry;
					break;

			case "juggernaut_suit":
			case "armor":
					var_02 = ::can_give_armor;
					break;

			case "laststand":
					var_02 = ::can_give_laststand;
					break;

			default:
					break;
		}
	}
	else if(param_00 == "airsupport")
	{
		switch(param_01)
		{
			case "remote_missile":
						var_02 = ::can_give_remote_missile;
						break;

			case "friendly_support_riotshield":
			case "friendly_support_delta":
						var_02 = ::can_give_friendlies;
						break;

			case "precision_airstrike":
						var_02 = ::can_give_airstrike;
						break;

			case "manned_chopper":
			case "assault_chopper":
						var_02 = ::can_give_chopper;
						break;

			case "specialty_bulletaccuracy":
			case "specialty_detectexplosive":
			case "specialty_quickdraw":
			case "specialty_fastreload":
			case "specialty_longersprint":
			case "specialty_stalker":
						var_02 = ::can_give_perk_care_package;
						break;

			default:
						break;
		}
	}
	else
	{
	}

	return var_02;
}

//Function Number: 54
get_func_give(param_00,param_01)
{
	if(item_exist(param_01))
	{
		return level.armory_all_items[param_01].func_give;
	}

	var_02 = ::give_default;
	if(param_00 == "weapon")
	{
		if(param_01 == "ammo")
		{
			var_02 = ::give_ammo;
		}
		else
		{
			var_02 = ::give_weapon;
		}
	}
	else if(param_00 == "weaponupgrade")
	{
		var_02 = ::give_weapon_upgrade;
	}
	else if(param_00 == "equipment")
	{
		switch(param_01)
		{
			case "flash_grenade":
			case "fraggrenade":
					var_02 = ::give_grenade;
					break;

			case "c4":
			case "claymore":
					var_02 = ::give_slotted_explosive;
					break;

			case "rpg_survival":
					var_02 = ::give_launcher;
					break;

			case "iw5_riotshield_so_upgrade":
			case "iw5_riotshield_so":
					var_02 = ::give_riotshield_so;
					break;

			case "sentry_gl":
			case "sentry":
					var_02 = ::give_sentry;
					break;

			case "juggernaut_suit":
			case "armor":
					var_02 = ::give_armor;
					break;

			case "laststand":
					var_02 = ::give_laststand;
					break;

			default:
					break;
		}
	}
	else if(param_00 == "airsupport")
	{
		switch(param_01)
		{
			case "remote_missile":
						var_02 = ::give_remote_missile;
						break;

			case "friendly_support_riotshield":
			case "friendly_support_delta":
						var_02 = ::give_friendlies;
						break;

			case "precision_airstrike":
						var_02 = ::give_airstrike;
						break;

			case "manned_chopper":
			case "assault_chopper":
						var_02 = ::give_chopper;
						break;

			case "specialty_bulletaccuracy":
			case "specialty_detectexplosive":
			case "specialty_quickdraw":
			case "specialty_fastreload":
			case "specialty_longersprint":
			case "specialty_stalker":
						var_02 = ::give_perk_care_package;
						break;

			default:
						break;
		}
	}
	else
	{
	}

	return var_02;
}

//Function Number: 55
can_give_default(param_00)
{
	return 0;
}

//Function Number: 56
give_default(param_00)
{
}

//Function Number: 57
can_give_ammo(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(weaponclass(var_03) == "rocketlauncher" || weaponclass(var_03) == "item" || weaponclass(var_03) == "none")
		{
			continue;
		}

		if(self getweaponammoclip(var_03) < weaponclipsize(var_03) || self getweaponammostock(var_03) < weaponmaxammo(var_03))
		{
			return 1;
		}

		var_04 = weaponaltweaponname(var_03);
		if((var_04 != "none" && self getweaponammoclip(var_04) < weaponclipsize(var_04)) || self getweaponammostock(var_04) < weaponmaxammo(var_04))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 58
give_ammo(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 == "rpg_survival")
		{
			continue;
		}

		give_ammo_max(var_03);
	}
}

//Function Number: 59
give_ammo_max(param_00)
{
	if(weaponinventorytype(param_00) == "altmode")
	{
		param_00 = get_weapon_name_from_alt(param_00);
	}

	self setweaponammoclip(param_00,weaponclipsize(param_00));
	self setweaponammostock(param_00,weaponmaxammo(param_00));
	var_01 = weaponaltweaponname(param_00);
	if(var_01 != "none")
	{
		self setweaponammoclip(var_01,weaponclipsize(var_01));
		self setweaponammostock(var_01,weaponmaxammo(var_01));
	}
}

//Function Number: 60
can_give_weapon(param_00)
{
	var_01 = weaponclass(param_00);
	var_02 = 0;
	var_03 = self getweaponslistprimaries();
	foreach(var_05 in var_03)
	{
		if(weaponclass(var_05) == var_01)
		{
			var_02 = 1;
			break;
		}
	}

	if(var_02 == 0)
	{
		return 1;
	}

	var_07 = get_weapon_base_name(param_00);
	foreach(var_05 in var_03)
	{
		if(weaponclass(var_05) == "rocketlauncher" || weaponclass(var_05) == "item" || weaponclass(var_05) == "none")
		{
			continue;
		}

		var_09 = get_weapon_base_name(var_05);
		if(var_09 == var_07)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 61
give_weapon(param_00,param_01)
{
	var_02 = get_replaceable_weapon();
	if(isdefined(var_02))
	{
		self takeweapon(var_02);
	}

	self giveweapon(param_00);
	if(!isdefined(param_01))
	{
		give_ammo_max(param_00);
	}

	self switchtoweapon(param_00);
}

//Function Number: 62
get_replaceable_weapon()
{
	var_00 = self getweaponslistprimaries();
	if(var_00.size > 1)
	{
		var_01 = self getcurrentweapon();
		if(weaponinventorytype(var_01) == "altmode")
		{
			var_01 = get_weapon_name_from_alt(var_01);
		}

		if(isdefined(var_01) && weaponinventorytype(var_01) == "primary")
		{
			return var_01;
		}
		else
		{
			var_02 = self getweaponslist("primary");
			foreach(var_04 in var_02)
			{
				if(weaponclass(var_04) != "item")
				{
					return var_04;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 63
can_give_weapon_upgrade(param_00)
{
	var_01 = undefined;
	if(isdefined(self.selected_weapon))
	{
		var_01 = self.selected_weapon;
	}
	else
	{
		var_01 = self getcurrentweapon();
	}

	if(weaponinventorytype(var_01) == "altmode")
	{
		var_01 = get_weapon_name_from_alt(var_01);
	}

	if(!isdefined(var_01) || var_01 == "none" || weaponinventorytype(var_01) != "primary" || weaponclass(var_01) == "item" || weaponclass(var_01) == "rocketlauncher" || weaponclass(var_01) == "none")
	{
		return 0;
	}

	var_02 = get_weapon_base_name(var_01);
	var_03 = get_upgrades_possible(var_02);
	if(!var_03.size)
	{
		return 0;
	}

	var_04 = 0;
	foreach(var_06 in var_03)
	{
		if(param_00 == var_06)
		{
			var_04 = 1;
			break;
		}
	}

	if(!var_04)
	{
		return 0;
	}

	var_08 = get_upgrades_on_weapon(var_01);
	foreach(var_06 in var_08)
	{
		if(param_00 == var_06)
		{
			return 2;
		}
	}

	return 1;
}

//Function Number: 64
give_weapon_upgrade(param_00)
{
	var_01 = self getcurrentweapon();
	if(isdefined(self.selected_weapon))
	{
		var_01 = self.selected_weapon;
	}

	if(weaponinventorytype(var_01) == "altmode")
	{
		var_01 = get_weapon_name_from_alt(var_01);
	}

	if(!isdefined(var_01) || weaponinventorytype(var_01) != "primary")
	{
		return;
	}

	var_02 = get_upgrades_on_weapon(var_01);
	var_03 = undefined;
	var_04 = get_slot(param_00);
	if(var_02.size)
	{
		foreach(var_06 in var_02)
		{
			if(var_04 == get_slot(var_06))
			{
				var_03 = var_06;
				break;
			}
		}
	}

	if(isdefined(var_03))
	{
		foreach(var_09, var_06 in var_02)
		{
			if(var_06 == var_03)
			{
				var_02[var_09] = param_00;
				break;
			}
		}
	}
	else
	{
		var_02[var_02.size] = param_00;
	}

	var_0A = get_weapon_base_name(var_01);
	var_0B = var_0A;
	while(var_02.size > 0)
	{
		var_0C = var_02[0];
		for(var_0D = 1;var_0D < var_02.size;var_0D++)
		{
			if(common_scripts\utility::is_later_in_alphabet(var_0C,var_02[var_0D]))
			{
				var_0C = var_02[var_0D];
			}
		}

		var_0B = var_0B + "_" + get_attachment_fullname(var_0C,var_0A);
		var_02 = common_scripts\utility::array_remove(var_02,var_0C);
	}

	var_0E = self getweaponammoclip(var_01);
	var_0F = self getweaponammostock(var_01);
	var_10 = undefined;
	var_11 = undefined;
	var_12 = weaponaltweaponname(var_01);
	if(var_12 != "none")
	{
		var_10 = self getweaponammoclip(var_12);
		var_11 = self getweaponammostock(var_12);
	}

	self takeweapon(var_01);
	self giveweapon(var_0B);
	self setweaponammoclip(var_0B,var_0E);
	self setweaponammostock(var_0B,var_0F);
	var_13 = weaponaltweaponname(var_0B);
	if(var_13 != "none")
	{
		if(var_04 != "main")
		{
			self setweaponammoclip(var_13,var_10);
			self setweaponammostock(var_13,var_11);
		}
		else
		{
			self setweaponammoclip(var_13,weaponclipsize(var_13));
			self setweaponammostock(var_13,weaponmaxammo(var_13));
		}
	}

	lib_0623::func_3F07(var_0B);
	self switchtoweapon(var_0B);
}

//Function Number: 65
get_attachment_fullname(param_00,param_01)
{
	var_02 = get_sub_type(param_01);
	switch(var_02)
	{
		case "smg":
			if(param_00 == "reflex")
			{
				return "reflexsmg";
			}
			else if(param_00 == "eotech")
			{
				return "eotechsmg";
			}
			else if(param_00 == "acog")
			{
				return "acogsmg";
			}
			else if(param_00 == "thermal")
			{
				return "thermalsmg";
			}
	
			break;

		case "lmg":
			if(param_00 == "reflex")
			{
				return "reflexlmg";
			}
			else if(param_00 == "eotech")
			{
				return "eotechlmg";
			}
	
			break;

		case "machinepistol":
			if(param_00 == "reflex")
			{
				return "reflexsmg";
			}
			else if(param_00 == "eotech")
			{
				return "eotechsmg";
			}
	
			break;

		default:
			return param_00;
	}
}

//Function Number: 66
get_attachment_basename(param_00)
{
	if(issubstr(param_00,"reflex"))
	{
		return "reflex";
	}

	if(issubstr(param_00,"eotech"))
	{
		return "eotech";
	}

	if(issubstr(param_00,"acog"))
	{
		return "acog";
	}

	if(issubstr(param_00,"reflex"))
	{
		return "reflex";
	}

	return param_00;
}

//Function Number: 67
get_weapon_base_name(param_00)
{
	var_01 = undefined;
	var_02 = 0;
	var_03 = undefined;
	if(weaponinventorytype(param_00) == "altmode")
	{
		var_02 = 4;
	}

	for(var_04 = var_02 + 4;var_04 < param_00.size;var_04++)
	{
		if(param_00[var_04] == "_")
		{
			var_03 = var_04 + 3;
			break;
		}
	}

	var_01 = getsubstr(param_00,var_02,var_03);
	return var_01;
}

//Function Number: 68
get_upgrades_on_weapon(param_00)
{
	var_01 = [];
	var_02 = get_weapon_base_name(param_00);
	if(var_02 == param_00)
	{
		return var_01;
	}

	var_03 = getsubstr(param_00,var_02.size);
	var_04 = strtok(var_03,"_");
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_04[var_05] = get_attachment_basename(var_04[var_05]);
	}

	return var_04;
}

//Function Number: 69
get_weapon_name_from_alt(param_00)
{
	if(weaponinventorytype(param_00) != "altmode")
	{
		return param_00;
	}

	return getsubstr(param_00,4);
}

//Function Number: 70
can_give_grenade(param_00)
{
	var_01 = get_maxstock(param_00);
	return self getweaponammostock(param_00) < var_01;
}

//Function Number: 71
give_grenade(param_00)
{
	if(!self hasweapon(param_00))
	{
		self giveweapon(param_00);
	}

	if(issubstr(param_00,"flash") && self getoffhandprimaryclass() != "flash")
	{
		self setoffhandsecondaryclass("flash");
	}

	var_01 = get_maxstock(param_00);
	self setweaponammostock(param_00,var_01);
}

//Function Number: 72
can_give_launcher(param_00)
{
	if(self hasweapon(param_00))
	{
		if(param_00 == "rpg_survival")
		{
			var_01 = self getweaponammoclip("rpg_survival") + self getweaponammostock("rpg_survival");
			return get_maxstock("rpg_survival") > var_01;
		}
	}

	return 1;
}

//Function Number: 73
can_give_slotted_explosive(param_00)
{
	if(self hasweapon(param_00))
	{
		if(param_00 == "claymore")
		{
			var_01 = self getweaponammostock(param_00);
			return get_maxstock(param_00) != var_01;
		}

		if(var_01 == "c4")
		{
			var_01 = self getweaponammostock(var_01);
			return get_maxstock(param_00) != var_01;
		}
	}

	return 1;
}

//Function Number: 74
give_launcher(param_00)
{
	if(!self hasweapon(param_00))
	{
		if(param_00 == "rpg_survival")
		{
			give_weapon("rpg_survival",1);
			self setweaponammoclip("rpg_survival",1);
			self setweaponammostock("rpg_survival",1);
			return;
		}

		return;
	}

	if(param_00 == "rpg_survival")
	{
		var_01 = self getweaponammoclip(param_00) + self getweaponammostock(param_00);
		var_02 = 1;
		var_03 = int(min(1 + var_01,get_maxstock(param_00) - 1));
		self setweaponammoclip("rpg_survival",var_02);
		self setweaponammostock("rpg_survival",var_03);
		self switchtoweapon("rpg_survival");
	}
}

//Function Number: 75
give_slotted_explosive(param_00)
{
	var_01 = 5;
	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	if(!self hasweapon(param_00))
	{
		if(param_00 == "claymore")
		{
			var_04 = 1;
		}
		else if(param_00 == "c4")
		{
			var_04 = 2;
		}

		self giveweapon(param_00);
		self setactionslot(var_04,"weapon",param_00);
	}
	else
	{
		var_02 = self getweaponammostock(param_00);
	}

	self setweaponammostock(param_00,var_02 + var_01 - var_03);
}

//Function Number: 76
can_give_riotshield_so(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"riotshield"))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 77
give_riotshield_so(param_00)
{
	give_weapon(param_00,1);
}

//Function Number: 78
can_give_sentry(param_00)
{
	if(!has_open_slot_right())
	{
		return 0;
	}

	if(maps\_utility::is_coop())
	{
		return !has_sentry() && get_total_sentries() < 2;
	}

	return get_total_sentries() < 2;
}

//Function Number: 79
give_sentry(param_00)
{
	thread maps\_sp_killstreaks::give_sp_killstreak(param_00);
}

//Function Number: 80
can_give_armor(param_00)
{
	if(!isdefined(self.armor))
	{
		return 1;
	}

	var_01 = 0;
	if(param_00 == "armor")
	{
		var_01 = 250;
	}
	else if(param_00 == "juggernaut_suit")
	{
		var_01 = 500;
	}

	if(self.armor["points"] < var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 81
give_armor(param_00)
{
	give_armor_amount(param_00);
}

//Function Number: 82
armor_init()
{
	self.max_armor_points = 0;
	self.armor = [];
	self.armor["type"] = "";
	self.armor["points"] = 0;
	thread player_armor_shield();
}

//Function Number: 83
give_armor_amount(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		if(param_00 == "armor")
		{
			param_01 = 250;
		}
		else if(param_00 == "juggernaut_suit")
		{
			param_01 = 500;
		}
		else
		{
			return;
		}
	}

	if(!isdefined(self.armor))
	{
		armor_init();
	}

	self.dogs_dont_instant_kill = 1;
	self.armor["type"] = param_00;
	self.armor["points"] = param_01;
	self.max_armor_points = param_01;
	self notify("health_update");
}

//Function Number: 84
player_armor_shield()
{
	self endon("death");
	if(isdefined(self.armor_shield_on))
	{
		return;
	}

	self.armor_shield_on = 1;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		self.previous_health = int(min(100,self.health + var_00));
		self.saved_by_armor = 0;
		if(self.armor["points"] > 0)
		{
			self.saved_by_armor = 1;
			var_0A = self.armor["points"] - var_00;
			var_0B = int(max(0,0 - var_0A));
			if(!var_0B)
			{
				self.armor["points"] = self.armor["points"] - var_00;
				self setnormalhealth(1);
			}
			else
			{
				var_0C = maps\_so_survival_code::int_capped(self.previous_health - var_0B,1,100) / 100;
				self setnormalhealth(var_0C);
				if(self.armor["points"] + self.previous_health <= var_00)
				{
					self.saved_by_armor = 0;
				}

				self.armor["points"] = 0;
			}

			if(self.armor["points"] <= 0)
			{
				self.dogs_dont_instant_kill = undefined;
			}

			self notify("health_update");
		}
	}
}

//Function Number: 85
can_give_laststand(param_00)
{
	return maps\_laststand::get_lives_remaining() == 0;
}

//Function Number: 86
give_laststand(param_00)
{
	maps\_laststand::update_lives_remaining(1);
}

//Function Number: 87
can_give_remote_missile(param_00)
{
	return has_open_slot_right();
}

//Function Number: 88
give_remote_missile(param_00)
{
	thread maps\_sp_killstreaks::give_sp_killstreak(param_00);
}

//Function Number: 89
can_give_friendlies(param_00)
{
	if(!has_open_slot_right())
	{
		return 0;
	}

	var_01 = getaiarray("allies");
	foreach(var_03 in var_01)
	{
		if(isalive(var_03) && isdefined(var_03.owner) && var_03.owner == self)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 90
give_friendlies(param_00)
{
	thread give_friendlies_monitor_use(param_00);
}

//Function Number: 91
give_friendlies_monitor_use(param_00)
{
	self endon("death");
	var_01 = "specops_ui_deltasupport";
	if(param_00 == "friendly_support_delta")
	{
		var_01 = "specops_ui_deltasupport";
	}

	if(param_00 == "friendly_support_riotshield")
	{
		var_01 = "specops_ui_riotshieldsupport";
	}

	self setweaponhudiconoverride("actionslot4",var_01);
	notifyoncommand("friendly_support_called","+actionslot 4");
	self waittill("friendly_support_called");
	lib_0623::spawn_allies(self.origin,param_00,self);
	self setweaponhudiconoverride("actionslot4","none");
}

//Function Number: 92
can_give_airstrike(param_00)
{
	return !self hasweapon("air_support_strobe");
}

//Function Number: 93
give_airstrike(param_00)
{
	thread maps\_air_support_strobe::enable_strobes_for_player();
	thread sticky_strobe();
	thread disable_strobe_for_player();
}

//Function Number: 94
sticky_strobe()
{
	level endon("special_op_terminated");
	self endon("death");
	self endon("strobe_timeout");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_00.sticky = 0;
		if(var_01 != "air_support_strobe")
		{
			continue;
		}

		var_02 = getaispeciesarray("axis","all");
		foreach(var_04 in var_02)
		{
			if(isai(var_04) && isalive(var_04))
			{
				var_04 thread watch_for_strobe_hit();
			}
		}

		if(isdefined(level.bosses) && level.bosses.size)
		{
			foreach(var_07 in level.bosses)
			{
				if(isdefined(var_07.vehicletype))
				{
					var_07 thread watch_for_strobe_hit();
				}
			}
		}

		thread strobe_timeout();
		self waittill("strobe_stuck_on_ai",var_09);
		var_00.sticky = 1;
		if(isdefined(var_09))
		{
			if(isai(var_09))
			{
				var_00.origin = var_09 gettagorigin("j_mainroot");
				var_00 linkto(var_09,"j_mainroot");
			}
			else
			{
				var_00.origin = var_09.origin;
				var_00 linkto(var_09);
			}

			for(;;)
			{
				var_09 waittill("death");
				if(isdefined(var_00))
				{
					var_00 unlink();
				}

				return;
			}
		}
	}
}

//Function Number: 95
strobe_timeout()
{
	self endon("strobe_stuck_on_ai");
	wait 5;
	self notify("strobe_timeout");
}

//Function Number: 96
watch_for_strobe_hit()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isdefined(var_09) || !isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		if(var_09 == "air_support_strobe")
		{
			var_01 notify("strobe_stuck_on_ai",self);
			return;
		}
	}
}

//Function Number: 97
disable_strobe_for_player()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		level waittill("air_suport_strobe_fired_upon",var_00);
		if(var_00.owner == self && !self hasweapon("air_support_strobe"))
		{
			thread maps\_air_support_strobe::disable_strobes_for_player();
			return;
		}
	}
}

//Function Number: 98
can_give_chopper(param_00)
{
	return 0;
}

//Function Number: 99
give_chopper(param_00)
{
}

//Function Number: 100
can_give_perk_care_package(param_00)
{
	if(self hasperk(param_00,1))
	{
		return 0;
	}

	return has_open_slot_right();
}

//Function Number: 101
give_perk_care_package(param_00)
{
	thread maps\_sp_killstreaks::give_sp_killstreak(param_00);
}

//Function Number: 102
get_item_ent(param_00,param_01)
{
	var_02 = "called get_item_ent() before armory tables are built!";
	if(isdefined(param_01))
	{
		return level.armory[param_01][param_00];
	}

	return level.armory_all_items[param_00];
}

//Function Number: 103
is_item_locked(param_00)
{
	var_01 = param_00.unlockrank;
	var_02 = maps\_rank::getrank();
	return var_02 >= var_01;
}

//Function Number: 104
can_afford(param_00)
{
	return self.survival_credit >= param_00.cost;
}