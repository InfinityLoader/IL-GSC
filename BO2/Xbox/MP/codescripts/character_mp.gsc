/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\character_mp.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:13:28 AM
*******************************************************************/

#include codescripts/character;

//Function Number: 1
setmodelfromarray(a)
{
	self setmodel(a[randomint(a.size)]);
}

//Function Number: 2
precachemodelarray(a)
{
	for(i = 0;i < a.size;i++)
	{
		precachemodel(a[i]);
	}
}

//Function Number: 3
attachfromarray(a)
{
	self attach(codescripts/character::randomelement(a),"",1);
}