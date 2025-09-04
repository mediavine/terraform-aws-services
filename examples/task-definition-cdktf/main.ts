import { Construct } from 'constructs';
import { App, TerraformStack } from 'cdktf';
import { TaskDefinitionModule, TaskDefinitionModuleConfig } from "./.gen/modules/task-definition-module";

export class ModulesStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    const taskDefinitionConfig: TaskDefinitionModuleConfig = {
      containerDefinitions: {},
      sidecarDefinitions: {},
      taskCpu: 256,
      taskMemory: 512,
      taskDefinitionName: "task_definition_example4",
      awsRegion: "us-east-1",
    }
    new TaskDefinitionModule(this, 'task_definition_example4', taskDefinitionConfig);
  }
}

const app = new App()
new ModulesStack(app, 'modules-stack');
app.synth();
