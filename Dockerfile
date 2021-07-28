FROM alpine:3.12

# Update pip and install required packages
RUN mkdir -p /root/.config/pip/
COPY pip/pip.conf /root/.config/pip/


RUN apk add --no-cache python3=3.8.10-r0 python3-dev=3.8.10-r0 py3-pip=20.1.1-r0 py3-wheel=0.34.2-r1 && \
    apk add --no-cache libffi-dev=3.3-r2 && \
    apk add --no-cache g++=9.3.0-r2 && \
    apk add --no-cache openssl-dev=1.1.1k-r0 && \
    apk add --no-cache openssl=1.1.1k-r0 && \
    apk add --no-cache groff==1.22.4-r1 && \
    apk add --no-cache curl && \
    apk add --no-cache cargo==1.44.0-r0

RUN pip install --no-cache-dir cryptography==3.3.1 && \
    pip install --no-cache-dir cffi==1.12.3 && \
    pip install --no-cache-dir pyopenssl==19.0.0 && \
    pip install --no-cache-dir boto3==1.15.10 && \
    pip install --no-cache-dir awscli==1.18.155

RUN VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl