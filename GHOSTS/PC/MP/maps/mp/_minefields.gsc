/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_minefields.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 70 ms
 * Timestamp: 10/27/2023 1:22:25 AM
*******************************************************************/

//Function Number: 1
func_5251()
{
	var_00 = getentarray("minefield","targetname");
	if(var_00.size > 0)
	{
		level._effect["mine_explosion"] = loadfx("vfx/gameplay/explosions/weap/gre/vfx_exp_gre_dirt_cg");
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread func_5250();
	}
}

//Function Number: 2
func_5250()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			var_00 thread func_524F(self);
		}
	}
}

//Function Number: 3
func_524F(param_00)
{
	if(isdefined(self.minefield))
	{
	}

	self.minefield = 1;
	wait(0.5);
	wait(randomfloat(0.5));
	if(isdefined(self) && self istouching(param_00))
	{
		var_01 = self getorigin();
		var_02 = 300;
		var_03 = 2000;
		var_04 = 50;
		radiusdamage(var_01,var_02,var_03,var_04);
	}

	self.minefield = undefined;
}