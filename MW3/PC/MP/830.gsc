/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 830.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	switch(lib_0144::func_1E63(2))
	{
		case 0:
			lib_02A0::main();
			break;

		case 1:
			lib_02A1::main();
			break;
	}
}

//Function Number: 2
precache()
{
	lib_02A0::precache();
	lib_02A1::precache();
}