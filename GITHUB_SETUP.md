# GitHub Setup

## Push to GitHub

1. Check git status:
```bash
git status
```

Make sure `.env` and `database.sqlite` are ignored.

2. Stage and commit:
```bash
git add .
git commit -m "Initial commit"
```

3. Create repository on GitHub (don't initialize with README/license).

4. Add remote and push:
```bash
git remote add origin https://github.com/YOUR_USERNAME/nest-authentication-service.git
git branch -M main
git push -u origin main
```

## Verify

- `.env` and `database.sqlite` should not be visible in the repo
- README displays correctly

## Troubleshooting

**Remote already exists:**
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/nest-authentication-service.git
```
