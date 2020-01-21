IMPORT $.raw_mod;

//------------------------------------------------------------------------------

// View raw Data
OUTPUT(CHOOSEN(raw_mod.games_ds,100), NAMED('Game_Data'));

//------------------------------------------------------------------------------

// Most Expensive Game -- Result has 30 rows
getMaxPrice := MAX(raw_mod.games_ds, price); //Get Max Price
MaxPrice := raw_mod.games_ds(price = getMaxPrice); //Find the max price in dataset
OUTPUT(MaxPrice, NAMED('Most_Expensive')); // View result

//------------------------------------------------------------------------------

// Count how many games have 5 rating -- Result is 990
GoodRating := raw_mod.games_ds(avg_user_rating >= 5);
OUTPUT(COUNT(GoodRating), NAMED('Above_Four_Rating'));

//------------------------------------------------------------------------------

// Game Used least memory sapce -- Result is 1 row
getLeastSpace := MIN(raw_mod.games_ds, size);
LeastSpace := raw_mod.games_ds(getLeastSpace = size);
OUTPUT(LeastSpace, NAMED('Least_Memory_Space'));

//------------------------------------------------------------------------------

// Sort Games by Name, display the first 200
SortName := SORT(raw_mod.games_ds, Name);
OUTPUT(CHOOSEN(SortName, 200), NAMED('Sorted_Name'));

//------------------------------------------------------------------------------
// How many apps have not yet been rated -- Result is 9446

unratedAppCount := COUNT(raw_mod.games_ds(User_Rating_Count = 0));
OUTPUT(unratedAppCount, NAMED('num_unrated_apps'));

//------------------------------------------------------------------------------

// Display games developed by "Mighty Mighty Good Games" OR "Ninja Kiwi" AND has "age_rating" equal 4+
// From above result count how many are "Mighty Mighty Good Games"
// Result -- Special_Developer is 14 rows and MightyMighty_Count is 10 rows
getDev := raw_mod.games_ds(developer IN ['Mighty Mighty Good Games', 'Ninja Kiwi'] AND age_rating = '4+');
OUTPUT(getDev, NAMED('Special_Developer'));
OUTPUT(COUNT(getDev(developer = 'Mighty Mighty Good Games')), NAMED('MightyMighty_Count'));

//------------------------------------------------------------------------------

// Create a  new data set that has ID, subtitle, age_rating, with a new col that shows
// "Name :: Developer" and call this new col "Game Info"
//Result is -- more than 100 rows
NewRec := RECORD
  STRING id;
  STRING	 GameInfo;
	STRING  age_rating;
	STRING subtitle;
END;


NewDS := PROJECT(raw_mod.games_ds,                  
                 				TRANSFORM(NewRec,                                  
                                  SELF.GameInfo := LEFT.Name  + ' :: ' + LEFT.Developer,
                                  SELF := LEFT));

OUTPUT(NewDS, NAMED('New_GameDS'));

//------------------------------------------------------------------------------


// Number of expensive apps (20-50, 50-100, 100+)

expensive20 := COUNT(raw_mod.games_ds(Price >=20 AND Price < 50));
OUTPUT(expensive20, NAMED('apps_20_50')); // Result is 4 

expensive50 := COUNT(raw_mod.games_ds(Price >=50 AND Price < 100));
OUTPUT(expensive50, NAMED('apps_50_100')); // Result is 2 

expensive100 := COUNT(raw_mod.games_ds(Price >=100));
OUTPUT(expensive100, NAMED('apps_100_plus')); // Result is 31 

//------------------------------------------------------------------------------
// Display number of games per their "avg_user_rating"
avgUserView := TABLE
    (
        raw_mod.games_ds,
        {
            UNSIGNED1   rating := TRUNCATE(avg_user_rating),	//Truncate returns integer portion of the real_value
            UNSIGNED4   num_games := COUNT(GROUP)
        },
        TRUNCATE(avg_user_rating)
    );

OUTPUT(avgUserView, NAMED('count_per_rating')); // Result is 6 rows

//------------------------------------------------------------------------------

// Number of apps for each age rating
// Result is 4 rows

ageTable := TABLE
    (
        raw_mod.games_ds,
        {
            Age_Rating,
            UNSIGNED2   num := COUNT(GROUP)
        },
        Age_Rating
    );
sortedAgeTable := SORT(ageTable, -num);
OUTPUT(sortedAgeTable, NAMED('app_count_by_age_rating')); 

//------------------------------------------------------------------------------

// Number of unrated apps for each primary genre
// Result is 21 rows

unratedApps := raw_mod.games_ds(User_Rating_count = 0);
genreTable := TABLE
    (
        raw_mod.games_ds,
        {
            Primary_Genre,
            UNSIGNED2   num := COUNT(GROUP)
        },
        Primary_Genre
    );
sortedGenreTable := SORT(genreTable, -num);
OUTPUT(sortedGenreTable, NAMED('unrated_app_count_by_genre'));

//------------------------------------------------------------------------------

// Number of rated apps for each primary genre and age rating
// Result is 4 rows

ratedApps := raw_mod.games_ds(User_Rating_count > 0);
genreAgeTable := TABLE
    (
        ratedApps,
        {
            Primary_Genre,
            Age_Rating,
            UNSIGNED2   num := COUNT(GROUP)
        },
        Primary_Genre, Age_Rating
    );
filteredGenreAgeTable := genreAgeTable(num > 100);
sortedGenreAgeTable := SORT(filteredGenreAgeTable, -num);
OUTPUT(sortedGenreAgeTable, NAMED('rated_app_count_by_genre_age'));
