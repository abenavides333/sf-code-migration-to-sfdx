# SF Code Migration: Metadata Model Sources to Package Sources

Project to migrate Salesforce sources using Metadata format to Package Sources format to be used with SFDX and GitHub.

## TODO
- [x] Create the [.forceignore](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_exclude_source.htm) file in the root directory.
- [x] Create the [project_name].json file
- [ ] Convert Metadata sources to Package Sources for SFDX: `sfdx force:mdapi:convert --rootdir src`

## Documentation
### Salesforce CI/CD
- [Package Development Model](https://trailhead.salesforce.com/content/learn/modules/sfdx_dev_model)
- [Simplify Your Development Process with Continuous Integration](https://trailhead.salesforce.com/content/learn/trails/move-to-a-continuous-integration-development)
- [Develop an App with Salesforce CLI and Source Control](https://trailhead.salesforce.com/content/learn/projects/develop-app-with-salesforce-cli-and-source-control)
- [Convert the Metadata Source to Source Format](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_convert_mdapi.htm)

