/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_escortairdrop.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 584 ms
 * Timestamp: 10/27/2023 1:20:45 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.ospreysettings = [];
	if(level.script == "mp_character_room")
	{
		return;
	}

	level.ospreysettings["escort_airdrop"] = spawnstruct();
	level.ospreysettings["escort_airdrop"].vehicle = "osprey_mp";
	level.ospreysettings["escort_airdrop"].modelbase = "vehicle_v22_osprey_body_mp";
	level.ospreysettings["escort_airdrop"].modelblades = "vehicle_v22_osprey_blades_mp";
	level.ospreysettings["escort_airdrop"].taghatchl = "tag_le_door_attach";
	level.ospreysettings["escort_airdrop"].taghatchr = "tag_ri_door_attach";
	level.ospreysettings["escort_airdrop"].tagdropcrates = "tag_turret_attach";
	level.ospreysettings["escort_airdrop"].prompt = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
	level.ospreysettings["escort_airdrop"].name = &"KILLSTREAKS_ESCORT_AIRDROP";
	level.ospreysettings["escort_airdrop"].weaponinfo = "osprey_minigun_mp";
	level.ospreysettings["escort_airdrop"].helitype = "osprey";
	level.ospreysettings["escort_airdrop"].droptype = "airdrop_escort";
	level.ospreysettings["escort_airdrop"].maxhealth = level.heli_maxhealth * 2;
	level.ospreysettings["escort_airdrop"].timeout = 60;
	level.ospreysettings["osprey_gunner"] = spawnstruct();
	level.ospreysettings["osprey_gunner"].vehicle = "osprey_player_mp";
	level.ospreysettings["osprey_gunner"].modelbase = "vehicle_v22_osprey_body_mp";
	level.ospreysettings["osprey_gunner"].modelblades = "vehicle_v22_osprey_blades_mp";
	level.ospreysettings["osprey_gunner"].taghatchl = "tag_le_door_attach";
	level.ospreysettings["osprey_gunner"].taghatchr = "tag_ri_door_attach";
	level.ospreysettings["osprey_gunner"].tagdropcrates = "tag_turret_attach";
	level.ospreysettings["osprey_gunner"].prompt = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
	level.ospreysettings["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
	level.ospreysettings["osprey_gunner"].weaponinfo = "osprey_player_minigun_mp";
	level.ospreysettings["osprey_gunner"].helitype = "osprey_gunner";
	level.ospreysettings["osprey_gunner"].droptype = "airdrop_osprey_gunner";
	level.ospreysettings["osprey_gunner"].maxhealth = level.heli_maxhealth * 2;
	level.ospreysettings["osprey_gunner"].timeout = 75;
	foreach(var_01 in level.ospreysettings)
	{
		level.chopper_fx["explode"]["death"][var_01.modelbase] = loadfx("fx/explosions/helicopter_explosion_osprey");
		level.chopper_fx["explode"]["air_death"][var_01.modelbase] = loadfx("fx/explosions/helicopter_explosion_osprey_air_mp");
		level.chopper_fx["anim"]["blades_anim_up"][var_01.modelbase] = loadfx("fx/props/osprey_blades_anim_up");
		level.chopper_fx["anim"]["blades_anim_down"][var_01.modelbase] = loadfx("fx/props/osprey_blades_anim_down");
		level.chopper_fx["anim"]["blades_static_up"][var_01.modelbase] = loadfx("fx/props/osprey_blades_up");
		level.chopper_fx["anim"]["blades_static_down"][var_01.modelbase] = loadfx("fx/props/osprey_blades_default");
		level.chopper_fx["anim"]["hatch_left_static_up"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_left_default");
		level.chopper_fx["anim"]["hatch_left_anim_down"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_left_anim_open");
		level.chopper_fx["anim"]["hatch_left_static_down"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_left_up");
		level.chopper_fx["anim"]["hatch_left_anim_up"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_left_anim_close");
		level.chopper_fx["anim"]["hatch_right_static_up"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_right_default");
		level.chopper_fx["anim"]["hatch_right_anim_down"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_right_anim_open");
		level.chopper_fx["anim"]["hatch_right_static_down"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_right_up");
		level.chopper_fx["anim"]["hatch_right_anim_up"][var_01.modelbase] = loadfx("fx/props/osprey_bottom_door_right_anim_close");
	}

	level.air_support_locs = [];
	level.killstreakfuncs["escort_airdrop"] = ::func_8437;
	level.killstreakfuncs["osprey_gunner"] = ::func_8444;
}

//Function Number: 2
func_8437(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(level.chopper))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	if(maps\mp\_utility::func_48F6())
	{
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_04 = maps\mp\killstreaks\_airdrop::beginairdropviamarker(param_00,"escort_airdrop");
	if(!isdefined(var_04) || !var_04)
	{
		self notify("markerDetermined");
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	return 1;
}

//Function Number: 3
func_8444(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(level.chopper))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_04 = func_6D71(param_00,"osprey_gunner","compass_objpoint_osprey_friendly","compass_objpoint_osprey_enemy",&"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
	if(!isdefined(var_04) || !var_04)
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	maps\mp\_matchdata::func_4F1D("osprey_gunner",self.origin);
	return 1;
}

//Function Number: 4
finishsupportescortusage(param_00,param_01,param_02,param_03)
{
	self notify("used");
	var_04 = (0,param_02,0);
	var_05 = 12000;
	var_06 = getent("airstrikeheight","targetname");
	var_07 = var_06.origin[2];
	var_08 = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
	var_09 = var_08.origin;
	var_0A = (param_01[0],param_01[1],var_07);
	var_0B = param_01 + anglestoforward(var_04) * var_05;
	var_0C = vectortoangles(var_0A - var_09);
	var_0D = param_01;
	param_01 = (param_01[0],param_01[1],var_07);
	var_0E = func_20C6(self,param_00,var_09,var_0C,param_01,param_03);
	var_09 = var_08;
	func_87D7(param_00,var_0E,var_09,var_0A,var_0B,var_07,var_0D);
}

//Function Number: 5
func_329E(param_00,param_01,param_02,param_03)
{
	self notify("used");
	var_04 = (0,param_02,0);
	var_05 = 12000;
	var_06 = getent("airstrikeheight","targetname");
	var_07 = var_06.origin[2];
	var_08 = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
	var_09 = var_08.origin;
	var_0A = (param_01[0],param_01[1],var_07);
	var_0B = param_01 + anglestoforward(var_04) * var_05;
	var_0C = vectortoangles(var_0A - var_09);
	param_01 = (param_01[0],param_01[1],var_07);
	var_0D = func_20C6(self,param_00,var_09,var_0C,param_01,param_03);
	var_09 = var_08;
	func_87CA(param_00,var_0D,var_09,var_0A,var_0B,var_07);
}

//Function Number: 6
func_7C6F()
{
	self waittill("stop_location_selection",var_00);
	switch(var_00)
	{
		case "emp":
		case "weapon_change":
		case "death":
		case "cancel_location":
		case "disconnect":
			self notify("customCancelLocation");
			break;
	}
}

//Function Number: 7
func_6D71(param_00,param_01,param_02,param_03,param_04)
{
	self endon("customCancelLocation");
	var_05 = undefined;
	var_06 = level.mapsize / 6.46875;
	if(level.splitscreen)
	{
		var_06 = var_06 * 1.5;
	}

	maps\mp\_utility::_beginlocationselection(param_01,"map_artillery_selector",0,500);
	thread func_7C6F();
	self waittill("confirm_location",var_07,var_08);
	maps\mp\_utility::stoplocationselection(0);
	maps\mp\_utility::func_720F(param_01);
	var_09 = maps\mp\killstreaks\_killstreaks::func_4649(param_01);
	if(var_09 != "success")
	{
		if(var_09 != "disconnect")
		{
			maps\mp\_utility::func_1D59();
		}

		return 0;
	}

	if(isdefined(level.chopper))
	{
		maps\mp\_utility::func_1D59();
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount >= maps\mp\_utility::maxvehiclesallowed())
	{
		maps\mp\_utility::func_1D59();
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	thread func_329E(param_00,var_07,var_08,param_01);
	return 1;
}

//Function Number: 8
func_7514(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",0.5);
	var_04 maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,-150);
	var_04 settext(param_02);
	self.locationobjectives = [];
	for(var_05 = 0;var_05 < param_03;var_05++)
	{
		self.locationobjectives[var_05] = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(self.locationobjectives[var_05],"invisible",(0,0,0));
		objective_position(self.locationobjectives[var_05],level.air_support_locs[level.script][var_05]["origin"]);
		objective_state(self.locationobjectives[var_05],"active");
		objective_player(self.locationobjectives[var_05],self getentitynumber());
		if(level.air_support_locs[level.script][var_05]["in_use"] == 1)
		{
			objective_icon(self.locationobjectives[var_05],param_01);
			continue;
		}

		objective_icon(self.locationobjectives[var_05],param_00);
	}

	common_scripts\utility::func_8B2A("cancel_location","picked_location","stop_location_selection");
	var_04 maps\mp\gametypes\_hud_util::destroyelem();
	for(var_05 = 0;var_05 < param_03;var_05++)
	{
		maps\mp\_utility::_objective_delete(self.locationobjectives[var_05]);
	}
}

//Function Number: 9
func_20C6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnhelicopter(param_00,param_02,param_03,level.ospreysettings[param_05].vehicle,level.ospreysettings[param_05].modelbase);
	if(!isdefined(var_06))
	{
		return undefined;
	}

	var_06.ospreytype = param_05;
	var_06.heli_type = level.ospreysettings[param_05].modelbase;
	var_06.helitype = level.ospreysettings[param_05].helitype;
	var_06.attractor = missile_createattractorent(var_06,level.heli_attract_strength,level.heli_attract_range);
	var_06.lifeid = param_01;
	var_06.team = param_00.pers["team"];
	var_06.pers["team"] = param_00.pers["team"];
	var_06.owner = param_00;
	var_06 setotherent(param_00);
	var_06.maxhealth = level.ospreysettings[param_05].maxhealth;
	var_06.zoffset = (0,0,0);
	var_06.targeting_delay = level.heli_targeting_delay;
	var_06.primarytarget = undefined;
	var_06.secondarytarget = undefined;
	var_06.attacker = undefined;
	var_06.currentstate = "ok";
	var_06.droptype = level.ospreysettings[param_05].droptype;
	var_06 common_scripts\utility::func_5009(var_06.team);
	level.chopper = var_06;
	var_06 maps\mp\killstreaks\_helicopter::addtohelilist();
	var_06 thread maps\mp\killstreaks\_flares::func_33DA(2);
	var_06 thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect(param_00);
	var_06 thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeteams(param_00);
	var_06 thread maps\mp\killstreaks\_helicopter::func_40E6(param_00);
	var_07 = level.ospreysettings[param_05].timeout;
	var_06 thread maps\mp\killstreaks\_helicopter::func_40E9(var_07);
	var_06 thread maps\mp\killstreaks\_helicopter::func_40A5(param_05,0);
	var_06 thread maps\mp\killstreaks\_helicopter::func_40D9();
	var_06 thread maps\mp\killstreaks\_helicopter::func_40B3();
	var_06 thread airshipfx();
	var_06 thread airshipfxonconnect();
	if(param_05 == "escort_airdrop")
	{
		var_08 = var_06.origin + anglestoforward(var_06.angles) * -200 + anglestoright(var_06.angles) * -200 + (0,0,200);
		var_06.killcament = spawn("script_model",var_08);
		var_06.killcament setscriptmoverkillcam("explosive");
		var_06.killcament linkto(var_06,"tag_origin");
	}

	return var_06;
}

//Function Number: 10
airshipfx()
{
	self endon("death");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.chopper_fx["anim"]["blades_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
	wait(0.05);
	playfxontag(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
	wait(0.05);
	playfxontag(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
}

//Function Number: 11
airshipfxonconnect()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		thread airshipfxonclient(var_00);
	}
}

//Function Number: 12
airshipfxonclient(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	wait(0.05);
	playfxontagforclients(level.chopper_fx["light"]["tail"],self,"tag_light_tail",param_00);
	wait(0.05);
	playfxontagforclients(level.chopper_fx["light"]["belly"],self,"tag_light_belly",param_00);
	if(isdefined(self.propsstate))
	{
		if(self.propsstate == "up")
		{
			wait(0.05);
			playfxontagforclients(level.chopper_fx["anim"]["blades_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH",param_00);
		}
		else
		{
			wait(0.05);
			playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH",param_00);
		}
	}
	else
	{
		wait(0.05);
		playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH",param_00);
	}

	if(isdefined(self.hatchstate))
	{
		if(self.hatchstate == "down")
		{
			wait(0.05);
			playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl,param_00);
			wait(0.05);
			playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr,param_00);
		}

		wait(0.05);
		playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl,param_00);
		wait(0.05);
		playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr,param_00);
	}

	wait(0.05);
	playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl,param_00);
	wait(0.05);
	playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr,param_00);
}

//Function Number: 13
func_87D7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_01 thread airshipflydefense(self,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 14
func_87CA(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_66A3(param_00,param_01);
	param_01 thread func_0A96(self,param_02,param_03,param_04,param_05);
}

//Function Number: 15
func_66A3(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("helicopter_done");
	thread maps\mp\_utility::func_7FA0("used_osprey_gunner",self);
	maps\mp\_utility::_giveweapon("heli_remote_mp");
	self switchtoweapon("heli_remote_mp");
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(0);
	}

	param_01 vehicleturretcontrolon(self);
	self playerlinkweaponviewtodelta(param_01,"tag_player",1,0,0,0,0,1);
	self setplayerangles(param_01 gettagangles("tag_player"));
	param_01 thread maps\mp\killstreaks\_helicopter::func_412F();
	param_01.gunner = self;
	self.heliridelifeid = param_00;
	thread func_2DEA(param_01);
	thread func_8B16(1,param_01);
	thread maps\mp\_utility::func_647F(param_01);
	for(;;)
	{
		param_01 waittill("turret_fire");
		param_01 fireweapon();
		earthquake(0.2,1,param_01.origin,1000);
	}
}

//Function Number: 16
func_8B16(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	param_01 endon("helicopter_done");
	param_01 endon("crashing");
	param_01 endon("leaving");
	wait(param_00);
	self visionsetthermalforplayer(level.ac130.enhanced_vision,0);
	self.lastvisionsetthermal = level.ac130.enhanced_vision;
	self thermalvisionon();
	self thermalvisionfofoverlayon();
}

//Function Number: 17
showdefendprompt(param_00)
{
	self endon("disconnect");
	param_00 endon("helicopter_done");
	self.escort_prompt = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",1.5);
	self.escort_prompt maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,-150);
	self.escort_prompt settext(level.ospreysettings[param_00.ospreytype].prompt);
	wait(6);
	if(isdefined(self.escort_prompt))
	{
		self.escort_prompt maps\mp\gametypes\_hud_util::destroyelem();
	}
}

//Function Number: 18
airshippitchpropsup()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.chopper_fx["anim"]["blades_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
	playfxontag(level.chopper_fx["anim"]["blades_anim_up"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.chopper_fx["anim"]["blades_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
		self.propsstate = "up";
	}
}

//Function Number: 19
airshippitchpropsdown()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.chopper_fx["anim"]["blades_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
	playfxontag(level.chopper_fx["anim"]["blades_anim_down"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.chopper_fx["anim"]["blades_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,"TAG_BLADES_ATTACH");
		self.propsstate = "down";
	}
}

//Function Number: 20
airshippitchhatchup()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.chopper_fx["anim"]["hatch_left_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
	playfxontag(level.chopper_fx["anim"]["hatch_left_anim_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
	stopfxontag(level.chopper_fx["anim"]["hatch_right_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
	playfxontag(level.chopper_fx["anim"]["hatch_right_anim_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
		playfxontag(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
		self.hatchstate = "up";
	}
}

//Function Number: 21
airshippitchhatchdown()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.chopper_fx["anim"]["hatch_left_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
	playfxontag(level.chopper_fx["anim"]["hatch_left_anim_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
	stopfxontag(level.chopper_fx["anim"]["hatch_right_static_up"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
	playfxontag(level.chopper_fx["anim"]["hatch_right_anim_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.chopper_fx["anim"]["hatch_left_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchl);
		playfxontag(level.chopper_fx["anim"]["hatch_right_static_down"][level.ospreysettings[self.ospreytype].modelbase],self,level.ospreysettings[self.ospreytype].taghatchr);
		self.hatchstate = "down";
	}

	self notify("hatch_down");
}

//Function Number: 22
func_3A3A(param_00)
{
	self endon("helicopter_removed");
	self endon("heightReturned");
	var_01 = getent("airstrikeheight","targetname");
	if(isdefined(var_01))
	{
		var_02 = var_01.origin[2];
	}
	else if(isdefined(level.airstrikeheightscale))
	{
		var_02 = 850 * level.airstrikeheightscale;
	}
	else
	{
		var_02 = 850;
	}

	self.bestheight = var_02;
	var_03 = 200;
	var_04 = 0;
	var_05 = 0;
	for(var_06 = 0;var_06 < 125;var_06++)
	{
		wait(0.05);
		var_07 = var_06 % 8;
		var_08 = var_06 * 3;
		switch(var_07)
		{
			case 0:
				var_04 = var_08;
				var_05 = var_08;
				break;

			case 1:
				var_04 = var_08 * -1;
				var_05 = var_08 * -1;
				break;

			case 2:
				var_04 = var_08 * -1;
				var_05 = var_08;
				break;

			case 3:
				var_04 = var_08;
				var_05 = var_08 * -1;
				break;

			case 4:
				var_04 = 0;
				var_05 = var_08 * -1;
				break;

			case 5:
				var_04 = var_08 * -1;
				var_05 = 0;
				break;

			case 6:
				var_04 = var_08;
				var_05 = 0;
				break;

			case 7:
				var_04 = 0;
				var_05 = var_08;
				break;

			default:
				break;
		}

		var_09 = bullettrace(param_00 + (var_04,var_05,1000),param_00 + (var_04,var_05,-10000),1,self);
		if(var_09["position"][2] > var_03)
		{
			var_03 = var_09["position"][2];
		}
	}

	self.bestheight = var_03 + 300;
	switch(getdvar("mapname"))
	{
		case "mp_morningwood":
			self.bestheight = self.bestheight + 600;
			break;

		case "mp_overwatch":
			var_0A = level.spawnpoints;
			var_0B = var_0A[0];
			var_0C = var_0A[0];
			foreach(var_0E in var_0A)
			{
				if(var_0E.origin[2] < var_0B.origin[2])
				{
					var_0B = var_0E;
				}
	
				if(var_0E.origin[2] > var_0C.origin[2])
				{
					var_0C = var_0E;
				}
			}
	
			if(var_03 < var_0B.origin[2] - 100)
			{
				self.bestheight = var_0C.origin[2] + 900;
			}
			break;
	}
}

//Function Number: 23
airshipflydefense(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("airshipFlyDefense");
	self endon("airshipFlyDefense");
	self endon("helicopter_removed");
	self endon("death");
	self endon("leaving");
	thread func_3A3A(param_02);
	maps\mp\killstreaks\_helicopter::func_40C6(param_01);
	self.pathgoal = param_02;
	var_06 = self.angles;
	self setyawspeed(30,30,30,0.3);
	var_07 = self.origin;
	var_08 = self.angles[1];
	var_09 = self.angles[0];
	self.timeout = level.ospreysettings[self.ospreytype].timeout;
	self setvehgoalpos(param_02,1);
	var_0A = gettime();
	self waittill("goal");
	var_0B = gettime() - var_0A * 0.001;
	self.timeout = self.timeout - var_0B;
	thread airshippitchpropsup();
	var_0C = param_02 * (1,1,0);
	var_0C = var_0C + (0,0,self.bestheight);
	self vehicle_setspeed(25,10,10);
	self setyawspeed(20,10,10,0.3);
	self setvehgoalpos(var_0C,1);
	var_0A = gettime();
	self waittill("goal");
	var_0B = gettime() - var_0A * 0.001;
	self.timeout = self.timeout - var_0B;
	self sethoverparams(65,50,50);
	func_5A13(1,level.ospreysettings[self.ospreytype].tagdropcrates,var_0C);
	thread func_4B20(param_05);
	if(isdefined(param_00))
	{
		param_00 common_scripts\utility::func_8B35(self.timeout,"disconnect");
	}

	self waittill("leaving");
	self notify("osprey_leaving");
	thread airshippitchpropsdown();
}

//Function Number: 24
func_8A65(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 25
func_4B20(param_00)
{
	self endon("osprey_leaving");
	self endon("helicopter_removed");
	self endon("death");
	var_01 = param_00;
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			wait(0.05);
			if(!isdefined(self))
			{
			}

			if(!isdefined(var_03))
			{
				continue;
			}

			if(!maps\mp\_utility::func_4945(var_03))
			{
				continue;
			}

			if(!self.owner maps\mp\_utility::isenemy(var_03))
			{
				continue;
			}

			if(var_03 maps\mp\_utility::_hasperk("specialty_blindeye"))
			{
				continue;
			}

			if(distancesquared(var_01,var_03.origin) > 500000)
			{
				continue;
			}

			thread aishootplayer(var_03,var_01);
			func_8ADE();
		}
	}
}

//Function Number: 26
aishootplayer(param_00,param_01)
{
	self notify("aiShootPlayer");
	self endon("aiShootPlayer");
	self endon("helicopter_removed");
	self endon("leaving");
	param_00 endon("death");
	self setturrettargetent(param_00);
	self setlookatent(param_00);
	thread func_7F59(param_00);
	var_02 = 6;
	var_03 = 2;
	for(;;)
	{
		var_02--;
		self fireweapon("tag_flash",param_00);
		wait(0.15);
		if(var_02 <= 0)
		{
			var_03--;
			var_02 = 6;
			if(distancesquared(param_00.origin,param_01) > 500000 || var_03 <= 0 || !maps\mp\_utility::func_4945(param_00))
			{
				self notify("abandon_target");
			}

			wait(1);
		}
	}
}

//Function Number: 27
func_7F59(param_00)
{
	self endon("abandon_target");
	self endon("leaving");
	self endon("helicopter_removed");
	param_00 waittill("death");
	self notify("target_killed");
}

//Function Number: 28
func_8ADE()
{
	self endon("helicopter_removed");
	self endon("leaving");
	self endon("target_killed");
	self endon("abandon_target");
	wait(0.05);
}

//Function Number: 29
func_0A96(param_00,param_01,param_02,param_03,param_04)
{
	self notify("airshipFlyGunner");
	self endon("airshipFlyGunner");
	self endon("helicopter_removed");
	self endon("death");
	self endon("leaving");
	thread func_3A3A(param_02);
	maps\mp\killstreaks\_helicopter::func_40C6(param_01);
	thread maps\mp\killstreaks\_helicopter::func_40E9(level.ospreysettings[self.ospreytype].timeout);
	var_05 = self.angles;
	self setyawspeed(30,30,30,0.3);
	var_06 = self.origin;
	var_07 = self.angles[1];
	var_08 = self.angles[0];
	self.timeout = level.ospreysettings[self.ospreytype].timeout;
	self setvehgoalpos(param_02,1);
	var_09 = gettime();
	self waittill("goal");
	var_0A = gettime() - var_09 * 0.001;
	self.timeout = self.timeout - var_0A;
	thread airshippitchpropsup();
	var_0B = param_02 * (1,1,0);
	var_0B = var_0B + (0,0,self.bestheight);
	self vehicle_setspeed(25,10,10);
	self setyawspeed(20,10,10,0.3);
	self setvehgoalpos(var_0B,1);
	var_09 = gettime();
	self waittill("goal");
	var_0A = gettime() - var_09 * 0.001;
	self.timeout = self.timeout - var_0A;
	func_5A12(1,level.ospreysettings[self.ospreytype].tagdropcrates,var_0B);
	var_0C = 1;
	if(isdefined(param_00))
	{
		param_00 common_scripts\utility::func_8B35(var_0C,"disconnect");
	}

	self.timeout = self.timeout - var_0C;
	self setvehgoalpos(param_02,1);
	var_09 = gettime();
	self waittill("goal");
	var_0A = gettime() - var_09 * 0.001;
	self.timeout = self.timeout - var_0A;
	var_0D = getentarray("heli_attack_area","targetname");
	var_0E = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
	if(var_0D.size)
	{
		thread maps\mp\killstreaks\_helicopter::func_40C8(var_0D);
	}
	else
	{
		thread maps\mp\killstreaks\_helicopter::func_40C5(var_0E);
	}

	self waittill("leaving");
	thread airshippitchpropsdown();
}

//Function Number: 30
func_5A13(param_00,param_01,param_02)
{
	thread airshippitchhatchdown();
	self waittill("hatch_down");
	level notify("escort_airdrop_started",self);
	var_03[0] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomint(10),randomint(10),randomint(10)),undefined,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	var_03[1] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomint(100),randomint(100),randomint(100)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	var_03[2] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomint(50),randomint(50),randomint(50)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	var_03[3] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomintrange(-100,0),randomintrange(-100,0),randomintrange(-100,0)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomintrange(-50,0),randomintrange(-50,0),randomintrange(-50,0)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(1);
	thread airshippitchhatchup();
}

//Function Number: 31
func_5A12(param_00,param_01,param_02)
{
	thread airshippitchhatchdown();
	self waittill("hatch_down");
	var_03[0] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomint(10),randomint(10),randomint(10)),undefined,param_01);
	wait(0.05);
	self.timeout = self.timeout - 0.05;
	self notify("drop_crate");
	wait(param_00);
	self.timeout = self.timeout - param_00;
	var_03[1] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomint(100),randomint(100),randomint(100)),var_03,param_01);
	wait(0.05);
	self.timeout = self.timeout - 0.05;
	self notify("drop_crate");
	wait(param_00);
	self.timeout = self.timeout - param_00;
	var_03[2] = thread maps\mp\killstreaks\_airdrop::func_2B5F(undefined,self.droptype,undefined,0,undefined,self.origin,(randomint(50),randomint(50),randomint(50)),var_03,param_01);
	wait(0.05);
	self.timeout = self.timeout - 0.05;
	self notify("drop_crate");
	wait(1);
	thread airshippitchhatchup();
}

//Function Number: 32
func_2DE9(param_00)
{
	if(isdefined(self.escort_prompt))
	{
		self.escort_prompt maps\mp\gametypes\_hud_util::destroyelem();
	}

	self remotecamerasoundscapeoff();
	self thermalvisionoff();
	self thermalvisionfofoverlayoff();
	self unlink();
	maps\mp\_utility::func_1D59();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(1);
	}

	self visionsetthermalforplayer(game["thermal_vision"],0);
	if(isdefined(param_00))
	{
		param_00 vehicleturretcontroloff(self);
	}

	self notify("heliPlayer_removed");
	self switchtoweapon(common_scripts\utility::func_3B0A());
	self takeweapon("heli_remote_mp");
}

//Function Number: 33
func_2DEA(param_00)
{
	self endon("disconnect");
	param_00 waittill("helicopter_done");
	func_2DE9(param_00);
}