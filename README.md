This repository contains a Containerfile to build and run a container with the ai-toolkit (https://github.com/ostris/ai-toolkit), which can be used to generate finetuned diffusion models or LoRA's.

For use with an NVIDIA GPU with the NVIDIA container toolkit installed and configured for use with Podman.

Clone this repository: `git clone https://github.com/ai-local/ai-toolkit-container.git`

If running rootless Podman, enable the container_use_devices SELinux boolean:
`sudo setsebool -P container_use_devices=true`

Place input images within the `input/` directory

Place configuration file within the `config/` directory.  The Flex and Flux example configuration files are included from: https://github.com/ostris/ai-toolkit/tree/main/config/examples  If you are using an existing configuration file, make sure to set `folder_path: "/ai-toolkit/input"` within the config

Build container with: 
`podman build --device nvidia.com/gpu=all . -t ai-toolkit`

Run container with: 
`podman run --device nvidia.com/gpu=all --name ai-toolkit -v ./config:/ai-toolkit/config:z -v ./input:/ai-toolkit/input:z -v ./output:/ai-toolkit/output:z -it ai-toolkit config/<config_file_name_here>`

The output will be placed in the `output/` direcotry
