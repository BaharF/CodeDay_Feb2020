EXPORT raw_mod := MODULE
  
  EXPORT games_layout := RECORD 
    STRING200 url;
    STRING50 id;
    STRING50 name;
    STRING50 subtitle;
    STRING200 icon_url;
    REAL avg_user_rating;
    INTEGER user_rating_count;
    REAL price;
    REAL in_app_purchases;
    STRING2000 description;
    STRING50 developer;
    STRING4 age_rating;
    STRING200 languages;
    STRING20 size;
    STRING50 primary_genre;
    STRING200 genres;
    STRING10 original_release_date;
    STRING10 current_version_release_date;
  END;

  EXPORT games_file_path := '~codeday_feb2020::appstore_games.csv';

  EXPORT games_ds := DATASET(games_file_path, games_layout, CSV(HEADING(1)));

END;