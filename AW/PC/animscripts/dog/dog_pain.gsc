/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_pain.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 44 ms
 * Timestamp: 4/22/2024 1:58:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["pain"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	if(isdefined(self.enemy) && isdefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self && !isdefined(self.disablepain) || !self.disablepain)
	{
		self unlink();
		self.enemy.syncedmeleetarget = undefined;
	}

	self animmode("zonly_physics");
	self clearanim(%body,0.2);
	if(self.prevscript == "dog_stop")
	{
		var_00 = "idle_pain";
	}
	else
	{
		var_00 = "run_pain";
	}

	self setflaggedanimrestart("dog_pain_anim",getdogpainanim(var_00),1,0.2,1);
	if(self isdogbeingdriven())
	{
		self playsound("bullet_large_flesh");
	}
	else
	{
		self playsound("bullet_large_flesh_npc");
	}

	soundscripts\_snd::snd_message("anml_doberman","pain");
	animscripts\shared::donotetracks("dog_pain_anim");
}

//Function Number: 2
getdogpainanim(param_00)
{
	var_01 = animscripts\utility::lookupdoganim("reaction",param_00);
	if(isarray(var_01))
	{
		return var_01[randomint(var_01.size)];
	}

	return var_01;
}

//Function Number: 3
initdogarchetype_reaction()
{
	var_00 = [];
	var_00["flash_long"] = [%iw6_dog_run_pain_4,%iw6_dog_run_pain_6];
	var_00["flash_short"] = %german_shepherd_run_flashbang_b;
	var_00["run_pain"] = [%iw6_dog_run_pain_4,%iw6_dog_run_pain_6];
	var_00["idle_pain"] = [%iw6_dog_alertidle_pain_4,%iw6_dog_alertidle_pain_6];
	level.archetypes["dog"]["reaction"] = var_00;
}