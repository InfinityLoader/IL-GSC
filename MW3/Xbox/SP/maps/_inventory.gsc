/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_inventory.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 6
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 2:34:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.inventory = [];
}

//Function Number: 2
func_3BBC(param_00,param_01)
{
	if(1)
	{
		return spawnstruct();
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = newhudelem();
	var_02.alignx = "right";
	var_02.aligny = "top";
	var_02.horzalign = "right";
	var_02.vertalign = "top";
	var_02.alpha = 0;
	var_02.index = level.inventory.size;
	var_02.var_3BBD = param_01;
	var_02 setshader(param_00,40,40);
	level.inventory[var_02.index] = var_02;
	func_3BC0();
	return var_02;
}

//Function Number: 3
func_3BBE()
{
	if(1)
	{
		return;
	}

	self.var_3BBD = 0;
	func_3BC0();
}

//Function Number: 4
func_3BBF()
{
	if(1)
	{
		return;
	}

	self.var_3BBD = 1;
	func_3BC0();
}

//Function Number: 5
func_3BC0()
{
	if(1)
	{
		return;
	}

	var_00 = -18;
	var_01 = 8;
	var_02 = 42;
	var_03 = 0;
	for(var_04 = 0;var_04 < level.inventory.size;var_04++)
	{
		if(level.inventory[var_04].var_3BBD)
		{
			var_05 = var_01 + var_02 * var_03;
			if(var_05 != level.inventory[var_04].y)
			{
				level.inventory[var_04].x = var_00;
				if(level.inventory[var_04].alpha != 0)
				{
					level.inventory[var_04] moveovertime(0.3);
				}

				level.inventory[var_04].y = var_05;
			}

			if(level.inventory[var_04].alpha != 1)
			{
				level.inventory[var_04] fadeovertime(0.3);
				level.inventory[var_04].alpha = 1;
			}

			var_03++;
			continue;
		}

		level.inventory[var_04] fadeovertime(0.3);
		level.inventory[var_04].alpha = 0;
	}
}

//Function Number: 6
func_3BC1()
{
	if(1)
	{
		return;
	}

	self destroy();
	var_00 = 0;
	var_01 = level.inventory;
	level.inventory = [];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02]))
		{
			level.inventory[level.inventory.size] = var_01[var_02];
		}
	}

	func_3BC0();
}