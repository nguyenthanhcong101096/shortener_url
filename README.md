# README

## Security
- For security, we can introduce private URLs and authorization. A separate table can be used to store user ids that have permission to access a specific URL. If a user does not have proper permissions, we can return an HTTP 401 (Unauthorized) error.

- Prevent ddos by algorithm (Leaky bucket, Fixed window)

## Scalability
- To scale out our database we will need to partition our data this is we will sepratate the DB into many different DB children. Each child will contain 1 piece of data

For example, URLs (omit https:// or http://) that start with the word 'a' will be put in the DB type a, URLs that start with letter 'B' will included in the database of type b 