/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_prone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 275 ms
 * Timestamp: 10/27/2023 1:54:50 AM
*******************************************************************/

//Function Number: 1
init_animset_cover_prone()
{
	var_00 = [];
	var_00["straight_level"] = %prone_aim_5;
	var_00["legs_up"] = %prone_aim_feet_45up;
	var_00["legs_down"] = %prone_aim_feet_45down;
	var_00["fire"] = %prone_fire_1;
	var_00["semi2"] = %prone_fire_burst;
	var_00["semi3"] = %prone_fire_burst;
	var_00["semi4"] = %prone_fire_burst;
	var_00["semi5"] = %prone_fire_burst;
	var_00["single"] = [%prone_fire_1];
	var_00["burst2"] = %prone_fire_burst;
	var_00["burst3"] = %prone_fire_burst;
	var_00["burst4"] = %prone_fire_burst;
	var_00["burst5"] = %prone_fire_burst;
	var_00["burst6"] = %prone_fire_burst;
	var_00["reload"] = %prone_reload;
	var_00["look"] = [%prone_twitch_look,%prone_twitch_lookfast,%prone_twitch_lookup];
	var_00["grenade_safe"] = [%prone_grenade_a,%prone_grenade_a];
	var_00["grenade_exposed"] = [%prone_grenade_a,%prone_grenade_a];
	var_00["exposed_idle"] = [%prone_idle];
	var_00["twitch"] = [%prone_twitch_ammocheck,%prone_twitch_look,%prone_twitch_scan,%prone_twitch_lookfast,%prone_twitch_lookup];
	var_00["hide_to_look"] = %coverstand_look_moveup;
	var_00["look_idle"] = %coverstand_look_idle;
	var_00["look_to_hide"] = %coverstand_look_movedown;
	var_00["look_to_hide_fast"] = %coverstand_look_movedown_fast;
	var_00["stand_2_prone"] = %stand_2_prone_nodelta;
	var_00["crouch_2_prone"] = %crouch_2_prone;
	var_00["prone_2_stand"] = %prone_2_stand_nodelta;
	var_00["prone_2_crouch"] = %prone_2_crouch;
	var_00["stand_2_prone_firing"] = %stand_2_prone_firing;
	var_00["crouch_2_prone_firing"] = %crouch_2_prone_firing;
	var_00["prone_2_stand_firing"] = %prone_2_stand_firing;
	var_00["prone_2_crouch_firing"] = %prone_2_crouch_firing;
	level.archetypes["soldier"]["cover_prone"] = var_00;
}

//Function Number: 2
main()
{
	self endon("killanimscript");
	animscripts\utility::initialize("cover_prone");
	if(weaponclass(self.weapon) == "rocketlauncher")
	{
		animscripts\combat::main();
		return;
	}

	if(isdefined(self.a.arrivaltype) && self.a.arrivaltype == "prone_saw")
	{
		animscripts\cover_wall::useselfplacedturret("saw_bipod_prone","weapon_saw_MG_Setup");
	}
	else if(isdefined(self.node.turret))
	{
		animscripts\cover_wall::usestationaryturret();
	}

	if(isdefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < squared(512))
	{
		thread animscripts\combat::main();
		return;
	}

	setup_cover_prone();
	self.covernode = self.node;
	self orientmode("face angle",self.covernode.angles[1]);
	self.a.goingtoproneaim = 1;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
	if(self.a.pose != "prone")
	{
		prone_transitionto("prone");
	}
	else
	{
		animscripts\utility::enterpronewrapper(0);
	}

	thread animscripts\combat_utility::aimidlethread();
	setupproneaim(0.2);
	self setanim(%prone_aim_5,1,0.1);
	self orientmode("face angle",self.covernode.angles[1]);
	self animmode("zonly_physics");
	pronecombatmainloop();
	self notify("stop_deciding_how_to_shoot");
}

//Function Number: 3
end_script()
{
	self.a.goingtoproneaim = undefined;
}

//Function Number: 4
idlethread()
{
	self endon("killanimscript");
	self endon("kill_idle_thread");
	for(;;)
	{
		var_00 = animscripts\utility::animarraypickrandom("prone_idle");
		self setflaggedanimlimited("idle",var_00);
		self waittillmatch("end","idle");
		self clearanim(var_00,0.2);
	}
}

//Function Number: 5
updatepronewrapper(param_00)
{
	self updateprone(animscripts\utility::lookupanim("cover_prone","legs_up"),animscripts\utility::lookupanim("cover_prone","legs_down"),1,param_00,1);
	self setanim(%exposed_aiming,1,0.2);
}

//Function Number: 6
pronecombatmainloop()
{
	self endon("killanimscript");
	thread animscripts\track::trackshootentorpos();
	thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
	var_00 = gettime() > 2500;
	for(;;)
	{
		animscripts\utility::updateisincombattimer();
		updatepronewrapper(0.05);
		if(!var_00)
		{
			wait(0.05 + randomfloat(1.5));
			var_00 = 1;
			continue;
		}

		if(!isdefined(self.shootpos))
		{
			if(considerthrowgrenade())
			{
				continue;
			}

			wait(0.05);
			continue;
		}

		var_01 = lengthsquared(self.origin - self.shootpos);
		if(self.a.pose != "crouch" && self isstanceallowed("crouch") && var_01 < squared(400))
		{
			if(var_01 < squared(285))
			{
				prone_transitionto("crouch");
				thread animscripts\combat::main();
				return;
			}
		}

		if(considerthrowgrenade())
		{
			continue;
		}

		if(pronereload(0))
		{
			continue;
		}

		if(animscripts\combat_utility::aimedatshootentorpos())
		{
			animscripts\combat_utility::shootuntilshootbehaviorchange();
			self clearanim(%add_fire,0.2);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 7
pronereload(param_00)
{
	return animscripts\combat_utility::reload(param_00,animscripts\utility::animarray("reload"));
}

//Function Number: 8
setup_cover_prone()
{
	self setdefaultaimlimits(self.node);
	self.a.array = animscripts\utility::lookupanimarray("cover_prone");
}

//Function Number: 9
trythrowinggrenade(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_01) && param_01)
	{
		var_02 = animscripts\utility::animarraypickrandom("grenade_safe");
	}
	else
	{
		var_02 = animscripts\utility::animarraypickrandom("grenade_exposed");
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_03 = (32,20,64);
	var_04 = animscripts\combat_utility::trygrenade(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_04;
}

//Function Number: 10
considerthrowgrenade()
{
	if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
	{
		if(trythrowinggrenade(level.player,200))
		{
			return 1;
		}
	}

	if(isdefined(self.enemy))
	{
		return trythrowinggrenade(self.enemy,850);
	}

	return 0;
}

//Function Number: 11
shouldfirewhilechangingpose()
{
	if(!isdefined(self.weapon) || !weaponisauto(self.weapon))
	{
		return 0;
	}

	if(isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 256)
	{
		return 0;
	}

	if(isdefined(self.enemy) && self cansee(self.enemy) && !isdefined(self.grenade) && animscripts\shared::getaimyawtoshootentorpos() < 20)
	{
		return animscripts\move::mayshootwhilemoving();
	}

	return 0;
}

//Function Number: 12
prone_transitionto(param_00)
{
	if(param_00 == self.a.pose)
	{
		return;
	}

	self clearanim(%animscript_root,0.3);
	animscripts\combat_utility::endfireandanimidlethread();
	if(shouldfirewhilechangingpose())
	{
		var_01 = animscripts\utility::animarray(self.a.pose + "_2_" + param_00 + "_firing");
	}
	else
	{
		var_01 = animscripts\utility::animarray(self.a.pose + "_2_" + var_01);
	}

	if(param_00 == "prone")
	{
	}

	self setflaggedanimknoballrestart("trans",var_01,%body,1,0.2,1);
	animscripts\shared::donotetracks("trans");
	self setanimknoballrestart(animscripts\utility::animarray("straight_level"),%body,1,0.25);
	setupproneaim(0.25);
}

//Function Number: 13
finishnotetracks(param_00)
{
	self endon("killanimscript");
	animscripts\shared::donotetracks(param_00);
}

//Function Number: 14
setupproneaim(param_00)
{
	self setanimknoball(%prone_aim_5,%body,1,param_00);
	self setanimlimited(%prone_aim_2_add,1,param_00);
	self setanimlimited(%prone_aim_4_add,1,param_00);
	self setanimlimited(%prone_aim_6_add,1,param_00);
	self setanimlimited(%prone_aim_8_add,1,param_00);
}

//Function Number: 15
proneto(param_00,param_01)
{
	self clearanim(%animscript_root,0.3);
	var_02 = undefined;
	if(shouldfirewhilechangingpose())
	{
		if(param_00 == "crouch")
		{
			var_02 = %prone_2_crouch_firing;
		}
		else if(param_00 == "stand")
		{
			var_02 = %prone_2_stand_firing;
		}
	}
	else if(param_00 == "crouch")
	{
		var_02 = %prone_2_crouch;
	}
	else if(param_00 == "stand")
	{
		var_02 = %prone_2_stand_nodelta;
	}

	if(isdefined(self.prone_anim_override))
	{
		var_02 = self.prone_anim_override;
	}

	if(isdefined(self.prone_rate_override))
	{
		param_01 = self.prone_rate_override;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	animscripts\utility::exitpronewrapper(getanimlength(var_02) / 2);
	self setflaggedanimknoballrestart("trans",var_02,%body,1,0.2,param_01);
	animscripts\shared::donotetracks("trans");
	self clearanim(var_02,0.1);
}