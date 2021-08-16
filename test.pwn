#include <a_samp>

// Run tests.
#define RUN_TESTS
// Uncomment (and edit) to run a single test case
//#define JUST_TEST TestName

// Minimal YSI.
#define YSI_NO_DIALOG_ASK
#define YSI_NO_ANDROID_CHECK
#define YSI_NO_GET_IP
#define FOREACH_NO_BOTS
#define FOREACH_NO_LOCALS
#define FOREACH_NO_VEHICLES
#define FOREACH_NO_ACTORS
#define FOREACH_NO_STREAMED

#include <YSI_Core\y_testing>

#define TEST_MESSAGE "HELLO, WORLD!"

forward SendTestMessagePID(playerid);
forward SendTestMessage();

main()
{
    print("Loading test Pawn scripts");
}

public OnGameModeInit()
{
    AddPlayerClass(0, 1000.0, 1000.0, 50.0, 0.0, 0, 0, 0, 0, 0, 0);
    CreateVehicle(562, 1000.0, 1000.0, 50.0, 0.0, 0, 0, 0, 0);
    return 1;
}

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, 0xFF0000FF, "This is Cman's test open.mp server.");
}

PTEST__ SendClientMessage(playerid)
{
    ASSERT_EQ(SendClientMessage(playerid, -1, TEST_MESSAGE), 1);
    ASSERT_EQ(SendClientMessage(playerid + 999, -1, TEST_MESSAGE), 0);
    ASK("Can you see the client message " TEST_MESSAGE "?");
}

PTEST__ SetPlayerCameraPosLookAt(playerid)
{
    ASSERT_EQ(SetPlayerCameraPos(playerid, 10, -10, 2), 1);
    ASSERT_EQ(SetPlayerCameraLookAt(playerid, 0, 0, 0), 1);
    ASSERT_EQ(SetPlayerCameraPos(playerid + 999, 10, -10, 2), 0);
    ASSERT_EQ(SetPlayerCameraLookAt(playerid + 999, 0, 0, 0), 0);
    ASK("Are you looking at the middle of Blueberry Farm?");
}

PTEST_CLOSE__ SetPlayerCameraPosLookAt(playerid)
{
    SetCameraBehindPlayer(playerid);
}

PTEST__ SetCameraBehindPlayer(playerid)
{
    ASSERT_EQ(SetCameraBehindPlayer(playerid), 1);
    ASSERT_EQ(SetCameraBehindPlayer(playerid + 999), 0);
    ASK("Is the camera behind you?");
}

PTEST__ SetPlayerDrunkLevel(playerid)
{
    ASSERT_EQ(SetPlayerDrunkLevel(playerid, 50000), 1);
    ASSERT_EQ(SetPlayerDrunkLevel(playerid + 999, 50000), 0);
    ASK("Are you drunk?");
}

PTEST__ SetPlayerDrunkLevelToZero(playerid)
{
    ASSERT_EQ(SetPlayerDrunkLevel(playerid, 0), 1);
    ASSERT_EQ(SetPlayerDrunkLevel(playerid + 999, 0), 0);
    ASK("Are you sober?");
}

PTEST__ SetPlayerInteriorAndPos(playerid)
{
    ASSERT_EQ(SetPlayerInterior(playerid, 17), 1);
    ASSERT_EQ(SetPlayerPos(playerid, -25.7220, -187.8216, 1003.5469), 1);
    ASSERT_EQ(SetPlayerInterior(playerid + 999, 17), 0);
    ASSERT_EQ(SetPlayerPos(playerid + 999, -25.7220, -187.8216, 1003.5469), 0);
    ASK("Are you in some shop?");
}

PTEST_CLOSE__ SetPlayerInteriorAndPos(playerid)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, 1010.0, 1010.0, 50.0);
}

PTEST__ SetPlayerWantedLevel(playerid)
{
    ASSERT_EQ(SetPlayerWantedLevel(playerid, 6), 1);
    ASSERT_EQ(SetPlayerWantedLevel(playerid + 999, 6), 0);
    ASK("Do you have a wanted level of 6?");
}

PTEST_CLOSE__ SetPlayerWantedLevel(playerid)
{
    SetPlayerWantedLevel(playerid, 0);
}

PTEST__ SetPlayerWeather(playerid)
{
    ASSERT_EQ(SetPlayerWeather(playerid, 16), 1);
    ASSERT_EQ(SetPlayerWeather(playerid + 999, 16), 0);
    ASK("Is the weather rainy?");
}

PTEST_CLOSE__ SetPlayerWeather(playerid)
{
    SetPlayerWeather(playerid, 0);
}

PTEST__ SetPlayerSkin(playerid)
{
    ASSERT_EQ(SetPlayerSkin(playerid, 1), 1);
    ASSERT_EQ(SetPlayerSkin(playerid + 999, 1), 0);
    ASK("Did your skin change?");
}

PTEST_CLOSE__ SetPlayerSkin(playerid)
{
    SetPlayerSkin(playerid, 0);
}

PTEST_INIT__ SetPlayerShopName(playerid)
{
    SetPlayerInterior(playerid, 5);
    SetPlayerPos(playerid, 372.5565, -131.3607, 1001.4922);
}

PTEST__ SetPlayerShopName(playerid)
{
    ASSERT_EQ(SetPlayerShopName(playerid, "FDPIZA"), 1);
    ASSERT_EQ(SetPlayerShopName(playerid + 999, "FDPIZA"), 0);
    ASK("Are you buying a pizza?");
}

PTEST_CLOSE__ SetPlayerShopName(playerid)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, 1000.0, 1000.0, 50.0);
}

PTEST__ GivePlayerMoney(playerid)
{
    ASSERT_EQ(GivePlayerMoney(playerid, 1000000), 1);
    ASSERT_EQ(GivePlayerMoney(playerid + 999, 1000000), 0);
    ASK("Are you suddenly rich ($1000000)?");
}

PTEST_CLOSE__ GivePlayerMoney(playerid)
{
    GivePlayerMoney(playerid, -1000000);
}

PTEST__ GetPlayerPos(playerid)
{
    new Float:x, Float:y, Float:z, ret[128];
    ASSERT_EQ(GetPlayerPos(playerid, x, y, z), 1);
    ASSERT_EQ(GetPlayerPos(playerid + 999, x, y, z), 0);
    format(ret, sizeof(ret), "Your pos is: %f %f %f", x, y, z);
    SendClientMessage(playerid, -1, ret);
    ASK("Does your position in a client message look nearly correct? (expected 1000 1000 50)");
}

PTEST__ CreateExplosion(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    ASSERT_EQ(CreateExplosion(x, y + 5, z, 1, 5.0), 1);
    ASSERT_EQ(CreateExplosion(x, y + 5, z, 14, -1.5), 1);
    ASK("Was there an explosion in front of you?");
}

TEST__ format()
{
    new ret[128];
    ASSERT_EQ(format(ret, sizeof(ret), "Test formatting: %s", "blibli"), 1);
    ASSERT_SAME(ret, "Test formatting: blibli");
    ret[0] = '\0';
    ASSERT_EQ(format(ret, sizeof(ret), "Failed formatting: %s", "blibli", "blabla"), 0);
    ASSERT_SAME(ret, "");
    ret[0] = '\0';
    ASSERT_EQ(format(ret, sizeof(ret), "Failed formatting: %s %s", "blibli"), 0);
    ASSERT_SAME(ret, "");
    ret[0] = '\0';
}

TEST__ strval()
{
    ASSERT_EQ(strval("0"), 0);
    ASSERT_EQ(strval("5"), 5);
    ASSERT_EQ(strval("5.0"), 5);
    ASSERT_EQ(strval(""), 0);
    ASSERT_EQ(strval("invalid_integer"), 0);
    ASSERT_EQ(strval("-5"), -5);
    ASSERT_EQ(strval("-5.0"), -5);
}

TEST__ floatstr()
{
    // Not implemented (yet) in master
    //ASSERT_EQ(floatstr("5.0"), 5.0);
}

PTEST__ GetPlayerName(playerid)
{
    new name[MAX_PLAYER_NAME + 1], ret[128];
    ASSERT_EQ(GetPlayerName(playerid, name, sizeof(name)), 1);
    ASSERT_EQ(GetPlayerName(playerid + 999, name, sizeof(name)), 0);
    format(ret, sizeof(ret), "Your name is: %s", name);
    SendClientMessage(playerid, -1, ret);
    ASK("Did you see your name in a client message?");
}

PTEST__ SendDeathMessage(playerid)
{
    ASSERT_EQ(SendDeathMessage(INVALID_PLAYER_ID, playerid, 10), 1);
    ASSERT_EQ(SendDeathMessage(playerid, playerid + 999, 5), 1);
    ASK("Do you see one death message?");
}

PTEST__ PlayAudioStreamForPlayer(playerid)
{
    ASSERT_EQ(PlayAudioStreamForPlayer(playerid, "http://tms-server.com/radio.mp3", 0, 0, 0, 100, true), 1);
    ASSERT_EQ(PlayAudioStreamForPlayer(playerid + 999, "http://tms-server.com/radio.mp3", 0, 0, 0, 100, true), 0);
    ASK("Is there a radio station playing?");
}

PTEST_CLOSE__ PlayAudioStreamForPlayer(playerid)
{
    StopAudioStreamForPlayer(playerid);
}

PTEST__ SetPlayerHealth(playerid)
{
    ASSERT_EQ(SetPlayerHealth(playerid, 50.0), 1);
    ASSERT_EQ(SetPlayerHealth(playerid + 999, 50.0), 0);
    ASK("Is your health at half?");
}

PTEST_CLOSE__ SetPlayerHealth(playerid)
{
    SetPlayerHealth(playerid, 100.0);
}

PTEST__ GetPlayerHealth(playerid)
{
    new ret[128], Float:hp;
    ASSERT_EQ(GetPlayerHealth(playerid, hp), 1);
    ASSERT_EQ(GetPlayerHealth(playerid + 999, hp), 0);
    format(ret, sizeof(ret), "Your hp are: %f", hp);
    SendClientMessage(playerid, -1, ret);
    ASK("Do you see your health displayed in a client message?");
}

PTEST_INIT__ EnableVehicleFriendlyFire(playerid)
{
    // TODO: Set players (playerid and +1) team, give them a weapon
}

// XXX: Does not work yet
PTEST__ EnableVehicleFriendlyFire(playerid)
{
    ASSERT_EQ(EnableVehicleFriendlyFire(), 1);
    SendClientMessage(playerid, -1, "Vehicle friendly fire is enabled");
    ASK("Is vehicle friendly fire on?");
}

PTEST_CLOSE__ EnableVehicleFriendlyFire(playerid)
{
    // TODO: Revert state set in PTEST_INIT__
}

// XXX: Does not work yet
PTEST__ SetTimer(playerid)
{
    //ASSERT_EQ(SetTimer("SendTestMessage", 5000, false), 1);
    SendClientMessage(playerid, -1, "Timer is set");
    ASK("Is the client message \"Timer was processed\" appearing after 5 seconds?");
}

// XXX: Does not work yet
PTEST__ SetTimerEx(playerid)
{
    //ASSERT_EQ(SetTimerEx("SendTestMessagePID", 5000, false, "i", playerid), 1);
    SendClientMessage(playerid, -1, "Timer is set");
    ASK("Is the client message \"Timer was processed\" appearing after 5 seconds?");
}

public SendTestMessage()
{
    //ASSERT_EQ(SendClientMessageToAll(-1, "Timer was processed"), 1);
}

public SendTestMessagePID(playerid)
{
    SendClientMessage(playerid, -1, "Timer was processed");
}
// vim: se ft=cpp:

