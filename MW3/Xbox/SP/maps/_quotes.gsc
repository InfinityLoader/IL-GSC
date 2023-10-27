/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_quotes.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 110 ms
 * Timestamp: 10/27/2023 2:33:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread setdeadquote();
}

//Function Number: 2
setdeadquote()
{
	level endon("mine death");
	level notify("new_quote_string");
	level endon("new_quote_string");
	if(isalive(level.player))
	{
		level.player waittill("death");
	}

	if(!level.var_1291)
	{
		var_00 = int(tablelookup("sp/deathQuoteTable.csv",1,"size",0));
		var_01 = randomint(var_00);
		if(getdvar("cycle_deathquotes") != "")
		{
			if(getdvar("ui_deadquote_index") == "")
			{
				setdvar("ui_deadquote_index","0");
			}

			var_01 = getdvarint("ui_deadquote_index");
			setdvar("ui_deadquote",func_1471(var_01));
			var_01++;
			if(var_01 > var_00 - 1)
			{
				var_01 = 0;
			}

			setdvar("ui_deadquote_index",var_01);
			return;
		}

		setdvar("ui_deadquote",func_1471(var_01));
	}
}

//Function Number: 3
func_1471(param_00)
{
	var_01 = tablelookup("sp/deathQuoteTable.csv",0,param_00,1);
	if(tolower(var_01[0]) != tolower("@"))
	{
		var_01 = "@" + var_01;
	}

	return var_01;
}

//Function Number: 4
setdeadquote_so()
{
	level notify("new_quote_string");
	var_00 = [];
	var_00 = so_builddeadquote();
	var_00 = maps\_utility::array_randomize(var_00);
	var_01 = randomint(var_00.size);
	if(!maps\_utility::is_coop_online())
	{
		var_02 = var_00.size > 1;
		var_03 = var_01;
		while(var_02)
		{
			if(func_1474(var_00[var_01]))
			{
				var_01++;
				if(var_01 >= var_00.size)
				{
					var_01 = 0;
				}

				if(var_01 == var_03)
				{
					var_02 = 0;
				}

				continue;
			}

			var_02 = 0;
		}

		setdvar("ui_deadquote_v3",getdvar("ui_deadquote_v2"));
		setdvar("ui_deadquote_v2",getdvar("ui_deadquote_v1"));
		setdvar("ui_deadquote_v1",var_00[var_01]);
	}

	switch(var_00[var_01])
	{
		case "@DEADQUOTE_SO_ICON_PARTNER":
			maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_partner");
			break;

		case "@DEADQUOTE_SO_ICON_OBJ":
			maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_obj");
			break;

		case "@DEADQUOTE_SO_ICON_OBJ_OFFSCREEN":
			maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_obj_offscreen");
			break;

		case "@DEADQUOTE_SO_STAR_RANKINGS":
			maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_stars");
			break;

		case "@DEADQUOTE_SO_CLAYMORE_ENEMIES_SHOOT":
		case "@DEADQUOTE_SO_CLAYMORE_POINT_ENEMY":
			maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_claymore");
			break;

		case "@DEADQUOTE_SO_STEALTH_STAY_LOW":
			maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_stealth_stance");
			break;
	}

	setdvar("ui_deadquote",var_00[var_01]);
}

//Function Number: 5
func_1474(param_00)
{
	if(param_00 == getdvar("ui_deadquote_v1"))
	{
		return 1;
	}

	if(param_00 == getdvar("ui_deadquote_v2"))
	{
		return 1;
	}

	if(param_00 == getdvar("ui_deadquote_v3"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
so_builddeadquote()
{
	if(should_use_custom_deadquotes())
	{
		return level.var_1408;
	}

	var_00 = [];
	if(!maps\_utility::is_survival())
	{
	}
	else
	{
	}

	if(isdefined(self.so_infohud_toggle_state) && self.so_infohud_toggle_state != "none")
	{
	}

	if(maps\_utility::func_E89())
	{
	}

	return var_41;
}

//Function Number: 7
should_use_custom_deadquotes()
{
	if(!isdefined(level.var_1408))
	{
		return 0;
	}

	if(level.var_1408.size <= 0)
	{
		return 0;
	}

	return level.so_deadquotes_chance >= randomfloat(1);
}