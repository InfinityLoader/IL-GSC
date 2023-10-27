/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfxundo.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 20
 * Decompile Time: 52 ms
 * Timestamp: 10/27/2023 3:04:56 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_createfx;
#include maps/mp/_createfxmenu;
#include maps/mp/_utility;

//Function Number: 1
store_undo_state(change_type,ents)
{
	if(!(IsDefined(level.cfx_undo_states)))
	{
		level.cfx_undo_states = [];
		level.cfx_redo_states = [];
		level.cfx_limbo_state = spawnstruct();
		level.cfx_max_states = 10;
	}

	if(!(isarray(ents)))
	{
		ents = array(ents);
	}

	temp_array = [];
	for(i = 0;i < ents.size;i++)
	{
		temp_array[i] = copy_fx_ent(ents[i]);
	}

	state = spawnstruct();
	state.operation = change_type;
	state.last_action = level.cfx_last_action;
	state.ent_array = temp_array;
	if(level.cfx_undo_states.size >= level.cfx_max_states)
	{
		level.cfx_undo_states = array_drop(level.cfx_undo_states);
	}

	level.cfx_undo_states[level.cfx_undo_states.size] = state;
	level.cfx_redo_states = [];
	level.cfx_limbo_state = undefined;
	debug_print_latest_state("undo");
}

//Function Number: 2
undo()
{
	if(!IsDefined(level.createfxent) || !IsDefined(level.cfx_undo_states) || level.cfx_undo_states.size < 1)
	{
		return;
	}

	revert_state = level.cfx_undo_states[level.cfx_undo_states.size - 1];
	if(level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
		move_undo_state_to_redo();
		clear_entity_selection("skip_undo");
		apply_state_change("undo",revert_state);
		move_undo_state_to_limbo();
		level.cfx_last_action = "none";
	}
	else
	{
		clear_entity_selection("skip_undo");
		if(revert_state.operation != "edit")
		{
			apply_state_change("undo",revert_state);
			move_undo_state_to_redo();
			level.cfx_last_action = "none";
		}
		else if(IsDefined(level.cfx_limbo_state))
		{
			move_limbo_state_to_redo();
			apply_state_change("undo",revert_state);
			move_undo_state_to_limbo();
			level.cfx_last_action = "none";
		}
		else
		{
			if(level.cfx_undo_states.size > 1)
			{
				move_undo_state_to_redo();
				revert_state = level.cfx_undo_states[level.cfx_undo_states.size - 1];
			}

			apply_state_change("undo",revert_state);
			move_undo_state_to_limbo();
		}
	}
}

//Function Number: 3
apply_state_change(type,revert_state)
{
	if(type == "undo")
	{
/#
		println("^2CreateFX: Undo operation");
#/
		if(revert_state.operation == "edit")
		{
			undo_edit(revert_state.ent_array);
		}
		else if(revert_state.operation == "add")
		{
			undo_add(revert_state.ent_array);
		}
		else if(revert_state.operation == "delete")
		{
			undo_delete(revert_state.ent_array);
		}
	}
	else
	{
/#
		println("^2CreateFX: Redo operation");
#/
		if(revert_state.operation == "edit")
		{
			undo_edit(revert_state.ent_array);
		}
		else if(revert_state.operation == "add")
		{
			undo_delete(revert_state.ent_array);
		}
		else if(revert_state.operation == "delete")
		{
			undo_add(revert_state.ent_array);
		}
	}
}

//Function Number: 4
move_undo_state_to_redo()
{
	if(level.cfx_redo_states.size >= level.cfx_max_states)
	{
		level.cfx_redo_states = array_drop(level.cfx_redo_states);
	}

	level.cfx_redo_states[level.cfx_redo_states.size] = level.cfx_undo_states[level.cfx_undo_states.size - 1];
	level.cfx_undo_states = array_pop(level.cfx_undo_states);
	debug_print_latest_state("undo");
	debug_print_latest_state("redo");
}

//Function Number: 5
move_redo_state_to_undo()
{
	if(level.cfx_undo_states.size >= level.cfx_max_states)
	{
		level.cfx_undo_states = array_drop(level.cfx_undo_states);
	}

	level.cfx_undo_states[level.cfx_undo_states.size] = level.cfx_redo_states[level.cfx_redo_states.size - 1];
	level.cfx_redo_states = array_pop(level.cfx_redo_states);
	debug_print_latest_state("undo");
	debug_print_latest_state("redo");
}

//Function Number: 6
move_undo_state_to_limbo()
{
	level.cfx_limbo_state = level.cfx_undo_states[level.cfx_undo_states.size - 1];
	level.cfx_undo_states = array_pop(level.cfx_undo_states);
	debug_print_latest_state("undo");
	debug_print_latest_state("limbo");
}

//Function Number: 7
move_redo_state_to_limbo()
{
	level.cfx_limbo_state = level.cfx_redo_states[level.cfx_redo_states.size - 1];
	level.cfx_redo_states = array_pop(level.cfx_redo_states);
	debug_print_latest_state("redo");
	debug_print_latest_state("limbo");
}

//Function Number: 8
move_limbo_state_to_undo()
{
	if(level.cfx_undo_states.size >= level.cfx_max_states)
	{
		level.cfx_undo_states = array_drop(level.cfx_undo_states);
	}

	level.cfx_undo_states[level.cfx_undo_states.size] = level.cfx_limbo_state;
	level.cfx_limbo_state = undefined;
	debug_print_latest_state("undo");
	debug_print_latest_state("limbo");
}

//Function Number: 9
move_limbo_state_to_redo()
{
	if(level.cfx_redo_states.size >= level.cfx_max_states)
	{
		level.cfx_redo_states = array_drop(level.cfx_redo_states);
	}

	level.cfx_redo_states[level.cfx_redo_states.size] = level.cfx_limbo_state;
	level.cfx_limbo_state = undefined;
	debug_print_latest_state("redo");
}

//Function Number: 10
undo_edit(ent_array)
{
	ent_array = reorder_ent_array_by_uniqueid(ent_array);
/#
	println("^3CreateFX: Undoing edit");
	debug_print_ent_array(ent_array,"ent_array[]");
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
#/
	last_id = ent_array[ent_array.size - 1].uniqueid;
	if(last_id > level.createfxent.size - 1)
	{
		last_id = level.createfxent.size - 1;
	}

	j = ent_array.size - 1;
	source_ent = ent_array[j];
	for(i = last_id;i >= 0;i--)
	{
		target_ent = level.createfxent[i];
		if(source_ent.uniqueid == target_ent.uniqueid)
		{
			copy_values_between_fx_ents(source_ent,target_ent);
			select_entity(i,target_ent,"skip_undo");
			j--;
			if(j < 0)
			{
				break;
			}

			source_ent = ent_array[j];
		}
	}

	update_selected_entities();
/#
	println("^1CreateFX: Finished edit");
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
#/
}

//Function Number: 11
undo_add(ent_array)
{
	ent_array = reorder_ent_array_by_uniqueid(ent_array);
/#
	println("^3createfx: Undoing add.");
	debug_print_ent_array(ent_array,"ent_array[]");
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
#/
	last_id = ent_array[ent_array.size - 1].uniqueid;
	if(last_id > level.createfxent.size - 1)
	{
		last_id = level.createfxent.size - 1;
	}

	j = ent_array.size - 1;
	source_ent = ent_array[j];
	for(i = last_id;i >= 0;i--)
	{
		target_ent = level.createfxent[i];
		if(source_ent.uniqueid == target_ent.uniqueid)
		{
			if(IsDefined(target_ent.looper))
			{
				target_ent.looper delete();
			}

			target_ent notify("stop_loop");
			level.createfxent[i] = undefined;
			j--;
			if(j < 0)
			{
				break;
			}

			source_ent = ent_array[j];
		}
	}

/#
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
	println("createfx: Starting array_remove_undefined()");
#/
	arrayremovevalue(level.createfxent,undefined);
/#
	println("^1CreateFX: Finished undo add.");
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
#/
	clear_fx_hudelements();
}

//Function Number: 12
undo_delete(ent_array)
{
/#
	println("^3CreateFX: Undoing delete");
	debug_print_ent_array(ent_array,"ent_array in undo_delete()");
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
#/
	ent_array = reorder_ent_array_by_uniqueid(ent_array);
	if(level.createfxent.size == 0)
	{
		for(i = 0;i < ent_array.size;i++)
		{
			level.createfxent[i] = copy_fx_ent(ent_array[i]);
		}
	}
	else
	{
		temp_array = [];
		i = 0;
		for(j = 0;j < level.createfxent.size;j++)
		{
			target_ent = level.createfxent[j];
			if(i >= ent_array.size)
			{
				temp_array[temp_array.size] = target_ent;
			}
			else
			{
				source_ent = ent_array[i];
				if(target_ent.uniqueid < source_ent.uniqueid)
				{
					temp_array[temp_array.size] = target_ent;
				}
				else
				{
					temp_array[temp_array.size] = copy_fx_ent(source_ent);
					j--;
					i++;
				}
			}
		}

		while(i < ent_array.size)
		{
			temp_array[temp_array.size] = ent_array[i];
			i++;
		}

		level.createfxent = temp_array;
	}

/#
	println("^1Createfx: Finished undoing delete, pre-selection");
	debug_print_ent_array(level.createfxent,"level.createFXent[]");
#/
	last_id = ent_array[ent_array.size - 1].uniqueid;
	if(last_id > level.createfxent.size - 1)
	{
		last_id = level.createfxent.size - 1;
	}

	j = ent_array.size - 1;
	source_ent = ent_array[j];
	for(i = last_id;i >= 0;i--)
	{
		target_ent = level.createfxent[i];
		if(source_ent.uniqueid == target_ent.uniqueid)
		{
			target_ent post_entity_creation_function();
			select_entity(i,target_ent,"skip_undo");
			j--;
			if(j < 0)
			{
				break;
			}

			source_ent = ent_array[j];
		}
	}

	update_selected_entities();
}

//Function Number: 13
redo()
{
	if(!IsDefined(level.createfxent) || !IsDefined(level.cfx_redo_states) || level.cfx_redo_states.size < 1)
	{
		return;
	}

	clear_entity_selection("skip_undo");
	if(IsDefined(level.cfx_limbo_state))
	{
		move_limbo_state_to_undo();
		move_redo_state_to_limbo();
		apply_state_change("redo",level.cfx_limbo_state);
	}
	else
	{
		revert_state = level.cfx_redo_states[level.cfx_redo_states.size - 1];
		apply_state_change("redo",revert_state);
		if(revert_state.operation == "edit")
		{
			move_redo_state_to_limbo();
		}
		else
		{
			move_redo_state_to_undo();
		}
	}

	level.cfx_last_action = "none";
}

//Function Number: 14
reorder_ent_array_by_uniqueid(ent_array)
{
	if(ent_array.size <= 1)
	{
		return ent_array;
	}

	array_size = ent_array.size;
	for(i = 0;i < array_size - 1;i++)
	{
		for(j = i + 1;j < array_size;j++)
		{
			if(ent_array[i].uniqueid > ent_array[j].uniqueid)
			{
				temp_ent = ent_array[i];
				ent_array[i] = ent_array[j];
				ent_array[j] = temp_ent;
			}
		}
	}

	return ent_array;
}

//Function Number: 15
copy_fx_ent(ent)
{
	temp_ent = spawnstruct();
	temp_ent.drawn = ent.drawn;
	temp_ent.drawn_axis_model = ent.drawn_axis_model;
	temp_ent.last_fx_index = ent.last_fx_index;
	temp_ent.textalpha = ent.textalpha;
	temp_ent.uniqueid = ent.uniqueid;
	temp_ent.v = ent.v;
	return temp_ent;
}

//Function Number: 16
copy_values_between_fx_ents(source,dest)
{
	dest.drawn = source.drawn;
	dest.drawn_axis_model = source.drawn_axis_model;
	dest.last_fx_index = source.last_fx_index;
	dest.textalpha = source.textalpha;
	dest.v = source.v;
	return dest;
}

//Function Number: 17
array_pop(array)
{
	array_size = array.size - 1;
	temp_array = [];
	if(array_size <= 0)
	{
		return temp_array;
	}

	for(i = 0;i < array_size;i++)
	{
		temp_array[i] = array[i];
	}

	array = temp_array;
	return array;
}

//Function Number: 18
array_drop(array)
{
	if(array.size > 0)
	{
		temp_array = [];
		for(i = 1;i < array.size;i++)
		{
			temp_array[i - 1] = array[i];
		}

		array = temp_array;
	}

	return array;
}

//Function Number: 19
debug_print_ent_array(array,name)
{
/#
	println("Printing out " + name);
	println("Printing out some array");
	i = 0;
	for(;;)
	{
		println("" + i + ": deleted effect");
		println("" + i + ": uniqueid: " + array[i].uniqueid + "  fxid: " + array[i].v["fxid"]);
		i++;
	}
(Stack-Empty ? Stack-Empty : IsDefined(name)) ? i < array.size : IsDefined(array[i])
#/
}

//Function Number: 20
debug_print_latest_state(type)
{
/#
	println("^3Saving " + type + " state");
	println("There are no undo states.");
	return;
	state = level.cfx_undo_states[level.cfx_undo_states.size - 1];
	size = level.cfx_undo_states.size - 1;
	println("There are no redo states.");
	return;
	state = level.cfx_redo_states[level.cfx_redo_states.size - 1];
	size = level.cfx_redo_states.size - 1;
	println("There is no limbo state.");
	return;
	state = level.cfx_limbo_state;
	size = 0;
	println("State " + size + " - " + state.operation + ": " + state.last_action);
	debug_print_ent_array(state.ent_array,"save state ent_array");
type == "undo" ? IsDefined(level.cfx_undo_states[level.cfx_undo_states.size - 1]) : (type == "redo" ? IsDefined(level.cfx_redo_states[level.cfx_redo_states.size - 1]) : IsDefined(level.cfx_limbo_state))
#/
}