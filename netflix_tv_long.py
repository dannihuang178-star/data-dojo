df_tvshows = df[(df['type']=='TV Show') & (df['release_year'] >= 2016) & (df['release_year'] <= 2020)] 
duration_numeric = df_tvshows['duration'].str.extract(r'(\d+)').astype(int) 
total_shows_by_year = df_tvshows.groupby('release_year').size() 
long_shows_by_year = df_tvshows.groupby('release_year').apply(lambda x: (x['duration'].str.extract(r'(\d+)').astype(int) > 2).sum()) 
share_of_long_shows = (long_shows_by_year / total_shows_by_year) * 100
