# require the driver package

# Create a client
# client = ...

# A. Update all movies with "NOT RATED" at the "rated" key to be "Pending rating". The operation must be in-place and atomic.


# B. Find a movie with your genre in imdb and insert it into your database with the fields listed in the hw description.


# C. Use the aggregation framework to find the total number of movies in your genre.

# Example result:
#  => [{"_id"=>"Comedy", "count"=>14046}]


# D. Use the aggregation framework to find the number of movies made in the country you were born in with a rating of "Pending rating".

# Example result when country is Hungary:
#  => [{"_id"=>{"country"=>"Hungary", "rating"=>"Pending rating"}, "count"=>9}]


# E. Create an example using the $lookup pipeline operator. See hw description for more info.