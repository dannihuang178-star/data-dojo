# 1. Filter the DataFrame to include only TV shows from 2016 to 2020.
# This narrows down the dataset to the specific scope of the analysis.
# The result is a new DataFrame `df_tvshows`.
df_tvshows = df[(df['type']=='TV Show') & (df['release_year'] >= 2016) & (df['release_year'] <= 2020)]

# 2. Extract the numeric part of the duration string and convert it to an integer.
# This cleans the data, allowing for numerical comparisons later.
# We apply a regex pattern to extract digits from strings like '3 Seasons'.
df_tvshows['duration_numeric'] = df_tvshows['duration'].str.extract(r'(\d+)').astype(int)

# 3. Group by release year to count total TV shows and long-running ones.
# This step aggregates the data to calculate per-year totals.
# We then perform a vectorized operation to get the final percentage.
total_shows_by_year = df_tvshows.groupby('release_year').size()
long_shows_by_year = df_tvshows[df_tvshows['duration_numeric'] > 2].groupby('release_year').size()

# 4. Calculate the percentage of long-running shows per year.
# This final calculation provides the core metric requested in the problem.
# We use direct Series division and round the result for readability.
share_of_long_shows = ((long_shows_by_year / total_shows_by_year) * 100).round(2)
