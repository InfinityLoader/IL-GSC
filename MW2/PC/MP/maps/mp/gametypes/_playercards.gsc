/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playercards.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		iconhandle = player maps\mp\gametypes\_persistence::statget("cardIcon");
		player setcardicon(iconhandle);
		titlehandle = player maps\mp\gametypes\_persistence::statget("cardTitle");
		player setcardtitle(titlehandle);
		nameplatehandle = player maps\mp\gametypes\_persistence::statget("cardNameplate");
		player setcardnameplate(nameplatehandle);
	}
}