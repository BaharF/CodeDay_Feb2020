import analysis_mod;
import Visualizer;

OUTPUT(analysis_mod.top_user_rating_count, NAMED('user_rating_count'));

Visualizer.TwoD.Bubble('user_rating_count', /*datasource*/, 'user_rating_count');
