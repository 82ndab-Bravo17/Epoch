/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Initalize player variables

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/release/Sources/epoch_code/compile/setup/EPOCH_clientInit.sqf

    Example:
    call EPOCH_clientInit;

    Parameter(s):
		NONE

	Returns:
	NOTHING
*/
EPOCH_buildMode = 0;
EPOCH_buildDirection = 0;
EPOCH_buildDirectionPitch = 0;
EPOCH_buildDirectionRoll = 0;
EPOCH_target_attachedTo = player;
EPOCH_debugMode = false;
EPOCH_snapDirection = 0;
EPOCH_stabilityTarget = objNull;
EPOCH_equippedItem_PVS = [];
EPOCH_pendingP2ptradeTarget = objNull;
EPOCH_lastNPCtradeTarget = objNull;
EPOCH_lastJumptime = diag_tickTime;
EPOCH_lastAGTime = diag_tickTime;
EPOCH_lastMineRocks = diag_tickTime;
EPOCH_target = objNull;
EPOCH_Z_OFFSET = 0;
EPOCH_X_OFFSET = 0;
EPOCH_Y_OFFSET = 5;
EPOCH_arr_snapPoints = [];
EPOCH_arr_snapObjects = [];
EPOCH_prevTarget = objNull;
EPOCH_interactOption = 0;
EPOCH_playerStaminaMax = 100;
Epoch_ActiveCam = objnull;
Epoch_AutoCam = true;
Epoch_CamAdjust = [0,0,0];

{
	missionNamespace setVariable [format ["EPOCH_player%1",_x],EPOCH_defaultVars select _forEachIndex];
}forEach EPOCH_customVars;

// suppress group chatter
0 fadeRadio 0;
enableSentences false;
enableRadio false;
player setVariable["BIS_noCoreConversations", true];

EPOCH_ArmaSlingLoad = true;
_r3fON = if(!isNil "R3F_LOG_CFG_can_lift")then{if!(R3F_LOG_CFG_can_lift isEqualTo [])then{true}else{false}}else{false};
_advSling = if(!isNil "ASL_ROPE_INIT")then{if(ASL_ROPE_INIT)then{true}else{false}}else{false};
if (_r3fON || _advSling)then{
	EPOCH_ArmaSlingLoad = false;
};

// handle actions, prevactions, nextactions
inGameUISetEventHandler ["Action", "if(!(_this isEqualTo []) && !(_this select 10 in ['PrevAction','NextAction']))then{_this call EPOCH_handleUIActions}"];
//inGameUISetEventHandler ["NextAction", "_this call EPOCH_handleUIActions"];
//inGameUISetEventHandler ["PrevAction", "_this call EPOCH_handleUIActions"];
