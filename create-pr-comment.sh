#!/bin/bash

pull_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
comment=$(cat <<EOF
This PR has triggered the signatures:

$(jq .eventName /tmp/tracee-action/signatures.json | sort | uniq )

Please review the Tracee [documentation](https://aquasecurity.github.io/tracee/v0.10/docs/detecting/rules/) to understand the signatures, and review the details of each trigger on the json below:

\`\`\`
$(cat /tmp/tracee-action/signatures.json)
\`\`\`
EOF
)
gh pr comment $pull_number -b "$comment"
