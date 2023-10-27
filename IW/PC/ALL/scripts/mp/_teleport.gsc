/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_teleport.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 483 ms
 * Timestamp: 10/27/2023 12:21:49 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_F87E()
{
	thread func_13A73();
}

//Function Number: 3
func_12D44()
{
	self notify("teleportUnset");
	if(self.var_AE62 == "archetype_assassin")
	{
		self setscriptablepartstate("teleporttrail","neutral",0);
	}

	self method_8208();
	scripts\mp\_utility::func_E0E6("teleport",0);
}

//Function Number: 4
func_10DFA(param_00,param_01)
{
	self playanimscriptevent("power_active","teleport");
	self setscriptablepartstate("teleporttrail","active",0);
	self motionblurhqenable();
	level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_ftl",undefined,0.75);
	thread func_4524(0.5);
}

//Function Number: 5
func_6391()
{
	self playsound("ftl_teleport_npc_in");
	self playanimscriptevent("power_exit","teleport");
	self setscriptablepartstate("teleporttrail","neutral",0);
	self method_8208();
}

//Function Number: 6
func_13A73()
{
	self endon("disconnect");
	self endon("teleportUnset");
	self notify("watchForTeleport");
	self endon("watchForTeleport");
	for(;;)
	{
		var_00 = spawnstruct();
		childthread func_13A77(var_00);
		childthread func_13A75(var_00);
		childthread func_13A74(var_00);
		childthread func_13A76(var_00);
		self waittill("teleportBeginRace");
		waittillframeend;
		if(isdefined(var_00.var_6ACF))
		{
			if(isplayer(self))
			{
				scripts\mp\_hud_message::func_10122("MP_TELEPORT_FAILED");
			}

			scripts\mp\_supers::func_DE7D();
		}
		else if(isdefined(var_00.var_10DE6) && isdefined(var_00.var_4E59))
		{
			scripts\mp\_supers::func_DE7D();
		}
		else if(isdefined(var_00.var_637B))
		{
			self notify("teleport_success");
			func_6391();
		}
		else if(isdefined(var_00.var_10DE6))
		{
			self notify("teleport_success");
			func_10DFA(var_00.var_2C5,var_00.var_6378);
		}

		self notify("teleportEndRace");
	}
}

//Function Number: 7
func_13A77(param_00)
{
	self endon("teleportEndRace");
	self waittill("teleportStart",var_01,var_02);
	param_00.var_10DE6 = 1;
	param_00.var_2C5 = var_01;
	param_00.var_6378 = var_02;
	self notify("teleportBeginRace");
}

//Function Number: 8
func_13A75(param_00)
{
	self endon("teleportEndRace");
	self waittill("teleportEnd");
	param_00.var_637B = 1;
	self notify("teleportBeginRace");
}

//Function Number: 9
func_13A74(param_00)
{
	self endon("teleportEndRace");
	self waittill("death");
	param_00.var_4E59 = 1;
	self notify("teleportBeginRace");
}

//Function Number: 10
func_13A76(param_00)
{
	self endon("teleportEndRace");
	self waittill("teleportFailed");
	param_00.var_6ACF = 1;
	self notify("teleportBeginRace");
}

//Function Number: 11
func_4524(param_00)
{
	self endon("death");
	self endon("disconnect");
	scripts\mp\_utility::func_8387("specialty_no_target");
	wait(param_00);
	scripts\mp\_utility::func_E150("specialty_no_target");
}