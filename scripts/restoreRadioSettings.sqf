// THIS SCRIPT DOES NOT WORK YET

// Get the saved variables/arrays from the profileNamespace
_baseRadios = profileNamespace getVariable ["radios_base", []];
_channels = profileNamespace getVariable ["radios_channel", []];
_volumes = profileNamespace getVariable ["radios_volume", []];
_spatials = profileNamespace getVariable ["radios_spatial", []];

// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Check if the player is carrying any radios
if (count _radios == 0) then {
    hint "You are not carrying any radios";
} else {
    // Reorder the elements in the _radios array
    _sortedRadios = [];
    _processedRadios = [];
    {
        _baseType = _x;
        {
            _currentBaseRadio = [_x] call acre_api_fnc_getBaseRadio;

            if (_currentBaseRadio isEqualTo _baseType && !(_x in _processedRadios)) then {
                _sortedRadios pushBack _x;
                _processedRadios pushBack _x;
                break;
            };
        } forEach _radios;
    } forEach _baseRadios;

    // Add any remaining radios not in the _baseRadios list
    _radios = _sortedRadios + (_radios - _processedRadios);

// Set the restored PTT assignment
_radiosCount = count _radios;
if (_radiosCount >= 3) then {
    _ptt1 = _radios select 0;
    _ptt2 = _radios select 1;
    _ptt3 = _radios select 2;
    _success = [ [_ptt1, _ptt2, _ptt3] ] call acre_api_fnc_setMultiPushToTalkAssignment;
} else {
    if (_radiosCount == 2) then {
        _ptt1 = _radios select 0;
        _ptt2 = _radios select 1;
        _success = [ [_ptt1, _ptt2] ] call acre_api_fnc_setMultiPushToTalkAssignment;
    } else {
        if (_radiosCount == 1) then {
            _ptt1 = _radios select 0;
            _success = [ [_ptt1] ] call acre_api_fnc_setMultiPushToTalkAssignment;
        };
    };
};

    // Create copies of the saved arrays to work with
    _baseRadiosCopy = +_baseRadios;
    _channelsCopy = +_channels;
    _volumesCopy = +_volumes;
    _spatialsCopy = +_spatials;

    // Check if any radios have matching base types
    _foundMatchingRadios = false;

    // Loop through the radios and set their settings
    {
        // Check if we have looped through more than 6 radios
        if (_forEachIndex >= 6) exitWith {};

        // Extract the base radio type from the radio ID
        _currentBaseRadio = [_x] call acre_api_fnc_getBaseRadio;

        // Check if the current base radio type is in the saved baseRadios array
        _index = _baseRadiosCopy find _currentBaseRadio;
        if (_index != -1) then {

            // Set the channel for the radio
            [_x, _channelsCopy select _index] call acre_api_fnc_setRadioChannel;

            // Set the volume for the radio
            [_x, _volumesCopy select _index] call acre_api_fnc_setRadioVolume;

            // Set the spatial setting for the radio
            [_x, _spatialsCopy select _index] call acre_api_fnc_setRadioSpatial;

            // Remove the used base radio type and its associated settings from the copied arrays
            _baseRadiosCopy deleteAt _index;
            _channelsCopy deleteAt _index;
            _volumesCopy deleteAt _index;
            _spatialsCopy deleteAt _index;

            // Set flag to indicate matching radio was found
            _foundMatchingRadios = true;
        };
    } forEach _radios;

    if (_foundMatchingRadios) then {

        // Check if all base radios were matched
        if (count _baseRadiosCopy == 0) then {
            hint "Radio Settings Restored";
        } else {
            hint "Radio settings could only be partially restored due to missing radios in your inventory";
        };
    } else {
        // Display failure message
        hint "No matching radio types found";
    };
};