#!bin/bash

# Sample Docker start script for the AppDynamics Machine Agent
# This is provided for illustration purposes only
 
# Enable using container ID as host ID when the pod has more than one containers
# MA_PROPERTIES+=" -Dappdynamics.docker.container.containerIdAsHostId.enabled=true"
# Start Machine Agent
${MACHINE_AGENT_HOME}/jre/bin/java ${MA_PROPERTIES} -jar ${MACHINE_AGENT_HOME}/machineagent.jar
