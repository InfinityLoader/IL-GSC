/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_boat.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 2585 ms
 * Timestamp: 10/27/2023 12:06:10 AM
*******************************************************************/

//Function Number: 1
func_96A9()
{
	level.var_B652 = ::func_13F12;
	level.var_2BFA = getvehiclenode("boat_start_struct","targetname");
	level.var_2BFB = spawnvehicle("cp_rave_pap_boat_animated","boat","cp_rave_boat",level.var_2BFA.origin,level.var_2BFA.angles);
	level.var_2BFB attachpath(level.var_2BFA);
	level.var_2BFB.var_AD27 = [];
	scripts\common\utility::flag_init("packboat_started");
	scripts\common\utility::flag_init("pap_fixed");
	scripts\common\utility::flag_init("disable_portals");
	scripts\common\utility::flag_init("fuses_inserted");
	scripts\common\utility::flag_init("pap_portal_used");
	level.var_2BFB method_8318(0);
	level.var_2BFB.var_246B = getentarray(level.var_2BFA.target,"targetname");
	foreach(var_01 in level.var_2BFB.var_246B)
	{
		var_01 linkto(level.var_2BFB);
	}

	level.var_2BFB method_8187("tag_motor");
	wait(1);
	level.var_2BFD = scripts\common\utility::getstructarray("boat_water_spawners","targetname");
}

//Function Number: 2
activate_pap(param_00)
{
	var_01 = level._effect["vfx_rave_pap_room_portal"];
	var_02 = scripts\common\utility::getstruct("porta_effect_location","targetname");
	var_02.script_noteworthy = "pap_portal";
	var_02.var_D674 = 1;
	var_02.var_E1B9 = 0;
	var_02.var_D776 = 1;
	var_02.var_EE79 = "default";
	var_02.var_4C72 = 96;
	scripts\cp\_interaction::add_to_current_interaction_list(var_02);
	level thread func_1298D();
	var_03 = scripts\common\utility::getstruct("projector_fx_struct","targetname");
	var_04 = spawnfx(level._effect["projector_light"],var_03.origin,anglestoforward(var_03.angles),anglestoup(var_03.angles));
	var_05 = spawnfx(var_01,var_02.origin,anglestoforward(var_02.angles),anglestoup(var_02.angles));
	wait(0.5);
	triggerfx(var_04);
	scripts\common\utility::func_5127(0.05,::scripts\common\utility::play_loopsound_in_space,"zmb_packapunch_machine_idle_lp",var_03.origin);
	wait(0.5);
	triggerfx(var_05);
	playsoundatpos(var_02.origin,"zmb_portal_powered_on_activate");
	scripts\common\utility::func_5127(0.5,::scripts\common\utility::play_loopsound_in_space,"zmb_portal_powered_on_activate_lp",var_02.origin);
}

//Function Number: 3
func_1298D()
{
	var_00 = getent("hidden_room_portal","targetname");
	var_01 = anglestoforward(var_00.angles);
	var_02 = spawnfx(level._effect["vfx_slasher_cabin"],var_00.origin,var_01);
	thread scripts\common\utility::play_loopsound_in_space("zmb_portal_powered_on_activate_lp",var_00.origin);
	triggerfx(var_02);
	func_11627(var_00);
}

//Function Number: 4
func_11627(param_00)
{
	param_00 makeusable();
	param_00 sethintstring(&"CP_RAVE_HIDDEN_LEAVE");
	param_00.var_D67A = 1;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01.kicked_out))
		{
			var_01 notify("left_hidden_room_early");
			var_01.disable_consumables = 1;
			func_8E60(var_01);
		}

		wait(0.1);
	}
}

//Function Number: 5
pap_portal_hint_logic(param_00,param_01)
{
	if(scripts\common\utility::flag("disable_portals"))
	{
		return "";
	}

	if(isdefined(param_00.var_4622))
	{
		return &"COOP_INTERACTIONS_COOLDOWN";
	}

	return &"CP_RAVE_HIDDEN_TELEPORT";
}

//Function Number: 6
pap_portal_use_func(param_00,param_01)
{
	if(scripts\common\utility::flag("disable_portals"))
	{
		return;
	}

	if(!param_01 scripts\cp\_utility::isteleportenabled())
	{
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	param_01 thread func_5591(param_01,0.5,"fast_travel_complete");
	param_00 thread func_126BE(param_01);
	param_00 thread pap_portal_cooldown(param_00);
}

//Function Number: 7
pap_portal_cooldown(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_cool_down))
	{
		return;
	}

	param_00.in_cool_down = 1;
	wait(31);
	param_00.var_4622 = 1;
	wait(60);
	param_00.in_cool_down = undefined;
	param_00.var_4622 = undefined;
}

//Function Number: 8
func_126BE(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00 notify("delete_equipment");
	param_00.disable_consumables = 1;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = func_BC83(param_00,"hidden_travel_tube_start","hidden_travel_tube_end");
	param_00 func_11648();
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_01 delete();
}

//Function Number: 9
func_11648()
{
	self endon("left_hidden_room_early");
	set_in_pap_room(self,1);
	scripts\cp\_utility::func_17C0("papRoom",0,0);
	self.var_9C54 = 1;
	self.disable_consumables = undefined;
	var_00 = scripts\common\utility::getstruct("hidden_room_spot","targetname");
	self unlink();
	self dontinterpolate();
	scripts\cp\powers\coop_powers::func_D72E();
	self setorigin(var_00.origin);
	self setplayerangles(var_00.angles);
	self method_8447();
	thread func_8E64();
	level notify("hidden_room_portal_used");
	scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(self);
}

//Function Number: 10
func_C8A9()
{
	self endon("disconnect");
	if(!isdefined(self.var_C8A8))
	{
		self.var_C8A8 = 1;
		var_00 = 30;
		self setclientomnvar("zombie_papTimer",var_00);
		wait(1);
		for(;;)
		{
			var_00--;
			if(var_00 < 0)
			{
				var_00 = 30;
				wait(1);
				break;
			}

			self setclientomnvar("zombie_papTimer",var_00);
			wait(1);
		}

		self setclientomnvar("zombie_papTimer",-1);
		self notify("kicked_out");
		wait(30);
		self.var_C8A8 = undefined;
	}
}

//Function Number: 11
func_8E60(param_00)
{
	param_00 endon("disconnect");
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = func_BC83(param_00,"hidden_travel_tube_end","hidden_travel_tube_start",1);
	func_1164E(param_00);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_01 delete();
	if(scripts\common\utility::istrue(param_00.var_13DB4))
	{
		param_00 lib_0D12::func_6978(1);
		param_00.var_13DB4 = 0;
	}

	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00 set_in_pap_room(param_00,0);
	param_00 notify("fast_travel_complete");
	scripts\cp\_vo::func_E01F("ww_pap_nag");
	scripts\cp\_vo::func_E01F("nag_find_pap");
}

//Function Number: 12
set_in_pap_room(param_00,param_01)
{
	param_00.is_in_pap = param_01;
}

//Function Number: 13
func_1164E(param_00)
{
	var_01 = scripts\common\utility::getstructarray(scripts\common\utility::getstruct("porta_effect_location","targetname").target,"targetname");
	var_02 = undefined;
	while(!isdefined(var_02))
	{
		foreach(var_04 in var_01)
		{
			if(!positionwouldtelefrag(var_04.origin))
			{
				var_02 = var_04;
			}
		}

		if(!isdefined(var_02))
		{
			var_06 = scripts\cp\_utility::func_13192(anglestoforward(var_01[0].angles,64));
			var_02 = var_01[0].origin + var_06;
		}

		wait(0.1);
	}

	param_00 method_8447();
	param_00 unlink();
	param_00 dontinterpolate();
	param_00 setorigin(var_02.origin);
	param_00 setplayerangles(var_02.angles);
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
}

//Function Number: 14
func_8E64()
{
	self endon("left_hidden_room_early");
	self endon("disconnect");
	self endon("last_stand");
	self.kicked_out = undefined;
	if(!scripts\common\utility::flag("pap_portal_used"))
	{
		scripts\common\utility::flag_set("pap_portal_used");
	}

	thread func_C8A9();
	level thread pap_vo(self);
	self waittill("kicked_out");
	self.kicked_out = 1;
	level thread func_8E60(self);
}

//Function Number: 15
pap_vo(param_00)
{
	if(level.var_C8A3 != 1)
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("pap_room_first","rave_pap_vo");
	}

	level.var_C8A3 = 1;
	wait(4);
	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_pap_nag","rave_pap_vo","high",undefined,undefined,undefined,1);
}

//Function Number: 16
func_BC83(param_00,param_01,param_02,param_03)
{
	param_00 earthquakeforplayer(0.3,0.2,param_00.origin,200);
	var_04 = getent(param_01,"targetname");
	var_05 = getent(param_02,"targetname");
	param_00 cancelmantle();
	param_00.var_C004 = 1;
	param_00.var_C016 = 1;
	var_06 = var_04.origin + (0,0,-45);
	var_07 = var_05.origin + (0,0,-45);
	param_00.var_9BE1 = 1;
	param_00 scripts\cp\_utility::func_17C0("fast_travel",0,0);
	param_00 scripts\cp\_utility::func_1C5C(1);
	param_00 dontinterpolate();
	param_00 setorigin(var_06);
	param_00 setplayerangles(var_04.angles);
	param_00 playlocalsound("zmb_portal_travel_lr");
	var_08 = spawn("script_origin",var_06);
	param_00 playerlinkto(var_08);
	param_00 method_8232();
	wait(0.1);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	var_08 moveto(var_07,1);
	wait(1);
	param_00.var_9BE1 = undefined;
	param_00 scripts\cp\_utility::func_E0E6("fast_travel",0);
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	param_00.var_9BE1 = undefined;
	param_00.var_C004 = 0;
	param_00.var_C016 = 0;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	return var_08;
}

//Function Number: 17
func_5591(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 scripts\cp\_utility::allow_player_teleport(0);
	param_00 waittill(param_02);
	wait(param_01);
	if(!param_00 scripts\cp\_utility::isteleportenabled())
	{
		param_00 scripts\cp\_utility::allow_player_teleport(1);
	}

	param_00 notify("can_teleport");
}

//Function Number: 18
packboat_hint_func(param_00,param_01)
{
	if(level.boat_pieces_found < 3)
	{
		return "";
	}

	return &"CP_RAVE_USEBOAT";
}

//Function Number: 19
func_13000(param_00,param_01)
{
	if(level.boat_pieces_found < 3)
	{
		return;
	}

	level scripts\cp\_utility::set_completed_quest_mark(1);
	level.boat_interaction_struct = param_00;
	level.var_2BFB method_8387("tag_motor");
	if(scripts\common\utility::flag("survivor_released"))
	{
		if(!all_players_near_boat(param_00))
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
			level.boat_survivor playsound("ks_nag_needallplayers");
			wait(5);
			scripts\cp\_interaction::add_to_current_interaction_list(param_00);
			return;
		}
		else
		{
			level.boat_survivor notify("stop_boat_nag");
			foreach(var_03 in level.players)
			{
				func_AD0A(var_03,param_00);
			}
		}
	}
	else
	{
		if(isdefined(level.start_boat_ride_func))
		{
			param_00 thread [[ level.start_boat_ride_func ]]();
		}

		param_01 playlocalsound("scn_boatride_board");
		level.var_2BFB thread setup_boat_sounds();
		func_AD0A(param_01,param_00);
	}

	if(isdefined(level.var_2BF1))
	{
		return;
	}

	if(!scripts\common\utility::flag("survivor_released"))
	{
		level thread func_C859();
		scripts\common\utility::flag_wait("packboat_started");
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	func_E21D(param_00);
	if(!isdefined(level.var_C85A))
	{
		if(!scripts\common\utility::flag("survivor_released"))
		{
			level.var_2BFB thread func_C85B(param_00);
		}
		else
		{
			level thread survivor_boat_ride();
		}

		level.var_2BFB startpath();
		level.var_C85A = 1;
		return;
	}

	if(scripts\common\utility::flag("survivor_released"))
	{
		level thread survivor_boat_ride();
		return;
	}

	level notify("boat_used");
}

//Function Number: 20
setup_boat_sounds()
{
	if(!isdefined(level.var_2BFB.sfx_front))
	{
		level.var_2BFB.sfx_front = spawn("script_model",level.var_2BFB.origin);
	}

	if(!isdefined(level.var_2BFB.sfx_rear))
	{
		level.var_2BFB.sfx_rear = spawn("script_model",level.var_2BFB.origin);
	}

	wait(0.05);
	level.var_2BFB.sfx_front linkto(level.var_2BFB,"tag_body");
	level.var_2BFB.sfx_rear linkto(level.var_2BFB,"tag_motor");
	wait(0.05);
	level.var_2BFB.sfx_front playsound("scn_boatride_startup");
	level.var_2BFB.sfx_rear playsound("scn_boatride_startup_lsrs");
	wait(5.15);
	level.var_2BFB thread boatride_sfx();
}

//Function Number: 21
all_players_near_boat(param_00)
{
	var_01 = 19600;
	foreach(var_03 in level.players)
	{
		if(!var_03 scripts\cp\_utility::is_valid_player())
		{
			return 0;
		}

		if(distance2dsquared(var_03.origin,param_00.origin) > var_01)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 22
func_E21D(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03.var_AD26 = undefined;
	}
}

//Function Number: 23
func_AD0A(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstruct("boat_player_" + level.var_2BFB.var_AD27.size,"script_noteworthy");
	var_03.var_AD26 = param_00;
	if(isdefined(param_02))
	{
		var_03 = spawnstruct();
		var_03.origin = level.var_2BFB gettagorigin(param_02);
		var_03.angles = level.var_2BFB gettagangles(param_02);
	}

	level.var_2BFB.var_AD27[level.var_2BFB.var_AD27.size] = param_00;
	param_00 setorigin(var_03.origin);
	param_00 setplayerangles(var_03.angles);
	param_00 playerlinkto(level.var_2BFB,undefined,1,45,45,30,30,0);
	param_00 playerlinkedoffsetenable();
	param_00.ignoreme = 1;
	if(!isdefined(level.var_2BFB.first_player))
	{
		level.var_2BFB.first_player = param_00;
	}

	param_00 method_85B3("seat",1);
	param_00 allowcrouch(1);
	param_00 allowstand(0);
	param_00 allowprone(0);
	param_00 method_8012(0);
	param_00.var_AD2B = 1;
	param_00.disable_consumables = 1;
	param_00.var_9A45 = 1;
	param_00.var_3859 = 0;
	param_00 thread func_2BF3(param_00);
}

//Function Number: 24
func_C85B(param_00)
{
	var_01 = getvehiclenode(level.var_2BFA.target,"targetname");
	for(;;)
	{
		var_01 waittill("trigger");
		if(isdefined(var_01.script_noteworthy))
		{
			switch(var_01.script_noteworthy)
			{
				case "island_stop":
					func_10FBA("island_dropoff_player");
					break;
	
				case "pier_stop":
					func_10FBB(param_00);
					break;
	
				default:
					break;
			}
		}

		if(!isdefined(var_01.target))
		{
			break;
		}

		var_01 = getvehiclenode(var_01.target,"targetname");
	}
}

//Function Number: 25
boatride_sfx()
{
	level endon("boatride_over");
	level endon("gamed_ended");
	if(isdefined(level.var_2BFB.sfx_front))
	{
		level.var_2BFB.sfx_front playsoundonmovingent("scn_boatride_01");
		level.var_2BFB.sfx_rear playsoundonmovingent("scn_boatride_01_lsrs");
	}

	var_00 = getvehiclenode(level.var_2BFA.target,"targetname");
	for(;;)
	{
		var_00 waittill("trigger");
		if(isdefined(var_00.name))
		{
			switch(var_00.name)
			{
				case "rave_boat_sound_2":
					if(isdefined(level.var_2BFB.sfx_front))
					{
						level.var_2BFB.sfx_front playsoundonmovingent("scn_boatride_02");
						level.var_2BFB.sfx_rear playsoundonmovingent("scn_boatride_02_lsrs");
					}
					break;
	
				default:
					break;
			}
		}

		if(!isdefined(var_00.target))
		{
			break;
		}

		var_00 = getvehiclenode(var_00.target,"targetname");
	}
}

//Function Number: 26
func_10FBB(param_00)
{
	level.var_2BFB method_83E6(0,1,1);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	if(isdefined(level.var_2BFB.sfx_front))
	{
		level.var_2BFB.sfx_front delete();
	}

	if(isdefined(level.var_2BFB.sfx_rear))
	{
		level.var_2BFB.sfx_rear delete();
	}

	level.var_2BFB.var_57F3 = 1;
	level waittill("boat_used");
	level.var_2BFB.var_57F3 = 0;
	level.var_2BFB method_8265(3);
}

//Function Number: 27
func_10FBA(param_00)
{
	level.var_2BFB method_83E6(0,1,1);
	wait(1);
	foreach(var_02 in level.var_2BFB.var_AD27)
	{
		level func_5CFB(var_02,param_00);
	}

	if(param_00 == "island_dropoff_player")
	{
		if(isdefined(level.var_2BFB.sfx_front))
		{
			level.var_2BFB.sfx_front playsoundonmovingent("scn_boatride_03");
			level.var_2BFB.sfx_rear playsoundonmovingent("scn_boatride_03_lsrs");
		}

		level.var_2BFB method_8265(3);
	}

	level.var_2BFB.first_player = undefined;
}

//Function Number: 28
func_5CFB(param_00,param_01)
{
	param_00 unlink();
	var_02 = param_00 getentitynumber();
	var_03 = scripts\common\utility::getstructarray(param_01,"targetname");
	var_04 = undefined;
	foreach(var_06 in var_03)
	{
		if(var_06.var_ED3C == var_02)
		{
			var_04 = var_06;
		}
	}

	var_08 = getgroundposition(var_04.origin,8,32,32);
	if(!isdefined(var_08))
	{
		var_08 = var_04.origin;
	}

	param_00 setorigin(var_08 + (0,0,1));
	param_00 setplayerangles(var_04.angles);
	param_00 allowstand(1);
	param_00 allowprone(1);
	param_00 allowcrouch(1);
	param_00 method_8012(1);
	param_00.ignoreme = 0;
	param_00.var_AD2B = undefined;
	param_00.disable_consumables = undefined;
	param_00.var_9A45 = undefined;
	param_00 method_85B3("seat",0);
	level.var_2BFB.var_AD27 = scripts\common\utility::func_22A9(level.var_2BFB.var_AD27,param_00);
	param_00.var_3859 = 1;
	param_00 notify("ride_over");
	level notify("boatride_over");
}

//Function Number: 29
func_2BF3(param_00)
{
	param_00 endon("ride_over");
	param_00 endon("disconnect");
	param_00 waittill("last_stand");
	param_00 unlink();
	var_01 = param_00 getentitynumber();
	var_02 = scripts\common\utility::getstructarray("packboat_player_exit","targetname");
	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		if(var_05.var_ED3C == var_01)
		{
			var_03 = var_05;
		}
	}

	param_00 setorigin(var_03.origin);
	param_00 setplayerangles(var_03.angles);
	param_00 allowstand(1);
	param_00 method_8012(1);
	param_00.ignoreme = 0;
	param_00.var_AD2B = undefined;
	param_00.disable_consumables = undefined;
	param_00.var_9A45 = undefined;
	level.var_2BFB.var_AD27 = scripts\common\utility::func_22A9(level.var_2BFB.var_AD27,param_00);
	param_00.ignoreme = 0;
	param_00.var_3859 = 1;
	param_00 notify("ride_over");
}

//Function Number: 30
func_C859()
{
	level.var_2BF1 = 1;
	wait(5);
	scripts\common\utility::flag_set("packboat_started");
	wait(1);
	scripts\common\utility::func_6E2A("packboat_started");
	level.var_2BF1 = undefined;
}

//Function Number: 31
func_C8A5(param_00,param_01)
{
	if(level.pap_pieces_found < 2)
	{
		return "";
	}

	if(!scripts\common\utility::flag("pap_fixed"))
	{
		return &"CP_RAVE_FIX_PAP";
	}

	return &"CP_RAVE_USE_PAP";
}

//Function Number: 32
func_6DFD(param_00,param_01)
{
	if(level.pap_pieces_found < 2)
	{
		return;
	}

	if(!scripts\common\utility::flag("pap_fixed"))
	{
		scripts\common\utility::flag_set("pap_fixed");
		var_02 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
		foreach(var_04 in var_02)
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(var_04);
		}

		level scripts\cp\_utility::set_completed_quest_mark(3);
		level.projector_struct setmodel("cp_rave_projector_with_reels");
		level thread play_pap_vo(param_01);
		level thread activate_pap(param_00);
		foreach(var_07 in level.players)
		{
			var_07 scripts\cp\_interaction::func_DE6E();
		}
	}
}

//Function Number: 33
play_pap_vo(param_00)
{
	level endon("gamed_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 thread scripts\cp\_vo::try_to_play_vo("ks_pap_restored","rave_ks_vo");
	wait(4.5);
	switch(param_00.var_134FD)
	{
		case "p1_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("pap_chola_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["pap_chola_1"] = 1;
			break;

		case "p4_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("pap_hiphop_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["pap_hiphop_1"] = 1;
			break;

		case "p3_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("pap_rocker_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["pap_rocker_1"] = 1;
			break;

		case "p2_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("pap_raver_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["pap_raver_1"] = 1;
			break;

		default:
			break;
	}
}

//Function Number: 34
func_13F12(param_00)
{
}

//Function Number: 35
spawn_survivor_on_boat()
{
	level endon("stop_boat_idle_anims");
	if(isdefined(level.boat_survivor))
	{
		return;
	}

	if(isdefined(level.boat_survivor_spawned))
	{
		return;
	}

	level.boat_survivor_spawned = 1;
	while(!scripts\common\utility::istrue(level.var_2BFB.var_57F3))
	{
		wait(0.25);
	}

	var_00 = spawnstruct();
	var_00.origin = (-3803.9,1589.5,-159);
	var_00.angles = (0,292,0);
	var_01 = spawn("script_model",var_00.origin);
	var_01.angles = var_00.angles;
	var_01 setmodel("zmb_world_k_smith");
	var_01 linkto(level.var_2BFB);
	level.boat_survivor = var_01;
	level.boat_survivor thread survivor_boat_nag();
	for(;;)
	{
		var_02 = getanimlength(%iw7_cp_survivor_boat_idle);
		level.boat_survivor scriptmodelplayanim("IW7_cp_survivor_boat_idle",1);
		wait(var_02);
	}
}

//Function Number: 36
survivor_boat_nag()
{
	self endon("stop_boat_nag");
	for(;;)
	{
		level.boat_survivor playsound("ks_nag_getonboat");
		wait(randomintrange(12,20));
	}
}

//Function Number: 37
survivor_boat_filler()
{
	self endon("stop_boat_filler");
	wait(4);
	var_00 = ["ks_examine_memento","ks_examine_memento_2","ks_examine_memento_3","ks_examine_memento_4","ks_examine_memento_5","ks_examine_memento_6"];
	var_01 = var_00;
	for(;;)
	{
		var_02 = scripts\common\utility::random(var_01);
		var_01 = scripts\common\utility::func_22A9(var_01,var_02);
		if(var_01.size < 1)
		{
			var_01 = var_00;
		}

		level.boat_survivor playsoundonmovingent(var_02);
		wait(randomintrange(5,9));
	}
}

//Function Number: 38
survivor_boat_ride()
{
	level thread scripts\cp\maps\cp_rave\cp_rave::hotjoin_on_boat();
	level.var_C9C1 = 1;
	level.var_2BFB method_8265(3);
	foreach(var_01 in level.players)
	{
		var_01 scripts\cp\_utility::allow_player_teleport(0);
	}

	level.no_slasher = 1;
	if(isdefined(level.slasher))
	{
		level.slasher suicide();
	}

	level.var_2BFB thread survivor_boat_ride_sfx();
	wait(1);
	level.var_2BFB.first_player scripts\cp\_vo::try_to_play_vo("memento_6","rave_comment_vo","highest");
	level.boat_survivor thread survivor_boat_filler();
	wait(15);
	level notify("stop_boat_idle_anims");
	var_03 = getanimlength(%iw7_cp_survivor_boat_idle);
	level.boat_survivor scriptmodelplayanim("IW7_cp_survivor_boat_idle",1);
	wait(var_03 - 4.5);
	level.var_2BFB method_83E5(0,5);
	level.boat_survivor notify("stop_boat_filler");
	wait(4.25);
	level.boat_survivor unlink();
	level thread ksmith_boat_vo();
	level.boat_survivor scriptmodelplayanimdeltamotionfrompos("IW7_cp_survivor_boat_fall",level.boat_survivor.origin,level.boat_survivor.angles,1);
	level.boat_survivor playsound("scn_slashride_survivor_fall");
	var_03 = getanimlength(%iw7_cp_survivor_boat_fall);
	wait(var_03 - 3.25);
	level.boat_survivor playsound("scn_slashride_survivor_splash");
	playfx(level._effect["boat_fall_splash"],level.boat_survivor.origin);
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("scn_slashride_03");
	}

	wait(1.25);
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("scn_slashride_slasher_water");
	}

	wait(1);
	level thread super_slasher_intro();
	level waittill("start_fadeout");
	wait(1);
	level.boat_survivor delete();
}

//Function Number: 39
survivor_boat_ride_music_01()
{
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("mus_zmb_rave_slasher_boat_01");
	}
}

//Function Number: 40
survivor_boat_ride_music_02()
{
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("mus_zmb_rave_slasher_boat_02");
	}
}

//Function Number: 41
survivor_boat_ride_sfx()
{
	level endon("boatride_over");
	level endon("gamed_ended");
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("scn_slashride_01");
	}

	var_03 = getvehiclenode(level.var_2BFA.target,"targetname");
	for(;;)
	{
		var_03 waittill("trigger");
		if(isdefined(var_03.name))
		{
			switch(var_03.name)
			{
				case "slasher_boat_sound_2":
					foreach(var_01 in level.players)
					{
						var_01 playlocalsound("scn_slashride_02");
					}
					break;
	
				default:
					break;
			}
		}

		if(!isdefined(var_03.target))
		{
			break;
		}

		var_03 = getvehiclenode(var_03.target,"targetname");
	}
}

//Function Number: 42
ksmith_boat_vo()
{
	level thread survivor_boat_ride_music_01();
	level.boat_survivor playsound("ks_memento_quest_3");
	var_00 = lookupsoundlength("ks_memento_quest_3");
	wait(var_00 / 1000 + 1.25);
	level thread survivor_boat_ride_music_02();
	level.boat_survivor playsound("ks_mement_boat_effort");
}

//Function Number: 43
super_slasher_intro()
{
	playfx(level._effect["vfx_ss_reveal_buildup"],(-3161,3791,-244));
	earthquake(0.3,5,level.var_2BFB.origin,350);
	wait(2);
	earthquake(0.45,10,level.var_2BFB.origin,350);
	var_00 = spawn("script_model",(-3201,3811,-328));
	var_00.angles = (0,0,0);
	var_00 setmodel("fullbody_zmb_superslasher");
	var_00 scriptmodelplayanimdeltamotionfrompos("IW7_cp_super_taunt_intro",(-3201,3811,-328),(0,0,0),1);
	var_00 playsound("zmb_vo_supslasher_water_emerge_lr");
	var_00 thread slasher_intro_fx();
	level thread shellshock_players(6);
	level scripts\cp\_utility::set_completed_quest_mark(4);
	wait(6.25);
	level notify("start_fadeout");
	scripts\common\utility::flag_set("survivor_got_to_island");
	wait(0.25);
	earthquake(0.9,3,level.var_2BFB.origin,350);
	var_00 playsound("zmb_vo_supslasher_attack_ground_pound");
	level thread shellshock_players(4);
	wait(1);
	var_00 delete();
}

//Function Number: 44
shellshock_players(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 shellshock("default_nosound",param_00);
		var_02 thread water_fx();
	}
}

//Function Number: 45
slasher_intro_fx()
{
	wait(0.2);
	playfx(level._effect["vfx_ss_reveal"],(self.origin[0] + 40,self.origin[1] - 20,-244));
	wait(0.5);
	playfxontag(level._effect["vfx_ss_reveal_arms"],self,"j_elbow_le");
	wait(0.05);
	playfxontag(level._effect["vfx_ss_reveal_arms"],self,"j_elbow_ri");
}

//Function Number: 46
water_fx()
{
	self endon("disconnect");
	playfxontag(level._effect["geyser_fullscreen_fx"],self,"tag_eye");
	scripts\common\utility::func_136F7();
	playfxontag(level._effect["geyser_fullscreen_fx"],self,"tag_eye");
	scripts\common\utility::func_136F7();
	playfxontag(level._effect["geyser_fullscreen_fx"],self,"tag_eye");
}

//Function Number: 47
fade_screen_after_ss_intro()
{
	foreach(var_01 in level.players)
	{
		var_01 thread ss_intro_black_screen();
	}

	wait(1);
}

//Function Number: 48
move_players_to_shore()
{
	foreach(var_01 in level.players)
	{
		var_01 thread move_player_to_shore(var_01,"island_dropoff_player");
	}
}

//Function Number: 49
fade_in_for_ss_fight()
{
	scripts\common\utility::flag_set("survivor_got_to_island");
}

//Function Number: 50
move_player_to_shore(param_00,param_01)
{
	param_00 unlink();
	var_02 = param_00 getentitynumber();
	var_03 = scripts\common\utility::getstructarray(param_01,"targetname");
	var_04 = undefined;
	foreach(var_06 in var_03)
	{
		if(var_06.var_ED3C == var_02)
		{
			var_04 = var_06;
		}
	}

	param_00 setorigin(var_04.origin);
	param_00 setplayerangles(var_04.angles);
	param_00 allowstand(1);
	param_00 allowprone(1);
	param_00 method_8012(1);
	param_00.var_AD2B = undefined;
	param_00.disable_consumables = undefined;
	param_00.var_9A45 = undefined;
	param_00 method_85B3("seat",0);
	level.var_2BFB.var_AD27 = scripts\common\utility::func_22A9(level.var_2BFB.var_AD27,param_00);
	param_00.var_3859 = 1;
	param_00.ignoreme = 0;
	param_00 notify("ride_over");
}

//Function Number: 51
ss_intro_black_screen()
{
	self endon("disconnect");
	self setclientomnvar("ui_hide_hud",1);
	self method_80AA();
	self.ss_intro_overlay = newclienthudelem(self);
	self.ss_intro_overlay.x = 0;
	self.ss_intro_overlay.y = 0;
	self.ss_intro_overlay setshader("black",640,480);
	self.ss_intro_overlay.alignx = "left";
	self.ss_intro_overlay.aligny = "top";
	self.ss_intro_overlay.sort = 1;
	self.ss_intro_overlay.horzalign = "fullscreen";
	self.ss_intro_overlay.vertalign = "fullscreen";
	self.ss_intro_overlay.foreground = 1;
	self.ss_intro_overlay.alpha = 0;
	self.ss_intro_overlay fadeovertime(1);
	self.ss_intro_overlay.alpha = 1;
	level waittill("ss_intro_finished");
	self.ss_intro_overlay fadeovertime(5);
	self.ss_intro_overlay.alpha = 0;
	self setclientomnvar("ui_hide_hud",0);
	wait(5);
	self.ss_intro_overlay destroy();
	wait(1.5);
	self enableweapons();
	wait(3);
	level notify("ww_slasher_intro");
}