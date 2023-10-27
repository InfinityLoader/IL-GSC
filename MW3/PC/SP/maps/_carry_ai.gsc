/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_carry_ai.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 113 ms
 * Timestamp: 10/27/2023 2:20:04 AM
*******************************************************************/

//Function Number: 1
initcarry()
{
	anims();
}

//Function Number: 2
anims()
{
	level.scr_anim["generic"]["wounded_idle"][0] = %wounded_carry_closet_idle_wounded;
	level.scr_anim["generic"]["pickup_wounded"] = %wounded_carry_pickup_closet_wounded_straight;
	level.scr_anim["generic"]["pickup_carrier"] = %wounded_carry_pickup_closet_carrier_straight;
	level.scr_anim["generic"]["wounded_walk_loop"][0] = %wounded_carry_fastwalk_wounded_relative;
	level.scr_anim["generic"]["carrier_walk_loop"] = %wounded_carry_fastwalk_carrier;
	level.scr_anim["generic"]["putdown_wounded"] = %wounded_carry_putdown_closet_wounded;
	level.scr_anim["generic"]["putdown_carrier"] = %wounded_carry_putdown_closet_carrier;
}

//Function Number: 3
setwounded(param_00)
{
	animscripts/shared::func_23C8();
	self.woundednode = param_00;
	self.woundednode thread maps\_anim::anim_generic_loop(self,"wounded_idle","stop_wounded_idle");
	self.allowdeath = 1;
}

//Function Number: 4
end_carry_ai_logic(param_00,param_01)
{
	level notify("end_carry_ai_logic");
	setsaveddvar("ai_friendlyFireBlockDuration",2000);
	param_00.allowpain = 1;
	param_00.disablebulletwhizbyreaction = 0;
	param_00.ignoreall = 0;
	param_00.grenadeawareness = 1;
	param_00 maps\_utility::setflashbangimmunity(0);
	param_00.dontmelee = undefined;
	param_00.neverenablecqb = undefined;
	param_00.disablearrivals = undefined;
	param_00.disableexits = undefined;
	param_00.nododgemove = 0;
	param_00 pushplayer(0);
	param_01 notify("stop_carried_loop");
	param_01 unlink();
	param_00 maps\_utility::clear_generic_run_anim();
	param_01.woundednode notify("stop_wounded_idle");
	param_01.woundednode = undefined;
}

//Function Number: 5
move_president_to_node(param_00,param_01)
{
	level endon("end_carry_ai_logic");
	goto_and_pickup_wounded(param_00,param_01);
	carry_to_and_putdown_wounded(param_00,param_01);
}

//Function Number: 6
move_president_to_node_nopickup(param_00,param_01)
{
	param_00 forceteleport(self.origin,self.angles);
	carry_to_and_putdown_wounded(param_00,param_01);
}

//Function Number: 7
goto_and_pickup_wounded(param_00,param_01)
{
	level endon("end_carry_ai_logic");
	self endon("end_carry_ai");
	param_00.woundednode maps\_anim::anim_generic_reach(self,"pickup_carrier");
	param_00 notify("stop_wounded_idle");
	param_00.woundednode notify("stop_wounded_idle");
	param_00.allowdeath = 1;
	param_00.woundednode thread maps\_anim::anim_generic(param_00,"pickup_wounded");
	param_00.woundednode maps\_anim::anim_generic(self,"pickup_carrier");
	self.dontmelee = 1;
	param_00 invisiblenotsolid();
}

//Function Number: 8
link_wounded(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 linkto(self,"tag_origin");
	wait 0.05;
	param_00 thread maps\_anim::anim_generic_loop(param_00,"wounded_walk_loop","stop_carried_loop");
}

//Function Number: 9
carry_to_and_putdown_wounded(param_00,param_01)
{
	level endon("end_carry_ai_logic");
	self endon("end_carry_ai");
	param_00.being_carried = 1;
	thread maps\_utility::set_generic_run_anim("carrier_walk_loop",1);
	param_00 notify("stop_wounded_idle");
	param_00.woundednode notify("stop_wounded_idle");
	wait 0.05;
	setsaveddvar("ai_friendlyFireBlockDuration",0);
	self animmode("none");
	self.allowpain = 0;
	self.disablebulletwhizbyreaction = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
	self.grenadeawareness = 0;
	maps\_utility::setflashbangimmunity(1);
	self.neverenablecqb = 1;
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.nododgemove = 1;
	maps\_utility::disable_cqbwalk();
	self.oldgoal = self.goalradius;
	thread link_wounded(param_00);
	while(isdefined(param_01.target))
	{
		self.ignoresuppression = 1;
		self.disablearrivals = 1;
		var_02 = getent(param_01.target,"targetname");
		var_02 = common_scripts\utility::ter_op(isdefined(var_02),var_02,getnode(param_01.target,"targetname"));
		if(!isdefined(var_02.target))
		{
			param_01 = var_02;
			break;
		}

		self.goalradius = 64;
		self setgoalpos(var_02.origin);
		self waittill("goal");
		param_01 = var_02;
	}

	param_01 maps\_anim::anim_generic_reach(self,"putdown_carrier");
	param_00.woundednode = param_01;
	param_00 notify("stop_carried_loop");
	param_01 notify("stop_wounded_idle");
	param_00 unlink();
	self.ignoresuppression = 0;
	self.disablearrivals = 0;
	self.goalradius = self.oldgoal;
	thread maps\_utility::clear_run_anim();
	param_00.woundednode thread maps\_anim::anim_generic(self,"putdown_carrier");
	param_00.woundednode maps\_anim::anim_generic(param_00,"putdown_wounded");
	setsaveddvar("ai_friendlyFireBlockDuration",2000);
	self.allowpain = 1;
	self.disablebulletwhizbyreaction = 0;
	self.ignoreall = 0;
	self.grenadeawareness = 1;
	maps\_utility::setflashbangimmunity(0);
	self.dontmelee = undefined;
	self.neverenablecqb = undefined;
	self.disablearrivals = undefined;
	self.disableexits = undefined;
	self.nododgemove = 0;
	self pushplayer(0);
	param_00 visiblesolid();
	param_00.woundednode thread maps\_anim::anim_generic_loop(param_00,"wounded_idle","stop_wounded_idle");
	param_00.allowdeath = 1;
	param_00 notify("stop_putdown");
	param_00.being_carried = undefined;
}