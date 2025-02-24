FROM docker:dind

USER root

RUN apk add --no-cache \
    sudo \
    openrc \
    openssh \
    bash \
    curl \
    git \
    openjdk17-jdk \
    docker-cli

ARG JENKINS_AGENT_VERSION=3283.v92c105e0f819
RUN curl --create-dirs -o /usr/share/jenkins/agent.jar -SL https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_AGENT_VERSION}/remoting-${JENKINS_AGENT_VERSION}.jar

RUN addgroup -g 1000 jenkins && \
    adduser -D -G jenkins -u 1000 jenkins && \
    addgroup jenkins docker

RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins \
    && chmod 0440 /etc/sudoers.d/jenkins

ENV DOCKER_TLS_CERTDIR=""

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY matlab /bin/matlab
RUN chmod +x /bin/matlab

RUN git config --global user.email "jenkins@example.com"
RUN git config --global user.name "Jenkins"

USER jenkins

ENTRYPOINT ["/entrypoint.sh"]
