/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 41 ms
 * Timestamp: 10/27/2023 3:23:44 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_A012 = spawnstruct();
	level.var_A012.var_C6 = "left";
	level.var_A012.var_1CA = "top";
	level.var_A012.accuracy = "left";
	level.var_A012.var_11 = "top";
	level.var_A012.maxsightdistsqrd = 0;
	level.var_A012.var_1D7 = 0;
	level.var_A012.var_1D2 = 0;
	level.var_A012.var_BD = 0;
	level.var_A012.var_21F6 = [];
	level.var_3DD8 = 12;
	level.var_4F52["allies"] = spawnstruct();
	level.var_4F52["axis"] = spawnstruct();
	level.var_76FF = -61;
	level.var_76FE = 0;
	level.var_76FA = 9;
	level.var_76FD = 120;
	level.var_76FC = -75;
	level.var_76FB = 0;
	level.var_76F9 = 0.6;
	level.var_9868 = 32;
	level.var_9865 = 14;
	level.var_9867 = 192;
	level.var_9866 = 8;
	level.var_9864 = 1.65;
	level.var_5F2F = "BOTTOM";
	level.var_5F2E = -90;
	level.var_5F2D = 1.6;
}

//Function Number: 2
func_3DDA(param_00)
{
	self.var_15FC = self.var_9B;
	if(isdefined(param_00))
	{
		self.var_6085 = min(param_00,6.3);
	}
	else
	{
		self.var_6085 = min(self.var_9B * 2,6.3);
	}

	self.var_5136 = 2;
	self.var_6C71 = 4;
}

//Function Number: 3
func_3DD9(param_00)
{
	self notify("fontPulse");
	self endon("fontPulse");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	self changefontscaleovertime(self.var_5136 * 0.05);
	self.var_9B = self.var_6085;
	wait(self.var_5136 * 0.05);
	self changefontscaleovertime(self.var_6C71 * 0.05);
	self.var_9B = self.var_15FC;
}