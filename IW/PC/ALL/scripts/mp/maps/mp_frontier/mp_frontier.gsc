/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_frontier\mp_frontier.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1316 ms
 * Timestamp: 10/27/2023 12:13:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0FAD::main();
	scripts\mp\maps\mp_frontier\gen\mp_frontier_art::main();
	lib_0FAC::main();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_frontier");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_volumetrics",0);
	setdvar("r_umbraMinObjectContribution",8);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	level._effect["launchSmoke"] = loadfx("vfx/iw7/core/smktrail/vfx_jackal_launch_smoke.vfx");
	level._effect["takeoffThrust2"] = loadfx("vfx/iw7/levels/mp_frontier/vfx_jkl_thrust_takeoff.vfx");
	level._effect["takeoffThrust"] = loadfx("vfx/iw7/levels/mp_frontier/vfx_jkl_boost_emit.vfx");
	level._effect["taxiThrust"] = loadfx("vfx/iw7/levels/mp_frontier/vfx_jackal_thrust_idle.vfx");
	thread fix_collision();
	thread func_A3FF();
	thread func_6F1A();
	thread func_CDA4("mp_frontier_forest");
	scripts\mp\_utility::func_627A(1,-0.05);
	func_1F01();
	thread func_E837();
	runmodespecifictriggers();
}

//Function Number: 2
fix_collision()
{
	var_00 = spawn("script_model",(-256,-1336,745));
	var_00.angles = (0,0,-90);
	var_00 setmodel("beacon_metal_panel_wall_quad_mp_frontier_patch");
	var_01 = spawn("script_model",(-256,-1336,745));
	var_01.angles = (0,0,90);
	var_01 setmodel("beacon_metal_panel_wall_quad_mp_frontier_patch");
	var_02 = spawn("script_model",(-256,-1432,745));
	var_02.angles = (0,0,-90);
	var_02 setmodel("beacon_metal_panel_wall_double_mp_frontier_patch");
	var_03 = spawn("script_model",(-256,-1432,745));
	var_03.angles = (0,0,90);
	var_03 setmodel("beacon_metal_panel_wall_double_mp_frontier_patch");
	var_04 = getent("player512x512x8","targetname");
	var_05 = spawn("script_model",(416,-72,768));
	var_05.angles = (0,0,90);
	var_05 clonebrushmodeltoscriptmodel(var_04);
	var_06 = spawn("trigger_radius",(0,0,800),0,2500,128);
	var_06.var_257 = 2500;
	var_06.height = 128;
	var_06 thread kill_trigger_loop("script_vehicle");
	var_07 = getent("clip512x512x8","targetname");
	var_08 = spawn("script_model",(0,592,240));
	var_08.angles = (0,0,-90);
	var_08 clonebrushmodeltoscriptmodel(var_07);
	var_09 = spawn("script_model",(774,-1082,502));
	var_09.angles = (0,90,0);
	var_09 setmodel("building_support_steel_beam_04_mp_frontier_patch");
}

//Function Number: 3
kill_trigger_loop(param_00)
{
	for(;;)
	{
		self waittill("trigger",var_01);
		if(isdefined(var_01) && isdefined(var_01.classname) && var_01.classname == param_00)
		{
			if(isdefined(var_01.var_110EA))
			{
				if(var_01.var_110EA == "minijackal")
				{
					var_01 notify("minijackal_end");
					continue;
				}

				if(var_01.var_110EA == "venom")
				{
					var_01 notify("venom_end",var_01.origin);
				}
			}
		}
	}
}

//Function Number: 4
func_1F01()
{
	precachempanim("machinery_floor_panel_popup_01_raise");
}

//Function Number: 5
func_E837()
{
	wait(5);
	thread func_E836();
	thread func_E834();
	thread func_E835();
}

//Function Number: 6
func_A3FF()
{
	level endon("game_ended");
	var_00 = func_A402("jackal01");
	var_01 = func_A402("jackal02");
	var_02 = func_A401();
	var_02 thread func_A400();
	var_01.origin = var_01.var_6106.origin;
	var_01.angles = var_01.var_6106.angles;
	var_01 func_A403();
	var_00 func_A3FE();
	for(;;)
	{
		level notify("elevator_open");
		wait(0.1);
		level notify("platform_raise");
		var_00 moveto(var_00.var_6106.origin,10,2.5,2.5);
		wait(10);
		var_01 func_A3FD();
		var_00 thread func_A403();
		var_01 func_A3FE();
		wait(7);
		level notify("platform_lower");
		wait(5);
		level notify("elevator_close");
		wait(10);
		level notify("elevator_open");
		wait(0.1);
		level notify("platform_raise");
		var_01 moveto(var_01.var_6106.origin,10,2.5,2.5);
		wait(10);
		var_00 func_A3FD();
		var_00 func_A3FE();
		var_01 thread func_A403();
		wait(7);
		level notify("platform_lower");
		wait(5);
		level notify("elevator_close");
		wait(10);
	}
}

//Function Number: 7
func_A403()
{
	playfxontag(scripts\common\utility::getfx("taxiThrust"),self,"tag_thrust_rear_le");
	playfxontag(scripts\common\utility::getfx("taxiThrust"),self,"tag_thrust_rear_ri");
	thread func_A252();
	var_00 = abs(distance(self.origin,self.var_BE1B.origin) * 0.01);
	self moveto(self.var_BE1B.origin,var_00,2,0);
	wait(var_00);
	self.var_BF7A = scripts\common\utility::getstruct(self.var_BE1B.target,"targetname");
	while(isdefined(self.var_BF7A))
	{
		var_00 = abs(distance(self.origin,self.var_BF7A.origin) * 0.01);
		if(isdefined(self.var_BF7A.target))
		{
			self moveto(self.var_BF7A.origin,var_00,0,0);
			self rotateto(self.var_BF7A.angles,var_00,0,0);
			wait(var_00);
			self.var_BF7A = scripts\common\utility::getstruct(self.var_BF7A.target,"targetname");
			continue;
		}

		self moveto(self.var_BF7A.origin,var_00,0,var_00 * 0.5);
		self rotateto(self.var_BF7A.angles,var_00,0,var_00 * 0.5);
		wait(var_00);
		self.var_BF7A = undefined;
	}

	stopfxontag(scripts\common\utility::getfx("taxiThrust"),self,"tag_thrust_rear_le");
	stopfxontag(scripts\common\utility::getfx("taxiThrust"),self,"tag_thrust_rear_ri");
}

//Function Number: 8
func_A252()
{
	self playsoundonmovingent("frontier_jackal_launch_01");
	wait(12.45);
	self playsoundonmovingent("frontier_jackal_launch_01b");
	wait(9.65);
	self playsoundonmovingent("frontier_jackal_launch_01c");
}

//Function Number: 9
func_6F1A()
{
	var_00 = [];
	var_00[0] = "emt_frontier_control_vo_1";
	var_00[1] = "emt_frontier_control_vo_2";
	var_00[2] = "emt_frontier_control_vo_3";
	var_00[3] = "emt_frontier_control_vo_4";
	var_00[4] = "emt_frontier_control_vo_5";
	var_00[5] = "emt_frontier_control_vo_6";
	var_00[6] = "emt_frontier_control_vo_7";
	var_00[7] = "emt_frontier_control_vo_8";
	var_00[8] = "emt_frontier_control_vo_9";
	var_00[9] = "emt_frontier_control_vo_10";
	var_00[10] = "emt_frontier_control_vo_11";
	var_00[11] = "emt_frontier_control_vo_12";
	var_00[12] = "emt_frontier_control_vo_13";
	var_00[13] = "emt_frontier_control_vo_14";
	var_00[14] = "emt_frontier_control_vo_15";
	var_00[15] = "emt_frontier_control_vo_16";
	var_00[16] = "emt_frontier_control_vo_17";
	var_00[17] = "emt_frontier_control_vo_18";
	var_00[18] = "emt_frontier_control_vo_19";
	var_01 = 0;
	wait(5);
	var_02 = [];
	var_02[0] = spawn("script_origin",(-1172.29,1822.21,560.74));
	var_02[1] = spawn("script_origin",(752.399,-1607.05,581.218));
	var_02[2] = spawn("script_origin",(-665.927,130.851,666.278));
	wait(1);
	for(;;)
	{
		if(var_01 < var_00.size)
		{
			foreach(var_04 in var_02)
			{
				var_04 playsound(var_00[var_01]);
			}

			wait(randomfloatrange(7.5,15));
			var_01 = var_01 + 1;
			continue;
		}

		var_01 = 0;
	}
}

//Function Number: 10
func_A3FD()
{
	playfxontag(scripts\common\utility::getfx("takeoffThrust2"),self,"tag_thrust_rear_le");
	playfxontag(scripts\common\utility::getfx("takeoffThrust2"),self,"tag_thrust_rear_ri");
	self playsoundonmovingent("frontier_jackal_launch_02");
	self rotateto(self.var_6F24.angles,6,2.5);
	self moveto(self.var_AAA7.origin,2.5,0.625);
	wait(2.5);
	playfxontag(scripts\common\utility::getfx("takeoffThrust"),self,"tag_thrust_rear_le");
	playfxontag(scripts\common\utility::getfx("takeoffThrust"),self,"tag_thrust_rear_ri");
	self playsoundonmovingent("frontier_jackal_launch_03");
	self moveto(self.var_6F24.origin,3.5,0.7);
	wait(3.5);
	playfxontag(scripts\common\utility::getfx("takeoffThrust"),self,"tag_thrust_rear_le");
	playfxontag(scripts\common\utility::getfx("takeoffThrust"),self,"tag_thrust_rear_ri");
	self moveto(self.var_6F26.origin,3.5,0.7);
	wait(3.5);
}

//Function Number: 11
func_A3FE()
{
	self.origin = self.var_2C5.origin;
	self.angles = self.var_2C5.angles;
}

//Function Number: 12
func_A402(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01.var_2C5 = scripts\common\utility::getstruct("jackal_startPos","targetname");
	var_01.var_BE12 = getent(param_00 + "_col","targetname");
	var_01.var_BE12 linkto(var_01);
	var_01.var_BE12 hide();
	var_01.var_BE1D = getent(param_00 + "_thrusters","targetname");
	var_01.var_BE1D linkto(var_01);
	var_01.var_BE1D hide();
	var_01.var_6106 = scripts\common\utility::getstruct("jackal_elevatorTopPos","targetname");
	var_01.var_BE1B = scripts\common\utility::getstruct(param_00 + "_path","targetname");
	var_01.var_AAA7 = scripts\common\utility::getstruct(param_00 + "_launch","targetname");
	var_01.var_6F24 = scripts\common\utility::getstruct(param_00 + "_flight","targetname");
	var_01.var_6F26 = scripts\common\utility::getstruct(param_00 + "_flightEnd","targetname");
	return var_01;
}

//Function Number: 13
func_A401()
{
	var_00["platform"] = getent("elevator_platform","targetname");
	var_01 = scripts\common\utility::getstruct("elevatorBot","targetname");
	var_02 = scripts\common\utility::getstruct("elevatorTop","targetname");
	var_00["platform"].var_2EEA = var_01.origin;
	var_00["platform"].var_11A06 = var_02.origin;
	var_00["door_left"] = getent("elevator_doorLeft","targetname");
	var_00["door_right"] = getent("elevator_doorRight","targetname");
	var_00["door_left"].var_2C5 = var_00["door_left"].origin;
	var_00["door_right"].var_2C5 = var_00["door_right"].origin;
	var_03 = scripts\common\utility::getstruct("elevatorOpenLeft","targetname");
	var_04 = scripts\common\utility::getstruct("elevatorOpenRight","targetname");
	var_00["door_left"].var_C630 = var_03.origin;
	var_00["door_right"].var_C630 = var_04.origin;
	return var_00;
}

//Function Number: 14
func_A400()
{
	level endon("game_ended");
	self["platform"] thread func_BCB8();
	for(;;)
	{
		level waittill("elevator_open");
		self["door_left"] moveto(self["door_left"].var_C630,2,0.5,0.5);
		self["door_right"] moveto(self["door_right"].var_C630,2,0.5,0.5);
		level waittill("elevator_close");
		self["door_left"] moveto(self["door_left"].var_2C5,2,0.5,0.5);
		self["door_right"] moveto(self["door_right"].var_2C5,2,0.5,0.5);
	}
}

//Function Number: 15
func_BCB8()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = level scripts\common\utility::func_13734("platform_raise","platform_lower");
		if(var_00 == "platform_raise")
		{
			self moveto(self.var_11A06,10,2.5,2.5);
			continue;
		}

		self moveto(self.var_2EEA,10,2.5,2.5);
	}
}

//Function Number: 16
func_CDA4(param_00)
{
	wait(30);
	function_030E(param_00);
}

//Function Number: 17
func_E834()
{
	level endon("game_ended");
	var_00 = getentarray("anim_hydroponics","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_1F9A();
	}
}

//Function Number: 18
func_1F9A()
{
	level endon("game_ended");
	var_00 = 20;
	for(;;)
	{
		self method_8269((0,0,360),var_00,0,0);
		wait(var_00);
	}
}

//Function Number: 19
func_E835()
{
	level endon("game_ended");
	for(var_00 = 0;var_00 <= 3;var_00++)
	{
		var_01[var_00] = getentarray("anim_hydroponic_pots_0" + var_00 + 1,"script_noteworthy");
		var_02 = [];
		foreach(var_04 in var_01[var_00])
		{
			if(isdefined(var_04.var_336))
			{
				if(var_04.var_336 == "cylinder_potted_kale_red" || var_04.var_336 == "cylinder_potted_spinach" || var_04.var_336 == "cylinder_potted_lettuce")
				{
					var_02[var_04.var_336] = var_04;
					var_02[var_04.var_336] thread func_1F9E();
				}
			}
		}

		foreach(var_07 in var_02)
		{
			foreach(var_04 in var_01[var_00])
			{
				if(isdefined(var_04.target))
				{
					var_04 linkto(var_02[var_04.target]);
				}
			}
		}
	}
}

//Function Number: 20
func_1F9E()
{
	level endon("game_ended");
	var_00 = 30;
	for(;;)
	{
		self method_8269((0,360,0),var_00,0,0);
		wait(var_00);
	}
}

//Function Number: 21
func_E836()
{
	level endon("game_ended");
	var_00 = getscriptablearray("animating_cover","targetname");
	var_01 = getent("trig_animating_cover","targetname");
	foreach(var_03 in var_00)
	{
		switch(var_03.script_noteworthy)
		{
			case "green":
			case "red":
				var_03 thread func_1F9B(var_01);
				break;

			case "start":
				var_03 thread func_1F9B();
				break;
		}
	}
}

//Function Number: 22
func_1F9B(param_00)
{
	if(isdefined(param_00))
	{
		param_00 waittill("trigger");
	}

	self playsound("frontier_cover_move_sfx");
	self setscriptablepartstate("root","raise",0);
}

//Function Number: 23
func_BD66()
{
	precachemodel("opsmap_solar_system_large");
	level._effect["vfx_opsmap_3d_planet_sol_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_sun_large.vfx");
	level._effect["vfx_opsmap_3d_planet_mercury_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mercury_large.vfx");
	level._effect["vfx_opsmap_3d_planet_venus_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_venus_large.vfx");
	level._effect["vfx_opsmap_3d_planet_earth_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_earth_large.vfx");
	level._effect["vfx_opsmap_3d_planet_mars_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mars_large.vfx");
	level._effect["vfx_opsmap_3d_planet_jupiter_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_jupiter_large.vfx");
	level._effect["vfx_opsmap_3d_planet_saturn_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_saturn_large.vfx");
	level._effect["vfx_opsmap_3d_planet_uranus_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_uranus_large.vfx");
	level._effect["vfx_opsmap_3d_planet_neptune_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_neptune_large.vfx");
	level._effect["vfx_opsmap_3d_planet_sol_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_sol_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_mercury_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_mercury_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_venus_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_venus_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_earth_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_earth_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_mars_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_mars_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_jupiter_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_jupiter_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_saturn_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_saturn_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_uranus_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_uranus_tag_large.vfx");
	level._effect["vfx_opsmap_3d_planet_neptune_tag_large"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_neptune_tag_large.vfx");
	level._effect["vfx_opsmap_3d_asteroid_cluster_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_asteroid_cluster_large.vfx");
	level._effect["vfx_opsmap_3d_ambient_large"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_ops_projection_under_glow_02_large.vfx");
}

//Function Number: 24
func_10CB4()
{
	var_00 = scripts\common\utility::getstruct("opsmap_org","targetname");
	var_01 = var_00.origin + (0,0,48);
	var_02 = spawn("script_model",var_01);
	var_02.angles = var_00.angles;
	var_02 setmodel("opsmap_solar_system_large");
	var_02 scriptmodelplayanim("opsmap_solar_system_large_idle");
	playfx(scripts\common\utility::getfx("vfx_opsmap_3d_ambient_large"),var_01);
	wait(5);
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_1");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_2");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_3");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_4");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_5");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_6");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_7");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_8");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_9");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_10");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_11");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_12");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_13");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_14");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_15");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_asteroid_cluster_large"),var_02,"tag_asteroid_16");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_sol_tag_large"),var_02,"tag_planet_sun");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_mercury_tag_large"),var_02,"tag_planet_mercury");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_venus_tag_large"),var_02,"tag_planet_venus");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_earth_tag_large"),var_02,"tag_planet_earth");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_mars_tag_large"),var_02,"tag_planet_mars");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_jupiter_tag_large"),var_02,"tag_planet_jupiter");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_saturn_tag_large"),var_02,"tag_planet_saturn");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_uranus_tag_large"),var_02,"tag_planet_uranus");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_neptune_tag_large"),var_02,"tag_planet_neptune");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_sol_large"),var_02,"tag_planet_sun");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_mercury_large"),var_02,"tag_planet_mercury");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_venus_large"),var_02,"tag_planet_venus");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_earth_large"),var_02,"tag_planet_earth");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_mars_large"),var_02,"tag_planet_mars");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_jupiter_large"),var_02,"tag_planet_jupiter");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_saturn_large"),var_02,"tag_planet_saturn");
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_uranus_large"),var_02,"tag_planet_uranus");
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("vfx_opsmap_3d_planet_neptune_large"),var_02,"tag_planet_neptune");
}

//Function Number: 25
runmodespecifictriggers()
{
	if(level.gametype == "ball" || level.gametype == "tdef")
	{
		var_00 = spawn("trigger_radius",(48,1848,716),0,75,80);
		var_00.var_336 = "uplink_nozone";
		var_00 hide();
	}
}