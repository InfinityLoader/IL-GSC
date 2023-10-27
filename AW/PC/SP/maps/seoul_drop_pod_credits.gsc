/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\seoul_drop_pod_credits.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 205 ms
 * Timestamp: 10/27/2023 1:56:47 AM
*******************************************************************/

//Function Number: 1
credits_start()
{
	level.used_credits_data1 = [];
	level.used_credits_data2 = [];
	level.used_credits = [];
	level.credits_alpha = 0.85;
	var_00 = 16;
	if(level.console)
	{
		var_01 = [33,110,var_00 + 2,"left","middle","left","middle"];
	}
	else
	{
		var_01 = [76,110,var_01 + 2,"left","middle","left","middle"];
	}

	var_02 = [-350,-110,var_00,"left","middle"];
	var_03 = [300,-110,var_00,"right","middle"];
	var_04 = [-350,150,var_00,"left","middle"];
	var_05 = [300,150,var_00,"right","middle"];
	show_shg_title_credits(var_01);
}

//Function Number: 2
credits_display_think(param_00)
{
	var_01 = 1;
	while(!common_scripts\utility::flag("kill_credits"))
	{
		while(common_scripts\utility::flag("pause_credits"))
		{
			level.credits_alpha = 0.55;
			wait 0.05;
		}

		if(var_01)
		{
			var_02 = [param_00[0],param_00[1]];
			common_scripts\utility::flag_set("pause_credits");
		}
		else
		{
			var_02 = param_00;
		}

		var_01 = 0;
		foreach(var_04 in var_02)
		{
			if(!common_scripts\utility::flag("kill_credits"))
			{
				thread quadrant_display(var_04);
				wait(6.25);
			}
		}

		param_00 = common_scripts\utility::array_randomize(param_00);
	}
}

//Function Number: 3
show_shg_title_credits(param_00)
{
	wait(2);
	var_01 = get_title_credit(param_00,&"SEOUL_CREDITS_SHG_DEVELOPMENT",3);
	maps\_utility::delaythread(3,::text_glow_adjust,var_01,0.2);
	thread maps\_utility::delaythread(4.5,::fade_name_random,var_01,0,1,4);
	wait(5);
	var_02 = get_title_credit(param_00,&"SEOUL_CREDITS_ASSOCIATION_WITH",2);
	thread maps\_utility::delaythread(6.5,::fade_name_random,var_02,0,1);
	wait(2);
	var_03 = get_title_credit(param_00,&"SEOUL_CREDITS_RAVEN_SOFT",1);
	thread maps\_utility::delaythread(3.5,::fade_name_random,var_03,0,1);
	wait(1.25);
	var_04 = get_title_credit(param_00,&"SEOUL_CREDITS_HIGHMOON",0);
	thread maps\_utility::delaythread(3.5,::fade_name_random,var_04,0,1);
	wait(3.7);
	var_05 = get_title_credit(param_00,&"SEOUL_CREDITS_COD_AW",3,1);
	wait(4);
}

//Function Number: 4
show_exec_title_credits(param_00)
{
	var_01 = [param_00[0],param_00[1],param_00[2] + 3,param_00[3],param_00[4]];
	var_02 = get_title_credit(var_01,&"SEOUL_CREDITS_DIRECTED_BY",3,1);
	thread maps\_utility::delaythread(8,::fade_name_random,var_02,0,1);
	wait(2);
	var_03 = get_title_credit(var_01,&"SEOUL_CREDITS_GLEN_SCHOFIELD",2);
	maps\_utility::delaythread(1,::text_glow_adjust,var_03,0.2);
	thread maps\_utility::delaythread(3.5,::fade_name_random,var_03,0,1);
	wait(2);
	var_04 = get_title_credit(var_01,&"SEOUL_CREDITS_MICHAEL_CONDREY",1);
	maps\_utility::delaythread(1,::text_glow_adjust,var_04,0.2);
	thread maps\_utility::delaythread(3.5,::fade_name_random,var_04,0,1);
	wait(4);
}

//Function Number: 5
get_title_credit(param_00,param_01,param_02,param_03)
{
	var_04 = 18;
	var_05 = maps\_shg_design_tools::get_standard_glow_text(param_00[0],param_00[1],param_00[2],param_00[3],param_00[4],param_02 * -1,(0.75,0.85,0.87),(0.25,0.25,0.3),param_00[5],param_00[6]);
	var_05.textstring = param_01;
	var_05.alpha = 0;
	var_05 fadeovertime(1.25);
	var_05.alpha = level.credits_alpha;
	var_05.fontscale = 1.85;
	var_05 settext(param_01);
	if(isdefined(param_03) && param_03)
	{
		var_05 setpulsefx(50,6000,700);
	}

	return var_05;
}

//Function Number: 6
quadrant_display(param_00)
{
	var_01 = get_random_strings_and_alphabatize(6);
	var_02 = [];
	foreach(var_05, var_04 in var_01)
	{
		var_02[var_05] = maps\_shg_design_tools::get_standard_glow_text(param_00[0],param_00[1],param_00[2],param_00[3],param_00[4],var_05 * -1,(0.75,0.85,0.87),(0.25,0.25,0.3));
		var_02[var_05] settext(var_04);
		var_02[var_05].alpha = 0;
		var_02[var_05].textstring = var_04;
	}

	foreach(var_07 in var_02)
	{
		thread fade_name_random(var_07);
		wait(0.2);
	}

	wait(3);
	var_08 = common_scripts\utility::array_randomize(var_02);
	foreach(var_07 in var_08)
	{
		thread fade_name_random(var_07,0);
		wait(randomfloat(0.5));
	}

	foreach(var_07 in var_08)
	{
		while(!var_07.at_rest)
		{
			wait 0.05;
		}

		var_07 destroy();
	}
}

//Function Number: 7
get_random_strings_and_alphabatize(param_00)
{
	var_01 = [];
	var_02 = common_scripts\utility::array_combine(level.credits_data1,level.credits_data2);
	var_03 = common_scripts\utility::array_combine(level.used_credits_data1,level.used_credits_data2);
	var_04 = level.credits_data2;
	var_05 = var_02;
	while(var_01.size < param_00 && level.used_credits.size < var_02.size)
	{
		var_06 = min(int(param_00 / 2),level.credits_data2.size - level.used_credits_data2.size);
		if(var_01.size < var_06)
		{
			var_07 = common_scripts\utility::random(var_04);
		}
		else
		{
			var_07 = common_scripts\utility::random(var_05);
		}

		if(common_scripts\utility::array_contains(level.used_credits,var_07))
		{
			continue;
		}

		if(common_scripts\utility::array_contains(var_01,var_07))
		{
			continue;
		}

		if(common_scripts\utility::array_contains(level.credits_data1,var_07))
		{
			level.used_credits_data1[level.used_credits_data1.size] = var_07;
		}
		else
		{
			level.used_credits_data2[level.used_credits_data2.size] = var_07;
		}

		var_01[var_01.size] = var_07;
		level.used_credits[level.used_credits.size] = var_07;
	}

	var_01 = common_scripts\utility::alphabetize(var_01);
	var_01 = common_scripts\utility::array_reverse(var_01);
	return var_01;
}

//Function Number: 8
alphabetize_localized_string(param_00,param_01)
{
	var_02 = [];
	var_03 = [];
	foreach(var_05 in param_00)
	{
		var_06[0] = var_05;
		var_06[1] = get_index_from_array(var_05,param_01);
		var_03[var_03.size] = var_06;
	}

	var_08 = 0;
	foreach(var_0A in var_03)
	{
		var_02[var_0A[1]] = var_0A[0];
	}

	var_0B = [];
	foreach(var_0D in var_02)
	{
		var_0B[var_0B.size] = var_0D;
	}

	return var_0B;
}

//Function Number: 9
get_index_from_array(param_00,param_01)
{
	var_02 = undefined;
	foreach(var_05, var_04 in param_01)
	{
		if(var_04 == param_00)
		{
			return var_05;
		}
	}
}

//Function Number: 10
fade_name_random(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = level.credits_alpha;
	}

	param_00.at_rest = 0;
	if(!isdefined(param_03))
	{
		param_03 = randomfloatrange(0.5,1.25);
	}

	param_00 fadeovertime(param_03);
	param_00.alpha = param_01;
	param_00 fadeovertime(param_03);
	wait(param_03);
	if(isdefined(param_00))
	{
		param_00.at_rest = 1;
	}

	if(isdefined(param_02) && isdefined(param_00))
	{
		param_00 destroy();
	}
}

//Function Number: 11
text_glow_adjust(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.85;
	}

	param_00.at_rest = 0;
	if(!isdefined(param_02))
	{
		param_02 = randomfloatrange(0.5,1.25);
	}

	var_03 = param_00.glowcolor;
	wait(param_02);
	var_04 = randomintrange(30,40);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		var_06 = param_00.glowcolor;
		if(common_scripts\utility::cointoss())
		{
			if(common_scripts\utility::cointoss())
			{
				var_06 = (param_00.glowcolor[0] / 2,param_00.glowcolor[1] / 2,param_00.glowcolor[2] / 2 - randomfloat(1));
			}
			else if(param_00.glowcolor[0] > 0.15)
			{
				var_06 = (param_00.glowcolor[0] * 2,param_00.glowcolor[1] * 2,param_00.glowcolor[2] * 2 * randomfloatrange(1,1.5));
			}

			param_00.glowcolor = var_06;
			param_00.glowalpha = randomfloat(1);
		}
		else if(common_scripts\utility::cointoss())
		{
			if(common_scripts\utility::cointoss())
			{
				param_00.alpha = level.credits_alpha * 0.7;
			}
			else
			{
				param_00.alpha = level.credits_alpha;
			}
		}

		wait 0.05;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	param_00.glowcolor = var_03;
	param_00.glowalpha = param_01;
	param_00.alpha = level.credits_alpha;
	param_00.at_rest = 1;
}

//Function Number: 12
standard_text_list(param_00,param_01)
{
	var_02 = newclienthudelem(level.player);
	var_02.positioninworld = 1;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.foreground = 1;
	var_02.hidewheninmenu = 1;
	var_02.start_x = param_00;
	var_02.y = param_01;
	return var_02;
}