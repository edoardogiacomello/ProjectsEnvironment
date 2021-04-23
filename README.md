# Tensorflow 2.0 GPU with JupyterLab docker environment

This repository is an helper for installing a docker environment that provides a
 tensorflow ecosystem through a JupyterLab interface.

## Prerequisites
- Linux distribution (Tested on Ubuntu and Arch Linux)
- Cuda Drivers for your host GPU
- docker
- nvidia-docker 

## What is included
- Tmux: Allows to manage multiple shells in the same docker container
- Standard Tools: vim, wget
- nodejs: jupyterlab extensions dependency
- Rclone: Allows file transfer from several cloud services, as Google Drive, Dropbox, etc.
- Python packages: requests, scikit-image, scikit-learn, pandas, seaborn, TF probability, SimpleITK (DICOM Imaging Library), jupyterlab, jupyter widgets 
- Fix for tensorflow docker not being able to hook to host cuda drivers

## Setup and First Run
- Clone this repository **inside the project folder that you wish to mount inside the environment**, e.g. ```~/MyProject/ProjectEnvironment/```
- Run ```build-latest.sh``` to build the latest stable release of Tensorflow. Other specific versions are available in different scripts.
- check that ```docker images``` returns the newly created image, e.g. ```edoardogiacomello/projectenv-latest``` if you ran ```build-latest.sh```
- choose a ```<name>``` for your new container and a ```<port>``` on your host to access jupyterlab (default is 8888)
- run ```first_run_gpu.py <name> <tag> [<port>]```. ``` <tag> ``` tag is the value shown by ```docker images``` (e.g. "latest")
- Now a new container has been created on your machine and you are into a new shell inside the docker environment. Your project folder (e.g. ``~/MyProject/``) has been mounted on the folder ``/tf`` inside the container. 
- check if your cuda installation and nvidia-docker is running correctly using ```nvidia-smi```
- You can detach from the container (leaving it running) using ``` ctrl + p, ctrl + q ```

## Typical Usage (todo on every reboot)
1) Check if your container is still running, with ``` docker ps ```
2) If it's not running, run it using ``` docker start <name> ```, using the name you chose in the setup phase.
3) Attach to the container with ```docker attach <name>```
4) (Optional) Open a TMUX interface using ```tmux```. This allows to open multiple windows inside the docker shell, as jupyterlab would prevent you from using the shell your run it from.
5) Run ```jupyter lab --ip=0.0.0.0 --allow-root```` to run the jupyter-lab interface. Take note of the token and keep it secret.
6) You can now access your jupyter interface from http://<your_ip>:<port>, e.g. http://localhost:8888, using the token provided.
7) You can detach safely leaving the container running using ```ctrl + p, ctrl + q```. If you need another shell window, you can use tmux commands, such ```Ctrl+b, Ctrl+c``` for a new shell, etc.

## Configuring File Cloud Access
You can configure Rclone to sync your Google Drive folders to the host machine, for example if you need to download models or datasets.
- You can open a new terminal directly from JupyterLab or creating a new tmux window from the container shell.
- use ```rclone config``` to configure the access to your account. Please refer to the [RClone Documentation](https://rclone.org/) for your use case. 

## Launching Tensorboard
Tensorboard can be launched inside the python notebook using
``` %load_ext tensorboard ```
``` %tensorboard --logdir <path-to-your-logs> ```

## Multiple Containers
If you need to run multiple containers you can launch the script ```first-run-gpu.py``` with another name and port.
**PLEASE NOTICE** that the script is made for mounting the **parent** folder with respect from where it is launched (See above example). 
You can just edit the script replacing the mounted path ```$PWD/../``` with one of your choice (must be absolute).
- Note on GPU Usage: Tensorflow by default allocates ALL available GPU memory to the first user. To avoid this, include this part of code just after the first tensorflow import in your code:

```
import tensorflow as tf
# Setting allow_growth for gpu
physical_devices = tf.config.experimental.list_physical_devices('GPU')
if len(physical_devices) > 0:
    tf.config.experimental.set_memory_growth(physical_devices[0], True)
else:
    print("No GPU found, model running on CPU")
```
