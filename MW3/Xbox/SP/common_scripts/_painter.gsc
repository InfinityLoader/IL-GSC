/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_painter.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 53
 * Decompile Time: 904 ms
 * Timestamp: 10/27/2023 2:34:15 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	var_01 = getentarray("painter_setup","targetname");
	if(!var_01.size)
	{
		return;
	}

	if(!getdvarint("painter"))
	{
		common_scripts\utility::array_thread(var_01,::painter_clean_me);
		return;
	}

	func_1762(param_00);
	var_02 = [];
	var_03 = func_1761(var_01);
	foreach(var_05 in var_03)
	{
		setup_painter_group(var_05);
	}

	thread painter_init();
	common_scripts\utility::array_thread(level.spam_model_group,::default_undefined);
	level.var_1750 = 1;
	level waittill("forever");
}

//Function Number: 2
painter_clean_me()
{
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		var_00 delete();
	}

	self delete();
}

//Function Number: 3
default_undefined()
{
	if(!isdefined(self.bposedstyle))
	{
		self.bposedstyle = 0;
	}

	if(!isdefined(self.var_1754))
	{
		self.var_1754 = 0;
	}

	if(!isdefined(self.btreeorient))
	{
		self.btreeorient = 0;
	}

	if(!isdefined(self.bfacade))
	{
		self.bfacade = 0;
	}

	if(!isdefined(self.density))
	{
		self.density = 32;
	}

	if(!isdefined(self.radius))
	{
		self.radius = 84;
	}

	if(!isdefined(self.maxdist))
	{
		self.maxdist = 1000;
	}

	if(!isdefined(self.var_1759))
	{
		self.var_1759 = [];
	}
}

//Function Number: 4
setup_painter_group(param_00)
{
	var_01 = 100000001;
	var_02 = param_00;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	foreach(var_0C in param_00)
	{
		var_0A = get_angle_offset(var_0C);
		var_07 = func_1760(var_0C);
		var_0D = isdefined(var_0C.script_parameters) && var_0C.script_parameters == "use_prefab_model";
		if(isdefined(var_0C.radius))
		{
			var_05 = var_0C.radius;
		}

		if(isdefined(var_0C.script_painter_treeorient) && var_0C.script_painter_treeorient)
		{
			var_03 = 1;
		}

		if(isdefined(var_0C.var_175C) && var_0C.var_175C)
		{
			var_06 = var_0C.var_175C;
		}

		if(isdefined(var_0C.script_painter_facade) && var_0C.script_painter_facade)
		{
			var_04 = 1;
		}

		foreach(var_0F in var_02)
		{
			if(var_0C == var_0F)
			{
				continue;
			}

			var_10 = distance(var_0C.origin,var_0F.origin);
			if(var_10 < var_01)
			{
				var_01 = var_10;
			}
		}

		if(var_01 == 100000001)
		{
			var_01 = undefined;
		}

		func_1775(var_0C.script_paintergroup,var_0C.model,var_03,var_04,var_01,var_05,var_06,var_07,var_08,var_09,var_0A,var_0D);
	}
}

//Function Number: 5
get_angle_offset(param_00)
{
	if(!isdefined(param_00.target))
	{
		return undefined;
	}

	var_01 = getent(param_00.target,"targetname");
	return var_01.angles - param_00.angles;
}

//Function Number: 6
func_1760(param_00)
{
	if(!isdefined(param_00.target))
	{
		return undefined;
	}

	var_01 = getent(param_00.target,"targetname");
	var_02 = var_01.origin[2] - param_00.origin[2];
	var_01 delete();
	return var_02;
}

//Function Number: 7
func_1761(param_00)
{
	var_01 = [];
	var_02 = "";
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.script_paintergroup))
		{
			var_04.script_paintergroup = var_04.model;
		}

		var_02 = var_04.script_paintergroup;
		level.var_16ED = var_02;
		if(!isdefined(var_01[var_02]) || !var_01[var_02].size)
		{
			var_01[var_02] = [];
		}

		var_01[var_02][var_01[var_02].size] = var_04;
	}

	return var_01;
}

//Function Number: 8
func_1762(param_00)
{
	level._clearalltextafterhudelem = 0;
	level.bposedstyle = 0;
	level.var_1754 = 0;
	level.var_1763 = 16;
	level.var_1764 = 0;
	level.spam_model_group = [];
	level.var_1765 = [];
	level.spam_models_flowrate = 0.1;
	level.var_1767 = 31;
	level.spam_maxdist = 1000;
	level.previewmodels = [];
	level.spam_models_iscustomrotation = 0;
	level.spam_models_iscustomheight = 0;
	level.spam_models_customheight = 0;
	level.spam_model_circlescale_lasttime = 0;
	level.spam_model_circlescale_accumtime = 0;
	level.var_176F = ::func_1775;
	level.timelimitoverride = 1;
	thread hack_start(param_00);
	thread func_16CA();
}

//Function Number: 9
hack_start(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "painter";
	}

	precachemenu(param_00);
	common_scripts\utility::flag_init("user_alive");
	while(!isdefined(get_player()))
	{
		wait 0.05;
	}

	level.painter_player = get_player();
	wait 0.05;
	var_01 = "team_marinesopfor";
	var_02 = "autoassign";
	level.painter_player notify("menuresponse",var_01,var_02);
	wait 0.05;
	var_01 = "changeclass_offline";
	var_02 = "offline_class1_mp, 0";
	level.painter_player notify("menuresponse",var_01,var_02);
	level.painter_player openpopupmenu(param_00);
	wait 0.05;
	level.painter_player closepopupmenu();
	common_scripts\utility::flag_set("user_alive");
}

//Function Number: 10
painter_init()
{
	common_scripts\utility::array_call(getentarray("script_model","classname"),::delete);
	setcurrentgroup(level.var_16ED);
	level.var_16ED = undefined;
	playerinit();
}

//Function Number: 11
hud_update_placed_model_count()
{
	level.hud_controler["helppm"].var_16D0 setvalue(level.var_1765.size);
	var_00 = 256;
	if(level.var_1765.size < var_00)
	{
		level.hud_controler["helppm"].var_16D0.color = (1,1,1);
		return;
	}

	var_01 = 1;
	var_02 = 1 - level.var_1765.size - var_00 / var_00;
	var_03 = var_02;
	level.hud_controler["helppm"].var_16D0.color = (var_01,var_02,var_03);
}

//Function Number: 12
func_16CA()
{
	common_scripts\utility::flag_init("user_hud_active");
	common_scripts\utility::flag_wait("user_alive");
	var_00 = 7;
	if(is_mp())
	{
		var_00 = 7;
	}

	var_01 = [];
	var_02 = 15;
	var_03 = int(var_00 / 2);
	var_04 = 240 + var_03 * var_02;
	var_05 = 0.5 / var_03;
	var_06 = var_05;
	for(var_07 = 0;var_07 < var_00;var_07++)
	{
		var_01[var_07] = _newhudelem();
		var_01[var_07].location = 0;
		var_01[var_07].alignx = "left";
		var_01[var_07].aligny = "middle";
		var_01[var_07].foreground = 1;
		var_01[var_07].fontscale = 2;
		var_01[var_07].sort = 20;
		if(var_07 == var_03)
		{
			var_01[var_07].alpha = 1;
		}
		else
		{
			var_01[var_07].alpha = var_06;
		}

		var_01[var_07].x = 20;
		var_01[var_07].y = var_04;
		var_01[var_07] _settext(".");
		if(var_07 == var_03)
		{
			var_05 = var_05 * -1;
		}

		var_06 = var_06 + var_05;
		var_04 = var_04 - var_02;
	}

	level.var_16CB = var_01;
	var_08 = _newhudelem();
	var_08.location = 0;
	var_08.alignx = "center";
	var_08.aligny = "bottom";
	var_08.foreground = 1;
	var_08.fontscale = 2;
	var_08.sort = 20;
	var_08.alpha = 1;
	var_08.x = 320;
	var_08.y = 244;
	var_08 _settext(".");
	level.var_16CC = var_08;
	var_08 = _newhudelem();
	var_08.location = 0;
	var_08.alignx = "center";
	var_08.aligny = "bottom";
	var_08.foreground = 1;
	var_08.fontscale = 2;
	var_08.sort = 20;
	var_08.alpha = 0;
	var_08.x = 320;
	var_08.y = 244;
	var_08 setvalue(0);
	level.crosshair_value = var_08;
	controler_hud_add("helppm",1,"^5Placed Models: ",undefined,level.var_1765.size);
	controler_hud_add("helpdensity",2,"^5Spacing: ",undefined,level.var_1763);
	controler_hud_add("helpradius",3,"^5Radius: ",undefined,level.var_1767);
	controler_hud_add("helpxy",6,"^4X / ^3Y: ",undefined,level.var_1767);
	controler_hud_add("helpab",7,"^2A / ^1B^7: "," - ");
	controler_hud_add("helplsrs",8,"^8L^7 / R Stick: "," - ");
	controler_hud_add("helplbrb",9,"^8L^7 / R Shoulder: "," - ");
	controler_hud_add("helpdpu",10,"^8DPad U / ^7D: "," - ");
	controler_hud_add("helpdpl",11,"^8DPad L / ^7R: "," - ");
	controler_hud_add("helpF",17,"^8F: ^7( dump ) ^3map_source/" + level.script + "_modeldump.map","");
	hint_buttons_main();
	common_scripts\utility::flag_set("user_hud_active");
}

//Function Number: 13
hint_buttons_main()
{
	controler_hud_update_text("helpxy","^4Select Set Up ^7 / ^3Down");
	controler_hud_update_text("helpab","^2Spacing Down ^7 / ^1up ");
	controler_hud_update_text("helplsrs","^8Radius Down ^7 / Up");
	controler_hud_update_text("helplbrb","^8Remove ^7 / Place");
	controler_hud_update_text("helpdpl","^8zOffset Clear ^7 / Set");
	controler_hud_update_text("helpdpu","^8Rotation Clear ^7 / Set");
}

//Function Number: 14
hint_buttons_zoffset()
{
	controler_hud_update_text("helpxy","^4 - ^7 / ^3 - ");
	controler_hud_update_text("helpab","^2Height Down ^7 / ^1Up ");
	controler_hud_update_text("helplsrs","^8 - ^7 / - ");
	controler_hud_update_text("helplbrb","^8 - ^7 / - ");
	controler_hud_update_text("helpdpl","^8 - ^7 / Set");
	controler_hud_update_text("helpdpu","^8 - ^7 / - ");
	controler_hud_update_text("helpF"," - ");
}

//Function Number: 15
func_1774()
{
	controler_hud_update_text("helpxy","^4 - ^7 / ^3 - ");
	controler_hud_update_text("helpab","^2RotateOther Up ^7 / ^1Down ");
	controler_hud_update_text("helplsrs","^8 - ^7 / - ");
	controler_hud_update_text("helplbrb","^8 - ^7 / - ");
	controler_hud_update_text("helpdpl","^8 - ^7 / - ");
	controler_hud_update_text("helpdpu","^8Set ^7 / - ");
	controler_hud_update_text("helpF"," - ");
}

//Function Number: 16
setcurrentgroup(param_00)
{
	common_scripts\utility::flag_wait("user_hud_active");
	level.spam_model_current_group = param_00;
	var_01 = getarraykeys(level.spam_model_group);
	var_02 = 0;
	var_03 = int(level.var_16CB.size / 2);
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(var_01[var_04] == param_00)
		{
			var_02 = var_04;
			break;
		}
	}

	level.var_16CB[var_03] _settext(var_01[var_02]);
	for(var_04 = 1;var_04 < level.var_16CB.size - var_03;var_04++)
	{
		if(var_02 - var_04 < 0)
		{
			level.var_16CB[var_03 + var_04] _settext(".");
			continue;
		}

		level.var_16CB[var_03 + var_04] _settext(var_01[var_02 - var_04]);
	}

	for(var_04 = 1;var_04 < level.var_16CB.size - var_03;var_04++)
	{
		if(var_02 + var_04 > var_01.size - 1)
		{
			level.var_16CB[var_03 - var_04] _settext(".");
			continue;
		}

		level.var_16CB[var_03 - var_04] _settext(var_01[var_02 + var_04]);
	}

	param_00 = getcurrent_groupstruct();
	level.var_1754 = param_00.var_1754;
	level.bposedstyle = param_00.bposedstyle;
	level.spam_maxdist = param_00.maxdist;
	level.var_1767 = param_00.radius;
	level.hud_controler["helpradius"].var_16D0 setvalue(level.var_1767);
	level.var_1763 = param_00.density;
	level.hud_controler["helpdensity"].var_16D0 setvalue(level.var_1763);
}

//Function Number: 17
setgroup_up()
{
	var_00 = undefined;
	var_01 = getarraykeys(level.spam_model_group);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == level.spam_model_current_group)
		{
			var_00 = var_02 + 1;
			break;
		}
	}

	if(var_00 == var_01.size)
	{
		return;
	}

	setcurrentgroup(var_01[var_00]);
	while(level.painter_player buttonpressed("BUTTON_Y"))
	{
		wait 0.05;
	}
}

//Function Number: 18
setgroup_down()
{
	var_00 = undefined;
	var_01 = getarraykeys(level.spam_model_group);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == level.spam_model_current_group)
		{
			var_00 = var_02 - 1;
			break;
		}
	}

	if(var_00 < 0)
	{
		return;
	}

	setcurrentgroup(var_01[var_00]);
	while(level.painter_player buttonpressed("BUTTON_X"))
	{
		wait 0.05;
	}
}

//Function Number: 19
func_1775(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(level.spam_model_group[param_00]))
	{
		var_0C = spawnstruct();
		level.spam_model_group[param_00] = var_0C;
		level.spam_model_group[param_00].var_1776 = [];
	}

	if(!isdefined(param_0A))
	{
		param_0A = (0,0,0);
	}

	level.spam_model_group[param_00].bfacade = param_03;
	level.spam_model_group[param_00].btreeorient = param_02;
	level.spam_model_group[param_00].density = param_04;
	level.spam_model_group[param_00].radius = param_05;
	level.spam_model_group[param_00].maxdist = param_06;
	level.spam_model_group[param_00].bposedstyle = param_08;
	level.spam_model_group[param_00].var_1754 = param_09;
	if(!isdefined(level.spam_model_group[param_00].var_1759))
	{
		level.spam_model_group[param_00].var_1759 = [];
	}

	level.spam_model_group[param_00].var_1759[param_01] = param_0A;
	if(!isdefined(level.spam_model_group[param_00].heightoffset))
	{
		level.spam_model_group[param_00].heightoffset = [];
	}

	level.spam_model_group[param_00].heightoffset[param_01] = param_07;
	if(!isdefined(level.spam_model_group[param_00].var_1778))
	{
		level.spam_model_group[param_00].var_1778 = [];
	}

	level.spam_model_group[param_00].var_1778[param_01] = param_0B;
	level.spam_model_group[param_00].var_1776[level.spam_model_group[param_00].var_1776.size] = param_01;
}

//Function Number: 20
playerinit()
{
	level.var_1779 = 700;
	level.painter_player takeallweapons();
	common_scripts\utility::flag_wait("user_hud_active");
	for(;;)
	{
		var_00 = player_view_trace();
		draw_placement_circle(var_00);
		if(level.painter_player buttonpressed("f"))
		{
			dump_models();
		}

		if(level.painter_player buttonpressed("DPAD_UP"))
		{
			customrotation_mode(var_00,"DPAD_UP");
		}
		else if(level.painter_player buttonpressed("DPAD_DOWN"))
		{
			customrotation_mode_off();
		}
		else if(level.painter_player buttonpressed("DPAD_RIGHT"))
		{
			customheight_mode(var_00,"DPAD_RIGHT");
		}
		else if(level.painter_player buttonpressed("DPAD_LEFT"))
		{
			func_177A();
		}
		else if(level.painter_player buttonpressed("BUTTON_X"))
		{
			setgroup_down();
		}
		else if(level.painter_player buttonpressed("BUTTON_Y"))
		{
			setgroup_up();
		}
		else if(level.painter_player buttonpressed("BUTTON_LSTICK"))
		{
			spam_model_circlescale(var_00,-1);
		}
		else if(level.painter_player buttonpressed("BUTTON_RSTICK"))
		{
			spam_model_circlescale(var_00,1);
		}
		else if(level.painter_player buttonpressed("BUTTON_A"))
		{
			func_1784(var_00,-1);
		}
		else if(level.painter_player buttonpressed("BUTTON_B"))
		{
			func_1784(var_00,1);
		}
		else
		{
			if(level.painter_player buttonpressed("BUTTON_LSHLDR"))
			{
				func_178F(var_00);
			}

			if(level.painter_player buttonpressed("BUTTON_RSHLDR"))
			{
				thread spam_model_place(var_00);
			}
		}

		level notify("clear_previews");
		wait 0.05;
		hud_update_placed_model_count();
	}
}

//Function Number: 21
func_177A()
{
	level.spam_models_iscustomheight = 0;
	hint_buttons_main();
}

//Function Number: 22
customheight_mode(param_00,param_01)
{
	if(param_00["fraction"] == 1)
	{
		return;
	}

	while(level.painter_player buttonpressed(param_01))
	{
		wait 0.05;
	}

	level.spam_models_iscustomheight = 1;
	hint_buttons_zoffset();
	var_02 = [];
	var_02 = func_178A(param_00,0,1);
	var_03 = 2;
	var_04 = 1;
	var_05 = param_00["position"];
	while(!level.painter_player buttonpressed(param_01))
	{
		var_06 = level.spam_models_customheight;
		if(level.painter_player buttonpressed("BUTTON_A"))
		{
			var_04 = -1;
		}
		else if(level.painter_player buttonpressed("BUTTON_B"))
		{
			var_04 = 1;
		}
		else
		{
			var_04 = 0;
		}

		var_06 = var_06 + var_04 * var_03;
		if(var_06 == 0)
		{
			var_06 = var_06 + var_04 * var_03;
		}

		level.spam_models_customheight = var_06;
		common_scripts\utility::array_thread(var_02,::customheight_mode_offsetmodels,param_00);
		draw_placement_circle(param_00,(1,1,1));
		wait 0.05;
	}

	common_scripts\utility::array_thread(var_02,::deleteme);
	hint_buttons_main();
	while(level.painter_player buttonpressed(param_01))
	{
		wait 0.05;
	}
}

//Function Number: 23
customheight_mode_offsetmodels(param_00)
{
	self.origin = self.orgorg + param_00["normal"] * level.spam_models_customheight;
}

//Function Number: 24
customrotation_mode_off()
{
	level.spam_models_iscustomrotation = 0;
	hint_buttons_main();
}

//Function Number: 25
customrotation_mode(param_00,param_01)
{
	if(param_00["fraction"] == 1)
	{
		return;
	}

	while(level.painter_player buttonpressed(param_01))
	{
		wait 0.05;
	}

	func_1774();
	level.spam_models_iscustomrotation = 1;
	level.spam_models_customrotation = level.painter_player getplayerangles();
	var_02 = [];
	var_02 = func_178A(param_00,1,1);
	var_03 = 0;
	var_04 = 1;
	var_05 = 0;
	while(!level.painter_player buttonpressed(param_01))
	{
		var_05 = 0;
		if(level.painter_player buttonpressed("BUTTON_A"))
		{
			var_05 = -1;
		}
		else if(level.painter_player buttonpressed("BUTTON_B"))
		{
			var_05 = 1;
		}

		var_03 = var_03 + var_05 * var_04;
		if(var_03 > 360)
		{
			var_03 = 1;
		}

		if(var_03 < 0)
		{
			var_03 = 359;
		}

		draw_placement_circle(param_00,(0,0,1));
		level.spam_models_customrotation = level.painter_player getplayerangles();
		level.spam_models_customrotation = level.spam_models_customrotation + (0,0,var_03);
		for(var_06 = 0;var_06 < var_02.size;var_06++)
		{
			var_02[var_06].angles = level.spam_models_customrotation;
		}

		wait 0.05;
	}

	hint_buttons_main();
	while(level.painter_player buttonpressed(param_01))
	{
		wait 0.05;
	}

	for(var_06 = 0;var_06 < var_02.size;var_06++)
	{
		var_02[var_06] thread deleteme();
	}
}

//Function Number: 26
deleteme()
{
	self delete();
}

//Function Number: 27
func_1781()
{
	self endon("death");
	level waittill("clear_previews");
	level.previewmodels = common_scripts\utility::array_remove(level.previewmodels,self);
	self delete();
}

//Function Number: 28
crosshair_fadetopoint()
{
	level notify("crosshair_fadetopoint");
	level endon("crosshair_fadetopoint");
	wait 2;
	level.crosshair_value.alpha = 0;
	level.var_16CC.alpha = 1;
}

//Function Number: 29
spam_model_circlescale(param_00,param_01)
{
	if(gettime() - level.spam_model_circlescale_lasttime > 60)
	{
		level.spam_model_circlescale_accumtime = 0;
	}

	level.spam_model_circlescale_accumtime = level.spam_model_circlescale_accumtime + 0.05;
	if(level.spam_model_circlescale_accumtime < 0.5)
	{
		var_02 = 2;
	}
	else
	{
		var_02 = level.spam_model_circlescale_accumtime / 0.3;
	}

	var_03 = level.var_1767;
	var_03 = var_03 + param_01 * var_02;
	if(var_03 > 0)
	{
		level.var_1767 = var_03;
	}

	level.hud_controler["helpradius"].var_16D0 setvalue(level.var_1767);
	level.spam_model_circlescale_lasttime = gettime();
}

//Function Number: 30
func_1784(param_00,param_01)
{
	var_02 = 2;
	var_03 = level.var_1763;
	var_03 = var_03 + param_01 * var_02;
	if(var_03 > 0)
	{
		level.var_1763 = var_03;
	}

	level.crosshair_value.alpha = 1;
	level.var_16CC.alpha = 0;
	level.crosshair_value setvalue(level.var_1763);
	level.hud_controler["helpdensity"].var_16D0 setvalue(level.var_1763);
	thread crosshair_fadetopoint();
}

//Function Number: 31
draw_placement_circle(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,1,0);
	}

	if(param_00["fraction"] == 1)
	{
		return;
	}

	var_02 = vectortoangles(param_00["normal"]);
	var_03 = param_00["position"];
	var_04 = level.var_1767;
	plot_circle(var_03,var_04,var_02,param_01,40,level.var_1767);
	if(level.spam_models_iscustomrotation)
	{
		draw_axis(var_03,level.spam_models_customrotation);
	}

	if(level.spam_models_iscustomheight)
	{
		common_scripts\utility::draw_arrow(var_03,var_03 + param_00["normal"] * level.spam_models_customheight,(1,1,1));
	}
}

//Function Number: 32
player_view_trace()
{
	var_00 = level.spam_maxdist;
	var_01 = level.painter_player geteye();
	return bullettrace(var_01,var_01 + anglestoforward(level.painter_player getplayerangles()) * var_00,0,self);
}

//Function Number: 33
orienttoplayeryrot()
{
	self addyaw(level.painter_player getplayerangles()[1] - common_scripts\utility::flat_angle(self.angles)[1]);
}

//Function Number: 34
getcurrent_groupstruct()
{
	return level.spam_model_group[level.spam_model_current_group];
}

//Function Number: 35
func_1787()
{
	var_00 = getcurrent_groupstruct();
	if(level.spam_models_iscustomrotation)
	{
		self.angles = level.spam_models_customrotation;
		return;
	}

	if(level.bposedstyle)
	{
		self.angles = level.painter_player getplayerangles();
	}

	if(level.var_1754)
	{
		orienttoplayeryrot();
	}

	if(var_00.btreeorient)
	{
		self.angles = common_scripts\utility::flat_angle(self.angles);
	}

	if(!level.var_1754 && !level.bposedstyle)
	{
		self addyaw(randomint(360));
	}

	if(var_00.bfacade)
	{
		self.angles = common_scripts\utility::flat_angle(vectortoangles(self.origin - level.painter_player geteye()));
		self addyaw(90);
	}

	self addroll(var_00.var_1759[self.model][0]);
	self addpitch(var_00.var_1759[self.model][1]);
	self addyaw(var_00.var_1759[self.model][2]);
}

//Function Number: 36
spam_model_place(param_00)
{
	if(level.var_1764)
	{
		return;
	}

	if(param_00["fraction"] == 1 && !level.bposedstyle)
	{
		return;
	}

	level.var_1764 = 1;
	var_01 = func_178A(param_00,1);
	level.var_1765 = common_scripts\utility::array_combine(level.var_1765,var_01);
	level.var_1764 = 0;
}

//Function Number: 37
func_1789()
{
	var_00 = level.spam_model_group[level.spam_model_current_group].var_1776;
	return var_00[randomint(var_00.size)];
}

//Function Number: 38
func_178A(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = [];
	var_04 = level.var_1763;
	var_05 = level.var_1767;
	var_06 = int(var_05 / var_04) * 2;
	var_07 = 0;
	var_08 = param_00["position"];
	var_09 = vectortoangles(param_00["normal"]);
	if(param_01)
	{
		var_09 = var_09 + (0,randomfloat(360),0);
	}

	var_0A = vectornormalize(anglestoright(var_09));
	var_0B = vectornormalize(anglestoup(var_09));
	var_0C = var_08;
	var_0C = var_0C - var_0A * var_05;
	var_0C = var_0C - var_0B * var_05;
	var_0C = var_0C + var_0A * var_04;
	var_0C = var_0C + var_0B * var_04;
	var_0D = var_0C;
	if(var_06 == 0 || level.bposedstyle)
	{
		if(!param_02)
		{
			if(is_too_dense(var_08))
			{
				return var_03;
			}
		}

		if(!param_02)
		{
			if(level.var_1765.size + var_03.size > level.var_1779)
			{
				return var_03;
			}
		}

		var_0E = func_1789();
		var_03[0] = func_178C(param_00,var_0E);
		var_03[0] func_1787();
		return var_03;
	}

	var_0F = [];
	var_10 = var_08;
	while(var_0F < var_06)
	{
		for(var_10 = var_07;var_10 < var_06;var_10++)
		{
			if(!param_02)
			{
				if(level.var_1765.size + var_03.size > level.var_1779)
				{
					return var_03;
				}
			}

			var_0D = var_0C;
			var_0D = var_0D + var_0A * var_0F * var_04;
			var_0D = var_0D + var_0B * var_10 * var_04;
			if(distance(var_0D,var_08) > var_05)
			{
				continue;
			}

			var_0E = contour_point(var_0D,var_09,level.var_1767);
			if(var_0E["fraction"] == 1)
			{
				continue;
			}

			if(is_too_dense(var_0E["position"]))
			{
				continue;
			}

			var_11 = func_1789();
			var_12 = func_178C(var_0E,var_11);
			var_12 func_1787();
			var_03[var_03.size] = var_12;
		}

		var_0F++;
	}

	return var_03;
}

//Function Number: 39
is_too_dense(param_00)
{
	for(var_01 = level.var_1765.size - 1;var_01 >= 0;var_01--)
	{
		if(distance(level.var_1765[var_01].orgorg,param_00) < level.var_1763 - 1)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
get_player()
{
	return getentarray("player","classname")[0];
}

//Function Number: 41
func_178C(param_00,param_01)
{
	var_02 = spawn("script_model",level.painter_player.origin);
	var_02 setmodel(param_01);
	var_02 notsolid();
	var_02.origin = param_00["position"];
	var_02.angles = vectortoangles(param_00["normal"]);
	var_02 addpitch(90);
	var_02.orgorg = var_02.origin;
	var_03 = getcurrent_groupstruct();
	if(level.spam_models_iscustomheight)
	{
		var_02.origin = var_02.origin + param_00["normal"] * level.spam_models_customheight;
	}

	var_03 = getcurrent_groupstruct();
	if(isdefined(var_03.heightoffset[param_01]))
	{
		var_02.origin = var_02.origin + param_00["normal"] * var_03.heightoffset[param_01];
	}

	if(isdefined(var_03.var_1778[param_01]))
	{
		var_02.var_1778 = var_03.var_1778[param_01];
	}

	return var_02;
}

//Function Number: 42
contour_point(param_00,param_01,param_02)
{
	var_03 = param_02;
	var_04 = anglestoforward(param_01);
	var_05 = param_00 + var_04 * var_03;
	var_06 = param_00 + var_04 * -1 * var_03;
	return bullettrace(var_05,var_06,0,level.painter_player);
}

//Function Number: 43
plot_circle(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,1,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = 16;
	}

	var_06 = param_04 / 2;
	var_07 = 360 / param_04;
	param_04++;
	var_08 = [];
	var_09 = 0;
	var_08 = [];
	var_09 = 0;
	for(var_0A = 0;var_0A < param_04;var_0A++)
	{
		var_0B = param_00 + anglestoup(param_02 + (0,0,var_09)) * param_01;
		var_0C = contour_point(var_0B,param_02,level.var_1767);
		if(var_0C["fraction"] != 1)
		{
			var_08[var_08.size] = var_0C["position"];
		}

		var_09 = var_09 + var_07;
	}

	common_scripts\utility::plot_points(var_08,param_03[0],param_03[1],param_03[2]);
	var_08 = [];
}

//Function Number: 44
func_178F(param_00)
{
	var_01 = param_00["position"];
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < level.var_1765.size;var_04++)
	{
		if(distance(level.var_1765[var_04].orgorg,var_01) > level.var_1767)
		{
			var_02[var_02.size] = level.var_1765[var_04];
			continue;
		}

		var_03[var_03.size] = level.var_1765[var_04];
	}

	level.var_1765 = var_02;
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04] delete();
	}
}

//Function Number: 45
dump_models()
{
}

//Function Number: 46
draw_axis(param_00,param_01)
{
	var_02 = 32;
	var_03 = var_02 * anglestoforward(param_01);
	var_04 = var_02 * anglestoright(param_01);
	var_05 = var_02 * anglestoup(param_01);
}

//Function Number: 47
_newhudelem()
{
	if(!isdefined(level.var_16D3))
	{
		level.var_16D3 = [];
	}

	var_00 = newhudelem();
	level.var_16D3[level.var_16D3.size] = var_00;
	return var_00;
}

//Function Number: 48
_settext(param_00)
{
	self.realtext = param_00;
	self settext("_");
	thread _clearalltextafterhudelem();
	var_01 = 0;
	foreach(var_03 in level.var_16D3)
	{
		if(isdefined(var_03.realtext))
		{
			var_01 = var_01 + var_03.realtext.size;
			var_03 settext(var_03.realtext);
		}
	}
}

//Function Number: 49
controler_hud_add(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 520;
	if(is_mp())
	{
		var_05 = 630;
	}

	var_06 = 120;
	var_07 = 18;
	var_08 = 0.8;
	var_09 = 20;
	var_0A = 1.4;
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(level.hud_controler) || !isdefined(level.hud_controler[param_00]))
	{
		level.hud_controler[param_00] = _newhudelem();
		var_0B = _newhudelem();
	}
	else
	{
		var_0B = level.hud_controler[param_01].var_16D0;
	}

	level.hud_controler[param_00].location = 0;
	level.hud_controler[param_00].alignx = "right";
	level.hud_controler[param_00].aligny = "middle";
	level.hud_controler[param_00].foreground = 1;
	level.hud_controler[param_00].fontscale = 1.5;
	level.hud_controler[param_00].sort = 20;
	level.hud_controler[param_00].alpha = var_08;
	level.hud_controler[param_00].x = var_05 + var_09;
	level.hud_controler[param_00].y = var_06 + param_01 * var_07;
	level.hud_controler[param_00] _settext(param_02);
	level.hud_controler[param_00].base_button_text = param_02;
	var_0B.location = 0;
	var_0B.alignx = "left";
	var_0B.aligny = "middle";
	var_0B.foreground = 1;
	var_0B.fontscale = var_0A;
	var_0B.sort = 20;
	var_0B.alpha = var_08;
	var_0B.x = var_05 + var_09;
	var_0B.y = var_06 + param_01 * var_07;
	if(isdefined(param_04))
	{
		var_0B setvalue(param_04);
	}

	if(isdefined(param_03))
	{
		var_0B _settext(param_03);
	}

	level.hud_controler[param_00].var_16D0 = var_0B;
}

//Function Number: 50
controler_hud_update_text(param_00,param_01)
{
	if(is_mp())
	{
		level.hud_controler[param_00] _settext(level.hud_controler[param_00].base_button_text + param_01);
		level.hud_controler[param_00].var_16D0 _settext("");
		return;
	}

	level.hud_controler[param_00].var_16D0 _settext(param_01);
}

//Function Number: 51
controler_hud_update_button(param_00,param_01)
{
	level.hud_controler[param_00] _settext(param_01);
}

//Function Number: 52
_clearalltextafterhudelem()
{
	if(level._clearalltextafterhudelem)
	{
		return;
	}

	level._clearalltextafterhudelem = 1;
	self clearalltextafterhudelem();
	wait 0.05;
	level._clearalltextafterhudelem = 0;
}

//Function Number: 53
is_mp()
{
	return issubstr(level.script,"mp_");
}