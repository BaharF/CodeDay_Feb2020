filePath := '~codeday::spotify_dataset.csv';

ds := DATASET(filePath, RECORDOF(filePath, LOOKUP), CSV(HEADING(1)));

OUTPUT(CHOOSEN(ds, 100));