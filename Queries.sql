#  Find the 5 oldest users of the Instagram from the database provided
SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 0 , 5;


#  Find the users who have never posted a single photo on Instagram
SELECT 
    *
FROM
    users
WHERE
    id NOT IN (SELECT 
            user_id
        FROM
            photos);


#  Identify the winner of the contest and provide their details to the team
SELECT 
    photos.user_id,
    users.username,
    photo_id,
    COUNT(*) AS max_likes
FROM
    likes
        JOIN
    users
        JOIN
    photos ON users.id = photos.user_id
        AND photos.id = likes.photo_id
GROUP BY likes.photo_id
ORDER BY max_likes DESC
LIMIT 1; 


#  Identify and suggest the top 5 most commonly used hashtags on the platform
SELECT 
    id, tag_name, COUNT(tag_id) AS no_of_times_tag_used
FROM
    photo_tags
        JOIN
    tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY no_of_times_tag_used DESC
LIMIT 5;

# What day of the week do most users register on? Provide insights on when to schedule an ad campaign
SELECT 
    COUNT(id) AS no_of_users_registered,
    DAYNAME(created_at) AS best_day_for_AD_campaign
FROM
    users
GROUP BY best_day_for_AD_campaign
ORDER BY COUNT(id) DESC
LIMIT 1; 

#  Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
SELECT 
    COUNT(DISTINCT (users.id)) AS total_no_of_users,
    COUNT(photos.id) AS total_no_of_photos,
    COUNT(photos.id) / COUNT(DISTINCT (users.id)) AS avg_posts_per_user
FROM
    users
        LEFT JOIN
    photos ON photos.user_id = users.id;
    
# Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
SELECT 
    user_id AS bot_id,
    
FROM
    likes
GROUP BY user_id
HAVING COUNT(user_id) = (SELECT 
        COUNT(id)
    FROM
        photos);
        