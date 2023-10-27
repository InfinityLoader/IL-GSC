/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_battlecry.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 229 ms
 * Timestamp: 10/27/2023 3:21:04 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level endon("game_ended");
	setdvarifuninitialized("battlecry_enabled",0);
	level.var_1648 = 0;
	level.battlecrymovespeedscale = 1.12;
	for(;;)
	{
		if(getdvarint("battlecry_enabled",0) && level.var_1648 == 0)
		{
			level.var_1648 = 1;
			thread func_A71F();
			return;
		}

		wait(1);
	}
}

//Function Number: 2
func_A71F()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(!isdefined(var_00.var_1643))
		{
			var_00.var_1643 = 1;
			var_00.var_1647 = 1;
			if(!isbot(var_00))
			{
				var_00.var_1645 = newclienthudelem(var_00);
				var_00.var_1645.maxsightdistsqrd = 0;
				var_00.var_1645.var_1D7 = 0;
				var_00.var_1645.accuracy = "left";
				var_00.var_1645.var_11 = "top";
				var_00.var_1645.var_C6 = "fullscreen";
				var_00.var_1645.var_1CA = "fullscreen";
				var_00.var_1645 setshader("combathigh_overlay",640,480);
				var_00.var_1645.var_18 = 0;
				var_00.var_1645.var_56 = (1,1,1);
				var_00.var_1645.ignoreme = -3;
				var_00 notifyonplayercommand("activate_battlecry","+actionslot 3");
			}

			var_00 thread func_1646();
			var_00 thread func_A88F();
			var_00 thread func_49A0();
			var_00 thread func_A735();
		}
	}
}

//Function Number: 3
func_1646()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self.var_1642 = 0;
		self.var_1649 = -1;
		self waittill("spawned_player");
	}
}

//Function Number: 4
func_A88F()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("activate_battlecry");
		if(self.var_1647)
		{
			self.var_1647 = 0;
			self.var_1642 = 1;
			foreach(var_01 in level.var_744A)
			{
				if(self.var_1A7 == var_01.var_1A7)
				{
					var_01.var_1649 = 60;
				}
			}

			self.var_1644 = maps\mp\_entityheadicons::func_869E(self.var_1A7,"waypoint_escort",(0,0,90),14,14,0,0.05,0,1,0,0,"tag_origin");
			if(isdefined(self.var_1645))
			{
				self.var_1645.var_18 = 1;
			}

			foreach(var_01 in level.var_744A)
			{
				if(!isbot(var_01) && var_01.var_1A7 == self.var_1A7)
				{
					var_01 iclientprintlnbold(&"MP_BATTLECRY_ACTIVE");
					var_01 method_8615("battlecry_use");
				}
			}
		}
	}
}

//Function Number: 5
func_49A0()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		if(self.var_1649 > 0)
		{
			if(isdefined(self.var_1645))
			{
				self.var_1645.var_18 = 1;
			}

			self.var_1649 = self.var_1649 - 1;
			maps\mp\gametypes\_weapons::func_A13B();
			if(!maps\mp\_utility::func_649("specialty_fastreload"))
			{
				maps\mp\_utility::func_47A2("specialty_fastreload");
			}

			self.var_98E2 = 4;
			self.var_98E1 = 0.1;
			self notify("damage");
		}
		else if(self.var_1649 == 0)
		{
			if(isdefined(self.var_1645))
			{
				self.var_1645.var_18 = 0;
			}

			maps\mp\gametypes\_weapons::func_A13B();
			if(maps\mp\_utility::func_649("specialty_fastreload"))
			{
				maps\mp\_utility::func_735("specialty_fastreload");
			}

			self.var_98E2 = undefined;
			self.var_98E1 = undefined;
			self notify("damage");
			func_3673();
			self.var_1649 = -1;
		}

		wait(1);
	}
}

//Function Number: 6
func_A735()
{
	level endon("game_ended");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("disconnect","death","faux_spawn");
		if(isdefined(self))
		{
			func_3673();
		}
	}
}

//Function Number: 7
func_3673()
{
	self.var_1647 = 0;
	self.var_1642 = 0;
	self.var_1649 = 0;
	if(isdefined(self.var_1644))
	{
		self.var_1644 destroy();
	}
}

//Function Number: 8
func_1647()
{
	self iclientprintlnbold(&"MP_BATTLECRY_READY");
	self method_8615("battlecry_use");
	self.var_1647 = 1;
}

//Function Number: 9
func_164A()
{
	level endon("game_ended");
	self endon("disconnect");
	thread func_A7F9();
}

//Function Number: 10
func_A7F9()
{
	level endon("game_ended");
	self endon("disconnect");
	thread func_6511();
}

//Function Number: 11
func_3209()
{
	level endon("game_ended");
	self endon("disconnect");
	thread func_3212();
}

//Function Number: 12
func_6511()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("updateRecentKills");
		wait 0.05;
		if(self.var_7AD2 > 1 && self.var_1642 == 0 && self.var_1647 == 0)
		{
			func_1647();
		}
	}
}

//Function Number: 13
func_6633()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("neardeath_battlecry");
		if(self.var_1642 == 0 && self.var_1647 == 0)
		{
			func_1647();
		}
	}
}

//Function Number: 14
func_7B43()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("recovery_battlecry");
		if(self.var_1642 == 0 && self.var_1647 == 0)
		{
			func_1647();
		}
	}
}

//Function Number: 15
func_9EA2()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("turned_on_battlecry");
		if(self.var_1642 == 0 && self.var_1647 == 0)
		{
			func_1647();
		}
	}
}

//Function Number: 16
func_3212()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("dominated_battlecry");
		if(isdefined(self.var_1A7) && maps/mp/gametypes/dom::func_46CC(maps\mp\_utility::func_45DE(self.var_1A7)) == level.var_3CC5.size && self.var_1642 == 0 && self.var_1647 == 0)
		{
			func_1647();
		}

		wait 0.05;
	}
}