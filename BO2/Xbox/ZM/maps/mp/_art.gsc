/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_art.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 14
 * Decompile Time: 6 ms
 * Timestamp: 10/28/2023 12:14:20 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
main()
{
/#
	if(GetDvar(#"5E997AE") == "" || GetDvar(#"5E997AE") == "0")
	{
		setdvar("scr_art_tweak",0);
	}

	if(GetDvar(#"628ADECB") == "")
	{
		setdvar("scr_dof_enable","1");
	}

	if(GetDvar(#"69E20811") == "")
	{
		setdvar("scr_cinematic_autofocus","1");
	}

	if(GetDvar(#"FE68F88A") == "" && IsDefined(level.script))
	{
		setdvar("scr_art_visionfile",level.script);
	}

	if(GetDvar(#"628768B6") == "")
	{
		setdvar("debug_reflection","0");
	}

	if(GetDvar(#"33E24970") == "")
	{
		setdvar("debug_reflection_matte","0");
	}

	if(GetDvar(#"C450CB50") == "")
	{
		setdvar("debug_color_pallete","0");
	}

	precachemodel("test_sphere_lambert");
	precachemodel("test_macbeth_chart");
	precachemodel("test_macbeth_chart_unlit");
	precachemodel("test_sphere_silver");
	level thread debug_reflection();
	level thread debug_reflection_matte();
	level thread debug_color_pallete();
#/
	if(!(IsDefined(level.dofdefault)))
	{
		level.dofdefault["nearStart"] = 0;
		level.dofdefault["nearEnd"] = 1;
		level.dofdefault["farStart"] = 8000;
		level.dofdefault["farEnd"] = 10000;
		level.dofdefault["nearBlur"] = 6;
		level.dofdefault["farBlur"] = 0;
	}

	level.curdof = level.dofdefault["farStart"] - level.dofdefault["nearEnd"] / 2;
/#
	thread tweakart();
#/
	if(!(IsDefined(level.script)))
	{
		level.script = tolower(GetDvar(#"B4B895C4"));
	}
}

//Function Number: 2
artfxprintln(file,string)
{
/#
	if(file == -1)
	{
		return;
	}

	fprintln(file,string);
#/
}

//Function Number: 3
strtok_loc(string,par1)
{
	stringlist = [];
	indexstring = "";
	for(i = 0;i < string.size;i++)
	{
		if(string[i] == " ")
		{
			stringlist[stringlist.size] = indexstring;
			indexstring = "";
		}
		else
		{
			indexstring = indexstring + string[i];
		}
	}

	if(indexstring.size)
	{
		stringlist[stringlist.size] = indexstring;
	}

	return stringlist;
}

//Function Number: 4
setfogsliders()
{
	fogall = strtok_loc(GetDvar(#"74682944")," ");
	red = fogall[0];
	green = fogall[1];
	blue = fogall[2];
	halfplane = GetDvar(#"E1FDE974");
	nearplane = GetDvar(#"F7F46A27");
	if(!IsDefined(red) || !IsDefined(green) || !IsDefined(blue) || !IsDefined(halfplane))
	{
		red = 1;
		green = 1;
		blue = 1;
		halfplane = 10000001;
		nearplane = 10000000;
	}

	setdvar("scr_fog_exp_halfplane",halfplane);
	setdvar("scr_fog_nearplane",nearplane);
	setdvar("scr_fog_color",red + " " + green + " " + blue);
}

//Function Number: 5
tweakart()
{
/#
	if(!(IsDefined(level.tweakfile)))
	{
		level.tweakfile = 0;
	}

	if(GetDvar(#"829C0FDB") == "")
	{
		setdvar("scr_fog_exp_halfplane","500");
		setdvar("scr_fog_exp_halfheight","500");
		setdvar("scr_fog_nearplane","0");
		setdvar("scr_fog_baseheight","0");
	}

	setdvar("scr_fog_fraction","1.0");
	setdvar("scr_art_dump","0");
	setdvar("scr_art_sun_fog_dir_set","0");
	setdvar("scr_dof_nearStart",level.dofdefault["nearStart"]);
	setdvar("scr_dof_nearEnd",level.dofdefault["nearEnd"]);
	setdvar("scr_dof_farStart",level.dofdefault["farStart"]);
	setdvar("scr_dof_farEnd",level.dofdefault["farEnd"]);
	setdvar("scr_dof_nearBlur",level.dofdefault["nearBlur"]);
	setdvar("scr_dof_farBlur",level.dofdefault["farBlur"]);
	file = undefined;
	filename = undefined;
	tweak_toggle = 1;
	for(;;)
	{
		while(GetDvarInt(#"5E997AE") == 0)
		{
			tweak_toggle = 1;
			wait(0.05);
		}

		if(tweak_toggle)
		{
			tweak_toggle = 0;
			fogsettings = getfogsettings();
			setdvar("scr_fog_nearplane",fogsettings[0]);
			setdvar("scr_fog_exp_halfplane",fogsettings[1]);
			setdvar("scr_fog_exp_halfheight",fogsettings[3]);
			setdvar("scr_fog_baseheight",fogsettings[2]);
			setdvar("scr_fog_color",fogsettings[4] + " " + fogsettings[5] + " " + fogsettings[6]);
			setdvar("scr_fog_color_scale",fogsettings[7]);
			setdvar("scr_sun_fog_color",fogsettings[8] + " " + fogsettings[9] + " " + fogsettings[10]);
			level.fogsundir = [];
			level.fogsundir[0] = fogsettings[11];
			level.fogsundir[1] = fogsettings[12];
			level.fogsundir[2] = fogsettings[13];
			setdvar("scr_sun_fog_start_angle",fogsettings[14]);
			setdvar("scr_sun_fog_end_angle",fogsettings[15]);
			setdvar("scr_fog_max_opacity",fogsettings[16]);
		}

		level.fogexphalfplane = GetDvarFloat(#"B59305FE");
		level.fogexphalfheight = GetDvarFloat(#"54D01B47");
		level.fognearplane = GetDvarFloat(#"5C40223D");
		level.fogbaseheight = GetDvarFloat(#"829C0FDB");
		level.fogcolorred = GetDvarColorRed(#"9DA55446");
		level.fogcolorgreen = GetDvarColorGreen(#"9DA55446");
		level.fogcolorblue = GetDvarColorBlue(#"9DA55446");
		level.fogcolorscale = GetDvarFloat(#"93B3FAED");
		level.sunfogcolorred = GetDvarColorRed(#"66A189BB");
		level.sunfogcolorgreen = GetDvarColorGreen(#"66A189BB");
		level.sunfogcolorblue = GetDvarColorBlue(#"66A189BB");
		level.sunstartangle = GetDvarFloat(#"ECC36390");
		level.sunendangle = GetDvarFloat(#"FA1301D9");
		level.fogmaxopacity = GetDvarFloat(#"81EA8425");
		if(GetDvarInt(#"9EF57A6C"))
		{
			setdvar("scr_art_sun_fog_dir_set","0");
			println("Setting sun fog direction to facing of player");
			players = get_players();
			dir = vectornormalize(AnglesToForward(players[0] getplayerangles()));
			level.fogsundir = [];
			level.fogsundir[0] = dir[0];
			level.fogsundir[1] = dir[1];
			level.fogsundir[2] = dir[2];
		}

		fovslidercheck();
		dumpsettings();
		if(!(GetDvarInt(#"DBBD8F3B")))
		{
			if(!(IsDefined(level.fogsundir)))
			{
				level.fogsundir = [];
				level.fogsundir[0] = 1;
				level.fogsundir[1] = 0;
				level.fogsundir[2] = 0;
			}

			setvolfog(level.fognearplane,level.fogexphalfplane,level.fogexphalfheight,level.fogbaseheight,level.fogcolorred,level.fogcolorgreen,level.fogcolorblue,level.fogcolorscale,level.sunfogcolorred,level.sunfogcolorgreen,level.sunfogcolorblue,level.fogsundir[0],level.fogsundir[1],level.fogsundir[2],level.sunstartangle,level.sunendangle,0,level.fogmaxopacity);
		}
		else
		{
			setexpfog(100000000,100000001,0,0,0,0);
		}

		wait(0.1);
	}
#/
}

//Function Number: 6
fovslidercheck()
{
	if(level.dofdefault["nearStart"] >= level.dofdefault["nearEnd"])
	{
		level.dofdefault["nearStart"] = level.dofdefault["nearEnd"] - 1;
		setdvar("scr_dof_nearStart",level.dofdefault["nearStart"]);
	}

	if(level.dofdefault["nearEnd"] <= level.dofdefault["nearStart"])
	{
		level.dofdefault["nearEnd"] = level.dofdefault["nearStart"] + 1;
		setdvar("scr_dof_nearEnd",level.dofdefault["nearEnd"]);
	}

	if(level.dofdefault["farStart"] >= level.dofdefault["farEnd"])
	{
		level.dofdefault["farStart"] = level.dofdefault["farEnd"] - 1;
		setdvar("scr_dof_farStart",level.dofdefault["farStart"]);
	}

	if(level.dofdefault["farEnd"] <= level.dofdefault["farStart"])
	{
		level.dofdefault["farEnd"] = level.dofdefault["farStart"] + 1;
		setdvar("scr_dof_farEnd",level.dofdefault["farEnd"]);
	}

	if(level.dofdefault["farBlur"] >= level.dofdefault["nearBlur"])
	{
		level.dofdefault["farBlur"] = level.dofdefault["nearBlur"] - 0.1;
		setdvar("scr_dof_farBlur",level.dofdefault["farBlur"]);
	}

	if(level.dofdefault["farStart"] <= level.dofdefault["nearEnd"])
	{
		level.dofdefault["farStart"] = level.dofdefault["nearEnd"] + 1;
		setdvar("scr_dof_farStart",level.dofdefault["farStart"]);
	}
}

//Function Number: 7
dumpsettings()
{
/#
	if(GetDvar(#"D1996D68") != "0")
	{
		println("\tstart_dist = " + level.fognearplane + ";");
		println("\thalf_dist = " + level.fogexphalfplane + ";");
		println("\thalf_height = " + level.fogexphalfheight + ";");
		println("\tbase_height = " + level.fogbaseheight + ";");
		println("\tfog_r = " + level.fogcolorred + ";");
		println("\tfog_g = " + level.fogcolorgreen + ";");
		println("\tfog_b = " + level.fogcolorblue + ";");
		println("\tfog_scale = " + level.fogcolorscale + ";");
		println("\tsun_col_r = " + level.sunfogcolorred + ";");
		println("\tsun_col_g = " + level.sunfogcolorgreen + ";");
		println("\tsun_col_b = " + level.sunfogcolorblue + ";");
		println("\tsun_dir_x = " + level.fogsundir[0] + ";");
		println("\tsun_dir_y = " + level.fogsundir[1] + ";");
		println("\tsun_dir_z = " + level.fogsundir[2] + ";");
		println("\tsun_start_ang = " + level.sunstartangle + ";");
		println("\tsun_stop_ang = " + level.sunendangle + ";");
		println("\ttime = 0;");
		println("\tmax_fog_opacity = " + level.fogmaxopacity + ";");
		println("");
		println("\tsetVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,");
		println("\t\tsun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, ");
		println("\t\tsun_stop_ang, time, max_fog_opacity);");
		setdvar("scr_art_dump","0");
	}
#/
}

//Function Number: 8
debug_reflection()
{
/#
	level.debug_reflection = 0;
	while(1)
	{
		wait(0.1);
		if((GetDvar(#"628768B6") == "2" && level.debug_reflection != 2) || GetDvar(#"628768B6") == "3" && level.debug_reflection != 3)
		{
			remove_reflection_objects();
			if(GetDvar(#"628768B6") == "2")
			{
				create_reflection_objects();
				level.debug_reflection = 2;
				continue;
			}

			create_reflection_objects();
			create_reflection_object();
			level.debug_reflection = 3;
			continue;
		}

		if(GetDvar(#"628768B6") == "1" && level.debug_reflection != 1)
		{
			setdvar("debug_reflection_matte","0");
			setdvar("debug_color_pallete","0");
			remove_reflection_objects();
			create_reflection_object();
			level.debug_reflection = 1;
			continue;
		}

		if(GetDvar(#"628768B6") == "0" && level.debug_reflection != 0)
		{
			remove_reflection_objects();
			level.debug_reflection = 0;
		}
	}
#/
}

//Function Number: 9
remove_reflection_objects()
{
/#
	if((level.debug_reflection == 2 || level.debug_reflection == 3) && IsDefined(level.debug_reflection_objects))
	{
		for(i = 0;i < level.debug_reflection_objects.size;i++)
		{
			level.debug_reflection_objects[i] delete();
		}

		level.debug_reflection_objects = undefined;
	}

	if(level.debug_reflection == 1 || level.debug_reflection == 3 || level.debug_reflection_matte == 1 || level.debug_color_pallete == 1 || level.debug_color_pallete == 2)
	{
		if(IsDefined(level.debug_reflectionobject))
		{
			level.debug_reflectionobject delete();
		}
	}
#/
}

//Function Number: 10
create_reflection_objects()
{
/#
	reflection_locs = getreflectionlocs();
	for(i = 0;i < reflection_locs.size;i++)
	{
		level.debug_reflection_objects[i] = spawn("script_model",reflection_locs[i]);
		level.debug_reflection_objects[i] setmodel("test_sphere_silver");
	}
#/
}

//Function Number: 11
create_reflection_object(model)
{
	if(!(IsDefined(model)))
	{
		model = "test_sphere_silver";
	}

/#
	if(IsDefined(level.debug_reflectionobject))
	{
		level.debug_reflectionobject delete();
	}

	players = get_players();
	player = players[0];
	level.debug_reflectionobject = spawn("script_model",100 + VectorScale(AnglesToForward(player.angles)));
	level.debug_reflectionobject setmodel(model);
	level.debug_reflectionobject.origin = 100 + VectorScale(AnglesToForward(player getplayerangles()));
	level.debug_reflectionobject linkto(player);
	thread debug_reflection_buttons();
#/
}

//Function Number: 12
debug_reflection_buttons()
{
/#
	level notify("new_reflection_button_running");
	level endon("new_reflection_button_running");
	level.debug_reflectionobject endon("death");
	offset = 100;
	lastoffset = offset;
	while(GetDvar(#"628768B6") == "1" || GetDvar(#"628768B6") == "3" || GetDvar(#"33E24970") == "1" || GetDvar(#"C450CB50") == "1" || GetDvar(#"C450CB50") == "2")
	{
		players = get_players();
		if(players[0] buttonpressed("BUTTON_X"))
		{
			offset = offset + 50;
		}

		if(players[0] buttonpressed("BUTTON_Y"))
		{
			offset = offset - 50;
		}

		if(offset > 1000)
		{
			offset = 1000;
		}

		if(offset < 64)
		{
			offset = 64;
		}

		level.debug_reflectionobject unlink();
		level.debug_reflectionobject.origin = offset + VectorScale(AnglesToForward(players[0] getplayerangles()));
		temp_angles = VectorToAngles(players[0].origin - level.debug_reflectionobject.origin);
		level.debug_reflectionobject.angles = (0,temp_angles[1],0);
		lastoffset = offset;
		line(level.debug_reflectionobject.origin,getreflectionorigin(level.debug_reflectionobject.origin),(1,0,0),1,1);
		wait(0.05);
		if(IsDefined(level.debug_reflectionobject))
		{
			level.debug_reflectionobject linkto(players[0]);
		}
	}
#/
}

//Function Number: 13
debug_reflection_matte()
{
/#
	level.debug_reflection_matte = 0;
	while(1)
	{
		wait(0.1);
		if(GetDvar(#"33E24970") == "1" && level.debug_reflection_matte != 1)
		{
			setdvar("debug_reflection","0");
			setdvar("debug_color_pallete","0");
			remove_reflection_objects();
			create_reflection_object("test_sphere_lambert");
			level.debug_reflection_matte = 1;
			continue;
		}

		if(GetDvar(#"33E24970") == "0" && level.debug_reflection_matte != 0)
		{
			remove_reflection_objects();
			level.debug_reflection_matte = 0;
		}
	}
#/
}

//Function Number: 14
debug_color_pallete()
{
/#
	level.debug_color_pallete = 0;
	while(1)
	{
		wait(0.1);
		if(GetDvar(#"C450CB50") == "1" && level.debug_color_pallete != 1)
		{
			setdvar("debug_reflection","0");
			setdvar("debug_reflection_matte","0");
			remove_reflection_objects();
			create_reflection_object("test_macbeth_chart");
			level.debug_color_pallete = 1;
			continue;
		}

		if(GetDvar(#"C450CB50") == "2" && level.debug_color_pallete != 2)
		{
			remove_reflection_objects();
			create_reflection_object("test_macbeth_chart_unlit");
			level.debug_color_pallete = 2;
			continue;
		}

		if(GetDvar(#"C450CB50") == "0" && level.debug_color_pallete != 0)
		{
			remove_reflection_objects();
			level.debug_color_pallete = 0;
		}
	}
#/
}