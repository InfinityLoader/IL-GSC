/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animmode.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 1:59:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self endon("stop_animmode");
	self notify("killanimscript");
	self._tag_entity endon(self._anime);
	if(isdefined(self._custom_anim_thread))
	{
		self thread [[ self._custom_anim_thread ]]();
		self._custom_anim_thread = undefined;
	}

	var_00 = isdefined(self._custom_anim_loop) && self._custom_anim_loop;
	if(var_00)
	{
		self endon("stop_loop");
		self._custom_anim_loop = undefined;
	}
	else
	{
		thread notify_on_end(self._anime);
	}

	var_01 = self._anime;
	self._anime = undefined;
	var_02 = 0;
	if(var_00 || isarray(level.scr_anim[self._animname][var_01]))
	{
		var_02 = level.scr_anim[self._animname][var_01].size;
		var_03 = level.scr_anim[self._animname][var_01][randomint(var_02)];
	}
	else
	{
		var_03 = level.scr_anim[self._animname][var_02];
	}

	var_04 = getstartorigin(self._tag_entity.origin,self._tag_entity.angles,var_03);
	var_05 = getstartangles(self._tag_entity.origin,self._tag_entity.angles,var_03);
	var_06 = self getdroptofloorposition(var_04);
	if(isdefined(var_06))
	{
		var_04 = var_06;
	}
	else
	{
	}

	if(!isdefined(self.noteleport))
	{
		self teleport(var_04,var_05);
	}

	self.pushable = 0;
	var_07 = 0.3;
	var_08 = 0.2;
	if(isdefined(self.anim_blend_time_override))
	{
		var_07 = self.anim_blend_time_override;
		var_08 = self.anim_blend_time_override;
	}

	self animmode(self._animmode);
	self clearanim(self.root_anim,var_07);
	self orientmode("face angle",var_05[1]);
	var_09 = "custom_animmode";
	self setflaggedanimrestart(var_09,var_03,1,var_08,1);
	self._tag_entity thread maps\_anim::start_notetrack_wait(self,var_09,var_01,self._animname,var_03);
	self._tag_entity thread maps\_anim::animscriptdonotetracksthread(self,var_09,var_01);
	var_0A = self._tag_entity;
	self._tag_entity = undefined;
	self._animmode = undefined;
	self endon("killanimscript");
	var_0B = "end";
	if(!var_00)
	{
		if(animhasnotetrack(var_03,"finish"))
		{
			var_0B = "finish";
		}
		else if(animhasnotetrack(var_03,"stop anim"))
		{
			var_0B = "stop anim";
		}
	}

	for(;;)
	{
		self waittillmatch(var_0B,var_09);
		if(var_00)
		{
			var_03 = level.scr_anim[self._animname][var_01][randomint(var_02)];
			self setflaggedanimknoblimitedrestart(var_09,var_03,1,0.2,1);
			if(isdefined(var_0A))
			{
				var_0A thread maps\_anim::start_notetrack_wait(self,var_09,var_01,self._animname,var_03);
				var_0A thread maps\_anim::animscriptdonotetracksthread(self,var_09,var_01);
			}

			continue;
		}

		break;
	}

	if(var_0B != "end")
	{
		self orientmode("face motion");
	}

	self notify("finished_custom_animmode" + var_01);
}

//Function Number: 2
notify_on_end(param_00)
{
	self endon("death");
	self endon("finished_custom_animmode" + param_00);
	self waittill("killanimscript");
	self notify("finished_custom_animmode" + param_00);
}