/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 898 ms
 * Timestamp: 10/27/2023 1:59:38 AM
*******************************************************************/

//Function Number: 1
light_init()
{
	if(!isdefined(level._light))
	{
		level._light = spawnstruct();
		light_setup_global_dvars();
		light_setup_common_dof_presets();
		light_setup_common_dof_viewmodel_presets();
		light_setup_common_flickerlight_presets();
		light_setup_pulse_presets();
		light_message_init();
		thread init_scriptable_primary_lights();
	}
}

//Function Number: 2
init_scriptable_primary_lights()
{
	level.scriptable_primary_light_override = 0;
	level.scr_prim_light = undefined;
	wait(0.05);
}

//Function Number: 3
execute_scriptable_primary_light(param_00)
{
	var_01 = level.scr_prim_lght[param_00];
	var_01.state = 0;
	var_01.trans_time[0] = 0;
	thread execute_primary_light_setkey_internal(0,var_01);
	for(var_04 = 1;var_04 < var_01.trans_time.size;var_04++)
	{
		maps\_utility::delaythread(var_01.time[var_04],::execute_primary_light_setkey_internal,var_04,var_01);
	}
}

//Function Number: 4
scriptable_primary_light_think(param_00,param_01)
{
	var_02 = getdvarint("scr_prim_edit_lights");
	var_03 = getdvarint("scr_prim_light_state");
	var_04 = getdvarint("scr_prim_light_num");
	var_05 = param_00.intensity["curr"];
	while(param_00.active)
	{
		var_06 = param_00.pos["curr"];
		var_07 = param_00.dir["curr"];
		var_08 = vectornormalize(anglestoforward(param_00.dir["curr"]));
		var_09 = param_00.pos["curr"];
		var_0A = param_00.intensity["curr"];
		var_0B = param_00.color["curr"];
		var_0C = param_00.innercone["curr"];
		var_0D = param_00.outercone["curr"];
		var_0E = param_00.radius["curr"];
		var_0F = param_00.light_number;
		if(isdefined(param_00.attach_ent))
		{
			var_13 = param_00.attach_tag.origin;
			var_14 = vectornormalize(anglestoforward(param_00.attach_tag.angles));
			var_15 = vectornormalize(anglestoup(param_00.attach_tag.angles));
			var_16 = vectornormalize(anglestoright(param_00.attach_tag.angles));
			var_17 = vectornormalize(var_14 * var_08[0] + var_15 * var_08[2] - var_16 * var_08[1]);
			var_18 = var_14 * var_06[0] + var_15 * var_06[2] - var_16 * var_06[1];
			param_00.primary_light unlink();
			param_00.primary_light.angles = vectortoangles(var_17);
			param_00.primary_light.origin = var_13 + var_18;
			if(isdefined(param_00.coi_ent))
			{
				var_19 = param_00.coi_ent gettagorigin(param_00.coi_bone);
				param_00.primary_light.angles = vectortoangles(vectornormalize(var_19 - param_00.primary_light.origin));
			}

			if(isdefined(param_00.coi_pos))
			{
				param_00.primary_light.angles = vectortoangles(vectornormalize(param_00.coi_pos - param_00.primary_light.origin));
			}

			param_00.primary_light linkto(param_00.attach_tag);
		}
		else
		{
			param_00.primary_light.angles = var_07;
			if(isdefined(param_00.coi_ent))
			{
				var_19 = param_00.coi_ent gettagorigin(param_00.coi_bone);
				param_00.primary_light.angles = vectortoangles(vectornormalize(var_19 - param_00.primary_light.origin));
			}

			if(isdefined(param_00.coi_pos))
			{
				param_00.primary_light.angles = vectortoangles(vectornormalize(param_00.coi_pos - param_00.primary_light.origin));
			}

			param_00.primary_light.origin = var_06;
		}

		param_00.primary_light setlightintensity(var_0A);
		param_00.primary_light setlightcolor(var_0B);
		param_00.primary_light setlightfovrange(var_0D,var_0C);
		param_00.primary_light setlightradius(var_0E);
		wait(0.05);
	}
}

//Function Number: 5
execute_primary_light_setkey_internal(param_00,param_01)
{
	var_02 = param_01.trans_time[param_00] * 20;
	var_03 = param_00 - 1;
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		var_05 = float(var_04) / var_02;
		var_06 = 1 - var_05;
		param_01.pos["curr"] = param_01.pos[param_00] * var_05 + param_01.pos[var_03] * var_06;
		param_01.dir["curr"] = param_01.dir[param_00] * var_05 + param_01.dir[var_03] * var_06;
		param_01.intensity["curr"] = param_01.intensity[param_00] * var_05 + param_01.intensity[var_03] * var_06;
		param_01.color["curr"] = param_01.color[param_00] * var_05 + param_01.color[var_03] * var_06;
		param_01.innercone["curr"] = param_01.innercone[param_00] * var_05 + param_01.innercone[var_03] * var_06;
		param_01.outercone["curr"] = param_01.outercone[param_00] * var_05 + param_01.outercone[var_03] * var_06;
		param_01.radius["curr"] = param_01.radius[param_00] * var_05 + param_01.radius[var_03] * var_06;
		wait(0.05);
	}

	param_01.pos["curr"] = param_01.pos[param_00];
	param_01.dir["curr"] = param_01.dir[param_00];
	param_01.intensity["curr"] = param_01.intensity[param_00];
	param_01.color["curr"] = param_01.color[param_00];
	param_01.innercone["curr"] = param_01.innercone[param_00];
	param_01.outercone["curr"] = param_01.outercone[param_00];
	param_01.radius["curr"] = param_01.radius[param_00];
	param_01.state = param_00;
}

//Function Number: 6
stop_scriptable_primary_light(param_00)
{
	var_01 = level.scr_prim_lght[param_00];
	var_01.active = 0;
	if(isdefined(var_01.attach_ent))
	{
		if(isdefined(var_01.primary_light))
		{
			var_01.primary_light unlink();
		}
	}
}

//Function Number: 7
setup_scriptable_primary_light(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = 5000;
	}

	if(!isdefined(param_05))
	{
		param_05 = (1,1,1);
	}

	if(!isdefined(param_06))
	{
		param_06 = 60;
	}

	if(!isdefined(param_07))
	{
		param_07 = 120;
	}

	if(!isdefined(param_0A))
	{
		param_0A = 50;
	}

	var_0B = spawnstruct();
	var_0B.light_number = param_01;
	var_0B.time[0] = 0;
	var_0B.dir[0] = param_03;
	var_0B.pos[0] = param_02;
	var_0B.active = 1;
	var_0B.color[0] = param_05;
	var_0B.innercone[0] = param_06;
	var_0B.outercone[0] = param_07;
	var_0B.radius[0] = param_0A;
	var_0B.intensity[0] = param_04;
	var_0B.trans_time[0] = 0;
	var_0B.dir["curr"] = param_03;
	var_0B.pos["curr"] = param_02;
	var_0B.color["curr"] = param_05;
	var_0B.innercone["curr"] = param_06;
	var_0B.outercone["curr"] = param_07;
	var_0B.radius["curr"] = param_0A;
	var_0B.intensity["curr"] = 0.1;
	var_0B.state = -1;
	var_0B.primary_light = getent(param_00,"targetname");
	var_0B.attach_ent = undefined;
	var_0B.attach_bone = undefined;
	var_0C = undefined;
	if(isstring(param_08))
	{
		if(isstring(param_08))
		{
			var_0C = getent(param_08,"targetname");
			var_0B.attach_ent = var_0C;
		}
	}
	else
	{
		var_0C = param_08;
	}

	if(isdefined(var_0C))
	{
		var_0B.attach_ent = var_0C;
		if(!isdefined(var_0B.attach_ent))
		{
			var_0B.attach_ent = undefined;
		}

		if(isdefined(param_09) && isdefined(var_0B.attach_ent))
		{
			var_0B.attach_bone = param_09;
		}
		else
		{
			var_0B.attach_bone = undefined;
		}

		var_0B.attach_tag = common_scripts\utility::spawn_tag_origin();
		if(isdefined(param_09))
		{
			var_0B.attach_tag.origin = var_0C gettagorigin(param_09);
			var_0B.attach_tag linkto(var_0C,param_09,(0,0,0),(0,0,0));
		}
		else
		{
			var_0B.attach_tag.origin = var_0C.origin;
			var_0B.attach_tag linkto(var_0C);
		}

		var_0D = var_0B.attach_tag.origin;
		var_0E = vectornormalize(anglestoforward(var_0B.attach_tag.angles));
		var_0F = vectornormalize(anglestoup(var_0B.attach_tag.angles));
		var_10 = vectornormalize(anglestoright(var_0B.attach_tag.angles));
		var_11 = vectornormalize(var_0E * param_03[0] + var_0F * param_03[2] - var_10 * param_03[1]);
		var_12 = var_0E * param_02[0] + var_0F * param_02[2] - var_10 * param_02[1];
		var_0B.primary_light.angles = vectortoangles(var_11);
		var_0B.primary_light.origin = var_0D + var_12;
		if(!isdefined(var_0B.primary_light.linkedtotag))
		{
			var_0B.primary_light.linkedtotag = 1;
			var_0B.primary_light enablelinkto();
		}

		var_0B.primary_light linkto(var_0B.attach_tag);
	}
	else
	{
		var_0B.attach_ent = undefined;
		var_0B.attach_bone = undefined;
	}

	var_13 = 0;
	if(isdefined(level.scr_prim_lght))
	{
		var_13 = level.scr_prim_lght.size;
	}

	var_0B.id = var_13;
	level.scr_prim_lght[var_13] = var_0B;
	thread scriptable_primary_light_think(var_0B,var_0B.id);
	return var_0B.id;
}

//Function Number: 8
scriptable_primary_light_centerofinterest(param_00,param_01,param_02,param_03)
{
	var_04 = level.scr_prim_lght[param_00];
	if(isdefined(param_02))
	{
		param_01 = undefined;
		if(!isdefined(param_03))
		{
			param_03 = "tag_origin";
		}
	}
	else if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	level.scr_prim_lght[param_00].coi_bone = param_03;
	level.scr_prim_lght[param_00].coi_pos = param_01;
	level.scr_prim_lght[param_00].coi_ent = param_02;
}

//Function Number: 9
scriptable_primary_light_setstate_color(param_00,param_01,param_02,param_03)
{
	scriptable_primary_light_setstate(param_00,param_01,undefined,undefined,undefined,param_02,undefined,undefined,undefined,param_03);
}

//Function Number: 10
scriptable_primary_light_setstate_pos(param_00,param_01,param_02,param_03)
{
	scriptable_primary_light_setstate(param_00,param_01,param_02,undefined,undefined,undefined,undefined,undefined,undefined,param_03);
}

//Function Number: 11
scriptable_primary_light_setstate_dir(param_00,param_01,param_02,param_03)
{
	scriptable_primary_light_setstate(param_00,param_01,undefined,param_02,undefined,undefined,undefined,undefined,undefined,param_03);
}

//Function Number: 12
scriptable_primary_light_setstate_intensity(param_00,param_01,param_02,param_03)
{
	scriptable_primary_light_setstate(param_00,param_01,undefined,param_02,undefined,undefined,undefined,undefined,undefined,param_03);
}

//Function Number: 13
scriptable_primary_light_setstate_cone(param_00,param_01,param_02,param_03,param_04)
{
	scriptable_primary_light_setstate(param_00,param_01,undefined,undefined,undefined,param_02,param_03,undefined,undefined,param_04);
}

//Function Number: 14
scriptable_primary_light_setstate_radius(param_00,param_01,param_02,param_03)
{
	scriptable_primary_light_setstate(param_00,param_01,undefined,undefined,undefined,undefined,undefined,undefined,param_02,param_03);
}

//Function Number: 15
scriptable_primary_light_setstate(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.scr_prim_lght[param_00];
	var_0B = var_0A.time.size;
	if(!isdefined(param_03))
	{
		param_03 = var_0A.dir[var_0B - 1];
	}

	if(!isdefined(param_02))
	{
		param_02 = var_0A.pos[var_0B - 1];
	}

	if(!isdefined(param_04))
	{
		param_04 = var_0A.intensity[var_0B - 1];
	}

	if(!isdefined(param_05))
	{
		param_05 = var_0A.color[var_0B - 1];
	}

	if(!isdefined(param_06))
	{
		param_06 = var_0A.innercone[var_0B - 1];
	}

	if(!isdefined(param_07))
	{
		param_07 = var_0A.outercone[var_0B - 1];
	}

	if(!isdefined(param_08))
	{
		param_08 = var_0A.radius[var_0B - 1];
	}

	var_0A.time[var_0B] = param_01;
	var_0A.pos[var_0B] = param_02;
	var_0A.dir[var_0B] = param_03;
	var_0A.intensity[var_0B] = param_04;
	var_0A.color[var_0B] = param_05;
	var_0A.innercone[var_0B] = param_06;
	var_0A.outercone[var_0B] = param_07;
	var_0A.radius[var_0B] = param_08;
	var_0A.trans_time[var_0B] = param_09;
}

//Function Number: 16
light_setup_global_dvars()
{
	if(isusinghdr())
	{
		setsaveddvar("r_veil",1);
		setsaveddvar("r_veilStrength",0.087);
		setsaveddvar("r_tonemap",2);
		setsaveddvar("r_tonemapBlack",0);
		setsaveddvar("r_tonemapCrossover",1);
		setsaveddvar("r_tonemapHighlightRange",16);
		setsaveddvar("r_tonemapDarkEv",2.84);
		setsaveddvar("r_tonemapMidEv",7.823);
		setsaveddvar("r_tonemapLightEv",12.81);
		setsaveddvar("r_tonemapDarkExposureAdjust",-3.17);
		setsaveddvar("r_tonemapMidExposureAdjust",-0.0651);
		setsaveddvar("r_tonemapLightExposureAdjust",1.47);
		setsaveddvar("r_tonemapMinExposureAdjust",-3.17);
		setsaveddvar("r_tonemapMaxExposureAdjust",2.3);
		if(level.ps4)
		{
			setsaveddvar("r_tonemapShoulder",0.4);
		}
		else
		{
			setsaveddvar("r_tonemapShoulder",0.94);
		}

		setsaveddvar("r_tonemapToe",0);
		setsaveddvar("r_tonemapWhite",512);
		setsaveddvar("r_tonemapAdaptSpeed",0.02);
		setsaveddvar("r_tonemapLockAutoExposureAdjust",0);
		setsaveddvar("r_tonemapAutoExposureAdjust",0);
		setsaveddvar("r_tonemapExposure",-10);
		setsaveddvar("r_tonemapMaxExposure",-10);
	}

	if(isusingssao())
	{
		setsaveddvar("r_ssaoPower",12);
		setsaveddvar("r_ssaoStrength",0.45);
		setsaveddvar("r_ssaominstrengthdepth",25);
		setsaveddvar("r_ssaomaxstrengthdepth",40);
	}
}

//Function Number: 17
screen_effect_base(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = newclienthudelem(level.player);
	var_08.x = 0;
	var_08.y = 0;
	var_08.splatter = 1;
	var_08.alignx = "left";
	var_08.aligny = "top";
	var_08.sort = 1;
	var_08.foreground = 0;
	var_08.horzalign = "fullscreen";
	var_08.vertalign = "fullscreen";
	var_08.alpha = param_04;
	var_08 thread cleanup_overlay();
	if(isdefined(param_05))
	{
		var_08.x = param_05;
	}

	if(isdefined(param_06))
	{
		var_08.y = param_06;
	}

	if(isdefined(param_07))
	{
		var_08.sort = param_07;
	}

	if(isarray(param_01))
	{
		foreach(var_0A in param_01)
		{
			var_08 setshader(var_0A,640,480);
		}
	}
	else
	{
		var_08 setshader(param_01,640,480);
	}

	if(param_00 > 0)
	{
		var_08.alpha = 0;
		var_0C = 1;
		if(isdefined(param_02))
		{
			var_0C = param_02;
		}

		var_0D = 1;
		if(isdefined(param_03))
		{
			var_0D = param_03;
		}

		var_0E = 1;
		if(isdefined(param_04))
		{
			var_0E = clamp(param_04,0,1);
		}

		var_0F = 0.05;
		if(var_0C > 0)
		{
			var_10 = 0;
			var_11 = var_0E / var_0C / var_0F;
			while(var_10 < var_0E)
			{
				var_08.alpha = var_10;
				var_10 = var_10 + var_11;
				wait(var_0F);
			}
		}

		var_08.alpha = var_0E;
		wait(param_00 - var_0C + var_0D);
		if(var_0D > 0)
		{
			var_10 = var_0E;
			var_12 = var_0E / var_0D / var_0F;
			while(var_10 > 0)
			{
				var_08.alpha = var_10;
				var_10 = var_10 - var_12;
				wait(var_0F);
			}
		}

		var_08.alpha = 0;
		var_08 destroy();
	}

	level.overlay = var_08;
	return level.overlay;
}

//Function Number: 18
cleanup_overlay()
{
	level waittill("end_screen_effect");
	self destroy();
}

//Function Number: 19
blood_splatter_simple()
{
}

//Function Number: 20
dirt_splatter_simple()
{
	var_00 = newclienthudelem(level.player);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("fullscreen_dirt_bottom",640,480);
	var_00 setshader("fullscreen_dirt_bottom_b",640,480);
	var_00 setshader("fullscreen_dirt_left",640,480);
	var_00 setshader("fullscreen_dirt_right",640,480);
	var_00.splatter = 1;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.foreground = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 1;
	var_00 fadeovertime(3);
	var_00.alpha = 0;
}

//Function Number: 21
bob_mask(param_00)
{
	self endon("stop_mask_bob");
	var_01 = 0;
	var_02 = level.player getplayerangles();
	var_03 = 0;
	var_04 = 0;
	var_05 = param_00.y;
	var_06 = param_00.x;
	var_07 = 0.05;
	for(;;)
	{
		if(isdefined(param_00))
		{
			var_08 = level.player getplayerangles();
			var_09 = level.player getvelocity();
			var_0A = var_09[2];
			var_09 = var_09 - var_09 * (0,0,1);
			var_0B = length(var_09);
			var_0C = level.player getstance();
			var_0D = clamp(var_0B,0,280) / 280;
			var_0E = 0.1 + var_0D * 0.25;
			var_0F = 0.1 + var_0D * 0.25;
			var_10 = 1;
			if(var_0C == "crouch")
			{
				var_10 = 0.75;
			}

			if(var_0C == "prone")
			{
				var_10 = 0.4;
			}

			if(var_0C == "stand")
			{
				var_10 = 1;
			}

			var_11 = 5;
			var_12 = 0.9;
			var_13 = level.player playerads();
			var_14 = var_11 * 1 - var_13 + var_12 * var_13;
			var_14 = var_14 * 1 + var_0D * 2;
			var_15 = 5;
			var_16 = var_15 * var_0E * var_10;
			var_17 = var_15 * var_0F * var_10;
			var_01 = var_01 + var_07 * 1000 * var_14;
			var_18 = 57.29578;
			var_19 = sin(var_01 * 0.001 * var_18);
			var_1A = sin(var_01 * 0.0007 * var_18);
			var_1B = angleclamp180(var_08[1] - var_02[1]);
			var_1B = clamp(var_1B,-10,10);
			var_1C = var_1B / 10 * var_15 * 1 - var_0E;
			var_1D = var_1C - var_04;
			var_04 = var_04 + clamp(var_1D,-1,1);
			var_1E = clamp(var_0A,-200,200) / 200 * var_15 * 1 - var_0F;
			var_1F = var_1E - var_03;
			var_03 = var_03 + clamp(var_1F,-0.6,0.6);
			param_00 moveovertime(0.05);
			param_00.x = var_06 + clamp(var_19 * var_16 + var_04 - var_15,0 - 2 * var_15,0);
			param_00.y = var_05 + clamp(var_1A * var_17 + var_03 - var_15,0 - 2 * var_15,0);
			var_02 = var_08;
		}

		wait(var_07);
	}
}

//Function Number: 22
gasmask_on_player(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.25;
	}

	if(param_00)
	{
		maps\_hud_util::fade_out(param_01);
	}

	self.gasmask_hud_elem = newclienthudelem(self);
	self.gasmask_hud_elem.x = 0;
	self.gasmask_hud_elem.y = 0;
	self.gasmask_hud_elem.horzalign = "fullscreen";
	self.gasmask_hud_elem.vertalign = "fullscreen";
	self.gasmask_hud_elem.foreground = 0;
	self.gasmask_hud_elem.sort = -1;
	self.gasmask_hud_elem setshader("gasmask_overlay_delta2_top",650,138);
	self.gasmask_hud_elem.alpha = 1;
	self.gasmask_hud_elem1 = newclienthudelem(self);
	self.gasmask_hud_elem1.x = 0;
	self.gasmask_hud_elem1.y = 352;
	self.gasmask_hud_elem1.horzalign = "fullscreen";
	self.gasmask_hud_elem1.vertalign = "fullscreen";
	self.gasmask_hud_elem1.foreground = 0;
	self.gasmask_hud_elem1.sort = -1;
	self.gasmask_hud_elem1 setshader("gasmask_overlay_delta2_bottom",650,138);
	self.gasmask_hud_elem1.alpha = 1;
	level.player maps\_utility::delaythread(1,::gasmask_breathing);
	thread bob_mask(self.gasmask_hud_elem);
	thread bob_mask(self.gasmask_hud_elem1);
	if(param_00)
	{
		wait(param_03);
		maps\_hud_util::fade_in(param_02);
	}
}

//Function Number: 23
gasmask_off_player()
{
	maps\_hud_util::fade_out(0.25);
	self notify("stop_mask_bob");
	if(isdefined(self.gasmask_hud_elem))
	{
		self.gasmask_hud_elem destroy();
		self.gasmask_hud_elem = undefined;
	}

	if(isdefined(self.gasmask_hud_elem1))
	{
		self.gasmask_hud_elem1 destroy();
		self.gasmask_hud_elem1 = undefined;
	}

	level.player notify("stop_breathing");
	wait(0.25);
	maps\_hud_util::fade_in(1.5);
}

//Function Number: 24
gasmask_breathing()
{
	var_00 = 1;
	self endon("stop_breathing");
	for(;;)
	{
		maps\_utility::play_sound_on_entity("breathing_gasmask");
		wait(var_00);
	}
}

//Function Number: 25
gasmask_on_npc()
{
	self.gasmask = spawn("script_model",(0,0,0));
	self.gasmask setmodel("prop_sas_gasmask");
	self.gasmask linkto(self,"tag_eye",(-4,0,2),(120,0,0));
}

//Function Number: 26
gasmask_off_npc()
{
	if(isdefined(self.gasmask))
	{
		self.gasmask delete();
	}
}

//Function Number: 27
light_setup_common_flickerlight_presets()
{
	create_flickerlight_preset("fire",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,8);
	create_flickerlight_preset("blue_fire",(0.445098,0.62451,0.972549),(0.05,0.150451,0.3078432),0.005,0.2,8);
	create_flickerlight_preset("white_fire",(0.972549,0.972549,0.972549),(0.2,0.2,0.2),0.005,0.2,8);
	create_flickerlight_preset("white_fire_dim",(0.972549,0.972549,0.972549),(0.2,0.2,0.2),0.005,0.2,0.5);
	create_flickerlight_preset("street_light",(0.972549,0.972549,0.972549),(0.572549,0.572549,0.572549),0.005,0.2,8);
	create_flickerlight_preset("pulse",(0,0,0),(255,107,107),0.2,1,8);
	create_flickerlight_preset("lightbulb",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,6);
	create_flickerlight_preset("fluorescent",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,7);
	create_flickerlight_preset("static_screen",(0.63,0.72,0.92),(0.4,0.43,0.48),0.005,0.2,7);
	create_flickerlight_preset("sfb_fire",(1,0.65,0.8),(0.4,0.24,0.3),0.005,0.2,8);
}

//Function Number: 28
create_flickerlight_motion_preset(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level._light.flicker_motion_presets))
	{
		level._light.flicker_motion_presets = [];
	}

	var_06 = spawnstruct();
	var_06.color = param_01;
	var_06.intensity = param_02;
	var_06.maxmove = param_03;
	var_06.mindelay = param_04;
	var_06.maxdelay = param_05;
	level._light.flicker_motion_presets[param_00] = var_06;
}

//Function Number: 29
get_flickerlight_motion_preset(param_00)
{
	if(isdefined(level._light.flicker_motion_presets) && isdefined(level._light.flicker_motion_presets[param_00]))
	{
		return level._light.flicker_motion_presets[param_00];
	}

	return undefined;
}

//Function Number: 30
play_flickerlight_motion_preset(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = get_flickerlight_motion_preset(param_00);
	if(!isdefined(var_03))
	{
		return;
	}

	var_02 setlightintensity(var_03.intensity);
	var_02.islightflickering = 1;
	var_02.islightflickerpaused = 0;
	var_02 thread dyn_motion_flickerlight(var_03.color,var_03.intensity,var_03.maxmove,var_03.mindelay,var_03.maxdelay);
	return var_02;
}

//Function Number: 31
create_flickerlight_preset(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level._light.flicker_presets))
	{
		level._light.flicker_presets = [];
	}

	var_06 = spawnstruct();
	var_06.color0 = param_01;
	var_06.color1 = param_02;
	var_06.mindelay = param_03;
	var_06.maxdelay = param_04;
	var_06.intensity = param_05;
	level._light.flicker_presets[param_00] = var_06;
}

//Function Number: 32
get_flickerlight_preset(param_00)
{
	if(isdefined(level._light.flicker_presets) && isdefined(level._light.flicker_presets[param_00]))
	{
		return level._light.flicker_presets[param_00];
	}

	return undefined;
}

//Function Number: 33
play_flickerlight_preset(param_00,param_01,param_02)
{
	var_03 = getent(param_01,"targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = get_flickerlight_preset(param_00);
	if(!isdefined(var_04))
	{
		return;
	}

	if(isdefined(param_02))
	{
		if(param_02 < 0)
		{
			param_02 = 0;
		}

		var_04.intensity = param_02;
	}

	var_03 setlightintensity(var_04.intensity);
	var_03.islightflickering = 1;
	var_03.islightflickerpaused = 0;
	var_03 thread dyn_flickerlight(var_04.color0,var_04.color1,var_04.mindelay,var_04.maxdelay);
	return var_03;
}

//Function Number: 34
stop_flickerlight(param_00,param_01,param_02)
{
	var_03 = getent(param_01,"targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	if(!isdefined(var_03.islightflickering))
	{
		return;
	}

	if(isdefined(param_02))
	{
		if(param_02 < 0)
		{
			param_02 = 0;
		}
	}

	var_03 setlightintensity(param_02);
	var_03 notify("kill_flicker");
	var_03.islightflickering = undefined;
}

//Function Number: 35
pause_flickerlight(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_02.islightflickering))
	{
		return;
	}

	var_02.islightflickerpaused = 1;
}

//Function Number: 36
unpause_flickerlight(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_02.islightflickering))
	{
		return;
	}

	var_02.islightflickerpaused = 0;
}

//Function Number: 37
dyn_flickerlight(param_00,param_01,param_02,param_03)
{
	self endon("kill_flicker");
	var_04 = param_00;
	var_05 = 0;
	for(;;)
	{
		if(self.islightflickerpaused)
		{
			wait(0.05);
			continue;
		}

		var_06 = var_04;
		var_04 = param_00 + param_01 - param_00 * randomfloat(1);
		if(param_02 != param_03)
		{
			var_05 = var_05 + randomfloatrange(param_02,param_03);
		}
		else
		{
			var_05 = var_05 + param_02;
		}

		if(var_05 == 0)
		{
			var_05 = var_05 + 1E-07;
		}

		var_07 = var_06 - var_04 * 1 / var_05;
		while(var_05 > 0 && !self.islightflickerpaused)
		{
			self setlightcolor(var_04 + var_07 * var_05);
			wait(0.05);
			var_05 = var_05 - 0.05;
		}
	}
}

//Function Number: 38
dyn_motion_flickerlight(param_00,param_01,param_02,param_03,param_04)
{
	self endon("kill_flicker");
	self setlightcolor(param_00);
	self setlightintensity(param_01);
	thread fire_flicker();
	var_05 = self.origin;
	var_06 = param_02;
	var_07 = param_02;
	var_08 = param_02;
	var_09 = param_03;
	var_0A = param_04;
	for(;;)
	{
		var_0B = randomfloatrange(var_09,var_0A);
		var_0C = var_06 * randomfloatrange(0.1,1);
		var_0D = var_07 * randomfloatrange(0.1,1);
		var_0E = var_08 * randomfloatrange(0.1,1);
		var_0F = var_05 + (var_0C,var_0D,var_0E);
		self moveto(var_0F,var_0B);
		wait(var_0B);
		while(self.islightflickerpaused)
		{
			wait(0.05);
		}
	}
}

//Function Number: 39
fire_flicker()
{
	var_00 = self getlightintensity();
	self endon("kill_flicker");
	var_01 = var_00;
	for(;;)
	{
		var_02 = randomfloatrange(var_00 * 0.5,var_00 * 1.2);
		var_03 = randomfloatrange(0.2,1);
		var_03 = var_03 * 0.75;
		while(self.islightflickerpaused)
		{
			wait(0.05);
		}

		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
			self setlightintensity(var_05);
			wait(0.05);
		}

		var_01 = var_02;
	}
}

//Function Number: 40
create_light_object(param_00,param_01)
{
	var_02 = spawnstruct();
	var_03 = getentarray(param_00,"script_noteworthy");
	var_02.lightents = [];
	var_02.modelents = [];
	foreach(var_05 in var_03)
	{
		if(var_05.classname == "script_model")
		{
			var_02.modelents[var_02.modelents.size] = var_05;
		}

		if(var_05.classname == "light_spot")
		{
			var_02.lightents[var_02.lightents.size] = var_05;
		}
	}

	var_02.fxid = param_01;
	return var_02;
}

//Function Number: 41
light_object_set_intensity(param_00,param_01,param_02)
{
	foreach(var_04 in self.lightents)
	{
		var_04 setlightintensity(param_00);
		var_04 setlightcolor(param_01);
	}

	if(param_02 && !isdefined(self.was_on))
	{
		common_scripts\_exploder::exploder(self.fxid);
		foreach(var_07 in self.modelents)
		{
			var_07 show();
		}

		self.was_on = 1;
		return;
	}

	if(isdefined(self.was_on) && !param_02)
	{
		maps\_utility::stop_exploder(self.fxid);
		foreach(var_07 in self.modelents)
		{
			var_07 hide();
		}

		self.was_on = undefined;
	}
}

//Function Number: 42
flickering_light(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 endon("kill_flicker");
	var_07 = 0;
	var_08 = 0;
	for(;;)
	{
		var_09 = var_07;
		var_07 = randomfloat(1);
		if(param_05 != param_06)
		{
			var_08 = var_08 + randomfloatrange(param_05,param_06);
		}
		else
		{
			var_08 = var_08 + param_06;
		}

		if(var_08 == 0)
		{
			var_08 = var_08 + 1E-07;
		}

		var_0A = var_07 - var_09 / var_08;
		while(var_08 > 0)
		{
			var_0B = var_07 - var_08 * var_0A;
			var_0C = vectorlerp(param_01,param_03,var_0B);
			var_0D = maps\_utility::linear_interpolate(var_0B,param_02,param_04);
			var_0E = var_0B > 0.5;
			param_00 light_object_set_intensity(var_0D,var_0C,var_0E);
			wait(0.05);
			var_08 = var_08 - 0.05;
		}
	}
}

//Function Number: 43
perlin_flickering_light(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 2;
	var_06 = 3;
	var_07 = 5;
	for(;;)
	{
		var_08 = clamp(perlinnoise2d(gettime() * 0.001 * var_05,0,var_06,2,var_07),0,1);
		var_09 = vectorlerp(param_01,param_03,var_08);
		var_0A = maps\_utility::linear_interpolate(var_08,param_02,param_04);
		var_0B = var_08 > 0.5;
		param_00 light_object_set_intensity(var_0A,var_09,var_0B);
		wait(0.05);
	}
}

//Function Number: 44
lerp_spot_intensity(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(level.currentgen && isdefined(var_03) == 0)
	{
		return;
	}

	var_04 = var_03 getlightintensity();
	var_03.endintensity = param_02;
	var_05 = 0;
	while(var_05 < param_01)
	{
		var_06 = var_04 + param_02 - var_04 * var_05 / param_01;
		var_05 = var_05 + 0.05;
		var_03 setlightintensity(var_06);
		wait(0.05);
	}

	var_03 setlightintensity(param_02);
}

//Function Number: 45
lerp_spot_intensity_array(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_06 = var_05 getlightintensity();
		var_05.endintensity = param_02;
		var_07 = 0;
		while(var_07 < param_01)
		{
			var_08 = var_06 + param_02 - var_06 * var_07 / param_01;
			var_07 = var_07 + 0.05;
			var_05 setlightintensity(var_08);
			wait(0.05);
		}

		var_05 setlightintensity(param_02);
	}
}

//Function Number: 46
lerp_spot_radius(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(level.currentgen && isdefined(var_03) == 0)
	{
		return;
	}

	var_04 = var_03 getlightradius();
	var_03.endradius = param_02;
	var_05 = 0;
	while(var_05 < param_01)
	{
		var_06 = var_04 + param_02 - var_04 * var_05 / param_01;
		var_05 = var_05 + 0.05;
		var_03 setlightradius(var_06);
		wait(0.05);
	}

	var_03 setlightradius(param_02);
}

//Function Number: 47
set_spot_intensity(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	if(level.currentgen && isdefined(var_02) == 0)
	{
		return;
	}

	var_02 setlightintensity(param_01);
}

//Function Number: 48
lerp_spot_color(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(level.currentgen && isdefined(var_03) == 0)
	{
		return;
	}

	var_04 = var_03 getlightcolor();
	var_03.endcolor = param_02;
	var_05 = 0;
	while(var_05 < param_01)
	{
		var_06 = var_04 + param_02 - var_04 * var_05 / param_01;
		var_05 = var_05 + 0.05;
		var_03 setlightcolor(var_06);
		wait(0.05);
	}

	var_03 setlightcolor(param_02);
}

//Function Number: 49
set_spot_color(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02 setlightcolor(param_01);
}

//Function Number: 50
light_setup_pulse_presets()
{
	create_pulselight_preset("red",0.1,0.1,10000,(1,0.2,0.2),2);
	create_pulselight_preset("red2",0.1,0.1,68200000,(1,0.2,0.2),2);
	create_pulselight_preset("yellow",0.1,0.1,68200000,(1,0.7,0.2),2);
	create_pulselight_preset("white",0.1,0.1,68200000,(1,1,1),2);
	create_pulselight_preset("turbine_pulse",0.1,0.1,10000,(0.9,0.9,1),2);
}

//Function Number: 51
create_pulselight_preset(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level._light.pulse_presets))
	{
		level._light.pulse_presets = [];
	}

	var_06 = spawnstruct();
	var_06.transition_on = param_01;
	var_06.transition_off = param_02;
	var_06.intensity = param_03;
	var_06.color01 = param_04;
	var_06.num = param_05;
	level._light.pulse_presets[param_00] = var_06;
}

//Function Number: 52
get_pulselight_preset(param_00)
{
	if(isdefined(level._light.pulse_presets) && isdefined(level._light.pulse_presets[param_00]))
	{
		return level._light.pulse_presets[param_00];
	}

	return undefined;
}

//Function Number: 53
play_pulse_preset(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 + param_01 + "_pulse";
	level notify(var_04);
	level endon(var_04);
	var_05 = getent(param_01,"targetname");
	if(!isdefined(var_05))
	{
		return;
	}

	var_06 = get_pulselight_preset(param_00);
	if(!isdefined(var_06))
	{
		return;
	}

	if(isdefined(param_02))
	{
		if(param_02 < 0)
		{
			param_02 = 0;
		}

		var_06.intensity = param_02;
	}

	var_05 setlightintensity(var_06.intensity);
	var_05 setlightcolor(var_06.color01);
	var_07 = var_06.num;
	var_08 = var_05 getlightintensity();
	var_09 = 0.05;
	var_0A = var_08;
	var_0B = var_06.transition_on;
	var_0C = var_06.transition_off;
	var_0D = var_08 - var_09 / var_0B / 0.05;
	var_0E = var_08 - var_09 / var_0C / 0.05;
	var_0F = var_06.num;
	for(;;)
	{
		var_10 = 1;
		var_11 = 0;
		while(var_11 < var_0C)
		{
			var_0A = var_0A - var_0E;
			var_0A = clamp(var_0A,0,1000000000);
			var_05 setlightintensity(var_0A);
			var_11 = var_11 + 0.05;
			wait(0.05);
		}

		if(isdefined(param_03))
		{
			maps\_utility::stop_exploder(param_03);
		}

		wait(0.8);
		var_11 = 0;
		while(var_11 < var_0B)
		{
			var_0A = var_0A + var_0D;
			var_0A = clamp(var_0A,0,1000000000);
			var_05 setlightintensity(var_0A);
			var_11 = var_11 + 0.05;
			wait(0.05);
		}

		if(isdefined(param_03))
		{
			common_scripts\_exploder::exploder(param_03);
		}

		wait(0.1);
		while(var_10 < var_0F)
		{
			var_11 = 0;
			while(var_11 < var_0C)
			{
				var_0A = var_0A - var_0E;
				var_0A = clamp(var_0A,0,300000);
				var_05 setlightintensity(var_0A);
				var_11 = var_11 + 0.05;
				wait(0.05);
			}

			wait(0.1);
			var_11 = 0;
			while(var_11 < var_0B)
			{
				var_0A = var_0A + var_0D;
				var_0A = clamp(var_0A,0,300000);
				var_05 setlightintensity(var_0A);
				var_11 = var_11 + 0.05;
				wait(0.05);
			}

			wait(0.1);
			var_10 = var_10 + 1;
		}
	}

	return var_05;
}

//Function Number: 54
model_flicker_preset(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	self endon("death");
	if(isdefined(param_0A))
	{
		level endon(param_0A);
	}

	var_0D = getentarray(param_00,"script_noteworthy");
	if(!isdefined(var_0D))
	{
		return;
	}

	var_0E = [];
	var_0F = [];
	foreach(var_11 in var_0D)
	{
		if(var_11.classname == "script_model")
		{
			var_0F[var_0F.size] = var_11;
		}

		if(var_11.classname == "light_spot" || var_11.classname == "light_omni")
		{
			var_0E[var_0E.size] = var_11;
			var_12 = param_02;
			if(param_03 > param_02)
			{
				var_12 = randomfloatrange(param_02,param_03);
			}

			var_11 setlightintensity(var_12);
		}
	}

	var_14 = 0;
	var_15 = undefined;
	var_16 = undefined;
	var_17 = undefined;
	var_18 = undefined;
	var_19 = undefined;
	var_1A = 1;
	if(isarray(param_0B))
	{
		var_15 = param_0B["on"];
		var_16 = param_0B["off"];
		var_17 = param_0B["loop"];
		var_19 = param_0B["vol_env"];
		if(isstring(var_17))
		{
			var_18 = "model_flicker_preset_" + soundscripts\_snd::snd_new_guid();
		}
	}

	var_1B = 0;
	if(isdefined(param_04))
	{
		common_scripts\_exploder::exploder(param_04);
	}

	while(var_1B < param_01 || param_01 == 0)
	{
		var_1C = undefined;
		if(isdefined(param_0C))
		{
			var_1D = param_0C;
		}
		else
		{
			var_1D = 0.05;
		}

		var_1E = 0;
		if(isdefined(param_06) && isdefined(param_07))
		{
			var_1F = randomfloatrange(param_06,param_07);
		}
		else
		{
			var_1F = randomfloatrange(0.1,0.8);
		}

		if(isdefined(param_08) && isdefined(param_09))
		{
			var_20 = randomfloatrange(param_08,param_09);
		}
		else
		{
			var_20 = randomfloatrange(0.1,0.8);
		}

		if(isdefined(param_05))
		{
			foreach(var_22 in var_0E)
			{
				if(var_14)
				{
					if(isstring(var_18))
					{
						level notify(var_18);
					}

					if(isdefined(var_16))
					{
						var_22 soundscripts\_snd_playsound::snd_play_linked(var_16,undefined,undefined,undefined,var_1A);
					}

					var_14 = 0;
				}
			}

			maps\_utility::stop_exploder(param_05);
		}

		foreach(var_25 in var_0F)
		{
			var_25 hide();
		}

		foreach(var_28 in var_0E)
		{
			var_1C = var_28 getlightintensity();
			var_28 setlightintensity(var_1D);
		}

		wait(var_20);
		if(isdefined(param_05))
		{
			foreach(var_22 in var_0E)
			{
				var_12 = param_02;
				if(param_03 > param_02)
				{
					var_12 = randomfloatrange(param_02,param_03);
				}

				var_22 setlightintensity(var_12);
				if(isdefined(var_15) && !var_14)
				{
					if(isarray(var_19))
					{
						var_1A = soundscripts\_snd::snd_map(var_12,var_19);
					}

					if(isdefined(var_15))
					{
						var_22 soundscripts\_snd_playsound::snd_play_linked(var_15,undefined,undefined,undefined,var_1A);
					}

					if(isdefined(var_17))
					{
						var_22 soundscripts\_snd_playsound::snd_play_loop_linked(var_17,var_18,0,0.1,var_1A);
					}

					var_14 = 1;
				}
			}

			common_scripts\_exploder::exploder(param_05);
		}

		foreach(var_25 in var_0F)
		{
			var_25 show();
		}

		foreach(var_28 in var_0E)
		{
			var_28 setlightintensity(var_1C);
		}

		wait(var_1F);
		if(param_01 != 0)
		{
			var_1B++;
		}
	}
}

//Function Number: 55
light_setup_common_dof_presets()
{
	create_dof_preset("default",1,1,4.5,500,500,0.05,0.5);
	create_dof_preset("viewmodel_blur",1,1,4.5,500,500,0.05,0.5);
	create_dof_preset("close_none_viewmodel_blur",1,50,4,1000,7000,0.05,0.5);
	create_dof_preset("river",1,104,4.5,500,500,1.8,0.5);
	create_dof_preset("medium_none_viewmodel_blur",1,500,10,1000,7000,0.05,0.5);
}

//Function Number: 56
create_dof_preset(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level._light.dof_presets))
	{
		level._light.dof_presets = [];
	}

	var_08 = [];
	var_08["nearStart"] = param_01;
	var_08["nearEnd"] = param_02;
	var_08["nearBlur"] = param_03;
	var_08["farStart"] = param_04;
	var_08["farEnd"] = param_05;
	var_08["farBlur"] = param_06;
	var_08["bias"] = param_07;
	level._light.dof_presets[param_00] = var_08;
}

//Function Number: 57
light_get_dof_preset(param_00)
{
	if(isdefined(level._light.dof_presets) && isdefined(level._light.dof_presets[param_00]))
	{
		return level._light.dof_presets[param_00];
	}
}

//Function Number: 58
blend_dof_presets(param_00,param_01,param_02)
{
	if(isdefined(level._light.dof_presets))
	{
		var_03 = light_get_dof_preset(param_00);
		var_04 = light_get_dof_preset(param_01);
		if(isdefined(var_03) && isdefined(var_04))
		{
			maps\_art::dof_enable_script(var_04["nearStart"],var_04["nearEnd"],var_04["nearBlur"],var_04["farStart"],var_04["farEnd"],var_04["farBlur"],param_02,var_04["bias"]);
			return;
		}
	}
}

//Function Number: 59
light_setup_common_dof_viewmodel_presets()
{
	create_dof_viewmodel_preset("default",2,8);
	create_dof_viewmodel_preset("viewmodel_blur",10,90);
	create_dof_viewmodel_preset("max",2,128);
}

//Function Number: 60
create_dof_viewmodel_preset(param_00,param_01,param_02)
{
	if(!isdefined(level._light.dof_viewmodel_presets))
	{
		level._light.dof_viewmodel_presets = [];
	}

	var_03["start"] = param_01;
	var_03["end"] = param_02;
	level.player.viewmodel_dof_start = var_03["start"];
	level.player.viewmodel_dof_end = var_03["end"];
	level._light.dof_viewmodel_presets[param_00] = var_03;
}

//Function Number: 61
light_get_dof_viewmodel_preset(param_00)
{
	if(isdefined(level._light.dof_viewmodel_presets) && isdefined(level._light.dof_viewmodel_presets[param_00]))
	{
		return level._light.dof_viewmodel_presets[param_00];
	}
}

//Function Number: 62
blend_dof_viewmodel_presets(param_00,param_01,param_02)
{
	if(isdefined(level._light.dof_viewmodel_presets))
	{
		var_03 = light_get_dof_viewmodel_preset(param_00);
		var_04 = light_get_dof_viewmodel_preset(param_01);
		if(isdefined(var_03) && isdefined(var_04))
		{
			blend_viewmodel_dof(var_03,var_04,param_02);
			return;
		}
	}
}

//Function Number: 63
blend_viewmodel_dof(param_00,param_01,param_02)
{
	if(param_02 > 0)
	{
		var_03 = param_01["start"] - param_00["start"] * 0.05 / param_02;
		var_04 = param_01["end"] - param_00["end"] * 0.05 / param_02;
		thread lerp_viewmodel_dof(param_01,var_03,var_04);
		return;
	}

	level.player.viewmodel_dof_start = param_01["start"];
	level.player.viewmodel_dof_end = param_01["end"];
}

//Function Number: 64
lerp_viewmodel_dof(param_00,param_01,param_02)
{
	level notify("lerp_viewmodel_dof");
	level endon("lerp_viewmodel_dof");
	var_03 = 0;
	var_04 = 0;
	while(!var_03 || !var_04)
	{
		if(!var_03)
		{
			level.player.viewmodel_dof_start = level.player.viewmodel_dof_start + param_01;
			if((param_01 > 0 && level.player.viewmodel_dof_start > param_00["start"]) || param_01 < 0 && level.player.viewmodel_dof_start < param_00["start"])
			{
				level.player.viewmodel_dof_start = param_00["start"];
				var_03 = 1;
			}
		}

		if(!var_04)
		{
			level.player.viewmodel_dof_end = level.player.viewmodel_dof_end + param_02;
			if((param_02 > 0 && level.player.viewmodel_dof_end > param_00["end"]) || param_02 < 0 && level.player.viewmodel_dof_end < param_00["end"])
			{
				level.player.viewmodel_dof_end = param_00["end"];
				var_04 = 1;
			}
		}

		level.player setviewmodeldepthoffield(level.player.viewmodel_dof_start,level.player.viewmodel_dof_end);
		wait(0.05);
	}
}

//Function Number: 65
light_message_init()
{
	level._light.messages = [];
}

//Function Number: 66
light_debug_dvar_init()
{
}

//Function Number: 67
light_register_message(param_00,param_01)
{
	level._light.messages[param_00] = param_01;
}

//Function Number: 68
light_message(param_00,param_01,param_02,param_03)
{
	if(isdefined(level._light.messages[param_00]))
	{
		if(isdefined(param_03))
		{
			thread [[ level._light.messages[param_00] ]](param_01,param_02,param_03);
			return;
		}

		if(isdefined(param_02))
		{
			thread [[ level._light.messages[param_00] ]](param_01,param_02);
			return;
		}

		if(isdefined(param_01))
		{
			thread [[ level._light.messages[param_00] ]](param_01);
			return;
		}

		thread [[ level._light.messages[param_00] ]]();
		return;
	}
}

//Function Number: 69
lerp_light_fov_range(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	while(var_05 <= param_04)
	{
		var_06 = var_05 / param_04;
		self setlightfovrange(maps\_utility::linear_interpolate(var_06,param_00,param_02),maps\_utility::linear_interpolate(var_06,param_01,param_03));
		wait 0.05;
		var_05 = var_05 + 0.05;
	}
}