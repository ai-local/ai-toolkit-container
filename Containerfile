FROM quay.io/centos/centos:stream9
RUN dnf install -y git python3.12 python3.12-devel python3.12-pip libglvnd-glx gcc 

WORKDIR /
RUN git clone https://github.com/ostris/ai-toolkit.git
WORKDIR /ai-toolkit
RUN git submodule update --init --recursive
RUN pip3.12 install --no-cache-dir torch==2.6.0 torchvision==0.21.0 --index-url https://download.pytorch.org/whl/cu126
RUN pip3.12 install -r requirements.txt

# Note: when running container, you will need to specify an argument the path to the configuration file in the config directory, e.g. config/train_lora_flex_24gb.yaml
ENTRYPOINT ["python3.12", "run.py"]

# If running rootless Podman, enable the container_use_devices SELinux boolean:  sudo setsebool -P container_use_devices=true
# Build with:  podman build --device nvidia.com/gpu=all . -t ai-toolkit
# Run with:  podman run --device nvidia.com/gpu=all --name ai-toolkit -v ./config:/ai-toolkit/config:z -v ./input:/ai-toolkit/input:z -v ./output:/ai-toolkit/output:z -it ai-toolkit config/<config_file_name_here>
