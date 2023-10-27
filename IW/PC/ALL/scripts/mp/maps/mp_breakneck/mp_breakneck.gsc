/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_breakneck\mp_breakneck.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 949 ms
 * Timestamp: 10/27/2023 12:13:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0F88::main();
	scripts\mp\maps\mp_breakneck\gen\mp_breakneck_art::main();
	lib_0F87::main();
	level func_D80C();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_breakneck");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",4);
	setdvar("r_umbraShadowCasters",1);
	setdvar("sm_roundRobinPrioritySpotShadows",8);
	setdvar("r_umbraAccurateOcclusionThreshold",400);
	setdvar("sm_sunCascadeSizeMultiplier1",3);
	setdvar("sm_sunCascadeSizeMultiplier2",2);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	level func_2FBC();
	thread scripts\mp\_animation_suite::func_1FAA();
	thread fix_collision();
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("clip512x512x8","targetname");
	var_01 = spawn("script_model",(-43104,296,512));
	var_01.angles = (0,0,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("clip512x512x8","targetname");
	var_03 = spawn("script_model",(-43104,808,512));
	var_03.angles = (0,0,0);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = spawn("script_model",(-38963.5,-781.5,80));
	var_04.angles = (0,0,0);
	var_04 setmodel("cnd_electric_panels_004_grey_dk_mp_breakneck_patch");
	var_05 = spawn("script_model",(-40748.5,-520.5,80));
	var_05.angles = (0,180,0);
	var_05 setmodel("cnd_electric_panels_004_grey_dk_mp_breakneck_patch");
	var_05 = spawn("script_model",(-37408,288,80));
	var_05.angles = (0,270,0);
	var_05 setmodel("panel_metal_03_16x208_mp_parkour_patch");
	var_06 = spawn("script_model",(-37408,496,80));
	var_06.angles = (0,270,0);
	var_06 setmodel("panel_metal_03_16x208_mp_parkour_patch");
	var_07 = spawn("script_model",(-37504,208,80));
	var_07.angles = (0,180,0);
	var_07 setmodel("panel_metal_03_16x208_mp_parkour_patch");
	var_08 = spawn("script_model",(-39852,416,168));
	var_08.angles = (0,0,0);
	var_08 setmodel("mp_breakneck_missile_patch_01");
	var_09 = spawn("trigger_radius",(-37408,1056,-16),0,128,64);
	var_09.var_257 = 128;
	var_09.height = 64;
	thread killtriggerloop(var_09);
	var_0A = getent("player32x32x8","targetname");
	var_0B = spawn("script_model",(-40556,-288,294));
	var_0B.angles = (290,0,0);
	var_0B clonebrushmodeltoscriptmodel(var_0A);
	var_0C = spawn("script_model",(-39772,398,44));
	var_0C.angles = (70,270,90);
	var_0C setmodel("mp_breakneck_missile_patch_01");
	var_0D = getent("player32x32x256","targetname");
	var_0E = spawn("script_model",(-39288,1136,448));
	var_0E.angles = (0,45,0);
	var_0E clonebrushmodeltoscriptmodel(var_0D);
	var_0F = getent("player32x32x256","targetname");
	var_10 = spawn("script_model",(-37816,84,288));
	var_10.angles = (0,0,10);
	var_10 clonebrushmodeltoscriptmodel(var_0F);
	var_11 = getent("player32x32x8","targetname");
	var_12 = spawn("script_model",(-40188,-1052,324));
	var_12.angles = (0,0,75);
	var_12 clonebrushmodeltoscriptmodel(var_11);
	var_13 = getent("clip512x512x8","targetname");
	var_14 = spawn("script_model",(-40656,-1020,-180));
	var_14.angles = (0,0,90);
	var_14 clonebrushmodeltoscriptmodel(var_13);
	var_15 = getent("clip256x256x8","targetname");
	var_16 = spawn("script_model",(-40272,-1020,-52));
	var_16.angles = (0,0,90);
	var_16 clonebrushmodeltoscriptmodel(var_15);
	var_17 = getent("clip32x32x256","targetname");
	var_18 = spawn("script_model",(-39184,-1004,60));
	var_18.angles = (42,90,90);
	var_18 clonebrushmodeltoscriptmodel(var_17);
	var_19 = getent("clip32x32x128","targetname");
	var_1A = spawn("script_model",(-38952,-1004,60));
	var_1A.angles = (42,90,90);
	var_1A clonebrushmodeltoscriptmodel(var_19);
	var_1B = getent("player32x32x8","targetname");
	var_1C = spawn("script_model",(-41560,832,360));
	var_1C.angles = (285,0,0);
	var_1C clonebrushmodeltoscriptmodel(var_1B);
	var_1D = getent("player32x32x8","targetname");
	var_1E = spawn("script_model",(-38656,-820,112));
	var_1E.angles = (285,123,0);
	var_1E clonebrushmodeltoscriptmodel(var_1D);
	var_1F = getent("player32x32x8","targetname");
	var_20 = spawn("script_model",(-39596,1554,98));
	var_20.angles = (285,75,0);
	var_20 clonebrushmodeltoscriptmodel(var_1F);
	var_21 = getent("player256x256x8","targetname");
	var_22 = spawn("script_model",(-42360,832,376));
	var_22.angles = (0,0,90);
	var_22 clonebrushmodeltoscriptmodel(var_21);
	var_23 = getent("clip64x64x256","targetname");
	var_24 = spawn("script_model",(-41840,880,-160));
	var_24.angles = (0,0,0);
	var_24 clonebrushmodeltoscriptmodel(var_23);
	var_25 = getent("player512x512x8","targetname");
	var_26 = spawn("script_model",(-41352,1224,-112));
	var_26.angles = (90,0,0);
	var_26 clonebrushmodeltoscriptmodel(var_25);
	var_27 = getent("player512x512x8","targetname");
	var_28 = spawn("script_model",(-41096,1488,-112));
	var_28.angles = (0,0,90);
	var_28 clonebrushmodeltoscriptmodel(var_27);
	var_29 = getent("clip64x64x256","targetname");
	var_2A = spawn("script_model",(-38732,1632,144));
	var_2A.angles = (30,270,90);
	var_2A clonebrushmodeltoscriptmodel(var_29);
	var_2B = getent("player128x128x256","targetname");
	var_2C = spawn("script_model",(-37888,136,300));
	var_2C.angles = (0,0,0);
	var_2C clonebrushmodeltoscriptmodel(var_2B);
	var_2D = getent("player128x128x256","targetname");
	var_2E = spawn("script_model",(-37888,136,556));
	var_2E.angles = (0,0,0);
	var_2E clonebrushmodeltoscriptmodel(var_2D);
	var_2F = getent("player256x256x8","targetname");
	var_30 = spawn("script_model",(-40264,-920,424));
	var_30.angles = (90,0,0);
	var_30 clonebrushmodeltoscriptmodel(var_2F);
	var_31 = getent("player256x256x8","targetname");
	var_32 = spawn("script_model",(-40264,-920,680));
	var_32.angles = (90,0,0);
	var_32 clonebrushmodeltoscriptmodel(var_31);
	var_33 = spawn("trigger_radius",(-41840,-640,-144),0,144,208);
	var_33.var_257 = 144;
	var_33.height = 208;
	thread killtriggerloop(var_33);
}

//Function Number: 3
killtriggerloop(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01))
		{
			if(isplayer(var_01))
			{
				var_01 suicide();
				continue;
			}

			if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
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
}

//Function Number: 4
func_D80C()
{
	level.var_2B31 = ["superstructure_hull_chunk_01","superstructure_hull_chunk_02","debris_exterior_damaged_metal_panels_01","debris_exterior_damaged_metal_panels_02","debris_exterior_damaged_metal_panels_03","debris_exterior_damaged_metal_panels_08","machinery_tower_pipe_beam_support_01_destroyed"];
	foreach(var_01 in level.var_2B31)
	{
		precachemodel(var_01);
	}

	level.var_871B = ["weapon_spas12_wm","weapon_ripper_rare_wm","weapon_vr_rifle_wm"];
	foreach(var_04 in level.var_871B)
	{
		precachemodel(var_04);
	}

	precachemodel("armory_weapon_locker_clamp_bn");
}

//Function Number: 5
func_2FBC()
{
	if(getdvar("r_reflectionProbeGenerate") != "1")
	{
		thread func_CDA4("mp_breakneck_collision_bink_01");
		thread func_FA92();
		thread func_226A();
	}
}

//Function Number: 6
func_226A()
{
	scripts\common\utility::func_136F7();
	if(isdefined(scripts\common\utility::getstruct("gunrack_up","targetname")) && isdefined(scripts\common\utility::getstruct("gunrack_down","targetname")))
	{
		level.var_871A = spawnstruct();
		level.var_871A.var_12F6C = spawnstruct();
		level.var_871A.var_12F6C.var_10B89 = scripts\common\utility::getstruct("gunrack_up","targetname");
		level.var_871A.var_12F6C.var_62A3 = scripts\common\utility::getstruct(level.var_871A.var_12F6C.var_10B89.target,"targetname");
		level.var_871A.var_12F6C.var_871C = func_226B(level.var_871A.var_12F6C.var_10B89.origin,1);
		level.var_871A.var_5AF4 = spawnstruct();
		level.var_871A.var_5AF4.var_10B89 = scripts\common\utility::getstruct("gunrack_down","targetname");
		level.var_871A.var_5AF4.var_62A3 = scripts\common\utility::getstruct(level.var_871A.var_5AF4.var_10B89.target,"targetname");
		level.var_871A.var_5AF4.var_871C = func_226B(level.var_871A.var_5AF4.var_10B89.origin,0);
		level.var_871A.var_12F6C thread func_2268();
		level.var_871A.var_5AF4 thread func_2268();
	}
}

//Function Number: 7
func_226B(param_00,param_01)
{
	level endon("game_ended");
	var_02 = [];
	for(;;)
	{
		var_03 = spawn("script_model",(0,0,0));
		var_03 setmodel("armory_weapon_locker_clamp_bn");
		var_03.var_870F = spawn("script_model",(0,0,0));
		var_03.var_870F setmodel("tag_origin");
		var_03.var_870F.var_C370 = [];
		if(param_01 == 1)
		{
			var_03.angles = (90,0,0);
			var_03.var_870F.angles = (0,354,0);
			var_03.var_870F.var_C370["weapon_spas12_wm"] = (-15.7,-5,3.2);
			var_03.var_870F.var_C370["weapon_ripper_rare_wm"] = (-14.1,-3.7,2.8);
			var_03.var_870F.var_C370["weapon_vr_rifle_wm"] = (-15.5,-4.8,2.3);
		}
		else
		{
			var_03.angles = (90,0,-180);
			var_03.var_870F.angles = (0,174,0);
			var_03.var_870F.var_C370["weapon_spas12_wm"] = (15.7,5,3.2);
			var_03.var_870F.var_C370["weapon_ripper_rare_wm"] = (14.1,3.7,2.8);
			var_03.var_870F.var_C370["weapon_vr_rifle_wm"] = (15.5,4.8,2.3);
		}

		var_03.var_870F linkto(var_03);
		var_03.origin = param_00;
		var_02[var_02.size] = var_03;
		if(var_02.size == 10)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 8
func_2268()
{
	foreach(var_01 in self.var_871C)
	{
		thread func_2269(var_01);
		wait(8);
	}
}

//Function Number: 9
func_2269(param_00)
{
	for(;;)
	{
		param_00.var_870F unlink();
		param_00 dontinterpolate();
		param_00.origin = self.var_10B89.origin;
		scripts\common\utility::func_136F7();
		if(randomint(100) < 90)
		{
			param_00.var_870F setmodel(scripts\common\utility::random(level.var_871B));
			param_00.var_870F.origin = param_00.origin + param_00.var_870F.var_C370[param_00.var_870F.model];
		}
		else
		{
			param_00.var_870F setmodel("tag_origin");
			param_00.var_870F.origin = param_00.origin;
		}

		param_00.var_870F linkto(param_00);
		param_00 moveto(self.var_62A3.origin,80);
		param_00 waittill("movedone");
	}
}

//Function Number: 10
func_FA92()
{
	level.var_2B2F = spawnstruct();
	level thread func_FA94();
}

//Function Number: 11
func_FA94()
{
	if(!isdefined(game["roundsPlayed"]))
	{
		level.var_2B2F.var_DAE3 = scripts\common\utility::getstruct("breakneck_blackhole_target_loc","script_noteworthy");
		level.var_2B2F.var_DAE5 = func_FA93(scripts\common\utility::getstructarray("breakneck_blackhole_spawn_loc","script_noteworthy"));
		level.var_2B2F.var_DAE4 = getentarray("breakneck_blackhole_pull","targetname");
		if(isdefined(level.var_2B2F.var_DAE3))
		{
			if(level.var_2B2F.var_DAE3.size != 0)
			{
				scripts\common\utility::array_thread(level.var_2B2F.var_DAE5,::func_139AE);
			}

			if(level.var_2B2F.var_DAE4.size != 0)
			{
				level thread func_139AF();
			}
		}
	}

	level thread func_2B44();
}

//Function Number: 12
func_FA93(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = spawn("script_model",var_03.origin);
		var_04 setmodel("tag_origin");
		var_04.angles = (0,0,0);
		var_04.var_2887 = var_04.origin;
		var_04.var_CB0B = 0;
		var_04.var_C2CD = 0;
		var_01[var_01.size] = var_04;
	}

	return var_01;
}

//Function Number: 13
func_2B44()
{
	level waittill("match_start_real_countdown");
	var_00 = getscriptablearray("scriptable_spawn_pulls","targetname");
	if(game["roundsPlayed"] == 0)
	{
		foreach(var_02 in var_00)
		{
			var_02 setscriptablepartstate("default","countdown_anim");
		}

		return;
	}

	foreach(var_02 in var_02)
	{
		var_02 setscriptablepartstate("default","fast_anim");
	}
}

//Function Number: 14
func_139AE()
{
	level endon("game_ended");
	wait(randomint(15));
	for(;;)
	{
		self.angles = (scripts\common\utility::func_4347() * randomint(360),scripts\common\utility::func_4347() * randomint(360),scripts\common\utility::func_4347() * randomint(360));
		self setmodel(scripts\common\utility::random(level.var_2B31));
		self moveto(level.var_2B2F.var_DAE3.origin,60 + scripts\common\utility::func_4347() * randomint(15),0,0);
		self method_8269((scripts\common\utility::func_4347() * randomint(360),scripts\common\utility::func_4347() * randomint(360),scripts\common\utility::func_4347() * randomint(360)),30,0,0);
		self waittill("movedone");
		wait(15 + scripts\common\utility::func_4347() * randomint(15));
		self dontinterpolate();
		self.origin = self.var_2887;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 15
func_139AF()
{
	level endon("game_ended");
	foreach(var_01 in level.var_2B2F.var_DAE4)
	{
		var_01.var_CB0B = 0;
	}

	for(;;)
	{
		wait(15 + scripts\common\utility::func_4347() * randomint(15));
		var_03 = scripts\common\utility::random(level.var_2B2F.var_DAE4);
		var_03 thread func_2B43();
		level.var_2B2F.var_DAE4 = scripts\common\utility::func_22A9(level.var_2B2F.var_DAE4,var_03);
		if(level.var_2B2F.var_DAE4.size == 0)
		{
			break;
		}
	}
}

//Function Number: 16
func_2B43()
{
	level endon("game_ended");
	self endon("death");
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	var_00 = scripts\common\utility::spawn_tag_origin(self.origin + (0,0,32),self.angles);
	var_00 show();
	var_01 = vectortoangles(level.var_2B2F.var_DAE3.origin - self.origin);
	self rotateto(var_01,1);
	wait(1);
	self moveto(level.var_2B2F.var_DAE3.origin,60 + scripts\common\utility::func_4347() * randomint(15),0,0);
	wait(0.1);
	playfxontag(level._effect["vfx_breakneck_explosion_01"],var_00,"tag_origin");
	self rotatevelocity((var_01[0] / 4,0,0),30);
	self waittill("movedone");
	stopfxontag(level._effect["vfx_breakneck_explosion_01"],var_00,"tag_origin");
	var_00 delete();
	self delete();
}

//Function Number: 17
func_CDA4(param_00)
{
	wait(30);
	function_030E(param_00);
}