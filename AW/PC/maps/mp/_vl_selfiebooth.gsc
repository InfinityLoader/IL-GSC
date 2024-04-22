/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_vl_selfiebooth.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 82 ms
 * Timestamp: 4/22/2024 2:16:54 AM
*******************************************************************/

//Function Number: 1
init_selfiebooth()
{
	var_00 = getent("selfie_player_pos","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getent(var_00.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	level.selfiebooth = spawnstruct();
	level.selfiebooth.player_pos = var_00;
	level.selfiebooth.camera_pos = var_02;
	setdvarifuninitialized("scr_vlobby_selfie_correction_y",32);
	setdvarifuninitialized("scr_vlobby_selfie_collision_z",10);
	level thread run_selfiebooth();
}

//Function Number: 2
run_selfiebooth()
{
	while(!isdefined(level.player))
	{
		wait 0.05;
	}

	level.player spawnselfieavatar();
	wait(5);
	for(;;)
	{
		wait 0.05;
		if(issystemlink() || !isonlinegame() || getdvarint("practiceroundgame"))
		{
			continue;
		}

		if(!should_take_selfie())
		{
			continue;
		}

		take_selfie();
	}
}

//Function Number: 3
spawnselfieavatar()
{
	while(!isdefined(level.player.spawned_avatar) || !isdefined(level.player.spawned_avatar.costume))
	{
		wait 0.05;
	}

	var_00 = level.selfiebooth.player_pos.origin;
	var_01 = getdvarfloat("scr_vlobby_selfie_collision_z",0);
	var_02 = getdvarfloat("scr_vlobby_selfie_correction_y",0);
	var_03 = (0,var_02,var_01);
	var_00 = var_00 + var_03;
	var_04 = level.selfiebooth.player_pos.angles;
	var_05 = maps\mp\agents\_agent_utility::getfreeagent("selfie_clone");
	var_05.isactive = 1;
	var_05 spawnagent(var_00,var_04,undefined,undefined,undefined,undefined,1);
	var_06 = level.player getxuid();
	setentplayerxuidforemblem(var_05,var_06);
	var_05 enableanimstate(1);
	var_05 setanimclass("vlobby_animclass");
	var_05 setanimstate("lobby_idle","selfie_01",1);
	var_05 setcostumemodels(level.player.spawned_avatar.costume);
	var_05 linkto(level.selfiebooth.player_pos);
	level.selfiebooth.clone = var_05;
	self.selfie_clone = var_05;
}

//Function Number: 4
should_take_selfie()
{
	if(!isdefined(level.player))
	{
		return 0;
	}

	if(!isdefined(level.player.spawned_avatar) || !isdefined(level.player.spawned_avatar.costume))
	{
		return 0;
	}

	if(!level.player selfieaccessselfiecustomassetsarestreamed())
	{
		return 0;
	}

	if(level.player selfieaccessselfievalidflaginplayerdef())
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
take_selfie()
{
	if(!isdefined(level.selfiebooth.clone))
	{
		return;
	}

	if(!isdefined(level.player))
	{
		return;
	}

	if(!isdefined(level.player.spawned_avatar))
	{
		return;
	}

	if(!isdefined(level.player.spawned_avatar.costume))
	{
		return;
	}

	var_00 = level.selfiebooth.clone.origin;
	var_01 = level.selfiebooth.clone geteye();
	level.selfiebooth.clone setcostumemodels(level.player.spawned_avatar.costume);
	wait 0.05;
	if(!level.player selfierequestupdate(level.selfiebooth.camera_pos.origin,var_00,var_01[2] - var_00[2],0,0))
	{
		return;
	}

	while(isdefined(level.player) && !level.player selfiescreenshottaken())
	{
		wait 0.05;
	}
}