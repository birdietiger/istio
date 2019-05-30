FROM ubuntu:14.04

# Install AppDynamics Machine Agent
ENV MACHINE_AGENT_HOME /opt/appdynamics/machine-agent
ADD machine-agent ${MACHINE_AGENT_HOME}

# Include start script to configure and start MA at runtime
ADD start-appdynamics.sh ${MACHINE_AGENT_HOME}
RUN chmod 744 ${MACHINE_AGENT_HOME}/start-appdynamics.sh

# Configure and Run AppDynamics Machine Agent
CMD "${MACHINE_AGENT_HOME}/start-appdynamics.sh"
