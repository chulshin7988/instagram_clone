-- Find the 5 oldest users
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;

-- Which day of the week do most users register on
SELECT
	dayname(created_at) AS dayOfWeek,
    COUNT(*) AS total
FROM users
GROUP BY dayOfWeek
ORDER BY total DESC;

-- Find the users who have never posted a photo
SELECT username
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Find out which one of the photos have the most likes
SELECT
	username,
    photos.id,
    photos.image_url,
    COUNT(*) AS total
FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- How many times does the average user post
SELECT
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS averg;

-- Top 5 most commonly used hashtags
SELECT
	tags.tag_name,
    COUNT(*) AS total
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

-- Find users who have liked every single photo on the site
SELECT
	username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);