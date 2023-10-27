/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian\civilian_init.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 160 ms
 * Timestamp: 10/27/2023 2:42:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	animscripts\init::main();
	civilian_init();
}

//Function Number: 2
civilian_init()
{
	self.allowdeath = 1;
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.neverenablecqb = 1;
	self.alwaysrunforward = 1;
	self orientmode("face default");
	self.combatmode = "no_cover";
	self pushplayer(0);
	self.a.reacttobulletchance = 1;
	if(!isdefined(level.initialized_civilian_animations))
	{
		level.initialized_civilian_animations = 1;
		level.scr_anim["default_civilian"]["run_combat"][0] = %civilian_run_upright;
		level.scr_anim["default_civilian"]["run_hunched_combat"][0] = %civilian_run_hunched_a;
		level.scr_anim["default_civilian"]["run_hunched_combat"][1] = %civilian_run_hunched_c;
		level.scr_anim["default_civilian"]["run_hunched_combat"][2] = %civilian_run_hunched_flinch;
		level.scr_anim["default_civilian"]["run_noncombat"][0] = %civilian_walk_cool;
		var_00 = [];
		var_00[0] = 3;
		var_00[1] = 3;
		var_00[2] = 1;
		level.scr_anim["default_civilian"]["run_hunched_weights"] = common_scripts\utility::get_cumulative_weights(var_00);
		var_00 = [];
		var_00[0] = 1;
		level.scr_anim["default_civilian"]["run_weights"] = common_scripts\utility::get_cumulative_weights(var_00);
		level.scr_anim["default_civilian"]["idle_noncombat"][0] = %unarmed_cowerstand_idle;
		level.scr_anim["default_civilian"]["idle_combat"][0] = %casual_crouch_v2_idle;
		level.scr_anim["default_civilian"]["idle_combat"][1] = %unarmed_cowercrouch_idle_duck;
		level.civilianflashedarray[0] = %unarmed_cowerstand_react;
		level.civilianflashedarray[1] = %unarmed_cowercrouch_react_a;
		level.civilianflashedarray[2] = %unarmed_cowercrouch_react_b;
	}

	var_01 = undefined;
	if(isdefined(self.civilian_walk_animation))
	{
		self.animname = self.civilian_walk_animation;
		attachprops(self.civilian_walk_animation);
		self.alertlevel = "noncombat";
		startnoncombat();
	}
	else
	{
		self.animname = "default_civilian";
		self.alertlevel = "alert";
		startcombat();
	}

	thread checkcombatstate();
	self.dropweapon = 0;
	animscripts\shared::dropaiweapon();
	self.saved = 0;
}

//Function Number: 3
attachprops(param_00)
{
	if(isdefined(self.hasattachedprops))
	{
		return;
	}

	initcivilianprops();
	var_01 = level.civilianprops[param_00];
	if(isdefined(var_01))
	{
		self.attachedpropmodel = var_01;
		self.attachedproptag = "tag_inhand";
		self attach(self.attachedpropmodel,self.attachedproptag,1);
		self.hasattachedprops = 1;
	}
}

//Function Number: 4
detachprops()
{
	if(isdefined(self.hasattachedprops))
	{
		self detach(self.attachedpropmodel,self.attachedproptag);
		var_00 = spawn("script_model",self gettagorigin(self.attachedproptag));
		var_00.angles = self gettagangles(self.attachedproptag);
		var_00 setmodel(self.attachedpropmodel);
		var_00 physicslaunchclient();
		var_00 thread waitforcleanup();
		self.hasattachedprops = undefined;
		self.attachedpropmodel = undefined;
		self.attachedproptag = undefined;
	}
}

//Function Number: 5
waitforcleanup()
{
	wait(10);
	self delete();
}

//Function Number: 6
initcivilianprops()
{
	if(isdefined(level.civilianprops))
	{
		return;
	}

	anim.civilianprops = [];
	level.civilianprops["civilian_briefcase_walk"] = "com_metal_briefcase";
	level.civilianprops["civilian_crazy_walk"] = "electronics_pda";
	level.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
	level.civilianprops["sit_lunch_A"] = "com_cellphone_on";
	level.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
	level.civilianprops["civilian_paper_walk"] = "paper_memo";
	level.civilianprops["civilian_coffee_walk"] = "cs_coffeemug02";
	level.civilianprops["civilian_pda_walk"] = "electronics_pda";
	level.civilianprops["reading1"] = "open_book";
	level.civilianprops["reading2"] = "open_book";
	level.civilianprops["texting_stand"] = "electronics_pda";
	level.civilianprops["texting_sit"] = "electronics_pda";
	level.civilianprops["smoking1"] = "prop_cigarette";
	level.civilianprops["smoking2"] = "prop_cigarette";
}

//Function Number: 7
startnoncombat()
{
	self.turnrate = 0.2;
	if(isdefined(self.civilian_walk_animation))
	{
		var_00 = %civilian_briefcase_walk_dodge_l;
		var_01 = %civilian_briefcase_walk_dodge_r;
		if(isdefined(level.scr_anim[self.animname]["dodge_left"]))
		{
			var_00 = level.scr_anim[self.animname]["dodge_left"];
		}

		if(isdefined(level.scr_anim[self.animname]["dodge_right"]))
		{
			var_01 = level.scr_anim[self.animname]["dodge_right"];
		}

		animscripts\move::setdodgeanims(var_00,var_01);
	}

	if(isdefined(level.scr_anim[self.animname]["turn_left_90"]))
	{
		self.pathturnanimoverridefunc = ::animscripts\civilian\civilian_move::civilian_noncombatmoveturn;
		self.pathturnanimblendtime = 0.1;
		maps\_utility::enable_turnanims();
	}
	else
	{
		maps\_utility::disable_turnanims();
	}

	self.run_overrideanim = level.scr_anim[self.animname]["run_noncombat"];
	self.walk_overrideanim = self.run_overrideanim;
	self.run_overridebulletreact = undefined;
	if(self.animname == "default_civilian")
	{
		self.run_override_weights = level.scr_anim[self.animname]["run_weights_noncombat"];
		self.walk_override_weights = self.run_override_weights;
	}
}

//Function Number: 8
startcombat()
{
	self notify("combat");
	animscripts\move::cleardodgeanims();
	self.pathturnanimblendtime = undefined;
	maps\_utility::enable_turnanims();
	self.turnrate = 0.3;
	var_00 = randomint(3) < 1;
	if(isdefined(self.force_civilian_stand_run))
	{
		var_00 = 1;
	}
	else if(isdefined(self.force_civilian_hunched_run))
	{
		var_00 = 0;
	}

	if(var_00)
	{
		self.pathturnanimoverridefunc = ::animscripts\civilian\civilian_move::civilian_combatmoveturn;
		self.run_overrideanim = level.scr_anim["default_civilian"]["run_combat"];
		self.run_override_weights = level.scr_anim["default_civilian"]["run_weights"];
	}
	else
	{
		self.pathturnanimoverridefunc = ::animscripts\civilian\civilian_move::civilian_combathunchedmoveturn;
		self.run_overrideanim = level.scr_anim["default_civilian"]["run_hunched_combat"];
		self.run_override_weights = level.scr_anim["default_civilian"]["run_hunched_weights"];
	}

	self.run_overridebulletreact = [];
	self.run_overridebulletreact[0] = %run_react_stumble;
	self.walk_overrideanim = self.run_overrideanim;
	self.walk_override_weights = self.run_override_weights;
}

//Function Number: 9
checkcombatstate()
{
	self endon("death");
	self endon("disable_combat_state_check");
	var_00 = self.alertlevelint > 1;
	for(;;)
	{
		var_01 = self.alertlevelint > 1;
		if(var_00 && !var_01)
		{
			startnoncombat();
		}
		else if(!var_00 && var_01)
		{
			startcombat();
		}

		var_00 = var_01;
		wait(0.05);
	}
}