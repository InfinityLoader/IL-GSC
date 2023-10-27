/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damagefeedback.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 49 ms
 * Timestamp: 10/27/2023 2:25:18 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("damage_feedback");
	precacheshader("damage_feedback_j");
	precacheshader("damage_feedback_lightarmor");
	precacheshader("damage_feedback_juggernaut");
	precacheshader("scavenger_pickup");
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.hud_damagefeedback = newclienthudelem(var_00);
		var_00.hud_damagefeedback.horzalign = "center";
		var_00.hud_damagefeedback.vertalign = "middle";
		var_00.hud_damagefeedback.x = -12;
		var_00.hud_damagefeedback.y = -12;
		var_00.hud_damagefeedback.alpha = 0;
		var_00.hud_damagefeedback.archived = 1;
		var_00.hud_damagefeedback setshader("damage_feedback",24,48);
	}
}

//Function Number: 3
updatedamagefeedback(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	var_01 = -12;
	var_02 = -12;
	if(getdvarint("camera_thirdPerson"))
	{
		var_03 = self getthirdpersoncrosshairoffset() * 240;
	}
	else
	{
		var_03 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
	}

	if(level.splitscreen || self issplitscreenplayer())
	{
		var_03 = var_03 * 0.5;
	}

	var_04 = 0;
	var_05 = 1;
	if(param_00 == "hitBodyArmor")
	{
		self.hud_damagefeedback setshader("damage_feedback_j",24,48);
		self playlocalsound("MP_hit_alert");
	}
	else if(param_00 == "hitLightArmor")
	{
		self.hud_damagefeedback setshader("damage_feedback_lightarmor",24,48);
		self playlocalsound("MP_hit_alert");
	}
	else if(param_00 == "hitJuggernaut")
	{
		self.hud_damagefeedback setshader("damage_feedback_juggernaut",24,48);
		self playlocalsound("MP_hit_alert");
	}
	else if(param_00 == "none")
	{
		return;
	}
	else if(param_00 == "scavenger" && !level.hardcoremode)
	{
		var_01 = -36;
		var_02 = 32;
		self.hud_damagefeedback setshader("scavenger_pickup",64,32);
		var_04 = 2.5;
	}
	else
	{
		self.hud_damagefeedback setshader("damage_feedback",24,48);
		self playlocalsound("MP_hit_alert");
	}

	self.hud_damagefeedback.alpha = var_05;
	if(var_04 != 0)
	{
		self.hud_damagefeedback fadeovertime(var_04);
	}
	else
	{
		self.hud_damagefeedback fadeovertime(1);
	}

	self.hud_damagefeedback.alpha = 0;
	if(self.hud_damagefeedback.x != var_01)
	{
		self.hud_damagefeedback.x = var_01;
	}

	var_02 = var_02 - int(var_03);
	if(self.hud_damagefeedback.y != var_02)
	{
		self.hud_damagefeedback.y = var_02;
	}
}