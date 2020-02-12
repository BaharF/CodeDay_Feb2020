
Tracks_Layout := RECORD
    STRING id;
    STRING artist_name;
    STRING track_name;
    STRING playlist_name;
END;

tracks_file_path := '~codeday::spotify_dataset.csv';

tracks_ds := DATASET(tracks_file_path, Tracks_Layout, CSV(HEADING(1)));

//********************************************************************************

// Show the first 100 records of the actual data
//OUTPUT(tracks_ds, NAMED('tracks_ds'));
OUTPUT(CHOOSEN(tracks_ds, 50), NAMED('first_100_tracks_ds'));

//********************************************************************************

// Simple Filter
NonBlank := tracks_ds(artist_name != '');
OUTPUT(CHOOSEN(NonBlank, 50), NAMED('NonBlank_Artists'));

//********************************************************************************

// Ascending sort
SortName_Asc := SORT(NonBlank, artist_name);
OUTPUT(CHOOSEN(SortName_Asc, 50), NAMED('SortName_Asc'));

// Descending sort
SortName_Dsc := SORT(NonBlank, -artist_name);
OUTPUT(CHOOSEN(SortName_Dsc, 50), NAMED('SortName_Dsc'));

//********************************************************************************

// Group By Artist Name
Artists := TABLE
    (
        tracks_ds,
        {
            artist_name,
            INTEGER Counting := COUNT(GROUP)
        },
        artist_name
    );

OUTPUT(CHOOSEN(SORT(Artists, Counting), 50), NAMED('Artists_Asc'));
OUTPUT(CHOOSEN(SORT(Artists, -Counting), 50), NAMED('Artists_Dsc'));

//********************************************************************************

// Inline TRANSFROM
New_Layout := RECORD
    INTEGER     ID;
    UNSIGNED4   RandomVal;
    STRING      FullName;
END;

PlayTime := PROJECT
    (
        tracks_ds,
        TRANSFORM
            (
                New_layout,
                SELF.ID := COUNTER,
                SELF.RandomVal := RANDOM() / 4;
                // TRIM Removes blank space from string, options are LEFT, RIGHT, ALL
                SELF.FullName := TRIM(LEFT.artist_name, ALL) + '  **  ' + TRIM(LEFT.playlist_name, ALL)
            )
    );

OUTPUT(CHOOSEN(PlayTime, 50), NAMED('PlayTime'));

//********************************************************************************

// Aggregation
getMax := Max(PlayTime, RandomVal); // Get Max Value
getMaxRec := PlayTime(RandomVal = getMax); //Get records with Max values

OUTPUT(getMax, NAMED('getMax'));
OUTPUT(CHOOSEN(getMaxRec, 50), NAMED('getMaxRec'));

getAVG := AVE(PlayTime, RandomVal);
OUTPUT(getAVG, NAMED('getAVG'));
