/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_dog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 242 ms
 * Timestamp: 4/22/2024 2:15:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["zombie_dog"]["onAIConnect"] = level.agent_funcs["zombie"]["onAIConnect"];
	level.agent_funcs["zombie_dog"]["on_damaged"] = ::maps\mp\agents\_agents::on_agent_generic_damaged;
	level.agent_funcs["zombie_dog"]["on_damaged_finished"] = level.agent_funcs["zombie"]["on_damaged_finished"];
	level.agent_funcs["zombie_dog"]["on_killed"] = level.agent_funcs["zombie"]["on_killed"];
	level.agent_funcs["zombie_dog"]["spawn"] = ::spawn_zombie_dog;
	level.agent_funcs["zombie_dog"]["think"] = ::maps\mp\agents\dog\_zombie_dog_think::main;
	var_00[0] = ["zom_dog_150p"];
	level._effect["zombie_dog_eye_base"] = loadfx("vfx/gameplay/mp/zombie/zombie_dog_eye_base");
	level._effect["zombie_dog_eye_emp"] = loadfx("vfx/gameplay/mp/zombie/zombie_dog_eye_emp");
	level._effect["zombie_dog_eye_exploder"] = loadfx("vfx/gameplay/mp/zombie/zombie_dog_eye_exploder");
	var_01 = spawnstruct();
	var_01.agent_type = "zombie_dog";
	var_01.animclass = "zombie_dog_animclass";
	var_01.model_bodies = var_00;
	var_01.health_scale = 1;
	var_01.healthoverridefunc = ::calculatedoghealth;
	var_01.meleedamage = 45;
	var_01.spawnparameter = "zombie_dog";
	maps\mp\zombies\_util::agentclassregister(var_01,"zombie_dog");
	level.getspawntypefunc["zombie_dog"] = ::getdogroundspawntype;
	level.candroppickupsfunc["zombie_dog"] = ::dogroundcandroppickups;
	level.numenemiesthisroundfunc["zombie_dog"] = ::dogroundnumenemies;
	level.roundspawndelayfunc["zombie_dog"] = ::dogroundspawndelay;
	level.roundstartfunc["zombie_dog"] = ::dogroundstart;
	level.roundendfunc["zombie_dog"] = ::dogroundend;
	level.movemodefunc["zombie_dog"] = ::dogcaculatemovemode;
	level.moveratescalefunc["zombie_dog"] = ::dogcaculatemoveratescale;
	level.nonmoveratescalefunc["zombie_dog"] = ::dogcalculatenonmoveratescale;
	level.traverseratescalefunc["zombie_dog"] = ::dogcalculatetraverseratescale;
	level.zombiedogondamage = ::maps\mp\agents\dog\_zombie_dog_think::ondamage;
}

//Function Number: 2
dogroundstart()
{
}

//Function Number: 3
dogroundend()
{
	maps\mp\gametypes\zombies::createpickuporgive("ammo",level.lastenemydeathpos,"Dog Round End");
}

//Function Number: 4
getdogroundspawntype(param_00,param_01)
{
	return "zombie_dog";
}

//Function Number: 5
dogroundcandroppickups(param_00)
{
	return 0;
}

//Function Number: 6
dogcaculatemovemode()
{
	return "run";
}

//Function Number: 7
dogcaculatemoveratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 8
dogcalculatenonmoveratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 9
dogcalculatetraverseratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 10
dogroundnumenemies(param_00)
{
	var_01 = maps\mp\zombies\_util::getnumplayers();
	var_02 = var_01 * 6;
	if(level.specialroundcounter > 3)
	{
		var_02 = var_01 * 8;
	}

	return var_02;
}

//Function Number: 11
dogroundspawndelay(param_00,param_01)
{
	var_02 = 1.5;
	switch(level.specialroundcounter)
	{
		case 1:
		case 0:
			var_02 = 3;
			break;

		case 2:
			var_02 = 2.5;
			break;

		case 3:
			var_02 = 2;
			break;

		default:
			var_02 = 1.5;
			break;
	}

	var_02 = var_02 - param_00 / param_01;
	return var_02;
}

//Function Number: 12
calculatedoghealth()
{
	var_00 = 400;
	switch(level.specialroundcounter)
	{
		case 1:
		case 0:
			var_00 = 400;
			break;

		case 2:
			var_00 = 900;
			break;

		case 3:
			var_00 = 1300;
			break;

		default:
			var_00 = 1600;
			break;
	}

	return var_00;
}

//Function Number: 13
spawn_zombie_dog(param_00,param_01,param_02)
{
	self setmodel("tag_origin");
	self.species = "dog";
	self.onenteranimstate = ::maps\mp\agents\_scripted_agent_anim_util::onenteranimstate;
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_03 = param_00;
		var_04 = param_01;
	}
	else
	{
		var_05 = self [[ level.getspawnpoint ]]();
		var_03 = var_05.origin;
		var_04 = var_05.angles;
	}

	maps\mp\agents\_agent_utility::activateagent();
	self.spawntime = gettime();
	self.lastspawntime = gettime();
	maps\mp\agents\dog\_zombie_dog_think::init();
	self spawnagent(var_03,var_04,self.animclass,self.radius,self.height,param_02);
	level notify("spawned_agent",self);
	maps\mp\agents\_agent_common::set_agent_health(100);
	if(isdefined(param_02))
	{
		maps\mp\agents\_agent_utility::set_agent_team(param_02.team,param_02);
	}

	self setthreatbiasgroup("Dogs");
	self takeallweapons();
	self scragentsetnopenetrate(1);
	self scragentsetpathteamspread(1);
	self scragentsetallowragdoll(1);
	self scragentsetobstacleavoid(0);
	self scragentsetorienttoground(0);
	self thread [[ maps\mp\agents\_agent_utility::agentfunc("think") ]]();
}