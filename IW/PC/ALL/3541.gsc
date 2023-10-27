/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3541.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:30:37 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_1303C()
{
	self endon("disconnect");
	self endon("removeAdrenaline");
	self notify("adrenaline_used");
	self notify("force_regeneration");
	self playlocalsound("mp_adrenaline_on");
	self playsoundtoteam("mp_adrenaline_on_npc","axis",self);
	self playsoundtoteam("mp_adrenaline_on_npc","allies",self);
	self playlocalsound("mp_adrenaline_pulse");
	if(self.health < self.maxhealth)
	{
		scripts\mp\_missions::func_D991("ch_tactical_adrenaline");
	}
	else
	{
		self.var_13071 = 1;
		thread func_40E0();
	}

	self.var_8BC2 = 1;
	scripts\mp\_utility::func_8387("specialty_adrenaline");
	thread func_E0C4();
	thread func_E0C6();
	thread func_E0C3();
	thread func_13A85();
	var_00 = scripts\mp\_powerloot::func_7FC1("power_adrenaline",5);
	scripts\mp\_powers::func_4575(var_00,"power_adrenaline_update","removeAdrenaline");
	thread func_E0C2();
}

//Function Number: 3
func_E0C2(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	if(isdefined(self.var_8BC2) && self.var_8BC2)
	{
		self notify("removeAdrenaline");
		self.var_8BC2 = 0;
		scripts\mp\_utility::func_E150("specialty_adrenaline");
		self setscriptablepartstate("adrenaline","neutral",0);
		self setscriptablepartstate("adrenalineHeal","neutral",0);
		if(param_00 != "death")
		{
			self playlocalsound("mp_adrenaline_off");
		}
	}
}

//Function Number: 4
func_E0C4()
{
	self endon("disconnect");
	self endon("removeAdrenaline");
	self notify("removeAdrenalineOnDeath");
	self endon("removeAdrenalineOnDeath");
	self waittill("death");
	thread func_E0C2("death");
}

//Function Number: 5
func_E0C6()
{
	self endon("disconnect");
	self endon("removeAdrenaline");
	self notify("removeAdrenalineOnGameEnd");
	self endon("removeAdrenalineOnGameEnd");
	level waittill("game_ended");
	thread func_E0C2();
}

//Function Number: 6
func_E0C3()
{
	self endon("disconnect");
	self endon("removeAdrenaline");
	self notify("removeAdrenalineOnCancel");
	self endon("removeAdrenalineOnCancel");
	self waittill("cancelAdrenaline");
	thread func_E0C2();
}

//Function Number: 7
func_40E0()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("cleanupAdrenalineMissionTracking");
	self endon("cleanupAdrenalineMissionTracking");
	self waittill("death");
	self.var_13071 = undefined;
}

//Function Number: 8
func_7EF5()
{
	return 4;
}

//Function Number: 9
func_13A85()
{
	self endon("disconnect");
	self endon("removeAdrenaline");
	self setscriptablepartstate("adrenaline","active",0);
	self setscriptablepartstate("adrenalineHeal","active",0);
}