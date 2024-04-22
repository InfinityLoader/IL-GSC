/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_mutators_armor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 83 ms
 * Timestamp: 4/22/2024 2:13:45 AM
*******************************************************************/

//Function Number: 1
initarmormutator()
{
	level.valideyetypes[level.valideyetypes.size] = "armored";
	level._effect["mut_helmet_impact"] = loadfx("vfx/explosion/impact_sparks_01");
	maps\mp\gametypes\zombies::loadeyeeffectsfortype("armored",1);
	maps\mp\zombies\_mutators::addmutatortotable("armor",::mutatorarmor,"zmb_mut_armor_spawn",undefined,::onhelmetzombiedamaged);
	maps\mp\zombies\_mutators::disablemutatorfortypes("armor",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
}

//Function Number: 2
mutatorarmor()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("armor");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "no_boost_fx";
	var_00 = "J_helmet";
	self.hasarmor = 1;
	self.hashelmet = 1;
	self detachall();
	self.limbmodels = undefined;
	self.helmet_health = 50;
	self setmodel("zom_mut_armor_body");
	var_01 = ["zombies_head_mutator_fire","zombies_head_mutator_fire_cau_a","zombies_head_mutator_fire_cau_b","zombies_head_mutator_fire_cau_c"];
	var_02 = randomint(var_01.size);
	self attach(var_01[var_02]);
	self.headmodel = var_01[var_02];
	var_03 = maps\mp\gametypes\zombies::geteyeeffectforzombie("armored",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_03);
	if(!isdefined(self.moverateroundmod))
	{
		self.moverateroundmod = 0;
	}

	self.moverateroundmod = self.moverateroundmod + 0.85;
	var_04 = self gettagorigin(var_00);
	var_05 = self gettagangles(var_00);
	var_06 = spawn("script_model",var_04);
	var_06.angles = var_05;
	var_06 setmodel("zombie_helmet");
	var_06 linkto(self,var_00,(-0.2,-0.45,-4.7),(0,90,0));
	thread mutatorhelmetdetach(var_06);
	self waittill("death");
	self.hashelmet = undefined;
	thread mutatorhelmetcleanup(var_06);
}

//Function Number: 3
onhelmetzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.hashelmet) && isplayer(param_01) && maps\mp\_utility::isheadshot(param_05,param_08,param_04))
	{
		self.helmet_health = self.helmet_health - param_02;
		if(self.helmet_health <= 0)
		{
			self notify("helmet_lost");
		}
	}
}

//Function Number: 4
mutatorhelmetdetach(param_00)
{
	self endon("death");
	self waittill("helmet_lost");
	self.hashelmet = undefined;
	earthquake(0.25,0.4,self.origin,128);
	self.moverateroundmod = self.moverateroundmod + 5;
	playfx(common_scripts\utility::getfx("mut_helmet_impact"),param_00.origin);
	param_00 playsound("zmb_mut_armor_helmet_ping");
	param_00 unlink();
	param_00 setmodel("zombie_helmet_collision");
	param_00 physicslaunchclient(param_00.origin,(randomintrange(-5,5),randomintrange(-5,5),randomintrange(-5,5)));
	physicsexplosionsphere(param_00.origin - (0,0,2),16,1,5);
	thread mutatorhelmetcleanup(param_00);
}

//Function Number: 5
mutatorhelmetcleanup(param_00)
{
	wait(5);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}