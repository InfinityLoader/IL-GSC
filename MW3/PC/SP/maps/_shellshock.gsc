/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_shellshock.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 34 ms
 * Timestamp: 10/27/2023 2:20:11 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level thread internalmain(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 2
internalmain(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		param_00 = 12;
	}
	else if(param_00 < 7)
	{
		param_00 = 7;
	}

	if(!isdefined(param_01))
	{
		param_01 = 150;
	}

	if(!isdefined(param_02))
	{
		param_02 = 100;
	}

	if(!isdefined(param_03))
	{
		param_03 = 100;
	}

	if(!isdefined(param_05))
	{
		var_06 = "default";
	}
	else
	{
		var_06 = var_06;
	}

	var_07 = level.player getorigin() + (0,8,2);
	var_08 = 320;
	var_09 = param_01 + randomint(param_02);
	var_0A = param_03;
	level.player playsound("weapons_rocket_explosion");
	wait 0.25;
	radiusdamage(var_07,var_08,var_09,var_0A);
	earthquake(0.75,2,var_07,2250);
	if(isalive(level.player))
	{
		level.player allowstand(0);
		level.player allowcrouch(0);
		level.player allowprone(1);
		wait 0.15;
		level.player viewkick(127,level.player.origin);
		level.player shellshock(var_06,param_00);
		if(!isdefined(param_04))
		{
			level.player thread playerhitable(param_00);
		}

		wait 1.5;
		level.player allowstand(1);
		level.player allowcrouch(1);
	}
}

//Function Number: 3
playerhitable(param_00)
{
	self.shellshocked = 1;
	self.ignoreme = 1;
	self notify("player is shell shocked");
	self endon("player is shell shocked");
	wait param_00 - 1;
	self.shellshocked = 0;
	self.ignoreme = 0;
}