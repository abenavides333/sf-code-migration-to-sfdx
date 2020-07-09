# SF Code Migration: Metadata Model Sources to Package Sources

Project to migrate Salesforce sources using Metadata format to Package Sources format to be used with SFDX and GitHub.

## TODO
- [x] Create a Salesforce DX project in the sources' directory: `sfdx force:project:create -n my-prod-playground --template standard`
- [x] Update the [.forceignore](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_exclude_source.htm) file to ignore the profiles: `**profile`
- [x] Convert Metadata sources to Package Sources for SFDX: `sfdx force:mdapi:convert --rootdir src --outputdir force-app-tmp`
- [ ] Move old files with git to the new folder structure: `git mv src/applications/* force-app/main/default/applications/`

## Documentation
### Salesforce CI/CD
- [Package Development Model](https://trailhead.salesforce.com/content/learn/modules/sfdx_dev_model)
- [Simplify Your Development Process with Continuous Integration](https://trailhead.salesforce.com/content/learn/trails/move-to-a-continuous-integration-development)
- [Develop an App with Salesforce CLI and Source Control](https://trailhead.salesforce.com/content/learn/projects/develop-app-with-salesforce-cli-and-source-control)
- [Convert the Metadata Source to Source Format](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_convert_mdapi.htm)

