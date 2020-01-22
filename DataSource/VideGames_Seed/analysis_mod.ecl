import clean_mod;

EXPORT analysis_mod := MODULE
  EXPORT top_user_rating_count := TOPN( TABLE(clean_mod.games_ds, {name, user_rating_count}) , 10, -user_rating_count);     
END;