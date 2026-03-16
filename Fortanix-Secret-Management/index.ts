import * as tl from "azure-pipelines-task-lib/task";
import * as https from "https";

async function run() {
  try {
    const FORTANIX_API_ENDPOINT = tl.getInput('FORTANIX_API_ENDPOINT', true)!;
    const FORTANIX_API_KEY = tl.getInput('FORTANIX_API_KEY', true)!;
    const FORTANIX_SECURITY_OBJECT_NAME = tl.getInput('FORTANIX_SECURITY_OBJECT_NAME', true)!;
    const FORTANIX_SECURITY_OBJECT = tl.getInput('FORTANIX_SECURITY_OBJECT', true)!;
    console.log("[INFO] Inputs has been received");
    const SOBJECT_PATH = "/crypto/v1/keys/export"
    fetchSecurityObject(FORTANIX_API_ENDPOINT, SOBJECT_PATH, FORTANIX_API_KEY, FORTANIX_SECURITY_OBJECT_NAME, FORTANIX_SECURITY_OBJECT);
  } catch (err: any) {
    tl.setResult(tl.TaskResult.Failed, err.message);
  }
}

function fetchSecurityObject(FORTANIX_API_ENDPOINT: string, SOBJECT_PATH: string, FORTANIX_API_KEY: string, NAME: string, FORTANIX_SECURITY_OBJECT: string) {
  const data = JSON.stringify({
    name: NAME
  });
  const options = {
    hostname: FORTANIX_API_ENDPOINT,
    path: SOBJECT_PATH,
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + FORTANIX_API_KEY
    },
  };
  const req = https.request(options, (res) => {
    let responseData = '';
    res.on('data', (chunk) => {
      responseData += chunk;
    });
    res.on('end', () => {
      let sobj_resp = JSON.parse(responseData)
      const sobj = Buffer.from(sobj_resp.value, "base64").toString("utf-8");
      // Set the FORTANIX_SECURITY_OBJECT
      tl.setVariable(FORTANIX_SECURITY_OBJECT, sobj, true);
      console.log(`[INFO] Fortanix Security object has been saved!`);
    });
    console.log('[INFO] Task executed successfully!');
  });
  req.on('error', (error) => {
    tl.error(error.message);
    tl.setResult(tl.TaskResult.Failed, error.message);
  });
  req.write(data);
  req.end();
}
run();
