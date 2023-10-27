/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_medic.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 325 ms
 * Timestamp: 10/27/2023 3:12:12 AM
*******************************************************************/

//Function Number: 1
initmedic()
{
	level.medics = [];
	level.medictriggers = [];
	thread func_87A7();
}

//Function Number: 2
func_87A7()
{
	level.var_A41["medic_patient"] = [];
	level.var_A41["medic_patient"]["spawn"] = ::spawnmedicpatient;
	level.var_A41["medic_patient"]["think"] = ::medicpatientthink;
	level.var_A41["medic_patient"]["on_killed"] = ::onmedicpatientkilled;
	level waittill("agent_funcs_init");
	level.var_A41["medic_patient"]["on_damaged"] = ::onmedicpatientdamaged;
	level.var_A41["medic_patient"]["on_damaged_finished"] = level.var_A41["player"]["on_damaged_finished"];
}

//Function Number: 3
setmedic()
{
	self.medic_patient_array = [];
	level.medics = common_scripts\utility::func_F6F(level.medics,self);
}

//Function Number: 4
unsetmedic()
{
	self.medic_patient_array = undefined;
	level.medics = common_scripts\utility::func_F93(level.medics,self);
}

//Function Number: 5
ondeath_handlemedic()
{
	self endon("disconnect");
	level endon("game_ended");
	if(canspawnmedicpatienttrigger())
	{
		thread setupmedicpatienttrigger();
	}
}

//Function Number: 6
canspawnmedicpatienttrigger()
{
	self endon("disconnect");
	level endon("game_ended");
	if(level.medics.size <= 0)
	{
		return 0;
	}

	var_00 = maps/mp/agents/_agent_utility::get_max_agents();
	if(maps/mp/agents/_agent_utility::func_45BB() >= var_00)
	{
		return 0;
	}

	foreach(var_02 in level.medics)
	{
		if(var_02 canmediccreatepatient(self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
canmediccreatepatient(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(self) || !maps\mp\_utility::func_57A0(self))
	{
		return 0;
	}

	if(self == param_00 || self.var_1A7 != param_00.var_1A7)
	{
		return 0;
	}

	if(!maps\mp\_utility::func_649("specialty_medic"))
	{
		return 0;
	}

	if(isdefined(self.medic_patient_array) && self.medic_patient_array.size > 0)
	{
		return 0;
	}

	var_01 = maps/mp/agents/_agent_utility::get_max_agents();
	if(maps/mp/agents/_agent_utility::func_45BB() >= var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
setupmedicpatienttrigger()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = spawnstruct();
	var_00.var_116 = self.var_116;
	var_00.var_1D = (0,0,0);
	var_00.var_9D65 = spawn("script_origin",var_00.var_116);
	var_00.var_9D65.var_68FB = var_00;
	var_00.var_9D65 makeusable();
	var_00.var_9D65 sethintstring(&"DIVISIONS_DLC3_MEDIC_PATIENT_TRIGGER");
	var_00.var_106 = spawn("script_model",var_00.var_116);
	var_00.var_106 linkto(self,"tag_origin");
	var_00.var_106 setmodel("tag_origin");
	level.medictriggers = common_scripts\utility::func_F6F(level.medictriggers,var_00);
	thread medic_trigger_enable_use_watcher(var_00);
	var_01 = [[ level.var_A4D ]]("medic_patient",self.var_1A7,undefined,self.var_116,self.var_1D,undefined,0,0,"recruit");
	var_00 thread handlemedictrigger(var_01);
	var_00 thread handlemedictriggerdeleteaftertime(var_01);
	var_01 setpatientactive(0);
	var_01 maps/mp/agents/_agent_utility::func_83FE(self.var_1A7);
	var_01 method_86D0();
}

//Function Number: 9
medic_trigger_enable_use_watcher(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	param_00.var_9D65 endon("deleted");
	foreach(var_02 in level.var_744A)
	{
		if(var_02 canmediccreatepatient(self))
		{
			param_00.var_9D65 enableplayeruse(var_02);
			continue;
		}

		param_00.var_9D65 disableplayeruse(var_02);
	}

	for(;;)
	{
		level waittill("joined_team",var_02);
		if(var_02 canmediccreatepatient(self))
		{
			param_00.var_9D65 enableplayeruse(var_02);
			continue;
		}

		param_00.var_9D65 disableplayeruse(var_02);
	}
}

//Function Number: 10
handlemedictrigger(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self.var_9D65 waittill("trigger",var_01);
	param_00 maps/mp/agents/_agent_utility::func_83FE(var_01.var_1A7,var_01);
	param_00 method_86D1();
	var_01 thread end_medic_patient(param_00);
	var_01.medic_patient_array = common_scripts\utility::func_F6F(var_01.medic_patient_array,param_00);
	param_00.var_117 = var_01;
	param_00 setpatientactive(1);
	param_00 thread [[ level.var_A55 ]](var_01);
	foreach(var_03 in level.medictriggers)
	{
		var_03.var_9D65 disableplayeruse(var_01);
	}

	param_00 notify("patient_revived");
	handlemedictriggerdelete();
}

//Function Number: 11
setpatientactive(param_00)
{
	self botsetflag("disable_attack",!param_00);
	self botsetflag("disable_movement",!param_00);
	self botsetflag("disable_rotation",!param_00);
	if(param_00)
	{
		self.patientdown = undefined;
		self.var_9 = &"DIVISIONS_DLC3_MEDIC_PATIENT";
		return;
	}

	self.patientdown = 1;
}

//Function Number: 12
handlemedictriggerdeleteaftertime(param_00)
{
	self endon("death");
	level endon("game_ended");
	var_01 = param_00 common_scripts\utility::func_A71A(20);
	param_00 method_86D1();
	param_00.patientdown = undefined;
	maps/mp/agents/_agent_utility::func_5A28(param_00);
	handlemedictriggerdelete();
}

//Function Number: 13
handlemedictriggerdelete()
{
	if(isdefined(self))
	{
		level.medictriggers = common_scripts\utility::func_F93(level.medictriggers,self);
		self.var_106 delete();
		self.var_9D65 notify("deleted");
		self.var_9D65 delete();
		self notify("death");
	}
}

//Function Number: 14
spawnmedicpatient(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	maps/mp/agents/_agent_utility::func_5334(1);
	self.var_5BE0 = spawnstruct();
	self.var_5BE0.var_116 = param_00;
	self.var_5BE0.var_1D = param_01;
	maps/mp/agents/_agent_utility::func_8A7();
	self.var_5CC6 = maps/mp/agents/_agent_utility::func_45AE(self.var_109);
	self.var_5BE2 = gettime();
	var_07 = param_00 + (0,0,25);
	var_08 = param_00;
	var_09 = playerphysicstrace(var_07,var_08);
	if(distancesquared(var_09,var_07) > 1)
	{
		param_00 = var_09;
	}

	self method_838F(param_00,param_01);
	if(isdefined(param_05))
	{
		self [[ level.var_19D5["bot_set_difficulty"] ]](param_05);
	}

	self [[ level.var_19D5["bot_set_personality"] ]]("default");
	maps/mp/agents/_agent_common::func_83FD(getdvarint("scr_player_maxhealth",100));
	self [[ level.var_A5B ]]();
	maps\mp\gametypes\_class::func_4773(self.var_1A7,self.var_2319,1);
	if(isdefined(self.var_117))
	{
		self thread [[ level.var_A55 ]](self.var_117);
	}

	thread maps\mp\_flashgrenades::func_6394();
	self thread [[ level.var_19D5["bot_think_watch_enemy"] ]](1);
	self thread [[ level.var_19D5["bot_think_tactical_goals"] ]]();
	self thread [[ maps/mp/agents/_agent_utility::func_A59("think") ]]();
	if(!self.var_4B60)
	{
		lib_050D::func_9FA();
	}

	thread maps\mp\gametypes\_weapons::func_9B90();
	self.var_4B60 = 0;
	thread maps\mp\gametypes\_healthoverlay::func_73FC();
	if(self.var_1A7 == "allies")
	{
		self setmodel("usa_paratrooper_streak_org1_mp");
		self attach("mp_head_clark_org1");
	}
	else
	{
		self setmodel("ita_paratrooper_streak_org1_mp");
		self attach("mp_head_clark_org1");
	}

	level notify("spawned_agent_player",self);
	level notify("spawned_agent",self);
	self notify("spawned_player");
}

//Function Number: 15
medicpatientthink()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self [[ self.var_6F7F ]]();
		wait 0.05;
	}
}

//Function Number: 16
onmedicpatientdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	level endon("game_ended");
	self endon("death");
	if(common_scripts\utility::func_562E(self.patientdown))
	{
		return 0;
	}

	self [[ level.var_A41["player"]["on_damaged"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 17
onmedicpatientkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self [[ level.var_A5D ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,1);
	if(isdefined(level.var_6A75))
	{
		[[ level.var_6A75 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	thread maps\mp\gametypes\_weapons::func_34A9(param_01,param_03,param_04);
	if(self.var_565F)
	{
		self.var_4B60 = 1;
		maps/mp/agents/_agent_utility::func_2A73();
	}

	if(isdefined(self.var_117))
	{
		self.var_117 notify("patient_died");
		self.var_117.medic_patient_array = common_scripts\utility::func_F93(self.var_117.medic_patient_array,self);
	}

	self.patientdown = undefined;
}

//Function Number: 18
end_medic_patient(param_00)
{
	level endon("game_ended");
	self endon("patient_died");
	var_01 = common_scripts\utility::func_A71B(60,"disconnect","joined_team");
	maps/mp/agents/_agent_utility::func_5A28(param_00);
	self.medic_patient_array = common_scripts\utility::func_F93(self.medic_patient_array,param_00);
}