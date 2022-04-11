
## Setting up HAL

1. Add your application to [HAL](https://hal.zone/)
    - Fill out the dialog boxes with the relevant information:
        * Name: Name of your application (YOURNAME-app)
        * Organization: Organization (AWS Account) that you will be deploying to ( "IAC Training" for this class)
        * GitHub Repository: Link to the Git repo hosting your code and Dockerfile ( https://git.rockfin.com/YOURNAMNE/99999-YOURNAME-IAC )
        * Provider: AWS
        * Platform: Linux
        * Language: .NET Core
        * Click on `Show Advanced Options` and for **Multi-Solution Project**, put in `/workshop_materials/Docker/sample-container`. This will tell HAL to go into that subfolder once it hits your repo, since that is where our code, Dockerfile, and app-specific .hal9000.yml file lives. The root of your repo is where your IAC lives (Terraform).
        * Click Add Application

2. Add deployment configuration
    - Select **Deployment Settings** (on the left)
    - Select **Add Deployment Setting** 
    - Select your environment (`test-aws`)
    - Select `script` for **Deployment Type**.
    - Enter your application name for the **Name** (Or whatever you like, its up to you).
    - Enter the region for **Script Context** (us-east-2)
    - Select your AWS credentials for **Credentials** ( Choose `"IAC Training - NonProd - Deployment (AWS Role)"` for our example)
    - Click **Add Deployment**
    - Repeat above steps for beta and make another deployment target for **beta-aws**, entering the same information for every field.

3. Generate HAL Token for authentication from CircleCI
    - On the [hal settings page](https://hal.zone/settings) create a personal access token.
    - For Token Type, select "Builds and Non-prod deployments". Copy this key and keep it handy, you'll need it for CircleCI below.


## Setting up CI/CD

#### Configuring HAL

- Copy the **.hal9000.yml** and the **task.json** from the `CI_CD` directory (in the root of your repository) into your `workshop_materials/Docker/sample-container/` folder.
- In your **.hal9000.yml** file, update the following values:
  * `HAL_ECS_TASK` should reflect the name of your service in the ECS cluster. for example : `test-999999-YOURNAME`. Replace PLACEHOLDER with your name.

#### Configuring CircleCI

- Copy the **.circleci/** folder from that same `CI_CD` directory into the **root of your repository.**
- In your **.circleci/config.yml** file, replace the following values with your own:
  * `CIRCLE_TEST_ECR_URL` should reflect your ECR URL  : `418023852230.dkr.ecr.us-east-2.amazonaws.com/test-999999-YOURNAME`
  * `CIRCLE_BETA_ECR_URL` should reflect your ECR URL  : `418023852230.dkr.ecr.us-east-2.amazonaws.com/beta-999999-YOURNAME`

  * `HAL_APP_ID: 'XXXX'` (retrieve via the URL when you click your APP in HAL. For example, for https://hal9000.rockfin.com/applications/1881/status, the APP_ID is 1881 )
  * `HAL_TARGETS: "XXXX"` (retrieve by clicking on your deployment target, it's the **Deployment ID**. Need two, one for test and beta)

- Make sure to push the changes you just made back up to your repository!
- To setup your repo for CI/CD with CircleCI, first log into [CircleCI](https://circleci.foc.zone/)
  * Make sure you have CircleCI setup to point to your personal org/profile in the top left. Then, click `Add Projects` on the left hand side and click **Set Up Project** for your repo.
  <div style='float: center'>
  <!-- <img width="2000px" height="400px" src="Circle2_setup_project.png"></img> -->
  <img  src="Circle2_setup_project.png"></img>
</div>

   * On the next screen, click **Start building** at the very bottom. No need to click anything else.
   * On the next screen, click the gear icon in the top right.

  <div style='float: center'>
  <img src="Circle2_project_settings.png"></img>
  <!-- <img width="300px" height="200px" src="Circle2_project_settings.png"></img> -->
</div>

  * Go to the `Environment Variables` section and add a variable called `HAL_API_TOKEN` with the value of the token you just generated in the HAL step above. This allows CircleCI to talk to HAL.
  * Also, populate the IAM keys for the AWS account you are deploying to; this allows CircleCI to push docker images to ECR (these can be the same keys as were used the second day of class).
  * Make sure you have the following three variables set in your project `Environment Variables` as shown in the image below:
    * HAL_API_TOKEN
    * AWS_ACCESS_KEY_ID_NP
    * AWS_SECRET_ACCESS_KEY_NP

  <div style='float: center'>
  <img width="700px" height="270px" src="Circle2_envvars.png"></img>
</div>

## Testing your pipeline

Once you have everything configured, you should be able to make a change to your git repository, commit and push it to our enterprise github, and Circle will run the pipeline. The "test" environment image you created on the third day of class will be "overwritten" by the Docker image you yourself created on the first day of class. In other words, the sample "#DEVOPS" container should be replaced by your sample .NET container.

You can verify your pipeline is working by checking the following:
- Do you see your test URL update with the new image? 
- Does your beta environment update in the same way? (Note, you may need to take action for beta to update)
