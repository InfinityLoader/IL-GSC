/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 722.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	switch(lib_0144::func_1E63(4))
	{
		case 0:
			lib_01C3::main();
			break;

		case 1:
			lib_01C4::main();
			break;

		case 2:
			lib_01C5::main();
			break;

		case 3:
			lib_01C6::main();
			break;
	}
}

//Function Number: 2
precache()
{
	lib_01C3::precache();
	lib_01C4::precache();
	lib_01C5::precache();
	lib_01C6::precache();
}