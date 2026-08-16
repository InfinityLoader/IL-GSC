/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_painter.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main(painter_spmp)
{
	painter_setup_array = getentarray("painter_setup", "targetname");
	if(!painter_setup_array.size)
	{
		return;
	}

	if(!getdvarint("painter"))
	{
		common_scripts\utility::array_thread(painter_setup_array, ::painter_clean_me);
		return;
	}

	painter_initvars(painter_spmp);
	painter_groups = [];
	groups = get_painter_groups(painter_setup_array);
	foreach(group in groups)
	{
		setup_painter_group(group);
	}

	thread painter_init();
	common_scripts\utility::array_thread(level.spam_model_group, ::default_undefined);
	level.stop_load = 1;
	level waittill("forever");
}

painter_clean_me()
{
	if(isdefined(self.target))
	{
		ent = getent(self.target, "targetname");
		ent delete();
	}

	self delete();
}

default_undefined()
{
	if(!isdefined(self.bposedstyle))
	{
		self.bposedstyle = 0;
	}

	if(!isdefined(self.borienttoplayeryrot))
	{
		self.borienttoplayeryrot = 0;
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

	if(!isdefined(self.angleoffset))
	{
		self.angleoffset = [];
		return;
	}
}

setup_painter_group(group)
{
	density = 100000001;
	group_copy = group;
	btreeorient = undefined;
	bfacade = undefined;
	radius = undefined;
	maxdist = undefined;
	offsetheight = undefined;
	bposedstyle = undefined;
	borienttoplayeryrot = undefined;
	angleoffset = undefined;
	foreach(obj in group)
	{
		angleoffset = get_angle_offset(obj);
		offsetheight = get_height_offset(obj);
		modeluseprefab = isdefined(obj.script_parameters) && obj.script_parameters == "use_prefab_model";
		if(isdefined(obj.radius))
		{
			radius = obj.radius;
		}

		if(isdefined(obj.script_painter_treeorient) && obj.script_painter_treeorient)
		{
			btreeorient = 1;
		}

		if(isdefined(obj.script_painter_maxdist) && obj.script_painter_maxdist)
		{
			maxdist = obj.script_painter_maxdist;
		}

		if(isdefined(obj.script_painter_facade) && obj.script_painter_facade)
		{
			bfacade = 1;
		}

		foreach(other_obj in group_copy)
		{
			if(obj == other_obj)
			{
				continue;
			}

			dist = distance(obj.origin, other_obj.origin);
			if(dist < density)
			{
				density = dist;
			}
		}

		if(density == 100000001)
		{
			density = undefined;
		}

		Add_Spammodel(obj.script_paintergroup, obj.model, btreeorient, bfacade, density, radius, maxdist, offsetheight, bposedstyle, borienttoplayeryrot, angleoffset, modeluseprefab);
	}
}

get_angle_offset(obj)
{
	if(!isdefined(obj.target))
	{
		return undefined;
	}

	targent = getent(obj.target, "targetname");
	return targent.angles - obj.angles;
}

get_height_offset(obj)
{
	if(!isdefined(obj.target))
	{
		return undefined;
	}

	targent = getent(obj.target, "targetname");
	origin = targent.origin[2] - obj.origin[2];
	targent delete();
	return origin;
}

get_painter_groups(painter_setup_array)
{
	groups = [];
	script_paintergroup = "";
	foreach(paint_obj in painter_setup_array)
	{
		if(!isdefined(paint_obj.script_paintergroup))
		{
			paint_obj.script_paintergroup = paint_obj.model;
		}

		script_paintergroup = paint_obj.script_paintergroup;
		level.painter_startgroup = script_paintergroup;
		if(!isdefined(groups[script_paintergroup]) || !groups[script_paintergroup].size)
		{
			groups[script_paintergroup] = [];
		}

		groups[script_paintergroup][groups[script_paintergroup].size] = paint_obj;
	}

	return groups;
}

painter_initvars(painter_spmp)
{
	level._clearalltextafterhudelem = 0;
	level.bposedstyle = 0;
	level.borienttoplayeryrot = 0;
	level.spam_density_scale = 16;
	level.spaming_models = 0;
	level.spam_model_group = [];
	level.spamed_models = [];
	level.spam_models_flowrate = 0.1;
	level.spam_model_radius = 31;
	level.spam_maxdist = 1000;
	level.previewmodels = [];
	level.spam_models_iscustomrotation = 0;
	level.spam_models_iscustomheight = 0;
	level.spam_models_customheight = 0;
	level.spam_model_circlescale_lasttime = 0;
	level.spam_model_circlescale_accumtime = 0;
	level.paintadd = ::Add_Spammodel;
	level.timelimitoverride = 1;
	thread hack_start(painter_spmp);
	thread hud_init();
}

hack_start(painter_spmp)
{
	if(!isdefined(painter_spmp))
	{
		painter_spmp = "painter";
	}

	precachemenu(painter_spmp);
	common_scripts\utility::flag_init("user_alive");
	while(!isdefined(get_player()))
	{
		wait 0.05;
	}

	level.painter_player = get_player();
	wait 0.05;
	menu = "team_marinesopfor";
	response = "autoassign";
	level.painter_player notify("menuresponse", menu, response);
	wait 0.05;
	menu = "changeclass_offline";
	response = "offline_class1_mp, 0";
	level.painter_player notify("menuresponse", menu, response);
	level.painter_player openpopupmenu(painter_spmp);
	wait 0.05;
	level.painter_player closepopupmenu();
	common_scripts\utility::flag_set("user_alive");
}

painter_init()
{
	common_scripts\utility::array_call(getentarray("script_model", "classname"), ::delete);
	setcurrentgroup(level.painter_startgroup);
	level.painter_startgroup = undefined;
	playerInit();
}

hud_update_placed_model_count()
{
	level.hud_controler["helppm"].description setvalue(level.spamed_models.size);
	whitecap = 256;
	if(level.spamed_models.size < whitecap)
	{
		level.hud_controler["helppm"].description.color = (1,1,1);
		return;
	}

	r = 1;
	g = 1 - level.spamed_models.size - whitecap / whitecap;
	b = g;
	level.hud_controler["helppm"].description.color = (r,g,b);
}

hud_init()
{
	common_scripts\utility::flag_init("user_hud_active");
	common_scripts\utility::flag_wait("user_alive");
	listsize = 7;
	if(is_mp())
	{
		listsize = 7;
	}

	hudelems = [];
	spacer = 15;
	div = int(listsize / 2);
	org = 240 + div * spacer;
	alphainc = 0.5 / div;
	alpha = alphainc;
	for(i = 0;i < listsize;i++)
	{
		hudelems[i] = _newhudelem();
		hudelems[i].location = 0;
		hudelems[i].alignx = "left";
		hudelems[i].aligny = "middle";
		hudelems[i].foreground = 1;
		hudelems[i].fontscale = 2;
		hudelems[i].sort = 20;
		if(i == div)
		{
			hudelems[i].alpha = 1;
		}
		else
		{
			hudelems[i].alpha = alpha;
		}

		hudelems[i].x = 20;
		hudelems[i].y = org;
		hudelems[i] _settext(".");
		if(i == div)
		{
			alphainc = alphainc * -1;
		}

		alpha = alpha + alphainc;
		org = org - spacer;
	}

	level.spam_group_hudelems = hudelems;
	crosshair = _newhudelem();
	crosshair.location = 0;
	crosshair.alignx = "center";
	crosshair.aligny = "bottom";
	crosshair.foreground = 1;
	crosshair.fontscale = 2;
	crosshair.sort = 20;
	crosshair.alpha = 1;
	crosshair.x = 320;
	crosshair.y = 244;
	crosshair _settext(".");
	level.crosshair = crosshair;
	crosshair = _newhudelem();
	crosshair.location = 0;
	crosshair.alignx = "center";
	crosshair.aligny = "bottom";
	crosshair.foreground = 1;
	crosshair.fontscale = 2;
	crosshair.sort = 20;
	crosshair.alpha = 0;
	crosshair.x = 320;
	crosshair.y = 244;
	crosshair setvalue(0);
	level.crosshair_value = crosshair;
	controler_hud_add("helppm", 1, "^5Placed Models: ", undefined, level.spamed_models.size);
	controler_hud_add("helpdensity", 2, "^5Spacing: ", undefined, level.spam_density_scale);
	controler_hud_add("helpradius", 3, "^5Radius: ", undefined, level.spam_model_radius);
	controler_hud_add("helpxy", 6, "^4X / ^3Y: ", undefined, level.spam_model_radius);
	controler_hud_add("helpab", 7, "^2A / ^1B^7: ", " - ");
	controler_hud_add("helplsrs", 8, "^8L^7 / R Stick: ", " - ");
	controler_hud_add("helplbrb", 9, "^8L^7 / R Shoulder: ", " - ");
	controler_hud_add("helpdpu", 10, "^8DPad U / ^7D: ", " - ");
	controler_hud_add("helpdpl", 11, "^8DPad L / ^7R: ", " - ");
	controler_hud_add("helpF", 17, "^8F: ^7( dump ) ^3map_source/" + level.script + "_modeldump.map", "");
	hint_buttons_main();
	common_scripts\utility::flag_set("user_hud_active");
}

hint_buttons_main()
{
	controler_hud_update_text("helpxy", "^4Select Set Up ^7 / ^3Down");
	controler_hud_update_text("helpab", "^2Spacing Down ^7 / ^1up ");
	controler_hud_update_text("helplsrs", "^8Radius Down ^7 / Up");
	controler_hud_update_text("helplbrb", "^8Remove ^7 / Place");
	controler_hud_update_text("helpdpl", "^8zOffset Clear ^7 / Set");
	controler_hud_update_text("helpdpu", "^8Rotation Clear ^7 / Set");
}

hint_buttons_zoffset()
{
	controler_hud_update_text("helpxy", "^4 - ^7 / ^3 - ");
	controler_hud_update_text("helpab", "^2Height Down ^7 / ^1Up ");
	controler_hud_update_text("helplsrs", "^8 - ^7 / - ");
	controler_hud_update_text("helplbrb", "^8 - ^7 / - ");
	controler_hud_update_text("helpdpl", "^8 - ^7 / Set");
	controler_hud_update_text("helpdpu", "^8 - ^7 / - ");
	controler_hud_update_text("helpF", " - ");
}

hint_buttons_rotation()
{
	controler_hud_update_text("helpxy", "^4 - ^7 / ^3 - ");
	controler_hud_update_text("helpab", "^2RotateOther Up ^7 / ^1Down ");
	controler_hud_update_text("helplsrs", "^8 - ^7 / - ");
	controler_hud_update_text("helplbrb", "^8 - ^7 / - ");
	controler_hud_update_text("helpdpl", "^8 - ^7 / - ");
	controler_hud_update_text("helpdpu", "^8Set ^7 / - ");
	controler_hud_update_text("helpF", " - ");
}

setcurrentgroup(group)
{
	common_scripts\utility::flag_wait("user_hud_active");
	level.spam_model_current_group = group;
	keys = getarraykeys(level.spam_model_group);
	index = 0;
	div = int(level.spam_group_hudelems.size / 2);
	for(i = 0;i < keys.size;i++)
	{
		if(keys[i] == group)
		{
			index = i;
			break;
		}
	}

	level.spam_group_hudelems[div] _settext(keys[index]);
	for(i = 1;i < level.spam_group_hudelems.size - div;i++)
	{
		if(index - i < 0)
		{
			level.spam_group_hudelems[div + i] _settext(".");
			continue;
		}

		level.spam_group_hudelems[div + i] _settext(keys[index - i]);
	}

	for(i = 1;i < level.spam_group_hudelems.size - div;i++)
	{
		if(index + i > keys.size - 1)
		{
			level.spam_group_hudelems[div - i] _settext(".");
			continue;
		}

		level.spam_group_hudelems[div - i] _settext(keys[index + i]);
	}

	group = getcurrent_groupstruct();
	level.borienttoplayeryrot = group.borienttoplayeryrot;
	level.bposedstyle = group.bposedstyle;
	level.spam_maxdist = group.maxdist;
	level.spam_model_radius = group.radius;
	level.hud_controler["helpradius"].description setvalue(level.spam_model_radius);
	level.spam_density_scale = group.density;
	level.hud_controler["helpdensity"].description setvalue(level.spam_density_scale);
}

setgroup_up()
{
	index = undefined;
	keys = getarraykeys(level.spam_model_group);
	for(i = 0;i < keys.size;i++)
	{
		if(keys[i] == level.spam_model_current_group)
		{
			index = i + 1;
			break;
		}
	}

	if(index == keys.size)
	{
		return;
	}

	setcurrentgroup(keys[index]);
	while(level.painter_player buttonpresseddevonly("BUTTON_Y"))
	{
		wait 0.05;
	}
}

setgroup_down()
{
	index = undefined;
	keys = getarraykeys(level.spam_model_group);
	for(i = 0;i < keys.size;i++)
	{
		if(keys[i] == level.spam_model_current_group)
		{
			index = i - 1;
			break;
		}
	}

	if(index < 0)
	{
		return;
	}

	setcurrentgroup(keys[index]);
	while(level.painter_player buttonpresseddevonly("BUTTON_X"))
	{
		wait 0.05;
	}
}

Add_Spammodel(group, model, btreeorient, bfacade, density, radius, maxdist, offsetheight, bposedstyle, borienttoplayeryrot, angleoffset, modelusesprefab)
{
	if(!isdefined(level.spam_model_group[group]))
	{
		struct = spawnstruct();
		level.spam_model_group[group] = struct;
		level.spam_model_group[group].models = [];
	}

	if(!isdefined(angleoffset))
	{
		angleoffset = (0,0,0);
	}

	level.spam_model_group[group].bfacade = bfacade;
	level.spam_model_group[group].btreeorient = btreeorient;
	level.spam_model_group[group].density = density;
	level.spam_model_group[group].radius = radius;
	level.spam_model_group[group].maxdist = maxdist;
	level.spam_model_group[group].bposedstyle = bposedstyle;
	level.spam_model_group[group].borienttoplayeryrot = borienttoplayeryrot;
	if(!isdefined(level.spam_model_group[group].angleoffset))
	{
		level.spam_model_group[group].angleoffset = [];
	}

	level.spam_model_group[group].angleoffset[model] = angleoffset;
	if(!isdefined(level.spam_model_group[group].heightoffset))
	{
		level.spam_model_group[group].heightoffset = [];
	}

	level.spam_model_group[group].heightoffset[model] = offsetheight;
	if(!isdefined(level.spam_model_group[group].modelusesprefab))
	{
		level.spam_model_group[group].modelusesprefab = [];
	}

	level.spam_model_group[group].modelusesprefab[model] = modelusesprefab;
	level.spam_model_group[group].models[level.spam_model_group[group].models.size] = model;
}

playerInit()
{
	level.painter_max = 700;
	level.painter_player takeallweapons();
	common_scripts\utility::flag_wait("user_hud_active");
	for(;;)
	{
		trace = player_view_trace();
		draw_placement_circle(trace);
		if(level.painter_player buttonpresseddevonly("f"))
		{
			dump_models();
		}

		if(level.painter_player buttonpresseddevonly("DPAD_UP"))
		{
			customrotation_mode(trace, "DPAD_UP");
		}
		else if(level.painter_player buttonpresseddevonly("DPAD_DOWN"))
		{
			customrotation_mode_off();
		}
		else if(level.painter_player buttonpresseddevonly("DPAD_RIGHT"))
		{
			customheight_mode(trace, "DPAD_RIGHT");
		}
		else if(level.painter_player buttonpresseddevonly("DPAD_LEFT"))
		{
			customheight_mode_off();
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_X"))
		{
			setgroup_down();
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_Y"))
		{
			setgroup_up();
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_LSTICK"))
		{
			spam_model_circlescale(trace, -1);
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_RSTICK"))
		{
			spam_model_circlescale(trace, 1);
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_A"))
		{
			spam_model_densityscale(trace, -1);
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_B"))
		{
			spam_model_densityscale(trace, 1);
		}
		else
		{
			if(level.painter_player buttonpresseddevonly("BUTTON_LSHLDR"))
			{
				spam_model_erase(trace);
			}

			if(level.painter_player buttonpresseddevonly("BUTTON_RSHLDR"))
			{
				thread spam_model_place(trace);
			}
		}

		level notify("clear_previews");
		wait 0.05;
		hud_update_placed_model_count();
	}
}

customheight_mode_off()
{
	level.spam_models_iscustomheight = 0;
	hint_buttons_main();
}

customheight_mode(trace, button)
{
	if(trace["fraction"] == 1)
	{
		return;
	}

	while(level.painter_player buttonpresseddevonly(button))
	{
		wait 0.05;
	}

	level.spam_models_iscustomheight = 1;
	hint_buttons_zoffset();
	models = [];
	models = spam_models_atcircle(trace, 0, 1);
	inc = 2;
	dir = 1;
	origin = trace["position"];
	while(!level.painter_player buttonpresseddevonly(button))
	{
		height = level.spam_models_customheight;
		if(level.painter_player buttonpresseddevonly("BUTTON_A"))
		{
			dir = -1;
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_B"))
		{
			dir = 1;
		}
		else
		{
			dir = 0;
		}

		height = height + dir * inc;
		if(height == 0)
		{
			height = height + dir * inc;
		}

		level.spam_models_customheight = height;
		common_scripts\utility::array_thread(models, ::customheight_mode_offsetmodels, trace);
		draw_placement_circle(trace, (1,1,1));
		wait 0.05;
	}

	common_scripts\utility::array_thread(models, ::deleteme);
	hint_buttons_main();
	while(level.painter_player buttonpresseddevonly(button))
	{
		wait 0.05;
	}
}

customheight_mode_offsetmodels(trace)
{
	self.origin = self.orgorg + trace["normal"] * level.spam_models_customheight;
}

customrotation_mode_off()
{
	level.spam_models_iscustomrotation = 0;
	hint_buttons_main();
}

customrotation_mode(trace, button)
{
	if(trace["fraction"] == 1)
	{
		return;
	}

	while(level.painter_player buttonpresseddevonly(button))
	{
		wait 0.05;
	}

	hint_buttons_rotation();
	level.spam_models_iscustomrotation = 1;
	level.spam_models_customrotation = level.painter_player getplayerangles();
	models = [];
	models = spam_models_atcircle(trace, 1, 1);
	otherangle = 0;
	otherangleinc = 1;
	dir = 0;
	while(!level.painter_player buttonpresseddevonly(button))
	{
		dir = 0;
		if(level.painter_player buttonpresseddevonly("BUTTON_A"))
		{
			dir = -1;
		}
		else if(level.painter_player buttonpresseddevonly("BUTTON_B"))
		{
			dir = 1;
		}

		otherangle = otherangle + dir * otherangleinc;
		if(otherangle > 360)
		{
			otherangle = 1;
		}

		if(otherangle < 0)
		{
			otherangle = 359;
		}

		draw_placement_circle(trace, (0,0,1));
		level.spam_models_customrotation = level.painter_player getplayerangles();
		level.spam_models_customrotation = level.spam_models_customrotation + (0,0,otherangle);
		for(i = 0;i < models.size;i++)
		{
			models[i].angles = level.spam_models_customrotation;
		}

		wait 0.05;
	}

	hint_buttons_main();
	while(level.painter_player buttonpresseddevonly(button))
	{
		wait 0.05;
	}

	for(i = 0;i < models.size;i++)
	{
		models[i] thread deleteme();
	}
}

deleteme()
{
	self delete();
}

spam_model_clearcondition()
{
	self endon("death");
	level waittill("clear_previews");
	level.previewmodels = common_scripts\utility::array_remove(level.previewmodels, self);
	self delete();
}

crosshair_fadetopoint()
{
	level notify("crosshair_fadetopoint");
	level endon("crosshair_fadetopoint");
	wait 2;
	level.crosshair_value.alpha = 0;
	level.crosshair.alpha = 1;
}

spam_model_circlescale(trace, dir)
{
	if(gettime() - level.spam_model_circlescale_lasttime > 60)
	{
		level.spam_model_circlescale_accumtime = 0;
	}

	level.spam_model_circlescale_accumtime = level.spam_model_circlescale_accumtime + 0.05;
	if(level.spam_model_circlescale_accumtime < 0.5)
	{
		inc = 2;
	}
	else
	{
		inc = level.spam_model_circlescale_accumtime / 0.3;
	}

	radius = level.spam_model_radius;
	radius = radius + dir * inc;
	if(radius > 0)
	{
		level.spam_model_radius = radius;
	}

	level.hud_controler["helpradius"].description setvalue(level.spam_model_radius);
	level.spam_model_circlescale_lasttime = gettime();
}

spam_model_densityscale(trace, dir)
{
	inc = 2;
	scale = level.spam_density_scale;
	scale = scale + dir * inc;
	if(scale > 0)
	{
		level.spam_density_scale = scale;
	}

	level.crosshair_value.alpha = 1;
	level.crosshair.alpha = 0;
	level.crosshair_value setvalue(level.spam_density_scale);
	level.hud_controler["helpdensity"].description setvalue(level.spam_density_scale);
	thread crosshair_fadetopoint();
}

draw_placement_circle(trace, param_9F6)
{
	if(!isdefined(param_9F6))
	{
		param_9F6 = (0,1,0);
	}

	if(trace["fraction"] == 1)
	{
		return;
	}

	angles = vectortoangles(trace["normal"]);
	origin = trace["position"];
	radius = level.spam_model_radius;
	plot_circle(origin, radius, angles, param_9F6, 40, level.spam_model_radius);
	if(level.spam_models_iscustomrotation)
	{
		draw_axis(origin, level.spam_models_customrotation);
	}

	if(level.spam_models_iscustomheight)
	{
		common_scripts\utility::draw_arrow(origin, origin + trace["normal"] * level.spam_models_customheight, (1,1,1));
		return;
	}
}

player_view_trace()
{
	maxdist = level.spam_maxdist;
	traceorg = level.painter_player geteye();
	return bullettrace(traceorg, traceorg + anglestoforward(level.painter_player getplayerangles()) * maxdist, 0, self);
}

Orienttoplayeryrot()
{
	self addyaw(level.painter_player getplayerangles()[1] - common_scripts\utility::flat_angle(self.angles)[1]);
}

getcurrent_groupstruct()
{
	return level.spam_model_group[level.spam_model_current_group];
}

orient_model()
{
	group = getcurrent_groupstruct();
	if(level.spam_models_iscustomrotation)
	{
		self.angles = level.spam_models_customrotation;
		return;
	}

	if(level.bposedstyle)
	{
		self.angles = level.painter_player getplayerangles();
	}

	if(level.borienttoplayeryrot)
	{
		Orienttoplayeryrot();
	}

	if(group.btreeorient)
	{
		self.angles = common_scripts\utility::flat_angle(self.angles);
	}

	if(!level.borienttoplayeryrot && !level.bposedstyle)
	{
		self addyaw(randomint(360));
	}

	if(group.bfacade)
	{
		self.angles = common_scripts\utility::flat_angle(vectortoangles(self.origin - level.painter_player geteye()));
		self addyaw(90);
	}

	self addroll(group.angleoffset[self.model][0]);
	self addpitch(group.angleoffset[self.model][1]);
	self addyaw(group.angleoffset[self.model][2]);
}

spam_model_place(trace)
{
	if(level.spaming_models)
	{
		return;
	}

	if(trace["fraction"] == 1 && !level.bposedstyle)
	{
		return;
	}

	level.spaming_models = 1;
	models = spam_models_atcircle(trace, 1);
	level.spamed_models = common_scripts\utility::array_combine(level.spamed_models, models);
	level.spaming_models = 0;
}

getrandom_spammodel()
{
	models = level.spam_model_group[level.spam_model_current_group].models;
	return models[randomint(models.size)];
}

spam_models_atcircle(trace, param_9F8, param_9F9)
{
	if(!isdefined(param_9F9))
	{
		param_9F9 = 0;
	}

	models = [];
	incdistance = level.spam_density_scale;
	radius = level.spam_model_radius;
	incs = int(radius / incdistance) * 2;
	startpoint = 0;
	traceorg = trace["position"];
	angles = vectortoangles(trace["normal"]);
	if(param_9F8)
	{
		angles = angles + (0,randomfloat(360),0);
	}

	xvect = vectornormalize(anglestoright(angles));
	yvect = vectornormalize(anglestoup(angles));
	startpos = traceorg;
	startpos = startpos - xvect * radius;
	startpos = startpos - yvect * radius;
	startpos = startpos + xvect * incdistance;
	startpos = startpos + yvect * incdistance;
	modelpos = startpos;
	if(incs == 0 || level.bposedstyle)
	{
		if(!param_9F9)
		{
			if(is_too_dense(traceorg))
			{
				return models;
			}
		}

		if(!param_9F9)
		{
			if(level.spamed_models.size + models.size > level.painter_max)
			{
				return models;
			}
		}

		getmodel = getrandom_spammodel();
		models[0] = spam_modelattrace(trace, getmodel);
		models[0] orient_model();
		return models;
	}

	countourtrace = [];
	for(x = startpoint;x < incs;x++)
	{
		for(y = startpoint;y < incs;y++)
		{
			if(!param_9F9)
			{
				if(level.spamed_models.size + models.size > level.painter_max)
				{
					return models;
				}
			}

			modelpos = startpos;
			modelpos = modelpos + xvect * x * incdistance;
			modelpos = modelpos + yvect * y * incdistance;
			if(distance(modelpos, traceorg) > radius)
			{
				continue;
			}

			countourtrace = contour_point(modelpos, angles, level.spam_model_radius);
			if(countourtrace["fraction"] == 1)
			{
				continue;
			}

			if(is_too_dense(countourtrace["position"]))
			{
				continue;
			}

			getmodel = getrandom_spammodel();
			model = spam_modelattrace(countourtrace, getmodel);
			model orient_model();
			models[models.size] = model;
		}
	}

	return models;
}

is_too_dense(param_A02)
{
	for(i = level.spamed_models.size - 1;i >= 0;i--)
	{
		if(distance(level.spamed_models[i].orgorg, param_A02) < level.spam_density_scale - 1)
		{
			return 1;
		}
	}

	return 0;
}

get_player()
{
	return getentarray("player", "classname")[0];
}

spam_modelattrace(trace, getmodel)
{
	model = spawn("script_model", level.painter_player.origin);
	model setmodel(getmodel);
	model notsolid();
	model.origin = trace["position"];
	model.angles = vectortoangles(trace["normal"]);
	model addpitch(90);
	model.orgorg = model.origin;
	group = getcurrent_groupstruct();
	if(level.spam_models_iscustomheight)
	{
		model.origin = model.origin + trace["normal"] * level.spam_models_customheight;
	}

	group = getcurrent_groupstruct();
	if(isdefined(group.heightoffset[getmodel]))
	{
		model.origin = model.origin + trace["normal"] * group.heightoffset[getmodel];
	}

	if(isdefined(group.modelusesprefab[getmodel]))
	{
		model.modelusesprefab = group.modelusesprefab[getmodel];
	}

	return model;
}

contour_point(origin, angles, height)
{
	offset = height;
	vect = anglestoforward(angles);
	destorg = origin + vect * offset;
	targetorg = origin + vect * -1 * offset;
	return bullettrace(destorg, targetorg, 0, level.painter_player);
}

plot_circle(origin, radius, angles, color, param_A06, param_A07)
{
	if(!isdefined(color))
	{
		color = (0,1,0);
	}

	if(!isdefined(param_A06))
	{
		param_A06 = 16;
	}

	hemires = param_A06 / 2;
	circleinc = 360 / param_A06;
	param_A06++;
	plotpoints = [];
	rad = 0;
	plotpoints = [];
	rad = 0;
	for(i = 0;i < param_A06;i++)
	{
		baseorg = origin + anglestoup(angles + (0,0,rad)) * radius;
		point = contour_point(baseorg, angles, level.spam_model_radius);
		if(point["fraction"] != 1)
		{
			plotpoints[plotpoints.size] = point["position"];
		}

		rad = rad + circleinc;
	}

	common_scripts\utility::plot_points(plotpoints, color[0], color[1], color[2]);
	plotpoints = [];
}

spam_model_erase(trace)
{
	traceorg = trace["position"];
	keepmodels = [];
	deletemodels = [];
	for(i = 0;i < level.spamed_models.size;i++)
	{
		if(distance(level.spamed_models[i].orgorg, traceorg) > level.spam_model_radius)
		{
			keepmodels[keepmodels.size] = level.spamed_models[i];
			continue;
		}

		deletemodels[deletemodels.size] = level.spamed_models[i];
	}

	level.spamed_models = keepmodels;
	for(i = 0;i < deletemodels.size;i++)
	{
		deletemodels[i] delete();
	}
}

dump_models()
{
}

draw_axis(org, angles)
{
	range = 32;
	forward = range * anglestoforward(angles);
	right = range * anglestoright(angles);
	up = range * anglestoup(angles);
}

_newhudelem()
{
	if(!isdefined(level.scripted_elems))
	{
		level.scripted_elems = [];
	}

	elem = newhudelem();
	level.scripted_elems[level.scripted_elems.size] = elem;
	return elem;
}

_settext(text)
{
	self.realtext = text;
	self settext("_");
	thread _clearalltextafterhudelem();
	sizeofelems = 0;
	foreach(elem in level.scripted_elems)
	{
		if(isdefined(elem.realtext))
		{
			sizeofelems = sizeofelems + elem.realtext.size;
			elem settext(elem.realtext);
		}
	}
}

controler_hud_add(param_A14, inc, param_A15, param_A16, param_A17)
{
	startx = 520;
	if(is_mp())
	{
		startx = 630;
	}

	starty = 120;
	space = 18;
	basealpha = 0.8;
	denradoffset = 20;
	descriptionscale = 1.4;
	if(!isdefined(param_A15))
	{
		param_A15 = "";
	}

	if(!isdefined(level.hud_controler) || !isdefined(level.hud_controler[param_A14]))
	{
		level.hud_controler[param_A14] = _newhudelem();
		description = _newhudelem();
	}
	else
	{
		description = level.hud_controler[param_A14].description;
	}

	level.hud_controler[param_A14].location = 0;
	level.hud_controler[param_A14].alignx = "right";
	level.hud_controler[param_A14].aligny = "middle";
	level.hud_controler[param_A14].foreground = 1;
	level.hud_controler[param_A14].fontscale = 1.5;
	level.hud_controler[param_A14].sort = 20;
	level.hud_controler[param_A14].alpha = basealpha;
	level.hud_controler[param_A14].x = startx + denradoffset;
	level.hud_controler[param_A14].y = starty + inc * space;
	level.hud_controler[param_A14] _settext(param_A15);
	level.hud_controler[param_A14].base_button_text = param_A15;
	description.location = 0;
	description.alignx = "left";
	description.aligny = "middle";
	description.foreground = 1;
	description.fontscale = descriptionscale;
	description.sort = 20;
	description.alpha = basealpha;
	description.x = startx + denradoffset;
	description.y = starty + inc * space;
	if(isdefined(param_A17))
	{
		description setvalue(param_A17);
	}

	if(isdefined(param_A16))
	{
		description _settext(param_A16);
	}

	level.hud_controler[param_A14].description = description;
}

controler_hud_update_text(param_A1F, text)
{
	if(is_mp())
	{
		level.hud_controler[param_A1F] _settext(level.hud_controler[param_A1F].base_button_text + text);
		level.hud_controler[param_A1F].description _settext("");
		return;
	}

	level.hud_controler[param_A1F].description _settext(text);
}

controler_hud_update_button(param_A1F, text)
{
	level.hud_controler[param_A1F] _settext(text);
}

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

is_mp()
{
	return issubstr(level.script, "mp_");
}