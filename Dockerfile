ARG tfversion=latest-gpu-jupyter
FROM tensorflow/tensorflow:$tfversion
WORKDIR /tf
RUN apt-get update && apt-get install -y vim wget tmux rclone
# Installing nodejs required for jupyterlab plugins
RUN wget https://deb.nodesource.com/setup_14.x && chmod +x setup_14.x && bash setup_14.x && apt-get install -y nodejs 
# Installing required packages (some are already present in tensorflow distribution)
RUN pip install --upgrade requests scikit-image scikit-learn pandas seaborn tensorflow-probability SimpleITK jupyterlab
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
# Installing tensorboard for jupyterlab (Disabled 23/04/2021 as jupyter-tensorboard is not yet compatible with the current lab release)
# RUN pip install --upgrade jupyter-tensorboard && jupyter labextension install jupyterlab_tensorboard
# This is to fix a bug in tensorflow docker not finding nvidia drivers:
RUN ldconfig
CMD bash
