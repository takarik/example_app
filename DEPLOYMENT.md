# Heroku Deployment Guide

This guide will help you deploy your Crystal Takarik application to Heroku.

## Prerequisites

1. [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed
2. Git repository initialized
3. Heroku account

## Deployment Steps

### 1. Login to Heroku
```bash
heroku login
```

### 2. Create a Heroku App
```bash
heroku create your-app-name
```

### 3. Set the Crystal Buildpack
```bash
heroku buildpacks:set https://github.com/crystal-lang/heroku-buildpack-crystal.git
```

### 4. Configure Environment Variables
```bash
# Set the Crystal environment
heroku config:set CRYSTAL_ENV=production

# Set the database URL (SQLite will be stored in /tmp on Heroku)
heroku config:set DATABASE_URL=sqlite3:///tmp/production.db
```

### 5. Deploy the Application
```bash
git add .
git commit -m "Prepare for Heroku deployment"
git push heroku main
```

### 6. Run Database Migrations
```bash
heroku run bin/migrate up
```

### 7. Open Your App
```bash
heroku open
```

## Important Notes

### SQLite Limitations on Heroku
- **Data Persistence**: SQLite data will be lost on dyno restarts (every 24 hours or on deployments)
- **File Storage**: SQLite files are stored in `/tmp` which is ephemeral
- **Scaling**: SQLite doesn't support multiple dynos

### For Production Use
Consider upgrading to PostgreSQL for production:
1. Add PostgreSQL addon: `heroku addons:create heroku-postgresql:mini`
2. Update dependencies in `shard.yml` to include `pg`
3. Modify database configuration in `app/example_app.cr`

## Troubleshooting

### Check Logs
```bash
heroku logs --tail
```

### Check App Status
```bash
heroku ps
```

### Restart App
```bash
heroku restart
```

### Run Commands on Heroku
```bash
heroku run crystal --version
heroku run ls -la bin/
```

## Files Created for Deployment

- `Procfile`: Defines how Heroku runs your app
- `.buildpacks`: Specifies the Crystal buildpack
- `bin/build`: Build script for compiling the Crystal app
- `app.json`: Heroku app configuration
- Updated `app/example_app.cr`: Added PORT environment variable support
- Updated `shard.yml`: Changed takarik dependency from local path to GitHub

## Local Testing

To test the production build locally:
```bash
# Build the app
bin/build

# Set environment variables
export PORT=3000
export DATABASE_URL=sqlite3:./db/production.db

# Run the compiled binary
bin/app
```