# SF Code Migration: Metadata Model Sources to Package Sources

Project to migrate Salesforce sources using Metadata format to Package Sources format to be used with SFDX and GitHub.

## TODO
- [x] Create a Salesforce DX project in the sources' directory: `sfdx force:project:create -n my-prod-playground --manifest --template standard`
- [x] Update the [.forceignore](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_exclude_source.htm) file to ignore the profiles: `**profile`
- [x] Convert Metadata sources to Package Sources for SFDX: `sfdx force:mdapi:convert --rootdir src --outputdir force-app-tmp`
- [x] One by one, delete the old directory in the **_src_** folder, and move the respective, new folder in **_force-app-tmp_** to **_force-app_**. Git will identify this operation as a move operation for the source files (`git mv`).
- [x] Replace the default package.xml file in the **_manifest_**  directory with the version in the **_src_** directory.
- [x] Delete the **_src_** directory.
- [x] Validate sources can be push to a Scratch Org.
- [x] Validate sources can be deploy to a Dev Org: `sfdx force:source:deploy --targetusername DevHub -x manifest/package.xml -l RunLocalTests`

### Git rename observations
- The following files won't keep the log history because they are changing structure in the files:
  - Static Resources
  - Objects
- Sharing Rules can break during renaming operation. To avoid this, move files in small batches. Some files could be marked as deleted and added again in the new path. 
- Some objects could keep the log history after the renaming operation.

# Setup SFDX with CI

The following process describes how to set up CI with GibHub and SFDX.

## TODO
- [x] Create a [Travis CI](https://travis-ci.org/) account.
- [x] Install the Travis CI client.
- [x] Create a Self-Signed SSL Certificate and Private Key (use a linux machine to avoid issues with the encryption process).
  - [x] Generate an RSA private key: `openssl genrsa -des3 -passout pass:[password] -out server.pass.key 2048`
  - [x] Create a key file from the file generated: `openssl rsa -passin pass:[password] -in server.pass.key -out server.key`
  - [x] Delete the file **_server.pass.key_**
  - [x] Request and generate the certificate: `openssl req -new -key server.key -out server.csr`. _No need to add challenge password (just press enter) neither optional company name (just enter ".")_. 
  - [x] Generate the SSL certificate: `openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt` 
- [x] Create the Connected App in SF (App Manager) for Travis CI.
  - [x] Enable Dev Hub in the Salesforce instance: Development -> Dev Hub -> Enable Dev Hub.
  - [x] Connect the SFDX to the Salesforce Dev Hub instance: `sfdx force:config:set defaultdevhubusername=[username@instance.com]`
  - [x] Create connected App:
    - [x] Select **Enable OAuth Settings**.
    - [x] Callback URL: http://localhost:1717/OauthRedirect.
    - [x] Select **Use digital signatures** and upload the _server.crt_ file here.
    - [x] Include the following scopes for OAuth:
      - [x] Access and manage your data (api)
      - [x] Perform requests on your behalf at any time (refresh_token, offline_access)
      - [x] Provide access to your data via the Web (web)
  - [x] Edit Policies for the Travis CI connected app.
    - [x] App Manager -> Select Travis CI -> Manage.
    - [x] Update the OAuth policies, Permitted Users to: **Admin approved users are pre-authorized**.
  - [x] Create a Permission Set to pre-authorize the Travis CI connected app.
  - [x] Update the Travis CI connected app to include the new permission set.
    - [x] App Manager -> Travis CI connected app -> Manage -> Manage Permission Sets.
    - [x] Select the new permission set and Save.
- [x] Add encrypted Travis server key to GitHub source files.
  - [x] Add a _.travis.yml_ file to the root directory in your repository to tell Travis CI what to do.
  - [x] If applies, remove the line that looks like this: `openssl aes-256-cbc -K $encrypted_0db5e9c4fee8_key -iv $encrypted_0db5e9c4fee8_iv -in assets/server.key.enc -out assets/server.key -d`
  - [x] Create an _assets_ directory and copy the _server.key_ file generated.
  - [x] Log in to Travis CI with your GitHub credentials: `travis login --org`
  - [x] Create an encrypted version for the _server.key_ file (use a linux machine to avoid issues with the encryption process): `travis encrypt-file assets/server.key assets/server.key.enc --add`
  - [x] Delete the _server.key_ file.
- [x] Create build file (YAML).
  - [x] Configure build for PR based on the target branch.
    - [x] Set _CONSUMERKEY_ and _USERNAME_ environment variables to be used in the commands in the YAML file.
    - [x] Create environment variables available only for the selected branch (create one per branch that needs a different value).
  - [x] Configure build for every commit into master and develop.
  
### Travis observations
- To skip building a commit (when no code changes are done, for example), use  the commit message to instruct Travis to ignore the commit: `[skip travis] README updated.`

# SFDX development with GitHub

The following process describes the steps to follow to develop new features with the GitHub sources.

## TODO
1. \(Optional) Clone GitHub repository.
2. Create a new branch using the GitFlow branching model for Git (feature, hotfix, release).
3. Create a new scratch org to work on the development changes: `sfdx force:org:create --setdefaultusername --setalias [scratch-alias] --definitionfile config/project-scratch-def.json`
4. Push Metadata changes to the new scratch org: `sfdx force:source:push`
5. Once your changes are ready, Pull Metadata from the scratch org into your local machine: `sfdx force:source:pull`
6. Set the package file with the components to be deployed (**_manifest/package-to-deploy.xml_**).
  - To retain generated metadata you can set the [SFDX_MDAPI_TEMP_DIR](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_develop_any_org.htm) environment variable and use the package.xml file generated when you use the force:source commands.
7. Commit your changes and create a PR in GitHub to review and merge them.

# References
## Salesforce CI/CD
- [Package Development Model](https://trailhead.salesforce.com/content/learn/modules/sfdx_dev_model)
- [Simplify Your Development Process with Continuous Integration](https://trailhead.salesforce.com/content/learn/trails/move-to-a-continuous-integration-development)
- [Develop an App with Salesforce CLI and Source Control](https://trailhead.salesforce.com/content/learn/projects/develop-app-with-salesforce-cli-and-source-control)
- [Convert the Metadata Source to Source Format](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_convert_mdapi.htm)
- [Develop Against Any Org](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_develop_any_org.htm)
- [Salesforce DX Developer Guide - Continuous Integration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ci.htm)

## Travis CI
- [Job Lifecycle](https://docs.travis-ci.com/user/job-lifecycle/)
- [Building Pull Requests](https://docs.travis-ci.com/user/pull-requests/)
- [Build Stages](https://docs.travis-ci.com/user/build-stages/)