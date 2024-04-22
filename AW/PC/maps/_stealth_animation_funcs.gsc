/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_animation_funcs.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 184 ms
 * Timestamp: 4/22/2024 2:22:59 AM
*******************************************************************/

//Function Number: 1
clear_animation(param_00)
{
	self clearanim(%root,param_00);
}

//Function Number: 2
enemy_animation_attack(param_00)
{
	var_01 = 600;
	if(isdefined(self.mech) && self.mech)
	{
		return;
	}

	if(isdefined(self.enemy))
	{
		var_01 = distance(self.enemy.origin,self.origin);
	}

	if(var_01 < 512)
	{
		var_02 = "_stealth_behavior_spotted_short";
	}
	else
	{
		var_02 = "_stealth_behavior_spotted_long";
	}

	self.allowdeath = 1;
	thread maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_02);
	if(var_01 < 200)
	{
		wait(0.5);
	}
	else
	{
		common_scripts\utility::waittill_notify_or_timeout(var_02,randomfloatrange(1.5,3));
	}

	self notify("stop_animmode");
}

//Function Number: 3
enemy_animation_nothing(param_00)
{
}

//Function Number: 4
enemy_animation_generic(param_00)
{
	self.allowdeath = 1;
	var_01 = level.player;
	if(isdefined(self.enemy))
	{
		var_01 = self.enemy;
	}
	else if(isdefined(self.favoriteenemy))
	{
		var_01 = self.favoriteenemy;
	}

	var_02 = distance(self.origin,var_01.origin);
	var_03 = 4;
	var_04 = 1024;
	for(var_05 = 1;var_05 < var_03;var_05++)
	{
		var_06 = var_04 * var_05 / var_03;
		if(var_02 < var_06)
		{
			break;
		}
	}

	var_07 = "_stealth_behavior_generic" + var_05;
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_07);
}

//Function Number: 5
dog_animation_generic(param_00)
{
	self.allowdeath = 1;
	var_01 = undefined;
	if(isdefined(self.meleeingplayer))
	{
		var_02 = self.meleeingplayer;
		if(isdefined(var_02.player_view) && isdefined(var_02.player_view.dog) && self == var_02.player_view.dog)
		{
			return;
		}
	}

	if(maps\_utility::ent_flag("_stealth_behavior_asleep"))
	{
		if(randomint(100) < 50)
		{
			var_01 = "_stealth_dog_wakeup_fast";
		}
		else
		{
			var_01 = "_stealth_dog_wakeup_slow";
		}
	}
	else
	{
		var_01 = "_stealth_dog_growl";
	}

	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 6
dog_animation_wakeup_fast(param_00)
{
	self.allowdeath = 1;
	var_01 = undefined;
	if(maps\_utility::ent_flag("_stealth_behavior_asleep"))
	{
		var_01 = "_stealth_dog_wakeup_fast";
	}
	else
	{
		var_01 = "_stealth_dog_growl";
	}

	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 7
dog_animation_wakeup_slow(param_00)
{
	self.allowdeath = 1;
	var_01 = undefined;
	if(maps\_utility::ent_flag("_stealth_behavior_asleep"))
	{
		var_01 = "_stealth_dog_wakeup_slow";
	}
	else
	{
		var_01 = "_stealth_dog_growl";
	}

	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 8
enemy_animation_sawcorpse(param_00)
{
	self.allowdeath = 1;
	var_01 = "_stealth_behavior_saw_corpse";
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 9
dog_animation_sawcorpse(param_00)
{
	self.allowdeath = 1;
	var_01 = "_stealth_dog_saw_corpse";
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 10
dog_animation_howl(param_00)
{
	self.allowdeath = 1;
	var_01 = "_stealth_dog_howl";
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 11
enemy_animation_foundcorpse(param_00)
{
	self endon("enemy");
	if(isdefined(self.enemy))
	{
		return;
	}

	self.allowdeath = 1;
	if(self.a.movement == "stop")
	{
		var_01 = "_stealth_find_stand";
	}
	else
	{
		var_01 = "_stealth_find_jog";
	}

	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}

//Function Number: 12
dog_animation_foundcorpse(param_00)
{
	self endon("enemy");
	if(isdefined(self.enemy))
	{
		return;
	}

	self.allowdeath = 1;
	var_01 = "_stealth_dog_find";
	maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
}