forward DataUserLoad(playerid);
forward DataUserSave(playerid);
forward DataUserClean(playerid);
forward LoadStaticVehicles();

enum DataUsers
{
	Dinero,
	Admin
};
enum DataUsersOnline
{
	Estado,
	/*
	    0 - Conectando...
		1 - Login
		2 - Registro
		3 - Logueado
	*/
	NameOnline[MAX_PLAYER_NAME]
};

new DIR_USUARIOS[12]    = "/Usuarios/";
new PlayersData[MAX_PLAYERS][DataUsers];
new PlayersDataOnline[MAX_PLAYERS][DataUsersOnline];

main()
{

}

public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	AddPlayerClass(0, -2089.7454, -85.3183, 34.9356, 269.1425, 0, 0, 0, 0, 0, 0);

	LoadStaticVehicles();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	PlayersDataOnline[playerid][Estado] = 0;
    GetPlayerName(playerid, PlayersDataOnline[playerid][NameOnline], MAX_PLAYER_NAME);

	new File[256];
	format(File, sizeof(File), "%s%s.ini", DIR_USUARIOS, PlayersDataOnline[playerid][NameOnline]);

	if ( dini_Exists(File) )
	{
	    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Iniciar sesi?n", "{FFFFFF}Bienvenido a {0080FF}Oderim! {FFFFFF}Ingrese su \ncontrase?a para iniciar sesi?n.", "Conectar", "Cancelar");
	    PlayersDataOnline[playerid][Estado] = 1;
	}
	else
	{
	    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Registrar cuenta", "{FFFFFF}Bienvenido a {0080FF}Oderim! {FFFFFF}Ingrese \nuna contrase?a para crear una cuenta.", "Registrar", "Cancelar");
	    PlayersDataOnline[playerid][Estado] = 2;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    DataUserSave(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (PlayersDataOnline[playerid][Estado] == 3)
	{
	    printf("%s[%i] || %s", PlayersDataOnline[playerid][NameOnline], playerid, cmdtext);

	    // COMANDO: /Dinero
	    if (strfind(cmdtext, "/Dinero", true) == 0)
	    {
	        GivePlayerMoney(playerid, 500);
	        return 1;
		}
		// COMANDO: /Admin
		if (strfind(cmdtext, "/Admin", true) == 0)
		{
		    PlayersData[playerid][Admin] = 1;
		    return 1;
		}
	}
	else
	{
		SendClientMessage(playerid, -1, "No has iniciado sesión para usar comandos.");
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch ( dialogid )
	{
	    // LOGIN
	    case 0:
	    {
			new File[256], Comprobar[256];
			if ( !strlen(inputtext) )
			{
			    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Iniciar sesi?n", "{FFFFFF}Bienvenido a {0080FF}Oderim! {FFFFFF}Ingrese su \ncontrase?a para iniciar sesi?n.", "Conectar", "Cancelar");
			}
			if ( response == 0 )
			{
			    Kick(playerid);
			}

			format(File, sizeof(File), "%s%s.ini", DIR_USUARIOS, PlayersDataOnline[playerid][NameOnline]);
			format(Comprobar, sizeof(Comprobar), "%s", dini_Get(File, "Contrase?a"));

			if ( !strcmp (inputtext, Comprobar) )
			{
				DataUserLoad(playerid);
				PlayersDataOnline[playerid][Estado] = 3;
			}
			else
			{
				ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "Contrase?a err?nea", "{FFFFFF}No has escrito la contrase?a correcta de esta cuenta.", "Aceptar", "");
				Kick(playerid);
			}
		}
		// REGISTRO
		case 1:
		{
		    new File[256], string[200];
			if ( !strlen(inputtext) )
			{
				ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "Registrar cuenta", "{FFFFFF}Bienvenido a {0080FF}Oderim! {FFFFFF}Ingrese \nuna contrase?a para crear una cuenta.", "Registrar", "Cancelar");
			}
			if ( response == 0 )
			{
			    Kick(playerid);
			}
			format(File, sizeof(File), "%s%s.ini", DIR_USUARIOS, PlayersDataOnline[playerid][NameOnline]);
			dini_Create(File);
			dini_Set(File, "Contrase?a", inputtext);
			DataUserClean(playerid);
			format(string,sizeof(string),"{FFFFFF}Ha elegido la contrase?a: {0080FF}%s \n{FFFFFF}Ingresela de nuevo por favor.", inputtext);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Registrar cuenta", string, "Aceptar", "Cancelar");
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public DataUserLoad(playerid)
{
	new File[256];
	format(File, 256, "%s%s.ini", DIR_USUARIOS, PlayersDataOnline[playerid][NameOnline]);

	GivePlayerMoney(playerid, dini_Int(File, "Dinero"));
	PlayersData[playerid][Admin] = dini_Int(File, "Admin");
	return 1;
}

public DataUserSave(playerid)
{
	if (PlayersDataOnline[playerid][Estado] == 3)
	{
		new File[256];
		format(File, 256, "%s%s.ini", DIR_USUARIOS, PlayersDataOnline[playerid][NameOnline]);

		dini_IntSet(File, "Dinero", GetPlayerMoney(playerid));
		dini_IntSet(File, "Admin", PlayersData[playerid][Admin]);
		return 1;
	}
	return 1;
}

public DataUserClean(playerid)
{
	if ( IsPlayerConnected(playerid) )
	{
		new File[256];
		format(File, 256, "%s%s.ini", DIR_USUARIOS, PlayersDataOnline[playerid][NameOnline]);

		dini_IntSet(File, "Dinero", 1000);
		dini_IntSet(File, "Admin", 0);
		return 1;
	}
	return 1;
}

public LoadStaticVehicles()
{
    // SPECIAL
	LoadStaticVehiclesFromFile("Vehicles/trains.txt");
	LoadStaticVehiclesFromFile("Vehicles/pilots.txt");

   	// LAS VENTURAS
    LoadStaticVehiclesFromFile("Vehicles/lv_law.txt");
    LoadStaticVehiclesFromFile("Vehicles/lv_airport.txt");
    LoadStaticVehiclesFromFile("Vehicles/lv_gen.txt");

    // SAN FIERRO
    LoadStaticVehiclesFromFile("Vehicles/sf_law.txt");
    LoadStaticVehiclesFromFile("Vehicles/sf_airport.txt");
    LoadStaticVehiclesFromFile("Vehicles/sf_gen.txt");

    // LOS SANTOS
    LoadStaticVehiclesFromFile("Vehicles/ls_law.txt");
    LoadStaticVehiclesFromFile("Vehicles/ls_airport.txt");
    LoadStaticVehiclesFromFile("Vehicles/ls_gen_inner.txt");
    LoadStaticVehiclesFromFile("Vehicles/ls_gen_outer.txt");

    // OTHER AREAS
    LoadStaticVehiclesFromFile("Vehicles/whetstone.txt");
    LoadStaticVehiclesFromFile("Vehicles/bone.txt");
    LoadStaticVehiclesFromFile("Vehicles/flint.txt");
    LoadStaticVehiclesFromFile("Vehicles/tierra.txt");
    LoadStaticVehiclesFromFile("Vehicles/red_county.txt");
}
