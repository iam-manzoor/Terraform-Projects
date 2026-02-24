# Infrastructure Deployment for SpringApp

### Modules
- When are are writing the module we have to declare the empty variables in the `variables.tf` file also we have to define the `output.tf` file to expose the ID's of the created resources to other modules.
- Define varaibles in the root folder with values that needs to be passed on to the calling module (ex vpc)
- Use `output.tf` in the root folder to access the output of madules in the other modules.
