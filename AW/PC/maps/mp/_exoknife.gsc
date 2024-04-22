/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_exoknife.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 218 ms
 * Timestamp: 4/22/2024 2:15:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["exo_knife_blood"] = loadfx("vfx/weaponimpact/flesh_impact_head_fatal_exit");
}

//Function Number: 2
exo_knife_think()
{
	thread exo_knife_throw_watch();
}

//Function Number: 3
exo_knife_throw_watch()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 != "exoknife_mp" && var_02 != "exoknife_jug_mp")
		{
			continue;
		}

		var_00.manuallydetonatefunc = ::exo_knife_manually_detonate;
		var_00.flying = 1;
		var_00.weaponname = var_01;
		if(!isdefined(var_00.recall))
		{
			var_00.recall = 0;
		}

		var_00.owner = self;
		thread exo_knife_enable_detonate(var_00);
		var_00 thread exo_knife_touch_watch();
		var_00 thread exo_knife_stuck_watch();
		var_00 thread exo_knife_recall_watch();
		var_00 thread exo_knife_emp_watch();
	}
}

//Function Number: 4
exo_knife_emp_watch()
{
	self endon("death");
	for(;;)
	{
		level waittill("emp_update");
		if(isdefined(level.empequipmentdisabled) && level.empequipmentdisabled && self.owner maps\mp\_utility::isempedbykillstreak())
		{
			thread exo_knife_delete();
		}
	}
}

//Function Number: 5
exo_knife_enable_detonate(param_00)
{
	self endon("disconnect");
	if(!isdefined(self.exoknife_count))
	{
		self.exoknife_count = 0;
	}

	if(!self.exoknife_count)
	{
		common_scripts\utility::_enabledetonate(param_00.weaponname,1);
	}

	self.exoknife_count++;
	param_00 waittill("death");
	self.exoknife_count--;
	if(!self.exoknife_count)
	{
		common_scripts\utility::_enabledetonate(param_00.weaponname,0);
	}
}

//Function Number: 6
exo_knife_passed_target()
{
	self endon("death");
	self.owner endon("disconnect");
	self waittill("missile_passed_target");
	exo_knife_restock();
}

//Function Number: 7
exo_knife_touch_watch()
{
	if(!isdefined(self.owner))
	{
		return;
	}

	self endon("death");
	self.owner endon("disconnect");
	var_00 = spawn("trigger_radius",self.origin,0,15,5);
	var_00 enablelinkto();
	var_00 linkto(self);
	var_00.knife = self;
	thread common_scripts\utility::delete_on_death(var_00);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01 != self.owner)
		{
			continue;
		}

		if(var_01 getfractionmaxammo(self.weaponname) >= 1)
		{
			continue;
		}

		break;
	}

	exo_knife_restock();
}

//Function Number: 8
exo_knife_restock()
{
	self.owner setclientomnvar("damage_feedback","throwingknife");
	self.owner setweaponammostock(self.weaponname,self.owner setweaponammostock(self.weaponname) + 1);
	exo_knife_delete();
}

//Function Number: 9
exo_knife_stuck_watch()
{
	self endon("death");
	for(;;)
	{
		self waittill("missile_stuck",var_00);
		var_01 = maps\mp\_riotshield::entisstucktoshield();
		self.flying = 0;
		self.recall = 0;
		if(isdefined(self.owner) && isdefined(var_00) && (isdefined(level.ishorde) && level.ishorde && var_00.model == "animal_dobernan") || maps\mp\_utility::isgameparticipant(var_00) && !var_01)
		{
			if(isdefined(var_00.team) && isdefined(self.owner.team) && var_00.team != self.owner.team)
			{
				playimpactheadfatalfx(self.origin,self.origin - self.owner.origin);
			}

			var_00 maps\mp\_snd_common_mp::snd_message("exo_knife_player_impact");
			var_02 = getdvarfloat("exo_knife_return_delay",0.5);
			self.owner thread exo_knife_recall(var_02);
			continue;
		}

		thread maps\mp\gametypes\_weapons::stickyhandlemovers(undefined,"exo_knife_recall");
	}
}

//Function Number: 10
exo_knife_recall_stuck_watch()
{
	self endon("death");
	for(;;)
	{
		self waittill("missile_stuck",var_00);
		if(isdefined(self.owner) && isdefined(var_00) && var_00 maps\mp\_utility::isjuggernaut())
		{
			if(!level.teambased || isdefined(self.owner.team) && isdefined(var_00.team) && var_00.team != self.owner.team)
			{
				thread exo_knife_delete();
			}
		}
	}
}

//Function Number: 11
exo_knife_recall(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("exo_knife_recall");
	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}

	self notify("exo_knife_recall");
}

//Function Number: 12
exo_knife_manually_detonate(param_00)
{
	if(isdefined(param_00) && !param_00.recall)
	{
		exo_knife_recall();
	}
}

//Function Number: 13
exo_knife_recall_watch()
{
	self endon("death");
	if(!isdefined(self.owner))
	{
		return;
	}

	self.owner endon("disconnect");
	self.owner endon("death");
	self.owner waittill("exo_knife_recall");
	var_00 = self.origin;
	var_01 = self.owner geteye();
	if(self.owner getstance() != "prone")
	{
		var_01 = var_01 - (0,0,20);
	}

	var_02 = getdvarfloat("exo_knife_speed",1200);
	var_03 = distance(var_00,var_01);
	var_04 = var_03 / var_02;
	var_05 = self.owner getvelocity();
	var_01 = var_01 + var_05 * var_04;
	var_06 = var_01 - var_00;
	var_06 = vectornormalize(var_06);
	var_07 = 0;
	if(var_07 != 0)
	{
		var_00 = var_00 + var_06 * var_07;
	}

	var_08 = var_06 * var_02;
	var_09 = magicgrenademanual(self.weaponname,var_00,var_08,30,self.owner,1);
	var_09.owner = self.owner;
	var_09.recall = 1;
	var_09 missile_settargetent(self.owner);
	var_09 thread exo_knife_recall_stuck_watch();
	var_09 thread exo_knife_passed_target();
	exo_knife_delete();
}

//Function Number: 14
exo_knife_clean_up_attractor(param_00,param_01,param_02)
{
	common_scripts\utility::waittill_any_ents(param_01,"disconnect",param_01,"death",param_02,"death",param_02,"missile_stuck");
	missile_deleteattractor(param_00);
}

//Function Number: 15
exo_knife_delete()
{
	self delete();
}