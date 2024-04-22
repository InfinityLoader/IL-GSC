/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _exo_punch_door.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 142 ms
 * Timestamp: 4/22/2024 2:20:57 AM
*******************************************************************/

//Function Number: 1
exo_door_init()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",4);
	setsaveddvar("r_hudoutlinecloaklumscale",0.5);
	setsaveddvar("r_hudoutlineAlpha0",1);
	setsaveddvar("r_hudoutlineAlpha1",0);
	setsaveddvar("r_hudoutlinecloakblurradius",0.45);
	setsaveddvar("r_hudoutlinecloakDarkenscale",1);
	setsaveddvar("r_hudoutlinecloaklumscale",1);
	setsaveddvar("r_hudoutlinehaloblurradius",1);
	setsaveddvar("r_hudoutlinehalodarkenscale",1);
	setsaveddvar("r_hudoutlinehaloLumscale",1);
	var_00 = getentarray("door_exo_punch_intact","targetname");
	var_01 = getentarray("door_exo_punch_broken","targetname");
	var_02 = getentarray("exo_punch_door_trigger","targetname");
	var_03 = getentarray("exo_punch_door_clip","targetname");
	var_04 = getentarray("exo_punch_door_usetrigger","targetname");
	foreach(var_06 in var_00)
	{
		var_06.trig = common_scripts\utility::getclosest(var_06.origin,var_02,100);
		var_06.broken = common_scripts\utility::getclosest(var_06.origin,var_01,50);
		var_06.clip = common_scripts\utility::getclosest(var_06.origin,var_03,100);
		var_06.handles = getentarray(var_06.target,"targetname");
		var_06.usetrig = common_scripts\utility::getclosest(var_06.origin,var_04,100);
		var_06 thread monitor_door_punch();
		var_06 thread exo_punch_outline_think();
		if(isdefined(var_06.usetrig))
		{
			var_06.usetrig sethintstring(&"RECOVERY_PROMPT_MELEE_BREACH");
			var_06.button = var_06.usetrig maps\_shg_utility::hint_button_trigger("rs",300);
		}
	}

	level.player thread monitor_last_weapon();
	edi_anims();
}

//Function Number: 2
monitor_last_weapon()
{
	self endon("death");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(var_00 != "none" && isdefined(var_00))
		{
			self.old_weapon = var_00;
		}

		wait 0.05;
	}
}

//Function Number: 3
exo_punch_outline_think()
{
	self endon("exo_door_punched");
	thread exo_door_punch_cleanup();
	for(;;)
	{
		if(distance(self.origin,level.player.origin) < 350)
		{
			if(!target_istarget(self))
			{
				target_set(self);
				target_hidefromplayer(self,level.player);
			}

			if(target_istarget(self) && target_isincircle(self,level.player,65,120))
			{
				self hudoutlineenable(6,1);
			}
			else
			{
				self hudoutlinedisable();
			}
		}
		else if(target_istarget(self))
		{
			target_remove(self);
		}

		wait 0.05;
	}
}

//Function Number: 4
exo_door_punch_cleanup()
{
	self waittill("exo_door_punched");
	self hudoutlinedisable();
}

//Function Number: 5
monitor_door_punch()
{
	self.broken hide();
	self.clip disconnectpaths();
	for(;;)
	{
		self.trig waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_01 == level.player && var_04 == "MOD_MELEE_ALT")
		{
			self.usetrig sethintstring(" ");
			self.button maps\_shg_utility::hint_button_clear();
			level.player switchtoweaponimmediate(level.player.old_weapon);
			self notify("exo_door_punched");
			self.direction = var_02;
			self.land_point = var_03;
			self.original_origin = self.origin;
			break;
		}

		wait 0.05;
	}

	var_05 = self.broken;
	var_05 show();
	self hide();
	self.origin = self.origin - (0,0,10000);
	common_scripts\utility::array_call(self.handles,::delete);
	self.clip.origin = self.clip.origin - (0,0,10000);
	self.clip connectpaths();
	exo_door_smash();
}

//Function Number: 6
exo_door_smash()
{
	var_00 = self.direction;
	var_01 = self.broken;
	var_02 = (randomintrange(-5,5),randomintrange(-5,5),randomintrange(-10,10));
	var_01 physicslaunchserver(var_01.origin + var_02,var_00 * randomintrange(500,1100));
	level.player notify("exo_door_punched");
	var_03 = getaiarray("axis");
	foreach(var_05 in var_03)
	{
		var_05 thread monitor_door_impact(self);
		var_05 thread monitor_door_react(self);
	}
}

//Function Number: 7
monitor_door_impact(param_00)
{
	var_01 = param_00.broken;
	self endon("death");
	var_01 endon("physics_finished");
	while(distance(self.origin,var_01.origin) > 80)
	{
		wait 0.05;
	}

	var_02 = vectornormalize(self gettagorigin("tag_eye") - param_00.original_origin);
	var_02 = vectornormalize(var_02 + (randomfloat(0.5),randomfloat(0.5),randomfloat(0.5)));
	self startragdollfromimpact("torso_lower",var_02 * randomintrange(2400,2800));
	thread common_scripts\utility::delaycall(2,::kill);
}

//Function Number: 8
monitor_door_react(param_00)
{
	var_01 = param_00.broken;
	self endon("death");
	var_01 endon("physics_finished");
	while(distance(self.origin,var_01.origin) > 200)
	{
		wait 0.05;
	}

	maps\_utility::flashbangstart(randomfloatrange(1,4));
}

//Function Number: 9
edi_anims()
{
	level.scr_anim["generic"]["exo_punch_react_1"] = %corner_standr_flinchb;
	level.scr_anim["generic"]["exo_punch_react_2"] = %corner_standr_flinch;
	level.scr_anim["generic"]["exo_punch_react_3"] = %exposed_crouch_pain_flinch;
	level.scr_anim["generic"]["exo_punch_react_4"] = %ny_harbor_bulkhead_door_breach_stunned_guy2;
	level.door_punch_flinches = ["exo_punch_react_1","exo_punch_react_2","exo_punch_react_3","exo_punch_react_4"];
}