#include <YSI\y_ini>

#pragma tabsize 0

#define PATH "/Usuarios/%s.ini"

#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4

enum pInfo
{
    pPassword,
    pMoney,
    pAdmin,
    pKills,
    pDeaths
}
new PlayerInfo[MAX_PLAYERS][pInfo];

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Contraseña",PlayerInfo[playerid][pPassword]);
    INI_Int("Dinero",PlayerInfo[playerid][pMoney]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Asesinatos",PlayerInfo[playerid][pKills]);
    INI_Int("Muertes",PlayerInfo[playerid][pDeaths]);
    return 1;
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

public OnPlayerConnect(playerid)
{
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"{FF8000}:: || Logeo || ::","{FFFFFF}Tu cuenta esta registrada, porfavor escribe tu contraseña.","Login","");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,"{FF8000}:: || Registro || ::","{FFFFFF}Tu cuenta no esta registrada, porfavor escribe una nueva contraseña para registrarla.","Register","");
        return 1;
    }
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Money",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Close(File);
    GangZoneHideForPlayer(playerid,gangzone);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "{FF8000}:: || Registro || ::","{FFFFFF}Tu cuenta no esta registrada, porfavor escribe una nueva contraseña para registrarla","Register","");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Money",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_Close(File);

                SetSpawnInfo(playerid, 0, 0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
                SpawnPlayer(playerid);
                SendClientMessage(playerid, COLOR_CHARTREUSE, "[<!>] Tu cuenta se ha registrado correctamente.");
            }
        }

        case DIALOG_LOGIN:
        {
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPassword][32])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
                    SendClientMessage(playerid, COLOR_CHARTREUSE, "[<!>] Has logeado correctamente.");
                }
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_SUCCESS_2, DIALOG_STYLE_INPUT,"{FF8000}:: || Logeo || ::","{FF0000}Contraseña incorrecta. \n{FFFFFF}Escribe tu contraseña para logearte.","Login","");
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
                    SendClientMessage(playerid, COLOR_CHARTREUSE, "[<!>] Has logeado correctamente.");
                }
                return 1;
            }
        }
    }
    return 1;
}
