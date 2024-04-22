/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _sarray.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 162 ms
 * Timestamp: 4/22/2024 2:22:29 AM
*******************************************************************/

//Function Number: 1
sarray_spawn()
{
	var_00 = spawnstruct();
	var_00.array = [];
	return var_00;
}

//Function Number: 2
sarray_set(param_00,param_01)
{
	self.array[param_00] = param_01;
}

//Function Number: 3
sarray_get(param_00)
{
	return self.array[param_00];
}

//Function Number: 4
sarray_copy(param_00)
{
	if(isarray(param_00))
	{
		self.array = param_00;
		return;
	}

	self.array = param_00.array;
}

//Function Number: 5
sarray_push(param_00)
{
	self.array[self.array.size] = param_00;
}

//Function Number: 6
sarray_pop()
{
	var_00 = self.array[self.array.size - 1];
	self.array[self.array.size - 1] = undefined;
	return var_00;
}

//Function Number: 7
sarray_clear()
{
	self.array = [];
}

//Function Number: 8
sarray_length()
{
	return self.array.size;
}

//Function Number: 9
sarray_create_func_obj(param_00)
{
	var_01 = spawnstruct();
	var_01.func = param_00;
	return var_01;
}

//Function Number: 10
sarray_sort_by_handler(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00 sarray_length() - 1;var_02++)
	{
		for(var_03 = var_02 + 1;var_03 < param_00 sarray_length();var_03++)
		{
			if(param_01 [[ param_01.func ]](param_00 sarray_get(var_03),param_00 sarray_get(var_02)))
			{
				var_04 = param_00 sarray_get(var_03);
				param_00 sarray_set(var_03,param_00 sarray_get(var_02));
				param_00 sarray_set(var_02,var_04);
			}
		}
	}
}