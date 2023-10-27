/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_shg_debug.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 118 ms
 * Timestamp: 10/27/2023 2:00:21 AM
*******************************************************************/

//Function Number: 1
draw_point(param_00,param_01,param_02,param_03)
{
}

//Function Number: 2
draw_axis(param_00,param_01,param_02,param_03)
{
}

//Function Number: 3
draw_debug_sphere(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 4
create_debug_text_hud(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 2;
	if(isdefined(param_05))
	{
		var_06 = param_05;
	}

	var_07 = level.player maps\_hud_util::createclientfontstring("default",var_06);
	var_07.x = param_01;
	var_07.y = param_02;
	var_07.sort = 1;
	var_07.horzalign = "fullscreen";
	var_07.vertalign = "fullscreen";
	var_07.alpha = 1;
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	var_07.color = param_03;
	if(isdefined(param_04))
	{
		var_07.label = param_04;
	}

	level.debug_text_hud[param_00] = var_07;
}

//Function Number: 5
print_debug_text_hud(param_00,param_01)
{
	level.debug_text_hud[param_00] setvalue(param_01);
}

//Function Number: 6
print_debug_text_string_hud(param_00,param_01)
{
	level.debug_text_hud[param_00] settext(param_01);
}

//Function Number: 7
change_debug_text_hud_color(param_00,param_01)
{
	level.debug_text_hud[param_00].color = param_01;
}

//Function Number: 8
delete_debug_text_hud(param_00)
{
	level.debug_text_hud[param_00] destroy();
	level.debug_text_hud[param_00] = undefined;
}