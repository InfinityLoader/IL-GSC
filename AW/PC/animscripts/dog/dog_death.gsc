/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_death.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 45 ms
 * Timestamp: 4/22/2024 1:58:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["death"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	if(isdefined(self.a.nodeath))
	{
		wait(1.1);
		var_00 = self getdroptofloorposition();
		if(isdefined(var_00))
		{
			var_01 = common_scripts\utility::spawn_tag_origin();
			var_01.origin = self.origin;
			var_01.angles = self.angles;
			self linkto(var_01);
			var_01 moveto(var_00,0.5);
			wait(0.5);
			self unlink();
			var_01 delete();
		}
		else
		{
			wait(0.5);
		}

		return;
	}

	self unlink();
	if(isdefined(self.enemy) && isdefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self)
	{
		self.enemy.syncedmeleetarget = undefined;
	}

	self clearanim(%body,0.2);
	var_02 = getdogdeathanim("front");
	if(isdefined(self.deathanim))
	{
		var_02 = self.deathanim;
	}

	if(isdefined(self.custom_deathsound))
	{
		self playsound(self.custom_deathsound);
	}
	else if(self isdogbeingdriven())
	{
		soundscripts\_snd::snd_message("anml_doberman","death");
	}
	else
	{
		soundscripts\_snd::snd_message("anml_doberman","death");
	}

	self setflaggedanimrestart("dog_anim",var_02,1,0.2,1);
	animscripts\shared::donotetracks("dog_anim");
}

//Function Number: 2
getdogdeathanim(param_00)
{
	var_01 = animscripts\utility::lookupdoganim("death",param_00);
	if(isarray(var_01))
	{
		return var_01[randomint(var_01.size)];
	}

	return var_01;
}

//Function Number: 3
initdogarchetype_death()
{
	var_00 = [];
	var_00["front"] = [%iw6_dog_death_4,%iw6_dog_death_6];
	level.archetypes["dog"]["death"] = var_00;
}