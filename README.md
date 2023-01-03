# README
## Setup
- [Document](https://github.com/nguyenthanhcong101096/shortener_url/blob/main/HOW_TO_RUN_PROJECT.md)
## Security
- For security, we can introduce private URLs and authorization. A separate table can be used to store user ids that have permission to access a specific URL. If a user does not have proper permissions, we can return an HTTP 401 (Unauthorized) error.

- Prevent ddos by algorithm (Leaky bucket, Fixed window) limit request

## Scalability
### Algorithm generate short link
- Think base62 and length of short link

  For example: 62^6 = 56.8 bilion short urls

### Server configuration
- Thinking upgrade memory and banwidth when we have over bilion users

### Database
- To scale out our database we will need to partition our data this is we will sepratate the DB into many different DB children. Each child will contain 1 piece of data

  For example, URLs (omit https:// or http://) that start with the word 'a' will be put in the DB type a, URLs that start with letter 'B' will included in the database of type b

- Thinking use NoSql(mongoDB)

### Memory
- Cache short_url often use by users
- Auto clear short_link not use by crontab