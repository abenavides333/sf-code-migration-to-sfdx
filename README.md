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

# SFDX development with GitHub

The following process describes the steps to follow to develop new features with the GitHub sources.

## TODO
1. \(Optional) Clone GitHub repository.
2. Create a new branch using the GitFlow branching model for Git (feature, hotfix, release).
3. Create a new scratch org to work on the development changes: `sfdx force:org:create --setdefaultusername --setalias [scratch-alias] --definitionfile config/project-scratch-def.json`
4. Push Metadata changes to the new scratch org: `sfdx force:source:push`
5. Once your changes are ready, Pull Metadata from the scratch org into your local machine: `sfdx force:source:pull`
6. Commit your changes and create a PR in GitHub to review and merge them.

# References
## Salesforce CI/CD
- [Package Development Model](https://trailhead.salesforce.com/content/learn/modules/sfdx_dev_model)
- [Simplify Your Development Process with Continuous Integration](https://trailhead.salesforce.com/content/learn/trails/move-to-a-continuous-integration-development)
- [Develop an App with Salesforce CLI and Source Control](https://trailhead.salesforce.com/content/learn/projects/develop-app-with-salesforce-cli-and-source-control)
- [Convert the Metadata Source to Source Format](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_convert_mdapi.htm)
- [Develop Against Any Org](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_develop_any_org.htm)
