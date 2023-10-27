/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_gas_airstrike.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 184 ms
 * Timestamp: 10/27/2023 1:20:47 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precachelocationselector("map_artillery_selector");
	var_00 = spawnstruct();
	var_00.modelnames = [];
	var_00.modelnames["allies"] = "vehicle_mig29_desert";
	var_00.modelnames["axis"] = "vehicle_mig29_desert";
	var_00.inboundsfx = "veh_mig29_dist_loop";
	var_00.compassiconfriendly = "compass_objpoint_airstrike_friendly";
	var_00.compassiconenemy = "compass_objpoint_airstrike_busy";
	var_00.speed = 5000;
	var_00.halfdistance = 15000;
	var_00.heightrange = 500;
	var_00.outboundflightanim = "airstrike_mp_roll";
	var_00.onattackdelegate = ::dropbombs;
	var_00.onflybycompletedelegate = ::cleanupflyby;
	var_00.choosedirection = 1;
	var_00.selectlocationvo = "KS_hqr_airstrike";
	var_00.inboundvo = "KS_ast_inbound";
	var_00.bombmodel = "projectile_cbu97_clusterbomb";
	var_00.numbombs = 3;
	var_00.distancebetweenbombs = 350;
	var_00.effectradius = 200;
	var_00.effectheight = 120;
	var_00.effectvfx = loadfx("fx/smoke/poisonous_gas_linger_medium_thick_killer_instant");
	var_00.effectmindelay = 0.25;
	var_00.effectmaxdelay = 0.5;
	var_00.effectlifespan = 13;
	var_00.effectcheckfrequency = 1;
	var_00.effectdamage = 10;
	var_00.obitweapon = "gas_strike_mp";
	var_00.killcamoffset = (0,0,60);
	level.planeconfigs["gas_airstrike"] = var_00;
	level.killstreakfuncs["gas_airstrike"] = ::onuse;
}

//Function Number: 2
onuse(param_00,param_01)
{
	var_02 = maps\mp\_utility::getotherteam(self.team);
	if(isdefined(level.numgasstrikeactive))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	var_03 = maps\mp\killstreaks\_plane::func_6D6F(param_00,"gas_airstrike",::dostrike);
	return isdefined(var_03) && var_03;
}

//Function Number: 3
dostrike(param_00,param_01,param_02,param_03)
{
	level.numgasstrikeactive = 0;
	wait(1);
	var_04 = maps\mp\killstreaks\_plane::func_3B92();
	var_05 = anglestoforward((0,param_02,0));
	dooneflyby(param_03,param_00,param_01,var_05,var_04);
	self waittill("gas_airstrike_flyby_complete");
}

//Function Number: 4
dooneflyby(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.planeconfigs[param_00];
	var_06 = maps\mp\killstreaks\_plane::func_3AAE(param_02,param_03,var_05.halfdistance,1,param_04,var_05.speed,0,param_00);
	level thread maps\mp\killstreaks\_plane::func_2896(param_01,self,param_01,var_06["startPoint"] + (0,0,randomint(var_05.heightrange)),var_06["endPoint"] + (0,0,randomint(var_05.heightrange)),var_06["attackTime"],var_06["flyTime"],param_03,param_00);
}

//Function Number: 5
cleanupflyby(param_00,param_01,param_02)
{
	param_00 notify("gas_airstrike_flyby_complete");
}

//Function Number: 6
dropbombs(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	wait(param_02);
	var_05 = level.planeconfigs[param_04];
	var_06 = var_05.numbombs;
	var_07 = var_05.distancebetweenbombs / var_05.speed;
	while(var_06 > 0)
	{
		thread droponebomb(param_03,param_04);
		var_06--;
		wait(var_07);
	}
}

//Function Number: 7
droponebomb(param_00,param_01)
{
	level.numgasstrikeactive++;
	var_02 = self;
	var_03 = level.planeconfigs[param_01];
	var_04 = anglestoforward(var_02.angles);
	var_05 = func_7863(var_03.bombmodel,var_02.origin,var_02.angles);
	var_05 movegravity(var_04 * var_03.speed / 1.5,3);
	var_06 = spawn("script_model",var_05.origin);
	var_06 setmodel("tag_origin");
	var_06.origin = var_05.origin;
	var_06.angles = var_05.angles;
	var_05 setmodel("tag_origin");
	wait(0.1);
	var_07 = var_06.origin;
	var_08 = var_06.angles;
	if(level.splitscreen)
	{
		playfxontag(level.airstrikessfx,var_06,"tag_origin");
	}
	else
	{
		playfxontag(level.airstrikefx,var_06,"tag_origin");
	}

	wait(1);
	var_09 = bullettrace(var_06.origin,var_06.origin + (0,0,-1000000),0,undefined);
	var_0A = var_09["position"];
	var_05 func_58FC(param_00,var_0A,param_01);
	var_06 delete();
	var_05 delete();
	level.numgasstrikeactive--;
	if(level.numgasstrikeactive == 0)
	{
		level.numgasstrikeactive = undefined;
	}
}

//Function Number: 8
func_7863(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_01);
	var_03.angles = param_02;
	var_03 setmodel(param_00);
	return var_03;
}

//Function Number: 9
func_58FC(param_00,param_01,param_02)
{
	var_03 = level.planeconfigs[param_02];
	var_04 = spawn("trigger_radius",param_01,0,var_03.effectradius,var_03.effectheight);
	var_04.owner = param_00;
	var_05 = var_03.effectradius;
	var_06 = spawnfx(var_03.effectvfx,param_01);
	triggerfx(var_06);
	wait(randomfloatrange(var_03.effectmindelay,var_03.effectmaxdelay));
	var_07 = var_03.effectlifespan;
	var_08 = spawn("script_model",param_01 + var_03.killcamoffset);
	var_08 linkto(var_04);
	self.killcament = var_08;
	while(var_07 > 0)
	{
		foreach(var_0A in level.characters)
		{
			var_0A applygaseffect(param_00,param_01,var_04,self,var_03.effectdamage);
		}

		wait(var_03.effectcheckfrequency);
		var_07 = var_07 - var_03.effectcheckfrequency;
	}

	self.killcament delete();
	var_04 delete();
	var_06 delete();
}

//Function Number: 10
applygaseffect(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 maps\mp\_utility::isenemy(self) && isalive(self) && self istouching(param_02))
	{
		param_03 radiusdamage(self.origin,1,param_04,param_04,param_00,"MOD_RIFLE_BULLET","gas_strike_mp");
		if(!maps\mp\_utility::func_4995())
		{
			var_05 = maps\mp\perks\_perkfunctions::applystunresistence(2);
			self shellshock("default",var_05);
		}
	}
}