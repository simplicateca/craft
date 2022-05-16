## About simplicate-web/craft

This is a highly opinionated, Docker-based `Craft CMS 3` project scaffolding / boilerplate.

It excels at rapidly prototyping modern website structures + page layouts.

We use it very early in our design & development process to increases collaboration and communication between team members and project stakeholders. We've found that it results in shorter timelines and better sites.

It comes pre-populated with:

 - a super-flexible matrix-based content editor
 - default sections for pages, news, and faqs
 - a variety of entry type templates
 - a nascent design system / component / pattern library
 - a default site module with web & console controllers
 - a secondary site to be used for documentation
 - [buddy.works](https://buddy.works/) deployment scripts for both staging & production

This project is a fork of the [nystudio107/craft](https://github.com/nystudio107/craft) package by Andrew Welch and contains most of it's core features.

  

## Installation

You will need Docker desktop for your platform installed to run the project in local development.

1. Run the following command to create a new project:

	`composer create-project simplicate-web/craft YOUR_PROJECT_NAME`

2. Change into the project directory and run this command to bring up the docker container for the first time:

	`make dev`

	This first launch will take several minutes to run while Docker does it's thing. Subsequent launches will be faster.


3. The webpack container will likely be the last to finish installing. Wait until you see this in the console:

```
webpack_1  | [nodemon] starting `webpack serve --config webpack.dev.js`
webpack_1  | <i> [webpack-dev-server] Project is running at:
webpack_1  | <i> [webpack-dev-server] Loopback: http://localhost:8080/
```

	And then visit the URL http://localhost:8000

  

## Admin Login

URL:  http://localhost:8000/admin

Login: `steve@simplicate.ca`

Password: `letmein`


## Accessing the Site Guide / Document frontend

From [Settings > System > Sites](http://localhost:8000/admin/settings/sites) click the "Site Guide" entry and enable the setting labelled:

    Make this the primary site

Craft will now display this site when you visit http://localhost:8000 

You can revert this by making any other site the primary.

## Important things to note

 - If you make a change to the contents of the `.env file` you will need to shutdown the docker container and restart it.

 - This project assumes you will be using an Amazon S3 or Digital Ocean Spaces type solution for storing your project assets in the cloud. You can disable this editing the `Asset Settings` or lean into it by editing the `CDN + S3 settings` section of the `.env` file to look something like:

```
    CDN_URL=https://[YOUR_BUCKET].[YOUR_REGION].digitaloceanspaces.com
    CDN_FOLDER=[asset/root/folder]
    S3_KEY=[...]
    S3_SECRET=[...]
    S3_ENDPOINT=https://[YOUR_REGION].digitaloceanspaces.com
    S3_BUCKET=[YOUR_BUCKET]
    S3_REGION=[YOUR_REGION]
```

 - If you attempt to export the Craft CMS database through the Admin > Utilities menu and receive an error message, run `make fixdb` and attempt the export again. This fixes a [weird mysql-server:8 bug](https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded) that only shows up when trying to export. This command only needs to be run once.