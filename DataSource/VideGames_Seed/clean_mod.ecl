import raw_mod;

EXPORT clean_mod := MODULE
		EXPORT games_layout := RECORD
       STRING50 name;
       REAL price;
       REAL avg_user_rating;
       INTEGER user_rating_count;
    END;
     
    EXPORT games_ds := PROJECT(raw_mod.games_ds, TRANSFORM (games_layout, SELF:=LEFT));
END;