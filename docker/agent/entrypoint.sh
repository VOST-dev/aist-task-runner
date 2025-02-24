#!/bin/bash
set -e

# Start Docker Daemon
sudo dockerd &

# Wait for Docker Daemon to start
until docker info > /dev/null 2>&1; do
    echo "Waiting for Docker daemon to start..."
    sleep 1
done

echo "Docker daemon started successfully."

# Start Jenkins Agent
if [ -n "$JENKINS_URL" ] && [ -n "$JENKINS_SECRET" ] && [ -n "$JENKINS_AGENT_NAME" ]; then
    echo "Starting Jenkins agent..."
    sudo java -jar /usr/share/jenkins/agent.jar -url ${JENKINS_URL} -secret ${JENKINS_SECRET} -name ${JENKINS_AGENT_NAME} -webSocket -workDir "/"
else
    echo "Jenkins agent is not configured. Waiting indefinitely..."
    tail -f /dev/null
fi