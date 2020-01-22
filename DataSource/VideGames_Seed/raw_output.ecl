filePath := '~codeday_nov2019::appstore_games.csv';

ds := DATASET(filePath, RECORDOF(filePath, LOOKUP), CSV(HEADING(1)));

OUTPUT(COUNT(ds));

OUTPUT(CHOOSEN(ds, 100));