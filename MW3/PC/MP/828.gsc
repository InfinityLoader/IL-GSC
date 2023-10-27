/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 828.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	switch(lib_0144::func_1E63(4))
	{
		case 0:
			lib_029C::main();
			break;

		case 1:
			lib_029D::main();
			break;

		case 2:
			lib_029E::main();
			break;

		case 3:
			lib_029F::main();
			break;
	}
}

//Function Number: 2
precache()
{
	lib_029C::precache();
	lib_029D::precache();
	lib_029E::precache();
	lib_029F::precache();
}