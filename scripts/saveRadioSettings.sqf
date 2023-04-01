// Define Arrays
_baseRadios = [];
_channels = [];
_volumes = [];
_spatials = [];
_pttAssignments = [];
_pttTemp = [];
_pttSettings = [];
_pttAssignment1 = "";
_pttAssignment2 = "";
_pttAssignment3 = "";
_channel1 = "";
_channel2 = "";
_channel3 = "";
_volume1 = "";
_volume2 = "";
_volume3 = "";
_spatial1 = "";
_spatial2 = "";
_spatial3 = "";

// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Get the current PTT key and save the Base Radio Type for each PTT.
_pttAssignment = call acre_api_fnc_getMultiPushToTalkAssignment;

// Check if pttAssignment array has at least one element to prevent potential Zero Divisor error
if (count _pttAssignment > 0) then {
    // Get base radio and settings for radio set to PTT1
    _pttAssignment1 = [_pttAssignment select 0] call acre_api_fnc_getBaseRadio;
    _channel1 = [_pttAssignment select 0] call acre_api_fnc_getRadioChannel;
    _volume1 = [_pttAssignment select 0] call acre_api_fnc_getRadioVolume;
    _spatial1 = [_pttAssignment select 0] call acre_api_fnc_getRadioSpatial;
    profileNamespace setVariable ["pttAssignment_1", _pttAssignment1];
    profileNamespace setVariable ["channel_1", _channel1];
    profileNamespace setVariable ["volume_1", _volume1];
    profileNamespace setVariable ["spatial_1", _spatial1];

    // Check if pttAssignment array has at least two elements
    if (count _pttAssignment > 1) then {
        // Get base radio and settings for radio set to PTT2
        _pttAssignment2 = [_pttAssignment select 1] call acre_api_fnc_getBaseRadio;
        _channel2 = [_pttAssignment select 1] call acre_api_fnc_getRadioChannel;
        _volume2 = [_pttAssignment select 1] call acre_api_fnc_getRadioVolume;
        _spatial2 = [_pttAssignment select 1] call acre_api_fnc_getRadioSpatial;
        profileNamespace setVariable ["pttAssignment_2", _pttAssignment2];
        profileNamespace setVariable ["channel_2", _channel2];
        profileNamespace setVariable ["volume_2", _volume2];
        profileNamespace setVariable ["spatial_2", _spatial2];
    };

    // Check if pttAssignment array has at least three elements
    if (count _pttAssignment > 2) then {
        // Get base radio and settings for radio set to PTT3
        _pttAssignment3 = [_pttAssignment select 2] call acre_api_fnc_getBaseRadio;
        _channel3 = [_pttAssignment select 2] call acre_api_fnc_getRadioChannel;
        _volume3 = [_pttAssignment select 2] call acre_api_fnc_getRadioVolume;
        _spatial3 = [_pttAssignment select 2] call acre_api_fnc_getRadioSpatial;
        profileNamespace setVariable ["pttAssignment_3", _pttAssignment3];
        profileNamespace setVariable ["channel_3", _channel3];
        profileNamespace setVariable ["volume_3", _volume3];
        profileNamespace setVariable ["spatial_3", _spatial3];
    };
};

// Loop through each radio in the list and extract its base type, channel, volume and spatial setting
{
    // Check if we have looped through more than 6 radios
    if (_forEachIndex >= 6) exitWith {};

    // Extract the base radio type from the radio ID
    _baseRadio = [_x] call acre_api_fnc_getBaseRadio;

    // Add the base radio type to the baseRadios array
    _baseRadios pushBack _baseRadio;

    // Get the current channel for the radio
    _channel = [_x] call acre_api_fnc_getRadioChannel;

    // Add the channel to the channels array
    _channels pushBack _channel;

    // Get the current volume for the radio
    _volume = [_x] call acre_api_fnc_getRadioVolume;

    // Add the volume to the volumes array
    _volumes pushBack _volume;

    // Get the current spatial setting for the radio
    _spatial = [_x] call acre_api_fnc_getRadioSpatial;

    // Add the spatial setting to the spatials array
    _spatials pushBack _spatial;
    
} forEach _radios;

// Add the variables/arrays to the profileNamespace
profileNamespace setVariable ["radios_base", _baseRadios];
profileNamespace setVariable ["radios_channel", _channels];
profileNamespace setVariable ["radios_volume", _volumes];
profileNamespace setVariable ["radios_spatial", _spatials];

// Display the hint in-game
// hint "Radio Settings Saved";

// Combine the elements of the _pttSettings array into a single string
_pttSettingsStr = format ["PTT Settings:\n\n%1 %2 %3 %4\n%5 %6 %7 %8\n%9 %10 %11 %12", _pttAssignment1, _channel1, _volume1, _spatial1, _pttAssignment2, _channel2, _volume2, _spatial2, _pttAssignment3, _channel3, _volume3, _spatial3];

// Display the hint with the PTT Settings
hint format ["Radio Settings Saved\n\n%1", _pttSettingsStr];

