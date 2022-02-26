
## About simplicate-web/craft

This is a highly opinionated, Docker-based `Craft CMS 3` project scaffolding / boilerplate.

It excels at rapidly prototyping modern website structures + page layouts.

We use it very early in our design & development process to increases collaboration and communication between team members and project stakeholders. We've found that it leads to better sites being developed in shorter timelines.

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

	`docker-compose up`

	This first launch will take several minutes to run while Docker does it's thing. Subsequent launches will be faster.


3. To import the seed database, open a second console window in the project directory and run:

	`./scripts/docker_restore_db.sh db-seed/seed_db.sql`

	This command **must be run while the docker container launched in step 2 is still running**.

4. Once the original docker container has completed it's installation and you can see that it's accepting connections on `http://localhost:8000` close it down `CTRL+C` and bring it back up again with:

	`docker-compose up`

	This is necessary because the first attempt will have partially failed due to the seed database not being initially available.
	
5. This second launch of the docker container should work without issue. Once the console indicates that it's accepting connections, you can visit the site at: http://localhost:8000
  

## Admin Login

URL:  http://localhost:8000/admin

Login: `steve@simplicate.ca`

Password: `letmein`


## Accessing the Site Guide / Document frontend

From [Settings > System > Sites](http://localhost:8000/admin/settings/sites) click the "Site Guide" entry and enable the setting labelled:

    **Make this the primary site**

Craft will now display this site when you visit `http://localhost:8000`. 

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